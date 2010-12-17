
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

  map<string, vcType*> _type_map;
  vector<vcType*> _type_vector;

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



  static void Error(string err_msg); // {_error_flag = true;}
  static void Warning(string err_msg); // {_warning_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }


  vcDatapathElementTemplate* Get_DPE_Template(string library_id, string template_id);
  void Add_Type(string tid, vcType* t);
  vcIntType* Make_Integer_Type(unsigned int w);
  vcFloatType* Make_Float_Type(unsigned int c, unsigned int m);
  vcArrayType* Make_Array_Type(vcType* etype, unsigned int dim);
  vcRecordType* Make_Record_Type(vector<vcType*>& etypes);
  vcPointerType* Make_Pointer_Type(string scope_id, string space_id);

};

#endif
