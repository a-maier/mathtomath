package Printer;
#define the output in generic format
#all output classes inherit from this one
#TODO: make local variables inheritable
use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------

#operator properties:
# which operators exist, which token(s) are to be used for output, precedence, pre/in/postfix...
# brackets should also be included here to indicate that they are legal
my %operator_by_name=(
    ';'		=> Operator->new(name => ';',prec => 0,assoc =>'left',pos => 'postfix'),
    ','		=> Operator->new(name => ',',prec => 100,assoc =>'left'),
    '='		=> Operator->new(name => '=',prec => 200,assoc =>'left'),
    '=='	=> Operator->new(name => '==',prec => 300,assoc =>'right'),
    '!='	=> Operator->new(name => '!=',prec => 300,assoc =>'right'),
    '<'		=> Operator->new(name => '<',prec => 300,assoc =>'right'),
    '<='	=> Operator->new(name => '<=',prec => 300,assoc =>'right'),
    '>'		=> Operator->new(name => '>',prec => 300,assoc =>'right'),
    '>='	=> Operator->new(name => '>=',prec => 300,assoc =>'right'),
    '+'		=> Operator->new(name => '+',prec => 400,assoc =>'left'),
    '-'		=> Operator->new(name => '-',prec => 400,assoc =>'left',pos => 'prefix'),
    '*'		=> Operator->new(name => '*',prec => 500,assoc =>'left'),
    '/'		=> Operator->new(name => '/',prec => 500,assoc =>'left'),
    '^'		=> Operator->new(name => '^',prec => 600,assoc =>'left'),
    '.'		=> Operator->new(name => '.',prec => 700),
    '?'		=> Operator->new(name => '?',prec => 800,pos => 'postfix'),
    '??'	=> Operator->new(name => '??',prec => 800,pos => 'postfix'),
    '???'	=> Operator->new(name => '???',prec => 800,pos => 'postfix'),
    '['		=> Operator->new(name => '['),
    ']'		=> Operator->new(name => ']'),
    '('		=> Operator->new(name => '('),
    ')'		=> Operator->new(name => ')'),
    '{'		=> Operator->new(name => '{'),
    '}'		=> Operator->new(name => '}')
    );

#special output for certain functions
# e.g. for Latex we are supposed to put '**log**' => '\log' here
my %symbol_by_name=();

#special output functions for single objects
my %special_fun=();

sub to_string{
    my $self= shift;
    
    my $tree=shift;
    # say "to_string";
    #dd($tree);
    my $last_prec=shift;
    defined $last_prec or $last_prec=0;
    my $string;
    #special treatment for some operators/functions/whatever
    if (defined $special_fun{$tree->name}){
	return &{$special_fun{$tree->name}}($self,$tree->name,$tree->args,$last_prec)
    }

    given($tree->is){
	when('number') {$string= $self->number_to_string($tree->name)}
	when('string') {$string= $self->string_to_string($tree->name);}
	when('symbol') {
	    my $sym=(defined $symbol_by_name{$tree->name})?$symbol_by_name{$tree->name}:$tree->name;
	    $string= $self->symbol_to_string($sym)
	}
	when('operator') {
	    #check whether the operator exists in this format
	    exists $operator_by_name{$tree->name} 
	    or die "Operator '".$tree->name."' does not exist in format $self";
	    $string=$self->operator_to_string($operator_by_name{$tree->name},$tree->args, $last_prec);
	}
	when('bracket') {
	    for my $i (0..1){
		exists $operator_by_name{$tree->name->[$i]} 
		or die "Bracket '".$tree->name->[$i]."'does not exist in format $self";
	    }
	    my $brackets;
	    #check whether the brackets are legal tokens in this format
	    @$brackets=map {$operator_by_name{$_}->name} @{$tree->name};
	    $string= $self->bracket_to_string($brackets,$tree->args)
	}
	default {die "Don't know how to format a '$tree->{is}' as a string in format 'generic'"}
    }
    return $string;
}

#format a symbol as a string, either ignoring all illegal tokens
# TODO: or dying on error
sub symbol_to_string{
    my $self=shift;
    $_=$_[0];
    #treat special symbols
    s/(^\*\*|\*\*$)//g;
    #delete illegal tokens
    s/\W+//g;
    s/^[[:^alpha:]]+//g;
    $_ or die "Symbol '$_[0]' can't be converted into the format 'generic', because it does not contain any legal tokens";
    return $_;
}

#format a number as a string
sub number_to_string{
    my $self=shift;
    $_=$_[0];
    s/[^\d\.]//g;
    /^(\d+|\d*\.\d+|\d+\.\d*)$/ 
	or die "Number '$_[0]' can't be converted into the format 'generic'";
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
    my $last_prec=shift;
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
    $string='('.$string.')' if ($last_prec > $operator->prec);
    return $string
}

sub prefix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my $last_prec=shift;
    return $operator->name.$self->to_string($$args[0],$operator->prec);
}

sub postfix_operator_to_string{
    my $self=shift;

    my $operator=shift;
    my $args=shift;
    my $last_prec=shift;
    return $self->to_string($$args[0],$operator->prec).$operator->name;
}

sub infix_operator_to_string{
    my $self=shift;
    my $operator=shift;
    my $args=shift;
    my $last_prec=shift;
    return join($operator->name, map {$self->to_string($_,$operator->prec)} @$args);
}

sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    scalar @$args<3 or die "Too many arguments for bracket";
    return((scalar @$args>1?$self->to_string($args->[0]):'').$brackets->[0].$self->to_string($args->[-1]).$brackets->[1])
}

1;
