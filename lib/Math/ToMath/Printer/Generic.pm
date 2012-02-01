package Math::ToMath::Printer::Generic;
#define the output in generic format

use 5.10.1;
use strict;
use warnings;
no warnings qw(recursion);
use Data::Dump;
use Math::ToMath::Operator qw(Operator);
#----------------------------------------------------------------------------------------------------
use parent 'Math::ToMath::Printer';

1;

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
