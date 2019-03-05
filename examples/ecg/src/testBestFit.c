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

#define MIN_SIGMA  0.003*(1000.0/360.0)
#define MAX_SIGMA  0.004*(1000.0/360.0)

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

void Logger()
{
	while(1)
	{
		uint32_t log_val = read_uint32("logger_pipe");
		fprintf(stderr,"Logged-value:  %d.\n", log_val);
	}
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
		int offset = SI*NSAMPLES;	
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

		//fprintf(stderr,"SW: Dot-product for sigma-index %d, HF-0, is %f.\n", SI, dp0);
		//fprintf(stderr,"SW: Dot-product for sigma-index %d, HF-1, is %f.\n", SI, dp1);
		//fprintf(stderr,"SW: Dot-product for sigma-index %d, HF-2, is %f.\n", SI, dp2);
		//fprintf(stderr,"SW: Dot-product for sigma-index %d, HF-3, is %f.\n", SI, dp3);
		//fprintf(stderr,"SW: Dot-product for sigma-index %d, HF-4, is %f.\n", SI, dp4);
		//fprintf(stderr,"SW: Dot-product for sigma-index %d, HF-5, is %f.\n", SI, dp5);

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
	fprintf(stdout,"SW: Reference best-fit: sigma-index = %d, MMSE = %f.\n", best_index, mmse);
}

#define __HF__(N,SI,hhf) {\
		int idx;\
		double hF[NSAMPLES];\
		double sigma = MIN_SIGMA + SI*((MAX_SIGMA-MIN_SIGMA)/NSIGMAS);\
		normalizedHermiteBasisFunction(N,sigma,hF);\
		for(idx	= 0; idx < NSAMPLES; idx++)\
		{\
			double oF = hF[idx];\
			write_float64("hermite_function_pipe",oF);\
			hhf[idx + (SI*NSAMPLES)] = oF;\
		}}
	

void Sender()
{
	double sigma;
	int SI, idx;
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__HF__(0,SI,_hF0);
	}
	fprintf(stderr," Sent hF0.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__HF__(1,SI,_hF1);
	}
	fprintf(stderr," Sent hF1.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__HF__(2,SI,_hF2);
	}
	fprintf(stderr," Sent hF2.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__HF__(3,SI,_hF3);
	}
	fprintf(stderr," Sent hF3.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__HF__(4,SI,_hF4);
	}
	fprintf(stderr," Sent hF4.\n");
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__HF__(5,SI,_hF5);
	}
	fprintf(stderr," Sent hF5.\n");
}

#ifdef SW
DEFINE_THREAD(bestFit)
#endif
DEFINE_THREAD(Logger)

int main(int argc, char* argv[])
{
	float result;
	int I;

	if(argc < 2)
	{
		fprintf(stderr,"Supply data set file.\n");
		return(1);
	}

	FILE* fp = fopen(argv[1],"r");
	if(fp == NULL)
	{
		fprintf(stderr,"Could not open data set file %s.\n", argv[1]);
		return(1);
	}

	signal(SIGINT,  Exit);
	signal(SIGTERM, Exit);

	PTHREAD_DECL(Logger);
	PTHREAD_CREATE(Logger);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(bestFit);
	PTHREAD_CREATE(bestFit);
#endif

	Sender();
	for(I = 0; I < NSAMPLES; I++)
	{
		double X;
		fscanf(fp, "%le", &X);
		write_float64("sample_data_pipe", X);
		samples[I] = X;
	}
	fprintf(stderr," Sent samples.\n");
	fclose(fp);

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

	uint32_t elapsed_time = read_uint32("elapsed_time_pipe");
	fprintf(stdout,"Elapsed time = %d.\n", elapsed_time);

#ifdef SW
	PTHREAD_CANCEL(bestFit);
	close_pipe_handler();
	return(0);
#endif
}
