
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

class vcSystem: public vcRoot
{
  map<string, vcMemorySpace*> _memory_space_map;
  vcModule* _top_module;
  map<string, vcModule*> _modules;

  map<string,int> _pipe_map;

  map<string, map<vcModule*, vector<int> > > _pipe_read_map; // inports on modules connected to pipe.
  map<string, int> _pipe_read_count;

  map<string, map<vcModule*, vector<int> > > _pipe_write_map; // inports on modules connected to pipe.
  map<string, int> _pipe_write_count;

  static bool _error_flag;
 public:
  vcSystem(string id);
  virtual void Print(ostream& ofile);

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

  int Get_Num_Pipe_Writes(string pipe_id)
  {
    if(_pipe_write_count.find(pipe_id) != _pipe_write_count.end())
      return(_pipe_write_count[pipe_id]);
    else
      return(0);
  }

  bool Has_Pipe(string pipe_id) {return(_pipe_map.find(pipe_id) != _pipe_map.end());}

  void Add_Pipe(string pipe_id, int width) 
  {
    assert(_pipe_map.find(pipe_id) == _pipe_map.end());
    assert(width > 0);
    _pipe_map[pipe_id] = width;
  }

  int Get_Pipe_Width(string pipe_id)
  {
    assert(_pipe_map.find(pipe_id) != _pipe_map.end());return(_pipe_map[pipe_id]);
  }

  void Print_Pipes(ostream& ofile);

  void Add_Module(vcModule* module);
  void Set_As_Top_Module(vcModule* module);
  void Set_As_Top_Module(string module_name);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string module_name, string ms_name); 
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcModule* Find_Module(string m_name);

  void Elaborate(); // elaborate the system...

  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }

  void Check_Control_Structure();
  void Compute_Compatibility_Labels();
  void Compute_Maximal_Groups();
  void Print_Control_Structure(ostream& ofile);

  virtual void Print_VHDL(ostream& ofile);

  void Print_VHDL_Testbench(ostream& ofile);
  void Print_VHDL_Component(ostream& ofile);
  void Print_VHDL_Entity(ostream& ofile);
  void Print_VHDL_Architecture(ostream& ofile);
  static void Print_VHDL_Inclusions(ostream& ofile);

  void Parse(string filename);
};


#endif
