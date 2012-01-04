#ifndef _vC_CP_H_
#define _vC_CP_H_
#include <vcIncludes.hpp>
class vcRoot;
class vcControlPath;
class vcCompatibilityLabel;
class vcCPElement: public vcRoot
{

protected:
  int64_t _index;
  vcCPElement* _parent;
  vector<vcCPElement*> _predecessors;
  vector<vcCPElement*> _successors;
  vcCompatibilityLabel* _compatibility_label;

public:

  vcCPElement(vcCPElement* parent, string id);

  void Add_Successor(vcCPElement* cpe);
  void Add_Predecessor(vcCPElement* cpe);
  void Remove_Successor(vcCPElement* cpe);
  void Remove_Predecessor(vcCPElement* cpe);
  virtual bool Is_Pipeline() { return (false); }
  virtual bool Is_Block() { return (false); }
  virtual bool Is_Control_Path() { return (false); }


  virtual int Get_Number_Of_Predecessors() { return(this->_predecessors.size());}
  int Get_Number_Of_Successors() {return(this->_successors.size());}

  vcCPElement* Get_Successor(int idx) {return(this->_successors[idx]);}

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

  virtual void Print_Successors(ostream& ofile);
  virtual void Print_Structure(ostream& ofile) {}

  //  string Get_VHDL_Id() {return("cp_" + IntToStr(this->Get_Index()));}
  string Get_VHDL_Id() {return(To_VHDL(this->Get_Id()+ "_" + Int64ToStr(this->Get_Index())));}

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
    _DEAD_TRANSITION
  };
class vcTransition: public vcCPElement
{
  vector<pair<vcDatapathElement*,vcTransitionType> > _dp_link;
  bool _is_input;
  bool _is_output;
  bool _is_dead;
  bool _is_entry_transition;

  bool _is_linked_to_non_local_dpe;

public:
  vcTransition(vcCPElement* parent, string id);
  void Add_DP_Link(vcDatapathElement* dpe,vcTransitionType ltype);

  virtual bool Is_Transition() {return(true);}
  bool Get_Is_Input() { return(_is_input);}
  bool Get_Is_Output() { return(_is_output);}

  void Set_Is_Dead(bool v) {this->_is_dead = v;}
  bool Get_Is_Dead() {return(this->_is_dead);}

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

};

class vcPlace: public vcCPElement
{
  unsigned int _initial_marking;
public:
  vcPlace(vcCPElement* parent, string id, unsigned int init_marking);
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcPlace");}
  virtual bool Is_Place() {return(true);}

  virtual void Print_VHDL(ostream& ofile);
  virtual void Construct_CPElement_Group_Graph_Vertices(vcControlPath* cp);

  friend class ControlPath;

};

class vcCPBlock: public vcCPElement
{

protected:
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

class vcCPForkBlock: public vcCPParallelBlock
{
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

  virtual bool Check_Structure(); // check that the block is well-formed.
  virtual void Compute_Compatibility_Labels(vcCompatibilityLabel* in_label, vcControlPath* m);
  virtual void Update_Predecessor_Successor_Links();
  void Precedence_Order(bool reverse_flag, vcCPElement* start_element, vector<vcCPElement*>& precedence_order);
  void Add_Join_Point(vcTransition* jp, vcCPElement* jre);
  void Remove_Join_Point(vcTransition* jp, vcCPElement* jre);
  void Add_Fork_Point(vcTransition* fp, vcCPElement* fre);
  void Remove_Fork_Point(vcTransition* fp, vcCPElement* fre);

  void Eliminate_Redundant_Dependencies();
  virtual void DFS_Forward_Edge_Action(bool reverse_flag,
					deque<vcCPElement*>& dfs_queue, 
					set<vcCPElement*>& on_queue_set,
					vcCPElement* u, vcCPElement* v);

};


class vcControlPath;
class vcCPElementGroup: public vcRoot
{
  int64_t _group_index;
  set<vcCPElement*> _elements;

  set<vcCPElementGroup*> _successors;
  set<vcCPElementGroup*> _predecessors;

  bool _has_transition;
  bool _has_place;
  bool _has_input_transition;
  bool _has_output_transition;
  bool _has_dead_transition;

  bool _is_join;
  bool _is_fork;
  bool _is_merge;
  bool _is_branch;

  bool _is_cp_entry;

  vcTransition* _input_transition;
  vector<vcTransition*> _output_transitions;

public:
  vcCPElementGroup():vcRoot()
  {
    _has_transition = false;
    _has_place = false;
    _has_input_transition = false;
    _has_output_transition = false;
    _has_dead_transition = false;
    _group_index = -1;
    _is_join = false;
    _is_fork = false;
    _is_merge = false;
    _is_branch = false;
    _input_transition = NULL;
    _is_cp_entry = false;
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

  int64_t Get_Group_Index() {return(_group_index);}
  void Add_Element(vcCPElement* cpe);


  bool Can_Absorb(vcCPElementGroup* g);
  friend class vcCPElement;

  void Print(ostream& ofile);
  void Print_VHDL(ostream& ofile);

  void Print_DP_To_CP_VHDL_Link(ostream& ofile);
  void Print_CP_To_DP_VHDL_Link(int idx, ostream& ofile);

  friend class vcControlPath;
};

class vcControlPath: public vcCPSeriesBlock
{
protected:
  set<vcCompatibilityLabel*> _compatibility_label_set;
  vector<vcCPElement*> _bfs_ordered_labels;

  map<vcCompatibilityLabel*, set<vcCompatibilityLabel*> > _label_descendent_map;
  map<vcCompatibilityLabel*, set<vcCompatibilityLabel*> > _compatible_label_map;


  map<string, vcCompatibilityLabel*> _join_label_map;

  set<vcCPElementGroup*, vcRoot_Compare> _cpelement_groups;
  map<vcCPElement*, vcCPElementGroup*> _cpelement_to_group_map;

public:
  static int64_t _free_index;

  vcControlPath(string id);
  virtual string Kind() {return("vcControlPath");}

  vcTransition* Find_Transition(vector<string>& hier_ref);
  vcPlace* Find_Place(vector<string>& hier_ref);
  virtual void Print(ostream& ofile);

  vcCPElementGroup* Make_New_Group();
  vcCPElementGroup* Delete_Group(vcCPElement* g);
  vcCPElementGroup* Get_Group(vcCPElement* cpe);

  virtual bool Is_Control_Path() { return (true); }

  void Construct_Reduced_Group_Graph();
  void Reduce_CPElement_Group_Graph();
  void Merge_Groups(vcCPElementGroup* part, vcCPElementGroup* whole);

  void Add_To_Group(vcCPElement* cpe, vcCPElementGroup* group);
  void Connect_Groups(vcCPElementGroup* from, vcCPElementGroup* to);
  void Print_Groups(ostream& ofile);


  virtual void Get_Hierarchical_Ref(vector<string>& ref_vec) {return;}
  virtual void Compute_Compatibility_Labels();
  void Connect_Compatibility_Labels();

  vcCompatibilityLabel* Make_Compatibility_Label(string id);
  void Delete_Compatibility_Label(vcCompatibilityLabel* nl);

  virtual bool Check_Structure();
  virtual void Print_Structure(ostream& ofile) {this->vcCPSeriesBlock::Print_Structure(ofile);}
  void Print_Compatibility_Labels(ostream& ofile);

  bool Are_Compatible(vcCompatibilityLabel* u, vcCompatibilityLabel* v);
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

  virtual string Get_Exit_Symbol() 
  {
    return("fin_ack_symbol");
  }
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
