//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.

#ifndef _VC_System_H_
#define _VC_System_H_

#include <vcIncludes.hpp>
#include <vcRoot.hpp>
class vcType;
class vcIntType;
class vcFloatType;
class vcArrayType;
class vcRecordType;
class vcPointerType;
class vcMemorySpace;
class vcDatapathElementLibrary;
class vcDatapathElementTemplate;
class vcModule;
class vcConstantWire;
class vcValue;
class vcPipe;
class vcTransition;

class vcSystem: public vcRoot
{
  map<string, vcMemorySpace*> _memory_space_map;
  set<vcModule*,vcRoot_Compare> _top_module_set;
  set<vcModule*,vcRoot_Compare> _ever_running_top_module_set;

  map<string, vcModule*> _modules;
  map<string, vcModule*> _unreachable_modules;
  map<string,vcConstantWire*> _constant_map;

  // pipe-related stuff.
  map<string,vcPipe*> _pipe_map;

  map<string, pair<string,int> >  _function_library_module_map;
  vector<vcModule*> _ordered_modules;

  // gated clocks -> enable
  map<string, string> _gated_clock_map;


 public:
  static bool _error_flag;
  static bool _suppress_io_pipes;
  static bool _verbose_flag;
  static bool _opt_flag;
  static bool _min_area_flag;
  static bool _min_clock_period_flag;

  static bool _vhpi_tb_flag;

  static string _simulator_link_prefix;
  static string _simulator_link_library;
  static string _vhdl_work_library;

  static string _tool_name;
  static bool _enable_logging;

  static bool _uses_function_library;
  static set<string> _non_ahir_function_library_libs;
  static vector<pair<vcTransition*, vcTransition*> > _scc_arcs;

  static string _top_entity_name;
  static int _estimated_buffering_bits;
  static int _number_of_marked_arcs_saved;

  static int _bypass_stride;
  static bool _generate_hsys_file;
  void Print_Hsys_File(string file_name);

  vcSystem(string id);
  virtual void Print(ostream& ofile);

  static int _register_bank_threshold;

  static int _fifo_register_count;
  static void Increment_Fifo_Register_Count(int S);

  map<string, vcModule*>& Get_Modules() { return _modules; }
  vector<vcModule*>& Get_Ordered_Modules() { return _ordered_modules; }

  void Register_Pipe_Read(string pipe_id, vcModule* m, int idx);
  int Get_Num_Pipe_Reads(string pipe_id);
  void Register_Pipe_Write(string pipe_id, vcModule* m, int idx);
  void Deregister_Pipe_Accesses(vcModule* m);
  int Get_Num_Pipe_Writes(string pipe_id);
  map<string,vcPipe*>& Get_Pipe_Map() { return _pipe_map; }
  bool Has_Pipe(string pipe_id) 
  {
    return(_pipe_map.find(pipe_id) != _pipe_map.end());
  }
  vcPipe* Find_Pipe(string pipe_id)
  {
    if(_pipe_map.find(pipe_id) !=  _pipe_map.end())
      {
	return(_pipe_map[pipe_id]);
      }
    else
      return NULL;
  }
  void Add_Pipe(string pipe_id, int width, int depth, bool lifo_mode, bool noblock_mode, bool in_flag, bool out_flag, bool signal_flag, 
		bool p2p_flag, bool shiftreg_flag, bool full_rate, bool bypass);
  int Get_Pipe_Width(string pipe_id);
  int Get_Pipe_Depth(string pipe_id);
  void Print_Pipes(ostream& ofile);

  void Add_Gated_Clock(string gc_name, string enable_name);

  void Add_Constant_Wire(string obj_name, vcValue* v);
  vcConstantWire* Find_Constant_Wire(string obj_name)
  {
    map<string,vcConstantWire*>::iterator iter = _constant_map.find(obj_name);
    if(iter != _constant_map.end())
      return((*iter).second);
    else
      return(NULL);
  }




  void Add_Module(vcModule* module);

  void Set_As_Top_Module(vcModule* module);
  void Set_As_Top_Module(string module_name);
  bool Is_A_Top_Module(vcModule* m);

  void Set_As_Ever_Running_Top_Module(vcModule* module);
  void Set_As_Ever_Running_Top_Module(string module_name);
  bool Is_An_Ever_Running_Top_Module(vcModule* m);

  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string module_name, string ms_name); 
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcModule* Find_Module(string m_name);

  void Detach_Unreachable_Modules();
  void Elaborate(); // elaborate the system...
  void Mark_Clock_Enables();


  static void Info(string err_msg); // {_error_flag = true;}
  static void DebugInfo(string err_msg); // {_error_flag = true;}
  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }

  void Check_Control_Structure();
  void Compute_Compatibility_Labels();
  void Compute_Maximal_Groups();
  void Print_Control_Structure(ostream& ofile);

  // VHDL related stuff... 
  virtual void Print_VHDL(ostream& ofile);
  void Print_VHDL_Global_Package(ostream& ofile);
  void Print_VHDL_Test_Bench(ostream& ofile);
  void Print_VHDL_Vhpi_Test_Bench(ostream& ofile);
  void Print_VHDL_Component(ostream& ofile);
  void Print_VHDL_Entity(ostream& ofile);
  void Print_VHDL_Architecture(ostream& ofile);
  static void Print_VHDL_Inclusions(ostream& ofile);

  void Print_VHDL_Gated_Clock_Signals(set<vcModule*>& modules_with_gated_clocks, ostream& ofile);
  void Print_VHDL_Gated_Clock_Generators(set<vcModule*>& modules_with_gated_clocks, ostream& ofile);

  string Print_VHDL_Pipe_Ports(string semi_colon, ostream& ofile);
  void Print_VHDL_Pipe_Signals(ostream& ofile);
  bool Get_Pipe_Module_Section(string pipe_id, 
			       vcModule* caller_module, 
			       string read_or_write, 
			       int& hindex, 
			       int& lindex);
  string Get_Pipe_Aggregate_Section(string pipe_id,
				    string pid, 
				    int hindex, 
				    int lindex);
  string Get_VHDL_Pipe_Interface_Port_Name(string pipe_id, string pid);
  void Print_VHDL_Pipe_Instances(ostream& ofile);
  string Print_VHDL_System_Ports(string semi_colon, ostream& ofile);
  void Print_VHDL_Pipe_Port_Signals(ostream& ofile);
  void Print_VHDL_Test_Bench_Signals(ostream& ofile);
  void Print_VHDL_Instance(ostream& ofile);
  string Print_VHDL_System_Instance_Pipe_Port_Map(string comma, ostream& ofile);
  string Print_VHDL_Instance_Port_Map(string comma, ostream& ofile);

  void  Print_VHDL_Constant_Declarations(ostream& ofile);
  void Parse(string filename);

  static string Get_Sys_Package_Name()
  {
     return(To_VHDL(vcSystem::_top_entity_name) + "_global_package");
  }

  void Add_Function_Library(string& file_name);
  bool Is_Function_Library_Module(int& delay, string& mod_name, string& lib_name);

  void Print_Reduced_Control_Paths_As_Dot_Files();
  void Print_Data_Paths_As_Dot_Files();
};


#endif
