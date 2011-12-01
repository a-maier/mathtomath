package Math::ToMath::Printer::Form;
#define the output in Form format

use Math::ToMath::Operator qw(Operator);
use 5.10.1;
use strict;
use warnings;
use Data::Dump;
#----------------------------------------------------------------------------------------------------
use parent 'Math::ToMath::Printer';

sub init{
    my $self=shift;
    $self->SUPER::init(@_);
    #these operators do not exist
    map {delete $self->{operators}->{$_}} qw(> < == != >= <= ???);
    # '=' is not associative
    $self->{operators}->{'='}=Operator->new(name => '=',prec => 200);
    # '??' is mapped onto a different operator
    $self->{operators}->{'??'}=Operator->new(name => '?',prec => 800,pos => 'prefix');
    # '*' can be commutative or non-commutative, depending on the operands
    $self->{operators}->{'**'} = $self->{operators}->{'*'};
}

#format a symbol as a string
sub symbol_to_string{
    my $self=shift;
    my $_=$_[0];
    $_=$self->replace_local($_);
    #if it contains illegal tokens, we use special form syntax [...]
    return $_ if /^(\$?[[:alpha:]][[:alnum:]]*_?|\.{3}|\[.*\])$/;
    return "[$_]";
}


sub string_to_string{
    my $self=shift;
    return '['.$self->replace_local($_[0]).']';
}


1;
