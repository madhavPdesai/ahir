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
#include <Aa2VC.h>

/***************************************** EXPRESSION  ****************************/
//---------------------------------------------------------------------
// AaExpression
//---------------------------------------------------------------------
AaExpression::AaExpression(AaScope* parent_tpr):AaRoot() 
{
  this->_scope = parent_tpr;
  this->_type = NULL; // will be determined by dependency traversal
  this->_expression_value = NULL; // if constant will be calculated in Evaluate traversal.
  this->_already_evaluated = false;
  this->_addressed_object_representative = NULL;
  this->_coalesce_flag = false;
}
AaExpression::~AaExpression() {};

bool AaExpression::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
  bool new_flag = false;

  if(obj == NULL)
    return(new_flag);

  if(this->_addressed_object_representative == NULL)
   {
     new_flag = true;
     this->_addressed_object_representative = obj;
   }
 else
   {
     if(obj != this->_addressed_object_representative)
       {
	 AaProgram::Add_Storage_Dependency(obj,this->_addressed_object_representative);
       }
   }
  return(new_flag);
}


void AaExpression::Propagate_Addressed_Object_Representative()
{
  if(!this->Get_Coalesce_Flag())
    {
      this->Set_Coalesce_Flag(true);

      AaStorageObject* obj = this->Get_Addressed_Object_Representative();
      
      // propagate to all that are targets of this expression.
      for(set<AaExpression*>::iterator iter = _targets.begin();
	  iter != _targets.end();
	  iter++)
	{
	  (*(iter))->Propagate_Addressed_Object_Representative(obj);
	}
      
      // propagate to all objects that use this 
      // expression as a source.
      for(set<AaRoot*>::iterator iter = _source_references.begin();
	  iter != _source_references.end();
	  iter++)
	{
	  if((*iter)->Is_Object())
	    ((AaObject*)(*iter))->Propagate_Addressed_Object_Representative(obj);
	}

      this->Set_Coalesce_Flag(false);
    }
}

void AaExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{
  this->Set_Addressed_Object_Representative(obj);
  this->Propagate_Addressed_Object_Representative();

}

void AaExpression::Set_Type(AaType* t)
{
  if(this->_type == NULL)
    {
      this->_type = t;

      // all expressions of which this is the target may need
      // to recompute their types.
      for(set<AaExpression*>::iterator siter = this->_targets.begin();
	  siter != this->_targets.end();
	  siter++)
	{
	  AaExpression* ref = *siter;
	  ref->Update_Type();
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
   string ret_string = "expr_" + Int64ToStr(this->Get_Index());
   return(ret_string);
 }

 void AaExpression::Write_VC_Control_Path(ostream& ofile)
 {
   ofile << "// " << this->To_String() << endl;

   ofile << ";;[" << this->Get_VC_Name() << "] {"
	 << "$T [dummy] " << endl
	 << "}" << endl;
 }

void AaExpression::Assign_Expression_Value(AaValue* expr_value)
{
  AaValue* nv = Make_Aa_Value(this->Get_Scope(),this->Get_Type());
  nv->Assign(this->Get_Type(),expr_value);
  _expression_value = nv;
}

//---------------------------------------------------------------------
// AaObjectReference
//---------------------------------------------------------------------
AaObjectReference::AaObjectReference(AaScope* parent_tpr, string object_id):AaExpression(parent_tpr)
{
  this->_object_ref_string = object_id;
  this->_search_ancestor_level = 0; 
  this->_object = NULL;
}

AaObjectReference::~AaObjectReference() {};
void AaObjectReference::Print(ostream& ofile)
{
  ofile << this->Get_Object_Ref_String();
}

AaType* AaObjectReference::Get_Object_Type()
{
  AaType* ret_type = NULL;
  if(this->_object)
    {
      if(this->_object->Is_Object())
	ret_type = ((AaObject*)(this->_object))->Get_Type();
      else if(this->_object->Is_Expression())
	ret_type = ((AaExpression*)(this->_object))->Get_Type();
    }
  return(ret_type);
}

// return -1 if not evaluatable.
int AaObjectReference::Evaluate(vector<AaExpression*>* indices, vector<int>* scale_factors)
{
  bool address_is_const = true;
  int address_offset = 0;
  if(indices != NULL)
    {
      for(int idx = 0; idx < indices->size(); idx++)
	{
	  if(!(*indices)[idx]->Is_Constant())
	    address_is_const = false;
	  else
	    {
	      address_offset += (*indices)[idx]->Get_Expression_Value()->To_Integer() *
		(*scale_factors)[idx];
	    }
	}
    }
  if(address_is_const)
    return(address_offset);
  else
    return(-1);
}

void AaObjectReference::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{
  this->AaExpression::Propagate_Addressed_Object_Representative(obj);
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

	  if(child->Is_Expression())
	    ((AaExpression*)child)->Add_Target(this);

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

void AaObjectReference::Evaluate()
{
  assert(0); // should never ever be called..
}

AaType* AaObjectReference::Get_Address_Type(vector<AaExpression*>* address_expressions)
{
  AaType* addr_type = NULL;
  if(this->_object->Get_Type()->Is_Pointer_Type())
    {
      addr_type = this->_object->Get_Type()->Get_Element_Type(0,*address_expressions);
    }
  else
    {
      assert(this->Get_Address_Width() > 0);
      addr_type =  AaProgram::Make_Uinteger_Type(this->Get_Address_Width());
    }
  return(addr_type);
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
  if(this->Get_Type() && !this->Get_Type()->Is_Array_Type())
    {
      if(this->_literals.size() > 0)    
	ofile << this->_literals[0] << " ";
      else
	ofile << this->Get_Object_Ref_String() << " ";
    }
  else
    {      
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
}

void AaConstantLiteralReference::Write_VC_Control_Path( ostream& ofile)
{
  // null region.
}

void AaConstantLiteralReference::Evaluate()
{
  if(!_already_evaluated)
    {
      assert(this->_type);
      _expression_value = Make_Aa_Value(this->Get_Scope(), this->Get_Type(), _literals);
      _already_evaluated = true;
    }
}

void AaConstantLiteralReference::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;

  Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				this->Get_Type(),
				this->_expression_value,
				ofile);
}

//---------------------------------------------------------------------
//AaSimpleObjectReference
//---------------------------------------------------------------------
AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, string object_id):AaObjectReference(parent_tpr, object_id) {};
AaSimpleObjectReference::~AaSimpleObjectReference() {};
void AaSimpleObjectReference::Set_Object(AaRoot* obj)
{
  if(obj->Is_Object())
    {
      if(((AaObject*)obj)->Get_Type())
	{
	  AaType* obj_type = ((AaObject*)obj)->Get_Type();
	  this->Set_Type(obj_type);
	}
    }
  else if(obj->Is_Expression())
    {
      AaProgram::Add_Type_Dependency(this,obj);

      // if obj is an expression, then 
      // obj drives this..
      // (otherwise, it would be 
      ((AaExpression*) obj)->Add_Target(this);
    }
  this->_object = obj;
}

void AaSimpleObjectReference::Print_AddressOf_C(ofstream& ofile, string tab_string)
{
  ofile << "(&(";
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name() << "))";
}

void AaSimpleObjectReference::Print_BaseStructRef_C(ofstream& ofile, string tab_string)
{
  ofile << "(";
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name() << ")";

}
void AaSimpleObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  this->Print_BaseStructRef_C(ofile,tab_string);
  if(!this->Get_Type()->Is_Pointer_Type())
    ofile << ".__val";
}

string AaSimpleObjectReference::Get_VC_Driver_Name()
{
  if(this->_object == NULL)
    {// implicit variable.
      return(this->AaExpression::Get_VC_Driver_Name());
    }
  else if(this->_object->Is_Object())
    {
      // if it points to an object, get the object's name
      // to avoid double declaration...
      if(this->_object->Is("AaInterfaceObject"))
	return(this->_object->Get_VC_Name());
      else
	return(this->AaExpression::Get_VC_Driver_Name());
    }
  else if(this->_object->Is_Expression())
    {
      return(((AaExpression*)this->_object)->Get_VC_Driver_Name());
    }
  else if(this->_object->Is_Statement())
    {
      return(To_Alphanumeric(this->_object_ref_string) + "_" + Int64ToStr(this->_object->Get_Index()));
    }
  else
    assert(0);
}

string AaSimpleObjectReference::Get_VC_Receiver_Name()
{
  // _object can be either an expression.
  if(this->_object == NULL)
    {
      return(this->AaExpression::Get_VC_Receiver_Name());
    }
  else if(this->_object->Is_Object())
    {
      if(this->_object->Is("AaInterfaceObject"))
	return(this->_object->Get_VC_Name());
      else
	return(this->AaExpression::Get_VC_Receiver_Name());
    }
  else if(this->_object->Is_Expression())
    {
      return(((AaExpression*)this->_object)->Get_VC_Receiver_Name());
    }
  else if(this->_object->Is_Statement())
    {
      return(To_Alphanumeric(this->_object_ref_string) + "_" + Int64ToStr(this->_object->Get_Index()));
    }
  else
    assert(0);
}


string AaSimpleObjectReference::Get_VC_Constant_Name()
{
  if(this->_object == NULL)
    {// implicit variable.
      return(this->AaExpression::Get_VC_Constant_Name());
    }
  else if(this->_object->Is_Object())
    {
      // if it points to an object, get the object's name
      // to avoid double declaration...
      if(this->_object->Is("AaInterfaceObject"))
	return(this->_object->Get_VC_Name());
      else
	return(this->AaExpression::Get_VC_Constant_Name());
    }
  else if(this->_object->Is_Expression())
    {
      return(((AaExpression*)this->_object)->Get_VC_Constant_Name());
    }
  else if(this->_object->Is_Statement())
    {
      return(To_Alphanumeric(this->_object_ref_string) + "_" + Int64ToStr(this->_object->Get_Index()));
    }
  else
    assert(0);
}


void AaSimpleObjectReference::Write_VC_Control_Path( ostream& ofile)
{


  if(!this->Is_Constant())
    {

      // if this is a statement...
      if(this->Is_Implicit_Variable_Reference())
	{
	  // do nothing..
	}
      // else, if the object being referred to is 
      // a storage object, then it is a load operation,
      // instantiate a series r-a-r-a chain..
      // if is_store is set, instantiate a store operation
      // as well.
      else if(this->_object->Is("AaStorageObject"))
	{
	  this->Write_VC_Load_Control_Path(NULL,NULL,ofile);
	}
      // else if the object being referred to is
      // a pipe, instantiate a series r-a
      // chain for the inport operation
      else if(this->_object->Is("AaPipeObject"))
	{
	  ofile << "// " << this->To_String() << endl;

	  ofile << ";;[" << this->Get_VC_Name() << "] { // pipe read" << endl;
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
  if(this->_object == NULL)
    {
      // nothing.
    }
  else if(this->_object->Is("AaStorageObject"))
    {

      // address calculation..
      // several parallel stores will be peformed..
      // must compute all of them..

      // followed by several parallel stores..
      // note that you will need a split operation here
      this->Write_VC_Store_Control_Path(NULL,NULL,ofile);
    }
  // else if the object being referred to is
  // a pipe, instantiate a series r-a
  // chain for the inport operation
  else if(this->_object->Is("AaPipeObject"))
    {
      ofile << "// " << this->To_String() << endl;
      ofile << ";;[" << this->Get_VC_Name() << "] { // pipe write ";
      this->Print(ofile);
      ofile << endl;
      ofile << "$T [pipe_wreq] $T [pipe_wack] " << endl;
      ofile << "}" << endl;
    }
}

bool AaSimpleObjectReference::Is_Implicit_Object() 
{
  return(this->_object == NULL);
}

// return true if the expression points
// to an implicitly defined variable reference.
// (either a statement or an interface object).
bool AaSimpleObjectReference::Is_Implicit_Variable_Reference()
{
  return((this->_object == NULL) ||
	 this->_object->Is("AaInterfaceObject") ||
	 this->_object->Is_Statement() ||
	 (this->_object->Is_Expression() && 
	  ((AaExpression*)this->_object)->Is_Implicit_Variable_Reference()));
}

void AaSimpleObjectReference::Update_Type()
{
  AaRoot* obj = _object;
  if((this->Get_Type() == NULL) &&  (obj != NULL) && obj->Is_Expression())
    {
      this->Set_Type(((AaExpression*)obj)->Get_Type());
    }
}


void AaSimpleObjectReference::Evaluate()
{
  if(this->_object && this->_object->Is_Expression())
    ((AaExpression*)(this->_object))->Evaluate();

  if(this->_object && this->_object->Is_Constant())
    {
      if(this->_object->Is("AaConstantObject"))
	{
	  this->Assign_Expression_Value(((AaConstantObject*)_object)->Get_Expression_Value());
	}
      else if(this->_object->Is_Expression())
	{
	  this->Assign_Expression_Value(((AaExpression*)_object)->Get_Expression_Value());
	}
    }
}


void AaSimpleObjectReference::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  if(this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				  this->Get_Type(),
				  this->Get_Expression_Value(),
				  ofile);



}
void AaSimpleObjectReference::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  if(!skip_immediate && !this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    {
      Write_VC_Wire_Declaration(this->Get_VC_Driver_Name(),
				this->Get_Type(),
				ofile);
    }

  if(!this->Is_Constant() && this->_object->Is("AaStorageObject"))
    {
      this->Write_VC_Load_Store_Constants(NULL,NULL,ofile);
      this->Write_VC_Load_Store_Wires(NULL,NULL,ofile);
    }
}

void AaSimpleObjectReference::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{

  if(!this->Is_Constant() )
    {

      // if _object is a statement, declare it, otherwise not.
      if(this->_object->Is_Statement())
	{
	  Write_VC_Wire_Declaration(this->Get_VC_Receiver_Name(),
				    this->Get_Type(),
				    ofile);
	}


      if(this->_object->Is("AaStorageObject"))
	{
	  this->Write_VC_Load_Store_Constants(NULL,NULL,ofile);
	  this->Write_VC_Load_Store_Wires(NULL,NULL,ofile);
	}
    }
}

void AaSimpleObjectReference:: Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source) 
{
  if(!this->Is_Constant()  && !this->Is_Implicit_Variable_Reference())
    {
      if(this->_object->Is("AaStorageObject"))
	{
	  this->Write_VC_Store_Data_Path(NULL,
					 NULL,
					 (source != NULL ? source : this),
					 ofile);
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  string src_name =  source->Get_VC_Driver_Name();
	  // io write.
	  Write_VC_IO_Output_Port((AaPipeObject*) this->_object,
				  this->Get_VC_Datapath_Instance_Name(),
				  src_name,
				  ofile);
	}
    }
}

void AaSimpleObjectReference:: Write_VC_Datapath_Instances(AaExpression* target,  ostream& ofile) 
{
  if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    {
      if(this->_object->Is("AaStorageObject"))
	{
	  this->Write_VC_Load_Data_Path(NULL,
					NULL,
					(target != NULL ? target : this),
					ofile);
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  // io write.
	  Write_VC_IO_Input_Port((AaPipeObject*) this->_object,
				 this->Get_VC_Datapath_Instance_Name(),
				 (target != NULL ? target->Get_VC_Driver_Name() : this->Get_VC_Receiver_Name()),
				 ofile);
	}
    }
}
void AaSimpleObjectReference::Write_VC_Links(string hier_id, ostream& ofile) 
{
  if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    {
      ofile << "// " << this->To_String() << endl;


      vector<string> reqs;
      vector<string> acks;

      if(this->_object->Is("AaStorageObject"))
	{
	  this->Write_VC_Load_Links(hier_id,NULL,NULL,ofile);
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  string inst_name = this->Get_VC_Datapath_Instance_Name();
	  reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/req");
	  acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/ack");
	  Write_VC_Link(inst_name, reqs,acks,ofile);
	}
    }
}
void AaSimpleObjectReference:: Write_VC_Links_As_Target(string hier_id, ostream& ofile) 
{
  if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
    {

      ofile << "// " << this->To_String() << endl;
      vector<string> reqs;
      vector<string> acks;

      if(this->_object->Is("AaStorageObject"))
	{
	  this->Write_VC_Store_Links(hier_id,NULL,NULL,ofile);
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  string inst_name = this->Get_VC_Datapath_Instance_Name();
	  reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/pipe_wreq");
	  acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/pipe_wack");
	  Write_VC_Link(inst_name, reqs,acks,ofile);
	}
    }
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


// Object reference by indexing into a composite
// object or into a pointer to a composite object.
// (this keeps us consistent with LLVM).
void AaArrayObjectReference::Set_Object(AaRoot* obj) 
{
  bool ok_flag = false;
  int index_size = _indices.size();
  AaType* obj_type = NULL;
  if(obj->Is_Object())
    {
      this->_object = obj;
      obj_type = ((AaObject*)obj)->Get_Type();

      // if the root of indexed expression is 
      // a pointer object, then this object must
      // first be fetched.  To do so we keep
      // a SimpleObjectReference to this object.
      if(obj_type->Is_Pointer_Type())
	{
	  _pointer_ref = new AaSimpleObjectReference(this->Get_Scope(), ((AaObject*)obj)->Get_Name());
	  _pointer_ref->Set_Object(obj);
	  _pointer_ref->Add_Target(this);
	}
    }
  else if(obj->Is_Expression())
    {
      this->_object = obj;
      obj_type = ((AaExpression*)obj)->Get_Type();
    }
  else
    {
      AaRoot::Error("array object references must index an object or expression",this);
    }
  
  if(obj_type != NULL)
    {
      this->Set_Type(obj_type->Get_Element_Type(0,_indices));
    }


}


void AaArrayObjectReference::Update_Type()
{
  AaRoot* obj = this->_object;
  int index_size = _indices.size();
  if((this->Get_Type() == NULL) &&  (obj != NULL) && obj->Is_Expression())
    {
      AaType* obj_type = ((AaExpression*)obj)->Get_Type();
      if(obj_type->Is("AaPointerType"))
	{
	  AaType* ref_type = ((AaPointerType*)obj_type)->Get_Ref_Type();
	  if(index_size > 1)
	    ref_type = (ref_type->Get_Element_Type(1,_indices));
	  this->Set_Type(AaProgram::Make_Pointer_Type(ref_type));
	}
      else if(obj_type->Is_Composite_Type())
	{
	  this->Set_Type(obj_type->Get_Element_Type(0,_indices));	       
	}
      else
	{
	  AaRoot::Error("cannot index an expression unless it has a pointer/array/record type",this);
	}
    }
}

void AaArrayObjectReference::Map_Source_References(set<AaRoot*>& source_objects)
{
  this->AaObjectReference::Map_Source_References(source_objects);
  for(unsigned int i=0; i < this->_indices.size(); i++)
    this->_indices[i]->Map_Source_References(source_objects);
}

void AaArrayObjectReference::Evaluate()
{
  AaArrayType* at = NULL;
  AaType* t = NULL;
  if(this->_object->Is_Expression())
    {
      t = ((AaExpression*)(this->_object))->Get_Type();
    }
  else if(this->_object->Is_Object())
    {
      t = ((AaObject*)(this->_object))->Get_Type();
    }
   
  if(!_already_evaluated)
    {
      _already_evaluated = true;
      bool all_indices_constants = true;
      vector<int> index_vector;
      for(int idx = 0; idx < _indices.size(); idx++)
	{
	  // need to evaluate the indices!
	  if(!_indices[idx]->Get_Type())
	    {
	      _indices[idx]->Set_Type(AaProgram::Make_Uinteger_Type(AaProgram::_pointer_width));
	    }
	  _indices[idx]->Evaluate();
	   
	   
	  if(!_indices[idx]->Is_Constant())
	    {
	      all_indices_constants = false;
	    }
	  else
	    index_vector.push_back(_indices[idx]->Get_Expression_Value()->To_Integer());
	}
       
      AaValue* expr_value = NULL;
      if(this->_object->Is_Expression())
	{
	  ((AaExpression*)this->_object)->Evaluate();
	  expr_value =  ((AaExpression*)this->_object)->Get_Expression_Value();
	}
      else if(this->_object->Is_Object() && this->_object->Is_Constant())
	{
	  expr_value = ((AaObject*)(this->_object))->Get_Value()->Get_Expression_Value();
	}
       
      if(!all_indices_constants || !this->_object->Is_Constant())
	return;
       
      assert(expr_value != NULL);
      if(!t->Is_Pointer_Type())
	this->Assign_Expression_Value(expr_value->Get_Element(index_vector));
      else 
	{
	  //
	  // what is being calculated is a pointer..
	  // if ptr is pointer to array[2] of int.
	  // ptr[1][2] is a pointer with value
	  //  = ptr + (1*sizeof(*ptr)) + (2*sizeof(*ptr[i])). etc.
	  // we need this to match llvm's getElementPtr.
	  // because the result of pointer arithmetic at the AA
	  // level is not known until storage coalescion has been
	  // completed.
	  //
	  AaStorageObject* rep = this->Get_Addressed_Object_Representative();
	  assert(rep != NULL);

	  int word_size = rep->Get_Word_Size();

	  // ok...  
	  int ret_int_val = this->_object->Get_Expression_Value()->To_Integer();
	  vector<int> scale_factors;
	  
	  this->Update_Address_Scaling_Factors(scale_factors,word_size);
	  for(int idx = 0; idx < _indices.size(); idx++)
	    {
	      int indx_val  = _indices[idx]->Get_Expression_Value()->To_Integer();
	      ret_int_val += (indx_val*scale_factors[idx]);
	    }

	  expr_value = Make_Aa_Value(this->Get_Scope(),t);
	  expr_value->Set_Value(IntToStr(ret_int_val));

	  this->Assign_Expression_Value(expr_value);
	  delete expr_value;
	}
    }
}

void AaArrayObjectReference::Update_Address_Scaling_Factors(vector<int>& scale_factors, int word_size)
{

  AaType* t = NULL;
  if(this->_object->Is_Expression())
    {
      t = ((AaExpression*)(this->_object))->Get_Type();
    }
  else if(this->_object->Is_Object())
    {
      t = ((AaObject*)(this->_object))->Get_Type();
    }

  int residual_size;
  vector<AaExpression*> index_prefix;
  for(int idx = 0; idx < _indices.size(); idx++)
    {
      index_prefix.push_back(_indices[idx]);
      if(t->Is_Pointer_Type())
	{
	  AaType* ref_type = ((AaPointerType*)t)->Get_Ref_Type();
	 
	  if(idx == 0)
	    residual_size = ref_type->Size()/word_size;
	  else
	    residual_size = ref_type->Get_Element_Type(1,index_prefix)->Size()/word_size;

	  scale_factors.push_back(residual_size);
	}
      else if(t->Is_Composite_Type())
	{
	  residual_size = t->Get_Element_Type(0,index_prefix)->Size()/word_size;

	  scale_factors.push_back(residual_size);
	}
    }
}

void AaArrayObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  this->Print_BaseStructRef_C(ofile,tab_string);
  if(!this->Get_Type()->Is_Pointer_Type())
    ofile << ".__val";
}

void AaArrayObjectReference::Print_AddressOf_C(ofstream& ofile, string tab_string)
{
  ofile << "(&(";
  this->AaObjectReference::PrintC(ofile,tab_string);
  ofile << this->Get_Object_Root_Name();
  for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
    {
      ofile << "[";
      this->Get_Array_Index(i)->PrintC(ofile,"");
      ofile << "]";
    }
  ofile << "))";
}

void AaArrayObjectReference::Print_BaseStructRef_C(ofstream& ofile, string tab_string)
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
  ofile << ")";
}

// TODO: most cases seem to be ok.  However,
// if object A has type array of pointer to array of pointers,
// then what does A[0][1][2][3] mean?
//    A[0]  will be a pointer to array of pointers.
// thus A[0][1] will be a pointer to array of pointers.
//      A[0][1][2] will be a pointer to a pointer.
//      A[0][1][2][3] will be a pointer to a pointer?
//
//  
// the other interpretation is to disallow a reference
// to A[0][1] altogether..  
// 
//
void AaArrayObjectReference::Write_VC_Control_Path( ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);


      if(this->Get_Object_Type()->Is_Pointer_Type())
	{
	  if(this->_object->Is_Storage_Object())
	    {
	      // please load the object.
	      this->_pointer_ref->Write_VC_Control_Path(ofile);
	    }

	  // the return value is a pointer,
	  // but this is only an address calculation.
	  ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;
	  this->Write_VC_Root_Address_Calculation_Control_Path(&_indices,
							       &scale_factors,
							       ofile);
	  ofile << "$T [final_reg_req] $T [final_reg_ack]" << endl;
	  ofile << "}" << endl;
	}
      else
	{ 
	  // this is just a regular object load
	  // using the indices, which returns the
	  // value stored at the computed address.
	  this->Write_VC_Load_Control_Path(&(_indices),
					   &scale_factors,
					   ofile);
	}
    }
}


void AaArrayObjectReference::Write_VC_Address_Gen_Control_Path(ostream& ofile)
{
  assert(0); // should never be called..
}

void AaArrayObjectReference::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;

  if(this->_object->Is("AaStorageObject"))
    {
      int word_size = ((AaStorageObject*)(this->_object))->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      this->Write_VC_Store_Control_Path(&(_indices),&(scale_factors), ofile);
    }
  else
    {
      // a target can only be an indexed storage object.
      assert(0);
    }
}

 
void AaArrayObjectReference::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;

  if(this->Is_Constant())
    {
      
      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    {
      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      // base pointer.. will need to be declared?
      // certainly..
      if(this->_object->Is_Expression())
	{
	  ((AaExpression*)this->_object)->Write_VC_Constant_Wire_Declarations(ofile);
	}

      if(this->Get_Object_Type()->Is_Pointer_Type())
	{
	  if(this->_object->Is_Storage_Object())
	    {
	      // the object needs to be loaded..  
	      // do the needful..
	      this->_pointer_ref->Write_VC_Constant_Wire_Declarations(ofile);
	    }

	  // the return value is a pointer,
	  // calculate the address (exactly as in the address-of expression,
	  // but with _pointer_ref providing the base).
	  this->Write_VC_Root_Address_Calculation_Constants(this->Get_Index_Vector(),
							    &scale_factors,
							    ofile);
	}
      else
	this->Write_VC_Load_Store_Constants(this->Get_Index_Vector(),&scale_factors,ofile);
    }
}

void AaArrayObjectReference::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  if(this->Is_Constant())
    return;

  ofile << "// " << this->To_String() << endl;
  
  
  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);


  // base pointer.. will need to be declared?
  // certainly..
  if(this->_object->Is_Expression())
    {
      ((AaExpression*)this->_object)->Write_VC_Wire_Declarations(false,ofile);
    }

  if(this->Get_Object_Type()->Is_Pointer_Type())
    {
      if(this->_object->Is_Storage_Object())
	{
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Wire_Declarations(false,ofile);
	}
      
      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Wires(this->Get_Index_Vector(),
						    &scale_factors,
						    ofile);
    }
  else
    this->Write_VC_Load_Store_Wires(this->Get_Index_Vector(),
				  &scale_factors,
				  ofile);

  
  // the final load-data.
  if(!skip_immediate)
    Write_VC_Wire_Declaration(this->Get_VC_Driver_Name(),
			      this->Get_Type(),
			      ofile);
}

int AaObjectReference::Get_Word_Size()
{
  assert(this->_object);
  int word_size = -1;

  if(this->_object->Is("AaStorageObject"))
    word_size = ((AaStorageObject*)(this->_object))->Get_Word_Size();
  else if(this->_object->Is_Expression())
    {
      assert(((AaExpression*)(this->_object))->Get_Addressed_Object_Representative() != NULL);
      word_size = ((AaExpression*)(this->_object))->Get_Addressed_Object_Representative()->Get_Word_Size();
    }
  
  assert(word_size  > 0);
  return(word_size);
}


void AaArrayObjectReference::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{
  if(this->Is_Constant())
    return;
  
  assert(this->_object->Is("AaStorageObject"));
  
  ofile << "// " << this->To_String() << endl;



  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);
  
  this->Write_VC_Load_Store_Wires(this->Get_Index_Vector(),
				  &scale_factors,
				  ofile);
}

void AaArrayObjectReference::Write_VC_Datapath_Instances_As_Target(ostream& ofile, AaExpression* source)
{
  
  if(this->Is_Constant())
    return;
  
  assert(this->_object && this->_object->Is("AaStorageObject"));
  
  ofile << "// " << this->To_String() << endl;

  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);

  this->Write_VC_Store_Data_Path(&_indices,
				 &scale_factors,
				 (source ? source : this),
				 ofile);
}

void AaArrayObjectReference::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
  
  if(this->Is_Constant())
    return;
  

  ofile << "// " << this->To_String() << endl;

  
  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);

  if(this->Get_Object_Type()->Is_Pointer_Type())
    {
      if(this->_object->Is_Storage_Object())
	{
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Datapath_Instances(NULL,ofile);
	}
      
      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Data_Path(this->Get_Index_Vector(),
							&scale_factors,
							ofile);

      // final register.
      Write_VC_Unary_Operator( __NOP,
			       this->Get_VC_Name() + "_final_reg",
			       this->Get_VC_Root_Address_Name(),
			       this->Get_Address_Type(this->Get_Index_Vector()),
			       (target != NULL ? target->Get_VC_Receiver_Name() : 
				this->Get_VC_Driver_Name()),
			       this->Get_Type(),
			       ofile);
			      
    }
  else
    this->Write_VC_Load_Data_Path(this->Get_Index_Vector(),
				&scale_factors,
				(target ? target : this),
				ofile);
}

void AaArrayObjectReference::Write_VC_Links(string hier_id, ostream& ofile)
{


  if(this->Is_Constant())
    return;
  
  ofile << "// " << this->To_String() << endl;


  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);


  if(this->Get_Object_Type()->Is_Pointer_Type())
    {
      hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());

      if(this->_object->Is_Storage_Object())
	{
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Links(hier_id,ofile);
	}
      
      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Links(hier_id,
						    this->Get_Index_Vector(),
						    &scale_factors,
						    ofile);

      vector<string> reqs;
      vector<string> acks;
      reqs.push_back(hier_id + "/final_reg_req");
      acks.push_back(hier_id + "/final_reg_ack");
      Write_VC_Link(this->Get_VC_Name() + "_final_reg",
		    reqs,
		    acks,
		    ofile);
    }
  else
    this->Write_VC_Load_Links(hier_id,
			      this->Get_Index_Vector(),
			      &scale_factors,
			      ofile);
}
  
void AaArrayObjectReference::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
    
  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);

  this->Write_VC_Store_Links(hier_id,
			     &_indices,
			     &scale_factors,
			     ofile);
}

//---------------------------------------------------------------------
// AaPointerDereferenceExpression
//---------------------------------------------------------------------
AaPointerDereferenceExpression::AaPointerDereferenceExpression(AaScope* scope, 
							       AaObjectReference* obj_ref):
  AaObjectReference(scope,obj_ref->Get_Object_Ref_String())
{
  _reference_to_object = obj_ref;
  
  obj_ref->Add_Target(this);
  AaProgram::Add_Storage_Dependency_Graph_Vertex(this);
}



void AaPointerDereferenceExpression::Print(ostream& ofile)
{
  ofile << "->(";
  this->_reference_to_object->Print(ofile);
  ofile << ")";
  
  if(_addressed_object_representative == NULL)
    {
      AaRoot::Error("illegal pointer-dereference expression... not associated with any memory space!", this);
    }
}
  
void AaPointerDereferenceExpression::PrintC(ofstream& ofile, string tab_string)
{
  ofile << "(" << this->_reference_to_object->Get_Type()->CPointerDereference();
  this->_reference_to_object->Print_BaseStructRef_C(ofile,tab_string);
  ofile << ")";
  if(this->_reference_to_object->Get_Type()->Is_Pointer_Type())
    {
      if(!(((AaPointerType*)(_reference_to_object->Get_Type()))->Get_Ref_Type()->Is_Pointer_Type()))
	ofile << ".__val ";
    }
}

void AaPointerDereferenceExpression::Map_Source_References(set<AaRoot*>& source_objects)
{
  this->_reference_to_object->Map_Source_References(source_objects);
  if(this->_reference_to_object->Get_Type())
    {
      if(!this->_reference_to_object->Get_Type()->Is("AaPointerType"))
	{
	  AaRoot::Error("cannot dereference an object whose type is not a pointer!", this);
	}
      else
	{
	  this->Set_Type(((AaPointerType*)this->_reference_to_object->Get_Type())->Get_Ref_Type());
	}
    }
}

void AaPointerDereferenceExpression::Update_Type()
{
  if(_reference_to_object->Get_Type() != NULL)
    {
      if(_reference_to_object->Get_Type()->Is_Pointer_Type())
	{
	  AaType* t = (((AaPointerType*)(_reference_to_object->Get_Type()))->Get_Ref_Type());
	  if(this->_type != NULL && (t != this->_type))
	    {
	      AaRoot::Error("type ambiguity in pointer dereference expression", this);
	    }
	  else if(this->_type == NULL)
	    this->Set_Type(t);
	}
    }
  else if(this->_type != NULL)
    {
      AaType* t = AaProgram::Make_Pointer_Type(this->_type);
      _reference_to_object->Set_Type(t);
    }
}

void AaPointerDereferenceExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{
  if(!this->Get_Coalesce_Flag())
    {
      this->Set_Coalesce_Flag(true);
      if((obj != NULL) && this->Get_Addressed_Object_Representative() == NULL)
	{
	  AaProgram::Add_Storage_Dependency(this,obj);
	}
      
      this->Set_Addressed_Object_Representative(obj);
      
      // broken.. fix it..
      // what should you propagate forward?
      // _reference_to_object points to a pointer p.
      // p has an addressed object representative obj1.
      // obj1 has an addressed object representative obj2.
      // ->(p) propagates obj2
      AaStorageObject* obj1 = _reference_to_object->Get_Addressed_Object_Representative();
      if(obj1 != NULL)
	{
	  AaStorageObject* obj2 = obj1->Get_Addressed_Object_Representative();
	  if(obj2 != NULL)
	    {
	      // propagate to all expressions that are targets of this expression.
	      for(set<AaExpression*>::iterator iter = _targets.begin();
		  iter != _targets.end();
		  iter++)
		{
		  (*(iter))->Propagate_Addressed_Object_Representative(obj2);
		}
	    }
	}
      this->Set_Coalesce_Flag(false);
    }
}

void AaPointerDereferenceExpression::Write_VC_Control_Path( ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;
  this->_reference_to_object->Write_VC_Control_Path(ofile);
  this->Write_VC_Load_Control_Path(NULL,NULL,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  this->_reference_to_object->Write_VC_Control_Path(ofile);
  this->Write_VC_Store_Control_Path(NULL,NULL,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;
  this->_reference_to_object->Write_VC_Constant_Wire_Declarations(ofile);
  this->Write_VC_Load_Store_Constants(NULL,NULL,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  if(!skip_immediate)
    {
     
      if(!skip_immediate)
	{
	  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
						 this->Get_Type(),
						 ofile);
	}
    }
  this->_reference_to_object->Write_VC_Wire_Declarations(false,ofile);
  this->Write_VC_Load_Store_Wires(NULL,NULL,ofile);
}
void AaPointerDereferenceExpression::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;
  this->_reference_to_object->Write_VC_Wire_Declarations(false,ofile);  
  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
					 this->Get_Type(),
					 ofile);
  this->Write_VC_Load_Store_Wires(NULL,NULL,ofile);
}
void AaPointerDereferenceExpression::Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source)
{
  ofile << "// " << this->To_String() << endl;
  this->_reference_to_object->Write_VC_Datapath_Instances(NULL, ofile);  
  // address will arrive from base.
  this->Write_VC_Store_Data_Path(NULL,
				 NULL,
				 ((source != NULL) ? source : this),
				 ofile);
}
void AaPointerDereferenceExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{ 

  ofile << "// " << this->To_String() << endl;
  this->_reference_to_object->Write_VC_Datapath_Instances(NULL, ofile);  
  this->Write_VC_Load_Data_Path(NULL,
				NULL,
				((target != NULL) ? target : this),
				ofile);
}
void AaPointerDereferenceExpression::Write_VC_Links(string hier_id, ostream& ofile)
{ 
  this->_reference_to_object->Write_VC_Links(hier_id,ofile);
  this->Write_VC_Load_Links(hier_id,
			    NULL,
			    NULL,
			    ofile);
}
void AaPointerDereferenceExpression::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{ 
  this->_reference_to_object->Write_VC_Links(hier_id,ofile);
  this->Write_VC_Store_Links(hier_id,
			     NULL,
			     NULL,
			     ofile);
}

//---------------------------------------------------------------------
// AaAddressOfExpression
//---------------------------------------------------------------------
AaAddressOfExpression::AaAddressOfExpression(AaScope* scope, AaObjectReference* obj_ref): 
  AaObjectReference(scope,obj_ref->Get_Object_Ref_String())
{
  _reference_to_object = obj_ref;
  obj_ref->Add_Target(this);
  this->_storage_object = NULL; // filled in during Map Source References.
}


void AaAddressOfExpression::Print(ostream& ofile)
{
  ofile << "@(";
  this->_reference_to_object->Print(ofile);
  ofile << ")";
  if(_addressed_object_representative == NULL)
    {
      AaRoot::Error("illegal address-of expression... unknown memory space!", this);
    }
}


void AaAddressOfExpression::PrintC(ofstream& ofile, string tab_string)
{
  ofile << "(&";
  this->_reference_to_object->Print_BaseStructRef_C(ofile,tab_string);
  ofile << ") " << endl;
}


void AaAddressOfExpression::Map_Source_References(set<AaRoot*>& source_objects)
{
  this->_reference_to_object->Map_Source_References(source_objects);

  if((this->_reference_to_object->Get_Object() == NULL )
     || (!this->_reference_to_object->Get_Object()->Is("AaStorageObject")))
    {
      AaRoot::Error("address-of expression must refer to a storage object",this);
    }

  // this expression definitely points to a storage object...
  AaStorageObject* obj = (AaStorageObject*) (_reference_to_object->Get_Object());
  this->_storage_object = obj;

  if(this->_reference_to_object->Get_Type())
    {
      AaType* ref_obj_type = this->_reference_to_object->Get_Type();
      if(ref_obj_type->Is_Scalar_Type())
	this->Set_Type(AaProgram::Make_Pointer_Type(this->_reference_to_object->Get_Type()));
      else
	this->Set_Type(AaProgram::Make_Pointer_Type(this->_reference_to_object->Get_Type()));
    }
}


void AaAddressOfExpression::Update_Type()
{
  if(_reference_to_object->Get_Type() != NULL)
    {
      AaType* t = AaProgram::Make_Pointer_Type(_reference_to_object->Get_Type());
      if(this->_type != NULL && (t != this->_type))
	{
	  AaRoot::Error("type ambiguity in address-of expression", this);
	}
      else if(this->_type == NULL)
	this->Set_Type(t);
    }
}


void AaAddressOfExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{

  // @(p) always propagates forward, because
  // _storage_object may have an updated 
  // representative..
  this->Set_Addressed_Object_Representative(this->_storage_object);
  this->AaExpression::Propagate_Addressed_Object_Representative();

}


void AaAddressOfExpression::Evaluate()
{
  if(this->_storage_object == NULL)
    {
      AaRoot::Error("did not find storage object to take address-of: ", this);
    }
  else
    {
      int addr = -1;
      if(this->_reference_to_object->Is("AaSimpleObjectReference"))
	{
	  addr = this->_storage_object->Get_Base_Address();
	}
      else if(this->_reference_to_object->Is("AaArrayObjectReference"))
	{
	  AaArrayObjectReference* obj_ref = 
	    (AaArrayObjectReference*)(this->_reference_to_object);
	  
	  obj_ref->Evaluate();

	  int word_size = obj_ref->Get_Word_Size();
	  vector<int> scale_factors;
	  obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

	  int offset_value = obj_ref->AaObjectReference::Evaluate(obj_ref->Get_Index_Vector(),
								  &scale_factors);
	  if(offset_value >= 0)
	    {
	      addr = this->_storage_object->Get_Base_Address() + offset_value;
	    }
	}
      else
	{
	  assert(0);
	}

      if(addr >= 0)
	{
	  AaValue* v = Make_Aa_Value(this->Get_Scope(),this->Get_Type());
	  v->Set_Value(IntToStr(addr));
	  this->_expression_value = v;
	}
    }
}

// this is a half-load.  The address up to the 
// final root address is calculated.  However,
// individual word addresses are not calculated..
void AaAddressOfExpression::Write_VC_Control_Path( ostream& ofile)
{ 
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      assert(this->_reference_to_object->Is("AaArrayObjectReference"));

      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);


      ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;

      obj_ref->Write_VC_Root_Address_Calculation_Control_Path(obj_ref->Get_Index_Vector(),
							      &scale_factors,
							      ofile);

      ofile << "$T [final_reg_req] $T [final_reg_ack]" << endl;
      ofile << "}" << endl;
							      
    }
}


void AaAddressOfExpression::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  // can never happen
  assert(0); 
}
void AaAddressOfExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{ 

  ofile << "// " << this->To_String() << endl;

  if(this->Is_Constant())
    {
      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    {
      assert(this->_reference_to_object->Is("AaArrayObjectReference"));

      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

      obj_ref->Write_VC_Root_Address_Calculation_Constants(obj_ref->Get_Index_Vector(),
							   &scale_factors,
							   ofile);
    }
}
void AaAddressOfExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{ 
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      if(!skip_immediate)
	{
	  Write_VC_Wire_Declaration(this->Get_VC_Driver_Name(),
				    this->Get_Type()->Get_VC_Name(),
				    ofile);
	}

      assert(this->_reference_to_object->Is("AaArrayObjectReference"));
      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

      // this calculates a final root address..
      // it will be named obj_ref->Get_VC_Root_Address_Name();
      obj_ref->Write_VC_Root_Address_Calculation_Wires(obj_ref->Get_Index_Vector(),
						       &scale_factors,
						       ofile);
    }
}
void AaAddressOfExpression::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{ 
  assert(0); 
}
void AaAddressOfExpression::Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source)
{ 
  // can never happen
  assert(0); 
}

// this is needless repetition, but is a half load/store operation..
// the address up to the actual word-accesses is calculated..
void AaAddressOfExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{ 
  if(!this->Is_Constant())
    {
      assert(this->_reference_to_object->Is("AaArrayObjectReference"));

      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

      obj_ref->Write_VC_Root_Address_Calculation_Data_Path(obj_ref->Get_Index_Vector(),
							  &scale_factors,
							  ofile);
      
      AaType* addr_type  = AaProgram::Make_Uinteger_Type(_storage_object->Get_Address_Width());

      Write_VC_Unary_Operator(__NOP,
			      this->Get_VC_Name() + "_final_reg",
			      obj_ref->Get_VC_Root_Address_Name(),
			      addr_type,
			      ((target != NULL) ? target->Get_VC_Driver_Name() :
			       this->Get_VC_Driver_Name()),
			      ((target != NULL) ? target->Get_Type() :
			       this->Get_Type()),
			      ofile);
    }
}
void AaAddressOfExpression::Write_VC_Links(string hier_id, ostream& ofile)
{ 
  if(this->Is_Constant())
    return;
  else
    {
      assert(this->_reference_to_object->Is("AaArrayObjectReference"));
      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);



      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
      obj_ref->Write_VC_Root_Address_Calculation_Links(hier_id,
						       obj_ref->Get_Index_Vector(),
						       &scale_factors,
						       ofile);
						       
      vector<string> reqs;
      vector<string> acks;
      reqs.push_back(hier_id + "/final_reg_req");
      acks.push_back(hier_id + "/final_reg_ack");
      Write_VC_Link(this->Get_VC_Name() + "_final_reg",
		    reqs,
		    acks,
		    ofile);
    }
}
void AaAddressOfExpression::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{ 
  // can never happen..
  assert(0); 
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
  ofile << "( $cast (" ;
  this->Get_To_Type()->Print(ofile);
  ofile << ") ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}


void AaTypeCastExpression::PrintC(ofstream& ofile, string tab_string)
{
  if(this->_rest->Get_Type() && this->_rest->Get_Type()->Is("AaPointerType"))
    ofile << tab_string << "(" << "(" << this->_to_type->CBaseName() << ") ";
  else
    ofile << tab_string << "(" << "(" << this->_to_type->CName() << ") ";

  this->_rest->PrintC(ofile,"");
  ofile << ")";
}


void AaTypeCastExpression::Write_VC_Control_Path(ostream& ofile)
{
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;
      
      ofile << ";;[" << this->Get_VC_Name() << "] { // type-cast expression" << endl;
      this->_rest->Write_VC_Control_Path(ofile);
      ofile << "$T [req] $T [ack] //  type-conversion.. " << endl;
      ofile << "}" << endl;
    }
}

void AaTypeCastExpression::Evaluate()
{
  if(!_already_evaluated)
    {
      _already_evaluated = true;
      this->_rest->Evaluate();
      if(this->_rest->Is_Constant())
	this->Assign_Expression_Value(this->_rest->Get_Expression_Value());
    }
}

void AaTypeCastExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  if(this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    {
      this->_rest->Write_VC_Constant_Wire_Declarations(ofile);
    }
}
void AaTypeCastExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  if(!this->Is_Constant())
    {
      this->_rest->Write_VC_Wire_Declarations(false,ofile);

      if(!skip_immediate)
	{

	  ofile << "// " << this->To_String() << endl;
	  
	  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
						 this->Get_Type(),
						 ofile);
	}
    }
}

void AaTypeCastExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_rest->Write_VC_Datapath_Instances(NULL,ofile);

      if(!this->Get_Type()->Is_Uinteger_Type() && 
	 !this->_rest->Get_Type()->Is_Uinteger_Type())
	{
	  AaRoot::Error("For vc2vhdl, type-cast operations not yet correctly implemented except for $uint -> $uint conversions",this);
	}


      ofile << "// " << this->To_String() << endl;


      Write_VC_Unary_Operator(__NOP,
			      this->Get_VC_Datapath_Instance_Name(),
			      this->_rest->Get_VC_Driver_Name(),
			      this->_rest->Get_Type(),
			      (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name()),
			      this->Get_Type(),
			      ofile);
    }
}

void AaTypeCastExpression::Write_VC_Links(string hier_id, ostream& ofile)
{



  if(!this->Is_Constant())
    {

      this->_rest->Write_VC_Links(hier_id + "/" + this->Get_VC_Name(), ofile);


      ofile << "// " << this->To_String() << endl;
      
      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/" +this->Get_VC_Name() + "/req");
      acks.push_back(hier_id + "/" +this->Get_VC_Name() + "/ack");
      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
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
  ofile << "( ";
  ofile << Aa_Name(this->Get_Operation());
  ofile << " ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}

void AaUnaryExpression::Write_VC_Control_Path(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  

  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // unary expression " << endl;
      this->_rest->Write_VC_Control_Path(ofile);
      ofile << "$T [rr] $T [ra] $T [cr] $T [ca] //(split) unary operation" << endl;
      ofile << "}" << endl;
    }
}


void AaUnaryExpression::Evaluate()
{
  if(!_already_evaluated)
    {
      _already_evaluated = true;
      this->_rest->Evaluate();
      if(this->_rest->Is_Constant())
	this->Assign_Expression_Value(Perform_Unary_Operation(this->_operation, 
							      this->_rest->Get_Expression_Value()));
      
    }
}

void AaUnaryExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  if(this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    this->_rest->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaUnaryExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_rest->Write_VC_Wire_Declarations(false,ofile);



      if(!skip_immediate)
	{

	  ofile << "// " << this->To_String() << endl;

	  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
						 this->Get_Type(),
						 ofile);
	}

    }

}
void AaUnaryExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
  if(!this->Is_Constant())
    {


      this->_rest->Write_VC_Datapath_Instances(NULL,ofile);


      ofile << "// " << this->To_String() << endl;


      Write_VC_Unary_Operator(this->Get_Operation(),
			      this->Get_VC_Datapath_Instance_Name(),
			      this->_rest->Get_VC_Driver_Name(),
			      this->_rest->Get_Type(),
			      (target != NULL ? target->Get_VC_Receiver_Name() : 
			       this->Get_VC_Receiver_Name()),
			      (target != NULL ? target->Get_Type() : this->Get_Type()),
			      ofile);
    }

}
void AaUnaryExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_rest->Write_VC_Links(hier_id + "/" + this->Get_VC_Name(), ofile);

      ofile << "// " << this->To_String() << endl;

      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/" +this->Get_VC_Name() + "/rr");
      reqs.push_back(hier_id + "/" +this->Get_VC_Name() + "/cr");
      acks.push_back(hier_id + "/" +this->Get_VC_Name() + "/ra");
      acks.push_back(hier_id + "/" +this->Get_VC_Name() + "/ca");
      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
    }
}

//---------------------------------------------------------------------
// AaBinaryExpression
//---------------------------------------------------------------------
AaBinaryExpression::AaBinaryExpression(AaScope* parent_tpr,AaOperation op, AaExpression* first, AaExpression* second):AaExpression(parent_tpr)
{
  this->_operation = op;

  this->_first = first;
  if(first)
    first->Add_Target(this);
  this->_second = second;
  if(second)
    second->Add_Target(this);

 
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
  else if(Is_Bitsel_Operation(this->_operation) || Is_Shift_Operation(this->_operation))
    {
      if((this->_second->Get_Type() == NULL) && (this->_first->Get_Type() != NULL))
	{
	  this->_second->Set_Type(AaProgram::Make_Uinteger_Type(CeilLog2(this->_first->Get_Type()->Size()-1)));
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

  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      ofile << ";;[" << this->Get_VC_Name() << "] { // binary expression " << endl;

      ofile << "||[" << this->Get_VC_Name() << "_inputs] { " << endl;
      this->_first->Write_VC_Control_Path(ofile);
      this->_second->Write_VC_Control_Path(ofile);
      ofile << "}" << endl;

      ofile << "$T [rr] $T [ra] $T [cr] $T [ca] // (split) binary operation " << endl;
      ofile << "}" << endl;
    }
}

void AaBinaryExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  if(this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;



      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    {
      this->_first->Write_VC_Constant_Wire_Declarations(ofile);
      this->_second->Write_VC_Constant_Wire_Declarations(ofile);
    }
}
void AaBinaryExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{


  if(!this->Is_Constant())
    {
      this->_first->Write_VC_Wire_Declarations(false,ofile);
      this->_second->Write_VC_Wire_Declarations(false, ofile);
      
      if(!this->Is_Constant() && !skip_immediate)
	{

	  ofile << "// " << this->To_String() << endl;

	  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
						 this->Get_Type(),
						 ofile);
	}
    }



}
void AaBinaryExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{


  if(!this->Is_Constant())
    {

      this->_first->Write_VC_Datapath_Instances(NULL,ofile);
      this->_second->Write_VC_Datapath_Instances(NULL,ofile);

      ofile << "// " << this->To_String() << endl;

      Write_VC_Binary_Operator(this->Get_Operation(),
			       this->Get_VC_Datapath_Instance_Name(),
			       _first->Get_VC_Driver_Name(),
			       _first->Get_Type(),
			       _second->Get_VC_Driver_Name(),
			       _second->Get_Type(),
			       (target != NULL ? target->Get_VC_Receiver_Name() : 
				this->Get_VC_Receiver_Name()),
			       (target != NULL ? target->Get_Type() : this->Get_Type()),
			       ofile);
    }
			  
}
void AaBinaryExpression::Write_VC_Links(string hier_id, ostream& ofile)
{

  if(!this->Is_Constant())
    {

      string input_hier_id = hier_id + "/"  + this->Get_VC_Name() + "/"
	+ this->Get_VC_Name() + "_inputs";

      this->_first->Write_VC_Links(input_hier_id, ofile);
      this->_second->Write_VC_Links(input_hier_id, ofile);

      ofile << "// " << this->To_String() << endl;

      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/" +this->Get_VC_Name() + "/rr");
      reqs.push_back(hier_id + "/" +this->Get_VC_Name() + "/cr");
      acks.push_back(hier_id + "/" +this->Get_VC_Name() + "/ra");
      acks.push_back(hier_id + "/" +this->Get_VC_Name() + "/ca");
      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
    }
}


void AaBinaryExpression::Evaluate()
{
  if(!_already_evaluated)
    {
      _already_evaluated = true;
      this->_first->Evaluate();
      this->_second->Evaluate();
      if(this->_first->Is_Constant() && this->_second->Is_Constant())
	this->Assign_Expression_Value(Perform_Binary_Operation(this->_operation, 
							       this->_first->Get_Expression_Value(),
							       this->_second->Get_Expression_Value()));
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

  ofile << "// " << this->To_String() << endl;


  // if _test is constant, print dummy.
  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // ternary expression: " << endl;
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


void AaTernaryExpression::Evaluate()
{
  if(!_already_evaluated)
    {
      _already_evaluated = true;
      this->_test->Evaluate();
      this->_if_true->Evaluate();
      this->_if_false->Evaluate();

      if(this->_test->Is_Constant() && this->_if_true->Is_Constant() && this->_if_false->Is_Constant())
	{
	  if(this->_test->Get_Expression_Value()->To_Boolean())
	    this->Assign_Expression_Value(this->_if_true->Get_Expression_Value());
	  else
	    this->Assign_Expression_Value(this->_if_false->Get_Expression_Value());
	}
    }
}


void AaTernaryExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;


  if(this->Is_Constant())
    {
      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    {
      this->_test->Write_VC_Constant_Wire_Declarations(ofile);
      this->_if_true->Write_VC_Constant_Wire_Declarations(ofile);
      this->_if_false->Write_VC_Constant_Wire_Declarations(ofile);
    }

}
void AaTernaryExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{



  if(!this->Is_Constant())
    {
      this->_test->Write_VC_Wire_Declarations(false,ofile);
      this->_if_true->Write_VC_Wire_Declarations(false,ofile);
      this->_if_false->Write_VC_Wire_Declarations(false,ofile);
    }

  if(!skip_immediate && !this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;

      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
					     this->Get_Type(),
					     ofile);
    }
}
void AaTernaryExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
  if(!this->Is_Constant())
    {


      this->_test->Write_VC_Datapath_Instances(NULL,ofile);
      this->_if_true->Write_VC_Datapath_Instances(NULL,ofile);
      this->_if_false->Write_VC_Datapath_Instances(NULL,ofile);

      ofile << "// " << this->To_String() << endl;

      Write_VC_Select_Operator(this->Get_VC_Datapath_Instance_Name(),
			       this->_test->Get_VC_Driver_Name(),
			       this->_test->Get_Type(),
			       this->_if_true->Get_VC_Driver_Name(),
			       this->_if_true->Get_Type(),
			       this->_if_false->Get_VC_Driver_Name(),
			       this->_if_false->Get_Type(),
			       (target != NULL ? target->Get_VC_Driver_Name() : this->Get_VC_Driver_Name()),
			       (target != NULL ? target->Get_Type() : this->Get_Type()),
			       ofile);
			       
    }
}
void AaTernaryExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
  if(!this->Is_Constant())
    {

      this->_test->Write_VC_Links(hier_id + "/" + this->Get_VC_Name() + "/" +
				  this->Get_VC_Name() + "_inputs", ofile);
      this->_if_true->Write_VC_Links(hier_id + "/" + this->Get_VC_Name() + "/"
				     + this->Get_VC_Name() + "_inputs", ofile); 
      this->_if_false->Write_VC_Links(hier_id + "/" + this->Get_VC_Name() + "/"
				      + this->Get_VC_Name() + "_inputs", ofile); 

      ofile << "// " << this->To_String() << endl;

      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/req");
      acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/ack");

      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),
		    reqs,
		    acks,
		    ofile);
    }
}



