#ifndef _VC_OPERATOR_H_
#define _VC_OPERATOR_H_

#include <vcIncludes.hpp>
#include <vcRoot.hpp>


class vcTransition;
class vcModule;
class vcWire;
class vcDataPath;

class vcOperator: public vcRoot
{

protected:
  // unitary operator..
  // cannot be pipelined!
  vcTransition* _req;
  vcTransition* _ack;
public:

  vcOperator(string id): vcRoot(id) {_req = NULL; _ack = NULL;}

  void Set_Req(vcTransition* req) {this->_req = req;}
  void Set_Ack(vcTransition* ack) {this->_ack = ack;}

  virtual string Kind() {return("vcOperator");}  

  friend class vcDataPath;
};

class vcSplitOperator: public vcRoot
{

protected:

  // note: split Request-Complete handshake
  vcTransition* _reqR;
  vcTransition* _ackR;

  vcTransition* _reqC;
  vcTransition* _ackC;

public: 
  vcSplitOperator(string id):vcRoot(id) {_reqR = NULL; _reqC = NULL; _ackR = NULL; _ackC = NULL;}

  void Set_ReqR(vcTransition* t) {_reqR = t;}
  void Set_ReqC(vcTransition* t) {_reqC = t;}
  void Set_AckR(vcTransition* t) {_ackR = t;}
  void Set_AckC(vcTransition* t) {_ackC = t;}

  virtual string Kind() {return("vcSplitOperator");}

  virtual void Check_Consistency() {assert(0);}

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
  friend class vcDataPath;
};

// only a single req/ack pair.. derive from vcOperator
class vcIOport: public vcOperator
{
protected:
  vcWire* _data;
  string _pipe_id;
public:
  vcIOport(string id, string pipe_id, vcWire* w): vcOperator(id)
  {
    _pipe_id = pipe_id;
    _data = w;
  }

  virtual string Kind() {return("vcIOport");}
  friend class vcDataPath;
};


class vcOutport: public vcIOport
{

public:
  vcOutport(string id, string pipe_id, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcOutport");}
  friend class vcDataPath;
};

class vcInport: public vcIOport
{
public:
  vcInport(string id, string pipe_id, vcWire* w);
  
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcInport");}
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
  virtual string Kind() {return("vcLoadStore");}
  friend class vcDataPath;
};


class vcLoad: public vcLoadStore
{
public:
  vcLoad(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcLoad");}
  friend class vcDataPath;
};


class vcStore: public vcLoadStore
{
public:
  vcStore(string id, vcMemorySpace* ms, vcWire* addr, vcWire* data);


  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcStore");}
  friend class vcDataPath;
};

// many reqs, single ack...unique operator of this type
class vcPhi: public vcRoot
{
protected:
  vector<vcWire*> _inwires;
  vcWire* _outwire;
  vector<vcTransition*> _inreqs;
  vcTransition* _ack;
public:
  vcPhi(string id, vector<vcWire*>& inwires, vcWire* outwire);
  virtual void Print(ostream& ofile);

  void Set_Inreqs(vector<vcTransition*>& reqs);
  void Set_Ack(vcTransition* t);


  vector<vcWire*>& Get_Inwires() {return(this->_inwires);}
  vcWire* Get_Outwire() {return(this->_outwire);}

  vector<vcTransition*>& Get_Inreqs() {return(this->_inreqs);}
  vcTransition* Get_Ack() {return(this->_ack);}
  virtual string Kind() {return("vcPhi");}

  friend class vcDataPath;
};


//
// all arithmetic and logical binary operators.
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


  virtual void Print(ostream& ofile);

  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcBinarySplitOperator");}

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

  virtual void Print(ostream& ofile);
  virtual void Check_Consistency() {assert(0);}
  virtual string Kind() {return("vcUnarySplitOperator");}

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
class vcBranch: public vcRoot
{
protected:
  vcWire* _test;

  vcTransition* _req;
  vcTransition* _ack0;
  vcTransition* _ack1;
public:
  vcBranch(string id, vcWire* twire);

  void Set_Req(vcTransition* t) {_req =t;}
  void Set_Ack0(vcTransition* t) {_ack0 = t;}
  void Set_Ack1(vcTransition* t) {_ack1 = t;}
  
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcBranch");}
  friend class vcDataPath;
};

#endif
