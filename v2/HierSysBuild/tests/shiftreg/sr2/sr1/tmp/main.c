#include <stdlib.h>
#include <stdio.h>

int _a_array[16];
#define A (_a_array)

typedef struct __b_struct {
	int val;
} b_struct;
b_struct __b;

#define B (__b)

int main(int argc, char* argv[])
{
	A[0] = 1;
	A[1] = 2;

	B.val = 0;

	printf("A[0] = %d, A[1] = %d\n", A[0], A[1]);
	printf("B.val = %d\n", B.val);
	return(0);
}
