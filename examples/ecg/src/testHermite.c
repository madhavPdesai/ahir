#include <stdio.h>
#include <math.h>
#include <hermite.h>
#include <bestFit.h>


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

	double hf[NSAMPLES];	
	normalizedHermiteBasisFunction(N, sigma, hf);	
	int idx;
	double norm_squared = 0.0;
	for(idx = 0; idx < NSAMPLES; idx++)
	{
		double oF = hf[idx];
		fprintf(stdout, "%le \n", oF);
		norm_squared += (oF*oF);
	}
	fprintf(stderr,"Norm is %f.\n", sqrt(norm_squared));

	return(0);
}
