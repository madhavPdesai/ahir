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

// This expression is the reader.  Its roots should be reenabled 
// by ctrans (which is the sample-complete transition of the statement of which this
// expression is a source).
void AaExpression::Write_VC_Update_Reenables(AaRoot* reenabling_agent,
						string ctrans, bool bypass_if_true,  set<AaRoot*>& visited_elements,  ostream& ofile)
{
	set<AaRoot*> root_set;
	this->Collect_Root_Sources(root_set);

	set<AaRoot*> reenabling_root_set;
	if(reenabling_agent->Is_Statement())
		((AaStatement*)reenabling_agent)->Collect_Root_Sources(reenabling_root_set);
	else if(reenabling_agent->Is_Expression())
		((AaExpression*)reenabling_agent)->Collect_Root_Sources(reenabling_root_set);

        // Check if reenabling agent has a Phi-root.	
        bool reenabling_agent_depends_on_phi       = false;
        bool reenabling_agent_does_not_depend_on_phi = false;
        for(set<AaRoot*>::iterator riter = reenabling_root_set.begin(), friter = reenabling_root_set.end();
			riter != friter; riter++)
	{
		AaRoot* ra_root = *riter;
		if(ra_root->Is("AaPhiStatement"))
		{
			reenabling_agent_depends_on_phi = true;
		}
		else if(ra_root->Is_Statement())
		{
			reenabling_agent_does_not_depend_on_phi = true;
		}
	}

	if(reenabling_agent_depends_on_phi && reenabling_agent_does_not_depend_on_phi) 
	{
		AaRoot::Error("Volatile depends on both Phi's and non-Phi's.. Pipelining may fail!", reenabling_agent);
	}
		
	ofile << "// RAW reenables for " << this->To_String() << endl;
	for(set<AaRoot*>::iterator iter = root_set.begin(), fiter = root_set.end(); iter != fiter; iter++)
	{
		if((*iter)->Is_Expression())
		{
			AaExpression* producer = (AaExpression*) *iter;
			bool bypass = (bypass_if_true || producer->Update_Protocol_Has_Delay(visited_elements));

			if(visited_elements.find(producer) != visited_elements.end())
			{
				if((!reenabling_agent_depends_on_phi && (this->Get_Associated_Phi_Statement() == NULL)) || 
						(producer->Get_Associated_Phi_Statement() == NULL))
				{
					AaRoot* producer_root = producer->Get_Root_Object();
					if( (producer_root != NULL)  && producer_root->Is("AaPhiStatement") &&
								(reenabling_agent_depends_on_phi ||
											this->Get_Associated_Phi_Statement() != NULL))
					{	
						ofile << "// producer  and  user are both determined by PHI statements." << endl;
					}
					else
					{
						__MJ(producer->Get_VC_Reenable_Update_Transition_Name(visited_elements), ctrans, bypass);
					}
				}
				else
					ofile << "// producer  and  user are determined by PHI statements." << endl;
			}

			// 
			// if producer is part of operator module, and if producer is
			// a simple-object-reference to an input interface object, then 
			// we create an unmarked link to an update-enable.
			// 
			if(this->Is_Part_Of_Operator_Module() && producer->Is("AaSimpleObjectReference"))
			{
				AaSimpleObjectReference* sor = (AaSimpleObjectReference*) producer;
				if(sor->Get_Object() && sor->Get_Object()->Is_Interface_Object())
				{
					AaInterfaceObject* iobj = (AaInterfaceObject*) (sor->Get_Object());
					if(iobj->Get_Mode() == "in")
					{
						__J(sor->Get_VC_Unmarked_Reenable_Update_Transition_Name(visited_elements), ctrans);
					}
				}
			}
		}
	}
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
// Here "this" is "b" in the target.
//
void AaExpression::Write_VC_WAR_Dependencies(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		ostream& ofile)
{
	if(!this->Is_Implicit_Variable_Reference())
		return;

	AaStatement* write_stmt = this->Get_Associated_Statement();
	assert(write_stmt != NULL); // this is always a target..  so statement completion should retrigger read.

	bool write_stmt_is_dependent_on_phi = write_stmt->Is_Dependent_On_Phi();
	bool this_is_volatile = write_stmt->Get_Is_Volatile();
	bool full_rate = write_stmt->Is_Part_Of_Fullrate_Pipeline();
	bool err_flag = false;

	// the transition that triggers the write.
	string write_trigger_transition_name =  __UST(write_stmt);;

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
			AaExpression* read_expr = (AaExpression*)(*iter);

			if(!read_expr->Is_Constant())
			{
				//
				// the rhs source expression which is to be assigned to "this"
				// must be started only after read_expr has finished sampling its
				// inputs..  We are currently using the activation transition
				// of the associated statement of expr as the marker.
				//
				// the target "b = (d+e)" can be triggered only after the
				// statement a := (b+c) has used the value of b.
				//
				ofile << "// WAR dependency: Read: " << read_expr->To_String() << " before Write: " << write_stmt->To_String() << endl;
				AaStatement* read_stmt = read_expr->Get_Associated_Statement();
				bool read_is_dependent_on_phi = read_stmt->Is_Dependent_On_Phi();


				// The target "b = (d+e)" cannot be updated until 
				// the statement a := (b+c) has sampled b..  
				// This is conservative.
				if((read_stmt != write_stmt) && 
						(!(read_is_dependent_on_phi && write_stmt_is_dependent_on_phi)))
				{
					__J(__UST(write_stmt), __SCT(read_stmt));
				}
				else
				{
					ofile << "// self dependency in WAR or PHI-PHI dependency in WAR ignored." << endl;
				}

				// The completion of "b = (d+e)" reenables the
				// evaluation of "a = (b+c)"
				if(pipeline_flag)
				{

					if(this_is_volatile && read_stmt->Get_Is_Volatile())
					{
						AaRoot::Error("WAR dependency cycle across volatile statements .. Reader: ", read_stmt);
						AaRoot::Error("WAR dependency cycle across volatile statements .. Writer:", write_stmt);
					}
					else  if(!this_is_volatile)
					{
						ofile << "// WAR dependency: release  Read: " << read_expr->To_String() 
							<< " with Write: " << write_stmt->To_String() << endl;
						__MJ(read_expr->Get_VC_Reenable_Sample_Transition_Name(visited_elements), 
									__UCT(write_stmt), true);
						int rb = write_stmt->Get_Buffering();
						if(full_rate && (rb < 2))
						{
							write_stmt->Set_Buffering(2);
						}
					}
					else
					{
						ofile << "// WAR dependency: release  Read: " << read_expr->To_String() 
							<< " with volatile-write: " << write_stmt->To_String() << endl;

						// this is volatile..  read-stmt should enable the root sources of the write-stmt.
						// and the root sources of the write-stmt should reenable read-stmt.
						set<AaRoot*> root_set;
						write_stmt->Collect_Root_Sources(root_set);

						for(set<AaRoot*>::iterator iter = root_set.begin(), fiter = root_set.end();
							iter != fiter; iter++)
						{
							bool forward_dependency = false;
							if((*iter)->Is_Expression())
							{

								AaExpression* root_write_expr = (AaExpression*) *iter;
								AaRoot* root = root_write_expr->Get_Root_Object();

								ofile << "// CHECK THIS." << endl;
								ofile << "// WAR dependency writer: " << root_write_expr->To_String() 
									<< ", reader " << read_expr->To_String() << endl;


								bool root_is_stmt = ((root != NULL) && root->Is_Statement());
								bool both_are_phi = (root_is_stmt && 
										root->Is("AaPhiStatement") && 
										read_stmt->Is("AaPhiStatement"));

								if (root_is_stmt && (visited_elements.find(root) != visited_elements.end()))
								{
									forward_dependency = true;
									if(!both_are_phi)
									{
										ofile << "// root-writer is " << root->To_String() << endl;
										__J(__UST(root), __SCT(read_stmt));
										__MJ(__SST(read_stmt), __UCT(root), true);

										int rb = ((AaStatement*)root)->Get_Buffering();
										if(full_rate && (rb < 2))
										{
											((AaStatement*) root)->Set_Buffering(2);
										}
									}
									else
									{
										ofile << "// phi-phi WAR ignored " << endl;
									}
								}

								if(!forward_dependency)
								{
									AaRoot::Error("Bad WAR dependency... write expression " + this->To_String()
											+ " depends on downstream source " + root_write_expr->To_String(),
											this);
								}
							}
						}
					}
				}
			}
		}
	}

}

//
// from guard expression guard_expr to this.
//
void AaExpression::Write_VC_Guard_Forward_Dependency(AaSimpleObjectReference* guard_expr, set<AaRoot*>& visited_elements, ostream& ofile)
{
	AaRoot* root = guard_expr->Get_Root_Object();
	if(visited_elements.find(root) != visited_elements.end())
	{
		if((this->Get_Associated_Phi_Statement() == NULL) ||
				(guard_expr->Get_Associated_Phi_Statement() == NULL))
		{
			// No Phi-Phi dependencies
			__J(__SST(this), __UCT(guard_expr));

			// Note: with new SplitGuardInterface
			// this dependency is no longer necessary.
			//__J(__UST(this), __UCT(root));
		}
	}
	else
	{
		ofile << "// root " << root->Get_VC_Name() << " of guard-expression " << guard_expr->Get_VC_Name() << " not in visited elements." << endl;
	}
}


void AaExpression::Write_VC_Guard_Backward_Dependency(AaExpression* guard_expr,
		set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(this->Get_Is_Target() || !(this->Is_Trivial() && this->Get_Is_Intermediate()))
	{
		// when this completes, the guard can be re-evaluated.
		guard_expr->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
	}

	// With new SplitGuardInterface, this dependency is
	// no longer necessary.
	//__MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements),
	//__UCT(this), true);  // bypass
}

void AaExpression::Write_VC_Guard_Dependency(bool pipeline_flag, set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(this->Get_Guard_Expression() != NULL)
	{
		AaExpression* expr = this->Get_Guard_Expression();
		if(!expr->Is_Constant() && (expr != this))
		{
			ofile << "// Guard dependency for expression " << this->Get_VC_Name() << " with guard " <<
				expr->Get_VC_Name() <<  endl;
			if(expr->Is("AaSimpleObjectReference"))
			{

				AaSimpleObjectReference* sexpr = (AaSimpleObjectReference*) expr;
				this->Write_VC_Guard_Forward_Dependency(sexpr,visited_elements,ofile);
			}
			else
			{
				AaRoot::Error("guard expression must be an implicit variable reference.\n",this);
			}

			if(pipeline_flag)
			{

				this->Write_VC_Guard_Backward_Dependency(expr,visited_elements,ofile);

			}
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
			if(!this->Is_Signal_Read())
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

			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";

			reqs.push_back(hier_id + "/" + sample_regn + "/req");
			reqs.push_back(hier_id + "/" + update_regn + "/req");
			acks.push_back(hier_id + "/" + sample_regn + "/ack");
			acks.push_back(hier_id + "/" + update_regn + "/ack");
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


		__DeclTransSplitProtocolPattern;

		// if this is a statement...
		if(this->_object->Is_Interface_Object())
		{
			ofile << "// reference to interface object" << endl;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
			}


			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
			AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();

			// forward dependency from root statement to this expression
			if((root != NULL) && (visited_elements.find(root) != visited_elements.end()))
			{
				__J(__SST(this), __UCT(root));
			}	  
			else if(this->Get_Associated_Phi_Statement() == NULL)
			{
				// in PHI, the sources are enabled from the sequencer.
				__J(__SST(this), "$entry");
			}

			// complete the connections.
			__J(__SCT(this),__SST(this));
			__J(__UST(this),__SCT(this));
			__J(__UCT(this),__UST(this));

			bool pm = this->Is_Part_Of_Pipelined_Module();
			if(pm && (this->Get_Associated_Phi_Statement() == NULL))
			{
				//string sample_enable = this->_object->Get_VC_Name() + "_update_enable";
				//
				// entry will be triggered on availability of input arguments.
				//
				string sample_enable = "$entry";
				__J(__SST(this), sample_enable); // no marking, since sample_enable
				// will have marked joins.
			}
		}
		else if(this->Is_Implicit_Variable_Reference())
		{
			ofile << "// implicit reference" << endl;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
			}

			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

			AaRoot* root = this->Get_Root_Object();
			if(visited_elements.find(root) != visited_elements.end())
			{
				//if((this->Get_Associated_Phi_Statement() == NULL) 
				// && !root->Is("AaPhiStatement"))
				//{
				__J(__SST(this), __UCT(root));
				//}

			}
			else if(this->Get_Associated_Phi_Statement() == NULL)
			{
				__J(__SST(this), "$entry");
			}

			// complete the connections.
			__J(__SCT(this),__SST(this));
			__J(__UST(this),__SCT(this));
			__J(__UCT(this),__UST(this));
		}
		else if(this->_object->Is("AaStorageObject"))
			// complete region name is in Write_VC_Load_Control...
		{
			__DeclTransSplitProtocolPattern;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this),__UCT(barrier));
			}

			// this takes care of the guard..
			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

			// load-control path evaluates the address and the
			// load.
			this->Write_VC_Load_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,NULL,NULL,NULL,barrier,ofile);

			ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);

			__ConnectSplitProtocolPattern;

			if(pipeline_flag)
			{
				__SelfReleaseSplitProtocolPattern
			}
		}
		// else if the object being referred to is
		// a pipe, instantiate a split protocol path
		// for the inport operation
		else if(this->_object->Is("AaPipeObject"))
			// needed to hook up pipe dependencies.
		{
			//
			// a pipe read.. only the update transitions are in 
			// play here.
			//
			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
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

			__ConnectChainedSplitProtocolPattern;

			// record the pipe!  Introduce pipe related dependencies 
			// later. 
			pipe_map[this->_object->Get_VC_Name()].push_back(this);

			if(pipeline_flag && !this->_object->Is_Signal())
			{
				//
				// SelfRelease (only the UST part is needed..).
				// the sample part does not need to be reenabled.
				// __MJ(__UST(this),__UCT(this),true);
				// however other logic depends on strict reenabling.
				// 
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

	ofile << "// (as target) " << this->To_String() << endl;

	if(this->Is_Implicit_Variable_Reference() || this->_object->Is_Interface_Object())
	{
		if(!this->_object->Is_Interface_Object())
			ofile << "// " << this->To_String() << endl << "// implicit reference" << endl;
		else
		{
			ofile << "// " << this->To_String() << endl << "// write to interface object" << endl;
			bool pm = this->Is_Part_Of_Pipelined_Module();
			if(pm)
			{
				string update_enable = this->_object->Get_VC_Name() + "_update_enable";
				__J(__UST(this), update_enable); // ... note: unmarked, since 
				// transitions to update_enable will be marked.
			}
		}
	}
	else if(this->_object->Is("AaStorageObject"))
	{
		__DeclTransSplitProtocolPattern;

		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
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

		__ConnectSplitProtocolPattern;

		if(pipeline_flag)
		{
			__SelfReleaseSplitProtocolPattern
		}

	}
	// else if the object being referred to is
	// a pipe, instantiate a series r-a
	// chain for the inport operation
	else if(this->_object->Is("AaPipeObject"))
	{
		__DeclTransSplitProtocolPattern;
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		string sample_regn = this->Get_VC_Name() + "_Sample";
		ofile << ";;[" << sample_regn << "] { // pipe write sample-start ";
		this->Print(ofile);
		ofile << endl;
		ofile << "$T [req] $T [ack] " << endl;
		ofile << "}" << endl;

		string update_regn = this->Get_VC_Name() + "_Update";
		ofile << ";;[" << update_regn << "] { // pipe write update (complete) ";
		this->Print(ofile);
		ofile << endl;
		ofile << "$T [req] $T [ack] " << endl;
		ofile << "}" << endl;

		__ConnectChainedSplitProtocolPattern;

		if(pipeline_flag)
		{
			//
			// only the sample pair is needed..
			// __MJ(__SST(this),__SCT(this),false);
			// However, both are released to guarantee
			// correct sequencing to guard logic.
			//
			__SelfReleaseSplitProtocolPattern
		}


		pipe_map[this->_object->Get_VC_Name()].push_back(this);
	}
}

	
bool AaSimpleObjectReference::Is_Pipe_Read()
{
	if(this->_object == NULL)
		return(false);
	if(this->_object->Is_Pipe_Object())
	{
		return(!this->Get_Is_Target());
	}
}

void AaSimpleObjectReference::Write_VC_Guard_Backward_Dependency(AaExpression* expr,
		set<AaRoot*>& visited_elements, ostream& ofile)
{
	// Simplified.  Earlier, a pipe read had to be handled specially
	// (reenable guard-update from update-complete instead of sample-complete).
	// The SplitUpdateGuardInterface was modified to internally sample
	// the guard signal, so the simple case works.
	this->AaExpression::Write_VC_Guard_Backward_Dependency(expr, visited_elements, ofile);
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
			if((this->_pointer_ref  != NULL) && !this->_pointer_ref->Is_Constant())
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

bool AaArrayObjectReference::Base_Address_Update_Protocol_Has_Delay(set<AaRoot*>& visited_elements)
{

	bool ret_val =  false;
	if(!this->Is_Constant())
	{
		if(this->Get_Object_Type()->Is_Pointer_Type())
			// array expression is a pointer-evaluation expression.
		{
			if((this->_pointer_ref  != NULL) && !this->_pointer_ref->Is_Constant())
			{
				ret_val = 
					this->_pointer_ref->Update_Protocol_Has_Delay(visited_elements);

			}
			else if(this->_object->Is_Expression())
			{
				AaRoot* root = (((AaExpression*)this->_object)->Get_Root_Object());
				if(root && root->Is_Statement())
				{
					if(visited_elements.find(root) != visited_elements.end())
					{
						ret_val = true;
					}
				}
			}
			else if(this->_object->Is_Interface_Object())
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				if(visited_elements.find(root) != visited_elements.end())
				{
					ret_val = true;
				}	  
			}
			else if(this->_object->Is_Statement())
			{
				AaRoot* root = this->_object;
				if(visited_elements.find(root) != visited_elements.end())
				{
					ret_val = true;
				}	  
			}
		}
	}
	return(ret_val);
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
			assert(this->_pointer_ref != NULL);
			this->_pointer_ref->Write_VC_Links_Optimized(hier_id,ofile);
		}

		// the return value is a pointer,
		// calculate the address.
		this->Write_VC_Root_Address_Calculation_Links_Optimized(hier_id,
				this->Get_Index_Vector(),
				&scale_factors, 
				&shift_factors,
				ofile);

		vector<string> reqs;
		vector<string> acks;
		reqs.push_back(hier_id + "/" + this->Get_VC_Request_Region_Name() + "/req");
		acks.push_back(hier_id + "/" + this->Get_VC_Request_Region_Name() + "/ack");
		reqs.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/req");
		acks.push_back(hier_id + "/" + this->Get_VC_Complete_Region_Name() + "/ack");
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

// there are some holes here.
void AaArrayObjectReference::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		ofile << "// " << this->To_String() << endl;

		string base_addr_calc = (this->Get_VC_Name() + "_base_address_calculated");
		__T(base_addr_calc);

		if(this->Get_Object_Type()->Is_Pointer_Type())
			// array expression is a pointer-evaluation expression.
		{
			__DeclTransSplitProtocolPattern;

			int word_size = this->Get_Word_Size();
			vector<int> scale_factors;
			this->Update_Address_Scaling_Factors(scale_factors,word_size);

			vector<int> shift_factors;
			this->Update_Address_Shift_Factors(shift_factors,word_size);

			if(this->_object->Is_Storage_Object())
			{
				// please load the object.
				ofile << "// pointer-reference " << endl;
				this->_pointer_ref->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);
				if(!this->_pointer_ref->Is_Constant())
				{
					__J(base_addr_calc, __UCT(this->_pointer_ref));
				}

			}
			else if(this->_object->Is_Expression())
			{
				AaRoot* root = (((AaExpression*)this->_object)->Get_Root_Object());
				if(root && root->Is_Statement())
				{
					if(visited_elements.find(root) != visited_elements.end())
					{
						__J(base_addr_calc, __UCT(((AaStatement*)root)));
					}
				}
			}
			else if(this->_object->Is_Interface_Object())
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				if(visited_elements.find(root) != visited_elements.end())
				{
					__J(base_addr_calc, __UCT(((AaStatement*)root)));
				}	  
			}
			else if(this->_object->Is_Statement())
			{
				AaRoot* root = this->_object;
				if(visited_elements.find(root) != visited_elements.end())
				{
					__J(base_addr_calc, __UCT(((AaStatement*)root)));
				}	  
			}
			else
			{
				assert(0);
			}


			// this will link to complete region.
			set<string> active_reenable_points;
			map<string,bool> active_reenable_bypass_flags;
			this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
					ls_map,
					pipe_map,
					&_indices,
					&scale_factors, &shift_factors,
					active_reenable_points,
					active_reenable_bypass_flags,
					barrier,
					ofile);




			// : this should be an interlock instead of a register.
			ofile << ";;[" << this->Get_VC_Request_Region_Name() << "] {" << endl;
			ofile << "$T [req] $T [ack]" << endl;
			ofile << "}" << endl;
			ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
			ofile << "$T [req] $T [ack]" << endl;
			ofile << "}" << endl;

			// remember, firing of active transition means that
			// all input variables to this expression have been 
			// sampled.
			__J(__SST(this),this->Get_VC_Name()+ "_root_address_calculated");
			__F(__SST(this),this->Get_VC_Request_Region_Name());
			__J(__SCT(this),this->Get_VC_Request_Region_Name());
			__F(__UST(this),this->Get_VC_Complete_Region_Name());
			__J(__UCT(this),this->Get_VC_Complete_Region_Name());

			if(pipeline_flag)
			{
				string ctrans = __SCT(this);

				// Note that the base address calculation reenable
				// will be part of the active_reenable_points.
				Write_VC_Reenable_Joins(active_reenable_points,
						active_reenable_bypass_flags, 
						ctrans,false, ofile); // do not force bypass, decide based on active bypass flags..

				active_reenable_points.clear();
				active_reenable_points.insert(__UST(this));

				// SelfRelease
				ofile << "// self-release " << endl;
				__SelfReleaseSplitProtocolPattern
			}

		}
		else if(this->_object->Is_Storage_Object())
			// array expression is a storage object indexed access expression..
		{
			__DeclTransSplitProtocolPattern;

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

			__ConnectSplitProtocolPattern
				if(pipeline_flag)
				{
					__SelfReleaseSplitProtocolPattern
				}
		}
		else
			// neither storage object nor pointer.. must be
			// a structure access expression..
		{
			if(this->_object->Is_Expression())
			{
				__DeclTransSplitProtocolPattern;
				AaExpression* expr = ((AaExpression*) (this->_object));
				expr->Write_VC_Control_Path_Optimized(pipeline_flag, 
						visited_elements,
						ls_map,
						pipe_map,
						barrier,
						ofile);

				// expression has been evaluated.. go to active
				__J(__SST(this), __UCT(expr));

				// TODO: use split protocol to implement Slice.
				//       (note that Slice doubles as a register..)
				ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
				ofile << "$T [slice_req] $T [slice_ack]" << endl;
				ofile << "}" << endl;

				__J(__SCT(this),__SST(this));
				__F(__SCT(this), __UST(this));
				__F(__UST(this),this->Get_VC_Complete_Region_Name());
				__J(__UCT(this), this->Get_VC_Complete_Region_Name());

				bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
				if(flow_through)
				{
					ofile << "// flow-through" << endl;
					__J(__UST(this), __SCT(this));
				}

				if(pipeline_flag)
				{
					// reenable expression when this completes.
					// note: conservative
					// __MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements), __UCT(this), true); // bypass
					expr->Write_VC_Update_Reenables(this, __UCT(this), 
							(!flow_through),
							visited_elements,ofile);

					if(!flow_through)
						__MJ(__UST(this),__UCT(this), true); // bypass
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

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
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

		__DeclTransSplitProtocolPattern

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

		__ConnectSplitProtocolPattern;

		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		if(pipeline_flag)
		{
			__SelfReleaseSplitProtocolPattern
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

bool AaPointerDereferenceExpression::Base_Address_Update_Protocol_Has_Delay(set<AaRoot*>& visited_elements)
{
	assert(this->_reference_to_object != NULL);
	bool ret_val = this->_reference_to_object->Update_Protocol_Has_Delay(visited_elements);
	return(ret_val);

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

	__DeclTransSplitProtocolPattern;

	if(barrier != NULL)
	{
		ofile << "// barrier " << endl;
		__J(__SST(this), __UCT(barrier));
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

	__ConnectSplitProtocolPattern;

	if(!this->_reference_to_object->Is_Constant())
	{
		__J(base_addr_calc,__UCT(this->_reference_to_object));
		__J(__SST(this),base_addr_calc);
		if(pipeline_flag)
		{
			//__MJ(this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
			this->_reference_to_object->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements,ofile);
		}

	}


	ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
	if(pipeline_flag)
	{
		__SelfReleaseSplitProtocolPattern
	}
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

	__DeclTransSplitProtocolPattern;

	if(barrier != NULL)
	{
		ofile << "// barrier " << endl;
		__J(__SST(this), __UCT(barrier));
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

	__ConnectSplitProtocolPattern;

	if(!this->_reference_to_object->Is_Constant())
	{
		__J(base_addr_calc,__UCT(this->_reference_to_object));
		__J(__SST(this),base_addr_calc);
		if(pipeline_flag)
		{
			this->_reference_to_object->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements,ofile);
			//__MJ(this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
		}
	}

	ls_map[this->Get_VC_Memory_Space_Name()].push_back(this);
	if(pipeline_flag)
	{
		__SelfReleaseSplitProtocolPattern
	}
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

		string req_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Request_Region_Name());
		string compl_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Complete_Region_Name());		       
		vector<string> reqs;
		vector<string> acks;
		reqs.push_back(req_hier_id + "/req");
		reqs.push_back(compl_hier_id + "/req");
		acks.push_back(req_hier_id + "/ack");
		acks.push_back(compl_hier_id + "/ack");

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
		__DeclTransSplitProtocolPattern;
		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this),__UCT(barrier));
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
		map<string,bool> active_reenable_bypass_flags;
		obj_ref->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				obj_ref->Get_Index_Vector(),
				&scale_factors, &shift_factors,
				active_reenable_points,
				active_reenable_bypass_flags,
				barrier,
				ofile);


		// need an interlock here!
		ofile << ";;[" << this->Get_VC_Request_Region_Name() << "] {" << endl;
		ofile << "$T [req] $T [ack]" << endl;
		ofile << "}" << endl;
		ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
		ofile << "$T [req] $T [ack]" << endl;
		ofile << "}" << endl;

		// links to root address calculation..
		__J(__SST(this), obj_ref->Get_VC_Name() + "_root_address_calculated");
		__F(__SST(this),this->Get_VC_Request_Region_Name());
		__J(__SCT(this),this->Get_VC_Request_Region_Name());
		__F(__UST(this),this->Get_VC_Complete_Region_Name());
		__J(__UCT(this), this->Get_VC_Complete_Region_Name());

		if(pipeline_flag)
		{
			ofile << "// reenables ." << endl;
			string ctrans = __SCT(this);
			Write_VC_Reenable_Joins(active_reenable_points,
					active_reenable_bypass_flags, 
					ctrans,false, ofile); // do not force bypass, decide based on active bypass flags
			active_reenable_points.clear();

			// SelfRelease
			ofile << "// self-release " << endl;
			__MJ(__SST(this),__SCT(this), false); // no bypass
			__MJ(__UST(this),__UCT(this), true); // bypass
		}
	}
	else
	{
		ofile << "// constant address-of expression" << endl;
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

	  	bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

		ofile << "// " << this->To_String() << endl;


		vector<string> reqs,acks;
		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		reqs.push_back(hier_id + "/" + sample_regn + "/rr");
		reqs.push_back(hier_id + "/" + update_regn + "/cr");
		acks.push_back(hier_id + "/" + sample_regn + "/ra");
		acks.push_back(hier_id + "/" + update_regn + "/ca");

		Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
	}

}

void AaTypeCastExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

string AaTypeCastExpression::Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
	return(__UST(this));
}
string AaTypeCastExpression::Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
{
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

		ofile << "// " << this->To_String() << endl;
		__DeclTransSplitProtocolPattern;

		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		this->_rest->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,barrier,
				ofile);

		__J(__SST(this),__UCT(this->_rest));

		// either it will be a register or a split conversion
		// operator..
		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		ofile << ";;[" << sample_regn << "] { // unary expression " << endl;      
		ofile << "$T [rr] $T [ra] // (split) unary operation" << endl;
		ofile << "}" << endl;

		ofile << ";;[" << update_regn << "] { // unary expression " << endl;      
		ofile << "$T [cr] $T [ca] //(split) unary operation" << endl;
		ofile << "}" << endl;

		__ConnectSplitProtocolPattern;

      		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
                if(flow_through)
		{
			ofile << "// flow-through" << endl;
			__J(__UST(this), __SCT(this));
		}

		if(pipeline_flag && !flow_through)
		{
			this->_rest->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements,ofile);
			// __MJ(this->_rest->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true );  // bypass
			__SelfReleaseSplitProtocolPattern
		}
		visited_elements.insert(this);
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

      		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

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
		__DeclTransSplitProtocolPattern;

		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

		this->_rest->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				barrier,
				ofile);


		if(!this->_rest->Is_Constant())
			__J(__SST(this),__UCT(this->_rest));

		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		ofile << ";;[" << sample_regn << "] { // unary expression " << endl;      
		ofile << "$T [rr] $T [ra] // (split) unary operation" << endl;
		ofile << "}" << endl;

		ofile << ";;[" << update_regn << "] { // unary expression " << endl;      
		ofile << "$T [cr] $T [ca] //(split) unary operation" << endl;
		ofile << "}" << endl;

		__ConnectSplitProtocolPattern;

      		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
                if(flow_through)
		{
			ofile << "// flow-through" << endl;
			__J(__UST(this), __SCT(this));
		}

		if(pipeline_flag && !flow_through)
		{
			this->_rest->Write_VC_Update_Reenables(this, __SCT(this), false,  visited_elements,ofile);
			// __MJ(this->_rest->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
			
			__SelfReleaseSplitProtocolPattern
		}
		visited_elements.insert(this);
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

		ofile << "// " << this->To_String() << endl;
		//bool add_hash = this->Is_Logical_Operation() && AaProgram::_optimize_flag && this->Is_Part_Of_Pipeline();
		bool add_hash = false; // turn it off.. operator way too heavy..
		if(add_hash)
		{
			this->Write_VC_Links_BLE_Optimized(hier_id, ofile);
			return;
		}

		this->_first->Write_VC_Links_Optimized(hier_id, ofile);
		this->_second->Write_VC_Links_Optimized(hier_id, ofile);


		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

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

void AaBinaryExpression::Write_VC_Links_BLE_Optimized(string hier_id, ostream& ofile)
{
	this->_first->Write_VC_Links_Optimized(hier_id, ofile);
	this->_second->Write_VC_Links_Optimized(hier_id, ofile);

	vector<AaExpression*> srcs;
	srcs.push_back(this->_first); srcs.push_back(this->_second);

	vector<string> reqs,acks;

	for(int i = 0; i < 2; i++)
	{
		AaExpression* src = srcs[i];
		if(!src->Is_Constant())
		{
			string sample_regn = this->Get_VC_Name() + "_sample_" + src->Get_VC_Name();
			string sample_hier_id = Augment_Hier_Id(hier_id,sample_regn);
			reqs.push_back(sample_hier_id + "/req");
			acks.push_back(sample_hier_id + "/ack");
		
		}
		else
		{
			string req_name = this->Get_VC_Name() + "_sample_" + src->Get_VC_Name() + "_req";
			string ack_name = this->Get_VC_Name() + "_sample_" + src->Get_VC_Name() + "_ack";
			reqs.push_back(hier_id + "/" + req_name);
			acks.push_back(hier_id + "/" + ack_name);
		}
	}

	string update_regn = this->Get_VC_Name() + "_Update";
	string update_hier_id = Augment_Hier_Id(hier_id,update_regn);

	reqs.push_back(update_hier_id + "/req");
	acks.push_back(update_hier_id + "/ack");

	Write_VC_Link(this->Get_VC_Datapath_Instance_Name(),reqs,acks,ofile);
}

// version for binary logical operation.
void AaBinaryExpression::Write_VC_Control_Path_BLE_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0); // DEAD CODE: TODO: get rid of it..
}


void AaBinaryExpression::Write_VC_Guard_Forward_Dependency(AaSimpleObjectReference* sexpr, set<AaRoot*>& visited_elements, ostream& ofile)
{
	this->AaExpression::Write_VC_Guard_Forward_Dependency(sexpr, visited_elements, ofile);
}

void AaBinaryExpression::Write_VC_Guard_Backward_Dependency(AaExpression* expr, set<AaRoot*>& visited_elements, ostream& ofile)
{
	//bool add_hash = this->Is_Logical_Operation() && AaProgram::_optimize_flag && this->Is_Part_Of_Pipeline();
	bool add_hash = false; // turn it off.. operator way too heavy..
	if(add_hash)
	{
		assert(0);
		__MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements),
			__UCT(this), expr->Update_Protocol_Has_Delay(visited_elements));  // bypass

		if(!this->_first->Is_Constant())
		{
			__MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT_I(this,0), expr->Update_Protocol_Has_Delay(visited_elements)); // bypass
		}
		if(!this->_second->Is_Constant())
		{
			__MJ(expr->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT_I(this,1), expr->Update_Protocol_Has_Delay(visited_elements)); // bypass
		}
	}
	else if(!(this->Is_Trivial() && this->Get_Is_Intermediate()))
	{
		this->AaExpression::Write_VC_Guard_Backward_Dependency(expr, visited_elements, ofile);
	}
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
		//bool add_hash = this->Is_Logical_Operation() && AaProgram::_optimize_flag && this->Is_Part_Of_Pipeline();
		bool add_hash = false; // turn it off.. operator way too heavy..
		if(add_hash)
		{
			// the completes of the two sources provide upto two triggers
			// to the binary expression.
			this->Write_VC_Control_Path_BLE_Optimized(pipeline_flag, visited_elements, ls_map, pipe_map, barrier,ofile);
			return;
		}


		__DeclTransSplitProtocolPattern;

		if(barrier != NULL)
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
		}

		this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		this->_first->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);
		this->_second->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);


		if(!this->_first->Is_Constant())
			__J(__SST(this),__UCT(this->_first));

		if(!this->_second->Is_Constant())
			__J(__SST(this),__UCT(this->_second));

		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

		ofile << ";;[" << sample_regn <<"] { // binary expression " << endl;
		ofile << "$T [rr] $T [ra]  // (split) binary operation " << endl;
		ofile << "}" << endl;

		ofile << ";;[" << update_regn << "] { // binary expression " << endl;
		ofile << "$T [cr] $T [ca] // (split) binary operation " << endl;
		ofile << "}" << endl;

		__ConnectSplitProtocolPattern;
      		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
		{
			ofile << "// flow-through" << endl;
			__J(__UST(this), __SCT(this));
		}
		if(pipeline_flag && !flow_through)
		{
			if(!this->_first->Is_Constant())
			{
				this->_first->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
				//__MJ(this->_first->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
			}

			if(!this->_second->Is_Constant())
			{	
				this->_second->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
				// __MJ(this->_second->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
			}

			__SelfReleaseSplitProtocolPattern
		}
		visited_elements.insert(this);
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


void AaTernaryExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->_test->Write_VC_Links_Optimized(hier_id,ofile);
		this->_if_true->Write_VC_Links_Optimized(hier_id,ofile);
		this->_if_false->Write_VC_Links_Optimized(hier_id,ofile);

		ofile << "// " << this->To_String() << endl;
		bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
		if(flow_through)
			return;

		string sample_regn = this->Get_VC_Start_Region_Name();
		string update_regn = this->Get_VC_Complete_Region_Name();
		vector<string> reqs,acks;
		reqs.push_back(hier_id + "/" + sample_regn + "/req");
		reqs.push_back(hier_id + "/" + update_regn + "/req");
		acks.push_back(hier_id + "/" + sample_regn + "/ack");
		acks.push_back(hier_id + "/" + update_regn + "/ack");

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
	__DeclTransSplitProtocolPattern;
	if(barrier != NULL)
	{
		ofile << "// barrier " << endl;
		__J(__SST(this),__UCT(barrier));
	}

	this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);

	if(this->_test)
		this->_test->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

	if(this->_if_true)
		this->_if_true->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

	if(this->_if_false)
		this->_if_false->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);


	if(!this->_test->Is_Constant())
		__J(__SST(this),__UCT(this->_test));
	if(this->_if_true && !this->_if_true->Is_Constant())
		__J(__SST(this),__UCT(this->_if_true));
	if(this->_if_false && !this->_if_false->Is_Constant())
		__J(__SST(this),__UCT(this->_if_false));

	ofile << ";;[" << this->Get_VC_Start_Region_Name() << "] { // ternary expression: " << endl;
	ofile << "$T [req] $T [ack] // sample req/ack" << endl;
	ofile << "}" << endl;
	ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // ternary expression: " << endl;
	ofile << "$T [req] $T [ack] // update req/ack" << endl;
	ofile << "}" << endl;

	__F(__SST(this),this->Get_VC_Start_Region_Name());
	__J(__SCT(this),this->Get_VC_Start_Region_Name());
	__F(__UST(this),this->Get_VC_Complete_Region_Name());
	__J(__UCT(this),this->Get_VC_Complete_Region_Name());

      	bool flow_through = (this->Is_Trivial() && this->Get_Is_Intermediate());
	if(flow_through)
	{
		ofile << "// flow-through" << endl;
		__J(__UST(this), __SCT(this));
	}
	else
	{
		__F(__SCT(this), "$null");
	}

	if(pipeline_flag && !flow_through)
	{

		if(!this->_test->Is_Constant())
		{
			this->_test->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
			 //__MJ(this->_test->Get_VC_Reenable_Update_Transition_Name(visited_elements),__UCT(this), true); // bypass
		}
		if(this->_if_true && !this->_if_true->Is_Constant())
		{
			this->_if_true->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
			//__MJ(this->_if_true->Get_VC_Reenable_Update_Transition_Name(visited_elements),__UCT(this), true); // bypass
		}
		if(this->_if_false && !this->_if_false->Is_Constant())
		{
			this->_if_false->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
			//__MJ(this->_if_false->Get_VC_Reenable_Update_Transition_Name(visited_elements),__UCT(this), true); // bypass
		}
		
		__SelfReleaseSplitProtocolPattern
		
	}
	visited_elements.insert(this);
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
	set<string> active_reenables;
	map<string,bool> active_reenable_bypass_flags;
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
			active_reenables,
			active_reenable_bypass_flags,
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
	__J(__SST(this),this->Get_VC_Name() + "_word_address_calculated");

	if(pipeline_flag)
	{
		string at = __SCT(this);
		ofile << "// reenable-joins" << endl;
 		Write_VC_Reenable_Joins(active_reenables, active_reenable_bypass_flags, at,false, ofile); // do not force bypass, decide based on active bypass flags
	}
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
	set<string> active_reenables;
	map<string,bool> active_reenable_bypass_flags;

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
			active_reenables,
			active_reenable_bypass_flags,
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

	__J(__SST(this),this->Get_VC_Name() + "_word_address_calculated");
	if(pipeline_flag)
	{
		string at = __SCT(this);

		ofile << "// reenable-joins" << endl;
 		Write_VC_Reenable_Joins(active_reenables, active_reenable_bypass_flags,  at,false, ofile); // do not force bypass, decide based on active bypass flags..
	}
}

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
      	string sample_regn = this->Get_VC_Name() + "_Sample";
      	string update_regn = this->Get_VC_Name() + "_Update";

	// in parallel access the words.
	// how many words?
	int nwords = (address_expressions ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));

	ofile << ";;[" << sample_regn << "] {" << endl;
	if(read_or_write == "write")
	{
      		string split_regn = this->Get_VC_Name() + "_Split";
		ofile << ";;[" << split_regn << "] {" << endl;
		// split the data into words..
		ofile << "$T [split_req] $T [split_ack]" << endl;
		ofile << "}" << endl;
	}
	ofile << "||[word_access_start] {" << endl;
	for(int idx = 0; idx < nwords; idx++)
	{
		// each word access.
		ofile << ";;[word_" << idx << "] {" << endl
			<< "$T [rr] $T [ra] " << endl
			<< "}" << endl;
	}
	ofile << "}" << endl;
	ofile << "}" << endl;

	ofile << ";;[" << update_regn << "] {" << endl;
	ofile << "||[word_access_complete] {" << endl;
	for(int idx = 0; idx < nwords; idx++)
	{
		// each word access.
		ofile << ";;[word_" << idx << "] {" << endl
			<< "$T [cr] $T [ca] " << endl
			<< "}" << endl;
	}
	ofile << "}" << endl;
	if(read_or_write == "read")
	{
      		string merge_regn = this->Get_VC_Name() + "_Merge";
		ofile << ";;[" << merge_regn << "] {" << endl;
		// merge the words into the data..
		ofile << "$T [merge_req] $T [merge_ack]" << endl;
		ofile << "}" << endl;
	}
	ofile << "}" << endl;

	// note: all higher level connections handled by
	//       users of this routine.
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

      	string sample_regn = this->Get_VC_Name() + "_Sample";
      	string update_regn = this->Get_VC_Name() + "_Update";
	string start_hier_id = Augment_Hier_Id(hier_id, sample_regn);
	string complete_hier_id = Augment_Hier_Id(hier_id, update_regn);

	// if read, then merge
	string ms_instance = this->Get_VC_Name() + "_gather_scatter";
	if(read_or_write == "read")
	{
      		string merge_regn = this->Get_VC_Name() + "_Merge";
		reqs.push_back(complete_hier_id + "/" + merge_regn + "/merge_req");
		acks.push_back(complete_hier_id + "/" + merge_regn + "/merge_ack");

	}
	else
	{
      		string split_regn = this->Get_VC_Name() + "_Split";
		reqs.push_back(start_hier_id + "/" + split_regn + "/split_req");
		acks.push_back(start_hier_id + "/" + split_regn + "/split_ack");
	}
	Write_VC_Link(ms_instance,reqs,acks, ofile);
	reqs.clear();
	acks.clear();

	// in parallel access the words.
	string start_word_access_hier_id = Augment_Hier_Id(start_hier_id, "word_access_start");
	string complete_word_access_hier_id = Augment_Hier_Id(complete_hier_id, "word_access_complete");

	for(int idx = 0; idx < (this->Get_Type()->Size() / this->Get_Word_Size()); idx++)
	{
		// each word access.
		string start_id = Augment_Hier_Id(start_word_access_hier_id , "word_" + IntToStr(idx));
		reqs.push_back(start_id + "/rr");
		acks.push_back(start_id + "/ra");

		string complete_id = Augment_Hier_Id(complete_word_access_hier_id , "word_" + IntToStr(idx));
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
		set<string>& active_reenable_points,
		map<string, bool>& active_reenable_bypass_flags,
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
		this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				indices,
				scale_factors,
				shift_factors,
				active_reenable_points,
				active_reenable_bypass_flags,
				barrier,
				ofile);


		// individual word addresses (in parallel)
		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
		bool reg_flag = false;
		if(nwords > 1)
		{
			reg_flag = true;
			string sample_start = word_region + "_sample_start";
			string sample_complete = word_region + "_sample_complete";
			string update_start = word_region + "_update_start";
			string update_complete = word_region + "_update_complete";

			__T(sample_start)
			__T(sample_complete)
			__T(update_start)
			__T(update_complete)

			__F(root_addr_calculated, sample_start)
			__J(word_addr_calculated, update_complete)

			for(int idx = 0; idx < nwords; idx++)
			{
				// each word address is a sum
				string sample_regn = word_region + "_" + IntToStr(idx) + "_Sample";
				string update_regn = word_region + "_" + IntToStr(idx) + "_Update";
				ofile << ";;[" << sample_regn << "] {" << endl
					<< "$T [rr] $T [ra]" << endl
					<< "}" << endl;
				ofile << ";;[" << update_regn << "] {" << endl
					<< "$T [cr] $T [ca]" << endl
					<< "}" << endl;
				__F(sample_start, sample_regn)
				__F(update_start, update_regn)
				__J(sample_complete, sample_regn)
				__J(update_complete, update_regn)
			}

			if(pipeline_flag)
			{
				// self-release..
				__MJ(sample_start, sample_complete, false) // no bypass
				__MJ(update_start, update_complete, true)  // bypass

				Write_VC_Reenable_Joins(active_reenable_points, active_reenable_bypass_flags,  word_addr_calculated, false,  ofile); // do not force bypass, decide based on active bypass flags.
				active_reenable_points.clear();
				active_reenable_points.insert(update_start);
				active_reenable_bypass_flags[update_start] =  true;
			}
		}
		else
		{
			// single word, no operation.. just rename it!
			ofile << ";;[" << word_region << "] {" << endl;
			ofile << "$T [root_register_req] $T [root_register_ack]" << endl;
			ofile << "}" << endl;
			__F(root_addr_calculated, word_region);
			__J(word_addr_calculated, word_region);
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

		// individual word addresses (in parallel)
		int nwords = (indices ? scale_factors->back() : (this->Get_Type()->Size() / this->Get_Word_Size()));
		if(nwords > 1)
		{
			for(int idx = 0; idx < nwords; idx++)
			{
				string sample_regn = hier_id + "/" + 
						word_region + "_" + IntToStr(idx) + "_Sample";
				string update_regn = hier_id + "/" + 
						word_region + "_" + IntToStr(idx) + "_Update";
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
			reqs.push_back(hier_id + "/" + word_region + "/root_register_req");
			acks.push_back(hier_id + "/" + word_region + "/root_register_ack");
			Write_VC_Link(this->Get_VC_Name() + "_addr_0",
					reqs,
					acks,
					ofile);
			reqs.clear();
			acks.clear();
		}
	}

}

// when this expression is trivial, reenables to it have to be
// targeted to the root sources.
void AaExpression:: Update_Reenable_Points_And_Producer_Delay_Status(set<string>& en_points, 
									map<string,bool>& en_bypass_flags,
										set<AaRoot*>& visited_elements)
{
	set<AaRoot*> root_expr_set;
	this->Collect_Root_Sources(root_expr_set);

	for(set<AaRoot*>::iterator iter = root_expr_set.begin();
			iter != root_expr_set.end(); iter++)
	{
		if((*iter)->Is_Expression())
		{
			AaExpression* root_expr = (AaExpression*) *iter;
			if(visited_elements.find(root_expr) != visited_elements.end())
			{
				if((this->Get_Associated_Phi_Statement() == NULL) || 
						(root_expr->Get_Associated_Phi_Statement() != 
						 this->Get_Associated_Phi_Statement()))
				{
					string en_trans_name = root_expr->Get_VC_Reenable_Update_Transition_Name(visited_elements);	
					en_points.insert(en_trans_name);

					bool en_bypass = root_expr->Update_Protocol_Has_Delay(visited_elements);
					en_bypass_flags[en_trans_name] =  en_bypass;
				}
			}
		}
	}	
}



// all operations are triggered immediately when the containing
// fork-block is entered.  dependencies as indicated..
// always produces a transition root_address_calculated.
//
// need to be careful in the reenables.  
//
void AaObjectReference::
Write_VC_Root_Address_Calculation_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<string,vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		vector<AaExpression*>* index_vector,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		set<string>& active_reenable_points,
		map<string,bool>& active_reenable_bypass_flags,
		AaRoot* barrier,
		ostream& ofile)
{


	string root_address_calculated = this->Get_VC_Name() + "_root_address_calculated";
	__T(root_address_calculated);

	int offset_val = 0;
	if(index_vector)
		offset_val = this->Evaluate(index_vector,scale_factors, shift_factors);
	int base_addr = this->Get_Base_Address();


	// if both are constants.. give up.
	if(offset_val >= 0 && base_addr >= 0)
		return;

	string base_addr_update_reenable = 
		this->Get_VC_Base_Address_Update_Reenable_Transition(visited_elements);
	bool base_addr_update_reenable_bypass = this->Base_Address_Update_Protocol_Has_Delay(visited_elements);
	if(pipeline_flag)
	{
		if(base_addr < 0)
		{
			active_reenable_points.insert(base_addr_update_reenable);
			active_reenable_bypass_flags[base_addr_update_reenable] =  base_addr_update_reenable_bypass;
		}
	}

	bool all_indices_zero = (offset_val == 0);
	int num_non_constant = 0;
	bool const_index_flag = false;
	bool reg_flag = false;


	vector<int> non_constant_indices;

	string index_sum_calculated = this->Get_VC_Name() + "_index_sum_calculated";
	string offset_calculated = this->Get_VC_Name() + "_offset_calculated";
	string base_address_resized = this->Get_VC_Name() + "_base_address_resized";

	string base_address_calculated = this->Get_VC_Name() + "_base_address_calculated";

	map<int,set<string> > index_chain_reenable_map;
	map<int,string> index_chain_complete_map;

	// if offset value is < 0, then it is not known at compile time.
	// calculate it at run time.
	if(offset_val < 0)
	{
		__T(offset_calculated);

		for(int idx = 0; idx < index_vector->size(); idx++)
		{
			AaExpression* index_expr = (*index_vector)[idx];

			// if the index is a constant dont bother to compute it..
			//
			if(!index_expr->Is_Constant())
			{
				non_constant_indices.push_back(idx);

			        string idx_active_reenable;
				string idx_active_complete;

				string index_resized = this->Get_VC_Name() + "_index_resized_" + IntToStr(idx);
				string index_scaled = this->Get_VC_Name() + "_index_scaled_" + IntToStr(idx);
				__T(index_resized);
				__T(index_scaled);

				num_non_constant++;
				index_expr->Write_VC_Control_Path_Optimized(pipeline_flag, 
						visited_elements,
						ls_map,pipe_map,barrier,
						ofile);


				if(pipeline_flag)
				{
					index_expr->Update_Reenable_Points_And_Producer_Delay_Status(index_chain_reenable_map[idx], 
													active_reenable_bypass_flags,
															visited_elements);
				}
				index_chain_complete_map[idx] = __UCT(index_expr);


				
				string idx_resize_regn_name = this->Get_VC_Name() + "_index_resize_" + 
								IntToStr(idx);

				if(index_expr->Get_Type()->Is_Uinteger_Type())
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
						for(set<string>::iterator iiter = index_chain_reenable_map[idx].begin(), 
							fiiter = index_chain_reenable_map[idx].end();
							iiter != fiiter; iiter++)
						{
							// reenable index expression update when
							// sample-completed.
							string jj = *iiter;
							__MJ(jj, idx_resize_sample_complete, true);  // bypass
						}
						index_chain_reenable_map[idx].clear();
						index_chain_reenable_map[idx].insert(idx_resize_update_start);

						// self-release. 
						__MJ(idx_resize_sample_start, idx_resize_sample_complete, false); // no bypass
						__MJ(idx_resize_update_start, idx_resize_update_complete, true); // bypass
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

					ofile << ";;[" << idx_scale_sample_regn << "] { " << endl;
					ofile << "$T [rr] $T [ra] " << endl;
					ofile << "}" << endl;
					ofile << ";;[" << idx_scale_update_regn << "] { " << endl;
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
						for(set<string>::iterator iiter = index_chain_reenable_map[idx].begin(), 
							fiiter = index_chain_reenable_map[idx].end();
							iiter != fiiter; iiter++)
						{
							string jj = *iiter;
							// reenable index expression update when
							// sample-completed.
							__MJ(jj, index_scaled, true);  // bypass
						}
						index_chain_reenable_map[idx].clear();
						index_chain_reenable_map[idx].insert(index_scaled);

						// self-release.. 
						__MJ(idx_scale_sample_start, idx_scale_sample_complete, false); // bypass
						__MJ(idx_scale_update_start, idx_scale_update_complete, true); // bypass
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
		
		// then add them up.. Note that if there is one non-constant
		// and at least one constant, then an adder will still be needed.
		int num_index_adds = (num_non_constant  - 1);

		assert(non_constant_indices.size() > 0);

		string last_sum_complete = index_chain_complete_map[non_constant_indices[0]];
		string last_sum_reenable = "";

		if(num_index_adds > 0)
		{
			for(int idx = 1; idx <= num_index_adds; idx++)
			{
				reg_flag = true;
				string prefix = this->Get_VC_Name() + "_partial_sum_" + IntToStr(idx);

				string sample_start = prefix + "_sample_start";
				string sample_complete = prefix + "_sample_complete";
				string update_start = prefix + "_update_start";
				string update_complete = prefix + "_update_complete";

				__T(sample_start);
				__T(sample_complete);
				__T(update_start);
				__T(update_complete);

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
					// self-release. aggressive
					__MJ(sample_start, sample_complete,false);  // no bypass
					__MJ(update_start, update_complete,true);   // bypass
				}

				if(idx == 1)
				{
					int I0 = non_constant_indices[idx-1];
					int I1 = non_constant_indices[idx];

					__J(sample_start, index_chain_complete_map[I0]);
					__J(sample_start, index_chain_complete_map[I1]);
				

					if(pipeline_flag)
					{
						Write_VC_Marked_Joins(index_chain_reenable_map[I0], sample_complete, false, ofile);
						Write_VC_Marked_Joins(index_chain_reenable_map[I1], sample_complete, false, ofile);
						index_chain_reenable_map[I0].clear();
						index_chain_reenable_map[I1].clear();
					}
				}
				else
				{
					int I1 = non_constant_indices[idx];
					__J(sample_start, index_chain_complete_map[I1]);
					__J(sample_start, last_sum_complete);
					if(pipeline_flag)
					{	
						Write_VC_Marked_Joins(index_chain_reenable_map[I1], sample_complete, true, ofile);
						index_chain_reenable_map[I1].clear();
						if(last_sum_reenable != "")
							__MJ(last_sum_reenable, update_complete, false);
					}
				}


				if(idx == num_index_adds)
				{
					__J(offset_calculated, update_complete);
				}

				last_sum_complete =  update_complete;
				last_sum_reenable =  update_start;

				active_reenable_points.clear();
				active_reenable_points.insert(last_sum_reenable);
				active_reenable_bypass_flags[last_sum_reenable] = true;
			}

		}

		// active reenables from index-chains.
		for(int IIDX = 0, FIIDX = index_vector->size(); IIDX < FIIDX; IIDX++)
                {
			for(set<string>::iterator iiter = index_chain_reenable_map[IIDX].begin(),
				fiiter = index_chain_reenable_map[IIDX].end(); iiter != fiiter; iiter++)
			{
				active_reenable_points.insert(*iiter);
				active_reenable_bypass_flags[*iiter] =true;
			}
                }

		// index addition..
		if(const_index_flag)
		{
			// add the constant index sum to the non-constant
			// index sum.
			string prefix = this->Get_VC_Name() + "_final_index_sum_regn";
 			string sample_complete = prefix + "_sample_complete";
 			string update_start = prefix + "_update_start";

			__T(sample_complete);
			__T(update_start);
			

 			string sample_regn = prefix + "_Sample";
 			string update_regn = prefix + "_Update";
			ofile << ";;[" <<  sample_regn << "] { " << endl;
			ofile << " $T [req] $T [ack] " << endl;
			ofile << "}" << endl;
			ofile << ";;[" <<  update_regn << "] { " << endl;
			ofile << " $T [req] $T [ack] " << endl;
			ofile << "}" << endl;

			__F(last_sum_complete, sample_regn);
			__J(sample_complete, sample_regn);

			__F(update_start, update_regn);
			__J(offset_calculated, update_regn);

			if(pipeline_flag)
			{
				Write_VC_Marked_Joins(active_reenable_points, sample_complete, false, ofile);
				__MJ(update_start, offset_calculated, true); // bypass.
			}
		
			active_reenable_points.clear();
			active_reenable_points.insert(update_start);
			active_reenable_bypass_flags[update_start] = true;
		}
		else
		{
			// the final index sum.. 
			string non_constant_index_sum_regn = this->Get_VC_Name() + "_final_index_sum_regn";
			ofile << ";;[" <<  non_constant_index_sum_regn << "] {" << endl;
			ofile << "$T [req] $T [ack] // rename" << endl;
			ofile << "}" << endl;
			__F(last_sum_complete, non_constant_index_sum_regn);
			__J(offset_calculated, non_constant_index_sum_regn);
		}
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
		  __MJ(bpo_sample_start, bpo_sample_complete, false); // no bypass
		  __MJ(bpo_update_start, bpo_update_complete, true); // bypass

		  Write_VC_Reenable_Joins(active_reenable_points, active_reenable_bypass_flags, bpo_sample_complete,false,  ofile); // do not force bypass, decide based on active bypass flags..
		  
		  active_reenable_points.clear();
		  active_reenable_points.insert(bpo_update_start);
		  active_reenable_bypass_flags[bpo_update_start] = true;
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
		int num_index_adds = (num_non_constant - 1);
		if(num_index_adds > 0)
		{
			for(int idx = 1; idx <= num_index_adds; idx++)
			{
				string prefix = this->Get_VC_Name() + "_partial_sum_" + IntToStr(idx);
				string sample_regn = prefix + "_Sample";
				string update_regn = prefix + "_Update";
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

		if(const_index_flag)
		{
			string prefix = this->Get_VC_Name() + "_final_index_sum_regn";
 			string sample_regn = prefix + "_Sample";
 			string update_regn = prefix + "_Update";

			inst_name = this->Get_VC_Name() + "_index_offset";

			reqs.push_back(hier_id + "/" + sample_regn + "/req");
			reqs.push_back(hier_id + "/" + update_regn + "/req");

			acks.push_back(hier_id + "/" + sample_regn + "/ack");
			acks.push_back(hier_id + "/" + update_regn + "/ack");

			Write_VC_Link(inst_name,reqs,acks,ofile);

			reqs.clear();
			acks.clear();
		}
		else
		{
			// the final index..
			string non_constant_index_sum_regn = this->Get_VC_Name() + "_final_index_sum_regn";
			reqs.push_back(hier_id + "/" + non_constant_index_sum_regn + "/req");
			acks.push_back(hier_id + "/" + non_constant_index_sum_regn + "/ack");
			inst_name = this->Get_VC_Name() + "_index_offset";
			Write_VC_Link(inst_name,reqs,acks,ofile);
			reqs.clear();
			acks.clear();
		}
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








