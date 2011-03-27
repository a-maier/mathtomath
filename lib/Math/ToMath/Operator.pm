package Math::ToMath::Operator;
use strict;
use warnings;
use Data::Dump;

use constant Operator => __PACKAGE__;
use parent 'Exporter';
our @EXPORT_OK = qw(Operator);
our @EXPORT = qw();
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

sub new{
    my $class=shift;
    my $self={
	prec => 0,
	assoc => '',
	'pos' => ''
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
    return $self->{'pos'};
}

1;
