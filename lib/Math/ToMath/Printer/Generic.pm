package Math::ToMath::Printer::Generic;

=head1 NAME

Math::ToMath::Printer::Generic - Convert expressions to strings in generic format

=cut

use 5.10.1;
use strict;
use warnings;
no warnings qw(recursion);
use Data::Dump;
use Math::ToMath::Operator qw(Operator);

use parent 'Math::ToMath::Printer';

=head1 SYNOPSIS

 use Math::ToMath::Printer::Generic;

 #create a new object
 my $printer=Math::ToMath::Printer::Generic->new();

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
    '^=$' => '=='
 );

 #set/get global transformation rules
 my $global_printer_rules = $printer->global_rules(
    "\(6\*7\)" => 42
 );


=head1 DESCRIPTION

A printer is an object that can convert L<Math::ToMath::Expression> objects 
to strings. This module provides printers producing output in a "generic" 
format. This format is a kind of default format not aimed at any specific 
program.

=over 2

=item B<new>

Create a new printer object.

=item B<convert>

Converts an expression object into a string in generic format.

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

1;

=head1 SEE ALSO

L<Math::ToMath::Parser::Generic> - the corresponding parser

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
