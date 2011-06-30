
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

class vcSystem: public vcRoot
{
  map<string, vcMemorySpace*> _memory_space_map;
  set<vcModule*,vcRoot_Compare> _top_module_set;
  set<vcModule*,vcRoot_Compare> _ever_running_top_module_set;

  map<string, vcModule*> _modules;
  map<string, vcModule*> _unreachable_modules;


  map<string,int> _pipe_map;
  map<string,int> _pipe_depth_map;

  map<string,vcConstantWire*> _constant_map;

  map<string, map<vcModule*, vector<int> > > _pipe_read_map; // inports on modules connected to pipe.
  map<string, int> _pipe_read_count;

  map<string, map<vcModule*, vector<int> > > _pipe_write_map; // inports on modules connected to pipe.
  map<string, int> _pipe_write_count;

  static bool _error_flag;
 public:
  static bool _verbose_flag;
  static bool _opt_flag;
  static bool _min_area_flag;

  static bool _vhpi_tb_flag;
  static string _simulator_prefix;

  vcSystem(string id);
  virtual void Print(ostream& ofile);

  static int _register_bank_threshold;



  void Register_Pipe_Read(string pipe_id, vcModule* m, int idx)
  {
    ((_pipe_read_map[pipe_id])[m]).push_back(idx);
    if(_pipe_read_count.find(pipe_id) == _pipe_read_count.end())
      _pipe_read_count[pipe_id] = 0;

    _pipe_read_count[pipe_id]++;
  }

  int Get_Num_Pipe_Reads(string pipe_id)
  {
    if(_pipe_read_count.find(pipe_id) != _pipe_read_count.end())
      return(_pipe_read_count[pipe_id]);
    else
      return(0);
  }

  void Register_Pipe_Write(string pipe_id, vcModule* m, int idx)
  {
    ((_pipe_write_map[pipe_id])[m]).push_back(idx);
    if(_pipe_write_count.find(pipe_id) == _pipe_write_count.end())
      _pipe_write_count[pipe_id] = 0;
    
    _pipe_write_count[pipe_id]++;
  }

  void Deregister_Pipe_Accesses(vcModule* m)
  {
    for(map<string,int>::iterator iter = _pipe_map.begin(), iiter = _pipe_map.end();
	iter != iiter;
	iter++)
      {
	string pipe_name = (*iter).first;
	if(_pipe_read_map.find(pipe_name) != _pipe_read_map.end())
	  {
	    if(_pipe_read_map[pipe_name].find(m) != _pipe_read_map[pipe_name].end())
	      {
		_pipe_read_count[pipe_name] -= _pipe_read_map[pipe_name][m].size();
		_pipe_read_map[pipe_name].erase(m);
	      }
	  }

	if(_pipe_write_map.find(pipe_name) != _pipe_write_map.end())
	  {
	    if(_pipe_write_map[pipe_name].find(m) != _pipe_write_map[pipe_name].end())
	      {
		_pipe_write_count[pipe_name] -= _pipe_write_map[pipe_name][m].size();
		_pipe_write_map[pipe_name].erase(m);
	      }
	  }
      }
  }

  int Get_Num_Pipe_Writes(string pipe_id)
  {
    if(_pipe_write_count.find(pipe_id) != _pipe_write_count.end())
      return(_pipe_write_count[pipe_id]);
    else
      return(0);
  }

  bool Has_Pipe(string pipe_id) {return(_pipe_map.find(pipe_id) != _pipe_map.end());}

  void Add_Pipe(string pipe_id, int width, int depth) 
  {
    assert(_pipe_map.find(pipe_id) == _pipe_map.end());
    assert(width > 0);
    assert(depth > 0);

    _pipe_map[pipe_id] = width;
    _pipe_depth_map[pipe_id] = depth;
  }

  void Add_Constant_Wire(string obj_name, vcValue* v);
  vcConstantWire* Find_Constant_Wire(string obj_name)
  {
    map<string,vcConstantWire*>::iterator iter = _constant_map.find(obj_name);
    if(iter != _constant_map.end())
      return((*iter).second);
    else
      return(NULL);
  }

  int Get_Pipe_Width(string pipe_id)
  {
    assert(_pipe_map.find(pipe_id) != _pipe_map.end());return(_pipe_map[pipe_id]);
  }

  int Get_Pipe_Depth(string pipe_id)
  {
    assert(_pipe_depth_map.find(pipe_id) != _pipe_depth_map.end());return(_pipe_depth_map[pipe_id]);
  }

  void Print_Pipes(ostream& ofile);

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


  static void Info(string err_msg); // {_error_flag = true;}
  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }

  void Check_Control_Structure();
  void Compute_Compatibility_Labels();
  void Compute_Maximal_Groups();
  void Print_Control_Structure(ostream& ofile);

  // VHDL related stuff... 
  virtual void Print_VHDL(ostream& ofile);
  void Print_VHDL_Test_Bench(ostream& ofile);
  void Print_VHDL_Vhpi_Test_Bench(ostream& ofile);
  void Print_VHDL_Component(ostream& ofile);
  void Print_VHDL_Entity(ostream& ofile);
  void Print_VHDL_Architecture(ostream& ofile);
  static void Print_VHDL_Inclusions(ostream& ofile);

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
};


#endif
