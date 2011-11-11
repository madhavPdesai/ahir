#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint_10 a,b,c,d,e;

	a.__val = 5;
	b.__val = 6;
	c.__val = 7;
	d.__val = 8;
	sum_mod(a,b,c,d,&e);

	printf("expected 26, saw %d\n",e.__val);
	return(1);
}
