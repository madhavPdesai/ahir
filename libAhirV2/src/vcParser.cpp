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

void vcParser::vc_System() {
#line 40 "vc.g"
	
		vcDPLibrary* lib = NULL;
		vcModule* nf = NULL;
		vcMemorySpace* ms = NULL;
	
#line 45 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case MODULE:
			{
				{
				nf=vc_Module();
#line 48 "vc.g"
				vcProgram::Add_Module(*nf);
#line 57 "vcParser.cpp"
				}
				break;
			}
			case MEMORYSPACE:
			{
				{
				ms=vc_MemorySpace();
#line 50 "vc.g"
				vcProgram::Add_Memory_Space(*ms)
#line 67 "vcParser.cpp"
				}
				break;
			}
			case LIBRARY:
			{
				{
				lib=vc_Library();
#line 52 "vc.g"
				vcProgram::Add_Library(*lib)
#line 77 "vcParser.cpp"
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

vcModule*  vcParser::vc_Module() {
#line 206 "vc.g"
	vcModule* m;
#line 99 "vcParser.cpp"
#line 206 "vc.g"
	
		string lbl;
		m = NULL;
	vcMemorySpace* ms;
	
#line 106 "vcParser.cpp"
	
	try {      // for error handling
		match(MODULE);
		lbl=vc_Label();
#line 212 "vc.g"
		m = new vcModule(lbl);
#line 113 "vcParser.cpp"
		match(LBRACE);
		vc_Inargs(m);
		vc_Outargs(m);
		vc_Controlpath(m);
		vc_Datapath(m);
		vc_Link(m);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == MEMORYSPACE)) {
				ms=vc_MemorySpace();
#line 213 "vc.g"
				m->Add_Memory_Space(ms);
#line 126 "vcParser.cpp"
			}
			else {
				goto _loop42;
			}
			
		}
		_loop42:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(m);
			}
			else {
				goto _loop44;
			}
			
		}
		_loop44:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
	return m;
}

vcMemorySpace*  vcParser::vc_MemorySpace() {
#line 168 "vc.g"
	vcMemorySpace* ms;
#line 159 "vcParser.cpp"
#line 168 "vc.g"
	
		string lbl;
		ms = NULL;
	
#line 165 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		lbl=vc_Label();
#line 173 "vc.g"
		ms = new vcMemorySpace(lbl);
#line 172 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(ms);
			}
			else {
				goto _loop36;
			}
			
		}
		_loop36:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_2);
	}
	return ms;
}

vcDatapathElementLibrary*  vcParser::vc_Library() {
#line 60 "vc.g"
	vcDatapathElementLibrary* new_lib;
#line 199 "vcParser.cpp"
#line 60 "vc.g"
	
		string lbl = "";
		vcDatapathElementTemplate* e;
		new_lib = NULL;
	
#line 206 "vcParser.cpp"
	
	try {      // for error handling
		match(LIBRARY);
		lbl=vc_Label();
#line 66 "vc.g"
		new_lib = new vcDatapathElementLibrary(lbl);
#line 213 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == DPE)) {
				e=vc_DatapathElementTemplate();
#line 67 "vc.g"
				new_lib->Add_Template(e);
#line 221 "vcParser.cpp"
			}
			else {
				goto _loop9;
			}
			
		}
		_loop9:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
	return new_lib;
}

string  vcParser::vc_Label() {
#line 425 "vc.g"
	string lbl;
#line 242 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		{
		match(LBRACKET);
		}
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 427 "vc.g"
		lbl = id->getText();
#line 254 "vcParser.cpp"
		}
		{
		match(RBRACKET);
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	return lbl;
}

vcDatapathElementTemplate*  vcParser::vc_DatapathElementTemplate() {
#line 73 "vc.g"
	vcDatapathElementTemplate* t;
#line 270 "vcParser.cpp"
#line 73 "vc.g"
	
		string lbl = "";
	
#line 275 "vcParser.cpp"
	
	try {      // for error handling
		match(DPE);
		lbl=vc_Label();
#line 77 "vc.g"
		t = new vcDatapathElementTemplate(lbl);
#line 282 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case PARAMETER:
		{
			vc_DpeParamSpec(t);
			break;
		}
		case IN:
		case OUT:
		case REQS:
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
		case IN:
		{
			vc_InDpePorts(t);
			break;
		}
		case OUT:
		case REQS:
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
			vc_OutDpePorts(t);
			break;
		}
		case REQS:
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
		vc_DpeReqs(t);
		}
		{
		vc_DpeAcks(t);
		}
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
	}
	return t;
}

void vcParser::vc_DpeParamSpec(
	vc_DatapathElementTemplate* p
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  minval = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  maxval = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 85 "vc.g"
	
		string pname;
		unsigned int min_val, max_val;
	
#line 363 "vcParser.cpp"
	
	try {      // for error handling
		match(PARAMETER);
		match(LPAREN);
		{ // ( ... )+
		int _cnt18=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Identifier();
#line 91 "vc.g"
				pname = nlbl->getText();
#line 375 "vcParser.cpp"
				minval = LT(1);
				match(UINTEGER);
#line 92 "vc.g"
				min_val = atoi(minval->getText().c_str());
#line 380 "vcParser.cpp"
				maxval = LT(1);
				match(UINTEGER);
#line 93 "vc.g"
				max_val = atoi(maxval->getText().c_str()); p->Add_Parameter(pname,min_val,max_val);
#line 385 "vcParser.cpp"
			}
			else {
				if ( _cnt18>=1 ) { goto _loop18; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt18++;
		}
		_loop18:;
		}  // ( ... )+
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

void vcParser::vc_InDpePorts(
	vc_DatapathElementTemplate* t
) {
	
	try {      // for error handling
		match(IN);
		vc_DpePorts(t,"in");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

void vcParser::vc_OutDpePorts(
	vc_DatapathElementTemplate* t
) {
	
	try {      // for error handling
		match(OUT);
		vc_DpePorts(t,"out");
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
}

void vcParser::vc_DpeReqs(
	vc_DatapathElementTemplate* t
) {
	
	try {      // for error handling
		match(REQS);
		{ // ( ... )+
		int _cnt30=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Identifier();
#line 154 "vc.g"
				t->Add_Req(id->getText());
#line 444 "vcParser.cpp"
			}
			else {
				if ( _cnt30>=1 ) { goto _loop30; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt30++;
		}
		_loop30:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_DpeAcks(
	vc_DatapathElementTemplate* t
) {
	
	try {      // for error handling
		match(ACKS);
		{ // ( ... )+
		int _cnt33=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Identifier();
#line 162 "vc.g"
				t->Add_Ack(id->getText());
#line 474 "vcParser.cpp"
			}
			else {
				if ( _cnt33>=1 ) { goto _loop33; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt33++;
		}
		_loop33:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
}

void vcParser::vc_Identifier() {
	
	try {      // for error handling
		match(SIMPLE_IDENTIFIER);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_DpePorts(
	vc_DatapathElementTemplate* t, string mode
) {
#line 118 "vc.g"
	
		vcScalarTypeTemplate* tt;
	
#line 509 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )+
		int _cnt23=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Identifier();
				match(COLON);
				tt=vc_ScalarTypeTemplate();
#line 124 "vc.g"
				
				if(mode == "in") 
				t->Add_Input_Port(lbl->getText(), *tt);
				else
				t->Add_Output_Port(lbl->getText(), *tt);
				
#line 526 "vcParser.cpp"
			}
			else {
				if ( _cnt23>=1 ) { goto _loop23; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt23++;
		}
		_loop23:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcScalarTypeTemplate*  vcParser::vc_ScalarTypeTemplate() {
#line 137 "vc.g"
	vcScalarTypeTemplate* t;
#line 546 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  c = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  m = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  w = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(TEMPLATE);
		{
		switch ( LA(1)) {
		case FLOAT:
		{
			{
			match(FLOAT);
			match(LESS);
			c = LT(1);
			match(SIMPLE_IDENTIFIER);
			m = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(GREATER);
#line 139 "vc.g"
			
			t = new vcScalarTypeTemplate(c->getText(),m->getText());
			
#line 569 "vcParser.cpp"
			}
			break;
		}
		case INT:
		{
			{
			match(INT);
			match(LESS);
			w = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(GREATER);
#line 143 "vc.g"
			
			t = new vcScalarTypeTemplate(w->getText());
			
#line 585 "vcParser.cpp"
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
		recover(ex,_tokenSet_11);
	}
	return t;
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
#line 180 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 616 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 181 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 622 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 182 "vc.g"
		ms->Set_Word_Size(atoi(aw->getText().c_str()));
#line 628 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_MemoryLocation(
	vcMemorySpace* ms
) {
#line 188 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 646 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type();
		{
		switch ( LA(1)) {
		case ASSIGNEQUAL:
		{
			match(ASSIGNEQUAL);
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
#line 196 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
			if(v != NULL)
				nl->Set_Value(v);
		
#line 678 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

vcType*  vcParser::vc_Type() {
#line 569 "vc.g"
	vcType* t;
#line 689 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case FLOAT:
		case INT:
		case POINTER:
		{
			{
			t=vc_ScalarType();
			}
			break;
		}
		case ARRAY:
		{
			{
			t=vc_ArrayType();
			}
			break;
		}
		case RECORD:
		{
			{
			t=vc_RecordType();
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
	return t;
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 497 "vc.g"
	vcValue* v;
#line 736 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 497 "vc.g"
	
		v = NULL;
		string v_string;
		int idx = 0;
		vector<vcType*> etypes;
		vector<vcValue*> evalues;
		vcValue* ev;
	
		if(t->Is("vcArrayType"))
			etype.push_back(((vcArrayType*)t)->Get_Element_Type());
		else if(t->Is("vcRecordType"))
		{
			int i;
			for(i = 0; i < ((vcRecordType*)t)->Get_Number_Of_Elements(); i++)
				etypes.push_back(((vcRecordType*)t)->Get_Element_Type(i));
		}
	
#line 756 "vcParser.cpp"
	
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
#line 518 "vc.g"
			evalues.push_back(ev);
#line 795 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 519 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 802 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 519 "vc.g"
					evalues.push_back(ev);
#line 806 "vcParser.cpp"
				}
				else {
					goto _loop127;
				}
				
			}
			_loop127:;
			} // ( ... )*
#line 521 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue(t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue(t,evalues));
			else 
			vcRoot::Error("composite value specified for scalar type: line %d\n", sig->getLine());
			
#line 824 "vcParser.cpp"
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
		recover(ex,_tokenSet_14);
	}
	return v;
}

void vcParser::vc_Inargs(
	vcModule* parent
) {
#line 433 "vc.g"
	
		string mode = "out";
	
#line 849 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(parent,mode);
			}
			else {
				goto _loop115;
			}
			
		}
		_loop115:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_Outargs(
	vcModule* parent
) {
#line 444 "vc.g"
	
		string mode = "out";
	
#line 881 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(parent,mode);
			}
			else {
				goto _loop118;
			}
			
		}
		_loop118:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_16);
	}
}

void vcParser::vc_Controlpath(
	vcModule* m
) {
#line 228 "vc.g"
	
		vcControPath* cp = new vcControlPath(m->Get_Id() + "_CP");
	
#line 913 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_17.member(LA(1)))) {
				vc_CPRegion(cp);
			}
			else {
				goto _loop48;
			}
			
		}
		_loop48:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(cp);
			}
			else {
				goto _loop50;
			}
			
		}
		_loop50:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_18);
	}
}

void vcParser::vc_Datapath(
	vcModule* m
) {
#line 391 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m->Get_Id() + "_DP");
	
#line 957 "vcParser.cpp"
	
	try {      // for error handling
		match(DATAPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case WIRE:
			{
				vc_WireDeclaration(dp);
				break;
			}
			case DPEINSTANCE:
			{
				vc_DatapathElementInstantiation(dp);
				break;
			}
			case ATTRIBUTE:
			{
				vc_AttributeSpec(dp);
				break;
			}
			default:
			{
				goto _loop99;
			}
			}
		}
		_loop99:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
}

void vcParser::vc_Link(
	vcModule* m
) {
	
	try {      // for error handling
		match(LINK);
		match(LPAREN);
		vc_Identifier();
		match(IMPLIES);
		vc_Identifier();
		match(COLON);
		vc_Identifier();
		match(RPAREN);
#line 222 "vc.g"
		m->Add_Link(tid->getText(), dpeid->getText(), reqackid->getText());
#line 1011 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
}

void vcParser::vc_AttributeSpec(
	vcRoot* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  kid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  vid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 641 "vc.g"
	
		string key;
		string value;
	
#line 1029 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		match(LPAREN);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 647 "vc.g"
		key = kid->getText();
#line 1038 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 647 "vc.g"
		value = vid->getText();
#line 1044 "vcParser.cpp"
		match(RPAREN);
#line 648 "vc.g"
		m->Add_Attribute(key,value);
#line 1048 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPRegion(
	vcControlPath* cp
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
		recover(ex,_tokenSet_22);
	}
}

vcCPElement*  vcParser::vc_CPElement() {
#line 238 "vc.g"
	vcCPElement* cpe;
#line 1097 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case PLACE:
		{
			{
			cpe=vc_CPPlace();
			}
			break;
		}
		case TRANSITION:
		{
			{
			cpe=vc_CPTransition();
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
	return cpe;
}

vcCPElement*  vcParser::vc_CPPlace() {
#line 245 "vc.g"
	vcCPElement* cpe;
#line 1131 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		vc_Identifier();
#line 246 "vc.g"
		cpe = (vcCPElement*) new vcPlace(id->getText());
#line 1138 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPTransition() {
#line 252 "vc.g"
	vcCPElement* cpe;
#line 1150 "vcParser.cpp"
#line 252 "vc.g"
	
	vcTransitionType t;
	
#line 1155 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		vc_Identifier();
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 256 "vc.g"
			t = _IN_TRANSITION;
#line 1168 "vcParser.cpp"
			}
			break;
		}
		case OUT:
		{
			{
			match(OUT);
#line 256 "vc.g"
			t = _OUT_TRANSITION;
#line 1178 "vcParser.cpp"
			}
			break;
		}
		case HIDDEN:
		{
			{
			match(HIDDEN);
#line 256 "vc.g"
			t = _HIDDEN_TRANSITION;
#line 1188 "vcParser.cpp"
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
		recover(ex,_tokenSet_23);
	}
	return cpe;
}

void vcParser::vc_CPSeriesBlock(
	vcControlPath* cp
) {
#line 272 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1215 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 278 "vc.g"
		sb = new vcSeriesBlock(lbl);
#line 1222 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt65=0;
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement();
#line 279 "vc.g"
				sb->Add_CPElement(cpe);
#line 1235 "vcParser.cpp"
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
				if ( _cnt65>=1 ) { goto _loop65; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt65++;
		}
		_loop65:;
		}  // ( ... )+
		match(RBRACE);
#line 281 "vc.g"
		cp->Add_CPElement(sb);
#line 1261 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPParallelBlock(
	vcControlPath* cp
) {
#line 287 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	
#line 1278 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 293 "vc.g"
		sb = new vcParallelBlock(lbl);
#line 1285 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt68=0;
		for (;;) {
			if ((_tokenSet_17.member(LA(1)))) {
				vc_CPRegion(sb);
			}
			else {
				if ( _cnt68>=1 ) { goto _loop68; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt68++;
		}
		_loop68:;
		}  // ( ... )+
		match(RBRACE);
#line 295 "vc.g"
		cp->Add_CPElement(sb);
#line 1304 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPBranchBlock(
	vcControlPath* cp
) {
#line 301 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1321 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 307 "vc.g"
		sb = new vcBranchBlock(lbl);
#line 1328 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt74=0;
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
			case BRANCH:
			{
				{
				vc_CPBranch(sb);
				}
				break;
			}
			case MERGE:
			{
				{
				vc_CPMerge(sb);
				}
				break;
			}
			default:
			{
				if ( _cnt74>=1 ) { goto _loop74; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt74++;
		}
		_loop74:;
		}  // ( ... )+
		match(RBRACE);
#line 311 "vc.g"
		cp->Add_CPElement(sb);
#line 1370 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPForkBlock(
	vcControlPath* cp
) {
#line 347 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1387 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 353 "vc.g"
		fb = new vcCPForkBlock(lbl);
#line 1394 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt88=0;
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
			case FORK:
			{
				{
				vc_CPFork(fb);
				}
				break;
			}
			case JOIN:
			{
				{
				vc_CPJoin(fb);
				}
				break;
			}
			default:
			{
				if ( _cnt88>=1 ) { goto _loop88; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt88++;
		}
		_loop88:;
		}  // ( ... )+
		match(RBRACE);
#line 357 "vc.g"
		cp->Add_CPElement(fb);
#line 1436 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPBranch(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 332 "vc.g"
	
		string lbl;
		vector<string> branch_ids;
	
#line 1453 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCH);
		lbl=vc_Label();
		match(LPAREN);
		{
		switch ( LA(1)) {
		case EXIT:
		{
			e = LT(1);
			match(EXIT);
#line 339 "vc.g"
			branch_ids.push_back(e->getText());
#line 1467 "vcParser.cpp"
			break;
		}
		case RPAREN:
		case SIMPLE_IDENTIFIER:
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
				vc_Identifier();
#line 340 "vc.g"
				branch_ids.push_back(b->getText());
#line 1487 "vcParser.cpp"
			}
			else {
				goto _loop82;
			}
			
		}
		_loop82:;
		} // ( ... )*
		match(RPAREN);
#line 341 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1499 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_24);
	}
}

void vcParser::vc_CPMerge(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 317 "vc.g"
	
		string lbl;
		string merge_region;
	
#line 1516 "vcParser.cpp"
	
	try {      // for error handling
		match(MERGE);
		lbl=vc_Label();
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 323 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1530 "vcParser.cpp"
			break;
		}
		case RPAREN:
		case SIMPLE_IDENTIFIER:
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
				vc_Identifier();
#line 324 "vc.g"
				bb->Add_Merge_Point(lbl,mid->getText());
#line 1550 "vcParser.cpp"
			}
			else {
				goto _loop78;
			}
			
		}
		_loop78:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_24);
	}
}

void vcParser::vc_CPFork(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 377 "vc.g"
	
		string lbl;
		vector<string> fork_ids;
	
#line 1576 "vcParser.cpp"
	
	try {      // for error handling
		match(FORK);
		lbl=vc_Label();
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 383 "vc.g"
			fork_ids.push_back(e->getText());
#line 1590 "vcParser.cpp"
			break;
		}
		case RPAREN:
		case SIMPLE_IDENTIFIER:
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
				vc_Identifier();
#line 384 "vc.g"
				fork_ids.push_back(b->getText());
#line 1610 "vcParser.cpp"
			}
			else {
				goto _loop96;
			}
			
		}
		_loop96:;
		} // ( ... )*
		match(RPAREN);
#line 385 "vc.g"
		bb->Add_Fork_Point(lbl,fork_ids);
#line 1622 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPJoin(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 363 "vc.g"
	
		string lbl;
		vector<string> join_ids;
	
#line 1639 "vcParser.cpp"
	
	try {      // for error handling
		match(JOIN);
		lbl=vc_Label();
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 369 "vc.g"
			join_ids.push_back(e->getText());
#line 1653 "vcParser.cpp"
			break;
		}
		case RPAREN:
		case SIMPLE_IDENTIFIER:
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
				vc_Identifier();
#line 370 "vc.g"
				join_ids.push_back(b->getText());
#line 1673 "vcParser.cpp"
			}
			else {
				goto _loop92;
			}
			
		}
		_loop92:;
		} // ( ... )*
		match(RPAREN);
#line 371 "vc.g"
		bb->Add_Join_Point(lbl,join_ids);
#line 1685 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_WireDeclaration(
	vcDataPath* dp
) {
#line 484 "vc.g"
	
		vcType* t;
		string obj_name;
	
#line 1701 "vcParser.cpp"
	
	try {      // for error handling
		match(WIRE);
		vc_Object_Declaration_Base(&t, obj_name, NULL);
#line 490 "vc.g"
		dp->Add_Wire(obj_name, t);
#line 1708 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_DatapathElementInstantiation(
	vcDataPath* dp
) {
#line 405 "vc.g"
	
		string id;
		string template_id;
		vcDatapathElement* dpe;
	
#line 1725 "vcParser.cpp"
	
	try {      // for error handling
		match(DPEINSTANCE);
		id=vc_Label();
		match(OF);
		template_id=vc_Label();
#line 410 "vc.g"
		dpe = new vcDatapathElement(id,template_id);
#line 1734 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case PARAMETER:
		{
			match(PARAMETER);
			match(MAP);
			{ // ( ... )+
			int _cnt103=0;
			for (;;) {
				if ((LA(1) == SIMPLE_IDENTIFIER)) {
					vc_Identifier();
					match(IMPLIES);
					vc_Identifier();
#line 413 "vc.g"
					dpe->Set_Parameter(paramid->getText(), atoi(vid->getText().c_str()));
#line 1751 "vcParser.cpp"
				}
				else {
					if ( _cnt103>=1 ) { goto _loop103; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt103++;
			}
			_loop103:;
			}  // ( ... )+
			break;
		}
		case RBRACE:
		case PORT:
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
		{
		switch ( LA(1)) {
		case PORT:
		{
			match(PORT);
			match(MAP);
			{ // ( ... )+
			int _cnt106=0;
			for (;;) {
				if ((LA(1) == SIMPLE_IDENTIFIER)) {
					vc_Identifier();
					match(IMPLIES);
					vc_Identifier();
#line 415 "vc.g"
					dpe->Connect_Wire(portid->getText(),dp->Get_Wire(wid->getText()));
#line 1790 "vcParser.cpp"
				}
				else {
					if ( _cnt106>=1 ) { goto _loop106; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt106++;
			}
			_loop106:;
			}  // ( ... )+
			break;
		}
		case RBRACE:
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
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(dpe);
			}
			else {
				goto _loop108;
			}
			
		}
		_loop108:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_Interface_Object_Declaration(
	vcModule* parent, string mode
) {
#line 454 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 1842 "vcParser.cpp"
	
	try {      // for error handling
		vc_Object_Declaration_Base(&t,obj_name,&v);
#line 461 "vc.g"
		
			if(mode == "in") parent->Add_Input_Argument(obj_name,t,v);
			else parent->Add_Output_Argument(obj_name,t,v);
		
#line 1851 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcType** t, string& obj_name, vcValue** v
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 470 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	
#line 1868 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 475 "vc.g"
		obj_name = id->getText();
#line 1875 "vcParser.cpp"
		match(COLON);
		tt=vc_Type();
		{
		switch ( LA(1)) {
		case ASSIGNEQUAL:
		{
			match(ASSIGNEQUAL);
			vv=vc_Value(*t);
			break;
		}
		case RBRACE:
		case RPAREN:
		case SIMPLE_IDENTIFIER:
		case DPEINSTANCE:
		case WIRE:
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
#line 476 "vc.g"
		*t = tt; *v = vv;
#line 1903 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

vcValue*  vcParser::vc_IntValue(
	vcType* t
) {
#line 537 "vc.g"
	vcValue* v;
#line 1916 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 537 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcIntType"));
	
#line 1925 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case BINARYSTRING:
		{
			{
			bid = LT(1);
			match(BINARYSTRING);
#line 542 "vc.g"
			vstring = bid->getText(); format = "binary";
#line 1936 "vcParser.cpp"
			}
			break;
		}
		case HEXSTRING:
		{
			{
			hid = LT(1);
			match(HEXSTRING);
#line 543 "vc.g"
			vstring = hid->getText(); format = "hexadecimal";
#line 1947 "vcParser.cpp"
			}
#line 544 "vc.g"
			
				v = (vcValue*) (new vcIntValue(t,vstring,format));
			
#line 1953 "vcParser.cpp"
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
		recover(ex,_tokenSet_28);
	}
	return v;
}

vcValue*  vcParser::vc_FloatValue(
	vcType* t
) {
#line 552 "vc.g"
	vcValue* v;
#line 1974 "vcParser.cpp"
#line 552 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcFloatType"));
		char sign_value = 0;
		vcIntValue* cv;
		vcIntValue* mv;
	
#line 1984 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case MINUS:
		{
			match(MINUS);
#line 560 "vc.g"
			sign_value = 1;
#line 1994 "vcParser.cpp"
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
		cv=vc_IntValue(t->Get_Characteristic_Type());
		match(LITERAL_M);
		mv=vc_IntValue(t->Get_Mantissa_Type());
#line 561 "vc.g"
		
			v = (vcValue*) (new vcFloatValue(t,sign_value, cv, mv));
		
#line 2015 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType() {
#line 575 "vc.g"
	vcType* t;
#line 2027 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case INT:
		{
			{
			t=vc_IntType();
			}
			break;
		}
		case FLOAT:
		{
			{
			t=vc_FloatType();
			}
			break;
		}
		case POINTER:
		{
			{
			t=vc_PointerType();
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
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_ArrayType() {
#line 617 "vc.g"
	vcType* t;
#line 2068 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 617 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 2076 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 622 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 2085 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type();
#line 623 "vc.g"
		at = new vcArrayType(et,dimension); t = (vcType*) at;
#line 2091 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_RecordType() {
#line 629 "vc.g"
	vcType* t;
#line 2103 "vcParser.cpp"
#line 629 "vc.g"
	
		vcRecordType* rt;
		vcElementType* et;
		vector<vcType*> etypes;
	
#line 2110 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		match(LBRACKET);
		{
		et=vc_Type();
#line 634 "vc.g"
		etypes.push_back(et);
#line 2119 "vcParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				t=vc_Type();
#line 634 "vc.g"
				etypes.push_back(et);
#line 2128 "vcParser.cpp"
			}
			else {
				goto _loop149;
			}
			
		}
		_loop149:;
		} // ( ... )*
		match(RBRACKET);
#line 635 "vc.g"
		rt = new vcRecordType(etypes); t = (vcType*) rt; etypes.clear();
#line 2140 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_IntType() {
#line 581 "vc.g"
	vcType* t;
#line 2152 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 581 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 2159 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(LESS);
		i = LT(1);
		match(UINTEGER);
#line 586 "vc.g"
		w = atoi(i->getText().c_str());
#line 2168 "vcParser.cpp"
		match(GREATER);
#line 586 "vc.g"
		it = vcProgram::Make_Integer_Type(w); t = (vcType*)it;
#line 2172 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_FloatType() {
#line 592 "vc.g"
	vcType* t;
#line 2184 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 592 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 2192 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(LESS);
		cid = LT(1);
		match(UINTEGER);
#line 597 "vc.g"
		c = atoi(cid->getText().c_str());
#line 2201 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 597 "vc.g"
		m = atoi(mid->getText().c_str());
#line 2207 "vcParser.cpp"
		match(GREATER);
#line 598 "vc.g"
		ft = vcProgram::Make_Float_Type(c,m); t = (vcType*)ft;
#line 2211 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_PointerType() {
#line 605 "vc.g"
	vcType* t;
#line 2223 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 605 "vc.g"
	
		vcPointerType* pt;
		string space_id; 
	
#line 2230 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(LESS);
		id = LT(1);
		match(HIERARCHICAL_IDENTIFIER);
#line 611 "vc.g"
		space_id = id->getText(); pt = new vcPointer(space_id); t = (vcType*) pt;
#line 2239 "vcParser.cpp"
		match(GREATER);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
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
	"LIBRARY",
	"LBRACE",
	"RBRACE",
	"DPE",
	"PARAMETER",
	"LPAREN",
	"UINTEGER",
	"RPAREN",
	"IN",
	"OUT",
	"COLON",
	"TEMPLATE",
	"FLOAT",
	"LESS",
	"SIMPLE_IDENTIFIER",
	"GREATER",
	"INT",
	"REQS",
	"ACKS",
	"MEMORYSPACE",
	"CAPACITY",
	"DATAWIDTH",
	"ADDRWIDTH",
	"OBJECT",
	"ASSIGNEQUAL",
	"MODULE",
	"LINK",
	"IMPLIES",
	"CONTROLPATH",
	"PLACE",
	"TRANSITION",
	"HIDDEN",
	"SERIESBLOCK",
	"PARALLELBLOCK",
	"BRANCHBLOCK",
	"MERGE",
	"ENTRY",
	"BRANCH",
	"EXIT",
	"FORKBLOCK",
	"JOIN",
	"FORK",
	"DATAPATH",
	"DPEINSTANCE",
	"OF",
	"MAP",
	"PORT",
	"LBRACKET",
	"RBRACKET",
	"WIRE",
	"COMMA",
	"BINARYSTRING",
	"HEXSTRING",
	"MINUS",
	"\"C\"",
	"\"M\"",
	"POINTER",
	"HIERARCHICAL_IDENTIFIER",
	"ARRAY",
	"RECORD",
	"ATTRIBUTE",
	"QUOTED_STRING",
	"WHITESPACE",
	"SINGLELINECOMMENT",
	"ALPHA",
	"DIGIT",
	0
};

const unsigned long vcParser::_tokenSet_0_data_[] = { 2UL, 0UL, 0UL, 0UL };
// EOF 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_0(_tokenSet_0_data_,4);
const unsigned long vcParser::_tokenSet_1_data_[] = { 545259538UL, 0UL, 0UL, 0UL };
// EOF LIBRARY MEMORYSPACE MODULE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,4);
const unsigned long vcParser::_tokenSet_2_data_[] = { 545259602UL, 0UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIBRARY RBRACE MEMORYSPACE MODULE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 16928UL, 65536UL, 0UL, 0UL };
// LBRACE LPAREN COLON OF 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,4);
const unsigned long vcParser::_tokenSet_4_data_[] = { 192UL, 0UL, 0UL, 0UL };
// RBRACE DPE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,4);
const unsigned long vcParser::_tokenSet_5_data_[] = { 2109440UL, 0UL, 0UL, 0UL };
// IN OUT REQS 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,4);
const unsigned long vcParser::_tokenSet_6_data_[] = { 2105344UL, 0UL, 0UL, 0UL };
// OUT REQS 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,4);
const unsigned long vcParser::_tokenSet_7_data_[] = { 2097152UL, 0UL, 0UL, 0UL };
// REQS 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,4);
const unsigned long vcParser::_tokenSet_8_data_[] = { 4194304UL, 0UL, 0UL, 0UL };
// ACKS 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,4);
const unsigned long vcParser::_tokenSet_9_data_[] = { 64UL, 0UL, 0UL, 0UL };
// RBRACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,4);
const unsigned long vcParser::_tokenSet_10_data_[] = { 2151971904UL, 264318UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE UINTEGER RPAREN IN OUT COLON SIMPLE_IDENTIFIER ACKS IMPLIES PLACE 
// TRANSITION HIDDEN SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK PORT 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,8);
const unsigned long vcParser::_tokenSet_11_data_[] = { 2367488UL, 0UL, 0UL, 0UL };
// OUT SIMPLE_IDENTIFIER REQS 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,4);
const unsigned long vcParser::_tokenSet_12_data_[] = { 134217792UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,4);
const unsigned long vcParser::_tokenSet_13_data_[] = { 402917440UL, 7372800UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER OBJECT ASSIGNEQUAL DPEINSTANCE RBRACKET 
// WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,8);
const unsigned long vcParser::_tokenSet_14_data_[] = { 134481984UL, 6324224UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER OBJECT DPEINSTANCE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,8);
const unsigned long vcParser::_tokenSet_15_data_[] = { 8192UL, 0UL, 0UL, 0UL };
// OUT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,4);
const unsigned long vcParser::_tokenSet_16_data_[] = { 0UL, 1UL, 0UL, 0UL };
// CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,4);
const unsigned long vcParser::_tokenSet_17_data_[] = { 0UL, 2160UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,4);
const unsigned long vcParser::_tokenSet_18_data_[] = { 0UL, 16384UL, 0UL, 0UL };
// DATAPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,4);
const unsigned long vcParser::_tokenSet_19_data_[] = { 1073741824UL, 0UL, 0UL, 0UL };
// LINK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,4);
const unsigned long vcParser::_tokenSet_20_data_[] = { 8388672UL, 0UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE MEMORYSPACE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,8);
const unsigned long vcParser::_tokenSet_21_data_[] = { 64UL, 2129920UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DPEINSTANCE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,8);
const unsigned long vcParser::_tokenSet_22_data_[] = { 64UL, 15094UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK MERGE 
// BRANCH FORKBLOCK JOIN FORK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 64UL, 2166UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,4);
const unsigned long vcParser::_tokenSet_24_data_[] = { 64UL, 2800UL, 0UL, 0UL };
// RBRACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK MERGE BRANCH FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,4);
const unsigned long vcParser::_tokenSet_25_data_[] = { 64UL, 14448UL, 0UL, 0UL };
// RBRACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK JOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,4);
const unsigned long vcParser::_tokenSet_26_data_[] = { 264192UL, 0UL, 0UL, 0UL };
// RPAREN SIMPLE_IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,4);
const unsigned long vcParser::_tokenSet_27_data_[] = { 264256UL, 2129920UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER DPEINSTANCE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,8);
const unsigned long vcParser::_tokenSet_28_data_[] = { 134481984UL, 140541952UL, 1UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER OBJECT DPEINSTANCE WIRE COMMA "M" ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,8);


