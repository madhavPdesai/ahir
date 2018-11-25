//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
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
  this->_ordered_flag = true;
  this->_number_of_banks = 1;
}

void vcMemorySpace::Add_Attribute(string tag, string value)
{
  if(tag == "number_of_banks")
    {
	if(value != "")
	{
		string unquoted_value = value.substr(1,value.size()-2);
		unsigned int nb = atoi(unquoted_value.c_str());
		if(nb > 1)
		{
		   vcSystem::Info("in memory space " + this->Get_Id() + ", used attribute number of banks = " 
					+ IntToStr(nb));
		   this->_number_of_banks = nb;
		}
	}
    }
  this->vcRoot::Add_Attribute(tag,value);
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
  ofile << vcLexerKeywords[__MEMORYSPACE];

  if(!this->Get_Ordered_Flag())
	ofile << " " << vcLexerKeywords[__UNORDERED] << " ";

  ofile  << " [" << this->Get_Id() << "] {" << endl;
  
  ofile << vcLexerKeywords[__CAPACITY] << " " << this->_capacity << " ";
  ofile << vcLexerKeywords[__DATAWIDTH] << " " << this->_word_size << " ";
  ofile << vcLexerKeywords[__ADDRWIDTH] << " " << this->_address_width << " ";
  ofile << vcLexerKeywords[__MAXACCESSWIDTH] << " " << this->_max_access_width << " ";

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
  int time_stamp_width = this->Calculate_Time_Stamp_Width();
  int addr_width = this->_address_width;
  int data_width = this->_word_size;

  vcModule* scope = this->Get_Scope();

  if(num_load_reqs > 0)
    {
      if(scope != NULL && scope->Get_Volatile_Flag())
	{
		vcSystem::Error("volatile module " + scope->Get_Label() + " reads from memory space " + this->Get_VHDL_Id());
	}
 
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_req") 
	    << " :  std_logic_vector(" << num_load_reqs-1  << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_ack") 
	    << " : std_logic_vector(" << num_load_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_addr") 
	    << " : std_logic_vector(" << (num_load_reqs*addr_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("lr_tag") 
	    << " : std_logic_vector(" << (num_load_reqs* (tag_length+time_stamp_width))-1  << " downto 0);" << endl;
      
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

      if(scope != NULL && scope->Get_Volatile_Flag())
	{
		vcSystem::Error("volatile module " + scope->Get_Label() + " writes to memory space " + this->Get_VHDL_Id());
	}

      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_req") 
	    << " :  std_logic_vector(" << num_store_reqs-1  << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_ack") 
	    << " : std_logic_vector(" << num_store_reqs-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_addr") 
	    << " : std_logic_vector(" << (num_store_reqs*addr_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_data") 
	    << " : std_logic_vector(" << (num_store_reqs*data_width)-1 << " downto 0);" << endl;
      ofile << "signal " << this->Get_VHDL_Memory_Interface_Port_Name("sr_tag") 
	    << " : std_logic_vector(" << (num_store_reqs*(tag_length+time_stamp_width))-1  << " downto 0);" << endl;
      
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
  else if((pid.find("sr_tag") != string::npos) || (pid.find("lr_tag") != string::npos))
    return(this->Get_VHDL_Id() + "_" + pid + "(" 
	   + IntToStr(((down_index+1)*(this->Get_Tag_Length()+this->Calculate_Time_Stamp_Width()))-1) + " downto "
	   + IntToStr(down_index*(this->Get_Tag_Length()+this->Calculate_Time_Stamp_Width())) + ")");
  else if((pid.find("sc_tag") != string::npos) || (pid.find("lc_tag") != string::npos))
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
  else if((pid.find("sr_tag") != string::npos) || (pid.find("lr_tag") != string::npos))
    data_width = this->Get_Tag_Length()+this->Calculate_Time_Stamp_Width();
  else if((pid.find("sc_tag") != string::npos) || (pid.find("lc_tag") != string::npos))
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
	  ofile << "name => \"" << this->Get_VHDL_Id() << "\"," << endl;
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
	  ofile << "name => \"" << this->Get_VHDL_Id() << "\"," << endl;
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
	  ofile << "name => \"" << this->Get_VHDL_Id() << "\"," << endl;
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
	  string mem_entity = (_ordered_flag ? "ordered_memory_subsystem" : "UnorderedMemorySubsystem");
	  ofile << "MemorySpace_" << this->Get_VHDL_Id() << ": " << mem_entity << " -- {" << endl;
	  ofile << "generic map(-- {" << endl;
	  ofile << "name => \"" << this->Get_VHDL_Id() << "\"," << endl;
	  ofile << "num_loads => " << this->Get_Num_Loads() << "," << endl
		<< "num_stores => " << this->Get_Num_Stores() << "," << endl
		<< "addr_width => " << this->Get_Address_Width() << "," << endl
		<< "data_width => " << this->Get_Word_Size() << "," << endl
		<< "tag_width => " << this->Get_Tag_Length() << "," << endl;
	  if(_ordered_flag)
	    {
	    // the following parameters are hard-wired.. but 
	    // it may be a good idea to expose them!
	      ofile << "time_stamp_width => " << this->Calculate_Time_Stamp_Width() << "," << endl;
	      ofile << "number_of_banks => " << this->Calculate_Number_Of_Banks() << "," << endl;
	    }
	  ofile << "mux_degree => 2," << endl
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


// this is a very important function.
//   the number of banks should be determined by
//   the available parallelism in the sytem.  Since
//   we dont know it for now, we will keep the
//   number to be 1 (conservative, but ok).
//
// top research priority: figure out a good metric
// to measure the parallelism.
int vcMemorySpace::Calculate_Number_Of_Banks()
{
  return(this->_number_of_banks);
}

int vcMemorySpace::Calculate_Base_Bank_Address_Width()
{
  int num_banks = this->Calculate_Number_Of_Banks();
  return(this->Get_Address_Width() - Log(num_banks,2));
}

int vcMemorySpace::Calculate_Base_Bank_Data_Width()
{
  return(this->Get_Word_Size());
}


int vcMemorySpace::Calculate_Time_Stamp_Width()
{

  if(_ordered_flag && (_num_loads > 0) && (_num_stores > 0))
  {
    return(Log(_num_stores + _num_loads,2) + 8);
  }
  else
    return(0);
}
