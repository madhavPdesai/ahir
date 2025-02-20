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
string Add(string s, string t); // s,t are assumed to be little-endian
bool Less(string s, string t); // s,t are assumed to be little-endian
bool Equal(string s, string t); // s,t are assumed to be little-endian
string Sub(string s, string t); // s,t are assumed to be little-endian
string Mul(string s, string t); // s,t are assumed to be little-endian
string SHRA(string s); // s is little-endian.
string SHR(string s);  // s is little-endian.
string Hex_To_Binary(string s); // little-endian hex-string converted to little-endian binary string


class vcValue: public vcRoot
{
protected:
  vcType* _type;
 public:
  vcValue(vcType* t);

  vcType* Get_Type() { return(this->_type);}
  virtual string Kind() {return("vcValue");}
  virtual void Print(ostream& ofile) {assert(0);}
  virtual string To_VHDL_String_Inner() {assert(0);}
  string To_VHDL_String();
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
  vcIntValue& operator=(vcIntValue& v);

  // +=, *=, -=
  vcIntValue& operator+=(vcIntValue&);
  vcIntValue& operator*=(vcIntValue&);
  vcIntValue& operator-=(vcIntValue&);
  vcIntValue& operator/=(vcIntValue&);

  virtual string To_VHDL_String_Inner();
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


class vcPointerValue: public vcIntValue
{
public:
  vcPointerValue(vcPointerType* t); // value will be all '0'
  vcPointerValue(vcPointerType* t, string value);
  vcPointerValue(vcPointerType* t, string value, string format);
};

class vcFloatValue: public vcValue
{

protected:
  // value is a binary string of characters
  // each of which can be 0 or 1.
  string _value;

public:
  vcFloatValue(vcFloatType* t, string value, string format);
  string Get_Value() {return(this->_value);}

  int Get_Characteristic_Width();
  int Get_Mantissa_Width();
  
  virtual void Print(ostream& ofile);
  virtual string Kind() {return("vcFloatValue");}
  
  virtual string To_VHDL_String_Inner();
  
  friend bool operator==(vcFloatValue&, vcFloatValue&);
};

bool operator==(vcFloatValue&, vcFloatValue&);
  


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

  vcType* Get_Element_Type();
  int Get_Dimension();

  // assignment operator
  vcArrayValue& operator=(vcArrayValue& v);

  // concatenate
  friend vcArrayValue* operator&&(vcArrayValue&, vcArrayValue&);

  // equality
  friend bool operator==(vcArrayValue&, vcArrayValue&);

  virtual string To_VHDL_String_Inner();
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
  vcRecordValue& operator=(vcRecordValue& v);
  vcValue* operator[](int index);

  int Get_Number_Of_Elements() {return(this->_element_values.size());}
  vcValue* Get_Element(int index) {assert(index >= 0 && index < this->_element_values.size()); return(this->_element_values[index]);}

  virtual string Kind() {return("vcRecordValue");}

  // equality
  friend bool operator==(vcRecordValue&, vcRecordValue&);

  virtual string To_VHDL_String_Inner();
};

bool operator==(vcRecordValue&, vcRecordValue&);


#endif // vcValue
