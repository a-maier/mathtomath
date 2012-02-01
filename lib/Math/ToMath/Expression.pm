package Math::ToMath::Expression;

=head1 NAME

Math::ToMath::Expression - Class for B<mathtomath> expressions

=cut

use strict;
use warnings;
use Data::Dump;

use constant Expression => __PACKAGE__;
use parent 'Exporter';
our @EXPORT_OK = qw(Expression);
our @EXPORT = qw();
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

=head1 SYNOPSIS

 use Math::ToMath::Expression;

 my $x=Expression->new(name =>'x',is => 'symbol');

 $x->is;
 $x->name;
 $x->args;


=head1 DESCRIPTION

Like almost all computer algebra systems, B<mathtomath> internally 
stores expressions as trees, which are implemented in the 
Math::ToMath::Expression class. It offers the following methods:

=over 2

=item B<new>


The constructor with the expression's name and type (C<is>) as mandatory arguments.


=item B<is>


Returns the type of the expression, which is one of "number", "symbol", "operator"
or "bracket".


=item B<name>


Returns the name of the expression, e.g. "x", "3.1415" or "+".


=item B<args>


For operators and brackets, this returns an array reference to the argument(s).


=back

=cut

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

=head1 SEE ALSO

B<TODO> 

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
