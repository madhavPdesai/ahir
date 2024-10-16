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
		GATED_CLOCK = 4,
		SIMPLE_IDENTIFIER = 5,
		LIFO = 6,
		NOBLOCK = 7,
		SHIFTREG = 8,
		PIPE = 9,
		UINTEGER = 10,
		DEPTH = 11,
		IN = 12,
		OUT = 13,
		SIGNAL = 14,
		P2P = 15,
		FULLRATE = 16,
		BYPASS = 17,
		MEMORYSPACE = 18,
		UNORDERED = 19,
		LBRACE = 20,
		RBRACE = 21,
		CAPACITY = 22,
		DATAWIDTH = 23,
		ADDRWIDTH = 24,
		MAXACCESSWIDTH = 25,
		OBJECT = 26,
		COLON = 27,
		USE_GATED_CLOCK = 28,
		FOREIGN = 29,
		PIPELINE = 30,
		BUFFERING = 31,
		DETERMINISTIC = 32,
		OPERATOR = 33,
		VOLATILE = 34,
		USEONCE = 35,
		MODULE = 36,
		EQUIVALENT = 37,
		LPAREN = 38,
		RPAREN = 39,
		OPEN = 40,
		DIV_OP = 41,
		ENTRY = 42,
		EXIT = 43,
		CONTROLPATH = 44,
		ALIAS = 45,
		PLACE = 46,
		LEFT_OPEN = 47,
		TRANSITION = 48,
		DEAD = 49,
		TIED_HIGH = 50,
		DELAY = 51,
		SERIESBLOCK = 52,
		PARALLELBLOCK = 53,
		BRANCHBLOCK = 54,
		LOOPBLOCK = 55,
		TERMINATE = 56,
		PHISEQUENCER = 57,
		TRANSITIONMERGE = 58,
		BIND = 59,
		IMPLIES = 60,
		ULE_OP = 61,
		MERGE = 62,
		BRANCH = 63,
		FORKBLOCK = 64,
		PIPELINEDFORKBLOCK = 65,
		N_ULL = 66,
		JOIN = 67,
		MARKEDJOIN = 68,
		SCC_ARC = 69,
		FORK = 70,
		DATAPATH = 71,
		WAR = 72,
		GUARD = 73,
		NOT_OP = 74,
		FLOWTHROUGH = 75,
		PLUS_OP = 76,
		MINUS_OP = 77,
		MUL_OP = 78,
		SHL_OP = 79,
		SHR_OP = 80,
		ROL_OP = 81,
		ROR_OP = 82,
		UGT_OP = 83,
		UGE_OP = 84,
		EQ_OP = 85,
		ULT_OP = 86,
		NEQ_OP = 87,
		BITSEL_OP = 88,
		CONCAT_OP = 89,
		UNORDERED_OP = 90,
		OR_OP = 91,
		AND_OP = 92,
		XOR_OP = 93,
		NOR_OP = 94,
		NAND_OP = 95,
		XNOR_OP = 96,
		SHRA_OP = 97,
		SGT_OP = 98,
		SGE_OP = 99,
		SLT_OP = 100,
		SLE_OP = 101,
		StoS_ASSIGN_OP = 102,
		StoU_ASSIGN_OP = 103,
		UtoS_ASSIGN_OP = 104,
		FtoS_ASSIGN_OP = 105,
		FtoU_ASSIGN_OP = 106,
		StoF_ASSIGN_OP = 107,
		UtoF_ASSIGN_OP = 108,
		FtoF_ASSIGN_OP = 109,
		DECODE_OP = 110,
		ENCODE_OP = 111,
		P_ENCODE_OP = 112,
		BITREDUCE_OR_OP = 113,
		BITREDUCE_AND_OP = 114,
		BITREDUCE_XOR_OP = 115,
		BRANCH_OP = 116,
		SELECT_OP = 117,
		SLICE_OP = 118,
		PERMUTE_OP = 119,
		ASSIGN_OP = 120,
		HASH = 121,
		CUT_THROUGH = 122,
		IN_PHI = 123,
		EQUIVALENCE_OP = 124,
		CALL = 125,
		INLINE = 126,
		IOPORT = 127,
		BARRIER = 128,
		LOAD = 129,
		FROM = 130,
		STORE = 131,
		TO = 132,
		PHI = 133,
		LBRACKET = 134,
		RBRACKET = 135,
		CONSTANT = 136,
		INTERMEDIATE = 137,
		WIRE = 138,
		BINARYSTRING = 139,
		HEXSTRING = 140,
		COMMA = 141,
		INT = 142,
		FLOAT = 143,
		POINTER = 144,
		ARRAY = 145,
		OF = 146,
		RECORD = 147,
		SIMPLE_IDENTIFER = 148,
		ATTRIBUTE = 149,
		QUOTED_STRING = 150,
		DPE = 151,
		LIBRARY = 152,
		REQS = 153,
		ACKS = 154,
		HIDDEN = 155,
		PARAMETER = 156,
		PORT = 157,
		MAP = 158,
		MIN = 159,
		MAX = 160,
		DPEINSTANCE = 161,
		LINK = 162,
		AT = 163,
		ORDERED_OP = 164,
		WHITESPACE = 165,
		SINGLELINECOMMENT = 166,
		ALPHA = 167,
		DIGIT = 168,
		NULL_TREE_LOOKAHEAD = 3
	};
#ifdef __cplusplus
};
#endif
#endif /*INC_vcParserTokenTypes_hpp_*/
