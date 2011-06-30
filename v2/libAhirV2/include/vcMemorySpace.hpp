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
  
  unsigned int _capacity; // in number of bits
  unsigned int _word_size; // in number of bits
  unsigned int _address_width; // in number of bits.
  unsigned int _max_access_width; // maximum access width

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

  map<vcModule*, int> _max_tag_map;

 public:

  vcModule* Get_Scope() {return(this->_scope);}

  int Get_Max_Number_Of_Tags_Needed()
  {
    int ret_val = 0;
    for(map<vcModule*,int >::iterator liter = _max_tag_map.begin();
	liter != _max_tag_map.end();
	liter++)
      {
	ret_val = MAX(ret_val, (*liter).second);
      }
    return(ret_val);
  }

  void Register_Load_Group(vcModule* m, int g_id, int num_reqs_in_this_group) 
  {
    _load_group_map[m].push_back(g_id); 

    if(_max_tag_map.find(m) == _max_tag_map.end())
      _max_tag_map[m] = num_reqs_in_this_group;
    else
      {
	int u =    _max_tag_map[m];
	_max_tag_map[m] = MAX(u,num_reqs_in_this_group);
      }

    _num_loads++;
  }
  int Get_Num_Loads() {return(this->_num_loads);}

  void Register_Store_Group(vcModule* m, int g_id, int num_reqs_in_this_group) 
  {
    _store_group_map[m].push_back(g_id); 

    if(_max_tag_map.find(m) == _max_tag_map.end())
      _max_tag_map[m] = num_reqs_in_this_group;
    else
      {
	int u =    _max_tag_map[m];
	_max_tag_map[m] = MAX(u,num_reqs_in_this_group);
      }


    _num_stores++;
  }


  void Deregister_Loads_And_Stores(vcModule* m)
  {

    if(_max_tag_map.find(m) != _max_tag_map.end())
      _max_tag_map.erase(m);

    if(_load_group_map.find(m) != _load_group_map.end())
      {
	_num_loads -= _load_group_map[m].size();
	_load_group_map.erase(m);
      }

    if(_store_group_map.find(m) != _store_group_map.end())
      {
	_num_stores -= _store_group_map[m].size();
	_store_group_map.erase(m);
      }
  }

  int Get_Num_Stores() {return(this->_num_stores);}
  int Get_Tag_Length() {return(CeilLog2(this->Get_Max_Number_Of_Tags_Needed()));}

  string Get_Scope_Id();
  string Get_Hierarchical_Id();
  void Set_Capacity(unsigned int c) { this->_capacity = c;}
  void Set_Word_Size(unsigned int c) { this->_word_size = c;}
  void Set_Address_Width(unsigned int c) { this->_address_width = c;}
  void Set_Max_Access_Width(unsigned int w) {this->_max_access_width = w;}

  int Get_Capacity() { return this->_capacity;}
  int Get_Word_Size() { return this->_word_size;}
  int Get_Address_Width() {return this->_address_width;}
  int Get_Max_Access_Width() {return this->_max_access_width;}

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

  bool Get_Caller_Module_Section(vcModule* caller_module, string load_or_store, int& hindex, int& lindex);
  string Get_Aggregate_Section(string pid, int hindex, int lindex);

  virtual void Print(ostream& ofile);
  void Print_VHDL_Instance(ostream& ofile);

  int Calculate_Number_Of_Banks();
  int Calculate_Base_Bank_Address_Width();
  int Calculate_Base_Bank_Data_Width();
};
#endif // vcMemorySpace
