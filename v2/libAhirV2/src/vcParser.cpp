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
#line 42 "vc.g"
	
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
#line 51 "vc.g"
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
			case CONSTANT:
			case INTERMEDIATE:
			case WIRE:
			{
				{
				vc_Wire_Declaration(sys,NULL);
				}
				break;
			}
			default:
			{
				goto _loop7;
			}
			}
		}
		_loop7:;
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
#line 109 "vc.g"
	vcModule* m;
#line 105 "vcParser.cpp"
#line 109 "vc.g"
	
		string lbl;
		m = NULL;
	vcMemorySpace* ms;
	
#line 112 "vcParser.cpp"
	
	try {      // for error handling
		match(MODULE);
		lbl=vc_Label();
#line 115 "vc.g"
		m = new vcModule(sys,lbl); sys->Add_Module(m);
#line 119 "vcParser.cpp"
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
#line 117 "vc.g"
				m->Add_Memory_Space(ms);
#line 164 "vcParser.cpp"
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
#line 72 "vc.g"
	vcMemorySpace* ms;
#line 231 "vcParser.cpp"
#line 72 "vc.g"
	
		string lbl;
		ms = NULL;
	
#line 237 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		lbl=vc_Label();
#line 77 "vc.g"
		ms = new vcMemorySpace(lbl,m);
#line 244 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(sys,ms);
			}
			else {
				goto _loop11;
			}
			
		}
		_loop11:;
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
#line 62 "vc.g"
	
	string lbl;
	
#line 276 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPE);
		lbl=vc_Label();
		wid = LT(1);
		match(UINTEGER);
#line 65 "vc.g"
		sys->Add_Pipe(lbl,atoi(wid->getText().c_str()));
#line 285 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

void vcParser::vc_Wire_Declaration(
	vcSystem* sys,vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  iid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 903 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	bool intermediate_flag = false;
	
#line 307 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			{
			cid = LT(1);
			match(CONSTANT);
#line 912 "vc.g"
			const_flag = true;
#line 319 "vcParser.cpp"
			}
			break;
		}
		case INTERMEDIATE:
		{
			{
			iid = LT(1);
			match(INTERMEDIATE);
#line 912 "vc.g"
			intermediate_flag = true;
#line 330 "vcParser.cpp"
			}
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
		wid = LT(1);
		match(WIRE);
		vc_Object_Declaration_Base(sys, &t, obj_name, &v);
#line 913 "vc.g"
		
		if(!const_flag) 
		{
		if(dp != NULL)
		{
		if(intermediate_flag)
		dp->Add_Intermediate_Wire(obj_name,t);
		else
		dp->Add_Wire(obj_name, t);
		}
		else
		sys->Error("Warning: wire declaration at system scope ignored: line number " + 
		IntToStr(wid->getLine()));
		}
		else
		{
		if (v == NULL)
		{
		sys->Error("constant wire without specified value? line number " +
		IntToStr(cid->getLine()));
		}
		else 
		{
		if(dp != NULL)
		dp->Add_Constant_Wire(obj_name,v);
		else
		sys->Add_Constant_Wire(obj_name,v);
		}
		}
		
#line 378 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

string  vcParser::vc_Label() {
#line 844 "vc.g"
	string lbl;
#line 389 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 846 "vc.g"
		lbl = id->getText();
#line 399 "vcParser.cpp"
		}
		match(RBRACKET);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
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
#line 84 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 423 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 85 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 429 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 86 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 435 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 92 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 453 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
#line 100 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
		ms->Add_Storage_Object(nl);
		
#line 465 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 1003 "vc.g"
	vcType* t;
#line 478 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_6);
	}
	return t;
}

void vcParser::vc_Inargs(
	vcSystem* sys, vcModule* parent
) {
#line 852 "vc.g"
	
		string mode = "in";
	
#line 527 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
			}
			else {
				goto _loop168;
			}
			
		}
		_loop168:;
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
#line 863 "vc.g"
	
		string mode = "out";
	
#line 557 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop171;
			}
			
		}
		_loop171:;
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
#line 215 "vc.g"
	
		vcControlPath* cp = new vcControlPath(m->Get_Id() + "_CP");
	
#line 587 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_9.member(LA(1)))) {
				vc_CPRegion(cp);
			}
			else {
				goto _loop40;
			}
			
		}
		_loop40:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(cp);
			}
			else {
				goto _loop42;
			}
			
		}
		_loop42:;
		} // ( ... )*
		match(RBRACE);
#line 219 "vc.g"
		m->Set_Control_Path(cp);
#line 619 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 401 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
	
#line 634 "vcParser.cpp"
	
	try {      // for error handling
		match(DATAPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case CONSTANT:
			case INTERMEDIATE:
			case WIRE:
			{
				vc_Wire_Declaration(sys,dp);
				break;
			}
			case DIV_OP:
			case PLUS_OP:
			case MINUS_OP:
			case MUL_OP:
			case SHL_OP:
			case SHR_OP:
			case UGT_OP:
			case UGE_OP:
			case EQ_OP:
			case ULT_OP:
			case ULE_OP:
			case NEQ_OP:
			case BITSEL_OP:
			case CONCAT_OP:
			case OR_OP:
			case AND_OP:
			case XOR_OP:
			case NOR_OP:
			case NAND_OP:
			case XNOR_OP:
			case SHRA_OP:
			case SGT_OP:
			case SGE_OP:
			case SLT_OP:
			case SLE_OP:
			case NOT_OP:
			case StoS_ASSIGN_OP:
			case StoU_ASSIGN_OP:
			case UtoS_ASSIGN_OP:
			case FtoS_ASSIGN_OP:
			case FtoU_ASSIGN_OP:
			case StoF_ASSIGN_OP:
			case UtoF_ASSIGN_OP:
			case FtoF_ASSIGN_OP:
			case BRANCH_OP:
			case SELECT_OP:
			case SLICE_OP:
			case ASSIGN_OP:
			case EQUIVALENCE_OP:
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
				goto _loop96;
			}
			}
		}
		_loop96:;
		} // ( ... )*
		match(RBRACE);
#line 412 "vc.g"
		m->Set_Data_Path(dp);
#line 729 "vcParser.cpp"
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
#line 127 "vc.g"
	
	vcDatapathElement* dpe;
	vector<string> ref_vec;
	vector<vcTransition*> reqs;
	vector<vcTransition*> acks;
	
#line 748 "vcParser.cpp"
	
	try {      // for error handling
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 135 "vc.g"
		
		dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
		NOT_FOUND__("datapath-element",dpe,dpeid->getText(),dpeid)
		
#line 758 "vcParser.cpp"
		match(EQUIVALENT);
		match(LPAREN);
		{ // ( ... )+
		int _cnt26=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 142 "vc.g"
				
				vcTransition* t = m->Get_Control_Path()->Find_Transition(ref_vec);
				if(t != NULL)
				{
				reqs.push_back(t);
				}
				else
				{
				
				string tid;
				for(int idx=0; idx < ref_vec.size();idx++)
				{
				if(idx > 0)
				tid += "/";
				tid += ref_vec[idx];
				}
				NOT_FOUND__("transition",t,tid,dpeid)
				}
				ref_vec.clear();
				
				
#line 788 "vcParser.cpp"
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
		int _cnt30=0;
		for (;;) {
			switch ( LA(1)) {
			case SIMPLE_IDENTIFIER:
			case ENTRY:
			case EXIT:
			{
				{
				vc_Hierarchical_CP_Ref(ref_vec);
#line 167 "vc.g"
				
				vcTransition* t = m->Get_Control_Path()->Find_Transition(ref_vec);
				if(t != NULL)
				{
				acks.push_back(t);
				}
				else
				{
				
				string tid;
				for(int idx=0; idx < ref_vec.size();idx++)
				{
				if(idx > 0)
				tid += "/";
				tid += ref_vec[idx];
				}
				
				NOT_FOUND__("transition",t,tid,dpeid)
				}
				ref_vec.clear();
				
				
				
#line 834 "vcParser.cpp"
				}
				break;
			}
			case OPEN:
			{
				{
				match(OPEN);
#line 192 "vc.g"
				acks.push_back(NULL);
#line 844 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt30>=1 ) { goto _loop30; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt30++;
		}
		_loop30:;
		}  // ( ... )+
		match(RPAREN);
#line 195 "vc.g"
		m->Add_Link(dpe,reqs,acks);
#line 860 "vcParser.cpp"
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
#line 1075 "vc.g"
	
		string key;
		string value;
	
#line 878 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1081 "vc.g"
		key = kid->getText();
#line 886 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1081 "vc.g"
		value = vid->getText();
#line 892 "vcParser.cpp"
#line 1082 "vc.g"
		m->Add_Attribute(key,value);
#line 895 "vcParser.cpp"
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
#line 202 "vc.g"
	
	string id;
	
#line 912 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				id=vc_Identifier();
#line 206 "vc.g"
				ref_vec.push_back(id);
#line 921 "vcParser.cpp"
				match(DIV_OP);
			}
			else {
				goto _loop33;
			}
			
		}
		_loop33:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			id=vc_Identifier();
#line 207 "vc.g"
			ref_vec.push_back(id);
#line 939 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			entry_id = LT(1);
			match(ENTRY);
#line 208 "vc.g"
			ref_vec.push_back(entry_id->getText());
#line 950 "vcParser.cpp"
			}
			break;
		}
		case EXIT:
		{
			{
			exit_id = LT(1);
			match(EXIT);
#line 209 "vc.g"
			ref_vec.push_back(exit_id->getText());
#line 961 "vcParser.cpp"
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
#line 1090 "vc.g"
	string s;
#line 981 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1090 "vc.g"
		s = id->getText();
#line 989 "vcParser.cpp"
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
#line 225 "vc.g"
	vcCPElement* cpe;
#line 1041 "vcParser.cpp"
	
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
#line 232 "vc.g"
	vcCPElement* cpe;
#line 1077 "vcParser.cpp"
#line 232 "vc.g"
	
	string id;
	
#line 1082 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 237 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		cpe = (vcCPElement*) new vcPlace(p, id,0);
		
#line 1093 "vcParser.cpp"
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
#line 248 "vc.g"
	vcCPElement* cpe;
#line 1107 "vcParser.cpp"
#line 248 "vc.g"
	
	string id;
	bool dead_flag = false;
	
#line 1113 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
		{
		switch ( LA(1)) {
		case DEAD:
		{
			match(DEAD);
#line 253 "vc.g"
			dead_flag = true;
#line 1125 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case ENTRY:
		case EXIT:
		case PLACE:
		case TRANSITION:
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case FORKBLOCK:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 254 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		{
		cpe = (vcCPElement*) (new vcTransition(p,id));
			((vcTransition*)cpe)->Set_Is_Dead(dead_flag);
		}
		
#line 1156 "vcParser.cpp"
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
#line 278 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1174 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 284 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 1181 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 285 "vc.g"
				sb->Add_CPElement(cpe);
#line 1193 "vcParser.cpp"
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
				goto _loop54;
			}
			}
		}
		_loop54:;
		} // ( ... )*
		match(RBRACE);
#line 287 "vc.g"
		cp->Add_CPElement(sb);
#line 1218 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 293 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	vcCPElement* t;
	
#line 1236 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 300 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 1243 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case SERIESBLOCK:
			case PARALLELBLOCK:
			case BRANCHBLOCK:
			case FORKBLOCK:
			{
				vc_CPRegion(sb);
				break;
			}
			case TRANSITION:
			{
				t=vc_CPTransition(sb);
#line 301 "vc.g"
				sb->Add_CPElement(t);
#line 1261 "vcParser.cpp"
				break;
			}
			default:
			{
				goto _loop57;
			}
			}
		}
		_loop57:;
		} // ( ... )*
		match(RBRACE);
#line 302 "vc.g"
		cp->Add_CPElement(sb);
#line 1275 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 308 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1292 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 314 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 1299 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt64=0;
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
#line 318 "vc.g"
				sb->Add_CPElement(cpe);
#line 1321 "vcParser.cpp"
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
				if ( _cnt64>=1 ) { goto _loop64; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt64++;
		}
		_loop64:;
		}  // ( ... )+
		match(RBRACE);
#line 319 "vc.g"
		cp->Add_CPElement(sb);
#line 1347 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 353 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1364 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 359 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 1371 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
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
#line 363 "vc.g"
				fb->Add_CPElement(cpe);
#line 1392 "vcParser.cpp"
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
				goto _loop79;
			}
			}
		}
		_loop79:;
		} // ( ... )*
		match(RBRACE);
#line 364 "vc.g"
		cp->Add_CPElement(fb);
#line 1417 "vcParser.cpp"
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
#line 340 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 1434 "vcParser.cpp"
	
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
#line 346 "vc.g"
			branch_ids.push_back(e->getText());
#line 1448 "vcParser.cpp"
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
#line 347 "vc.g"
				branch_ids.push_back(b);
#line 1468 "vcParser.cpp"
			}
			else {
				goto _loop72;
			}
			
		}
		_loop72:;
		} // ( ... )*
#line 347 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1479 "vcParser.cpp"
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
#line 325 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 1497 "vcParser.cpp"
	
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
#line 331 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1511 "vcParser.cpp"
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
#line 332 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 1531 "vcParser.cpp"
			}
			else {
				goto _loop68;
			}
			
		}
		_loop68:;
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
#line 384 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 1558 "vcParser.cpp"
	
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
#line 391 "vc.g"
			lbl = fe->getText();
#line 1577 "vcParser.cpp"
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
#line 391 "vc.g"
			fork_ids.push_back(e->getText());
#line 1597 "vcParser.cpp"
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
#line 392 "vc.g"
				fork_ids.push_back(b);
#line 1617 "vcParser.cpp"
			}
			else {
				goto _loop93;
			}
			
		}
		_loop93:;
		} // ( ... )*
		match(RPAREN);
#line 393 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 1629 "vcParser.cpp"
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
#line 370 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 1647 "vcParser.cpp"
	
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
#line 376 "vc.g"
			lbl = je->getText();
#line 1666 "vcParser.cpp"
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
#line 376 "vc.g"
			join_ids.push_back(e->getText());
#line 1686 "vcParser.cpp"
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
#line 377 "vc.g"
				join_ids.push_back(b);
#line 1706 "vcParser.cpp"
			}
			else {
				goto _loop86;
			}
			
		}
		_loop86:;
		} // ( ... )*
		match(RPAREN);
#line 378 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 1718 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
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
		case UGT_OP:
		case UGE_OP:
		case EQ_OP:
		case ULT_OP:
		case ULE_OP:
		case NEQ_OP:
		case BITSEL_OP:
		case CONCAT_OP:
		case OR_OP:
		case AND_OP:
		case XOR_OP:
		case NOR_OP:
		case NAND_OP:
		case XNOR_OP:
		case SHRA_OP:
		case SGT_OP:
		case SGE_OP:
		case SLT_OP:
		case SLE_OP:
		{
			vc_BinaryOperator_Instantiation(dp);
			break;
		}
		case NOT_OP:
		case StoS_ASSIGN_OP:
		case StoU_ASSIGN_OP:
		case UtoS_ASSIGN_OP:
		case FtoS_ASSIGN_OP:
		case FtoU_ASSIGN_OP:
		case StoF_ASSIGN_OP:
		case UtoF_ASSIGN_OP:
		case FtoF_ASSIGN_OP:
		{
			vc_UnaryOperator_Instantiation(dp);
			break;
		}
		case SELECT_OP:
		{
			vc_Select_Instantiation(dp);
			break;
		}
		case SLICE_OP:
		{
			vc_Slice_Instantiation(dp);
			break;
		}
		case BRANCH_OP:
		{
			vc_Branch_Instantiation(dp);
			break;
		}
		case ASSIGN_OP:
		{
			vc_Register_Instantiation(dp);
			break;
		}
		case EQUIVALENCE_OP:
		{
			vc_Equivalence_Instantiation(dp);
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  p_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 819 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 1824 "vcParser.cpp"
	
	try {      // for error handling
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt163=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 827 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 1840 "vcParser.cpp"
			}
			else {
				if ( _cnt163>=1 ) { goto _loop163; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt163++;
		}
		_loop163:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 832 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
		phi = new vcPhi(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 1860 "vcParser.cpp"
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 680 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 1885 "vcParser.cpp"
	
	try {      // for error handling
		cid = LT(1);
		match(CALL);
		{
		switch ( LA(1)) {
		case INLINE:
		{
			match(INLINE);
#line 691 "vc.g"
			inline_flag = true;
#line 1897 "vcParser.cpp"
			break;
		}
		case LBRACKET:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		id=vc_Label();
		match(MODULE);
		mid=vc_Identifier();
#line 692 "vc.g"
		m = sys->Find_Module(mid); NOT_FOUND__("module",m,mid,cid)
#line 1915 "vcParser.cpp"
		lpid1 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 693 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid1)
				inwires.push_back(w);
#line 1926 "vcParser.cpp"
			}
			else {
				goto _loop150;
			}
			
		}
		_loop150:;
		} // ( ... )*
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 696 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid2)
				outwires.push_back(w);
#line 1946 "vcParser.cpp"
			}
			else {
				goto _loop152;
			}
			
		}
		_loop152:;
		} // ( ... )*
		match(RPAREN);
#line 699 "vc.g"
		nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc);
#line 1958 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_IOPort_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  ipid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 705 "vc.g"
	
	string id, in_id, out_id, pipe_id;
	vcWire* w;
	bool in_flag = false;
	
#line 1977 "vcParser.cpp"
	
	try {      // for error handling
		ipid = LT(1);
		match(IOPORT);
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 711 "vc.g"
			in_flag = true;
#line 1990 "vcParser.cpp"
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
		lpid = LT(1);
		match(LPAREN);
		out_id=vc_Identifier();
		match(RPAREN);
#line 713 "vc.g"
		
		if(in_flag)
		{
		w = dp->Find_Wire(out_id);
		NOT_FOUND__("wire",w,out_id,lpid)
		pipe_id = in_id;
		}
		else
		{
		w = dp->Find_Wire(in_id);
		NOT_FOUND__("wire",w,in_id,ipid);
		pipe_id = out_id;
		}
		
		
		
		
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
		
#line 2045 "vcParser.cpp"
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  shra_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sgt_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sge_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  slt_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sle_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 433 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 2122 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 445 "vc.g"
			op_id = plus_id->getText();
#line 2134 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 446 "vc.g"
			op_id = minus_id->getText();
#line 2145 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 447 "vc.g"
			op_id = mul_id->getText();
#line 2156 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 448 "vc.g"
			op_id = div_id->getText();
#line 2167 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 449 "vc.g"
			op_id = shl_id->getText();
#line 2178 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 450 "vc.g"
			op_id = shr_id->getText();
#line 2189 "vcParser.cpp"
			}
			break;
		}
		case UGT_OP:
		{
			{
			gt_id = LT(1);
			match(UGT_OP);
#line 451 "vc.g"
			op_id = gt_id->getText();
#line 2200 "vcParser.cpp"
			}
			break;
		}
		case UGE_OP:
		{
			{
			ge_id = LT(1);
			match(UGE_OP);
#line 452 "vc.g"
			op_id = ge_id->getText();
#line 2211 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 453 "vc.g"
			op_id = eq_id->getText();
#line 2222 "vcParser.cpp"
			}
			break;
		}
		case ULT_OP:
		{
			{
			lt_id = LT(1);
			match(ULT_OP);
#line 454 "vc.g"
			op_id = lt_id->getText();
#line 2233 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			le_id = LT(1);
			match(ULE_OP);
#line 455 "vc.g"
			op_id = le_id->getText();
#line 2244 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 456 "vc.g"
			op_id = neq_id->getText();
#line 2255 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 457 "vc.g"
			op_id = bitsel_id->getText();
#line 2266 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 458 "vc.g"
			op_id = concat_id->getText();
#line 2277 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 459 "vc.g"
			op_id = or_id->getText();
#line 2288 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 460 "vc.g"
			op_id = and_id->getText();
#line 2299 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 461 "vc.g"
			op_id = xor_id->getText();
#line 2310 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 462 "vc.g"
			op_id = nor_id->getText();
#line 2321 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 463 "vc.g"
			op_id = nand_id->getText();
#line 2332 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 464 "vc.g"
			op_id = xnor_id->getText();
#line 2343 "vcParser.cpp"
			}
			break;
		}
		case SHRA_OP:
		{
			{
			shra_id = LT(1);
			match(SHRA_OP);
#line 465 "vc.g"
			op_id = shra_id->getText();
#line 2354 "vcParser.cpp"
			}
			break;
		}
		case SGT_OP:
		{
			{
			sgt_id = LT(1);
			match(SGT_OP);
#line 466 "vc.g"
			op_id = sgt_id->getText();
#line 2365 "vcParser.cpp"
			}
			break;
		}
		case SGE_OP:
		{
			{
			sge_id = LT(1);
			match(SGE_OP);
#line 467 "vc.g"
			op_id = sge_id->getText();
#line 2376 "vcParser.cpp"
			}
			break;
		}
		case SLT_OP:
		{
			{
			slt_id = LT(1);
			match(SLT_OP);
#line 468 "vc.g"
			op_id = slt_id->getText();
#line 2387 "vcParser.cpp"
			}
			break;
		}
		case SLE_OP:
		{
			{
			sle_id = LT(1);
			match(SLE_OP);
#line 469 "vc.g"
			op_id = sle_id->getText();
#line 2398 "vcParser.cpp"
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
		lpid = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 472 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 2417 "vcParser.cpp"
		wid=vc_Identifier();
#line 477 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 2425 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 485 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 2435 "vcParser.cpp"
		match(RPAREN);
#line 490 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op);
#line 2439 "vcParser.cpp"
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  ss_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  su_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  us_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  fs_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  fu_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sf_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  uf_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  ff_assign_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 498 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 2470 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 510 "vc.g"
			op_id = not_id->getText();
#line 2482 "vcParser.cpp"
			}
			break;
		}
		case StoS_ASSIGN_OP:
		{
			{
			ss_assign_id = LT(1);
			match(StoS_ASSIGN_OP);
#line 511 "vc.g"
			op_id = ss_assign_id->getText();
#line 2493 "vcParser.cpp"
			}
			break;
		}
		case StoU_ASSIGN_OP:
		{
			{
			su_assign_id = LT(1);
			match(StoU_ASSIGN_OP);
#line 512 "vc.g"
			op_id = su_assign_id->getText();
#line 2504 "vcParser.cpp"
			}
			break;
		}
		case UtoS_ASSIGN_OP:
		{
			{
			us_assign_id = LT(1);
			match(UtoS_ASSIGN_OP);
#line 513 "vc.g"
			op_id = us_assign_id->getText();
#line 2515 "vcParser.cpp"
			}
			break;
		}
		case FtoS_ASSIGN_OP:
		{
			{
			fs_assign_id = LT(1);
			match(FtoS_ASSIGN_OP);
#line 514 "vc.g"
			op_id = fs_assign_id->getText();
#line 2526 "vcParser.cpp"
			}
			break;
		}
		case FtoU_ASSIGN_OP:
		{
			{
			fu_assign_id = LT(1);
			match(FtoU_ASSIGN_OP);
#line 515 "vc.g"
			op_id = fu_assign_id->getText();
#line 2537 "vcParser.cpp"
			}
			break;
		}
		case StoF_ASSIGN_OP:
		{
			{
			sf_assign_id = LT(1);
			match(StoF_ASSIGN_OP);
#line 516 "vc.g"
			op_id = sf_assign_id->getText();
#line 2548 "vcParser.cpp"
			}
			break;
		}
		case UtoF_ASSIGN_OP:
		{
			{
			uf_assign_id = LT(1);
			match(UtoF_ASSIGN_OP);
#line 517 "vc.g"
			op_id = uf_assign_id->getText();
#line 2559 "vcParser.cpp"
			}
			break;
		}
		case FtoF_ASSIGN_OP:
		{
			{
			ff_assign_id = LT(1);
			match(FtoF_ASSIGN_OP);
#line 518 "vc.g"
			op_id = ff_assign_id->getText();
#line 2570 "vcParser.cpp"
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
		lpid = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 521 "vc.g"
		
		x = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 2589 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 528 "vc.g"
		
		z = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 2599 "vcParser.cpp"
		match(RPAREN);
#line 533 "vc.g"
		new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
#line 2603 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Select_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  sel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 560 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 2627 "vcParser.cpp"
	
	try {      // for error handling
		sel_id = LT(1);
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 575 "vc.g"
		sel = dp->Find_Wire(wid); NOT_FOUND__("wire",sel,wid,sel_id)
#line 2637 "vcParser.cpp"
		wid=vc_Identifier();
#line 576 "vc.g"
		x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,sel_id)
#line 2641 "vcParser.cpp"
		wid=vc_Identifier();
#line 577 "vc.g"
		y = dp->Find_Wire(wid); NOT_FOUND__("wire",y,wid,sel_id)
#line 2645 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 580 "vc.g"
		z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id)
#line 2651 "vcParser.cpp"
		match(RPAREN);
#line 582 "vc.g"
		new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);
#line 2655 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Slice_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  slice_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 590 "vc.g"
	
	vcSlice* new_op = NULL;
	string id;
	string wid;
	int h, l;
	vcWire* sel = NULL;
	vcWire* din = NULL;
	vcWire* dout = NULL;
	
#line 2679 "vcParser.cpp"
	
	try {      // for error handling
		slice_id = LT(1);
		match(SLICE_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 603 "vc.g"
		din = dp->Find_Wire(wid); NOT_FOUND__("wire",din,wid,slice_id)
#line 2689 "vcParser.cpp"
		hid = LT(1);
		match(UINTEGER);
#line 604 "vc.g"
		h = atoi(hid->getText().c_str());
#line 2694 "vcParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 605 "vc.g"
		l = atoi(lid->getText().c_str());
#line 2699 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 608 "vc.g"
		dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id)
#line 2705 "vcParser.cpp"
		match(RPAREN);
#line 610 "vc.g"
		new_op = new vcSlice(id,din,dout,h,l); dp->Add_Slice(new_op);
#line 2709 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Branch_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  br_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 539 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vector<vcWire*> wires;
	vcWire* x;
	
#line 2729 "vcParser.cpp"
	
	try {      // for error handling
		br_id = LT(1);
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt138=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 550 "vc.g"
				x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,br_id)
				wires.push_back(x);
#line 2744 "vcParser.cpp"
			}
			else {
				if ( _cnt138>=1 ) { goto _loop138; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt138++;
		}
		_loop138:;
		}  // ( ... )+
		match(RPAREN);
#line 553 "vc.g"
		new_op = new vcBranch(id,wires); dp->Add_Branch(new_op);
#line 2757 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Register_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 618 "vc.g"
	
	vcRegister* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 2778 "vcParser.cpp"
	
	try {      // for error handling
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 626 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 2789 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 629 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 2796 "vcParser.cpp"
		match(RPAREN);
#line 632 "vc.g"
		
		new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
		
#line 2802 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Equivalence_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 642 "vc.g"
	
	string id;
	vcEquivalence* nm = NULL;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	vcWire* w;
	string wid;
	
#line 2823 "vcParser.cpp"
	
	try {      // for error handling
		eq_id = LT(1);
		match(EQUIVALENCE_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt144=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 654 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				inwires.push_back(w);
				
#line 2841 "vcParser.cpp"
			}
			else {
				if ( _cnt144>=1 ) { goto _loop144; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt144++;
		}
		_loop144:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt146=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 662 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				outwires.push_back(w);
				
#line 2864 "vcParser.cpp"
			}
			else {
				if ( _cnt146>=1 ) { goto _loop146; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt146++;
		}
		_loop146:;
		}  // ( ... )+
		match(RPAREN);
#line 668 "vc.g"
		
		nm = new vcEquivalence(id,inwires,outwires);
		dp->Add_Equivalence(nm);
		
#line 2880 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Load_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  ldid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 758 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 2902 "vcParser.cpp"
	
	try {      // for error handling
		ldid = LT(1);
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
#line 769 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),ldid)
		
#line 2927 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 773 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,ldid);
		
#line 2934 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 776 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",data,wid,ldid);
		
#line 2942 "vcParser.cpp"
		match(RPAREN);
#line 779 "vc.g"
		
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
		
#line 2949 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Store_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  st_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 789 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 2971 "vcParser.cpp"
	
	try {      // for error handling
		st_id = LT(1);
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
#line 800 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),st_id)
		
#line 2996 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 804 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,st_id);
		
#line 3003 "vcParser.cpp"
		wid=vc_Identifier();
#line 807 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("data",addr,wid,st_id);              
		
#line 3009 "vcParser.cpp"
		match(RPAREN);
#line 810 "vc.g"
		
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
		
#line 3016 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Interface_Object_Declaration(
	vcSystem* sys, vcModule* parent, string mode
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 873 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 3034 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 879 "vc.g"
		obj_name = id->getText();
#line 3041 "vcParser.cpp"
		match(COLON);
		t=vc_Type(sys);
#line 880 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 3048 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
#line 888 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	string oname;
	
#line 3065 "vcParser.cpp"
	
	try {      // for error handling
		oname=vc_Label();
#line 894 "vc.g"
		obj_name = oname;
#line 3071 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 894 "vc.g"
		*t = tt;
#line 3076 "vcParser.cpp"
		{
		if ((LA(1) == ASSIGN_OP) && (LA(2) == LPAREN || LA(2) == BINARYSTRING || LA(2) == HEXSTRING)) {
			match(ASSIGN_OP);
			vv=vc_Value(*t);
		}
		else if ((_tokenSet_3.member(LA(1))) && (_tokenSet_22.member(LA(2)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
#line 895 "vc.g"
		if(v != NULL) *v = vv;
#line 3091 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 949 "vc.g"
	vcValue* v;
#line 3104 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 949 "vc.g"
	
		v = NULL;
		string v_string;
		int idx = 0;
		vector<vcType*> etypes;
		vector<vcValue*> evalues;
		vcValue* ev;
	
		string vstring;
		string format;
	
		if(t->Is("vcArrayType"))
			etypes.push_back(((vcArrayType*)t)->Get_Element_Type());
		else if(t->Is("vcRecordType"))
		{
			int i;
			for(i = 0; i < ((vcRecordType*)t)->Get_Number_Of_Elements(); i++)
				etypes.push_back(((vcRecordType*)t)->Get_Element_Type(i));
		}
	
#line 3129 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case BINARYSTRING:
		case HEXSTRING:
		{
			{
			{
			switch ( LA(1)) {
			case BINARYSTRING:
			{
				{
				bid = LT(1);
				match(BINARYSTRING);
#line 972 "vc.g"
				vstring = bid->getText(); format = "binary";
#line 3146 "vcParser.cpp"
				}
				break;
			}
			case HEXSTRING:
			{
				{
				hid = LT(1);
				match(HEXSTRING);
#line 973 "vc.g"
				vstring = hid->getText(); format = "hexadecimal";
#line 3157 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 975 "vc.g"
			
				if(t->Is("vcIntType") || t->Is("vcPointerType"))
				   v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
			else if(t->Is("vcFloatType"))
				   v = (vcValue*) (new vcFloatValue((vcFloatType*)t,vstring.substr(2),format));
			
#line 3174 "vcParser.cpp"
			}
			break;
		}
		case LPAREN:
		{
			{
			sid = LT(1);
			match(LPAREN);
			ev=vc_Value(etypes[idx]);
#line 984 "vc.g"
			evalues.push_back(ev);
#line 3186 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 985 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 3193 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 985 "vc.g"
					evalues.push_back(ev);
#line 3197 "vcParser.cpp"
				}
				else {
					goto _loop186;
				}
				
			}
			_loop186:;
			} // ( ... )*
#line 987 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 3215 "vcParser.cpp"
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
		recover(ex,_tokenSet_23);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType(
	vcSystem* sys
) {
#line 1009 "vc.g"
	vcType* t;
#line 3238 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_6);
	}
	return t;
}

vcType*  vcParser::vc_ArrayType(
	vcSystem* sys
) {
#line 1051 "vc.g"
	vcType* t;
#line 3281 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1051 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 3289 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 1056 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 3298 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 1057 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 3304 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	return t;
}

vcType*  vcParser::vc_RecordType(
	vcSystem* sys
) {
#line 1063 "vc.g"
	vcType* t;
#line 3318 "vcParser.cpp"
#line 1063 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 3325 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		{ // ( ... )+
		int _cnt204=0;
		for (;;) {
			if ((LA(1) == ULT_OP) && (_tokenSet_24.member(LA(2)))) {
				match(ULT_OP);
				{
				et=vc_Type(sys);
#line 1068 "vc.g"
				etypes.push_back(et);
#line 3338 "vcParser.cpp"
				}
				match(UGT_OP);
			}
			else {
				if ( _cnt204>=1 ) { goto _loop204; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt204++;
		}
		_loop204:;
		}  // ( ... )+
#line 1069 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 3352 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	return t;
}

vcType*  vcParser::vc_IntType(
	vcSystem* sys
) {
#line 1015 "vc.g"
	vcType* t;
#line 3366 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1015 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 3373 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(ULT_OP);
		i = LT(1);
		match(UINTEGER);
#line 1020 "vc.g"
		w = atoi(i->getText().c_str());
#line 3382 "vcParser.cpp"
		match(UGT_OP);
#line 1020 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 3386 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	return t;
}

vcType*  vcParser::vc_FloatType(
	vcSystem* sys
) {
#line 1026 "vc.g"
	vcType* t;
#line 3400 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1026 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 3408 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(ULT_OP);
		cid = LT(1);
		match(UINTEGER);
#line 1031 "vc.g"
		c = atoi(cid->getText().c_str());
#line 3417 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 1031 "vc.g"
		m = atoi(mid->getText().c_str());
#line 3423 "vcParser.cpp"
		match(UGT_OP);
#line 1032 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 3427 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
	return t;
}

vcType*  vcParser::vc_PointerType(
	vcSystem* sys
) {
#line 1039 "vc.g"
	vcType* t;
#line 3441 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1039 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 3449 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(ULT_OP);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(DIV_OP);
#line 1044 "vc.g"
			scope_id = sid->getText();
#line 3461 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == UGT_OP)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1045 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 3474 "vcParser.cpp"
		match(UGT_OP);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
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
	"MODULE",
	"SIMPLE_IDENTIFIER",
	"EQUIVALENT",
	"LPAREN",
	"RPAREN",
	"OPEN",
	"DIV_OP",
	"ENTRY",
	"EXIT",
	"CONTROLPATH",
	"PLACE",
	"TRANSITION",
	"DEAD",
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
	"UGT_OP",
	"UGE_OP",
	"EQ_OP",
	"ULT_OP",
	"ULE_OP",
	"NEQ_OP",
	"BITSEL_OP",
	"CONCAT_OP",
	"OR_OP",
	"AND_OP",
	"XOR_OP",
	"NOR_OP",
	"NAND_OP",
	"XNOR_OP",
	"SHRA_OP",
	"SGT_OP",
	"SGE_OP",
	"SLT_OP",
	"SLE_OP",
	"NOT_OP",
	"StoS_ASSIGN_OP",
	"StoU_ASSIGN_OP",
	"UtoS_ASSIGN_OP",
	"FtoS_ASSIGN_OP",
	"FtoU_ASSIGN_OP",
	"StoF_ASSIGN_OP",
	"UtoF_ASSIGN_OP",
	"FtoF_ASSIGN_OP",
	"BRANCH_OP",
	"SELECT_OP",
	"SLICE_OP",
	"ASSIGN_OP",
	"EQUIVALENCE_OP",
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
	"INTERMEDIATE",
	"WIRE",
	"BINARYSTRING",
	"HEXSTRING",
	"COMMA",
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
	"ORDERED_OP",
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
const unsigned long vcParser::_tokenSet_1_data_[] = { 16466UL, 0UL, 29360128UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE MODULE CONSTANT INTERMEDIATE WIRE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,8);
const unsigned long vcParser::_tokenSet_2_data_[] = { 8405074UL, 0UL, 29360128UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE MODULE CONTROLPATH CONSTANT INTERMEDIATE WIRE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 1065298UL, 4294967280UL, 30054399UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE RBRACE MODULE DIV_OP PLUS_OP MINUS_OP MUL_OP SHL_OP 
// SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP ULE_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP 
// SLE_OP NOT_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI 
// CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 1063444896UL, 1UL, 327680UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER LBRACE RBRACE COLON MODULE SIMPLE_IDENTIFIER LPAREN ENTRY EXIT 
// PLACE TRANSITION DEAD SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
// FROM TO 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,8);
const unsigned long vcParser::_tokenSet_5_data_[] = { 4352UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,4);
const unsigned long vcParser::_tokenSet_6_data_[] = { 9490770UL, 4294967280UL, 30070783UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE RBRACE OBJECT MODULE SIMPLE_IDENTIFIER DIV_OP CONTROLPATH 
// PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP ULE_OP 
// NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP 
// SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP NOT_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP 
// CALL IOPORT OUT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,8);
const unsigned long vcParser::_tokenSet_7_data_[] = { 8388672UL, 0UL, 16384UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE CONTROLPATH OUT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,8);
const unsigned long vcParser::_tokenSet_8_data_[] = { 8388672UL, 0UL, 0UL, 0UL };
// MEMORYSPACE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,4);
const unsigned long vcParser::_tokenSet_9_data_[] = { 939524096UL, 1UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,4);
const unsigned long vcParser::_tokenSet_10_data_[] = { 33024UL, 8UL, 0UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,8);
const unsigned long vcParser::_tokenSet_11_data_[] = { 33024UL, 0UL, 0UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 1048832UL, 4294967280UL, 30054399UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DIV_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP 
// ULT_OP ULE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP 
// NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP NOT_OP StoS_ASSIGN_OP 
// StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP 
// UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP 
// EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 7110656UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RPAREN OPEN ENTRY EXIT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,4);
const unsigned long vcParser::_tokenSet_14_data_[] = { 3229515808UL, 6UL, 0UL, 0UL };
// UINTEGER SIMPLE_IDENTIFIER LPAREN RPAREN OPEN DIV_OP ENTRY EXIT MERGE 
// BRANCH JOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,4);
const unsigned long vcParser::_tokenSet_15_data_[] = { 996180224UL, 1UL, 0UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,8);
const unsigned long vcParser::_tokenSet_16_data_[] = { 989856000UL, 1UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,4);
const unsigned long vcParser::_tokenSet_17_data_[] = { 989888768UL, 1UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,4);
const unsigned long vcParser::_tokenSet_18_data_[] = { 996180224UL, 1UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,4);
const unsigned long vcParser::_tokenSet_19_data_[] = { 956334336UL, 1UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,4);
const unsigned long vcParser::_tokenSet_20_data_[] = { 979403008UL, 1UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,4);
const unsigned long vcParser::_tokenSet_21_data_[] = { 8421440UL, 0UL, 16384UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MEMORYSPACE SIMPLE_IDENTIFIER CONTROLPATH OUT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,8);
const unsigned long vcParser::_tokenSet_22_data_[] = { 33026UL, 0UL, 17852416UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// EOF RBRACE SIMPLE_IDENTIFIER INLINE IN OUT LBRACKET WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 1327442UL, 4294967280UL, 164272127UL, 4UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE RBRACE MODULE RPAREN DIV_OP PLUS_OP MINUS_OP MUL_OP 
// SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP ULE_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP 
// SLE_OP NOT_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI 
// CONSTANT INTERMEDIATE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,8);
const unsigned long vcParser::_tokenSet_24_data_[] = { 0UL, 0UL, 4026531840UL, 2UL, 0UL, 0UL, 0UL, 0UL };
// INT FLOAT POINTER ARRAY RECORD 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,8);


