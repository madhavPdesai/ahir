#include <stdint.h>
#include <timer.h>
#include "Pipes.h"
#include "MatMulVec.h"


#ifndef SW
void loop_pipelining_on();
#else
void loop_pipelining_on() {}
#endif

#include "Macros.h"

uint32_t nCells, nFaces;

// all arrays will be statically declared, and will
// have a maximum size.  
double diagPtrCell[MaxNumCells], psiPtrCell[MaxNumCells], ApsiPtrCell[MaxNumCells];
uint32_t uPtr[MaxNumFaces], lPtr[MaxNumFaces];
double lowerPtr[MaxNumFaces], upperPtr[MaxNumFaces];

#ifdef PARALLELIZED
double diagProd[MaxNumCells];
#ifdef USE4
double t0[MaxNumCells], t1[MaxNumCells], t2[MaxNumCells], t3[MaxNumCells];
#else
double t0[MaxNumCells], t1[MaxNumCells];
#endif
#endif

void getDiagPtr()
{
	while(1)
	{
		uint32_t n = read_uint32("start_diag_ptr_read");
		RFLOAT64BURST("diag_ptr_pipe", diagPtrCell, n);
		write_uint8("done_diag_ptr_read",1);
	}
}
void getLPtr()
{
	while(1)
	{
		uint32_t n = read_uint32("start_lptr_read");
		RUINT32BURST("lptr_pipe", lPtr, n);
		write_uint8("done_lptr_read",1);
	}
}
void getUPtr()
{
	while(1)
	{
		uint32_t n = read_uint32("start_uptr_read");
		RUINT32BURST("uptr_pipe", uPtr, n);
		write_uint8("done_uptr_read",1);
	}
}
void getUpperPtr()
{
	while(1)
	{
		uint32_t n = read_uint32("start_upper_ptr_read");
		RFLOAT64BURST("upper_ptr_pipe", upperPtr, n);
		write_uint8("done_upper_ptr_read",1);
	}
}
void getLowerPtr()
{
	while(1)
	{
		uint32_t n = read_uint32("start_lower_ptr_read");
		RFLOAT64BURST("lower_ptr_pipe", lowerPtr, n);
		write_uint8("done_lower_ptr_read",1);
	}
}
void getB()
{
	while(1)
	{
		uint32_t n = read_uint32("start_b_read");
		RFLOAT64BURST("b_pipe", psiPtrCell, n);
		write_uint8("done_b_read",1);
	}
}

uint8_t dbg_stage = 0;
#define __debugLog__ {\
    write_uint8("debug_pipe", dbg_stage);\
    uint32_t dbg_time = getClockTime();	\
    write_uint32("debug_timer_pipe", dbg_time);\
    dbg_stage++;}

// listen in and get matrix etc..
void MatMulDaemon()
{
	uint8_t new_problem = 1;
	uint32_t dbg_time;
	
	while(1)
	{

#ifdef PARALLELIZED
    		// spawn the initialization thread.
    		write_uint8("start_init_temps",1);
#endif

		if(new_problem)
		{
			
			nCells = read_uint32("num_cells_pipe");
			nFaces = read_uint32("num_faces_pipe");
	
			write_uint32("start_diag_ptr_read",nCells);
			write_uint32("start_uptr_read",nFaces);
			write_uint32("start_lptr_read",nFaces);
			write_uint32("start_upper_ptr_read",nFaces);
			write_uint32("start_lower_ptr_read",nFaces);
		}
		write_uint32("start_b_read",nCells);

		// wait for all reads to finish.
		if(new_problem)
		{
			uint8_t r0 = read_uint8("done_diag_ptr_read");
			uint8_t r1 = read_uint8("done_uptr_read");
			uint8_t r2 = read_uint8("done_lptr_read");
			uint8_t r3 = read_uint8("done_upper_ptr_read");
			uint8_t r4 = read_uint8("done_lower_ptr_read");
		}
		uint8_t r5 = read_uint8("done_b_read");
		
		__debugLog__;

  		AMulMatVec();

		__debugLog__;

		WFLOAT64BURST("Axb_pipe", ApsiPtrCell, nCells);

		__debugLog__;

		// read new_problem.. if it is 1, go back and
		// repopulate the matrices.
		new_problem = read_uint8("new_problem_pipe");
	}
}

#ifdef PARALLELIZED
// the 0th stage.. initialize the temporaries.
void initTemps()
{
    while(1)
    {
	uint8_t s = read_uint8("start_init_temps");
	uint32_t cell;
    	for(cell = 0; cell < nCells; cell++)
    	{
		t0[cell] = 0.0;
		t1[cell] = 0.0;
#ifdef USE4
		t2[cell] = 0.0;
		t3[cell] = 0.0;
#endif
    	}
	write_uint8("done_init_temps",s);
    }
}

// the first stage: start four parallel scalers.
void scaleEntries()
{
	uint32_t sIndex, eIndex;
#ifdef USE4
	uint32_t chunkSize = (nCells >> 2);
#else
	uint32_t chunkSize = (nCells >> 1);
#endif

	sIndex = 0; eIndex = chunkSize;
	write_uint32("scale_start_index_0", sIndex);
	write_uint32("scale_end_index_0", eIndex);

#ifdef USE4
	sIndex = eIndex; eIndex += chunkSize;
#else
	sIndex = eIndex; eIndex = nCells;
#endif 
	write_uint32("scale_start_index_1", sIndex);
	write_uint32("scale_end_index_1", eIndex);

#ifdef USE4
	sIndex = eIndex; eIndex += chunkSize;
	write_uint32("scale_start_index_2", sIndex);
	write_uint32("scale_end_index_2", eIndex);

	sIndex = eIndex; eIndex = nCells;
	write_uint32("scale_start_index_3", sIndex);
	write_uint32("scale_end_index_3", eIndex);
#endif


	uint8_t d0= read_uint8("done_scale_0");
	uint8_t d1= read_uint8("done_scale_1");
#ifdef USE4
	uint8_t d2= read_uint8("done_scale_2");
	uint8_t d3= read_uint8("done_scale_3");
#endif

	return;
}
#endif

//  The first stage: scale.
#define __ScaleLoop(startIndex, endIndex,tmp) {\
		uint32_t idx;\
		uint32_t endIndex_r = startIndex + (((endIndex-startIndex) >> 2) << 2);\
		for(idx = startIndex; idx < endIndex_r; idx = idx+4)\
		{\
			loop_pipelining_on();\
			uint32_t idx1 = idx+1;\
			uint32_t idx2 = idx+2;\
			uint32_t idx3 = idx+3;\
			tmp[idx] = diagPtrCell[idx]*psiPtrCell[idx]; \
			tmp[idx1] = diagPtrCell[idx1]*psiPtrCell[idx1]; \
			tmp[idx2] = diagPtrCell[idx2]*psiPtrCell[idx2]; \
			tmp[idx3] = diagPtrCell[idx3]*psiPtrCell[idx3]; \
		}\
		for(idx = endIndex_r; idx < endIndex; idx++)\
		{\
			tmp[idx] = diagPtrCell[idx]*psiPtrCell[idx]; \
		}\
	    } 

#ifdef PARALLELIZED
void Scale0()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("scale_start_index_0");
		uint32_t endIndex   = read_uint32("scale_end_index_0");
		__ScaleLoop(startIndex, endIndex,diagProd)
		write_uint8("done_scale_0",1);
	}
}

void Scale1()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("scale_start_index_1");
		uint32_t endIndex   = read_uint32("scale_end_index_1");
		__ScaleLoop(startIndex, endIndex,diagProd)
		write_uint8("done_scale_1",1);
	}
}


#ifdef USE4
void Scale2()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("scale_start_index_2");
		uint32_t endIndex   = read_uint32("scale_end_index_2");
		__ScaleLoop(startIndex, endIndex,diagProd)
		write_uint8("done_scale_2",1);
	}
}

void Scale3()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("scale_start_index_3");
		uint32_t endIndex   = read_uint32("scale_end_index_3");
		__ScaleLoop(startIndex, endIndex,diagProd)
		write_uint8("done_scale_3",1);
	}
}
#endif

// the second stage:  update the products.
void productStage()
{
	uint32_t sIndex, eIndex;
#ifdef USE4
	uint32_t chunkSize = (nFaces >> 2);
#else
	uint32_t chunkSize = (nFaces >> 1);
#endif

	sIndex = 0; eIndex = chunkSize;
	write_uint32("product_start_index_0", sIndex);
	write_uint32("product_end_index_0", eIndex);

#ifdef USE4
	sIndex = eIndex; eIndex += chunkSize;
#else
	sIndex = eIndex; eIndex = nFaces;
#endif
	write_uint32("product_start_index_1", sIndex);
	write_uint32("product_end_index_1", eIndex);

#ifdef USE4
	sIndex = eIndex; eIndex += chunkSize;
	write_uint32("product_start_index_2", sIndex);
	write_uint32("product_end_index_2", eIndex);

	sIndex = eIndex; eIndex = nFaces;
	write_uint32("product_start_index_3", sIndex);
	write_uint32("product_end_index_3", eIndex);
#endif
	uint8_t d0= read_uint8("done_product_0");
	uint8_t d1= read_uint8("done_product_1");
#ifdef USE4
	uint8_t d2= read_uint8("done_product_2");
	uint8_t d3= read_uint8("done_product_3");
#endif

	return;
}

#endif

// remember to add the diagonal entry.. 
#define __Contrib(idx,id,tmp) {uint32_t x = idx+id; uint32_t u0 = uPtr[x]; uint32_t l0 = lPtr[x];\
      tmp[u0] += (lowerPtr[x]*psiPtrCell[l0]);\
      tmp[l0] += (upperPtr[x]*psiPtrCell[u0]);}

#define __ProductLoop(startIndex, endIndex,tmp) {\
		uint32_t idx;\
		uint32_t endIndex_r = startIndex + (((endIndex-startIndex) >> 2) << 2);\
		for(idx = startIndex; idx < endIndex_r; idx = idx+4)\
		{\
			loop_pipelining_on();\
			__Contrib(idx,0,tmp)\
			__Contrib(idx,1,tmp)\
			__Contrib(idx,2,tmp)\
			__Contrib(idx,3,tmp)\
		}\
		for(idx = endIndex_r; idx < endIndex; idx++)\
		{\
			__Contrib(idx,0,tmp)\
		}\
	    } 

#ifdef PARALLELIZED
void ProductStage0()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("product_start_index_0");
		uint32_t endIndex   = read_uint32("product_end_index_0");
		__ProductLoop(startIndex, endIndex, t0)
		write_uint8("done_product_0",1);
	}
}

void ProductStage1()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("product_start_index_1");
		uint32_t endIndex   = read_uint32("product_end_index_1");
		__ProductLoop(startIndex, endIndex, t1)
		write_uint8("done_product_1",1);
	}
}

#ifdef USE4
void ProductStage2()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("product_start_index_2");
		uint32_t endIndex   = read_uint32("product_end_index_2");
		__ProductLoop(startIndex, endIndex, t2)
		write_uint8("done_product_2",1);
	}
}

void ProductStage3()
{
	while(1)
	{
		uint32_t startIndex = read_uint32("product_start_index_3");
		uint32_t endIndex   = read_uint32("product_end_index_3");
		__ProductLoop(startIndex, endIndex, t3)
		write_uint8("done_product_3",1);
	}
}
#endif

void sumTemporaries()
{
	uint32_t c0;
	uint32_t N = (nCells >> 2) << 2;
    	for(c0 = 0; c0 < N; c0+=4)
    	{
		loop_pipelining_on();
		uint32_t c1 = c0+1;
		uint32_t c2 = c0+2;
		uint32_t c3 = c0+3;
#ifdef USE4
		ApsiPtrCell[c0] = diagProd[c0] + ((t0[c0] + t1[c0]) + (t2[c0] + t3[c0]));
		ApsiPtrCell[c1] = diagProd[c1] + ((t0[c1] + t1[c1]) + (t2[c1] + t3[c1]));
		ApsiPtrCell[c2] = diagProd[c2] + ((t0[c2] + t1[c2]) + (t2[c2] + t3[c2]));
		ApsiPtrCell[c3] = diagProd[c3] + ((t0[c3] + t1[c3]) + (t2[c3] + t3[c3]));
#else
		ApsiPtrCell[c0] = diagProd[c0] + (t0[c0] + t1[c0]);
		ApsiPtrCell[c1] = diagProd[c1] + (t0[c1] + t1[c1]);
		ApsiPtrCell[c2] = diagProd[c2] + (t0[c2] + t1[c2]);
		ApsiPtrCell[c3] = diagProd[c3] + (t0[c3] + t1[c3]);
#endif
	}

	for(c0 = N; c0 < nCells; c0++)
	{
#ifdef USE4
		ApsiPtrCell[c0] = diagProd[c0] + ((t0[c0] + t1[c0]) + (t2[c0] + t3[c0]));
#else
		ApsiPtrCell[c0] = diagProd[c0] + (t0[c0] + t1[c0]);
#endif
	}
}

#endif

/*---------------------------------------------------------------------------*\
 
Description
    C Kernel to multiply a given vector (second argument) by the matrix or its transpose
    and return the result in the first argument for OpenFOAM.

Written by
    S. Gopalakrishnan
    Dept. of Mechanical Engg.
    Indian Institute of Technology Bombay
    March 2013

\*---------------------------------------------------------------------------*/
#ifdef PARALLELIZED
void AMulMatVec()
{
    // wait for initTemps to finish.
    uint8_t s = read_uint8("done_init_temps");

    // call the scale function
    scaleEntries();

    __debugLog__

    productStage();

    __debugLog__

    sumTemporaries();

    __debugLog__
}
#else
void AMulMatVec()
{
	__ScaleLoop(0,nCells,ApsiPtrCell);

    	__debugLog__;
	
    	__ProductLoop(0, nFaces,ApsiPtrCell);

    	__debugLog__;
}
#endif

