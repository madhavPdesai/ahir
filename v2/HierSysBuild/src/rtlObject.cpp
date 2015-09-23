#include <istream>
#include <ostream>
#include <assert.h>
#include <hierSystem.h>
#include <rtlInclusions.h>
#include <rtlEnums.h>
#include <rtlType.h>
#include <Value.hpp>
#include <rtlValue.h>
#include <rtlObject.h>
#include <rtlThread.h>

rtlObject::rtlObject(string name, rtlType* t):hierRoot(name)
{
	_type = t;
	_group = NULL;
}

	
void rtlObject::Print_C_Struct_Field_Initialization(string obj_name, ostream& source_file)
{
	_type->Print_C_Struct_Field_Initialization(obj_name, NULL, source_file);
}

void rtlObject::Print_C_Probe_Matcher(ostream& source_file)
{
	rtlType* tt = this->Get_Type();
	rtlInterfaceGroup* ng = this->Get_Group();

	if(ng != NULL)
	{
		if(ng->_is_pipe_access)
		{
			source_file << "// pipe-access probe triggered by " << this->Get_Id() << endl;
			source_file << "{" << endl;
			source_file  << "char __req_flag = ";
			if(ng->_req->Get_Type()->Is("rtlIntegerType"))
				source_file << ng->_req->Get_C_Name() << ";" << endl;
			else
				source_file << "bit_vector_to_uint64(0, &(" << ng->_req->Get_C_Name() << "));" << endl;
			source_file << "char __ack_flag;" << endl;
			source_file << "probeMatcher("
				   << 	"__sstate->__" << ng->Get_Id() << ","
				   <<   (ng->_is_input ? "0" : "1") << ","
				   <<   "__req_flag, &__ack_flag, &(" 
				   <<    ng->_data->Get_C_Name() << "));" << endl;
			source_file << "bit_vector_assign_uint64(0, &(" << ng->_ack->Get_C_Name() << "), __ack_flag);" << endl;
			source_file << "}" << endl;
		}
		else
		{
			source_file << "// signal-access probe triggered by " << this->Get_Id() << endl;
			if(ng->_is_input)
			{
				source_file << "bit_vector_bitcast_to_bit_vector(&(" << ng->_data->Get_C_Name() << "), "
						<< "getSignalValue(__sstate->__" << ng->Get_Id() << "));" << endl;
			}
			else
			{
				source_file << "assignSignalValue(__sstate->__" << ng->Get_Id() << ", &(" 
						<< ng->_data->Get_C_Name() << "));" << endl;
			}
		}
	}
}

rtlConstant::rtlConstant(string name, rtlType* t, rtlValue* v):rtlObject(name, t)
{
	_value = v;
}

void rtlConstant::Print_C_Struct_Field_Initialization(string obj_name, ostream& source_file)
{
	_type->Print_C_Struct_Field_Initialization(obj_name, _value, source_file);
}

// Print declaration.
void rtlConstant::Print(ostream& ofile)
{
	ofile << " $constant " << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << " := ";
	_value->Print(ofile);
	ofile << endl;
}

rtlVariable::rtlVariable(string name, rtlType* t):rtlObject(name, t)
{
}

// Print declaration.
void rtlVariable::Print(ostream& ofile)
{
	ofile << " $variable " << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << endl;
}

rtlSignal::rtlSignal(string name, rtlType* t):rtlObject(name, t)
{
	_is_volatile = false;
}

// Print declaration.
void rtlSignal::Print(ostream& ofile)
{
	ofile << " $signal " << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << endl;
}

// Print declaration.
void rtlInPort::Print(ostream& ofile)
{
	ofile << " $in " << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << endl;
}

// Print declaration.
void rtlOutPort::Print(ostream& ofile)
{
	ofile << " $out " << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << endl;
}
