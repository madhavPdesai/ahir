#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <math.h>
#ifdef SW
#include <pipeHandler.h>
#include <Pipes.h>
#include <pthreadUtils.h>
#else
#include "vhdlCStubs.h"
#endif
#include "prog.h"


#define BUILD_TWIDDLE_ARRAY__(twwR,twwI) {\
	float SinThetaBy2 = sin(M_PI / ORDER);\
	float pR = 1.0 - (2.0*(SinThetaBy2*SinThetaBy2));\
	float pI = - sin(2.0*M_PI/ORDER);\
	float tR = 1.0;\
	float tI = 0.0;\
	uint16_t idx;\
	float wtemp;\
	for(idx = 0; idx < ORDER; idx++)\
	{\
		twwR[idx] = tR;\
		twwI[idx] = tI;\
		wtemp = tR;\
		tR = (tR*pR) - (tI*pI); \
		tI = (tI*pR) + (wtemp*pI); \
	}\
}

float Re[ORDER], Im[ORDER];
float refRe[ORDER], refIm[ORDER];
float twR[ORDER], twI[ORDER];

void calculateDFT(float* R, float* I, float* fR, float* fI)
{

        uint16_t K,L,M,N;
        for(K = 0; K < ORDER; K++)
        {
                float re = 0.0;
                float im = 0.0;

                float tr = 0.0;
                float ti = 0.0;

                for (M = 0; M < ORDER; M++)
                {
                        uint16_t tindex = (M*K) % ORDER;
                        tr = (twR[tindex]*R[M]) - (twI[tindex]*I[M]);
                        ti = (twR[tindex]*I[M]) + (twI[tindex]*R[M]);

                        re += tr;
                        im += ti;
                }

                fR[K] = re;
                fI[K] = im;
        }
}

void SendTwiddlesR()
{
	write_float32_n("twR_pipe",twR,ORDER);
}

void SendTwiddlesI()
{
	write_float32_n("twI_pipe",twI,ORDER);
}

void SendRe()
{
	write_float32_n("Re_pipe",Re,ORDER);
}

void SendIm()
{
	write_float32_n("Im_pipe",Im,ORDER);
}

void RxRe()
{
	read_float32_n("fRe_pipe",Re,ORDER);
}

void RxIm()
{
	read_float32_n("fIm_pipe",Im,ORDER);
}

#ifdef SW
DEFINE_THREAD(fft)
#endif


int main(int argc, char* argv[])
{
	int num_blocks = 1;
	if(argc > 1)
		num_blocks = atoi(argv[1]);

	if(num_blocks < 1)
	{
		num_blocks = 1;
	}

	uint32_t idx, offset, lim;
	srand48(1023);

	for(idx = 0; idx < ORDER; idx++)
	{
		Re[idx] = drand48();
		Im[idx] = drand48();
	}

	BUILD_TWIDDLE_ARRAY__(twR,twI);
	calculateDFT(Re,Im,refRe,refIm);

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(fft);
	PTHREAD_CREATE(fft);
#endif


	SendTwiddlesR();
	SendTwiddlesI();
	SendRe();
	SendIm();

	RxRe();
	RxIm();

	for(idx = 0; idx < ORDER; idx++)
		fprintf(stdout,"%d.  Re=%f (ref=%f), Im=%f (ref=%f).\n", idx, Re[idx],refRe[idx], Im[idx],refIm[idx]);

#ifdef SW
	PTHREAD_CANCEL(fft);
	close_pipe_handler();
#endif
	return(0);
}
