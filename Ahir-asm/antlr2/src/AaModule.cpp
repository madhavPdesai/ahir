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
AaModule::AaModule(string fname): AaBlockStatement(NULL,fname)
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

  // print objects
  this->PrintC_Objects(ofile,"\t");

  // print statement sequence
  if(this->_statement_sequence != NULL)
    {
      this->_statement_sequence->Write_C_Struct(ofile);
    }

  // bit fields at the end whenever possible...
  ofile << "\tunsigned _entry : 1;" << endl;
  ofile << "\tunsigned _exit  : 1;" << endl;
  ofile << "} "
	<< this->Get_Structure_Name() 
	<< ";" 
	<< endl;

  // two function declarations associated with this statement.
  ofile << this->Get_Structure_Name() << "* " 
	<< this->Get_C_Function_Name() 
	<< "(" 
	<< this->Get_Structure_Name()
	<< "*);" 
	<< endl;

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
  ofile << "\t" 
	<< this->Get_Structure_Name() 
	<< "* __top = "
	<< "(" << this->Get_Structure_Name() << "*) calloc(1,sizeof(" 
	<< this->Get_Structure_Name() << "));" << endl;
  ofile << "\t__top->_entry = 1;" <<  endl;
  for(unsigned int i = 0 ; i < this->_input_args.size(); i++)
    {
      ofile << "\t__top->" << this->_input_args[i]->Get_Name() << " = " 
	    << this->_input_args[i]->Get_Name() << ";" << endl;
    }

  ofile << "\twhile(!__top->_exit) " << endl;
  ofile << "\t{ " << endl;
  ofile << "\t\t__top = " << this->Get_C_Function_Name() << "(__top);" << endl;
  ofile << "\t} " << endl;
  for(unsigned int i = 0 ; i < this->_output_args.size(); i++)
    {
      ofile << "\t*" << this->_output_args[i]->Get_Name() 
	    << "= __top->" << this->_output_args[i]->Get_Name() << ";" << endl;
    }

  ofile << "}" << endl;

}
