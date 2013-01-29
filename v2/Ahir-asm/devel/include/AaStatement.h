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

class AaPlaceStatement;

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

 public:
  AaStatement(AaScope* scope);
  
  // add map entries in parent's lookup map for easy access
  virtual void Map_Targets() 
  {
    // derived statements will map their targets
    // in their containing scopes.
    assert(0); 
  }

  virtual void Set_Guard_Expression(AaSimpleObjectReference* oref)
  {
	_guard_expression = oref;
  }
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

  virtual void Map_Target(AaObjectReference* obj_ref);
  virtual string Tab();

  virtual void Set_Tab_Depth(unsigned int td) { this->_tab_depth = td; }
  virtual unsigned int Get_Tab_Depth() { return(this->_tab_depth); }
  virtual void Increment_Tab_Depth() { this->_tab_depth += 1; }

  virtual bool Is_Statement() { return(true);}
  virtual bool Is_Control_Flow_Statement() {return(false);}
  virtual bool Is_Block_Statement() {return(false);}


  void Set_Index_In_Sequence(int id) {this->_index_in_sequence = id;}
  int Get_Index_In_Sequence() {return(this->_index_in_sequence);}

  virtual void Coalesce_Storage() {}

  ~AaStatement();

  virtual string Kind() {return("AaStatement");}
  virtual void Map_Source_References() { assert(0);}

  virtual void Write_C_Struct(ofstream& ofile);
  virtual void Write_C_Struct_Extra(ofstream& ofile) {}
  virtual void Write_C_Function_Header(ofstream& ofile);
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_C_Name() {assert(0); }


  virtual string Get_Entry_Name() { return(this->Get_C_Name() + "_entry"); }
  virtual string Get_In_Progress_Name() { return(this->Get_C_Name() + "_in_progress"); }
  virtual string Get_Exit_Name() { return(this->Get_C_Name() + "_exit"); }

  virtual string Get_Entry_Name_Ref() 
  {
    return(this->Get_Struct_Dereference() + this->Get_Entry_Name());
  }

  virtual string Get_In_Progress_Name_Ref() 
  {
    return(this->Get_Struct_Dereference() + this->Get_In_Progress_Name());
  }

  virtual string Get_Exit_Name_Ref() 
  {
    return(this->Get_Struct_Dereference() + this->Get_Exit_Name());
  }


  virtual string Get_Structure_Name() { return("_" + this->Get_C_Name()); }
  virtual string Get_C_Function_Name() { return(this->Get_C_Name() + "_"); }
  virtual string Get_C_Wrap_Function_Name() { return(this->Get_C_Name()); }
  
  virtual bool Can_Block() { assert(0); }
  virtual void Write_Pipe_Condition_Check(ofstream& ofile , string tab_string);
  virtual void Write_Pipe_Read_Condition_Check(ofstream& ofile , string tab_string);
  virtual void Write_Pipe_Write_Condition_Check(ofstream& ofile , string tab_string);
  virtual void Write_Pipe_Condition_Update(ofstream& ofile, string tab_string);
  virtual void Write_Pipe_Read_Condition_Update(ofstream& ofile , string tab_string);
  virtual void Write_Pipe_Write_Condition_Update(ofstream& ofile , string tab_string);
  virtual void Write_VC_Constant_Declarations(ostream& ofile) {};

  virtual void PrintC(ofstream& ofile, string tab_string) { assert(0); }

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
					       map<string,vector<AaExpression*> >& ls_map,
					       map<string,vector<AaExpression*> >& pipe_map,
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

  //
  //  the transition which reenables the update of predecessors.
  //  Essentially, when a statement has sources, the sources 
  //  can be updated immediately after the statement has saved
  //  the previous values of the sources. 
  //
  virtual string Get_VC_Predecessor_Releasing_Transition_Name()
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
  virtual string Get_VC_Re_Enable_Update_Transition_Name()
  {
    // these need to be defined for each type of (relevant) statement
    // (the Assignment, Phi and Call statements).
    assert(0);
  }


};

// statement sequence (is used in block statements which lead to programs)
class AaStatementSequence: public AaScope
{
  vector<AaStatement*> _statement_sequence;
 public:

  AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence);
  ~AaStatementSequence();

  unsigned int Get_Statement_Count() { return this->_statement_sequence.size(); }
  AaStatement* Get_Statement(unsigned int indx) 
  { 
    if(indx < this->Get_Statement_Count())
      return (this->_statement_sequence[indx]);
    else
      return(NULL);
  }

  void Renumber_Statements()
  {
	for(int idx =0, fidx = _statement_sequence.size(); idx < fidx; idx++)
	{
		_statement_sequence[idx]->Set_Index_In_Sequence(idx);
	}
  }

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaStatementSequence");}
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

  virtual void Write_C_Struct(ofstream& ofile)
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Write_C_Struct(ofile);
  }

  virtual void Write_C_Function_Body(ofstream& ofile)
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Write_C_Function_Body(ofile);
  }

  virtual void Get_Target_Places(set<AaPlaceStatement*>& target_places);

  virtual void  Write_Parallel_Entry_Transfer_Code(ofstream& ofile);
  virtual void  Write_Series_Entry_Transfer_Code(ofstream& ofile);

  virtual void Write_Parallel_Statement_Invocations(ofstream& ofile);
  virtual void Write_Series_Statement_Invocations(ofstream& ofile);

  virtual void  Write_Parallel_Exit_Check_Condition(ofstream& ofile);
  virtual void  Write_Series_Exit_Check_Condition(ofstream& ofile);

  virtual void Write_Clear_Exit_Flags_Code(ostream& ofile);

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
  virtual void Map_Source_References() {} // do nothing

  virtual void PrintC(ofstream& ofile, string tab_string)
  {
    ofile <<  tab_string << ";" << endl;
  }
  virtual string Get_C_Name()
  {
    return("_null_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual bool Can_Block() { return(false); }
  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);

};


// assignment statement
class AaAssignmentStatement: public AaStatement
{
  AaExpression* _target;
  AaExpression* _source;
 public:
  AaExpression* Get_Target() {return(this->_target);}
  AaExpression* Get_Source() {return(this->_source);}

  virtual void Map_Targets();

  AaAssignmentStatement(AaScope* scope,AaExpression* target, AaExpression* source, int lineno);
  ~AaAssignmentStatement();

  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaAssignmentStatement");}
  virtual void Map_Source_References();


  virtual string Debug_Info();

  virtual string Get_C_Name()
  {
    return("_assign_line_" +   IntToStr(this->Get_Line_Number()));
  }

  // return true if one of the sources or targets is a pipe.
  virtual bool Can_Block();
  virtual void PrintC(ofstream& ofile, string tab_string);


  virtual void Write_C_Struct(ofstream& ofile);
  void Write_VC_WAR_Dependencies(bool pipeline_flag, set<AaRoot*>& visited_elements,
				 ostream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);


  // this is the big one!
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<string, vector<AaExpression*> >& ls_map,
					       map<string,vector<AaExpression*> >& pipe_map,
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

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);
};



class AaCallStatement: public AaStatement
{

  string _function_name;
  AaRoot* _called_module;
  vector<AaExpression*> _input_args;
  vector<AaObjectReference*> _output_args;
 public:
  unsigned int Get_Number_Of_Input_Args() {return(this->_input_args.size());}
  unsigned int Get_Number_Of_Output_Args() {return(this->_output_args.size());}
  string Get_Function_Name() {return(this->_function_name);}
  void Set_Called_Module(AaRoot* m) { this->_called_module = m; }
  AaRoot* Get_Called_Module() {return(this->_called_module);}

  AaCallStatement(AaScope* scope_tpr,
		  string func_name,
		  vector<AaExpression*>& inargs, 
		  vector<AaObjectReference*>& outargs,
		  int lineno);

  ~AaCallStatement();
  
  AaExpression* Get_Input_Arg(unsigned int index);
  AaObjectReference* Get_Output_Arg(unsigned int index);
  
  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaCallStatement");}
  virtual void Map_Source_References();

  //  virtual void Map_Targets();


  // structure.
  virtual void Write_C_Struct(ofstream& ofile);

  // body
  virtual void Write_C_Function_Body(ofstream& ofile);

  // return true if one of the sources or targets is a pipe.
  virtual bool Can_Block();

  virtual string Get_C_Name()
  {
    return("_call_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual string Get_Called_Function_Struct_Pointer()
  {
    return(this->Get_C_Name() + "_called_fn_struct");
  }

  virtual string Get_Called_Function_Struct_Pointer_Ref()
  {
    return(this->Get_Struct_Dereference() + this->Get_Called_Function_Struct_Pointer());
  }

  virtual string Get_Called_Module_Struct_Name();

  virtual void PrintC(ofstream& ofile, string tab_string);
  virtual void Write_Inarg_Copy_Code(ofstream& ofile,string tab_string);
  virtual void Write_Outarg_Copy_Code(ofstream& ofile,string tab_string);
  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile)
  {
    assert(0);
  }
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<string, vector<AaExpression*> >& ls_map,
					       map<string,vector<AaExpression*> >& pipe_map,
					       ostream& ofile);
  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);
  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual void Propagate_Constants();
  virtual string Get_VC_Name() {return("call_stmt_" + Int64ToStr(this->Get_Index()));}

  virtual string Get_VC_Successor_Triggering_Region_Name()
  {
    return(this->Get_VC_Name() + "_start");
  }

  virtual string Get_VC_Predecessor_Releasing_Region_Name()
  {
    return(this->Get_VC_Name() + "_complete");
  }

  virtual void Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements);
};


class AaBlockStatement: public AaStatement
{
 protected:
  string _label;
  vector<AaObject*> _objects;
  AaStatementSequence* _statement_sequence;
  map<string,string> _exports;

 public:

  virtual string Get_Label() { return(this->_label);}
  virtual bool Is_Block_Statement() {return(true);}
  virtual bool Is_Pipelined() {return(false);}

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
  virtual void PrintC_Objects(ofstream &ofile,string tab_string)
  {
    if(this->_objects.size() > 0)
      {
	for(unsigned int i = 0; i < this->_objects.size(); i++)
	  {
	    this->_objects[i]->PrintC(ofile,tab_string);
	  }
      }
  }

  virtual void Write_Object_Initializations(ofstream& ofile)
  {
    for(unsigned int i = 0; i < this->_objects.size(); i++)
      {
	this->_objects[i]->Write_Initialization(ofile);
      }
  }
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
  virtual void Map_Source_References();

  // the block statement can be blocked, so there
  // will certainly be a structure contributed
  // by this.
  virtual void Write_C_Struct(ofstream& ofile);

  virtual void Write_Entry_Transfer_Code(ofstream& ofile) {assert(0);}
  virtual void Write_Statement_Invocations(ofstream& ofile) {assert(0);}
  virtual void Write_Exit_Check_Condition(ofstream& ofile) {assert(0);}
  virtual void Write_Cleanup_Code(ofstream& ofile) 
  {
    if(this->_statement_sequence)
      this->_statement_sequence->Write_Clear_Exit_Flags_Code(ofile);
  }

  // the block statement is always encased in a function!
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_C_Name()
  {
    return(this->Get_Label());
  }

  // return true if one of the sources or targets is a pipe.
  virtual bool Can_Block() { return (true); }



  virtual void Write_Entry_Condition(ofstream& ofile);

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
					       AaExpression* test_expression,
					       AaStatementSequence* sseq,
					       vector<AaStatement*>* phi_stmts,
					       string& region_name,
					       ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(AaStatement* stmt,
					       ostream& ofile);


  
  void Write_VC_Load_Store_Dependencies(bool pipeline_flag, map<string,vector<AaExpression*> >& load_store_dep_map,
					ostream& ofile);
  void Write_VC_Pipe_Dependencies(bool pipeline_flag, map<string,vector<AaExpression*> >& pipe_map,
					ostream& ofile);

  virtual void Propagate_Constants();

  void Add_Buffers_For_Pipelining(AaStatementSequence* sseq);
};

class AaSeriesBlockStatement: public AaBlockStatement
{
 public:
  AaSeriesBlockStatement(AaScope* scope, string label);
  ~AaSeriesBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaSeriesBlockStatement");}

  // series block stitches control-flow in a slightly different way.
  virtual void Write_Entry_Transfer_Code(ofstream& ofile);
  virtual void Write_Statement_Invocations(ofstream& ofile);
  virtual void Write_Exit_Check_Condition(ofstream& ofile);

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
  void Write_VC_Control_Path_Optimized_Base(ostream& ofile);

};


class AaParallelBlockStatement: public AaBlockStatement
{
 public:
  AaParallelBlockStatement(AaScope* scope, string label);
  ~AaParallelBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaParallelBlockStatement");}

  // inherits the C function stuff from block statement.
  virtual void Write_Entry_Transfer_Code(ofstream& ofile);
  virtual void Write_Statement_Invocations(ofstream& ofile);
  virtual void Write_Exit_Check_Condition(ofstream& ofile);

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

  virtual void Write_C_Struct_Extra(ofstream& ofile);

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
  virtual void Write_Entry_Transfer_Code(ofstream& ofile);

  virtual string Get_C_Name()
  {
    return("_join_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }


  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);

  virtual void Write_VC_Links(string hier_id, ostream& ofile);
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual string Get_VC_Name() {return("join_fork_stmt_" + Int64ToStr(this->Get_Index()));}

};



class AaPlaceStatement: public AaStatement
{
  string _label;
 public:
  AaPlaceStatement(AaBranchBlockStatement* parent_tpr, string lbl);
  ~AaPlaceStatement();
  virtual string Get_Label() {return(this->_label);}

  void Mark_As_Merged()
  {
    ((AaBranchBlockStatement*)this->Get_Scope())->Add_Merged_Place(this->Get_Label());
  }

  virtual string Get_Place_Name() { return(this->Get_Label()); }
  virtual string Get_Place_Name_Ref() {return(this->Get_Struct_Dereference() + this->Get_Place_Name()); }

  virtual void Print(ostream& ofile) 
  { 
    this->Err_Check(); 
    ofile << this->Tab() << "$place[" << this->Get_Label() << "]"  << endl; 
  }
  virtual string Kind() {return("AaPlaceStatement");}
  virtual void Map_Source_References() {} // do nothing

  virtual bool Is_Control_Flow_Statement() {return(true);}
  virtual string Get_C_Name()
  {
    return("_place_line_" +   IntToStr(this->Get_Line_Number()));
  }
  // cannot block, but will contribute a flag to the
  // structure and will also contribute a line of code
  // to the function body
  virtual void Write_C_Struct(ofstream& ofile); 
  virtual void Write_C_Function_Body(ofstream& ofile) ;

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
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
    ofile << "$P [" << this->Get_VC_Name() << "]" << endl;
  }
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile)
  {
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

  void Set_In_Do_While(bool v);
  bool Get_In_Do_While() {return(_in_do_while);}


  AaMergeStatement(AaBranchBlockStatement* scope);
  ~AaMergeStatement();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaMergeStatement");}

  void Set_Has_Entry_Place(bool v)
  {
    _has_entry_place = v;
  }


  virtual void Map_Source_References();

  virtual string Get_C_Name()
  {
    return("_merge_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual void Write_Entry_Condition(ofstream& ofile);
  virtual void Write_Cleanup_Code(ofstream& ofile);
  virtual void Write_Entry_Transfer_Code(ofstream& ofile);

  void Write_C_Struct(ofstream& ofile);

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }

  virtual string Get_Merge_From_Entry() { return(this->Get_C_Name() + "_from_entry"); }
  virtual string Get_Merge_From_Entry_Ref() 
  {
    return(this->Get_Struct_Dereference() +  this->Get_Merge_From_Entry());
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
  AaMergeStatement* _parent_merge;
  AaObjectReference* _target;
  vector<pair<string,AaExpression*> > _source_pairs;
  set<string> _merged_labels;
  bool _in_do_while;

 public:
  AaPhiStatement(AaBranchBlockStatement* scope, AaMergeStatement* pm);
  ~AaPhiStatement();

  void Set_Target(AaObjectReference* tgt);
  AaObjectReference* Get_Target() {return(_target);}

  void Add_Source_Pair(string label, AaExpression* expr);
  bool Is_Merged(string label)
  {
    return(_merged_labels.find(label) != _merged_labels.end());
  }

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPhiStatement");}
  virtual void Map_Source_References();

  virtual string Get_C_Name()
  {
    return("_phi_line_" +   IntToStr(this->Get_Line_Number()));
  }
  virtual void PrintC(ofstream& ofile, string tab_string);
  void Write_C_Struct(ofstream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile);
  virtual void Write_VC_Control_Path_Optimized(ostream& ofile);

  virtual void Write_VC_Constant_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Wire_Declarations(ostream& ofile);
  virtual void Write_VC_Datapath_Instances(ostream& ofile);

  virtual void Write_VC_Source_Control_Paths(ostream& ofile);

  virtual void Propagate_Constants();
  virtual bool Is_Constant();

  virtual string Get_VC_Name() {return("phi_stmt_" + Int64ToStr(this->Get_Index()));}

  void Set_In_Do_While(bool v) { _in_do_while = v;}
  bool Get_In_Do_While() {return(_in_do_while);}

  // this is the big one! added to support loop pipelining.
  virtual void Write_VC_Control_Path_Optimized(bool pipeline_flag,
					       set<AaRoot*>& visited_elements,
					       map<string, vector<AaExpression*> >& ls_map,
					       map<string,vector<AaExpression*> >& pipe_map,
					       ostream& ofile);



  // called only if it appears in a do while loop.
  virtual void Write_VC_Links_Optimized(string hier_id, ostream& ofile);

  virtual string Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
  {
    return(this->Get_VC_Name() + "_enable_");
  }
  virtual string Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
  {
    return(this->Get_VC_Name() + "_enable_");
  }
  friend class AaMergeStatement;
};


class AaSwitchStatement: public AaStatement
{
  AaExpression* _select_expression;
  vector<pair<AaExpression*, AaStatementSequence*> > _choice_pairs;
  AaStatementSequence* _default_sequence;

 public:

  void Set_Select_Expression(AaExpression* expr) {this->_select_expression = expr;}
  void Add_Choice(AaExpression* cond, AaStatementSequence* sseq)
  {
    this->_choice_pairs.push_back(pair<AaExpression*,AaStatementSequence*>(cond,sseq));
  }

  void Set_Default_Sequence(AaStatementSequence* sseq)
  {
    this->_default_sequence = sseq;
  }

  AaSwitchStatement(AaBranchBlockStatement* scope);
  ~AaSwitchStatement();
  virtual void Coalesce_Storage();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaSwitchStatement");}
  virtual void Map_Source_References();


  virtual string Get_C_Name()
  {
    return("_switch_line_" +   IntToStr(this->Get_Line_Number()));
  }


  virtual bool Is_Control_Flow_Statement() {return(true);}

  virtual void Write_C_Struct(ofstream& ofile);
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }


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

  void Set_Test_Expression(AaExpression* te) { this->_test_expression = te; }
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

  AaIfStatement(AaBranchBlockStatement* scope);
  ~AaIfStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaIfStatement");}
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

  virtual void Write_C_Struct(ofstream& ofile);
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }

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

 public:

  void Set_Test_Expression(AaExpression* te) { this->_test_expression = te; }
  void Set_Merge_Statement(AaMergeStatement* ms) { this->_merge_statement = ms; }
  void Set_Loop_Body_Sequence(AaStatementSequence* lbs) { this->_loop_body_sequence = lbs; }

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
  virtual void Map_Source_References()
  {
    if(this->_test_expression)
      this->_test_expression->Map_Source_References(this->_source_objects);
    if(this->_merge_statement)
    	this->_merge_statement->Map_Source_References();
    if(this->_loop_body_sequence)
      this->_loop_body_sequence->Map_Source_References();
  }

  virtual void Coalesce_Storage();


  virtual string Get_C_Name()
  {
    return("_do_while_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual bool Is_Control_Flow_Statement() {return(true);}

  virtual void Write_VC_Constant_Declarations(ostream& ofile);
  virtual void Write_C_Struct(ofstream& ofile);
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }

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

  // first in-memory transformation.  Add delayed versions
  // of implicit variables in order to help pipelining.
  void Equalize_Paths_For_Pipelining();

  void Add_Delayed_Versions(AaRoot* curr, 
				map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map,
				map<AaRoot*, int>& longest_paths_from_root_map);

   void Find_Longest_Paths( map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
				map<AaRoot*, int>& longest_paths_from_root_map);
};



#endif
