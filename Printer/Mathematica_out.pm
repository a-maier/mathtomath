package Mathematica_out;
#define the output in LaTeX format

use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------
use base 'Printer';

sub bracket_to_string{
    my $self=shift;
    my $brackets=shift;
    my $args=shift;
    if(scalar @$args==1){
	#for usual brackets use the default
	return $self->SUPER::bracket_to_string($brackets,$args)
    }
    elsif(scalar @$args==2){
	#for functions use square brackets
	return $self->to_string($args->[0]).'['.$self->to_string($args->[1]).']'
    }
    else{
	die "Too many arguments for bracket"
    }
}


#format a symbol as a string, either falling back to interpreting the symbol as string
# TODO: or dying on error
sub symbol_to_string{
    my $self=shift;
    $_=$_[0];
    #if it contains illegal tokens, we transform it into a string
    return $self->string_to_string($_[0]) unless /^(([[:alpha:]]|\$)([[:alnum:]]|\$)*)$/;
    return $_;
}


1;
