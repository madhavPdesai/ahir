#ifndef VC_MODULE_H
#define VC_MODULE_H
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcMemorySpace;
class vcDatapathElement;
class vcTransition;
class vcControlPath;
class vcWire;
class vcDataPath;
class vcDatapathElement;
class vcWire;
class vcPhi;
class vcSystem;
class vcModule: public vcRoot
{
  
  vcSystem* _parent;

  map<string, vcMemorySpace*> _memory_space_map;

  // transition-id -> (dpe-id,req-ack-id) 
  set<vcDatapathElement*> _linked_dpe_set;
  set<vcTransition*> _linked_transition_set;

  vector<string> _ordered_input_arguments;
  vector<string> _ordered_output_arguments;

  map<string, vcWire*> _input_arguments;
  map<string, vcWire*> _output_arguments;

  vcControlPath* _control_path;
  vcDataPath*    _data_path;

  // calls to each module
  // for each module, record the indices of the
  // groups which call this module
  map<vcModule*,vector<int> > _call_group_map;

  int _num_calls;

  bool _inline;
 public:
  vcModule(vcSystem* sys, string module_name);
  vcSystem* Get_Parent() {return(this->_parent);}

  virtual void Print(ostream& ofile);

  void Register_Call_Group(vcModule* m, int g_id) {_call_group_map[m].push_back(g_id); _num_calls++;}
  int Get_Num_Calls() {return(this->_num_calls);}

  int Get_In_Arg_Width();
  int Get_Out_Arg_Width();
  void Add_Link(vcDatapathElement* dpe, vector<vcTransition*>& reqs, vector<vcTransition*>& acks);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcType* Get_Argument_Type(string arg_name, string mode /* "in" or "out" */);
  void Add_Argument(string arg_name, string mode, vcType* t);
  vcWire* Get_Argument(string arg_name, string mode);
  string Get_Input_Argument(int idx)
  {
    assert(idx >= 0 && idx < this->_ordered_input_arguments.size());
    return(this->_ordered_input_arguments[idx]);
  }

  string Get_Output_Argument(int idx)
  {
    assert(idx >= 0 && idx < this->_ordered_output_arguments.size());
    return(this->_ordered_output_arguments[idx]);
  }

  void Set_Inline(bool v) { this->_inline = v;}
  bool Get_Inline() { return this->_inline;}
  virtual string Kind() {return("vcModule");}

  void Set_Control_Path(vcControlPath* cp) { this->_control_path = cp;}
  vcControlPath* Get_Control_Path() { return(this->_control_path);}

  void Set_Data_Path(vcDataPath* dp);
  vcDataPath* Get_Data_Path() { return(this->_data_path);}

  void Check_Control_Structure();
  void Compute_Compatibility_Labels();
  void Compute_Maximal_Groups();

  void Print_Control_Structure(ostream& ofile);
  void Print_Compatible_Operator_Groups(ostream& ofile);

  virtual void Print_VHDL(ostream& ofile);

  void Print_VHDL_Ports(ostream& ofile);
  string Print_VHDL_Argument_Ports(string semi_colon, ostream& ofile);
  void Print_VHDL_Component(ostream& ofile);
  void Print_VHDL_Entity(ostream& ofile);
  void Print_VHDL_Architecture(ostream& ofile);

};

#endif // vcModule
