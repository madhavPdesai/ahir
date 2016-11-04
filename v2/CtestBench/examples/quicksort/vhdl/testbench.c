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
#include <SocketLib.h>
#include <Vhpi.h>
#include <vhdlCStubs.h>
#include <pthread.h>
#include <signal.h>

#define N 10
void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}



void *main__(void* fargs)
{
   main_inner();
}



int main(int argc, char* argv[])
{
	int inputs[N];
	int outputs[N];
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

		
	fprintf(stderr, "specify ten numbers\n");
	int i;
	int n;
	for(i = 0; i < N; i++)
	{
		fscanf(stdin,"%d", &n);
		inputs[i] = n;
	}

	pthread_t main_t;


	pthread_create(&main_t,NULL,&main__,NULL);

	for(i = 0; i < N; i++)
		write_uint32("inpipe",inputs[i]);

	for(i = 0; i < N; i++)
		outputs[i] = read_uint32("outpipe");

	pthread_join(main_t,NULL);

	for(i=0; i< N; i++)
	{
		fprintf(stdout,"%d\n",outputs[i]);
	}

	return(0);
}
