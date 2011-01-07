#ifndef _Aa_Program__
#define _Aa_Program__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>
#include <AaBglWrap.h>

// ******************************************* PROGRAM ************************************
// The program, a list of modules etc...
// all members are static since there is a single program
class AaProgram
{


  // all kinds of std::maps.
  static std::map<string,AaObject*,StringCompare> _objects;
  static std::map<string,AaModule*,StringCompare> _modules;
  static std::map<string,AaType*,StringCompare> _type_map;

  // the call graph
  static AaGraphBase _call_graph;

  // the type dependency graph
  // (an undirected graph: connected components of this
  // graph will correspond to unique types!)
  static AaUGraphBase _type_dependency_graph;

 public:

  static string _current_file_name;

  AaProgram();
  ~AaProgram();

  static void Print(ostream& ofile);

  static void Add_Object(AaObject* obj);
  static void Add_Module(AaModule* obj);

  static AaObject* Find_Object(string obj_name);
  static AaModule* Find_Module(string obj_name);

  static void Add_Call_Pair(AaModule* caller, AaModule* callee);

  static AaUintType* Make_Uinteger_Type(unsigned int w);

  static AaIntType* Make_Integer_Type(unsigned int w);
  static AaFloatType* Make_Float_Type(unsigned int c, unsigned int m);
  static AaArrayType* Make_Array_Type(AaScalarType* etype, vector<unsigned int>& dims);
  static AaPointerType* Make_Pointer_Type(unsigned int w);

  static void Map_Source_References();

  // Check for cycles
  static void Check_For_Cycles_In_Call_Graph();
  static void Init_Call_Graph();

  // add type dependency
  static void Add_Type_Dependency(AaRoot* u, AaRoot* v);
  static bool Propagate_Types();
  static void Print_Type_Dependency_Graph(ostream& ofile)
  {
    AaProgram::_type_dependency_graph.Print(ofile);
  }

  // check that there are no cycles 
  // connections, infer types, etc. etc.
  static void Elaborate();

  // write a C model.
  static void Write_C_Model();
  static string Get_Top_Struct_Variable_Name() 
  { 
    string r = "__top";
    return (r);
  }

  // write an AHIR model
  static void Write_Ahir_Model();

};


#endif
