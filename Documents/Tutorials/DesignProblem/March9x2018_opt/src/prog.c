#include <stdint.h>   // gives uint types.
#include <Pipes.h>    // read_, write_ functions.
#include <pthread.h>  // for pthread.

uint8_t numbers_h[8];  // global
uint8_t numbers_l[8];  // global

uint8_t sorted_numbers[16];  // global


// forward declaration.
uint8_t bubble_sort_h ();
uint8_t bubble_sort_l ();
void merge_sort ();

void sort_daemon()
{
	int i;
	while (1)
	{
		// read the numbers
		for(i=0; i < 8; i++)
			numbers_h[i] = read_uint8("in_data");

		for(i=0; i < 8; i++)
			numbers_l[i] = read_uint8("in_data");

		// now sort in place.
		uint8_t sort_ret_val_h = bubble_sort_h ();
		uint8_t sort_ret_val_l = bubble_sort_l ();


		// merge sort and write to output.
		merge_sort ();
	}
}


void merge_sort ()
{
	int ptr_1 = 0;
	int ptr_2 = 0;
	int J = 0;
	// go down the two arrays and merge them to the output.
	while (1)
	{
		if ((ptr_1 < 8) && 
			((ptr_2 == 8) || (numbers_h[ptr_1]  < numbers_l[ptr_2])))
		{
			write_uint8("out_data", numbers_h[ptr_1]);
			J++;
			ptr_1++;
		}
		else if ((ptr_2 < 8) && 
			((ptr_1 == 8) || (numbers_l[ptr_2]  < numbers_h[ptr_1])))
		{
			write_uint8("out_data", numbers_l[ptr_2]);
			J++;
			ptr_2++;
		}

		if(J == 16)
			break;
	}
}
