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

// 4 slots.
Link free_list[FREE_LIST_SIZE+1];
Link* head;

void free_queue_manager()
{
	int i;

	for(i = 1; i < FREE_LIST_SIZE; i++)
	{
		free_list[i].next = &(free_list[i+1]);
	}
	free_list[FREE_LIST_SIZE].next = NULL;
 	head = &(free_list[1]);
	
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

