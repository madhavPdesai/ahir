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
#include <rtlThread.h>
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

	hierSystemInstance* subsys    = NULL;
	rtlThread*   subthread = NULL;
	rtlString*   ti = NULL;

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

		(

			subsys = hier_System_Instance[sys, sys_vector, global_pipe_map, global_pipe_signals] 
			{
				if(subsys != NULL)
					sys->Add_Child(subsys);
				else
				{
					sys->Report_Error("null subsystem instance ");
				}
				subsys = NULL;
			}
		) |
		(   
			subthread = rtl_Thread[sys]
			{
				if(subthread != NULL)
					sys->Add_Thread(subthread);
				else
				{
					sys->Report_Error("null subsystem thread ");
				}

				subthread = NULL;
			}
		) |
		(
			ti = rtl_String[sys]
			{
				if(ti != NULL)
					sys->Add_String(ti);
				else
				{
					sys->Report_Error("null thread instance ");
				}
			}
		)
	)*

	RBRACE
;



hier_System_Instance[hierSystem* sys, vector<hierSystem*>& sys_vector, map<string, pair<int,int> >& global_pipe_map,
			set<string>& global_signals] returns [hierSystemInstance* sys_inst]
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
					sys->Report_Error("Error: could not find base system " + 
								mod_name->getText() + " in library " + lib_id);
				}
			}
			( 
				formal_port: SIMPLE_IDENTIFIER IMPLIES actual_pipe: SIMPLE_IDENTIFIER 
				{
					if(sys_inst)
						sys_inst->Add_Port_Mapping(formal_port->getText(), 
										actual_pipe->getText(),
										global_pipe_map,
										global_signals);
				
				}
			)*
			{
				//
				// BUG: add internal pipe to parent if needed..
				//      pass global maps to this function..
				//
				if(sys_inst)
					sys_inst->Map_Unmapped_Ports_To_Defaults(global_pipe_map,
										 global_signals);
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

// thread.
rtl_Thread[hierSystem* sys] returns [rtlThread* t]
{
	t = NULL;
	vector<pair<string,int> > def_params;
}:
	THREAD tname:SIMPLE_IDENTIFIER {t = new rtlThread(sys, tname->getText());}
	(
		(rtl_ObjectDeclaration[t] | rtl_LabeledBlockStatement[t])*
	)*
;

rtl_String[hierSystem* sys] returns [rtlString* ti]
{
	ti = NULL;
	vector<pair<string,string> > pmap;
}:
	STRING 
		inst_name_id: SIMPLE_IDENTIFIER
		COLON
		thread_name_id: SIMPLE_IDENTIFIER

		( formal_id: SIMPLE_IDENTIFIER IMPLIES actual_id:SIMPLE_IDENTIFIER 
			{
				pmap.push_back(pair<string,string> (formal_id->getText(), actual_id->getText()));
			}
		)*
	{
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
	}	
;


// rtl-object declaration
rtl_ObjectDeclaration[rtlThread* t]
{
	bool variable_flag = false;
	bool constant_flag = false;
	bool signal_flag = false;
	rtlObject* obj = NULL;
	rtlType* type = NULL;
	vector<string> names;
	string init_value;
}:
	(
		(VARIABLE {variable_flag  = true;}) |
		(CONSTANT {constant_flag  = true;}) |
		(SIGNAL   {signal_flag    = true;}) 
	)
	( sid: SIMPLE_IDENTIFIER {names.push_back(sid->getText());} )+
	COLON
	(type = rtl_TypeDeclaration[t])
	(ASSIGNEQUAL bs: BITSTRING {init_value = bs->getText();})?
	{
		for(int I = 0, fI = names.size(); I < fI; I++)
		{
			string obj_name = names[I];
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
				rtlValue* val = Make_Rtl_Value(type, init_value);	
				obj = new rtlConstant(obj_name, type, val);
			}
		}
	}

;

	
	 

// rtl-statement
rtl_Simple_Statement[rtlThread* t] returns [rtlStatement* stmt]
:
	( (stmt=rtl_AssignStatement[t]) |
		(stmt=rtl_EmitStatement[t]) |
		  (stmt=rtl_NullStatement[t]) |
		    (stmt=rtl_GotoStatement[t])  |
			(stmt=rtl_IfStatement[t]) )
			
;


// assignment statement
rtl_AssignStatement[rtlThread* t] returns [rtlStatement* stmt]
{
	rtlExpression* tgt = NULL;
	rtlExpression* src = NULL;
}:
	(tgt = rtl_Expression[t])
	(src = rtl_Expression[t])
	{
		stmt = new rtlAssignStatement(t, tgt, src);
	}
;

		
rtl_EmitStatement[rtlThread* t]  returns [rtlStatement* stmt]
{
	rtlObject* emittee = NULL;
}:
	EMIT sid:SIMPLE_IDENTIFIER
		{
			emittee = t->Find_Object(sid->getText());
			assert(emittee != NULL);

			stmt = new rtlEmitStatement(t, emittee);
		}
;

rtl_NullStatement[rtlThread* t]  returns [rtlStatement* stmt]
{
}:
	NuLL 
		{
			stmt = new rtlNullStatement(t);
		}
;

rtl_GotoStatement[rtlThread* t] returns [rtlStatement* stmt]
{
	string lbl;
}:
	GOTO sid: SIMPLE_IDENTIFIER 
	{
		lbl = sid->getText();
		stmt  = new rtlGotoStatement(t, lbl);
	}
;

rtl_Block_Statement[rtlThread* t] returns [rtlBlockStatement* stmt]
{
	rtlStatement* astmt = NULL;
	vector<rtlStatement*> stmts;
}:
	LBRACE
		( astmt = rtl_Simple_Statement[t] {stmts.push_back(astmt); astmt = NULL;})+
	RBRACE
	{
		stmt = new rtlBlockStatement(t, stmts);
	}
;

rtl_If_Statement[rtlThread* t] returns [rtlStatement* stmt]
{
	rtlExpression* testexpr = NULL;
	rtlBlockStatement* if_block = NULL;
	rtlBlockStatement* else_block = NULL;
}
:
	IF (test_expr = rtlExpression[t])  LBRACE (if_block  = rtl_BlockStatement[t]) RBRACE
	(ELSE LBRACE (else_block = rtl_BlockStatement[t]) RBRACE)?
	{ stmt = (rtlStatement*) new rtlIfStatement(t, testexpr, if_block, else_block);}
;

rtl_Labeled_Block_Statement[rtlThread* t]
{
	rtlStatement* astmt = NULL;
	rtlLabeledBlockStatement* bstmt = NULL;
	vector<rtlStatement*> stmts;
	string lbl;
}:
	lbl = rtl_Label

	LBRACE
		( astmt = rtl_Simple_Statement[t] {stmts.push_back(astmt); astmt = NULL;})+
	RBRACE
	{
		bstmt = new rtlLabeledBlockStatement(lbl, t, stmts);
		t->Add_Statement(bstmt);
	}
;

rtl_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	expr = NULL;
}
:
	( (expr = rtl_Constant_Literal_Expression[t]) |
		(expr = rtl_Object_Reference[t]) | 
		   (expr = rtl_Slice_Expression[t]) | 
			(expr = rtl_Unary_Expression[t]) |
				(expr = rtl_Binary_Expression[t]) |
					(expr = rtl_Ternary_Expression[t]) )
;


rtl_Constant_Literal_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	string init_value;
}:
	( (iid: UINTEGER {init_value = iid->getText();}) |
		(bid: BINARY {init_value = bid->getText();}) |
			(hid : HEXADECIMAL {init_value = hid->getText()))
	{
		expr = new rtlConstantLiteral(init_value);
	}	
;


rtl_Object_Reference[rtlThread* t] returns [rtlExpression* expr]
{
	string obj_name;
	vector<rtlExpression*> indices;	
	bool array_flag = false;
	rtlExpression* iexpr = NULL;
}:
	sid: SIMPLE_IDENTIFIER {obj_name = sid->getText();}
	( LBRACKET iexpr = rtl_Expression[t] RBRACKET {array_flag = true; indices.push_back(iexpr); iexpr = NULL;} )*
	{
		rtlObject* obj = t->Find_Object(obj_name);
		assert(obj != NULL);

		if(array_flag)
			expr = new rtlArrayObjectReference(obj, indices);
		else
			expr = new rtlSimpleObjectReference(obj);
	}
;

rtl_Slice_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	rtlExpression* base_expr;
	rtlExpression* high_expr;
	rtlExpression* low_expr;
}:
	LPAREN 
		SLICE base_expr = rtl_Expression[t]
			high_expr = rtl_Expression[t]
			low_expr  = rtl_Expression[t]
	RPAREN
	{
		expr = new rtlSliceExpression(base_expr, high_expr, low_expr);
	}
;

rtl_Unary_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	rtlOperation  op;
	rtlExpression* rest;
}:
	LPAREN
		op = rtl_Operation 
		rest  = rtl_Expression[t]
	RPAREN
	{
		expr = new rtlUnaryExpression(op, rest);
	}
;

rtl_Binary_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	rtlExpression* first = NULL;
	rtlExpression* second = NULL;
	rtlOperation op;
}:
	LPAREN
		first = rtl_Expression[t]
		op = rtl_Operation
		second = rtl_Expression[t]
	RPAREN	
	{
		expr = new rtlBinaryExpression(op, first, second);
	}
;

rtl_Ternary_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	rtlExpression* test_expr = NULL;
	rtlExpression* if_true = NULL;
	rtlExpression* if_false = NULL;
}:
	LPAREN
		test_expression = rtl_Expression[t]
		QUESTION
		if_true = rtl_Expression[t]
		COLON
		if_false = rtl_Expression[t]
	RPAREN
	{
		expr = new rtlTernaryExpression(test_expression, if_true, if_false);
	}
;

rtl_Unary_Operation returns [rtlOperation op]
:
	NOT {return (__NOT);}
;

rtl_Binary_Operation returns [rtlOperation op]
{
}:
        ( id_or:OR {op = __OR;}) |
        ( id_and:AND {op = __AND;}) | 
        ( id_nor:NOR { op = __NOR;}) | 
        ( id_nand:NAND { op = __NAND;}) | 
        ( id_xor:XOR { op = __XOR;}) | 
        ( id_xnor:XNOR { op = __XNOR;}) | 
        ( id_shl:SHL { op = __SHL;}) |
        ( id_shr:SHR { op = __SHR;}) | 
        ( id_rol:ROL { op = __ROL;}) | 
        ( id_ror:ROR { op = __ROR;}) | 
        ( id_plus:PLUS { op = __PLUS;}) | 
        ( id_minus:MINUS { op = __MINUS;}) | 
        ( id_mul:MUL { op = __MUL;}) | 
        ( id_EQUAL:EQUAL { op = __EQUAL;}) | 
        ( id_notequal:NOTEQUAL { op = __NOTEQUAL;}) | 
        ( id_less:LESS { op = __LESS;}) | 
        ( id_lessequal:LESSEQUAL { op = __LESSEQUAL;}) | 
        ( id_greater:GREATER { op = __GREATER;}) | 
        ( id_greaterequal:GREATEREQUAL { op = __GREATEREQUAL;}) | 
        ( id_concat:CONCAT { op = __CONCAT;})  
;

rtl_Label returns [string label]
:
	LBRACKET sid: SIMPLE_IDENTIFIER {label = sid->getText();} RBRACKET
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
LBRACKET:"[";
RBRACKET:"]";



SYSTEM: "$system";
IN: "$in";
OUT: "$out";
PIPE: "$pipe";
LIFO: "$lifo";
SIGNAL: "$signal";
INSTANCE: "$instance";
LIBRARY: "$library";
DEPTH: "$depth";
THREAD: "$thread";
STRING: "$string";
NuLL: "$null";
EMIT: "$emit";
GOTO: "$goto";



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

