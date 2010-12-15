#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>


vcSystem::vcSystem(string id):vcRoot(id)
{
}
void vcSystem::Print(ostream& ofile)
{
}
void vcSystem::Add_Module(string m_id, vcModule* module)
{
  assert(this->_modules.find(m_id) == this->_modules.end());
  this->_modules[m_id] = module;
}
void vcSystem::Add_Library(string m_id, vcDatapathElementLibrary* lib)
{
  assert(this->_dpe_libraries.find(m_id) == this->_dpe_libraries.end());
  this->_dpe_libraries[m_id] = lib;
}
void vcSystem::Set_As_Top_Module(vcModule* module)
{
  bool add_flag = true;
  for(int idx = 0; idx < this->_top_modules.size(); idx++)
    {
      if(this->_top_modules[idx] == module)
	{
	  add_flag = false;
	  break;
	}
    }
  if(add_flag)
    this->_top_modules.push_back(module);
}

void vcSystem::Add_Memory_Space(string m_id, vcMemorySpace* ms)
{
  assert(this->_memory_space_map.find(m_id) == this->_memory_space_map.end());
  this->_memory_space_map[m_id] = ms;
}
vcMemorySpace* vcSystem::Find_Memory_Space(string ms_name)
{
  vcMemorySpace* ret_space = NULL;
  map<string, vcMemorySpace*>::iterator iter = this->_memory_space_map.find(ms_name);
  if(iter != this->_memory_space_map.end())
    ret_space = (*iter).second;
  return(ret_space);
}
vcModule* vcSystem::Find_Module(string m_name)
{
  vcModule* ret_module = NULL;
  map<string, vcModule*>::iterator iter = this->_modules.find(ms_name);
  if(iter != this->_modules.end())
    ret_module = (*iter).second;
  return(ret_module);
}
vcDatapathElementLibrary* vcSystem::Find_Library(string lib_name)
{
  vcDatapathElementLibrary* ret_lib = NULL;
  map<string, vcDatapathElementLibrary*>::iterator iter = this->_dpe_libraries.find(ms_name);
  if(iter != this->_dpe_libraries.end())
    ret_lib = (*iter).second;
  return(ret_lib);
}

void vcSystem::Elaborate()
{
  assert(0 && "todo");
}
 
void vcSystem::Print_VHDL(ostream& ofile)
{
  assert(0 && "todo");

}
void vcSystem::Print_VHDL(ofstream& ofile)
{
  ostream* outstr = &ofile;
  this->Print(*outstr);
}




