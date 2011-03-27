package Math::ToMath::Symbols;
use 5.10.1;
use strict;
use warnings;

use File::ShareDir qw(dist_file);
use File::Spec;

use constant Symbols => __PACKAGE__;

use parent 'Exporter';
our @EXPORT_OK = qw(Symbols);
our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

=head1 NAME

Math::ToMath::Symbols - Helper module for locating symbols config files

=head1 SYNOPSIS

  use Math::ToMath qw(:all);
  my $symbols_file = Symbols->get_symbol_file_for_class($parser_class);

=head1 DESCRIPTION

This module has the simple purpose to provide convenient access
to the Symbols data files that are installed along with the module.

=head2 EXPORT

None by default.

Can export a shortcut name for this class: C<Symbols>

=head1 SEE ALSO

L<Math::ToMath>

=head1 AUTHOR

Andreas Maier, E<lt>email@addressE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010-2011 by Andreas Maier

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.1 or,
at your option, any later version of Perl 5 you may have available.

=cut

sub get_symbol_file_for_class {
    my $self  = shift;
    my $class = shift;
    $class =~ /::([^:]+)$/
        or die "Cannot find symbol name for class '$class'";
    my $symbol_file = File::Spec->catfile("Symbols", $1 . ".dat");
    return dist_file('Math-ToMath', $symbol_file);
}

1;
