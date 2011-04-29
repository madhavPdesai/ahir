#include "../iolib.h"
#include <stdlib.h>
#include <stdio.h>

int main (void)
{
	int i;
	for(i = 0; i < 10; i++)
	{
		write_uint32("xpipe",i);
		fprintf(stderr,"wrote %d\n",i);
	}
	return(0);
}
