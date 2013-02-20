#include <AaProgram.h>
#include <Aa2VC.h>


//---------------------------------------------------------------------
// AaStatement
//---------------------------------------------------------------------
AaStatement::AaStatement(AaScope* p): AaScope(p) 
{
  this->_tab_depth = ((p != NULL) ? p->Get_Depth()+1 : 1);
  _index_in_sequence = -1;
  _guard_expression = NULL;
  _guard_complement = false;
  
}
AaStatement::~AaStatement() {};
string AaStatement::Tab()
{
  return(Tab_(this->Get_Tab_Depth()));
}

// Algorithm:
//  Find search-scope:
//  Find child in search-scope
//  if ref is array ref and child is null, throw error
//  if ref is array ref and child is not null, link target
//  if ref is not array ref
//       if child is null, go ahead and declare implicit variable
//       if child is not null
//            if child is declared object/iface, link to it and
//               check link count.
//            if child is not declared object/iface
//                if child is not from this->Get_Scope()
//                   declare implicit variable
//               else
//                   redeclaration error!
//
// Added: multiple writes to the same port are permitted
//        if the module to which the port belongs is 
//        a MACRO..
void AaStatement::Map_Target(AaObjectReference* obj_ref) 
{

  bool is_pointer_deref = obj_ref->Is("AaPointerDereferenceExpression");
  if(is_pointer_deref)
    return;

  string obj_ref_root_name =obj_ref->Get_Object_Root_Name();
  bool err_flag = false;
  AaScope* search_scope = this->Get_Scope()->Get_Ancestor_Scope(obj_ref->Get_Search_Ancestor_Level());
  AaRoot* child = NULL;

  if(search_scope != NULL)
    child = search_scope->Find_Child(obj_ref_root_name);
  else
    child = AaProgram::Find_Object(obj_ref_root_name);

  bool unsuitable_target = (child != NULL) && !(child->Is_Object() || child->Is_Expression());
  if(unsuitable_target)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " is not an object/expression",this);
      err_flag = true;
    }
  
  if(child != NULL && child->Is("AaPipeObject"))
    {
      AaScope* root = this->Get_Root_Scope();
      assert(root->Is("AaModule"));
      ((AaPipeObject*)child)->Add_Writer((AaModule*)root);
      ((AaModule*)root)->Add_Write_Pipe((AaPipeObject*)child);
    }

  bool is_array_ref = obj_ref->Is("AaArrayObjectReference");

  bool is_simple_ref = obj_ref->Is("AaSimpleObjectReference");

  bool from_above = ((child != NULL) && (child->Is_Expression()) && 
		     (((AaExpression*)child)->Get_Scope() != this->Get_Scope()));

  bool map_flag = (((child == NULL) || from_above) && 
		   (search_scope == this->Get_Scope()) && 
		   !(is_array_ref) && !(is_pointer_deref));

  bool err_no_target_in_scope = ((child == NULL) && 
				 (is_array_ref || is_pointer_deref 
				  || (search_scope != this->Get_Scope())));

  bool err_redeclaration = ((child !=NULL) && 
			    (child->Is_Expression()) &&
			    is_simple_ref &&
			    (((AaExpression*)child)->Get_Scope() == this->Get_Scope()));

  bool err_write_to_constant = ((child !=NULL) && child->Is("AaConstantObject"));
  bool err_write_to_input_port = ((child != NULL) &&
				  (child->Is("AaInterfaceObject") && 
				   (((AaInterfaceObject*)child)->Get_Mode() == "in")));

  bool err_multiple_refs_to_ports =((child != NULL) &&  
				    child->Is("AaInterfaceObject") && 
				    !((AaModule*)((AaInterfaceObject*)child)->Get_Scope())->Get_Macro_Flag() &&
				    (child->Get_Number_Of_Target_References() > 0));
  
  
  if(err_no_target_in_scope)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " not found ",this);
      err_flag = true;
    }
  if(err_redeclaration)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " redeclared ",this);
      err_flag = true;
    }
  if(err_write_to_constant)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " is a constant, cannot be written to ",this);
      err_flag = true;
    }
  if(err_write_to_input_port)
    {
      AaRoot::Error( string("specified target ") + obj_ref_root_name + " is a module input, cannot be written to ",this);
      err_flag = true;
    }
  if(err_multiple_refs_to_ports)
    {
      AaRoot::Error( string("multiple writes to module port ") + obj_ref_root_name + " are not permitted",this);
      err_flag = true;
    }

  if(child != NULL && child->Is_Interface_Object())
    {
      ((AaInterfaceObject*)child)->Set_Unique_Driver_Statement(this);
    }

  if(map_flag)
    {
      this->Get_Scope()->Map_Child(obj_ref_root_name,obj_ref);
      obj_ref->Set_Object(this);
    }
  else if((child != NULL) && !err_flag)
    {
      obj_ref->Set_Object(child);

      if(child->Is_Expression())
	obj_ref->Add_Target((AaExpression*) child);


      if(child->Is_Storage_Object())
	((AaStorageObject*)child)->Set_Is_Written_Into(true);


      // obj_ref -> child
      child->Add_Target_Reference(obj_ref); // obj_ref uses child as a target
      obj_ref->Add_Source_Reference(child); // child uses obj_ref as a source
      

      if(child->Is_Object())
	{
	  this->_target_objects.insert(child);
	}
    }

}

void AaStatement::Write_Pipe_Read_Condition_Check(ofstream& ofile , string tab_string)
{
  ofile << tab_string << "1";
  for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
      siter != this->_source_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << " && ";
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref();
	}
    }

}
void AaStatement::Write_Pipe_Write_Condition_Check(ofstream& ofile , string tab_string)
{

  ofile << tab_string << "1";
  for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
      siter != this->_target_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << " && !";
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref();
	}
    }


}
void AaStatement::Write_Pipe_Condition_Check(ofstream& ofile , string tab_string)
{
  ofile << tab_string << "1";
  for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
      siter != this->_source_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << " && ";
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref() << endl;
	}
    }

  for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
      siter != this->_target_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << " && !";
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref();
	}
    }
}


void AaStatement::Write_Pipe_Read_Condition_Update(ofstream& ofile , string tab_string)
{
  for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
      siter != this->_source_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << tab_string;
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref() << " = 0;" << endl;
	}
    }
}
void AaStatement::Write_Pipe_Write_Condition_Update(ofstream& ofile , string tab_string)
{
  for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
      siter != this->_target_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << tab_string;
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref() << " = 1;" << endl;
	}
    }
}
void AaStatement::Write_Pipe_Condition_Update(ofstream& ofile, string tab_string)
{
  for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
      siter != this->_target_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << tab_string;
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref() << " = 1;" << endl;
	}
    }

  for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
      siter != this->_source_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	{
	  ofile << tab_string;
	  ofile << ((AaPipeObject*)(*siter))->Get_Valid_Flag_Name_Ref() << " = 0;" << endl;
	}
    }
}

// no contribution unless instruction can block
void AaStatement::Write_C_Struct(ofstream& ofile)
{
  // the statement needs an entry flag and an exit flag!
  ofile << this->Tab() << "unsigned int " << this->Get_Entry_Name() << ": 1; " << endl;
  ofile << this->Tab() << "unsigned int " << this->Get_In_Progress_Name() << ": 1; " << endl;
  ofile << this->Tab() << "unsigned int " << this->Get_Exit_Name()  << ": 1; " << endl;
}

void AaStatement::Write_C_Function_Header(ofstream& ofile)
{
  // nothing is needed, no separate function is required.
}

// default behaviour used for all simple statements
// call, block statements will redefine.
void AaStatement::Write_C_Function_Body(ofstream& ofile)
{
  // if all the pipes needed to be accessed are available.
  // if yes, then execute the assignment, clear the entry flag
  // update the pipe flags, and set the exit flag.
  // if no, then dont do anything.
  // if entry flag is not set, dont do anything.
  // if it cannot block, just write the execution code.
  
  // check if entry flag is set 
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// Begin Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;

  ofile << "if (" << this->Get_Entry_Name_Ref() << ")" <<  endl;
  ofile << "{" << endl;

  // check if pipe read and write condition flags are set.
  ofile << "if (" ;
  // check condition flags (if they are ok for read and write)
  this->Write_Pipe_Condition_Check(ofile,"");
  ofile << ") {" << endl;
  this->PrintC(ofile, "");
  this->Write_Pipe_Condition_Update(ofile,"");
  ofile << this->Get_Entry_Name_Ref() << " = 0;" << endl;
  ofile << this->Get_Exit_Name_Ref()  << " = 1;" << endl;
  ofile << "}" << endl;
  ofile << "}" << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// End Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
}



void AaStatement::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{
  for(set<AaRoot*>::iterator iter = _source_references.begin();
      iter != _source_references.end();
      iter++)
    {
      if((*iter)->Is_Expression())
	((AaExpression*)(*iter))->Propagate_Addressed_Object_Representative(obj,this);
    }
}



string AaStatement::Get_VC_Guard_String()
{
	string ret_string;
	AaExpression* ge = this->Get_Guard_Expression();
	bool not_flag = this->Get_Guard_Complement();
	if(ge)
	{
		if(not_flag)
			ret_string = "$guard ( ~ " + ge->Get_VC_Driver_Name() + " ) " ;
		else
			ret_string = "$guard ( " + ge->Get_VC_Driver_Name() + " ) " ;
	}
	return(ret_string);
}
//---------------------------------------------------------------------
// AaStatementSequence
//---------------------------------------------------------------------
AaStatementSequence::AaStatementSequence(AaScope* scope, vector<AaStatement*>& statement_sequence):AaScope(scope)
{
  for(unsigned int i=0; i < statement_sequence.size();i++)
    {
      AaStatement* stmt = statement_sequence[i];
      stmt->Set_Index_In_Sequence(i);

      this->_statement_sequence.push_back(stmt);
    }
}
AaStatementSequence::~AaStatementSequence() {}
  
void AaStatementSequence::Print(ostream& ofile)
{
  for(unsigned int i=0; i < this->_statement_sequence.size();i++)
    this->_statement_sequence[i]->Print(ofile);
}

void AaStatementSequence::Write_Clear_Exit_Flags_Code(ostream& ofile)
{
  for(unsigned int i= 0; i < this->Get_Statement_Count(); i++)
    {
      if(!this->Get_Statement(i)->Is("AaPlaceStatement"))
	ofile << this->Get_Statement(i)->Get_Exit_Name_Ref() << " = 0;"  << endl;	  
    }
}

void AaStatementSequence::Write_Parallel_Entry_Transfer_Code(ofstream& ofile)
{
  for(unsigned int i= 0; i < this->Get_Statement_Count(); i++)
    {
      // set entry flag of all subsidiaries
      ofile << this->Get_Statement(i)->Get_Entry_Name_Ref() << " = 1;"  << endl;	  
    }
}
void AaStatementSequence::Write_Series_Entry_Transfer_Code(ofstream& ofile)
{
  // look for first non-null statement
  AaStatement* first_statement = NULL;
  for(unsigned int i= 0; i < this->Get_Statement_Count(); i++)
    {
      if(first_statement == NULL)
	first_statement = this->Get_Statement(i);
    }

  if(first_statement != NULL)
    {
      // set entry flag of first statement
      ofile << first_statement->Get_Entry_Name_Ref() << " = 1;"  << endl;
    }
}
void AaStatementSequence::Write_Parallel_Statement_Invocations(ofstream& ofile)
{
  AaStatement* curr_statement;
  for(unsigned int i= 0; i < this->Get_Statement_Count(); i++)
    {
      curr_statement = this->Get_Statement(i);
      curr_statement->Write_C_Function_Body(ofile);
    }
}
void AaStatementSequence::Write_Series_Statement_Invocations(ofstream& ofile)
{

  AaStatement* prev_statement = NULL;
  AaStatement* curr_statement = NULL;
  
  for(unsigned int i= 0; i < this->Get_Statement_Count(); i++)
    {
      curr_statement = this->Get_Statement(i);
	  
      
      if(prev_statement != NULL)
	{
	  // check if previous statement has finished before passing token
	  // to next statement
	  ofile << "if (" << prev_statement->Get_Exit_Name_Ref() << ") {" << endl;
	  
	  ofile << prev_statement->Get_Exit_Name_Ref() <<  " = 0;" << endl;
	  ofile << curr_statement->Get_Entry_Name_Ref() << " = 1;" << endl << "}" << endl;
	  
	  //Note: the exit flag is not reset here!
	}
      curr_statement->Write_C_Function_Body(ofile);
      prev_statement = curr_statement;
    }
}

void AaStatementSequence::Write_Parallel_Exit_Check_Condition(ofstream& ofile)
{
  ofile << "(1";
  for(int i= (int) this->Get_Statement_Count() - 1; i >= 0 ; i--)
    {
      ofile << " && "
	    << this->Get_Statement(i)->Get_Exit_Name_Ref() ;
    }
  
  ofile << ")";
}
void AaStatementSequence::Write_Series_Exit_Check_Condition(ofstream& ofile)
{
  AaStatement* last_statement = NULL;
  if(this->Get_Statement_Count() > 0)
    {
      for( int i= (int) this->Get_Statement_Count() - 1; i >= 0 ; i--)
	{
	  last_statement = this->Get_Statement(i);
	  break;
	}

    }
  if(last_statement != NULL)
    {
      if(last_statement->Is("AaPlaceStatement"))
	ofile << "0";
      else 
	ofile << last_statement->Get_Exit_Name_Ref();
    }
  else
    ofile << "1";
}

void AaStatementSequence::Write_VC_Control_Path(ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Control_Path(ofile);
}
void AaStatementSequence::Write_VC_Pipe_Declarations(ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Pipe_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Memory_Space_Declarations(ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Memory_Space_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Wire_Declarations(ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Wire_Declarations(ofile);
}
void AaStatementSequence::Write_VC_Datapath_Instances(ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Datapath_Instances(ofile);
}
void AaStatementSequence::Write_VC_Links(string hier_id, ostream& ofile)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
    this->_statement_sequence[i]->Write_VC_Links(hier_id, ofile);
}
  
// TODO: get rid of this..
void AaStatementSequence::Write_VC_Control_Path_As_Fork_Block(bool pipe_flag, string region_id, ostream& ofile)
{
	assert(0);
}

AaStatement* AaStatementSequence::Get_Next_Statement(AaStatement* stmt)
{
  AaStatement* ret_stmt = NULL;
  int idx = stmt->Get_Index_In_Sequence();

  assert(idx >= 0);

  if(idx < (this->Get_Statement_Count() -1))
    {
      ret_stmt = this->Get_Statement(idx+1);
    }
  
  return(ret_stmt);
}

AaStatement* AaStatementSequence::Get_Previous_Statement(AaStatement* stmt)
{
  AaStatement* ret_stmt = NULL;
  int idx = stmt->Get_Index_In_Sequence();

  assert(idx >= 0);

  if(idx > 0)
    {
      ret_stmt = this->Get_Statement(idx-1);
    }
  
  return(ret_stmt);
}

void AaStatementSequence::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
  for(unsigned int i = 0; i < this->_statement_sequence.size(); i++)
  {
    AaStatement* stmt = this->_statement_sequence[i];
    stmt->Get_Target_Places(target_places);
    if(this->_statement_sequence[i]->Is("AaPlaceStatement"))
	break;
  }
}


void AaStatementSequence::Insert_Statements_After(AaStatement* pred, vector<AaStatement*>& nstmts)
{
	
	for(vector<AaStatement*>::iterator iter = _statement_sequence.begin(), fiter = _statement_sequence.end();
		iter != fiter; iter++)
	{
		if(*iter == pred)
		{
			iter++;
			_statement_sequence.insert(iter, nstmts.begin(), nstmts.end());	
			break;
		}
	}	
	this->Renumber_Statements();
}
  
void AaStatementSequence::Insert_Statements_Before(AaStatement* succ, vector<AaStatement*>& nstmts)
{
	for(vector<AaStatement*>::iterator iter = _statement_sequence.begin(), fiter = _statement_sequence.end();
		iter != fiter; iter++)
	{
		if(*iter == succ)
		{
			_statement_sequence.insert(iter, nstmts.begin(), nstmts.end());	
			break;
		}
	}	
	this->Renumber_Statements();
}

void AaStatementSequence::Delete_Statement(AaStatement* stmt)
{
	for(vector<AaStatement*>::iterator iter = _statement_sequence.begin(), fiter = _statement_sequence.end();
		iter < fiter; iter++)
	{
		if(*iter == stmt)
		{
			_statement_sequence.erase(iter);
			break;
		}
	}
	this->Renumber_Statements();
}

//---------------------------------------------------------------------
// AaNullStatement: public AaStatement
//---------------------------------------------------------------------
AaNullStatement::AaNullStatement(AaScope* parent_tpr):AaStatement(parent_tpr) {};
AaNullStatement::~AaNullStatement() {};
void AaNullStatement::Write_VC_Control_Path(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

    
  // write a blank series block...
  ofile << ";;[" << this->Get_VC_Name() << "] {"  << endl;
  ofile << "}";
}

//---------------------------------------------------------------------
// AaAssignmentStatement
//---------------------------------------------------------------------
AaAssignmentStatement::AaAssignmentStatement(AaScope* parent_tpr, AaExpression* tgt, AaExpression* src, int lineno):
  AaStatement(parent_tpr) 
{
  assert(tgt); assert(src);

  tgt->Set_Associated_Statement(this);
  src->Set_Associated_Statement(this);

  this->Set_Line_Number(lineno);

  this->_target = tgt;
  this->_target->Set_Is_Target(true);

  if(tgt->Is_Object_Reference())
    this->Map_Target((AaObjectReference*)tgt);

  tgt->Add_RHS_Source(src);
  this->_source = src;
  this->_source->Add_Target(this->_target);

}

AaAssignmentStatement::~AaAssignmentStatement() {};


string AaAssignmentStatement::Debug_Info()
{
  string ret_string;
  AaType* tt;
  AaType* st;

  tt = this->Get_Target()->Get_Type();
  AaStorageObject* tms =  this->_target->Get_Addressed_Object_Representative();

  st = this->Get_Source()->Get_Type();
  AaStorageObject* sms =  this->_source->Get_Addressed_Object_Representative();

  ret_string =  "// target-type =   ";
  ret_string += (tt ? tt->To_String() : "unknown") + "\n";
  ret_string += "// target-memory-space = ";
  if(tms != NULL && tms->Is_Foreign_Storage_Object())
    ret_string += tms->Get_Name() + "\n";
  else
    ret_string += (tms ?  IntToStr(tms->Get_Mem_Space_Index()) : " none") + "\n";

  ret_string += "// source-type = " ;
  ret_string += (st ? st->To_String() : "unknown") + "\n";
  ret_string += "// source-memory-space = ";
  if(sms != NULL && sms->Is_Foreign_Storage_Object())
    ret_string += sms->Get_Name() + "\n";
  else
    ret_string += (sms ?  IntToStr(sms->Get_Mem_Space_Index()) : " none") + "\n";

  return(ret_string);
}

void AaAssignmentStatement::Print(ostream& ofile)
{
  assert(this->Get_Target()->Get_Type() && this->Get_Source()->Get_Type());
  int twidth = this->Get_Target()->Get_Type()->Size();
  int swidth = this->Get_Source()->Get_Type()->Size();
  int awidth = AaProgram::_foreign_address_width;
  bool flag = AaProgram::_keep_extmem_inside;

  string guard_string;
  if(this->_guard_expression != NULL)
  {
	guard_string = "$guard (";
	if(this->_guard_complement)
		guard_string += " $not ";
	guard_string += this->_guard_expression->To_String();
	guard_string += ") ";
  }


  if(!flag && this->Get_Target()->Is_Foreign_Store() && this->Get_Source()->Is_Foreign_Load())
    {
      AaPointerDereferenceExpression *ptgt = (AaPointerDereferenceExpression*)(this->Get_Target());
      AaPointerDereferenceExpression *psrc = (AaPointerDereferenceExpression*)(this->Get_Source());

      // first load and then store.
      ofile << "$seriesblock [as_" << this->Get_Index() << "_ext_mem_access] {";
      ofile << guard_string << "$call extmem_load_for_type_" << this->Get_Target()->Get_Type()->Get_Index()
	    << " ( ($bitcast ( $uint<" << awidth << " > ) "
	    <<  psrc->Get_Reference_To_Object()->To_String() << ")) ("
	    << " (as_" << this->Get_Index() << "_ld_result)" << endl;
      ofile << guard_string << "$call extmem_store_for_type_" << this->Get_Source()->Get_Type()->Get_Index()
	    << " ( ($bitcast ($uint<" << awidth << "> )"
	    << ptgt->Get_Reference_To_Object()->To_String() << ") "
	    << "( as_" << this->Get_Index() << "_ld_result)) ()" << endl;
      ofile << "}" << endl;
    }
  else if(!flag && this->Get_Source()->Is_Foreign_Load())
    {
      AaPointerDereferenceExpression *psrc = (AaPointerDereferenceExpression*)(this->Get_Source());

      ofile << guard_string << "$call extmem_load_for_type_" << this->Get_Target()->Get_Type()->Get_Index() 
	    << " ( ($bitcast ($uint<" <<  awidth << "> )"
	    << "  " << psrc->Get_Reference_To_Object()->To_String() << ")) ("
	    << this->Get_Target()->To_String() << ")" << endl;
    }
  else if(!flag && this->Get_Target()->Is_Foreign_Store())
    {
      AaPointerDereferenceExpression *ptgt = (AaPointerDereferenceExpression*)(this->Get_Target());
      ofile << guard_string << "$call extmem_store_for_type_" << this->Get_Source()->Get_Type()->Get_Index()
	    << " ( ($bitcast ($uint<" << awidth << "> )"
	    << ptgt->Get_Reference_To_Object()->To_String() << ") "
	    << " " << this->Get_Source()->To_String() << ")  ()" << endl;
    }
  else
    {
      ofile << this->Tab();
      ofile << guard_string;
      this->Get_Target()->Print(ofile);
      ofile << " := ";
      this->Get_Source()->Print(ofile);
    }

  if(AaProgram::_verbose_flag)
    ofile << endl << Debug_Info();

  ofile << endl;
}

void AaAssignmentStatement::Map_Targets()
{
  // only one target which can serve as a handle
  // to this statement
  if(this->_target->Is_Object_Reference())
    this->Map_Target((AaObjectReference*)this->Get_Target());
}

void AaAssignmentStatement::Map_Source_References()
{
  this->_target->Map_Source_References_As_Target(this->_source_objects);
  AaProgram::Add_Type_Dependency(this->_target,this->_source);

  this->_source->Map_Source_References(this->_source_objects);

  if(this->_guard_expression)
  {
	this->_guard_expression->Map_Source_References(this->_source_objects);
	if(!this->_guard_expression->Is_Implicit_Variable_Reference())
	{
		AaRoot::Error("guard variable must be implicit (SSA)", this);
	}
  }

}



void AaAssignmentStatement::PrintC(ofstream& ofile, string tab_string)
{
  ofile << tab_string;
  this->_target->PrintC(ofile,"");
  ofile << " = ";
  this->_source->PrintC(ofile,"");
  ofile << "; // " << this->Get_Source_Info() << endl;
  
}

// return true if one of the sources or targets is a pipe.
bool AaAssignmentStatement::Can_Block()
{
  for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
      siter != this->_target_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	return(true);
    }

  for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
      siter != this->_source_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	return(true);
    }

  return(false);
}

void AaAssignmentStatement::Write_C_Struct(ofstream& ofile)
{
  this->AaStatement::Write_C_Struct(ofile);
  if((this->_target->Is("AaSimpleObjectReference")) &&
     (((AaObjectReference*)this->_target)->Get_Object() == this))
    {
      ((AaSimpleObjectReference*)(this->_target))->PrintC_Header_Entry(ofile);
    }
}

void AaAssignmentStatement::Write_VC_Control_Path(ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  ofile << ";;[" << this->Get_VC_Name() << "] // " << this->Get_Source_Info() << endl << " {" << endl;
  if(!this->Is_Constant())
    {

      this->_source->Write_VC_Control_Path(ofile);
      assert(this->_target->Is_Object_Reference()); //\todo later ->(a)!
      this->_target->Write_VC_Control_Path_As_Target(ofile);

      // if _source is an object-reference which refers to
      // an implicit variable, and if _target is an object
      // reference which refers to an implicit variable,
      // then you will need to instantiate a register..
      if(_source->Is_Implicit_Variable_Reference() && _target->Is_Implicit_Variable_Reference())
	{
	  ofile << "$T [req] $T [ack] // register." << endl;
	}

      // if target is a pointer then you will need a
      // register??

    }
  else
    {
      ofile << "$T [dummy] // assignment evaluates to a constant " << endl;
    }
  ofile << "} // end assignment statement " << this->Get_VC_Name() << endl;
}

void AaAssignmentStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  if(this->Is_Constant())
    {
      ofile << "// " << this->To_String() << endl;
      ofile << "// " << this->Get_Source_Info() << endl;

      // declare the target as a constant...
      Write_VC_Constant_Declaration(this->_target->Get_VC_Constant_Name(),
				    this->_target->Get_Type()->Get_VC_Name(),
				    this->_target->Get_Expression_Value()->To_VC_String() + " // " +
				    this->_target->Get_Expression_Value()->To_C_String(),
				    ofile);
    }
  else
    {
      this->_source->Write_VC_Constant_Wire_Declarations(ofile);
      this->_target->Write_VC_Constant_Wire_Declarations(ofile);
    }
}
void AaAssignmentStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
  if(!this->Is_Constant())
    {
      ofile << "// " << this->To_String() << endl;
      ofile << "// " << this->Get_Source_Info() << endl;


      if(this->_target->Is_Implicit_Variable_Reference())
	// source wire not necessary if the target is
	// an implicit variable
	this->_source->Write_VC_Wire_Declarations(true,ofile);
      else
	// if target is not implicit variable,
	// then source wire must be declared..
	this->_source->Write_VC_Wire_Declarations(false,ofile);

      // target wire is explicitly declared only if
      // target is a statement..
      this->_target->Write_VC_Wire_Declarations_As_Target(ofile);
    }
}

void AaAssignmentStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;
      ofile << "// " << this->Get_Source_Info() << endl;

      if(this->_target->Is_Implicit_Variable_Reference())
	{
	  if(this->_source->Is_Implicit_Variable_Reference())
	    {
	      // target and source are both implicit.
	      // instantiate a register..
	      Write_VC_Unary_Operator(__NOP,
				      this->_target->Get_VC_Datapath_Instance_Name(),
				      this->_source->Get_VC_Driver_Name(),
				      this->_source->Get_Type(),
				      this->_target->Get_VC_Receiver_Name(),
				      this->_target->Get_Type(),
			 		this->Get_VC_Guard_String(),
				      ofile);
	    }
	  else
	    {
	      // target is implicit, source is not..
	      // instantiate source stuf..
	      this->_source->Write_VC_Datapath_Instances(this->_target,ofile);
	    }
	}
      else
	{
	  // target is not implicit..
	  // source will have an explicit wire..
	  this->_source->Write_VC_Datapath_Instances(NULL,ofile);
	  this->_target->Write_VC_Datapath_Instances_As_Target(ofile, this->_source);
	}
    }
}

void AaAssignmentStatement::Write_VC_Links(string hier_id,ostream& ofile)
{
  if(!this->Is_Constant())
    {

      ofile << "// " << this->To_String() << endl;
      ofile << "// " << this->Get_Source_Info() << endl;


      if(hier_id != "")
	hier_id = hier_id + "/" + this->Get_VC_Name();
      else
	hier_id = this->Get_VC_Name();

      vector<string> reqs;
      vector<string> acks;
      
      if(this->_target->Is_Implicit_Variable_Reference())
	{
	  if(this->_source->Is_Implicit_Variable_Reference())
	    {
	      reqs.push_back(hier_id + "/req");
	      acks.push_back(hier_id + "/ack");
	      Write_VC_Link(this->_target->Get_VC_Datapath_Instance_Name(),
			    reqs, acks, ofile);
	      reqs.clear();
	      acks.clear();
	    }
	  else
	    {
	      this->_source->Write_VC_Links(hier_id,ofile);
	    }
	}
      else if(!this->_target->Is_Implicit_Variable_Reference())
	{
	  this->_target->Write_VC_Links_As_Target(hier_id, ofile);
	  this->_source->Write_VC_Links(hier_id, ofile);
	}
    }
}

bool AaAssignmentStatement::Is_Constant()
{
  return(this->_target->Is_Constant());
}

void AaAssignmentStatement::Propagate_Constants()
{
  this->_source->Evaluate();
  this->_target->Evaluate();
  if(this->_source->Is_Constant() && this->_target->Is_Implicit_Variable_Reference())
    {
      this->_target->Assign_Expression_Value(this->_source->Get_Expression_Value());
    }
}

string AaAssignmentStatement::Get_VC_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
  bool source_is_implicit = _source->Is_Implicit_Variable_Reference();
  bool target_is_implicit = _target->Is_Implicit_Variable_Reference();
  // if target is not implicit variable reference, then the final register
  // will be in the source, return the reenable update transition for the
  // target.
  if(!target_is_implicit)
    {
      return(_target->Get_VC_Reenable_Update_Transition_Name(visited_elements));
    }
  // if target is implicit, but source is not implicit, then
  // return the reenable update transition for the source.
  else if (!source_is_implicit)
    {
      return(_source->Get_VC_Reenable_Update_Transition_Name(visited_elements));
    }
  else
  // if both are implicit, return the start transition of this
  // statement, since this starts the registering process..
    return(this->Get_VC_Start_Transition_Name());
}

string AaAssignmentStatement::Get_VC_Reenable_Sample_Transition_Name(set<AaRoot*>& visited_elements)
{
  return(_source->Get_VC_Reenable_Sample_Transition_Name(visited_elements));
}

//---------------------------------------------------------------------
// AaCallStatement
//---------------------------------------------------------------------
AaCallStatement::AaCallStatement(AaScope* parent_tpr,
				 string func_name,
				 vector<AaExpression*>& inargs, 
				 vector<AaObjectReference*>& outargs,
				 int lineno): AaStatement(parent_tpr)
{

  this->_function_name = func_name;
  this->Set_Line_Number(lineno);
  this->_called_module = NULL;

  for(unsigned int i = 0; i < inargs.size(); i++)
    {
      inargs[i]->Set_Associated_Statement(this);
      this->_input_args.push_back(inargs[i]);
    }

  for(unsigned int i = 0; i < outargs.size(); i++)
    {
      outargs[i]->Set_Associated_Statement(this);
      outargs[i]->Set_Is_Target(true);

      this->_output_args.push_back(outargs[i]);
      this->Map_Target(outargs[i]);
    }
}
AaCallStatement::~AaCallStatement() {};
  
AaExpression* AaCallStatement::Get_Input_Arg(unsigned int index)
{
  assert(index < this->Get_Number_Of_Input_Args());
  return(this->_input_args[index]);
}
AaObjectReference* AaCallStatement::Get_Output_Arg(unsigned int index)
{
  assert(index < this->Get_Number_Of_Output_Args());
  return(this->_output_args[index]);
}
  
void AaCallStatement::Print(ostream& ofile)
{
  AaModule* cm = (AaModule*) _called_module;
  string guard_string;
  if(this->_guard_expression != NULL)
  {
	guard_string = "$guard (";
	if(this->_guard_complement)
		guard_string += " $not ";

	guard_string += this->_guard_expression->To_String();
	guard_string += ") ";
  }
 
  if((cm->Get_Inline_Flag() || cm->Get_Macro_Flag()) && AaProgram::_print_inlined_functions_in_caller)
  {

    if(cm->Get_Inline_Flag())
      cm->Set_Print_Prefix(this->Get_Function_Name() + "_" + Int64ToStr(this->Get_Index()) + "_");
    else
      {
	if(cm->Get_Number_Of_Input_Arguments() > 0) 
	  {
	    
	    for(int arg_index = 0; arg_index < cm->Get_Number_Of_Input_Arguments(); arg_index++)
	      {	
		cm->Set_Print_Remap(cm->Get_Input_Argument(arg_index), this->_input_args[arg_index]);
	      }
	  }	
	
	if(cm->Get_Number_Of_Output_Arguments() > 0)
	  {
	    for(int arg_index = 0; arg_index < cm->Get_Number_Of_Output_Arguments(); arg_index++)
	      {	
		cm->Set_Print_Remap(cm->Get_Output_Argument(arg_index), this->_output_args[arg_index]);
	      }
	    
	  }
      }
  

    vector<AaSimpleObjectReference*> exports;

    if(this->_guard_expression)
    {
	ofile << this->Tab();
	ofile << "$if (";
	if(this->_guard_complement)
		guard_string += " $not ";
	this->_guard_expression->Print(ofile);
	ofile << ") $then " << endl;
    }

    ofile << "$seriesblock[" << this->Get_Function_Name() << "_" <<  this->Get_Index()
	  << "] { " << endl;

    if(cm->Get_Inline_Flag())
      {
	if(cm->Get_Number_Of_Input_Arguments() > 0)
	  {
	    ofile << "$parallelblock[InArgs] { " << endl;
	    for(int arg_index = 0; arg_index < cm->Get_Number_Of_Input_Arguments(); arg_index++)
	      {
		ofile << cm->Get_Input_Argument(arg_index)->Get_Name();
		ofile << " := ";
		this->_input_args[arg_index]->Print(ofile);
		ofile << endl;
	      }
	    ofile << "} (" ;
	    for(int arg_index = 0; arg_index < cm->Get_Number_Of_Input_Arguments(); arg_index++)
	      {
		ofile << " ";
		ofile << cm->Get_Input_Argument(arg_index)->Get_Name();
		ofile << " => ";
		ofile << cm->Get_Input_Argument(arg_index)->Get_Name();
	      }
	    ofile << " )" << endl;
	  }

      }
	
    if(cm->Get_Inline_Flag())
      ofile << "$seriesblock[body] {" << endl;

    cm->Print_Body(ofile);

    if(cm->Get_Inline_Flag())
      ofile << "} ";
    
    if(cm->Get_Inline_Flag())
      {
	if(cm->Get_Number_Of_Output_Arguments() > 0)
	  {
	    ofile << "( " ;
	    for(int arg_index = 0; arg_index < cm->Get_Number_Of_Output_Arguments(); arg_index++)
	      {
		ofile << " ";
		ofile << cm->Get_Output_Argument(arg_index)->Get_Name();
		ofile << " => ";
		ofile << cm->Get_Output_Argument(arg_index)->Get_Name();
	      }
	    ofile << " )";
	  }
	ofile << endl;
      }
    
    if(cm->Get_Number_Of_Output_Arguments() > 0)
      {

	if(cm->Get_Inline_Flag())
	  {
	    ofile << "$parallelblock[OutArgs] { " << endl;
	  }

	for(int arg_index = 0; arg_index < cm->Get_Number_Of_Output_Arguments(); arg_index++)
	  {

	    if(cm->Get_Inline_Flag())
	      {
		this->_output_args[arg_index]->Print(ofile);
		ofile << " := " <<  cm->Get_Output_Argument(arg_index)->Get_Name() << endl;
		ofile << endl;
	      }
	    
	    if(this->_output_args[arg_index]->Is_Implicit_Variable_Reference())
	      {
		assert(this->_output_args[arg_index]->Is("AaSimpleObjectReference"));
		exports.push_back(((AaSimpleObjectReference*) this->_output_args[arg_index]));
	      }
	  }

	if(cm->Get_Inline_Flag())
	  ofile << "}" ;
	
	if(cm->Get_Inline_Flag())
	  {
	    if(exports.size() > 0)
	      {
		ofile << "(" ;
		for(int eindex = 0; eindex < exports.size() ; eindex++)
		  {
		    ofile << " ";
		    exports[eindex]->Print(ofile);		
		    ofile << " => ";
		    exports[eindex]->Print(ofile);
		  }
		ofile << " )" << endl;
	      }
	  }
      }
  

    ofile << "}" ;
    if(exports.size() > 0)
      {
	ofile << "(" ;
	for(int eindex = 0; eindex < exports.size() ; eindex++)
	  {
	    ofile << " ";
	    exports[eindex]->Print(ofile);		
	    ofile << " => ";
	    exports[eindex]->Print(ofile);
	  }
	ofile << " )" << endl;
      }
    
    if(cm->Get_Inline_Flag())
      cm->Clear_Print_Prefix();
    else if(cm->Get_Macro_Flag())
      cm->Clear_Print_Remap();

    if(this->_guard_expression)
    {
	ofile << endl;
	ofile << "$endif " << endl;
    }

    return;
  }


  // not inlined or macro
  ofile << this->Tab();
  ofile << guard_string;
  ofile << "$call ";


  ofile << this->Get_Function_Name();

  ofile << " (";
  for(unsigned int i = 0; i < this->Get_Number_Of_Input_Args(); i++)
    {
      this->_input_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";

  ofile << " (";
  for(unsigned int i = 0; i < this->Get_Number_Of_Output_Args(); i++)
    {
      this->_output_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")" << endl;

}

void AaCallStatement::Map_Source_References()
{
  AaModule* called_module = AaProgram::Find_Module(this->_function_name);
  if(called_module != NULL)
    {
      called_module->Increment_Number_Of_Times_Called();
      this->Set_Called_Module(called_module);

      AaScope* root_scope = this->Get_Root_Scope();
      assert(root_scope && root_scope->Is("AaModule"));
      AaModule* caller_module = (AaModule*) root_scope;
      AaProgram::Add_Call_Pair(caller_module,called_module);

      if(called_module->Get_Number_Of_Input_Arguments() != this->_input_args.size())
	{
	  AaRoot::Error("incorrect number of input arguments in function call", this );
	}


      if(called_module->Get_Number_Of_Output_Arguments() != this->_output_args.size())
	{
	  AaRoot::Error("incorrect number of output arguments in function call", this );
	}
    }
  else
    {
      AaRoot::Error("module " +  this->_function_name  + " not found!",this);
    }


  for(unsigned int i=0; i < this->_input_args.size(); i++)
    {
      this->_input_args[i]->Map_Source_References(this->_source_objects);
      if(called_module != NULL)
	{
	  // transfer the type of inarg to inargument.
	  this->_input_args[i]->Set_Type(called_module->Get_Input_Argument(i)->Get_Type());

	  // inarg -> inargument
	  this->_input_args[i]->Add_Source_Reference(called_module->Get_Input_Argument(i));
	  called_module->Get_Input_Argument(i)->Add_Target_Reference(this->_input_args[i]);
	  called_module->Get_Input_Argument(i)->
	    Set_Addressed_Object_Representative(this->_input_args[i]->Get_Addressed_Object_Representative());
	}
    }
  for(unsigned int i=0; i < this->_output_args.size(); i++)
    {
      this->_output_args[i]->Map_Source_References_As_Target(this->_source_objects);
      if(called_module != NULL)
	{

	  // transfer the type of outarg to ioutargument.
	  this->_output_args[i]->Set_Type(called_module->Get_Output_Argument(i)->Get_Type());

	  // outarg <- outargument
	  this->_output_args[i]->Add_Target_Reference(called_module->Get_Output_Argument(i));
	  called_module->Get_Output_Argument(i)->Add_Source_Reference(this->_output_args[i]);
	  this->_output_args[i]->
	    Set_Addressed_Object_Representative(called_module->Get_Output_Argument(i)->Get_Addressed_Object_Representative());
	}
    }

  if(this->_guard_expression)
  {
	this->_guard_expression->Map_Source_References(this->_source_objects);
	if(!this->_guard_expression->Is_Implicit_Variable_Reference())
	{
		AaRoot::Error("guard variable must be implicit (SSA)", this);
	}
  }
}


// the call statement can be blocked, so there
// will certainly be a flag contributed by this
// as well as a place holder for the called function
// structure.
void AaCallStatement::Write_C_Struct(ofstream& ofile)
{
  // entry flag, exit flag and
  // pointer to structure maintaining state of
  // called function.
  // the statement needs an entry flag and an exit flag!
  this->AaStatement::Write_C_Struct(ofile);

  // Targets.
  for(unsigned int i=0; i < this->_output_args.size(); i++)
    {
      if(this->_output_args[i]->Get_Object() == this)
	{
	  if(this->_output_args[i]->Is("AaSimpleObjectReference"))
	    ((AaSimpleObjectReference*)(this->_output_args[i]))->PrintC_Header_Entry(ofile);
	}
    }

  if(this->Get_Called_Module() != NULL)
    {
      ofile <<  this->Tab() 
	    << ((AaModule*)(this->Get_Called_Module()))->Get_Structure_Name() 
	    << "* " 
	    << this->Get_Called_Function_Struct_Pointer() << ";" << endl;
    }
}


// the call statement is always encased in a function!
void AaCallStatement::Write_C_Function_Body(ofstream& ofile)
{

  /*
    if(entry)
    {
    called-fn-struct.entry = 1
    
    if(called-fn-struct->entry)
    if(read-pipe-conditions-ok)
    copy arguments to called-fn-struct
    update read-pipe-conditions
    
    if(!called-fn-struct->exit)
    call function .. function should reset called-fn-struct->entry
    
    if(called-fn-struct->exit)
    {
    if(write-pipe-conditions-ok)
    copy arguments from called-fn-struct
    update-write-pipe-conditions.
    delete called-fn-struct and set to NULL
    set exit flag
    clear-entry-flag
    }
    }
  */
  // if entry {
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// Begin Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "if (" << this->Get_Entry_Name_Ref() << endl;
  ofile << ") {" << endl;
  //     if(called-fn-struct == NULL) {
      
  ofile <<  "if ("
	<< this->Get_Called_Function_Struct_Pointer_Ref() 
	<< " == NULL ) {" << endl;
  //          function being called for the "first time"... allocate
  ofile	<< this->Get_Called_Function_Struct_Pointer_Ref() 
	<< " = ("
	<< this->Get_Called_Module_Struct_Name()
	<< "*) calloc(1,sizeof("
	<< this->Get_Called_Module_Struct_Name()
	<< "));" << endl;
  ofile << "// reset entry flag and set in progress flag" << endl;
  ofile << this->Get_Entry_Name_Ref() << " = 0;" << endl;
  ofile << this->Get_In_Progress_Name_Ref() << " = 1;" << endl;
  ofile << "} // allocation of pointer to called function" << endl;
  ofile << "} // entry into this call statement" << endl;
  //     }
      

  // go further if the call statement is in progress
  ofile << "if (" << this->Get_In_Progress_Name_Ref() << " ) { " << endl;

  //     if(called-fn-struct->_entry) {
  ofile << "if ( !" 
	<< this->Get_Called_Function_Struct_Pointer_Ref() << "->" 
	<< ((AaModule*)this->Get_Called_Module())->Get_Entry_Name() 
	<< " && !"
	<< this->Get_Called_Function_Struct_Pointer_Ref() << "->" 
	<< ((AaModule*)this->Get_Called_Module())->Get_In_Progress_Name() 
	<< ") {// entry and in_progress flags not set?" << endl;
  //           if(pipe-read-flags-ok) {
  ofile << "if (" ;
  this->Write_Pipe_Read_Condition_Check(ofile,"");
  ofile << ") { // check if pipes can be read from" << endl;
  //                copy input arguments
  this->Write_Inarg_Copy_Code(ofile,"");
  //                update read condition flags
  this->Write_Pipe_Read_Condition_Update(ofile,"");

  // set the entry flag in the called function structure.
  ofile << this->Get_Called_Function_Struct_Pointer_Ref() << "->"
	<< ((AaModule*)this->Get_Called_Module())->Get_Entry_Name()  << " = 1;" << endl;


  ofile << "} // arguments copied to call structure" << endl;
  //           }
  ofile << "} // called function had entry flag set" << endl;
  //     }
      
      
  // if called function is still in progress, call it again
  ofile << "if ( " 
	<< this->Get_Called_Function_Struct_Pointer_Ref() << "->" 
	<< ((AaModule*)this->Get_Called_Module())->Get_Entry_Name() 
	<< " || "
	<< this->Get_Called_Function_Struct_Pointer_Ref() << "->" 
	<< ((AaModule*)this->Get_Called_Module())->Get_In_Progress_Name() 
	<< ")  {// called function still in progress" << endl;
      
  // call the function
  ofile << "// call the function" << endl;
  this->PrintC(ofile,"");
      
  ofile << "} // called function was in progress "  << endl;
      
  // if exit flag is set on called function, try to write.
  ofile << "if (" 
	<< this->Get_Called_Function_Struct_Pointer_Ref() 
	<< "->"
	<< ((AaModule*)this->Get_Called_Module())->Get_Exit_Name() 
	<< ") {" << endl;
  ofile << "if (";
  this->Write_Pipe_Write_Condition_Check(ofile,"");
  ofile << ") {"  << endl;
  this->Write_Outarg_Copy_Code(ofile,"");
  this->Write_Pipe_Write_Condition_Update(ofile,"");

  // delete the foreign structure
  ofile << "cfree("<< this->Get_Called_Function_Struct_Pointer_Ref() << ");" << endl;
  ofile << this->Get_Called_Function_Struct_Pointer_Ref() << " = NULL;" << endl;
      
  // set the exit flag for this statement
  ofile << "// reset in progress flag and set exit flag" << endl;
  ofile << this->Get_Exit_Name_Ref() << " = 1;" << endl;
  ofile << this->Get_In_Progress_Name_Ref() << " = 0;" << endl;
      
  // close the ifs
  ofile << "} // ok to copy outputs to destinations?" << endl;
  ofile << "} // called function had finishes?" << endl;
  ofile << "} // statement was in progress" << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// End Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
}

// return true if one of the sources or targets is a pipe.
bool AaCallStatement::Can_Block()
{
  for(set<AaRoot*>::iterator siter = this->_target_objects.begin();
      siter != this->_target_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	return(true);
    }

  for(set<AaRoot*>::iterator siter = this->_source_objects.begin();
      siter != this->_source_objects.end();
      siter++)
    {
      if((*siter)->Is("AaPipeObject"))
	return(true);
    }

  return(false);
}

void AaCallStatement::PrintC(ofstream& ofile, string tab_string)
{

  bool foreign_flag =  
    (this->Get_Called_Module() == NULL || ((AaModule*)this->Get_Called_Module())->Get_Foreign_Flag());

  // depending on whether the called function is foreign or not,
  // there are two forms
  //
  // if called function is foreign.
  //   foo(struct->in1, struct->in2, &(struct->out1),&(struct->out2))
  //
  // if called function is foreign
  //   struct = __foo(struct)
  // 

  string struct_name =  this->Get_Called_Function_Struct_Pointer_Ref();
  if(!foreign_flag)
    {
      ofile << struct_name 
	    << " = "
	    << ((AaModule*)this->Get_Called_Module())->Get_C_Function_Name()
	    << "(" << struct_name << "); // " <<  this->Get_Source_Info() << endl;
    }
  else
    {
      bool first_one = true;
      ofile << ((AaModule*)this->Get_Called_Module())->Get_C_Wrap_Function_Name() // foreign function
	    << "(" << endl;
      for(unsigned int i=0; i < this->_input_args.size(); i++)
	{
	  if(!first_one)
	    ofile << "," << endl;
	  ofile << struct_name << "->";
	  ofile << ((AaModule*)this->Get_Called_Module())->Get_Input_Argument(i)->Get_Name() ;
	  first_one = false;
	}

      for(unsigned int i=0; i < this->_output_args.size(); i++)
	{
	  if(!first_one)
	    ofile << "," << endl;
	  ofile << "&(" << struct_name << "->";
	  ofile << ((AaModule*)this->Get_Called_Module())->Get_Output_Argument(i)->Get_Name() ;
	  ofile << ")";
	  first_one = false;
	}
      ofile << endl << "); //  " << this->Get_Source_Info() << endl;
      ofile <<  struct_name << "->" << ((AaModule*)this->Get_Called_Module())->Get_Entry_Name() << "  = 0;" << endl;
      ofile <<  struct_name << "->" << ((AaModule*)this->Get_Called_Module())->Get_In_Progress_Name() << "  = 0;" << endl;
      ofile <<  struct_name << "->" << ((AaModule*)this->Get_Called_Module())->Get_Exit_Name() <<  "  = 1;" << endl;
    }
}

string AaCallStatement::Get_Called_Module_Struct_Name()
{
  if(this->_called_module)
    return(((AaModule*)this->_called_module)->Get_Structure_Name());
  else
    return(this->_function_name + "_State");

}
void AaCallStatement::Write_Inarg_Copy_Code(ofstream& ofile,string tab_string)
{
  // copy inargs to struct
  string struct_name =  this->Get_Called_Function_Struct_Pointer_Ref();
  for(unsigned int i=0; i < this->_input_args.size(); i++)
    {
      string input_argument;
      input_argument = ((AaModule*)(this->Get_Called_Module()))->Get_Input_Argument(i)->Get_Name() + ".__val";
      
      ofile << tab_string << struct_name << "->" << input_argument << " = ";
      this->_input_args[i]->PrintC(ofile,"");
      ofile << ";" << endl;
    }
}


void AaCallStatement::Write_Outarg_Copy_Code(ofstream& ofile,string tab_string)
{
  // copy inargs to struct
  string struct_name =  this->Get_Called_Function_Struct_Pointer_Ref();
  for(unsigned int i=0; i < this->_output_args.size(); i++)
    {
      string output_argument;
      output_argument = ((AaModule*)(this->Get_Called_Module()))->Get_Output_Argument(i)->Get_Name() + ".__val";
      
      ofile << tab_string;
      this->_output_args[i]->PrintC(ofile,"");
      ofile << " = " << struct_name << "->" << output_argument;
      ofile << ";" << endl;
    }
}


void AaCallStatement::Write_VC_Control_Path(ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  ofile << ";;[" << this->Get_VC_Name() << "] { // call statement " << this->Get_Source_Info() << endl;

  // nothing should happen.
  if(this->Get_Guard_Expression() != NULL)
	this->Get_Guard_Expression()->Write_VC_Control_Path(ofile);

  ofile << "||[in_args] { // input arguments" << endl;
  for(int idx = 0; idx < _input_args.size(); idx++)
    _input_args[idx]->Write_VC_Control_Path(ofile);
  ofile << "}" << endl;

  ofile << "$T [crr] $T [cra] $T [ccr] $T [cca]" << endl;

  ofile << "||[out_args] { // output arguments" << endl;
  for(int idx = 0; idx < _output_args.size(); idx++)
    _output_args[idx]->Write_VC_Control_Path_As_Target(ofile);
  ofile << "}" << endl;

  ofile << "} // end call-statement " << this->Get_VC_Name() << endl;
}


void AaCallStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

 for(int idx = 0; idx < _input_args.size(); idx++)
   _input_args[idx]->Write_VC_Constant_Wire_Declarations(ofile);

}
void AaCallStatement::Write_VC_Wire_Declarations(ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


 for(int idx = 0; idx < _input_args.size(); idx++)
   _input_args[idx]->Write_VC_Wire_Declarations(false, ofile);
 for(int idx = 0; idx < _output_args.size(); idx++)
   {
     if(!_output_args[idx]->Is_Implicit_Variable_Reference())
       {
	 // will have to explicitly declare this wire.
	 // because a normal store target always
	 // has a declared source.  In the case of the
	 // call statement, this declared source is absent.
	 // hence declare it.
	 Write_VC_Wire_Declaration(_output_args[idx]->Get_VC_Driver_Name(),
				   _output_args[idx]->Get_Type(),
				   ofile);
       }

     // the remaining wires needed ..
     _output_args[idx]->Write_VC_Wire_Declarations_As_Target(ofile);
   }
}
void AaCallStatement::Write_VC_Datapath_Instances(ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

 
  vector<pair<string,AaType*> > inargs, outargs;

  for(int idx = 0; idx < _input_args.size(); idx++)
    {
      _input_args[idx]->Write_VC_Datapath_Instances(NULL, ofile);
      inargs.push_back(pair<string,AaType*>(_input_args[idx]->Get_VC_Driver_Name(),
					    _input_args[idx]->Get_Type()));
    }
  
  for(int idx = 0; idx < _output_args.size(); idx++)
    {
      _output_args[idx]->Write_VC_Datapath_Instances_As_Target(ofile,NULL);
      outargs.push_back(pair<string,AaType*>(_output_args[idx]->Get_VC_Receiver_Name(),
					     _output_args[idx]->Get_Type()));
    }

  Write_VC_Call_Operator(this->Get_VC_Name() + "_call",
			 _function_name,
			 inargs,
			 outargs,
			 this->Get_VC_Guard_String(),
			 ofile);

}
void AaCallStatement::Write_VC_Links(string hier_id, ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());

  vector<string> reqs, acks;

  for(int idx = 0; idx < _input_args.size(); idx++)
    {
      string ih = Augment_Hier_Id(hier_id, "in_args");
      _input_args[idx]->Write_VC_Links(ih, ofile);

    }
  for(int idx = 0; idx < _output_args.size(); idx++)
    {
      string oh = Augment_Hier_Id(hier_id,"out_args");
      _output_args[idx]->Write_VC_Links_As_Target(oh, ofile);
    }

  reqs.push_back(hier_id + "/crr");
  reqs.push_back(hier_id + "/ccr");

  acks.push_back(hier_id + "/cra");
  acks.push_back(hier_id + "/cca");

  Write_VC_Link(this->Get_VC_Name() + "_call",reqs,acks,ofile);
}


void AaCallStatement::Propagate_Constants()
{
 for(int idx = 0; idx < _input_args.size(); idx++)
    {
      _input_args[idx]->Evaluate();
    }
}

//---------------------------------------------------------------------
// AaBlockStatement: public AaStatement
//---------------------------------------------------------------------
AaBlockStatement::AaBlockStatement(AaScope* scope,string label):AaStatement(scope) 
{
  this->_label = label;
  this->_statement_sequence = NULL;
  if(label != "" && scope != NULL)
    scope->Map_Child(label,this);
}

AaBlockStatement::~AaBlockStatement() {}

void AaBlockStatement::Add_Object(AaObject* obj) 
{ 
  if(this->Find_Child_Here(obj->Get_Name()) == NULL)
    { 
      this->_objects.push_back(obj);
      this->Map_Child(obj->Get_Name(),obj);
      if(obj->Is("AaStorageObject"))
	{
	  AaProgram::Add_Storage_Dependency_Graph_Vertex(obj);
	}
    }
  else
    {
      AaRoot::Error("object " + obj->Get_Name() + " already exists in " + this->Get_Label(),obj);
    }
}

void AaBlockStatement::Add_Export(string formal, string actual)
{
  AaRoot* formal_ref = this->Find_Child(formal);
  if(formal_ref == NULL)
    {
      AaRoot::Error("in export, did not find object " + formal + " in " + this->Get_Label(),this);
    }
  else
    {
      if(this->Get_Scope() != NULL)
	{
	  this->Get_Scope()->Map_Child(actual, formal_ref);
	  this->_exports[formal] = actual;
	}
      else
	{
	  AaRoot::Warning("export " + formal + " => " + actual + " ignored for block " + this->Get_Label(), this);
	}
    }
}

void AaBlockStatement::Coalesce_Storage()
{
  for(int idx = 0; idx < _objects.size(); idx++)
    {
      if(_objects[idx]->Is("AaStorageObject"))
	_objects[idx]->Coalesce_Storage();
    }

  if(this->_statement_sequence)
    this->_statement_sequence->Coalesce_Storage();
}

void AaBlockStatement::Print(ostream& ofile)
{

  if(this->Get_Label() != "")
    ofile << "[" << this->Get_Label() << "]" << endl;
  else
    ofile << endl;

  ofile << this->Tab() << "{" << endl;
  this->Print_Objects(ofile);
  this->Print_Statement_Sequence(ofile);
  ofile << this->Tab() << "}" << endl;

  // print exports.
  if(this->_exports.size() > 0)
    {
      ofile << "(" ;
      for(map<string,string>::iterator iter = _exports.begin(); iter != _exports.end(); iter++)
	{
	  ofile << " " << (*iter).first << " => " << (*iter).second << " ";
	}
      ofile << ")" << endl ;
    }
}

void AaBlockStatement::Map_Source_References()
{
  if(this->_statement_sequence)
    this->_statement_sequence->Map_Source_References();
}

// the block statement can be blocked, so there
// will certainly be a structure contributed
// by this.
void AaBlockStatement::Write_C_Struct(ofstream& ofile) 
{

  if(this->Get_Label() != "")
    {
      ofile << "struct " << this->Get_Structure_Name() << "__ {" << endl;
      this->PrintC_Objects(ofile,"");
    }

  ofile << "\tunsigned int " << this->Get_Entry_Name() << " : 1;" << endl;
  ofile << "\tunsigned int " << this->Get_Exit_Name() << " : 1;" << endl;
  ofile << "\tunsigned int " << this->Get_In_Progress_Name() << " : 1;" << endl;

  if(this->_statement_sequence != NULL)
    {
      this->_statement_sequence->Write_C_Struct(ofile);
    }

  this->Write_C_Struct_Extra(ofile);
  if(this->Get_Label() != "")
    ofile << "} " << this->Get_Label() << ";" << endl;
}

// the block statement is always encased in a function!
void AaBlockStatement::Write_C_Function_Body(ofstream& ofile) 
{
  string tab_string = this->Tab();

  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// Begin Block " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;

  // if entry flag is set, transfer entry to constituents.
  ofile << "if ( " ;
  this->Write_Entry_Condition(ofile);
  ofile << ") " 	
	<< " { " << endl;
  this->Write_Object_Initializations(ofile);
  this->Write_Entry_Transfer_Code(ofile);
  ofile << "}";


  ofile << "if (" 
	<<  this->Get_In_Progress_Name_Ref() << ") {"  << endl;
  this->Write_Statement_Invocations(ofile);

  // check if all constituents have exited before setting _exit flag.
  ofile << tab_string << "if (";
  this->Write_Exit_Check_Condition(ofile);
  ofile << ") {" << endl;
  this->Write_Cleanup_Code(ofile);
  ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
  ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;

  ofile << "}" << endl;
  ofile << "}" << endl;

  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// End Block " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;

}

void AaBlockStatement::Write_Entry_Condition(ofstream& ofile)
{
  ofile << this->Get_Entry_Name_Ref();
}


void AaBlockStatement::Write_VC_Constant_Declarations(ostream& ofile)
{

  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Constant_Declarations(ofile);
      }

  ofile << "// constant-object-declarations for block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;
  for(int idx = 0; idx < _objects.size(); idx++)
    {
      if(_objects[idx]->Is("AaConstantObject"))
	{
	  _objects[idx]->Write_VC_Model(ofile);
	}
      else if(_objects[idx]->Is("AaStorageObject"))
	{
	  ((AaStorageObject*)(_objects[idx]))->Write_VC_Load_Store_Constants(ofile);
	}
    }
}
void AaBlockStatement::Write_VC_Pipe_Declarations(ostream& ofile)
{
  ofile << "// pipe-declarations for block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  for(int idx = 0; idx < _objects.size(); idx++)
    {
      if(_objects[idx]->Is("AaPipeObject"))
	((AaPipeObject*)(_objects[idx]))->Write_VC_Model(ofile);
    }

  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Pipe_Declarations(ofile);
      }
}
 
void AaBlockStatement::Write_VC_Memory_Space_Declarations(ostream& ofile)
{

  ofile << "// memory-space-declarations for block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  for(int idx = 0; idx < _objects.size(); idx++)
    {
      if(_objects[idx]->Is("AaStorageObject"))
	{
	  ((AaStorageObject*)(_objects[idx]))->Write_VC_Model(ofile);
	}
    }
  
  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Memory_Space_Declarations(ofile);
      }
}

void AaBlockStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

  ofile << "// constant-declarations for block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  for(int idx = 0; idx < _objects.size(); idx++)
    {
      if(_objects[idx]->Is("AaConstantObject"))
	{
	  ((AaStorageObject*)(_objects[idx]))->Write_VC_Model(ofile);
	}
    }
  
  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Constant_Wire_Declarations(ofile);
      }
}


void AaBlockStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
  ofile << "// block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Wire_Declarations(ofile);
      }
}

void AaBlockStatement::Write_VC_Datapath_Instances(ostream& ofile)
{

  ofile << "// datapath-instances for block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Datapath_Instances(ofile);
      }
}

void AaBlockStatement::Write_VC_Links(string hier_id, ostream& ofile)
{

  ofile << "// CP-DP links for block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  if(hier_id != "")
    hier_id = hier_id + "/" + this->Get_VC_Name();
  else
    hier_id = this->Get_VC_Name();

  if(this->_statement_sequence != NULL)
    for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
      {
	this->_statement_sequence->Get_Statement(idx)->Write_VC_Links(hier_id, ofile);
      }
}


void AaBlockStatement::Propagate_Constants()
{
  for(int idx = 0; idx < _objects.size(); idx++)
    {
      if(_objects[idx]->Is("AaConstantObject"))
	{
	  ((AaConstantObject*)(_objects[idx]))->Evaluate();
	}
    }

  if(this->_statement_sequence)
    this->_statement_sequence->Propagate_Constants();

}

//---------------------------------------------------------------------
// AaSeriesBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaSeriesBlockStatement::AaSeriesBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaSeriesBlockStatement::~AaSeriesBlockStatement() {}
void AaSeriesBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$seriesblock";
  this->AaBlockStatement::Print(ofile);
}

void AaSeriesBlockStatement::Write_Entry_Transfer_Code(ofstream& ofile)
{
  ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
  ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;

  if(this->_statement_sequence)
    this->_statement_sequence->Write_Series_Entry_Transfer_Code(ofile);
}
void AaSeriesBlockStatement::Write_Statement_Invocations(ofstream& ofile)
{
  if(this->_statement_sequence)
    this->_statement_sequence->Write_Series_Statement_Invocations(ofile);
}

void AaSeriesBlockStatement::Write_Exit_Check_Condition(ofstream& ofile)
{
  if(this->_statement_sequence)
    this->_statement_sequence->Write_Series_Exit_Check_Condition(ofile);
  else
    ofile << "1";
}


//---------------------------------------------------------------------
// AaParallelBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaParallelBlockStatement::AaParallelBlockStatement(AaScope* scope,string label):AaBlockStatement(scope,label) {}
AaParallelBlockStatement::~AaParallelBlockStatement() {}
void AaParallelBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$parallelblock";
  this->AaBlockStatement::Print(ofile);
}

void AaParallelBlockStatement::Write_Entry_Transfer_Code(ofstream& ofile) 
{
  ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
  ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;

  if(this->_statement_sequence)
    this->_statement_sequence->Write_Parallel_Entry_Transfer_Code(ofile);
}

void AaParallelBlockStatement::Write_Statement_Invocations(ofstream& ofile) 
{
  if(this->_statement_sequence)
    this->_statement_sequence->Write_Parallel_Statement_Invocations(ofile);
}
void AaParallelBlockStatement::Write_Exit_Check_Condition(ofstream& ofile) 
{
  if(this->_statement_sequence)
    this->_statement_sequence->Write_Parallel_Exit_Check_Condition(ofile);
  else
    ofile << "1";
}

//---------------------------------------------------------------------
// AaForkBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaForkBlockStatement::AaForkBlockStatement(AaScope* scope,string label):AaParallelBlockStatement(scope,label) {}
AaForkBlockStatement::~AaForkBlockStatement() {}
void AaForkBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$forkblock ";
  this->AaBlockStatement::Print(ofile);
}

void AaForkBlockStatement::Write_VC_Control_Path(ostream& ofile)
{

  ofile << "// control-path for fork-block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  ofile << "::[" << this->Get_VC_Name() << "] // fork block " << this->Get_Source_Info() << endl << "{";
  // two passes: first print the statements in this
  // block which are NOT fork/joins.
  if(this->_statement_sequence)
    {
      for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
	  if(!stmt->Is("AaJoinForkStatement"))
	    stmt->Write_VC_Control_Path(ofile);
	}
      
      // second pass, print the fork/joins.
      for(int idx = 0; idx  < this->_statement_sequence->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = this->_statement_sequence->Get_Statement(idx);
	  if(stmt->Is("AaJoinForkStatement"))
	    stmt->Write_VC_Control_Path(ofile);
	}
    }
  else
    {
      ofile << ";;[DummySB] { $T [dummy] } " << endl;
      ofile << "$entry &-> DummySB" << endl;
      ofile << "$exit <-& DummySB" << endl;
    }
  ofile << "} // end fork block " << this->Get_Source_Info() << endl;
}

//---------------------------------------------------------------------
// AaBranchBlockStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaBranchBlockStatement::AaBranchBlockStatement(AaScope* scope,string label):AaSeriesBlockStatement(scope,label) {}
AaBranchBlockStatement::~AaBranchBlockStatement() {}
void AaBranchBlockStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$branchblock ";
  this->AaBlockStatement::Print(ofile);
}

void AaBranchBlockStatement::Write_C_Struct_Extra(ofstream& ofile)
{
  for(set<string>::iterator iter = _merged_places.begin(), fiter = _merged_places.end();
      iter != fiter;
      iter++)
    {
      ofile << this->Tab() << "unsigned int " << (*iter) << " : 1;" << endl;
    }
}

void AaBranchBlockStatement::Write_VC_Control_Path(ostream& ofile)
{
  ofile << "// control-path for branch block " << this->Get_Hierarchical_Name() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  // three passes..
  ofile << "<>[" << this->Get_VC_Name() << "] // Branch Block " << this->Get_Source_Info() << endl << " {" << endl;
  ofile << "$P [" << this->Get_VC_Name() << "__entry__]" << endl;
  ofile << this->Get_VC_Name() << "__entry__ <-| ($entry)" << endl;
  ofile << "$P [" << this->Get_VC_Name() << "__exit__]" << endl;
  ofile << this->Get_VC_Name() << "__exit__ |-> ($exit)" << endl;
  


  this->Write_VC_Control_Path(this->Get_VC_Name() + "__entry__", 
			      this->_statement_sequence, 
			      this->Get_VC_Name() + "__exit__",
			      ofile);

  ofile << "} " << endl;
}

void AaBranchBlockStatement::Write_VC_Control_Path(string source_link,
						   AaStatementSequence* sseq,
						   string sink_link,
						   ostream& ofile)
{
  if(sseq)
    {
      // first declare the entry/exit places for statements
      // in the sequence..
      for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
	{
	  AaStatement* prev = (idx > 0 ? sseq->Get_Statement(idx-1) : NULL);
	  AaStatement* stmt = sseq->Get_Statement(idx);
	  if(!stmt->Is("AaPlaceStatement"))
	    {
	      if(!stmt->Is("AaMergeStatement"))
		ofile << "$P [" << stmt->Get_VC_Entry_Place_Name() << "] " << endl;
	      else
		{
		  if(prev == NULL || !prev->Is("AaPlaceStatement"))
		    {

		      AaMergeStatement* ms = ((AaMergeStatement*)stmt);
		      if(ms->Has_Merge_Label("$entry"))
			{
			  if(prev != NULL && prev->Is("AaPlaceStatement"))
			    {
			      AaRoot::Error("merge statement specifies a merge from entry which is unreachable.",
					    stmt);
			    }
			}
		      ms->Set_Has_Entry_Place(true);
		      ofile << "$P [" << stmt->Get_VC_Entry_Place_Name() << "] " << endl;
		    }
		}

	      ofile << "$P [" << stmt->Get_VC_Exit_Place_Name() << "] " << endl;
	    }
	  else
	    // place statement..
	    stmt->Write_VC_Control_Path(ofile);	    
	}


      // next all except the merges.
      for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = sseq->Get_Statement(idx);
	  if(!stmt->Is("AaMergeStatement") && !stmt->Is("AaPlaceStatement"))
	    {
	      stmt->Write_VC_Control_Path(ofile);
		
	      // control regulated by __entry__ and __exit__ places..
	      // except for switch and if statements..
	      if(!stmt->Is("AaSwitchStatement") && !stmt->Is("AaIfStatement"))
		{
		  // for switch and if, the control flow is a bit more complicated..
		  // we do not create an explicit CP region for these statements..
		  ofile << stmt->Get_VC_Name() << "__entry__ |-> (" << stmt->Get_VC_Name() << ")" << endl;
		  ofile << stmt->Get_VC_Name() << "__exit__ <-| (" << stmt->Get_VC_Name() << ")" << endl;
		}
	    }
	}
	
      // almost finally the merges.
      for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = sseq->Get_Statement(idx);
	  if(stmt->Is("AaMergeStatement"))
	    {
	      stmt->Write_VC_Control_Path(ofile);
	    }
	}
	
      // very finally, the control transfer between statements..
      for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = sseq->Get_Statement(idx);
	    
	  
	  // stmt gets control from its predecessor..
	  AaStatement* prev_stmt = sseq->Get_Previous_Statement(stmt);
	  if(prev_stmt == NULL)
	    {
	      ofile << stmt->Get_VC_Entry_Place_Name() << " <-| (" << source_link << ")" << endl;
	    }
	  else
	    {
	      if(!prev_stmt->Is("AaPlaceStatement"))
		{
		  ofile << stmt->Get_VC_Entry_Place_Name() 
			<< " <-| (" 
			<< prev_stmt->Get_VC_Exit_Place_Name() 
			<< ")" << endl;

		}
	    }

	  AaStatement* next_stmt = sseq->Get_Next_Statement(stmt);
	  // the last statement needs to be linked up to the sink_link
	  // (not if it is a place statement, obviously!)
	  if(next_stmt == NULL)
	    {
	      if(!stmt->Is("AaPlaceStatement"))
		{
		  ofile << stmt->Get_VC_Exit_Place_Name() << " |-> (" << sink_link << ")" << endl;
		}
	    }
	}
    }
  else 
    {
      ofile << "$P [dummy_place_] " << endl;
      ofile << "dummy___place___ <-| (" << source_link << ")" << endl;
      ofile << "dummy___place___ |-> (" << sink_link  << ")" << endl;
    }
}

void AaBranchBlockStatement::Identify_Inner_Loops(AaStatementSequence* sseq,
						  vector<AaStatementSequence*>& linear_segment_vector)
{
  
  
  // take the statement sequence and identify inner loops within the sequence.
  // The loops are identified using the following pattern:
  //
  // 1. The inner loop must start with a merge, which must have exactly two incoming places
  //    the $entry place and a loopback place.
  // 2. The last statement in the loop must be either 
  // 	  - an unconditional branch that places a token in the loopback place.
  // 	  - an if statement one of whose branches places a token in the loopback
  // 	    place.
  // 	  - a switch statement, at least one of whose branches places a token in the
  // 	    loopback place.. (NOTE this is currently not implemented).
  // 3. The statements between the first and the last statement must be either 
  //    assignments or calls (can be guarded). (NOTE: this can and should be relaxed..) 
  // 
  int start_idx = 0;
  while(start_idx < sseq->Get_Statement_Count())
    {
      AaStatement* stmt = NULL;
      int end_idx = start_idx;
      
      vector<AaStatement*> linear_segment;
      while(end_idx < sseq->Get_Statement_Count())
	{
	  stmt  = sseq->Get_Statement(end_idx);

	  if(!stmt->Is("AaMergeStatement"))
	    {
	      end_idx++;
	      continue;
	    }

	  // OK, we have found a merge statement. Now, look forward
	  // through the sequence to see if you eventually get to a
	  // branch which loops back to the merge place.
	  linear_segment.push_back(stmt);
	  AaMergeStatement* leading_merge_stmt = (AaMergeStatement*) stmt;
	  AaStatement* trailing_stmt = NULL;
	  AaStatement* next_stmt;
	  int trailing_idx = end_idx + 1;
	  while(trailing_idx  < sseq->Get_Statement_Count())
	  {
		next_stmt = sseq->Get_Statement(trailing_idx);
		if(next_stmt->Is("AaPlaceStatement"))
		{
			if(leading_merge_stmt->Has_Merge_Label(((AaPlaceStatement*)next_stmt)->Get_Label()))
			{
				trailing_stmt = next_stmt;
				linear_segment.push_back(next_stmt);
			}
			break;
				
		}
		else if(next_stmt->Is("AaIfStatement"))
		{
			AaIfStatement* if_stmt = (AaIfStatement*) stmt;
			int tidx;
			for(tidx = 0; tidx < 2; tidx++)
			{
				AaStatement* xstmt = ((tidx == 0) ? if_stmt->Get_If_Sequence_Statement(0): if_stmt->Get_Else_Sequence_Statement(0));
				if(xstmt != NULL)
				{
					if(xstmt->Is("AaPlaceStatement"))
					{
						if(leading_merge_stmt->Has_Merge_Label(((AaPlaceStatement*)next_stmt)->Get_Label()))
						{
							trailing_stmt = next_stmt;
							linear_segment.push_back(next_stmt);
							break;
						}
				
					}
				}
			}

			break;
		}
		// for the moment, give up if you hit a switch.
		else if(next_stmt->Is("AaSwitchStatement"))
		{
			break;	
		}
		// in principle, we can continue through blocks, pipe-reads
		// call statements with side-effects etc., but for the moment
		// we abort the loop search if we hit any of these.
	  	else if(next_stmt->Is_Block_Statement()  || 
	     		next_stmt->Is_Control_Flow_Statement() || 
	     		(next_stmt->Is("AaCallStatement") && 
		 		!((AaModule*)(((AaCallStatement*)next_stmt)->Get_Called_Module()))->Has_No_Side_Effects())
	     		|| next_stmt->Can_Block())
		{
			break;
		}

		trailing_idx++;
	  }

	  if(trailing_stmt != NULL)
	  {
		  AaStatementSequence* new_seq = new AaStatementSequence(this,linear_segment);
		  linear_segment_vector.push_back(new_seq);
		  linear_segment.clear();
	  }

	  end_idx = trailing_idx;
	}
      
      	start_idx = end_idx;
    }
}

//---------------------------------------------------------------------
//  AaJoinForkStatement: public AaBlockStatement
//---------------------------------------------------------------------
AaJoinForkStatement::AaJoinForkStatement(AaForkBlockStatement* scope):AaParallelBlockStatement(scope,"") {}
AaJoinForkStatement::~AaJoinForkStatement() {}
void AaJoinForkStatement::Print(ostream& ofile) 
{
  ofile << this->Tab();
  ofile << "$join ";
  for(unsigned int i = 0; i < this->_join_labels.size(); i++)
    ofile << this->_join_labels[i] << " ";
  if(this->Get_Statement_Count() > 0)
    {
      ofile << endl << this->Tab();
      ofile << " $fork " << endl;
      this->_statement_sequence->Print(ofile);
    }
  ofile << this->Tab();
  ofile << "$endjoin " << endl;
}


void AaJoinForkStatement::Map_Source_References()
{

  for(unsigned int i=0; i < this->_join_labels.size(); i++)
    {
      AaRoot* child = 
	((AaScope*)this->Get_Scope())->Find_Child_Here(this->_join_labels[i]);
      if(child != NULL)
	{
	  if(child->Is_Statement())
	    {
	      this->_wait_on_statements.push_back((AaStatement*)child);
	    }
	  else
	    AaRoot::Error("did not find statement with label " + this->_join_labels[i],this);
	}
      else
	{
	  AaRoot::Error("did not find statement with label " + this->_join_labels[i],this);
	}
    }

  this->AaBlockStatement::Map_Source_References();
}

void AaJoinForkStatement::Write_Entry_Transfer_Code(ofstream& ofile)
{
  ofile << this->Tab() << "if (1 ";
  for(unsigned int i=0; i < this->_wait_on_statements.size(); i++)
    {
      ofile << "&& " << this->_wait_on_statements[i]->Get_Exit_Name_Ref() ;
    }
  ofile << ")" << endl;
  ofile << "{" << endl;

  ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
  ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;

  if(this->_statement_sequence)
    this->_statement_sequence->Write_Parallel_Entry_Transfer_Code(ofile);
  ofile << "}" << endl;

}


void AaJoinForkStatement::Write_VC_Control_Path(ostream& ofile)
{
  ofile << "// control-path for join-fork statement " <<  endl;
  ofile << "// " << this->Get_Source_Info() << endl;
  if(this->_statement_sequence != NULL)
    this->_statement_sequence->Write_VC_Control_Path(ofile);


  ofile << "$T [" << this->Get_VC_Name() <<"] // join " << this->Get_Source_Info() << endl;
  if(_join_labels.size() == 0)
    {
      ofile << this->Get_VC_Name() << " <-& ($entry)" <<  endl;
    }
  else
    {
      ofile << this->Get_VC_Name() << " <-& (";
      for(int idx = 0; idx < _wait_on_statements.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " ";
	  ofile << _wait_on_statements[idx]->Get_VC_Name();
	}
      ofile << ")" << endl;
    }

  if(_statement_sequence == NULL)
    {
      ofile << this->Get_VC_Name() << " &-> ($exit)" <<  endl;
    }
  else
    {
      ofile << this->Get_VC_Name() << " &-> (";
      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  if(idx > 0)
	    ofile << " ";
	  ofile << _statement_sequence->Get_Statement(idx)->Get_VC_Name();
	}
      ofile << ")" << endl;
    }
}

void AaJoinForkStatement::Write_VC_Links(string hier_id, ostream& ofile)
{
  ofile << "// CP-DP links for join-fork  " << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  if(_statement_sequence != NULL)
    {
      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  _statement_sequence->Get_Statement(idx)->Write_VC_Links(hier_id,ofile);
	}
    }
}

//---------------------------------------------------------------------
// AaMergeStatement: public AaStatement
//---------------------------------------------------------------------
AaMergeStatement::AaMergeStatement(AaBranchBlockStatement* scope):AaSeriesBlockStatement((AaScope*)scope,"") 
{
  this->_wait_on_entry = 0;
  this->_has_entry_place = 0;
}

AaMergeStatement::~AaMergeStatement() {}
void AaMergeStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$merge " ;
  for(unsigned int i=0; i < this->_merge_label_vector.size(); i++)
    { 
      ofile  << this->_merge_label_vector[i] << " ";
    }
  ofile << endl;


  if(this->_statement_sequence != NULL)
    {
      ofile << this->Tab() << endl;
      this->_statement_sequence->Print(ofile);
      ofile << this->Tab() << endl;
    }
  ofile << this->Tab();
  ofile << "$endmerge" << endl ;
}

void AaMergeStatement::Map_Source_References()
{
  for(unsigned int i=0; i < this->_merge_label_vector.size(); i++)
    {
      if((this->_merge_label_vector[i] != "$entry") &&
	 (this->_merge_label_vector[i] != "$loopback"))
	{
	  AaRoot* child = 
	    ((AaScope*)this->Get_Scope())->Find_Child_Here(this->_merge_label_vector[i]);
	  if(child != NULL)
	    {
	      if(child->Is("AaPlaceStatement"))
		{
		  this->_wait_on_statements.push_back((AaPlaceStatement*)child);
		  ((AaPlaceStatement*)child)->Mark_As_Merged();
		}
	      else
		AaRoot::Error("did not find place statement with label " + this->_merge_label_vector[i],this);
	    }
	  else 
	    {
	      AaRoot::Error("did not find place statement with label " + this->_merge_label_vector[i],this);
	    }
	}
      else
	{
	  this->_wait_on_entry = 1;
	}
    }

  // also the phi statements!
  this->AaBlockStatement::Map_Source_References();
}


void AaMergeStatement::Set_In_Do_While(bool v)
{ 
  _in_do_while = v; 
  if(_statement_sequence != NULL)
    {
      for(unsigned int idx = 0; idx < this->Get_Statement_Count(); idx++)
	{
	  AaPhiStatement* pstmt = (AaPhiStatement*) this->Get_Statement(idx);
	  pstmt->Set_In_Do_While(v);
	}
    }
}


void AaMergeStatement::Write_Entry_Condition(ofstream& ofile)
{
  if(this->_wait_on_entry)
    this->AaBlockStatement::Write_Entry_Condition(ofile);
  else
    ofile << " 0 ";

  for(unsigned int i=0; i < this->_wait_on_statements.size(); i++)
    {
      ofile << " || " << this->_wait_on_statements[i]->Get_Place_Name_Ref() ;
    }

}

void AaMergeStatement::Write_Cleanup_Code(ofstream& ofile)
{

  this->AaBlockStatement::Write_Cleanup_Code(ofile);

  // clear the places after you exit the merge..
  for(unsigned int i=0; i < this->_wait_on_statements.size(); i++)
    {
      ofile << this->Tab() << "// clear the place flag " << endl;
      ofile << this->Tab() << this->_wait_on_statements[i]->Get_Place_Name_Ref() << " = 0; " << endl;
    }
  ofile << this->Get_Merge_From_Entry_Ref() << " = 0;"  << endl;
}

void AaMergeStatement::Write_C_Struct(ofstream& ofile)
{
  this->AaBlockStatement::Write_C_Struct(ofile);
  ofile << "unsigned int " << this->Get_Merge_From_Entry() << " : 1;" << endl;
}
void AaMergeStatement::Write_Entry_Transfer_Code(ofstream& ofile)
{
  // need to add a flag in the merge statement which is set
  // if it came from $entry.

  ofile << "if (" << this->Get_Entry_Name_Ref() << ") {"  << endl;
  ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
  ofile << this->Get_Merge_From_Entry_Ref() << " = 1;"  << endl;
  ofile << "}";

  ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;

  if(this->_statement_sequence)
    this->_statement_sequence->Write_Series_Entry_Transfer_Code(ofile);

}


void AaMergeStatement::Write_VC_Control_Path(ostream& ofile)
{

  ofile << "// control-path for merge  " << endl;
  ofile << "// " << this->Get_Source_Info() << endl;
  string source_link = this->Get_VC_Entry_Place_Name();


  // this has an entry place (because its predecessor
  // was not a place statement).
  //
  // to preserve static connectivity of the containing
  // branch region, we introduce a dead link
  // connection from the entry place to the exit place
  // (otherwise there will be a dangle.. which is flagged
  // as an error).
  if(this->_has_entry_place)
    {
      string dead_link = this->Get_VC_Name() + "_dead_link";
      ofile << ";;[" << dead_link << "] { $T [dead_transition] $dead } " << endl;
      // tie up the dead link..
      ofile << this->Get_VC_Entry_Place_Name() << " |-> (" << dead_link << ")" << endl;
      ofile << this->Get_VC_Exit_Place_Name() << " <-| (" << dead_link << ")" << endl;
    }

  // first, for each element of the merge-label set,
  // find the phi statements that depend on it.
  map<string,set<AaPhiStatement*> > phi_dependency_map;
  ofile << "//---------------------   merge statement " << this->Get_Source_Info() << "  --------------------------" << endl;
  if(_statement_sequence != NULL)
    {
      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = _statement_sequence->Get_Statement(idx);
	  assert(stmt->Is("AaPhiStatement"));
	  
	  AaPhiStatement* pstmt = (AaPhiStatement*) stmt;
	  for(set<string,StringCompare>::iterator iter= _merge_label_set.begin();
	      iter != _merge_label_set.end();
	      iter++)
	    {
	      if(pstmt->Is_Merged(*iter))
		phi_dependency_map[(*iter)].insert(pstmt);
	    }
	}
    }


  // for each merge-label create a parallel region
  // in which requests are generated to all the phi-statements
  // which depend on this label..
  for(set<string,StringCompare>::iterator iter= _merge_label_set.begin();
      iter != _merge_label_set.end();
      iter++)
    {
      string mlabel = (*iter);
      string mplace = ((mlabel == "$entry") ? source_link : mlabel);

      if(mplace  != "")
	{

	  ofile << "||[" << Make_VC_Legal(mplace) << "_PhiReq] {" << endl; 
	  if(phi_dependency_map[mlabel].size() > 0)
	    {
	      for(set<AaPhiStatement*>::iterator siter = phi_dependency_map[mlabel].begin();
		  siter != phi_dependency_map[mlabel].end();
		  siter++)
		{
		  ofile << ";;[" << (*siter)->Get_VC_Name() << "] {" << endl;
		    
		  ofile << "||[" << (*siter)->Get_VC_Name() << "_sources] {" << endl;
		  // the sources to the phi must be computed.
		  (*siter)->Write_VC_Source_Control_Paths(ofile);

	
		  ofile << "}" << endl;

		  // issue a req to the phi.
		  ofile << "$T [" << (*siter)->Get_VC_Name() << "_req] " << endl;
		  ofile << "}" << endl;
		}
	    }
	  else
	    {
	      ofile << "// no phi statements in merge.." << endl;
	    }
	  ofile << "}" << endl;

      
	  // merge-labels 
	  ofile << mplace << " |-> (" << Make_VC_Legal(mplace) << "_PhiReq)" << endl;
	}
    }
  
  // all the parallel regions created above will merge into 
  // a single place.
  ofile << "$P [" << this->Get_VC_Name() << "_PhiReqMerge] " << endl;
  ofile << this->Get_VC_Name() << "_PhiReqMerge <-| (";
  for(set<string,StringCompare>::iterator iter= _merge_label_set.begin();
      iter != _merge_label_set.end();
      iter++)
    {
      string mlabel = (*iter);
      string mplace = ((mlabel == "$entry") ? this->Get_VC_Entry_Place_Name() : mlabel);
      if(mplace != "")
	ofile << " " << Make_VC_Legal(mplace) << "_PhiReq "; 
    }
  ofile << ")" << endl;

  // now a parallel region, in which we wait for all
  // the acks from the phi statements associated with
  // this merge statement.
  // 
  // note that the delay from the req to the phi
  // to this transition should be at most one tick..
  // 
  //
  ofile << "||[" << this->Get_VC_Name() << "_PhiAck] {" << endl;

  if(_statement_sequence)
    {
      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = _statement_sequence->Get_Statement(idx);
	  assert(stmt->Is("AaPhiStatement"));
	  ofile << "$T [" << stmt->Get_VC_Name() << "_ack] " << endl; 
	}
    }
  else
    ofile << "$T [dummy] " << endl;

  ofile << "}";

  // the PhiAck parallel CPR merges into the exit place for this merge
  ofile << this->Get_VC_Name() << "_PhiReqMerge |-> (" << this->Get_VC_Name() << "_PhiAck)" << endl;
  ofile << this->Get_VC_Exit_Place_Name() << "  <-| (" << this->Get_VC_Name() << "_PhiAck)" << endl;

  // thats it..
  ofile << "//---------------------  end of merge statement " << this->Get_Source_Info() << "  --------------------------" << endl;
}

void AaMergeStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
  if(_statement_sequence != NULL)
    {
      ofile << "// merge-statement  " << endl;
      ofile << "// " << this->Get_Source_Info() << endl;


      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  _statement_sequence->Get_Statement(idx)->Write_VC_Wire_Declarations(ofile);
	}
    }
}
void AaMergeStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
  if(_statement_sequence != NULL)
    {
      ofile << "// data-path instances for merge  " << endl;
      ofile << "// " << this->Get_Source_Info() << endl;

      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  _statement_sequence->Get_Statement(idx)->Write_VC_Datapath_Instances(ofile);
	}
    }
}

void AaMergeStatement::Write_VC_Links(string hier_id, ostream& ofile)
{
  ofile << "// CP-DP links for merge  " << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  if(_statement_sequence)
    {


      for(int idx = 0; idx < _statement_sequence->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = _statement_sequence->Get_Statement(idx);
	  assert(stmt->Is("AaPhiStatement"));

	  vector<string> reqs;
	  AaPhiStatement* phi_stmt = (AaPhiStatement*) stmt;

	  // phi reqs..
	  for(int pidx = 0; pidx < phi_stmt->_source_pairs.size(); pidx++)
	    {

	      string mlabel = phi_stmt->_source_pairs[pidx].first;
	      string mplace = ((mlabel == "$entry") ? this->Get_VC_Entry_Place_Name() : mlabel);

	      // in the request block, you compute the inputs and then  hang the
	      // req..
	      string req_hier_id = Augment_Hier_Id(hier_id , Make_VC_Legal(mplace) + "_PhiReq/" + 
						   phi_stmt->Get_VC_Name());

	      // finish all the sources for the phi's...
	      string src_hier_id = Augment_Hier_Id(req_hier_id,
						   phi_stmt->Get_VC_Name() + "_sources");

	      phi_stmt->_source_pairs[pidx].second->Write_VC_Links(src_hier_id,ofile);

	      reqs.push_back(req_hier_id + "/" + phi_stmt->Get_VC_Name() + "_req");
	    }

	  
	  string ack_name = hier_id + "/"  +  this->Get_VC_Name() + "_PhiAck/" + 
	    phi_stmt->Get_VC_Name() + "_ack";

	  vector<string> acks;
	  acks.push_back(ack_name);
	  Write_VC_Link(phi_stmt->Get_VC_Name(),reqs,acks,ofile);

	  reqs.clear(); acks.clear();
	}
    }
}

//---------------------------------------------------------------------
// AaPhiStatement: public AaStatement
//---------------------------------------------------------------------
AaPhiStatement::AaPhiStatement(AaBranchBlockStatement* scope, AaMergeStatement* pm):AaStatement(scope) 
{
  this->_target = NULL;
  this->_parent_merge = pm;
  this->_in_do_while = false;
}
AaPhiStatement::~AaPhiStatement() 
{
}

void AaPhiStatement::Print(ostream& ofile)
{
  ofile << this->Tab() << "$phi ";
  this->_target->Print(ofile);
  ofile << " := ";
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      ofile << this->Tab() << "  ";
      this->_source_pairs[i].second->Print(ofile);
      ofile << " $on " << this->_source_pairs[i].first;
    }
  if(this->_target->Get_Type())
    {
      ofile <<" // type of target is ";
      this->_target->Get_Type()->Print(ofile);
    }

  ofile << endl;
}

void AaPhiStatement::Set_Target(AaObjectReference* tgt)
{ 
  this->_target = tgt; 
  this->_target->Set_Is_Target(true);

  tgt->Set_Associated_Statement(this);
  this->Map_Target(tgt);

  if(!tgt->Is_Implicit_Variable_Reference())
    {
      AaRoot::Error("target of a PHI statement must be an implicit (SSA) variable.", this);
    }

  if(this->_source_pairs.size() > 0)
    {
      for(int idx = 0; idx < this->_source_pairs.size(); idx++)
	{
	  this->_source_pairs[idx].second->Add_Target(this->_target);
	  this->_target->Add_RHS_Source(this->_source_pairs[idx].second);
	}

    }
}

void AaPhiStatement::Add_Source_Pair(string label, AaExpression* expr)
{
  _merged_labels.insert(label);

  expr->Set_Associated_Statement(this);
  if(this->_target)
    {
      expr->Add_Target(this->_target);
      this->_target->Add_RHS_Source(expr);
    }

  this->_source_pairs.push_back(pair<string,AaExpression*>(label,expr));
}

void AaPhiStatement::Map_Source_References()
{

  this->_target->Map_Source_References(this->_target_objects);
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      AaProgram::Add_Type_Dependency(this->_target, this->_source_pairs[i].second);

      this->_source_pairs[i].second->Map_Source_References(this->_source_objects);
      bool special_place = (this->_source_pairs[i].first == "$entry");
      if(this->Get_In_Do_While())
	special_place = special_place || (this->_source_pairs[i].first == "$loopback");

      if(!special_place)
	{
	  AaRoot* child = this->Get_Scope()->Find_Child(this->_source_pairs[i].first);
	  if(child == NULL)
	    {
	      AaRoot::Error("could not find place statement with label " + (this->_source_pairs[i].first),this);
	    }
	  else if(!child->Is("AaPlaceStatement"))
	    {
	      AaRoot::Error("in phi statement, statement with label " + (this->_source_pairs[i].first) 
			    + " is not a place statement : line " ,this);

	    }
	}
    }
}

void AaPhiStatement::PrintC(ofstream& ofile,string tab_string)
{
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      string mlabel = this->_source_pairs[i].first;
      string check_string;

      if(mlabel == "$entry")
      {
	assert(this->_parent_merge != NULL);
	check_string = this->_parent_merge->Get_Merge_From_Entry_Ref();
      }
      else
	check_string = this->Get_Struct_Dereference() + mlabel;

      ofile << tab_string 
	    << "if(" << check_string << ")"
	    << endl;
      this->_target->PrintC(ofile,tab_string);
      ofile << " = ";
      this->_source_pairs[i].second->PrintC(ofile,"");
      ofile << ";" << endl;
    }
}

void AaPhiStatement::Write_C_Struct(ofstream& ofile)
{
  this->AaStatement::Write_C_Struct(ofile);
  if((this->_target->Is("AaSimpleObjectReference")) &&
     (((AaObjectReference*)this->_target)->Get_Object() == this))
    {
      ((AaSimpleObjectReference*)(this->_target))->PrintC_Header_Entry(ofile);
    }
}

void AaPhiStatement::Write_VC_Control_Path(ostream& ofile)
{

  ofile << "// control-path for phi:  ";
  this->Print(ofile);
  ofile << "// " << this->Get_Source_Info() << endl;

  // the phi-statement is totally handled by
  // the AaMergeStatement which contains it.

  // however, the source expressions need to be handled..
  // separately..

}


// the merge statement calls this
void AaPhiStatement::Write_VC_Source_Control_Paths(ostream& ofile)
{
  ofile << "// sources for " << this->To_String();
  for(int idx = 0; idx < _source_pairs.size(); idx++)
    _source_pairs[idx].second->Write_VC_Control_Path(ofile);
}



void AaPhiStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{
  ofile << "// constant-declarations for phi:  ";
  this->Print(ofile);
  ofile << "// " << this->Get_Source_Info() << endl;

  for(int idx = 0; idx < _source_pairs.size(); idx++)
    _source_pairs[idx].second->Write_VC_Constant_Wire_Declarations(ofile);
  
  this->_target->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaPhiStatement::Write_VC_Wire_Declarations(ostream& ofile)
{

  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  for(int idx = 0; idx < _source_pairs.size(); idx++)
    _source_pairs[idx].second->Write_VC_Wire_Declarations(false,ofile);

  this->_target->Write_VC_Wire_Declarations_As_Target(ofile);
}

// Some ordering problem here!
void AaPhiStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
  ofile << "// " << this->To_String() << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  vector<pair<string,AaType*> > sources;
  for(int i = 0; i < _source_pairs.size(); i++)
    {
      sources.push_back(pair<string,AaType*>(_source_pairs[i].second->Get_VC_Driver_Name(),
					     _source_pairs[i].second->Get_Type()));

      // write the data-path..
      _source_pairs[i].second->Write_VC_Datapath_Instances(NULL,ofile);
    }

  Write_VC_Phi_Operator(this->Get_VC_Name(),
			sources,
			_target->Get_VC_Receiver_Name(),
			_target->Get_Type(),
			ofile);
}




bool AaPhiStatement::Is_Constant()
{
  return(this->_target->Is_Constant());
}


void AaPhiStatement::Propagate_Constants()
{
  bool all_values_equal = true;
  AaValue* last_expr_value = NULL;
  for(int idx = 0; idx < _source_pairs.size(); idx++)
    {
      _source_pairs[idx].second->Evaluate();
      if(all_values_equal && _source_pairs[idx].second->Is_Constant())
	{
	  if( last_expr_value  == NULL)
	    last_expr_value = _source_pairs[idx].second->Get_Expression_Value();
	  else
	    all_values_equal = last_expr_value->Equals(_source_pairs[idx].second->Get_Expression_Value());
	}
      else if(! _source_pairs[idx].second->Is_Constant())
	all_values_equal = false;
    }

  // target is a constant if _source_pairs.size() == 1.
  if(all_values_equal && (_source_pairs.size() > 1))
    _target->Assign_Expression_Value(_source_pairs[0].second->Get_Expression_Value());
}

//---------------------------------------------------------------------
// AaSwitchStatement: public AaStatement
//---------------------------------------------------------------------
AaSwitchStatement::AaSwitchStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_select_expression = NULL;
  this->_default_sequence = NULL;
}
AaSwitchStatement::~AaSwitchStatement() {}

void AaSwitchStatement::Coalesce_Storage()
{
  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    this->_choice_pairs[i].second->Coalesce_Storage();

  if(this->_default_sequence)
    this->_default_sequence->Coalesce_Storage();
}
  
void AaSwitchStatement::Map_Source_References()
{
  
    if(this->_select_expression)
      this->_select_expression->Map_Source_References(this->_source_objects);

    for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    {
      this->_choice_pairs[i].first->Map_Source_References(this->_source_objects);
      if(this->_choice_pairs[i].first->Is("AaSimpleObjectReference"))
	{
		AaRoot* obj = ((AaSimpleObjectReference*)(this->_choice_pairs[i].first))->Get_Object();
		if(!obj->Is_Constant())
			AaRoot::Error("Choice in switch statement must be a constant", this);
	}
      else if(!this->_choice_pairs[i].first->Is("AaConstantLiteralReference"))
	{
	        AaRoot::Error("Choice in switch statement must be a scalar constant", this);
	}

      this->_choice_pairs[i].second->Map_Source_References();
    }
    if(this->_default_sequence)
      this->_default_sequence->Map_Source_References();
}

void AaSwitchStatement::Print(ostream& ofile)
{
  assert(this->_select_expression);

  ofile << this->Tab();
  ofile << "$switch ";
  this->_select_expression->Print(ofile);
  ofile << endl;

  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    {
      ofile << this->Tab();
      ofile << "  $when ";
      this->_choice_pairs[i].first->Print(ofile);
      ofile << " $then " << endl;
      this->_choice_pairs[i].second->Print(ofile);
      ofile << endl;
    }

  if(this->_default_sequence)
    {
      ofile << this->Tab() << "  $default " << endl;
      this->_default_sequence->Print(ofile);
      ofile << endl;
    }
  ofile << this->Tab();
  ofile << "$endswitch " << endl;
}


void AaSwitchStatement::Write_C_Struct(ofstream& ofile)
{
  this->AaStatement::Write_C_Struct(ofile);

  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    this->_choice_pairs[i].second->Write_C_Struct(ofile);

  if(this->_default_sequence)
    this->_default_sequence->Write_C_Struct(ofile);
}

void AaSwitchStatement::Write_C_Function_Body(ofstream& ofile)
{
  /*
    if(entryflag)
    {
    if(pipeokflag)
    {
    if(cond)
    {
    transfer-to-if-sequence
    }
    else
    {
    transfer-to-else-sequence 
    (or set exit flag)
    }
    }
    }

    sequence-invocation
    exit-condition-invocation
 
    sequence-invocation
    exit-condition-invocation
  */

  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// Begin Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "if (" << this->Get_Entry_Name_Ref() << ")" <<  endl;
  ofile << "{" << endl;

  // check if pipe read and write condition flags are set.
  ofile << "if (" ;
  // check condition flags (if they are ok for read and write)
  this->Write_Pipe_Read_Condition_Check(ofile,"");
  ofile << ") {" << endl;
  ofile << "switch (";
  this->_select_expression->PrintC(ofile,"");
  ofile << ")";
  ofile << " { " << endl;
  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    {
      ofile << " case ";
      this->_choice_pairs[i].first->PrintC(ofile,"");
      ofile << " : " << endl;
      ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;
      this->_choice_pairs[i].second->Write_Series_Entry_Transfer_Code(ofile);
      ofile << "break;" << endl;
    }
  ofile << " default : " << endl;
  if(this->_default_sequence)
    {
      ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;
      this->_default_sequence->Write_Series_Entry_Transfer_Code(ofile);
      ofile << "break;" << endl;
    }
  else
    {
      ofile <<  this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
      ofile << "break;" << endl;
    }
  ofile << "} // transfer control based on test condition" << endl;
  ofile << "} // proceed if pipe is available " << endl;
  ofile << "} // entry flag" << endl; 

  for(unsigned int i=0; i < this->_choice_pairs.size(); i++)
    {
      AaStatementSequence* sseq = this->_choice_pairs[i].second;
      ofile << "if (" 
	    <<  this->Get_In_Progress_Name_Ref() << ") {"  << endl;
      sseq->Write_Series_Statement_Invocations(ofile);


      ofile << "if (";
      sseq->Write_Series_Exit_Check_Condition(ofile);
      ofile << ")  {" <<  endl;
      sseq->Write_Clear_Exit_Flags_Code(ofile);
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;
    }
  if(this->_default_sequence)
    {
      ofile << "if (" 
	    <<  this->Get_In_Progress_Name_Ref() << ") {"  << endl;
      this->_default_sequence->Write_Series_Statement_Invocations(ofile);


      ofile << "if (";
      this->_default_sequence->Write_Series_Exit_Check_Condition(ofile);
      ofile << ")  {" <<  endl;
      this->_default_sequence->Write_Clear_Exit_Flags_Code(ofile);
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;

    }

  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// End Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
}


void AaSwitchStatement::Write_VC_Control_Path( ostream& ofile)
{
  this->Write_VC_Control_Path(false,ofile);
}
void AaSwitchStatement::Write_VC_Control_Path(bool optimize_flag,
					      ostream& ofile)
{

  ofile << "// control-path for switch  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  string exit_place = this->Get_VC_Exit_Place_Name();

  // first declare a dead region.
  string dead_link = this->Get_VC_Name() + "_dead_link";
  ofile << ";;[" << dead_link << "] { $T [dead_transition] $dead } " << endl;

  // tie up the dead link..
  ofile << this->Get_VC_Entry_Place_Name() << " |-> (" << dead_link << ")" << endl;
  ofile << exit_place << " <-| (" << dead_link << ")" << endl;
  

  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  // first evaluate the switch expression..
  ofile << "//---------------------    switch statement " << this->Get_Source_Info() << "  --------------------------" << endl;
  ofile << "$P [" << this->Get_VC_Name() << "__condition_check_place__] " << endl;

  // the select expression... may be trivial ...
  if(!this->_select_expression->Is_Implicit_Variable_Reference())
    {
      this->_select_expression->Write_VC_Control_Path(ofile);
      ofile << this->Get_VC_Name() << "__entry__ |-> (" << this->_select_expression->Get_VC_Name() << ")" << endl;
      ofile << this->Get_VC_Name() << "__condition_check_place__ <-| (" 
	    << this->_select_expression->Get_VC_Name() << ")" << endl;
    }
  else
    {
      ofile << this->Get_VC_Name() << "__entry__ |-> (" 
	    << this->Get_VC_Name() << "__condition_check_place__)"  << endl;
    }


  ofile << "||[" << this->Get_VC_Name() << "__condition_check__] { // condition computation" << endl;
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {

      ofile << ";;[condition_" << idx << "] {" << endl;

      // one comparison per choice
      ofile << " $T [rr] $T [ra] $T [cr] $T [ca] " << endl;

      // one branch operator per choice
      ofile << " $T [cmp] // cmp will trigger choice comparison" << endl;
      ofile << "}" << endl;
    }

  // need one branch operator for the default.
  // $exit of condition_check will trigger default branch comparison.
  ofile << "}" << endl;
  ofile << this->Get_VC_Name() << "__condition_check_place__ |-> (" << this->Get_VC_Name() << "__condition_check__)" << endl;

  // select place..
  ofile << "$P [" << this->Get_VC_Name() << "__select__] " << endl;

  // condition check will merge into select.
  ofile << this->Get_VC_Name() << "__select__ <-| (" << this->Get_VC_Name() << "__condition_check__)" << endl;
  // follow the place by "n+1" choices.  The +1 choice
  // corresponds to the default..

  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      ofile << "// switch choice " << idx << endl;

      // link ack1 of the corresponding branch operator
      // to choice_K/ack1.
      //
      // the ack0 transition from the branch operator
      // will be ignored..
      string source_element = this->Get_VC_Name() + "_choice_" + IntToStr(idx);
      ofile << ";;[" << source_element  << "] { $T [ack1]  // ack0 will be ignored..\n }"  << endl;

      if(optimize_flag)
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(source_element,
									   _choice_pairs[idx].second,
									   exit_place,
									   ofile);
      else
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(source_element,
								 _choice_pairs[idx].second,
								 exit_place,
								 ofile);

    }
  if(_default_sequence != NULL)
    {
      // link ack0 of the default branch operator to
      // choice_default/ack0.
      //
      // the ack1 transition from the branch operator
      // will be ignored.
      //
      string source_element = this->Get_VC_Name() + "_choice_default";
      ofile << ";;[" << source_element << "] { $T [ack0] // ack1 will be ignored..\n  }"  << endl;

      
      // the default sequence will use the ack0 signal from a branch
      // operator whose input is the concatenation of the comparisons
      // carried out in the condition-check parallel block
      ofile << "// switch default choice " << endl;

      if(!optimize_flag)
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(source_element,
								 _default_sequence,
								 exit_place,
								 ofile);
      else
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(source_element,
									   _default_sequence,
									   exit_place,
									   ofile);
    }

  // select will branch off to one of the choice
  // regions.
  ofile << this->Get_VC_Name() << "__select__ |-> (";
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";

      string source_element = this->Get_VC_Name() + "_choice_" + IntToStr(idx);
      ofile << source_element;
    }
 
  if(_default_sequence != NULL)
    {
      string source_element = this->Get_VC_Name() + "_choice_default";
      ofile << " " << source_element;
    }
  ofile << ")" << endl;

  
  ofile << "//---------------------   end of switch statement " << this->Get_Source_Info() << "  --------------------------" << endl;
}

void AaSwitchStatement::Write_VC_Constant_Declarations(ostream& ofile)
{
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      this->_choice_pairs[idx].second->Write_VC_Constant_Declarations(ofile);
    }
  if(this->_default_sequence)
    this->_default_sequence->Write_VC_Constant_Declarations(ofile);

}

void AaSwitchStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

  ofile << "// constant-declarations  for switch  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  this->_select_expression->Write_VC_Constant_Wire_Declarations(ofile);
  // constant literal expressions will be declared as constants..
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      this->_choice_pairs[idx].first->Write_VC_Constant_Wire_Declarations(ofile);
      this->_choice_pairs[idx].second->Write_VC_Constant_Wire_Declarations(ofile);
    }
  if(this->_default_sequence)
    this->_default_sequence->Write_VC_Constant_Wire_Declarations(ofile);
}

void AaSwitchStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
  ofile << "// switch-statement  " << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // wire declarations..
  this->_select_expression->Write_VC_Wire_Declarations(false,ofile);
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      AaExpression* expr = this->_choice_pairs[idx].first;
      Write_VC_Wire_Declaration(expr->Get_VC_Constant_Name() + "_cmp", "$int<1>",ofile);
      this->_choice_pairs[idx].second->Write_VC_Wire_Declarations(ofile);
    }
  if(this->_default_sequence)
    this->_default_sequence->Write_VC_Wire_Declarations(ofile);
  
}
void AaSwitchStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
  ofile << "// datapath-instances  for switch  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  vector<pair<string,AaType*> > default_branch_inputs;
  this->_select_expression->Write_VC_Datapath_Instances(NULL,ofile);
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      AaExpression* expr = this->_choice_pairs[idx].first;
      vector<pair<string,AaType*> > br_input;

      // one comparison operator per switch choice.
      Write_VC_Binary_Operator(__EQUAL, 
			       this->Get_VC_Name() + "_select_expr_" + IntToStr(idx),
			       _select_expression->Get_VC_Driver_Name(),
			       _select_expression->Get_Type(),
			       expr->Get_VC_Constant_Name(),
			       expr->Get_Type(),
			       expr->Get_VC_Constant_Name() + "_cmp",
			       expr->Get_Type(),
			       this->Get_VC_Guard_String(),
			       ofile);

      br_input.push_back(pair<string,AaType*>(expr->Get_VC_Constant_Name() + "_cmp",
					      expr->Get_Type()));
      default_branch_inputs.push_back(pair<string,AaType*>(expr->Get_VC_Constant_Name() + "_cmp",
							   expr->Get_Type()));

      // one branch instance per switch choice.
      Write_VC_Branch_Instance(this->Get_VC_Name() + "_branch_" + IntToStr(idx),
			       br_input,
			       ofile);
      this->_choice_pairs[idx].second->Write_VC_Datapath_Instances(ofile);
    }

  if(this->_default_sequence != NULL)
    {
      // one branch instance for the default.
      Write_VC_Branch_Instance(this->Get_VC_Name() + "_branch_default",
			       default_branch_inputs,
			       ofile);
      this->_default_sequence->Write_VC_Datapath_Instances(ofile);
    }
}

void AaSwitchStatement::Write_VC_Links(string hier_id, ostream& ofile)
{
  this->Write_VC_Links(false,hier_id,ofile);
}

void AaSwitchStatement::Write_VC_Links(bool optimize_flag,
				       string hier_id, ostream& ofile)
{

  ofile << "// CP-DP links for switch  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  vector<string> reqs, acks;
  // links in the expression tree.
  this->_select_expression->Write_VC_Links(hier_id,ofile);

  //  links for each of the choices.  Note that there will
  //  be a single branch instance for each choice.
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {


      // for the comparison operation.
      reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/rr");
      reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/cr");
      acks.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/ra");
      acks.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/ca");
      Write_VC_Link(this->Get_VC_Name() + "_select_expr_" + IntToStr(idx),reqs,acks,ofile);
      
      reqs.clear();
      acks.clear();

      // for the branch operator
      reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "__condition_check__/condition_" + IntToStr(idx) + "/cmp");
      acks.push_back("$open"); // ack0 is ignored. 
      acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_choice_" + IntToStr(idx) + "/ack1");
      Write_VC_Link(this->Get_VC_Name() + "_branch_" + IntToStr(idx),
		    reqs,
		    acks,
		    ofile);

      reqs.clear();
      acks.clear();

      // choice sequence has links too..
      if(!optimize_flag)
	this->_choice_pairs[idx].second->Write_VC_Links(hier_id, ofile);
      else
	{
	  ((AaBranchBlockStatement*)pscope)->
	    Write_VC_Links_Optimized(hier_id,
				     this->_choice_pairs[idx].second,
				     ofile);	  

	}

    }

  // link for the default branch.
  if(this->_default_sequence != NULL)
    {
      string req_hier_id = hier_id + "/" + this->Get_VC_Name() + "__condition_check__";

      // the branch operator for the default.
      reqs.push_back(req_hier_id + "/$exit");
      acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_choice_default/ack0");
      acks.push_back("$open"); // ack1 is ignored.
      Write_VC_Link(this->Get_VC_Name() + "_branch_default",reqs,acks,ofile);
      reqs.clear();
      acks.clear();

      // default sequence has links too..
      if(!optimize_flag)
	this->_default_sequence->Write_VC_Links(hier_id,ofile);
      else
	{
	  ((AaBranchBlockStatement*)pscope)->
	    Write_VC_Links_Optimized(hier_id,
				     this->_default_sequence,
				     ofile);	  
	}

    }
}

void AaSwitchStatement::Propagate_Constants()
{
  if(this->_select_expression->Get_Type() == NULL)
    {
      AaRoot::Error("Could not determine type of select expression in switch statement.. ", this);
    }
  else
    {
      this->_select_expression->Evaluate();
      for(int idx = 0; idx < _choice_pairs.size(); idx++)
	{
	  if(this->_choice_pairs[idx].first->Is("AaSimpleObjectReference"))
	  	this->_choice_pairs[idx].first->Evaluate();
	  else
	  {
	  	if(!this->_choice_pairs[idx].first->Get_Type())
	    	{
	      		this->_choice_pairs[idx].first->Set_Type(this->_select_expression->Get_Type());
	    	}
	  	this->_choice_pairs[idx].first->Evaluate();
	  }
	  this->_choice_pairs[idx].second->Propagate_Constants();
	}

      if(this->_default_sequence)
	this->_default_sequence->Propagate_Constants();
    }
}

void AaSwitchStatement::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	int idx;
	for(idx = 0; idx < _choice_pairs.size(); idx++)
	{
		_choice_pairs[idx].second->Get_Target_Places(target_places);
	}
}

//---------------------------------------------------------------------
// AaIfStatement: public AaStatement
//---------------------------------------------------------------------
AaIfStatement::AaIfStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_test_expression = NULL;
  this->_if_sequence = NULL;
  this->_else_sequence = NULL;
}
AaIfStatement::~AaIfStatement() {}

void AaIfStatement::Coalesce_Storage()
{
  if(this->_if_sequence)
    this->_if_sequence->Coalesce_Storage();

  if(this->_else_sequence)
    this->_if_sequence->Coalesce_Storage();
}


void AaIfStatement::Print(ostream& ofile)
{
  assert(this->_test_expression);
  assert(this->_if_sequence);

  ofile << this->Tab();
  ofile << "$if ";
  this->_test_expression->Print(ofile);
  ofile << " $then " << endl;
  this->_if_sequence->Print(ofile);
  ofile << endl;
  if(this->_else_sequence)
    {
      ofile << this->Tab() << "$else " << endl;
      this->_else_sequence->Print(ofile);
      ofile << endl;
    }
  ofile << this->Tab() << "$endif" << endl;
}


void AaIfStatement::Write_C_Struct(ofstream& ofile)
{
  this->AaStatement::Write_C_Struct(ofile);
  if(this->_if_sequence)
    this->_if_sequence->Write_C_Struct(ofile);
  if(this->_else_sequence)
    this->_else_sequence->Write_C_Struct(ofile);
}

void AaIfStatement::Write_C_Function_Body(ofstream& ofile)
{
  /*
    if(entryflag)
    {
    if(pipeokflag)
    {
    if(cond)
    {
    transfer-to-if-sequence
    }
    else
    {
    transfer-to-else-sequence 
    (or set exit flag)
    }
    }
    }

    if-sequence-invocation
    if-exit-condition-invocation
 
    else-sequence-invocation
    else-exit-condition-invocation
  */
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// Begin Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "if (" << this->Get_Entry_Name_Ref() << ")" <<  endl;
  ofile << "{" << endl;

  // check if pipe read and write condition flags are set.
  ofile << "if (" ;
  // check condition flags (if they are ok for read and write)
  this->Write_Pipe_Read_Condition_Check(ofile,"");
  ofile << ") {" << endl;
  this->Write_Pipe_Read_Condition_Update(ofile,"");
  ofile << "if (";
  this->_test_expression->PrintC(ofile,"");
  ofile << ") { " << endl;
  if(this->_if_sequence)
    {
      ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;
      this->_if_sequence->Write_Series_Entry_Transfer_Code(ofile);
    }
  else
    {
      ofile <<  this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
    }
  ofile << "} " << endl; 
  ofile << "else {" << endl;
  if(this->_else_sequence)
    {
      ofile << this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile << this->Get_In_Progress_Name_Ref() << " = 1;"  << endl;
      this->_else_sequence->Write_Series_Entry_Transfer_Code(ofile);
    }
  else
    {
      ofile <<  this->Get_Entry_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
    }
  ofile << "} // transfer control based on test condition" << endl;
  ofile << "} // proceed if pipe is available " << endl;
  ofile << "} // entry flag" << endl; 

  if(this->_if_sequence)
    {

      ofile << "if (" 
	    <<  this->Get_In_Progress_Name_Ref() << ") {"  << endl;
      this->_if_sequence->Write_Series_Statement_Invocations(ofile);


      ofile << "if (";
      this->_if_sequence->Write_Series_Exit_Check_Condition(ofile);
      ofile << ")  {" <<  endl;
      this->_if_sequence->Write_Clear_Exit_Flags_Code(ofile);
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;

    }
  if(this->_else_sequence)
    {
      ofile << "if (" 
	    <<  this->Get_In_Progress_Name_Ref() << ") {"  << endl;
      this->_else_sequence->Write_Series_Statement_Invocations(ofile);



      ofile << "if (";
      this->_else_sequence->Write_Series_Exit_Check_Condition(ofile);
      ofile << ")  {" <<  endl;

      this->_else_sequence->Write_Clear_Exit_Flags_Code(ofile);
      ofile <<  this->Get_In_Progress_Name_Ref() << " = 0;"  << endl;
      ofile <<  this->Get_Exit_Name_Ref() << " = 1;"  << endl;
      ofile << "}" << endl;
      ofile << "}" << endl;
    }
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// End Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
}



void AaIfStatement::Write_VC_Control_Path(ostream& ofile)
{
  this->Write_VC_Control_Path(false,ofile);
}

void AaIfStatement::Write_VC_Control_Path(bool optimize_flag, ostream& ofile)
{

  ofile << "// if-statement  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  string exit_place = this->Get_VC_Exit_Place_Name();

  // a dead-link: to show that the normal path of control
  // flow is from entry to exit.. but this normal path is
  // not taken.
  //
  // this is needed because we do structure checks on
  // CP regions which would fail otherwise.
  string dead_link = this->Get_VC_Name() + "_dead_link";
  ofile << ";;[" << dead_link << "] { $T [dead_transition] $dead } " << endl;

  // tie up the dead link..
  ofile << this->Get_VC_Entry_Place_Name() << " |-> (" << dead_link << ")" << endl;
  ofile << exit_place << " <-| (" << dead_link << ")" << endl;
  

  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  // first the CP for the test expression
  string eval_test_region = this->Get_VC_Name() + "_eval_test";
  string if_link = this->Get_VC_Name() + "_if_link";
  string else_link = this->Get_VC_Name() + "_else_link";


  ofile << ";;[" << eval_test_region << "] { // test expression evaluate and trigger branch "  << endl;
  this->_test_expression->Write_VC_Control_Path(ofile);
    
  ofile << " $T [branch_req] " << endl;
  ofile << "}" << endl;
  ofile << this->Get_VC_Name() << "__entry__ |-> (" << eval_test_region << ")" << endl;
  
  // now the test-place.
  ofile << "$P [" << _test_expression->Get_VC_Name() << "_place]" << endl;
  ofile << _test_expression->Get_VC_Name() << "_place <-| (" << eval_test_region << ")" << endl;
  string test_place_successors = if_link + " " + else_link;

  ofile << ";;[" << if_link << "] { $T [if_choice_transition] } " << endl;
  ofile << ";;[" << else_link << "] { $T [else_choice_transition] } " << endl;

  ofile << _test_expression->Get_VC_Name() << "_place |-> (" << test_place_successors << ")" << endl;  


  // now the if-sequence of statments
  if(_if_sequence != NULL)
    {

      if(!optimize_flag)
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(if_link,
								 _if_sequence,
								 exit_place,
								 ofile);
      else
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(if_link,
									   _if_sequence,
									   exit_place,
									   ofile);
	
    }
  else
    {
      ofile << exit_place << " <-| (" << if_link << ")" << endl;
    }

  if(_else_sequence != NULL)
    {
      if(!optimize_flag)
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(else_link,
								 _else_sequence,
								 exit_place,
								 ofile);
      else
	((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path_Optimized(else_link,
									   _else_sequence,
									   exit_place,
									   ofile);
    }
  else
    {
      ofile << exit_place << " <-| (" << else_link << ")" << endl;
    }

}

void AaIfStatement::Write_VC_Constant_Declarations(ostream& ofile)
{
  if(this->_if_sequence)
    this->_if_sequence->Write_VC_Constant_Declarations(ofile);
  if(this->_else_sequence)
    this->_else_sequence->Write_VC_Constant_Declarations(ofile);
}

void AaIfStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

  ofile << "// if-statement  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  // one wire for the test expression result.
  this->_test_expression->Write_VC_Constant_Wire_Declarations(ofile);

 if(this->_if_sequence)
    this->_if_sequence->Write_VC_Constant_Wire_Declarations(ofile);

  if(this->_else_sequence)
    this->_else_sequence->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaIfStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
  ofile << "// if statement  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // one wire for the test expression result.
  this->_test_expression->Write_VC_Wire_Declarations(false,ofile);

  // wires from the if-sequence
  if(this->_if_sequence)
    this->_if_sequence->Write_VC_Wire_Declarations(ofile);

  // wires from the else-sequence
  if(this->_else_sequence)
    this->_else_sequence->Write_VC_Wire_Declarations(ofile);

}
void AaIfStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
  
  ofile << "// datapath-instances for if  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // test expression needs to be computed.
  this->_test_expression->Write_VC_Datapath_Instances(NULL, ofile);

  // followed by a branch.
  vector<pair<string,AaType*> > branch_inputs;
  branch_inputs.push_back(pair<string,AaType*>(this->_test_expression->Get_VC_Driver_Name(),
					       this->_test_expression->Get_Type()));
			  
  Write_VC_Branch_Instance(this->Get_VC_Name()+"_branch",
			   branch_inputs,
			   ofile);

  if(this->_if_sequence)
    this->_if_sequence->Write_VC_Datapath_Instances(ofile);

  if(this->_else_sequence)
    this->_else_sequence->Write_VC_Datapath_Instances(ofile);
}

void AaIfStatement::Write_VC_Links(string hier_id,ostream& ofile)
{
  this->Write_VC_Links(false,hier_id,ofile);
}

void AaIfStatement::Write_VC_Links(bool optimize_flag, string hier_id,ostream& ofile)
{

  ofile << "// CP-DP links for if  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  this->_test_expression->Write_VC_Links(hier_id + "/" + this->Get_VC_Name() + "_eval_test",ofile);
  vector<string> reqs;
  vector<string> acks;

  reqs.push_back(hier_id + "/" + this->Get_VC_Name() + "_eval_test/branch_req");
  acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_else_link/else_choice_transition");
  acks.push_back(hier_id + "/" + this->Get_VC_Name() + "_if_link/if_choice_transition");

  Write_VC_Link(this->Get_VC_Name()+"_branch",reqs,acks,ofile);

  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  if(this->_if_sequence)
    {
      if(!optimize_flag)
	this->_if_sequence->Write_VC_Links(hier_id,ofile);
      else
	{
	  ((AaBranchBlockStatement*)pscope)->Write_VC_Links_Optimized(hier_id,
								      _if_sequence,
								      ofile);
	}
    }

  if(this->_else_sequence)
    {
      if(!optimize_flag)
	this->_else_sequence->Write_VC_Links(hier_id,ofile);
      else
	{
	  ((AaBranchBlockStatement*)pscope)->Write_VC_Links_Optimized(hier_id,
								      _else_sequence,
								      ofile);
	}
    }
}

void AaIfStatement::Propagate_Constants()
{
  if(this->_test_expression->Get_Type() == NULL)
    {
      AaRoot::Warning("Could not determine type of test expression in if statement.. will assume that it is $uint<1> ", this);
      this->_test_expression->Set_Type(AaProgram::Make_Uinteger_Type(1));
    }
  this->_test_expression->Evaluate();
  if(this->_if_sequence)
    this->_if_sequence->Propagate_Constants();
  if(this->_else_sequence)
    this->_else_sequence->Propagate_Constants();
}

void AaIfStatement::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	if(this->_if_sequence)
		this->_if_sequence->Get_Target_Places(target_places);
	if(this->_else_sequence)
		this->_if_sequence->Get_Target_Places(target_places);
}

//---------------------------------------------------------------------
// AaPlaceStatement: public AaStatement
//---------------------------------------------------------------------
AaPlaceStatement::AaPlaceStatement(AaBranchBlockStatement* parent_tpr,string lbl):AaStatement(parent_tpr) 
{
  this->_label = lbl;
  parent_tpr->Map_Child(lbl,this);
};
AaPlaceStatement::~AaPlaceStatement() {};
void AaPlaceStatement::Write_C_Struct(ofstream& ofile)
{
  this->Err_Check();

  ofile << this->Tab() << "unsigned int " << this->Get_Entry_Name() << ": 1;" << endl;
  // NOTE: no exit flag!

}
void AaPlaceStatement::Write_C_Function_Body(ofstream& ofile) 
{

  this->Err_Check();

  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// Begin Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "if (" << this->Get_Entry_Name_Ref() << ") {" << endl;
  ofile << this->Get_Place_Name_Ref() << "= 1;" << endl;
  ofile << this->Get_Entry_Name_Ref() << "= 0;" << endl;
  ofile << "}" << endl;

  // DO NOT SET THE EXIT FLAG!

  ofile << "// -------------------------------------------------------------------------------------------" << endl;
  ofile << "// End Statement " << this->Get_C_Name() << endl;
  ofile << "// -------------------------------------------------------------------------------------------" << endl;
}


//---------------------------------------------------------------------
// AaDoWhileStatement: public AaStatement
//---------------------------------------------------------------------
AaDoWhileStatement::AaDoWhileStatement(AaBranchBlockStatement* scope):AaStatement(scope) 
{
  this->_test_expression = NULL;
  this->_merge_statement = NULL;
  this->_loop_body_sequence = NULL;
}
AaDoWhileStatement::~AaDoWhileStatement() {}

void AaDoWhileStatement::Coalesce_Storage()
{
  if(this->_merge_statement)
    this->_merge_statement->Coalesce_Storage();

  if(this->_loop_body_sequence)
    this->_loop_body_sequence->Coalesce_Storage();
}


void AaDoWhileStatement::Print(ostream& ofile)
{
  assert(this->_test_expression);
  assert(this->_loop_body_sequence);

  if(AaProgram::_balance_loop_pipeline_bodies)
  {
	this->Equalize_Paths_For_Pipelining();
  }

  ofile << this->Tab();
  ofile << "$do " << endl;
  this->_merge_statement->Print(ofile);
  this->_loop_body_sequence->Print(ofile);
  ofile << " $while " ;
  this->_test_expression->Print(ofile);
  ofile << endl;
}


void AaDoWhileStatement::Write_C_Struct(ofstream& ofile)
{
	AaRoot::Error("AaDoWhileStatement:Write_C_Struct not implemented.\n",this);
	assert(0);
}

void AaDoWhileStatement::Write_C_Function_Body(ofstream& ofile)
{
	AaRoot::Error("AaDoWhileStatement:Write_C_Function_Body not implemented.\n",this);
	assert(0);
}

void AaDoWhileStatement::Write_VC_Control_Path(ostream& ofile)
{
  // for the moment, DoWhile is always written in optimized
  // fashion.
  this->Write_VC_Control_Path(true,ofile);
}

void AaDoWhileStatement::Write_VC_Control_Path_Optimized(ostream& ofile)
{
  this->Write_VC_Control_Path(true,ofile);
}

void AaDoWhileStatement::Write_VC_Control_Path(bool optimize_flag, ostream& ofile)
{

  // in the optimized case, there are two regions in
  // the CP for the dowhile.  An outer loop region
  // and an inner region for the loop-body.
  //
  // The inner region has two input places (bound to 
  // corresponding transitions) and is a pipelined
  // fork body.  The PHI statements are included
  // in the inner body and their sequencing is
  // handled inside the inner body.
  // 
  ofile << "// do-while-statement  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // the outer region name
  string vc_block_id = "loop_" + Int64ToStr(this->Get_Index());

  // the inner region name
  string vc_loop_body_id = this->Get_VC_Name() + "_loop_body";

  // start the outer region
  ofile << "<o> [" << this->Get_VC_Name() << "] {" << endl;

  // entry and exit places.
  string entry_place_name = this->Get_VC_Name() + "__entry__";
  string exit_place_name = this->Get_VC_Name() + "__exit__";
  __Place(entry_place_name);
  __Place(exit_place_name);

  // the syntax is very strict about the ordering of
  // declarations:
  //    First the loop_back place.
  __Place("loop_back");
    
  //    then the condition_done place (which is bound to 
  //    the condition evaluation transition in the loop body).
  __Place("condition_done");

  // a place to indicate the the loop-body has finished
  // an iteration.
  __Place("loop_body_done");

  // next: the loop_body, which is a pipeline.
  // to write its control-path, we must pass in the
  // test-expression as well as the list of PHI statements
  // which act as sources for the expressions within
  // the loop body.
  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  // get the list of Phi-stmts.
  vector<AaStatement*> phi_stmts;
  for(unsigned int idx = 0; idx < this->_merge_statement->Get_Statement_Count(); idx++)
    {
      phi_stmts.push_back(this->_merge_statement->Get_Statement(idx));
    }


  AaBlockStatement* pstmt = (AaBlockStatement*) pscope;
  // Here's where the inner body gets written.
  // This is a hack which reuses as much code as possible.
  // perhaps it can be cleaned up later (which means never :-))
  pstmt->Write_VC_Control_Path_Optimized(true, 
					 this->_test_expression,
					 _loop_body_sequence,
					 &phi_stmts,
					 vc_loop_body_id,
					 ofile); 

  //    following the loop body, the branch options (exit/taken)
  ofile << ";; [loop_exit] { $T [ack] } " << endl;
  ofile << ";; [loop_taken] { $T [ack] } " << endl;


  //    merges.
  ofile << entry_place_name << " <-| ($entry)" << endl;
  ofile << "loop_body_done <-| ( " << vc_loop_body_id << " ) " << endl;

  // branches.
  ofile << "condition_done |-> (loop_exit loop_taken)" << endl;
  // ofile << entry_place_name << " |-> ( " << vc_loop_body_id<< " ) " << endl;
  ofile << exit_place_name << " |-> ($exit)" << endl;

  //    the binding of the condition_done to the test expression completion.
  ofile << "$bind condition_done <= " << vc_loop_body_id << " : condition_evaluated"; 

  // the binding of the loop-entry contol places to the loop body.
  ofile << "$bind " << entry_place_name << "  => " << vc_loop_body_id << " : first_time_through_loop_body " << endl; 
  ofile << "$bind loop_back  => " << vc_loop_body_id << " : back_edge_to_loop_body " << endl; 

  //    the terminator!
  ofile << "$terminate (loop_exit loop_taken loop_body_done) (loop_back " << exit_place_name << ")" << endl;
  ofile << "}" << endl;
}

void AaDoWhileStatement::Write_VC_Constant_Declarations(ostream& ofile)
{
  this->_merge_statement->Write_VC_Constant_Declarations(ofile);
  if(this->_loop_body_sequence)
    this->_loop_body_sequence->Write_VC_Constant_Declarations(ofile);
}

void AaDoWhileStatement::Write_VC_Constant_Wire_Declarations(ostream& ofile)
{

  ofile << "// do-while statement  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;


  // one wire for the test expression result.
  this->_test_expression->Write_VC_Constant_Wire_Declarations(ofile);

 if(this->_merge_statement)
    this->_merge_statement->Write_VC_Constant_Wire_Declarations(ofile);

  if(this->_loop_body_sequence)
    this->_loop_body_sequence->Write_VC_Constant_Wire_Declarations(ofile);
}
void AaDoWhileStatement::Write_VC_Wire_Declarations(ostream& ofile)
{
  ofile << "// do-while statement  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // one wire for the test expression result.
  this->_test_expression->Write_VC_Wire_Declarations(false,ofile);

  // wires from the if-sequence
  if(this->_merge_statement)
    this->_merge_statement->Write_VC_Wire_Declarations(ofile);

  // wires from the else-sequence
  if(this->_loop_body_sequence)
    this->_loop_body_sequence->Write_VC_Wire_Declarations(ofile);

}
void AaDoWhileStatement::Write_VC_Datapath_Instances(ostream& ofile)
{
  
  ofile << "// datapath-instances for do-while  ";
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  // test expression needs to be computed.
  this->_test_expression->Write_VC_Datapath_Instances(NULL, ofile);

  // followed by a branch.
  vector<pair<string,AaType*> > branch_inputs;
  branch_inputs.push_back(pair<string,AaType*>(this->_test_expression->Get_VC_Driver_Name(),
					       this->_test_expression->Get_Type()));
			  
  Write_VC_Branch_Instance(this->Get_VC_Name()+"_branch",
			   branch_inputs,
			   ofile);

  if(this->_merge_statement)
    this->_merge_statement->Write_VC_Datapath_Instances(ofile);

  if(this->_loop_body_sequence)
    this->_loop_body_sequence->Write_VC_Datapath_Instances(ofile);
}

void AaDoWhileStatement::Write_VC_Links(string hier_id,ostream& ofile)
{
  this->Write_VC_Links(true,hier_id,ofile);
}

void AaDoWhileStatement::Write_VC_Links_Optimized(string hier_id,ostream& ofile)
{
  this->Write_VC_Links(true,hier_id,ofile);
}

void AaDoWhileStatement::Write_VC_Links(bool optimize_flag, string hier_id,ostream& ofile)
{
  ofile << "// CP-DP links for do-while  " << this->Get_VC_Name();
  ofile << endl;
  ofile << "// " << this->Get_Source_Info() << endl;

  string this_hier_id = Augment_Hier_Id(hier_id, this->Get_VC_Name());
  string loop_body_id = this->Get_VC_Name() + "_loop_body";
  string loop_body_seq_hier_id = Augment_Hier_Id(this_hier_id,loop_body_id);

  // in the PHI statements in the do-while.
  for(int idx=0, fidx = this->_merge_statement->Get_Statement_Count(); idx < fidx; idx++)
    {
      AaStatement* cphi = this->_merge_statement->Get_Statement(idx);
      cphi->Write_VC_Links_Optimized(loop_body_seq_hier_id, ofile);
    }

  // in the loop body
  _loop_body_sequence->Write_VC_Links_Optimized(loop_body_seq_hier_id, ofile);

  // test expression sits inside the loop-body.
  _test_expression->Write_VC_Links_Optimized(loop_body_seq_hier_id,ofile);

  // branch instance..
  vector<string> reqs;
  vector<string> acks;
  // req to branch is produced by completion of test expression..
  // which is inside the loop-body
  reqs.push_back(loop_body_seq_hier_id + "/condition_evaluated");
  // acks from branch in loop-exit and loop-taken which are in here.
  acks.push_back(this_hier_id + "/loop_exit/ack");
  acks.push_back(this_hier_id + "/loop_taken/ack");
  string br_inst_name = this->Get_VC_Name() + "_branch";
  Write_VC_Link(br_inst_name, reqs,acks,ofile);

}

void AaDoWhileStatement::Propagate_Constants()
{
  if(this->_test_expression->Get_Type() == NULL)
    {
      AaRoot::Warning("Could not determine type of test expression in do-while statement.. will assume that it is $uint<1> ", this);
      this->_test_expression->Set_Type(AaProgram::Make_Uinteger_Type(1));
    }
  this->_test_expression->Evaluate();
  if(this->_merge_statement)
    this->_merge_statement->Propagate_Constants();
  if(this->_loop_body_sequence)
    this->_loop_body_sequence->Propagate_Constants();
}

void AaDoWhileStatement::Get_Target_Places(set<AaPlaceStatement*>& target_places)
{
	// do nothing.
}


// Build a weighted statement precedence graph as follows:
//   1.  A vertex for each expression/statement.
//   2.  If result of u is used in v  then introduce an edge u -> v.  
//       The weight of the edge is the estimated delay incurred in executing
//       statement v in hardware.
//   3.  For each u, build a longest path tree to
//       its neighbours.  
//   4.  For each statement u, find the maximum slack Su on
//       any path u->v relative to the longest path tree.
//   5.  For each u, introduce Su delayed versions of u.
//   6.  For each u: in every v such that u->v, if the slack on u->v
//       is Suv, then replace the uses of u in v by 
//       u-delayed-by-Suv.
//
void AaDoWhileStatement::Equalize_Paths_For_Pipelining()
{
	// implicit variable references.. which are targets
	// of statements and the expression that depend on them,
	// with the estimated delay from the point of generation
	// to the point of use.
	map<AaRoot*, vector< pair<AaRoot*, int> > > adjacency_map;

	// set of statements already visited.
	set<AaRoot*> visited_elements;

	// steps 1,2.
	//
	
	// first put the phi-statements in the visited_statements set..
	//
  	for(int idx=0, fidx = this->_merge_statement->Get_Statement_Count(); idx < fidx; idx++)
	{
      		AaStatement* cphi = (this->_merge_statement->Get_Statement(idx));
		cphi->Update_Adjacency_Map(adjacency_map, visited_elements);
	}
	
	// now update the adjacencies.
  	for(int idx=0, fidx = this->_loop_body_sequence->Get_Statement_Count(); idx < fidx; idx++)
	{
      		AaStatement* curr_stmt = this->_loop_body_sequence->Get_Statement(idx);
		curr_stmt->Update_Adjacency_Map(adjacency_map, visited_elements);
	}


	// OK. At this point, you have all the adjacencies.  Now, 
	// AaRoot::Info("Adjacency map in do-while loop body " + this->Get_VC_Name());
	for(map<AaRoot*,vector<pair<AaRoot*,int> > >::iterator miter = adjacency_map.begin(),
			fmiter = adjacency_map.end(); miter != fmiter; miter++)
	{
		AaRoot* tmp  = (*miter).first;
		if(tmp != NULL)
			cerr << (*miter).first->To_String() << " (" << (*miter).first->Get_VC_Name() << "): " << endl;
		else
			cerr <<  "NULL : " << endl;

		for(int idx = 0, fidx = (*miter).second.size(); idx < fidx; idx++)
		{
			cerr << "\t(" << (*miter).second[idx].first->Get_VC_Name() << "," << (*miter).second[idx].second << ")" 
			     << endl;
		}
	}

	// find the longest paths from the NULL node to all other
	// vertices.
	map<AaRoot*, int> longest_paths_from_root_map;

	// find longest paths to each element from NULL.	
  	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();
		iter != fiter; iter++)
	{
		longest_paths_from_root_map[*iter] = 0;	
        }
	this->Find_Longest_Paths(adjacency_map,longest_paths_from_root_map);

	// Now, for each expression in visited-elements..  introduce delayed
	// versions of them as needed.
  	for(set<AaRoot*>::iterator iter = visited_elements.begin(), fiter = visited_elements.end();
		iter != fiter; iter++)
	{
      		AaRoot* curr = *iter;
		this->Add_Delayed_Versions(curr, adjacency_map, longest_paths_from_root_map);
	}
}

// find the longest paths.  First do a topological sort
// and then a straight update.
void AaDoWhileStatement::Find_Longest_Paths(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
				map<AaRoot*, int>& longest_paths_from_root_map)
{	

	// reverse lookup map.
	map<AaRoot*, vector<pair<AaRoot*,int> > > predecessor_map;
	AaGraphBase g;


	// first build a Boost graph.
	string nname = "null";
	g.Add_Vertex(NULL);

	for(map<AaRoot*,int>::iterator miter = longest_paths_from_root_map.begin(),
		fmiter = longest_paths_from_root_map.end();
		miter != fmiter;
		miter++)
	{
		AaRoot* it = (*miter).first;
		g.Add_Vertex(it);
	}

	for(map<AaRoot*,vector< pair<AaRoot*,int> > >::iterator iter = adjacency_map.begin(), fiter = adjacency_map.end();
		iter != fiter;
		iter++)
	{
		AaRoot* u = (*iter).first;
		for(int idx = 0, fidx = (*iter).second.size(); idx < fidx; idx++)
		{
			AaRoot* v = (*iter).second[idx].first;
			int length = (*iter).second[idx].second;
			g.Add_Edge(u,v);

			predecessor_map[v].push_back(pair<AaRoot*,int>(u,length));
		}
	}

	// topological sort.
	vector<AaRoot*> precedence_order;
	g.Topological_Sort(precedence_order);

	for(int idx = precedence_order.size()-1, fidx = 0; idx >= fidx; idx--)
	{
		
				
		AaRoot* v = precedence_order[idx];
		int lp = 0;

		if(v != NULL)
		{
			int curr_dist = longest_paths_from_root_map[v];
			int new_dist =0;
			for(int jdx = 0, fjdx = predecessor_map[v].size(); jdx < fjdx; jdx++)
			{
				AaRoot* u = predecessor_map[v][jdx].first;

				int dist_to_u = 0;
				if(u != NULL)
				{
					dist_to_u = longest_paths_from_root_map[u];
				}
				int length = predecessor_map[v][jdx].second;
				int nn = length + dist_to_u;
				if(nn > new_dist)
				{	
					new_dist = nn;
				}
			}

			if(new_dist > curr_dist)
			{
				lp = new_dist;
				longest_paths_from_root_map[v] = new_dist;
			}
			else
				lp  = curr_dist;
			AaRoot::DebugInfo("longest path to " + v->Get_VC_Name() + " is " + IntToStr(lp));
		}
		else
			 AaRoot::DebugInfo("longest path to NULL is 0");
	}
}

void AaDoWhileStatement::Add_Delayed_Versions(AaRoot* curr, 
		map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, 
		map<AaRoot*, int>& longest_paths_from_root_map)
{
	AaExpression* curr_expr = NULL;
	if(curr->Is_Expression())
	{
		curr_expr = (AaExpression*) curr;
	}
	else if(curr->Is_Statement())
	{
		return;
	}

	map<AaRoot*,int> slack_map;
	// TODO
	// Look at all the outarcs of curr.  If there is slack present on the outarc,
	// calculate the slack for that arc.  Keep track of the maximum, and
	// add those many delayed versions of curr (you will need to add
	// assignment statements for them).  Then for each outarc, reconnect
	// from curr to the appropriate delayed version!
	int max_slack = 0;
	for(int idx = 0, fidx = adjacency_map[curr].size(); idx < fidx; idx++)
	{
		AaRoot* nbr = adjacency_map[curr][idx].first;

		// check for slack only on neighbours which are
		// expressions.
		if(nbr->Is_Statement())
			continue;

		int dist =  adjacency_map[curr][idx].second;
		int slack = longest_paths_from_root_map[nbr] - (dist + longest_paths_from_root_map[curr]);


		if(slack_map.find(nbr) == slack_map.end())
			slack_map[nbr] = slack;
		else if(slack_map[nbr] < slack)
			slack_map[nbr] = slack;

		if(slack > max_slack)
			max_slack = slack;
	}


	// if the maximum slack is 0, then do nothing..
	if(max_slack == 0)
		return;

	AaStatement* stmt = curr_expr->Get_Associated_Statement();
	AaAssignmentStatement* root_stmt = NULL;
	
	if(stmt == NULL)
	{
		// This can happen if there is a reference to
		// an interface object.
	   return;
	}

	vector<AaStatement*> delayed_versions;

	if(curr_expr->Get_Is_Target())
	{

		// get here only if it is an implicit variable
		// reference.
		assert(curr_expr->Is_Implicit_Variable_Reference());

		// if expression is target, then introduce delayed 
		// statements after the stmt in which it occurs.
		string root_name = curr_expr->Get_Name();
		string current_source_name = root_name;
		string delayed_name;
		for(int idx =1; idx < max_slack; idx++)
		{
			delayed_name =  root_name + "_" + Int64ToStr(curr_expr->Get_Index()) + "_delayed_" + 
						IntToStr(idx);

			AaSimpleObjectReference* new_target = new AaSimpleObjectReference(this->Get_Scope(), delayed_name);
			new_target->Set_Type(curr_expr->Get_Type());

			AaSimpleObjectReference* new_src    = new AaSimpleObjectReference(this->Get_Scope(), current_source_name);
			new_src->Set_Type(curr_expr->Get_Type());
			
			AaAssignmentStatement* new_stmt = new AaAssignmentStatement(this->Get_Scope(),
											new_target,
											new_src,
											0);
			new_stmt->Map_Source_References();

			delayed_versions.push_back(new_stmt);
			current_source_name = delayed_name;
		}
		this->_loop_body_sequence->Insert_Statements_After(stmt,delayed_versions);
	}
	else
	{
		// if expression is not a target, then the delayed
		// statements should be introduced before the statement
		// in which the expression occurs.
		string root_name = curr_expr->Get_Name() + "_" + Int64ToStr(curr_expr->Get_Index());

		AaExpression* new_target = new AaSimpleObjectReference(this->Get_Scope(), root_name);
		new_target->Set_Type(curr_expr->Get_Type());

		root_stmt = new AaAssignmentStatement(this->Get_Scope(),
							new_target,
							curr_expr,
							0);
		delayed_versions.push_back(root_stmt);

		string current_source_name = root_name;
		for(int idx =1; idx < max_slack; idx++)
		{
			string delayed_name =  root_name + "_delayed_" + IntToStr(idx);
			AaSimpleObjectReference* new_target = new AaSimpleObjectReference(this->Get_Scope(), delayed_name);
			new_target->Set_Type(curr_expr->Get_Type());
			
			AaSimpleObjectReference* new_src    = new AaSimpleObjectReference(this->Get_Scope(), current_source_name);
			new_src->Set_Type(curr_expr->Get_Type());
			
			AaAssignmentStatement* new_stmt = new AaAssignmentStatement(this->Get_Scope(),
											new_target,
											new_src,
											0);
			new_stmt->Map_Source_References();

			delayed_versions.push_back(new_stmt);
			current_source_name = delayed_name;
		}
		this->_loop_body_sequence->Insert_Statements_Before(stmt,delayed_versions);
	}

	for(map<AaRoot*,int>::iterator iter = slack_map.begin(), fiter = slack_map.end(); iter != fiter; iter++)
	{
		AaRoot* nbr = (*iter).first;
		int slack   = (*iter).second;
	
		
	
                assert(slack <= max_slack);

		// Replace uses of curr_expr in nbr_expr by 
		// a simple object reference to the appropriately
		// delayed version.
		//
 		if(slack > 0)
		{
			assert(nbr->Is_Expression());
			AaExpression* nbr_expr = (AaExpression*) nbr;

			AaAssignmentStatement* rs = (AaAssignmentStatement*) delayed_versions[slack-1];
			nbr_expr->Replace_Uses_By(curr_expr, rs);
		}
		else if(!curr_expr->Get_Is_Target())
		{
			assert(nbr->Is_Expression());
			AaExpression* nbr_expr = (AaExpression*) nbr;

			nbr_expr->Replace_Uses_By(curr_expr, root_stmt);
		}
	}
}

void AaPhiStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
       	AaExpression* tgt_expression = this->Get_Target();
	__InsMap(adjacency_map,NULL,this,0);
	__InsMap(adjacency_map,this,tgt_expression,1);
	visited_elements.insert(this);
}

void AaAssignmentStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	AaExpression* src_expression = this->_source;
	src_expression->Update_Adjacency_Map(adjacency_map, visited_elements);
	__InsMap(adjacency_map,src_expression,this,0);

	visited_elements.insert(this);

       	AaExpression* tgt_expression = this->Get_Target();
	tgt_expression->Update_Adjacency_Map(adjacency_map,visited_elements);

	int delay = 0;
	// check if delay not accounted for.
	if(src_expression->Is_Implicit_Variable_Reference())
		delay = 1;
	// arc from root to tgt_expression.
	__InsMap(adjacency_map,this,tgt_expression,delay);
}

void AaCallStatement::Update_Adjacency_Map(map<AaRoot*, vector< pair<AaRoot*, int> > >& adjacency_map, set<AaRoot*>& visited_elements)
{
	for(int idx = 0, fidx = _input_args.size(); idx < fidx; idx++)
	{
		AaExpression* src = _input_args[idx];
		src->Update_Adjacency_Map(adjacency_map, visited_elements);
		__InsMap(adjacency_map,src,this,0);
	}

	for(int idx = 0, fidx = _output_args.size(); idx < fidx; idx++)
	{
		AaExpression* tgt = _output_args[idx];
		tgt->Update_Adjacency_Map(adjacency_map, visited_elements);
		int delay = this->_called_module->Get_Delay();
		__InsMap(adjacency_map,this,tgt,delay);
	}
}


AaSimpleObjectReference* AaCallStatement::Get_Implicit_Target(string tgt_name)
{
	AaSimpleObjectReference* ret = NULL;
        for(int idx = 0, fidx = _output_args.size(); idx < fidx; idx++)
	{
		AaObjectReference* oarg = _output_args[idx];
		if(oarg->Is_Implicit_Variable_Reference())
		{
			string oarg_name = oarg->Get_Object_Root_Name();
			if(oarg_name == tgt_name)
			{
				ret = (AaSimpleObjectReference*) oarg;
				break;
			}
		}
	}	
	return(ret);
}
