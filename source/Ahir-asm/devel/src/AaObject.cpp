using namespace std;
#include <AaIncludes.h>
#include <AaEnums.h>
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
#include <Aa2VC.h>


/*****************************************  OBJECT  ****************************/

//---------------------------------------------------------------------
// AaObject
//---------------------------------------------------------------------
AaObject::AaObject(AaScope* parent_tpr, string oname, AaType* object_type):AaRoot() 
{
  this->_name = oname;
  this->_scope = parent_tpr;
  this->_value = NULL;
  this->_type = object_type;
}
AaObject::~AaObject() {};
string AaObject::Tab()
{
  return((this->Get_Scope() != NULL) ? Tab_(this->Get_Scope()->Get_Depth()+1) : Tab_(0));
}

void AaObject::Print(ostream& ofile)
{
  ofile << " " << this->Get_Name() << " : ";
  this->Get_Type()->Print(ofile);
  if(this->_value != NULL)
    {
      ofile << ":= ";
      this->_value->Print(ofile);
    }
  ofile << " ";
}

void AaObject::Write_VC_Model(ostream& ofile)
{
  ofile << this->Get_VC_Name() << ":";  this->Get_Type()->Write_VC_Model(ofile);
}

void AaObject::Set_Value(AaConstantLiteralReference* v)
{
  _value = v;
  if(v != NULL)
    {
      v->Set_Type(this->_type);
      v->Evaluate();
    }
}
//---------------------------------------------------------------------
// AaInterfaceObject
//---------------------------------------------------------------------
AaInterfaceObject::AaInterfaceObject(AaScope* parent_tpr, 
				     string oname, 
				     AaType* otype, 
				     string mode):AaObject(parent_tpr,oname,otype) 
{
  this->_mode = mode;
}
AaInterfaceObject::~AaInterfaceObject() {};

//---------------------------------------------------------------------
// AaStorageObject
//---------------------------------------------------------------------
AaStorageObject::AaStorageObject(AaScope* parent_tpr,string oname, AaType* otype, 
		   AaConstantLiteralReference* initial_value):AaObject(parent_tpr,oname,otype) 
{
  this->Set_Value(initial_value);
};
AaStorageObject::~AaStorageObject() {};
void AaStorageObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$storage ";
  this->AaObject::Print(ofile);
}

void AaStorageObject::Write_VC_Model(ostream& ofile)
{
  ofile << "// ";
  this->Print(ofile);
  ofile << endl;
  ofile << "// in scope  " << (this->Get_Scope() != NULL ? this->Get_Scope()->Get_Hierarchical_Name() : "top-level") << endl;
  // declare the memoryspace/storage object pair..
  Write_VC_Memory_Space_Declaration("ms_" + this->Get_VC_Name(),
				    this->Get_VC_Name(),
				    this->Get_Type(),
				    ofile);
				    
			       
  // later, a VC compiler can potentially 
  // club memory spaces together.
}


string AaStorageObject::Get_VC_Name()
{
  string ret_string = "storage_" + this->Get_Name() + "_" + Int64ToStr(this->Get_Index());
  return(ret_string);
}


string AaStorageObject::Get_VC_Memory_Space_Name()
{
  string scope_name;
  if(this->Get_Scope())
    {
      scope_name =this->Get_Scope()->Get_Root_Scope()->Get_Label() + "/";
    }
  return(scope_name + "ms_" + this->Get_VC_Name());
}


//---------------------------------------------------------------------
// AaPipeObject
//---------------------------------------------------------------------
AaPipeObject::AaPipeObject(AaScope* parent_tpr, string oname, AaType* otype):AaObject(parent_tpr,oname,otype) {};
AaPipeObject::~AaPipeObject() {};
void AaPipeObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$pipe ";
  this->AaObject::Print(ofile);
}

//
// add DPE's for pipe.
// note: if there are writes to the pipe, add an output port
//       and if there are reads from the pipe, add an input port.
//
void AaPipeObject::Write_VC_Model(ostream& ofile)
{
  ofile << "// ";
  this->Print(ofile);
  ofile << endl;
  ofile << "// in scope  " << (this->Get_Scope() != NULL ? this->Get_Scope()->Get_Hierarchical_Name() : "top-level") << endl;

  Write_VC_Pipe_Declaration(this->Get_VC_Name(),
			    this->_type->Size(),
			    ofile);
}

string AaPipeObject::Get_VC_Name()
{
  string ret_string = "pipe_" + this->Get_Name() + "_" + Int64ToStr(this->Get_Index());
  return(ret_string);
}

//---------------------------------------------------------------------
// AaConstantObject
//---------------------------------------------------------------------
AaConstantObject::AaConstantObject(AaScope* parent_tpr , string oname, AaType* otype, 
		       AaConstantLiteralReference* value):AaObject(parent_tpr, oname,otype)
{
  this->Set_Value(value);
}
AaConstantObject::~AaConstantObject() {};
void AaConstantObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$constant ";
  this->AaObject::Print(ofile);
}


AaValue* AaConstantObject::Get_Expression_Value()
{
  return(this->_value->Get_Expression_Value());
}

void AaConstantObject::Write_VC_Model(ostream& ofile)
{
  Write_VC_Constant_Declaration(this->Get_VC_Name(),
				this->Get_Type(),
				this->Get_Value()->Get_Expression_Value(),
				ofile);
}


void AaConstantObject::Evaluate()
{
  this->_value->Evaluate();
}


string AaConstantObject::Get_VC_Name()
{
  string ret_string = "constant_" + this->Get_Name() + "_" + Int64ToStr(this->Get_Index());
  return(ret_string);
}
