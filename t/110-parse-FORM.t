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
    '[x]',
    '[x+[y]]',
    'x = y',
    'x / y;',
    'x1+...+x100',
    'x+{1,3,4,10}[4]',
    'x?+f(?a)',
    'p1.p2',
    #disabled - the parser is not powerful enough yet
    #'x?!int_',
    #'x?{1,2,3}',
    #'x?{1,2,3}[n]',
    #'x?set[y]',
    # 'f(0,,,0)',  #== f(0,0,0,0)
    # 'f(,,,0)',   #== f(0,0,0,0)
    # 'f(0 0 0 0)',#== f(0,0,0,0)
    # 'f(,, 0 0)', #== f(0,0,0,0)
    # '{,}',       #=={}
    # '{1,,3}[2]', #=={1,3}[2]
    # '{,,3}[1]',  #=={3}[1]
    '[foo-[&%$/##]^bar]=[][[-]({a1,...,a3}[2])]-[\].[\];;'
    #improved version:
    #'[foo-[&%$/##]^bar]=[][[-](,{,,a1,...,a3,,}[2] 0)]-[\].[\];;'
    );
my $parser_class;
if($parser_class=Parser->get_parser('Form')){
    plan tests => 1+@expressions;
}
else{
    plan skip_all => "No Form parser available";
}

can_ok($parser_class,qw(new parse));
my $parser=$parser_class->new;
for my $expression (@expressions){
    ok($parser->parse($expression),"FORM parser parses expression $expression")
	or diag explain $parser->parse($expression);
}


