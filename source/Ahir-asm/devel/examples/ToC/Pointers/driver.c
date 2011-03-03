#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint_32 a, b;

	a.__val = 3;

	passpointer(a,&b);


	printf("%d\n",b.__val);
	return(1);
}

