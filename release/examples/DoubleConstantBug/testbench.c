#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#ifdef SW
#include <Pipes.h>
#include <pipeHandler.h>
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

// usage: testbench [rng-seed] [num-tests]
// both rng-seed and num-tests should be positive integers.
int main(int argc, char* argv[])
{

	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);

	
	int rng_seed = 1023;
	if(argc > 1)
		rng_seed = atoi(argv[1]);
	
	srand48(rng_seed);

	float X,Y, hZ, sZ;
	int counter;
	int err_flag = 0;
	float scale_factor = 1.0;

	if(argc > 2) 
		counter = atoi(argv[2]);
	else
		counter = 10;


	while(counter > 0) {
		counter--;

		X = drand48() / scale_factor;
		Y = drand48() * scale_factor;
		scale_factor = 1.1 * scale_factor;


		double T = fpincrd(X);
		if(T != (X + 1.0))
		{
			fprintf(stdout,"Error: (%f + 1.0) = %f, expected %f.\n",X, T, X+1.0);
			err_flag = 1;
		}


		float fX = fpdtos(X);
		if(fX != ((float) X))
		{
			fprintf(stdout,"Error: (float(%le)  = %e, expected %e.\n",X, fX, (float)X);
			err_flag = 1;
		}
	}

	if(err_flag)
		fprintf(stdout,"TESTS FAILED: there were errors.\n");
	else
		fprintf(stdout,"TESTS SUCCEEDED.\n");

}

