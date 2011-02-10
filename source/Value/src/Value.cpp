#include <Value.hpp>
using namespace std;
using namespace _base_value_;
Value::Value()
{
}

IntValue::IntValue():Value()
{
  this->_bit_field = NULL;
  this->_width = 0;
}

IntValue::IntValue(int n): Value()
{
  assert(n > 0);
  _width = n;

  this->_bit_field = new UWord[(this->Array_Size())];
  for(int idx = 0; idx < this->Array_Size() ; idx++)
    this->_bit_field[idx] = 0;
}

IntValue::IntValue(int n, string format, string init_value)
{
  assert(n > 0);
  _width = n;
  _bit_field = new UWord[this->Array_Size()];

  for(int idx = 0; idx < this->Array_Size(); idx++)
    _bit_field[idx] = 0;

  if(format == "decimal")
    {
      if(n > 32)
	{
	  cerr << "Error: decimal format can be used for integers which are up to 32 bits wide" << endl;
	  cerr << "          the initial value will be ignored " << endl;
	}
      else
	{
	  _bit_field[0] = (SWord) atoi(init_value.c_str());
	}
    }
  else if(format == "binary")
    {
      if(init_value.size() > _width)
	{
	  cerr << "Error: binary initialization string is longer than integer width" << endl;
	  cerr << "          the initial value will be truncated " << endl;
	}
      for(int idx = init_value.size()-1; idx >= 0; idx--)
	{
	  int actual_index = (init_value.size()-1) - idx;
	  if(init_value[idx] == '1')
	    this->Set_Bit(actual_index,true);
	  else
	    this->Set_Bit(actual_index,false);
	}
    }
}

IntValue::IntValue(const IntValue& v):Value()
{
  _width = v._width;
  _bit_field = new UWord[this->Array_Size()];
  for(int idx = 0; idx < this->Array_Size(); idx++)
    _bit_field[idx] = v._bit_field[idx];
}

UWord IntValue::To_Uinteger()
{
  return(_bit_field[0]);
}

SWord IntValue::To_Integer()
{
  SWord int_val;
  int_val = _bit_field[0]; // ugly but can it be done better?
  return(int_val);
}

string IntValue::To_String()
{
  string ret_value;
  for(int idx = _width-1; idx >= 0; idx--)
    {
      ret_value.push_back((this->Get_Bit(idx) ? '1' : '0'));
    }
  return(ret_value);
}


FloatValue IntValue::To_Float(int characteristic, int mantissa)
{
  FloatValue ret_val = FloatValue(characteristic,mantissa);
  if(_width > 64)
    {
      cerr << "Error: int<->float conversion supported only for integers which are up to 64 bits wide" 
	   << endl;
      cerr << "          the initial value will be ignored " << endl;
      return(ret_val);
    }

  if(characteristic + mantissa == 31)
    ret_val.data._float_value = (float) _bit_field[0];
  else if(characteristic+mantissa == 63)
    ret_val.data._double_value = (double) _bit_field[0];

  return(ret_val);
}


FloatValue IntValue::Signed_To_Float(int characteristic, int mantissa_width)
{
  FloatValue ret_val = FloatValue(characteristic,mantissa_width);
  if(_width > 64)
    {
      cerr << "Error: int<->float conversion supported only for integers which are up to 64 bits wide" 
	   << endl;
      cerr << "          the initial value will be ignored " << endl;
      return(ret_val);
    }


  if(ret_val.Is_float32())
    ret_val.data._float_value = (float) _bit_field[0];
  else if(ret_val.Is_double64())
    ret_val.data._double_value = (double) _bit_field[0];

  return(ret_val);
}



void IntValue::Swap(const IntValue& v)
{
  if(this->_bit_field)
    delete [] this->_bit_field;
  
  _width = v._width;
  _bit_field = new UWord[this->Array_Size()];

  for(int idx = 0; idx < this->Array_Size(); idx++)
    _bit_field[idx] = v._bit_field[idx];
}

IntValue& IntValue::operator=(IntValue v)
{
  this->Swap(v);
  return(*this);
}


void IntValue::Add(IntValue& b)
{
  bool carry = false;
  assert(this->_width == b.Width());

  for(int idx = 0; idx < b.Width(); idx++)
    {
      bool abit = this->Get_Bit(idx);
      bool bbit = b.Get_Bit(idx);
      bool sum = (abit ^ bbit ^ carry);
      this->Set_Bit(idx,sum);
      carry = (abit & bbit) | ((abit | bbit) & carry);
    }
}

void IntValue::Multiply(IntValue& b )
{
  assert(this->_width == b.Width());

  if(b.Width() > 64)
    {
      cerr << "Error: multiply supported for integers which are up to 64 bits wide" << endl;
      cerr << "          will return junk " << endl;
      return;
    }

  this->_bit_field[0] = this->_bit_field[0] * b._bit_field[0];
}

void IntValue::Subtract(IntValue& b)
{
  assert(_width == b.Width());
  IntValue one_val(b.Width(),"binary","1");

  IntValue tmp(b.Width());
  tmp = b;
  tmp.Complement();
  tmp.Add(one_val);
  
  this->Add(tmp);
}

void IntValue::Divide(IntValue& b)
{
  assert(_width == b.Width());
  if(_width > 64)
    {
      cerr << "Error: divide supported for integers which are up to 64 bits wide" << endl;
      cerr << "          will return junk " << endl;
      return;
    }
  
  this->_bit_field[0] = this->_bit_field[0] / b._bit_field[0];
}


// unsigned int <-> unsigned int type conversion
void IntValue::Unsigned_Assign(IntValue& v)
{
  for(int idx = 0; idx < this->Array_Size(); idx++)
    _bit_field[idx] = 0;

  for(int idx = 0; idx < __MIN__(this->Array_Size(),v.Array_Size()); idx++)
    _bit_field[idx] = v._bit_field[idx];
}

void IntValue::Signed_Assign(IntValue& v)
{
  for(int idx = 0; idx < this->Array_Size(); idx++)
    _bit_field[idx] = 0;

  bool sign_bit = v.Get_Bit(v.Width() - 1);
  
  for(int idx = 0; idx < __MIN__(_width,v.Width()); idx++)
    {
      this->Set_Bit(idx, v.Get_Bit(idx));
    }
  for(int idx = v.Width(); idx < _width; idx++)
    this->Set_Bit(idx,sign_bit);
}

bool IntValue::Get_Bit(int idx)
{
  int word_index = idx/__WORD_SIZE__;
  int bit_index  = idx%__WORD_SIZE__;

  assert(word_index < this->Array_Size());
  
  UWord mask_bit = 1;
  if(_bit_field[word_index] & (mask_bit << bit_index))
    return(true);
  else
    return(false);
}


void IntValue::Set_Bit(int idx, bool v)
{
  int word_index = idx/__WORD_SIZE__;
  int bit_index  = idx%__WORD_SIZE__;

  assert(word_index < this->Array_Size());
  
  UWord bit_mask = (1 << bit_index);
  UWord and_mask = ~bit_mask;

  _bit_field[word_index] = (_bit_field[word_index] &  and_mask) | (v ? bit_mask : 0);
}


void IntValue::Negate()
{
  IntValue one_val(this->Width(),"binary","1");
  this->Complement();
  this->Add(one_val);
}

void IntValue::Complement()
{
  for(int idx = 0; idx < this->Array_Size(); idx++)
    _bit_field[idx] = ~(_bit_field[idx]);
}

void IntValue::And(IntValue& b)
{
  assert(this->Width() == b.Width());
  for(int idx = 0; idx < this->Array_Size(); idx++)
    this->_bit_field[idx] = (this->_bit_field[idx] & b._bit_field[idx]);
}

void IntValue::Or(IntValue& b)
{
  assert(this->Width() == b.Width());
  for(int idx = 0; idx < this->Array_Size(); idx++)
    this->_bit_field[idx] = (this->_bit_field[idx] | b._bit_field[idx]);
}

void IntValue::Xor(IntValue& b)
{
  assert(this->Width() == b.Width());
  for(int idx = 0; idx < this->Array_Size(); idx++)
    this->_bit_field[idx] = (this->_bit_field[idx] ^ b._bit_field[idx]);
}
void IntValue::Nand(IntValue& b)
{
  this->And(b);
  this->Complement();
}
void IntValue::Nor(IntValue& b)
{
  this->Or(b);
  this->Complement();
}
void IntValue::Xnor(IntValue& b)
{
  this->Xor(b);
  this->Complement();
}

void IntValue::Concatenate(IntValue& b)
{
  IntValue tmp(_width + b._width);

  for(int idx = 0; idx < b.Width(); idx++)
    {
      tmp.Set_Bit(idx, (b.Get_Bit(idx) ? true : false));
    }
  for(int idx = 0; idx < this->_width; idx++)
    {
      tmp.Set_Bit(idx + b.Width(), (this->Get_Bit(idx) ? true : false));
    }

  this->Swap(tmp);
}

bool IntValue::Greater(IntValue& b)
{
  bool ret_val = true;
  assert(this->Width() == b.Width());
  for(int idx = this->Width()-1; idx >= 0; idx--)
    {
      if((!this->Get_Bit(idx) && b.Get_Bit(idx)))
	{
	  ret_val = false;
	  break;
	}
      else if(this->Get_Bit(idx) && !b.Get_Bit(idx))
	break;
    }

  return(ret_val);
}

bool IntValue::Less_Than(IntValue& b)
{
  return(b.Greater(*this));
}

bool IntValue::Greater_Equal(IntValue& b)
{
  return(this->Greater(b) && !b.Greater(*this));
}

bool IntValue::Less_Equal(IntValue& b)
{
  return(this->Less_Than(b) && !this->Greater(b));
}
bool IntValue::Equal(IntValue& b)
{
  return(!this->Greater(b) && !this->Less_Than(b));
}

bool IntValue::Signed_Less(IntValue& b)
{
  bool a_sign = this->Get_Bit(_width - 1);
  bool b_sign = b.Get_Bit(b.Width() -1);

  assert(this->Width() == b.Width());

  if(!a_sign && !b_sign)
    return(this->Less_Than(b)); // both positive
  else if(a_sign && !b_sign)
    return(true); // a negative, b positive
  else if(!a_sign && b_sign)
    return(false); // a positive, b negative
  else
    return(b.Less_Than(*this)); // both negative.
}
bool IntValue::Signed_Greater(IntValue& b)
{
  return(this->Signed_Less(b));
}
bool IntValue::Signed_Less_Equal(IntValue& b)
{
  return(this->Signed_Less(b) && !this->Signed_Greater(b));
}
bool IntValue::Signed_Greater_Equal(IntValue& b)
{
  return(!this->Signed_Less(b) && !this->Signed_Greater(b));
}

FloatValue::FloatValue(int characteristic_width, int mantissa_width):Value()
{
  if(characteristic_width + mantissa_width == 31)
    this->data._float_value = 0;
  else if(characteristic_width + mantissa_width == 63)
    this->data._double_value = 0;
  else
    {
      cerr << "Error: IEEE float and double precision are the only supported floating point formats" 
	   << endl;
    }

  _characteristic_width = characteristic_width;
  _mantissa_width = mantissa_width;

}
FloatValue::FloatValue(int characteristic_width, int mantissa_width, string float_value):Value()
{

  _characteristic_width = characteristic_width;
  _mantissa_width = mantissa_width;

  if(this->Is_float32())
    this->data._float_value = atof(float_value.c_str());
  else if(this->Is_double64())
    this->data._double_value = atof(float_value.c_str());
  else
    {
      cerr << "Error: IEEE float and double precision are the only supported floating point formats" 
	   << endl;
    }


}


    // +=, *=, -=
void FloatValue::Add(FloatValue& v)
{
  assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
  if(this->Is_float32())
    this->data._float_value += v.data._float_value;
  else   if(this->Is_double64())
    this->data._double_value += v.data._double_value;

}
void FloatValue::Multiply(FloatValue& v) 
{
  assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
  if(this->Is_float32())
    this->data._float_value *= v.data._float_value;
  else   if(this->Is_double64())
    this->data._double_value *= v.data._double_value;
}

void FloatValue::Subtract(FloatValue& v)
{
  assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
  if(this->Is_float32())
    this->data._float_value -= v.data._float_value;
  else   if(this->Is_double64())
    this->data._double_value -= v.data._double_value;
}

void FloatValue::Divide(FloatValue& v)
{
  assert((_characteristic_width == v._characteristic_width) && (_mantissa_width == v._mantissa_width));
  if(this->Is_float32())
    this->data._float_value /= v.data._float_value;
  else   if(this->Is_double64())
    this->data._double_value /= v.data._double_value;
}

void FloatValue::To_Integer(IntValue& v)
{
  if(this->Is_float32())
    v._bit_field[0] = (SWord) this->data._float_value;
  else   if(this->Is_double64())
    v._bit_field[0] = (SWord) this->data._double_value;
}

string FloatValue::To_String()
{
  char buffer[1024];
  if(this->Is_float32())
    sprintf(buffer,"%f",this->data._float_value);
  else   if(this->Is_double64())
    sprintf(buffer,"%f",this->data._double_value);

  string ret_string = buffer;
  return(ret_string);
}



bool FloatValue::Greater(FloatValue& t)
{
  bool ret_val;
  assert((this->_characteristic_width == t._characteristic_width) && (this->_mantissa_width == t._mantissa_width));
  if(this->Is_float32())
    ret_val = (this->data._float_value > t.data._float_value);
  else   if(this->Is_double64())
    ret_val = (this->data._float_value < t.data._float_value);
  return(ret_val);  

}
bool FloatValue::Less_Than(FloatValue& t)
{
  return(t.Greater(*this));
}
bool FloatValue::Greater_Equal(FloatValue& t)
{
  return (!this->Less_Than(t));
}
bool FloatValue::Less_Equal(FloatValue& t)
{
  return (!this->Greater(t));
}
bool FloatValue::Equal(FloatValue& t)
{
  return(!(this->Less_Than(t) || this->Greater(t)));
}
