
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
  map<string, vcDatapathElementLibrary*> _dpe_libraries;

  static bool _error_flag;
 public:
  vcSystem(string id);
  virtual void Print(ostream& ofile);
  void Add_Module(vcModule* module);
  void Add_Library(vcDatapathElementLibrary* lib);
  void Set_As_Top_Module(vcModule* module);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string module_name, string ms_name); 
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcModule* Find_Module(string m_name);
  vcDatapathElementLibrary* Find_Library(string lib_name);

  void Elaborate(); // elaborate the system...





  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }


  vcDatapathElementTemplate* Get_DPE_Template(string library_id, string template_id);

  void Check_Control_Structure();
  void Compute_Compatibility_Labels();
  void Print_Control_Structure(ostream& ofile);

  virtual void Print_VHDL(ostream& ofile);
  void Print_VHDL(string top_module_name);
};

void vcParse(string filename, vcSystem* sys);
#endif
