//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
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
 
 
 
