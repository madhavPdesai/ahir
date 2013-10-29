#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include "hermite.h"
#include "bestFit.h"
#ifndef SW
#include "vhdlCStubs.h"
#endif

#define MIN_SIGMA  0.025
#define MAX_SIGMA  0.05

double _hF0[MEM_SIZE];
double _hF1[MEM_SIZE];
double _hF2[MEM_SIZE];
double _hF3[MEM_SIZE];
double _hF4[MEM_SIZE];
double _hF5[MEM_SIZE];
double samples[NSAMPLES];



void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}


void calculateReferenceFit()
{
	// for each sigma, calculate the projections and
	// the MSE.
	int idx, SI;
	double mmse = 1.0e+20;
	int best_index = -1;
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		double dp0 = 0;
		double dp1 = 0;
		double dp2 = 0;
		double dp3 = 0;
		double dp4 = 0;
		double dp5 = 0;
		int offset = SI*NSIGMAS;	
		for(idx = 0; idx < NSAMPLES; idx++)
		{
			int J = idx + offset;
			dp0 += samples[idx] * _hF0[J];
			dp1 += samples[idx] * _hF1[J];
			dp2 += samples[idx] * _hF2[J];
			dp3 += samples[idx] * _hF3[J];
			dp4 += samples[idx] * _hF4[J];
			dp5 += samples[idx] * _hF5[J];
		}

		// Calculate error for this sigma.
		double err = 0.0;
		for(idx = 0; idx < NSAMPLES; idx++)
		{
			int J = idx + offset;

			double p0 = dp0 * _hF0[J];
			double p1 = dp1 * _hF1[J];
			double p2 = dp2 * _hF2[J];
			double p3 = dp3 * _hF3[J];
			double p4 = dp4 * _hF4[J];
			double p5 = dp5 * _hF5[J];

			double P = p0 + p1 + p2 + p3 + p4 + p5;
			double Diff = samples[idx] - P;
			err += (Diff * Diff);
		}

		if(err < mmse)
		{
			mmse = err;
			best_index = SI;
		}
	}
	fprintf(stdout,"Reference best-fit: sigma-index = %d, MMSE = %f.\n", best_index, mmse);
}

void Sender()
{
	double sigma;
	int SI, idx;

	for(SI = 0; SI < NSIGMAS; SI++)
	{
		sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);
		for(idx	= 0; idx < NSAMPLES; idx++)
		{
			double X = -0.1 + (idx * 0.001);
			double oF = hermiteBasisFunction(0,sigma,X);
			write_float64("hermite_function_pipe",oF);
			_hF0[idx + (SI*NSAMPLES)] = oF;
		}
	}
	fprintf(stderr," Sent hF0.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);
		for(idx	= 0; idx < NSAMPLES; idx++)
		{
			double X = -0.1 + (idx * 0.001);
			double oF = hermiteBasisFunction(1,sigma,X);
			write_float64("hermite_function_pipe",oF);
			_hF1[idx + (SI*NSAMPLES)] = oF;
		}
	}
	fprintf(stderr," Sent hF1.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);
		for(idx	= 0; idx < NSAMPLES; idx++)
		{
			double X = -0.1 + (idx * 0.001);
			double oF = hermiteBasisFunction(2,sigma,X);
			write_float64("hermite_function_pipe",oF);
			_hF2[idx + (SI*NSAMPLES)] = oF;
		}
	}
	fprintf(stderr," Sent hF2.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);
		for(idx	= 0; idx < NSAMPLES; idx++)
		{
			double X = -0.1 + (idx * 0.001);
			double oF = hermiteBasisFunction(3,sigma,X);
			write_float64("hermite_function_pipe",oF);
			_hF3[idx + (SI*NSAMPLES)] = oF;
		}
	}
	fprintf(stderr," Sent hF3.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);
		for(idx	= 0; idx < NSAMPLES; idx++)
		{
			double X = -0.1 + (idx * 0.001);
			double oF = hermiteBasisFunction(4,sigma,X);
			write_float64("hermite_function_pipe",oF);
			_hF4[idx + (SI*NSAMPLES)] = oF;
		}
	}
	fprintf(stderr," Sent hF4.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);
		for(idx	= 0; idx < NSAMPLES; idx++)
		{
			double X = -0.1 + (idx * 0.001);
			double oF = hermiteBasisFunction(5,sigma,X);
			write_float64("hermite_function_pipe",oF);
			_hF5[idx + (SI*NSAMPLES)] = oF;
		}
	}
	fprintf(stderr," Sent hF5.\n");
}

#ifdef SW
DEFINE_THREAD(bestFit)
#endif

int main(int argc, char* argv[])
{
	float result;
	int I;
	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(bestFit);
	PTHREAD_CREATE(bestFit);
#endif

	Sender();
	srand48(819);
	for(I = 0; I < NSAMPLES; I++)
	{
		double X = drand48();
		write_float64("sample_data_pipe", X);
		samples[I] = X;
	}
	fprintf(stderr," Sent samples.\n");

	calculateReferenceFit();

	uint32_t best_sigma_index = read_uint32("best_sigma_pipe");
	fprintf(stdout, " Best sigma= %f (index = %d).\n", (MIN_SIGMA + (best_sigma_index*(MAX_SIGMA - MIN_SIGMA)/NSIGMAS)), best_sigma_index);
	
	double p0 = read_float64("fit_coefficient_pipe");
	double p1 = read_float64("fit_coefficient_pipe");
	double p2 = read_float64("fit_coefficient_pipe");
	double p3 = read_float64("fit_coefficient_pipe");
	double p4 = read_float64("fit_coefficient_pipe");
	double p5 = read_float64("fit_coefficient_pipe");
	fprintf(stdout, "Fit coefficients = %le, %le, %le, %le, %le, %le.\n", p0,p1,p2,p3,p4,p5);

#ifdef SW
	PTHREAD_CANCEL(bestFit);
	close_pipe_handler();
	return(0);
#endif
}
