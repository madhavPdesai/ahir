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
#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcControlPath.hpp>
#include <vcDataPath.hpp>
#include <vcOperator.hpp>
#include <vcSystem.hpp>
#include <vcModule.hpp>
#include <BGLWrap.hpp>

int _flip_flop_count;
int _saved_flip_flop_count;
int _mux2_count;
int _and2_count;

void vcPlace::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{
  vcCPElementGroup* my_group = cp->Make_New_Group();
  cp->Add_To_Group(this,my_group);
}

void vcTransition::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{
  if((this->Get_Is_Delay_Element()) &&
	(this->_predecessors.size() == 0))
  {
	vcSystem::Error("Transition " + this->Get_Id() + " is delay element and has no predecessors?");
  }
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
	  cp->Connect_Groups(pred_group,my_group,false, 0);
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
	  cp->Connect_Groups(my_group,succ_group,false, 0);
	}
    }

  // update marked connections between my group and predecessor groups
  for(int idx = 0; idx < _marked_predecessors.size() ; idx++)
    {
      vcCPElement* pred = _marked_predecessors[idx]->Get_Exit_Element();
      int delay = this->Get_Marked_Predecessor_Delay(_marked_predecessors[idx]);

      vcCPElementGroup* pred_group = cp->Get_Group(pred);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Entry_Element());

      if(pred_group != NULL && pred_group != my_group)
	{
	  cp->Connect_Groups(pred_group,my_group,true, delay);
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
      int delay = this->Get_Marked_Successor_Delay(_marked_successors[idx]);

      vcCPElementGroup* succ_group = cp->Get_Group(succ);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Exit_Element());
      if(succ_group != NULL && succ_group != my_group)
	{
	  cp->Connect_Groups(my_group,succ_group,true, delay);
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

vcCPElement* vcCPElementGroup::Get_Top_Element()
{
	vcCPElement* cpe = NULL;
	if(_elements.size() > 0)
		cpe = *(_elements.begin());
	return(cpe);	
}

  
string vcCPElementGroup::Get_VHDL_Id()
{
      string prefix = this->_cp->Get_VHDL_Id() + "_elements";
      string ret_string = prefix + "(" + Int64ToStr(this->Get_Group_Index()) + ")"; 
      return(ret_string);
}

int  vcCPElementGroup::Get_Marked_Successor_Delay(vcCPElementGroup* g)
{
	if(_marked_successor_delays.find(g) != _marked_successor_delays.end())
		return(_marked_successor_delays[g]);
	else
		return(-1);
}
int  vcCPElementGroup::Get_Marked_Predecessor_Delay(vcCPElementGroup* g)
{
	if(_marked_predecessor_delays.find(g) != _marked_predecessor_delays.end())
		return(_marked_predecessor_delays[g]);
	else
		return(-1);
}

bool vcCPElementGroup::Is_Pure_Transition_Group()
{
	if( _has_place ||
		_has_input_transition ||
		_has_output_transition ||
		_has_dead_transition ||
		_has_tied_high_transition ||
		_has_left_open_transition ||
		_is_delay_element ||
		_is_bound_as_input_to_cp_function ||
		_is_bound_as_output_from_cp_function ||
		_is_bound_as_input_to_region ||
		_is_bound_as_output_from_region ||
		(_associated_cp_function != NULL) ||
		(_associated_cp_region != NULL) ||
		_is_left_open )
		return(false);
	if(_marked_predecessors.size() > 0)
		return(false);
	if(_marked_successors.size() > 0)
		return(false);
	if(_successors.size() > 1)
		return(false);

	return(_has_transition);
	
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
  else if(this->_is_delay_element)
    ret_val = false;
  //else if(this->_is_bound_as_output_from_region)
    //ret_val = false;
  else if(g->_is_bound_as_output_from_cp_function)
    ret_val = false;
  else if(g->_is_delay_element)
    ret_val = false;
  else if(g->_has_input_transition)
    ret_val = false;
  else if(g->_marked_predecessors.size() > 0) // such a transition should not be pulled in because
						// it will introduce a false wait on "this".
    ret_val = false;
  else if(this->_pipeline_parent != g->_pipeline_parent)
    ret_val = false;
  else
    {
      // g must have one predecessor and it must be this 
      if((g->_predecessors.size() == 1) && 
	 //(this->_successors.size() == 1) && 
	 ((*(g->_predecessors.begin())) == this))
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


 	// is delay element?
      this->_is_delay_element |= (((vcTransition*)cpe)->Get_Is_Delay_Element());
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

      if(this->_has_output_transition && (this->_output_transitions.size() == 0))
	{
		vcSystem::Error("panic!.. added transition " + tr->Get_Id() + ": garbled output status");
	}
      if(this->_has_input_transition && (this->_input_transition == NULL))
	{
		vcSystem::Error("panic!.. added transition " + tr->Get_Id() + ": garbled input status");
	}
    }
  else if(cpe->Is_Place())
    {
      this->_has_place = true;

      if(cpe->Get_Number_Of_Predecessors() > 1)
	this->_is_merge = true;
      if(cpe->Get_Number_Of_Successors() > 1)
	this->_is_branch = true;
      if(cpe->Get_Is_Left_Open())
	this->_is_left_open = true;	
    }

  _elements.insert(cpe);

  vcCPBlock* pipeline_parent = cpe->Get_Pipeline_Parent();
  if(_pipeline_parent == NULL)
	  _pipeline_parent = pipeline_parent;
  else if(_pipeline_parent != pipeline_parent)
	  vcSystem::Error("Group has conflicting pipeline parent.");

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
  ofile << "-- CP-element group " << _group_index << ": ";
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
  if(_is_delay_element)
    ofile << " delay-element ";
  if(_has_tied_high_transition)
    ofile << " tied-high ";
  if(_has_left_open_transition)
    ofile << " left-open ";
  if(_bypass_flag)
    ofile << " bypass ";
  else
    ofile << " no-bypass ";
  if(_pipeline_parent != NULL)
    ofile << " pipeline-parent ";

  ofile << endl;
  ofile << "-- CP-element group " << _group_index << ": predecessors " << endl;
  for(set<vcCPElementGroup*>::iterator iter = _predecessors.begin(), fiter = _predecessors.end();
      iter != fiter;
      iter++)
    {
      ofile << "-- CP-element group " << _group_index << ": \t";
      ofile <<  (*iter)->Get_Group_Index() << " ";
      ofile << endl;
    }
  ofile << endl;

  if(_marked_predecessors.size() > 0)
  {
     ofile << "-- CP-element group " << _group_index << ": marked-predecessors " << endl;
     for(set<vcCPElementGroup*>::iterator iter = _marked_predecessors.begin(), fiter = _marked_predecessors.end();
         iter != fiter;
         iter++)
       {
      	 ofile << "-- CP-element group " << _group_index << ": \t";
         ofile << (*iter)->Get_Group_Index() << " ";
	 ofile << endl;
       }
     ofile << endl;
  }

  ofile << "-- CP-element group " << _group_index << ": successors " << endl;
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
      ofile << "-- CP-element group " << _group_index << ": \t";
      ofile << (*iter)->Get_Group_Index() << " ";
      ofile << endl;
    }
  ofile << endl;

  if(_marked_successors.size() > 0)
  {
      ofile << "-- CP-element group " << _group_index << ": marked-successors " << endl;
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
        ofile << "-- CP-element group " << _group_index << ": \t";
        ofile << (*iter)->Get_Group_Index() << " ";
	ofile << endl;
      }
    ofile << endl;
  }


  ofile << "-- CP-element group " << _group_index << ": ";
  ofile << " members (" << _elements.size() << ") {" << endl;
  for(set<vcCPElement*>::iterator iter = _elements.begin(), fiter = _elements.end();
      iter != fiter;
      iter++)
    {
      ofile << "-- CP-element group " << _group_index << ": \t ";
      ofile << (*iter)->Get_Hierarchical_Id() << endl;
    }
  ofile << "-- }" << endl;
}


string vcCPElementGroup::Generate_Marked_Join_Bypass_String()
{
	string ret_string ;
	int N = _marked_predecessors.size();
	if(N > 0)
	{
	    ret_string = "constant markedPredBypass: BooleanArray(" + IntToStr(N-1) + " downto 0) := (";
	    int C = 0;
	    for(set<vcCPElementGroup*>::iterator iter = _marked_predecessors.begin(), fiter = _marked_predecessors.end();
		iter != fiter; iter++)
	    {
		    vcCPElementGroup* cpg = *iter;
		    if(C > 0)
			    ret_string += ", ";
		    ret_string += IntToStr(C) + " => " + ((this->Get_Marked_Predecessor_Delay(cpg) > 0) ? "false" : "true");
		    C++;
	    }
	    ret_string += ");";
	}
	return(ret_string);
}

void vcCPElementGroup::Print_VHDL_Logger(ostream& ofile)
{
	string module_name = this->_cp->Get_Parent_Module()->Get_VHDL_Id();
	string logger_message = "logger:" + module_name + ":CP:" + this->Get_VHDL_Id() + " fired.";
	ofile << "-- logger for CP element group " << this->Get_VHDL_Id() << endl;
	ofile << "process (clk) " << endl;
	ofile << "begin --{" << endl;
	ofile << " if (clk'event and (clk = '1') and (reset = '0') and " << this->Get_VHDL_Id() << ") then -- {" << endl;
	ofile << " LogRecordPrint(global_clock_cycle_count,  \" " << logger_message << "\"); " << endl;
	if(this->_input_transition)
	{
		string ip_logger_message = "logger:" + module_name + ":CP:" + this->_input_transition->Get_DP_To_CP_Symbol() + " fired.";
		ofile << " LogRecordPrint(global_clock_cycle_count,  \" " << ip_logger_message << "\"); " << endl;
	}
  	for(int idx = 0, fidx = _output_transitions.size(); idx < fidx; idx++)
  	{
		string ack_str = this->_output_transitions[idx]->Get_CP_To_DP_Symbol();
		string op_logger_message = "logger:" + module_name + ":CP:" + ack_str + " fired.";
		ofile << " LogRecordPrint(global_clock_cycle_count,  \" " << op_logger_message << "\"); " << endl;
  	}
        ofile << "-- }" << endl;
	ofile << "end if; --} " << endl;
        ofile << "end process; " << endl;
}

// take care of marked predecessors!
void vcCPElementGroup::Print_VHDL(ostream& ofile)
{

  string module_name = this->_cp->Get_Parent_Module()->Get_VHDL_Id();
  string bypass_string = (this->_bypass_flag ?  "true" : "false");
  int bypass_delay = (this->_bypass_flag ? 0 : 1);
  string delay_element = (this->_is_delay_element ? " delay-element ": "");

  // print out the group into the VHDL file.
  this->Print(ofile);

  if(this->_has_output_transition && (this->_output_transitions.size() == 0))
  {
	  vcSystem::Error("panic!.. group " + this->Get_VHDL_Id() + ": garbled output status");
  }
  if(this->_has_input_transition && (this->_input_transition == NULL))
  {
	  vcSystem::Error("panic!.. group " + this->Get_VHDL_Id() + ": garbled input status");
  }

  if(vcSystem::_enable_logging)
	this->Print_VHDL_Logger(ofile);
 
  if(this->_has_input_transition)
  {
	  this->Print_DP_To_CP_VHDL_Link(ofile);
  }

  for(int idx = 0, fidx = _output_transitions.size(); idx < fidx; idx++)
  {
	  this->Print_CP_To_DP_VHDL_Link(idx, ofile);
  }

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

  if(this->_is_delay_element)
  {
	  assert(_predecessors.size() == 1);
	  assert(_marked_predecessors.size() == 0);
	  ofile << "-- Element group " << this->Get_VHDL_Id() << " is a control-delay." << endl;
	  ofile << "cp_element_" << this->Get_Group_Index() << "_delay: control_delay_element "
		  << " generic map(name => \" " << this->Get_Group_Index() << "_delay\", delay_value => 1) " 
		  << " port map(req => " << (*(_predecessors.begin()))->Get_VHDL_Id()
		  << ", ack => " << this->Get_VHDL_Id()
		  << ", clk => clk, reset =>reset);" << endl;
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
	  if(!this->_has_input_transition)
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
			  if(!this->_is_cp_entry && !this->_is_left_open)
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
			   (_marked_predecessors.size() > 0)) :
			  (_predecessors.size() > 1));
	  if(is_true_join && (this->_input_transition == NULL))
	  {
		  vector<string> preds; 
		  vector<int> pred_markings;
		  vector<int> pred_capacities;
		  vector<int> pred_delays;
		  string joined_symbol = this->Get_VHDL_Id();
		  string join_name = module_name + "_cp_element_group_" + IntToStr(this->Get_Group_Index());

		  if(_predecessors.size() > 1)
			  _and2_count += (_predecessors.size() - 1);

		  int saved_flop_count = 0;
		  for(set<vcCPElementGroup*>::iterator iter = _predecessors.begin(),
				  fiter = _predecessors.end();
				  iter != fiter;
				  iter++)
		  {
			  vcCPElementGroup* pg = (*iter);
			  preds.push_back((*iter)->Get_VHDL_Id());
			  pred_markings.push_back(0);

			  // If the predecessor is in the same SCC, then it can
			  // never have more than one token.
			  int pred_capacity = max_iterations_in_flight;
			  if((pg->Get_SCC_Index() > 0) && (pg->Get_SCC_Index() == this->Get_SCC_Index()))
				pred_capacity = 1;
			  pred_capacities.push_back(pred_capacity);

			  pred_delays.push_back(bypass_delay);

			  _flip_flop_count += CeilLog2(pred_capacity);
			  _saved_flip_flop_count += CeilLog2(max_iterations_in_flight) - CeilLog2(pred_capacity);

			  if(bypass_delay == 0)
				  _mux2_count++;

		  }

		  for(set<vcCPElementGroup*>::iterator iter = this->_marked_predecessors.begin(),
				  fiter = _marked_predecessors.end();
				  iter != fiter;
				  iter++)
		  {
			  preds.push_back((*iter)->Get_VHDL_Id());
			  pred_markings.push_back(1);
			  pred_capacities.push_back(1);
			  int dly = this->Get_Marked_Predecessor_Delay(*iter);
			  pred_delays.push_back(dly);
			  _flip_flop_count++;
			  if(dly == 0)
				  _mux2_count++;
		  }

		  Print_VHDL_Join(join_name, preds, pred_markings, pred_capacities, pred_delays, joined_symbol, ofile);
	  }
	  else if((_predecessors.size() == 1) && (this->_input_transition == NULL))
	  {
		  ofile << this->Get_VHDL_Id() << " <= ";	      
		  ofile << (*(_predecessors.begin()))->Get_VHDL_Id() << ";" << endl;
	  }
	  else if(this->_input_transition == NULL)
	  {
		  vcSystem::Warning("CP-element group " + this->Get_VHDL_Id() + " has no true predecessors.\n");
	  }
  }
}

void vcCPElementGroup::Print_DP_To_CP_VHDL_Link(ostream& ofile)
{
	string ack_str =  this->Get_VHDL_Id(); 
	string req_str = this->_input_transition->Get_DP_To_CP_Symbol();

	string delay_str = "0";
	ofile << this->_input_transition->Get_Exit_Symbol() << "_link_from_dp: control_delay_element -- { "  << endl
		<< " generic map(name => \" " << this->Get_Group_Index() << "_delay\","
		<< "delay_value => " << delay_str << ")" << endl
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
		<< " generic map(name => \" " << this->_output_transitions[idx]->Get_Exit_Symbol() << "_delay\","
		<< "delay_value => " << delay_str << ")" << endl
		<< "port map(clk => clk, reset => reset, req => " << req_str
		<< ", ack => " << ack_str << "); -- } " << endl;
}

void vcControlPath::Construct_Reduced_Group_Graph()
{
	this->vcCPBlock::Construct_CPElement_Group_Graph_Vertices(this);
	this->vcCPBlock::Connect_CPElement_Group_Graph(this);
	if(this->Check_Group_Graph_Structure())
	{
		vcSystem::Error("malformed group graph after construction.");
	}

	vcSystem::Info("Detect and try to fix combinational loops by increasing interlock-buffering (two passes)");
	int err = this->Fix_Combinational_Loops(1); // first-pass
	if (err)
	{
		err = this->Fix_Combinational_Loops(2); // second-pass

		if(err)
		{
			err = this->Fix_Combinational_Loops(3);
		}
	}

	this->Reduce_CPElement_Group_Graph();
	if(this->Check_Group_Graph_Structure())
	{
		vcSystem::Error("malformed group graph after reduction.");
	}
	this->Identify_Strongly_Connected_Components();
	//this->Print_Groups(cerr);	
}

	
//
// when pass-index == 1, it tries to fix combinational loops by double buffering
// interlock buffers.
//
// when pass-index == 2, it tries to fix combinational loops by double buffering
// Split operators.
//
// when pass_index == 3, it reports an error if there is a loop
//
// returns 0 if no loops found, 1 otherwise
// 
int vcControlPath::Fix_Combinational_Loops(int pass_index)
{
	vcSystem::Info("Started Fix_Combinational_Loops (pass " + IntToStr(pass_index) + ")");
        if(pass_index == 1)
		vcSystem::Info("Started will double buffer interlock-buffers if needed");
	if(pass_index == 2)
		vcSystem::Info("Started will double buffer split-protocol operartors if needed");
	if(pass_index == 3)
		vcSystem::Info("Final pass to check if double buffering has worked"); 
	

	int err = 0;

	// first build a graph.
	GraphBase  t_graph;

	//
	// At this point, each group has one element.
	//
	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
	
		// must have one element.
		assert(g->_elements.size() == 1);
		vcCPElement* e = g->Get_Top_Element();

		t_graph.Add_Vertex ((void*) e);
		if(vcSystem::_verbose_flag)
			cerr << "FCL (pass " << pass_index << "): added vertex " << e->Get_Id() << endl;
	}

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		vcCPElement* e = g->Get_Top_Element();
		if(!e->Get_Is_Delay_Element() && !e->Is_Output_Transition() && !e->Get_Is_Bound_As_Input_To_CP_Function() && !e->Get_Is_Dead())
		// If e is a delay element, no need to look at its successors..
		// If e is an output transition, then the DPE to which it is linked
		//   will set-up the arc.
		// If e is bound as output of CP function, then the CP function will
		//   set up th earc.
		// If e is dead, it is dead.
		{
			for(set<vcCPElementGroup*>::iterator succ_iter = g->_successors.begin(), fsucc_iter = g->_successors.end();
					succ_iter != fsucc_iter; succ_iter++)
			{
				vcCPElementGroup* s = *succ_iter;
				vcCPElement* f = s->Get_Top_Element();

				if(e != f)
					t_graph.Add_Edge(e,f);	

				if(vcSystem::_verbose_flag)
					cerr << "FCL (pass " << pass_index << "): added control edge " << e->Get_Id() << " -> " << f->Get_Id() <<  endl;
			}

			for(set<vcCPElementGroup*>::iterator msucc_iter = g->_marked_successors.begin(), fmsucc_iter = g->_marked_successors.end();
					msucc_iter != fmsucc_iter; msucc_iter++)
			{
				vcCPElementGroup* s = *msucc_iter;
				vcCPElement* h = s->Get_Top_Element();
				
				int m_delay = e->Get_Marked_Successor_Delay(h);

				// add e -> h if not delayed.
				if(m_delay == 0)
				{
					if(e != h)
						t_graph.Add_Edge(e,h);	

					if(vcSystem::_verbose_flag)
						cerr << "FCL (pass " << pass_index << "): added (marked) control edge " << e->Get_Id() << " -> " << h->Get_Id() <<  endl;
				}
			}

		}

		if(e->Is_Output_Transition())
		//
		// check which one it is and if there is an output transition
		// to which it has a zero delay connection
		//
		{
			set<vcCPElement*> zero_delay_successors;

			zero_delay_successors.clear();
			vcTransition* te = (vcTransition*) e;		

			this->Find_Zero_Delay_Successors_Via_DPE(te, zero_delay_successors);
			for(set<vcCPElement*>::iterator uiter = zero_delay_successors.begin(), fuiter = zero_delay_successors.end();
				uiter != fuiter; uiter++)
			{
				if(e != *uiter)
					t_graph.Add_Edge(e, *uiter);
				if(vcSystem::_verbose_flag)
					cerr << "FCL (pass " << pass_index << "): added (dpe) control edge " << e->Get_Id() << " -> " << (*uiter)->Get_Id() <<  endl;
			}
		}
		
		if(e->Is_Transition() && e->Get_Is_Bound_As_Input_To_CP_Function())
		{
			set<vcCPElement*> zero_delay_successors;
			this->Find_Zero_Delay_Successors_Via_CP_Function((vcTransition*)e, zero_delay_successors);
			for(set<vcCPElement*>::iterator uiter = zero_delay_successors.begin(), fuiter = zero_delay_successors.end();
				uiter != fuiter; uiter++)
			{
				if (e != *uiter)	
					t_graph.Add_Edge(e, *uiter);
				if(vcSystem::_verbose_flag)
					cerr << "FCL (pass " << pass_index << "): added (cpf) control edge " << e->Get_Id() << " -> " << (*uiter)->Get_Id() <<  endl;
			}
		}
	}

	map<void*, int>   scc_map;
	t_graph.Strongly_Connected_Components(scc_map);

	map<int, vector<vcCPElement*> >  scc_member_map;
	for(map<void*,int>::iterator miter=scc_map.begin(), fmiter = scc_map.end(); miter != fmiter; miter++)
	{
		vcCPElement* cpeg = (vcCPElement*) ((*miter).first);
		int scc_index = (*miter).second;

		scc_member_map[scc_index].push_back(cpeg);
	}

		
	set <vcDatapathElement*> dpes_in_combinational_cycle;
	for(map<int, vector<vcCPElement*> >::iterator mmiter=scc_member_map.begin(), fmmiter = scc_member_map.end(); mmiter != fmmiter; mmiter++)
	{
		int I = (*mmiter).first;
		int vsize = (*mmiter).second.size();
		if(vsize > 1) 
		{
			err = 1;
			if(pass_index == 3)
			{
				vcSystem::Error("Fix_Combinational (pass 2): found a combinational cycle (strongly-connected-component) in module " + this->_parent_module->Get_Label());
			}
			else
			{
				vcSystem::Warning("Fix_Combinational (pass " + IntToStr(pass_index) + "): found a combinational cycle (strongly-connected-component) in module " + this->_parent_module->Get_Label());
			}
			cerr << "Combination cycle control elements  " << endl;
			for(int J = 0, fJ = (*mmiter).second.size();  J < fJ; J++)
			{
				vcCPElement* q = (*mmiter).second[J];
				if(q->Is_Input_Transition())
				{
					vcTransition* tq = (vcTransition*) q;
					this->Include_DPE_Elements_Bound_With_Ack_Transition(tq, dpes_in_combinational_cycle);
				}
				cerr << "   " <<  (*mmiter).second[J]->Get_Id() << endl;
			}
		}
	}

	if(dpes_in_combinational_cycle.size() > 0)
	{
		cerr << "The following DPE's are involved in combinational cycles" << endl;
		for(set<vcDatapathElement*>::iterator siter = dpes_in_combinational_cycle.begin(), fsiter = dpes_in_combinational_cycle.end();
				siter != fsiter; siter++)
		{
			vcDatapathElement* dpe = *siter;
			cerr << " " << 	dpe->Get_Id() << endl;

			if((dpe->Kind() == "vcInterlockBuffer") && (pass_index == 1))
			{
				vcInterlockBuffer* ilb = (vcInterlockBuffer*) dpe;
				if(ilb->Get_Output_Buffering(ilb->Get_Dout()) < 2)
				{
					cerr << "  Setting buffering on ILB " << dpe->Get_Id() << " to 2" << endl;
					ilb->Set_Output_Buffering(ilb->Get_Dout(),2);
				}

				cerr << "  Setting cut_through = false on ILB " << dpe->Get_Id() << endl;
				ilb->Set_Cut_Through(false);
			}

			if(dpe->Is_Split_Operator() && (dpe->Get_Number_Of_Output_Wires() == 1) && (pass_index == 2))
			{
				cerr << "  Setting buffering on Split-operator " << dpe->Get_Id() << " to 2" << endl;
				dpe->Set_Output_Buffering(dpe->Get_Output_Wire(0),2);
			}
		}
	}

	if(!err)
	{
		vcSystem::Info(" Fix_Combi pass OK");	
	}
	return(err);
}


void vcControlPath::Find_Zero_Delay_Successors_Via_DPE(vcTransition* t, set<vcCPElement*>& zero_delay_successors)
{
	for(int idx = 0, fidx = t->_dp_link.size(); idx < fidx; idx++)
	{
		vcDatapathElement* dpe = t->_dp_link[idx].first;
		dpe->Append_Zero_Delay_Successors_To_Req(t,zero_delay_successors);	
	}
}
  
void vcControlPath::Find_Zero_Delay_Successors_Via_CP_Function(vcTransition* t, set<vcCPElement*>& zero_delay_successors)
{
	for(set<vcCPSimpleLoopBlock*>::iterator slb_iter = _simple_loop_blocks.begin(), fslb_iter = _simple_loop_blocks.end();
			slb_iter != fslb_iter;
			slb_iter++)
	{
		vcCPSimpleLoopBlock* slb = *slb_iter;
		slb->Get_Terminator()->Append_Zero_Delay_Successors(t, zero_delay_successors);

		vcCPPipelinedLoopBody* plb = slb->Get_Loop_Body();
		for(int idx = 0, fidx = plb->Get_Number_Of_Phi_Sequencers();  idx < fidx; idx++)
		{
			vcPhiSequencer* ps = plb->Get_Phi_Sequencer(idx);
			ps->Append_Zero_Delay_Successors(t,zero_delay_successors);
		}

		for(int jdx = 0, fjdx = plb->Get_Number_Of_Transition_Merges(); jdx < fjdx; jdx++)
		{
			vcTransitionMerge* tm = plb->Get_Transition_Merge(jdx);
			tm->Append_Zero_Delay_Successors(t,zero_delay_successors);
		}

	}
}

void vcControlPath::Include_DPE_Elements_Bound_With_Ack_Transition(vcTransition* t, set<vcDatapathElement*>& dpe_set)
{
	for(int idx = 0, fidx = t->_dp_link.size(); idx < fidx; idx++)
	{
		vcDatapathElement* dpe = t->_dp_link[idx].first;
		vcTransitionType tt = t->_dp_link[idx].second;
	
		if(tt == _IN_TRANSITION)
		{
			dpe_set.insert(dpe);
		}		
	}
}


void vcControlPath::Index_Groups()
{
	int idx = 0;
	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		g->Set_Group_Index(idx);
		idx++;
	}
}

//
// TODO: change the algorithm.
//   1. Identify nuclei: all elements without predecessors.
//   2. From each, nucleus, DFS search forward
//      and keep finding new nucleii
//   3. Stop when nucleus set is empty.
//    
void vcControlPath::Reduce_CPElement_Group_Graph()
{
	cerr << "Info: reducing Control-path " << endl;

	// eliminate dead groups.
	this->Eliminate_Dead_Groups();

	// index the groups.
	this->Index_Groups();

	set<vcCPElementGroup*> nucleii;
	set<vcCPElementGroup*> absorbed_elements;

	this->Identify_Nucleii(nucleii);

	while(nucleii.size() > 0)
	{
		vcCPElementGroup* nucleus = *(nucleii.begin());
		absorbed_elements.insert(nucleus);
		nucleii.erase(nucleus);
		this->Reduce_From_Nucleus(nucleus, absorbed_elements, nucleii);
	}


	this->Last_Gasp_Reduce();

	// index the groups.. again..
	this->Index_Groups();

	this->Collapse_Pure_Transition_Components();

	//finally, update the bypass entries.
	this->Update_Group_Bypass_Flags();
}

void vcControlPath::Last_Gasp_Reduce()
{
	vector<vcCPElementGroup*> reduction_candidates;
	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = (*iter);
		if((!g->_is_bound_as_output_from_cp_function) &&
				(!g->_has_input_transition) &&
				(g->_marked_predecessors.size() == 0) &&
				(!g->_is_delay_element) &&
				(g->_predecessors.size() == 1))
		{
			reduction_candidates.push_back(g);
		} 	  
	}

	for(int I = 0, fI = reduction_candidates.size(); I < fI; I++)
	{
		vcCPElementGroup* g = reduction_candidates[I];
		vcCPElementGroup* pg = *(g->_predecessors.begin());

		if((g->_pipeline_parent == pg->_pipeline_parent) &&
				(g->_associated_cp_function == pg->_associated_cp_function))
		{
			// Do not create merge/join OR branch/fork
			// aliasing.
			if((g->_pipeline_parent != NULL) ||
				(!(pg->_is_join && g->_is_merge) &&
				 !(pg->_is_merge && g->_is_join) &&
				 !(g->_is_branch && pg->_is_fork) &&
				 !(g->_is_fork && pg->_is_branch)))
			{
				this->Merge_Groups(g,pg);	
			}
		}
	}
}

//
// find connected components of pure transitions.
// A transition is pure if
//    it is not an input/output transition
//    it has no marked predecessors.
//    it has no marked successors.
//    it is not bound as i/o transition to anything.
//
void vcControlPath::Collapse_Pure_Transition_Components()
{
	UGraphBase  t_graph;

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		if(g->Is_Pure_Transition_Group())
			t_graph.Add_Vertex ((void*) g);
	}

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		if(g->Is_Pure_Transition_Group())
		{
			for(set<vcCPElementGroup*>::iterator succ_iter = g->_successors.begin(), fsucc_iter = g->_successors.end();
					succ_iter != fsucc_iter; succ_iter++)
			{
				vcCPElementGroup* s = *succ_iter;
				if(s->Is_Pure_Transition_Group())
				{
					if(g->_pipeline_parent == s->_pipeline_parent)
						t_graph.Add_Edge(g,s);	
				}
			}

		}
	}

	map<int, set<void*> >  cc_map;
	t_graph.Connected_Components(cc_map);

	for(int idx = 0, fidx = cc_map.size(); idx < fidx; idx++)
	{
		this->Collapse_Pure_Transition_Set(cc_map[idx]);	
	}

	this->Index_Groups();
}



void vcControlPath::Collapse_Pure_Transition_Set(set<void*>& tset)
{
	if(tset.size() > 1)
	{

		if(vcSystem::_verbose_flag)
			vcSystem::Info("collapsing pure transition set of size " + IntToStr(tset.size()));
		vcCPElementGroup* cg = new vcCPElementGroup(this);
		_cpelement_groups.insert(cg);

		cg->_has_transition = true;	

		set<vcCPElementGroup*> preds;
		set<vcCPElementGroup*> succs;

		for(set<void*>::iterator iter = tset.begin(), fiter = tset.end(); iter != fiter; iter++)
		{
			vcCPElementGroup* e = (vcCPElementGroup*) *iter;

			if(cg->_pipeline_parent == NULL)
				cg->_pipeline_parent = e->_pipeline_parent;
			else
				assert(cg->_pipeline_parent == e->_pipeline_parent);

			// move all the elements of e into cg.
			for(set<vcCPElement*>::iterator eiter = e->_elements.begin(), feiter = e->_elements.end();
					eiter != feiter; eiter++)
			{
				this->_cpelement_to_group_map.erase(*eiter);
				this->Add_To_Group(*eiter,cg);
			}

			// disconnect e from all predecessors of e
			// if the predecessor of e is not in tset,
			// add it to the predecessor set.
			for(set<vcCPElementGroup*>::iterator pred_iter = e->_predecessors.begin(), 
					fpred_iter = e->_predecessors.end();
					pred_iter != fpred_iter; pred_iter++)
			{
				vcCPElementGroup* pe = *pred_iter;
				pe->_successors.erase(e);
				if(tset.find((void*)pe) == tset.end())
					this->Connect_Groups(pe,cg, false, 0); 
			}

			// disconnect e from all successors of e
			// if the successor of e is not in tset,
			// add it to the successor set.
			for(set<vcCPElementGroup*>::iterator succ_iter = e->_successors.begin(), 
					fsucc_iter = e->_successors.end();
					succ_iter != fsucc_iter; succ_iter++)
			{
				vcCPElementGroup* se = *succ_iter;
				se->_predecessors.erase(e);
				if(tset.find((void*)se) == tset.end())
					this->Connect_Groups(cg,se, false, 0);
			}

			// remove e from graph vertex set.
			_cpelement_groups.erase(e);
		}
	}
}

void vcControlPath::Add_To_Reverse_Map(map<vcTransition*, vcCPElementGroup*>& transition_group_map,
			vcCPElementGroup* g)
{

	for(set<vcCPElement*>::iterator esiter = g->_elements.begin(),
			fesiter = g->_elements.end(); 
			esiter != fesiter; esiter++)
	{
		vcCPElement* e = *esiter;
		if(e->Is_Transition())
		{
			transition_group_map[(vcTransition*) e] = g;
		}
	}
}

void vcControlPath::Identify_Strongly_Connected_Components()
{
	GraphBase  t_graph;
	set<vcCPBlock*, vcRoot_Compare> pipeline_parents;
	map<vcTransition*, vcCPElementGroup*> transition_group_map;

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		if(g->_pipeline_parent)
		{
			pipeline_parents.insert(g->_pipeline_parent);
		}
		t_graph.Add_Vertex ((void*) g);

		// keep the reverse map from transition to group.
		this->Add_To_Reverse_Map(transition_group_map, g);
	}

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		for(set<vcCPElementGroup*>::iterator succ_iter = g->_successors.begin(), 
				fsucc_iter = g->_successors.end();
				succ_iter != fsucc_iter; succ_iter++)
		{
			vcCPElementGroup* s = *succ_iter;
			if(g->_pipeline_parent == s->_pipeline_parent)
				t_graph.Add_Edge(g,s);	
		}

		for(set<vcCPElementGroup*>::iterator msucc_iter = g->_marked_successors.begin(), 
				fmsucc_iter = g->_marked_successors.end();
				msucc_iter != fmsucc_iter; msucc_iter++)
		{
			vcCPElementGroup* s = *msucc_iter;
			if(g->_pipeline_parent == s->_pipeline_parent)
				t_graph.Add_Edge(g,s);	
		}

	}

	// make connections through the PHI Sequencer blocks in order to identify
	// SCC elements.
	for(set<vcCPBlock*,vcRoot_Compare>::iterator pp_iter = pipeline_parents.begin(), 
			fpp_iter = pipeline_parents.end(); pp_iter != fpp_iter; pp_iter++)
	{
		vcCPBlock* pp = *pp_iter;
		if(pp->Is("vcCPPipelinedLoopBody"))
			// through phi sequencer...  These paths were missed earlier.
		{
			vcCPPipelinedLoopBody* plb = (vcCPPipelinedLoopBody*) pp;
			vcPhiSequencer* ps = NULL;
			for(int pidx = 0, fpidx = plb->Get_Number_Of_Phi_Sequencers();
					pidx < fpidx; pidx++)
			{
				ps = plb->Get_Phi_Sequencer(pidx);
				vcTransition* sr = ps->_phi_sample_req;
				vcTransition* sc = ps->_phi_sample_ack; 

				vcCPElementGroup* srg = transition_group_map[sr];
				vcCPElementGroup* scg = transition_group_map[sc];
				t_graph.Add_Edge(srg,scg);	

				vcTransition* ur = ps->_phi_update_req;
				vcTransition* uc = ps->_phi_update_ack;

				vcCPElementGroup* urg = transition_group_map[ur];
				vcCPElementGroup* ucg = transition_group_map[uc];
				t_graph.Add_Edge(urg,ucg);	
			}
		}		
	}

	// Add SCC arcs
	vcSystem::Info ("in CPForkblock " + this->Get_Label() + ", adding SCC arcs");
	int scc_count = 0;
	for(vector<pair<vcTransition*, vcTransition*> >:: iterator sc_iter = vcSystem::_scc_arcs.begin(),
				fsc_iter = vcSystem::_scc_arcs.end(); sc_iter != fsc_iter;
				sc_iter++)
	{
		vcTransition* tail  = (*sc_iter).first;
		vcTransition* head  = (*sc_iter).second;

		vcCPElementGroup* tg = transition_group_map[tail];
		vcCPElementGroup* hg = transition_group_map[head];

		if((tg != NULL) && (hg != NULL) && (tg != hg))
		{
			scc_count++;
			t_graph.Add_Edge (tg, hg);
		}
	}
	vcSystem::Info ("in CPForkblock " + this->Get_Label() + ", added " + IntToStr (scc_count) + " SCC arcs");


	map<void*, int>   scc_map;
	t_graph.Strongly_Connected_Components(scc_map);


	map<int, vector<vcCPElementGroup*> >  scc_member_map;
	for(map<void*,int>::iterator miter=scc_map.begin(), fmiter = scc_map.end(); miter != fmiter; miter++)
	{
		vcCPElementGroup* g = (vcCPElementGroup*) ((*miter).first);
		int scc_index = (*miter).second;

		g->Set_SCC_Index(scc_index);
		scc_member_map[scc_index].push_back(g);
	}

	for(map<int, vector<vcCPElementGroup*> >::iterator mmiter=scc_member_map.begin(), fmmiter = scc_member_map.end(); mmiter != fmmiter; mmiter++)
	{
		int I = (*mmiter).first;
		cerr << "Info: SCC " << I << endl;
		for(int J = 0, fJ = (*mmiter).second.size();  J < fJ; J++)
		{
			cerr << "\t" <<  (*mmiter).second[J]->Get_Dot_Id() << endl;
		}
	}
}

void vcControlPath::Merge_Groups(vcCPElementGroup* part, vcCPElementGroup* whole)
{

	// no join/merge fork/branch confusion.
	assert(
		(!part->_is_join || !whole->_is_merge) && 
		(!part->_is_fork || !whole->_is_branch) &&
		(!whole->_is_join || !part->_is_merge) && 
		(!whole->_is_fork || !part->_is_branch)
	     );


	assert(part->_predecessors.size() == 1);
	assert(!part->_is_delay_element);

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
			this->Connect_Groups(whole,(*iter),false, 0);

	}

	// move marked successors of part to whole.
	for(set<vcCPElementGroup*>::iterator iter = part->_marked_successors.begin(),
			fiter = part->_marked_successors.end();
			iter != fiter;
			iter++)
	{
		// remove part as a marked predecessor of iter..
		(*iter)->_marked_predecessors.erase(part);
		(*iter)->_marked_predecessor_delays.erase(part);

		// connect whole to iter..
		if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
		{
			int delay = part->Get_Marked_Successor_Delay(*iter);
			if(whole != (*iter)) // avoid self loops since they are redundant.
				this->Connect_Groups(whole,(*iter), true, delay);
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
		(*iter)->_marked_successor_delays.erase(part);

		// connect iter to whole..
		if(this->_cpelement_groups.find(*iter) != this->_cpelement_groups.end())
		{
			int delay = part->Get_Marked_Predecessor_Delay(*iter);
			if(whole != (*iter)) // avoid self loops since they are redundant.
				this->Connect_Groups((*iter), whole, true, delay);
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

void vcCPElementGroup::Generate_Successor_Vector()
{
	this->_successor_vector.clear();
	for(set<vcCPElementGroup*>::iterator iter = _successors.begin(), fiter = _successors.end();
			iter != fiter; iter++)
	{
		this->_successor_vector.push_back(*iter);
	}
}

vcCPElementGroup* vcControlPath::Make_New_Group()
{
	vcCPElementGroup* ng = new vcCPElementGroup(this);
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

void vcControlPath::Delete_Group(vcCPElementGroup* g)
{
	this->_cpelement_groups.erase(g);
	for(set<vcCPElement*>::iterator iter = g->_elements.begin(), fiter = g->_elements.end(); 
			iter != fiter; iter++)
	{
		vcCPElement* cpe = *iter;
		_cpelement_to_group_map[cpe] = NULL;
		vcSystem::Info("removed CP-element " + cpe->Get_Id() + " maybe it was dead?");
	}


	for(set<vcCPElementGroup*>::iterator siter = g->_successors.begin(), fsiter = g->_successors.end();
			siter != fsiter; siter++)
	{
		vcCPElementGroup* succ = *siter;	
		succ->_predecessors.erase(g);
		succ->_marked_predecessors.erase(g);
	}		

	for(set<vcCPElementGroup*>::iterator piter = g->_predecessors.begin(), fpiter = g->_predecessors.end();
			piter != fpiter; piter++)
	{
		vcCPElementGroup* pred = *piter;	
		pred->_successors.erase(g);
		pred->_marked_successors.erase(g);
	}		
}

void vcControlPath::Add_To_Group(vcCPElement* cpe, vcCPElementGroup* group)
{
	group->Add_Element(cpe);
	// cannot be a member of two groups!
	assert(_cpelement_to_group_map.find(cpe) == _cpelement_to_group_map.end());
	_cpelement_to_group_map[cpe] = group;
}

void vcControlPath::Connect_Groups(vcCPElementGroup* from, vcCPElementGroup* to, bool marked_flag, int delay)
{
	if(!marked_flag)
	{
		from->Add_Successor(to);
		to->Add_Predecessor(from);
	}
	else 
	{
		assert(delay >= 0);

		from->Add_Marked_Successor(to);
		from->Set_Marked_Successor_Delay(to,delay);

		to->Add_Marked_Predecessor(from);
		to->Set_Marked_Predecessor_Delay(from,delay);
	}
}


// basic sanity checks.. returns true if error.
bool vcControlPath::Check_Group_Graph_Structure()
{
	bool ret_val = false;
	int idx = 0;
	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		(*iter)->Set_Group_Index(idx);
		idx++;
	}
	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = *iter;
		for(set<vcCPElementGroup*>::iterator succ_iter = g->_successors.begin(), fsucc_iter = g->_successors.end();
				succ_iter != fsucc_iter; succ_iter++)
		{
			vcCPElementGroup* sg = *succ_iter;
			if(!sg->Has_Predecessor(g))
			{
				vcSystem::Error("malformed group graph: successor mismatch. ");
				g->Print(cerr);
				sg->Print(cerr);
				ret_val = true;
			}
		}
		for(set<vcCPElementGroup*>::iterator pred_iter = g->_predecessors.begin(), fpred_iter = g->_predecessors.end();
				pred_iter != fpred_iter; pred_iter++)
		{
			vcCPElementGroup* pg = *pred_iter;
			if(!pg->Has_Successor(g))
			{
				vcSystem::Error("malformed group graph: predecessor mismatch. ");
				g->Print(cerr);
				pg->Print(cerr);
				ret_val = true;
			}
		}
		for(set<vcCPElementGroup*>::iterator succ_iter = g->_marked_successors.begin(), fsucc_iter = g->_marked_successors.end();
				succ_iter != fsucc_iter; succ_iter++)
		{
			vcCPElementGroup* sg = *succ_iter;
			if(!sg->Has_Marked_Predecessor(g))
			{
				vcSystem::Error("malformed group graph: marked-successor mismatch. ");
				g->Print(cerr);
				sg->Print(cerr);
				ret_val = true;
			}
		}
		for(set<vcCPElementGroup*>::iterator pred_iter = g->_marked_predecessors.begin(), fpred_iter = g->_marked_predecessors.end();
				pred_iter != fpred_iter; pred_iter++)
		{
			vcCPElementGroup* pg = *pred_iter;
			if(!pg->Has_Marked_Successor(g))
			{
				vcSystem::Error("malformed group graph: marked-predecessor mismatch. ");
				g->Print(cerr);
				pg->Print(cerr);
				ret_val = true;
			}

			if(g->Has_Predecessor(pg))
			{
				vcSystem::Error("malformed group graph: predecessor is both marked and unmarked. ");
				g->Print(cerr);
				pg->Print(cerr);
				ret_val = true;
			}
		}
	}
	return(ret_val);
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

	_flip_flop_count = 0;
	_saved_flip_flop_count = 0;
	_mux2_count = 0;
	_and2_count = 0;

	string id = "control-path";

	ofile << this->Get_VHDL_Id() << ": Block -- " << id << " {" << endl;
	string prefix = this->Get_VHDL_Id() + "_elements";
	ofile << "signal " << prefix << ": BooleanArray("	
		<< _cpelement_groups.size()-1 
		<< " downto 0);" << endl;
	ofile << "-- }" << endl << "begin -- {" << endl;

	vcCPElementGroup* entry_grp = _cpelement_to_group_map[this->_entry];
	assert(entry_grp);
	entry_grp->_is_cp_entry = true;

	ofile << entry_grp->Get_VHDL_Id() 
		<< " <= " << this->Get_Start_Symbol() << ";" << endl;

	vcCPElementGroup* exit_grp = _cpelement_to_group_map[this->_exit];

	if(exit_grp != NULL)
		ofile << this->Get_Exit_Symbol() << " <= " << exit_grp->Get_VHDL_Id() << ";" << endl;
	else
	{
		vcSystem::Warning("exit symbol of control-path " + this->Get_VHDL_Id() + " not reachable, tied to false");
		ofile << "-- unreachable exit of control-path" << endl;
		ofile << this->Get_Exit_Symbol() << " <= false;" << endl;
	}


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

	this->Print_VHDL_Export_Cleanup_Optimized(ofile);
	ofile << "-- }" << endl << "end Block; -- " << id << endl;

	vcSystem::Info("resources used by CP "  + this->Get_VHDL_Id() + ": ff-count=" + IntToStr(_flip_flop_count) + " (saved " + IntToStr(_saved_flip_flop_count) +"),"
			+ " mux2-count= " + IntToStr(_mux2_count) + ","
			+ " and2-count= " + IntToStr(_and2_count));
}

void vcControlPath::Print_VHDL_Export_Cleanup_Optimized(ostream& ofile)
{
	ofile << "--  hookup: inputs to control-path " << endl;
	for(map<vcPlace*,vcTransition*>::iterator biter = _input_bindings.begin(), fbiter = _input_bindings.end();
			biter != fbiter;
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcCPElementGroup* pl_grp = _cpelement_to_group_map[pl];
		assert(pl_grp);
		string pl_id = pl_grp->Get_VHDL_Id();

		string raw_id = To_VHDL(pl->Get_Id());

		ofile << pl_id << " <= " << raw_id  << ";" << endl;
	}

	ofile << "-- hookup: output from control-path " << endl;
	for(map<vcPlace*,vcTransition*>::iterator biter = _output_bindings.begin(), fbiter = _output_bindings.end();
			biter != fbiter;
			biter++)
	{
		vcPlace* pl = (*biter).first;
		vcCPElementGroup* pl_grp = _cpelement_to_group_map[pl];
		assert(pl_grp);
		string pl_id = pl_grp->Get_VHDL_Id();

		string raw_id = To_VHDL(pl->Get_Id());

		ofile << raw_id << " <= " << pl_id  << ";" << endl;
	}
}


void vcCPSimpleLoopBlock::Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp)
{
	this->vcCPBlock::Construct_CPElement_Group_Graph_Vertices(cp);
	cp->Add_Simple_Loop_Block(this);
}

void vcCPSimpleLoopBlock::Print_VHDL_Terminator(vcControlPath* cp, ostream& ofile)
{
	vcModule* m = this->Get_Root_Parent_Module();
	string t_name;
	if(m != NULL)
		t_name = m->Get_VHDL_Id() + "_" + _terminator->Get_VHDL_Id();
	else
		t_name =  _terminator->Get_VHDL_Id();

	ofile <<  t_name << ": loop_terminator -- {" << endl;
	ofile <<  "generic map (name => \" " << t_name 
		<< "\", max_iterations_in_flight =>" <<  this->Get_Pipeline_Depth() << ") " << endl;
	ofile <<  "port map(loop_body_exit => " << _terminator->_loop_body->Get_Exit_Symbol(cp) << ","
		<< "loop_continue => " << _terminator->_loop_taken->Get_Exit_Symbol(cp) << ","
		<< "loop_terminate => " << _terminator->_loop_exit->Get_Exit_Symbol(cp) << ","
		<< "loop_back => " << _terminator->_loop_back->Get_Exit_Symbol(cp) << ","
		<< "loop_exit => " << _terminator->_exit_from_loop->Get_Exit_Symbol(cp) << ","
		<< "clk => clk, reset => reset);" << " -- } " << endl;
}

void vcCPSimpleLoopBlock::Print_Terminator_Dot_Entry(vcControlPath* cp, ostream& ofile)
{
	// TODO: repeated code... put it in a function.
	vcModule* m = this->Get_Root_Parent_Module();
	string tnode_id;
	if(m != NULL)
		tnode_id = m->Get_VHDL_Id() + "_" + _terminator->Get_VHDL_Id();
	else
		tnode_id =  _terminator->Get_VHDL_Id();

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

//
//   Identify nucleii:
//       
void vcControlPath::Identify_Nucleii(set<vcCPElementGroup*>& nucleii)
{
	cerr << "Info: finding nucleii " << endl;
	nucleii.clear();

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* g = (*iter);

		g->Generate_Successor_Vector();
		if(g->_predecessors.size() == 0)
		{
			nucleii.insert(g);
		}
		else if(g->_marked_predecessors.size() > 0)
		{
			nucleii.insert(g);
		}
		else if(g->_has_input_transition)
		{
			nucleii.insert(g);
		}
		else if(g->_is_bound_as_output_from_cp_function)
		{
			nucleii.insert(g);
		}
		else if(g->_is_delay_element)
		{
			nucleii.insert(g);
		}
		else if(g->_has_dead_transition ||
				g->_has_tied_high_transition || 
				g->_has_left_open_transition)
		{
			nucleii.insert(g);
		}
	}
}


// 2. dfs absorb from each nucleus.
void vcControlPath::Reduce_From_Nucleus(vcCPElementGroup* nucleus, 
		set<vcCPElementGroup*>& absorbed_elements,
		set<vcCPElementGroup*>& unabsorbed_elements)
{
	map<vcCPElementGroup*, int> in_visit_count_map;
	map<vcCPElementGroup*, int> out_visit_count_map;
	deque<vcCPElementGroup*> dfs_queue;
	set<vcCPElementGroup*> on_queue_set;
	dfs_queue.push_front(nucleus);

	vector<vcCPElementGroup*> reduction_vector;

	// dfs.
	while(!dfs_queue.empty())
	{
		vcCPElementGroup* top = dfs_queue.front();
		int out_visit_count = ((out_visit_count_map.find(top) == out_visit_count_map.end()) ?
				0	: out_visit_count_map[top]);

		if(out_visit_count == top->_successors.size())
		{
			dfs_queue.pop_front();
			on_queue_set.erase(top);
		}
		else
		{
			vcCPElementGroup* succ = top->_successor_vector[out_visit_count];
			out_visit_count_map[top] = (out_visit_count+1);

			if(absorbed_elements.find(succ) != absorbed_elements.end())
				continue;  // already absorbed ..
			if(on_queue_set.find(succ) != on_queue_set.end())
				continue; // cycle.

			// note that you have visited this one.
			// you will kick it out if succ is not merged.
			if(unabsorbed_elements.find(succ) == unabsorbed_elements.end())
				unabsorbed_elements.insert(succ);

			if(top->Can_Potentially_Absorb(succ))
			{
				int in_visit_count = ((in_visit_count_map.find(succ) != in_visit_count_map.end()) ?
						in_visit_count_map[succ] : 0);

				if(in_visit_count == (succ->_predecessors.size() - 1))
				{
					reduction_vector.push_back(succ);
					on_queue_set.insert(succ);
					dfs_queue.push_front(succ);
				}	

				in_visit_count_map[succ] = (in_visit_count + 1);
			}
		}
	}

	// now reduce..
	for(int idx = 0, fidx = reduction_vector.size(); idx < fidx; idx++)
	{
		vcCPElementGroup* succ = reduction_vector[idx];
		if(nucleus->Can_Potentially_Absorb(succ))
		{
			this->Merge_Groups(reduction_vector[idx], nucleus);
			unabsorbed_elements.erase(succ);
		}
	}
}

bool vcCPElementGroup::Can_Potentially_Absorb(vcCPElementGroup* g)
{
	bool ret_val = true;


	if((this->_associated_cp_function != NULL) && (g->_associated_cp_function != NULL) && 
			(this->_associated_cp_function != g->_associated_cp_function))
	{
		// if this->g, and this, g are associated with different functions,
		// then g cannot be pulled into this.
		ret_val = false;
	}
	else if(this->_is_bound_as_input_to_cp_function)
		ret_val = false;
	else if(this->_is_delay_element)
		ret_val = false;
	//else if(this->_is_bound_as_output_from_region)
	//ret_val = false;
	else if(g->_is_bound_as_output_from_cp_function)
		ret_val = false;
	else if(g->_is_delay_element)
		ret_val = false;
	else if(g->_has_input_transition)
		ret_val = false;
	else if(g->_marked_predecessors.size() > 0) // such a transition should not be pulled in because
		// it will introduce a false wait on "this".
		ret_val = false;
	else if(this->_pipeline_parent != g->_pipeline_parent)
		ret_val = false;
	else if(g->_has_dead_transition)
		ret_val = false;
	else if(g->_has_tied_high_transition)
		ret_val = false;
	else if(g->_has_left_open_transition)
		ret_val = false;
	// places and transitions should never
	// be combined. this is safe..
	else if (this->_has_place)
		ret_val = !(g->_has_transition); 
	else if(this->_has_transition)
		ret_val = !(g->_has_place);
	else
		// otherwise there is no issue..
		ret_val = true;

	return(ret_val);
}



void vcControlPath::Eliminate_Dead_Groups()
{
	int idx = 0;
	set<vcCPElementGroup*> dead_nucleii;

	for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
			fiter = _cpelement_groups.end();
			iter != fiter;
			iter++)
	{
		vcCPElementGroup* grp = (*iter);
		grp->Set_Group_Index(idx);
		grp->Generate_Successor_Vector();

		if(grp->_has_dead_transition)
			dead_nucleii.insert(grp);
		idx++;
	}

	//
	// Do a dfs starting from the dead-nucleii.
	//
	map<vcCPElementGroup*, int> in_visit_count_map;
	map<vcCPElementGroup*, int> out_visit_count_map;
	deque<vcCPElementGroup*> dfs_queue;
	set<vcCPElementGroup*> on_queue_set;
	set<vcCPElementGroup*> absorbed_elements;

	for(set<vcCPElementGroup*>::iterator siter = dead_nucleii.begin(), fsiter = dead_nucleii.end();
			siter != fsiter; siter++)
	{
		vcCPElementGroup* nucleus = *siter;
		dfs_queue.push_front(nucleus);
		on_queue_set.insert(nucleus);
		absorbed_elements.insert(nucleus);
	}


	// dfs.
	while(!dfs_queue.empty())
	{
		vcCPElementGroup* top = dfs_queue.front();
		int out_visit_count = ((out_visit_count_map.find(top) == out_visit_count_map.end()) ?
				0	: out_visit_count_map[top]);

		if(out_visit_count == top->_successors.size())
		{
			dfs_queue.pop_front();
			on_queue_set.erase(top);
		}
		else
		{
			vcCPElementGroup* succ = top->_successor_vector[out_visit_count];
			out_visit_count_map[top] = (out_visit_count+1);

			if(on_queue_set.find(succ) != on_queue_set.end())
				continue; // cycle.

			if(absorbed_elements.find(succ) != absorbed_elements.end())
				continue;  // already absorbed ..

			// input transitions are skipped.
			if(!succ->_has_input_transition)
			{
				int in_visit_count = ((in_visit_count_map.find(succ) != in_visit_count_map.end()) ?
						in_visit_count_map[succ] : 0);

				if(in_visit_count == (succ->_predecessors.size() - 1))
				{
					absorbed_elements.insert(succ);
					on_queue_set.insert(succ);
					dfs_queue.push_front(succ);
				}	

				in_visit_count_map[succ] = (in_visit_count + 1);
			}
		}
	}

	// now get rid of dead elements...
	for(set<vcCPElementGroup*>::iterator diter = absorbed_elements.begin(), fditer = absorbed_elements.end();
			diter != fditer; diter++)
	{
		vcCPElementGroup* grp = *diter;
		this->Delete_Group(*diter);
	}
}


