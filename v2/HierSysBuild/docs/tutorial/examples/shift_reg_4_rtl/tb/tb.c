#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "Pipes.h"
#include "SockPipes.h"

int test_length = 16;

int main (int argc, char* argv[])
{
	fprintf(stderr,"Usage: %s <test-length (default 16)>\n", argv[0]);

	if(argc > 1)
		test_length = atoi(argv[1]);


	uint32_t I;
	for(I = 0; I < test_length; I++)
	{
		sock_write_uint32("in_data",I);
		uint32_t J = sock_read_uint32("out_data");
		if(J != (~I))
		{
			fprintf(stderr,"Error: expected 0x%x, received 0x%x\n", (~I), J);
		}
	}
	fprintf(stderr,"All done.\n");
}

