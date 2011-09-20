use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expressions=();
plan tests => 1+@expressions;
my $parser;
ok($parser=Parser->get_parser('Mathematica'),"Found a parser for Mathematica!");
for my $expression (@expressions){
    ok($parser->parse($expression),"Mathematica parser parses expression $expression");
}

