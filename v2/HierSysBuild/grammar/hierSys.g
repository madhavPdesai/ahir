/*
 * hierSystemGrammar.g: a simple grammar to describe
 * a hierarchical system.  Useful for assembling a larger
 * system out of smaller subsystems.
 *
 * Author: Madhav Desai
 *
 */


header "post_include_cpp" {
}

header "post_include_hpp" {
#include <hierSystem.h>
#include <antlr/RecognitionException.hpp>
	ANTLR_USING_NAMESPACE(antlr)
#include <map>
#include <set>


}

options {
	language="Cpp";
}

class hierSysParser extends Parser;

options {
	// go with LL(3) grammar
	k=3;
	defaultErrorHandler=true;
} 
{
	void reportError(RecognitionException &re )
	{
		cerr << "Error: Parsing Exception: " <<  re.toString() << endl;
	}
}


//---------------------------------------------------------------------------------------------------------------
// hier_System :  "hier_system" SIMPLE_IDENTIFIER in-pipe-decls out-pipe-decls internal-pipe decls subsystem decls
//---------------------------------------------------------------------------------------------------------------
sys_Description [vector<hierSystem*>& sys_vec, map<string,pair<int,int> >&  global_pipe_map, set<string>& global_pipe_signals]
{

	hierSystem* sys = NULL;
}
:
      (hier_system_Pipe_Declaration[global_pipe_map,global_pipe_signals] )*
      (sys = hier_System [sys_vec, global_pipe_map,global_pipe_signals] {sys_vec.push_back(sys); })*
;

//---------------------------------------------------------------------------------------------------------------
// hier_System :  "hier_system" SIMPLE_IDENTIFIER in-pipe-decls out-pipe-decls internal-pipe decls subsystem decls
//---------------------------------------------------------------------------------------------------------------
hier_System[vector<hierSystem*>& sys_vector, map<string,pair<int,int> >&  global_pipe_map, set<string>& global_pipe_signals]  
		returns [hierSystem* sys]

{ 
	sys =  NULL;
	hierSystemInstance* subsys = NULL;
	bool signal_flag = false;
	string lib_id = "work";
	int depth = 1;
	int pipe_width = 0;
}:
	(SYSTEM 
		sysid:SIMPLE_IDENTIFIER  

		(LIBRARY libid: SIMPLE_IDENTIFIER {lib_id = libid->getText();})? 
		{
			sys = new hierSystem(sysid->getText());
			sys->Set_Library(lib_id);
		}
	)
	

	IN 
	( 
		(PIPE | (SIGNAL {signal_flag = true;}))
		sidi: SIMPLE_IDENTIFIER  (uidi: UINTEGER {pipe_width = atoi(uidi->getText().c_str());})?
				(DEPTH didi: UINTEGER {depth = atoi(didi->getText().c_str());})?
			{
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

			} 

	)*

	OUT
	( 
		(PIPE | (SIGNAL {signal_flag = true;}))
		 sido: SIMPLE_IDENTIFIER  (uido:UINTEGER  {pipe_width = atoi(uido->getText().c_str());})?
				(DEPTH dido: UINTEGER {depth = atoi(dido->getText().c_str());})?
			{
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
			} 
 		     
	)*

	LBRACE


	( 
		(PIPE |  (SIGNAL {signal_flag = true;}))
		  sidint: SIMPLE_IDENTIFIER  
			(uidint: UINTEGER {pipe_width = atoi(uidint->getText().c_str());})?
				(DEPTH didint: UINTEGER {depth = atoi(didint->getText().c_str());})?
				{
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
				} 
	
	)*


	(

		subsys = hier_System_Instance[sys, sys_vector] 
		{
			if(subsys != NULL)
				sys->Add_Child(subsys);
			else
				sys->Set_Error(true);
		}
	)*

	RBRACE
;


hier_System_Instance[hierSystem* sys, vector<hierSystem*>& sys_vector] returns [hierSystemInstance* sys_inst]
{
	sys_inst = NULL;
	string lib_id = "work";
}
:
	INSTANCE inst_name: SIMPLE_IDENTIFIER  
		(libid: SIMPLE_IDENTIFIER {lib_id = libid->getText();})?
		COLON
		mod_name: SIMPLE_IDENTIFIER  
			{
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
					cerr << "Error: could not find base system " << mod_name->getText() <<
						" in library " << lib_id << endl;
				        sys->Set_Error(true);
				}
			}
			( 
				formal_port: SIMPLE_IDENTIFIER IMPLIES actual_pipe: SIMPLE_IDENTIFIER 
				{
					if(sys_inst)
						sys_inst->Add_Port_Mapping(formal_port->getText(), actual_pipe->getText());
				
				}
			)*
			{
				if(sys_inst)
					sys_inst->Map_Unmapped_Ports_To_Defaults();
			}
;

hier_system_Pipe_Declaration[map<string, pair<int,int> >& pipe_map, set<string>& signals] 
{
            vector<string> oname_list;
            int pipe_depth = 1;
	    int pipe_width = 0;

	    bool lifo_flag = false;
	    bool in_mode = false;
	    bool out_mode = false;
	    bool is_port = false;
	    bool is_signal = false;
	    bool is_synch  = false;
 }
        :       (lid:LIFO { std::cerr << "Warning: lifo flag ignored.. line number " << lid->getLine() << endl; })? 
		PIPE 
		(psid:SIMPLE_IDENTIFIER {oname_list.push_back(psid->getText());})+
		COLON UINT LESS_THAN wid:UINTEGER GREATER_THAN  
			{pipe_width = atoi(wid->getText().c_str());} 
        	(DEPTH did:UINTEGER {pipe_depth = atoi(did->getText().c_str());})?
		(SIGNAL {is_signal = true;})?
        {
	    for(int I = 0, fI = oname_list.size(); I < fI; I++)
	    {
		string oname = oname_list[I];
			
		addPipeToGlobalMaps(oname, pipe_map, signals,  pipe_width, pipe_depth, is_signal);

	   }

	}
        ;

// lexer rules
class hierSysLexer extends Lexer;

options {
	k = 6;
	testLiterals = true;
	charVocabulary = '\3'..'\377';
	defaultErrorHandler=true;
}

LBRACE : '{';
RBRACE : '}';
LPAREN : '(';
RPAREN : ')';
IMPLIES: "=>";
COLON: ":";
LESS_THAN: "<";
GREATER_THAN: ">";
UINT: "$uint";
PORT: "$port";
SYNCH: "$synch";


SYSTEM: "$system";
IN: "$in";
OUT: "$out";
PIPE: "$pipe";
LIFO: "$lifo";
SIGNAL: "$signal";
INSTANCE: "$instance";
LIBRARY: "$library";
DEPTH: "$depth";


// language keywords (all start with $)
UINTEGER          : DIGIT (DIGIT)*;

// White spaces (only "\n" is newline)
WHITESPACE: (	' ' |'\t' | '\f' | '\r' | '\n' { newline(); } ) 
{ 
	$setType(ANTLR_USE_NAMESPACE(antlr)Token::SKIP); 
}
;

// Comment: anything which follows //
SINGLELINECOMMENT:
( 
 "//" (~'\n')* '\n' { newline(); }
 ) 
{ 
	$setType(ANTLR_USE_NAMESPACE(antlr)Token::SKIP); 
}
;



// Identifiers
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_')*; 

// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

