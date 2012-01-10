#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>


// note: initialized value..
uint32_t sum1 = 23;
uint32_t sum2 = 39;

// note: no problems with pointers :-)
uint32_t* tgt[2] = {&sum1, &sum2};


void accumulate()
{
    int i = 0;
    while(1)
    {
	int nxt = read_uint32("in_data");
#ifdef SW
	printf("read %u\n", nxt);
#endif
	// ugly, but this is just a demo!
	*(tgt[i])= ((*tgt[i]) + nxt);

	write_uint32("out_data",*(tgt[i]));
#ifdef SW
	printf("wrote %u\n", *(tgt[i]));
#endif
	i = 1 - i;
    }
}

