#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#else
#include "aa_c_model.h"
#endif


int main(int argc, char* argv[])
{
#ifdef SW
	init_pipe_handler();
	start_daemons(NULL,0);
#endif
	while(1)
	{
		float a;
		scanf("%f", &a);
		write_float32("in_data",a);
		float c = read_float32("out_data");
		fprintf(stdout,"Result = %f.\n", c);

		if(a == 0.0)
			break;
	}
	return(0);
}

