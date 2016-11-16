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
		OUT = 8,
		LBRACE = 9,
		RBRACE = 10,
		NOBLOCK = 11,
		P2P = 12,
		PIPE = 13,
		SIGNAL = 14,
		UINTEGER = 15,
		DEPTH = 16,
		INSTANCE = 17,
		COLON = 18,
		IMPLIES = 19,
		LIFO = 20,
		UINT = 21,
		LESS = 22,
		GREATER = 23,
		THREAD = 24,
		DEFAULT = 25,
		NOW = 26,
		TICK = 27,
		STRING = 28,
		VARIABLE = 29,
		CONSTANT = 30,
		ASSIGNEQUAL = 31,
		SPLIT = 32,
		LPAREN = 33,
		RPAREN = 34,
		NuLL = 35,
		GOTO = 36,
		LOG = 37,
		IF = 38,
		ELSE = 39,
		BINARY = 40,
		HEXADECIMAL = 41,
		COMMA = 42,
		REQ = 43,
		ACK = 44,
		LBRACKET = 45,
		RBRACKET = 46,
		SLICE = 47,
		MUX = 48,
		NOT = 49,
		OR = 50,
		AND = 51,
		NOR = 52,
		NAND = 53,
		XOR = 54,
		XNOR = 55,
		SHL = 56,
		SHR = 57,
		ROL = 58,
		ROR = 59,
		PLUS = 60,
		MINUS = 61,
		MUL = 62,
		DIV = 63,
		EQUAL = 64,
		NOTEQUAL = 65,
		LESSEQUAL = 66,
		GREATEREQUAL = 67,
		INTEGER = 68,
		UNSIGNED = 69,
		SIGNED = 70,
		ARRAY = 71,
		OF = 72,
		PARAMETER = 73,
		HEXCSTYLEINTEGER = 74,
		POWER = 75,
		CONCAT = 76,
		EMIT = 77,
		WHITESPACE = 78,
		SINGLELINECOMMENT = 79,
		ALPHA = 80,
		DIGIT = 81,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
