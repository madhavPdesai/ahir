#include <stdlib.h>
#include <math.h>
#include <aa_c_model.h>
#include <stdio.h>
#include <stdint.h>


//
// double precision checks.
//
int main (int argc, char* argv [])
{
	int I;

	srand48(1963);
	start_daemons();	

	for(I = 0; I < 100; I++)
	{
		double A = drand48();
		double B = drand48();

		double mul_result; 
		fpmul64(A,B, &mul_result);
		fprintf(stderr,"%le X %le = %le, expected %le\n", A,B, mul_result, A*B);

		double add_result;  
		fpadd64(A,B, &add_result);
		fprintf(stderr,"%le + %le = %le, expected %le\n", A,B, add_result, A+B);

		double sub_result;
	        fpsub64(A,B, &sub_result);
		fprintf(stderr,"%le - %le = %le, expected %le\n", A,B, sub_result, A-B);

		double div_result;
		fpdiv64(A,B,&div_result);
		fprintf(stderr,"%le / %le = %le, expected %le\n", A,B, div_result, A/B);

		double sqrt_result; 
		fpsqrt64(A,&sqrt_result);
		fprintf(stderr,"sqrt(%le) = %le, expected %le\n", A, sqrt_result, pow(A,0.5));
	}

	return(0);
}

