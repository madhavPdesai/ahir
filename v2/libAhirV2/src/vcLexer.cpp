/* $ANTLR 2.7.7 (2006-11-01): "vc.g" -> "vcLexer.cpp"$ */
#include "vcLexer.hpp"
#include <antlr/CharBuffer.hpp>
#include <antlr/TokenStreamException.hpp>
#include <antlr/TokenStreamIOException.hpp>
#include <antlr/TokenStreamRecognitionException.hpp>
#include <antlr/CharStreamException.hpp>
#include <antlr/CharStreamIOException.hpp>
#include <antlr/NoViableAltForCharException.hpp>

#line 10 "vc.g"


#line 15 "vcLexer.cpp"
#line 1 "vc.g"
#line 17 "vcLexer.cpp"
vcLexer::vcLexer(ANTLR_USE_NAMESPACE(std)istream& in)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(new ANTLR_USE_NAMESPACE(antlr)CharBuffer(in),true)
{
	initLiterals();
}

vcLexer::vcLexer(ANTLR_USE_NAMESPACE(antlr)InputBuffer& ib)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(ib,true)
{
	initLiterals();
}

vcLexer::vcLexer(const ANTLR_USE_NAMESPACE(antlr)LexerSharedInputState& state)
	: ANTLR_USE_NAMESPACE(antlr)CharScanner(state,true)
{
	initLiterals();
}

void vcLexer::initLiterals()
{
}

ANTLR_USE_NAMESPACE(antlr)RefToken vcLexer::nextToken()
{
	ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
	for (;;) {
		ANTLR_USE_NAMESPACE(antlr)RefToken theRetToken;
		int _ttype = ANTLR_USE_NAMESPACE(antlr)Token::INVALID_TYPE;
		resetText();
		try {   // for lexical and char stream error handling
			switch ( LA(1)) {
			case 0x3b /* ';' */ :
			{
				mSERIESBLOCK(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2c /* ',' */ :
			{
				mCOMMA(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7b /* '{' */ :
			{
				mLBRACE(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x7d /* '}' */ :
			{
				mRBRACE(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5d /* ']' */ :
			{
				mRBRACKET(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x28 /* '(' */ :
			{
				mLPAREN(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x29 /* ')' */ :
			{
				mRPAREN(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2b /* '+' */ :
			{
				mPLUS_OP(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2d /* '-' */ :
			{
				mMINUS_OP(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x2a /* '*' */ :
			{
				mMUL_OP(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x3f /* '?' */ :
			{
				mSELECT_OP(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x5e /* '^' */ :
			{
				mXOR_OP(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x23 /* '#' */ :
			{
				mHASH(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mUINTEGER(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x9 /* '\t' */ :
			case 0xa /* '\n' */ :
			case 0xc /* '\14' */ :
			case 0xd /* '\r' */ :
			case 0x20 /* ' ' */ :
			{
				mWHITESPACE(true);
				theRetToken=_returnToken;
				break;
			}
			case 0x22 /* '\"' */ :
			{
				mQUOTED_STRING(true);
				theRetToken=_returnToken;
				break;
			}
			default:
				if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x70 /* 'p' */ ) && (LA(5) == 0x65 /* 'e' */ ) && (LA(6) == 0x6c /* 'l' */ )) {
					mPIPELINE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x55 /* 'U' */ )) {
					mUtoS_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x53 /* 'S' */ )) {
					mStoS_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x55 /* 'U' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x53 /* 'S' */ )) {
					mStoU_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x46 /* 'F' */ )) {
					mFtoS_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x55 /* 'U' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x46 /* 'F' */ )) {
					mFtoU_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x46 /* 'F' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x53 /* 'S' */ )) {
					mStoF_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x46 /* 'F' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x55 /* 'U' */ )) {
					mUtoF_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x46 /* 'F' */ ) && (LA(3) == 0x3a /* ':' */ ) && (LA(4) == 0x3d /* '=' */ ) && (LA(5) == 0x24 /* '$' */ ) && (LA(6) == 0x46 /* 'F' */ )) {
					mFtoF_ASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ ) && (LA(3) == 0x61 /* 'a' */ ) && (LA(4) == 0x78 /* 'x' */ ) && (LA(5) == 0x61 /* 'a' */ )) {
					mMAXACCESSWIDTH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ ) && (LA(3) == 0x70 /* 'p' */ ) && (LA(4) == 0x65 /* 'e' */ ) && (LA(5) == 0x69 /* 'i' */ )) {
					mDPEINSTANCE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x70 /* 'p' */ ) && (LA(5) == 0x65 /* 'e' */ ) && (true)) {
					mPIPE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (LA(4) == 0x74 /* 't' */ ) && (LA(5) == 0x65 /* 'e' */ )) {
					mINTERMEDIATE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x68 /* 'h' */ ) && (LA(4) == 0x69 /* 'i' */ ) && (LA(5) == 0x73 /* 's' */ )) {
					mPHISEQUENCER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x61 /* 'a' */ ) && (LA(3) == 0x74 /* 't' */ ) && (LA(4) == 0x74 /* 't' */ )) {
					mATTRIBUTE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ ) && (LA(3) == 0x70 /* 'p' */ ) && (LA(4) == 0x65 /* 'e' */ ) && (true)) {
					mDPE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x62 /* 'b' */ )) {
					mLIBRARY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x63 /* 'c' */ ) && (LA(3) == 0x61 /* 'a' */ ) && (LA(4) == 0x70 /* 'p' */ )) {
					mCAPACITY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x72 /* 'r' */ ) && (LA(3) == 0x65 /* 'e' */ ) && (LA(4) == 0x71 /* 'q' */ )) {
					mREQS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x6f /* 'o' */ ) && (LA(4) == 0x72 /* 'r' */ )) {
					mPORT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ ) && (LA(3) == 0x61 /* 'a' */ ) && (LA(4) == 0x70 /* 'p' */ )) {
					mMAP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ ) && (LA(3) == 0x61 /* 'a' */ ) && (LA(4) == 0x78 /* 'x' */ ) && (true)) {
					mMAX(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x6e /* 'n' */ )) {
					mLINK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x68 /* 'h' */ ) && (LA(4) == 0x69 /* 'i' */ ) && (true)) {
					mPHI(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x63 /* 'c' */ ) && (LA(3) == 0x61 /* 'a' */ ) && (LA(4) == 0x6c /* 'l' */ )) {
					mCALL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (LA(4) == 0x6c /* 'l' */ )) {
					mINLINE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x69 /* 'i' */ ) && (LA(4) == 0x66 /* 'f' */ )) {
					mLIFO(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ ) && (LA(3) == 0x65 /* 'e' */ ) && (LA(4) == 0x70 /* 'p' */ )) {
					mDEPTH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (LA(4) == 0x74 /* 't' */ ) && (true)) {
					mINT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x6f /* 'o' */ ) && (LA(4) == 0x69 /* 'i' */ )) {
					mPOINTER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x72 /* 'r' */ ) && (LA(3) == 0x65 /* 'e' */ ) && (LA(4) == 0x63 /* 'c' */ )) {
					mRECORD(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3e /* '>' */ ) && (LA(4) == 0x24 /* '$' */ )) {
					mSGT_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3e /* '>' */ ) && (LA(4) == 0x3d /* '=' */ )) {
					mSGE_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3c /* '<' */ ) && (LA(4) == 0x24 /* '$' */ )) {
					mSLT_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3c /* '<' */ ) && (LA(4) == 0x3d /* '=' */ )) {
					mSLE_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ ) && (LA(3) == 0x65 /* 'e' */ ) && (LA(4) == 0x6c /* 'l' */ )) {
					mDELAY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x53 /* 'S' */ ) && (LA(3) == 0x3e /* '>' */ ) && (LA(4) == 0x3e /* '>' */ )) {
					mSHRA_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ ) && (LA(3) == 0x65 /* 'e' */ ) && (LA(4) == 0x61 /* 'a' */ )) {
					mDEAD(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ ) && (LA(3) == 0x65 /* 'e' */ )) {
					mMEMORYSPACE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6f /* 'o' */ ) && (LA(3) == 0x62 /* 'b' */ )) {
					mOBJECT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x64 /* 'd' */ ) && (LA(3) == 0x61 /* 'a' */ )) {
					mDATAWIDTH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x61 /* 'a' */ ) && (LA(3) == 0x64 /* 'd' */ )) {
					mADDRWIDTH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ ) && (LA(3) == 0x6f /* 'o' */ )) {
					mMODULE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x66 /* 'f' */ ) && (LA(3) == 0x6f /* 'o' */ )) {
					mFOREIGN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6f /* 'o' */ ) && (LA(3) == 0x66 /* 'f' */ )) {
					mOF(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x2d /* '-' */ ) && (LA(3) == 0x26 /* '&' */ )) {
					mJOIN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x2d /* '-' */ ) && (LA(3) == 0x7c /* '|' */ )) {
					mMERGE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x65 /* 'e' */ ) && (LA(3) == 0x6e /* 'n' */ )) {
					mENTRY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x65 /* 'e' */ ) && (LA(3) == 0x78 /* 'x' */ )) {
					mEXIT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6e /* 'n' */ ) && (true)) {
					mIN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6f /* 'o' */ ) && (LA(3) == 0x75 /* 'u' */ )) {
					mOUT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x61 /* 'a' */ ) && (LA(3) == 0x63 /* 'c' */ )) {
					mACKS(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x70 /* 'p' */ ) && (LA(3) == 0x61 /* 'a' */ )) {
					mPARAMETER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6d /* 'm' */ ) && (LA(3) == 0x69 /* 'i' */ )) {
					mMIN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x6f /* 'o' */ )) {
					mLOAD(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x74 /* 't' */ ) && (LA(3) == 0x6f /* 'o' */ )) {
					mTO(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x69 /* 'i' */ ) && (LA(3) == 0x6f /* 'o' */ )) {
					mIOPORT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x66 /* 'f' */ ) && (LA(3) == 0x72 /* 'r' */ )) {
					mFROM(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x61 /* 'a' */ ) && (LA(3) == 0x74 /* 't' */ ) && (true)) {
					mAT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x63 /* 'c' */ ) && (LA(3) == 0x6f /* 'o' */ )) {
					mCONSTANT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x62 /* 'b' */ ) && (LA(3) == 0x75 /* 'u' */ )) {
					mBUFFERING(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x66 /* 'f' */ ) && (LA(3) == 0x75 /* 'u' */ )) {
					mFULLRATE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x62 /* 'b' */ ) && (LA(3) == 0x69 /* 'i' */ )) {
					mBIND(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x74 /* 't' */ ) && (LA(3) == 0x65 /* 'e' */ )) {
					mTERMINATE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x74 /* 't' */ ) && (LA(3) == 0x72 /* 'r' */ )) {
					mTRANSITIONMERGE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3d /* '=' */ ) && (LA(3) == 0x3e /* '>' */ )) {
					mEQUIVALENT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x66 /* 'f' */ ) && (LA(3) == 0x6c /* 'l' */ )) {
					mFLOAT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x61 /* 'a' */ ) && (LA(3) == 0x72 /* 'r' */ )) {
					mARRAY(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ ) && (LA(3) == 0x30 /* '0' */ )) {
					mBRANCH_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6f /* 'o' */ ) && (LA(3) == 0x70 /* 'p' */ )) {
					mOPEN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x74 /* 't' */ ) && (LA(3) == 0x69 /* 'i' */ )) {
					mTIED_HIGH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6c /* 'l' */ ) && (LA(3) == 0x65 /* 'e' */ )) {
					mLEFT_OPEN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3a /* ':' */ ) && (_tokenSet_0.member(LA(2))) && (_tokenSet_1.member(LA(3)))) {
					mHIERARCHICAL_IDENTIFIER(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x75 /* 'u' */ )) {
					mUNORDERED(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mPARALLELBLOCK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3a /* ':' */ ) && (LA(2) == 0x3a /* ':' */ ) && (true)) {
					mFORKBLOCK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mBRANCHBLOCK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x6f /* 'o' */ )) {
					mLOOPBLOCK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x2d /* '-' */ )) {
					mFORK(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x6f /* 'o' */ ) && (LA(2) == 0x3c /* '<' */ )) {
					mMARKEDJOIN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (LA(2) == 0x2d /* '-' */ )) {
					mBRANCH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x6e /* 'n' */ )) {
					mN_ULL(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x54 /* 'T' */ )) {
					mTRANSITION(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x50 /* 'P' */ )) {
					mPLACE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x68 /* 'h' */ )) {
					mHIDDEN(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x44 /* 'D' */ )) {
					mDATAPATH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x43 /* 'C' */ )) {
					mCONTROLPATH(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x57 /* 'W' */ )) {
					mWIRE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x73 /* 's' */ )) {
					mSTORE(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x24 /* '$' */ ) && (LA(2) == 0x67 /* 'g' */ )) {
					mGUARD(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mIMPLIES(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3c /* '<' */ )) {
					mSHL_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3e /* '>' */ )) {
					mSHR_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3d /* '=' */ ) && (LA(2) == 0x3d /* '=' */ ) && (true)) {
					mEQ_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mUGE_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x3d /* '=' */ ) && (true)) {
					mULE_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x21 /* '!' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mNEQ_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (LA(2) == 0x2f /* '/' */ )) {
					mORDERED_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x21 /* '!' */ ) && (LA(2) == 0x3c /* '<' */ )) {
					mUNORDERED_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5b /* '[' */ ) && (LA(2) == 0x5d /* ']' */ )) {
					mBITSEL_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x26 /* '&' */ )) {
					mCONCAT_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5b /* '[' */ ) && (LA(2) == 0x3a /* ':' */ )) {
					mSLICE_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3a /* ':' */ ) && (LA(2) == 0x3d /* '=' */ )) {
					mASSIGN_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x7c /* '|' */ )) {
					mNOR_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x26 /* '&' */ )) {
					mNAND_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (LA(2) == 0x5e /* '^' */ )) {
					mXNOR_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (LA(2) == 0x2f /* '/' */ )) {
					mEQUIVALENCE_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (LA(2) == 0x2f /* '/' */ )) {
					mSINGLELINECOMMENT(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5f /* '_' */ ) && (LA(2) == 0x62 /* 'b' */ )) {
					mBINARYSTRING(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5f /* '_' */ ) && (LA(2) == 0x68 /* 'h' */ )) {
					mHEXSTRING(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3a /* ':' */ ) && (true)) {
					mCOLON(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x5b /* '[' */ ) && (true)) {
					mLBRACKET(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x2f /* '/' */ ) && (true)) {
					mDIV_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3e /* '>' */ ) && (true)) {
					mUGT_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x3c /* '<' */ ) && (true)) {
					mULT_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7e /* '~' */ ) && (true)) {
					mNOT_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x7c /* '|' */ ) && (true)) {
					mOR_OP(true);
					theRetToken=_returnToken;
				}
				else if ((LA(1) == 0x26 /* '&' */ ) && (true)) {
					mAND_OP(true);
					theRetToken=_returnToken;
				}
				else if ((_tokenSet_2.member(LA(1))) && (true)) {
					mSIMPLE_IDENTIFIER(true);
					theRetToken=_returnToken;
				}
			else {
				if (LA(1)==EOF_CHAR)
				{
					uponEOF();
					_returnToken = makeToken(ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE);
				}
				else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			if ( !_returnToken )
				goto tryAgain; // found SKIP token

			_ttype = _returnToken->getType();
			_ttype = testLiteralsTable(_ttype);
			_returnToken->setType(_ttype);
			return _returnToken;
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& e) {
			{
				reportError(e);
				consume();
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamIOException& csie) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamIOException(csie.io);
		}
		catch (ANTLR_USE_NAMESPACE(antlr)CharStreamException& cse) {
			throw ANTLR_USE_NAMESPACE(antlr)TokenStreamException(cse.getMessage());
		}
tryAgain:;
	}
}

void vcLexer::mATTRIBUTE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ATTRIBUTE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$attribute");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDPE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DPE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$dpe");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLIBRARY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LIBRARY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$lib");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMEMORYSPACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MEMORYSPACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$memoryspace");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUNORDERED(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UNORDERED;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$unordered");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mOBJECT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OBJECT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$object");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCAPACITY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CAPACITY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$capacity");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDATAWIDTH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DATAWIDTH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$datawidth");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mADDRWIDTH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ADDRWIDTH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$addrwidth");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMAXACCESSWIDTH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MAXACCESSWIDTH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$maxaccesswidth");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMODULE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MODULE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$module");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFOREIGN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FOREIGN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$foreign");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPIPELINE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PIPELINE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$pipeline");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSERIESBLOCK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SERIESBLOCK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(";;");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPARALLELBLOCK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PARALLELBLOCK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("||");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFORKBLOCK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FORKBLOCK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("::");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBRANCHBLOCK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BRANCHBLOCK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLOOPBLOCK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LOOPBLOCK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<o>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mOF(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OF;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$of");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFORK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FORK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("&->");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mJOIN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = JOIN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<-&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMARKEDJOIN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MARKEDJOIN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("o<-&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBRANCH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BRANCH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("|->");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMERGE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MERGE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<-|");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mENTRY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ENTRY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$entry");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mEXIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EXIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$exit");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mN_ULL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = N_ULL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$null");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mIN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$in");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mOUT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OUT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$out");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mREQS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = REQS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$reqs");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mACKS(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ACKS;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$acks");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mTRANSITION(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TRANSITION;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$T");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPLACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PLACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$P");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mHIDDEN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HIDDEN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$hidden");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPARAMETER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PARAMETER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$parameter");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPORT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PORT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$port");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMAP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MAP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$map");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDATAPATH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DATAPATH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$DP");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCONTROLPATH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CONTROLPATH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$CP");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mWIRE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = WIRE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$W");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMIN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MIN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$min");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMAX(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MAX;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$max");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDPEINSTANCE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DPEINSTANCE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$dpeinstance");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLINK(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LINK;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$link");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPHI(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PHI;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$phi");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLOAD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LOAD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$load");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSTORE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = STORE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$store");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mTO(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TO;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$to");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCALL(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CALL;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$call");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mINLINE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = INLINE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$inline");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mIOPORT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IOPORT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$ioport");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPIPE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PIPE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$pipe");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLIFO(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LIFO;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$lifo");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFROM(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FROM;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$from");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mAT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$at");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCONSTANT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CONSTANT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$constant");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mINTERMEDIATE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = INTERMEDIATE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$intermediate");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDEPTH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DEPTH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$depth");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBUFFERING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BUFFERING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$buffering");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFULLRATE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FULLRATE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$fullrate");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mGUARD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = GUARD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$guard");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBIND(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BIND;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$bind");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mTERMINATE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TERMINATE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$terminate");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPHISEQUENCER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PHISEQUENCER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$phisequencer");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mTRANSITIONMERGE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TRANSITIONMERGE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$transitionmerge");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCOLON(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COLON;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(':' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCOMMA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = COMMA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(',' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mIMPLIES(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = IMPLIES;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("=>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mEQUIVALENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQUIVALENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<=>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLBRACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LBRACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('{' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mRBRACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RBRACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('}' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLBRACKET(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LBRACKET;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('[' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mRBRACKET(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RBRACKET;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(']' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('(' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mRPAREN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RPAREN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(')' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mINT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = INT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$int");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFLOAT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FLOAT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$float");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPOINTER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = POINTER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$pointer");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mARRAY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ARRAY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$array");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mRECORD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = RECORD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$record");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mPLUS_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = PLUS_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("+");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMINUS_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MINUS_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("-");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mMUL_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = MUL_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("*");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDIV_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIV_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('/' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSHL_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SHL_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<<");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSHR_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SHR_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSGT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SGT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S>$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSGE_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SGE_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S>=$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mEQ_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQ_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("==");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSLT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SLT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S<$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSLE_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SLE_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S<=$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUGT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UGT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUGE_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UGE_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(">=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mULT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ULT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mULE_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ULE_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("<=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mNEQ_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NEQ_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("!=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mORDERED_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ORDERED_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("</=/>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUNORDERED_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UNORDERED_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("!</=/>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBITSEL_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BITSEL_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("[]");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mCONCAT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = CONCAT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("&&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBRANCH_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BRANCH_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("==0?");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSELECT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SELECT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("?");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSLICE_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SLICE_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("[:]");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(":=");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mNOT_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOT_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mOR_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OR_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("|");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mAND_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = AND_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mXOR_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XOR_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("^");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mNOR_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NOR_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~|");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mNAND_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = NAND_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~&");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mXNOR_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = XNOR_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("~^");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mEQUIVALENCE_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = EQUIVALENCE_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("&/");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mOPEN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = OPEN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$open");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDELAY(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DELAY;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$delay");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSHRA_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SHRA_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S>>");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUtoS_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UtoS_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S:=$U");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mStoS_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = StoS_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S:=$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mStoU_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = StoU_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$U:=$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFtoS_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FtoS_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$S:=$F");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFtoU_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FtoU_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$U:=$F");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mStoF_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = StoF_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$F:=$S");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUtoF_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UtoF_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$F:=$U");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mFtoF_ASSIGN_OP(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = FtoF_ASSIGN_OP;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$F:=$F");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDEAD(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DEAD;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$dead");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mTIED_HIGH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = TIED_HIGH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$tied_high");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mLEFT_OPEN(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = LEFT_OPEN;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("$left_open");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mHASH(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HASH;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match("#");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mUINTEGER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = UINTEGER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		mDIGIT(false);
		{ // ( ... )*
		for (;;) {
			if (((LA(1) >= 0x30 /* '0' */  && LA(1) <= 0x39 /* '9' */ ))) {
				mDIGIT(false);
			}
			else {
				goto _loop462;
			}
			
		}
		_loop462:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mDIGIT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = DIGIT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		matchRange('0','9');
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mWHITESPACE(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = WHITESPACE;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case 0x20 /* ' ' */ :
		{
			match(' ' /* charlit */ );
			break;
		}
		case 0x9 /* '\t' */ :
		{
			match('\t' /* charlit */ );
			break;
		}
		case 0xc /* '\14' */ :
		{
			match('\14' /* charlit */ );
			break;
		}
		case 0xd /* '\r' */ :
		{
			match('\r' /* charlit */ );
			break;
		}
		case 0xa /* '\n' */ :
		{
			match('\n' /* charlit */ );
#line 1888 "vc.g"
			newline();
#line 3293 "vcLexer.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
#line 1889 "vc.g"
		
			_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; 
		
#line 3306 "vcLexer.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSINGLELINECOMMENT(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SINGLELINECOMMENT;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		{
		match("//");
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_5.member(LA(1)))) {
				matchNot('\n' /* charlit */ );
			}
			else {
				goto _loop468;
			}
			
		}
		_loop468:;
		} // ( ... )*
		match('\n' /* charlit */ );
#line 1897 "vc.g"
		newline();
#line 3343 "vcLexer.cpp"
		}
#line 1899 "vc.g"
		
			_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP; 
		
#line 3349 "vcLexer.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mBINARYSTRING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = BINARYSTRING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('_' /* charlit */ );
		match('b' /* charlit */ );
		{ // ( ... )+
		int _cnt471=0;
		for (;;) {
			switch ( LA(1)) {
			case 0x30 /* '0' */ :
			{
				match('0' /* charlit */ );
				break;
			}
			case 0x31 /* '1' */ :
			{
				match('1' /* charlit */ );
				break;
			}
			default:
			{
				if ( _cnt471>=1 ) { goto _loop471; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			_cnt471++;
		}
		_loop471:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mHEXSTRING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HEXSTRING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('_' /* charlit */ );
		match('h' /* charlit */ );
		{ // ( ... )+
		int _cnt474=0;
		for (;;) {
			switch ( LA(1)) {
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mDIGIT(false);
				break;
			}
			case 0x61 /* 'a' */ :
			{
				match('a' /* charlit */ );
				break;
			}
			case 0x62 /* 'b' */ :
			{
				match('b' /* charlit */ );
				break;
			}
			case 0x63 /* 'c' */ :
			{
				match('c' /* charlit */ );
				break;
			}
			case 0x64 /* 'd' */ :
			{
				match('d' /* charlit */ );
				break;
			}
			case 0x65 /* 'e' */ :
			{
				match('e' /* charlit */ );
				break;
			}
			case 0x66 /* 'f' */ :
			{
				match('f' /* charlit */ );
				break;
			}
			default:
			{
				if ( _cnt474>=1 ) { goto _loop474; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());}
			}
			}
			_cnt474++;
		}
		_loop474:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mQUOTED_STRING(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = QUOTED_STRING;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match('\"' /* charlit */ );
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x47 /* 'G' */ :
			case 0x48 /* 'H' */ :
			case 0x49 /* 'I' */ :
			case 0x4a /* 'J' */ :
			case 0x4b /* 'K' */ :
			case 0x4c /* 'L' */ :
			case 0x4d /* 'M' */ :
			case 0x4e /* 'N' */ :
			case 0x4f /* 'O' */ :
			case 0x50 /* 'P' */ :
			case 0x51 /* 'Q' */ :
			case 0x52 /* 'R' */ :
			case 0x53 /* 'S' */ :
			case 0x54 /* 'T' */ :
			case 0x55 /* 'U' */ :
			case 0x56 /* 'V' */ :
			case 0x57 /* 'W' */ :
			case 0x58 /* 'X' */ :
			case 0x59 /* 'Y' */ :
			case 0x5a /* 'Z' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			case 0x67 /* 'g' */ :
			case 0x68 /* 'h' */ :
			case 0x69 /* 'i' */ :
			case 0x6a /* 'j' */ :
			case 0x6b /* 'k' */ :
			case 0x6c /* 'l' */ :
			case 0x6d /* 'm' */ :
			case 0x6e /* 'n' */ :
			case 0x6f /* 'o' */ :
			case 0x70 /* 'p' */ :
			case 0x71 /* 'q' */ :
			case 0x72 /* 'r' */ :
			case 0x73 /* 's' */ :
			case 0x74 /* 't' */ :
			case 0x75 /* 'u' */ :
			case 0x76 /* 'v' */ :
			case 0x77 /* 'w' */ :
			case 0x78 /* 'x' */ :
			case 0x79 /* 'y' */ :
			case 0x7a /* 'z' */ :
			{
				mALPHA(false);
				break;
			}
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mDIGIT(false);
				break;
			}
			case 0x5f /* '_' */ :
			{
				match('_' /* charlit */ );
				break;
			}
			case 0x20 /* ' ' */ :
			{
				match(' ' /* charlit */ );
				break;
			}
			case 0x2e /* '.' */ :
			{
				match('.' /* charlit */ );
				break;
			}
			case 0x9 /* '\t' */ :
			{
				match('\t' /* charlit */ );
				break;
			}
			default:
			{
				goto _loop477;
			}
			}
		}
		_loop477:;
		} // ( ... )*
		match('\"' /* charlit */ );
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mALPHA(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = ALPHA;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		switch ( LA(1)) {
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			matchRange('a','z');
			break;
		}
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		{
			matchRange('A','Z');
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mHIERARCHICAL_IDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = HIERARCHICAL_IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		match(':' /* charlit */ );
		{
		switch ( LA(1)) {
		case 0x41 /* 'A' */ :
		case 0x42 /* 'B' */ :
		case 0x43 /* 'C' */ :
		case 0x44 /* 'D' */ :
		case 0x45 /* 'E' */ :
		case 0x46 /* 'F' */ :
		case 0x47 /* 'G' */ :
		case 0x48 /* 'H' */ :
		case 0x49 /* 'I' */ :
		case 0x4a /* 'J' */ :
		case 0x4b /* 'K' */ :
		case 0x4c /* 'L' */ :
		case 0x4d /* 'M' */ :
		case 0x4e /* 'N' */ :
		case 0x4f /* 'O' */ :
		case 0x50 /* 'P' */ :
		case 0x51 /* 'Q' */ :
		case 0x52 /* 'R' */ :
		case 0x53 /* 'S' */ :
		case 0x54 /* 'T' */ :
		case 0x55 /* 'U' */ :
		case 0x56 /* 'V' */ :
		case 0x57 /* 'W' */ :
		case 0x58 /* 'X' */ :
		case 0x59 /* 'Y' */ :
		case 0x5a /* 'Z' */ :
		case 0x61 /* 'a' */ :
		case 0x62 /* 'b' */ :
		case 0x63 /* 'c' */ :
		case 0x64 /* 'd' */ :
		case 0x65 /* 'e' */ :
		case 0x66 /* 'f' */ :
		case 0x67 /* 'g' */ :
		case 0x68 /* 'h' */ :
		case 0x69 /* 'i' */ :
		case 0x6a /* 'j' */ :
		case 0x6b /* 'k' */ :
		case 0x6c /* 'l' */ :
		case 0x6d /* 'm' */ :
		case 0x6e /* 'n' */ :
		case 0x6f /* 'o' */ :
		case 0x70 /* 'p' */ :
		case 0x71 /* 'q' */ :
		case 0x72 /* 'r' */ :
		case 0x73 /* 's' */ :
		case 0x74 /* 't' */ :
		case 0x75 /* 'u' */ :
		case 0x76 /* 'v' */ :
		case 0x77 /* 'w' */ :
		case 0x78 /* 'x' */ :
		case 0x79 /* 'y' */ :
		case 0x7a /* 'z' */ :
		{
			mSIMPLE_IDENTIFIER(false);
			break;
		}
		case 0x3a /* ':' */ :
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltForCharException(LA(1), getFilename(), getLine(), getColumn());
		}
		}
		}
		match(':' /* charlit */ );
		mSIMPLE_IDENTIFIER(false);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}

void vcLexer::mSIMPLE_IDENTIFIER(bool _createToken) {
	int _ttype; ANTLR_USE_NAMESPACE(antlr)RefToken _token; ANTLR_USE_NAMESPACE(std)string::size_type _begin = text.length();
	_ttype = SIMPLE_IDENTIFIER;
	ANTLR_USE_NAMESPACE(std)string::size_type _saveIndex;
	
	try {      // for error handling
		mALPHA(false);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case 0x41 /* 'A' */ :
			case 0x42 /* 'B' */ :
			case 0x43 /* 'C' */ :
			case 0x44 /* 'D' */ :
			case 0x45 /* 'E' */ :
			case 0x46 /* 'F' */ :
			case 0x47 /* 'G' */ :
			case 0x48 /* 'H' */ :
			case 0x49 /* 'I' */ :
			case 0x4a /* 'J' */ :
			case 0x4b /* 'K' */ :
			case 0x4c /* 'L' */ :
			case 0x4d /* 'M' */ :
			case 0x4e /* 'N' */ :
			case 0x4f /* 'O' */ :
			case 0x50 /* 'P' */ :
			case 0x51 /* 'Q' */ :
			case 0x52 /* 'R' */ :
			case 0x53 /* 'S' */ :
			case 0x54 /* 'T' */ :
			case 0x55 /* 'U' */ :
			case 0x56 /* 'V' */ :
			case 0x57 /* 'W' */ :
			case 0x58 /* 'X' */ :
			case 0x59 /* 'Y' */ :
			case 0x5a /* 'Z' */ :
			case 0x61 /* 'a' */ :
			case 0x62 /* 'b' */ :
			case 0x63 /* 'c' */ :
			case 0x64 /* 'd' */ :
			case 0x65 /* 'e' */ :
			case 0x66 /* 'f' */ :
			case 0x67 /* 'g' */ :
			case 0x68 /* 'h' */ :
			case 0x69 /* 'i' */ :
			case 0x6a /* 'j' */ :
			case 0x6b /* 'k' */ :
			case 0x6c /* 'l' */ :
			case 0x6d /* 'm' */ :
			case 0x6e /* 'n' */ :
			case 0x6f /* 'o' */ :
			case 0x70 /* 'p' */ :
			case 0x71 /* 'q' */ :
			case 0x72 /* 'r' */ :
			case 0x73 /* 's' */ :
			case 0x74 /* 't' */ :
			case 0x75 /* 'u' */ :
			case 0x76 /* 'v' */ :
			case 0x77 /* 'w' */ :
			case 0x78 /* 'x' */ :
			case 0x79 /* 'y' */ :
			case 0x7a /* 'z' */ :
			{
				mALPHA(false);
				break;
			}
			case 0x30 /* '0' */ :
			case 0x31 /* '1' */ :
			case 0x32 /* '2' */ :
			case 0x33 /* '3' */ :
			case 0x34 /* '4' */ :
			case 0x35 /* '5' */ :
			case 0x36 /* '6' */ :
			case 0x37 /* '7' */ :
			case 0x38 /* '8' */ :
			case 0x39 /* '9' */ :
			{
				mDIGIT(false);
				break;
			}
			case 0x5f /* '_' */ :
			{
				match('_' /* charlit */ );
				break;
			}
			default:
			{
				goto _loop482;
			}
			}
		}
		_loop482:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	_ttype = testLiteralsTable(_ttype);
	if ( _createToken && _token==ANTLR_USE_NAMESPACE(antlr)nullToken && _ttype!=ANTLR_USE_NAMESPACE(antlr)Token::SKIP ) {
	   _token = makeToken(_ttype);
	   _token->setText(text.substr(_begin, text.length()-_begin));
	}
	_returnToken = _token;
	_saveIndex=0;
}


const unsigned long vcLexer::_tokenSet_0_data_[] = { 0UL, 67108864UL, 134217726UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// : A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g 
// h i j k l m n o p q r s t u v w x y z 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_0(_tokenSet_0_data_,10);
const unsigned long vcLexer::_tokenSet_1_data_[] = { 0UL, 134152192UL, 2281701374UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0 1 2 3 4 5 6 7 8 9 : A B C D E F G H I J K L M N O P Q R S T U V W 
// X Y Z _ a b c d e f g h i j k l m n o p q r s t u v w x y z 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_1(_tokenSet_1_data_,10);
const unsigned long vcLexer::_tokenSet_2_data_[] = { 0UL, 0UL, 134217726UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h 
// i j k l m n o p q r s t u v w x y z 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_2(_tokenSet_2_data_,10);
const unsigned long vcLexer::_tokenSet_3_data_[] = { 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_3(_tokenSet_3_data_,10);
const unsigned long vcLexer::_tokenSet_4_data_[] = { 512UL, 134168581UL, 2281701374UL, 134217726UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x9   \" . 0 1 2 3 4 5 6 7 8 9 : A B C D E F G H I J K L M N O P Q R 
// S T U V W X Y Z _ a b c d e f g h i j k l m n o p q r s t u v w x y 
// z 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_4(_tokenSet_4_data_,10);
const unsigned long vcLexer::_tokenSet_5_data_[] = { 4294966264UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 4294967295UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// 0x3 0x4 0x5 0x6 0x7 0x8 0x9 0xb 0xc 0xd 0xe 0xf 0x10 0x11 0x12 0x13 
// 0x14 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x1e 0x1f   ! \" # 
// $ % & \' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @ A B C D E 
// F G H I J K L M N O P Q R S T U V W X Y Z [ 0x5c ] ^ _ ` a b c d e f 
// g h i j k l m n o p q r s t u v w x y z { | } ~ 0x7f 0x80 0x81 0x82 
// 0x83 0x84 0x85 0x86 0x87 0x88 0x89 0x8a 0x8b 0x8c 0x8d 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_5(_tokenSet_5_data_,16);
const unsigned long vcLexer::_tokenSet_6_data_[] = { 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// : 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcLexer::_tokenSet_6(_tokenSet_6_data_,10);

