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
		LPAREN = 18,
		RPAREN = 19,
		WHITESPACE = 20,
		SINGLELINECOMMENT = 21,
		ALPHA = 22,
		DIGIT = 23,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
