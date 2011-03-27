package Math::ToMath::Expression;
#define the structure of one node in our syntax tree
use strict;
use warnings;
use Data::Dump;

use constant Expression => __PACKAGE__;
use parent 'Exporter';
our @EXPORT_OK = qw(Expression);
our @EXPORT = qw();
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

sub new{
    my $class=shift;
    my $self={};
    %$self=@_;
    foreach my $property (qw(is name)){
	#dd $self;
	exists $self->{$property} or die "Failed to construct expression: property '$property' is missing in (@_)"
    }
    bless($self,$class);
    return $self;
}

sub is{
    my $self=shift;
    return $self->{is};
}

sub name{
    my $self=shift;
    return $self->{name};
}

sub args{
    my $self=shift;
    return $self->{args};
}

1;
