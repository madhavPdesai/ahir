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
AaStorageObject* AaProgram::_extmem_object = NULL;
string AaProgram::_extmem_object_name;
int AaProgram::_extmem_size;

string AaProgram::_current_file_name;
AaVoidType* AaProgram::_void_type = NULL;
std::map<string,AaType*,StringCompare>   AaProgram::_type_map;
std::map<string,AaObject*,StringCompare> AaProgram::_objects;
std::map<string,AaModule*,StringCompare> AaProgram::_modules;
std::map<int,set<AaRoot*> > AaProgram::_storage_eq_class_map;
std::vector<AaModule*> AaProgram::_ordered_module_vector;
std::map<int,set<AaModule*> > AaProgram::_storage_index_module_coverage_map;
std::map<int,AaMemorySpace*> AaProgram::_memory_space_map;
std::map<AaType*,AaForeignStorageObject*> AaProgram::_foreign_storage_map;
std::set<AaObject*> AaProgram::_recoalesce_set;
std::set<int> AaProgram::_extmem_access_widths;
std::set<AaType*> AaProgram::_extmem_access_types;
std::set<AaPointerDereferenceExpression*> AaProgram::_pointer_dereferences;



AaGraphBase AaProgram::_call_graph;
AaUGraphBase AaProgram::_type_dependency_graph;
AaUGraphBase AaProgram::_storage_dependency_graph;


void AaMemorySpace::Write_VC_Model(ostream& ofile)
{
  if(_objects.size() == 0)
    AaRoot::Error("memory space " + IntToStr(this->_mem_space_index) +
		  " has no storage objects in it!",NULL);

  ofile << "$memoryspace [memory_space_" << this->_mem_space_index << "] {"
	<< "$capacity " << this->_total_size << endl
	<< "$datawidth " << this->_word_size << endl
	<< "$addrwidth " << this->_address_width << endl;  

  for(set<AaStorageObject*,AaRootCompare>::iterator iter = _objects.begin();
      iter != _objects.end();
      iter++)
    {
      (*iter)->Write_VC_Model(ofile);
    }

  ofile << "}" << endl;
}

string AaMemorySpace::Get_VC_Identifier()
{
  if(this->_modules.size() == 1)
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

  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    (*miter).second->Print(ofile);

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
  assert(AaProgram::Find_Object(obj->Get_Name()) == NULL); 
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
  assert(AaProgram::Find_Module(obj->Get_Label()) == NULL); 
  AaProgram::_modules[obj->Get_Label()] = obj;


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
	  for(set<AaRoot*>::iterator siter = type_eq_class_map[i].begin();
	      siter != type_eq_class_map[i].end();
	      siter++)
	    {
	      AaRoot* item = *siter;
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
	      unknown_type_set.erase(i);
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
      (*miter).second->Coalesce_Storage();
    }
  
  while(AaProgram::_recoalesce_set.size() > 0)
    {
      AaObject* top_obj = *(AaProgram::_recoalesce_set.begin());
      AaProgram::_recoalesce_set.erase(top_obj);
      AaRoot::Info("Recoalescing from " + top_obj->Get_Name());
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

  for(int idx = 0; idx < AaProgram::_storage_eq_class_map.size(); idx++)
    {
      set<int> lau_set;
      int total_size = 0;

      AaMemorySpace* new_ms = new AaMemorySpace(idx);
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
	      ((AaStorageObject*)u)->Get_Type()->Fill_LAU_Set(lau_set);
	      
	      total_size += ((AaStorageObject*)u)->Get_Type()->Size();

	      AaScope* p_scope = ((AaStorageObject*)u)->Get_Scope();
	      if(p_scope != NULL)
		{
		  AaScope* root_p_scope = p_scope->Get_Root_Scope();
		  assert(root_p_scope->Is("AaModule"));
		  AaProgram::_storage_index_module_coverage_map[idx].insert((AaModule*) root_p_scope);
		  new_ms->_modules.insert((AaModule*)root_p_scope);
		}
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
			AaRoot::Error("pointer dereference expression is no associated with any memory space",pu);
		    }
		}

	      AaScope* p_scope = pu->Get_Scope();
	      if(p_scope != NULL)
		{
		  AaScope* root_p_scope = p_scope->Get_Root_Scope();
		  assert(root_p_scope->Is("AaModule"));
		  AaProgram::_storage_index_module_coverage_map[idx].insert((AaModule*) root_p_scope);
		  new_ms->_modules.insert((AaModule*)root_p_scope);
		}
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
	AaRoot::Warning("memory space " + new_ms->Get_VC_Identifier() + " has no objects", NULL);
	continue;
      }	    

      // find the gcd
      int word_size = GCD(lau_set);
      int max_access_width = *(lau_set.rbegin());
      int base_address = 0;
      int addr_width = CeilLog2((total_size/word_size)-1);

      new_ms->_total_size = (total_size/word_size);
      new_ms->_word_size = word_size;
      new_ms->_address_width = addr_width;
      new_ms->_max_access_width = max_access_width;

      // assign the base addresses and the word-size to the
      // objects..
      for(set<AaStorageObject*,AaRootCompare>::iterator iter = 
	    new_ms->_objects.begin();
	  iter !=  new_ms->_objects.end();
	  iter++)
	{
	  AaStorageObject* u = (*iter);

	  ((AaStorageObject*)u)->Set_Base_Address(base_address);
	  ((AaStorageObject*)u)->Set_Word_Size(word_size);
	  ((AaStorageObject*)u)->Set_Address_Width(addr_width);

	  base_address += (((AaStorageObject*)u)->Get_Type()->Size())/word_size;
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
      if(ms->_modules.size() == 1)
	{
	  (*(ms->_modules.begin()))->Add_Memory_Space(ms);
	}
    }
}


void AaProgram::Elaborate()
{
  AaRoot::Info("elaborating the program .... initializing the call-graph");
  AaProgram::Init_Call_Graph();
  AaRoot::Info("mapping object references..");
  AaProgram::Map_Source_References();
  AaRoot::Info("checking for cycles in the call-graph ... ");
  AaProgram::Check_For_Cycles_In_Call_Graph();
  AaRoot::Info("propagating types in the program ... ");
  AaProgram::Propagate_Types();
  AaRoot::Info("coalescing storage into distinct memory spaces ... ");
  AaProgram::Coalesce_Storage();
  AaRoot::Info("propagating constants in the program ... ");
  AaProgram::Propagate_Constants();
}

void AaProgram::Write_C_Model()
{

  ofstream header_file;
  string header = "aa_c_model.h";
  header_file.open(header.c_str());
  
  ofstream source_file;
  string source = "aa_c_model.c";
  source_file.open(source.c_str());


  header_file << "#include <Aa2C.h>" << endl;
  // declare all the record types that you have encountered.

  source_file << "#include <" << header << ">" << endl;
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
  

  for(std::map<string,AaObject*,StringCompare>::iterator miter = AaProgram::_objects.begin();
      miter != AaProgram::_objects.end();
      miter++)
    {
      // these are global in the source file
      (*miter).second->PrintC(source_file,"");
    }

  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    {
      (*miter).second->Write_Header(header_file);
      (*miter).second->Write_Source(source_file);
    }
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
	      << "#include <SocketLib.h>" << endl;

  // declare all the record types that you have encountered.
  source_file << "#include <" << header << ">" << endl;

  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    {
      (*miter).second->Write_VHDL_C_Stub_Header(header_file);
      (*miter).second->Write_VHDL_C_Stub_Source(source_file);
    }

  header_file.close();
  source_file.close();
}



void AaProgram::Write_VC_Model(int default_space_pointer_width,
			       int default_space_word_size,
			       ostream& ofile)
{

  AaRoot::Info("Writing VC model.. ");
  AaProgram::Write_VC_Pipe_Declarations(ofile);
  AaProgram::Write_VC_Constant_Declarations(ofile);

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

  AaProgram::Write_VC_Memory_Spaces(ofile);
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

void AaProgram::Add_To_Recoalesce_Set(AaObject* obj)
{
  AaProgram::_recoalesce_set.insert(obj);
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

  for(map<string,AaModule*,StringCompare>::iterator iter = AaProgram::_modules.begin();
      iter != AaProgram::_modules.end();
      iter++)
    {
      ((*iter).second)->Write_VC_Pipe_Declarations(ofile);
    }
}


void AaProgram::Write_VC_Memory_Spaces(ostream& ofile)
{
  for(map<int,AaMemorySpace*>::iterator iter = AaProgram::_memory_space_map.begin();
      iter != AaProgram::_memory_space_map.end();
      iter++)
    {

      if((*iter).second->_modules.size() != 1)
	(*iter).second->Write_VC_Model(ofile);
    }
}


void AaProgram::Write_VC_Modules(ostream& ofile)
{
  for(int idx =0; idx < AaProgram::_ordered_module_vector.size(); idx++)
    {
      AaProgram::_ordered_module_vector[idx]->Write_VC_Model(ofile);
    }
}



void AaProgram::Write_VC_Modules_Optimized(ostream& ofile)
{
  for(int idx =0; idx < AaProgram::_ordered_module_vector.size(); idx++)
    {
      AaProgram::_ordered_module_vector[idx]->Write_VC_Model_Optimized(ofile);
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
      (*miter).second->Propagate_Constants();
    }

}
