package Latex_out;
#define the output in LaTeX format

use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------
use base 'Printer';

sub number_to_string{
    return $_[1];
}

sub symbol_to_string{
    return $_[1];
}

sub string_to_string{
    return $_[1];
}

#format ratios as \frac{}{}
sub ratio_as_frac{
    my $self=shift;
    shift;
    my $args=shift;
    my $string='\frac{'.$self->to_string($$args[0]).'}{'.$self->to_string($$args[1]).'}';
    return $string;
}

1;
