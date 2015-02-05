#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint16_t a,b,c;

	a = 5;
	b = 6;
	sum_mod(a,b,&c);

	if(c != a*b)
		printf("Error: expected %d, got %d.\n", a*b, c);
	else
	printf("Success, got %d\n",c);
	return(1);
}
