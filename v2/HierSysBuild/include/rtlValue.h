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
#ifndef rtl_Value_h__
#define rtl_Value_h__
#include <rtlType.h>

using namespace _base_value_;

class hierRoot;
enum rtlOperation;

class rtlValue:public hierRoot
{
	protected:
	rtlType* _type;
	
	public:
	rtlValue(rtlType* t) { t = NULL;}
	rtlType* Get_Type() {return(_type);}
	virtual void Print(ostream& ofile) {assert(0);}

	virtual int  To_Integer() {assert(0);}
	virtual string  To_Bit_Vector_String() {assert(0);}

	virtual bool Get_Bit(int bit_index) {assert(0);}
	virtual void Set_Bit(int bit_index, bool bit_val) {assert(0);}

	virtual rtlValue* Copy() {assert(0);}
	virtual rtlValue* Resize(int w) {assert(0);}
	virtual rtlValue* Get_Value(int index) {assert(0);}

	virtual void Not() {assert(0);}
	virtual void And(rtlValue* other) {assert(0);}
	virtual void Or(rtlValue* other)  {assert(0);}
	virtual void Xor(rtlValue* other) {assert(0);}
	virtual void Nand(rtlValue* other) {assert(0);}
	virtual void Nor(rtlValue* other)  {assert(0);}
	virtual void Xnor(rtlValue* other) {assert(0);}

	virtual void Shl(rtlValue* other) {assert(0);}
	virtual void Shr(rtlValue* other) {assert(0);}
	virtual void Rol(rtlValue* other) {assert(0);}
	virtual void Ror(rtlValue* other) {assert(0);}
	 
	virtual void Plus(rtlValue* other) {assert(0);}
	virtual void Minus(rtlValue* other) {assert(0);}
	virtual void Mul(rtlValue* other) {assert(0);}

	virtual bool Greater(rtlValue* other) {assert(0);}
	virtual bool Less(rtlValue* other) {assert(0);}
	virtual bool Equal(rtlValue* other) {assert(0);}
	virtual bool GreaterEqual(rtlValue* other) {return(!this->Less(other));}
	virtual bool LessEqual(rtlValue* other) {return(!this->Greater(other));}
	virtual bool NotEqual(rtlValue* other) {return(!this->Equal(other));}

	virtual void Concat(rtlValue* other) {assert(0);}
	virtual string  To_Vhdl_String() {return(this->To_Bit_Vector_String());}
};


class rtlIntegerValue: public rtlValue
{
	protected:
	int _value;

	public:
	rtlIntegerValue(rtlType* t, int v):rtlValue(t) {_value = v;}

	virtual void Print(ostream& ofile);
	virtual int  To_Integer() {return(_value);}

	virtual rtlValue* Copy();

	virtual void Not() {_value = ~_value;}
	virtual void And(rtlValue* other) {_value = _value & other->To_Integer();}
	virtual void Or(rtlValue* other)  {_value = _value | other->To_Integer();}
	virtual void Xor(rtlValue* other) {_value = _value ^ other->To_Integer();}
	virtual void Nand(rtlValue* other) {_value = ~(_value & other->To_Integer());}
	virtual void Nor(rtlValue* other)  {_value = ~(_value | other->To_Integer());}
	virtual void Xnor(rtlValue* other) {_value = ~(_value ^ other->To_Integer());}

	virtual void Shl(rtlValue* other) {_value = _value << other->To_Integer();}
	virtual void Shr(rtlValue* other) {_value = _value >> other->To_Integer();}
	 
	virtual void Plus(rtlValue* other) {_value = _value + other->To_Integer();}
	virtual void Minus(rtlValue* other) {_value = _value + other->To_Integer();}
	virtual void Mul(rtlValue* other) {_value = _value + other->To_Integer();}

	virtual bool Greater(rtlValue* other) { return(_value > other->To_Integer());}
	virtual bool Less(rtlValue* other) { return(_value < other->To_Integer());}
	virtual bool Equal(rtlValue* other) { return(_value == other->To_Integer());}
	virtual string  To_Vhdl_String();
};



class rtlUnsignedValue: public rtlValue
{

	protected:
	Value* _value;

	public:
	rtlUnsignedValue(rtlType* t, Value* v):rtlValue(t) {_value = v;} 
	virtual void Print(ostream& ofile);	
	virtual int  To_Integer();		
	virtual bool Get_Bit(int bi);
	virtual void Set_Bit(int bit_index, bool bit_val);
	virtual rtlValue* Copy();

	virtual Value* Get_Value() {return(_value);}
	virtual rtlValue* Resize(int w);

	virtual void Not();
	virtual void And(rtlValue* other);
	virtual void Or(rtlValue* other);
	virtual void Xor(rtlValue* other);
	virtual void Nand(rtlValue* other);
	virtual void Nor(rtlValue* other);
	virtual void Xnor(rtlValue* other);

	virtual void Shl(rtlValue* other);
	virtual void Shr(rtlValue* other);
	virtual void Rol(rtlValue* other);
	virtual void Ror(rtlValue* other);
	 
	virtual void Plus(rtlValue* other);
	virtual void Minus(rtlValue* other);
	virtual void Mul(rtlValue* other);

	virtual bool Greater(rtlValue* other);
	virtual bool Less(rtlValue* other);
	virtual bool Equal(rtlValue* other);

	virtual void Concat(rtlValue* other);

	virtual string  To_Bit_Vector_String() ;
	virtual string  To_Vhdl_String();
};


class rtlSignedValue: public rtlUnsignedValue
{
	public:

	rtlSignedValue(rtlType* t, Value* v):rtlUnsignedValue(t,v) {}
	virtual void Print(ostream& ofile);
	virtual int  To_Integer();		
	virtual rtlValue* Copy();
	virtual rtlValue* Resize(int w);

	virtual void Shr(rtlValue* other);
	 
	virtual void Plus(rtlValue* other);
	virtual void Minus(rtlValue* other);
	virtual void Mul(rtlValue* other);

	virtual bool Greater(rtlValue* other);
	virtual bool Less(rtlValue* other);
};

class rtlArrayValue: public rtlValue
{
	vector<rtlValue*> _values;

	public:
	rtlArrayValue(rtlType* t, vector<rtlValue*> vals):rtlValue(t)
	{
		_values = vals;
	}

	virtual rtlValue* Get_Value(int index) 
	{
		if((index >= 0)	 && (index < _values.size()))
		  return(_values[index]);
		else
			return(NULL);
	}
	rtlValue* Get_Value(vector<int>& indices);
	virtual void Print(ostream& ofile);
	virtual rtlValue* Copy();
	virtual string  To_Vhdl_String();
};


// make a value..
rtlValue* Make_Rtl_Value(rtlType* t, vector<string>& init_values);
rtlValue* Make_Unsigned_Zero(rtlType* t);
rtlValue* Perform_Unary_Operation(rtlOperation op, rtlValue* v);
rtlValue* Perform_Binary_Operation(rtlOperation op, rtlValue* f, rtlValue* s);
bool      Is_Zero(rtlValue* v);
bool      Are_Equal(rtlValue* f, rtlValue* s);

#endif
