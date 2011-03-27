use strict;
use warnings;
use Test::More tests => 2;
use Math::ToMath qw(:all);

my @parsers = Parser->get_parsers();
ok(@parsers > 0, "Found parsers");
ok(
  (grep {$_ eq 'Math::ToMath::Parser::Mathematica'} @parsers),
  "Found at least a Mathematica parser!"
);
