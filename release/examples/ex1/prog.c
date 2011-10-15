#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>


// note: initialized value..
uint32_t sum = 23;


uint32_t get_sum()
{
    return(sum);
}

void accumulate()
{
    while(1)
    {
	int nxt = read_uint32("in_data");
#ifdef SW
	printf("read %u\n", nxt);
#endif
	sum = (sum + nxt);
	write_uint32("out_data",sum);
#ifdef SW
	printf("wrote %u\n", sum);
#endif
    }
}

