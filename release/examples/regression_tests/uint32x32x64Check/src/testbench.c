#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif

void Split (uint64_t A, uint32_t* A_H, uint32_t* A_L)
{
	uint64_t Alow = ((A << 32) >> 32);
	uint64_t Ahigh = (A >> 32);

	*A_H = Ahigh;
	*A_L = Alow;
}

int main(int argc, char* argv[])
{
	uint8_t err = 0;

	uint32_t A, B;	

	A = 291; B = 1;

	uint64_t uP64 = umul32_check (A,B);
	int pp, pn, np, nn;

	pp = 0;
	pn = 0;
	np = 0;
	nn = 0;

	pp++;

	if(uP64 != A)
	{
		fprintf(stderr,"Error: 291/1 = %d, expected 291\n", (uint32_t) uP64);
		err = 1;
	}

	uint64_t sP64 = smul32_check (A,B);
	if(sP64 != A)
	{
		fprintf(stderr,"Error: signed 291/1 = %d, expected 291\n", (uint32_t) sP64);
		err = 1;
	}

	int I;
	for(I=0; I < 1024; I++)
	{
		int u = rand(); int v = rand();

		A = (((uint32_t) u) << 1) + (u&0x1);
		B = (((uint32_t) v) << 1) + (v&0x1);

		uint32_t sA = (A & 0x80000000);
		uint32_t sB = (B & 0x80000000);

		if(sA && sB)
			nn++;
		else if(sA && !sB)
			np++;
		else if(!sA && sB)
			pn++;
		else
			pp++;

		uP64 = umul32_check (A, B);
		uint64_t eR = ((uint64_t) A)*((uint64_t) B);
		uint32_t eR_H, eR_L, P64_H, P64_L;

		Split(eR, &eR_H, &eR_L);
		Split(uP64, &P64_H, &P64_L);

		if(eR != uP64)
		{
			fprintf(stderr,"Error: %x X %x = (%x,%x), expected (%x,%x)\n", A,B, P64_H, P64_L,
										eR_H, eR_L);
			err = 1;
		}
		else
		{
			fprintf(stderr,".");
		}

		sP64 = smul32_check (A, B);
		eR = (uint64_t) (((int64_t) ((int32_t) A))*((int64_t) ((int32_t) B)));

		Split(eR, &eR_H, &eR_L);
		Split(sP64, &P64_H, &P64_L);

		if(eR != sP64)
		{
			fprintf(stderr,"Error: signed %x X %x = (%x,%x), expected (%x,%x)\n", A,B, 
										P64_H, P64_L,
										eR_H, eR_L);
			err = 1;
		}
		else
			fprintf(stderr,".");

		fprintf(stderr,"Tested %x, %x      signs=%x,%x\n", A, B, sA, sB);
	}
	fprintf(stderr,"\n");

	
	if(err)
		fprintf(stderr,"There were errors. FAILED.\n");
	else
	{
		fprintf(stderr,"Finished: pp=%d, pn=%d, np=%d, nn=%d\n",pp,pn,np,nn);
	}
	
	return(err);
}
