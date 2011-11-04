#include <AaProgram.h>
#include <Aa2VC.h>

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

void AaAssignmentStatement::Write_VC_WAR_Dependencies(set<AaRoot*>& visited_elements,
						      ostream& ofile)
{

  if(!this->Is_Constant())
    {
      AaExpression* tgt = this->_target;
      
      if(tgt->Is_Implicit_Variable_Reference())
	tgt->Write_VC_WAR_Dependencies(visited_elements,this->_source,ofile);
    }

}


void AaAssignmentStatement::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
							    map<string, vector<AaExpression*> >& ls_map,
							    map<string, vector<AaExpression*> >& pipe_map,
							    ostream& ofile)
{

  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;
      ofile << "// " << this->Get_Source_Info() << endl;


      __T(this->Get_VC_Active_Transition_Name());
      __T(this->Get_VC_Completed_Transition_Name());


      // write the source side expressions and their 
      // dependencies..
      if(!this->_source->Is_Constant())
	{
	  this->_source->Write_VC_Control_Path_Optimized(visited_elements,
							 ls_map,pipe_map,
							 ofile);
	  
	  __J(this->Get_VC_Active_Transition_Name(), _source->Get_VC_Complete_Region_Name());
	}
      


      
      this->_target->Write_VC_Control_Path_As_Target_Optimized(visited_elements,
							       ls_map,pipe_map,
							       ofile);




      if(!this->_target->Is_Implicit_Variable_Reference())
	{
	  __J(_target->Get_VC_Start_Transition_Name(),this->Get_VC_Active_Transition_Name());
	  __J(this->Get_VC_Completed_Transition_Name(), _target->Get_VC_Complete_Region_Name());
	}
      else
	{
	  __J(this->Get_VC_Completed_Transition_Name(), this->Get_VC_Active_Transition_Name());
	}


      // WAR dependencies
      this->Write_VC_WAR_Dependencies(visited_elements,ofile);

      bool source_is_implicit = _source->Is_Implicit_Variable_Reference();
      bool target_is_implicit = _target->Is_Implicit_Variable_Reference();
      if(source_is_implicit && target_is_implicit)
	{
	  ofile <<  ";;[" << this->Get_VC_Name() << "_register] { " << endl;
	  ofile << "$T [req] $T [ack] // register." << endl;
	  ofile << "}" << endl;
	  
	  __F(this->Get_VC_Active_Transition_Name(), this->Get_VC_Name() + "_register");
	  __J(this->Get_VC_Completed_Transition_Name(), this->Get_VC_Name() + "_register");

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
	bool source_is_implicit = _source->Is_Implicit_Variable_Reference();
	bool target_is_implicit = _target->Is_Implicit_Variable_Reference();
	
	if(source_is_implicit && target_is_implicit)
	  {
	    hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name() + "_register");
	    vector<string> reqs;
	    vector<string> acks;
	    reqs.push_back(hier_id + "/req");
	    acks.push_back(hier_id + "/ack");
	    Write_VC_Link(this->_target->Get_VC_Datapath_Instance_Name(),
			  reqs, acks, ofile);
	    reqs.clear();
	    acks.clear();
	  }
    }
}


// AaCallStatement
void AaCallStatement::Write_VC_Control_Path_Optimized(set<AaRoot*>& visited_elements,
						      map<string, vector<AaExpression*> >& ls_map,
						      map<string, vector<AaExpression*> >& pipe_map,
						      ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // first the input arguments... zipping through.
  for(int idx = 0; idx < _input_args.size(); idx++)
    _input_args[idx]->Write_VC_Control_Path_Optimized(visited_elements,ls_map,pipe_map,ofile);

  // trigger the call after the input arguments
  // have been computed..
  string call_trigger = this->Get_VC_Active_Transition_Name();
  __T(call_trigger);

  for(int idx = 0; idx < _input_args.size(); idx++)
    {

      AaExpression* expr = _input_args[idx];
      if(!expr->Is_Constant())
	{
	  __J(call_trigger, expr->Get_VC_Complete_Region_Name());
	}
    }

  string in_progress = this->Get_VC_Name() + "_in_progress";
  __T(in_progress);

  // the call-trigger will start the call..
  ofile << ";;[" << this->Get_VC_Name() << "_start] { " 
	<< "$T [crr] $T [cra] "
	<< "} " << endl;
  __F(call_trigger,this->Get_VC_Name() + "_start");
  __J(in_progress, this->Get_VC_Name() + "_start");

  // the call will eventually complete.
  ofile << ";;[" << this->Get_VC_Name() << "_complete] { " 
	<< "$T [ccr] $T [cca] "
	<< "} " << endl;
  __F(in_progress,this->Get_VC_Name() + "_complete");

  string call_completed = this->Get_VC_Name() + "_call_complete";
  __T(call_completed);
  __J(call_completed, this->Get_VC_Name() + "_complete");

  // completed
  string completed = this->Get_VC_Completed_Transition_Name();
  __T(completed);

  // the output arguments.
  bool non_triv_flag = false;
  for(int idx = 0; idx < _output_args.size(); idx++)
    {
      AaExpression* expr = _output_args[idx];

      expr->Write_VC_Control_Path_As_Target_Optimized(visited_elements,ls_map,pipe_map,ofile);
      if(!expr->Is_Implicit_Variable_Reference())
	{

	  __J(expr->Get_VC_Start_Transition_Name(),call_completed);
	  __J(completed, expr->Get_VC_Complete_Region_Name());
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

  if(!non_triv_flag)
    {
      __J(completed,call_completed);
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

  vector<string> reqs;
  vector<string> acks;

  string start_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name() + "_start");
  reqs.push_back(start_hier_id + "/crr");
  acks.push_back(start_hier_id + "/cra");


  string complete_hier_id = Augment_Hier_Id(hier_id,this->Get_VC_Name() + "_complete");
  reqs.push_back(complete_hier_id + "/ccr");
  acks.push_back(complete_hier_id + "/cca");

  Write_VC_Link(this->Get_VC_Name() + "_call",reqs,acks,ofile);
}

// AaBlockStatement
void AaBlockStatement::Identify_Maximal_Sequences(AaStatementSequence* sseq,
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

	  if(stmt->Is("AaNullStatement"))
	    {
	      end_idx++;
	      continue;
	    }

	  if(this->Is_Pipelined() ||
	     stmt->Is_Block_Statement()  || 
	     stmt->Is_Control_Flow_Statement() || 
	     (stmt->Is("AaCallStatement") && 
		 !((AaModule*)(((AaCallStatement*)stmt)->Get_Called_Module()))->Has_No_Side_Effects())
	     || stmt->Can_Block())
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
  this->AaBlockStatement::Write_VC_Control_Path_Optimized(ss,ofile);
  delete ss;
}


// sseq consists of linear sequence of simple statements..
// no control-flow, no block statements.
void AaBlockStatement::Write_VC_Control_Path_Optimized(AaStatementSequence* sseq,
						       ostream& ofile)
{


  if(sseq->Get_Statement_Count() == 1 && sseq->Get_Statement(0)->Is_Block_Statement())
    sseq->Get_Statement(0)->Write_VC_Control_Path_Optimized(ofile);
  else
    {
      ofile << "::[" << sseq->Get_VC_Name() << "] {" << endl;

      set<AaRoot*> visited_elements;
      map<string, vector<AaExpression*> > load_store_ordering_map;
      map<string, vector<AaExpression*> >  pipe_map;

      for(int idx = 0, fidx = sseq->Get_Statement_Count(); idx < fidx; idx++)
	{
	  sseq->Get_Statement(idx)->Write_VC_Control_Path_Optimized(visited_elements,
								    load_store_ordering_map,
								    pipe_map,
								    ofile);
	}

      this->Write_VC_Load_Store_Dependencies(load_store_ordering_map,ofile);
      this->Write_VC_Pipe_Dependencies(pipe_map,ofile);

      ofile << "}" << endl;
    }



}



// load store dependencies.
void AaBlockStatement::
Write_VC_Load_Store_Dependencies(map<string,vector<AaExpression*> >& load_store_dep_map,
				 ostream& ofile)
{

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
      for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
	{
	  AaExpression* expr = (*iter).second[idx];

	  if(expr->Is_Store())
	    {
	      if(active_loads.size() > 0)
		{
		  // dependency between active loads and
		  // expr start.
		  for(int lsi = 0, flsi = active_loads.size(); lsi < flsi; lsi++)
		    {
		      Write_VC_Load_Store_Dependency(active_loads[lsi],expr,ofile);
		    }

		  // active load dependencies are taken care of
		  active_loads.clear();
		  last_store = expr;
		}
	      else
		{
		  if(last_store != NULL)
		      Write_VC_Load_Store_Dependency(last_store,expr,ofile);

		  last_store = expr;
		}
	    }
	  else if(last_store != NULL && expr->Is_Load())
	    {
	      // dependency between last store and expr.
	      Write_VC_Load_Store_Dependency(last_store,expr,ofile);
	      
	      // keep track of active loads.
	      active_loads.push_back(expr);
	    }
	  else if(last_store == NULL && expr->Is_Load())
	    {
	      active_loads.push_back(expr);
	    }
	}
    }
}

// pipe accesses will be strictly in order!
void AaBlockStatement::
Write_VC_Pipe_Dependencies(map<string,vector<AaExpression*> >& pipe_map,
				 ostream& ofile)
{


  for(map<string,vector<AaExpression*> >::iterator iter = pipe_map.begin(), 
	fiter  = pipe_map.end();
      iter != fiter;
      iter++)
    {
      
      ofile << "// pipe read/write dependencies for pipe " << (*iter).first << endl;
      AaExpression* last_expr = NULL;
      for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
	{
	  AaExpression* expr = (*iter).second[idx];
	  if(last_expr != NULL)
	    Write_VC_Pipe_Dependency(last_expr,expr,ofile);
	  last_expr = expr;
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
	  if(curr_seq->Get_Statement(0)->Is_Block_Statement())
	    curr_seq->Get_Statement(0)->Write_VC_Control_Path_Optimized(ofile);
	  else
	    this->AaBlockStatement::Write_VC_Control_Path_Optimized(curr_seq,
								    ofile);
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
      this->AaBlockStatement::Write_VC_Control_Path_Optimized(stmt, ofile);
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
      this->AaBlockStatement::Write_VC_Links_Optimized(hier_id, stmt, ofile);
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
		    this->AaBlockStatement::Write_VC_Control_Path_Optimized(sseq,ofile);
		  
		  
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
void AaPhiStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
  this->Write_VC_Control_Path(ofile);
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
