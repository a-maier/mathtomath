####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Form;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 8 "Form.yp"

#use Data::Dump;


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
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			"(" => 21,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		DEFAULT => -1,
		GOTOS => {
			'sp' => 2,
			'input' => 7,
			'number' => 6,
			'function' => 5,
			'term' => 9,
			'spattern' => 10,
			'sum' => 12,
			'equal' => 14,
			'list' => 13,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 1
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 29,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 2
		DEFAULT => -12
	},
	{#State 3
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 30,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 4
		DEFAULT => -20
	},
	{#State 5
		DEFAULT => -15
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			'' => 31
		}
	},
	{#State 8
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 32,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 9
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -2
	},
	{#State 10
		ACTIONS => {
			"{" => 17,
			"!" => 41
		},
		DEFAULT => -16,
		GOTOS => {
			'index' => 43,
			'not' => 40,
			'list' => 42
		}
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		DEFAULT => -7
	},
	{#State 13
		ACTIONS => {
			"[" => 44
		}
	},
	{#State 14
		DEFAULT => -6
	},
	{#State 15
		DEFAULT => -11
	},
	{#State 16
		ACTIONS => {
			"[" => 45,
			"?" => 46,
			"(" => 47
		},
		DEFAULT => -3
	},
	{#State 17
		ACTIONS => {
			"}" => 48,
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 49,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'lsequence' => 50,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 18
		DEFAULT => -13
	},
	{#State 19
		DEFAULT => -19
	},
	{#State 20
		DEFAULT => -14
	},
	{#State 21
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 51,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 22
		DEFAULT => -18
	},
	{#State 23
		DEFAULT => -17
	},
	{#State 24
		DEFAULT => -8
	},
	{#State 25
		DEFAULT => -22
	},
	{#State 26
		DEFAULT => -10
	},
	{#State 27
		DEFAULT => -9
	},
	{#State 28
		DEFAULT => -5
	},
	{#State 29
		ACTIONS => {
			"/" => 37,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -26
	},
	{#State 30
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39,
			">" => 52
		}
	},
	{#State 31
		DEFAULT => 0
	},
	{#State 32
		ACTIONS => {
			"/" => 37,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -24
	},
	{#State 33
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 53,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 54,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 55,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 36
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 56,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 37
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 57,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 38
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 58,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 59,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 40
		DEFAULT => -54
	},
	{#State 41
		ACTIONS => {
			"{" => 17
		},
		GOTOS => {
			'list' => 60
		}
	},
	{#State 42
		ACTIONS => {
			"[" => 44
		},
		DEFAULT => -52
	},
	{#State 43
		DEFAULT => -53
	},
	{#State 44
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 61,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 45
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 62,
			'spattern' => 10,
			'sum' => 12,
			'list' => 13,
			'equal' => 14,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 46
		DEFAULT => -47
	},
	{#State 47
		ACTIONS => {
			"-" => 1,
			"?" => 67,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			"," => 64,
			"(" => 21,
			'ELLIPSIS' => 25,
			")" => 66,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'function' => 5,
			'number' => 6,
			'term' => 65,
			'mpattern' => 63,
			'spattern' => 10,
			'sum' => 12,
			'equal' => 14,
			'list' => 13,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'fsequence' => 68,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 48
		DEFAULT => -38
	},
	{#State 49
		ACTIONS => {
			"}" => 69,
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"," => 70,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39
		}
	},
	{#State 50
		ACTIONS => {
			"}" => 71
		}
	},
	{#State 51
		ACTIONS => {
			"-" => 33,
			"^" => 35,
			"*" => 36,
			"+" => 34,
			"/" => 37,
			")" => 72,
			"." => 39,
			"=" => 38
		}
	},
	{#State 52
		DEFAULT => -33
	},
	{#State 53
		ACTIONS => {
			"/" => 37,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -27
	},
	{#State 54
		ACTIONS => {
			"/" => 37,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -25
	},
	{#State 55
		ACTIONS => {
			"." => 39
		},
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			"^" => 35,
			"." => 39
		},
		DEFAULT => -28
	},
	{#State 57
		ACTIONS => {
			"^" => 35,
			"." => 39
		},
		DEFAULT => -29
	},
	{#State 58
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"=" => undef,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -23
	},
	{#State 59
		ACTIONS => {
			"." => undef
		},
		DEFAULT => -31
	},
	{#State 60
		DEFAULT => -51
	},
	{#State 61
		ACTIONS => {
			"-" => 33,
			"^" => 35,
			"*" => 36,
			"+" => 34,
			"/" => 37,
			"." => 39,
			"]" => 73,
			"=" => 38
		}
	},
	{#State 62
		ACTIONS => {
			"-" => 33,
			"^" => 35,
			"*" => 36,
			"+" => 34,
			"/" => 37,
			"." => 39,
			"]" => 74,
			"=" => 38
		}
	},
	{#State 63
		ACTIONS => {
			")" => 75
		}
	},
	{#State 64
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			"," => 64,
			"(" => 21,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 76,
			'spattern' => 10,
			'sum' => 12,
			'equal' => 14,
			'list' => 13,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'fsequence' => 77,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 65
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"," => 78,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39,
			")" => 79
		}
	},
	{#State 66
		DEFAULT => -34
	},
	{#State 67
		ACTIONS => {
			'SYMBOL' => 4
		},
		GOTOS => {
			'symbol' => 80
		}
	},
	{#State 68
		ACTIONS => {
			")" => 81
		}
	},
	{#State 69
		DEFAULT => -40
	},
	{#State 70
		ACTIONS => {
			"-" => 1,
			"(" => 21,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 83,
			'spattern' => 10,
			'sum' => 12,
			'equal' => 14,
			'list' => 13,
			'exp' => 15,
			'symbol' => 16,
			'lsequence' => 82,
			'bracket' => 18,
			'coefficient' => 19,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 71
		DEFAULT => -39
	},
	{#State 72
		DEFAULT => -32
	},
	{#State 73
		DEFAULT => -49
	},
	{#State 74
		DEFAULT => -50
	},
	{#State 75
		DEFAULT => -37
	},
	{#State 76
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"," => 78,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -41
	},
	{#State 77
		DEFAULT => -43
	},
	{#State 78
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 4,
			"<" => 3,
			"+" => 8,
			"{" => 17,
			"," => 64,
			"(" => 21,
			'ELLIPSIS' => 25,
			'NUMBER' => 11
		},
		GOTOS => {
			'sp' => 2,
			'number' => 6,
			'function' => 5,
			'term' => 84,
			'spattern' => 10,
			'sum' => 12,
			'equal' => 14,
			'list' => 13,
			'exp' => 15,
			'symbol' => 16,
			'bracket' => 18,
			'coefficient' => 19,
			'fsequence' => 85,
			'abracket' => 20,
			'index' => 22,
			'cpattern' => 23,
			'diff' => 24,
			'product' => 27,
			'quot' => 26,
			'ellipsis' => 28
		}
	},
	{#State 79
		DEFAULT => -35
	},
	{#State 80
		DEFAULT => -48
	},
	{#State 81
		DEFAULT => -36
	},
	{#State 82
		DEFAULT => -45
	},
	{#State 83
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"," => 70,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -46
	},
	{#State 84
		ACTIONS => {
			"-" => 33,
			"+" => 34,
			"/" => 37,
			"," => 78,
			"=" => 38,
			"^" => 35,
			"*" => 36,
			"." => 39
		},
		DEFAULT => -42
	},
	{#State 85
		DEFAULT => -44
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
		 'term', 1, undef
	],
	[#Rule 13
		 'term', 1, undef
	],
	[#Rule 14
		 'term', 1, undef
	],
	[#Rule 15
		 'term', 1, undef
	],
	[#Rule 16
		 'term', 1, undef
	],
	[#Rule 17
		 'term', 1, undef
	],
	[#Rule 18
		 'term', 1, undef
	],
	[#Rule 19
		 'term', 1, undef
	],
	[#Rule 20
		 'symbol', 1,
sub
#line 39 "Form.yp"
{Node->new($_[1],'symbol')}
	],
	[#Rule 21
		 'number', 1,
sub
#line 43 "Form.yp"
{Node->new($_[1],'number')}
	],
	[#Rule 22
		 'ellipsis', 1,
sub
#line 46 "Form.yp"
{Node->new($_[1],'ellipsis')}
	],
	[#Rule 23
		 'equal', 3,
sub
#line 49 "Form.yp"
{Node->new($_[2],'equal',$_[1],$_[3])}
	],
	[#Rule 24
		 'sum', 2,
sub
#line 53 "Form.yp"
{Node->new($_[1],'sum',$_[2])}
	],
	[#Rule 25
		 'sum', 3,
sub
#line 54 "Form.yp"
{Node->new($_[2],'sum',$_[1],$_[3])}
	],
	[#Rule 26
		 'diff', 2,
sub
#line 57 "Form.yp"
{Node->new($_[1],'diff',$_[2])}
	],
	[#Rule 27
		 'diff', 3,
sub
#line 58 "Form.yp"
{Node->new($_[2],'diff',$_[1],$_[3])}
	],
	[#Rule 28
		 'product', 3,
sub
#line 61 "Form.yp"
{Node->new($_[2],'product',$_[1],$_[3])}
	],
	[#Rule 29
		 'quot', 3,
sub
#line 64 "Form.yp"
{Node->new($_[2],'quot',$_[1],$_[3])}
	],
	[#Rule 30
		 'exp', 3,
sub
#line 67 "Form.yp"
{Node->new($_[2],'exp',$_[1],$_[3])}
	],
	[#Rule 31
		 'sp', 3,
sub
#line 70 "Form.yp"
{Node->new($_[2],'sp',$_[1],$_[3])}
	],
	[#Rule 32
		 'bracket', 3,
sub
#line 73 "Form.yp"
{Node->new($_[1],'bracket',$_[2])}
	],
	[#Rule 33
		 'abracket', 3,
sub
#line 76 "Form.yp"
{Node->new($_[1],'angular_bracket',$_[2])}
	],
	[#Rule 34
		 'function', 3,
sub
#line 81 "Form.yp"
{Node->new($_[1],'function')}
	],
	[#Rule 35
		 'function', 4,
sub
#line 82 "Form.yp"
{Node->new($_[1],'function',$_[3])}
	],
	[#Rule 36
		 'function', 4,
sub
#line 83 "Form.yp"
{Node->new($_[1],'function',$_[3])}
	],
	[#Rule 37
		 'function', 4,
sub
#line 84 "Form.yp"
{Node->new($_[1],'function',$_[3])}
	],
	[#Rule 38
		 'list', 2,
sub
#line 91 "Form.yp"
{Node->new($_[1],'list')}
	],
	[#Rule 39
		 'list', 3,
sub
#line 92 "Form.yp"
{Node->new($_[1],'list',$_[2])}
	],
	[#Rule 40
		 'list', 3,
sub
#line 93 "Form.yp"
{Node->new($_[1],'list',$_[2])}
	],
	[#Rule 41
		 'fsequence', 2,
sub
#line 112 "Form.yp"
{
	       	    my $zero=Node->new('0','number');
	       	    Node->new($_[1],'sequence',$zero,$_[2])
	   	    }
	],
	[#Rule 42
		 'fsequence', 3,
sub
#line 116 "Form.yp"
{Node->new($_[2],'sequence',$_[1],$_[3])}
	],
	[#Rule 43
		 'fsequence', 2,
sub
#line 117 "Form.yp"
{
	   	       	   my $zero=Node->new('0','number');
	     	 	   Node->new($_[1],'sequence',$zero,$_[2])
	     		   }
	],
	[#Rule 44
		 'fsequence', 3,
sub
#line 121 "Form.yp"
{Node->new($_[2],'sequence',$_[1],$_[3])}
	],
	[#Rule 45
		 'lsequence', 3,
sub
#line 133 "Form.yp"
{Node->new($_[2],'sequence',$_[1],$_[3])}
	],
	[#Rule 46
		 'lsequence', 3,
sub
#line 134 "Form.yp"
{Node->new($_[2],'sequence',$_[1],$_[3])}
	],
	[#Rule 47
		 'spattern', 2,
sub
#line 137 "Form.yp"
{Node->new($_[2],'single_pattern',$_[1])}
	],
	[#Rule 48
		 'mpattern', 2,
sub
#line 140 "Form.yp"
{Node->new($_[1],'multi_pattern',$_[2])}
	],
	[#Rule 49
		 'index', 4,
sub
#line 146 "Form.yp"
{Node->new('[','index',$_[1],$_[3])}
	],
	[#Rule 50
		 'coefficient', 4,
sub
#line 148 "Form.yp"
{Node->new('[','coefficient',$_[1],$_[3])}
	],
	[#Rule 51
		 'not', 2,
sub
#line 152 "Form.yp"
{Node->new('!','not',$_[2])}
	],
	[#Rule 52
		 'cpattern', 2,
sub
#line 156 "Form.yp"
{Node->new('','cond_pattern',$_[1], $_[2])}
	],
	[#Rule 53
		 'cpattern', 2,
sub
#line 157 "Form.yp"
{Node->new('','cond_pattern',$_[1], $_[2])}
	],
	[#Rule 54
		 'cpattern', 2,
sub
#line 158 "Form.yp"
{Node->new('','cond_pattern',$_[1], $_[2])}
	]
],
                                  @_);
    bless($self,$class);
}

#line 161 "Form.yp"


my %pair=(
    '[' => ']',
    "{" => "}"
);


#find the matching closing bracket for $_[1] in $_[0]
sub find_matching_bracket{
    my $text=shift;
    my $pos = shift;
    defined $pos or $pos=0;
    my $bracket=substr($text,$pos,1);
    my $anti_bracket=$pair{$bracket};
    defined $anti_bracket or die "'$bracket' is not a bracket";
    my $count=1;
    for(++$pos;$pos<length($text);++$pos){
    	   if(substr($text,$pos,1) eq $bracket){++$count; }
    	   elsif(substr($text,$pos,1) eq $anti_bracket){--$count; }
	   $count or last;
    }
    return undef if $pos==length($text);
    return $pos;   
}

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
    #TODO: convert to internal format (i.g. d_ -> delta)
    for ($parser->YYData->{INPUT}) {
	return('NUMBER',$1) if s/^(\d+)//; 
	if(s/^([[:alpha:]][[:alnum:]]*_?)//){
#	   return $special_sym{$1} if defined $special_sym{$1};
	   return ('SYMBOL',$1);
	}
	# TODO:
	# form symbols don't work atm, it is difficult to
	# distinguish them from indices
	# if(/^([\['`])/){
	# 	  my $end=find_matching_bracket($_,$1);
	# 	  defined $end or die "Unmatched bracket";
	# 	  my $symbol=substr($_,0,$end+1);
	# 	  substr($_,0,$end+1)='';
	# 	  return('SYMBOL',$symbol);
	# }
	return('ELLIPSIS',$1) if s/^(\.{3})//;
        return($1,$1) if s/^(.)//s;
    }
}

sub parse {
    my $self=shift;
    my $data=shift;
    for ($data){
    # we have to do some nasty things to emulate form treatment of
    # whitespace vs. ,
      	
	# in curly brackets, simply treat whitespace as a ','
	# and eliminate superfluous ','
	for(my $pos=0;($pos=index($_,'{',$pos))>-1;++$pos){
	    my $end;
	    $end=find_matching_bracket($_,$pos) 
		or die "Unmatched opening bracket '(' HERE >>".substr($_,$pos-2,5)."<<HERE";
	    substr($_,$pos+1,$end-$pos-1) =~ s/[\s,]+/,/g;
	    $end=find_matching_bracket($_,$pos) 
	    	or die "Internal error";
	    substr($_,$pos+1,$end-$pos-1) =~ s/(^,|,$)//g
	}
	s/\s+//g;
	print;
	$self->YYData->{INPUT} = $_
    }
    $self->YYParse( yylex => \&_lexer, yyerror => \&_error );
}


1;
