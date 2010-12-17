#ifndef _vc_Value__
#define _vc_Value__
#include <vcIncludes.hpp>
#include <vcRoot.hpp>


class vcType;
class vcIntType;
class vcFloatType;
class vcArrayType;
class vcRecordType;

#define _XOR_(a,b) ( a == b ? '0' : '1')
#define _OR_(a,b)  (( a == '1' || b == '1') ? '1' : '0')
#define _AND_(a,b)  (( a == '0' || b == '0') ? '0' : '1')
#define _NOT_(a) (a == '1' ? '0' : '1')
#define _NAND_(a,b) _NOT_(_AND_(a,b))
#define _NOR_(a,b) _NOT_(_OR_(a,b))
 

string Reverse(string s);
string Zero_String(int n);
string Complement(string s);
bool   Add(string s, string t); // s,t are assumed to be little-endian
bool   Less(string s, string t); // s,t are assumed to be little-endian
string Equal(string s, string t); // s,t are assumed to be little-endian
string Sub(string s, string t); // s,t are assumed to be little-endian
string Mul(string s, string t); // s,t are assumed to be little-endian
string SHRA(string s); // s is little-endian.
string SHR(string s);  // s is little-endian.
string Hex_To_Binary(string s); // little-endian hex-string converted to little-endian binary string


class vcValue: public vcRoot
{
  vcType* _type;
 public:
  vcValue(vcType t);

  vcType* Get_Type() { return(this->_type);}
  virtual string Kind() {return("vcValue");}
  virtual void Print(ostream& ofile) {assert(0);}
};

class vcIntValue: public vcValue
{
  // value is a binary string of characters
  // each of which can be 0 or 1.
  string _value;
 public:
  string Get_Value() { return(this->_value);}

  vcIntValue(vcIntType* t); // value will be all '0'
  vcIntValue(vcIntType* t, string value);
  vcIntValue(vcIntType* t, string value, string format);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcIntValue");}

  // assignment operator
  vcIntValue& operator=(const vcIntValue& v);

  // +=, *=, -=
  vcIntValue& operator+=(const vcIntValue&);
  vcIntValue& operator*=(const vcIntValue&);
  vcIntValue& operator-=(const vcIntValue&);
  vcIntValue& operator/=(const vcIntValue&);

};

vcIntValue operator+(vcIntValue&, vcIntValue&);
vcIntValue operator-(vcIntValue&, vcIntValue&);
vcIntValue operator*(vcIntValue&, vcIntValue&);
vcIntValue operator/(vcIntValue&, vcIntValue&);

bool operator>(vcIntValue&, vcIntValue&);
bool operator<(vcIntValue&, vcIntValue&);
bool operator>=(vcIntValue&, vcIntValue&);
bool operator<=(vcIntValue&, vcIntValue&);
bool operator==(vcIntValue&, vcIntValue&);


class vcFloatValue: public vcValue
{
  char _sign;
  vcIntValue& _characteristic;
  vcIntValue& _mantissa;

 public:

  vcFloatValue(vcFloatType* t, char sgn, vcIntValue* cvalue, vcIntValue* mvalue);

  vcIntValue& Get_Characteristic() {return(this->_characteristic);}
  vcIntValue& Get_Mantissa() {return(this->_mantissa);}
  
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcFloatValue");}

  // assignment operator
  vcFloatValue& operator=(const vcFloatValue& v);

  // +=, *=, -=
  vcFloatValue& operator+=(vcFloatValue) { assert(0);}
  vcFloatValue& operator*=(vcFloatValue) { assert(0);}
  vcFloatValue& operator-=(vcFloatValue) { assert(0);}
  vcFloatValue& operator/=(vcFloatValue) { assert(0);}

};

vcFloatValue operator+(vcFloatValue& s, vcFloatValue& t) { assert(0);}
vcFloatValue operator-(vcFloatValue& s, vcFloatValue& t) { assert(0);}
vcFloatValue operator*(vcFloatValue& s, vcFloatValue& t) { assert(0);}
vcFloatValue operator/(vcFloatValue& s, vcFloatValue& t) { assert(0);}

bool operator>(vcFloatValue& s, vcFloatValue& t) {assert(0);}
bool operator<(vcFloatValue& s, vcFloatValue& t) {assert(0);}
bool operator>=(vcFloatValue& s, vcFloatValue& t) {assert(0);}
bool operator==(vcFloatValue& s, vcFloatValue& t) {assert(0);}

class vcArrayValue: public vcValue
{
  vector<vcValue*> _value_array;
 public:
  vcArrayValue(vcArrayType* t, vector<vcValue*>& values);

  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcArrayValue");}

  vcArrayValue* Slice(int lindex, int rindex);
  vcValue* operator[](int index);

  int Get_Number_Of_Values() { return(this->_value_array.size());}


  // assignment operator
  vcArrayValue& operator=(const vcArrayValue& v);

  // concatenate
  friend vcArrayValue* operator&&(vcArrayValue&, vcArrayValue&);

  // equality
  friend bool operator==(vcArrayValue&, vcArrayValue&);
};

// concatenate arrays.
vcArrayValue* operator&&(vcArrayValue&, vcArrayValue&);
bool operator==(vcArrayValue&, vcArrayValue&);

class vcRecordValue: public vcValue
{
  vector<vcValue*> _element_values;
 public:
  vcRecordValue(vcRecordType* t, vector<vcValue*>& values);
  virtual void Print(ostream& ofile);
  // assignment operator
  vcRecordValue& operator=(const vcRecordValue& v);
  vcValue* operator[](int index);

  int Get_Number_Of_Elements() {return(this->_element_values.size());}
  vcValue* Get_Element(int index) {assert(index >= 0 && index < this->_element_values.size()); return(this->_element_values[index]);}

  virtual string Kind() {return("vcRecordValue");}

  // equality
  friend bool operator==(vcRecordValue&, vcRecordValue&);
};

bool operator==(vcRecordValue&, vcRecordValue&);


#endif // vcValue
