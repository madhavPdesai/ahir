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
//  
#include "vhdlCStubs.h" 
//
//
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *io_module_(void* fargs)
{
   io_module();
}

void *write_pipe_(void* a)
{
	write_uint64("foo_in",*((uint64_t*)a));
	write_uint64("foo_in",*((uint64_t*)a));
}

void *read_pipe_1_(void* a)
{
	*((uint64_t*)a) = read_uint64("dest1_pipe");
}

void *read_pipe_2_(void* a)
{
	*((uint64_t*)a) = read_uint64("dest2_pipe");
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t buf_in[8], buf_out_1[8], buf_out_2[8];
        int i;

        for(i = 0; i < 8; i++)
		buf_in[i] = i;

	pthread_t io_module_t, wpipe_t, rpipe_1_t, rpipe_2_t;

	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)&buf_in);
	pthread_create(&rpipe_1_t,NULL,&read_pipe_1_,(void*)&buf_out_1);
	pthread_create(&rpipe_2_t,NULL,&read_pipe_2_,(void*)&buf_out_2);



	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_1_t,NULL);
	pthread_join(rpipe_2_t,NULL);


 	fprintf(stdout,"from dest1, we read ");
        for(i = 0; i < 8; i++) 
 	   fprintf(stdout," %x ", buf_out_1[i]);
	fprintf(stdout,"\n");
 	fprintf(stdout," %llx \n", *((uint64_t*) buf_out_1));

 	fprintf(stdout,"from dest2, we read ");
        for(i = 0; i < 8; i++) 
 	   fprintf(stdout," %x ", buf_out_2[i]);
	fprintf(stdout,"\n");
 	fprintf(stdout," %llx \n", *((uint64_t*) buf_out_2));

}
