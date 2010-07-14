using namespace std;
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
#include <AaProgram.h>

string Tab_(unsigned int n)
{
  string ret_string = "";
  for(unsigned int i=0; i < n; i++)
    ret_string += '\t';
  return(ret_string);
}

string IntToStr(unsigned int x)
{
  ostringstream string_stream(ostringstream::out);
  string_stream << x;
  return(string_stream.str());
}

bool StringCompare::operator() (string s11, string s21) const
{
  const char *s1 = s11.c_str ();
  const char *s2 = s21.c_str ();
  for (int i = 0; s2[i]; i++)
    {
      if (!s1[i])
	return ((!s2[i]) ? false : true);
      else if (s1[i] < s2[i])
	return true;
      else if (s1[i] > s2[i])
	return false;
    }
  return false;
};

bool Is_Shift_Operation(string op)
{
  return(op == "<<" || op == ">>");
}
bool Is_Compare_Operation(string op)
{
  return(op == "<" || op == ">" || op == "<=" || op == ">=" || op == "==" || op == "!=");
}

//---------------------------------------------------------------------
// AaRoot
//---------------------------------------------------------------------
int AaRoot::_root_counter = 0;
bool AaRoot::_error_flag = false;

AaRoot::AaRoot() 
{
  this->Increment_Root_Counter();
}
AaRoot::~AaRoot() {};
string AaRoot::Kind()
{
  return("AaRoot");
}
bool AaRoot::Is(const string kinfo)
{ 
  return(this->Kind() == kinfo);
}
void AaRoot::Increment_Root_Counter() { AaRoot::_root_counter += 1; }
int AaRoot::Get_Root_Counter() { return AaRoot::_root_counter; }
void AaRoot::Error() { AaRoot::_error_flag = true;}
bool AaRoot::Get_Error_Flag() { return AaRoot::_error_flag; }
void AaRoot::Print(ostream& ofile)
{
  assert(0);
}
void AaRoot::Print(ofstream& ofile)
{
  ostream *outstr = &ofile;
  this->Print(*outstr);
}
void AaRoot::Print(string& ostring) 
{
  ostringstream string_stream(ostringstream::out);
  this->Print(string_stream);
  ostring += string_stream.str();
}

void AaRoot::Add_Target_Reference(AaRoot* referrer)
{
  this->_target_references.insert(referrer);
}
void AaRoot::Add_Source_Reference(AaRoot* referrer)
{
  this->_source_references.insert(referrer);
}


//---------------------------------------------------------------------
// AaScope
//---------------------------------------------------------------------
AaScope::AaScope(AaScope* p):AaRoot() 
{
  this->_scope = p; 
  if(p != NULL)
    this->_depth = p->Get_Depth() + 1;
  else
    this->_depth = 0;
}

AaScope::~AaScope() {}


void AaScope::Map_Child(string lbl, AaRoot* tn)
{
  if(tn != NULL)
    {
      if(this->_child_map.find(lbl) == this->_child_map.end())
	{
	  this->_child_map[lbl] = tn;
	  this->_reference_map[tn] = pair<vector<AaRoot*>*, vector<AaRoot*>*>(new vector<AaRoot*>, new vector<AaRoot*>);
	}
    }
}

AaRoot* AaScope::Find_Child_Here(string cname)
{
  AaRoot* ret_child = NULL;
  map<string,AaRoot*,StringCompare>::iterator miter =
    this->_child_map.find(cname);
  if(miter != this->_child_map.end())
    ret_child = (*miter).second;
  return(ret_child);
}

AaRoot* AaScope::Find_Child(string cname)
{
  AaRoot* ret_child = this->Find_Child_Here(cname);
  if(!ret_child && this->Get_Scope())
    {
      ret_child = this->Get_Scope()->Find_Child(cname);
    }
  return(ret_child);
}

/*****************************************  TYPE ****************************/

//---------------------------------------------------------------------
// AaType
//---------------------------------------------------------------------
AaType::AaType(AaScope* p): AaRoot() {this->_scope = p;}
AaType::~AaType() {};

//---------------------------------------------------------------------
// AaScalarType
//---------------------------------------------------------------------
AaScalarType::AaScalarType(AaScope* p):AaType(p) {};
AaScalarType::~AaScalarType() {};

//---------------------------------------------------------------------
// AaUintType
//---------------------------------------------------------------------
AaUintType::AaUintType(AaScope* p, unsigned int width):AaScalarType(p) 
{
  this->_width = width;
}
AaUintType::~AaUintType() {};
void AaUintType::Print(ostream& ofile)
{
  ofile << "$uint<" << this->Get_Width() << ">";
}

//---------------------------------------------------------------------
// AaIntType
//---------------------------------------------------------------------
AaIntType::AaIntType(AaScope* p, unsigned int width):AaUintType(p, width) {};
AaIntType::~AaIntType() {};
void AaIntType::Print(ostream& ofile)
{
  ofile << "$int<" << this->Get_Width() << ">";
}

//---------------------------------------------------------------------
// AaPointerType: public AaUintType
//---------------------------------------------------------------------
AaPointerType::AaPointerType(AaScope* p, unsigned int object_width): AaUintType(p,object_width) {};
AaPointerType::~AaPointerType() {};
void AaPointerType::Print(ostream& ofile)
{
  ofile << "$pointer<" << this->Get_Width() << "> ";
}

//---------------------------------------------------------------------
//AaFloatType
//---------------------------------------------------------------------
AaFloatType::AaFloatType(AaScope* p, unsigned int characteristic, unsigned int mantissa):AaScalarType(p)
{
  this->_characteristic = characteristic;
  this->_mantissa = mantissa;
}
AaFloatType::~AaFloatType() {};
void AaFloatType::Print(ostream& ofile)
{
  ofile << "$float<" << this->Get_Characteristic() << "," << this->Get_Mantissa() << ">";
}

//---------------------------------------------------------------------
// AaArrayType
//---------------------------------------------------------------------
AaArrayType::AaArrayType(AaScope* p, AaScalarType* stype, vector<unsigned int>& dimensions): AaType(p) 
{
  this->_element_type = stype;
  for(unsigned int i = 0; i < dimensions.size(); i++)
    this->_dimension.push_back(dimensions[i]);
};
AaArrayType::~AaArrayType() {};
unsigned int AaArrayType::Get_Dimension(unsigned int dim_id)
{
  unsigned int ret_value = 0;
  if(dim_id >= 0 && dim_id <= this->_dimension.size())
    {
      ret_value = this->_dimension[dim_id];
    }
  return(ret_value);
}
void AaArrayType::Print(ostream& ofile)
{
  ofile << "$array";
  for(unsigned int i = 0; i < this->Get_Number_Of_Dimensions(); i++)
    ofile << "<" << this->Get_Dimension(i) << ">";
  ofile << " $of ";
  this->Get_Element_Type()->Print(ofile);
}


// *******************************************  VALUE ************************************
// AaValue
AaValue::AaValue(AaScope* parent):AaRoot() {this->_scope = parent;}
AaValue::~AaValue() {};

//AaStringValue
AaStringValue::AaStringValue(AaScope* parent, string value): AaValue(parent) 
{
  this->_value = value;
};
AaStringValue::~AaStringValue() {};
void AaStringValue::Print(ostream& ofile) 
{
  ofile << this->Get_Value_String(); 
}

/*****************************************  OBJECT  ****************************/

//---------------------------------------------------------------------
// AaObject
//---------------------------------------------------------------------
AaObject::AaObject(AaScope* parent_tpr, string oname, AaType* object_type):AaRoot() 
{
  this->_name = oname;
  this->_scope = parent_tpr;
  this->_value = NULL;
  this->_type = object_type;
}
AaObject::~AaObject() {};
string AaObject::Tab()
{
  return((this->Get_Scope() != NULL) ? Tab_(this->Get_Scope()->Get_Depth()) : Tab_(0));
}
void AaObject::Print(ostream& ofile)
{
  ofile << " " << this->Get_Name() << " ";
  this->Get_Type()->Print(ofile);
  if(this->_value != NULL)
    {
      ofile << ":= ";
      this->_value->Print(ofile);
    }
  ofile << " ";
}

//---------------------------------------------------------------------
// AaInterfaceObject
//---------------------------------------------------------------------
AaInterfaceObject::AaInterfaceObject(AaScope* parent_tpr, 
				     string oname, 
				     AaType* otype, 
				     string mode):AaObject(parent_tpr,oname,otype) 
{
  this->_mode = mode;
}
AaInterfaceObject::~AaInterfaceObject() {};

//---------------------------------------------------------------------
// AaStorageObject
//---------------------------------------------------------------------
AaStorageObject::AaStorageObject(AaScope* parent_tpr,string oname, AaType* otype, 
		   AaConstantLiteralReference* initial_value):AaObject(parent_tpr,oname,otype) 
{
  this->Set_Value(initial_value);
};
AaStorageObject::~AaStorageObject() {};
void AaStorageObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "\t$storage ";
  this->AaObject::Print(ofile);
}

//---------------------------------------------------------------------
// AaPipeObject
//---------------------------------------------------------------------
AaPipeObject::AaPipeObject(AaScope* parent_tpr, string oname, AaType* otype):AaObject(parent_tpr,oname,otype) {};
AaPipeObject::~AaPipeObject() {};
void AaPipeObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "\t$pipe ";
  this->AaObject::Print(ofile);
}

//---------------------------------------------------------------------
// AaConstantObject
//---------------------------------------------------------------------
AaConstantObject::AaConstantObject(AaScope* parent_tpr , string oname, AaType* otype, 
		       AaConstantLiteralReference* value):AaObject(parent_tpr, oname,otype)
{
  this->Set_Value(value);
}
AaConstantObject::~AaConstantObject() {};
void AaConstantObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "\t$constant ";
  this->AaObject::Print(ofile);
}



/***************************************** EXPRESSION  ****************************/
//---------------------------------------------------------------------
// AaExpression
//---------------------------------------------------------------------
AaExpression::AaExpression(AaScope* parent_tpr):AaRoot() 
{
  this->_scope = parent_tpr;
  this->_type = NULL; // will be determined by dependency traversal
}
AaExpression::~AaExpression() {};

//---------------------------------------------------------------------
// AaObjectReference
//---------------------------------------------------------------------
AaObjectReference::AaObjectReference(AaScope* parent_tpr, string object_id):AaExpression(parent_tpr)
{
  this->_object_ref_string = object_id;
  this->_search_ancestor_level = 0; 
}

AaObjectReference::~AaObjectReference() {};
void AaObjectReference::Print(ostream& ofile)
{
  ofile << this->Get_Object_Ref_String();
}

void AaObjectReference::Map_Source_References()
{
  AaScope* search_scope = NULL;
  if(this->Get_Search_Ancestor_Level() > 0)
    {
      search_scope = this->Get_Scope()->Get_Ancestor_Scope(this->Get_Search_Ancestor_Level());
    }
  else if(this->_hier_ids.size() > 0)
    search_scope = this->Get_Scope()->Get_Descendant_Scope(this->_hier_ids);
  else
    search_scope = this->Get_Scope();


  AaRoot* child = NULL;
  if(search_scope == NULL)
    {
      child = AaProgram::Find_Object(this->_object_root_name);
    }
  else
    {
      child = search_scope->Find_Child(this->_object_root_name);
    }

  if(child == NULL)
    {
      cerr << "Error: did not find object reference " << this->Get_Object_Ref_String() << ": line " << this->Get_Line_Number() << endl;
      AaRoot::Error();
    }
  else
    {
      this->Set_Object(child);
      child->Add_Source_Reference(this);  // child -> this
      this->Add_Target_Reference(child);  // this  -> child
    }
}

void AaObjectReference::Add_Target_Reference(AaRoot* referrer)
{
  this->AaRoot::Add_Target_Reference(referrer);
  if(referrer->Is("AaInterfaceObject"))
    {
      this->Set_Type(((AaInterfaceObject*)referrer)->Get_Type());
    }
}
void AaObjectReference::Add_Source_Reference(AaRoot* referrer)
{
  this->AaRoot::Add_Source_Reference(referrer);
  if(referrer->Is("AaInterfaceObject"))
    {
      this->Set_Type(((AaInterfaceObject*)referrer)->Get_Type());
    }
}

//---------------------------------------------------------------------
// AaConstantLiteralReference: public AaObjectReference
//---------------------------------------------------------------------
AaConstantLiteralReference::AaConstantLiteralReference(AaScope* parent_tpr, string literal_string):
  AaObjectReference(parent_tpr,literal_string) {};
AaConstantLiteralReference::~AaConstantLiteralReference() {};

//---------------------------------------------------------------------
//AaSimpleObjectReference
//---------------------------------------------------------------------
AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, string object_id):AaObjectReference(parent_tpr, object_id) {};
AaSimpleObjectReference::~AaSimpleObjectReference() {};
void AaSimpleObjectReference::Set_Object(AaRoot* obj)
{
  if(obj->Is_Object())
    this->Set_Type(((AaObject*)obj)->Get_Type());
  else if(obj->Is_Expression())
    AaProgram::Add_Type_Dependency(this,obj);
  this->_object = obj;
}


//---------------------------------------------------------------------
// AaArrayObjectReference
//---------------------------------------------------------------------
AaArrayObjectReference::AaArrayObjectReference(AaScope* parent_tpr, 
					       string object_id, 
					       vector<AaExpression*>& index_list):AaObjectReference(parent_tpr,object_id)
{
  for(unsigned int i  = 0; i < index_list.size(); i++)
    this->_indices.push_back(index_list[i]);
}
AaArrayObjectReference::~AaArrayObjectReference()
{
}
void AaArrayObjectReference::Print(ostream& ofile)
{
  ofile << this->Get_Object_Ref_String();
  for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
    {
      ofile << "[";
      this->Get_Array_Index(i)->Print(ofile);
      ofile << "]";
    }
}
AaExpression*  AaArrayObjectReference::Get_Array_Index(unsigned int idx)
{
  assert (idx < this->Get_Number_Of_Indices());
  return(this->_indices[idx]);
}

void AaArrayObjectReference::Set_Object(AaRoot* obj) 
{
  bool ok_flag = false;
  if(obj->Is_Object())
    {
      if(((AaObject*)obj)->Get_Type() && 
	 ((AaObject*)obj)->Get_Type()->Is("AaArrayType"))
	{
	  if(((AaArrayType*)(((AaObject*)obj)->Get_Type()))->Get_Number_Of_Dimensions() == this->_indices.size())
	    {
	      this->_object = obj;
	      this->Set_Type(((AaArrayType*)(((AaObject*)obj)->Get_Type()))->Get_Element_Type());
	      ok_flag = true;
	    }
	}
    }
  if(!ok_flag)
    {
      cerr << "Error: type mismatch in object reference " << this->Get_Object_Ref_String() << " : line " <<
	this->Get_Line_Number() << endl;
      AaRoot::Error();
    }
}


//---------------------------------------------------------------------
// type cast expression (is unary)
//---------------------------------------------------------------------
AaTypeCastExpression::AaTypeCastExpression(AaScope* parent, AaType* ref_type,AaExpression* rest):AaExpression(parent)
{
  this->_to_type = ref_type;
  this->_type = ref_type;
  this->_rest = rest;
}

AaTypeCastExpression::~AaTypeCastExpression() {};
void AaTypeCastExpression::Print(ostream& ofile)
{
  ofile << "( (" ;
  this->Get_To_Type()->Print(ofile);
  ofile << ") ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}


//---------------------------------------------------------------------
// AaUnaryExpression
//---------------------------------------------------------------------
AaUnaryExpression::AaUnaryExpression(AaScope* parent_tpr,AaStringValue* op, AaExpression* rest):AaExpression(parent_tpr)
{
  this->_operation  = op;
  this->_rest       = rest;
  
  AaProgram::Add_Type_Dependency(this,rest);
}
AaUnaryExpression::~AaUnaryExpression() {};
void AaUnaryExpression::Print(ostream& ofile)
{
  ofile << " ( ";
  assert(this->Get_Operation());
  this->Get_Operation()->Print(ofile);
  ofile << " ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}

//---------------------------------------------------------------------
// AaBinaryExpression
//---------------------------------------------------------------------
AaBinaryExpression::AaBinaryExpression(AaScope* parent_tpr,AaStringValue* op, AaExpression* first, AaExpression* second):AaExpression(parent_tpr)
{
  this->_operation = op;

  if(Is_Compare_Operation(op->Get_Value_String()))
    {
      this->Set_Type(AaProgram::Make_Uinteger_Type(1));
      AaProgram::Add_Type_Dependency(first,second);
    }
  else if(Is_Shift_Operation(op->Get_Value_String()))
    {
      AaProgram::Add_Type_Dependency(first,this);
    }
  else
    {
      AaProgram::Add_Type_Dependency(first,this);
      AaProgram::Add_Type_Dependency(second,this);
    }

  this->_first = first;
  this->_second = second;
}
AaBinaryExpression::~AaBinaryExpression() {};
void AaBinaryExpression::Print(ostream& ofile)
{
  ofile << "(" ;
  this->Get_First()->Print(ofile);
  ofile << " ";
  this->Get_Operation()->Print(ofile);
  ofile << " ";
  this->Get_Second()->Print(ofile);
  ofile << ")";
}

//---------------------------------------------------------------------
// AaTernaryExpression
//---------------------------------------------------------------------
AaTernaryExpression::AaTernaryExpression(AaScope* parent_tpr,
					 AaExpression* test,
					 AaExpression* iftrue, 
					 AaExpression* iffalse):AaExpression(parent_tpr)
{
  this->_test = test;
  assert(test->Get_Type() && test->Get_Type()->Is("AaUintType") &&
	 (((AaUintType*)(test->Get_Type()))->Get_Width() == 1));

  if(iftrue)
    AaProgram::Add_Type_Dependency(iftrue,this);
  if(iffalse)
    AaProgram::Add_Type_Dependency(iffalse,this);

  this->_if_true = iftrue;
  this->_if_false = iffalse;
}
AaTernaryExpression::~AaTernaryExpression() {};
void AaTernaryExpression::Print(ostream& ofile)
{
  ofile << "( $mux ";
  this->Get_Test()->Print(ofile);
  ofile << " ";
  this->Get_If_True()->Print(ofile);
  ofile << "  ";
  this->Get_If_False()->Print(ofile);
  ofile << " ) ";
}


//---------------------------------------------------------------------
// AaStatement
//---------------------------------------------------------------------
AaStatement::AaStatement(AaScope* p): AaScope(p) 
{
  this->_tab_depth = ((p != NULL) ? p->Get_Depth() : 0);
}
AaStatement::~AaStatement() {};
string AaStatement::Tab()
{
  return(Tab_(this->Get_Tab_Depth()));
}

// try to map the target of the statement in the scope hierarchy
// rules
//     
//     found    here?    storage/pipe/io   constant    action
//      yes      -            yes           -          nomap
//      yes      -            -            yes         nomap,error
//      no       no           -             -          nomap,error
//      yes      yes          yes           -          nomap
//      no       yes          -             -          map         
//
// \todo: this needs to be cleaned up... still not OK.
//
// 1. get search_scope
// 2. find child starting from search_scope
// 3. if child == NULL and reference is array ref throw error
// 4. if child == NULL and if search_scope != this->Get_Scope() through error
// 5. if child == NULL and reference is not array ref, map child
// 6. if child != NULL and child is of storage/pipe type, dont map, and go on.
// 7. if child != NULL and child is of interface type, check ref count and
//     direction and throw error if appropriate
// 8. if child != NULL and child is not an object declaration then
//     warn and map
void AaStatement::Map_Target(AaObjectReference* obj_ref) 
{
  string obj_ref_root_name =obj_ref->Get_Object_Root_Name();

  AaScope* search_scope = this->Get_Scope()->Get_Ancestor_Scope(obj_ref->Get_Search_Ancestor_Level());
  AaRoot* child = NULL;

  if(search_scope != NULL)
    child = search_scope->Find_Child(obj_ref_root_name);
  else
    child = AaProgram::Find_Object(obj_ref_root_name);

  if(child != NULL)
    child->Add_Target_Reference(obj_ref);
  
  bool is_array_ref = obj_ref->Is("AaArrayObjectReference");

  bool map_flag = ((child == NULL) && (search_scope == this->Get_Scope()) && !(is_array_ref));

  bool err_no_target_in_scope = ((child == NULL) && (is_array_ref || (search_scope != this->Get_Scope())));
  bool err_redeclaration = ((child !=NULL) && !(child->Is("AaStorageObject") || 
						child->Is("AaPipeObject") ||
						child->Is("AaConstantObject") ||
						child->Is("AaInterfaceObject")));
  bool err_write_to_constant = ((child !=NULL) && child->Is("AaConstantObject"));
  bool err_write_to_input_port = ((child != NULL) &&
				  (child->Is("AaInterfaceObject") && 
				   (((AaInterfaceObject*)child)->Get_Mode() == "in")));

  bool err_multiple_refs_to_ports =((child != NULL) &&  
				    child->Is("AaInterfaceObject") && 
				    (child->Get_Number_Of_Target_References() > 1));
  
  
  if(err_no_target_in_scope)
    {
      cerr << "Error: specified target " << obj_ref_root_name << " not found in specified scope: line " << this->Get_Line_Number() << endl;
      AaRoot::Error();
    }
  if(err_redeclaration)
    {
      cerr << "Error: specified target " << obj_ref_root_name << " redeclared: line " << this->Get_Line_Number() << endl;
      AaRoot::Error();
    }
  if(err_write_to_constant)
    {
      cerr << "Error: specified target " << obj_ref_root_name << " is a constant: line " << this->Get_Line_Number() << endl;
      AaRoot::Error();
    }
  if(err_write_to_input_port)
    {
      cerr << "Error: attempted write to module input port " << obj_ref_root_name << " : line " << this->Get_Line_Number() << endl;      
      AaRoot::Error();
    }
  if(err_multiple_refs_to_ports)
    {
      cerr << "Error: multiple writes to module port " << obj_ref_root_name << " : line " << this->Get_Line_Number() << endl;     
      AaRoot::Error();
    }

  if(map_flag)
    {
      this->Get_Scope()->Map_Child(obj_ref_root_name,obj_ref);
      obj_ref->Set_Object(this);
    }
}


//---------------------------------------------------------------------
// AaStatementSequence
//---------------------------------------------------------------------
AaStatementSequence::AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence):AaScope(scope)
{
  for(unsigned int i=0; i < statement_sequence.size();i++)
    {
      AaStatement* stmt = statement_sequence[i];
      this->_statement_sequence.push_back(stmt);
    }
}
AaStatementSequence::~AaStatementSequence() {}
  
void AaStatementSequence::Print(ostream& ofile)
{
  for(unsigned int i=0; i < this->_statement_sequence.size();i++)
    this->_statement_sequence[i]->Print(ofile);
}

//---------------------------------------------------------------------
// AaNullStatement: public AaStatement
//---------------------------------------------------------------------
AaNullStatement::AaNullStatement(AaScope* parent_tpr):AaStatement(parent_tpr) {};
AaNullStatement::~AaNullStatement() {};


//---------------------------------------------------------------------
// AaAssignmentStatement
//---------------------------------------------------------------------
AaAssignmentStatement::AaAssignmentStatement(AaScope* parent_tpr, AaObjectReference* tgt, AaExpression* src, int lineno):
  AaStatement(parent_tpr) 
{
  assert(tgt); assert(src);

  this->Set_Line_Number(lineno);
  this->_target = tgt;
  this->Map_Target(tgt);

  this->_source = src;
}
AaAssignmentStatement::~AaAssignmentStatement() {};
void AaAssignmentStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  this->Get_Target()->Print(ofile);
  ofile << " := ";
  this->Get_Source()->Print(ofile);
  if(this->Get_Target()->Get_Type())
    {
      ofile <<" // type of target is ";
      this->Get_Target()->Get_Type()->Print(ofile);
    }
  ofile << endl;

}
void AaAssignmentStatement::Map_Source_References()
{
  this->_target->Map_Source_References();
  this->_source->Map_Source_References();
  AaProgram::Add_Type_Dependency(this->_target,this->_source);
}


//---------------------------------------------------------------------
// AaCallStatement
//---------------------------------------------------------------------
AaCallStatement::AaCallStatement(AaScope* parent_tpr,
				 string func_name,
				 vector<AaObjectReference*>& inargs, 
				 vector<AaObjectReference*>& outargs,
				 int lineno): AaStatement(parent_tpr)
{

  this->_function_name = func_name;
  this->Set_Line_Number(lineno);

  for(unsigned int i = 0; i < inargs.size(); i++)
    {
      this->_input_args.push_back(inargs[i]);
    }

  for(unsigned int i = 0; i < outargs.size(); i++)
    {
      this->_output_args.push_back(outargs[i]);
      this->Map_Target(outargs[i]);
    }
}
AaCallStatement::~AaCallStatement() {};
  
AaObjectReference* AaCallStatement::Get_Input_Arg(unsigned int index)
{
  assert(index < this->Get_Number_Of_Input_Args());
  return(this->_input_args[index]);
}
AaObjectReference* AaCallStatement::Get_Output_Arg(unsigned int index)
{
  assert(index < this->Get_Number_Of_Output_Args());
  return(this->_output_args[index]);
}
  
void AaCallStatement::Print(ostream& ofile)
{

  ofile << this->Tab();
  ofile << "$call ";


  ofile << this->Get_Function_Name();

  ofile << " (";
  for(unsigned int i = 0; i < this->Get_Number_Of_Input_Args(); i++)
    {
      this->_input_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";

  ofile << " (";
  for(unsigned int i = 0; i < this->Get_Number_Of_Output_Args(); i++)
    {
      this->_output_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")" << endl;

}


void AaCallStatement::Map_Source_References()
{
  AaModule* called_module = AaProgram::Find_Module(this->_function_name);
  if(called_module != NULL)
    {
      AaScope* root_scope = this->Get_Root_Scope();
      assert(root_scope && root_scope->Is("AaModule"));
      AaModule* caller_module = (AaModule*) root_scope;
      AaProgram::Add_Call_Pair(caller_module,called_module);

      if(called_module->Get_Number_Of_Input_Arguments() != this->_input_args.size())
	{
	  cerr << "Error: number of input arguments to called function does not match the number of declared arguments: line " << this->Get_Line_Number() << endl;
	}


      if(called_module->Get_Number_Of_Output_Arguments() != this->_output_args.size())
	{
	  cerr << "Error: number of output arguments to called function does not match the number of declared arguments: line " << this->Get_Line_Number() << endl;
	}
    }
  else
    {
      cerr << "Warning: module " << this->_function_name << " not found, assuming that it is foreign!"<< endl;
    }


  for(unsigned int i=0; i < this->_input_args.size(); i++)
    {
      this->_input_args[i]->Map_Source_References();
      if(called_module != NULL)
	{
	  called_module->Get_Input_Argument(i)->Add_Source_Reference(this->_input_args[i]);
	  this->_input_args[i]->Add_Target_Reference(called_module->Get_Input_Argument(i));
	}
    }
  for(unsigned int i=0; i < this->_output_args.size(); i++)
    {
      this->_output_args[i]->Map_Source_References();
      if(called_module != NULL)
	{
	  called_module->Get_Output_Argument(i)->Add_Target_Reference(this->_output_args[i]);
	  this->_output_args[i]->Add_Source_Reference(called_module->Get_Output_Argument(i));
	}
    }
}


//---------------------------------------------------------------------
// AaBlockStatement: public AaStatement
//---------------------------------------------------------------------
AaBlockStatement::AaBlockStatement(AaScope* scope,string label):AaStatement(scope) 
{
  this->_label = label;
  this->_statement_sequence = NULL;
  if(label != "" && scope != NULL)
    scope->Map_Child(label,this);
}

AaBlockStatement::~AaBlockStatement() {}

void AaBlockStatement::Print(ostream& ofile)
{

  if(this->Get_Label() != "")
    ofile << "[" << this->Get_Label() << "]" << endl;
  else
    ofile << endl;

  ofile << this->Tab() << "{" << endl;
  this->Print_Objects(ofile);
  this->Print_Statement_Sequence(ofile);
  ofile << this->Tab() << "}" << endl;
}

void AaBlockStatement::Map_Source_References()
{
  this->_statement_sequence->Map_Source_References();
}

//---------------------------------------------------------------------
// AaSeriesBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaSeriesBlockStatement::AaSeriesBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaSeriesBlockStatement::~AaSeriesBlockStatement() {}
 void AaSeriesBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$seriesblock";
  this->AaBlockStatement::Print(ofile);
}


//---------------------------------------------------------------------
// AaParallelBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaParallelBlockStatement::AaParallelBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaParallelBlockStatement::~AaParallelBlockStatement() {}
 void AaParallelBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$parallelblock";
  this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
// AaForkBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaForkBlockStatement::AaForkBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaForkBlockStatement::~AaForkBlockStatement() {}
 void AaForkBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$forkblock ";
  this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
// AaBranchBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaBranchBlockStatement::AaBranchBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaBranchBlockStatement::~AaBranchBlockStatement() {}
void AaBranchBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$branchblock ";
  this->AaBlockStatement::Print(ofile);
}

//---------------------------------------------------------------------
//  AaJoinForkStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaJoinForkStatement::AaJoinForkStatement(AaForkBlockStatement* scope):AaBlockStatement(scope,"") {}
AaJoinForkStatement::~AaJoinForkStatement() {}
void AaJoinForkStatement::Print(ostream& ofile) 
{
  ofile << this->Tab();
  ofile << "$join ";
  for(unsigned int i = 0; i < this->_join_labels.size(); i++)
    ofile << this->_join_labels[i] << " ";
  if(this->Get_Statement_Count() > 0)
    {
      ofile << endl << this->Tab();
      ofile << "$and $fork " << endl;
      this->_statement_sequence->Print(ofile);
    }
  ofile << this->Tab();
  ofile << "$endjoin " << endl;
}

//---------------------------------------------------------------------
// AaMergeStatement: public AaStatement
//---------------------------------------------------------------------
AaMergeStatement::AaMergeStatement(AaBranchBlockStatement* scope):AaBlockStatement((AaScope*)scope,"") {}
AaMergeStatement::~AaMergeStatement() {}
void AaMergeStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$merge " ;
  for(unsigned int i=0; i < this->_merge_label_vector.size(); i++)
    { 
      ofile  << this->_merge_label_vector[i] << " ";
    }
  ofile << endl;


  if(this->_statement_sequence != NULL)
    {
      ofile << this->Tab() << endl;
      this->_statement_sequence->Print(ofile);
      ofile << this->Tab() << endl;
    }
  ofile << this->Tab();
  ofile << "$endmerge" << endl ;
}

// AaPhiStatement: public AaStatement
AaPhiStatement::AaPhiStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_target = NULL;
}
AaPhiStatement::~AaPhiStatement() 
{
}

void AaPhiStatement::Print(ostream& ofile)
{
  ofile << this->Tab() << "$phi ";
  this->_target->Print(ofile);
  ofile << " := ";
  if(this->_target->Get_Type())
    {
      ofile <<" // type of target is ";
      this->_target->Get_Type()->Print(ofile);
      ofile << endl;
    }
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      ofile << this->Tab() << "  ";
      this->_source_pairs[i].second->Print(ofile);
      ofile << " $on " << this->_source_pairs[i].first << endl;
    }
  ofile << endl;
}
void AaPhiStatement::Map_Source_References()
{
  this->_target->Map_Source_References();
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      AaProgram::Add_Type_Dependency(this->_target, this->_source_pairs[i].second);

      this->_source_pairs[i].second->Map_Source_References();
      if(this->_source_pairs[i].first != "$entry")
	{
	  AaRoot* child = this->Get_Scope()->Find_Child(this->_source_pairs[i].first);
	  if(child == NULL)
	    {
	      AaRoot::Error();
	      cerr << "Error: could not find place statement with label " << (this->_source_pairs[i].first) 
		   << " : line " << this->Get_Line_Number() << endl;
	    }
	  else if(!child->Is("AaPlaceStatement"))
	    {
	      cerr << "Error: in phi statement, statement with label " << (this->_source_pairs[i].first) 
		   << " is not a place statement : line " << this->Get_Line_Number() << endl;
	      AaRoot::Error();
	    }
	}
    }
}



//---------------------------------------------------------------------
// AaSwitchStatement: public AaStatement
//---------------------------------------------------------------------
AaSwitchStatement::AaSwitchStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_select_expression = NULL;
  this->_default_sequence = NULL;
}
AaSwitchStatement::~AaSwitchStatement() {}
void AaSwitchStatement::Print(ostream& ofile)
{
  assert(this->_select_expression);

  ofile << this->Tab();
  ofile << "$switch ";
  this->_select_expression->Print(ofile);
  ofile << endl;

  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    {
      ofile << this->Tab();
      ofile << "  $when ";
      this->_choice_pairs[i].first->Print(ofile);
      ofile << " $then " << endl;
      this->_choice_pairs[i].second->Print(ofile);
      ofile << endl;
    }

  if(this->_default_sequence)
    {
      ofile << this->Tab() << "  $default " << endl;
      this->_default_sequence->Print(ofile);
      ofile << endl;
    }
  ofile << this->Tab();
  ofile << "$endswitch " << endl;
}


//---------------------------------------------------------------------
// AaIfStatement: public AaStatement
//---------------------------------------------------------------------
AaIfStatement::AaIfStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_test_expression = NULL;
  this->_if_sequence = NULL;
  this->_else_sequence = NULL;
}
AaIfStatement::~AaIfStatement() {}
void AaIfStatement::Print(ostream& ofile)
{
  assert(this->_test_expression);
  assert(this->_if_sequence);

  ofile << this->Tab();
  ofile << "$if ";
  this->_test_expression->Print(ofile);
  ofile << " $then " << endl;
  this->_if_sequence->Print(ofile);
  ofile << endl;
  if(this->_else_sequence)
    {
      ofile << this->Tab() << "$else " << endl;
      this->_else_sequence->Print(ofile);
      ofile << endl;
    }
  ofile << this->Tab() << "$endif" << endl;
}

//---------------------------------------------------------------------
// AaPlaceStatement: public AaStatement
//---------------------------------------------------------------------
AaPlaceStatement::AaPlaceStatement(AaBranchBlockStatement* parent_tpr,string lbl):AaStatement(parent_tpr) 
{
  this->_label = lbl;
  parent_tpr->Map_Child(lbl,this);
};
AaPlaceStatement::~AaPlaceStatement() {};



/***************************************** MODULE   ****************************/

//---------------------------------------------------------------------
// AaModule
//---------------------------------------------------------------------
AaModule::AaModule(string fname): AaBlockStatement(NULL,fname)
{
}

void AaModule::Add_Argument(AaInterfaceObject* obj)
{

  assert(obj);

  this->Map_Child(obj->Get_Name(), obj);

  if(obj->Get_Mode() == "in")
    {
      this->_input_args.push_back(obj);
    }
  else if(obj->Get_Mode() == "out")
    {
      this->_output_args.push_back(obj);
    }
  else
    {
      assert(0 && "unknown interface mode");
    }
}

void AaModule::Print(ostream& ofile)
{
  ofile << "$module [" << this->Get_Label() << "]" << endl;
  ofile << "\t $in (";
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      this->_input_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")" << endl;

  ofile << "\t $out (";
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      this->_output_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";
  ofile << endl;
  ofile << "$is" << endl;
  ofile << "{" << endl;

  // print objects
  this->Print_Objects(ofile);

  // print statement sequence
  this->Print_Statement_Sequence(ofile);

  ofile << "}" << endl;
}

AaRoot* AaModule::Find_Child_Here(string tag)
{
  AaRoot* child = this->AaScope::Find_Child_Here(tag);
  if(child == NULL)
    {
      child = AaProgram::Find_Object(tag);
      if(child == NULL)
	child = AaProgram::Find_Module(tag);
    }
  return(child);
}


void AaModule::Map_Source_References()
{
  this->AaBlockStatement::Map_Source_References();
}




