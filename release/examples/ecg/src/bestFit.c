#include <math.h>
#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <timer.h>
#include "bestFit.h"

#ifdef SW
void __loop_pipelining_on__(int A,int B,int C) {}
#else
void __loop_pipelining_on__(int,int,int); 
#endif	

double best_mse;
int best_sigma_index ;

void initHF()
{
	int M = MEM_SIZE;
	int idx;

	for(idx = 0; idx < NSIGMAS; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		dotP0[idx]  = 0;
		dotP1[idx]  = 0;
		dotP2[idx]  = 0;
		dotP3[idx]  = 0;
		dotP4[idx]  = 0;
		dotP5[idx]  = 0;
	}

	for(idx = 0; idx < M; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		hF0[idx] = read_float64("hermite_function_pipe");
	}
	for(idx = 0; idx < M; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		hF1[idx] = read_float64("hermite_function_pipe");
	}
	for(idx = 0; idx < M; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		hF2[idx] = read_float64("hermite_function_pipe");
	}
	for(idx = 0; idx < M; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		hF3[idx] = read_float64("hermite_function_pipe");
	}
	for(idx = 0; idx < M; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		hF4[idx] = read_float64("hermite_function_pipe");
	}
	for(idx = 0; idx < M; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		hF5[idx] = read_float64("hermite_function_pipe");
	}

#ifdef SW
	fprintf(stderr,"initHF completed.\n");
#endif
}

void initFit()
{
	int idx;

	for(idx = 0; idx < NSIGMAS; idx++)
	{
		__loop_pipelining_on__(8,1,0);
		dotP0[idx]  = 0;
		dotP1[idx]  = 0;
		dotP2[idx]  = 0;
		dotP3[idx]  = 0;
		dotP4[idx]  = 0;
		dotP5[idx]  = 0;
	}
}


// given the next input, the hf polynomial
// array and the dotp array, update the dotp
// arrays for all sigma positions with 
// the inner product computation.
// 
// 
inline void  __InnerProduct__(int I0, double x) {
	int SI;
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		__loop_pipelining_on__(8,1,0);
		int I = I0 + (SI*NSAMPLES);
		double p0 = (x*hF0[I]);
		dotP0[SI] += p0;
		double p1 = (x*hF1[I]);
		dotP1[SI] += p1;
		double p2 = (x*hF2[I]);
		dotP2[SI] += p2;
		double p3 = (x*hF3[I]);
		dotP3[SI] += p3;
		double p4 = (x*hF4[I]);
		dotP4[SI] += p4;
		double p5 = (x*hF5[I]);
		dotP5[SI] += p5;
	}
}


// receive a sample frame and compute the
// inner products with all the hF basis
// polynomials.
void RxAndComputeInnerProducts()
{
	int I;
	for(I=0; I < NSAMPLES; I++)
	{
		double x = read_float64("sample_data_pipe");
		inputData[I] = x;

		// note: the sample interval will about 
		// 1ms.  Assuming a clock of 100MHz, this
		// means that the inner-product loop below
		// should finish in 100K cycles.  not likely
		// to be critical.
		__InnerProduct__(I,x);

		write_uint32("logger_pipe", I);
	}
#ifdef SW
	for(I = 0; I < NSIGMAS; I++)
	{
		fprintf(stderr,"Dot-product for sigma-index %d, HF-0, is %f.\n", I, dotP0[I]);
		fprintf(stderr,"Dot-product for sigma-index %d, HF-1, is %f.\n", I, dotP1[I]);
		fprintf(stderr,"Dot-product for sigma-index %d, HF-2, is %f.\n", I, dotP2[I]);
		fprintf(stderr,"Dot-product for sigma-index %d, HF-3, is %f.\n", I, dotP3[I]);
		fprintf(stderr,"Dot-product for sigma-index %d, HF-4, is %f.\n", I, dotP4[I]);
		fprintf(stderr,"Dot-product for sigma-index %d, HF-5, is %f.\n", I, dotP5[I]);
	}
#endif
}


// For each sigma:
//  Calculate the projection of the input
//  data  onto the subspace spanned by the
//  hF's.  
//  
//  Find the mse of the difference between
//  the projection and the original data.
//
//  Keep track of the smallest mse and the
//  corresponding sigma index.
//
void computeMSE()
{
	int I;

	best_mse = 1.0e+20;
	best_sigma_index = -1;

	int SI;
	double projection[NSAMPLES];
	for(SI = 0; SI < NSIGMAS; SI++)
	{
		double err = 0.0;

		double s0 = dotP0[SI];
		double s1 = dotP1[SI];
		double s2 = dotP2[SI];
		double s3 = dotP3[SI];
		double s4 = dotP4[SI];
		double s5 = dotP5[SI];

		int Offset = (SI * NSAMPLES);

		for(I = 0; I < NSAMPLES; I++)
		{
			__loop_pipelining_on__(8,1,0);
			double p0 = (s0*hF0[I+Offset]);
			double p1 = (s1*hF1[I+Offset]);
			double p2 = (s2*hF2[I+Offset]);
			double p3 = (s3*hF3[I+Offset]);
			double p4 = (s4*hF4[I+Offset]);
			double p5 = (s5*hF5[I+Offset]);

			double diff = (inputData[I] - 
					((p0+p1) + (p2+p3) + (p4 + p5)));

			//fprintf(stderr,"inputData[%d] = %f, Diff (%d,%d) = %f.\n",I, inputData[I], SI,I, diff);
			err += (diff * diff);
		}

#ifdef SW
		fprintf(stdout," Error for %d-th sigma is %f.\n", SI, err);
#endif

		write_uint32("logger_pipe", SI);

		if(err <  best_mse)
		{
			best_mse = err;
			best_sigma_index = SI;
		}
	}
}

void bestFit()
{
	initHF();

	while(1)
	{
	
		uint32_t start_time = getClockTime();
		// read in the samples one by one.
		// for each sample, simultaneously calculate
		// the incremental inner product across all the hF polynomials.
		RxAndComputeInnerProducts();

		// At this point you have the projections.  Calculate
		// MSE for each projection..
		computeMSE();

		// At this point, we have the best SI.
		int SI = best_sigma_index;
		write_uint32("best_sigma_pipe", SI);
		write_float64("fit_coefficient_pipe", dotP0[SI]);
		write_float64("fit_coefficient_pipe", dotP1[SI]);
		write_float64("fit_coefficient_pipe", dotP2[SI]);
		write_float64("fit_coefficient_pipe", dotP3[SI]);
		write_float64("fit_coefficient_pipe", dotP4[SI]);
		write_float64("fit_coefficient_pipe", dotP5[SI]);

		uint32_t end_time = getClockTime();

		write_uint32("elapsed_time_pipe", (end_time - start_time));

		initFit();

	}
}
