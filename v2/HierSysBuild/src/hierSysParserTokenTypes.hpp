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
		LOG = 31,
		IF = 32,
		ELSE = 33,
		LPAREN = 34,
		RPAREN = 35,
		BINARY = 36,
		HEXADECIMAL = 37,
		COMMA = 38,
		REQ = 39,
		ACK = 40,
		LBRACKET = 41,
		RBRACKET = 42,
		SLICE = 43,
		MUX = 44,
		NOT = 45,
		OR = 46,
		AND = 47,
		NOR = 48,
		NAND = 49,
		XOR = 50,
		XNOR = 51,
		SHL = 52,
		SHR = 53,
		ROL = 54,
		ROR = 55,
		PLUS = 56,
		MINUS = 57,
		MUL = 58,
		DIV = 59,
		EQUAL = 60,
		NOTEQUAL = 61,
		LESSEQUAL = 62,
		GREATEREQUAL = 63,
		CONCAT = 64,
		INTEGER = 65,
		UNSIGNED = 66,
		SIGNED = 67,
		ARRAY = 68,
		OF = 69,
		GROUP = 70,
		EMIT = 71,
		WHITESPACE = 72,
		SINGLELINECOMMENT = 73,
		ALPHA = 74,
		DIGIT = 75,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
