#ifndef __AA2VC__
#define __AA2VC__

#include <AaIncludes.h>

#define __T(x) ofile << "$T[" << x << "] " << endl; 
#define __Place(x) ofile << "$P[" << x << "] " << endl; 
#define __J(x,y) ofile << x << " <-& (" << y << ")" << endl;
// TODO: need to pass an integer to this..
#define __MJ(x,y) ofile << x << " o<-& (" << y <<  " " << 1 << ")" << endl;
#define __F(x,y) ofile << x << " &-> (" << y << ")" << endl;

#define __ST(u)  u->Get_VC_Start_Transition_Name()
#define __AT(u)  u->Get_VC_Active_Transition_Name()
#define __CT(u)  u->Get_VC_Completed_Transition_Name()
#define __SST(u) u->Get_VC_Sample_Start_Transition_Name()
#define __SCT(u) u->Get_VC_Sample_Completed_Transition_Name()
#define __UST(u) u->Get_VC_Update_Start_Transition_Name()
#define __UCT(u) u->Get_VC_Update_Completed_Transition_Name()

#define __DeclTrans  {\
	string st = __ST(this);\
	string at = __AT(this);\
	string ct = __CT(this);\
        __T(st); __T(at); __T(ct); }

#define __DeclTransSplitProtocolPattern  {\
	__T(__ST(this)); __T(__AT(this)); __T(__CT(this));\
      	__T(__SST(this)); __T(__SCT(this)); __T(__UST(this)); __T(__UCT(this));\
      	__J(__SST(this),__ST(this));\
      	__J(__UST(this),__ST(this));\
      	__J(__CT(this),__UCT(this));\
      	__J(__CT(this),__SCT(this)); }

#define _ConnectSplitProtocolPattern  {\
      string _sample_regn = this->Get_VC_Name() + "_Sample";\
      string _update_regn = this->Get_VC_Name() + "_Update";\
      __F(__SST(this), _sample_regn);\
      __J(__SCT(this), _sample_regn);\
      __F(__UST(this), _update_regn);\
      __J(__UCT(this), _update_regn);\
	}

#define __SelfReleaseSplitProtocolPattern {\
  __MJ(__SST(this),__SCT(this));\
  __MJ(__UST(this),__UCT(this));}

void Write_VC_Equivalence_Operator(string inst_name,
				   string input,
				   string output,
				   string guard_string,
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
				   string guard_string,
				   ostream& ofile);

void Write_VC_Unary_Operator(AaOperation op, 
			     string inst_name, 
			     string src_name, 
			     AaType* src_type,
			     string target_name,
			     AaType* target_type,
			     string guard_string,
			     ostream& ofile);
void Write_VC_Register( string inst_name, 
			string src_name, 
			string target_name,
			string guard_string,
			ostream& ofile);
void Write_VC_Binary_Operator(AaOperation op, 
			      string inst_name, 
			      string src1, 
			      AaType* src1_type,
			      string src2, 
			      AaType* src2_type, 
			      string target_name,
			      AaType* target_type,
			     string guard_string,
			      ostream& ofile);
void Write_VC_Call_Operator(string inst_name, 
			    string module_name, 
			    vector<pair<string,AaType*> >& inargs,
			    vector<pair<string,AaType*> >& outargs,
			     string guard_string,
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

void Write_VC_Pipe_Declaration(string name, int width,int depth, bool lifo_mode, ostream& ofile);
void Write_VC_Memory_Space_Declaration(string space_name, string obj_name, AaType* type,ostream& ofile);
void Write_VC_Load_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			     string guard_string,
			    ostream& ofile);
void Write_VC_Store_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			     string guard_string,
			     ostream& ofile);
void Write_VC_IO_Input_Port(AaPipeObject* obj, string inst_name, string data_name,
			     string guard_string,
				ostream& ofile);
void Write_VC_IO_Output_Port(AaPipeObject* obj, string inst_name, string data_name,
			     string guard_string,
				ostream& ofile);

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
			      ostream& ofile);

void Write_VC_Slice_Operator(string inst_name,
			     string in_name,
			     string out_name,
			     int high_index,
			     int low_index,
			     string guard_string,
			     ostream& ofile);

bool Is_Trivial_VC_Type_Conversion(AaType* from, AaType* to);

void Write_VC_Load_Store_Dependency(bool pipeline_flag,
				    AaExpression* src,
				    AaExpression* tgt,
				    ostream& ofile);
void Write_VC_Load_Store_Loop_Pipeline_Ring_Dependency(string& mem_space_name,
							set<AaExpression*>& leading_accesses,
							set<AaExpression*>& trailing_accesses,
							ostream& ofile);

void Write_VC_Pipe_Dependency(bool pipeline_flag,
			      AaExpression* src,
			      AaExpression* tgt,
			      ostream& ofile);

void Write_VC_Reenable_Joins(set<string>& active_reenable_points, string& rel_tran, ostream& ofile);

void Write_VC_RAW_Release_Deps(AaRoot* succ, set<AaRoot*>& preds);

#endif
