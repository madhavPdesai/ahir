#ifndef INC_vcParserTokenTypes_hpp_
#define INC_vcParserTokenTypes_hpp_

/* $ANTLR 2.7.7 (2006-11-01): "vc.g" -> "vcParserTokenTypes.hpp"$ */

#ifndef CUSTOM_API
# define CUSTOM_API
#endif

#ifdef __cplusplus
struct CUSTOM_API vcParserTokenTypes {
#endif
	enum {
		EOF_ = 1,
		LIBRARY = 4,
		LBRACE = 5,
		RBRACE = 6,
		DPE = 7,
		PARAMETER = 8,
		LPAREN = 9,
		UINTEGER = 10,
		RPAREN = 11,
		IN = 12,
		OUT = 13,
		COLON = 14,
		TEMPLATE = 15,
		FLOAT = 16,
		LESS = 17,
		SIMPLE_IDENTIFIER = 18,
		GREATER = 19,
		INT = 20,
		REQS = 21,
		ACKS = 22,
		MEMORYSPACE = 23,
		CAPACITY = 24,
		DATAWIDTH = 25,
		ADDRWIDTH = 26,
		OBJECT = 27,
		ASSIGNEQUAL = 28,
		MODULE = 29,
		LINK = 30,
		IMPLIES = 31,
		CONTROLPATH = 32,
		PLACE = 33,
		TRANSITION = 34,
		HIDDEN = 35,
		SERIESBLOCK = 36,
		PARALLELBLOCK = 37,
		BRANCHBLOCK = 38,
		AT = 39,
		MERGE = 40,
		ENTRY = 41,
		FROM = 42,
		BRANCH = 43,
		EXIT = 44,
		FORKBLOCK = 45,
		JOIN = 46,
		FORK = 47,
		DATAPATH = 48,
		DPEINSTANCE = 49,
		OF = 50,
		MAP = 51,
		PORT = 52,
		LBRACKET = 53,
		RBRACKET = 54,
		WIRE = 55,
		COMMA = 56,
		BINARYSTRING = 57,
		HEXSTRING = 58,
		MINUS = 59,
		LITERAL_C = 60,
		LITERAL_M = 61,
		POINTER = 62,
		HIERARCHICAL_IDENTIFIER = 63,
		ARRAY = 64,
		RECORD = 65,
		ATTRIBUTE = 66,
		QUOTED_STRING = 67,
		MIN = 68,
		MAX = 69,
		WHITESPACE = 70,
		SINGLELINECOMMENT = 71,
		ALPHA = 72,
		DIGIT = 73,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_vcParserTokenTypes_hpp_*/
