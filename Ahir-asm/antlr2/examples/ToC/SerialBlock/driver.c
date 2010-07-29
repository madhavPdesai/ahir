#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint_10 a,b,c;

	a.__val = 5;
	b.__val = 6;
	sum_mod(a,b,&c);

	printf("%d\n",c.__val);
	return(1);
}
