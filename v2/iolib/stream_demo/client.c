#include "../iolib.h"
#include <stdlib.h>
#include <stdio.h>

int main (void)
{
	int i;
        int jbuf[10];

	for(i = 0; i < 10; i++)
		jbuf[i] = i;

	write_uint32_n("xpipe",jbuf,10);
	fprintf(stderr,"sent 0 1 ... 10\n");
	return(0);
}
