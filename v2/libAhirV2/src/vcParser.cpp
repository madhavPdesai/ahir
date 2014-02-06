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
#line 138 "vc.g"
	vcModule* m;
#line 123 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 138 "vc.g"
	
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
#line 149 "vc.g"
			foreign_flag = true;
#line 148 "vcParser.cpp"
			}
			break;
		}
		case PIPELINE:
		{
			{
			match(PIPELINE);
#line 150 "vc.g"
			pipeline_flag = true;
#line 158 "vcParser.cpp"
			{
			switch ( LA(1)) {
			case DEPTH:
			{
				match(DEPTH);
				did = LT(1);
				match(UINTEGER);
#line 151 "vc.g"
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
#line 152 "vc.g"
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
#line 153 "vc.g"
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
#line 156 "vc.g"
		
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
		case OUT:
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
#line 168 "vc.g"
				m->Add_Memory_Space(ms);
#line 310 "vcParser.cpp"
			}
			else {
				goto _loop34;
			}
			
		}
		_loop34:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LIFO || LA(1) == PIPE)) {
				vc_Pipe(NULL,m);
			}
			else {
				goto _loop36;
			}
			
		}
		_loop36:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case CONTROLPATH:
		{
			vc_Controlpath(sys,m);
#line 170 "vc.g"
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
#line 171 "vc.g"
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
#line 172 "vc.g"
				assert(!foreign_flag);
#line 382 "vcParser.cpp"
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
				vc_AttributeSpec(m);
			}
			else {
				goto _loop42;
			}
			
		}
		_loop42:;
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
#line 92 "vc.g"
	vcMemorySpace* ms;
#line 417 "vcParser.cpp"
#line 92 "vc.g"
	
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
#line 98 "vc.g"
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
#line 100 "vc.g"
		
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
				goto _loop19;
			}
			
		}
		_loop19:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(ms);
			}
			else {
				goto _loop21;
			}
			
		}
		_loop21:;
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
	bool in_flag = false;
	bool out_flag = false;
	bool port_flag = false;
	bool signal_flag = false;
	
#line 505 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case LIFO:
		{
			match(LIFO);
#line 76 "vc.g"
			lifo_mode = true;
#line 515 "vcParser.cpp"
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
#line 76 "vc.g"
			depth = atoi(did->getText().c_str());
#line 541 "vcParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case LIFO:
		case PIPE:
		case IN:
		case OUT:
		case PORT:
		case SIGNAL:
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
		{
		switch ( LA(1)) {
		case IN:
		{
			match(IN);
#line 77 "vc.g"
			in_flag = true;
#line 580 "vcParser.cpp"
			break;
		}
		case OUT:
		{
			match(OUT);
#line 77 "vc.g"
			out_flag = true;
#line 588 "vcParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case LIFO:
		case PIPE:
		case PORT:
		case SIGNAL:
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
		{
		switch ( LA(1)) {
		case PORT:
		{
			match(PORT);
#line 78 "vc.g"
			port_flag = true;
#line 625 "vcParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case LIFO:
		case PIPE:
		case SIGNAL:
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
		{
		switch ( LA(1)) {
		case SIGNAL:
		{
			match(SIGNAL);
#line 79 "vc.g"
			signal_flag = true;
#line 661 "vcParser.cpp"
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
#line 80 "vc.g"
		
		if (sys) 
		sys->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode, port_flag, in_flag, out_flag, signal_flag);
		else if(m)
		m->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode, port_flag, in_flag, out_flag, signal_flag);
		
#line 696 "vcParser.cpp"
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
#line 1282 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	bool intermediate_flag = false;
	
#line 718 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			{
			cid = LT(1);
			match(CONSTANT);
#line 1291 "vc.g"
			const_flag = true;
#line 730 "vcParser.cpp"
			}
			break;
		}
		case INTERMEDIATE:
		{
			{
			iid = LT(1);
			match(INTERMEDIATE);
#line 1291 "vc.g"
			intermediate_flag = true;
#line 741 "vcParser.cpp"
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
#line 1292 "vc.g"
		
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
		
#line 789 "vcParser.cpp"
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
#line 1550 "vc.g"
	
		string key;
		string value;
		bool mem_space = false;
	bool module = false;
		vcRoot* child = NULL;
		string m_id;
		string ms_id;
	string child_id;
	
#line 814 "vcParser.cpp"
	
	try {      // for error handling
		aid = LT(1);
		match(ATTRIBUTE);
		{
		switch ( LA(1)) {
		case MEMORYSPACE:
		{
			{
			match(MEMORYSPACE);
#line 1563 "vc.g"
			mem_space = true;
#line 827 "vcParser.cpp"
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
#line 1565 "vc.g"
			
								child_id = m_id + "/" + ms_id; 
								child = sys->Find_Memory_Space(m_id,ms_id);
							
#line 846 "vcParser.cpp"
			}
			break;
		}
		case MODULE:
		{
			{
			match(MODULE);
#line 1569 "vc.g"
			module = true;
#line 856 "vcParser.cpp"
			m_id=vc_Identifier();
#line 1571 "vc.g"
			
								child_id = m_id;
								child = sys->Find_Module(m_id);
							
#line 863 "vcParser.cpp"
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
#line 1576 "vc.g"
		key = kid->getText();
#line 877 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1577 "vc.g"
		value = vid->getText();
#line 883 "vcParser.cpp"
#line 1578 "vc.g"
		
					if(child != NULL) 
						child->Add_Attribute(key,value);
					else
					{
						vcSystem::Warning("could not find " + child_id + " to add attribute,"
									+ IntToStr(aid->getLine()));
								
					}
				
#line 895 "vcParser.cpp"
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
#line 1454 "vc.g"
	
		string mod_name;
		string dpe_name;
		string wire_name;
		int buffering;
		bool input_flag = true;
	
#line 918 "vcParser.cpp"
	
	try {      // for error handling
		match(BUFFERING);
		mid = LT(1);
		match(SIMPLE_IDENTIFER);
#line 1463 "vc.g"
		mod_name = mid->getText();
#line 926 "vcParser.cpp"
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
#line 1464 "vc.g"
			input_flag = false;
#line 940 "vcParser.cpp"
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
#line 1465 "vc.g"
		dpe_name = dpe_id->getText();
#line 954 "vcParser.cpp"
		wire_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1466 "vc.g"
		wire_name = wire_id->getText();
#line 959 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1467 "vc.g"
		buffering = atoi(bid->getText().c_str());
#line 964 "vcParser.cpp"
#line 1468 "vc.g"
		
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
				
#line 988 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

string  vcParser::vc_Label() {
#line 1223 "vc.g"
	string lbl;
#line 999 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1225 "vc.g"
		lbl = id->getText();
#line 1009 "vcParser.cpp"
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
#line 112 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 1034 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 113 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 1040 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 114 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 1046 "vcParser.cpp"
		match(MAXACCESSWIDTH);
		maw = LT(1);
		match(UINTEGER);
#line 115 "vc.g"
		ms->Set_Max_Access_Width(atoi(maw->getText().c_str()));
#line 1052 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 121 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 1070 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
#line 129 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
		ms->Add_Storage_Object(nl);
		
#line 1082 "vcParser.cpp"
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
#line 1593 "vc.g"
	
		string key;
		string value;
	
#line 1100 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1599 "vc.g"
		key = kid->getText();
#line 1108 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1599 "vc.g"
		value = vid->getText();
#line 1114 "vcParser.cpp"
#line 1600 "vc.g"
		m->Add_Attribute(key,value);
#line 1117 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 1382 "vc.g"
	vcType* t;
#line 1130 "vcParser.cpp"
	
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
#line 1231 "vc.g"
	
		string mode = "in";
	
#line 1179 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
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
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Outargs(
	vcSystem* sys, vcModule* parent
) {
#line 1242 "vc.g"
	
		string mode = "out";
	
#line 1209 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop288;
			}
			
		}
		_loop288:;
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
#line 269 "vc.g"
	
	vcControlPath* cp;
	cp = new vcControlPath(m->Get_Id() + "_CP");
	vcCPElement* cpe;
	
#line 1241 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{
		switch ( LA(1)) {
		case PIPELINEDFORKBLOCK:
		{
			{
			vc_CPPipelinedForkBlock(cp,m);
#line 278 "vc.g"
				
						assert(m->Get_Pipeline_Flag());
						cp->Set_Is_Pipelined(true);
						cp->Set_Pipeline_Depth(m->Get_Pipeline_Depth());
						cp->Set_Pipeline_Buffering(m->Get_Pipeline_Buffering());
						cp->Set_Pipeline_Full_Rate_Flag(m->Get_Pipeline_Full_Rate_Flag());
					
#line 1260 "vcParser.cpp"
			{ // ( ... )+
			int _cnt61=0;
			for (;;) {
				if ((LA(1) == PLACE)) {
					cpe=vc_CPPlace(cp);
#line 285 "vc.g"
					cp->Add_CPElement(cpe);
#line 1268 "vcParser.cpp"
				}
				else {
					if ( _cnt61>=1 ) { goto _loop61; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt61++;
			}
			_loop61:;
			}  // ( ... )+
			{ // ( ... )+
			int _cnt63=0;
			for (;;) {
				if ((LA(1) == BIND)) {
					vc_CPBind(cp);
				}
				else {
					if ( _cnt63>=1 ) { goto _loop63; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt63++;
			}
			_loop63:;
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
			int _cnt66=0;
			for (;;) {
				if ((_tokenSet_10.member(LA(1)))) {
					vc_CPRegion(cp);
				}
				else {
					if ( _cnt66>=1 ) { goto _loop66; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt66++;
			}
			_loop66:;
			}  // ( ... )+
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == ATTRIBUTE)) {
					vc_AttributeSpec(cp);
				}
				else {
					goto _loop68;
				}
				
			}
			_loop68:;
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
#line 289 "vc.g"
		
			m->Set_Control_Path(cp);
		
#line 1345 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 677 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
		m->Set_Data_Path(dp);
	
#line 1361 "vcParser.cpp"
	
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
				goto _loop203;
			}
			}
		}
		_loop203:;
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
#line 181 "vc.g"
	
	vcDatapathElement* dpe;
	vector<string> ref_vec;
	vector<vcTransition*> reqs;
	vector<vcTransition*> acks;
	
#line 1434 "vcParser.cpp"
	
	try {      // for error handling
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 189 "vc.g"
		
		dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
		NOT_FOUND__("datapath-element",dpe,dpeid->getText(),dpeid)
		
#line 1444 "vcParser.cpp"
		match(EQUIVALENT);
		match(LPAREN);
		{ // ( ... )+
		int _cnt45=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 196 "vc.g"
				
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
				
				
#line 1474 "vcParser.cpp"
			}
			else {
				if ( _cnt45>=1 ) { goto _loop45; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt45++;
		}
		_loop45:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt49=0;
		for (;;) {
			switch ( LA(1)) {
			case SIMPLE_IDENTIFIER:
			case ENTRY:
			case EXIT:
			{
				{
				vc_Hierarchical_CP_Ref(ref_vec);
#line 221 "vc.g"
				
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
				
				
				
#line 1520 "vcParser.cpp"
				}
				break;
			}
			case OPEN:
			{
				{
				match(OPEN);
#line 246 "vc.g"
				acks.push_back(NULL);
#line 1530 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt49>=1 ) { goto _loop49; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt49++;
		}
		_loop49:;
		}  // ( ... )+
		match(RPAREN);
#line 249 "vc.g"
		m->Add_Link(dpe,reqs,acks);
#line 1546 "vcParser.cpp"
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
#line 256 "vc.g"
	
	string id;
	
#line 1563 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				id=vc_Identifier();
#line 260 "vc.g"
				ref_vec.push_back(id);
#line 1572 "vcParser.cpp"
				match(DIV_OP);
			}
			else {
				goto _loop52;
			}
			
		}
		_loop52:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			id=vc_Identifier();
#line 261 "vc.g"
			ref_vec.push_back(id);
#line 1590 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			entry_id = LT(1);
			match(ENTRY);
#line 262 "vc.g"
			ref_vec.push_back(entry_id->getText());
#line 1601 "vcParser.cpp"
			}
			break;
		}
		case EXIT:
		{
			{
			exit_id = LT(1);
			match(EXIT);
#line 263 "vc.g"
			ref_vec.push_back(exit_id->getText());
#line 1612 "vcParser.cpp"
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
#line 1608 "vc.g"
	string s;
#line 1632 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1608 "vc.g"
		s = id->getText();
#line 1640 "vcParser.cpp"
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
#line 569 "vc.g"
	
		string lbl;
		vcCPPipelinedForkBlock* fb;
		vcCPElement* cpe;
		string internal_id;
	
#line 1659 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPELINEDFORKBLOCK);
		lbl=vc_Label();
#line 576 "vc.g"
		fb = new vcCPPipelinedForkBlock(cp,lbl); fb->Set_Max_Iterations_In_Flight(m->Get_Pipeline_Depth());
#line 1666 "vcParser.cpp"
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
#line 581 "vc.g"
				fb->Add_CPElement(cpe);
#line 1687 "vcParser.cpp"
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
				goto _loop151;
			}
			}
		}
		_loop151:;
		} // ( ... )*
		match(RBRACE);
#line 583 "vc.g"
		cp->Add_CPElement(fb);
#line 1724 "vcParser.cpp"
		{
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 584 "vc.g"
				fb->Add_Exported_Input(internal_id);
#line 1733 "vcParser.cpp"
			}
			else {
				goto _loop154;
			}
			
		}
		_loop154:;
		} // ( ... )*
		match(RPAREN);
		}
		{
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 585 "vc.g"
				fb->Add_Exported_Output(internal_id);
#line 1752 "vcParser.cpp"
			}
			else {
				goto _loop157;
			}
			
		}
		_loop157:;
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
#line 304 "vc.g"
	vcCPElement* cpe;
#line 1775 "vcParser.cpp"
#line 304 "vc.g"
	
	string id;
	
#line 1780 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 309 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		cpe = (vcCPElement*) new vcPlace(p, id,0);
		
#line 1791 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case LEFT_OPEN:
		{
			match(LEFT_OPEN);
#line 314 "vc.g"
			cpe->Set_Is_Left_Open(true);
#line 1799 "vcParser.cpp"
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
#line 509 "vc.g"
	
		string pl_lbl, rgn_label, rgn_internal_lbl;
	bool input_binding;
	
#line 1839 "vcParser.cpp"
	
	try {      // for error handling
		match(BIND);
		pl_lbl=vc_Identifier();
		{
		switch ( LA(1)) {
		case IMPLIES:
		{
			{
			match(IMPLIES);
#line 514 "vc.g"
			input_binding = true;
#line 1852 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			match(ULE_OP);
#line 514 "vc.g"
			input_binding = false;
#line 1862 "vcParser.cpp"
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
#line 515 "vc.g"
		
			cp->Bind(pl_lbl,rgn_label,rgn_internal_lbl,input_binding);
		
#line 1879 "vcParser.cpp"
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
#line 297 "vc.g"
	vcCPElement* cpe;
#line 1930 "vcParser.cpp"
	
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
#line 321 "vc.g"
	vcCPElement* cpe;
#line 1966 "vcParser.cpp"
#line 321 "vc.g"
	
	string id;
	bool dead_flag = false;
	bool tie_high = false;
	bool leave_open = false;
	bool delay_flag = false;
	
#line 1975 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
		{
		switch ( LA(1)) {
		case DEAD:
		{
			{
			match(DEAD);
#line 329 "vc.g"
			dead_flag = true;
#line 1988 "vcParser.cpp"
			}
			break;
		}
		case TIED_HIGH:
		{
			{
			match(TIED_HIGH);
#line 329 "vc.g"
			tie_high = true;
#line 1998 "vcParser.cpp"
			}
			break;
		}
		case LEFT_OPEN:
		{
			{
			match(LEFT_OPEN);
#line 330 "vc.g"
			leave_open = true;
#line 2008 "vcParser.cpp"
			}
			break;
		}
		case DELAY:
		{
			{
			match(DELAY);
#line 330 "vc.g"
			delay_flag = true;
#line 2018 "vcParser.cpp"
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
#line 331 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		{
		cpe = (vcCPElement*) (new vcTransition(p,id));
			((vcTransition*)cpe)->Set_Is_Dead(dead_flag);
			((vcTransition*)cpe)->Set_Is_Tied_High(tie_high);
			((vcTransition*)cpe)->Set_Is_Left_Open(leave_open);
			((vcTransition*)cpe)->Set_Is_Delay_Element(delay_flag);
		}
		
#line 2057 "vcParser.cpp"
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
#line 358 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 2075 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 364 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 2082 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 365 "vc.g"
				sb->Add_CPElement(cpe);
#line 2094 "vcParser.cpp"
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
				goto _loop86;
			}
			}
		}
		_loop86:;
		} // ( ... )*
		match(RBRACE);
#line 367 "vc.g"
		cp->Add_CPElement(sb);
#line 2126 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 373 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	vcCPElement* t;
	
#line 2144 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 380 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 2151 "vcParser.cpp"
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
#line 381 "vc.g"
				sb->Add_CPElement(t);
#line 2169 "vcParser.cpp"
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
				goto _loop90;
			}
			}
		}
		_loop90:;
		} // ( ... )*
		match(RBRACE);
#line 383 "vc.g"
		cp->Add_CPElement(sb);
#line 2190 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 390 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 2207 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 396 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 2214 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )+
		int _cnt99=0;
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
#line 401 "vc.g"
				sb->Add_CPElement(cpe);
#line 2243 "vcParser.cpp"
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
				if ( _cnt99>=1 ) { goto _loop99; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt99++;
		}
		_loop99:;
		}  // ( ... )+
		match(RBRACE);
#line 403 "vc.g"
		cp->Add_CPElement(sb);
#line 2276 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 551 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 2293 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 557 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 2300 "vcParser.cpp"
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
#line 561 "vc.g"
				fb->Add_CPElement(cpe);
#line 2321 "vcParser.cpp"
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
				goto _loop142;
			}
			}
		}
		_loop142:;
		} // ( ... )*
		match(RBRACE);
#line 563 "vc.g"
		cp->Add_CPElement(fb);
#line 2353 "vcParser.cpp"
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
#line 538 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 2370 "vcParser.cpp"
	
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
#line 544 "vc.g"
			branch_ids.push_back(e->getText());
#line 2384 "vcParser.cpp"
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
#line 545 "vc.g"
				branch_ids.push_back(b);
#line 2404 "vcParser.cpp"
			}
			else {
				goto _loop134;
			}
			
		}
		_loop134:;
		} // ( ... )*
#line 545 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 2415 "vcParser.cpp"
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
#line 523 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 2433 "vcParser.cpp"
	
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
#line 529 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 2447 "vcParser.cpp"
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
#line 530 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 2467 "vcParser.cpp"
			}
			else {
				goto _loop130;
			}
			
		}
		_loop130:;
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
#line 409 "vc.g"
	
		string lbl;
		vcCPSimpleLoopBlock* sb;
		vcCPElement* cpe;
		int depth, buffering;
		bool full_rate_flag = false;
	
#line 2497 "vcParser.cpp"
	
	try {      // for error handling
		match(LOOPBLOCK);
		lbl=vc_Label();
#line 417 "vc.g"
		sb = new vcCPSimpleLoopBlock(cp,lbl);
#line 2504 "vcParser.cpp"
		match(DEPTH);
		did = LT(1);
		match(UINTEGER);
#line 418 "vc.g"
		depth = atoi(did->getText().c_str()); sb->Set_Pipeline_Depth(depth);
#line 2510 "vcParser.cpp"
		match(BUFFERING);
		bid = LT(1);
		match(UINTEGER);
#line 419 "vc.g"
		buffering = atoi(bid->getText().c_str()); sb->Set_Pipeline_Buffering(buffering);
#line 2516 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case FULLRATE:
		{
			match(FULLRATE);
#line 420 "vc.g"
			full_rate_flag = true;
#line 2524 "vcParser.cpp"
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
#line 422 "vc.g"
				sb->Add_CPElement(cpe);
#line 2544 "vcParser.cpp"
			}
			else {
				goto _loop103;
			}
			
		}
		_loop103:;
		} // ( ... )*
		vc_CPPipelinedLoopBody(sb);
		{ // ( ... )+
		int _cnt105=0;
		for (;;) {
			if ((LA(1) == SERIESBLOCK)) {
				vc_CPSeriesBlock(sb);
			}
			else {
				if ( _cnt105>=1 ) { goto _loop105; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt105++;
		}
		_loop105:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt107=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == MERGE)) {
				vc_CPMerge(sb);
			}
			else {
				if ( _cnt107>=1 ) { goto _loop107; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt107++;
		}
		_loop107:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt109=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				vc_CPBranch(sb);
			}
			else {
				if ( _cnt109>=1 ) { goto _loop109; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt109++;
		}
		_loop109:;
		}  // ( ... )+
		{ // ( ... )+
		int _cnt111=0;
		for (;;) {
			if ((LA(1) == BIND)) {
				vc_CPBind(sb);
			}
			else {
				if ( _cnt111>=1 ) { goto _loop111; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt111++;
		}
		_loop111:;
		}  // ( ... )+
		vc_CPLoopTerminate(sb);
		match(RBRACE);
#line 431 "vc.g"
		cp->Add_CPElement(sb);  sb->Set_Pipeline_Full_Rate_Flag(true);
#line 2614 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPPipelinedLoopBody(
	vcCPBlock* cp
) {
#line 592 "vc.g"
	
	string lbl;
	vcCPPipelinedLoopBody* fb;
	vcCPElement* cpe;
	string internal_id, external_id;
	bool pipeline_flag = false;
	
#line 2633 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPELINE);
		lbl=vc_Label();
#line 600 "vc.g"
		fb = new vcCPPipelinedLoopBody(cp,lbl);
#line 2640 "vcParser.cpp"
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
#line 605 "vc.g"
				fb->Add_CPElement(cpe);
#line 2661 "vcParser.cpp"
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
				goto _loop168;
			}
			}
		}
		_loop168:;
		} // ( ... )*
		match(RBRACE);
#line 609 "vc.g"
		cp->Add_CPElement(fb);
#line 2712 "vcParser.cpp"
		{
		match(LPAREN);
		{ // ( ... )+
		int _cnt171=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 610 "vc.g"
				fb->Add_Exported_Input(internal_id);
#line 2722 "vcParser.cpp"
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
		{
		match(LPAREN);
		{ // ( ... )+
		int _cnt174=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				internal_id=vc_Identifier();
#line 611 "vc.g"
				fb->Add_Exported_Output(internal_id);
#line 2743 "vcParser.cpp"
			}
			else {
				if ( _cnt174>=1 ) { goto _loop174; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt174++;
		}
		_loop174:;
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
#line 437 "vc.g"
	
		string loop_exit, loop_taken, loop_body, loop_back, exit_place;
	
#line 2769 "vcParser.cpp"
	
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
#line 449 "vc.g"
		slb->Set_Loop_Termination_Information(loop_exit, loop_taken, loop_body, loop_back, exit_place);
#line 2784 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_27);
	}
}

void vcParser::vc_CPPhiSequencer(
	vcCPPipelinedLoopBody* slb
) {
#line 457 "vc.g"
	
	vector<string> selects;
	vector<string> enables;
	vector<string> reqs;
	string lbl;
	string enable;
	string ack;
	string done;
	string tmp_string;
	
#line 2806 "vcParser.cpp"
	
	try {      // for error handling
		match(PHISEQUENCER);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt115=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 469 "vc.g"
				selects.push_back(tmp_string);
#line 2819 "vcParser.cpp"
			}
			else {
				if ( _cnt115>=1 ) { goto _loop115; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt115++;
		}
		_loop115:;
		}  // ( ... )+
		match(COLON);
		{ // ( ... )+
		int _cnt117=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 471 "vc.g"
				enables.push_back(tmp_string);
#line 2837 "vcParser.cpp"
			}
			else {
				if ( _cnt117>=1 ) { goto _loop117; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt117++;
		}
		_loop117:;
		}  // ( ... )+
		match(COLON);
		ack=vc_Identifier();
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt119=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 476 "vc.g"
				reqs.push_back(tmp_string);
#line 2858 "vcParser.cpp"
			}
			else {
				if ( _cnt119>=1 ) { goto _loop119; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt119++;
		}
		_loop119:;
		}  // ( ... )+
		match(COLON);
		done=vc_Identifier();
		match(RPAREN);
#line 480 "vc.g"
		slb->Add_Phi_Sequencer(lbl, selects, enables, ack, reqs, done);
#line 2873 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_28);
	}
}

void vcParser::vc_CPTransitionMerge(
	vcCPPipelinedLoopBody* slb
) {
#line 490 "vc.g"
	
	string tm_id;
	vector<string> in_transitions;
	string out_transition;
	string tmp_string;
	
#line 2891 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITIONMERGE);
		tm_id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt122=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				tmp_string=vc_Identifier();
#line 498 "vc.g"
				in_transitions.push_back(tmp_string);
#line 2904 "vcParser.cpp"
			}
			else {
				if ( _cnt122>=1 ) { goto _loop122; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt122++;
		}
		_loop122:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		out_transition=vc_Identifier();
		match(RPAREN);
#line 503 "vc.g"
		slb->Add_Transition_Merge(tm_id, in_transitions, out_transition);
#line 2920 "vcParser.cpp"
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
#line 658 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
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
		case ENTRY:
		{
			{
			fe = LT(1);
			match(ENTRY);
#line 665 "vc.g"
			lbl = fe->getText();
#line 2958 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			match(N_ULL);
#line 665 "vc.g"
			lbl = "$null";
#line 2968 "vcParser.cpp"
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
#line 666 "vc.g"
			fork_ids.push_back(e->getText());
#line 2988 "vcParser.cpp"
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
#line 667 "vc.g"
			fork_ids.push_back(n->getText());
#line 3011 "vcParser.cpp"
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
#line 668 "vc.g"
				fork_ids.push_back(b);
#line 3031 "vcParser.cpp"
			}
			else {
				goto _loop200;
			}
			
		}
		_loop200:;
		} // ( ... )*
		match(RPAREN);
#line 669 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 3043 "vcParser.cpp"
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
#line 618 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 3063 "vcParser.cpp"
	
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
#line 625 "vc.g"
			lbl = je->getText();
#line 3082 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			jen = LT(1);
			match(ENTRY);
#line 626 "vc.g"
			lbl = jen->getText();
#line 3093 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			jnull = LT(1);
			match(N_ULL);
#line 627 "vc.g"
			lbl = jnull->getText();
#line 3104 "vcParser.cpp"
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
#line 628 "vc.g"
			join_ids.push_back(e->getText());
#line 3124 "vcParser.cpp"
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
#line 629 "vc.g"
				join_ids.push_back(b);
#line 3144 "vcParser.cpp"
			}
			else {
				goto _loop183;
			}
			
		}
		_loop183:;
		} // ( ... )*
		match(RPAREN);
#line 630 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 3156 "vcParser.cpp"
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
#line 636 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
		vector<int>  join_markings;
	//
	// TODO: join markings need to be established here..
	//
	
#line 3181 "vcParser.cpp"
	
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
#line 647 "vc.g"
			lbl = je->getText();
#line 3200 "vcParser.cpp"
			}
			break;
		}
		case N_ULL:
		{
			{
			jnull = LT(1);
			match(N_ULL);
#line 648 "vc.g"
			lbl = jnull->getText();
#line 3211 "vcParser.cpp"
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
#line 649 "vc.g"
			join_ids.push_back(e->getText());
#line 3231 "vcParser.cpp"
			me = LT(1);
			match(UINTEGER);
#line 650 "vc.g"
			join_markings.push_back(atoi(me->getText().c_str()));
#line 3236 "vcParser.cpp"
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
#line 651 "vc.g"
				join_ids.push_back(b);
#line 3256 "vcParser.cpp"
				be = LT(1);
				match(UINTEGER);
#line 651 "vc.g"
				join_markings.push_back(atoi(be->getText().c_str()));
#line 3261 "vcParser.cpp"
			}
			else {
				goto _loop191;
			}
			
		}
		_loop191:;
		} // ( ... )*
		match(RPAREN);
#line 652 "vc.g"
		fb->Add_Marked_Join_Point(lbl,join_ids, join_markings);
#line 3273 "vcParser.cpp"
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
#line 694 "vc.g"
	
		vcWire* guard_wire = NULL;
		bool guard_complement = false;
		string gwid;
		vcDatapathElement* dpe = NULL;
	
#line 3292 "vcParser.cpp"
	
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
#line 705 "vc.g"
				guard_complement = true;
#line 3376 "vcParser.cpp"
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
#line 705 "vc.g"
			guard_wire = dp->Find_Wire(gwid); NOT_FOUND__("wire",guard_wire, gwid,gid)
#line 3392 "vcParser.cpp"
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
#line 707 "vc.g"
		
				if((dpe != NULL) && (guard_wire != NULL))
				{
					dpe->Set_Guard_Wire(guard_wire);
					dpe->Set_Guard_Complement(guard_complement);
				}
			
#line 3466 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case FLOWTHROUGH:
		{
			match(FLOWTHROUGH);
#line 714 "vc.g"
			dpe->Set_Flow_Through(true);
#line 3474 "vcParser.cpp"
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
#line 845 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vector<vcWire*> wires;
	vcWire* x;
	
#line 3557 "vcParser.cpp"
	
	try {      // for error handling
		br_id = LT(1);
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt251=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 856 "vc.g"
				x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,br_id)
				wires.push_back(x);
#line 3572 "vcParser.cpp"
			}
			else {
				if ( _cnt251>=1 ) { goto _loop251; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt251++;
		}
		_loop251:;
		}  // ( ... )+
		match(RPAREN);
#line 859 "vc.g"
		new_op = new vcBranch(id,wires); dp->Add_Branch(new_op);
#line 3585 "vcParser.cpp"
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
#line 1170 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 3606 "vcParser.cpp"
	
	try {      // for error handling
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt277=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1179 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 3622 "vcParser.cpp"
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
#line 1184 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
			 phi = new vcPhi(lbl,inwires, outwire); 
		
		dp->Add_Phi(phi);
		
#line 3643 "vcParser.cpp"
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
#line 1197 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhiPipelined* phi;
	vector<vcWire*> inwires;
	
#line 3665 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt280=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1206 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 3682 "vcParser.cpp"
			}
			else {
				if ( _cnt280>=1 ) { goto _loop280; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt280++;
		}
		_loop280:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 1211 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
		phi = new vcPhiPipelined(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 3702 "vcParser.cpp"
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
#line 1495 "vc.g"
	
		string dpe_name;
		string wire_name;
		int buffering;
		bool input_flag = true;
	
#line 3724 "vcParser.cpp"
	
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
#line 1503 "vc.g"
			input_flag = false;
#line 3741 "vcParser.cpp"
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
#line 1504 "vc.g"
		dpe_name = dpe_id->getText();
#line 3755 "vcParser.cpp"
		wire_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1505 "vc.g"
		wire_name = wire_id->getText();
#line 3760 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1506 "vc.g"
		buffering = atoi(bid->getText().c_str());
#line 3765 "vcParser.cpp"
#line 1507 "vc.g"
		
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
				
#line 3784 "vcParser.cpp"
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
#line 1529 "vc.g"
	
		string dpe_name;
		int delay = 1;
	
#line 3802 "vcParser.cpp"
	
	try {      // for error handling
		match(DELAY);
		dpe_id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1535 "vc.g"
		dpe_name = dpe_id->getText();
#line 3810 "vcParser.cpp"
		bid = LT(1);
		match(UINTEGER);
#line 1536 "vc.g"
		delay = atoi(bid->getText().c_str());
#line 3815 "vcParser.cpp"
#line 1537 "vc.g"
		
						vcDatapathElement* dpe = m->Get_Data_Path()->Find_DPE(dpe_name);
						NOT_FOUND__("Datapath-element", dpe, dpe_name, dpe_id);
						if(dpe != NULL)
						{
							dpe->Set_Delay(delay);
						}
				
#line 3825 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_29);
	}
}

vcDatapathElement*  vcParser::vc_Operator_Instantiation(
	vcDataPath* dp
) {
#line 721 "vc.g"
	vcDatapathElement* dpe;
#line 3838 "vcParser.cpp"
	
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
#line 1018 "vc.g"
	vcDatapathElement* dpe;
#line 3929 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1018 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 3943 "vcParser.cpp"
	
	try {      // for error handling
		cid = LT(1);
		match(CALL);
		{
		switch ( LA(1)) {
		case INLINE:
		{
			match(INLINE);
#line 1029 "vc.g"
			inline_flag = true;
#line 3955 "vcParser.cpp"
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
#line 1030 "vc.g"
		m = sys->Find_Module(mid); NOT_FOUND__("module",m,mid,cid)
#line 3973 "vcParser.cpp"
		lpid1 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 1031 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid1)
				inwires.push_back(w);
#line 3984 "vcParser.cpp"
			}
			else {
				goto _loop264;
			}
			
		}
		_loop264:;
		} // ( ... )*
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 1034 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid2)
				outwires.push_back(w);
#line 4004 "vcParser.cpp"
			}
			else {
				goto _loop266;
			}
			
		}
		_loop266:;
		} // ( ... )*
		match(RPAREN);
#line 1037 "vc.g"
		
			 nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc); 
			 dpe = (vcDatapathElement*) nc;
			
#line 4019 "vcParser.cpp"
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
#line 1046 "vc.g"
	vcDatapathElement* dpe;
#line 4033 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ipid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1046 "vc.g"
	
	string id, in_id, out_id, pipe_id;
	vcWire* w;
	vcPipe* p = NULL;
	bool in_flag = false;
	
#line 4043 "vcParser.cpp"
	
	try {      // for error handling
		ipid = LT(1);
		match(IOPORT);
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 1053 "vc.g"
			in_flag = true;
#line 4056 "vcParser.cpp"
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
#line 1055 "vc.g"
		
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
			
		
#line 4117 "vcParser.cpp"
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
#line 1097 "vc.g"
	vcDatapathElement* dpe;
#line 4131 "vcParser.cpp"
	
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
#line 736 "vc.g"
	vcDatapathElement* dpe;
#line 4163 "vcParser.cpp"
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
#line 736 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4202 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 748 "vc.g"
			op_id = plus_id->getText();
#line 4214 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 749 "vc.g"
			op_id = minus_id->getText();
#line 4225 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 750 "vc.g"
			op_id = mul_id->getText();
#line 4236 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 751 "vc.g"
			op_id = div_id->getText();
#line 4247 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 752 "vc.g"
			op_id = shl_id->getText();
#line 4258 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 753 "vc.g"
			op_id = shr_id->getText();
#line 4269 "vcParser.cpp"
			}
			break;
		}
		case UGT_OP:
		{
			{
			gt_id = LT(1);
			match(UGT_OP);
#line 754 "vc.g"
			op_id = gt_id->getText();
#line 4280 "vcParser.cpp"
			}
			break;
		}
		case UGE_OP:
		{
			{
			ge_id = LT(1);
			match(UGE_OP);
#line 755 "vc.g"
			op_id = ge_id->getText();
#line 4291 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 756 "vc.g"
			op_id = eq_id->getText();
#line 4302 "vcParser.cpp"
			}
			break;
		}
		case ULT_OP:
		{
			{
			lt_id = LT(1);
			match(ULT_OP);
#line 757 "vc.g"
			op_id = lt_id->getText();
#line 4313 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			le_id = LT(1);
			match(ULE_OP);
#line 758 "vc.g"
			op_id = le_id->getText();
#line 4324 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 759 "vc.g"
			op_id = neq_id->getText();
#line 4335 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 760 "vc.g"
			op_id = bitsel_id->getText();
#line 4346 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 761 "vc.g"
			op_id = concat_id->getText();
#line 4357 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 762 "vc.g"
			op_id = or_id->getText();
#line 4368 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 763 "vc.g"
			op_id = and_id->getText();
#line 4379 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 764 "vc.g"
			op_id = xor_id->getText();
#line 4390 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 765 "vc.g"
			op_id = nor_id->getText();
#line 4401 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 766 "vc.g"
			op_id = nand_id->getText();
#line 4412 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 767 "vc.g"
			op_id = xnor_id->getText();
#line 4423 "vcParser.cpp"
			}
			break;
		}
		case SHRA_OP:
		{
			{
			shra_id = LT(1);
			match(SHRA_OP);
#line 768 "vc.g"
			op_id = shra_id->getText();
#line 4434 "vcParser.cpp"
			}
			break;
		}
		case SGT_OP:
		{
			{
			sgt_id = LT(1);
			match(SGT_OP);
#line 769 "vc.g"
			op_id = sgt_id->getText();
#line 4445 "vcParser.cpp"
			}
			break;
		}
		case SGE_OP:
		{
			{
			sge_id = LT(1);
			match(SGE_OP);
#line 770 "vc.g"
			op_id = sge_id->getText();
#line 4456 "vcParser.cpp"
			}
			break;
		}
		case SLT_OP:
		{
			{
			slt_id = LT(1);
			match(SLT_OP);
#line 771 "vc.g"
			op_id = slt_id->getText();
#line 4467 "vcParser.cpp"
			}
			break;
		}
		case SLE_OP:
		{
			{
			sle_id = LT(1);
			match(SLE_OP);
#line 772 "vc.g"
			op_id = sle_id->getText();
#line 4478 "vcParser.cpp"
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
#line 775 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4497 "vcParser.cpp"
		wid=vc_Identifier();
#line 780 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 4505 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 788 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4515 "vcParser.cpp"
		match(RPAREN);
#line 793 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op); 
			dpe = (vcDatapathElement*)new_op;
#line 4520 "vcParser.cpp"
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
#line 801 "vc.g"
	vcDatapathElement* dpe;
#line 4534 "vcParser.cpp"
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
#line 801 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 4555 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 813 "vc.g"
			op_id = not_id->getText();
#line 4567 "vcParser.cpp"
			}
			break;
		}
		case StoS_ASSIGN_OP:
		{
			{
			ss_assign_id = LT(1);
			match(StoS_ASSIGN_OP);
#line 814 "vc.g"
			op_id = ss_assign_id->getText();
#line 4578 "vcParser.cpp"
			}
			break;
		}
		case StoU_ASSIGN_OP:
		{
			{
			su_assign_id = LT(1);
			match(StoU_ASSIGN_OP);
#line 815 "vc.g"
			op_id = su_assign_id->getText();
#line 4589 "vcParser.cpp"
			}
			break;
		}
		case UtoS_ASSIGN_OP:
		{
			{
			us_assign_id = LT(1);
			match(UtoS_ASSIGN_OP);
#line 816 "vc.g"
			op_id = us_assign_id->getText();
#line 4600 "vcParser.cpp"
			}
			break;
		}
		case FtoS_ASSIGN_OP:
		{
			{
			fs_assign_id = LT(1);
			match(FtoS_ASSIGN_OP);
#line 817 "vc.g"
			op_id = fs_assign_id->getText();
#line 4611 "vcParser.cpp"
			}
			break;
		}
		case FtoU_ASSIGN_OP:
		{
			{
			fu_assign_id = LT(1);
			match(FtoU_ASSIGN_OP);
#line 818 "vc.g"
			op_id = fu_assign_id->getText();
#line 4622 "vcParser.cpp"
			}
			break;
		}
		case StoF_ASSIGN_OP:
		{
			{
			sf_assign_id = LT(1);
			match(StoF_ASSIGN_OP);
#line 819 "vc.g"
			op_id = sf_assign_id->getText();
#line 4633 "vcParser.cpp"
			}
			break;
		}
		case UtoF_ASSIGN_OP:
		{
			{
			uf_assign_id = LT(1);
			match(UtoF_ASSIGN_OP);
#line 820 "vc.g"
			op_id = uf_assign_id->getText();
#line 4644 "vcParser.cpp"
			}
			break;
		}
		case FtoF_ASSIGN_OP:
		{
			{
			ff_assign_id = LT(1);
			match(FtoF_ASSIGN_OP);
#line 821 "vc.g"
			op_id = ff_assign_id->getText();
#line 4655 "vcParser.cpp"
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
#line 824 "vc.g"
		
		x = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 4674 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 831 "vc.g"
		
		z = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 4684 "vcParser.cpp"
		match(RPAREN);
#line 836 "vc.g"
		
			new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
			dpe = (vcDatapathElement*) new_op;
		
#line 4691 "vcParser.cpp"
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
#line 866 "vc.g"
	vcDatapathElement* dpe;
#line 4705 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 866 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 4719 "vcParser.cpp"
	
	try {      // for error handling
		sel_id = LT(1);
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 881 "vc.g"
		sel = dp->Find_Wire(wid); NOT_FOUND__("wire",sel,wid,sel_id)
#line 4729 "vcParser.cpp"
		wid=vc_Identifier();
#line 882 "vc.g"
		x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,sel_id)
#line 4733 "vcParser.cpp"
		wid=vc_Identifier();
#line 883 "vc.g"
		y = dp->Find_Wire(wid); NOT_FOUND__("wire",y,wid,sel_id)
#line 4737 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 886 "vc.g"
		z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id)
#line 4743 "vcParser.cpp"
		match(RPAREN);
#line 888 "vc.g"
		
			new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);   
			dpe = (vcDatapathElement*) new_op;
		
#line 4750 "vcParser.cpp"
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
#line 898 "vc.g"
	vcDatapathElement* dpe;
#line 4764 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  slice_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 898 "vc.g"
	
	vcSlice* new_op = NULL;
	string id;
	string wid;
	int h, l;
	vcWire* sel = NULL;
	vcWire* din = NULL;
	vcWire* dout = NULL;
	
#line 4778 "vcParser.cpp"
	
	try {      // for error handling
		slice_id = LT(1);
		match(SLICE_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 911 "vc.g"
		din = dp->Find_Wire(wid); NOT_FOUND__("wire",din,wid,slice_id)
#line 4788 "vcParser.cpp"
		hid = LT(1);
		match(UINTEGER);
#line 912 "vc.g"
		h = atoi(hid->getText().c_str());
#line 4793 "vcParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 913 "vc.g"
		l = atoi(lid->getText().c_str());
#line 4798 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 916 "vc.g"
		dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id)
#line 4804 "vcParser.cpp"
		match(RPAREN);
#line 918 "vc.g"
		
			new_op = new vcSlice(id,din,dout,h,l); dp->Add_Slice(new_op);    
			dpe = (vcDatapathElement*) new_op;
		
#line 4811 "vcParser.cpp"
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
#line 929 "vc.g"
	vcDatapathElement* dpe;
#line 4825 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 929 "vc.g"
	
	vcRegister* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 4836 "vcParser.cpp"
	
	try {      // for error handling
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 937 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 4847 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 940 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 4854 "vcParser.cpp"
		match(RPAREN);
#line 943 "vc.g"
		
		new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
			dpe = (vcDatapathElement*) new_reg;
		
#line 4861 "vcParser.cpp"
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
#line 979 "vc.g"
	vcDatapathElement* dpe;
#line 4875 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 979 "vc.g"
	
	string id;
	vcEquivalence* nm = NULL;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	vcWire* w;
	string wid;
	
#line 4886 "vcParser.cpp"
	
	try {      // for error handling
		eq_id = LT(1);
		match(EQUIVALENCE_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt258=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 991 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				inwires.push_back(w);
				
#line 4904 "vcParser.cpp"
			}
			else {
				if ( _cnt258>=1 ) { goto _loop258; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt258++;
		}
		_loop258:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt260=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 999 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				outwires.push_back(w);
				
#line 4927 "vcParser.cpp"
			}
			else {
				if ( _cnt260>=1 ) { goto _loop260; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt260++;
		}
		_loop260:;
		}  // ( ... )+
		match(RPAREN);
#line 1005 "vc.g"
		
		nm = new vcEquivalence(id,inwires,outwires);
		dp->Add_Equivalence(nm);
			    dpe = (vcDatapathElement*) nm;
		
#line 4944 "vcParser.cpp"
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
#line 953 "vc.g"
	vcDatapathElement* dpe;
#line 4958 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 953 "vc.g"
	
	vcInterlockBuffer* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 4969 "vcParser.cpp"
	
	try {      // for error handling
		match(HASH);
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 961 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 4981 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 964 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 4988 "vcParser.cpp"
		match(RPAREN);
#line 967 "vc.g"
		
		new_reg = new vcInterlockBuffer(id, x, y); 
		dp->Add_Interlock_Buffer(new_reg);
		dpe = (vcDatapathElement*) new_reg;
		
#line 4996 "vcParser.cpp"
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
#line 1106 "vc.g"
	vcDatapathElement* dpe;
#line 5010 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ldid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1106 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
	
#line 5023 "vcParser.cpp"
	
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
#line 1118 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),ldid)
		
#line 5048 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 1122 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,ldid);
		
#line 5055 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 1125 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",data,wid,ldid);
		
#line 5063 "vcParser.cpp"
		match(RPAREN);
#line 1128 "vc.g"
		
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
			 dpe = (vcDatapathElement*) nl;
		
#line 5071 "vcParser.cpp"
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
#line 1139 "vc.g"
	vcDatapathElement* dpe;
#line 5085 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  st_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1139 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 5097 "vcParser.cpp"
	
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
#line 1150 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),st_id)
		
#line 5122 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 1154 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,st_id);
		
#line 5129 "vcParser.cpp"
		wid=vc_Identifier();
#line 1157 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("data",addr,wid,st_id);              
		
#line 5135 "vcParser.cpp"
		match(RPAREN);
#line 1160 "vc.g"
		
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
			 dpe=(vcDatapathElement*)  ns;
		
#line 5143 "vcParser.cpp"
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
#line 1252 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 5162 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1258 "vc.g"
		obj_name = id->getText();
#line 5169 "vcParser.cpp"
		match(COLON);
		t=vc_Type(sys);
#line 1259 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 5176 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
#line 1267 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	string oname;
	
#line 5193 "vcParser.cpp"
	
	try {      // for error handling
		oname=vc_Label();
#line 1273 "vc.g"
		obj_name = oname;
#line 5199 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 1273 "vc.g"
		*t = tt;
#line 5204 "vcParser.cpp"
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
#line 1274 "vc.g"
		if(v != NULL) *v = vv;
#line 5219 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 1328 "vc.g"
	vcValue* v;
#line 5232 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1328 "vc.g"
	
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
	
#line 5257 "vcParser.cpp"
	
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
#line 1351 "vc.g"
				vstring = bid->getText(); format = "binary";
#line 5274 "vcParser.cpp"
				}
				break;
			}
			case HEXSTRING:
			{
				{
				hid = LT(1);
				match(HEXSTRING);
#line 1352 "vc.g"
				vstring = hid->getText(); format = "hexadecimal";
#line 5285 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 1354 "vc.g"
			
				if(t->Is("vcIntType") || t->Is("vcPointerType"))
				   v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
			else if(t->Is("vcFloatType"))
				   v = (vcValue*) (new vcFloatValue((vcFloatType*)t,vstring.substr(2),format));
			
#line 5302 "vcParser.cpp"
			}
			break;
		}
		case LPAREN:
		{
			{
			sid = LT(1);
			match(LPAREN);
			ev=vc_Value(etypes[idx]);
#line 1363 "vc.g"
			evalues.push_back(ev);
#line 5314 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 1364 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 5321 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 1364 "vc.g"
					evalues.push_back(ev);
#line 5325 "vcParser.cpp"
				}
				else {
					goto _loop303;
				}
				
			}
			_loop303:;
			} // ( ... )*
#line 1366 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 5343 "vcParser.cpp"
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
#line 1388 "vc.g"
	vcType* t;
#line 5366 "vcParser.cpp"
	
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
#line 1430 "vc.g"
	vcType* t;
#line 5409 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1430 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 5417 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 1435 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 5426 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 1436 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 5432 "vcParser.cpp"
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
#line 1442 "vc.g"
	vcType* t;
#line 5446 "vcParser.cpp"
#line 1442 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 5453 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		{ // ( ... )+
		int _cnt321=0;
		for (;;) {
			if ((LA(1) == ULT_OP) && (_tokenSet_33.member(LA(2)))) {
				match(ULT_OP);
				{
				et=vc_Type(sys);
#line 1447 "vc.g"
				etypes.push_back(et);
#line 5466 "vcParser.cpp"
				}
				match(UGT_OP);
			}
			else {
				if ( _cnt321>=1 ) { goto _loop321; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt321++;
		}
		_loop321:;
		}  // ( ... )+
#line 1448 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 5480 "vcParser.cpp"
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
#line 1394 "vc.g"
	vcType* t;
#line 5494 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1394 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 5501 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(ULT_OP);
		i = LT(1);
		match(UINTEGER);
#line 1399 "vc.g"
		w = atoi(i->getText().c_str());
#line 5510 "vcParser.cpp"
		match(UGT_OP);
#line 1399 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 5514 "vcParser.cpp"
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
#line 1405 "vc.g"
	vcType* t;
#line 5528 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1405 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 5536 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(ULT_OP);
		cid = LT(1);
		match(UINTEGER);
#line 1410 "vc.g"
		c = atoi(cid->getText().c_str());
#line 5545 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 1410 "vc.g"
		m = atoi(mid->getText().c_str());
#line 5551 "vcParser.cpp"
		match(UGT_OP);
#line 1411 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 5555 "vcParser.cpp"
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
#line 1418 "vc.g"
	vcType* t;
#line 5569 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1418 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 5577 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(ULT_OP);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(DIV_OP);
#line 1423 "vc.g"
			scope_id = sid->getText();
#line 5589 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == UGT_OP)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1424 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 5602 "vcParser.cpp"
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
	"IN",
	"OUT",
	"PORT",
	"SIGNAL",
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
const unsigned long vcParser::_tokenSet_1_data_[] = { 96473138UL, 0UL, 0UL, 268664832UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE FOREIGN PIPELINE BUFFERING MODULE CONSTANT 
// INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,8);
const unsigned long vcParser::_tokenSet_2_data_[] = { 230723634UL, 268435464UL, 0UL, 268664832UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN PIPELINE BUFFERING MODULE SIMPLE_IDENTIFIER 
// CONTROLPATH DATAPATH CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 96505906UL, 1074266625UL, 4294967295UL, 268670399UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN PIPELINE BUFFERING MODULE DIV_OP 
// DELAY ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP 
// EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 748732608UL, 21217270UL, 0UL, 268438016UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER DEPTH LBRACE RBRACE COLON PIPELINE MODULE SIMPLE_IDENTIFIER 
// LPAREN ENTRY EXIT PLACE LEFT_OPEN TRANSITION DEAD TIED_HIGH DELAY SERIESBLOCK 
// PARALLELBLOCK BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE BIND 
// FORKBLOCK N_ULL FROM TO ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,8);
const unsigned long vcParser::_tokenSet_5_data_[] = { 1081344UL, 0UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,8);
const unsigned long vcParser::_tokenSet_6_data_[] = { 151027712UL, 1095351895UL, 4294967295UL, 268670399UL, 0UL, 0UL, 0UL, 0UL };
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
const unsigned long vcParser::_tokenSet_7_data_[] = { 231772722UL, 1342702089UL, 4294967295UL, 268670399UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE OUT MEMORYSPACE RBRACE OBJECT FOREIGN PIPELINE BUFFERING 
// MODULE SIMPLE_IDENTIFIER DIV_OP CONTROLPATH DELAY ULE_OP DATAPATH NOT_OP 
// PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP 
// BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP 
// SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP 
// FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP 
// BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP CALL IOPORT 
// LOAD STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,8);
const unsigned long vcParser::_tokenSet_8_data_[] = { 134255152UL, 268435464UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE OUT MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,8);
const unsigned long vcParser::_tokenSet_9_data_[] = { 134254640UL, 268435464UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,8);
const unsigned long vcParser::_tokenSet_10_data_[] = { 0UL, 4201472UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,6);
const unsigned long vcParser::_tokenSet_11_data_[] = { 134250496UL, 268435456UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 0UL, 1074266113UL, 2147483647UL, 1471UL, 0UL, 0UL, 0UL, 0UL };
// DIV_OP ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP 
// EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP 
// XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP CALL 
// IOPORT LOAD STORE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 768UL, 0UL, 0UL, 8260UL, 0UL, 0UL, 0UL, 0UL };
// IN OUT ASSIGN_OP INLINE LBRACKET 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,8);
const unsigned long vcParser::_tokenSet_14_data_[] = { 134250496UL, 0UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,8);
const unsigned long vcParser::_tokenSet_15_data_[] = { 3355443200UL, 6UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RPAREN OPEN ENTRY EXIT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,6);
const unsigned long vcParser::_tokenSet_16_data_[] = { 3894444096UL, 238960647UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER RBRACE COLON SIMPLE_IDENTIFIER LPAREN RPAREN OPEN DIV_OP ENTRY 
// EXIT TERMINATE BIND IMPLIES ULE_OP MERGE BRANCH JOIN MARKEDJOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,6);
const unsigned long vcParser::_tokenSet_17_data_[] = { 134217728UL, 16777222UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER ENTRY EXIT N_ULL 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,6);
const unsigned long vcParser::_tokenSet_18_data_[] = { 0UL, 16UL, 0UL, 0UL, 0UL, 0UL };
// PLACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,6);
const unsigned long vcParser::_tokenSet_19_data_[] = { 142639104UL, 4340816UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PIPELINE SIMPLE_IDENTIFIER PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK BIND FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,8);
const unsigned long vcParser::_tokenSet_20_data_[] = { 32768UL, 147456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE TERMINATE BIND 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,6);
const unsigned long vcParser::_tokenSet_21_data_[] = { 134250496UL, 21085270UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK LOOPBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,8);
const unsigned long vcParser::_tokenSet_22_data_[] = { 32768UL, 4201552UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,8);
const unsigned long vcParser::_tokenSet_23_data_[] = { 134250496UL, 21077078UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,8);
const unsigned long vcParser::_tokenSet_24_data_[] = { 134250496UL, 4340752UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// LOOPBLOCK BIND FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,8);
const unsigned long vcParser::_tokenSet_25_data_[] = { 134250496UL, 4209680UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// LOOPBLOCK FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,8);
const unsigned long vcParser::_tokenSet_26_data_[] = { 0UL, 1024UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,6);
const unsigned long vcParser::_tokenSet_27_data_[] = { 32768UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,6);
const unsigned long vcParser::_tokenSet_28_data_[] = { 134250496UL, 21077062UL, 0UL, 268435456UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK PHISEQUENCER TRANSITIONMERGE FORKBLOCK N_ULL ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,8);
const unsigned long vcParser::_tokenSet_29_data_[] = { 16809984UL, 1074266625UL, 4294967295UL, 268670399UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE BUFFERING DIV_OP DELAY ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP 
// SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP 
// OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP 
// SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP 
// StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP 
// ASSIGN_OP HASH EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_29(_tokenSet_29_data_,8);
const unsigned long vcParser::_tokenSet_30_data_[] = { 16809984UL, 3758621185UL, 4294967295UL, 268670399UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE BUFFERING DIV_OP DELAY ULE_OP GUARD NOT_OP FLOWTHROUGH PLUS_OP 
// MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP 
// CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP 
// SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP 
// FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP 
// SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP CALL IOPORT LOAD STORE 
// PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_30(_tokenSet_30_data_,8);
const unsigned long vcParser::_tokenSet_31_data_[] = { 251704226UL, 0UL, 0UL, 402796612UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE DEPTH IN OUT MEMORYSPACE UNORDERED RBRACE BUFFERING FULLRATE 
// MODULE SIMPLE_IDENTIFIER ASSIGN_OP INLINE PHI LBRACKET WIRE SIMPLE_IDENTIFER 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_31(_tokenSet_31_data_,8);
const unsigned long vcParser::_tokenSet_32_data_[] = { 1170247730UL, 1074266625UL, 4294967295UL, 269718975UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN PIPELINE BUFFERING MODULE RPAREN 
// DIV_OP DELAY ULE_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP 
// UGE_OP EQ_OP ULT_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP 
// NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP HASH EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_32(_tokenSet_32_data_,8);
const unsigned long vcParser::_tokenSet_33_data_[] = { 0UL, 0UL, 0UL, 98566144UL, 0UL, 0UL, 0UL, 0UL };
// INT FLOAT POINTER ARRAY RECORD 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_33(_tokenSet_33_data_,8);


