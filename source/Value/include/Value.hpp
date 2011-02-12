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

#define __WORD_SIZE__ sizeof(UWord)

  class Value
  {

  public:
    Value();
    virtual string To_String() {assert(0);}
  };

  class FloatValue;
  // two's complement integer with _width bits.
  class IntValue: public Value
  {

  public:
    int _width;
    UWord* _bit_field;

    ~IntValue();
    IntValue();
    IntValue(int width);

    // init_value is either a decimal string (e.g. "-135", "2490")
    // or a binary string (with _b as the first two characters)
    // e.g. "_b1010"
    IntValue(int width, string initial_value);
    IntValue(const IntValue&);

    int Width() {return(_width);}
    int Array_Size()
    {
      int ret_val = _width/__WORD_SIZE__;
      if(ret_val*__WORD_SIZE__ < _width)
	ret_val++;
      return(ret_val);
    }

    SWord To_Integer();
    UWord To_Uinteger();

    string To_String();

    FloatValue To_Float(int characteristic, int mantissa);
    FloatValue Signed_To_Float(int characteristic, int mantissa);

    // assignment operator
    void Swap(const IntValue& v);
    IntValue& operator=(const IntValue v);

    // +=, *=, -=
    void Add(IntValue&);
    void Multiply(IntValue&);
    void Subtract(IntValue&);
    void Divide(IntValue&);
    void Negate();

    void Signed_Assign(IntValue&);
    void Unsigned_Assign(IntValue&);

    void Increment();
    void Decrement();


    void Complement();
    void And(IntValue&);
    void Or(IntValue&);
    void Xor(IntValue&);
    void Nand(IntValue&);
    void Nor(IntValue&);
    void Xnor(IntValue&);
    void Concatenate(IntValue&);

    // todo: shift operators.
    void Shift_Left();
    void Shift_Left(int idx);
    void Shift_Right();
    void Shift_Right(int idx);

    void Shift_Right_Signed();
    void Shift_Right_Signed(int idx);

    void Rotate_Left();
    void Rotate_Left(int idx);
    void Rotate_Right();
    void Rotate_Right(int idx);
    
    //////// ^^ shift operators todo ////////////////

    bool Greater(IntValue&);
    bool Less_Than(IntValue&);
    bool Greater_Equal(IntValue&);
    bool Less_Equal(IntValue&);
    bool Equal(IntValue&);
    
    bool Signed_Less(IntValue&);
    bool Signed_Greater(IntValue&);
    bool Signed_Less_Equal(IntValue&);
    bool Signed_Greater_Equal(IntValue&);

    // bit-field.
    bool Get_Bit(int idx);
    void Set_Bit(int idx, bool v);

  };



  // sign + characteristic (exponent) + mantissa.
  class FloatValue: public Value
  {
  public:
    union
    {
      float _float_value;
      double _double_value;
    } data;

    int _characteristic_width;
    int _mantissa_width;

    FloatValue(int characteristic_width, int mantissa_width);
    FloatValue(int characteristic_width, int mantissa_width, string float_value);

    bool Is_float32()
    {
      return((_characteristic_width == 8) && (_mantissa_width == 23));
    }

    bool Is_double64()
    {
      return((_characteristic_width == 11) && (_mantissa_width == 52));
    }

    // assignment operator
    void Swap(const FloatValue& v)
    {
      _characteristic_width = v._characteristic_width;
      _mantissa_width = v._mantissa_width;
      if(this->Is_float32())
	data._float_value = v.data._float_value;
      else if(this->Is_double64())
	data._double_value = v.data._double_value;

    }
    FloatValue& operator=(FloatValue v)
    {
      this->Swap(v);
      return(*this);
    }

    // +=, *=, -=
    void Add(FloatValue&) ;
    void Multiply(FloatValue&) ;
    void Subtract(FloatValue&) ;
    void Divide(FloatValue&) ;


    bool Greater( FloatValue& t);
    bool Less_Than( FloatValue& t);
    bool Greater_Equal( FloatValue& t);
    bool Less_Equal( FloatValue& t);
    bool Equal( FloatValue& t);

    void Assign(FloatValue& t);

    void To_Integer(IntValue&);

    virtual string To_String();

  };


} // namespace _base_value_
#endif // Value

