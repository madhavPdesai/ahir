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
#include <unistd.h>
#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>

#define DEPTH     1

int TSIZE = 10000;
void Sender()
{
	uint32_t word;
	for(word = 0; word < TSIZE; word++)
	{
		write_uint32("S_to_R",word);
	}
	fprintf(stderr,"Info: Sender done.\n");
}

void Receiver()
{
	uint32_t word;
	uint32_t I;
	for(I = 0; I < TSIZE; I++)
	{

		word = read_uint32("S_to_R");
		if(word != I)
		{
			fprintf(stderr,"Error: Receiver received incorrect word: %d (expected %d).\n", word, I);
		}
	}
	fprintf(stderr,"Info: Receiver done.\n");
}

DEFINE_THREAD(Sender);
DEFINE_THREAD(Receiver);

int main(int argc, char* argv[])
{
	if(argc > 1)
	{
		TSIZE = atoi(argv[1]);
	}

	fprintf(stderr,"Info: Test-size = %d.\n", TSIZE);

        init_pipe_handler();
	register_pipe("S_to_R",DEPTH,32, 0);
	register_pipe("R_to_S",DEPTH,32, 0);

	PTHREAD_DECL(Receiver);
	PTHREAD_CREATE(Receiver);


	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);

	PTHREAD_JOIN(Sender);
	PTHREAD_JOIN(Receiver);
	close_pipe_handler();
}
