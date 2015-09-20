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
		STRING = 23,
		LPAREN = 24,
		RPAREN = 25,
		VARIABLE = 26,
		CONSTANT = 27,
		ASSIGNEQUAL = 28,
		VOLATILE = 29,
		EMIT = 30,
		NuLL = 31,
		GOTO = 32,
		IF = 33,
		ELSE = 34,
		BINARY = 35,
		HEXADECIMAL = 36,
		COMMA = 37,
		LBRACKET = 38,
		RBRACKET = 39,
		SLICE = 40,
		MUX = 41,
		NOT = 42,
		OR = 43,
		AND = 44,
		NOR = 45,
		NAND = 46,
		XOR = 47,
		XNOR = 48,
		SHL = 49,
		SHR = 50,
		ROL = 51,
		ROR = 52,
		PLUS = 53,
		MINUS = 54,
		MUL = 55,
		DIV = 56,
		EQUAL = 57,
		NOTEQUAL = 58,
		LESSEQUAL = 59,
		GREATEREQUAL = 60,
		CONCAT = 61,
		INTEGER = 62,
		UNSIGNED = 63,
		SIGNED = 64,
		ARRAY = 65,
		OF = 66,
		WHITESPACE = 67,
		SINGLELINECOMMENT = 68,
		ALPHA = 69,
		DIGIT = 70,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
