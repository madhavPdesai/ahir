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
#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <prog.h>

int stack_size = 0;
#define PUSH__(x) { write_uint32("eval_stack",x); stack_size++; }
#define POP__(x) { if(stack_size > 0) { x = read_uint32("eval_stack");  stack_size--;} else \
		x = 0; }

void accumulate()
{

    stack_size = 0;
    while(1)
    {
	uint8_t  op = read_uint8("in_op");
	uint32_t data = read_uint32("in_data");
#ifdef SW
#ifdef DEBUG
	printf("read %d, %d\n", data, op);
#endif
#endif
        int32_t op1, op2;
	switch(op)
	{
		case _PUSH : 
			PUSH__(data)
#ifdef SW
#ifdef DEBUG
	printf("pushed %d\n", data);
#endif
#endif
			break;
		case _ADD :
			POP__(op1);
			POP__(op2);
			PUSH__(op1+op2);
#ifdef SW
#ifdef DEBUG
	printf("popped %d %d, pushed %d\n",op1,op2,op1+op2 );
#endif
#endif
			break;
		case _SUB :
			POP__(op1);
			POP__(op2);
			PUSH__(op2-op1);
#ifdef SW
#ifdef DEBUG
	printf("popped %d %d, pushed %d\n",op1,op2,op1-op2 );
#endif
#endif
			break;
		case _MUL :
			POP__(op1);
			POP__(op2);
			PUSH__(op1*op2);
#ifdef SW
#ifdef DEBUG
	printf("popped %d %d, pushed %d\n",op1,op2,op1*op2 );
#endif
#endif
			break;
		case _POP :
			POP__(op1);
			write_uint32("out_data", op1);
#ifdef SW
#ifdef DEBUG
			printf("popped %d\n", op1);
#endif
#endif
			break;
		default:
			break;
	}
    }
}

