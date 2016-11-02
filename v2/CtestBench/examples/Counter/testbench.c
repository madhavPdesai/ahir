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
#include "vhdlCStubs.h"
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *counter_(void* fargs)
{
   counter();
}

void *write_pipe_(void* a)
{
	write_uint8_n("in_data",(uint8_t*)a, 4);
}

void *read_pipe_(void* a)
{
	read_uint8_n("out_data", (uint8_t*)a, 4);
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t pipe_in[4], pipe_out[4];
        int i;

	pipe_in[0] = 0;
        for(i = 1; i < 4; i++)
		pipe_in[i] = 1;

	// in parallel, start foo and bar.
	pthread_t counter_t, wpipe_t, rpipe_t, rpipe_valid_t;

	//
	// No need to start counter... it is an auto-run
	// module..
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)pipe_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)pipe_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);


 	fprintf(stdout,"from out_data, we read ");
        for(i = 0; i < 4; i++) 
 	   fprintf(stdout," %d\n ",  pipe_out[i]);
	fprintf(stdout,"\n");

}
