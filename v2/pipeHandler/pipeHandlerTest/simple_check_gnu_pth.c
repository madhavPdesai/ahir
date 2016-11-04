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
#include <pth.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>


// shows the use of the pipeHandler.
int main(int argc, char* argv[])
{

	pth_init();

	// must be initialized before doing anything
        init_pipe_handler();

	// register a FIFO pipe test_pipe with
	// depth 32, word-width 32.
	register_pipe("test_pipe",32,32,0);
	register_pipe("test_pipe_64",1,64,0);

	// write a integer to test_pipe.
	write_uint32("test_pipe",1);
	uint64_t tmp = 1;
	tmp = tmp | (tmp << 32);
	write_uint64("test_pipe_64",tmp);

	// read back and print integer.
	uint32_t v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received uint32_t %d\n", v);

	uint64_t v64 = read_uint64("test_pipe_64");
	fprintf(stderr,"TEST: received uint64_t %llu\n", v64);

	// write another integer
	write_uint32("test_pipe",1);

	// read back and print integer.
	v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received %d\n", v);

	// close the handler.
        close_pipe_handler();
        return(0);
}
