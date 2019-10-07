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
#else
#include "aa_c_model.h"
#endif

#define ORDER 256

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}
	

void Sender()
{
	int idx;
	uint8_t val[ORDER];
	for(idx = 0; idx < ORDER; idx++)
	{
		val[idx] = idx;
	}
	write_uint8_n("in_data",val,ORDER);
}
DEFINE_THREAD(Sender)

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

#ifdef SW
	start_daemons(NULL,0);
#endif
	int idx;
	uint8_t err = 0;
	for(idx = 0; idx < ORDER; idx++)
	{
		uint8_t abit = (idx == 255);
		uint8_t obit = (idx != 0);
  		uint8_t xbit = ((idx & 0x1) ^ ((idx >> 1) & 0x1) 
  				^ ((idx >> 2) & 0x1) 
  				^ ((idx >> 3) & 0x1) 
  				^ ((idx >> 4) & 0x1) 
  				^ ((idx >> 5) & 0x1) 
  				^ ((idx >> 6) & 0x1) 
  				^ ((idx >> 7) & 0x1));

		uint8_t ev = (abit << 2) | (obit << 1) | xbit;
			
		uint8_t rv = read_uint8("out_data");
		if(rv != ev)
		{
			fprintf(stderr,"Error: %d. Result = %x, Expected = %x\n", idx, rv, ev);
			err = 1;
		}
	}
	if(err == 0)
		fprintf(stderr,"Success.\n");

#ifndef SW
	PTHREAD_CANCEL(Sender);
#endif

	return(0);
}
