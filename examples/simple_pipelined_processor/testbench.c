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


void run(); 
#ifdef SW
void fetch(); 
void decode(); 
void execute(); 
#endif

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *run_(void* args)
{
	run();
} 
 
#ifdef SW
void *fetch_(void* args)
{
	fetch();
} 

void *decode_(void* args)
{
	decode();
} 

void *execute_(void* args)
{
	execute();
} 

#endif
int main()
{
  int idx = 5;

#ifndef SW
  // In the HW case, will need to initialize the processor memory.
  uint16_t mem[7] = {0x5105,0x5201,0xE100,0xA103,0x2112,0x9083,0x0000};
  for(idx = 0; idx < 7; idx++)
	write_to_mem(idx,mem[idx]);
#endif

  pthread_t run_t;
  pthread_create(&run_t,NULL,&run_,NULL);

#ifdef SW
  pthread_t decode_t, fetch_t, execute_t;
  pthread_create(&fetch_t,NULL,&fetch_,NULL);
  pthread_create(&decode_t,NULL,&decode_,NULL);
  pthread_create(&execute_t,NULL,&execute_,NULL);
#endif

  
  for(idx = 0; idx < 5; idx++)
  {
	fprintf(stdout,"Program output=%d\n", read_uint16("out_port"));
  }
  
  pthread_cancel(run_t);
#ifdef SW
  pthread_cancel(fetch_t);
  pthread_cancel(execute_t);
  pthread_cancel(decode_t);
#endif

  return(0); 
}
 
 
 
