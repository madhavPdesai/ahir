#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>


int foo(int a)
{
	
	int b;
	b = read_uint32("inpipe");
	write_uint32("midpipe",a+b);

	return(a);
}

int bar(int a)
{
	int b;

	b = read_uint32("midpipe");
	write_uint32("outpipe",(a+b));

	return(a);
}

