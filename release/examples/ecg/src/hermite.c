#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <hermite.h>
#include <bestFit.h>


// N = order
// sigma = scale factor.
// x = point at which the polynomial is to be computed.
double hermitePolynomial(int N, double x)
{
	double ret_val = 0.0;
	if(N == 0)
		ret_val = 1;
	else if(N == 1)
		ret_val = 2.0 * x;
	else 
	{
		double H_1 = (2.0 * x * hermitePolynomial(N-1, x));
		double H_2 = (2.0 * (N-1) * hermitePolynomial(N-2, x));
		ret_val = H_1 - H_2;
	}
	return(ret_val);
}

double nFactor(int N)
{
	double ret_val = 1.0;
	if(N > 0)
	{
		ret_val = nFactor(N-1) * 1.0 / sqrt(2 * N);
	}
	return(ret_val);
}

double basisScaleFactor(int N, double sigma, double x)
{
	double exp_factor  = pow(M_E, -(pow(x/sigma,2.0)/ 2.0));
	double denom_1 = 1.0/sqrt(sigma * sqrt(M_PI));
	double denom_2 = nFactor(N);
	return(exp_factor * denom_1 * denom_2);
}

double hermiteBasisFunction(int N, double sigma, double x)
{
	double ret_val = basisScaleFactor(N,sigma,x) *  hermitePolynomial(N,x/sigma);
	return(ret_val);
}

void normalizedHermiteBasisFunction(int N, double sigma, double* nhf)
{
	double norm_sq = 0.0;
	int idx;
	for(idx	= 0; idx < NSAMPLES; idx++)
	{
		double X = ((idx - (NSAMPLES/2)) * SAMPLING_INTERVAL);
		double oF = hermiteBasisFunction(N,sigma,X);
		nhf[idx] = oF;
		norm_sq += oF * oF;
	}
	
	double norm = sqrt(norm_sq);
	for(idx	= 0; idx < NSAMPLES; idx++)
	{
		nhf[idx] /= norm;
	}
}

