####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package Mathematica;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
use Parse::Yapp::Driver;

#line 8 "Mathematica.yp"

#use Data::Dump;
my %special_symbols=(
   'Pi' => 'pi',
   'E' => 'e',
   'I' => 'i'
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
			'INC' => 18,
			"+" => 6,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			'pattern' => 22,
			"(" => 21,
			"!" => 10,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		DEFAULT => -1,
		GOTOS => {
			'symbol' => 16,
			'assignment' => 17,
			'input' => 5,
			'number' => 4,
			'function' => 3,
			'string' => 7,
			'bracket' => 20,
			'term' => 9,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 1
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			'INC' => 18,
			"+" => 6,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			'pattern' => 22,
			"(" => 21,
			"!" => 10,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'assignment' => 17,
			'number' => 4,
			'function' => 3,
			'string' => 7,
			'bracket' => 20,
			'term' => 25,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 2
		DEFAULT => -14
	},
	{#State 3
		DEFAULT => -10
	},
	{#State 4
		ACTIONS => {
			'EXP' => 26,
			"´" => 27
		},
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			'' => 28
		}
	},
	{#State 6
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			'INC' => 18,
			"+" => 6,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			'pattern' => 22,
			"(" => 21,
			"!" => 10,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'assignment' => 17,
			'number' => 4,
			'function' => 3,
			'string' => 7,
			'bracket' => 20,
			'term' => 29,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 7
		DEFAULT => -5
	},
	{#State 8
		DEFAULT => -17
	},
	{#State 9
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			";" => 59,
			"+" => 60,
			'REP' => 61,
			'CAT' => 63,
			'RULE' => 62,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'OVERSCRIPT' => 69,
			'PUT' => 68,
			"\\" => 70
		},
		DEFAULT => -2
	},
	{#State 10
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 71,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 11
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 72,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 12
		DEFAULT => -8
	},
	{#State 13
		DEFAULT => -15
	},
	{#State 14
		DEFAULT => -12
	},
	{#State 15
		DEFAULT => -13
	},
	{#State 16
		ACTIONS => {
			":" => 73,
			'PATTERN' => 74
		},
		DEFAULT => -3
	},
	{#State 17
		DEFAULT => -6
	},
	{#State 18
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 75,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 19
		ACTIONS => {
			"}" => 76,
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			'pattern' => 22,
			"!" => 10,
			"(" => 21,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'sequence' => 77,
			'string' => 7,
			'bracket' => 20,
			'term' => 78,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 20
		DEFAULT => -9
	},
	{#State 21
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 79,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 22
		ACTIONS => {
			":" => 80
		}
	},
	{#State 23
		DEFAULT => -11
	},
	{#State 24
		DEFAULT => -7
	},
	{#State 25
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -42
	},
	{#State 26
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 81,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 27
		ACTIONS => {
			'NUMBER' => 13
		},
		GOTOS => {
			'number' => 82
		}
	},
	{#State 28
		DEFAULT => 0
	},
	{#State 29
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -41
	},
	{#State 30
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 83,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 31
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 84,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 32
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 85,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 33
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 86,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 34
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 87,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 35
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 88,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 36
		ACTIONS => {
			'STRING' => 8
		},
		GOTOS => {
			'string' => 89
		}
	},
	{#State 37
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 90,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 38
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 91,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 39
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'sequence' => 92,
			'string' => 7,
			'bracket' => 20,
			'term' => 93,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 40
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 94,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 41
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 95,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 42
		ACTIONS => {
			"!" => 10,
			'SQRT' => 11,
			'INC' => 18,
			"(" => 21,
			'SYMBOL' => 2,
			'STRING' => 8,
			'NUMBER' => 13,
			"{" => 19,
			'index' => 23,
			'pattern' => 22
		},
		DEFAULT => -49,
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 96,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 43
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 97,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 44
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'sequence' => 98,
			'string' => 7,
			'bracket' => 20,
			'term' => 99,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 45
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 100,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 46
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 101,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 47
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 102,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 48
		DEFAULT => -52
	},
	{#State 49
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 103,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 50
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 104,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 51
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 105,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 52
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 106,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 53
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 107,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 54
		DEFAULT => -48
	},
	{#State 55
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 108,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 56
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 109,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 57
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 110,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 58
		DEFAULT => -50
	},
	{#State 59
		ACTIONS => {
			"-" => 1,
			"!" => 10,
			'SQRT' => 11,
			'INC' => 18,
			"(" => 21,
			'SYMBOL' => 2,
			"+" => 6,
			'STRING' => 8,
			'NUMBER' => 13,
			"{" => 19,
			'index' => 23,
			'pattern' => 22
		},
		DEFAULT => -29,
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 111,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 60
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 112,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 61
		DEFAULT => -60
	},
	{#State 62
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 113,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 63
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 114,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 64
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 115,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 65
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 116,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 66
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 117,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 67
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 118,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 68
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 119,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 69
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 120,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 70
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 121,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 71
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"+" => 60,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -63
	},
	{#State 72
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			"\'" => 54,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -45
	},
	{#State 73
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 122,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 74
		DEFAULT => -18
	},
	{#State 75
		ACTIONS => {
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'UNDERSCRIPT' => 56,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -53
	},
	{#State 76
		DEFAULT => -73
	},
	{#State 77
		ACTIONS => {
			"}" => 123
		}
	},
	{#State 78
		ACTIONS => {
			"}" => 124,
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			"," => 125,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		}
	},
	{#State 79
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			")" => 126,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		}
	},
	{#State 80
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 127,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 81
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			"\'" => 54,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -64
	},
	{#State 82
		ACTIONS => {
			"´" => undef
		},
		DEFAULT => -16
	},
	{#State 83
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -40
	},
	{#State 84
		ACTIONS => {
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -36
	},
	{#State 85
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -19
	},
	{#State 86
		ACTIONS => {
			"\@" => 33,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'UNDERSCRIPT' => 56,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -71
	},
	{#State 87
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'UNDERSCRIPT' => 56,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -51
	},
	{#State 88
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 128,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		}
	},
	{#State 89
		DEFAULT => -58
	},
	{#State 90
		ACTIONS => {
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'GET' => 45,
			'UNDERSCRIPT' => 56,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -55
	},
	{#State 91
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"+" => 60,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -34
	},
	{#State 92
		ACTIONS => {
			'PARTC' => 129
		}
	},
	{#State 93
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'PARTC' => 130,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			"," => 125,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		}
	},
	{#State 94
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"+" => 60,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -25
	},
	{#State 95
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			"\'" => 54,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -47
	},
	{#State 96
		ACTIONS => {
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -38
	},
	{#State 97
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'CAT' => 63,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -26
	},
	{#State 98
		ACTIONS => {
			"]" => 131
		}
	},
	{#State 99
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			"]" => 132,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			"," => 125,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		}
	},
	{#State 100
		ACTIONS => {
			'MESSAGENAME' => 36,
			'GET' => undef
		},
		DEFAULT => -24
	},
	{#State 101
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"+" => 60,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -27
	},
	{#State 102
		ACTIONS => {
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -37
	},
	{#State 103
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -31
	},
	{#State 104
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -20
	},
	{#State 105
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			"\'" => 54,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -44
	},
	{#State 106
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"+" => 60,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -62
	},
	{#State 107
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -59
	},
	{#State 108
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"+" => 60,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -61
	},
	{#State 109
		ACTIONS => {
			'MESSAGENAME' => 36,
			'GET' => 45,
			'UNDERSCRIPT' => 56,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -56
	},
	{#State 110
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -43
	},
	{#State 111
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -28
	},
	{#State 112
		ACTIONS => {
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -35
	},
	{#State 113
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -32
	},
	{#State 114
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -33
	},
	{#State 115
		ACTIONS => {
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			"\'" => 54,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -46
	},
	{#State 116
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			"?" => 66,
			"&" => 67,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -70
	},
	{#State 117
		ACTIONS => {
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'GET' => 45,
			'UNDERSCRIPT' => 56,
			"?" => undef,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -54
	},
	{#State 118
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			"?" => 66,
			"&" => undef,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -30
	},
	{#State 119
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -21
	},
	{#State 120
		ACTIONS => {
			'MESSAGENAME' => 36,
			'GET' => 45,
			'UNDERSCRIPT' => 56,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -57
	},
	{#State 121
		ACTIONS => {
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'FAC' => 58,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -39
	},
	{#State 122
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -22
	},
	{#State 123
		DEFAULT => -75
	},
	{#State 124
		DEFAULT => -74
	},
	{#State 125
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'sequence' => 133,
			'string' => 7,
			'bracket' => 20,
			'term' => 134,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 126
		DEFAULT => -65
	},
	{#State 127
		ACTIONS => {
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'INC' => 48,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			'REP' => 61,
			"^" => 64,
			"?" => 66,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -23
	},
	{#State 128
		ACTIONS => {
			"-" => 1,
			'SYMBOL' => 2,
			"+" => 6,
			'INC' => 18,
			"{" => 19,
			'STRING' => 8,
			'index' => 23,
			"!" => 10,
			"(" => 21,
			'pattern' => 22,
			'SQRT' => 11,
			'NUMBER' => 13
		},
		GOTOS => {
			'symbol' => 16,
			'number' => 4,
			'function' => 3,
			'assignment' => 17,
			'string' => 7,
			'bracket' => 20,
			'term' => 135,
			'relation' => 24,
			'operation' => 12,
			'wildcard' => 14,
			'list' => 15
		}
	},
	{#State 129
		DEFAULT => -67
	},
	{#State 130
		DEFAULT => -66
	},
	{#State 131
		DEFAULT => -69
	},
	{#State 132
		DEFAULT => -68
	},
	{#State 133
		DEFAULT => -77
	},
	{#State 134
		ACTIONS => {
			'SET' => 32,
			"-" => 31,
			'DIVIDE' => 30,
			'MAPPLY' => 34,
			"\@" => 33,
			"~" => 35,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'SPAN' => 38,
			'PARTO' => 39,
			'SAME' => 40,
			'COND' => 43,
			"*" => 42,
			'STRINGJOIN' => 41,
			'GET' => 45,
			"[" => 44,
			'CMP' => 46,
			"×" => 47,
			'REPL' => 49,
			'INC' => 48,
			'OSET' => 50,
			'NCMULTIPLY' => 51,
			'AND' => 52,
			"|" => 53,
			"\'" => 54,
			"." => 57,
			'UNDERSCRIPT' => 56,
			'OR' => 55,
			'FAC' => 58,
			"+" => 60,
			";" => 59,
			"," => 125,
			'REP' => 61,
			'RULE' => 62,
			'CAT' => 63,
			"^" => 64,
			'POST' => 65,
			"?" => 66,
			"&" => 67,
			'PUT' => 68,
			'OVERSCRIPT' => 69,
			"\\" => 70
		},
		DEFAULT => -76
	},
	{#State 135
		ACTIONS => {
			"\@" => 33,
			'MESSAGENAME' => 36,
			'SUBSCRIPT' => 37,
			'PARTO' => 39,
			'GET' => 45,
			"[" => 44,
			'INC' => 48,
			'UNDERSCRIPT' => 56,
			"?" => 66,
			'OVERSCRIPT' => 69
		},
		DEFAULT => -72
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
		 'symbol', 1,
sub
#line 126 "Mathematica.yp"
{
		my $symbol=$_[1];
		#special characters
		if(defined $special_symbols{$symbol}){
			   $symbol="**$special_symbols{$symbol}**";		
		}
		elsif($symbol =~ /^\\\[(.*)\]$/){
			$symbol=lc $1;
			$symbol =~ s/capital([a-z])/uc($1)/e;
			$symbol = "**$symbol**";
		}
		Expression->new(name =>$symbol,is => 'symbol')
		}
	],
	[#Rule 15
		 'number', 1,
sub
#line 141 "Mathematica.yp"
{Expression->new(name =>$_[1],is => 'number')}
	],
	[#Rule 16
		 'number', 3,
sub
#line 142 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 17
		 'string', 1,
sub
#line 144 "Mathematica.yp"
{Expression->new(name =>$_[1],is => 'string')}
	],
	[#Rule 18
		 'wildcard', 2,
sub
#line 147 "Mathematica.yp"
{
	 my %wildcard=('_' => '?', '___' => '??', '__' => '???');
	 Expression->new(name =>$wildcard{$_[1]},is => 'operator',args => [$_[1]])
	 }
	],
	[#Rule 19
		 'assignment', 3,
sub
#line 152 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 20
		 'assignment', 3,
sub
#line 153 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 21
		 'assignment', 3,
sub
#line 154 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 22
		 'assignment', 3,
sub
#line 155 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 23
		 'assignment', 3,
sub
#line 156 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 24
		 'assignment', 3,
sub
#line 157 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 25
		 'relation', 3,
sub
#line 160 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 26
		 'relation', 3,
sub
#line 161 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 27
		 'relation', 3,
sub
#line 162 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 28
		 'operation', 3,
sub
#line 166 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 29
		 'operation', 2,
sub
#line 167 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1]])}
	],
	[#Rule 30
		 'operation', 3,
sub
#line 168 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 31
		 'operation', 3,
sub
#line 169 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 32
		 'operation', 3,
sub
#line 170 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 33
		 'operation', 3,
sub
#line 171 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 34
		 'operation', 3,
sub
#line 172 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 35
		 'operation', 3,
sub
#line 173 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 36
		 'operation', 3,
sub
#line 174 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 37
		 'operation', 3,
sub
#line 175 "Mathematica.yp"
{Expression->new(name =>'*',is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 38
		 'operation', 3,
sub
#line 176 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 39
		 'operation', 3,
sub
#line 179 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 40
		 'operation', 3,
sub
#line 180 "Mathematica.yp"
{Expression->new(name =>'/',is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 41
		 'operation', 2,
sub
#line 181 "Mathematica.yp"
{$_[2]}
	],
	[#Rule 42
		 'operation', 2,
sub
#line 182 "Mathematica.yp"
{Expression->new(name =>$_[1],is => 'operator',args => [$_[2]])}
	],
	[#Rule 43
		 'operation', 3,
sub
#line 183 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 44
		 'operation', 3,
sub
#line 184 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 45
		 'operation', 2,
sub
#line 185 "Mathematica.yp"
{
		       				my $sqrt=Expression->new(name =>'**Sqrt**',is => 'symbol');
		       				Expression->new(name =>['(',')'],is => 'bracket',args => [$sqrt,$_[2]])
						}
	],
	[#Rule 46
		 'operation', 3,
sub
#line 190 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 47
		 'operation', 3,
sub
#line 192 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 48
		 'operation', 2,
sub
#line 193 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1]])}
	],
	[#Rule 49
		 'operation', 2,
sub
#line 194 "Mathematica.yp"
{
		       		      		my $conj=Expression->new(name =>'**Conjugate**',is => 'symbol');	
		       		      		Expression->new(name =>['(',')'],is => 'bracket',args => [$conj,$_[1]])
						}
	],
	[#Rule 50
		 'operation', 2,
sub
#line 198 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1]])}
	],
	[#Rule 51
		 'operation', 3,
sub
#line 199 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 52
		 'operation', 2,
sub
#line 200 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1]])}
	],
	[#Rule 53
		 'operation', 2,
sub
#line 201 "Mathematica.yp"
{Expression->new(name =>$_[1],is => 'operator',args => [$_[2]])}
	],
	[#Rule 54
		 'operation', 3,
sub
#line 202 "Mathematica.yp"
{
		       		      		my $ptest=Expression->new(name =>'**PatternTest**',is => 'symbol');	
		       	   	    		my $args=Expression->new(name =>',',is => 'operator',args =>[$_[1],$_[3]]);
		       		      		Expression->new(name =>['(',')'],is => 'bracket',args => [$ptest,$args])
						}
	],
	[#Rule 55
		 'operation', 3,
sub
#line 207 "Mathematica.yp"
{
		       		      		my $script=Expression->new(name =>'**Subscript**',is => 'symbol');	
		       	   	    		my $args=Expression->new(name =>',',is => 'operator',args =>[$_[1],$_[3]]);
		       		      		Expression->new(name =>['(',')'],is => 'bracket',args => [$script,$args])
		  		       		}
	],
	[#Rule 56
		 'operation', 3,
sub
#line 213 "Mathematica.yp"
{
		       		      		my $script=Expression->new(name =>'**Overscript**',is => 'symbol');	
		       	   	    		my $args=Expression->new(name =>',',is => 'operator',args =>[$_[1],$_[3]]);
		       		      		Expression->new(name =>['(',')'],is => 'bracket',args => [$script,$args])
		  		       		}
	],
	[#Rule 57
		 'operation', 3,
sub
#line 218 "Mathematica.yp"
{
		       		      		my $script=Expression->new(name =>'**Underscript**',is => 'symbol');	
		       	   	    		my $args=Expression->new(name =>',',is => 'operator',args =>[$_[1],$_[3]]);
		       		      		Expression->new(name =>['(',')'],is => 'bracket',args => [$script,$args])
		  		       		}
	],
	[#Rule 58
		 'operation', 3,
sub
#line 223 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 59
		 'operation', 3,
sub
#line 224 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 60
		 'operation', 2,
sub
#line 225 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1]])}
	],
	[#Rule 61
		 'operation', 3,
sub
#line 226 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 62
		 'operation', 3,
sub
#line 227 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 63
		 'operation', 2,
sub
#line 228 "Mathematica.yp"
{Expression->new(name =>$_[1],is => 'operator',args => [$_[2]])}
	],
	[#Rule 64
		 'operation', 3,
sub
#line 229 "Mathematica.yp"
{
		  	     			my $base=Expression->new(name =>'10',is => 'number');
						my $pow=Expression->new(name =>'^',is => 'operator',args => [$base,$_[3]]);
		  	     			Expression->new(name =>'*',is => 'operator',args => [$_[1],$pow])
						}
	],
	[#Rule 65
		 'bracket', 3,
sub
#line 236 "Mathematica.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[2]])}
	],
	[#Rule 66
		 'bracket', 4,
sub
#line 237 "Mathematica.yp"
{Expression->new(name =>['[',']'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 67
		 'bracket', 4,
sub
#line 238 "Mathematica.yp"
{Expression->new(name =>['[',']'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 68
		 'function', 4,
sub
#line 241 "Mathematica.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 69
		 'function', 4,
sub
#line 242 "Mathematica.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 70
		 'function', 3,
sub
#line 243 "Mathematica.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[3],$_[1]])}
	],
	[#Rule 71
		 'function', 3,
sub
#line 244 "Mathematica.yp"
{Expression->new(name =>['(',')'],is => 'bracket',args => [$_[1],$_[3]])}
	],
	[#Rule 72
		 'function', 5,
sub
#line 245 "Mathematica.yp"
{
		        	   	    		my $args=Expression->new(name =>',',is => 'operator',args =>[$_[1],$_[5]]);
		        	   	    		Expression->new(name =>['(',')'],is => 'bracket',args =>[$_[3],$args])
		 				}
	],
	[#Rule 73
		 'list', 2,
sub
#line 251 "Mathematica.yp"
{Expression->new(name =>['{','}'],is => 'bracket')}
	],
	[#Rule 74
		 'list', 3,
sub
#line 252 "Mathematica.yp"
{Expression->new(name =>['{','}'],is => 'bracket',args => [$_[2]])}
	],
	[#Rule 75
		 'list', 3,
sub
#line 253 "Mathematica.yp"
{Expression->new(name =>['{','}'],is => 'bracket',args => [$_[2]])}
	],
	[#Rule 76
		 'sequence', 3,
sub
#line 256 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	],
	[#Rule 77
		 'sequence', 3,
sub
#line 257 "Mathematica.yp"
{Expression->new(name =>$_[2],is => 'operator',args => [$_[1],$_[3]])}
	]
],
                                  @_);
    bless($self,$class);
}

#line 261 "Mathematica.yp"


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
	return('SYMBOL',$1) if s/^(([[:alpha:]]|\$)([[:alnum:]]|\$)*)//;
	#named characters
	return('SYMBOL',$1) if s/^(\\\[.*?\])//;
	return('STRING',$1) if s/^(".*?[^\\]")//;
	return('FBOX',$1) if s/^(\\´)//;
	return('PUT',$1) if s/^(>{2,3})//;
	return('SET',$1) if s/^(=\.|\^?:?=)//;
	return('POST',$1) if s$^(//)$$;
	return('OSET',$1) if s/^([\/\*\+-]=)//;
	return('REPL',$1) if s$^(/?/\.)$$;
	return('RULE',$1) if s/^([:-]>)//;
	return('COND',$1) if s/^(\/;)//;
	return('CAT',$1) if s/^(~~)//;
	return('REP',$1) if s/^(\.{2,3})//;
	return('OR',$1) if s/^(\|\|)//;
	return('AND',$1) if s/^(&&)//;
	return('CMP',$1) if s/^([<>]=?|[!=]=)//;
	return('SPAN',$1) if s/^(;;)//;
	return('DIVIDE',$1) if s$^(\\?/)$$;
	return('NCMULTIPLY',$1) if s/^(\*\*)//;
	return('SQRT',$1) if s/^(\\@)//;
	return('STRINGJOIN',$1) if s/^(<>)//;
	return('FAC',$1) if s/^(!!?)//;
	return('MAPPLY',$1) if s/^([\/@]@@?)//;
	return('INC',$1) if s/^(\+\+|--)//;
	return('PARTO',$1) if s/^(\[\[)//;
	return('PARTC',$1) if s/^(\]\])//;
	return('SUBSCRIPT',$1) if s/^(\\_)//;
	return('OVERSCRIPT',$1) if s/^(\\&)//;
	return('UNDERSCRIPT',$1) if s/^(\\\+)//;
	return('GET',$1) if s/^(<<)//;
	return('MESSAGENAME',$1) if s/^(::)//;
	return('PATTERN',$1) if s/^(_{1,3})//;
	return('EXP',$1) if s/^(\*\^)//;
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
