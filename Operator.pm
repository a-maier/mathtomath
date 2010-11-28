package Operator;
use strict;
use Data::Dump;

sub new{
    my $class=shift;
    my $self={
	prec => 0,
	assoc => '',
	pos => ''
    };
    %$self=@_;
    bless($self,$class);
    return $self;
}


sub name{
    my $self=shift;
    return $self->{name};
}

sub prec{
    my $self=shift;
    return $self->{prec};
}

sub assoc{
    my $self=shift;
    return $self->{assoc};
}

sub pos{
    my $self=shift;
    return $self->{pos};
}

1;
