package Form_out;
#define the output in LaTeX format

use 5.10.1;
use strict;
use Data::Dump;
use Operator;
#----------------------------------------------------------------------------------------------------
use base 'Printer';

#format a symbol as a string
sub symbol_to_string{
    my $self=shift;
    $_=$_[0];
    #if it contains illegal tokens, we use special form syntax [...]
    return $_ if /^(\$?[[:alpha:]][[:alnum:]]*_?|\.{3}|\[.*\])$/;
    return "[$_]";
}


sub string_to_string{
    my $self=shift;
    return "[$_[0]]";
}


1;
