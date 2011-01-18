#include <vcType.hpp>
#include <vcValue.hpp>

string Hex_To_Binary(string s) // s is assumed to be little endian 
{
  string ret_string;
  for(int idx = 0; idx < s.size(); idx++)
    {
      switch(idx)
	{
	case '0': ret_string += "0000"; break;
	case '1': ret_string += "1000"; break;
	case '2': ret_string += "0100"; break;
	case '3': ret_string += "1100"; break;
	case '4': ret_string += "0010"; break;
	case '5': ret_string += "1010"; break;
	case '6': ret_string += "0110"; break;
	case '7': ret_string += "1110"; break;
	case '8': ret_string += "0001"; break;
	case '9': ret_string += "1001"; break;
	case 'a': ret_string += "0101"; break;
	case 'b': ret_string += "1101"; break;
	case 'c': ret_string += "0011"; break;
	case 'd': ret_string += "1011"; break;
	case 'e': ret_string += "0111"; break;
	case 'f': ret_string += "1111"; break;
	default: assert(0); break;
	}
    }
  return(ret_string);
}

string Zero_String(int n)
{
  string ret_string;
  for(int idx = 0; idx < n; idx++)
    ret_string.push_back('0');
  return(ret_string);
}

string Complement(string s)
{
  string ret_string;
  for(int idx = s.size()-1; idx >= 0; idx--)
    {
      if(s[idx] == '0')
	ret_string.push_back('1');
      else
	ret_string.push_back('0');
    }
  return(ret_string);
}

string Reverse(string s)
{
  string ret_string;
  for(int idx = s.size()-1; idx >= 0; idx--)
    ret_string.push_back(s[idx]);
  return(ret_string);

}

string Add(string s, string t)
{
  assert(s.size() == t.size());

  char cin = '0';
  char cout, sum;
  string ret_string = s;

  for(int idx = 0; idx < ret_string.size(); idx++)
    {
      cout = _OR_(_AND_(ret_string[idx],t[idx]), _AND_(_OR_(ret_string[idx],t[idx]),cin));
      sum = _XOR_(_XOR_(ret_string[idx],t[idx]),cin);

      ret_string[idx] = sum;
      cin = cout;
    }
  return(ret_string);
}


bool Less(string s, string t) // s,t are assumed to be little-endian
{
  assert(s.size() == t.size());
  bool ret_val = true;

  ret_val = Less(s.substr(1), t.substr(1)) || (s[0] == '0' && t[0] == '1' && Equal(s.substr(1), t.substr(1)));
  return(ret_val);

}

bool Equal(string s, string t) // s,t are assumed to be little-endian
{
  assert(s.size() == t.size());
  bool ret_val = (s[0] == t[0]) && Equal(s.substr(1),t.substr(1));
  return(ret_val);
}

string Sub(string s, string t) // s,t are assumed to be little-endian
{
  string q = Complement(t);
  string z = Zero_String(t.size());
  z[0] = '1';
  
  string tc = Add(z,q);
  string result = Add(tc,s);
  return(result);
}

string Mul(string s, string t) // s,t are assumed to be little-endian
{
  assert(s.size() == t.size());

  string mul_result;
  int mul_size = s.size() + t.size();
  int result_size = s.size();

  // result is initialized with all zero's
  for(int idx = 0; idx < mul_size; idx++)
    {
      mul_result[idx] = '0';
    }

  // shift and add algorithm
  for(int vidx = 0; vidx < result_size; vidx++)
    {
      mul_result = SHRA(mul_result);
      if(t[vidx] == '1') 
	{
	  string mul_result_top = mul_result.substr(result_size);
	  mul_result_top = Add(mul_result_top,s);
	  mul_result.replace(result_size,result_size, mul_result_top);
	}
    }

  string ret_string = (mul_result.substr(0,result_size));
  return(ret_string);
}

// s is little-endian
// s = s0 s1 s2 ... sn
// SHRA(s) = s1 s2 s3 ... sn sn
string SHRA(string s)
{
  string sr = Reverse(s);
  string retr;
  retr.push_back(sr[0]);
  retr = retr + sr.substr(1);
  return(Reverse(retr));
}

// s is little-endian
// s = s0 s1 s2 ... sn
// SHR(s) = s1 s2 s3 ... sn 0
string SHR(string s)
{
  string sr = Reverse(s);
  string retr = '0' + sr.substr(1);
  return(Reverse(retr));
}

vcValue::vcValue(vcType* t):vcRoot()
{
  assert(t != NULL);
  this->_type = t;
}


vcIntValue::vcIntValue(vcIntType* t):vcValue((vcType*)t)
{
  assert(t->Is("vcIntType") || t->Is("vcPointerType") );
  for(int idx = 0; idx < t->Size(); idx++)
    this->_value.push_back('0');
}



vcIntValue::vcIntValue(vcIntType* t, string value):vcValue((vcType*)t)
{
  // length
  assert(t->Is("vcIntType") || t->Is("vcPointerType") );
  assert((t)->Size() == value.size());

  // assume binary.
  for(int idx = 0; idx < value.size(); idx++)
    assert(value[idx] == '0' || value[idx] == '1');

  this->_value = Reverse(value);
}

vcIntValue::vcIntValue(vcIntType* t, string big_endian_value, string format):vcValue((vcType*)t)
{
  if(format == "binary")
    {
      assert(t->Is("vcIntType") || t->Is("vcPointerType") );
      assert((t)->Size() == big_endian_value.size());
      this->_value = Reverse(big_endian_value);
    }
  else 
    {
      this->_value = Hex_To_Binary(Reverse(big_endian_value));
      this->_value.resize((t)->Size(),'0');
    }
}


void vcIntValue::Print(ostream& ofile)
{
  ofile << "_b" << Reverse(this->_value) << " ";
}

string vcIntValue::To_VHDL_String()
{
  return('"' + Reverse(this->_value) + '"');
}

// assignment operator
vcIntValue& vcIntValue::operator=( vcIntValue& v)
{
  this->_type = v.Get_Type();
  this->_value = v.Get_Value();
  return(*this);
}

// +=, *=, -=
vcIntValue& vcIntValue::operator+=( vcIntValue& v)
{
  assert(this->_value.size() == v.Get_Value().size());
  this->_value = Add(this->_value, v.Get_Value());
  return (*this);
}

vcIntValue& vcIntValue::operator*=( vcIntValue& v)
{
  assert(this->_value.size() == v.Get_Value().size());
  this->_value = Mul(this->_value, v.Get_Value());
  return(*this);
}

vcIntValue& vcIntValue::operator-=( vcIntValue& v)
{
  assert(this->_value.size() == v.Get_Value().size());
  this->_value = Sub(this->_value, v.Get_Value());
  return (*this);
}

vcIntValue& vcIntValue::operator/=( vcIntValue& v)
{
  assert(0 && "integer divide not implemented\n");
}
 

// friend operators
vcIntValue operator+(vcIntValue& s, vcIntValue& t)
{
  assert(s.Get_Type()->Is("vcIntType") && t.Get_Type()->Is("vcIntType") && (s.Get_Type()->Size() ==  t.Get_Type()->Size()));
  return vcIntValue((vcIntType*)(s.Get_Type()),Add(s.Get_Value(),t.Get_Value()));
}
vcIntValue operator-(vcIntValue& s, vcIntValue& t)
{
  assert(s.Get_Type()->Is("vcIntType") && t.Get_Type()->Is("vcIntType") && (s.Get_Type()->Size() ==  t.Get_Type()->Size()));
  return vcIntValue((vcIntType*)(s.Get_Type()),Sub(s.Get_Value(),t.Get_Value()));
}
vcIntValue operator*(vcIntValue& s , vcIntValue &t)
{
  assert(s.Get_Type()->Is("vcIntType") && t.Get_Type()->Is("vcIntType") && (s.Get_Type()->Size() ==  t.Get_Type()->Size()));
  return vcIntValue((vcIntType*)(s.Get_Type()),Mul(s.Get_Value(),t.Get_Value()));
}
vcIntValue operator/(vcIntValue& s, vcIntValue& t)
{
  assert(0);
}


bool operator>(vcIntValue& s, vcIntValue& t)
{
  return (!((s == t) || (s < t)));
}
bool operator<(vcIntValue& s, vcIntValue& t)
{
  return (Less(s.Get_Value(),t.Get_Value()));
}
bool operator>=(vcIntValue& s, vcIntValue& t)
{
  return (!(s < t));
}
bool operator==(vcIntValue& s, vcIntValue& t)
{
  return (Equal(s.Get_Value(),t.Get_Value()));
}
bool operator<=(vcIntValue& s, vcIntValue& t)
{
  return ((s < t) || (s == t));
}


vcPointerValue::vcPointerValue(vcPointerType* t):vcIntValue((vcIntType*)t) 
{
}
vcPointerValue::vcPointerValue(vcPointerType* t, string big_endian_value, string format):
  vcIntValue((vcIntType*)t,big_endian_value,format)
{
}
vcPointerValue::vcPointerValue(vcPointerType* t, string value):vcIntValue((vcIntType*)t,value)
{
}

vcFloatValue::vcFloatValue(vcFloatType* t, char sgn, vcIntValue* cvalue, vcIntValue* mvalue):vcValue((vcType*)t)
{
  this->_sign = sgn;
  this->_characteristic = cvalue;
  this->_mantissa = mvalue;
}

void vcFloatValue::Print(ostream& ofile)
{
  ofile << (this->_sign ? "-" : " ") << "C";
  this->_characteristic->Print(ofile);
  ofile << "M";
  this->_mantissa->Print(ofile);
  ofile << " ";
}

string vcFloatValue::To_VHDL_String()
{
  string ret_string;
  ret_string += '"';
  ret_string = ret_string + (this->_sign ? "1" : "0");
  ret_string = ret_string + Reverse(this->_characteristic->Get_Value()) + Reverse(this->_mantissa->Get_Value());
  ret_string += '"';
  return(ret_string);
}

// assignment operator
vcFloatValue& vcFloatValue::operator=( vcFloatValue& v)
{
  this->_sign = v.Get_Sign();

  // dont delete anything!
  this->_characteristic = v.Get_Characteristic();
  this->_mantissa = v.Get_Mantissa();
}


vcFloatValue& vcFloatValue::operator+=(vcFloatValue) { assert(0);}
vcFloatValue& vcFloatValue::operator*=(vcFloatValue) { assert(0);}
vcFloatValue& vcFloatValue::operator-=(vcFloatValue) { assert(0);}
vcFloatValue& vcFloatValue::operator/=(vcFloatValue) { assert(0);}

vcFloatValue operator+(vcFloatValue& s, vcFloatValue& t) { assert(0);}
vcFloatValue operator-(vcFloatValue& s, vcFloatValue& t) { assert(0);}
vcFloatValue operator*(vcFloatValue& s, vcFloatValue& t) { assert(0);}
vcFloatValue operator/(vcFloatValue& s, vcFloatValue& t) { assert(0);}

bool operator>(vcFloatValue& s, vcFloatValue& t) {assert(0);}
bool operator<(vcFloatValue& s, vcFloatValue& t) {assert(0);}
bool operator>=(vcFloatValue& s, vcFloatValue& t) {assert(0);}

bool operator==(vcFloatValue& s, vcFloatValue& t) 
{
  if((s._sign == t._sign) && (*(s._characteristic) == *(t._characteristic)) &&  (*(s._mantissa) == *(t._mantissa)))
    return(true);
  else
    return(false);
}

vcArrayValue::vcArrayValue(vcArrayType* t, vector<vcValue*>& values):vcValue((vcType*)t)
{
  for(int idx = 0; idx < values.size(); idx++)
    _value_array.push_back(values[idx]);
}


void vcArrayValue::Print(ostream& ofile)
{
  ofile << "(";
  for(int idx = 0; idx < _value_array.size(); idx++)
    {
      if(idx > 0)
	ofile << ", ";

      _value_array[idx]->Print(ofile);
    }
  ofile << ") ";
}


string vcArrayValue::To_VHDL_String()
{
  string ret_string;
  ret_string = "(";
  for(int idx = 0; idx < _value_array.size(); idx++)
    {
      if(idx > 0)
	ret_string += ',';

      ret_string += _value_array[idx]->To_VHDL_String();
    }
  ret_string += ")";
  return(ret_string);
}

vcArrayValue* vcArrayValue::Slice(int lindex, int rindex)
{
  assert(rindex >= lindex);
  vcArrayType* t = Make_Array_Type(((vcArrayType*)(this->Get_Type()))->Get_Element_Type(), rindex-lindex);
  vector<vcValue*> slice_values;
  for(int idx = lindex; idx <= rindex; idx++)
    slice_values.push_back(this->_value_array[idx]);
  
  vcArrayValue* ret_val = new vcArrayValue(t, slice_values);
  return(ret_val);
}

vcValue* vcArrayValue::operator[](int index)
{
  assert(index >= 0 && index < this->_value_array.size());
  return(this->_value_array[index]);
}

// assignment operator
vcArrayValue& vcArrayValue::operator=( vcArrayValue& v)
{
  this->_type = v.Get_Type();
  this->_value_array.clear();
  for(int idx = 0; idx < v.Get_Number_Of_Values(); idx++)
    this->_value_array.push_back(v[idx]);
};

vcType* vcArrayValue::Get_Element_Type()
{
  return(((vcArrayType*)this->_type)->Get_Element_Type());
}
int vcArrayValue::Get_Dimension()
{
 return(((vcArrayType*)this->_type)->Get_Dimension());
}

// concatenate arrays.
vcArrayValue* operator&&(vcArrayValue& s, vcArrayValue& t)
{

  assert(s.Get_Element_Type() == t.Get_Element_Type());

  vcArrayType* at = Make_Array_Type(s.Get_Element_Type(), s.Get_Dimension() + t.Get_Dimension());
  vector<vcValue*> concat_values = s._value_array;
  
  for(int idx = 0; idx < t.Get_Number_Of_Values(); idx++)
    concat_values.push_back(t[idx]);
  
  vcArrayValue* ret_val = new vcArrayValue(at, concat_values);
  return(ret_val);

}

bool operator==(vcArrayValue& s, vcArrayValue& t)
{
  bool ret_val = true;
  if(s.Get_Type() == t.Get_Type())
    {
      if(s._value_array.size() == t._value_array.size())
	for(int idx = 0; idx < s._value_array.size(); idx++)
	  {
	    if(!(s[idx] == t[idx]))
	      { 
		ret_val = false;
		break;
	      }
	  }
      else 
	ret_val = false;
    }
  else
    ret_val = false;

  return(ret_val);
}


vcRecordValue::vcRecordValue(vcRecordType* t, vector<vcValue*>& values):vcValue((vcType*)t)
{
  this->_element_values = values;
}

void vcRecordValue::Print(ostream& ofile)
{
  ofile << "(";
  for(int idx = 0; idx < _element_values.size(); idx++)
    {
      if(idx > 0)
	ofile << ", ";

      _element_values[idx]->Print(ofile);
    }
  ofile << ") ";
}

string vcRecordValue::To_VHDL_String()
{
  string ret_string =  "(";
  for(int idx = 0; idx < _element_values.size(); idx++)
    {
      if(idx > 0)
	ret_string += ", ";

      ret_string += _element_values[idx]->To_VHDL_String();
    }
  ret_string += ")";
  return(ret_string);
}

vcValue* vcRecordValue::operator[](int index)
{
  assert(index >= 0 && index < this->_element_values.size());
  return(this->_element_values[index]);
}

  // assignment operator
vcRecordValue& vcRecordValue::operator=( vcRecordValue& v)
{
  this->_type = v.Get_Type();
  this->_element_values.clear();
  for(int idx = 0; idx < v.Get_Number_Of_Elements(); idx++)
    this->_element_values.push_back(v[idx]);
  return(*this);
}



bool operator==(vcRecordValue& s, vcRecordValue& t)
{
  bool ret_val = true;
  if(s.Get_Type() == t.Get_Type())
    {
      if(s._element_values.size() == t._element_values.size())
	for(int idx = 0; idx < s._element_values.size(); idx++)
	  {
	    if(!(s[idx] == t[idx]))
	      { 
		ret_val = false;
		break;
	      }
	  }
      else 
	ret_val = false;
    }
  else
    ret_val = false;

  return(ret_val);
}


