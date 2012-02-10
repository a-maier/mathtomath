use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);

my $format="Generic";

my %expr=(
"123\\\n456\\\n789\\\n*ab\\\ncde\\\nfgh\\\nij" => 
    Expression->new(
	name => '*',
	is => 'operator',
	args =>[
	    Expression->new(name => '123456789', is => 'number'),
	    Expression->new(name => 'abcdefghij', is => 'symbol')
	]
    )    
    );

plan tests => (1+keys %expr);

my $printer_class="Math::ToMath::Printer::$format";
require_ok($printer_class);
my $printer = $printer_class->new;
$printer->options(
    line_length => 4
    );
for my $x (sort keys %expr){
    is($printer->convert($expr{$x}),$x,"expression $x has correct format")
	or diag explain $expr{$x};
}
