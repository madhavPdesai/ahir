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



void AaModule::Write_VC_Model(int default_space_pointer_width,
		    int default_space_word_size,
		    ostream& ofile)
{
  ofile << "$module [" << this->Get_Label() << "] {" << endl;
  if(_input_args.size() > 0)
    {
      ofile << "$in ";
      for(int idx = 0; idx < _input_args.size(); idx++)
	{
	  _input_args[idx]->Write_VC_Model(ofile);
	}
    }
  if(_output_args.size() > 0)
    {
      ofile << "$out ";
      for(int idx = 0; idx < _output_args.size(); idx++)
	{
	  _output_args[idx]->Write_VC_Model(ofile);
	}
    }
  ofile << endl;
  
  this->Write_VC_Control_Path(ofile);
  this->Write_VC_Data_Path(ofile);
  this->Write_VC_Memory_Spaces(ofile);
  ofile << "}";
}


void AaModule::Write_VC_Control_Path(ostream& ofile)
{

  ofile << "$CP { // begin control-path " << endl;

  // for each statement, print a CP region.
  for(int idx = 0; idx < this->_statement_sequence->Get_Statement_Count(); idx++)
    {
      this->_statement_sequence->Get_Statement(idx)->Write_VC_Control_Path(ofile);
    }
  
  // for simple statements
  //    for the rhs expression, create
  //    a fork region.  In this region,
  //    each expression node will correspond
  //    to a series region, and at each
  //    expression node, two series regions
  //    will join.  The series region for
  //    an expression node will consist
  //    of req/ack transitions.
  

  // for series/parallel/fork regions, 
  // things are easy.


  // for branch regions, the if and switch
  // statements create small complications.
  // For each if node, the test-expression will
  // need to be evaluated and will need to be 
  // followed by a branch.
  // Each select node will correspond to
  // a fork-region, in which each leg will be
  // a test-expression computation followed by
  // a branch region in which the result of
  // the test is use.
  ofile << "} // end control-path" << endl;
}

void AaModule::Write_VC_Data_Path(ostream& ofile)
{
}

void AaModule::Write_VC_Memory_Spaces(ostream& ofile)
{
}
