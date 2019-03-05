#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif

#define __portBehaviour__(I) {\
		uint32_t in_data = read_uint32(I);\
		uint32_t port_id = (in_data >> 24);\
		if(!(port_id & 0x00000001)) \
			write_uint32("output_port_0", in_data);\
		if(port_id & 0x00000001)\
			write_uint32("output_port_1", in_data);\
	}

void inputPort_0()
{
	while(1)
	{
#ifndef SW
		__loop_pipelining_on__(8,2,1);
#endif
		__portBehaviour__("input_port_0");
	}
}

void inputPort_1()
{
	while(1)
	{
#ifndef SW
		__loop_pipelining_on__(8,2,1);
#endif
		__portBehaviour__("input_port_1");
	}
}
