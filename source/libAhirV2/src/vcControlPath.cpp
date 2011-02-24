#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcControlPath.hpp>
#include <vcSystem.hpp>

int vcControlPath::_free_index = 0;

vcCompatibilityLabel::vcCompatibilityLabel(vcControlPath* cp, string id): vcCPElement(cp,id)
{
  this->_labeled_in_arc.first = NULL;
}

void vcCompatibilityLabel::Add_In_Arc(vcCompatibilityLabel* u, pair<vcTransition*, int>& arc)
{
  assert(this->_labeled_in_arc.first == NULL);
  this->_labeled_in_arc.first = u;
  this->_labeled_in_arc.second = arc;
}

void vcCompatibilityLabel::Add_In_Arc(vcCompatibilityLabel* u)
{
  this->_unlabeled_in_arcs.insert(u);
}

vcCompatibilityLabel* vcCompatibilityLabel::Reduce()
{
  vcCompatibilityLabel* ret_label = this;
  bool change_flag = true;;

  while(change_flag)
    {
      
      change_flag = false;
      if(this->_unlabeled_in_arcs.size() > 0)
	assert(this->_labeled_in_arc.first == NULL);
      if(this->_labeled_in_arc.first != NULL)
	assert(this->_unlabeled_in_arcs.size() ==  0);
      
      if(this->_unlabeled_in_arcs.size() == 0)
	return(ret_label);
      
      if(this->_unlabeled_in_arcs.size() == 1)
	{
	  {// just one labeled in arc.
	    ret_label = (*(this->_unlabeled_in_arcs.begin()));
	  }
	  return(ret_label);
	}
      
      // more than one incoming unlabeled edge
      
      vector<vcCompatibilityLabel* > erase_vec;
      vector<vcCompatibilityLabel* > insert_vec;
      
      
      // First, eliminate unlabeled paths of length 2.
      for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
	  iter != this->_unlabeled_in_arcs.end();
	  iter++)
	{
	  vcCompatibilityLabel* u = *(iter);
	  if(u->_unlabeled_in_arcs.size() > 0)
	    {
	      erase_vec.push_back(u);
	      for(set<vcCompatibilityLabel*>::iterator miter = u->_unlabeled_in_arcs.begin();
		  miter != u->_unlabeled_in_arcs.end();
		  miter++)
		{
		  insert_vec.push_back((*miter));
		}
	    }
	}
      // remove all elements in erase set from unlabeled_in_arcs
      for(int idx = 0; idx < erase_vec.size(); idx++)
	this->_unlabeled_in_arcs.erase(erase_vec[idx]);
      
      // add all elements in insert set to unlabeled_in_arcs
      for(int idx = 0; idx < insert_vec.size(); idx++)
	this->_unlabeled_in_arcs.insert(insert_vec[idx]);
      
      
      set<vcCompatibilityLabel*> insert_set;
      
      // OK, now you have multiple incoming unlabeled arcs..
      // try to reduce.
      map<vcCompatibilityLabel*, map<vcTransition*,int> > reduce_map;
      for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
	  iter != this->_unlabeled_in_arcs.end();
	  iter++)
	{
	  vcCompatibilityLabel* u = (*iter);
	  assert(u->_unlabeled_in_arcs.size() == 0);
	  
	  vcCompatibilityLabel* v = u->_labeled_in_arc.first;
	  if(v != NULL)
	    {
	      
	      vcTransition* t = u->_labeled_in_arc.second.first;
	      
	      if(reduce_map[v].find(t) == reduce_map[v].end())
		(reduce_map[v])[t] = 1;
	      else
		((reduce_map[v])[t])++;
	      
	      if((reduce_map[v])[t] == t->Get_Number_Of_Successors())
		{
		  insert_set.insert(v);
		}
	    }
	}
      
      // based on the insert set, compute the reduce set.
      set<vcCompatibilityLabel*> erase_set;
      for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
	  iter != this->_unlabeled_in_arcs.end();
	  iter++)
	{
	  vcCompatibilityLabel* u = (*iter);
	  assert(u->_unlabeled_in_arcs.size() == 0);
	  
	  vcCompatibilityLabel* v = u->_labeled_in_arc.first;
	  if(v != NULL)
	    {
	      if(insert_set.find(v) != insert_set.end())
		{
		  erase_set.insert(u);
		}
	    }
	}
      
      // now remove elements from the erase set and
      // add elements from the insert set
      for(set<vcCompatibilityLabel*>::iterator iter = erase_set.begin();
	  iter != erase_set.end();
	  iter++)
	{
	  this->_unlabeled_in_arcs.erase((*iter));
	  change_flag = true;
	}
      
      for(set<vcCompatibilityLabel*>::iterator iter = insert_set.begin();
	  iter != insert_set.end();
	  iter++)
	{
	  this->_unlabeled_in_arcs.insert((*iter));
	  change_flag = true;
	}
      
      // thats it.  you have done one pass of the  reduction.. one last step remains..
      // after the previous reduction, you may be left with a unique
      // unlabeled in arc... In this case, break out of the
      // loop..
      if(this->_unlabeled_in_arcs.size() == 1)
	{
	  ret_label = *(this->_unlabeled_in_arcs.begin());
	  break;
	}
    }

  return(ret_label);
}

bool vcCompatibilityLabel::Is_Compatible(vcCompatibilityLabel* other)
{
  if(this == other)
    return true;
  else if(((vcControlPath*)(this->_parent))->Are_Compatible(this,other))
    return true;
  else
    return false;
}


bool operator==(vector<vcCompatibilityLabel*>& u, vector<vcCompatibilityLabel*>& v)
{
  bool ret_flag = true;
  for(int idx = 0; idx < u.size(); idx++)
    {
      for(int jdx = 0; idx < v.size(); jdx++)
	{
	  if(!(u[idx]->Is_Compatible(v[idx])))
	    {
	      ret_flag = false;
	      break;
	    }
	}
    }
  return(ret_flag);
}

bool operator==(set<vcCompatibilityLabel*>& u, set<vcCompatibilityLabel*>& v)
{
  bool ret_flag = true;
  for(set<vcCompatibilityLabel*>::iterator uiter = u.begin();
      uiter != u.end();
      uiter++)
    {
      for(set<vcCompatibilityLabel*>::iterator viter = v.begin();
	  viter != v.end();
	  viter++)
	{
	  if(!(*uiter)->Is_Compatible((*viter)))
	    {
	      ret_flag = false;
	      break;
	    }
	}
    }
  return(ret_flag);
}

void vcCompatibilityLabel::Print(ostream& ofile)
{
  ofile << "label " << this->Get_Id() << " : ";
  if(this->_labeled_in_arc.first != NULL)
    {
      ofile << "\t labeled predecessor (" << this->_labeled_in_arc.first->Get_Id() << ", " 
	    << this->_labeled_in_arc.second.first->Get_Hierarchical_Id() << ", " 
	    << this->_labeled_in_arc.second.second << ")" << endl;
    }
  else if(this->_unlabeled_in_arcs.size() > 0)
    {
      ofile << "\t unlabeled predecessor(s) ";
      for(set<vcCompatibilityLabel*>::iterator iter = this->_unlabeled_in_arcs.begin();
	  iter != this->_unlabeled_in_arcs.end();
	  iter++)
	{
	  ofile << (*iter)->Get_Id() << " ";
	}
      ofile << endl;
    }
  else
    ofile << endl;
}

vcCPElement::vcCPElement(vcCPElement* parent, string id):vcRoot(id)
{
  this->_index = vcControlPath::_free_index;
  vcControlPath::_free_index++;

  this->_compatibility_label = NULL;
  this->_parent = parent;
}
void vcCPElement::Get_Hierarchical_Ref(vector<string>& ref_vec)
{
  if(this->_parent != NULL)
    this->_parent->Get_Hierarchical_Ref(ref_vec);
  ref_vec.push_back(this->Get_Id());
}
string vcCPElement::Get_Hierarchical_Id()
{
  string ret_string;
  vector<string> ref_vec;
  this->Get_Hierarchical_Ref(ref_vec);
  for(int idx = 0; idx < ref_vec.size(); idx++)
    {
      ret_string += ref_vec[idx];
      if((idx+1) < ref_vec.size())
	ret_string += vcLexerKeywords[__SLASH];
    }
  return(ret_string);
}

void vcCPElement::Print_Successors(ostream& ofile)
{
  ofile << this->Get_Hierarchical_Id() << " (label =  " << this->Get_Compatibility_Label()->Get_Id() << ") -> ";
  for(int idx =0; idx < this->_successors.size(); idx++)
    {
      ofile << this->_successors[idx]->Get_Hierarchical_Id() << " ";
    }
  ofile << endl;
}
vcTransition::vcTransition(vcCPElement* parent, string id):vcCPElement(parent, id)
{
  _is_input = false;
  _is_output = false;
}



void vcTransition::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__TRANSITION] << " " << this->Get_Label() << endl;
}

#define MAX(x,y) (x > y ? x : y)

//
// slightly complicated but not too bad.
// you will need to instantiate places if the transition is a join..
//
void vcTransition::Print_VHDL(ostream& ofile)
{

  // every transition has at least one predecessor (entry of control-path has no
  // explicit predecessor, but does have an implicit one.
  if(this->Get_Number_Of_Predecessors() > 1)
    {

      ofile << this->Get_VHDL_Id() << "_block : Block -- non-trivial join transition " << this->Get_Hierarchical_Id() << " {" <<  endl;

      ofile << "signal " <<  this->Get_VHDL_Id() << "_predecessors: BooleanArray(" 
	    << this->Get_Number_Of_Predecessors()-1 << " downto 0);" << endl;

      for(int idx = 0; idx < this->Get_Number_Of_Predecessors(); idx++)
	{
	  ofile << "signal " <<  this->Get_VHDL_Id() << "_p" << idx << "_pred: BooleanArray(0 downto 0);" << endl;
	  ofile << "signal " <<  this->Get_VHDL_Id() << "_p" << idx << "_succ: BooleanArray(0 downto 0);" << endl;
	}
      ofile << "-- }" << endl << "begin -- {" << endl;

      for(int idx = 0; idx < this->Get_Number_Of_Predecessors(); idx++)
	{
	  vcCPElement* pred = this->Get_Predecessors()[idx];
	  ofile << this->Get_VHDL_Id() << "_" << idx << "_place: Place -- {" << endl
		<< "generic map(marking => false)" << endl
		<< "port map( -- {";
	  // predecessors
	  ofile << this->Get_VHDL_Id() << "_p" << idx << "_pred, ";
	  ofile << this->Get_VHDL_Id() << "_p" << idx << "_succ, ";
	  ofile <<  this->Get_VHDL_Id() << "_predecessors(" << idx << "), ";
	  ofile << "clk, reset" << "-- }" << endl << "); -- } " << endl;

	  ofile << this->Get_VHDL_Id() << "_p" << idx << "_succ(0) <=  " << this->Get_Exit_Symbol() << ";" << endl;
	  ofile << this->Get_VHDL_Id() << "_p" << idx << "_pred(0) <=  " << pred->Get_Exit_Symbol() << ";" << endl;
	}
      
      ofile << this->Get_Exit_Symbol() << " <= AndReduce(" << this->Get_VHDL_Id() << "_predecessors)";
      if(this->Get_Is_Input())
	ofile << " and " << this->Get_DP_To_CP_Symbol();
      ofile << "; " << endl;
    }
  else if(this->Get_Number_Of_Predecessors() == 1)
    {
      // if only one predecessor, then direct connection from predecessors(0).
      if(!this->_is_input)
	{
	  vcCPElement* pred = this->Get_Predecessors()[0];
	  ofile <<  this->Get_Exit_Symbol() << " <= " << pred->Get_Exit_Symbol() << "; -- transition " << this->Get_Hierarchical_Id() << endl;
	}
      else
	{
	  ofile <<  this->Get_Exit_Symbol() << " <= " << this->Get_DP_To_CP_Symbol() << "; -- transition " << this->Get_Hierarchical_Id() << endl;
	}
    }
  else
    {
      ofile <<  this->Get_Exit_Symbol() << "  <= " << this->Get_Parent()->Get_Start_Symbol() << "; -- transition " << this->Get_Hierarchical_Id() << endl;
    }

  if(this->Get_Is_Output())
    ofile << this->Get_CP_To_DP_Symbol() << " <= " << this->Get_Exit_Symbol() << "; -- link to DP" << endl;
  
  if(this->Get_Number_Of_Predecessors() > 1) // block was used...
    ofile << "-- }" << endl << "end Block; -- non-trivial join transition " << this->Get_Hierarchical_Id() << endl;

}


string vcTransition::Get_DP_To_CP_Symbol()
{
  return(To_VHDL(this->Get_Hierarchical_Id()) + "_dp_to_cp");
}
string vcTransition::Get_CP_To_DP_Symbol()
{
  return(To_VHDL(this->Get_Hierarchical_Id()) + "_cp_to_dp");
}
vcPlace::vcPlace(vcCPElement* parent, string id, unsigned int init_marking):vcCPElement(parent, id)
{
  this->_initial_marking = init_marking;
}

void vcPlace::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PLACE] << " " << this->Get_Label() << endl;
}

void vcPlace::Print_VHDL(ostream& ofile)
{
  // 
  // the place is simply optimized away to a direct connection..
  //
  ofile << this->Get_Exit_Symbol() <<  "  <=  ";
  for(int idx = 0; idx < this->Get_Number_Of_Predecessors(); idx++)
    {
      if(idx > 0)
	ofile << " or ";
      
      ofile <<  this->Get_Predecessors()[idx]->Get_Exit_Symbol();
    }
  ofile << "; -- place " << this->Get_Hierarchical_Id() << " (optimized away) " << endl;
}

vcCPBlock::vcCPBlock(vcCPBlock* parent, string id): vcCPElement((vcCPElement*)parent, id)
{
  _entry = new vcTransition(this,vcLexerKeywords[__ENTRY]);
  _exit = new vcTransition(this,vcLexerKeywords[__EXIT]);
}

void vcCPBlock::Add_CPElement(vcCPElement* cpe)
{
  assert(this->_element_map.find(cpe->Get_Id()) == this->_element_map.end());

  this->_element_map[cpe->Get_Id()] = cpe;
  this->_elements.push_back(cpe);
}

vcCPElement* vcCPBlock::Find_CPElement(string cname)
{
  vcCPElement* ret_cpe = NULL;
  if(cname == vcLexerKeywords[__ENTRY])
    ret_cpe = (vcCPElement*) this->_entry;
  else if(cname == vcLexerKeywords[__EXIT])
    ret_cpe = (vcCPElement*) this->_exit;
  else if(this->_element_map.find(cname) != this->_element_map.end())
    ret_cpe = ((*(this->_element_map.find(cname))).second);
  return(ret_cpe);
}



void vcCPBlock::Print_VHDL_Start_Symbol_Assignment(ostream& ofile)
{
  ofile << this->Get_Start_Symbol() << " <= " << this->Get_Predecessors()[0]->Get_Exit_Symbol() << "; -- control passed to block" << endl;
}

void vcCPBlock::Print_VHDL_Exit_Symbol_Assignment(ostream& ofile)
{
  ofile << this->Get_Exit_Symbol() << " <= " << this->_exit->Get_Exit_Symbol() << "; -- control passed from block " << endl;
}

void vcCPBlock::Print_VHDL(ostream& ofile)
{
  
  // Hack alert!
  string id = (this->Get_Hierarchical_Id() == "" ? "control-path" : this->Get_Hierarchical_Id());

  // declare all exit flags.
  ofile << this->Get_VHDL_Id() << ": Block -- " << id << " {" << endl;
  ofile << "signal " << this->Get_Start_Symbol() << ": Boolean;" << endl;
  ofile << "signal " << this->_entry->Get_Exit_Symbol() << ": Boolean;" << endl;
  ofile << "signal " << this->_exit->Get_Exit_Symbol() << ": Boolean;" << endl;
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      ofile << "signal " << _elements[idx]->Get_Exit_Symbol() << " : Boolean;" << endl;
    }
  ofile << "-- }" << endl << "begin -- {" << endl;
  this->Print_VHDL_Start_Symbol_Assignment(ofile);

  this->_entry->Print_VHDL(ofile);
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      this->_elements[idx]->Print_VHDL(ofile);
    }
  this->_exit->Print_VHDL(ofile);
  this->Print_VHDL_Exit_Symbol_Assignment(ofile);

  ofile << "-- }" << endl << "end Block; -- " << id << endl;
}

void vcCPBlock::Print_Elements(ostream& ofile)
{
  for(int idx = 0; idx < this->_elements.size(); idx++)
    this->_elements[idx]->Print(ofile);
}

bool vcCPBlock::Check_Structure() 
{ 
  bool ret_flag = true;
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      ret_flag = (ret_flag && this->_elements[idx]->Check_Structure());
      if(!ret_flag)
	break;
    }
  return(ret_flag);
}


void vcCPBlock::Print_Structure(ostream& ofile)
{
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      this->_elements[idx]->Print_Structure(ofile);
    }
}


void vcCPBlock::BFS_Order(bool reverse_flag, vcCPElement* start_element, int& num_visited, vector<vcCPElement*>& bfs_ordered_elements)
{
  set<vcCPElement*> visited_set;
  deque<vcCPElement*> bfs_queue;
  set<vcCPElement*> on_queue_set;
  bfs_queue.push_back(start_element);
  on_queue_set.insert(start_element);
  num_visited = 0;

  while(!bfs_queue.empty())
    {
      vcCPElement* top = (bfs_queue.front());

      bfs_queue.pop_front();
      on_queue_set.erase(top);

      visited_set.insert(top);
      bfs_ordered_elements.push_back(top);

      num_visited++;

      vector<vcCPElement*>& adj = (reverse_flag ? top->Get_Predecessors() : top->Get_Successors());
      for(int idx = 0; idx < adj.size(); idx++)
	{
	  vcCPElement* w = adj[idx];
	  if((on_queue_set.find(w) == on_queue_set.end()) && (visited_set.find(w) == visited_set.end()))
	    {// push into queue if not already present in the queue and if not already popped from front..
	      bfs_queue.push_back(w);
	      on_queue_set.insert(w);
	    }
	}
    }
}


void vcCPBlock::DFS_Order(bool reverse_flag, vcCPElement* start_element, bool& cycle_flag, int& num_visited, vector<vcCPElement*>& dfs_ordered_elements)
{
  set<vcCPElement*> visited_set;
  set<vcCPElement*> on_queue_set;
  deque<vcCPElement*> dfs_queue;
  
  dfs_queue.push_front(start_element);
  on_queue_set.insert(start_element);

  num_visited = 1;
  visited_set.insert(start_element);
  dfs_ordered_elements.push_back(start_element);

  while(!dfs_queue.empty())
    {
      vcCPElement* top = dfs_queue.front();
      vector<vcCPElement*>& adj = (reverse_flag ? top->Get_Predecessors() : top->Get_Successors());
      bool all_neighbours_visited = true;
      for(int idx = 0; idx < adj.size(); idx++)
	{
	  vcCPElement* w = adj[idx];
	  if(on_queue_set.find(w) != on_queue_set.end())
	    {
	      cycle_flag = true;
	    }
	  else if(visited_set.find(w) == visited_set.end())
	    {
	      num_visited++;

	      dfs_ordered_elements.push_back(w);
	      visited_set.insert(w);
	      dfs_queue.push_front(w);
	      on_queue_set.insert(w);
	      all_neighbours_visited = false;

	      break;
	    }
	}

      if(all_neighbours_visited)
	{
	  dfs_queue.pop_front();
	  on_queue_set.erase(top);
	}
    }
}



void vcCPBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp) {assert(0);}
void vcCPBlock::Update_Predecessor_Successor_Links() 
{
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      this->_elements[idx]->Update_Predecessor_Successor_Links();
    }
}

vcCPSeriesBlock::vcCPSeriesBlock(vcCPBlock* p, string id):vcCPBlock(p, id)
{
}


void vcCPSeriesBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__SERIESBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);
  ofile << "\n// end series-block " << this->Get_Id() << endl << "}" << endl;
}


void vcCPSeriesBlock::Print_Structure(ostream& ofile)
{
  ofile << "Structure of Series Region " << this->Get_Hierarchical_Id() << " {" << endl;
  this->_entry->Print_Successors(ofile);
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      this->_elements[idx]->Print_Successors(ofile);
    }
  this->_exit->Print_Successors(ofile); 
  ofile << "}";

  this->vcCPBlock::Print_Structure(ofile);
}


void vcCPSeriesBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp)
{
  this->Set_Compatibility_Label(in_label);

  this->_entry->Set_Compatibility_Label(in_label);
  for(int idx = 0; idx < this->_elements.size(); idx++)
    this->_elements[idx]->Compute_Compatibility_Labels(in_label,cp);
  this->_exit->Set_Compatibility_Label(in_label);
}

void vcCPSeriesBlock::Update_Predecessor_Successor_Links()
{

  if(this->_elements.size() > 0)
    {
      this->_entry->Add_Successor(this->_elements.front());
      this->_elements.front()->Add_Predecessor(this->_entry);
      for(int idx = 0; idx < this->_elements.size(); idx++)
	{
	  if(idx > 0)
	    {
	      this->_elements[idx]->Add_Predecessor(this->_elements[idx-1]);
	    }
	  if(idx+1 < this->_elements.size())
	    {
	      this->_elements[idx]->Add_Successor(this->_elements[idx+1]);
	    }
	}
      this->_elements.back()->Add_Successor(this->_exit);
      this->_exit->Add_Predecessor(this->_elements.back());
    }
  else
    {
      this->_entry->Add_Successor(this->_exit);
      this->_exit->Add_Predecessor(this->_entry);
    }

  this->vcCPBlock::Update_Predecessor_Successor_Links();
}

vcCPParallelBlock::vcCPParallelBlock(vcCPBlock* p, string id):vcCPBlock(p, id)
{

}


void vcCPParallelBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PARALLELBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);
  ofile << "\n// end  parallel-block " << this->Get_Id() << endl << "}" << endl;
}


void vcCPParallelBlock::Print_Structure(ostream& ofile)
{
  string id = (this->Get_Hierarchical_Id());
  if(id == "")
    id = this->Get_Id();

  ofile << "Structure of  Region " << id << " {" << endl;
  this->_entry->Print_Successors(ofile);
  for(int idx = 0; idx < this->_elements.size(); idx++)
    {
      this->_elements[idx]->Print_Successors(ofile);
    }
  this->_exit->Print_Successors(ofile);
  ofile << "}" << endl;

  this->vcCPBlock::Print_Structure(ofile);

}



void vcCPParallelBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* cp)
{
  this->Set_Compatibility_Label(in_label);
  this->_entry->Set_Compatibility_Label(in_label);

  if(this->_elements.size() > 1)
    {
      for(int idx = 0; idx < this->_elements.size(); idx++)
	{
	  string hid = this->Get_Hierarchical_Id();
	  if(hid == "")
	    hid = this->Get_Id();

	  string id = cp->Get_Id() + "/" +  hid + "[" + IntToStr(idx) + "]";
	  vcCompatibilityLabel* nl = cp->Make_Compatibility_Label(id);

	  pair<vcTransition*,int> p(this->_entry,idx);
	  nl->Add_In_Arc(in_label,p);
	  this->_elements[idx]->Compute_Compatibility_Labels(nl,cp);
	}
    }
  else if(this->_elements.size() == 1)
    this->_elements[0]->Compute_Compatibility_Labels(in_label,cp);

  this->_exit->Set_Compatibility_Label(in_label);
}
void vcCPParallelBlock::Update_Predecessor_Successor_Links()
{
  if(!this->_elements.empty())
    {
      for(int idx = 0; idx < this->_elements.size(); idx++)
	{
	  this->_entry->Add_Successor(this->_elements[idx]);
	  this->_elements[idx]->Add_Predecessor(this->_entry);

	  this->_exit->Add_Predecessor(this->_elements[idx]);
	  this->_elements[idx]->Add_Successor(this->_exit);
	}
    }
  else
    {
      this->_entry->Add_Successor(this->_exit);
      this->_exit->Add_Predecessor(this->_entry);
    }
  this->vcCPBlock::Update_Predecessor_Successor_Links();
}

vcCPBranchBlock::vcCPBranchBlock(vcCPBlock* p, string id):vcCPSeriesBlock(p, id)
{
}

void vcCPBranchBlock::Add_Branch_Point(string bp_name, vector<string>& choice_cpe_vec)
{
  vcCPElement* bp = this->Find_CPElement(bp_name);
  assert(bp != NULL && bp->Is("vcPlace"));

  for(int idx = 0; idx < choice_cpe_vec.size(); idx++)
    {
      vcCPElement* bre = this->Find_CPElement(choice_cpe_vec[idx]);
      assert(bre != NULL);
      this->_branch_map[((vcPlace*)bp)].push_back(bre);
    }
}

void vcCPBranchBlock::Add_Merge_Point(string merge_place, string merge_region)
{
  vcCPElement* mp = this->Find_CPElement(merge_place);
  vcCPElement* mr = this->Find_CPElement(merge_region);

  assert(mp != NULL && mp->Is("vcPlace"));
  assert(mr != NULL);
  this->_merge_map[(vcPlace*)mp].push_back(mr);
}

void vcCPBranchBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__BRANCHBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);

  // now print the branch and merge points.
  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _branch_map.begin();
      iter != _branch_map.end();
      iter++)
    {
      ofile << (*iter).first->Get_Id() << " " << 
	vcLexerKeywords[__BRANCH] << " (";
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << ")" << endl;
    }

  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _merge_map.begin();
      iter != _merge_map.end();
      iter++)
    {
      ofile << (*iter).first->Get_Id() << " " << vcLexerKeywords[__MERGE] << " (";
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << ")" << endl;
    }
  ofile << "\n// end branch-block " << this->Get_Id() << endl << "}" << endl;
}


bool vcCPBranchBlock::Check_Structure()
{

  bool ret_flag = this->vcCPBlock::Check_Structure();
  if(ret_flag)
    {

      vector<vcCPElement*> reachable_elements;
      bool cycle_flag = false;
      int num_visited = 0;

      this->BFS_Order(false,this->_entry, num_visited, reachable_elements);
      if(num_visited != (this->_elements.size() + 2))
	{
	  ret_flag = false;
	  vcSystem::Error("all elements not reachable from entry in region " + this->Get_Hierarchical_Id());
	}

      reachable_elements.clear();
      num_visited = 0;
      cycle_flag = false;
      this->BFS_Order(true, this->_exit, num_visited, reachable_elements);
      if(num_visited != (this->_elements.size() + 2))
	{
	  ret_flag = false;
	  vcSystem::Error("exit not reachable from every element in region " + this->Get_Hierarchical_Id());
	}
    }

  return(ret_flag);
}

void vcCPBranchBlock::Update_Predecessor_Successor_Links()
{
  // branches
  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = this->_branch_map.begin();
      iter != this->_branch_map.end();
      iter++)
    {
      vcPlace* p = (*iter).first;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  vcCPElement* e = (*iter).second[idx];
	  e->Add_Predecessor(p);
	  p->Add_Successor(e);
	}
    }

  // merges
  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = this->_merge_map.begin();
      iter != this->_merge_map.end();
      iter++)
    {
      vcPlace* p = (*iter).first;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  vcCPElement* e = (*iter).second[idx];
	  e->Add_Successor(p);
	  p->Add_Predecessor(e);
	}
    }

  this->vcCPBlock::Update_Predecessor_Successor_Links();
}

vcCPForkBlock::vcCPForkBlock(vcCPBlock* p, string id):vcCPParallelBlock(p, id)
{
}


void vcCPForkBlock::Add_Fork_Point(string& fork_name, vector<string>& fork_cpe_vec)
{
  vcCPElement* fp = this->Find_CPElement(fork_name);
  assert(fp != NULL && fp->Is("vcTransition"));

  for(int idx = 0; idx < fork_cpe_vec.size(); idx++)
    {
      vcCPElement* fre = this->Find_CPElement(fork_cpe_vec[idx]);
      assert(fre != NULL);
      this->_fork_map[((vcTransition*)fp)].push_back(fre);
      this->_forked_elements.insert(fre);
    }
}

void vcCPForkBlock::Add_Join_Point(string& join_name, vector<string>& join_cpe_vec)
{
  vcCPElement* jp = this->Find_CPElement(join_name);
  assert(jp != NULL && jp->Is("vcTransition"));

  for(int idx = 0; idx < join_cpe_vec.size(); idx++)
    {
      vcCPElement* jre = this->Find_CPElement(join_cpe_vec[idx]);
      assert(jre != NULL);
      this->_join_map[((vcTransition*)jp)].push_back(jre);
      this->_joined_elements.insert(jre);
    }
}
void vcCPForkBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__FORKBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);


  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _fork_map.begin();
      iter != _fork_map.end();
      iter++)
    {
      ofile << (*iter).first->Get_Id() << " " << 
	vcLexerKeywords[__FORK] << " (" ;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << ")" << endl;
    }


  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _join_map.begin();
      iter != _join_map.end();
      iter++)
    {
      ofile <<  (*iter).first->Get_Id() << " " << 
	vcLexerKeywords[__JOIN] << " (" ;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << ")" << endl;
    }
  ofile << "\n// end fork-block " << this->Get_Id() << endl << "}" << endl;
}

bool vcCPForkBlock::Check_Structure()
{
  bool ret_flag = this->vcCPBlock::Check_Structure();
  if(ret_flag)
    {
      vector<vcCPElement*> reachable_elements;
      bool cycle_flag = false;
      int num_visited = 0;

      this->DFS_Order(false, this->_entry, cycle_flag, num_visited, reachable_elements);
      if(num_visited != (this->_elements.size() + 2))
	{
	  ret_flag = false;
	  vcSystem::Error("all elements not reachable from entry in region " + this->Get_Hierarchical_Id());
	}

      if(cycle_flag)
	{
	  vcSystem::Error("Cycles present in fork region " + this->Get_Hierarchical_Id());
	  ret_flag = false;
	}

      reachable_elements.clear();
      num_visited = 0;
      cycle_flag = false;
      this->BFS_Order(true, this->_exit, num_visited, reachable_elements);
      if(num_visited != (this->_elements.size() + 2))
	{
	  ret_flag = false;
	  vcSystem::Error("exit not reachable from every element in region " + this->Get_Hierarchical_Id());
	}
    }

  return(ret_flag);
}

void vcCPForkBlock::Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath*  cp)
{
  // inherited label is passed down from _entry.
  // create additional labels whenever there is 
  // a fork.  Whenever there is a join, do 
  // a reduce.
  this->Set_Compatibility_Label(in_label);

  vector<vcCPElement*> reachable_elements;
  int num_visited = 0;
  
  this->BFS_Order(false, this->_entry, num_visited, reachable_elements);
  this->_entry->Set_Compatibility_Label(in_label);

  for(int idx = 0; idx < reachable_elements.size(); idx++)
    {
      if(reachable_elements[idx]->Is("vcTransition"))
	{
	  vcTransition* t = (vcTransition*) reachable_elements[idx];

	  map<vcTransition*, vector<vcCPElement*>, vcRoot_Compare>::iterator join_iter = this->_join_map.find(t);
	  if(join_iter != this->_join_map.end())
	    {

	      if((*join_iter).second.size() > 1)
		{
		  string id = cp->Get_Id()  + "/" + t->Get_Hierarchical_Id();
		  vcCompatibilityLabel* nl = cp->Make_Compatibility_Label(id);

		  // multiple incoming..
		  for(int idx = 0; idx < (*join_iter).second.size(); idx++)
		    {
		      nl->Add_In_Arc((*join_iter).second[idx]->Get_Compatibility_Label());
		    }
		  
		  vcCompatibilityLabel* reduced_label = nl->Reduce();
		  if(reduced_label != nl)
		    {
		      cp->Delete_Compatibility_Label(nl);
		    }

		  t->Compute_Compatibility_Labels(reduced_label,cp);
		}
	      else
		{// trivial join, inherit the label of the predecessor
		  t->Compute_Compatibility_Labels((*join_iter).second.front()->Get_Compatibility_Label(),cp);
		}
	    }

	  // is it a fork?
	  map<vcTransition*, vector<vcCPElement*>, vcRoot_Compare>::iterator fork_iter = this->_fork_map.find(t);
	  if(fork_iter != this->_fork_map.end())
	    {
	      // ok, t was a fork
	      if((*fork_iter).second.size() > 1)
		{
		  // t has multiple successors
		  for(int idx = 0; idx < (*fork_iter).second.size(); idx++)
		    {

		      // for each, create a new label
		      string id = cp->Get_Id() + "/" + t->Get_Hierarchical_Id() + "[" +IntToStr(idx) + "]";
		      vcCompatibilityLabel* nl = cp->Make_Compatibility_Label(id);
		      pair<vcTransition*, int> npair(t,idx);
		      nl->Add_In_Arc(t->Get_Compatibility_Label(), npair);

		      // propagate the label into the successor
		      (*fork_iter).second[idx]->Compute_Compatibility_Labels(nl,cp);
		    }
		}
	      else
		{
		  (*fork_iter).second.front()->Compute_Compatibility_Labels(t->Get_Compatibility_Label(),cp);
		}
	    }
	}
    }
}

void vcCPForkBlock::Update_Predecessor_Successor_Links()
{

  // forks
  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = this->_fork_map.begin();
      iter != this->_fork_map.end();
      iter++)
    {
      vcTransition* t = (*iter).first;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  vcCPElement* e = (*iter).second[idx];
	  e->Add_Predecessor(t);
	  t->Add_Successor(e);
	}
    }

  // joins
  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = this->_join_map.begin();
      iter != this->_join_map.end();
      iter++)
    {
      vcTransition* t = (*iter).first;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  vcCPElement* e = (*iter).second[idx];
	  e->Add_Successor(t);
	  t->Add_Predecessor(e);
	}
    }


  // those that were not covered by explicit fork/join declarations
  vector<vcCPElement*> unforked_elements;
  vector<vcCPElement*> unjoined_elements;
  for(int idx = 0; idx < _elements.size(); idx++)
    {
      if(_forked_elements.find(_elements[idx]) == _forked_elements.end())
	unforked_elements.push_back(_elements[idx]);
      
      if(_joined_elements.find(_elements[idx]) == _joined_elements.end())
	unjoined_elements.push_back(_elements[idx]);
    }
  if(_forked_elements.find(this->_exit) == _forked_elements.end())
    unforked_elements.push_back(this->_exit);

  if(_joined_elements.find(this->_exit) == _joined_elements.end())
    unjoined_elements.push_back(this->_exit);



  // finally, those CPElements in the block which
  // are not forked from an explicitly specified fork
  // are assumed to be forked from $entry.
  if(unforked_elements.size() > 0)
    {
      for(int idx = 0; idx < unforked_elements.size(); idx++)
	{
	  // entry -> exit link may be introduced here.
	  // (if not explicitly specified).
	  this->_entry->Add_Successor(unforked_elements[idx]);
	  unforked_elements[idx]->Add_Predecessor(this->_entry);
	  this->_fork_map[this->_entry].push_back(unforked_elements[idx]);
	}
    }

  // finally, those CPElements in the block which
  // are not joined at an explicitly specified join
  // are assumed to join at $exit.
  if(unjoined_elements.size() > 0)
    {
      for(int idx = 0; idx < unjoined_elements.size(); idx++)
	{
	  if(unjoined_elements[idx] != this->_exit)
	    {
	      this->_exit->Add_Predecessor(unjoined_elements[idx]);
	      unjoined_elements[idx]->Add_Successor(this->_exit);
	      this->_join_map[this->_exit].push_back(unjoined_elements[idx]);
	    }
	}
    }

  this->vcCPBlock::Update_Predecessor_Successor_Links();
}

vcControlPath::vcControlPath(string id):vcCPSeriesBlock(NULL, id)
{
}

// some thought here.. named transitions must be unique.
vcTransition* vcControlPath::Find_Transition(vector<string>& hier_id)
{
  vcCPElement* cpe = this;
  for(int idx = 0; idx < hier_id.size(); idx++)
    {
      cpe = cpe->Find_CPElement(hier_id[idx]);
      if(cpe == NULL)
	break;
    }
  
  if(cpe != NULL && cpe->Is("vcTransition"))
    return((vcTransition*)cpe);
  else
    return(NULL);
}

vcPlace* vcControlPath::Find_Place(vector<string>& hier_id)
{

  vcCPElement* cpe = this;
  for(int idx = 0; idx < hier_id.size(); idx++)
    {
      cpe = cpe->Find_CPElement(hier_id[idx]);
      if(cpe == NULL)
	break;
    }
  
  if(cpe != NULL && cpe->Is("vcPlace"))
    return((vcPlace*)cpe);
  else
    return(NULL);
}

void vcControlPath::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__CONTROLPATH] << " {" << endl;
  this->Print_Elements(ofile);
  this->Print_Attributes(ofile);
  ofile << "\n// end controlpath" << endl << "}" << endl;
}



void vcControlPath::Compute_Compatibility_Labels()
{
  vcCompatibilityLabel* nl = this->Make_Compatibility_Label(this->Get_Id());
  this->vcCPSeriesBlock::Compute_Compatibility_Labels(nl,this);


  // set up connectivity
  for(set<vcCompatibilityLabel*>::iterator iter = this->_compatibility_label_set.begin();
      iter != this->_compatibility_label_set.end();
      iter++)
    {
      if((*iter)->_labeled_in_arc.first != NULL)
	{
	  (*iter)->_labeled_in_arc.first->Add_Successor((*iter));
	  (*iter)->Add_Predecessor((*iter)->_labeled_in_arc.first);
	}
      else 
	{
	  for(set<vcCompatibilityLabel*>::iterator siter = (*iter)->_unlabeled_in_arcs.begin();
	      siter != (*iter)->_unlabeled_in_arcs.end();
	      siter++)
	    {
	      (*iter)->Add_Predecessor((*siter));
	      (*siter)->Add_Successor((*iter));
	    }
	}
    }

  // check that there is exactly one vertex of out-degree 1.
  vcCompatibilityLabel* source = NULL;
  for(set<vcCompatibilityLabel*>::iterator iter = this->_compatibility_label_set.begin();
      iter != this->_compatibility_label_set.end();
      iter++)
    {
      if((*iter)->Get_Number_Of_Predecessors() == 0)
	{
	  if(source != NULL)
	    vcSystem::Error("Multiple source labels in compatibility graph \n");
	  assert(source == NULL && "more than one source in compatibility label graph?");
	  source = (*iter);
	}
    }

  // now check that all labels are reachable from the source
  // and that there is no cycle.
  bool cycle_flag = false;
  int num_visited = 0;
  vector<vcCPElement*> dfs_ordered_elements;
  this->vcCPBlock::DFS_Order(false, (vcCPElement*) source, cycle_flag, num_visited,dfs_ordered_elements);
  if(cycle_flag)
    {
      vcSystem::Error("Cycle in compatibility label graph\n");
    }
  if(num_visited != this->_compatibility_label_set.size())
    {
      vcSystem::Error("Some compatibility labels are not reachable from the source label\n");
    }

  // now build the descendant maps.
  // transitive closure..
  this->vcCPBlock::BFS_Order(false, (vcCPElement*) source,num_visited, this->_bfs_ordered_labels);
  for(int hidx = this->_bfs_ordered_labels.size(); hidx > 0; hidx--)
    {
      int idx = hidx-1;

      vcCompatibilityLabel* u = (vcCompatibilityLabel*) (this->_bfs_ordered_labels[idx]);
      set<vcCompatibilityLabel*>& adj_set = this->_label_descendent_map[u];
      adj_set.insert(u);

      for(int adjidx = 0; adjidx < u->Get_Number_Of_Successors(); adjidx++)
	{
	  adj_set.insert(this->_label_descendent_map[((vcCompatibilityLabel*)(u->Get_Successor(adjidx)))].begin(),
			 this->_label_descendent_map[((vcCompatibilityLabel*) (u->Get_Successor(adjidx)))].end());
	}
    }
}

bool vcControlPath::Are_Compatible(vcCompatibilityLabel* u, vcCompatibilityLabel* v)
{
  if(this->_label_descendent_map[u].find(v) != this->_label_descendent_map[u].end())
    return(true);
  else if(this->_label_descendent_map[v].find(u) != this->_label_descendent_map[v].end())
    return(true);
  else
    return(false);
}


bool vcControlPath::Lesser(vcCompatibilityLabel* u, vcCompatibilityLabel* v)
{
  return(this->_label_descendent_map[u].find(v) != this->_label_descendent_map[u].end());
}

bool vcControlPath::Greater(vcCompatibilityLabel* v, vcCompatibilityLabel* u)
{
  return(this->_label_descendent_map[u].find(v) != this->_label_descendent_map[u].end());
}


vcCompatibilityLabel* vcControlPath::Make_Compatibility_Label(string id)
{
  vcCompatibilityLabel* nl = new vcCompatibilityLabel(this,id);
  this->_compatibility_label_set.insert(nl);
  return(nl);
}

void vcControlPath::Delete_Compatibility_Label(vcCompatibilityLabel* nl)
{
  if(_compatibility_label_set.find(nl) != _compatibility_label_set.end())
    {
      _compatibility_label_set.erase(nl);
      delete nl;
    }
}

bool vcControlPath::Check_Structure()
{
  this->vcCPSeriesBlock::Update_Predecessor_Successor_Links();
  this->vcCPSeriesBlock::Check_Structure();
}

void vcControlPath::Print_Compatibility_Labels(ostream& ofile)
{
  ofile << "Label Summary " << endl;
  for(set<vcCompatibilityLabel*>::iterator iter = _compatibility_label_set.begin();
      iter != _compatibility_label_set.end();
      iter++)
    {
      (*iter)->Print(ofile);
    }
  
  ofile << "Label Transitive Closure " << endl;
  for(map<vcCompatibilityLabel*, set<vcCompatibilityLabel*> >::iterator iter = this->_label_descendent_map.begin();
      iter != this->_label_descendent_map.end();
      iter++)
    {
      ofile <<  (*iter).first->Get_Id() << " ==> " ;
      for(set<vcCompatibilityLabel*>::iterator siter = (*iter).second.begin();
	  siter != (*iter).second.end();
	  siter++)
	{
	  ofile << (*siter)->Get_Id() << " ";
	}
      ofile << endl;
    }
}

bool vcCompatibilityLabel_Compare::operator() (vcCompatibilityLabel* u, vcCompatibilityLabel* v) const
{
  if(u->Get_Parent() != v->Get_Parent())
    return(false);
  
  assert(u->Get_Parent() != NULL && (u->Get_Parent()->Kind() == "vcControlPath"));

  vcControlPath* cp = (vcControlPath*) u->Get_Parent();
  return(cp->Lesser(u,v));
}

void vcControlPath::Print_VHDL_Start_Symbol_Assignment(ostream& ofile)
{
  ofile << this->Get_Start_Symbol() << " <=  true when start = '1' else false; -- control passed to control-path." << endl;
}

void vcControlPath::Print_VHDL_Exit_Symbol_Assignment(ostream& ofile)
{
  ofile << "fin  <=  '1' when " << this->_exit->Get_Exit_Symbol() << " else '0'; -- fin symbol when control-path exits" << endl;
}
