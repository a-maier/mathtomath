package Math::ToMath;

use 5.010001;
use strict;
use warnings;

our $VERSION = '0.01';

use Math::ToMath::Parser qw(Parser);
use Math::ToMath::Symbols qw(Symbols);
use Math::ToMath::Expression qw(Expression);

use parent 'Exporter';
our @EXPORT = qw();
our @EXPORT_OK = qw(Parser Symbols Expression);
our %EXPORT_TAGS = ( 'all' => \@EXPORT_OK );

1;
__END__

=head1 NAME

Math::ToMath - Convert mathematical expressions between different formats

=head1 SYNOPSIS

  use Math::ToMath;

=head1 DESCRIPTION

Stub documentation for Math::ToMath, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

You can request to have various package name shortcuts exported:

  Symbols    => Math::ToMath::Symbols
  Parser     => Math::ToMath::Parser
  Expression => Math::ToMath::Expression

The following export tag will export all exportable shortcuts and functions:

  use Math::ToMath ':all';

=head1 SEE ALSO

...

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
