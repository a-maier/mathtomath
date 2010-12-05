package Latex_out;
#define the output in LaTeX format

use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------
use base 'Printer';

sub init{
    my $self=shift;
    $self->SUPER::init;
    %{$self->{specials}}=(
	'/' => \&ratio_as_frac,
	'*' => \&product,
	'^' => \&power
	);
}

sub number_to_string{
    return $_[0]->replace_local($_[1]);
}
sub symbol_to_string{
    return $_[0]->replace_local($_[1]);
}
sub string_to_string{
    return $_[0]->replace_local($_[1]);
}

#special latex functions
sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    if(scalar @$args > 1){
	my $function=shift @$args;
	given($function->name){
	    when ('**subscript**'){return $self->subscript($args)}
	    when ('**sqrt**'){return $self->sqrt($args)}
	    default {unshift @$args,$function}
	}
    }
    return $self->SUPER::bracket_to_string($brackets,$args);
}


#format ratios as \frac{}{}
sub ratio_as_frac{
    my $self=shift;
    shift;
    my $args=shift;
    my ($num,$den);
    ($num,$den)=map {$self->to_string($self->fall_through_bracket($_))} @$args;
    my $string=$self->replace_local('\frac')."{$num}{$den}";
    return $string;
}

#format products
sub product{
    my $self=shift;
    shift;
    my $args=shift;
    #TODO: it would be wise to use operator_to_string here, but first these operators have to be defined
    #TODO: the following check is not sufficient
    if($$args[0]->is eq 'number' and $$args[1]->is eq 'number'){
	return $self->to_string($$args[0]).$self->replace_local('\cdot').$self->to_string($$args[1]) 
    }
    return $self->to_string($$args[0]).$self->replace_local('\*').$self->to_string($$args[1]) 
}

#format power (= remove superfluous brackets)
sub power{
    my $self=shift;
    my $op=shift;
    my $args=shift;
    my $last_prec=shift;
    #dd $$args[1];
    my $real_args=$self->fall_through_bracket($$args[1]);
    my $arg_str=$self->to_string($real_args);
    if(length $arg_str==1){
	return $self->to_string($$args[0]).$self->replace_local('^').$arg_str;
    }
    else{
	return $self->to_string($$args[0]).$self->replace_local('^')."{$arg_str}";
    }
}


#format subscripts
sub subscript{
    my $self=shift;
    my $args=shift;
    # $args is a sequence, we have to go one level deeper
    my $real_args=$$args[0]->args;
    my $subscript=$self->to_string($$real_args[1]);
    return $self->to_string($$real_args[0]).$self->replace_local('_').((length $subscript ==1 )?$subscript:"{$subscript}");
}

#format roots
sub sqrt{
    my $self=shift;
    my $args=shift;
    die "Don't know how to format **sqrt** with more than one argument in Latex format" if scalar @$args >1;
    #TODO: roots with sequence as argument
    return $self->replace_local('\sqrt').'{'.$self->to_string($$args[0]).'}';
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

1;
