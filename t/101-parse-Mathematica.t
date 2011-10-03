use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expressions=(
    '-1',
    'x1',
    'x*y',
    'x * y', 
    'x^4*y^ y',
    #not implemented
    # 'a b',
    # '4 a',
    # '3 4',
    # 'x(x+y)',
    'f[1,2]',
    'f[1,g[2+3]-1]',
    '$x',
    '\[Alpha]',
    '"x+y"',
    'x = y = z',
    'x / y;',
    'x+{1,3,4,10}[[4]]',
    'x_+f[a__]',
    'p1.p2',
    'f[ #[[1]] ]&/@foo'
    );
my $parser_class;
if($parser_class=Parser->get_parser('Mathematica')){
    plan tests => 1+@expressions;
}
else{
    plan skip_all => "No Mathematica parser available";
}

can_ok($parser_class,qw(new parse));
my $parser=$parser_class->new;
for my $expression (@expressions){
    ok($parser->parse($expression),"Mathematica parser parses expression $expression")
	or diag explain $parser->parse($expression);
}


