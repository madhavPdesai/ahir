using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
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

bool Is_Shift_Operation(AaOperation op)
{
  return(op == __SHL || op == __SHR);
}
bool Is_Compare_Operation(AaOperation op)
{
  return(op == __LESS || op == __GREATER || op == __LESSEQUAL || op == __GREATEREQUAL 
	 || op == __EQUAL || op == __NOTEQUAL);
}

string C_Name(AaOperation op)
{
  string ret_string = "__undefined";
  switch(op)
    {
    case __OR:
      ret_string = "__OR";
      break;
    case __AND:
      ret_string = "__AND";
      break;
    case __NOR:
      ret_string = "__NOR";
      break;
    case __NAND:
      ret_string = "__NAND";
      break;
    case __XOR:
      ret_string = "__XOR";
      break;
    case __XNOR:
      ret_string = "__XNOR";
      break;
    case __SHL:
      ret_string = "__SHL";
      break;
    case __SHR:
      ret_string = "__SHL";
      break;
    case __PLUS:
      ret_string = "__PLUS";
      break;
    case __MINUS:
      ret_string = "__MINUS";
      break;
    case __DIV:
      ret_string = "__DIV";
      break;
    case __MUL:
      ret_string = "__MUL";
      break;
    case __EQUAL:
      ret_string = "__EQUAL";
      break;
    case __NOTEQUAL:
      ret_string = "__NOTEQUAL";
      break;
    case __LESS:
      ret_string = "__LESS";
      break;
    case __LESSEQUAL:
      ret_string = "__LESSEQUAL";
      break;
    case __GREATER:
      ret_string = "__GREATER";
      break;
    case __GREATEREQUAL:
      ret_string = "__GREATEREQUAL";
      break;
    case __NOT:
      ret_string = "__NOT";
      break;
    default:
      cerr << "Error: unrecognized operation" << endl;
    }
  return(ret_string);
}

string Aa_Name(AaOperation op)
{
  string ret_string = "__undefined";
  switch(op)
    {
    case __OR:
      ret_string = "$or";
      break;
    case __AND:
      ret_string = "$and";
      break;
    case __NOR:
      ret_string = "$nor";
      break;
    case __NAND:
      ret_string = "$nand";
      break;
    case __XOR:
      ret_string = "$xor";
      break;
    case __XNOR:
      ret_string = "$xnor";
      break;
    case __SHL:
      ret_string = ">>";
      break;
    case __SHR:
      ret_string = "<<";
      break;
    case __PLUS:
      ret_string = "+";
      break;
    case __MINUS:
      ret_string = "-";
      break;
    case __DIV:
      ret_string = "/";
      break;
    case __MUL:
      ret_string = "*";
      break;
    case __EQUAL:
      ret_string = "==";
      break;
    case __NOTEQUAL:
      ret_string = "!=";
      break;
    case __LESS:
      ret_string = "<";
      break;
    case __LESSEQUAL:
      ret_string = "<=";
      break;
    case __GREATER:
      ret_string = ">";
      break;
    case __GREATEREQUAL:
      ret_string = ">=";
      break;
    case __NOT:
      ret_string = "$not";
      break;
    default:
      cerr << "Error: unrecognized operation" << endl;
    }
  return(ret_string);
}

//---------------------------------------------------------------------
// AaRoot
//---------------------------------------------------------------------
int AaRoot::_root_counter = 0;
bool AaRoot::_error_flag = false;
bool AaRoot::_warning_flag = false;

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
void AaRoot::Error(string msg,AaRoot* r) 
{ 
  cerr << "Error: " << msg;
  if(r != NULL)
    cerr << " :line " << r->Get_Line_Number();
  cerr << endl;
  AaRoot::_error_flag = true;
}
void AaRoot::Warning(string msg,AaRoot* r) 
{ 
  cerr << "Warning: " << msg;
  if(r != NULL)
    cerr << " :line " << r->Get_Line_Number();
  cerr << endl;
  AaRoot::_warning_flag = true;
}

bool AaRoot::Get_Error_Flag() { return AaRoot::_error_flag; }
bool AaRoot::Get_Warning_Flag() { return AaRoot::_warning_flag; }

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


string AaScope::Get_Struct_Dereference()
{
  string ret_string;

  if(this->Get_Scope() == NULL)
    ret_string = "(*" + AaProgram::Get_Top_Struct_Variable_Name() + ")";
  else if (this->Get_Label() != "")
    ret_string = this->Get_Scope()->Get_Struct_Dereference() + "." + this->Get_Label();
  else 
    ret_string = this->Get_Scope()->Get_Struct_Dereference();

  return(ret_string);
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
  return((this->Get_Scope() != NULL) ? Tab_(this->Get_Scope()->Get_Depth()+1) : Tab_(0));
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
  ofile << "$storage ";
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
  ofile << "$pipe ";
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
  ofile << "$constant ";
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

void AaObjectReference::Map_Source_References(set<AaRoot*>& source_objects)
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
      AaRoot::Error("did not find object reference " + this->Get_Object_Ref_String(), this);
    }
  else
    {
      // child -> obj_ref
      if(child != this)
	{
	  this->Set_Object(child);
	  
	  child->Add_Source_Reference(this);  // child -> this (this uses child as a source)
	  this->Add_Target_Reference(child);  // this  -> child (child uses this as a target)

	  if(child->Is_Object())
	    source_objects.insert(child);
	}
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

void AaObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  if(this->Get_Object()->Is_Object())
    {
      if(((AaObject*)(this->Get_Object()))->Get_Scope() != NULL)
	ofile << tab_string 
	      << ((AaObject*)this->Get_Object())->Get_Scope()->Get_Struct_Dereference()
	      << ".";
    }
}
//---------------------------------------------------------------------
// AaConstantLiteralReference: public AaObjectReference
//---------------------------------------------------------------------
AaConstantLiteralReference::AaConstantLiteralReference(AaScope* parent_tpr, 
						       string literal_string,
						       vector<string>& literals):
  AaObjectReference(parent_tpr,literal_string) 
{
  for(unsigned int i= 0; i < literals.size(); i++)
    this->_literals.push_back(literals[i]);
};
AaConstantLiteralReference::~AaConstantLiteralReference() {};
void AaConstantLiteralReference::PrintC(ofstream& ofile, string tab_string)
{
  ofile << tab_string;
  if(this->_literals.size() > 0)
    {
      ofile << "{ ";
      ofile << this->_literals[0];
      for(unsigned int i= 1; i < this->_literals.size(); i++)
	ofile << ", " << this->_literals[i];
      ofile << "} ";
    }
  else
    {
      ofile << this->Get_Object_Ref_String() << " ";
    }
}

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
void AaSimpleObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name();
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
      AaRoot::Error("type mismatch in object reference " + this->Get_Object_Ref_String(),this);
    }
}


void AaArrayObjectReference::Map_Source_References(set<AaRoot*>& source_objects)
{
  this->AaObjectReference::Map_Source_References(source_objects);
  for(unsigned int i=0; i < this->_indices.size(); i++)
    this->_indices[i]->Map_Source_References(source_objects);
}

void AaArrayObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name();
  for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
    {
      ofile << "[";
      this->Get_Array_Index(i)->PrintC(ofile,"");
      ofile << "]";
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
AaUnaryExpression::AaUnaryExpression(AaScope* parent_tpr,AaOperation op, AaExpression* rest):AaExpression(parent_tpr)
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
  ofile << Aa_Name(this->Get_Operation());
  ofile << " ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}

//---------------------------------------------------------------------
// AaBinaryExpression
//---------------------------------------------------------------------
AaBinaryExpression::AaBinaryExpression(AaScope* parent_tpr,AaOperation op, AaExpression* first, AaExpression* second):AaExpression(parent_tpr)
{
  this->_operation = op;

  if(Is_Compare_Operation(op))
    {
      this->Set_Type(AaProgram::Make_Uinteger_Type(1));
      AaProgram::Add_Type_Dependency(first,second);
    }
  else if(Is_Shift_Operation(op))
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
  ofile << Aa_Name(this->Get_Operation());
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





