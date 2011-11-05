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

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint32_t a = 0x0011223344556677;
	uint32_t b, c;

 	b = byteswap32(a);
 	fprintf(stdout,"%x -> %x", a, b);
	fprintf(stdout,"\n");

 	c = byteswap32_alt(a);
 	fprintf(stdout,"%x -> %x", a, c);
	fprintf(stdout,"\n");
}
