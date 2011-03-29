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
  this->_addressed_object_representative = NULL;
}
AaObject::~AaObject() {};

bool AaObject::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
  bool new_flag = false;
  if(obj != NULL)
    {
      if(this->_addressed_object_representative == NULL)
	{
	  this->_addressed_object_representative = obj;
	  new_flag = true;
	}
      else
	{
	  if(obj != this->_addressed_object_representative)
	    {
	      AaProgram::Add_Storage_Dependency(obj,this->_addressed_object_representative);
	    }
	}
    }
  return(new_flag);
}

// basically a DFS: which visits each expression reachable from
// this object.  Whenever another object a is encountered
// and the addressed object ref of a is modified, a is added
// to a re-coalesce set.
void AaObject::Coalesce_Storage()
{
  // ask the expressions that depend on this
  // to propagate storage object references..
  for(set<AaRoot*>::iterator iter = _source_references.begin();
      iter != _source_references.end();
      iter++)
    {
      if((*iter)->Is_Expression())
	((AaExpression*)(*iter))->
	  Propagate_Addressed_Object_Representative(this->Get_Addressed_Object_Representative());
    }
}

void AaObject::Propagate_Addressed_Object_Representative(AaStorageObject* obj)
{
  if(this->Set_Addressed_Object_Representative(obj))
    {
      AaProgram::Add_To_Recoalesce_Set(this);
    }
}

string AaObject::Tab()
{
  return((this->Get_Scope() != NULL) ? Tab_(this->Get_Scope()->Get_Depth()+1) : Tab_(0));
}

string AaObject::Get_Hierarchical_Name()
{
  if(this->_scope)
    {
      return(this->_scope->Get_Hierarchical_Name() + ":" + this->Get_Name());
    }
  else
    return(this->Get_Name());
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

void AaObject::PrintC(ofstream& ofile, string tab_string)
{
  AaType* t = this->Get_Type();
  if(!t->Is_Pointer_Type())
    {
      ofile << tab_string << this->Get_Type()->CName() 
	    << " " 
	    << this->Get_Name()
	    << this->Get_Type()->CDim();
      ofile << ";" << endl;
    }
  else
    {
      AaType* ref_type = ((AaPointerType*)t)->Get_Ref_Type();
      ofile << tab_string << ref_type->CName() 
	    << " (*" 
	    << this->Get_Name()
	    << ") "
	    << ref_type->CDim();
      ofile << ";" << endl;
    }
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
  AaProgram::Add_Storage_Dependency_Graph_Vertex(this);
};
AaStorageObject::~AaStorageObject() {};
void AaStorageObject::Print(ostream& ofile)
{
  ofile << this->Tab();
  ofile << "$storage ";
  this->AaObject::Print(ofile);
  ofile << "// memory space index = " << this->Get_Mem_Space_Index() <<  " "
	<< " base address = " << this->Get_Base_Address() << " "
	<< " word size = " << this->Get_Word_Size();
}

void AaStorageObject::Write_VC_Model(ostream& ofile)
{
  ofile << "// ";
  this->Print(ofile);
  ofile << endl;
  ofile << "// in scope  " << (this->Get_Scope() != NULL ? this->Get_Scope()->Get_Hierarchical_Name() : "top-level") << endl;
  
  ofile << "$object [" << this->Get_VC_Name() << "] : " 
	<< this->Get_Type()->Get_VC_Name() << endl;
}


string AaStorageObject::Get_VC_Name()
{
  string ret_string = Make_VC_Legal(this->Get_Hierarchical_Name());
  return(ret_string);
}



string AaStorageObject::Get_VC_Memory_Space_Name()
{
  string scope_name;
  AaMemorySpace* ms = AaProgram::Get_Memory_Space(_mem_space_index);
  assert(ms != NULL);
  return(ms->Get_VC_Identifier());
}

void AaStorageObject::Write_VC_Load_Store_Constants(ostream& ofile)
{
  AaType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());
  
  ofile << "// load store constants for object " 
	<< this->Get_Hierarchical_Name() 
	<< endl;

  Write_VC_Constant_Declaration(this->Get_VC_Base_Address_Name(),
				addr_type->Get_VC_Name(),
				To_VC_String(this->Get_Base_Address(),addr_type->Size()),
				ofile);
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
  string ret_string = Make_VC_Legal(this->Get_Hierarchical_Name());
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
  string ret_string = Make_VC_Legal(this->Get_Hierarchical_Name());
  return(ret_string);
}
