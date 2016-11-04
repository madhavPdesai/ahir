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
#ifndef __Aa_Enums__
#define __Aa_Enums__
#include <AaIncludes.h>

enum AaOperation
  {
    __NOT,
    __OR,
    __AND,
    __XOR,
    __NOR,
    __NAND,
    __XNOR,
    __SHL,
    __SHR,
    __ROR,
    __ROL,
    __PLUS,
    __MINUS,
    __MUL,
    __DIV,
    __EQUAL,
    __NOTEQUAL,
    __LESS,
    __LESSEQUAL,
    __GREATER,
    __GREATEREQUAL,
    __CONCAT,
    __BITSEL,
    __NOP,
    __BITMAP,
    __UNORDERED,
    __DECODE,
    __ENCODE,
    __PRIORITYENCODE,
    __BITREDUCEOR,
    __BITREDUCEAND,
    __BITREDUCEXOR,
    __POW
  };


#endif
