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
#ifndef _VC_OPERATOR_H_
#define _VC_OPERATOR_H_

#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcDataPath.hpp>

class vcTransition;
class vcModule;
class vcWire;
class vcDataPath;
class vcType;





// single req, single ack
class vcOperator: public vcDatapathElement
{

public:
  vcOperator(string id): vcDatapathElement(id) {}
  virtual string Kind() {return("vcOperator");}  

  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

  virtual bool Is_Local_To_Datapath()
  {
    return(true);
  }

  virtual string Get_Logger_Description() {return ("");}
  virtual void Print_VHDL_Logger(vcModule* parent_module, ostream& ofile);
  friend class vcDataPath;
};


class vcEquivalence: public vcOperator
{
public:
  vcEquivalence(string id, vector<vcWire*>& inwires, vector<vcWire*>& outwires);
  virtual string Kind() {return("vcEquivalence");}    
  virtual void Print(ostream& ofile);
  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);
  friend class vcDataPath;
};


// split reqs (2) and matching acks (2)
class vcSplitOperator: public vcDatapathElement
{
protected:

public: 

  vcSplitOperator(string id):vcDatapathElement(id) {}
  virtual string Kind() {return("vcSplitOperator");}

  virtual bool Is_Split_Operator() {return(true);}
  virtual void Check_Consistency() {assert(0);}
  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

  virtual string Get_Op_Id() {assert(0);}
  virtual vcType* Get_Input_Type() {assert(0);}
  virtual vcType* Get_Output_Type() {assert(0);}

  virtual void Print_VHDL_Logger(vcModule* parent_module, ostream& ofile);

  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile) {assert(0);}
  virtual void Print_VHDL_Instantiation_Preamble(bool flow_through_flag, ostream& ofile);
  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors);
  virtual string Get_Logger_Description() {return ("");}
  friend class vcDataPath;
};



class vcCall: public vcSplitOperator
{
  vcModule* _parent_module;
  vcModule* _called_module;
  bool _inline_flag;
public:


  vcCall(string id, vcModule* parent,  vcModule* called_module, vector<vcWire*>& in_wires, vector<vcWire*> out_wires, bool inline_flag);
  virtual void Check_Consistency() {assert(0);}

  bool Get_Inline() {return(this->_inline_flag);}
  vcModule* Get_Called_Module() {return(this->_called_module);}

  virtual int Get_Deterministic_Pipeline_Delay();
  virtual int Estimate_Buffering_Bits();

  virtual bool Is_Part_Of_Pipeline();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcCall");}
  virtual bool Is_Shareable_With(vcDatapathElement* other) ;

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs);

  virtual bool Is_Local_To_Datapath()
  {
    return(false);
  }

  virtual int Get_Delay();

  // combinational operator..
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);

  // operator instance..
  virtual void Print_Operator_VHDL(ostream& ofile);
  virtual string Get_Logger_Description();
   
  virtual bool Is_Deterministic_Pipeline_Operator();
  virtual void Print_Deterministic_Pipeline_Operator_VHDL(string stall_sig, ostream& ofile);

  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors);
  friend class vcDataPath;
};

class vcIOport: public vcSplitOperator
{
protected:
  vcPipe* _pipe;
public:
  vcIOport(string id, vcPipe* pipe);
  string Get_Pipe_Id();
  vcPipe* Get_Pipe() {return(_pipe);}
  virtual vcWire* Get_Data() {assert(0);}
  virtual string Kind() {return("vcIOport");}
  virtual bool Is_Shareable_With(vcDatapathElement* other) 
  {
    return((this->Kind() == other->Kind()) && (this->Get_Pipe() == ((vcIOport*)other)->Get_Pipe()));
  }

  virtual bool Is_Local_To_Datapath()
  {
    return(false);
  }

  friend class vcDataPath;
};


class vcOutport: public vcIOport
{

public:
  vcOutport(string id, vcPipe* pipe, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcOutport");}

  virtual vcWire* Get_Data()
  {
	if(_input_wires.size() > 0)
		return(_input_wires[0]);
	else
		return(NULL);
  }

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering)
  {
	vcWire* d  = this->Get_Data();
	if(d != NULL)
		inwire_buffering.push_back(this->Get_Input_Buffering(d));
  }

  virtual string Get_Logger_Description() {return (" PipeWrite to " + _pipe->Get_Id()); }
  friend class vcDataPath;

  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors)
  {
	if(t == _reqs[0])
		zero_delay_successors.insert(_acks[0]);
  }
};

class vcInport: public vcIOport
{
  bool _barrier_flag;
public:
  vcInport(string id, vcPipe* pipe, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcInport");}
  virtual vcWire* Get_Data()
  {
	if(_output_wires.size() > 0)
		return(_output_wires[0]);
	else
		return(NULL);
  }
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs)
  {
	vcWire* d  = this->Get_Data();
	if(d != NULL)
		outwire_buffering.push_back(this->Get_Output_Buffering(d, num_reqs));
  }
  void Set_Barrier_Flag(bool v) {_barrier_flag =v;}
  bool Get_Barrier_Flag() {return(_barrier_flag);}

 
  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors)
  {
	if(t == _reqs[0])
		zero_delay_successors.insert(_acks[0]);
  }

  virtual string Get_Logger_Description() {return (" PipeRead from " + _pipe->Get_Id()); }
  friend class vcDataPath;
};

class vcLoadStore: public vcSplitOperator
{

protected:
  vcMemorySpace* _memory_space;
public:
  vcLoadStore(string id, vcMemorySpace* ms);
  vcMemorySpace* Get_Memory_Space() {return(this->_memory_space);}
  virtual string Kind() {return("vcLoadStore");}

  virtual bool Is_Shareable_With(vcDatapathElement* other)
  {
    return((this->Kind() == other->Kind()) && (this->_memory_space == ((vcLoadStore*)other)->Get_Memory_Space()));
  }

  virtual vcWire* Get_Address() {assert(0);}
  virtual vcWire* Get_Data()  {assert(0);}
	
  virtual void Check_Memory_Space_Consistency(int addr_width, int data_width);

  virtual bool Is_Local_To_Datapath()
  {
    return(false);
  }

  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors)
  {
	if(t == _reqs[0])
		zero_delay_successors.insert(_acks[0]);
  }

  friend class vcDataPath;
};


class vcLoad: public vcLoadStore
{

  // input wire 0 addr
  // output wire 0 data
public:
  vcLoad(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcLoad");}

  virtual vcWire* Get_Address() {if(_input_wires.size() > 0) return(this->_input_wires[0]); else return (NULL);}
  virtual vcWire* Get_Data()  {if(_output_wires.size() > 0) return(this->_output_wires[0]); else return (NULL);}

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs);

  friend class vcDataPath;
};


class vcStore: public vcLoadStore
{
	// inputs address, data.
public:
  vcStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);


  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcStore");}

  virtual vcWire* Get_Address() {if(_input_wires.size() > 0) return(this->_input_wires[0]); else return (NULL);}
  virtual vcWire* Get_Data()  {if(_input_wires.size() > 1) return(this->_input_wires[1]); else return (NULL);}

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs) 
  {
    // nothing.
  }
  friend class vcDataPath;
};


// many reqs, single ack...unique operator of this type
class vcPhi: public vcDatapathElement
{
public:
  vcPhi(string id, vector<vcWire*>& inwires, vcWire* outwire);
  virtual void Print(ostream& ofile);

  virtual string Get_Bypass_String() {return("false");}

  vector<vcWire*>& Get_Inwires() {return(this->_input_wires);}
  vcWire* Get_Outwire() {if(_output_wires.size() > 0) return(this->_output_wires[0]); else return (NULL);}
  virtual string Kind() {return("vcPhi");}

  virtual void Print_VHDL(ostream& ofile);
  virtual void Print_VHDL_Logger(vcModule* parent_module, ostream& ofile);

  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors);

  friend class vcDataPath;
};


// vcPhiPipelined
class vcPhiPipelined: public vcPhi
{
public:
  vcPhiPipelined(string id, vector<vcWire*>& inwires, vcWire* outwire);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcPhiPipelined");}
  virtual string Get_Bypass_String() {return(this->Get_Full_Rate() ? "true" : "false");}
  friend class vcDataPath;

};

//
// all arithmetic binary operators.
//
class vcBinarySplitOperator: public vcSplitOperator
{
protected:
  string _op_id;

  bool _x_war_flag;
  bool _y_war_flag;

public:

  vcBinarySplitOperator(string id, string op_id, vcWire* x, vcWire* y, vcWire* z);
  virtual string Get_Op_Id() {return(this->_op_id);}


  vcWire* Get_X() {if(_input_wires.size() == 2)  return(_input_wires[0]); else return(NULL);}
  vcWire* Get_Y() {if(_input_wires.size() == 2)  return(_input_wires[1]); else return(NULL);}
  vcWire* Get_Z() {if(_output_wires.size() == 1) return(_output_wires[0]); else return(NULL);}

  vcType* Get_X_Input_Type() {return(this->Get_X()->Get_Type());}
  vcType* Get_Y_Input_Type() {return(this->Get_Y()->Get_Type());}

  virtual vcType* Get_Input_Type() {return(this->Get_X()->Get_Type());}
  virtual vcType* Get_Output_Type() {return(this->Get_Z()->Get_Type());}

  virtual void Print(ostream& ofile);

  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcBinarySplitOperator");}

  virtual bool Is_Shareable_With(vcDatapathElement* other);
  virtual bool Is_Pipelined_Operator();

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs);

  bool Is_Int_Add_Op();
  virtual string Get_Operator_Type() {return(this->Kind() + " (" + this->_op_id + ")");}

  // combinational operator..
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);
  virtual bool Is_Floating_Point_Dpe();
  friend class vcDataPath;
};


// NOT and type-casts are the only ones of this type
class vcUnarySplitOperator: public vcSplitOperator
{
protected:
  string _op_id;

public:

  vcUnarySplitOperator(string id, string op_id, vcWire* x, vcWire* z);
  string Get_Op_Id() {return(this->_op_id);}

  virtual bool Is_Float_To_Float_Operator();

  virtual bool Is_Shareable_With(vcDatapathElement* other);
  virtual void Print(ostream& ofile);
  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcUnarySplitOperator");}

  virtual string Get_Operator_Type() {return(this->Kind() + " (" + this->_op_id + ")");}

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering, int num_reqs);

  virtual vcType* Get_Input_Type() {if(_input_wires.size() > 0) return(this->_input_wires[0]->Get_Type()); else return(NULL);}

  vcWire* Get_X() {if(_input_wires.size() > 0) return(this->_input_wires[0]); else return(NULL);}
  vcWire* Get_Z() {if(_output_wires.size() > 0) return(this->_output_wires[0]); else return(NULL);}

  vcType* Get_X_Input_Type() {return(this->Get_Input_Type());}
  virtual vcType* Get_Output_Type() {if(_output_wires.size() > 0) return(this->_output_wires[0]->Get_Type()); else return(NULL);}

  // combinational operator..
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);
  virtual bool Is_Floating_Point_Dpe();
  friend class vcDataPath;
};


class vcSelect: public vcSplitOperator
{

protected:

  // input wires sel x y
  // output wire z

  bool _sel_war_flag;
  bool _x_war_flag;
  bool _y_war_flag;

public:
  vcSelect(string id, vcWire* sel, vcWire* x, vcWire* y, vcWire* z);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcSelect");}
  virtual void Print_VHDL(ostream& ofile);

  vcWire* Get_Sel() {return(this->Get_Input_Wire(0));}
  vcWire* Get_X() {return(this->Get_Input_Wire(1));}
  vcWire* Get_Y() {return(this->Get_Input_Wire(2));}
  vcWire* Get_Z() {return(this->Get_Output_Wire(0));}


  // combinational operator..
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);

  friend class vcDataPath;
};

// single req, two acks.
class vcBranch: public vcDatapathElement
{
  bool _bypass_flag;
public:
  vcBranch(string id, vector<vcWire*>& wires);
  vcBranch(string id, vector<vcWire*>& wires, bool bypass_flag);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcBranch");}
  bool Get_Bypass_Flag() {return(_bypass_flag);}

  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors);
  friend class vcDataPath;
};

class vcRegister: public vcOperator
{
public:
  vcRegister(string id, vcWire* din, vcWire* dout);
  virtual string Kind() {return("vcRegister");}
  virtual void Print(ostream& ofile);

  virtual vcWire* Get_Din() {return(this->Get_Input_Wire(0));}
  virtual vcWire* Get_Dout() {return(this->Get_Output_Wire(0));}

  virtual void Print_VHDL(ostream& ofile);
  friend class vcDataPath;
};

// new operator to support full-rate pipelining..
class vcInterlockBuffer: public vcSplitOperator
{
  bool _cut_through;
  bool _in_phi;

  public:
  vcInterlockBuffer(string id, vcWire* x, vcWire* z);

  virtual string Kind() {return("vcInterlockBuffer");}
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  virtual vcWire* Get_Din() {return(this->Get_Input_Wire(0));}
  virtual vcWire* Get_Dout() {return(this->Get_Output_Wire(0));}

  virtual void Set_Cut_Through(bool v) {_cut_through = v;}
  bool Get_Cut_Through() {return(_cut_through);}

  virtual void Set_In_Phi(bool v) {_in_phi = v;}
  bool Get_In_Phi() {return(_in_phi);}

  // combinational operator..
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);
  virtual void Append_Zero_Delay_Successors_To_Req(vcTransition* t,set<vcCPElement*>& zero_delay_successors);

};
// dout := din[_high_index downto _low_index]
class vcSlice: public vcInterlockBuffer
{

protected:
  unsigned int _high_index;
  unsigned int _low_index;

public:
  vcSlice(string id, vcWire* din, vcWire* dout, int high_index, int low_index);
  virtual string Kind() {return("vcSlice");}
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  unsigned int Get_High_Index() { return _high_index; }
  unsigned int Get_Low_Index() { return _low_index; }

  // combinational operator..
  virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);

  friend class vcDataPath;
};


//
// permutation: a useful operator in bit-level logic.
//
class vcPermutation: public vcInterlockBuffer
{
	vector<pair<int,int> > _permutation;
	public:
  	vcPermutation(string id, vcWire* din, vcWire* dout, vector<pair<int,int> >& bmapv);
  	virtual string Kind() {return("vcPermutation");}
  	virtual void Print(ostream& ofile);
  	virtual void Print_VHDL(ostream& ofile);
  
	// combinational operator..
  	virtual void Print_Flow_Through_VHDL(bool level_mode, ostream& ofile);

  	friend class vcDataPath;
};


string Get_VHDL_Op_Id(string vc_op_id, vcType* in_type, vcType* out_type, bool add_quotes);
bool Check_If_Equivalent(vector<vcWire*>& iw1, vector<vcWire*>& iw2);
bool Is_Trivial_Op(string vc_op_id);
bool Is_Compare_Op(string vc_op_id);
bool Is_Symmetric_Op(string vc_op_id);
bool Is_Unary_Op(string vc_op_id);
bool Is_Shift_Op(string vc_op_id);
bool Is_Pipelined_Float_Op(string vc_op_id, vcType* in_type, vcType* out_type, int& exponent_width, int& fraction_width);
bool Is_Float_Compare_Op(string vc_op_id);

#endif
