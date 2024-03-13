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
#include <Aa2C.h>
#include <AaProgram.h>
#include <SocketLib.h>

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
  _pipeline_deterministic_flag = false;
  _pipeline_depth = 1;
  _pipeline_buffering = 1;
  _pipeline_full_rate_flag = false;
  
  _writes_to_shared_pipe = false;
  _reads_from_shared_pipe = false;
  _pipelined_bodies_have_been_equalized = false;

  _noopt_flag = false;
  _use_once_flag = false;

  _use_gated_clock = false;
  _number_of_times_called = 0;
  this->Set_Delay(2);

}

  
bool AaModule::Is_Volatizable()
{
	if(_memory_spaces.size() > 0)
		return(false);
	if(_write_pipes.size() > 0)
		return(false);
	if(_read_pipes.size() > 0)
		return(false);
	if(_called_modules.size() > 0)
		return(false);

	if(_global_objects_that_are_read.size() > 0)
		return(false);
	if(_global_objects_that_are_written.size() > 0)
		return(false);
	if(_objects_that_are_read.size() > 0)
		return(false);
	if(_objects_that_are_written.size() > 0)
		return(false);

	// top-level modules cannot be volatile.
	if(_calling_modules.size() == 0)
		return(false);

	if(_macro_flag)
		return(false);
	if(_inline_flag)
		return(false);

	string mname = this->Get_Label();
	bool is_marked = AaProgram::Is_Marked_As_Volatile_Module(mname);
	return(is_marked);
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

	if(this->Get_Foreign_Flag())
	{
		ofile << "$foreign ";
	}
	else
	{
		this->Check_That_All_Out_Args_Are_Driven();

		if(this->Get_Inline_Flag())
			ofile << "$inline ";
		if(this->Get_Macro_Flag())
			ofile << "$macro ";
		if(this->Get_Pipeline_Flag())
		{
			ofile << "$pipeline $depth " << this->Get_Pipeline_Depth() << " ";
			ofile << "$buffering " << this->Get_Pipeline_Buffering() << " ";
			if(this->Get_Pipeline_Full_Rate_Flag())
				ofile << "$fullrate ";
			if(this->Get_Pipeline_Deterministic_Flag())
				ofile << "$deterministic ";
		}
		if(this->Get_Operator_Flag())
			ofile << "$operator ";
		else if(this->Get_Volatile_Flag())
			ofile << "$volatile ";
		if(this->Get_Opaque_Flag())
			ofile << "$opaque ";

		if(this->Get_Noopt_Flag())
			ofile << "$noopt ";
		if(this->Get_Use_Once_Flag())
			ofile << "$useonce ";
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
	if (!this->Get_Foreign_Flag())
	{
		ofile << "$is" << endl;
		ofile << "{" << endl;
		this->Print_Body(ofile);
		ofile << "}" << endl;
	}
}

void AaModule::Print_Body(ostream& ofile)
{
	if(this->_pipeline_flag && AaProgram::_balance_loop_pipeline_bodies && !this->Get_Has_Been_Equalized())
	{
		if(!this->Get_Noopt_Flag())
		{
			AaRoot::Info(" started path balancing for module " + this->Get_Label());
			this->Equalize_Paths_For_Pipelining();
		}
		this->Set_Has_Been_Equalized(true);
	}

	// print objects
	this->Print_Objects(ofile);

	// print statement sequence
	this->Print_Statement_Sequence(ofile);

	this->Print_Attributes(ofile);
}

void AaModule::Print_Attributes(ostream& ofile)
{
	bool delay_found = false;
	for(map<string,string>::iterator iter = _attribute_map.begin(), fiter =_attribute_map.end();
			iter != fiter;
			iter++)
	{
		ofile << "$attribute " << (*iter).first << " " << (*iter).second << endl;
		if((*iter).first == "delay")
			delay_found = true;
	}

	// print if calculated and not already attributed.
	if(!delay_found && this->_pipeline_flag && AaProgram::_balance_loop_pipeline_bodies)
		ofile << "$attribute delay " << this->Get_Delay() << endl;
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

void AaModule::Map_Targets()
{
	this->AaBlockStatement::Map_Targets();
}

void AaModule::Map_Source_References()
{
	this->AaBlockStatement::Map_Source_References();
}

bool AaModule::Can_Have_Native_C_Interface()
{
	//
	// if all argument types are legal, then
	// declare the outer wrap function.
	//
	bool all_types_native = true;
	for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
		if(!(this->_input_args[i]->Get_Type()->Is_A_Native_C_Type()))
		{
			all_types_native = false;
			break;
		}
	}
	if(all_types_native)
	{
		for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
		{
			if(!(this->_output_args[i]->Get_Type()->Is_A_Native_C_Type()))
			{
				all_types_native = false;
				break;
			}
		}
	}
	return(all_types_native);
}

// name of the function..
string AaModule::Get_C_Name()
{
    string ret_val;
    if (this->Get_Foreign_Flag())
	ret_val = this->Get_Label();
    else
	ret_val =  AaProgram::_c_vhdl_module_prefix + this->Get_Label();
    return(ret_val);
}


void AaModule::Write_C_Header(ofstream& ofile)
{
 
  bool all_types_native = this->Can_Have_Native_C_Interface();
  if(this->_operator_flag && (_number_of_times_called > 1))
  {
	if(this->Get_Has_Declared_Storage_Object())
	{
		AaRoot::Error("Operator module " + this->Get_Label() + " with storage object called multiple times... may get unexpected results in Aa2C code.",
					NULL);
	}
  }

  if(all_types_native)
    {
      ofile << "void " 
	    << this->Get_C_Outer_Wrap_Function_Name() 
	    << "(";
      bool first_one = true;
      for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
	  if(!first_one)
	    ofile << ", ";
	  first_one = false;
      
	  //
	  // all arguments are passed as pointers..
	  //
	  ofile << this->_input_args[i]->Get_Type()->Native_C_Name();
	}
      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  if(!first_one)
	    ofile << ", ";
	  first_one = false;
	  ofile << this->_output_args[i]->Get_Type()->Native_C_Name();
	  ofile << "* ";
	}
      ofile << ");" << endl;
    }


  //
  // then declare the inner wrap function.
  //
  ofile << "void " 
	<< this->Get_C_Inner_Wrap_Function_Name() 
	<< "(";
  bool first_one = true;
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      if(!first_one)
	ofile << ", ";
      first_one = false;
      
      //
      // all arguments are passed as pointers..
      //
      ofile << this->_input_args[i]->Get_Type()->C_Name() << "*";
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

void AaModule::Write_C_Source(ofstream& srcfile, ofstream& headerfile)
{
  if(this->Get_Foreign_Flag())
    return;

  bool static_flag = this->Static_Flag_In_C();

  // inner wrap function.
  srcfile << "void " 
	<< this->Get_C_Inner_Wrap_Function_Name() 
	<< "(";
  bool first_one = true;
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      if(!first_one)
	srcfile << ", ";
      first_one = false;
      srcfile << this->_input_args[i]->Get_Type()->C_Name();
      srcfile << "* __p" << this->_input_args[i]->Get_Name();
    }
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      if(!first_one)
	srcfile << ", ";
      first_one = false;
      srcfile << this->_output_args[i]->Get_Type()->C_Name();
      srcfile << "* ";
      srcfile << " __p" << this->_output_args[i]->Get_Name();
    }
  srcfile << ")" << endl;
  srcfile << "{" << endl;
  //
  // pointer-interface <-> declare i/o objects
  // print input side conversions.
  //
  srcfile << "MUTEX_DECL(" << this->Get_C_Mutex_Name()  << ");" << endl; 
  srcfile << "MUTEX_LOCK(" << this->Get_C_Mutex_Name()  << ");" << endl; 
  headerfile << "\n#define " << this->Get_C_Inner_Input_Args_Prepare_Macro() << " ";
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
	string o_name =  this->_input_args[i]->Get_C_Name();
	string n_name = "__p" + o_name;

	Print_C_Declaration(o_name, static_flag,  this->_input_args[i]->Get_Type(), headerfile);
	Print_C_Assignment(o_name, "(*" + n_name + ")", this->_input_args[i]->Get_Type(), headerfile);
    }
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
	string o_name =  this->_output_args[i]->Get_C_Name();
	Print_C_Declaration(o_name, static_flag,  this->_output_args[i]->Get_Type(), headerfile);
    }

  this->Write_C_Object_Declarations_And_Initializations(headerfile);
  this->_statement_sequence->PrintC_Implicit_Declarations(headerfile);
  srcfile <<  this->Get_C_Inner_Input_Args_Prepare_Macro() << "; " << endl;

  this->_statement_sequence->PrintC(srcfile, headerfile);

  // TODO pointer interface <-> output side conversions
  headerfile << "\n#define " << this->Get_C_Inner_Output_Args_Prepare_Macro() << " ";
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
	string o_name =  this->_output_args[i]->Get_C_Name();
	string n_name = "__p" + o_name;
	Print_C_Assignment("(*" + n_name + ")", o_name,  this->_output_args[i]->Get_Type(), headerfile);
    }
  headerfile << ";" <<endl;
  srcfile << this->Get_C_Inner_Output_Args_Prepare_Macro() << "; " << endl;

  srcfile << "MUTEX_UNLOCK(" << this->Get_C_Mutex_Name()  << ");" << endl; 
  srcfile << "}" << endl;

  // outer wrap function if all argument types are "native"
  bool all_types_native = this->Can_Have_Native_C_Interface();
  if(all_types_native)
    {
      srcfile << "void " 
	    << this->Get_C_Outer_Wrap_Function_Name() 
	    << "(";
      bool first_one = true;
      for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
	  if(!first_one)
	    srcfile << ", ";
	  first_one = false;
      
	  //
	  // all arguments are passed as pointers..
	  //
	  srcfile << this->_input_args[i]->Get_Type()->Native_C_Name();
	  srcfile << " " << this->_input_args[i]->Get_C_Name() << " ";
	}
      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  if(!first_one)
	    srcfile << ", ";
	  first_one = false;
	  srcfile << this->_output_args[i]->Get_Type()->Native_C_Name();
	  srcfile << "* ";
	  srcfile << " " << this->_output_args[i]->Get_C_Name() << " ";
	}
      srcfile << ")" << endl;

      srcfile << "{" << endl;
      headerfile << "\n#define " << this->Get_C_Outer_Arg_Decl_Macro_Name() << " ";
	// set up and call inner function.
      for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
	  AaType* t = this->_input_args[i]->Get_Type();
	  string o_name =  this->_input_args[i]->Get_C_Name();
	  string n_name = "__" + o_name;

	  if(t->Is_Integer_Type())
	    {
	      headerfile << "__declare_static_bit_vector(" << n_name << ", " << t->Size() << ");\\" << endl;
	      headerfile << "bit_vector_assign_uint64(0, &" << n_name << ", " << o_name << ");\\" << endl;
	    }
	  else
	    {
	      headerfile << t->Native_C_Name() << " " << n_name << " = " << o_name << ";\\" << endl;
	    }
	}


      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  AaType* t = this->_output_args[i]->Get_Type();
	  string o_name =  this->_output_args[i]->Get_C_Name();
	  string n_name = "__" + o_name;

	  if(t->Is_Integer_Type())
	    {
	      headerfile << "__declare_static_bit_vector(" << n_name << ", " << t->Size() << ");\\" << endl;
	    }
	  else
	    {
	      srcfile << t->Native_C_Name() << " " << n_name << ";\\" << endl;
	    }
	}
	headerfile << ";" << endl;
	srcfile <<  this->Get_C_Outer_Arg_Decl_Macro_Name() << ";" << endl;


      // call inner function.
      srcfile << this->Get_C_Inner_Wrap_Function_Name() 
	    << "(";
      first_one = true;;
      for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
	{
	  AaType* t = this->_input_args[i]->Get_Type();
	  string o_name =  this->_input_args[i]->Get_C_Name();
	  string n_name = "__" + o_name;
	  if(!first_one)
	    {
	      srcfile << ", ";
	    }
	  srcfile << " &" << n_name;
	  first_one = false;
	}
      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  AaType* t = this->_output_args[i]->Get_Type();
	  string o_name =  this->_output_args[i]->Get_C_Name();
	  string n_name = "__" + o_name;
	  if(!first_one)
	    {
	      srcfile << ", ";
	    }
	  srcfile << " &" << n_name;
	  first_one = false;
	}
      
      srcfile << ");" << endl;

      // get the outputs in order.
      headerfile << "\n#define " << this->Get_C_Outer_Output_Xfer_To_Outer_Macro_Name() << " ";
      for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
	{
	  AaType* t = this->_output_args[i]->Get_Type();
	  string o_name =  this->_output_args[i]->Get_C_Name();
	  string n_name = "__" + o_name;

	  if(t->Is_Integer_Type())
	    {
	      headerfile << " *" << o_name << " =  bit_vector_to_uint64(" 
		    << (!t->Is_Uinteger_Type() ? 1 : 0)
		    << ", &" << n_name << ");\\" << endl;
	    }
	  else
	    {
	      headerfile << " *" << o_name << " = " << n_name << ";\\" << endl;
	    }
	}
	headerfile << ";" <<endl;
	srcfile << this->Get_C_Outer_Output_Xfer_To_Outer_Macro_Name() << ";" << endl;

      srcfile << "}" << endl;
      srcfile << endl << endl;
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
  this->Check_That_All_Out_Args_Are_Driven();

  // gated clock... pass it to VC
  if(this->Get_Use_Gated_Clock())
  {
	ofile << "$use_gated_clock " << this->Get_Gated_Clock_Name() << endl;
  }
	
  //  this->Propagate_Constants();
  if(this->_foreign_flag)
    ofile << "$foreign ";

  if(this->Get_Pipeline_Flag())
  {
    ofile << "$pipeline $depth " << this->Get_Pipeline_Depth() << " ";
    ofile << "$buffering " << this->Get_Pipeline_Buffering() << " ";
    if(this->Get_Pipeline_Full_Rate_Flag())
	ofile << "$fullrate ";
    if(this->Get_Pipeline_Deterministic_Flag())
	ofile << "$deterministic ";
  }

  if(this->Get_Operator_Flag())
	ofile << " $operator ";
  else if(this->Get_Volatile_Flag())
	ofile << " $volatile ";
  else if(this->Get_Use_Once_Flag())
	ofile << " $useonce ";

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

  this->Write_VC_Attributes(ofile);

  ofile << "}" << endl;
}

void AaModule::Write_VC_Links(bool opt_flag, ostream& ofile)
{
  if(this->Get_Volatile_Flag())
  {
	ofile << "// Volatile module.. no links." << endl;
	return;
  }

  if(this->_statement_sequence)
    {
      if(opt_flag)
	{
		if(this->Is_Pipelined())
			this->AaBlockStatement::Write_VC_Links_Optimized("",this->_statement_sequence, ofile); 
		else
			this->AaSeriesBlockStatement::Write_VC_Links_Optimized_Base("", ofile); 
	}
      else
	this->_statement_sequence->Write_VC_Links("",ofile);
    }
}


void AaModule::Write_VC_Control_Path(bool opt_flag, ostream& ofile)
{

  this->Check_Statements(); // check for errors.
  ofile << "$CP { // begin control-path " << endl;
  if(this->Get_Volatile_Flag()) 
	ofile << "// Volatile! CP is left blank " << endl;
  else
  {
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
	for(set<AaMemorySpace*>::iterator witer = _memory_spaces_written_into.begin(),
				fwiter = _memory_spaces_written_into.end();  witer != fwiter; witer++)
	{
		ofile << "// memory-space " << (*witer)->_mem_space_index << " is written into." << endl;
	}

	for(set<AaMemorySpace*>::iterator riter = _memory_spaces_read_from.begin(),
				friter = _memory_spaces_read_from.end();  riter != friter; riter++)
	{
		ofile << "// memory-space " << (*riter)->_mem_space_index << " is read from." << endl;
	}

	if(_memory_spaces.size() > 0)
	{
		ofile << "// memory spaces local to this module." << endl;

		for(int idx = 0; idx < _memory_spaces.size(); idx++)
        	{
			_memory_spaces[idx]->Write_VC_Model(opt_flag, ofile);
		}
	}
	else
		ofile << "// there are no memory spaces local to this module." << endl;
}


void AaModule::Write_VC_Attributes(ostream& ofile)
{
  for(map<string,string>::iterator iter = _attribute_map.begin(), fiter =_attribute_map.end();
      iter != fiter;
      iter++)
    {
      ofile << "$attribute " << (*iter).first << " => \"" << (*iter).second << "\"" << endl;
    }
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
		ret_type = this->Get_Output_Argument(0)->Get_Type()->Native_C_Name();
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

		ofile << this->Get_Input_Argument(idx)->Get_Type()->Native_C_Name()
			<< " " << this->Get_Input_Argument(idx)->Get_Name();

		comma = ",";
	}

	if(multiple_outputs)
	{
		for(int idx = 0; idx < this->Get_Number_Of_Output_Arguments(); idx++)
		{
			ofile << comma;

			ofile << this->Get_Output_Argument(idx)->Get_Type()->Native_C_Name()
				<< "* " << this->Get_Output_Argument(idx)->Get_Name();

			comma = ",";
		}      
	}
	ofile << ")";
}

void AaModule::Write_VHDL_C_Stub_Header(ostream& ofile)
{

	if (!this->Can_Have_Native_C_Interface())
		return;
	this->Write_VHDL_C_Stub_Prefix(ofile);
	ofile << ";" << endl;
}

void AaModule::Write_VHDL_C_Stub_Source(ostream& ofile)
{
	if (!this->Can_Have_Native_C_Interface())
		return;
  this->Write_VHDL_C_Stub_Prefix(ofile);
  ofile << endl << "{" << endl;
  
  ofile << "char buffer[4096];\
  char* ss;\
  sprintf(buffer, \"call " << this->Get_Label() << " \");" << endl;

  ofile << "append_int(buffer," << this->Get_Number_Of_Input_Arguments() << "); ADD_SPACE__(buffer);" << endl;
  for(int idx = 0; idx < this->Get_Number_Of_Input_Arguments(); idx++)
    {
      AaType* t = this->Get_Input_Argument(idx)->Get_Type();
      if(!t->Is_Pointer_Type())
	ofile << "append_" << this->Get_Input_Argument(idx)->Get_Type()->Native_C_Name() 
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
  
  ofile << "send_packet_and_wait_for_response(buffer,strlen(buffer)+1,\"localhost\"," << DEFAULT_SERVER_PORT << ");" << endl;
  

 if(this->Get_Number_Of_Output_Arguments() == 0)
   {
     ofile << "return;" << endl;
   }
 else if(this->Get_Number_Of_Output_Arguments() == 1)
   {
     AaType* ret_type = this->Get_Output_Argument(0)->Get_Type();
     if(!ret_type->Is_Pointer_Type())
       {
	 ofile << ret_type->Native_C_Name() 
	       << " "
	       << this->Get_Output_Argument(0)->Get_Name() << " = " ;
	 ofile << "get_" << ret_type->Native_C_Name() << "(buffer,&ss);" << endl;
	 ofile << "return(" << this->Get_Output_Argument(0)->Get_Name() << ");" << endl;
       }
     else
       {
	 ofile << ret_type->Native_C_Name() 
	       << " "
	       << this->Get_Output_Argument(0)->Get_Name() << " = (" 
	       << ret_type->Native_C_Name() << ") ";
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
	     ofile << "get_" << ret_type->Native_C_Name() << "(" << ((idx == 0) ? "buffer" : "NULL") <<
				",&ss);" << endl;
	   }
	 else
	   {
	     ofile << "*" << this->Get_Output_Argument(idx)->Get_Name() << " = (" 
		   << ret_type->Native_C_Name() << ") " ;
	     ofile << "get_uint32_t(" << ((idx == 0) ? "buffer" : "NULL") << ",&ss);" << endl;
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
			if(!(s->Is("AaAssignmentStatement") || s->Is("AaCallStatement") || s->Is_Null_Like_Statement()))

			{
				AaRoot::Error("pipelined module can contain only call/assignment/null statements.", s);
				err_flag = true;
			}
			else
				s->Set_Pipeline_Parent(this);
		}

		if(this->Get_Operator_Flag() || this->Get_Volatile_Flag() || this->Get_Macro_Flag() || this->Get_Inline_Flag())
		{
			if(!(s->Is("AaAssignmentStatement") || s->Is_Null_Like_Statement()))
			{
				if(!s->Is("AaCallStatement") && (this->Get_Volatile_Flag() || this->Get_Macro_Flag() || this->Get_Inline_Flag()))
				{
					AaRoot::Error("volatile/macro/inline module can contain only assignment/null statements.", s);
					err_flag = true;
				}
				else if(s->Is("AaCallStatement"))
				{
					AaRoot::Warning("volatile/operator/macro/inline module " + this->Get_Label() + "  has call statement.", s);
				}
			}
		}
	}	

	if(err_flag)
	{
		AaRoot::Error("Due to errors, module will not be pipelined.", this);
		this->Set_Pipeline_Flag(false);
	}

	this->_statement_sequence = statement_sequence;
}

void AaModule::Check_Statements()
{
	if(_statement_sequence == NULL)
		return;

	bool err_flag = false;
	for(int idx = 0, fidx = this->_statement_sequence->Get_Statement_Count(); idx < fidx; idx++)
	{
		AaStatement* s = this->_statement_sequence->Get_Statement(idx);
		if(this->Is_Pipelined())
		{
			if(!(s->Is("AaAssignmentStatement") || s->Is("AaCallStatement") 
					|| s->Is_Null_Like_Statement())){
				AaRoot::Error("pipelined module can contain only call/assignment/null statements.", s);
				err_flag = true;
			}
		}

		if(this->Get_Operator_Flag() || this->Get_Volatile_Flag())
		{
			if(!(s->Is("AaAssignmentStatement") ||  s->Is_Null_Like_Statement()))
			{
				if(!s->Is("AaCallStatement") && this->Get_Volatile_Flag())
				{
					AaRoot::Error("volatile module can contain only assignment/null statements.", s);
					err_flag = true;
				}
				else if(s->Is("AaCallStatement"))
				{
					AaCallStatement* as = (AaCallStatement*) s;
					if(this->Get_Volatile_Flag() && !as->Get_Called_Module()->Get_Volatile_Flag())
					{
						AaRoot::Error("volatile module " + this->Get_Label() + "  has non-volatile call statement.", s);
						err_flag = true;
					}
					else if(this->Get_Operator_Flag() && 
						!(as->Get_Called_Module()->Get_Volatile_Flag()  ||
							as->Get_Called_Module()->Get_Foreign_Flag() || 
							as->Get_Called_Module()->Get_Operator_Flag()))
					{
						AaRoot::Error("operator module  " + this->Get_Label() + " can call only volatile/operator/foreign modules.", s);
						err_flag = true;
					}
				}
			}
		}
	}	

	if(err_flag)
	{
		AaRoot::Error("Due to errors, module will not be pipelined.", this);
		this->Set_Pipeline_Flag(false);
	}
}

void AaModule::Check_That_All_Out_Args_Are_Driven()
{
	if(!this->Get_Foreign_Flag())
	{
		for(int I = 0, fI = this->Get_Number_Of_Output_Arguments(); I < fI; I++)
		{
			AaInterfaceObject* oobj = this->Get_Output_Argument(I);
			if(oobj->Get_Unique_Driver_Statement() == NULL)
			{
				AaRoot::Error("output interface " + oobj->Get_Name() + " of module " + 
							this->Get_Label() + " not driven.", NULL);
			}
		}
	}
}

void AaModule::Write_VC_Control_Path_Optimized_Base(ostream& ofile)
{
	this->Check_Statements(); // check for errors.

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

		set<AaRoot*> visited_elements;

		// TODO: collect group of inputs and outputs that are actually used
		// 	 those that are unused will not need really need input buffers! 
		for(int idx = 0,  fidx = this->Get_Number_Of_Input_Arguments(); 
				idx < fidx;
				idx++)
		{
			AaInterfaceObject* inobj = this->Get_Input_Argument(idx);

			//
			// add inobj to visited elements.
			// (only for pipelined modules)
			//
			visited_elements.insert(inobj);

			string tname = inobj->Get_VC_Name() + "_update_enable";

			exported_outputs += " " + tname + "_out";
			place_decls += "$P [" + tname + "] \n";
			trans_decls += "$T [" + tname + "] ";
			trans_decls += "\n";

			trans_decls += "$scc_arc " + tname + " => $entry\n";
			trans_decls += "\n";
			trans_decls += "$T [" + tname + "_out] \n";
			trans_decls += tname + " &-> (" + tname + "_out)\n";
			trans_decls += "$null &-> (" + tname + ")\n";
			binding_string += "$bind " + tname + " <= " + region_name + " : " + tname + "_out\n"; 
			if(this->Get_Operator_Flag())
			{
				string tname_u = inobj->Get_VC_Name() + "_update_enable_unmarked";
				exported_outputs += " " + tname_u + "_out";
				place_decls += "$P [" + tname_u + "] \n";
				trans_decls += "$T [" + tname_u + "] ";
				trans_decls += "\n";
				trans_decls += "$T [" + tname_u  + "_out] \n";
				trans_decls += tname_u + " &-> (" + tname_u + "_out)\n";
				trans_decls += "$null &-> (" + tname_u + ")\n";
				binding_string += "$bind " + tname_u + " <= " + region_name + " : " + tname_u + "_out\n"; 
			}

		}

		for(int idx = 0,  fidx = this->Get_Number_Of_Output_Arguments(); 
				idx < fidx;
				idx++)
		{
			AaInterfaceObject* outobj = this->Get_Output_Argument(idx);
			bool is_constant = (outobj->Get_Expr_Value() != NULL);
			if(!is_constant)
			{
				string tname = outobj->Get_VC_Name() + "_update_enable";
			
				exported_inputs += " " + tname + "_in";
				place_decls += "$P [" + tname + "] \n";
				trans_decls += "$T [" + tname + "] \n";
				trans_decls += "$T [" + tname + "_in] \n";
				trans_decls += "$null &-> (" + tname + ")\n";
				trans_decls +=  "$null <-& (" + tname + "_in) \n";
				trans_decls += "$null &-> (" + tname + ")\n";
				trans_decls +=  "$scc_arc $exit => " + tname + "\n";
				// note simplification!
				trans_decls += tname + " <-& (" + tname + "_in) \n"; // 0-delay, else wasted cycle.
				binding_string += "$bind " + tname + " => " + region_name + " : " + tname + "_in\n"; 
			}
		}

		ofile << ":|:[" << region_name << "] {" << endl;
		map<AaMemorySpace*, vector<AaRoot*> > load_store_ordering_map;
		map<AaPipeObject*, vector<AaRoot*> >  pipe_map;
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
      
string AaModule::Get_C_Outer_Arg_Decl_Macro_Name() 
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Label() + 
			"_outer_arg_decl_macro__");
}
string AaModule::Get_C_Outer_Output_Xfer_To_Outer_Macro_Name() 
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Label() + 
			"_outer_op_xfer_macro__");
}
  
string AaModule::Get_C_Inner_Input_Args_Prepare_Macro()
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Label() + 
			"_inner_inarg_prep_macro__");
}

string AaModule::Get_C_Inner_Output_Args_Prepare_Macro() 
{
	return(AaProgram::_c_vhdl_module_prefix + "_" + this->Get_Label() + 
			"_inner_outarg_prep_macro__");
}

   
void AaModule::Initialize_Visited_Elements(set<AaRoot*>& visited_elements)
{
	if(this->Is_Pipelined())
	{
		for(int idx = 0,  fidx = this->Get_Number_Of_Input_Arguments(); 
				idx < fidx;
				idx++)
		{
			AaInterfaceObject* inobj = this->Get_Input_Argument(idx);

			//
			// add inobj to visited elements.
			// (only for pipelined modules)
			//
			visited_elements.insert(inobj);
		}
	}
}

bool AaModule::Writes_To_Memory_Space(AaMemorySpace* ms)
{
	bool ret_val = false;
	if(_memory_spaces_written_into.find(ms) != _memory_spaces_written_into.end())
		ret_val = true;
	else
		// called modules may write memory space...
	{
		for(set<AaModule*>::iterator iter = _called_modules.begin(), 
				fiter = _called_modules.end(); iter != fiter; iter++)
		{
			if((*iter)->Writes_To_Memory_Space(ms))
			{
				ret_val = true;
			}
			if(ret_val)
				break;
		}
	}
	return(ret_val);
}

bool AaModule::Reads_From_Memory_Space(AaMemorySpace* ms)
{
	bool ret_val = false;
	if(_memory_spaces_read_from.find(ms) != _memory_spaces_read_from.end())
		ret_val = true;
	else
		// called modules may read from memory space...
	{
		for(set<AaModule*>::iterator iter = _called_modules.begin(), 
				fiter = _called_modules.end(); iter != fiter; iter++)
		{
			if((*iter)->Reads_From_Memory_Space(ms))
			{
				ret_val = true;
			}
			if(ret_val)
				break;
		}
	}
	return(ret_val);
}
bool AaModule::Reads_From_Pipe(AaPipeObject* obj)
{
	bool ret_val = (_read_pipes.find(obj) != _read_pipes.end());
	if(!ret_val)
	{
		for(set<AaModule*>::iterator iter = this->_called_modules.begin(),
				fiter = this->_called_modules.end(); iter != fiter; iter++)
		{
			AaModule* cm = *iter;
			if((cm != this) && cm->Reads_From_Pipe(obj))
			{
				ret_val = true;
			}
			if(ret_val)
				break;
		}
	}
	return(ret_val);
}
bool AaModule::Writes_To_Pipe(AaPipeObject* obj)
{
	bool ret_val = (_write_pipes.find(obj) != _write_pipes.end());
	if(!ret_val)
	{
		for(set<AaModule*>::iterator iter = this->_called_modules.begin(),
				fiter = this->_called_modules.end(); iter != fiter; iter++)
		{
			AaModule* cm = *iter;
			if((cm != this) && cm->Writes_To_Pipe(obj))
			{
				ret_val = true;
			}
			if(ret_val)
				break;
		}
	}
	return(ret_val);
}
void AaModule::Get_Accessed_Pipes(set<AaPipeObject*>& p_set)
{
	for(set<AaPipeObject*>::iterator iter = _write_pipes.begin(),
			fiter = _write_pipes.end(); iter != fiter; iter++)
	{
		p_set.insert(*iter);
	}
	for(set<AaPipeObject*>::iterator riter = _read_pipes.begin(),
			rfiter = _read_pipes.end(); riter != rfiter; riter++)
	{
		p_set.insert(*riter);
	}

	//
	// called modules may access pipes as well!
	//
	for(set<AaModule*>::iterator titer = _called_modules.begin(),
			tfiter = _called_modules.end(); titer != tfiter; titer++)
	{
		AaModule* cm = *titer;
		if(cm != this)
			cm->Get_Accessed_Pipes(p_set);
	}
}

void AaModule::Get_Accessed_Memory_Spaces(set<AaMemorySpace*>& ms_set)
{
	for(set<AaMemorySpace*>::iterator iter = _memory_spaces_written_into.begin(),
			fiter = _memory_spaces_written_into.end(); iter != fiter; iter++)
	{
		ms_set.insert(*iter);
	}
	for(set<AaMemorySpace*>::iterator riter = _memory_spaces_read_from.begin(),
			rfiter = _memory_spaces_read_from.end(); riter != rfiter; riter++)
	{
		ms_set.insert(*riter);
	}
	for(set<AaModule*>::iterator titer = _called_modules.begin(),
			tfiter = _called_modules.end(); titer != tfiter; titer++)
	{
		AaModule* cm = *titer;
		if(cm != this)
			cm->Get_Accessed_Memory_Spaces(ms_set);
	}
}

void AaModule::Update_Pipe_Map(map<AaPipeObject*,vector<AaRoot*> >& pipe_map, AaRoot* r)
{
	set<AaPipeObject*>  accessed_pipes;
	this->Get_Accessed_Pipes(accessed_pipes);
	for(set<AaPipeObject*>::iterator iter = accessed_pipes.begin(), 
		fiter = accessed_pipes.end(); iter != fiter; iter++)
	{
		pipe_map[*iter].push_back(r);
	}
}

void AaModule::Update_Memory_Space_Map(map<AaMemorySpace*,vector<AaRoot*> >& ls_map, AaRoot* r)
{
	set<AaMemorySpace*> accessed_memory_spaces;
	this->Get_Accessed_Memory_Spaces(accessed_memory_spaces);
	for(set<AaMemorySpace*>::iterator mter = accessed_memory_spaces.begin(), 
			fmter = accessed_memory_spaces.end(); mter != fmter; mter++)
	{
		ls_map[*mter].push_back(r);
	}

}
