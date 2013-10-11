#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "prog.h"
#ifdef SW
#include <Pipes.h>
#include <pipeHandler.h>
#else
#include "vhdlCStubs.h"
#endif

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

float bug(float a, float b)
{
	return(fpsub(a,b));
}

// usage: testbench [rng-seed] [num-tests]
// both rng-seed and num-tests should be positive integers.
int main(int argc, char* argv[])
{

	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);

#ifdef BUG
	uint32_t ubuga = 0x3e2ae850;
        uint32_t ubugb = 0x40854861;

	float buga = *((float*) &ubuga);
	float bugb = *((float*) &ubugb);

	float bugc = bug(buga,bugb);
	float ebugc = buga - bugb;

	fprintf(stdout,"Info: bug result = %f (%x), expected %f (%x).\n",
			bugc, *((uint32_t*)&bugc), ebugc, *((uint32_t*)&ebugc));
	
	return(0);
#endif
	
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


#ifdef MUL
		hZ = fpmul(X,Y);
		sZ = (X*Y);
		if(hZ != sZ)
		{

			fprintf(stdout,"Error: %f * %f = %f, expected %f.\n", X,Y,hZ,sZ);
			fprintf(stdout,"Error:  %x * %x = %x, expected %x.\n", *((uint32_t*) &X),
					*((uint32_t*) &Y),
					*((uint32_t*) &hZ),
					*((uint32_t*) &sZ));
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: %f * %f = %f.\n", X,Y,hZ);
			fprintf(stdout,"Info:  %x * %x = %x.\n", *((uint32_t*) &X),
					*((uint32_t*) &Y),
					*((uint32_t*) &hZ));
		}
#endif



#ifdef ADD
		hZ = fpadd(X,Y);
		sZ = (X + Y);
		if(hZ != sZ)
		{
			fprintf(stdout,"Error: %f + %f = %f, expected %f.\n", X,Y,hZ,sZ);
			fprintf(stdout,"Error: %x + %x = %x, expected %x.\n", *((uint32_t*) &X),
					*((uint32_t*) &Y),
					*((uint32_t*) &hZ),
					*((uint32_t*) &sZ));
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: %f + %f = %f.\n", X,Y,hZ);
			fprintf(stdout,"Info:  %x + %x = %x.\n", *((uint32_t*) &X),
					*((uint32_t*) &Y),
					*((uint32_t*) &hZ));
		}

		hZ = fpincr(X);
		sZ = (X + 1.0);
		if(hZ != sZ)
		{
			fprintf(stdout,"Error: %f + 1.0 = %f, expected %f.\n", X,hZ,sZ);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: %f + 1.0 = %f.\n", X,hZ);
		}

#endif

#ifdef SUB

		hZ = fpsub(X,Y);
		sZ = (X - Y);
		if(hZ != sZ)
		{
			fprintf(stdout," %f - %f = %f, expected %f.\n", X,Y,hZ,sZ);
			fprintf(stdout," %x - %x = %x, expected %x.\n", *((uint32_t*) &X),
					*((uint32_t*) &Y),
					*((uint32_t*) &hZ),
					*((uint32_t*) &sZ));
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: %f - %f = %f.\n", X,Y,hZ);
			fprintf(stdout,"Info:  %x - %x = %x.\n", *((uint32_t*) &X),
					*((uint32_t*) &Y),
					*((uint32_t*) &hZ));
		}

#endif


#ifdef DOT


		hZ = dotProduct(X,Y,X,Y,X,Y,X,Y);
		sZ = (X*Y) + (X*Y) + (X*Y) + (X*Y);
		if(hZ != sZ)
		{
			fprintf(stdout," dotProduct = %f, expected %f\n ", hZ,sZ);
			fprintf(stdout," dotProduct = %x, expected %x\n ", *((uint32_t*) &hZ),
					*((uint32_t*) &sZ));
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: dot-product ok.\n");	
		}

#endif

#ifdef CMP

		uint8_t cmpresult;
		cmpresult = fpcmplt(X,Y);
		if(cmpresult != (X < Y))
		{
			fprintf(stdout,"Error: (%f < %f) = %d, expected %d.\n", X,Y, cmpresult,(X<Y));
			err_flag = 1;
		}
		else
			fprintf(stdout,"Info: (%f < %f) = %d.\n", X,Y, cmpresult);


		cmpresult = fpcmpgt(X,Y);
		if(cmpresult != (X > Y))
		{
			fprintf(stdout,"Error: (%f > %f) = %d, expected %d.\n", X,Y, cmpresult,(X>Y));
			err_flag = 1;
		}
		else
			fprintf(stdout,"Info: (%f > %f) = %d.\n", X,Y, cmpresult);


		cmpresult = fpcmpeq(X,Y);
		if(cmpresult != (X == Y))
		{
			fprintf(stdout,"Error: (%f == %f) = %d, expected %d.\n",X,Y, cmpresult,(X==Y));
			err_flag = 1;
		}
		else
			fprintf(stdout,"Info: (%f == %f) = %d.\n", X,Y, cmpresult);

		cmpresult = fpcmpeq(X,X);
		if(cmpresult != 1)
		{
			fprintf(stdout,"Error: (%f == %f) = %d, expected %d.\n",X,X, cmpresult,(X==X));
			err_flag = 1;
		}
		else
			fprintf(stdout,"Info: (%f == %f) = %d.\n", X,X, cmpresult);

#endif

	}

	if(err_flag)
		fprintf(stdout,"TESTS FAILED: there were errors.\n");
	else
		fprintf(stdout,"TESTS SUCCEEDED.\n");

}

