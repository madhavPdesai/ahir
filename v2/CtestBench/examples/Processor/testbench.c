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
#include <iolib.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>


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
  int idx = 5;

  pthread_t run_t;

  pthread_create(&run_t,NULL,&run_,NULL);
  while(idx >= 0)
  {
	fprintf(stdout,"Program output=%d\n", read_uint16("out_port"));
	idx--;
  }
  
  pthread_join(run_t,NULL);

  return(0); 
}
 
 
 
