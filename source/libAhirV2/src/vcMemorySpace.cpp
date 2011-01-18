#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcObject.hpp>
#include <vcModule.hpp>
#include <vcMemorySpace.hpp>

vcMemorySpace::vcMemorySpace(string id, vcModule* m):vcRoot(id)
{
  this->_scope = m;
  this->_address_width = 0;
  this->_word_size = 0;
  this->_capacity = 0;
  this->_num_loads = 0;
  this->_num_stores = 0;
}

void vcMemorySpace::Add_Storage_Object(vcStorageObject* obj)
{
  assert(obj != NULL);
  this->_object_map[obj->Get_Id()] = obj;
}
int vcMemorySpace::Get_Number_Of_Storage_Objects()
{
  return(this->_object_map.size());
}
vcStorageObject* vcMemorySpace::Get_Storage_Object(string obj_name)
{
  map<string, vcStorageObject*>::iterator miter = this->_object_map.find(obj_name);
  if(miter != this->_object_map.end())
    return((*miter).second);
  else
    return(NULL);
}

string vcMemorySpace::Get_Scope_Id()
{
  string ret_string = "";
  if(this->_scope)
    ret_string = this->_scope->Get_Id();
  return(ret_string);
}

string vcMemorySpace::Get_Hierarchical_Id()
{
  if(this->_scope)
    return(this->Get_Scope_Id() + "/" + this->Get_Id());
  else
    return(this->Get_Id());
}

void vcMemorySpace::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__MEMORYSPACE] << "[" << this->Get_Id() << "] {" << endl;
  ofile << vcLexerKeywords[__CAPACITY] << " " << this->_capacity << " ";
  ofile << vcLexerKeywords[__DATAWIDTH] << " " << this->_word_size << " ";
  ofile << vcLexerKeywords[__ADDRWIDTH] << " " << this->_address_width << " ";

  ofile << endl;

  for(map<string, vcStorageObject*>::iterator miter = this->_object_map.begin();
      miter != this->_object_map.end();
      miter++)
    {
      (*miter).second->Print(ofile);
    }
  ofile << "}" << endl;
}
