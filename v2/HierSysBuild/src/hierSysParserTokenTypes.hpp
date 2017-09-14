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
		SHIFTREG = 13,
		PIPE = 14,
		SIGNAL = 15,
		UINTEGER = 16,
		DEPTH = 17,
		INSTANCE = 18,
		COLON = 19,
		IMPLIES = 20,
		LIFO = 21,
		UINT = 22,
		LESS = 23,
		GREATER = 24,
		THREAD = 25,
		DEFAULT = 26,
		NOW = 27,
		TICK = 28,
		STRING = 29,
		VARIABLE = 30,
		CONSTANT = 31,
		ASSIGNEQUAL = 32,
		SPLIT = 33,
		LPAREN = 34,
		RPAREN = 35,
		NuLL = 36,
		GOTO = 37,
		LOG = 38,
		IF = 39,
		ELSE = 40,
		BINARY = 41,
		HEXADECIMAL = 42,
		COMMA = 43,
		REQ = 44,
		ACK = 45,
		LBRACKET = 46,
		RBRACKET = 47,
		SLICE = 48,
		MUX = 49,
		NOT = 50,
		OR = 51,
		AND = 52,
		NOR = 53,
		NAND = 54,
		XOR = 55,
		XNOR = 56,
		SHL = 57,
		SHR = 58,
		ROL = 59,
		ROR = 60,
		PLUS = 61,
		MINUS = 62,
		MUL = 63,
		DIV = 64,
		EQUAL = 65,
		NOTEQUAL = 66,
		LESSEQUAL = 67,
		GREATEREQUAL = 68,
		INTEGER = 69,
		UNSIGNED = 70,
		SIGNED = 71,
		ARRAY = 72,
		OF = 73,
		PARAMETER = 74,
		HEXCSTYLEINTEGER = 75,
		POWER = 76,
		CONCAT = 77,
		EMIT = 78,
		WHITESPACE = 79,
		SINGLELINECOMMENT = 80,
		ALPHA = 81,
		DIGIT = 82,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
