#include <stdio.h>

#ifdef SW
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

int main()
{
	float a, b, c, d;
	float res1, res2, res3;
	double res4, res5, res6;
	printf("Enter 2 floats and two doubles \n");
	scanf("%f %f", &a, &b);
	scanf("%f %f", &c, &d);

	res1 = doubleDiv(a, b);
	printf("**********************************FLOAT OPERATIONS**************************\n");
	printf("%f / %f = %0.10f \n", a, b, res1);
	res2 = doubleSqrt(a);
	printf("sqrt of %f is %0.10f\n", a, res2);
	res3 = doubleSqrt(b);
	printf("sqrt of %f is %0.10f\n", b, res3);

	printf("**********************************DOUBLE OPERATIONS**************************\n");
	res4 = doubleDiv(c, d);
	printf("%f / %f = %0.10f\n", c, d, res4);
	res5 = doubleSqrt(c);
	printf("sqrt of %f is %0.10f\n", c, res5);
	res6 = doubleSqrt(d);
	printf("sqrt of %f is %0.10f\n", d, res6);



	return 0;
}
