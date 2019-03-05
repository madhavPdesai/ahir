#include <stdio.h>
#include <stdint.h>

int main(int argc, char* argv[])
{
	uint32_t A;
	sscanf(argv[1],"%x", &A);
	uint32_t sA = A & 0x80000000;
	fprintf(stdout,"%x, %x\n", A, sA);
}
