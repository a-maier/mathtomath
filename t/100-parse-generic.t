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
    'f(1,2)',
    'f(1,g(2+3)-1)',
    'alpha_s',
    '"x+y"',
    'x = y = z',
    'x / y;',
    'x+{1,3,4,10}[4]',
    'x?+f[a??]',
    'p1.p2',
    'a < b'
    );
my $parser_class;
if($parser_class=Parser->get_parser('Generic')){
    plan tests => 1+@expressions;
}
else{
    plan skip_all => "No Generic parser available";
}

can_ok($parser_class,qw(new parse));
my $parser=$parser_class->new;
for my $expression (@expressions){
    ok($parser->parse($expression),"Generic parser parses expression $expression")
	or diag explain $parser->parse($expression);
}


