#include "../iolib.h"
#include <stdlib.h>
#include <stdio.h>

int main (void)
{
	int i,j;
	for(i = 0; i < 10; i++)
	{
		j = 	read_uint32("xpipe");
		fprintf(stderr,"read %d\n",j);
	}
	return(0);
}
