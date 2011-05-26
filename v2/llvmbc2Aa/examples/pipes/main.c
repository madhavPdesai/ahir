#include <stdlib.h>
#include <stdint.h>

float read_float32(const char *id);
uint32_t read_uint32(const char *id);

void write_float32(const char *id, float data);
void write_uint32(const char *id, uint32_t data);

typedef struct pipeId_
{
   char* id;
   int w;
} pipeId;

const pipeId p1 = { "pipe1" , 4};

int foo(int a)
{
	int b;
      

	write_uint32(p1.id,a);
	b = read_uint32("pipe2");

	return(b);
}

int bar()
{
	int b;

	b = read_uint32("pipe1");
	write_uint32("pipe2",b);

	return(1);
}

