#ifndef VC_MODULE_H
#define VC_MODULE_H
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcType;
class vcValue;
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
class vcPipe;
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

  set<vcModule*> _called_modules;
  set<vcMemorySpace*> _accessed_memory_spaces;

  // for each module, record the indices of the
  // groups which call this module
  map<vcModule*,vector<int> > _call_group_map;
  int _num_calls;
  int _max_number_of_caller_tags_needed;
  int _pipeline_depth;
  int _pipeline_buffering;
  int _delay;

  map<string,vcPipe*> _pipe_map;

  string _function_library_vhdl_lib;

  bool _inline;
  bool _foreign_flag; 
  bool _pipeline_flag; 
  bool _operator_flag; 
  bool _volatile_flag; 
  bool _pipeline_full_rate_flag;
  bool _is_function_library_module;

  

 public:
  vcModule(vcSystem* sys, string module_name);
  vcSystem* Get_Parent() {return(this->_parent);}

  virtual void Print(ostream& ofile);

  void Set_Foreign_Flag(bool v) {_foreign_flag = v; }
  bool Get_Foreign_Flag() {return(_foreign_flag);}
  void Set_Pipeline_Flag(bool v) {_pipeline_flag = v; }
  bool Get_Pipeline_Flag() {return(_pipeline_flag);}

  void Set_Pipeline_Depth(int d) {_pipeline_depth = d;}
  int  Get_Pipeline_Depth() {return(_pipeline_depth);}

  void Set_Pipeline_Buffering(int d) {_pipeline_buffering = d;}
  int  Get_Pipeline_Buffering() {return(_pipeline_buffering);}

  void Set_Pipeline_Full_Rate_Flag(bool d) {_pipeline_full_rate_flag = d;}
  int  Get_Pipeline_Full_Rate_Flag() {return(_pipeline_full_rate_flag);}

  void Set_Operator_Flag(bool v) {_operator_flag = v;}
  bool Get_Operator_Flag() {return(_operator_flag);}

  void Set_Volatile_Flag(bool v) {_volatile_flag = v;}
  bool Get_Volatile_Flag() {return(_volatile_flag);}

  void Set_Delay(int d) {_delay = d;}
  int  Get_Delay() {return(_delay);}

  void Set_Is_Function_Library_Module(bool d) {_is_function_library_module = d;}
  int  Get_Is_Function_Library_Module() {return(_is_function_library_module);}

  void Set_Function_Library_Vhdl_Lib(string d) {_function_library_vhdl_lib = d;}
  string  Get_Function_Library_Vhdl_Lib() {return(_function_library_vhdl_lib);}

  void Register_Call_Group(vcModule* m, int g_id, int g_size) 
  {
    _call_group_map[m].push_back(g_id); 
    _num_calls++;
    _max_number_of_caller_tags_needed = MAX(_max_number_of_caller_tags_needed, g_size);
  }

  void Deregister_Call_Groups(vcModule* m)
  {
    if(_call_group_map.find(m) != _call_group_map.end())
      {
	_num_calls =_num_calls - _call_group_map[m].size();
	_call_group_map.erase(m);
      }
  }

  void Add_Called_Module(vcModule* m)
  {
    _called_modules.insert(m);
  }

  void Add_Accessed_Memory_Space(vcMemorySpace* ms)
  {
    _accessed_memory_spaces.insert(ms);
  }

  int Get_Num_Calls() {return(this->_num_calls);}
  int Get_Caller_Tag_Length() {return(CeilLog2(this->_max_number_of_caller_tags_needed));}

  int Get_Callee_Tag_Length() 
  {
    if(this->_num_calls > 0)
      return(CeilLog2(this->_num_calls));
    else
      return(CeilLog2(this->Get_Pipeline_Depth()));
  }

  int Get_In_Arg_Width();
  int Get_Out_Arg_Width();

  int Get_Number_Of_Input_Arguments()
  {
    return(_ordered_input_arguments.size());
  }
  int Get_Number_Of_Output_Arguments()
  {
    return(_ordered_output_arguments.size());
  }

  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcType* Get_Argument_Type(string arg_name, string mode /* "in" or "out" */);

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


  bool Get_Inline() { return this->_inline;}
  virtual string Kind() {return("vcModule");}

  vcControlPath* Get_Control_Path() { return(this->_control_path);}
  vcDataPath* Get_Data_Path() { return(this->_data_path);}

  // Pipes.
  void Register_Pipe_Read(string pipe_id, int idx);
  void Register_Pipe_Write(string pipe_id, int idx);
  bool Has_Pipe(string pipe_id) 
  {
    return(_pipe_map.find(pipe_id) != _pipe_map.end());
  }
  vcPipe* Find_Pipe_Here(string pipe_id)
  {
    if(_pipe_map.find(pipe_id) !=  _pipe_map.end())
      {
	return(_pipe_map[pipe_id]);
      }
    else
      return(NULL);
  }
  vcPipe* Find_Pipe(string pipe_id);
  void Add_Pipe(string pipe_id, int width, int depth, bool lifo_mode, bool noblock_mode,  
			bool in_flag, bool out_flag, bool signal_flag, bool p2p_flag, bool shiftreg_flag, bool full_rate);
  void Print_Pipes(ostream& ofile);
  void Print_VHDL_Pipe_Signals(ostream& ofile);
  void Print_VHDL_Pipe_Instances(ostream& ofile);

  // builder methods
  void Add_Link(vcDatapathElement* dpe, vector<vcTransition*>& reqs, vector<vcTransition*>& acks);
  void Add_Memory_Space(vcMemorySpace* ms);
  void Add_Argument(string arg_name, string mode, vcType* t, vcValue* v);
  void Set_Control_Path(vcControlPath* cp) { this->_control_path = cp;}
  void Set_Data_Path(vcDataPath* dp);
  void Set_Inline(bool v) { this->_inline = v;}

  void Check_Control_Structure();
  void Compute_Compatibility_Labels();
  void Compute_Maximal_Groups();

  // print analysis results.
  void Print_Control_Structure(ostream& ofile);
  void Print_Compatible_Operator_Groups(ostream& ofile);

  // VHDL related stuff..
  virtual void Print_VHDL(ostream& ofile);

  void Print_VHDL_Ports(ostream& ofile);
  string Print_VHDL_Argument_Ports(string semi_colon, ostream& ofile);
  string Print_VHDL_Control_Ports(string semi_colon, ostream& ofile);

  void Print_VHDL_Component(ostream& ofile);
  void Print_VHDL_Entity(ostream& ofile);
  void Print_VHDL_Architecture(ostream& ofile);

  void Print_VHDL_Operator_Component(ostream& ofile);
  void Print_VHDL_Operator_Entity(ostream& ofile);
  void Print_VHDL_Operator_Architecture(ostream& ofile);

  void Print_VHDL_Volatile_Component(ostream& ofile);
  void Print_VHDL_Volatile_Entity(ostream& ofile);

  string Get_VHDL_Architecture_Name()
  {
	if(this->Get_Volatile_Flag())
		return(this->Get_VHDL_Id() + "_Volatile_arch");	
	else if(this->Get_Operator_Flag())
		return(this->Get_VHDL_Id() + "_Operator_arch");	
	else 
		return(this->Get_VHDL_Id() + "_arch");	
  }
  string Get_VHDL_Entity_Name()
  {
	if(this->Get_Volatile_Flag())
		return(this->Get_VHDL_Id() + "_Volatile");	
	else if(this->Get_Operator_Flag())
		return(this->Get_VHDL_Id() + "_Operator");	
	else 
		return(this->Get_VHDL_Id());	
  }
  string Get_VHDL_Call_Interface_Port_Name(string pid);
  string Get_VHDL_Call_Interface_Port_Section(vcModule* m,
		  string call_or_return,
		  string pid,
		  int idx);

  string Print_VHDL_Tag_Interface_Ports(string semi_colon,ostream& ofile);
  void Print_VHDL_Argument_Signals(ostream& ofile);
  void Print_VHDL_Caller_Aggregate_Signals(ostream& ofile);

  void Print_VHDL_In_Arg_Disconcatenation(ostream& ofile);
  void Print_VHDL_Out_Arg_Concatenation(ostream& ofile);
  void Print_VHDL_Call_Arbiter_Instantiation(ostream& ofile);

  void Print_VHDL_Instance(ostream& ofile);
  void Print_VHDL_Auto_Run_Instance(ostream& ofile);
  void Print_VHDL_Instance_Port_Map(ostream& ofile);

  string Print_VHDL_Argument_Port_Map(string  comma, ostream& ofile);
  string Print_VHDL_Tag_Interface_Port_Map(string comma, ostream& ofile);
  string Print_VHDL_System_Argument_Ports(string semi_colon,ostream& ofile);
  void Print_VHDL_System_Argument_Signals(ostream& ofile);
  string Print_VHDL_System_Instance_Port_Map(string comma,ostream& ofile);

  bool Get_Caller_Module_Section(vcModule* caller_module, int& hindex, int& lindex);
  string Get_Aggregate_Section(string pid, int hindex, int lindex);


  void Mark_Reachable_Modules(set<vcModule*>& reachable_modules);
  void Delink_From_Modules_And_Memory_Spaces();

  void Print_Reduced_CP_As_Dot_File();
  void Print_VHDL_Tag_Logic(ostream& ofile);
};

#endif // vcModule
