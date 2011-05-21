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
	  cp->Connect_Groups(pred_group,my_group);
	}
    }
  
  
  // update connections between my group and successor groups
  for(int idx = 0; idx < _successors.size(); idx++)
    {
      vcCPElement* succ = _successors[idx]->Get_Entry_Element();
      vcCPElementGroup* succ_group = cp->Get_Group(succ);
      vcCPElementGroup* my_group = cp->Get_Group(this->Get_Exit_Element());
      if(succ_group != NULL && succ_group != my_group)
	{
	  cp->Connect_Groups(my_group,succ_group);
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


bool vcCPElementGroup::Can_Absorb(vcCPElementGroup* g)
{
  bool ret_val = true;

  if(g->_has_input_transition)
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

      if(cpe->Get_Number_Of_Predecessors() > 1)
	this->_is_join = true;
      if(cpe->Get_Number_Of_Successors() > 1)
	this->_is_fork = true;
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


  ofile << " members (" << _elements.size() << ") {" << endl;
  for(set<vcCPElement*>::iterator iter = _elements.begin(), fiter = _elements.end();
      iter != fiter;
      iter++)
    {
      ofile << "\t" << (*iter)->Get_Hierarchical_Id() << endl;
    }
  ofile << "}" << endl;
}

void vcCPElementGroup::Print_VHDL(ostream& ofile)
{

  // if it has a dead transition, tie it to false.
  if(this->_has_dead_transition)
    {
      ofile << "cp_elements(" << this->Get_Group_Index() << ") <= false;" << endl;
      return;
    }


  if(!(this->_is_join || this->_is_fork))
    {
      if(this->_has_input_transition)
	{
	  ofile << "cp_elements(" << this->Get_Group_Index() << ") <= ";
	  ofile <<  _input_transition->Get_DP_To_CP_Symbol() << ";" << endl;
	}
      else
	{
	  if(_predecessors.size() > 1)
	    {
	      ofile << "cp_elements(" << this->Get_Group_Index() << ") <= OrReduce(";	      // write the symbol as an OR of all incoming symbols.

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
		  
		  ofile << "cp_elements(" << (*iter)->Get_Group_Index() << ")";
		}
	      ofile << ");" << endl;
	    }
	  else if(_predecessors.size() == 1)
	    {
	      ofile << "cp_elements(" << this->Get_Group_Index() << ") <= ";	      
	      ofile << "cp_elements(" << (*(_predecessors.begin()))->Get_Group_Index() << ");" << endl;
	    }
	  else if(_predecessors.size() == 0)
	    {
	      if(!this->_is_cp_entry)
		{
		  vcSystem::Warning("CP element " + Int64ToStr(this->Get_Group_Index()) + " has no predecessors.. tie to false");
		  ofile << "cp_elements(" << this->Get_Group_Index() << ") <= false; " << endl;	      		  
		}
	    }
	}
    }
  else
    {
      // instantiate join element.
      if(_predecessors.size() > 1)
	{
	  ofile << "cpelement_group_" << this->Get_Group_Index() << " : Block -- { " << endl;
	  ofile << "signal predecessors: BooleanArray(" 
		<< _predecessors.size()-1 << " downto 0);" << endl;
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
	      
	      ofile << "cp_elements(" << (*iter)->Get_Group_Index() << ")";
	      
	    }
	  ofile << ");" << endl;

	  if(this->_input_transition != NULL)
	    {
	      ofile << "jI: join_with_input -- {" << endl
		    << "port map( -- {"
		    << "preds => predecessors," << endl
		    << "symbol_in => " << this->_input_transition->Get_DP_To_CP_Symbol() << "," << endl
		    << "symbol_out => cp_elements(" << this->Get_Group_Index() << ")," << endl
		    << "clk => clk," << endl
		    << "reset => reset); -- }}" << endl;
	    }
	  else
	    {
	      ofile << "jNoI: join -- {" << endl
		    << "port map( -- {"
		    << "preds => predecessors," << endl
		    << "symbol_out => cp_elements(" << this->Get_Group_Index() << ")," << endl
		    << "clk => clk," << endl
		    << "reset => reset); -- }}" << endl;
	    }
	  
	  ofile << "-- }" << endl << "end Block;" << endl;
	}
      else if(_predecessors.size() == 1)
	{
	  if(this->_has_input_transition)
	    {
	      ofile << "cp_elements(" << this->Get_Group_Index() << ") <= ";
	      ofile <<  _input_transition->Get_DP_To_CP_Symbol() << ";" << endl;
	    }
	  else
	    {
	      ofile << "cp_elements(" << this->Get_Group_Index() << ") <= ";	      
	      ofile << "cp_elements(" << (*(_predecessors.begin()))->Get_Group_Index() << ");" << endl;
	    }
	}
    }

  
  
  for(int idx = 0, fidx = _output_transitions.size(); idx < fidx; idx++)
    {
      ofile << _output_transitions[idx]->Get_CP_To_DP_Symbol() << " <= cp_elements("
	    << this->Get_Group_Index()
	    << ");" << endl;
    }
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
	this->Connect_Groups(whole,(*iter));
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

void vcControlPath::Connect_Groups(vcCPElementGroup* from, vcCPElementGroup* to)
{
  from->Add_Successor(to);
  to->Add_Predecessor(from);
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

  _cpelement_to_group_map[this->_entry]->_is_cp_entry = true;

  ofile << "cp_elements(" 
	<< _cpelement_to_group_map[this->_entry]->Get_Group_Index()
	<< ") <= true when start = '1' else false;" << endl;
  ofile << "fin <= '1' when cp_elements(" 
	<< _cpelement_to_group_map[this->_exit]->Get_Group_Index()
	<< ") else '0';" << endl;

  for(set<vcCPElementGroup*,vcRoot_Compare>::iterator iter = _cpelement_groups.begin(), 
	fiter = _cpelement_groups.end();
      iter != fiter;
      iter++)
    {
      (*iter)->Print_VHDL(ofile);
    }

  ofile << "-- }" << endl << "end Block; -- " << id << endl;
}
