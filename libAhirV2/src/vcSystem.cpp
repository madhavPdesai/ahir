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
  for(map<string,vcMemorySpace*>::iterator msiter = _memory_space_map.begin();
      msiter != _memory_space_map.end();
      msiter++)
    {
      (*msiter).second->Print(ofile);
    }

  for(map<string,vcModule*>::iterator moditer = _modules.begin();
      moditer != _modules.end();
      moditer++)
    {
      (*moditer).second->Print(ofile);
    }

  for(map<string,vcDatapathElementLibrary*>::iterator libiter = _dpe_libraries.begin();
      libiter != _dpe_libraries.end();
      libiter++)
    {
      (*libiter).second->Print(ofile);
    }

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

void vcSystem::Add_Memory_Space(vcMemorySpace* ms)
{
  assert(ms != NULL);
  string m_id = ms->Get_Id();
  
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
 
void vcSystem::Print_VHDL(ostream& ofile)
{
  assert(0 && "todo");

}

void vcSystem::Print_VHDL(ofstream& ofile)
{
  ostream* outstr = &ofile;
  this->Print(*outstr);
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


void vcSystem::Add_Type(string tid, vcType* t)
{
  this->_type_map[tid] = t;
  this->_type_vector.push_back(t);
  t->Set_Index(this->_type_vector.size());
}

vcIntType* vcSystem::Make_Integer_Type(unsigned int w)
{
  vcIntType* ret_type = NULL;
  string tid = "int<" + IntToStr(w) + ">";
  std::map<string,vcType*>::iterator titer = this->_type_map.find(tid);
  if(titer != this->_type_map.end())
    {
      assert((*titer).second->Is("vcIntType"));
      ret_type = (vcIntType*) (*titer).second;
    }
  else
    {
      ret_type = new vcIntType(w);
      this->Add_Type(tid,ret_type);
    }
  return(ret_type);
}

vcFloatType* vcSystem::Make_Float_Type(unsigned int c, unsigned int m)
{
  vcFloatType* ret_type = NULL;
  string tid = "float<" + IntToStr(c) + "," + IntToStr(m) + ">";
  std::map<string,vcType*>::iterator titer = this->_type_map.find(tid);
  if(titer != this->_type_map.end())
    {
      assert((*titer).second->Is("vcFloatType"));
      ret_type = (vcFloatType*) (*titer).second;
    }
  else
    {
      ret_type = new vcFloatType(this->Make_Integer_Type(c),this->Make_Integer_Type(m));
      this->Add_Type(tid,ret_type);
    }
  return(ret_type);
}
vcArrayType* vcSystem::Make_Array_Type(vcType* etype, unsigned int dim)
{
  vcArrayType* ret_type = NULL;
  string tid = "array<" + IntToStr(dim) + "> of " + IntToStr(etype->Get_Index());
  assert(etype->Get_Index() > 0);
  std::map<string,vcType*>::iterator titer = this->_type_map.find(tid);
  if(titer != this->_type_map.end())
    {
      assert((*titer).second->Is("vcArrayType"));
      ret_type = (vcArrayType*) (*titer).second;
    }
  else
    {
      ret_type = new vcArrayType(etype,dim);
      this->Add_Type(tid,ret_type);
    }
  return(ret_type);

}
vcRecordType* vcSystem::Make_Record_Type(vector<vcType*>& etypes)
{
  vcRecordType* ret_type = NULL;
  string tid = "record ";
  for(int idx = 0; idx < etypes.size(); idx++)
    {
      assert(etypes[idx]->Get_Index() > 0);
      tid += IntToStr(etypes[idx]->Get_Index()) + " ";
    }

  std::map<string,vcType*>::iterator titer = this->_type_map.find(tid);
  if(titer != this->_type_map.end())
    {
      assert((*titer).second->Is("vcRecordType"));
      ret_type = (vcRecordType*) (*titer).second;
    }
  else
    {
      ret_type = new vcRecordType(etypes);
      this->Add_Type(tid,ret_type);
    }
  return(ret_type);
}

vcPointerType* vcSystem::Make_Pointer_Type(string scope_id, string space_id)
{
  vcPointerType* ret_type = NULL;
  string tid = "pointer " + scope_id + " " + space_id;

  std::map<string,vcType*>::iterator titer = this->_type_map.find(tid);
  if(titer != this->_type_map.end())
    {
      assert((*titer).second->Is("vcPointerType"));
      ret_type = (vcPointerType*) (*titer).second;
    }
  else
    {
      ret_type = new vcPointerType(scope_id, space_id);
      vcMemorySpace* ms = NULL;
      if(scope_id == "")
	ms = this->Find_Memory_Space(space_id);
      else 
	{
	  vcModule* m = this->Find_Module(scope_id);
	  if(m == NULL)
	    {
	      this->Error("did not find module " + scope_id );
	    }
	  else
	    ms = m->Find_Memory_Space(space_id);
	}

      ret_type->Set_Memory_Space(ms);
      this->Add_Type(tid,ret_type);
    }
  return(ret_type);
}





