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

class vcPhi;
class vcModule: public vcRoot
{
  map<string, vcMemorySpace*> _memory_space_map;

  // transition-id -> (dpe-id,req-ack-id) 
  map<vcTransition*,pair<vcDatapathElement*,string> > _link_map;

  // this map is actually redundant
  map<vcPhi*, pair< vector<vcTransition*>, vcTransition*> > _phi_link_map;

  vector<string> _ordered_input_arguments;
  vector<string> _ordered_output_arguments;

  map<string, vcWire*> _input_arguments;
  map<string, vcWire*> _output_arguments;

  vcControlPath* _control_path;
  vcDataPath*    _data_path;

  bool _inline;
 public:
  vcModule(string module_name);
  virtual void Print(ostream& ofile);

  void Add_Link(vector<string>& transition_ref, string dpe_name, string dpe_req_ack_name);
  void Add_Phi_Link(vcPhi* phi, vector<vcTransition*>& inreqs, vcTransition* outack);

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

  void Print_Control_Structure(ostream& ofile);

  virtual void Print_VHDL(ostream& ofile);
};

#endif // vcModule
