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
#include <vhdlCStubs.h>


#define N 10

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

typedef struct RWArgs_ RWArgs;
struct RWArgs_
{
	int n;
	int* list;
};

void *write_(void* fargs)
{
	RWArgs* u = (RWArgs*) fargs;
	int i;
	for(i = 0; i < u->n; i++)
	{
		write_uint32("inpipe",u->list[i]);
	}
}

void *read_(void* fargs)
{
	RWArgs* u = (RWArgs*) fargs;
	int i;
	for(i = 0; i < u->n; i++)
	{
		u->list[i]  = read_uint32("outpipe");
	}
}

void *start_(void* fargs)
{
  start(*((int*) fargs));
}



int main(int argc, char* argv[])
{

	int list_size = N;
	int inputs[N];
	int outputs[N];

	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	int pipe_in, pipe_out;
		
	int i;
	int n;

	fprintf(stderr,"Specify %d numbers\n", N);
	for(i = 0; i < N; i++)
	{
		fscanf(stdin,"%d", &(inputs[i]));
	}

	RWArgs in_args;
	in_args.n = N;
	in_args.list = inputs;

	RWArgs out_args;
	out_args.n = N;
	out_args.list = outputs;

	pthread_t start_t, write_t, read_t;


	pthread_create(&start_t,NULL,&start_,&list_size);
	pthread_create(&write_t,NULL,&write_,&in_args);
	pthread_create(&read_t,NULL,&read_,&out_args);

	pthread_join(start_t,NULL);
	pthread_join(write_t,NULL);
	pthread_join(read_t,NULL);

	for(i=0; i< N; i++)
	{
		fprintf(stdout,"%d\n",outputs[i]);
	}

	return(0);
}
