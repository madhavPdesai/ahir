#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

#include "prog.h"

void reverse(uint8_t* buf8, uint32_t len)
{
	int t = len-1;
        int imax = len >> 1;
        int i;
	uint8_t tmp;

	for(i = 0; i <= imax ; i++)
	{
		tmp = buf8[i];
		buf8[i] = buf8[t-i];	
		buf8[t-i] = tmp;	
	}
}

void io_module()
{
    uint8_t buf8[4096];
    while(1)
    {

	// number of bytes to be read..
       	uint32_t len8 = read_uint32("inpipe");

	// read the uint32_t's and stuff them into buf.
	int i;
	for(i=0; i < len8; i=i+4)
		*((uint32_t*)(buf8 + i)) = read_uint32("inpipe");

	// reverse bytes.
	reverse(buf8,len8);
			
 
	// send the packet as uint8_t's..
	// first the length.
	uint8_t* lenptr = (uint8_t*) (&len8);
	// least-significant byte first.
	for(i=0; i < 4; i++)
		write_uint8("outpipe",lenptr[i]);

	// then the packet.
	for(i=0; i < len8; i++)
		write_uint8("outpipe", buf8[i]);

    }
}

