#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	uint16_t a,b,c;

	a = 5;
	b = 6;
	sum_mod(a,b,&c);

	uint16_t x = (a + b);
        x = ( x - b );
        x = ( x * b );
 	x = ~( x | b );
 	x = ~( x & b );
	x = ~( x ^ b );
	x = ( x ^ b );
 	x = ( x & b );
 	x = ( x | b );

	printf("expected %u, saw %u\n",x, c);
	return(1);
}
