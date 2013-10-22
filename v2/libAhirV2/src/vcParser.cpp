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
			case PIPELINE:
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
#line 68 "vcParser.cpp"
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
#line 123 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 131 "vc.g"
	
		string lbl;
		m = NULL;
	bool foreign_flag = false;
		bool pipeline_flag = false;
	vcMemorySpace* ms;
	int depth = 1;
	int buffering = 1;
	bool full_rate_flag = false;
	
#line 137 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case FOREIGN:
		{
			{
			match(FOREIGN);
#line 142 "vc.g"
			foreign_flag = true;
#line 148 "vcParser.cpp"
			}
			break;
		}
		case PIPELINE:
		{
			{
			match(PIPELINE);
#line 143 "vc.g"
			pipeline_flag = true;
#line 158 "vcParser.cpp"
			{
			switch ( LA(1)) {
			case DEPTH:
			{
				match(DEPTH);
				did = LT(1);
				match(UINTEGER);
#line 144 "vc.g"
				depth = atoi(did->getText().c_str());
#line 168 "vcParser.cpp"
				break;
			}
			case BUFFERING:
			case FULLRATE:
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
			{
			switch ( LA(1)) {
			case BUFFERING:
			{
				match(BUFFERING);
				bid = LT(1);
				match(UINTEGER);
#line 145 "vc.g"
				buffering = atoi(did->getText().c_str());
#line 192 "vcParser.cpp"
				break;
			}
			case FULLRATE:
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
			{
			switch ( LA(1)) {
			case FULLRATE:
			{
				match(FULLRATE);
#line 146 "vc.g"
				full_rate_flag = true;
#line 213 "vcParser.cpp"
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
			}
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
#line 149 "vc.g"
		
		m = new vcModule(sys,lbl); 
		sys->Add_Module(m); 
		if(foreign_flag) m->Set_Foreign_Flag(true);
		if(pipeline_flag) { 
				m->Set_Pipeline_Flag(true); 
				m->Set_Pipeline_Depth(depth);
				m->Set_Pipeline_Buffering(buffering);
				m->Set_Pipeline_Full_Rate_Flag(full_rate_flag);
			    }
		
#line 253 "vcParser.cpp"
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
#line 161 "vc.g"
				m->Add_Memory_Space(ms);
#line 310 "vcParser.cpp"
			}
			else {
				goto _loop31;
			}
			
		}
		_loop31:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LIFO || LA(1) == PIPE)) {
				vc_Pipe(NULL,m);
			}
			else {
				goto _loop33;
			}
			
		}
		_loop33:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case CONTROLPATH:
		{
			vc_Controlpath(sys,m);
#line 163 "vc.g"
			assert(!foreign_flag);
#line 338 "vcParser.cpp"
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
#line 164 "vc.g"
			assert(!foreign_flag);
#line 361 "vcParser.cpp"
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
#line 165 "vc.g"
				assert(!foreign_flag);
#line 382 "vcParser.cpp"
			}
			else {
				goto _loop37;
			}
			
		}
		_loop37:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(m);
			}
			else {
				goto _loop39;
			}
			
		}
		_loop39:;
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
#line 417 "vcParser.cpp"
#line 85 "vc.g"
	
		string lbl;
		bool unordered_flag = false;
		ms = NULL;
	
#line 424 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		{
		switch ( LA(1)) {
		case UNORDERED:
		{
			match(UNORDERED);
#line 91 "vc.g"
			unordered_flag = true;
#line 435 "vcParser.cpp"
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
			
#line 454 "vcParser.cpp"
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
	
#line 501 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case LIFO:
		{
			match(LIFO);
#line 72 "vc.g"
			lifo_mode = true;
#line 511 "vcParser.cpp"
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
#line 537 "vcParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case LIFO:
		case PIPE:
		case MEMORYSPACE:
		case RBRACE:
		case FOREIGN:
		case PIPELINE:
		case BUFFERING:
		case MODULE:
		case SIMPLE_IDENTIFIER:
		case CONTROLPATH:
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
		
#line 572 "vcParser.cpp"
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
#line 1275 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	bool intermediate_flag = false;
	
#line 594 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			{
			cid = LT(1);
			match(CONSTANT);
#line 1284 "vc.g"
			const_flag = true;
#line 606 "vcParser.cpp"
			}
			break;
		}
		case INTERMEDIATE:
		{
			{
			iid = LT(1);
			match(INTERMEDIATE);
#line 1284 "vc.g"
			intermediate_flag = true;
#line 617 "vcParser.cpp"
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
#line 1285 "vc.g"
		
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
		
#line 665 "vcParser.cpp"
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
#line 1543 "vc.g"
	
		string key;
		string value;
		bool mem_space = false;
	bool module = false;
		vcRoot* child = NULL;
		string m_id;
		string ms_id;
	string child_id;
	
#line 690 "vcParser.cpp"
	
	try {      // for error handling
		aid = LT(1);
		match(ATTRIBUTE);
		{
		switch ( LA(1)) {
		case MEMORYSPACE:
		{
			{
			match(MEMORYSPACE);
#line 1556 "vc.g"
			mem_space = true;
#line 703 "vcParser.cpp"
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
#line 1558 "vc.g"
			
								child_id = m_id + "/" + ms_id; 
								child = sys->Find_Memory_Space(m_id,ms_id);
							
#line 722 "vcParser.cpp"
			}
			break;
		}
		case MODULE:
		{
			{
			match(MODULE);
#line 1562 "vc.g"
			module = true;
#line 732 "vcParser.cpp"
			m_id=vc_Identifier();
#line 1564 "vc.g"
			
								child_id = m_id;
								child = sys->Find_Module(m_id);
							
#line 739 "vcParser.cpp"
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
#line 1569 "vc.g"
		key = kid->getText();
#line 753 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1570 "vc.g"
		value = vid->getText();
#line 759 "vcParser.cpp"
#line 1571 "vc.g"
		
					if(child != NULL) 
						child->Add_Attribute(key,value);
					else
					{
						vcSystem::Warning("could not find " + child_id + " to add attribute,"
									+ IntToStr(aid->getLine()));
								
					}
				
#line 771 "vcParser.cpp"
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
#line 1447 "vc.g"
	
		string mod_name;
		string dpe_name;
		string wire_name;
		int buffering;
		bool input_flag = true;
	
#line 794 "vcParser.cpp"
	
	try {      // for error handling
		match(BUFFERING);
		mid = LT(1);
		match(SIMPLE_IDENTIFER);
#line 1456 "vc.g"
		mod_name = mid->getText();
#line 802 "vcParser.cpp"
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
#line 1457 "vc.g"
			input_flag = false;
#line 816 "vcParser.cpp"
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
#line 1458 "vc.g"
		dpe_name = dpe_id->getText();
#line 830 "vcParser.cpp"
		wire_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1459 "vc.g"
		wire_name = wire_id->getText();
#line 835 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1460 "vc.g"
		buffering = atoi(bid->getText().c_str());
#line 840 "vcParser.cpp"
#line 1461 "vc.g"
		
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
				
#line 864 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

string  vcParser::vc_Label() {
#line 1216 "vc.g"
	string lbl;
#line 875 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1218 "vc.g"
		lbl = id->getText();
#line 885 "vcParser.cpp"
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
#line 910 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 106 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 916 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 107 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 922 "vcParser.cpp"
		match(MAXACCESSWIDTH);
		maw = LT(1);
		match(UINTEGER);
#line 108 "vc.g"
		ms->Set_Max_Access_Width(atoi(maw->getText().c_str()));
#line 928 "vcParser.cpp"
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
	
#line 946 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
#line 122 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
		ms->Add_Storage_Object(nl);
		
#line 958 "vcParser.cpp"
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
#line 1586 "vc.g"
	
		string key;
		string value;
	
#line 976 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1592 "vc.g"
		key = kid->getText();
#line 984 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1592 "vc.g"
		value = vid->getText();
#line 990 "vcParser.cpp"
#line 1593 "vc.g"
		m->Add_Attribute(key,value);
#line 993 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 1375 "vc.g"
	vcType* t;
#line 1006 "vcParser.cpp"
	
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
#line 1224 "vc.g"
	
		string mode = "in";
	
#line 1055 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
			}
			else {
				goto _loop282;
			}
			
		}
		_loop282:;
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
#line 1235 "vc.g"
	
		string mode = "out";
	
#line 1085 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop285;
			}
			
		}
		_loop285:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
}

void vcParser::vc_Controlpath(
	vcSystem* sys, vcModule* m
) {
#line 262 "vc.g"
	
	vcControlPath* cp;
	cp = new vcControlPath(m->Get_Id() + "_CP");
	vcCPElement* cpe;
	
#line 1117 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{
		switch ( LA(1)) {
		case PIPELINEDFORKBLOCK:
		{
			{
			vc_CPPipelinedForkBlock(cp,m);
#line 271 "vc.g"
				
						assert(m->Get_Pipeline_Flag());
						cp->Set_Is_Pipelined(true);
						cp->Set_Pipeline_Depth(m->Get_Pipeline_Depth());
						cp->Set_Pipeline_Buffering(m->Get_Pipeline_Buffering());
						cp->Set_Pipeline_Full_Rate_Flag(m->Get_Pipeline_Full_Rate_Flag());
					
#line 1136 "vcParser.cpp"
			{ // ( ... )+
			int _cnt58=0;
			for (;;) {
				if ((LA(1) == PLACE)) {
					cpe=vc_CPPlace(cp);
#line 278 "vc.g"
					cp->Add_CPElement(cpe);
#line 1144 "vcParser.cpp"
				}
				else {
					if ( _cnt58>=1 ) { goto _loop58; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt58++;
			}
			_loop58:;
			}  // ( ... )+
			{ // ( ... )+
			int _cnt60=0;
			for (;;) {
				if ((LA(1) == BIND)) {
					vc_CPBind(cp);
				}
				else {
					if ( _cnt60>=1 ) { goto _loop60; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt60++;
			}
			_loop60:;
			}  // ( ... )+
			}
			break;
		}
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case FORKBLOCK:
		{
			{
			{ // ( ... )+
			int _cnt63=0;
			for (;;) {
				if ((_tokenSet_10.member(LA(1)))) {
					vc_CPRegion(cp);
				}
				else {
					if ( _cnt63>=1 ) { goto _loop63; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt63++;
			}
			_loop63:;
			}  // ( ... )+
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
			}
			break;
		}
		case RBRACE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(RBRACE);
#line 282 "vc.g"
		
			m->Set_Control_Path(cp);
		
#line 1221 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 670 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
		m->Set_Data_Path(dp);
	
#line 1237 "vcParser.cpp"
	
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
			case DELAY:
			{
				vc_ModuleDelaySpec(m);
				break;
			}
			default:
				if ((_tokenSet_12.member(LA(1))) && (_tokenSet_13.member(LA(2)))) {
					vc_Guarded_Operator_Instantiation(sys,dp);
				}
				else if ((LA(1) == HASH) && (LA(2) == PHI)) {
					vc_PhiPipelined_Instantiation(dp);
				}
			else {
				goto _loop200;
			}
			}
		}
		_loop200:;
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
#line 174 "vc.g"
	
	vcDatapathElement* dpe;
	vector<string> ref_vec;
	vector<vcTransition*> reqs;
	vector<vcTransition*> acks;
	
#line 1310 "vcParser.cpp"
	
	try {      // for error handling
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 182 "vc.g"
		
		dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
		NOT_FOUND__("datapath-element",dpe,dpeid->getText(),dpeid)
		
#line 1320 "vcParser.cpp"
		match(EQUIVALENT);
		match(LPAREN);
		{ // ( ... )+
		int _cnt42=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 189 "vc.g"
				
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
				
				
#line 1350 "vcParser.cpp"
			}
			else {
				if ( _cnt42>=1 ) { goto _loop42; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt42++;
		}
		_loop42:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt46=0;
		for (;;) {
			switch ( LA(1)) {
			case SIMPLE_IDENTIFIER:
			case ENTRY:
			case EXIT:
			{
				{
				vc_Hierarchical_CP_Ref(ref_vec);
#line 214 "vc.g"
				
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
				
				
				
#line 1396 "vcParser.cpp"
				}
				break;
			}
			case OPEN:
			{
				{
				match(OPEN);
#line 239 "vc.g"
				acks.push_back(NULL);
#line 1406 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt46>=1 ) { goto _loop46; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt46++;
		}
		_loop46:;
		}  // ( ... )+
		match(RPAREN);
#line 242 "vc.g"
		m->Add_Link(dpe,reqs,acks);
#line 1422 "vcParser.cpp"
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
#line 249 "vc.g"
	
	string id;
	
#line 1439 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				id=vc_Identifier();
#line 253 "vc.g"
				ref_vec.push_back(id);
#line 1448 "vcParser.cpp"
				match(DIV_OP);
			}
			else {
				goto _loop49;
			}
			
		}
		_loop49:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			id=vc_Identifier();
#line 254 "vc.g"
			ref_vec.push_back(id);
#line 1466 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			entry_id = LT(1);
			match(ENTRY);
#line 255 "vc.g"
			ref_vec.push_back(entry_id->getText());
#line 1477 "vcParser.cpp"
			}
			break;
		}
		case EXIT:
		{
			{
			exit_id = LT(1);
			match(EXIT);
#line 256 "vc.g"
			ref_vec.push_back(exit_id->getText());
#line 1488 "vcParser.cpp"
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
#line 1601 "vc.g"
	string s;
#line 1508 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1601 "vc.g"
		s = id->getText();
#line 1516 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_16);
	}
	return s;
}

void vcParser::vc_CPPipelinedForkBlock(
	vcCPBlock* cp, vcModule* m
) {
#line 562 "vc.g"
	
		string lbl;
		vcCPPipelinedForkBlock* fb;
		vcCPElement* cpe;
		string internal_id;
	
#line 1535 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPELINEDFORKBLOCK);
		lbl=vc_Label();
#line 569 "vc.g"
		fb = new vcCPPipelinedForkBlock(cp,lbl); fb->Set_Max_Iterations_In_Flight(m->Get_Pipeline_Depth());
#line 1542 "vcParser.cpp"
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
#line 574 "vc.g"
				fb->Add_CPElement(cpe);
#line 1563 "vcParser.cpp"
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
				if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == N_ULL) && (LA(2) == FORK)) {
					{
					vc_CPFork(fb);
					}
				}
				else if ((_tokenSet_17.member(LA(1))) && (LA(2) == JOIN)) {
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
				goto _loop148;
			}
			}
		}
		_loop148:;
		} // ( ... )*
		match(RBRACE);
#line 576 "vc.g"
		cp->Add_CPElement(fb);
#line 1600 "vcParser.cpp"
		{
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 577 "vc.g"
				fb->Add_Exported_Input(internal_id);
#line 1609 "vcParser.cpp"
			}
			else {
				goto _loop151;
			}
			
		}
		_loop151:;
		} // ( ... )*
		match(RPAREN);
		}
		{
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 578 "vc.g"
				fb->Add_Exported_Output(internal_id);
#line 1628 "vcParser.cpp"
			}
			else {
				goto _loop154;
			}
			
		}
		_loop154:;
		} // ( ... )*
		match(RPAREN);
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_18);
	}
}

vcCPElement*  vcParser::vc_CPPlace(
	vcCPElement* p
) {
#line 297 "vc.g"
	vcCPElement* cpe;
#line 1651 "vcParser.cpp"
#line 297 "vc.g"
	
	string id;
	
#line 1656 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 302 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		cpe = (vcCPElement*) new vcPlace(p, id,0);
		
#line 1667 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case LEFT_OPEN:
		{
			match(LEFT_OPEN);
#line 307 "vc.g"
			cpe->Set_Is_Left_Open(true);
#line 1675 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case PIPELINE:
		case SIMPLE_IDENTIFIER:
		case PLACE:
		case TRANSITION:
		case SERIESBLOCK:
		case PARALLELBLOCK:
		case BRANCHBLOCK:
		case LOOPBLOCK:
		case BIND:
		case FORKBLOCK:
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
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
	return cpe;
}

void vcParser::vc_CPBind(
	vcCPBlock* cp
) {
#line 502 "vc.g"
	
		string pl_lbl, rgn_label, rgn_internal_lbl;
	bool input_binding;
	
#line 1715 "vcParser.cpp"
	
	try {      // for error handling
		match(BIND);
		pl_lbl=vc_Identifier();
		{
		switch ( LA(1)) {
		case IMPLIES:
		{
			{
			match(IMPLIES);
#line 507 "vc.g"
			input_binding = true;
#line 1728 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			match(ULE_OP);
#line 507 "vc.g"
			input_binding = false;
#line 1738 "vcParser.cpp"
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
#line 508 "vc.g"
		
			cp->Bind(pl_lbl,rgn_label,rgn_internal_lbl,input_binding);
		
#line 1755 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
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
		recover(ex,_tokenSet_21);
	}
}

vcCPElement*  vcParser::vc_CPElement(
	vcCPElement* p
) {
#line 290 "vc.g"
	vcCPElement* cpe;
#line 1806 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_22);
	}
	return cpe;
}

vcCPElement*  vcParser::vc_CPTransition(
	vcCPElement* p
) {
#line 314 "vc.g"
	vcCPElement* cpe;
#line 1842 "vcParser.cpp"
#line 314 "vc.g"
	
	string id;
	bool dead_flag = false;
	bool tie_high = false;
	bool leave_open = false;
	bool delay_flag = false;
	
#line 1851 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
		{
		switch ( LA(1)) {
		case DEAD:
		{
			{
			match(DEAD);
#line 322 "vc.g"
			dead_flag = true;
#line 1864 "vcParser.cpp"
			}
			break;
		}
		case TIED_HIGH:
		{
			{
			match(TIED_HIGH);
#line 322 "vc.g"
			tie_high = true;
#line 1874 "vcParser.cpp"
			}
			break;
		}
		case LEFT_OPEN:
		{
			{
			match(LEFT_OPEN);
#line 323 "vc.g"
			leave_open = true;
#line 1884 "vcParser.cpp"
			}
			break;
		}
		case DELAY:
		{
			{
			match(DELAY);
#line 323 "vc.g"
			delay_flag = true;
#line 1894 "vcParser.cpp"
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
#line 324 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		{
		cpe = (vcCPElement*) (new vcTransition(p,id));
			((vcTransition*)cpe)->Set_Is_Dead(dead_flag);
			((vcTransition*)cpe)->Set_Is_Tied_High(tie_high);
			((vcTransition*)cpe)->Set_Is_Left_Open(leave_open);
			((vcTransition*)cpe)->Set_Is_Delay_Element(delay_flag);
		}
		
#line 1933 "vcParser.cpp"
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
#line 351 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1951 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 357 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 1958 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 358 "vc.g"
				sb->Add_CPElement(cpe);
#line 1970 "vcParser.cpp"
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
				goto _loop83;
			}
			}
		}
		_loop83:;
		} // ( ... )*
		match(RBRACE);
#line 360 "vc.g"
		cp->Add_CPElement(sb);
#line 2002 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 366 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	vcCPElement* t;
	
#line 2020 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 373 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 2027 "vcParser.cpp"
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
#line 374 "vc.g"
				sb->Add_CPElement(t);
#line 2045 "vcParser.cpp"
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
				goto _loop87;
			}
			}
		}
		_loop87:;
		} // ( ... )*
		match(RBRACE);
#line 376 "vc.g"
		cp->Add_CPElement(sb);
#line 2066 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 383 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 2083 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 389 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 2090 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt96=0;
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
#line 394 "vc.g"
				sb->Add_CPElement(cpe);
#line 2119 "vcParser.cpp"
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
				if ( _cnt96>=1 ) { goto _loop96; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt96++;
		}
		_loop96:;
		}  // ( ... )+
		match(RBRACE);
#line 396 "vc.g"
		cp->Add_CPElement(sb);
#line 2152 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 544 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 2169 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 550 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 2176 "vcParser.cpp"
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
#line 554 "vc.g"
				fb->Add_CPElement(cpe);
#line 2197 "vcParser.cpp"
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
				if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == N_ULL) && (LA(2) == FORK)) {
					{
					vc_CPFork(fb);
					}
				}
				else if ((_tokenSet_17.member(LA(1))) && (LA(2) == JOIN)) {
					{
					vc_CPJoin(fb);
					}
				}
			else {
				goto _loop139;
			}
			}
		}
		_loop139:;
		} // ( ... )*
		match(RBRACE);
#line 556 "vc.g"
		cp->Add_CPElement(fb);
#line 2229 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPBranch(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 531 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 2246 "vcParser.cpp"
	
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
#line 537 "vc.g"
			branch_ids.push_back(e->getText());
#line 2260 "vcParser.cpp"
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
#line 538 "vc.g"
				branch_ids.push_back(b);
#line 2280 "vcParser.cpp"
			}
			else {
				goto _loop131;
			}
			
		}
		_loop131:;
		} // ( ... )*
#line 538 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 2291 "vcParser.cpp"
		match(RPAREN);
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
#line 516 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 2309 "vcParser.cpp"
	
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
#line 522 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 2323 "vcParser.cpp"
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
#line 523 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 2343 "vcParser.cpp"
			}
			else {
				goto _loop127;
			}
			
		}
		_loop127:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPSimpleLoopBlock(
	vcCPBlock* cp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 402 "vc.g"
	
		string lbl;
		vcCPSimpleLoopBlock* sb;
		vcCPElement* cpe;
		int depth, buffering;
		bool full_rate_flag = false;
	
#line 2373 "vcParser.cpp"
	
	try {      // for error handling
		match(LOOPBLOCK);
		lbl=vc_Label();
#line 410 "vc.g"
		sb = new vcCPSimpleLoopBlock(cp,lbl);
#line 2380 "vcParser.cpp"
		match(DEPTH);
		did = LT(1);
		match(UINTEGER);
#line 411 "vc.g"
		depth = atoi(did->getText().c_str()); sb->Set_Pipeline_Depth(depth);
#line 2386 "vcParser.cpp"
		match(BUFFERING);
		bid = LT(1);
		match(UINTEGER);
#line 412 "vc.g"
		buffering = atoi(bid->getText().c_str()); sb->Set_Pipeline_Buffering(buffering);
#line 2392 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case FULLRATE:
		{
			match(FULLRATE);
#line 413 "vc.g"
			full_rate_flag = true;
#line 2400 "vcParser.cpp"
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
#line 415 "vc.g"
				sb->Add_CPElement(cpe);
#line 2420 "vcParser.cpp"
			}
			else {
				goto _loop100;
			}
			
		}
		_loop100:;
		} // ( ... )*
		vc_CPPipelinedLoopBody(sb);
		{ // ( ... )+
		int _cnt102=0;
		for (;;) {
			if ((LA(1) == SERIESBLOCK)) {
				vc_CPSeriesBlock(sb);
			}
			else {
				if ( _cnt102>=1 ) { goto _loop102; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt102++;
		}
		_loop102:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt104=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == MERGE)) {
				vc_CPMerge(sb);
			}
			else {
				if ( _cnt104>=1 ) { goto _loop104; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt104++;
		}
		_loop104:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt106=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_CPBranch(sb);
			}
			else {
				if ( _cnt106>=1 ) { goto _loop106; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt106++;
		}
		_loop106:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt108=0;
		for (;;) {
			if ((LA(1) == BIND)) {
				vc_CPBind(sb);
			}
			else {
				if ( _cnt108>=1 ) { goto _loop108; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt108++;
		}
		_loop108:;
		}  // ( ... )+
		vc_CPLoopTerminate(sb);
		match(RBRACE);
#line 424 "vc.g"
		cp->Add_CPElement(sb);  sb->Set_Pipeline_Full_Rate_Flag(true);
#line 2490 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPPipelinedLoopBody(
	vcCPBlock* cp
) {
#line 585 "vc.g"
	
	string lbl;
	vcCPPipelinedLoopBody* fb;
	vcCPElement* cpe;
	string internal_id, external_id;
	bool pipeline_flag = false;
	
#line 2509 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPELINE);
		lbl=vc_Label();
#line 593 "vc.g"
		fb = new vcCPPipelinedLoopBody(cp,lbl);
#line 2516 "vcParser.cpp"
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
#line 598 "vc.g"
				fb->Add_CPElement(cpe);
#line 2537 "vcParser.cpp"
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
				if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == N_ULL) && (LA(2) == FORK)) {
					{
					vc_CPFork(fb);
					}
				}
				else if ((_tokenSet_17.member(LA(1))) && (LA(2) == JOIN)) {
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
				goto _loop165;
			}
			}
		}
		_loop165:;
		} // ( ... )*
		match(RBRACE);
#line 602 "vc.g"
		cp->Add_CPElement(fb);
#line 2588 "vcParser.cpp"
		{
		match(LPAREN);
		{ // ( ... )+
		int _cnt168=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 603 "vc.g"
				fb->Add_Exported_Input(internal_id);
#line 2598 "vcParser.cpp"
			}
			else {
				if ( _cnt168>=1 ) { goto _loop168; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt168++;
		}
		_loop168:;
		}  // ( ... )+
		match(RPAREN);
		}
		{
		match(LPAREN);
		{ // ( ... )+
		int _cnt171=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 604 "vc.g"
				fb->Add_Exported_Output(internal_id);
#line 2619 "vcParser.cpp"
			}
			else {
				if ( _cnt171>=1 ) { goto _loop171; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt171++;
		}
		_loop171:;
		}  // ( ... )+
		match(RPAREN);
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
}

void vcParser::vc_CPLoopTerminate(
	vcCPSimpleLoopBlock* slb
) {
#line 430 "vc.g"
	
		string loop_exit, loop_taken, loop_body, loop_back, exit_place;
	
#line 2645 "vcParser.cpp"
	
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
#line 442 "vc.g"
		slb->Set_Loop_Termination_Information(loop_exit, loop_taken, loop_body, loop_back, exit_place);
#line 2660 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_CPPhiSequencer(
	vcCPPipelinedLoopBody* slb
) {
#line 450 "vc.g"
	
	vector<string> selects;
	vector<string> enables;
	vector<string> reqs;
	string lbl;
	string enable;
	string ack;
	string done;
	string tmp_string;
	
#line 2682 "vcParser.cpp"
	
	try {      // for error handling
		match(PHISEQUENCER);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt112=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 462 "vc.g"
				selects.push_back(tmp_string);
#line 2695 "vcParser.cpp"
			}
			else {
				if ( _cnt112>=1 ) { goto _loop112; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt112++;
		}
		_loop112:;
		}  // ( ... )+
		match(COLON);
		{ // ( ... )+
		int _cnt114=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 464 "vc.g"
				enables.push_back(tmp_string);
#line 2713 "vcParser.cpp"
			}
			else {
				if ( _cnt114>=1 ) { goto _loop114; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt114++;
		}
		_loop114:;
		}  // ( ... )+
		match(COLON);
		ack=vc_Identifier();
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt116=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 469 "vc.g"
				reqs.push_back(tmp_string);
#line 2734 "vcParser.cpp"
			}
			else {
				if ( _cnt116>=1 ) { goto _loop116; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt116++;
		}
		_loop116:;
		}  // ( ... )+
		match(COLON);
		done=vc_Identifier();
		match(RPAREN);
#line 473 "vc.g"
		slb->Add_Phi_Sequencer(lbl, selects, enables, ack, reqs, done);
#line 2749 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_CPTransitionMerge(
	vcCPPipelinedLoopBody* slb
) {
#line 483 "vc.g"
	
	string tm_id;
	vector<string> in_transitions;
	string out_transition;
	string tmp_string;
	
#line 2767 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITIONMERGE);
		tm_id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt119=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 491 "vc.g"
				in_transitions.push_back(tmp_string);
#line 2780 "vcParser.cpp"
			}
			else {
				if ( _cnt119>=1 ) { goto _loop119; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt119++;
		}
		_loop119:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		out_transition=vc_Identifier();
		match(RPAREN);
#line 496 "vc.g"
		slb->Add_Transition_Merge(tm_id, in_transitions, out_transition);
#line 2796 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_CPFork(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  fe = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  n = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 651 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 2815 "vcParser.cpp"
	
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
#line 658 "vc.g"
			lbl = fe->getText();
#line 2834 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			match(N_ULL);
#line 658 "vc.g"
			lbl = "$null";
#line 2844 "vcParser.cpp"
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
#line 659 "vc.g"
			fork_ids.push_back(e->getText());
#line 2864 "vcParser.cpp"
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
#line 660 "vc.g"
			fork_ids.push_back(n->getText());
#line 2887 "vcParser.cpp"
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
#line 661 "vc.g"
				fork_ids.push_back(b);
#line 2907 "vcParser.cpp"
			}
			else {
				goto _loop197;
			}
			
		}
		_loop197:;
		} // ( ... )*
		match(RPAREN);
#line 662 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 2919 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_CPJoin(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  jen = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  jnull = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 611 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 2939 "vcParser.cpp"
	
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
#line 618 "vc.g"
			lbl = je->getText();
#line 2958 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			jen = LT(1);
			match(ENTRY);
#line 619 "vc.g"
			lbl = jen->getText();
#line 2969 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			jnull = LT(1);
			match(N_ULL);
#line 620 "vc.g"
			lbl = jnull->getText();
#line 2980 "vcParser.cpp"
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
#line 621 "vc.g"
			join_ids.push_back(e->getText());
#line 3000 "vcParser.cpp"
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
#line 622 "vc.g"
				join_ids.push_back(b);
#line 3020 "vcParser.cpp"
			}
			else {
				goto _loop180;
			}
			
		}
		_loop180:;
		} // ( ... )*
		match(RPAREN);
#line 623 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 3032 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_CPMarkedJoin(
	vcCPPipelinedForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  jnull = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  me = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  be = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 629 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
		vector<int>  join_markings;
	//
	// TODO: join markings need to be established here..
	//
	
#line 3057 "vcParser.cpp"
	
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
#line 640 "vc.g"
			lbl = je->getText();
#line 3076 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			jnull = LT(1);
			match(N_ULL);
#line 641 "vc.g"
			lbl = jnull->getText();
#line 3087 "vcParser.cpp"
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
#line 642 "vc.g"
			join_ids.push_back(e->getText());
#line 3107 "vcParser.cpp"
			me = LT(1);
			match(UINTEGER);
#line 643 "vc.g"
			join_markings.push_back(atoi(me->getText().c_str()));
#line 3112 "vcParser.cpp"
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
#line 644 "vc.g"
				join_ids.push_back(b);
#line 3132 "vcParser.cpp"
				be = LT(1);
				match(UINTEGER);
#line 644 "vc.g"
				join_markings.push_back(atoi(be->getText().c_str()));
#line 3137 "vcParser.cpp"
			}
			else {
				goto _loop188;
			}
			
		}
		_loop188:;
		} // ( ... )*
		match(RPAREN);
#line 645 "vc.g"
		fb->Add_Marked_Join_Point(lbl,join_ids, join_markings);
#line 3149 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_Guarded_Operator_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  gid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 687 "vc.g"
	
		vcWire* guard_wire = NULL;
		bool guard_complement = false;
		string gwid;
		vcDatapathElement* dpe = NULL;
	
#line 3168 "vcParser.cpp"
	
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
		case HASH:
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
#line 698 "vc.g"
				guard_complement = true;
#line 3252 "vcParser.cpp"
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
#line 698 "vc.g"
			guard_wire = dp->Find_Wire(gwid); NOT_FOUND__("wire",guard_wire, gwid,gid)
#line 3268 "vcParser.cpp"
			match(RPAREN);
			break;
		}
		case RBRACE:
		case BUFFERING:
		case DIV_OP:
		case DELAY:
		case ULE_OP:
		case NOT_OP:
		case FLOWTHROUGH:
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
		case HASH:
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
#line 700 "vc.g"
		
				if((dpe != NULL) && (guard_wire != NULL))
				{
					dpe->Set_Guard_Wire(guard_wire);
					dpe->Set_Guard_Complement(guard_complement);
				}
			
#line 3342 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case FLOWTHROUGH:
		{
			match(FLOWTHROUGH);
#line 707 "vc.g"
			dpe->Set_Flow_Through(true);
#line 3350 "vcParser.cpp"
			break;
		}
		case RBRACE:
		case BUFFERING:
		case DIV_OP:
		case DELAY:
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
		case HASH:
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
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

void vcParser::vc_Branch_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  br_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 838 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vector<vcWire*> wires;
	vcWire* x;
	
#line 3433 "vcParser.cpp"
	
	try {      // for error handling
		br_id = LT(1);
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt248=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 849 "vc.g"
				x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,br_id)
				wires.push_back(x);
#line 3448 "vcParser.cpp"
			}
			else {
				if ( _cnt248>=1 ) { goto _loop248; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt248++;
		}
		_loop248:;
		}  // ( ... )+
		match(RPAREN);
#line 852 "vc.g"
		new_op = new vcBranch(id,wires); dp->Add_Branch(new_op);
#line 3461 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

void vcParser::vc_Phi_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  p_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1163 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 3482 "vcParser.cpp"
	
	try {      // for error handling
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt274=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1172 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 3498 "vcParser.cpp"
			}
			else {
				if ( _cnt274>=1 ) { goto _loop274; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt274++;
		}
		_loop274:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 1177 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
			 phi = new vcPhi(lbl,inwires, outwire); 
		
		dp->Add_Phi(phi);
		
#line 3519 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

void vcParser::vc_PhiPipelined_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  p_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1190 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhiPipelined* phi;
	vector<vcWire*> inwires;
	
#line 3541 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt277=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1199 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 3558 "vcParser.cpp"
			}
			else {
				if ( _cnt277>=1 ) { goto _loop277; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt277++;
		}
		_loop277:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 1204 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
		phi = new vcPhiPipelined(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 3578 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

void vcParser::vc_ModuleBufferingSpec(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpe_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  wire_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1488 "vc.g"
	
		string dpe_name;
		string wire_name;
		int buffering;
		bool input_flag = true;
	
#line 3600 "vcParser.cpp"
	
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
#line 1496 "vc.g"
			input_flag = false;
#line 3617 "vcParser.cpp"
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
#line 1497 "vc.g"
		dpe_name = dpe_id->getText();
#line 3631 "vcParser.cpp"
		wire_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1498 "vc.g"
		wire_name = wire_id->getText();
#line 3636 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1499 "vc.g"
		buffering = atoi(bid->getText().c_str());
#line 3641 "vcParser.cpp"
#line 1500 "vc.g"
		
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
				
#line 3660 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

void vcParser::vc_ModuleDelaySpec(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpe_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1522 "vc.g"
	
		string dpe_name;
		int delay = 1;
	
#line 3678 "vcParser.cpp"
	
	try {      // for error handling
		match(DELAY);
		dpe_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1528 "vc.g"
		dpe_name = dpe_id->getText();
#line 3686 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1529 "vc.g"
		delay = atoi(bid->getText().c_str());
#line 3691 "vcParser.cpp"
#line 1530 "vc.g"
		
						vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
						NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
						if(dpe != NULL)
						{
							dpe->Set_Delay(delay);
						}
				
#line 3701 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

vcDatapathElement*  vcParser::vc_Operator_Instantiation(
	vcDataPath* dp
) {
#line 714 "vc.g"
	vcDatapathElement* dpe;
#line 3714 "vcParser.cpp"
	
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
		case HASH:
		{
			dpe=vc_InterlockBuffer_Instantiation(dp);
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
		recover(ex,_tokenSet_30);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Call_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 1011 "vc.g"
	vcDatapathElement* dpe;
#line 3805 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1011 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 3819 "vcParser.cpp"
	
	try {      // for error handling
		cid = LT(1);
		match(CALL);
		{
		switch ( LA(1)) {
		case INLINE:
		{
			match(INLINE);
#line 1022 "vc.g"
			inline_flag = true;
#line 3831 "vcParser.cpp"
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
#line 1023 "vc.g"
		m = sys->Find_Module(mid); NOT_FOUND__("module",m,mid,cid)
#line 3849 "vcParser.cpp"
		lpid1 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 1024 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid1)
				inwires.push_back(w);
#line 3860 "vcParser.cpp"
			}
			else {
				goto _loop261;
			}
			
		}
		_loop261:;
		} // ( ... )*
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 1027 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid2)
				outwires.push_back(w);
#line 3880 "vcParser.cpp"
			}
			else {
				goto _loop263;
			}
			
		}
		_loop263:;
		} // ( ... )*
		match(RPAREN);
#line 1030 "vc.g"
		
			 nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc); 
			 dpe = (vcDatapathElement*) nc;
			
#line 3895 "vcParser.cpp"
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
#line 1039 "vc.g"
	vcDatapathElement* dpe;
#line 3909 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ipid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1039 "vc.g"
	
	string id, in_id, out_id, pipe_id;
	vcWire* w;
	vcPipe* p = NULL;
	bool in_flag = false;
	
#line 3919 "vcParser.cpp"
	
	try {      // for error handling
		ipid = LT(1);
		match(IOPORT);
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 1046 "vc.g"
			in_flag = true;
#line 3932 "vcParser.cpp"
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
#line 1048 "vc.g"
		
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
			
		
#line 3993 "vcParser.cpp"
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
#line 1090 "vc.g"
	vcDatapathElement* dpe;
#line 4007 "vcParser.cpp"
	
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
#line 729 "vc.g"
	vcDatapathElement* dpe;
#line 4039 "vcParser.cpp"
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
#line 729 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4078 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 741 "vc.g"
			op_id = plus_id->getText();
#line 4090 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 742 "vc.g"
			op_id = minus_id->getText();
#line 4101 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 743 "vc.g"
			op_id = mul_id->getText();
#line 4112 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 744 "vc.g"
			op_id = div_id->getText();
#line 4123 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 745 "vc.g"
			op_id = shl_id->getText();
#line 4134 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 746 "vc.g"
			op_id = shr_id->getText();
#line 4145 "vcParser.cpp"
			}
			break;
		}
		case UGT_OP:
		{
			{
			gt_id = LT(1);
			match(UGT_OP);
#line 747 "vc.g"
			op_id = gt_id->getText();
#line 4156 "vcParser.cpp"
			}
			break;
		}
		case UGE_OP:
		{
			{
			ge_id = LT(1);
			match(UGE_OP);
#line 748 "vc.g"
			op_id = ge_id->getText();
#line 4167 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 749 "vc.g"
			op_id = eq_id->getText();
#line 4178 "vcParser.cpp"
			}
			break;
		}
		case ULT_OP:
		{
			{
			lt_id = LT(1);
			match(ULT_OP);
#line 750 "vc.g"
			op_id = lt_id->getText();
#line 4189 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			le_id = LT(1);
			match(ULE_OP);
#line 751 "vc.g"
			op_id = le_id->getText();
#line 4200 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 752 "vc.g"
			op_id = neq_id->getText();
#line 4211 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 753 "vc.g"
			op_id = bitsel_id->getText();
#line 4222 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 754 "vc.g"
			op_id = concat_id->getText();
#line 4233 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 755 "vc.g"
			op_id = or_id->getText();
#line 4244 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 756 "vc.g"
			op_id = and_id->getText();
#line 4255 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 757 "vc.g"
			op_id = xor_id->getText();
#line 4266 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 758 "vc.g"
			op_id = nor_id->getText();
#line 4277 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 759 "vc.g"
			op_id = nand_id->getText();
#line 4288 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 760 "vc.g"
			op_id = xnor_id->getText();
#line 4299 "vcParser.cpp"
			}
			break;
		}
		case SHRA_OP:
		{
			{
			shra_id = LT(1);
			match(SHRA_OP);
#line 761 "vc.g"
			op_id = shra_id->getText();
#line 4310 "vcParser.cpp"
			}
			break;
		}
		case SGT_OP:
		{
			{
			sgt_id = LT(1);
			match(SGT_OP);
#line 762 "vc.g"
			op_id = sgt_id->getText();
#line 4321 "vcParser.cpp"
			}
			break;
		}
		case SGE_OP:
		{
			{
			sge_id = LT(1);
			match(SGE_OP);
#line 763 "vc.g"
			op_id = sge_id->getText();
#line 4332 "vcParser.cpp"
			}
			break;
		}
		case SLT_OP:
		{
			{
			slt_id = LT(1);
			match(SLT_OP);
#line 764 "vc.g"
			op_id = slt_id->getText();
#line 4343 "vcParser.cpp"
			}
			break;
		}
		case SLE_OP:
		{
			{
			sle_id = LT(1);
			match(SLE_OP);
#line 765 "vc.g"
			op_id = sle_id->getText();
#line 4354 "vcParser.cpp"
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
#line 768 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4373 "vcParser.cpp"
		wid=vc_Identifier();
#line 773 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 4381 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 781 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4391 "vcParser.cpp"
		match(RPAREN);
#line 786 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op); 
			dpe = (vcDatapathElement*)new_op;
#line 4396 "vcParser.cpp"
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
#line 794 "vc.g"
	vcDatapathElement* dpe;
#line 4410 "vcParser.cpp"
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
#line 794 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 4431 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 806 "vc.g"
			op_id = not_id->getText();
#line 4443 "vcParser.cpp"
			}
			break;
		}
		case StoS_ASSIGN_OP:
		{
			{
			ss_assign_id = LT(1);
			match(StoS_ASSIGN_OP);
#line 807 "vc.g"
			op_id = ss_assign_id->getText();
#line 4454 "vcParser.cpp"
			}
			break;
		}
		case StoU_ASSIGN_OP:
		{
			{
			su_assign_id = LT(1);
			match(StoU_ASSIGN_OP);
#line 808 "vc.g"
			op_id = su_assign_id->getText();
#line 4465 "vcParser.cpp"
			}
			break;
		}
		case UtoS_ASSIGN_OP:
		{
			{
			us_assign_id = LT(1);
			match(UtoS_ASSIGN_OP);
#line 809 "vc.g"
			op_id = us_assign_id->getText();
#line 4476 "vcParser.cpp"
			}
			break;
		}
		case FtoS_ASSIGN_OP:
		{
			{
			fs_assign_id = LT(1);
			match(FtoS_ASSIGN_OP);
#line 810 "vc.g"
			op_id = fs_assign_id->getText();
#line 4487 "vcParser.cpp"
			}
			break;
		}
		case FtoU_ASSIGN_OP:
		{
			{
			fu_assign_id = LT(1);
			match(FtoU_ASSIGN_OP);
#line 811 "vc.g"
			op_id = fu_assign_id->getText();
#line 4498 "vcParser.cpp"
			}
			break;
		}
		case StoF_ASSIGN_OP:
		{
			{
			sf_assign_id = LT(1);
			match(StoF_ASSIGN_OP);
#line 812 "vc.g"
			op_id = sf_assign_id->getText();
#line 4509 "vcParser.cpp"
			}
			break;
		}
		case UtoF_ASSIGN_OP:
		{
			{
			uf_assign_id = LT(1);
			match(UtoF_ASSIGN_OP);
#line 813 "vc.g"
			op_id = uf_assign_id->getText();
#line 4520 "vcParser.cpp"
			}
			break;
		}
		case FtoF_ASSIGN_OP:
		{
			{
			ff_assign_id = LT(1);
			match(FtoF_ASSIGN_OP);
#line 814 "vc.g"
			op_id = ff_assign_id->getText();
#line 4531 "vcParser.cpp"
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
#line 817 "vc.g"
		
		x = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4550 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 824 "vc.g"
		
		z = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4560 "vcParser.cpp"
		match(RPAREN);
#line 829 "vc.g"
		
			new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
			dpe = (vcDatapathElement*) new_op;
		
#line 4567 "vcParser.cpp"
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
#line 859 "vc.g"
	vcDatapathElement* dpe;
#line 4581 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 859 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4595 "vcParser.cpp"
	
	try {      // for error handling
		sel_id = LT(1);
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 874 "vc.g"
		sel = dp->Find_Wire(wid); NOT_FOUND__("wire",sel,wid,sel_id)
#line 4605 "vcParser.cpp"
		wid=vc_Identifier();
#line 875 "vc.g"
		x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,sel_id)
#line 4609 "vcParser.cpp"
		wid=vc_Identifier();
#line 876 "vc.g"
		y = dp->Find_Wire(wid); NOT_FOUND__("wire",y,wid,sel_id)
#line 4613 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 879 "vc.g"
		z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id)
#line 4619 "vcParser.cpp"
		match(RPAREN);
#line 881 "vc.g"
		
			new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);   
			dpe = (vcDatapathElement*) new_op;
		
#line 4626 "vcParser.cpp"
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
#line 891 "vc.g"
	vcDatapathElement* dpe;
#line 4640 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  slice_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 891 "vc.g"
	
	vcSlice* new_op = NULL;
	string id;
	string wid;
	int h, l;
	vcWire* sel = NULL;
	vcWire* din = NULL;
	vcWire* dout = NULL;
	
#line 4654 "vcParser.cpp"
	
	try {      // for error handling
		slice_id = LT(1);
		match(SLICE_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 904 "vc.g"
		din = dp->Find_Wire(wid); NOT_FOUND__("wire",din,wid,slice_id)
#line 4664 "vcParser.cpp"
		hid = LT(1);
		match(UINTEGER);
#line 905 "vc.g"
		h = atoi(hid->getText().c_str());
#line 4669 "vcParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 906 "vc.g"
		l = atoi(lid->getText().c_str());
#line 4674 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 909 "vc.g"
		dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id)
#line 4680 "vcParser.cpp"
		match(RPAREN);
#line 911 "vc.g"
		
			new_op = new vcSlice(id,din,dout,h,l); dp->Add_Slice(new_op);    
			dpe = (vcDatapathElement*) new_op;
		
#line 4687 "vcParser.cpp"
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
#line 922 "vc.g"
	vcDatapathElement* dpe;
#line 4701 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 922 "vc.g"
	
	vcRegister* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 4712 "vcParser.cpp"
	
	try {      // for error handling
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 930 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 4723 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 933 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 4730 "vcParser.cpp"
		match(RPAREN);
#line 936 "vc.g"
		
		new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
			dpe = (vcDatapathElement*) new_reg;
		
#line 4737 "vcParser.cpp"
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
#line 972 "vc.g"
	vcDatapathElement* dpe;
#line 4751 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 972 "vc.g"
	
	string id;
	vcEquivalence* nm = NULL;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	vcWire* w;
	string wid;
	
#line 4762 "vcParser.cpp"
	
	try {      // for error handling
		eq_id = LT(1);
		match(EQUIVALENCE_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt255=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 984 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				inwires.push_back(w);
				
#line 4780 "vcParser.cpp"
			}
			else {
				if ( _cnt255>=1 ) { goto _loop255; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt255++;
		}
		_loop255:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt257=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 992 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				outwires.push_back(w);
				
#line 4803 "vcParser.cpp"
			}
			else {
				if ( _cnt257>=1 ) { goto _loop257; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt257++;
		}
		_loop257:;
		}  // ( ... )+
		match(RPAREN);
#line 998 "vc.g"
		
		nm = new vcEquivalence(id,inwires,outwires);
		dp->Add_Equivalence(nm);
			    dpe = (vcDatapathElement*) nm;
		
#line 4820 "vcParser.cpp"
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
#line 946 "vc.g"
	vcDatapathElement* dpe;
#line 4834 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 946 "vc.g"
	
	vcInterlockBuffer* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 4845 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 954 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 4857 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 957 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 4864 "vcParser.cpp"
		match(RPAREN);
#line 960 "vc.g"
		
		new_reg = new vcInterlockBuffer(id, x, y); 
		dp->Add_Interlock_Buffer(new_reg);
		dpe = (vcDatapathElement*) new_reg;
		
#line 4872 "vcParser.cpp"
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
#line 1099 "vc.g"
	vcDatapathElement* dpe;
#line 4886 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ldid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1099 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
	
#line 4899 "vcParser.cpp"
	
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
#line 1111 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),ldid)
		
#line 4924 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 1115 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,ldid);
		
#line 4931 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 1118 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",data,wid,ldid);
		
#line 4939 "vcParser.cpp"
		match(RPAREN);
#line 1121 "vc.g"
		
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
			 dpe = (vcDatapathElement*) nl;
		
#line 4947 "vcParser.cpp"
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
#line 1132 "vc.g"
	vcDatapathElement* dpe;
#line 4961 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  st_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1132 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 4973 "vcParser.cpp"
	
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
#line 1143 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),st_id)
		
#line 4998 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 1147 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,st_id);
		
#line 5005 "vcParser.cpp"
		wid=vc_Identifier();
#line 1150 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("data",addr,wid,st_id);              
		
#line 5011 "vcParser.cpp"
		match(RPAREN);
#line 1153 "vc.g"
		
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
			 dpe=(vcDatapathElement*)  ns;
		
#line 5019 "vcParser.cpp"
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
#line 1245 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 5038 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1251 "vc.g"
		obj_name = id->getText();
#line 5045 "vcParser.cpp"
		match(COLON);
		t=vc_Type(sys);
#line 1252 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 5052 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
#line 1260 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	string oname;
	
#line 5069 "vcParser.cpp"
	
	try {      // for error handling
		oname=vc_Label();
#line 1266 "vc.g"
		obj_name = oname;
#line 5075 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 1266 "vc.g"
		*t = tt;
#line 5080 "vcParser.cpp"
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
#line 1267 "vc.g"
		if(v != NULL) *v = vv;
#line 5095 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 1321 "vc.g"
	vcValue* v;
#line 5108 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1321 "vc.g"
	
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
	
#line 5133 "vcParser.cpp"
	
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
#line 1344 "vc.g"
				vstring = bid->getText(); format = "binary";
#line 5150 "vcParser.cpp"
				}
				break;
			}
			case HEXSTRING:
			{
				{
				hid = LT(1);
				match(HEXSTRING);
#line 1345 "vc.g"
				vstring = hid->getText(); format = "hexadecimal";
#line 5161 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 1347 "vc.g"
			
				if(t->Is("vcIntType") || t->Is("vcPointerType"))
				   v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
			else if(t->Is("vcFloatType"))
				   v = (vcValue*) (new vcFloatValue((vcFloatType*)t,vstring.substr(2),format));
			
#line 5178 "vcParser.cpp"
			}
			break;
		}
		case LPAREN:
		{
			{
			sid = LT(1);
			match(LPAREN);
			ev=vc_Value(etypes[idx]);
#line 1356 "vc.g"
			evalues.push_back(ev);
#line 5190 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 1357 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 5197 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 1357 "vc.g"
					evalues.push_back(ev);
#line 5201 "vcParser.cpp"
				}
				else {
					goto _loop300;
				}
				
			}
			_loop300:;
			} // ( ... )*
#line 1359 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 5219 "vcParser.cpp"
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
#line 1381 "vc.g"
	vcType* t;
#line 5242 "vcParser.cpp"
	
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
#line 1423 "vc.g"
	vcType* t;
#line 5285 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1423 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 5293 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 1428 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 5302 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 1429 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 5308 "vcParser.cpp"
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
#line 1435 "vc.g"
	vcType* t;
#line 5322 "vcParser.cpp"
#line 1435 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 5329 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		{ // ( ... )+
		int _cnt318=0;
		for (;;) {
			if ((LA(1) == ULT_OP) && (_tokenSet_33.member(LA(2)))) {
				match(ULT_OP);
				{
				et=vc_Type(sys);
#line 1440 "vc.g"
				etypes.push_back(et);
#line 5342 "vcParser.cpp"
				}
				match(UGT_OP);
			}
			else {
				if ( _cnt318>=1 ) { goto _loop318; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt318++;
		}
		_loop318:;
		}  // ( ... )+
#line 1441 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 5356 "vcParser.cpp"
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
#line 1387 "vc.g"
	vcType* t;
#line 5370 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1387 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 5377 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(ULT_OP);
		i = LT(1);
		match(UINTEGER);
#line 1392 "vc.g"
		w = atoi(i->getText().c_str());
#line 5386 "vcParser.cpp"
		match(UGT_OP);
#line 1392 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 5390 "vcParser.cpp"
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
#line 1398 "vc.g"
	vcType* t;
#line 5404 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1398 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 5412 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(ULT_OP);
		cid = LT(1);
		match(UINTEGER);
#line 1403 "vc.g"
		c = atoi(cid->getText().c_str());
#line 5421 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 1403 "vc.g"
		m = atoi(mid->getText().c_str());
#line 5427 "vcParser.cpp"
		match(UGT_OP);
#line 1404 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 5431 "vcParser.cpp"
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
#line 1411 "vc.g"
	vcType* t;
#line 5445 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1411 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 5453 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(ULT_OP);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(DIV_OP);
#line 1416 "vc.g"
			scope_id = sid->getText();
#line 5465 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == UGT_OP)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1417 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 5478 "vcParser.cpp"
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
	"PIPELINE",
	"BUFFERING",
	"FULLRATE",
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
	"LEFT_OPEN",
	"TRANSITION",
	"DEAD",
	"TIED_HIGH",
	"DELAY",
	"SERIESBLOCK",
	"PARALLELBLOCK",
	"BRANCHBLOCK",
	"LOOPBLOCK",
	"TERMINATE",
	"PHISEQUENCER",
	"TRANSITIONMERGE",
	"BIND",
	"IMPLIES",
	"ULE_OP",
	"MERGE",
	"BRANCH",
	"FORKBLOCK",
	"PIPELINEDFORKBLOCK",
	"N_ULL",
	"JOIN",
	"MARKEDJOIN",
	"FORK",
	"DATAPATH",
	"GUARD",
	"NOT_OP",
	"FLOWTHROUGH",
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
	"HASH",
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
	"ALPHA",
	"DIGIT",
	0
};

const unsigned long vcParser::_tokenSet_0_data_[] = { 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_0(_tokenSet_0_data_,6);
const unsigned long vcParser::_tokenSet_1_data_[] = { 6029618UL, 0UL, 0UL, 67166208UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE FOREIGN PIPELINE BUFFERING MODULE CONSTANT 
// INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,8);
const unsigned long vcParser::_tokenSet_2_data_[] = { 2161903922UL, 16777216UL, 0UL, 67166208UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN PIPELINE BUFFERING MODULE SIMPLE_IDENTIFIER 
// CONTROLPATH DATAPATH CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 274467122UL, 4093673504UL, 4294967295UL, 67167563UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN PIPELINE BUFFERING MODULE DIV_OP 
// DELAY ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP 
// EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 1657408704UL, 1326079UL, 0UL, 67109504UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER DEPTH LBRACE RBRACE COLON PIPELINE MODULE SIMPLE_IDENTIFIER 
// LPAREN ENTRY EXIT PLACE LEFT_OPEN TRANSITION DEAD TIED_HIGH DELAY SERIESBLOCK 
// PARALLELBLOCK BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE BIND 
// FORKBLOCK N_ULL FROM TO ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,8);
const unsigned long vcParser::_tokenSet_5_data_[] = { 67584UL, 0UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,8);
const unsigned long vcParser::_tokenSet_6_data_[] = { 1888487424UL, 4094991333UL, 4294967295UL, 67167563UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE BUFFERING SIMPLE_IDENTIFIER DIV_OP ENTRY EXIT PLACE TRANSITION 
// DELAY SERIESBLOCK PARALLELBLOCK BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE 
// ULE_OP FORKBLOCK N_ULL NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP 
// UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP 
// NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP 
// StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP 
// UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP 
// HASH EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,8);
const unsigned long vcParser::_tokenSet_7_data_[] = { 2430404914UL, 4110450720UL, 4294967295UL, 67167595UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE OBJECT FOREIGN PIPELINE BUFFERING MODULE 
// SIMPLE_IDENTIFIER DIV_OP CONTROLPATH DELAY ULE_OP DATAPATH NOT_OP PLUS_OP 
// MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP 
// CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP 
// SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP CALL IOPORT OUT LOAD 
// STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,8);
const unsigned long vcParser::_tokenSet_8_data_[] = { 2155874608UL, 16777216UL, 0UL, 67108896UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// OUT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,8);
const unsigned long vcParser::_tokenSet_9_data_[] = { 2155874608UL, 16777216UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,8);
const unsigned long vcParser::_tokenSet_10_data_[] = { 0UL, 262592UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,6);
const unsigned long vcParser::_tokenSet_11_data_[] = { 8390656UL, 16777216UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 268435456UL, 4093673472UL, 4160749567UL, 331UL, 0UL, 0UL, 0UL, 0UL };
// DIV_OP ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP 
// EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP CALL 
// IOPORT LOAD STORE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 0UL, 0UL, 1073741824UL, 2100UL, 0UL, 0UL, 0UL, 0UL };
// ASSIGN_OP INLINE IN OUT LBRACKET 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,8);
const unsigned long vcParser::_tokenSet_14_data_[] = { 8390656UL, 0UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,8);
const unsigned long vcParser::_tokenSet_15_data_[] = { 1820327936UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RPAREN OPEN ENTRY EXIT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,6);
const unsigned long vcParser::_tokenSet_16_data_[] = { 2122451008UL, 14935040UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER RBRACE COLON SIMPLE_IDENTIFIER LPAREN RPAREN OPEN DIV_OP ENTRY 
// EXIT TERMINATE BIND IMPLIES ULE_OP MERGE BRANCH JOIN MARKEDJOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,6);
const unsigned long vcParser::_tokenSet_17_data_[] = { 1619001344UL, 1048576UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER ENTRY EXIT N_ULL 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,6);
const unsigned long vcParser::_tokenSet_18_data_[] = { 0UL, 1UL, 0UL, 0UL, 0UL, 0UL };
// PLACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,6);
const unsigned long vcParser::_tokenSet_19_data_[] = { 8914944UL, 271301UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PIPELINE SIMPLE_IDENTIFIER PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK BIND FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,8);
const unsigned long vcParser::_tokenSet_20_data_[] = { 2048UL, 9216UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE TERMINATE BIND 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,6);
const unsigned long vcParser::_tokenSet_21_data_[] = { 1619003392UL, 1317829UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,8);
const unsigned long vcParser::_tokenSet_22_data_[] = { 2048UL, 262597UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 1619003392UL, 1317317UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,8);
const unsigned long vcParser::_tokenSet_24_data_[] = { 8390656UL, 271297UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// LOOPBLOCK BIND FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,8);
const unsigned long vcParser::_tokenSet_25_data_[] = { 8390656UL, 263105UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// LOOPBLOCK FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,8);
const unsigned long vcParser::_tokenSet_26_data_[] = { 0UL, 64UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,6);
const unsigned long vcParser::_tokenSet_27_data_[] = { 2048UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,6);
const unsigned long vcParser::_tokenSet_28_data_[] = { 1619003392UL, 1317316UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,8);
const unsigned long vcParser::_tokenSet_29_data_[] = { 269486080UL, 4093673504UL, 4294967295UL, 67167563UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE BUFFERING DIV_OP DELAY ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP 
// SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP 
// SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP 
// StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP 
// ASSIGN_OP HASH EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_29(_tokenSet_29_data_,8);
const unsigned long vcParser::_tokenSet_30_data_[] = { 269486080UL, 4261445664UL, 4294967295UL, 67167563UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE BUFFERING DIV_OP DELAY ULE_OP GUARD NOT_OP FLOWTHROUGH PLUS_OP 
// MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP 
// CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP 
// SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP CALL IOPORT LOAD STORE 
// PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_30(_tokenSet_30_data_,8);
const unsigned long vcParser::_tokenSet_31_data_[] = { 15731618UL, 0UL, 1073741824UL, 100699188UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE DEPTH MEMORYSPACE UNORDERED RBRACE BUFFERING FULLRATE MODULE 
// SIMPLE_IDENTIFIER ASSIGN_OP INLINE IN OUT PHI LBRACKET WIRE SIMPLE_IDENTIFER 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_31(_tokenSet_31_data_,8);
const unsigned long vcParser::_tokenSet_32_data_[] = { 341575986UL, 4093673504UL, 4294967295UL, 67429707UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN PIPELINE BUFFERING MODULE RPAREN 
// DIV_OP DELAY ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP 
// UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP 
// NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_32(_tokenSet_32_data_,8);
const unsigned long vcParser::_tokenSet_33_data_[] = { 0UL, 0UL, 0UL, 24641536UL, 0UL, 0UL, 0UL, 0UL };
// INT FLOAT POINTER ARRAY RECORD 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_33(_tokenSet_33_data_,8);


