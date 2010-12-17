
#ifndef _VC_System_H_
#define _VC_System_H_

#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcMemorySpace;
class vcDatapathElementLibrary;
class vcModule;

class vcSystem: public vcRoot
{
  map<string, vcMemorySpace*> _memory_space_map;
  vector<vcModule*> _top_modules;
  map<string, vcModule*> _modules;
  map<string, vcDatapathElementLibrary*> _dpe_libraries;

  static bool _error_flag;
 public:
  vcSystem(string id);
  virtual void Print(ostream& ofile);
  void Add_Module(vcModule* module);
  void Add_Library(vcDatapathElementLibrary* lib);
  void Set_As_Top_Module(vcModule* module);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcModule* Find_Module(string m_name);
  vcDatapathElementLibrary* Find_Library(string lib_name);

  void Elaborate(); // elaborate the system...
  void Print_VHDL(ostream& ofile);
  void Print_VHDL(ofstream& ofile);

  // search in the libraries for the template_id
  vcDatapathElementTemplate* Get_DPE_Template(string library_id, string template_id);

  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }
};

#endif
