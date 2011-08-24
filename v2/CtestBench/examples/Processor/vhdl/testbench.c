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
#include "vhdlCStubs.h"


void run(); 

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *run_(void* args)
{
	run();
} 
 
int main()
{

  int idx;
  pthread_t run_t;
  uint16_t mem[7] = {0x5105,0x5201,0xE100,0xA103,0x2112,0x9083,0x0000};
  for(idx = 0; idx < 7; idx++)
	write_to_mem(idx,mem[idx]);
  
  

  pthread_create(&run_t,NULL,&run_,NULL);
  for(idx = 0; idx < 6; idx++)
  {
	fprintf(stdout,"Program output=%d\n", read_uint16("out_port"));
	idx--;
  }
  
  pthread_join(run_t,NULL);

  return(0); 
}
 
 
 
