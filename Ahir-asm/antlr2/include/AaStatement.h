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


  ~AaStatement();

  virtual string Kind() {return("AaStatement");}
  virtual void Map_Source_References() { assert(0);}
};

// statement sequence (is used in block statements which lead to programs)
class AaStatementSequence: public AaScope
{
  vector<AaStatement*> _statement_sequence;
 public:

  AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence);
  ~AaStatementSequence();

  unsigned int Get_Statement_Count() { return this->_statement_sequence.size(); }
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
};



class AaCallStatement: public AaStatement
{
  string _function_name;
  vector<AaObjectReference*> _input_args;
  vector<AaObjectReference*> _output_args;
 public:
  unsigned int Get_Number_Of_Input_Args() {return(this->_input_args.size());}
  unsigned int Get_Number_Of_Output_Args() {return(this->_output_args.size());}
  string Get_Function_Name() {return(this->_function_name);}
  
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
    return((this->_statement_sequence ? this->_statement_sequence->Get_Statement_Count() : 0)); }
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
 	cerr << "Error: object " << obj->Get_Name() << " already exists in " << this->Get_Label() << endl;
	AaRoot::Error();
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
};

class AaSeriesBlockStatement: public AaBlockStatement
{
 public:
  AaSeriesBlockStatement(AaScope* scope, string label);
  ~AaSeriesBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaSeriesBlockStatement");}
};

class AaParallelBlockStatement: public AaBlockStatement
{
 public:
  AaParallelBlockStatement(AaScope* scope, string label);
  ~AaParallelBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaParallelBlockStatement");}
};

class AaForkBlockStatement: public AaBlockStatement
{
 public:
  AaForkBlockStatement(AaScope* scope , string label);
  ~AaForkBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaForkBlockStatement");}
};

class AaBranchBlockStatement: public AaBlockStatement
{
 public:
  AaBranchBlockStatement(AaScope* scope, string label);
  ~AaBranchBlockStatement();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaBranchBlockStatement");}
};


class AaJoinForkStatement: public AaBlockStatement
{
  vector<string> _join_labels;
 public:
  void Add_Join_Label(string jl) { this->_join_labels.push_back(jl); }

  virtual void Print(ostream& ofile);
  AaJoinForkStatement(AaForkBlockStatement* scope);
  ~AaJoinForkStatement();
  virtual string Kind() {return("AaJoinForkStatement");}

};

class AaMergeStatement: public AaBlockStatement
{
  vector<string> _merge_label_vector; // to preserve the order
  set<string,StringCompare> _merge_label_set;

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
};

class AaPhiStatement: public AaStatement
{
  AaSimpleObjectReference* _target;
  vector<pair<string,AaExpression*> > _source_pairs;

 public:
  AaPhiStatement(AaBranchBlockStatement* scope);
  ~AaPhiStatement();
  void Set_Target(AaSimpleObjectReference* tgt) 
  { 
    this->_target = tgt; 
    this->Map_Target(tgt); 
  }
  void Add_Source_Pair(string label, AaExpression* expr)
  {
    this->_source_pairs.push_back(pair<string,AaExpression*>(label,expr));
  }
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaPhiStatement");}
  virtual void Map_Source_References();
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
      this->_select_expression->Map_Source_References();

    for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
      this->_choice_pairs[i].second->Map_Source_References();
    if(this->_default_sequence)
      this->_default_sequence->Map_Source_References();
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
      this->_test_expression->Map_Source_References();
    this->_if_sequence->Map_Source_References();
    if(this->_else_sequence)
      this->_else_sequence->Map_Source_References();
  }
};


// branch statement
class AaPlaceStatement: public AaStatement
{
  string _label;
 public:
  AaPlaceStatement(AaBranchBlockStatement* parent_tpr, string lbl);
  ~AaPlaceStatement();
  virtual string Get_Label() {return(this->_label);}

  virtual void Print(ostream& ofile) { ofile << this->Tab() << "$place[" << this->Get_Label() << "]"  << endl; }
  virtual string Kind() {return("AaPlaceStatement");}
  virtual void Map_Source_References() {} // do nothing
};

#endif
