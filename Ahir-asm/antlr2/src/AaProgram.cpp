#include <AaParserClasses.h>
#include <AaBglWrap.h>
#include <AaProgram.h>

//---------------------------------------------------------------------
// AaProgram
//---------------------------------------------------------------------

// static members of AaProgram..
std::map<string,AaType*,StringCompare>   AaProgram::_type_map;
std::map<string,AaObject*,StringCompare> AaProgram::_objects;
std::map<string,AaModule*,StringCompare> AaProgram::_modules;

AaGraphBase AaProgram::_call_graph;

AaProgram::AaProgram() {}
AaProgram::~AaProgram() {};


void AaProgram::Print(ostream& ofile)
{
  if(AaProgram::_objects.size() > 0)
    ofile << "$declare " << std::endl;

  for(std::map<string,AaObject*,StringCompare>::iterator miter = AaProgram::_objects.begin();
      miter != AaProgram::_objects.end();
      miter++)
    (*miter).second->Print(ofile);

  for(std::map<string,AaModule*,StringCompare>::iterator miter = AaProgram::_modules.begin();
      miter != AaProgram::_modules.end();
      miter++)
    (*miter).second->Print(ofile);
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
  string caller_label = caller->Get_Label();
  string callee_label = callee->Get_Label();
  AaProgram::_call_graph.Add_Vertex((AaRoot*)caller,caller_label);
  AaProgram::_call_graph.Add_Vertex((AaRoot*)callee,callee_label);
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

AaPointerType* AaProgram::Make_Pointer_Type(unsigned int w)
{
  AaPointerType* ret_type = NULL;
  string tid = "pointer<" + IntToStr(w) + ">";
  std::map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
  if(titer != AaProgram::_type_map.end())
    ret_type = (AaPointerType*) (*titer).second;
  else
    {
      ret_type = new AaPointerType((AaScope*) NULL, w);
      AaProgram::_type_map[tid] = ret_type;
    }
  return(ret_type);
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
  if(!AaProgram::_call_graph.Cycle_Detect_Dfs())
    std::cerr << "Error: cycle(s) in module call graph are not permitted" << std::endl;
}
