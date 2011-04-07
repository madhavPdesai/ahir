#ifndef __AA2VC__
#define __AA2VC__

#include <AaIncludes.h>

#define __T(x) ofile << "$T[" << x << "] " << endl; 
#define __Place(x) ofile << "$P[" << x << "] " << endl; 
#define __J(x,y) ofile << x << " <-& (" << y << ")" << endl;
#define __F(x,y) ofile << x << " &-> (" << y << ")" << endl;

void Write_VC_Equivalence_Operator(string inst_name,
				   string input,
				   string output,
				   ostream& ofile);

void Write_VC_Constant_Declaration(string name, string type, string val,  ostream& ofile);
void Write_VC_Constant_Declaration(string wire_name, 
				   AaType* t, 
				   string initial_value,
				   ostream& ofile);

void Write_VC_Wire_Declaration(string wire_name, string type_name,
			       ostream& ofile);

void Write_VC_Equivalence_Operator(string inst_name,
				   vector<string>& inwires,
				   vector<string>& outwires,
				   ostream& ofile);

void Write_VC_Unary_Operator(AaOperation op, 
			     string inst_name, 
			     string src_name, 
			     AaType* src_type,
			     string target_name,
			     AaType* target_type,
			     ostream& ofile);
void Write_VC_Binary_Operator(AaOperation op, 
			      string inst_name, 
			      string src1, 
			      AaType* src1_type,
			      string src2, 
			      AaType* src2_type, 
			      string target_name,
			      AaType* target_type,
			      ostream& ofile);
void Write_VC_Call_Operator(string inst_name, 
			    string module_name, 
			    vector<pair<string,AaType*> >& inargs,
			    vector<pair<string,AaType*> >& outargs,
			    ostream& ofile);

void Write_VC_Phi_Operator(string inst_name,
			   vector<pair<string,AaType*> >& sources,
			   string target,
			   AaType* target_type,
			   ostream& ofile);
void Write_VC_Link(string inst_name, vector<string>& reqs, vector<string>& acks,
		   ostream& ofile);
void Write_VC_Branch_Instance(string inst_name, vector<pair<string,AaType*> >& br_inputs,
			      ostream& ofile);
void Write_VC_Constant_Declaration(string name, AaType* type, AaValue* value,
				   ostream& ofile);

void Write_VC_Constant_Pointer_Declaration(string name, 
					   string wire_name, 
					   AaUintType* type, 
					   string value,
					   ostream& ofile);
void Write_VC_Pointer_Declaration(string name, string wire_name, AaType* type,ostream& ofile);
void Write_VC_Wire_Declaration(string name, AaType* type,ostream& ofile);
void Write_VC_Intermediate_Wire_Declaration(string wire_name, 
					    AaType* t,
					    ostream& ofile);

void Write_VC_Pipe_Declaration(string name, int width,ostream& ofile);
void Write_VC_Memory_Space_Declaration(string space_name, string obj_name, AaType* type,ostream& ofile);
void Write_VC_Load_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			    ostream& ofile);
void Write_VC_Store_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			     ostream& ofile);
void Write_VC_IO_Input_Port(AaPipeObject* obj, string inst_name, string data_name,ostream& ofile);
void Write_VC_IO_Output_Port(AaPipeObject* obj, string inst_name, string data_name,ostream& ofile);

void Write_VC_Select_Operator(string inst_name,
			      string test_name,
			      AaType* test_type,
			      string if_true_name,
			      AaType* if_true_type,
			      string if_false_name,
			      AaType* if_false_type,
			      string target_name,
			      AaType* target_type,
			      ostream& ofile);


bool Is_Trivial_VC_Type_Conversion(AaType* from, AaType* to);

void Write_VC_Load_Store_Dependency(AaExpression* src,
				    AaExpression* tgt,
				    ostream& ofile);

void Write_VC_Pipe_Dependency(AaExpression* src,
			      AaExpression* tgt,
			      ostream& ofile);
#endif
