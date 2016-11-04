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
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>

void Sender()
{
	uint32_t word;
	for(word = 0; word < 10; word++)
	{
		write_uint32("test_fifo",word);
		fprintf(stdout,"Sent:fifo: %d\n", word);
		write_float32("test_lifo",(float)word);
		fprintf(stdout,"Sent:lifo: %f\n", (float) word);
	}
}

void Receiver()
{
	uint32_t word;
	float fword;
        uint32_t idx;
	for(idx = 0; idx < 10; idx++)
	{
		fword = read_float32("test_lifo");
		fprintf(stdout,"Received:lifo: %f\n", fword);

		word = read_uint32("test_fifo");
		fprintf(stdout,"Received:fifo: %d\n", word);
	}
}

int main(int argc, char* argv[])
{
        init_pipe_handler();
	register_pipe("test_fifo",32,32, 0);// last arg = 1 => FIFO
	register_pipe("test_lifo",32,32, 1);// last arg = 1 => LIFO

	Sender(); // write 10 words into both pipes.
	Receiver(); // read back 10 words from both pipes.

        close_pipe_handler();
}
