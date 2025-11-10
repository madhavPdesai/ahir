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
#ifndef _vC_CP_H_
#define _vC_CP_H_
#include <vcIncludes.hpp>
class vcRoot;
class vcControlPath;
class vcCompatibilityLabel;
class vcCPPipelinedLoopBody;
class vcCPPipelinedForkBlock;
class vcCPBlock;
class vcModule;
class vcTransition;
class vcCPElement: public vcRoot
{

protected:
  int64_t _index;
  vcCPElement* _parent;
  vector<vcCPElement*> _predecessors;
  vector<vcCPElement*> _successors;

  vector<vcCPElement*> _marked_predecessors;
  map<vcCPElement*, int> _marked_predecessor_delays;

  vector<vcCPElement*> _marked_successors;
  map<vcCPElement*, int> _marked_successor_delays;

  vcCompatibilityLabel* _compatibility_label;

  // for bindings.
  vcCPElement* _associated_cp_function;
  vcCPElement* _associated_cp_region;

  bool _is_bound_as_input_to_cp_function;
  bool _is_bound_as_output_from_cp_function;

  bool _is_bound_as_input_to_region;
  bool _is_bound_as_output_from_region;
 
  bool _has_null_successor;
  bool _has_null_predecessor;

  bool _is_left_open;

  vcCPBlock* _pipeline_parent;


public:

  vcCPElement(vcCPElement* parent, string id);


  virtual void Add_Alias(string alias_string, string ref_string) {assert(0);}
  virtual string Get_Alias_Reference_String(string alias_string) {assert(0);}

  virtual bool Is_Input_Transition ()  {return(false);}
  virtual bool Is_Output_Transition () {return(false);}

  void Add_Successor(vcCPElement* cpe);
  void Add_Predecessor(vcCPElement* cpe);
  void Remove_Successor(vcCPElement* cpe);
  void Remove_Predecessor(vcCPElement* cpe);

  void Add_Marked_Successor(vcCPElement* cpe);
  void Add_Marked_Predecessor(vcCPElement* cpe);
  void Remove_Marked_Successor(vcCPElement* cpe);
  void Remove_Marked_Predecessor(vcCPElement* cpe);

  void Set_Marked_Successor_Delay(vcCPElement* cpe, int m);
  int  Get_Marked_Successor_Delay(vcCPElement* cpe);

  void Set_Marked_Predecessor_Delay(vcCPElement* cpe, int m);
  int  Get_Marked_Predecessor_Delay(vcCPElement* cpe);

  void Connect(vcCPElement* dest)
  {
	this->Add_Successor(dest);
	dest->Add_Predecessor(this);
  }

  virtual bool Is_Pipeline() { return (false); }
  virtual bool Is_Block() { return (false); }
  virtual bool Is_Control_Path() { return (false); }

  void Set_Is_Left_Open(bool v) {this->_is_left_open = v;}
  bool Get_Is_Left_Open() {return(this->_is_left_open);}

  void Get_Explicit_Predecessors(vector<vcCPElement*>& epreds);
  void Get_Explicit_Successors(vector<vcCPElement*>& epreds);

  virtual int Get_Number_Of_Predecessors() { return(this->_predecessors.size());}
  int Get_Number_Of_Successors() {return(this->_successors.size());}

  virtual int Get_Number_Of_Marked_Predecessors() { return(this->_marked_predecessors.size());}
  int Get_Number_Of_Marked_Successors() {return(this->_marked_successors.size());}

  bool Has_Predecessor(vcCPElement* cpe)
  {
	for(int idx = 0, fidx = _predecessors.size(); idx < fidx; idx++)
	{
		if(_predecessors[idx] == cpe)
			return(true);
	}
	return(false);
  }

  vcCPElement* Get_Successor(int idx) {
	  if(idx < _successors.size() )
		  return(this->_successors[idx]);
	  else
		  return(NULL);
  }
  vcCPElement* Get_Predecessor(int idx) {
	  if(idx < _predecessors.size() )
		  return(this->_predecessors[idx]);
	  else 
		  return(NULL);
  }

  vcCPElement* Get_Marked_Successor(int idx) {
	  if(idx < _marked_successors.size() )
		  return(this->_marked_successors[idx]);
	  else
		  return(NULL);
  }
  vcCPElement* Get_Marked_Predecessor(int idx) {
	  if(idx < _marked_predecessors.size() )
		  return(this->_marked_predecessors[idx]);
	  else 
		  return(NULL);
  }
  virtual string Kind() {return("vcCPElement");}
  virtual void Print(ostream& ofile) {assert(0);}

  virtual vcCPElement* Find_CPElement(string cname) {return(NULL);}

  virtual bool Is_Transition() {return(false);}
  virtual bool Is_Place() {return(false);}
  virtual void Get_Hierarchical_Ref(vector<string>& ref_vec);
  vcCPElement* Get_Parent() {return(this->_parent);}

  string Get_Hierarchical_Id();

  virtual void Update_Predecessor_Successor_Links() {return;}
  virtual bool Check_Structure() { return(true);}
  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m) 
  {
    this->Set_Compatibility_Label(in_label);
  }

  virtual void Set_Compatibility_Label(vcCompatibilityLabel* v) 
  {
    this->_compatibility_label = v;
  }

  virtual vcCompatibilityLabel* Get_Compatibility_Label() 
  {
    return(this->_compatibility_label);
  }

  vector<vcCPElement*>& Get_Predecessors() {return(this->_predecessors);}
  vector<vcCPElement*>& Get_Successors() {return(this->_successors);}

  vector<vcCPElement*>& Get_Marked_Predecessors() {return(this->_marked_predecessors);}
  vector<vcCPElement*>& Get_Marked_Successors() {return(this->_marked_successors);}

  virtual void Print_Successors(ostream& ofile);
  virtual void Print_Marked_Successors(ostream& ofile);

  virtual void Print_Structure(ostream& ofile) {}

  //  string Get_VHDL_Id() {return("cp_" + IntToStr(this->Get_Index()));}
  virtual string Get_VHDL_Id() {return(To_VHDL(this->Get_Id()+ "_" + Int64ToStr(this->Get_Index())));}

  // exit symbol lookup from control-path
  string Get_Exit_Symbol(vcControlPath* cp); 

  virtual string Get_Exit_Symbol() {return(this->Get_VHDL_Id() + "_symbol");}
  virtual string Get_Start_Symbol(){return(this->Get_VHDL_Id() + "_start");}

  virtual string Get_Enable_Place_Symbol() {return(this->Get_VHDL_Id() + "_enable");}
  virtual string Get_Trigger_Place_Symbol(){return(this->Get_VHDL_Id() + "_trigger");}

  virtual string Get_Always_True_Symbol() {return("always_true_symbol");}

  virtual int64_t Get_Index() {return(this->_index);}


  virtual void Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp) {}
  virtual void Connect_CPElement_Group_Graph(vcControlPath* cp);
  
  virtual vcCPElement* Get_Exit_Element()
  {
    return(this);
  }

  virtual vcCPElement* Get_Entry_Element()
  {
    return(this);
  }

  // (u,v) is a forward edge ...
  virtual void DFS_Forward_Edge_Action(bool reverse_flag, 
					deque<vcCPElement*>& dfs_queue, 
					set<vcCPElement*>& on_queue_set,
					vcCPElement* u, vcCPElement* v)
  {
	// do nothing..
  }

  // (u,v) is a backward edge
  virtual void DFS_Backward_Edge_Action(bool reverse_flag,
					deque<vcCPElement*>& dfs_queue, 
					set<vcCPElement*>& on_queue_set,
					vcCPElement* u, vcCPElement* v)
  {
	// do nothing..
  }

  void Set_Is_Bound_As_Input_To_CP_Function(bool v) {this->_is_bound_as_input_to_cp_function = v;}
  bool Get_Is_Bound_As_Input_To_CP_Function() {return(this->_is_bound_as_input_to_cp_function);}

  void Set_Is_Bound_As_Output_From_CP_Function(bool v) {this->_is_bound_as_output_from_cp_function = v;}
  bool Get_Is_Bound_As_Output_From_CP_Function() {return(this->_is_bound_as_output_from_cp_function);}

  void Set_Is_Bound_As_Input_To_Region(bool v) {this->_is_bound_as_input_to_region = v;}
  bool Get_Is_Bound_As_Input_To_Region() {return(this->_is_bound_as_input_to_region);}

  void Set_Is_Bound_As_Output_From_Region(bool v) {this->_is_bound_as_output_from_region = v;}
  bool Get_Is_Bound_As_Output_From_Region() {return(this->_is_bound_as_output_from_region);}

  void Set_Associated_CP_Function(vcCPElement* c);
  vcCPElement* Get_Associated_CP_Function() {return(_associated_cp_function);}

  void Set_Associated_CP_Region(vcCPElement* c) {_associated_cp_region = c;}
  vcCPElement* Get_Associated_CP_Region() {return(_associated_cp_region);}
  
  void Set_Has_Null_Successor(bool v) {_has_null_successor = v;}
  bool Get_Has_Null_Successor() {return(_has_null_successor);}

  void Set_Has_Null_Predecessor(bool v) {_has_null_predecessor = v;}
  bool Get_Has_Null_Predecessor() {return(_has_null_predecessor);}

  virtual void  Set_Pipeline_Parent(vcCPBlock* cpb) {if(_pipeline_parent == NULL) _pipeline_parent = cpb;}
  vcCPBlock* Get_Pipeline_Parent() {return(_pipeline_parent);}

  virtual void Print_VHDL_Bindings(vcControlPath* cp, ostream& ofile) {assert(0);}
  virtual bool Is_Pipelined() {return(false);}

  // CP function related.
  virtual bool Is_In_Transition(vcTransition* p) {return(false);}
  virtual bool Is_Out_Transition(vcTransition* p) {return(false);}
  virtual bool Get_Is_Dead() {return(false);}
  virtual bool Get_Is_Delay_Element() {return(false);}

  virtual vcModule* Get_Root_Parent_Module();

};



class vcTransition;
class vcControlPath;
class vcCompatibilityLabel: public vcCPElement
{

  //     pair<> is arc-label.
  //     if pair.first is null, then arc-label is 1.
  pair<vcCompatibilityLabel*, pair<vcTransition*,int> >  _labeled_in_arc;
  set<vcCompatibilityLabel*> _unlabeled_in_arcs;

public:
  vcCompatibilityLabel(vcControlPath* cp, string id);
  void Add_In_Arc(vcCompatibilityLabel* u, pair<vcTransition*, int>& arc);
  void Add_In_Arc(vcCompatibilityLabel* u);
  vcCompatibilityLabel* Reduce(vcControlPath* cp);

  void Print(ostream& ofile);

  virtual string Kind() {return("vcCompatibilityLabel");}

  bool Is_Compatible(vcCompatibilityLabel* other);
  bool Is_Join()
  {
    return((_labeled_in_arc.first == NULL) && (_unlabeled_in_arcs.size() > 0));
  }
  string Get_Join_String()
  {
    string ret_string = "##";
    for(set<vcCompatibilityLabel*>::iterator iter = _unlabeled_in_arcs.begin(),
	  fiter = _unlabeled_in_arcs.end();
	iter != fiter;
	iter++)
      {
	ret_string += (*iter)->Get_Id() + "##";
      }
    return(ret_string);
  }




  friend class vcControlPath;

  friend bool operator==(vector<vcCompatibilityLabel*>&, vector<vcCompatibilityLabel*>&);
  friend bool operator==(set<vcCompatibilityLabel*>&, set<vcCompatibilityLabel*>&);
};

// compatibility operators
bool operator== (vector<vcCompatibilityLabel*>&, vector<vcCompatibilityLabel*>&);
bool operator==(set<vcCompatibilityLabel*>&, set<vcCompatibilityLabel*>&);


class vcDatapathElement;
enum vcTransitionType
  {
    _IN_TRANSITION,
    _OUT_TRANSITION,
    _DEAD_TRANSITION,
    _TIE_HIGH_TRANSITION,
    _LEFT_OPEN_TRANSITION
  };
class vcTransition: public vcCPElement
{
  vector<pair<vcDatapathElement*,vcTransitionType> > _dp_link;
  bool _is_input;
  bool _is_output;
  bool _is_dead;
  bool _is_tied_high;
  bool _is_entry_transition;
  bool _is_linked_to_non_local_dpe;
  bool _is_delay_element;


public:
  vcTransition(vcCPElement* parent, string id);
  void Add_DP_Link(vcDatapathElement* dpe,vcTransitionType ltype);

  virtual bool Is_Transition() {return(true);}
  virtual bool Is_Input_Transition ()  {return(_is_input);}
  virtual bool Is_Output_Transition () {return(_is_output);}
  bool Get_Is_Input() { return(_is_input);}
  bool Get_Is_Output() { return(_is_output);}

  void Set_Is_Dead(bool v) {this->_is_dead = v;}
  virtual bool Get_Is_Dead() {return(this->_is_dead);}


  void Set_Is_Delay_Element(bool v) {this->_is_delay_element = v;}
  virtual bool Get_Is_Delay_Element() {return(this->_is_delay_element);}

  void Set_Is_Tied_High(bool v) {this->_is_tied_high = v;}
  bool Get_Is_Tied_High() {return(this->_is_tied_high);}

  void Set_Is_Entry_Transition(bool v) {this->_is_entry_transition = v;}
  bool Get_Is_Entry_Transition() {return(this->_is_entry_transition);}

  bool Get_Is_Linked_To_Non_Local_Dpe() {return(this->_is_linked_to_non_local_dpe);}


  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  virtual string Kind() {return("vcTransition");}

  vector<pair<vcDatapathElement*,vcTransitionType> >&  Get_DP_Link() {return(this->_dp_link);}

  friend class vcControlPath;

  string Get_DP_To_CP_Symbol();
  string Get_CP_To_DP_Symbol();

  virtual void Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp);

  void Print_DP_To_CP_VHDL_Link(ostream& ofile);
  void Print_CP_To_DP_VHDL_Link(ostream& ofile);

  string Generate_Marked_Join_Bypass_String();
};

class vcPlace: public vcCPElement
{
  unsigned int _initial_marking;

  bool _is_bound_as_input_to_region;
  bool _is_bound_as_output_from_region;

public:
  vcPlace(vcCPElement* parent, string id, unsigned int init_marking);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcPlace");}
  virtual bool Is_Place() {return(true);}


  virtual void Print_VHDL(ostream& ofile);
  virtual void Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp);

  void Set_Is_Bound_As_Input_To_Region(bool v) { _is_bound_as_input_to_region = v;}
  void Set_Is_Bound_As_Output_From_Region(bool v) { _is_bound_as_output_from_region = v;}


  friend class ControlPath;

};

class vcCPBlock: public vcCPElement
{

protected:
  map<vcPlace*, vcTransition*> _input_bindings;
  map<vcPlace*, vcTransition*> _output_bindings;

  map<string, vcCPElement*> _element_map;
  vector<vcCPElement*> _elements;

  map<string, string> _alias_map;
  vcTransition* _entry;
  vcTransition* _exit;

public:
  vcCPBlock(vcCPBlock* parent, string id);

  vector<vcCPElement*>& Get_Elements() { return _elements; }

  virtual void Set_Pipeline_Parent(vcCPBlock* cpb)
  {
	  if(_pipeline_parent != NULL)
		return;

	  for(int I = 0, fI = _elements.size(); I < fI; I++)
	  {
		  _elements[I]->Set_Pipeline_Parent(cpb);
	  }
	  this->_entry->Set_Pipeline_Parent(cpb);
	  this->_exit->Set_Pipeline_Parent(cpb);
	  _pipeline_parent = cpb;
  }

  virtual void Add_Alias(string alias_string, string ref_string)
  {
	_alias_map[alias_string] = ref_string;
  }
  virtual string Get_Alias_Reference_String(string alias_string)
  {
	string ret_val = alias_string;
	if(_alias_map.find(alias_string) != _alias_map.end())
		ret_val = _alias_map[alias_string];
	return(ret_val);
  }

  virtual void Add_CPElement(vcCPElement* cpe);
  vcCPElement* Find_CPElement(string cname);
  virtual void Print(ostream& ofile) {assert(0);}
  void Print_Elements(ostream& ofile);

  virtual bool Is_Block() { return (true); }

  virtual int Get_Max_Iterations_In_Flight() {return (1);} ;
  int Get_Number_Of_Elements() {return(this->_elements.size());}

  virtual string Kind() {return("vcCPBlock");}

  virtual bool Check_Structure(); // check that the block is well-formed.
  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m);
  virtual void Update_Predecessor_Successor_Links();
  
  void BFS_Order(bool reverse_flag,
		 vcCPElement* start_element, 
		 int& num_visited, 
		 vector<vcCPElement*>& bfs_ordered_elements,
		 set<vcCPElement*>& visited_set);
  void DFS_Order(bool reverse_flag,vcCPElement* start_element, 
		 bool& cycle_flag, int& num_visited, 
		 vector<vcCPElement*>& dfs_ordered_elements,
		 set<vcCPElement*>& visited_set);

  virtual void Print_Structure(ostream& ofile);

  virtual void Print_VHDL(ostream& ofile);
  virtual void Print_VHDL_Start_Interlock(ostream& ofile);
  virtual void Print_VHDL_Start_Symbol_Assignment(ostream& ofile);
  virtual void Print_VHDL_Exit_Symbol_Assignment(ostream& ofile);
  virtual void Print_VHDL_Signal_Declarations(ostream& ofile);
  virtual void Print_VHDL_Export_Cleanup(ostream& ofile);

  void Print_Missing_Elements(set<vcCPElement*>& visited_set); // print to cerr
  virtual void Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp);
  virtual void Connect_CPElement_Group_Graph(vcControlPath* cp);

  virtual vcCPElement* Get_Exit_Element()
  {
    return(this->_exit);
  }
  virtual vcCPElement* Get_Entry_Element()
  {
    return(this->_entry);
  }

  virtual string Get_Predecessor_Exit_Symbol();
  virtual string Get_Successor_Start_Symbol();

  // for a normal block everything is reachable from
  // entry.  Thus, the number is N + 2 (because exit
  // and entry are kept separately).
  virtual int Number_Of_Elements_Reachable_From_Entry()
  {
	return(this->Get_Number_Of_Elements() + 2);
  }
  
  virtual int Number_Of_Elements_That_Can_Reach_Exit()
  {
	return(this->Get_Number_Of_Elements() + 2);
  }

  virtual bool Relaxed_Entry_Reachability_Checking() {return(false);}
  virtual bool Relaxed_Exit_Reachability_Checking() {return(false);}

  virtual void Bind(string place_name, string region_name, string transition_name, bool input_binding);
  virtual void Print_VHDL_Bindings(vcControlPath* cp, ostream& ofile);
  void Update_Binding_Predecessor_Successor_Links();
  
  virtual void Add_Scc_Arc (string tail_lbl, string head_lbl);
};

class vcCPSeriesBlock: public vcCPBlock
{
  
public:

  vcCPSeriesBlock(vcCPBlock* parent, string id);


  virtual void Print(ostream& ofile);


  virtual string Kind() {return("vcCPSeriesBlock");}

  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m);
  virtual void Update_Predecessor_Successor_Links();

  virtual void Print_Structure(ostream& ofile);

};

class vcCPParallelBlock: public vcCPBlock
{

public:


  vcCPParallelBlock(vcCPBlock* parent, string id);
  virtual void Print(ostream& ofile);


  virtual string Kind() {return("vcCPParallelBlock");}

  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m);
  virtual void Update_Predecessor_Successor_Links();

  virtual void Print_Structure(ostream& ofile);
};


class vcCPBranchBlock: public vcCPSeriesBlock
{
protected:
  map<vcPlace*, vector<vcCPElement*>, vcRoot_Compare >   _branch_map;
  map<vcPlace*, vector<vcCPElement*>, vcRoot_Compare > _merge_map;

public:
  vcCPBranchBlock(vcCPBlock* parent, string id);
  virtual string Kind() {return("vcCPBranchBlock");}

  void Add_Branch_Point(string bp_name, vector<string>& choice_cpe_vec);
  void Add_Merge_Point(string merge_place, string merge_region);
  virtual void Print(ostream& ofile);


  virtual bool Check_Structure(); // check that the block is well-formed.
  virtual void Update_Predecessor_Successor_Links();
};

class vcTransitionMerge: public vcCPElement
{
  vector<vcTransition*> _in_transitions;
  vcTransition* _out_transition;

public:
  vcTransitionMerge(vcCPElement* prnt, string id);

  vector<vcTransition*>& Get_In_Transitions() { return _in_transitions; }
  vcTransition* Get_Out_Transition() { return _out_transition; }

  void Add_In_Transition(vcTransition* p) 
  {
    _in_transitions.push_back(p);
  }
  void Set_Out_Transition(vcTransition* p) { _out_transition = p; }

  int Get_Number_Of_In_Transitions() { return(_in_transitions.size()); }
  vcTransition* Get_In_Transition(int idx) 
  { 
    if((idx >= 0) && (idx < _in_transitions.size()))
      return(_in_transitions[idx]);
    else
      return(NULL);
  }

  void Print(ostream& ofile);
  void Print_VHDL(vcControlPath* cp, ostream& ofile);
  void Print_Dot_Entry(vcControlPath* cp, ostream& ofile);

  virtual void Update_Predecessor_Successor_Links();
  virtual bool Is_In_Transition(vcTransition* p)
  {
	for(int idx = 0, fidx = _in_transitions.size(); idx < fidx; idx++)
	{
		if(_in_transitions[idx] == p)
			return(true);
		else 
			return(false);
	}
	return(false);
  }
  virtual bool Is_Out_Transition(vcTransition* p)
  {
	return(_out_transition == p);
  }

  void Append_Zero_Delay_Successors(vcTransition* t, set<vcCPElement*>& zero_delay_successors);
};

class vcPhiSequencer: public vcCPElement
{

public:
  int _place_capacity;

  vector<vcTransition*> _triggers;
  vector<vcTransition*> _src_sample_reqs;
  vector<vcTransition*> _src_sample_acks;
  vector<vcTransition*> _src_update_reqs;
  vector<vcTransition*> _src_update_acks;
  vcTransition* _phi_sample_req;
  vcTransition* _phi_sample_ack;
  vcTransition* _phi_update_req;
  vcTransition* _phi_update_ack;
  vector<vcTransition*> _phi_mux_reqs;
  vcTransition* _phi_mux_ack;

  vcPhiSequencer(vcCPElement* prnt, string id);
  void Add_Trigger(vcTransition* s) { _triggers.push_back(s); }

  void Add_Src_Sample_Req(vcTransition* s) { _src_sample_reqs.push_back(s); }
  void Add_Src_Sample_Ack(vcTransition* s) { _src_sample_acks.push_back(s); }
  void Add_Src_Update_Req(vcTransition* s) { _src_update_reqs.push_back(s); }
  void Add_Src_Update_Ack(vcTransition* s) { _src_update_acks.push_back(s); }

  void Set_Phi_Sample_Req(vcTransition* p) { _phi_sample_req = p; }
  void Set_Phi_Sample_Ack(vcTransition* p) { _phi_sample_ack = p; }
  void Set_Phi_Update_Req(vcTransition* p) { _phi_update_req = p; }
  void Set_Phi_Update_Ack(vcTransition* p) { _phi_update_ack = p; }

  void Add_Phi_Mux_Req(vcTransition* s) { _phi_mux_reqs.push_back(s); }
  void Set_Phi_Mux_Ack(vcTransition* p) { _phi_mux_ack = p; }
 
  void Set_Place_Capacity(int n) {_place_capacity = n;}
  int  Get_Place_Capacity() {return(_place_capacity);}


  // return false if there is a problem.
  bool Check_Consistency()
  {
	if(_triggers.size() != _src_sample_reqs.size())
		return(true);
	if(_triggers.size() != _src_sample_acks.size())
		return(true);
	if(_triggers.size() != _src_update_reqs.size())
		return(true);
	if(_triggers.size() != _src_update_acks.size())
		return(true);
	if(_triggers.size() != _phi_mux_reqs.size())
		return(true);

	return(false);
  }

  void Print(ostream& ofile);
  void Print_VHDL(vcControlPath* cp, ostream& ofile);
  void Print_Dot_Entry(vcControlPath* cp, ostream& ofile);

  virtual void Update_Predecessor_Successor_Links();

  virtual bool Is_In_Transition(vcTransition* p)
  {
	for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	{
		if(_triggers[idx] == p)
			return(true);
		if(_src_sample_acks[idx] == p)
			return(true);
		if(_src_update_acks[idx] == p)
			return(true);
	}
	if(_phi_sample_req == p)
		return(true);
	if(_phi_update_req == p)
		return(true);
	if(_phi_mux_ack == p)
		return(true);
	return(false);
  }
  virtual bool Is_Out_Transition(vcTransition* p)
  {
	  for(int idx = 0, fidx = _triggers.size(); idx < fidx; idx++)
	  {
		  if(_src_sample_reqs[idx] == p)
			  return(true);
		  if(_src_update_reqs[idx] == p)
			  return(true);
		  if(_phi_mux_reqs[idx] == p)
			  return(true);
	  }
	  if(_phi_sample_ack == p)
		  return(true);
	  if(_phi_update_ack == p)
		  return(true);
	  return(false);
  }

  void Append_Zero_Delay_Successors(vcTransition* t, set<vcCPElement*>& zero_delay_successors);
};


class vcLoopTerminator: public vcCPElement
{
	vcCPElement* _loop_exit;
	vcCPElement* _loop_taken;
	vcCPElement* _loop_body;
	vcCPElement* _loop_back;
	vcCPElement* _exit_from_loop;

	public:

	vcCPElement* Get_Loop_Exit() { return _loop_exit; }
	vcCPElement* Get_Loop_Taken() { return _loop_taken; }
	vcCPElement* Get_Loop_Body() { return _loop_body; }
	vcCPElement* Get_Loop_Back() { return _loop_back; }
	vcCPElement* Get_Exit_From_Loop() { return _exit_from_loop; }

	vcLoopTerminator(vcCPElement* prnt, string id):vcCPElement(prnt,id) 
	{
		_loop_exit = NULL;
		_loop_taken = NULL;
		_loop_body = NULL;
		_loop_back = NULL;
		_exit_from_loop = NULL;
	}

  	void Append_Zero_Delay_Successors(vcTransition* t, set<vcCPElement*>& zero_delay_successors);
	friend class vcCPSimpleLoopBlock;
	friend class vcControlPath;
};

class vcCPPipelinedLoopBody;
class vcCPSimpleLoopBlock: public vcCPBranchBlock
{

	vcLoopTerminator* _terminator;
	int  _pipeline_depth;
	int  _pipeline_buffering;
	bool _pipeline_full_rate_flag;

	public:
	vcCPSimpleLoopBlock(vcCPBlock* parent, string id);
	virtual string Kind() {return("vcCPSimpleLoopBlock");}

	void Set_Pipeline_Depth(int d) {_pipeline_depth = d;}
	int  Get_Pipeline_Depth() {return(_pipeline_depth);}

	void Set_Pipeline_Buffering(int d) {_pipeline_buffering = d;}
	int  Get_Pipeline_Buffering() {return(_pipeline_buffering);}

	void Set_Pipeline_Full_Rate_Flag(bool d) {_pipeline_full_rate_flag = d;}
	int  Get_Pipeline_Full_Rate_Flag() {return(_pipeline_full_rate_flag);}

	vcLoopTerminator* Get_Terminator() {return(_terminator);}
	virtual int Get_Max_Iterations_In_Flight() {return(_pipeline_depth);}

	virtual void Print(ostream& ofile);
	virtual void Print_VHDL(ostream& ofile);


	void Print_VHDL_Terminator(vcControlPath* cp, ostream& ofile);
	vcCPPipelinedLoopBody* Get_Loop_Body();

	virtual void Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp);

	virtual bool Check_Structure(); // check that the block is well-formed.


	virtual void Update_Predecessor_Successor_Links();
	void Set_Loop_Termination_Information(string loop_exit, string loop_taken, string loop_body, string loop_back, string exit_from_loop);


	//
	// all except the following:
	// do_while_stmt_4__exit__
	// loop_back
	// condition_done
	// loop_body_done
	// do_while_stmt_4_loop_body
	// loop_exit
	// loop_taken
	// $entry
	//
	virtual int Number_Of_Elements_Reachable_From_Entry()
	{
		return(this->Get_Number_Of_Elements() + 2 - 8);
	}

	//
	// all except the following
	// do_while_stmt_4__entry__
	// loop_back
	//
	virtual int Number_Of_Elements_That_Can_Reach_Exit()
	{
		return(this->Get_Number_Of_Elements() + 2 - 3);
	}
	void Print_Terminator_Dot_Entry(vcControlPath* cp, ostream& ofile);
};



class vcCPForkBlock: public vcCPParallelBlock
{

protected:
  map<vcTransition*, set<vcCPElement*>, vcRoot_Compare > _fork_map;
  map<vcTransition*, set<vcCPElement*>, vcRoot_Compare > _join_map;

  set<vcCPElement*> _forked_elements;
  set<vcCPElement*> _joined_elements;

  vector<pair<vcCPElement*, vcCPElement*> > _redundant_pairs;

public:
  virtual string Kind() {return("vcCPForkBlock");}
  vcCPForkBlock(vcCPBlock* parent, string id);

  virtual void Add_Marked_Join_Point(string& join_name, vector<string>& join_cpe_vec, vector<int>& join_markings) {}
  virtual void Add_Marked_Join_Point(vcTransition* jp, int join_marking, vcCPElement* jre) {}

  virtual void Print(ostream& ofile);
  void Add_Fork_Point(string& fork_name, vector<string>& fork_cpe_vec);
  void Add_Join_Point(string& join_name, vector<string>& join_cpe_vec);


  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m);

  virtual bool Check_Structure(); // check that the block is well-formed.
  virtual void Update_Predecessor_Successor_Links();

  void Precedence_Order(bool reverse_flag, vcCPElement* start_element, vector<vcCPElement*>& precedence_order);
  void Add_Join_Point(vcTransition* jp, vcCPElement* jre);
  void Remove_Join_Point(vcTransition* jp, vcCPElement* jre);
  void Add_Fork_Point(vcTransition* fp, vcCPElement* fre);
  void Remove_Fork_Point(vcTransition* fp, vcCPElement* fre);

  virtual void Eliminate_Redundant_Dependencies();
  virtual void DFS_Forward_Edge_Action(bool reverse_flag,
					deque<vcCPElement*>& dfs_queue, 
					set<vcCPElement*>& on_queue_set,
					vcCPElement* u, vcCPElement* v);
   void All_Pairs_Longest_Paths(map<vcCPElement*,map<vcCPElement*,int> >& distance_map);
   virtual void Remove_Redundant_Arcs(map<vcCPElement*,map<vcCPElement*,int> >& distance_map);

   virtual void Remove_Isolated_Transitions();

};


class vcCPPipelinedForkBlock: public vcCPForkBlock
{
protected:
  map<vcTransition*, set<vcCPElement*>, vcRoot_Compare > _marked_join_map;
  set<vcTransition*> _exported_inputs;
  set<vcTransition*> _exported_outputs;

  int _max_iterations_in_flight;
public: 

  virtual string Kind() {return("vcCPPipelinedForkBlock");}
  vcCPPipelinedForkBlock(vcCPBlock* parent, string id);

  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

public:
  virtual void Add_Marked_Join_Point(string& join_name, vector<string>& join_cpe_vec, vector<int>& join_markings);
  virtual void Add_Marked_Join_Point(vcTransition* jp, int join_marking, vcCPElement* jre);

  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m) ;

  virtual void Eliminate_Redundant_Dependencies();
  virtual void Remove_Redundant_Arcs(map<vcCPElement*,map<vcCPElement*,int> >& distance_map);
  virtual void Remove_Redundant_Reenable_Arcs(map<vcCPElement*,map<vcCPElement*,int> >& distance_map);
  virtual void Remove_Redundant_Reenable_Arcs_Pass2(map<vcCPElement*,map<vcCPElement*,int> >& distance_map);

  void Add_Exported_Input(string internal_id);
  void Add_Exported_Output(string internal_id);
  void Add_Export(string internal_id, bool input_flag);

  void Set_Max_Iterations_In_Flight(int N) {_max_iterations_in_flight = N;}
  virtual int Get_Max_Iterations_In_Flight() {return(_max_iterations_in_flight);}

  virtual bool Relaxed_Entry_Reachability_Checking() {return(true);}
  virtual bool Relaxed_Exit_Reachability_Checking() {return(true);}

  virtual bool Is_Pipelined() {return(true);}
  virtual void Print_Forks_And_Joins(ostream& ofile);
  virtual void Print_Exports(ostream& ofile);
  virtual void Print_VHDL_Export_Cleanup(ostream& ofile);
};

class vcCPPipelinedLoopBody: public vcCPPipelinedForkBlock
{

  vector<vcPhiSequencer*> _phi_sequencers;
  vector<vcTransitionMerge*> _transition_merges;

public:

  vector<vcPhiSequencer*>& Get_Phi_Sequencers() { return _phi_sequencers; }
  vector<vcTransitionMerge*>& Get_Transition_Merges() { return _transition_merges; }

  virtual string Kind() {return("vcCPPipelinedLoopBody");}
  vcCPPipelinedLoopBody(vcCPBlock* parent, string id);

  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  void Print_VHDL_Phi_Sequencers(vcControlPath* cp, ostream& ofile);
  void Print_VHDL_Transition_Merges(vcControlPath* cp, ostream& ofile);

  int Get_Number_Of_Phi_Sequencers()
  {
	return(_phi_sequencers.size());
  }
  vcPhiSequencer* Get_Phi_Sequencer(int idx) 
  {
	vcPhiSequencer* rv = NULL;
	if(idx < _phi_sequencers.size())
	{
		rv = _phi_sequencers[idx];
	}
	return(rv);
  }

  int Get_Number_Of_Transition_Merges()
  {
	return(_transition_merges.size());
  }
  vcTransitionMerge* Get_Transition_Merge(int idx) 
  {
	vcTransitionMerge* rv = NULL;
	if(idx < _transition_merges.size())
	{
		rv = _transition_merges[idx];
	}
	return(rv);
  }

  void Print_Phi_Sequencer_Dot_Entries(vcControlPath* cp, ostream& ofile);
  void Print_Transition_Merge_Dot_Entries(vcControlPath* cp, ostream& ofile);

  virtual void Update_Predecessor_Successor_Links();

  void Add_Phi_Sequencer(string& phi_id, 
				vector<string>& triggers, 
				vector<string>& src_sample_reqs, 
				vector<string>& src_sample_acks, 
				vector<string>& src_update_reqs, 
				vector<string>& src_update_acks, 
				string& phi_sample_req,
				string& phi_sample_ack,
				string& phi_update_req,
				string& phi_update_ack,
				vector<string>& phi_mux_reqs,
				string& phi_mux_ack);
  void Add_Transition_Merge(string& tm_id, vector<string>& in_transition, string& out_transition);

  // for a pipelined loop block some of the elements are not reachable from
  // entry.  In particular, there are 3 predecessors of entry
  // and for each phi statement, there are two places which are not reachable. 
  virtual int Number_Of_Elements_Reachable_From_Entry()
  {
	return(this->Get_Number_Of_Elements()+2 - (3 + (4*_phi_sequencers.size())));
  }
  virtual bool Relaxed_Entry_Reachability_Checking() {return(true);}
  virtual bool Relaxed_Exit_Reachability_Checking() {return(true);}
};


class vcCPPipelinedForkBlock;
class vcControlPath;
class vcCPElementGroup: public vcRoot
{
  vcControlPath* _cp;
  int64_t _group_index;
  int _scc_index;
  set<vcCPElement*> _elements;

  set<vcCPElementGroup*> _successors;
  vector<vcCPElementGroup*> _successor_vector;

  set<vcCPElementGroup*> _predecessors;
  set<vcCPElementGroup*> _marked_predecessors;
  set<vcCPElementGroup*> _marked_successors;
  map<vcCPElementGroup*,int> _marked_successor_delays;
  map<vcCPElementGroup*,int> _marked_predecessor_delays;
  
  bool _has_transition;
  bool _has_place;
  bool _has_input_transition;
  bool _has_output_transition;
  bool _has_dead_transition;
  bool _has_tied_high_transition;
  bool _has_left_open_transition;

  bool _is_join;
  bool _is_fork;
  bool _is_merge;
  bool _is_branch;
  bool _is_delay_element;
  bool _is_left_open;

  bool _is_cp_entry;

  bool _is_bound_as_input_to_cp_function;
  bool _is_bound_as_output_from_cp_function;

  bool _is_bound_as_input_to_region;
  bool _is_bound_as_output_from_region;


  vcTransition* _input_transition;
  vector<vcTransition*> _output_transitions;

  // if this field is not null, then all
  // elements in the group must belong to
  // the same pipelined loop body.
  vcCPBlock* _pipeline_parent;

  vcCPElement* _associated_cp_function;
  vcCPElement* _associated_cp_region;


  bool _bypass_flag;

public:
  bool Get_Has_Input_Transition() { return _has_input_transition; }
  bool Get_Has_Output_Transition() { return _has_output_transition; }
  bool Get_Is_Merge() { return _is_merge; }
  bool Get_Is_Fork() { return _is_fork; }
  vcTransition* Get_Input_Transition() { return _input_transition; }
  vector<vcTransition*>& Get_Output_Transitions() { return _output_transitions; }
  set<vcCPElementGroup*>& Get_Predecessors() { return _predecessors; }
  set<vcCPElementGroup*>& Get_Marked_Predecessors() { return _marked_predecessors; }
  set<vcCPElement*>& Get_Elements() { return _elements; }

  vcCPElementGroup(vcControlPath* cp):vcRoot()
  {
    _cp = cp;
    _has_transition = false;
    _has_place = false;
    _has_input_transition = false;
    _has_output_transition = false;
    _has_dead_transition = false;
    _has_tied_high_transition = false;
    _has_left_open_transition = false;
    _group_index = -1;
    _is_join = false;
    _is_fork = false;
    _is_merge = false;
    _is_branch = false;
    _input_transition = NULL;
    _is_cp_entry = false;
    _is_delay_element = false;
    _is_bound_as_input_to_cp_function = false;
    _is_bound_as_output_from_cp_function = false;
    _is_bound_as_input_to_region = false;
    _is_bound_as_output_from_region = false;
    _pipeline_parent = NULL;
    _associated_cp_function = NULL;
    _associated_cp_region = NULL;
    _bypass_flag = false;
    _is_left_open = false;
    _scc_index = -1; // unassigned..
  }


  bool Is_Pure_Transition_Group();

  bool Has_Predecessor(vcCPElementGroup* g)
  {
	return(_predecessors.find(g) != _predecessors.end());
  }
  bool Has_Successor(vcCPElementGroup* g)
  {
	return(_successors.find(g) != _successors.end());
  }
  bool Has_Marked_Predecessor(vcCPElementGroup* g)
  {
	return(_marked_predecessors.find(g) != _marked_predecessors.end());
  }
  bool Has_Marked_Successor(vcCPElementGroup* g)
  {
	return(_marked_successors.find(g) != _marked_successors.end());
  }

  void Set_Group_Index(int64_t idx)
  {
    _group_index = idx;
  }

  void Set_SCC_Index(int idx)
  {
    _scc_index = idx;
  }

  int Get_SCC_Index()
  {
	return(_scc_index);
  }


  void Add_Successor(vcCPElementGroup* g)
  {
    _successors.insert(g);
  }

  void Generate_Successor_Vector();

  void Add_Predecessor(vcCPElementGroup* g)
  {
    _predecessors.insert(g);
  }

  void Add_Marked_Successor(vcCPElementGroup* g)
  {
    _marked_successors.insert(g);
  }


  void Set_Marked_Successor_Delay(vcCPElementGroup* g, int m)
  {
    _marked_successor_delays[g] = m;
  }
  int  Get_Marked_Successor_Delay(vcCPElementGroup* g);

  void Add_Marked_Predecessor(vcCPElementGroup* g)
  {
    _marked_predecessors.insert(g);
  }
  int  Get_Marked_Predecessor_Delay(vcCPElementGroup* g);

  void Set_Marked_Predecessor_Delay(vcCPElementGroup* g, int m)
  {
    _marked_predecessor_delays[g] = m;
  }

  int64_t Get_Group_Index() {return(_group_index);}
  void Add_Element(vcCPElement* cpe);

  bool Has_Element(vcCPElement* cpe) {return(_elements.find(cpe) != _elements.end());}

  void Set_Is_Bound_As_Input_To_CP_Function(bool v) {this->_is_bound_as_input_to_cp_function = v;}
  bool Get_Is_Bound_As_Input_To_CP_Function() {return(this->_is_bound_as_input_to_cp_function);}

  void Set_Is_Bound_As_Output_From_CP_Function(bool v) {this->_is_bound_as_output_from_cp_function = v;}
  bool Get_Is_Bound_As_Output_From_CP_Function() {return(this->_is_bound_as_output_from_cp_function);}

  void Set_Is_Bound_As_Input_To_Region(bool v) {this->_is_bound_as_input_to_region = v;}
  bool Get_Is_Bound_As_Input_To_Region() {return(this->_is_bound_as_input_to_region);}

  void Set_Is_Bound_As_Output_From_Region(bool v) {this->_is_bound_as_output_from_region = v;}
  bool Get_Is_Bound_As_Output_From_Region() {return(this->_is_bound_as_output_from_region);}

  bool Can_Absorb(vcCPElementGroup* g);
  bool Can_Potentially_Absorb(vcCPElementGroup* g);

  void Print(ostream& ofile);
  void Print_VHDL(ostream& ofile);
  void Print_VHDL_Logger(ostream& ofile);

  void Print_DP_To_CP_VHDL_Link(ostream& ofile);
  void Print_CP_To_DP_VHDL_Link(int idx, ostream& ofile);

  virtual string Get_VHDL_Id();

  virtual string Get_Dot_Id() 
  { 
      string ret_string = "e_" + Int64ToStr(this->Get_Group_Index());
      return(ret_string);
  }

  void Set_Associated_CP_Function(vcCPElement* c) {_associated_cp_function = c;}
  vcCPElement* Get_Associated_CP_Function() {return(_associated_cp_function);}

  void Set_Associated_CP_Region(vcCPElement* c) {_associated_cp_region = c;}
  vcCPElement* Get_Associated_CP_Region() {return(_associated_cp_region);}

  string Generate_Marked_Join_Bypass_String();

  vcCPElement* Get_Top_Element();
  bool Has_Entry_As_Predecessor ();


  friend class vcCPElement;
  friend class vcControlPath;
};

class vcControlPath: public vcCPSeriesBlock
{
  bool _is_pipelined;
  int  _pipeline_depth;
  int  _pipeline_buffering;
  bool _pipeline_full_rate_flag;

  vcModule* _parent_module;
protected:
  set<vcCompatibilityLabel*> _compatibility_label_set;
  vector<vcCPElement*> _bfs_ordered_labels;

  map<vcCompatibilityLabel*, set<vcCompatibilityLabel*> > _label_descendent_map;
  map<vcCompatibilityLabel*, set<vcCompatibilityLabel*> > _compatible_label_map;
  

   
  map<string, vcCompatibilityLabel*> _join_label_map;

  set<vcCPElementGroup*, vcRoot_Compare> _cpelement_groups;
  map<vcCPElement*, vcCPElementGroup*> _cpelement_to_group_map;

  // simple loop blocks have some special things inside them..
  set<vcCPSimpleLoopBlock*> _simple_loop_blocks;

public:
  static int64_t _free_index;

  set<vcCPElementGroup*, vcRoot_Compare>& Get_CPElement_Groups() { return _cpelement_groups; }
  map<vcCPElement*, vcCPElementGroup*>& Get_CPElement_To_Group_Map() { return _cpelement_to_group_map; }
  set<vcCPSimpleLoopBlock*>& Get_Simple_Loop_Blocks() { return _simple_loop_blocks; }

  vcControlPath(string id);
  virtual string Kind() {return("vcControlPath");}

  void  Set_Parent_Module(vcModule* m);
  vcModule* Get_Parent_Module() {return(_parent_module);}

  vcTransition* Find_Transition(vector<string>& hier_ref);
  vcPlace* Find_Place(vector<string>& hier_ref);
  virtual void Print(ostream& ofile);

  void Set_Is_Pipelined(bool v) {_is_pipelined = v;}
  bool Get_Is_Pipelined() {return(_is_pipelined);}

  virtual int Get_Max_Iterations_In_Flight() {return (_pipeline_depth);} 

  void Set_Pipeline_Depth(int d) {_pipeline_depth = d;}
  int  Get_Pipeline_Depth() {return(_pipeline_depth);}

  void Set_Pipeline_Buffering(int d) {_pipeline_buffering = d;}
  int  Get_Pipeline_Buffering() {return(_pipeline_buffering);}

  void Set_Pipeline_Full_Rate_Flag(bool d) {_pipeline_full_rate_flag = d;}
  int  Get_Pipeline_Full_Rate_Flag() {return(_pipeline_full_rate_flag);}

  void Add_Simple_Loop_Block(vcCPSimpleLoopBlock* slb) {_simple_loop_blocks.insert(slb);}

  vcCPElementGroup* Make_New_Group();
  void Delete_Group(vcCPElementGroup* g);
  vcCPElementGroup* Get_Group(vcCPElement* cpe);

  virtual bool Is_Control_Path() { return (true); }

  void Construct_Reduced_Group_Graph();
  int Fix_Combinational_Loops(int pass_index);

  void Identify_Nucleii(set<vcCPElementGroup*>& nucleii);
  void Reduce_From_Nucleus(vcCPElementGroup* nucleus, set<vcCPElementGroup*>& absorbed_elements,
						set<vcCPElementGroup*>& unabsorbed_elements);
  void Last_Gasp_Reduce();

  void Index_Groups();

  void Reduce_CPElement_Group_Graph();
  void Collapse_Pure_Transition_Components();
  void Collapse_Pure_Transition_Set(set<void*>& tset);
  void Merge_Groups(vcCPElementGroup* part, vcCPElementGroup* whole);

  void Add_To_Group(vcCPElement* cpe, vcCPElementGroup* group);
  void Connect_Groups(vcCPElementGroup* from, vcCPElementGroup* to, bool marked_flag, int marked_delay);
  void Print_Groups(ostream& ofile);


  virtual void Get_Hierarchical_Ref(vector<string>& ref_vec) {return;}
  virtual void Compute_Compatibility_Labels();
  void Connect_Compatibility_Labels();

  vcCompatibilityLabel* Make_Compatibility_Label(string id);
  void Delete_Compatibility_Label(vcCompatibilityLabel* nl);


  virtual void Print_Structure(ostream& ofile) {this->vcCPSeriesBlock::Print_Structure(ofile);}
  void Print_Compatibility_Labels(ostream& ofile);

  bool Are_Compatible(vcCompatibilityLabel* u, vcCompatibilityLabel* v);
  bool Are_Compatible(vector<vcCompatibilityLabel*>& l1, vector<vcCompatibilityLabel*>& l2);

  bool Lesser(vcCompatibilityLabel* u, vcCompatibilityLabel* v);
  bool Greater(vcCompatibilityLabel* u, vcCompatibilityLabel* v);

  virtual void Print_VHDL_Start_Symbol_Assignment(ostream& ofile);
  virtual void Print_VHDL_Exit_Symbol_Assignment(ostream& ofile);

  virtual void Print_VHDL_Optimized(ostream& ofile);

  vcCompatibilityLabel* Find_Or_Map_Join_Label(string sid, vcCompatibilityLabel* t)
  {
    if(_join_label_map.find(sid) == _join_label_map.end())
      {
	_join_label_map[sid] = t;
	return(t);
      }
    else
      {
	return(_join_label_map[sid]);
      }
  }

  void Update_Compatibility_Map();
  bool Look_Back_For_Compatibility(vcCompatibilityLabel* from_here, 
				   vcCompatibilityLabel* check_against,
				   set<vcCompatibilityLabel*>& visited_set);
  void Mark_As_Compatible(set<vcCompatibilityLabel*>& uset, set<vcCompatibilityLabel*>& vset);
  void Print_Compatibility_Map(ostream& ofile);

  virtual string Get_Predecessor_Exit_Symbol()
  {
    assert(0);
  }
  virtual string Get_Successor_Start_Symbol()
  {
    assert(0);
  }

  void Update_Group_Bypass_Flags();

  virtual void Print_VHDL_Export_Cleanup(ostream& ofile); // ugly fixups..
  virtual void Print_Reduced_Control_Path_As_Dot_File(ostream& ofile);

  virtual void Update_Predecessor_Successor_Links();
  virtual bool Check_Structure();
  void Print_VHDL_Export_Cleanup_Optimized(ostream& ofile);

  void Eliminate_Dead_Groups();

  void Find_Zero_Delay_Successors_Via_DPE(vcTransition* t, set<vcCPElement*>& zero_delay_successors);
  void Find_Zero_Delay_Successors_Via_CP_Function(vcTransition* t, set<vcCPElement*>& zero_delay_successors);
  void Include_DPE_Elements_Bound_With_Ack_Transition(vcTransition* t, set<vcDatapathElement*>& dpe_set);

  // ensure correct connectivity.
  bool Check_Group_Graph_Structure();
  void Identify_Strongly_Connected_Components();
  void Add_To_Reverse_Map(map<vcTransition*, vcCPElementGroup*>& transition_group_map,
			vcCPElementGroup* g);

};


class vcControlPathPipelined: public vcControlPath
{
public:
  vcControlPathPipelined(string id):vcControlPath(id)
  {
  }
  virtual string Kind() {return("vcControlPathPipelined");}
  virtual bool Is_Pipeline() { return (true); }
  virtual void Compute_Compatibility_Labels();
  
  virtual bool Check_Structure();
  virtual void Print_VHDL_Optimized(ostream& ofile)
  {
    assert(0);
  }


};

struct vcCompatibilityLabel_Compare:public binary_function
  <vcCompatibilityLabel*, vcCompatibilityLabel*, bool >
{
  bool operator() (vcCompatibilityLabel*, vcCompatibilityLabel*) const;
};

#endif
