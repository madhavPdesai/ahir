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
   ofile << "// CP for expression: ";
   this->Print(ofile);
   ofile << endl;

   ofile << ";;[" << this->Get_VC_Name() << "] {"
	 << "$T [dummy] " << endl
	 << "}" << endl;
 }

 void AaExpression::Assign_Expression_Value(AaValue* expr_value)
 {
   if(this->Get_Type()->Is_Integer_Type())
     {
       AaIntValue* nv = (AaIntValue*) Make_Aa_Value(this->Get_Scope(),
						    this->Get_Type());

       nv->Assign(this->Get_Type(),expr_value);
       _expression_value = nv;
     }
   else if(this->Get_Type()->Is_Float_Type())
     {
       AaFloatValue* nv = new AaFloatValue(this->Get_Scope(),
					   ((AaFloatType*)this->Get_Type())->Get_Characteristic(),
					   ((AaFloatType*)this->Get_Type())->Get_Mantissa());
       nv->Assign(this->Get_Type(),expr_value);
       _expression_value = nv;

     }
   else if(this->Get_Type()->Is("AaArrayType"))
     {
       AaArrayValue* nv = new AaArrayValue(this->Get_Scope(),
					   ((AaArrayType*)this->Get_Type())->Get_Element_Type(),
					   ((AaArrayType*)this->Get_Type())->Get_Dimension_Vector());
       assert(expr_value->Is("AaArrayValue") && 
	      (((AaArrayValue*)expr_value)->_value_vector.size() == nv->_value_vector.size()));

       nv->Assign(this->Get_Type(),expr_value);
       _expression_value = nv;
     }
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
   ofile << "// Constant-declaration for expression: ";
   this->Print(ofile);
   ofile << endl;

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
   string ps;
   this->AaRoot::Print(ps);



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
	   this->Write_VC_Load_Control_Path(NULL,ofile);
	 }
       // else if the object being referred to is
       // a pipe, instantiate a series r-a
       // chain for the inport operation
       else if(this->_object->Is("AaPipeObject"))
	 {
	   ofile << "// CP for expression: ";
	   this->Print(ofile);
	   ofile << endl;

	   ofile << ";;[" << this->Get_VC_Name() << "] { // pipe read: " << ps << endl;
	   ofile << "$T [req] $T [ack] " << endl;
	   ofile << "}" << endl;
	 }
     }
 }


 void AaSimpleObjectReference::Write_VC_Control_Path_As_Target( ostream& ofile)
 {

   ofile << "// CP for expression: ";
   this->Print(ofile);
   ofile << endl;

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
       this->Write_VC_Store_Control_Path(NULL,ofile);
     }
   // else if the object being referred to is
   // a pipe, instantiate a series r-a
   // chain for the inport operation
   else if(this->_object->Is("AaPipeObject"))
     {
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
       this->Write_VC_Load_Store_Constants(NULL,ofile);
       this->Write_VC_Load_Store_Wires(NULL,ofile);
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

       // if _object is a storage object, then,
       // make a single-bit constant pointer
       // for use in subsequence store instance.
       if(this->_object->Is("AaStorageObject"))
	 {
	   this->Write_VC_Load_Store_Constants(NULL,ofile);
	   this->Write_VC_Load_Store_Wires(NULL,ofile);
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
       ofile << "// CP-DP links for expression: ";
       this->Print(ofile);
       ofile << endl;

       vector<string> reqs;
       vector<string> acks;

       if(this->_object->Is("AaStorageObject"))
	 {
	   this->Write_VC_Load_Links(hier_id,NULL,ofile);
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

       ofile << "// CP-DP links for expression: ";
       this->Print(ofile);
       ofile << endl;

       vector<string> reqs;
       vector<string> acks;

       if(this->_object->Is("AaStorageObject"))
	 {
	   this->Write_VC_Store_Links(hier_id,NULL,ofile);
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
   ofile << "[";
   for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
     {
       if(i > 0)
	 ofile << " ";
       this->Get_Array_Index(i)->Print(ofile);
     }
   ofile << "]";
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
	   this->_object = obj;
	   AaArrayType* at = ((AaArrayType*)(((AaObject*)obj)->Get_Type()));

	   this->Set_Type(at->Get_Element_Type());

	   // update the types of the index expressions if not 
	   // already set.
	   for(unsigned int i = 0; i < this->Get_Number_Of_Indices(); i++)
	     {
	       if(this->_indices[i]->Get_Type() == NULL)
		 {
		   this->_indices[i]->Set_Type(AaProgram::Make_Uinteger_Type(CeilLog2(at->Get_Dimension(i)-1)));
		 }
	     }

	   ok_flag = true;
	 }
     }
   if(!ok_flag)
     {
       AaRoot::Error("array object reference must be to a storage object.." + this->Get_Object_Ref_String(),this);
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
 void AaArrayObjectReference::Write_VC_Control_Path( ostream& ofile)
 {
   string ps;
   this->AaRoot::Print(ps);

   if(!this->Is_Constant())
     {

       ofile << "// CP for expression: ";
       this->Print(ofile);
       ofile << endl;

       if(this->_object->Is("AaStorageObject"))
	 {
	   if(_indices.size() > 1)
	     {
	       AaRoot::Error("Aa2VC currently does not support multiple dimensional arrays", this);
	       //\todo:  need to instantiate a tree of adders here..
	     }

	   this->Write_VC_Load_Control_Path(_indices[0],
					    ofile);
	 }
       else
	 {
	   AaRoot::Error("illegal array reference", this);
	 }
     }
 }


 void AaArrayObjectReference::Write_VC_Address_Gen_Control_Path(ostream& ofile)
 {
   assert(0); // should never be called..
 }

 void AaArrayObjectReference::Write_VC_Control_Path_As_Target( ostream& ofile)
 {
   ofile << "// CP for expression: ";
   this->Print(ofile);
   ofile << endl;
   
   if(this->_object->Is("AaStorageObject"))
     {
       if(_indices.size() > 1)
	 {
	   AaRoot::Error("Aa2VC currently does not support multiple dimensional arrays", this);
	   //\todo:  need to instantiate a tree of adders here..
	 }
       
       this->Write_VC_Store_Control_Path(_indices[0], ofile);
     }
 }

 void AaArrayObjectReference::Evaluate()
 {

   AaArrayType* at;
   AaType* t = NULL;
   if(this->_object->Is_Expression())
     {
       t = ((AaExpression*)(this->_object))->Get_Type();
     }
   else if(this->_object->Is_Object())
     {
       t = ((AaObject*)(this->_object))->Get_Type();
     }

   assert(t->Is("AaArrayType"));

   at = (AaArrayType*)t;

   if(!_already_evaluated)
     {
       _already_evaluated = true;
       bool all_indices_constants = true;
       vector<int> index_vector;
       for(int idx = 0; idx < _indices.size(); idx++)
	 {

	   // need to evaluate the indices!
	   if(!_indices[idx]->Get_Type())
	     _indices[idx]->Set_Type(AaProgram::Make_Uinteger_Type(CeilLog2(at->Get_Dimension(idx)-1)));

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

       assert(expr_value != NULL && expr_value->Is("AaArrayValue"));
       this->Assign_Expression_Value(((AaArrayValue*)expr_value)->Get_Element(index_vector));
     }
 }

void AaArrayObjectReference::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  if(this->Is_Constant())
    {
      ofile << "// constant-declarations for expression: ";
      this->Print(ofile);
      ofile << endl;
      
      Write_VC_Constant_Declaration(this->Get_VC_Constant_Name(),
				    this->Get_Type(),
				    this->Get_Expression_Value(),
				    ofile);
    }
  else
    {
      _indices[0]->Write_VC_Constant_Wire_Declarations(ofile);
    }
}

void AaArrayObjectReference::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
   assert(this->_object->Is("AaStorageObject"));

   if(this->Is_Constant())
     return;


   this->Write_VC_Load_Store_Wires(_indices[0],
				   ofile);

   // the final load-data.
   if(!skip_immediate)
     Write_VC_Wire_Declaration(this->Get_VC_Driver_Name(),
			       this->Get_Type(),
			       ofile);
}

void AaArrayObjectReference::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{
  if(this->Is_Constant())
    return;
  
  assert(this->_object->Is("AaStorageObject"));
  
  ofile << "// wire-declarations for expression: ";
  this->Print(ofile);
  ofile << endl;
  
  this->Write_VC_Load_Store_Wires(_indices[0],
				  ofile);
}

void AaArrayObjectReference::Write_VC_Datapath_Instances_As_Target(ostream& ofile, AaExpression* source)
{
  
  if(this->Is_Constant())
    return;
  
  assert(this->_object && this->_object->Is("AaStorageObject"));
  
  ofile << "// data-path-instances for expression: ";
  this->Print(ofile);
  ofile << endl;
  
  this->Write_VC_Store_Data_Path(_indices[0],
				 (source ? source : this),
				 ofile);
}

void AaArrayObjectReference::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
  
  if(this->Is_Constant())
    return;
  
  
  ofile << "// data-path-instances for expression: ";
  this->Print(ofile);
  ofile << endl;
  
  this->Write_VC_Load_Data_Path(_indices[0],
				(target ? target : this),
				ofile);
}

void AaArrayObjectReference::Write_VC_Links(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
  
  ofile << "// CP-DP links for expression: ";
  this->Print(ofile);
  ofile << endl;
  
  this->Write_VC_Load_Links(hier_id,
			    _indices[0],
			    ofile);
}

void AaArrayObjectReference::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{
  if(this->Is_Constant())
    return;
  
  ofile << "// CP-DP links for expression: ";
  this->Print(ofile);
  ofile << endl;
  
  this->Write_VC_Store_Links(hier_id,
			     _indices[0],
			     ofile);
}

//---------------------------------------------------------------------
// AaPointerDereferenceExpression
//---------------------------------------------------------------------
AaPointerDereferenceExpression::AaPointerDereferenceExpression(AaScope* scope, AaObjectReference* obj_ref):
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
  this->Write_VC_Load_Control_Path(this->_reference_to_object,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_As_Target( ostream& ofile)
{
  this->Write_VC_Store_Control_Path(this->_reference_to_object,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{ 
  this->Write_VC_Load_Store_Constants(this->_reference_to_object,ofile);
}

void AaPointerDereferenceExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
  if(!skip_immediate)
    {
     
      if(!skip_immediate)
	{
	  ofile << "// wire-declarations for expression: ";
	  this->Print(ofile);
	  ofile << endl;
	  
	  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
						 this->Get_Type(),
						 ofile);
	}
    }
  this->Write_VC_Load_Store_Wires(this->_reference_to_object,ofile);
}
void AaPointerDereferenceExpression::Write_VC_Wire_Declarations_As_Target(ostream& ofile)
{ 
  ofile << "// wire-declarations for expression: ";
  this->Print(ofile);
  ofile << endl;
  
  Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
					 this->Get_Type(),
					 ofile);
  this->Write_VC_Load_Store_Wires(this->_reference_to_object,ofile);
  
}
void AaPointerDereferenceExpression::Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source)
{
  this->Write_VC_Store_Data_Path(this->_reference_to_object,
				 source,
				 ofile);
}
void AaPointerDereferenceExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{ 
  this->Write_VC_Load_Data_Path(this->_reference_to_object,
				target,
				ofile);
}
void AaPointerDereferenceExpression::Write_VC_Links(string hier_id, ostream& ofile)
{ 
  this->Write_VC_Load_Links(hier_id,
			    this->_reference_to_object,
			    ofile);
}
void AaPointerDereferenceExpression::Write_VC_Links_As_Target(string hier_id, ostream& ofile)
{ 
  this->Write_VC_Store_Links(hier_id,
			     this->_reference_to_object,
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
	  AaRoot::Error("type ambiguity in pointer dereference expression", this);
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
	  obj_ref->Get_Indices(0)->Evaluate();
	  if(obj_ref->Get_Indices(0)->Is_Constant())
	    {
	      addr = this->_storage_object->Get_Base_Address()
		+ (this->_storage_object->Get_Offset_Scale_Factor()*
		   (obj_ref->Get_Indices(0)->Get_Expression_Value()->To_Integer()));
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
      ofile << "// CP for expression: ";
      this->Print(ofile);
      ofile << endl;

      assert(this->_reference_to_object->Is("AaArrayObjectReference"));
      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);
      ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;
      obj_ref->Get_Indices(0)->Write_VC_Control_Path(ofile);

      // next A is resized, to produce A_resized
      // this may also be just a renaming..
      ofile << "$T [resize_req] $T [resize_ack]" << endl;

      if(this->_storage_object->Get_Offset_Scale_Factor() > 1)
	ofile << "$T [scale_rr] $T [scale_ra] $T [scale_cr] $T [scale_ca] // scale-offset" << endl;
      else
	ofile << "$T [scale_req] $T [scale_ack] // offset*1 " << endl;
	
      if(this->_storage_object->Get_Base_Address() > 0)      
	ofile << "$T [plus_base_rr] $T [plus_base_ra] $T [plus_base_cr] $T [plus_base_ca] // offset+base" << endl;
      else
	ofile << "$T [plus_base_req] $T [plus_base_ack] // offset+0 " << endl;

      ofile << "$T [final_reg_req] $T [final_reg_ack] // unsigned resize " << endl;
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

  ofile << "// Constants for expression: ";
  this->Print(ofile);
  ofile << endl;

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

      obj_ref->Get_Indices(0)->Write_VC_Constant_Wire_Declarations(ofile);
    }
}
void AaAddressOfExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{ 
  if(!this->Is_Constant())
    {

      ofile << "// wires for expression: ";
      this->Print(ofile);
      ofile << endl;

      if(!skip_immediate)
	{
	  Write_VC_Wire_Declaration(this->Get_VC_Driver_Name(),
				    this->Get_Type()->Get_VC_Name(),
				    ofile);
	}

      assert(this->_reference_to_object->Is("AaArrayObjectReference"));
      AaArrayObjectReference* obj_ref = 
	(AaArrayObjectReference*)(this->_reference_to_object);

      obj_ref->Get_Indices(0)->Write_VC_Wire_Declarations(false,ofile);
      
      // a wire which resizes the address expression to 
      // the required width.
      AaUintType* addr_type = 
	AaProgram::Make_Uinteger_Type(_storage_object->Get_Address_Width());
      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name() + "_resized_address",
					     addr_type,
					     ofile);
      
      
      // for the product of multiplier*addresswire.
      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name() + "_scaled_offset_address",
					     addr_type,
					     ofile);
      
      // for the sum base + offset
      Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name() + "_address",
					     addr_type,
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


      AaUintType* addr_type = AaProgram::Make_Uinteger_Type(_storage_object->Get_Address_Width());
      
      string addr_expr_name =  obj_ref->Get_Indices(0)->Get_VC_Driver_Name();
      string inst_root_name = this->Get_VC_Name();
      string resized_addr_name = this->Get_VC_Driver_Name() + "_resized_address";
      string scaled_offset_name = this->Get_VC_Driver_Name() + "_scaled_offset_address";
      string final_root_address_name = this->Get_VC_Driver_Name() + "_address";
      
      // resize or equivalent?
      bool resize_flag = false;
      AaExpression* address_expression = obj_ref->Get_Indices(0);
      address_expression->Write_VC_Datapath_Instances(NULL,ofile);
      if(address_expression->Get_Type()->Size() != _storage_object->Get_Address_Width())
	{
	  resize_flag = true;
	  // write resize operator.
	  // address -> resized_address
	  
	  Write_VC_Unary_Operator(__NOP,
				  inst_root_name + "_addr_resize",
				  addr_expr_name,
				  address_expression->Get_Type(),
				  resized_addr_name,
				  addr_type,
				  ofile);
				  
	}
      else
	{
	  vector<string> inwires; inwires.push_back(addr_expr_name);
	  vector<string> outwires; outwires.push_back(resized_addr_name);
	  Write_VC_Equivalence_Operator(inst_root_name + "_addr_resize",
					inwires,
					outwires,
					ofile);
	}
      
      // scale operation
      bool scale_flag = (_storage_object->Get_Offset_Scale_Factor() > 1);
      if(scale_flag)
	{
	  // write multiply operator..
	  // resized_address -> scaled_offset
	  Write_VC_Binary_Operator(__MUL,
				   inst_root_name + "_scale_offset",
				   resized_addr_name,
				   addr_type,
				   _storage_object->Get_VC_Offset_Scale_Factor_Name(),
				   addr_type,
				   scaled_offset_name,
				   addr_type,
				   ofile
				   );
	  
	}
      else
	{
	  vector<string> inwires; inwires.push_back(resized_addr_name);
	  vector<string> outwires; outwires.push_back(scaled_offset_name);
	  Write_VC_Equivalence_Operator(inst_root_name + "_scale_offset",
					inwires,
					outwires,
					ofile);
	}
      
      // base+offset operation
      if(_storage_object->Get_Base_Address() > 0)
	{
	  // write multiply operator..
	  // addr = base + scaled_offset
	  Write_VC_Binary_Operator(__PLUS,
				   inst_root_name + "_plus_base",
				   scaled_offset_name,
				   addr_type,
				   _storage_object->Get_VC_Base_Address_Name(),
				   addr_type,
				   final_root_address_name,
				   addr_type,
				   ofile
				   );

	}
      else
	{
	  // an equivalence
	  // scaled_offset -> final_root.
	  vector<string> inwires; 
	  inwires.push_back(scaled_offset_name);
	  vector<string> outwires; 
	  outwires.push_back(final_root_address_name);
	  
	  Write_VC_Equivalence_Operator(inst_root_name + "_plus_base",
					inwires,
					outwires,
					ofile);

	}


      // finally, resize to pointer
      Write_VC_Unary_Operator(__NOP,
			      this->Get_VC_Name() + "_final_reg",
			      final_root_address_name,
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

      //  ofile << ";;[" << this->Get_VC_Name() << "_address_calculate] {" << endl;
      hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
      AaExpression* address_expression = obj_ref->Get_Indices(0);
      
      address_expression->Write_VC_Links(hier_id,ofile);
 
      vector<string> reqs;
      vector<string> acks;
  
      // next A is resized, to produce A_resized
      //  ofile << "$T [resize_req] $T [resize_ack]" << endl;
      reqs.push_back(hier_id + "/resize_req");
      acks.push_back(hier_id + "/resize_ack");
      Write_VC_Link(this->Get_VC_Name() + "_addr_resize",
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();
      
      
      bool scale_flag = (this->_storage_object->Get_Offset_Scale_Factor() > 1);
      if(scale_flag)
	{
	  // A_scaled = A_resized * scale_factor
	  //  ofile << "$T [scale_rr] $T [scale_ra] $T [scale_cr] $T [scale_ca]" << endl;
	  reqs.push_back(hier_id + "/scale_rr");
	  reqs.push_back(hier_id + "/scale_cr");
	  acks.push_back(hier_id + "/scale_ra");
	  acks.push_back(hier_id + "/scale_ca");
	}
      else
	{
	  reqs.push_back(hier_id + "/scale_req");
	  acks.push_back(hier_id + "/scale_ack");
	}
      Write_VC_Link(this->Get_VC_Name() + "_scale_offset",
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();
      
      // A_final = base + A_scaled.
      // ofile << "$T [offset_rr] $T [offset_ra] $T [offset_cr] $T [offset_ca]" << endl;
      if(this->_storage_object->Get_Base_Address() > 0)
	{
	  reqs.push_back(hier_id + "/plus_base_rr");
	  reqs.push_back(hier_id + "/plus_base_cr");
	  acks.push_back(hier_id + "/plus_base_ra");
	  acks.push_back(hier_id + "/plus_base_ca");
	}
      else
	{
	  reqs.push_back(hier_id + "/plus_base_req");
	  acks.push_back(hier_id + "/plus_base_ack");
	}
      Write_VC_Link(this->Get_VC_Name() + "_plus_base",
		    reqs,
		    acks,
		    ofile);
      reqs.clear();
      acks.clear();

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
  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {
      ofile << "// control-path for expression: ";
      this->Print(ofile);
      ofile << endl;
      
      ofile << ";;[" << this->Get_VC_Name() << "] { // type-cast expression: " << ps << endl;
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

      ofile << "// constant-declarations for expression: ";
      this->Print(ofile);
      ofile << endl;
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
	  ofile << "// wire-declarations for expression: ";
	  this->Print(ofile);
	  ofile << endl;
	  
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

      ofile << "// data-path instances for expression: ";
      this->Print(ofile);
      ofile << endl;

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

      ofile << "// CP-DP links for expression: ";
      this->Print(ofile);
      ofile << endl;
      
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
  ofile << " ( ";
  ofile << Aa_Name(this->Get_Operation());
  ofile << " ";
  this->Get_Rest()->Print(ofile);
  ofile << " )";
}

void AaUnaryExpression::Write_VC_Control_Path(ostream& ofile)
{
  string ps;
  this->AaRoot::Print(ps);

  ofile << "// control-path for expression: ";
  this->Print(ofile);
  ofile << endl;


  if(!this->Is_Constant())
    {
      ofile << ";;[" << this->Get_VC_Name() << "] { // unary expression: " << ps << endl;
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

      ofile << "// constant-declarations for expression: ";
      this->Print(ofile);
      ofile << endl;


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

	  ofile << "// wire-declarations for expression: ";
	  this->Print(ofile);
	  ofile << endl;

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


      ofile << "// data-path instances for expression: ";
      this->Print(ofile);
      ofile << endl;

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


      ofile << "// CP-DP links for expression: ";
      this->Print(ofile);
      ofile << endl;

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

  string ps;
  this->AaRoot::Print(ps);

  if(!this->Is_Constant())
    {

      ofile << "// control-path for expression: ";
      this->Print(ofile);
      ofile << endl;

      ofile << ";;[" << this->Get_VC_Name() << "] { // binary expression: " << ps << endl;

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

      ofile << "// constant-declarations for expression: ";
      this->Print(ofile);
      ofile << endl;


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
	  ofile << "// wire-declarations for expression: ";
	  this->Print(ofile);
	  ofile << endl;
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

      ofile << "// data-path-instances for expression: ";
      this->Print(ofile);
      ofile << endl;

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

      ofile << "// CP-DP links for expression: ";
      this->Print(ofile);
      ofile << endl;

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

  ofile << "// control-path for expression: ";
  this->Print(ofile);
  ofile << endl;

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

  ofile << "// constant-declarations for expression: ";
  this->Print(ofile);
  ofile << endl;


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
      ofile << "// wire-declarations for expression: ";
      this->Print(ofile);
      ofile << endl;
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

      ofile << "// data-path-instances for expression: ";
      this->Print(ofile);
      ofile << endl;

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


      ofile << "// CP-DP links for expression: ";
      this->Print(ofile);
      ofile << endl;

      vector<string> reqs,acks;
      reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/req");
      acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/ack");

      Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),
		    reqs,
		    acks,
		    ofile);
    }
}



