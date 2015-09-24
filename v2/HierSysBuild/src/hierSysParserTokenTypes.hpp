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
		DEFAULT = 23,
		STRING = 24,
		VARIABLE = 25,
		CONSTANT = 26,
		ASSIGNEQUAL = 27,
		NOW = 28,
		NuLL = 29,
		GOTO = 30,
		IF = 31,
		ELSE = 32,
		LPAREN = 33,
		RPAREN = 34,
		BINARY = 35,
		HEXADECIMAL = 36,
		COMMA = 37,
		REQ = 38,
		ACK = 39,
		LBRACKET = 40,
		RBRACKET = 41,
		SLICE = 42,
		MUX = 43,
		NOT = 44,
		OR = 45,
		AND = 46,
		NOR = 47,
		NAND = 48,
		XOR = 49,
		XNOR = 50,
		SHL = 51,
		SHR = 52,
		ROL = 53,
		ROR = 54,
		PLUS = 55,
		MINUS = 56,
		MUL = 57,
		DIV = 58,
		EQUAL = 59,
		NOTEQUAL = 60,
		LESSEQUAL = 61,
		GREATEREQUAL = 62,
		CONCAT = 63,
		INTEGER = 64,
		UNSIGNED = 65,
		SIGNED = 66,
		ARRAY = 67,
		OF = 68,
		GROUP = 69,
		EMIT = 70,
		WHITESPACE = 71,
		SINGLELINECOMMENT = 72,
		ALPHA = 73,
		DIGIT = 74,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
