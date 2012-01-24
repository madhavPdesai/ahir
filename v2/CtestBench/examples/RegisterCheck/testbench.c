#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "vhdlCStubs.h"



void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t i,j, err_flag;

	err_flag = 0;

 	init();

	for(i = 0; i < 16; i++)
	{
		write_mem(i,i);
	}

	for(i = 0; i < 16; i++)
	{
		j = read_mem(i);
		if(j != i)
		{
			fprintf(stderr,"Error: expected %d, read %d\n", i,j);
			err_flag = 1;
		}
	}
			
       fprintf(stderr,"Test finished, %s\n", (err_flag ? "with errors" : "successfully"));

	return(0);
}
