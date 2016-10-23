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
      _is_global = false;
      _total_size = 0;
      _word_size = 0;
      _address_width = 0;
      _max_access_width = 0;
      _max_read_write_width = 0;
      _is_ordered = true;
    }

  int _mem_space_index;
  int _total_size;
  int _word_size;
  int _address_width;
  int _max_access_width;
  int _max_read_write_width;

  bool _is_written_into;
  bool _is_read_from;
  bool _is_global;
  bool _is_ordered;

  set<AaStorageObject*,AaRootCompare> _objects;
  set<AaModule*> _modules;

  void Write_VC_Model(ostream& ofile) {this->Write_VC_Model(false,ofile);}
  void Write_VC_Model_Optimized(ostream& ofile) {this->Write_VC_Model(true,ofile);}

  void Write_VC_Model(bool opt_flag, ostream& ofile);


  string Get_VC_Identifier();

  void Set_Is_Global(bool v) {_is_global = v;}
  bool Get_Is_Global() {return(_is_global);}

  void Set_Is_Ordered(bool v) {_is_ordered = v;}
  bool Get_Is_Ordered() {return(_is_ordered);}

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
  static std::map<string, int> _integer_parameter_map;

  static std::set<AaType*> _extmem_access_types;
  static std::set<int> _extmem_access_widths;



  // external memory object.
  static AaStorageObject* _extmem_object;

  // recoalesce set.
  static map<AaObject*,set<AaStorageObject*> > _recoalesce_map;
  
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

  
   // marked root (top-level) modules.
  static set<string> _root_module_names;

  // modules reachable from root-modules.
  // (if no root-modules are specified, then all
  // modules become reachable).
  static set<AaModule*> _reachable_modules;



  static set<string> _mutex_set;
 public:

  static int _pointer_width;
  static int _foreign_word_size;
  static int _foreign_address_width;
  static string _current_file_name;
  static bool _verbose_flag;
  // gnu-pth links for aa2c?
  static bool _use_gnu_pth;

  static bool _balance_loop_pipeline_bodies;
  static string _tool_name;


  static bool _keep_extmem_inside;
  static int _extmem_size;

  static std::set<AaPointerDereferenceExpression*> _pointer_dereferences;

  static AaVoidType* _void_type;
  static string _extmem_object_name;


  static bool _print_inlined_functions_in_caller;
  static bool _optimize_flag;
  static bool _unordered_memory_flag;

  //// Aa2C related stuff.
  // top-level threads (daemons)
  // used by Aa2C to generate thread creation code.
  static set<string> _top_level_daemons;

  // prefix to be attached to c/vhdl modules.
  // this is useful to disambiguate different 
  // functions/entities created as part of a hierarchical
  // system build.
  static string _c_vhdl_module_prefix;

  // directory in which aa2c products will be created..
  static string _aa2c_output_directory;

  AaProgram();
  ~AaProgram();

  static string Report_Log_File_Name()
  {
	return(AaProgram::_c_vhdl_module_prefix + "__report_log_file__");
  }
  static void Add_Mutex(string m)
  {
		AaProgram::_mutex_set.insert(m);
  }
  static bool Is_Mutex(string m)
  {
	return(AaProgram::_mutex_set.find(m) != AaProgram::_mutex_set.end());
  }

  static void Make_Extmem_Object();
  static AaStorageObject* Get_Extmem_Object()
    {
      return(AaProgram::_extmem_object);
    }

  static void Print(ostream& ofile);
  static void Print_ExtMem_Access_Modules(ostream& ofile);
  static void Add_ExtMem_Access_Type(AaType* t);

  static void Add_ExtMem_Access_Width(int u)
    {
      AaProgram::_extmem_access_widths.insert(u);
    }

  static void Add_Object(AaObject* obj);
  static void Add_Module(AaModule* obj);

  static AaObject* Find_Object(string obj_name);
  static AaModule* Find_Module(string obj_name);

  static void Add_Call_Pair(AaModule* caller, AaModule* callee);

  // calculate longest path in all pipelined modules.
  static void Equalize_Paths_Of_Pipelined_Modules();

  static AaVoidType* Make_Void_Type();
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
  static void Write_VC_Memory_Spaces_Optimized(ostream& ofile);
  static void Write_VC_Modules(ostream& ofile);
  static void Write_VC_Modules_Optimized(ostream& ofile);

  static AaMemorySpace* Get_Memory_Space(int idx);

  static void Add_To_Recoalesce_Map(AaObject* obj, AaStorageObject* addr_obj);

  static AaForeignStorageObject* Make_Foreign_Storage_Object(AaType* t);

  static void Write_VHDL_C_Stubs();
  static void Print_Memory_Space_Info();

  static void Print_Global_Storage_Initializer(ostream& ofile);

  static void Mark_As_Root_Module(string& mod_name);
  static void Mark_Reachable_Modules(set<AaModule*>& reachable_modules);


  static void Add_Integer_Parameter(string pid, int pval);
  static int  Get_Integer_Parameter_Value(string pid);
  static bool  Is_Integer_Parameter(string pid);

};


#endif
