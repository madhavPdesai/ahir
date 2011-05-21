#include "../iolib.h"
#include <stdlib.h>
#include <stdio.h>

int main (void)
{
	int i,j;
	int jbuf[10];

	read_uint32_n("xpipe",jbuf,10);

        for(i = 0; i < 10; i++)
	  fprintf(stderr,"read %d\n",jbuf[i]);

	return(0);
}
