#ifndef INC_hierSysParserTokenTypes_hpp_
#define INC_hierSysParserTokenTypes_hpp_

/* $ANTLR 2.7.7 (2006-11-01): "hierSys.g" -> "hierSysParserTokenTypes.hpp"$ */

#ifndef CUSTOM_API
# define CUSTOM_API
#endif

#ifdef __cplusplus
struct CUSTOM_API hierSysParserTokenTypes {
#endif
	enum {
		EOF_ = 1,
		SYSTEM = 4,
		SIMPLE_IDENTIFIER = 5,
		LIBRARY = 6,
		IN = 7,
		PIPE = 8,
		SIGNAL = 9,
		UINTEGER = 10,
		DEPTH = 11,
		OUT = 12,
		LBRACE = 13,
		RBRACE = 14,
		INSTANCE = 15,
		COLON = 16,
		IMPLIES = 17,
		LIFO = 18,
		UINT = 19,
		LESS = 20,
		GREATER = 21,
		THREAD = 22,
		GROUP = 23,
		LPAREN = 24,
		RPAREN = 25,
		STRING = 26,
		VARIABLE = 27,
		CONSTANT = 28,
		ASSIGNEQUAL = 29,
		VOLATILE = 30,
		EMIT = 31,
		NuLL = 32,
		GOTO = 33,
		IF = 34,
		ELSE = 35,
		BINARY = 36,
		HEXADECIMAL = 37,
		COMMA = 38,
		LBRACKET = 39,
		RBRACKET = 40,
		SLICE = 41,
		MUX = 42,
		NOT = 43,
		OR = 44,
		AND = 45,
		NOR = 46,
		NAND = 47,
		XOR = 48,
		XNOR = 49,
		SHL = 50,
		SHR = 51,
		ROL = 52,
		ROR = 53,
		PLUS = 54,
		MINUS = 55,
		MUL = 56,
		DIV = 57,
		EQUAL = 58,
		NOTEQUAL = 59,
		LESSEQUAL = 60,
		GREATEREQUAL = 61,
		CONCAT = 62,
		INTEGER = 63,
		UNSIGNED = 64,
		SIGNED = 65,
		ARRAY = 66,
		OF = 67,
		WHITESPACE = 68,
		SINGLELINECOMMENT = 69,
		ALPHA = 70,
		DIGIT = 71,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
