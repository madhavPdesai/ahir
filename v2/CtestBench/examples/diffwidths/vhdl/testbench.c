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
#include <SocketLib.h>
#include "prog.h"
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


// all pipes are 32 bits wide.
void *write_pipe_(void* a)
{
	write_uint32_n("inpipe",(uint32_t*)a, 4);
}

void *read_pipe_(void* a)
{
	read_uint8_n("outpipe", (uint8_t*)a, 14);
}

int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint8_t packet_in[16]; // multiple of 4, because we will be sending as uint32_t
        uint8_t packet_out[14]; // need not be a multiple of 4, because we will be receiving as uint8_t
        int i;

	*((uint32_t*)packet_in) = 10; // packet length
        for(i = 4; i < 14; i++)
		packet_in[i] = i-4;

	// in parallel, start foo and bar.
	pthread_t io_module_t, wpipe_t, rpipe_t;

	//pthread_create(&io_module_t,NULL,&io_module_,NULL);
	pthread_create(&wpipe_t,NULL,&write_pipe_,(void*)packet_in);
	pthread_create(&rpipe_t,NULL,&read_pipe_,(void*)packet_out);


	pthread_join(wpipe_t,NULL);
	pthread_join(rpipe_t,NULL);


 	fprintf(stdout,"from outpipe, we read ");
	int packet_length =  *((uint32_t*) packet_out);
	fprintf(stdout,"packet-length=%d ", packet_length);
        for(i = 4; i < 4 + packet_length; i++) 
 	   fprintf(stdout," %#x ", packet_out[i]);
	fprintf(stdout,"\n");

	//pthread_cancel(io_module_t);
}
