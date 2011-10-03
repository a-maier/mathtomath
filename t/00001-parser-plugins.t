use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expected_parsers=
    qw(Generic Mathematica Form Latex);
plan tests => scalar @expected_parsers;
for my $format (@expected_parsers){
    ok(
	Parser->get_parser($format),
	"Found a parser for $format!"
	);
}
