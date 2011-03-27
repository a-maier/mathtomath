use strict;
use warnings;
use Test::More tests => 3;
use Math::ToMath qw(:all);

my @parsers = grep /::Form$/, Parser->get_parsers();
ok(@parsers > 0, "Found Form parser");
my $formclass = shift @parsers;

my $symbols_file = Symbols->get_symbol_file_for_class($formclass);
ok(defined($symbols_file), "Found a symbols file for Form");
ok(-e $symbols_file, "Symbols file for Form parser exists");

