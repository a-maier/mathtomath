use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expressions=();
plan tests => 1+@expressions;
my $parser;
ok($parser=Parser->get_parser('Form'),"Found a parser for FORM!");
for my $expression (@expressions){
    ok($parser->parse($expression),"FORM parser parses expression $expression");
}

