use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @parsers = Parser->get_parsers();
plan tests => 1 + 4*@parsers;
ok(@parsers > 0, "Found parsers");
for my $parser_class (@parsers){
    my $format = ($parser_class =~ /::(\w+)$/);
    can_ok($parser_class,qw(new parse));
    my $parser=$parser_class->new();
    for my $expression qw(0 1 x){
	ok($parser->parse($expression),"$format parser parses expression $expression")
    }
}

