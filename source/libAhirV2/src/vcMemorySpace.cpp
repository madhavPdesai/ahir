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
  this->_max_number_of_tags_needed = 0;
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

void vcMemorySpace::Print_VHDL_Interface_Signal_Declarations(ostream& ofile)
{
  int num_load_reqs = this->_num_loads;
  int num_store_reqs = this->_num_stores;

  int tag_length = this->Get_Tag_Length();
  int addr_width = this->_address_width;
  int data_width = this->_word_size;

  if(num_load_reqs > 0)
    {
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_req") 
	    << " :  std_logic_vector(" << num_load_reqs-1  << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_ack") 
	    << " : std_logic_vector(" << num_load_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_addr") 
	    << " : std_logic_vector(" << (num_load_reqs*addr_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_tag") 
	    << " : std_logic_vector(" << (num_load_reqs* tag_length)-1  << " downto 0);" << endl;
      
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lc_req") 
	    << " : std_logic_vector(" << num_load_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lc_ack") 
	    << " :  std_logic_vector(" << num_load_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lc_data") 
	    << " : std_logic_vector(" << (num_load_reqs*data_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lc_tag") 
	    << " :  std_logic_vector("  << (num_load_reqs*tag_length)-1  << " downto 0);" << endl;
      
    }

  if(num_store_reqs > 0)
    {
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_req") 
	    << " :  std_logic_vector(" << num_store_reqs-1  << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_ack") 
	    << " : std_logic_vector(" << num_store_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_addr") 
	    << " : std_logic_vector(" << (num_store_reqs*addr_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_data") 
	    << " : std_logic_vector(" << (num_store_reqs*data_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_tag") 
	    << " : std_logic_vector(" << (num_store_reqs* tag_length)-1  << " downto 0);" << endl;
      
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sc_req") 
	    << " : std_logic_vector(" << num_store_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sc_ack") 
	    << " :  std_logic_vector(" << num_store_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sc_tag") 
	    << " :  std_logic_vector("  << (num_store_reqs*tag_length)-1  << " downto 0);" << endl;
    }
}


string vcMemorySpace::Get_VHDL_Memory_Interface_Port_Name(string pid)
{
  return(this->Get_Id() + "_" + pid);
}

// given a module, and type of operation,
// find the section of the port of type pid
// from the module memory interface ports
// for this memory space.
//
// algorithm: find the position of idx (from the left)
// in the vector of load/store groups associated
// with this memory space from the module m.
// Then, calculate the section using the word-size.
string vcMemorySpace::Get_VHDL_Memory_Interface_Port_Section(vcModule* m,
							     string load_or_store,
							     string pid,
							     int idx)
{
  map<vcModule*,vector<int> >::iterator iter;
  if(load_or_store == "load")
    {
      iter = _load_group_map.find(m);
      assert(iter != _load_group_map.end());
    }
  else
    {
      iter = _store_group_map.find(m);
      assert(iter != _store_group_map.end());
    }

  int down_index;
  // left to right 
  for(int index = 0; index < (*iter).second.size(); index++)
    {
      down_index = ((*iter).second.size()-1) - index; // position from left.
      if(idx == (*iter).second[index])
	break;
      if(index == (*iter).second.size() - 1)
	assert(0);
    }

  if((pid.find("req") != string::npos) || (pid.find("ack") != string::npos))
    return(this->Get_Id() + "_" + pid + "(" + IntToStr(down_index) + ")");
  else if(pid.find("data") != string::npos)
    return(this->Get_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*this->Get_Word_Size())-1) + " downto "
	   + IntToStr(down_index*this->Get_Word_Size()) + ")");
  else if(pid.find("addr") != string::npos)
    return(this->Get_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*this->Get_Address_Width())-1) + " downto "
	   + IntToStr(down_index*this->Get_Address_Width()) + ")");
  else if(pid.find("tag") != string::npos)
    return(this->Get_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*this->Get_Tag_Length())-1) + " downto "
	   + IntToStr(down_index*this->Get_Tag_Length()) + ")");
  else
    assert(0); // fatal
}
