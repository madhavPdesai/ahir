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
#ifndef Aa_Delays_h__
#define Aa_Delays_h__

// delays of different operations.
#define TO_FLOAT_CONVERSION_DELAY    	 	 10
#define TO_INTEGER_CONVERSION_DELAY 	  	  1
#define BINARY_INTEGER_OPERATION_DELAY   	  1
#define UNARY_INTEGER_OPERATION_DELAY    	  1
#define BINARY_FLOAT_OPERATION_DELAY             14
#define MEMORY_ACCESS_DELAY              	  4
#define PIPE_ACCESS_DELAY		          1 
#define ADDRESS_CALCULATION_DELAY		  2
#define TERNARY_OPERATION_DELAY			  1
#define INTERLOCK_DELAY				  1
#define PHI_OPERATOR_DELAY			  1

#endif
