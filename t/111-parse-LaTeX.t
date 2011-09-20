use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expressions=();
plan tests => 1+@expressions;
my $parser;
ok($parser=Parser->get_parser('Latex'),"Found a parser for LaTeX!");
for my $expression (@expressions){
    ok($parser->parse($expression),"LaTeX parser parses expression $expression");
}

