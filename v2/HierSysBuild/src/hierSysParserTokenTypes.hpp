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
		INPIPE = 7,
		UINTEGER = 8,
		OUTPIPE = 9,
		LBRACE = 10,
		INTERNALPIPE = 11,
		RBRACE = 12,
		INSTANCE = 13,
		IMPLIES = 14,
		WHITESPACE = 15,
		SINGLELINECOMMENT = 16,
		ALPHA = 17,
		DIGIT = 18,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_hierSysParserTokenTypes_hpp_*/
