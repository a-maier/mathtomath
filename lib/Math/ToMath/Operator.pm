package Math::ToMath::Operator;

=head1 NAME

Math::ToMath::Operator - Class for mathematical operators used by Math::ToMath::Printer

=cut

use strict;
use warnings;
use Data::Dump;

use constant Operator => __PACKAGE__;
use parent 'Exporter';
our @EXPORT_OK = qw(Operator);
our @EXPORT = qw();
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

=head1 SYNOPSIS

 use Math::ToMath::Operator;

 my $op=Operator->new(name => ';',prec => 0,assoc =>'right',pos => 'postfix')

 $op->name;
 $op->prec;
 $op->assoc;
 $op->pos;

=head1 DESCRIPTION


=over 2

=item B<new>


The constructor. All arguments are optional.


=item B<name>


Returns the operator's name, e.g. "+", "==".


=item B<prec>


Returns the operator's precedence (a number). 


=item B<assoc>

Returns the operator's associativity, i.e. one of "left", "right" or "nonassoc"

=item B<pos>

Returns the position of the operator relative to its argument. This is either 
"prefix" or "postfix". Operators with more than one argument are automatically
considered to be infix operators.


=back

=cut

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
    return $self->{'pos'};
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
