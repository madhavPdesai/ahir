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
#ifndef __Value__
#define __Value__

using namespace std;

#include <cstddef>
#include <algorithm>
#include <stdlib.h>
#include <ctype.h>
#include <malloc.h>
#include <unistd.h>
#include <fstream>
#include <iostream>
#include <getopt.h>
#include <stdint.h>
#include <string>
#include <set>
#include <list>
#include <vector>
#include <deque>
#include <map>
#include <deque>
#include <iomanip>
#include <sstream>
#include <math.h>
#include <istream>
#include <ostream>
#include <assert.h>
#include <stdint.h>


#define __MAX__(x,y) (x > y ? x : y)
#define __MIN__(x,y) (x < y ? x : y)

namespace _base_value_
{
  typedef uint64_t UWord;
  typedef int64_t  SWord;

#define __WORD_SIZE__ (sizeof(UWord)*8)

  class Float;
  class Signed;
  class Unsigned;

  class Value
  {

  public:
    Value();
    
    virtual string To_String() {assert(0);}
    virtual SWord To_Integer() {assert(0);}
    virtual UWord To_Uinteger() {assert(0);}
    virtual float To_Float() {assert(0);}
    virtual double To_Double() {assert(0);}
    virtual bool To_Boolean(){assert(0);}

    // bit-cast this into other.
    virtual void Bit_Cast_Into(Unsigned& other) {assert(0);}
    virtual int Bit_Width() {assert(0);}

    virtual void Slice(Unsigned& other, int hi, int li) { assert(0); }
    virtual void Bitmap(Unsigned& other, vector<pair<int,int> >& bitmap_vector) { assert(0); }
    virtual string Kind() {return("Value");}

    virtual void Fill_Byte_Array(uint8_t* v_array, uint32_t v_array_size) {assert(0);}

  };



  // two's complement integer with _width bits.
  // all arithmetic is assuming that is is unsigned.
  class Unsigned: public Value
  {

  public:
    int _width;
    UWord* _bit_field;

    ~Unsigned();
    Unsigned();
    Unsigned(int width);

    // init_value is either a decimal string (e.g. "-135", "2490")
    // or a binary string (with _b as the first two characters)
    // e.g. "_b1010"
    Unsigned(int sign_extend, int width, string initial_value);
    Unsigned(int width, string initial_value);
    Unsigned(const Unsigned&);
   
    void Initialize_From_String(int sign_extend, int n, string init_value);

    virtual string Kind() {return("Unsigned");}

    int Width() {return(_width);}
    virtual int Bit_Width() {return(_width);}
    int Array_Size()
    {
      int ret_val = _width/__WORD_SIZE__;
      if(ret_val*__WORD_SIZE__ < _width)
	ret_val++;
      return(ret_val);
    }

    virtual SWord To_Integer();
    virtual UWord To_Uinteger();
    virtual bool Is_Negative() {return(false);}
    virtual bool To_Boolean();

    virtual UWord AtoI(string ival);
    virtual UWord AtoU(string ival);

    virtual void Initialize_From_Binary_String(string& init_value);

    virtual string To_String();
    virtual string To_C_String();
    virtual Float To_Float(int characteristic, int mantissa);

    // assignment operator
    virtual void Swap(const Unsigned& v);
    virtual Unsigned& operator=(const Unsigned v);
    virtual Unsigned& operator=(const Signed v);

    // +=, *=, -=
    void Add(Unsigned&);
    void Multiply(Unsigned&);
    void Subtract(Unsigned&);
    void Divide(Unsigned&);
    void Negate();

    virtual void Assign(Unsigned&);
    virtual void Assign(Signed&);

    void Increment();
    void Decrement();

    void Complement();
    void And(Unsigned&);
    void Or(Unsigned&);
    void Xor(Unsigned&);
    void Nand(Unsigned&);
    void Nor(Unsigned&);
    void Xnor(Unsigned&);
    void Concatenate(Unsigned&);

    // todo: shift operators.
    void Shift_Left();
    void Shift_Left(int idx);
    void Shift_Right();
    virtual void Shift_Right(int idx);

    void Rotate_Left();
    void Rotate_Left(int idx);
    void Rotate_Right();
    void Rotate_Right(int idx);
    
    virtual bool Greater(Unsigned&);
    virtual bool Less_Than(Unsigned&);
    virtual bool Greater_Equal(Unsigned&);
    virtual bool Less_Equal(Unsigned&);

    bool Equal(Unsigned&);

    // bit-field.
    bool Get_Bit(int idx);
    void Set_Bit(int idx, bool v);

    virtual void Sign_Extend() 
    {
    }

    // bit-cast this into other.
    virtual void Bit_Cast_Into(Unsigned& other);
    void Reset_And_Clear(int width);
    void Set_Bit_Field(int idx, UWord bf);

    virtual void Slice(Unsigned& other, int hi, int li);
    virtual void Bitmap(Unsigned& other, vector<pair<int,int> >& bitmap_vector);

    // essentially convert the UWord array to a byte-array.
    virtual void Fill_Byte_Array(uint8_t* v_array, uint32_t v_array_size);

    virtual void Resize(int w);
  };


  class Signed: public Unsigned
  {

  public:
    ~Signed();
    Signed();
    Signed(int width);

    virtual string Kind() {return("Signed");}

    // init_value is either a decimal string (e.g. "-135", "2490")
    // or a binary string (with _b as the first two characters)
    // e.g. "_b1010"
    Signed(int width, string initial_value);
    Signed(const Signed&);

    virtual UWord AtoI(string ival);

    virtual string To_String();
    virtual string To_C_String();
    virtual Float To_Float(int characteristic, int mantissa);

    virtual SWord To_Integer();
    virtual UWord To_Uinteger();
    virtual bool Is_Negative();


    // 
    virtual void Assign(Unsigned&);
    virtual void Assign(Signed&);

    // assignment operator
    void Swap(const Signed& v);
    Signed& operator=(const Signed v);
    Signed& operator=(const Unsigned v);

    virtual void Shift_Right();
    bool Greater(Signed&);
    bool Less_Than(Signed&);
    bool Greater_Equal(Signed&);
    bool Less_Equal(Signed&);

    virtual void Resize(int w);
    virtual void Sign_Extend();
    virtual void Fill_Byte_Array(uint8_t* v_array, uint32_t v_array_size);

    virtual void Shift_Right(int idx);
  };



  // sign + characteristic (exponent) + mantissa.
  class Float: public Value
  {
  public:
    union
    {
      float _float_value;
      double _double_value;
    } data;

    int _characteristic_width;
    int _mantissa_width;

    virtual string Kind() {return("Float");}

    Float(int characteristic_width, int mantissa_width);
    Float(int characteristic_width, int mantissa_width, string float_value);

    bool Is_float32()
    {
      return((_characteristic_width == 8) && (_mantissa_width == 23));
    }
    virtual float To_Float() 
    {
      if(Is_float32())
	return(this->data._float_value);
      else
	return((float) (this->data._double_value));
    }

    virtual int Bit_Width() 
	{ if(Is_float32()) return(32); else return(64); }

    virtual double To_Double()
    {
      if(Is_float32())
	return((double)this->data._float_value);
      else
	return(this->data._double_value);
    }

    bool Is_double64()
    {
      return((_characteristic_width == 11) && (_mantissa_width == 52));
    }

    // assignment operator
    void Swap(const Float& v)
    {
      _characteristic_width = v._characteristic_width;
      _mantissa_width = v._mantissa_width;
      if(this->Is_float32())
	data._float_value = v.data._float_value;
      else if(this->Is_double64())
	data._double_value = v.data._double_value;

    }
    Float& operator=(Float v)
    {
      this->Swap(v);
      return(*this);
    }

    // +=, *=, -=
    void Add(Float&) ;
    void Multiply(Float&) ;
    void Subtract(Float&) ;
    void Divide(Float&) ;


    bool Greater( Float& t);
    bool Less_Than( Float& t);
    bool Greater_Equal( Float& t);
    bool Less_Equal( Float& t);
    bool Equal( Float& t);

    void Assign(Float& t);
    void To_Signed(Signed&);
    void To_Unsigned(Unsigned&);

    virtual string To_String();
    virtual string To_C_String();

    virtual void Bit_Cast_Into(Unsigned& other);
 
  };

  string Hex_To_Binary(string& init_value);

} // namespace _base_value_
#endif // Value

