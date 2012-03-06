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

