#include <vcIncludes.hpp>
#include <vcRoot.hpp>
#include <vcControlPath.hpp>
#include <vcSystem.hpp>

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
vcTransition::vcTransition(vcCPElement* parent, string id, vcTransitionType t):vcCPElement(parent, id)
{
  this->_transition_type = t;
}

void vcTransition::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__TRANSITION] << " " << this->Get_Label() << " ";
  switch(_transition_type)
    {
    case  _IN_TRANSITION: ofile << vcLexerKeywords[__IN] << endl; break;
    case  _OUT_TRANSITION: ofile << vcLexerKeywords[__OUT] << endl; break;
    case  _HIDDEN_TRANSITION: ofile << vcLexerKeywords[__HIDDEN] << endl; break;
    default: break;
    }
}


vcPlace::vcPlace(vcCPElement* parent, string id, unsigned int init_marking):vcCPElement(parent, id)
{
  this->_initial_marking = init_marking;
}

void vcPlace::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PLACE] << " " << this->Get_Label() << endl;
}

vcCPBlock::vcCPBlock(vcCPBlock* parent, string id): vcCPElement((vcCPElement*)parent, id)
{
}

void vcCPBlock::Add_CPElement(vcCPElement* cpe)
{
  assert(this->_element_map.find(cpe->Get_Id()) == this->_element_map.end());

  this->_element_map[cpe->Get_Id()] = cpe;
  this->_elements.push_back(cpe);
}

vcCPElement* vcCPBlock::Find_CPElement(string cname)
{
  if(this->_element_map.find(cname) == this->_element_map.end())
    return(NULL);
  else
    return ((*(this->_element_map.find(cname))).second);
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


void vcCPBlock::BFS_Order(bool reverse_flag, vcCPElement* start_element, bool& cycle_flag, int& num_visited, vector<vcCPElement*>& bfs_ordered_elements)
{
  set<vcCPElement*> visited_set;
  set<vcCPElement*> on_queue_set;
  deque<vcCPElement*> bfs_queue;
  
  bfs_queue.push_back(start_element);
  num_visited = 0;

  while(!bfs_queue.empty())
    {
      vcCPElement* top = (bfs_queue.front());

      bfs_queue.pop_front();
      visited_set.insert(top);
      bfs_ordered_elements.push_back(top);
      on_queue_set.erase(top);

      num_visited++;


      vector<vcCPElement*>& adj = (reverse_flag ? top->Get_Predecessors() : top->Get_Successors());
      for(int idx = 0; idx < adj.size(); idx++)
	{
	  vcCPElement* w = adj[idx];
	  if(visited_set.find(w) != visited_set.end())
	    {
	      cycle_flag = true;
	    }
	  else if((on_queue_set.find(w) == on_queue_set.end()) && (visited_set.find(w) == visited_set.end()))
	    {// push into queue if not already present in the queue and if not already popped from front..
	      bfs_queue.push_back(w);
	      on_queue_set.insert(w);
	    }
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
  _entry = new vcPlace(this,vcLexerKeywords[__ENTRY],0);
  _exit = new vcPlace(this,vcLexerKeywords[__EXIT],0);
}

vcCPElement* vcCPSeriesBlock::Find_CPElement(string cname)
{
  vcCPElement* ret_cpe = NULL;
  if(cname == vcLexerKeywords[__ENTRY])
    ret_cpe = (vcCPElement*) this->_entry;
  else if(cname == vcLexerKeywords[__EXIT])
    ret_cpe = (vcCPElement*) this->_exit;
  else
    ret_cpe = this->vcCPBlock::Find_CPElement(cname);
    
  return(ret_cpe);
}

void vcCPSeriesBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__SERIESBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);
  ofile << "}// series-block " << this->Get_Id() << endl;
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
  _entry = new vcTransition(this,vcLexerKeywords[__ENTRY],_HIDDEN_TRANSITION);
  _exit = new vcTransition(this,vcLexerKeywords[__EXIT], _HIDDEN_TRANSITION);
}

vcCPElement* vcCPParallelBlock::Find_CPElement(string cname)
{
  vcCPElement* ret_cpe = NULL;
  if(cname == vcLexerKeywords[__ENTRY])
    ret_cpe = (vcCPElement*) this->_entry;
  else if(cname == vcLexerKeywords[__EXIT])
    ret_cpe = (vcCPElement*) this->_exit;
  else
    ret_cpe = this->vcCPBlock::Find_CPElement(cname);
    
  return(ret_cpe);
}

void vcCPParallelBlock::Print(ostream& ofile)
{
  ofile << vcLexerKeywords[__PARALLELBLOCK]  << " [" << this->Get_Id() << "] {" << endl;
  this->Print_Elements(ofile);
  ofile << "}// parallel-block " << this->Get_Id() << endl;
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
      ofile << vcLexerKeywords[__FROM] << " " << (*iter).first->Get_Id() << " " << 
	vcLexerKeywords[__BRANCH] << " ";
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << endl;
    }

  for(map<vcPlace*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _merge_map.begin();
      iter != _merge_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__AT] << " " << (*iter).first->Get_Id() << " " << vcLexerKeywords[__MERGE] << " ";
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << endl;
    }
  ofile << "}// branch-block " << this->Get_Id() << endl;
}


bool vcCPBranchBlock::Check_Structure()
{

  bool ret_flag = this->vcCPBlock::Check_Structure();
  if(ret_flag)
    {

      vector<vcCPElement*> reachable_elements;
      bool cycle_flag = false;
      int num_visited = 0;

      this->BFS_Order(false,this->_entry, cycle_flag, num_visited, reachable_elements);
      if(num_visited != (this->_elements.size() + 2))
	{
	  ret_flag = false;
	  vcSystem::Error("all elements not reachable from entry in region " + this->Get_Hierarchical_Id());
	}

      reachable_elements.clear();
      num_visited = 0;
      cycle_flag = false;
      this->BFS_Order(true, this->_exit, cycle_flag, num_visited, reachable_elements);
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
      ofile << vcLexerKeywords[__FROM] << " " << (*iter).first->Get_Id() << " " << 
	vcLexerKeywords[__FORK] << " " ;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << endl;
    }


  for(map<vcTransition*,vector<vcCPElement*>,vcRoot_Compare>::iterator iter = _join_map.begin();
      iter != _join_map.end();
      iter++)
    {
      ofile << vcLexerKeywords[__AT] << " " << (*iter).first->Get_Id() << " " << 
	vcLexerKeywords[__JOIN] << " " ;
      for(int idx = 0; idx < (*iter).second.size(); idx++)
	{
	  ofile << " " << (*iter).second[idx]->Get_Id() << " ";
	}
      ofile << endl;
    }
  ofile << "}// fork-block " << this->Get_Id() << endl;
}

bool vcCPForkBlock::Check_Structure()
{
  bool ret_flag = this->vcCPBlock::Check_Structure();
  if(ret_flag)
    {
      vector<vcCPElement*> reachable_elements;
      bool cycle_flag = false;
      int num_visited = 0;

      this->BFS_Order(false, this->_entry, cycle_flag, num_visited, reachable_elements);
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
      this->BFS_Order(true, this->_exit, cycle_flag, num_visited, reachable_elements);
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
  bool cycle_flag = false;
  int num_visited = 0;
  
  this->BFS_Order(false, this->_entry, cycle_flag, num_visited, reachable_elements);
  this->_entry->Set_Compatibility_Label(in_label);

  for(int idx = 0; idx < reachable_elements.size(); idx++)
    {
      if(reachable_elements[idx]->Is("vcTransition"))
	{
	  vcTransition* t = (vcTransition*) reachable_elements[idx];

	  // first the join case.
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
  this->vcCPBlock::Update_Predecessor_Successor_Links();
}

vcControlPath::vcControlPath(string id):vcCPParallelBlock(NULL, id)
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
  ofile << "}// controlpath" << endl;
}



void vcControlPath::Compute_Compatibility_Labels()
{
  vcCompatibilityLabel* nl = this->Make_Compatibility_Label(this->Get_Id());
  this->vcCPParallelBlock::Compute_Compatibility_Labels(nl,this);


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
  this->vcCPBlock::BFS_Order(false, (vcCPElement*) source, cycle_flag, num_visited, this->_bfs_ordered_labels);
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
  this->vcCPParallelBlock::Update_Predecessor_Successor_Links();
  this->vcCPParallelBlock::Check_Structure();
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
