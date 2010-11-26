package Expression;
#define the structure of one node in our syntax tree
use strict;
use Data::Dump;

sub new{
    my $class=shift;
    my $self={};
    %$self=@_;
    foreach my $property ('is','name'){
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
