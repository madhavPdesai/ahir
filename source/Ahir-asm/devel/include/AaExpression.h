#ifndef _Aa_Expression__
#define _Aa_Expression__

#include <AaIncludes.h>
#include <AaEnums.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>


//**************************************** EXPRESSION ****************************************
class AaExpression: public AaRoot
{
  // the containing scope of this expression
  AaScope* _scope;

 protected:
  // type of the expression
  AaType* _type;

  // targets of this expression?
  set<AaExpression*> _targets;

  bool _already_evaluated;
 public:

  AaValue* _expression_value;

  virtual AaScope* Get_Scope() { return(this->_scope);}

  AaExpression(AaScope* scope_tpr);
  ~AaExpression();
  virtual string Kind() {return("AaExpression");}

  virtual void Set_Type(AaType* t);
  virtual AaType* Get_Type() {return(this->_type);}
  virtual AaValue* Get_Expression_Value() {return(this->_expression_value);}

  virtual void Map_Source_References(set<AaRoot*>& source_objects) { assert(0); }
  virtual bool Is_Expression() {return(true); }
  virtual bool Is_Object_Reference() {return(false);}

  virtual void PrintC(ofstream& ofile, string tab_string) { assert(0); }
  virtual void Update_Type() {};

  virtual void Add_Target(AaExpression* expr) {this->_targets.insert(expr);}
  
  virtual string Get_VC_Name();

  virtual void Write_VC_Control_Path( ostream& ofile);
  virtual void Write_VC_Control_Path_As_Target( ostream& ofile) 
  {
    this->Write_VC_Control_Path(ofile);
  }

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile) {}
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile) {}
  virtual void Write_VC_Wire_Declarations_As_Target(ostream& ofile) {}
  virtual void Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source) {}
  virtual void Write_VC_Datapath_Instances(AaExpression* target,  ostream& ofile) {}
  virtual void Write_VC_Links(string hier_id, ostream& ofile) {}
  virtual void Write_VC_Links_As_Target(string hier_id, ostream& ofile) {}
  virtual string Get_VC_Wire_Name()
  {
    return(this->Get_VC_Name() + "_wire");
  }

  virtual string Get_VC_Constant_Name()
  {
    return(this->Get_VC_Wire_Name() + "_constant");
  }

  virtual string Get_VC_Driver_Name()
  {
    if(this->Is_Constant())
      return(this->Get_VC_Constant_Name());
    else
      return(this->Get_VC_Wire_Name());
  }

  virtual string Get_VC_Receiver_Name()
  {
    return(this->Get_VC_Wire_Name());
  }

  virtual string Get_VC_Datapath_Instance_Name()
  {
    return(this->Get_VC_Name() +  "_inst");
  }

  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
    assert(0);
  }

  virtual bool Is_Constant() {return(this->_expression_value != NULL);}

  virtual bool Is_Implicit_Variable_Reference() {return(false);}

  virtual bool Is_Implicit_Object() {return(false);}

  virtual void Evaluate() {if(!_already_evaluated) _already_evaluated = true;};
  virtual void Assign_Expression_Value(AaValue* expr_value);
};


// Object Reference: base class for
// references to objects such as a, a[i], ./a[i][j]
// etc.
class AaObjectReference: public AaExpression
{

 protected:

  // the original string which was 
  // in the source file.
  string _object_ref_string;

  // make it more interesting for second pass
  // fixup

  // 0 means start searching from here
  // 1 means start searching in parent of this
  // and so on
  unsigned int _search_ancestor_level; 

  // if vector is (a b), this means that
  // look for child from search start point/a/b
  vector<string> _hier_ids;

  // root object.
  string _object_root_name;

  // the object to which this reference points!
  // figure it out in the second pass.
  // for an object reference which defines
  // an implicit variable, _object points
  // to the statement which defined it.
  AaRoot* _object;

 public:
  AaObjectReference(AaScope* scope_tpr, string object_ref_string);
  ~AaObjectReference();
  virtual void Print(ostream& ofile);
  virtual string Get_Object_Ref_String() {return(this->_object_ref_string);}

  virtual void Set_Object(AaRoot* obj) {this->_object = obj;}
  virtual AaRoot* Get_Object() { return(this->_object);}
  virtual void Add_Hier_Id(string hier_id) {this->_hier_ids.push_back(hier_id);}
  virtual void Set_Object_Root_Name(string orn) {this->_object_root_name = orn; }
  virtual string Get_Object_Root_Name() {return(this->_object_root_name);}
  virtual void Set_Search_Ancestor_Level(unsigned int sal) {this->_search_ancestor_level = sal;}
  virtual unsigned int Get_Search_Ancestor_Level() {return(this->_search_ancestor_level);}
  virtual bool Is_Hierarchical_Reference() 
  {
    return((this->_hier_ids.size() > 0) || (this->_search_ancestor_level > 0));
  }
  virtual string Kind() {return("AaObjectReference");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects); // important
  virtual void Add_Target_Reference(AaRoot* referrer); 
  virtual void Add_Source_Reference(AaRoot* referrer);
  virtual void PrintC(ofstream& ofile, string tab_string);

  virtual bool Is_Object_Reference() {return(true);}

  virtual void Evaluate();

};

// simple reference to a constant string (must be integer or real scalar or array)
class AaConstantLiteralReference: public AaObjectReference
{
  vector<string> _literals;
 public:
  AaConstantLiteralReference(AaScope* scope_tpr, 
			     string literal_string,  
			     vector<string>& literals);
  ~AaConstantLiteralReference();
  virtual string Kind() {return("AaConstantLiteralReference");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects) {} // do nothing
  virtual void PrintC(ofstream& ofile, string tab_string);
  virtual void Write_VC_Control_Path( ostream& ofile);

  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
    leaf_expression_set.insert(this);
  }

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Evaluate();
};

// simple reference (no array indices)
class AaSimpleObjectReference: public AaObjectReference
{
 public:
  AaSimpleObjectReference(AaScope* scope_tpr, string object_ref_string);
  ~AaSimpleObjectReference();
  virtual string Kind() {return("AaSimpleObjectReference");}
  virtual void Set_Object(AaRoot* obj);
  virtual void PrintC(ofstream& ofile, string tab_string);

  virtual void Write_VC_Control_Path( ostream& ofile);

  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
    leaf_expression_set.insert(this);
  }

  virtual void Write_VC_Control_Path_As_Target( ostream& ofile);

  virtual bool Is_Implicit_Variable_Reference();
  virtual bool Is_Implicit_Object();

  virtual string Get_VC_Constant_Name();
  virtual string Get_VC_Driver_Name();
  virtual string Get_VC_Receiver_Name();

  virtual void Evaluate();

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile);
  virtual void Write_VC_Wire_Declarations_As_Target(ostream& ofile);
  virtual void Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source);
  virtual void Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_As_Target(string hier_id, ostream& ofile);

  string Get_VC_Name() {return("simple_obj_ref_" + Int64ToStr(this->Get_Index()));}
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
  virtual void Set_Object(AaRoot* obj); 

  virtual string Kind() {return("AaArrayObjectReference");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects); // important
  virtual void PrintC(ofstream& ofile, string tab_string);

  virtual void Write_VC_Control_Path( ostream& ofile);
  void Write_VC_Address_Gen_Control_Path(ostream& ofile);

  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
    for(int idx = 0; idx < _indices.size(); idx++)
      _indices[idx]->Get_Leaf_Expression_Set(leaf_expression_set);
  }

  virtual void Write_VC_Control_Path_As_Target( ostream& ofile);
  virtual void Evaluate();

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile);
  virtual void Write_VC_Wire_Declarations_As_Target(ostream& ofile);
  virtual void Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source);
  virtual void Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_As_Target(string hier_id, ostream& ofile);
  string Get_VC_Name() {return("array_obj_ref_" + Int64ToStr(this->Get_Index()));}
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
  virtual string Kind() {return("AaTypeCastExpression");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects) 
  {
    if(this->_rest) 
      this->_rest->Map_Source_References(source_objects);
  }
  virtual void PrintC(ofstream& ofile, string tab_string)
  {
    ofile << tab_string << "(" << "(" << this->_to_type->CName() << ") ";
    this->_rest->PrintC(ofile,"");
    ofile << ")";
  }

  virtual void Write_VC_Control_Path( ostream& ofile);
  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
      _rest->Get_Leaf_Expression_Set(leaf_expression_set);
  }

  virtual void Evaluate();

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile);
  virtual void Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  string Get_VC_Name() {return("type_cast_" + Int64ToStr(this->Get_Index()));}
};


//
// unary expressions
// not B, <type-name> B
//
class AaUnaryExpression: public AaExpression
{
  AaOperation _operation;
  AaExpression* _rest;
 public:
  AaUnaryExpression(AaScope* scope_tpr, AaOperation operation, AaExpression* rest);
  ~AaUnaryExpression();
  virtual void Print(ostream& ofile); 

  AaOperation Get_Operation() {return(this->_operation);}
  AaExpression* Get_Rest() {return(this->_rest);}
  virtual string Kind() {return("AaUnaryExpression");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects) 
  {
    if(this->_rest) 
      this->_rest->Map_Source_References(source_objects);
  }
  virtual void PrintC(ofstream& ofile, string tab_string)
  {
    ofile << tab_string << C_Name(this->_operation) << "(";
    this->_rest->PrintC(ofile,"");
    ofile << ") ";
  }

  virtual void Write_VC_Control_Path( ostream& ofile);
  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
      _rest->Get_Leaf_Expression_Set(leaf_expression_set);
  }


  virtual void Evaluate();
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile);
  virtual void Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);

  string Get_VC_Name() {return("unary_" + Int64ToStr(this->Get_Index()));}
};

// 
// binary expression: q + r
//
class AaBinaryExpression: public AaExpression
{
  AaOperation _operation;
  AaExpression* _first;
  AaExpression* _second;

 public:
  AaBinaryExpression(AaScope* scope_tpr, AaOperation operation, AaExpression* first, AaExpression* second);
  ~AaBinaryExpression();
  virtual void Print(ostream& ofile);

  AaOperation Get_Operation() {return(this->_operation);}
  AaExpression* Get_First() {return(this->_first);}
  AaExpression* Get_Second() {return(this->_second);}
  virtual string Kind() {return("AaBinaryExpression");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects) 
  {
    if(this->_first) this->_first->Map_Source_References(source_objects);
    if(this->_second) this->_second->Map_Source_References(source_objects);
  }
  virtual void PrintC(ofstream& ofile, string tab_string)
  {
    if(!Is_Concat_Operation(this->_operation))
      {
	ofile << tab_string 
	      << C_Name(this->_operation) << "(";
	this->_first->PrintC(ofile,"");
	ofile << ", ";
	this->_second->PrintC(ofile,"");
	ofile << ")" ;
      }
    else
      {
	int a_width = ((AaUintType*)(this->Get_Type()))->Get_Width();
	int c_width;
	if(a_width <= 8)
	  c_width = 8;
	else if(a_width <= 16)
	  c_width = 16;
	else if(a_width <= 32)
	  c_width = 32;
	else if(a_width <= 64)
	  c_width = 64;
	else
	  assert(0 && "maximum supported length of integer for Aa2C is 64");

	ofile << tab_string 
	      << C_Name(this->_operation) << "(" << c_width << "_t,";
	this->_first->PrintC(ofile,"");
	
	ofile << ", ";
	ofile << ((AaUintType*)this->_first->Get_Type())->Get_Width();
	ofile << ", ";
	this->_second->PrintC(ofile,"");
	ofile << ", ";
	ofile << ((AaUintType*)this->_first->Get_Type())->Get_Width();
	ofile << ")" ;
      }
  }

  virtual void Update_Type();


  virtual void Write_VC_Control_Path( ostream& ofile);

  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
      _first->Get_Leaf_Expression_Set(leaf_expression_set);
      _second->Get_Leaf_Expression_Set(leaf_expression_set);
  }

  bool Is_Trivial();
  virtual void Evaluate();
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile);
  virtual void Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);

  string Get_VC_Name() {return("binary_" + Int64ToStr(this->Get_Index()));}
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
  virtual string Kind() {return("AaTernaryExpression");}
  virtual void Map_Source_References(set<AaRoot*>& source_objects) 
  {
    if(this->_test) this->_test->Map_Source_References(source_objects);
    if(this->_if_true) this->_if_true->Map_Source_References(source_objects);
    if(this->_if_false) this->_if_false->Map_Source_References(source_objects);
  }

  virtual void PrintC(ofstream& ofile, string tab_string)
  {
    ofile << tab_string ;
    ofile << "( (";
    this->_test->PrintC(ofile,tab_string);
    ofile << ") ? (";
    this->_if_true->PrintC(ofile,tab_string);
    ofile << ") : (";
    this->_if_false->PrintC(ofile,tab_string);
    ofile << ") ";
  }

  virtual void Write_VC_Control_Path( ostream& ofile);
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile);
  virtual void Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);

  virtual void Get_Leaf_Expression_Set(set<AaExpression*>& leaf_expression_set)
  {
      _test->Get_Leaf_Expression_Set(leaf_expression_set);
      _if_true->Get_Leaf_Expression_Set(leaf_expression_set);
      _if_false->Get_Leaf_Expression_Set(leaf_expression_set);
  }

  virtual void Evaluate();

  string Get_VC_Name() {return("ternary_" + Int64ToStr(this->Get_Index()));}
};

#endif
