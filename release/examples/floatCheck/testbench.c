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


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
	float X,Y;


#ifdef INTERACTIVE
 	fprintf(stdout,"Supply two numbers to multiply:\n ");
	scanf("%f %f", &X, &Y);
#else
	X = 24.8;
	Y = 19.65;
#endif


        float hZ = fpmul(X,Y);
        float sZ = (X*Y);
  	fprintf(stdout," %f * %f = %f, expected %f\n ", X,Y,hZ,sZ);
  	fprintf(stdout," %x * %x = %x, expected %x\n ", *((uint32_t*) &X),
							*((uint32_t*) &Y),
							*((uint32_t*) &hZ),
							*((uint32_t*) &sZ));
							

#ifdef INTERACTIVE
 	fprintf(stdout,"Supply two numbers to add:\n ");
	scanf("%f %f", &X, &Y);
#endif
        hZ = fpadd(X,Y);
        sZ = (X + Y);
  	fprintf(stdout," %f + %f = %f, expected %f\n ", X,Y,hZ,sZ);
  	fprintf(stdout," %x + %x = %x, expected %x\n ", *((uint32_t*) &X),
							*((uint32_t*) &Y),
							*((uint32_t*) &hZ),
							*((uint32_t*) &sZ));

        hZ = fpsub(X,Y);
        sZ = (X - Y);
  	fprintf(stdout," %f - %f = %f, expected %f\n ", X,Y,hZ,sZ);
  	fprintf(stdout," %x - %x = %x, expected %x\n ", *((uint32_t*) &X),
							*((uint32_t*) &Y),
							*((uint32_t*) &hZ),
							*((uint32_t*) &sZ));



	hZ = dotProduct(X,Y,X,Y,X,Y,X,Y);
        sZ = (X*Y) + (X*Y) + (X*Y) + (X*Y);
  	fprintf(stdout," dotProduct = %f, expected %f\n ", hZ,sZ);
  	fprintf(stdout," dotProduct = %x, expected %x\n ", *((uint32_t*) &hZ),
							*((uint32_t*) &sZ));


	uint8_t cmpresult;
	cmpresult = fpcmplt(2.0, 3.0);
  	fprintf(stdout," (2.0 < 3.0) = %d, expected %d\n ", cmpresult,1);

	cmpresult = fpcmplt(3.0, 2.0);
  	fprintf(stdout," (3.0 < 2.0) = %d, expected %d\n ", cmpresult,0);

	cmpresult = fpcmpgt(2.0, 3.0);
  	fprintf(stdout," (2.0 > 3.0) = %d, expected %d\n ", cmpresult,0);

	cmpresult = fpcmpgt(3.0, 2.0);
  	fprintf(stdout," (3.0 > 2.0) = %d, expected %d\n ", cmpresult,1);

	cmpresult = fpcmpeq(2.0, 2.0);
  	fprintf(stdout," (2.0 == 2.0) = %d, expected %d\n ", cmpresult,1);

	cmpresult = fpcmpeq(3.0, 2.0);
  	fprintf(stdout," (3.0 == 2.0) = %d, expected %d\n ", cmpresult,0);

}
   
