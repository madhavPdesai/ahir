//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#include <AaProgram.h>
#include <Aa2VC.h>

void Write_VC_Equivalence_Operator(string inst_name,
				   string input,
				   string output,
				   string guard_string,
				   ostream& ofile)
{
  vector<string> i; i.push_back(input);
  vector<string> o; o.push_back(output);
  Write_VC_Equivalence_Operator(inst_name,i,o,guard_string,ofile);
}

void Write_VC_Constant_Declaration(string wire_name, AaType* t, string initial_value,
				   ostream& ofile)
{
  AaValue* v = Make_Aa_Value(NULL,t);
  v->Set_Value(initial_value);
  Write_VC_Constant_Declaration(wire_name, t, v, ofile);
  delete v;
}


void Write_VC_Constant_Declaration(string wire_name, string type_name, string initial_value, 
				   ostream& ofile)
{
  ofile << "$constant $W[" << wire_name << "] : " << type_name << " := " << initial_value << endl; 
}

void Write_VC_Constant_Declaration(string name, AaType* type, AaValue* value, ostream& ofile)
{
  Write_VC_Constant_Declaration(name,
				type->Get_VC_Name(),
				value->To_VC_String() + "// " + value->To_C_String(),
				ofile);
}

void Write_VC_Constant_Pointer_Declaration(string name, 
					   string wire_name, 
					   AaUintType* type, 
					   string value,
					   ostream& ofile)
{
  string type_name = "$pointer<" + name + ">";
  AaValue* v = Make_Aa_Value(NULL,type);
  v->Set_Value(value);
  Write_VC_Constant_Declaration(wire_name,
				type_name,
				v->To_VC_String(),
				ofile);
  delete v;
}



void Write_VC_Wire_Declaration(string wire_name, string type_name, ostream& ofile)
{
  ofile << "$W[" << wire_name << "] : " << type_name << endl;
}

void Write_VC_Equivalence_Operator(string inst_name,
				   vector<string>& inwires,
				   vector<string>& outwires,
			           string guard_string,
				   ostream& ofile)
{
  ofile << "&/ [" << inst_name << "] ";
  ofile << "(";
  for(int idx=0; idx < inwires.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << inwires[idx];
    }
  ofile << ") ";

  ofile << "(";
  for(int idx=0; idx < outwires.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << outwires[idx];
    }
  ofile << ") " << guard_string << endl;

}

bool Is_Trivial_VC_Type_Conversion(AaType* src_type, AaType* target_type)
{
  bool ret_val;
  if((target_type == src_type) || 
     (target_type->Is_Integer_Type() && src_type->Is_Integer_Type()))
    ret_val = true;
  else
    ret_val = false;

  return(ret_val);
}

void Write_VC_Unary_Operator(AaOperation op, 
			     string inst_name, 
			     string src_name, 
			     AaType* src_type,
			     string target_name,
			     AaType* target_type,
			     string guard_string,
			     bool flow_through,
			     bool bitcast_flag,
			     bool full_rate, 
			     ostream& ofile)
{
  string op_name;
  string slice_string;
  if(op == __NOT)
    {
      op_name = "~";
    }
  else
    {
      if(op == __NOP)
	{
	  // the assign operation is multifaceted!
	  string src_kind, dest_kind;

	  dest_kind = ((target_type->Is("AaFloatType")) ? "F" :
		       (target_type->Is("AaIntType") ? "S" : "U"));

	  src_kind = ((src_type->Is("AaFloatType")) ? "F" :
		       (src_type->Is("AaIntType") ? "S" : "U"));

	  if(bitcast_flag || ((target_type == src_type) || ( (dest_kind == "U" && src_kind == "U"))))
	    {
	      	// just an interlock-buffer.
	      	op_name = "# :=";
	    }
	  else 
	    op_name = "$" + dest_kind + ":=$" + src_kind;

	}
      else if(op == __DECODE)
	{
	    op_name = "$decode";
	}
      else if(op == __ENCODE)
        {
	    op_name = "$encode";
        }
      else if(op == __PRIORITYENCODE)
        {
	    op_name = "$priority_encode";
        }
      else if(op == __BITREDUCEOR)
        {
	    op_name = "!|";
        }
      else if(op == __BITREDUCEAND)
        {
	    op_name = "!&";
        }
      else if(op == __BITREDUCEXOR)
        {
	    op_name = "!^";
        }
    }

  string sflow_through = (flow_through ? " $flowthrough" : "");
  string sfull_rate    = ((full_rate && !flow_through) ? " $fullrate" : "");
  ofile << op_name << " [" << inst_name << "] "
	<< "(" << src_name <<  ") "
	<< "(" << target_name << ")  " << guard_string << sflow_through << sfull_rate <<  endl;
}


void Write_VC_Bitmap_Operator(string inst_name, 
			      string src_name, 
			      string target_name,
			      AaType* src_type,
			      vector<pair<int,int> >& bmapv,
			      string guard_string,
			      bool flow_through,
			      bool full_rate, 
			      ostream& ofile)
{
	ofile << ":X= [" << inst_name << "] ";
	ofile << "( " << src_name << " ";
	for(int idx = 0, fidx = bmapv.size(); idx < fidx; idx++)
	{
		ofile << bmapv[idx].first << " " << bmapv[idx].second << " ";
	}
	ofile << ") ";
	ofile << "(" << target_name << ")" ;
  	string sflow_through = (flow_through ? " $flowthrough" : "");
        string sfull_rate    = ((full_rate && !flow_through) ? " $fullrate" : "");
	ofile << " " << guard_string << " " << sflow_through << sfull_rate <<  endl;
}

void Write_VC_Register( string inst_name, 
			string src_name, 
			string target_name,
                        string guard_string,
			ostream& ofile)
{
  ofile << ":= [" << inst_name << "] " 
	<< "(" << src_name << ") "
	<< "(" << target_name << ") " << guard_string << endl;
}

void Write_VC_Interlock_Buffer( string inst_name, 
			string src_name, 
			string target_name,
                        string guard_string,
			bool flow_through, 
			bool full_rate, 
			bool cut_through,
			bool in_phi,
			ostream& ofile)
{
  string sflow_through = (flow_through ? " $flowthrough" : "");
  string sfull_rate    = ((full_rate && !flow_through) ? " $fullrate" : "");

  ofile << "# := [" << inst_name << "] " 
	<< "(" << src_name << ") "
	<< "(" << target_name << ") " << (cut_through ? " $cut_through " : " ")  
	<<  (in_phi ? " $in_phi "  : " ")
	<< guard_string << " " << sflow_through <<  " " << sfull_rate << endl;
}

void Write_VC_Binary_Operator(AaOperation op, 
			      string inst_name, 
			      string src1, 
			      AaType* src1_type,
			      string src2, 
			      AaType* src2_type, 
			      string target_name,
			      AaType* target_type,
			      string guard_string,
			      bool add_hash,
			      bool flow_through,
			      bool full_rate, 
			      ostream& ofile)
{
  string op_name;

  if(add_hash) 
	op_name = "# ";

  // Logical operations.. add-hash 
  // if add_hash is true.
  if(op == __OR) op_name += "|";
  else if(op == __AND) op_name += "&";
  else if(op == __XOR) op_name += "^";
  else if(op == __NOR) op_name += "~|";
  else if(op == __NAND) op_name += "~&";
  else if(op == __XNOR) op_name += "~^";
  else if(op == __SHL) op_name = "<<";
  //  for SHR, if the types of src1,src2 are integer,
  //  then we use the signed version.
  else if(op == __SHR)
    {
      if(target_type->Is("AaIntType"))
	op_name = "$S>>";
      else
	op_name = ">>";
    }
  else if(op == __ROR) op_name = ">o>";
  else if(op == __ROL) op_name = "<o<";
  else if(op == __PLUS) op_name = "+";
  else if(op == __MINUS) op_name = "-";
  else if(op == __MUL) op_name = "*";
  else if(op == __DIV) op_name = "/";
  else if(op == __EQUAL) op_name = "==";
  else if(op == __NOTEQUAL) op_name = "!=";
  //
  // for comparisons, if the types of src1,src2 are integer,
  //       then we use the signed version.
  else if(op == __LESS)
    {
      if(src1_type->Is("AaIntType") || src1_type->Is("AaFloatType"))
	op_name = "$S<$S";
      else
	op_name = "<";
    }
  else if(op == __LESSEQUAL) 
    {
      if(src1_type->Is("AaIntType") || src1_type->Is("AaFloatType"))
	op_name = "$S<=$S";
      else 
	op_name = "<=";
    }
  else if(op == __GREATER)
    {
      if(src1_type->Is("AaIntType") || src1_type->Is("AaFloatType"))
	op_name = "$S>$S";
      else 
	op_name = ">";
    }
  else if(op == __GREATEREQUAL)
    {
      if(src1_type->Is("AaIntType") || src1_type->Is("AaFloatType"))
	op_name = "$S>=$S";
      else 
	op_name = ">=";
    }
  else if(op == __CONCAT) op_name = "&&";
  else if(op == __BITSEL) op_name = "[]";
  else if(op == __UNORDERED) op_name = "><";
  else
    assert(0);

  string sflow_through = (flow_through ? " $flowthrough" : "");
  string sfull_rate    = ((full_rate && !flow_through) ? " $fullrate" : "");
  ofile << op_name << "[" << inst_name << "]" << " "
	<< "(" << src1 << " " << src2 << ") "
	<< "(" << target_name << ") " << guard_string <<  " " << sflow_through <<  " " << sfull_rate <<  endl;
}

void Write_VC_Call_Operator(string inst_name, 
			    string module_name, 
			    vector<pair<string,AaType*> >& inargs,
			    vector<pair<string,AaType*> >& outargs,
			     string guard_string,
			    bool flow_through,
			    bool full_rate,
			    ostream& ofile)
{
  string sflow_through = (flow_through ? " $flowthrough" : "");
  string sfull_rate = (full_rate ? " $fullrate" : "");
  ofile << "$call [" << inst_name << "] $module " << module_name 
	<< "(";
  for(int idx = 0; idx < inargs.size(); idx++)
    {
      if(idx > 0)
	ofile <<  " ";
      ofile << inargs[idx].first;
    }
  ofile << ") (";
  for(int idx = 0; idx < outargs.size(); idx++)
    {
      if(idx > 0)
	ofile <<  " ";
      ofile << outargs[idx].first;
    }
  ofile << ") " << guard_string << " " << sflow_through << sfull_rate << endl;
}

void Write_VC_Phi_Operator(string inst_name,
			   vector<pair<string,AaType*> >& sources,
			   string target,
			   AaType* target_type,
			   bool pipeline_flag,
			   bool full_rate, 
			   ostream& ofile)
{
  if(pipeline_flag)
	ofile << "# ";

  ofile << "$phi [" << inst_name << "] " ;
  ofile << "(";
  for(int idx = 0; idx < sources.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << sources[idx].first;
    }
  ofile << ") ";
  ofile << "( " << target << " )"  <<  " " << (full_rate ? "$fullrate" : "") << endl;
}

void Write_VC_Link(string inst_name, vector<string>& reqs, vector<string>& acks, ostream& ofile)
{
  ofile << inst_name << " <=> (" ;
  for(int idx = 0; idx < reqs.size(); idx++)
    {
      if(idx > 0) ofile << " ";
      ofile << reqs[idx];
    }
  ofile << ") (";
  for(int idx = 0; idx < acks.size(); idx++)
    {
      if(idx > 0) ofile << " ";
      ofile << acks[idx];
    }
  ofile << ")" << endl;
}
void Write_VC_Branch_Instance(string inst_name, vector<pair<string,AaType*> >& br_inputs, ostream& ofile)
{
  ofile << "==0? [" << inst_name << "] (";
  for(int idx = 0; idx < br_inputs.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << br_inputs[idx].first;
    }
  ofile << ")" << endl;
}

void Write_VC_Branch_With_Bypass_Instance(string inst_name, vector<pair<string,AaType*> >& br_inputs, ostream& ofile)
{
  Write_VC_Branch_Instance(inst_name, br_inputs,ofile);
  ofile << " $flowthrough" << endl;
}

void Write_VC_Pointer_Declaration(string name, string wire_name, AaType* type,ostream& ofile)
{
  string type_name = "$pointer<" + name + ">";
  Write_VC_Wire_Declaration(wire_name,
			    type_name,
			    ofile);
}

void Write_VC_Wire_Declaration(string name, AaType* type, ostream& ofile)
{
  string type_name = type->Get_VC_Name();
  Write_VC_Wire_Declaration(name,
			    type_name,
			    ofile);
}

void Write_VC_Intermediate_Wire_Declaration(string name, AaType* type, ostream& ofile)
{
  string type_name = type->Get_VC_Name();
  ofile << "$intermediate ";
  Write_VC_Wire_Declaration(name,
			    type_name,
			    ofile);
}


void Write_VC_Pipe_Declaration(string name, int width,int depth, bool lifo_mode, bool noblock_flag,
			bool in_flag, bool out_flag, bool signal_flag, bool p2p_flag, bool shiftreg_flag,  
			bool full_rate, bool bypass, ostream& ofile)
{
  if(lifo_mode)
	ofile << "$lifo ";
  else if(noblock_flag)
	ofile << "$noblock ";

  if(shiftreg_flag)
	  ofile << " $shiftreg ";
  
  ofile << "$pipe [" << name << "] " << width << " " << "$depth " << depth << " ";

  if(in_flag)
	  ofile << "$in  ";
  else if(out_flag)
	ofile << "$out  ";

  if(signal_flag)
	  ofile << "$signal ";

  if(p2p_flag)
	  ofile << " $p2p ";

  if(full_rate)
	  ofile << " $fullrate ";

  if(bypass)
	  ofile << " $bypass ";

  ofile << endl;
}
 

void Write_VC_Memory_Space_Declaration(string space_name, string obj_name, AaType* type, ostream& ofile)
{
  assert(0);
}

void Write_VC_Load_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			   string guard_string,
			    ostream& ofile)
{
  ofile << "$load [" << inst_name << "] $from " << ms_name 
	<< " (" << addr_name  << ") (" << data_name << ") " << guard_string <<  endl;
}
void Write_VC_Store_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			   string guard_string,
			     ostream& ofile)
{
  ofile << "$store [" << inst_name << "] $to " << ms_name 
	<< " (" << addr_name  << " " << data_name << ") " << guard_string <<  endl;
}
void Write_VC_IO_Input_Port(AaPipeObject* obj, string inst_name, string data_name,
			    string guard_string, bool full_rate, bool barrier_flag,
			    ostream& ofile)
{
  string frate = (full_rate ? " $fullrate " : "");
  ofile << "$ioport $in [" << inst_name  << "] (" << obj->Get_VC_Name() << ") ("
	<< data_name << ") " <<  (barrier_flag ? "$barrier " : "") << guard_string << frate <<  endl;
}
void Write_VC_IO_Output_Port(AaPipeObject* obj, string inst_name, string data_name,
			    string guard_string, bool full_rate,
			     ostream& ofile)
{
  string frate = (full_rate ? " $fullrate " : "");
  ofile << "$ioport $out [" << inst_name  << "] "
	<< " (" << data_name << ") " 
	<< "(" << obj->Get_VC_Name() << ") "
	<< guard_string << frate << endl;
}

void Write_VC_Select_Operator(string inst_name,
			      string test_name,
			      AaType* test_type,
			      string if_true_name,
			      AaType* if_true_type,
			      string if_false_name,
			      AaType* if_false_type,
			      string target_name,
			      AaType* target_type,
			    string guard_string,
				bool flow_through,
				bool full_rate,
			      ostream& ofile)
{
  string sflow_through = (flow_through ? " $flowthrough" : "");
  string sfull_rate    = ((full_rate && !flow_through) ? " $fullrate" : "");
  ofile << "? [" << inst_name << "] " 
	<< "(" << test_name << " " << if_true_name << " " << if_false_name << ") "
	<< "(" << target_name << ") " << guard_string <<  sflow_through << sfull_rate << endl;
}


void Write_VC_Slice_Operator(string inst_name,
			     string in_name,
			     string out_name,
			     int high_index,
			     int low_index,
			    string guard_string,
				bool flow_through,
				bool full_rate, 
			     ostream& ofile)
{
  string sflow_through = (flow_through ? " $flowthrough" : "");
  string sfull_rate    = ((full_rate && !flow_through) ? " $fullrate" : "");
  ofile << "[:] [" << inst_name << "] (" << in_name << " " << high_index << " " << low_index
	<< ") (" << out_name << ") " << guard_string << sflow_through << sfull_rate <<  endl;
}


void Write_VC_Load_Store_Dependency(bool pipeline_flag,
				    AaMemorySpace* ms,
				    AaRoot* src,
				    AaRoot* tgt,
				    ostream& ofile)
{
  int ms_index = ms->_mem_space_index;

  string delay_trans = src->Get_VC_Name() + "_" + tgt->Get_VC_Name() + "_delay";
  ofile << "$T [" << delay_trans << "] $delay" << endl;


  if(ms_index >= 0)
  { 
  	ofile << "// " << src->Get_VC_Name() << (src->Writes_To_Memory_Space(ms) ? "(store)" : "(load)" )
		<<  " -> " 
		<< tgt->Get_VC_Name()  << (tgt->Writes_To_Memory_Space(ms) ? "(store)" : "(load)" ) << endl;

	if(tgt->Is_Expression() &&  !tgt->Is("AaFunctionCallExpression"))
	{
		assert(ms_index == ((AaExpression*) tgt)->Get_VC_Memory_Space_Index());
	}

	if(ms->Get_Is_Ordered() && src->Is_Expression()  && !src->Is("AaFunctionCallExpression"))
	{
  		ofile << __SST(tgt) << " <-& (" << delay_trans << ")" << endl;
  		ofile << delay_trans << " <-& (" << __SCT(src) << ")" << endl;
		//if(pipeline_flag)
		//{
			//__MJ(src->Get_VC_Start_Transition_Name(), tgt->Get_VC_Active_Transition_Name());
		//}
	}
	else
	{
  		ofile << __SST(tgt) << " <-& (" << delay_trans << ")" << endl;
  		ofile << delay_trans << " <-& (" << __UCT(src) << ")" << endl;
		//if(pipeline_flag)
		//{
			//__MJ(src->Get_VC_Start_Transition_Name(), tgt->Get_VC_Completed_Transition_Name());
		//}
	}
   }
}

void Write_VC_Load_Store_Loop_Pipeline_Ring_Dependency(AaMemorySpace* ms,
							set<AaRoot*>& leading_accesses,
							set<AaRoot*>& trailing_accesses,
							ostream& ofile)
{


	string mem_space_name = ms->Get_VC_Name();
	ofile << "// reenable across ring for memory space " << mem_space_name << endl;
	
	if(leading_accesses == trailing_accesses)
	{
		ofile << "// leading and trailing sets are the same... no ring dependency" << endl;
		return;
	}

	string reenable_trans = "ring_reenable_" + Make_VC_Legal(mem_space_name);
	__T(reenable_trans)

	for(set<AaRoot*>::iterator titer = trailing_accesses.begin(),
		ftiter = trailing_accesses.end();
		titer != ftiter;
		titer++)
	{
		AaRoot* expr = *titer;
		if(ms->Get_Is_Ordered() && expr->Is_Expression() && !expr->Is("AaFunctionCallExpression"))
		{
			ofile << "// ordered memory-subsystem." << endl;
			__J(reenable_trans, __SCT(expr))
		}
		else
		{
			__J(reenable_trans, __UCT(expr))
		}
			
	}

	for(set<AaRoot*>::iterator liter = leading_accesses.begin(),
		fliter = leading_accesses.end();
		liter != fliter;
		liter++)
	{
		AaRoot* expr = *liter;
		__MJ(__SST(expr), reenable_trans, false) // no bypass
	}
}

// sample complete of src to sample complete of start.
// need to modify this.  we need to enforce ordering only
// on reads and only on writes
void Write_VC_Pipe_Dependency(bool pipeline_flag, 
			      AaExpression* first,
			      AaExpression* second,
			      bool mark_flag,
			      ostream& ofile)
{
  ofile << "// pipe dependency " << endl;
  if(mark_flag)
  {
	  __MJ(__SST(second), __UCT(first), false); // no bypass
  }
  else
  {
	  __J(__SST(second), __UCT(first)); // no need for delay
  }
}

void Write_VC_Reenable_Joins(set<string>& active_reenable_points, 
		map<string, bool>& active_reenable_bypass_flags, string& rel_tran, 
		bool force_bypass_flag, ostream& ofile)
{
	for(set<string>::iterator siter = active_reenable_points.begin(),
			fiter = active_reenable_points.end();
			siter != fiter;
			siter++)
	{
		assert(active_reenable_bypass_flags.find(*siter) != active_reenable_bypass_flags.end());

		bool bypass_this = (force_bypass_flag || active_reenable_bypass_flags[(*siter)]);
		__MJ((*siter), rel_tran, bypass_this);
	}
}

void Write_VC_RAW_Release_Deps(AaRoot* succ, set<AaRoot*>& preds) {assert(0);}

void Write_VC_Marked_Joins(set<string> join_trans_set, string trig_trans, bool bypass_flag, ostream& ofile)
{
	for(set<string>::iterator iter = join_trans_set.begin(), fiter = join_trans_set.end(); iter != fiter; iter++)
	{
		string jname = *iter;
		__MJ(jname, trig_trans, bypass_flag);
	}
}

void Write_VC_Unmarked_Joins(set<string> join_trans_set, string trig_trans, ostream& ofile)
{
	for(set<string>::iterator iter = join_trans_set.begin(), fiter = join_trans_set.end(); iter != fiter; iter++)
	{
		string jname = *iter;
		__J(jname, trig_trans);
	}
}


string Get_Op_Ascii_Name(AaOperation op, AaType* src_type, AaType* dest_type)
{
	string ret_val;
	if(op == __NOT)
		ret_val = "NOT";
	else if(op == __NOP)
		ret_val = "NOP";
	else if(op == __OR) ret_val = "OR";
	else if(op == __AND) ret_val = "AND";
	else if(op == __XOR) ret_val = "XOR";
	else if(op == __NOR) ret_val = "NOR";
	else if(op == __NAND) ret_val = "NAND";
	else if(op == __XNOR) ret_val = "XOR";
	else if(op == __SHL) ret_val = "SHL";
	//  for SHR, if the types of src1,src2 are integer,
	//  then we use the signed version.
	else if(op == __SHR)
	{
		if(dest_type->Is("AaIntType"))
			ret_val = "ASHR";
		else
			ret_val = "LSHR";
	}
	else if(op == __ROL) ret_val = "ROL";
	else if(op == __ROR) ret_val = "ROR";
	else if(op == __PLUS) ret_val = "ADD";
	else if(op == __MINUS) ret_val = "SUB";
	else if(op == __MUL) ret_val = "MUL";
	else if(op == __DIV) ret_val = "DIV";
	else if(op == __EQUAL) ret_val = "EQ";
	else if(op == __NOTEQUAL) ret_val = "NEQ";
	//
	// for comparisons, if the types of src1,src2 are integer,
	//       then we use the signed version.
	else if(op == __LESS)
	{
		if(src_type->Is("AaIntType") || src_type->Is("AaFloatType"))
			ret_val = "SLT";
		else
			ret_val = "ULT";
	}
	else if(op == __LESSEQUAL) 
	{
		if(src_type->Is("AaIntType") || src_type->Is("AaFloatType"))
			ret_val = "SLE";
		else 
			ret_val = "ULE";
	}
	else if(op == __GREATER)
	{
		if(src_type->Is("AaIntType") || src_type->Is("AaFloatType"))
			ret_val = "SGT";
		else 
			ret_val = "UGT";
	}
	else if(op == __GREATEREQUAL)
	{
		if(src_type->Is("AaIntType") || src_type->Is("AaFloatType"))
			ret_val = "SGE";
		else 
			ret_val = "UGE";
	}
	else if(op == __CONCAT) ret_val = "CONCAT";
	else if(op == __BITSEL) ret_val = "BITSEL";
	else if(op == __BITMAP) ret_val = "BITMAP";
	else if(op == __UNORDERED) ret_val = "UNORDERED";
	else if(op == __DECODE) ret_val = "DECODE";
	else if(op == __ENCODE) ret_val = "ENCODE";
	else if(op == __PRIORITYENCODE) ret_val = "PENCODE";
	else if(op == __BITREDUCEOR) ret_val = "BITREDUCEOR";
	else if(op == __BITREDUCEAND) ret_val = "BITREDUCEAND";
	else if(op == __BITREDUCEXOR) ret_val = "BITREDUCEXOR";
	else
		assert(0);


	if(src_type->Is("AaFloatType"))
		ret_val += "_f" + IntToStr(((AaFloatType*)src_type)->Size());
	else if(src_type->Is("AaUintType"))
		ret_val += "_u" + IntToStr(((AaUintType*)src_type)->Size());
	else if(src_type->Is("AaIntType"))
		ret_val += "_i" + IntToStr(((AaIntType*)src_type)->Size());
			
	if(dest_type->Is("AaFloatType"))
		ret_val += "_f" + IntToStr(((AaFloatType*)dest_type)->Size());
	else if(dest_type->Is("AaUintType"))
		ret_val += "_u" + IntToStr(((AaUintType*)dest_type)->Size());
	else if(dest_type->Is("AaIntType"))
		ret_val += "_i" + IntToStr(((AaIntType*)dest_type)->Size());

	return(ret_val);
}
