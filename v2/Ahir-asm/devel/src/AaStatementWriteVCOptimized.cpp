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
			if(visited_elements.find(stmt) != visited_elements.end())
			{
				ofile << "// forced synch" << endl;
				__J(__SST(this), __UCT(stmt));
				if(pipeline_flag)
				{
					__MJ(__UST(stmt), __SCT(this), true); // bypass
				}
			}
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
	this->Write_VC_Control_Path(ofile);
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
		map<string, vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{
	if(this->Is_Constant())
	{
		return;
	}
	else  if(this->Get_Is_Volatile())
	{
		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;
		ofile << "// volatile.. " << endl;
		if(this->_guard_expression)
		{
			AaRoot::Error("Volatile statement cannot have guard expression.", this);
		}

		this->_source->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements, ls_map,
									pipe_map, barrier, ofile);

		if(!this->_target->Is_Implicit_Variable_Reference())
		{
			AaRoot::Error("Target of volatile statement must be an implicit variable reference..", this);
		}
		else
		{
			AaRoot* robj = this->_target->Get_Root_Object();
			if(robj->Is_Interface_Object())
			{
				if((this->Get_Root_Scope() == NULL) || 
						!this->Get_Root_Scope()->Get_Is_Volatile())
					AaRoot::Error("Target of volatile statement cannot be an interface object..", this);
			}
		}

		
		bool source_is_implicit = (_source->Is_Signal_Read() || _source->Is_Implicit_Variable_Reference());

		// target has to be implicit..  but if source is also
		// implicit, we will declare the transitions for
		// this statement.
		if(source_is_implicit)
		{
			__DeclTransSplitProtocolPattern;
			__J(__SST(this), __UCT(this->_source));
			__FlowThroughConnectSplitProtocolPattern;
		}

		//
		// WAR dependencies
		// If a WAR dependency exists, this will flag an error..
		//
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);

		visited_elements.insert(this);
	}
	else
	{
		ofile << "// " << this->To_String() << endl;
		ofile << "// " << this->Get_Source_Info() << endl;

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


		// if both are implicit, then declare an interlock.
		bool source_is_implicit = (_source->Is_Signal_Read() || _source->Is_Implicit_Variable_Reference());
		bool target_is_implicit = _target->Is_Implicit_Variable_Reference();

		// declare explicitly if target and source are both implicit.
		// else one of the two will define the transitions for this
		// statement.
		if(target_is_implicit && source_is_implicit)
		{
			__DeclTransSplitProtocolPattern;
		}

		ofile << "// Target expression" << endl;
		this->_target->Write_VC_Control_Path_As_Target_Optimized(pipeline_flag,
				visited_elements,
				ls_map,pipe_map,barrier,
				ofile);

		// four cases.
		if(source_is_implicit && target_is_implicit)
			// both are implicit.. introduce an interlock.
		{
			if(source_is_implicit)
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
			}
			else
			{
				__J(__SST(this), __UCT(this->_source));
				__FlowThroughConnectSplitProtocolPattern;
			}


			if(this->_guard_expression)
			{
				if(!this->_guard_expression->Is_Constant())
				{
					if(source_is_implicit)
					{
						ofile << "// Guard dependency" << endl;
						__J(__SST(this), __UCT(this->_guard_expression));
						if(pipeline_flag)
						{
							this->_guard_expression->Write_VC_Update_Reenables(this, __SCT(this), false,
								visited_elements, ofile);
						}
					}
					else
					// is signal-read.
					{
						ofile << "// Guard dependency" << endl;
						__J(__SST(_source), __UCT(this->_guard_expression));
					}
				}

			}

			__J(__SST(this), __UCT(this->_source));
			if(pipeline_flag)
			{
				this->_source->Write_VC_Update_Reenables(this, __SCT(this), false,
						visited_elements, ofile);
				__SelfReleaseSplitProtocolPattern
			}
		}

		// WAR dependencies
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);

		if(!target_is_implicit && !this->_source->Is_Constant())
		{
			__J(__SST(this->_target), __UCT(this->_source));
			if(pipeline_flag)
			{
				this->_source->Write_VC_Update_Reenables(this, __SCT(this->_target), false,
						visited_elements, ofile);
			}
		}

		if(target_is_implicit)
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

		this->Write_VC_Synch_Dependency(visited_elements, pipeline_flag, ofile);
		visited_elements.insert(this);
	}
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
		bool source_is_implicit = (_source->Is_Signal_Read() || _source->Is_Implicit_Variable_Reference());
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
		map<string, vector<AaExpression*> >& ls_map,
		map<string, vector<AaExpression*> >& pipe_map,
		AaRoot* barrier,
		ostream& ofile)
{

	ofile << "// " << this->To_String() << endl;
	ofile << "// " << this->Get_Source_Info() << endl;
	bool volatile_flag = false;
	if(this->Get_Is_Volatile())
	{
		ofile << "// volatile.. " << endl;
		if(this->_guard_expression)
			AaRoot::Error("Volatile statement cannot have  a guard." , this);

		__DeclTransSplitProtocolPattern;
		__FlowThroughConnectSplitProtocolPattern;
		for(int idx = 0; idx < _input_args.size(); idx++)
		{
			ofile << "// Call input argument " << idx << endl;
			AaExpression* expr = _input_args[idx];
			if(!expr->Is_Constant())
			{
				expr->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);
				__J(__SST(this), __UCT(expr));
			}
		}
		for(int idx = 0; idx < _output_args.size(); idx++)
		{
			AaExpression* expr = _output_args[idx];


			if(!expr->Is_Implicit_Variable_Reference())
			{
				AaRoot::Error("Volatile call statement must have implicit output args." , this);
			}
			else
			{
				AaRoot* robj = expr->Get_Root_Object();
				if(robj->Is_Interface_Object())
				{
					if((this->Get_Root_Scope() == NULL) || 
						!this->Get_Root_Scope()->Get_Is_Volatile())
						AaRoot::Error("Target of volatile statement cannot be an interface object..", this);
				}
			}

			ofile << "// Call output argument " << idx << endl;
			expr->Write_VC_Control_Path_As_Target_Optimized(pipeline_flag,
					visited_elements,ls_map,pipe_map,barrier,ofile);

			if(!expr->Is_Constant() && !expr->Is_Implicit_Variable_Reference())
				__J(__SST(expr), __UCT(this));
		}
		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);
		visited_elements.insert(this);
	} 
	else
	{
		__DeclTransSplitProtocolPattern;

		// take care of the guard
		if(this->_guard_expression)
		{

			if(!this->_guard_expression->Is_Constant())
			{
				ofile << "// Guard expression" << endl;
				this->_guard_expression->Write_VC_Control_Path_Optimized(pipeline_flag, visited_elements,ls_map,pipe_map,barrier,ofile);

				__J(__SST(this),__UCT(this->_guard_expression));

				if(pipeline_flag)
				{
					this->_guard_expression->Write_VC_Update_Reenables(this, __SCT(this), false,
							visited_elements, ofile);
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
			if(!expr->Is_Constant())
			{
				__J(__SST(this), __UCT(expr));

				if(pipeline_flag)
				{
					// expression evaluation will be reenabled by activation of the
					// call.
					expr->Write_VC_Update_Reenables(this, __SCT(this), false,
							visited_elements, ofile);
				}
			}
		}

		// the call-trigger will start the call..
		ofile << ";;[" << this->Get_VC_Name() << "_Sample] { " 
			<< "$T [crr] $T [cra] "
			<< "} " << endl;
		// the call will eventually complete.
		ofile << ";;[" << this->Get_VC_Name() << "_Update] { " 
			<< "$T [ccr] $T [cca] "
			<< "} " << endl;
		__ConnectSplitProtocolPattern;


		// the output arguments.
		bool non_triv_flag = false;
		for(int idx = 0; idx < _output_args.size(); idx++)
		{
			AaExpression* expr = _output_args[idx];

			ofile << "// Call output argument " << idx << endl;
			expr->Write_VC_Control_Path_As_Target_Optimized(pipeline_flag,
					visited_elements,ls_map,pipe_map,barrier,ofile);
			if(!expr->Is_Implicit_Variable_Reference())
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


			AaRoot* root_obj = expr->Get_Root_Object();
			if(root_obj == ((AaRoot*) this))
				visited_elements.insert(this);
			else if ((root_obj != NULL) && (root_obj->Is("AaInterfaceObject")))
			{
				visited_elements.insert(this);
				visited_elements.insert(root_obj);
			}
		}

		this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements,ofile);
		this->Write_VC_Synch_Dependency(visited_elements, pipeline_flag, ofile);
		visited_elements.insert(this);


		// if pipeline-flag, then re-enable..
		if(pipeline_flag)
		{
			__SelfReleaseSplitProtocolPattern
		}

	}
}


void AaCallStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
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

			// some statements are just ignored.
			if(stmt->Is_Null_Like_Statement())
			{
				end_idx++;
				continue;
			}

					
			// barrier_due_to_side_effects.
			bool barrier_due_to_side_effects = false;
			if(stmt->Is("AaCallStatement"))
			{
				AaModule* cm =  ((AaModule*)(((AaCallStatement*)stmt)->Get_Called_Module()));
				if(!cm->Has_No_Side_Effects())
					barrier_due_to_side_effects = true;
			}
			if( stmt->Is_Block_Statement()  || 
				stmt->Is_Control_Flow_Statement() || 
					barrier_due_to_side_effects || stmt->Can_Block(false))
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
	map<string, vector<AaExpression*> > load_store_ordering_map;
	map<string, vector<AaExpression*> >  pipe_map;
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
		map<string,vector<AaExpression*> >& load_store_ordering_map,
		map<string,vector<AaExpression*> >& pipe_map,
		AaRoot*& trailing_barrier,
		ostream& ofile)
{
	if(sseq->Get_Statement_Count() == 1 && sseq->Get_Statement(0)->Is_Block_Statement())
		sseq->Get_Statement(0)->Write_VC_Control_Path_Optimized(ofile);
	else
	{
		/////////////////////////////////////////////////  CORE FUNCTIONALITY /////////////////////////////////////////////////////
		trailing_barrier = NULL;
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

			// barriers:
			//   to maintain ordering dependencies, we will create a
			//   barrier if
			//      stmt is a block statement (it may modify memory/access a pipe)
			//      stmt is a call which modifies memory or writes to a pipe.
			// this can be made less restrictive. 
			bool barrier_due_to_side_effects = false;
			if(stmt->Is("AaCallStatement"))
			{
				AaModule* cm =  ((AaModule*)(((AaCallStatement*)stmt)->Get_Called_Module()));
				if(!cm->Has_No_Side_Effects() && !pipeline_flag)
					barrier_due_to_side_effects = true;
			}

			if(stmt->Is_Block_Statement() ||  barrier_due_to_side_effects || stmt->Can_Block(pipeline_flag))
			{
				trailing_barrier = stmt;
				ofile << "// barrier: " << stmt->To_String() << endl;

				// put dependencies from all prior statements 
				// to the barrier
				for(int K = idx-1; K >= 0; K--)
				{
					AaStatement* prev_stmt = sseq->Get_Statement(K);

					// if prev_stmt is a constant or can be ignored, then skip it.
					if(prev_stmt->Is_Constant() || prev_stmt->Is_Null_Like_Statement())
						continue;

					__J(__SST(stmt), __UCT(prev_stmt));
					if(prev_stmt->Is_Block_Statement() || (prev_stmt->Is("AaCallStatement") && 
								!((AaModule*)(((AaCallStatement*)prev_stmt)->Get_Called_Module()))->Has_No_Side_Effects())
							|| prev_stmt->Can_Block(pipeline_flag))
					{
						break;
					}
				}
			}
		}
	}
}



// load store dependencies.
void AaBlockStatement::
Write_VC_Load_Store_Dependencies(bool pipeline_flag, map<string,vector<AaExpression*> >& load_store_dep_map,
		ostream& ofile)
{

	bool leading_store_found = false;
	set<AaExpression*> leading_accesses;

	set<AaExpression*> trailing_accesses;
	ofile << "// load-store dependencies.." << endl;
	// for each memory space, scan the ordered list of 
	// load-stores, and add dependencies as follows
	//    - start->start dependencies between every load
	//      and nearest store before and after the load
	//    - start->start dependencies between adjacent
	//      stores.
	for(map<string,vector<AaExpression*> >::iterator iter = load_store_dep_map.begin(), 
			fiter  = load_store_dep_map.end();
			iter != fiter;
			iter++)
	{
		vector<AaExpression*> active_loads;
		AaExpression* last_store = NULL;

		string mem_space_name = (*iter).first;

		for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
		{
			AaExpression* expr = (*iter).second[idx];


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
				if(expr->Is_Store())
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

			if(expr->Is_Store())
			{


				if(active_loads.size() > 0)
				{
					// dependency between active loads and
					// expr start.
					for(int lsi = 0, flsi = active_loads.size(); lsi < flsi; lsi++)
					{
						Write_VC_Load_Store_Dependency(pipeline_flag, active_loads[lsi],expr,ofile);
					}

					// active load dependencies are taken care of
					active_loads.clear();
					last_store = expr;
				}
				else
				{
					if(last_store != NULL)
						Write_VC_Load_Store_Dependency(pipeline_flag, last_store,expr,ofile);

					last_store = expr;
				}
			}
			else if(last_store != NULL && expr->Is_Load())
			{
				// dependency between last store and expr.
				Write_VC_Load_Store_Dependency(pipeline_flag, last_store,expr,ofile);

				// keep track of active loads.
				active_loads.push_back(expr);
			}
			else if(last_store == NULL && expr->Is_Load())
			{
				active_loads.push_back(expr);
			}
		}

		// TODO: in the pipeline case, the last store in the list must
		//       start before the first load/store in the list.  That is,
		//       the ring dependency must be enforced.  Other dependencies
		//       are superfluous!
		if(pipeline_flag)
		{
			Write_VC_Load_Store_Loop_Pipeline_Ring_Dependency(mem_space_name,
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
Write_VC_Pipe_Dependencies(bool pipeline_flag, map<string,vector<AaExpression*> >& pipe_map,
		ostream& ofile)
{


	for(map<string,vector<AaExpression*> >::iterator iter = pipe_map.begin(), 
			fiter  = pipe_map.end();
			iter != fiter;
			iter++)
	{

		ofile << "// pipe read/write dependencies for pipe " << (*iter).first << endl;
		AaExpression* last_expr = NULL;
		string pipe_name = (*iter).first;
		AaExpression* fe = (*iter).second[0];

		AaRoot* obj = fe->Get_Object();
		assert((obj != NULL) && (obj->Is_Pipe_Object()));
		bool is_signal = obj->Is_Signal();
	
		AaExpression* first_expr = (*iter).second[0];
		vector<AaExpression*> write_expr_vector;
		vector<AaExpression*> read_expr_vector;
		vector<AaExpression*> signal_access_vector;
		for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
		{

			AaExpression* expr = (*iter).second[idx];
			if(is_signal)
				signal_access_vector.push_back(expr);
			else if(expr->Get_Is_Target())
				write_expr_vector.push_back(expr);
			else
				read_expr_vector.push_back(expr);
		}

		ofile << "// read-dependencies for pipe " << (*iter).first << endl;
		if(read_expr_vector.size() > 1)
		{
			AaExpression* first_expr = read_expr_vector[0];
			for(int I = 0, fI = read_expr_vector.size(); I < fI; I++)
			{
				if(I == 0) continue;

				AaExpression* first = read_expr_vector[I-1];
				AaExpression* second = read_expr_vector[I];
				__J(__SST(second), __UCT(first));
				if(pipeline_flag && (I == (fI-1)))
				{
					AaExpression* last = read_expr_vector[I];

					ofile << "// ring dependency in pipeline." << endl;
					__MJ(__UST(first_expr), __UCT(last),  true); // bypass.
				}
			}
		}
		ofile << "// write-dependencies for pipe " << (*iter).first << endl;
		if(write_expr_vector.size() > 1)
		{
			for(int I = 0, fI = write_expr_vector.size(); I < fI; I++)
			{
				AaExpression* first_expr = write_expr_vector[0];
				if(I == 0) continue;

				AaExpression* first = write_expr_vector[I-1];
				AaExpression* second = write_expr_vector[I];
				string delay_trans_name = "delay_transition_" +
								Int64ToStr(first->Get_Index()) + "_" +
								Int64ToStr(second->Get_Index());

				ofile << "$T [" << delay_trans_name << "] $delay" <<  endl;
				__J(delay_trans_name, __SCT(first));	
				__J(__SST(second), delay_trans_name);
				if(pipeline_flag && (I == (fI-1)))
				{
					AaExpression* last = write_expr_vector[I];

					ofile << "// ring dependency in pipeline." << endl;
					__MJ(__SST(first_expr), __SCT(last),  false); // no-bypass.
				}
			}

		}
		ofile << "// signal dependencies for " << pipe_name << endl;
		if(signal_access_vector.size() > 1)
		{
			int SS = signal_access_vector.size();
			AaExpression* first_expr = signal_access_vector[0];
			AaExpression* last_expr = signal_access_vector[SS-1];

			for(int I = 1; I < SS; I++)
			{
				__J(__SST(signal_access_vector[I]), __UCT(signal_access_vector[I-1]));
			}
			if(pipeline_flag)
			{
				ofile << "// ring dependency in pipeline." << endl;
				__MJ(__SST(first_expr), __UCT(last_expr),  false); // no-bypass.
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
				map<string, vector<AaExpression*> > load_store_ordering_map;
				map<string, vector<AaExpression*> >  pipe_map;
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
						map<string, vector<AaExpression*> > load_store_ordering_map;
						map<string, vector<AaExpression*> >  pipe_map;
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
						     map<string, vector<AaExpression*> >& ls_map,
						     map<string,vector<AaExpression*> >& pipe_map,
						     AaRoot* barrier,
						     ostream& ofile)
{
  bool ok_flag = this->Get_In_Do_While();
  if(!ok_flag)
    assert(0);

  assert(pipeline_flag);

  ofile << "// (pipelined) PHI statement " << this->Get_VC_Name() << endl;
  ofile << "// " << this->To_String() << endl;
  __DeclTransSplitProtocolPattern;

   //
   // PHI synchronization.
   //
  __T(__SST(this) + "_ps");
  __J("aggregated_phi_sample_req", __SST(this));
  __J((__SST(this) + "_ps"), "aggregated_phi_sample_req");

  __T(__SCT(this) + "_ps");
  __F((__SCT(this) + "_ps"),"aggregated_phi_sample_ack");
  __F("aggregated_phi_sample_ack", __SCT(this));

  __T(__UST(this) + "_ps");
  __J("aggregated_phi_update_req", __UST(this));
  __J((__UST(this) + "_ps"), "aggregated_phi_update_req");

  __T(__UCT(this) + "_ps");
  __F((__UCT(this) + "_ps"), "aggregated_phi_update_ack");
  __F("aggregated_phi_update_ack", __UCT(this));

  // the active, completed and the active transitions
  string trigger_from_loop_back = this->Get_VC_Name() + "_loopback_trigger";
  string sample_from_loop_back = this->Get_VC_Name() + "_loopback_sample_req";
  __T(trigger_from_loop_back);
  __J(trigger_from_loop_back,"back_edge_to_loop_body");
  __T(sample_from_loop_back);

  string trigger_from_entry = this->Get_VC_Name() + "_entry_trigger";
  string sample_from_entry = this->Get_VC_Name() + "_entry_sample_req";
  __T(trigger_from_entry);
  __J(trigger_from_entry, "first_time_through_loop_body");
  __T(sample_from_entry);



  if(pipeline_flag)
  {
	__MJ(__UST(this), __UCT(this), true); // bypass.
	__MJ(__SST(this), __SCT(this), false); // no bypass.
  }

  string msample_req = this->Get_VC_Name() + "_merged_reqs";
  string req_merge_name = this->Get_VC_Name() + "_req_merge";
  __T(msample_req);

  string merge_from_entry = sample_from_entry +  "__merge_in";
  __T(merge_from_entry);
  __J(merge_from_entry, sample_from_entry);
  string merge_from_loop_back = sample_from_loop_back +  "__merge_in";
  __T(merge_from_loop_back);
  __J(merge_from_loop_back, sample_from_loop_back);
 
  ofile << "$transitionmerge [" << req_merge_name << "] (" 
	<< merge_from_entry << " " << merge_from_loop_back << ") (" << msample_req << ")" << endl;
  __F(msample_req, "$null"); // merged the two and tied the merge as open.

  vector<string> triggers;
  vector<string> src_sample_reqs;
  vector<string> src_sample_acks;
  vector<string> src_update_reqs;
  vector<string> src_update_acks;
  vector<string> phi_mux_reqs;

  string phi_mux_ack = this->Get_VC_Name() + "_phi_mux_ack";
  __T(phi_mux_ack);
  string phi_mux_ack_ps = this->Get_VC_Name() + "_phi_mux_ack_ps";
  __T(phi_mux_ack_ps);
  __J(phi_mux_ack_ps, phi_mux_ack);

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
	      if((sge != NULL) && !sge->Is_Constant() && (sge != source_expr))
	      {
		      sge->Write_VC_Control_Path_Optimized(pipeline_flag,
				      visited_elements,
				      ls_map,pipe_map,barrier,
				      ofile);

			__J(__SST(sge), (__SST(source_expr) + "_ps"));
			
	      }

	      bool src_has_no_dpe  = (source_expr->Is_Implicit_Variable_Reference() ||  source_expr->Is_Signal_Read());
	      bool src_has_trivial_dpe = (!src_has_no_dpe && (source_expr->Is_Trivial() && source_expr->Get_Is_Intermediate()));
	      if(src_has_no_dpe || src_has_trivial_dpe)
		{
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
	      else
		{
	      		source_expr->Write_VC_Control_Path_Optimized(pipeline_flag,
			      visited_elements,
			      ls_map,pipe_map,barrier,
			      ofile);
		}
	

	      if(sge != NULL)
	      {
		      ofile << "// Guard dependency in PHI alternative.." << endl;
		      __J(__SST(source_expr), __UCT(sge));
	      }

	      if(pipeline_flag)
	      {
		      if(sge != NULL)
		      {
			      sge->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
		      }

		      source_expr->Write_VC_Update_Reenables(this, __SCT(this), false, visited_elements, ofile);
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
      __J(__SST(source_expr), (__SST(source_expr) + "_ps"));
      __J((__SCT(source_expr) + "_ps"), __SCT(source_expr));
      __J(__UST(source_expr), (__UST(source_expr) + "_ps"));
      __J((__UCT(source_expr) + "_ps"), __UCT(source_expr));

      if(trig_place == "$loopback")
      {
	      triggers.push_back(trigger_from_loop_back);
	      phi_mux_reqs.push_back(sample_from_loop_back);
      }
      else
      {
	      triggers.push_back(trigger_from_entry);
	      phi_mux_reqs.push_back(sample_from_entry);
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
  for(int idx = 0, fidx = phi_mux_reqs.size(); idx < fidx; idx++)
  {
	ofile <<  phi_mux_reqs[idx] << " ";
  }
  ofile << ": " << endl;
  ofile << "     ";
  ofile << phi_mux_ack << endl;

  // sample-ack from phi must join with condition-evaluated so that
  // loop-back is delayed until the present PHI has sampled.
  __J("condition_evaluated", __SCT(this));

  // take care of the guard
  if(this->_guard_expression)
  {
	  // For the moment, PHI statements cannot have guards.
	  AaRoot::Error("Guards for PHI statements are not permitted.", this);
  }

  this->Write_VC_WAR_Dependencies(pipeline_flag, visited_elements, ofile);
  visited_elements.insert(this);
}

// called only if it appears in a do-while loop.
void AaPhiStatement::Write_VC_Links_Optimized(string hier_id, ostream& ofile)
{
	bool ok_flag = this->Get_In_Do_While();
	if(!ok_flag)
		assert(0);

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

	for(int idx = 0, fidx = _source_pairs.size(); idx < fidx; idx++)
	{
		AaExpression* source_expr = _source_pairs[idx].second;
	        bool src_has_no_dpe  = (source_expr->Is_Implicit_Variable_Reference() ||  source_expr->Is_Signal_Read());
	        bool src_has_trivial_dpe = (!src_has_no_dpe && (source_expr->Is_Trivial() && source_expr->Get_Is_Intermediate()));
		if(!source_expr->Is_Constant() && (src_has_no_dpe || src_has_trivial_dpe))
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
