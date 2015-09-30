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
		NOW = 24,
		TICK = 25,
		STRING = 26,
		VARIABLE = 27,
		CONSTANT = 28,
		ASSIGNEQUAL = 29,
		NuLL = 30,
		GOTO = 31,
		LOG = 32,
		IF = 33,
		ELSE = 34,
		LPAREN = 35,
		RPAREN = 36,
		BINARY = 37,
		HEXADECIMAL = 38,
		COMMA = 39,
		REQ = 40,
		ACK = 41,
		LBRACKET = 42,
		RBRACKET = 43,
		SLICE = 44,
		MUX = 45,
		NOT = 46,
		OR = 47,
		AND = 48,
		NOR = 49,
		NAND = 50,
		XOR = 51,
		XNOR = 52,
		SHL = 53,
		SHR = 54,
		ROL = 55,
		ROR = 56,
		PLUS = 57,
		MINUS = 58,
		MUL = 59,
		DIV = 60,
		EQUAL = 61,
		NOTEQUAL = 62,
		LESSEQUAL = 63,
		GREATEREQUAL = 64,
		CONCAT = 65,
		INTEGER = 66,
		UNSIGNED = 67,
		SIGNED = 68,
		ARRAY = 69,
		OF = 70,
		GROUP = 71,
		EMIT = 72,
		WHITESPACE = 73,
		SINGLELINECOMMENT = 74,
		ALPHA = 75,
		DIGIT = 76,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
