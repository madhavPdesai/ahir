#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

#ifndef SW
// first argument: number of stages to use for pipelining a loop.
// second argument:  default buffering of operators in pipeline.
// third argument:  set to 1 if full speed (ie one iteration per cycle)
//                  is desired.
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif


void fetchDaemon()
{

	while(1)
	{
#ifndef SW
		// This cannot be a full speed pipeline because
		// indata is read twice in each iteration...etc.
		__loop_pipelining_on__(15,1,0);
#endif

		// read one pair of numbers
		uint32_t x = read_uint32("in_data_pipe");
		uint32_t y = read_uint32("in_data_pipe");
#ifdef SW
		fprintf(stderr,"Info:fetchDaemon: received 0x%x, 0x%x\n", x,y);
#endif
		// send to coprocessor 1
		write_uint32("coprocessor_in_data_1",x);
		write_uint32("coprocessor_in_data_1",y);

		// receive result from coprocessor 0
		uint32_t result_1  = read_uint32("coprocessor_out_data_1");

		// write to output...
		write_uint32("out_data_pipe",result_1);
#ifdef SW
		fprintf(stderr,"Info:fetchDaemon: sent 0x%x\n", result_1);
#endif

		// read second pair of numbers
		x = read_uint32("in_data_pipe");
		y = read_uint32("in_data_pipe");

#ifdef SW
		fprintf(stderr,"Info:fetchDaemon: received 0x%x, 0x%x\n", x,y);
#endif

		// send to coprocessor 2
		write_uint32("coprocessor_in_data_2",x);
		write_uint32("coprocessor_in_data_2",y);

		// receive result from coprocessor 2
		uint32_t result_2  = read_uint32("coprocessor_out_data_2");

		// write to output...
		write_uint32("out_data_pipe",result_2);
#ifdef SW
		fprintf(stderr,"Info:fetchDaemon: sent 0x%x\n", result_2);
#endif
	}
}

void coprocessorDaemonOne()
{
	// Can make the interior a macro so you can
	// reuse it in the other daemon.
	while (1)
	{
#ifndef SW
		// This cannot be a full speed pipeline because
		// coprocessor_in_data  is read twice in each iteration...etc.
		__loop_pipelining_on__(7,1,0);
#endif
		uint32_t x = read_uint32("coprocessor_in_data_1");
		uint32_t y = read_uint32("coprocessor_in_data_1");

		uint32_t result = (x + y);
		write_uint32("coprocessor_out_data_1",result);
#ifdef SW
		fprintf(stderr,"Info:coprocessorDaemonOne: 0x%x + 0x%x = 0x%x\n",
					x,y, result);
#endif
		

	}
}

void coprocessorDaemonTwo()
{
	while (1)
	{
#ifndef SW
		// This cannot be a full speed pipeline because
		// coprocessor_in_data  is read twice in each iteration...etc.
		__loop_pipelining_on__(7,1,0);
#endif
		uint32_t x = read_uint32("coprocessor_in_data_2");
		uint32_t y = read_uint32("coprocessor_in_data_2");

		uint32_t result = (x + y);
		write_uint32("coprocessor_out_data_2",result);
#ifdef SW
		fprintf(stderr,"Info:coprocessorDaemonTwo: 0x%x + 0x%x = 0x%x\n",
					x,y, result);
#endif
	}
}

