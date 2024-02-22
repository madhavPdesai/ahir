//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
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
#include <Aa2C.h>
#include <AaDelays.h>

#define __endl__  "\\\n" 

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
  this->_pipeline_parent = NULL;
  this->_is_intermediate = true;
  this->_buffering = 1;
  this->_guard_expression = NULL;
  this->_guard_complement = false;
  this->_phi_source_index = -1;
}

AaExpression::~AaExpression() {};

bool AaExpression::Is_Flow_Through()
{
	return(this->Is_Trivial() && this->Get_Is_Intermediate());
}

void AaExpression::Check_Volatile_Inconsistency()
{
	this->Check_Volatile_Inconsistency(this->Get_Associated_Statement());
}

void AaExpression::Check_Volatile_Inconsistency(AaStatement* stmt)
{
	if((stmt != NULL) && stmt->Get_Is_Volatile())
	{ 
		if(this->Get_Is_Target() && !this->Is_Implicit_Variable_Reference())
		{
			AaRoot::Error("Targets of volatile statements must be implicit variable refs: "  + this->To_String(), stmt);
		}
		if (!stmt->Is_Call_Statement() && !this->Is_Trivial())
		{
			AaRoot::Error("Expression "  + this->To_String() 
				+ " is not trivial but appears in a volatile assignment statement.", stmt);
		}
	}
}

void AaExpression::Write_VC_Output_Buffering(string dpe_name, string tgt_name, ostream& ofile)
{
	int this_buffering = this->Get_Buffering();
	int stmt_buf = 0;

	AaStatement* stmt = this->Get_Associated_Statement();
	if(stmt->Is("AaAssignmentStatement"))
	{
		AaAssignmentStatement* astmt = (AaAssignmentStatement*) stmt;
		if(astmt->Get_Source() == this)
		{
			stmt_buf = astmt->Get_Buffering();
			
			//
			// Buffering may be attached to the target of
			// the assignment statement..
			//
			if(astmt->Get_Target()->Is_Implicit_Variable_Reference())
			{
				if(astmt->Get_Target()->Get_Buffering() > stmt_buf)
					stmt_buf = astmt->Get_Target()->Get_Buffering();
			}
		}
	}

	if(stmt_buf > this_buffering)
		this_buffering = stmt_buf;

	ofile << "$buffering  $out " << dpe_name << " " << tgt_name << " " << this_buffering << endl;
}

AaModule* AaExpression::Get_Module()
{
	AaStatement* stmt = this->Get_Associated_Statement();
	if(stmt != NULL)
	{
		return(stmt->Get_Module());
	}
	else
		return(NULL);
}

AaMemorySpace* AaExpression::Get_VC_Memory_Space()
{
	AaMemorySpace* ms = NULL;
	int ms_index = this->Get_VC_Memory_Space_Index();
	if(ms_index >= 0)
		ms = AaProgram::Get_Memory_Space(ms_index);
	return(ms);
}

AaPhiStatement* AaExpression::Get_Associated_Phi_Statement()
{
	AaStatement* stmt = this->Get_Associated_Statement();
	if((stmt != NULL) && (stmt->Is("AaPhiStatement")))
		return((AaPhiStatement*) stmt);
	
	AaExpression* e = this->Get_Guarded_Expression();
	if(e != NULL)
		return(e->Get_Associated_Phi_Statement());

	return(NULL);
}	

void AaExpression::Print_Buffering(ostream& ofile)
{
  int bb  = this->Get_Buffering();
  if (bb > 1)
	ofile << " $buffering " << bb << " ";
}

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


bool AaExpression::Is_Part_Of_Fullrate_Pipeline()
{
	AaStatement* dws = this->Get_Pipeline_Parent();
	bool ret_val = ((dws != NULL)  && dws->Get_Pipeline_Full_Rate_Flag());
	return(ret_val);
}


void AaExpression::PrintC_Declaration(ofstream& ofile)
{
  AaModule* m = this->Get_Module();
  bool static_flag = ((m != NULL) && m->Static_Flag_In_C());

  Print_C_Declaration(this->C_Reference_String(), static_flag,  this->Get_Type(), ofile);
  this->Evaluate();
  if(this->Get_Expression_Value())
  {
     Print_C_Assignment_To_Constant(this->C_Reference_String(), this->Get_Type(), this->Get_Expression_Value(), ofile);
  }
}

string AaExpression::Get_VC_Guard_String()
{
	string ret_string = "";
	AaExpression* ge = this->Get_Guard_Expression();
	bool not_flag = this->Get_Guard_Complement();
	if(ge)
	{
		if(not_flag)
			ret_string = "$guard ( ~ " + ge->Get_VC_Driver_Name() + " ) " ;
		else
			ret_string = "$guard ( " + ge->Get_VC_Driver_Name() + " ) " ;
	}
	return(ret_string);
}

//
// is used_expr and *eptr match, then *eptr is replaced by
// a simple object reference to "replacement".
//
void AaExpression::Replace_Field_Expression(AaExpression** eptr, AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	AaExpression* fexpr = *eptr;

	if(fexpr != NULL)
	{

		if((fexpr == used_expr) || (fexpr->Is("AaSimpleObjectReference") &&
						used_expr->Is("AaSimpleObjectReference") &&
							(fexpr->Get_Root_Object() == used_expr->Get_Root_Object())) )
		{
			
			AaExpression* new_expr = NULL;
			bool match_flag = false;
			if(fexpr->Is("AaSimpleObjectReference") && used_expr->Is("AaSimpleObjectReference"))
			// may match through common implicit variable..
			{
				AaSimpleObjectReference* s_fexpr = ((AaSimpleObjectReference*)fexpr);
				AaRoot* s_fexpr_obj = s_fexpr->Get_Object();
				AaSimpleObjectReference* s_used_expr = ((AaSimpleObjectReference*)used_expr);
				AaRoot* s_used_expr_obj = s_used_expr->Get_Object();


				bool f_ok = (s_fexpr->Is_Implicit_Variable_Reference() || s_fexpr_obj->Is_Interface_Object());
				bool used_ok = (s_used_expr->Is_Implicit_Variable_Reference() || s_used_expr_obj->Is_Interface_Object());
				if((f_ok && used_ok) && 
					(s_fexpr->Get_Root_Object() == s_used_expr->Get_Root_Object()) &&
						(s_fexpr->Get_Object_Ref_String() == s_used_expr->Get_Object_Ref_String()))
					match_flag = true;
			}
			else
			{
				match_flag = (fexpr == used_expr);
			}

			if(match_flag)
			{

				new_expr = new AaSimpleObjectReference(this->Get_Scope(),replacement);
				
				replacement->Get_Target()->Add_Target(new_expr);

				*eptr  = new_expr;
				this->AaExpression::Replace_Uses_By(fexpr, new_expr);
			}
		}
	}
}

void AaExpression::Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_expr)
{

  if(!this->Get_Coalesce_Flag())
    {
      this->Set_Coalesce_Flag(true);

      bool continue_propagating = (obj == NULL) || (obj != this->Get_Addressed_Object_Representative());
      this->Set_Addressed_Object_Representative(obj);

      if(AaProgram::_verbose_flag)
	AaRoot::Info("coalescing: propagating " + (obj ? obj->Get_Name() : "null") + " from expression " + this->To_String() +
		 this->Get_Source_Info());

      // propagate to all that are targets of this expression.
      if(continue_propagating)
      {
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



bool AaExpression::Is_Part_Of_Pipelined_Module()
{
	bool ret_val = false;
	AaScope* s = NULL;
	AaStatement* stmt = this->Get_Associated_Statement();

	if(stmt != NULL)
		ret_val = stmt->Is_Part_Of_Pipelined_Module();
	else 
	{
		s = this->Get_Scope();
		if(s && s->Is("AaModule") && ((AaModule*) s)->Is_Pipelined())
			ret_val = true;
	}

	return(ret_val);
}

bool AaExpression::Is_Part_Of_Operator_Module()
{
	AaScope* s = NULL;
	AaStatement* stmt = this->Get_Associated_Statement();
	if(stmt != NULL)
		s = stmt->Get_Scope();
	else 
		s = this->Get_Scope();
	if(s && s->Is("AaModule") && ((AaModule*) s)->Get_Operator_Flag())
		return(true);
	return(false);
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

void AaExpression::Set_Guard_Expression(AaExpression* expr)
{
	if(this != expr)  // expression cannot guard itself!
	{
		_guard_expression = expr;
		expr->Set_Guarded_Expression(this);
	}
}

void AaExpression::Set_Guard_Complement(bool v)
{
	_guard_complement = v;
}

AaExpression* AaExpression::Get_Guard_Expression()
{
	if(_associated_statement != NULL)
	{
		if(_associated_statement->Get_Guard_Expression())
			return(_associated_statement->Get_Guard_Expression());
	}
	return(this->_guard_expression);
}
bool AaExpression::Get_Guard_Complement()
{
	if(_associated_statement != NULL)
	{
		if(_associated_statement->Get_Guard_Expression())
			return(_associated_statement->Get_Guard_Complement());
	}
	return(this->_guard_complement);
}
int AaExpression::Get_Delay()
{
	this->Evaluate();

	// flow-through operators should have 0 delay.
	if(this->Is_Constant() || (this->Get_Is_Intermediate() && this->Is_Trivial()))
		return(0);
	else 
		return(this->AaRoot::Get_Delay());
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

bool AaObjectReference::Can_Be_Combinationalized()
{
	bool ret_val = false;
	if(this->_object != NULL)
	{
		if(!this->_object->Is_Storage_Object() && !this->_object->Is_Pipe_Object())
		{
			ret_val = true;
		}
	}
	return(ret_val);
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

int AaObjectReference::Get_Delay()
{
	int ret_val = this->AaExpression::Get_Delay();
	if(this->_object && this->_object->Is_Storage_Object())
	{
		AaStorageObject* sobj = (AaStorageObject*) this->_object;
		if(!this->Get_Is_Target())
		{
			if(sobj->Get_Number_Of_Reader_Modules() > 1)
				ret_val++;
		}
		else
		{
			if(sobj->Get_Number_Of_Writer_Modules() > 1)
				ret_val++;
		}
	}
	return(ret_val);
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
				AaScope* r_scope = this->Get_Scope()->Get_Root_Scope();
				assert((r_scope != NULL) && r_scope->Is_Module());

				if(child->Is("AaStorageObject"))
				{
					((AaStorageObject*)child)->Set_Is_Read_From(true);

					// keep track of which modules wrote to this object.
					((AaStorageObject*)child)->Add_Reader_Module((AaModule*)r_scope);
				}
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
			{
				pm->Add_Written_Global_Object(sobj);
				pm->Add_Written_Object(sobj);
			}
			else
			{
				pm->Add_Read_Global_Object(sobj);
				pm->Add_Read_Object(sobj);
			}
		}
	}
}

bool AaObjectReference::Writes_To_Memory_Space(AaMemorySpace* ms)
{
	bool ret_val = false;
	if(this->_object->Is_Storage_Object())
	{
		AaStorageObject* sobj = (AaStorageObject*) (this->_object);
		AaMemorySpace* oms = AaProgram::Get_Memory_Space(sobj->Get_Mem_Space_Index());
		ret_val = ((oms == ms) && this->Get_Is_Target());
	}
	return(ret_val);
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
AaConstantLiteralReference::AaConstantLiteralReference(AaScope* parent_tpr, int param_value):
	AaObjectReference(parent_tpr,IntToStr(param_value)) 
{
		string lit_val = IntToStr(param_value);
		this->_literals.push_back(lit_val);
};
AaConstantLiteralReference::~AaConstantLiteralReference() {};


void AaConstantLiteralReference::PrintC(ofstream& ofile)
{
	this->Evaluate();
	Print_C_Assignment_To_Constant(this->C_Reference_String(), this->Get_Type(), this->_expression_value, ofile);
}


void AaConstantLiteralReference::Write_VC_Control_Path( ostream& ofile)
{
	// null region.
}

void AaConstantLiteralReference::Evaluate()
{
	if(!_already_evaluated)
	{
		if(this->_type == NULL)
		{
			AaRoot::Error("could not determine type of constant expression", this);
		}
		else
		{
			_expression_value = Make_Aa_Value(this->Get_Scope(), this->Get_Type(), _literals);
		}
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


//
// TODO: technically, the guard adjacency is from the
// guard-expression to this expression.  Instead, we
// are introducing the guard adjacency from the root 
// object of the guard expression to this expression.
//
// This needs a fresh look.
//
void AaExpression::Update_Guard_Adjacency(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	AaExpression* ge = this->Get_Guard_Expression();
	if((ge != NULL) && (ge->Is("AaSimpleObjectReference")))
	{
		AaSimpleObjectReference* sexpr = (AaSimpleObjectReference*) ge;
		AaRoot* root = sexpr->Get_Root_Object();
		if(visited_elements.find(root) != visited_elements.end())
		{
			AaRoot* root_target = NULL;
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
				root_target = ((AaCallStatement*)root)->Get_Implicit_Target(sexpr->Get_Object_Root_Name());
			}
			else
				root_target = root;

			__InsMap(adjacency_map,root_target,this,ge->Get_Delay());
		}
		else
		{
			__InsMap(adjacency_map,ge,this,ge->Get_Delay());
		}
	}
}

void AaExpression::Get_Non_Trivial_Source_References(set<AaRoot*>& root_set, set<AaRoot*>& visited_elements)
{
	if(this->Get_Is_On_Search_For_Non_Trivial_Refs_Stack())
	{
		AaRoot::Error("Cycle in searching for non-trivial source refs ", this);
		return;
	}

	if(visited_elements.find(this) == visited_elements.end())
		return;

	this->Set_Is_On_Search_For_Non_Trivial_Refs_Stack(true);

	
	if(visited_elements.find(this) != visited_elements.end())
	{
		AaStatement* stmt = this->Get_Associated_Statement();
		if(this->Get_Is_Target())
			// if this is a target... then keep going forward from those who
			// use this as a source...
		{
			assert(stmt != NULL);

			if(this->Is_Implicit_Variable_Reference())
			{
				if(!stmt->Get_Is_Volatile() && (visited_elements.find(stmt) != visited_elements.end()))
				{
					root_set.insert(stmt);
				}
				else 
					// keep hunting.
				{
					for(set<AaRoot*>::iterator iter = this->_source_references.begin(),
							fiter = this->_source_references.end(); iter != fiter; iter++)
					{
						AaRoot* r = *iter;
						if(visited_elements.find(r) != visited_elements.end())
						{
							r->Get_Non_Trivial_Source_References(root_set, visited_elements);
						}
					}
				}
			}
			else 
			{
				root_set.insert(this);
			}
		}
		//
		//  Possible predicates
		//       a. this is in a phi
		//       b. this is an implicit variable reference
		//       c. this is intermediate
		//       d. this is trivial
		//       e. the statement corresponding to this is volatile
		//       f. there is no statement corresponding to this.
		//  Not a target.
		//  1. If stmt is a phi-statement insert the phi and be done with it.
		//
		else if((stmt != NULL) && stmt->Is_Phi_Statement())
		{
			root_set.insert(stmt);
		}
		else if(!this->Is_Flow_Through() && !this->Is_Implicit_Variable_Reference())
		//  2. if this is not flow-through, no issues.
		//       insert this if it is serious.
		{
			root_set.insert(this);
		}
		//
		//  3. if it is intermediate.. hunt its targets down
		//       it is a flow-through intermediate.
		//      
		else if(this->Get_Is_Intermediate())
		{
			for(set<AaExpression*>::iterator iter = _targets.begin(), fiter = _targets.end(); iter != fiter; iter++)
			{
				AaExpression* expr = *iter;
				expr->Get_Non_Trivial_Source_References(root_set, visited_elements);
			}
		}
		//
		//  4.  Not intermediate...  See what its stmt does.
		else if(stmt != NULL)
		{
			if(visited_elements.find(stmt) != visited_elements.end())
			{
				if(!stmt->Get_Is_Volatile())
					root_set.insert(stmt);
				else
					stmt->Get_Non_Trivial_Source_References(root_set, visited_elements);
			}
		}
		//
		//   5. stmt is null..  not possible to get here.
		//
		else 
		{
			AaRoot::Error("expression has no associated statement", this);
			root_set.insert(this);
		}

	}
	this->Set_Is_On_Search_For_Non_Trivial_Refs_Stack(false);
}

//---------------------------------------------------------------------
//AaSimpleObjectReference
//---------------------------------------------------------------------
AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, string object_id):AaObjectReference(parent_tpr, object_id) 
{
	_guarded_statement = NULL;
	_guarded_expression = NULL;
	_in_collect_roots_stack = false;
};
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
			if(this->Get_Is_Target())
				((AaStorageObject*)obj)->Add_Writer_Expression(this);
			else
				((AaStorageObject*)obj)->Add_Reader_Expression(this);
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
	{
		//
		// TODO: delays are more subtle than they appear to be.
		//       They should be set using the logic of the data-path
		//       operators which implement these expressions!
		//
		this->Set_Delay(0);
	}
	else if(obj->Is_Pipe_Object())
	{
		this->Set_Delay(PIPE_ACCESS_DELAY);
	}
	else if(obj->Is_Storage_Object())
	{
		this->Set_Delay(MEMORY_ACCESS_DELAY);
	}

}
	
int AaSimpleObjectReference::Get_Existing_Buffering()
{
	int ret_val = 0;
	AaRoot* root  = this->Get_Root_Object();
	if(root != NULL)
	{
		AaStatement* stmt = NULL;

		if(root->Is_Statement())
		{
			stmt = (AaStatement*) root;
		}
		else if (root->Is_Expression())
		{
			stmt = ((AaExpression*)root)->Get_Associated_Statement();
		}

		if((stmt != NULL) && !stmt->Get_Is_Volatile())
		{
			ret_val = stmt->Get_Buffering();
		}
	}
	return(ret_val);
}

bool AaSimpleObjectReference::Is_Trivial()
{
	return(!this->Get_Is_Target() 
			&& (this->Is_Implicit_Variable_Reference() || this->Is_Signal_Read()));
}

bool AaSimpleObjectReference::Can_Be_Combinationalized()
{
	bool ret_val = (this->Is_Implicit_Variable_Reference() || this->Is_Signal_Read());
	return(ret_val);
}


bool AaSimpleObjectReference::Is_Write_To_Pipe(AaPipeObject* obj)
{
	return(this->Get_Is_Target()  &&
			(this->_object == (AaObject*)obj));
}


AaSimpleObjectReference::AaSimpleObjectReference(AaScope* parent_tpr, AaAssignmentStatement* root_obj):AaObjectReference(parent_tpr, root_obj) 
{
	this->Set_Object(root_obj->Get_Target());
	this->Set_Type(root_obj->Get_Target()->Get_Type());
}

// does the expression have a trivial update stage?
bool AaSimpleObjectReference::Has_No_Registered_Update()
{
	return(this->Is_Signal_Read() || this->Is_Implicit_Variable_Reference() 
			|| this->Is_Interface_Object_Reference()
			|| (this->Is_Trivial() && this->Get_Is_Intermediate())
			|| (this->Get_Is_Target() && this->_object->Is_Pipe_Object()));
}

// is it reading a signal?
bool AaSimpleObjectReference::Is_Signal_Read()
{
	if(this->Get_Object() != NULL)
	{	
		if(this->Get_Object()->Is_Pipe_Object())
		{
			if(((AaPipeObject*)(this->Get_Object()))->Get_Signal())
			{
				if(!this->Get_Is_Target())
					return(true);
			}
		}
	}
	return(false);
}

//
// if driven by a signal through a chain of volatiles,
// the root sources set will be empty.
//
bool AaSimpleObjectReference::Is_Indirect_Signal_Read()
{
	bool ret_val = this->Is_Signal_Read();
	if(!ret_val)
	{
		set<AaRoot*> root_sources;
		this->Collect_Root_Sources(root_sources);

		if(root_sources.size() == 0)
		{
			ret_val = true;	
		}
	}
	return(ret_val);
}

bool AaSimpleObjectReference::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
	this->_addressed_objects.insert(obj);

	// TBD: overly conservative.
	//  if(this->_is_dereferenced)
	//{

	if(this->Get_Addressed_Object_Representative() && (obj != this->Get_Addressed_Object_Representative()))
	{
		AaProgram::Add_Storage_Dependency(obj,this->Get_Addressed_Object_Representative());
	}

	//    }

	this->AaExpression::Set_Addressed_Object_Representative(obj);

}

void AaSimpleObjectReference::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	if(this->Get_Is_On_Collect_Root_Sources_Stack())
	{
		AaRoot::Error("Cycle in collect-root-sources", this);
		return;
	}

	if(this->Is_Constant())
		return;

	this->Set_Is_On_Collect_Root_Sources_Stack(true);
	// if it is an implicit reference
	if(this->Get_Is_Target())
	{
		if(this->Is_Implicit_Variable_Reference())
		{
			AaRoot* root_obj = this->Get_Root_Object();
			if(root_obj->Is_Statement())
			{
				AaStatement* r = (AaStatement*) root_obj;
				if(r->Get_Is_Volatile())
				{
					r->Collect_Root_Sources(root_set);
				}
				else
				{
					root_set.insert(r);
				}
			}	
			else   if(root_obj->Is_Interface_Object())
			{
				AaStatement* stmt = 
					((AaInterfaceObject*) root_obj)->Get_Unique_Driver_Statement();
				if(stmt != NULL) 
				{
					if (stmt->Get_Is_Volatile())
						stmt->Collect_Root_Sources(root_set);
					else
						root_set.insert(this);
				}
			}
			else 
			{
				// what could this be?  
				// It could be a signal read.
				root_set.insert(this);
			}
		}
		else
			root_set.insert(this);
	}
	else if(this->Is_Implicit_Variable_Reference())
	{
		AaRoot* root_obj = this->Get_Root_Object();
		if(root_obj->Is_Statement())
		{
			AaStatement* r = (AaStatement*) root_obj;
			if(r->Get_Is_Volatile())
			{
				r->Collect_Root_Sources(root_set);
			}
			else
			{
				root_set.insert(r);
			}
		}	
		else if(root_obj->Is_Interface_Object())
		{
			// an output interface object may be written by
			// a statement. Add this statement to the roots.
			AaInterfaceObject* io = ((AaInterfaceObject*) root_obj);
			AaStatement* sio = io->Get_Unique_Driver_Statement();
			if(sio != NULL)
			{
				if(sio->Is_Phi_Statement())
					root_set.insert(sio);
				else
					sio->Collect_Root_Sources(root_set);
			}
			else 
			//
			// this must be an input interface object..
			// put it into the root-set!
			//
			{	
				//
				// interface object can link to 
				// update enables in operators.
				//
				root_set.insert(io);
			}
		}
		else
			root_set.insert(this);
	}
	else if(!this->Is_Signal_Read())
	{
		// signal reads are ignored.
		root_set.insert(this);
	}


	this->Set_Is_On_Collect_Root_Sources_Stack(false);
}

void AaSimpleObjectReference::Set_Type(AaType* t)
{
	if(this->_object && this->_object->Is_Storage_Object() && !this->Used_Only_In_Address_Of_Expression())
		((AaStorageObject*)this->_object)->Add_Access_Width(t->Size());

	this->AaExpression::Set_Type(t);
}

string AaSimpleObjectReference::Get_Name()
{
	if(this->_object == NULL)
	{
		AaRoot::Error("simple object reference to unresolved object " + this->Get_Object_Ref_String(), this);
		return("");
	}

	if(this->_object->Is("AaInterfaceObject"))
		return this->_object->Get_Name();
	else
		return this->Get_Object_Ref_String();
}

void AaSimpleObjectReference::Print(ostream& ofile)
{
	if(this->_object == NULL)
	{
		AaRoot::Error("simple object reference to unresolved object " + this->Get_Object_Ref_String(), this);
		return;
	}

	if(this->_object->Is("AaInterfaceObject"))
	{
		ofile << this->_object->Get_Name();
	}
	else
	{
		string ret_val  = this->Get_Object_Ref_String();

		// Get scope
		AaScope* sm =  NULL;
		if(this->_object->Is_Object())
			sm = ((AaObject*) this->_object)->Get_Scope();
		else if(this->_object->Is_Expression())
			sm = ((AaExpression*) this->_object)->Get_Scope();
		else if(this->_object->Is_Statement())
			sm = ((AaStatement*) this->_object)->Get_Scope();

		if((sm != NULL) && sm->Is_Module())
		{
			AaModule* m = (AaModule*) sm;
			if((m->Get_Macro_Flag() || m->Get_Inline_Flag()) && AaProgram::_print_inlined_functions_in_caller)
			{
				ret_val = m->Get_Print_Prefix() + this->Get_Object_Ref_String();
			}
		}
		
		ofile << ret_val;
	}

	this->Print_Buffering(ofile);
}


//
//
//
string AaSimpleObjectReference::C_Reference_String()
{
	if(this->Is_Implicit_Variable_Reference())
	{

		AaRoot* obj = this->Get_Object();
		AaRoot* root_obj = this->Get_Root_Object();
		if(obj == NULL)
		{
			AaRoot::Error("simple object reference to unresolved object " + this->Get_Object_Ref_String(), this);
			return("");
		}

		// 
		// if this refers to an export of 
		// something else, then the exported
		// version is given an extension
		//
		if(root_obj->Is_Statement() && obj->Is("AaSimpleObjectReference"))
		{
			string this_obj_str = this->Get_Object_Ref_String();
			string obj_str  = ((AaSimpleObjectReference*) obj)->Get_Object_Ref_String();

			AaScope* this_scope = this->Get_Scope();
			AaScope* root_scope = ((AaSimpleObjectReference*)obj)->Get_Scope();

			// if this-scope is the parent of root scope then this
			// is an export.
			if((root_scope != NULL) && (root_scope->Get_Scope() == this_scope))
				return(this_obj_str + "__" + obj_str);
			else
				return(obj_str);
		}
		else
			return(this->Get_Object_Ref_String());
	}
	else if(this->Get_Object() && this->Get_Object()->Is_Storage_Object() || this->Get_Object()->Is_Constant())
	{
		return(this->Get_Object_Ref_String());
	}
	else
	{
		return(this->Get_VC_Name());
	}
}

void AaSimpleObjectReference::PrintC_Declaration(ofstream& ofile)
{	
	// if you can trace yourself to an implicit reference, print
	// only if root is not already printed.
	if(this->Get_Is_Target() && this->Is_Implicit_Variable_Reference())
	{
		if(!this->Get_Object()->Is_Object())
		{
			this->AaExpression::PrintC_Declaration(ofile);
		}
	}
	else if(this->Get_Object()->Is_Pipe_Object())
	{
		AaModule* m = this->Get_Module();
		bool static_flag = ((m != NULL) && m->Static_Flag_In_C());
		Print_C_Declaration(this->C_Reference_String(),static_flag, this->Get_Type(),ofile);
	}
	//else
	//{
	//ofile << "// skipped declaration of " << this->C_Reference_String() << endl;
	//}
}

//
// print something only if there is something interesting to print.
//
void AaSimpleObjectReference::PrintC(ofstream& ofile)
{
	// constants are declared and initialized.
	if(this->Is_Constant()) 
		return;

	if(this->Get_Object()->Is_Pipe_Object())
	{
		if(this->Get_Is_Target())
		{
			Print_C_Pipe_Write(this->C_Reference_String(),  
					this->Get_Type(), 
					(AaPipeObject*) this->Get_Object(), 
					ofile);
		}
		else
		{
			// access the pipe..
			Print_C_Pipe_Read(this->C_Reference_String(),  
					this->Get_Type(), 
					(AaPipeObject*) this->Get_Object(), 
					ofile);
		}
	}	
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

		this->Check_Volatile_Inconsistency();
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

			// for pipe accesses, chained protocol.
			ofile << "// " << this->To_String() << endl;
			ofile << ";;[" << this->Get_VC_Name() << "] { // pipe read" << endl;
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
	if(this->Is_Constant() || this->Is_Signal_Read())
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
		AaPhiStatement* pstmt = this->Get_Associated_Phi_Statement();
		if(pstmt != NULL)
			return(__UST(pstmt));

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
			{

				bool pm = this->Is_Part_Of_Pipelined_Module();
				if(pm)
				{
					return(this->_object->Get_VC_Name() + "_update_enable");
				}
				else
				{
					return("$null");
				}
			}
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
				return("$null");
			}
		}

		// you should never get here.
		assert(0 && "unknown variety of simple-object-reference");
	}
}

// return the name of the transition which triggers the update of
// this expression's value.
string AaSimpleObjectReference::Get_VC_Unmarked_Reenable_Update_Transition_Name_Generic(set<AaRoot*>& visited_elements)
{
	string ret_val = "$null";
	if(!this->Is_Constant() && !this->Is_Signal_Read() && (this->_object != NULL))
	{
		if(this->_object->Is_Interface_Object())
		{
			AaInterfaceObject* obj = ((AaInterfaceObject*)(this->_object));
		
			if(obj->Get_Mode() == "in")
			{
				bool pm = this->Is_Part_Of_Pipelined_Module();
				if(pm)
				{
					ret_val = this->Get_VC_Unmarked_Reenable_Update_Transition_Name(visited_elements);
				}
			}
		}
	}
	return(ret_val);
}

//
//  Very specific function to be called only
//  when parent module is pipelined and an operator,
//  and _object is an input interface object!
//
//  asserts all over the place as a fence.
//
string AaSimpleObjectReference::Get_VC_Unmarked_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
	if(this->_object->Is_Interface_Object())
	{
		AaInterfaceObject* obj = ((AaInterfaceObject*)(this->_object));
		if(obj->Get_Mode() == "in")
		{
			bool pm = this->Is_Part_Of_Pipelined_Module() && this->Is_Part_Of_Operator_Module();
			if(pm)
			{
				return(this->_object->Get_VC_Name() + "_update_enable_unmarked");
			}
			else
				assert(0);
		}
		else 
			assert(0);
	}
	else
		assert(0);
}

// return the name of the transition which triggers the sampling of
// this expression's inputs.
string AaSimpleObjectReference::Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
{
	bool phi_stmt_case = false;
	if(this->Is_Constant() || this->Is_Signal_Read())
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
		AaPhiStatement* pstmt = this->Get_Associated_Phi_Statement();
		if(pstmt != NULL)
			return(__SST(pstmt));


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
					return(__SST(this));
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

// Return true if this expression has a non-trivial
// update req->ack, with a unit delay inserted.
bool AaSimpleObjectReference::Update_Protocol_Has_Delay(set<AaRoot*>& visited_elements)
{
	if(this->Is_Constant())
	{
		return(false);
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
			return(true);

		if(this->_object->Is("AaPipeObject"))
		{
			if(!this->Get_Is_Target() && !this->Is_Signal_Read())
				return(true);
			else
				return(false);
		}

		if(this->_object->Is_Interface_Object())
		{
			AaInterfaceObject* io = (AaInterfaceObject*) (this->_object);
			if(io->Get_Is_Input())
				// this needs to be false? else a 
				// combinational cycle is produced.
				// TODO: why?
				return(true);
			else
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				if((root != NULL) && (visited_elements.find(root) != visited_elements.end()))
					return(true);
				else
					return(false);
			}
		}

		if(this->Is_Implicit_Variable_Reference())
		{
			AaRoot* root = this->Get_Root_Object();
			if(visited_elements.find(root) != visited_elements.end())
			{
				return(true);
			}
			else
			{
				return(false);
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
	else if(this->_object->Is_Interface_Object() && 
			(this->Get_Associated_Phi_Statement() == NULL))
		return ("$entry");
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
		// for pipe accesses, chained protocol.
		ofile << "// " << this->To_String() << endl;
		ofile << ";;[" << this->Get_VC_Name() << "_Sample] { // sample-data. " << endl;
		ofile << "$T [req] $T [ack] " << endl;
		ofile << "}" << endl;
		ofile << ";;[" << this->Get_VC_Name() << "_Update] { // data to pipe. " << endl;
		ofile << "$T [req] $T [ack] " << endl;
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

bool AaSimpleObjectReference::Is_Interface_Object_Reference()
{
	AaRoot* ro  = this->Get_Root_Object();
	if(ro != NULL) 
	{
		if(ro->Is("AaInterfaceObject"))
			return(true);
	}
	return(false);
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
		else if(this->_object->Is_Statement())
		{
			if(this->_object->Is("AaAssignmentStatement"))
			{
				AaAssignmentStatement* ss = (AaAssignmentStatement*) (this->_object);
				this->Assign_Expression_Value(ss->Get_Target()->Get_Expression_Value());
			}
		}
	}
}

void AaSimpleObjectReference::Assign_Expression_Value(AaValue* expr_value)
{
	if(this->_object && !this->_object->Is_Storage_Object())
	{
		this->AaExpression::Assign_Expression_Value(expr_value);
		if(this->Is_Interface_Object_Reference() && (expr_value != NULL))
		{
			AaRoot* ro = this->Get_Root_Object();
			assert(ro->Kind() == "AaInterfaceObject");
			AaInterfaceObject* ifo = (AaInterfaceObject*) ro;
			AaValue* nv = Make_Aa_Value(this->Get_Scope(),this->Get_Type());
			nv->Assign(this->Get_Type(),expr_value);

			// cannot overwrite!
			assert(ifo->Get_Expr_Value() == NULL);
			ifo->Set_Expr_Value(nv);
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
	else if(this->Is_Signal_Read())
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


void AaSimpleObjectReference::Write_VC_Output_Buffering(string dpe_name, string tgt_name, ostream& ofile)
{
	if(this->_object->Is_Pipe_Object() && !this->Get_Is_Target())
	{
		int buffering = this->Get_Buffering();
		if(buffering > 0)
		{
			ofile << " $buffering $out " 
				<< this->Get_VC_Datapath_Instance_Name() << " "
				<< tgt_name
				<< " " << buffering  << endl;
		}
	}
	else
	{
		this->AaExpression::Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);
	}
}

void AaSimpleObjectReference::Write_VC_Input_Buffering(string dpe_name, string src_name, ostream& ofile)
{
	/*
	   if(this->_object->Is_Pipe_Object() && this->Get_Is_Target())
	   {
	   AaPipeObject* pobj = (AaPipeObject*) (this->_object);

	   if(this->Get_Pipeline_Parent() != NULL)
	   {
	   int buffering = 0;
	   if(!pobj->Get_P2P())
	   buffering = 2;

	   ofile << " $buffering $in " 
	   << this->Get_VC_Datapath_Instance_Name() << " "
	   << src_name
	   << " " << buffering  << endl;
	   }
	   }
	   else
	   {
	 */

	// Why waste a cycle?
	this->AaExpression::Write_VC_Input_Buffering(dpe_name, src_name, ofile);
	/*
	   }
	 */
}


void AaSimpleObjectReference::Write_VC_Datapath_Instances_As_Target( ostream& ofile, AaExpression* source) 
{
	if(!this->Is_Constant()  && !this->Is_Implicit_Variable_Reference())
	{
		bool pipeline_flag = (this->Get_Pipeline_Parent() != NULL);
		bool full_rate = (pipeline_flag && this->Get_Pipeline_Parent()->Get_Pipeline_Full_Rate_Flag());

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
					full_rate,
					ofile);

			//
			// pipeline case.
			// double buffering at the input side.
			// in the non P2P case.
			//
			this->Write_VC_Input_Buffering(this->Get_VC_Datapath_Instance_Name(),
					src_name, ofile);
		}
	}
}


string AaSimpleObjectReference::Get_VC_Name()
{
	string ret_val;
	string idx = Int64ToStr(this->Get_Index());

	if(this->_object->Is("AaStorageObject"))
	{
		if(this->Get_Is_Target())
			ret_val = "STORE";
		else
			ret_val = "LOAD";
		ret_val += "_" + this->_object->Get_VC_Name();
	}
	else if(this->_object->Is("AaPipeObject"))
	{
		if(this->Get_Is_Target())
			ret_val = "WPIPE";
		else
			ret_val = "RPIPE";
		ret_val += "_" + this->_object->Get_VC_Name();
	}
	else
	{
		if(this->Get_Is_Target())
			ret_val = "W_" + this->Get_Name();
		else
			ret_val = "R_" + this->Get_Name();
	}


	ret_val += "_" + idx;

	return(ret_val);
}

void AaSimpleObjectReference::Write_VC_Datapath_Instances(AaExpression* target,  ostream& ofile) 
{

	if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
	{
		bool pipelining_flag = (this->Get_Pipeline_Parent() != NULL);
		bool full_rate = (pipelining_flag && (this->Get_Pipeline_Parent()->Is_Part_Of_Fullrate_Pipeline()));

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

			bool barrier_flag = 
				(this->Get_Associated_Statement() != NULL) && 
				this->Get_Associated_Statement()->Is_Phi_Statement() &&
					((AaPhiStatement*)this->Get_Associated_Statement())->Get_Barrier_Flag();


			//
			// io read.
			//
			Write_VC_IO_Input_Port((AaPipeObject*) this->_object,
					dpe_name,
					tgt_name,
					this->Get_VC_Guard_String(),
					full_rate, 
					barrier_flag,
					ofile);

			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);
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
			if(!this->Is_Signal_Read())
			{
				AaPipeObject* pobj = (AaPipeObject*) this->_object;
				string inst_name = this->Get_VC_Datapath_Instance_Name();
				reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Sample/req");
				reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Update/req");
				acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Sample/ack");
				acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Update/ack");
				Write_VC_Link(inst_name, reqs,acks,ofile);
			}
		}
	}
}
void AaSimpleObjectReference::Write_VC_Links_As_Target(string hier_id, ostream& ofile) 
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
			reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "_Sample/req");
			acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_Sample/ack");
			reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "_Update/req");
			acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_Update/ack");

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

				AaRoot* root_target = NULL;
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
					root_target = root;

				__InsMap(adjacency_map,root_target,this,0);
				visited_elements.insert(this);
			}		
			else
			{
				bool is_war = ((root != NULL) && root->Is_Statement() &&
						(((AaStatement*)root)->Get_Scope() == this->Get_Scope()));

				if(!is_war)
				{
					root = NULL;
					__InsMap(adjacency_map,root,this,0);
					visited_elements.insert(this);
				}

			}
		}
		else
		{
			AaRoot* tmp = NULL;
			__InsMap(adjacency_map,tmp,this,0);
			visited_elements.insert(this);
		}
		//this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	}
	else 
	{
		if(this->_object->Is_Interface_Object())
		{
			__InsMap(adjacency_map,this, AaProgram::_dummy_root, 0);
		}
		visited_elements.insert(this);
	}
}

void AaSimpleObjectReference::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	if(this->_object == used_expr->Get_Root_Object())
	{
		AaRoot* obj   = this->_object;
		this->_object = replacement->Get_Target();

		// need to link replacement to this else we
		// have an orphan.
		replacement->Get_Target()->Add_Target(this);
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
	/*
	if(referrer->Is("AaInterfaceObject"))
	{
		AaType* rtype = ((AaInterfaceObject*)referrer)->Get_Type();
		this->Set_Type(rtype);
	}
	*/
}
void AaArrayObjectReference::Add_Source_Reference(AaRoot* referrer)
{
	this->AaRoot::Add_Source_Reference(referrer);
	if(referrer->Is("AaInterfaceObject"))
	{
		AaType* rtype = ((AaInterfaceObject*)referrer)->Get_Type();
		this->Set_Type(rtype);
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

			_pointer_ref->Set_Associated_Statement(this->Get_Associated_Statement());
		}

		if(obj->Is_Pipe_Object())
			this->Set_Does_Pipe_Access(true);

		if(obj->Is_Storage_Object())
		{
			this->Update_Globally_Accessed_Objects((AaStorageObject*) obj);
			if(this->Get_Is_Target())
				((AaStorageObject*)obj)->Add_Writer_Expression(this);
			else
				((AaStorageObject*)obj)->Add_Reader_Expression(this);
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

	this->Set_Delay(MEMORY_ACCESS_DELAY);

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

string AaArrayObjectReference::C_Reference_String()
{

	string ret_string;

	if(this->_object->Get_Type()->Is_Pointer_Type())
	{
		AaType* t  = this->_object->Get_Type();
		ret_string += "&((*(";
		ret_string += this->Get_Object()->C_Reference_String();
		ret_string += " + bit_vector_to_uint64(0,&" ;
		ret_string += _indices[0]->C_Reference_String();
		ret_string += ")))";
		AaType* rt = ((AaPointerType*)t)->Get_Ref_Type();
		ret_string += this->C_Index_String(rt,1,&_indices);
		ret_string += ")";
	}
	else
	{
		ret_string += "(";
		ret_string += this->Get_Object()->C_Reference_String();
		ret_string += this->C_Index_String(this->_object->Get_Type(),0,&_indices);
		ret_string += ")";
	}
	return(ret_string);
}

void AaArrayObjectReference::PrintC_Declaration(ofstream& ofile)
{
	assert(this->_object && this->_object->Get_Type());

	if(this->_object->Is_Expression())
	{
		((AaExpression*) (this->_object))->PrintC_Declaration(ofile);
	}
	for(int i = 0, imax = _indices.size(); i < imax; i++)
	{
		_indices[i]->PrintC_Declaration(ofile);
	}
}

void AaArrayObjectReference::PrintC(ofstream& ofile)
{
	assert(this->_object && this->_object->Get_Type());

	if(this->_object->Is_Expression())
	{
		((AaExpression*) (this->_object))->PrintC(ofile);
	}
	for(int i = 0, imax = _indices.size(); i < imax; i++)
	{
		_indices[i]->PrintC(ofile);
	}
}


string AaArrayObjectReference::C_Index_String(AaType* t, int start_id, vector<AaExpression*>* indices)
{
	string ret_string;
	AaType* curr_type = t;

	while(start_id < indices->size())
	{
		assert(curr_type != NULL);

		if(curr_type->Is("AaArrayType"))
		{
			AaExpression* iexp = (*indices)[start_id];
			ret_string += "[";
			ret_string += C_Value_Expression(iexp->C_Reference_String(), iexp->Get_Type());
			ret_string += "]";
			curr_type = ((AaArrayType*)curr_type)->Get_Element_Type(0);
		}
		else if(curr_type->Is("AaRecordType"))
		{
			assert((*indices)[start_id]->Is_Constant());
			int idx = ((*indices)[start_id]->Get_Expression_Value()->To_Integer());
			ret_string +=  ".f_" + IntToStr(idx);
			curr_type = ((AaRecordType*)curr_type)->Get_Element_Type(idx);
		}
		else
		{
			assert(0);
		}
		start_id++;
	}

	return(ret_string);
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

		this->Check_Volatile_Inconsistency();
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
				ofile << "|| [PipeRead] {" <<  endl;
				ofile << " ;; [Sample] { " << endl;
				ofile << "$T [req] $T [ack] " << endl;
				ofile << "}" << endl;
				ofile << " ;; [Update] { " << endl;
				ofile << "$T [req] $T [ack] " << endl;
				ofile << "}" << endl;
				ofile << "}" << endl;
			}
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

void AaArrayObjectReference::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	
	if(this->Is_Constant())
		return;
	
	if(this->Get_Is_On_Collect_Root_Sources_Stack())
		AaRoot::Error("Cycle in collect-root-sources", this);
	this->Set_Is_On_Collect_Root_Sources_Stack(true);

	if(this->Get_Object_Type()->Is_Pointer_Type())
		root_set.insert(this);
	else if(this->_object->Is_Storage_Object())
		root_set.insert(this);
	else 
	// object is an expression/pipe/stmt/interface reference..
	{
		if(this->_object->Is_Expression())
		// expression?
		{
			((AaExpression*) (this->_object))->Collect_Root_Sources(root_set);
		}
		else if(this->_object->Is("AaPipeObject"))
		// Pipe?
		{
			// no flow through.
			root_set.insert(this);
		}
		else if(this->_object->Is_Interface_Object())
		// interface object.
		{
			// an output interface object may be written by
			// a statement. Add this statement to the roots.
			AaInterfaceObject* io = ((AaInterfaceObject*) this->_object);
			AaStatement* sio = io->Get_Unique_Driver_Statement();

			if(sio != NULL)
				sio->Collect_Root_Sources(root_set);
			else 
				//
				// this must be an input interface object..
				// put it into the root-set!
				//
			{	
				//
				// interface object can link to 
				// update enables in operators.
				//
					root_set.insert(io);
			}

		} 
		else
		// statement.
		{
			AaRoot* root_obj = this->Get_Root_Object();
			if(root_obj->Is_Statement())
			{
				AaStatement* r = (AaStatement*) root_obj;
				if(r->Get_Is_Volatile())
				{
					r->Collect_Root_Sources(root_set);
				}
				else
				{
					root_set.insert(r);
				}
			}	
			else
			{
				// should never get here.
				assert(0);
			}
		}
	}
	this->Set_Is_On_Collect_Root_Sources_Stack(false);
}

void AaArrayObjectReference::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{

	if(this->Is_Constant())
		return;

	bool full_rate = ((this->Get_Associated_Statement() != NULL)
			&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());


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
				false, // flow-through
				full_rate, 
				false, // cut-through
				ofile);

		//
		//  pipelining... address calculation path is double buffered.
		//
		if(this->Get_Pipeline_Parent() != NULL)
		{
			ofile << "$buffering  $out " << dpe_name << " " << tgt_name << " 2" << endl;
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
			ofile << "// array reference to interface object... " << endl;
			source_wire = ((AaInterfaceObject*) this->_object)->Get_Name();
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			AaRoot::Error("indexed array expression not supported on pipe object." ,this->_object);
			// not supported.
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

			bool flow_through = true;
			Write_VC_Slice_Operator(dpe_name,
					src_name,
					tgt_name,
					high_index,
					low_index,
					this->Get_VC_Guard_String(),
					flow_through, // flow-through is set to true.
					full_rate,
					ofile);
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
			// not supported.
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			// not supported.
		}

		reqs.clear();
		acks.clear();
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
		__InsMap(adjacency_map,_indices[idx],this,_indices[idx]->Get_Delay());
	}

	if(_pointer_ref)
	{
		_pointer_ref->Update_Adjacency_Map(adjacency_map,visited_elements);
		__InsMap(adjacency_map,_pointer_ref,this,_pointer_ref->Get_Delay());
	}
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
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


	// 1. multiple readers/writers,
	//    we need to add an extra delay 
	// 2. multiple modules accessing the
	//    memory, we need to add an extra
	//    delay.
	int additional_delay = 2;
	this->Set_Delay(MEMORY_ACCESS_DELAY + additional_delay);

}



void AaPointerDereferenceExpression::Print(ostream& ofile)
{
	ofile << "->(";
	this->_reference_to_object->Print(ofile);
	ofile << ")";
}

void AaPointerDereferenceExpression::PrintC_Declaration(ofstream& ofile)
{
	this->_reference_to_object->PrintC_Declaration(ofile);
	this->AaExpression::PrintC_Declaration(ofile);
}

void AaPointerDereferenceExpression::PrintC(ofstream& ofile)
{
	this->_reference_to_object->PrintC(ofile);
	Print_C_Assignment(this->C_Reference_String(), "*" + this->_reference_to_object->C_Reference_String(),
			this->Get_Type(), ofile); 
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
			AaScope* r_scope = this->Get_Scope()->Get_Root_Scope();

			if(this->Get_Is_Target())
			{
				obj->Set_Is_Written_Into(true);
				if(r_scope->Is_Module())
					obj->Add_Writer_Module((AaModule*) r_scope);
				
			}
			else
			{
				obj->Set_Is_Read_From(true);
				if(r_scope->Is_Module())
					obj->Add_Reader_Module((AaModule*) r_scope);
			}

			if(this->Get_Is_Target())
				((AaStorageObject*)obj)->Add_Writer_Expression(this);
			else
				((AaStorageObject*)obj)->Add_Reader_Expression(this);

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
			if(obj != this->Get_Addressed_Object_Representative())
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
	__InsMap(adjacency_map,_reference_to_object,this,_reference_to_object->Get_Delay());
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
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

	this->Check_Volatile_Inconsistency();
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
	this->Set_Delay(ADDRESS_CALCULATION_DELAY);
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

void AaAddressOfExpression::PrintC_Declaration(ofstream& ofile)
{
	this->_reference_to_object->PrintC_Declaration(ofile);
	this->AaExpression::PrintC_Declaration(ofile);
}

void AaAddressOfExpression::PrintC(ofstream& ofile)
{
	this->_reference_to_object->PrintC(ofile);
	ofile << this->C_Reference_String() << " = ";
	ofile << "&(" << this->_reference_to_object->C_Reference_String() << ");";
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

		this->Check_Volatile_Inconsistency();
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

		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());
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
				false,
				full_rate,
				false, // cut-through
				ofile);

		this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);

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
	__InsMap(adjacency_map,_reference_to_object,this,_reference_to_object->Get_Delay());
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
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

	if((ref_type != NULL) && ref_type->Is("AaFloatType"))
		this->Set_Delay(TO_FLOAT_CONVERSION_DELAY);
	else
		this->Set_Delay(TO_INTEGER_CONVERSION_DELAY);
}

AaTypeCastExpression::~AaTypeCastExpression() {};
void AaTypeCastExpression::Print(ostream& ofile)
{
	string cast_name = (_bit_cast ? "$bitcast" : "$cast");
	ofile << "(" << cast_name << " (" ;
	this->Get_To_Type()->Print(ofile);
	ofile << ") ";
	this->Get_Rest()->Print(ofile);
	this->Print_Buffering(ofile);
	ofile << " )";
}

void AaTypeCastExpression::PrintC_Declaration(ofstream& ofile)
{
	this->_rest->PrintC_Declaration(ofile);
	this->AaExpression::PrintC_Declaration(ofile);
}

void AaTypeCastExpression::PrintC(ofstream& ofile)
{
	this->_rest->PrintC(ofile);
	Print_C_Type_Cast_Operation(this->_bit_cast,
			this->_rest->C_Reference_String(),
			this->_rest->Get_Type(), 
			this->C_Reference_String(),
			this->Get_Type(),
			ofile);
}


void AaTypeCastExpression::Write_VC_Control_Path(ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->Check_Volatile_Inconsistency();
		ofile << "// " << this->To_String() << endl;

		ofile << ";;[" << this->Get_VC_Name() << "] { // type-cast expression" << endl;
		this->_rest->Write_VC_Control_Path(ofile);

		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());

		// either it will be a register or a split conversion
		// operator..
		if(not flow_through)
		{
			ofile << "||[SplitProtocol] {" << endl;
		}
		else
		{
			ofile << "// flow-through" << endl;
			ofile << ";;[SplitProtocol] {" << endl;
		}
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

bool AaTypeCastExpression::Is_Trivial()
{
	if(this->_rest->Is_Trivial() && 
		(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type())))
		return(true);
	else 
		return(false);
}



void AaTypeCastExpression::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	if(!this->Is_Constant())
	{
		if(this->Get_Is_On_Collect_Root_Sources_Stack())
			AaRoot::Error("Cycle in collect-root-sources", this);
		this->Set_Is_On_Collect_Root_Sources_Stack(true);
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			_rest->Collect_Root_Sources(root_set);
		else
			root_set.insert(this);
		this->Set_Is_On_Collect_Root_Sources_Stack(false);
	}
}

void AaTypeCastExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
	if(!this->Is_Constant())
	{
		bool ilb_flag = false;
		if(this->Is_Trivial())
		{
			//
			// its just an interlock buffer if the target type is unsigned.
			// else its a sign extension.
			//
			if(this->Get_Type()->Is_Uinteger_Type() ||
				(this->Get_Type()->Size() == this->_rest->Get_Type()->Size()))
			{
				ilb_flag = true;
			}
		}


		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());

		this->_rest->Write_VC_Datapath_Instances(NULL,ofile);

		ofile << "// " << this->To_String() << endl;
		string dpe_name = this->Get_VC_Datapath_Instance_Name();
		string src_name = this->_rest->Get_VC_Driver_Name(); 
		string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

		if(ilb_flag & (not flow_through))
		{
			Write_VC_Interlock_Buffer(dpe_name,
					src_name,
					tgt_name,
					this->Get_VC_Guard_String(),
					false,
					full_rate, 
					false, // cut-through
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
					flow_through, 
					this->_bit_cast,
					full_rate, 
					ofile);
		}

		if(!flow_through)
			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);

		int delay = (flow_through ? 0 : this->Get_Delay());
		ofile << "$delay " << dpe_name << " " << delay << endl;
	}
}

void AaTypeCastExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Links(hier_id + "/" + this->Get_VC_Name(), ofile);

		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

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
	__InsMap(adjacency_map,_rest,this,_rest->Get_Delay());
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
}

void AaTypeCastExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_rest, used_expr, replacement);
}

//---------------------------------------------------------------------
// AaSliceExpression
//---------------------------------------------------------------------
AaSliceExpression::AaSliceExpression(AaScope* scope, AaType* to_type, int low_index, AaExpression *rest):
	AaTypeCastExpression(scope,to_type,rest)
{
	_low_index = low_index;
}

void AaSliceExpression::Evaluate()
{
	if(!_already_evaluated)
	{
		_already_evaluated = true;

		if(this->_rest->Get_Type() == NULL)
			this->_rest->Set_Type(this->Get_To_Type());

		this->_rest->Evaluate();
		if(this->_rest->Is_Constant())
		{
			int hi = this->_low_index + this->Get_Type()->Size() - 1;

			this->Assign_Expression_Value(Perform_Slice_Operation(this->_rest->Get_Expression_Value(), hi,
						this->_low_index));
		}

		if(_rest->Get_Does_Pipe_Access())
		{
			this->Set_Does_Pipe_Access(true);
		}
	}

}


//
// same as bit-cast, but the casting operation is a bit different.
//
void AaSliceExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
	if(!this->Is_Constant())
	{
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());

		this->_rest->Write_VC_Datapath_Instances(NULL,ofile);

		ofile << "// " << this->To_String() << endl;
		string dpe_name = this->Get_VC_Datapath_Instance_Name();
		string src_name = this->_rest->Get_VC_Driver_Name(); 
		string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

		int high_index = this->Get_Type()->Size() + this->_low_index - 1;
		Write_VC_Slice_Operator(dpe_name,
				src_name,
				tgt_name,
				high_index,
				this->_low_index,
				this->Get_VC_Guard_String(),
				flow_through,
				full_rate, 
				ofile);

		// extreme pipelining.
		if(!flow_through)
			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);
		int delay = (flow_through ? 0 : this->Get_Delay());
		ofile << "$delay " << dpe_name << " " << delay << endl;
	}
}

void AaSliceExpression::Print(ostream& ofile)
{
	ofile << "( $slice ";
	this->_rest->Print(ofile);
	ofile << " " << this->Get_Type()->Size() + this->_low_index - 1 << " " << this->_low_index;
	this->Print_Buffering(ofile);
	ofile  << " ) ";
}

void AaSliceExpression::PrintC(ofstream& ofile)
{
	this->_rest->PrintC(ofile);
	Print_C_Slice_Operation(this->_rest->C_Reference_String(), 
			this->_rest->Get_Type(),
			this->_low_index, 
			this->C_Reference_String(),
			this->Get_Type(), 
			ofile);
}

//---------------------------------------------------------------------
// AaUnaryExpression
//---------------------------------------------------------------------
AaUnaryExpression::AaUnaryExpression(AaScope* parent_tpr,AaOperation op, AaExpression* rest):AaExpression(parent_tpr)
{
	this->_operation  = op;
	this->_rest       = rest;

	//
	// type of result is the same as the type of
	// the operand, only if the operation is a NOT
	// operation.
	//
	// added: Priority encode also!
	// added: Bitmap also!
	//
	if((op == __NOT) || (op == __PRIORITYENCODE) || (op == __BITMAP))
		AaProgram::Add_Type_Dependency(this,rest);

	if(rest)
		rest->Add_Target(this);

	if((this->_operation == __BITREDUCEOR) ||
			(this->_operation == __BITREDUCEAND) ||
			(this->_operation == __BITREDUCEXOR))
	{
		AaType* nt = AaProgram:: Make_Uinteger_Type(1);
		this->AaExpression::Set_Type(nt);
	}

	this->Set_Delay(UNARY_INTEGER_OPERATION_DELAY);
}

AaUnaryExpression::~AaUnaryExpression() {};
void AaUnaryExpression::Set_Associated_Statement(AaStatement* stmt)
{
	_associated_statement = stmt;
	_rest->Set_Associated_Statement(stmt);
}
void AaUnaryExpression::Print(ostream& ofile)
{
	ofile << "( ";
	ofile << Aa_Name(this->Get_Operation());
	ofile << " ";
	this->Get_Rest()->Print(ofile);
	this->Print_Buffering(ofile);
	ofile << " )";
}

void AaUnaryExpression::PrintC_Declaration(ofstream& ofile)
{
	this->_rest->PrintC_Declaration(ofile);
	this->AaExpression::PrintC_Declaration(ofile);
}

void AaUnaryExpression::PrintC(ofstream& ofile)
{
	this->_rest->PrintC(ofile);
	Print_C_Unary_Operation(this->_rest->C_Reference_String(), 
			this->_rest->Get_Type(), 
			this->C_Reference_String(),
			this->Get_Type(),
			this->Get_Operation(),
			ofile);
}


string AaUnaryExpression::Get_VC_Name()
{
	string ret_val;
	string idx = Int64ToStr(this->Get_Index());

	ret_val = Get_Op_Ascii_Name(this->Get_Operation(), _rest->Get_Type(), this->Get_Type());	
	ret_val += "_" + idx;
	return(ret_val);
}

void AaUnaryExpression::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	if(!this->Is_Constant())
	{
		if(this->Get_Is_On_Collect_Root_Sources_Stack())
			AaRoot::Error("Cycle in collect-root-sources", this);
		this->Set_Is_On_Collect_Root_Sources_Stack(true);
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			_rest->Collect_Root_Sources(root_set);
		else
			root_set.insert(this);

		this->Set_Is_On_Collect_Root_Sources_Stack(false);
	}
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
		this->Check_Volatile_Inconsistency();
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		ofile << ";;[" << this->Get_VC_Name() << "] { // unary expression " << endl;
		this->_rest->Write_VC_Control_Path(ofile);

		if(not flow_through)
			ofile << "||[SplitProtocol] { " << endl;
		else
		{
			ofile << "// flow-through" << endl;
			ofile << ";;[SplitProtocol] { " << endl;
		}

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

		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());

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
				flow_through, 
				false, //not a bit-cast.
				full_rate, 
				ofile);

		if(!flow_through)
			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);

		int delay = (flow_through ? 0 : this->Get_Delay());
		ofile << "$delay " << dpe_name << " " << delay << endl;
	}

}
void AaUnaryExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Links(hier_id + "/" + this->Get_VC_Name(), ofile);

		ofile << "// " << this->To_String() << endl;
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

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
	__InsMap(adjacency_map,_rest,this,_rest->Get_Delay());
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
}

void AaUnaryExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_rest, used_expr, replacement);
}

//---------------------------------------------------------------------
// AaBitmapExpression
//---------------------------------------------------------------------
AaBitmapExpression::AaBitmapExpression(AaScope* scope, map<int,int>& bitmap, AaExpression *rest):
	AaUnaryExpression(scope, __BITMAP, rest)
{
	for(map<int,int>::iterator iter = bitmap.begin(), fiter = bitmap.end(); iter != fiter; iter++)
	{	
		_bitmap_vector.push_back(pair<int,int>((*iter).second, (*iter).first));	
	}	
}

void AaBitmapExpression::Check_If_Well_Formed()
{
	// need to check if the bitmap is well-formed!
	set<int> mapped_dests;
	set<int> mapped_srcs;
	for(int I = 0, fI  = _bitmap_vector.size(); I < fI; I++)
	{
		int s = _bitmap_vector[I].first;
		mapped_srcs.insert(s);

		int d  = _bitmap_vector[I].second;
		mapped_dests.insert(d);
	}

	// if I is a dest, it must also be a source!
	for(set<int>::iterator iter = mapped_dests.begin(), fiter = mapped_dests.end(); 
			iter != fiter; iter++)
	{
		int d = *iter;
		if(mapped_srcs.find(d) == mapped_srcs.end())
		{
			AaRoot::Error("inconsistent bit-map specification ", this);
		}
	}
}


void AaBitmapExpression::Evaluate()
{
	if(!_already_evaluated)
	{
		_already_evaluated = true;
		this->_rest->Evaluate();
		if(this->_rest->Is_Constant())
			this->Assign_Expression_Value(Perform_Bitmap_Operation(this->_rest->Get_Expression_Value(), this->_bitmap_vector));
		if(_rest->Get_Does_Pipe_Access())
		{
			this->Set_Does_Pipe_Access(true);
		}
	}
}


void AaBitmapExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Datapath_Instances(NULL,ofile);


		ofile << "// " << this->To_String() << endl;
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());

		string dpe_name = this->Get_VC_Datapath_Instance_Name();
		string src_name = this->_rest->Get_VC_Driver_Name(); 
		string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

		Write_VC_Bitmap_Operator(dpe_name,
				src_name,
				tgt_name,
				this->Get_Type(),
				this->_bitmap_vector,
				this->Get_VC_Guard_String(),
				flow_through,
				full_rate,
				ofile);

		// extreme pipelining.
		if(!flow_through)
			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);
		int delay = (flow_through ? 0 : this->Get_Delay());
		ofile << "$delay " << dpe_name << " " << delay << endl;
	}
}

void AaBitmapExpression::Print(ostream& ofile)
{
	ofile << "( $bitmap ";
	this->_rest->Print(ofile);
	for(int idx = 0, fidx = _bitmap_vector.size(); idx < fidx; idx++)
	{
		ofile << " " <<  _bitmap_vector[idx].first << " " << _bitmap_vector[idx].second << " ";
	}
	this->Print_Buffering(ofile);
	ofile << " ) ";
}

void AaBitmapExpression::PrintC(ofstream& ofile)
{
	// not supported for now... until its utility is clearer :-)
	AaRoot::Error("Bitmap operation not supported in Aa2C." , this);
	assert(0);
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

	this->Set_Delay(BINARY_INTEGER_OPERATION_DELAY);
}

AaBinaryExpression::~AaBinaryExpression() {};

string AaBinaryExpression::Get_VC_Name()
{
	string ret_val;
	string idx = Int64ToStr(this->Get_Index());

	ret_val = Get_Op_Ascii_Name(this->Get_Operation(), _first->Get_Type(), this->Get_Type());	
	ret_val += "_" + idx;
	return(ret_val);
}

void AaBinaryExpression::Print(ostream& ofile)
{
	ofile << "(" ;
	this->Get_First()->Print(ofile);
	ofile << " ";
	ofile << Aa_Name(this->Get_Operation());
	ofile << " ";
	this->Get_Second()->Print(ofile);
	this->Print_Buffering(ofile);
	ofile << ")";
}

void AaBinaryExpression::PrintC_Declaration(ofstream& ofile)
{
	this->_first->PrintC_Declaration(ofile);
	this->_second->PrintC_Declaration(ofile);
	this->AaExpression::PrintC_Declaration(ofile);
}

void AaBinaryExpression::PrintC(ofstream& ofile)
{

	this->_first->PrintC(ofile);
	this->_second->PrintC(ofile);


	Print_C_Binary_Operation(this->_first->C_Reference_String(), 
			this->_first->Get_Type(),
			this->_second->C_Reference_String(),
			this->_second->Get_Type(),
			this->C_Reference_String(),
			this->Get_Type(), 
			this->Get_Operation(), 
			ofile);
}

void AaUnaryExpression::Update_Type()
{
	AaType* rest_type = _rest->Get_Type();
	AaType* this_type = this->Get_Type();

	if(this->_operation == __DECODE)
	{
		if(rest_type != NULL)
		{
			if(rest_type->Is("AaUintType"))
			{
				int rest_width = ((AaUintType*) rest_type)->Get_Width();
				if(this_type == NULL)
				{		
					AaType* nt = AaProgram::Make_Uinteger_Type(1 << rest_width);
					this->AaExpression::Set_Type(nt);
				}
				else 
				{
					if(!this_type->Is("AaUintType"))
					{
						AaRoot::Error("type of decode expression must be $uint",this);
					}
					else if((((AaUintType*)this_type)->Get_Width()) != (1 << rest_width))
					{
						AaRoot::Error("width of decode type does not match type being decoded.",this);
					}

				}
			}
			else
			{
				AaRoot::Error("type of rest-expr in decode expr must be $uint",this);
			}
		}
	}
	else if(this->_operation == __ENCODE)
	{
		if(rest_type != NULL)
		{
			if(rest_type->Is("AaUintType"))
			{
				uint32_t rest_width = ((AaUintType*) rest_type)->Get_Width();
				if((rest_width < 2) || (rest_width != (1 << uLog2(rest_width))))
				{
					AaRoot::Error("in encode expression, rest-expr width must be > 1, and a power of 2",
							this);
				}
				else
				{
					if(this_type == NULL)
					{		
						AaType* nt = AaProgram::Make_Uinteger_Type(uLog2(rest_width));
						this->AaExpression::Set_Type(nt);
					}
					else 
					{
						if(!this_type->Is("AaUintType"))
						{
							AaRoot::Error("type of decode expression must be $uint",this);
						}
						else if((((AaUintType*)this_type)->Get_Width()) != CeilLog2(rest_width)) 
						{
							AaRoot::Error("width of decode type does not match type being decoded.",this);
						}

					}
				}
			}
			else
			{
				AaRoot::Error("type of rest-expr in encode expr must be $uint",this);
			}
		}
	}
	else if((this->_operation == __BITREDUCEOR) ||
			(this->_operation == __BITREDUCEAND) ||
			(this->_operation == __BITREDUCEXOR))
	{
		if(this_type == NULL)
		{
			AaType* nt = AaProgram:: Make_Uinteger_Type(1);
			this->AaExpression::Set_Type(nt);
		}
	}
}


void AaBinaryExpression::Update_Type()
{
	AaType* t1 = this->Get_First()->Get_Type();
	AaType* t2 = this->Get_Second()->Get_Type();

	if(Is_Concat_Operation(this->_operation))
	{
		// check the types of both sources.
		// they must both be uintegers and
		// the type of this expression must
		// be a uinteger whose width is the
		// sume of those of the sources.

		if(t1 != NULL && t2 != NULL)
		{
			int t1_width = 0;  int t2_width = 0;
			if(t1->Is("AaUintType") && t2->Is("AaUintType"))
			{
				t1_width = ((AaUintType*)t1)->Get_Width();
				t2_width = ((AaUintType*)t2)->Get_Width();
			}
			else
			{
				AaRoot::Error("source arguments of concatenate expression must have uint types",this);
			}
			if(this->Get_Type() == NULL)
			{
				if((t1_width > 0) && (t2_width > 0))
				{
					AaType* nt = AaProgram::
						Make_Uinteger_Type(t1_width + t2_width);
					this->AaExpression::Set_Type(nt);
				}
			}
			else
			{
				if((t1_width > 0) && (t2_width > 0))
				{
					AaType* this_type = this->Get_Type();
					if(this_type->Is("AaUintType"))
					{
						int this_width = ((AaUintType*)this_type)->Get_Width();
						if(this_width != (t1_width + t2_width))
						{
							AaRoot::Error("concatenation width not sum of constituent widths", this);
						}
					}
					else
					{
						AaRoot::Error("concatenate expression must have uint type",this);
					}
				}
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
	{
		// float add/sub operations will have higher delay!
		if((this->_operation == __PLUS)  || (this->_operation == __MINUS)
				|| (this->_operation == __MUL) || (this->_operation == __DIV))
			this->Set_Delay(BINARY_FLOAT_OPERATION_DELAY);
		else
			this->Set_Delay(BINARY_INTEGER_OPERATION_DELAY);
	}
}

bool AaBinaryExpression::Is_Trivial()
{
	// not-trivial
	// 	floating point ops
	//      muls and shifts > 64 bits
	bool ret_val = true;	

	bool second_is_constant = (this->_second != NULL) && this->_second->Is_Constant();
	// 64-bit mul/shifts are trivial (ha ha)
	if(!this->Get_Type()->Is_Float_Type() && 
			((this->_operation == __MUL) || 
				(Is_Shift_Operation(this->_operation) && !second_is_constant)))
	{
		// lets say we can do up to 64-bit mul/shift operations in one cycle.
		// even though they have quadratic complexity.
		ret_val =  (this->_first->Get_Type()->Size() <= 64);
	}
	else if(this->Get_Type()->Is_Float_Type())
	{
		// floats are never trivial.
		ret_val = false;
	}

	return(ret_val);
}

void AaBinaryExpression::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	if(!this->Is_Constant())
	{
		if(this->Get_Is_On_Collect_Root_Sources_Stack())
			AaRoot::Error("Cycle in collect-root-sources", this);
		this->Set_Is_On_Collect_Root_Sources_Stack(true);
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
		{
			_first->Collect_Root_Sources(root_set);
			_second->Collect_Root_Sources(root_set);
		}
		else
			root_set.insert(this);

		this->Set_Is_On_Collect_Root_Sources_Stack(false);
	}
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

		this->Check_Volatile_Inconsistency();
		ofile << "// " << this->To_String() << endl;

		ofile << ";;[" << this->Get_VC_Name() << "] { // binary expression " << endl;

		ofile << "||[" << this->Get_VC_Name() << "_inputs] { " << endl;
		this->_first->Write_VC_Control_Path(ofile);
		this->_second->Write_VC_Control_Path(ofile);
		ofile << "}" << endl;

		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(not flow_through) 
			ofile << "||[SplitProtocol] { " << endl;
		else
		{
			ofile << "// flow-through" << endl;
			ofile << ";;[SplitProtocol] { " << endl;
		}
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
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());


		string dpe_name = this->Get_VC_Datapath_Instance_Name();
		string src_1_name = _first->Get_VC_Driver_Name();
		string src_2_name = _second->Get_VC_Driver_Name();
		string tgt_name = (target != NULL ? target->Get_VC_Receiver_Name() : this->Get_VC_Receiver_Name());

		//bool add_hash = this->Is_Logical_Operation() && AaProgram::_optimize_flag && this->Is_Part_Of_Pipeline();
		bool add_hash = false; // turn it off, the operator is way too heavy.

		Write_VC_Binary_Operator(this->Get_Operation(),
				dpe_name,
				src_1_name,
				_first->Get_Type(),
				src_2_name,
				_second->Get_Type(),
				tgt_name,
				(target != NULL ? target->Get_Type() : this->Get_Type()),
				this->Get_VC_Guard_String(),
				add_hash,
				flow_through,
				full_rate, 
				ofile);

		// extreme pipelining.
		if(!flow_through)
			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);
		int delay = (flow_through ? 0 : this->Get_Delay());
		ofile << "$delay " << dpe_name << " " << delay << endl;
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
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

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
	__InsMap(adjacency_map,_first,this,_first->Get_Delay());
	__InsMap(adjacency_map,_second,this,_second->Get_Delay());
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
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

	this->Set_Delay(TERNARY_OPERATION_DELAY);
}
AaTernaryExpression::~AaTernaryExpression() {};

string AaTernaryExpression::Get_VC_Name()
{
	string ret_val;
	string idx = Int64ToStr(this->Get_Index());

	ret_val = "MUX";
	ret_val += "_" + idx;
	return(ret_val);
}

void AaTernaryExpression::Print(ostream& ofile)
{
	ofile << "( $mux ";
	this->Get_Test()->Print(ofile);
	ofile << " ";
	this->Get_If_True()->Print(ofile);
	ofile << "  ";
	this->Get_If_False()->Print(ofile);
	this->Print_Buffering(ofile);
	ofile << " ) ";
}

void AaTernaryExpression::PrintC_Declaration(ofstream& ofile)
{
	this->_test->PrintC_Declaration(ofile);
	this->_if_true->PrintC_Declaration(ofile);
	this->_if_false->PrintC_Declaration(ofile);

	this->AaExpression::PrintC_Declaration(ofile);
}

void AaTernaryExpression::PrintC(ofstream& ofile)
{
	assert(this->_test->Get_Type()->Is_Integer_Type());

	this->_test->PrintC(ofile);
	if(!this->_test->Is_Constant())
	{
		Print_C_Assert_If_Bitvector_Undefined(this->_test->C_Reference_String(), ofile);
	}

	AaType* tgt_type = this->Get_Type();
	string tgt = this->C_Reference_String();

	AaType* if_expr_type = this->_if_true->Get_Type();
	string if_expr = this->_if_true->C_Reference_String();

	AaType* else_expr_type = this->_if_false->Get_Type();
	string else_expr = this->_if_false->C_Reference_String();

	ofile << "if(" << C_Value_Expression(this->_test->C_Reference_String(), this->_test->Get_Type()) << ")";
	ofile << "{";
	this->_if_true->PrintC(ofile);
	if(tgt_type->Is_Integer_Type())
		ofile << "bit_vector_cast_to_bit_vector(" << (!tgt_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << tgt 
			<< "), &(" << if_expr << "));" << __endl__;
	else
		ofile << tgt << " = " << if_expr << ";" << __endl__;
	ofile << "}";
	ofile << "else {";
	this->_if_false->PrintC(ofile);
	if(tgt_type->Is_Integer_Type())
		ofile << "bit_vector_cast_to_bit_vector(" << (!tgt_type->Is_Uinteger_Type() ? 1 : 0) << ", &(" << tgt << "), &(" 
			<< else_expr << "));" << __endl__;
	else
		ofile << tgt << " = " << else_expr<< ";" << __endl__;
	ofile << "}";

	/*
	Print_C_Ternary_Operation(this->_test->C_Reference_String(),
			this->_test->Get_Type(),
			this->_if_true->C_Reference_String(), 
			this->_if_true->Get_Type(),
			this->_if_false->C_Reference_String(), 
			this->_if_false->Get_Type(),
			this->C_Reference_String(), 
			this->Get_Type(),
			ofile);
	*/
}

void AaTernaryExpression::Write_VC_Control_Path(ostream& ofile)
{

	ofile << "// " << this->To_String() << endl;
	this->Check_Volatile_Inconsistency();

	// if _test is constant, print dummy.
	if(!this->Is_Constant())
	{

		// TODO: ternary will be triggered from three points. fork region.
		ofile << ";;[" << this->Get_VC_Name() << "] { // ternary expression: " << endl;
		ofile << "||[" << this->Get_VC_Name() << "_inputs] { " << endl;
		this->_test->Write_VC_Control_Path(ofile);
		if(this->_if_true)
			this->_if_true->Write_VC_Control_Path(ofile);

		if(this->_if_false)
			this->_if_false->Write_VC_Control_Path(ofile);
		ofile << "}" << endl;

		ofile << "|| [Mux] { " << endl;

		ofile << ";; [Sample] {" << endl;
		ofile << "$T [req] $T [ack] // select req/ack" << endl;
		ofile << "}" << endl;
		ofile << ";; [Update] {" << endl;
		ofile << "$T [req] $T [ack] // select req/ack" << endl;
		ofile << "}" << endl;
		ofile << "}" << endl;

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
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		bool full_rate = ((this->Get_Associated_Statement() != NULL)
				&& this->Get_Associated_Statement()->Is_Part_Of_Fullrate_Pipeline());

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
				flow_through,
				full_rate,
				ofile);
		if(!flow_through)
			this->Write_VC_Output_Buffering(dpe_name, tgt_name, ofile);
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
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

		vector<string> reqs,acks;
		reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Mux/Sample/req");
		reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Mux/Update/req");
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Mux/Sample/ack");
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Mux/Update/ack");

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
	__InsMap(adjacency_map,_test,this,_test->Get_Delay());
	__InsMap(adjacency_map,_if_true,this,_if_true->Get_Delay());
	__InsMap(adjacency_map,_if_false,this,_if_false->Get_Delay());
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
}

void AaTernaryExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	this->Replace_Field_Expression(&_test, used_expr, replacement);
	this->Replace_Field_Expression(&_if_true, used_expr, replacement);
	this->Replace_Field_Expression(&_if_false, used_expr, replacement);
}

void AaTernaryExpression::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	if(!this->Is_Constant())
	{
		if(this->Get_Is_On_Collect_Root_Sources_Stack())
			AaRoot::Error("Cycle in collect-root-sources", this);
		this->Set_Is_On_Collect_Root_Sources_Stack(true);
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
		{
			_test->Collect_Root_Sources(root_set);
			_if_true->Collect_Root_Sources(root_set);
			_if_false->Collect_Root_Sources(root_set);
		}
		else
			root_set.insert(this);

		this->Set_Is_On_Collect_Root_Sources_Stack(false);
	}
}

/////////////////////////////////////////////////  Function Call  /////////////////////////////////////////
AaFunctionCallExpression::AaFunctionCallExpression
	(AaScope* scope, string module_id, vector<AaExpression*>& args):AaExpression(scope)
{
	_module_identifier = module_id;
	_called_module = NULL;
	for(int I = 0, fI = args.size();I < fI; I++)
	{
		AaExpression* expr = args[I];
		_arguments.push_back(expr);
		expr->Add_Target(this);
	}
}

AaFunctionCallExpression::~AaFunctionCallExpression()  {};

void AaFunctionCallExpression::Print(ostream& ofile)
{
	ofile << "( $call " << _module_identifier << " (";
	for(int I = 0, fI = _arguments.size();I < fI; I++)
	{
		_arguments[I]->Print(ofile);
		ofile << " ";
	}
	ofile << ") )";
}



void AaFunctionCallExpression::Map_Source_References(set<AaRoot*>& source_objects) 
{
	AaModule* called_module = AaProgram::Find_Module(this->_module_identifier);
	if(called_module != NULL)
	{
		this->_called_module = called_module;

		if(called_module->Get_Number_Of_Output_Arguments() == 1)
		{
			called_module->Increment_Number_Of_Times_Called();
			this->Set_Type(called_module->Get_Output_Argument(0)->Get_Type());

			AaModule* caller_module = this->Get_Module();
			assert(caller_module != NULL);
			AaProgram::Add_Call_Pair(caller_module,called_module);

			for(int I = 0, fI = _arguments.size(); I < fI; I++)
			{
				this->_arguments[I]->Map_Source_References(source_objects);
				this->_arguments[I]->Set_Type(called_module->Get_Input_Argument(I)->Get_Type());
			}
		}
		else
		{
			AaRoot::Error("In function-call-expression, called module must have exactly one output arg.",
					this);
		}
	}
	else
	{
		AaRoot::Error("In function-call-expression, called module not found.",
				this);
	}
}
	
string AaFunctionCallExpression::Get_VC_Name()
{
	string ret_val = "call_" + this->_module_identifier  + "_expr_" + Int64ToStr(this->Get_Index());
	return(ret_val);
}

	
void AaFunctionCallExpression::PrintC_Declaration( ofstream& ofile)
{
	
	for(int I = 0, fI = _arguments.size(); I < fI; I++)
	{
		this->_arguments[I]->PrintC_Declaration(ofile);
	}
	this->AaExpression::PrintC_Declaration(ofile);
}

	
void AaFunctionCallExpression::PrintC( ofstream& ofile)
{
	for(int I = 0, fI = _arguments.size(); I < fI; I++)
	{
		this->_arguments[I]->PrintC(ofile);
	}
	bool first_one = true;
	ofile << this->_called_module->Get_C_Inner_Wrap_Function_Name()
		<< "(";
	for(int i=0,fi=_arguments.size(); i < fi; i++)
	{
		if(!first_one)
			ofile << ", ";
		ofile << " &(" << this->_arguments[i]->C_Reference_String() << ")";
		first_one = false;
	}
	if(!first_one) ofile << ", "; 
	ofile << "&(";
	ofile << this->C_Reference_String() << ")";
	ofile  <<  ");\\" << endl;
}
	
void AaFunctionCallExpression::Write_VC_Control_Path( ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	this->Check_Volatile_Inconsistency();

	if(!this->Is_Constant())
	{
		ofile << ";;[" << this->Get_VC_Name() << "] { // function-call expression: " << endl;
		ofile << "||[" << this->Get_VC_Name() << "_inputs] { " << endl;
		for(int i=0,fi=_arguments.size(); i < fi; i++)
		{
			AaExpression* expr = _arguments[i];
			if(!expr->Is_Constant())
				expr->Write_VC_Control_Path(ofile);
		}
		ofile << "}" << endl;

		if(!this->Is_Trivial())
		{
			ofile << "|| [Call] { " << endl;

			ofile << ";; [Sample] {" << endl;
			ofile << "$T [req] $T [ack] // select req/ack" << endl;
			ofile << "}" << endl;
			ofile << ";; [Update] {" << endl;
			ofile << "$T [req] $T [ack] // select req/ack" << endl;
			ofile << "}" << endl;
			ofile << "}" << endl;

			ofile << "}" << endl;
		}
	}
}

void AaFunctionCallExpression::Write_VC_Constant_Wire_Declarations(ostream& ofile)
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
		for(int i=0,fi=_arguments.size(); i < fi; i++)
		{
			AaExpression* expr = _arguments[i];
			expr->Write_VC_Constant_Wire_Declarations(ofile);
		}
	}
}

void AaFunctionCallExpression::Write_VC_Wire_Declarations(bool skip_immediate, ostream& ofile)
{
	if(!this->Is_Constant())
	{
		for(int i=0,fi=_arguments.size(); i < fi; i++)
		{
			AaExpression* expr = _arguments[i];
			if(!expr->Is_Constant())
				expr->Write_VC_Wire_Declarations(false,ofile);
		}

		// NOTE:
		// skip_immediate is ignored for function-call expressions
		// because they are handled a bit differently from normal
		// expressions (cannot embed a register into a volatile fn call).
		//
		if(this->Is_Trivial() || !skip_immediate)
		{
			ofile << "// " << this->To_String() << endl;
			Write_VC_Intermediate_Wire_Declaration(this->Get_VC_Driver_Name(),
					this->Get_Type(),
					ofile);
		}
	}
}

void AaFunctionCallExpression::Write_VC_Datapath_Instances(AaExpression* target, ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	int delay = (this->_called_module->Get_Volatile_Flag() ? 0 : 
			((AaModule*)_called_module)->Get_Delay());
	bool full_rate = this->Is_Part_Of_Fullrate_Pipeline();

	vector<pair<string,AaType*> > inargs, outargs;

	for(int idx = 0, fidx =  _arguments.size(); idx < fidx;  idx++)
	{
		_arguments[idx]->Write_VC_Datapath_Instances(NULL, ofile);
		inargs.push_back(pair<string,AaType*>(_arguments[idx]->Get_VC_Driver_Name(),
					_arguments[idx]->Get_Type()));
	}

	if(target == NULL)
	{
		outargs.push_back(pair<string,AaType*>(this->Get_VC_Receiver_Name(),
					this->Get_Type()));
	}
	else
	{
		outargs.push_back(pair<string,AaType*>(target->Get_VC_Receiver_Name(),
					target->Get_Type()));
	}

	string dpe_name = this->Get_VC_Datapath_Instance_Name();
	string guard_string = this->Get_VC_Guard_String();
	Write_VC_Call_Operator(dpe_name,
			_module_identifier,
			inargs,
			outargs,
			guard_string,	// guard-string
			this->Is_Trivial(), // volatile.
			full_rate,		      
			ofile);

	// no need for additional buffering if volatile..
	if(this->Is_Trivial())
		return;

	ofile << "$delay " << dpe_name <<  " " << delay << endl;

	// extreme pipelining.
	AaStatement* dws = this->Get_Pipeline_Parent();
	int buffering = this->Get_Buffering();

	//
	// Rationalized earlier...
	//if((dws != NULL)  && (dws->Get_Pipeline_Full_Rate_Flag()))
	//{
	//if(buffering < 2) 
	//buffering = 2;
	//}

	//
	// input buffering is used to decouple the
	// two sides.
	//
	for(int i = 0; i < inargs.size(); i++)
	{
		string src_name = inargs[i].first;
		ofile << "$buffering  $in " << dpe_name << " "
			<< src_name << " " << buffering << endl;
	}

	//
	// output buffering is used to decouple the
	// two sides.
	//
	string tgt_name = outargs[0].first;
	ofile << "$buffering  $out " << dpe_name << " "
		<< tgt_name << " " << buffering << endl;
}


void AaFunctionCallExpression::Write_VC_Links(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		for(int idx = 0, fidx =  _arguments.size(); idx < fidx;  idx++)
		{
			_arguments[idx]->Write_VC_Links(hier_id + "/" + this->Get_VC_Name() + "/" +
					this->Get_VC_Name() + "_inputs", ofile);
		}

		bool flow_through = this->Is_Trivial();
		if(!flow_through) 
		{

			ofile << "// " << this->To_String() << endl;

			vector<string> reqs,acks;
			reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Call/Sample/req");
			reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "/Call/Update/req");
			acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Call/Sample/ack");
			acks.push_back(hier_id + "/" + this->Get_VC_Name() + "/Call/Update/ack");

			Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),
					reqs,
					acks,
					ofile);
		}
	}
}

void AaFunctionCallExpression::Evaluate()
{
	for(int idx = 0, fidx = _arguments.size(); idx < fidx; idx++)
	{
		_arguments[idx]->Evaluate();
	}
}



void AaFunctionCallExpression::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	for(int I = 0, fI = _arguments.size(); I < fI; I++)
	{
		_arguments[I]->Update_Adjacency_Map(adjacency_map, visited_elements);
		
		int delay = 0;
		if(!this->_called_module->Get_Volatile_Flag())
			delay = this->_called_module->Get_Delay();

		__InsMap(adjacency_map,_arguments[I],this,delay);
	}
	this->Update_Guard_Adjacency(adjacency_map,visited_elements);
	visited_elements.insert(this);
}



void AaFunctionCallExpression::Replace_Uses_By(AaExpression* used_expr, AaAssignmentStatement* replacement)
{
	vector<AaExpression*> vec;
	for(int I = 0, fI = _arguments.size(); I < fI; I++)
	{
		AaExpression* expr = _arguments[I];
		this->Replace_Field_Expression(&expr, used_expr, replacement);
		vec.push_back(expr);
	}
	_arguments.clear();
	for(int J = 0, fJ = vec.size(); J < fJ; J++)
	{
		_arguments.push_back(vec[J]);
	}
}



void AaFunctionCallExpression::Collect_Root_Sources(set<AaRoot*>& root_set)
{
	if(!this->Is_Constant())
	{
		if(this->Get_Is_On_Collect_Root_Sources_Stack())
			AaRoot::Error("Cycle in collect-root-sources", this);
		this->Set_Is_On_Collect_Root_Sources_Stack(true);
		bool flow_through = this->Is_Trivial();

		if(flow_through)
		{
			for(int I = 0, fI = _arguments.size(); I < fI; I++)
			{
				AaExpression* expr = _arguments[I];
				expr->Collect_Root_Sources(root_set);
			}
		}
		else
			root_set.insert(this);

		this->Set_Is_On_Collect_Root_Sources_Stack(false);
	}
}


bool AaFunctionCallExpression::Is_Trivial() // return false if called module is volatile.
{
	return(_called_module->Get_Volatile_Flag());
}

bool AaFunctionCallExpression::Can_Be_Combinationalized()
{
	bool ret_val = false;
	if((this->_called_module != NULL)  && this->_called_module->Get_Is_Volatile())
		ret_val = true;
	return(ret_val);
}

bool AaFunctionCallExpression::Is_Write_To_Pipe(AaPipeObject* obj)
{
	
	bool ret_val = false;
	if(this->_called_module)
	{
		ret_val = this->_called_module->Writes_To_Pipe(obj);
	}
	return(ret_val);
}

bool AaFunctionCallExpression::Writes_To_Memory_Space(AaMemorySpace* ms)
{
	bool ret_val = false;
	if(this->_called_module && !this->_called_module->Get_Foreign_Flag())
	{
		ret_val = this->_called_module->Writes_To_Memory_Space(ms);
	}
	return(ret_val);
}

bool AaFunctionCallExpression:: Get_Is_Volatile() 
{
	return(_called_module->Get_Is_Volatile());
}

bool AaFunctionCallExpression::Is_Opaque_Function_Call_Expression()
{
	return(_called_module->Get_Opaque_Flag());
}

/////////////////////////////////////////////////  Utilities //////////////////////////////////////////////
AaExpression* Make_Reduce_Expression_Base(AaScope* scope, int line_no, 
		int sindex, int findex, 
		AaOperation op,  vector<AaExpression*>& expr_vector)
{
	AaExpression* ret_expr = NULL;
	int SZ = (findex-sindex)+1;
	if(SZ == 1)
	{
		ret_expr = expr_vector[sindex];
	}
	else
	{
		int MP = sindex + ((findex-sindex)/2);
		AaExpression* le = Make_Reduce_Expression_Base(scope, line_no, sindex, MP, op, expr_vector);
		AaExpression* re = Make_Reduce_Expression_Base(scope, line_no, MP+1, findex, op, expr_vector);

		ret_expr = new AaBinaryExpression(scope,op, le, re);
		ret_expr->Set_Line_Number(line_no);
	}

	return(ret_expr);
}

AaExpression* Make_Reduce_Expression(AaScope* scope, int line_no, AaOperation op,  vector<AaExpression*>& expr_vector)
{

	AaExpression* ret_expr = Make_Reduce_Expression_Base(scope, line_no, 0, expr_vector.size()-1, op, expr_vector);
	return(ret_expr);

}


AaExpression* Make_Priority_Mux_Expression(AaScope* scope, int line_no, int sindex, vector<pair<AaExpression*,AaExpression*> >& expr_vector,
		AaExpression* default_expr)
{
	AaExpression* ret_expr = NULL;
	if(sindex == expr_vector.size())
	{
		ret_expr = default_expr;
	}
	else if(sindex < expr_vector.size())
	{
		AaExpression* rest = Make_Priority_Mux_Expression(scope, line_no, sindex+1, expr_vector, default_expr);
		ret_expr = new AaTernaryExpression(scope, expr_vector[sindex].first, expr_vector[sindex].second, rest);
	}

	if(ret_expr != NULL)
		ret_expr->Set_Line_Number(line_no);

	return(ret_expr);
}

AaExpression* Make_Exclusive_Mux_Expression(AaScope* scope, int line_no, int sindex, int findex,
		vector<pair<AaExpression*,AaExpression*> >& expr_vector)
{
	vector<AaExpression*> and_expr_vector;

	for(int I = 0, fI = expr_vector.size(); I < fI; I++)
	{

		//
		// Some ugly stuff here... should make literal forming
		// easier...
		//
		AaConstantLiteralReference* zero_expr = NULL;
		string zfn = "_b0";
		vector<string> literals; literals.push_back(zfn);
		zfn += " ";
		zero_expr = new AaConstantLiteralReference(scope, zfn, literals);

		//
		// need to create a mux because test expression type may be different from
		// choices..
		// 
		AaExpression* ne = new AaTernaryExpression(scope, expr_vector[I].first, expr_vector[I].second, zero_expr);
		ne->Set_Line_Number(line_no);
		and_expr_vector.push_back(ne);
	}

	AaExpression* ret_expr = Make_Reduce_Expression(scope, line_no, __OR, and_expr_vector);
	return(ret_expr);
}


