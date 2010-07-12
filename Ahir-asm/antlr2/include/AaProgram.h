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

  // expression dependency graph (for resolving types)
  
 public:

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
};


#endif
