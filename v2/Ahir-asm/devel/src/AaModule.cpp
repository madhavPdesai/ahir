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
#include <AaProgram.h>

/***************************************** MODULE   ****************************/

//---------------------------------------------------------------------
// AaModule
//---------------------------------------------------------------------
AaModule::AaModule(string fname): AaSeriesBlockStatement(NULL,fname)
{
  _foreign_flag = false;
  _inline_flag = false;
  _number_of_times_called = 0;
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

void AaModule::Print(ostream& ofile)
{
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

  // print objects
  this->Print_Objects(ofile);

  // print statement sequence
  this->Print_Statement_Sequence(ofile);

  ofile << "}" << endl;
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


void AaModule::Write_Header(ofstream& ofile)
{
  

  ofile << "typedef struct " << this->Get_Structure_Name() << "__ {" << endl;
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      this->_input_args[i]->PrintC(ofile,"\t");
    }
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      this->_output_args[i]->PrintC(ofile,"\t");
    }
  
  if(!this->Get_Foreign_Flag())
    {      
      // print objects
      this->PrintC_Objects(ofile,"\t");
      
      // print statement sequence
      if(this->_statement_sequence != NULL)
	{
	  this->_statement_sequence->Write_C_Struct(ofile);
	}
      
    }      
  
  // bit fields at the end whenever possible...
  ofile << "\tunsigned " << this->Get_Entry_Name() << " : 1;" << endl;
  ofile << "\tunsigned " << this->Get_In_Progress_Name() << " : 1;" << endl;
  ofile << "\tunsigned " << this->Get_Exit_Name() << " : 1;" << endl;
  
  ofile << "} "
	<< this->Get_Structure_Name() 
	<< ";" 
	<< endl;

  if(!this->Get_Foreign_Flag())
    {
      // two function declarations associated with this statement.
      ofile << this->Get_Structure_Name() << "* " 
	    << this->Get_C_Function_Name() 
	    << "(" 
	    << this->Get_Structure_Name()
	    << "*);" 
	    << endl;
    }

  
  ofile << "int " 
	<< this->Get_C_Wrap_Function_Name() 
	<< "(";
  bool first_one = true;
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      if(!first_one)
	ofile << ", ";
      first_one = false;
      ofile << this->_input_args[i]->Get_Type()->CName();
    }
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      if(!first_one)
	ofile << ", ";
      first_one = false;
      ofile << this->_output_args[i]->Get_Type()->CName();
      ofile << "* ";
    }
  ofile << ");" 
	<< endl;
}

void AaModule::Write_Source(ofstream& ofile)
{

  if(!this->Get_Foreign_Flag())
    {
      // print the two functions corresponding to AaModule
      // first the outer function.
      ofile << "int " 
	    << this->Get_C_Wrap_Function_Name() 
	    << "(";
      bool first_one = true;
      for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
	  if(!first_one)
	    ofile << ", ";
	  first_one = false;
	  ofile << this->_input_args[i]->Get_Type()->CName();
	  ofile << " " << this->_input_args[i]->Get_Name();
	}
      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  if(!first_one)
	    ofile << ", ";
	  first_one = false;
	  ofile << this->_output_args[i]->Get_Type()->CName();
	  ofile << "* ";
	  ofile << " " << this->_output_args[i]->Get_Name();
	}
      ofile << ")" << endl;
      ofile << "{" << endl;
      ofile << this->Get_Structure_Name() << "* "
	    << AaProgram::Get_Top_Struct_Variable_Name()
	    << " = "
	    << "(" << this->Get_Structure_Name() << "*) calloc(1,sizeof(" 
	    << this->Get_Structure_Name() << "));" << endl;
      ofile << this->Get_Entry_Name_Ref() << " = 1;" <<  endl;
      for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
	  ofile << "\t" << AaProgram::Get_Top_Struct_Variable_Name()
		<< "->" << this->_input_args[i]->Get_Name() << " = " 
		<< this->_input_args[i]->Get_Name() << ";" << endl;
	}
      
      ofile << "\twhile(!" << this->Get_Exit_Name_Ref() << ") " << endl;
      ofile << "\t{ " << endl;
      ofile << "\t\t" << AaProgram::Get_Top_Struct_Variable_Name() 
	    << " = " << this->Get_C_Function_Name() 
	    << "(" 
	    << AaProgram::Get_Top_Struct_Variable_Name() 
	    << ");" << endl;
      ofile << "\t} " << endl;
      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  ofile << "\t*" << this->_output_args[i]->Get_Name() 
		<< "= "
		<< AaProgram::Get_Top_Struct_Variable_Name() 
		<< "->" << this->_output_args[i]->Get_Name() << ";" << endl;
	}
      
      ofile << "cfree(" << AaProgram::Get_Top_Struct_Variable_Name() << ");" << endl;
      ofile << "return AASUCCESS; " << endl;
      ofile << "}" << endl;
      
      
      // now the inner function.
      // two function declarations associated with this statement.
      ofile << this->Get_Structure_Name() << "* " 
	    << this->Get_C_Function_Name() 
	    << "(" 
	    << this->Get_Structure_Name()
	    << "* "
	    << AaProgram::Get_Top_Struct_Variable_Name()
	    << ")" 
	    << endl;
      ofile << "{" << endl;
      
      ofile << "if (" << this->Get_Entry_Name_Ref() <<") {" << endl;
      ofile << this->Get_Entry_Name_Ref() << " = 0;" << endl;
      ofile << this->Get_In_Progress_Name_Ref() <<" = 1;" << endl;
      
      this->Write_Object_Initializations(ofile);
      this->Write_Entry_Transfer_Code(ofile);
      
      ofile << "}" << endl;

      ofile << "if (" 
	    <<  this->Get_In_Progress_Name_Ref() << ") {"  << endl;
      this->Write_Statement_Invocations(ofile);

      
      ofile << "if (";
      this->Write_Exit_Check_Condition(ofile);
      ofile << ") {" << endl;
      this->Write_Cleanup_Code(ofile);
      
      ofile << this->Get_In_Progress_Name_Ref() <<" = 0;" << endl;
      ofile << this->Get_Exit_Name_Ref() << " = 1;" << endl;
      
      ofile << "} " << endl;
      ofile << "}" << endl;;

      ofile << "return "<< AaProgram::Get_Top_Struct_Variable_Name() << ";" << endl;
      ofile << "}" << endl;
    }

}

void AaModule::Propagate_Constants()
{
  if(this->_statement_sequence)
    this->_statement_sequence->Propagate_Constants();
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
	      inobj->Propagate_Addressed_Object_Representative(fobj);
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
	      inobj->Propagate_Addressed_Object_Representative(fobj);
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

	      outobj->Propagate_Addressed_Object_Representative(fobj);
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
	      outobj->Propagate_Addressed_Object_Representative(fobj);
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
  this->Write_VC_Model(true,ofile);
}

void AaModule::Write_VC_Model(bool opt_flag, ostream& ofile)
{

  //  this->Propagate_Constants();

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

  this->Write_VC_Memory_Spaces(ofile);  
  this->Write_VC_Control_Path(opt_flag, ofile);
  this->Write_VC_Data_Path(ofile);
  this->Write_VC_Links(opt_flag, ofile);

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


void AaModule::Write_VC_Memory_Spaces(ostream& ofile)
{
  for(int idx = 0; idx < _memory_spaces.size(); idx++)
    _memory_spaces[idx]->Write_VC_Model(ofile);
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
     ret_type = this->Get_Output_Argument(0)->Get_Type()->CBaseName();
   }
 else
   {
     multiple_outputs = true;
   }
 
 string comma;
 ofile << ret_type << " " << this->Get_Label() << "(";
 for(int idx = 0; idx < this->Get_Number_Of_Input_Arguments(); idx++)
   {
     ofile << comma;
     
     ofile << this->Get_Input_Argument(idx)->Get_Type()->CBaseName()
	   << " " << this->Get_Input_Argument(idx)->Get_Name();
     
     comma = ",";
   }
 
 if(multiple_outputs)
   {
     for(int idx = 0; idx < this->Get_Number_Of_Output_Arguments(); idx++)
       {
	 ofile << comma;
	 
	 ofile << this->Get_Output_Argument(idx)->Get_Type()->CBaseName()
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
	ofile << "append_" << this->Get_Input_Argument(idx)->Get_Type()->CBaseName() 
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
	 ofile << ret_type->CBaseName() 
	       << " "
	       << this->Get_Output_Argument(0)->Get_Name() << " = " ;
	 ofile << "get_" << ret_type->CBaseName() << "(buffer,&ss);" << endl;
	 ofile << "return(" << this->Get_Output_Argument(0)->Get_Name() << ");" << endl;
       }
     else
       {
	 ofile << ret_type->CBaseName() 
	       << " "
	       << this->Get_Output_Argument(0)->Get_Name() << " = (" 
	       << ret_type->CBaseName() << ") ";
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
	     ofile << "get_" << ret_type->CBaseName() << "(buffer,&ss);" << endl;
	   }
	 else
	   {
	     ofile << "*" << this->Get_Output_Argument(idx)->Get_Name() << " = (" 
		   << ret_type->CBaseName() << ") " ;
	     ofile << "get_uint32_t(buffer,&ss);" << endl;
	   }
       }

     ofile << "return;" << endl;
   }
  ofile << "}" << endl;
}
