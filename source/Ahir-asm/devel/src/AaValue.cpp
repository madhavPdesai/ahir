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


// *******************************************  VALUE ************************************
// AaValue
AaValue::AaValue(AaScope* parent):AaRoot() {this->_scope = parent;}
AaValue::~AaValue() {};

//AaStringValue
AaStringValue::AaStringValue(AaScope* parent, string value): AaValue(parent) 
{
  this->_value = value;
};
AaStringValue::~AaStringValue() {};
void AaStringValue::Print(ostream& ofile) 
{
  ofile << this->Get_Value_String(); 
}
AaIntValue::AaIntValue(AaScope* s, int w):AaValue(s)
{
  _value = new IntValue(w);
}
void AaIntValue::Set_Value(string format)
{
  IntValue tmp(_value->_width,format);
  _value->Swap(tmp);
}
AaFloatValue::AaFloatValue(AaScope* s, int c, int m):AaValue(s)
{
  _value = new FloatValue(c,m);
}
void AaFloatValue::Set_Value(string init_value)
{
  FloatValue tmp(_value->_characteristic_width, _value->_mantissa_width, init_value);
  _value->Swap(tmp);
}
AaArrayValue::AaArrayValue(AaScope* s, int w, vector<string>& init_values):AaValue(s)
{
  for(int idx = 0; idx < init_values.size(); idx++)
    {
      AaIntValue* new_val = new AaIntValue(s,w);
      new_val->Set_Value(init_values[idx]);
      _value_vector.push_back(new_val);
    }
}
AaArrayValue::AaArrayValue(AaScope* s, int c, int m, vector<string>& init_values):AaValue(s)
{
  for(int idx = 0; idx < init_values.size(); idx++)
    {
      AaFloatValue* new_val = new AaFloatValue(s,c,m);
      new_val->Set_Value(init_values[idx]);
      _value_vector.push_back(new_val);
    }
}


