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

class AaMemorySpace: public AaRoot
{
 public:
 AaMemorySpace(int msi):AaRoot() 
    { 
      _mem_space_index = msi;
      _is_written_into = false;
      _is_read_from = false;
    }

  int _mem_space_index;
  int _total_size;
  int _word_size;
  int _address_width;
  int _max_access_width;

  bool _is_written_into;
  bool _is_read_from;


  set<AaStorageObject*,AaRootCompare> _objects;
  set<AaModule*> _modules;

  void Write_VC_Model(ostream& ofile);
  string Get_VC_Identifier();
};

// The program, a list of modules etc...
// all members are static since there is a single program
class AaProgram
{
  // all kinds of std::maps.
  static std::map<string,AaObject*,StringCompare> _objects;
  static std::map<string,AaModule*,StringCompare> _modules;
  static std::map<string,AaType*,StringCompare> _type_map;
  static std::map<int,set<AaRoot*> > _storage_eq_class_map;
  static std::map<int,set<AaModule*> > _storage_index_module_coverage_map;
  static std::map<int,AaMemorySpace*> _memory_space_map;
  static std::map<AaType*,AaForeignStorageObject*> _foreign_storage_map;

  // recoalesce set.
  static set<AaObject*> _recoalesce_set;

  // modules should be printed in the order in which
  // they were encountered.
  static vector<AaModule*> _ordered_module_vector;
  // the call graph
  static AaGraphBase _call_graph;

  // the type dependency graph
  // (an undirected graph: connected components of this
  // graph will correspond to unique types!)
  static AaUGraphBase _type_dependency_graph;

  // edge between u and v implies that
  // u and v must be in the same memory space!
  static AaUGraphBase _storage_dependency_graph;

  

 public:
  static int _pointer_width;
  static int _foreign_word_size;
  static int _foreign_address_width;
  static string _current_file_name;
  static bool _verbose_flag;

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
  static AaArrayType* Make_Array_Type(AaType* etype, vector<unsigned int>& dims);
  static AaPointerType* Make_Pointer_Type(AaType* ref_type);
  static AaRecordType* Make_Record_Type(vector<AaType*>& element_types);
  static AaRecordType* Make_Named_Record_Type(string rname);
  static AaRecordType* Find_Named_Record_Type(string rname);

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

  // propagate constant values...
  static void Propagate_Constants();

  static void Coalesce_Storage();
  static void Add_Storage_Dependency(AaRoot* u, AaRoot* v);
  static void Add_Storage_Dependency_Graph_Vertex(AaRoot* u);

  // write VC model
  static void Write_VC_Model(int default_space_pointer_width,
			     int default_space_word_size,
			     ostream& ofile);
  static void Write_VC_Model_Optimized(int default_space_pointer_width,
				       int default_space_word_size,
				       ostream& ofile);
  static void Write_VC_Pipe_Declarations(ostream& ofile);
  static void Write_VC_Constant_Declarations(ostream& ofile);
  static void Write_VC_Memory_Spaces(ostream& ofile);
  static void Write_VC_Modules(ostream& ofile);
  static void Write_VC_Modules_Optimized(ostream& ofile);

  static AaMemorySpace* Get_Memory_Space(int idx);

  static void Add_To_Recoalesce_Set(AaObject* obj);

  static AaForeignStorageObject* Make_Foreign_Storage_Object(AaType* t);
};


#endif
