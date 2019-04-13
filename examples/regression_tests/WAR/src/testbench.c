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
	float result;
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	init();
	fprintf(stdout,"init completed.\n");

	result = dot_product();	
	fprintf(stdout,"dot-product result = %f.\n", result);

	result = dot_product_unrolled();	
	fprintf(stdout,"dot-product-unrolled result = %f.\n", result);

	return(0);
}
