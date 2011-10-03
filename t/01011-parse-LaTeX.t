use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);
my @expressions=(
    '-1',
    'x\*y',
    'x \* y', 
    'x \cdot y', 
    'x\;y', 
    'x\ y', 
    'x^4*y^ y',
    'f(1,2),\,a',
    'a,\,b',
    'f\big(1,g(2+3)-1\big)',
    'a_x',
    'a_{x,y}',
    'a_{x+y}',
    'x = y',
    'x / y',
    'x \over y',
    '{x \over y}^3',
    '\frac{x}{y}+3',
    '\frac34',
    'f\left(\frac34\right)',
    'x_1+\dots+x_{100}',
    'x+\{1,3,4,10\}_4',
    '\begin{pmatrix}
     1 & 2\\\\
     3&4
     \end{pmatrix}',
    'a^{\begin{pmatrix}
     1 & 2\\\\
     3&4
     \end{pmatrix}}'
    );
my $parser_class;
if($parser_class=Parser->get_parser('Latex')){
    plan tests => 1+@expressions;
}
else{
    plan skip_all => "No LaTeX parser available";
}

can_ok($parser_class,qw(new parse));
my $parser=$parser_class->new;
for my $expression (@expressions){
    ok($parser->parse($expression),"LaTeX parser parses expression $expression")
	or diag explain $parser->parse($expression);
}

