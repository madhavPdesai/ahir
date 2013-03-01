#include <stdint.h>
#include <stdio.h>
#include "Pipes.h"
#include "prog.h"

uint16_t bitReverseArray[ORDER];
float Re[ORDER], Im[ORDER];
float fRe[ORDER], fIm[ORDER];
float twR[ORDER], twI[ORDER];

// A 2x2 butterfly. 
#define BUTTERFLY__(rT,iT,rB,iB,fRT,fIT,fRB,fIB,tfR,tfI) {\
		float pR = ((rB*tfR)-(iB*tfI));\
		float pI = ((rB*tfI) + (iB*tfR));\
		float sRT = (rT + pR); float sIT = (iT + pI);\
		float sRB = (rT - pR); float sIB = (iT - pI);\
		*fRT = sRT; *fIT = sIT; *fRB = sRB; *fIB = sIB;\
	}

inline void fft_butterfly(uint16_t stage_id, uint16_t stride, uint16_t half_stride, uint16_t half_stride_mask, uint16_t BID)
{
	// butterflies are organized into 
	// groups of size STRIDE.
	//
	// if stride = 2, then 
	// butterfly 0 forms group 0
	// butterfly 1 forms group 1
	// etc.
	//
	// if stride = 4, then 
	// butterfly 0,1 form group 0
	// butterfly 2,3 form group 1 etc.
	// 
	// in general, if stride = S, then butterfly
	// 0,1,2, ..., (S/2)-1 form group 1,
	// S/2,(S/2)+1, ... , (S/2)+(S/2)-1 form group 2 
	// etc.
	//
	// Thus group id = ((BID)/(S/2))
	//
	// half_stride is a power of 2.
	// uint16_t GID =  (BID/half_stride);  // note: no dividers available in AHIR
	uint16_t GID =  (BID & (~half_stride_mask)) >> stage_id;

	// index of the butterfly within a
	// group
	uint16_t J = (BID & half_stride_mask);

	// top-index for butterfly is 
	// (GID*stride) + (BID mod half_stride)
	uint16_t tIndex = (GID*stride) + J;
	// bottom-index is top-index + half-stride.
	uint16_t bIndex = half_stride + tIndex;

	// twiddle-index
	// twiddle factor for the butterfly will
	// be W^((ORDER >> (stage_id+1))*J), that is
	// for the first stage, it is W^((ORDER/2)*J),
	// etc..
	uint16_t tWindex = ((((uint16_t) ORDER) >> (stage_id+1)) * J);\

			   float tfR = twR[tWindex]; float tfI = twI[tWindex];
	float rT = fRe[tIndex]; float iT = fIm[tIndex];
	float rB = fRe[bIndex]; float iB = fIm[bIndex];
	float* fRB = &(fRe[bIndex]);
	float* fIB = &(fIm[bIndex]);
	float* fRT = &(fRe[tIndex]);
	float* fIT = &(fIm[tIndex]);
	BUTTERFLY__(rT,iT,rB,iB,fRT,fIT,fRB,fIB,tfR,tfI);
#ifdef SW
	fprintf(stderr,"Info: Butterfly: stage %d, index %d, group %d, t-index %d. b-index %d, tw-index %d.\n",
			stage_id, BID, GID, tIndex, bIndex, tWindex);
#endif
}

void fft_stage(uint16_t stage_id)
{
	uint16_t stride = (2 << stage_id);    // log2 (stride) = stage_id + 1
	uint16_t half_stride = (stride >> 1); // log2 (half_stride) = stage_id.
	uint16_t half_stride_mask = half_stride-1;

	uint16_t BID;
	uint16_t I;
#ifdef UNROLL
	uint16_t  STEP = 4;
#else
	uint16_t  STEP = 1;
#endif

	for(I = 0; I < (ORDER >> 1); I += STEP)
	{
		fft_butterfly(stage_id,stride,half_stride, half_stride_mask, I);
#ifdef UNROLL
		fft_butterfly(stage_id,stride,half_stride, half_stride_mask, I+1);
		fft_butterfly(stage_id,stride,half_stride, half_stride_mask, I+2);
		fft_butterfly(stage_id,stride,half_stride, half_stride_mask, I+3);
#endif
	}
}

// Each FFT stage invokes ORDER/2 butterflies.  Each butterfly
// will take a pair from the left and combine it to provide
// a pair to the right. The stride will be 2 for the 0 
// stage and ORDER/2 for the last stage.
#define FFT_STAGE(STAGE_ID) {\
	uint16_t STRIDE = (2 << (STAGE_ID));\
	uint16_t HALFSTRIDE = (STRIDE >> 1);\
	uint16_t SEGSTART,J;\
	for(J=0; J < HALFSTRIDE; J++) \
	{\
		uint16_t tindex = ((((uint16_t) ORDER) >> (STAGE_ID+1)) * J);\
		float tfR = twR[tindex]; float tfI = twI[tindex];\
		for(SEGSTART=0; SEGSTART < ORDER; SEGSTART += STRIDE) {\
			uint16_t tIndex = SEGSTART+J;\
			uint16_t bIndex = tIndex + HALFSTRIDE;\
			float rT = fRe[tIndex]; float iT = fIm[tIndex];\
			float rB = fRe[bIndex]; float iB = fIm[bIndex];\
			float* fRB = &(fRe[bIndex]);\
			float* fIB = &(fIm[bIndex]);\
			float* fRT = &(fRe[tIndex]);\
			float* fIT = &(fIm[tIndex]);\
			BUTTERFLY__(rT,iT,rB,iB,fRT,fIT,fRB,fIB,tfR,tfI);\
		}\
	}\
}




uint8_t bitReverse8(uint8_t I)
{
	uint8_t J = 0;
	uint8_t idx;
	for(idx = 0; idx < 8;  idx++)
	{
		if( ((I >> (7-idx)) & 0x1) != 0)
			J = (J | (0x1 << idx));
	}
	return(J);
}

uint16_t bitReverse16(uint16_t I)
{
	uint16_t JU = bitReverse8((uint8_t) I);
	uint16_t JL = bitReverse8((uint8_t) (I >> 8));

	uint16_t J = JU;
	J = (J << 8) | ((uint16_t) JL); 

	return((J >> (16 - LOG2ORDER)));

}


void buildBitReverseArray()
{
	uint16_t I;
	for(I = 0; I < ORDER; I++)
	{
		bitReverseArray[I] = bitReverse16(I);
#ifdef SW
		fprintf(stdout,"bit_reverse[%x] = %x.\n", I, bitReverseArray[I]);
#endif
	}
	
}

void fftBase()
{
	uint32_t i;

	for(i= 0; i < ORDER; i++)
	{
		uint32_t J = 	bitReverseArray[i];
		fRe[J] = Re[i];
		fIm[J] = Im[i];
	}
        
        uint16_t S;
	for(S=0; S < LOG2ORDER; S++)
	{
		fft_stage(S);
		//FFT_STAGE(S);
        }
}

void getTwR()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		twR[idx] = read_float32("twR_pipe");
	}
}

void getTwI()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		twI[idx] = read_float32("twI_pipe");
	}
}

void readRe()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		Re[idx] = read_float32("Re_pipe");
	}
}

void writeRe()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		write_float32("fRe_pipe",fRe[idx]);
	}
}

void readIm()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		Im[idx] = read_float32("Im_pipe");
	}
}

void writeIm()
{
	uint32_t idx;
	for(idx = 0; idx < ORDER; idx++)
	{
		write_float32("fIm_pipe",fIm[idx]);
	}
}

void fft()
{
	uint32_t idx;
	buildBitReverseArray();

	getTwR();
	getTwI();

	while(1)
	{
		
		readRe();
		readIm();
		fftBase();
		writeRe();
		writeIm();
	}

}
