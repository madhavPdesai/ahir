#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint32_t a[2],b;

	a[0] = (uint32_t) &a;
	printf("try to increment %u\n",a[0]);

	passpointer(a[0],&b);


	printf("incremented value is %u\n",b);
	return(1);
}

