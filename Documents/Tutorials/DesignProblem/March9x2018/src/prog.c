#include <stdint.h>   // gives uint types.
#include <Pipes.h>    // read_, write_ functions.
#include <pthread.h>  // for pthread.

uint8_t numbers[16];  // global

// forward declaration.
uint8_t bubble_sort ();

void sort_daemon()
{
	int i;
	while (1)
	{
		// read the numbers
		for(i=0; i < 16; i++)
			numbers[i] = read_uint8("in_data");

		// now sort in place.
		uint8_t sort_ret_val = bubble_sort ();


		// write out the numbers.
		for (i=0; i < 16; i++)
			write_uint8 ("out_data", numbers[i]);
	}
}


// function bubble_sort in ascending order.
uint8_t bubble_sort ()
{
	int i,j;
	while (1)
	{
		uint8_t swap = 0;
		for (i = 0; i < 15; i++)
		{
			uint8_t X = numbers[i];
			uint8_t Y = numbers[i+1];

			if (X > Y)
			{
				numbers[i+1] = X;
				numbers[i]   = Y;
				swap = 1;
			}
		}

		if(swap == 0)
			break;
	}
	return(1);
}
