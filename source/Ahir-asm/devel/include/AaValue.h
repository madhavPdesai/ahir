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
  AaType* _type;
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
  virtual string To_VC_String() {assert(0);} //todo
  virtual bool Equals(AaValue* other) {return(false);}
  virtual int To_Integer() {assert(0);}
  virtual bool To_Boolean() {assert(0);}
  virtual void Assign(AaType* t, AaValue* v) {assert(0);}

  void Set_Type(AaType* t) {_type = t;}
  AaType* Get_Type() {return(_type);}
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
  virtual bool Equals(AaValue* other); // todo
};

class AaIntValue: public AaValue
{
 public:
  IntValue* _value;
  AaIntValue(AaScope* s, int width);
  void Set_Value(string format);
  void Assign(AaType* target_type, AaValue* expr_value);

  virtual string Kind() {return("AaIntValue");}
  virtual bool Is_IntValue() {return(true);}
  virtual bool Equals(AaValue* other); 
  virtual int To_Integer()
  {
    if(this->_value)
      return((int)(this->_value->To_Integer()));
    else
      return(0);
  }
  virtual bool To_Boolean()
  {
    if(this->_value)
      return(this->_value->To_Boolean());
    else
      return(false);
  }

  virtual string To_VC_String()
  {
    return(this->_value->To_String());
  }
};

class AaFloatValue: public AaValue
{
 public:
  FloatValue* _value;
  virtual string Kind() {return("AaFloatValue");}
  AaFloatValue(AaScope* s, int c, int m);
  void Assign(AaType* target_type, AaValue* expr_value);

  void Set_Value(string format);
  virtual bool Is_FloatValue() {return(true);}
  virtual bool Equals(AaValue* other); 

  virtual string To_VC_String()
  {
    return(this->_value->To_String());
  }
};

class AaArrayValue: public AaValue
{

 public:
  vector<unsigned int> _dimensions;
  vector<AaValue*> _value_vector;

  void Set_Value(vector<string>& init_values);

  AaArrayValue(AaScope* s, AaType* element_type, vector<unsigned int>& dims);
  void Assign(AaType* target_type, AaValue* expr_value);

  AaArrayValue(AaScope* s, int w, vector<unsigned int>& dims,  vector<string>& init_values);
  AaArrayValue(AaScope* s, int c, int m, vector<unsigned int>& dims, vector<string>& init_values);
  AaValue* Get_Element(vector<int>& indices);
  virtual bool Is_ArrayValue() {return(true);}
  virtual bool Equals(AaValue* other); 
  virtual string Kind() {return("AaArrayValue");}
  virtual string To_VC_String()
  {
    string ret_val = "(";
    for(int idx = 0; idx < _value_vector.size(); idx++)
      {
	if(idx > 0)
	  ret_val += ",";
	ret_val += this->_value_vector[idx]->To_VC_String();
      }
    return(ret_val);
  }
};

AaValue* Make_Aa_Value(AaScope* scope, AaType* t);
AaValue* Make_Aa_Value(AaScope* scope, AaType* t, vector<string>& literals);
AaValue* Perform_Unary_Operation(AaOperation op, AaValue* v);
AaValue* Perform_Binary_Operation(AaOperation op, AaValue* u, AaValue* v);

#endif
