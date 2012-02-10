package Math::ToMath::Printer::Latex;

=head1 NAME

Math::ToMath::Printer::Latex - Convert expressions to strings in LaTeX format

=cut

use 5.10.1;
use strict;
use warnings;
no warnings qw(recursion);
use Data::Dump;
use Math::ToMath::Operator qw(Operator);

use parent 'Math::ToMath::Printer';

=head1 SYNOPSIS

 use Math::ToMath::Printer::Latex;

 #create a new object
 my $printer=Math::ToMath::Printer::Latex->new();

 #get format
 my $format=$printer->format();

 #convert an expression to a string
 my $expr_str=$printer->convert($expression_tree);

 #set/get conversion options
 my $printer_options = $printer->options(
    line_length => 42
 );

 #set/get local transformation rules
 my $local_printer_rules = $printer->local_rules(
    '^=$' => ':='
 );

 #set/get global transformation rules
 my $global_printer_rules = $printer->global_rules(
    "\(6\*7\)" => 42
 );


=head1 DESCRIPTION

Printer objects of this class can be used to convert 
L<Math::ToMath::Expression> objects into strings that can be fed into LaTeX.

=over 2

=item B<new>

Create a new printer object.

=item B<convert>

Converts an expression object into a string compatible to LaTeX.

=item B<options>

Set options for the conversion to strings. See the L</"OPTIONS"> section of
this manual for a complete list.

=item B<local_rules>

Set local transformation rules. Transformation rules have the form LHS => RHS
and act like regular expression substitution, i.e. s/LHS/RHS/. Local rules 
are applied separately to each subexpression. This allows a limited form of
"semantic" replacements as shown in the example.

=item B<global_rules>

Set global transformation rules. Transformation rules have the form LHS => RHS
and act like regular expression substitution, i.e. s/LHS/RHS/. Global rules are
applied by the B<convert> method to the whole resulting string. If the 
I<line_length> option is set line breaks will be inserted B<after> global 
rules are applied.

=back

=head2 OPTIONS

=over 2

=item B<symbols_as_text>

If set to non-zero, all variable names containing more than one
character are converted to C<\text{>I<name>C<}>.

By default this option is turned off.

=item B<list_format>

Determines the output format for lists. Supported formats are 
C<tabular, array> and the various matrix environments defined by the amsmath 
LaTeX package. 

The default is zero, which means that lists have the form
C<\{...\}>.

=item B<bracket_scaling>

Changes how brackets are scaled. If this option is set to a zero value 
brackets are left as they are. C<auto> means that brackets are preceded by 
C<\left> and C<\right>. C<incremental> is most useful for nested brackets: the 
innermost bracket pair is in general left unchanged, whereas the following
levels are enlarged with C<\big> and the like. Up to five levels are supported.
Brackets around ratio will always be at least C<\bigg>.

The default value for this option is C<incremental>.

=item B<line_length>

The minimal number of characters in a line. When a line is long enough a
line break will be inserted directly before the next match of the
regular expression given by B<line_break_at>. If ratios appear in the
line, only the number of characters in either the numerator or the
denominator is counted, depending on which is longer. For matrices or
tables only the longest row counts. Subscript or superscript characters
are usually not counted as whole characters (see B<subscript_size>).

A zero value means that no line breaks will be inserted. The default value is 
40.

=item B<line_break_at>

The value should be a regular expression stating before which characters line
breaks may be inserted as soon as the number of characters given by the 
B<line_length> option is exceeded. 

The default value is C<qr/[\+\-]/>, which means
that line breaks may be inserted before plus and minus signs.

=item B<line_break>

Defines how a line break looks like.

By default a line break is two backslashes followed by a newline and the 
alignment character C<&>.

=item B<subscript_size>

How much subscript/superscript characters count. A value of 0.5
e.g. means that two subscript characters count as much as one "usual"
character towards the target B<line_length>.

=item B<break_ratio>

Unbalanced ratios X/Y will be rewritten to 1/Y*(X) if two conditions are
fulfilled. First, X has to contain at least one plus or minus
sign. Second, X has to be longer than Y by at least a factor given by
the value of B<break_ratio>. If the value is zero, nothing will be done.

The default is to break up ratios where the numerator is longer by at 
least a factor of 5.

=back

=cut

#minimal size of brackets around fraction
#if the option bracket_scaling=incremental is set
my $frac_bracket_size=2;
my @bracket_size_modifier=('','\big','\Big','\bigg','\Bigg');

sub init{
    my $self=shift;
    $self->SUPER::init(@_);
    %{$self->{specials}}=(
	'/' => \&ratio_as_frac,
	'*' => \&product,
	'^' => \&power,
	',' => \&sequence
	);
    $self->{operators}->{'&'}= Operator->new(name => '&',prec => 100,assoc =>'left');
    $self->{operators}->{'\\'}= Operator->new(name => "\\\\\n",prec => 100,assoc =>'left');
    $self->{operators}->{'{'}= Operator->new(name => '\{');
    $self->{operators}->{'}'}= Operator->new(name => '\}');

    $self->{options}={
	symbols_as_text => "0",
	list_format => "",
	bracket_scaling => "incremental",
	subscript_size => "0.6",
	line_length => "40",
	line_break => "\\\\\n&",
	line_break_at => qr/[\+\-]/,
	break_ratio => "5"
    }
}

sub number_to_string{
    my $self=shift;
    my $string=shift;
    my %tree_info=@_;
    return ($self->replace_local($string),%tree_info);
}

sub symbol_to_string{
    my $self=shift;
    my $string=shift;
    my %tree_info=@_;
    if ($self->{options}->{symbols_as_text}
	&& (length $string > 1)
	){
	$string='\text{'.$string.'}';
    }
    return ($self->replace_local($string),%tree_info);
}

sub string_to_string{
    my $self=shift;
    my $string=shift;
    my %tree_info=@_;
    return ($self->replace_local($string),%tree_info);
}

sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string_fun='';
    my %tree_info_fun=();
    my $string_arg;
    my $string;
    $tree_info{last_op}=0;
    if(defined $args and scalar @$args > 1){
	my $function=shift @$args;
        #special latex functions
	given($function->name){
	    when ('**subscript**'){return $self->subscript($args,%tree_info)}
	    when ('**sqrt**'){return $self->sqrt($args,%tree_info)}
	}
	($string_fun,%tree_info_fun)=$self->to_string($function,%tree_info);
    }

    #check for non-standard list format
    if( 
	$$brackets[0] eq '\{'
	and $$brackets[1] eq '\}'
	and defined $self->{options}->{list_format}
	and $self->{options}->{list_format}
	){
	#format this list in a non-standard way (e.g. as a matrix)
	#print 'bracket_to_string: ';dd %tree_info;
	return $self->matrix_to_string($$args[0],%tree_info)
    }
    
    ($string_arg,%tree_info)=$self->to_string($$args[0],%tree_info);

    #treat bracket scaling
    if(defined $self->{options}->{bracket_scaling}){
	given($self->{options}->{bracket_scaling}){
	    when(/^auto/){$$brackets[0]='\left'.$$brackets[0];$$brackets[1]='\right'.$$brackets[1]}
	    #incremental bracket scaling: 
	    # make this bracket one unit larger than the largest bracket in the argument
	    when(/^inc/){
		if(defined $tree_info{last_bracket_size}){
		    #there are brackets in the argument
		    ++$tree_info{last_bracket_size};
		    map {$_=$self->bracket_size($tree_info{last_bracket_size},$_)} @$brackets;
		}
		else{
		    #no previous bracket
		    $tree_info{last_bracket_size}=0;
		}
	    }
	}
    }
    $string=$string_fun.$self->replace_local($$brackets[0]).$string_arg.$self->replace_local($$brackets[1]);
    %tree_info=$self->merge_info(\%tree_info_fun,\%tree_info);
    return ($string,%tree_info);
}


#format ratios as \frac{}{}
sub ratio_as_frac{
    my $self=shift;
    shift;
    my $args=shift;
    my %tree_info=@_;
    my (%tree_info_num,%tree_info_den);
    my ($num,$den);
    $num=$self->fall_through_bracket($$args[0]);
    #-x/y should be formatted as -\frac{x}{y}, not \frac{-x}{y}
    my $uminus=0;
    if($num->name eq 'u-'){
	$num=$num->args->[0];
	$uminus=1;
    }
    ($num,%tree_info_num)=$self->to_string($num);
    ($den,%tree_info_den)=$self->to_string($self->fall_through_bracket($$args[1]));
    %tree_info=$self->merge_info(\%tree_info_num,\%tree_info_den);
    if(!defined $tree_info{last_bracket_size} or $tree_info{last_bracket_size}<$frac_bracket_size){
	$tree_info{last_bracket_size}=$frac_bracket_size
    }
    my $string=$self->replace_local('\frac')."{$num}{$den}";
    if($uminus){$string='-'.$string}
    return ($string,%tree_info);
}

#format products
sub product{
    my $self=shift;
    shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    my ($string_left,$string_right);
    my (%tree_info_left,%tree_info_right);
    $tree_info{last_op}='*';
    ($string_left,%tree_info_left)=$self->to_string($$args[0],%tree_info);
    ($string_right,%tree_info_right)=$self->to_string($$args[1],%tree_info);
    %tree_info=$self->merge_info(\%tree_info_left,\%tree_info_right);
    
    #TODO: it would be wise to use operator_to_string here, but first these operators have to be defined
    #TODO: the following check is not sufficient
    $string=$string_left
	.(
	($$args[0]->is eq 'number' and $$args[1]->is eq 'number')
	?$self->replace_local('\cdot')
	:$self->replace_local('\*')
	)
	.$string_right
	;
    return ($string,%tree_info)
}

#format power (= remove superfluous brackets)
#atm ignore brackets in the exponent for incremental bracket size
sub power{
    my $self=shift;
    my $op=shift;
    my $args=shift;
    my %tree_info=@_;
    #dd $$args[0];
    my $filtered_exponent=$self->fall_through_bracket($$args[1]);
    #this is a hack: by giving a *wrong* last operator,
    # we make sure that the exponent does not introduce a superfluous bracket
    # due to operator precedence or associativity
    $tree_info{last_op}='0';
    my $arg_str=$self->to_string($filtered_exponent,%tree_info);
    $tree_info{last_op}='^';
    my $base_str;
    ($base_str,%tree_info)=$self->to_string($$args[0],%tree_info);
    my $string= 
	$base_str
	.$self->replace_local('^')
	.((length $arg_str==1)?$arg_str:"{$arg_str}")
	;
    return ($string,%tree_info);
}


#format subscripts
#atm ignore brackets in the subscript for incremental bracket size
sub subscript{
    my $self=shift;
    my $args=shift;
    my %tree_info=@_;
    # $args is a sequence, we have to go one level deeper
    my $real_args=$$args[0]->args;
    my $subscript=$self->to_string($$real_args[1],%tree_info);
    my $string;
    ($string,%tree_info)=$self->to_string($$real_args[0],%tree_info);
    $string.=
	$self->replace_local('_')
	.((length $subscript ==1)?"$subscript":"{$subscript}")
	;
    return ($string,%tree_info)
}

#format roots
sub sqrt{
    my $self=shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    ($string,%tree_info)=$self->to_string($$args[0],%tree_info);
    die "Don't know how to format **sqrt** with more than one argument in Latex format" if scalar @$args >1;
    #TODO: roots with sequence as argument
    return ($self->replace_local('\sqrt').'{'.$string.'}',%tree_info);
}

#format matrix
sub matrix_to_string{
    my $self=shift;
    my $arg=shift;
    my %tree_info=@_;
    my $list_format=$self->{options}->{list_format};
    my $string='';
    #change current list level 
    #0/undef: not inside a list
    #odd value: 'outer' list; items separated by "\\\\\n"
    #even value: 'inner' list; items separated by '&'
    if(defined $tree_info{list_level}){
	++$tree_info{list_level}
    }
    else{$tree_info{list_level}=1}
    my $list_level=$tree_info{list_level};
    #print 'matrix_to_string: ';dd %tree_info;

    ($string,%tree_info)=$self->to_string($arg,%tree_info) if $arg;
    
    if($list_level % 2){
	my ($begin_string,$end_string);
	#outer list: we need an environment
	($begin_string,$end_string)=("\\begin{$list_format}","\\end{$list_format}");
	#array and tabular environments need the number of columns
	defined $tree_info{num_columns} or $tree_info{num_columns}=1;
	$begin_string.='{'.('c' x $tree_info{num_columns}).'}' 
	    if $list_format =~ /^(array|tabular)$/;
	$string="$begin_string\n$string\n$end_string";
	$string='\left('.$string.'\right)' if $list_format eq 'array';
	$string="\n$string\n";
    }
    #clean up
    delete $tree_info{num_columns} if $list_level % 2;
    --$tree_info{list_level};
    return ($string,%tree_info);
}

#format sequences ... like usual or like matrix entries
#in the latter case, use either "\\\\\n" or '&' as separators
# and return number of columns
sub sequence{
    my $self=shift;
    shift;
    my $args=shift;
    my %tree_info=@_;
    my $string;
    #usual sequence
    return $self->operator_to_string(',',$args,%tree_info)
	unless ($tree_info{list_level});
    
    #bad luck, we are inside a matrix
    #how deep?
    my $list_level=$tree_info{list_level};
    #print "sequence: ";dd %tree_info;
    if($list_level % 2){
	#an 'outer' level
	return $self->operator_to_string('\\',$args,%tree_info)
    }
    else{
	#an 'inner' level
	($string,%tree_info)= $self->operator_to_string('&',$args,%tree_info);
	#there is at least one column in one row
	$tree_info{num_columns} // ($tree_info{num_columns}=1);
	# we have just added another column
	++$tree_info{num_columns};
	return ($string,%tree_info)
    }
}

#remove unneeded bracket -> if $_[1] is a bracket (), return its argument
sub fall_through_bracket{
    my $self=shift;
    my $object=shift;
        if(
	 ($object->is eq 'bracket')
	 and ($object->name->[0] eq '(')
	 and ($object->name->[1] eq ')')
	and (scalar @{$object->args} !=2)	
	){
	# we have an unneeded bracket, let's jump one level deeper
	return $object->args->[0];
    }
   return $object
}

#give correct size modifier for size $_[0] of bracket $[1]
sub bracket_size{
    my $self=shift;
    my $size=shift;
    my $bracket=shift;
    return 
	(($size<scalar @bracket_size_modifier)
	  ?$bracket_size_modifier[$size]
	  :$bracket_size_modifier[-1]
	)
	.$bracket
	;
}

#merge information from processing different branches of the tree
#only the size of the last bracket is interesting for our purposes
sub merge_info{
    my @tree_infos=@_;
    my $last_bracket_size=-1;
    my $num_columns=-1;
    my %result_info;
    foreach (@tree_infos){
	if(defined $_->{last_bracket_size} and $_->{last_bracket_size}>$last_bracket_size){
	    $last_bracket_size=$_->{last_bracket_size}
	}
	if(defined $_->{num_columns} and $_->{num_columns}>$num_columns){
	    $num_columns=$_->{num_columns}
	}
    }
    if($last_bracket_size>-1){
	$result_info{last_bracket_size}=$last_bracket_size;
    }
    if($num_columns>-1){
	$result_info{num_columns}=$num_columns;
    }
    return %result_info;
}

#insert line breaks after a certain number of characters
sub insert_line_breaks{
    my $self=shift;
    my $_=shift;
    #$_ or return $_;
    use Math::ToMath::Printer::LatexSlicer;
    my $slicer= Math::ToMath::Printer::LatexSlicer->new;
    $slicer->init($self->{options});
    $_=$slicer->slice($_) // die "Internal error: failed to parse output string"; 
    return $_;
}

1;

=head1 SEE ALSO

L<mathtomath>

L<Math::ToMath::Parser::Latex> - the corresponding parser

L<Math::ToMath::Expression>

other Math::ToMath::Printer::* modules

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
