/* $ANTLR 2.7.7 (2006-11-01): "vc.g" -> "vcParser.cpp"$ */
#include "vcParser.hpp"
#include <antlr/NoViableAltException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/ASTFactory.hpp>
#line 10 "vc.g"


#line 10 "vcParser.cpp"
#line 1 "vc.g"
#line 12 "vcParser.cpp"
vcParser::vcParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,k)
{
}

vcParser::vcParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,2)
{
}

vcParser::vcParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

vcParser::vcParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,2)
{
}

vcParser::vcParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,2)
{
}

void vcParser::vc_System(
	vcSystem* sys
) {
#line 40 "vc.g"
	
		vcModule* nf = NULL;
		vcMemorySpace* ms = NULL;
	
#line 46 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case MODULE:
			{
				{
				nf=vc_Module(sys);
				}
				break;
			}
			case MEMORYSPACE:
			{
				{
				ms=vc_MemorySpace(sys,NULL);
#line 49 "vc.g"
				sys->Add_Memory_Space(ms);
#line 65 "vcParser.cpp"
				}
				break;
			}
			case PIPE:
			{
				{
				vc_Pipe(sys);
				}
				break;
			}
			default:
			{
				goto _loop6;
			}
			}
		}
		_loop6:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
}

vcModule*  vcParser::vc_Module(
	vcSystem* sys
) {
#line 107 "vc.g"
	vcModule* m;
#line 96 "vcParser.cpp"
#line 107 "vc.g"
	
		string lbl;
		m = NULL;
	vcMemorySpace* ms;
	
#line 103 "vcParser.cpp"
	
	try {      // for error handling
		match(MODULE);
		lbl=vc_Label();
#line 113 "vc.g"
		m = new vcModule(sys,lbl); sys->Add_Module(m);
#line 110 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case IN:
		{
			vc_Inargs(sys,m);
			break;
		}
		case MEMORYSPACE:
		case CONTROLPATH:
		case OUT:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{
		switch ( LA(1)) {
		case OUT:
		{
			vc_Outargs(sys,m);
			break;
		}
		case MEMORYSPACE:
		case CONTROLPATH:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == MEMORYSPACE)) {
				ms=vc_MemorySpace(sys,m);
#line 115 "vc.g"
				m->Add_Memory_Space(ms);
#line 155 "vcParser.cpp"
			}
			else {
				goto _loop18;
			}
			
		}
		_loop18:;
		} // ( ... )*
		vc_Controlpath(sys,m);
		{
		switch ( LA(1)) {
		case DATAPATH:
		{
			vc_Datapath(sys,m);
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case ATTRIBUTE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Link(m);
			}
			else {
				goto _loop21;
			}
			
		}
		_loop21:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(m);
			}
			else {
				goto _loop23;
			}
			
		}
		_loop23:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
	return m;
}

vcMemorySpace*  vcParser::vc_MemorySpace(
	vcSystem* sys, vcModule* m
) {
#line 68 "vc.g"
	vcMemorySpace* ms;
#line 222 "vcParser.cpp"
#line 68 "vc.g"
	
		string lbl;
		ms = NULL;
	
#line 228 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		lbl=vc_Label();
#line 73 "vc.g"
		ms = new vcMemorySpace(lbl,m);
#line 235 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(sys,ms);
			}
			else {
				goto _loop10;
			}
			
		}
		_loop10:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_2);
	}
	return ms;
}

void vcParser::vc_Pipe(
	vcSystem* sys
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 58 "vc.g"
	
	string lbl;
	
#line 267 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPE);
		lbl=vc_Label();
		wid = LT(1);
		match(UINTEGER);
#line 61 "vc.g"
		sys->Add_Pipe(lbl,atoi(wid->getText().c_str()));
#line 276 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

string  vcParser::vc_Label() {
#line 643 "vc.g"
	string lbl;
#line 287 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 645 "vc.g"
		lbl = id->getText();
#line 297 "vcParser.cpp"
		}
		match(RBRACKET);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	return lbl;
}

void vcParser::vc_MemorySpaceParams(
	vcMemorySpace* ms
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  cap = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lau = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  aw = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(CAPACITY);
		cap = LT(1);
		match(UINTEGER);
#line 80 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 321 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 81 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 327 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 82 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 333 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 88 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 351 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
		{
		switch ( LA(1)) {
		case ASSIGN_OP:
		{
			match(ASSIGN_OP);
			v=vc_Value(t);
			break;
		}
		case RBRACE:
		case OBJECT:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 96 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
			if(v != NULL)
				nl->Set_Value(v);
		ms->Add_Storage_Object(nl);
		
#line 384 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 802 "vc.g"
	vcType* t;
#line 397 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case INT:
		case FLOAT:
		case POINTER:
		{
			{
			t=vc_ScalarType(sys);
			}
			break;
		}
		case ARRAY:
		{
			{
			t=vc_ArrayType(sys);
			}
			break;
		}
		case RECORD:
		{
			{
			t=vc_RecordType(sys);
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 729 "vc.g"
	vcValue* v;
#line 444 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 729 "vc.g"
	
		v = NULL;
		string v_string;
		int idx = 0;
		vector<vcType*> etypes;
		vector<vcValue*> evalues;
		vcValue* ev;
	
		if(t->Is("vcArrayType"))
			etypes.push_back(((vcArrayType*)t)->Get_Element_Type());
		else if(t->Is("vcRecordType"))
		{
			int i;
			for(i = 0; i < ((vcRecordType*)t)->Get_Number_Of_Elements(); i++)
				etypes.push_back(((vcRecordType*)t)->Get_Element_Type(i));
		}
	
#line 464 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case BINARYSTRING:
		case HEXSTRING:
		case MINUS:
		case LITERAL_C:
		{
			{
			switch ( LA(1)) {
			case BINARYSTRING:
			case HEXSTRING:
			{
				v=vc_IntValue(t);
				break;
			}
			case MINUS:
			case LITERAL_C:
			{
				v=vc_FloatValue(t);
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
			break;
		}
		case LPAREN:
		{
			{
			sid = LT(1);
			match(LPAREN);
			ev=vc_Value(etypes[idx]);
#line 750 "vc.g"
			evalues.push_back(ev);
#line 503 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 751 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 510 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 751 "vc.g"
					evalues.push_back(ev);
#line 514 "vcParser.cpp"
				}
				else {
					goto _loop157;
				}
				
			}
			_loop157:;
			} // ( ... )*
#line 753 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 532 "vcParser.cpp"
			match(RPAREN);
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	return v;
}

void vcParser::vc_Inargs(
	vcSystem* sys, vcModule* parent
) {
#line 651 "vc.g"
	
		string mode = "in";
	
#line 557 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
			}
			else {
				goto _loop144;
			}
			
		}
		_loop144:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
}

void vcParser::vc_Outargs(
	vcSystem* sys, vcModule* parent
) {
#line 662 "vc.g"
	
		string mode = "out";
	
#line 587 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop147;
			}
			
		}
		_loop147:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Controlpath(
	vcSystem* sys, vcModule* m
) {
#line 178 "vc.g"
	
		vcControlPath* cp = new vcControlPath(m->Get_Id() + "_CP");
	
#line 617 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_9.member(LA(1)))) {
				vc_CPRegion(cp);
			}
			else {
				goto _loop38;
			}
			
		}
		_loop38:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(cp);
			}
			else {
				goto _loop40;
			}
			
		}
		_loop40:;
		} // ( ... )*
		match(RBRACE);
#line 182 "vc.g"
		m->Set_Control_Path(cp);
#line 649 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 351 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
	
#line 664 "vcParser.cpp"
	
	try {      // for error handling
		match(DATAPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case CONSTANT:
			case WIRE:
			{
				vc_Wire_Declaration(sys,dp);
				break;
			}
			case ASSIGN_OP:
			case DIV_OP:
			case PLUS_OP:
			case MINUS_OP:
			case MUL_OP:
			case SHL_OP:
			case SHR_OP:
			case GT_OP:
			case GE_OP:
			case EQ_OP:
			case LT_OP:
			case LE_OP:
			case NEQ_OP:
			case BITSEL_OP:
			case CONCAT_OP:
			case OR_OP:
			case AND_OP:
			case XOR_OP:
			case NOR_OP:
			case NAND_OP:
			case XNOR_OP:
			case NOT_OP:
			case BRANCH_OP:
			case SELECT_OP:
			{
				vc_Operator_Instantiation(sys,dp);
				break;
			}
			case PHI:
			{
				vc_Phi_Instantiation(dp);
				break;
			}
			case CALL:
			{
				vc_Call_Instantiation(sys,dp);
				break;
			}
			case IOPORT:
			{
				vc_IOPort_Instantiation(dp);
				break;
			}
			case LOAD:
			case STORE:
			{
				vc_LoadStore_Instantiation(sys,dp);
				break;
			}
			case ATTRIBUTE:
			{
				vc_AttributeSpec(dp);
				break;
			}
			default:
			{
				goto _loop93;
			}
			}
		}
		_loop93:;
		} // ( ... )*
		match(RBRACE);
#line 362 "vc.g"
		m->Set_Data_Path(dp);
#line 743 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
}

void vcParser::vc_Link(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpeid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 125 "vc.g"
	
	vcDatapathElement* dpe;
	vector<string> ref_vec;
	vector<vcTransition*> reqs;
	vector<vcTransition*> acks;
	
#line 762 "vcParser.cpp"
	
	try {      // for error handling
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 133 "vc.g"
		
		dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
		assert(dpe != NULL);
		
#line 772 "vcParser.cpp"
		match(EQUIVALENT);
		match(LPAREN);
		{ // ( ... )+
		int _cnt26=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 140 "vc.g"
				
				vcTransition* t = m->Get_Control_Path()->Find_Transition(ref_vec);
				assert(t != NULL);
				reqs.push_back(t);
				ref_vec.clear();
				
#line 787 "vcParser.cpp"
			}
			else {
				if ( _cnt26>=1 ) { goto _loop26; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt26++;
		}
		_loop26:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt28=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 150 "vc.g"
				
				vcTransition* t = m->Get_Control_Path()->Find_Transition(ref_vec);
				assert(t != NULL);
				acks.push_back(t);
				ref_vec.clear();
				
#line 811 "vcParser.cpp"
			}
			else {
				if ( _cnt28>=1 ) { goto _loop28; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt28++;
		}
		_loop28:;
		}  // ( ... )+
		match(RPAREN);
#line 158 "vc.g"
		m->Add_Link(dpe,reqs,acks);
#line 824 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
}

void vcParser::vc_AttributeSpec(
	vcRoot* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  kid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  vid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 874 "vc.g"
	
		string key;
		string value;
	
#line 842 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 880 "vc.g"
		key = kid->getText();
#line 850 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 880 "vc.g"
		value = vid->getText();
#line 856 "vcParser.cpp"
#line 881 "vc.g"
		m->Add_Attribute(key,value);
#line 859 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Hierarchical_CP_Ref(
	vector<string>& ref_vec
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  entry_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  exit_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 165 "vc.g"
	
	string id;
	
#line 876 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				id=vc_Identifier();
#line 169 "vc.g"
				ref_vec.push_back(id);
#line 885 "vcParser.cpp"
				match(DIV_OP);
			}
			else {
				goto _loop31;
			}
			
		}
		_loop31:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			id=vc_Identifier();
#line 170 "vc.g"
			ref_vec.push_back(id);
#line 903 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			entry_id = LT(1);
			match(ENTRY);
#line 171 "vc.g"
			ref_vec.push_back(entry_id->getText());
#line 914 "vcParser.cpp"
			}
			break;
		}
		case EXIT:
		{
			{
			exit_id = LT(1);
			match(EXIT);
#line 172 "vc.g"
			ref_vec.push_back(exit_id->getText());
#line 925 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
}

string  vcParser::vc_Identifier() {
#line 889 "vc.g"
	string s;
#line 945 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 889 "vc.g"
		s = id->getText();
#line 953 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return s;
}

void vcParser::vc_CPRegion(
	vcCPBlock* cp
) {
	
	try {      // for error handling
		switch ( LA(1)) {
		case SERIESBLOCK:
		{
			vc_CPSeriesBlock(cp);
			break;
		}
		case PARALLELBLOCK:
		{
			vc_CPParallelBlock(cp);
			break;
		}
		case BRANCHBLOCK:
		{
			vc_CPBranchBlock(cp);
			break;
		}
		case FORKBLOCK:
		{
			vc_CPForkBlock(cp);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

vcCPElement*  vcParser::vc_CPElement(
	vcCPElement* p
) {
#line 188 "vc.g"
	vcCPElement* cpe;
#line 1005 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case PLACE:
		{
			{
			cpe=vc_CPPlace(p);
			}
			break;
		}
		case TRANSITION:
		{
			{
			cpe=vc_CPTransition(p);
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_16);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPPlace(
	vcCPElement* p
) {
#line 195 "vc.g"
	vcCPElement* cpe;
#line 1041 "vcParser.cpp"
#line 195 "vc.g"
	
	string id;
	
#line 1046 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 199 "vc.g"
		cpe = (vcCPElement*) new vcPlace(p, id,0);
#line 1053 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_17);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPTransition(
	vcCPElement* p
) {
#line 205 "vc.g"
	vcCPElement* cpe;
#line 1067 "vcParser.cpp"
#line 205 "vc.g"
	
	string id;
	
#line 1072 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
#line 210 "vc.g"
		
		cpe = (vcCPElement*) (new vcTransition(p,id));
		
#line 1081 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_18);
	}
	return cpe;
}

void vcParser::vc_CPSeriesBlock(
	vcCPBlock* cp
) {
#line 229 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1099 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 235 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 1106 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt51=0;
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 236 "vc.g"
				sb->Add_CPElement(cpe);
#line 1119 "vcParser.cpp"
				}
				break;
			}
			case SERIESBLOCK:
			case PARALLELBLOCK:
			case BRANCHBLOCK:
			case FORKBLOCK:
			{
				{
				vc_CPRegion(sb);
				}
				break;
			}
			default:
			{
				if ( _cnt51>=1 ) { goto _loop51; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt51++;
		}
		_loop51:;
		}  // ( ... )+
		match(RBRACE);
#line 238 "vc.g"
		cp->Add_CPElement(sb);
#line 1145 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 244 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	
#line 1162 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 250 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 1169 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt54=0;
		for (;;) {
			if ((_tokenSet_9.member(LA(1)))) {
				vc_CPRegion(sb);
			}
			else {
				if ( _cnt54>=1 ) { goto _loop54; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt54++;
		}
		_loop54:;
		}  // ( ... )+
		match(RBRACE);
#line 252 "vc.g"
		cp->Add_CPElement(sb);
#line 1188 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 258 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1205 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 264 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 1212 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt61=0;
		for (;;) {
			switch ( LA(1)) {
			case SERIESBLOCK:
			case PARALLELBLOCK:
			case BRANCHBLOCK:
			case FORKBLOCK:
			{
				{
				vc_CPRegion(sb);
				}
				break;
			}
			case PLACE:
			{
				{
				cpe=vc_CPPlace(sb);
#line 268 "vc.g"
				sb->Add_CPElement(cpe);
#line 1234 "vcParser.cpp"
				}
				break;
			}
			default:
				if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == BRANCH)) {
					{
					vc_CPBranch(sb);
					}
				}
				else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == MERGE)) {
					{
					vc_CPMerge(sb);
					}
				}
			else {
				if ( _cnt61>=1 ) { goto _loop61; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt61++;
		}
		_loop61:;
		}  // ( ... )+
		match(RBRACE);
#line 269 "vc.g"
		cp->Add_CPElement(sb);
#line 1260 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 303 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1277 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 309 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 1284 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt76=0;
		for (;;) {
			switch ( LA(1)) {
			case SERIESBLOCK:
			case PARALLELBLOCK:
			case BRANCHBLOCK:
			case FORKBLOCK:
			{
				{
				vc_CPRegion(fb);
				}
				break;
			}
			case TRANSITION:
			{
				{
				cpe=vc_CPTransition(fb);
#line 313 "vc.g"
				fb->Add_CPElement(cpe);
#line 1306 "vcParser.cpp"
				}
				break;
			}
			default:
				if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY) && (LA(2) == FORK)) {
					{
					vc_CPFork(fb);
					}
				}
				else if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == EXIT) && (LA(2) == JOIN)) {
					{
					vc_CPJoin(fb);
					}
				}
			else {
				if ( _cnt76>=1 ) { goto _loop76; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt76++;
		}
		_loop76:;
		}  // ( ... )+
		match(RBRACE);
#line 314 "vc.g"
		cp->Add_CPElement(fb);
#line 1332 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPBranch(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 290 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 1349 "vcParser.cpp"
	
	try {      // for error handling
		lbl=vc_Identifier();
		match(BRANCH);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case EXIT:
		{
			e = LT(1);
			match(EXIT);
#line 296 "vc.g"
			branch_ids.push_back(e->getText());
#line 1363 "vcParser.cpp"
			break;
		}
		case SIMPLE_IDENTIFIER:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				b=vc_Identifier();
#line 297 "vc.g"
				branch_ids.push_back(b);
#line 1383 "vcParser.cpp"
			}
			else {
				goto _loop69;
			}
			
		}
		_loop69:;
		} // ( ... )*
#line 297 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1394 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
}

void vcParser::vc_CPMerge(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 275 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 1412 "vcParser.cpp"
	
	try {      // for error handling
		lbl=vc_Identifier();
		match(MERGE);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 281 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1426 "vcParser.cpp"
			break;
		}
		case SIMPLE_IDENTIFIER:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 282 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 1446 "vcParser.cpp"
			}
			else {
				goto _loop65;
			}
			
		}
		_loop65:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
}

void vcParser::vc_CPFork(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  fe = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 334 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 1473 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			lbl=vc_Identifier();
			}
			break;
		}
		case ENTRY:
		{
			{
			fe = LT(1);
			match(ENTRY);
#line 341 "vc.g"
			lbl = fe->getText();
#line 1492 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(FORK);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case EXIT:
		{
			e = LT(1);
			match(EXIT);
#line 341 "vc.g"
			fork_ids.push_back(e->getText());
#line 1512 "vcParser.cpp"
			break;
		}
		case SIMPLE_IDENTIFIER:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				b=vc_Identifier();
#line 342 "vc.g"
				fork_ids.push_back(b);
#line 1532 "vcParser.cpp"
			}
			else {
				goto _loop90;
			}
			
		}
		_loop90:;
		} // ( ... )*
		match(RPAREN);
#line 343 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 1544 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
}

void vcParser::vc_CPJoin(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 320 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 1562 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			lbl=vc_Identifier();
			}
			break;
		}
		case EXIT:
		{
			{
			je = LT(1);
			match(EXIT);
#line 326 "vc.g"
			lbl = je->getText();
#line 1581 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(JOIN);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 326 "vc.g"
			join_ids.push_back(e->getText());
#line 1601 "vcParser.cpp"
			break;
		}
		case SIMPLE_IDENTIFIER:
		case RPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				b=vc_Identifier();
#line 327 "vc.g"
				join_ids.push_back(b);
#line 1621 "vcParser.cpp"
			}
			else {
				goto _loop83;
			}
			
		}
		_loop83:;
		} // ( ... )*
		match(RPAREN);
#line 328 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 1633 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
}

void vcParser::vc_Wire_Declaration(
	vcSystem* sys,vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 701 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	
#line 1652 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			cid = LT(1);
			match(CONSTANT);
#line 709 "vc.g"
			const_flag = true;
#line 1663 "vcParser.cpp"
			break;
		}
		case WIRE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(WIRE);
		vc_Object_Declaration_Base(sys, &t, obj_name, &v);
#line 710 "vc.g"
		
		if(!const_flag) 
		dp->Add_Wire(obj_name, t);
		else
		{
		if (v == NULL)
		{
		sys->Error("constant wire without specified value?\n");
		}
		else 
		dp->Add_Constant_Wire(obj_name,v);
		}
		
#line 1692 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Operator_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	
	try {      // for error handling
		switch ( LA(1)) {
		case DIV_OP:
		case PLUS_OP:
		case MINUS_OP:
		case MUL_OP:
		case SHL_OP:
		case SHR_OP:
		case GT_OP:
		case GE_OP:
		case EQ_OP:
		case LT_OP:
		case LE_OP:
		case NEQ_OP:
		case BITSEL_OP:
		case CONCAT_OP:
		case OR_OP:
		case AND_OP:
		case XOR_OP:
		case NOR_OP:
		case NAND_OP:
		case XNOR_OP:
		{
			vc_BinaryOperator_Instantiation(dp);
			break;
		}
		case ASSIGN_OP:
		case NOT_OP:
		{
			vc_UnaryOperator_Instantiation(dp);
			break;
		}
		case SELECT_OP:
		{
			vc_Select_Instantiation(dp);
			break;
		}
		case BRANCH_OP:
		{
			vc_Branch_Instantiation(dp);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Phi_Instantiation(
	vcDataPath* dp
) {
#line 620 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 1770 "vcParser.cpp"
	
	try {      // for error handling
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt139=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 628 "vc.g"
				tw = dp->Find_Wire(id); assert(tw != NULL); inwires.push_back(tw);
#line 1783 "vcParser.cpp"
			}
			else {
				if ( _cnt139>=1 ) { goto _loop139; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt139++;
		}
		_loop139:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 631 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		assert(outwire != NULL); 
		phi = new vcPhi(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 1803 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Call_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 498 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 1825 "vcParser.cpp"
	
	try {      // for error handling
		match(CALL);
		{
		match(INLINE);
#line 509 "vc.g"
		inline_flag = true;
#line 1833 "vcParser.cpp"
		}
		id=vc_Label();
		match(MODULE);
		mid=vc_Identifier();
		match(LBRACE);
#line 509 "vc.g"
		m = sys->Find_Module(mid); assert(m != NULL);
#line 1841 "vcParser.cpp"
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 510 "vc.g"
				vcWire* w = dp->Find_Wire(mid); assert(w != NULL); inwires.push_back(w);
#line 1849 "vcParser.cpp"
			}
			else {
				goto _loop126;
			}
			
		}
		_loop126:;
		} // ( ... )*
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 511 "vc.g"
				vcWire* w = dp->Find_Wire(mid); assert(w != NULL); outwires.push_back(w);
#line 1866 "vcParser.cpp"
			}
			else {
				goto _loop128;
			}
			
		}
		_loop128:;
		} // ( ... )*
		match(RPAREN);
#line 512 "vc.g"
		nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc);
#line 1878 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_IOPort_Instantiation(
	vcDataPath* dp
) {
#line 518 "vc.g"
	
	string id, in_id, out_id, pipe_id;
	vcWire* w;
	bool in_flag = false;
	
#line 1895 "vcParser.cpp"
	
	try {      // for error handling
		match(IOPORT);
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 524 "vc.g"
			in_flag = true;
#line 1907 "vcParser.cpp"
			}
			break;
		}
		case OUT:
		{
			match(OUT);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		id=vc_Label();
		match(LPAREN);
		in_id=vc_Identifier();
		match(RPAREN);
		match(LPAREN);
		out_id=vc_Identifier();
		match(RPAREN);
#line 526 "vc.g"
		
		if(in_flag)
		{
		w = dp->Find_Wire(out_id);
		pipe_id = in_id;
		}
		else
		{
		w = dp->Find_Wire(in_id);
		pipe_id = out_id;
		}
		
		assert(w != NULL);
		if(w->Get_Type()->Size() != dp->Get_Parent()->Get_Parent()->Get_Pipe_Width(pipe_id))
		vcSystem::Error("Pipe " + pipe_id + " width does not match wire width on IOport " + id);
		
		if(in_flag)
		{
		vcInport* np = new vcInport(id,pipe_id,w);
		dp->Add_Inport(np);
		}
		else
		{
		vcOutport* np = new vcOutport(id,pipe_id,w);
		dp->Add_Outport(np);
		}
		
#line 1957 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_LoadStore_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	
	try {      // for error handling
		switch ( LA(1)) {
		case LOAD:
		{
			vc_Load_Instantiation(sys,dp);
			break;
		}
		case STORE:
		{
			vc_Store_Instantiation(sys,dp);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_BinaryOperator_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  plus_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  minus_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mul_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  div_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  shl_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  shr_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  gt_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  ge_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lt_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  le_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  neq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bitsel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  concat_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  or_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  and_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  xor_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  nor_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  nand_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  xnor_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 379 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 2027 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 391 "vc.g"
			op_id = plus_id->getText();
#line 2039 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 392 "vc.g"
			op_id = minus_id->getText();
#line 2050 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 393 "vc.g"
			op_id = mul_id->getText();
#line 2061 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 394 "vc.g"
			op_id = div_id->getText();
#line 2072 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 395 "vc.g"
			op_id = shl_id->getText();
#line 2083 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 396 "vc.g"
			op_id = shr_id->getText();
#line 2094 "vcParser.cpp"
			}
			break;
		}
		case GT_OP:
		{
			{
			gt_id = LT(1);
			match(GT_OP);
#line 397 "vc.g"
			op_id = gt_id->getText();
#line 2105 "vcParser.cpp"
			}
			break;
		}
		case GE_OP:
		{
			{
			ge_id = LT(1);
			match(GE_OP);
#line 398 "vc.g"
			op_id = ge_id->getText();
#line 2116 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 399 "vc.g"
			op_id = eq_id->getText();
#line 2127 "vcParser.cpp"
			}
			break;
		}
		case LT_OP:
		{
			{
			lt_id = LT(1);
			match(LT_OP);
#line 400 "vc.g"
			op_id = lt_id->getText();
#line 2138 "vcParser.cpp"
			}
			break;
		}
		case LE_OP:
		{
			{
			le_id = LT(1);
			match(LE_OP);
#line 401 "vc.g"
			op_id = le_id->getText();
#line 2149 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 402 "vc.g"
			op_id = neq_id->getText();
#line 2160 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 403 "vc.g"
			op_id = bitsel_id->getText();
#line 2171 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 404 "vc.g"
			op_id = concat_id->getText();
#line 2182 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 405 "vc.g"
			op_id = or_id->getText();
#line 2193 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 406 "vc.g"
			op_id = and_id->getText();
#line 2204 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 407 "vc.g"
			op_id = xor_id->getText();
#line 2215 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 408 "vc.g"
			op_id = nor_id->getText();
#line 2226 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 409 "vc.g"
			op_id = nand_id->getText();
#line 2237 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 410 "vc.g"
			op_id = xnor_id->getText();
#line 2248 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 412 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 2263 "vcParser.cpp"
		wid=vc_Identifier();
#line 413 "vc.g"
		y = dp->Find_Wire(wid); assert(x != NULL);
#line 2267 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 416 "vc.g"
		z = dp->Find_Wire(wid); assert(z != NULL);
#line 2273 "vcParser.cpp"
		match(RPAREN);
#line 418 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op);
#line 2277 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_UnaryOperator_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  not_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  nop_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 426 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 2299 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 436 "vc.g"
			op_id = not_id->getText();
#line 2311 "vcParser.cpp"
			}
			break;
		}
		case ASSIGN_OP:
		{
			{
			nop_id = LT(1);
			match(ASSIGN_OP);
#line 437 "vc.g"
			op_id = nop_id->getText();
#line 2322 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 439 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 2337 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 442 "vc.g"
		z = dp->Find_Wire(wid); assert(z != NULL);
#line 2343 "vcParser.cpp"
		match(RPAREN);
#line 444 "vc.g"
		new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
#line 2347 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Select_Instantiation(
	vcDataPath* dp
) {
#line 469 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 2370 "vcParser.cpp"
	
	try {      // for error handling
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 484 "vc.g"
		sel = dp->Find_Wire(wid); assert(sel != NULL);
#line 2379 "vcParser.cpp"
		wid=vc_Identifier();
#line 485 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 2383 "vcParser.cpp"
		wid=vc_Identifier();
#line 486 "vc.g"
		y = dp->Find_Wire(wid); assert(x != NULL);
#line 2387 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 489 "vc.g"
		z = dp->Find_Wire(wid); assert(z != NULL);
#line 2393 "vcParser.cpp"
		match(RPAREN);
#line 491 "vc.g"
		new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);
#line 2397 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Branch_Instantiation(
	vcDataPath* dp
) {
#line 450 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vcWire* x = NULL;
	
#line 2415 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 460 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 2424 "vcParser.cpp"
		match(RPAREN);
#line 462 "vc.g"
		new_op = new vcBranch(id,x); dp->Add_Branch(new_op);
#line 2428 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Load_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 567 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 2449 "vcParser.cpp"
	
	try {      // for error handling
		match(LOAD);
		id=vc_Label();
		match(FROM);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			m_id=vc_Identifier();
			match(DIV_OP);
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == LPAREN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		ms_id=vc_Identifier();
#line 578 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		assert(ms != NULL);
		
#line 2473 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 582 "vc.g"
		addr = dp->Find_Wire(wid); assert(addr != NULL);
#line 2478 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 583 "vc.g"
		data = dp->Find_Wire(wid); assert(data != NULL);
#line 2484 "vcParser.cpp"
		match(RPAREN);
#line 584 "vc.g"
		
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
		
#line 2491 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Store_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 594 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 2512 "vcParser.cpp"
	
	try {      // for error handling
		match(STORE);
		id=vc_Label();
		match(TO);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			m_id=vc_Identifier();
			match(DIV_OP);
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == LPAREN)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		ms_id=vc_Identifier();
#line 605 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		assert(ms != NULL);
		
#line 2536 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 609 "vc.g"
		addr = dp->Find_Wire(wid); assert(addr != NULL);
#line 2541 "vcParser.cpp"
		wid=vc_Identifier();
#line 610 "vc.g"
		data = dp->Find_Wire(wid); assert(data != NULL);
#line 2545 "vcParser.cpp"
		match(RPAREN);
#line 611 "vc.g"
		
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
		
#line 2552 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Interface_Object_Declaration(
	vcSystem* sys, vcModule* parent, string mode
) {
#line 672 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 2569 "vcParser.cpp"
	
	try {      // for error handling
		vc_Object_Declaration_Base(sys, &t,obj_name,&v);
#line 679 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 2577 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 687 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	
#line 2594 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 692 "vc.g"
		obj_name = id->getText();
#line 2601 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 692 "vc.g"
		*t = tt;
#line 2606 "vcParser.cpp"
		{
		if ((LA(1) == ASSIGN_OP) && (_tokenSet_22.member(LA(2)))) {
			match(ASSIGN_OP);
			vv=vc_Value(*t);
		}
		else if ((_tokenSet_23.member(LA(1))) && (_tokenSet_24.member(LA(2)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
#line 693 "vc.g"
		if(v != NULL) *v = vv;
#line 2621 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

vcValue*  vcParser::vc_IntValue(
	vcType* t
) {
#line 769 "vc.g"
	vcValue* v;
#line 2634 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 769 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcIntType") || t->Is("vcPointerType"));
	
#line 2643 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case BINARYSTRING:
		{
			{
			bid = LT(1);
			match(BINARYSTRING);
#line 774 "vc.g"
			vstring = bid->getText(); format = "binary";
#line 2655 "vcParser.cpp"
			}
			break;
		}
		case HEXSTRING:
		{
			{
			hid = LT(1);
			match(HEXSTRING);
#line 775 "vc.g"
			vstring = hid->getText(); format = "hexadecimal";
#line 2666 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 776 "vc.g"
		
			v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
		
#line 2680 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
	return v;
}

vcValue*  vcParser::vc_FloatValue(
	vcType* t
) {
#line 784 "vc.g"
	vcValue* v;
#line 2694 "vcParser.cpp"
#line 784 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcFloatType"));
		char sign_value = 0;
		vcValue* cv;
		vcValue* mv;
	assert(t != NULL && t->Is("vcFloatType"));
	
#line 2705 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case MINUS:
		{
			match(MINUS);
#line 793 "vc.g"
			sign_value = 1;
#line 2715 "vcParser.cpp"
			break;
		}
		case LITERAL_C:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LITERAL_C);
		cv=vc_IntValue(((vcFloatType*)t)->Get_Characteristic_Type());
		match(LITERAL_M);
		mv=vc_IntValue(((vcFloatType*)t)->Get_Mantissa_Type());
#line 794 "vc.g"
		
			v = (vcValue*) (new vcFloatValue((vcFloatType*)t,sign_value, (vcIntValue*)cv, (vcIntValue*)mv));
		
#line 2736 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType(
	vcSystem* sys
) {
#line 808 "vc.g"
	vcType* t;
#line 2750 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case INT:
		{
			{
			t=vc_IntType(sys);
			}
			break;
		}
		case FLOAT:
		{
			{
			t=vc_FloatType(sys);
			}
			break;
		}
		case POINTER:
		{
			{
			t=vc_PointerType(sys);
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

vcType*  vcParser::vc_ArrayType(
	vcSystem* sys
) {
#line 850 "vc.g"
	vcType* t;
#line 2793 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 850 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 2801 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 855 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 2810 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 856 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 2816 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

vcType*  vcParser::vc_RecordType(
	vcSystem* sys
) {
#line 862 "vc.g"
	vcType* t;
#line 2830 "vcParser.cpp"
#line 862 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 2837 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		match(LBRACKET);
		{
		et=vc_Type(sys);
#line 867 "vc.g"
		etypes.push_back(et);
#line 2846 "vcParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				t=vc_Type(sys);
#line 867 "vc.g"
				etypes.push_back(et);
#line 2855 "vcParser.cpp"
			}
			else {
				goto _loop181;
			}
			
		}
		_loop181:;
		} // ( ... )*
		match(RBRACKET);
#line 868 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 2867 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

vcType*  vcParser::vc_IntType(
	vcSystem* sys
) {
#line 814 "vc.g"
	vcType* t;
#line 2881 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 814 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 2888 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(LT_OP);
		i = LT(1);
		match(UINTEGER);
#line 819 "vc.g"
		w = atoi(i->getText().c_str());
#line 2897 "vcParser.cpp"
		match(GT_OP);
#line 819 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 2901 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

vcType*  vcParser::vc_FloatType(
	vcSystem* sys
) {
#line 825 "vc.g"
	vcType* t;
#line 2915 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 825 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 2923 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(LT_OP);
		cid = LT(1);
		match(UINTEGER);
#line 830 "vc.g"
		c = atoi(cid->getText().c_str());
#line 2932 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 830 "vc.g"
		m = atoi(mid->getText().c_str());
#line 2938 "vcParser.cpp"
		match(GT_OP);
#line 831 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 2942 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

vcType*  vcParser::vc_PointerType(
	vcSystem* sys
) {
#line 838 "vc.g"
	vcType* t;
#line 2956 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 838 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 2964 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(LT_OP);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(DIV_OP);
#line 843 "vc.g"
			scope_id = sid->getText();
#line 2976 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == GT_OP)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 844 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 2989 "vcParser.cpp"
		match(GT_OP);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
	return t;
}

void vcParser::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& )
{
}
const char* vcParser::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"PIPE",
	"UINTEGER",
	"MEMORYSPACE",
	"LBRACE",
	"RBRACE",
	"CAPACITY",
	"DATAWIDTH",
	"ADDRWIDTH",
	"OBJECT",
	"COLON",
	"ASSIGN_OP",
	"MODULE",
	"SIMPLE_IDENTIFIER",
	"EQUIVALENT",
	"LPAREN",
	"RPAREN",
	"DIV_OP",
	"ENTRY",
	"EXIT",
	"CONTROLPATH",
	"PLACE",
	"TRANSITION",
	"SERIESBLOCK",
	"PARALLELBLOCK",
	"BRANCHBLOCK",
	"MERGE",
	"BRANCH",
	"FORKBLOCK",
	"JOIN",
	"FORK",
	"DATAPATH",
	"PLUS_OP",
	"MINUS_OP",
	"MUL_OP",
	"SHL_OP",
	"SHR_OP",
	"GT_OP",
	"GE_OP",
	"EQ_OP",
	"LT_OP",
	"LE_OP",
	"NEQ_OP",
	"BITSEL_OP",
	"CONCAT_OP",
	"OR_OP",
	"AND_OP",
	"XOR_OP",
	"NOR_OP",
	"NAND_OP",
	"XNOR_OP",
	"NOT_OP",
	"BRANCH_OP",
	"SELECT_OP",
	"CALL",
	"INLINE",
	"IOPORT",
	"IN",
	"OUT",
	"LOAD",
	"FROM",
	"STORE",
	"TO",
	"PHI",
	"LBRACKET",
	"RBRACKET",
	"CONSTANT",
	"WIRE",
	"COMMA",
	"BINARYSTRING",
	"HEXSTRING",
	"MINUS",
	"\"C\"",
	"\"M\"",
	"INT",
	"FLOAT",
	"POINTER",
	"ARRAY",
	"OF",
	"RECORD",
	"ATTRIBUTE",
	"IMPLIES",
	"QUOTED_STRING",
	"DPE",
	"LIBRARY",
	"REQS",
	"ACKS",
	"HIDDEN",
	"PARAMETER",
	"PORT",
	"MAP",
	"MIN",
	"MAX",
	"DPEINSTANCE",
	"LINK",
	"AT",
	"UGT_OP",
	"UGE_OP",
	"ULT_OP",
	"ULE_OP",
	"UNORDERED_OP",
	"WHITESPACE",
	"SINGLELINECOMMENT",
	"HIERARCHICAL_IDENTIFIER",
	"ALPHA",
	"DIGIT",
	0
};

const unsigned long vcParser::_tokenSet_0_data_[] = { 2UL, 0UL, 0UL, 0UL };
// EOF 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_0(_tokenSet_0_data_,4);
const unsigned long vcParser::_tokenSet_1_data_[] = { 32850UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE MODULE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,4);
const unsigned long vcParser::_tokenSet_2_data_[] = { 8421458UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE MODULE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,4);
const unsigned long vcParser::_tokenSet_3_data_[] = { 2674237856UL, 2147483648UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER LBRACE RBRACE COLON MODULE SIMPLE_IDENTIFIER LPAREN ENTRY EXIT 
// PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK FROM 
// TO 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 4352UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,4);
const unsigned long vcParser::_tokenSet_5_data_[] = { 9523520UL, 1811939320UL, 524533UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE RBRACE OBJECT ASSIGN_OP SIMPLE_IDENTIFIER DIV_OP CONTROLPATH 
// PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP LT_OP LE_OP 
// NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP 
// NOT_OP BRANCH_OP SELECT_OP CALL IOPORT OUT LOAD STORE PHI RBRACKET CONSTANT 
// WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,8);
const unsigned long vcParser::_tokenSet_6_data_[] = { 10047808UL, 1811939320UL, 524517UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE RBRACE OBJECT ASSIGN_OP SIMPLE_IDENTIFIER RPAREN DIV_OP 
// CONTROLPATH PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP 
// LT_OP LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP NOT_OP BRANCH_OP SELECT_OP CALL IOPORT OUT LOAD STORE PHI CONSTANT 
// WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,8);
const unsigned long vcParser::_tokenSet_7_data_[] = { 8388672UL, 536870912UL, 0UL, 0UL };
// MEMORYSPACE CONTROLPATH OUT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,4);
const unsigned long vcParser::_tokenSet_8_data_[] = { 8388672UL, 0UL, 0UL, 0UL };
// MEMORYSPACE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,4);
const unsigned long vcParser::_tokenSet_9_data_[] = { 2617245696UL, 0UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,4);
const unsigned long vcParser::_tokenSet_10_data_[] = { 65792UL, 4UL, 524288UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,8);
const unsigned long vcParser::_tokenSet_11_data_[] = { 65792UL, 0UL, 524288UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 1065216UL, 1275068408UL, 524389UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE ASSIGN_OP DIV_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP GT_OP 
// GE_OP EQ_OP LT_OP LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP 
// NOR_OP NAND_OP XNOR_OP NOT_OP BRANCH_OP SELECT_OP CALL IOPORT LOAD STORE 
// PHI CONSTANT WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 6881280UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RPAREN ENTRY EXIT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,4);
const unsigned long vcParser::_tokenSet_14_data_[] = { 1618804864UL, 3UL, 0UL, 0UL };
// LBRACE SIMPLE_IDENTIFIER LPAREN RPAREN DIV_OP ENTRY EXIT MERGE BRANCH 
// JOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,4);
const unsigned long vcParser::_tokenSet_15_data_[] = { 2673934592UL, 0UL, 524288UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,8);
const unsigned long vcParser::_tokenSet_16_data_[] = { 2667577600UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,4);
const unsigned long vcParser::_tokenSet_17_data_[] = { 2667643136UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,4);
const unsigned long vcParser::_tokenSet_18_data_[] = { 2673934592UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,4);
const unsigned long vcParser::_tokenSet_19_data_[] = { 2634088704UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,4);
const unsigned long vcParser::_tokenSet_20_data_[] = { 2657157376UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,4);
const unsigned long vcParser::_tokenSet_21_data_[] = { 8454208UL, 536870912UL, 0UL, 0UL };
// MEMORYSPACE SIMPLE_IDENTIFIER CONTROLPATH OUT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,4);
const unsigned long vcParser::_tokenSet_22_data_[] = { 262144UL, 0UL, 3840UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// LPAREN BINARYSTRING HEXSTRING MINUS "C" 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 9519424UL, 1811939320UL, 524389UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE RBRACE ASSIGN_OP SIMPLE_IDENTIFIER DIV_OP CONTROLPATH PLUS_OP 
// MINUS_OP MUL_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP LT_OP LE_OP NEQ_OP BITSEL_OP 
// CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP NOT_OP BRANCH_OP 
// SELECT_OP CALL IOPORT OUT LOAD STORE PHI CONSTANT WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,8);
const unsigned long vcParser::_tokenSet_24_data_[] = { 8462784UL, 872415232UL, 524360UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE LBRACE RBRACE COLON SIMPLE_IDENTIFIER CONTROLPATH INLINE 
// IN OUT LBRACKET WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,8);
const unsigned long vcParser::_tokenSet_25_data_[] = { 10047808UL, 1811939320UL, 528613UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE RBRACE OBJECT ASSIGN_OP SIMPLE_IDENTIFIER RPAREN DIV_OP 
// CONTROLPATH PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP 
// LT_OP LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP NOT_OP BRANCH_OP SELECT_OP CALL IOPORT OUT LOAD STORE PHI CONSTANT 
// WIRE COMMA "M" ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,8);


