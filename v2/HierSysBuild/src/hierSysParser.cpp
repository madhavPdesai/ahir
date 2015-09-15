/* $ANTLR 2.7.7 (2006-11-01): "hierSys.g" -> "hierSysParser.cpp"$ */
#include "hierSysParser.hpp"
#include <antlr/NoViableAltException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/ASTFactory.hpp>
#line 11 "hierSys.g"


#line 10 "hierSysParser.cpp"
#line 1 "hierSys.g"
#line 12 "hierSysParser.cpp"
hierSysParser::hierSysParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,k)
{
}

hierSysParser::hierSysParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,3)
{
}

hierSysParser::hierSysParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

hierSysParser::hierSysParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,3)
{
}

hierSysParser::hierSysParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,3)
{
}

void hierSysParser::sys_Description(
	vector<hierSystem*>& sys_vec, map<string,pair<int,int> >&  global_pipe_map, set<string>& global_pipe_signals
) {
#line 54 "hierSys.g"
	
	
		hierSystem* sys = NULL;
	
#line 46 "hierSysParser.cpp"
	
	try {      // for error handling
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PIPE || LA(1) == LIFO)) {
				hier_system_Pipe_Declaration(global_pipe_map,global_pipe_signals);
			}
			else {
				goto _loop3;
			}
			
		}
		_loop3:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SYSTEM)) {
				sys=hier_System(sys_vec, global_pipe_map,global_pipe_signals);
#line 61 "hierSys.g"
				sys_vec.push_back(sys);
#line 67 "hierSysParser.cpp"
			}
			else {
				goto _loop5;
			}
			
		}
		_loop5:;
		} // ( ... )*
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_0);
	}
}

void hierSysParser::hier_system_Pipe_Declaration(
	map<string, pair<int,int> >& pipe_map, set<string>& signals
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  psid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 282 "hierSys.g"
	
	vector<string> oname_list;
	int pipe_depth = 1;
	int pipe_width = 0;
	
	bool lifo_flag = false;
	bool in_mode = false;
	bool out_mode = false;
	bool is_port = false;
	bool is_signal = false;
	bool is_synch  = false;
	
#line 103 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case LIFO:
		{
			lid = LT(1);
			match(LIFO);
#line 295 "hierSys.g"
			std::cerr << "Warning: lifo flag ignored.. line number " << lid->getLine() << endl;
#line 114 "hierSysParser.cpp"
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
		{ // ( ... )+
		int _cnt39=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				psid = LT(1);
				match(SIMPLE_IDENTIFIER);
#line 297 "hierSys.g"
				oname_list.push_back(psid->getText());
#line 136 "hierSysParser.cpp"
			}
			else {
				if ( _cnt39>=1 ) { goto _loop39; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt39++;
		}
		_loop39:;
		}  // ( ... )+
		match(COLON);
		match(UINT);
		match(LESS);
		wid = LT(1);
		match(UINTEGER);
		match(GREATER);
#line 299 "hierSys.g"
		pipe_width = atoi(wid->getText().c_str());
#line 154 "hierSysParser.cpp"
		{
		switch ( LA(1)) {
		case DEPTH:
		{
			match(DEPTH);
			did = LT(1);
			match(UINTEGER);
#line 300 "hierSys.g"
			pipe_depth = atoi(did->getText().c_str());
#line 164 "hierSysParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case SYSTEM:
		case PIPE:
		case SIGNAL:
		case LIFO:
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
#line 301 "hierSys.g"
			is_signal = true;
#line 188 "hierSysParser.cpp"
			break;
		}
		case ANTLR_USE_NAMESPACE(antlr)Token::EOF_TYPE:
		case SYSTEM:
		case PIPE:
		case LIFO:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 302 "hierSys.g"
		
		for(int I = 0, fI = oname_list.size(); I < fI; I++)
		{
		string oname = oname_list[I];
		
		addPipeToGlobalMaps(oname, pipe_map, signals,  pipe_width, pipe_depth, is_signal);
		
		}
		
		
#line 215 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_1);
	}
}

hierSystem*  hierSysParser::hier_System(
	vector<hierSystem*>& sys_vector, map<string,pair<int,int> >&  global_pipe_map, set<string>& global_pipe_signals
) {
#line 67 "hierSys.g"
	hierSystem* sys;
#line 228 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sysid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  libid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sidi = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  uidi = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  didi = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sido = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  uido = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  dido = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  sidint = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  uidint = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  didint = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 67 "hierSys.g"
	
		sys =  NULL;
	
		hierSystemInstance* subsys    = NULL;
		rtlThread*   subthread = NULL;
		rtlString*   ti = NULL;
	
		bool signal_flag = false;
		string lib_id = "work";
		int depth = 1;
		int pipe_width = 0;
	
#line 253 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		match(SYSTEM);
		sysid = LT(1);
		match(SIMPLE_IDENTIFIER);
		{
		switch ( LA(1)) {
		case LIBRARY:
		{
			match(LIBRARY);
			libid = LT(1);
			match(SIMPLE_IDENTIFIER);
#line 85 "hierSys.g"
			lib_id = libid->getText();
#line 269 "hierSysParser.cpp"
			break;
		}
		case IN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 86 "hierSys.g"
		
					sys = new hierSystem(sysid->getText());
					sys->Set_Library(lib_id);
				
#line 287 "hierSysParser.cpp"
		}
		match(IN);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PIPE || LA(1) == SIGNAL)) {
				{
				switch ( LA(1)) {
				case PIPE:
				{
					match(PIPE);
					break;
				}
				case SIGNAL:
				{
					{
					match(SIGNAL);
#line 95 "hierSys.g"
					signal_flag = true;
#line 306 "hierSysParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				sidi = LT(1);
				match(SIMPLE_IDENTIFIER);
				{
				switch ( LA(1)) {
				case UINTEGER:
				{
					uidi = LT(1);
					match(UINTEGER);
#line 96 "hierSys.g"
					pipe_width = atoi(uidi->getText().c_str());
#line 326 "hierSysParser.cpp"
					break;
				}
				case PIPE:
				case SIGNAL:
				case DEPTH:
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
				case DEPTH:
				{
					match(DEPTH);
					didi = LT(1);
					match(UINTEGER);
#line 97 "hierSys.g"
					depth = atoi(didi->getText().c_str());
#line 351 "hierSysParser.cpp"
					break;
				}
				case PIPE:
				case SIGNAL:
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
#line 98 "hierSys.g"
				
								string pipe_name = sidi->getText();
								if((pipe_width == 0) || (depth == 0))
								{
									bool err = getPipeInfoFromGlobals(pipe_name, global_pipe_map,
													     global_pipe_signals, pipe_width, depth, signal_flag);
									if(err)
									{
										sys->Report_Error("underspecified pipe " + pipe_name + " not found in globals.");		
									}
							
								}
				
								sys->Add_In_Pipe(pipe_name, pipe_width, depth);
								if(signal_flag)
									sys->Add_Signal(sidi->getText());
								signal_flag = false;
								depth = 1;
								pipe_width = 0;
				
							
#line 388 "hierSysParser.cpp"
			}
			else {
				goto _loop14;
			}
			
		}
		_loop14:;
		} // ( ... )*
		match(OUT);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PIPE || LA(1) == SIGNAL)) {
				{
				switch ( LA(1)) {
				case PIPE:
				{
					match(PIPE);
					break;
				}
				case SIGNAL:
				{
					{
					match(SIGNAL);
#line 124 "hierSys.g"
					signal_flag = true;
#line 414 "hierSysParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				sido = LT(1);
				match(SIMPLE_IDENTIFIER);
				{
				switch ( LA(1)) {
				case UINTEGER:
				{
					uido = LT(1);
					match(UINTEGER);
#line 125 "hierSys.g"
					pipe_width = atoi(uido->getText().c_str());
#line 434 "hierSysParser.cpp"
					break;
				}
				case PIPE:
				case SIGNAL:
				case DEPTH:
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
				{
				switch ( LA(1)) {
				case DEPTH:
				{
					match(DEPTH);
					dido = LT(1);
					match(UINTEGER);
#line 126 "hierSys.g"
					depth = atoi(dido->getText().c_str());
#line 459 "hierSysParser.cpp"
					break;
				}
				case PIPE:
				case SIGNAL:
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
#line 127 "hierSys.g"
				
								string pipe_name = sido->getText();
								if((pipe_width == 0) || (depth == 0))
								{
									bool err = getPipeInfoFromGlobals(pipe_name, global_pipe_map,
													     global_pipe_signals, pipe_width, depth, signal_flag);
									if(err)
									{
										sys->Report_Error("underspecified pipe " + pipe_name + " not found in globals.");		
									}
							
								}
								sys->Add_Out_Pipe(pipe_name, pipe_width, depth);
								if(signal_flag)
									sys->Add_Signal(sido->getText());
								signal_flag = false;
								depth = 1;
								pipe_width = 0;
							
#line 494 "hierSysParser.cpp"
			}
			else {
				goto _loop20;
			}
			
		}
		_loop20:;
		} // ( ... )*
		match(LBRACE);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == PIPE || LA(1) == SIGNAL)) {
				{
				switch ( LA(1)) {
				case PIPE:
				{
					match(PIPE);
					break;
				}
				case SIGNAL:
				{
					{
					match(SIGNAL);
#line 153 "hierSys.g"
					signal_flag = true;
#line 520 "hierSysParser.cpp"
					}
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
				sidint = LT(1);
				match(SIMPLE_IDENTIFIER);
				{
				switch ( LA(1)) {
				case UINTEGER:
				{
					uidint = LT(1);
					match(UINTEGER);
#line 155 "hierSys.g"
					pipe_width = atoi(uidint->getText().c_str());
#line 540 "hierSysParser.cpp"
					break;
				}
				case PIPE:
				case SIGNAL:
				case DEPTH:
				case RBRACE:
				case INSTANCE:
				case THREAD:
				case STRING:
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
				case DEPTH:
				{
					match(DEPTH);
					didint = LT(1);
					match(UINTEGER);
#line 156 "hierSys.g"
					depth = atoi(didint->getText().c_str());
#line 568 "hierSysParser.cpp"
					break;
				}
				case PIPE:
				case SIGNAL:
				case RBRACE:
				case INSTANCE:
				case THREAD:
				case STRING:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
				}
				}
				}
#line 157 "hierSys.g"
				
									string pipe_name = sidint->getText();
									if((pipe_width == 0) || (depth == 0))
									{
										bool err = getPipeInfoFromGlobals(pipe_name, global_pipe_map,
													     	global_pipe_signals, pipe_width, depth, signal_flag);
										if(err)
										{
											sys->Report_Error("underspecified pipe " + 
													pipe_name + " not found in globals.");		
										}
								
									}
									sys->Add_Internal_Pipe(pipe_name, pipe_width, depth);
									if(signal_flag)
										sys->Add_Signal(sidint->getText());
									signal_flag = false;
									depth = 1;
									pipe_width = 0;
								
#line 607 "hierSysParser.cpp"
			}
			else {
				goto _loop26;
			}
			
		}
		_loop26:;
		} // ( ... )*
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case INSTANCE:
			{
				{
				subsys=hier_System_Instance(sys, sys_vector, global_pipe_map, global_pipe_signals);
#line 186 "hierSys.g"
				
								if(subsys != NULL)
									sys->Add_Child(subsys);
								else
								{
									sys->Report_Error("null subsystem instance ");
								}
								subsys = NULL;
							
#line 633 "hierSysParser.cpp"
				}
				break;
			}
			case THREAD:
			{
				{
				subthread=rtl_Thread(sys);
#line 198 "hierSys.g"
				
								if(subthread != NULL)
									sys->Add_Thread(subthread);
								else
								{
									sys->Report_Error("null subsystem thread ");
								}
				
								subthread = NULL;
							
#line 652 "hierSysParser.cpp"
				}
				break;
			}
			case STRING:
			{
				{
				ti=rtl_String(sys);
#line 211 "hierSys.g"
				
								if(ti != NULL)
									sys->Add_String(ti);
								else
								{
									sys->Report_Error("null thread instance ");
								}
							
#line 669 "hierSysParser.cpp"
				}
				break;
			}
			default:
			{
				goto _loop31;
			}
			}
		}
		_loop31:;
		} // ( ... )*
		match(RBRACE);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_2);
	}
	return sys;
}

hierSystemInstance*  hierSysParser::hier_System_Instance(
	hierSystem* sys, vector<hierSystem*>& sys_vector, map<string, pair<int,int> >& global_pipe_map,
			set<string>& global_signals
) {
#line 227 "hierSys.g"
	hierSystemInstance* sys_inst;
#line 696 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  inst_name = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  libid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  mod_name = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  formal_port = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  actual_pipe = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 227 "hierSys.g"
	
		sys_inst = NULL;
		string lib_id = "work";
	
#line 707 "hierSysParser.cpp"
	
	try {      // for error handling
		match(INSTANCE);
		inst_name = LT(1);
		match(SIMPLE_IDENTIFIER);
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		{
			libid = LT(1);
			match(SIMPLE_IDENTIFIER);
#line 235 "hierSys.g"
			lib_id = libid->getText();
#line 721 "hierSysParser.cpp"
			break;
		}
		case COLON:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		match(COLON);
		mod_name = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 238 "hierSys.g"
		
						hierSystem* base_sys = NULL;
						// find module
						for(int I = 0, fI = sys_vector.size(); I < fI; I++)
						{
							if(sys_vector[I]->Get_Id() == mod_name->getText())
							{
								if(sys_vector[I]->Get_Library() == lib_id)
								{
									base_sys = sys_vector[I];
									break;
								}
							}
						}
						if(base_sys)
							sys_inst = new hierSystemInstance(sys, base_sys, inst_name->getText());
						else
						{
							sys->Report_Error("Error: could not find base system " + 
										mod_name->getText() + " in library " + lib_id);
						}
					
#line 760 "hierSysParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				formal_port = LT(1);
				match(SIMPLE_IDENTIFIER);
				match(IMPLIES);
				actual_pipe = LT(1);
				match(SIMPLE_IDENTIFIER);
#line 262 "hierSys.g"
				
									if(sys_inst)
										sys_inst->Add_Port_Mapping(formal_port->getText(), 
														actual_pipe->getText(),
														global_pipe_map,
														global_signals);
								
								
#line 778 "hierSysParser.cpp"
			}
			else {
				goto _loop35;
			}
			
		}
		_loop35:;
		} // ( ... )*
#line 271 "hierSys.g"
		
						//
						// BUG: add internal pipe to parent if needed..
						//      pass global maps to this function..
						//
						if(sys_inst)
							sys_inst->Map_Unmapped_Ports_To_Defaults(global_pipe_map,
												 global_signals);
					
#line 797 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	return sys_inst;
}

rtlThread*  hierSysParser::rtl_Thread(
	hierSystem* sys
) {
#line 315 "hierSys.g"
	rtlThread* t;
#line 811 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  tname = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 315 "hierSys.g"
	
		t = NULL;
		vector<pair<string,int> > def_params;
	
#line 818 "hierSysParser.cpp"
	
	try {      // for error handling
		match(THREAD);
		tname = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 320 "hierSys.g"
		t = new rtlThread(sys, tname->getText());
#line 826 "hierSysParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIGNAL || LA(1) == VARIABLE || LA(1) == CONSTANT)) {
				rtl_ObjectDeclaration(t);
			}
			else {
				goto _loop44;
			}
			
		}
		_loop44:;
		} // ( ... )*
		{ // ( ... )+
		int _cnt46=0;
		for (;;) {
			if ((LA(1) == LBRACKET)) {
				rtl_LabeledBlockStatement(t);
			}
			else {
				if ( _cnt46>=1 ) { goto _loop46; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt46++;
		}
		_loop46:;
		}  // ( ... )+
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	return t;
}

rtlString*  hierSysParser::rtl_String(
	hierSystem* sys
) {
#line 325 "hierSys.g"
	rtlString* ti;
#line 866 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  inst_name_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  thread_name_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  formal_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  actual_id = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 325 "hierSys.g"
	
		ti = NULL;
		vector<pair<string,string> > pmap;
	
#line 876 "hierSysParser.cpp"
	
	try {      // for error handling
		match(STRING);
		inst_name_id = LT(1);
		match(SIMPLE_IDENTIFIER);
		match(COLON);
		thread_name_id = LT(1);
		match(SIMPLE_IDENTIFIER);
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				formal_id = LT(1);
				match(SIMPLE_IDENTIFIER);
				match(IMPLIES);
				actual_id = LT(1);
				match(SIMPLE_IDENTIFIER);
#line 336 "hierSys.g"
				
								pmap.push_back(pair<string,string> (formal_id->getText(), actual_id->getText()));
							
#line 897 "hierSysParser.cpp"
			}
			else {
				goto _loop49;
			}
			
		}
		_loop49:;
		} // ( ... )*
#line 340 "hierSys.g"
		
		rtlThread* bt = sys->Find_Thread(thread_name_id->getText());
		if (bt != NULL)
		{
		ti = new rtlString(inst_name_id->getText(), bt, pmap);
		sys->Add_String(ti);
		}
		else
		{
		sys->Report_Error("Error: could not find base thread " + 
		thread_name_id->getText() + " in system " + sys->Get_Id());
		}
		
#line 920 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_3);
	}
	return ti;
}

void hierSysParser::rtl_ObjectDeclaration(
	rtlThread* t
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  ibs = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bbs = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hbs = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 357 "hierSys.g"
	
		bool variable_flag = false;
		bool constant_flag = false;
		bool signal_flag = false;
		rtlObject* obj = NULL;
		rtlType* type = NULL;
		vector<string> names;
		vector<string> init_values;
	
#line 946 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case VARIABLE:
		{
			{
			match(VARIABLE);
#line 368 "hierSys.g"
			variable_flag  = true;
#line 957 "hierSysParser.cpp"
			}
			break;
		}
		case CONSTANT:
		{
			{
			match(CONSTANT);
#line 369 "hierSys.g"
			constant_flag  = true;
#line 967 "hierSysParser.cpp"
			}
			break;
		}
		case SIGNAL:
		{
			{
			match(SIGNAL);
#line 370 "hierSys.g"
			signal_flag    = true;
#line 977 "hierSysParser.cpp"
			}
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		{ // ( ... )+
		int _cnt56=0;
		for (;;) {
			if ((LA(1) == SIMPLE_IDENTIFIER)) {
				sid = LT(1);
				match(SIMPLE_IDENTIFIER);
#line 372 "hierSys.g"
				names.push_back(sid->getText());
#line 995 "hierSysParser.cpp"
			}
			else {
				if ( _cnt56>=1 ) { goto _loop56; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt56++;
		}
		_loop56:;
		}  // ( ... )+
		match(COLON);
		{
		type=rtl_Type_Declaration(t);
		}
		{
		match(ASSIGNEQUAL);
		{ // ( ... )*
		for (;;) {
			switch ( LA(1)) {
			case UINTEGER:
			{
				{
				ibs = LT(1);
				match(UINTEGER);
#line 377 "hierSys.g"
				init_values.push_back(ibs->getText());
#line 1021 "hierSysParser.cpp"
				}
				break;
			}
			case BINARY:
			{
				{
				bbs = LT(1);
				match(BINARY);
#line 378 "hierSys.g"
				init_values.push_back(bbs->getText());
#line 1032 "hierSysParser.cpp"
				}
				break;
			}
			case HEXADECIMAL:
			{
				{
				hbs = LT(1);
				match(HEXADECIMAL);
#line 379 "hierSys.g"
				init_values.push_back(hbs->getText());
#line 1043 "hierSysParser.cpp"
				}
				break;
			}
			default:
			{
				goto _loop63;
			}
			}
		}
		_loop63:;
		} // ( ... )*
		}
#line 382 "hierSys.g"
		
		for(int I = 0, fI = names.size(); I < fI; I++)
				{
					string obj_name = names[I];
		obj = NULL;
					if(variable_flag) 
		{
		obj = new rtlVariable(obj_name, type); 
		}
		else if(signal_flag)
		{
		obj = new rtlSignal(obj_name, type); 
		}
		else if(constant_flag)
		{
		rtlValue* val = Make_Rtl_Value(type, init_values);	
		obj = new rtlConstant(obj_name, type, val);
		}
		t->Add_Object(obj);
		}
			
#line 1078 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_4);
	}
}

void hierSysParser::rtl_LabeledBlockStatement(
	rtlThread* t
) {
#line 502 "hierSys.g"
	
		rtlStatement* astmt = NULL;
		rtlLabeledBlockStatement* bstmt = NULL;
		vector<rtlStatement*> stmts;
		string lbl;
	
#line 1096 "hierSysParser.cpp"
	
	try {      // for error handling
		lbl=rtl_Label();
		match(LBRACE);
		{ // ( ... )+
		int _cnt86=0;
		for (;;) {
			if ((_tokenSet_5.member(LA(1)))) {
				astmt=rtl_SimpleStatement(t);
#line 512 "hierSys.g"
				stmts.push_back(astmt); astmt = NULL;
#line 1108 "hierSysParser.cpp"
			}
			else {
				if ( _cnt86>=1 ) { goto _loop86; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt86++;
		}
		_loop86:;
		}  // ( ... )+
		match(RBRACE);
#line 514 "hierSys.g"
		
				bstmt = new rtlLabeledBlockStatement(t, lbl, stmts);
				t->Add_Statement(bstmt);
			
#line 1124 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_6);
	}
}

rtlType*  hierSysParser::rtl_Type_Declaration(
	rtlThread* thrd
) {
#line 683 "hierSys.g"
	rtlType* t;
#line 1137 "hierSysParser.cpp"
#line 683 "hierSys.g"
	
		t  = NULL;
	
#line 1142 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case INTEGER:
		{
			{
			t=rtl_IntegerType_Declaration(thrd);
			}
			break;
		}
		case UNSIGNED:
		{
			{
			t=rtl_UnsignedType_Declaration(thrd);
			}
			break;
		}
		case SIGNED:
		{
			{
			t=rtl_SignedType_Declaration(thrd);
			}
			break;
		}
		case ARRAY:
		{
			{
			t=rtl_ArrayType_Declaration(thrd);
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

rtlStatement*  hierSysParser::rtl_SimpleStatement(
	rtlThread* t
) {
#line 410 "hierSys.g"
	rtlStatement* stmt;
#line 1194 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case SIMPLE_IDENTIFIER:
		case VOLATILE:
		case LPAREN:
		{
			{
			stmt=rtl_AssignStatement(t);
			}
			break;
		}
		case EMIT:
		{
			{
			stmt=rtl_EmitStatement(t);
			}
			break;
		}
		case NuLL:
		{
			{
			stmt=rtl_NullStatement(t);
			}
			break;
		}
		case GOTO:
		{
			{
			stmt=rtl_GotoStatement(t);
			}
			break;
		}
		case IF:
		{
			{
			stmt=rtl_IfStatement(t);
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
		recover(ex,_tokenSet_8);
	}
	return stmt;
}

rtlStatement*  hierSysParser::rtl_AssignStatement(
	rtlThread* t
) {
#line 422 "hierSys.g"
	rtlStatement* stmt;
#line 1255 "hierSysParser.cpp"
#line 422 "hierSys.g"
	
		rtlExpression* tgt = NULL;
		rtlExpression* src = NULL;
	bool volatile_flag = false;
	
#line 1262 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		switch ( LA(1)) {
		case VOLATILE:
		{
			match(VOLATILE);
#line 428 "hierSys.g"
			volatile_flag = true;
#line 1272 "hierSysParser.cpp"
			break;
		}
		case SIMPLE_IDENTIFIER:
		case LPAREN:
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
		tgt=rtl_Expression(t);
		}
		match(ASSIGNEQUAL);
		{
		src=rtl_Expression(t);
		}
#line 432 "hierSys.g"
		
		tgt->Set_Is_Target(true);
		stmt = new rtlAssignStatement(t,volatile_flag, tgt, src);
			
#line 1298 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
	return stmt;
}

rtlStatement*  hierSysParser::rtl_EmitStatement(
	rtlThread* t
) {
#line 439 "hierSys.g"
	rtlStatement* stmt;
#line 1312 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 439 "hierSys.g"
	
		rtlObject* emittee = NULL;
	
#line 1318 "hierSysParser.cpp"
	
	try {      // for error handling
		match(EMIT);
		sid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 444 "hierSys.g"
		
					emittee = t->Find_Object(sid->getText());
					assert(emittee != NULL);
		
					stmt = new rtlEmitStatement(t, emittee);
				
#line 1331 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
	return stmt;
}

rtlStatement*  hierSysParser::rtl_NullStatement(
	rtlThread* t
) {
#line 452 "hierSys.g"
	rtlStatement* stmt;
#line 1345 "hierSysParser.cpp"
#line 452 "hierSys.g"
	
	
#line 1349 "hierSysParser.cpp"
	
	try {      // for error handling
		match(NuLL);
#line 456 "hierSys.g"
		
					stmt = new rtlNullStatement(t);
				
#line 1357 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
	return stmt;
}

rtlStatement*  hierSysParser::rtl_GotoStatement(
	rtlThread* t
) {
#line 461 "hierSys.g"
	rtlStatement* stmt;
#line 1371 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 461 "hierSys.g"
	
		string lbl;
	
#line 1377 "hierSysParser.cpp"
	
	try {      // for error handling
		match(GOTO);
		sid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 466 "hierSys.g"
		
				lbl = sid->getText();
				stmt  = new rtlGotoStatement(t, lbl);
			
#line 1388 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
	return stmt;
}

rtlStatement*  hierSysParser::rtl_IfStatement(
	rtlThread* t
) {
#line 485 "hierSys.g"
	rtlStatement* stmt;
#line 1402 "hierSysParser.cpp"
#line 485 "hierSys.g"
	
		rtlExpression* test_expr = NULL;
		rtlBlockStatement* if_block = NULL;
		rtlBlockStatement* else_block = NULL;
	
#line 1409 "hierSysParser.cpp"
	
	try {      // for error handling
		match(IF);
		{
		test_expr=rtl_Expression(t);
		}
		if_block=rtl_BlockStatement(t);
		{
		switch ( LA(1)) {
		case ELSE:
		{
			match(ELSE);
			else_block=rtl_BlockStatement(t);
			break;
		}
		case SIMPLE_IDENTIFIER:
		case RBRACE:
		case VOLATILE:
		case EMIT:
		case NuLL:
		case GOTO:
		case IF:
		case LPAREN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
#line 497 "hierSys.g"
		
				stmt = (rtlStatement*) new rtlIfStatement(t, test_expr, if_block, else_block);
			
#line 1446 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_8);
	}
	return stmt;
}

rtlExpression*  hierSysParser::rtl_Expression(
	rtlThread* t
) {
#line 520 "hierSys.g"
	rtlExpression* expr;
#line 1460 "hierSysParser.cpp"
#line 520 "hierSys.g"
	
		expr = NULL;
	
#line 1465 "hierSysParser.cpp"
	
	try {      // for error handling
		{
		if ((LA(1) == LPAREN) && ((LA(2) >= INTEGER && LA(2) <= ARRAY))) {
			{
			expr=rtl_Constant_Literal_Expression(t);
			}
		}
		else if ((LA(1) == SIMPLE_IDENTIFIER)) {
			{
			expr=rtl_Object_Reference(t);
			}
		}
		else if ((LA(1) == LPAREN) && (LA(2) == SLICE)) {
			{
			expr=rtl_Slice_Expression(t);
			}
		}
		else if ((LA(1) == LPAREN) && (LA(2) == NOT)) {
			{
			expr=rtl_Unary_Expression(t);
			}
		}
		else if ((LA(1) == LPAREN) && (LA(2) == SIMPLE_IDENTIFIER || LA(2) == LPAREN)) {
			{
			expr=rtl_Binary_Expression(t);
			}
		}
		else if ((LA(1) == LPAREN) && (LA(2) == MUX)) {
			{
			expr=rtl_Ternary_Expression(t);
			}
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		
		}
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlBlockStatement*  hierSysParser::rtl_BlockStatement(
	rtlThread* t
) {
#line 472 "hierSys.g"
	rtlBlockStatement* stmt;
#line 1517 "hierSysParser.cpp"
#line 472 "hierSys.g"
	
		rtlStatement* astmt = NULL;
		vector<rtlStatement*> stmts;
	
#line 1523 "hierSysParser.cpp"
	
	try {      // for error handling
		match(LBRACE);
		{ // ( ... )+
		int _cnt80=0;
		for (;;) {
			if ((_tokenSet_5.member(LA(1)))) {
				astmt=rtl_SimpleStatement(t);
#line 478 "hierSys.g"
				stmts.push_back(astmt); astmt = NULL;
#line 1534 "hierSysParser.cpp"
			}
			else {
				if ( _cnt80>=1 ) { goto _loop80; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt80++;
		}
		_loop80:;
		}  // ( ... )+
		match(RBRACE);
#line 480 "hierSys.g"
		
				stmt = new rtlBlockStatement(t, stmts);
			
#line 1549 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_10);
	}
	return stmt;
}

string  hierSysParser::rtl_Label() {
#line 677 "hierSys.g"
	string label;
#line 1561 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	try {      // for error handling
		match(LBRACKET);
		sid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 679 "hierSys.g"
		label = sid->getText();
#line 1570 "hierSysParser.cpp"
		match(RBRACKET);
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_11);
	}
	return label;
}

rtlExpression*  hierSysParser::rtl_Constant_Literal_Expression(
	rtlThread* thrd
) {
#line 538 "hierSys.g"
	rtlExpression* expr;
#line 1585 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  iid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  iidn = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  bidn = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hidn = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 538 "hierSys.g"
	
		vector<string> init_values;
		rtlType* t = NULL;
	
#line 1597 "hierSysParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		t=rtl_Type_Declaration(thrd);
		match(RPAREN);
		{
		switch ( LA(1)) {
		case UINTEGER:
		{
			{
			iid = LT(1);
			match(UINTEGER);
#line 544 "hierSys.g"
			init_values.push_back(iid->getText());
#line 1612 "hierSysParser.cpp"
			}
			break;
		}
		case BINARY:
		{
			{
			bid = LT(1);
			match(BINARY);
#line 545 "hierSys.g"
			init_values.push_back(bid->getText());
#line 1623 "hierSysParser.cpp"
			}
			break;
		}
		case HEXADECIMAL:
		{
			{
			hid = LT(1);
			match(HEXADECIMAL);
#line 546 "hierSys.g"
			init_values.push_back(hid->getText());
#line 1634 "hierSysParser.cpp"
			}
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
			if ((LA(1) == COMMA)) {
				match(COMMA);
				{
				switch ( LA(1)) {
				case UINTEGER:
				{
					{
					iidn = LT(1);
					match(UINTEGER);
#line 547 "hierSys.g"
					init_values.push_back(iidn->getText());
#line 1657 "hierSysParser.cpp"
					}
					break;
				}
				case BINARY:
				{
					{
					bidn = LT(1);
					match(BINARY);
#line 548 "hierSys.g"
					init_values.push_back(bidn->getText());
#line 1668 "hierSysParser.cpp"
					}
					break;
				}
				case HEXADECIMAL:
				{
					{
					hidn = LT(1);
					match(HEXADECIMAL);
#line 549 "hierSys.g"
					init_values.push_back(hidn->getText());
#line 1679 "hierSysParser.cpp"
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
			else {
				goto _loop105;
			}
			
		}
		_loop105:;
		} // ( ... )*
#line 550 "hierSys.g"
		
				rtlValue* v = Make_Rtl_Value(t, init_values);
				expr = new rtlConstantLiteralExpression(t, v);
			
#line 1702 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlExpression*  hierSysParser::rtl_Object_Reference(
	rtlThread* t
) {
#line 557 "hierSys.g"
	rtlExpression* expr;
#line 1716 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  sid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 557 "hierSys.g"
	
		string obj_name;
		vector<rtlExpression*> indices;	
		bool array_flag = false;
		rtlExpression* iexpr = NULL;
	
#line 1725 "hierSysParser.cpp"
	
	try {      // for error handling
		sid = LT(1);
		match(SIMPLE_IDENTIFIER);
#line 564 "hierSys.g"
		obj_name = sid->getText();
#line 1732 "hierSysParser.cpp"
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == LBRACKET)) {
				match(LBRACKET);
				iexpr=rtl_Expression(t);
				match(RBRACKET);
#line 565 "hierSys.g"
				array_flag = true; indices.push_back(iexpr); iexpr = NULL;
#line 1741 "hierSysParser.cpp"
			}
			else {
				goto _loop108;
			}
			
		}
		_loop108:;
		} // ( ... )*
#line 566 "hierSys.g"
		
				rtlObject* obj = t->Find_Object(obj_name);
				assert(obj != NULL);
		
				if(array_flag)
					expr = new rtlArrayObjectReference(obj, indices);
				else
					expr = new rtlSimpleObjectReference(obj);
			
#line 1760 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlExpression*  hierSysParser::rtl_Slice_Expression(
	rtlThread* t
) {
#line 577 "hierSys.g"
	rtlExpression* expr;
#line 1774 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 577 "hierSys.g"
	
		rtlExpression* base_expr;
		int high_index;
		int low_index;
	
#line 1783 "hierSysParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		match(SLICE);
		base_expr=rtl_Expression(t);
		hid = LT(1);
		match(UINTEGER);
#line 585 "hierSys.g"
		high_index = atoi(hid->getText().c_str());
#line 1793 "hierSysParser.cpp"
		lid = LT(1);
		match(UINTEGER);
#line 586 "hierSys.g"
		low_index = atoi(lid->getText().c_str());
#line 1798 "hierSysParser.cpp"
		match(RPAREN);
#line 588 "hierSys.g"
		
				expr = new rtlSliceExpression(base_expr, high_index, low_index);
			
#line 1804 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlExpression*  hierSysParser::rtl_Unary_Expression(
	rtlThread* t
) {
#line 593 "hierSys.g"
	rtlExpression* expr;
#line 1818 "hierSysParser.cpp"
#line 593 "hierSys.g"
	
		rtlOperation  op;
		rtlExpression* rest;
	
#line 1824 "hierSysParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		op=rtl_Unary_Operation();
		rest=rtl_Expression(t);
		match(RPAREN);
#line 602 "hierSys.g"
		
				expr = new rtlUnaryExpression(op, rest);
			
#line 1835 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlExpression*  hierSysParser::rtl_Binary_Expression(
	rtlThread* t
) {
#line 607 "hierSys.g"
	rtlExpression* expr;
#line 1849 "hierSysParser.cpp"
#line 607 "hierSys.g"
	
		rtlExpression* first = NULL;
		rtlExpression* second = NULL;
		rtlOperation op;
	
#line 1856 "hierSysParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		first=rtl_Expression(t);
		op=rtl_Binary_Operation();
		second=rtl_Expression(t);
		match(RPAREN);
#line 618 "hierSys.g"
		
				expr = new rtlBinaryExpression(op, first, second);
			
#line 1868 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlExpression*  hierSysParser::rtl_Ternary_Expression(
	rtlThread* t
) {
#line 623 "hierSys.g"
	rtlExpression* expr;
#line 1882 "hierSysParser.cpp"
#line 623 "hierSys.g"
	
		rtlExpression* test_expr = NULL;
		rtlExpression* if_true = NULL;
		rtlExpression* if_false = NULL;
	
#line 1889 "hierSysParser.cpp"
	
	try {      // for error handling
		match(LPAREN);
		match(MUX);
		test_expr=rtl_Expression(t);
		if_true=rtl_Expression(t);
		if_false=rtl_Expression(t);
		match(RPAREN);
#line 635 "hierSys.g"
		
				expr = new rtlTernaryExpression(test_expr, if_true, if_false);
			
#line 1902 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_9);
	}
	return expr;
}

rtlOperation  hierSysParser::rtl_Unary_Operation() {
#line 647 "hierSys.g"
	rtlOperation op;
#line 1914 "hierSysParser.cpp"
	
	try {      // for error handling
		match(NOT);
#line 649 "hierSys.g"
		op = __NOT;
#line 1920 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_12);
	}
	return op;
}

rtlOperation  hierSysParser::rtl_Binary_Operation() {
#line 652 "hierSys.g"
	rtlOperation op;
#line 1932 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_or = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_and = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_nor = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_nand = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_xor = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_xnor = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_shl = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_shr = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_rol = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_ror = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_plus = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_minus = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_mul = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_EQUAL = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_notequal = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_less = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_lessequal = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_greater = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_greaterequal = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  id_concat = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 652 "hierSys.g"
	
	
#line 1956 "hierSysParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case OR:
		{
			{
			id_or = LT(1);
			match(OR);
#line 655 "hierSys.g"
			op = __OR;
#line 1967 "hierSysParser.cpp"
			}
			break;
		}
		case AND:
		{
			{
			id_and = LT(1);
			match(AND);
#line 656 "hierSys.g"
			op = __AND;
#line 1978 "hierSysParser.cpp"
			}
			break;
		}
		case NOR:
		{
			{
			id_nor = LT(1);
			match(NOR);
#line 657 "hierSys.g"
			op = __NOR;
#line 1989 "hierSysParser.cpp"
			}
			break;
		}
		case NAND:
		{
			{
			id_nand = LT(1);
			match(NAND);
#line 658 "hierSys.g"
			op = __NAND;
#line 2000 "hierSysParser.cpp"
			}
			break;
		}
		case XOR:
		{
			{
			id_xor = LT(1);
			match(XOR);
#line 659 "hierSys.g"
			op = __XOR;
#line 2011 "hierSysParser.cpp"
			}
			break;
		}
		case XNOR:
		{
			{
			id_xnor = LT(1);
			match(XNOR);
#line 660 "hierSys.g"
			op = __XNOR;
#line 2022 "hierSysParser.cpp"
			}
			break;
		}
		case SHL:
		{
			{
			id_shl = LT(1);
			match(SHL);
#line 661 "hierSys.g"
			op = __SHL;
#line 2033 "hierSysParser.cpp"
			}
			break;
		}
		case SHR:
		{
			{
			id_shr = LT(1);
			match(SHR);
#line 662 "hierSys.g"
			op = __SHR;
#line 2044 "hierSysParser.cpp"
			}
			break;
		}
		case ROL:
		{
			{
			id_rol = LT(1);
			match(ROL);
#line 663 "hierSys.g"
			op = __ROL;
#line 2055 "hierSysParser.cpp"
			}
			break;
		}
		case ROR:
		{
			{
			id_ror = LT(1);
			match(ROR);
#line 664 "hierSys.g"
			op = __ROR;
#line 2066 "hierSysParser.cpp"
			}
			break;
		}
		case PLUS:
		{
			{
			id_plus = LT(1);
			match(PLUS);
#line 665 "hierSys.g"
			op = __PLUS;
#line 2077 "hierSysParser.cpp"
			}
			break;
		}
		case MINUS:
		{
			{
			id_minus = LT(1);
			match(MINUS);
#line 666 "hierSys.g"
			op = __MINUS;
#line 2088 "hierSysParser.cpp"
			}
			break;
		}
		case MUL:
		{
			{
			id_mul = LT(1);
			match(MUL);
#line 667 "hierSys.g"
			op = __MUL;
#line 2099 "hierSysParser.cpp"
			}
			break;
		}
		case EQUAL:
		{
			{
			id_EQUAL = LT(1);
			match(EQUAL);
#line 668 "hierSys.g"
			op = __EQUAL;
#line 2110 "hierSysParser.cpp"
			}
			break;
		}
		case NOTEQUAL:
		{
			{
			id_notequal = LT(1);
			match(NOTEQUAL);
#line 669 "hierSys.g"
			op = __NOTEQUAL;
#line 2121 "hierSysParser.cpp"
			}
			break;
		}
		case LESS:
		{
			{
			id_less = LT(1);
			match(LESS);
#line 670 "hierSys.g"
			op = __LESS;
#line 2132 "hierSysParser.cpp"
			}
			break;
		}
		case LESSEQUAL:
		{
			{
			id_lessequal = LT(1);
			match(LESSEQUAL);
#line 671 "hierSys.g"
			op = __LESSEQUAL;
#line 2143 "hierSysParser.cpp"
			}
			break;
		}
		case GREATER:
		{
			{
			id_greater = LT(1);
			match(GREATER);
#line 672 "hierSys.g"
			op = __GREATER;
#line 2154 "hierSysParser.cpp"
			}
			break;
		}
		case GREATEREQUAL:
		{
			{
			id_greaterequal = LT(1);
			match(GREATEREQUAL);
#line 673 "hierSys.g"
			op = __GREATEREQUAL;
#line 2165 "hierSysParser.cpp"
			}
			break;
		}
		case CONCAT:
		{
			{
			id_concat = LT(1);
			match(CONCAT);
#line 674 "hierSys.g"
			op = __CONCAT;
#line 2176 "hierSysParser.cpp"
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
		recover(ex,_tokenSet_12);
	}
	return op;
}

rtlOperation  hierSysParser::rtl_Operation() {
#line 641 "hierSys.g"
	rtlOperation op;
#line 2196 "hierSysParser.cpp"
	
	try {      // for error handling
		switch ( LA(1)) {
		case NOT:
		{
			{
			op=rtl_Unary_Operation();
			}
			break;
		}
		case LESS:
		case GREATER:
		case OR:
		case AND:
		case NOR:
		case NAND:
		case XOR:
		case XNOR:
		case SHL:
		case SHR:
		case ROL:
		case ROR:
		case PLUS:
		case MINUS:
		case MUL:
		case EQUAL:
		case NOTEQUAL:
		case LESSEQUAL:
		case GREATEREQUAL:
		case CONCAT:
		{
			{
			op=rtl_Binary_Operation();
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
		recover(ex,_tokenSet_0);
	}
	return op;
}

rtlType*  hierSysParser::rtl_IntegerType_Declaration(
	rtlThread* thrd
) {
#line 693 "hierSys.g"
	rtlType* t;
#line 2251 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  lid = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  hid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 693 "hierSys.g"
	
		int L = INT_MIN;
		bool neg_L = false;
		int H = INT_MAX;
		bool neg_H = false;
	
#line 2261 "hierSysParser.cpp"
	
	try {      // for error handling
		match(INTEGER);
		{
		switch ( LA(1)) {
		case MINUS:
		{
			match(MINUS);
#line 700 "hierSys.g"
			neg_L = true;
#line 2272 "hierSysParser.cpp"
			break;
		}
		case UINTEGER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		lid = LT(1);
		match(UINTEGER);
		{
		switch ( LA(1)) {
		case MINUS:
		{
			match(MINUS);
#line 700 "hierSys.g"
			neg_H = true;
#line 2294 "hierSysParser.cpp"
			break;
		}
		case UINTEGER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
		}
		}
		}
		hid = LT(1);
		match(UINTEGER);
#line 701 "hierSys.g"
		
				L = (neg_L ? - atoi(lid->getText().c_str()) : atoi (lid->getText().c_str()));
				H = (neg_H ? - atoi(hid->getText().c_str()) : atoi (hid->getText().c_str()));
				t = Find_Or_Make_Integer_Type(L,H);
			
#line 2315 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

rtlType*  hierSysParser::rtl_UnsignedType_Declaration(
	rtlThread* thrd
) {
#line 709 "hierSys.g"
	rtlType* t;
#line 2329 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 709 "hierSys.g"
	
		int width;
	
#line 2335 "hierSysParser.cpp"
	
	try {      // for error handling
		match(UNSIGNED);
		match(LESS);
		wid = LT(1);
		match(UINTEGER);
		match(GREATER);
#line 714 "hierSys.g"
		
				t = Find_Or_Make_Unsigned_Type(atoi(wid->getText().c_str()));
			
#line 2347 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

rtlType*  hierSysParser::rtl_SignedType_Declaration(
	rtlThread* thrd
) {
#line 719 "hierSys.g"
	rtlType* t;
#line 2361 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  wid = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 719 "hierSys.g"
	
		int width;
	
#line 2367 "hierSysParser.cpp"
	
	try {      // for error handling
		match(SIGNED);
		match(LESS);
		wid = LT(1);
		match(UINTEGER);
		match(GREATER);
#line 724 "hierSys.g"
		
				t = Find_Or_Make_Signed_Type(atoi(wid->getText().c_str()));
			
#line 2379 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

rtlType*  hierSysParser::rtl_ArrayType_Declaration(
	rtlThread* thrd
) {
#line 729 "hierSys.g"
	rtlType* t;
#line 2393 "hierSysParser.cpp"
	ANTLR_USE_NAMESPACE(antlr)RefToken  did = ANTLR_USE_NAMESPACE(antlr)nullToken;
#line 729 "hierSys.g"
	
		vector<int> dims;
		rtlType* ele_type = NULL;
	
#line 2400 "hierSysParser.cpp"
	
	try {      // for error handling
		match(ARRAY);
		{ // ( ... )+
		int _cnt152=0;
		for (;;) {
			if ((LA(1) == LBRACKET)) {
				match(LBRACKET);
				did = LT(1);
				match(UINTEGER);
				match(RBRACKET);
#line 735 "hierSys.g"
				dims.push_back(atoi(did->getText().c_str()));
#line 2414 "hierSysParser.cpp"
			}
			else {
				if ( _cnt152>=1 ) { goto _loop152; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
			}
			
			_cnt152++;
		}
		_loop152:;
		}  // ( ... )+
		match(OF);
		ele_type=rtl_Type_Declaration(thrd);
#line 738 "hierSys.g"
		
				t = Find_Or_Make_Array_Type(dims, ele_type);
			
#line 2430 "hierSysParser.cpp"
	}
	catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& ex) {
		reportError(ex);
		recover(ex,_tokenSet_7);
	}
	return t;
}

void hierSysParser::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& )
{
}
const char* hierSysParser::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"SYSTEM",
	"SIMPLE_IDENTIFIER",
	"LIBRARY",
	"IN",
	"PIPE",
	"SIGNAL",
	"UINTEGER",
	"DEPTH",
	"OUT",
	"LBRACE",
	"RBRACE",
	"INSTANCE",
	"COLON",
	"IMPLIES",
	"LIFO",
	"UINT",
	"LESS",
	"GREATER",
	"THREAD",
	"STRING",
	"VARIABLE",
	"CONSTANT",
	"ASSIGNEQUAL",
	"BINARY",
	"HEXADECIMAL",
	"VOLATILE",
	"EMIT",
	"NuLL",
	"GOTO",
	"IF",
	"ELSE",
	"LPAREN",
	"RPAREN",
	"COMMA",
	"LBRACKET",
	"RBRACKET",
	"SLICE",
	"MUX",
	"NOT",
	"OR",
	"AND",
	"NOR",
	"NAND",
	"XOR",
	"XNOR",
	"SHL",
	"SHR",
	"ROL",
	"ROR",
	"PLUS",
	"MINUS",
	"MUL",
	"EQUAL",
	"NOTEQUAL",
	"LESSEQUAL",
	"GREATEREQUAL",
	"CONCAT",
	"INTEGER",
	"UNSIGNED",
	"SIGNED",
	"ARRAY",
	"OF",
	"WHITESPACE",
	"SINGLELINECOMMENT",
	"ALPHA",
	"DIGIT",
	0
};

const unsigned long hierSysParser::_tokenSet_0_data_[] = { 2UL, 0UL, 0UL, 0UL };
// EOF 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_0(_tokenSet_0_data_,4);
const unsigned long hierSysParser::_tokenSet_1_data_[] = { 262418UL, 0UL, 0UL, 0UL };
// EOF SYSTEM PIPE LIFO 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_1(_tokenSet_1_data_,4);
const unsigned long hierSysParser::_tokenSet_2_data_[] = { 18UL, 0UL, 0UL, 0UL };
// EOF SYSTEM 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_2(_tokenSet_2_data_,4);
const unsigned long hierSysParser::_tokenSet_3_data_[] = { 12632064UL, 0UL, 0UL, 0UL };
// RBRACE INSTANCE THREAD STRING 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_3(_tokenSet_3_data_,4);
const unsigned long hierSysParser::_tokenSet_4_data_[] = { 50332160UL, 64UL, 0UL, 0UL };
// SIGNAL VARIABLE CONSTANT LBRACKET 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_4(_tokenSet_4_data_,4);
const unsigned long hierSysParser::_tokenSet_5_data_[] = { 3758096416UL, 11UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER VOLATILE EMIT NuLL GOTO IF LPAREN 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_5(_tokenSet_5_data_,4);
const unsigned long hierSysParser::_tokenSet_6_data_[] = { 12632064UL, 64UL, 0UL, 0UL };
// RBRACE INSTANCE THREAD STRING LBRACKET 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_6(_tokenSet_6_data_,4);
const unsigned long hierSysParser::_tokenSet_7_data_[] = { 67108864UL, 16UL, 0UL, 0UL };
// ASSIGNEQUAL RPAREN 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_7(_tokenSet_7_data_,4);
const unsigned long hierSysParser::_tokenSet_8_data_[] = { 3758112800UL, 11UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RBRACE VOLATILE EMIT NuLL GOTO IF LPAREN 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_8(_tokenSet_8_data_,4);
const unsigned long hierSysParser::_tokenSet_9_data_[] = { 3828376608UL, 536869019UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER UINTEGER LBRACE RBRACE LESS GREATER ASSIGNEQUAL VOLATILE 
// EMIT NuLL GOTO IF LPAREN RPAREN RBRACKET OR AND NOR NAND XOR XNOR SHL 
// SHR ROL ROR PLUS MINUS MUL EQUAL NOTEQUAL LESSEQUAL GREATEREQUAL CONCAT 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_9(_tokenSet_9_data_,4);
const unsigned long hierSysParser::_tokenSet_10_data_[] = { 3758112800UL, 15UL, 0UL, 0UL };
// SIMPLE_IDENTIFIER RBRACE VOLATILE EMIT NuLL GOTO IF ELSE LPAREN 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_10(_tokenSet_10_data_,4);
const unsigned long hierSysParser::_tokenSet_11_data_[] = { 8192UL, 0UL, 0UL, 0UL };
// LBRACE 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_11(_tokenSet_11_data_,4);
const unsigned long hierSysParser::_tokenSet_12_data_[] = { 34UL, 8UL, 0UL, 0UL };
// EOF SIMPLE_IDENTIFIER LPAREN 
const ANTLR_USE_NAMESPACE(antlr)BitSet hierSysParser::_tokenSet_12(_tokenSet_12_data_,4);


