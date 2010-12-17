#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcObject.hpp>
#include <vcMemorySpace.hpp>

vcMemorySpace::vcMemorySpace(string id):vcRoot(id)
{
  this->_address_width = 0;
  this->_word_size = 0;
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

void vcMemorySpace::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__MEMORYSPACE] << "[" << this->Get_Id() << "] {" << endl;
  ofile << vcLexerKeywords[__CAPACITY] << " " << this->_capacity << " ";
  ofile << vcLexerKeywords[__DATAWIDTH] << " " << this->_word_size << " ";
  ofile << vcLexerKeywords[__ADDRWIDTH] << " " << this->_address_width << " ";

  for(map<string, vcStorageObject*>::iterator miter = this->_object_map.begin();
      miter != this->_object_map.end();
      miter++)
    {
      (*miter).second->Print(ofile);
    }
  ofile << "}" << endl;
}
