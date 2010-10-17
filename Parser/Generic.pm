####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Generic;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 2 "Generic.yp"

#use Data::Dump;
#special symbols
my %special_symbols=(
	'alpha' => 'alpha',
	'beta' => 'beta',
	'gamma' => 'gamma',
	'delta' => 'delta',
	'epsilon' => 'epsilon',
	'zeta' => 'zeta',
	'eta' => 'eta',
	'theta' => 'theta',
	'iota' => 'iota',
	'kappa' => 'kappa',
	'lambda' => 'lambda',
	'mu' => 'mu',
	'nu' => 'nu',
	'xi' => 'xi',
	'omicron' => 'omicron',
	'pi' => 'pi',
	'rho' => 'rho',
	'sigma' => 'sigma',
	'tau' => 'tau',
	'upsilon' => 'upsilon',
	'phi' => 'phi',
	'chi' => 'chi',
	'psi' => 'psi',
	'omega' => 'omega',
	'Alpha' => 'Alpha',
	'Beta' => 'Beta',
	'Gamma' => 'Gamma',
	'Delta' => 'Delta',
	'Epsilon' => 'Epsilon',
	'Zeta' => 'Zeta',
	'Eta' => 'Eta',
	'Theta' => 'Theta',
	'Iota' => 'Iota',
	'Kappa' => 'Kappa',
	'Lambda' => 'Lambda',
	'Mu' => 'Mu',
	'Nu' => 'Nu',
	'Xi' => 'Xi',
	'Omicron' => 'Omicron',
	'Pi' => 'Pi',
	'Rho' => 'Rho',
	'Sigma' => 'Sigma',
	'Tau' => 'Tau',
	'Upsilon' => 'Upsilon',
	'Phi' => 'Phi',
	'Chi' => 'Chi',
	'Psi' => 'Psi',
	'Omega' => 'Omega',
	'i' => 'i',
	'e' => 'e'
);



sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			"(" => 16,
			'NUMBER' => 9
		},
		DEFAULT => -1,
		GOTOS => {
			'symbol' => 12,
			'input' => 5,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 7,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 1
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 18,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 2
		DEFAULT => -12
	},
	{#State 3
		ACTIONS => {
			"(" => 19
		},
		DEFAULT => -8
	},
	{#State 4
		ACTIONS => {
			'SYMBOL' => 2,
			"(" => 16
		},
		DEFAULT => -4,
		GOTOS => {
			'symbol' => 21,
			'function' => 20,
			'bracket' => 22
		}
	},
	{#State 5
		ACTIONS => {
			'' => 23
		}
	},
	{#State 6
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 24,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 7
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			">" => 37
		},
		DEFAULT => -2
	},
	{#State 8
		DEFAULT => -6
	},
	{#State 9
		DEFAULT => -13
	},
	{#State 10
		DEFAULT => -11
	},
	{#State 11
		ACTIONS => {
			"[" => 38
		},
		DEFAULT => -9
	},
	{#State 12
		ACTIONS => {
			'WILDCARD' => 39,
			"[" => 40,
			"(" => 41
		},
		DEFAULT => -3
	},
	{#State 13
		ACTIONS => {
			"}" => 42,
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'sequence' => 43,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 44,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 14
		DEFAULT => -7
	},
	{#State 15
		DEFAULT => -10
	},
	{#State 16
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 45,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 17
		DEFAULT => -5
	},
	{#State 18
		ACTIONS => {
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -23
	},
	{#State 19
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 46,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 20
		ACTIONS => {
			"(" => 19
		},
		DEFAULT => -28
	},
	{#State 21
		ACTIONS => {
			"(" => 41
		},
		DEFAULT => -27
	},
	{#State 22
		DEFAULT => -26
	},
	{#State 23
		DEFAULT => 0
	},
	{#State 24
		ACTIONS => {
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -21
	},
	{#State 25
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 47,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 26
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 48,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 27
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 49,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 28
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 50,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 29
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 51,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 30
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 52,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 31
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 53,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 32
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 54,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 33
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 55,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 56,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 57,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 58,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 37
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 59,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 38
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'sequence' => 60,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 61,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 39
		DEFAULT => -45
	},
	{#State 40
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'sequence' => 62,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 63,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 41
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'sequence' => 64,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 65,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 42
		DEFAULT => -36
	},
	{#State 43
		ACTIONS => {
			"}" => 66
		}
	},
	{#State 44
		ACTIONS => {
			"}" => 67,
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"," => 68,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			">" => 37
		}
	},
	{#State 45
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			")" => 69,
			">" => 37
		}
	},
	{#State 46
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			")" => 70,
			">" => 37
		}
	},
	{#State 47
		ACTIONS => {
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -24
	},
	{#State 48
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -15
	},
	{#State 49
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -19
	},
	{#State 50
		ACTIONS => {
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -22
	},
	{#State 51
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -18
	},
	{#State 52
		ACTIONS => {
			"." => 36
		},
		DEFAULT => -30
	},
	{#State 53
		ACTIONS => {
			"^" => 30,
			"." => 36
		},
		DEFAULT => -25
	},
	{#State 54
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -16
	},
	{#State 55
		ACTIONS => {
			"^" => 30,
			"." => 36
		},
		DEFAULT => -29
	},
	{#State 56
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -14
	},
	{#State 57
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -20
	},
	{#State 58
		ACTIONS => {
			"." => undef
		},
		DEFAULT => -31
	},
	{#State 59
		ACTIONS => {
			"-" => 25,
			"+" => 28,
			"^" => 30,
			"*" => 31,
			"/" => 33,
			"." => 36
		},
		DEFAULT => -17
	},
	{#State 60
		ACTIONS => {
			"]" => 71
		}
	},
	{#State 61
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"," => 68,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			"]" => 72,
			">" => 37
		}
	},
	{#State 62
		ACTIONS => {
			"]" => 73
		}
	},
	{#State 63
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"," => 68,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			"]" => 74,
			">" => 37
		}
	},
	{#State 64
		ACTIONS => {
			")" => 75
		}
	},
	{#State 65
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"/" => 33,
			"," => 68,
			"=" => 34,
			"^" => 30,
			"*" => 31,
			'LE' => 35,
			'NE' => 32,
			"." => 36,
			")" => 76,
			">" => 37
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		DEFAULT => -37
	},
	{#State 68
		ACTIONS => {
			"-" => 1,
			"(" => 16,
			'SYMBOL' => 2,
			"+" => 6,
			"{" => 13,
			'NUMBER' => 9
		},
		GOTOS => {
			'symbol' => 12,
			'sequence' => 77,
			'number' => 4,
			'function' => 3,
			'bracket' => 14,
			'term' => 78,
			'index' => 15,
			'relation' => 17,
			'operation' => 8,
			'wildcard' => 10,
			'list' => 11
		}
	},
	{#State 69
		DEFAULT => -32
	},
	{#State 70
		DEFAULT => -35
	},
	{#State 71
		DEFAULT => -44
	},
	{#State 72
		DEFAULT => -43
	},
	{#State 73
		DEFAULT => -42
	},
	{#State 74
		DEFAULT => -41
	},
	{#State 75
		DEFAULT => -34
	},
	{#State 76
		DEFAULT => -33
	},
	{#State 77
		DEFAULT => -40
	},
	{#State 78
		ACTIONS => {
			'ID' => 26,
			"-" => 25,
			"<" => 27,
			'GE' => 29,
			"+" => 28,
			"," => 68,
			"^" => 30,
			"*" => 31,
			'NE' => 32,
			"/" => 33,
			"=" => 34,
			'LE' => 35,
			"." => 36,
			">" => 37
		},
		DEFAULT => -39
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'input', 0, undef
	],
	[#Rule 2
		 'input', 1, undef
	],
	[#Rule 3
		 'term', 1, undef
	],
	[#Rule 4
		 'term', 1, undef
	],
	[#Rule 5
		 'term', 1, undef
	],
	[#Rule 6
		 'term', 1, undef
	],
	[#Rule 7
		 'term', 1, undef
	],
	[#Rule 8
		 'term', 1, undef
	],
	[#Rule 9
		 'term', 1, undef
	],
	[#Rule 10
		 'term', 1, undef
	],
	[#Rule 11
		 'term', 1, undef
	],
	[#Rule 12
		 'symbol', 1,
sub
#line 86 "Generic.yp"
{
		my $symbol=$_[1];
		#special characters
		if(defined $special_symbols{$symbol}){
			   $symbol="**$special_symbols{$symbol}**";		
		}
		Expression->new(name =>$symbol,is => 'symbol')
		}
	],
	[#Rule 13
		 'number', 1,
sub
#line 97 "Generic.yp"
{Expression->new(name =>$_[1],is => 'number')}
	],
	[#Rule 14
		 'relation', 3,
sub
#line 100 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 15
		 'relation', 3,
sub
#line 101 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 16
		 'relation', 3,
sub
#line 102 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 17
		 'relation', 3,
sub
#line 103 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 18
		 'relation', 3,
sub
#line 104 "Generic.yp"
{Expression->new(name =>'>=',is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 19
		 'relation', 3,
sub
#line 105 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 20
		 'relation', 3,
sub
#line 106 "Generic.yp"
{Expression->new(name =>'<=',is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 21
		 'operation', 2,
sub
#line 110 "Generic.yp"
{$_[2]}
	],
	[#Rule 22
		 'operation', 3,
sub
#line 111 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 23
		 'operation', 2,
sub
#line 112 "Generic.yp"
{Expression->new(name =>$_[1],is => 'operator',args => [$_[2]])}
	],
	[#Rule 24
		 'operation', 3,
sub
#line 113 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 25
		 'operation', 3,
sub
#line 114 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 26
		 'operation', 2,
sub
#line 115 "Generic.yp"
{Expression->new(name =>'*',is => 'operator',args => [$_[1],$_[2]])}
	],
	[#Rule 27
		 'operation', 2,
sub
#line 116 "Generic.yp"
{Expression->new(name =>'*',is => 'operator',args => [$_[1],$_[2]])}
	],
	[#Rule 28
		 'operation', 2,
sub
#line 117 "Generic.yp"
{Expression->new(name =>'*',is => 'operator',args => [$_[1],$_[2]])}
	],
	[#Rule 29
		 'operation', 3,
sub
#line 118 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 30
		 'operation', 3,
sub
#line 119 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 31
		 'operation', 3,
sub
#line 120 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 32
		 'bracket', 3,
sub
#line 123 "Generic.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[2]])}
	],
	[#Rule 33
		 'function', 4,
sub
#line 126 "Generic.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 34
		 'function', 4,
sub
#line 127 "Generic.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 35
		 'function', 4,
sub
#line 129 "Generic.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 36
		 'list', 2,
sub
#line 132 "Generic.yp"
{Expression->new(name =>['{','}'],is => 'bracket')}
	],
	[#Rule 37
		 'list', 3,
sub
#line 133 "Generic.yp"
{Expression->new(name =>['{','}'],is => 'bracket',args => [$_[2]])}
	],
	[#Rule 38
		 'list', 3,
sub
#line 134 "Generic.yp"
{Expression->new(name =>['{','}'],is => 'bracket',args => [$_[2]])}
	],
	[#Rule 39
		 'sequence', 3,
sub
#line 137 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 40
		 'sequence', 3,
sub
#line 138 "Generic.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 41
		 'index', 4,
sub
#line 141 "Generic.yp"
{Expression->new(name =>['[',']'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 42
		 'index', 4,
sub
#line 142 "Generic.yp"
{Expression->new(name =>['[',']'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 43
		 'index', 4,
sub
#line 143 "Generic.yp"
{Expression->new(name =>['[',']'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 44
		 'index', 4,
sub
#line 144 "Generic.yp"
{Expression->new(name =>['[',']'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 45
		 'wildcard', 2,
sub
#line 146 "Generic.yp"
{Expression->new(name => $_[2],is => 'operator',args => [$_[1]])}
	]
],
                                  @_);
    bless($self,$class);
}

#line 149 "Generic.yp"


sub _error {
    if(exists $_[0]->YYData->{ERRMSG}) {
	print $_[0]->YYData->{ERRMSG};
        delete $_[0]->YYData->{ERRMSG};
        return;
    };	
    print "Syntax error.\n";
}

sub _lexer {
    my $parser =shift;
    
    return('',undef) unless $parser->YYData->{INPUT};

    for ($parser->YYData->{INPUT}) {
    	# first check for reals, then for integers
	return('NUMBER',$1) if s/^(\d*\.\d+|\d+\.\d*)//; 
	return('NUMBER',$1) if s/^(\d+)//; 
	return('SYMBOL',$1) if s/^([[:alpha:]]\w*)//;
	return('ID',$1) if s/^(==)//;
	return('NE',$1) if s/^(!=)//;
	return('LE',$1) if s/^(<=|=>)//;
	return('GE',$1) if s/^(=>|<=)//;
	return('WILDCARD',$1) if s/^(\?{1,3})//;
        return($1,$1) if s/^(.)//s;
    }
}

sub parse {
    my $self=shift;
    my $data=shift;
    for ($data){
	s/\s+//g;
	$self->YYData->{INPUT} = $_
    }
    $self->YYParse( yylex => \&_lexer, yyerror => \&_error );
}


1;
