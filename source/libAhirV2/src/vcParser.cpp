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
				}
				break;
			}
			case MEMORYSPACE:
			{
				{
				ms=vc_MemorySpace(sys,NULL);
#line 50 "vc.g"
				sys->Add_Memory_Space(ms);
#line 66 "vcParser.cpp"
				}
				break;
			}
			case LIBRARY:
			{
				{
				lib=vc_Library(sys);
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
#line 219 "vc.g"
	vcModule* m;
#line 97 "vcParser.cpp"
#line 219 "vc.g"
	
		string lbl;
		m = NULL;
	vcMemorySpace* ms;
	
#line 104 "vcParser.cpp"
	
	try {      // for error handling
		match(MODULE);
		lbl=vc_Label();
#line 225 "vc.g"
		m = new vcModule(lbl); sys->Add_Module(m);
#line 111 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case IN:
		{
			vc_Inargs(sys,m);
			break;
		}
		case OUT:
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
#line 227 "vc.g"
				m->Add_Memory_Space(ms);
#line 156 "vcParser.cpp"
			}
			else {
				goto _loop46;
			}
			
		}
		_loop46:;
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
		case LINK:
		case PHI:
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
			if ((LA(1) == LINK)) {
				vc_Link(m);
			}
			else {
				goto _loop49;
			}
			
		}
		_loop49:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PHI)) {
				vc_Phi_Link(m);
			}
			else {
				goto _loop51;
			}
			
		}
		_loop51:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(m);
			}
			else {
				goto _loop53;
			}
			
		}
		_loop53:;
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
#line 180 "vc.g"
	vcMemorySpace* ms;
#line 236 "vcParser.cpp"
#line 180 "vc.g"
	
		string lbl;
		ms = NULL;
	
#line 242 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		lbl=vc_Label();
#line 185 "vc.g"
		ms = new vcMemorySpace(lbl,m);
#line 249 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(sys,ms);
			}
			else {
				goto _loop38;
			}
			
		}
		_loop38:;
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
#line 278 "vcParser.cpp"
#line 60 "vc.g"
	
		string lbl = "";
		vcDatapathElementTemplate* e;
		new_lib = NULL;
	
#line 285 "vcParser.cpp"
	
	try {      // for error handling
		match(LIBRARY);
		lbl=vc_Label();
#line 66 "vc.g"
		new_lib = new vcDatapathElementLibrary(lbl); sys->Add_Library(new_lib);
#line 292 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == DPE)) {
				e=vc_DatapathElementTemplate(sys,new_lib);
#line 68 "vc.g"
				new_lib->Add_Template(e);
#line 300 "vcParser.cpp"
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
#line 744 "vc.g"
	string lbl;
#line 321 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 746 "vc.g"
		lbl = id->getText();
#line 331 "vcParser.cpp"
		}
		match(RBRACKET);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	return lbl;
}

vcDatapathElementTemplate*  vcParser::vc_DatapathElementTemplate(
	vcSystem* sys,vcDatapathElementLibrary* lib
) {
#line 75 "vc.g"
	vcDatapathElementTemplate* t;
#line 347 "vcParser.cpp"
#line 75 "vc.g"
	
		string lbl = "";
	
#line 352 "vcParser.cpp"
	
	try {      // for error handling
		match(DPE);
		lbl=vc_Label();
#line 79 "vc.g"
		t = new vcDatapathElementTemplate(lib,lbl);
#line 359 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case PARAMETER:
		{
			vc_DpeParamSpec(t);
			break;
		}
		case RBRACE:
		case IN:
		case OUT:
		case REQS:
		case ACKS:
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
		case IN:
		{
			vc_InDpePorts(t);
			break;
		}
		case RBRACE:
		case OUT:
		case REQS:
		case ACKS:
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
		case OUT:
		{
			vc_OutDpePorts(t);
			break;
		}
		case RBRACE:
		case REQS:
		case ACKS:
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
		case REQS:
		{
			vc_DpeReqs(t);
			break;
		}
		case RBRACE:
		case ACKS:
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
		case ACKS:
		{
			vc_DpeAcks(t);
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
				vc_AttributeSpec(t);
			}
			else {
				goto _loop17;
			}
			
		}
		_loop17:;
		} // ( ... )*
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
#line 89 "vc.g"
	
		string pname;
		unsigned int min_val, max_val;
	
#line 492 "vcParser.cpp"
	
	try {      // for error handling
		match(PARAMETER);
		{ // ( ... )+
		int _cnt20=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				pname=vc_Identifier();
				match(MIN);
				minval = LT(1);
				match(UINTEGER);
#line 96 "vc.g"
				min_val = atoi(minval->getText().c_str());
#line 506 "vcParser.cpp"
				match(MAX);
				maxval = LT(1);
				match(UINTEGER);
#line 98 "vc.g"
				max_val = atoi(maxval->getText().c_str()); p->Add_Parameter(pname,min_val,max_val);
#line 512 "vcParser.cpp"
			}
			else {
				if ( _cnt20>=1 ) { goto _loop20; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt20++;
		}
		_loop20:;
		}  // ( ... )+
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
#line 158 "vc.g"
	
	string lbl;
	
#line 564 "vcParser.cpp"
	
	try {      // for error handling
		match(REQS);
		{ // ( ... )+
		int _cnt32=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				lbl=vc_Identifier();
#line 163 "vc.g"
				t->Add_Req(lbl);
#line 575 "vcParser.cpp"
			}
			else {
				if ( _cnt32>=1 ) { goto _loop32; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt32++;
		}
		_loop32:;
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
#line 169 "vc.g"
	
	string lbl;
	
#line 599 "vcParser.cpp"
	
	try {      // for error handling
		match(ACKS);
		{ // ( ... )+
		int _cnt35=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				lbl=vc_Identifier();
#line 174 "vc.g"
				t->Add_Ack(lbl);
#line 610 "vcParser.cpp"
			}
			else {
				if ( _cnt35>=1 ) { goto _loop35; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt35++;
		}
		_loop35:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
}

void vcParser::vc_AttributeSpec(
	vcRoot* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  kid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  vid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 975 "vc.g"
	
		string key;
		string value;
	
#line 637 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 981 "vc.g"
		key = kid->getText();
#line 645 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 981 "vc.g"
		value = vid->getText();
#line 651 "vcParser.cpp"
#line 982 "vc.g"
		m->Add_Attribute(key,value);
#line 654 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

string  vcParser::vc_Identifier() {
#line 990 "vc.g"
	string s;
#line 665 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 990 "vc.g"
		s = id->getText();
#line 673 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
	return s;
}

void vcParser::vc_DpePorts(
	vcDatapathElementTemplate* t, string mode
) {
#line 123 "vc.g"
	
	string pname;
		vcScalarTypeTemplate* tt;
	
#line 690 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )+
		int _cnt25=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				pname=vc_Identifier();
				match(COLON);
				tt=vc_ScalarTypeTemplate();
#line 130 "vc.g"
				
				if(mode == "in") 
				t->Add_Input_Port(pname, tt);
				else
				t->Add_Output_Port(pname, tt);
				
#line 707 "vcParser.cpp"
			}
			else {
				if ( _cnt25>=1 ) { goto _loop25; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt25++;
		}
		_loop25:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcScalarTypeTemplate*  vcParser::vc_ScalarTypeTemplate() {
#line 143 "vc.g"
	vcScalarTypeTemplate* t;
#line 727 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  c = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  m = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  w = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case FLOAT:
		{
			{
			match(FLOAT);
			match(LESS);
			c = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(COMMA);
			m = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(GREATER);
#line 145 "vc.g"
			
			t = new vcScalarTypeTemplate(c->getText(),m->getText());
			
#line 750 "vcParser.cpp"
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
#line 149 "vc.g"
			
			t = new vcScalarTypeTemplate(w->getText());
			
#line 766 "vcParser.cpp"
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
		recover(ex,_tokenSet_12);
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
#line 192 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 797 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 193 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 803 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 194 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 809 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 200 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 827 "vcParser.cpp"
	
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
#line 208 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
			if(v != NULL)
				nl->Set_Value(v);
		ms->Add_Storage_Object(nl);
		
#line 860 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_13);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 903 "vc.g"
	vcType* t;
#line 873 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_14);
	}
	return t;
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 830 "vc.g"
	vcValue* v;
#line 920 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 830 "vc.g"
	
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
	
#line 940 "vcParser.cpp"
	
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
#line 851 "vc.g"
			evalues.push_back(ev);
#line 979 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 852 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 986 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 852 "vc.g"
					evalues.push_back(ev);
#line 990 "vcParser.cpp"
				}
				else {
					goto _loop198;
				}
				
			}
			_loop198:;
			} // ( ... )*
#line 854 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 1008 "vcParser.cpp"
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
		recover(ex,_tokenSet_15);
	}
	return v;
}

void vcParser::vc_Inargs(
	vcSystem* sys, vcModule* parent
) {
#line 752 "vc.g"
	
		string mode = "in";
	
#line 1033 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
			}
			else {
				goto _loop185;
			}
			
		}
		_loop185:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_16);
	}
}

void vcParser::vc_Outargs(
	vcSystem* sys, vcModule* parent
) {
#line 763 "vc.g"
	
		string mode = "out";
	
#line 1063 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop188;
			}
			
		}
		_loop188:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_17);
	}
}

void vcParser::vc_Controlpath(
	vcSystem* sys, vcModule* m
) {
#line 291 "vc.g"
	
		vcControlPath* cp = new vcControlPath(m->Get_Id() + "_CP");
	
#line 1093 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_18.member(LA(1)))) {
				vc_CPRegion(cp);
			}
			else {
				goto _loop63;
			}
			
		}
		_loop63:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(cp);
			}
			else {
				goto _loop65;
			}
			
		}
		_loop65:;
		} // ( ... )*
		match(RBRACE);
#line 295 "vc.g"
		m->Set_Control_Path(cp);
#line 1125 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 463 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
	
#line 1140 "vcParser.cpp"
	
	try {      // for error handling
		match(DATAPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case CONSTANT:
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
			case PLUS_OP:
			case MINUS_OP:
			case MUL_OP:
			case DIV_OP:
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
			case NOP_OP:
			case BRANCH_OP:
			case SELECT_OP:
			{
				vc_OperatorInstantiation(sys,dp);
				break;
			}
			case PHI:
			{
				vc_PhiInstantiation(dp);
				break;
			}
			case CALL:
			{
				vc_CallInstantiation(sys,dp);
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
				goto _loop122;
			}
			}
		}
		_loop122:;
		} // ( ... )*
		match(RBRACE);
#line 475 "vc.g"
		m->Set_Data_Path(dp);
#line 1224 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
}

void vcParser::vc_Link(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpeid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  reqackid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 237 "vc.g"
	
	vector<string> ref_vec;
	
#line 1241 "vcParser.cpp"
	
	try {      // for error handling
		match(LINK);
		vc_Hierarchical_CP_Ref(ref_vec);
		match(EQUIVALENT);
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
		match(SLASH);
		reqackid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 242 "vc.g"
		m->Add_Link(ref_vec, dpeid->getText(), reqackid->getText());
#line 1254 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
}

void vcParser::vc_Phi_Link(
	vcModule* m
) {
#line 250 "vc.g"
	
	vector<string> ref_vec;
	string phi_id;
	vcPhi* phi;
	vcTransition* t;
	vector<vcTransition*> inreqs;
	vcTransition* outack;
	
#line 1274 "vcParser.cpp"
	
	try {      // for error handling
		match(PHI);
		match(LINK);
		phi_id=vc_Identifier();
#line 259 "vc.g"
		phi = m->Get_Data_Path()->Find_Phi(phi_id); assert(phi != NULL);
#line 1282 "vcParser.cpp"
		match(REQS);
		{ // ( ... )+
		int _cnt57=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 261 "vc.g"
				
				t = m->Get_Control_Path()->Find_Transition(ref_vec); 
				assert(t != NULL);
				inreqs.push_back(t);
				ref_vec.clear();
				
#line 1296 "vcParser.cpp"
			}
			else {
				if ( _cnt57>=1 ) { goto _loop57; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt57++;
		}
		_loop57:;
		}  // ( ... )+
		match(ACKS);
		vc_Hierarchical_CP_Ref(ref_vec);
#line 268 "vc.g"
		
		outack = m->Get_Control_Path()->Find_Transition(ref_vec); 
		assert(outack != NULL);
		phi->Set_Inreqs(inreqs);
		phi->Set_Ack(outack);
		
		m->Add_Phi_Link(phi,inreqs,outack);
		
#line 1317 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_Hierarchical_CP_Ref(
	vector<string>& ref_vec
) {
#line 281 "vc.g"
	
	string id;
	
#line 1332 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == SLASH)) {
				id=vc_Identifier();
#line 285 "vc.g"
				ref_vec.push_back(id);
#line 1341 "vcParser.cpp"
				match(SLASH);
			}
			else {
				goto _loop60;
			}
			
		}
		_loop60:;
		} // ( ... )*
		id=vc_Identifier();
#line 285 "vc.g"
		ref_vec.push_back(id);
#line 1354 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
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
		recover(ex,_tokenSet_23);
	}
}

vcCPElement*  vcParser::vc_CPElement(
	vcCPElement* p
) {
#line 301 "vc.g"
	vcCPElement* cpe;
#line 1405 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_24);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPPlace(
	vcCPElement* p
) {
#line 308 "vc.g"
	vcCPElement* cpe;
#line 1441 "vcParser.cpp"
#line 308 "vc.g"
	
	string id;
	
#line 1446 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 312 "vc.g"
		cpe = (vcCPElement*) new vcPlace(p, id,0);
#line 1453 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPTransition(
	vcCPElement* p
) {
#line 318 "vc.g"
	vcCPElement* cpe;
#line 1467 "vcParser.cpp"
#line 318 "vc.g"
	
	vcTransitionType t;
	string id;
	
#line 1473 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 323 "vc.g"
			t = _IN_TRANSITION;
#line 1486 "vcParser.cpp"
			}
			break;
		}
		case OUT:
		{
			{
			match(OUT);
#line 323 "vc.g"
			t = _OUT_TRANSITION;
#line 1496 "vcParser.cpp"
			}
			break;
		}
		case HIDDEN:
		{
			{
			match(HIDDEN);
#line 323 "vc.g"
			t = _HIDDEN_TRANSITION;
#line 1506 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 324 "vc.g"
		
		cpe = (vcCPElement*) (new vcTransition(p,id,t));
		
#line 1520 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
	return cpe;
}

void vcParser::vc_CPSeriesBlock(
	vcCPBlock* cp
) {
#line 343 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1538 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 349 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 1545 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt80=0;
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 350 "vc.g"
				sb->Add_CPElement(cpe);
#line 1558 "vcParser.cpp"
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
				if ( _cnt80>=1 ) { goto _loop80; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt80++;
		}
		_loop80:;
		}  // ( ... )+
		match(RBRACE);
#line 352 "vc.g"
		cp->Add_CPElement(sb);
#line 1584 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 358 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	
#line 1601 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 364 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 1608 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt83=0;
		for (;;) {
			if ((_tokenSet_18.member(LA(1)))) {
				vc_CPRegion(sb);
			}
			else {
				if ( _cnt83>=1 ) { goto _loop83; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt83++;
		}
		_loop83:;
		}  // ( ... )+
		match(RBRACE);
#line 366 "vc.g"
		cp->Add_CPElement(sb);
#line 1627 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 372 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1644 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 378 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 1651 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt90=0;
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
			case PLACE:
			{
				{
				cpe=vc_CPPlace(sb);
#line 382 "vc.g"
				sb->Add_CPElement(cpe);
#line 1687 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt90>=1 ) { goto _loop90; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt90++;
		}
		_loop90:;
		}  // ( ... )+
		match(RBRACE);
#line 383 "vc.g"
		cp->Add_CPElement(sb);
#line 1703 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 417 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1720 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 423 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 1727 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt105=0;
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
			case FROM:
			{
				{
				vc_CPFork(fb);
				}
				break;
			}
			case AT:
			{
				{
				vc_CPJoin(fb);
				}
				break;
			}
			case TRANSITION:
			{
				{
				cpe=vc_CPTransition(fb);
#line 427 "vc.g"
				fb->Add_CPElement(cpe);
#line 1763 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt105>=1 ) { goto _loop105; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt105++;
		}
		_loop105:;
		}  // ( ... )+
		match(RBRACE);
#line 428 "vc.g"
		cp->Add_CPElement(fb);
#line 1779 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPBranch(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 404 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 1796 "vcParser.cpp"
	
	try {      // for error handling
		match(FROM);
		lbl=vc_Identifier();
		match(BRANCH);
		{
		switch ( LA(1)) {
		case EXIT:
		{
			e = LT(1);
			match(EXIT);
#line 410 "vc.g"
			branch_ids.push_back(e->getText());
#line 1810 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case PLACE:
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case AT:
		case FROM:
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
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				b=vc_Identifier();
#line 411 "vc.g"
				branch_ids.push_back(b);
#line 1837 "vcParser.cpp"
			}
			else {
				goto _loop98;
			}
			
		}
		_loop98:;
		} // ( ... )*
#line 411 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1848 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
}

void vcParser::vc_CPMerge(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 389 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 1865 "vcParser.cpp"
	
	try {      // for error handling
		match(AT);
		lbl=vc_Identifier();
		match(MERGE);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 395 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1879 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case PLACE:
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case AT:
		case FROM:
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
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 396 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 1906 "vcParser.cpp"
			}
			else {
				goto _loop94;
			}
			
		}
		_loop94:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
}

void vcParser::vc_CPFork(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  fe = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 448 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 1932 "vcParser.cpp"
	
	try {      // for error handling
		match(FROM);
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
#line 454 "vc.g"
			lbl = fe->getText();
#line 1952 "vcParser.cpp"
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
		{
		switch ( LA(1)) {
		case EXIT:
		{
			e = LT(1);
			match(EXIT);
#line 454 "vc.g"
			fork_ids.push_back(e->getText());
#line 1971 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case TRANSITION:
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case AT:
		case FROM:
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
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				b=vc_Identifier();
#line 455 "vc.g"
				fork_ids.push_back(b);
#line 1998 "vcParser.cpp"
			}
			else {
				goto _loop119;
			}
			
		}
		_loop119:;
		} // ( ... )*
#line 456 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 2009 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_CPJoin(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 434 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 2027 "vcParser.cpp"
	
	try {      // for error handling
		match(AT);
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
#line 440 "vc.g"
			lbl = je->getText();
#line 2047 "vcParser.cpp"
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
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 440 "vc.g"
			join_ids.push_back(e->getText());
#line 2066 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case TRANSITION:
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case AT:
		case FROM:
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
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				b=vc_Identifier();
#line 441 "vc.g"
				join_ids.push_back(b);
#line 2093 "vcParser.cpp"
			}
			else {
				goto _loop112;
			}
			
		}
		_loop112:;
		} // ( ... )*
#line 442 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 2104 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_WireDeclaration(
	vcSystem* sys,vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 802 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	
#line 2123 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			cid = LT(1);
			match(CONSTANT);
#line 810 "vc.g"
			const_flag = true;
#line 2134 "vcParser.cpp"
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
#line 811 "vc.g"
		
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
		
#line 2163 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_DatapathElementInstantiation(
	vcSystem* sys, vcModule* m, vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  vid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 718 "vc.g"
	
		string id;
		string template_id,param_id,port_id,wid,lib_id;
		vcDatapathElement* dpe;
	
#line 2181 "vcParser.cpp"
	
	try {      // for error handling
		match(DPEINSTANCE);
		id=vc_Label();
		match(LIBRARY);
		{
		lib_id=vc_Identifier();
		}
		match(DPE);
		{
		template_id=vc_Identifier();
		}
#line 724 "vc.g"
		
		vcDatapathElementTemplate* tt = sys->Get_DPE_Template(lib_id,template_id);
		assert(tt != NULL);
		dpe = new vcDatapathElement(id,tt);
		
#line 2200 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case PARAMETER:
		{
			match(PARAMETER);
			match(MAP);
			{ // ( ... )+
			int _cnt175=0;
			for (;;) {
				if ((LA(1) == SIMPLE_IDENTIFIER)) {
					param_id=vc_Identifier();
					match(IMPLIES);
					vid = LT(1);
					match(UINTEGER);
#line 731 "vc.g"
					dpe->Set_Parameter(param_id, atoi(vid->getText().c_str()));
#line 2218 "vcParser.cpp"
				}
				else {
					if ( _cnt175>=1 ) { goto _loop175; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt175++;
			}
			_loop175:;
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
			int _cnt178=0;
			for (;;) {
				if ((LA(1) == SIMPLE_IDENTIFIER)) {
					port_id=vc_Identifier();
					match(IMPLIES);
					wid=vc_Identifier();
#line 733 "vc.g"
					assert(dp->Find_Wire(wid) != NULL); dpe->Connect_Wire(port_id,dp->Find_Wire(wid));
#line 2257 "vcParser.cpp"
				}
				else {
					if ( _cnt178>=1 ) { goto _loop178; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt178++;
			}
			_loop178:;
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
				goto _loop180;
			}
			
		}
		_loop180:;
		} // ( ... )*
		match(RBRACE);
#line 736 "vc.g"
		dp->Add_DPE(dpe);
#line 2295 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_OperatorInstantiation(
	vcSystem* sys, vcDataPath* dp
) {
	
	try {      // for error handling
		switch ( LA(1)) {
		case PLUS_OP:
		case MINUS_OP:
		case MUL_OP:
		case DIV_OP:
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
			vc_BinaryOperatorInstantiation(dp);
			break;
		}
		case NOT_OP:
		case NOP_OP:
		{
			vc_UnaryOperatorInstantiation(dp);
			break;
		}
		case SELECT_OP:
		{
			vc_SelectInstantiation(dp);
			break;
		}
		case BRANCH_OP:
		{
			vc_BranchInstantiation(dp);
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
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_PhiInstantiation(
	vcDataPath* dp
) {
#line 694 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 2373 "vcParser.cpp"
	
	try {      // for error handling
		match(PHI);
		lbl=vc_Label();
		{ // ( ... )+
		int _cnt169=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 702 "vc.g"
				tw = dp->Find_Wire(id); assert(tw != NULL); inwires.push_back(tw);
#line 2385 "vcParser.cpp"
			}
			else {
				if ( _cnt169>=1 ) { goto _loop169; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt169++;
		}
		_loop169:;
		}  // ( ... )+
		match(IMPLIES);
		id=vc_Identifier();
#line 704 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		assert(outwire != NULL); 
		phi = new vcPhi(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 2404 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_CallInstantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 612 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 2425 "vcParser.cpp"
	
	try {      // for error handling
		match(CALL);
		{
		match(INLINE);
#line 623 "vc.g"
		inline_flag = true;
#line 2433 "vcParser.cpp"
		}
		id=vc_Label();
		match(MODULE);
		mid=vc_Identifier();
		match(LBRACE);
#line 623 "vc.g"
		m = sys->Find_Module(mid); assert(m != NULL);
#line 2441 "vcParser.cpp"
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 624 "vc.g"
				vcWire* w = dp->Find_Wire(mid); assert(w != NULL); inwires.push_back(w);
#line 2449 "vcParser.cpp"
			}
			else {
				goto _loop155;
			}
			
		}
		_loop155:;
		} // ( ... )*
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 625 "vc.g"
				vcWire* w = dp->Find_Wire(mid); assert(w != NULL); outwires.push_back(w);
#line 2466 "vcParser.cpp"
			}
			else {
				goto _loop157;
			}
			
		}
		_loop157:;
		} // ( ... )*
		match(RPAREN);
#line 626 "vc.g"
		nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc);
#line 2478 "vcParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(nc);
			}
			else {
				goto _loop159;
			}
			
		}
		_loop159:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_IOPort_Instantiation(
	vcDataPath* dp
) {
#line 633 "vc.g"
	
	string id, wid, pid;
	vcWire* w;
	bool in_flag = false;
	
#line 2508 "vcParser.cpp"
	
	try {      // for error handling
		match(IOPORT);
		id=vc_Label();
		match(PIPE);
		pid=vc_Identifier();
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 639 "vc.g"
			in_flag = true;
#line 2523 "vcParser.cpp"
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
		wid=vc_Identifier();
#line 640 "vc.g"
		
		w = dp->Find_Wire(wid);
		assert(w != NULL);
		if(in_flag)
		{
		vcInport* np = new vcInport(id,pid,w);
		dp->Add_Inport(np);
		}
		else
		{
		vcOutport* np = new vcOutport(id,pid,w);
		dp->Add_Outport(np);
		}
		
#line 2554 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_LoadStore_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 659 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 2575 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case LOAD:
		{
			{
			match(LOAD);
#line 670 "vc.g"
			is_load = true;
#line 2586 "vcParser.cpp"
			}
			break;
		}
		case STORE:
		{
			match(STORE);
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		id=vc_Label();
		match(MEMORYSPACE);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == SLASH)) {
			m_id=vc_Identifier();
			match(SLASH);
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == ADDRESS)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		ms_id=vc_Identifier();
#line 671 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		assert(ms != NULL);
		
#line 2621 "vcParser.cpp"
		match(ADDRESS);
		wid=vc_Identifier();
#line 675 "vc.g"
		addr = dp->Find_Wire(wid); assert(addr != NULL);
#line 2626 "vcParser.cpp"
		match(DATA);
		wid=vc_Identifier();
#line 676 "vc.g"
		data = dp->Find_Wire(wid); assert(data != NULL);
#line 2631 "vcParser.cpp"
#line 677 "vc.g"
		
		if(is_load)
		{
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
		}
		else
		{
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
		}
		
#line 2645 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_BinaryOperatorInstantiation(
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
#line 492 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 2687 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 504 "vc.g"
			op_id = plus_id->getText();
#line 2699 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 505 "vc.g"
			op_id = minus_id->getText();
#line 2710 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 506 "vc.g"
			op_id = mul_id->getText();
#line 2721 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 507 "vc.g"
			op_id = div_id->getText();
#line 2732 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 508 "vc.g"
			op_id = shl_id->getText();
#line 2743 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 509 "vc.g"
			op_id = shr_id->getText();
#line 2754 "vcParser.cpp"
			}
			break;
		}
		case GT_OP:
		{
			{
			gt_id = LT(1);
			match(GT_OP);
#line 510 "vc.g"
			op_id = gt_id->getText();
#line 2765 "vcParser.cpp"
			}
			break;
		}
		case GE_OP:
		{
			{
			ge_id = LT(1);
			match(GE_OP);
#line 511 "vc.g"
			op_id = ge_id->getText();
#line 2776 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 512 "vc.g"
			op_id = eq_id->getText();
#line 2787 "vcParser.cpp"
			}
			break;
		}
		case LT_OP:
		{
			{
			lt_id = LT(1);
			match(LT_OP);
#line 513 "vc.g"
			op_id = lt_id->getText();
#line 2798 "vcParser.cpp"
			}
			break;
		}
		case LE_OP:
		{
			{
			le_id = LT(1);
			match(LE_OP);
#line 514 "vc.g"
			op_id = le_id->getText();
#line 2809 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 515 "vc.g"
			op_id = neq_id->getText();
#line 2820 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 516 "vc.g"
			op_id = bitsel_id->getText();
#line 2831 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 517 "vc.g"
			op_id = concat_id->getText();
#line 2842 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 518 "vc.g"
			op_id = or_id->getText();
#line 2853 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 519 "vc.g"
			op_id = and_id->getText();
#line 2864 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 520 "vc.g"
			op_id = xor_id->getText();
#line 2875 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 521 "vc.g"
			op_id = nor_id->getText();
#line 2886 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 522 "vc.g"
			op_id = nand_id->getText();
#line 2897 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 523 "vc.g"
			op_id = xnor_id->getText();
#line 2908 "vcParser.cpp"
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
#line 525 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 2923 "vcParser.cpp"
		wid=vc_Identifier();
#line 526 "vc.g"
		y = dp->Find_Wire(wid); assert(x != NULL);
#line 2927 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 529 "vc.g"
		z = dp->Find_Wire(wid); assert(z != NULL);
#line 2933 "vcParser.cpp"
		match(RPAREN);
#line 531 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op);
#line 2937 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_UnaryOperatorInstantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  not_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  nop_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 539 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 2959 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 549 "vc.g"
			op_id = not_id->getText();
#line 2971 "vcParser.cpp"
			}
			break;
		}
		case NOP_OP:
		{
			{
			nop_id = LT(1);
			match(NOP_OP);
#line 550 "vc.g"
			op_id = nop_id->getText();
#line 2982 "vcParser.cpp"
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
#line 552 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 2997 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 555 "vc.g"
		z = dp->Find_Wire(wid); assert(z != NULL);
#line 3003 "vcParser.cpp"
		match(RPAREN);
#line 557 "vc.g"
		new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
#line 3007 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_SelectInstantiation(
	vcDataPath* dp
) {
#line 582 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 3030 "vcParser.cpp"
	
	try {      // for error handling
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 597 "vc.g"
		sel = dp->Find_Wire(wid); assert(sel != NULL);
#line 3039 "vcParser.cpp"
		wid=vc_Identifier();
#line 598 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 3043 "vcParser.cpp"
		wid=vc_Identifier();
#line 599 "vc.g"
		y = dp->Find_Wire(wid); assert(x != NULL);
#line 3047 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 602 "vc.g"
		z = dp->Find_Wire(wid); assert(z != NULL);
#line 3053 "vcParser.cpp"
		match(RPAREN);
#line 604 "vc.g"
		new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);
#line 3057 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_BranchInstantiation(
	vcDataPath* dp
) {
#line 563 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vcWire* x = NULL;
	
#line 3075 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 573 "vc.g"
		x = dp->Find_Wire(wid); assert(x != NULL);
#line 3084 "vcParser.cpp"
		match(RPAREN);
#line 575 "vc.g"
		new_op = new vcBranch(id,x); dp->Add_Branch(new_op);
#line 3088 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
}

void vcParser::vc_Interface_Object_Declaration(
	vcSystem* sys, vcModule* parent, string mode
) {
#line 773 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 3105 "vcParser.cpp"
	
	try {      // for error handling
		vc_Object_Declaration_Base(sys, &t,obj_name,&v);
#line 780 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 3113 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 788 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	
#line 3130 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 793 "vc.g"
		obj_name = id->getText();
#line 3137 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 793 "vc.g"
		*t = tt;
#line 3142 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case ASSIGNEQUAL:
		{
			match(ASSIGNEQUAL);
			vv=vc_Value(*t);
			break;
		}
		case RBRACE:
		case OUT:
		case SIMPLE_IDENTIFIER:
		case MEMORYSPACE:
		case PHI:
		case CONTROLPATH:
		case PLUS_OP:
		case MINUS_OP:
		case MUL_OP:
		case DIV_OP:
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
		case NOP_OP:
		case BRANCH_OP:
		case SELECT_OP:
		case CALL:
		case IOPORT:
		case LOAD:
		case STORE:
		case DPEINSTANCE:
		case CONSTANT:
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
#line 794 "vc.g"
		if(v != NULL) *v = vv;
#line 3200 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

vcValue*  vcParser::vc_IntValue(
	vcType* t
) {
#line 870 "vc.g"
	vcValue* v;
#line 3213 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 870 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcIntType") || t->Is("vcPointerType"));
	
#line 3222 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case BINARYSTRING:
		{
			{
			bid = LT(1);
			match(BINARYSTRING);
#line 875 "vc.g"
			vstring = bid->getText(); format = "binary";
#line 3234 "vcParser.cpp"
			}
			break;
		}
		case HEXSTRING:
		{
			{
			hid = LT(1);
			match(HEXSTRING);
#line 876 "vc.g"
			vstring = hid->getText(); format = "hexadecimal";
#line 3245 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 877 "vc.g"
		
			v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
		
#line 3259 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return v;
}

vcValue*  vcParser::vc_FloatValue(
	vcType* t
) {
#line 885 "vc.g"
	vcValue* v;
#line 3273 "vcParser.cpp"
#line 885 "vc.g"
	
		string vstring;
		string format;
		assert(t->Is("vcFloatType"));
		char sign_value = 0;
		vcValue* cv;
		vcValue* mv;
	assert(t != NULL && t->Is("vcFloatType"));
	
#line 3284 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case MINUS:
		{
			match(MINUS);
#line 894 "vc.g"
			sign_value = 1;
#line 3294 "vcParser.cpp"
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
#line 895 "vc.g"
		
			v = (vcValue*) (new vcFloatValue((vcFloatType*)t,sign_value, (vcIntValue*)cv, (vcIntValue*)mv));
		
#line 3315 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType(
	vcSystem* sys
) {
#line 909 "vc.g"
	vcType* t;
#line 3329 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_14);
	}
	return t;
}

vcType*  vcParser::vc_ArrayType(
	vcSystem* sys
) {
#line 951 "vc.g"
	vcType* t;
#line 3372 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 951 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 3380 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 956 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 3389 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 957 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 3395 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return t;
}

vcType*  vcParser::vc_RecordType(
	vcSystem* sys
) {
#line 963 "vc.g"
	vcType* t;
#line 3409 "vcParser.cpp"
#line 963 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 3416 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		match(LBRACKET);
		{
		et=vc_Type(sys);
#line 968 "vc.g"
		etypes.push_back(et);
#line 3425 "vcParser.cpp"
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == COMMA)) {
				match(COMMA);
				t=vc_Type(sys);
#line 968 "vc.g"
				etypes.push_back(et);
#line 3434 "vcParser.cpp"
			}
			else {
				goto _loop222;
			}
			
		}
		_loop222:;
		} // ( ... )*
		match(RBRACKET);
#line 969 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 3446 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return t;
}

vcType*  vcParser::vc_IntType(
	vcSystem* sys
) {
#line 915 "vc.g"
	vcType* t;
#line 3460 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 915 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 3467 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(LESS);
		i = LT(1);
		match(UINTEGER);
#line 920 "vc.g"
		w = atoi(i->getText().c_str());
#line 3476 "vcParser.cpp"
		match(GREATER);
#line 920 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 3480 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return t;
}

vcType*  vcParser::vc_FloatType(
	vcSystem* sys
) {
#line 926 "vc.g"
	vcType* t;
#line 3494 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 926 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 3502 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(LESS);
		cid = LT(1);
		match(UINTEGER);
#line 931 "vc.g"
		c = atoi(cid->getText().c_str());
#line 3511 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 931 "vc.g"
		m = atoi(mid->getText().c_str());
#line 3517 "vcParser.cpp"
		match(GREATER);
#line 932 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 3521 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
	return t;
}

vcType*  vcParser::vc_PointerType(
	vcSystem* sys
) {
#line 939 "vc.g"
	vcType* t;
#line 3535 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 939 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 3543 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(LESS);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == SLASH)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(SLASH);
#line 944 "vc.g"
			scope_id = sid->getText();
#line 3555 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == GREATER)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 945 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 3568 "vcParser.cpp"
		match(GREATER);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
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
	"MIN",
	"UINTEGER",
	"MAX",
	"IN",
	"OUT",
	"COLON",
	"FLOAT",
	"LESS",
	"SIMPLE_IDENTIFIER",
	"COMMA",
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
	"EQUIVALENT",
	"SLASH",
	"PHI",
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
	"PLUS_OP",
	"MINUS_OP",
	"MUL_OP",
	"DIV_OP",
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
	"LPAREN",
	"RPAREN",
	"NOT_OP",
	"NOP_OP",
	"BRANCH_OP",
	"SELECT_OP",
	"CALL",
	"INLINE",
	"IOPORT",
	"PIPE",
	"LOAD",
	"STORE",
	"ADDRESS",
	"DATA",
	"IMPLIES",
	"DPEINSTANCE",
	"MAP",
	"PORT",
	"LBRACKET",
	"RBRACKET",
	"CONSTANT",
	"WIRE",
	"BINARYSTRING",
	"HEXSTRING",
	"MINUS",
	"\"C\"",
	"\"M\"",
	"POINTER",
	"ARRAY",
	"OF",
	"RECORD",
	"ATTRIBUTE",
	"QUOTED_STRING",
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
const unsigned long vcParser::_tokenSet_2_data_[] = { 545259538UL, 4UL, 0UL, 0UL };
// EOF LIBRARY MEMORYSPACE MODULE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,4);
const unsigned long vcParser::_tokenSet_3_data_[] = { 545419376UL, 37880UL, 65664UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// LIBRARY LBRACE RBRACE IN OUT COLON SIMPLE_IDENTIFIER MEMORYSPACE MODULE 
// PLACE TRANSITION HIDDEN SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM 
// FORKBLOCK LPAREN PIPE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 192UL, 0UL, 0UL, 0UL };
// RBRACE DPE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,4);
const unsigned long vcParser::_tokenSet_5_data_[] = { 6303808UL, 0UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE IN OUT REQS ACKS ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,8);
const unsigned long vcParser::_tokenSet_6_data_[] = { 6299712UL, 0UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OUT REQS ACKS ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,8);
const unsigned long vcParser::_tokenSet_7_data_[] = { 6291520UL, 0UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE REQS ACKS ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,8);
const unsigned long vcParser::_tokenSet_8_data_[] = { 4194368UL, 0UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE ACKS ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,8);
const unsigned long vcParser::_tokenSet_9_data_[] = { 64UL, 0UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,8);
const unsigned long vcParser::_tokenSet_10_data_[] = { 64UL, 4294443010UL, 407289471UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PHI PLUS_OP MINUS_OP MUL_OP DIV_OP SHL_OP SHR_OP GT_OP GE_OP 
// EQ_OP LT_OP LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP 
// NAND_OP XNOR_OP NOT_OP NOP_OP BRANCH_OP SELECT_OP CALL IOPORT LOAD STORE 
// DPEINSTANCE CONSTANT WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,8);
const unsigned long vcParser::_tokenSet_11_data_[] = { 2153935584UL, 4294686683UL, 410959743UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// LBRACE RBRACE DPE MIN IN OUT COLON SIMPLE_IDENTIFIER REQS ACKS EQUIVALENT 
// SLASH PHI PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT 
// MERGE FROM BRANCH FORKBLOCK JOIN FORK PLUS_OP MINUS_OP MUL_OP DIV_OP 
// SHL_OP SHR_OP GT_OP GE_OP EQ_OP LT_OP LE_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP RPAREN NOT_OP NOP_OP BRANCH_OP 
// SELECT_OP CALL IOPORT LOAD STORE ADDRESS DATA IMPLIES DPEINSTANCE CONSTANT 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 6430784UL, 0UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OUT SIMPLE_IDENTIFIER REQS ACKS ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 134217792UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,4);
const unsigned long vcParser::_tokenSet_14_data_[] = { 411443264UL, 4294443014UL, 474398335UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OUT SIMPLE_IDENTIFIER COMMA MEMORYSPACE OBJECT ASSIGNEQUAL PHI 
// CONTROLPATH PLUS_OP MINUS_OP MUL_OP DIV_OP SHL_OP SHR_OP GT_OP GE_OP 
// EQ_OP LT_OP LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP 
// NAND_OP XNOR_OP NOT_OP NOP_OP BRANCH_OP SELECT_OP CALL IOPORT LOAD STORE 
// DPEINSTANCE RBRACKET CONSTANT WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,8);
const unsigned long vcParser::_tokenSet_15_data_[] = { 143007808UL, 4294443014UL, 407289727UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OUT SIMPLE_IDENTIFIER COMMA MEMORYSPACE OBJECT PHI CONTROLPATH 
// PLUS_OP MINUS_OP MUL_OP DIV_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP LT_OP 
// LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP RPAREN NOT_OP NOP_OP BRANCH_OP SELECT_OP CALL IOPORT LOAD STORE 
// DPEINSTANCE CONSTANT WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,8);
const unsigned long vcParser::_tokenSet_16_data_[] = { 8396800UL, 4UL, 0UL, 0UL };
// OUT MEMORYSPACE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,4);
const unsigned long vcParser::_tokenSet_17_data_[] = { 8388608UL, 4UL, 0UL, 0UL };
// MEMORYSPACE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,4);
const unsigned long vcParser::_tokenSet_18_data_[] = { 0UL, 33216UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,4);
const unsigned long vcParser::_tokenSet_19_data_[] = { 1073741888UL, 262146UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE LINK PHI DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,8);
const unsigned long vcParser::_tokenSet_20_data_[] = { 1073741888UL, 2UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE LINK PHI ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,8);
const unsigned long vcParser::_tokenSet_21_data_[] = { 64UL, 2UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PHI ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,8);
const unsigned long vcParser::_tokenSet_22_data_[] = { 2151809088UL, 2UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ACKS EQUIVALENT PHI ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 64UL, 37848UL, 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM 
// FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,8);
const unsigned long vcParser::_tokenSet_24_data_[] = { 64UL, 33240UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,4);
const unsigned long vcParser::_tokenSet_25_data_[] = { 64UL, 37848UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM 
// FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,4);
const unsigned long vcParser::_tokenSet_26_data_[] = { 64UL, 37832UL, 0UL, 0UL };
// RBRACE PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,4);
const unsigned long vcParser::_tokenSet_27_data_[] = { 64UL, 37840UL, 0UL, 0UL };
// RBRACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK AT FROM FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,4);
const unsigned long vcParser::_tokenSet_28_data_[] = { 8527872UL, 4UL, 0UL, 0UL };
// OUT SIMPLE_IDENTIFIER MEMORYSPACE CONTROLPATH 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,4);
const unsigned long vcParser::_tokenSet_29_data_[] = { 8527936UL, 4294443014UL, 407289471UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OUT SIMPLE_IDENTIFIER MEMORYSPACE PHI CONTROLPATH PLUS_OP MINUS_OP 
// MUL_OP DIV_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP LT_OP LE_OP NEQ_OP BITSEL_OP 
// CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP NOT_OP NOP_OP BRANCH_OP 
// SELECT_OP CALL IOPORT LOAD STORE DPEINSTANCE CONSTANT WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_29(_tokenSet_29_data_,8);
const unsigned long vcParser::_tokenSet_30_data_[] = { 143007808UL, 4294443014UL, 407289727UL, 66UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OUT SIMPLE_IDENTIFIER COMMA MEMORYSPACE OBJECT PHI CONTROLPATH 
// PLUS_OP MINUS_OP MUL_OP DIV_OP SHL_OP SHR_OP GT_OP GE_OP EQ_OP LT_OP 
// LE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP RPAREN NOT_OP NOP_OP BRANCH_OP SELECT_OP CALL IOPORT LOAD STORE 
// DPEINSTANCE CONSTANT WIRE "M" ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_30(_tokenSet_30_data_,8);


