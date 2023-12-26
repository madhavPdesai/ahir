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
#define _sLine_(u,v) {if(u != NULL) ((hierRoot*) u)->Set_Line_Number(v->getLine());}

}

options {
	language="Cpp";
}

class hierSysParser extends Parser;

options {
	// go with LL(6) grammar
	k=6;
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
sys_Description [vector<hierSystem*>& sys_vec, map<string,hierPipe*>&  global_pipe_map, map<string, int>& global_parameter_map]
{

	hierSystem* sys = NULL;
}
:
      (aA_Integer_Parameter_Declaration[global_parameter_map])*
      (hier_system_Pipe_Declaration[global_pipe_map,global_parameter_map] )*
      (sys = hier_System [sys_vec, global_pipe_map, global_parameter_map] {sys_vec.push_back(sys); })*
;

//---------------------------------------------------------------------------------------------------------------
// hier_System :  "hier_system" SIMPLE_IDENTIFIER in-pipe-decls out-pipe-decls internal-pipe decls subsystem decls
//---------------------------------------------------------------------------------------------------------------
hier_System[vector<hierSystem*>& sys_vector, map<string,hierPipe*>&  global_pipe_map,
		map<string,int>& global_parameter_map]
		returns [hierSystem* sys]

{ 
	sys =  NULL;

	hierSystemInstance* subsys    = NULL;
	rtlThread*   subthread = NULL;
	rtlString*   ti = NULL;

	bool signal_flag = false;
	bool noblock_flag = false;
	string lib_id = "work";
	int depth = 1;
	int pipe_width = 0;
	bool p2p_flag = false;
}:
	(SYSTEM 
		sysid:SIMPLE_IDENTIFIER  

		(LIBRARY libid: SIMPLE_IDENTIFIER {lib_id = libid->getText();})? 
		{
			sys = new hierSystem(sysid->getText());
			_sLine_(sys,sysid);
			sys->Set_Library(lib_id);
		}
	)
	


	// interface, pipe
	IN 
	( 
	  hier_system_Pipe_Base [sys, global_pipe_map, true,false]
        )*

	OUT
	( 
	  hier_system_Pipe_Base [sys, global_pipe_map, false,true]
	)*

	LBRACE
	( 
	  hier_system_Pipe_Base [sys, global_pipe_map, false,false]
	)*

	(

		(

			subsys = hier_System_Instance[sys, sys_vector, global_pipe_map]
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
			subthread = rtl_Thread[sys, global_parameter_map]
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


hier_system_Pipe_Base[hierSystem* sys, map<string,hierPipe* >&  global_pipe_map, bool in_flag, bool out_flag]
{
	bool	noblock_flag = false;
	bool    signal_flag = false;
	bool    p2p_flag = false;
	string pipe_name;
	int depth = 1;
	int pipe_width = 0;
	bool shiftreg_flag = false;
	bool bypass_flag = false;
	bool depth_specified = false;
	bool width_specified = false;
	bool is_clock = false;
	bool is_reset = false;
	string clk_str = "clk";
	string reset_str = "reset";
}:
		(NOBLOCK {noblock_flag = true;})? 
		((P2P {p2p_flag = true;})| (SHIFTREG {shiftreg_flag = true;})) ?
		(BYPASS {bypass_flag = true;})?

		(PIPE | 
			( 
				SIGNAL {signal_flag = true;}

				// Clock/Reset....
				(
					(CLOCK {is_clock = true;})  |
					(RESET {is_reset = true;})  
				)?
			       ))

		sidi: SIMPLE_IDENTIFIER  (uidi: UINTEGER {width_specified = true; pipe_width = atoi(uidi->getText().c_str());})?
				(DEPTH didi: UINTEGER {depth_specified = true; depth = atoi(didi->getText().c_str());})?
			{
				string pipe_name = sidi->getText();
				if(!width_specified || !depth_specified)
				{
					bool err = getPipeInfoFromGlobals(pipe_name, global_pipe_map,
										pipe_width, 
										depth, signal_flag,
										noblock_flag, p2p_flag, 
										shiftreg_flag, bypass_flag);
					if(err)
					{
						sys->Report_Error("underspecified pipe " + pipe_name + " not found in globals.");		
					}
			
				}

				if(in_flag)
					sys->Add_In_Pipe(pipe_name, pipe_width, depth, noblock_flag, p2p_flag,
								shiftreg_flag, bypass_flag);
				else if(out_flag)
					sys->Add_Out_Pipe(pipe_name, pipe_width, depth, noblock_flag, p2p_flag,
								shiftreg_flag, bypass_flag);
				else
					sys->Add_Internal_Pipe(pipe_name, pipe_width, depth, noblock_flag, p2p_flag,
								shiftreg_flag, bypass_flag);

				if(signal_flag)
				{
					sys->Report_Info ("Added signal " + sidi->getText() + " to system " + 
								sys->Get_Id());
					sys->Add_Signal(sidi->getText());

					if(is_clock)
					{
						sys->Mark_As_Clock(sidi->getText());
						sys->Report_Info ("signal " + sidi->getText() + " in system " + 
								sys->Get_Id() + " marked as clock");
					}

					if(is_reset)
					{
						sys->Mark_As_Reset(sidi->getText());
						sys->Report_Info ("signal " + sidi->getText() + " in system " + 
								sys->Get_Id() + " marked as reset");
					}
						
				}
			} 
		(CLOCK IMPLIES  ((NuLL 
				{
					clk_str = "$null"; 
					sys->Report_Info("default clock set to null in system " + sys->Get_Id() );
				}) |
				(cidi: SIMPLE_IDENTIFIER 
				{
					clk_str = cidi->getText();
					sys->Report_Info("default clock set to " + clk_str + " in system " 
								+ sys->Get_Id());
				}))
			{
			 	sys->Set_Pipe_Default_Clock(sidi->getText(), clk_str);
			})?
		(RESET IMPLIES ((NuLL {reset_str = "$null";}) |
					(ridi: SIMPLE_IDENTIFIER  {reset_str = ridi->getText();}))
			{
			 	sys->Set_Pipe_Default_Reset(sidi->getText(), reset_str);
			})?
;


hier_System_Instance[hierSystem* sys, vector<hierSystem*>& sys_vector, map<string, hierPipe* >& global_pipe_map]
		returns [hierSystemInstance* sys_inst]
{
	sys_inst = NULL;
	string lib_id = "work";
	string clk_str = "clk";
	string reset_str = "reset";
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
										global_pipe_map);
				
				}
			)*
			( 
			  (CLOCK IMPLIES ((NuLL  {clk_str = "$null";})| 
						(clk_id: SIMPLE_IDENTIFIER {clk_str = clk_id->getText();}))
				{
					if(sys_inst)
						sys_inst->Set_Default_Clock(clk_str);
				})?
			  (RESET IMPLIES ((NuLL {reset_str = "$null";}) |
						(reset_id: SIMPLE_IDENTIFIER {reset_str = reset_id->getText();}))
				{
					if(sys_inst)
						sys_inst->Set_Default_Reset(reset_str);
				})?
			)
			
			{
				//
				// 	add internal pipe to parent if needed..
				//      pass global maps to this function..
				//
				if(sys_inst)
					sys_inst->Map_Unmapped_Ports_To_Defaults(global_pipe_map);
			}
;

hier_system_Pipe_Declaration[map<string, hierPipe* >& pipe_map, map<string, int>& global_parameter_map]
{
    vector<string> oname_list;
    int pipe_depth = 1;
    int pipe_width = 0;


    bool lifo_flag = false;
    bool noblock_mode = false;
    bool in_mode = false;
    bool out_mode = false;
    bool is_port = false;
    bool is_signal = false;
    bool is_synch  = false;
    bool is_p2p   = false;
    bool shiftreg_mode = false;
    bool bypass_flag = false;
   
}
    :       ((lid:LIFO { std::cerr << "Warning: lifo flag ignored.. line number " << lid->getLine() << endl; }) |
			(nid: NOBLOCK {noblock_mode = true;}) |
			(srid: SHIFTREG {shiftreg_mode = true;})
	    )?  
		PIPE 
		(psid:SIMPLE_IDENTIFIER {oname_list.push_back(psid->getText());})+
		COLON UINT LESS wid:UINTEGER GREATER  
        {pipe_width = atoi(wid->getText().c_str());} 
        (DEPTH pipe_depth = aA_Integer_Parameter_Expression[global_parameter_map])?
		(SIGNAL {is_signal = true;})?
		(P2P    {is_p2p = true;})?
		(BYPASS {bypass_flag = true;})?
        {
            for(int I = 0, fI = oname_list.size(); I < fI; I++)
                {
                    string oname = oname_list[I];
                    
                    addPipeToGlobalMaps(oname, pipe_map, pipe_width, pipe_depth, is_signal, noblock_mode, 
						shiftreg_mode, is_p2p, bypass_flag);

                }

        }
    ;

// thread.
rtl_Thread[hierSystem* sys, map<string,int>& global_parameter_map] returns [rtlThread* t]
{
	t = NULL;
	vector<pair<string,int> > def_params;
}:
        THREAD tname:SIMPLE_IDENTIFIER {t = new rtlThread(sys, tname->getText());}
        (rtl_ObjectDeclaration[t, global_parameter_map])*
	rtl_DefaultStatementBlock[t, global_parameter_map]
        (rtl_LabeledBlockStatement[t, global_parameter_map])+

	rtl_ImmediateStatementBlock[t, global_parameter_map]
	rtl_TickStatementBlock[t, global_parameter_map]

    ;



rtl_DefaultStatementBlock[rtlThread* t, map<string,int>& global_parameter_map] 
{
	rtlStatement* stmt = NULL;
}:
	DEFAULT
		(((stmt = rtl_SplitStatement[t,false,false,global_parameter_map]) | (stmt = rtl_AssignStatement[t,false,false, global_parameter_map]) | (stmt = rtl_LogStatement[t, global_parameter_map]))  { t->Add_Default_Statement(stmt); } )*
;


rtl_ImmediateStatementBlock[rtlThread* t, map<string,int>& global_parameter_map] 
{
	rtlStatement* stmt = NULL;
}:
	NOW
		(((stmt = rtl_SplitStatement[t,false, true,global_parameter_map]) | (stmt = rtl_AssignStatement[t,false,true, global_parameter_map]) | (stmt = rtl_LogStatement[t, global_parameter_map]) | (stmt = rtl_IfStatement[t,false,true, global_parameter_map]))  { t->Add_Immediate_Statement(stmt); } )*
;

rtl_TickStatementBlock[rtlThread* t, map<string,int>& global_parameter_map] 
{
	rtlStatement* stmt = NULL;
}:
	TICK
		(((stmt = rtl_SplitStatement[t,true,false,global_parameter_map]) | (stmt = rtl_AssignStatement[t, true, false, global_parameter_map]) | (stmt = rtl_LogStatement[t, global_parameter_map]) | (stmt = rtl_IfStatement[t,true,false, global_parameter_map]))  { t->Add_Tick_Statement(stmt); } )*
;

rtl_String[hierSystem* sys] returns [rtlString* ti]
{
	ti = NULL;

	string actual;
	string formal_group;

	string clk_str = "clk";
	string reset_str = "reset";

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

		(
		formal_id: SIMPLE_IDENTIFIER { formal_group = formal_id->getText();}
			IMPLIES actual_id:SIMPLE_IDENTIFIER 
			{
				actual = actual_id->getText();
				if(ti != NULL)
					ti->Add_Port_Map_Entry(formal_group, actual);
			}
		)*
			( 
			  (CLOCK IMPLIES ((NuLL  {clk_str = "$null";})| 
						(clk_id: SIMPLE_IDENTIFIER {clk_str = clk_id->getText();}))
				{
					if(ti)
						ti->_default_clock = clk_str;
				})?
			  (RESET IMPLIES ((NuLL {reset_str = "$null";}) |
						(reset_id: SIMPLE_IDENTIFIER {reset_str = reset_id->getText();}))
				{
					if(ti)
						ti->_default_reset = reset_str;
				})?
			)
		
    ;


// rtl-object declaration
rtl_ObjectDeclaration[rtlThread* t, map<string,int>& global_parameter_map]
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
	bool pipe_flag = false;
}:
        (
            (VARIABLE {variable_flag  = true;}) |
		(CONSTANT {constant_flag  = true;}) |
		(SIGNAL   {signal_flag    = true;})  |
		(IN  ((PIPE {pipe_flag = true;}) | (SIGNAL {signal_flag = true;}))  {in_flag = true;}) |
		(OUT ((PIPE {pipe_flag = true;}) | (SIGNAL {signal_flag = true;}))  {out_flag = true;})
	)
	( sid: SIMPLE_IDENTIFIER {names.push_back(sid->getText());} )+
        COLON
        (type = rtl_Type_Declaration[t, global_parameter_map])
        (ASSIGNEQUAL init_expr=rtl_Expression[t,type, global_parameter_map] {init_expr->Evaluate(t); init_value = init_expr->Get_Value();})?

{
	for(int I = 0, fI = names.size(); I < fI; I++)
	{
		string obj_name = names[I];
		obj = NULL;
		if(in_flag)
		{
			obj = new rtlInPort(pipe_flag, obj_name, type); 
		}
		else if(out_flag)
		{
			obj = new rtlOutPort(pipe_flag, obj_name, type); 
		}
		else if(signal_flag)
		{
			obj = new rtlSignal(obj_name, type); 
		}
		else if(variable_flag) 
		{
			obj = new rtlVariable(obj_name, type); 
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
rtl_SimpleStatement[rtlThread* t, bool tick_flag, bool imm_flag, map<string,int>& global_parameter_map] returns [rtlStatement* stmt]
:
( (stmt=rtl_AssignStatement[t, tick_flag, imm_flag, global_parameter_map]) |
  (stmt=rtl_SplitStatement[t, tick_flag, imm_flag,global_parameter_map]) |
  (stmt=rtl_NullStatement[t]) |
  (stmt=rtl_LogStatement[t, global_parameter_map]) |
  (stmt=rtl_GotoStatement[t])  |
  (stmt=rtl_IfStatement[t,tick_flag,imm_flag, global_parameter_map]) )

;


// assignment statement
rtl_AssignStatement[rtlThread* t, bool tick_flag, bool imm_flag, map<string,int>& global_parameter_map] 
			returns [rtlStatement* stmt]
{
	rtlExpression* tgt = NULL;
	rtlExpression* src = NULL;
	bool volatile_flag = false;
}:

(NOW {volatile_flag = true;})?
(tgt = rtl_Expression[t,NULL, global_parameter_map])
	aid: ASSIGNEQUAL
(src = rtl_Expression[t,NULL, global_parameter_map])
{
	tgt->Set_Is_Target(true);
	stmt = new rtlAssignStatement(t, volatile_flag, tick_flag, imm_flag,  tgt, src);
	_sLine_(stmt,aid);
}
;

rtl_SplitStatement[rtlThread* t, bool tick_flag, bool imm_flag, map<string,int>& global_parameter_map]
			returns [rtlStatement* stmt]
{
	rtlExpression* src = NULL;
	rtlExpression* tgt = NULL;
	vector<rtlExpression*> targets;
	bool volatile_flag = false;
}
:
SPLIT 
(NOW {volatile_flag = true;})?
LPAREN (src = rtl_Expression[t,NULL, global_parameter_map]) RPAREN
LPAREN (tgt = rtl_Object_Reference[t, global_parameter_map] {targets.push_back(tgt);} )+ RPAREN
	{
		stmt = new rtlSplitStatement(t, volatile_flag, tick_flag, imm_flag, targets, src);
	}
;


rtl_NullStatement[rtlThread* t]  returns [rtlStatement* stmt]
{
}:
NuLL 
{
	stmt = new rtlNullStatement(t);
	//_sLine_(stmt, nid);
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
	_sLine_(stmt, sid);
}
;

rtl_LogStatement[rtlThread* t, map<string,int>& global_parameter_map] returns [rtlStatement* stmt]
{
	string lbl;
}:
LOG sid:SIMPLE_IDENTIFIER 
{
	rtlObject* obj = t->Find_Object(sid->getText());
	stmt  = new rtlLogStatement(t, obj);
	_sLine_(stmt, sid);
};


rtl_BlockStatement[rtlThread* t, bool tick_flag, bool imm_flag, map<string,int>& global_parameter_map] 
		returns [rtlBlockStatement* stmt]
{
	rtlStatement* astmt = NULL;
	vector<rtlStatement*> stmts;
}:
LBRACE
( astmt = rtl_SimpleStatement[t, tick_flag, imm_flag, global_parameter_map] {stmts.push_back(astmt); astmt = NULL;})+
RBRACE
{
	stmt = new rtlBlockStatement(t, stmts);
	}
;

rtl_IfStatement[rtlThread* t, bool tick_flag, bool imm_flag, map<string,int>& global_parameter_map] 
			returns [rtlStatement* stmt]
{
	rtlExpression* test_expr = NULL;
	rtlBlockStatement* if_block = NULL;
	rtlBlockStatement* else_block = NULL;
}
:
	IF (test_expr = rtl_Expression[t,NULL, global_parameter_map])  
        if_block  = rtl_BlockStatement[t,tick_flag, imm_flag, global_parameter_map]
	(ELSE 
            else_block = rtl_BlockStatement[t,tick_flag, imm_flag, global_parameter_map]
        )?
	{ 
		stmt = (rtlStatement*) new rtlIfStatement(t, test_expr, if_block, else_block);
	}
;

rtl_LabeledBlockStatement[rtlThread* t, map<string,int>& global_parameter_map]
{
	rtlStatement* astmt = NULL;
	rtlLabeledBlockStatement* bstmt = NULL;
	vector<rtlStatement*> stmts;
	string lbl;
}:
	lbl  = rtl_Label
	LBRACE
		( astmt = rtl_SimpleStatement[t,false, false, global_parameter_map] 
						{stmts.push_back(astmt); astmt = NULL;})+
	RBRACE
	{
		bstmt = new rtlLabeledBlockStatement(t, lbl, stmts);
		t->Add_Statement(bstmt);
	}
;

rtl_Expression[rtlThread* t, rtlType* type, map<string,int>& global_parameter_map] 
			returns [rtlExpression* expr]
{
	expr = NULL;
}
:
	( (expr = rtl_Constant_Literal_Expression[t,type, global_parameter_map]) |
		(expr = rtl_Object_Reference[t, global_parameter_map]) | 
		   (expr = rtl_Slice_Expression[t, global_parameter_map]) | 
			(expr = rtl_Unary_Expression[t, global_parameter_map]) |
				(expr = rtl_Binary_Expression[t, global_parameter_map]) |
					(expr = rtl_Ternary_Expression[t, global_parameter_map]) )
;


//
// ($signed<5>) _b11010
// ($array[2][2] $of $integer) 0 1 2 3
//
rtl_Constant_Literal_Expression[rtlThread* thrd,rtlType* itype,map<string,int>& global_parameter_map] 
		returns [rtlExpression* expr]
{
	vector<string> init_values;
	rtlType* t = NULL;
	int iid;
	string tmp;
}:
	lpid:LPAREN t = rtl_Type_Declaration[thrd, global_parameter_map] {assert((itype == NULL) || (t == itype));}  RPAREN
	( (iid =  aA_Integer_Parameter_Expression[global_parameter_map] 
			{tmp=UintToStr((unsigned int) iid);
				init_values.push_back(tmp);}) |
		(bid: BINARY {init_values.push_back(bid->getText());}) |
			(hid : HEXADECIMAL {init_values.push_back(hid->getText());}))
	(COMMA ( (iid = aA_Integer_Parameter_Expression[global_parameter_map] 
				{init_values.push_back(UintToStr((unsigned int) iid));}) |
		(bidn: BINARY {init_values.push_back(bidn->getText());}) |
			(hidn : HEXADECIMAL {init_values.push_back(hidn->getText());})))*
	{
		rtlValue* v = Make_Rtl_Value(t, init_values);
		expr = new rtlConstantLiteralExpression(t, v);
		_sLine_(expr, lpid);
	}	
;


rtl_Object_Reference[rtlThread* t, map<string,int>& global_parameter_map] returns [rtlExpression* expr]
{
	string obj_name;
	vector<rtlExpression*> indices;	
	bool array_flag = false;
	rtlExpression* iexpr = NULL;
	bool req_flag = false;
	bool ack_flag = false;
}:
	sid: SIMPLE_IDENTIFIER {obj_name = sid->getText();}

	(( REQ {req_flag = true;}) | (ACK {ack_flag = true;}))?

	(LBRACKET ( iexpr = rtl_Expression[t,NULL, global_parameter_map] {array_flag = true; indices.push_back(iexpr); iexpr = NULL;} )+ RBRACKET)?
	{
		rtlObject* obj = t->Find_Object(obj_name);
		if(obj == NULL)
			t->Report_Error("object " + obj_name + " not found in thread " + t->Get_Id());
		

		if(array_flag)
			expr = new rtlArrayObjectReference(obj, indices);
		else
			expr = new rtlSimpleObjectReference(obj,req_flag, ack_flag);

		_sLine_(expr, sid);
	}
;

rtl_Slice_Expression[rtlThread* t, map<string,int>& global_parameter_map] returns [rtlExpression* expr]
{
	rtlExpression* base_expr;
	int high_index;
	int low_index;
}:
	lpid: LPAREN 
		SLICE base_expr = rtl_Expression[t,NULL, global_parameter_map]
			high_index = aA_Integer_Parameter_Expression[global_parameter_map]
			low_index  = aA_Integer_Parameter_Expression[global_parameter_map]
	RPAREN
	{
		expr = new rtlSliceExpression(base_expr, high_index, low_index);
		_sLine_(expr, lpid);
	}
;

rtl_Unary_Expression[rtlThread* t, map<string,int>& global_parameter_map] returns [rtlExpression* expr]
{
	rtlOperation  op;
	rtlExpression* rest;
}:
	lpid: LPAREN
		op = rtl_Unary_Operation 
		rest  = rtl_Expression[t,NULL, global_parameter_map]
	RPAREN
	{
		expr = new rtlUnaryExpression(op, rest);
		_sLine_(expr, lpid);
	}
;

rtl_Binary_Expression[rtlThread* t, map<string,int>& global_parameter_map] returns [rtlExpression* expr]
{
	rtlExpression* first = NULL;
	rtlExpression* second = NULL;
	rtlOperation op;
}:
	lpid: LPAREN
		first = rtl_Expression[t,NULL, global_parameter_map]
		op = rtl_Binary_Operation
		second = rtl_Expression[t,NULL, global_parameter_map]
	RPAREN	
	{
		expr = new rtlBinaryExpression(op, first, second);
		_sLine_(expr, lpid);
	}
;

rtl_Ternary_Expression[rtlThread* t, map<string,int>& global_parameter_map] returns [rtlExpression* expr]
{
	rtlExpression* test_expr = NULL;
	rtlExpression* if_true = NULL;
	rtlExpression* if_false = NULL;
}:
	lpid: LPAREN
		MUX
		test_expr = rtl_Expression[t,NULL, global_parameter_map]
		if_true = rtl_Expression[t,NULL, global_parameter_map]
		if_false = rtl_Expression[t,NULL, global_parameter_map]
	RPAREN
	{
		expr = new rtlTernaryExpression(test_expr, if_true, if_false);
		_sLine_(expr, lpid);
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
        ( id_div:DIV { op = __DIV;}) | 
        ( id_EQUAL:EQUAL { op = __EQUAL;}) | 
        ( id_notequal:NOTEQUAL { op = __NOTEQUAL;}) | 
        ( id_less:LESS { op = __LESS;}) | 
        ( id_lessequal:LESSEQUAL { op = __LESSEQUAL;}) | 
        ( id_greater:GREATER { op = __GREATER;}) | 
        ( id_concat:CONCAT { op = __CONCAT;}) | 
        ( id_greaterequal:GREATEREQUAL { op = __GREATEREQUAL;})  
;

rtl_Label returns [string label]
:
	LESS sid: SIMPLE_IDENTIFIER {label = sid->getText();} GREATER
;


rtl_Type_Declaration[rtlThread* thrd, map<string,int>& global_parameter_map] returns [rtlType* t]
{
	t  = NULL;
}:
	((t = rtl_IntegerType_Declaration[thrd, global_parameter_map]) |
		(t = rtl_UnsignedType_Declaration[thrd, global_parameter_map]) |
			(t = rtl_SignedType_Declaration[thrd, global_parameter_map]) |
				(t = rtl_ArrayType_Declaration[thrd, global_parameter_map]))
;

rtl_IntegerType_Declaration[rtlThread* thrd, map<string,int>& global_parameter_map] returns [rtlType* t]
{
	int L = INT_MIN;
	bool neg_L = false;
	int H = INT_MAX;
	bool neg_H = false;
}:
	INTEGER (MINUS {neg_L = true;})? L=aA_Integer_Parameter_Expression[global_parameter_map]
			  (MINUS {neg_H = true;})? H=aA_Integer_Parameter_Expression[global_parameter_map]
	{
		L = (neg_L ? - L : L);
		H = (neg_H ? - H : H);

		t = Find_Or_Make_Integer_Type(L,H);
	}
;

		
rtl_UnsignedType_Declaration[rtlThread* thrd, map<string,int>& global_parameter_map] returns [rtlType* t]
{
	int width;
}:
	UNSIGNED LESS width=aA_Integer_Parameter_Expression[global_parameter_map] GREATER 
	{
		t = Find_Or_Make_Unsigned_Type(width);
	}
;

rtl_SignedType_Declaration[rtlThread* thrd, map<string,int>& global_parameter_map] returns [rtlType* t]
{
	int width;
}:
	SIGNED LESS width=aA_Integer_Parameter_Expression[global_parameter_map] GREATER 
	{
		t = Find_Or_Make_Signed_Type(width);
	}
;

rtl_ArrayType_Declaration[rtlThread* thrd, map<string,int>& global_parameter_map] returns [rtlType* t]
{
	vector<int> dims;
	rtlType* ele_type = NULL;
	int did;
}:
	ARRAY 
	( LBRACKET did = aA_Integer_Parameter_Expression[global_parameter_map] RBRACKET 
			{dims.push_back(did);} )+
	OF
	ele_type = rtl_Type_Declaration[thrd, global_parameter_map]
	{
		t = Find_Or_Make_Array_Type(dims, ele_type);
	}
;

//----------------------------------------------------------------------------------------------------------
// aA_Integer_Parameter_Declaration returns int
//----------------------------------------------------------------------------------------------------------
aA_Integer_Parameter_Declaration [map<string, int>& global_parameter_map]
{
	string param_name;
	int param_value;
	int lno;
}:

PARAMETER sid:SIMPLE_IDENTIFIER param_value = aA_Integer_Parameter_Expression [global_parameter_map]
   {
 	param_name = sid->getText();
	if(global_parameter_map.find(param_name) != global_parameter_map.end())
	{
		cerr << "Error: parameter " << param_name << " redeclared on line " <<
			sid->getLine() << endl;
	}
	global_parameter_map[param_name] = param_value;
	cerr << "Info: added parameter " << param_name << " with value " << param_value << endl;
   }
;

//----------------------------------------------------------------------------------------------------------
// aA_Integer_Parameter_Expression returns int
//----------------------------------------------------------------------------------------------------------
aA_Integer_Parameter_Expression[map<string, int>& global_parameter_map]  returns [int expr_value]
{
  int line_number = 0;	
}:
  (iid: UINTEGER {expr_value = atoi(iid->getText().c_str()); line_number = iid->getLine();})
	| 
  (hid: HEXCSTYLEINTEGER  {sscanf(hid->getText().c_str(),"0x%x", &expr_value);
				line_number = hid->getLine();})
	|
  (sid: SIMPLE_IDENTIFIER { 
				map<string,int>::iterator iter = global_parameter_map.find(sid->getText());
				line_number = sid->getLine();
				if(iter == global_parameter_map.end())
				{
					cout << "Error: parameter " << sid->getText() << " not found (line " << line_number 
						<< ")" << endl;	
				}
				else
				{
					expr_value = (*iter).second;	
				}
			    })
	|
  (expr_value = aA_Integer_Parameter_Expression_Nontrivial [global_parameter_map])
;


aA_Integer_Parameter_Expression_Nontrivial [map<string,int>& global_parameter_map] returns [int expr_value]
{
    int val_1;
    int val_2;
    int val_3;
    rtlOperation opid;
    int  line_number;
}:
  lpid: LBRACE
     ( 
	(NOT val_1 = aA_Integer_Parameter_Expression [global_parameter_map] {expr_value = (~ val_1);}) 
	|
	(MINUS val_1 = aA_Integer_Parameter_Expression [global_parameter_map] {expr_value = (- val_1);}) 
	|
	(val_1 = aA_Integer_Parameter_Expression [global_parameter_map]
			opid = rtl_Binary_Op
              			val_2 = aA_Integer_Parameter_Expression [global_parameter_map] 
		{ 
			line_number = lpid->getLine();
			if(opid == __PLUS)
			{
				expr_value = val_1 + val_2;
			}
			else if(opid == __MINUS)
			{
				expr_value = val_1 - val_2;
			}
			else if(opid == __MUL)
			{
				expr_value = val_1 * val_2;
			}
			else if(opid == __DIV)
			{
				expr_value = val_1 / val_2;
			}
			else if(opid == __EQUAL)
			{
				expr_value = val_1 == val_2;
			}
			else if(opid == __NOTEQUAL)
			{
				expr_value = val_1 != val_2;
			}
			else if(opid == __LESS)
			{
				expr_value = val_1 < val_2;
			}
			else if(opid == __LESSEQUAL)
			{
				expr_value = val_1 <= val_2;
			}
			else if(opid == __GREATER)
			{
				expr_value = val_1 > val_2;
			}
			else if(opid == __GREATEREQUAL)
			{
				expr_value = val_1 >= val_2;
			}
			else if(opid == __SHL)
			{
				expr_value = val_1 << val_2;
			}
			else if(opid == __SHR)
			{
				expr_value = val_1 >> val_2;
			}
			else if(opid == __OR)
			{
				expr_value = val_1 | val_2;
			}
			else if(opid == __AND)
			{
				expr_value = val_1 & val_2;
			}
			else if(opid == __XOR)
			{
				expr_value = val_1 ^ val_2;
			}
			else if(opid == __POW)
			{
				expr_value = IntPower(val_1, val_2);
			}
			else
			{
				cerr << "Unsupported binary operation in parameter expression on line " << lpid->getLine() << endl;
			}
		}
   	)
	|
  	(MUX val_1 = aA_Integer_Parameter_Expression [global_parameter_map]
		val_2 = aA_Integer_Parameter_Expression [global_parameter_map]
		   val_3 = aA_Integer_Parameter_Expression [global_parameter_map]
		{expr_value = (val_1 ? val_2 : val_3);}
	))
					RBRACE
;

//----------------------------------------------------------------------------------------------------------
// aA_Binary_Op : OR | AND | NOR | NAND | XOR | XNOR | SHL | SHR | ROL | ROR | PLUS | MINUS | DIV | MUL | EQUAL | NOTEQUAL | LESS | LESSEQUAL | GREATER | GREATEREQUAL 
//----------------------------------------------------------------------------------------------------------
rtl_Binary_Op returns [rtlOperation op] : 
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
        ( id_div:DIV { op = __DIV;}) | 
        ( id_mul:MUL { op = __MUL;}) | 
        ( id_EQUAL:EQUAL { op = __EQUAL;}) | 
        ( id_notequal:NOTEQUAL { op = __NOTEQUAL;}) | 
        ( id_less:LESS { op = __LESS;}) | 
        ( id_lessequal:LESSEQUAL { op = __LESSEQUAL;}) | 
        ( id_greater:GREATER { op = __GREATER;}) | 
        ( id_greaterequal:GREATEREQUAL { op = __GREATEREQUAL;}) | 
	( id_power: POWER {op = __POW;})  
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
DIV              : '/' ; // multiply

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
NOBLOCK: "$noblock";
SHIFTREG: "$shiftreg";
P2P: "$p2p";
BYPASS:"$bypass";
SIGNAL: "$signal";
INSTANCE: "$instance";
LIBRARY: "$library";
DEPTH: "$depth";
THREAD: "$thread";
STRING: "$string";
NuLL: "$null";
EMIT: "$emit";
GOTO: "$goto";
LOG: "$log";
INTEGER: "$integer";
UNSIGNED: "$unsigned";
SIGNED: "$signed";
ARRAY:"$array";
OF:"$of";
IF:"$if";
ELSE:"$else";
NOW:"$now";
SPLIT:"$split";
TICK:"$tick";
DEFAULT:"$default";
REQ: "$req";
ACK: "$ack";
SLICE: "$slice";
PARAMETER     : "$parameter";
CLOCK: "$clk";
RESET: "$reset";

POWER            : "**" ; // powering operation.


BINARY : "_b"  ('0' | '1')+ ;
HEXADECIMAL: "_h" (DIGIT | ('a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' ))+ ;
HEXCSTYLEINTEGER          : "0x" (DIGIT | ('a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' ))+ ;

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
SIMPLE_IDENTIFIER options {testLiterals=true;} : ALPHA (ALPHA | DIGIT | '_' )*; 

// base
protected ALPHA: 'a'..'z'|'A'..'Z';
protected DIGIT:'0'..'9';

