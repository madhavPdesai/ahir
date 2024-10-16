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
#include <Value.hpp>
using namespace std;
using namespace _base_value_;

int main()
{
  Unsigned b(4,"_b0010");
  cout <<  "b = " << b.To_String() << endl;
  Unsigned a(4,"_b0011");
  cout <<  "a = " << a.To_String() << endl;

  bool eq = b.Equal(b);
  cout <<  "(" << b.To_String() << " == " << b.To_String() << ") = " << (eq ? "true" : "false") << endl;
  bool grtr = a.Greater(b);
  cout <<  "(" << a.To_String() << " > " << b.To_String() << ") = " << (grtr ? "true" : "false") << endl;
  bool ngrtr = b.Greater(a);
  cout <<  "(" << b.To_String() << " > " << a.To_String() << ") = " << (ngrtr ? "true" : "false") << endl;
  bool lessthan = b.Less_Than(a);
  cout <<  "(" << b.To_String() << " < " << a.To_String() << ") = " << (lessthan ? "true" : "false") << endl;
  bool nlessthan = a.Less_Than(b);
  cout <<  "(" << a.To_String() << " < " << b.To_String() << ") = " << (lessthan ? "true" : "false") << endl;


  cout << "Word-size is " << __WORD_SIZE__ << endl;
  cout << a.To_String() << " a" << endl << b.To_String() << " b" << endl;
  a.Add(b);
  cout << a.To_String() << " a = a + b " <<  endl;
  a.Subtract(b);
  cout << a.To_String() <<  " a = a - b " << endl;
  a.Multiply(b);
  cout << a.To_String() << " a = a*b " << endl;
  a.Divide(b);
  cout << a.To_String() << " a = a/b " << endl;

  a.Concatenate(b);
  cout << a.To_String() << " a = Concatenate(a,b) " << endl;
  a.Concatenate(b);
  cout << a.To_String() << " a = Concatenate(a,b) " << endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " << " width " << a._width <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " << " width " << a._width <<  endl;
  a.Concatenate(b);
  cout << a.To_String() <<" a = Concatenate(a,b) " << " width " << a._width <<  endl;
 

  Unsigned one_val(68);
  one_val.Increment();
  a.Add(one_val);
  cout << a.To_String() << " a = a + 1" << endl;
  a.Decrement();
  cout << a.To_String() << " a = a - 1 " << endl;
  a.Complement();
  cout << a.To_String() << " a = (~a)  " << endl;
  a.Complement();
  cout << a.To_String() << " a = (~a)  " << endl;


  a.Rotate_Left();
  cout << a.To_String() << " a = ROL(a) " << endl;

  a.Rotate_Right();
  cout << a.To_String() << " a = ROR(a)" << endl;

  a.Rotate_Right();
  cout << a.To_String() << " a = ROR(a)" << endl;

  Signed sa (a._width);
  sa.Assign(a);

  sa.Shift_Right();
  cout << sa.To_String() << " sa = SHRA(a)" << endl;


  Float c(8,23,"2.5");
  Float d(8,23,"5.0");
 

  c.Add(d);
  cout << c.To_String() << endl;
  c.Subtract(d);
  cout << c.To_String() << endl;
  c.Multiply(d);
  cout << c.To_String() << endl;
  c.Divide(d);
  cout << c.To_String() << endl;

  Float e(11,52,"247.5");
  c.Assign(e);
  cout << c.To_String() << endl;

  Float f(11,52,"_b10101001");
  cout << f.To_String() << endl;
  fprintf(stdout,"expected a9, got %llx\n", (uint64_t) *((uint64_t*) &(f.data._double_value)));

  Float g(8,23, "_ha9");
  cout << g.To_String() << endl;
  fprintf(stdout,"expected a9, got %x\n", (uint32_t) *((uint32_t*) &(g.data._float_value)));

  Float h(8,23, "_b0");
  cout << h.To_String() << endl;
  fprintf(stdout,"expected 0, got %x\n", (uint32_t) *((uint32_t*) &(h.data._float_value)));


   // bitcast.
   Unsigned ug(32);
   g.Bit_Cast_Into(ug);
   cout << "bitcast " << g.To_String() << " = " << ug.To_String() << endl;

   Unsigned sug(8);
   sug.Slice(ug, 31, 24);
   cout << "slice " << ug.To_String() << "[31:24] = " << sug.To_String() << endl;


   
   Unsigned ssug(8, "_b10000000");
   Unsigned pssug(8);
   vector<pair<int,int> > tp;
   tp.push_back(pair<int,int>(7,0));
   tp.push_back(pair<int,int>(0,7));
   pssug.Bitmap(ssug,tp);
   cout << "permute 7 <-> 0 " << ssug.To_String() << " = " << pssug.To_String() << endl;

  return(1);
}
