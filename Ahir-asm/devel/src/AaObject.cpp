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
#include <Aa2Ahir.h>


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
  ofile << " " << this->Get_Name() << " ";
  this->Get_Type()->Print(ofile);
  if(this->_value != NULL)
    {
      ofile << ":= ";
      this->_value->Print(ofile);
    }
  ofile << " ";
}

void AaObject::Write_Ahir_Model()
{
/* This gets out of here.. put it in Aa2Ahir "later"
  AaScope* pmodule = this->Get_Scope()->Get_Nearest_Ancestor_Scope("AaModule");
  string module_name = (pmodule != NULL ? pmodule->Get_Name() : "");
  
  Aa2Ahir::Add_Memory_Location(module_name,
			       this->Get_Name(), 
			       this->Get_Name(),
			       this->Get_Type());

  //\todo: add attribute initial value to memory location..
*/
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

// add DPE's for pipe.
// note: if there are writes to the pipe, add an output port
//       and if there are reads from the pipe, add an input port.
//
void AaPipeObject::Write_Ahir_Model()
{

// Get this out of here.
/*
  AaScope* pmodule = this->Get_Scope()->Get_Nearest_Ancestor_Scope("AaModule");
  string module_name = (pmodule != NULL ? pmodule->Get_Name() : "");
  
  if(this->Get_Number_Of_Target_References() > 0)
    {
      string inst_name = this->Get_Name() + "_output_port";
      Aa2Ahir::Add_DPE(module_name,
		       "output_port",
		       inst_name);
      Aa2Ahir::Add_DPE_Port(module_name,
			    inst_name,
			    "data",
			    "in",
			    this->Get_Type());
    }

  if(this->Get_Number_Of_Source_References() > 0)
    {
      string inst_name = this->Get_Name() + "_output_port";
      Aa2Ahir::Add_DPE(module_name,
		       "input_port",
		       inst_name);
      Aa2Ahir::Add_DPE_Port(module_name,
			    inst_name,
			    "data",
			    "out",
			    this->Get_Type());
    }
*/
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



