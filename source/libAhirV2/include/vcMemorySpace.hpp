#ifndef _VC_MEMORY_SPACE_H__
#define _VC_MEMORY_SPACE_H__
#include <vcIncludes.hpp>
#include <vcRoot.hpp>

class vcModule;
class vcStorageObject;
class vcMemorySpace: public vcRoot
{
  vcModule* _scope; // module pointer or NULL if at system scope
  map<string, vcStorageObject*> _object_map;
  
  unsigned int _capacity;
  unsigned int _word_size;
  unsigned int _address_width;

  // loads from each memory space
  // for each module, record the indices of the
  // groups which load from this memory space.
  map<vcModule*,vector<int> > _load_group_map;
  int _num_loads;

  // stores to each memory space
  // for each module, record the indices of the
  // groups which store to this memory space.
  map<vcModule*,vector<int> > _store_group_map;
  int _num_stores;

  int _max_number_of_tags_needed;

 public:

  vcModule* Get_Scope() {return(this->_scope);}

  void Register_Load_Group(vcModule* m, int g_id, int num_reqs_in_this_group) 
  {
    _load_group_map[m].push_back(g_id); 
    _num_loads++;
    _max_number_of_tags_needed = MAX(_max_number_of_tags_needed, num_reqs_in_this_group);
  }
  int Get_Num_Loads() {return(this->_num_loads);}

  void Register_Store_Group(vcModule* m, int g_id, int num_reqs_in_this_group) 
  {
    _store_group_map[m].push_back(g_id); 
    _num_stores++;
    _max_number_of_tags_needed = MAX(_max_number_of_tags_needed, num_reqs_in_this_group);
  }
  int Get_Num_Stores() {return(this->_num_stores);}
  int Get_Tag_Length() {return(CeilLog2(this->_max_number_of_tags_needed));}

  string Get_Scope_Id();
  string Get_Hierarchical_Id();
  void Set_Capacity(unsigned int c) { this->_capacity = c;}
  void Set_Word_Size(unsigned int c) { this->_word_size = c;}
  void Set_Address_Width(unsigned int c) { this->_address_width = c;}

  int Get_Capacity() { return this->_capacity;}
  int Get_Word_Size() { return this->_word_size;}
  int Get_Address_Width() {return this->_address_width;}

  virtual string Kind() {return("vcMemorySpace");}

  vcMemorySpace(string id, vcModule* m);

  void Add_Storage_Object(vcStorageObject* obj);
  int Get_Number_Of_Storage_Objects();
  vcStorageObject* Get_Storage_Object(string obj_name);

  void Print_VHDL_Interface_Signal_Declarations(ostream& ofile);

  string Get_VHDL_Memory_Interface_Port_Name(string pid);
  string Get_VHDL_Memory_Interface_Port_Section(vcModule* m,
						string load_or_store,
						string pid,
						int idx);
  virtual void Print(ostream& ofile);

};
#endif // vcMemorySpace
