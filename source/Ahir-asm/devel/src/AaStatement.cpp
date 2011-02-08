#include <AaProgram.h>

//---------------------------------------------------------------------
// AaStatement
//---------------------------------------------------------------------
AaStatement::AaStatement(AaScope* p): AaScope(p) 
{
  this->_tab_depth = ((p != NULL) ? p->Get_Depth()+1 : 1);
  _index_in_sequence = -1;
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
void AaStatement::Map_Target(AaObjectReference* obj_ref) 
{
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
  

  bool is_array_ref = obj_ref->Is("AaArrayObjectReference");

  bool from_above = ((child != NULL) && (child->Is_Expression()) && 
		     (((AaExpression*)child)->Get_Scope() != this->Get_Scope()));

  bool map_flag = (((child == NULL) || from_above) && 
		   (search_scope == this->Get_Scope()) && 
		   !(is_array_ref));
  bool err_no_target_in_scope = ((child == NULL) && (is_array_ref || (search_scope != this->Get_Scope())));
  bool err_redeclaration = ((child !=NULL) && (child->Is_Expression()) &&
			    (((AaExpression*)child)->Get_Scope() == this->Get_Scope()));

  bool err_write_to_constant = ((child !=NULL) && child->Is("AaConstantObject"));
  bool err_write_to_input_port = ((child != NULL) &&
				  (child->Is("AaInterfaceObject") && 
				   (((AaInterfaceObject*)child)->Get_Mode() == "in")));

  bool err_multiple_refs_to_ports =((child != NULL) &&  
				    child->Is("AaInterfaceObject") && 
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

  if(map_flag)
    {
      this->Get_Scope()->Map_Child(obj_ref_root_name,obj_ref);
      obj_ref->Set_Object(this);
    }
  else if((child != NULL) && !err_flag)
    {
      obj_ref->Set_Object(child);

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


string AaStatement::Get_VC_Name()
{
  string ret_string = this->Kind() + "_" + Int64ToStr(this->Get_Index());
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

//---------------------------------------------------------------------
// AaNullStatement: public AaStatement
//---------------------------------------------------------------------
AaNullStatement::AaNullStatement(AaScope* parent_tpr):AaStatement(parent_tpr) {};
AaNullStatement::~AaNullStatement() {};
void AaNullStatement::Write_VC_Control_Path(ostream& ofile)
{
  // write a blank series block...
  ofile << ";;[" << this->Get_VC_Name() << "] {"  << endl;
  ofile << "$T [dummy] // dummy transition " << endl;
  ofile << "}";
}

//---------------------------------------------------------------------
// AaAssignmentStatement
//---------------------------------------------------------------------
AaAssignmentStatement::AaAssignmentStatement(AaScope* parent_tpr, AaObjectReference* tgt, AaExpression* src, int lineno):
  AaStatement(parent_tpr) 
{
  assert(tgt); assert(src);

  this->Set_Line_Number(lineno);
  this->_target = tgt;
  this->Map_Target(tgt);

  this->_source = src;
}
AaAssignmentStatement::~AaAssignmentStatement() {};
void AaAssignmentStatement::Print(ostream& ofile)
{
  ofile << this->Tab();
  this->Get_Target()->Print(ofile);
  ofile << " := ";
  this->Get_Source()->Print(ofile);
  if(this->Get_Target()->Get_Type())
    {
      ofile <<" // type of target is ";
      this->Get_Target()->Get_Type()->Print(ofile);
    }
  ofile << endl;

}
void AaAssignmentStatement::Map_Source_References()
{
  this->_target->Map_Source_References(this->_target_objects);
  this->_source->Map_Source_References(this->_source_objects);
  AaProgram::Add_Type_Dependency(this->_target,this->_source);
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
  if(this->_target->Get_Object() == this)
    {
      ofile << this->Tab() 
	    << this->_target->Get_Type()->CName() 
	    << " "
	    << this->_target->Get_Object_Ref_String()
	    << ";" << endl;
    }
}

void AaAssignmentStatement::Write_VC_Control_Path(ostream& ofile)
{
  ofile << ";;[" << this->Get_VC_Name() << "] // " << this->Get_Source_Info() << endl << " {" << endl;
  this->_source->Write_VC_Control_Path(ofile);
  this->_target->Write_VC_Control_Path(ofile);
  ofile << "} // end assignment statement " << this->Get_VC_Name() << endl;
}

//---------------------------------------------------------------------
// AaCallStatement
//---------------------------------------------------------------------
AaCallStatement::AaCallStatement(AaScope* parent_tpr,
				 string func_name,
				 vector<AaObjectReference*>& inargs, 
				 vector<AaObjectReference*>& outargs,
				 int lineno): AaStatement(parent_tpr)
{

  this->_function_name = func_name;
  this->Set_Line_Number(lineno);
  this->_called_module = NULL;

  for(unsigned int i = 0; i < inargs.size(); i++)
    {
      this->_input_args.push_back(inargs[i]);
    }

  for(unsigned int i = 0; i < outargs.size(); i++)
    {
      this->_output_args.push_back(outargs[i]);
      this->Map_Target(outargs[i]);
    }
}
AaCallStatement::~AaCallStatement() {};
  
AaObjectReference* AaCallStatement::Get_Input_Arg(unsigned int index)
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

  ofile << this->Tab();
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
	  // inarg -> inargument
	  this->_input_args[i]->Add_Source_Reference(called_module->Get_Input_Argument(i));
	  called_module->Get_Input_Argument(i)->Add_Target_Reference(this->_input_args[i]);

	}
    }
  for(unsigned int i=0; i < this->_output_args.size(); i++)
    {
      if(called_module != NULL)
	{
	  // outarg <- outargument
	  this->_output_args[i]->Add_Target_Reference(called_module->Get_Output_Argument(i));
	  called_module->Get_Output_Argument(i)->Add_Source_Reference(this->_output_args[i]);
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
	  ofile << this->Tab() 
		<< this->_output_args[i]->Get_Type()->CName() 
		<< " "
		<< this->_output_args[i]->Get_Object_Ref_String()
		<< ";" << endl;
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
  // all calls will be considered as able to block
  return(this->Get_Called_Module() != NULL);
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
  ofile << ";;[" << this->Get_VC_Name() << "] {" << endl;
  ofile << "||[" << this->Get_VC_Name() << "_in_args_] {" << endl;
  for(int idx = 0; idx < _input_args.size(); idx++)
    _input_args[idx]->Write_VC_Control_Path(ofile);
  ofile << "}" << endl;

  ofile << "$T [crr] $T [cra] $T [ccr] $T [cca]" << endl;

  ofile << "||[" << this->Get_VC_Name() << "_out_args_] {" << endl;
  for(int idx = 0; idx < _output_args.size(); idx++)
    _output_args[idx]->Write_VC_Control_Path(ofile);
  ofile << "}" << endl;

  ofile << "} // end call-statement " << this->Get_VC_Name() << endl;
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


void AaBlockStatement::Write_VC_Pipe_Declarations(ostream& ofile)
{
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
  ofile << "::[ " << this->Get_VC_Name() << "] {" << endl;
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
  ofile << "}" << endl;
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

void AaBranchBlockStatement::Write_VC_Control_Path(ostream& ofile)
{
  // three passes..
  ofile << "<>[" << this->Get_VC_Name() << "] // Branch Block " << endl << " {" << endl;

  // entry and exit place, created explicitly
  ofile << "$P [" << this->Get_VC_Name() << "__entry__]" << endl;
  ofile << "$P [" << this->Get_VC_Name() << "__exit__]" << endl;

  this->Write_VC_Control_Path(true, this->_statement_sequence, ofile);

  ofile << "} " << endl;
}

void AaBranchBlockStatement::Write_VC_Control_Path(bool link_to_self,
						   AaStatementSequence* sseq,
						   ostream& ofile)
{
  if(sseq)
    {
      // first declare the entry/exit places for statements
      // in the sequence..
      for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = sseq->Get_Statement(idx);
	  if(!stmt->Is("AaPlaceStatement"))
	    {
	      // every statement other than a place 
	      ofile << "$P [" << stmt->Get_VC_Name() << "__entry__] " << endl;
	      ofile << "$P [" << stmt->Get_VC_Name() << "__exit__] " << endl;
	    }
	}

      // now the place statements.
      for(int idx = 0; idx  < sseq->Get_Statement_Count(); idx++)
	{
	  AaStatement* stmt = sseq->Get_Statement(idx);
	  if(stmt->Is("AaPlaceStatement"))
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
	      ofile << stmt->Get_VC_Name() << "__entry__ |-> (" << stmt->Get_VC_Name() << ")" << endl;
	      ofile << stmt->Get_VC_Name() << "__exit__ <-| (" << stmt->Get_VC_Name() << ")" << endl;
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
	    
	  if(!stmt->Is("AaPlaceStatement"))
	    {
	      // stmt must pass control to its successor..
	      AaStatement* next_stmt = sseq->Get_Next_Statement(stmt);
	      if(next_stmt != NULL)
		{
		  if(!next_stmt->Is("AaPlaceStatement"))
		    ofile << stmt->Get_VC_Name() << "__exit__ |-> (" << next_stmt->Get_VC_Name() << "__entry__)" << endl;
		  else
		    ofile << stmt->Get_VC_Name() << "__exit__ |-> (" << next_stmt->Get_VC_Name() << ")" << endl;
		}
	      else if(link_to_self)
		ofile << stmt->Get_VC_Name() << "__exit__ |-> ($exit)";
		
		
	      AaStatement* prev_stmt = sseq->Get_Previous_Statement(stmt);
	      if(prev_stmt == NULL)
		{
		  if(link_to_self)
		    ofile << stmt->Get_VC_Name() << "__entry__ <-| ($entry)" << endl;
		}
	      else
		{
		  if(!prev_stmt->Is("AaPlaceStatement"))		  
		    ofile << stmt->Get_VC_Name() << "__entry__ <-| (" << prev_stmt->Get_VC_Name() << "__exit__)" << endl;
		  else
		    ofile << stmt->Get_VC_Name() << "__entry__ <-| (" << prev_stmt->Get_VC_Name() << ")" << endl;
		}
	    }
	}
    }
  else if(link_to_self)
    {
      ofile << "$P [dummy_place_] " << endl;
      ofile << "dummy_place_ <-| ($entry) " << endl;
      ofile << "dummy_place_ |-> ($exit)" << endl;
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
  if(_join_labels.size() == 0)
    {
      ofile << this->Get_VC_Name() << " <-& ($entry)" <<  endl;
    }
  else
    {
      ofile << this->Get_VC_Name() << " <-& (" <<  endl;
      for(int idx = 0; idx < _join_labels.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " ";
	  ofile << _join_labels[idx];
	}
      ofile << ")" << endl;
    }

  if(_wait_on_statements.size() == 0)
    {
      ofile << this->Get_VC_Name() << " &-> ($exit)" <<  endl;
    }
  else
    {
      ofile << this->Get_VC_Name() << " &-> (" <<  endl;
      for(int idx = 0; idx < _wait_on_statements.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " ";
	  ofile << _wait_on_statements[idx]->Get_VC_Name();
	}
      ofile << ")" << endl;
    }
}

//---------------------------------------------------------------------
// AaMergeStatement: public AaStatement
//---------------------------------------------------------------------
AaMergeStatement::AaMergeStatement(AaBranchBlockStatement* scope):AaSeriesBlockStatement((AaScope*)scope,"") 
{
  this->_wait_on_entry = 0;
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
      if(this->_merge_label_vector[i] != "$entry")
	{
	  AaRoot* child = 
	    ((AaScope*)this->Get_Scope())->Find_Child_Here(this->_merge_label_vector[i]);
	  if(child != NULL)
	    {
	      if(child->Is("AaPlaceStatement"))
		{
		  this->_wait_on_statements.push_back((AaPlaceStatement*)child);
		  ((AaPlaceStatement*)child)->Increment_Merge_Count();
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

string AaMergeStatement::Get_VC_Name()
{
  string ret_string = this->Kind() + "_" + Int64ToStr(this->Get_Index());
  return(ret_string);
}

void AaMergeStatement::Write_VC_Control_Path(ostream& ofile)
{
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
      string mplace = ((mlabel == "$entry") ? (this->Get_VC_Name() + "__entry__") : mlabel);


      ofile << "||[" << mplace << "_PhiReq] {" << endl; 
      if(phi_dependency_map[mlabel].size() > 0)
	{
	  for(set<AaPhiStatement*>::iterator siter = phi_dependency_map[mlabel].begin();
	      siter != phi_dependency_map[mlabel].end();
	      siter++)
	    {
	      ofile << "$T [" << (*siter)->Get_VC_Name() << "_req] " << endl;
	    }
	}
      else
	{
	  ofile << "$T [dummy]" << endl;
	}
      ofile << "}" << endl;
      
      // merge-labels 
      ofile << mplace << " |-> (" << mplace << "_PhiReq)" << endl;
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
      string mplace = ((mlabel == "$entry") ? (this->Get_VC_Name() + "__entry__") : mlabel);
      ofile << " " << mplace << "_PhiReq "; 
    }
  ofile << ")" << endl;

  // now a parallel region, in which we wait for all
  // the acks from the phi statements associated with
  // this merge statement.
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
  ofile << this->Get_VC_Name() << "__exit__ <-| (" << this->Get_VC_Name() << "_PhiAck)" << endl;

  // thats it..
  ofile << "//---------------------  end of merge statement " << this->Get_Source_Info() << "  --------------------------" << endl;
}


//---------------------------------------------------------------------
// AaPhiStatement: public AaStatement
//---------------------------------------------------------------------
AaPhiStatement::AaPhiStatement(AaBranchBlockStatement* scope, AaMergeStatement* pm):AaStatement(scope) 
{
  this->_target = NULL;
  this->_parent_merge = pm;
}
AaPhiStatement::~AaPhiStatement() 
{
}

void AaPhiStatement::Print(ostream& ofile)
{
  ofile << this->Tab() << "$phi ";
  this->_target->Print(ofile);
  ofile << " := ";
  if(this->_target->Get_Type())
    {
      ofile <<" // type of target is ";
      this->_target->Get_Type()->Print(ofile);
      ofile << endl;
    }
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      ofile << this->Tab() << "  ";
      this->_source_pairs[i].second->Print(ofile);
      ofile << " $on " << this->_source_pairs[i].first << endl;
    }
  ofile << endl;
}
void AaPhiStatement::Map_Source_References()
{
  this->_target->Map_Source_References(this->_target_objects);
  for(unsigned int i=0; i < this->_source_pairs.size(); i++)
    {
      AaProgram::Add_Type_Dependency(this->_target, this->_source_pairs[i].second);

      this->_source_pairs[i].second->Map_Source_References(this->_source_objects);
      if(this->_source_pairs[i].first != "$entry")
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
	check_string = this->_parent_merge->Get_Merge_From_Entry_Ref();
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
  if(this->_target->Get_Object() == this)
    {
      ofile << this->Tab() 
	    << this->_target->Get_Type()->CName() 
	    << " "
	    << this->_target->Get_Object_Ref_String()
	    << ";" << endl;
    }
}

void AaPhiStatement::Write_VC_Control_Path(ostream& ofile)
{

  // the phi-statement is totally handled by
  // the AaMergeStatement which contains it.
  ofile << ";;[" << this->Get_VC_Name() << "] { " 
	<< "$T [dummy] " << endl
	<< "}" << endl;
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

void AaSwitchStatement::Write_VC_Control_Path(ostream& ofile)
{
  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  // first evaluate the switch expression..

  ofile << "//---------------------    switch statement " << this->Get_Source_Info() << "  --------------------------" << endl;
  this->_select_expression->Write_VC_Control_Path(ofile);
  ofile << this->Get_VC_Name() << "__entry__ |-> (" << this->_select_expression->Get_VC_Name() << ")" << endl;

  ofile << "//---------------------    condition computation  --------------------------" << endl;
  ofile << "||[" << this->Get_VC_Name() << "__condition_check__] {" << endl;
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      ofile << ";;[condition_" << idx << "] {" << endl;
      ofile << "$T [rr] $T [ra] $T [cr] $T [ca] " << endl;
      ofile << "}" << endl;
    }
  ofile << "}" << endl;
  ofile << "$P [" << this->Get_VC_Name() << "__select__] " << endl;
  ofile << this->Get_VC_Name() << "__select__ <-| (" << this->Get_VC_Name() << "__condition_check__)" << endl;
  ofile << "//---------------------    choices  --------------------------" << endl;
  // follow the place by "n+1" choices.  The +1 choice
  // corresponds to the default..
  vector<AaStatement*> last_statements;
  vector<AaStatement*> first_statements;
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      ofile << "//---------------------    alternative " << idx << "  --------------------------" << endl;
      ((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(false,_choice_pairs[idx].second,ofile);
      last_statements.push_back(_choice_pairs[idx].second->Get_Statement(_choice_pairs[idx].second->Get_Statement_Count() - 1));
      first_statements.push_back(_choice_pairs[idx].second->Get_Statement(0));
      ofile << ";;[choice_" << idx << "] { $T [choice_transition]  }"  << endl;
      if(first_statements[idx]->Is("AaPlaceStatement"))
	{
	  ofile << first_statements[idx]->Get_VC_Name() << " <-| (choice_" << idx << ")" << endl;
	}
      else
	{
	  ofile << first_statements[idx]->Get_VC_Name() << "__entry__ <-| (choice_" << idx << ")" <<  endl;
	}
    }
  if(_default_sequence != NULL)
    {
      // the default sequence will use the ack0 signal from a branch
      // operator whose input is the concatenation of the comparisons
      // carried out in the condition-check parallel block
      ofile << "//---------------------  default ---------------------------------------" << endl;
      ((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(false,_default_sequence,ofile);
      last_statements.push_back(_default_sequence->Get_Statement(_default_sequence->Get_Statement_Count() - 1));
      first_statements.push_back(_default_sequence->Get_Statement(0));

      ofile << ";;[choice_default] { $T [choice_transition]  }"  << endl;
      if(first_statements.back()->Is("AaPlaceStatement"))
	{
	  ofile << first_statements.back()->Get_VC_Name() << " <-| (choice_default) " << endl;
	}
      else
	{
	  ofile << first_statements.back()->Get_VC_Name() << "__entry__ <-| (choice_default)" <<  endl;
	}
    }

  ofile << this->Get_VC_Name() << "__select__ |-> (";
  for(int idx = 0; idx < _choice_pairs.size(); idx++)
    {
      if(idx > 0)
	ofile << " ";
      ofile << "choice_" << idx;
    }
  if(_default_sequence != NULL)
    ofile << " choice_default";
  ofile << ")" << endl;
  
  ofile << "//---------------------  exit merge for switch ---------------------------------------" << endl;
  string exit_merge_list;
  for(int idx = 0; idx < last_statements.size(); idx++)
    {
      if(!last_statements[idx]->Is("AaPlaceStatement"))
	{
	  exit_merge_list += last_statements[idx]->Get_VC_Name() + "__exit__ ";	  
	}
    }
  
  if(exit_merge_list != "")
    {
      ofile << this->Get_VC_Name() << "__exit__ <-| ("  << exit_merge_list << ")" << endl;
    }
  ofile << "//---------------------   end of switch statement " << this->Get_Source_Info() << "  --------------------------" << endl;
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
  AaScope* pscope = this->Get_Scope();
  assert(pscope->Is("AaBranchBlockStatement"));

  // first the CP for the test expression
  this->_test_expression->Write_VC_Control_Path(ofile);
  ofile << this->Get_VC_Name() << "__entry__ |-> (" << this->_test_expression->Get_VC_Name() << ")" << endl;
  
  // now the test-place.
  ofile << "$P [" << _test_expression->Get_VC_Name() << "_place]" << endl;
  ofile << _test_expression->Get_VC_Name() << "_place <-| (" << _test_expression->Get_VC_Name() << ")" << endl;
  
  AaStatement* last_if = NULL;
  AaStatement* last_else = NULL;
  // now the if-sequence of statments
  if(_if_sequence != NULL)
    {
      ((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(false,_if_sequence,ofile);
      last_if = _if_sequence->Get_Statement(_if_sequence->Get_Statement_Count() -1 );
      
    }
  if(_else_sequence != NULL)
    {
      ((AaBranchBlockStatement*)pscope)->Write_VC_Control_Path(false,_else_sequence,ofile);
      last_else = _else_sequence->Get_Statement(_else_sequence->Get_Statement_Count() -1 );
    }
  else
    {
      ofile << ";;[NullElse] { $T [dummy] } " << endl;
    }

  string exit_merge_list;
  if(!last_if->Is("AaPlace"))
    exit_merge_list += last_if->Get_VC_Name() + " ";
  if(last_else != NULL)
    {
      if(!last_else->Is("AaPlace"))
	exit_merge_list += last_else->Get_VC_Name() + " ";
    }
  else
    exit_merge_list += "NullElse ";

  if(exit_merge_list != "")
    {
      ofile << this->Get_VC_Name() << "__exit__ <-| ("  << exit_merge_list << ")" << endl;
    }
}


//---------------------------------------------------------------------
// AaPlaceStatement: public AaStatement
//---------------------------------------------------------------------
AaPlaceStatement::AaPlaceStatement(AaBranchBlockStatement* parent_tpr,string lbl):AaStatement(parent_tpr) 
{
  this->_label = lbl;
  this->_merge_count = 0;
  parent_tpr->Map_Child(lbl,this);
};
AaPlaceStatement::~AaPlaceStatement() {};
void AaPlaceStatement::Write_C_Struct(ofstream& ofile)
{
  this->Err_Check();

  ofile << this->Tab() << "unsigned int " << this->Get_Place_Name() << ": 1;" << endl;
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


