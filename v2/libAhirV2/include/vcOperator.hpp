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

protected:
  bool _flow_through; // if true, operator is combinational..
public:

  vcOperator(string id): vcDatapathElement(id) { _flow_through = false; }

  void Set_Flow_Through(bool v) {this->_flow_through = v;}
  bool Get_Flow_Through() {return(this->_flow_through);}

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);
  virtual string Kind() {return("vcOperator");}  

  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

  virtual bool Is_Local_To_Datapath()
  {
    return(true);
  }

  virtual int Get_Number_Of_Input_Wires() {assert(0);}
  virtual int Get_Number_Of_Output_Wires() {assert(0);}

  virtual vcWire* Get_Input_Wire(int idx){assert(0);}
  virtual vcWire* Get_Output_Wire(int idx){assert(0);}

  virtual string Get_Logger_Description() {return ("");}
  virtual void Print_VHDL_Logger(ostream& ofile);
  friend class vcDataPath;
};


class vcEquivalence: public vcOperator
{
  int _in_width;
  int _out_width;
  vector<vcWire*> _inwires;
  vector<vcWire*> _outwires;
public:
  vcEquivalence(string id, vector<vcWire*>& inwires, vector<vcWire*>& outwires);
  virtual string Kind() {return("vcEquivalence");}    
  virtual void Print(ostream& ofile);
  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

  virtual int Get_Number_Of_Input_Wires() {return(_inwires.size());}
  virtual int Get_Number_Of_Output_Wires() {return(_outwires.size());}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ return(_inwires[idx]);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ return(_outwires[idx]);}

  friend class vcDataPath;
};


// split reqs (2) and matching acks (2)
class vcSplitOperator: public vcDatapathElement
{
protected:

public: 

  vcSplitOperator(string id):vcDatapathElement(id) {}

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);
  virtual string Kind() {return("vcSplitOperator");}

  virtual void Check_Consistency() {assert(0);}
  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

  virtual int Get_Number_Of_Input_Wires() {assert(0);}
  virtual int Get_Number_Of_Output_Wires() {assert(0);}

  virtual vcWire* Get_Input_Wire(int idx) {assert(0);}
  virtual vcWire* Get_Output_Wire(int idx) {assert(0);}


  virtual string Get_Op_Id() {assert(0);}
  virtual vcType* Get_Input_Type() {assert(0);}
  virtual vcType* Get_Output_Type() {assert(0);}

  virtual void Print_VHDL_Logger(ostream& ofile);

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering) { assert(0);}
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering) { assert(0);};

  friend class vcDataPath;
};



class vcCall: public vcSplitOperator
{
  vcModule* _called_module;
  vector<vcWire*> _in_wires;
  vector<vcWire*> _out_wires;

  bool _inline_flag;
public:

  vcCall(string id, vcModule* m, vector<vcWire*>& in_wires, vector<vcWire*> out_wires, bool inline_flag);
  virtual void Check_Consistency() {assert(0);}

  bool Get_Inline() {return(this->_inline_flag);}
  vcModule* Get_Called_Module() {return(this->_called_module);}

  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcCall");}
  virtual bool Is_Shareable_With(vcDatapathElement* other) 
  {
    return((this->Kind() == other->Kind()) && (this->_called_module == ((vcCall*)other)->Get_Called_Module()));
  }

  virtual int Get_Number_Of_Input_Wires() { return(this->_in_wires.size()); }
  virtual int Get_Number_Of_Output_Wires() { return(this->_out_wires.size()); }
  virtual vcWire* Get_Input_Wire(int idx) 
	{ return(_in_wires[idx]);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ return(_out_wires[idx]);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    for(int idx = 0; idx < _in_wires.size(); idx++)
      inwires.push_back(_in_wires[idx]);
  }
 
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    for(int idx = 0; idx < _out_wires.size(); idx++)
      outwires.push_back(_out_wires[idx]);
  }

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering);

  virtual bool Is_Local_To_Datapath()
  {
    return(false);
  }

  friend class vcDataPath;
};

// only a single req/ack pair.. derive from vcOperator
class vcIOport: public vcOperator
{
protected:
  vcWire* _data;
  vcPipe* _pipe;
public:
  vcIOport(string id, vcPipe* pipe, vcWire* w);
  string Get_Pipe_Id();
  vcPipe* Get_Pipe() {return(_pipe);}
  vcWire* Get_Data() {return(this->_data);}
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

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_data);
  }
  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering)
  {
	inwire_buffering.push_back(this->Get_Input_Buffering(_data));
  }
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering)
  {
	// nothing..
  }

  virtual int Get_Number_Of_Input_Wires() { return(1); }
  virtual int Get_Number_Of_Output_Wires() { return(0);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_data); else return(NULL);}

  virtual vcWire* Get_Output_Wire(int idx) 
	{ return(NULL);}

  virtual string Get_Logger_Description() {return (" PipeWrite to " + _pipe->Get_Id()); }
  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);
  friend class vcDataPath;

};

class vcInport: public vcIOport
{
public:
  vcInport(string id, vcPipe* pipe, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcInport");}
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_data);
  }
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering);

  virtual int Get_Number_Of_Input_Wires() { return(0); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_data); else return(NULL);}
  virtual vcWire* Get_Input_Wire(int idx) 
	{ return(NULL);}

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);

  virtual string Get_Logger_Description() {return (" PipeRead from " + _pipe->Get_Id()); }
  friend class vcDataPath;
};

class vcLoadStore: public vcSplitOperator
{

protected:
  vcMemorySpace* _memory_space;

  vcWire* _address;
  vcWire* _data;


public:
  vcLoadStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);
  vcMemorySpace* Get_Memory_Space() {return(this->_memory_space);}
  virtual string Kind() {return("vcLoadStore");}

  virtual bool Is_Shareable_With(vcDatapathElement* other)
  {
    return((this->Kind() == other->Kind()) && (this->_memory_space == ((vcLoadStore*)other)->Get_Memory_Space()));
  }

  vcWire* Get_Address() {return(this->_address);}
  vcWire* Get_Data() {return(this->_data);}

  virtual bool Is_Local_To_Datapath()
  {
    return(false);
  }

  friend class vcDataPath;
};


class vcLoad: public vcLoadStore
{
public:
  vcLoad(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcLoad");}

  virtual int Get_Number_Of_Input_Wires() { return(1); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_data); else return(NULL);}
  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_address); else return(NULL);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_address);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_data);
  }
  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering);

  friend class vcDataPath;
};


class vcStore: public vcLoadStore
{
public:
  vcStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);


  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcStore");}

  virtual int Get_Number_Of_Input_Wires() { return(2); }
  virtual int Get_Number_Of_Output_Wires() { return(0);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_address);
    inwires.push_back(_data);
  }

  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    // nothing.
  }

  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);

  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering) 
  {
    // nothing.
  }
  virtual vcWire* Get_Output_Wire(int idx) 
	{ return(NULL);}
  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_address); else if(idx == 1) return(_data); else  return(NULL);}

  friend class vcDataPath;
};

// many reqs, single ack...unique operator of this type
class vcPhi: public vcDatapathElement
{
protected:
  vector<vcWire*> _inwires;
  vcWire* _outwire;
public:
  vcPhi(string id, vector<vcWire*>& inwires, vcWire* outwire);
  virtual void Print(ostream& ofile);

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);

  vector<vcWire*>& Get_Inwires() {return(this->_inwires);}
  vcWire* Get_Outwire() {return(this->_outwire);}
  virtual string Kind() {return("vcPhi");}

  virtual int Get_Number_Of_Input_Wires() { return(_inwires.size()); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx < _inwires.size()) return(_inwires[idx]); else return(NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_outwire); else return(NULL);}

  virtual void Print_VHDL(ostream& ofile);
  friend class vcDataPath;
};


//
// all arithmetic binary operators.
//
class vcBinarySplitOperator: public vcSplitOperator
{
protected:
  string _op_id;

  // two inputs
  vcWire* _x;
  vcWire* _y;
  
  // single output
  vcWire* _z;

public:

  vcBinarySplitOperator(string id, string op_id, vcWire* x, vcWire* y, vcWire* z);
  virtual string Get_Op_Id() {return(this->_op_id);}

  virtual vcType* Get_Input_Type() {return(this->_x->Get_Type());}

  vcType* Get_X_Input_Type() {return(this->_x->Get_Type());}
  vcType* Get_Y_Input_Type() {return(this->_y->Get_Type());}
  virtual vcType* Get_Output_Type() {return(this->_z->Get_Type());}

  virtual void Print(ostream& ofile);

  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcBinarySplitOperator");}

  virtual bool Is_Shareable_With(vcDatapathElement* other);
  virtual bool Is_Pipelined_Operator();


  virtual int Get_Number_Of_Input_Wires() { return(2); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_x); else if(idx == 1) return(_y); else return (NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_z); else return(NULL);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_x);
    inwires.push_back(_y);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_z);
  }
  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering);

  vcWire* Get_X() {return(_x);}
  vcWire* Get_Y() {return(_y);}
  vcWire* Get_Z() {return(_z);}


  bool Is_Int_Add_Op();
  virtual string Get_Operator_Type() {return(this->Kind() + " (" + this->_op_id + ")");}

  friend class vcDataPath;
};


// NOT is the only one of this type
class vcUnarySplitOperator: public vcSplitOperator
{
protected:
  string _op_id;

  // single input
  vcWire* _x;
  
  // single output
  vcWire* _z;

public:

  vcUnarySplitOperator(string id, string op_id, vcWire* x, vcWire* z);
  string Get_Op_Id() {return(this->_op_id);}

  virtual bool Is_Shareable_With(vcDatapathElement* other);
  virtual void Print(ostream& ofile);
  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcUnarySplitOperator");}

  virtual string Get_Operator_Type() {return(this->Kind() + " (" + this->_op_id + ")");}

  virtual int Get_Number_Of_Input_Wires() { return(1); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_x); else return(NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_z); else return(NULL);}


  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_x);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_z);
  }
  virtual void Append_Inwire_Buffering(vector<int>& inwire_buffering);
  virtual void Append_Outwire_Buffering(vector<int>& outwire_buffering);

  virtual vcType* Get_Input_Type() {return(this->_x->Get_Type());}

  vcType* Get_X_Input_Type() {return(this->_x->Get_Type());}
  virtual vcType* Get_Output_Type() {return(this->_z->Get_Type());}

  friend class vcDataPath;
};


class vcSelect: public vcOperator
{

protected:

  vcWire* _sel;

  vcWire* _x;
  vcWire* _y;

  vcWire* _z;

public:
  vcSelect(string id, vcWire* sel, vcWire* x, vcWire* y, vcWire* z);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcSelect");}
  virtual int Get_Number_Of_Input_Wires() { return(3); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_sel); else if(idx == 1) return(_x); else if (idx ==2)
			return(_y); else return(NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_z); else return(NULL);}

  virtual void Print_VHDL(ostream& ofile);
  friend class vcDataPath;
};

// single req, two acks.
class vcBranch: public vcDatapathElement
{
protected:
  vector<vcWire*> _inwires;
public:
  vcBranch(string id, vector<vcWire*>& wires);

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcBranch");}

  virtual int Get_Number_Of_Input_Wires() { return(_inwires.size()); }
  virtual int Get_Number_Of_Output_Wires() { return(0);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx <  _inwires.size()) return(_inwires[idx]); else return(NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ return(NULL);}

  friend class vcDataPath;
};

class vcRegister: public vcOperator
{
protected:
  vcWire* _din;
  vcWire* _dout;
public:
  vcRegister(string id, vcWire* din, vcWire* dout);
  virtual string Kind() {return("vcRegister");}
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  virtual int Get_Number_Of_Input_Wires() { return(1); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_din); else return(NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_dout); else return(NULL);}
  friend class vcDataPath;
};

// dout := din[_high_index downto _low_index]
class vcSlice: public vcOperator
{

protected:
  vcWire* _din;
  vcWire* _dout;
  unsigned int _high_index;
  unsigned int _low_index;

public:
  vcSlice(string id, vcWire* din, vcWire* dout, int high_index, int low_index);
  virtual string Kind() {return("vcSlice");}
  virtual void Print(ostream& ofile);

  virtual int Get_Number_Of_Input_Wires() { return(1); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual vcWire* Get_Input_Wire(int idx) 
	{ if(idx == 0) return(_din); else return(NULL);}
  virtual vcWire* Get_Output_Wire(int idx) 
	{ if(idx == 0) return(_dout); else return(NULL);}

  virtual void Print_VHDL(ostream& ofile);
  friend class vcDataPath;
};

// new operators to support full-rate pipelining..
class vcInterlockBuffer: public vcRegister
{
  public:
  vcInterlockBuffer(string id, vcWire* x, vcWire* z):
  	vcRegister(id, x, z) {}

  virtual string Kind() {return("vcInterlockBuffer");}
  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);


};

class vcSliceWithBuffering: public vcSlice
{
public:
  vcSliceWithBuffering(string id, vcWire* din, vcWire* dout, int high_index, int low_index):
     vcSlice(id, din, dout, high_index, low_index) {}
  virtual string Kind() {return("vcSliceWithInputBuffering");}
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);

  friend class vcDataPath;
};

class vcBinaryLogicalOperator: public vcBinarySplitOperator
{
 public:
  vcBinaryLogicalOperator(string id, string op_id, vcWire* x, vcWire* y, vcWire* z):
     vcBinarySplitOperator(id, op_id, x, y, z) {}

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);

  virtual string Kind() {return("vcBinaryLogicalOperator");}
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);
  friend class vcDataPath;
};

class vcSelectWithInputBuffering: public vcSelect
{
  public:
  vcSelectWithInputBuffering(string id, vcWire* sel, vcWire* x, vcWire* y, vcWire* z):
  	vcSelect(id, sel, x, y, z) {}
  virtual string Kind() {return("vcSelectWithInputBuffering");}
  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);
  friend class vcDataPath;
};

class vcPhiWithBuffering: public vcPhi
{

  public:
  vcPhiWithBuffering(string id, vector<vcWire*>& inwires, vcWire* outwire):
   vcPhi(id, inwires, outwire) {}

  virtual string Kind() {return("vcPhiWithBuffering");}
  virtual void Print(ostream& ofile);
  friend class vcDataPath;
};

class vcBinaryOperatorWithInputBuffering: public vcBinarySplitOperator
{
public:
  vcBinaryOperatorWithInputBuffering(string id, string op_id, vcWire* x, vcWire* y, vcWire* z):
  	vcBinarySplitOperator(id, op_id, x, y, z) {}

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);

  virtual string Kind() {return("vcBinaryOperatorWithInputBuffering");}
  virtual void Print(ostream& ofile);
};

string Get_VHDL_Op_Id(string vc_op_id, vcType* in_type, vcType* out_type);
bool Check_If_Equivalent(vector<vcWire*>& iw1, vector<vcWire*>& iw2);
bool Is_Trivial_Op(string vc_op_id);
bool Is_Compare_Op(string vc_op_id);
bool Is_Symmetric_Op(string vc_op_id);
bool Is_Unary_Op(string vc_op_id);
bool Is_Shift_Op(string vc_op_id);
bool Is_Pipelined_Float_Op(string vc_op_id, vcType* in_type, vcType* out_type, int& exponent_width, int& fraction_width);

#endif
