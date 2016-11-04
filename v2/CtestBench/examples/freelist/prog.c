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


#define FREE_LIST_PUT 1
#define FREE_LIST_GET 2

#define FREE_LIST_SIZE 2
typedef struct Link_ Link;

struct Link_
{
	Link* next;
	uint32_t val;
};

Link free_list[FREE_LIST_SIZE];
Link* head;

void free_queue_manager()
{
	int i;

	for(i = 0; i < FREE_LIST_SIZE-1; i++)
	{
		free_list[i].next = &(free_list[i+1]);
	}
	free_list[FREE_LIST_SIZE-1].next = NULL;
 	head = &(free_list[0]);
	
	while(1)
	{
		uint8_t command = read_uint8("free_queue_request");
		if(command == FREE_LIST_GET)
		{
			Link* ret = head;
			if(head != NULL)
				head = head->next;
			write_pointer("free_queue_get", ret);
		}	
		else if(command == FREE_LIST_PUT)
		{
			Link* put_link = read_pointer("free_queue_put");
			put_link->next = head;
			head = put_link;
		}
#ifdef RUN
		else
			fprintf(stderr,"Error: unknown free list command\n");
#endif

	}
}

void foo()
{

	while(1)
	{
		Link* lptr = read_pointer("foo_in");
		lptr->val = 2 * lptr->val; 
		write_pointer("foo_out",lptr);
	}
}

void input_module()
{
	while(1)
	{
		write_uint8("free_queue_request", FREE_LIST_GET);
		Link* lptr  =  read_pointer("free_queue_get");
		if(lptr != NULL)
		{
			// read value
			uint32_t nval = read_uint32("input_data");

 			lptr->val = nval;
			write_pointer("foo_in",lptr);
		}
	}
}


void output_module()
{
	while(1)
	{
		Link* lptr = read_pointer("foo_out");
		write_uint32("output_data", lptr->val);
		write_uint8("free_queue_request", FREE_LIST_PUT);
		write_pointer("free_queue_put", lptr);
	}
}

