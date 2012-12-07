#include <pthread.h>
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

uint32_t test_prog(uint32_t a);

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t a = 19;
	uint32_t d = test_prog(a);

	fprintf(stdout,"a=%d, d=%d\n",a,d);
}
