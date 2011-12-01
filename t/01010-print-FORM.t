use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);

my $format="Form";

my %expr=(
    '[]' => Expression->new(name =>'[]',is => 'symbol'),
    '[x]' => Expression->new(name =>'x',is => 'string'),
    '[**Alpha**]' => Expression->new(name =>'**Alpha**',is => 'symbol'),
    "f(1)" => Expression->new(
	name =>['(',')'],
	is => 'bracket',
	args =>[
	    Expression->new(name => 'f', is => 'symbol'),
	    Expression->new(name => '1', is => 'number'),
	]
    ),
    "1+1" => Expression->new(
	name =>'+',
	is => 'operator',
	args =>[
	    Expression->new(name => '1', is => 'number'),
	    Expression->new(name => '1', is => 'number'),
	]
    ),
    "f(2,1)" => Expression->new(
    	name =>['(',')'],
    	is => 'bracket',
    	args =>[
    	    Expression->new(name => 'f', is => 'symbol'),
    	    Expression->new(
    		name => ',', 
    		is => 'operator',
    		args =>[
    		    Expression->new(name => '2', is => 'number'),
    		    Expression->new(name => '1', is => 'number')
    		]
    	    ),
    	]
    ),
    #check special functions
    "sqrt_(2)" => Expression->new(
    	name =>['(',')'],
    	is => 'bracket',
    	args =>[
    	    Expression->new(name => '**sqrt**', is => 'symbol'),
    	    Expression->new(name => '2', is => 'number'),
    	]
    ),
    #check operator precedence -
    # this has to work even if there is no bracket in the
    # internal representation
    "x*x.y^p.q" => 
    Expression->new(
	name => '*',
	is => 'operator',
	args =>[
	    Expression->new(name => 'x', is => 'symbol'),
	    Expression->new(
		name =>'^',
		is => 'operator',
		args =>[
		    Expression->new(
			name => '.',
			is => 'operator',
			args => [
			    Expression->new(name => 'x', is => 'symbol'),
			    Expression->new(name => 'y', is => 'symbol'),
			]
		    ),
		    Expression->new(
			name => '.',
			is => 'operator',
			args => [
			    Expression->new(name => 'p', is => 'symbol'),
			    Expression->new(name => 'q', is => 'symbol'),
			]
		    )
		]
	    )
	]
    )
    );

plan tests => (1+keys %expr);

my $printer_class="Math::ToMath::Printer::$format";
require_ok($printer_class);
my $printer = $printer_class->new;
for my $x (sort keys %expr){
    is($printer->convert($expr{$x}),$x,"expression $x has correct format")
	or diag explain $expr{$x};
}
