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


// Write dependency from phi-sequencer to start this expression's evaluation.
void AaExpression::Write_VC_Phi_Start_Dependency(ostream& ofile)
{
	if(!this->Is_Flow_Through() && !this->Get_Is_Target())
	{
		AaPhiStatement* phi = this->Get_Associated_Phi_Statement();
		if((phi != NULL) && !phi->Is_Single_Source())
		{
			ofile << "// Phi start dependency" << endl;
			int src_index = this->Get_Phi_Source_Index();
			assert(src_index >= 0);
			AaExpression* source_expr = phi->Get_Source_Expression(src_index);

			string strig_name = __SST(source_expr) + "_ps";
			__J(__SST(this), strig_name);

			string utrig_name = __UST(source_expr) + "_ps";
			__J(__UST(this), utrig_name);
		}
	}
}

//
// From this expression, write forward dependencies to dependent_transition.
// Look for root expressions of this and add UCT->dependent_transition links.
// 
void AaExpression::Write_Forward_Dependency_From_Roots(string dependent_transition, 
		int64_t to_index, 
		set<AaRoot*>& visited_elements, ostream& ofile)
{

	bool this_is_in_phi = (this->Get_Associated_Statement() != NULL)
					&& this->Get_Associated_Statement()->Is_Phi_Statement();

	ofile << "// start: Forward dependencies from " << this->To_String() 
		<< " to transition " << dependent_transition << endl;

	// special case.. signal read
	if(this->Is_Signal_Read() && !this_is_in_phi)
	{
		ofile << "// special case... expr is signal read, which does not involve control.." << endl;
		//__J(dependent_transition, __UCT(this));
		return;
	}

	set<AaRoot*> root_sources;
	this->Collect_Root_Sources(root_sources);

	//
	// If this expression depends only on signals and constants, the root source set 
	// will be empty..   while this expression may still have control structures present
	// in the virtual circuit.
	//
	//
	if(root_sources.size() == 0)
	{
		AaRoot::Warning("Looks like you have an expression which depends only on signals/constants..", 
						this);
		ofile << "// non-constant expression which depends only on signals/constants?" << endl; 
	}
	else
	{
		for(set<AaRoot*>::iterator iter = root_sources.begin(), fiter = root_sources.end();
				iter != fiter; iter++)
		{
			AaRoot* pred = *iter;

			if(visited_elements.find(pred) != visited_elements.end())
			{
				bool pred_is_in_phi = false;
				if(pred->Is_Expression())
				{
					AaExpression* pred_expr = (AaExpression*) pred;

					pred_is_in_phi = (pred_expr->Get_Associated_Statement() != NULL)
						&& pred_expr->Get_Associated_Statement()->Is_Phi_Statement();
				}
				else if(pred->Is_Statement())
				{
					pred_is_in_phi = ((AaStatement*)pred)->Is_Phi_Statement();
				}

				if(!(this_is_in_phi && pred_is_in_phi && !pred->Is_Expression())) 
					// No PHI-PHI dependencies!
				{
					if((to_index > 0) && (pred->Get_Index() > to_index))
					{
						AaRoot::Error("incorrect ordering of forward dependency for " + this->To_String() + 
								" (from " + pred->To_String() + ")", this);
					}
					else 
					{
						if(pred->Is_Expression())
						{
							AaExpression* expr = ((AaExpression*) pred);
							if(!expr->Is_Interface_Object_Reference())
								//
								// interface object references may be
								// included in the root object set.
								// But these do not have any control transitions.
								//
							{
								__J(dependent_transition,__UCT(pred));
							}
							else
							{
								ofile << "// Forward dependency from interface-object-ref omitted ("
									<< expr->To_String() << ")" << endl;
							}
						}
						else
						{
							__J(dependent_transition,__UCT(pred));
						}
					}
				}
				else
				{
					ofile << "// Forward dependency from PHI->PHI omitted" << endl;
				}
			}
		}
	}
	ofile << "// done: Forward dependencies from " << this->To_String() 
		<< " to transition " << dependent_transition << endl;
}

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

	bool this_depends_on_phi =
		reenabling_agent->Is_Phi_Statement() || (this->Get_Associated_Phi_Statement() != NULL);

	ofile << "// RAW reenables for " << this->To_String() << endl;
	for(set<AaRoot*>::iterator iter = root_set.begin(), fiter = root_set.end(); iter != fiter; iter++)
	{
		AaRoot* producer = *iter;
		bool producer_is_dependent_on_phi =
			producer->Is_Phi_Statement() ||
			(producer->Is_Expression() && 
			 (((AaExpression*)producer)->Get_Associated_Phi_Statement() != NULL));
		if(visited_elements.find(producer) != visited_elements.end())
		{

			if(!(this_depends_on_phi && producer_is_dependent_on_phi))
				//
				// No Phi->Phi dependencies.
				//
			{
				__MJ(producer->Get_VC_Reenable_Update_Transition_Name(visited_elements), ctrans, bypass_if_true);
			}
			else
			{
				ofile << "// producer  and  consumer are both determined by PHI statements." << endl;
			}

			// 
			// if producer is part of operator module, and if producer is
			// a simple-object-reference to an input interface object, then 
			// we create an unmarked link to an update-enable.
			// 
			if(producer->Is_Interface_Object())
			{
				AaInterfaceObject* iobj = (AaInterfaceObject*) producer;
				if(iobj->Get_Mode() == "in")
				{
					string utrans = 
						iobj->Get_VC_Unmarked_Reenable_Update_Transition_Name(visited_elements);
					if(utrans != "$null")
						__J(utrans, ctrans);
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
//   Subtlety: what if b := (d+e) is volatile?
//   Then, we look at the root sources of b..
//
void AaExpression::Write_VC_WAR_Dependencies(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		ostream& ofile)
{

	ofile << "// start: WAR dependencies for " << this->To_String() << endl;
	if(!this->Is_Implicit_Variable_Reference())
		return;

	set<AaRoot*> root_sources_of_this;
	this->Collect_Root_Sources(root_sources_of_this);

	AaStatement* write_stmt = this->Get_Associated_Statement();
	assert(write_stmt != NULL); // this is always a target..  so statement completion should retrigger read.

	bool full_rate = write_stmt->Is_Part_Of_Fullrate_Pipeline();
	bool err_flag = false;

	// root will be the statement b = (d+e) (or possibly a $call foo () (b))
	AaRoot* root = this->Get_Root_Object();
	if((root == NULL) || root->Is_Statement() || !root->Is_Interface_Object())
	{
		// statement is a root object, but source referencing is done
		// through the target object reference...
		root = this;
	}



	// expressions/statements in which root is used as a source..
	// these include expression "b" in (b+c)
	set<AaRoot*> read_root_set;
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
				read_expr->Get_Non_Trivial_Source_References(read_root_set, visited_elements);
			}
		}
	}

	for(set<AaRoot*>::iterator w_iter = root_sources_of_this.begin(), fw_iter = root_sources_of_this.end();
			w_iter != fw_iter; w_iter++)
	{
		AaRoot* w_root = *w_iter;
		bool write_is_dependent_on_phi = 
			(w_root->Is_Phi_Statement() || (w_root->Is_Expression() && 
							(((AaExpression*)w_root)->Get_Associated_Statement() != NULL) &&
							((AaExpression*)w_root)->Get_Associated_Statement()->Is_Phi_Statement()));

		// ignore out of scope dependencies.
		bool ignore_w_root = (w_root == NULL) || (visited_elements.find(w_root) == visited_elements.end());

		if(ignore_w_root)
		{
			if(w_root != NULL)
				ofile << "// ignored out-of-scope w_root " << w_root->To_String() << endl;
			continue;
		}


		// root not to be ignored.
		for(set<AaRoot*>::iterator r_iter = read_root_set.begin(),
				fr_iter = read_root_set.end(); r_iter != fr_iter; r_iter++)
		{
			AaRoot* r_root = *r_iter;
			bool read_is_dependent_on_phi = 
				(r_root->Is_Phi_Statement() || (r_root->Is_Expression() && 
								(((AaExpression*)r_root)->Get_Associated_Statement() != NULL) &&
								((AaExpression*)r_root)->Get_Associated_Statement()->Is_Phi_Statement()));
			AaPhiStatement* r_phi =
				(r_root->Is_Phi_Statement()  ? ((AaPhiStatement*) r_root) : 
				 ((r_root->Is_Expression() ?
				   ((AaExpression*)r_root)->Get_Associated_Phi_Statement() : NULL)));

			if(visited_elements.find(r_root) == visited_elements.end())
				continue;


			int r_index;
			bool w_root_is_double_buffered = false;
			if(r_root->Is_Expression())
			{
				AaStatement* rs = ((AaExpression*)r_root)->Get_Associated_Statement();
				if(rs != NULL)
					r_index = rs->Get_Index();
				else
					r_index = r_root->Get_Index();
			}
			else
				r_index = r_root->Get_Index();

			int w_index;
			if(w_root->Is_Expression())
			{
				AaStatement* ws = ((AaExpression*)w_root)->Get_Associated_Statement();

				if(ws != NULL)
				{
					w_index = ws->Get_Index();
					if(ws->Is("AaAssignmentStatement"))
					{
						w_root_is_double_buffered =
							(((AaAssignmentStatement*)ws)->Get_Target()->Get_Buffering() > 1);
					}
				}
				else
					w_index = w_root->Get_Index();
			}
			else
				w_index = w_root->Get_Index();

			// The target "b = (d+e)" cannot be updated until 
			// the statement a := (b+c) has sampled b..  
			// This is conservative
			if(!(read_is_dependent_on_phi && write_is_dependent_on_phi))
				//
				// Note: phi-phi WAR dependencies are taken care of through
				//         aggregated-phi symbols.  See 
				// void AaDoWhileStatement::Write_VC_Control_Path(bool optimize_flag, ostream& ofile)
				//
			{
				if(r_phi == NULL)
				{ // WAR across two non-PHI statements.

					if(r_index <= w_index)
					{

						string w_sct = __SCT(w_root);
						string r_sct = __SCT(r_root);


						// Aggressive timing and use of registers implies that
						// this dependency must be delayed in order to prevent
						// combinational cycles.        
						//
						// THIS DELAY IS REQUIRED TO PREVENT COMBINATIONAL LOOPS
						//
						// 
						//  no_additional_dependencies is set if the WAR is across the same
						//  statement, and there is unit buffering, and w_root is an 
						//  assignment statement.  In this case, there is no need to 
						//  put in a new dependency.
						//
						//    For example   a := (a + 1)
						//
						//  The r_root and w_root are the same, and the buffering is 1, hence
						//  fused.
						//
						//  WARNING, if the buffering is modified at a later stage, this assumption
						//  will not hold..  TODO: put NOTOUCH on this
						//
						//
						bool no_additional_dependencies = ((w_sct == r_sct) && (w_root->Get_Buffering() == 1));
						
						// If we add dependencies, we must have double buffering..
						bool add_double_buffering = !no_additional_dependencies;


						bool added_forward_dependency = false;	
						bool dependency_without_delay = this->Is_Part_Of_Fullrate_Pipeline() || add_double_buffering;

						if(!no_additional_dependencies)
						{
							if(dependency_without_delay)
							{
								__J(__UST(w_root), __SCT(r_root));
							}
							else
							{
								string delay_trans_name = 
									__SCT(r_root) + "_delay_to_" + __UST(w_root) + "_for_" + 
									this->Get_VC_Name();
								ofile << "$T [" << delay_trans_name << "] $delay" << endl;
								__J(delay_trans_name, __SCT(r_root));
								__J(__UST(w_root), delay_trans_name);
							}

							added_forward_dependency = true;
						}
						else
						{
							ofile << "// no additional dependencies for simple assignment with single buffering" << endl;
						}

						if(pipeline_flag and added_forward_dependency)
						{
							// The completion of "b = (d+e)" reenables the
							// evaluation of "a = (b+c)"
							ofile << "// WAR dependency: release  Read: " << this->To_String() 
								<< " with Write: " << w_root->To_String() << endl;
							__MJ(__SST(r_root), __UCT(w_root), true);
						}

						// also, a dependency from sct to ust is added from r-root
						// to w-root.  This can cause a dead-lock unless the
						// operator is double-buffered.
						if(add_double_buffering)
						{
							int rb = w_root->Get_Buffering();
							if(rb < 2)
							{
								ofile << "// added double buffering for w-root" << endl;
								w_root->Set_Buffering(2);
							}
						}
					}
					else
					{
						AaRoot::Error("ordering error in WAR for " + this->To_String() + " writer:" + w_root->To_String() + " reader:" + r_root->To_String(), this);
					}
				}
				else  // WAR across PHI and another statement...
				{
					bool bypass_flag = this->Is_Part_Of_Fullrate_Pipeline();
					//
					// Double buffering is required to prevent combinational
					// cycle here.  This prevents an UST -> SCT path
					// in the control logic.
					//
					if(bypass_flag)
					{
						__J(__UST(w_root), __SCT(r_phi));
					}
					else
					{
						string delay_trans_name = 
							__SCT(r_phi) + "_delay_to_" + __UST(w_root) + "_for_" + 
							this->Get_VC_Name();
						ofile << "$T [" << delay_trans_name << "] $delay" << endl;
						__J(delay_trans_name, __SCT(r_phi));
						__J(__UST(w_root), delay_trans_name);
					}

					if(pipeline_flag)
					{		
						// The completion of "b = (d+e)" reenables the
						// evaluation of "a = (b+c)"
						__MJ(__SST(r_phi), __UCT(w_root), true);
						ofile << "// WAR dependency: release  Read: " << this->To_String() << " with Write: " << w_root->To_String() << endl;
					}

					int rb = w_root->Get_Buffering();
					if(rb < 2)
					{
						w_root->Set_Buffering(2);
					}
				}

				if(pipeline_flag)
				{
					if(r_phi == NULL)
					{
						if(r_root != w_root)
						{
							AaModule* rsm = this->Get_Module();
							if((rsm != NULL)  && rsm->Get_Pipeline_Deterministic_Flag())
							{
								AaRoot::Error ("non-accumulative WAR dependency in deterministic pipeline not permitted.", this);
							}
						}
					}
				}
			}
			else
			{
				ofile << "//  WAR  PHI-PHI dependency ignored..." << endl;
			}
		}
	}
	ofile << "// done: WAR dependencies for " << this->To_String() << endl;
}

//
// from guard expression guard_expr to this.
//
void AaExpression::Write_VC_Guard_Forward_Dependency(AaRoot* guard_expr_root, set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(visited_elements.find(guard_expr_root) != visited_elements.end())
	{
		if((this->Get_Associated_Phi_Statement() == NULL) || !guard_expr_root->Is_Phi_Statement())
		{
			// No Phi-Phi dependencies
			__J(__SST(this), __UCT(guard_expr_root));

			// Note: with new SplitGuardInterface
			// this dependency is no longer necessary.
			//__J(__UST(this), __UCT(root));
		}
	}
	else
	{
		ofile << "// root " << guard_expr_root->Get_VC_Name() << " of guard-expression not in visited elements." << endl;
	}
}


void AaExpression::Write_VC_Guard_Backward_Dependency(AaExpression* guard_expr,
		set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(this->Get_Is_Target() || !(this->Is_Trivial() && this->Get_Is_Intermediate()))
	{
		// when this completes, the guard can be re-evaluated.
		guard_expr->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
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
				set<AaRoot*> root_sources;
				expr->Collect_Root_Sources(root_sources);

				for(set<AaRoot*>::iterator iter = root_sources.begin(), fiter = root_sources.end();
						iter != fiter; iter++)
				{
					AaRoot* pred = *iter;
					this->Write_VC_Guard_Forward_Dependency(pred,visited_elements,ofile);
				}
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
	if(!this->Is_Constant())
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		this->Check_Volatile_Inconsistency();
		ofile << "// " << this->To_String() << endl;
		if(this->_object->Is("AaStorageObject"))
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

			AaMemorySpace* ms = this->Get_VC_Memory_Space();
			assert(ms != NULL);
			ls_map[ms].push_back(this);

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
			if(!this->Is_Signal_Read())
			{
				__DeclTransSplitProtocolPattern;

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

				// for simplifying the guard interface, we treat this
				// as a special case (since sr->sa an empty operation for an
				// input pipe).
				__ConnectChainedSplitProtocolPattern;

				// record the pipe!  Introduce pipe related dependencies 
				// later. 
				pipe_map[(AaPipeObject*) (this->_object)].push_back(this);

				if(pipeline_flag && !this->_object->Is_Signal())
				{
					//
					// Close the ring.
					// 
					__MJ (__SST(this), __UCT(this),true); // bypass
					//__SelfReleaseSplitProtocolPattern
				}
			}
		}

		// at the end!
		visited_elements.insert(this);

		this->Write_VC_Phi_Start_Dependency(ofile);
	}
}

void AaSimpleObjectReference::Write_VC_Pipelined_Module_Enable_Joins(set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(this->_object->Is_Interface_Object())
	{
		ofile << "// " << this->To_String() << endl << "// write to interface object" << endl;
		bool pm = this->Is_Part_Of_Pipelined_Module();
		if(pm)
		{
			string update_enable = this->_object->Get_VC_Name() + "_update_enable";
			this->Write_VC_Joins_To_Root_Source_Updates(update_enable, visited_elements, ofile);
		}
	}
}


void AaSimpleObjectReference::Write_VC_Joins_To_Root_Source_Updates(string trig_trans, 
		set<AaRoot*>& visited_elements, ostream& ofile)
{

	set<AaRoot*> root_set;
	this->Collect_Root_Sources(root_set);
	for(set<AaRoot*>::iterator iter = root_set.begin(), fiter = root_set.end();
			iter != fiter; iter++)
	{
		AaRoot* r = *iter;
		if((r != NULL) && (visited_elements.find(r) != visited_elements.end()))
		{
			bool err;
			err = false;
			//
			// If r is an input interface object, then we are in trouble.
			//
			if(r->Is_Interface_Object() && ((AaInterfaceObject*)r)->Get_Is_Input())
			{
				AaRoot::Error("zero-delay path from input-interface-object-ref " 
						+ r->Get_VC_Name() + " to output-interface-object-ref "
						+ this->Get_VC_Name(), this);
				err = true;
			}
			if(!err)
			{
				// ... note: unmarked, since 
				// transitions to update_enable will be marked.
				__J(__UST(r), trig_trans);
			}
		}
	}
}

void AaSimpleObjectReference::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{

	ofile << "// (as target) " << this->To_String() << endl;
	if(this->_object->Is_Interface_Object())
	{
		ofile << "// " << this->To_String() << endl << "// write to interface object" << endl;
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

		AaMemorySpace* ms = this->Get_VC_Memory_Space();
		assert(ms != NULL);
		ls_map[ms].push_back(this);

		//
		// SelfRelease (only the UST part is needed..).
		// the sample part does not need to be reenabled.
		// __MJ(__UST(this),__UCT(this),true);
		// however other logic depends on strict reenabling.
		// 
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
			// Close the ring.
			//
			__MJ(__SST(this), __UCT(this), true); // ring bypass
			//__SelfReleaseSplitProtocolPattern
		}


		pipe_map[(AaPipeObject*) (this->_object)].push_back(this);
	}

	// at the end!
	visited_elements.insert(this);
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

bool AaSimpleObjectReference::Is_Pipe_Write()
{
	if(this->_object == NULL)
		return(false);
	if(this->_object->Is_Pipe_Object())
	{
		return(this->Get_Is_Target());
	}
}

//
// from guard expression guard_expr to this.
//
void AaSimpleObjectReference::Write_VC_Guard_Forward_Dependency(AaRoot* guard_expr_root, set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(visited_elements.find(guard_expr_root) != visited_elements.end())
	{
		if((this->Get_Associated_Phi_Statement() == NULL) || !guard_expr_root->Is_Phi_Statement())
		{
			// No Phi-Phi dependencies
			if(this->_object->Is("AaPipeObject") && !this->Get_Is_Target() && !this->Is_Signal_Read())
			{
				// Not relevant for pipe reads any more....
				//__J(__UST(this), __UCT(guard_expr_root));
				//
				// Guard will be sampled inside the split guard interface..
				//
				ofile << "// Guard forward dependency for pipe read " << endl;
				__J(__SST(this), __UCT(guard_expr_root));
			}
			else
			{
				ofile << "// Guard forward dependency " << endl;
				__J(__SST(this), __UCT(guard_expr_root));
			}

			// Note: with new SplitGuardInterface
			// this dependency is no longer necessary.
			//__J(__UST(this), __UCT(root));
		}
	}
	else
	{
		ofile << "// root " << guard_expr_root->Get_VC_Name() << " not in visited_elements" << endl;
	}
}

void AaSimpleObjectReference::Write_VC_Guard_Backward_Dependency(AaExpression* expr,
		set<AaRoot*>& visited_elements, ostream& ofile)
{

	bool bypass_flag = this->Is_Part_Of_Fullrate_Pipeline();

	// Added: special case for pipe read!
	if(this->_object->Is("AaPipeObject") && !this->Get_Is_Target() && !this->Is_Signal_Read())
	{
		// expr->Write_VC_Update_Reenables (this, __UST(this), bypass_flag, visited_elements, ofile);
		//
		// 	Special case is not needed with new split guard interface
		//
		ofile << "// Guard backward dependency for pipe read " << endl;
		this->AaExpression::Write_VC_Guard_Backward_Dependency(expr, visited_elements, ofile);
	}
	else
	{
		this->AaExpression::Write_VC_Guard_Backward_Dependency(expr, visited_elements, ofile);
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

string AaArrayObjectReference::Get_VC_Base_Address_Update_Unmarked_Reenable_Transition(set<AaRoot*>& visited_elements)
{

	string base_addr_calc_reenable =  "$null";
	if(!this->Is_Constant())
	{
		if(this->Get_Object_Type()->Is_Pointer_Type())
			// array expression is a pointer-evaluation expression.
		{
			if(this->_object->Is_Interface_Object())
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
				bool pm = this->Is_Part_Of_Pipelined_Module();
				if(pm)
				{
					base_addr_calc_reenable =
						(this->_object->Get_VC_Name() + "_update_enable_unmarked");
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		this->Check_Volatile_Inconsistency();
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
					this->_pointer_ref->Write_Forward_Dependency_From_Roots(base_addr_calc, -1, 
							visited_elements, ofile);
				}

			}
			else if(this->_object->Is_Expression())
			{
				AaExpression* expr = ((AaExpression*)this->_object);
				expr->Write_Forward_Dependency_From_Roots(base_addr_calc,-1, visited_elements, ofile);
			}
			else if(this->_object->Is_Interface_Object())
			{
				AaStatement* root = ((AaInterfaceObject*)(this->_object))->Get_Unique_Driver_Statement();
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
			set<string> active_unmarked_reenable_points;
			map<string,bool> active_reenable_bypass_flags;
			this->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
					ls_map,
					pipe_map,
					&_indices,
					&scale_factors, &shift_factors,
					active_reenable_points,
					active_unmarked_reenable_points,
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
			__F(__SCT(this),"$null");

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

				// unmarked joins (for use in pipelined operator modules).
				Write_VC_Unmarked_Joins (active_unmarked_reenable_points, ctrans,ofile);
				active_unmarked_reenable_points.clear();

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

			AaMemorySpace* ms =this->Get_VC_Memory_Space();
			assert(ms != NULL);
			ls_map[ms].push_back(this);

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
				expr->Write_Forward_Dependency_From_Roots(__SST(this), this->Get_Index(),
						visited_elements, ofile);

				// TODO: use split protocol to implement Slice.
				//       (note that Slice doubles as a register..)
				ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] {" << endl;
				ofile << "$T [slice_req] $T [slice_ack]" << endl;
				ofile << "}" << endl;

				__J(__SCT(this),__SST(this));
				__F(__SCT(this), __UST(this));
				__F(__UST(this),this->Get_VC_Complete_Region_Name());
				__J(__UCT(this), this->Get_VC_Complete_Region_Name());

				bool flow_through = this->Is_Flow_Through();
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
		if((barrier != NULL) && !this->Is_Flow_Through())
		{
			ofile << "// barrier " << endl;
			__J(__SST(this), __UCT(barrier));
		}

		visited_elements.insert(this);
		this->Write_VC_Phi_Start_Dependency(ofile);
	}
}

void AaArrayObjectReference::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{

	this->Check_Volatile_Inconsistency();
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

		AaMemorySpace* ms =this->Get_VC_Memory_Space();
		assert(ms != NULL);
		ls_map[ms].push_back(this);

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

	visited_elements.insert(this);
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

string AaPointerDereferenceExpression::Get_VC_Base_Address_Update_Unmarked_Reenable_Transition(set<AaRoot*>& visited_elements)
{
	string ret_val = "$null";
	assert(this->_reference_to_object != NULL);
	string ret_string = this->_reference_to_object->Get_VC_Unmarked_Reenable_Update_Transition_Name_Generic(visited_elements);
	return(ret_string);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
		this->Check_Volatile_Inconsistency();
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
		this->_reference_to_object->Write_Forward_Dependency_From_Roots(base_addr_calc, 
				-1,
				visited_elements,
				ofile);

		__J(__SST(this),base_addr_calc);
		if(pipeline_flag)
		{
			//__MJ(this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
			this->_reference_to_object->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements,ofile);
		}

	}


	AaMemorySpace* ms = this->Get_VC_Memory_Space();
	assert (ms != NULL);
	ls_map[ms].push_back(this);

	if(pipeline_flag)
	{
		__SelfReleaseSplitProtocolPattern
	}


	visited_elements.insert(this);
	this->Write_VC_Phi_Start_Dependency(ofile);
}

void AaPointerDereferenceExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
		this->Check_Volatile_Inconsistency();
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
		this->_reference_to_object->Write_Forward_Dependency_From_Roots(base_addr_calc, 
				-1,
				visited_elements,
				ofile);
		__J(__SST(this),base_addr_calc);
		if(pipeline_flag)
		{
			this->_reference_to_object->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements,ofile);
			//__MJ(this->_reference_to_object->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
		}
	}

	AaMemorySpace* ms =this->Get_VC_Memory_Space();
	assert(ms != NULL);
	ls_map[ms].push_back(this);
	if(pipeline_flag)
	{
		__SelfReleaseSplitProtocolPattern
	}
	visited_elements.insert(this);
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
		this->Check_Volatile_Inconsistency();
	ofile << "// " << this->To_String() << endl;

	if(!this->Is_Constant())
	{
		__DeclTransSplitProtocolPattern;
		if((barrier != NULL) && !this->Is_Flow_Through())
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
		set<string> active_unmarked_reenable_points;
		map<string,bool> active_reenable_bypass_flags;
		obj_ref->Write_VC_Root_Address_Calculation_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				obj_ref->Get_Index_Vector(),
				&scale_factors, &shift_factors,
				active_reenable_points,
				active_unmarked_reenable_points,
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
		__F(__SCT(this),"$null");
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

			Write_VC_Unmarked_Joins(active_unmarked_reenable_points, ctrans,ofile);
			active_unmarked_reenable_points.clear();

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
	visited_elements.insert(this);
	this->Write_VC_Phi_Start_Dependency(ofile);
}

void AaAddressOfExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		this->Check_Volatile_Inconsistency();

		ofile << "// " << this->To_String() << endl;
		if(!this->Is_Flow_Through())
		{
			__DeclTransSplitProtocolPattern;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
			}

			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		}
		this->_rest->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,barrier,
				ofile);


		if(!this->Is_Flow_Through())
		{
			this->_rest->Write_Forward_Dependency_From_Roots(__SST(this), this->Get_Index(),
					visited_elements, ofile);

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


			if(pipeline_flag)
			{
				this->_rest->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements,ofile);
				// __MJ(this->_rest->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true );  // bypass
				__SelfReleaseSplitProtocolPattern
			}
		}
		this->Write_VC_Phi_Start_Dependency(ofile);
	}
	visited_elements.insert(this);

}

void AaTypeCastExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		this->Check_Volatile_Inconsistency();
		ofile << "// " << this->To_String() << endl;
		if(!this->Is_Flow_Through())
		{
			__DeclTransSplitProtocolPattern;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
			}

			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		}

		this->_rest->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
				ls_map,pipe_map,
				barrier,
				ofile);


		if(!this->Is_Flow_Through())
		{
			this->_rest->Write_Forward_Dependency_From_Roots(__SST(this), this->Get_Index(),
					visited_elements, ofile);

			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";

			ofile << ";;[" << sample_regn << "] { // unary expression " << endl;      
			ofile << "$T [rr] $T [ra] // (split) unary operation" << endl;
			ofile << "}" << endl;

			ofile << ";;[" << update_regn << "] { // unary expression " << endl;      
			ofile << "$T [cr] $T [ca] //(split) unary operation" << endl;
			ofile << "}" << endl;

			__ConnectSplitProtocolPattern;

			if(pipeline_flag)
			{
				this->_rest->Write_VC_Update_Reenables(this, __SCT(this), true,  visited_elements,ofile);
				__SelfReleaseSplitProtocolPattern
			}
		}
		this->Write_VC_Phi_Start_Dependency(ofile);
	}
	visited_elements.insert(this);
}
void AaUnaryExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0); // DEAD CODE: TODO: get rid of it..
}


void AaBinaryExpression::Write_VC_Guard_Forward_Dependency(AaRoot* guard_expr_root, set<AaRoot*>& visited_elements, ostream& ofile)
{
	this->AaExpression::Write_VC_Guard_Forward_Dependency(guard_expr_root, visited_elements, ofile);
}

void AaBinaryExpression::Write_VC_Guard_Backward_Dependency(AaExpression* expr, set<AaRoot*>& visited_elements, ostream& ofile)
{
	if(!this->Is_Flow_Through())
	{
		this->AaExpression::Write_VC_Guard_Backward_Dependency(expr, visited_elements, ofile);
	}
}

void AaBinaryExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->Check_Volatile_Inconsistency();
		ofile << "// " << this->To_String() << endl;

		if(!this->Is_Flow_Through())
		{
			__DeclTransSplitProtocolPattern;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
			}

			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		}
		this->_first->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);
		this->_second->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier, ofile);



		if(!this->Is_Flow_Through())
		{
			string sst = __SST(this);
			if(!this->_first->Is_Constant())
			{
				this->_first->Write_Forward_Dependency_From_Roots(sst, this->Get_Index(),
						visited_elements, ofile);
			}
			if(!this->_second->Is_Constant())
			{
				this->_second->Write_Forward_Dependency_From_Roots(sst,this->Get_Index(),
						visited_elements, ofile);
			}



			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";

			ofile << ";;[" << sample_regn <<"] { // binary expression " << endl;
			ofile << "$T [rr] $T [ra]  // (split) binary operation " << endl;
			ofile << "}" << endl;

			ofile << ";;[" << update_regn << "] { // binary expression " << endl;
			ofile << "$T [cr] $T [ca] // (split) binary operation " << endl;
			ofile << "}" << endl;

			__ConnectSplitProtocolPattern;
			if(pipeline_flag)
			{
				if(!this->_first->Is_Constant())
				{
					this->_first->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
					//__MJ(this->_first->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
				}

				if(!this->_second->Is_Constant())
				{	
					this->_second->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
					// __MJ(this->_second->Get_VC_Reenable_Update_Transition_Name(visited_elements), __SCT(this), true); // bypass
				}

				__SelfReleaseSplitProtocolPattern
			}
		}
		this->Write_VC_Phi_Start_Dependency(ofile);
	}
	visited_elements.insert(this);
}

void AaBinaryExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(!this->Is_Constant())
	{
		this->Check_Volatile_Inconsistency();

		ofile << "// " << this->To_String() << endl;

		if(!this->Is_Flow_Through())
		{
			__DeclTransSplitProtocolPattern;
			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this),__UCT(barrier));
			}

			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		}

		if(this->_test)
			this->_test->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

		if(this->_if_true)
			this->_if_true->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

		if(this->_if_false)
			this->_if_false->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

		if(!this->Is_Flow_Through())
		{
			string sst = __SST(this);
			if(!this->_test->Is_Constant())
			{
				this->_test->Write_Forward_Dependency_From_Roots(sst,this->Get_Index(),
						visited_elements, ofile);
			}
			if(!this->_if_true->Is_Constant())
			{
				this->_if_true->Write_Forward_Dependency_From_Roots(sst, this->Get_Index(),
						visited_elements, ofile);
			}
			if(!this->_if_false->Is_Constant())
			{
				this->_if_false->Write_Forward_Dependency_From_Roots(sst,this->Get_Index(),
						visited_elements, ofile);
			}

			ofile << ";;[" << this->Get_VC_Start_Region_Name() << "] { // ternary expression: " << endl;
			ofile << "$T [req] $T [ack] // sample req/ack" << endl;
			ofile << "}" << endl;
			ofile << ";;[" << this->Get_VC_Complete_Region_Name() << "] { // ternary expression: " << endl;
			ofile << "$T [req] $T [ack] // update req/ack" << endl;
			ofile << "}" << endl;
			
			//
			// split protocol.
			//
			__F(__SST(this),this->Get_VC_Start_Region_Name());
			__J(__SCT(this),this->Get_VC_Start_Region_Name());
			__F(__SCT(this),"$null");  // this is important to avoid needless dependencies.

			__F(__UST(this),this->Get_VC_Complete_Region_Name());
			__J(__UCT(this),this->Get_VC_Complete_Region_Name());


			if(pipeline_flag)
			{

				if(!this->_test->Is_Constant())
				{
					this->_test->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
					//__MJ(this->_test->Get_VC_Reenable_Update_Transition_Name(visited_elements),__UCT(this), true); // bypass
				}
				if(this->_if_true && !this->_if_true->Is_Constant())
				{
					this->_if_true->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
					//__MJ(this->_if_true->Get_VC_Reenable_Update_Transition_Name(visited_elements),__UCT(this), true); // bypass
				}
				if(this->_if_false && !this->_if_false->Is_Constant())
				{
					this->_if_false->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
					//__MJ(this->_if_false->Get_VC_Reenable_Update_Transition_Name(visited_elements),__UCT(this), true); // bypass
				}

				__SelfReleaseSplitProtocolPattern

			}
		}
		this->Write_VC_Phi_Start_Dependency(ofile);
	}
	visited_elements.insert(this);
}

void AaTernaryExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}

	
void AaFunctionCallExpression::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{
		for(int I = 0, fI = _arguments.size(); I < fI; I++)
		{
			AaExpression* expr = _arguments[I];
			expr->Write_VC_Links_Optimized(hier_id,ofile);
		}

		ofile << "// " << this->To_String() << endl;
		bool flow_through = this->Is_Trivial();
		if(flow_through)
			return;

		string sample_regn = this->Get_VC_Name() + "_Sample";
		string update_regn = this->Get_VC_Name() + "_Update";

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

void AaFunctionCallExpression::Write_VC_Links_As_Target_Optimized(string hier_id, ostream& ofile)
{
	assert(0);
}

void AaFunctionCallExpression::Write_VC_Control_Path_Optimized(bool pipeline_flag,
			set<AaRoot*>& visited_elements,
			map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
			map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
			AaRoot* barrier,
			ostream& ofile)
{
	if(!this->Is_Constant())
	{

		this->Check_Volatile_Inconsistency();
		ofile << "// " << this->To_String() << endl;

		if(!this->Is_Trivial())
		{
			__DeclTransSplitProtocolPattern;

			if(barrier != NULL)
			{
				ofile << "// barrier " << endl;
				__J(__SST(this), __UCT(barrier));
			}

			this->Write_VC_Guard_Dependency(pipeline_flag, visited_elements,ofile);
		}
	
		for(int I = 0, fI = _arguments.size(); I < fI; I++)
		{
			AaExpression* expr = _arguments[I];
			expr->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,
								ls_map,pipe_map,barrier, ofile);

			if(!this->Is_Trivial())
			{
				string sst = __SST(this);
				if(!expr->Is_Constant())
				{
					expr->Write_Forward_Dependency_From_Roots(sst, this->Get_Index(),
							visited_elements, ofile);

					if(pipeline_flag)
					{
						expr->Write_VC_Update_Reenables(this, __SCT(this), true, 
								visited_elements, ofile);
					}
				}
			}
		}

		if(!this->Is_Trivial())
		{

			string sample_regn = this->Get_VC_Name() + "_Sample";
			string update_regn = this->Get_VC_Name() + "_Update";

			ofile << ";;[" << sample_regn <<"] { // fn-call expression " << endl;
			ofile << "$T [req] $T [ack]  // (split) fn-call binary operation " << endl;
			ofile << "}" << endl;

			ofile << ";;[" << update_regn << "] { // fn-call binary expression " << endl;
			ofile << "$T [req] $T [ack] // (split) fn-call binary operation " << endl;
			ofile << "}" << endl;

			__ConnectSplitProtocolPattern;
			if(pipeline_flag)
				__SelfReleaseSplitProtocolPattern;
		}

		this->Write_VC_Phi_Start_Dependency(ofile);
	}
	visited_elements.insert(this);
}

void AaFunctionCallExpression::Write_VC_Control_Path_As_Target_Optimized(bool pipeline_flag,
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	assert(0);
}



/// load-store related stuff.
void AaObjectReference::Write_VC_Load_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		AaRoot* barrier,
		ostream& ofile)
{
	set<string> active_reenables;
	set<string> active_unmarked_reenables;
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
			active_unmarked_reenables,
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
		Write_VC_Unmarked_Joins(active_unmarked_reenables, at, ofile); 

	}

	active_reenables.clear();
	active_unmarked_reenables.clear();
}

void AaObjectReference::Write_VC_Store_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map, 
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		vector<AaExpression*>* address_expressions,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		AaRoot* barrier,
		ostream& ofile)
{
	set<string> active_reenables;
	set<string> active_unmarked_reenables;
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
			active_unmarked_reenables,
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
		Write_VC_Unmarked_Joins(active_unmarked_reenables,  at, ofile); // do not force bypass, decide based on active bypass flags..

	}

	active_reenables.clear();
	active_unmarked_reenables.clear();
}

void AaObjectReference::Write_VC_Load_Store_Control_Path_Optimized(bool pipeline_flag, set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map, 
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		vector<AaExpression*>* indices,
		vector<int>* scale_factors,		
		vector<int>* shift_factors,
		AaRoot* barrier,
		set<string>& active_reenable_points,
		set<string>& active_unmarked_reenable_points,
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
				active_unmarked_reenable_points,
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
				__MJ(sample_start, sample_complete, false); // no bypass
				__MJ(update_start, update_complete, true);  // bypass

				Write_VC_Reenable_Joins(active_reenable_points, active_reenable_bypass_flags,  word_addr_calculated, false,  ofile); // do not force bypass, decide based on active bypass flags.
				active_reenable_points.clear();
				active_reenable_points.insert(update_start);
				active_reenable_bypass_flags[update_start] =  true;

				Write_VC_Unmarked_Joins(active_unmarked_reenable_points, 
									word_addr_calculated, ofile);
				active_unmarked_reenable_points.clear();
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
void AaExpression:: Update_Reenable_Points_And_Producer_Delay_Status(
		set<string>& en_points, 
		set<string>& en_unmarked_points, 
		map<string,bool>& en_bypass_flags,
		set<AaRoot*>& visited_elements)
{
	set<AaRoot*> root_expr_set;
	this->Collect_Root_Sources(root_expr_set);

	for(set<AaRoot*>::iterator iter = root_expr_set.begin();
			iter != root_expr_set.end(); iter++)
	{
		AaRoot* root = (*iter);
		if((root != NULL) && (visited_elements.find(root) != visited_elements.end()))
		{
			if(this->Get_Associated_Phi_Statement() == NULL)
			{
				string en_trans_name = root->Get_VC_Reenable_Update_Transition_Name(visited_elements);	
				string en_unmarked_trans_name = 
					root->Get_VC_Unmarked_Reenable_Update_Transition_Name_Generic(visited_elements);	
				en_points.insert(en_trans_name);
				if(en_unmarked_trans_name != "$null")
					en_unmarked_points.insert(en_unmarked_trans_name);
					
				en_bypass_flags[en_trans_name] =  true;
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
		map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		vector<AaExpression*>* index_vector,
		vector<int>* scale_factors,
		vector<int>* shift_factors,
		set<string>& active_reenable_points,
		set<string>& active_unmarked_reenable_points,
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
	string base_addr_unmarked_update_reenable = 
		this->Get_VC_Base_Address_Update_Unmarked_Reenable_Transition(visited_elements);
	//bool base_addr_update_reenable_bypass = this->Base_Address_Update_Protocol_Has_Delay(visited_elements);
	bool base_addr_update_reenable_bypass = true; // in the new rationalized scheme, this is always true.
	if(pipeline_flag)
	{
		if(base_addr < 0)
		{
			active_reenable_points.insert(base_addr_update_reenable);
			active_reenable_bypass_flags[base_addr_update_reenable] =  base_addr_update_reenable_bypass;

			if(base_addr_unmarked_update_reenable != "$null")
				active_unmarked_reenable_points.insert(base_addr_unmarked_update_reenable);
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
	map<int,set<string> > index_chain_unmarked_reenable_map;
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

				string index_resized = this->Get_VC_Name() + "_index_resized_" + IntToStr(idx);
				string index_scaled = this->Get_VC_Name() + "_index_scaled_" + IntToStr(idx);
				string index_computed = this->Get_VC_Name() + "_index_computed_" + IntToStr(idx);
				__T(index_resized);
				__T(index_scaled);
				__T(index_computed);

				num_non_constant++;
				index_expr->Write_VC_Control_Path_Optimized(pipeline_flag, 
						visited_elements,
						ls_map,pipe_map,barrier,
						ofile);


				if(pipeline_flag)
				{
					index_expr->Update_Reenable_Points_And_Producer_Delay_Status
							(index_chain_reenable_map[idx], 
								index_chain_unmarked_reenable_map[idx], 
								active_reenable_bypass_flags,
								visited_elements);
				}
				index_expr->Write_Forward_Dependency_From_Roots(index_computed, -1, visited_elements, ofile);
				index_chain_complete_map[idx] = index_computed;



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

						for(set<string>::iterator iiuter = index_chain_unmarked_reenable_map[idx].begin(), 
								fiuiter = index_chain_unmarked_reenable_map[idx].end();
								iiuter != fiuiter; iiuter++)
						{
							// reenable index expression update when
							// sample-completed.
							string jj = *iiuter;
							__J(jj, idx_resize_sample_complete);
						}
						index_chain_unmarked_reenable_map[idx].clear();

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

						for(set<string>::iterator iiuter = index_chain_unmarked_reenable_map[idx].begin(), 
								fiuiter = index_chain_unmarked_reenable_map[idx].end();
								iiuter != fiuiter; iiuter++)
						{
							// reenable index expression update when
							// sample-completed.
							string jj = *iiuter;
							__J(jj, index_scaled);
						}
						index_chain_unmarked_reenable_map[idx].clear();

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
						Write_VC_Unmarked_Joins(index_chain_unmarked_reenable_map[I0], sample_complete,ofile);
						Write_VC_Marked_Joins(index_chain_reenable_map[I1], sample_complete, false, ofile);
						Write_VC_Unmarked_Joins(index_chain_unmarked_reenable_map[I1], sample_complete,  ofile);
						index_chain_reenable_map[I0].clear();
						index_chain_reenable_map[I1].clear();

						index_chain_unmarked_reenable_map[I0].clear();
						index_chain_unmarked_reenable_map[I1].clear();
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
						Write_VC_Unmarked_Joins(index_chain_unmarked_reenable_map[I1], sample_complete,  ofile);
						index_chain_reenable_map[I1].clear();
						index_chain_unmarked_reenable_map[I1].clear();
					
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
				active_unmarked_reenable_points.clear();

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
			for(set<string>::iterator iiuter = index_chain_unmarked_reenable_map[IIDX].begin(),
					fiiuter = index_chain_unmarked_reenable_map[IIDX].end(); 
					iiuter != fiiuter; iiuter++)
			{
				active_unmarked_reenable_points.insert(*iiuter);
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
				Write_VC_Unmarked_Joins(active_unmarked_reenable_points, sample_complete, ofile);
				__MJ(update_start, offset_calculated, true); // bypass.
			}

			active_reenable_points.clear();
			active_unmarked_reenable_points.clear();

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
		__T(bpo_sample_start);
		__T(bpo_sample_complete);
		__T(bpo_update_start);
		__T(bpo_update_complete);

		ofile << ";;[" << bpo_sample_regn << "] { " << endl;
		ofile << "$T [rr] $T [ra]" << endl;
		ofile << "}" << endl;
		ofile << ";;[" << bpo_update_regn << "] { " << endl;
		ofile << "$T [cr] $T [ca]" << endl;
		ofile << "}" << endl;

		__F(bpo_sample_start, bpo_sample_regn);
		__F(bpo_update_start, bpo_update_regn);
		__J(bpo_sample_complete, bpo_sample_regn);
		__J(bpo_update_complete, bpo_update_regn);


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
			Write_VC_Unmarked_Joins(active_unmarked_reenable_points, bpo_sample_complete, ofile); 

			active_reenable_points.clear();
			active_unmarked_reenable_points.clear();
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




