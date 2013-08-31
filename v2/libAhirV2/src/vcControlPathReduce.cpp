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

  vector<vcCPElement*> explicit_preds;
  this->Get_Explicit_Predecessors(explicit_preds);

  // update connections between my group and predecessor groups
  for(int idx = 0; idx < explicit_preds.size() ; idx++)
    {
      vcCPElement* pred = explicit_preds[idx]->Get_Exit_Element();
      vcCPElementGroup* pred_group = cp->Get_Group(pred);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Entry_Element());
      if(pred_group != NULL && pred_group != my_group)
	{
	  cp->Connect_Groups(pred_group,my_group, 0);
	}
    }
  
  vector<vcCPElement*> explicit_succs;
  this->Get_Explicit_Successors(explicit_succs);
  
  // update connections between my group and successor groups
  for(int idx = 0; idx < explicit_succs.size(); idx++)
    {
	// this will be an issue for the pipelined-loop-body
	// whose entry is not the successor of those pointing to
	// it. Sorted out by making the bound transition in
	// the loop-body as the successor.
      vcCPElement* succ = explicit_succs[idx]->Get_Entry_Element();

      vcCPElementGroup* succ_group = cp->Get_Group(succ);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Exit_Element());

      if(succ_group != NULL && succ_group != my_group)
	{
	  cp->Connect_Groups(my_group,succ_group, 0);
	}
    }

  // update marked connections between my group and predecessor groups
  for(int idx = 0; idx < _marked_predecessors.size() ; idx++)
    {
      vcCPElement* pred = _marked_predecessors[idx]->Get_Exit_Element();
      int marking = this->Get_Marked_Predecessor_Marking(_marked_predecessors[idx]);

      vcCPElementGroup* pred_group = cp->Get_Group(pred);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Entry_Element());

      if(pred_group != NULL && pred_group != my_group)
	{
	  cp->Connect_Groups(pred_group,my_group,marking);
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
      int marking = this->Get_Marked_Successor_Marking(_marked_successors[idx]);

      vcCPElementGroup* succ_group = cp->Get_Group(succ);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Exit_Element());
      if(succ_group != NULL && succ_group != my_group)
	{
	  cp->Connect_Groups(my_group,succ_group,marking);
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

int  vcCPElementGroup::Get_Marked_Successor_Marking(vcCPElementGroup* g)
{
	if(_marked_successor_markings.find(g) != _marked_successor_markings.end())
		return(_marked_successor_markings[g]);
	else
		return(-1);
}
int  vcCPElementGroup::Get_Marked_Predecessor_Marking(vcCPElementGroup* g)
{
	if(_marked_predecessor_markings.find(g) != _marked_predecessor_markings.end())
		return(_marked_predecessor_markings[g]);
	else
		return(-1);
}

// Can this absorb g (g is a successor of this)?
bool vcCPElementGroup::Can_Absorb(vcCPElementGroup* g)
{
  bool ret_val = true;
  

  if((this->_associated_cp_function != NULL) && (g->_associated_cp_function != NULL) && 
		(this->_associated_cp_function != g->_associated_cp_function))
  // if this->g, and this, g are associated with different functions,
  // then g cannot be pulled into this.
	ret_val = false;
  else if(this->_is_bound_as_input_to_cp_function)
    ret_val = false;
  //else if(this->_is_bound_as_output_from_region)
    //ret_val = false;
  else if(g->_is_bound_as_output_from_cp_function)
    ret_val = false;
  else if(g->_has_input_transition)
    ret_val = false;
  else if(this->_has_output_transition && (g->_marked_predecessors.size() > 0))
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
	  if(this->_has_tied_high_transition || g->_has_tied_high_transition)
	    ret_val = false;
	  if(this->_has_left_open_transition || g->_has_left_open_transition)
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
	
  if(cpe->Get_Is_Bound_As_Input_To_CP_Function())
   this->Set_Is_Bound_As_Input_To_CP_Function(true);
  if(cpe->Get_Is_Bound_As_Output_From_CP_Function())
   this->Set_Is_Bound_As_Output_From_CP_Function(true);
  if(cpe->Get_Is_Bound_As_Input_To_Region())
   this->Set_Is_Bound_As_Input_To_Region(true);
  if(cpe->Get_Is_Bound_As_Output_From_Region())
   this->Set_Is_Bound_As_Output_From_Region(true);

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
      this->_has_tied_high_transition   |= ((vcTransition*)cpe)->Get_Is_Tied_High();
      this->_has_left_open_transition   |= ((vcTransition*)cpe)->Get_Is_Left_Open();

     
      if((cpe->Get_Number_Of_Predecessors() > 1) || (cpe->Get_Number_Of_Marked_Predecessors() > 0)) 
	this->_is_join = true;
      if((cpe->Get_Number_Of_Successors() > 1) || (cpe->Get_Number_Of_Marked_Successors() > 0))
	this->_is_fork = true;

      vcTransition* tr = (vcTransition*) cpe;


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
		vcSystem::Error("Group has conflicting pipeline parent.");
  }

  vcCPElement* assoc_ele = cpe->Get_Associated_CP_Function();
  if(this->_associated_cp_function == NULL)
	this->_associated_cp_function = assoc_ele;
  else
  {
	if(assoc_ele != NULL && (assoc_ele != this->_associated_cp_function))
		vcSystem::Error("Group has conflicting associated cp function.");
  }
}


void vcCPElementGroup::Print(ostream& ofile)
{
  ofile << "-- CP-element group " << _group_index;
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
  if(_has_tied_high_transition)
    ofile << " tied-high ";
  if(_has_left_open_transition)
    ofile << " left-open ";
  if(_bypass_flag)
    ofile << " bypass ";
  else
    ofile << " no-bypass ";
  ofile << endl;
  ofile << "-- predecessors ";
  for(set<vcCPElementGroup*>::iterator iter = _predecessors.begin(), fiter = _predecessors.end();
      iter != fiter;
      iter++)
    {

      ofile << (*iter)->Get_Group_Index() << " ";
    }
  ofile << endl;

  if(_marked_predecessors.size() > 0)
  {
     ofile << "-- marked predecessors ";
     for(set<vcCPElementGroup*>::iterator iter = _marked_predecessors.begin(), fiter = _marked_predecessors.end();
         iter != fiter;
         iter++)
       {
   
         ofile << (*iter)->Get_Group_Index() << " ";
       }
     ofile << endl;
  }

  ofile << "-- successors ";
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
    ofile << "-- marked successors ";
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


  ofile << "-- members (" << _elements.size() << ") {" << endl;
  for(set<vcCPElement*>::iterator iter = _elements.begin(), fiter = _elements.end();
      iter != fiter;
      iter++)
    {
      ofile << "-- \t" << (*iter)->Get_Hierarchical_Id() << endl;
    }
  ofile << "-- }" << endl;
}

// take care of marked predecessors!
void vcCPElementGroup::Print_VHDL(ostream& ofile)
{

  string bypass_string = (this->_bypass_flag ?  "true" : "false");

  // print out the group into the VHDL file.
  this->Print(ofile);

  // if it has a dead transition, tie it to false.
  if(this->_has_dead_transition)
    {
      ofile << this->Get_VHDL_Id() << " <= false;" << endl;
      return;
    }
  else if(this->_has_tied_high_transition)
    {
      ofile << this->Get_VHDL_Id() << " <= true;" << endl;
      return;
    }
  else if(this->_has_left_open_transition)
    {
      ofile << "-- left open: " << this->Get_VHDL_Id() << endl;
      return;
    }
  


  // if it is bound to an output of a cp function, dont print anything.
  if(this->_is_bound_as_output_from_cp_function)
  {
      ofile << "-- Element group " << this->Get_VHDL_Id() << " is bound as output of CP function." << endl;
      return;
  }

  bool is_pipelined = (this->_pipeline_parent != NULL);

  int max_iterations_in_flight = 1;
  if(is_pipelined)
  {
     max_iterations_in_flight = this->_pipeline_parent->Get_Max_Iterations_In_Flight();
  }

  if(!this->_is_join && (this->_marked_predecessors.size() == 0))
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
                  this->Print(cerr);
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
      bool is_true_join = (is_pipelined ? 
			((_predecessors.size() > 1) || 
				((_predecessors.size() > 0) && (_marked_predecessors.size() > 0))) :
			(_predecessors.size() > 1));
      if(is_true_join)
	{
	  bool marked_flag = (_marked_predecessors.size() > 0);
	  ofile << "cpelement_group_" << this->Get_Group_Index() << " : Block -- { " << endl;
	  ofile << "signal predecessors: BooleanArray(" 
		<< _predecessors.size()-1 << " downto 0);" << endl;
          if(marked_flag)
	     ofile << "signal marked_predecessors: BooleanArray(" << _marked_predecessors.size()-1 
			<< " downto 0);" << endl;
	  ofile << "-- }" << endl << "begin -- {" << endl;
	  
          int idx = 0;
	  for(set<vcCPElementGroup*>::iterator iter = _predecessors.begin(),
		fiter = _predecessors.end();
	      iter != fiter;
	      iter++)
	    {
	      ofile << "predecessors(" << idx << ") <= " ; 
	      ofile << (*iter)->Get_VHDL_Id() << ";" << endl;
	      idx++;
	    }

	  if(marked_flag)
	  {
		idx = 0;
	  	for(set<vcCPElementGroup*>::iterator iter = this->_marked_predecessors.begin(),
			fiter = _marked_predecessors.end();
	      		iter != fiter;
	      		iter++)
	    	{
	      		ofile << "marked_predecessors(" << idx << ") <= " ; idx++;
	      		ofile << (*iter)->Get_VHDL_Id() << ";" << endl;
	    	}

          }
	  if(this->_input_transition != NULL)
	    {
	      if(!marked_flag)
	      	ofile << "jI: join_with_input -- {" << endl;
	      else
	      	ofile << "jI: marked_join_with_input -- {" << endl;

	      ofile << "generic map(place_capacity => " << max_iterations_in_flight << "," << endl
		<< "bypass => " << bypass_string << "," << endl
		<< "name => \" " << this->Get_VHDL_Id() << "_join\")" << endl;
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
	      if(!marked_flag)
	      	ofile << "jNoI: join -- {" << endl;
	      else
	      	ofile << "jNoI: marked_join -- {" << endl;
	      ofile << "generic map(place_capacity => " << max_iterations_in_flight << "," << endl
			<< "bypass => " << bypass_string << "," << endl
		    << "name => \" " << this->Get_VHDL_Id() << "_join\")" << endl
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
      else if(this->_has_input_transition)
	// some will be dangling.
	{
	      ofile << this->Get_VHDL_Id() << " <= ";
	      ofile <<  _input_transition->Get_DP_To_CP_Symbol() << ";" << endl;
	}
      else
	{
		vcSystem::Warning("CP-element group " + this->Get_VHDL_Id() + " has no true predecessors.\n");
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

  //finally, update the bypass entries.
  this->Update_Group_Bypass_Flags();
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
	this->Connect_Groups(whole,(*iter), 0);

    }

  // move marked successors of part to whole.
  for(set<vcCPElementGroup*>::iterator iter = part->_marked_successors.begin(),
	fiter = part->_marked_successors.end();
      iter != fiter;
      iter++)
    {
      // remove part as a marked predecessor of iter..
      (*iter)->_marked_predecessors.erase(part);
      (*iter)->_marked_predecessor_markings.erase(part);

      // connect whole to iter..
      if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
      {
        int marking = part->Get_Marked_Successor_Marking(*iter);
	if(whole != (*iter)) // avoid self loops since they are redundant.
		this->Connect_Groups(whole,(*iter), marking);
      }
    }

  // move marked predecessors of part to whole.
  for(set<vcCPElementGroup*>::iterator iter = part->_marked_predecessors.begin(),
	fiter = part->_marked_predecessors.end();
      iter != fiter;
      iter++)
    {
      // remove part as a marked successor of iter..
      (*iter)->_marked_successors.erase(part);
      (*iter)->_marked_successor_markings.erase(part);

      // connect iter to whole..
      if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
      {
        int marking = part->Get_Marked_Predecessor_Marking(*iter);
	if(whole != (*iter)) // avoid self loops since they are redundant.
		this->Connect_Groups((*iter), whole, marking);
      }
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
  assert(cpe != NULL);

  vcCPElement* eu = NULL; 

  if(cpe->Is_Place() || cpe->Is_Transition())
	  eu = cpe;
  else if(cpe->Is_Block())
	  eu = cpe->Get_Exit_Element();

  if(_cpelement_to_group_map.find(eu) != _cpelement_to_group_map.end())
    {
      rg = _cpelement_to_group_map[eu];
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

void vcControlPath::Connect_Groups(vcCPElementGroup* from, vcCPElementGroup* to, int marking)
{
  if(marking == 0)
  {
  	from->Add_Successor(to);
  	to->Add_Predecessor(from);
  }
  else if(marking > 0)
  {
  	from->Add_Marked_Successor(to);
	from->Set_Marked_Successor_Marking(to,marking);

  	to->Add_Marked_Predecessor(from);
	to->Set_Marked_Predecessor_Marking(from,marking);
  }
  else
	assert(0);
}


//
// Do a DFS starting from the entry group.
// The bypass counter is incremented on every
// forward step.  Whenever a node is reached,
// if the bypass counter has reached the max.
// value, then the bypass flag for the
// node is set to true.
//
// At the end of this routine, each element
// will have its bypass-flag either set or cleared.
//
void vcControlPath::Update_Group_Bypass_Flags()
{

  map<vcCPElementGroup*,int> distance_map;


  deque<vcCPElementGroup*> dfs_queue;
  set<vcCPElementGroup*>   visited_set;
  set<vcCPElementGroup*>   on_queue_set;

  // if we are not looking to minimize the clock period,
  // then all groups in the control-path will have byass
  // set to true.  WARNING: this may lead to combinational
  // cycles if trivial loops are instantiated in the program.
  if(!vcSystem::_min_clock_period_flag)
  {
  	for(set<vcCPElementGroup*, vcRoot_Compare>::iterator iter = this->_cpelement_groups.begin(),
		fiter = this->_cpelement_groups.end(); iter != fiter; iter++)
	{
  		vcCPElementGroup* grp = *iter;
		grp->_bypass_flag = true;
	}
	return;
  }


  // start the DFS with all "root" groups.
  for(set<vcCPElementGroup*, vcRoot_Compare>::iterator iter = this->_cpelement_groups.begin(),
		fiter = this->_cpelement_groups.end(); iter != fiter; iter++)
  {
	
  	vcCPElementGroup* grp = *iter;
	if(grp->_predecessors.size() == 0)
	{

		vcSystem::DebugInfo("group " + IntToStr(grp->Get_Group_Index()) + " has no predecessors, set as root of DFS.");
  		dfs_queue.push_back(grp);
  		on_queue_set.insert(grp);

  		grp->_bypass_flag = true;
  		distance_map[grp] = vcSystem::_bypass_stride;
	}
  }

  int bypass_counter;

  while(!dfs_queue.empty())
  {
	vcCPElementGroup* top = dfs_queue.front();
	visited_set.insert(top);

	int top_dist = distance_map[top];
	int bypass_counter = 0;
	
	// the bypass flag must be true, otherwise we would
	// not be here.
	if(!top->_bypass_flag)
	{
	} 

  	bool is_pipelined = (top->_pipeline_parent != NULL);
        bool is_true_join = (top->_is_join || top->_is_fork) && (is_pipelined ? 
			((top->_predecessors.size() > 1) || 
				((top->_predecessors.size() > 0) && (top->_marked_predecessors.size() > 0))) :
			(top->_predecessors.size() > 1));

	// if you have already reached the stride,
	// bypass should be set false.
	if (top->_has_input_transition || ((top_dist >= vcSystem::_bypass_stride) && is_true_join))
	{
		// if an input transition is present, then there is no need for
		// a bypass, because the output->input path always has at least
		// a unit delay.
		top->_bypass_flag = false;
		bypass_counter = 1;
		vcSystem::DebugInfo("setting bypass = false for group " + IntToStr(top->Get_Group_Index()) + ".");
	}
	else
	// if the unbypassed distance to top is < stride,
	// then bypass is set to true.
	{
		// bypass this node and increase bypass distance.
		top->_bypass_flag = true;
		bypass_counter = top_dist + 1;
		vcSystem::DebugInfo("setting bypass = true for group " + IntToStr(top->Get_Group_Index()) + ".");
	}

        bool all_neighbours_visited = true;
	for(set<vcCPElementGroup*>::iterator iter = top->_successors.begin(), fiter = top->_successors.end(); iter != fiter; iter++)
	{
		vcCPElementGroup* succ = *iter;
		if(on_queue_set.find(succ) == on_queue_set.end())
		// break cycles.
		{
			bool already_visited = false;
			if(visited_set.find(succ) != visited_set.end())
			{
				// succ has been visited.
				int old_dist =  distance_map[succ];
				if(succ->_bypass_flag && (old_dist < bypass_counter))
				{
					// if succ has been marked as to be bypassed and
					// if distance to succ has increased, then
					// continue from succ.
					distance_map[succ] = bypass_counter;
				}
				else
				{
					already_visited = true;
				}
			}
			else
			// not visited? set distance..
			{
				distance_map[succ] = bypass_counter;
				succ->_bypass_flag = true;
			}
	
			if(!already_visited)
			// if to be continued..
			{
				dfs_queue.push_front(succ);
				all_neighbours_visited = false;
			}
		}
		else
		// found a cycle ending at succ.  This implies
		// that the bypass for succ must be set to false if
		// it not already set.  We handle this by directly
		// setting the bypass distance to succ to be the
		// maximum stride.
		{
			vcSystem::DebugInfo("found cycle ending at group " + IntToStr(succ->Get_Group_Index()));
			distance_map[succ] = vcSystem::_bypass_stride;
		}
	}

	if(all_neighbours_visited)
	// pop top.
	{
		dfs_queue.pop_front();
		on_queue_set.erase(top);
	}
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

  ofile << "finAckJoin: join2 generic map(name=> \"finAckJoin\" )" << endl
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
	ofile <<  _terminator->Get_VHDL_Id() << ": loop_terminator -- {" << endl;
	ofile <<  "generic map (max_iterations_in_flight =>" <<  this->Get_Depth() << ") " << endl;
	ofile <<  "port map(loop_body_exit => " << _terminator->_loop_body->Get_Exit_Symbol(cp) << ","
		<< "loop_continue => " << _terminator->_loop_taken->Get_Exit_Symbol(cp) << ","
		<< "loop_terminate => " << _terminator->_loop_exit->Get_Exit_Symbol(cp) << ","
		<< "loop_back => " << _terminator->_loop_back->Get_Exit_Symbol(cp) << ","
		<< "loop_exit => " << _terminator->_exit_from_loop->Get_Exit_Symbol(cp) << ","
		<< "clk => clk, reset => reset);" << " -- } " << endl;
}
  
void vcCPSimpleLoopBlock::Print_Terminator_Dot_Entry(vcControlPath* cp, ostream& ofile)
{
	string tnode_id = this->_terminator->Get_VHDL_Id();
	ofile << "  " << tnode_id << " [shape=rectangle];" << endl;
	ofile << cp->Get_Group(this->_terminator->_loop_body)->Get_Dot_Id()
		<< " -> " << tnode_id << ";" << endl;
	ofile << cp->Get_Group(this->_terminator->_loop_taken)->Get_Dot_Id()
		<< " -> " << tnode_id << ";" << endl;
	ofile << cp->Get_Group(this->_terminator->_loop_exit)->Get_Dot_Id()
		<< " -> " << tnode_id << ";" << endl;
	ofile << tnode_id << " -> " << cp->Get_Group(this->_terminator->_loop_back)->Get_Dot_Id() << ";" << endl;
	ofile << tnode_id << " -> " << cp->Get_Group(this->_terminator->_exit_from_loop)->Get_Dot_Id() << ";" << endl;
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

void vcCPPipelinedLoopBody::Print_Phi_Sequencer_Dot_Entries(vcControlPath* cp, ostream& ofile)
{
	for(int idx = 0, fidx = _phi_sequencers.size(); idx < fidx; idx++)
		_phi_sequencers[idx]->Print_Dot_Entry(cp,ofile);
}

void vcCPPipelinedLoopBody::Print_Transition_Merge_Dot_Entries(vcControlPath* cp, ostream& ofile)
{
	for(int idx = 0, fidx = _transition_merges.size(); idx < fidx; idx++)
		_transition_merges[idx]->Print_Dot_Entry(cp,ofile);
}


void vcControlPath::Print_Reduced_Control_Path_As_Dot_File(ostream& ofile)
{
	vcCPElementGroup* entry_grp = _cpelement_to_group_map[this->_entry];
	vcCPElementGroup* exit_grp  = _cpelement_to_group_map[this->_exit];

	ofile << "digraph control_path {" << endl;
	// ofile << "  node [shape = rectangle]; " << endl;

	// two passes: first pass, print all the nodes.	
	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* grp = *iter;

		if(grp == entry_grp)
			ofile << "  " << grp->Get_Dot_Id() << ": entry_node " << ": n ;" << endl;
		else if(grp == exit_grp) 
			ofile << "  " << grp->Get_Dot_Id() << ": exit_node " << ": s ;" << endl;
		else if(grp->_has_input_transition && !grp->_has_output_transition)		
			ofile << "  " << grp->Get_Dot_Id() << " [shape = triangle];" << endl;
		else if(grp->_has_output_transition && !grp->_has_input_transition)		
			ofile << "  " << grp->Get_Dot_Id() << " [shape = invtriangle];" << endl;
		else if(grp->_has_output_transition && grp->_has_input_transition)		
			ofile << "  " << grp->Get_Dot_Id() << " [shape = diamond];" << endl;
		else if(grp->_is_join)
			ofile << "  " << grp->Get_Dot_Id() << " [shape = invtrapezium];" << endl;
		else if(grp->_is_fork)
			ofile << "  " << grp->Get_Dot_Id() << " [shape = trapezium];" << endl;
		else if(grp->_is_merge || grp->_is_branch)
			ofile << "  " << grp->Get_Dot_Id() << " [shape = circle];" << endl;
		else
			ofile << "  " << grp->Get_Dot_Id() << " [shape = dot];" << endl;
	}

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* grp = *iter;

		uint32_t idx;
		for(set<vcCPElementGroup*>::iterator piter = grp->_predecessors.begin(),
				fpiter = grp->_predecessors.end();
				piter != fpiter;
				piter++)
		{
			vcCPElementGroup* pred = *piter;
			ofile << "  " << pred->Get_Dot_Id() << " -> " << grp->Get_Dot_Id() << ";" << endl;
		}

		for(set<vcCPElementGroup*>::iterator miter = grp->_marked_predecessors.begin(),
				fmiter = grp->_marked_predecessors.end();
				miter != fmiter;
				miter++)
		{
			vcCPElementGroup* pred = *miter;
			ofile << "  " << pred->Get_Dot_Id() << " -> " << grp->Get_Dot_Id() 
				<< "[style = dashed]" << ";" << endl;
		}
	}

	for(set<vcCPSimpleLoopBlock*>::iterator slb_iter = _simple_loop_blocks.begin(), fslb_iter = _simple_loop_blocks.end();
			slb_iter != fslb_iter;
			slb_iter++)
	{
		vcCPSimpleLoopBlock* slb = *slb_iter;
		slb->Print_Terminator_Dot_Entry(this,ofile);

		vcCPPipelinedLoopBody* plb = slb->Get_Loop_Body();
		plb->Print_Phi_Sequencer_Dot_Entries(this,ofile);
		plb->Print_Transition_Merge_Dot_Entries(this,ofile);
	}

	ofile << "}" << endl;
}


