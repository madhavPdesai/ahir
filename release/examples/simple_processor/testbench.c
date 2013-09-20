/*------------------------------------------------------------------*|
|* FILE:              cpu.c
|* DESCRIPTION:       CPU emulator
|* DATE:              2006.9.20
|* LANGUAGE PLATFORM: gcc 3.3.6 (Linux), TCC 1.01 (DOS)
|* AUTHOR:            Jeffrey A. Meunier
|* EMAIL:             jeffrey_a_meunier@yahoo.com
|*------------------------------------------------------------------*/
 
 
#include <stdio.h>
#include <stdint.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>

#ifdef SW
#include <iolib.h>
#else
#include "vhdlCStubs.h"
#endif


void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void run(); 
void *run_(void* args)
{
	run();
} 
 

void write_to_mem(uint16_t mem_addr, uint16_t mem_data);

int main()
{
  int idx; 

#ifndef SW
  // In the HW case, will need to initialize the processor memory.
  uint16_t mem[7] = {0x5105,0x5201,0xE100,0xA103,0x2112,0x9083,0x0000};
  for(idx = 0; idx < 7; idx++)
	write_to_mem(idx,mem[idx]);
#endif

#ifdef SW
  pthread_t run_t;
  pthread_create(&run_t,NULL,&run_,NULL);
#endif

  for(idx = 0; idx < 6; idx++)
  {
	fprintf(stdout,"Program output=%d\n", read_uint16("out_port"));
  }
  

#ifdef SW
  pthread_cancel(run_t);
#endif
  return(0); 
}
 
 
 
