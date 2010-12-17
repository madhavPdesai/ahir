#ifndef _VC_DATAPATH_H_
#define _VC_DATAPATH_H_
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcScalarTypeTemplate;

class vcWire: public vcRoot
{
  vcType* _type;
  vcRoot* _driver;
  set<vcRoot*,vcRoot_Compare> _receivers;

 public:
  vcWire(string id, vcType* t);
  virtual void Print(ostream& ofile);

  void Connect_Driver(vcRoot* d) {this->_driver = d;}
  void Connect_Receiver(vcRoot* r) {this->_receivers.insert(r);}

  vcType* Get_Type() {return(this->_type);}
  vcRoot* Get_Driver() {return(this->_driver);}
  const set<vcRoot*,vcRoot_Compare>&  Get_Receivers() {return this->_receivers;}

  virtual string Kind() {return("vcWire");}
};

class vcDatapathElementTemplate: public vcRoot
{
  map<string, pair<int,int> > _parameter_limit_map;
  
  set<string> _reqs;
  set<string> _acks;
  
  map<string, vcScalarTypeTemplate*> _input_port_map;
  map<string, vcScalarTypeTemplate*> _output_port_map;

 public:

  vcDatapathElementTemplate(string id);
  bool Is_Legal_Parameter_Value(string pname, int val);
  virtual void Print(ostream& ofile);


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


class vcDataPath: public vcRoot
{
  map<string, vcDatapathElement*> _dpe_map;
  map<string, vcWire*> _wire_map;
 public:
  vcDataPath(string id);
  void Add_DPE(string dpe_name, vcDatapathElementTemplate* t);
  vcDatapathElement* Find_DPE(string dpe_name);
  void Set_DPE_Parameter(string dpe_name, string param_name, int param_value);
  int Get_DPE_Parameter(string dpe_name, string param_name);

  vcWire* Find_Wire(string wname);
  void Add_Wire(string wname, vcType* t);
  void Connect_Wire(string dpe_name, string port_name, vcWire* w);
  virtual void Print(ostream& ofile);

  virtual string Kind() {return("vcDatapath");}
};
#endif // vcDataPath
