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
		DEFTHREAD = 15,
		DEFPARAMETER = 16,
		THREADINSTANCE = 17,
		COLON = 18,
		PARAMETER = 19,
		IMPLIES = 20,
		INSTANCE = 21,
		LIFO = 22,
		UINT = 23,
		LESS_THAN = 24,
		GREATER_THAN = 25,
		LPAREN = 26,
		RPAREN = 27,
		PORT = 28,
		SYNCH = 29,
		WHITESPACE = 30,
		SINGLELINECOMMENT = 31,
		ALPHA = 32,
		DIGIT = 33,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
