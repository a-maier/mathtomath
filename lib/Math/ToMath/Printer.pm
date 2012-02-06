package Math::ToMath::Printer;

=head1 NAME

Math::ToMath::Printer - Convert expressions to strings

=cut

use 5.10.1;
use strict;
use warnings;
no warnings qw(recursion);

use constant Printer => __PACKAGE__;

use parent 'Exporter';
our @EXPORT_OK = qw(Printer);
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

use Data::Dump;
use Math::ToMath qw(:all);
use Math::ToMath::Operator qw(Operator);
use Math::ToMath::Symbols qw(Symbols);
use Scalar::Util qw(blessed);

=head1 SYNOPSIS

 use parent 'Math::ToMath::Printer';

=head1 DESCRIPTION

Math::ToMath::Printer provides methods to convert L<Math::ToMath::Expression> 
objects to strings. It is intended to be used as a base class for printers 
converting to specific formats. Therefore this manual contains rather 
technical information; if you don't plan to write your own printer class 
the manuals of more specific printers like L<Math::ToMath::Printer::Generic>
might be more helpful.

=over 2

=cut

=item B<new>

Construct a new object. Calls init for initialisation. No need to overwrite 
this in derived classes.

=cut

sub new{
    my $class=shift;
    my $self={};

    bless($self,$class);
    $self->init(@_);
    return $self;
}

=item B<init>

Perform initialisation of a newly created object. The following has to be done:

=back

=over 4

=item * Determine and set the output format according to the object's class.

=item * Define all operators that are known to this format.

=item * Read file that determines how to translate special symbols.

=item * Set default options.

=item * (Optional) define default rules and methods for treating (very) special expressions.

=back

=over 2

=cut


sub init{
    my $self=shift;

    $self->{format}= blessed($self);
    #why not just s/^.*::// ?
    $self->{format} =~ s/^(?:[^:]+::)+//; # Math::ToMath::Printer::Foo => Foo

#operator properties:
# which operators exist, which token(s) are to be used for output, precedence, pre/in/postfix...
# brackets should also be included here to indicate that they are legal
    %{$self->{operators}}=(
	';'	=> Operator->new(name => ';',prec => 0,assoc =>'left',pos => 'postfix'),
	','	=> Operator->new(name => ',',prec => 100,assoc =>'left'),
	'='	=> Operator->new(name => '=',prec => 200,assoc =>'right'),
	'=='	=> Operator->new(name => '==',prec => 300,assoc =>'right'),
	'!='	=> Operator->new(name => '!=',prec => 300,assoc =>'right'),
	'<'	=> Operator->new(name => '<',prec => 300,assoc =>'right'),
	'<='	=> Operator->new(name => '<=',prec => 300,assoc =>'right'),
	'>'	=> Operator->new(name => '>',prec => 300,assoc =>'right'),
	'>='	=> Operator->new(name => '>=',prec => 300,assoc =>'right'),
	'+'	=> Operator->new(name => '+',prec => 400,assoc =>'left'),
	'-'	=> Operator->new(name => '-',prec => 400,assoc =>'left'),
	'*'	=> Operator->new(name => '*',prec => 500,assoc =>'left'),
	'/'	=> Operator->new(name => '/',prec => 500,assoc =>'left'),
	'u-'	=> Operator->new(name => '-',prec => 550,pos => 'prefix'),
	'^'	=> Operator->new(name => '^',prec => 600,assoc =>'left'),
	'.'	=> Operator->new(name => '.',prec => 700),
	'?'	=> Operator->new(name => '?',prec => 800,pos => 'postfix'),
	'??'	=> Operator->new(name => '??',prec => 800,pos => 'postfix'),
	'???'	=> Operator->new(name => '???',prec => 800,pos => 'postfix'),
	'['	=> Operator->new(name => '['),
	']'	=> Operator->new(name => ']'),
	'('	=> Operator->new(name => '('),
	')'	=> Operator->new(name => ')'),
	'{'	=> Operator->new(name => '{'),
	'}'	=> Operator->new(name => '}'),
	#sometimes we need a comparison with the last operator
	# when there is no such operator, we use 0
	0       => Operator->new(name => '',prec => 0),
	);

#special output for certain functions
# e.g. for Latex we are supposed to put '**log**' => '\log' here
    %{$self->{symbols}}=reverse $self->get_config(Symbols->get_symbol_file_for_class($self->{format}));

    %{$self->{options}}=(
	line_length => ''
	);
    for my $scope ("local","global"){
	%{$self->{rules}->{$scope}}=();
    }
#special output functions for single objects
    %{$self->{specials}}=();

}

=item B<options>

If there are arguments, set options according to them. 
Return a hash with the options and their values.

=cut


#set or read options
sub options{
    my $self=shift;
    %{$self->{options}}=@_ if @_;
    return %{$self->{options}};
}

=item B<local_rules>

If there are arguments, set local rules according to them. 
Return a hash with the local rules and their values. 
Rules have the form LHS => RHS and act like s/LHS/RHS/;
Local rules are applied separately to each node of the expression tree.

=cut

sub local_rules{
    my $self=shift;
    %{$self->{rules}->{local}}=@_ if @_;
    map {$_=qr/$_/} keys %{$self->{rules}->{local}};
    return %{$self->{rules}->{local}};
}

=item B<global_rules>

If there are arguments, set global rules according to them. 
Return a hash with the global rules and their values. 
Rules have the form LHS => RHS and act like s/LHS/RHS/;
Global rules are applied to the (almost final) output string. Only line 
breaks are inserted afterwards, and only if a corresponding option is set

=cut

sub global_rules{
    my $self=shift;
    %{$self->{rules}->{global}}=@_ if @_;
    map {$_=qr/$_/} keys %{$self->{rules}->{global}};
    return %{$self->{rules}->{global}};
}

=item B<operator_by_name>

Small convenience routine which returns the Math::ToMath::operator definition 
for the operator with the given name. If two arguments are given, redefines
the operator with the name corresponding to the first argument.

=cut

sub operator_by_name{
    my $self=shift;
    my $op_name=shift;
    $self->{operators}->{$op_name}= $_[0] if(defined $_[0]);
    return $self->{operators}->{$op_name}
}

=item B<symbol_by_name>

For a given special symbol gets the string representation of this symbol in 
the current format. In the two-argument form sets the representation to the 
second argument.

=cut

sub symbol_by_name{
    my $self=shift;
    my $sym_name=shift;
    $self->{symbols}->{$sym_name}= $_[0] if(defined $_[0]);
    return $self->{symbols}->{$sym_name}
}

=item B<special_by_name>

Takes the name of an object. If there is a special routine to treat this 
object, a reference to it is returned. If two arguments are given the routine
given as the second argument is set to treat the object with the name given by
the first argument.

=cut


sub special_by_name{
    my $self=shift;
    my $sym_name=shift;
    $self->{specials}->{$sym_name}= $_[0] if(defined $_[0]);
    return $self->{specials}->{$sym_name}
}

=item B<to_string>

Main method. Takes an expression and returns the corresponding string, 
but without applying global rules nor inserting line breaks. The current 
node of the expression is checked and a corresponding subroutine is called.

=cut


sub to_string{
    my $self= shift;
    
    my $tree=shift;
    # say "to_string";
    #dd($tree);
    # general information collected while parsing the tree
    my %tree_info=@_;
    # last operator
    # if the current operator has a lower precedence, we need a bracket
    defined $tree_info{last_op} or $tree_info{last_op}=0;
    #if the current operator equals the old one, depending on the 
    #associativity we might need a bracket
    # for this we need to know whether we are looking at the left argument or at the right one
    defined $tree_info{arg_num} or $tree_info{arg_num}='';
    my $string;
    #special treatment for some operators/functions/whatever
    if (defined $self->special_by_name($tree->name)){
	($string,%tree_info)=&{$self->special_by_name($tree->name)}($self,$tree->name,$tree->args,%tree_info);
	return wantarray?($string,%tree_info):$string;
    }

    given($tree->is){
	when('number') {($string,%tree_info) = $self->number_to_string($tree->name,%tree_info)}
	when('string') {($string,%tree_info) = $self->string_to_string($tree->name,%tree_info);}
	when('symbol') {
	    my $sym=$tree->name;
	    if($sym =~ /^\*\*/ and $sym =~ /\*\*$/){
		my $tmp=$sym;
		$tmp =~ s/(^\*\*|\*\*$)//g;
		$sym = $self->symbol_by_name($tmp) if defined $self->symbol_by_name($tmp);
	    }
	    ($string,%tree_info)= $self->symbol_to_string($sym,%tree_info)
	}
	when('operator') {
	    #check whether the operator exists in this format
	    defined $self->operator_by_name($tree->name) 
	    or die "Operator '".$tree->name."' does not exist in format $self->{format}";
	    ($string,%tree_info) =$self->operator_to_string($tree->name,$tree->args,%tree_info);
	}
	when('bracket') {
	    for my $i (0..1){
		defined $self->operator_by_name($tree->name->[$i]) 
		or die "Bracket '".$tree->name->[$i]."'does not exist in format $self->{format}";
	    }
	    my $brackets;
	    #check whether the brackets are legal tokens in this format
	    @$brackets=map {$self->operator_by_name($_)->name} @{$tree->name};
	    ($string,%tree_info) = $self->bracket_to_string($brackets,$tree->args,%tree_info)
	}
	default {die "Don't know how to format a '$tree->{is}' as a string in format $self->{format}"}
    }
    #say $string;
    return wantarray?($string,%tree_info):$string;
}

=item B<symbol_to_string>

Takes a symbol and returns the corresponding string in the current format. 
There are two possibilities if the symbol's name is not valid in the 
current format. If the I<strict> option set an invalid symbol name should be 
a fatal error. If this option is not set symbol_to_string tries to construct 
a similar, but valid symbol name (e.g. by removing illegal characters)

=cut


# TODO: or die on error if strict is set
sub symbol_to_string{
    my $self=shift;
    my $_=$_[0];
    $_=$self->replace_local($_);
    #delete illegal tokens
    s/^[[:^alpha:]]+//;
    s/\W+//g;
    $_ or die "Symbol '$_[0]' can't be converted into the format $self->{format}, because it does not contain any legal tokens";
    return ($_);
}

=item B<number_to_string>

Takes a number and returns the corresponding string in the current format. 

=cut

sub number_to_string{
    my $self=shift;
    my $_=$_[0];
    $_=$self->replace_local($_);
    s/[^\d\.]//g;
    /^(\d+|\d*\.\d+|\d+\.\d*)$/ 
	or die "Number '$_[0]' can't be converted into the format $self->{format}";
    $_=$1;
    if(/^\./){$_='0'.$_}
    elsif(/\.$/){$_.='0'}
    return ($_);
}

=item B<string_to_string>

Takes a string (in the sense of Math::ToMath::Expression) and returns the 
corresponding string (in the sense of perl) in the current format.

=cut

sub string_to_string{
    my $self=shift;
    my $_=$self->replace_local($_[0]);
    return ("\"$_\"");
}


=item B<operator_to_string>

Takes an operator and its operands and returns the corresponding string in 
the current format. Depending on the type of the operator 
(prefix, postfix, infix) an appropriate helper routine is called. Also takes
care of additional brackets that might have to be inserted depending on
operator precedence or associativity.

=cut

sub operator_to_string{
    my $self=shift;
    my $op_name=shift;
    my $operator=$self->operator_by_name($op_name);
    my $args=shift;
    my %tree_info=@_;
    my $last_op=$tree_info{last_op};
    my $arg_num=$tree_info{arg_num};
    my $string;
    $tree_info{last_op}=$op_name;
    if(scalar @$args == 1){
	#there is one argument, so it has to be either a postfix or a prefix operator
	if($operator->pos eq 'prefix'){
	    ($string,%tree_info) = $self->prefix_operator_to_string($operator,$args,%tree_info);
	}
	elsif($operator->pos eq 'postfix'){
	    ($string,%tree_info) = $self->postfix_operator_to_string($operator,$args,%tree_info);
	}
	else{
	    die "Failed to format ".$operator->pos." operator '".$operator->name."' with one argument"
	} 
    }
    else{
	#more than one argument, has to be an infix operator
	($string,%tree_info) = $self->infix_operator_to_string($operator,$args,%tree_info);
    }
    #check precedence
    my $last_prec=$self->operator_by_name($last_op)->prec;
    
    if ($last_prec > $operator->prec) {$string='('.$string.')'}
    #check associativity - only important if the previous operator equals the current one
    elsif($op_name eq $last_op){
	if(! defined $operator->assoc){
	    die "Subsequent occurence of non-associative operator ".$operator->name;
	}
	elsif(
	    (($operator->assoc eq 'right') and ($arg_num eq 'left'))
	    or (($operator->assoc eq 'left') and ($arg_num eq 'right'))
	    ){#the associativity has changed compared to the input format -> we need a bracket
	    $string='('.$string.')';
	}
    }
    return ($string,%tree_info)
}

=item B<prefix_operator_to_string>

Takes a prefix operator and its operand and returns the corresponding string 
in the current format. The operand is converted using B<to_string>.

=cut


sub prefix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    $tree_info{arg_num}='right';
    ($string,%tree_info)=$self->to_string($$args[0],%tree_info);
    $string=$self->replace_local($operator->name).$string;
    return ($string,%tree_info);
}

=item B<postfix_operator_to_string>

Takes a postfix operator and its operand and returns the corresponding string 
in the current format. The operand is converted using B<to_string>.

=cut


sub postfix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    $tree_info{arg_num}='left';
    ($string,%tree_info)=$self->to_string($$args[0],%tree_info);
    $string.=$self->replace_local($operator->name);
    return ($string,%tree_info);
}

=item B<infix_operator_to_string>

Takes an infix operator and its operands and returns the corresponding string 
in the current format. The operands are converted using B<to_string>.

=cut

sub infix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my %tree_info=@_;
    my (%tree_info_left,%tree_info_right);
    my ($string_left,$string_right);
    #left argument
    $tree_info{arg_num}='left';
    ($string_left,%tree_info_left)= $self->to_string($$args[0],%tree_info);
    $tree_info{arg_num}='right';
    ($string_right,%tree_info_right)= $self->to_string($$args[1],%tree_info);
    %tree_info=$self->merge_info(\%tree_info_left,\%tree_info_right);
    return (
	$string_left.$self->replace_local($operator->name).$string_right
	,%tree_info
	)
#join($operator->name, map {$self->to_string($_,$operator->prec)} @$args);
}

=item B<bracket_to_string>

Takes a bracket and its contents and returns the corresponding string 
in the current format. Note that functions are considered brackets by
L<Math::ToMath::Expression> and hence are also treated by this method.

=cut


sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    scalar @$args<3 or die "Too many arguments for bracket";
    $tree_info{last_op}=0;
    if(@$args>1){
	# we have a function with the function name being $$args[0]
	my (%tree_info_fun,%tree_info_arg);
	my ($string_fun,$string_arg);
	($string_fun,%tree_info_fun)=$self->to_string($$args[0],%tree_info);
	($string_arg,%tree_info_arg)=$self->to_string($$args[1],%tree_info);
	%tree_info=$self->merge_info(\%tree_info_fun,\%tree_info_arg);
	$string=
	    $string_fun
	    .$self->replace_local($brackets->[0])
	    .$string_arg
	    .$self->replace_local($brackets->[1])
	    ;
    }
    else{
	#usual bracket
	($string,%tree_info)=$self->to_string($$args[0],%tree_info);
	$string=
	    $self->replace_local($brackets->[0])
	    .$string
	    .$self->replace_local($brackets->[1])
	    ;
    }
    return ($string,%tree_info)
}

=item B<replace_local>

Applies the local replacement rules to its argument. The argument should be 
the string corresponding to a single node in the L<Math::ToMath::Expression>
expression tree. Each rule has the form LHS => RHS and is applied as
s/LHS/RHS/

=cut

sub replace_local{
    my $self=shift;
    my $_=shift;
    for my $pattern (keys %{$self->{rules}->{local}}){
	#TODO: replace by something reasonable
	eval("s/$pattern/$self->{rules}->{local}->{$pattern}/");
    }
    return $_
}

=item B<get_config>

Reads a configuration file. Largely obsolete, but still used to read the symbol
file during initialisation.

=cut

SCOPE: {
    my %config_cache;
    sub get_config{
	my $self=shift;
	my $file=shift;
	return @{ $config_cache{$file} } if exists $config_cache{$file};
	open(my $in, '<', $file) or die "Failed to open $file for reading: $!";
	my $contents='';
	while(<$in>){
	    #ignore whitespace and comments
	    s/(\s+|\#.*)//g;
	    $contents.=$_;
	}
	close $in;
	my @tmp=split(/=>|,|;/,$contents);
	$config_cache{$file} = \@tmp;
	return  @tmp;
    }
}

=item B<merge_info>

Some formats need to keep additional information while processing the 
expression tree. This method determines how to merge information coming
form different branches.

=cut

sub merge_info{
}

=item B<format>

Returns the format into which expressions are converted.

=cut

sub format{
    my $self=shift;
    return $self->{format};
}


=item B<convert>

Takes a L<Math::ToMath::Expression> object and converts it into a string in
the current format using the B<to_string> method. Then applies the global rules
and, depending on options, inserts line breaks where appropriate.

=cut

sub convert{
    my $self=shift;
    my $expression=shift;
    my $_=$self->to_string($expression);
    #final formatting for output string
    for my $pattern (keys %{$self->{rules}->{global}}){
	eval("s/$pattern/$self->{rules}->{global}->{$pattern}/g");
    }
    $_=$self->insert_line_breaks($_) if ($self->{options}->{line_length});
    return $_;
}

=item B<insert_line_breaks>

Takes a string and inserts line breaks after a certain number of characters. 
How this is handled exactly is up to the format class.

=cut

#insert line breaks after a certain number of characters
sub insert_line_breaks{
    my $self=shift;
    my $_=shift;
    my $max_length=$self->{options}->{line_length}-1;
    # FIXME: See Text::Wrap! It's part of core perl.
    s/(.{$max_length})/$1\\\n/g;
    return $_;
}

=back

=cut

1;

=head1 SEE ALSO

L<Math::ToMath::Expression>

L<Math::ToMath::Printer::Generic>

other Math::ToMath::Printer::* modules

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
