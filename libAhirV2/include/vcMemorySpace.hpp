#ifndef _VC_MEMORY_SPACE_H__
#define _VC_MEMORY_SPACE_H__
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcStorageObject;
class vcMemorySpace: public vcRoot
{
  map<string, vcStorageObject*> _object_map;
  
  unsigned int _capacity;
  unsigned int _word_size;
  unsigned int _address_width;

 public:


  void Set_Capacity(unsigned int c) { this->_capacity = c;}
  void Set_Word_Size(unsigned int c) { this->_word_size = c;}
  void Set_Address_Width(unsigned int c) { this->_address_width = c;}

  int Set_Capacity() { return this->_capacity;}
  int Set_Word_Size() { return this->_word_size;}
  int Set_Address_Width() {return this->_address_width;}

  virtual string Kind() {return("vcMemorySpace");}

  vcMemorySpace(string id);
  void Add_Storage_Object(vcStorageObject* obj);
  int Get_Number_Of_Storage_Objects();
  vcStorageObject* Get_Storage_Object(string obj_name);

  virtual void Print(ostream& ofile);

};
#endif // vcMemorySpace
