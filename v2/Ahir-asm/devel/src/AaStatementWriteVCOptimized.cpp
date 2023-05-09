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
#include <AaProgram.h>
#include <Aa2VC.h>

// for the pipelined case.
void AaStatement::Write_VC_RAW_Release_Dependencies(AaExpression* expr, set<AaRoot*>& visited_elements)
{
	set<AaRoot*> non_triv_preds;
	expr->Identify_Non_Trivial_Predecessors(non_triv_preds, visited_elements);
	Write_VC_RAW_Release_Deps(((AaRoot*)this),non_triv_preds);
}

void AaStatement::Write_VC_Synch_Dependency(set<AaRoot*>& visited_elements, bool pipeline_flag, ostream& ofile)
{
	if(this->_synch_statements.size() > 0)
	{
		for(set<AaStatement*>::iterator siter = _synch_statements.begin(), fiter = _synch_statements.end();
				siter != fiter; siter++)
		{
			AaStatement* stmt = *siter;
			bool update_flag = this->_synch_update_flag_map[stmt];
			if(visited_elements.find(stmt) != visited_elements.end())
			{
				ofile << "// forced synch: synched statement will start after marked statement" 
					<< endl;

				bool synch_has_delay;
				string stmt_synch_transition = stmt->Get_VC_Synch_Transition_Name(synch_has_delay);
				string synch_transition_name = 
					string ("synch_") + __SST(this) + "_" + stmt_synch_transition;

				ofile << "$T [" << synch_transition_name <<"] ";
				if(!synch_has_delay)
					ofile << " $delay" << endl;
				else
					ofile << endl;

				
				if(update_flag)
				{
					__J(synch_transition_name, __UCT(stmt));
				}
				else
				{
					__J(synch_transition_name, stmt_synch_transition);
				}

				__J(__SST(this), synch_transition_name);

				if(pipeline_flag)
				{
					if(update_flag)
					{
						__MJ(__UST(stmt), __SCT(this), true); // bypass
					}
					else
					{
						__MJ(__SST(stmt), __SCT(this), true); // bypass
					}
				}
			}
		}
	}
}

   
void AaStatement::Check_Volatility_Ordering_Condition()
{
	set<AaRoot*> root_sources;
	this->Collect_Root_Sources(root_sources);

	for(set<AaRoot*>::iterator iter = root_sources.begin(), fiter = root_sources.end();
		iter != fiter; iter++)
	{
		AaRoot* r =*iter;
		if(r->Get_Index() > this->Get_Index())
		{
			AaRoot::Error("volatile statement uses downstream statement " + r->To_String(), this);
		}
	}
}


// a lot of code repetition, but can it be avoided?

void AaStatementSequence::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	for(int idx = 0, fidx = _statement_sequence.size(); idx < fidx; idx++)
	{
		_statement_sequence[idx]->Write_VC_Control_Path_Optimized(ofile);
	}
}


void AaStatementSequence::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	for(int idx = 0, fidx = _statement_sequence.size(); idx < fidx; idx++)
	{
		_statement_sequence[idx]->Write_VC_Links_Optimized(hier_id,ofile);
	}
}

// AaNullStatement
void AaNullStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
}

// AaAssignmentStatement
void AaAssignmentStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	// this should never be called.
	assert(0);
}

void AaAssignmentStatement::Write_VC_WAR_Dependencies(bool pipeline_flag,
		set<AaRoot*>& visited_elements,
		ostream& ofile)
{

	if(!this->Is_Constant())
	{
		AaExpression* tgt = this->_target;

		if(tgt->Is_Implicit_Variable_Reference())
			tgt->Write_VC_WAR_Dependencies(pipeline_flag,
					visited_elements,ofile);
	}

}


// New addition: the pipeline-flag.
// In this case, in addition to the data-dependency, the following pipeline 
// release dependencies is added.
// 
//    the source expression can be updated as soon
//    as the target has used the previous result of the source.
//
//    the guard expression can be updated as soon
//    as the statement has completed.
//
//
//   forward dependencies
//            guard-complete ->  statement-start.
//            source-complete -> statement-active.
//            statement-active -> target-start.
//            target-complete  -> statement-complete.
//            statement-start  -> statement-active  (could be redundant)
//            statement-active -> statement-complete (could be redundant)
//
//   backward dependencies.
//            statement-active -> guard-reenable.
//            statement-complete -> statement-active (could be redundant).
void AaAssignmentStatement::Write_VC_Control_Path_Optimized(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(this->Get_Is_Volatile())
	{
		//
		// volatile statements should not depend 
		// on anything which is indexed higher than
		// the statement.
		//
		this->Check_Volatility_Ordering_Condition();

		// WAR dependencies.. need to be chased down even if it is volatile.
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);
	}
	ofile << "// start:  " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->Is_Constant()) 
	{
		ofile << "// constant! " << endl;
	}
	else  
	{

		if(this->Get_Is_Volatile())
			ofile << "// volatile! " << endl;

		bool source_is_implicit = 
			(_source->Is_Signal_Read() ||
			 _source->Is_Volatile_Function_Call() ||
			 _source->Is_Implicit_Variable_Reference());

		bool target_is_implicit = _target->Is_Implicit_Variable_Reference();

		if(!this->Get_Is_Volatile() && source_is_implicit && target_is_implicit)
			// both are implicit.. introduce an interlock.
		{
			__DeclTransSplitProtocolPattern;
		}

		// take care of the guard
		if(this->_guard_expression)
		{
			if(this->_guard_expression->Is_Constant())
			{
				ofile << "// Guard expression is a constant" << endl;
			}
			else
			{
				// guard expression calculation
				ofile << "// Guard expression " << endl;
				this->_guard_expression->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);
			}
		}


		// write the source side expressions and their 
		// dependencies..
		if(!this->_source->Is_Constant())
		{
			ofile << "// Source expression" << endl;
			this->_source->Write_VC_Control_Path_Optimized(pipeline_flag,
					visited_elements,
					ls_map,pipe_map, barrier,
					ofile);
		}



		ofile << "// Target expression" << endl;
		this->_target->Write_VC_Control_Path_As_Target_Optimized(pipeline_flag,
				visited_elements,
				ls_map,pipe_map,barrier,
				ofile);

		if(!this->Get_Is_Volatile() && source_is_implicit && target_is_implicit)
			// both are implicit.. introduce an interlock.
		{
			ofile << "// both source and target are implicit: use interlock " << endl;
			ofile << "// Interlock " << endl;

			ofile <<  ";;[" << this->Get_VC_Name() << "_Sample] { " << endl;
			ofile << "$T [req] $T [ack] // interlock-sample." << endl;
			ofile << "}" << endl;

			ofile <<  ";;[" << this->Get_VC_Name() << "_Update] { " << endl;
			ofile << "$T [req] $T [ack] // interlock-update." << endl;
			ofile << "}" << endl;

			__ConnectSplitProtocolPattern;

			if(this->_guard_expression && !this->_guard_expression->Is_Constant())
			{
				ofile << "// Guard dependency" << endl;
				this->_guard_expression->Write_Forward_Dependency_From_Roots(__SST(this),
						this->Get_Index(),
						visited_elements,
						ofile);
				if(pipeline_flag)
				{
					this->_guard_expression->Write_VC_Update_Reenables(this, __SCT(this), true,
							visited_elements, ofile);
				}
			}

			this->_source->Write_Forward_Dependency_From_Roots(__SST(this),
						this->Get_Index(),
					visited_elements,
					ofile);
			if(pipeline_flag)
			{
				this->_source->Write_VC_Update_Reenables(this, __SCT(this), true,
						visited_elements, ofile);
				__SelfReleaseSplitProtocolPattern
			}
		}



		if(!this->Get_Is_Volatile() && !target_is_implicit && !this->_source->Is_Constant())
		{
			this->_source->Write_Forward_Dependency_From_Roots(__SST(this->_target),
					this->Get_Index(),
					visited_elements,
					ofile);
			if(pipeline_flag)
			{
				this->_source->Write_VC_Update_Reenables(this, __SCT(this->_target), true,
						visited_elements, ofile);
			}
		}

		if(target_is_implicit && !this->Get_Is_Volatile())
		{
			AaRoot* root_obj = _target->Get_Root_Object();
			if(root_obj == ((AaRoot*) this))
				visited_elements.insert(this);
			else if ((root_obj != NULL) && root_obj->Is_Interface_Object())
			{
				visited_elements.insert(this);
				visited_elements.insert(root_obj);
			}
		}

		if(!this->Get_Is_Volatile())
			this->Write_VC_Synch_Dependency(visited_elements, pipeline_flag, ofile);

		visited_elements.insert(this);
		// WAR dependencies
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);
	}

	// if target is interface object in a pipelined module then this
	// join kicks in!
	if(this->_target)
		this->_target->Write_VC_Pipelined_Module_Enable_Joins(visited_elements,ofile);

	ofile << "// end:  " << this->To_String() << endl;
}  


// note: hier-id is already assumed to have been set-up
void AaAssignmentStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(!this->Is_Constant())
	{

		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;

		this->_source->Write_VC_Links_Optimized(hier_id,
				ofile);
		this->_target->Write_VC_Links_As_Target_Optimized(hier_id,
				ofile);
		bool source_is_implicit = 
			(_source->Is_Signal_Read() ||
			 _source->Is_Volatile_Function_Call() ||
			 _source->Is_Implicit_Variable_Reference());

		bool target_is_implicit = _target->Is_Implicit_Variable_Reference();

		if(source_is_implicit && target_is_implicit)
		{
			if(!this->Get_Is_Volatile())
			{
				vector<string> reqs;
				vector<string> acks;
				reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "_Sample/req");
				acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_Sample/ack");
				reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "_Update/req");
				acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_Update/ack");

				Write_VC_Link(this->_target->Get_VC_Datapath_Instance_Name(),
						reqs, acks, ofile);
				reqs.clear();
				acks.clear();
			}
		}
	}
}


// AaCallStatement
void AaCallStatement::Write_VC_WAR_Dependencies(bool pipeline_flag,
		set<AaRoot*>& visited_elements,
		ostream& ofile)
{

	if(!this->Is_Constant())
	{
		for(int idx = 0; idx < _output_args.size(); idx++)
		{
			AaExpression* tgt = _output_args[idx];

			if(tgt->Is_Implicit_Variable_Reference())
				tgt->Write_VC_WAR_Dependencies(pipeline_flag,
						visited_elements,ofile);
		}
	}
}

void AaCallStatement::Write_VC_Control_Path_Optimized(bool pipeline_flag, 
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
		map<AaPipeObject*, vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}
	if(this->Get_Is_Volatile())
	{
		//
		// volatile statements should not depend 
		// on anything which is indexed higher than
		// the statement.
		//
		this->Check_Volatility_Ordering_Condition();

		// WAR dependencies.. need to be chased down even if it is volatile.
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);
	}
	ofile << "// start: " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(this->Is_Constant())
	{
		ofile << "// constant! " << endl;
	}
	else 
	{
		if(this->Get_Is_Volatile())
			ofile << "// volatile! " << endl;
		if(!this->Get_Is_Volatile())
		{
			__DeclTransSplitProtocolPattern;
		}

		// take care of the guard
		if(this->_guard_expression)
		{

			if(!this->_guard_expression->Is_Constant())
			{
				ofile << "// Guard expression" << endl;
				this->_guard_expression->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

				if(!this->Get_Is_Volatile())
				{
					this->_guard_expression->Write_Forward_Dependency_From_Roots(__SST(this), 
										this->Get_Index(), visited_elements, ofile);
					if(pipeline_flag)
					{
						this->_guard_expression->Write_VC_Update_Reenables(this, __SCT(this), true,
								visited_elements, ofile);
					}
				}
			}
		}

		// first the input arguments... zipping through.
		for(int idx = 0; idx < _input_args.size(); idx++)
		{
			ofile << "// Call input argument " << idx << endl;
			_input_args[idx]->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);
		}


		for(int idx = 0; idx < _input_args.size(); idx++)
		{

			AaExpression* expr = _input_args[idx];
			if(!expr->Is_Constant() && !this->Get_Is_Volatile())
			{
				expr->Write_Forward_Dependency_From_Roots(__SST(this),
										this->Get_Index(),  visited_elements, ofile);
				if(pipeline_flag)
				{
					// expression evaluation will be reenabled by activation of the
					// call.
					expr->Write_VC_Update_Reenables(this, __SCT(this), true,
							visited_elements, ofile);
				}
			}
		}


		if(!this->Get_Is_Volatile())
		{
			// the call-trigger will start the call..
			ofile << ";;[" << this->Get_VC_Name() << "_Sample] { " 
				<< "$T [crr] $T [cra] "
				<< "} " << endl;
			// the call will eventually complete.
			ofile << ";;[" << this->Get_VC_Name() << "_Update] { " 
				<< "$T [ccr] $T [cca] "
				<< "} " << endl;
			__ConnectSplitProtocolPattern;
		}


		// the output arguments.
		bool non_triv_flag = false;
		for(int idx = 0; idx < _output_args.size(); idx++)
		{
			AaExpression* expr = _output_args[idx];

			ofile << "// Call output argument " << idx << endl;
			expr->Write_VC_Control_Path_As_Target_Optimized(pipeline_flag,
					visited_elements,ls_map,pipe_map,barrier,ofile);


			if(!this->Get_Is_Volatile() && !expr->Is_Implicit_Variable_Reference())
			{

				__J(__SST(expr),__UCT(this));

				// if pipeline-flag, then expression activation must reenable call
				// statement .
				if(pipeline_flag)
				{
					__MJ(__UST(this), __SCT(expr), true); // bypass
				}

				non_triv_flag = true;
			}

			if(!this->Get_Is_Volatile())
			{
				AaRoot* root_obj = expr->Get_Root_Object();
				if(root_obj == ((AaRoot*) this))
					visited_elements.insert(this);
				else if ((root_obj != NULL) && (root_obj->Is("AaInterfaceObject")))
				{
					visited_elements.insert(this);
					visited_elements.insert(root_obj);
				}
			}

			//
			// if expr is a interface-object in pipelined module, this kicks in
			// to play.
			//
			expr->Write_VC_Pipelined_Module_Enable_Joins(visited_elements,ofile);
		}


		if(!this->Get_Is_Volatile())
			this->Write_VC_Synch_Dependency(visited_elements, pipeline_flag, ofile);


		// if pipeline-flag, then re-enable..
		if(!this->Get_Is_Volatile() && pipeline_flag)
		{
			__SelfReleaseSplitProtocolPattern
		}

		visited_elements.insert(this);
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);

		// Pipe and memory space information into ls and pipe maps.
		AaModule* cm = this->Get_Called_Module();
		set<AaPipeObject*>  accessed_pipes;
		cm->Get_Accessed_Pipes(accessed_pipes);
		for(set<AaPipeObject*>::iterator iter = accessed_pipes.begin(), 
			fiter = accessed_pipes.end(); iter != fiter; iter++)
		{
			pipe_map[*iter].push_back(this);
		}

		set<AaMemorySpace*> accessed_memory_spaces;
		cm->Get_Accessed_Memory_Spaces(accessed_memory_spaces);
		for(set<AaMemorySpace*>::iterator mter = accessed_memory_spaces.begin(), 
			fmter = accessed_memory_spaces.end(); mter != fmter; mter++)
		{
			ls_map[*mter].push_back(this);
		}

	}
	ofile << "// end: " << this->To_String() << endl;
}


void AaCallStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	if(this->_called_module->Get_Foreign_Flag())
	{
		AaRoot::Info("ignored foreign module call to " + this->_called_module->Get_Label());
		return;
	}
	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	for(int idx = 0; idx < _input_args.size(); idx++)
		_input_args[idx]->Write_VC_Links_Optimized(hier_id,ofile);

	for(int idx = 0; idx < _output_args.size(); idx++)
		_output_args[idx]->Write_VC_Links_As_Target_Optimized(hier_id,ofile);

	if(this->Get_Is_Volatile())
		return;

	vector<string> reqs;
	vector<string> acks;

	string start_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name() + "_Sample");
	reqs.push_back(start_hier_id + "/crr");
	acks.push_back(start_hier_id + "/cra");


	string complete_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name() + "_Update");
	reqs.push_back(complete_hier_id + "/ccr");
	acks.push_back(complete_hier_id + "/cca");

	Write_VC_Link(this->Get_VC_Name() + "_call",reqs,acks,ofile);
}

// AaBlockStatement
void AaBlockStatement::Identify_Maximal_Sequences( AaStatementSequence* sseq,
		vector<AaStatementSequence*>& linear_segment_vector)
{


	// take the statement sequence and chop it into maximal sequences
	// which end in non-control flow statements (place/merge/switch/if)
	// statements.
	//
	//   a sequence with a block statement is a single statement.
	//   a sequence with a control-flow statement is a single statement.
	//   a sequence with a pipe-access is a single statement.
	//   a sequence with simple statements can have many statements.
	//
	// Note: added: a barrier statement introduces a cut in the
	//      linear segment, but the barrier statement itself is
	//      ignored.
	//
	int start_idx = 0;
	while(start_idx < sseq->Get_Statement_Count())
	{
		AaStatement* stmt = NULL;
		int end_idx = start_idx;

		vector<AaStatement*> linear_segment;
		while(end_idx < sseq->Get_Statement_Count())
		{
			stmt  = sseq->Get_Statement(end_idx);

			if(stmt->Is("AaBarrierStatement"))
			{
				// barrier.. 
				end_idx++;
				break;
			}
			// some statements are just ignored.
			else if(stmt->Is_Null_Like_Statement())
			{
				end_idx++;
				continue;
			}
			else if(stmt->Is_Block_Statement()  || stmt->Is_Control_Flow_Statement())
			{
				if(linear_segment.size() == 0)
				{
					linear_segment.push_back(stmt);
					end_idx++;
					break;
				}
				else
					break;
			}
			else 
			{
				linear_segment.push_back(stmt);
				end_idx++;
			}
		}

		if(linear_segment.size() > 0)
		{
			AaStatementSequence* new_seq = new AaStatementSequence(this,linear_segment);
			linear_segment_vector.push_back(new_seq);
			linear_segment.clear();
		}

		start_idx = end_idx;
	}
}


void AaBlockStatement::Destroy_Maximal_Sequences(vector<AaStatementSequence*>& linear_segment_vector)
{
	for(int idx = 0, fidx = linear_segment_vector.size(); idx < fidx; idx++)
	{
		delete linear_segment_vector[idx];
	}
	linear_segment_vector.clear();
}


// put stmt in a sequence and call the subsequent method.
void AaBlockStatement::Write_VC_Control_Path_Optimized(AaStatement* stmt, ostream& ofile)
{
	vector<AaStatement*> tv;
	tv.push_back(stmt);
	AaStatementSequence* ss = new AaStatementSequence(this,tv);
	string region_name = ss->Get_VC_Name();
	set<AaRoot*> visited_elements;
	map<AaMemorySpace*, vector<AaRoot*> > load_store_ordering_map;
	map<AaPipeObject*, vector<AaRoot*> >  pipe_map;
	AaRoot* tb = NULL;
	ofile << "::[" << region_name << "] {" << endl;

	this->AaBlockStatement::Write_VC_Control_Path_Optimized(false,ss,visited_elements, load_store_ordering_map, pipe_map, tb, ofile);
	this->Write_VC_Load_Store_Dependencies(false, load_store_ordering_map,ofile);
	this->Write_VC_Pipe_Dependencies(false, pipe_map,ofile);

	ofile << "}" << endl;
	delete ss;
}


// sseq consists of linear sequence of simple statements..
// no control-flow, no block statements.
void AaBlockStatement::Write_VC_Control_Path_Optimized(bool pipeline_flag,
		AaStatementSequence* sseq,
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*,vector<AaRoot*> >& load_store_ordering_map,
		map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
		AaRoot*& trailing_barrier,
		ostream& ofile)
{
	trailing_barrier = NULL;
	if(sseq->Get_Statement_Count() == 1 && sseq->Get_Statement(0)->Is_Block_Statement())
		sseq->Get_Statement(0)->Write_VC_Control_Path_Optimized(ofile);
	else
	{
		/////////////////////////////////////////////////  CORE FUNCTIONALITY /////////////////////////////////////////////////////
		for(int idx = 0, fidx = sseq->Get_Statement_Count(); idx < fidx; idx++)
		{
			AaStatement* stmt = sseq->Get_Statement(idx);

			// skip null, report statements.
			if(stmt->Is_Null_Like_Statement())
				continue;

			if(stmt->Is_Block_Statement())
			{
				AaRoot::Error("block statement in printing fork block.\n", stmt);
			}
			else if(stmt->Is_Control_Flow_Statement())
			{
				AaRoot::Error("control-flow statement in printing fork block.\n", stmt);
			}
			else
			{
				stmt->Write_VC_Control_Path_Optimized(pipeline_flag, 
						visited_elements,
						load_store_ordering_map,
						pipe_map,
						trailing_barrier,
						ofile);
			}
		}
	}
}



// load store dependencies.
void AaBlockStatement::
Write_VC_Load_Store_Dependencies(bool pipeline_flag, 
		map<AaMemorySpace*,vector<AaRoot*> >& load_store_dep_map,
		ostream& ofile)
{

	bool leading_store_found = false;
	set<AaRoot*> leading_accesses;

	set<AaRoot*> trailing_accesses;
	ofile << "// load-store dependencies.." << endl;
	// for each memory space, scan the ordered list of 
	// load-stores, and add dependencies as follows
	//    - start->start dependencies between every load
	//      and nearest store before and after the load
	//    - start->start dependencies between adjacent
	//      stores.
	for(map<AaMemorySpace*,vector<AaRoot*> >::iterator iter = load_store_dep_map.begin(), 
			fiter  = load_store_dep_map.end();
			iter != fiter;
			iter++)
	{
		vector<AaRoot*> active_loads;
		AaRoot* last_store = NULL;

		AaMemorySpace* ms = (*iter).first;
		string mem_space_name = ms->Get_VC_Name();
		ofile << "// memory-space  " << mem_space_name << endl;


		for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
		{
			AaRoot* expr = (*iter).second[idx];
			// expr can be call statement.
			if(expr->Is_Expression() ||
					(!AaProgram::_treat_all_modules_as_opaque && 
							expr->Is_Call_Statement() && 
							// volatiles are ignored, as they should be
							!(((AaCallStatement*)expr)->Get_Is_Volatile()) && 
							!expr->Is_Opaque_Call_Statement()))
			{
				bool is_store = expr->Writes_To_Memory_Space(ms);
				ofile << "//  " << expr->Get_VC_Name() <<  (is_store ? " store" : " load") << endl;

				if(pipeline_flag)
				{
					// keep track of the leading and trailing accesses in
					// the sequence..  In the pipeline case, the trailing
					// access set will reenable the leading accesses..
					// the scheme: scan the list, and create a leading
					// set of loads (or a singleton store).  At the same
					// time create a trailing set of loads (or a singleton
					// store).  It is possible for the leading and trailing
					// sets to be the same.
					if(is_store)
					{
						if(!leading_store_found)
						{
							if(leading_accesses.size() == 0)
								leading_accesses.insert(expr);

							leading_store_found = true;	
						}

						trailing_accesses.clear();
						trailing_accesses.insert(expr);
					}
					else
					{
						if(!leading_store_found)
							leading_accesses.insert(expr);

						trailing_accesses.insert(expr);
					}
				}

				if(is_store)
				{
					if(active_loads.size() > 0)
					{
						// dependency between active loads and
						// expr start.
						for(int lsi = 0, flsi = active_loads.size(); lsi < flsi; lsi++)
						{
							Write_VC_Load_Store_Dependency(pipeline_flag, 
									ms,
									active_loads[lsi],
									expr, ofile);
						}

						// active load dependencies are taken care of
						active_loads.clear();
						last_store = expr;
					}
					else
					{
						if(last_store != NULL)
							Write_VC_Load_Store_Dependency(pipeline_flag, 
									ms,
									last_store,
									expr,
									ofile);

						last_store = expr;
					}
				}
				else if(last_store != NULL && !is_store)
				{
					// dependency between last store and expr.
					Write_VC_Load_Store_Dependency(pipeline_flag, 
							ms,
							last_store,
							expr, 
							ofile);

					// keep track of active loads.
					active_loads.push_back(expr);
				}
				else if(last_store == NULL && !is_store)
				{
					active_loads.push_back(expr);
				}
			} // ignore opaque
		}

		// TODO: in the pipeline case, the last store in the list must
		//       start before the first load/store in the list.  That is,
		//       the ring dependency must be enforced.  Other dependencies
		//       are superfluous!
		if(pipeline_flag)
		{
			Write_VC_Load_Store_Loop_Pipeline_Ring_Dependency(ms,
					leading_accesses,
					trailing_accesses,
					ofile);
			leading_store_found = false;
			leading_accesses.clear();
			trailing_accesses.clear();
		}
	}
}

// pipe accesses will be strictly in order!
void AaBlockStatement::
Write_VC_Pipe_Dependencies(bool pipeline_flag, map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
		ostream& ofile)
{


	for(map<AaPipeObject*,vector<AaRoot*> >::iterator iter = pipe_map.begin(), 
			fiter  = pipe_map.end();
			iter != fiter;
			iter++)
	{

		string pipe_name = (*iter).first->Get_Name();
		AaPipeObject* obj = (*iter).first;

		ofile << "// pipe read/write dependencies for pipe " << pipe_name << endl;

		AaRoot* last_expr = NULL;
		AaRoot* fe = (*iter).second[0];
		bool is_signal = obj->Is_Signal();

		AaRoot* first_expr = (*iter).second[0];
		vector<AaRoot*> write_expr_vector;
		vector<AaRoot*> read_expr_vector;
		vector<AaRoot*> signal_write_vector;
		for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
		{

			AaRoot* expr = (*iter).second[idx];
			if(expr->Is_Expression() ||
					(!AaProgram::_treat_all_modules_as_opaque && 
							expr->Is_Call_Statement() && 
							// volatiles are ignored, as they should be
							!(((AaCallStatement*)expr)->Get_Is_Volatile()) && 
							!expr->Is_Opaque_Call_Statement()))
				// opaque calls are ignored... up to 1-level.
			{
				if(expr->Is_Write_To_Pipe(obj))
				{
					if(is_signal)
						signal_write_vector.push_back(expr);
					else
						write_expr_vector.push_back(expr);
				}
				else	
				{
					if(!is_signal)
						read_expr_vector.push_back(expr);
				}
			}
		}

		ofile << "// read-dependencies for pipe " << pipe_name << endl;
		if(read_expr_vector.size() > 1)
		{
			AaRoot* first_expr = read_expr_vector[0];
			for(int I = 0, fI = read_expr_vector.size(); I < fI; I++)
			{
				if(I == 0) continue;

				AaRoot* first = read_expr_vector[I-1];
				AaRoot* second = read_expr_vector[I];
				__J(__SST(second), __UCT(first));
				if(pipeline_flag && (I == (fI-1)))
				{
					AaRoot* last = read_expr_vector[I];

					ofile << "// ring dependency in pipeline." << endl;
					__MJ(__UST(first_expr), __UCT(last),  true); // bypass.
				}
			}
		}
		ofile << "// write-dependencies for pipe " << pipe_name << endl;
		if(write_expr_vector.size() > 1)
		{
			for(int I = 0, fI = write_expr_vector.size(); I < fI; I++)
			{
				AaRoot* first_expr = write_expr_vector[0];
				if(I == 0) continue;

				AaRoot* first = write_expr_vector[I-1];
				AaRoot* second = write_expr_vector[I];
				__J(__SST(second), __UCT(first));
				if(pipeline_flag && (I == (fI-1)))
				{
					AaRoot* last = write_expr_vector[I];

					ofile << "// ring dependency in pipeline." << endl;
					__MJ(__SST(first_expr), __UCT(last),  true); // bypass.
				}
			}

		}
		ofile << "// signal write dependencies for " << pipe_name << endl;
		if(signal_write_vector.size() > 1)
		{
			int SS = signal_write_vector.size();
			AaRoot* first_expr = signal_write_vector[0];
			AaRoot* last_expr = signal_write_vector[SS-1];

			for(int I = 1; I < SS; I++)
			{
				__J(__SST(signal_write_vector[I]), __UCT(signal_write_vector[I-1]));
			}
			if(pipeline_flag)
			{
				ofile << "// ring dependency in pipeline." << endl;
				__MJ(__SST(first_expr), __UCT(last_expr),  true); // bypass.
			}
		}
	}
}

void AaBlockStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
	if(this->_statement_sequence != NULL)
		this->Write_VC_Links_Optimized(hier_id,this->_statement_sequence, ofile);
}

void AaBlockStatement::Write_VC_Links_Optimized(string hier_id, AaStatement* stmt, ostream& ofile)
{
	vector<AaStatement*> tv;
	tv.push_back(stmt);
	AaStatementSequence* ss = new AaStatementSequence(this,tv);
	this->AaBlockStatement::Write_VC_Links_Optimized(hier_id,ss,ofile);
	delete ss;
}

void AaBlockStatement::Write_VC_Links_Optimized(string hier_id, AaStatementSequence* sseq, ostream& ofile)
{
	if(sseq->Get_Statement_Count() == 1 && sseq->Get_Statement(0)->Is_Block_Statement())
	{
		sseq->Get_Statement(0)->Write_VC_Links_Optimized(hier_id,ofile);
	}
	else
	{
		hier_id = Augment_Hier_Id(hier_id,sseq->Get_VC_Name());
		for(int idx = 0, fidx = sseq->Get_Statement_Count(); idx < fidx; idx++)
		{
			sseq->Get_Statement(idx)->Write_VC_Links_Optimized(hier_id,ofile);
		}
	}
}


// AaSeriesBlockStatement
void AaSeriesBlockStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	ofile << ";;["  << this->Get_VC_Name()  << "] {" << endl;
	this->Write_VC_Control_Path_Optimized_Base(ofile);
	ofile << "}" << endl;
}


void AaSeriesBlockStatement::Write_VC_Control_Path_Optimized_Base(ostream& ofile)
{
	AaStatementSequence* sseq = this->_statement_sequence;
	if(sseq->Get_Statement_Count() > 0)
	{
		vector<AaStatementSequence* > linear_segment_vector;
		this->Identify_Maximal_Sequences(sseq,linear_segment_vector);

		for(int idx = 0, fidx = linear_segment_vector.size(); idx < fidx; idx++)
		{
			AaStatementSequence* curr_seq = linear_segment_vector[idx];
			string block_name = curr_seq->Get_VC_Name();

			if(curr_seq->Get_Statement(0)->Is_Block_Statement())
				curr_seq->Get_Statement(0)->Write_VC_Control_Path_Optimized(ofile);
			else
			{
				// TODO .. rationalize this.
				set<AaRoot*> visited_elements;
				map<AaMemorySpace*, vector<AaRoot*> > load_store_ordering_map;
				map<AaPipeObject*, vector<AaRoot*> >  pipe_map;
				AaRoot* tb = NULL;

				string region_name = curr_seq->Get_VC_Name();
				ofile << "::[" << region_name << "] {" << endl;
				this->AaBlockStatement::Write_VC_Control_Path_Optimized(false,
						curr_seq, 
						visited_elements,
						load_store_ordering_map,
						pipe_map,
						tb,
						ofile);
				this->Write_VC_Load_Store_Dependencies(false, load_store_ordering_map,ofile);
				this->Write_VC_Pipe_Dependencies(false, pipe_map,ofile);
				ofile  << "}" << endl;
			}
		}
		this->Destroy_Maximal_Sequences(linear_segment_vector);
	}
}


void AaSeriesBlockStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
	this->Write_VC_Links_Optimized_Base(hier_id,ofile);
}

void AaSeriesBlockStatement::Write_VC_Links_Optimized_Base(string hier_id, ostream& ofile)
{
	AaStatementSequence* sseq = this->_statement_sequence;
	if(sseq->Get_Statement_Count() > 0)
	{
		vector<AaStatementSequence* > linear_segment_vector;
		this->Identify_Maximal_Sequences(sseq,linear_segment_vector);

		for(int idx = 0, fidx = linear_segment_vector.size(); idx < fidx; idx++)
		{
			AaStatementSequence* curr_seq = linear_segment_vector[idx];
			if(curr_seq->Get_Statement(0)->Is_Block_Statement())
				curr_seq->Get_Statement(0)->Write_VC_Links_Optimized(hier_id,ofile);
			else
				this->AaBlockStatement::Write_VC_Links_Optimized(hier_id,
						curr_seq,
						ofile);
		}
		this->Destroy_Maximal_Sequences(linear_segment_vector);
	}  
}

// parallel block statement
void AaParallelBlockStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	ofile << "||["  << this->Get_VC_Name()  << "] {" << endl;
	AaStatementSequence* sseq = this->_statement_sequence;
	for(int idx = 0; idx < sseq->Get_Statement_Count(); idx++)
	{
		AaStatement* stmt = sseq->Get_Statement(idx);
		if(stmt->Is_Block_Statement())
			stmt->Write_VC_Control_Path_Optimized(ofile);
		else
			this->AaBlockStatement::Write_VC_Control_Path_Optimized(stmt,ofile);
	}
	ofile << "}" << endl;
}


void AaParallelBlockStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
	AaStatementSequence* sseq = this->_statement_sequence;
	for(int idx = 0; idx < sseq->Get_Statement_Count(); idx++)
	{
		AaStatement* stmt = sseq->Get_Statement(idx);
		if(stmt->Is_Block_Statement())
		{
			stmt->Write_VC_Links_Optimized(hier_id,ofile);
		}
		else
		{
			this->AaBlockStatement::Write_VC_Links_Optimized(hier_id,stmt,ofile);
		}
	}
}



// AaForkBlockStatement
void AaForkBlockStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	ofile << "// control-path for fork-block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;


	ofile << "::[" << this->Get_VC_Name() << "] // fork block " << this->Get_Source_Info() << endl << "{";
	// two passes: first print the statements in this
	// block which are NOT fork/joins.
	if(this->_statement_sequence)
	{
		for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(!stmt->Is("AaJoinForkStatement"))
			{
				vector<AaStatement*> tv;

				if(stmt->Is_Block_Statement())
					stmt->Write_VC_Control_Path_Optimized(ofile);
				else
				{
					this->AaBlockStatement::Write_VC_Control_Path_Optimized(stmt,ofile);
				}


			}
		}

		// second pass, print the fork/joins.
		for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(stmt->Is("AaJoinForkStatement"))
				stmt->Write_VC_Control_Path_Optimized(ofile);
		}
	}
	else
	{
		ofile << ";;[DummySB] { $T [dummy] } " << endl;
		ofile << "$entry &-> DummySB" << endl;
		ofile << "$exit <-& DummySB" << endl;
	}
	ofile << "} // end fork block " << this->Get_Source_Info() << endl;
}


void AaForkBlockStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	ofile << "// cp-dp links for fork-block " << this->Get_Hierarchical_Name() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	if(this->_statement_sequence)
	{
		hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
		for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(!stmt->Is("AaJoinForkStatement"))
			{


				if(stmt->Is_Block_Statement())
				{
					stmt->Write_VC_Links_Optimized(hier_id,ofile);
				}
				else
				{
					this->AaBlockStatement::Write_VC_Links_Optimized(hier_id,stmt,ofile);
				}


			}
		}

		// second pass, print the fork/joins.
		for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(stmt->Is("AaJoinForkStatement"))
				stmt->Write_VC_Links_Optimized(hier_id,ofile);
		}
	}
}

// AaBranchBlockStatement
void AaBranchBlockStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	ofile << "<>[" << this->Get_VC_Name() << "] // Branch Block " 
		<< this->Get_Source_Info() << endl << " {" << endl;
	ofile << "$P [" << this->Get_VC_Name() << "__entry__]" << endl;
	ofile << this->Get_VC_Name() << "__entry__ <-| ($entry)" << endl;
	ofile << "$P [" << this->Get_VC_Name() << "__exit__]" << endl;
	ofile << this->Get_VC_Name() << "__exit__ |-> ($exit)" << endl;

	this->Write_VC_Control_Path_Optimized(this->Get_VC_Name() + "__entry__", 
			this->_statement_sequence, 
			this->Get_VC_Name() + "__exit__",
			ofile);

	ofile << "} " << endl;
}


void AaBranchBlockStatement::Write_VC_Control_Path_Optimized(string source_link,
		AaStatementSequence* sseq,
		string sink_link,
		ostream& ofile)
{
	bool dummy_flag = true;
	if(sseq->Get_Statement_Count() > 0)
	{
		vector<AaStatementSequence* > linear_segment_vector;
		this->Identify_Maximal_Sequences(sseq,linear_segment_vector);

		if(linear_segment_vector.size() > 0)
		{
			dummy_flag = false;

			// first write out the places..
			for(int idx = 0, fidx = linear_segment_vector.size();  idx < fidx; idx++)
			{
				AaStatementSequence* sseq = linear_segment_vector[idx];
				AaStatement* stmt = sseq->Get_Statement(0);
				AaStatement* prev = NULL;
				if(idx > 0)
				{
					prev = linear_segment_vector[idx-1]->Get_Statement(0);
				}

				if(!stmt->Is("AaPlaceStatement"))
				{
					if(!stmt->Is("AaMergeStatement"))
						ofile << "$P [" << sseq->Get_VC_Entry_Place_Name() << "] " << endl;
					else
					{
						if(prev == NULL || !prev->Is("AaPlaceStatement"))
						{

							AaMergeStatement* ms = ((AaMergeStatement*)stmt);
							if(ms->Has_Merge_Label("$entry"))
							{
								if(prev != NULL && prev->Is("AaPlaceStatement"))
								{
									AaRoot::Error("merge statement specifies a merge from entry which is unreachable.",
											stmt);
								}
							}
							ms->Set_Has_Entry_Place(true);
							ofile << "$P [" << stmt->Get_VC_Entry_Place_Name() << "] " << endl;
						}
					}
					ofile << "$P [" << sseq->Get_VC_Exit_Place_Name() << "] " << endl;	  
				}
				else
					stmt->Write_VC_Control_Path_Optimized(ofile);
			}

			// second pass, all except merges.
			for(int idx = 0, fidx = linear_segment_vector.size();  idx < fidx; idx++)
			{
				AaStatementSequence* sseq = linear_segment_vector[idx];
				AaStatement* stmt = sseq->Get_Statement(0);

				if(!stmt->Is("AaMergeStatement") && !stmt->Is("AaPlaceStatement"))
				{
					if(stmt->Is_Block_Statement() || stmt->Is_Control_Flow_Statement())
						stmt->Write_VC_Control_Path_Optimized(ofile);
					else 
					{
						set<AaRoot*> visited_elements;
						map<AaMemorySpace*, vector<AaRoot*> > load_store_ordering_map;
						map<AaPipeObject*, vector<AaRoot*> >  pipe_map;
						AaRoot* tb = NULL;

						string region_name = sseq->Get_VC_Name();

						ofile << "::[" << region_name << "] {" << endl;
						this->AaBlockStatement::Write_VC_Control_Path_Optimized(false, 
								sseq, 
								visited_elements,
								load_store_ordering_map,
								pipe_map,
								tb,
								ofile);

						this->Write_VC_Load_Store_Dependencies(false, load_store_ordering_map,ofile);
						this->Write_VC_Pipe_Dependencies(false, pipe_map,ofile);
						ofile  << "}" << endl;
					}

					// control regulated by __entry__ and __exit__ places..
					// except for switch and if statements..
					if(!stmt->Is("AaSwitchStatement") && !stmt->Is("AaIfStatement"))
					{
						// for switch and if, the control flow is a bit more complicated..
						// we do not create an explicit CP region for these statements..
						ofile << sseq->Get_VC_Entry_Place_Name() << " |-> (" << sseq->Get_VC_Name() << ")" << endl;
						ofile << sseq->Get_VC_Exit_Place_Name() << " <-| (" << sseq->Get_VC_Name() << ")" << endl;
					}
				}
			}

			// third pass, the merges.
			for(int idx = 0, fidx = linear_segment_vector.size();  idx < fidx; idx++)
			{
				AaStatementSequence* sseq = linear_segment_vector[idx];
				AaStatement* stmt = sseq->Get_Statement(0);

				if(stmt->Is("AaMergeStatement"))
				{
					stmt->Write_VC_Control_Path(ofile);	  
				}
			}


			// finally, control transfer.
			for(int idx = 0, fidx = linear_segment_vector.size();  idx < fidx; idx++)
			{
				AaStatementSequence* sseq = linear_segment_vector[idx];
				AaStatement* stmt = sseq->Get_Statement(0);

				AaStatementSequence* prev = NULL;
				AaStatementSequence* next = NULL;

				if(idx > 0)
					prev = linear_segment_vector[idx-1];
				if(idx < fidx-1)
				{
					next = linear_segment_vector[idx+1];
				}

				// stmt gets control from its predecessor..
				AaStatement* prev_stmt = (prev != NULL ? prev->Get_Statement(0) : NULL);
				AaStatement* next_stmt = (next != NULL ? next->Get_Statement(0) : NULL);
				if(prev_stmt == NULL)
				{
					ofile << sseq->Get_VC_Entry_Place_Name() << " <-| (" << source_link << ")" << endl;
				}
				else
				{
					if(!prev_stmt->Is("AaPlaceStatement"))
					{
						ofile << sseq->Get_VC_Entry_Place_Name() 
							<< " <-| (" 
							<< prev->Get_VC_Exit_Place_Name() 
							<< ")" << endl;
					}
				}

				if(next_stmt == NULL)
				{
					if(!stmt->Is("AaPlaceStatement"))
					{
						ofile << sseq->Get_VC_Exit_Place_Name() << " |-> (" << sink_link << ")" << endl;
					}

				}
			} 

			// clean up..
			this->Destroy_Maximal_Sequences(linear_segment_vector);
		}      
	}

	if(dummy_flag)
	{
		string plname = source_link + "_to_" + sink_link;
		__Place(plname);
		ofile << plname << " <-| (" << source_link << ")" << endl;
		ofile << plname << " |-> (" << sink_link << ")" << endl;
	}
}


void AaBranchBlockStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name());
	this->Write_VC_Links_Optimized(hier_id, _statement_sequence, ofile);
}

void AaBranchBlockStatement::Write_VC_Links_Optimized(string hier_id,
		AaStatementSequence* sseq_in,
		ostream& ofile)
{
	if(sseq_in->Get_Statement_Count() > 0)
	{

		vector<AaStatementSequence* > linear_segment_vector;
		this->Identify_Maximal_Sequences(sseq_in,linear_segment_vector);

		for(int idx = 0, fidx = linear_segment_vector.size();  idx < fidx; idx++)
		{
			AaStatementSequence* sseq = linear_segment_vector[idx];
			AaStatement* stmt = sseq->Get_Statement(0);

			if(!stmt->Is("AaPlaceStatement"))
			{
				if(stmt->Is_Block_Statement() || stmt->Is_Control_Flow_Statement())
					stmt->Write_VC_Links_Optimized(hier_id, ofile);
				else 
					this->AaBlockStatement::Write_VC_Links_Optimized(hier_id,sseq,ofile);
			}

		}      

		this->Destroy_Maximal_Sequences(linear_segment_vector);
	}
}


// AaJoinForkStatement
void AaJoinForkStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	ofile << "// control-path for join-fork statement " <<  endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	if(_statement_sequence != NULL)
	{
		for(int idx = 0, fidx = _statement_sequence->Get_Statement_Count();
				idx < fidx;
				idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(stmt->Is_Block_Statement())
				stmt->Write_VC_Control_Path_Optimized(ofile);
			else
			{
				this->AaBlockStatement::Write_VC_Control_Path_Optimized(stmt,ofile);
			}
		}
	}


	ofile << "$T [" << this->Get_VC_Name() <<"] // join " << this->Get_Source_Info() << endl;
	if(_join_labels.size() == 0)
	{
		ofile << this->Get_VC_Name() << " <-& ($entry)" <<  endl;
	}
	else
	{
		ofile << this->Get_VC_Name() << " <-& (";
		for(int idx = 0; idx < _wait_on_statements.size(); idx++)
		{
			if(idx > 0)
				ofile << " ";
			ofile << _wait_on_statements[idx]->Get_VC_Name();
		}
		ofile << ")" << endl;
	}

	if(_statement_sequence == NULL)
	{
		ofile << this->Get_VC_Name() << " &-> ($exit)" <<  endl;
	}
	else
	{
		ofile << this->Get_VC_Name() << " &-> (";
		for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
		{
			if(idx > 0)
				ofile << " ";
			ofile << _statement_sequence->Get_Statement(idx)->Get_VC_Name();
		}
		ofile << ")" << endl;
	}
}
void AaJoinForkStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	ofile << "// CP-DP links for join-fork  " << endl;
	ofile << "// " << this->Get_Source_Info() << endl;

	if(_statement_sequence != NULL)
	{
		for(int idx = 0, fidx = _statement_sequence->Get_Statement_Count();
				idx < fidx;
				idx++)
		{
			AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
			if(stmt->Is_Block_Statement())
				stmt->Write_VC_Links_Optimized(hier_id,ofile);
			else
			{
				this->AaBlockStatement::Write_VC_Links_Optimized(hier_id, stmt, ofile);
			}
		}
	}
}


// AaMergeStatement
void AaMergeStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	this->Write_VC_Control_Path(ofile);
}
void AaMergeStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	this->Write_VC_Links(hier_id,ofile);
}

// AaPhiStatement
void AaPhiStatement::Write_VC_WAR_Dependencies(bool pipeline_flag, set<AaRoot*>& visited_elements,
		ostream& ofile)
{
	this->_target->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements, ofile);
}

void AaPhiStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	this->Write_VC_Control_Path(ofile);
}


// implemented for supporting loop pipelining.  This statement should
// be called only if the PHI statement appears in a loop body.
//
//    The control flow instantiates a phi-sequencer and keys off
// the place transitions associated with the loop block body
// in which the statement occurs.
void AaPhiStatement::Write_VC_Control_Path_Optimized(bool pipeline_flag,
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
		map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	bool ok_flag = this->Get_In_Do_While();
	if(!ok_flag)
		assert(0);

	// a bit ugly.
	int relaxed_count, strict_count;
	this->_parent_merge->Get_Phi_Statement_Counts(relaxed_count, strict_count);

	assert(pipeline_flag);


	if(this->_target->Is_Constant())
	{
		ofile << "// constant  PHI statement " << this->Get_VC_Name() << " ignored " << endl;
		ofile << "// " << this->To_String() << endl;
		visited_elements.insert(this);
		return;
	}

	if(this->_source_label_vector.size() == 1)
	{

		this->Write_VC_Control_Path_Optimized_Single_Source(pipeline_flag,
									visited_elements,
									ls_map,
									pipe_map,
									barrier,
									ofile);
		return;
	}
	
	ofile << "// start:  multi-source PHI statement " << this->Get_VC_Name() << (this->Get_Relaxed_Flag() ? "relaxed" : "") << endl;
	ofile << "// " << this->To_String() << endl;
	__DeclTransSplitProtocolPattern;


	//
	// PHI synchronization.
	//
	__T(__SST(this) + "_ps");
	__J((__SST(this) + "_ps"), "aggregated_phi_sample_req");

	__T(__SCT(this) + "_ps");
	__F((__SCT(this) + "_ps"),"aggregated_phi_sample_ack");

	__T(__UST(this) + "_ps");
	if(this->Get_Relaxed_Flag())
	{
		__J((__UST(this) + "_ps"), __UST(this));
	}
	else
	{
		__J((__UST(this) + "_ps"), "aggregated_phi_update_req");
	}

	__T(__UCT(this) + "_ps");
	__J(__UCT(this), __UCT(this) + "_ps");


	// Note that aggregated-phi-update ack
	// is not mentioned here...
	__J("aggregated_phi_sample_req", __SST(this));
        __F("aggregated_phi_sample_ack", __SCT(this));
	if(!this->Get_Relaxed_Flag())
	{
        	__J("aggregated_phi_update_req", __UST(this));
	}


	// the active, completed and the active transitions
	string trigger_from_loop_back = this->Get_VC_Name() + "_loopback_trigger";
	string sample_from_loop_back = this->Get_VC_Name() + "_loopback_sample_req";
	string sample_from_loop_back_ps = this->Get_VC_Name() + "_loopback_sample_req_ps";
	__T(trigger_from_loop_back);
	__J(trigger_from_loop_back,"back_edge_to_loop_body");
	__T(sample_from_loop_back);
	__T(sample_from_loop_back_ps);
	__J(sample_from_loop_back, sample_from_loop_back_ps);

	// loop body exit not determined by this guy.
	__F(sample_from_loop_back, "$null");

	string trigger_from_entry = this->Get_VC_Name() + "_entry_trigger";
	string sample_from_entry = this->Get_VC_Name() + "_entry_sample_req";
	string sample_from_entry_ps = this->Get_VC_Name() + "_entry_sample_req_ps";
	__T(trigger_from_entry);
	__J(trigger_from_entry, "first_time_through_loop_body");
	__T(sample_from_entry);

	__T(sample_from_entry_ps);
	__J(sample_from_entry, sample_from_entry_ps);

	// loop body exit not determined by this guy.
	__F(sample_from_entry, "$null");


	if(pipeline_flag)
	{
		__MJ(__UST(this), __UCT(this), true); // bypass.
		__MJ(__SST(this), __SCT(this), false); // no bypass.
	}

	string msample_req = this->Get_VC_Name() + "_merged_reqs";
	string req_merge_name = this->Get_VC_Name() + "_req_merge";
	__T(msample_req);

	/*
	   No longer required... aggregated_phi_req_merge does the job.
	   string merge_from_entry = sample_from_entry +  "__merge_in";
	   __T(merge_from_entry);
	   __J(merge_from_entry, sample_from_entry);
	   string merge_from_loop_back = sample_from_loop_back +  "__merge_in";
	   __T(merge_from_loop_back);
	   __J(merge_from_loop_back, sample_from_loop_back);

	   ofile << "$transitionmerge [" << req_merge_name << "] (" 
	   << merge_from_entry << " " << merge_from_loop_back << ") (" << msample_req << ")" << endl;
	   __F(msample_req, "$null"); // merged the two and tied the merge as open.
	   */

	vector<string> triggers;
	vector<string> src_sample_reqs;
	vector<string> src_sample_acks;
	vector<string> src_update_reqs;
	vector<string> src_update_acks;
	vector<string> phi_mux_reqs;

	// mux-ack from phi-base going back into 
	// phi-sequencer.
	string phi_mux_ack = this->Get_VC_Name() + "_phi_mux_ack";
	__T(phi_mux_ack);
	string phi_mux_ack_ps = this->Get_VC_Name() + "_phi_mux_ack_ps";
	__T(phi_mux_ack_ps);
	__J(phi_mux_ack_ps, phi_mux_ack);


	// join update-ack to aggregated phi update ack
	__J("aggregated_phi_update_ack", __UCT(this));

	// the source control paths.
	for(int idx = 0, fidx = _source_pairs.size(); idx < fidx; idx++)
	{
		AaExpression* source_expr = _source_pairs[idx].second;
		string trig_place = _source_pairs[idx].first;


		__T(__SST(source_expr) + "_ps");
		__T(__SCT(source_expr) + "_ps");
		__T(__UST(source_expr) + "_ps");
		__T(__UCT(source_expr) + "_ps");

		src_sample_reqs.push_back(__SST(source_expr) + "_ps");
		src_sample_acks.push_back(__SCT(source_expr) + "_ps");
		src_update_reqs.push_back(__UST(source_expr) + "_ps");
		src_update_acks.push_back(__UCT(source_expr) + "_ps");

		if(!source_expr->Is_Constant())
		{
			AaExpression* sge = source_expr->Get_Guard_Expression();
			if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr) && 
					!sge->Is_Volatile_Function_Call() && 
					!sge->Is_Implicit_Variable_Reference() && 
					!sge->Is_Signal_Read() && !sge->Is_Flow_Through())
			{
				ofile << "// guard in Phi alternative" << endl;
				sge->Write_VC_Control_Path_Optimized(pipeline_flag,
						visited_elements,
						ls_map,pipe_map,barrier,
						ofile);

				//
				// This will be taken care of in a unified way.
				//
				//__J(__SST(sge), (__SST(source_expr) + "_ps"));

			}

			if((sge != NULL) && (sge != source_expr))
				sge->Mark_As_Visited(visited_elements);

			bool src_has_no_dpe  = (source_expr->Is_Implicit_Variable_Reference() ||  source_expr->Is_Signal_Read());
			bool src_is_volatile_fn_call  = source_expr->Is_Volatile_Function_Call();
			if(src_has_no_dpe || src_is_volatile_fn_call)
			{
				ofile << "// interlock for implicit-variable-ref/signal-read in Phi alternative " 
					<<  idx <<  endl;
				__T(__SST(source_expr));
				__T(__SCT(source_expr));
				__T(__UST(source_expr));
				__T(__UCT(source_expr));

				string sample_region_name = source_expr->Get_VC_Name() + "_Sample";
				ofile <<  ";;[" << sample_region_name << "] { " << endl;
				ofile << "$T [req] $T [ack] // interlock-sample." << endl;
				ofile << "}" << endl;
				__F(__SST(source_expr), sample_region_name);
				__J(__SCT(source_expr), sample_region_name);

				string update_region_name = source_expr->Get_VC_Name() + "_Update";
				ofile <<  ";;[" << update_region_name << "] { " << endl;
				ofile << "$T [req] $T [ack] // interlock-update." << endl;
				ofile << "}" << endl;
				__F(__UST(source_expr), update_region_name);
				__J(__UCT(source_expr), update_region_name);


				// dont forget!
				source_expr->Mark_As_Visited(visited_elements);
			}

			if(!src_has_no_dpe)
			{
				ofile << "// source expression in Phi alternative " 
					<<  idx <<  endl;
				source_expr->Write_VC_Control_Path_Optimized(pipeline_flag,
						visited_elements,
						ls_map,pipe_map,barrier,
						ofile);
			}


			if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr) && 
					!sge->Is_Implicit_Variable_Reference() && 
					!sge->Is_Signal_Read() && !sge->Is_Flow_Through())
			{
				ofile << "// Guard dependency in PHI alternative.." << endl;
				__J(__SST(source_expr), __UCT(sge));
			}

			if(pipeline_flag)
			{
				if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr) && 
						!sge->Is_Implicit_Variable_Reference() && 
						!sge->Is_Signal_Read() && !sge->Is_Flow_Through())
				{
					sge->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
				}

				source_expr->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
			}
		}
		else
		{
			// source is constant... but phi-sequencer needs dummies.
			ofile << "// dummies for constant expression source for phi" << endl;
			__T(__SST(source_expr));
			__T(__SCT(source_expr));
			__J(__SCT(source_expr), __SST(source_expr));

			__T(__UST(source_expr));
			// delay needed from UST -> UCT.
			ofile << "$T [" << __UCT(source_expr) << "] $delay " << endl;
			__J(__UCT(source_expr), __UST(source_expr));
		}

		// relayed to i/o of phi-sequencer.
		//  This will be taken care of in a unified way.
		if(source_expr->Is_Implicit_Variable_Reference() || 
			source_expr->Is_Volatile_Function_Call() ||
			source_expr->Is_Constant() ||
			source_expr->Is_Signal_Read())
		{
			ofile << "// Phi start dependency for implicit/constant alternative." << endl;
			__J(__SST(source_expr), (__SST(source_expr) + "_ps"));
			__J(__UST(source_expr), (__UST(source_expr) + "_ps"));
		}
		ofile << "// Phi complete dependency." << endl;
		__J((__SCT(source_expr) + "_ps"), __SCT(source_expr));
		__J((__UCT(source_expr) + "_ps"), __UCT(source_expr));

		if(trig_place == "$loopback")
		{
			triggers.push_back(trigger_from_loop_back);
			phi_mux_reqs.push_back(sample_from_loop_back_ps);
		}
		else
		{
			triggers.push_back(trigger_from_entry);
			phi_mux_reqs.push_back(sample_from_entry_ps);
		}
	}

	// the control-sequencing for the PHI is too complicated to
	// model in a normal-fork block. The dirty stuff is hidden
	// in the phi_sequencer.
	ofile << "$phisequencer [ " << this->Get_VC_Name() << "_phi_seq] : " << endl;
	ofile << "     ";
	for(int idx = 0, fidx = triggers.size(); idx < fidx; idx++)
	{
		ofile << triggers[idx] <<  " " << src_sample_reqs[idx] << " "
			<< src_sample_acks[idx] << " " 
			<< src_update_reqs[idx] << " "
			<< src_update_acks[idx] << " ";
	}
	ofile << ":" << endl;
	ofile << "     ";
	ofile << __SST(this)+"_ps" << " " << __SCT(this)+"_ps" << " " << __UST(this)+"_ps" << " " << __UCT(this)+"_ps" << " ";
	ofile << ":" << endl;
	ofile << "     ";

	// sample from entry, sample from loopback.
	for(int idx = 0, fidx = phi_mux_reqs.size(); idx < fidx; idx++)
	{
		ofile <<  phi_mux_reqs[idx] << " ";
	}
	ofile << ": " << endl;
	ofile << "     ";
	ofile << phi_mux_ack_ps << endl;


	// sample-ack from phi must join with condition-evaluated so that
	// loop-back is delayed until the present PHI has sampled.
	// 
	// Note: this is handled at the do-while level using the
	//    aggregated phi-sample-ack.
	//__J("condition_evaluated", __SCT(this));

	// take care of the guard
	if(this->_guard_expression)
	{
		// For the moment, PHI statements cannot have guards.
		AaRoot::Error("Guards for PHI statements are not permitted.", this);
	}

	//this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements, ofile);
	visited_elements.insert(this);
	ofile << "// done: PHI Statement " << this->Get_VC_Name() << endl;
}


//
// This is a hack.. useful when the two alternatives of the phi
// are the same..
//
void AaPhiStatement::Write_VC_Control_Path_Optimized_Single_Source(bool pipeline_flag,
		set<AaRoot*>& visited_elements,
		map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
		map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{

	
	// a bit ugly.
	int relaxed_count, strict_count;
	this->_parent_merge->Get_Phi_Statement_Counts(relaxed_count, strict_count);

	ofile << "// start:  single source PHI statement " << this->Get_VC_Name() << (this->Get_Relaxed_Flag() ? "relaxed" : "") << endl;
	ofile << "// " << this->To_String() << endl;
	__DeclTransSplitProtocolPattern;

        __J("aggregated_phi_sample_req", __SST(this));
        __F("aggregated_phi_sample_ack", __SCT(this));
	
	if(!this->Get_Relaxed_Flag())
	{
        	__J("aggregated_phi_update_req", __UST(this));
	}

	AaExpression* source_expr = (*(this->_source_label_vector.begin())).first;

	AaExpression* sge = source_expr->Get_Guard_Expression();
	if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr) && 
			!sge->Is_Implicit_Variable_Reference() && 
			!sge->Is_Signal_Read() && !sge->Is_Flow_Through())
	{
		ofile << "// guard in Phi alternative" << endl;
		sge->Write_VC_Control_Path_Optimized(pipeline_flag,
				visited_elements,
				ls_map,pipe_map,barrier,
				ofile);

		//
		// This will be taken care of in a unified way.
		//
		//__J(__SST(sge), (__SST(source_expr) + "_ps"));

	}

	if((sge != NULL) && (sge != source_expr))
		sge->Mark_As_Visited(visited_elements);

	bool src_has_no_dpe  = 
		(source_expr->Is_Implicit_Variable_Reference() ||  source_expr->Is_Signal_Read());
	bool src_is_volatile_fn_call = source_expr->Is_Volatile_Function_Call();
	if(src_has_no_dpe || src_is_volatile_fn_call)
	{
		ofile << "// interlock for implicit-variable-ref/signal-read in single-source phi" 
			<<   endl;
		__T(__SST(source_expr));
		__T(__SCT(source_expr));
		__T(__UST(source_expr));
		__T(__UCT(source_expr));

		string sample_region_name = source_expr->Get_VC_Name() + "_Sample";
		ofile <<  ";;[" << sample_region_name << "] { " << endl;
		ofile << "$T [req] $T [ack] // interlock-sample." << endl;
		ofile << "}" << endl;
		__F(__SST(source_expr), sample_region_name);
		__J(__SCT(source_expr), sample_region_name);

		string update_region_name = source_expr->Get_VC_Name() + "_Update";
		ofile <<  ";;[" << update_region_name << "] { " << endl;
		ofile << "$T [req] $T [ack] // interlock-update." << endl;
		ofile << "}" << endl;
		__F(__UST(source_expr), update_region_name);
		__J(__UCT(source_expr), update_region_name);


		// dont forget!
		if(src_has_no_dpe)
			source_expr->Mark_As_Visited(visited_elements);
	}

	if(!src_has_no_dpe)
	{
		ofile << "// non-implicit source expression in single-source phi" <<  endl;
		source_expr->Write_VC_Control_Path_Optimized(pipeline_flag,
				visited_elements,
				ls_map,pipe_map,barrier,
				ofile);
	}


	if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr) && 
			!sge->Is_Implicit_Variable_Reference() && 
			!sge->Is_Signal_Read() && !sge->Is_Flow_Through())
	{
		ofile << "// Guard dependency in PHI alternative.." << endl;
		__J(__SST(source_expr), __UCT(sge));
	}

	if(pipeline_flag)
	{
		if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr) && 
				!sge->Is_Implicit_Variable_Reference() && 
				!sge->Is_Signal_Read() && !sge->Is_Flow_Through())
		{
			sge->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
		}

		source_expr->Write_VC_Update_Reenables(this, __SCT(this), true, visited_elements, ofile);
	}

	__F ("aggregated_phi_sample_req", __SST(source_expr));
	__J ("aggregated_phi_sample_ack", __SCT(source_expr));

	if(this->Get_Relaxed_Flag())
	{
		__F (__UST(this), __UST(source_expr));

	}
	else
	{
		__F ("aggregated_phi_update_req", __UST(source_expr));
	}

	__J (__UCT(this), __UCT(source_expr));
        __J ("aggregated_phi_update_ack", __UCT(this));

	visited_elements.insert(this);
	ofile << "// done: PHI Statement " << this->Get_VC_Name() << endl;
}

// called only if it appears in a do-while loop.
void AaPhiStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	bool ok_flag = this->Get_In_Do_While();
	if(!ok_flag)
		assert(0);

	if(!this->Is_Single_Source() && !this->_target->Is_Constant())
	{
		vector<string> reqs;
		vector<string> acks;

		string sample_from_loop_back = this->Get_VC_Name() + "_loopback_sample_req";
		string sample_from_entry = this->Get_VC_Name() + "_entry_sample_req";

		for(int idx = 0, fidx = _source_pairs.size(); idx < fidx; idx++)
		{
			string trig_place = _source_pairs[idx].first;
			if(trig_place == "$loopback")
				reqs.push_back(hier_id + "/" + sample_from_loop_back);
			else
				reqs.push_back(hier_id + "/" + sample_from_entry);
		}
		acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_phi_mux_ack");
		Write_VC_Link(this->Get_VC_Name(),reqs,acks,ofile);
	}

	set<AaExpression*> sset;
	for(int idx = 0, fidx = _source_pairs.size(); idx < fidx; idx++)
	{
		AaExpression* source_expr = _source_pairs[idx].second;
		if(sset.find(source_expr) == sset.end())
		{
			sset.insert(source_expr);
			bool src_has_no_dpe  = (source_expr->Is_Implicit_Variable_Reference() ||  source_expr->Is_Signal_Read());
			bool src_has_trivial_dpe = (!src_has_no_dpe && (source_expr->Is_Trivial() && source_expr->Get_Is_Intermediate()));
			bool src_is_volatile_fn_call  = source_expr->Is_Volatile_Function_Call();
			if(!source_expr->Is_Constant() && 
				(src_has_no_dpe || src_has_trivial_dpe || src_is_volatile_fn_call))
			{
				// interlock.
				vector<string> reqs;
				vector<string> acks;
				string dpe_name = source_expr->Get_VC_Driver_Name() + "_" +
					Int64ToStr(source_expr->Get_Index()) +  "_buf";
				string sample_region_name = source_expr->Get_VC_Name() + "_Sample";
				string update_region_name = source_expr->Get_VC_Name() + "_Update";
				reqs.push_back(hier_id + "/" + sample_region_name + "/req");
				reqs.push_back(hier_id + "/" + update_region_name + "/req");
				acks.push_back(hier_id + "/" + sample_region_name + "/ack");
				acks.push_back(hier_id + "/" + update_region_name + "/ack");
				Write_VC_Link(dpe_name, reqs, acks, ofile);
			}
			else
			{
				source_expr->Write_VC_Links_Optimized(hier_id, ofile);
			}
		}
	}
}

// AaSwitchStatement
void AaSwitchStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	this->Write_VC_Control_Path(true, ofile);
}
void AaSwitchStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	this->Write_VC_Links(true, hier_id, ofile);
}

// AaIfStatement
void AaIfStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
	this->Write_VC_Control_Path(true, ofile);  
}

void AaIfStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	this->Write_VC_Links(true, hier_id,ofile);
}
