#ifndef INC_vcParser_hpp_
#define INC_vcParser_hpp_

#include <antlr/config.hpp>
/* $ANTLR 2.7.7 (2006-11-01): "vc.g" -> "vcParser.hpp"$ */
#include <antlr/TokenStream.hpp>
#include <antlr/TokenBuffer.hpp>
#include "vcParserTokenTypes.hpp"
#include <antlr/LLkParser.hpp>

#line 13 "vc.g"

#include <vcHeader.hpp>
#include <antlr/RecognitionException.hpp>
	ANTLR_USING_NAMESPACE(antlr)

#line 18 "vcParser.hpp"
class CUSTOM_API vcParser : public ANTLR_USE_NAMESPACE(antlr)LLkParser, public vcParserTokenTypes
{
#line 30 "vc.g"

	void reportError(RecognitionException &re )
	{
		vcSystem::Error("Parsing Exception: " + re.toString());
	}
#line 22 "vcParser.hpp"
public:
	void initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory );
protected:
	vcParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k);
public:
	vcParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf);
protected:
	vcParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k);
public:
	vcParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer);
	vcParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state);
	int getNumTokens() const
	{
		return vcParser::NUM_TOKENS;
	}
	const char* getTokenName( int type ) const
	{
		if( type > getNumTokens() ) return 0;
		return vcParser::tokenNames[type];
	}
	const char* const* getTokenNames() const
	{
		return vcParser::tokenNames;
	}
	public: void vc_System(
		vcSystem* sys
	);
	public: vcModule*  vc_Module(
		vcSystem* sys
	);
	public: vcMemorySpace*  vc_MemorySpace(
		vcSystem* sys, vcModule* m
	);
	public: void vc_Pipe(
		vcSystem* sys
	);
	public: void vc_Wire_Declaration(
		vcSystem* sys,vcDataPath* dp
	);
	public: string  vc_Label();
	public: void vc_MemorySpaceParams(
		vcMemorySpace* ms
	);
	public: void vc_MemoryLocation(
		vcSystem* sys, vcMemorySpace* ms
	);
	public: vcType*  vc_Type(
		vcSystem* sys
	);
	public: void vc_Inargs(
		vcSystem* sys, vcModule* parent
	);
	public: void vc_Outargs(
		vcSystem* sys, vcModule* parent
	);
	public: void vc_Controlpath(
		vcSystem* sys, vcModule* m
	);
	public: void vc_Datapath(
		vcSystem* sys,vcModule* m
	);
	public: void vc_Link(
		vcModule* m
	);
	public: void vc_AttributeSpec(
		vcRoot* m
	);
	public: void vc_Hierarchical_CP_Ref(
		vector<string>& ref_vec
	);
	public: string  vc_Identifier();
	public: void vc_CPRegion(
		vcCPBlock* cp
	);
	public: vcCPElement*  vc_CPElement(
		vcCPElement* p
	);
	public: vcCPElement*  vc_CPPlace(
		vcCPElement* p
	);
	public: vcCPElement*  vc_CPTransition(
		vcCPElement* p
	);
	public: void vc_CPSeriesBlock(
		vcCPBlock* cp
	);
	public: void vc_CPParallelBlock(
		vcCPBlock* cp
	);
	public: void vc_CPBranchBlock(
		vcCPBlock* cp
	);
	public: void vc_CPForkBlock(
		vcCPBlock* cp
	);
	public: void vc_CPBranch(
		vcCPBranchBlock* bb
	);
	public: void vc_CPMerge(
		vcCPBranchBlock* bb
	);
	public: void vc_CPFork(
		vcCPForkBlock* fb
	);
	public: void vc_CPJoin(
		vcCPForkBlock* fb
	);
	public: void vc_Operator_Instantiation(
		vcSystem* sys, vcDataPath* dp
	);
	public: void vc_Phi_Instantiation(
		vcDataPath* dp
	);
	public: void vc_Call_Instantiation(
		vcSystem* sys, vcDataPath* dp
	);
	public: void vc_IOPort_Instantiation(
		vcDataPath* dp
	);
	public: void vc_LoadStore_Instantiation(
		vcSystem* sys, vcDataPath* dp
	);
	public: void vc_BinaryOperator_Instantiation(
		vcDataPath* dp
	);
	public: void vc_UnaryOperator_Instantiation(
		vcDataPath* dp
	);
	public: void vc_Select_Instantiation(
		vcDataPath* dp
	);
	public: void vc_Branch_Instantiation(
		vcDataPath* dp
	);
	public: void vc_Register_Instantiation(
		vcDataPath* dp
	);
	public: void vc_Load_Instantiation(
		vcSystem* sys, vcDataPath* dp
	);
	public: void vc_Store_Instantiation(
		vcSystem* sys, vcDataPath* dp
	);
	public: void vc_Interface_Object_Declaration(
		vcSystem* sys, vcModule* parent, string mode
	);
	public: void vc_Object_Declaration_Base(
		vcSystem* sys, vcType** t, string& obj_name, vcValue** v
	);
	public: vcValue*  vc_Value(
		vcType* t
	);
	public: vcValue*  vc_IntValue(
		vcType* t
	);
	public: vcValue*  vc_FloatValue(
		vcType* t
	);
	public: vcType*  vc_ScalarType(
		vcSystem* sys
	);
	public: vcType*  vc_ArrayType(
		vcSystem* sys
	);
	public: vcType*  vc_RecordType(
		vcSystem* sys
	);
	public: vcType*  vc_IntType(
		vcSystem* sys
	);
	public: vcType*  vc_FloatType(
		vcSystem* sys
	);
	public: vcType*  vc_PointerType(
		vcSystem* sys
	);
public:
	ANTLR_USE_NAMESPACE(antlr)RefAST getAST()
	{
		return returnAST;
	}
	
protected:
	ANTLR_USE_NAMESPACE(antlr)RefAST returnAST;
private:
	static const char* tokenNames[];
#ifndef NO_STATIC_CONSTS
	static const int NUM_TOKENS = 111;
#else
	enum {
		NUM_TOKENS = 111
	};
#endif
	
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
	static const unsigned long _tokenSet_6_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_6;
	static const unsigned long _tokenSet_7_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_7;
	static const unsigned long _tokenSet_8_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_8;
	static const unsigned long _tokenSet_9_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_9;
	static const unsigned long _tokenSet_10_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_10;
	static const unsigned long _tokenSet_11_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_11;
	static const unsigned long _tokenSet_12_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_12;
	static const unsigned long _tokenSet_13_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_13;
	static const unsigned long _tokenSet_14_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_14;
	static const unsigned long _tokenSet_15_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_15;
	static const unsigned long _tokenSet_16_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_16;
	static const unsigned long _tokenSet_17_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_17;
	static const unsigned long _tokenSet_18_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_18;
	static const unsigned long _tokenSet_19_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_19;
	static const unsigned long _tokenSet_20_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_20;
	static const unsigned long _tokenSet_21_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_21;
	static const unsigned long _tokenSet_22_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_22;
	static const unsigned long _tokenSet_23_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_23;
	static const unsigned long _tokenSet_24_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_24;
	static const unsigned long _tokenSet_25_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_25;
};

#endif /*INC_vcParser_hpp_*/
