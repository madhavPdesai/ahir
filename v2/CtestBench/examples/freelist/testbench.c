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
//
// the next two inclusions are
// to be used in the software version
//  
#include <iolib.h>
#include "prog.h"
//
//
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *free_queue_manager_(void* fargs)
{
   free_queue_manager();
}

void *foo_(void* fargs)
{
   foo();
}

void *input_module_(void* fargs)
{
   input_module();
}

void *output_module_(void* fargs)
{
   output_module();
}

void *write_pipe_(void* a)
{
	write_uint32_n("input_data",(uint32_t*)a, 10);
}

void *read_pipe_(void* a)
{
	read_uint32_n("output_data", (uint32_t*)a, 10);
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
  	signal(SIGSEGV, Exit);

	uint32_t pipe_in[10], pipe_out[10];
        int i;

        for(i = 0; i < 10; i++)
		pipe_in[i] = i;

	// in parallel, start foo and bar.
	pthread_t input_module_t,output_module_t,free_queue_manager_t,foo_t,wpipe_t, rpipe_t;

	pthread_create(&input_module_t,NULL,&input_module_,NULL);
	pthread_create(&output_module_t,NULL,&output_module_,NULL);
	pthread_create(&free_queue_manager_t,NULL,&free_queue_manager_,NULL);
	pthread_create(&foo_t,NULL,&foo_,NULL);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)pipe_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);

	pthread_cancel(input_module_t);
	pthread_cancel(output_module_t);
	pthread_cancel(free_queue_manager_t);
	pthread_cancel(foo_t);

 	fprintf(stdout,"from output_data, we read ");
        for(i = 0; i < 10; i++) 
 	   fprintf(stdout," %d ", pipe_out[i]);
	fprintf(stdout,"\n");
}
