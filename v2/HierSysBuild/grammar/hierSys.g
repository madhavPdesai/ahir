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
#include <limits.h>
#include <hierSystem.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <rtlExpression.h>
#include <rtlObject.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlStatement.h>
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
		COLON UINT LESS wid:UINTEGER GREATER  
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
        (rtl_ObjectDeclaration[t])*
        (rtl_LabeledBlockStatement[t])+
    ;

rtl_String[hierSystem* sys] returns [rtlString* ti]
{
	ti = NULL;

	string actual;
	vector<string> formals;

}:
        STRING 
		inst_name_id: SIMPLE_IDENTIFIER
		COLON
		thread_name_id: SIMPLE_IDENTIFIER
        	{ 
			rtlThread* bt = sys->Find_Thread(thread_name_id->getText());
            		if (bt == NULL)
			{
                    		sys->Report_Error("Error: could not find base thread " + 
                                      thread_name_id->getText() + " in system " + sys->Get_Id());
			
			}
			else
			{
                    		ti = new rtlString(inst_name_id->getText(), bt);
			}
		}

		( LPAREN (formal_id: SIMPLE_IDENTIFIER {formals.push_back(formal_id->getText());})+ RPAREN
			IMPLIES actual_id:SIMPLE_IDENTIFIER 
			{
				actual = actual_id->getText();
				if(ti != NULL)
					ti->Add_Port_Map_Entry(formals, actual);
				formals.clear();
			}
		)*
    ;


// rtl-object declaration
rtl_ObjectDeclaration[rtlThread* t]
{
	bool variable_flag = false;
	bool constant_flag = false;
	bool signal_flag = false;
	bool in_flag = false;
	bool out_flag = false;
	rtlObject* obj = NULL;
	rtlType* type = NULL;
	vector<string> names;
	vector<string> init_values;
	rtlExpression* init_expr = NULL;
	rtlValue* init_value = NULL;
}:
        (
            (VARIABLE {variable_flag  = true;}) |
		(CONSTANT {constant_flag  = true;}) |
		(SIGNAL   {signal_flag    = true;})  |
		(IN  {in_flag = true;}) |
		(OUT {out_flag = true;})
	)
	( sid: SIMPLE_IDENTIFIER {names.push_back(sid->getText());} )+
        COLON
        (type = rtl_Type_Declaration[t])
        (ASSIGNEQUAL init_expr=rtl_Expression[t,type] {init_expr->Evaluate(t); init_value = init_expr->Get_Value();})?

{
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
		else if(in_flag)
		{
			obj = new rtlInPort(obj_name, type); 
		}
		else if(out_flag)
		{
			obj = new rtlOutPort(obj_name, type); 
		}
		else if(constant_flag)
		{
			if(init_value == NULL)
				t->Get_Parent()->Report_Error("initial value of constant " + obj_name + " could not be evaluated ");
			else
				obj = new rtlConstant(obj_name, type, init_value);
		}
		if(obj != NULL)
			t->Add_Object(obj);
	}
}

;




// rtl-statement
rtl_SimpleStatement[rtlThread* t] returns [rtlStatement* stmt]
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
	bool volatile_flag = false;
}:
(VOLATILE {volatile_flag = true;})?
(tgt = rtl_Expression[t,NULL])
	ASSIGNEQUAL
(src = rtl_Expression[t,NULL])
{
	tgt->Set_Is_Target(true);
	stmt = new rtlAssignStatement(t,volatile_flag, tgt, src);
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

rtl_BlockStatement[rtlThread* t] returns [rtlBlockStatement* stmt]
{
	rtlStatement* astmt = NULL;
	vector<rtlStatement*> stmts;
}:
LBRACE
( astmt = rtl_SimpleStatement[t] {stmts.push_back(astmt); astmt = NULL;})+
RBRACE
{
	stmt = new rtlBlockStatement(t, stmts);
	}
;

rtl_IfStatement[rtlThread* t] returns [rtlStatement* stmt]
{
	rtlExpression* test_expr = NULL;
	rtlBlockStatement* if_block = NULL;
	rtlBlockStatement* else_block = NULL;
}
:
	IF (test_expr = rtl_Expression[t,NULL])  
        if_block  = rtl_BlockStatement[t]
	(ELSE 
            else_block = rtl_BlockStatement[t]
        )?
	{ 
		stmt = (rtlStatement*) new rtlIfStatement(t, test_expr, if_block, else_block);
	}
;

rtl_LabeledBlockStatement[rtlThread* t]
{
	rtlStatement* astmt = NULL;
	rtlLabeledBlockStatement* bstmt = NULL;
	vector<rtlStatement*> stmts;
	string lbl;
}:
	lbl  = rtl_Label
	LBRACE
		( astmt = rtl_SimpleStatement[t] {stmts.push_back(astmt); astmt = NULL;})+
	RBRACE
	{
		bstmt = new rtlLabeledBlockStatement(t, lbl, stmts);
		t->Add_Statement(bstmt);
	}
;

rtl_Expression[rtlThread* t, rtlType* type] returns [rtlExpression* expr]
{
	expr = NULL;
}
:
	( (expr = rtl_Constant_Literal_Expression[t,type]) |
		(expr = rtl_Object_Reference[t]) | 
		   (expr = rtl_Slice_Expression[t]) | 
			(expr = rtl_Unary_Expression[t]) |
				(expr = rtl_Binary_Expression[t]) |
					(expr = rtl_Ternary_Expression[t]) )
;


//
// ($signed<5>) _b11010
// ($array[2][2] $of $integer) 0 1 2 3
//
rtl_Constant_Literal_Expression[rtlThread* thrd,rtlType* itype] returns [rtlExpression* expr]
{
	vector<string> init_values;
	rtlType* t = NULL;
}:
	LPAREN t = rtl_Type_Declaration[thrd] {assert((itype == NULL) || (t == itype));}  RPAREN
	( (iid: UINTEGER {init_values.push_back(iid->getText());}) |
		(bid: BINARY {init_values.push_back(bid->getText());}) |
			(hid : HEXADECIMAL {init_values.push_back(hid->getText());}))
	(COMMA ( (iidn: UINTEGER {init_values.push_back(iidn->getText());}) |
		(bidn: BINARY {init_values.push_back(bidn->getText());}) |
			(hidn : HEXADECIMAL {init_values.push_back(hidn->getText());})))*
	{
		rtlValue* v = Make_Rtl_Value(t, init_values);
		expr = new rtlConstantLiteralExpression(t, v);
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
	(LBRACKET ( iexpr = rtl_Expression[t,NULL] {array_flag = true; indices.push_back(iexpr); iexpr = NULL;} )+ RBRACKET)?
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
	int high_index;
	int low_index;
}:
	LPAREN 
		SLICE base_expr = rtl_Expression[t,NULL]
			hid: UINTEGER {high_index = atoi(hid->getText().c_str());}
			lid: UINTEGER {low_index = atoi(lid->getText().c_str());}
	RPAREN
	{
		expr = new rtlSliceExpression(base_expr, high_index, low_index);
	}
;

rtl_Unary_Expression[rtlThread* t] returns [rtlExpression* expr]
{
	rtlOperation  op;
	rtlExpression* rest;
}:
	LPAREN
		op = rtl_Unary_Operation 
		rest  = rtl_Expression[t,NULL]
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
		first = rtl_Expression[t,NULL]
		op = rtl_Binary_Operation
		second = rtl_Expression[t,NULL]
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
		MUX
		test_expr = rtl_Expression[t,NULL]
		if_true = rtl_Expression[t,NULL]
		if_false = rtl_Expression[t,NULL]
	RPAREN
	{
		expr = new rtlTernaryExpression(test_expr, if_true, if_false);
	}
;


rtl_Operation returns [rtlOperation op]
:
	(op = rtl_Unary_Operation) | (op = rtl_Binary_Operation)
;


rtl_Unary_Operation returns [rtlOperation op]
:
	NOT {op = __NOT;}
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
	LESS sid: SIMPLE_IDENTIFIER {label = sid->getText();} GREATER
;


rtl_Type_Declaration[rtlThread* thrd] returns [rtlType* t]
{
	t  = NULL;
}:
	((t = rtl_IntegerType_Declaration[thrd]) |
		(t = rtl_UnsignedType_Declaration[thrd]) |
			(t = rtl_SignedType_Declaration[thrd]) |
				(t = rtl_ArrayType_Declaration[thrd]))
;

rtl_IntegerType_Declaration[rtlThread* thrd] returns [rtlType* t]
{
	int L = INT_MIN;
	bool neg_L = false;
	int H = INT_MAX;
	bool neg_H = false;
}:
	INTEGER (MINUS {neg_L = true;})? lid:UINTEGER  (MINUS {neg_H = true;})? hid: UINTEGER
	{
		L = (neg_L ? - atoi(lid->getText().c_str()) : atoi (lid->getText().c_str()));
		H = (neg_H ? - atoi(hid->getText().c_str()) : atoi (hid->getText().c_str()));
		t = Find_Or_Make_Integer_Type(L,H);
	}
;

		
rtl_UnsignedType_Declaration[rtlThread* thrd] returns [rtlType* t]
{
	int width;
}:
	UNSIGNED LESS wid:UINTEGER GREATER 
	{
		t = Find_Or_Make_Unsigned_Type(atoi(wid->getText().c_str()));
	}
;

rtl_SignedType_Declaration[rtlThread* thrd] returns [rtlType* t]
{
	int width;
}:
	SIGNED LESS wid:UINTEGER GREATER 
	{
		t = Find_Or_Make_Signed_Type(atoi(wid->getText().c_str()));
	}
;

rtl_ArrayType_Declaration[rtlThread* thrd] returns [rtlType* t]
{
	vector<int> dims;
	rtlType* ele_type = NULL;
}:
	ARRAY 
	( LBRACKET did:UINTEGER RBRACKET {dims.push_back(atoi(did->getText().c_str()));} )+
	OF
	ele_type = rtl_Type_Declaration[thrd]
	{
		t = Find_Or_Make_Array_Type(dims, ele_type);
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
UINT: "$uint";
LBRACKET:"[";
RBRACKET:"]";
MUX:"$mux";
VARIABLE:"$variable";
CONSTANT:"$constant";

ASSIGNEQUAL      : ":=" ; // assignment

// comparisons
EQUAL            : "=="; // equality 
NOTEQUAL         : "!="; // not equal
LESS             : '<' ; // less-than
LESSEQUAL        : "<="; // less-than-or-equal
GREATER          : ">" ; // greater-than
GREATEREQUAL     : ">="; // greater-than-or-equal

// shifts
SHL              : "<<"; // shift-left
SHR              : ">>"; // shift-right
ROL              : "<o<" ; // rotate-left.
ROR              : ">o>" ;  // rotate-right

// concatenate
CONCAT           : "&&" ; // concatenation


// arithmetic operators
PLUS             : '+' ; // plus
MINUS            : '-' ; // minus
MUL              : '*' ; // multiply

// logical operators
NOT              : '~'     ;
OR               : '|'     ;
AND              : '&'     ;
XOR              : '^'     ;
NOR              : "~|"    ;
NAND             : "~&"    ;
XNOR             : "~^"    ;




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
INTEGER: "$integer";
UNSIGNED: "$unsigned";
SIGNED: "$signed";
ARRAY:"$array";
OF:"$of";
IF:"$if";
ELSE:"$else";
VOLATILE:"$volatile";




BINARY : "_b"  ('0' | '1')+ ;
HEXADECIMAL: "_h" (DIGIT | ('a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' ))+ ;

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

