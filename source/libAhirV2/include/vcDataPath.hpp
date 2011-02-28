#ifndef _VC_DATAPATH_H_
#define _VC_DATAPATH_H_
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcValue;
class vcScalarTypeTemplate;
class vcPhi;
class vcCall;
class vcLoad;
class vcStore;
class vcSelect;
class vcBranch;
class vcInport;
class vcOutport;
class vcOperator;
class vcSplitOperator;
class vcRegister;
class vcDatapathElement;
class vcWire: public vcRoot
{
protected:
  vcType* _type;
  vcDatapathElement* _driver;
  set<vcDatapathElement*> _receivers;

public:

  vcWire(string id, vcType* t);
  virtual void Print(ostream& ofile);

  virtual void Connect_Driver(vcDatapathElement* d) {this->_driver = d;}
  virtual void Connect_Receiver(vcDatapathElement* r) {this->_receivers.insert(r);}

  vcType* Get_Type() {return(this->_type);}
  vcDatapathElement* Get_Driver() {return(this->_driver);}
  const set<vcDatapathElement*>&  Get_Receivers() {return this->_receivers;}

  virtual string Kind() {return("vcWire");}
  virtual void Print_VHDL_Std_Logic_Declaration(ostream& ofile);
  int Get_Size();
};

class vcIntermediateWire: public vcWire
{
public:
  vcIntermediateWire(string id, vcType* t) : vcWire(id,t) {}
  virtual void Print(ostream& ofile)
  {
    ofile << vcLexerKeywords[__INTERMEDIATE] << " ";
    this->vcWire::Print(ofile);
  }

  virtual string Kind() {return("vcIntermediateWire");}
};

class vcConstantWire: public vcWire
{
  vcValue* _value;
public:
  vcConstantWire(string id, vcValue* v);
  virtual void Print(ostream& ofile);
  vcValue* Get_Value() {return(this->_value);}
  virtual void Connect_Driver(vcDatapathElement* d) {assert(0);}

  void Print_VHDL_Constant_Declaration(ostream& ofile);
  virtual string Kind() {return("vcConstantWire");}
};

class vcInputWire: public vcWire
{
public:
  vcInputWire(string id, vcType* t);
  virtual void Connect_Driver(vcRoot* d) {assert(0);}

  virtual string Kind() {return("vcInputWire");}
};


class vcOutputWire: public vcWire
{
public:
  vcOutputWire(string id, vcType* t);
  virtual void Connect_Receiver(vcRoot* r) {assert(0);}

  virtual string Kind() {return("vcOutputWire");}
};


class vcTransition;
class vcCompatibilityLabel;
class vcControlPath;
class vcDataPath;
class vcDatapathElement: public vcRoot
{
protected:
  vector<vcTransition*> _reqs;
  vector<vcTransition*> _acks;

 public:
  vcDatapathElement(string id):vcRoot(id) {}

  virtual void Add_Reqs(vector<vcTransition*>& reqs) {assert(0);}
  virtual void Add_Acks(vector<vcTransition*>& acks) {assert(0);}

  int Get_Number_Of_Reqs() {return(this->_reqs.size());}
  int Get_Number_Of_Acks() {return(this->_acks.size());}

  vcTransition* Get_Req(int idx) {if(idx >= 0 && idx<_reqs.size()) return(this->_reqs[idx]); else return(NULL);}
  vcTransition* Get_Ack(int idx) {if(idx >= 0 && idx<_acks.size()) return(this->_acks[idx]); else return(NULL);}

  int Get_Req_Index(vcTransition* t)
  {
    int ret_index = -1;
    for(int idx = 0; idx < _reqs.size(); idx++)
      {
	if(_reqs[idx] == t)
	  {
	    ret_index = idx;
	    break;
	  }
      }
    return(ret_index);
  }

  int Get_Ack_Index(vcTransition* t)
  {
    int ret_index = -1;
    for(int idx = 0; idx < _acks.size(); idx++)
      {
	if(_acks[idx] == t)
	  {
	    ret_index = idx;
	    break;
	  }
      }
    return(ret_index);
  }

  virtual bool Is_Shareable_With(vcDatapathElement* other) {return(false);}
  virtual string Kind() {return("vcDatapathElement");}
  virtual string Get_Operator_Type() {return(this->Kind());}

  virtual void Append_Inwires(vector<vcWire*>& inwires) {assert(0);}
  virtual void Append_Outwires(vector<vcWire*>& owires) {assert(0);}

  friend class vcDataPath;

};


class vcModule;
class vcControlPath;
class vcMemorySpace;
class vcDataPath: public vcRoot
{
  vcModule* _parent;

  // lots of maps.
  map<string, vcDatapathElement*> _dpe_map; // all dpes are recorded here

  // separated maps for convenience
  map<string, vcPhi*> _phi_map;
  map<string, vcWire*> _wire_map;
  map<string, vcSelect*> _select_map;
  map<string, vcBranch*> _branch_map;
  map<string, vcRegister*> _register_map;

  // these operators can be shared..
  map<string, vcSplitOperator*> _split_operator_map;
  vector<set<vcDatapathElement*> > _compatible_split_operator_groups;

  map<string, vcLoad*> _load_map;
  vector<set<vcDatapathElement*> > _compatible_load_groups;

  map<string, vcStore*> _store_map;
  vector<set<vcDatapathElement*> > _compatible_store_groups;

  map<string, vcCall*> _call_map;
  vector<set<vcDatapathElement*> > _compatible_call_groups;

  map<string, vcOutport*> _outport_map;
  vector<set<vcDatapathElement*> > _compatible_outport_groups;

  map<string, vcInport*> _inport_map;
  vector<set<vcDatapathElement*> > _compatible_inport_groups;

  map<vcDatapathElement*, pair<vcCompatibilityLabel*, vcCompatibilityLabel*> > _dpe_label_interval_map;

  // pipe-name to vector of groups which use pipe name.
  map<string, vector<int> > _inport_group_map;
  map<string, vector<int> > _outport_group_map;

 public:
  vcDataPath(vcModule* m, string id);

  void Add_Load(vcLoad* ld);
  vcLoad* Find_Load(string id);

  void Add_Store(vcStore* st);
  vcStore* Find_Store(string id);

  void Add_Call(vcCall* c);
  vcCall* Find_Call(string id);

  void Add_Inport(vcInport* p);
  vcInport* Find_Inport(string id);

  void Add_Outport(vcOutport* p);
  vcOutport* Find_Outport(string id);

  void Add_Split_Operator(vcSplitOperator* p);
  vcSplitOperator* Find_Split_Operator(string id);

  void Add_Select(vcSelect* p);
  vcSelect* Find_Select(string id);

  void Add_Branch(vcBranch* p);
  vcBranch* Find_Branch(string id);

  void Add_Register(vcRegister* p);
  vcRegister* Find_Register(string id);

  vcDatapathElement* Find_DPE(string dpe_name);

  void Add_Phi(vcPhi* p);
  vcPhi* Find_Phi(string pname);

  vcWire* Find_Wire(string wname);
  void Add_Wire(string wname, vcType* t);
  void Add_Intermediate_Wire(string wname, vcType* t);

  void Add_Constant_Wire(string wname, vcValue* v);

  void Connect_Wire(string dpe_name, string port_name, vcWire* w);
  
  void Set_Parent(vcModule* m) {this->_parent = m;}
  vcModule* Get_Parent() {return(this->_parent);}

  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcDatapath");}

  pair<vcCompatibilityLabel*,vcCompatibilityLabel*> Get_Label_Interval(vcControlPath* cp, vcDatapathElement* dpe);

  void Compute_Maximal_Groups(vcControlPath* cp);
  void Update_Maximal_Groups(vcControlPath* cp,
			     vcDatapathElement* dpe, 
			     vector<set<vcDatapathElement*> >& dpe_group);
  void Print_Compatible_Operator_Groups(ostream& ofile);
  void Print_Compatible_Operator_Groups(ostream& ofile, vector<set<vcDatapathElement*> >& dpe_groups);

  string Print_VHDL_Memory_Interface_Ports(string semi_colon, ostream& ofile);
  string Print_VHDL_IO_Interface_Ports(string semi_colon, ostream& ofile);
  string Print_VHDL_Call_Interface_Ports(string semi_colon, ostream& ofile);

  string Print_VHDL_Memory_Interface_Port_Map(string comma, ostream& ofile);
  string Print_VHDL_IO_Interface_Port_Map(string comma, ostream& ofile);
  string Print_VHDL_Call_Interface_Port_Map(string comma, ostream& ofile);

  void Print_VHDL(ostream& ofile);

  void Print_VHDL_Phi_Instances(ostream& ofile);
  void Print_VHDL_Select_Instances(ostream& ofile);
  void Print_VHDL_Register_Instances(ostream& ofile);
  void Print_VHDL_Branch_Instances(ostream& ofile);
  void Print_VHDL_Split_Operator_Instances(ostream& ofile);
  void Print_VHDL_Load_Instances(ostream& ofile);
  void Print_VHDL_Store_Instances(ostream& ofile);
  void Print_VHDL_Inport_Instances(ostream& ofile);
  void Print_VHDL_Outport_Instances(ostream& ofile);
  void Print_VHDL_Call_Instances(ostream& ofile);

  void Print_VHDL_Concatenation(string target, vector<vcWire*> wires, ostream& ofile);
  void Print_VHDL_Disconcatenation(string source, int total_width, vector<vcWire*> wires, ostream& ofile);

  void Print_VHDL_Concatenate_Req(string req_id, vector<vcTransition*>& reqs,  ostream& ofile);
  void Print_VHDL_Disconcatenate_Ack(string ack_id, vector<vcTransition*>& acks,  ostream& ofile);

  string Get_VHDL_IOport_Interface_Port_Name(string pipe_id, string pid);
  string Get_VHDL_IOport_Interface_Port_Section(string pipe_id,
						string in_or_out,
						string pid,
						int idx);
};
#endif // vcDataPath
