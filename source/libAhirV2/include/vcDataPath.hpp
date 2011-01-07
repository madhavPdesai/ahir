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

class vcWire: public vcRoot
{
protected:
  vcType* _type;
  vcRoot* _driver;
  set<vcRoot*,vcRoot_Compare> _receivers;

public:

  vcWire(string id, vcType* t);
  virtual void Print(ostream& ofile);

  virtual void Connect_Driver(vcRoot* d) {this->_driver = d;}
  virtual void Connect_Receiver(vcRoot* r) {this->_receivers.insert(r);}

  vcType* Get_Type() {return(this->_type);}
  vcRoot* Get_Driver() {return(this->_driver);}
  const set<vcRoot*,vcRoot_Compare>&  Get_Receivers() {return this->_receivers;}

  virtual string Kind() {return("vcWire");}
};

class vcConstantWire: public vcWire
{
  vcValue* _value;
public:
  vcConstantWire(string id, vcValue* v);
  virtual void Print(ostream& ofile);

  virtual void Connect_Driver(vcRoot* d) {assert(0);}
  virtual void Connect_Receiver(vcRoot* r) {this->_receivers.insert(r);}

  virtual string Kind() {return("vcConstantWire");}
};

class vcInputWire: public vcWire
{
public:
  vcInputWire(string id, vcType* t);
  virtual void Connect_Driver(vcRoot* d) {assert(0);}
  virtual void Connect_Receiver(vcRoot* r) {this->_receivers.insert(r);}

  virtual string Kind() {return("vcInputWire");}
};


class vcOutputWire: public vcWire
{
public:
  vcOutputWire(string id, vcType* t);
  virtual void Connect_Driver(vcRoot* d) {this->_driver = d;}
  virtual void Connect_Receiver(vcRoot* r) {assert(0);}

  virtual string Kind() {return("vcOutputWire");}
};


class vcDatapathElementLibrary; // forward decl.
class vcDatapathElementTemplate: public vcRoot
{
protected:
  vcDatapathElementLibrary* _library;
  map<string, pair<int,int> > _parameter_limit_map;
  
  set<string> _reqs;
  set<string> _acks;
  
  map<string, vcScalarTypeTemplate*> _input_port_map;
  map<string, vcScalarTypeTemplate*> _output_port_map;

public:

  vcDatapathElementTemplate(vcDatapathElementLibrary* lib, string id);
  bool Is_Legal_Parameter_Value(string pname, int val);
  virtual void Print(ostream& ofile);
  vcDatapathElementLibrary* Get_Library() {return(this->_library);}

  void Add_Parameter(string param_val, int min_val, int max_val) {this->_parameter_limit_map[param_val] = pair<int,int>(min_val,max_val);}
  void Add_Req(string req_name) {this->_reqs.insert(req_name);}
  void Add_Ack(string ack_name) {this->_acks.insert(ack_name);}
  
  void Add_Input_Port(string pname, vcScalarTypeTemplate* t) {this->_input_port_map[pname] = t;}
  void Add_Output_Port(string pname, vcScalarTypeTemplate* t) {this->_output_port_map[pname] = t;}

  bool Is_Req(string req_name) {return(this->_reqs.find(req_name) != this->_reqs.end());}
  bool Is_Ack(string ack_name) {return(this->_acks.find(ack_name) != this->_acks.end());}
  
  bool Is_Input_Port(string pname) {return(this->_input_port_map.find(pname) != this->_input_port_map.end());}
  bool Is_Output_Port(string pname){return(this->_output_port_map.find(pname) != this->_output_port_map.end());}

  bool Is_Parameter(string pname) {return(this->_parameter_limit_map.find(pname) != this->_parameter_limit_map.end());}

  virtual string Kind() {return("vcDatapathElementTemplate");}
};

class vcDatapathElementLibrary: public vcRoot
{
  map<string,vcDatapathElementTemplate*> _templates;
 public:
  vcDatapathElementLibrary(string id);
  void Add_Template(vcDatapathElementTemplate* t);
  vcDatapathElementTemplate* Get_Template(string template_name);
  virtual void Print(ostream& ofile);
};

class vcTransition;
class vcDatapathElement: public vcRoot
{
  vcDatapathElementTemplate* _template;

  map<string, int> _parameter_value_map;

  map<string, vcWire*> _port_map;
  map<vcWire*, string, vcRoot_Compare> _reverse_port_map;

  map<string, vcTransition*> _control_link_map;

 public:

  vcDatapathElement(string id, vcDatapathElementTemplate* t);
  virtual void Print(ostream& ofile);

  bool Is_Parameter(string id);

  void Set_Parameter(string id, int val);
  int  Get_Parameter(string id);

  vcWire* Get_Connected_Wire(string port_name);
  string Get_Connected_Port(vcWire* w);

  void Connect_Wire(string port_name, vcWire* w) {_port_map[port_name] = w; _reverse_port_map[w] = port_name;}
  void Add_Link(vcTransition* t, string req_ack_id) {_control_link_map[req_ack_id] = t;}
  vcDatapathElementTemplate* Get_Template() {return(this->_template);}
  virtual string Kind() {return("vcDatapathElement");}
};


class vcModule;
class vcMemorySpace;

#define _ADD(_map_id,_id,_ptr) _map_id[_id]=_ptr
#define __FIND(_map_id,_id) (_map_id.find(_id) != _map_id.end() ? _map_id[_id] : NULL) 

class vcDataPath: public vcRoot
{

  vcModule* _parent;

  // lots of maps.
  map<string, vcDatapathElement*> _dpe_map;
  map<string, vcPhi*> _phi_map;
  map<string, vcWire*> _wire_map;
  map<string, vcSelect*> _select_map;
  map<string, vcBranch*> _branch_map;
  map<string, vcOperator*> _operator_map;
  map<string, vcSplitOperator*> _split_operator_map;
  map<string, vcLoad*> _load_map;
  map<string, vcStore*> _store_map;
  map<string, vcCall*> _call_map;
  map<string, vcOutport*> _outport_map;
  map<string, vcInport*> _inport_map;

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

  void Add_Operator(vcOperator* p);
  vcOperator* Find_Operator(string id);

  void Add_Split_Operator(vcSplitOperator* p);
  vcSplitOperator* Find_Split_Operator(string id);

  void Add_Select(vcSelect* p);
  vcSelect* Find_Select(string id);

  void Add_Branch(vcBranch* p);
  vcBranch* Find_Branch(string id);

  void Add_DPE(vcDatapathElement* t);
  vcDatapathElement* Find_DPE(string dpe_name);

  void Set_DPE_Parameter(string dpe_name, string param_name, int param_value);
  int Get_DPE_Parameter(string dpe_name, string param_name);

  void Add_Phi(vcPhi* p);
  vcPhi* Find_Phi(string pname);

  vcWire* Find_Wire(string wname);
  void Add_Wire(string wname, vcType* t);

  void Add_Constant_Wire(string wname, vcValue* v);

  void Connect_Wire(string dpe_name, string port_name, vcWire* w);
  
  void Set_Parent(vcModule* m) {this->_parent = m;}
  vcModule* Get_Parent() {return(this->_parent);}

  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcDatapath");}
};
#endif // vcDataPath
