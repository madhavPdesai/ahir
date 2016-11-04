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
#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

char dest1[16] = "dest1_pipe";
char dest2[16] = "dest2_pipe";

int my_strcmp(char* s1, char* s2)
{
	int i = 0;
	while((s1[i] != 0) && (s2[i] != 0))
	{	
		if(s1[i] != s2[i])
			return(1);
		i++;
	}
	return(0);
}

void pipe_dispatch_uint64(char* pipe_id, uint64_t data_val)
{
	if(my_strcmp(pipe_id,"dest1_pipe") == 0)
		write_uint64("dest1_pipe",data_val);
	else if(my_strcmp(pipe_id,"dest2_pipe") == 0)
		write_uint64("dest2_pipe",data_val);
}

void global_storage_initializer_();
void io_module()
{
    char* pipe_id;
  
    global_storage_initializer_();

    while(1)
    {
	pipe_id = dest1;
       	uint64_t foo_in_val = read_uint64("foo_in");
       	pipe_dispatch_uint64(pipe_id, foo_in_val);

	pipe_id = dest2;
       	foo_in_val = read_uint64("foo_in");
       	pipe_dispatch_uint64(pipe_id, foo_in_val);
    }
}


