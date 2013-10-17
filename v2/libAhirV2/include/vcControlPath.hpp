#ifndef _vC_CP_H_
#define _vC_CP_H_
#include <vcIncludes.hpp>
class vcRoot;
class vcControlPath;
class vcCompatibilityLabel;
class vcCPPipelinedLoopBody;
class vcCPPipelinedForkBlock;
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

  vcCPPipelinedForkBlock* _pipeline_parent;
public:

  vcCPElement(vcCPElement* parent, string id);

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

  // return true if some ancestral parent is a pipelined loop body..
  void  Set_Pipeline_Parent()
  {
	this->_pipeline_parent = NULL;
	vcCPElement* p = this->Get_Parent();
	while(p != NULL)
	{
		if(p->Is("vcCPPipelinedLoopBody") || p->Is("vcCPPipelinedForkBlock"))
		{
			this->_pipeline_parent = (vcCPPipelinedForkBlock*) p;
			break;
		}
		p = p->Get_Parent();
	}
  }

  vcCPPipelinedForkBlock* Get_Pipeline_Parent() {return(_pipeline_parent);}

  virtual void Print_VHDL_Bindings(vcControlPath* cp, ostream& ofile) {assert(0);}
  virtual bool Is_Pipelined() {return(false);}
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
  bool Get_Is_Input() { return(_is_input);}
  bool Get_Is_Output() { return(_is_output);}

  void Set_Is_Dead(bool v) {this->_is_dead = v;}
  bool Get_Is_Dead() {return(this->_is_dead);}


  void Set_Is_Delay_Element(bool v) {this->_is_delay_element = v;}
  bool Get_Is_Delay_Element() {return(this->_is_delay_element);}

  void Set_Is_Tied_High(bool v) {this->_is_tied_high = v;}
  bool Get_Is_Tied_High() {return(this->_is_tied_high);}

  void Set_Is_Entry_Transition(bool v) {this->_is_entry_transition = v;}
  bool Get_Is_Entry_Transition() {return(this->_is_entry_transition);}

  bool Get_Is_Linked_To_Non_Local_Dpe() {return(this->_is_linked_to_non_local_dpe);}


  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  virtual string Kind() {return("vcTransition");}

  vector<pair<vcDatapathElement*,vcTransitionType> >&  Get_DP_Link() {return(this->_dp_link);}

  friend class ControlPath;

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

  vcTransition* _entry;
  vcTransition* _exit;

public:
  vcCPBlock(vcCPBlock* parent, string id);

  virtual void Add_CPElement(vcCPElement* cpe);
  vcCPElement* Find_CPElement(string cname);
  virtual void Print(ostream& ofile) {assert(0);}
  void Print_Elements(ostream& ofile);

  virtual bool Is_Block() { return (true); }

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
};

class vcPhiSequencer: public vcCPElement
{
  int _place_capacity;

  vector<vcTransition*> _selects;
  vector<vcTransition*> _enables;
  vector<vcTransition*> _reqs;
  vcTransition* _ack;
  vcTransition* _done;

public:
  vcPhiSequencer(vcCPElement* prnt, string id);
  void Add_Select(vcTransition* s) { _selects.push_back(s); }
  void Add_Enable(vcTransition* s) { _enables.push_back(s); }
  void Add_Req(vcTransition* s) { _reqs.push_back(s); }
  void Set_Ack(vcTransition* p) { _ack = p; }
  void Set_Done(vcTransition* p) { _done = p; }
 
  void Set_Place_Capacity(int n) {_place_capacity = n;}
  int Get_Place_Capacity() {return(_place_capacity);}

  int Get_Number_Of_Selects() { return(_selects.size()); }
  vcTransition* Get_Select(int idx) 
  { 
    if((idx >= 0) && (idx < _selects.size()))
      return(_selects[idx]);
    else
      return(NULL);
  }

  int Get_Number_Of_Enables() { return(_enables.size()); }
  vcTransition* Get_Enable(int idx) 
  { 
    if((idx >= 0) && (idx < _enables.size()))
      return(_enables[idx]);
    else
      return(NULL);
  }

  int Get_Number_Of_Reqs() { return(_reqs.size()); }
  vcTransition* Get_Req(int idx) 
  { 
    if((idx >= 0) && (idx < _reqs.size()))
      return(_reqs[idx]);
    else
      return(NULL);
  }
  
  vcTransition* Get_Ack()
  {return(_ack);}
  vcTransition* Get_Done() 
  {return(_done);}

  void Print(ostream& ofile);
  void Print_VHDL(vcControlPath* cp, ostream& ofile);
  void Print_Dot_Entry(vcControlPath* cp, ostream& ofile);

  virtual void Update_Predecessor_Successor_Links();
};


class vcLoopTerminator: public vcCPElement
{
  vcCPElement* _loop_exit;
  vcCPElement* _loop_taken;
  vcCPElement* _loop_body;
  vcCPElement* _loop_back;
  vcCPElement* _exit_from_loop;

 public:

   vcLoopTerminator(vcCPElement* prnt, string id):vcCPElement(prnt,id) 
   {
	_loop_exit = NULL;
	_loop_taken = NULL;
	_loop_body = NULL;
	_loop_back = NULL;
	_exit_from_loop = NULL;
   }

   friend class vcCPSimpleLoopBlock;
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

  void Add_Exported_Input(string internal_id);
  void Add_Exported_Output(string internal_id);
  void Add_Export(string internal_id, bool input_flag);

  void Set_Max_Iterations_In_Flight(int N) {_max_iterations_in_flight = N;}
  int Get_Max_Iterations_In_Flight() {return(_max_iterations_in_flight);}

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

  virtual string Kind() {return("vcCPPipelinedLoopBody");}
  vcCPPipelinedLoopBody(vcCPBlock* parent, string id);

  virtual void Print(ostream& ofile);
  virtual void Print_VHDL(ostream& ofile);

  void Print_VHDL_Phi_Sequencers(vcControlPath* cp, ostream& ofile);
  void Print_VHDL_Transition_Merges(vcControlPath* cp, ostream& ofile);

  void Print_Phi_Sequencer_Dot_Entries(vcControlPath* cp, ostream& ofile);
  void Print_Transition_Merge_Dot_Entries(vcControlPath* cp, ostream& ofile);

  virtual void Update_Predecessor_Successor_Links();

  void Add_Phi_Sequencer(string& phi_id, vector<string>& selects, vector<string>& enables, string& ack, vector<string>& reqs, string& done);
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
  int64_t _group_index;
  set<vcCPElement*> _elements;

  set<vcCPElementGroup*> _successors;
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
  vcCPPipelinedForkBlock* _pipeline_parent;

  vcCPElement* _associated_cp_function;
  vcCPElement* _associated_cp_region;


  bool _bypass_flag;

public:
  vcCPElementGroup():vcRoot()
  {
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
  }

  void Set_Group_Index(int64_t idx)
  {
    _group_index = idx;
  }

  void Add_Successor(vcCPElementGroup* g)
  {
    _successors.insert(g);
  }

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

  void Print(ostream& ofile);
  void Print_VHDL(ostream& ofile);

  void Print_DP_To_CP_VHDL_Link(ostream& ofile);
  void Print_CP_To_DP_VHDL_Link(int idx, ostream& ofile);

  virtual string Get_VHDL_Id() 
  { 
      string ret_string = "cp_elements(" + Int64ToStr(this->Get_Group_Index()) + ")"; 
      return(ret_string);
  }

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

  friend class vcCPElement;
  friend class vcControlPath;
};

class vcControlPath: public vcCPSeriesBlock
{

  bool _is_pipelined;
  int  _pipeline_depth;
  int  _pipeline_buffering;
  bool _pipeline_full_rate_flag;

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

  vcControlPath(string id);
  virtual string Kind() {return("vcControlPath");}

  vcTransition* Find_Transition(vector<string>& hier_ref);
  vcPlace* Find_Place(vector<string>& hier_ref);
  virtual void Print(ostream& ofile);

  void Set_Is_Pipelined(bool v) {_is_pipelined = v;}
  bool Get_Is_Pipelined() {return(_is_pipelined);}

  void Set_Pipeline_Depth(int d) {_pipeline_depth = d;}
  int  Get_Pipeline_Depth() {return(_pipeline_depth);}

  void Set_Pipeline_Buffering(int d) {_pipeline_buffering = d;}
  int  Get_Pipeline_Buffering() {return(_pipeline_buffering);}

  void Set_Pipeline_Full_Rate_Flag(bool d) {_pipeline_full_rate_flag = d;}
  int  Get_Pipeline_Full_Rate_Flag() {return(_pipeline_full_rate_flag);}

  void Add_Simple_Loop_Block(vcCPSimpleLoopBlock* slb) {_simple_loop_blocks.insert(slb);}

  vcCPElementGroup* Make_New_Group();
  vcCPElementGroup* Delete_Group(vcCPElement* g);
  vcCPElementGroup* Get_Group(vcCPElement* cpe);

  virtual bool Is_Control_Path() { return (true); }

  void Construct_Reduced_Group_Graph();
  void Reduce_CPElement_Group_Graph();
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
