#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>

#define NUMSLOTS 16

// free-list..
// array of uint32_t + next-index.
#define __alloc_slot__(x) { x = read_uint32("free_slots");}
#define __free_slot__(x) {write_uint32("free_slots", x);}

// each list-item contains
// value  prev next
uint64_t list_items [ NUMSLOTS ];
int16_t  head_index, tail_index;

#define __value__(x) ((uint32_t) (x >> 32))
#define __next__(x) ((int16_t) (x & 0xffff))
#define __prev__(x) ((int16_t) ((x >> 16) & 0xffff))
inline uint64_t __set_prev__(uint64_t v, int16_t x) 
{ 
	uint64_t ret_val =  (v & (~0xffff0000));
	ret_val = (ret_val | (x << 16));
	return(ret_val);
}

#define __set_next__(v,x) { v = ((v & (~((uint64_t)0xffff))) | x);}
inline uint64_t  __set_prev_next__(uint64_t v, uint16_t x, uint16_t y) 
{ 
	uint64_t retval = (v & (~((uint64_t)0xffffffff)));
	uint64_t x64  = ((x << 16) | y) & 0xffffffff ;
	retval  |= x64;
	return(retval);
}



#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif

void insertIntoList (uint32_t A)
{
	int16_t pred, curr, next;

	//
	// get a free slot to put it into the list.
	//
	uint16_t slot; 
	__alloc_slot__ (slot);

	//
	// entry..
	//
	uint64_t slot_entry = A;

	//
	// search for the appropriate location
	// in the linked list.
	//
	curr = head_index;
	pred = -1;
	while(curr != -1)
	{
		uint64_t curr_slot_entry = list_items[curr];

		if((curr_slot_entry >> 32) < slot_entry)
		// if new entry is greater move to the right.
		{
			pred = curr;
			curr = __next__ (curr_slot_entry);
		}
		else
		{
			// new entry is <=, insert it before the
			// current one.
			break;
		}
	}

	// slot entry.. shift the value by 32
	slot_entry = (slot_entry << 32);

	// either the head or a curr before which
	// you must place the new item.
	// prev,next in slot-entry.
	slot_entry = __set_prev_next__(slot_entry, pred, curr);

	if((head_index == -1) || (pred == -1))
	{
		head_index = slot;
	}

	if(curr == -1)
		tail_index = slot;
	else
	{
		uint64_t p_entry = list_items[curr];
		__set_prev__ (p_entry, slot);
		list_items[curr] = p_entry;
	}

	if(pred != -1)
	{
		uint64_t p_entry = list_items[pred];
		__set_next__ (p_entry, slot);
		list_items[pred] = p_entry;
	}

	list_items[slot] = slot_entry;

}

uint32_t popFromList ()
{
	uint32_t ret_val = 0;
	if(head_index >= 0)
	{
		uint64_t u64 = list_items[head_index];
		int16_t next_head_index = __next__(u64);
		u64  = (u64 >> 32);
		ret_val = u64;

		__free_slot__ (head_index);
		head_index = next_head_index;


		uint64_t v64 = list_items[head_index];
		__set_prev__(v64,-1);
		list_items[head_index] = v64;

		if(head_index == -1)
			tail_index = -1;
	}

	return(ret_val);

}

void sortDaemon()
{

	int I;

	///////////////////////////////////////////////////
	// initialize
	///////////////////////////////////////////////////
	for(I=0; I < NUMSLOTS; I++)
		write_uint32("free_slots", I);

	head_index = -1;
	tail_index = -1;
	///////////////////////////////////////////////////

	///////////////////////////////////////////////////
	// Insert lots..
	///////////////////////////////////////////////////
	for(I=0; I < NUMSLOTS; I++)
	{
		uint32_t A = read_uint32("in_data");
		insertIntoList (A);
	}
	///////////////////////////////////////////////////
	// Pop lots..
	///////////////////////////////////////////////////
	for(I=0; I < NUMSLOTS; I++)
	{
		uint32_t B = popFromList ();
		write_uint32("out_data", B);
	}

}

