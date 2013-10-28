#include <stdio.h>
#include <hermite.h>


// generate orthogonal basis functions
// for specified N, sigma.
// X is varied from -0.1 to +0.1 in
// steps of 0.001;
int main(int argc, char* argv[])
{
	int N = 1;
	double sigma = 1.0;

	if(argc < 3)
	{
		fprintf(stderr," Supply N, sigma.\n");
		return(1);
	}

	N = atoi(argv[1]);
	sscanf(argv[2],"%le", &sigma);

	if(sigma == 0)
	{
		fprintf(stderr," sigma must be > 0.\n");
		sigma = 1.0;
	}
	int idx;
	for(idx = 0; idx < 200; idx++)
	{
		double X = -0.1 + (idx * 0.001);
		double oF = hermiteBasisFunction(N,sigma,X);	
		double pF = hermitePolynomial(N,X);	
		fprintf(stdout, "%d %f %le %le %le \n", N, sigma, X, oF, pF);
	}

	return(0);
}
