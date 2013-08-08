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

//
// Find all the non-trivial antecedents (those on which expr depends) of expr in visited_elements.
// put in a release dependency to each of these.
// 
void AaExpression::Write_VC_RAW_Release_Dependencies(AaExpression* expr, set<AaRoot*>& visited_elements)
{
	set<AaRoot*> non_triv_preds;
	expr->Identify_Non_Trivial_Predecessors(non_triv_preds, visited_elements);
	Write_VC_RAW_Release_Deps(((AaRoot*)this),non_triv_preds);
}


// "this" is a Write. If there is an expression expr in
// visited_elements which uses "this", then we have 
// a WAR dependency.  In this case, "this" must happen
// after expr.  Further, in the pipeline case, the 
// completion of "this" must release expr.
// 
// e.g.
//  a := (b + c)
//  b := (d + e)
//
// the write to b can happen only after a is updated.
// in case the pipeline flag is set, the expression
// that reads from b must be reenabled only after
// the write to b is finished.
//
// Here "this" is "b", "source_expr" is (d+e).
//
void AaExpression::Write_VC_WAR_Dependencies(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		AaExpression* source_expr,
		ostream& ofile)
{
	if(!this->Is_Implicit_Variable_Reference())
		return;

	AaStatement* pstmt = this->Get_Associated_Statement();
	assert(pstmt != NULL); // this is always a target..  so statement completion should retrigger read.

	// the transition that triggers the write.
	string write_trigger_transition_name;
	if(pstmt->Is("AaAssignmentStatement"))
		write_trigger_transition_name = ((AaAssignmentStatement*) pstmt)->Get_Source()->Get_VC_Start_Transition_Name();
	else 
		write_trigger_transition_name = ((AaCallStatement*) pstmt)->Get_VC_Start_Transition_Name();

	// root will be the statement b = (d+e) (or possibly a $call foo () (b))
	AaRoot* root = this->Get_Root_Object();
	if(root == NULL || !root->Is_Interface_Object() || root->Is_Statement())
	{
		root = this;
	}


	// expressions/statements in which root is used as a source..
	// these include expression "b" in (b+c)
	for(set<AaRoot*>::iterator iter = root->Get_Source_References().begin(), 
			fiter = root->Get_Source_References().end();
			iter != fiter;
			iter++)
		// search across all expressions that depend on root.
		// these include "b" in (b+c)
	{

		// found the  "b" in the elements already visited?
		if((*iter)->Is_Expression() && (visited_elements.find(*iter) != visited_elements.end()))
		{
			// "b" in (b+c) is found.
			AaExpression* expr = (AaExpression*)(*iter);

			if(!expr->Is_Constant())
			{
				//
				// the rhs source expression which is to be assigned to "this"
				// must be started only after expr has finished sampling its
				// inputs..  We are currently using the activation transition
				// of the associated statement of expr as the marker.
				//
				// the target "b = (d+e)" can be triggered only after the
				// statement a := (b+c) has used the value of b.
				//
				ofile << "// WAR dependency: Read: " << expr->To_String() << " before Write: " << pstmt->To_String() << endl;

				// The target "b = (d+e)" cannot be updated until the statement a := (b+c)
				// has finished.  This is conservative.
				__J(write_trigger_transition_name, expr->Get_Associated_Statement()->Get_VC_Completed_Transition_Name());

				// The completion of "b = (d+e)" reenables the
				// evaluation of "a = (b+c)"
				if(pipeline_flag)
				{
					ofile << "// WAR dependency: release  Read: " << expr->To_String() << " with Write: " << pstmt->To_String() << endl;
					// expr can get a new value only after this has completed.
					__MJ(expr->Get_VC_Reenable_Sample_Transition_Name(visited_elements),  
							__CT(pstmt));
				}
			}
		}
	}
}

void AaExpression::Write_VC_Guard_Dependency(bool pipeline_flag, set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(this->Get_Guard_Expression() != NULL)
	{
		AaExpression* expr = this->Get_Guard_Expression();
		if(expr->Is("AaSimpleObjectReference"))
		{
			AaSimpleObjectReference* sexpr = (AaSimpleObjectReference*) expr;
			AaRoot* root = sexpr->Get_Root_Object();
			if(visited_elements.find(root) != visited_elements.end())
			{
				__J(this->Get_VC_Start_Transition_Name(), root->Get_VC_Completed_Transition_Name());
			}
		}
		else
		{
			AaRoot::Error("guard expression must be an implicit variable reference.\n",this);
		}

		if(pipeline_flag)
		{
			// when this completes, the guard can be re-evaluated.
			__MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements), __CT(this));
		}
	}
}

// AaObjectReference
bool AaObjectReference::Is_Load()
{
	bool ret_val = false;
	assert(this->_object);
	if(this->_object->Is_Storage_Object())
	{
		if(!this->Get_Is_Target())
		{
			ret_val = true;
		}
	}
	return(ret_val);
}
bool AaObjectReference::Is_Store()
{
	bool ret_val = false;
	assert(this->_object);
	if(this->_object->Is_Storage_Object())
	{
		if(this->Get_Is_Target())
		{
			ret_val = true;
		}
	}
	return(ret_val);
}

// AaSimpleObjectReference
void AaSimpleObjectReference::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
	{
		ofile << "// " << this->To_String() << endl;

		vector<string> reqs;
		vector<string> acks;

		if(this->_object->Is("AaStorageObject"))
		{
			this->AaObjectReference::Write_VC_Load_Links_Optimized(hier_id,NULL,NULL,NULL,ofile);
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			string inst_name = this->Get_VC_Datapath_Instance_Name();
			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";
			reqs.push_back(hier_id + "/" + sample_regn + "/rr");
			reqs.push_back(hier_id + "/" + update_regn + "/cr");
			acks.push_back(hier_id + "/" + sample_regn + "/ra");
			acks.push_back(hier_id + "/" + update_regn + "/ca");
			Write_VC_Link(inst_name, reqs,acks,ofile);
		}
	}
}
void AaSimpleObjectReference::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{

	if(!this->Is_Constant() && !this->Is_Implicit_Variable_Reference())
	{

		ofile << "// " << this->To_String() << endl;
		vector<string> reqs;
		vector<string> acks;

		if(this->_object->Is("AaStorageObject"))
		{
			this->AaObjectReference::Write_VC_Store_Links_Optimized(hier_id,NULL,NULL,NULL,ofile);
		}
		else if(this->_object->Is("AaPipeObject"))
		{
			string inst_name = this->Get_VC_Datapath_Instance_Name();
			reqs.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/pipe_wreq");
			acks.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/pipe_wack");
			Write_VC_Link(inst_name, reqs,acks,ofile);
		}
	}
}

void AaSimpleObjectReference::Write_VC_Control_Path_Optimized(bool pipeline_flag,
		set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;
			// if this is a statement...
			if(this->_object->Is_Interface_Object())
			{
				__DeclTrans
				ofile << "// reference to interface object" << endl;

				if(barrier != NULL)
				{
					ofile << "// barrier " << endl;
					__J(__ST(this), __CT(barrier));
				}


				this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();

				// forward dependency from root statement to this expression
				if((root != NULL) && (visited_elements.find(root) != visited_elements.end()))
				{
					__J(__ST(this), __CT(root));

					// pipeline case?
					if(pipeline_flag)
					{
						// completion of this should enable re-update of root.
						__MJ(root->Get_VC_Reenable_Update_Transition_Name(visited_elements), 
								__CT(this));

						// No self-releasing needed...
					}
				}	  

				// complete the connections.
				__J(__CT(this),__AT(this));
				__J(__AT(this),__ST(this));

			}
			else if(this->Is_Implicit_Variable_Reference())
			{
				ofile << "// implicit reference" << endl;
				__DeclTrans

				this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

				AaRoot* root = this->Get_Root_Object();
				if(visited_elements.find(root) != visited_elements.end())
				{
					__J(__ST(this), __CT(root));

					// pipeline case?
					if(pipeline_flag)
					{
						// since there is no sampling happening in this case, 
						// there is no need for a reenable.
						//__MJ(root->Get_VC_Reenable_Update_Transition_Name(visited_elements), 
						//this->Get_VC_Completed_Transition_Name());

						// No self-release is necessary..
					}	      
				}
				else
				{
					if(barrier != NULL)
					{
						ofile << "// barrier " << endl;
						__J(__ST(this), __CT(barrier));
					}
				}

				// complete the connections.
				__J(__CT(this),__AT(this));
				__J(__AT(this),__ST(this));
			}
			else if(this->_object->Is("AaStorageObject"))
				// complete region name is in Write_VC_Load_Control...
			{
				__DeclTrans

				if(barrier != NULL)
				{
					ofile << "// barrier " << endl;
					__J(__ST(this),__CT(barrier));
				}

				// this takes care of the guard..
				this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

				// load-control path evaluates the address and the
				// load.
				this->Write_VC_Load_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,NULL,NULL,NULL,barrier,ofile);

				ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);

				if(pipeline_flag)
				{
					// in this case, self-release is needed.
					__MJ(__ST(this),__AT(this));
					__MJ(__AT(this),__CT(this));
				}
			}
		// else if the object being referred to is
		// a pipe, instantiate a split protocol path
		// for the inport operation
			else if(this->_object->Is("AaPipeObject"))
				// needed to hook up pipe dependencies.
			{
				__DeclTransSplitProtocolPattern
				if(barrier != NULL)
				{
					ofile << "// barrier " << endl;
					__J(__ST(this), __CT(barrier));
				}

				// the guard dependency..
				this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

				string sample_regn = this->Get_VC_Name() + "_Sample";
				string update_regn = this->Get_VC_Name() + "_Update";
				ofile << ";;[" << sample_regn << "] { // pipe read sample" << endl;
				ofile << "$T [rr] $T [ra] " << endl;
				ofile << "}" << endl;

				ofile << ";;[" << update_regn << "] { // pipe read update" << endl;
				ofile << "$T [cr] $T [ca] " << endl;
				ofile << "}" << endl;

				_ConnectSplitProtocolPattern

				// record the pipe!  Introduce pipe related dependencies 
				// later. TODO
				pipe_map[this->_object->Get_VC_Name()].push_back(this);

				if(pipeline_flag)
				{
					// SelfRelease
					__SelfReleaseSplitProtocolPattern
				}
			}

		// at the end!
		visited_elements.insert(this);
	}
}

void AaSimpleObjectReference::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{

	if( this->Is_Implicit_Variable_Reference())
	{
		ofile << "// " << this->To_String() << endl << "// implicit reference" << endl;
	}
	else if(this->_object->Is("AaStorageObject"))
	{
		__DeclTrans

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__ST(this), __CT(barrier));
			}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		// address calculation..
		// several parallel stores will be peformed..
		// must compute all of them..

		// followed by several parallel stores..
		// note that you will need a split operation here
		ofile << "// " << this->To_String() << endl;
		this->Write_VC_Store_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,NULL,NULL,NULL,barrier,ofile);
		ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);

		// Note: pipeline release dependencies of this store
		// will be taken care of at the statement level..
		// self-release is needed!
		if(pipeline_flag)
		{
			// SelfRelease
			__MJ(__ST(this),__AT(this));
			__MJ(__AT(this),__CT(this));
		}
	}
	// else if the object being referred to is
	// a pipe, instantiate a series r-a
	// chain for the inport operation
	else if(this->_object->Is("AaPipeObject"))
	{
		ofile << "// " << this->To_String() << endl;
		__DeclTrans
			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__ST(this), __CT(barrier));
			}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // pipe write ";
		this->Print(ofile);
		ofile << endl;
		ofile << "$T [pipe_wreq] $T [pipe_wack] " << endl;
		ofile << "}" << endl;

		// connections.
		__F(__ST(this), this->Get_VC_Complete_Region_Name());
		__J(__AT(this), this->Get_VC_Complete_Region_Name());
		__J(__CT(this),__AT(this));

		// Note: pipeline release dependencies of this store
		// will be taken care of at the statement level..
		//
		// TODO: pipe sequence dependencies must be handled
		//       separately.
		if(pipeline_flag)
		{
			// SelfRelease
			__MJ(__ST(this),__AT(this));
		}


		pipe_map[this->_object->Get_VC_Name()].push_back(this);
	}

}

// AaArrayObjectReference
string AaArrayObjectReference::Get_VC_Base_Address_Update_Reenable_Transition(set<AaRoot*>& visited_elements)
{
	
	string base_addr_calc_reenable =  "$null";
	if(!this->Is_Constant())
	{
		if(this->Get_Object_Type()->Is_Pointer_Type())
			// array expression is a pointer-evaluation expression.
		{
			if(!this->_pointer_ref->Is_Constant())
			{
			    base_addr_calc_reenable = 
				this->_pointer_ref->Get_VC_Reenable_Update_Transition_Name(visited_elements);

			}
			else if(this->_object->Is_Expression())
			{
				AaRoot* root = (((AaExpression*)this->_object)->Get_Root_Object());
				if(root && root->Is_Statement())
				{
					if(visited_elements.find(root) != visited_elements.end())
					{
					    base_addr_calc_reenable = 
							((AaStatement*)root)->Get_VC_Reenable_Update_Transition_Name(visited_elements);
					}
				}
			}
			else if(this->_object->Is_Interface_Object())
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				if(visited_elements.find(root) != visited_elements.end())
				{
					base_addr_calc_reenable = ((AaStatement*)root)->Get_VC_Reenable_Update_Transition_Name(visited_elements);
				}	  
			}
			else if(this->_object->Is_Statement())
			{
				AaRoot* root = this->_object;
				if(visited_elements.find(root) != visited_elements.end())
				{
					base_addr_calc_reenable = ((AaStatement*)root)->Get_VC_Reenable_Update_Transition_Name(visited_elements);
				}	  
			}
		}
	}
	return(base_addr_calc_reenable);
}

void AaArrayObjectReference::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(this->Is_Constant())
		return;

	ofile << "// " << this->To_String() << endl;


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
			this->_pointer_ref->Write_VC_Links_Optimized(hier_id,ofile);
		}

		// the return value is a pointer,
		// calculate the address.
		this->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,
				this->Get_Index_Vector(),
				&scale_factors, 
				&shift_factors,
				ofile);

		hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());
		vector<string> reqs;
		vector<string> acks;
		reqs.push_back(hier_id + "/final_reg_req");
		acks.push_back(hier_id + "/final_reg_ack");
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

		this->AaObjectReference::Write_VC_Load_Links_Optimized(hier_id,
				this->Get_Index_Vector(),
				&scale_factors, &shift_factors,
				ofile);
	}
	else
	{
		vector<string> reqs;
		vector<string> acks;

		if(this->_object->Is_Expression())
		{
			AaExpression* expr =(AaExpression*) (this->_object);
			expr->Write_VC_Links(hier_id,ofile);
			hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());
			reqs.push_back(hier_id + "/slice_req");
			acks.push_back(hier_id + "/slice_ack");
			Write_VC_Link(this->Get_VC_Name() + "_slice",
					reqs,
					acks,
					ofile);
		}
		else if(this->_object->Is("AaInterfaceObject"))
		{
			hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());
			reqs.push_back(hier_id + "/slice_req");
			acks.push_back(hier_id + "/slice_ack");
			Write_VC_Link(this->Get_VC_Name() + "_slice",
					reqs,
					acks,
					ofile);

		}
		else if(this->_object->Is("AaPipeObject"))
		{
			hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());

			reqs.push_back(hier_id + "/pipe_read_req");
			acks.push_back(hier_id + "/pipe_read_ack");
			Write_VC_Link(this->Get_VC_Name() + "_pipe_access",
					reqs,
					acks,
					ofile);

			reqs.clear();
			acks.clear();
			reqs.push_back(hier_id + "/slice_req");
			acks.push_back(hier_id + "/slice_ack");
			Write_VC_Link(this->Get_VC_Name() + "_slice",
					reqs,
					acks,
					ofile);

		}
	}
}

void AaArrayObjectReference::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	if(this->Is_Constant())
		return;

	int word_size = this->Get_Word_Size();
	vector<int> scale_factors;
	this->Update_Address_Scaling_Factors(scale_factors,word_size);

	vector<int> shift_factors;
	this->Update_Address_Shift_Factors(shift_factors,word_size);

	this->AaObjectReference::Write_VC_Store_Links_Optimized(hier_id,
			&_indices,
			&scale_factors, &shift_factors,
			ofile);

}

// TODO: there are some holes here.
void AaArrayObjectReference::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;


		bool be_flag = false;
		string base_addr_calc_reenable = "$UNDEFINED";

		__DeclTrans
			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(this->Get_VC_Start_Transition_Name(), barrier->Get_VC_Completed_Transition_Name());
			}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		if(this->Get_Object_Type()->Is_Pointer_Type())
			// array expression is a pointer-evaluation expression.
		{

			int word_size = this->Get_Word_Size();
			vector<int> scale_factors;
			this->Update_Address_Scaling_Factors(scale_factors,word_size);

			vector<int> shift_factors;
			this->Update_Address_Shift_Factors(shift_factors,word_size);

			string base_addr_calc = this->Get_VC_Name() + "_base_address_calculated";
			__T(base_addr_calc);

			if(this->_object->Is_Storage_Object())
			{
				// please load the object.
				this->_pointer_ref->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);
				if(!this->_pointer_ref->Is_Constant())
				{
					__J(base_addr_calc, this->_pointer_ref->Get_VC_Completed_Transition_Name());
					if(pipeline_flag)
					{
						base_addr_calc_reenable = this->_pointer_ref->Get_VC_Reenable_Update_Transition_Name(visited_elements);
						be_flag = true;
					}
				}

			}
			else if(this->_object->Is_Expression())
			{
				AaRoot* root = (((AaExpression*)this->_object)->Get_Root_Object());
				if(root && root->Is_Statement())
				{
					if(visited_elements.find(root) != visited_elements.end())
					{
						__J(base_addr_calc, __CT(((AaStatement*)root)));
						if(pipeline_flag)
						{
							be_flag = true;
							base_addr_calc_reenable = ((AaStatement*)root)->Get_VC_Reenable_Update_Transition_Name(visited_elements);
						}
					}
				}
			}
			else if(this->_object->Is_Interface_Object())
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				if(visited_elements.find(root) != visited_elements.end())
				{
					__J(base_addr_calc, __CT(((AaStatement*)root)));
					if(pipeline_flag)
					{
						base_addr_calc_reenable = ((AaStatement*)root)->Get_VC_Reenable_Update_Transition_Name(visited_elements);
						be_flag = true;
					}
				}	  
			}
			else if(this->_object->Is_Statement())
			{
				AaRoot* root = this->_object;
				if(visited_elements.find(root) != visited_elements.end())
				{
					__J(base_addr_calc, __CT(((AaStatement*)root)));
					if(pipeline_flag)
					{
						base_addr_calc_reenable = ((AaStatement*)root)->Get_VC_Reenable_Update_Transition_Name(visited_elements);
						be_flag = true;
					}
				}	  
			}
			else
			{
				assert(0);
			}


			// this will link to complete region.
			set<string> active_reenable_points;
			this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
					ls_map,
					pipe_map,
					&_indices,
					&scale_factors, &shift_factors,
					active_reenable_points,
					barrier,
					ofile);




			// TODO: this should be an interlock instead of a register.
			ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
			ofile << "$T [final_reg_req] $T [final_reg_ack]" << endl;
			ofile << "}" << endl;

			// remember, firing of active transition means that
			// all input variables to this expression have been 
			// sampled.
			__J(__AT(this),__ST(this)); // to complete the connections.
			__J(__AT(this),this->Get_VC_Name()+ "_root_address_calculated");
			__F(__AT(this),this->Get_VC_Complete_Region_Name());
			__J(__CT(this), this->Get_VC_Complete_Region_Name());

			if(pipeline_flag)
			{
				// completion of this will reenable the calculation of the base address.
				if(be_flag)
					__MJ(base_addr_calc_reenable, __CT(this));

				string ctrans = __CT(this);
				Write_VC_Reenable_Joins(active_reenable_points,ctrans,ofile);
				active_reenable_points.clear();
				active_reenable_points.insert(this->Get_VC_Active_Transition_Name());

				// SelfRelease
				__MJ(__AT(this),__CT(this));
			}

		}
		else if(this->_object->Is_Storage_Object())
			// array expression is a storage object indexed access expression..
		{ 

			int word_size = this->Get_Word_Size();
			vector<int> scale_factors;
			this->Update_Address_Scaling_Factors(scale_factors,word_size);

			vector<int> shift_factors;
			this->Update_Address_Shift_Factors(shift_factors,word_size);

			// this is just a regular object load
			// using the indices, which returns the
			// value stored at the computed address.
			this->Write_VC_Load_Control_Path_Optimized(pipeline_flag, visited_elements,
					ls_map,pipe_map,
					&(_indices),
					&scale_factors, &shift_factors,
					barrier,
					ofile);

			ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);

			if(pipeline_flag)
			{
				__MJ(__ST(this),__AT(this));
				__MJ(__AT(this),__CT(this));
			}
		}
		else
			// neither storage object nor pointer.. must be
			// a structure access expression..
		{
			if(this->_object->Is_Expression())
			{
				AaExpression* expr = ((AaExpression*) (this->_object));
				expr->Write_VC_Control_Path_Optimized(pipeline_flag, 
						visited_elements,
						ls_map,
						pipe_map,
						barrier,
						ofile);

				// expression has been evaluated.. go to active
				__J(__AT(this), expr->Get_VC_Completed_Transition_Name());

				// TODO: use split protocol to implement Slice.
				//       (note that Slice doubles as a register..)
				ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
				ofile << "$T [slice_req] $T [slice_ack]" << endl;
				ofile << "}" << endl;

				__J(__AT(this),__ST(this));
				__F(__AT(this),this->Get_VC_Complete_Region_Name());
				__J(__CT(this), this->Get_VC_Complete_Region_Name());

				if(pipeline_flag)
				{
					// reenable expression when this completes.
					__MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements), __CT(this));
					__MJ(__AT(this),__CT(this));
				}
			}
			else if(this->_object->Is("AaInterfaceObject"))
			{
				AaRoot::Error("indexed array expression not supported on interface object." ,this->_object);
				// not supported.
				assert(0);
			}
			else if(this->_object->Is("AaPipeObject"))
			{
				AaRoot::Error("indexed array expression not supported on pipe object." , this->_object);
				// not supported.
				assert(0);
			}
			else
				assert(0);
		}

		visited_elements.insert(this);
	}
}

void AaArrayObjectReference::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{

	if(this->_object->Is("AaStorageObject"))
	{
		ofile << "// " << this->To_String() << endl;
		__DeclTrans
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__ST(this), __CT(barrier));
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		int word_size = ((AaStorageObject*)(this->_object))->Get_Word_Size();
		vector<int> scale_factors;
		this->Update_Address_Scaling_Factors(scale_factors,word_size);

		vector<int> shift_factors;
		this->Update_Address_Shift_Factors(shift_factors,word_size);

		this->Write_VC_Store_Control_Path_Optimized(pipeline_flag, 
				visited_elements,
				ls_map,pipe_map,
				&(_indices),
				&(scale_factors), 
				&shift_factors,
				barrier,
				ofile);
		ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);

		// do nothing.. the target dependencies will be
		// taken care of by the associated statement.
		if(pipeline_flag)
		{
			__MJ(__ST(this),__AT(this));
			__MJ(__AT(this),__CT(this));
		}
	}
	else
	{
		// a target can only be an indexed storage object.
		assert(0);
	}
}


// AaPointerDereferenceExpression
void AaPointerDereferenceExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if((this->Get_Addressed_Object_Representative() == NULL)
			|| this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
	{
		ofile << "// foreign memory space access omitted!" << endl;
		return;
	}

	this->_reference_to_object->Write_VC_Links_Optimized(hier_id,ofile);
	this->AaObjectReference::Write_VC_Load_Links_Optimized(hier_id,
			NULL,
			NULL,
			NULL,
			ofile);
}

void AaPointerDereferenceExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	if((this->Get_Addressed_Object_Representative() == NULL)
			|| this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
	{
		ofile << "// foreign memory space access omitted!" << endl;
		return;
	}


	this->_reference_to_object->Write_VC_Links_Optimized(hier_id,ofile);
	this->AaObjectReference::Write_VC_Store_Links_Optimized(hier_id,
			NULL,
			NULL,
			NULL,
			ofile);
}

string AaPointerDereferenceExpression::Get_VC_Base_Address_Update_Reenable_Transition(set<AaRoot*>& visited_elements)
{
	assert(this->_reference_to_object != NULL);
	string ret_string = this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements);
	return(ret_string);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	if((this->Get_Addressed_Object_Representative() == NULL)
			|| this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
	{
		AaRoot::Error("pointer dereference to foreign object!", this);
		ofile << "// foreign memory space access omitted!" << endl;
		return;
	}

	__DeclTrans
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(this->Get_VC_Start_Transition_Name(), barrier->Get_VC_Completed_Transition_Name());
		}

	this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
	string base_addr_calc = (this->Get_VC_Name() + "_base_address_calculated");
	__T(base_addr_calc);

	this->_reference_to_object->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,
			pipe_map,
			barrier,
			ofile);


	this->Write_VC_Load_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,pipe_map, 
			NULL,NULL,NULL,barrier,ofile);

	if(!this->_reference_to_object->Is_Constant())
	{
		__J(base_addr_calc,__CT(this->_reference_to_object));
		__J(__ST(this),base_addr_calc);

		if(pipeline_flag)
		{

			// This dependency is taken care of in the address-calculation chain.
			// __MJ(this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements),
					//__AT(this));

			// SelfRelease
			__MJ(__ST(this),__AT(this));
			__MJ(__AT(this),__CT(this));
		}
	}

	ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	if((this->Get_Addressed_Object_Representative() == NULL)
			|| this->Get_Addressed_Object_Representative()->Is_Foreign_Storage_Object())
	{
		AaRoot::Error("pointer dereference to foreign object!", this);
		ofile << "// foreign memory space access omitted!" << endl;
		return;
	}


	__DeclTrans
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__ST(this), __CT(barrier));
		}

	string base_addr_calc = (this->Get_VC_Name() + "_base_address_calculated");
	__T(base_addr_calc);

	this->_reference_to_object->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,
			pipe_map,
			barrier,
			ofile);
	this->Write_VC_Store_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,pipe_map,
			NULL,NULL,NULL,barrier,ofile);

	if(!this->_reference_to_object->Is_Constant())
	{
		__J(base_addr_calc,this->_reference_to_object->Get_VC_Completed_Transition_Name());
		__J(__ST(this),base_addr_calc);

		if(pipeline_flag)
		{
			// when this expression is active, we may reevaluate
			// the base address.
			__MJ(this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements),
					__AT(this));
			// SelfRelease
			__MJ(__ST(this),__AT(this));
			__MJ(__AT(this),__CT(this));
		}
	}

	ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
}



// AaAddressOfExpression
void AaAddressOfExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
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


		obj_ref->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,
				obj_ref->Get_Index_Vector(),
				&scale_factors, &shift_factors,
				ofile);

		hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());		       
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
void AaAddressOfExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

void AaAddressOfExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;

	if(!this->Is_Constant())
	{
		__DeclTrans
			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__ST(this),__CT(barrier));
			}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);


		assert(this->_reference_to_object->Is("AaArrayObjectReference"));

		AaArrayObjectReference* obj_ref = 
			(AaArrayObjectReference*)(this->_reference_to_object);

		int word_size = this->Get_Word_Size();
		vector<int> scale_factors;
		obj_ref->Update_Address_Scaling_Factors(scale_factors,word_size);

		vector<int> shift_factors;
		obj_ref->Update_Address_Shift_Factors(shift_factors,word_size);

		// root address calculation will include all dependencies with 
		// this etc..
		set<string> active_reenable_points;
		obj_ref->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				obj_ref->Get_Index_Vector(),
				&scale_factors, &shift_factors,
				active_reenable_points,
				barrier,
				ofile);

		ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;

		ofile << "$T [final_reg_req] $T [final_reg_ack]" << endl;
		ofile << "}" << endl;

		// links to root address calculation..
		__J(__AT(this),__ST(this));
		__J(__AT(this), obj_ref->Get_VC_Name() + "_root_address_calculated");
		__F(__AT(this),this->Get_VC_Complete_Region_Name());
		__J(__CT(this), this->Get_VC_Complete_Region_Name());

		if(pipeline_flag)
		{
			string ctrans = this->Get_VC_Completed_Transition_Name();
			Write_VC_Reenable_Joins(active_reenable_points, ctrans,ofile);
			active_reenable_points.clear();

			// just take care of the complete to active reenabling.. root address
			// calculation deps will be taken care of in Write_VC_Root_Address...
			// SelfRelease
			__MJ(__AT(this),__CT(this));
		}
	}
	else
	{
		__DeclTrans
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__ST(this), __CT(barrier));
		}
		
		// to keep the chain alive.
		__J(__AT(this),__ST(this));
		__J(__CT(this),__AT(this));

		// standard marked joins.. these are not really needed.
		if(pipeline_flag)
		{
			// SelfRelease.
		}
	}
}

void AaAddressOfExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}




// AaTypeCastExpression
void AaTypeCastExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Links_Optimized(hier_id, ofile);

		ofile << "// " << this->To_String() << endl;


		vector<string> reqs,acks;
		if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
		{
			hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());
			reqs.push_back(hier_id + "/req");
			acks.push_back(hier_id + "/ack");
			Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
		}
		else
		{
			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";

			reqs.push_back(hier_id + "/" + sample_regn + "/rr");
			reqs.push_back(hier_id + "/" + update_regn + "/cr");
			acks.push_back(hier_id + "/" + sample_regn + "/ra");
			acks.push_back(hier_id + "/" + update_regn + "/ca");

			Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
		}
	}

}

void AaTypeCastExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

string AaTypeCastExpression::Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
    bool split_protocol = true;
    if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
	split_protocol = false;
    if(!split_protocol)
	return(__AT(this));
    else
	return(__UST(this));

}
string AaTypeCastExpression::Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
{
    bool split_protocol = true;
    if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
	split_protocol = false;

    if(!split_protocol)
	return(__ST(this));
    else
	return(__SST(this));
}

void AaTypeCastExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{

		bool split_protocol = true;
		if(_bit_cast || Is_Trivial_VC_Type_Conversion(_rest->Get_Type(), this->Get_Type()))
			split_protocol = false;

		ofile << "// " << this->To_String() << endl;

		if(split_protocol)
		{
			__DeclTransSplitProtocolPattern
		}
		else
		{
			__DeclTrans
		}

		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(this->Get_VC_Start_Transition_Name(), barrier->Get_VC_Completed_Transition_Name());
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		this->_rest->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,barrier,
				ofile);

		__J(__ST(this),__CT(this->_rest));

		// either it will be a register or a split conversion
		// operator..
		if(!split_protocol)
		{
			ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "]{ " << endl;
			ofile << "$T [req] $T [ack] //  type-conversion (bit-cast) " << endl;
			ofile << "}" << endl;
			
			__F(__ST(this),this->Get_VC_Complete_Region_Name());
			__J(__AT(this),this->Get_VC_Complete_Region_Name());
			__J(__CT(this),__AT(this));
			if(pipeline_flag)
			{
				__MJ(this->_rest->Get_VC_Reenable_Update_Transition_Name(visited_elements), this->Get_VC_Active_Transition_Name());

				// SelfRelease not necessary, because
				// rest cannot be retriggered until this completes.
			}
		}
		else
		{
			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";

			ofile << ";;[" << sample_regn << "] { // unary expression " << endl;      
			ofile << "$T [rr] $T [ra] // (split) unary operation" << endl;
			ofile << "}" << endl;

			ofile << ";;[" << update_regn << "] { // unary expression " << endl;      
			ofile << "$T [cr] $T [ca] //(split) unary operation" << endl;
			ofile << "}" << endl;

			_ConnectSplitProtocolPattern

			if(pipeline_flag)
			{
				__MJ(this->_rest->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this));

				// This is not strictly necessary, because
				// the sources to the expression cannot be
				// retriggered until this has completed.
				// __SelfReleaseSplitProtocolPattern
			}
		}

	}
}

void AaTypeCastExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}



// AaUnaryExpression
void AaUnaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_rest->Write_VC_Links_Optimized(hier_id, ofile);

		ofile << "// " << this->To_String() << endl;

		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		string sample_hier_id = Augment_Hier_Id(hier_id,sample_regn);
		string update_hier_id = Augment_Hier_Id(hier_id,update_regn);

		vector<string> reqs,acks;

		reqs.push_back(sample_hier_id + "/rr");
		reqs.push_back(update_hier_id + "/cr");
		acks.push_back(sample_hier_id + "/ra");
		acks.push_back(update_hier_id + "/ca");

		Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}
}
void AaUnaryExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

void AaUnaryExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{


	if(!this->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;
		__DeclTransSplitProtocolPattern

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(this->Get_VC_Start_Transition_Name(), barrier->Get_VC_Completed_Transition_Name());
			}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		this->_rest->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				barrier,
				ofile);


		if(!this->_rest->Is_Constant())
			__J(this->Get_VC_Start_Transition_Name(),this->_rest->Get_VC_Completed_Transition_Name());

		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		ofile << ";;[" << sample_regn << "] { // unary expression " << endl;      
		ofile << "$T [rr] $T [ra] // (split) unary operation" << endl;
		ofile << "}" << endl;

		ofile << ";;[" << update_regn << "] { // unary expression " << endl;      
		ofile << "$T [cr] $T [ca] //(split) unary operation" << endl;
		ofile << "}" << endl;

		_ConnectSplitProtocolPattern

		if(pipeline_flag)
		{
			__MJ(this->_rest->Get_VC_Reenable_Update_Transition_Name(visited_elements), 
					__SCT(this));
			__SelfReleaseSplitProtocolPattern
		}
	}
}
void AaUnaryExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}




// AaBinaryExpression
void AaBinaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_first->Write_VC_Links_Optimized(hier_id, ofile);
		this->_second->Write_VC_Links_Optimized(hier_id, ofile);

		ofile << "// " << this->To_String() << endl;


		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		string sample_hier_id = Augment_Hier_Id(hier_id,sample_regn);
		string update_hier_id = Augment_Hier_Id(hier_id,update_regn);

		vector<string> reqs,acks;

		reqs.push_back(sample_hier_id + "/rr");
		reqs.push_back(update_hier_id + "/cr");
		acks.push_back(sample_hier_id + "/ra");
		acks.push_back(update_hier_id + "/ca");

		Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}
}
void AaBinaryExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

void AaBinaryExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{

		ofile << "// " << this->To_String() << endl;

		__DeclTransSplitProtocolPattern

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(this->Get_VC_Start_Transition_Name(), barrier->Get_VC_Completed_Transition_Name());
			}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		this->_first->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);
		this->_second->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);


		if(!this->_first->Is_Constant())
			__J(__ST(this),this->_first->Get_VC_Completed_Transition_Name());

		if(!this->_second->Is_Constant())
			__J(__ST(this),this->_second->Get_VC_Completed_Transition_Name());

		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		ofile << ";;[" << sample_regn <<"] { // binary expression " << endl;
		ofile << "$T [rr] $T [ra]  // (split) binary operation " << endl;
		ofile << "}" << endl;

		ofile << ";;[" << update_regn << "] { // binary expression " << endl;
		ofile << "$T [cr] $T [ca] // (split) binary operation " << endl;
		ofile << "}" << endl;

		_ConnectSplitProtocolPattern

			if(pipeline_flag)
			{
				if(!this->_first->Is_Constant())
					__MJ(this->_first->Get_VC_Reenable_Update_Transition_Name(visited_elements),
							this->Get_VC_Sample_Completed_Transition_Name());

				if(!this->_second->Is_Constant())
					__MJ(this->_second->Get_VC_Reenable_Update_Transition_Name(visited_elements),
							this->Get_VC_Sample_Completed_Transition_Name());

				__SelfReleaseSplitProtocolPattern
			}
	}
}

void AaBinaryExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}


// AaTernaryExpression
void AaTernaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_test->Write_VC_Links_Optimized(hier_id,ofile);
		this->_if_true->Write_VC_Links_Optimized(hier_id,ofile);
		this->_if_false->Write_VC_Links_Optimized(hier_id,ofile);

		ofile << "// " << this->To_String() << endl;

		hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());
		vector<string> reqs,acks;
		reqs.push_back(hier_id + "/req");
		acks.push_back(hier_id + "/ack");

		Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),
				reqs,
				acks,
				ofile);
	}

}

void AaTernaryExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

void AaTernaryExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(this->Is_Constant())
		return;

	ofile << "// " << this->To_String() << endl;
	__DeclTrans
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__ST(this),__CT(barrier));
		}

	this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

	this->_test->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);
	if(this->_if_true)
		this->_if_true->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);
	if(this->_if_false)
		this->_if_false->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);


	if(!this->_test->Is_Constant())
		__J(__ST(this),__CT(this->_test));
	if(this->_if_true && !this->_if_true->Is_Constant())
		__J(__ST(this),__CT(this->_if_true));
	if(this->_if_false && !this->_if_false->Is_Constant())
		__J(__ST(this),__CT(this->_if_false));

	ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // ternary expression: " << endl;
	ofile << "$T [req] $T [ack] // select req/ack" << endl;
	ofile << "}" << endl;
	__F(__ST(this),this->Get_VC_Complete_Region_Name());
	__J(__AT(this),this->Get_VC_Complete_Region_Name());
	__J(__CT(this),__AT(this));

	if(pipeline_flag)
	{
		if(!this->_test->Is_Constant())
			__MJ(this->_test->Get_VC_Reenable_Update_Transition_Name(visited_elements), this->Get_VC_Active_Transition_Name());
		if(this->_if_true && !this->_if_true->Is_Constant())
			__MJ(this->_if_true->Get_VC_Reenable_Update_Transition_Name(visited_elements), this->Get_VC_Active_Transition_Name());
		if(this->_if_false && !this->_if_false->Is_Constant())
			__MJ(this->_if_false->Get_VC_Reenable_Update_Transition_Name(visited_elements), this->Get_VC_Active_Transition_Name());
		
		// SelfRelease .. not necessary.
		// because a source expression cannot be retriggered until
		// this expression has completed.
	}
}

void AaTernaryExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}



/// load-store related stuff.
void AaObjectReference::Write_VC_Load_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string, vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		AaRoot* barrier,
		ostream& ofile)
{
	// address calculation
	// 1. compute agross = base + (offset*scale-factor)
	// 2. in parallel, compute aI = agross + I
	//       optimization: if number is 2**N then append.
	this->Write_VC_Address_Calculation_Control_Path_Optimized(pipeline_flag, 
			visited_elements,
			ls_map,
			pipe_map,
			address_expressions,
			scale_factors,
			shift_factors, 
			barrier,
			ofile);

	// load operations
	//    in parallel, load..
	this->Write_VC_Load_Store_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,pipe_map,
			address_expressions, 
			scale_factors,
			shift_factors,
			"read",
			barrier,
			ofile);

	// there is a long chain of transitions until word_address_calculated.
	__J(__ST(this),this->Get_VC_Name() + "_word_address_calculated");

}

void AaObjectReference::Write_VC_Store_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string, vector<AaExpression*> >& ls_map, 
		map<string, vector<AaExpression*> >& pipe_map,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		AaRoot* barrier,
		ostream& ofile)
{
	// address calculation
	// 1. compute agross = base + (offset*scale-factor)
	// 2. in parallel, compute aI = agross + I
	//       optimization: if number is 2**N then append.
	this->Write_VC_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,pipe_map,
			address_expressions, 
			scale_factors,
			shift_factors, 
			barrier,
			ofile);

	//    in parallel, store
	this->Write_VC_Load_Store_Control_Path_Optimized(pipeline_flag, visited_elements,
			ls_map,pipe_map,
			address_expressions, 
			scale_factors,
			shift_factors,
			"write", 
			barrier,
			ofile);

	__J(__ST(this),this->Get_VC_Name() + "_word_address_calculated");
}

// TODO: this needs to be refined and fixed, especially
//       the reenable to the address calculation chain.
void AaObjectReference::Write_VC_Load_Store_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string, vector<AaExpression*> >& ls_map, 
		map<string, vector<AaExpression*> >& pipe_map,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		string read_or_write,
		AaRoot* barrier,
		ostream& ofile)
{

	string start_trans = this->Get_VC_Start_Transition_Name();
	string active_trans = this->Get_VC_Active_Transition_Name();
	string complete_trans = this->Get_VC_Completed_Transition_Name();

	ofile << ";;[" << this->Get_VC_Request_Region_Name() << "] {" << endl;
	if(read_or_write == "write")
	{
		// split the data into words..
		ofile << "$T [split_req] $T [split_ack]" << endl;
	}

	// in parallel access the words.
	// how many words?
	int nwords = (address_expressions ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));

	ofile << "||[word_access] {" << endl;
	for(int idx = 0; idx < nwords; idx++)
	{
		// each word access.
		ofile << ";;[word_access_" << idx << "] {" << endl
			<< "$T [rr] $T [ra] " << endl
			<< "}" << endl;
	}
	ofile << "}" << endl;
	ofile << "}" << endl;

	ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
	ofile << "||[word_access] {" << endl;
	for(int idx = 0; idx < nwords; idx++)
	{
		// each word access.
		ofile << ";;[word_access_" << idx << "] {" << endl
			<< "$T [cr] $T [ca] " << endl
			<< "}" << endl;
	}
	ofile << "}" << endl;
	if(read_or_write == "read")
	{
		// merge the words into the data..
		ofile << "$T [merge_req] $T [merge_ack]" << endl;
	}
	ofile << "}" << endl;

	__F(start_trans,this->Get_VC_Request_Region_Name());
	__J(active_trans,this->Get_VC_Request_Region_Name());
	__F(active_trans,this->Get_VC_Complete_Region_Name());
	__J(complete_trans,this->Get_VC_Complete_Region_Name());

	if(pipeline_flag)
	{
		// as soon as this is active, reenable the last stage of
		// word-address calculation.  This is more complicated than
		// it appears, because of the extensive use of zero-delay
		// stages in the address calculation logic. One must 
		// revisit this.
		string root_addr_calculated = this->Get_VC_Name() + "_root_address_calculated"; 
		__MJ(root_addr_calculated,active_trans);
	}
}



void AaObjectReference::Write_VC_Load_Links_Optimized(string hier_id,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		ostream& ofile)
{
	this->Write_VC_Address_Calculation_Links_Optimized(hier_id, address_expressions, scale_factors, shift_factors, ofile);
	string rd_id = "read";
	this->Write_VC_Load_Store_Links_Optimized(hier_id, rd_id, address_expressions, scale_factors, shift_factors, ofile);
}

void AaObjectReference::Write_VC_Store_Links_Optimized(string hier_id,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		ostream& ofile)
{
	this->Write_VC_Address_Calculation_Links_Optimized(hier_id, address_expressions, scale_factors, shift_factors, ofile);
	string rd_id = "write";
	this->Write_VC_Load_Store_Links_Optimized(hier_id, rd_id, address_expressions, scale_factors, shift_factors, ofile);
}


void AaObjectReference::Write_VC_Load_Store_Links_Optimized( string hier_id,
		string read_or_write,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		ostream& ofile)
{
	vector<string> reqs;
	vector<string> acks;

	string start_hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Request_Region_Name());
	string complete_hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Complete_Region_Name());

	// if read, then merge
	string ms_instance = this->Get_VC_Name() + "_gather_scatter";
	if(read_or_write == "read")
	{
		reqs.push_back(complete_hier_id + "/merge_req");
		acks.push_back(complete_hier_id + "/merge_ack");

	}
	else
	{
		reqs.push_back(start_hier_id + "/split_req");
		acks.push_back(start_hier_id + "/split_ack");
	}
	Write_VC_Link(ms_instance,reqs,acks, ofile);
	reqs.clear();
	acks.clear();

	// in parallel access the words.
	string start_word_access_hier_id = Augment_Hier_Id(start_hier_id, "word_access");
	string complete_word_access_hier_id = Augment_Hier_Id(complete_hier_id, "word_access");

	for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
	{
		// each word access.
		string start_id = Augment_Hier_Id(start_word_access_hier_id , "word_access_" + IntToStr(idx));
		reqs.push_back(start_id + "/rr");
		acks.push_back(start_id + "/ra");

		string complete_id = Augment_Hier_Id(complete_word_access_hier_id , "word_access_" + IntToStr(idx));
		reqs.push_back(complete_id + "/cr");
		acks.push_back(complete_id + "/ca");

		string inst_name = this->Get_VC_Name() 
			+ ((read_or_write == "read") ? "_load_" : "_store_") 
			+ IntToStr(idx);

		Write_VC_Link(inst_name,
				reqs,
				acks,
				ofile);
		reqs.clear();
		acks.clear();
	}
}




void AaObjectReference::
Write_VC_Address_Calculation_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		vector<AaExpression*>* indices,
		vector<int>* scale_factors,		
		vector<int>* shift_factors,
		AaRoot* barrier,
		ostream& ofile)
{
	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();

	string root_addr_calculated = this->Get_VC_Name() + "_root_address_calculated";
	string word_addr_calculated = this->Get_VC_Name() + "_word_address_calculated"; 
	__T(word_addr_calculated);

	if(offset_val < 0 || base_addr < 0)
	{

		string word_region = this->Get_VC_Name() + "_word_addrgen"; 

		// calculates root address.. triggers a root-address-calculated transition
		// when it is done..
		set<string> active_reenable_points;
		this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				indices,
				scale_factors,
				shift_factors,
				active_reenable_points,
				barrier,
				ofile);


		// individual word addresses (in parallel)
		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
		bool reg_flag = false;
		if(nwords > 1)
		{
			reg_flag = true;
			ofile << "||[" << word_region << "] {" << endl;

			for(int idx = 0; idx < nwords; idx++)
			{
				// each word address is a sum
				ofile << ";;[word_" << idx << "_sample] {" << endl
					<< "$T [rr] $T [ra]" << endl
					<< "}" << endl;
				ofile << ";;[word_" << idx << "_update] {" << endl
					<< "$T [cr] $T [ca]" << endl
					<< "}" << endl;
			}
			ofile << "}" << endl;
		}
		else
		{
			// single word, no operation.. just rename it!
			ofile << ";;[" << word_region << "] {" << endl;
			ofile << "$T [root_register_req] $T [root_register_ack]" << endl;
			ofile << "}" << endl;
		}


		__F(root_addr_calculated, word_region);
		__J(word_addr_calculated, word_region);

		if(pipeline_flag)
		{
			if(reg_flag)
			{
				Write_VC_Reenable_Joins(active_reenable_points, word_addr_calculated,ofile);
				active_reenable_points.clear();
			}
		}
	}
	else
	{
		// declare root address calculated..
		__T(root_addr_calculated);

		// address is a constant... no need to reenable..
		__J(word_addr_calculated, root_addr_calculated);
	}
}

void AaObjectReference::Write_VC_Address_Calculation_Links_Optimized(string hier_id,
		vector<AaExpression*>* indices,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		ostream& ofile)
{

	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();

	vector<string> reqs;
	vector<string> acks;

	if(offset_val < 0 || base_addr < 0)
	{
		this->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,indices,scale_factors,shift_factors, ofile);

		string word_region = this->Get_VC_Name() + "_word_addrgen"; 
		hier_id = Augment_Hier_Id(hier_id,word_region);

		// individual word addresses (in parallel)
		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
		if(nwords > 1)
		{
			for(int idx = 0; idx < nwords; idx++)
			{
				string sample_regn = hier_id + "/word_" + IntToStr(idx) + "_sample"; 
				string update_regn = hier_id + "/word_" + IntToStr(idx) + "_update"; 
				reqs.push_back(sample_regn + "/rr");
				reqs.push_back(update_regn + "/cr");
				acks.push_back(sample_regn + "/ra");
				acks.push_back(update_regn + "/ca");
				Write_VC_Link(this->Get_VC_Name() + "_addr_" + IntToStr(idx),
						reqs,
						acks,
						ofile);
				reqs.clear();
				acks.clear();
			}
		}
		else
		{
			// single word, no operation.. but rename it.
			// ofile << "$T [root_register_req] $T [root_register_ack]" << endl;
			reqs.push_back(hier_id + "/root_register_req");
			acks.push_back(hier_id + "/root_register_ack");
			Write_VC_Link(this->Get_VC_Name() + "_addr_0",
					reqs,
					acks,
					ofile);
			reqs.clear();
			acks.clear();
		}
	}

}

 

// all operations are triggered immediately when the containing
// fork-block is entered.  dependencies as indicated..
// always produces a transition root_address_calculated.
//
// need to be careful in the reenables.  
//
// TODO:  the reenabling is broken..  the complete transition
// of the successor should reenable the sample transition of
// the predecessor register!
//
void AaObjectReference::
Write_VC_Root_Address_Calculation_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		vector<AaExpression*>* index_vector,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		set<string>& active_reenable_points,
		AaRoot* barrier,
		ostream& ofile)
{


	string root_address_calculated = this->Get_VC_Name() + "_root_address_calculated";
	__T(root_address_calculated);

	int offset_val = 0;
	if(index_vector)
		offset_val = this->Evaluate(index_vector,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();
			    
        string base_addr_update_reenable = 
		this->Get_VC_Base_Address_Update_Reenable_Transition(visited_elements);

	// if both are constants.. give up.
	if(offset_val >= 0 && base_addr >= 0)
		return;

	bool all_indices_zero = (offset_val == 0);
	int num_non_constant = 0;
	bool const_index_flag = false;
	bool reg_flag = false;


	vector<int> non_constant_indices;

	string offset_calculated = this->Get_VC_Name() + "_offset_calculated";
	string base_address_resized = this->Get_VC_Name() + "_base_address_resized";

	string base_address_calculated = this->Get_VC_Name() + "_base_address_calculated";

	map<int,string> index_chain_reenable_map;
	map<int,string> index_chain_complete_map;

	// if offset value is < 0, then it is not known at compile time.
	// calculate it at run time.
	if(offset_val < 0)
	{
		__T(offset_calculated);

		for(int idx = 0; idx < index_vector->size(); idx++)
		{
			// if the index is a constant dont bother to compute it..
			if(!(*index_vector)[idx]->Is_Constant())
			{
				non_constant_indices.push_back(idx);

			        string idx_active_reenable;
				string idx_active_complete;

				string index_resized = this->Get_VC_Name() + "_index_resized_" + IntToStr(idx);
				string index_scaled = this->Get_VC_Name() + "_index_scaled_" + IntToStr(idx);
				__T(index_resized);
				__T(index_scaled);

				num_non_constant++;
				(*index_vector)[idx]->Write_VC_Control_Path_Optimized(pipeline_flag, 
						visited_elements,
						ls_map,pipe_map,barrier,
						ofile);

				index_chain_reenable_map[idx] = ((*index_vector)[idx]->Get_VC_Reenable_Update_Transition_Name(visited_elements));
				index_chain_complete_map[idx] = (*index_vector)[idx]->Get_VC_Completed_Transition_Name();

				string idx_resize_regn_name = this->Get_VC_Name() + "_index_resize_" + 
								IntToStr(idx);

				if((*index_vector)[idx]->Get_Type()->Is_Uinteger_Type())
				{
					ofile << ";;[" << idx_resize_regn_name << "] {" << endl;
					ofile << "$T [index_resize_req] $T [index_resize_ack] // resize index to address-width" << endl;
					ofile << "}" << endl;

					__F(index_chain_complete_map[idx],idx_resize_regn_name);
					__J(index_resized,idx_resize_regn_name);
					index_chain_complete_map[idx] = index_resized;
				}
				else
				{
			
					// type conversion to uinteger.
					// the sample and update regions
					// are separated to create
					// separate sample and update
					// reenable points.
					string idx_resize_sample_start = 
							idx_resize_regn_name + "_sample_start";
					string idx_resize_sample_complete = idx_resize_regn_name + "_sample_complete";

					string idx_resize_update_start = idx_resize_regn_name + "_update_start";
					string idx_resize_update_complete = idx_resize_regn_name + "_update_complete";

					__T(idx_resize_sample_start);
					__T(idx_resize_sample_complete);
					__T(idx_resize_update_start);
					__T(idx_resize_update_complete);

					string idx_resize_sample_regn = idx_resize_regn_name + "_Sample";
					string idx_resize_update_regn = idx_resize_regn_name + "_Update";
					ofile << ";;[" << idx_resize_sample_regn << "] { " << endl;
					ofile << "$T [rr] $T [ra]" << endl;
					ofile << "}" << endl;
					ofile << ";;[" << idx_resize_update_regn << "] { " << endl;
					ofile << "$T [cr] $T [ca]" << endl;
					ofile << "}" << endl;
					ofile << "}" << endl;

					__F(index_chain_complete_map[idx],idx_resize_sample_start);
					__F(idx_resize_sample_start,idx_resize_sample_regn);
					__J(idx_resize_sample_complete,idx_resize_sample_regn);
					__F(idx_resize_update_start, idx_resize_update_regn);
					__J(idx_resize_update_complete,idx_resize_update_regn);
					__J(index_resized,idx_resize_update_complete);
					index_chain_complete_map[idx] = index_resized;

					if(pipeline_flag)
					{
						// reenable index expression update when
						// sample-completed.
						__MJ(index_chain_reenable_map[idx], idx_resize_sample_complete);
						active_reenable_points.erase(index_chain_reenable_map[idx]);
						index_chain_reenable_map[idx] = idx_resize_update_start;
						active_reenable_points.insert(idx_resize_update_start);

						// self-release.
						__MJ(idx_resize_sample_start, idx_resize_sample_complete);
						__MJ(idx_resize_update_start, idx_resize_update_complete);
					}
				}



				string idx_scale_regn_name =
					this->Get_VC_Name() + "_index_scale_" + IntToStr(idx);
				if((*scale_factors)[idx] > 1)
				{
					string idx_scale_sample_start = 
							idx_scale_regn_name + "_sample_start";
					string idx_scale_sample_complete = idx_scale_regn_name + "_sample_complete";

					string idx_scale_update_start = idx_scale_regn_name + "_update_start";
					string idx_scale_update_complete = idx_scale_regn_name + "_update_complete";

					__T(idx_scale_sample_start);
					__T(idx_scale_sample_complete);
					__T(idx_scale_update_start);
					__T(idx_scale_update_complete);

					string idx_scale_sample_regn = 
							idx_scale_regn_name + "_Sample";
					string idx_scale_update_regn = 
							idx_scale_regn_name + "_Update";

					ofile << ";;" << idx_scale_sample_regn << "] { " << endl;
					ofile << "$T [rr] $T [ra] " << endl;
					ofile << "}" << endl;
					ofile << ";;" << idx_scale_update_regn << "] { " << endl;
					ofile << "$T [cr] $T [ca] " << endl;
					ofile << "}" << endl;

					__F(index_chain_complete_map[idx],idx_scale_sample_start);
					__F(idx_scale_sample_start,idx_scale_sample_regn);
					__J(idx_scale_sample_complete,idx_scale_sample_regn);
					__F(idx_scale_update_start, idx_scale_update_regn);
					__J(idx_scale_update_complete,idx_scale_update_regn);
					__J(index_scaled,idx_scale_update_complete);

					index_chain_complete_map[idx] = index_scaled;

					if(pipeline_flag)
					{
						// successor complete: indices_scaled
						// predecessor sample: index_resized.
						__MJ(index_chain_reenable_map[idx], index_scaled);
						active_reenable_points.erase(index_chain_reenable_map[idx]);
						index_chain_reenable_map[idx] = idx_scale_update_start;
						active_reenable_points.insert(idx_scale_update_start);

						// self-release.
						__MJ(idx_scale_sample_start, idx_scale_sample_complete);
						__MJ(idx_scale_update_start, idx_scale_update_complete);
					}
				}
				else
				{
					ofile << ";;[" << idx_scale_regn_name << "] {" << endl;
					ofile << "$T [scale_rename_req] $T [scale_rename_ack] // rename " << endl;
					ofile << "}" << endl;
					__F(index_chain_complete_map[idx],idx_scale_regn_name);
					__J(index_scaled,idx_scale_regn_name);
					index_chain_complete_map[idx] = index_scaled;
				}

			}
			else
			{
				const_index_flag = true;
			}
		}

		//       each addition is written as a split pair
		//       of sample and update.  The updates trigger
		//       the next sample (forming a chain).
		
		// then add them up.
		int num_index_adds = (num_non_constant + (const_index_flag ? 1 : 0)) - 1;

		assert(non_constant_indices.size() > 0);
		string last_sum_complete = index_chain_complete_map[non_constant_indices[0]];
		string last_sum_reenable = index_chain_reenable_map[non_constant_indices[0]];

		if(index_vector->size() > 1)
		{

			for(int idx = 1; idx <= num_index_adds; idx++)
			{
				reg_flag = true;
				string prefix = "partial_sum_" + IntToStr(idx);

				string sample_start = prefix + "_sample_start";
				string sample_complete = prefix + "_sample_complete";
				string update_start = prefix + "_update_start";
				string update_complete = prefix + "_update_complete";

				string sample_regn = prefix + "_Sample";
				string update_regn = prefix + "_Update";

				ofile << ";;[" << sample_regn << "] {"  << endl;
				ofile << "$T [rr] $T [ra] " << endl;
				ofile << "}" << endl;

				ofile << ";;[" << update_regn << "] {"  << endl;
				ofile << "$T [cr] $T [ca] " << endl;
				ofile << "}" << endl;

				__F(sample_start, sample_regn);
				__J(sample_complete,sample_regn);

				__F(update_start, update_regn);
				__J(update_complete,update_regn);

				if(pipeline_flag)
				{
					// self-release.
					__MJ(sample_start, sample_complete);
					__MJ(update_start, update_complete);
				}

				if(idx == 1)
				{
					int I0 = non_constant_indices[idx-1];
					int I1 = non_constant_indices[idx];

					__J(sample_start, index_chain_complete_map[I0]);
					__J(sample_start, index_chain_complete_map[I1]);
				

					if(pipeline_flag)
					{
						__MJ(index_chain_reenable_map[I0], sample_complete);
						__MJ(index_chain_reenable_map[I1], sample_complete);
					}
				}
				else
				{
					int I1 = non_constant_indices[idx];
					__J(sample_start, index_chain_complete_map[I1]);
					__J(sample_start, last_sum_complete);
					if(pipeline_flag)
					{	
						__MJ(index_chain_reenable_map[I1], sample_complete);
					}
				}


				if(idx == num_index_adds)
				{
					__J(offset_calculated, update_complete);
				}

				last_sum_complete =  update_complete;
				last_sum_reenable =  update_start;
			}

			active_reenable_points.clear();
			active_reenable_points.insert(last_sum_reenable);
		}


		// the final index.. (simply rename)
		string final_offset_regn = this->Get_VC_Name() + "_final_offset";
		ofile << ";;[" <<  final_offset_regn << "] {" << endl;
		ofile << "$T [final_index_req] $T [final_index_ack] // rename" << endl;
		ofile << "}" << endl;
					
		
		__F(last_sum_complete, final_offset_regn);
                __J(offset_calculated, final_offset_regn);
	}


	// at this point you have a final-offset-index.
	// this needs to be added to a base address, which 
	// is either a constant (if _object is a declared storage object)
	if(base_addr < 0)
	{

		__T(base_address_resized);

		// base is not constant, resize it to the required address width..
		// otherwise, we will just declare the base as a constant
		// with the required width
		string b_resize_regn = this->Get_VC_Name() + "_base_addr_resize";
		ofile << ";;[" << b_resize_regn << "] {" << endl;
		ofile << "$T [base_resize_req] $T [base_resize_ack]" << endl;
		ofile << "}" << endl;

		__F(base_address_calculated,b_resize_regn);  
		__J(base_address_resized,b_resize_regn);
	}

	reg_flag = false;
	if(!all_indices_zero && (base_addr != 0))
	{
		reg_flag = true;
		// index was not zero and base was not zero..
		// we need to add two numbers, at most one of which
		// can be a constant..

		// 	separate sample and update regions to create
		//       distinct RAW and WAR enable points.
		string bpo_sample_regn = this->Get_VC_Name() + "_base_plus_offset_sample";
		string bpo_update_regn = this->Get_VC_Name() + "_base_plus_offset_update";

		// base-plus-offset.
		// transitions.
		string bpo_sample_start = this->Get_VC_Name() + "_base_plus_offset_sample_start";
		string bpo_sample_complete = this->Get_VC_Name() + "_base_plus_offset_sample_complete";
		string bpo_update_start = this->Get_VC_Name() + "_base_plus_offset_update_start";
		string bpo_update_complete = this->Get_VC_Name() + "_base_plus_offset_update_complete";
		__T(bpo_sample_start)
		__T(bpo_sample_complete)
		__T(bpo_update_start)
		__T(bpo_update_complete)

		ofile << ";;[" << bpo_sample_regn << "] { " << endl;
		ofile << "$T [rr] $T [ra]" << endl;
		ofile << "}" << endl;
		ofile << ";;[" << bpo_update_regn << "] { " << endl;
		ofile << "$T [cr] $T [ca]" << endl;
		ofile << "}" << endl;
	
		__F(bpo_sample_start, bpo_sample_regn)
		__F(bpo_update_start, bpo_update_regn)
		__J(bpo_sample_complete, bpo_sample_regn)
		__J(bpo_update_complete, bpo_update_regn)


		if(base_addr < 0)
		{
			__F(base_address_resized,bpo_sample_start);
			if(pipeline_flag)
			{
			    active_reenable_points.insert(base_addr_update_reenable);
			}
		}
		if(offset_val < 0)
		{
			__F(offset_calculated,bpo_sample_start);
			if(pipeline_flag)
			{
				// nothing, because last_sum_reenable is 
				// already in active_reenable_points.
			}
		}
		__J(root_address_calculated,bpo_update_complete);
	
		if(pipeline_flag)
		{
			// self-release
			__MJ(bpo_sample_complete, bpo_sample_start);
			__MJ(bpo_update_complete, bpo_update_start);
		}
	}
	else 
	{
		// at least one is zero.
		// just rename, no addition is needed.
		// the input operand is offset if it is non-zero, base if it is non-zero.
		ofile << ";;[" << this->Get_VC_Name() << "_base_plus_offset] {" << endl;
		ofile << "$T [sum_rename_req] $T [sum_rename_ack] // one gets through " << endl;
		ofile << "}" << endl;

		if(base_addr != 0)
		{
			__F(base_address_resized,(this->Get_VC_Name() + "_base_plus_offset"));
			if(pipeline_flag)
			{
				// nothing.
			    active_reenable_points.insert(base_addr_update_reenable);
			}
		}
		else
		{
			__F(offset_calculated,(this->Get_VC_Name() + "_base_plus_offset"));
			if(pipeline_flag)
			{
				// nothing, last sum is already in the 
				// active_reenable_points set.
			}
		}
		__J(root_address_calculated,(this->Get_VC_Name() + "_base_plus_offset"));
	}
}



void AaObjectReference::
Write_VC_Root_Address_Calculation_Links_Optimized(string hier_id,
		vector<AaExpression*>* indices,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		ostream& ofile)
{
	int offset_val = 0;
	if(indices)
		offset_val = this->Evaluate(indices,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();


	bool all_indices_zero = (offset_val == 0);
	int num_non_constant = 0;
	bool const_index_flag = false;

	vector<string> reqs;
	vector<string> acks;
	string inst_name;


	if(offset_val < 0)
	{
		for(int idx = 0; idx < indices->size(); idx++)
		{
			// if the index is a constant dont bother to compute it..
			if(!(*indices)[idx]->Is_Constant())
			{
				string idx_resize_regn_name = this->Get_VC_Name() + "_index_resize_" + 
								IntToStr(idx);

				num_non_constant++;
				(*indices)[idx]->Write_VC_Links_Optimized(hier_id,ofile);

								IntToStr(idx);

				if((*indices)[idx]->Get_Type()->Is_Uinteger_Type())	      
				{
					reqs.push_back(hier_id + "/" + idx_resize_regn_name  + "/index_resize_req");
					acks.push_back(hier_id + "/" + idx_resize_regn_name  + "/index_resize_ack");
				}
				else
				{
					string idx_resize_sample_regn = idx_resize_regn_name + "_Sample";
					string idx_resize_update_regn = idx_resize_regn_name + "_Update";
					reqs.push_back(hier_id + "/" + idx_resize_sample_regn + "/rr");
					acks.push_back(hier_id + "/" + idx_resize_sample_regn + "/ra");
					reqs.push_back(hier_id + "/" + idx_resize_update_regn + "/cr");
					acks.push_back(hier_id + "/" + idx_resize_update_regn + "/ca");
				}
				inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_resize";
				Write_VC_Link(inst_name,reqs,acks,ofile);
				reqs.clear();
				acks.clear();

				string idx_scale_regn_name =
					this->Get_VC_Name() + "_index_scale_" + IntToStr(idx);
				if((*scale_factors)[idx] > 1)
				{
					string idx_scale_sample_regn = 
							idx_scale_regn_name + "_Sample";
					string idx_scale_update_regn = 
							idx_scale_regn_name + "_Update";
					reqs.push_back(hier_id + "/" + idx_scale_sample_regn + "/rr");
					reqs.push_back(hier_id + "/" + idx_scale_update_regn + "/cr");
					acks.push_back(hier_id + "/" + idx_scale_sample_regn + "/ra");
					acks.push_back(hier_id + "/" + idx_scale_update_regn + "/ca");

					inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_scale";
					Write_VC_Link(inst_name,reqs,acks,ofile);
					reqs.clear();
					acks.clear();
				}
				else
				{
					reqs.push_back(hier_id + "/" + idx_scale_regn_name + "/scale_rename_req");
					acks.push_back(hier_id + "/" + idx_scale_regn_name + "/scale_rename_ack");
					inst_name = this->Get_VC_Name() + "_index_" + IntToStr(idx) + "_rename";
					Write_VC_Link(inst_name,reqs,acks,ofile);
					reqs.clear();
					acks.clear();
				}
			}
			else
				const_index_flag = true;
		}


		// then add them up.
		string nhid = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_add_indices");
		if(indices->size() > 1)
		{
			int num_index_adds = (num_non_constant + (const_index_flag ? 1 : 0)) - 1;
			for(int idx = 1; idx <= num_index_adds; idx++)
			{
				string prefix = "partial_sum_" + IntToStr(idx);
				string sample_regn = prefix + "_sample";
				string update_regn = prefix + "_update";
				reqs.push_back(hier_id + "/" + sample_regn + "/rr");
				reqs.push_back(hier_id + "/" + update_regn + "/cr");
				acks.push_back(hier_id + "/" + sample_regn + "/ra");
				acks.push_back(hier_id + "/" + update_regn + "/ca");
				inst_name= this->Get_VC_Name() + "_index_sum_" + IntToStr(idx);
				Write_VC_Link(inst_name,reqs,acks,ofile);
				reqs.clear();
				acks.clear();
			}
		}


		// the final index..
		string final_offset_regn = this->Get_VC_Name() + "_final_offset";
		reqs.push_back(hier_id + "/" + final_offset_regn + "/final_index_req");
		acks.push_back(hier_id + "/" + final_offset_regn + "/final_index_ack");
		inst_name = this->Get_VC_Name() + "_offset_inst";
		Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}

	// back to hier_id.

	// at this point you have a final-offset-index.
	// this needs to be added to a base address, which 
	// is either a constant (if _object is a declared storage object)
	if(base_addr < 0)
	{
		string b_resize_regn = this->Get_VC_Name() + "_base_addr_resize";
		// base is not constant, resize it to the required address width..
		// otherwise, we will just declare the base as a constant
		// with the required width
		reqs.push_back(hier_id + "/" + b_resize_regn + "/base_resize_req");
		acks.push_back(hier_id + "/" + b_resize_regn + "/base_resize_ack");
		inst_name = this->Get_VC_Name() + "_base_resize";
		Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}


	if(!all_indices_zero && (base_addr != 0))
	{
		string bpo_sample_regn = this->Get_VC_Name() + "_base_plus_offset_sample";
		string bpo_update_regn = this->Get_VC_Name() + "_base_plus_offset_update";
		// index was not zero and base was not zero..
		// we need to add two numbers, at most one of which
		// can be a constant..

		string sample_region = hier_id + "/" + bpo_sample_regn;
		string update_region = hier_id + "/" + bpo_update_regn;
		reqs.push_back(sample_region + "/rr");
		reqs.push_back(update_region + "/cr");
		acks.push_back(sample_region + "/ra");
		acks.push_back(update_region + "/ca");
		inst_name =  this->Get_VC_Name() + "_root_address_inst",
			  Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}
	else 
	{
		string hid = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_base_plus_offset");
		// at least one is zero.
		// just rename, no addition is needed.
		// the input operand is offset if it is non-zero, base if it is non-zero.
		reqs.push_back(hid + "/sum_rename_req");
		acks.push_back(hid + "/sum_rename_ack");
		inst_name = this->Get_VC_Name() + "_root_address_inst";
		Write_VC_Link(inst_name,reqs,acks,ofile);
		reqs.clear();
		acks.clear();
	}
}








