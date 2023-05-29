#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "Pipes.h"
#ifdef AA2C
#include "pipeHandler.h"
#include "shift_register_lib_shift_reg_4.h"
#else
#include "SockPipes.h"
#endif

int test_length = 16;

int main (int argc, char* argv[])
{
	fprintf(stderr,"Usage: %s <test-length (default 16)>\n", argv[0]);

	if(argc > 1)
		test_length = atoi(argv[1]);

#ifdef AA2C
	init_pipe_handler_with_log("pipeHandler.log");
	shift_register_lib_start_daemons(NULL,0);	
#endif

	uint32_t I;
	for(I = 0; I < test_length; I++)
	{
#ifdef AA2C
		write_uint32("in_data",I);
		uint32_t J = read_uint32("out_data");
#else
		sock_write_uint32("in_data",I);
		uint32_t J = sock_read_uint32("out_data");
#endif

		if(J != I)
		{
			fprintf(stderr,"Error: expected 0x%x, received 0x%x\n", I, J);
		}
	}
	fprintf(stderr,"All done.\n");
}

