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
	_number_of_drivers = 0;
}

	
void rtlObject::Print_C_Struct_Field_Initialization(string obj_name, ostream& source_file)
{
	_type->Print_C_Struct_Field_Initialization(obj_name, NULL, source_file);
}

void rtlObject::Print_C_Probe_Matcher(ostream& source_file)
{
	rtlType* tt = this->Get_Type();
	if(this->Is_Pipe())
	{
		source_file << "// pipe-access probe triggered by " << this->Get_Id() << endl;
		source_file << "{" << endl;
		source_file  << "char __req_flag = ";
		source_file << "bit_vector_to_uint64(0, &(" << this->Get_C_Req_Name() << "));" << endl;
		source_file << "char __ack_flag = 0;" << endl;
		source_file << "probeMatcher("
			<< 	"__sstate->__matcher_" << this->Get_Id() << ","
			<<   (this->Is_InPort() ? "0" : "1") << ","
			<<   "__req_flag, &__ack_flag, &(" 
			<<    (this->Is_InPort() ? this->Get_C_Target_Name() : this->Get_C_Name())  << "));" << endl;
		source_file << "bit_vector_assign_uint64(0, &(" << this->Get_C_Ack_Name() << "), __ack_flag);" << endl;
		source_file << "}" << endl;
	}
	else 
	{
		if(this->Is_InPort())
		{
			source_file  << "{" << endl;
			source_file << "// signal-access probe triggered by " << this->Get_Id() << endl;
			source_file << "bit_vector* sig_val = getSignalValue(__sstate->__matcher_" + this->Get_Id() + ");" << endl;
			source_file << "bit_vector_bitcast_to_bit_vector(&(" << this->Get_C_Target_Name() << "),sig_val);" << endl;
			source_file << "}" << endl;
		}
		else if(this->Is_OutPort())
		{
			source_file << "{" << endl;
			source_file << "// signal-access probe triggered by " << this->Get_Id() << endl;
			source_file << "assignSignalValue(__sstate->__matcher_" << this->Get_Id() << ", &(" 
						<< this->Get_C_Name() << "));" << endl;
			source_file << "}" << endl;
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
	_is_pipe = false;
	_is_volatile = false;
	_tick = false;
}

rtlSignal::rtlSignal(bool is_pipe, string name, rtlType* t):rtlObject(name, t)
{
	_is_pipe = is_pipe;
	_is_volatile = false;
	_tick = false;
}

void rtlSignal::Set_Tick(bool v) 
{
	if(v && _is_volatile)
		this->Report_Error("signal " + this->Get_Id() + " is simultaneously volatile and ticked");

	_tick = v;
}
void rtlSignal::Set_Is_Volatile(bool v)
{
	if(v && _tick)
		this->Report_Error("signal " + this->Get_Id() + " is simultaneously volatile and ticked");

	_is_volatile = v;
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
	ofile << " $in " << (this->Is_Pipe() ? "$pipe " : "")  << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << endl;
}

// Print declaration.
void rtlOutPort::Print(ostream& ofile)
{
	ofile << " $out " << (this->Is_Pipe() ? "$pipe " : "")  << this->Get_Id();
	ofile << " : ";
	_type->Print(ofile);
	ofile << endl;
}
