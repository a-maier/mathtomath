use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expressions=();
plan tests => 1+@expressions;
my $parser;
ok($parser=Parser->get_parser('Generic'),"Found a parser for Generic!");
for my $expression (@expressions){
    ok($parser->parse($expression),"Generic parser parses expression $expression");
}

