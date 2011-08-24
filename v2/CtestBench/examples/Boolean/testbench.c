#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
//
// the next two inclusions are
// to be used in the software version
//  
#include <iolib.h>
#include "prog.h"
//
//
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}



int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

 	fprintf(stdout,"0 xor 0 = %d\n", xor2(0,0));
 	fprintf(stdout,"0 xor 1 = %d\n", xor2(0,1));
 	fprintf(stdout,"1 xor 1 = %d\n", xor2(1,1));
 	fprintf(stdout,"1 xor 0 = %d\n", xor2(1,0));
}
