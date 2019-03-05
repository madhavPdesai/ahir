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


uint8_t mem_test();
uint8_t cam_test();


void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

	
int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);


	uint8_t mem_status = mem_test();
	uint8_t cam_status = cam_test();

	fprintf(stderr,"mem-status=%d, cam-status=%d\n", mem_status, cam_status);
	return(0);
}
