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

rtlVariable::rtlVariable(string name, rtlType* t):rtlObject(name, t)
{
}

rtlSignal::rtlSignal(string name, rtlType* t):rtlObject(name, t)
{
}

