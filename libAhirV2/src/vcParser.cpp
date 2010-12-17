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
	
		vcDatapathElementLibrary* lib = NULL;
		vcModule* nf = NULL;
		vcMemorySpace* ms = NULL;
	
#line 47 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case MODULE:
			{
				{
				nf=vc_Module(sys);
#line 48 "vc.g"
				sys->Add_Module(nf);
#line 59 "vcParser.cpp"
				}
				break;
			}
			case MEMORYSPACE:
			{
				{
				ms=vc_MemorySpace(sys);
#line 50 "vc.g"
				sys->Add_Memory_Space(ms);
#line 69 "vcParser.cpp"
				}
				break;
			}
			case LIBRARY:
			{
				{
				lib=vc_Library(sys);
#line 52 "vc.g"
				sys->Add_Library(lib);
#line 79 "vcParser.cpp"
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
#line 213 "vc.g"
	vcModule* m;
#line 103 "vcParser.cpp"
#line 213 "vc.g"
	
		string lbl;
		m = NULL;
	vcMemorySpace* ms;
	
#line 110 "vcParser.cpp"
	
	try {      // for error handling
		match(MODULE);
		lbl=vc_Label();
#line 219 "vc.g"
		m = new vcModule(lbl);
#line 117 "vcParser.cpp"
		match(LBRACE);
		vc_Inargs(sys,m);
		vc_Outargs(sys,m);
		vc_Controlpath(sys,m);
		vc_Datapath(sys,m);
		vc_Link(m);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == MEMORYSPACE)) {
				ms=vc_MemorySpace(sys);
#line 220 "vc.g"
				m->Add_Memory_Space(ms);
#line 130 "vcParser.cpp"
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

vcMemorySpace*  vcParser::vc_MemorySpace(
	vcSystem* sys
) {
#line 175 "vc.g"
	vcMemorySpace* ms;
#line 165 "vcParser.cpp"
#line 175 "vc.g"
	
		string lbl;
		ms = NULL;
	
#line 171 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		lbl=vc_Label();
#line 180 "vc.g"
		ms = new vcMemorySpace(lbl);
#line 178 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(sys,ms);
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

vcDatapathElementLibrary*  vcParser::vc_Library(
	vcSystem* sys
) {
#line 60 "vc.g"
	vcDatapathElementLibrary* new_lib;
#line 207 "vcParser.cpp"
#line 60 "vc.g"
	
		string lbl = "";
		vcDatapathElementTemplate* e;
		new_lib = NULL;
	
#line 214 "vcParser.cpp"
	
	try {      // for error handling
		match(LIBRARY);
		lbl=vc_Label();
#line 66 "vc.g"
		new_lib = new vcDatapathElementLibrary(lbl);
#line 221 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == DPE)) {
				e=vc_DatapathElementTemplate(sys);
#line 67 "vc.g"
				new_lib->Add_Template(e);
#line 229 "vcParser.cpp"
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
#line 449 "vc.g"
	string lbl;
#line 250 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		{
		match(LBRACKET);
		}
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 451 "vc.g"
		lbl = id->getText();
#line 262 "vcParser.cpp"
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

vcDatapathElementTemplate*  vcParser::vc_DatapathElementTemplate(
	vcSystem* sys
) {
#line 73 "vc.g"
	vcDatapathElementTemplate* t;
#line 280 "vcParser.cpp"
#line 73 "vc.g"
	
		string lbl = "";
	
#line 285 "vcParser.cpp"
	
	try {      // for error handling
		match(DPE);
		lbl=vc_Label();
#line 77 "vc.g"
		t = new vcDatapathElementTemplate(lbl);
#line 292 "vcParser.cpp"
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
	vcDatapathElementTemplate* p
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  minval = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  maxval = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 85 "vc.g"
	
		string pname;
		unsigned int min_val, max_val;
	
#line 373 "vcParser.cpp"
	
	try {      // for error handling
		match(PARAMETER);
		match(LPAREN);
		{ // ( ... )+
		int _cnt18=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				pname=vc_Identifier();
				minval = LT(1);
				match(UINTEGER);
#line 92 "vc.g"
				min_val = atoi(minval->getText().c_str());
#line 387 "vcParser.cpp"
				maxval = LT(1);
				match(UINTEGER);
#line 93 "vc.g"
				max_val = atoi(maxval->getText().c_str()); p->Add_Parameter(pname,min_val,max_val);
#line 392 "vcParser.cpp"
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
	vcDatapathElementTemplate* t
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
	vcDatapathElementTemplate* t
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
	vcDatapathElementTemplate* t
) {
#line 153 "vc.g"
	
	string lbl;
	
#line 445 "vcParser.cpp"
	
	try {      // for error handling
		match(REQS);
		{ // ( ... )+
		int _cnt30=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				lbl=vc_Identifier();
#line 158 "vc.g"
				t->Add_Req(lbl);
#line 456 "vcParser.cpp"
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
	vcDatapathElementTemplate* t
) {
#line 164 "vc.g"
	
	string lbl;
	
#line 480 "vcParser.cpp"
	
	try {      // for error handling
		match(ACKS);
		{ // ( ... )+
		int _cnt33=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				lbl=vc_Identifier();
#line 169 "vc.g"
				t->Add_Ack(lbl);
#line 491 "vcParser.cpp"
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

string  vcParser::vc_Identifier() {
#line 681 "vc.g"
	string s;
#line 511 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 681 "vc.g"
		s = id->getText();
#line 519 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
	return s;
}

void vcParser::vc_DpePorts(
	vcDatapathElementTemplate* t, string mode
) {
#line 118 "vc.g"
	
	string pname;
		vcScalarTypeTemplate* tt;
	
#line 536 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )+
		int _cnt23=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				pname=vc_Identifier();
				match(COLON);
				tt=vc_ScalarTypeTemplate();
#line 125 "vc.g"
				
				if(mode == "in") 
				t->Add_Input_Port(pname, tt);
				else
				t->Add_Output_Port(pname, tt);
				
#line 553 "vcParser.cpp"
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
#line 138 "vc.g"
	vcScalarTypeTemplate* t;
#line 573 "vcParser.cpp"
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
#line 140 "vc.g"
			
			t = new vcScalarTypeTemplate(c->getText(),m->getText());
			
#line 596 "vcParser.cpp"
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
#line 144 "vc.g"
			
			t = new vcScalarTypeTemplate(w->getText());
			
#line 612 "vcParser.cpp"
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
#line 187 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 643 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 188 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 649 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 189 "vc.g"
		ms->Set_Word_Size(atoi(aw->getText().c_str()));
#line 655 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 195 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 673 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
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
#line 203 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
			if(v != NULL)
				nl->Set_Value(v);
		
#line 705 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 593 "vc.g"
	vcType* t;
#line 718 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case FLOAT:
		case INT:
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
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 520 "vc.g"
	vcValue* v;
#line 765 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 520 "vc.g"
	
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
	
#line 785 "vcParser.cpp"
	
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
#line 541 "vc.g"
			evalues.push_back(ev);
#line 824 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 542 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 831 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 542 "vc.g"
					evalues.push_back(ev);
#line 835 "vcParser.cpp"
				}
				else {
					goto _loop127;
				}
				
			}
			_loop127:;
			} // ( ... )*
#line 544 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 853 "vcParser.cpp"
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
	vcSystem* sys, vcModule* parent
) {
#line 457 "vc.g"
	
		string mode = "out";
	
#line 878 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
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
	vcSystem* sys, vcModule* parent
) {
#line 468 "vc.g"
	
		string mode = "out";
	
#line 910 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
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
	vcSystem* sys, vcModule* m
) {
#line 238 "vc.g"
	
		vcControlPath* cp = new vcControlPath(m->Get_Id() + "_CP");
	
#line 942 "vcParser.cpp"
	
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
	vcSystem* sys,vcModule* m
) {
#line 409 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m->Get_Id() + "_DP");
	
#line 986 "vcParser.cpp"
	
	try {      // for error handling
		match(DATAPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case WIRE:
			{
				vc_WireDeclaration(sys,dp);
				break;
			}
			case DPEINSTANCE:
			{
				vc_DatapathElementInstantiation(sys,m,dp);
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
#line 227 "vc.g"
	
	string tid,dpeid,reqackid;
	
#line 1032 "vcParser.cpp"
	
	try {      // for error handling
		match(LINK);
		match(LPAREN);
		tid=vc_Identifier();
		match(IMPLIES);
		dpeid=vc_Identifier();
		match(COLON);
		reqackid=vc_Identifier();
		match(RPAREN);
#line 232 "vc.g"
		m->Add_Link(tid, dpeid, reqackid);
#line 1045 "vcParser.cpp"
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
#line 666 "vc.g"
	
		string key;
		string value;
	
#line 1063 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		match(LPAREN);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 672 "vc.g"
		key = kid->getText();
#line 1072 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 672 "vc.g"
		value = vid->getText();
#line 1078 "vcParser.cpp"
		match(RPAREN);
#line 673 "vc.g"
		m->Add_Attribute(key,value);
#line 1082 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
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
		recover(ex,_tokenSet_22);
	}
}

vcCPElement*  vcParser::vc_CPElement() {
#line 248 "vc.g"
	vcCPElement* cpe;
#line 1131 "vcParser.cpp"
	
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
#line 255 "vc.g"
	vcCPElement* cpe;
#line 1165 "vcParser.cpp"
#line 255 "vc.g"
	
	string id;
	
#line 1170 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Identifier();
#line 259 "vc.g"
		cpe = (vcCPElement*) new vcPlace(id,0);
#line 1177 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPTransition() {
#line 265 "vc.g"
	vcCPElement* cpe;
#line 1189 "vcParser.cpp"
#line 265 "vc.g"
	
	vcTransitionType t;
	string id;
	
#line 1195 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Identifier();
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 270 "vc.g"
			t = _IN_TRANSITION;
#line 1208 "vcParser.cpp"
			}
			break;
		}
		case OUT:
		{
			{
			match(OUT);
#line 270 "vc.g"
			t = _OUT_TRANSITION;
#line 1218 "vcParser.cpp"
			}
			break;
		}
		case HIDDEN:
		{
			{
			match(HIDDEN);
#line 270 "vc.g"
			t = _HIDDEN_TRANSITION;
#line 1228 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 271 "vc.g"
		
		cpe = (vcCPElement*) (new vcTransition(id,t));
		
#line 1242 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
	return cpe;
}

void vcParser::vc_CPSeriesBlock(
	vcCPBlock* cp
) {
#line 290 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1260 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 296 "vc.g"
		sb = new vcCPSeriesBlock(lbl);
#line 1267 "vcParser.cpp"
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
#line 297 "vc.g"
				sb->Add_CPElement(cpe);
#line 1280 "vcParser.cpp"
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
#line 299 "vc.g"
		cp->Add_CPElement(sb);
#line 1306 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 305 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	
#line 1323 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 311 "vc.g"
		sb = new vcCPParallelBlock(lbl);
#line 1330 "vcParser.cpp"
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
#line 313 "vc.g"
		cp->Add_CPElement(sb);
#line 1349 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 319 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1366 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 325 "vc.g"
		sb = new vcCPBranchBlock(lbl);
#line 1373 "vcParser.cpp"
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
			case FROM:
			{
				{
				vc_CPBranch(sb);
				}
				break;
			}
			case AT:
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
#line 329 "vc.g"
		cp->Add_CPElement(sb);
#line 1415 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 365 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1432 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 371 "vc.g"
		fb = new vcCPForkBlock(lbl);
#line 1439 "vcParser.cpp"
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
#line 375 "vc.g"
		cp->Add_CPElement(fb);
#line 1481 "vcParser.cpp"
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
#line 350 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 1498 "vcParser.cpp"
	
	try {      // for error handling
		match(FROM);
		lbl=vc_Label();
		match(BRANCH);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case EXIT:
		{
			e = LT(1);
			match(EXIT);
#line 357 "vc.g"
			branch_ids.push_back(e->getText());
#line 1513 "vcParser.cpp"
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
				b=vc_Identifier();
#line 358 "vc.g"
				branch_ids.push_back(b);
#line 1533 "vcParser.cpp"
			}
			else {
				goto _loop82;
			}
			
		}
		_loop82:;
		} // ( ... )*
		match(RPAREN);
#line 359 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1545 "vcParser.cpp"
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
#line 335 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 1562 "vcParser.cpp"
	
	try {      // for error handling
		match(AT);
		lbl=vc_Label();
		match(MERGE);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 341 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1577 "vcParser.cpp"
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
				mid=vc_Identifier();
#line 342 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 1597 "vcParser.cpp"
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
#line 395 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 1623 "vcParser.cpp"
	
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
#line 401 "vc.g"
			fork_ids.push_back(e->getText());
#line 1637 "vcParser.cpp"
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
				b=vc_Identifier();
#line 402 "vc.g"
				fork_ids.push_back(b);
#line 1657 "vcParser.cpp"
			}
			else {
				goto _loop96;
			}
			
		}
		_loop96:;
		} // ( ... )*
		match(RPAREN);
#line 403 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 1669 "vcParser.cpp"
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
#line 381 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 1686 "vcParser.cpp"
	
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
#line 387 "vc.g"
			join_ids.push_back(e->getText());
#line 1700 "vcParser.cpp"
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
				b=vc_Identifier();
#line 388 "vc.g"
				join_ids.push_back(b);
#line 1720 "vcParser.cpp"
			}
			else {
				goto _loop92;
			}
			
		}
		_loop92:;
		} // ( ... )*
		match(RPAREN);
#line 389 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 1732 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_WireDeclaration(
	vcSystem* sys,vcDataPath* dp
) {
#line 507 "vc.g"
	
		vcType* t;
		string obj_name;
	
#line 1748 "vcParser.cpp"
	
	try {      // for error handling
		match(WIRE);
		vc_Object_Declaration_Base(sys, &t, obj_name, NULL);
#line 513 "vc.g"
		dp->Add_Wire(obj_name, t);
#line 1755 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_DatapathElementInstantiation(
	vcSystem* sys, vcModule* m, vcDataPath* dp
) {
#line 424 "vc.g"
	
		string id;
		string template_id,param_id,vid,port_id,wid,lib_id;
		vcDatapathElement* dpe;
	
#line 1772 "vcParser.cpp"
	
	try {      // for error handling
		match(DPEINSTANCE);
		id=vc_Label();
		match(OF);
		lib_id=vc_Identifier();
		match(COLON);
		template_id=vc_Identifier();
#line 430 "vc.g"
		
		vcDatapathElementTemplate* tt = sys->Get_DPE_Template(lib_id,template_id);
		assert(tt != NULL);
		dpe = new vcDatapathElement(id,tt);
		
#line 1787 "vcParser.cpp"
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
					param_id=vc_Identifier();
					match(IMPLIES);
					vid=vc_Identifier();
#line 437 "vc.g"
					dpe->Set_Parameter(param_id, atoi(vid.c_str()));
#line 1804 "vcParser.cpp"
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
					port_id=vc_Identifier();
					match(IMPLIES);
					wid=vc_Identifier();
#line 439 "vc.g"
					assert(dp->Find_Wire(wid) != NULL); dpe->Connect_Wire(port_id,dp->Find_Wire(wid));
#line 1843 "vcParser.cpp"
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
	vcSystem* sys, vcModule* parent, string mode
) {
#line 478 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 1895 "vcParser.cpp"
	
	try {      // for error handling
		vc_Object_Declaration_Base(sys, &t,obj_name,&v);
#line 485 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 1903 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 493 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	
#line 1920 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 498 "vc.g"
		obj_name = id->getText();
#line 1927 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
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
#line 499 "vc.g"
		*t = tt; *v = vv;
#line 1955 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

vcValue*  vcParser::vc_IntValue(
	vcType* t
) {
#line 560 "vc.g"
	vcValue* v;
#line 1968 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 560 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcIntType"));
	
#line 1977 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case BINARYSTRING:
		{
			{
			bid = LT(1);
			match(BINARYSTRING);
#line 565 "vc.g"
			vstring = bid->getText(); format = "binary";
#line 1988 "vcParser.cpp"
			}
			break;
		}
		case HEXSTRING:
		{
			{
			hid = LT(1);
			match(HEXSTRING);
#line 566 "vc.g"
			vstring = hid->getText(); format = "hexadecimal";
#line 1999 "vcParser.cpp"
			}
#line 567 "vc.g"
			
				v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring,format));
			
#line 2005 "vcParser.cpp"
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
#line 575 "vc.g"
	vcValue* v;
#line 2026 "vcParser.cpp"
#line 575 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcFloatType"));
		char sign_value = 0;
		vcValue* cv;
		vcValue* mv;
	assert(t != NULL && t->Is("vcFloatType"));
	
#line 2037 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case MINUS:
		{
			match(MINUS);
#line 584 "vc.g"
			sign_value = 1;
#line 2047 "vcParser.cpp"
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
#line 585 "vc.g"
		
			v = (vcValue*) (new vcFloatValue((vcFloatType*)t,sign_value, (vcIntValue*)cv, (vcIntValue*)mv));
		
#line 2068 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType(
	vcSystem* sys
) {
#line 599 "vc.g"
	vcType* t;
#line 2082 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_ArrayType(
	vcSystem* sys
) {
#line 642 "vc.g"
	vcType* t;
#line 2125 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 642 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 2133 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 647 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 2142 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 648 "vc.g"
		at = sys->Make_Array_Type(et,dimension); t = (vcType*) at;
#line 2148 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_RecordType(
	vcSystem* sys
) {
#line 654 "vc.g"
	vcType* t;
#line 2162 "vcParser.cpp"
#line 654 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 2169 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		match(LBRACKET);
		{
		et=vc_Type(sys);
#line 659 "vc.g"
		etypes.push_back(et);
#line 2178 "vcParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				t=vc_Type(sys);
#line 659 "vc.g"
				etypes.push_back(et);
#line 2187 "vcParser.cpp"
			}
			else {
				goto _loop150;
			}
			
		}
		_loop150:;
		} // ( ... )*
		match(RBRACKET);
#line 660 "vc.g"
		rt = sys->Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 2199 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_IntType(
	vcSystem* sys
) {
#line 605 "vc.g"
	vcType* t;
#line 2213 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 605 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 2220 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(LESS);
		i = LT(1);
		match(UINTEGER);
#line 610 "vc.g"
		w = atoi(i->getText().c_str());
#line 2229 "vcParser.cpp"
		match(GREATER);
#line 610 "vc.g"
		it = sys->Make_Integer_Type(w); t = (vcType*)it;
#line 2233 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_FloatType(
	vcSystem* sys
) {
#line 616 "vc.g"
	vcType* t;
#line 2247 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 616 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 2255 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(LESS);
		cid = LT(1);
		match(UINTEGER);
#line 621 "vc.g"
		c = atoi(cid->getText().c_str());
#line 2264 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 621 "vc.g"
		m = atoi(mid->getText().c_str());
#line 2270 "vcParser.cpp"
		match(GREATER);
#line 622 "vc.g"
		ft = sys->Make_Float_Type(c,m); t = (vcType*)ft;
#line 2274 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
	return t;
}

vcType*  vcParser::vc_PointerType(
	vcSystem* sys
) {
#line 629 "vc.g"
	vcType* t;
#line 2288 "vcParser.cpp"
#line 629 "vc.g"
	
		vcPointerType* pt;
	string scope_id;
		string space_id; 
	
#line 2295 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(LESS);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
			scope_id=vc_Identifier();
			match(COLON);
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == GREATER)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		space_id=vc_Identifier();
#line 636 "vc.g"
		pt = sys->Make_Pointer_Type(scope_id,space_id); t = (vcType*) pt;
#line 2315 "vcParser.cpp"
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
	"AT",
	"MERGE",
	"ENTRY",
	"FROM",
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
	"ARRAY",
	"RECORD",
	"ATTRIBUTE",
	"QUOTED_STRING",
	"MIN",
	"MAX",
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
const unsigned long vcParser::_tokenSet_1_data_[] = { 545259538UL, 0UL, 0UL, 0UL };
// EOF LIBRARY MEMORYSPACE MODULE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,4);
const unsigned long vcParser::_tokenSet_2_data_[] = { 545259602UL, 0UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIBRARY RBRACE MEMORYSPACE MODULE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 16928UL, 264448UL, 0UL, 0UL };
// LBRACE LPAREN COLON MERGE BRANCH OF 
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
const unsigned long vcParser::_tokenSet_10_data_[] = { 2152496224UL, 1056894UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// LBRACE RBRACE UINTEGER RPAREN IN OUT COLON SIMPLE_IDENTIFIER GREATER 
// ACKS IMPLIES PLACE TRANSITION HIDDEN SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// FORKBLOCK PORT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,8);
const unsigned long vcParser::_tokenSet_11_data_[] = { 2367488UL, 0UL, 0UL, 0UL };
// OUT SIMPLE_IDENTIFIER REQS 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,4);
const unsigned long vcParser::_tokenSet_12_data_[] = { 134217792UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,4);
const unsigned long vcParser::_tokenSet_13_data_[] = { 402917440UL, 29491200UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER OBJECT ASSIGNEQUAL DPEINSTANCE RBRACKET 
// WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,8);
const unsigned long vcParser::_tokenSet_14_data_[] = { 134481984UL, 25296896UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER OBJECT DPEINSTANCE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,8);
const unsigned long vcParser::_tokenSet_15_data_[] = { 8192UL, 0UL, 0UL, 0UL };
// OUT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,4);
const unsigned long vcParser::_tokenSet_16_data_[] = { 0UL, 1UL, 0UL, 0UL };
// CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,4);
const unsigned long vcParser::_tokenSet_17_data_[] = { 0UL, 8304UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,4);
const unsigned long vcParser::_tokenSet_18_data_[] = { 0UL, 65536UL, 0UL, 0UL };
// DATAPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,4);
const unsigned long vcParser::_tokenSet_19_data_[] = { 1073741824UL, 0UL, 0UL, 0UL };
// LINK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,4);
const unsigned long vcParser::_tokenSet_20_data_[] = { 8388672UL, 0UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE MEMORYSPACE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,8);
const unsigned long vcParser::_tokenSet_21_data_[] = { 64UL, 8519680UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DPEINSTANCE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,8);
const unsigned long vcParser::_tokenSet_22_data_[] = { 64UL, 58614UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM 
// FORKBLOCK JOIN FORK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 64UL, 8310UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,4);
const unsigned long vcParser::_tokenSet_24_data_[] = { 64UL, 9456UL, 0UL, 0UL };
// RBRACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,4);
const unsigned long vcParser::_tokenSet_25_data_[] = { 64UL, 57456UL, 0UL, 0UL };
// RBRACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK JOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,4);
const unsigned long vcParser::_tokenSet_26_data_[] = { 264192UL, 0UL, 0UL, 0UL };
// RPAREN SIMPLE_IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,4);
const unsigned long vcParser::_tokenSet_27_data_[] = { 264256UL, 8519680UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER DPEINSTANCE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,8);
const unsigned long vcParser::_tokenSet_28_data_[] = { 134481984UL, 562167808UL, 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE RPAREN SIMPLE_IDENTIFIER OBJECT DPEINSTANCE WIRE COMMA "M" ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,8);


