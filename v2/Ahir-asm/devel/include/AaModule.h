#ifndef _Aa_Module__
#define _Aa_Module__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>


// *******************************************  MODULE ************************************
// compilation unit: a module is basically a block
// statement, but with arguments
class AaMemorySpace;
class AaModule: public AaSeriesBlockStatement
{
  vector<AaInterfaceObject*>  _input_args;
  vector<AaInterfaceObject*>  _output_args;

  int  _pipeline_depth;
  int  _pipeline_buffering;
  bool _pipeline_full_rate_flag;


  bool _pipelined_bodies_have_been_equalized;
  // memory spaces and pipes accessed by
  // this module.
  vector<AaMemorySpace*> _memory_spaces;

  set<AaPipeObject*> _write_pipes;
  set<AaPipeObject*> _read_pipes;
  set<AaMemorySpace*> _shared_memory_spaces;

  int _number_of_times_called;

  map<string,string> _attribute_map;

  string _print_prefix;

  map<AaInterfaceObject*, AaExpression*> _print_remap;

  // modules called by this module..
  set<AaModule*> _called_modules;
  // modules from which this is called.
  set<AaModule*> _calling_modules;

  // global storage objects read/written from this module.
  // these will only be set if global storage objects are directly (ie, not through pointers)
  // accessed by this module. This particular side effect was not being captured
  // by the existing _shared_memory_spaces code.
  set<AaStorageObject*> _global_objects_that_are_read;
  set<AaStorageObject*> _global_objects_that_are_written;

  bool _foreign_flag;
  bool _inline_flag;
  bool _macro_flag;
  bool _pipeline_flag;
  bool _operator_flag;
  bool _volatile_flag;
  bool _writes_to_shared_pipe;
  bool _reads_from_shared_pipe;

 public:
  AaModule(string fname); // Modules have NULL parent (parent is the program)
  ~AaModule();


  virtual bool Is_Module() {return(true);}

  virtual void Set_Has_Been_Equalized(bool v) {_pipelined_bodies_have_been_equalized = v;}
  virtual bool Get_Has_Been_Equalized() {return(_pipelined_bodies_have_been_equalized);}

  virtual void Set_Pipeline_Depth(int v) {_pipeline_depth = v;}
  virtual int Get_Pipeline_Depth() {return(_pipeline_depth);}

  virtual void Set_Pipeline_Buffering(int v) {_pipeline_buffering = v;}
  virtual int Get_Pipeline_Buffering() {return(_pipeline_buffering);}

  virtual void Set_Pipeline_Full_Rate_Flag(bool v) {_pipeline_full_rate_flag = v;}
  virtual bool Get_Pipeline_Full_Rate_Flag() {return(_pipeline_full_rate_flag);}

  virtual void Set_Operator_Flag(bool v) {_operator_flag = v;}
  virtual bool Get_Operator_Flag() {return(_operator_flag);}

  virtual void Set_Volatile_Flag(bool v) {_volatile_flag = v;}
  virtual bool Get_Volatile_Flag() {return(_volatile_flag);}

  virtual bool Is_Part_Of_Fullrate_Pipeline()
  {
	return(_pipeline_flag && _pipeline_full_rate_flag);
  }

  virtual bool Get_Is_Volatile() {return(this->Get_Volatile_Flag());}

  void Update_Memory_Space_Info();

  void Add_Written_Global_Object(AaStorageObject* sobj) {_global_objects_that_are_written.insert(sobj);}
  void Add_Read_Global_Object(AaStorageObject* sobj) {_global_objects_that_are_read.insert(sobj);}

  void Set_Print_Prefix(string str) { _print_prefix = str;}
  string Get_Print_Prefix() {return(_print_prefix);}
  void Clear_Print_Prefix() {_print_prefix = "";}

  void Add_Called_Module(AaModule* m)
  {
	_called_modules.insert(m);
  }

  void Add_Calling_Module(AaModule* m)
  {
	_calling_modules.insert(m);
  }

  void Mark_Reachable_Modules(set<AaModule*>& mset);
  virtual int Get_Delay() 
  {
	if(_attribute_map.find("delay") != _attribute_map.end())
		return(atoi(_attribute_map["delay"].c_str()));
	else
	{
		int dly = this->Get_Longest_Path();
		return(this->_operator_flag ? dly : (dly+2));
	}
  }

  void Increment_Number_Of_Times_Called()
  {
    _number_of_times_called++;
  }
  int Get_Number_Of_Times_Called()
  {
    return(_number_of_times_called);
  }

  bool Has_No_Side_Effects();

  void Set_Foreign_Flag(bool ff) { this->_foreign_flag = ff; }
  bool Get_Foreign_Flag() {return(this->_foreign_flag);}

  void Set_Pipeline_Flag(bool ff) { this->_pipeline_flag = ff; }
  bool Get_Pipeline_Flag() {return(this->_pipeline_flag);}

  virtual bool Is_Pipelined() {return(_pipeline_flag);}

  void Set_Inline_Flag(bool ff);
  virtual bool Can_Block(bool pipeline_flag);

  bool Get_Inline_Flag() {return(this->_inline_flag);}

  void Set_Macro_Flag(bool ff);
  bool Get_Macro_Flag() {return(this->_macro_flag);}

  //
  // for the moment, we will make all static.. seems to
  // break otherwise.  This prevents us from making two
  // copies of a module e.g. if there is a multiple use
  // of an operator..  
  // 
  bool Static_Flag_In_C() {return(true);}
	//{return(!(_inline_flag || _macro_flag || _volatile_flag || _operator_flag));}

  void Add_Argument(AaInterfaceObject* obj);

  void Set_Print_Remap(AaInterfaceObject* obj, AaExpression* expr) { _print_remap[obj] = expr;}
  void Clear_Print_Remap() {_print_remap.clear();}
  AaExpression* Lookup_Print_Remap(AaInterfaceObject* obj);

  void Add_Attribute(string name, string val)
  {
    _attribute_map[name] = val;
  }
  
  bool Has_Attribute(string name)
  {
    return(_attribute_map.find(name) != _attribute_map.end());
  }

  string Get_Attribute_Value(string name)
  {
    string ret_string = "";
    if (this->Has_Attribute(name))
      return(_attribute_map[name]);
    else
      return ret_string;
  }

  void Print_Attributes(ostream& ofile);

  unsigned int Get_Number_Of_Input_Arguments() {return(this->_input_args.size());}
  AaInterfaceObject* Get_Input_Argument(unsigned int index)
  {
    return(this->_input_args[index]);
  }

  unsigned int Get_Number_Of_Output_Arguments() {return(this->_output_args.size());}
  AaInterfaceObject* Get_Output_Argument(unsigned int index)
  {
    return(this->_output_args[index]);
  }

  virtual string Get_C_Name();

  void Print(ostream& ofile);
  void Print_Body(ostream& ofile);
  virtual string Kind() {return("AaModule");}

  virtual AaRoot* Find_Child(string tag);
  virtual void Map_Source_References();

  void Set_Foreign_Object_Representatives();

  //
  // Aa2C support.
  //
  void Write_C_Header(ofstream& ofile);
  void Write_C_Source(ofstream& srcfile, ofstream& headerfile);
  bool Can_Have_Native_C_Interface();

  void Write_VC_Model(ostream& ofile);
  void Write_VC_Model(bool opt_flag, ostream& ofile);


  void Write_VC_Control_Path(bool opt_flag, ostream& ofile);


  void Write_VC_Data_Path(ostream& ofile);
  void Write_VC_Memory_Spaces(bool opt_flag, ostream& ofile);
  void Write_VC_Links(bool opt_flag, ostream& ofile);

  void Write_VC_Model_Optimized(ostream& ofile);

  void Propagate_Constants();
  void Add_Memory_Space(AaMemorySpace* ms)
  {
    _memory_spaces.push_back(ms);
  }

  void Add_Shared_Memory_Space(AaMemorySpace* ms)
  {
    _shared_memory_spaces.insert(ms);
  }

  void Add_Write_Pipe(AaPipeObject* obj)
  {
    if((obj->Get_Scope() == NULL) || 
       (obj->Get_Scope()->Get_Root_Scope() != (AaScope*)this))
      {
	_writes_to_shared_pipe = true;
      }
    _write_pipes.insert(obj);
  }

  void Add_Read_Pipe(AaPipeObject* obj)
  {
    if((obj->Get_Scope() == NULL) || 
       (obj->Get_Scope()->Get_Root_Scope() != (AaScope*)this))
      {
	_reads_from_shared_pipe = true;
      }
    _read_pipes.insert(obj);
  }

  void Write_VHDL_C_Stub_Prefix(ostream& ofile);
  void Write_VHDL_C_Stub_Header(ostream& ofile);
  void Write_VHDL_C_Stub_Source(ostream& ofile);

  virtual void Set_Statement_Sequence(AaStatementSequence* statement_sequence);
  virtual void Write_VC_Control_Path_Optimized_Base(ostream& ofile);

   string Get_C_Outer_Arg_Decl_Macro_Name();
   string Get_C_Outer_Output_Xfer_To_Outer_Macro_Name() ;
   string Get_C_Inner_Input_Args_Prepare_Macro();
   string Get_C_Inner_Output_Args_Prepare_Macro() ;

   void Check_Statements();
};

#endif
