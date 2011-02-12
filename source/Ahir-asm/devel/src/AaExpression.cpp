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


/***************************************** EXPRESSION  ****************************/
//---------------------------------------------------------------------
// AaExpression
//---------------------------------------------------------------------
AaExpression::AaExpression(AaScope* parent_tpr):AaRoot() 
{
  this->_scope = parent_tpr;
  this->_type = NULL; // will be determined by dependency traversal
  this->_expression_value = NULL; // if constant will be calculated in Evaluate traversal.
}
AaExpression::~AaExpression() {};

void AaExpression::Set_Type(AaType* t)
{
  if(this->_type == NULL)
    {
      this->_type = t;
      for(set<AaExpression*>::iterator siter = this->_targets.begin();
	  siter != this->_targets.end();
	  siter++)
	{
	  AaExpression* ref = *siter;
	  if(ref->Is("AaBinaryExpression"))
	    ((AaBinaryExpression*)ref)->Update_Type();
	}
    }
  else
    {
      if(t != this->_type)
	{
	  string err_msg = "Error: type of expression ";
	  this->Print(err_msg);
	  err_msg += " is ambiguous, is it  ";
	  this->_type->Print(err_msg);
	  err_msg += " or ";
	  t->Print(err_msg);
	  err_msg += " ? ";
	  AaRoot::Error(err_msg, this);
	}
    }
}

string AaExpression::Get_VC_Name()
{
  string ret_string = this->Kind() + "_" + Int64ToStr(this->Get_Index());
  return(ret_string);
}

void AaExpression::Write_VC_Control_Path(ostream& ofile)
{
  ofile << ";;[" << this->Get_VC_Name() << "] {"
	<< "$T [dummy] " << endl
	<< "}" << endl;
}

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
  assert(this->Get_Object());

  if(this->Get_Object()->Is_Object())
    {// this refers to an object
      if(((AaObject*)(this->Get_Object()))->Get_Scope() != NULL)
	ofile << ((AaObject*)this->Get_Object())->Get_Scope()->Get_Struct_Dereference();
    }
  else if(this->Get_Object()->Is_Statement())
    {// this refers to a statement
      ofile << this->Get_Scope()->Get_Struct_Dereference();
    }
  else if(this->Get_Object()->Is_Expression())
    { // this refers to an object reference?
      ofile << ((AaExpression*)this->Get_Object())->Get_Scope()->Get_Struct_Dereference();
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

void AaConstantLiteralReference::Write_VC_Control_Path( ostream& ofile)
{
  // null region.
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
    {
      AaProgram::Add_Type_Dependency(this,obj);
      this->Add_Target((AaExpression*) obj);
    }
  this->_object = obj;
}
void AaSimpleObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  ofile << "(";
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name() << ").__val";
}

void AaSimpleObjectReference::Write_VC_Control_Path( ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {
      // else, if the object being referred to is 
      // a storage object, then it is a load operation,
      // instantiate a series r-a-r-a chain..
      // if is_store is set, instantiate a store operation
      // as well.
      if(this->_object->Is("AaStorageObject"))
	{
	  
	  ofile << ";;[" << this->Get_VC_Name() << "] { // load: " << ps  << endl;
	  ofile << "$T [rr] $T [ra] $T[cr] $T[ca]" << endl;
	  ofile << "}" << endl;
	}
      
      
      // else if the object being referred to is
      // a pipe, instantiate a series r-a
      // chain for the inport operation
      else if(this->_object->Is("AaPipeObject"))
	{
	  ofile << ";;[" << this->Get_VC_Name() << "] { // pipe read: " << ps << endl;
	  ofile << "$T [req] $T [ack] " << endl;
	  ofile << "}" << endl;
	}
    }
}


void AaSimpleObjectReference::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  // else, if the object being referred to is 
  // a storage object, then it is a load operation,
  // instantiate a series r-a-r-a chain..
  // if is_store is set, instantiate a store operation
  // as well.
  if(this->_object->Is("AaStorageObject"))
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // store operation" << endl;
      ofile << "$T [srr] $T [sra] $T[scr] $T[sca]" << endl;
      ofile << "}" << endl;
    }


  // else if the object being referred to is
  // a pipe, instantiate a series r-a
  // chain for the inport operation
  else if(this->_object->Is("AaPipeObject"))
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // pipe write operation" << endl;
      ofile << "$T [pipe_wreq] $T [pipe_wack] " << endl;
      ofile << "}" << endl;
    }
}

bool AaSimpleObjectReference::Is_Constant()
{
  return(this->_object->Is_Constant());
}

bool AaSimpleObjectReference::Is_Implicit_Variable_Reference()
{
  return(!this->_object->Is("AaStorageObject") && !this->_object->Is("AaPipeObject") &&
	 !this->_object->Is("AaConstantObject"));
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
  ofile << "(";
  ofile << this->Get_Object_Ref_String();
  for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
    {
      ofile << "[";
      this->Get_Array_Index(i)->Print(ofile);
      ofile << "]";
    }
  ofile << ").__val";
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
  ofile << "(";
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name();
  for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
    {
      ofile << "[";
      this->Get_Array_Index(i)->PrintC(ofile,"");
      ofile << "]";
    }
  ofile << ").__val";
}

void AaArrayObjectReference::Write_VC_Control_Path( ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {
      // else, if the object being referred to is 
      // a storage object, then it is a load operation,
      // instantiate a series r-a-r-a chain..
      if(this->_object->Is("AaStorageObject") || this->_object->Is("AaConstantObject"))
	{
	  
	  ofile << ";;[" << this->Get_VC_Name() << "] { // array object reference: " << ps << endl;
	  this->Write_VC_Address_Gen_Control_Path(ofile);
	  ofile << "$T [rr] $T [ra] $T[cr] $T[ca]" << endl;
	  ofile << "}" << endl;
	}
      // this should never happen!
      else
	{
	  AaRoot::Error("illegal array reference", this);
	}
    }
}


void AaArrayObjectReference::Write_VC_Address_Gen_Control_Path(ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  ofile << ";;[" << this->Get_VC_Name() << "_AddressGen] { // address generation for " << ps << endl;

  // in parallel, compute each of the indices..
  ofile << "// calculate index1 = idx1*dim1, index2 = idx2*dim2 ... " << endl;
  ofile << "||[" << this->Get_VC_Name() << "_IndexGen] { // indices" << endl;
  for(int idx = 0; idx < _indices.size(); idx++)
    {
      _indices[idx]->Write_VC_Control_Path(ofile);
    }
  ofile << "}" << endl;
  
  // followed by a computation of the address
  // as a weighted sum of the computed indices..
  if(_indices.size() > 1)
    {
      AaRoot::Error("Aa2VC currently does not support multiple dimensional arrays", this);
      //\todo:  need to instantiate a tree of adders here..
    }

  // followed by a base + index*step
  ofile << "// addr = (index*step) + base" << endl;
  ofile << "$T [mrr] $T [mra] $T [mcr] $T [mca] // multiply by constant." << endl;
  ofile << "$T [arr] $T [ara] $T [acr] $T [aca] // add base " << endl;

  ofile << "}" << endl;
}

void AaArrayObjectReference::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  this->Write_VC_Control_Path(ofile);
}


bool AaArrayObjectReference::Is_Constant()
{
  bool ret_val = (this->_object->Is_Constant());
  for(int idx = 0; idx < _indices.size(); idx++)
    ret_val = ret_val && _indices[idx]->Is_Constant();
  return(ret_val);
}

//---------------------------------------------------------------------
// type cast expression (is unary)
//---------------------------------------------------------------------
AaTypeCastExpression::AaTypeCastExpression(AaScope* parent, AaType* ref_type,AaExpression* rest):AaExpression(parent)
{
  this->_to_type = ref_type;
  this->_type = ref_type;
  this->_rest = rest;
  if(rest)
    rest->Add_Target(this);
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


void AaTypeCastExpression::Write_VC_Control_Path(ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // type-cast expression: " << ps << endl;
      
      this->_rest->Write_VC_Control_Path(ofile);

      // if object referred to is a constant, then
      // print a null control-path
      if(this->_rest->Is_Constant() || (this->_to_type == _rest->Get_Type()))
	{
	  ofile << "$T [req] $T [ack] // update expression result. " << endl;
	}
      // int-to-int conversion:  r-a pair
      else if(this->_to_type->Is_Integer_Type() && _rest->Get_Type()->Is_Integer_Type())
	{
	  ofile << "$T [req] $T [ack] // int->int conversion " << endl;
	}
      // int-to-float or float-to-int conversion: r-a-r-a pair.
      else
	{
	  ofile << "$T [rr] $T [ra] $T [cr] $T [ca] // int<->float conversion. " << endl;
	}
      ofile << "}" << endl;
    }
}


//---------------------------------------------------------------------
// AaUnaryExpression
//---------------------------------------------------------------------
AaUnaryExpression::AaUnaryExpression(AaScope* parent_tpr,AaOperation op, AaExpression* rest):AaExpression(parent_tpr)
{
  this->_operation  = op;
  this->_rest       = rest;
  
  AaProgram::Add_Type_Dependency(this,rest);
  if(rest)
    rest->Add_Target(this);
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

void AaUnaryExpression::Write_VC_Control_Path(ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // unary expression: " << ps << endl;
      this->_rest->Write_VC_Control_Path(ofile);
      ofile << "$T [req] $T [ack] // variable update" << endl;
      ofile << "}" << endl;
    }
}

//---------------------------------------------------------------------
// AaBinaryExpression
//---------------------------------------------------------------------
AaBinaryExpression::AaBinaryExpression(AaScope* parent_tpr,AaOperation op, AaExpression* first, AaExpression* second):AaExpression(parent_tpr)
{
  this->_operation = op;

  if(Is_Bitsel_Operation(op))
    { // bitsel: the output is always a single bit
      // there is no dependence betweem the two 
      // inputs
      this->Set_Type(AaProgram::Make_Uinteger_Type(1));
    }
  else if(Is_Compare_Operation(op))
    {
      this->Set_Type(AaProgram::Make_Uinteger_Type(1));
      AaProgram::Add_Type_Dependency(first,second);
    }
  else if(Is_Shift_Operation(op))
    {
      AaProgram::Add_Type_Dependency(first,this);
    }
  else if(!Is_Concat_Operation(op))
    {
      AaProgram::Add_Type_Dependency(first,this);
      AaProgram::Add_Type_Dependency(second,this);
    }

  this->_first = first;
  if(first)
    first->Add_Target(this);
  this->_second = second;
  if(second)
    second->Add_Target(this);

  this->Update_Type();
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

void AaBinaryExpression::Update_Type()
{
  if(Is_Concat_Operation(this->_operation) && (this->Get_Type() == NULL))
    {
      // check the types of both sources.
      // they must both be uintegers and
      // the type of this expression must
      // be a uinteger whose width is the
      // sume of those of the sources.
      AaType* t1 = this->Get_First()->Get_Type();
      AaType* t2 = this->Get_Second()->Get_Type();

      if(t1 != NULL && t2 != NULL)
	{
	  if(t1->Is("AaUintType") && t2->Is("AaUintType"))
	    {
	      AaType* nt = AaProgram::Make_Uinteger_Type(((AaUintType*)t1)->Get_Width()+((AaUintType*)t2)->Get_Width());
	      this->AaExpression::Set_Type(nt);
	    }
	  else
	    {
	      AaRoot::Error("source arguments of concatenate expression must have uint types",this);
	    }
	}
    }
}


bool AaBinaryExpression::Is_Trivial()
{
  if(this->_operation == __OR || this->_operation == __AND ||
     this->_operation == __NOR || this->_operation == __NAND ||
     this->_operation == __XOR || this->_operation == __XNOR ||
     this->_operation == __CONCAT || this->_operation == __BITSEL)
    return(true);
  else
    return(false);

}

void AaBinaryExpression::Write_VC_Control_Path(ostream& ofile)
{

  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // binary expression: " << ps << endl;

      ofile << "||[" << this->Get_VC_Name() << "_inputs] { " << endl;
      this->_first->Write_VC_Control_Path(ofile);
      this->_second->Write_VC_Control_Path(ofile);
      ofile << "}" << endl;

      if(this->Is_Trivial())
	{
	  ofile << "$T [req] $T [ack] // trivial (unitary) binary operation" << endl;
	}
      else
	{
	  ofile << "$T [rr] $T [ra] $T [cr] $T [ca] // non-trivial (split) binary operation " << endl;
	}    
      ofile << "}" << endl;
    }
}



//---------------------------------------------------------------------
// AaTernaryExpression
//---------------------------------------------------------------------
AaTernaryExpression::AaTernaryExpression(AaScope* parent_tpr,
					 AaExpression* test,
					 AaExpression* iftrue, 
					 AaExpression* iffalse):AaExpression(parent_tpr)
{

  assert(test != NULL);

  
  this->_test = test;
  test->Add_Target(this);

  assert(test->Get_Type() && test->Get_Type()->Is("AaUintType") &&
	 (((AaUintType*)(test->Get_Type()))->Get_Width() == 1));

  if(iftrue)
    {
      AaProgram::Add_Type_Dependency(iftrue,this);
      iftrue->Add_Target(this);
    }
  if(iffalse)
    {
      AaProgram::Add_Type_Dependency(iffalse,this);
      iffalse->Add_Target(this);
    }

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

void AaTernaryExpression::Write_VC_Control_Path(ostream& ofile)
{

  // if _test is constant, print dummy.
  string ps;
  this->AaRoot::Print(ps);
  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // ternary expression: " << ps << endl;
      ofile << "||[" << this->Get_VC_Name() << "_inputs] { " << endl;
      this->_test->Write_VC_Control_Path(ofile);
      if(this->_if_true)
	this->_if_true->Write_VC_Control_Path(ofile);

      if(this->_if_false)
	this->_if_false->Write_VC_Control_Path(ofile);
      ofile << "}" << endl;

      ofile << "$T [req] $T [ack] // select req/ack" << endl;
      ofile << "}" << endl;
    }
}





