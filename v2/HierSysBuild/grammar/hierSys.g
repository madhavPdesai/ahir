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
sys_Description [vector<hierSystem*>& sys_vec]
{
	hierSystem* sys = NULL;
}
:
      (sys = hier_System [sys_vec] {sys_vec.push_back(sys); })+
;

//---------------------------------------------------------------------------------------------------------------
// hier_System :  "hier_system" SIMPLE_IDENTIFIER in-pipe-decls out-pipe-decls internal-pipe decls subsystem decls
//---------------------------------------------------------------------------------------------------------------
hier_System[vector<hierSystem*>& sys_vector]  returns [hierSystem* sys]
{ 
	sys =  NULL;
	hierSystemInstance* subsys = NULL;
	bool signal_flag = false;
	string lib_id = "work";

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
		sidi: SIMPLE_IDENTIFIER  uidi: UINTEGER 
			{
				sys->Add_In_Pipe(sidi->getText(), atoi(uidi->getText().c_str()));
				if(signal_flag)
					sys->Add_Signal(sidi->getText());
				signal_flag = false;
			} 

	)*

	OUT
	( 
		(PIPE | (SIGNAL {signal_flag = true;}))
		 sido: SIMPLE_IDENTIFIER  uido: UINTEGER 
			{
				sys->Add_Out_Pipe(sido->getText(), atoi(uido->getText().c_str()));
				if(signal_flag)
					sys->Add_Signal(sido->getText());
				signal_flag = false;
			} 
 		     
	)*

	LBRACE


	( 
		(PIPE |  (SIGNAL {signal_flag = true;}))
		  sidint: SIMPLE_IDENTIFIER  
			uidint: UINTEGER 
				{
					sys->Add_Internal_Pipe(sidint->getText(), atoi(uidint->getText().c_str()));
					if(signal_flag)
						sys->Add_Signal(sidint->getText());
					signal_flag = false;
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

SYSTEM: "$system";
IN: "$in";
OUT: "$out";
PIPE: "$pipe";
SIGNAL: "$signal";
INSTANCE: "$instance";
LIBRARY: "$library";


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

