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
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,3)
{
}

vcParser::vcParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

vcParser::vcParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,3)
{
}

vcParser::vcParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,3)
{
}

void vcParser::vc_System(
	vcSystem* sys
) {
#line 42 "vc.g"
	
		vcModule* nf = NULL;
		vcMemorySpace* ms = NULL;
	
	
#line 47 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case FOREIGN:
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
#line 52 "vc.g"
				sys->Add_Memory_Space(ms);
#line 67 "vcParser.cpp"
				}
				break;
			}
			case LIFO:
			case PIPE:
			{
				{
				vc_Pipe(sys,NULL);
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
			case ATTRIBUTE:
			{
				{
				vc_SysAttributeSpec(sys);
				}
				break;
			}
			case BUFFERING:
			{
				{
				vc_SysBufferingSpec(sys);
				}
				break;
			}
			default:
			{
				goto _loop9;
			}
			}
		}
		_loop9:;
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
#line 131 "vc.g"
	vcModule* m;
#line 122 "vcParser.cpp"
#line 131 "vc.g"
	
		string lbl;
		m = NULL;
	bool foreign_flag = false;
	bool pipeline_flag = false;
	vcMemorySpace* ms;
	
#line 131 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case FOREIGN:
		{
			match(FOREIGN);
#line 139 "vc.g"
			foreign_flag = true;
#line 141 "vcParser.cpp"
			break;
		}
		case MODULE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(MODULE);
		lbl=vc_Label();
#line 141 "vc.g"
		
		m = new vcModule(sys,lbl); 
		sys->Add_Module(m); 
		if(foreign_flag) m->Set_Foreign_Flag(true);
		
#line 162 "vcParser.cpp"
		match(LBRACE);
		{
		switch ( LA(1)) {
		case IN:
		{
			vc_Inargs(sys,m);
			break;
		}
		case LIFO:
		case PIPE:
		case MEMORYSPACE:
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case CONTROLPATH:
		case DATAPATH:
		case OUT:
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
			vc_Outargs(sys,m);
			break;
		}
		case LIFO:
		case PIPE:
		case MEMORYSPACE:
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case CONTROLPATH:
		case DATAPATH:
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
			if ((LA(1) == MEMORYSPACE)) {
				ms=vc_MemorySpace(sys,m);
#line 147 "vc.g"
				m->Add_Memory_Space(ms);
#line 219 "vcParser.cpp"
			}
			else {
				goto _loop26;
			}
			
		}
		_loop26:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LIFO || LA(1) == PIPE)) {
				vc_Pipe(NULL,m);
			}
			else {
				goto _loop28;
			}
			
		}
		_loop28:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case CONTROLPATH:
		{
			vc_Controlpath(sys,m,pipeline_flag);
#line 149 "vc.g"
			assert(!foreign_flag);
#line 247 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case SIMPLE_IDENTIFIER:
		case DATAPATH:
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
		case DATAPATH:
		{
			vc_Datapath(sys,m);
#line 150 "vc.g"
			assert(!foreign_flag);
#line 270 "vcParser.cpp"
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
#line 151 "vc.g"
				assert(!foreign_flag);
#line 291 "vcParser.cpp"
			}
			else {
				goto _loop32;
			}
			
		}
		_loop32:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(m);
			}
			else {
				goto _loop34;
			}
			
		}
		_loop34:;
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
#line 85 "vc.g"
	vcMemorySpace* ms;
#line 326 "vcParser.cpp"
#line 85 "vc.g"
	
		string lbl;
		bool unordered_flag = false;
		ms = NULL;
	
#line 333 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		{
		switch ( LA(1)) {
		case UNORDERED:
		{
			match(UNORDERED);
#line 91 "vc.g"
			unordered_flag = true;
#line 344 "vcParser.cpp"
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
		lbl=vc_Label();
#line 93 "vc.g"
		
				ms = new vcMemorySpace(lbl,m);
				ms->Set_Ordered_Flag(!unordered_flag);
			
#line 363 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(sys,ms);
			}
			else {
				goto _loop16;
			}
			
		}
		_loop16:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(ms);
			}
			else {
				goto _loop18;
			}
			
		}
		_loop18:;
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
	vcSystem* sys, vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 67 "vc.g"
	
	string lbl;
	int depth = 1;
	bool lifo_mode = false;
	
#line 410 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case LIFO:
		{
			match(LIFO);
#line 72 "vc.g"
			lifo_mode = true;
#line 420 "vcParser.cpp"
			break;
		}
		case PIPE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(PIPE);
		lbl=vc_Label();
		wid = LT(1);
		match(UINTEGER);
		{
		switch ( LA(1)) {
		case DEPTH:
		{
			match(DEPTH);
			did = LT(1);
			match(UINTEGER);
#line 72 "vc.g"
			depth = atoi(did->getText().c_str());
#line 446 "vcParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case LIFO:
		case PIPE:
		case MEMORYSPACE:
		case RBRACE:
		case FOREIGN:
		case MODULE:
		case SIMPLE_IDENTIFIER:
		case CONTROLPATH:
		case BUFFERING:
		case DATAPATH:
		case CONSTANT:
		case INTERMEDIATE:
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
#line 73 "vc.g"
		
		if (sys) 
		sys->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode);
		else if(m)
		m->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode);
		
#line 480 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_2);
	}
}

void vcParser::vc_Wire_Declaration(
	vcSystem* sys,vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  iid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1409 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	bool intermediate_flag = false;
	
#line 502 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			{
			cid = LT(1);
			match(CONSTANT);
#line 1418 "vc.g"
			const_flag = true;
#line 514 "vcParser.cpp"
			}
			break;
		}
		case INTERMEDIATE:
		{
			{
			iid = LT(1);
			match(INTERMEDIATE);
#line 1418 "vc.g"
			intermediate_flag = true;
#line 525 "vcParser.cpp"
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
#line 1419 "vc.g"
		
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
		sys->Warning("Warning: wire declaration at system scope ignored: line number " + 
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
		
#line 573 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

void vcParser::vc_SysAttributeSpec(
	vcSystem* sys
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  aid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  kid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  vid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1656 "vc.g"
	
		string key;
		string value;
		bool mem_space = false;
	bool module = false;
		vcRoot* child = NULL;
		string m_id;
		string ms_id;
	string child_id;
	
#line 598 "vcParser.cpp"
	
	try {      // for error handling
		aid = LT(1);
		match(ATTRIBUTE);
		{
		switch ( LA(1)) {
		case MEMORYSPACE:
		{
			{
			match(MEMORYSPACE);
#line 1669 "vc.g"
			mem_space = true;
#line 611 "vcParser.cpp"
			{
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				m_id=vc_Identifier();
				match(DIV_OP);
			}
			else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == SIMPLE_IDENTIFIER)) {
			}
			else {
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			
			}
			ms_id=vc_Identifier();
#line 1671 "vc.g"
			
								child_id = m_id + "/" + ms_id; 
								child = sys->Find_Memory_Space(m_id,ms_id);
							
#line 630 "vcParser.cpp"
			}
			break;
		}
		case MODULE:
		{
			{
			match(MODULE);
#line 1675 "vc.g"
			module = true;
#line 640 "vcParser.cpp"
			m_id=vc_Identifier();
#line 1677 "vc.g"
			
								child_id = m_id;
								child = sys->Find_Module(m_id);
							
#line 647 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1682 "vc.g"
		key = kid->getText();
#line 661 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1683 "vc.g"
		value = vid->getText();
#line 667 "vcParser.cpp"
#line 1684 "vc.g"
		
					if(child != NULL) 
						child->Add_Attribute(key,value);
					else
					{
						vcSystem::Warning("could not find " + child_id + " to add attribute,"
									+ IntToStr(aid->getLine()));
								
					}
				
#line 679 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

void vcParser::vc_SysBufferingSpec(
	vcSystem* sys
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpe_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  wire_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1581 "vc.g"
	
		string mod_name;
		string dpe_name;
		string wire_name;
		int buffering;
		bool input_flag = true;
	
#line 702 "vcParser.cpp"
	
	try {      // for error handling
		match(BUFFERING);
		mid = LT(1);
		match(SIMPLE_IDENTIFER);
#line 1590 "vc.g"
		mod_name = mid->getText();
#line 710 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case IN:
		{
			match(IN);
			break;
		}
		case OUT:
		{
			{
			match(OUT);
#line 1591 "vc.g"
			input_flag = false;
#line 724 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		dpe_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1592 "vc.g"
		dpe_name = dpe_id->getText();
#line 738 "vcParser.cpp"
		wire_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1593 "vc.g"
		wire_name = wire_id->getText();
#line 743 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1594 "vc.g"
		buffering = atoi(bid->getText().c_str());
#line 748 "vcParser.cpp"
#line 1595 "vc.g"
		
					vcModule* m = sys->Find_Module(mod_name);
					NOT_FOUND__("Module", m, mod_name, mid);
					if(m != NULL)
					{
						vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
						NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
						if(dpe != NULL)
						{
							vcWire* w = m->Get_Data_Path()->Find_Wire(wire_name);
							NOT_FOUND__("wire", w, wire_name, wire_id);
							if(w != NULL)
							{
								if(input_flag)
									dpe->Set_Input_Buffering(w,buffering);
								else
									dpe->Set_Output_Buffering(w,buffering);
		
							}
						}
					}
				
#line 772 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

string  vcParser::vc_Label() {
#line 1350 "vc.g"
	string lbl;
#line 783 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1352 "vc.g"
		lbl = id->getText();
#line 793 "vcParser.cpp"
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  maw = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(CAPACITY);
		cap = LT(1);
		match(UINTEGER);
#line 105 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 818 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 106 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 824 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 107 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 830 "vcParser.cpp"
		match(MAXACCESSWIDTH);
		maw = LT(1);
		match(UINTEGER);
#line 108 "vc.g"
		ms->Set_Max_Access_Width(atoi(maw->getText().c_str()));
#line 836 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 114 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 854 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
#line 122 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
		ms->Add_Storage_Object(nl);
		
#line 866 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

void vcParser::vc_AttributeSpec(
	vcRoot* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  kid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  vid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1699 "vc.g"
	
		string key;
		string value;
	
#line 884 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1705 "vc.g"
		key = kid->getText();
#line 892 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1705 "vc.g"
		value = vid->getText();
#line 898 "vcParser.cpp"
#line 1706 "vc.g"
		m->Add_Attribute(key,value);
#line 901 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 1509 "vc.g"
	vcType* t;
#line 914 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_7);
	}
	return t;
}

void vcParser::vc_Inargs(
	vcSystem* sys, vcModule* parent
) {
#line 1358 "vc.g"
	
		string mode = "in";
	
#line 963 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
			}
			else {
				goto _loop283;
			}
			
		}
		_loop283:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Outargs(
	vcSystem* sys, vcModule* parent
) {
#line 1369 "vc.g"
	
		string mode = "out";
	
#line 993 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop286;
			}
			
		}
		_loop286:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
}

void vcParser::vc_Controlpath(
	vcSystem* sys, vcModule* m, bool pipeline_flag
) {
#line 248 "vc.g"
	
		vcControlPath* cp;
	if(!pipeline_flag) 
	cp = new vcControlPath(m->Get_Id() + "_CP");
	else
	cp = new vcControlPathPipelined(m->Get_Id() + "_CP");
	
#line 1027 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_10.member(LA(1)))) {
				vc_CPRegion(cp);
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
				vc_AttributeSpec(cp);
			}
			else {
				goto _loop53;
			}
			
		}
		_loop53:;
		} // ( ... )*
		match(RBRACE);
#line 256 "vc.g"
		m->Set_Control_Path(cp);
#line 1059 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 619 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
		m->Set_Data_Path(dp);
	
#line 1075 "vcParser.cpp"
	
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
			case BRANCH_OP:
			{
				vc_Branch_Instantiation(dp);
				break;
			}
			case PHI:
			{
				vc_Phi_Instantiation(dp);
				break;
			}
			case ATTRIBUTE:
			{
				vc_AttributeSpec(dp);
				break;
			}
			case BUFFERING:
			{
				vc_ModuleBufferingSpec(m);
				break;
			}
			default:
				if ((_tokenSet_12.member(LA(1))) && (_tokenSet_13.member(LA(2)))) {
					vc_Guarded_Operator_Instantiation(sys,dp);
				}
				else if ((LA(1) == HASH) && (LA(2) == PHI)) {
					vc_PhiWithBuffering_Instantiation(dp);
				}
			else {
				goto _loop171;
			}
			}
		}
		_loop171:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
}

void vcParser::vc_Link(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpeid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 160 "vc.g"
	
	vcDatapathElement* dpe;
	vector<string> ref_vec;
	vector<vcTransition*> reqs;
	vector<vcTransition*> acks;
	
#line 1143 "vcParser.cpp"
	
	try {      // for error handling
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 168 "vc.g"
		
		dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
		NOT_FOUND__("datapath-element",dpe,dpeid->getText(),dpeid)
		
#line 1153 "vcParser.cpp"
		match(EQUIVALENT);
		match(LPAREN);
		{ // ( ... )+
		int _cnt37=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 175 "vc.g"
				
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
				
				
#line 1183 "vcParser.cpp"
			}
			else {
				if ( _cnt37>=1 ) { goto _loop37; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt37++;
		}
		_loop37:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt41=0;
		for (;;) {
			switch ( LA(1)) {
			case SIMPLE_IDENTIFIER:
			case ENTRY:
			case EXIT:
			{
				{
				vc_Hierarchical_CP_Ref(ref_vec);
#line 200 "vc.g"
				
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
				
				
				
#line 1229 "vcParser.cpp"
				}
				break;
			}
			case OPEN:
			{
				{
				match(OPEN);
#line 225 "vc.g"
				acks.push_back(NULL);
#line 1239 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt41>=1 ) { goto _loop41; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt41++;
		}
		_loop41:;
		}  // ( ... )+
		match(RPAREN);
#line 228 "vc.g"
		m->Add_Link(dpe,reqs,acks);
#line 1255 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_14);
	}
}

void vcParser::vc_Hierarchical_CP_Ref(
	vector<string>& ref_vec
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  entry_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  exit_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 235 "vc.g"
	
	string id;
	
#line 1272 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				id=vc_Identifier();
#line 239 "vc.g"
				ref_vec.push_back(id);
#line 1281 "vcParser.cpp"
				match(DIV_OP);
			}
			else {
				goto _loop44;
			}
			
		}
		_loop44:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			id=vc_Identifier();
#line 240 "vc.g"
			ref_vec.push_back(id);
#line 1299 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			entry_id = LT(1);
			match(ENTRY);
#line 241 "vc.g"
			ref_vec.push_back(entry_id->getText());
#line 1310 "vcParser.cpp"
			}
			break;
		}
		case EXIT:
		{
			{
			exit_id = LT(1);
			match(EXIT);
#line 242 "vc.g"
			ref_vec.push_back(exit_id->getText());
#line 1321 "vcParser.cpp"
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
		recover(ex,_tokenSet_15);
	}
}

string  vcParser::vc_Identifier() {
#line 1714 "vc.g"
	string s;
#line 1341 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1714 "vc.g"
		s = id->getText();
#line 1349 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_16);
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
		recover(ex,_tokenSet_17);
	}
}

vcCPElement*  vcParser::vc_CPElement(
	vcCPElement* p
) {
#line 262 "vc.g"
	vcCPElement* cpe;
#line 1401 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_18);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPPlace(
	vcCPElement* p
) {
#line 269 "vc.g"
	vcCPElement* cpe;
#line 1437 "vcParser.cpp"
#line 269 "vc.g"
	
	string id;
	
#line 1442 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 274 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		cpe = (vcCPElement*) new vcPlace(p, id,0);
		
#line 1453 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPTransition(
	vcCPElement* p
) {
#line 285 "vc.g"
	vcCPElement* cpe;
#line 1467 "vcParser.cpp"
#line 285 "vc.g"
	
	string id;
	bool dead_flag = false;
	bool tie_high = false;
	bool leave_open = false;
	bool delay_flag = false;
	
#line 1476 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
		{
		switch ( LA(1)) {
		case DEAD:
		{
			{
			match(DEAD);
#line 293 "vc.g"
			dead_flag = true;
#line 1489 "vcParser.cpp"
			}
			break;
		}
		case TIED_HIGH:
		{
			{
			match(TIED_HIGH);
#line 293 "vc.g"
			tie_high = true;
#line 1499 "vcParser.cpp"
			}
			break;
		}
		case LEFT_OPEN:
		{
			{
			match(LEFT_OPEN);
#line 294 "vc.g"
			leave_open = true;
#line 1509 "vcParser.cpp"
			}
			break;
		}
		case DELAY:
		{
			{
			match(DELAY);
#line 294 "vc.g"
			delay_flag = true;
#line 1519 "vcParser.cpp"
			}
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
		case PHISEQUENCER:
		case TRANSITIONMERGE:
		case FORKBLOCK:
		case N_ULL:
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
#line 295 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		{
		cpe = (vcCPElement*) (new vcTransition(p,id));
			((vcTransition*)cpe)->Set_Is_Dead(dead_flag);
			((vcTransition*)cpe)->Set_Is_Tied_High(tie_high);
			((vcTransition*)cpe)->Set_Is_Left_Open(leave_open);
			((vcTransition*)cpe)->Set_Is_Delay_Element(delay_flag);
		}
		
#line 1558 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
	return cpe;
}

void vcParser::vc_CPSeriesBlock(
	vcCPBlock* cp
) {
#line 322 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1576 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 328 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 1583 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 329 "vc.g"
				sb->Add_CPElement(cpe);
#line 1595 "vcParser.cpp"
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
			case ATTRIBUTE:
			{
				{
				vc_AttributeSpec(sb);
				}
				break;
			}
			default:
			{
				goto _loop70;
			}
			}
		}
		_loop70:;
		} // ( ... )*
		match(RBRACE);
#line 331 "vc.g"
		cp->Add_CPElement(sb);
#line 1627 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_17);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 337 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	vcCPElement* t;
	
#line 1645 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 344 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 1652 "vcParser.cpp"
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
#line 345 "vc.g"
				sb->Add_CPElement(t);
#line 1670 "vcParser.cpp"
				break;
			}
			case ATTRIBUTE:
			{
				{
				vc_AttributeSpec(sb);
				}
				break;
			}
			default:
			{
				goto _loop74;
			}
			}
		}
		_loop74:;
		} // ( ... )*
		match(RBRACE);
#line 347 "vc.g"
		cp->Add_CPElement(sb);
#line 1691 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_17);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 354 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1708 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 360 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 1715 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt83=0;
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
			case LOOPBLOCK:
			{
				{
				vc_CPSimpleLoopBlock(sb);
				}
				break;
			}
			case PLACE:
			{
				{
				cpe=vc_CPPlace(sb);
#line 365 "vc.g"
				sb->Add_CPElement(cpe);
#line 1744 "vcParser.cpp"
				}
				break;
			}
			case ATTRIBUTE:
			{
				{
				vc_AttributeSpec(sb);
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
				if ( _cnt83>=1 ) { goto _loop83; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt83++;
		}
		_loop83:;
		}  // ( ... )+
		match(RBRACE);
#line 367 "vc.g"
		cp->Add_CPElement(sb);
#line 1777 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_17);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 515 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1794 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 521 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 1801 "vcParser.cpp"
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
#line 525 "vc.g"
				fb->Add_CPElement(cpe);
#line 1822 "vcParser.cpp"
				}
				break;
			}
			case ATTRIBUTE:
			{
				{
				vc_AttributeSpec(fb);
				}
				break;
			}
			default:
				if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY) && (LA(2) == FORK)) {
					{
					vc_CPFork(fb);
					}
				}
				else if ((_tokenSet_21.member(LA(1))) && (LA(2) == JOIN)) {
					{
					vc_CPJoin(fb);
					}
				}
			else {
				goto _loop126;
			}
			}
		}
		_loop126:;
		} // ( ... )*
		match(RBRACE);
#line 527 "vc.g"
		cp->Add_CPElement(fb);
#line 1854 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_17);
	}
}

void vcParser::vc_CPBranch(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 502 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 1871 "vcParser.cpp"
	
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
#line 508 "vc.g"
			branch_ids.push_back(e->getText());
#line 1885 "vcParser.cpp"
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
#line 509 "vc.g"
				branch_ids.push_back(b);
#line 1905 "vcParser.cpp"
			}
			else {
				goto _loop118;
			}
			
		}
		_loop118:;
		} // ( ... )*
#line 509 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1916 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPMerge(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 487 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 1934 "vcParser.cpp"
	
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
#line 493 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1948 "vcParser.cpp"
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
#line 494 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 1968 "vcParser.cpp"
			}
			else {
				goto _loop114;
			}
			
		}
		_loop114:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPSimpleLoopBlock(
	vcCPBlock* cp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 373 "vc.g"
	
		string lbl;
		vcCPSimpleLoopBlock* sb;
		vcCPElement* cpe;
		int depth, buffering;
		bool full_rate_flag = false;
	
#line 1998 "vcParser.cpp"
	
	try {      // for error handling
		match(LOOPBLOCK);
		lbl=vc_Label();
#line 381 "vc.g"
		sb = new vcCPSimpleLoopBlock(cp,lbl);
#line 2005 "vcParser.cpp"
		match(DEPTH);
		did = LT(1);
		match(UINTEGER);
#line 382 "vc.g"
		depth = atoi(did->getText().c_str()); sb->Set_Depth(depth);
#line 2011 "vcParser.cpp"
		match(BUFFERING);
		bid = LT(1);
		match(UINTEGER);
#line 383 "vc.g"
		buffering = atoi(bid->getText().c_str()); sb->Set_Buffering(buffering);
#line 2017 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case FULLRATE:
		{
			match(FULLRATE);
#line 384 "vc.g"
			full_rate_flag = true;
#line 2025 "vcParser.cpp"
			break;
		}
		case LBRACE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PLACE)) {
				cpe=vc_CPPlace(sb);
#line 386 "vc.g"
				sb->Add_CPElement(cpe);
#line 2045 "vcParser.cpp"
			}
			else {
				goto _loop87;
			}
			
		}
		_loop87:;
		} // ( ... )*
		vc_CPPipelinedLoopBody(sb);
		{ // ( ... )+
		int _cnt89=0;
		for (;;) {
			if ((LA(1) == SERIESBLOCK)) {
				vc_CPSeriesBlock(sb);
			}
			else {
				if ( _cnt89>=1 ) { goto _loop89; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt89++;
		}
		_loop89:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt91=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == MERGE)) {
				vc_CPMerge(sb);
			}
			else {
				if ( _cnt91>=1 ) { goto _loop91; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt91++;
		}
		_loop91:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt93=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_CPBranch(sb);
			}
			else {
				if ( _cnt93>=1 ) { goto _loop93; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt93++;
		}
		_loop93:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt95=0;
		for (;;) {
			if ((LA(1) == BIND)) {
				vc_CPBind(sb);
			}
			else {
				if ( _cnt95>=1 ) { goto _loop95; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt95++;
		}
		_loop95:;
		}  // ( ... )+
		vc_CPLoopTerminate(sb);
		match(RBRACE);
#line 395 "vc.g"
		cp->Add_CPElement(sb);  sb->Set_Full_Rate_Flag(true);
#line 2115 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPPipelinedLoopBody(
	vcCPBlock* cp
) {
#line 534 "vc.g"
	
	string lbl;
	vcCPPipelinedLoopBody* fb;
	vcCPElement* cpe;
	string internal_id, external_id;
	bool pipeline_flag = false;
	
#line 2134 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPELINE);
		lbl=vc_Label();
#line 542 "vc.g"
		fb = new vcCPPipelinedLoopBody(cp,lbl);
#line 2141 "vcParser.cpp"
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
#line 547 "vc.g"
				fb->Add_CPElement(cpe);
#line 2162 "vcParser.cpp"
				}
				break;
			}
			case PHISEQUENCER:
			{
				{
				vc_CPPhiSequencer(fb);
				}
				break;
			}
			case TRANSITIONMERGE:
			{
				{
				vc_CPTransitionMerge(fb);
				}
				break;
			}
			case ATTRIBUTE:
			{
				{
				vc_AttributeSpec(fb);
				}
				break;
			}
			default:
				if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY) && (LA(2) == FORK)) {
					{
					vc_CPFork(fb);
					}
				}
				else if ((_tokenSet_21.member(LA(1))) && (LA(2) == JOIN)) {
					{
					vc_CPJoin(fb);
					}
				}
				else if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == N_ULL) && (LA(2) == MARKEDJOIN)) {
					{
					vc_CPMarkedJoin(fb);
					}
				}
			else {
				goto _loop137;
			}
			}
		}
		_loop137:;
		} // ( ... )*
		match(RBRACE);
#line 551 "vc.g"
		cp->Add_CPElement(fb);
#line 2213 "vcParser.cpp"
		{
		match(LPAREN);
		{ // ( ... )+
		int _cnt140=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 552 "vc.g"
				fb->Add_Exported_Input(internal_id);
#line 2223 "vcParser.cpp"
			}
			else {
				if ( _cnt140>=1 ) { goto _loop140; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt140++;
		}
		_loop140:;
		}  // ( ... )+
		match(RPAREN);
		}
		{
		match(LPAREN);
		{ // ( ... )+
		int _cnt143=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 553 "vc.g"
				fb->Add_Exported_Output(internal_id);
#line 2244 "vcParser.cpp"
			}
			else {
				if ( _cnt143>=1 ) { goto _loop143; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt143++;
		}
		_loop143:;
		}  // ( ... )+
		match(RPAREN);
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_24);
	}
}

void vcParser::vc_CPBind(
	vcCPSimpleLoopBlock* cp
) {
#line 473 "vc.g"
	
		string pl_lbl, rgn_label, rgn_internal_lbl;
	bool input_binding;
	
#line 2271 "vcParser.cpp"
	
	try {      // for error handling
		match(BIND);
		pl_lbl=vc_Identifier();
		{
		switch ( LA(1)) {
		case IMPLIES:
		{
			{
			match(IMPLIES);
#line 478 "vc.g"
			input_binding = true;
#line 2284 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			match(ULE_OP);
#line 478 "vc.g"
			input_binding = false;
#line 2294 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		rgn_label=vc_Identifier();
		match(COLON);
		rgn_internal_lbl=vc_Identifier();
#line 479 "vc.g"
		
			cp->Bind(pl_lbl,rgn_label,rgn_internal_lbl,input_binding);
		
#line 2311 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPLoopTerminate(
	vcCPSimpleLoopBlock* slb
) {
#line 401 "vc.g"
	
		string loop_exit, loop_taken, loop_body, loop_back, exit_place;
	
#line 2326 "vcParser.cpp"
	
	try {      // for error handling
		match(TERMINATE);
		match(LPAREN);
		loop_exit=vc_Identifier();
		loop_taken=vc_Identifier();
		loop_body=vc_Identifier();
		match(RPAREN);
		match(LPAREN);
		loop_back=vc_Identifier();
		exit_place=vc_Identifier();
		match(RPAREN);
#line 413 "vc.g"
		slb->Set_Loop_Termination_Information(loop_exit, loop_taken, loop_body, loop_back, exit_place);
#line 2341 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
}

void vcParser::vc_CPPhiSequencer(
	vcCPPipelinedLoopBody* slb
) {
#line 421 "vc.g"
	
	vector<string> selects;
	vector<string> enables;
	vector<string> reqs;
	string lbl;
	string enable;
	string ack;
	string done;
	string tmp_string;
	
#line 2363 "vcParser.cpp"
	
	try {      // for error handling
		match(PHISEQUENCER);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt99=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 433 "vc.g"
				selects.push_back(tmp_string);
#line 2376 "vcParser.cpp"
			}
			else {
				if ( _cnt99>=1 ) { goto _loop99; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt99++;
		}
		_loop99:;
		}  // ( ... )+
		match(COLON);
		{ // ( ... )+
		int _cnt101=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 435 "vc.g"
				enables.push_back(tmp_string);
#line 2394 "vcParser.cpp"
			}
			else {
				if ( _cnt101>=1 ) { goto _loop101; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt101++;
		}
		_loop101:;
		}  // ( ... )+
		match(COLON);
		ack=vc_Identifier();
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt103=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 440 "vc.g"
				reqs.push_back(tmp_string);
#line 2415 "vcParser.cpp"
			}
			else {
				if ( _cnt103>=1 ) { goto _loop103; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt103++;
		}
		_loop103:;
		}  // ( ... )+
		match(COLON);
		done=vc_Identifier();
		match(RPAREN);
#line 444 "vc.g"
		slb->Add_Phi_Sequencer(lbl, selects, enables, ack, reqs, done);
#line 2430 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_CPTransitionMerge(
	vcCPPipelinedLoopBody* slb
) {
#line 454 "vc.g"
	
	string tm_id;
	vector<string> in_transitions;
	string out_transition;
	string tmp_string;
	
#line 2448 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITIONMERGE);
		tm_id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt106=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 462 "vc.g"
				in_transitions.push_back(tmp_string);
#line 2461 "vcParser.cpp"
			}
			else {
				if ( _cnt106>=1 ) { goto _loop106; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt106++;
		}
		_loop106:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		out_transition=vc_Identifier();
		match(RPAREN);
#line 467 "vc.g"
		slb->Add_Transition_Merge(tm_id, in_transitions, out_transition);
#line 2477 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_CPFork(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  fe = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  n = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 600 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 2496 "vcParser.cpp"
	
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
#line 607 "vc.g"
			lbl = fe->getText();
#line 2515 "vcParser.cpp"
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
#line 608 "vc.g"
			fork_ids.push_back(e->getText());
#line 2535 "vcParser.cpp"
			break;
		}
		case SIMPLE_IDENTIFIER:
		case RPAREN:
		case N_ULL:
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
		case N_ULL:
		{
			n = LT(1);
			match(N_ULL);
#line 609 "vc.g"
			fork_ids.push_back(n->getText());
#line 2558 "vcParser.cpp"
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
#line 610 "vc.g"
				fork_ids.push_back(b);
#line 2578 "vcParser.cpp"
			}
			else {
				goto _loop168;
			}
			
		}
		_loop168:;
		} // ( ... )*
		match(RPAREN);
#line 611 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 2590 "vcParser.cpp"
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  jen = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  jnull = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 560 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 2610 "vcParser.cpp"
	
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
#line 567 "vc.g"
			lbl = je->getText();
#line 2629 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			jen = LT(1);
			match(ENTRY);
#line 568 "vc.g"
			lbl = jen->getText();
#line 2640 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			jnull = LT(1);
			match(N_ULL);
#line 569 "vc.g"
			lbl = jnull->getText();
#line 2651 "vcParser.cpp"
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
#line 570 "vc.g"
			join_ids.push_back(e->getText());
#line 2671 "vcParser.cpp"
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
#line 571 "vc.g"
				join_ids.push_back(b);
#line 2691 "vcParser.cpp"
			}
			else {
				goto _loop152;
			}
			
		}
		_loop152:;
		} // ( ... )*
		match(RPAREN);
#line 572 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 2703 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_CPMarkedJoin(
	vcCPPipelinedLoopBody* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  jnull = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  me = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  be = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 578 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
		vector<int>  join_markings;
	//
	// TODO: join markings need to be established here..
	//
	
#line 2728 "vcParser.cpp"
	
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
			je = LT(1);
			match(ENTRY);
#line 589 "vc.g"
			lbl = je->getText();
#line 2747 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			jnull = LT(1);
			match(N_ULL);
#line 590 "vc.g"
			lbl = jnull->getText();
#line 2758 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(MARKEDJOIN);
		match(LPAREN);
		{
		switch ( LA(1)) {
		case ENTRY:
		{
			e = LT(1);
			match(ENTRY);
#line 591 "vc.g"
			join_ids.push_back(e->getText());
#line 2778 "vcParser.cpp"
			me = LT(1);
			match(UINTEGER);
#line 592 "vc.g"
			join_markings.push_back(atoi(me->getText().c_str()));
#line 2783 "vcParser.cpp"
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
#line 593 "vc.g"
				join_ids.push_back(b);
#line 2803 "vcParser.cpp"
				be = LT(1);
				match(UINTEGER);
#line 593 "vc.g"
				join_markings.push_back(atoi(be->getText().c_str()));
#line 2808 "vcParser.cpp"
			}
			else {
				goto _loop160;
			}
			
		}
		_loop160:;
		} // ( ... )*
		match(RPAREN);
#line 594 "vc.g"
		fb->Add_Marked_Join_Point(lbl,join_ids, join_markings);
#line 2820 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_Guarded_Operator_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  gid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 636 "vc.g"
	
		vcWire* guard_wire = NULL;
		bool guard_complement = false;
		string gwid;
		vcDatapathElement* dpe = NULL;
	
#line 2839 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case DIV_OP:
		case ULE_OP:
		case NOT_OP:
		case PLUS_OP:
		case MINUS_OP:
		case MUL_OP:
		case SHL_OP:
		case SHR_OP:
		case UGT_OP:
		case UGE_OP:
		case EQ_OP:
		case ULT_OP:
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
		case HASH:
		case StoS_ASSIGN_OP:
		case StoU_ASSIGN_OP:
		case UtoS_ASSIGN_OP:
		case FtoS_ASSIGN_OP:
		case FtoU_ASSIGN_OP:
		case StoF_ASSIGN_OP:
		case UtoF_ASSIGN_OP:
		case FtoF_ASSIGN_OP:
		case SELECT_OP:
		case SLICE_OP:
		case ASSIGN_OP:
		case EQUIVALENCE_OP:
		{
			dpe=vc_Operator_Instantiation(dp);
			break;
		}
		case CALL:
		{
			dpe=vc_Call_Instantiation(sys,dp);
			break;
		}
		case IOPORT:
		{
			dpe=vc_IOPort_Instantiation(dp);
			break;
		}
		case LOAD:
		case STORE:
		{
			dpe=vc_LoadStore_Instantiation(sys,dp);
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
		case GUARD:
		{
			gid = LT(1);
			match(GUARD);
			match(LPAREN);
			{
			switch ( LA(1)) {
			case NOT_OP:
			{
				match(NOT_OP);
#line 647 "vc.g"
				guard_complement = true;
#line 2923 "vcParser.cpp"
				break;
			}
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
			gwid=vc_Identifier();
#line 647 "vc.g"
			guard_wire = dp->Find_Wire(gwid); NOT_FOUND__("wire",guard_wire, gwid,gid)
#line 2939 "vcParser.cpp"
			match(RPAREN);
			break;
		}
		case RBRACE:
		case DIV_OP:
		case BUFFERING:
		case ULE_OP:
		case NOT_OP:
		case PLUS_OP:
		case MINUS_OP:
		case MUL_OP:
		case SHL_OP:
		case SHR_OP:
		case UGT_OP:
		case UGE_OP:
		case EQ_OP:
		case ULT_OP:
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
		case HASH:
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
		case CALL:
		case IOPORT:
		case LOAD:
		case STORE:
		case PHI:
		case CONSTANT:
		case INTERMEDIATE:
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
#line 649 "vc.g"
		
				if((dpe != NULL) && (guard_wire != NULL))
				{
					dpe->Set_Guard_Wire(guard_wire);
					dpe->Set_Guard_Complement(guard_complement);
				}
			
#line 3011 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_Branch_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  br_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 908 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vector<vcWire*> wires;
	vcWire* x;
	
#line 3031 "vcParser.cpp"
	
	try {      // for error handling
		br_id = LT(1);
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt247=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 919 "vc.g"
				x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,br_id)
				wires.push_back(x);
#line 3046 "vcParser.cpp"
			}
			else {
				if ( _cnt247>=1 ) { goto _loop247; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt247++;
		}
		_loop247:;
		}  // ( ... )+
		match(RPAREN);
#line 922 "vc.g"
		new_op = new vcBranch(id,wires); dp->Add_Branch(new_op);
#line 3059 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_Phi_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  p_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1298 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 3080 "vcParser.cpp"
	
	try {      // for error handling
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt275=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1307 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 3096 "vcParser.cpp"
			}
			else {
				if ( _cnt275>=1 ) { goto _loop275; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt275++;
		}
		_loop275:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 1312 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
		phi = new vcPhi(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 3116 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_PhiWithBuffering_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  p_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1324 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhiWithBuffering* phi;
	vector<vcWire*> inwires;
	
#line 3138 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt278=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1333 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 3155 "vcParser.cpp"
			}
			else {
				if ( _cnt278>=1 ) { goto _loop278; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt278++;
		}
		_loop278:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 1338 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
		phi = new vcPhiWithBuffering(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 3175 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_ModuleBufferingSpec(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpe_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  wire_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1622 "vc.g"
	
		string dpe_name;
		string wire_name;
		int buffering;
		bool input_flag = true;
	
#line 3197 "vcParser.cpp"
	
	try {      // for error handling
		match(BUFFERING);
		{
		switch ( LA(1)) {
		case IN:
		{
			match(IN);
			break;
		}
		case OUT:
		{
			{
			match(OUT);
#line 1630 "vc.g"
			input_flag = false;
#line 3214 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		dpe_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1631 "vc.g"
		dpe_name = dpe_id->getText();
#line 3228 "vcParser.cpp"
		wire_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1632 "vc.g"
		wire_name = wire_id->getText();
#line 3233 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1633 "vc.g"
		buffering = atoi(bid->getText().c_str());
#line 3238 "vcParser.cpp"
#line 1634 "vc.g"
		
						vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
						NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
						if(dpe != NULL)
						{
							vcWire* w = m->Get_Data_Path()->Find_Wire(wire_name);
							NOT_FOUND__("wire", w, wire_name, wire_id);
							if(w != NULL)
							{
								if(input_flag)
									dpe->Set_Input_Buffering(w,buffering);
								else
									dpe->Set_Output_Buffering(w,buffering);
		
							}
						}
				
#line 3257 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

vcDatapathElement*  vcParser::vc_Operator_Instantiation(
	vcDataPath* dp
) {
#line 663 "vc.g"
	vcDatapathElement* dpe;
#line 3270 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case DIV_OP:
		case ULE_OP:
		case PLUS_OP:
		case MINUS_OP:
		case MUL_OP:
		case SHL_OP:
		case SHR_OP:
		case UGT_OP:
		case UGE_OP:
		case EQ_OP:
		case ULT_OP:
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
			dpe=vc_BinaryOperator_Instantiation(dp);
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
			dpe=vc_UnaryOperator_Instantiation(dp);
			break;
		}
		case SELECT_OP:
		{
			dpe=vc_Select_Instantiation(dp);
			break;
		}
		case SLICE_OP:
		{
			dpe=vc_Slice_Instantiation(dp);
			break;
		}
		case ASSIGN_OP:
		{
			dpe=vc_Register_Instantiation(dp);
			break;
		}
		case EQUIVALENCE_OP:
		{
			dpe=vc_Equivalence_Instantiation(dp);
			break;
		}
		default:
			if ((LA(1) == HASH) && ((LA(2) >= OR_OP && LA(2) <= XNOR_OP))) {
				dpe=vc_BinaryLogicalOperator_Instantiation(dp);
			}
			else if ((LA(1) == HASH) && (_tokenSet_29.member(LA(2)))) {
				dpe=vc_BinaryOperatorWithInputBuffering_Instantiation(dp);
			}
			else if ((LA(1) == HASH) && (LA(2) == SELECT_OP)) {
				dpe=vc_SelectWithInputBuffering_Instantiation(dp);
			}
			else if ((LA(1) == HASH) && (LA(2) == SLICE_OP)) {
				dpe=vc_SliceWithBuffering_Instantiation(dp);
			}
			else if ((LA(1) == HASH) && (LA(2) == ASSIGN_OP)) {
				dpe=vc_InterlockBuffer_Instantiation(dp);
			}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Call_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 1146 "vc.g"
	vcDatapathElement* dpe;
#line 3371 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1146 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 3385 "vcParser.cpp"
	
	try {      // for error handling
		cid = LT(1);
		match(CALL);
		{
		switch ( LA(1)) {
		case INLINE:
		{
			match(INLINE);
#line 1157 "vc.g"
			inline_flag = true;
#line 3397 "vcParser.cpp"
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
#line 1158 "vc.g"
		m = sys->Find_Module(mid); NOT_FOUND__("module",m,mid,cid)
#line 3415 "vcParser.cpp"
		lpid1 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 1159 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid1)
				inwires.push_back(w);
#line 3426 "vcParser.cpp"
			}
			else {
				goto _loop262;
			}
			
		}
		_loop262:;
		} // ( ... )*
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 1162 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid2)
				outwires.push_back(w);
#line 3446 "vcParser.cpp"
			}
			else {
				goto _loop264;
			}
			
		}
		_loop264:;
		} // ( ... )*
		match(RPAREN);
#line 1165 "vc.g"
		
			 nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc); 
			 dpe = (vcDatapathElement*) nc;
			
#line 3461 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_IOPort_Instantiation(
	vcDataPath* dp
) {
#line 1174 "vc.g"
	vcDatapathElement* dpe;
#line 3475 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ipid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1174 "vc.g"
	
	string id, in_id, out_id, pipe_id;
	vcWire* w;
	vcPipe* p = NULL;
	bool in_flag = false;
	
#line 3485 "vcParser.cpp"
	
	try {      // for error handling
		ipid = LT(1);
		match(IOPORT);
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 1181 "vc.g"
			in_flag = true;
#line 3498 "vcParser.cpp"
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
#line 1183 "vc.g"
		
		if(in_flag)
		{
		w = dp->Find_Wire(out_id);
		NOT_FOUND__("wire",w,out_id,lpid)
		pipe_id = in_id;
		p = dp->Get_Parent()->Find_Pipe(pipe_id);
		NOT_FOUND__("pipe",p,pipe_id,lpid);
		}
		else
		{
		w = dp->Find_Wire(in_id);
		NOT_FOUND__("wire",w,in_id,lpid);
		pipe_id = out_id;
		p = dp->Get_Parent()->Find_Pipe(pipe_id);
		NOT_FOUND__("pipe",p,pipe_id,lpid);
		}
		
		
		
		if(w->Get_Type()->Size() != p->Get_Width())
		vcSystem::Error("Pipe " + pipe_id + " width does not match wire width on IOport " + id);
		
		if(in_flag)
		{
		vcInport* np = new vcInport(id,p,w);
		dp->Add_Inport(np);
			     dpe=(vcDatapathElement*) np;
		}
		else
		{
		vcOutport* np = new vcOutport(id,p,w);
		dp->Add_Outport(np);
			     dpe=(vcDatapathElement*) np;
		}
			
		
#line 3559 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_LoadStore_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 1225 "vc.g"
	vcDatapathElement* dpe;
#line 3573 "vcParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case LOAD:
		{
			dpe=vc_Load_Instantiation(sys,dp);
			break;
		}
		case STORE:
		{
			dpe=vc_Store_Instantiation(sys,dp);
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
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_BinaryOperator_Instantiation(
	vcDataPath* dp
) {
#line 684 "vc.g"
	vcDatapathElement* dpe;
#line 3605 "vcParser.cpp"
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
#line 684 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 3644 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 696 "vc.g"
			op_id = plus_id->getText();
#line 3656 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 697 "vc.g"
			op_id = minus_id->getText();
#line 3667 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 698 "vc.g"
			op_id = mul_id->getText();
#line 3678 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 699 "vc.g"
			op_id = div_id->getText();
#line 3689 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 700 "vc.g"
			op_id = shl_id->getText();
#line 3700 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 701 "vc.g"
			op_id = shr_id->getText();
#line 3711 "vcParser.cpp"
			}
			break;
		}
		case UGT_OP:
		{
			{
			gt_id = LT(1);
			match(UGT_OP);
#line 702 "vc.g"
			op_id = gt_id->getText();
#line 3722 "vcParser.cpp"
			}
			break;
		}
		case UGE_OP:
		{
			{
			ge_id = LT(1);
			match(UGE_OP);
#line 703 "vc.g"
			op_id = ge_id->getText();
#line 3733 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 704 "vc.g"
			op_id = eq_id->getText();
#line 3744 "vcParser.cpp"
			}
			break;
		}
		case ULT_OP:
		{
			{
			lt_id = LT(1);
			match(ULT_OP);
#line 705 "vc.g"
			op_id = lt_id->getText();
#line 3755 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			le_id = LT(1);
			match(ULE_OP);
#line 706 "vc.g"
			op_id = le_id->getText();
#line 3766 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 707 "vc.g"
			op_id = neq_id->getText();
#line 3777 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 708 "vc.g"
			op_id = bitsel_id->getText();
#line 3788 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 709 "vc.g"
			op_id = concat_id->getText();
#line 3799 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 710 "vc.g"
			op_id = or_id->getText();
#line 3810 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 711 "vc.g"
			op_id = and_id->getText();
#line 3821 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 712 "vc.g"
			op_id = xor_id->getText();
#line 3832 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 713 "vc.g"
			op_id = nor_id->getText();
#line 3843 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 714 "vc.g"
			op_id = nand_id->getText();
#line 3854 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 715 "vc.g"
			op_id = xnor_id->getText();
#line 3865 "vcParser.cpp"
			}
			break;
		}
		case SHRA_OP:
		{
			{
			shra_id = LT(1);
			match(SHRA_OP);
#line 716 "vc.g"
			op_id = shra_id->getText();
#line 3876 "vcParser.cpp"
			}
			break;
		}
		case SGT_OP:
		{
			{
			sgt_id = LT(1);
			match(SGT_OP);
#line 717 "vc.g"
			op_id = sgt_id->getText();
#line 3887 "vcParser.cpp"
			}
			break;
		}
		case SGE_OP:
		{
			{
			sge_id = LT(1);
			match(SGE_OP);
#line 718 "vc.g"
			op_id = sge_id->getText();
#line 3898 "vcParser.cpp"
			}
			break;
		}
		case SLT_OP:
		{
			{
			slt_id = LT(1);
			match(SLT_OP);
#line 719 "vc.g"
			op_id = slt_id->getText();
#line 3909 "vcParser.cpp"
			}
			break;
		}
		case SLE_OP:
		{
			{
			sle_id = LT(1);
			match(SLE_OP);
#line 720 "vc.g"
			op_id = sle_id->getText();
#line 3920 "vcParser.cpp"
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
#line 723 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 3939 "vcParser.cpp"
		wid=vc_Identifier();
#line 728 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 3947 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 736 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 3957 "vcParser.cpp"
		match(RPAREN);
#line 741 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op); 
			dpe = (vcDatapathElement*)new_op;
#line 3962 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_UnaryOperator_Instantiation(
	vcDataPath* dp
) {
#line 864 "vc.g"
	vcDatapathElement* dpe;
#line 3976 "vcParser.cpp"
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
#line 864 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 3997 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 876 "vc.g"
			op_id = not_id->getText();
#line 4009 "vcParser.cpp"
			}
			break;
		}
		case StoS_ASSIGN_OP:
		{
			{
			ss_assign_id = LT(1);
			match(StoS_ASSIGN_OP);
#line 877 "vc.g"
			op_id = ss_assign_id->getText();
#line 4020 "vcParser.cpp"
			}
			break;
		}
		case StoU_ASSIGN_OP:
		{
			{
			su_assign_id = LT(1);
			match(StoU_ASSIGN_OP);
#line 878 "vc.g"
			op_id = su_assign_id->getText();
#line 4031 "vcParser.cpp"
			}
			break;
		}
		case UtoS_ASSIGN_OP:
		{
			{
			us_assign_id = LT(1);
			match(UtoS_ASSIGN_OP);
#line 879 "vc.g"
			op_id = us_assign_id->getText();
#line 4042 "vcParser.cpp"
			}
			break;
		}
		case FtoS_ASSIGN_OP:
		{
			{
			fs_assign_id = LT(1);
			match(FtoS_ASSIGN_OP);
#line 880 "vc.g"
			op_id = fs_assign_id->getText();
#line 4053 "vcParser.cpp"
			}
			break;
		}
		case FtoU_ASSIGN_OP:
		{
			{
			fu_assign_id = LT(1);
			match(FtoU_ASSIGN_OP);
#line 881 "vc.g"
			op_id = fu_assign_id->getText();
#line 4064 "vcParser.cpp"
			}
			break;
		}
		case StoF_ASSIGN_OP:
		{
			{
			sf_assign_id = LT(1);
			match(StoF_ASSIGN_OP);
#line 882 "vc.g"
			op_id = sf_assign_id->getText();
#line 4075 "vcParser.cpp"
			}
			break;
		}
		case UtoF_ASSIGN_OP:
		{
			{
			uf_assign_id = LT(1);
			match(UtoF_ASSIGN_OP);
#line 883 "vc.g"
			op_id = uf_assign_id->getText();
#line 4086 "vcParser.cpp"
			}
			break;
		}
		case FtoF_ASSIGN_OP:
		{
			{
			ff_assign_id = LT(1);
			match(FtoF_ASSIGN_OP);
#line 884 "vc.g"
			op_id = ff_assign_id->getText();
#line 4097 "vcParser.cpp"
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
#line 887 "vc.g"
		
		x = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4116 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 894 "vc.g"
		
		z = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4126 "vcParser.cpp"
		match(RPAREN);
#line 899 "vc.g"
		
			new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
			dpe = (vcDatapathElement*) new_op;
		
#line 4133 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Select_Instantiation(
	vcDataPath* dp
) {
#line 929 "vc.g"
	vcDatapathElement* dpe;
#line 4147 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 929 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4161 "vcParser.cpp"
	
	try {      // for error handling
		sel_id = LT(1);
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 944 "vc.g"
		sel = dp->Find_Wire(wid); NOT_FOUND__("wire",sel,wid,sel_id)
#line 4171 "vcParser.cpp"
		wid=vc_Identifier();
#line 945 "vc.g"
		x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,sel_id)
#line 4175 "vcParser.cpp"
		wid=vc_Identifier();
#line 946 "vc.g"
		y = dp->Find_Wire(wid); NOT_FOUND__("wire",y,wid,sel_id)
#line 4179 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 949 "vc.g"
		z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id)
#line 4185 "vcParser.cpp"
		match(RPAREN);
#line 951 "vc.g"
		
			new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);   
			dpe = (vcDatapathElement*) new_op;
		
#line 4192 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Slice_Instantiation(
	vcDataPath* dp
) {
#line 995 "vc.g"
	vcDatapathElement* dpe;
#line 4206 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  slice_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 995 "vc.g"
	
	vcSlice* new_op = NULL;
	string id;
	string wid;
	int h, l;
	vcWire* sel = NULL;
	vcWire* din = NULL;
	vcWire* dout = NULL;
	
#line 4220 "vcParser.cpp"
	
	try {      // for error handling
		slice_id = LT(1);
		match(SLICE_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 1008 "vc.g"
		din = dp->Find_Wire(wid); NOT_FOUND__("wire",din,wid,slice_id)
#line 4230 "vcParser.cpp"
		hid = LT(1);
		match(UINTEGER);
#line 1009 "vc.g"
		h = atoi(hid->getText().c_str());
#line 4235 "vcParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 1010 "vc.g"
		l = atoi(lid->getText().c_str());
#line 4240 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 1013 "vc.g"
		dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id)
#line 4246 "vcParser.cpp"
		match(RPAREN);
#line 1015 "vc.g"
		
			new_op = new vcSlice(id,din,dout,h,l); dp->Add_Slice(new_op);    
			dpe = (vcDatapathElement*) new_op;
		
#line 4253 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Register_Instantiation(
	vcDataPath* dp
) {
#line 1057 "vc.g"
	vcDatapathElement* dpe;
#line 4267 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1057 "vc.g"
	
	vcRegister* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 4278 "vcParser.cpp"
	
	try {      // for error handling
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 1065 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 4289 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 1068 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 4296 "vcParser.cpp"
		match(RPAREN);
#line 1071 "vc.g"
		
		new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
			dpe = (vcDatapathElement*) new_reg;
		
#line 4303 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Equivalence_Instantiation(
	vcDataPath* dp
) {
#line 1107 "vc.g"
	vcDatapathElement* dpe;
#line 4317 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1107 "vc.g"
	
	string id;
	vcEquivalence* nm = NULL;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	vcWire* w;
	string wid;
	
#line 4328 "vcParser.cpp"
	
	try {      // for error handling
		eq_id = LT(1);
		match(EQUIVALENCE_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt256=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 1119 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				inwires.push_back(w);
				
#line 4346 "vcParser.cpp"
			}
			else {
				if ( _cnt256>=1 ) { goto _loop256; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt256++;
		}
		_loop256:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt258=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 1127 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				outwires.push_back(w);
				
#line 4369 "vcParser.cpp"
			}
			else {
				if ( _cnt258>=1 ) { goto _loop258; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt258++;
		}
		_loop258:;
		}  // ( ... )+
		match(RPAREN);
#line 1133 "vc.g"
		
		nm = new vcEquivalence(id,inwires,outwires);
		dp->Add_Equivalence(nm);
			    dpe = (vcDatapathElement*) nm;
		
#line 4386 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_BinaryLogicalOperator_Instantiation(
	vcDataPath* dp
) {
#line 749 "vc.g"
	vcDatapathElement* dpe;
#line 4400 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  or_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  and_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  xor_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  nor_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  nand_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  xnor_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 749 "vc.g"
	
	vcBinaryLogicalOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4420 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		{
		switch ( LA(1)) {
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 763 "vc.g"
			op_id = or_id->getText();
#line 4433 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 764 "vc.g"
			op_id = and_id->getText();
#line 4444 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 765 "vc.g"
			op_id = xor_id->getText();
#line 4455 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 766 "vc.g"
			op_id = nor_id->getText();
#line 4466 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 767 "vc.g"
			op_id = nand_id->getText();
#line 4477 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 768 "vc.g"
			op_id = xnor_id->getText();
#line 4488 "vcParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		lpid = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 772 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4506 "vcParser.cpp"
		wid=vc_Identifier();
#line 777 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 4514 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 785 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4524 "vcParser.cpp"
		match(RPAREN);
#line 790 "vc.g"
		
		new_op = new vcBinaryLogicalOperator(id,op_id,x,y,z); 
		dp->Add_Binary_Logical_Operator(new_op); 
		dpe = (vcDatapathElement*)new_op; 
		
#line 4532 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_BinaryOperatorWithInputBuffering_Instantiation(
	vcDataPath* dp
) {
#line 801 "vc.g"
	vcDatapathElement* dpe;
#line 4546 "vcParser.cpp"
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
	ANTLR_USE_NAMESPACE(antlr)RefToken  shra_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sgt_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sge_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  slt_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sle_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 801 "vc.g"
	
	vcBinaryOperatorWithInputBuffering* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4579 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 814 "vc.g"
			op_id = plus_id->getText();
#line 4592 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 815 "vc.g"
			op_id = minus_id->getText();
#line 4603 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 816 "vc.g"
			op_id = mul_id->getText();
#line 4614 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 817 "vc.g"
			op_id = div_id->getText();
#line 4625 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 818 "vc.g"
			op_id = shl_id->getText();
#line 4636 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 819 "vc.g"
			op_id = shr_id->getText();
#line 4647 "vcParser.cpp"
			}
			break;
		}
		case UGT_OP:
		{
			{
			gt_id = LT(1);
			match(UGT_OP);
#line 820 "vc.g"
			op_id = gt_id->getText();
#line 4658 "vcParser.cpp"
			}
			break;
		}
		case UGE_OP:
		{
			{
			ge_id = LT(1);
			match(UGE_OP);
#line 821 "vc.g"
			op_id = ge_id->getText();
#line 4669 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 822 "vc.g"
			op_id = eq_id->getText();
#line 4680 "vcParser.cpp"
			}
			break;
		}
		case ULT_OP:
		{
			{
			lt_id = LT(1);
			match(ULT_OP);
#line 823 "vc.g"
			op_id = lt_id->getText();
#line 4691 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			le_id = LT(1);
			match(ULE_OP);
#line 824 "vc.g"
			op_id = le_id->getText();
#line 4702 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 825 "vc.g"
			op_id = neq_id->getText();
#line 4713 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 826 "vc.g"
			op_id = bitsel_id->getText();
#line 4724 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 827 "vc.g"
			op_id = concat_id->getText();
#line 4735 "vcParser.cpp"
			}
			break;
		}
		case SHRA_OP:
		{
			{
			shra_id = LT(1);
			match(SHRA_OP);
#line 828 "vc.g"
			op_id = shra_id->getText();
#line 4746 "vcParser.cpp"
			}
			break;
		}
		case SGT_OP:
		{
			{
			sgt_id = LT(1);
			match(SGT_OP);
#line 829 "vc.g"
			op_id = sgt_id->getText();
#line 4757 "vcParser.cpp"
			}
			break;
		}
		case SGE_OP:
		{
			{
			sge_id = LT(1);
			match(SGE_OP);
#line 830 "vc.g"
			op_id = sge_id->getText();
#line 4768 "vcParser.cpp"
			}
			break;
		}
		case SLT_OP:
		{
			{
			slt_id = LT(1);
			match(SLT_OP);
#line 831 "vc.g"
			op_id = slt_id->getText();
#line 4779 "vcParser.cpp"
			}
			break;
		}
		case SLE_OP:
		{
			{
			sle_id = LT(1);
			match(SLE_OP);
#line 832 "vc.g"
			op_id = sle_id->getText();
#line 4790 "vcParser.cpp"
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
#line 835 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4809 "vcParser.cpp"
		wid=vc_Identifier();
#line 840 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 4817 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 848 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4827 "vcParser.cpp"
		match(RPAREN);
#line 853 "vc.g"
		
			new_op = new vcBinaryOperatorWithInputBuffering(id,op_id,x,y,z); 
			dp->Add_Split_Operator(new_op); 
			dpe = (vcDatapathElement*)new_op; 
		
#line 4835 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_SelectWithInputBuffering_Instantiation(
	vcDataPath* dp
) {
#line 961 "vc.g"
	vcDatapathElement* dpe;
#line 4849 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 961 "vc.g"
	
	vcSelectWithInputBuffering* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4863 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		sel_id = LT(1);
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 977 "vc.g"
		sel = dp->Find_Wire(wid); NOT_FOUND__("wire",sel,wid,sel_id)
#line 4874 "vcParser.cpp"
		wid=vc_Identifier();
#line 978 "vc.g"
		x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,sel_id)
#line 4878 "vcParser.cpp"
		wid=vc_Identifier();
#line 979 "vc.g"
		y = dp->Find_Wire(wid); NOT_FOUND__("wire",y,wid,sel_id)
#line 4882 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 982 "vc.g"
		z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id)
#line 4888 "vcParser.cpp"
		match(RPAREN);
#line 984 "vc.g"
		
			new_op = new vcSelectWithInputBuffering(id,sel,x,y,z); 
			dp->Add_Select(new_op);   
			dpe = (vcDatapathElement*) new_op;
		
#line 4896 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_SliceWithBuffering_Instantiation(
	vcDataPath* dp
) {
#line 1025 "vc.g"
	vcDatapathElement* dpe;
#line 4910 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  slice_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1025 "vc.g"
	
	vcSliceWithBuffering* new_op = NULL;
	string id;
	string wid;
	int h, l;
	vcWire* sel = NULL;
	vcWire* din = NULL;
	vcWire* dout = NULL;
	
#line 4924 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		slice_id = LT(1);
		match(SLICE_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 1039 "vc.g"
		din = dp->Find_Wire(wid); NOT_FOUND__("wire",din,wid,slice_id)
#line 4935 "vcParser.cpp"
		hid = LT(1);
		match(UINTEGER);
#line 1040 "vc.g"
		h = atoi(hid->getText().c_str());
#line 4940 "vcParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 1041 "vc.g"
		l = atoi(lid->getText().c_str());
#line 4945 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 1044 "vc.g"
		dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id)
#line 4951 "vcParser.cpp"
		match(RPAREN);
#line 1046 "vc.g"
		
			new_op = new vcSliceWithBuffering(id,din,dout,h,l); dp->Add_Slice(new_op);    
			dpe = (vcDatapathElement*) new_op;
		
#line 4958 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_InterlockBuffer_Instantiation(
	vcDataPath* dp
) {
#line 1081 "vc.g"
	vcDatapathElement* dpe;
#line 4972 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1081 "vc.g"
	
	vcInterlockBuffer* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 4983 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 1089 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 4995 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 1092 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 5002 "vcParser.cpp"
		match(RPAREN);
#line 1095 "vc.g"
		
		new_reg = new vcInterlockBuffer(id, x, y); 
		dp->Add_Interlock_Buffer(new_reg);
		dpe = (vcDatapathElement*) new_reg;
		
#line 5010 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Load_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 1234 "vc.g"
	vcDatapathElement* dpe;
#line 5024 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ldid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1234 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
	
#line 5037 "vcParser.cpp"
	
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
#line 1246 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),ldid)
		
#line 5062 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 1250 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,ldid);
		
#line 5069 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 1253 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",data,wid,ldid);
		
#line 5077 "vcParser.cpp"
		match(RPAREN);
#line 1256 "vc.g"
		
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
			 dpe = (vcDatapathElement*) nl;
		
#line 5085 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Store_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 1267 "vc.g"
	vcDatapathElement* dpe;
#line 5099 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  st_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1267 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 5111 "vcParser.cpp"
	
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
#line 1278 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),st_id)
		
#line 5136 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 1282 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,st_id);
		
#line 5143 "vcParser.cpp"
		wid=vc_Identifier();
#line 1285 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("data",addr,wid,st_id);              
		
#line 5149 "vcParser.cpp"
		match(RPAREN);
#line 1288 "vc.g"
		
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
			 dpe=(vcDatapathElement*)  ns;
		
#line 5157 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

void vcParser::vc_Interface_Object_Declaration(
	vcSystem* sys, vcModule* parent, string mode
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1379 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 5176 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1385 "vc.g"
		obj_name = id->getText();
#line 5183 "vcParser.cpp"
		match(COLON);
		t=vc_Type(sys);
#line 1386 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 5190 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
#line 1394 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	string oname;
	
#line 5207 "vcParser.cpp"
	
	try {      // for error handling
		oname=vc_Label();
#line 1400 "vc.g"
		obj_name = oname;
#line 5213 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 1400 "vc.g"
		*t = tt;
#line 5218 "vcParser.cpp"
		{
		if ((LA(1) == ASSIGN_OP) && (LA(2) == LPAREN || LA(2) == BINARYSTRING || LA(2) == HEXSTRING)) {
			match(ASSIGN_OP);
			vv=vc_Value(*t);
		}
		else if ((_tokenSet_3.member(LA(1))) && (_tokenSet_31.member(LA(2)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
#line 1401 "vc.g"
		if(v != NULL) *v = vv;
#line 5233 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 1455 "vc.g"
	vcValue* v;
#line 5246 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1455 "vc.g"
	
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
	
#line 5271 "vcParser.cpp"
	
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
#line 1478 "vc.g"
				vstring = bid->getText(); format = "binary";
#line 5288 "vcParser.cpp"
				}
				break;
			}
			case HEXSTRING:
			{
				{
				hid = LT(1);
				match(HEXSTRING);
#line 1479 "vc.g"
				vstring = hid->getText(); format = "hexadecimal";
#line 5299 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 1481 "vc.g"
			
				if(t->Is("vcIntType") || t->Is("vcPointerType"))
				   v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
			else if(t->Is("vcFloatType"))
				   v = (vcValue*) (new vcFloatValue((vcFloatType*)t,vstring.substr(2),format));
			
#line 5316 "vcParser.cpp"
			}
			break;
		}
		case LPAREN:
		{
			{
			sid = LT(1);
			match(LPAREN);
			ev=vc_Value(etypes[idx]);
#line 1490 "vc.g"
			evalues.push_back(ev);
#line 5328 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 1491 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 5335 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 1491 "vc.g"
					evalues.push_back(ev);
#line 5339 "vcParser.cpp"
				}
				else {
					goto _loop301;
				}
				
			}
			_loop301:;
			} // ( ... )*
#line 1493 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 5357 "vcParser.cpp"
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
		recover(ex,_tokenSet_32);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType(
	vcSystem* sys
) {
#line 1515 "vc.g"
	vcType* t;
#line 5380 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_7);
	}
	return t;
}

vcType*  vcParser::vc_ArrayType(
	vcSystem* sys
) {
#line 1557 "vc.g"
	vcType* t;
#line 5423 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1557 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 5431 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 1562 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 5440 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 1563 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 5446 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

vcType*  vcParser::vc_RecordType(
	vcSystem* sys
) {
#line 1569 "vc.g"
	vcType* t;
#line 5460 "vcParser.cpp"
#line 1569 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 5467 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		{ // ( ... )+
		int _cnt319=0;
		for (;;) {
			if ((LA(1) == ULT_OP) && (_tokenSet_33.member(LA(2)))) {
				match(ULT_OP);
				{
				et=vc_Type(sys);
#line 1574 "vc.g"
				etypes.push_back(et);
#line 5480 "vcParser.cpp"
				}
				match(UGT_OP);
			}
			else {
				if ( _cnt319>=1 ) { goto _loop319; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt319++;
		}
		_loop319:;
		}  // ( ... )+
#line 1575 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 5494 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

vcType*  vcParser::vc_IntType(
	vcSystem* sys
) {
#line 1521 "vc.g"
	vcType* t;
#line 5508 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1521 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 5515 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(ULT_OP);
		i = LT(1);
		match(UINTEGER);
#line 1526 "vc.g"
		w = atoi(i->getText().c_str());
#line 5524 "vcParser.cpp"
		match(UGT_OP);
#line 1526 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 5528 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

vcType*  vcParser::vc_FloatType(
	vcSystem* sys
) {
#line 1532 "vc.g"
	vcType* t;
#line 5542 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1532 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 5550 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(ULT_OP);
		cid = LT(1);
		match(UINTEGER);
#line 1537 "vc.g"
		c = atoi(cid->getText().c_str());
#line 5559 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 1537 "vc.g"
		m = atoi(mid->getText().c_str());
#line 5565 "vcParser.cpp"
		match(UGT_OP);
#line 1538 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 5569 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

vcType*  vcParser::vc_PointerType(
	vcSystem* sys
) {
#line 1545 "vc.g"
	vcType* t;
#line 5583 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1545 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 5591 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(ULT_OP);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(DIV_OP);
#line 1550 "vc.g"
			scope_id = sid->getText();
#line 5603 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == UGT_OP)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1551 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 5616 "vcParser.cpp"
		match(UGT_OP);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
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
	"LIFO",
	"PIPE",
	"UINTEGER",
	"DEPTH",
	"MEMORYSPACE",
	"UNORDERED",
	"LBRACE",
	"RBRACE",
	"CAPACITY",
	"DATAWIDTH",
	"ADDRWIDTH",
	"MAXACCESSWIDTH",
	"OBJECT",
	"COLON",
	"FOREIGN",
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
	"TIED_HIGH",
	"LEFT_OPEN",
	"DELAY",
	"SERIESBLOCK",
	"PARALLELBLOCK",
	"BRANCHBLOCK",
	"LOOPBLOCK",
	"BUFFERING",
	"FULLRATE",
	"TERMINATE",
	"PHISEQUENCER",
	"TRANSITIONMERGE",
	"BIND",
	"IMPLIES",
	"ULE_OP",
	"MERGE",
	"BRANCH",
	"FORKBLOCK",
	"PIPELINE",
	"N_ULL",
	"JOIN",
	"MARKEDJOIN",
	"FORK",
	"DATAPATH",
	"GUARD",
	"NOT_OP",
	"PLUS_OP",
	"MINUS_OP",
	"MUL_OP",
	"SHL_OP",
	"SHR_OP",
	"UGT_OP",
	"UGE_OP",
	"EQ_OP",
	"ULT_OP",
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
	"HASH",
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
	"SIMPLE_IDENTIFER",
	"ATTRIBUTE",
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

const unsigned long vcParser::_tokenSet_0_data_[] = { 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_0(_tokenSet_0_data_,6);
const unsigned long vcParser::_tokenSet_1_data_[] = { 786738UL, 128UL, 0UL, 16791552UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE FOREIGN MODULE BUFFERING CONSTANT INTERMEDIATE 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,8);
const unsigned long vcParser::_tokenSet_2_data_[] = { 270272818UL, 8388736UL, 0UL, 16791552UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN MODULE SIMPLE_IDENTIFIER CONTROLPATH 
// BUFFERING DATAPATH CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 34343218UL, 4261429376UL, 4294967295UL, 16791890UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN MODULE DIV_OP BUFFERING ULE_OP 
// NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP 
// NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP 
// SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP HASH StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 3965324480UL, 920703UL, 0UL, 16777376UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER DEPTH LBRACE RBRACE COLON MODULE SIMPLE_IDENTIFIER LPAREN ENTRY 
// EXIT PLACE TRANSITION DEAD TIED_HIGH LEFT_OPEN DELAY SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK PIPELINE 
// N_ULL FROM TO ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,8);
const unsigned long vcParser::_tokenSet_5_data_[] = { 67584UL, 0UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,8);
const unsigned long vcParser::_tokenSet_6_data_[] = { 1846544384UL, 4262087928UL, 4294967295UL, 16791890UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DIV_OP ENTRY EXIT PLACE TRANSITION SERIESBLOCK 
// PARALLELBLOCK BRANCHBLOCK LOOPBLOCK BUFFERING PHISEQUENCER TRANSITIONMERGE 
// ULE_OP FORKBLOCK N_ULL NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP 
// UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP 
// NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP HASH StoS_ASSIGN_OP 
// StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP 
// UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP 
// EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,8);
const unsigned long vcParser::_tokenSet_7_data_[] = { 303892786UL, 4269817984UL, 4294967295UL, 16791898UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE OBJECT FOREIGN MODULE SIMPLE_IDENTIFIER 
// DIV_OP CONTROLPATH BUFFERING ULE_OP DATAPATH NOT_OP PLUS_OP MINUS_OP 
// MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP 
// SLE_OP HASH StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT OUT LOAD STORE 
// PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,8);
const unsigned long vcParser::_tokenSet_8_data_[] = { 269486384UL, 8388608UL, 0UL, 16777224UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// OUT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,8);
const unsigned long vcParser::_tokenSet_9_data_[] = { 269486384UL, 8388608UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,8);
const unsigned long vcParser::_tokenSet_10_data_[] = { 0UL, 131128UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,6);
const unsigned long vcParser::_tokenSet_11_data_[] = { 1050624UL, 8388608UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 33554432UL, 4261429248UL, 4227858431UL, 82UL, 0UL, 0UL, 0UL, 0UL };
// DIV_OP ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP 
// EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP HASH StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT 
// LOAD STORE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 33554432UL, 4227874816UL, 939655167UL, 525UL, 0UL, 0UL, 0UL, 0UL };
// DIV_OP ULE_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP 
// ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP SELECT_OP SLICE_OP ASSIGN_OP 
// INLINE IN OUT LBRACKET 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,8);
const unsigned long vcParser::_tokenSet_14_data_[] = { 1050624UL, 0UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,8);
const unsigned long vcParser::_tokenSet_15_data_[] = { 227540992UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RPAREN OPEN ENTRY EXIT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,6);
const unsigned long vcParser::_tokenSet_16_data_[] = { 265420864UL, 7467520UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER COLON SIMPLE_IDENTIFIER LPAREN RPAREN OPEN DIV_OP ENTRY EXIT 
// TERMINATE BIND IMPLIES ULE_OP MERGE BRANCH JOIN MARKEDJOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,6);
const unsigned long vcParser::_tokenSet_17_data_[] = { 1812989952UL, 658552UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,8);
const unsigned long vcParser::_tokenSet_18_data_[] = { 1610614784UL, 131128UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,8);
const unsigned long vcParser::_tokenSet_19_data_[] = { 1611663360UL, 393336UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK FORKBLOCK PIPELINE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,8);
const unsigned long vcParser::_tokenSet_20_data_[] = { 1812989952UL, 658488UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,8);
const unsigned long vcParser::_tokenSet_21_data_[] = { 202375168UL, 524288UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER ENTRY EXIT N_ULL 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,6);
const unsigned long vcParser::_tokenSet_22_data_[] = { 537921536UL, 135288UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// LOOPBLOCK BIND FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 537921536UL, 131192UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// LOOPBLOCK FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,8);
const unsigned long vcParser::_tokenSet_24_data_[] = { 0UL, 8UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,6);
const unsigned long vcParser::_tokenSet_25_data_[] = { 0UL, 4608UL, 0UL, 0UL, 0UL, 0UL };
// TERMINATE BIND 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,6);
const unsigned long vcParser::_tokenSet_26_data_[] = { 2048UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,6);
const unsigned long vcParser::_tokenSet_27_data_[] = { 1276119040UL, 658488UL, 0UL, 16777216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,8);
const unsigned long vcParser::_tokenSet_28_data_[] = { 33556480UL, 4261429376UL, 4294967295UL, 16791890UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DIV_OP BUFFERING ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP 
// SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP 
// XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP HASH 
// StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP 
// StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP 
// ASSIGN_OP EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,8);
const unsigned long vcParser::_tokenSet_29_data_[] = { 33554432UL, 4227874816UL, 127039UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// DIV_OP ULE_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP 
// ULT_OP NEQ_OP BITSEL_OP CONCAT_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_29(_tokenSet_29_data_,8);
const unsigned long vcParser::_tokenSet_30_data_[] = { 33556480UL, 4278206592UL, 4294967295UL, 16791890UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DIV_OP BUFFERING ULE_OP GUARD NOT_OP PLUS_OP MINUS_OP MUL_OP 
// SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP 
// SLE_OP HASH StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI 
// CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_30(_tokenSet_30_data_,8);
const unsigned long vcParser::_tokenSet_31_data_[] = { 35130146UL, 4227874816UL, 939655167UL, 25174797UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE UNORDERED RBRACE MODULE SIMPLE_IDENTIFIER DIV_OP 
// ULE_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP 
// NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP 
// SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP SELECT_OP SLICE_OP ASSIGN_OP INLINE 
// IN OUT PHI LBRACKET WIRE SIMPLE_IDENTIFER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_31(_tokenSet_31_data_,8);
const unsigned long vcParser::_tokenSet_32_data_[] = { 42731826UL, 4261429376UL, 4294967295UL, 16857426UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN MODULE RPAREN DIV_OP BUFFERING 
// ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP 
// ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP HASH StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_32(_tokenSet_32_data_,8);
const unsigned long vcParser::_tokenSet_33_data_[] = { 0UL, 0UL, 0UL, 6160384UL, 0UL, 0UL, 0UL, 0UL };
// INT FLOAT POINTER ARRAY RECORD 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_33(_tokenSet_33_data_,8);


