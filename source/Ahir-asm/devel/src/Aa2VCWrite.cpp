#include <AaProgram.h>
#include <Aa2VC.h>

void Write_VC_Constant_Declaration(string wire_name, string type_name, string initial_value, 
				   ostream& ofile)
{
  ofile << "$constant $W[" << wire_name << "] : " << type_name << " := " << initial_value << endl; 
}

void Write_VC_Wire_Declaration(string wire_name, string type_name, ostream& ofile)
{
  ofile << "$W[" << wire_name << "] : " << type_name << endl;
}
void Write_VC_Unary_Operator(AaOperation op, 
			     string inst_name, 
			     string src_name, 
			     AaType* src_type,
			     string target_name,
			     AaType* target_type,
			     ostream& ofile)
{
  string op_name;
  if(op == __NOT)
    {
      op_name = "~";
    }
  else
    {
      op_name = ":=";
    }

  ofile << op_name << " [" << inst_name << "] "
	<< "(" << src_name << ") "
	<< "(" << target_name << ")" << endl;
}
void Write_VC_Binary_Operator(AaOperation op, 
			      string inst_name, 
			      string src1, 
			      AaType* src1_type,
			      string src2, 
			      AaType* src2_type, 
			      string target_name,
			      AaType* target_type,
			      ostream& ofile)
{
  string op_name;
  if(op == __OR) op_name = "|";
  else if(op == __AND) op_name = "&";
  else if(op == __XOR) op_name = "^";
  else if(op == __NOR) op_name = "~|";
  else if(op == __NAND) op_name = "~&";
  else if(op == __XNOR) op_name = "~^";
  else if(op == __SHL) op_name = "<<";
  else if(op == __SHR) op_name = ">>";
  else if(op == __PLUS) op_name = "+";
  else if(op == __MINUS) op_name = "-";
  else if(op == __MUL) op_name = "*";
  else if(op == __DIV) op_name = "/";
  else if(op == __EQUAL) op_name = "==";
  else if(op == __NOTEQUAL) op_name = "!=";
  else if(op == __LESS) op_name = "<";
  else if(op == __LESSEQUAL) op_name = "<=";
  else if(op == __GREATER) op_name = ">";
  else if(op == __GREATEREQUAL) op_name = ">=";
  else if(op == __CONCAT) op_name = "_";
  else if(op == __BITSEL) op_name = "[]";
  else
    assert(0);

  ofile << op_name << "[" << inst_name << "]" << " "
	<< "(" << src1 << " " << src2 << ") "
	<< "(" << target_name << ")" << endl;
}

void Write_VC_Call_Operator(string inst_name, 
			    string module_name, 
			    vector<pair<string,AaType*> >& inargs,
			    vector<pair<string,AaType*> >& outargs,
			    ostream& ofile)
{
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
  ofile << ")" << endl;
}

void Write_VC_Phi_Operator(string inst_name,
			   vector<pair<string,AaType*> >& sources,
			   string target,
			   AaType* target_type,
			   ostream& ofile)
{
  ofile << "$phi [" << inst_name << "] " ;
  ofile << "(";
  for(int idx = 0; idx < sources.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << sources[idx].first;
    }
  ofile << ")";
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
  ofile << "$branch [" << inst_name << "] (";
  for(int idx = 0; idx < br_inputs.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << br_inputs[idx].first;
    }
  ofile << ")" << endl;
}
void Write_VC_Constant_Declaration(string name, AaType* type, AaValue* value, ostream& ofile)
{
  Write_VC_Constant_Declaration(name,
				type->Get_VC_Name(),
				value->To_VC_String(),
				ofile);
}
void Write_VC_Constant_Pointer_Declaration(string name, 
					   string wire_name, 
					   AaUintType* type, 
					   string value,
					   ostream& ofile)
{
  string type_name = "$pointer<" + name + ">";
  Write_VC_Constant_Declaration(wire_name,
				type_name,
				value,
				ofile);
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
void Write_VC_Pipe_Declaration(string name, int width, ostream& ofile)
{
  ofile << "$pipe [" << name << "] " << width << endl;
}

void Write_VC_Memory_Space_Declaration(string space_name, string obj_name, AaType* type, ostream& ofile)
{
  ofile << "$memoryspace [" << space_name << "] {"
	<< "$capacity " << type->Number_Of_Elements() << endl
	<< "$datawidth " << type->Get_Data_Width() << endl
	<< "$addrwidth " << CeilLog2(type->Number_Of_Elements()) << endl
	<< "$object [" << obj_name << "] : " << type->Get_VC_Name() << endl
	<< "}" << endl;
}

void Write_VC_Load_Operator(AaStorageObject* obj, string inst_name, string data_name, string addr_name,
			    ostream& ofile)
{
  ofile << "$load [" << inst_name << "] $from " << obj->Get_VC_Memory_Space_Name() 
	<< " (" << addr_name  << ") (" << data_name << ")" << endl;
}
void Write_VC_Store_Operator(AaStorageObject* obj, string inst_name, string data_name, string addr_name,
			     ostream& ofile)
{
  ofile << "$store [" << inst_name << "] $to " << obj->Get_VC_Memory_Space_Name() 
	<< " (" << addr_name  << " " << data_name << ")" << endl;
}
void Write_VC_IO_Input_Port(AaPipeObject* obj, string inst_name, string data_name,
			    ostream& ofile)
{
  ofile << "$ioport $in [" << inst_name  << "] (" << obj->Get_VC_Name() << ") ("
	<< data_name << ")" << endl;
}
void Write_VC_IO_Output_Port(AaPipeObject* obj, string inst_name, string data_name,
			     ostream& ofile)
{
  ofile << "$ioport $out [" << inst_name  << "] "
	<< "(" << obj->Get_VC_Name() << ") "
	<< " (" 
	<< data_name << ")" << endl;
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
			      ostream& ofile)
{
  ofile << "? [" << inst_name << "] " 
	<< "(" << test_name << " " << if_true_name << " " << if_false_name << ") "
	<< "(" << target_name << ")" << endl;
}

