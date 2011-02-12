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

  bool _flow_through; // if true, operator is combinational..

public:

  vcOperator(string id): vcDatapathElement(id) { _flow_through = false; }

  void Set_Flow_Through(bool v) {this->_flow_through = v;}
  bool Get_Flow_Through() {return(this->_flow_through);}

  virtual void Add_Reqs(vector<vcTransition*>& reqs);
  virtual void Add_Acks(vector<vcTransition*>& acks);
  virtual string Kind() {return("vcOperator");}  

  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

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


  virtual string Get_Op_Id() {assert(0);}
  virtual vcType* Get_Input_Type() {assert(0);}
  virtual vcType* Get_Output_Type() {assert(0);}

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

  friend class vcDataPath;
};

// only a single req/ack pair.. derive from vcOperator
class vcIOport: public vcOperator
{
protected:
  vcWire* _data;
  string _pipe_id;
public:
  vcIOport(string id, string pipe_id, vcWire* w);
  string Get_Pipe_Id() {return(this->_pipe_id);}
  vcWire* Get_Data() {return(this->_data);}
  virtual string Kind() {return("vcIOport");}
  virtual bool Is_Shareable_With(vcDatapathElement* other) 
  {
    return((this->Kind() == other->Kind()) && (this->_pipe_id == ((vcIOport*)other)->Get_Pipe_Id()));
  }

  friend class vcDataPath;
};


class vcOutport: public vcIOport
{

public:
  vcOutport(string id, string pipe_id, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcOutport");}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_data);
  }

  friend class vcDataPath;
};

class vcInport: public vcIOport
{
public:
  vcInport(string id, string pipe_id, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcInport");}
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_data);
  }

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

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_address);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_data);
  }

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
  string Get_Op_Id() {return(this->_op_id);}

  virtual vcType* Get_Input_Type() {return(this->_x->Get_Type());}

  vcType* Get_X_Input_Type() {return(this->_x->Get_Type());}
  vcType* Get_Y_Input_Type() {return(this->_y->Get_Type());}
  virtual vcType* Get_Output_Type() {return(this->_z->Get_Type());}

  virtual void Print(ostream& ofile);

  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcBinarySplitOperator");}

  virtual bool Is_Shareable_With(vcDatapathElement* other);


  virtual int Get_Number_Of_Input_Wires() { return(2); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_x);
    inwires.push_back(_y);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_z);
  }

  vcWire* Get_X() {return(_x);}
  vcWire* Get_Y() {return(_y);}
  vcWire* Get_Z() {return(_z);}


  virtual string Get_Operator_Type() {return(this->Kind() + " (" + this->_op_id + ")");}

  friend class vcDataPath;
};

// binary operator can also be non-split, that is
// with a single req/ack pair.
class vcBinaryOperator: public vcOperator
{
protected:
  string _op_id;

  // two inputs
  vcWire* _x;
  vcWire* _y;
  
  // single output
  vcWire* _z;

public:

  vcBinaryOperator(string id, string op_id, vcWire* x, vcWire* y, vcWire* z);
  string Get_Op_Id() {return(this->_op_id);}

  virtual vcType* Get_Input_Type() {return(this->_x->Get_Type());}

  vcType* Get_X_Input_Type() {return(this->_x->Get_Type());}
  vcType* Get_Y_Input_Type() {return(this->_y->Get_Type());}
  virtual vcType* Get_Output_Type() {return(this->_z->Get_Type());}

  virtual void Print(ostream& ofile);

  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcBinaryOperator");}

  virtual bool Is_Shareable_With(vcDatapathElement* other) 
  { 
    return(false); 
  }

  virtual int Get_Number_Of_Input_Wires() { return(2); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_x);
    inwires.push_back(_y);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_z);
  }

  vcWire* Get_X() {return(_x);}
  vcWire* Get_Y() {return(_y);}
  vcWire* Get_Z() {return(_z);}

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

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_x);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_z);
  }

  virtual vcType* Get_Input_Type() {return(this->_x->Get_Type());}

  vcType* Get_X_Input_Type() {return(this->_x->Get_Type());}
  virtual vcType* Get_Output_Type() {return(this->_z->Get_Type());}

  friend class vcDataPath;
};


// NOT is the only one of this type
class vcUnaryOperator: public vcOperator
{
protected:
  string _op_id;

  // single input
  vcWire* _x;
  
  // single output
  vcWire* _z;

public:

  vcUnaryOperator(string id, string op_id, vcWire* x, vcWire* z);
  string Get_Op_Id() {return(this->_op_id);}

  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}

  virtual void Print(ostream& ofile);
  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcUnaryOperator");}

  virtual string Get_Operator_Type() {return(this->Kind() + " (" + this->_op_id + ")");}

  virtual int Get_Number_Of_Input_Wires() { return(1); }
  virtual int Get_Number_Of_Output_Wires() { return(1);}

  virtual void Append_Inwires(vector<vcWire*>& inwires) 
  {
    inwires.push_back(_x);
  }
  virtual void Append_Outwires(vector<vcWire*>& outwires) 
  {
    outwires.push_back(_z);
  }

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
  vcSelect(string id, vcWire* x, vcWire* y, vcWire* sel, vcWire* z);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcSelect");}
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
  friend class vcDataPath;
};

string Get_VHDL_Op_Id(string vc_op_id, vcType* in_type, vcType* out_type);
bool Check_If_Equivalent(vector<vcWire*>& iw1, vector<vcWire*>& iw2);
bool Is_Trivial_Op(string vc_op_id);
#endif
