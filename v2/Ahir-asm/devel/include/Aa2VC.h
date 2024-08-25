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
#ifndef __AA2VC__
#define __AA2VC__

#include <AaIncludes.h>

#define __T(x) ofile << "$T[" << x << "] " << endl; 
#define __TD(x) ofile << "$T[" << x << "] $delay" << endl; 
#define __Place(x) ofile << "$P[" << x << "] " << endl; 
#define __J(x,y) ofile << x << " <-& (" << y << ")" << endl;
#define __ALIAS(x,y) ofile << "$A [" <<  x << "] [" << y <<  "]" << endl;
// TODO: need to pass an integer to this..
#define __MJ(x,y,epf) ofile << x << " o<-& (" << y <<  " " << (epf ? 0 : 1) << ")" << endl;
#define __F(x,y) ofile << x << " &-> (" << y << ")" << endl;

#define __SST(u) u->Get_VC_Sample_Start_Transition_Name()
#define __SCT(u) u->Get_VC_Sample_Completed_Transition_Name()
#define __SST_I(u,i) (u->Get_VC_Sample_Start_Transition_Name() + "_" + IntToStr(i))
#define __SCT_I(u,i) (u->Get_VC_Sample_Completed_Transition_Name() + "_" + IntToStr(i))

#define __UST(u) u->Get_VC_Update_Start_Transition_Name()
#define __UCT(u) u->Get_VC_Update_Completed_Transition_Name()

#define __DeclTransSplitProtocolPattern  {\
      	__T(__SST(this)); __T(__SCT(this)); __T(__UST(this)); __T(__UCT(this));}

#define __TrivialConnectSplitProtocolPattern  {\
      __F(__SST(this), __SCT(this));\
      __F(__UST(this), __UCT(this));\
	}

#define __FlowThroughConnectSplitProtocolPattern  {\
	__J(__SCT(this), __SST(this));\
	__J(__UST(this), __SCT(this));\
	__J(__UCT(this), __UST(this));}

#define __ConnectSplitProtocolPattern  {\
      string _sample_regn = this->Get_VC_Name() + "_Sample";\
      string _update_regn = this->Get_VC_Name() + "_Update";\
      __F(__SST(this), _sample_regn);\
      __J(__SCT(this), _sample_regn);\
      __F(__SCT(this), "$null");\
      __F(__UST(this), _update_regn);\
      __J(__UCT(this), _update_regn);\
	}

#define __ConnectChainedSplitProtocolPattern  {\
      string _sample_regn = this->Get_VC_Name() + "_Sample";\
      string _update_regn = this->Get_VC_Name() + "_Update";\
      __F(__SST(this), _sample_regn);\
      __J(__SCT(this), _sample_regn);\
      __J(__UST(this), __SCT(this));\
      __F(__UST(this), _update_regn);\
      __J(__UCT(this), _update_regn);\
	}
#define __SelfReleaseSplitProtocolPattern {\
  ofile << "// self-release: " << endl;\
  __MJ(__SST(this),__SCT(this),false);\
  __F("$null", __UST(this));\
  __MJ(__UST(this),__UCT(this),true);}

#define __SelfReleaseChainedSplitProtocolPattern {\
  ofile << "// self-release-chained-split-protocol: " << endl;\
  __MJ(__SST(this),__UCT(this),true);}

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
			     bool flow_through,
			     bool full_rate,
			     bool bitcast_flag, 
			     ostream& ofile);

void Write_VC_Bitmap_Operator(string inst_name, 
			      string src_name, 
			      string target_name,
			      AaType* src_type,
			      vector<pair<int,int> >& bmapv,
			      string guard_string,
			      bool flow_through,
			     bool full_rate,
			      ostream& ofile);

void Write_VC_Register( string inst_name, 
			string src_name, 
			string target_name,
			string guard_string,
			ostream& ofile);

void Write_VC_Interlock_Buffer( string inst_name, 
			string src_name, 
			string target_name,
			string guard_string,
			bool flow_through,
			bool full_rate,
			bool cut_through,
			bool in_phi,
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
			      bool add_hash,			
			     bool flow_through,
			     bool full_rate,
			      ostream& ofile);
void Write_VC_Call_Operator(string inst_name, 
			    string module_name, 
			    vector<pair<string,AaType*> >& inargs,
			    vector<pair<string,AaType*> >& outargs,
			    string guard_string,
			    bool flow_through,
			    bool full_rate,
			    ostream& ofile);

void Write_VC_Phi_Operator(string inst_name,
			   vector<pair<string,AaType*> >& sources,
			   string target,
			   AaType* target_type,
			   bool pipeline_flag,
			   bool full_rate, 
			   ostream& ofile);
void Write_VC_Link(string inst_name, vector<string>& reqs, vector<string>& acks,
		   ostream& ofile);
void Write_VC_Branch_Instance(string inst_name, vector<pair<string,AaType*> >& br_inputs,
			      ostream& ofile);
void Write_VC_Branch_With_Bypass_Instance(string inst_name, vector<pair<string,AaType*> >& br_inputs,
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

void Write_VC_Pipe_Declaration(string name, int width,int depth, bool lifo_mode,  bool noblock_flag, 
			bool in_flag, bool out_flag, bool signal_flag, 
			 bool p2p_flag, bool shiftreg_flag, bool full_rate, bool bypass, ostream& ofile);
void Write_VC_Memory_Space_Declaration(string space_name, string obj_name, AaType* type,ostream& ofile);
void Write_VC_Load_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			     string guard_string,
			    ostream& ofile);
void Write_VC_Store_Operator(string ms_name, string inst_name, string data_name, string addr_name,
			     string guard_string,
			     ostream& ofile);
void Write_VC_IO_Input_Port(AaPipeObject* obj, string inst_name, string data_name,
			     string guard_string, bool full_rate, bool barrier_flag,
				ostream& ofile);
void Write_VC_IO_Output_Port(AaPipeObject* obj, string inst_name, string data_name,
			     string guard_string, bool full_rate,
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
			     bool flow_through,
			     bool full_rate,
			      ostream& ofile);

void Write_VC_Slice_Operator(string inst_name,
			     string in_name,
			     string out_name,
			     int high_index,
			     int low_index,
			     string guard_string,
			     bool flow_through,
			     bool full_rate,
			     ostream& ofile);

bool Is_Trivial_VC_Type_Conversion(AaType* from, AaType* to);

void Write_VC_Load_Store_Dependency(bool pipeline_flag,
				      	AaMemorySpace* ms, 
				    	AaRoot* src, 
				    	AaRoot* tgt, 
				    	ostream& ofile);
void Write_VC_Load_Store_Loop_Pipeline_Ring_Dependency(AaMemorySpace* ms,
							set<AaRoot*>& leading_accesses,
							set<AaRoot*>& trailing_accesses,
							ostream& ofile);

void Write_VC_Pipe_Dependency(bool pipeline_flag,
			      AaExpression* src,
			      AaExpression* tgt,
			      bool mark_flag,
			      ostream& ofile);

void Write_VC_Reenable_Joins(set<string>& active_reenable_points,
				map<string,bool>& active_reenable_bypass_flags, 
				 string& rel_tran, bool force_bypass_flag, ostream& ofile);

void Write_VC_RAW_Release_Deps(AaRoot* succ, set<AaRoot*>& preds);


void Write_VC_Marked_Joins(set<string> join_trans_set, string trig_trans, bool bypass_flag, ostream& ofile);
void Write_VC_Unmarked_Joins(set<string> join_trans_set, string trig_trans, ostream& ofile);

string Get_Op_Ascii_Name(AaOperation op, AaType* src_type, AaType* dest_type);

#endif
