#include <stdint.h>   // gives uint types.
#include <Pipes.h>    // read_, write_ functions.
#include <pthread.h>  // for pthread.

extern uint8_t numbers_h[8];  // global
extern uint8_t numbers_l[8];  // global

// function bubble_sort top half in ascending order.
uint8_t bubble_sort_h ()
{
	int i,j;
	while (1)
	{
		uint8_t swap = 0;
		for (i = 0; i < 7; i++)
		{
			uint8_t X = numbers_h[i];
			uint8_t Y = numbers_h[i+1];

			if (X > Y)
			{
				numbers_h[i+1] = X;
				numbers_h[i]   = Y;
				swap = 1;
			}
		}

		if(swap == 0)
			break;
	}
	return(1);
}

// function bubble_sort bottom half in ascending order.
uint8_t bubble_sort_l ()
{
	int i,j;
	while (1)
	{
		uint8_t swap = 0;
		for (i = 0; i < 7; i++)
		{
			uint8_t X = numbers_l[i];
			uint8_t Y = numbers_l[i+1];

			if (X > Y)
			{
				numbers_l[i+1] = X;
				numbers_l[i]   = Y;
				swap = 1;
			}
		}

		if(swap == 0)
			break;
	}
	return(1);
}
