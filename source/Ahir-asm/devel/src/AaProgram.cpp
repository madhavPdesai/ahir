#include <AaParserClasses.h>
#include <AaProgram.h>

//---------------------------------------------------------------------
// AaProgram
//---------------------------------------------------------------------

// static members of AaProgram..
int AaProgram::_pointer_width = 32;
string AaProgram::_current_file_name;
std::map<string,AaType*,StringCompare>   AaProgram::_type_map;
std::map<string,AaObject*,StringCompare> AaProgram::_objects;
std::map<string,AaModule*,StringCompare> AaProgram::_modules;
std::map<int,set<AaRoot*> > AaProgram::_storage_eq_class_map;
std::vector<AaModule*> AaProgram::_ordered_module_vector;
std::map<int,set<AaModule*> > AaProgram::_storage_index_module_coverage_map;
AaGraphBase AaProgram::_call_graph;
AaUGraphBase AaProgram::_type_dependency_graph;
AaUGraphBase AaProgram::_storage_dependency_graph;

AaProgram::AaProgram() {}
AaProgram::~AaProgram() {};


void AaProgram::Print(ostream& ofile)
{
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
	  ofile << ((AaStorageObject*)(*siter))->Get_Hierarchical_Name() << " ";
	}
      ofile << endl;
    }
}

void AaProgram::Add_Object(AaObject* obj) 
{ 
  assert(AaProgram::Find_Object(obj->Get_Name()) == NULL); 
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
  AaProgram::_ordered_module_vector.push_back(obj);

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
AaArrayType* AaProgram::Make_Array_Type(AaScalarType* etype, vector<unsigned int>& dims)
{
  AaArrayType* ret_type = NULL;
  string tid = "array";
  for(unsigned int i=0; i < dims.size(); i++)
    tid += "<" + IntToStr(dims[i]) + ">";
  tid += " of ";
  etype->Print(tid);
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
  string tid = "pointer<" + ref_type->CName() + ">";
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

void AaProgram::Add_Storage_Dependency(AaStorageObject* u, AaStorageObject* v)
{
  AaProgram::_storage_dependency_graph.Add_Edge(u,v);
}

void AaProgram::Add_Storage_Dependency_Graph_Vertex(AaStorageObject* u)
{
  AaProgram::_storage_dependency_graph.Add_Vertex(u);
}

void AaProgram::Coalesce_Storage()
{
  // basically a DFS starting from the storage objects (at each level in the program)
  for(map<string,AaObject*,StringCompare>::iterator obj_iter = _objects.begin();
      obj_iter != _objects.end();
      obj_iter++)
    {
      (*obj_iter).second->Coalesce_Storage();
    }


  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    {
      (*miter).second->Coalesce_Storage();
    }


  int num_comps = AaProgram::_storage_dependency_graph.Connected_Components(AaProgram::_storage_eq_class_map);
  for(int idx = 0; idx < AaProgram::_storage_eq_class_map.size(); idx++)
    {
      for(set<AaRoot*>::iterator iter = AaProgram::_storage_eq_class_map[idx].begin();
	  iter !=  AaProgram::_storage_eq_class_map[idx].end();
	  iter++)
	{
	  AaRoot* u = (*iter);
	  assert(u->Is("AaStorageObject"));

	  ((AaStorageObject*)u)->Set_Mem_Space_Index(idx);

	  AaScope* p_scope = ((AaStorageObject*)u)->Get_Scope();
	  if(p_scope != NULL)
	    {
	      AaScope* root_p_scope = p_scope->Get_Root_Scope();
	      assert(root_p_scope->Is("AaModule"));
	      AaProgram::_storage_index_module_coverage_map[idx].insert((AaModule*) root_p_scope);
	    }
	}
    }
}


void AaProgram::Elaborate()
{
  AaProgram::Init_Call_Graph();
  AaProgram::Map_Source_References();
  AaProgram::Check_For_Cycles_In_Call_Graph();
  AaProgram::Propagate_Types();
  AaProgram::Coalesce_Storage();
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
  source_file << "#include <" << header << ">" << endl;
  

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



void AaProgram::Write_VC_Model(int default_space_pointer_width,
				 int default_space_word_size,
				 ostream& ofile)
{
  AaProgram::Write_VC_Pipe_Declarations(ofile);
  AaProgram::Write_VC_Constant_Declarations(ofile);

  AaProgram::Write_VC_Memory_Spaces(default_space_pointer_width,
				    default_space_word_size,
				    ofile);

  AaProgram::Write_VC_Modules(default_space_pointer_width,
				default_space_word_size,
				ofile);
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


void AaProgram::Write_VC_Memory_Spaces(int default_space_pointer_width,
				       int default_space_word_size,
				       ostream& ofile)
{
  for(map<string,AaObject*,StringCompare>::iterator iter = AaProgram::_objects.begin();
      iter != AaProgram::_objects.end();
      iter++)
    {
      if((*iter).second->Is("AaStorageObject"))
	{
	  ((AaStorageObject*)((*iter).second))->Write_VC_Model(ofile);
	}
    }
}


void AaProgram::Write_VC_Modules(int default_space_pointer_width,
			     int default_space_word_size,
			     ostream& ofile)
{
  for(int idx =0; idx < AaProgram::_ordered_module_vector.size(); idx++)
    {
      AaProgram::_ordered_module_vector[idx]->Write_VC_Model(default_space_pointer_width,
							     default_space_word_size,
							     ofile);
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
