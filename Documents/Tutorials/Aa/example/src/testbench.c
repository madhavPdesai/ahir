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
#endif

void maxDaemon();


int main(int argc, char* argv[])
{
	while(1)
	{
		uint32_t a, b;
		scanf("%d", &a);
		scanf("%d", &b);
		write_uint32("in_data",a);
		write_uint32("in_data",b);
		uint32_t c = read_uint32("out_data");
		fprintf(stdout,"Result = %d.\n", c);

		if(a == 0)
			break;
	}

	return(0);
}

