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

rtlObject::rtlObject(string name, rtlType* t):hierRoot(name)
{
	_type = t;
}


rtlConstant::rtlConstant(string name, rtlType* t, rtlValue* v):rtlObject(name, t)
{
	_value = v;
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
