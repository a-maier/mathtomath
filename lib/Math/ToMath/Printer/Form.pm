package Math::ToMath::Printer::Form;

=head1 NAME

Math::ToMath::Printer::Form - Convert expressions to strings in FORM format

=cut

use Math::ToMath::Operator qw(Operator);
use 5.10.1;
use strict;
use warnings;
no warnings qw(recursion);
use Data::Dump;

use parent 'Math::ToMath::Printer';

=head1 SYNOPSIS

 use Math::ToMath::Printer::Form;

 #create a new object
 my $printer=Math::ToMath::Printer::Form->new();

 #get format
 my $format=$printer->format();

 #convert an expression to a string
 my $expr_str=$printer->convert($expression_tree);

 #set/get conversion options
 my $printer_options = $printer->options(
    line_length => 42
 );

 #set/get local transformation rules
 my $local_printer_rules = $printer->local_rules(
    '^=$' => ':='
 );

 #set/get global transformation rules
 my $global_printer_rules = $printer->global_rules(
    "\(6\*7\)" => 42
 );


=head1 DESCRIPTION

Printer objects of this class can be used to convert
L<Math::ToMath::Expression> objects into strings that can be fed into the
computer algebra (or symbolic manipulation) system FORM.

=over 2

=item B<new>

Create a new printer object.

=item B<convert>

Converts an expression object into a string in FORM compatible format.

=item B<options>

Set options for the conversion to strings. At the moment the only supported
option is I<line_length>, which specifies the maximum length of lines in the
output. The length is measured in characters. Longer lines are wrapped by
inserting a continuation character and a line break. If this option is not set
(or set to 0) lines can have arbitrary length.

=item B<local_rules>

Set local transformation rules. Transformation rules have the form LHS => RHS
and act like regular expression substitution, i.e. s/LHS/RHS/. Local rules
are applied separately to each subexpression. This allows a limited form of
"semantic" replacements as shown in the example.

=item B<global_rules>

Set global transformation rules. Transformation rules have the form LHS => RHS
and act like regular expression substitution, i.e. s/LHS/RHS/. Global rules are
applied by the B<convert> method to the whole resulting string. If the
I<line_length> option is set line breaks will be inserted B<after> global
rules are applied.

=back

=cut


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
    local $_=$_[0];
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

=head1 SEE ALSO

L<mathtomath>

L<The FORM home page|http://www.nikhef.nl/~form/>

L<The FORM reference manual|http://www.nikhef.nl/~form/maindir/documentation/reference/online/online.html>

L<Math::ToMath::Parser::Form> - the corresponding parser

L<Math::ToMath::Expression>

other Math::ToMath::Printer::* modules

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
