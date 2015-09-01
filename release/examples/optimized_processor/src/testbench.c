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
#include <pipeHandler.h>
#ifdef SW
#include <Pipes.h>
#else
#ifndef AA2C
#include "vhdlCStubs.h"
#else
#include "aa_c_model.h"
#endif
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

 
#ifdef SW
void *run_(void* args)
{
	run();
} 

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


#ifdef SW
  init_pipe_handler();
  pthread_t run_t;
  pthread_create(&run_t,NULL,&run_,NULL);
  pthread_t decode_t, fetch_t, execute_t;
  pthread_create(&fetch_t,NULL,&fetch_,NULL);
  pthread_create(&decode_t,NULL,&decode_,NULL);
  pthread_create(&execute_t,NULL,&execute_,NULL);
#endif

#ifdef AA2C
  init_pipe_handler();
  start_daemons(stderr);
#endif

  // In the HW case, will need to initialize the processor memory.
  uint16_t mem[7] = {0x5105,0x5201,0xE100,0xA103,0x2112,0x9083,0x0000};
  for(idx = 0; idx < 7; idx++)
	write_to_mem(idx,mem[idx]);

  write_uint16("env_to_processor_start_pc", 0);
  
  for(idx = 0; idx < 5; idx++)
  {
	fprintf(stdout,"Program output=%d\n", read_uint16("out_port"));
  }

  uint8_t hlt = read_uint16("processor_to_env_halt");
  fprintf(stderr,"HALT!\n");
  
#ifdef SW
  pthread_cancel(run_t);
  pthread_cancel(fetch_t);
  pthread_cancel(execute_t);
  pthread_cancel(decode_t);
#endif

#ifdef AA2C
  stop_daemons();
#endif
  return(0); 
}
 
 
 
