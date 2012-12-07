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
			default:
			{
				goto _loop8;
			}
			}
		}
		_loop8:;
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
#line 129 "vc.g"
	vcModule* m;
#line 115 "vcParser.cpp"
#line 129 "vc.g"
	
		string lbl;
		m = NULL;
	bool foreign_flag = false;
	bool pipeline_flag = false;
	vcMemorySpace* ms;
	
#line 124 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case FOREIGN:
		{
			match(FOREIGN);
#line 137 "vc.g"
			foreign_flag = true;
#line 134 "vcParser.cpp"
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
#line 139 "vc.g"
		
		m = new vcModule(sys,lbl); 
		sys->Add_Module(m); 
		if(foreign_flag) m->Set_Foreign_Flag(true);
		
#line 155 "vcParser.cpp"
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
#line 145 "vc.g"
				m->Add_Memory_Space(ms);
#line 212 "vcParser.cpp"
			}
			else {
				goto _loop25;
			}
			
		}
		_loop25:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LIFO || LA(1) == PIPE)) {
				vc_Pipe(NULL,m);
			}
			else {
				goto _loop27;
			}
			
		}
		_loop27:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case CONTROLPATH:
		{
			vc_Controlpath(sys,m,pipeline_flag);
#line 147 "vc.g"
			assert(!foreign_flag);
#line 240 "vcParser.cpp"
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
#line 148 "vc.g"
			assert(!foreign_flag);
#line 263 "vcParser.cpp"
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
#line 149 "vc.g"
				assert(!foreign_flag);
#line 284 "vcParser.cpp"
			}
			else {
				goto _loop31;
			}
			
		}
		_loop31:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(m);
			}
			else {
				goto _loop33;
			}
			
		}
		_loop33:;
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
#line 83 "vc.g"
	vcMemorySpace* ms;
#line 319 "vcParser.cpp"
#line 83 "vc.g"
	
		string lbl;
		bool unordered_flag = false;
		ms = NULL;
	
#line 326 "vcParser.cpp"
	
	try {      // for error handling
		match(MEMORYSPACE);
		{
		switch ( LA(1)) {
		case UNORDERED:
		{
			match(UNORDERED);
#line 89 "vc.g"
			unordered_flag = true;
#line 337 "vcParser.cpp"
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
#line 91 "vc.g"
		
				ms = new vcMemorySpace(lbl,m);
				ms->Set_Ordered_Flag(!unordered_flag);
			
#line 356 "vcParser.cpp"
		match(LBRACE);
		vc_MemorySpaceParams(ms);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == OBJECT)) {
				vc_MemoryLocation(sys,ms);
			}
			else {
				goto _loop15;
			}
			
		}
		_loop15:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(ms);
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
		recover(ex,_tokenSet_2);
	}
	return ms;
}

void vcParser::vc_Pipe(
	vcSystem* sys, vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 65 "vc.g"
	
	string lbl;
	int depth = 1;
	bool lifo_mode = false;
	
#line 403 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case LIFO:
		{
			match(LIFO);
#line 70 "vc.g"
			lifo_mode = true;
#line 413 "vcParser.cpp"
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
#line 70 "vc.g"
			depth = atoi(did->getText().c_str());
#line 439 "vcParser.cpp"
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
#line 71 "vc.g"
		
		if (sys) 
		sys->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode);
		else if(m)
		m->Add_Pipe(lbl,atoi(wid->getText().c_str()),depth, lifo_mode);
		
#line 472 "vcParser.cpp"
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
#line 1077 "vc.g"
	
		vcType* t;
	vcValue* v;
		string obj_name;
	bool const_flag = false;
	bool intermediate_flag = false;
	
#line 494 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case CONSTANT:
		{
			{
			cid = LT(1);
			match(CONSTANT);
#line 1086 "vc.g"
			const_flag = true;
#line 506 "vcParser.cpp"
			}
			break;
		}
		case INTERMEDIATE:
		{
			{
			iid = LT(1);
			match(INTERMEDIATE);
#line 1086 "vc.g"
			intermediate_flag = true;
#line 517 "vcParser.cpp"
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
#line 1087 "vc.g"
		
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
		
#line 565 "vcParser.cpp"
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
#line 1249 "vc.g"
	
		string key;
		string value;
		bool mem_space = false;
	bool module = false;
		vcRoot* child = NULL;
		string m_id;
		string ms_id;
	string child_id;
	
#line 590 "vcParser.cpp"
	
	try {      // for error handling
		aid = LT(1);
		match(ATTRIBUTE);
		{
		switch ( LA(1)) {
		case MEMORYSPACE:
		{
			{
			match(MEMORYSPACE);
#line 1262 "vc.g"
			mem_space = true;
#line 603 "vcParser.cpp"
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
#line 1264 "vc.g"
			
								child_id = m_id + "/" + ms_id; 
								child = sys->Find_Memory_Space(m_id,ms_id);
							
#line 622 "vcParser.cpp"
			}
			break;
		}
		case MODULE:
		{
			{
			match(MODULE);
#line 1268 "vc.g"
			module = true;
#line 632 "vcParser.cpp"
			m_id=vc_Identifier();
#line 1270 "vc.g"
			
								child_id = m_id;
								child = sys->Find_Module(m_id);
							
#line 639 "vcParser.cpp"
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
#line 1275 "vc.g"
		key = kid->getText();
#line 653 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1276 "vc.g"
		value = vid->getText();
#line 659 "vcParser.cpp"
#line 1277 "vc.g"
		
					if(child != NULL) 
						child->Add_Attribute(key,value);
					else
					{
						vcSystem::Warning("could not find " + child_id + " to add attribute,"
									+ IntToStr(aid->getLine()));
								
					}
				
#line 671 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

string  vcParser::vc_Label() {
#line 1018 "vc.g"
	string lbl;
#line 682 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		{
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1020 "vc.g"
		lbl = id->getText();
#line 692 "vcParser.cpp"
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
#line 103 "vc.g"
		ms->Set_Capacity(atoi(cap->getText().c_str()));
#line 717 "vcParser.cpp"
		match(DATAWIDTH);
		lau = LT(1);
		match(UINTEGER);
#line 104 "vc.g"
		ms->Set_Word_Size(atoi(lau->getText().c_str()));
#line 723 "vcParser.cpp"
		match(ADDRWIDTH);
		aw = LT(1);
		match(UINTEGER);
#line 105 "vc.g"
		ms->Set_Address_Width(atoi(aw->getText().c_str()));
#line 729 "vcParser.cpp"
		match(MAXACCESSWIDTH);
		maw = LT(1);
		match(UINTEGER);
#line 106 "vc.g"
		ms->Set_Max_Access_Width(atoi(maw->getText().c_str()));
#line 735 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_5);
	}
}

void vcParser::vc_MemoryLocation(
	vcSystem* sys, vcMemorySpace* ms
) {
#line 112 "vc.g"
	
		vcStorageObject* nl = NULL;
		string lbl;
		vcType* t;
		vcValue* v = NULL;
	
#line 753 "vcParser.cpp"
	
	try {      // for error handling
		match(OBJECT);
		lbl=vc_Label();
		match(COLON);
		t=vc_Type(sys);
#line 120 "vc.g"
		
			nl = new vcStorageObject(lbl,t);
		ms->Add_Storage_Object(nl);
		
#line 765 "vcParser.cpp"
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
#line 1292 "vc.g"
	
		string key;
		string value;
	
#line 783 "vcParser.cpp"
	
	try {      // for error handling
		match(ATTRIBUTE);
		kid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1298 "vc.g"
		key = kid->getText();
#line 791 "vcParser.cpp"
		match(IMPLIES);
		vid = LT(1);
		match(QUOTED_STRING);
#line 1298 "vc.g"
		value = vid->getText();
#line 797 "vcParser.cpp"
#line 1299 "vc.g"
		m->Add_Attribute(key,value);
#line 800 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcType*  vcParser::vc_Type(
	vcSystem* sys
) {
#line 1177 "vc.g"
	vcType* t;
#line 813 "vcParser.cpp"
	
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
#line 1026 "vc.g"
	
		string mode = "in";
	
#line 862 "vcParser.cpp"
	
	try {      // for error handling
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys, parent,mode);
			}
			else {
				goto _loop206;
			}
			
		}
		_loop206:;
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
#line 1037 "vc.g"
	
		string mode = "out";
	
#line 892 "vcParser.cpp"
	
	try {      // for error handling
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == COLON)) {
				vc_Interface_Object_Declaration(sys,parent,mode);
			}
			else {
				goto _loop209;
			}
			
		}
		_loop209:;
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
#line 246 "vc.g"
	
		vcControlPath* cp;
	if(!pipeline_flag) 
	cp = new vcControlPath(m->Get_Id() + "_CP");
	else
	cp = new vcControlPathPipelined(m->Get_Id() + "_CP");
	
#line 926 "vcParser.cpp"
	
	try {      // for error handling
		match(CONTROLPATH);
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((_tokenSet_10.member(LA(1)))) {
				vc_CPRegion(cp);
			}
			else {
				goto _loop50;
			}
			
		}
		_loop50:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == ATTRIBUTE)) {
				vc_AttributeSpec(cp);
			}
			else {
				goto _loop52;
			}
			
		}
		_loop52:;
		} // ( ... )*
		match(RBRACE);
#line 254 "vc.g"
		m->Set_Control_Path(cp);
#line 958 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
}

void vcParser::vc_Datapath(
	vcSystem* sys,vcModule* m
) {
#line 527 "vc.g"
	
		vcDataPath* dp = new vcDataPath(m,m->Get_Id() + "_DP");
	
#line 973 "vcParser.cpp"
	
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
			case CALL:
			case IOPORT:
			case LOAD:
			case STORE:
			{
				vc_Guarded_Operator_Instantiation(sys,dp);
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
			default:
			{
				goto _loop129;
			}
			}
		}
		_loop129:;
		} // ( ... )*
		match(RBRACE);
#line 536 "vc.g"
		m->Set_Data_Path(dp);
#line 1060 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
}

void vcParser::vc_Link(
	vcModule* m
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  dpeid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 158 "vc.g"
	
	vcDatapathElement* dpe;
	vector<string> ref_vec;
	vector<vcTransition*> reqs;
	vector<vcTransition*> acks;
	
#line 1079 "vcParser.cpp"
	
	try {      // for error handling
		dpeid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 166 "vc.g"
		
		dpe = m->Get_Data_Path()->Find_DPE(dpeid->getText()); 
		NOT_FOUND__("datapath-element",dpe,dpeid->getText(),dpeid)
		
#line 1089 "vcParser.cpp"
		match(EQUIVALENT);
		match(LPAREN);
		{ // ( ... )+
		int _cnt36=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == ENTRY || LA(1) == EXIT)) {
				vc_Hierarchical_CP_Ref(ref_vec);
#line 173 "vc.g"
				
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
				
				
#line 1119 "vcParser.cpp"
			}
			else {
				if ( _cnt36>=1 ) { goto _loop36; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt36++;
		}
		_loop36:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt40=0;
		for (;;) {
			switch ( LA(1)) {
			case SIMPLE_IDENTIFIER:
			case ENTRY:
			case EXIT:
			{
				{
				vc_Hierarchical_CP_Ref(ref_vec);
#line 198 "vc.g"
				
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
				
				
				
#line 1165 "vcParser.cpp"
				}
				break;
			}
			case OPEN:
			{
				{
				match(OPEN);
#line 223 "vc.g"
				acks.push_back(NULL);
#line 1175 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				if ( _cnt40>=1 ) { goto _loop40; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt40++;
		}
		_loop40:;
		}  // ( ... )+
		match(RPAREN);
#line 226 "vc.g"
		m->Add_Link(dpe,reqs,acks);
#line 1191 "vcParser.cpp"
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
#line 233 "vc.g"
	
	string id;
	
#line 1208 "vcParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
				id=vc_Identifier();
#line 237 "vc.g"
				ref_vec.push_back(id);
#line 1217 "vcParser.cpp"
				match(DIV_OP);
			}
			else {
				goto _loop43;
			}
			
		}
		_loop43:;
		} // ( ... )*
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			{
			id=vc_Identifier();
#line 238 "vc.g"
			ref_vec.push_back(id);
#line 1235 "vcParser.cpp"
			}
			break;
		}
		case ENTRY:
		{
			{
			entry_id = LT(1);
			match(ENTRY);
#line 239 "vc.g"
			ref_vec.push_back(entry_id->getText());
#line 1246 "vcParser.cpp"
			}
			break;
		}
		case EXIT:
		{
			{
			exit_id = LT(1);
			match(EXIT);
#line 240 "vc.g"
			ref_vec.push_back(exit_id->getText());
#line 1257 "vcParser.cpp"
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
#line 1307 "vc.g"
	string s;
#line 1277 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1307 "vc.g"
		s = id->getText();
#line 1285 "vcParser.cpp"
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
#line 260 "vc.g"
	vcCPElement* cpe;
#line 1337 "vcParser.cpp"
	
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
#line 267 "vc.g"
	vcCPElement* cpe;
#line 1373 "vcParser.cpp"
#line 267 "vc.g"
	
	string id;
	
#line 1378 "vcParser.cpp"
	
	try {      // for error handling
		match(PLACE);
		id=vc_Label();
#line 272 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		cpe = (vcCPElement*) new vcPlace(p, id,0);
		
#line 1389 "vcParser.cpp"
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
#line 283 "vc.g"
	vcCPElement* cpe;
#line 1403 "vcParser.cpp"
#line 283 "vc.g"
	
	string id;
	bool dead_flag = false;
	
#line 1409 "vcParser.cpp"
	
	try {      // for error handling
		match(TRANSITION);
		id=vc_Label();
		{
		switch ( LA(1)) {
		case DEAD:
		{
			match(DEAD);
#line 288 "vc.g"
			dead_flag = true;
#line 1421 "vcParser.cpp"
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
#line 289 "vc.g"
		
		cpe = NULL;
		if(p->Find_CPElement(id) == NULL) 
		{
		cpe = (vcCPElement*) (new vcTransition(p,id));
			((vcTransition*)cpe)->Set_Is_Dead(dead_flag);
		}
		
#line 1452 "vcParser.cpp"
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
#line 313 "vc.g"
	
		string lbl;
		vcCPSeriesBlock* sb;
		vcCPElement* cpe;
	
#line 1470 "vcParser.cpp"
	
	try {      // for error handling
		match(SERIESBLOCK);
		lbl=vc_Label();
#line 319 "vc.g"
		sb = new vcCPSeriesBlock(cp,lbl);
#line 1477 "vcParser.cpp"
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case PLACE:
			case TRANSITION:
			{
				{
				cpe=vc_CPElement(sb);
#line 320 "vc.g"
				sb->Add_CPElement(cpe);
#line 1489 "vcParser.cpp"
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
				goto _loop64;
			}
			}
		}
		_loop64:;
		} // ( ... )*
		match(RBRACE);
#line 322 "vc.g"
		cp->Add_CPElement(sb);
#line 1514 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_19);
	}
}

void vcParser::vc_CPParallelBlock(
	vcCPBlock* cp
) {
#line 328 "vc.g"
	
		string lbl;
		vcCPParallelBlock* sb;
		vcCPElement* cpe;
	vcCPElement* t;
	
#line 1532 "vcParser.cpp"
	
	try {      // for error handling
		match(PARALLELBLOCK);
		lbl=vc_Label();
#line 335 "vc.g"
		sb = new vcCPParallelBlock(cp,lbl);
#line 1539 "vcParser.cpp"
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
#line 336 "vc.g"
				sb->Add_CPElement(t);
#line 1557 "vcParser.cpp"
				break;
			}
			default:
			{
				goto _loop67;
			}
			}
		}
		_loop67:;
		} // ( ... )*
		match(RBRACE);
#line 337 "vc.g"
		cp->Add_CPElement(sb);
#line 1571 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPBranchBlock(
	vcCPBlock* cp
) {
#line 344 "vc.g"
	
		string lbl;
		vcCPBranchBlock* sb;
		vcCPElement* cpe;
	
#line 1588 "vcParser.cpp"
	
	try {      // for error handling
		match(BRANCHBLOCK);
		lbl=vc_Label();
#line 350 "vc.g"
		sb = new vcCPBranchBlock(cp,lbl);
#line 1595 "vcParser.cpp"
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
			case PLACE:
			{
				{
				cpe=vc_CPPlace(sb);
#line 354 "vc.g"
				sb->Add_CPElement(cpe);
#line 1617 "vcParser.cpp"
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
				if ( _cnt74>=1 ) { goto _loop74; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			}
			_cnt74++;
		}
		_loop74:;
		}  // ( ... )+
		match(RBRACE);
#line 355 "vc.g"
		cp->Add_CPElement(sb);
#line 1643 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_15);
	}
}

void vcParser::vc_CPForkBlock(
	vcCPBlock* cp
) {
#line 442 "vc.g"
	
		string lbl;
		vcCPForkBlock* fb;
		vcCPElement* cpe;
	
#line 1660 "vcParser.cpp"
	
	try {      // for error handling
		match(FORKBLOCK);
		lbl=vc_Label();
#line 448 "vc.g"
		fb = new vcCPForkBlock(cp,lbl);
#line 1667 "vcParser.cpp"
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
#line 452 "vc.g"
				fb->Add_CPElement(cpe);
#line 1688 "vcParser.cpp"
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
				goto _loop94;
			}
			}
		}
		_loop94:;
		} // ( ... )*
		match(RBRACE);
#line 453 "vc.g"
		cp->Add_CPElement(fb);
#line 1713 "vcParser.cpp"
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
#line 429 "vc.g"
	
		string lbl,b;
		vector<string> branch_ids;
	
#line 1730 "vcParser.cpp"
	
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
#line 435 "vc.g"
			branch_ids.push_back(e->getText());
#line 1744 "vcParser.cpp"
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
#line 436 "vc.g"
				branch_ids.push_back(b);
#line 1764 "vcParser.cpp"
			}
			else {
				goto _loop87;
			}
			
		}
		_loop87:;
		} // ( ... )*
#line 436 "vc.g"
		bb->Add_Branch_Point(lbl,branch_ids);
#line 1775 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_20);
	}
}

void vcParser::vc_CPMerge(
	vcCPBranchBlock* bb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 414 "vc.g"
	
		string lbl,mid;
		string merge_region;
	
#line 1793 "vcParser.cpp"
	
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
#line 420 "vc.g"
			bb->Add_Merge_Point(lbl,e->getText());
#line 1807 "vcParser.cpp"
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
#line 421 "vc.g"
				bb->Add_Merge_Point(lbl,mid);
#line 1827 "vcParser.cpp"
			}
			else {
				goto _loop83;
			}
			
		}
		_loop83:;
		} // ( ... )*
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_21);
	}
}

void vcParser::vc_CPSimpleLoopBlock(
	vcCPBlock* cp
) {
#line 361 "vc.g"
	
		string lbl;
		vcCPSimpleLoopBlock* sb;
		vcCPElement* cpe;
	
#line 1853 "vcParser.cpp"
	
	try {      // for error handling
		match(LOOPBLOCK);
		lbl=vc_Label();
#line 367 "vc.g"
		sb = new vcCPSimpleLoopBlock(cp,lbl);
#line 1860 "vcParser.cpp"
		match(LBRACE);
		{
		cpe=vc_CPPlace(sb);
#line 368 "vc.g"
		sb->Add_CPElement(cpe);
#line 1866 "vcParser.cpp"
		}
		{
		cpe=vc_CPPlace(sb);
#line 369 "vc.g"
		sb->Add_CPElement(cpe);
#line 1872 "vcParser.cpp"
		}
		vc_CPPipelinedForkBlock(sb);
		vc_CPSeriesBlock(sb);
		vc_CPSeriesBlock(sb);
		vc_CPBind(sb);
		vc_CPBranch(sb);
		vc_CPMerge(sb);
		vc_CPLoopTerminate(sb);
		match(RBRACE);
#line 378 "vc.g"
		cp->Add_CPElement(sb);
#line 1884 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
}

void vcParser::vc_CPPipelinedForkBlock(
	vcCPBlock* cp
) {
#line 460 "vc.g"
	
		string lbl;
		vcCPPipelinedForkBlock* fb;
		vcCPElement* cpe;
	string internal_id, external_id;
	bool pipeline_flag = false;
	
#line 1903 "vcParser.cpp"
	
	try {      // for error handling
		match(PIPELINE);
		lbl=vc_Label();
#line 468 "vc.g"
		fb = new vcCPPipelinedForkBlock(cp,lbl);
#line 1910 "vcParser.cpp"
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
#line 473 "vc.g"
				fb->Add_CPElement(cpe);
#line 1931 "vcParser.cpp"
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
				else if ((LA(1) == SIMPLE_IDENTIFIER || LA(1) == EXIT) && (LA(2) == MARKEDJOIN)) {
					{
					vc_CPMarkedJoin(fb);
					}
				}
			else {
				goto _loop102;
			}
			}
		}
		_loop102:;
		} // ( ... )*
		match(RBRACE);
#line 474 "vc.g"
		cp->Add_CPElement(fb);
#line 1961 "vcParser.cpp"
		{
		switch ( LA(1)) {
		case LPAREN:
		{
			match(LPAREN);
			{ // ( ... )+
			int _cnt105=0;
			for (;;) {
				if ((LA(1) == SIMPLE_IDENTIFIER)) {
					internal_id=vc_Identifier();
#line 475 "vc.g"
					fb->Add_Export(internal_id);
#line 1974 "vcParser.cpp"
				}
				else {
					if ( _cnt105>=1 ) { goto _loop105; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
				}
				
				_cnt105++;
			}
			_loop105:;
			}  // ( ... )+
			match(RPAREN);
			break;
		}
		case SERIESBLOCK:
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
		recover(ex,_tokenSet_22);
	}
}

void vcParser::vc_CPBind(
	vcCPSimpleLoopBlock* cp
) {
#line 401 "vc.g"
	
		string pl_lbl, rgn_label, rgn_internal_lbl;
	
#line 2011 "vcParser.cpp"
	
	try {      // for error handling
		match(BIND);
		pl_lbl=vc_Identifier();
		rgn_label=vc_Identifier();
		match(COLON);
		rgn_internal_lbl=vc_Identifier();
#line 406 "vc.g"
		
			cp->Bind(pl_lbl,rgn_label,rgn_internal_lbl);
		
#line 2023 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_23);
	}
}

void vcParser::vc_CPLoopTerminate(
	vcCPSimpleLoopBlock* slb
) {
#line 384 "vc.g"
	
		string loop_exit, loop_taken, loop_body, loop_back;
	
#line 2038 "vcParser.cpp"
	
	try {      // for error handling
		match(TERMINATE);
		match(LPAREN);
		loop_exit=vc_Identifier();
		loop_taken=vc_Identifier();
		loop_body=vc_Identifier();
		match(RPAREN);
		match(LPAREN);
		loop_back=vc_Identifier();
		match(RPAREN);
#line 395 "vc.g"
		slb->Set_Loop_Termination_Information(loop_exit, loop_taken, loop_body, loop_back);
#line 2052 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_24);
	}
}

void vcParser::vc_CPFork(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  fe = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 510 "vc.g"
	
		string lbl,b;
		vector<string> fork_ids;
	
#line 2070 "vcParser.cpp"
	
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
#line 517 "vc.g"
			lbl = fe->getText();
#line 2089 "vcParser.cpp"
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
#line 517 "vc.g"
			fork_ids.push_back(e->getText());
#line 2109 "vcParser.cpp"
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
#line 518 "vc.g"
				fork_ids.push_back(b);
#line 2129 "vcParser.cpp"
			}
			else {
				goto _loop126;
			}
			
		}
		_loop126:;
		} // ( ... )*
		match(RPAREN);
#line 519 "vc.g"
		fb->Add_Fork_Point(lbl,fork_ids);
#line 2141 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPJoin(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 482 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 2159 "vcParser.cpp"
	
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
#line 488 "vc.g"
			lbl = je->getText();
#line 2178 "vcParser.cpp"
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
#line 488 "vc.g"
			join_ids.push_back(e->getText());
#line 2198 "vcParser.cpp"
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
#line 489 "vc.g"
				join_ids.push_back(b);
#line 2218 "vcParser.cpp"
			}
			else {
				goto _loop112;
			}
			
		}
		_loop112:;
		} // ( ... )*
		match(RPAREN);
#line 490 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 2230 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_CPMarkedJoin(
	vcCPForkBlock* fb
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  je = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  e = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 496 "vc.g"
	
		string lbl,b;
		vector<string> join_ids;
	
#line 2248 "vcParser.cpp"
	
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
#line 502 "vc.g"
			lbl = je->getText();
#line 2267 "vcParser.cpp"
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
#line 502 "vc.g"
			join_ids.push_back(e->getText());
#line 2287 "vcParser.cpp"
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
#line 503 "vc.g"
				join_ids.push_back(b);
#line 2307 "vcParser.cpp"
			}
			else {
				goto _loop119;
			}
			
		}
		_loop119:;
		} // ( ... )*
		match(RPAREN);
#line 504 "vc.g"
		fb->Add_Join_Point(lbl,join_ids);
#line 2319 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_25);
	}
}

void vcParser::vc_Guarded_Operator_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  gid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 542 "vc.g"
	
		vcWire* guard_wire = NULL;
		bool guard_complement = false;
		string gwid;
		vcDatapathElement* dpe = NULL;
	
#line 2338 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case DIV_OP:
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
#line 553 "vc.g"
				guard_complement = true;
#line 2421 "vcParser.cpp"
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
#line 553 "vc.g"
			guard_wire = dp->Find_Wire(gwid); NOT_FOUND__("wire",guard_wire, gwid,gid)
#line 2437 "vcParser.cpp"
			match(RPAREN);
			break;
		}
		case RBRACE:
		case DIV_OP:
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
#line 555 "vc.g"
		
				if((dpe != NULL) && (guard_wire != NULL))
				{
					dpe->Set_Guard_Wire(guard_wire);
					dpe->Set_Guard_Complement(guard_complement);
				}
			
#line 2507 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

void vcParser::vc_Branch_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  br_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 691 "vc.g"
	
	vcBranch* new_op = NULL;
	string id;
	string wid;
	vector<vcWire*> wires;
	vcWire* x;
	
#line 2527 "vcParser.cpp"
	
	try {      // for error handling
		br_id = LT(1);
		match(BRANCH_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt176=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 702 "vc.g"
				x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,br_id)
				wires.push_back(x);
#line 2542 "vcParser.cpp"
			}
			else {
				if ( _cnt176>=1 ) { goto _loop176; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt176++;
		}
		_loop176:;
		}  // ( ... )+
		match(RPAREN);
#line 705 "vc.g"
		new_op = new vcBranch(id,wires); dp->Add_Branch(new_op);
#line 2555 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

void vcParser::vc_Phi_Instantiation(
	vcDataPath* dp
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  p_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 992 "vc.g"
	
	string lbl;
	string id;
	vcWire* tw;
	vcWire* outwire;
	vcPhi* phi;
	vector<vcWire*> inwires;
	
#line 2576 "vcParser.cpp"
	
	try {      // for error handling
		p_id = LT(1);
		match(PHI);
		lbl=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt201=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				id=vc_Identifier();
#line 1001 "vc.g"
				tw = dp->Find_Wire(id); 
				NOT_FOUND__("wire",tw,id,p_id);
				inwires.push_back(tw);
#line 2592 "vcParser.cpp"
			}
			else {
				if ( _cnt201>=1 ) { goto _loop201; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt201++;
		}
		_loop201:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		id=vc_Identifier();
#line 1006 "vc.g"
		
		outwire = dp->Find_Wire(id); 
		NOT_FOUND__("wire",outwire,id,p_id);
		phi = new vcPhi(lbl,inwires, outwire); 
		dp->Add_Phi(phi);
		
#line 2612 "vcParser.cpp"
		match(RPAREN);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

vcDatapathElement*  vcParser::vc_Operator_Instantiation(
	vcDataPath* dp
) {
#line 567 "vc.g"
	vcDatapathElement* dpe;
#line 2626 "vcParser.cpp"
	
	try {      // for error handling
		{
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
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Call_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 840 "vc.g"
	vcDatapathElement* dpe;
#line 2712 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid1 = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid2 = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 840 "vc.g"
	
	bool inline_flag;
	vcCall* nc = NULL;
	string id;
	string mid;
	vcModule* m;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	
#line 2726 "vcParser.cpp"
	
	try {      // for error handling
		cid = LT(1);
		match(CALL);
		{
		switch ( LA(1)) {
		case INLINE:
		{
			match(INLINE);
#line 851 "vc.g"
			inline_flag = true;
#line 2738 "vcParser.cpp"
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
#line 852 "vc.g"
		m = sys->Find_Module(mid); NOT_FOUND__("module",m,mid,cid)
#line 2756 "vcParser.cpp"
		lpid1 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 853 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid1)
				inwires.push_back(w);
#line 2767 "vcParser.cpp"
			}
			else {
				goto _loop188;
			}
			
		}
		_loop188:;
		} // ( ... )*
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				mid=vc_Identifier();
#line 856 "vc.g"
				vcWire* w = dp->Find_Wire(mid); 
				NOT_FOUND__("wire",w,mid,lpid2)
				outwires.push_back(w);
#line 2787 "vcParser.cpp"
			}
			else {
				goto _loop190;
			}
			
		}
		_loop190:;
		} // ( ... )*
		match(RPAREN);
#line 859 "vc.g"
		
			 nc = new vcCall(id, m, inwires, outwires, inline_flag); dp->Add_Call(nc); 
			 dpe = (vcDatapathElement*) nc;
			
#line 2802 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_IOPort_Instantiation(
	vcDataPath* dp
) {
#line 868 "vc.g"
	vcDatapathElement* dpe;
#line 2816 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ipid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lpid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 868 "vc.g"
	
	string id, in_id, out_id, pipe_id;
	vcWire* w;
	vcPipe* p = NULL;
	bool in_flag = false;
	
#line 2826 "vcParser.cpp"
	
	try {      // for error handling
		ipid = LT(1);
		match(IOPORT);
		{
		switch ( LA(1)) {
		case IN:
		{
			{
			match(IN);
#line 875 "vc.g"
			in_flag = true;
#line 2839 "vcParser.cpp"
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
#line 877 "vc.g"
		
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
			
		
#line 2900 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_LoadStore_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 919 "vc.g"
	vcDatapathElement* dpe;
#line 2914 "vcParser.cpp"
	
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
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_BinaryOperator_Instantiation(
	vcDataPath* dp
) {
#line 581 "vc.g"
	vcDatapathElement* dpe;
#line 2946 "vcParser.cpp"
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
#line 581 "vc.g"
	
	vcBinarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 2985 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case PLUS_OP:
		{
			{
			plus_id = LT(1);
			match(PLUS_OP);
#line 593 "vc.g"
			op_id = plus_id->getText();
#line 2997 "vcParser.cpp"
			}
			break;
		}
		case MINUS_OP:
		{
			{
			minus_id = LT(1);
			match(MINUS_OP);
#line 594 "vc.g"
			op_id = minus_id->getText();
#line 3008 "vcParser.cpp"
			}
			break;
		}
		case MUL_OP:
		{
			{
			mul_id = LT(1);
			match(MUL_OP);
#line 595 "vc.g"
			op_id = mul_id->getText();
#line 3019 "vcParser.cpp"
			}
			break;
		}
		case DIV_OP:
		{
			{
			div_id = LT(1);
			match(DIV_OP);
#line 596 "vc.g"
			op_id = div_id->getText();
#line 3030 "vcParser.cpp"
			}
			break;
		}
		case SHL_OP:
		{
			{
			shl_id = LT(1);
			match(SHL_OP);
#line 597 "vc.g"
			op_id = shl_id->getText();
#line 3041 "vcParser.cpp"
			}
			break;
		}
		case SHR_OP:
		{
			{
			shr_id = LT(1);
			match(SHR_OP);
#line 598 "vc.g"
			op_id = shr_id->getText();
#line 3052 "vcParser.cpp"
			}
			break;
		}
		case UGT_OP:
		{
			{
			gt_id = LT(1);
			match(UGT_OP);
#line 599 "vc.g"
			op_id = gt_id->getText();
#line 3063 "vcParser.cpp"
			}
			break;
		}
		case UGE_OP:
		{
			{
			ge_id = LT(1);
			match(UGE_OP);
#line 600 "vc.g"
			op_id = ge_id->getText();
#line 3074 "vcParser.cpp"
			}
			break;
		}
		case EQ_OP:
		{
			{
			eq_id = LT(1);
			match(EQ_OP);
#line 601 "vc.g"
			op_id = eq_id->getText();
#line 3085 "vcParser.cpp"
			}
			break;
		}
		case ULT_OP:
		{
			{
			lt_id = LT(1);
			match(ULT_OP);
#line 602 "vc.g"
			op_id = lt_id->getText();
#line 3096 "vcParser.cpp"
			}
			break;
		}
		case ULE_OP:
		{
			{
			le_id = LT(1);
			match(ULE_OP);
#line 603 "vc.g"
			op_id = le_id->getText();
#line 3107 "vcParser.cpp"
			}
			break;
		}
		case NEQ_OP:
		{
			{
			neq_id = LT(1);
			match(NEQ_OP);
#line 604 "vc.g"
			op_id = neq_id->getText();
#line 3118 "vcParser.cpp"
			}
			break;
		}
		case BITSEL_OP:
		{
			{
			bitsel_id = LT(1);
			match(BITSEL_OP);
#line 605 "vc.g"
			op_id = bitsel_id->getText();
#line 3129 "vcParser.cpp"
			}
			break;
		}
		case CONCAT_OP:
		{
			{
			concat_id = LT(1);
			match(CONCAT_OP);
#line 606 "vc.g"
			op_id = concat_id->getText();
#line 3140 "vcParser.cpp"
			}
			break;
		}
		case OR_OP:
		{
			{
			or_id = LT(1);
			match(OR_OP);
#line 607 "vc.g"
			op_id = or_id->getText();
#line 3151 "vcParser.cpp"
			}
			break;
		}
		case AND_OP:
		{
			{
			and_id = LT(1);
			match(AND_OP);
#line 608 "vc.g"
			op_id = and_id->getText();
#line 3162 "vcParser.cpp"
			}
			break;
		}
		case XOR_OP:
		{
			{
			xor_id = LT(1);
			match(XOR_OP);
#line 609 "vc.g"
			op_id = xor_id->getText();
#line 3173 "vcParser.cpp"
			}
			break;
		}
		case NOR_OP:
		{
			{
			nor_id = LT(1);
			match(NOR_OP);
#line 610 "vc.g"
			op_id = nor_id->getText();
#line 3184 "vcParser.cpp"
			}
			break;
		}
		case NAND_OP:
		{
			{
			nand_id = LT(1);
			match(NAND_OP);
#line 611 "vc.g"
			op_id = nand_id->getText();
#line 3195 "vcParser.cpp"
			}
			break;
		}
		case XNOR_OP:
		{
			{
			xnor_id = LT(1);
			match(XNOR_OP);
#line 612 "vc.g"
			op_id = xnor_id->getText();
#line 3206 "vcParser.cpp"
			}
			break;
		}
		case SHRA_OP:
		{
			{
			shra_id = LT(1);
			match(SHRA_OP);
#line 613 "vc.g"
			op_id = shra_id->getText();
#line 3217 "vcParser.cpp"
			}
			break;
		}
		case SGT_OP:
		{
			{
			sgt_id = LT(1);
			match(SGT_OP);
#line 614 "vc.g"
			op_id = sgt_id->getText();
#line 3228 "vcParser.cpp"
			}
			break;
		}
		case SGE_OP:
		{
			{
			sge_id = LT(1);
			match(SGE_OP);
#line 615 "vc.g"
			op_id = sge_id->getText();
#line 3239 "vcParser.cpp"
			}
			break;
		}
		case SLT_OP:
		{
			{
			slt_id = LT(1);
			match(SLT_OP);
#line 616 "vc.g"
			op_id = slt_id->getText();
#line 3250 "vcParser.cpp"
			}
			break;
		}
		case SLE_OP:
		{
			{
			sle_id = LT(1);
			match(SLE_OP);
#line 617 "vc.g"
			op_id = sle_id->getText();
#line 3261 "vcParser.cpp"
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
#line 620 "vc.g"
		
		x = dp->Find_Wire(wid);
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 3280 "vcParser.cpp"
		wid=vc_Identifier();
#line 625 "vc.g"
		
		y = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", y,wid,lpid)
		
		
#line 3288 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 633 "vc.g"
		
		z = dp->Find_Wire(wid);
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 3298 "vcParser.cpp"
		match(RPAREN);
#line 638 "vc.g"
		new_op = new vcBinarySplitOperator(id,op_id,x,y,z); dp->Add_Split_Operator(new_op); 
			dpe = (vcDatapathElement*)new_op;
#line 3303 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_UnaryOperator_Instantiation(
	vcDataPath* dp
) {
#line 647 "vc.g"
	vcDatapathElement* dpe;
#line 3317 "vcParser.cpp"
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
#line 647 "vc.g"
	
	vcUnarySplitOperator* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* x = NULL;
	vcWire* z = NULL;
	
#line 3338 "vcParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case NOT_OP:
		{
			{
			not_id = LT(1);
			match(NOT_OP);
#line 659 "vc.g"
			op_id = not_id->getText();
#line 3350 "vcParser.cpp"
			}
			break;
		}
		case StoS_ASSIGN_OP:
		{
			{
			ss_assign_id = LT(1);
			match(StoS_ASSIGN_OP);
#line 660 "vc.g"
			op_id = ss_assign_id->getText();
#line 3361 "vcParser.cpp"
			}
			break;
		}
		case StoU_ASSIGN_OP:
		{
			{
			su_assign_id = LT(1);
			match(StoU_ASSIGN_OP);
#line 661 "vc.g"
			op_id = su_assign_id->getText();
#line 3372 "vcParser.cpp"
			}
			break;
		}
		case UtoS_ASSIGN_OP:
		{
			{
			us_assign_id = LT(1);
			match(UtoS_ASSIGN_OP);
#line 662 "vc.g"
			op_id = us_assign_id->getText();
#line 3383 "vcParser.cpp"
			}
			break;
		}
		case FtoS_ASSIGN_OP:
		{
			{
			fs_assign_id = LT(1);
			match(FtoS_ASSIGN_OP);
#line 663 "vc.g"
			op_id = fs_assign_id->getText();
#line 3394 "vcParser.cpp"
			}
			break;
		}
		case FtoU_ASSIGN_OP:
		{
			{
			fu_assign_id = LT(1);
			match(FtoU_ASSIGN_OP);
#line 664 "vc.g"
			op_id = fu_assign_id->getText();
#line 3405 "vcParser.cpp"
			}
			break;
		}
		case StoF_ASSIGN_OP:
		{
			{
			sf_assign_id = LT(1);
			match(StoF_ASSIGN_OP);
#line 665 "vc.g"
			op_id = sf_assign_id->getText();
#line 3416 "vcParser.cpp"
			}
			break;
		}
		case UtoF_ASSIGN_OP:
		{
			{
			uf_assign_id = LT(1);
			match(UtoF_ASSIGN_OP);
#line 666 "vc.g"
			op_id = uf_assign_id->getText();
#line 3427 "vcParser.cpp"
			}
			break;
		}
		case FtoF_ASSIGN_OP:
		{
			{
			ff_assign_id = LT(1);
			match(FtoF_ASSIGN_OP);
#line 667 "vc.g"
			op_id = ff_assign_id->getText();
#line 3438 "vcParser.cpp"
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
#line 670 "vc.g"
		
		x = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",x,wid,lpid)
		
#line 3457 "vcParser.cpp"
		match(RPAREN);
		lpid2 = LT(1);
		match(LPAREN);
		wid=vc_Identifier();
#line 677 "vc.g"
		
		z = dp->Find_Wire(wid); 
		NOT_FOUND__("wire", z,wid,lpid2)
		
#line 3467 "vcParser.cpp"
		match(RPAREN);
#line 682 "vc.g"
		
			new_op = new vcUnarySplitOperator(id,op_id,x,z); dp->Add_Split_Operator(new_op);
			dpe = (vcDatapathElement*) new_op;
		
#line 3474 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Select_Instantiation(
	vcDataPath* dp
) {
#line 712 "vc.g"
	vcDatapathElement* dpe;
#line 3488 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sel_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 712 "vc.g"
	
	vcSelect* new_op = NULL;
	string id;
	string op_id;
	string wid;
	vcWire* sel = NULL;
	vcWire* x = NULL;
	vcWire* y = NULL;
	vcWire* z = NULL;
	vcValue* val = NULL;
	
#line 3502 "vcParser.cpp"
	
	try {      // for error handling
		sel_id = LT(1);
		match(SELECT_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 727 "vc.g"
		sel = dp->Find_Wire(wid); NOT_FOUND__("wire",sel,wid,sel_id)
#line 3512 "vcParser.cpp"
		wid=vc_Identifier();
#line 728 "vc.g"
		x = dp->Find_Wire(wid); NOT_FOUND__("wire",x,wid,sel_id)
#line 3516 "vcParser.cpp"
		wid=vc_Identifier();
#line 729 "vc.g"
		y = dp->Find_Wire(wid); NOT_FOUND__("wire",y,wid,sel_id)
#line 3520 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 732 "vc.g"
		z = dp->Find_Wire(wid); NOT_FOUND__("wire",z,wid,sel_id)
#line 3526 "vcParser.cpp"
		match(RPAREN);
#line 734 "vc.g"
		
			new_op = new vcSelect(id,sel,x,y,z); dp->Add_Select(new_op);   
			dpe = (vcDatapathElement*) new_op;
		
#line 3533 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Slice_Instantiation(
	vcDataPath* dp
) {
#line 745 "vc.g"
	vcDatapathElement* dpe;
#line 3547 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  slice_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 745 "vc.g"
	
	vcSlice* new_op = NULL;
	string id;
	string wid;
	int h, l;
	vcWire* sel = NULL;
	vcWire* din = NULL;
	vcWire* dout = NULL;
	
#line 3561 "vcParser.cpp"
	
	try {      // for error handling
		slice_id = LT(1);
		match(SLICE_OP);
		id=vc_Label();
		match(LPAREN);
		wid=vc_Identifier();
#line 758 "vc.g"
		din = dp->Find_Wire(wid); NOT_FOUND__("wire",din,wid,slice_id)
#line 3571 "vcParser.cpp"
		hid = LT(1);
		match(UINTEGER);
#line 759 "vc.g"
		h = atoi(hid->getText().c_str());
#line 3576 "vcParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 760 "vc.g"
		l = atoi(lid->getText().c_str());
#line 3581 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 763 "vc.g"
		dout = dp->Find_Wire(wid); NOT_FOUND__("wire",dout,wid,slice_id)
#line 3587 "vcParser.cpp"
		match(RPAREN);
#line 765 "vc.g"
		
			new_op = new vcSlice(id,din,dout,h,l); dp->Add_Slice(new_op);    
			dpe = (vcDatapathElement*) new_op;
		
#line 3594 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Register_Instantiation(
	vcDataPath* dp
) {
#line 776 "vc.g"
	vcDatapathElement* dpe;
#line 3608 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  as_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 776 "vc.g"
	
	vcRegister* new_reg = NULL;
	vcWire* x;
	vcWire* y;
	string id;
	string din;
	string dout;
	
#line 3619 "vcParser.cpp"
	
	try {      // for error handling
		as_id = LT(1);
		match(ASSIGN_OP);
		id=vc_Label();
		match(LPAREN);
		din=vc_Identifier();
#line 784 "vc.g"
		x = dp->Find_Wire(din); 
		NOT_FOUND__("wire",x,din,as_id)
#line 3630 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		dout=vc_Identifier();
#line 787 "vc.g"
		y = dp->Find_Wire(dout); 
		NOT_FOUND__("wire",y,dout,as_id)
#line 3637 "vcParser.cpp"
		match(RPAREN);
#line 790 "vc.g"
		
		new_reg = new vcRegister(id, x, y); dp->Add_Register(new_reg);
			dpe = (vcDatapathElement*) new_reg;
		
#line 3644 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Equivalence_Instantiation(
	vcDataPath* dp
) {
#line 801 "vc.g"
	vcDatapathElement* dpe;
#line 3658 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  eq_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 801 "vc.g"
	
	string id;
	vcEquivalence* nm = NULL;
	vector<vcWire*> inwires;
	vector<vcWire*> outwires;
	vcWire* w;
	string wid;
	
#line 3669 "vcParser.cpp"
	
	try {      // for error handling
		eq_id = LT(1);
		match(EQUIVALENCE_OP);
		id=vc_Label();
		match(LPAREN);
		{ // ( ... )+
		int _cnt182=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 813 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				inwires.push_back(w);
				
#line 3687 "vcParser.cpp"
			}
			else {
				if ( _cnt182>=1 ) { goto _loop182; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt182++;
		}
		_loop182:;
		}  // ( ... )+
		match(RPAREN);
		match(LPAREN);
		{ // ( ... )+
		int _cnt184=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				wid=vc_Identifier();
#line 821 "vc.g"
				
				w = dp->Find_Wire(wid); 
				NOT_FOUND__("wire",w,wid,eq_id) 
				outwires.push_back(w);
				
#line 3710 "vcParser.cpp"
			}
			else {
				if ( _cnt184>=1 ) { goto _loop184; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt184++;
		}
		_loop184:;
		}  // ( ... )+
		match(RPAREN);
#line 827 "vc.g"
		
		nm = new vcEquivalence(id,inwires,outwires);
		dp->Add_Equivalence(nm);
			    dpe = (vcDatapathElement*) nm;
		
#line 3727 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Load_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 928 "vc.g"
	vcDatapathElement* dpe;
#line 3741 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  ldid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 928 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
	
#line 3754 "vcParser.cpp"
	
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
#line 940 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),ldid)
		
#line 3779 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 944 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,ldid);
		
#line 3786 "vcParser.cpp"
		match(RPAREN);
		match(LPAREN);
		wid=vc_Identifier();
#line 947 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",data,wid,ldid);
		
#line 3794 "vcParser.cpp"
		match(RPAREN);
#line 950 "vc.g"
		
		vcLoad* nl = new vcLoad(id, ms, addr, data);
		dp->Add_Load(nl);
			 dpe = (vcDatapathElement*) nl;
		
#line 3802 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

vcDatapathElement*  vcParser::vc_Store_Instantiation(
	vcSystem* sys, vcDataPath* dp
) {
#line 961 "vc.g"
	vcDatapathElement* dpe;
#line 3816 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  st_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 961 "vc.g"
	
	string id, wid;
	string ms_id;
	string m_id = "";
	vcWire* addr;
	vcWire* data;
	vcMemorySpace* ms;
	bool is_load = false;
	
#line 3828 "vcParser.cpp"
	
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
#line 972 "vc.g"
		
		ms = sys->Find_Memory_Space(m_id,ms_id); 
		NOT_FOUND__("memory-space", ms, (m_id+"/"+ms_id),st_id)
		
#line 3853 "vcParser.cpp"
		match(LPAREN);
		wid=vc_Identifier();
#line 976 "vc.g"
		addr = dp->Find_Wire(wid); 
		NOT_FOUND__("wire",addr,wid,st_id);
		
#line 3860 "vcParser.cpp"
		wid=vc_Identifier();
#line 979 "vc.g"
		data = dp->Find_Wire(wid); 
		NOT_FOUND__("data",addr,wid,st_id);              
		
#line 3866 "vcParser.cpp"
		match(RPAREN);
#line 982 "vc.g"
		
		vcStore* ns = new vcStore(id, ms, addr, data);
		dp->Add_Store(ns);
			 dpe=(vcDatapathElement*)  ns;
		
#line 3874 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_26);
	}
	return dpe;
}

void vcParser::vc_Interface_Object_Declaration(
	vcSystem* sys, vcModule* parent, string mode
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1047 "vc.g"
	
		vcType* t;
		vcValue* v;
		string obj_name;
	
#line 3893 "vcParser.cpp"
	
	try {      // for error handling
		id = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1053 "vc.g"
		obj_name = id->getText();
#line 3900 "vcParser.cpp"
		match(COLON);
		t=vc_Type(sys);
#line 1054 "vc.g"
		
			parent->Add_Argument(obj_name,mode,t);
		
#line 3907 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
}

void vcParser::vc_Object_Declaration_Base(
	vcSystem* sys, vcType** t, string& obj_name, vcValue** v
) {
#line 1062 "vc.g"
	
		vcType* tt = NULL;
		vcValue* vv = NULL;
	string oname;
	
#line 3924 "vcParser.cpp"
	
	try {      // for error handling
		oname=vc_Label();
#line 1068 "vc.g"
		obj_name = oname;
#line 3930 "vcParser.cpp"
		match(COLON);
		tt=vc_Type(sys);
#line 1068 "vc.g"
		*t = tt;
#line 3935 "vcParser.cpp"
		{
		if ((LA(1) == ASSIGN_OP) && (LA(2) == LPAREN || LA(2) == BINARYSTRING || LA(2) == HEXSTRING)) {
			match(ASSIGN_OP);
			vv=vc_Value(*t);
		}
		else if ((_tokenSet_3.member(LA(1))) && (_tokenSet_27.member(LA(2)))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
#line 1069 "vc.g"
		if(v != NULL) *v = vv;
#line 3950 "vcParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
}

vcValue*  vcParser::vc_Value(
	vcType* t
) {
#line 1123 "vc.g"
	vcValue* v;
#line 3963 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1123 "vc.g"
	
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
	
#line 3988 "vcParser.cpp"
	
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
#line 1146 "vc.g"
				vstring = bid->getText(); format = "binary";
#line 4005 "vcParser.cpp"
				}
				break;
			}
			case HEXSTRING:
			{
				{
				hid = LT(1);
				match(HEXSTRING);
#line 1147 "vc.g"
				vstring = hid->getText(); format = "hexadecimal";
#line 4016 "vcParser.cpp"
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
			}
			}
			}
#line 1149 "vc.g"
			
				if(t->Is("vcIntType") || t->Is("vcPointerType"))
				   v = (vcValue*) (new vcIntValue((vcIntType*)t,vstring.substr(2),format));
			else if(t->Is("vcFloatType"))
				   v = (vcValue*) (new vcFloatValue((vcFloatType*)t,vstring.substr(2),format));
			
#line 4033 "vcParser.cpp"
			}
			break;
		}
		case LPAREN:
		{
			{
			sid = LT(1);
			match(LPAREN);
			ev=vc_Value(etypes[idx]);
#line 1158 "vc.g"
			evalues.push_back(ev);
#line 4045 "vcParser.cpp"
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == COMMA)) {
					match(COMMA);
#line 1159 "vc.g"
					if(t->Is("vcRecordType")) idx++;
#line 4052 "vcParser.cpp"
					ev=vc_Value(etypes[idx]);
#line 1159 "vc.g"
					evalues.push_back(ev);
#line 4056 "vcParser.cpp"
				}
				else {
					goto _loop224;
				}
				
			}
			_loop224:;
			} // ( ... )*
#line 1161 "vc.g"
			
			if(t->Is("vcRecordType")) 
			v = (vcValue*) (new vcRecordValue((vcRecordType*)t,evalues));
			else 
			if(t->Is("vcArrayType")) v = (vcValue*) (new vcArrayValue((vcArrayType*)t,evalues));
			else 
			vcSystem::Error("composite value specified for scalar type");
			
#line 4074 "vcParser.cpp"
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
		recover(ex,_tokenSet_28);
	}
	return v;
}

vcType*  vcParser::vc_ScalarType(
	vcSystem* sys
) {
#line 1183 "vc.g"
	vcType* t;
#line 4097 "vcParser.cpp"
	
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
#line 1225 "vc.g"
	vcType* t;
#line 4140 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  dim = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1225 "vc.g"
	
		vcArrayType* at;
		vcType* et;
		unsigned int dimension;
	
#line 4148 "vcParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		match(LBRACKET);
		dim = LT(1);
		match(UINTEGER);
#line 1230 "vc.g"
		dimension = atoi(dim->getText().c_str());
#line 4157 "vcParser.cpp"
		match(RBRACKET);
		match(OF);
		et=vc_Type(sys);
#line 1231 "vc.g"
		at = Make_Array_Type(et,dimension); t = (vcType*) at;
#line 4163 "vcParser.cpp"
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
#line 1237 "vc.g"
	vcType* t;
#line 4177 "vcParser.cpp"
#line 1237 "vc.g"
	
		vcRecordType* rt;
		vcType* et;
		vector<vcType*> etypes;
	
#line 4184 "vcParser.cpp"
	
	try {      // for error handling
		match(RECORD);
		{ // ( ... )+
		int _cnt242=0;
		for (;;) {
			if ((LA(1) == ULT_OP) && (_tokenSet_29.member(LA(2)))) {
				match(ULT_OP);
				{
				et=vc_Type(sys);
#line 1242 "vc.g"
				etypes.push_back(et);
#line 4197 "vcParser.cpp"
				}
				match(UGT_OP);
			}
			else {
				if ( _cnt242>=1 ) { goto _loop242; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt242++;
		}
		_loop242:;
		}  // ( ... )+
#line 1243 "vc.g"
		rt = Make_Record_Type(etypes); t = (vcType*) rt; etypes.clear();
#line 4211 "vcParser.cpp"
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
#line 1189 "vc.g"
	vcType* t;
#line 4225 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1189 "vc.g"
	
		vcIntType* it;
		unsigned int w;
	
#line 4232 "vcParser.cpp"
	
	try {      // for error handling
		match(INT);
		match(ULT_OP);
		i = LT(1);
		match(UINTEGER);
#line 1194 "vc.g"
		w = atoi(i->getText().c_str());
#line 4241 "vcParser.cpp"
		match(UGT_OP);
#line 1194 "vc.g"
		it = Make_Integer_Type(w); t = (vcType*)it;
#line 4245 "vcParser.cpp"
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
#line 1200 "vc.g"
	vcType* t;
#line 4259 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  cid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1200 "vc.g"
	
		vcFloatType* ft;
		unsigned int c,m;
	
#line 4267 "vcParser.cpp"
	
	try {      // for error handling
		match(FLOAT);
		match(ULT_OP);
		cid = LT(1);
		match(UINTEGER);
#line 1205 "vc.g"
		c = atoi(cid->getText().c_str());
#line 4276 "vcParser.cpp"
		match(COMMA);
		mid = LT(1);
		match(UINTEGER);
#line 1205 "vc.g"
		m = atoi(mid->getText().c_str());
#line 4282 "vcParser.cpp"
		match(UGT_OP);
#line 1206 "vc.g"
		ft = Make_Float_Type(c,m); t = (vcType*)ft;
#line 4286 "vcParser.cpp"
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
#line 1213 "vc.g"
	vcType* t;
#line 4300 "vcParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 1213 "vc.g"
	
		vcPointerType* pt;
	string scope_id, space_id;
	
#line 4308 "vcParser.cpp"
	
	try {      // for error handling
		match(POINTER);
		match(ULT_OP);
		{
		if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == DIV_OP)) {
			sid = LT(1);
			match(SIMPLE_IDENTIFIER);
			match(DIV_OP);
#line 1218 "vc.g"
			scope_id = sid->getText();
#line 4320 "vcParser.cpp"
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER) && (LA(2) == UGT_OP)) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
		mid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 1219 "vc.g"
		space_id = mid->getText(); pt = Make_Pointer_Type(sys, scope_id,space_id); t = (vcType*) pt;
#line 4333 "vcParser.cpp"
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
	"SERIESBLOCK",
	"PARALLELBLOCK",
	"BRANCHBLOCK",
	"LOOPBLOCK",
	"TERMINATE",
	"BIND",
	"MERGE",
	"BRANCH",
	"FORKBLOCK",
	"PIPELINE",
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

const unsigned long vcParser::_tokenSet_0_data_[] = { 2UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// EOF 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_0(_tokenSet_0_data_,6);
const unsigned long vcParser::_tokenSet_1_data_[] = { 786738UL, 0UL, 0UL, 8206UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE FOREIGN MODULE CONSTANT INTERMEDIATE WIRE 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_1(_tokenSet_1_data_,8);
const unsigned long vcParser::_tokenSet_2_data_[] = { 270272818UL, 8192UL, 0UL, 8206UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN MODULE SIMPLE_IDENTIFIER CONTROLPATH 
// DATAPATH CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_2(_tokenSet_2_data_,8);
const unsigned long vcParser::_tokenSet_3_data_[] = { 34343218UL, 4294934528UL, 1421869055UL, 8206UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN MODULE DIV_OP NOT_OP PLUS_OP 
// MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP ULE_OP NEQ_OP 
// BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP 
// SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP 
// FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP 
// BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT LOAD 
// STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_3(_tokenSet_3_data_,8);
const unsigned long vcParser::_tokenSet_4_data_[] = { 3965324352UL, 775UL, 671088640UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER LBRACE RBRACE COLON MODULE SIMPLE_IDENTIFIER LPAREN ENTRY EXIT 
// PLACE TRANSITION DEAD SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
// PIPELINE FROM TO 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_4(_tokenSet_4_data_,8);
const unsigned long vcParser::_tokenSet_5_data_[] = { 67584UL, 0UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE OBJECT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_5(_tokenSet_5_data_,8);
const unsigned long vcParser::_tokenSet_6_data_[] = { 33556480UL, 4294934528UL, 1421869055UL, 8206UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DIV_OP NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP 
// EQ_OP ULT_OP ULE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP 
// NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP 
// UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP 
// FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP 
// CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_6(_tokenSet_6_data_,8);
const unsigned long vcParser::_tokenSet_7_data_[] = { 303892786UL, 4294942720UL, 1455423487UL, 8206UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE OBJECT FOREIGN MODULE SIMPLE_IDENTIFIER 
// DIV_OP CONTROLPATH DATAPATH NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP 
// UGT_OP UGE_OP EQ_OP ULT_OP ULE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP 
// XOR_OP NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP 
// StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP 
// UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP 
// EQUIVALENCE_OP CALL IOPORT OUT LOAD STORE PHI CONSTANT INTERMEDIATE 
// WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_7(_tokenSet_7_data_,8);
const unsigned long vcParser::_tokenSet_8_data_[] = { 269486384UL, 8192UL, 33554432UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// OUT ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_8(_tokenSet_8_data_,8);
const unsigned long vcParser::_tokenSet_9_data_[] = { 269486384UL, 8192UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// LIFO PIPE MEMORYSPACE RBRACE SIMPLE_IDENTIFIER CONTROLPATH DATAPATH 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_9(_tokenSet_9_data_,8);
const unsigned long vcParser::_tokenSet_10_data_[] = { 0UL, 263UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_10(_tokenSet_10_data_,6);
const unsigned long vcParser::_tokenSet_11_data_[] = { 1050624UL, 8192UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER DATAPATH ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_11(_tokenSet_11_data_,8);
const unsigned long vcParser::_tokenSet_12_data_[] = { 1050624UL, 0UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_12(_tokenSet_12_data_,8);
const unsigned long vcParser::_tokenSet_13_data_[] = { 227540992UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RPAREN OPEN ENTRY EXIT 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_13(_tokenSet_13_data_,6);
const unsigned long vcParser::_tokenSet_14_data_[] = { 265420864UL, 7360UL, 0UL, 0UL, 0UL, 0UL };
// UINTEGER COLON SIMPLE_IDENTIFIER LPAREN RPAREN OPEN DIV_OP ENTRY EXIT 
// MERGE BRANCH JOIN MARKEDJOIN FORK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_14(_tokenSet_14_data_,6);
const unsigned long vcParser::_tokenSet_15_data_[] = { 1812989952UL, 263UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_15(_tokenSet_15_data_,8);
const unsigned long vcParser::_tokenSet_16_data_[] = { 1610614784UL, 263UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE PLACE TRANSITION SERIESBLOCK PARALLELBLOCK BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_16(_tokenSet_16_data_,6);
const unsigned long vcParser::_tokenSet_17_data_[] = { 1611663360UL, 775UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK PIPELINE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_17(_tokenSet_17_data_,6);
const unsigned long vcParser::_tokenSet_18_data_[] = { 1812989952UL, 263UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_18(_tokenSet_18_data_,6);
const unsigned long vcParser::_tokenSet_19_data_[] = { 1812989952UL, 295UL, 0UL, 8192UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT PLACE TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK BIND FORKBLOCK ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_19(_tokenSet_19_data_,8);
const unsigned long vcParser::_tokenSet_20_data_[] = { 537921536UL, 263UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_20(_tokenSet_20_data_,6);
const unsigned long vcParser::_tokenSet_21_data_[] = { 537921536UL, 279UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER PLACE SERIESBLOCK PARALLELBLOCK BRANCHBLOCK 
// TERMINATE FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_21(_tokenSet_21_data_,6);
const unsigned long vcParser::_tokenSet_22_data_[] = { 0UL, 1UL, 0UL, 0UL, 0UL, 0UL };
// SERIESBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_22(_tokenSet_22_data_,6);
const unsigned long vcParser::_tokenSet_23_data_[] = { 1048576UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_23(_tokenSet_23_data_,6);
const unsigned long vcParser::_tokenSet_24_data_[] = { 2048UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_24(_tokenSet_24_data_,6);
const unsigned long vcParser::_tokenSet_25_data_[] = { 1276119040UL, 263UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE SIMPLE_IDENTIFIER ENTRY EXIT TRANSITION SERIESBLOCK PARALLELBLOCK 
// BRANCHBLOCK FORKBLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_25(_tokenSet_25_data_,6);
const unsigned long vcParser::_tokenSet_26_data_[] = { 33556480UL, 4294950912UL, 1421869055UL, 8206UL, 0UL, 0UL, 0UL, 0UL };
// RBRACE DIV_OP GUARD NOT_OP PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP 
// UGE_OP EQ_OP ULT_OP ULE_OP NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP 
// NOR_OP NAND_OP XNOR_OP SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP 
// StoU_ASSIGN_OP UtoS_ASSIGN_OP FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP 
// UtoF_ASSIGN_OP FtoF_ASSIGN_OP BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP 
// EQUIVALENCE_OP CALL IOPORT LOAD STORE PHI CONSTANT INTERMEDIATE WIRE 
// ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_26(_tokenSet_26_data_,8);
const unsigned long vcParser::_tokenSet_27_data_[] = { 1575714UL, 0UL, 2202009600UL, 8200UL, 0UL, 0UL, 0UL, 0UL };
// EOF PIPE MEMORYSPACE UNORDERED RBRACE MODULE SIMPLE_IDENTIFIER INLINE 
// IN OUT LBRACKET WIRE ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_27(_tokenSet_27_data_,8);
const unsigned long vcParser::_tokenSet_28_data_[] = { 42731826UL, 4294934528UL, 1421869055UL, 8270UL, 0UL, 0UL, 0UL, 0UL };
// EOF LIFO PIPE MEMORYSPACE RBRACE FOREIGN MODULE RPAREN DIV_OP NOT_OP 
// PLUS_OP MINUS_OP MUL_OP SHL_OP SHR_OP UGT_OP UGE_OP EQ_OP ULT_OP ULE_OP 
// NEQ_OP BITSEL_OP CONCAT_OP OR_OP AND_OP XOR_OP NOR_OP NAND_OP XNOR_OP 
// SHRA_OP SGT_OP SGE_OP SLT_OP SLE_OP StoS_ASSIGN_OP StoU_ASSIGN_OP UtoS_ASSIGN_OP 
// FtoS_ASSIGN_OP FtoU_ASSIGN_OP StoF_ASSIGN_OP UtoF_ASSIGN_OP FtoF_ASSIGN_OP 
// BRANCH_OP SELECT_OP SLICE_OP ASSIGN_OP EQUIVALENCE_OP CALL IOPORT LOAD 
// STORE PHI CONSTANT INTERMEDIATE WIRE COMMA ATTRIBUTE 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_28(_tokenSet_28_data_,8);
const unsigned long vcParser::_tokenSet_29_data_[] = { 0UL, 0UL, 0UL, 6016UL, 0UL, 0UL, 0UL, 0UL };
// INT FLOAT POINTER ARRAY RECORD 
const ANTLR_USE_NAMESPACE(antlr)BitSet vcParser::_tokenSet_29(_tokenSet_29_data_,8);


