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
#ifndef _Aa_Util__
#define _Aa_Util__
#include <AaIncludes.h>
#include <AaEnums.h>

// Tab string
string Tab_(unsigned int n);

// IntToStr
string IntToStr(int x);
string Int64ToStr(int64_t x);
string UintToStr(uint32_t x);
string Uint64ToStr(uint64_t x);

// string compare
struct StringCompare:public binary_function
  <string, string, bool >
{
  bool operator() (string, string) const;
};

int CeilLog2(int n);
int nAddressBits(int n);

uint32_t uLog2(uint32_t n);


bool Is_Compare_Operation(AaOperation op);
bool Is_Shift_Operation(AaOperation op);
bool Is_Bitsel_Operation(AaOperation op);
bool Is_Concat_Operation(AaOperation op);


string C_Name(AaOperation op);
string Aa_Name(AaOperation op);

string To_Alphanumeric(string x);

int GCD(set<int>& s);
string Augment_Hier_Id(string hid, string suffix);
uint32_t IntPower(uint32_t A, uint32_t B); // A**B

string Replace_Dollar (string x);



#endif
