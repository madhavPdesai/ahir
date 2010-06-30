#ifndef _Aa_Parser_Classes__
#define _Aa_Parser_Classes__

#include <cstddef>
#include <algorithm>
#include <stdlib.h>
#include <ctype.h>
#include <malloc.h>
#include <unistd.h>
#include <fstream>
#include <iostream>
#include <getopt.h>
#include <string>
#include <set>
#include <list>
#include <vector>
#include <deque>
#include <map>
#include <deque>
#include <iomanip>
#include <sstream>
#include <math.h>
#include <istream>
#include <ostream>
#include <assert.h>


using namespace std;
/* Author: Madhav Desai                                  */
/* This could have been auto-generated, but I did it the */
/* brute force way.                                      */

// Tab string
string Tab_(unsigned int n);

// IntToStr
string IntToStr(unsigned int x);

// string compare
struct StringCompare:public binary_function
  <string, string, bool >
{
  bool operator() (string, string) const;
};

//****************************************** ROOT ***************************************

//
// base class for all objects.  Each object will have a parent scope
//
class AaRoot
{
  // the containing scope
  AaRoot* _scope;

  // to get unique id's for anon objects
  static int _root_counter;
  // set if there is an error
  static bool _error_flag;

  // fill from the parser at some point.
  unsigned int _line_number;


 public:

  static void Increment_Root_Counter();// { _root_counter += 1; }
  static int Get_Root_Counter(); // { return _root_counter; }
  static void Error(); // {_error_flag = true;}
  static bool Get_Error_Flag(); // { return _error_flag; }
  void Set_Line_Number(int n) { this->_line_number = n; }
  unsigned int Get_Line_Number() { return(this->_line_number); }

  AaRoot();
  ~AaRoot(); 

  // do we really need this? keep it for now
  virtual bool Is(string& class_name);

  // useful print versions
  virtual void Print(ostream& ofile); // override this in derived classes
  virtual void Print(ofstream& ofile);
  virtual void Print(string& ostring);
};

//**************************************** SCOPE **************************************


// each scope manages a collection of scopes
class AaScope : public AaRoot
{
  // the containing scope of this scope!
  AaScope* _scope;
  unsigned int _depth;

 private: 

  string _label;
    
  //
  // map of label to children of this scope
  // children can be scopes or objects or ...
  // 
  map<string,AaRoot*,StringCompare> _child_map;

 public:

  virtual unsigned int Get_Depth() {return this->_depth;}

  virtual void Set_Label(string s) {if(s != "") this->_label = s; else assert(0);}
  virtual string Get_Label() {return (this->_label);}

  AaScope* Get_Scope() { return(this->_scope);}

  AaScope(AaScope* parent_scope);
  ~AaScope(); 

  //  map for easy searching
  virtual void Map_Child(string tag, AaRoot* tn);

  // find child with specified label
  virtual AaRoot* Find_Child(string tag);
};

/*****************************************  TYPE ****************************/

class AaType: public AaRoot
{
  AaScope* _scope;
  // types dont have names, only declarations.
 public:
  virtual AaScope* Get_Scope() {return(this->_scope);}

  AaType(AaScope* parent);
  ~AaType();
};

class AaScalarType: public AaType
{

 public:
  AaScalarType(AaScope* parent);
  ~AaScalarType();
};


class AaUintType: public AaScalarType
{
  // width > 0
  unsigned int _width;

 public:
  virtual unsigned int Get_Width() {return(this->_width);}

  AaUintType(AaScope* scope, unsigned int width);
  ~AaUintType();
  void Print(ostream& ofile);
};

class AaIntType: public AaUintType
{
  // gets width from Uint

 public:
  AaIntType(AaScope* scope,unsigned int width);
  ~AaIntType();
  void Print(ostream& ofile);
};

class AaPointerType: public AaUintType
{
 public :
  AaPointerType(AaScope* scope, unsigned int _object_width);
  ~AaPointerType();

  virtual void Print(ostream& ofile);
};


class AaFloatType : public AaScalarType
{
  // both > 0
  unsigned int _characteristic;
  unsigned int _mantissa;

 public:
  unsigned int Get_Characteristic() {return(this->_characteristic);}
  unsigned int Get_Mantissa() {return(this->_mantissa);}

  AaFloatType(AaScope* scope, unsigned int characteristic, unsigned int mantissa);
  ~AaFloatType();
  void Print(ostream& ofile);
};

class AaArrayType: public AaType
{
  // multi-dimensional array types are possible
  vector<unsigned int> _dimension;
  
  // element type is a scalar
  AaScalarType* _element_type;
 
 public:

  unsigned int Get_Number_Of_Dimensions() {return(this->_dimension.size());}
  AaScalarType* Get_Element_Type() {return(this->_element_type);}


  AaArrayType(AaScope* scope, AaScalarType* stype, vector<unsigned int>& dimensions);
  ~AaArrayType();

  unsigned int Get_Dimension(unsigned int dim_id);
  void Print(ostream& ofile);
};

/*****************************************  VALUE  ****************************/
// value

class AaValue: public AaRoot
{
  AaScope* _scope;
 public:
  
    AaValue(AaScope* scope);
  ~AaValue();

  virtual string Get_Value_String() {assert(0);}
  virtual AaScope* Get_Scope() {return this->_scope;}

};

class AaStringValue: public AaValue
{
  string _value;
 public:
  string Get_Value_String() {return(this->_value);}

  AaStringValue(AaScope* scope, string value);
  ~AaStringValue();
  virtual void Print(ostream& ofile);
};


//**************************************** EXPRESSION ****************************************

// general expression class
// expressions are anonymous
class AaExpression: public AaRoot
{
  // the containing scope of this expression
  AaScope* _scope;

 public:
  virtual AaScope* Get_Scope() { return(this->_scope);}

  AaExpression(AaScope* scope_tpr);
  ~AaExpression();
};


// Object Reference: base class for
// references to objects such as a, a[i], ./a[i][j]
// etc.
class AaObjectReference: public AaExpression
{

  // just a string for now. 
  string _object_ref_string;

 public:
  AaObjectReference(AaScope* scope_tpr, string object_ref_string);
  ~AaObjectReference();
  virtual void Print(ostream& ofile);
  virtual string Get_Object_Ref_String() {return(this->_object_ref_string);}
};

// simple reference to a constant string (must be integer or real scalar or array)
class AaConstantLiteralReference: public AaObjectReference
{
 public:
  AaConstantLiteralReference(AaScope* scope_tpr, string literal_string);
  ~AaConstantLiteralReference();
};

// simple reference (no array indices)
class AaSimpleObjectReference: public AaObjectReference
{
 public:
  AaSimpleObjectReference(AaScope* scope_tpr, string object_ref_string);
  ~AaSimpleObjectReference();
};

// array object reference
class AaArrayObjectReference: public AaObjectReference
{
  // indices will in general be expressions
  vector<AaExpression*> _indices;

 public:
   unsigned int Get_Number_Of_Indices() {return this->_indices.size();}

  // note: base object and all elements of index_list become children
  AaArrayObjectReference(AaScope* scope_tpr,
			 string object_ref_string, 
			 vector<AaExpression*>& index_list);
  ~AaArrayObjectReference();

  virtual void Print(ostream& ofile); 
  AaExpression* Get_Array_Index(unsigned int idx);
};

// type cast expression (is unary)
class AaTypeCastExpression: public AaExpression
{
  AaType* _to_type;
  AaExpression* _rest;
 public:

  AaType* Get_To_Type() {return(this->_to_type);}
  AaExpression* Get_Rest() {return(this->_rest);}

  AaTypeCastExpression(AaScope* scope, AaType* ref_type, AaExpression *rest);
  ~AaTypeCastExpression();
  void Print(ostream& ofile);
};


//
// unary expressions
// not B, <type-name> B
//
class AaUnaryExpression: public AaExpression
{
  AaStringValue* _operation;
  AaExpression* _rest;
 public:
  AaUnaryExpression(AaScope* scope_tpr, AaStringValue* operation, AaExpression* rest);
  ~AaUnaryExpression();
  virtual void Print(ostream& ofile); 

  AaStringValue* Get_Operation() {return(this->_operation);}
  AaExpression* Get_Rest() {return(this->_rest);}
};

// 
// binary expression: q + r
//
class AaBinaryExpression: public AaExpression
{
  AaStringValue* _operation;
  AaExpression* _first;
  AaExpression* _second;

 public:
  AaBinaryExpression(AaScope* scope_tpr, AaStringValue* operation, AaExpression* first, AaExpression* second);
  ~AaBinaryExpression();
  virtual void Print(ostream& ofile);

  AaStringValue* Get_Operation() {return(this->_operation);}
  AaExpression* Get_First() {return(this->_first);}
  AaExpression* Get_Second() {return(this->_second);}
};

// ternary expression: a ? b : c
class AaTernaryExpression: public AaExpression
{
  AaExpression* _test;
  AaExpression* _if_true;
  AaExpression* _if_false;
 public:
  AaTernaryExpression(AaScope* scope_tpr, AaExpression* test,AaExpression* iftrue, AaExpression* iffalse);
  ~AaTernaryExpression();

  virtual void Print(ostream& ofile); 

  AaExpression*      Get_Test() {return(this->_test);}
  AaExpression* Get_If_True() {return(this->_if_true);}
  AaExpression* Get_If_False() {return(this->_if_false);}
};


// *******************************************  STATEMENT etc. ************************************
// base class for statements
// A statement may specify a set of targets which act as
// implicit variable declarations.  These need to be 
// mapped in the containing scope
class AaStatement: public AaScope
{
 public:
  AaStatement(AaScope* scope);
  
  // add map entries in parent´s lookup map for easy access
  virtual void Map_Targets() 
  {
    // derived statements will map their targets
    // in their containing scopes.
    assert(0); 
  }

  virtual void Map_Target(AaObjectReference* obj_ref) 
  {
    // \todo the object reference string is presented to
    // the containing scope. If no declared object is
    // found in the map and if no duplicate exists, then
    // an entry is made into the map 
    cerr << "Warning: Map_Target is not yet implemented" << endl;
  }

  virtual string Tab();

  ~AaStatement();
};

// statement sequence (is used in block statements which lead to programs)
class AaStatementSequence: public AaScope
{
  vector<AaStatement*> _statement_sequence;
 public:

  AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence);
  ~AaStatementSequence();

  unsigned int Get_Statement_Count() { return this->_statement_sequence.size(); }
  virtual void Print(ostream& ofile);
};

// null statement
class AaNullStatement: public AaStatement
{
 public:
  AaNullStatement(AaScope* parent_tpr);
  ~AaNullStatement();

  virtual void Print(ostream& ofile) { ofile << this->Tab() << "$null" << endl; }
};

// exit statement
class AaExitStatement: public AaStatement
{
 public:
  AaExitStatement(AaScope* parent_tpr);
  ~AaExitStatement();

  virtual void Print(ostream& ofile) { ofile << this->Tab() << "$exit" << endl; }
};

// assignment statement
class AaAssignmentStatement: public AaStatement
{
  AaObjectReference* _target;
  AaExpression* _source;
 public:
  AaObjectReference* Get_Target() {return(this->_target);}
  AaExpression* Get_Source() {return(this->_source);}

  virtual void Map_Targets() 
  {
    // only one target which can serve as a handle
    // to this statement
    this->Map_Target(this->Get_Target());
  }

  AaAssignmentStatement(AaScope* scope,AaObjectReference* target, AaExpression* source);
  ~AaAssignmentStatement();

  virtual void Print(ostream& ofile); 
};



class AaCallStatement: public AaStatement
{
  string _function_name;
  vector<AaObjectReference*> _input_args;
  vector<AaObjectReference*> _output_args;
 public:
  unsigned int Get_Number_Of_Input_Args() {return(this->_input_args.size());}
  unsigned int Get_Number_Of_Output_Args() {return(this->_output_args.size());}
  string Get_Function_Name() {return(this->_function_name);}
  
  AaCallStatement(AaScope* scope_tpr,
		  string func_name,
		  vector<AaObjectReference*>& inargs, 
		  vector<AaObjectReference*>& outargs);

  ~AaCallStatement();
  
  AaObjectReference* Get_Input_Arg(unsigned int index);
  AaObjectReference* Get_Output_Arg(unsigned int index);
  
  virtual void Print(ostream& ofile); 
};


class AaBlockStatement: public AaStatement
{
  string _label;
 protected:
  AaStatementSequence* _statement_sequence;

 public:
  virtual string Get_Label() { return(this->_label);}
  virtual unsigned int Get_Statement_Count() {return(this->_statement_sequence->Get_Statement_Count()); }
  virtual void Set_Statement_Sequence(AaStatementSequence* statement_sequence) 
  {
    this->_statement_sequence = statement_sequence;
  }
  AaBlockStatement(AaScope* scope, string label);
  ~AaBlockStatement();
  virtual void Print(ostream& ofile);
};

class AaSeriesBlockStatement: public AaBlockStatement
{
 public:
  AaSeriesBlockStatement(AaScope* scope, string label);
  ~AaSeriesBlockStatement();
  virtual void Print(ostream& ofile);
};

class AaParallelBlockStatement: public AaBlockStatement
{
 public:
  AaParallelBlockStatement(AaScope* scope, string label);
  ~AaParallelBlockStatement();
  virtual void Print(ostream& ofile);
};

class AaForkBlockStatement: public AaBlockStatement
{
 public:
  AaForkBlockStatement(AaScope* scope , string label);
  ~AaForkBlockStatement();
  virtual void Print(ostream& ofile);
};

class AaBranchBlockStatement: public AaBlockStatement
{
 public:
  AaBranchBlockStatement(AaScope* scope, string label);
  ~AaBranchBlockStatement();
  virtual void Print(ostream& ofile);
};

class AaJoinForkStatement: public AaBlockStatement
{
  vector<string> _join_labels;
 public:
  void Add_Join_Label(string jl) { this->_join_labels.push_back(jl); }

  virtual void Print(ostream& ofile);
  AaJoinForkStatement(AaForkBlockStatement* scope);
  ~AaJoinForkStatement();
};

class AaMergeStatement: public AaBlockStatement
{
  vector<string> _merge_label_vector; // to preserve the order
  set<string,StringCompare> _merge_label_set;

 public:
  void Add_Merge_Label(string lbl) 
  { 
    if(this->_merge_label_set.find(lbl) == this->_merge_label_set.end())
      {
	this->_merge_label_set.insert(lbl); 
	this->_merge_label_vector.push_back(lbl);
      }
  }

  AaMergeStatement(AaBranchBlockStatement* scope);
  ~AaMergeStatement();

  virtual void Print(ostream& ofile);
};

class AaPhiStatement: public AaStatement
{
  AaSimpleObjectReference* _target;
  vector<pair<string,AaObjectReference*> > _merged_objects;

 public:
  AaPhiStatement(AaMergeStatement* scope);
  ~AaPhiStatement();
  void Set_Target(AaSimpleObjectReference* tgt) { this->_target = tgt; }
  void Add_Source_Pair(string label, AaObjectReference* obj)
  {
    this->_merged_objects.push_back(pair<string,AaObjectReference*>(label,obj));
  }
  virtual void Print(ostream& ofile);
};

class AaSwitchStatement: public AaStatement
{
  AaExpression* _select_expression;
  vector<pair<AaConstantLiteralReference*, AaBlockStatement*> > _choice_pairs;
  AaBlockStatement* _default_statement;

 public:

  void Set_Select_Expression(AaExpression* expr) {this->_select_expression = expr;}
  void Add_Choice(AaConstantLiteralReference* cond, AaBlockStatement* sseq)
  {
    this->_choice_pairs.push_back(pair<AaConstantLiteralReference*,AaBlockStatement*>(cond,sseq));
  }

  void Set_Default_Statement(AaBlockStatement* sseq)
  {
    this->_default_statement = sseq;
  }

  AaSwitchStatement(AaBranchBlockStatement* scope);
  ~AaSwitchStatement();
  virtual void Print(ostream& ofile);
};


class AaIfStatement: public AaStatement
{
  AaExpression* _test_expression;
  AaBlockStatement* _if_statement;
  AaBlockStatement* _else_statement;
 public:

  void Set_Test_Expression(AaExpression* te) { this->_test_expression = te; }
  void Set_If_Statement(AaBlockStatement* is) { this->_if_statement = is; }
  void Set_Else_Statement(AaBlockStatement* es) { this->_else_statement = es; }

  AaIfStatement(AaBranchBlockStatement* scope);
  ~AaIfStatement();
  virtual void Print(ostream& ofile);
};



/*****************************************  OBJECT  ****************************/
// base object
// Each object has a type, a name, a value and a parent

class AaObject: public AaRoot
{
  string _name;
  AaConstantLiteralReference* _value;
  AaType* _object_type;
  AaScope* _scope;

 public:

  AaType* Get_Object_Type() {return(this->_object_type);}
  AaConstantLiteralReference* Get_Value() {return(this->_value);}
  void Set_Value(AaConstantLiteralReference* v) {this->_value = v;}
  virtual string Get_Name() {return(this->_name);}
  virtual AaScope* Get_Scope() {return(this->_scope);}
  virtual string Tab();

  AaObject(AaScope* scope_tpr, string oname, AaType* object_type);
  ~AaObject();

  virtual void Print(ostream& ofile);

};

// interface object: function arguments
class AaInterfaceObject: public AaObject
{
  // arguments can be input or output
  string _mode; // IN or OUT?

 public:
  string Get_Mode() {return(this->_mode);}

  AaInterfaceObject(AaScope* scope_tpr, string oname, AaType* otype, string mode);
  ~AaInterfaceObject();

  // uses AaObject::Print method
};

class AaConstant: public AaObject
{
  //
  // constants are visible only in pure ancestors
  // or pure descendants.
  //
 public:
  AaConstant(AaScope* scope_tpr, string oname, AaType* otype, AaConstantLiteralReference* value);
  ~AaConstant();

  virtual void Print(ostream& ofile); 
};

class AaGlobal: public AaObject
{
  // globally declared objects will be
  // stored in memory which is visible to
  // entire program
  //
  // parent of global will always be AaProgram
  //
 public:

  AaGlobal(AaScope* scope_tpr, string oname, AaType* otype, AaConstantLiteralReference* initial_value);
  ~AaGlobal();

  virtual void Print(ostream& ofile); 
};

class AaLocal: public AaObject
{
  //
  // locally declared memory is visible only
  // in scope and pure descendants.
 public:
  AaLocal(AaScope* scope_tpr, string oname, AaType* otype, AaConstantLiteralReference* initial_value);
  ~AaLocal();
  virtual void Print(ostream& ofile); 
};

class AaPipe: public AaObject
{
  // 
  // A pipe is global 
  //
 public:
  AaPipe(AaScope* scope_tpr,string oname, AaType* otype);
  ~AaPipe();

  virtual void Print(ostream& ofile);
};


// compilation unit: a module is basically a block
// statement, but with arguments
class AaModule: public AaBlockStatement
{
  vector<AaInterfaceObject*>  _input_args;
  vector<AaInterfaceObject*>  _output_args;
  vector<AaObject*> _objects;

 public:
  AaModule(AaScope* scope, string fname);
  ~AaModule();

  void Add_Argument(AaInterfaceObject* obj);
  void Add_Object(AaObject* obj) 
  { 
    assert(this->Find_Child(obj->Get_Name()) == NULL); 
    this->_objects.push_back(obj);
    this->Map_Child(obj->Get_Name(),obj);
  }

  unsigned int Get_Number_Of_Input_Arguments() {return(this->_input_args.size());}
  AaInterfaceObject* Get_Input_Argument(unsigned int index);

  unsigned int Get_Number_Of_Output_Arguments() {return(this->_output_args.size());}
  AaInterfaceObject* Get_Output_Argument(unsigned int index);

  void Print(ostream& ofile);
};


// The program, a list of modules
class AaProgram : public AaScope
{

  // perhaps we should also have declarations here?

  vector<AaModule*> _modules;
  static map<string,AaType*,StringCompare> _type_map;

 public:
  AaProgram();
  ~AaProgram();

  void Add_Module(AaModule* fn);
  virtual void Print(ostream& ofile);

  static AaUintType* Make_Uinteger_Type(unsigned int w)
  {
    AaUintType* ret_type = NULL;
    string tid = "uint<" + IntToStr(w) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaUintType*) (*titer).second;
    else
      {
	ret_type = new AaUintType((AaScope*) NULL, w);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaIntType* Make_Integer_Type(unsigned int w)
  {
    AaIntType* ret_type = NULL;
    string tid = "int<" + IntToStr(w) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaIntType*) (*titer).second;
    else
      {
	ret_type = new AaIntType((AaScope*) NULL, w);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaFloatType* Make_Float_Type(unsigned int c, unsigned int m)
  {
    AaFloatType* ret_type = NULL;
    string tid = "float<" + IntToStr(c) + "," + IntToStr(m) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaFloatType*) (*titer).second;
    else
      {
	ret_type = new AaFloatType((AaScope*) NULL, c,m);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaArrayType* Make_Array_Type(AaScalarType* etype, vector<unsigned int>& dims)
  {
    AaArrayType* ret_type = NULL;
    string tid = "array";
    for(unsigned int i=0; i < dims.size(); i++)
	tid += "<" + IntToStr(dims[i]) + ">";
    tid += " of ";
    etype->Print(tid);
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaArrayType*) (*titer).second;
    else
      {
	ret_type = new AaArrayType((AaScope*) NULL,etype,dims);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
  static AaPointerType* Make_Pointer_Type(unsigned int w)
  {
    AaPointerType* ret_type = NULL;
    string tid = "pointer<" + IntToStr(w) + ">";
    map<string,AaType*,StringCompare>::iterator titer = AaProgram::_type_map.find(tid);
    if(titer != AaProgram::_type_map.end())
      ret_type = (AaPointerType*) (*titer).second;
    else
      {
	ret_type = new AaPointerType((AaScope*) NULL, w);
	AaProgram::_type_map[tid] = ret_type;
      }
    return(ret_type);
  }
};


#endif
