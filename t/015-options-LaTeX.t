use strict;
use warnings;
use Test::More tests => 18;
use Math::ToMath qw(:all);

my $format="Latex";

my $parser;
ok($parser=Parser->get_parser("Generic")->new);

my $printer_class="Math::ToMath::Printer::$format";
require_ok($printer_class);
my $printer = $printer_class->new;

my @default_options=$printer->options();

$printer->options(
    no_options => 1
    );

my @expr =(
    "a=b+c*d", 
    "e^(x+x^2/2+x^3/3+O(x^4))-id(-(x-1))", 
    "1+2+{3+4+5+6,7+8+a+b}
     -x*y*{{a11,a12,a13},{a21,a22,{{b11,b12},{b21,x+y+z}}}}",
    "-((-1+(1+((+1)-1)))*(-1))",
    "(234435*1249)/2+(234435*(x+y)-((1249-a)*x)-(x+y)*(y-x))/4"
    );


#transformation of variables to text
$printer->options(
    symbols_as_text => 1
    );
is(
    $printer->convert($parser->parse($expr[0])),
    'a=b+c\*d',
    "symbols as text in $expr[0]"
);

is(
    $printer->convert($parser->parse($expr[1])),
    'e^{x+\frac{x^2}{2}+\frac{x^3}{3}+O(x^4)}-\text{id}(-(x-1))',
    "symbols as text in $expr[1]"
);

#bracket scaling
$printer->options(
    bracket_scaling => ""
    );

is(
    $printer->convert($parser->parse($expr[3])),
    '-((-1+(1+((1)-1)))\*(-1))',
    "no bracket scaling in $expr[3]"
);

$printer->options(
    bracket_scaling => "auto"
    );

is(
    $printer->convert($parser->parse($expr[3])),
    '-\left(\left(-1+\left(1+\left(\left(1\right)-1\right)\right)\right)\*\left(-1\right)\right)',
    "auto bracket scaling in $expr[3]"
);

$printer->options(
    @default_options,
    bracket_scaling => "auto",
    line_length => 3
    );

is(
    $printer->convert($parser->parse($expr[3])),
    '-\left(\left(-1\right.\right.\\\\
&\left.\left.+\left(1+\left(\left(1\right)\right.\right.\right.\right.\\\\
&\left.\left.\left.\left.-1\right)\right)\right)\*\left(\right.\right.\\\\
&\left.\left.-1\right)\right)',
    "auto bracket scaling in $expr[3] with line breaks"
);

$printer->options(
    bracket_scaling => "incremental"
    );

is(
    $printer->convert($parser->parse($expr[3])),
    '-\Bigg(\bigg(-1+\Big(1+\big((1)-1\big)\Big)\bigg)\*(-1)\Bigg)',
    "incremental bracket scaling in $expr[3]"
);


#line breaks

$printer->options(
    @default_options,
    bracket_scaling => "",
    line_length => 2
    );

is(
    $printer->convert($parser->parse($expr[0])),
    'a=b\\\\
&+c\*d',
    "line break in $expr[0]"
);

$printer->options(
    @default_options,
    bracket_scaling => "",
    line_length => 8
    );

is(
    $printer->convert($parser->parse($expr[1])),
    'e^{x+\frac{x^2}{2}+\frac{x^3}{3}+O(x^4)}\\\\
&-id(-(x-1))',
    "line break in $expr[1]"
);

$printer->options(
    @default_options,
    line_break_at => qr/\\\*/,
    line_length => 2
    );

is(
    $printer->convert($parser->parse($expr[0])),
    'a=b+c\\\\
&\*d',
    "line break in $expr[0] at different regex"
);

#subscript size

$printer->options(
    @default_options,
    bracket_scaling => "",
    line_length => 8,
    subscript_size => 0
    );

is(
    $printer->convert($parser->parse($expr[1])),
    'e^{x+\frac{x^2}{2}+\frac{x^3}{3}+O(x^4)}-id(-(x-1))',
    "no line break in $expr[3] due to subscript_size=0"
);

#list formats
$printer->options(
    list_format => ""
    );

is(
    $printer->convert($parser->parse($expr[2])),
    '1+2+\{3+4+5+6,7+8+a+b\}-x\*y\*\{\{a11,a12,a13\},\{a21,a22,\{\{b11,b12\},\{b21,x+y+z\}\}\}\}',
    "lists in $expr[2]"
);

$printer->options(
    list_format => "tabular"
    );

is(
    $printer->convert($parser->parse($expr[2])),
'1+2+
\begin{tabular}{c}
3+4+5+6\\\\
7+8+a+b
\end{tabular}
-x\*y\*
\begin{tabular}{ccc}
a11&a12&a13\\\\
a21&a22&
\begin{tabular}{cc}
b11&b12\\\\
b21&x+y+z
\end{tabular}

\end{tabular}
',
    "lists in $expr[2] as tabulars"
);

$printer->options(
    list_format => "array"
    );

is(
    $printer->convert($parser->parse($expr[2])),
'1+2+
\left(\begin{array}{c}
3+4+5+6\\\\
7+8+a+b
\end{array}\right)
-x\*y\*
\left(\begin{array}{ccc}
a11&a12&a13\\\\
a21&a22&
\left(\begin{array}{cc}
b11&b12\\\\
b21&x+y+z
\end{array}\right)

\end{array}\right)
',
    "lists in $expr[2] as arrays"
);

$printer->options(
    list_format => "pmatrix"
    );

is(
    $printer->convert($parser->parse($expr[2])),
'1+2+
\begin{pmatrix}
3+4+5+6\\\\
7+8+a+b
\end{pmatrix}
-x\*y\*
\begin{pmatrix}
a11&a12&a13\\\\
a21&a22&
\begin{pmatrix}
b11&b12\\\\
b21&x+y+z
\end{pmatrix}

\end{pmatrix}
',
    "lists in $expr[2] as pmatrices"
);

#auto-balance ratios
$printer->options(
    @default_options,
    bracket_scaling => 0,
    # circumvent bug (slicer is only used for non-zero line_length)
    line_length => 1000
    );

is(
    $printer->convert($parser->parse($expr[4])),
    '\frac{234435\cdot1249}{2}+\frac{1}{4}\*(234435\*(x+y)-((1249-a)\*x)-(x+y)\*(y-x))',
    "break ratios in $expr[4]"
    );

$printer->options(
    @default_options,
    # circumvent bug (slicer is only used for non-zero line_length)
    line_length => 1000
    );

is(
    $printer->convert($parser->parse($expr[4])),
    '\frac{234435\cdot1249}{2}+\frac{1}{4}\*\Big(234435\*(x+y)-\big((1249-a)\*x\big)-(x+y)\*(y-x)\Big)',
    "break ratios in $expr[4] wit incremental bracket scaling"
    );
