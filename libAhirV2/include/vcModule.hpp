#ifndef VC_MODULE_H
#define VC_MODULE_H
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcMemorySpace;
class vcDatapathElement;
class vcCPTransition;
class vcControlPath;
class vcDataPath;


class vcModule: public vcRoot
{
  map<string, vcMemorySpace*> _memory_space_map;

  // transition-id -> (dpe-id,req-ack-id) 
  map<string,pair<string,string> > _link_map;

  map<string, vcType*> _input_arguments;
  map<string, vcType*> _output_arguments;

  vcControlPath* _control_path;
  vcDataPath*    _data_path;

  bool _inline;

 public:
  vcModule(string module_name);
  virtual void Print(ostream& ofile);
  void Add_Link(string dpe_name, string dpe_req_ack_name, string transition_name);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcType* Get_Argument_Type(string arg_name, string mode /* "in" or "out" */);
  void Add_Argument(string arg_name, string mode, vcType* t);

  void Set_Inline(bool v) { this->_inline = v;}
  bool Get_Inline() { return this->_inline;}
  virtual string Kind() {return("vcModule");}

  void Set_Control_Path(vcControlPath* cp) { this->_control_path = cp;}
  vcControlPath* Get_Control_Path() { return(this->_control_path);}

  void Set_Data_Path(vcDataPath* cp) { this->_data_path = cp;}
  vcDataPath* Get_Data_Path() { return(this->_data_path);}
};

#endif // vcModule
