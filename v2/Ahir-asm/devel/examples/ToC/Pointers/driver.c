#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint_32 a[2],b;

	a[0].__val = (uint32_t) &a;

	passpointer(a[0],&b);


	printf("%d\n",b.__val);
	return(1);
}

