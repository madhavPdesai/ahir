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

 protected:
  AaValue(AaScope* scope,AaType* t);


 public:
  AaScope* _scope;

  ~AaValue();


  virtual int Get_Width();
  virtual string Get_Value_String() {assert(0);}
  virtual AaScope* Get_Scope() {return this->_scope;}
  virtual string Kind() {return("AaValue");}
  virtual void Set_Value(string fmt) { assert(0); }

  virtual bool Is_IntValue() {return(false);}
  virtual bool Is_FloatValue() {return(false);}
  virtual bool Is_StringValue() {return(false);}
  virtual bool Is_ArrayValue() {return(false);}
  virtual bool Is_RecordValue() {return(false);}

  virtual string To_C_String() {assert(0);}
  virtual string To_VC_String() {assert(0);} //todo

  virtual bool Equals(AaValue* other) {return(false);}
  virtual int To_Integer() {assert(0);}
  virtual bool To_Boolean() {assert(0);}
  virtual void Assign(AaType* t, AaValue* v) {assert(0);}

  void Set_Type(AaType* t) {_type = t;}
  AaType* Get_Type() {return(_type);}

  virtual unsigned int Eat(unsigned int init_id, vector<string>& init_vals) {assert(0);}
  virtual AaValue* Get_Element(vector<int>& indices) { assert(0); }

  virtual Value* Get_Value() {assert(0);}

  virtual void Flatten(vector<AaValue*>& fvalues) {fvalues.push_back(this);}

  friend AaValue* Make_Aa_Value(AaScope* scope, AaType* t);
  friend AaValue* Make_Aa_Value(AaScope* scope, AaType* t, vector<string>& literals);
};


class AaUintValue: public AaValue
{
 public:
  Value* _value;

  virtual Value* Get_Value() {return(_value);}
  AaUintValue(AaScope* s, int width);
  virtual void Set_Value(string format);
  virtual unsigned int Eat(unsigned int init_id, vector<string>& init_vals) 
  {
    assert(init_id < init_vals.size());
    Set_Value(init_vals[init_id]);
    return(init_id + 1);
  }

  virtual void Assign(AaType* target_type, AaValue* expr_value);

  virtual string Kind() {return("AaUintValue");}
  virtual bool Is_IntValue() {return(true);}

  virtual bool Equals(AaValue* other); 
  virtual void Make_Value(int w);
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
    return("_b" + this->_value->To_String());
  }

  virtual string To_C_String() 
  {
    return(IntToStr(this->To_Integer()));
  }
};

class AaIntValue: public AaUintValue
{
 public:
  AaIntValue(AaScope* s, int width);
  virtual void Make_Value(int w);
  virtual void Set_Value(string format);
  virtual void Assign(AaType* target_type, AaValue* expr_value);

  virtual string Kind() {return("AaIntValue");}
};

class AaFloatValue: public AaValue
{
 public:
  Float* _value;
  virtual Value* Get_Value() {return(_value);}
  virtual string Kind() {return("AaFloatValue");}
  AaFloatValue(AaScope* s, int c, int m);
  void Assign(AaType* target_type, AaValue* expr_value);
  virtual unsigned int Eat(unsigned int init_id, vector<string>& init_vals) 
  {
    assert(init_id < init_vals.size());
    Set_Value(init_vals[init_id]);
    return(init_id + 1);
  }


  virtual void Set_Value(string format);
  virtual bool Is_FloatValue() {return(true);}
  virtual bool Equals(AaValue* other); 


  virtual string To_VC_String();

  virtual string To_C_String() 
  {
    char buffer[256];
    sprintf(buffer,"%le", this->_value->To_Double());
    string ret_string = buffer;
    return(ret_string);
  }

};


class AaArrayValue: public AaValue
{

 public:
  vector<unsigned int> _dimensions;
  vector<AaValue*> _value_vector;


  virtual void Flatten(vector<AaValue*>& fvalues) 
  {
	for(int idx = 0, fidx = _value_vector.size(); idx < fidx; idx++)
		fvalues.push_back(_value_vector[idx]);
  }

  AaArrayValue(AaScope* s, AaArrayType* at);
  AaArrayValue(AaScope* s, AaArrayType* at,  vector<string>& init_values);

  virtual unsigned int Eat(unsigned int init_id, vector<string>& init_vals);

  void Assign(AaType* target_type, AaValue* expr_value);
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
    ret_val += ")";
    return(ret_val);
  }
  virtual string To_C_String()
  {
    string ret_val = "{";
    for(int idx = 0; idx < _value_vector.size(); idx++)
      {
	if(idx > 0)
	  ret_val += ",";
	ret_val += this->_value_vector[idx]->To_C_String();
      }
    ret_val += "}";
    return(ret_val);
  }
};

class AaRecordValue: public AaValue
{
 public:
  vector<AaValue*> _value_vector;

  virtual void Flatten(vector<AaValue*>& fvalues) 
  {
	for(int idx = 0, fidx = _value_vector.size(); idx < fidx; idx++)
		fvalues.push_back(_value_vector[idx]);
  }

  virtual bool Is_RecordValue() {return(true);}
  virtual unsigned int Eat(unsigned int init_id, vector<string>& init_vals);

  virtual string Kind() {return("AaRecordValue");}
  AaRecordValue(AaScope* s, AaRecordType* rt);
  AaRecordValue(AaScope* s, AaRecordType* rt, vector<string>& init_values);

  AaValue* Get_Element(vector<int>& indices);
  virtual string To_VC_String()
  {
    string ret_val = "(";
    for(int idx = 0; idx < _value_vector.size(); idx++)
      {
	if(idx > 0)
	  ret_val += ",";
	ret_val += this->_value_vector[idx]->To_VC_String();
      }
    ret_val += ")";
    return(ret_val);
  }
  virtual string To_C_String()
  {
    string ret_val = "{";
    for(int idx = 0; idx < _value_vector.size(); idx++)
      {
	if(idx > 0)
	  ret_val += ",";
	ret_val += this->_value_vector[idx]->To_C_String();
      }
    ret_val += "}";
    return(ret_val);
  }

  virtual bool Equals(AaValue* other); 
  void Assign(AaType* target_type, AaValue* expr_value);
};

// All values must be made through these two functions!
AaValue* Make_Aa_Value(AaScope* scope, AaType* t);
AaValue* Make_Aa_Value(AaScope* scope, AaType* t, vector<string>& literals);
AaValue* Perform_Unary_Operation(AaOperation op, AaValue* v);
AaValue* Perform_Binary_Operation(AaOperation op, AaValue* u, AaValue* v);

// slicing, bit-permutations.. useful stuff.
AaValue* Perform_Slice_Operation(AaValue* v, int hi, int li);
AaValue* Perform_Bitmap_Operation(AaValue* v, vector<pair<int,int> >& bitmap_vector);

// try to pack val into a binary string with size bits.
// 
string To_VC_String(unsigned int val, unsigned int size);

#endif
