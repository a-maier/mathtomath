use strict;
use warnings;
use Test::More;
use Math::ToMath qw(:all);

my @formats=qw(Generic Mathematica Form Latex);

my %expr=(
    0 => Expression->new(name =>'0',is => 'number'),
    1 => Expression->new(name =>'1',is => 'number'),
    x => Expression->new(name =>'x',is => 'symbol')
    );

plan tests => (2+keys %expr) * @formats;

for my $format (@formats){
    my $printer_class="Math::ToMath::Printer::$format";
    require_ok($printer_class);
    can_ok(
	$printer_class,
	qw(new options local_rules global_rules format convert)
	);
    my $printer = $printer_class->new;
    for my $x (keys %expr){
    	is($printer->convert($expr{$x}),$x,"expression $x has correct format")
    	    or diag explain $expr{$x};
    }
}
