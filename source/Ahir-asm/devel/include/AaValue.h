#ifndef _Aa_Value__
#define _Aa_Value__

#include <AaIncludes.h>
#include <AaUtil.h>
#include <AaRoot.h>
#include <AaScope.h>
#include <AaType.h>
#include <Value.hpp>

using namespace _base_value_;

class AaValue: public AaRoot
{
 public:
  AaScope* _scope;
  AaValue(AaScope* scope);
  ~AaValue();

  virtual string Get_Value_String() {assert(0);}
  virtual AaScope* Get_Scope() {return this->_scope;}
  virtual string Kind() {return("AaValue");}
  virtual bool Is_IntValue() {return(false);}
  virtual bool Is_FloatValue() {return(false);}
  virtual bool Is_StringValue() {return(false);}
  virtual bool Is_ArrayValue() {return(false);}
  virtual string To_Binary_String() {assert(0);} //todo
};


class AaStringValue: public AaValue
{
 public:
  string _value;

  string Get_Value_String() {return(this->_value);}

  AaStringValue(AaScope* scope, string value);
  ~AaStringValue();
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("AaStringValue");}

  virtual bool Is_StringValue() {return(true);}
};

class AaIntValue: public AaValue
{
 public:
  IntValue* _value;
  AaIntValue(AaScope* s, int width);
  void Set_Value(string format);

  virtual bool Is_IntValue() {return(true);}

};

class AaFloatValue: public AaValue
{
 public:
  FloatValue* _value;
  AaFloatValue(AaScope* s, int c, int m);
  void Set_Value(string format);
  virtual bool Is_FloatValue() {return(true);}
};

class AaArrayValue: public AaValue
{
 public:
  vector<AaValue*> _value_vector;
  AaArrayValue(AaScope* s, int w, vector<string>& init_values);
  AaArrayValue(AaScope* s, int c, int m, vector<string>& init_values);
  virtual bool Is_ArrayValue() {return(true);}
};

#endif
