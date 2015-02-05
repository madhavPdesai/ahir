#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint16_t a,b,c,d,e;

	a = 5;
	b = 6;
	c = 7;
	d = 8;
	sum_mod(a,b,c,d,&e);

	printf("expected %d, saw %d\n", 2*a*d, e);
	return(1);
}
