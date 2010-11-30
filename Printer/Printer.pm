package Printer;
#define the output in generic format
#all output classes inherit from this one
use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------


sub new{
    my $class=shift;
    my $self={};

    bless($self,$class);
    $self->init;
    return $self;
}

sub init{
    my $self=shift;

    #this is very questionable
    $self->{format}="$self";
    $self->{format} =~ s/(_out)?=.*//;
    say "Output format: $self->{format}";
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
	'-'	=> Operator->new(name => '-',prec => 400,assoc =>'left',pos => 'prefix'),
	'*'	=> Operator->new(name => '*',prec => 500,assoc =>'left'),
	'/'	=> Operator->new(name => '/',prec => 500,assoc =>'left'),
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
    %{$self->{symbols}}=reverse $self->get_config("Symbols/$self->{format}.dat");
#special output functions for single objects
    %{$self->{specials}}=();

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
    # last operator
    # if the current operator has a lower precedence, we need a bracket
    my $last_op=shift;
    defined $last_op or $last_op=0;
    # argument number of last operator
    #if the current operator equals the old one, depending on the 
    #associativity we might need a bracket
    my $arg_num=shift;
    defined $arg_num or $arg_num=0;
    my $string;
    #special treatment for some operators/functions/whatever
    if (defined $self->special_by_name($tree->name)){
	return &{$self->special_by_name($tree->name)}($self,$tree->name,$tree->args,$last_op)
    }

    given($tree->is){
	when('number') {$string= $self->number_to_string($tree->name)}
	when('string') {$string= $self->string_to_string($tree->name);}
	when('symbol') {
	    my $sym=$tree->name;
	    if($sym =~ /^\*\*/ and $sym =~ /\*\*$/){
		my $tmp=$sym;
		$tmp =~ s/(^\*\*|\*\*$)//g;
		$sym = $self->symbol_by_name($tmp) if defined $self->symbol_by_name($tmp);
	    }
	    $string= $self->symbol_to_string($sym)
	}
	when('operator') {
	    #check whether the operator exists in this format
	    defined $self->operator_by_name($tree->name) 
	    or die "Operator '".$tree->name."' does not exist in format $self->{format}";
	    $string=$self->operator_to_string($self->operator_by_name($tree->name),$tree->args, $last_op,$arg_num);
	}
	when('bracket') {
	    for my $i (0..1){
		defined $self->operator_by_name($tree->name->[$i]) 
		or die "Bracket '".$tree->name->[$i]."'does not exist in format $self->{format}";
	    }
	    my $brackets;
	    #check whether the brackets are legal tokens in this format
	    @$brackets=map {$self->operator_by_name($_)->name} @{$tree->name};
	    $string= $self->bracket_to_string($brackets,$tree->args)
	}
	default {die "Don't know how to format a '$tree->{is}' as a string in format $self->{format}"}
    }
    return $string;
}

#format a symbol as a string, either ignoring all illegal tokens
# TODO: or dying on error
sub symbol_to_string{
    my $self=shift;
    $_=$_[0];
    #delete illegal tokens
    s/^[[:^alpha:]]+//;
    s/\W+//g;
    $_ or die "Symbol '$_[0]' can't be converted into the format $self->{format}, because it does not contain any legal tokens";
    return $_;
}

#format a number as a string
sub number_to_string{
    my $self=shift;
    $_=$_[0];
    s/[^\d\.]//g;
    /^(\d+|\d*\.\d+|\d+\.\d*)$/ 
	or die "Number '$_[0]' can't be converted into the format $self->{format}";
    $_=$1;
    if(/^\./){$_='0'.$_}
    elsif(/\.$/){$_.='0'}
    return $_;
}

#format an internal string as an output string 
sub string_to_string{
    my $self=shift;
    return "\"$_[0]\"";
}

# sub function_to_string{
#     my $function=shift;
#     my $args=shift;
#     return(to_string($function).$fun_brackets[0].to_string($args).$fun_brackets[1])
# }

#format an operator
sub operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my $last_op=shift;
    my $arg_num=shift;
    my $string;
    if(scalar @$args == 1){
	#there is one argument, so it has to be either a postfix or a prefix operator
	if($operator->pos eq 'prefix'){
	    $string= $self->prefix_operator_to_string($operator,$args);
	}
	elsif($operator->pos eq 'postfix'){
	    $string= $self->postfix_operator_to_string($operator,$args);
	}
	else{
	    die "Failed to format ".$operator->pos." operator '".$operator->name."' with one argument"
	} 
    }
    else{
	#more than one argument, has to be an infix operator
	$string = $self->infix_operator_to_string($operator,$args);
    }
    #check precedence
    my $last_prec=$self->operator_by_name($last_op)->prec;
    
    if ($last_prec > $operator->prec) {$string='('.$string.')'}
    #check associativiy - only important if the previous operator equals the current one
    elsif($operator->name eq $last_op){
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
    return $string
}

sub prefix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my $last_prec=shift;
    return $operator->name.$self->to_string($$args[0],$operator->name,'right');
}

sub postfix_operator_to_string{
    my $self=shift;

    my $operator=shift;
    my $args=shift;
    my $last_prec=shift;
    return $self->to_string($$args[0],$operator->name,'left').$operator->name;
}

sub infix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my $last_prec=shift;
    return $self->to_string($$args[0],$operator->name,'left')
	.$operator->name
	.$self->to_string($$args[1],$operator->name,'right')
#join($operator->name, map {$self->to_string($_,$operator->prec)} @$args);
}

sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    scalar @$args<3 or die "Too many arguments for bracket";
    return((scalar @$args>1?$self->to_string($args->[0]):'').$brackets->[0].$self->to_string($args->[-1]).$brackets->[1])
}

#return contents of a configuration file
sub get_config{
    shift;
    my $file=shift;
    open(IN,$file) or die "Failed to open $file for reading: $!";
    my $contents='';
    while(<IN>){
	#ignore whitespace and comments
	s/(\s+|\#.*)//g;
	$contents.=$_;
    }
    close IN;
    my @tmp=split(/=>|,/,$contents);
    return  @tmp;
}


1;
