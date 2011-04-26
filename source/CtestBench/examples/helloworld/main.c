#include <stdlib.h>
#include <stdint.h>

float read_float32(const char *id);
uint32_t read_uint32(const char *id);

void write_float32(const char *id, float data);
void write_uint32(const char *id, uint32_t data);


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

