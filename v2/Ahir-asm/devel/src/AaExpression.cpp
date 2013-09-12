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
  this->_is_target = false;
  this->_does_pipe_access = false;
  this->_associated_statement = NULL;
  this->_is_malformed = false;
  this->_do_while_parent = NULL;
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
     if(this->_addressed_object_representative->Is_Foreign_Storage_Object() !=
	obj->Is_Foreign_Storage_Object())
       {
	 AaRoot::Error("cannot coalesce a foreign storage object with a native storage object",this);
       }
     else if(!this->_addressed_object_representative->Is_Foreign_Storage_Object())
       {
	 if(obj != this->_addressed_object_representative)
	   {
	     this->_addressed_object_representative = obj;
	     new_flag = true;
	   }
       }
   }
  return(new_flag);
}


bool AaExpression::Is_Part_Of_Extreme_Pipeline()
{
	AaDoWhileStatement* dws = this->Get_Do_While_Parent();
	bool ret_val = ((dws != NULL)  && dws->Get_Full_Rate_Flag());
	return(ret_val);
}

string AaExpression::Get_VC_Guard_String()
{
	string ret_string;
	AaStatement* stmt = this->Get_Associated_Statement();
	if(stmt != NULL)
	{
	    ret_string = stmt->Get_VC_Guard_String();
	}
	return(ret_string);
}

void AaExpression::Replace_Field_Expression(AaExpression** eptr, AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	AaExpression* fexpr = *eptr;

	if(fexpr != NULL)
	{
		if((fexpr == used_expr) || (fexpr->Is_Implicit_Variable_Reference() &&  
					(fexpr->Get_Root_Object() == used_expr->Get_Root_Object())) )
		{
			assert(replacement->Is_Statement());
			AaExpression* new_expr = new AaSimpleObjectReference(this->Get_Scope(),replacement);
			*eptr  = new_expr;
			this->AaExpression::Replace_Uses_By(fexpr, new_expr);
		}
		
	}
}

void AaExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_expr)
{

  if(!this->Get_Coalesce_Flag())
    {
      this->Set_Coalesce_Flag(true);

      this->Set_Addressed_Object_Representative(obj);
      if(AaProgram::_verbose_flag)
	AaRoot::Info("coalescing: propagating " + (obj ? obj->Get_Name() : "null") + " from expression " + this->To_String() +
		 this->Get_Source_Info());

      // propagate to all that are targets of this expression.
      for(set<AaExpression*>::iterator iter = _targets.begin();
	  iter != _targets.end();
	  iter++)
	{
	  (*(iter))->Propagate_Addressed_Object_Representative(obj, this);
	}
      
      // propagate to all objects that use this 
      // expression as a source.
      for(set<AaRoot*>::iterator iter = _source_references.begin();
	  iter != _source_references.end();
	  iter++)
	{
	  if((*iter)->Is_Object())
	    ((AaObject*)(*iter))->Propagate_Addressed_Object_Representative(obj, this);
	  
	}

      this->Set_Coalesce_Flag(false);
    }
}

void AaExpression::Set_Type(AaType* t)
{
  if(this->_type == NULL)
    {
      if(this->Scalar_Types_Only() && !t->Is_Scalar_Type())
	{
	  AaRoot::Error("expression " + this->To_String() + " type must be a scalar", this);
	}
      else
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
    }
   else
     {
       if(t != this->_type)
	 {
	   string err_msg = "type of expression ";
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

bool AaExpression::Used_Only_In_Address_Of_Expression()
{
  bool ret_val = false;
  if(this->_targets.size() == 1)
    {
      // has a unique target
      AaExpression* expr =*(this->_targets.begin());
      if(expr->Get_Is_Target())
	ret_val = false;
      else if(expr->Is("AaAddressOfExpression"))
	ret_val = true;
      else
	ret_val = expr->Used_Only_In_Address_Of_Expression();
    }
  else
    ret_val = false;

  return(ret_val);
}

AaExpression* AaExpression::Get_Guard_Expression()
{
	if(_associated_statement != NULL)
		return(_associated_statement->Get_Guard_Expression());
	else
		return(NULL);
}
bool AaExpression::Get_Guard_Complement()
{
	if(_associated_statement != NULL)
		return(_associated_statement->Get_Guard_Complement());
	else
		return(false);
}

//---------------------------------------------------------------------
// AaObjectReference
//---------------------------------------------------------------------
AaObjectReference::AaObjectReference(AaScope* parent_tpr, string object_id):AaExpression(parent_tpr)
{
	this->_object_ref_string = object_id;
	this->_object_root_name = object_id;
	this->_search_ancestor_level = 0; 
	this->_object = NULL;
	this->_is_dereferenced = false;
}

AaObjectReference::~AaObjectReference() {};

AaObjectReference::AaObjectReference(AaScope* parent_tpr, AaAssignmentStatement* root_obj):AaExpression(parent_tpr)
{
	this->_object_ref_string = root_obj->Get_Target_Name();
	this->_object_root_name =  this->_object_ref_string;
	this->_search_ancestor_level = 0; 
	this->_object = root_obj;
	this->_is_dereferenced = false;
}

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


// cannot assign a value to a storage object!
void AaObjectReference::Assign_Expression_Value(AaValue* expr_value)
{
	if(this->_object && !this->_object->Is_Storage_Object())
	{
		this->AaExpression::Assign_Expression_Value(expr_value);
	}
}

// return -1 if not evaluatable.
int AaObjectReference::Evaluate(vector<AaExpression*>* indices, vector<int>* scale_factors, vector<int>* shift_factors)
{
	bool address_is_const = true;
	int address_offset = 0;


	if(indices != NULL)
	{

		assert(scale_factors);
		assert(shift_factors);
		assert(scale_factors->size() == shift_factors->size());

		for(int idx = 0; idx < indices->size(); idx++)
		{
			if(!(*indices)[idx]->Is_Constant())
				address_is_const = false;
			else
			{
				if((*shift_factors)[idx] < 0)
					address_offset += (*indices)[idx]->Get_Expression_Value()->To_Integer() *
						(*scale_factors)[idx];
				else
					address_offset += (*shift_factors)[idx];
			}
		}
	}
	if(address_is_const)
		return(address_offset);
	else
		return(-1);
}

void AaObjectReference::Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_expr)
{
	this->AaExpression::Propagate_Addressed_Object_Representative(obj, from_expr);
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

	  if(child->Is("AaPipeObject"))
	    {
	      AaScope* root = this->Get_Scope()->Get_Root_Scope();
	      assert(root->Is("AaModule"));
	      ((AaPipeObject*)child)->Add_Reader((AaModule*)root);
	      ((AaModule*)root)->Add_Read_Pipe((AaPipeObject*)child);
	    }

	  this->Set_Object(child);

	  child->Add_Source_Reference(this);  // child -> this (child is a source of this)
	  this->Add_Target_Reference(child);  // this <- child (this is a target of child)

	  if(child->Is_Expression())
	    ((AaExpression*)child)->Add_Target(this);

	  if(child->Is_Object())
	    {
	      source_objects.insert(child);

	      if(child->Is("AaStorageObject"))
		((AaStorageObject*)child)->Set_Is_Read_From(true);
	    }
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

void AaObjectReference::Set_Is_Dereferenced(bool v) 
{
  _is_dereferenced = v;
  if(this->_object->Is_Object())
    {
      ((AaObject*) (this->_object))->Set_Is_Dereferenced(v);
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


void AaObjectReference::Update_Globally_Accessed_Objects(AaStorageObject* sobj)
{
	AaScope* root_scope = NULL;
	if(this->Get_Scope())
		root_scope = this->Get_Scope()->Get_Root_Scope();
	if(root_scope != NULL)
		// parent module of this expression.
	{
		assert(root_scope->Is_Module());
		AaModule* pm = ((AaModule*) root_scope);

		if(sobj->Get_Scope() == NULL)
		// object defined in global scope? record it in pm.
		{
			if(this->Get_Is_Target())
				pm->Add_Written_Global_Object(sobj);
			else
				pm->Add_Read_Global_Object(sobj);
		}
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
	this->Evaluate();
	ofile << tab_string;
	if(this->Get_Scalar_Flag())
	{
		assert(this->_literals.size() == 1);
		ofile << this->Get_Expression_Value()->To_C_String() << " ";
	}
	else
	{ 
		assert(this->_literals.size() > 0);
		ofile << this->Get_Expression_Value()->To_C_String() << " ";
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

// all uses of used_expr in this expression are to be replaced
// by simple object reference with replacement as the object.
void AaExpression::Replace_Uses_By(AaExpression* used_expr, AaExpression* r_expr)
{
	if(this->Get_Target_References().find(used_expr) != this->Get_Target_References().end())
	{
		// unlink..
		this->Get_Target_References().erase(used_expr);
		used_expr->Get_Source_References().erase(this);
		used_expr->Remove_Target(this);

		this->Add_Target_Reference(r_expr);
		r_expr->Add_Source_Reference(this);
		r_expr->Add_Target(this);
	}
}

//---------------------------------------------------------------------
//AaSimpleObjectReference
//---------------------------------------------------------------------
AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, string object_id):AaObjectReference(parent_tpr, object_id) {};
AaSimpleObjectReference::~AaSimpleObjectReference() {};
void AaSimpleObjectReference::Set_Object(AaRoot* obj)
{
	this->_object = obj;

	if(obj->Is_Object())
	{
		if(((AaObject*)obj)->Get_Type())
		{
			AaType* obj_type = ((AaObject*)obj)->Get_Type();
			this->Set_Type(obj_type);
		}

		if(obj->Is_Pipe_Object())
		{
			this->Set_Does_Pipe_Access(true);
		}

		if(obj->Is_Storage_Object())
			// register this object as an accessed global
			// object in the module if appropriate.
		{
			this->Update_Globally_Accessed_Objects((AaStorageObject*) obj);
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

	if(this->Is_Implicit_Variable_Reference() || obj->Is_Interface_Object())
		this->Set_Delay(0);
	else
		this->Set_Delay(1);

}

AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, AaAssignmentStatement* root_obj):AaObjectReference(parent_tpr, root_obj) 
{
	this->Set_Object(root_obj);
	this->Set_Type(root_obj->Get_Target()->Get_Type());
}

bool AaSimpleObjectReference::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
	this->_addressed_objects.insert(obj);

	// TBD: overly conservative.
	//  if(this->_is_dereferenced)
	//{

	if(this->Get_Addressed_Object_Representative())
		AaProgram::Add_Storage_Dependency(obj,this->Get_Addressed_Object_Representative());

	//    }
	this->AaExpression::Set_Addressed_Object_Representative(obj);
}

void AaSimpleObjectReference::Set_Type(AaType* t)
{
	if(this->_object && this->_object->Is_Storage_Object() && !this->Used_Only_In_Address_Of_Expression())
		((AaStorageObject*)this->_object)->Add_Access_Width(t->Size());

	this->AaExpression::Set_Type(t);
}

string AaSimpleObjectReference::Get_Name()
{
	assert(this->_object != NULL);

	if(this->_object->Is("AaInterfaceObject"))
		return this->_object->Get_Name();
	else
		return this->Get_Object_Ref_String();
}

void AaSimpleObjectReference::Print(ostream& ofile)
{
	assert(this->_object != NULL);

	if(this->_object->Is("AaInterfaceObject"))
		ofile << this->_object->Get_Name();
	else
		ofile << this->Get_Object_Ref_String();
}

void AaSimpleObjectReference::PrintC_Header_Entry(ofstream& ofile)
{
	AaType* t = this->Get_Type();
	if(t->Is_Pointer_Type())
	{

		AaType* rt = ((AaPointerType*)t)->Get_Ref_Type();
		ofile << rt->CName() << " (*";
		ofile << this->Get_Object_Root_Name() << ")";
		ofile << rt->CDim();
		ofile << ";" << endl;
	}
	else
	{
		ofile << t->CName() 
			<< " " 
			<< this->Get_Object_Root_Name()
			<< t->CDim();
		ofile << ";" << endl;

	}
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
			this->Write_VC_Load_Control_Path(NULL,NULL,NULL,ofile);
		}
		// else if the object being referred to is
		// a pipe, instantiate a series r-a
		// chain for the inport operation
		else if(this->_object->Is("AaPipeObject"))
		{
			ofile << "// " << this->To_String() << endl;
			ofile << "||[" << this->Get_VC_Name() << "] { // pipe read" << endl;
			ofile << ";;[Sample] {" << endl;
			ofile << "$T [req] $T [ack] " << endl;
			ofile << "}" << endl;
			ofile << ";;[Update] { " << endl;
			ofile << "$T [req] $T [ack] " << endl;
			ofile << "}" << endl;
			ofile << "}" << endl;
		}
	}
}


// return the name of the transition which triggers the update of
// this expression's value.
string AaSimpleObjectReference::Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
	if(this->Is_Constant())
	{
		// in this case, there is no such transition which fits the bill.
		// return null
		return("$null");
	}
	else 
		// either it is an access to a storage object, pipe,
		// implicit variable or interface object.
		//
		// In the pipe/storage case, simply reenable the active
		// transition 
		//
		// In the implicit variable case, reenable the
		// active transition of the statement defining the
		// variable, if it exists in visited elements
		//
		// In the interface object case, if the unique
		// driver to the interface object exists in visited elements
		// use the active of that driver statement.
		//
	{

		if(this->_object->Is("AaStorageObject"))
			return(__UST(this));

		if(this->_object->Is("AaPipeObject"))
		{
			return(__UST(this));
		}

		if(this->_object->Is_Interface_Object())
		{
			AaRoot* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
			if((root != NULL) && (visited_elements.find(root) != visited_elements.end()))
				return(root->Get_VC_Reenable_Update_Transition_Name(visited_elements));
			else
				return("$null");
		}

		if(this->Is_Implicit_Variable_Reference())
		{
			AaRoot* root = this->Get_Root_Object();
			if(visited_elements.find(root) != visited_elements.end())
			{
				return(root->Get_VC_Reenable_Update_Transition_Name(visited_elements));
			}
			else
			{
				// the expression/statement which sets the value of this implicit variable
				// is not found in the visited elements.  
				return(__UST(this));
			}
		}

		// you should never get here.
		assert(0 && "unknown variety of simple-object-reference");
	}
}

// return the name of the transition which triggers the sampling of
// this expression's inputs.
string AaSimpleObjectReference::Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
{
	if(this->Is_Constant())
	{
		// if it is a constant, there is no such transition.
		return("$null");
	}
	else 
		// either it is an access to a storage object, pipe,
		// implicit variable or interface object.
		//
		// In the pipe/storage case, simply reenable the active
		// transition 
		//
		// In the implicit variable case, reenable the
		// active transition of the statement defining the
		// variable, if it exists in visited elements
		//
		// In the interface object case, if the unique
		// driver to the interface object exists in visited elements
		// use the active of that driver statement.
		//
	{

		if(this->_object->Is("AaStorageObject"))
			return(__SST(this));

		if(this->_object->Is("AaPipeObject"))
			return(__SST(this));

		if(this->_object->Is_Interface_Object())
		{
			AaInterfaceObject* io = (AaInterfaceObject*) (this->_object);
			if(io->Get_Is_Input())
				return("$null");
			else
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				if((root != NULL) && (visited_elements.find(root) != visited_elements.end()))
					return(root->Get_VC_Reenable_Sample_Transition_Name(visited_elements));
				else
					return("$null");
			}
		}

		if(this->Is_Implicit_Variable_Reference())
		{
			AaRoot* root = this->Get_Root_Object();
			if(visited_elements.find(root) != visited_elements.end())
			{
				return(root->Get_VC_Reenable_Sample_Transition_Name(visited_elements));
			}
			else
			{
				// the expression/statement which sets the value of this implicit variable
				// is not found in the visited elements.  Return the start transition.
				return(__SST(this));
			}
		}

		// you should never get here.
		assert(0 && "unknown variety of simple-object-reference");
	}
}

// TODO: in these four cases, the case when the target is
//       an interface object needs to be handled similarly..
string AaSimpleObjectReference::Get_VC_Sample_Start_Transition_Name()
{
	if(this->Get_Is_Target() 
		&&  (this->Is_Implicit_Variable_Reference() || 
			this->_object->Is_Interface_Object()))
		
		return(__SST(this->Get_Associated_Statement()));
	else
		return(this->AaRoot::Get_VC_Sample_Start_Transition_Name());
}

string AaSimpleObjectReference::Get_VC_Sample_Completed_Transition_Name()
{
	if(this->Get_Is_Target() 
		&&  (this->Is_Implicit_Variable_Reference() || 
			this->_object->Is_Interface_Object()))
		return(__SCT(this->Get_Associated_Statement()));
	else
		return(this->AaRoot::Get_VC_Sample_Completed_Transition_Name());
}

string AaSimpleObjectReference::Get_VC_Update_Start_Transition_Name()
{
	if(this->Get_Is_Target() 
		&&  (this->Is_Implicit_Variable_Reference() || 
			this->_object->Is_Interface_Object()))
		return(__UST(this->Get_Associated_Statement()));
	else
		return(this->AaRoot::Get_VC_Update_Start_Transition_Name());
}

string AaSimpleObjectReference::Get_VC_Update_Completed_Transition_Name()
{
	if(this->Get_Is_Target() 
		&&  (this->Is_Implicit_Variable_Reference() || 
			this->_object->Is_Interface_Object()))
		return(__UCT(this->Get_Associated_Statement()));
	else
		return(this->AaRoot::Get_VC_Update_Completed_Transition_Name());
}

AaRoot* Get_Non_Trivial_Predecessor(set<AaRoot*>& visited_elements)
{
	assert(0);
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
		this->Write_VC_Store_Control_Path(NULL,NULL,NULL,ofile);
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
	// dead code .. should never be called.
	assert(0);
}

// return true if the expression points
// to an implicitly defined variable reference.
// (either a statement or an interface object).
bool AaSimpleObjectReference::Is_Implicit_Variable_Reference()
{
	return(this->Get_Root_Object() != NULL);
}

AaRoot* AaSimpleObjectReference::Get_Root_Object()
{
	assert(this->_object != NULL);
	if(this->_object->Is("AaSimpleObjectReference"))
	{
		return(((AaSimpleObjectReference*)this->_object)->Get_Root_Object());
	}
	else if(this->_object->Is("AaInterfaceObject"))
	{
		return(this->_object);
	}
	else if(this->_object->Is_Statement())
	{
		return(this->_object);
	}
	else
		return(NULL);
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
	{
		ofile << "// " << this->To_String() << endl;
		Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				this->Get_Type(),
				this->Get_Expression_Value(),
				ofile);
	}

	if(!this->Is_Constant() && this->_object->Is("AaStorageObject"))
	{
		ofile << "// " << this->To_String() << endl;
		this->Write_VC_Load_Store_Constants(NULL,NULL,NULL,ofile);
	}



}
void AaSimpleObjectReference::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
	if(!skip_immediate && !this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
	{
		ofile << "// " << this->To_String() << endl;
		Write_VC_Wire_Declaration(this->Get_VC_Driver_Name(),
				this->Get_Type(),
				ofile);
	}

	if(!this->Is_Constant() && this->_object->Is("AaStorageObject"))
	{
		ofile << "// " << this->To_String() << endl;
		this->Write_VC_Load_Store_Wires(NULL,NULL,NULL,ofile);
	}
}

void AaSimpleObjectReference::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{

	if(!this->Is_Constant() )
	{
		ofile << "// " << this->To_String() << endl;

		// if _object is a statement, declare it, otherwise not.
		if(this->_object->Is_Statement())
		{
			Write_VC_Wire_Declaration(this->Get_VC_Receiver_Name(),
					this->Get_Type(),
					ofile);
		}

		if(this->_object->Is("AaStorageObject"))
		{
			this->Write_VC_Load_Store_Constants(NULL,NULL,NULL,ofile);
			this->Write_VC_Load_Store_Wires(NULL,NULL,NULL,ofile);
		}

		// if this is a pipe?  This is covered in the statement
		// method (three cases: assignment, phi, call)
	}
}

void AaSimpleObjectReference:: Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source) 
{
	if(!this->Is_Constant()  && !this->Is_Implicit_Variable_Reference())
	{
		bool extreme_pipeline_flag = this->Is_Part_Of_Extreme_Pipeline();

		ofile << "// " << this->To_String() << endl;
		if(this->_object->Is("AaStorageObject"))
		{
			this->Write_VC_Store_Data_Path(NULL,
					NULL,
					NULL,
					(source != NULL ? source : this),
					ofile);
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			string src_name =  
				(source != NULL ? 
				 source->Get_VC_Driver_Name() : this->Get_VC_Driver_Name());

			// io write.
			Write_VC_IO_Output_Port((AaPipeObject*) this->_object,
					this->Get_VC_Datapath_Instance_Name(),
					src_name,
					this->Get_VC_Guard_String(),
					ofile);

			// extreme pipelining
			// double buffering at the input side.
			if(extreme_pipeline_flag)
			{
				ofile << " $buffering $in " 
					<< this->Get_VC_Datapath_Instance_Name() << " "
					<< src_name
					<< " 2"  << endl;
			}
			else
			{
				ofile << " $buffering $in " 
					<< this->Get_VC_Datapath_Instance_Name() << " "
					<< src_name
					<< " 0"  << endl;
			}
		}
	}
}

void AaSimpleObjectReference:: Write_VC_Datapath_Instances(AaExpression* target,  ostream& ofile) 
{

	if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
	{
		bool extreme_pipelining_flag = this->Is_Part_Of_Extreme_Pipeline();

		ofile << "// " << this->To_String() << endl;
		if(this->_object->Is("AaStorageObject"))
		{
			this->Write_VC_Load_Data_Path(NULL,
					NULL,
					NULL,
					(target != NULL ? target : this),
					ofile);
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			string dpe_name = this->Get_VC_Datapath_Instance_Name();
			string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

			// io write.
			Write_VC_IO_Input_Port((AaPipeObject*) this->_object,
					dpe_name,
					tgt_name,
					this->Get_VC_Guard_String(),
					ofile);

			//  extreme pipelining
			if(extreme_pipelining_flag)
			{
				ofile << "$buffering $out " << dpe_name << " " << tgt_name << " 2" << endl;
			}
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
			this->Write_VC_Load_Links(hier_id,NULL,NULL,NULL,ofile);
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			string inst_name = this->Get_VC_Datapath_Instance_Name();
			reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Sample/req");
			reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Update/req");
			acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Sample/ack");
			acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Update/ack");
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
			this->Write_VC_Store_Links(hier_id,NULL,NULL,NULL,ofile);
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


// find all dependencies from elements in visited_elements to this
// expression.
void AaSimpleObjectReference::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	if(!this->Get_Is_Target())
	{
		if(this->Is_Implicit_Variable_Reference())
		{
			AaRoot* root = this->Get_Root_Object();
			if(visited_elements.find(root) != visited_elements.end())
			{

				AaExpression* root_target = NULL;
				if(root->Is("AaAssignmentStatement"))
				{
					root_target = ((AaAssignmentStatement*)root)->Get_Target();		
				}
				else if(root->Is("AaPhiStatement"))
				{
					root_target = ((AaPhiStatement*)root)->Get_Target();		
				}
				else if(root->Is("AaCallStatement"))
				{
					root_target = ((AaCallStatement*)root)->Get_Implicit_Target(this->Get_Object_Root_Name());
				}
				else
					assert(0);

				assert(root_target != NULL);
				__InsMap(adjacency_map,root_target,this,0);
				visited_elements.insert(this);
			}		
			else
			{
				root = NULL;
				__InsMap(adjacency_map,root,this,0);
				visited_elements.insert(this);
			}
		}
		else
		{
			AaRoot* tmp = NULL;
			__InsMap(adjacency_map,tmp,this,0);
			visited_elements.insert(this);
		}
	}
	else 
	{
		visited_elements.insert(this);
	}
}

void AaSimpleObjectReference::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	if(this->_object == used_expr->Get_Root_Object())
	{
		AaRoot* obj   = this->_object;
		this->_object = replacement;
	}
}

//---------------------------------------------------------------------
// AaArrayObjectReference
//---------------------------------------------------------------------
AaArrayObjectReference::AaArrayObjectReference(AaScope* parent_tpr, 
		string object_id, 
		vector<AaExpression*>& index_list):AaObjectReference(parent_tpr,object_id)
{

	this->_pointer_ref = NULL;
	for(unsigned int i  = 0; i < index_list.size(); i++)
		this->_indices.push_back(index_list[i]);
}
AaArrayObjectReference::~AaArrayObjectReference()
{
}
void AaArrayObjectReference::Print(ostream& ofile)
{
	assert(this->_object != NULL);

	if(this->_object->Is("AaInterfaceObject"))
		ofile << this->_object->Get_Name();
	else 
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


void AaArrayObjectReference::Set_Type(AaType* t)
{
	if(this->_object->Is_Storage_Object())
	{
		if(!this->_object->Get_Type()->Is_Pointer_Type() && !this->Used_Only_In_Address_Of_Expression())
			((AaStorageObject*)this->_object)->Add_Access_Width(t->Size());
	}

	this->AaExpression::Set_Type(t);
}

void AaArrayObjectReference::Add_Target_Reference(AaRoot* referrer)
{
	this->AaRoot::Add_Target_Reference(referrer);
	if(referrer->Is("AaInterfaceObject"))
	{
		AaType* rtype = ((AaInterfaceObject*)referrer)->Get_Type();
		this->Set_Type(rtype->Get_Element_Type(0,_indices));
	}
}
void AaArrayObjectReference::Add_Source_Reference(AaRoot* referrer)
{
	this->AaRoot::Add_Source_Reference(referrer);
	if(referrer->Is("AaInterfaceObject"))
	{
		AaType* rtype = ((AaInterfaceObject*)referrer)->Get_Type();
		this->Set_Type(rtype->Get_Element_Type(0,_indices));
	}
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

		if(obj->Is_Pipe_Object())
			this->Set_Does_Pipe_Access(true);

		if(obj->Is_Storage_Object())
			this->Update_Globally_Accessed_Objects((AaStorageObject*) obj);
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

	this->Set_Delay(2);

}


bool AaArrayObjectReference::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
	if(this->Get_Object_Type() && this->Get_Object_Type()->Is_Pointer_Type())
	{
		AaStorageObject* ref = this->Get_Addressed_Object_Representative();

		// pointer calculation is always done in the context of a memory
		// space... so all storage objects pointed to by pointer calculation
		// operation must be in the same memory space!
		if(ref != NULL && ref != obj)
		{
			AaProgram::Add_Storage_Dependency(ref,obj);
		}

		// since we will be doing address calculation,
		// the width of the word to which this address points
		// must be recorded!
		assert(this->_type->Is_Pointer_Type());
		if(obj != NULL)
			obj->Add_Access_Width(((AaPointerType*)(this->_type))->Get_Ref_Type()->Size());
	}
	this->AaExpression::Set_Addressed_Object_Representative(obj);
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

void AaArrayObjectReference::Map_Source_References_As_Target(set<AaRoot*>& source_objects)
{
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

		if(this->_pointer_ref)
			this->_pointer_ref->Evaluate();

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

			if(_indices[idx]->Get_Does_Pipe_Access())
				this->Set_Does_Pipe_Access(true);

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

			vector<int> shift_factors;
			this->Update_Address_Shift_Factors(shift_factors,word_size);

			for(int idx = 0; idx < _indices.size(); idx++)
			{
				int indx_val  = _indices[idx]->Get_Expression_Value()->To_Integer();
				if(shift_factors[idx] < 0)
					ret_int_val += (indx_val*scale_factors[idx]);
				else
					ret_int_val += shift_factors[idx];
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
	    {
	      residual_size = ref_type->Get_Element_Type(1,index_prefix)->Size()/word_size;
	      if(residual_size == 0)
		{
		  AaRoot::Error("address calculation must be for full words only!", this);
		}
	    }

	  scale_factors.push_back(residual_size);
	}
      else if(t->Is_Composite_Type())
	{
	  residual_size = t->Get_Element_Type(0,index_prefix)->Size()/word_size;
	  if(residual_size == 0)
	    AaRoot::Error("address calculation must be for full words only!", this);

	  scale_factors.push_back(residual_size);
	}
    }
}


void AaArrayObjectReference::Update_Address_Shift_Factors(vector<int>& shift_factors, int word_size)
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

  int start_index = 0;
  if(t->Is_Pointer_Type())
    {
      shift_factors.push_back(-1);
      start_index = 1;
      t =  ((AaPointerType*)t)->Get_Ref_Type();
    }

  for(int idx = start_index; idx < _indices.size(); idx++)
    {
      assert(t->Is_Composite_Type());

      if(t->Is_Record_Type())
	{
	  int soffset = (((AaRecordType*)t)->Get_Start_Bit_Offset(_indices[idx]))/word_size;
	  shift_factors.push_back(soffset);
	  t = ((AaRecordType*)t)->Get_Element_Type(_indices[idx]);
	}
      else if(t->Is_Array_Type())
	{
	  shift_factors.push_back(-1);
	  t = t->Get_Element_Type(0);
	}
    }
}


void AaArrayObjectReference::PrintC(ofstream& ofile, string tab_string)
{
  assert(this->_object && this->_object->Get_Type());
  if(this->_object->Get_Type()->Is_Pointer_Type())
    {
      AaType* t  = this->_object->Get_Type();

      ofile << "&(*(";
      this->AaObjectReference::PrintC(ofile,"");
      ofile << this->Get_Object_Root_Name() << " ";
      ofile << " + " ;

      _indices[0]->PrintC(ofile,"");

      ofile << ")";
      
      AaType* rt = ((AaPointerType*)t)->Get_Ref_Type();
      this->Print_Indexed_C(rt,1,&_indices,ofile);
      ofile << ")";
    }
  else
    {
      ofile << "(";
      this->AaObjectReference::PrintC(ofile,"");
      ofile << this->Get_Object_Root_Name();
      this->Print_Indexed_C(this->_object->Get_Type(),0,&_indices,ofile);
      ofile << ").__val";
    }

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

void AaArrayObjectReference::Print_Indexed_C(AaType* t, int start_id, vector<AaExpression*>* indices, ofstream& ofile)
{
  AaType* curr_type = t;
  
  while(start_id < indices->size())
    {
      assert(curr_type != NULL);

      if(curr_type->Is("AaArrayType"))
	{
	  ofile << "[";
	  (*indices)[start_id]->PrintC(ofile,"");
	  ofile << "]";
	  curr_type = ((AaArrayType*)curr_type)->Get_Element_Type(0);
	}
      else if(curr_type->Is("AaRecordType"))
	{
	  assert((*indices)[start_id]->Is_Constant());
	  int idx = ((*indices)[start_id]->Get_Expression_Value()->To_Integer());
	  ofile << ".f_" << IntToStr(idx);
	  curr_type = ((AaRecordType*)curr_type)->Get_Element_Type(idx);
	}
      else
	{
	  assert(0);
	}
      start_id++;
    }
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
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;



      if(this->Get_Object_Type()->Is_Pointer_Type())
	{
	  if(this->_object->Is_Storage_Object())
	    {
	      // please load the object.
	      this->_pointer_ref->Write_VC_Control_Path(ofile);
	    }

	  int word_size = this->Get_Word_Size();

	  vector<int> scale_factors;
	  this->Update_Address_Scaling_Factors(scale_factors,word_size);

	  vector<int> shift_factors;
	  this->Update_Address_Shift_Factors(shift_factors,word_size);


	  // the return value is a pointer,
	  // but this is only an address calculation.
	  ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;
	  this->Write_VC_Root_Address_Calculation_Control_Path(&_indices,
							       &scale_factors,
							       &shift_factors,
							       ofile);

	  ofile << "||[Interlock] { " << endl;
	  ofile << ";;[Sample] {" << endl;
	  ofile << "$T [req] $T [ack]" << endl;
	  ofile << "}" << endl;
	  ofile << ";;[Update] {" << endl;
	  ofile << "$T [req] $T [ack]" << endl;
	  ofile << "}" << endl;
	  ofile << "}" << endl;
	}
      else if(this->_object->Is_Storage_Object())
	{ 

	  int word_size = this->Get_Word_Size();

	  vector<int> scale_factors;
	  this->Update_Address_Scaling_Factors(scale_factors,word_size);

	  vector<int> shift_factors;
	  this->Update_Address_Shift_Factors(shift_factors,word_size);



	  // this is just a regular object load
	  // using the indices, which returns the
	  // value stored at the computed address.
	  this->Write_VC_Load_Control_Path(&(_indices),
					   &scale_factors,
					   &shift_factors,
					   ofile);
	}
      else 
	{

	  ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;
	  if(this->_object->Is_Expression())
	    {
	      AaExpression* expr = ((AaExpression*) (this->_object));
	      expr->Write_VC_Control_Path(ofile);
	    }
	  else if(this->_object->Is("AaInterfaceObject"))
	    {
	      // do nothing.
	    }
	  else if(this->_object->Is("AaPipeObject"))
	    {
	      ofile << "$T [pipe_read_req] $T [pipe_read_ack] " << endl;
	    }
	  ofile << "$T [slice_req] $T [slice_ack]" << endl;
	  ofile << "}" << endl;
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
      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      this->Write_VC_Store_Control_Path(&(_indices),&(scale_factors),&shift_factors,  ofile);
    }
  else
    {
      AaRoot::Error("indexed target reference can only be to a storage object", this);
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

      // base pointer.. will need to be declared?
      // certainly..
      if(this->_object->Is_Expression())
	{
	  ((AaExpression*)this->_object)->Write_VC_Constant_Wire_Declarations(ofile);
	}

      if(this->Get_Object_Type()->Is_Pointer_Type())
	{
	  int word_size = this->Get_Word_Size();
	  vector<int> scale_factors;
	  this->Update_Address_Scaling_Factors(scale_factors,word_size);
	  
	  vector<int> shift_factors;
	  this->Update_Address_Shift_Factors(shift_factors,word_size);

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
							    &shift_factors,
							    ofile);
	}
      else if(this->_object->Is_Storage_Object())
	{
	  int word_size = this->Get_Word_Size();
	  vector<int> scale_factors;
	  this->Update_Address_Scaling_Factors(scale_factors,word_size);

	  vector<int> shift_factors;
	  this->Update_Address_Shift_Factors(shift_factors,word_size);

	  this->Write_VC_Load_Store_Constants(this->Get_Index_Vector(),&scale_factors,
					      &shift_factors,
					      ofile);
	}
    }
}

void AaArrayObjectReference::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  if(this->Is_Constant())
    return;

  ofile << "// " << this->To_String() << endl;
  
  
  if(this->Get_Object_Type()->Is_Pointer_Type())
    {

      // base pointer.. will need to be declared?
      // certainly..
      if(this->_object->Is_Expression())
	{
	  ((AaExpression*)this->_object)->Write_VC_Wire_Declarations(false,ofile);
	}
      else if(this->_object->Is_Storage_Object())
	{
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Wire_Declarations(false,ofile);
	}
      
      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Wires(this->Get_Index_Vector(),
						    &scale_factors,
						    &shift_factors,
						    ofile);
    }
  else if(this->_object->Is_Storage_Object())
    {

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      this->Write_VC_Load_Store_Wires(this->Get_Index_Vector(),
				      &scale_factors,
				      &shift_factors,
				      ofile);
    }
  else 
    {
      if(this->_object->Is_Expression())
	{
	  AaExpression* expr = ((AaExpression*) (this->_object));
	  expr->Write_VC_Wire_Declarations(false,ofile);
	}
      else if(this->_object->Is("AaInterfaceObject"))
	{
	  // do nothing.
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  string pipe_wire = this->Get_VC_Name() + "_pipe_read_data";
	  Write_VC_Wire_Declaration(pipe_wire,	  
				    ((AaObject*)(this->_object))->Get_Type(),
				    ofile);
	}

    }


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

  vector<int> shift_factors;
  this->Update_Address_Shift_Factors(shift_factors,word_size);
  
  this->Write_VC_Load_Store_Wires(this->Get_Index_Vector(),
				  &scale_factors,
				  &shift_factors,
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

  vector<int> shift_factors;
  this->Update_Address_Shift_Factors(shift_factors,word_size);

  this->Write_VC_Store_Data_Path(&_indices,
				 &scale_factors,
				 &shift_factors,
				 (source ? source : this),
				 ofile);
}

void AaArrayObjectReference::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
  
  if(this->Is_Constant())
    return;
  

  ofile << "// " << this->To_String() << endl;

  if(this->Get_Object_Type()->Is_Pointer_Type())
    {
      if(this->_object->Is_Storage_Object())
	{
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Datapath_Instances(NULL,ofile);
	}
      
      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);
      
      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Data_Path(this->Get_Index_Vector(),
							&scale_factors,
							&shift_factors,
							ofile);

      // final register.
      string dpe_name =  this->Get_VC_Name() + "_final_reg";
      string src_name = this->Get_VC_Root_Address_Name();
      string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

      Write_VC_Interlock_Buffer(dpe_name,
			        src_name,
				tgt_name,
				this->Get_VC_Guard_String(),
			        ofile);

      //  extreme pipelining.
      if(this->Is_Part_Of_Extreme_Pipeline())
	{
		ofile << "$buffering  $in " << dpe_name << " "
			<< src_name << " 2" << endl;
		ofile << "$buffering  $out " << dpe_name << " "
			<< tgt_name << " 2" << endl;
	}

    }
  else if(this->_object->Is_Storage_Object())
  {
	  int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      this->Write_VC_Load_Data_Path(this->Get_Index_Vector(),
				    &scale_factors,
				    &shift_factors,
				    (target ? target : this),
				    ofile);
    }
  else
    {
      string source_wire;
      AaType* obj_type =  NULL;
      if(this->_object->Is_Expression())
	{
	  AaExpression* expr =(AaExpression*) (this->_object);
	  expr->Write_VC_Datapath_Instances(NULL,ofile);
	  obj_type = expr->Get_Type();
	  source_wire = expr->Get_VC_Driver_Name();
	}
      else if(this->_object->Is("AaInterfaceObject"))
	{
	  source_wire = ((AaObject*)this->_object)->Get_VC_Name();
	  obj_type = ((AaObject*)(this->_object))->Get_Type();
	}
      else if(this->_object->Is("AaPipeObject"))
	{
	  source_wire = this->Get_VC_Name() + "_pipe_read_data";
	  obj_type = ((AaObject*)(this->_object))->Get_Type();
	  string pipe_inst = this->Get_VC_Name() + "_pipe_access";
	  Write_VC_IO_Input_Port((AaPipeObject*)(this->_object), pipe_inst,source_wire,
				  this->Get_VC_Guard_String(),
					ofile);
	  // extreme pipelining
	  if(this->Is_Part_Of_Extreme_Pipeline())
	  {
			ofile << "$buffering  $out " << pipe_inst << " "
				<< source_wire << " 2" << endl;
	  }
	}
      else
	assert(0);
	    
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,1);

      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,1);

      int offset_value = this->AaObjectReference::Evaluate(this->Get_Index_Vector(),&scale_factors,&shift_factors);
      
      if(offset_value >= 0)
	{
	  int high_index = (this->Get_Type()->Size() + offset_value)-1;
	  int low_index  = offset_value;

	  string dpe_name = this->Get_VC_Name() + "_slice";
	  string src_name = source_wire;
	  string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());
	  
	  Write_VC_Slice_Operator(dpe_name,
				  src_name,
				  tgt_name,
				  high_index,
				  low_index,
				  this->Get_VC_Guard_String(),
				  ofile);
	  // extreme pipelining
	  if(this->Is_Part_Of_Extreme_Pipeline())
	  {
			ofile << "$buffering  $in " << dpe_name << " "
				<< src_name << " 2" << endl;
			ofile << "$buffering  $out " << dpe_name << " "
				<< tgt_name << " 2" << endl;
	  }
	}
      else
	{
	  AaRoot::Error("in extract element expression, indices must be constants",this);
	}
    }
}

void AaArrayObjectReference::Write_VC_Links(string hier_id, ostream& ofile)
{

  if(this->Is_Constant())
    return;
  
  ofile << "// " << this->To_String() << endl;
  if(this->Get_Object_Type()->Is_Pointer_Type())
    {

      if(this->_object->Is_Storage_Object())
	{
	  assert(this->_pointer_ref);
	  // the object needs to be loaded..  
	  // do the needful..
	  this->_pointer_ref->Write_VC_Links(hier_id,ofile);
	}
      
      hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());

      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      // the return value is a pointer,
      // calculate the address.
      this->Write_VC_Root_Address_Calculation_Links(hier_id,
						    this->Get_Index_Vector(),
						    &scale_factors,
						    &shift_factors,
						    ofile);

      vector<string> reqs;
      vector<string> acks;
      reqs.push_back(hier_id + "/Interlock/Sample/req");
      reqs.push_back(hier_id + "/Interlock/Update/req");
      acks.push_back(hier_id + "/Interlock/Sample/ack");
      acks.push_back(hier_id + "/Interlock/Update/ack");
      Write_VC_Link(this->Get_VC_Name() + "_final_reg",
		    reqs,
		    acks,
		    ofile);
    }
  else if(this->_object->Is_Storage_Object())
    {
      int word_size = this->Get_Word_Size();
      vector<int> scale_factors;
      this->Update_Address_Scaling_Factors(scale_factors,word_size);

      vector<int> shift_factors;
      this->Update_Address_Shift_Factors(shift_factors,word_size);

      this->Write_VC_Load_Links(hier_id,
				this->Get_Index_Vector(),
				&scale_factors,
				&shift_factors,
				ofile);
    }
  else
    {
      vector<string> reqs;
      vector<string> acks;
      hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());

      if(this->_object->Is_Expression())
	{
	  AaExpression* expr =(AaExpression*) (this->_object);
	  expr->Write_VC_Links(hier_id,ofile);
	}
      else if(this->_object->Is("AaInterfaceObject"))
	{
	}
      else if(this->_object->Is("AaPipeObject"))
	{

	  reqs.push_back(hier_id + "/pipe_read_req");
	  acks.push_back(hier_id + "/pipe_read_ack");
	  Write_VC_Link(this->Get_VC_Name() + "_pipe_access",
			reqs,
			acks,
			ofile);
	}

      reqs.push_back(hier_id + "/slice_req");
      acks.push_back(hier_id + "/slice_ack");
      Write_VC_Link(this->Get_VC_Name() + "_slice",
		    reqs,
		    acks,
		    ofile);
    }
}
  
void AaArrayObjectReference::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
    
  int word_size = this->Get_Word_Size();
  vector<int> scale_factors;
  this->Update_Address_Scaling_Factors(scale_factors,word_size);

  vector<int> shift_factors;
  this->Update_Address_Shift_Factors(shift_factors,word_size);

  this->Write_VC_Store_Links(hier_id,
			     &_indices,
			     &scale_factors,
			     &shift_factors,
			     ofile);
}

void AaArrayObjectReference::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	for(int idx = 0, fidx = _indices.size(); idx < fidx; idx++)
	{
		_indices[idx]->Update_Adjacency_Map(adjacency_map,visited_elements);
		__InsMap(adjacency_map,_indices[idx],this,this->Get_Delay());
	}

	if(_pointer_ref)
	{
		_pointer_ref->Update_Adjacency_Map(adjacency_map,visited_elements);
		__InsMap(adjacency_map,_pointer_ref,this,this->Get_Delay());
	}
}


void AaArrayObjectReference::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	for(int idx = 0, fidx = _indices.size(); idx < fidx; idx++)
	{
		AaExpression* ind_exp = _indices[idx];
		bool is_implicit = ind_exp->Is_Implicit_Variable_Reference();
		if((ind_exp == used_expr) || (is_implicit &&  (ind_exp->Get_Root_Object() == used_expr->Get_Root_Object())) )
		{
			AaExpression* new_indx = new AaSimpleObjectReference(this->Get_Scope(),replacement);
			_indices[idx] = new_indx;
			this->AaExpression::Replace_Uses_By(ind_exp, new_indx);
		}
	}	

	if(_pointer_ref != NULL)
	{
	   this->Replace_Field_Expression((AaExpression**) &_pointer_ref, used_expr, replacement);
	}
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
  AaProgram::_pointer_dereferences.insert(this);

  this->Set_Delay(2);

}



void AaPointerDereferenceExpression::Print(ostream& ofile)
{
  ofile << "->(";
  this->_reference_to_object->Print(ofile);
  ofile << ")";
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

      AaRoot* obj = this->_reference_to_object->Get_Object();
      if(obj != NULL)
	{
	  if(obj->Is_Object())
	    {
	      ((AaObject*) obj)->Set_Is_Dereferenced(true);
	    }
	  else if(obj->Is_Expression())
	    {
	      if(((AaExpression*)obj)->Is_Object_Reference())
		((AaObjectReference*) obj)->Set_Is_Dereferenced(true);	      
	    }
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

void AaPointerDereferenceExpression::Evaluate()
{
  	if((this->Get_Addressed_Object_Representative() == NULL)
     		|| this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
	{
      		AaRoot::Error("pointer dereference to foreign object.. will assume it is not defined", this);
		AaValue* v = Make_Aa_Value(this->Get_Scope(),this->Get_Type());
	  	this->_expression_value = v;
	}
}

// two ways you can get here if this is a target: you
// can get from _reference_to_object or you can get here
// from the RHS of an assignment statement.
//
// if it is from the RHS, then obj is attached as the
// address_rep of _reference_to_object->addr_obj_rep..
//
// otherwise, obj is combined with this..
void AaPointerDereferenceExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_expr)
{
  if(!this->Get_Coalesce_Flag())
    {
      this->Set_Coalesce_Flag(true);

      bool from_ref = (from_expr == (AaRoot*)this->_reference_to_object);

      if(AaProgram::_verbose_flag)
	AaRoot::Info("coalescing: propagating " + (obj ? obj->Get_Name() : "null") + " from expression " + this->To_String()
		     + this->Get_Source_Info());

      // why are we doing this?
      if(obj != NULL && from_ref)
	{
	  int acc_width = 0;
	  AaType* ptr_type = this->_reference_to_object->Get_Type();
	  assert(ptr_type->Is_Pointer_Type());
	  acc_width = ((AaPointerType*) ptr_type)->Get_Ref_Type()->Size();

	  obj->Add_Access_Width(acc_width);

	  if(this->Get_Is_Target())
	    obj->Set_Is_Written_Into(true);
	  else
	    obj->Set_Is_Read_From(true);


	  if(!obj->Is_Foreign_Storage_Object())
	    // this expression accesses obj.
	    AaProgram::Add_Storage_Dependency(this,obj);
	}


      if(obj != NULL && !from_ref && this->Get_Is_Target())
	{
	  _addressed_objects_from_rhs.insert(obj);
	}

      // OK. this gets the addressed object representative...
      // but only if it is from the reference.
      if((this->Get_Addressed_Object_Representative()) != NULL && (obj != NULL) && from_ref)
	{
	  AaProgram::Add_Storage_Dependency(obj,this->Get_Addressed_Object_Representative());
	}

      if(from_ref && obj != NULL)
	this->Set_Addressed_Object_Representative(obj);

      
      // address rep of _reference to object 
      if(this->Get_Is_Target())
	{
	  assert(_reference_to_object->Is("AaSimpleObjectReference"));

	  AaRoot* root_ref = ((AaSimpleObjectReference*)_reference_to_object)->Get_Object();

	  set<AaStorageObject*>::iterator riter, friter;
	  if(root_ref->Is_Object())
	    {
	      set<AaStorageObject*>& ref_reps  = ((AaObject*)root_ref)->Get_Addressed_Objects();
	      riter = ref_reps.begin();
	      friter = ref_reps.end();
	    }
	  else if(root_ref->Is("AaSimpleObjectReference"))
	    {
	      set<AaStorageObject*>& ref_reps = ((AaSimpleObjectReference*)root_ref)->Get_Addressed_Objects();
	      riter = ref_reps.begin();
	      friter = ref_reps.end();
	    }
	  else
	    assert(0);
	  
	  
	  for(;riter != friter; riter++)
	    {
	      AaStorageObject* obj1 = *riter;
	      for(set<AaStorageObject*>::iterator siter = _addressed_objects_from_rhs.begin(),
		    fsiter = _addressed_objects_from_rhs.end();
		  siter != fsiter;
		  siter++)
		{
		  obj1->Propagate_Addressed_Object_Representative(*siter,this);
		}
	    }
	}

      

      if(obj != NULL && from_ref)
	{
	  // if obj came here from ref, it is the addressed objects of
	  // obj that must go ahead to all targets of this expression..
	  set<AaStorageObject*>& ref_reps = obj->Get_Addressed_Objects();
	  for(set<AaStorageObject*>::iterator riter = ref_reps.begin(), friter = ref_reps.end();
	      riter != friter;
	      riter++)
	    {
	      AaStorageObject* obj2 = *riter;
	      
	      if(obj2 != NULL)
		{
		  // propagate to all expressions that are targets of this expression.
		  for(set<AaExpression*>::iterator iter = _targets.begin();
		      iter != _targets.end();
		      iter++)
		    {
		      (*iter)->Propagate_Addressed_Object_Representative(obj2, this);
		    }
		}
	    }
	}
      else if(obj != NULL && !from_ref)
	{
	  // if obj did not come here from ref, then obj goes
	  // ahead..
	  for(set<AaExpression*>::iterator iter = _targets.begin();
	      iter != _targets.end();
	      iter++)
	    {
	      (*iter)->Propagate_Addressed_Object_Representative(obj, this);
	    }
	}

      // finally continue the DFS directly from the siblings of this deref expression.
      if(this->Get_Is_Target() && !from_ref)
	{
	  set<AaPointerDereferenceExpression*> sibling_set;
	  this->Get_Siblings(sibling_set, true, false);
	  
	  for(set<AaPointerDereferenceExpression*>::iterator siter = sibling_set.begin(), fsiter = sibling_set.end();
	      siter != fsiter;
	      siter++)
	    {
	      (*siter)->Propagate_Addressed_Object_Representative(obj,this);
	    }
	}

      this->Set_Coalesce_Flag(false);
    }
}

void AaPointerDereferenceExpression::Get_Siblings(set<AaPointerDereferenceExpression*>& sibling_set, bool get_sources, bool get_targets)
{
  assert(this->_reference_to_object->Is("AaSimpleObjectReference"));
  
  AaRoot* root_ref = ((AaSimpleObjectReference*)_reference_to_object)->Get_Object();
  
  set<AaStorageObject*>::iterator riter, friter;
  if(root_ref->Is_Object())
    {
      AaObject* obj = ((AaObject*) root_ref);
      for(set<AaRoot*>::iterator iter = _source_references.begin();
	  iter != _source_references.end();
	  iter++)
	{
	  if((*iter)->Is("AaPointerDereferenceExpression"))
	    {
	      AaPointerDereferenceExpression* expr = ((AaPointerDereferenceExpression*)(*iter));
	      if( (expr != this) && (expr->Get_Is_Target() ? get_targets : get_sources))
		{
		  sibling_set.insert(expr);
		}
	    }
	}
    }
  else if(root_ref->Is("AaSimpleObjectReference"))
    {
      AaExpression* sref = ((AaSimpleObjectReference*) root_ref);
      for(set<AaExpression*>::iterator iter = sref->Get_Targets().begin(), fiter = sref->Get_Targets().end();
	  iter != fiter;
	  iter++)
	{
	  if((*iter)->Is("AaPointerDereferenceExpression"))
	    {
	      AaPointerDereferenceExpression* expr = ((AaPointerDereferenceExpression*)(*iter));
	      if((expr != this) && (expr->Get_Is_Target() ? get_targets : get_sources))
		{
		  sibling_set.insert(expr);
		}
	    }
	}
    }
}
  
void AaPointerDereferenceExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	_reference_to_object->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,_reference_to_object,this,this->Get_Delay());
}

bool AaPointerDereferenceExpression::Is_Foreign_Store()
{
  return(this->Is_Store() &&
	 ((this->Get_Addressed_Object_Representative() == NULL) ||
	  (this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())));
}

bool AaPointerDereferenceExpression::Is_Foreign_Load()
{
  return(this->Is_Load() &&
	 ((this->Get_Addressed_Object_Representative() == NULL) ||
	  (this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())));
}

void AaPointerDereferenceExpression::Write_VC_Control_Path( ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;

  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      AaRoot::Error("pointer dereference to foreign object!", this);
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }
  this->_reference_to_object->Write_VC_Control_Path(ofile);
  this->Write_VC_Load_Control_Path(NULL,NULL,NULL,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;


  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      AaRoot::Error("pointer dereference to foreign object!", this);
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }
  this->_reference_to_object->Write_VC_Control_Path(ofile);
  this->Write_VC_Store_Control_Path(NULL,NULL,NULL,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  this->_reference_to_object->Write_VC_Constant_Wire_Declarations(ofile);
  this->Write_VC_Load_Store_Constants(NULL,NULL,NULL,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;

  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  
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
  this->Write_VC_Load_Store_Wires(NULL,NULL,NULL,ofile);
}
void AaPointerDereferenceExpression::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;

  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }


  this->_reference_to_object->Write_VC_Wire_Declarations(false,ofile);  
  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
					 this->Get_Type(),
					 ofile);
  this->Write_VC_Load_Store_Wires(NULL,NULL,NULL,ofile);
}
void AaPointerDereferenceExpression::Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source)
{
  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }


  this->_reference_to_object->Write_VC_Datapath_Instances(NULL, ofile);  
  // address will arrive from base.
  this->Write_VC_Store_Data_Path(NULL,
				 NULL,
				 NULL,
				 ((source != NULL) ? source : this),
				 ofile);
}
void AaPointerDereferenceExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{ 

  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  this->_reference_to_object->Write_VC_Datapath_Instances(NULL, ofile);  
  this->Write_VC_Load_Data_Path(NULL,
				NULL,
				NULL,
				((target != NULL) ? target : this),
				ofile);
}
void AaPointerDereferenceExpression::Write_VC_Links(string hier_id, ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  this->_reference_to_object->Write_VC_Links(hier_id,ofile);
  this->Write_VC_Load_Links(hier_id,
			    NULL,
			    NULL,
			    NULL,
			    ofile);
}

void AaPointerDereferenceExpression::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{ 
  ofile << "// " << this->To_String() << endl;
  if((this->Get_Addressed_Object_Representative() == NULL)
     || this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
    {
      ofile << "// foreign memory space access omitted!" << endl;
      return;
    }

  this->_reference_to_object->Write_VC_Links(hier_id,ofile);
  this->Write_VC_Store_Links(hier_id,
			     NULL,
			     NULL,
			     NULL,
			     ofile);
}

void AaPointerDereferenceExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
   this->Replace_Field_Expression((AaExpression**) &_reference_to_object, used_expr, replacement);
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
  this->Set_Delay(2);
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
  ofile << "(&(";
  if(this->_reference_to_object->Is("AaArrayObjectReference"))
    {
      AaArrayObjectReference* obj_ref = ((AaArrayObjectReference*)(this->_reference_to_object));
      obj_ref->AaObjectReference::PrintC(ofile,"");
      ofile << obj_ref->Get_Object_Root_Name();
      obj_ref->Print_Indexed_C(obj_ref->Get_Object()->Get_Type(),0,obj_ref->Get_Index_Vector(),ofile);
    }
  else if(this->_reference_to_object->Is("AaSimpleObjectReference"))
    {
      AaSimpleObjectReference* obj_ref = ((AaSimpleObjectReference*)(this->_reference_to_object));
      obj_ref->AaObjectReference::PrintC(ofile,"");
      ofile << obj_ref->Get_Object_Root_Name();
    }
  else
    {
      assert(0);
    }

  ofile << ")) " << endl;
}


void AaAddressOfExpression::Map_Source_References(set<AaRoot*>& source_objects)
{
  this->_reference_to_object->Map_Source_References(source_objects);

  AaRoot* tobj = this->_reference_to_object->Get_Object();

   if(tobj != NULL)
    {
      if(!tobj->Is("AaStorageObject"))
  	{
      		AaRoot::Error("address-of expression must refer to a storage object",this);
		return;
	}
      else
      	{
		if(((AaStorageObject*)tobj)->Get_Register_Flag())
		{
      			AaRoot::Error("address-of expression cannot refer to a register object",this);
			return;
		}
	}
    }
  

  // this expression definitely points to a storage object...
  AaStorageObject* obj = (AaStorageObject*) tobj; 
  this->_storage_object = obj;

  if(this->_reference_to_object->Get_Type())
    {
      AaType* ref_obj_type = this->_reference_to_object->Get_Type();
      this->Set_Type(AaProgram::Make_Pointer_Type(ref_obj_type));
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


void AaAddressOfExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_expr)
{

  // @(p) always propagates forward, because
  // _storage_object may have an updated 
  // representative..
  this->Set_Addressed_Object_Representative(this->_storage_object);
  if(AaProgram::_verbose_flag)
    AaRoot::Info("coalescing: propagating " + (obj ? obj->Get_Name() : "null") + " from expression " + this->To_String()
		 + this->Get_Source_Info());

  this->AaExpression::Propagate_Addressed_Object_Representative(this->_storage_object, this);

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
	  if(obj_ref->Get_Does_Pipe_Access())
	    {
	      this->Set_Does_Pipe_Access(true);
	    }

	  int word_size = obj_ref->Get_Word_Size();
	  vector<int> scale_factors;
	  obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

	  vector<int> shift_factors;
	  obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);

	  int offset_value = obj_ref->AaObjectReference::Evaluate(obj_ref->Get_Index_Vector(),
								  &scale_factors,
								  &shift_factors);
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

      vector<int> shift_factors;
      obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);


      ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;

      obj_ref->Write_VC_Root_Address_Calculation_Control_Path(obj_ref->Get_Index_Vector(),
							      &scale_factors,
							      &shift_factors,
							      ofile);

      ofile << "||[Interlock] {" << endl;
      ofile << ";;[Sample] {" << endl;
      ofile << "$T [req] $T [ack]" << endl;
      ofile << "}" << endl;
      ofile << ";;[Update] {" << endl;
      ofile << "$T [req] $T [ack]" << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;
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

      vector<int> shift_factors;
      obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);

      obj_ref->Write_VC_Root_Address_Calculation_Constants(obj_ref->Get_Index_Vector(),
							   &scale_factors,
							   &shift_factors,
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

      vector<int> shift_factors;
      obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);

      // this calculates a final root address..
      // it will be named obj_ref->Get_VC_Root_Address_Name();
      obj_ref->Write_VC_Root_Address_Calculation_Wires(obj_ref->Get_Index_Vector(),
						       &scale_factors,
						       &shift_factors,
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

      vector<int> shift_factors;
      obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);

      obj_ref->Write_VC_Root_Address_Calculation_Data_Path(obj_ref->Get_Index_Vector(),
							  &scale_factors,
							   &shift_factors,
							  ofile);
      
      AaType* addr_type  = AaProgram::Make_Uinteger_Type(_storage_object->Get_Address_Width());
      string dpe_name = this->Get_VC_Name() + "_final_reg";
      string src_name = obj_ref->Get_VC_Root_Address_Name();
      string tgt_name = ((target != NULL) ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

      Write_VC_Interlock_Buffer(dpe_name,
				src_name,
				tgt_name,
			        this->Get_VC_Guard_String(),
			        ofile);
	// extreme pipelining.
	if(this->Is_Part_Of_Extreme_Pipeline())
	{
		ofile << "$buffering  $in " << dpe_name << " "
			<< src_name << " 2" << endl;
		ofile << "$buffering  $out " << dpe_name << " "
			<< tgt_name << " 2" << endl;
	}
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

      vector<int> shift_factors;
      obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);



      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
      obj_ref->Write_VC_Root_Address_Calculation_Links(hier_id,
						       obj_ref->Get_Index_Vector(),
						       &scale_factors,
						       &shift_factors,
						       ofile);
						       
      vector<string> reqs;
      vector<string> acks;
      reqs.push_back(hier_id + "/Interlock/Sample/req");
      reqs.push_back(hier_id + "/Interlock/Update/req");
      acks.push_back(hier_id + "/Interlock/Sample/ack");
      acks.push_back(hier_id + "/Interlock/Update/ack");
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

void AaAddressOfExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	_reference_to_object->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,_reference_to_object,this,this->Get_Delay());
}

void AaAddressOfExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	// this should never happen, because replacement is always by an implicit
	// variable
	assert(0);
}

//---------------------------------------------------------------------
// type cast expression (is unary)
//---------------------------------------------------------------------
AaTypeCastExpression::AaTypeCastExpression(AaScope* parent, AaType* ref_type,AaExpression* rest):AaExpression(parent)
{
  this->_bit_cast = false;
  this->_to_type = ref_type;
  this->_type = ref_type;
  this->_rest = rest;
  if(rest)
    rest->Add_Target(this);

  this->Set_Delay(1);
}

AaTypeCastExpression::~AaTypeCastExpression() {};
void AaTypeCastExpression::Print(ostream& ofile)
{
  string cast_name = (_bit_cast ? "$bitcast" : "$cast");
  ofile << "(" << cast_name << " (" ;
  this->Get_To_Type()->Print(ofile);
  ofile << ") ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}


void AaTypeCastExpression::PrintC(ofstream& ofile, string tab_string)
{
  if(this->_bit_cast)
    {
      AaRoot::Error("bit-cast not supported in Aa2C", this);
    }

  ofile << tab_string << "(" << "(" << this->_to_type->CBaseName() << ") ";
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

      // either it will be a register or a split conversion
      // operator..
      ofile << "||[SplitProtocol] {" << endl;
      ofile << ";;[Sample] {" << endl;
      ofile << "$T [rr] $T [ra]  " << endl;
      ofile << "}" << endl;
      ofile << ";;[Update] {" << endl;
      ofile << "$T [cr] $T [ca] " << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;
    }
}

void AaTypeCastExpression::Evaluate()
{
  if(!_already_evaluated)
    {
      _already_evaluated = true;

      if(this->_rest->Get_Type() == NULL)
	this->_rest->Set_Type(this->Get_To_Type());

      this->_rest->Evaluate();
      if(this->_rest->Is_Constant())
	this->Assign_Expression_Value(this->_rest->Get_Expression_Value());

      if(_rest->Get_Does_Pipe_Access())
	{
	  this->Set_Does_Pipe_Access(true);
	}
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
	  bool ilb_flag = false;
	  if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
	  {
		  ilb_flag = true;
	  }

	  this->_rest->Write_VC_Datapath_Instances(NULL,ofile);

	  ofile << "// " << this->To_String() << endl;
	  string dpe_name = this->Get_VC_Datapath_Instance_Name();
	  string src_name = this->_rest->Get_VC_Driver_Name(); 
	  string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());
	  if(ilb_flag)
	  {
		  Write_VC_Interlock_Buffer(dpe_name,
				  src_name,
				  tgt_name,
				  this->Get_VC_Guard_String(),
				  ofile);

	  }
	  else
	  {

		  Write_VC_Unary_Operator(__NOP,
				  dpe_name,
				  src_name,
				  this->_rest->Get_Type(),
				  tgt_name,
				  this->Get_Type(),
				  this->Get_VC_Guard_String(),
				  ofile);
	  }
	  // extreme pipelining.
	  if(this->Is_Part_Of_Extreme_Pipeline())
	  {
		  ofile << "$buffering  $in " << dpe_name << " "
			  << src_name << " 2" << endl;
		  ofile << "$buffering  $out " << dpe_name << " "
			  << tgt_name << " 2" << endl;
	  }
  }
}

void AaTypeCastExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Links(hier_id + "/" + this->Get_VC_Name(), ofile);


		ofile << "// " << this->To_String() << endl;

		vector<string> reqs,acks;

		string sample_regn = hier_id  + "/" + this->Get_VC_Name() + "/SplitProtocol/Sample";
		string update_regn = hier_id  + "/" + this->Get_VC_Name() + "/SplitProtocol/Update";
		reqs.push_back( sample_regn + "/rr");
		reqs.push_back( update_regn + "/cr");
		acks.push_back( sample_regn +  "/ra");
		acks.push_back( update_regn + "/ca");

		Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}
}

void AaTypeCastExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	_rest->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,_rest,this,this->Get_Delay());
}

void AaTypeCastExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_rest, used_expr, replacement);
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

	this->Set_Delay(1);
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

//
//   unary operators have a split protocol 
//     start-req -> start-ack 
//     complete-req -> complete-ack.
//   both req-ack sequences are started in parallel.
//
//  
void AaUnaryExpression::Write_VC_Control_Path(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  

  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // unary expression " << endl;
      this->_rest->Write_VC_Control_Path(ofile);

	ofile << "||[SplitProtocol] { " << endl;
	ofile << ";;[Sample] { " << endl;
      	ofile << "$T [rr] $T [ra]" << endl;
	ofile << "}" << endl;
	ofile << ";;[Update] { " << endl;
      	ofile << "$T [cr] $T [ca]" << endl;
	ofile << "}" << endl;
	ofile << "}" << endl;

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
      if(_rest->Get_Does_Pipe_Access())
	{
	  this->Set_Does_Pipe_Access(true);
	}
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

      string dpe_name = this->Get_VC_Datapath_Instance_Name();
      string src_name = this->_rest->Get_VC_Driver_Name(); 
      string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

      Write_VC_Unary_Operator(this->Get_Operation(),
		      dpe_name,
		      src_name,
		      this->_rest->Get_Type(),
		      tgt_name,
		      (target != NULL ? target->Get_Type() : this->Get_Type()),
		      this->Get_VC_Guard_String(),
		      ofile);
      // extreme pipelining.
      if(this->Is_Part_Of_Extreme_Pipeline())
      {
	      ofile << "$buffering  $in " << dpe_name << " "
		      << src_name << " 2" << endl;
	      ofile << "$buffering  $out " << dpe_name << " "
		      << tgt_name << " 2" << endl;
      }
    }

}
void AaUnaryExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Links(hier_id + "/" + this->Get_VC_Name(), ofile);

		ofile << "// " << this->To_String() << endl;

		vector<string> reqs,acks;

		string sample_region = hier_id + "/" + this->Get_VC_Name() + "/SplitProtocol/Sample";
		string update_region = hier_id + "/" + this->Get_VC_Name() + "/SplitProtocol/Update";
		reqs.push_back(sample_region + "/rr");
		reqs.push_back(update_region + "/cr");
		acks.push_back(sample_region + "/ra");
		acks.push_back(update_region + "/ca");

		Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}
}

void AaUnaryExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	_rest->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,_rest,this,this->Get_Delay());
}

void AaUnaryExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_rest, used_expr, replacement);
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
		AaProgram::Add_Type_Dependency(first,second);
	}
	else if(!Is_Concat_Operation(op))
	{
		AaProgram::Add_Type_Dependency(first,this);
		AaProgram::Add_Type_Dependency(second,this);
	}

	this->Update_Type();

  this->Set_Delay(1);
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
  AaType* t1 = this->Get_First()->Get_Type();
  AaType* t2 = this->Get_Second()->Get_Type();

  if(Is_Concat_Operation(this->_operation) && (this->Get_Type() == NULL))
    {
      // check the types of both sources.
      // they must both be uintegers and
      // the type of this expression must
      // be a uinteger whose width is the
      // sume of those of the sources.

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
	  // both arguments of a shift-operator must have the same
	  // width!
	  this->_second->Set_Type(this->_first->Get_Type());
	}
    }
  else if((t1 != NULL) && (t2 != NULL) && t1->Is("AaFloatType") && t2->Is("AaFloatType"))
	// float operations will have higher delay!
	this->Set_Delay(10);
  
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

// TODO:
//   Binary expressions are to be considered to be of two types.
//   - pipelined (split)
//   - unitary (non-split).
//
//   Pipelined binary operators have a split protocol 
//     start-req -> start-ack -> complete-req -> complete-ack.
//
//   Unitary binary operators have a simple protocol
//     req -> ack
//   (similar to registers).
//
//  
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

	ofile << "||[SplitProtocol] { " << endl;
	ofile << ";;[Sample] { " << endl;
      	ofile << "$T [rr] $T [ra]" << endl;
	ofile << "}" << endl;
	ofile << ";;[Update] { " << endl;
      	ofile << "$T [cr] $T [ca]" << endl;
	ofile << "}" << endl;
	ofile << "}" << endl;

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

      string dpe_name = this->Get_VC_Datapath_Instance_Name();
      string src_1_name = _first->Get_VC_Driver_Name();
      string src_2_name = _second->Get_VC_Driver_Name();
      string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

      Write_VC_Binary_Operator(this->Get_Operation(),
		      dpe_name,
		      src_1_name,
		      _first->Get_Type(),
		      src_2_name,
		      _second->Get_Type(),
		      tgt_name,
		      (target != NULL ? target->Get_Type() : this->Get_Type()),
				  this->Get_VC_Guard_String(),
			       ofile);
      // extreme pipelining.
      if(this->Is_Part_Of_Extreme_Pipeline())
      {
	      ofile << "$buffering  $in " << dpe_name << " "
		      << src_1_name << " 2" << endl;
	      ofile << "$buffering  $in " << dpe_name << " "
		      << src_2_name << " 2" << endl;
	      ofile << "$buffering  $out " << dpe_name << " "
		      << tgt_name << " 2" << endl;
      }
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
      string sample_region = hier_id + "/" + this->Get_VC_Name() + "/SplitProtocol/Sample";
      string update_region = hier_id + "/" + this->Get_VC_Name() + "/SplitProtocol/Update";
      reqs.push_back(sample_region + "/rr");
      reqs.push_back(update_region + "/cr");
      acks.push_back(sample_region + "/ra");
      acks.push_back(update_region + "/ca");
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
      if(_first->Get_Does_Pipe_Access() || _second->Get_Does_Pipe_Access())
	{
	  this->Set_Does_Pipe_Access(true);
	}
    }
}

void AaBinaryExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	_first->Update_Adjacency_Map(adjacency_map, visited_elements);
	_second->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,_first,this,this->Get_Delay());
	__InsMap(adjacency_map,_second,this,this->Get_Delay());
}

void AaBinaryExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_first, used_expr, replacement);
	this->Replace_Field_Expression(&_second, used_expr, replacement);
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

  this->Set_Delay(1);
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

      if( (_test->Get_Does_Pipe_Access()) ||
	  (_if_true->Get_Does_Pipe_Access()) ||
	  (_if_false->Get_Does_Pipe_Access()))
	{
	  this->Set_Does_Pipe_Access(true);
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

      string dpe_name = this->Get_VC_Datapath_Instance_Name();
      string src_1_name = _test->Get_VC_Driver_Name();
      string src_2_name = _if_true->Get_VC_Driver_Name();
      string src_3_name = _if_false->Get_VC_Driver_Name();
      string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

      Write_VC_Select_Operator(dpe_name,
			       src_1_name,
			       this->_test->Get_Type(),
				src_2_name,
			       this->_if_true->Get_Type(),
				src_3_name,
			       this->_if_false->Get_Type(),
				tgt_name,
			       (target != NULL ? target->Get_Type() : this->Get_Type()),
				  this->Get_VC_Guard_String(),
			       ofile);
	// extreme pipelining.
      if(this->Is_Part_Of_Extreme_Pipeline())
      {
	      ofile << "$buffering  $in " << dpe_name << " "
		      << src_1_name << " 2" << endl;
	      ofile << "$buffering  $in " << dpe_name << " "
		      << src_2_name << " 2" << endl;
	      ofile << "$buffering  $in " << dpe_name << " "
		      << src_3_name << " 2" << endl;
	      ofile << "$buffering  $out " << dpe_name << " "
		      << tgt_name << " 2" << endl;
      }
			       
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



void AaTernaryExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	_test->Update_Adjacency_Map(adjacency_map, visited_elements);
	_if_true->Update_Adjacency_Map(adjacency_map, visited_elements);
	_if_false->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,_test,this,this->Get_Delay());
	__InsMap(adjacency_map,_if_true,this,this->Get_Delay());
	__InsMap(adjacency_map,_if_false,this,this->Get_Delay());
}

void AaTernaryExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_test, used_expr, replacement);
	this->Replace_Field_Expression(&_if_true, used_expr, replacement);
	this->Replace_Field_Expression(&_if_false, used_expr, replacement);
}
