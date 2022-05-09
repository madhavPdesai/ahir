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
#include <Aa2C.h>


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
	this->_is_dereferenced = false;
}
AaObject::~AaObject() {};

bool AaObject::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
	bool new_flag = false;
	if(obj != NULL)
	{
		if(this->_addressed_objects.find(obj) == this->_addressed_objects.end())
			new_flag = true;

		// TBD: this is overly conservative...
		//      need to sharpen the addressed object propagation
		//      to remove this conservativeness.
		//      if(this->_is_dereferenced)
		//{
		if(this->Get_Addressed_Object_Representative() && (obj != this->Get_Addressed_Object_Representative()))
		{
			AaProgram::Add_Storage_Dependency(obj,this->Get_Addressed_Object_Representative());
		}
		//}

		this->_addressed_objects.insert(obj);

		if(this->_addressed_object_representative == NULL)
		{
			this->_addressed_object_representative = obj;
			new_flag = true;
		}
		else
		{
			if(this->_addressed_object_representative->Is_Foreign_Storage_Object() !=
					obj->Is_Foreign_Storage_Object())
			{ 
				AaRoot::Error("cannot coalesce a foreign storage object with native storage object ", NULL);
			}
			else if(!this->_addressed_object_representative->Is_Foreign_Storage_Object())
			{
				// nothing
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
				Propagate_Addressed_Object_Representative(this->Get_Addressed_Object_Representative(), this);
	}
}

void AaObject::Propagate_Addressed_Object_Representative(AaStorageObject* obj, AaRoot* from_where)
{
	if(AaProgram::_verbose_flag)
		AaRoot::Info("coalescing: propagating " + (obj ? obj->Get_Name() : "null") + " from object " + this->Get_Name());

	if(this->Set_Addressed_Object_Representative(obj))
		AaProgram::Add_To_Recoalesce_Map(this, obj);
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

//
// C related stuff.
//
string AaObject::C_Reference_String()
{
	return(this->Get_Name());
}


AaModule* AaObject::Get_Module()
{
	AaScope* us = this->Get_Scope();
	if(us == NULL)
		return(NULL);
	else if(us->Is("AaModule"))
		return((AaModule*)us);

	AaScope* root_scope = us->Get_Root_Scope();
	if((root_scope != NULL) && root_scope->Is("AaModule"))
		return ((AaModule*) root_scope);

	return(NULL);
}

void AaObject::PrintC_Declaration(ofstream& ofile)
{
	AaType* t = this->Get_Type();
	AaModule* m = this->Get_Module();
	bool static_flag = ((m != NULL) && m->Static_Flag_In_C());
	Print_C_Declaration(this->C_Reference_String(), static_flag, t, ofile);


	if(_value != NULL)
	{
		this->_value->Evaluate();
		// initialization of object...
		Print_C_Assignment_To_Constant(this->C_Reference_String(), this->Get_Type(), this->_value->_expression_value, ofile);
	}
}

void AaObject::PrintC_Global_Declaration(ofstream& ofile)
{
	AaType* t = this->Get_Type();

	// 
	// For uniquification, each global object name must be qualified with the
	// prefix which will be modified for each instance of a module.
	//
	string declared_name = AaProgram::_c_vhdl_module_prefix + "_" + this->C_Reference_String();
	
	// a convenient handle to refer to this global is the declared name
	// Use a define.
	Print_C_Global_Declaration(declared_name, t, ofile);
	ofile << "#define " << this->C_Reference_String() << " (" << declared_name << ")" << endl;
	ofile << endl;
}
   

void AaObject::PrintC_Global_Initialization(ofstream& ofile)
{
	AaType* t = this->Get_Type();
	Print_C_Global_Initialization(this->C_Reference_String(), t,  ofile);

	if(_value != NULL)
	{
		this->_value->Evaluate();
		// initialization of object...
		Print_C_Assignment_To_Constant(this->C_Reference_String(), this->Get_Type(), this->_value->_expression_value, ofile);
	}
}

void AaObject::PrintC(ofstream& ofile) {}

void AaObject::Write_VC_Model(ostream& ofile)
{
	ofile << this->Get_VC_Name() << ":";  this->Get_Type()->Write_VC_Model(ofile);
	ofile << endl;
	ofile << "// can point into ";
	Print_Storage_Object_Set(this->Get_Addressed_Objects(),ofile);
	ofile << endl;
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
	this->_unique_driver_statement = NULL;
	this->_expr_value = NULL;
	if(mode == "in")
		_is_input = true;
	else
		_is_input = false;
}
AaInterfaceObject::~AaInterfaceObject() {};

string AaInterfaceObject::Get_Name() 
{
	assert(this->Get_Scope() && this->Get_Scope()->Is("AaModule"));

	AaModule* m = (AaModule*)(this->Get_Scope());
	if(m->Get_Inline_Flag())
		return(m->Get_Print_Prefix() + this->AaObject::Get_Name());
	else if(m->Get_Macro_Flag())
	{

		AaExpression* expr = m->Lookup_Print_Remap(this);
		if(expr != NULL)
		{
			string pstr;
			expr->Print(pstr);
			return(pstr);
		}
		else
		{
			return(this->AaObject::Get_Name());
		}
	}
	else
		return(this->AaObject::Get_Name());
}

void AaInterfaceObject::Write_VC_Model(ostream& ofile)
{
	ofile << this->Get_VC_Name() << ":";  this->Get_Type()->Write_VC_Model(ofile);
	AaValue* expr_value = this->Get_Expr_Value();
	if(expr_value != NULL)
		ofile << " := " << expr_value->To_VC_String() << endl;
	ofile << endl;
	ofile << "// can point into ";
	Print_Storage_Object_Set(this->Get_Addressed_Objects(),ofile);
	ofile << endl;
}

  
// interface objects can be root sources.  In this case we
// need to specify their sample/update transitions.  This
// was being done in a round-about way..
string AaInterfaceObject::Get_VC_Sample_Start_Transition_Name()
{
	return("$null");
}
string AaInterfaceObject::Get_VC_Sample_Completed_Transition_Name()
{
	return("$entry");
}
string AaInterfaceObject::Get_VC_Update_Start_Transition_Name()
{
	if(this->Get_Scope()->Is_Module() && 
		((AaModule*)this->Get_Scope())->Is_Pipelined())
	{
		return(this->Get_VC_Name() + "_update_enable");
	}
	else
	{
		return("$null");
	}
}

string AaInterfaceObject::Get_VC_Update_Completed_Transition_Name()
{
	return("$entry");
}

string AaInterfaceObject::Get_VC_Unmarked_Reenable_Update_Transition_Name(set<AaRoot*>& visited_elements)
{
	string ret_val = "$null";
	if(this->Get_Scope()->Is_Module() && 
			((AaModule*)this->Get_Scope())->Is_Pipelined() &&
			((AaModule*)this->Get_Scope())->Get_Operator_Flag())
	{
		if(this->Get_Mode() == "in")
			ret_val = this->Get_VC_Name() + "_update_enable_unmarked";
	}
	return(ret_val);
}

//---------------------------------------------------------------------
// AaStorageObject
//---------------------------------------------------------------------
AaStorageObject::AaStorageObject(AaScope* parent_tpr,string oname, AaType* otype, 
		AaConstantLiteralReference* initial_value):AaObject(parent_tpr,oname,otype) 
{
	this->Set_Value(initial_value);

	_is_written_into = false;
	_is_read_from = false;
	_mem_space_index = -1;
	_base_address = 0;
	_word_size = 0;
	_address_width = 0;
	_register_flag = 0;
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
	ofile << endl << "// can point into ";
	Print_Storage_Object_Set(this->Get_Addressed_Objects(),ofile);
	ofile << endl;
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
	if(this->Get_Address_Width() > 0)
	{
		AaType* addr_type = AaProgram::Make_Uinteger_Type(this->Get_Address_Width());

		ofile << "// load store constants for object " 
			<< this->Get_Hierarchical_Name() 
			<< endl;

		Write_VC_Constant_Declaration(this->Get_VC_Base_Address_Name(),
				addr_type->Get_VC_Name(),
				To_VC_String(this->Get_Base_Address(),
					addr_type->Size()),
				ofile);
	}
	else
	{
		AaRoot::Warning("storage object " + this->Get_Name() + " not accessed in program? ",this);
	}
}



//---------------------------------------------------------------------
// AaForeignStorageObject
//---------------------------------------------------------------------
AaForeignStorageObject::AaForeignStorageObject(AaType* otype, int word_size, int address_width)
	: AaStorageObject(NULL,"foreign("+otype->To_String() + ")",otype,NULL)
{
	_word_size = word_size;
	_address_width = address_width;
}

bool AaForeignStorageObject::Set_Addressed_Object_Representative(AaStorageObject* obj)
{
	if(obj != NULL && !obj->Is_Foreign_Storage_Object())
	{
		AaRoot::Error("foreign storage object cannot be coalesced with native storage object", obj);
	}
	else if(obj != NULL)
	{
		this->_addressed_object_representative = obj;
		this->_addressed_objects.insert(obj);
	}
}

//---------------------------------------------------------------------
// AaPipeObject
//---------------------------------------------------------------------
AaPipeObject::AaPipeObject(AaScope* parent_tpr, string oname, AaType* otype):AaObject(parent_tpr,oname,otype) 
{
	_depth = 1;
	_lifo_mode = false;
	_no_block_mode = false;
	_port = false;
	_in_mode = false;
	_out_mode = false;
	_signal = false;
	_synch  = false;
	_p2p  = false;
	_full_rate = false;
	_bypass = false;
};

void AaPipeObject::Set_Depth(int d)
{
	if(d == 0)
	{
		AaRoot::Warning("pipe depth of " + this->Get_Name() + " set to 0", this);
	}
	else if(d < 0)
	{
		AaRoot::Error("pipe depth of " + this->Get_Name() + " < 0", this);
	}

	if(d >= 0)
		_depth = d;
}

AaPipeObject::~AaPipeObject() {};
void AaPipeObject::Print(ostream& ofile)
{
	ofile << this->Tab();
	if(_lifo_mode)
		ofile << "$lifo ";
	else if(_no_block_mode)
		ofile << "$noblock ";

	if(_shift_reg)
		ofile << " $shiftreg ";

	ofile << "$pipe ";
	this->AaObject::Print(ofile);
	ofile << " $depth " << this->Get_Depth() << " ";
	if(_in_mode)
		ofile << " $in ";
	else if(_out_mode)
		ofile << " $out ";

	if(_port)
		ofile << " $port ";


	if(_signal)
		ofile << " $signal ";

	if(_synch)
		ofile << " $synch ";

	if(_p2p)
		ofile << " $p2p ";

	if(_full_rate)
		ofile << " $fullrate ";

	if(_bypass)
		ofile << " $bypass ";


	ofile << endl << "// can point into ";
	Print_Storage_Object_Set(this->Get_Addressed_Objects(),ofile);
	ofile << endl;
}


void AaPipeObject::Add_Reader(AaModule* m) 
{
	if(this->Get_Out_Mode())
	{
		AaRoot::Error("pipe " + this->Get_Name() + " is marked as an out-flag.. cannot be read from.", this);
		return;
	}
	_reader_modules.insert(m);

	if(this->Get_P2P() && (_reader_modules.size() > 1))
	{
		AaRoot::Warning("pipe " + this->Get_Name() + " is marked as P2P.. cannot have multiple readers.", this);
		//this->Set_P2P(false);
	}
}

void AaPipeObject::Add_Writer(AaModule* m) 
{
	if(this->Get_In_Mode())
	{
		AaRoot::Error("pipe " + this->Get_Name() + " is marked as an in-flag.. cannot be written into.", this);
		return;
	}
	_writer_modules.insert(m);

	if(this->Get_P2P() && (_writer_modules.size() > 1))
	{
		AaRoot::Warning("pipe " + this->Get_Name() + " is marked as P2P.. cannot have multiple writers.", this);
		//this->Set_P2P(false);
	}
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
			this->Get_Depth(),
			this->Get_Lifo_Mode(),
			this->Get_No_Block_Mode(),
			this->Get_In_Mode(),
			this->Get_Out_Mode(),
			this->Get_Signal(),
			this->Get_P2P(),
			this->Get_Shift_Reg(),
			this->Get_Full_Rate(),
			this->Get_Bypass(),
			ofile);
}

string AaPipeObject::Get_VC_Name()
{
	string ret_string = Make_VC_Legal(this->Get_Hierarchical_Name());
	return(ret_string);
}


void AaPipeObject::PrintC_Pipe_Registration(ofstream& ofile)
{
	AaType* t = this->Get_Type();
	string pname = this->C_Reference_String();

	// register the pipe.
	Print_C_Pipe_Registration(pname, t, _depth, (_port | _signal),  _lifo_mode, _no_block_mode,  ofile);
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


void Print_Storage_Object_Set(set<AaStorageObject*>& ss, ostream& ofile)
{
	for(set<AaStorageObject*>::iterator iter= ss.begin(), fiter = ss.end();
			iter != fiter;
			iter++)
	{
		ofile << " " << (*iter)->Get_Hierarchical_Name();
	}
}



