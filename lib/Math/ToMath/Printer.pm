package Math::ToMath::Printer;
#define the output in generic format
#all output classes inherit from this one
use 5.10.1;
use strict;

use constant Printer => __PACKAGE__;

use parent 'Exporter';
our @EXPORT_OK = qw(Printer);
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

use Data::Dump;
use Math::ToMath qw(:all);
use Math::ToMath::Operator qw(Operator);
use Math::ToMath::Symbols qw(Symbols);
use Scalar::Util qw(blessed);
#----------------------------------------------------------------------------------------------------

sub new{
    my $class=shift;
    my $self={};

    bless($self,$class);
    $self->init(@_);
    return $self;
}

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
	'^'	=> Operator->new(name => '^',prec => 600,assoc =>'left'),
	'.'	=> Operator->new(name => '.',prec => 700),
	'u-'	=> Operator->new(name => '-',prec => 750,pos => 'prefix'),
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

    #TODO: set default options
    %{$self->{options}}=();
    for my $scope ("local","global"){
	%{$self->{rules}->{$scope}}=();
    }
#special output functions for single objects
    %{$self->{specials}}=();

}

#set or read options
sub options{
    my $self=shift;
    %{$self->{options}}=@_ if @_;
    return %{$self->{options}};
}

#set or read local rules
sub local_rules{
    my $self=shift;
    %{$self->{rules}->{local}}=@_ if @_;
    map {$_=qr/$_/} keys %{$self->{rules}->{local}};
    return %{$self->{rules}->{local}};
}

#set or read global rules
sub global_rules{
    my $self=shift;
    %{$self->{rules}->{global}}=@_ if @_;
    map {$_=qr/$_/} keys %{$self->{rules}->{global}};
    return %{$self->{rules}->{global}};
}

sub operator_by_name{
    my $self=shift;
    my $op_name=shift;
    $self->{operators}->{$op_name}= $_[0] if(defined $_[0]);
    return $self->{operators}->{$op_name}
}

sub symbol_by_name{
    my $self=shift;
    my $sym_name=shift;
    $self->{symbols}->{$sym_name}= $_[0] if(defined $_[0]);
    return $self->{symbols}->{$sym_name}
}

sub special_by_name{
    my $self=shift;
    my $sym_name=shift;
    $self->{specials}->{$sym_name}= $_[0] if(defined $_[0]);
    return $self->{specials}->{$sym_name}
}

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

#format a symbol as a string, either ignoring all illegal tokens
# TODO: or dying on error
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

#format a number as a string
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

#format an internal string as an output string 
sub string_to_string{
    my $self=shift;
    my $_=$self->replace_local($_[0]);
    return ("\"$_\"");
}

#format an operator
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
    #check associativiy - only important if the previous operator equals the current one
    elsif($op_name eq $last_op){
	if(! defined $operator->assoc){
	    die "Subsequent occurence of non-associative operator ".$operator->name;
	}
	elsif(
	    (($operator->assoc eq 'right') and ($tree_info{arg_num} eq 'left'))
	    or (($operator->assoc eq 'left') and ($tree_info{arg_num} eq 'right'))
	    ){#the associativity has changed compared to the input format -> we need a bracket
	    $string='('.$string.')';
	}
    }
    return ($string,%tree_info)
}

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

#use local replacement rules on argument 
sub replace_local{
    my $self=shift;
    my $_=shift;
    for my $pattern (keys %{$self->{rules}->{local}}){
	s/$pattern/$self->{rules}->{local}->{$pattern}/ee;
    }
    return $_
}

#return contents of a configuration file
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

#merge information from processing different branches of the tree
sub merge_info{
}

sub format{
    my $self=shift;
    return $self->{format};
}

#convert expression to current format
sub convert{
    my $self=shift;
    my $expression=shift;
    my $_=$self->to_string($expression);
    #final formatting for output string
    for my $pattern (keys %{$self->{rules}->{global}}){
	s/$pattern/$self->{rules}->{global}->{$pattern}/ee;
    }
    $_=$self->insert_line_breaks($_) if ($self->{options}->{line_length});
    return $_;
}

#insert line breaks after a certain number of characters
sub insert_line_breaks{
    my $self=shift;
    my $_=shift;
    # FIXME: See Text::Wrap! It's part of core perl.
    s/(.{$self->{options}->{line_length}})/$1\n/g;
    return $_;
}

1;
