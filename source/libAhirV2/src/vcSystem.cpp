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
  this->Print_Pipes(ofile);

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


void vcSystem::Print_Pipes(ostream& ofile)
{
  for(map<string,int>::iterator piter = this->_pipe_map.begin();
      piter != this->_pipe_map.end();
      piter++)
    {
      ofile << vcLexerKeywords[__PIPE] << " [" << (*piter).first << "] " << (*piter).second << endl;
    }
}

void vcSystem::Add_Module(vcModule* module)
{
  assert(this->_modules.find(module->Get_Id()) == this->_modules.end());
  this->_modules[module->Get_Id()] = module;
}

void vcSystem::Set_As_Top_Module(string module_name)
{
  vcModule* m = this->Find_Module(module_name);
  if(m == NULL)
    vcSystem::Error("did not find module " + module_name + " in the system");
  else
    this->Set_As_Top_Module(m);
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

void vcSystem::Elaborate()
{
  this->Check_Control_Structure();
  this->Compute_Compatibility_Labels();
  this->Compute_Maximal_Groups();

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

void vcSystem::Compute_Maximal_Groups()
{
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Compute_Maximal_Groups();
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

void  vcSystem::Print_VHDL(ostream& ofile)
{
  // print modules
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print_VHDL(ofile);
    }

  this->Print_VHDL_Inclusions(ofile);
  this->Print_VHDL_Entity(ofile);
  this->Print_VHDL_Architecture(ofile);
}

void vcSystem::Print_VHDL_Testbench(ostream& ofile) {assert(0);}
void vcSystem::Print_VHDL_Component(ostream& ofile)
{
  ofile << "component " << this->Get_Id() << " is " << endl;
  ofile << "port (" << endl;
  this->_top_module->Print_VHDL_Argument_Ports(ofile);
  ofile << ");" << endl;
  ofile << "end component;" << endl;
  
}
void vcSystem::Print_VHDL_Entity(ostream& ofile)
{
  ofile << "entity " << this->Get_Id() << " is " << endl;
  ofile << "port (" << endl;
  this->_top_module->Print_VHDL_Argument_Ports(ofile);
  ofile << ");" << endl;
  ofile << "end entity;" << endl;

}

void vcSystem::Print_VHDL_Architecture(ostream& ofile)
{
  ofile << "architecture Default of " << this->Get_Id() << " is " << endl;
  ofile << "-- IN PROGRESS " << endl;
  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print_VHDL_Component(ofile);
    }

  ofile << "begin " << endl;
  ofile << "-- IN PROGRESS " << endl;
  ofile << "end Default;" << endl;
  
}

void  vcSystem::Print_VHDL_Inclusions(ostream& ofile)
{
  ofile << "library ieee;\n\
use ieee.std_logic_1164.all;\n			\
library ahir;\n					\
use ahir.memory_subsystem_package.all;\n	\
use ahir.types.all;\n				\
use ahir.subprograms.all;\n			\
use ahir.components.all;\n			\
use ahir.basecomponents.all;\n			\
use ahir.loadstorepack.all;\n			\
use ahir.operatorpackage.all;\n";
}

