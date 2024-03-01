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
#ifndef _Aa_Statement__
#define _Aa_Statement__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>

class AaStatementSequence;
class AaPlaceStatement;
class AaDoWhileStatement;
class AaModule;

// *******************************************  STATEMENT etc. ************************************
// base class for statements
// A statement may specify a set of targets which act as
// implicit variable declarations.  These need to be 
// mapped in the containing scope
class AaStatement: public AaScope
{
 protected:
  // for pretty printing..
  unsigned int _tab_depth;

  set<AaRoot*> _target_objects;
  set<AaRoot*> _source_objects;

  int _index_in_sequence;

  AaSimpleObjectReference* _guard_expression;
  bool _guard_complement;

  AaStatement* _pipeline_parent;

  // mark
  string _mark;
  set<AaStatement*> _synch_statements;
  map<AaStatement*,int> _marked_delay_statements;
  map<AaStatement*,bool> _synch_update_flag_map;

  map<string,AaStatement*> _marked_statement_map;

  int _longest_path;
  bool _keep_flag;

 public:
  AaStatement(AaScope* scope);
  
  virtual void Set_Mark(string mid) {_mark = mid;}
  virtual string Get_Mark() {return(_mark);}

  virtual void Set_Keep_Flag(bool v) {_keep_flag = v;}
  virtual bool Get_Keep_Flag() {return(_keep_flag);}

  virtual void Mark_Statement(string mid, AaStatement* stmt);

  virtual int Get_Buffering() {return(1);}
  virtual void Set_Buffering(int b) {}

  virtual AaModule* Get_Module();

  virtual AaStatement* Get_Marked_Statement(string mark)
  {
	map<string,AaStatement*>::iterator miter = _marked_statement_map.find(mark);
	if(miter != _marked_statement_map.end())
		return((*miter).second);
	else
		return(NULL);
  }
  virtual void Add_Synch_Or_Marked_Delay(bool synch_flag, string syid, int delay_value,
						bool update_flag)
  {
	if(this->Get_Scope()->Is_Statement())
	{
		AaStatement* ss = (AaStatement*) this->Get_Scope();
		AaStatement* synch = ss->Get_Marked_Statement(syid);
		if(synch != NULL)
		{
			if(synch_flag)
			{
				_synch_statements.insert(synch);
				_synch_update_flag_map[synch] = update_flag;
			}
			else
				_marked_delay_statements[synch] = delay_value;

	
		}
	}	
  }
  virtual bool Is_Phi_Statement() {return(false);}
  virtual void Write_VC_Synch_Dependency(set<AaRoot*>& visited_elements, bool pipeline_flag, ostream& ofile);
  virtual void Set_Pipeline_Parent(AaStatement* dws) {_pipeline_parent = dws;}
  AaStatement* Get_Pipeline_Parent() {return(_pipeline_parent);}

  // return implicit target with supplied name, NULL if none found.
  virtual AaSimpleObjectReference* Get_Implicit_Target(string tgt_name) {assert(0);}

  virtual void Set_Guard_Expression(AaSimpleObjectReference* oref);
  virtual void Replace_Guard_Expression(AaSimpleObjectReference* oref);

  virtual AaExpression* Get_Guard_Expression()
  {
	return(_guard_expression);
  }

  virtual void Set_Guard_Complement(bool v)
  {
	_guard_complement = v;
  }
  virtual bool Get_Guard_Complement()
  {
	return(_guard_complement);
  }

  virtual string Get_VC_Guard_String();

  virtual string Get_VC_Synch_Transition_Name(bool& has_delay);

  virtual void Map_Target(AaObjectReference* obj_ref);

  virtual string Tab();

  virtual void Set_Tab_Depth(unsigned int td) { this->_tab_depth = td; }
  virtual unsigned int Get_Tab_Depth() { return(this->_tab_depth); }
  virtual void Increment_Tab_Depth() { this->_tab_depth += 1; }

  virtual bool Is_Statement() { return(true);}
  virtual bool Is_Assignment_Statement() { return(false);}
  virtual bool Is_Call_Statement() {return(false);}
  virtual bool Is_Control_Flow_Statement() {return(false);}
  virtual bool Is_Block_Statement() {return(false);}


  void Set_Index_In_Sequence(int id) {this->_index_in_sequence = id;}
  int Get_Index_In_Sequence() {return(this->_index_in_sequence);}

  virtual void Coalesce_Storage() {}

  ~AaStatement();

  virtual string Kind() {return("AaStatement");}
  virtual void Map_Targets() { assert(0);}
  virtual void Map_Source_References() { assert(0);}

  bool Is_Dependent_On_Phi();

  virtual string Get_C_Name() {assert(0); }

  virtual string Get_C_Inner_Wrap_Function_Name() { return("_" + this->Get_C_Name() + "_"); }
  virtual string Get_C_Outer_Wrap_Function_Name() { return(this->Get_C_Name()); }
  
  virtual bool Can_Block(bool pipeline_flag);
  virtual void Write_VC_Constant_Declarations(ostream& ofile) {};

  
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile) { assert(0); }
  virtual void PrintC_Implicit_Declarations(ofstream& ofile) { }

  virtual string Get_Line_Directive()
  {
    return(string("#line ") + IntToStr(this->Get_Line_Number()) + " \"" + this->Get_File_Name() + "\"\n");
  }

  virtual string Get_VC_Name()
  {
    string ret_string = "stmt_" + Int64ToStr(this->Get_Index());
    return(ret_string);
  }

  virtual void Write_VC_Control_Path(ostream& ofile) { assert(0);}
  virtual void Write_VC_Control_Path(string sink_link, ostream& ofile) { assert(0);}
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile) {assert(0);}
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<AaMemorySpace*,vector<AaRoot*> >& ls_map,
					       map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
						AaRoot* barrier,
					       ostream& ofile) {assert(0);}
  virtual void Write_VC_Control_Path_Optimized(string sink_link, ostream& ofile) { assert(0);}

  virtual void Write_VC_Pipe_Declarations(ostream& ofile) {}
  virtual void Write_VC_Memory_Space_Declarations(ostream& ofile) {}
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile) {}
  virtual void Write_VC_Wire_Declarations(ostream& ofile) {}
  virtual void Write_VC_Datapath_Instances(ostream& ofile) {}
  virtual void Write_VC_Links(string hier_id, ostream& ofile) {}
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile) {}

  virtual void Propagate_Constants() {}

  virtual string Get_VC_Entry_Place_Name() { return(this->Get_VC_Name() + "__entry__");}
  virtual string Get_VC_Exit_Place_Name() { return(this->Get_VC_Name() + "__exit__");}

  virtual string Get_VC_Entry_Transition_Name() { return(this->Get_VC_Name() + "__entry__");}
  virtual string Get_VC_Entry_Active_Transition_Name() { return(this->Get_VC_Name() + "__entry__");}
  virtual string Get_VC_Exit_Transition_Name() { return(this->Get_VC_Name() + "__exit__");}

  void Propagate_Addressed_Object_Representative(AaStorageObject* obj);

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places) {} // do nothing.

  void Write_VC_RAW_Release_Dependencies(AaExpression* expr, set<AaRoot*>& visited_elements);

  virtual string Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
  {
    // these need to be defined for each type of (relevant) statement
    // (the Assignment, Phi and Call statements).
    assert(0);
  }

  //
  // The transition which enables the update of the results
  // of this statement (Note that this may be part of the
  // source of an assignment statement).
  //
  virtual string Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
  {
    // these need to be defined for each type of (relevant) statement
    // (the Assignment, Phi and Call statements).
    assert(0);
  }

  virtual string Get_Name() {return(this->Get_VC_Name());}

  virtual bool Is_Part_Of_Fullrate_Pipeline();

  virtual void Set_Pipeline_Depth(int v){assert(0);}
  virtual int Get_Pipeline_Depth() {assert(0);}

  virtual void Set_Pipeline_Buffering(int v) {assert(0);}
  virtual int Get_Pipeline_Buffering() {assert(0);}

  virtual void Set_Pipeline_Full_Rate_Flag(bool v) {assert(0);}
  virtual bool Get_Pipeline_Full_Rate_Flag() {assert(0);}

  void Print_Adjacency_Map( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map);
  virtual void Initialize_Visited_Elements(set<AaRoot*>& visited_elements)
  {
	// do nothing.	
  }
  virtual void Equalize_Paths_For_Pipelining();
  virtual void Calculate_And_Update_Longest_Path();
  virtual int Find_Longest_Paths(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		  set<AaRoot*>& visited_elements,
		  map<AaRoot*, int>& longest_paths_from_root_map);
  virtual void Set_Longest_Path(int lp) {_longest_path = lp;}
  virtual int Get_Longest_Path() {return(_longest_path);}

  void Add_Delayed_Versions(AaRoot* curr, 
		  map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		  set<AaRoot*>& visited_elements, 
		  map<AaRoot*, int>& longest_paths_from_root_map,
		  AaStatementSequence* stmt_sequence);
  virtual void Add_Delayed_Versions( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map) 
  {
	assert(0);
  }
  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
	{ assert(0);}
  void Update_Marked_Delay_Adjacencies(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
				set<AaRoot*>& visited_elements);
  void Print_Slacks(set<AaRoot*>& visited_elements,
	map<AaRoot*, vector< pair<AaRoot*, int> > > adjacency_map,
	map<AaRoot*, int> longest_paths_from_root_map);

   virtual string Get_C_Macro_Name();
   virtual string Get_C_Mutex_Name();
   virtual string Get_Export_Declare_Macro();
   virtual string Get_Export_Apply_Macro();
   virtual string Get_C_Preamble_Macro_Name();
   virtual string Get_C_Postamble_Macro_Name();

   //
   // defined only for assignment and call statements.
   //
   virtual void Set_Is_Volatile(bool v) {assert(0);}

   // only assignment/calls can be volatile.
   virtual bool Get_Is_Volatile()       {return(false);}

   //
   // if combinational, then find the root source expressions on
   // which the outputs of this statement depend.
   //
   virtual void Collect_Root_Sources(set<AaRoot*>& root_sources) {};


   //
   // volatile statements should not depend 
   // on anything which is indexed higher than
   // the statement.
   //
   virtual void Check_Volatility_Ordering_Condition();
   virtual bool Is_Part_Of_Pipelined_Module();
  
   virtual bool Is_Orphaned() {return(false);}
  virtual bool Can_Be_Combinationalized() {return(false);}
};

// statement sequence (is used in block statements which lead to programs)
class AaStatementSequence: public AaScope
{
  vector<AaStatement*> _statement_sequence;
  AaStatement* _pipeline_parent;
 public:

  AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence);
  ~AaStatementSequence();

  virtual void PrintC(ofstream& srcfile, ofstream& headerfile)
  {
	for(int i = 0, imax = _statement_sequence.size(); i < imax; i++)
		_statement_sequence[i]->PrintC(srcfile, headerfile);
  }
  virtual void PrintC_Implicit_Declarations(ofstream& ofile)
  {
	for(int i = 0, imax = _statement_sequence.size(); i < imax; i++)
		_statement_sequence[i]->PrintC_Implicit_Declarations(ofile);
  }

  unsigned int Get_Statement_Count() { return this->_statement_sequence.size(); }
  AaStatement* Get_Statement(unsigned int indx) 
  { 
    if(indx < this->Get_Statement_Count())
      return (this->_statement_sequence[indx]);
    else
      return(NULL);
  }

  bool Can_Block(bool pipeline_flag);

  void Renumber_Statements()
  {
	for(int idx =0, fidx = _statement_sequence.size(); idx < fidx; idx++)
	{
		_statement_sequence[idx]->Set_Index_In_Sequence(idx);
	}
  }

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaStatementSequence");}

  void Set_Pipeline_Parent(AaStatement* dws)
  {
    this->_pipeline_parent = dws;
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Set_Pipeline_Parent(dws);
  }
  virtual void Map_Targets() 
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Map_Targets();
  }
  virtual void Map_Source_References() 
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Map_Source_References();
  }
  virtual void Coalesce_Storage()
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Coalesce_Storage();
  }
  virtual void Increment_Tab_Depth()
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Increment_Tab_Depth();
  }

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places);

  virtual void Write_VC_Control_Path(ostream& ofile); 
  void Write_VC_Control_Path_Optimized(ostream& ofile);

  virtual void Write_VC_Pipe_Declarations(ostream& ofile);
  virtual void Write_VC_Memory_Space_Declarations(ostream& ofile);
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  AaStatement* Get_Next_Statement(AaStatement* stmt);
  AaStatement* Get_Previous_Statement(AaStatement* stmt);

  virtual void Propagate_Constants()
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Propagate_Constants();
  }

  virtual void Write_VC_Constant_Declarations(ostream& ofile)
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Write_VC_Constant_Declarations(ofile);
  }

  virtual string Get_VC_Name()
  {
    assert(this->_statement_sequence.size() > 0);
    AaStatement* first = this->_statement_sequence[0];
    AaStatement* last = this->_statement_sequence[this->_statement_sequence.size() -1];

    if(first == last)
      return(first->Get_VC_Name());
    else
      return(first->Get_VC_Name() + "_to_" + last->Get_VC_Name());
  };

  virtual string Get_VC_Entry_Place_Name()
  {
    assert(this->_statement_sequence.size() > 0);
    AaStatement* first = this->_statement_sequence[0];
    AaStatement* last = this->_statement_sequence[this->_statement_sequence.size() -1];

    if(first == last)
      return(first->Get_VC_Entry_Place_Name());
    else
      return(this->Get_VC_Name() + "__entry__");
  }

  virtual string Get_VC_Exit_Place_Name()
  {
    assert(this->_statement_sequence.size() > 0);
    AaStatement* first = this->_statement_sequence[0];
    AaStatement* last = this->_statement_sequence[this->_statement_sequence.size() -1];

    if(first == last)
      return(first->Get_VC_Exit_Place_Name());
    else
      return(this->Get_VC_Name() + "__exit__");
  }

  void Write_VC_Control_Path_As_Fork_Block(bool pipe_flag, string region_id, ostream& ofile);

  void Insert_Statements_After(AaStatement* pred, vector<AaStatement*>& nstmt);
  void Insert_Statements_Before(AaStatement* succ, vector<AaStatement*>& nstmt);
  void Delete_Statement(AaStatement* stmt);

};

// null statement
class AaNullStatement: public AaStatement
{
 public:
  AaNullStatement(AaScope* parent_tpr);
  ~AaNullStatement();

  virtual void Print(ostream& ofile) { ofile << this->Tab() << "$null" << endl; }
  virtual string Kind() {return("AaNullStatement");}
  virtual void Map_Targets () {} // do nothing
  virtual void Map_Source_References() {} // do nothing

  virtual void PrintC(ofstream& srcfile, ofstream& headerfile)
  {
    srcfile << "/* null */ ";
    srcfile <<  ";" << endl;
  }
  virtual string Get_C_Name()
  {
    return("_null_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual bool Is_Null_Like_Statement() {return(true);}

  virtual bool Can_Block(bool pipeline_flag) { return(false); }
  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
  {
	// do nothing..
  }
};

// barrier statement
class AaBarrierStatement: public AaNullStatement
{
 public:
  AaBarrierStatement(AaScope* parent_tpr);
  ~AaBarrierStatement();

  virtual void Print(ostream& ofile) { ofile << this->Tab() << "$barrier" << endl; }
  virtual string Kind() {return("AaBarrierStatement");}
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile)
  {
    srcfile << "/* barrier */ ";
    srcfile <<  ";" << endl;
  }
  virtual string Get_C_Name()
  {
    return("_barrier_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual string Get_VC_Name()
  {
    string ret_string = "barrier_stmt_" + Int64ToStr(this->Get_Index());
    return(ret_string);
  }

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual bool Is_Control_Flow_Statement() {return(true);}
};


class AaTraceStatement: public AaNullStatement
{
	string _trace_identifier;
	int _trace_index;
	public:
	AaTraceStatement(AaScope* prnt, string tid):AaNullStatement(prnt) {_trace_identifier = tid; _trace_index = 0;}
	AaTraceStatement(AaScope* prnt, string tid, int tindex):AaNullStatement(prnt) {_trace_identifier = tid; _trace_index = tindex;}
        virtual void Print(ostream& ofile);
  	virtual void Map_Targets () {} // do nothing
  	virtual void Map_Source_References();

  	virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
        virtual string Kind() {return("AaTraceStatement");}
};

class AaReportStatement: public AaNullStatement
{
	public:
        AaExpression* _assert_expression;
        string _tag;
	string _synopsys;
	vector<pair<string, AaExpression*> > _descr_pairs;

	AaReportStatement(AaScope* parent, AaExpression* assert_expr, 
				string tag, string synopsys, vector<pair<string,AaExpression*> >& descr_pairs);
        virtual void Print(ostream& ofile);
  	virtual void Map_Targets () {} // do nothing
  	virtual void Map_Source_References();
  	virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
        virtual string Kind() {return("AaReportStatement");}
};

class AaLockStatement: public AaNullStatement
{
	public:
        string _mutex_id;
	AaLockStatement(AaScope* parent, string mid);
        virtual void Print(ostream& ofile)
	{
		ofile << "$lock " << _mutex_id << endl;
	}
  	virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
        virtual string Kind() {return("AaLockStatement");}
};

class AaUnlockStatement: public AaNullStatement
{
	public:
        string _mutex_id;
	AaUnlockStatement(AaScope* parent, string mid);
        virtual void Print(ostream& ofile)
	{
		ofile << "$unlock " << _mutex_id << endl;
	}
  	virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
        virtual string Kind() {return("AaUnlockStatement");}
};

class AaSleepStatement: public AaNullStatement
{
	public:
        int _sleep_count;
	AaSleepStatement(AaScope* prnt, int sleep_count):AaNullStatement(prnt) {_sleep_count = sleep_count;}
        virtual void Print(ostream& ofile);
  	virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
        virtual string Kind() {return("AaSleepStatement");}
};

// assignment statement
class AaAssignmentStatement: public AaStatement
{
  AaExpression* _target;
  AaExpression* _source;

  int _buffering;
  bool _is_volatile;
  bool _cut_through;
 public:
  AaExpression* Get_Target() {return(this->_target);}
  AaExpression* Get_Source() {return(this->_source);}


  AaAssignmentStatement(AaScope* scope,AaExpression* target, AaExpression* source, int lineno);
  ~AaAssignmentStatement();

  virtual bool Is_Assignment_Statement() { return(true);}

  virtual void Set_Is_Volatile(bool v);
  virtual bool Get_Is_Volatile(); //       { return(_is_volatile); }

  virtual void Set_Cut_Through(bool v) {_cut_through = v;}
  virtual bool Get_Cut_Through() {return(_cut_through);}

  virtual void Collect_Root_Sources(set<AaRoot*>& root_src_exprs);

  virtual void Set_Pipeline_Parent(AaStatement* dws);

  virtual int Get_Buffering() {return(_buffering);}
  virtual void Set_Buffering(int b) {_buffering = b;}

  string Get_VC_Buffering_String();

  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaAssignmentStatement");}

  virtual void Map_Targets();
  virtual void Map_Source_References();

  virtual AaSimpleObjectReference* Get_Implicit_Target(string tgt_name);

  virtual string Debug_Info();

  virtual string Get_C_Name()
  {
    return("_assign_line_" +   IntToStr(this->Get_Line_Number()));
  }
  virtual string C_Reference_String()
  {
	return(this->Get_Target()->C_Reference_String());
  }
 
  string Get_Target_Name() {return(this->_target->Get_Name());}


  void Replace_Source_Expression(AaExpression* old_arg, AaSimpleObjectReference* new_arg);

  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
  virtual void PrintC_Implicit_Declarations(ofstream& ofile);


  void Write_VC_WAR_Dependencies(bool pipeline_flag, set<AaRoot*>& visited_elements,
				 ostream& ofile);


  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);


  // this is the big one!
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
					       map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
						AaRoot* barrier,
					       ostream& ofile);


  virtual bool Is_Constant();

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual void Propagate_Constants(); 
  virtual string Get_VC_Name() {return("assign_stmt_" + Int64ToStr(this->Get_Index()));}

  virtual string Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements);
  virtual string Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements);
  virtual string Get_VC_Synch_Transition_Name(bool& has_delay);

  virtual string Get_VC_Sample_Start_Transition_Name();
  virtual string Get_VC_Sample_Completed_Transition_Name();
  virtual string Get_VC_Update_Start_Transition_Name();
  virtual string Get_VC_Update_Completed_Transition_Name();

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);
   virtual void Get_Non_Trivial_Source_References(set<AaRoot*>& tgt_set, set<AaRoot*>& visited_elements);

  virtual bool Is_Orphaned();
  virtual bool Can_Be_Combinationalized();
};



class AaCallStatement: public AaStatement
{

  string _function_name;
  AaModule* _called_module;
  vector<AaExpression*> _input_args;
  vector<AaObjectReference*> _output_args;
  int _buffering;
  bool _is_volatile;
 public:
  unsigned int Get_Number_Of_Input_Args() {return(this->_input_args.size());}
  unsigned int Get_Number_Of_Output_Args() {return(this->_output_args.size());}
  string Get_Function_Name() {return(this->_function_name);}
  void Set_Called_Module(AaModule* m);
  AaModule* Get_Called_Module() {return(this->_called_module);}
  virtual void Set_Pipeline_Parent(AaStatement* dws);

  virtual bool Is_Call_Statement() {return(true);}
  virtual bool Is_Opaque_Call_Statement();

  // return true if module writes to pipe ..
  virtual bool Is_Write_To_Pipe(AaPipeObject* obj);
  virtual bool Writes_To_Memory_Space(AaMemorySpace* ms);

  virtual void Set_Is_Volatile(bool v);
  virtual bool Get_Is_Volatile(); //       { return(_is_volatile); }
  virtual void Collect_Root_Sources(set<AaRoot*>& root_src_exprs);
  virtual void Get_Non_Trivial_Source_References(set<AaRoot*>& tgt_set, set<AaRoot*>& visited_elements);

  void Replace_Input_Argument(AaExpression* old_arg, AaSimpleObjectReference* new_arg);

  AaCallStatement(AaScope* scope_tpr,
		  string func_name,
		  vector<AaExpression*>& inargs, 
		  vector<AaObjectReference*>& outargs,
		  int lineno);

  ~AaCallStatement();
  
  virtual int Get_Buffering() {return(_buffering);}
  virtual void Set_Buffering(int b) {_buffering = b;}

  AaExpression* Get_Input_Arg(unsigned int index);
  AaObjectReference* Get_Output_Arg(unsigned int index);
  
  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaCallStatement");}

  virtual void Map_Targets();
  virtual void Map_Source_References();

  virtual AaSimpleObjectReference* Get_Implicit_Target(string tgt_name);

  //
  // return true if one of the sources or targets is a pipe.
  // or if the called module can block.
  //
  // (if pipeline_flag is true, then the pipe must also be marked
  //  as an explicit synch pipe).
  // 
  virtual bool Can_Block(bool pipeline_flag);

  virtual string Get_C_Name()
  {
    return("_call_line_" +   IntToStr(this->Get_Line_Number()));
  }

  void PrintC_Call_To_Foreign_Module(ofstream& ofile);
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
  virtual void PrintC_Implicit_Declarations(ofstream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile)
  {
    assert(0);
  }
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
					       map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
					       AaRoot* barrier,
					       ostream& ofile);
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual void Propagate_Constants();
  virtual string Get_VC_Name() {return("call_stmt_" + Int64ToStr(this->Get_Index()));}

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);

  virtual string Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
  {
    return(this->AaRoot::Get_VC_Reenable_Sample_Transition_Name(visited_elements));
  }

  //
  // The transition which enables the update of the results
  // of this statement (Note that this may be part of the
  // source of an assignment statement).
  //
  virtual string Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
  {
    return(this->AaRoot::Get_VC_Reenable_Update_Transition_Name(visited_elements));
  }

  void Write_VC_WAR_Dependencies(bool pipeline_flag, set<AaRoot*>& visited_elements,
				 ostream& ofile);
  virtual bool Can_Be_Combinationalized();
};


class AaBlockStatement: public AaStatement
{
 protected:
  string _label;
  vector<AaObject*> _objects;
  AaStatementSequence* _statement_sequence;
  map<string,string> _exports;


  bool _has_declared_storage_object;
  
 public:

  virtual string Get_Label() { return(this->_label);}
  virtual string Get_Name() {return(this->Get_Label());}
  virtual bool Is_Block_Statement() {return(true);}
  virtual bool Is_Pipelined() {return(false);}

  virtual bool Get_Has_Declared_Storage_Object() 
  {
	return(_has_declared_storage_object);
  }
  virtual void Set_Has_Declared_Storage_Object(bool v)
  {
	_has_declared_storage_object = v;
  }

  virtual void Set_Pipeline_Parent(AaStatement* dws) 
  { 
      _pipeline_parent = dws;
      if(_statement_sequence != NULL)
      	_statement_sequence->Set_Pipeline_Parent(dws);
  }

  virtual unsigned int Get_Statement_Count() 
  {
    return((this->_statement_sequence ? this->_statement_sequence->Get_Statement_Count() : 0)); 
  }
  virtual AaStatement* Get_Statement(unsigned int indx)
  {
    return((this->_statement_sequence == NULL ? NULL : this->_statement_sequence->Get_Statement(indx)));
  }
  virtual void Set_Statement_Sequence(AaStatementSequence* statement_sequence) 
  {
    this->_statement_sequence = statement_sequence;
  }

  void Add_Export(string formal, string actual);

  virtual void Coalesce_Storage();

  virtual void Add_Object(AaObject* obj);
  virtual void Print_Objects(ostream &ofile)
  {
    if(this->_objects.size() > 0)
      {
	for(unsigned int i = 0; i < this->_objects.size(); i++)
	  {
	    this->_objects[i]->Print(ofile);
	    ofile << endl;
	  }
      }
  }

  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
  virtual void Write_C_Object_Declarations_And_Initializations(ofstream& ofile);

  virtual void Print_Statement_Sequence(ostream& ofile)
  {
    if(this->_statement_sequence != NULL)
      this->_statement_sequence->Print(ofile);
  }

  virtual void Increment_Tab_Depth() 
  { 
    this->_tab_depth += 1; 
    if(this->_statement_sequence != NULL)
      this->_statement_sequence->Increment_Tab_Depth();
  }
  AaBlockStatement(AaScope* scope, string label);
  ~AaBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaBlockStatement");}

  virtual void Map_Targets();
  virtual void Map_Source_References();



  virtual string Get_C_Name()
  {
    return(this->Get_Label());
  }

  //
  // return true if one of the constituent statements
  // can block.
  //
  virtual bool Can_Block(bool pipeline_flag);




  virtual void Write_VC_Constant_Declarations(ostream& ofile);
  virtual void Write_VC_Pipe_Declarations(ostream& ofile);  
  virtual void Write_VC_Memory_Space_Declarations(ostream& ofile);  
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);

  void Identify_Maximal_Sequences(AaStatementSequence* sseq, 
				  vector<AaStatementSequence*>& linear_segment_vector);

  void Destroy_Maximal_Sequences(vector<AaStatementSequence*>& linear_segment_vector);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, AaStatement* stmt, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, AaStatementSequence* seq, ostream& ofile);

  virtual string Get_VC_Name() {return("block_stmt_" + Int64ToStr(this->Get_Index()));}


  virtual AaStatement* Get_Next_Statement(AaStatement* stmt)
  {
    return(this->_statement_sequence->Get_Next_Statement(stmt));
  }

  virtual AaStatement* Get_Previous_Statement(AaStatement* stmt)
  {
    return(this->_statement_sequence->Get_Previous_Statement(stmt));
  }


  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag, 
					       AaStatementSequence* sseq,
					       set<AaRoot*>& visited_elements,
					       map<AaMemorySpace*,vector<AaRoot*> >& load_store_dep_map,
					       map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
					       AaRoot*& trailing_barrier,
					       ostream& ofile);

  virtual void Write_VC_Control_Path_Optimized(AaStatement* stmt,
					       ostream& ofile);


  
  void Write_VC_Load_Store_Dependencies(bool pipeline_flag, 
					map<AaMemorySpace*,vector<AaRoot*> >& load_store_dep_map,
					ostream& ofile);
  void Write_VC_Pipe_Dependencies(bool pipeline_flag, 
				  map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
				  ostream& ofile);

  virtual void Propagate_Constants();
  void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);
};

class AaSeriesBlockStatement: public AaBlockStatement
{
 public:
  AaSeriesBlockStatement(AaScope* scope, string label);
  ~AaSeriesBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaSeriesBlockStatement");}


  virtual void Write_VC_Control_Path(ostream& ofile)
  {
    ofile << ";;[" << this->Get_VC_Name() << "] // series block " << this->Get_Source_Info() << endl << "{";
    this->_statement_sequence->Write_VC_Control_Path(ofile);
    ofile << "} // end series block " << this->Get_VC_Name() << endl;
  }
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual string Get_VC_Name() {return ("series_block_stmt_" + Int64ToStr(this->Get_Index()));}
  
  
  void Write_VC_Links_Optimized_Base(string hier_id, ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized_Base(ostream& ofile);

  virtual void Add_Delayed_Versions( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map);
};


class AaParallelBlockStatement: public AaBlockStatement
{
 public:
  AaParallelBlockStatement(AaScope* scope, string label);
  ~AaParallelBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaParallelBlockStatement");}


  virtual void Write_VC_Control_Path(ostream& ofile)
  {
    ofile << "||[" << this->Get_VC_Name() << "] // parallel block " 
	  << this->Get_Source_Info() << endl << "{";
    this->_statement_sequence->Write_VC_Control_Path(ofile);
    ofile << "} // end parallel block " << this->Get_VC_Name() << endl;
  }

  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual string Get_VC_Name() {return("parallel_block_stmt_" + Int64ToStr(this->Get_Index()));}
};


class AaForkBlockStatement: public AaParallelBlockStatement
{

  set<AaStatement*> _explicitly_forked_statements;
  set<AaStatement*> _explicitly_joined_statements;

 public:
  AaForkBlockStatement(AaScope* scope , string label);
  ~AaForkBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaForkBlockStatement");}

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual string Get_VC_Name() {return("fork_block_stmt_" + Int64ToStr(this->Get_Index()));}
};

class AaBranchBlockStatement: public AaSeriesBlockStatement
{
  set<string> _merged_places;

 public:
  AaBranchBlockStatement(AaScope* scope, string label);
  ~AaBranchBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaBranchBlockStatement");}

  void Add_Merged_Place(string place_name)
  {
    if(_merged_places.find(place_name) == _merged_places.end())
      _merged_places.insert(place_name);
    else
      AaRoot::Error("place " + place_name + " is merged more than once in branch block: ", this);
  }

  bool Is_A_Merged_Place(string place_name)
  {
    return(_merged_places.find(place_name) != _merged_places.end());
  }

  virtual void Write_VC_Control_Path(ostream& ofile);
  void Write_VC_Control_Path(string source_link,
			     AaStatementSequence* sseq,
			     string sink_link,
			     ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  void Write_VC_Control_Path_Optimized(string source_link,
				       AaStatementSequence* sseq,
				       string sink_link,
				       ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);
  void Write_VC_Links_Optimized(string hier_id,
				AaStatementSequence* sseq_in,
				ostream& ofile);


  virtual string Get_VC_Name() {return("branch_block_stmt_" + Int64ToStr(this->Get_Index()));}

  void Identify_Inner_Loops(AaStatementSequence* sseq, 
				  vector<AaStatementSequence*>& linear_segment_vector);
};


class AaJoinForkStatement: public AaParallelBlockStatement
{
  vector<AaStatement*> _wait_on_statements;
  vector<string> _join_labels;
 public:
  void Add_Join_Label(string jl) { this->_join_labels.push_back(jl); }

  virtual void Print(ostream& ofile);
  AaJoinForkStatement(AaForkBlockStatement* scope);
  ~AaJoinForkStatement();
  virtual string Kind() {return("AaJoinForkStatement");}

  virtual void Map_Source_References();


  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);

  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual string Get_VC_Name() {return("join_fork_stmt_" + Int64ToStr(this->Get_Index()));}
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);

  virtual void PrintC_Implicit_Declarations(ofstream& ofile) 
  { 
	this->_statement_sequence->PrintC_Implicit_Declarations(ofile);
  }
};



class AaPlaceStatement: public AaStatement
{
  string _label;
  int _multiplicity;
 public:
  AaPlaceStatement(AaBranchBlockStatement* parent_tpr, string lbl);
  ~AaPlaceStatement();
  virtual string Get_Label() {return(this->_label);}

  void Mark_As_Merged()
  {
    ((AaBranchBlockStatement*)this->Get_Scope())->Add_Merged_Place(this->Get_Label());
  }

  virtual string Get_Place_Name() { return(this->Get_Label()); }
  virtual string C_Reference_String();

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
  {
	// do nothing.
  }

  virtual void Print(ostream& ofile) 
  { 
    this->Err_Check(); 
    ofile << this->Tab() << "$place[" << this->Get_Label() << "]"  << endl; 
  }
  virtual string Kind() {return("AaPlaceStatement");}
  virtual void Map_Targets() {} // do nothing
  virtual void Map_Source_References() {} // do nothing

  virtual bool Is_Control_Flow_Statement() {return(true);}

  virtual void PrintC(ofstream& srcfile, ofstream& headerfile)
  {
	srcfile << "/* " << this->To_String() << "*/  ";
	srcfile << "goto " << this->C_Reference_String() << ";" << endl;
  }

  virtual void Err_Check()
  {
    if(!((AaBranchBlockStatement*)this->Get_Scope())->Is_A_Merged_Place(this->Get_Label()))
      {
	AaRoot::Error("place is not cleared by any merge ", this);
      }
  }

  virtual string Get_VC_Name() {return(this->_label);}

  void Write_VC_Control_Path(ostream& ofile)
  {
    // nothing.. places will be printed from the enclosing
    // scope.
    ofile << "$P [" << this->Get_VC_Name() << "]" << endl;
  }
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile)
  {
   // nothing.. places will be printed from the enclosing scope..
    ofile << "$P [" << this->Get_VC_Name() << "]" << endl;
  }



  virtual string Get_VC_Entry_Place_Name() { return(this->Get_VC_Name()); }
  virtual string Get_VC_Exit_Place_Name() { return(this->Get_VC_Name()); }

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places)
  {
	target_places.insert(this);
  }
};


class AaMergeStatement: public AaSeriesBlockStatement
{
  vector<string> _merge_label_vector; // to preserve the order
  set<string,StringCompare> _merge_label_set;
  vector<AaPlaceStatement*> _wait_on_statements;

  string _vc_source_link; // name of VC source link.

  bool _has_entry_place;
  unsigned char _wait_on_entry;
  bool _in_do_while;

 public:
  void Add_Merge_Label(string lbl) 
  { 
    if(this->_merge_label_set.find(lbl) == this->_merge_label_set.end())
      {
	this->_merge_label_set.insert(lbl); 
	this->_merge_label_vector.push_back(lbl);
      }
  }

  bool Has_Merge_Label(string lbl)
  {
    return(this->_merge_label_set.find(lbl) != this->_merge_label_set.end());
  }

  virtual bool Can_Block(bool pipeline_flag);
  void Set_In_Do_While(bool v);
  bool Get_In_Do_While() {return(_in_do_while);}

  void Get_Phi_Statement_Counts(int& relaxed_count, int& strict_count);


  
  AaMergeStatement(AaBranchBlockStatement* scope);
  ~AaMergeStatement();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaMergeStatement");}

  void Set_Has_Entry_Place(bool v)
  {
    _has_entry_place = v;
  }

  virtual void Map_Targets();
  virtual void Map_Source_References();

  virtual string C_Reference_String()
  {
    return("_merge_line_" +   IntToStr(this->Get_Line_Number()));
  }


  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
  virtual void PrintC_Implicit_Declarations(ofstream& ofile) 
  { 
	if(this->_statement_sequence)
		this->_statement_sequence->PrintC_Implicit_Declarations(ofile);
  }

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);


  virtual string Get_VC_Name() {return("merge_stmt_" + Int64ToStr(this->Get_Index()));}
  virtual string Get_VC_Entry_Place_Name() {return(this->Get_VC_Name() + "__entry__");}

  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

};

class AaPhiStatement: public AaStatement
{
  bool _barrier_flag;
  bool _relaxed_flag;
  AaMergeStatement* _parent_merge;
  AaObjectReference* _target;
  vector<pair<string,AaExpression*> > _source_pairs;
  set<string> _merged_labels;
  bool _in_do_while;
  map<AaExpression*,vector<string> > _source_label_vector;

 public:
  AaPhiStatement(AaBranchBlockStatement* scope, AaMergeStatement* pm);
  ~AaPhiStatement();

  void Set_Barrier_Flag(bool v) {_barrier_flag = v;}
  bool Get_Barrier_Flag() {return(_barrier_flag);}

  void Set_Relaxed_Flag(bool v) {_relaxed_flag = v;}
  bool Get_Relaxed_Flag() {return(_relaxed_flag);}

  void Set_Target(AaObjectReference* tgt);
  AaObjectReference* Get_Target() {return(_target);}

  virtual bool Is_Phi_Statement() {return(true);}
  void Add_Source_Pair(string label, AaExpression* expr);
  void Add_Source_Label_Vector(AaExpression* expr, vector<string>& labels);
  
  bool Is_Single_Source() {return(_source_label_vector.size() == 1);}

  AaExpression* Get_Source_Expression(int index)
  {
	if((index >=0) && (index < _source_pairs.size()))
	{
		return(_source_pairs[index].second);
	}
	else
	{
		return(NULL);
	}
  }
  virtual void Set_Pipeline_Parent(AaStatement* dws);
  bool Is_Merged(string label)
  {
    return(_merged_labels.find(label) != _merged_labels.end());
  }

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPhiStatement");}

  virtual void Map_Targets();
  virtual void Map_Source_References();

  virtual AaSimpleObjectReference* Get_Implicit_Target(string tgt_name);

  void Write_VC_WAR_Dependencies(bool pipeline_flag, set<AaRoot*>& visited_elements,
				 ostream& ofile);

  virtual string Get_C_Name()
  {
    return("_phi_line_" +   IntToStr(this->Get_Line_Number()));
  }
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);  
  virtual void PrintC_Implicit_Declarations(ofstream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);

  virtual void Write_VC_Source_Control_Paths(string& mplace, ostream& ofile);

  virtual void Propagate_Constants();
  virtual bool Is_Constant();

  virtual string Get_VC_Name() {return("phi_stmt_" + Int64ToStr(this->Get_Index()));}

  void Set_In_Do_While(bool v) { _in_do_while = v;}
  bool Get_In_Do_While() {return(_in_do_while);}

  // this is the big one! added to support loop pipelining.
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
					       map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
						AaRoot* barrier,
					       ostream& ofile);
   // when there is only a single source in the phi, things are a lot simpler.
  virtual void Write_VC_Control_Path_Optimized_Single_Source
				(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<AaMemorySpace*, vector<AaRoot*> >& ls_map,
					       map<AaPipeObject*,vector<AaRoot*> >& pipe_map,
						AaRoot* barrier,
					       ostream& ofile);




  // called only if it appears in a do while loop.
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  
  virtual string Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
  {
    return(this->Get_VC_Name() + "_update_start_");
  }

  virtual string Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
  {
    return(this->Get_VC_Name() + "_sample_start_");
  }
 

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);
  friend class AaMergeStatement;
};


class AaSwitchStatement: public AaStatement
{
  AaExpression* _select_expression;
  vector<pair<AaExpression*, AaStatementSequence*> > _choice_pairs;
  AaStatementSequence* _default_sequence;

 public:

  void Set_Select_Expression(AaExpression* expr);
  void Add_Choice(AaExpression* cond, AaStatementSequence* sseq);

  void Set_Default_Sequence(AaStatementSequence* sseq)
  {
    this->_default_sequence = sseq;
  }

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
  {
	for(int I = 0, fI = _choice_pairs.size(); I < fI; I++)
	{
		AaStatementSequence* css = _choice_pairs[I].second;
		if(css != NULL)
			css->Update_Adjacency_Map(adjacency_map, visited_elements);
	}
	if(_default_sequence != NULL)
	{
		_default_sequence->Update_Adjacency_Map(adjacency_map, visited_elements);
	}
  }

  AaSwitchStatement(AaBranchBlockStatement* scope);
  ~AaSwitchStatement();
  virtual void Coalesce_Storage();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaSwitchStatement");}

  virtual void Map_Targets();
  virtual void Map_Source_References();

  virtual bool Can_Block(bool pipeline_flag);
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);  
  virtual void PrintC_Implicit_Declarations(ofstream& ofile) 
  { 
	for(int i = 0, imax = _choice_pairs.size(); i < imax; i++)
	{
		_choice_pairs[i].second->PrintC_Implicit_Declarations(ofile);
	}
  }

  virtual bool Is_Control_Flow_Statement() {return(true);}


  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  void Write_VC_Control_Path(bool optimize_flag, ostream& ofile);


  virtual void Write_VC_Constant_Declarations(ostream& ofile);
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);
  void Write_VC_Links(bool opt_flag, string hier_id,ostream& ofile);

  virtual void Propagate_Constants(); 

  virtual string Get_VC_Name() {return("switch_stmt_" + Int64ToStr(this->Get_Index()));}
  virtual string Get_VC_Exit_Place_Name() {return(this->Get_VC_Name() + "__exit__");}

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places);
};


class AaIfStatement: public AaStatement
{
  AaExpression* _test_expression;
  AaStatementSequence* _if_sequence;
  AaStatementSequence* _else_sequence;
 public:


  void Set_Test_Expression(AaExpression* te);
  void Set_If_Sequence(AaStatementSequence* is) { this->_if_sequence = is; }
  void Set_Else_Sequence(AaStatementSequence* es) { this->_else_sequence = es; }
  AaStatement* Get_If_Sequence_Statement(int idx)
  {
	if(_if_sequence)
		return(_if_sequence->Get_Statement(idx));
	else
		return(NULL);
  } 
  AaStatement* Get_Else_Sequence_Statement(int idx)
  {
	if(_else_sequence)
		return(_else_sequence->Get_Statement(idx));
	else
		return(NULL);
  } 

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
  {
	if(_if_sequence != NULL)
		_if_sequence->Update_Adjacency_Map(adjacency_map, visited_elements);
	if(_else_sequence != NULL)
		_else_sequence->Update_Adjacency_Map(adjacency_map, visited_elements);
  }

  virtual bool Can_Block(bool pipeline_flag);
  AaIfStatement(AaBranchBlockStatement* scope);
  ~AaIfStatement();
  virtual void Print(ostream& ofile);
  virtual void PrintC(ofstream& srcfile, ofstream& headerfile);
  virtual void PrintC_Implicit_Declarations(ofstream& ofile) 
  { 
	  if(_if_sequence)
		  this->_if_sequence->PrintC_Implicit_Declarations(ofile);
	  if(_else_sequence)
		  this->_else_sequence->PrintC_Implicit_Declarations(ofile);
  }
  virtual string Kind() {return("AaIfStatement");}
  virtual void Map_Targets()
  {
    if(this->_if_sequence)
    	this->_if_sequence->Map_Targets();
    if(this->_else_sequence)
      this->_else_sequence->Map_Targets();
  }
  virtual void Map_Source_References()
  {
    if(this->_test_expression)
      this->_test_expression->Map_Source_References(this->_source_objects);
    if(this->_if_sequence)
    	this->_if_sequence->Map_Source_References();
    if(this->_else_sequence)
      this->_else_sequence->Map_Source_References();
  }

  virtual void Coalesce_Storage();

  virtual void Write_VC_Constant_Declarations(ostream& ofile);

  virtual string Get_C_Name()
  {
    return("_if_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual bool Is_Control_Flow_Statement() {return(true);}


  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  void Write_VC_Control_Path(bool optimize_flag, ostream& ofile);

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);

  virtual void Write_VC_Links(string hier_id,ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);
  void Write_VC_Links(bool opt_flag, string hier_id,ostream& ofile);


  virtual void Propagate_Constants(); 

  virtual string Get_VC_Name() {return("if_stmt_" + Int64ToStr(this->Get_Index()));}
  virtual string Get_VC_Exit_Place_Name() {return(this->Get_VC_Name() + "__exit__");}

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places);
};


class AaDoWhileStatement: public AaStatement
{
  AaExpression* _test_expression;
  AaMergeStatement* _merge_statement;
  AaStatementSequence* _loop_body_sequence;

  int  _pipeline_depth;
  int  _pipeline_buffering;
  bool _pipeline_full_rate_flag;
 public:

  virtual void Set_Pipeline_Depth(int v) {_pipeline_depth = v;}
  virtual int Get_Pipeline_Depth() {return(_pipeline_depth);}

  virtual void Set_Pipeline_Buffering(int v) {_pipeline_buffering = v;}
  virtual int Get_Pipeline_Buffering() {return(_pipeline_buffering);}

  virtual void Set_Pipeline_Full_Rate_Flag(bool v) {_pipeline_full_rate_flag = v;}
  virtual bool Get_Pipeline_Full_Rate_Flag() {return(_pipeline_full_rate_flag);}

  void Set_Test_Expression(AaExpression* te);
  void Set_Merge_Statement(AaMergeStatement* ms) { this->_merge_statement = ms; }
  void Set_Loop_Body_Sequence(AaStatementSequence* lbs);

  virtual bool Can_Block(bool pipeline_flag);

  int Get_Number_Of_Loop_Body_Statements()
  {
	if(_loop_body_sequence)
		return(_loop_body_sequence->Get_Statement_Count());
	else
		return(0);
  }
  AaMergeStatement* Get_Merge_Statement()
  {
    return(_merge_statement);
  } 

  virtual bool Is_Part_Of_Fullrate_Pipeline()
  {
	return(_pipeline_full_rate_flag);
  }


  AaStatement* Get_Loop_Body_Statement(int idx)
  {
	if(_loop_body_sequence)
		return(_loop_body_sequence->Get_Statement(idx));
	else
		return(NULL);
  } 

  AaDoWhileStatement(AaBranchBlockStatement* scope);
  ~AaDoWhileStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaDoWhileStatement");}
  virtual void Map_Targets()
  {
    if(this->_merge_statement)
    	this->_merge_statement->Map_Targets();
    if(this->_loop_body_sequence)
      this->_loop_body_sequence->Map_Targets();
  }
  virtual void Map_Source_References()
  {
    if(this->_test_expression)
      this->_test_expression->Map_Source_References(this->_source_objects);
    if(this->_merge_statement)
    	this->_merge_statement->Map_Source_References();
    if(this->_loop_body_sequence)
      this->_loop_body_sequence->Map_Source_References();
  }

  virtual void PrintC_Implicit_Declarations(ofstream& ofile) 
  { 
	this->_merge_statement->PrintC_Implicit_Declarations(ofile);
	if(this->_loop_body_sequence)
		this->_loop_body_sequence->PrintC_Implicit_Declarations(ofile);
  }

  virtual void Coalesce_Storage();


  virtual void PrintC(ofstream& srcfile, ofstream& headerfile); 

  virtual bool Is_Control_Flow_Statement() {return(true);}

  virtual void Write_VC_Constant_Declarations(ostream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);
  void Write_VC_Control_Path(bool optimize_flag, ostream& ofile);

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);

  virtual void Write_VC_Links(string hier_id,ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);
  void Write_VC_Links(bool opt_flag, string hier_id,ostream& ofile);


  virtual void Propagate_Constants(); 

  virtual string Get_VC_Name() {return("do_while_stmt_" + Int64ToStr(this->Get_Index()));}
  virtual string Get_VC_Exit_Place_Name() {return(this->Get_VC_Name() + "__exit__");}

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places); // do nothing.


  //int Find_Longest_Paths( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
				//map<AaRoot*, int>& longest_paths_from_root_map);
  void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);
  void Add_Delayed_Versions( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		set<AaRoot*>& visited_elements,
		map<AaRoot*, int>& longest_paths_from_root_map);
};



bool Make_Split_Statement(AaScope* scope, string src, vector<int>& sizes, vector<AaExpression*>& targets, 
				vector<AaStatement*>& slist, int buffering, int  line_number);
#endif
