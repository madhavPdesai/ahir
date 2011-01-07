#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcType.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcModule.hpp>
#include <vcSystem.hpp>

bool vcSystem::_error_flag = false;

vcSystem::vcSystem(string id):vcRoot(id)
{
}
void vcSystem::Print(ostream& ofile)
{
  // libraries
  for(map<string,vcDatapathElementLibrary*>::iterator libiter = _dpe_libraries.begin();
      libiter != _dpe_libraries.end();
      libiter++)
    {
      (*libiter).second->Print(ofile);
    }

  // memory spaces
  for(map<string,vcMemorySpace*>::iterator msiter = _memory_space_map.begin();
      msiter != _memory_space_map.end();
      msiter++)
    {
      (*msiter).second->Print(ofile);
    }

  // modules
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print(ofile);
    }

  // attributes
  this->Print_Attributes(ofile);
}

void vcSystem::Add_Module(vcModule* module)
{
  assert(this->_modules.find(module->Get_Id()) == this->_modules.end());
  this->_modules[module->Get_Id()] = module;
}
void vcSystem::Add_Library(vcDatapathElementLibrary* lib)
{
  string m_id = lib->Get_Id();
  assert(this->_dpe_libraries.find(m_id) == this->_dpe_libraries.end());
  this->_dpe_libraries[m_id] = lib;
}

void vcSystem::Set_As_Top_Module(vcModule* module)
{
  this->_top_module = module;
}

void vcSystem::Add_Memory_Space(vcMemorySpace* ms)
{
  assert(ms != NULL);
  string m_id = ms->Get_Id();
  
  assert(this->_memory_space_map.find(m_id) == this->_memory_space_map.end());
  this->_memory_space_map[m_id] = ms;
}

vcMemorySpace* vcSystem::Find_Memory_Space(string module_name, string ms_name)
{
  if(module_name == "")
    return(this->Find_Memory_Space(ms_name));

  vcModule* m = this->Find_Module(module_name);
  if(m==NULL)
    return(NULL);

  return(m->Find_Memory_Space(ms_name));
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
  map<string, vcModule*>::iterator iter = this->_modules.find(m_name);
  if(iter != this->_modules.end())
    ret_module = (*iter).second;
  return(ret_module);
}
vcDatapathElementLibrary* vcSystem::Find_Library(string lib_name)
{
  vcDatapathElementLibrary* ret_lib = NULL;
  map<string, vcDatapathElementLibrary*>::iterator iter = this->_dpe_libraries.find(lib_name);
  if(iter != this->_dpe_libraries.end())
    ret_lib = (*iter).second;
  return(ret_lib);
}

void vcSystem::Elaborate()
{
  assert(0 && "todo");
}
 

void vcSystem::Error(string err_msg)
{
  cerr << "Error: " << err_msg << endl;
  vcSystem::_error_flag = true;
}

void vcSystem::Warning(string err_msg)
{
  cerr << "Warning: " << err_msg << endl;
}


bool vcSystem::Get_Error_Flag()
{
  return(vcSystem::_error_flag);
}


vcDatapathElementTemplate* vcSystem::Get_DPE_Template(string library_id, string template_id)
{
  vcDatapathElementTemplate* t = NULL;
  vcDatapathElementLibrary* lib = this->Find_Library(library_id);
  if(lib == NULL)
    {
      string err_msg = "could not find library " + library_id;
      this->Error(err_msg);
    }
  else
    {
      t = lib->Get_Template(template_id);
      if(t == NULL)
	{
	  this->Error(string("could not find template ") + template_id + " in library " + library_id);
	}
    }
  return(t);
}


void vcSystem::Check_Control_Structure()
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Check_Control_Structure();
    }
}
void vcSystem::Compute_Compatibility_Labels()
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Compute_Compatibility_Labels();
    }

}

void vcSystem::Print_Control_Structure(ostream& ofile)
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print_Control_Structure(ofile);
    }
}


void vcSystem::Print_VHDL(string top_module_name)
{
  vcModule* top_module = this->Find_Module(top_module_name);
  if(top_module == NULL)
    {
      vcSystem::Error("could not find module " + top_module_name);
      return;
    }

  this->_top_module = top_module;

  ofstream outfile;
  string file_name = (string("SystemWith_") + top_module_name + "_AsTop.vhd");
  outfile.open(file_name.c_str());
  this->Print_VHDL(outfile);
  outfile.close();
}


void  vcSystem::Print_VHDL(ostream& ofile)
{
  ofile << "library ieee;\n\
              use ieee.std_logic_1164.all;\n\
              library ahir;\n\
              use ahir.memory_subsystem_package.all;\n\
              use ahir.types.all;\n\
              use ahir.subprograms.all;\n\
              use ahir.components.all;\n\
              use ahir.basecomponents.all;\n\
              use ahir.loadstorepack.all;\n\
              use ahir.operatorpackage.all;\n";
}



