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

 public:
  AaStatement(AaScope* scope);
  
  // add map entries in parent´s lookup map for easy access
  virtual void Map_Targets() 
  {
    // derived statements will map their targets
    // in their containing scopes.
    assert(0); 
  }

  virtual void Map_Target(AaObjectReference* obj_ref);
  virtual string Tab();

  virtual void Set_Tab_Depth(unsigned int td) { this->_tab_depth = td; }
  virtual unsigned int Get_Tab_Depth() { return(this->_tab_depth); }
  virtual void Increment_Tab_Depth() { this->_tab_depth += 1; }

  virtual bool Is_Statement() { return(true);}



  ~AaStatement();

  virtual string Kind() {return("AaStatement");}
  virtual void Map_Source_References() { assert(0);}

  virtual void Write_C_Struct(ofstream& ofile);
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

  virtual void PrintC(ofstream& ofile, string tab_string) { assert(0); }

  virtual string Get_Source_Info() 
  {
     return(string(" file ") 
	   + this->Get_File_Name() 
	   + ", line " 
	   + 
	   IntToStr(this->Get_Line_Number())); 
  }

  virtual string Get_Line_Directive()
  {
    return(string("#line ") + IntToStr(this->Get_Line_Number()) + " \"" + this->Get_File_Name() + "\"\n");
  }

  virtual void Write_VC_Pipe_Declarations(ostream& ofile)
  {
    // do nothing.
  }

  virtual string Get_VC_Name();
  virtual void Write_VC_Control_Path(ostream& ofile) { assert(0);}

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

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaStatementSequence");}
  virtual void Map_Source_References() 
  {
    for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
      this->_statement_sequence[i]->Map_Source_References();
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

  virtual void  Write_Parallel_Entry_Transfer_Code(ofstream& ofile);
  virtual void  Write_Series_Entry_Transfer_Code(ofstream& ofile);

  virtual void Write_Parallel_Statement_Invocations(ofstream& ofile);
  virtual void Write_Series_Statement_Invocations(ofstream& ofile);

  virtual void  Write_Parallel_Exit_Check_Condition(ofstream& ofile);
  virtual void  Write_Series_Exit_Check_Condition(ofstream& ofile);

  virtual void Write_Clear_Exit_Flags_Code(ostream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile); 

  AaStatement* Get_Next_Statement(AaStatement* stmt);
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
};


// assignment statement
class AaAssignmentStatement: public AaStatement
{
  AaObjectReference* _target;
  AaExpression* _source;
 public:
  AaObjectReference* Get_Target() {return(this->_target);}
  AaExpression* Get_Source() {return(this->_source);}

  virtual void Map_Targets() 
  {
    // only one target which can serve as a handle
    // to this statement
    this->Map_Target(this->Get_Target());
  }

  AaAssignmentStatement(AaScope* scope,AaObjectReference* target, AaExpression* source, int lineno);
  ~AaAssignmentStatement();

  virtual void Print(ostream& ofile); 
  virtual string Kind() {return("AaAssignmentStatement");}
  virtual void Map_Source_References();


  virtual string Get_C_Name()
  {
    return("_assign_line_" +   IntToStr(this->Get_Line_Number()));
  }

  // return true if one of the sources or targets is a pipe.
  virtual bool Can_Block();
  virtual void PrintC(ofstream& ofile, string tab_string);

  virtual void Write_C_Struct(ofstream& ofile);

  virtual void Write_VC_Control_Path(ostream& ofile);
};



class AaCallStatement: public AaStatement
{

  string _function_name;
  AaRoot* _called_module;
  vector<AaObjectReference*> _input_args;
  vector<AaObjectReference*> _output_args;
 public:
  unsigned int Get_Number_Of_Input_Args() {return(this->_input_args.size());}
  unsigned int Get_Number_Of_Output_Args() {return(this->_output_args.size());}
  string Get_Function_Name() {return(this->_function_name);}
  void Set_Called_Module(AaRoot* m) { this->_called_module = m; }
  AaRoot* Get_Called_Module() {return(this->_called_module);}

  AaCallStatement(AaScope* scope_tpr,
		  string func_name,
		  vector<AaObjectReference*>& inargs, 
		  vector<AaObjectReference*>& outargs,
		  int lineno);

  ~AaCallStatement();
  
  AaObjectReference* Get_Input_Arg(unsigned int index);
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

};


class AaBlockStatement: public AaStatement
{
 protected:
  string _label;
  vector<AaObject*> _objects;
  AaStatementSequence* _statement_sequence;

 public:
  virtual string Get_Label() { return(this->_label);}
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
  virtual void Add_Object(AaObject* obj) 
  { 
    if(this->Find_Child_Here(obj->Get_Name()) == NULL)
    { 
    	this->_objects.push_back(obj);
    	this->Map_Child(obj->Get_Name(),obj);
    }
    else
    {
      AaRoot::Error("object " + obj->Get_Name() + " already exists in " + this->Get_Label(),obj);
    }
  }
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

  virtual void Write_VC_Pipe_Declarations(ostream& ofile);  

  virtual string Get_VC_Name() {return(this->_label);}

  virtual AaStatement* Get_Next_Statement(AaStatement* stmt)
  {
    return(this->_statement_sequence->Get_Next_Statement(stmt));
  }
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
    ofile << ";;[" << this->Get_VC_Name() << "] {";
    this->_statement_sequence->Write_VC_Control_Path(ofile);
    ofile << "} // end series block " << this->Get_VC_Name() << endl;
  }

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
    ofile << "||[" << this->Get_VC_Name() << "] {";
    this->_statement_sequence->Write_VC_Control_Path(ofile);
    ofile << "} // end series block " << this->Get_VC_Name() << endl;
  }

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
};

class AaBranchBlockStatement: public AaSeriesBlockStatement
{
 public:
  AaBranchBlockStatement(AaScope* scope, string label);
  ~AaBranchBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaBranchBlockStatement");}

  virtual void Write_VC_Control_Path(ostream& ofile);
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

  virtual string Get_VC_Name() {return(this->_label);}

};



class AaPlaceStatement: public AaStatement
{
  string _label;
  int _merge_count;
 public:
  AaPlaceStatement(AaBranchBlockStatement* parent_tpr, string lbl);
  ~AaPlaceStatement();
  virtual string Get_Label() {return(this->_label);}
  void Increment_Merge_Count()
  {

    if(this->_merge_count > 0)
      {
	AaRoot::Error("place merges into more than one merge statement!",this);
      }

    this->_merge_count++;
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
    if(this->_merge_count == 0)
      {
	AaRoot::Error("place is not cleared by any merge ", this);
      }
  }

  virtual string Get_VC_Name() {return(this->Get_Label());}
  void Write_VC_Control_Path(ostream& ofile)
  {
    ofile << "$P [" << this->Get_VC_Name() << "]" << endl;
  }

};


class AaMergeStatement: public AaSeriesBlockStatement
{
  vector<string> _merge_label_vector; // to preserve the order
  set<string,StringCompare> _merge_label_set;
  vector<AaPlaceStatement*> _wait_on_statements;

  unsigned char _wait_on_entry;

 public:
  void Add_Merge_Label(string lbl) 
  { 
    if(this->_merge_label_set.find(lbl) == this->_merge_label_set.end())
      {
	this->_merge_label_set.insert(lbl); 
	this->_merge_label_vector.push_back(lbl);
      }
  }

  AaMergeStatement(AaBranchBlockStatement* scope);
  ~AaMergeStatement();

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaMergeStatement");}


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


};

class AaPhiStatement: public AaStatement
{
  AaMergeStatement* _parent_merge;
  AaSimpleObjectReference* _target;
  vector<pair<string,AaExpression*> > _source_pairs;
  set<string> _merged_labels;

 public:
  AaPhiStatement(AaBranchBlockStatement* scope, AaMergeStatement* pm);
  ~AaPhiStatement();
  void Set_Target(AaSimpleObjectReference* tgt) 
  { 
    this->_target = tgt; 
    this->Map_Target(tgt); 
  }
  void Add_Source_Pair(string label, AaExpression* expr)
  {
    _merged_labels.insert(label);
    this->_source_pairs.push_back(pair<string,AaExpression*>(label,expr));
  }
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
};


class AaSwitchStatement: public AaStatement
{
  AaExpression* _select_expression;
  vector<pair<AaConstantLiteralReference*, AaStatementSequence*> > _choice_pairs;
  AaStatementSequence* _default_sequence;

 public:

  void Set_Select_Expression(AaExpression* expr) {this->_select_expression = expr;}
  void Add_Choice(AaConstantLiteralReference* cond, AaStatementSequence* sseq)
  {
    this->_choice_pairs.push_back(pair<AaConstantLiteralReference*,AaStatementSequence*>(cond,sseq));
  }

  void Set_Default_Sequence(AaStatementSequence* sseq)
  {
    this->_default_sequence = sseq;
  }

  AaSwitchStatement(AaBranchBlockStatement* scope);
  ~AaSwitchStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaSwitchStatement");}
  virtual void Map_Source_References()
  {
    if(this->_select_expression)
      this->_select_expression->Map_Source_References(this->_source_objects);

    for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
      this->_choice_pairs[i].second->Map_Source_References();
    if(this->_default_sequence)
      this->_default_sequence->Map_Source_References();
  }


  virtual string Get_C_Name()
  {
    return("_switch_line_" +   IntToStr(this->Get_Line_Number()));
  }


  virtual void Write_C_Struct(ofstream& ofile);
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }

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

  AaIfStatement(AaBranchBlockStatement* scope);
  ~AaIfStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaIfStatement");}
  virtual void Map_Source_References()
  {
    if(this->_test_expression)
      this->_test_expression->Map_Source_References(this->_source_objects);
    this->_if_sequence->Map_Source_References();
    if(this->_else_sequence)
      this->_else_sequence->Map_Source_References();
  }


  virtual string Get_C_Name()
  {
    return("_if_line_" +   IntToStr(this->Get_Line_Number()));
  }

  virtual void Write_C_Struct(ofstream& ofile);
  virtual void Write_C_Function_Body(ofstream& ofile);

  virtual string Get_Struct_Dereference()
  {
    return(this->Get_Scope()->Get_Struct_Dereference());
  }


};



#endif
