#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcSystem.hpp>


void vcPlace::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{
  vcCPElementGroup* my_group = cp->Make_New_Group();
  cp->Add_To_Group(this,my_group);
}

void vcTransition::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{
  vcCPElementGroup* my_group = cp->Make_New_Group();
  cp->Add_To_Group(this,my_group);
}

void vcCPElement::Connect_CPElement_Group_Graph(vcControlPath* cp)
{
  // update connections between my group and predecessor groups
  for(int idx = 0; idx < _predecessors.size() ; idx++)
    {
      vcCPElement* pred = _predecessors[idx]->Get_Exit_Element();
      vcCPElementGroup* pred_group = cp->Get_Group(pred);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Entry_Element());
      if(pred_group != NULL && pred_group != my_group)
	{
	  cp->Connect_Groups(pred_group,my_group, false);
	}
    }
  
  
  // update connections between my group and successor groups
  for(int idx = 0; idx < _successors.size(); idx++)
    {
	// this will be an issue for the pipelined-loop-body
	// whose entry is not the successor of those pointing to
	// it. Sorted out by making the bound transition in
	// the loop-body as the successor.
      vcCPElement* succ = _successors[idx]->Get_Entry_Element();

      vcCPElementGroup* succ_group = cp->Get_Group(succ);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Exit_Element());
      if(succ_group != NULL && succ_group != my_group)
	{
	  cp->Connect_Groups(my_group,succ_group, false);
	}
    }

  // update marked connections between my group and predecessor groups
  for(int idx = 0; idx < _marked_predecessors.size() ; idx++)
    {
      vcCPElement* pred = _marked_predecessors[idx]->Get_Exit_Element();
      vcCPElementGroup* pred_group = cp->Get_Group(pred);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Entry_Element());
      if(pred_group != NULL && pred_group != my_group)
	{
	  cp->Connect_Groups(pred_group,my_group,true);
	}
    }
  
  
  // update marked connections between my group and successor groups
  for(int idx = 0; idx < _marked_successors.size(); idx++)
    {
	// this will be an issue for the pipelined-loop-body
	// whose entry is not the successor of those pointing to
	// it. Sorted out by making the bound transition in
	// the loop-body as the successor.
      vcCPElement* succ = _marked_successors[idx]->Get_Entry_Element();

      vcCPElementGroup* succ_group = cp->Get_Group(succ);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Exit_Element());
      if(succ_group != NULL && succ_group != my_group)
	{
	  cp->Connect_Groups(my_group,succ_group,true);
	}
    }
}

void vcCPBlock::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{

  this->_entry->Construct_CPElement_Group_Graph_Vertices(cp);
  for(int idx = 0; idx < _elements.size(); idx++)
    {
      this->_elements[idx]->Construct_CPElement_Group_Graph_Vertices(cp);
    }
  this->_exit->Construct_CPElement_Group_Graph_Vertices(cp);
}


void vcCPBlock::Connect_CPElement_Group_Graph(vcControlPath* cp)
{
  this->_entry->Connect_CPElement_Group_Graph(cp);
  for(int idx = 0; idx < _elements.size(); idx++)
    {
      this->_elements[idx]->Connect_CPElement_Group_Graph(cp);
    }
  this->_exit->Connect_CPElement_Group_Graph(cp);

  // connect this block to it's predecessors
  // and successors.
  this->vcCPElement::Connect_CPElement_Group_Graph(cp);
}


// Can this absorb g (g is a successor of this)?
bool vcCPElementGroup::Can_Absorb(vcCPElementGroup* g)
{
  bool ret_val = true;
  
  

  if(this->_is_bound_as_input_to_cp_function)
    ret_val = false;
  else if(this->_is_bound_as_output_from_region)
    ret_val = false;
  else if(this->_is_bound_as_output_from_region)
    ret_val = false;
  else if(g->_has_input_transition)
    ret_val = false;
  else if(g->_marked_predecessors.size() > 0)
    ret_val = false;
  else if(this->_pipeline_parent != g->_pipeline_parent)
    ret_val = false;
  else
    {
      // g must have one predecessor and this must have one successor
      // and they must be adjacent
      if(g->_predecessors.size() == 1 && this->_successors.size() == 1
	 && ((*(g->_predecessors.begin())) == this))
	{
	  // dont mess with dead transitions..
	  // there are not too many of them.
	  if(this->_has_dead_transition || g->_has_dead_transition)
	    ret_val = false;
	  // if this is a join, g cannot be a
	  // place
	  else if(this->_is_join)
	    ret_val = !(g->_has_place);
	  // if this is a merge, g cannot
	  // be a transition.
	  else if (this->_is_merge)
	    ret_val = !(g->_has_transition);
	  else if(g->_is_branch)
	    ret_val = !(this->_has_transition);
	  else if(g->_is_fork)
	    ret_val = !(this->_has_place);
	  else
	    // otherwise there is no issue..
	    ret_val = true;
	}
      else
	ret_val = false;
    }

  return(ret_val);
}


void vcCPElementGroup::Add_Element(vcCPElement* cpe)
{

  bool is_pipelined = ((cpe->Get_Parent() != NULL)  && cpe->Get_Parent()->Is("vcCPPipelinedLoopBody"));
	
  if(cpe->Is_Transition())
    {
      this->_has_transition = true;

      if(((vcTransition*)cpe)->Get_Is_Input())
	_input_transition = (vcTransition*)cpe;

      if(((vcTransition*)cpe)->Get_Is_Output())
	_output_transitions.push_back((vcTransition*)cpe);


      this->_has_input_transition  |= ((vcTransition*)cpe)->Get_Is_Input();
      this->_has_output_transition |= ((vcTransition*)cpe)->Get_Is_Output();
      this->_has_dead_transition   |= ((vcTransition*)cpe)->Get_Is_Dead();

     
      if((cpe->Get_Number_Of_Predecessors() > 1) || is_pipelined )
	this->_is_join = true;
      if((cpe->Get_Number_Of_Successors() > 1) || (cpe->Get_Number_Of_Marked_Successors() > 0))
	this->_is_fork = true;

      vcTransition* tr = (vcTransition*) cpe;

      if(tr->Get_Is_Bound_As_Input_To_CP_Function())
	this->Set_Is_Bound_As_Input_To_CP_Function(true);
      if(tr->Get_Is_Bound_As_Output_From_CP_Function())
	this->Set_Is_Bound_As_Output_From_CP_Function(true);
      if(tr->Get_Is_Bound_As_Input_To_Region())
	this->Set_Is_Bound_As_Input_To_Region(true);
      if(tr->Get_Is_Bound_As_Output_From_Region())
	this->Set_Is_Bound_As_Output_From_Region(true);

    }
  else if(cpe->Is_Place())
    {
      this->_has_place = true;

      if(cpe->Get_Number_Of_Predecessors() > 1)
	this->_is_merge = true;
      if(cpe->Get_Number_Of_Successors() > 1)
	this->_is_branch = true;
    }

  _elements.insert(cpe);

  if(is_pipelined)
  {
	vcCPPipelinedLoopBody* lb = ((vcCPPipelinedLoopBody*) cpe->Get_Parent());
	if(_pipeline_parent == NULL)
		_pipeline_parent = lb;
	else if(_pipeline_parent != lb)
		vcSystem::Error("Group has conflicting pipeline parent");
  }
}


void vcCPElementGroup::Print(ostream& ofile)
{
  ofile << "CP-element group " << _group_index;
  if(_is_merge)
    ofile << " merge ";
  if(_is_branch)
    ofile << " branch ";
  if(_is_join) 
    ofile << " join ";
  if(_is_fork)
    ofile << " fork ";
  if(_has_transition)
    ofile << " transition ";
  if(_has_place)
    ofile << " place ";
  if(_has_input_transition)
    ofile << " input ";
  if(_has_output_transition)
    ofile << " output ";
  if(_has_dead_transition)
    ofile << " dead ";
  ofile << endl;
  ofile << "predecessors ";
  for(set<vcCPElementGroup*>::iterator iter = _predecessors.begin(), fiter = _predecessors.end();
      iter != fiter;
      iter++)
    {

      ofile << (*iter)->Get_Group_Index() << " ";
    }
  ofile << endl;

  if(_marked_predecessors.size() > 0)
  {
     ofile << "marked predecessors ";
     for(set<vcCPElementGroup*>::iterator iter = _marked_predecessors.begin(), fiter = _marked_predecessors.end();
         iter != fiter;
         iter++)
       {
   
         ofile << (*iter)->Get_Group_Index() << " ";
       }
     ofile << endl;
  }

  ofile << "successors ";
  for(set<vcCPElementGroup*>::iterator iter = _successors.begin(), fiter = _successors.end();
      iter != fiter;
      iter++)
    {
      if((*iter)->Get_Group_Index() < 0)
	{
	  cerr << endl;
	  cerr << "Error: group " << this->Get_Root_Index() << " has dangling successor " <<
	    (*iter)->Get_Root_Index() << endl;
	}
      ofile << (*iter)->Get_Group_Index() << " ";
    }
  ofile << endl;

  if(_marked_successors.size() > 0)
  {
    ofile << "marked successors ";
    for(set<vcCPElementGroup*>::iterator iter = _marked_successors.begin(), fiter = _marked_successors.end();
        iter != fiter;
        iter++)
      {
        if((*iter)->Get_Group_Index() < 0)
	  {
	    cerr << endl;
	    cerr << "Error: group " << this->Get_Root_Index() << " has dangling marked successor " <<
	      (*iter)->Get_Root_Index() << endl;
	  }
        ofile << (*iter)->Get_Group_Index() << " ";
      }
    ofile << endl;
  }


  ofile << " members (" << _elements.size() << ") {" << endl;
  for(set<vcCPElement*>::iterator iter = _elements.begin(), fiter = _elements.end();
      iter != fiter;
      iter++)
    {
      ofile << "\t" << (*iter)->Get_Hierarchical_Id() << endl;
    }
  ofile << "}" << endl;
}

// TODO: take care of marked predecessors!
void vcCPElementGroup::Print_VHDL(ostream& ofile)
{

  // if it has a dead transition, tie it to false.
  if(this->_has_dead_transition)
    {
      ofile << this->Get_VHDL_Id() << " <= false;" << endl;
      return;
    }


  // if it is bound to an output of a cp function, dont print anything.
  if(this->_is_bound_as_output_from_cp_function)
	return;

  bool is_pipelined = (this->_pipeline_parent != NULL);
  int max_iterations_in_flight = 1;
  if(is_pipelined)
	max_iterations_in_flight = this->_pipeline_parent->Get_Max_Iterations_In_Flight();

  if(!(this->_is_join || this->_is_fork))
    {
      if(this->_has_input_transition)
	{
	  this->Print_DP_To_CP_VHDL_Link(ofile);
	}
      else
	{
	  if(_predecessors.size() > 1)
	    {
	      ofile << this->Get_VHDL_Id() << " <= OrReduce(";	      // write the symbol as an OR of all incoming symbols.

	      bool first_one = true;
	      for(set<vcCPElementGroup*>::iterator iter = this->_predecessors.begin(),
		    fiter = _predecessors.end();
		  iter != fiter;
		  iter++)
		{
		  if(!first_one)
		    {
		      ofile << " & ";
		    }
		  else
		    first_one = false;
		  
		  ofile << (*iter)->Get_VHDL_Id(); 
		}
	      ofile << ");" << endl;
	    }
	  else if(_predecessors.size() == 1)
	    {
	      ofile << this->Get_VHDL_Id() << " <= ";	      
	      ofile << (*(_predecessors.begin()))->Get_VHDL_Id() << ";" << endl;
	    }
	  else if(_predecessors.size() == 0)
	    {
	      if(!this->_is_cp_entry)
		{
		  vcSystem::Warning("CP element " + Int64ToStr(this->Get_Group_Index()) + " has no predecessors.. tie to false");
		  ofile << this->Get_VHDL_Id() << " <= false; " << endl;	      		  
		}
	    }
	}
    }
  else
    {
      // here, if there is a marked predecessor, force a join.
      // all elements in the group are either part of a pipeline or not.
      // if they are part of a pipelined loop body, then all joins must have internal
      // places with a certain capacity... either forced from a global parameter
      // or etc. etc.
      // instantiate join element.
      if((_predecessors.size() > 1) || is_pipelined)
	{
	  bool marked_flag = (_marked_predecessors.size() > 0);
	  ofile << "cpelement_group_" << this->Get_Group_Index() << " : Block -- { " << endl;
	  ofile << "signal predecessors: BooleanArray(" 
		<< _predecessors.size()-1 << " downto 0);" << endl;
          if(marked_flag)
	     ofile << "signal marked_predecessors: BooleanArray(" << _marked_predecessors.size()-1 
			<< " downto 0);" << endl;
	  ofile << "-- }" << endl << "begin -- {" << endl;
	  
	  ofile << "predecessors <= (" ;
	  bool first_one = true;
	  for(set<vcCPElementGroup*>::iterator iter = this->_predecessors.begin(),
		fiter = _predecessors.end();
	      iter != fiter;
	      iter++)
	    {
	      if(!first_one)
		{
		  ofile << " & ";
		}
	      else
		first_one = false;
	      
	      ofile << (*iter)->Get_VHDL_Id();
	      
	    }
	  ofile << ");" << endl;

	  if(marked_flag)
	  {
	  	ofile << "marked_predecessors <= (" ;
	  	bool first_one = true;
	  	for(set<vcCPElementGroup*>::iterator iter = this->_predecessors.begin(),
			fiter = _predecessors.end();
	      		iter != fiter;
	      		iter++)
	    	{
	      		if(!first_one)
			{
		  		ofile << " & ";
			}
	      		else
				first_one = false;
	      
	      		ofile << (*iter)->Get_VHDL_Id();
	      
	    	}
	  	ofile << ");" << endl;

          }
	  if(this->_input_transition != NULL)
	    {
	      if(marked_flag)
	      	ofile << "jI: join_with_input -- {" << endl;
	      else
	      	ofile << "jI: marked_join_with_input -- {" << endl;

	      ofile << "generic map (place_capacity => " << max_iterations_in_flight << ")" << endl;
	      ofile << "port map( -- {"
		    << "preds => predecessors," << endl;
	      if(marked_flag)
		 ofile << "marked_preds => marked_predecessors," << endl;
		
	      ofile << "symbol_in => " << this->_input_transition->Get_DP_To_CP_Symbol() << "," << endl
		    << "symbol_out => " << this->Get_VHDL_Id() << "," << endl
		    << "clk => clk," << endl
		    << "reset => reset); -- }}" << endl;
	    }
	  else
	    {
	      if(marked_flag)
	      	ofile << "jNoI: join -- {" << endl;
	      else
	      	ofile << "jNoI: marked_join -- {" << endl;
	      ofile << "generic map ( place_capacity => " << max_iterations_in_flight << ")" << endl
		    << "port map( -- {"
		    << "preds => predecessors," << endl;
	      if(marked_flag)
		ofile << "marked_preds => marked_predecessors," << endl;

	      ofile << "symbol_out => " << this->Get_VHDL_Id() << "," << endl
		    << "clk => clk," << endl
		    << "reset => reset); -- }}" << endl;
	    }
		  
	  ofile << "-- }" << endl << "end Block;" << endl;
	}
      else if(_predecessors.size() == 1)
	{
	  if(this->_has_input_transition)
	    {
	      ofile << this->Get_VHDL_Id() << " <= ";
	      ofile <<  _input_transition->Get_DP_To_CP_Symbol() << ";" << endl;
	    }
	  else
	    {
	      ofile << this->Get_VHDL_Id() << " <= ";	      
	      ofile << (*(_predecessors.begin()))->Get_VHDL_Id() << ";" << endl;
	    }
	}
    }

	  
	  
  for(int idx = 0, fidx = _output_transitions.size(); idx < fidx; idx++)
    {
      this->Print_CP_To_DP_VHDL_Link(idx, ofile);
    }
}

void vcCPElementGroup::Print_DP_To_CP_VHDL_Link(ostream& ofile)
{
  string ack_str =  this->Get_VHDL_Id(); 
  string req_str = this->_input_transition->Get_DP_To_CP_Symbol();

  string delay_str = "0";
  ofile << this->_input_transition->Get_Exit_Symbol() << "_link_from_dp: control_delay_element -- { "  << endl
	<< "generic map (delay_value => " << delay_str << ")" << endl
	<< "port map(clk => clk, reset => reset, req => " << req_str
	<< ", ack => " << ack_str << "); -- } " << endl;
}

void vcCPElementGroup::Print_CP_To_DP_VHDL_Link(int idx, ostream& ofile)
{
  string req_str =  this->Get_VHDL_Id(); 
  string ack_str = this->_output_transitions[idx]->Get_CP_To_DP_Symbol();

  string delay_str = "0";
  //   if(this->_output_transitions[idx]->Get_Is_Linked_To_Non_Local_Dpe() && vcSystem::_min_clock_period_flag)
  //     {
  //       delay_str = "1";
  //     }
  //   else
  //     {
  //       delay_str = "0";
  //     }

  ofile << this->_output_transitions[idx]->Get_Exit_Symbol() << "_link_to_dp: control_delay_element -- { "  << endl
	<< "generic map (delay_value => " << delay_str << ")" << endl
	<< "port map(clk => clk, reset => reset, req => " << req_str
	<< ", ack => " << ack_str << "); -- } " << endl;
}

void vcControlPath::Construct_Reduced_Group_Graph()
{
  this->vcCPBlock::Construct_CPElement_Group_Graph_Vertices(this);
  this->vcCPBlock::Connect_CPElement_Group_Graph(this);
  this->Reduce_CPElement_Group_Graph();
}

void vcControlPath::Reduce_CPElement_Group_Graph()
{
  cerr << "Info: reducing Control-path " << endl;
  map<vcCPElementGroup*,vcCPElementGroup*> reduce_map;
  for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
	fiter = _cpelement_groups.end();
      iter != fiter;
      iter++)
    {
      vcCPElementGroup* g = (*iter);
      if(g->_predecessors.size() == 1)
	{
	  for(set<vcCPElementGroup*>::iterator niter = g->_predecessors.begin(),
		fniter = g->_predecessors.end();
	      niter != fniter;
	      niter++)
	    {
	      vcCPElementGroup* pg = (*niter);
	      if(pg->_successors.size() == 1)
		{
		  if(pg->Can_Absorb(g))
		    {
		      if(reduce_map.find(pg) == reduce_map.end())
			reduce_map[g] = pg;
		      else
			reduce_map[g] = reduce_map[pg];
		    }
		}
	    }
	}
    }

  // transitive closure..
  for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
	fiter = _cpelement_groups.end();
      iter != fiter;
      iter++)
    {
      vcCPElementGroup* g = *iter;
      if(reduce_map.find(g) != reduce_map.end())
	{
	  vcCPElementGroup* pg = reduce_map[g];
	  while(reduce_map.find(pg) != reduce_map.end())
	    pg = reduce_map[pg];
		  
	  reduce_map[g] = pg;
	}
    }  

  // now merge..
  for(map<vcCPElementGroup*,vcCPElementGroup*>::iterator miter = reduce_map.begin(),
	fmiter = reduce_map.end();
      miter != fmiter;
      miter++)
    {
      this->Merge_Groups((*miter).first, (*miter).second);
    }

	  
  // index the groups.
  int idx = 0;
  for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
	fiter = _cpelement_groups.end();
      iter != fiter;
      iter++)
    {
      (*iter)->Set_Group_Index(idx);
      idx++;
    }
}


void vcControlPath::Merge_Groups(vcCPElementGroup* part, vcCPElementGroup* whole)
{

	  
  assert(part->_predecessors.size() == 1);

  // get part out of the succ. list. of whole
  whole->_successors.erase(part);

  // the same as above, but from marked successors of whole.
  whole->_marked_successors.erase(part);

  // move part' successors to whole..
  for(set<vcCPElementGroup*>::iterator iter = part->_successors.begin(),
	fiter = part->_successors.end();
      iter != fiter;
      iter++)
    {
      // remove part as a predecessor of iter..
      (*iter)->_predecessors.erase(part);

      // connect whole to iter..
      if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
	this->Connect_Groups(whole,(*iter), false);

    }

  // move marked successors of part to whole.
  for(set<vcCPElementGroup*>::iterator iter = part->_marked_successors.begin(),
	fiter = part->_marked_successors.end();
      iter != fiter;
      iter++)
    {
      // remove part as a marked predecessor of iter..
      (*iter)->_marked_predecessors.erase(part);

      // connect whole to iter..
      if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
	this->Connect_Groups(whole,(*iter), true);

    }

  // move marked predecessors of part to whole.
  for(set<vcCPElementGroup*>::iterator iter = part->_marked_predecessors.begin(),
	fiter = part->_marked_predecessors.end();
      iter != fiter;
      iter++)
    {
      // remove part as a marked successor of iter..
      (*iter)->_marked_successors.erase(part);

      // connect iter to whole..
      if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
	this->Connect_Groups((*iter), whole, true);
    }


  // move part' elements to whole..
  for(set<vcCPElement*>::iterator el_iter = part->_elements.begin();
      el_iter != part->_elements.end();
      el_iter++)
    {
      this->_cpelement_to_group_map.erase(*el_iter);
      this->Add_To_Group(*el_iter,whole);
    }

  // remove part from the groups..
  this->_cpelement_groups.erase(part);

}

vcCPElementGroup* vcControlPath::Make_New_Group()
{
  vcCPElementGroup* ng = new vcCPElementGroup();
  this->_cpelement_groups.insert(ng);
  return(ng);
}

vcCPElementGroup* vcControlPath::Get_Group(vcCPElement* cpe)
{
  vcCPElementGroup* rg = NULL;
  if(_cpelement_to_group_map.find(cpe) != _cpelement_to_group_map.end())
    {
      rg = _cpelement_to_group_map[cpe];
    }
  return(rg);
}


void vcControlPath::Add_To_Group(vcCPElement* cpe, vcCPElementGroup* group)
{
  group->Add_Element(cpe);
  // cannot be a member of two groups!
  assert(_cpelement_to_group_map.find(cpe) == _cpelement_to_group_map.end());
  _cpelement_to_group_map[cpe] = group;
}

void vcControlPath::Connect_Groups(vcCPElementGroup* from, vcCPElementGroup* to, bool marked_flag)
{
  if(!marked_flag)
  {
  	from->Add_Successor(to);
  	to->Add_Predecessor(from);
  }
  else
  {
  	from->Add_Marked_Successor(to);
  	to->Add_Marked_Predecessor(from);
  }
}

void vcControlPath::Print_Groups(ostream& ofile)
{
  for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
	fiter = _cpelement_groups.end();
      iter != fiter;
      iter++)
    {
      (*iter)->Print(ofile);
    }
}


void vcControlPath::Print_VHDL_Optimized(ostream& ofile)
{
	  
  string id = "control-path";

  ofile << this->Get_VHDL_Id() << ": Block -- " << id << " {" << endl;
  ofile << "signal cp_elements: BooleanArray("	
	<< _cpelement_groups.size()-1 
	<< " downto 0);" << endl;
  ofile << "-- }" << endl << "begin -- {" << endl;

  vcCPElementGroup* entry_grp = _cpelement_to_group_map[this->_entry];
  assert(entry_grp);
  entry_grp->_is_cp_entry = true;

  ofile << entry_grp->Get_VHDL_Id() 
	<< " <= start_req_symbol;" << endl;

  vcCPElementGroup* exit_grp = _cpelement_to_group_map[this->_exit];
  assert(exit_grp);

  ofile << "start_ack_symbol <= " << exit_grp->Get_VHDL_Id() << ";" << endl;

  ofile << "finAckJoin: join2 " << endl
	<< " port map(pred0 => fin_req_symbol, pred1 =>" << exit_grp->Get_VHDL_Id()
	<< ", symbol_out => fin_ack_symbol, clk => clk, reset => reset);"
	<< endl;

  for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
	fiter = _cpelement_groups.end();
      iter != fiter;
      iter++)
    {
      (*iter)->Print_VHDL(ofile);
    }


  for(set<vcCPSimpleLoopBlock*>::iterator slb_iter = _simple_loop_blocks.begin(), fslb_iter = _simple_loop_blocks.end();
	slb_iter != fslb_iter;
	slb_iter++)
  {
	vcCPSimpleLoopBlock* slb = *slb_iter;

	slb->Print_VHDL_Terminator(this, ofile);

        vcCPPipelinedLoopBody* plb = slb->Get_Loop_Body();
	plb->Print_VHDL_Phi_Sequencers(this,ofile);
	plb->Print_VHDL_Transition_Merges(this,ofile);

		
  }

  ofile << "-- }" << endl << "end Block; -- " << id << endl;
}

void vcCPSimpleLoopBlock::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{
	this->vcCPBlock::Construct_CPElement_Group_Graph_Vertices(cp);
	cp->Add_Simple_Loop_Block(this);
}

void vcCPSimpleLoopBlock::Print_VHDL_Terminator(vcControlPath* cp, ostream& ofile)
{
	ofile <<  "lterm: loop_terminator -- {" << endl;
	ofile <<  "generic map (max_iterations_in_flight => 4) " << endl;
	ofile <<  "port map(loop_body_exit => " << _loop_body->Get_Exit_Symbol(cp) << ","
		<< "loop_continue => " << _loop_taken->Get_Exit_Symbol(cp) << ","
		<< "loop_terminate => " << _loop_exit->Get_Exit_Symbol(cp) << ","
		<< "loop_back => " << _loop_back->Get_Exit_Symbol(cp) << ","
		<< "loop_exit => " << _exit_from_loop->Get_Exit_Symbol(cp) << ","
		<< "clk => clk, reset => reset);" << " -- } " << endl;
}
  
void vcCPPipelinedLoopBody::Print_VHDL_Phi_Sequencers(vcControlPath* cp, ostream& ofile)
{
	for(int idx = 0, fidx = _phi_sequencers.size(); idx < fidx; idx++)
		_phi_sequencers[idx]->Print_VHDL(cp,ofile);
}

void vcCPPipelinedLoopBody::Print_VHDL_Transition_Merges(vcControlPath* cp, ostream& ofile)
{
	for(int idx = 0, fidx = _transition_merges.size(); idx < fidx; idx++)
		_transition_merges[idx]->Print_VHDL(cp,ofile);
}


