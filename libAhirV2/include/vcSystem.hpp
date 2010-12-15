
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

 public:
  vcSystem(string id);
  virtual void Print(ostream& ofile);
  void Add_Module(string m_id, vcModule* module);
  void Add_Library(string m_id, vcDatapathElementLibrary* lib);
  void Set_As_Top_Module(vcModule* module);
  void Add_Memory_Space(vcMemorySpace* ms);
  vcMemorySpace* Find_Memory_Space(string ms_name);
  vcModule* Find_Module(string m_name);
  vcDatapathElementLibrary* Find_Library(string lib_name);

  void Elaborate(); // elaborate the system...
  void Print_VHDL(ostream& ofile);
  void Print_VHDL(ofstream& ofile);
};

#endif
