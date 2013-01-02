#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include "vhdlCStubs.h"

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

uint32_t asum();

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t result = asum();	
	fprintf(stdout,"result = %d.\n", result);

	return(0);
}
