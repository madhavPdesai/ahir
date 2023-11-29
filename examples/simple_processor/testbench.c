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
#include <pipeHandler.h>
#else
#include "vhdlCStubs.h"
#endif


void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

#ifdef SW
void run(); 
void *run_(void* args)
{
	run();
} 
#endif
 

void write_to_mem(uint16_t mem_addr, uint16_t mem_data);

int main()
{
  int idx; 

#ifndef SW
  // In the HW case, will need to initialize the processor memory.
  uint16_t altmem[11] = {0x5100,0x5200,0x5300,0x1123,0x1123,0x1123,0x1123,0x1123,0x1123,0x1123,0x1123};
  uint16_t mem[7] = {0x5105,0x5201,0xE100,0xA103,0x2112,0x9083,0x0000};
  for(idx = 0; idx < 11; idx++)
	write_to_mem(idx,altmem[idx]);
  for(idx = 0; idx < 7; idx++)
	write_to_mem(idx+11,mem[idx]);

  write_uint8("start_ifetch",1);
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
 
 
 
