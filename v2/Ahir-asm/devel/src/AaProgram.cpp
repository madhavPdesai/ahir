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
#include <AaParserClasses.h>
#include <AaProgram.h>

//---------------------------------------------------------------------
// AaProgram
//---------------------------------------------------------------------

// static members of AaProgram..


// the foreign memory space is assumed to have
// a word-size of 8 bits and an address width
// of 32 bits .. (nothing sacred about this,
// but this will be used in doing pointer arithmetic).
int AaProgram::_foreign_word_size = 8;
int AaProgram::_foreign_address_width = 32;

// all pointers in the program are assumed to
// be 32 bits wide (override if you wish..)
int AaProgram::_pointer_width = 32;
bool AaProgram::_keep_extmem_inside = false;
bool AaProgram::_verbose_flag = false;
bool AaProgram::_print_inlined_functions_in_caller = false;
bool AaProgram::_use_gnu_pth = false;
bool AaProgram::_do_not_print_orphans = false;

AaStorageObject* AaProgram::_extmem_object = NULL;
string AaProgram::_extmem_object_name;
int AaProgram::_extmem_size;

string AaProgram::_current_file_name;
string AaProgram::_tool_name;
AaVoidType* AaProgram::_void_type = NULL;
std::map<string,AaType*,StringCompare>   AaProgram::_type_map;
std::map<string,AaObject*,StringCompare> AaProgram::_objects;
std::map<string,AaModule*,StringCompare> AaProgram::_modules;
std::set<string> AaProgram::_volatile_modules;
std::map<int,set<AaRoot*> > AaProgram::_storage_eq_class_map;
std::vector<AaModule*> AaProgram::_ordered_module_vector;
std::map<int,set<AaModule*> > AaProgram::_storage_index_module_coverage_map;
std::map<int,AaMemorySpace*> AaProgram::_memory_space_map;
std::map<AaType*,AaForeignStorageObject*> AaProgram::_foreign_storage_map;
std::map<AaObject*,set<AaStorageObject*> > AaProgram::_recoalesce_map;
std::set<int> AaProgram::_extmem_access_widths;
std::set<AaType*> AaProgram::_extmem_access_types;
std::set<AaPointerDereferenceExpression*> AaProgram::_pointer_dereferences;
std::set<string> AaProgram::_root_module_names;
std::set<string> AaProgram::_top_level_daemons;
std::set<AaModule*> AaProgram::_reachable_modules;
std::set<string> AaProgram::_mutex_set;
std::map<string, int> AaProgram::_integer_parameter_map;
std::map<string, string> AaProgram::_gated_clock_map;

// use as a filler whenever you need.
AaRoot* AaProgram::_dummy_root = NULL;

//
// prefix to be attached to c/vhdl modules.
// 
string AaProgram::_c_vhdl_module_prefix="";

//
// Module name to be given to C model source.
//
string AaProgram::_c_module_name="";


// directory for aa2c outputs.
string AaProgram::_aa2c_output_directory = ".";

bool AaProgram::_optimize_flag = false;
bool AaProgram::_unordered_memory_flag = false;
bool AaProgram::_balance_loop_pipeline_bodies = false;
bool AaProgram::_combinationalize_statements = false;
bool AaProgram::_treat_all_modules_as_opaque = false;


AaGraphBase AaProgram::_call_graph;
AaUGraphBase AaProgram::_type_dependency_graph;
AaUGraphBase AaProgram::_storage_dependency_graph;

int AaProgram::_buffering_bits_added_during_path_balancing = 0;

string AaMemorySpace::Get_VC_Name()
{
	string ret_string = "memory_space_" + IntToStr(this->_mem_space_index);
	return(ret_string);
}

void AaMemorySpace::Write_VC_Model(bool opt_flag, ostream& ofile)
{
  if(this->_is_written_into || this->_is_read_from)
    {
      if(_objects.size() == 0)
	AaRoot::Error("memory space " + IntToStr(this->_mem_space_index) +
		      " has no storage objects in it!",NULL);
      
      ofile << "$memoryspace ";
      if(!this->Get_Is_Ordered())
	{
	  ofile << "$unordered " << endl;
	}

      ofile << "[memory_space_" << this->_mem_space_index << "] {"
	    << "$capacity " << this->_total_size << endl
	    << "$datawidth " << this->_word_size << endl
	    << "$addrwidth " << this->_address_width << endl;  
      ofile << "$maxaccesswidth " << this->_max_access_width << endl;  
      
      for(set<AaStorageObject*,AaRootCompare>::iterator iter = _objects.begin();
	  iter != _objects.end();
	  iter++)
	{
	  (*iter)->Write_VC_Model(ofile);
	}


      ofile << "}" << endl;
    }
  else
    {
      string obj_list;
      for(set<AaStorageObject*,AaRootCompare>::iterator iter = _objects.begin();
	  iter != _objects.end();
	  iter++)
	{
	  obj_list += " ";
	  obj_list += (*iter)->Get_Name();
	}

      AaRoot::Warning("the following objects are not accessed: " + obj_list,NULL);
    }
}

string AaMemorySpace::Get_VC_Identifier()
{
  if(!this->_is_global && this->_modules.size() == 1)
    return((*(this->_modules.begin()))->Get_Label() + "/memory_space_" + IntToStr(_mem_space_index));
  else
    return("memory_space_" + IntToStr(_mem_space_index));
}

AaProgram::AaProgram() {}
AaProgram::~AaProgram() {};


void AaProgram::Make_Extmem_Object()
{
  AaType* el_type = AaProgram::Make_Uinteger_Type(AaProgram::_foreign_word_size);

  vector<unsigned int> dims;
  dims.push_back(AaProgram::_extmem_size);

  AaType* obj_type = AaProgram::Make_Array_Type(el_type,dims);

  AaProgram::_extmem_object = new AaStorageObject(NULL,AaProgram::_extmem_object_name,obj_type,NULL);
  AaProgram::Add_Storage_Dependency_Graph_Vertex(AaProgram::_extmem_object);

  AaProgram::_extmem_object->Add_Access_Width(AaProgram::_foreign_word_size);

}

void AaProgram::Print_ExtMem_Access_Modules(ostream& ofile)
{
  if(AaProgram::_extmem_object != NULL)
    {
      AaProgram::_extmem_object->Print(ofile);
      ofile << endl;
    }

  if(!AaProgram::_keep_extmem_inside)
    {
      for(set<int>::iterator iter = _extmem_access_widths.begin(), fiter = _extmem_access_widths.end();
	  iter != fiter;
	  iter++)
	{
	  int width = (*iter);
	  int awidth = AaProgram::_foreign_address_width;
	  
	  ofile << "$pipe extmem_read_address_" << width << " : $uint<" << awidth << " >" << endl;
	  ofile << "$pipe extmem_read_data_" << width << " : $uint<" << width << " >" << endl;
	  ofile << "$pipe extmem_write_address_" << width << " : $uint<" << awidth << " >" << endl;
	  ofile << "$pipe extmem_write_data_" << width << " : $uint<" << width << " >" << endl;
	  
	  ofile << "$module [extmem_load_" << width << "] "
		<< " $in (addr: $uint<" << awidth << "> )" << endl
		<< " $out (data: $uint<" << width << "> )" << endl
		<< " $is {" << endl
		<< " extmem_read_address_" << width << " := addr" << endl
		<< " data := extmem_read_data_" << width << endl
		<< "}" << endl;
	  
	  ofile << "$module [extmem_store_" << width << "] "
		<< " $in (addr: $uint<" << awidth << "> "
		<< " data: $uint<" << width << "> )" << endl
		<< " $out () " << endl
		<< " $is {" << endl
		<< " extmem_write_address_" << width << " := addr" << endl
		<< " extmem_write_data_" << width << " := data" << endl
		<< "}" << endl;
	}


      for(set<AaType*>::iterator iter = _extmem_access_types.begin(), fiter = _extmem_access_types.end();
	  iter != fiter;
	  iter++)
	{
	  
	  int width = (*iter)->Size();
	  int index = (*iter)->Get_Index();
	  int awidth = AaProgram::_foreign_address_width;

	  ofile << "$module [extmem_load_for_type_" << index << "] "
		<< " $in (addr: $uint<" << awidth << "> )" << endl
		<< " $out (data: " << (*iter)->To_String() << " )" << endl
		<< " $is {" << endl
		<< " $call extmem_load_" << width << " ( addr ) "
		<< " ( t_data ) " << endl;
	  ofile << " data := ($bitcast ( " << (*iter)->To_String() << " ) t_data) " << endl;
	  ofile << "}" << endl;
	  
	  ofile << "$module [extmem_store_for_type_" << index << "] "
		<< " $in (addr: $uint<" << awidth << "> "
		<< " data: " << (*iter)->To_String() << " )" << endl
		<< " $out () " << endl
		<< " $is {" << endl
		<< " t_data := ($bitcast ($uint< "  << width << " > ) data  )" << endl;
	  ofile << " $call extmem_store_" << width 
		<< " (addr t_data) () " << endl;
	  ofile << "}" << endl;
	}
    }
  else
    {// add a module which provides a link for the outside
      // world to access the inside world..
      int width =  AaProgram::_foreign_word_size;
      int awidth = AaProgram::_foreign_address_width;
      
      int addr_scale_factor = width/AaProgram::_extmem_object->Get_Word_Size();
      int base_addr = AaProgram::_extmem_object->Get_Base_Address();
      ofile << "$module [mem_load__] " << endl;
      ofile << "$in (address : $uint<" << awidth << " > ) " << endl;
      ofile << "$out (data : $uint<" << width << " > ) " << endl;
      ofile << " $is {" << endl;
      ofile << " data := " << endl;
      ofile << AaProgram::_extmem_object_name << "[ " 
	    << "((address * " << addr_scale_factor
	    << " ) + " << base_addr << ") ]" << endl;
      ofile << "}" << endl;
      
      ofile << "$module [mem_store__] " << endl;
      ofile << "$in (address : $uint<" << awidth << " > " 
	    << "data : $uint<" << width << " > ) " << endl;
      ofile << " $out ()" << endl
	    << " $is {" << endl;
      ofile << AaProgram::_extmem_object_name << "[ " 
		<< "((address * " << addr_scale_factor
	    << " ) + " << base_addr << ") ] := "
	    << " data " 
	    << "}" << endl;
    }
}


void AaProgram::Print(ostream& ofile)
{
  for(std::set<string>::iterator muiter = AaProgram::_mutex_set.begin(), fmuiter = AaProgram::_mutex_set.end();
					muiter != fmuiter; muiter++)
  {
	ofile << "$mutex " << *muiter <<  endl;
  }


  // print named types
  for(std::map<string,AaType*>::iterator iter = AaProgram::_type_map.begin(),
	fiter = AaProgram::_type_map.end();
      iter != fiter;
      iter++)
    {
      AaType* t = (*iter).second;
      if(t->Is("AaRecordType"))
	((AaRecordType*)t)->Print_Declaration(ofile);
    }

  for(std::map<string,AaObject*,StringCompare>::iterator miter = AaProgram::_objects.begin();
      miter != AaProgram::_objects.end();
      miter++)
    {
      (*miter).second->Print(ofile);
      ofile << endl;
    }

  // print gated clocks
  for(std::map<string,string>::iterator giter = AaProgram::_gated_clock_map.begin();
      giter != AaProgram::_gated_clock_map.end();
      giter++)
  {
	ofile << "$gated_clock " << (*giter).first << " " << (*giter).second << endl;
  }

  for(int idx = 0, fidx = AaProgram::_ordered_module_vector.size(); idx < fidx; idx++)
  {
	  AaModule* m = ((AaModule*)(AaProgram::_ordered_module_vector[idx]));
	  if(!(AaProgram::_print_inlined_functions_in_caller) || 
			  (!m->Get_Inline_Flag() && !m->Get_Macro_Flag()))
		  m->Print(ofile);
	  else
	  {
		  AaRoot::Info("not printing inlined/macro module " + m->Get_Label());
	  }
  }

  for(std::map<int,set<AaRoot*> >::iterator iter = AaProgram::_storage_eq_class_map.begin();
		  iter != AaProgram::_storage_eq_class_map.end();
		  iter++)
  {
	  ofile << "// Memory space " << (*iter).first << ": ";
	  for(set<AaRoot*>::iterator siter = (*iter).second.begin();
			  siter != (*iter).second.end();
			  siter++)
	  {
		  if((*siter)->Is("AaStorageObject"))
			  ofile << ((AaStorageObject*)(*siter))->Get_Hierarchical_Name() << " ";
	  }
	  ofile << endl;
  }

  // print use_gated_clock statements..
  ofile << "// use of gated clocks in modules " << endl;
  for(int gidx = 0, fgidx = AaProgram::_ordered_module_vector.size(); gidx < fgidx; gidx++)
  {
	  AaModule* m = ((AaModule*)(AaProgram::_ordered_module_vector[gidx]));
	  if (m->Get_Use_Gated_Clock())
	  {
		ofile << "$use_gated_clock " << m->Get_Name() << " " << m->Get_Gated_Clock_Name() << endl;
	  } 
  }
}


void AaProgram::Print_Memory_Space_Info()
{
	for(std::map<int,set<AaRoot*> >::iterator iter = AaProgram::_storage_eq_class_map.begin();
			iter != AaProgram::_storage_eq_class_map.end();
			iter++)
	{
		cerr << "Info: Memory space " << (*iter).first << ": ";
		for(set<AaRoot*>::iterator siter = (*iter).second.begin();
				siter != (*iter).second.end();
				siter++)
		{
			if((*siter)->Is("AaStorageObject"))
				cerr << ((AaStorageObject*)(*siter))->Get_Hierarchical_Name() << " ";
		}
		cerr << endl;
	}
}

void AaProgram::Add_ExtMem_Access_Type(AaType* t)
{
	if(t == NULL)
		return;

	AaProgram::_extmem_access_types.insert(t);
	AaProgram::Add_ExtMem_Access_Width(t->Size());
}

void AaProgram::Add_Object(AaObject* obj) 
{ 
	if(AaProgram::Is_Integer_Parameter(obj->Get_Name()))
	{
		AaRoot::Error("Object " + obj->Get_Name() + " shadows parameter name. ", obj);
		return;
	}

	AaObject* prev_obj = AaProgram::Find_Object(obj->Get_Name());
	if(prev_obj != NULL)
	{
		if(prev_obj->Kind() == obj->Kind())
		{
			if(prev_obj->Get_Type() == obj->Get_Type())
			{
				if(prev_obj->Is("AaPipeObject"))
				{
					AaRoot::Info("re-declaration of pipe: " + obj->Get_Name() + ", parameters updated.");
					AaPipeObject* pp = (AaPipeObject*)prev_obj;
					AaPipeObject* po = (AaPipeObject*)obj;
					pp->Set_In_Mode(po->Get_In_Mode());
					pp->Set_Out_Mode(po->Get_Out_Mode());
					pp->Set_Signal(po->Get_Signal());
					pp->Set_Depth(po->Get_Depth());
					
				}
				else
				{
					AaRoot::Warning("redeclaration of " + obj->Get_Name() + " ignored",obj);
				}
			}
			else
				AaRoot::Error("redeclaration of " + obj->Get_Name() + " with conflicting type",obj);
		}
		else
		{
			AaRoot::Error("dissimilar declarations of " + obj->Get_Name(),obj);
		}
		return;
	}

	if(obj->Is("AaStorageObject"))
	{
		if(obj->Get_Name() == AaProgram::_extmem_object_name)
		{
			AaRoot::Info("external memory accesses will be assumed to point to internal object "
					+ obj->Get_Name());
			AaProgram::_extmem_object = (AaStorageObject*)obj;

		}
		AaProgram::Add_Storage_Dependency_Graph_Vertex(obj);
	}

	AaProgram::_objects[obj->Get_Name()] = obj;
}

AaObject* AaProgram::Find_Object(string obj_name)
{
	AaObject* ret_obj = NULL;
	std::map<string,AaObject*,StringCompare>::iterator miter = AaProgram::_objects.find(obj_name);
	if(miter != AaProgram::_objects.end())
		ret_obj = (*miter).second;
	return(ret_obj);
}


void AaProgram::Add_Module(AaModule* obj) 
{ 
  AaRoot::Info("Added module " + obj->Get_Label());

  if(AaProgram::Find_Module(obj->Get_Label()) == NULL)
    {
      AaProgram::_modules[obj->Get_Label()] = obj;
    }
  else
    {
      AaRoot::Warning("Duplicate module " + obj->Get_Label() + " ignored", obj);
    }
}

AaModule* AaProgram::Find_Module(string obj_name)
{
  AaModule* ret_obj = NULL;
  std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.find(obj_name);
  if(miter != AaProgram::_modules.end())
    ret_obj = (*miter).second;
  return(ret_obj);
}

void AaProgram::Add_Call_Pair(AaModule* caller, AaModule* callee)
{
  AaProgram::_call_graph.Add_Edge((AaRoot*)caller,(AaRoot*)callee);
  if(caller != NULL)
  	caller->Add_Called_Module(callee);
  if(callee != NULL)
  	callee->Add_Calling_Module(caller);
}


AaVoidType* AaProgram::Make_Void_Type()
{
	if(AaProgram::_void_type == NULL)
		AaProgram::_void_type = new AaVoidType(NULL);
	return(AaProgram::_void_type);
}

AaUintType* AaProgram::Make_Uinteger_Type(unsigned int w)
{
  AaUintType* ret_type = NULL;
  string tid = "uint<" + IntToStr(w) + ">";
  std::map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    ret_type = (AaUintType*) (*titer).second;
  else
    {
      ret_type = new AaUintType((AaScope*) NULL, w);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
}

AaIntType* AaProgram::Make_Integer_Type(unsigned int w)
{
  AaIntType* ret_type = NULL;
  string tid = "int<" + IntToStr(w) + ">";
  std::map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    ret_type = (AaIntType*) (*titer).second;
  else
    {
      ret_type = new AaIntType((AaScope*) NULL, w);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
}
AaFloatType* AaProgram::Make_Float_Type(unsigned int c, unsigned int m)
{
  AaFloatType* ret_type = NULL;
  string tid = "float<" + IntToStr(c) + "," + IntToStr(m) + ">";
  std::map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    ret_type = (AaFloatType*) (*titer).second;
  else
    {
      ret_type = new AaFloatType((AaScope*) NULL, c,m);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
}
AaArrayType* AaProgram::Make_Array_Type(AaType* etype, vector<unsigned int>& dims)
{
  AaArrayType* ret_type = NULL;
  string tid = "array";
  for(unsigned int i=0; i < dims.size(); i++)
    tid += "[" + IntToStr(dims[i]) + "]";
  tid += " of ";
  tid += Int64ToStr(etype->Get_Index());

  std::map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    ret_type = (AaArrayType*) (*titer).second;
  else
    {
      ret_type = new AaArrayType((AaScope*) NULL,etype,dims);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
}

AaPointerType* AaProgram::Make_Pointer_Type(AaType* ref_type)
{
  AaPointerType* ret_type = NULL;
  string tid = "pointer<" + Int64ToStr(ref_type->Get_Index()) + ">";
  std::map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    ret_type = (AaPointerType*) (*titer).second;
  else
    {
      ret_type = new AaPointerType((AaScope*) NULL, ref_type);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
}

AaRecordType* AaProgram::Make_Record_Type(vector<AaType*>& etypes)
{
  AaRecordType* ret_type = NULL;
  string tid = "record<";
  for(int idx = 0; idx < etypes.size(); idx++)
    {
      assert(etypes[idx]->Get_Index() >= 0);
      if(idx >= 0)
	tid += ",";
      tid += IntToStr(etypes[idx]->Get_Index());
    }
  tid += ">";

  std::map<string,AaType*>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    {
      assert((*titer).second->Is("AaRecordType"));
      ret_type = (AaRecordType*) (*titer).second;
    }
  else
    {
      ret_type = new AaRecordType((AaScope*) NULL, etypes);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
}

AaRecordType* AaProgram::Make_Named_Record_Type(string rname)
{
  AaRecordType* rt = NULL;
  if(AaProgram::_type_map.find(rname) == AaProgram::_type_map.end())
    {
      rt = new AaRecordType(NULL,rname);
      AaProgram::_type_map[rname] = rt;
    }
  else
    {
      AaType* t = AaProgram::_type_map[rname];
      assert(t->Is("AaRecordType"));
      rt = (AaRecordType*)t;
    }

  return(rt);
}

AaRecordType* AaProgram::Find_Named_Record_Type(string rname)
{
  AaRecordType* rt = AaProgram::Make_Named_Record_Type(rname);
  return(rt);
}

void AaProgram::Init_Call_Graph()
{
  string prog_name = "program";
  AaProgram::_call_graph.Add_Vertex((AaRoot*)NULL,prog_name);

  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    {
      string mod_name = (*miter).first;
      AaProgram::_call_graph.Add_Vertex((*miter).second, mod_name);
      AaProgram::Add_Call_Pair((AaModule*) NULL, (*miter).second);
    }
}
void AaProgram::Map_Targets()
{
  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    (*miter).second->Map_Targets();
}
void AaProgram::Map_Source_References()
{
  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    (*miter).second->Map_Source_References();
}
void AaProgram::Check_For_Cycles_In_Call_Graph()
{
  // Assume that map source references has been called before...
  if(AaProgram::_call_graph.Cycle_Detect_Dfs())
    {
      AaRoot::Error("cycle(s) in module call graph are not permitted",NULL);
    }

  vector<AaRoot*> prec_order;
  AaProgram::_call_graph.Topological_Sort(prec_order);
  std::cerr << "Info: module order:" << endl;
  for(int idx = 0; idx < prec_order.size(); idx++)
    {
      AaModule* m = ((AaModule*)(prec_order[idx]));
      if( m != NULL)
	{
	  std::cerr << "\t" << m->Get_Label() << endl;
	  AaProgram::_ordered_module_vector.push_back(m);
	}
    }
}

void AaProgram::Add_Type_Dependency(AaRoot* u, AaRoot* v)
{
  AaProgram::_type_dependency_graph.Add_Edge(u,v);
}
bool AaProgram::Propagate_Types()
{
  map<int,set<AaRoot*> > type_eq_class_map;
  int num_comps = AaProgram::_type_dependency_graph.Connected_Components(type_eq_class_map);
  bool err_flag = false;
  assert(num_comps == type_eq_class_map.size());
  int unknown_type_count, last_unknown_type_count;

  unknown_type_count = 0;

  // initially all are in the unknown set
  set<int> unknown_type_set;
  for(int i = 0; i < type_eq_class_map.size(); i++)
    unknown_type_set.insert(i);

  vector<int> erase_vector;


  // keep iterating as long as there is an unknown
  // type
  while(unknown_type_set.size() > 0)
    { 
      // keep trying until you cover all equivalence classes or until
      // you reach a fixed point..
      set<int>::iterator siter;
      bool found_at_least_one = false;

      for(siter = unknown_type_set.begin(); siter != unknown_type_set.end(); siter++)
	{
	  int i = *siter;

	  AaType* itype = NULL;
	  
	  // two passes: first find the type and then set it
	  for(set<AaRoot*>::iterator ssiter = type_eq_class_map[i].begin();
	      ssiter != type_eq_class_map[i].end();
	      ssiter++)
	    {
	      AaRoot* item = *ssiter;
	      AaType* ntype = NULL;
	      if(item->Is_Expression())
		{
		  ntype = ((AaExpression*)item)->Get_Type();
		}
	      else if(item->Is_Object())
		{
		  ntype = ((AaObject*)item)->Get_Type();
		}
	      else 
		{
		  
		  AaRoot::Error("in type propagation, encountered an object which was not an expression or object",item);
		  item->Print(cerr);
		  cerr << endl;
		  err_flag = true;
		}
	      
	      if(ntype != NULL && itype != NULL && (itype != ntype))
		{
		  AaRoot::Error("in type propagation, found ambiguity in types",item);
		  item->Print(cerr);
		  cerr << endl;
		  
		  err_flag = true;
		}
	      else if(ntype != NULL && itype == NULL)
		itype = ntype;
	    }

	  if(itype != NULL)
	    {
	      found_at_least_one = true;

	      // set the type of all expressions in this equivalence class to itype
	      for(set<AaRoot*>::iterator siter = type_eq_class_map[i].begin();
		  siter != type_eq_class_map[i].end();
		  siter++)
		{
		  AaRoot* item = *siter;
		  if(item->Is_Expression())
		    {
		      if(((AaExpression*)item)->Get_Type() == NULL)
			((AaExpression*)item)->Set_Type(itype);
		    }
		}

	      // type of map entry at i has been discovered
	      // erase it from the set.
	      // unknown_type_set.erase(i);
	      erase_vector.push_back(i);
	    }
	} // iterated over all unknown equivalence classes 

      if(!found_at_least_one)
	{// did not find even one map whose type could be determined!
	  string err_msg =  "in type propagation, could not determine types of the following expressions/objects ";
	  AaRoot::Error(err_msg, NULL);
	  for(set<int>::iterator uiter = unknown_type_set.begin(); uiter != unknown_type_set.end(); uiter++)
	    {
	      int i = *uiter;

	      for(set<AaRoot*>::iterator siter = type_eq_class_map[i].begin();
		  siter != type_eq_class_map[i].end();
		  siter++)
		{
		  (*siter)->Print(cerr);
		  cerr << "\t line " << (*siter)->Get_Line_Number() << endl;
		}
	 	    }
	  err_flag = true;
	  break; // stop trying, you have reached a fixed point.
	}
      // if found at least one, continue..
      int Ei;
	for(Ei = 0; Ei < erase_vector.size(); Ei++)
	{
		unknown_type_set.erase(erase_vector[Ei]);
	}
	erase_vector.clear();
    }
  return(err_flag);
}

void AaProgram::Add_Storage_Dependency(AaRoot* u, AaRoot* v)
{
  AaProgram::_storage_dependency_graph.Add_Edge(u,v);
}

void AaProgram::Add_Storage_Dependency_Graph_Vertex(AaRoot* u)
{
  AaProgram::_storage_dependency_graph.Add_Vertex(u);
}

AaForeignStorageObject* AaProgram::Make_Foreign_Storage_Object(AaType* t)
{
  AaForeignStorageObject* ret_obj = NULL;
  if(AaProgram::_foreign_storage_map.find(t) == AaProgram::_foreign_storage_map.end())
    {
      ret_obj = new AaForeignStorageObject(t, AaProgram::_foreign_word_size, AaProgram::_foreign_address_width);
      AaProgram::_foreign_storage_map[t] = ret_obj;
    }
  else
    ret_obj = AaProgram::_foreign_storage_map[t];

  return(ret_obj);
}

// try to identify sets of objects which must reside in the
// same memory space.
//
// the algorithm uses a DFS starting from the storage
// objects and propagating through dependencies (expressions)
// each expression or object has a representative pointer.
// And as the DFS proceeds, edges are introduced between
// storage objects.  Connected components in the storage
// dependency graph correspond to memory spaces.
void AaProgram::Coalesce_Storage()
{

  AaRoot::Info("Marking foreign pointers in modules which are not called from the program");
  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    {
      AaModule* m =(*miter).second;
      if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end()) 
      	m->Set_Foreign_Object_Representatives();
    }


  AaRoot::Info("Coalescing storage from native objects..");
  // basically a DFS starting from the storage objects (at each level in the program)
  for(map<string,AaObject*,StringCompare>::iterator obj_iter = _objects.begin();
      obj_iter != _objects.end();
      obj_iter++)
    {
      if(((*obj_iter).second)->Is("AaStorageObject"))
	((*obj_iter).second)->Coalesce_Storage();
    }
  

  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    {
    
      AaModule* m =(*miter).second;
      if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end()) 
      	(*miter).second->Coalesce_Storage();
    }
  
  // recoalesce..
  while(AaProgram::_recoalesce_map.size() > 0)
    {
      AaObject* top_obj = (*(AaProgram::_recoalesce_map.begin())).first;
      set<AaStorageObject*> addr_obj_set = (*(AaProgram::_recoalesce_map.begin())).second;
      AaProgram::_recoalesce_map.erase(top_obj);

      if(AaProgram::_verbose_flag)
      {
	      for(set<AaStorageObject*>::iterator siter = addr_obj_set.begin(), fsiter = addr_obj_set.end();
			      siter != fsiter;
			      siter++)
	      {

		      AaRoot::Info("Recoalescing from " + top_obj->Get_Name() + 
						" with addressable-object " + (*siter)->Get_Name());
	      }
      }
      top_obj->Coalesce_Storage();
    }

  // all "unknown" memory access will be assumed to point to
  // _extmem_object if this object is not null..
  if(AaProgram::_extmem_object != NULL)
  {
	  for(set<AaPointerDereferenceExpression*>::iterator piter = AaProgram::_pointer_dereferences.begin(),
			  fpiter = AaProgram::_pointer_dereferences.end();
			  piter != fpiter;
			  piter++)
	  {
		  AaPointerDereferenceExpression* pu = (*piter);

		  if(pu->Get_Addressed_Object_Representative() == NULL)
		  {
			  pu->Set_Addressed_Object_Representative(AaProgram::_extmem_object);
			  AaRoot::Warning("pointer dereference linked to extmem-pool :", pu);
			  AaProgram::Add_Storage_Dependency(pu,AaProgram::_extmem_object);
		  }
	  }
  }
  else
  {

	  for(set<AaPointerDereferenceExpression*>::iterator piter = AaProgram::_pointer_dereferences.begin(),
			  fpiter = AaProgram::_pointer_dereferences.end();
			  piter != fpiter;
			  piter++)
	  {
		  AaPointerDereferenceExpression* pu = (*piter);

		  AaObject* obj = pu->Get_Addressed_Object_Representative();

		  if(obj == NULL || obj->Is_Foreign_Storage_Object())
		  {
			  AaProgram::Add_ExtMem_Access_Type(pu->Get_Type());
		  }
	  }
  }

  int num_comps = AaProgram::_storage_dependency_graph.Connected_Components(AaProgram::_storage_eq_class_map);
  AaRoot::Info("Finished coalescing storage.. identified " + IntToStr(num_comps) + " disjoint memory space(s)");
  AaProgram::Print_Memory_Space_Info();

  for(int idx = 0; idx < AaProgram::_storage_eq_class_map.size(); idx++)
  {
	  set<int> lau_set;
	  int total_size = 0;

	  AaMemorySpace* new_ms = new AaMemorySpace(idx);
	  new_ms->Set_Is_Ordered(!AaProgram::_unordered_memory_flag);

	  AaProgram::_memory_space_map[idx] = new_ms;
	  bool soltero = (AaProgram::_storage_eq_class_map[idx].size() == 1);

	  for(set<AaRoot*>::iterator iter = AaProgram::_storage_eq_class_map[idx].begin();
			  iter !=  AaProgram::_storage_eq_class_map[idx].end();
			  iter++)
	  {

		  AaRoot* u = (*iter);
		  if(u->Is("AaStorageObject"))
		  {

			  new_ms->_objects.insert((AaStorageObject*)u);

			  if(((AaStorageObject*)u)->Get_Is_Written_Into())
			  {
				  new_ms->_is_written_into = true;
			  }
			  if(((AaStorageObject*)u)->Get_Is_Read_From())
			  {
				  new_ms->_is_read_from = true;
			  }

			  ((AaStorageObject*)u)->Set_Mem_Space_Index(idx);
			
			  vector<AaModule*> wmodules;
			  ((AaStorageObject*)u)->Get_Writer_Modules(wmodules);
			  for (int I = 0, fI = wmodules.size(); I < fI; I++)
			  {
				wmodules[I]->Add_Written_Memory_Space(new_ms);
			  }

			  vector<AaModule*> rmodules;
			  ((AaStorageObject*)u)->Get_Reader_Modules(rmodules);
			  for (int I = 0, fI = rmodules.size(); I < fI; I++)
			  {
				rmodules[I]->Add_Read_Memory_Space(new_ms);
			  }

			  for(set<int>::iterator witer = ((AaStorageObject*)u)->Get_Access_Widths().begin(),
					  fwiter = ((AaStorageObject*)u)->Get_Access_Widths().end();
					  witer != fwiter;
					  witer++)
			  {
				  lau_set.insert(*witer);
			  }

			  // overly conservative..
			  // ((AaStorageObject*)u)->Get_Type()->Fill_LAU_Set(lau_set);

			  total_size += ((AaStorageObject*)u)->Get_Type()->Size();

			  AaScope* p_scope = ((AaStorageObject*)u)->Get_Scope();
			  if(p_scope != NULL)
			  {
				  AaScope* root_p_scope = p_scope->Get_Root_Scope();

				  assert(root_p_scope->Is("AaModule"));
				  new_ms->_modules.insert((AaModule*)root_p_scope);

				  AaProgram::_storage_index_module_coverage_map[idx].insert((AaModule*) root_p_scope);

			  }
			  else
				  new_ms->Set_Is_Global(true);

		  }
		  else if(u->Is("AaPointerDereferenceExpression"))
		  {


			  AaPointerDereferenceExpression* pu = ((AaPointerDereferenceExpression*)u);

			  if(pu->Get_Is_Target())
				  new_ms->_is_written_into = true;
			  else
				  new_ms->_is_read_from = true;

			  AaType* ptype = pu->Get_Reference_To_Object()->Get_Type();
			  assert(ptype != NULL && ptype->Is_Pointer_Type());

			  int acc_width = ((AaPointerType*)ptype)->Get_Ref_Type()->Size();
			  lau_set.insert(acc_width);

			  if(pu->Get_Addressed_Object_Representative() == NULL)
			  {
				  if(!AaProgram::_keep_extmem_inside)
					  AaProgram::Add_ExtMem_Access_Width(acc_width);
				  else
				  {
					  AaRoot::Error("pointer dereference expression is not associated with any memory space",pu);
					  pu->Set_Is_Malformed(true);
				  }
			  }

			  AaScope* p_scope = pu->Get_Scope();
			  if(p_scope != NULL)
			  {
				  AaScope* root_p_scope = p_scope->Get_Root_Scope();

				  assert(root_p_scope->Is("AaModule"));
				  new_ms->_modules.insert((AaModule*)root_p_scope);

				  if(pu->Get_Is_Target())
					((AaModule*)root_p_scope)->Add_Written_Memory_Space(new_ms);
				  else
					  ((AaModule*)root_p_scope)->Add_Read_Memory_Space(new_ms);


				  AaProgram::_storage_index_module_coverage_map[idx].insert((AaModule*) root_p_scope);

			  }
			  else
				  new_ms->Set_Is_Global(true);

		  }
		  else if(u->Is("AaForeignStorageObject"))
		  {
			  AaRoot::Warning("foreign storage object ignored in memory space identification",NULL);
		  }
		  else
			  assert(0);
	  }

	  if(!new_ms->_is_written_into)
	  {
		  AaRoot::Warning("memory space " + new_ms->Get_VC_Identifier() 
				  + " is not written into in the program", NULL);
	  }
	  if(!new_ms->_is_read_from)
	  {
		  AaRoot::Warning("memory space " +
				  new_ms->Get_VC_Identifier() +
				  " is not read from in the program", NULL);
	  }

	  if(lau_set.size() == 0)
	  {
		  AaRoot::Warning("memory space " + new_ms->Get_VC_Identifier() + " is not accessed ", NULL);

		  new_ms->_total_size = total_size;
		  new_ms->_word_size = 1;
		  new_ms->_address_width = nAddressBits(total_size); 
		  new_ms->_max_access_width = 1;
	  }	    
	  else
	  {
		  // find the gcd
		  int word_size = GCD(lau_set);
		  int max_access_width = *(lau_set.rbegin());
		  int addr_width = nAddressBits(total_size/word_size); // address all-one will not be used..

		  new_ms->_total_size = (total_size/word_size);
		  new_ms->_word_size = word_size;
		  new_ms->_address_width = addr_width;
		  new_ms->_max_access_width = max_access_width;
	  }

	  // assign the base addresses and the word-size to the
	  // objects..
	  int base_address = 0; 
	  for(set<AaStorageObject*,AaRootCompare>::iterator iter = 
			  new_ms->_objects.begin();
			  iter !=  new_ms->_objects.end();
			  iter++)
	  {
		  AaStorageObject* u = (*iter);

		  ((AaStorageObject*)u)->Set_Base_Address(base_address);
		  ((AaStorageObject*)u)->Set_Word_Size(new_ms->_word_size);
		  ((AaStorageObject*)u)->Set_Address_Width(new_ms->_address_width);

		  base_address += (((AaStorageObject*)u)->Get_Type()->Size())/
			  new_ms->_word_size;
	  }
  }

  // finally, assign memory-spaces to modules
  // a memory space that is only used within a 
  // module is localized to that module..
  for(map<int,AaMemorySpace*>::iterator miter = AaProgram::_memory_space_map.begin();
		  miter != AaProgram::_memory_space_map.end();
		  miter++)
  {
	  AaMemorySpace* ms = (*miter).second;
	  if(!ms->Get_Is_Global() && (ms->_modules.size() == 1 ))
	  {
		  (*(ms->_modules.begin()))->Add_Memory_Space(ms);
	  }
	  else
	  {
		  for(set<AaModule*>::iterator mmiter = ms->_modules.begin();
				  mmiter != ms->_modules.end();
				  mmiter++)
		  {
			  (*mmiter)->Add_Shared_Memory_Space(ms);
		  }
	  }
  }
}


void AaProgram::Elaborate()
{
	AaRoot::Info("elaborating the program .... initializing the call-graph");
	AaProgram::Init_Call_Graph();
	AaRoot::Info("mapping target object references..");
	AaProgram::Map_Targets();
	AaRoot::Info("mapping source object references..");
	AaProgram::Map_Source_References();
	AaRoot::Info("checking for cycles in the call-graph ... ");
	AaProgram::Check_For_Cycles_In_Call_Graph();
	AaRoot::Info("marking modules reachable from root-modules ... ");
	AaProgram::Mark_Reachable_Modules(AaProgram::_reachable_modules);
	AaRoot::Info("propagating types in the program ... ");
	AaProgram::Propagate_Types();
	AaRoot::Info("coalescing storage into distinct memory spaces ... ");
	AaProgram::Coalesce_Storage();
	AaRoot::Info("propagating constants in the program ... ");
	AaProgram::Propagate_Constants();
}

void AaProgram::Equalize_Paths_Of_Pipelined_Modules()
{
	AaProgram::_dummy_root = new AaRoot();
	for(int idx = 0, fidx = AaProgram::_ordered_module_vector.size(); idx < fidx; idx++)
	{
		AaModule* m = ((AaModule*)(AaProgram::_ordered_module_vector[idx]));
		if(m->Is_Pipelined())
		{
			if(!m->Get_Has_Been_Equalized() && !m->Get_Noopt_Flag())
			{
				AaRoot::Info (" started path balancing for module " + m->Get_Label());
				m->Equalize_Paths_For_Pipelining();
				m->Set_Has_Been_Equalized(true);
			}
		}
		else  if(m->Get_Operator_Flag())
		{
			m->Calculate_And_Update_Longest_Path();
		}
	}
}

void AaProgram::Mark_Volatizable_Modules_As_Volatile()
{
	for(int idx = 0, fidx = AaProgram::_ordered_module_vector.size(); idx < fidx; idx++)
	{
		AaModule* m = ((AaModule*)(AaProgram::_ordered_module_vector[idx]));
		if(m->Is_Volatizable())
		{
			AaRoot::Info (" volatizing module " + m->Get_Label());
			m->Set_Volatile_Flag(true);
		}
	}
}

void AaProgram::Write_C_Model()
{
	string sys_prefix = AaProgram::_c_vhdl_module_prefix;
	string prefix_file_name = AaProgram::_aa2c_output_directory  + "/PREFIX";
	ofstream prefix_file;
	prefix_file.open(prefix_file_name.c_str());
	prefix_file << sys_prefix << endl;
	prefix_file.close();

	ofstream header_file;
	string header = sys_prefix + "aa_c_model.h";
	string header_file_name = AaProgram::_aa2c_output_directory + "/" + header;
	header_file.open(header_file_name.c_str());

	ofstream internal_header_file;
	string internal_header = sys_prefix + "aa_c_model_internal.h";
	string internal_header_file_name = AaProgram::_aa2c_output_directory + "/" + internal_header;
	internal_header_file.open(internal_header_file_name.c_str());

	ofstream source_file;
	string source = sys_prefix + "aa_c_model.c";
	string source_file_name = AaProgram::_aa2c_output_directory + "/" + source;
	source_file.open(source_file_name.c_str());


	header_file << "#include <stdlib.h>" << endl;
	header_file << "#include <unistd.h>" << endl; // for usleep.
	header_file << "#include <assert.h>" << endl;
	header_file << "#include <stdio.h>" << endl;
	header_file << "#include <BitVectors.h>" << endl;
	header_file << "#include <pipeHandler.h>" << endl;

	internal_header_file << "#include <stdlib.h>" << endl;
	internal_header_file << "#include <unistd.h>" << endl; // for usleep.
	internal_header_file << "#include <assert.h>" << endl;
	internal_header_file << "#include <stdio.h>" << endl;
	internal_header_file << "#include <BitVectors.h>" << endl;
	internal_header_file << "#include <pipeHandler.h>" << endl;

	if(AaProgram::_use_gnu_pth) 
	{
		source_file << "#include <pth.h>" << endl;
		source_file << "#include <GnuPthUtils.h>" << endl;
	}
	else
	{
		source_file << "#include <pthread.h>" << endl;
		source_file << "#include <pthreadUtils.h>" << endl;
	}
	source_file << "#include <Pipes.h>" << endl;
	source_file << "#include <" << internal_header << ">" << endl;
	source_file << "#include <" << header << ">" << endl;

	source_file << "FILE* " << AaProgram::Report_Log_File_Name() << " = NULL;" << endl;
	source_file << "int " << AaProgram::Trace_On_Flag_Name() << " = 0;" << endl;
	header_file << "void " << AaProgram::_c_vhdl_module_prefix << "_set_trace_file(FILE* fp);" << endl;
	source_file << "void " << AaProgram::_c_vhdl_module_prefix << "_set_trace_file(FILE* fp) {" << endl;
	source_file << AaProgram::Report_Log_File_Name() << " = fp;" << endl;
	source_file << "}" << endl;

	// declare mutexes
	for(std::set<string>::iterator muiter = AaProgram::_mutex_set.begin(), fmuiter = AaProgram::_mutex_set.end();
			muiter != fmuiter; muiter++)
	{
		source_file << "MUTEX_DECL(" << *muiter << ");" << endl;
	}

	for(std::map<string,AaType*,StringCompare>::iterator miter = AaProgram::_type_map.begin();
			miter != AaProgram::_type_map.end();
			miter++)
	{
		AaType* t = (*miter).second;
		if(t->Is("AaRecordType"))
		{
			((AaRecordType*)t)->PrintC_Declaration(header_file);
		}
	}

	internal_header_file << "// object initialization " << endl;
	for(std::map<string,AaObject*,StringCompare>::iterator miter = AaProgram::_objects.begin();
			miter != AaProgram::_objects.end();
			miter++)
	{
		//
		// These are global in the source file.
		//
		if(((*miter).second->Is_Storage_Object()) || ((*miter).second->Is_Pipe_Object()) || ((*miter).second->Is_Constant()))
			((AaStorageObject*) (*miter).second)->PrintC_Global_Declaration(source_file);
	}
	header_file << "void " << AaProgram::_c_vhdl_module_prefix << "__init_aa_globals__(); " << endl;
	source_file << "void " << AaProgram::_c_vhdl_module_prefix << "__init_aa_globals__() " << endl; 
	source_file << "{" << endl;
	for(std::map<string,AaObject*,StringCompare>::iterator miter = AaProgram::_objects.begin();
			miter != AaProgram::_objects.end();
			miter++)
	{
		//
		// These are global in the source file.
		//
		if(((*miter).second->Is_Storage_Object()) || ((*miter).second->Is_Pipe_Object()) || ((*miter).second->Is_Constant()))
			((AaStorageObject*) (*miter).second)->PrintC_Global_Initialization(source_file);
	}
	source_file << "}" << endl;


	// top-level daemons.
	vector<AaModule*> top_daemons;
	for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
			miter != AaProgram::_modules.end();
			miter++)
	{
		AaModule* m = (*miter).second;
		if(!m->Get_Foreign_Flag() && (AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end()))
		{
			(*miter).second->Write_C_Header(header_file);
			(*miter).second->Write_C_Source(source_file, internal_header_file);

			string mname = m->Get_Label();
			if(AaProgram::_top_level_daemons.find(mname) != AaProgram::_top_level_daemons.end())
				top_daemons.push_back(m);

		}
	}

	for(int I = 0, fI = top_daemons.size(); I < fI; I++)
	{
		AaModule* m = top_daemons[I];
		source_file << "DEFINE_THREAD(" << m->Get_C_Outer_Wrap_Function_Name() << ");" << endl;
		source_file << "PTHREAD_DECL(" << m->Get_C_Outer_Wrap_Function_Name() << ");" << endl;
	}

	header_file << "void " << AaProgram::_c_vhdl_module_prefix << "start_daemons(FILE* fp, int trace_on);" << endl;
	source_file << "void " << AaProgram::_c_vhdl_module_prefix << "start_daemons(FILE* fp, int trace_on) {" << endl;
	source_file << AaProgram::Report_Log_File_Name() << " = fp;" << endl;
	source_file << AaProgram::Trace_On_Flag_Name() << " = trace_on;" << endl;
	source_file << AaProgram::_c_vhdl_module_prefix << "__init_aa_globals__(); " << endl;
	for(int I = 0, fI = top_daemons.size(); I < fI; I++)
	{
		AaModule* m = top_daemons[I];

		//TODO: register pipes declared inside module..
		source_file << "PTHREAD_CREATE(" << m->Get_C_Outer_Wrap_Function_Name() << ");" << endl;
	}
	source_file << "}" << endl;

	header_file << "void " << AaProgram::_c_vhdl_module_prefix << "stop_daemons();" << endl;
	source_file << "void " << AaProgram::_c_vhdl_module_prefix << "stop_daemons() {" << endl;
	for(int I = 0, fI = top_daemons.size(); I < fI; I++)
	{
		AaModule* m = top_daemons[I];
		source_file << "PTHREAD_CANCEL(" << m->Get_C_Outer_Wrap_Function_Name() << ");" << endl;
	}

	//for(int I = 0, fI = top_daemons.size(); I < fI; I++)
	//{
	//AaModule* m = top_daemons[I];
	//header_file << "DECLARE_THREAD(" << m->Get_C_Outer_Wrap_Function_Name() << ");" << endl;
	//}
	source_file << "}" << endl;

	source_file.close();
	header_file.close();
	internal_header_file.close();
}


void AaProgram::Write_VHDL_C_Stubs()
{

	ofstream header_file;
	string header = "vhdlCStubs.h";
	header_file.open(header.c_str());

	ofstream source_file;
	string source = "vhdlCStubs.c";
	source_file.open(source.c_str());

	header_file << "#include <stdlib.h>" << endl
		<< "#include <stdint.h>" << endl
		<< "#include <stdio.h>" << endl
		<< "#include <string.h>" << endl
		<< "#include <Pipes.h>" << endl
		<< "#include <SocketLib.h>" << endl;

	source_file << "#include <" << header << ">" << endl;

	for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
			miter != AaProgram::_modules.end();
			miter++)
	{
		AaModule* m = (*miter).second;
		if(!m->Get_Foreign_Flag())
		{
			if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end())
			{
				(*miter).second->Write_VHDL_C_Stub_Header(header_file);
				(*miter).second->Write_VHDL_C_Stub_Source(source_file);
			}
		}
	}

	header_file.close();
	source_file.close();
}


void AaProgram::Write_VC_Gated_Clocks(ostream& ofile)
{
	AaRoot::Info("Writing gated clocks.. ");
	ofile << "// Declared gated clocks." << endl;
	for(map<string,string>::iterator giter = AaProgram::_gated_clock_map.begin();
				giter != AaProgram::_gated_clock_map.end();
				giter++)
	{
		ofile << "$gated_clock " << (*giter).first << " " << (*giter).second << endl;
	}
	
}

void AaProgram::Write_VC_Model(int default_space_pointer_width,
		int default_space_word_size,
		ostream& ofile)
{

	AaRoot::Info("Writing VC model.. ");
	AaProgram::Write_VC_Pipe_Declarations(ofile);
	AaProgram::Write_VC_Constant_Declarations(ofile);
	AaProgram::Write_VC_Gated_Clocks(ofile);

	AaProgram::Write_VC_Memory_Spaces(ofile);
	AaProgram::Write_VC_Modules(ofile);
	AaRoot::Info("Done writing VC model.. ");
}

void AaProgram::Write_VC_Model_Optimized(int default_space_pointer_width,
		int default_space_word_size,
		ostream& ofile)
{

	AaRoot::Info("Writing optimized VC model.. ");
	AaProgram::Write_VC_Pipe_Declarations(ofile);
	AaProgram::Write_VC_Constant_Declarations(ofile);
	AaProgram::Write_VC_Gated_Clocks(ofile);

	AaProgram::Write_VC_Memory_Spaces_Optimized(ofile);
	AaProgram::Write_VC_Modules_Optimized(ofile);
	AaRoot::Info("Done writing optimized VC model.. ");
}

AaMemorySpace* AaProgram::Get_Memory_Space(int idx)
{
	if(AaProgram::_memory_space_map.find(idx) != AaProgram::_memory_space_map.end())
		return(AaProgram::_memory_space_map[idx]);
	else
		return(NULL);
}

void AaProgram::Add_To_Recoalesce_Map(AaObject* obj, AaStorageObject* addr_obj)
{
	AaProgram::_recoalesce_map[obj].insert(addr_obj);
}

void AaProgram::Write_VC_Constant_Declarations(ostream& ofile)
{
	for(map<string,AaObject*,StringCompare>::iterator iter = AaProgram::_objects.begin();
			iter != AaProgram::_objects.end();
			iter++)
	{
		if((*iter).second->Is("AaConstantObject"))
		{
			((AaConstantObject*)((*iter).second))->Write_VC_Model(ofile);
		}
		else if(((*iter).second)->Is("AaStorageObject"))
		{
			((AaStorageObject*)((*iter).second))->Write_VC_Load_Store_Constants(ofile);
		}
	}
}

void AaProgram::Write_VC_Pipe_Declarations(ostream& ofile)
{

	// Pipes in VC are declared at the system level.
	//
	// declare pipes at top-level and recursively
	// enter all modules/blocks and print pipes declared
	// in their scope..
	for(map<string,AaObject*,StringCompare>::iterator iter = AaProgram::_objects.begin();
			iter != AaProgram::_objects.end();
			iter++)
	{
		if((*iter).second->Is("AaPipeObject"))
		{
			((AaPipeObject*)((*iter).second))->Write_VC_Model(ofile);
		}
	}
}


void AaProgram::Write_VC_Memory_Spaces(ostream& ofile)
{
	for(map<int,AaMemorySpace*>::iterator iter = AaProgram::_memory_space_map.begin();
			iter != AaProgram::_memory_space_map.end();
			iter++)
	{

		if((*iter).second->Get_Is_Global() || ((*iter).second->_modules.size() != 1))
			(*iter).second->Write_VC_Model(ofile);
	}
}

void AaProgram::Write_VC_Memory_Spaces_Optimized(ostream& ofile)
{
	for(map<int,AaMemorySpace*>::iterator iter = AaProgram::_memory_space_map.begin();
			iter != AaProgram::_memory_space_map.end();
			iter++)
	{

		if((*iter).second->Get_Is_Global() || ((*iter).second->_modules.size() != 1))
			(*iter).second->Write_VC_Model_Optimized(ofile);
	}
}


void AaProgram::Write_VC_Modules(ostream& ofile)
{
	for(int idx =0; idx < AaProgram::_ordered_module_vector.size(); idx++)
	{
		AaModule* m = AaProgram::_ordered_module_vector[idx];
		if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end())
		{
			AaProgram::_ordered_module_vector[idx]->Write_VC_Model(ofile);
		}
	}
}



void AaProgram::Write_VC_Modules_Optimized(ostream& ofile)
{
	for(int idx =0; idx < AaProgram::_ordered_module_vector.size(); idx++)
	{
		AaModule* m = AaProgram::_ordered_module_vector[idx];
		if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end())
		{
			AaProgram::_ordered_module_vector[idx]->Write_VC_Model_Optimized(ofile);
		}
	}
}




// propagate constant values...
void AaProgram::Propagate_Constants()
{
	for(map<string,AaObject*,StringCompare>::iterator iter = AaProgram::_objects.begin();
			iter != AaProgram::_objects.end();
			iter++)
	{
		if((*iter).second->Is("AaConstantObject"))
		{
			((AaConstantObject*)((*iter).second))->Evaluate();
		}
	}

	for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
			miter != AaProgram::_modules.end();
			miter++)
	{
		AaModule* m = (*miter).second;
		if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end())
			(*miter).second->Propagate_Constants();
	}
}


void AaProgram::Print_Global_Storage_Initializer(ostream& ofile)
{
	vector<AaModule*> init_modules;

	for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
			miter != AaProgram::_modules.end();
			miter++)
	{
		AaModule* m = (*miter).second;
		//if(AaProgram::_reachable_modules.find(m) != AaProgram::_reachable_modules.end())
		//{
		if(m->Has_Attribute("initializer"))
			init_modules.push_back(m);
		//}
	}

	ofile << "$module [global_storage_initializer_] $in () $out () $is {" << endl;
	if(init_modules.size() > 0)
	{
		ofile << "$parallelblock [pb] { " << std::endl;      
		for(unsigned int idx = 0; idx < init_modules.size(); idx++)
		{
			ofile << "$call " << init_modules[idx]->Get_Label() << " () () " << endl;
		}
		ofile << "}" << endl;
	}
	else
	{
		ofile << "$null" << endl;
	}
	ofile << "}" << endl;
}

void AaProgram::Print_Record_Type_Helpers(ostream& ofile)
{
	for(std::map<string,AaType*,StringCompare>::iterator miter = AaProgram::_type_map.begin();
			miter != AaProgram::_type_map.end();
			miter++)
	{
		AaType* t  = (*miter).second;
		if(t->Is_Record_Type())
		{
			AaRecordType* rt = (AaRecordType*) t;
			if(rt->Get_Is_Named())
			{
				rt->Print_Group_Function (ofile);
				rt->Print_Ungroup_Function (ofile);
			}
		}
	}
}


void AaProgram::Mark_As_Root_Module(string& mod_name)
{
	AaProgram::_root_module_names.insert(mod_name);
}


void AaProgram::Mark_Reachable_Modules(set<AaModule*>& reachable_modules)
{

	for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
			miter != AaProgram::_modules.end();
			miter++)
	{
		if((AaProgram::_root_module_names.size() == 0) ||  (AaProgram::_root_module_names.find((*miter).first) != AaProgram::_root_module_names.end()))
		{
			(*miter).second->Mark_Reachable_Modules(reachable_modules);
		}
	}
}


void AaProgram::Add_Integer_Parameter(string pid, int pval)
{
	if(AaProgram::_integer_parameter_map.find(pid) != AaProgram::_integer_parameter_map.end())
	{
		AaRoot::Error("redefinition of integer parameter " + pid, NULL);
	}
	else
	{
		AaProgram::_integer_parameter_map[pid] = pval;
	}
}

int AaProgram::Get_Integer_Parameter_Value(string pid)
{
	map<string,int>::iterator iter = AaProgram::_integer_parameter_map.find(pid);
	if(iter == AaProgram::_integer_parameter_map.end())
	{
		AaRoot::Error("did not find integer parameter " + pid, NULL);
		return(-1);
	}
	else
	{
		return((*iter).second);
	}
}

bool AaProgram::Is_Integer_Parameter(string pid)
{
	bool ret_val = false;
	map<string,int>::iterator iter = AaProgram::_integer_parameter_map.find(pid);
	if(iter != AaProgram::_integer_parameter_map.end())
	{
		ret_val = true;
	}
	return(ret_val);
}

bool AaProgram::Is_Marked_As_Volatile_Module(string mname)
{
	return(AaProgram::_volatile_modules.find(mname) != AaProgram::_volatile_modules.end());
}

void AaProgram::Mark_As_Volatile_Module(string mname)
{
	AaProgram::_volatile_modules.insert(mname);
}

