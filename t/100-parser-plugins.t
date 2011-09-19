use strict;
use warnings;
use Test::More tests => 5;
use Math::ToMath qw(:all);
my @expected_parsers=
    qw(Generic Mathematica Form Latex);
my @parsers = Parser->get_parsers();
ok(@parsers > 0, "Found parsers");
for my $format (@expected_parsers){
ok(
  (grep {$_ eq "Math::ToMath::Parser::$format"} @parsers),
  "Found a parser for $format!"
);
}
