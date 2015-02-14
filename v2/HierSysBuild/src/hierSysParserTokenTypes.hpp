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
		OUT = 11,
		LBRACE = 12,
		RBRACE = 13,
		INSTANCE = 14,
		COLON = 15,
		IMPLIES = 16,
		LPAREN = 17,
		RPAREN = 18,
		WHITESPACE = 19,
		SINGLELINECOMMENT = 20,
		ALPHA = 21,
		DIGIT = 22,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
