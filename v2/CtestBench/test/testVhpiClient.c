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
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <SocketLib.h>
#include "vhdlCStubs.h"

#define N 16

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}



typedef struct _FnArgs FnArgs;
struct _FnArgs
{
	int a;
	int* ret_val;
};

void *foo_(void* fargs)
{
   *(((FnArgs*)fargs)->ret_val) = foo(((FnArgs*)fargs)->a);
}

void *write_pipe_(void* a)
{
  write_uint32_n("inpipe",(uint32_t*)a, N);
}

void *read_pipe_(void* a)
{
  read_uint32_n("outpipe",(uint32_t*) a, N);
}


// starts foo, sends N numbers to inpipe and
// reads back N numbers from outpipe
int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
	
	int i;

	uint32_t pipe_in[N];
	uint32_t pipe_out[N];

	int  seed, foo_ret;

        // some random number..
	seed = 593;

	for(i=0; i < N; i++)
	  {
	    pipe_in[i] = seed + i;
	  }

	// in parallel, start foo and bar.
	pthread_t foo_t, wpipe_t, rpipe_t;
	FnArgs foo_args;

	foo_args.a = seed;
	foo_args.ret_val = &foo_ret;

	pthread_create(&foo_t,NULL,&foo_,(void*)&foo_args);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)&pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)&pipe_out);


	pthread_join(foo_t,NULL);
	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);

	fprintf(stdout,"foo returns %d\n", foo_ret);
 	fprintf(stdout,"from outpipe, we read ");
	for(i = 0; i < N; i++)
	  fprintf(stdout," %d", pipe_out[i]);

	fprintf(stdout,"\n");
}
