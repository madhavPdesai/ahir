#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

int main(int argc, char* argv[])
{

	uint8_t idx;
	
	write_uint32 ("in_data", 1);
	write_uint32 ("in_data", 2);
	write_uint32 ("in_data", 3);
	write_uint32 ("in_data", 4);

        uint32_t result = read_uint32("out_data");
	fprintf(stdout,"Result = 0x%x\n", result);

	return(0);
}
