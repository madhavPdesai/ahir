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


	double dX, dY, dhZ, dsZ;
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
		
		int32_t IVAL = rand();

		dX = drand48() / scale_factor;
		dY = drand48() * scale_factor;

		X = dX;
		Y = dY;

		scale_factor = 1.1 * scale_factor;

#ifdef FLOATRESIZE
		float fX = (float) X;
		float ffX = double_to_float (X);
		if(fX != ffX)
		{
			fprintf(stdout,"Error: (float) %le = %e, expected %e.\n", X,ffX, fX);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (float) %le = %e.\n", X,ffX);
		}

		float nfX = (float) (-X);
		float nffX = double_to_float (-X);
		if(nfX != nffX)
		{
			fprintf(stdout,"Error: (float) %le = %e, expected %e.\n", -X,nffX,nfX);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (float) %le = %e.\n", -X,nffX);
		}

		float dfX = (double) fX;
		double ddfX = float_to_double (fX);
		if(ddfX != dfX)
		{
			fprintf(stdout,"Error: (double) %e = %le, expected %le.\n", fX,ddfX, dfX);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (double) %e = %le.\n", fX,ddfX);
		}

		float ndfX = (double) -fX;
		double nddfX = float_to_double (-fX);
		if(nddfX != ndfX)
		{
			fprintf(stdout,"Error: (double) %e = %le, expected %le.\n", -fX,nddfX, ndfX);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (double) %e = %le.\n",-fX,nddfX);
		}
		

#endif


#ifdef INTTOFLOAT
		float fIVAL = int2float(IVAL);
		float rfIVAL = (float) IVAL;
		if(fIVAL != rfIVAL)
		{
			fprintf(stdout,"Error: (float) %d = %f, expected %f.\n", IVAL, fIVAL, rfIVAL);
			err_flag = 1;
		}

		double dIVAL = int2double(IVAL);
		double rdIVAL = (double) IVAL;
		if(dIVAL != rdIVAL)
		{
			fprintf(stdout,"Error: (double) %d = %le, expected %le.\n", IVAL, dIVAL, rdIVAL);
			err_flag = 1;
		}
#endif
			

#ifdef TOINT

		int32_t iY = fp2int(Y);
		int32_t eiY = (int32_t) Y;
		if(iY != eiY)
		{
			fprintf(stdout,"Error: (int32_t) %f = %d, expected %d.\n", Y,iY,eiY);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (int32_t) %f = %d.\n", Y,iY);
		}

		uint32_t uiY = fp2uint(Y);
		uint32_t ueiY = (uint32_t) Y;
		if(uiY != ueiY)
		{
			fprintf(stdout,"Error: (uint32_t) %f = %u, expected %u.\n", Y,uiY,ueiY);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (uint32_t) %f = %u.\n", Y,uiY);
		}

		iY = fpd2int(Y);
		eiY = (int32_t) ((double) Y);
		if(iY != eiY)
		{
			fprintf(stdout,"Error: (int32_t) %le = %d, expected %d.\n", ((double) Y),iY,eiY);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (int32_t) %f = %d.\n", Y,iY);
		}

		uiY = fpd2uint(Y);
		ueiY = (uint32_t) ((double) Y);
		if(uiY != ueiY)
		{
			fprintf(stdout,"Error: (uint32_t) %le = %u, expected %u.\n", ((double) Y),uiY,ueiY);
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: (uint32_t) %le = %u.\n", ((double) Y),uiY);
		}
#endif

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

		dhZ = fpmuld(dX,dY);
		dsZ = (dX*dY);
		if(dhZ != dsZ)
		{

			fprintf(stdout,"Error: %le * %le = %le, expected %le.\n", dX,dY,dhZ,dsZ);
			fprintf(stdout,"Error:  %llx * %llx = %llx, expected %llx.\n", *((uint64_t*) &dX),
					*((uint64_t*) &dY),
					*((uint64_t*) &dhZ),
					*((uint64_t*) &dsZ));
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: %le * %le = %le.\n", dX,dY,dhZ);
			fprintf(stdout,"Info:  %llx * %llx = %llx.\n", *((uint64_t*) &dX),
					*((uint64_t*) &dY),
					*((uint64_t*) &dhZ));
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

		dhZ = fpaddd(dX,dY);
		dsZ = (dX + dY);
		if(dhZ != dsZ)
		{
			fprintf(stdout,"Error: %le + %le = %le, expected %le.\n", dX,dY,dhZ,dsZ);
			fprintf(stdout,"Error: %llx + %llx = %llx, expected %llx.\n", *((uint64_t*) &dX),
					*((uint64_t*) &dY),
					*((uint64_t*) &dhZ),
					*((uint64_t*) &dsZ));
			err_flag = 1;
		}
		else
		{
			fprintf(stdout,"Info: %le + %le = %le.\n", dX,dY,dhZ);
			fprintf(stdout,"Info:  %llx + %llx = %llx.\n", *((uint64_t*) &dX),
					*((uint64_t*) &dY),
					*((uint64_t*) &dhZ));
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


#ifdef DOUBLEBUG
		double T = fpincrd(X);
		if(T != (X + 1.0))
		{
			fprintf(stdout,"Error: (%f + 1.0) = %f, expected %f.\n",X, T, X+1.0);
			err_flag = 1;
		}

#endif
	}

	if(err_flag)
		fprintf(stdout,"TESTS FAILED: there were errors.\n");
	else
		fprintf(stdout,"TESTS SUCCEEDED.\n");

}

