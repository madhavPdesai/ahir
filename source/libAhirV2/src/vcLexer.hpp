#ifndef INC_vcLexer_hpp_
#define INC_vcLexer_hpp_

#include <antlr/config.hpp>
/* $ANTLR 2.7.7 (2006-11-01): "vc.g" -> "vcLexer.hpp"$ */
#include <antlr/CommonToken.hpp>
#include <antlr/InputBuffer.hpp>
#include <antlr/BitSet.hpp>
#include "vcParserTokenTypes.hpp"
#include <antlr/CharScanner.hpp>
#line 13 "vc.g"

#include <vcHeader.hpp>
#include <antlr/RecognitionException.hpp>
	ANTLR_USING_NAMESPACE(antlr)
#define NOT_FOUND__(str, w, wid,token_id)      if(w == NULL)\
         vcSystem::Error(string("did not find ") + str + " " +  wid + ": line " + IntToStr(token_id->getLine()));

#line 20 "vcLexer.hpp"
class CUSTOM_API vcLexer : public ANTLR_USE_NAMESPACE(antlr)CharScanner, public vcParserTokenTypes
{
#line 1 "vc.g"
#line 24 "vcLexer.hpp"
private:
	void initLiterals();
public:
	bool getCaseSensitiveLiterals() const
	{
		return true;
	}
public:
	vcLexer(ANTLR_USE_NAMESPACE(std)istream& in);
	vcLexer(ANTLR_USE_NAMESPACE(antlr)InputBuffer& ib);
	vcLexer(const ANTLR_USE_NAMESPACE(antlr)LexerSharedInputState& state);
	ANTLR_USE_NAMESPACE(antlr)RefToken nextToken();
	public: void mATTRIBUTE(bool _createToken);
	public: void mDPE(bool _createToken);
	public: void mLIBRARY(bool _createToken);
	public: void mMEMORYSPACE(bool _createToken);
	public: void mOBJECT(bool _createToken);
	public: void mCAPACITY(bool _createToken);
	public: void mDATAWIDTH(bool _createToken);
	public: void mADDRWIDTH(bool _createToken);
	public: void mMODULE(bool _createToken);
	public: void mSERIESBLOCK(bool _createToken);
	public: void mPARALLELBLOCK(bool _createToken);
	public: void mFORKBLOCK(bool _createToken);
	public: void mBRANCHBLOCK(bool _createToken);
	public: void mOF(bool _createToken);
	public: void mFORK(bool _createToken);
	public: void mJOIN(bool _createToken);
	public: void mBRANCH(bool _createToken);
	public: void mMERGE(bool _createToken);
	public: void mENTRY(bool _createToken);
	public: void mEXIT(bool _createToken);
	public: void mIN(bool _createToken);
	public: void mOUT(bool _createToken);
	public: void mREQS(bool _createToken);
	public: void mACKS(bool _createToken);
	public: void mTRANSITION(bool _createToken);
	public: void mPLACE(bool _createToken);
	public: void mHIDDEN(bool _createToken);
	public: void mPARAMETER(bool _createToken);
	public: void mPORT(bool _createToken);
	public: void mMAP(bool _createToken);
	public: void mDATAPATH(bool _createToken);
	public: void mCONTROLPATH(bool _createToken);
	public: void mWIRE(bool _createToken);
	public: void mMIN(bool _createToken);
	public: void mMAX(bool _createToken);
	public: void mDPEINSTANCE(bool _createToken);
	public: void mLINK(bool _createToken);
	public: void mPHI(bool _createToken);
	public: void mLOAD(bool _createToken);
	public: void mSTORE(bool _createToken);
	public: void mTO(bool _createToken);
	public: void mCALL(bool _createToken);
	public: void mINLINE(bool _createToken);
	public: void mIOPORT(bool _createToken);
	public: void mPIPE(bool _createToken);
	public: void mFROM(bool _createToken);
	public: void mAT(bool _createToken);
	public: void mCONSTANT(bool _createToken);
	public: void mINTERMEDIATE(bool _createToken);
	public: void mCOLON(bool _createToken);
	public: void mCOMMA(bool _createToken);
	public: void mIMPLIES(bool _createToken);
	public: void mEQUIVALENT(bool _createToken);
	public: void mLBRACE(bool _createToken);
	public: void mRBRACE(bool _createToken);
	public: void mLBRACKET(bool _createToken);
	public: void mRBRACKET(bool _createToken);
	public: void mLPAREN(bool _createToken);
	public: void mRPAREN(bool _createToken);
	public: void mINT(bool _createToken);
	public: void mFLOAT(bool _createToken);
	public: void mPOINTER(bool _createToken);
	public: void mARRAY(bool _createToken);
	public: void mRECORD(bool _createToken);
	public: void mPLUS_OP(bool _createToken);
	public: void mMINUS_OP(bool _createToken);
	public: void mMUL_OP(bool _createToken);
	public: void mDIV_OP(bool _createToken);
	public: void mSHL_OP(bool _createToken);
	public: void mSHR_OP(bool _createToken);
	public: void mSGT_OP(bool _createToken);
	public: void mSGE_OP(bool _createToken);
	public: void mEQ_OP(bool _createToken);
	public: void mSLT_OP(bool _createToken);
	public: void mSLE_OP(bool _createToken);
	public: void mUGT_OP(bool _createToken);
	public: void mUGE_OP(bool _createToken);
	public: void mULT_OP(bool _createToken);
	public: void mULE_OP(bool _createToken);
	public: void mNEQ_OP(bool _createToken);
	public: void mORDERED_OP(bool _createToken);
	public: void mUNORDERED_OP(bool _createToken);
	public: void mBITSEL_OP(bool _createToken);
	public: void mCONCAT_OP(bool _createToken);
	public: void mBRANCH_OP(bool _createToken);
	public: void mSELECT_OP(bool _createToken);
	public: void mASSIGN_OP(bool _createToken);
	public: void mNOT_OP(bool _createToken);
	public: void mOR_OP(bool _createToken);
	public: void mAND_OP(bool _createToken);
	public: void mXOR_OP(bool _createToken);
	public: void mNOR_OP(bool _createToken);
	public: void mNAND_OP(bool _createToken);
	public: void mXNOR_OP(bool _createToken);
	public: void mEQUIVALENCE_OP(bool _createToken);
	public: void mOPEN(bool _createToken);
	public: void mSHRA_OP(bool _createToken);
	public: void mUtoS_ASSIGN_OP(bool _createToken);
	public: void mStoS_ASSIGN_OP(bool _createToken);
	public: void mStoU_ASSIGN_OP(bool _createToken);
	public: void mFtoS_ASSIGN_OP(bool _createToken);
	public: void mFtoU_ASSIGN_OP(bool _createToken);
	public: void mStoF_ASSIGN_OP(bool _createToken);
	public: void mUtoF_ASSIGN_OP(bool _createToken);
	public: void mFtoF_ASSIGN_OP(bool _createToken);
	public: void mUINTEGER(bool _createToken);
	protected: void mDIGIT(bool _createToken);
	public: void mWHITESPACE(bool _createToken);
	public: void mSINGLELINECOMMENT(bool _createToken);
	public: void mBINARYSTRING(bool _createToken);
	public: void mHEXSTRING(bool _createToken);
	public: void mQUOTED_STRING(bool _createToken);
	protected: void mALPHA(bool _createToken);
	public: void mHIERARCHICAL_IDENTIFIER(bool _createToken);
	public: void mSIMPLE_IDENTIFIER(bool _createToken);
private:
	
	static const unsigned long _tokenSet_0_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_0;
	static const unsigned long _tokenSet_1_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_1;
	static const unsigned long _tokenSet_2_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_2;
	static const unsigned long _tokenSet_3_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_3;
	static const unsigned long _tokenSet_4_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_4;
	static const unsigned long _tokenSet_5_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_5;
};

#endif /*INC_vcLexer_hpp_*/
