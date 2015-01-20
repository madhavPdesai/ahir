#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <AaValue.h>
#include <AaExpression.h>
#include <AaObject.h>
#include <AaStatement.h>
#include <AaModule.h>
#include <Aa2VC.h>
#include <AaProgram.h>

/***************************************** MODULE   ****************************/

//---------------------------------------------------------------------
// AaModule
//---------------------------------------------------------------------
AaModule::AaModule(string fname): AaSeriesBlockStatement(NULL,fname)
{
  _foreign_flag = false;
  _inline_flag = false;
  _macro_flag = false;
  _pipeline_flag = false;
  _pipeline_depth = 1;
  _pipeline_buffering = 1;
  _pipeline_full_rate_flag = false;
  
  _writes_to_shared_pipe = false;
  _reads_from_shared_pipe = false;

  _number_of_times_called = 0;
  this->Set_Delay(2);

}

void AaModule::Add_Argument(AaInterfaceObject* obj)
{

  assert(obj);

  this->Map_Child(obj->Get_Name(), obj);

  if(obj->Get_Mode() == "in")
    {
      this->_input_args.push_back(obj);
    }
  else if(obj->Get_Mode() == "out")
    {
      this->_output_args.push_back(obj);
    }
  else
    {
      assert(0 && "unknown interface mode");
    }
}


void AaModule::Set_Macro_Flag(bool ff) 
{ 
  if(this->_inline_flag && ff)
    {
      AaRoot::Error("module " + this->Get_Label() + " is already marked inline, it cannot be a macro", this);
    }
  else
    this->_macro_flag = ff; 
}

void AaModule::Set_Inline_Flag(bool ff) 
{ 
  if(this->_macro_flag && ff)
    {
      AaRoot::Error("module " + this->Get_Label() + " is already marked as a macro, it cannot be inline", this);
    }
  else
    this->_inline_flag = ff; 
}

AaExpression* AaModule::Lookup_Print_Remap(AaInterfaceObject* obj)
{
  map<AaInterfaceObject*, AaExpression* >::iterator iter = _print_remap.find(obj);
  if(iter != _print_remap.end())
    return ((*iter).second);
  else
    return(NULL);
}

void AaModule::Print(ostream& ofile)
{
  if(this->Get_Inline_Flag())
    ofile << "$inline ";
  if(this->Get_Macro_Flag())
    ofile << "$macro ";
  if(this->Get_Pipeline_Flag())
  {
    ofile << "$pipeline $depth " << this->Get_Pipeline_Depth() << " ";
    ofile << "$buffering " << this->Get_Pipeline_Depth() << " ";
    if(this->Get_Pipeline_Full_Rate_Flag())
	ofile << "$fullrate ";
  }

  ofile << "$module [" << this->Get_Label() << "]" << endl;
  ofile << "\t $in (";
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      this->_input_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")" << endl;

  ofile << "\t $out (";
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      this->_output_args[i]->Print(ofile);
      ofile << " ";
    }
  ofile << ")";
  ofile << endl;
  ofile << "$is" << endl;
  ofile << "{" << endl;
  this->Print_Body(ofile);
  ofile << "}" << endl;
}

void AaModule::Print_Body(ostream& ofile)
{
  	// print objects
  	this->Print_Objects(ofile);

  	if(AaProgram::_balance_loop_pipeline_bodies)
  	{
  		if(this->Get_Pipeline_Flag())
			this->Equalize_Paths_For_Pipelining();
  	}

  	// print statement sequence
  	this->Print_Statement_Sequence(ofile);

  	this->Print_Attributes(ofile);
}

void AaModule::Print_Attributes(ostream& ofile)
{
  for(map<string,string>::iterator iter = _attribute_map.begin(), fiter =_attribute_map.end();
      iter != fiter;
      iter++)
    {
      ofile << "$attribute " << (*iter).first << " " << (*iter).second << endl;
    }
}

AaRoot* AaModule::Find_Child(string tag)
{
  AaRoot* child = this->Find_Child_Here(tag);
  if(child == NULL)
    {
      child = AaProgram::Find_Object(tag);
      if(child == NULL)
	child = AaProgram::Find_Module(tag);
    }
  return(child);
}


void AaModule::Map_Source_References()
{
  this->AaBlockStatement::Map_Source_References();
}


void AaModule::Write_C_Header(ofstream& ofile)
{

	ofile << "void " 
		<< this->Get_C_Wrap_Function_Name() 
		<< "(";
	bool first_one = true;
	for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
		if(!first_one)
			ofile << ", ";
		first_one = false;
		ofile << this->_input_args[i]->Get_Type()->C_Name();
	}
	for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
		if(!first_one)
			ofile << ", ";
		first_one = false;
		ofile << this->_output_args[i]->Get_Type()->C_Name();
		ofile << "* ";
	}
	ofile << ");" << endl;
}

void AaModule::Write_C_Source(ofstream& ofile)
{
	if(!this->Get_Foreign_Flag())
	{
		ofile << "void " 
			<< this->Get_C_Wrap_Function_Name() 
			<< "(";
		bool first_one = true;
		for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
		{
			if(!first_one)
				ofile << ", ";
			first_one = false;
			ofile << this->_input_args[i]->Get_Type()->C_Name();
			ofile << " " << this->_input_args[i]->Get_Name();
		}
		for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
		{
			if(!first_one)
				ofile << ", ";
			first_one = false;
			ofile << this->_output_args[i]->Get_Type()->C_Name();
			ofile << "* ";
			ofile << " " << this->_output_args[i]->Get_Name();
		}
		ofile << ")" << endl;
		ofile << "{" << endl;
		this->Write_C_Object_Declarations(ofile);
		this->_statement_sequence->PrintC(ofile);
		ofile << "}" << endl;
	}
}

void AaModule::Propagate_Constants()
{
	if(this->_statement_sequence)
		this->_statement_sequence->Propagate_Constants();
}


void AaModule::Mark_Reachable_Modules(set<AaModule*>& reachable_modules)
{
	if(reachable_modules.find(this) == reachable_modules.end())
	{
		AaRoot::Info("module " + this->Get_Label() + " is reachable from a specified root module.");
		reachable_modules.insert(this);
		for(set<AaModule*>::iterator citer = _called_modules.begin(), fciter = _called_modules.end();
				citer != fciter;
				citer++)
		{
			(*citer)->Mark_Reachable_Modules(reachable_modules);
		}
	}
}


bool AaModule::Has_No_Side_Effects()
{
	if(this->Get_Foreign_Flag())
		return(true);

	if(_reads_from_shared_pipe)
		return(false);

	if(_writes_to_shared_pipe)
		return(false);

	if(_shared_memory_spaces.size() > 0)
	return(false);

  if(_global_objects_that_are_written.size() > 0)
	return(false);

  return(true);
}

void AaModule::Set_Foreign_Object_Representatives()
{
  bool is_root = (this->Get_Number_Of_Times_Called() ==  0);
	
  if(is_root)
    {
      for(int idx = 0,  fidx = this->Get_Number_Of_Input_Arguments(); 
	  idx < fidx;
	  idx++)
	{
	  AaInterfaceObject* inobj = this->Get_Input_Argument(idx);
	  if(inobj->Get_Type()->Is_Pointer_Type())
	    {
	      AaRoot::Info("input argument " + inobj->Get_Name() + " of module " + this->Get_Label()
			   + " points to foreign storage ");

	      AaStorageObject* fobj = NULL;
	      if(!AaProgram::_keep_extmem_inside)
		{
		  AaType* el_type = ((AaPointerType*)inobj->Get_Type())->Get_Ref_Type();
		  fobj = AaProgram::Make_Foreign_Storage_Object(el_type);
		}
	      else
		fobj = AaProgram::Get_Extmem_Object();

	      fobj->Add_Source_Reference(inobj);  // inobj uses fobj as a source
	      inobj->Add_Target_Reference(fobj);  // fobj uses inobj as a target
	      inobj->Propagate_Addressed_Object_Representative(fobj,NULL);
	    }
	  else
	    {
	      AaStorageObject* fobj = NULL;

	      // not a pointer, so we cannot say anything about the
	      // type of the object to which it points.
	      if(!AaProgram::_keep_extmem_inside)
		{
		  fobj = AaProgram::Make_Foreign_Storage_Object(AaProgram::Make_Void_Type());
		}
	      else
		fobj = AaProgram::Get_Extmem_Object();



	      fobj->Add_Source_Reference(inobj);  // inobj uses fobj as a source
	      inobj->Add_Target_Reference(fobj);  // fobj uses inobj as a target
	      inobj->Propagate_Addressed_Object_Representative(fobj,NULL);
	    }
	}
	    
      for(int idx = 0,  fidx = this->Get_Number_Of_Output_Arguments(); 
	  idx < fidx;
	  idx++)
	{
	  AaInterfaceObject* outobj = this->Get_Output_Argument(idx);
	  if(outobj->Get_Type()->Is_Pointer_Type())
	    {
		    
	      AaRoot::Info("output argument " + outobj->Get_Name() + " of module " + this->Get_Label()
			   + " points to foreign storage ");

	      AaStorageObject* fobj = NULL;
	      if(!AaProgram::_keep_extmem_inside)
		{
		  AaType* el_type = ((AaPointerType*)outobj->Get_Type())->Get_Ref_Type();
		  fobj = AaProgram::Make_Foreign_Storage_Object(el_type);
		}
	      else
		fobj = AaProgram::Get_Extmem_Object();


	      fobj->Add_Source_Reference(outobj);  // fobj uses outobj as a source
	      outobj->Add_Target_Reference(fobj);  // outobj uses fobj as a target

	      outobj->Propagate_Addressed_Object_Representative(fobj,NULL);
	    }
	  else
	    {
	      AaStorageObject* fobj = NULL;
	      // not a pointer, so we cannot say anything about the
	      // type of the object to which it points.
	      if(!AaProgram::_keep_extmem_inside)
		{
		  fobj = AaProgram::Make_Foreign_Storage_Object(AaProgram::Make_Void_Type());
		}
	      else
		fobj = AaProgram::Get_Extmem_Object();


	      fobj->Add_Source_Reference(outobj);  // fobj uses outobj as a source
	      outobj->Add_Target_Reference(fobj);  // outobj uses fobj as a target
	      outobj->Propagate_Addressed_Object_Representative(fobj,NULL);
	    }
	}
    }
}

void AaModule::Write_VC_Model(ostream& ofile)
{
  this->Write_VC_Model(false,ofile);
}

void AaModule::Write_VC_Model_Optimized(ostream& ofile)
{
  string no_opt_string = "nooptimize";
  if(this->_attribute_map.find("nooptimize") == this->_attribute_map.end())
    this->Write_VC_Model(true,ofile);
  else
    this->Write_VC_Model(false,ofile);    
}

void AaModule::Write_VC_Model(bool opt_flag, ostream& ofile)
{

  //  this->Propagate_Constants();
  if(this->_foreign_flag)
    ofile << "$foreign ";

  if(this->Get_Pipeline_Flag())
  {
    ofile << "$pipeline $depth " << this->Get_Pipeline_Depth() << " ";
    ofile << "$buffering " << this->Get_Pipeline_Depth() << " ";
    if(this->Get_Pipeline_Full_Rate_Flag())
	ofile << "$fullrate ";
  }

  ofile << "$module [" << this->Get_Label() << "] {" << endl;
  if(_input_args.size() > 0)
    {
      ofile << "$in ";
      for(int idx = 0; idx < _input_args.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " ";

	  _input_args[idx]->Write_VC_Model(ofile);
	}
    }

  ofile << endl;

  if(_output_args.size() > 0)
    {
      ofile << "$out ";
      for(int idx = 0; idx < _output_args.size(); idx++)
	{
	  if(idx > 0)
	    ofile << " ";
	  _output_args[idx]->Write_VC_Model(ofile);
	}
    }
  ofile << endl;

  if(!this->_foreign_flag)
    {
      this->Write_VC_Pipe_Declarations(ofile);
      this->Write_VC_Memory_Spaces(opt_flag, ofile);  
      
      this->Write_VC_Control_Path(opt_flag, ofile);
      this->Write_VC_Data_Path(ofile);
      this->Write_VC_Links(opt_flag, ofile);
    }

  ofile << "}" << endl;
}

void AaModule::Write_VC_Links(bool opt_flag, ostream& ofile)
{
  if(this->_statement_sequence)
    {
      if(opt_flag)
	this->Write_VC_Links_Optimized_Base("",ofile);
      else
	this->_statement_sequence->Write_VC_Links("",ofile);
    }
}

void AaModule::Write_VC_Control_Path(bool opt_flag, ostream& ofile)
{

  ofile << "$CP { // begin control-path " << endl;
  // for each statement, print a CP region.
  if(!opt_flag)
    {
      for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
	{
	  this->_statement_sequence->Get_Statement(idx)->Write_VC_Control_Path(ofile);
	}
    }
  else
    {
      this->Write_VC_Control_Path_Optimized_Base(ofile);
    }

  ofile << "} // end control-path" << endl;
}

void AaModule::Write_VC_Data_Path(ostream& ofile)
{
  ofile << "$DP { // begin data-path " << endl;

  this->Write_VC_Constant_Declarations(ofile);

  if(this->_statement_sequence)
    {
      this->_statement_sequence->Write_VC_Constant_Wire_Declarations(ofile);
      this->_statement_sequence->Write_VC_Wire_Declarations(ofile);
      this->_statement_sequence->Write_VC_Datapath_Instances(ofile);
    }
  ofile << "} // end data-path" << endl;
}


void AaModule::Write_VC_Memory_Spaces(bool opt_flag, ostream& ofile)
{
  for(int idx = 0; idx < _memory_spaces.size(); idx++)
    _memory_spaces[idx]->Write_VC_Model(opt_flag, ofile);
}


void AaModule::Write_VHDL_C_Stub_Prefix(ostream& ofile)
{
 string ret_type;
 bool multiple_outputs = false;
 if(this->Get_Number_Of_Output_Arguments() == 0)
   {
     ret_type = "void";
   }
 else if(this->Get_Number_Of_Output_Arguments() == 1)
   {
     ret_type = this->Get_Output_Argument(0)->Get_Type()->C_Base_Name();
   }
 else
   {
     multiple_outputs = true;
     ret_type = "void";
   }
 
 string comma;
 ofile << ret_type << " " << this->Get_Label() << "(";
 for(int idx = 0; idx < this->Get_Number_Of_Input_Arguments(); idx++)
   {
     ofile << comma;
     
     ofile << this->Get_Input_Argument(idx)->Get_Type()->C_Base_Name()
	   << " " << this->Get_Input_Argument(idx)->Get_Name();
     
     comma = ",";
   }
 
 if(multiple_outputs)
   {
     for(int idx = 0; idx < this->Get_Number_Of_Output_Arguments(); idx++)
       {
	 ofile << comma;
	 
	 ofile << this->Get_Output_Argument(idx)->Get_Type()->C_Base_Name()
	       << "* " << this->Get_Output_Argument(idx)->Get_Name();
	 
	 comma = ",";
       }      
   }
 ofile << ")";
}

void AaModule::Write_VHDL_C_Stub_Header(ostream& ofile)
{
  this->Write_VHDL_C_Stub_Prefix(ofile);
  ofile << ";" << endl;
}

void AaModule::Write_VHDL_C_Stub_Source(ostream& ofile)
{
  this->Write_VHDL_C_Stub_Prefix(ofile);
  ofile << endl << "{" << endl;
  
  ofile << "char buffer[1024];\
  char* ss;\
  sprintf(buffer, \"call " << this->Get_Label() << " \");" << endl;

  ofile << "append_int(buffer," << this->Get_Number_Of_Input_Arguments() << "); ADD_SPACE__(buffer);" << endl;
  for(int idx = 0; idx < this->Get_Number_Of_Input_Arguments(); idx++)
    {
      AaType* t = this->Get_Input_Argument(idx)->Get_Type();
      if(!t->Is_Pointer_Type())
	ofile << "append_" << this->Get_Input_Argument(idx)->Get_Type()->C_Base_Name() 
	      << "(buffer," <<  this->Get_Input_Argument(idx)->Get_Name() << "); ADD_SPACE__(buffer);" << endl;
      else
	{
	  ofile << "append_uint32_t" 
		<< "(buffer,(uint32_t) " 
		<<  this->Get_Input_Argument(idx)->Get_Name() << "); ADD_SPACE__(buffer);" << endl;	  
	}
    }
      
  ofile << "append_int(buffer," << this->Get_Number_Of_Output_Arguments() << "); ADD_SPACE__(buffer);" << endl;
  for(int idx = 0; idx < this->Get_Number_Of_Output_Arguments(); idx++)
    {
      ofile << "append_int(buffer," << this->Get_Output_Argument(idx)->Get_Type()->Size() << "); ADD_SPACE__(buffer);" << endl;
    }
  
  ofile << "send_packet_and_wait_for_response(buffer,strlen(buffer)+1,\"localhost\",9999);" << endl;
  

 if(this->Get_Number_Of_Output_Arguments() == 0)
   {
     ofile << "return;" << endl;
   }
 else if(this->Get_Number_Of_Output_Arguments() == 1)
   {
     AaType* ret_type = this->Get_Output_Argument(0)->Get_Type();
     if(!ret_type->Is_Pointer_Type())
       {
	 ofile << ret_type->C_Base_Name() 
	       << " "
	       << this->Get_Output_Argument(0)->Get_Name() << " = " ;
	 ofile << "get_" << ret_type->C_Base_Name() << "(buffer,&ss);" << endl;
	 ofile << "return(" << this->Get_Output_Argument(0)->Get_Name() << ");" << endl;
       }
     else
       {
	 ofile << ret_type->C_Base_Name() 
	       << " "
	       << this->Get_Output_Argument(0)->Get_Name() << " = (" 
	       << ret_type->C_Base_Name() << ") ";
	 ofile << "get_uint32_t(buffer,&ss);" << endl;
	 ofile << "return(" << this->Get_Output_Argument(0)->Get_Name() << ");" << endl;
       }
   }
 else
   {
     for(int idx = 0; idx < this->Get_Number_Of_Output_Arguments(); idx++)
       {
	 AaType* ret_type = this->Get_Output_Argument(idx)->Get_Type();
	 if(!ret_type->Is_Pointer_Type())
	   {
	     ofile << "*" << this->Get_Output_Argument(idx)->Get_Name() << " = " ;
	     ofile << "get_" << ret_type->C_Base_Name() << "(buffer,&ss);" << endl;
	   }
	 else
	   {
	     ofile << "*" << this->Get_Output_Argument(idx)->Get_Name() << " = (" 
		   << ret_type->C_Base_Name() << ") " ;
	     ofile << "get_uint32_t(buffer,&ss);" << endl;
	   }
       }

     ofile << "return;" << endl;
   }
  ofile << "}" << endl;
}

void AaModule::Set_Statement_Sequence(AaStatementSequence* statement_sequence)
{
	bool err_flag = false;
	// check that all statements in the sequence are atomic
	// ie. either call statements or assignment statements.
	for(int idx = 0, fidx = statement_sequence->Get_Statement_Count(); idx < fidx; idx++)
	{
		AaStatement* s = statement_sequence->Get_Statement(idx);
		if(this->Is_Pipelined())
		{
			if(!(s->Is("AaAssignmentStatement") || s->Is("AaCallStatement") || s->Is("AaNullStatement")))
			{
				AaRoot::Error("pipelined module can contain only call/assignment/null statements.", s);
				err_flag = true;
			}
			else
				s->Set_Pipeline_Parent(this);
		}
	}	

	if(err_flag)
	{
		AaRoot::Error("Due to errors, module will not be pipelined.", this);
		this->Set_Pipeline_Flag(false);
	}

	this->_statement_sequence = statement_sequence;
}


void AaModule::Write_VC_Control_Path_Optimized_Base(ostream& ofile)
{
  if(!this->Is_Pipelined())
    {
      this->AaSeriesBlockStatement::Write_VC_Control_Path_Optimized_Base(ofile);
    }
  else
    {
      ofile << "// pipelined module" << endl;
      string region_name = this->_statement_sequence->Get_VC_Name();

      string exported_outputs;
      string exported_inputs;
      string trans_decls;
      string place_decls;
      string binding_string;

	// TODO: collect group of inputs and outputs that are actually used
	// 	 those that are unused will not need really need input buffers! 
      for(int idx = 0,  fidx = this->Get_Number_Of_Input_Arguments(); 
	  idx < fidx;
	  idx++)
	{
	  AaInterfaceObject* inobj = this->Get_Input_Argument(idx);
	  string tname = inobj->Get_VC_Name() + "_update_enable";
	  exported_outputs += " " + tname + "_out";
	  place_decls += "$P [" + tname + "] \n";
	  trans_decls += "$T [" + tname + "] ";
	  trans_decls += "\n";
	  trans_decls += "$T [" + tname + "_out] \n";
	  trans_decls += tname + " &-> (" + tname + "_out)\n";
	  trans_decls += "$null &-> (" + tname + ")\n";
	  binding_string += "$bind " + tname + " <= " + region_name + ":" + tname + "_out\n"; 
	}

      for(int idx = 0,  fidx = this->Get_Number_Of_Output_Arguments(); 
	  idx < fidx;
	  idx++)
	{
	  AaInterfaceObject* outobj = this->Get_Output_Argument(idx);
	  string tname = outobj->Get_VC_Name() + "_update_enable";
	  exported_inputs += " " + tname + "_in";
	  place_decls += "$P [" + tname + "] \n";
	  trans_decls += "$T [" + tname + "] \n";
	  trans_decls += "$T [" + tname + "_in] \n";
	  trans_decls += "$null &-> (" + tname + ")\n";
	  trans_decls +=  "$null <-& (" + tname + "_in) \n";
	  trans_decls += "$null &-> (" + tname + ")\n";
	  trans_decls += tname + " o<-& (" + tname + "_in  0) \n"; // 0-delay, else wasted cycle.
	  binding_string += "$bind " + tname + " => " + region_name + ":" + tname + "_in\n"; 
	}

      ofile << ":o:[" << region_name << "] {" << endl;
      set<AaRoot*> visited_elements;
      map<string, vector<AaExpression*> > load_store_ordering_map;
      map<string, vector<AaExpression*> >  pipe_map;
      AaRoot* tb = NULL;

      // declare the linking (export) transitions.
      ofile << trans_decls << endl;

      // the main fork-pipeline.
      this->AaBlockStatement::Write_VC_Control_Path_Optimized(true,
							      this->_statement_sequence,
							      visited_elements,
							      load_store_ordering_map,
							      pipe_map,
							      tb,
							      ofile);

      // load-store and pipe dependencies..
      this->Write_VC_Load_Store_Dependencies(true, load_store_ordering_map,ofile);
      this->Write_VC_Pipe_Dependencies(true, pipe_map,ofile);
      
      ofile << "}" << endl;

      ofile << "(" << exported_inputs << ")" << endl;
      ofile << "(" << exported_outputs << ")" << endl;

      ofile << place_decls << endl;
      ofile << binding_string << endl;
    }
}

bool AaModule::Can_Block(bool pipeline_flag)
{
	return(this->AaSeriesBlockStatement::Can_Block(pipeline_flag));
}
