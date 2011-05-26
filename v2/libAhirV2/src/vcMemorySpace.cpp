#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcObject.hpp>
#include <vcModule.hpp>
#include <vcMemorySpace.hpp>
#include <vcSystem.hpp>

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
  return(this->Get_VHDL_Id() + "_" + pid);
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
    return(this->Get_VHDL_Id() + "_" + pid + "(" + IntToStr(down_index) + ")");
  else if(pid.find("data") != string::npos)
    return(this->Get_VHDL_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*this->Get_Word_Size())-1) + " downto "
	   + IntToStr(down_index*this->Get_Word_Size()) + ")");
  else if(pid.find("addr") != string::npos)
    return(this->Get_VHDL_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*this->Get_Address_Width())-1) + " downto "
	   + IntToStr(down_index*this->Get_Address_Width()) + ")");
  else if(pid.find("tag") != string::npos)
    return(this->Get_VHDL_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*this->Get_Tag_Length())-1) + " downto "
	   + IntToStr(down_index*this->Get_Tag_Length()) + ")");
  else
    assert(0); // fatal
}


bool vcMemorySpace::Get_Caller_Module_Section(vcModule* caller_module, string load_or_store, int& hindex, int& lindex)
{
  bool ret_val = false;
  hindex = ((load_or_store == "load") ? this->_num_loads-1 : this->_num_stores -1);
  for(map<vcModule*,vector<int> >::iterator iter = ((load_or_store == "load") ? _load_group_map.begin() : _store_group_map.begin());
      iter != ((load_or_store == "load") ? _load_group_map.end() : _store_group_map.end());
      iter++)
    {
      if(caller_module == (*iter).first)
	{
	  lindex = (hindex + 1) - (*iter).second.size();
	  ret_val = true;
	  break;
	}
      else
	{
	  hindex -= (*iter).second.size();
	}
    }
  return(ret_val);
}

string vcMemorySpace::Get_Aggregate_Section(string pid, int hindex, int lindex)
{
  int data_width;
  string ret_string = this->Get_VHDL_Id() + "_" + pid;

  // find data_width.
  if((pid.find("req") != string::npos) || (pid.find("ack") != string::npos))
    data_width = 1;
  else if(pid.find("addr") != string::npos)
    data_width = this->Get_Address_Width();
  else if(pid.find("data") != string::npos)
    data_width = this->Get_Word_Size();
  else if(pid.find("tag") != string::npos)
    data_width = this->Get_Tag_Length();
  else
    assert(0); // fatal

  ret_string += "(";
  ret_string += IntToStr(((hindex+1)*data_width)-1);
  ret_string += " downto ";
  ret_string += IntToStr(lindex*data_width);
  ret_string += ")";
  return(ret_string);
}


void vcMemorySpace::Print_VHDL_Instance(ostream& ofile)
{
  if(_num_loads == 0)
    {


      if(_num_stores > 0)
	{
	  vcSystem::Warning("memory space " + this->Get_VHDL_Id() + " is not read from... dummy used");
	  // dummy write-only memory..
	  // instantiate a register bank..
	  ofile << "dummyWOM_" << this->Get_VHDL_Id() << ": dummy_write_only_memory_subsystem -- {" << endl;
	  ofile << "generic map(-- {" << endl;
	  ofile << "num_stores => " << this->Get_Num_Stores() << "," << endl
		<< "addr_width => " << this->Get_Address_Width() << "," << endl
		<< "data_width => " << this->Get_Word_Size() << "," << endl
		<< "tag_width => " << this->Get_Tag_Length() << endl
		<< ") -- }" << endl;
	  ofile << "port map(-- {" << endl;
	  ofile << "sr_addr_in => " << this->Get_VHDL_Id() << "_sr_addr," << endl
	    << "sr_data_in => " << this->Get_VHDL_Id() << "_sr_data," << endl
	    << "sr_req_in => " << this->Get_VHDL_Id() << "_sr_req," << endl
	    << "sr_ack_out => " << this->Get_VHDL_Id() << "_sr_ack," << endl
	    << "sr_tag_in => " << this->Get_VHDL_Id() << "_sr_tag," << endl
	    << "sc_req_in=> " << this->Get_VHDL_Id() << "_sc_req," << endl
	    << "sc_ack_out => " << this->Get_VHDL_Id() << "_sc_ack," << endl
	    << "sc_tag_out => " << this->Get_VHDL_Id() << "_sc_tag," << endl
	    << "clock => clk," << endl
	    << "reset => reset";
	  ofile << "); -- }  }" << endl;
	}
      else
	vcSystem::Warning("memory space " + this->Get_VHDL_Id() + " is not used... omitted!");
    }
  
  if(_num_stores == 0)
    {

      if(_num_loads > 0)
	{
	  vcSystem::Warning("memory space " + this->Get_VHDL_Id() + " is not written into... dummy used");
	  // dummy read-only memory..
	  // instantiate a register bank..
	  ofile << "dummyROM_" << this->Get_VHDL_Id() << ": dummy_read_only_memory_subsystem -- {" << endl;
	  ofile << "generic map(-- {" << endl;
	  ofile << "num_loads => " << this->Get_Num_Loads() << "," << endl
		<< "addr_width => " << this->Get_Address_Width() << "," << endl
		<< "data_width => " << this->Get_Word_Size() << "," << endl
		<< "tag_width => " << this->Get_Tag_Length() << endl
		<< ") -- }" << endl;
	  ofile << "port map(-- {" << endl;
	  ofile << "lr_addr_in => " << this->Get_VHDL_Id() << "_lr_addr," << endl
		<< "lr_req_in => " << this->Get_VHDL_Id() << "_lr_req," << endl
		<< "lr_ack_out => " << this->Get_VHDL_Id() << "_lr_ack," << endl
		<< "lr_tag_in => " << this->Get_VHDL_Id() << "_lr_tag," << endl
		<< "lc_req_in => " << this->Get_VHDL_Id() << "_lc_req," << endl
		<< "lc_ack_out => " << this->Get_VHDL_Id() << "_lc_ack," << endl
		<< "lc_data_out => " << this->Get_VHDL_Id() << "_lc_data," << endl
		<< "lc_tag_out => " << this->Get_VHDL_Id() << "_lc_tag," << endl
		<< "clock => clk," << endl
		<< "reset => reset";
	  ofile << "); -- }  }" << endl;
	}
      else
	vcSystem::Warning("memory space " + this->Get_VHDL_Id() + " is not used... omitted!");
    }

  if(_num_loads > 0 && _num_stores > 0)
    {
      if(this->Get_Capacity() <= vcSystem::_register_bank_threshold)
	{
	  // instantiate a register bank..
	  ofile << "RegisterBank_" << this->Get_VHDL_Id() << ": register_bank -- {" << endl;
	  ofile << "generic map(-- {" << endl;
	  ofile << "num_loads => " << this->Get_Num_Loads() << "," << endl
		<< "num_stores => " << this->Get_Num_Stores() << "," << endl
		<< "addr_width => " << this->Get_Address_Width() << "," << endl
		<< "data_width => " << this->Get_Word_Size() << "," << endl
		<< "tag_width => " << this->Get_Tag_Length() << "," << endl
		<< "num_registers => " << this->Get_Capacity()
		<< ") -- }" << endl;
	  ofile << "port map(-- {" << endl;
	  ofile 
	    << "lr_addr_in => " << this->Get_VHDL_Id() << "_lr_addr," << endl
	    << "lr_req_in => " << this->Get_VHDL_Id() << "_lr_req," << endl
	    << "lr_ack_out => " << this->Get_VHDL_Id() << "_lr_ack," << endl
	    << "lr_tag_in => " << this->Get_VHDL_Id() << "_lr_tag," << endl
	    << "lc_req_in => " << this->Get_VHDL_Id() << "_lc_req," << endl
	    << "lc_ack_out => " << this->Get_VHDL_Id() << "_lc_ack," << endl
	    << "lc_data_out => " << this->Get_VHDL_Id() << "_lc_data," << endl
	    << "lc_tag_out => " << this->Get_VHDL_Id() << "_lc_tag," << endl
	    << "sr_addr_in => " << this->Get_VHDL_Id() << "_sr_addr," << endl
	    << "sr_data_in => " << this->Get_VHDL_Id() << "_sr_data," << endl
	    << "sr_req_in => " << this->Get_VHDL_Id() << "_sr_req," << endl
	    << "sr_ack_out => " << this->Get_VHDL_Id() << "_sr_ack," << endl
	    << "sr_tag_in => " << this->Get_VHDL_Id() << "_sr_tag," << endl
	    << "sc_req_in=> " << this->Get_VHDL_Id() << "_sc_req," << endl
	    << "sc_ack_out => " << this->Get_VHDL_Id() << "_sc_ack," << endl
	    << "sc_tag_out => " << this->Get_VHDL_Id() << "_sc_tag," << endl
	    << "clock => clk," << endl
	    << "reset => reset";
	  ofile << "); -- }  }" << endl;
	}
      else
	{
	  ofile << "MemorySpace_" << this->Get_VHDL_Id() << ": memory_subsystem -- {" << endl;
	  ofile << "generic map(-- {" << endl;
	  ofile << "num_loads => " << this->Get_Num_Loads() << "," << endl
		<< "num_stores => " << this->Get_Num_Stores() << "," << endl
		<< "addr_width => " << this->Get_Address_Width() << "," << endl
		<< "data_width => " << this->Get_Word_Size() << "," << endl
		<< "tag_width => " << this->Get_Tag_Length() << "," << endl
	    // the following parameters are hard-wired.. but 
	    // it may be a good idea to expose them!
		<< "number_of_banks => " << this->Calculate_Number_Of_Banks() << "," << endl
		<< "mux_degree => 2," << endl
		<< "demux_degree => 2," << endl
		<< "base_bank_addr_width => " << this->Calculate_Base_Bank_Address_Width() << "," << endl
		<< "base_bank_data_width => " << this->Calculate_Base_Bank_Data_Width() << endl 
		<< ") -- }" << endl;
	  ofile << "port map(-- {" << endl;
	  ofile 
	    << "lr_addr_in => " << this->Get_VHDL_Id() << "_lr_addr," << endl
	    << "lr_req_in => " << this->Get_VHDL_Id() << "_lr_req," << endl
	    << "lr_ack_out => " << this->Get_VHDL_Id() << "_lr_ack," << endl
	    << "lr_tag_in => " << this->Get_VHDL_Id() << "_lr_tag," << endl
	    << "lc_req_in => " << this->Get_VHDL_Id() << "_lc_req," << endl
	    << "lc_ack_out => " << this->Get_VHDL_Id() << "_lc_ack," << endl
	    << "lc_data_out => " << this->Get_VHDL_Id() << "_lc_data," << endl
	    << "lc_tag_out => " << this->Get_VHDL_Id() << "_lc_tag," << endl
	    << "sr_addr_in => " << this->Get_VHDL_Id() << "_sr_addr," << endl
	    << "sr_data_in => " << this->Get_VHDL_Id() << "_sr_data," << endl
	    << "sr_req_in => " << this->Get_VHDL_Id() << "_sr_req," << endl
	    << "sr_ack_out => " << this->Get_VHDL_Id() << "_sr_ack," << endl
	    << "sr_tag_in => " << this->Get_VHDL_Id() << "_sr_tag," << endl
	    << "sc_req_in=> " << this->Get_VHDL_Id() << "_sc_req," << endl
	    << "sc_ack_out => " << this->Get_VHDL_Id() << "_sc_ack," << endl
	    << "sc_tag_out => " << this->Get_VHDL_Id() << "_sc_tag," << endl
	    << "clock => clk," << endl
	    << "reset => reset";
	  ofile << "); -- }  }" << endl;
	}
    }
}


int vcMemorySpace::Calculate_Number_Of_Banks()
{
  // the number of banks must be a power of 2
  int max_reqs = MAX(this->Get_Num_Loads(),this->Get_Num_Stores());

  // keep the maximum number of banks to 4.
  int num_banks = 1;
  if(max_reqs >= 2)
    num_banks = 2;
  else if(max_reqs > 8)
    num_banks = 4;

  if(CeilLog2(num_banks-1) < this->Get_Address_Width())
    {
      return(num_banks);
    }
  else
    {
      return(1);
    }
}
int vcMemorySpace::Calculate_Base_Bank_Address_Width()
{
  // TODO: calculate this better...
  return(10);
}
int vcMemorySpace::Calculate_Base_Bank_Data_Width()
{
  // TODO: calculate this better...
  return(8);
}
