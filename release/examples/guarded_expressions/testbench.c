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

uint32_t test_prog(uint32_t a, uint32_t b, uint8_t sel);
uint32_t test_prog_alt(uint32_t a, uint32_t b, uint8_t sel);

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t a = 19;
	uint32_t b = 21;

	uint32_t d = test_prog(a,b,1);
	uint32_t d_alt = test_prog_alt(a,b,1);
	uint32_t c = test_prog(a,b,0);
	uint32_t c_alt = test_prog_alt(a,b,0);

	fprintf(stdout,"c=%d, d=%d, c_alt = %d, d_alt=%d\n",c,d,c_alt,d_alt);
}
