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

uint32_t pendingCount = 0;
uint32_t nCells, nFaces;

// all arrays will be statically declared, and will
// have a maximum size.  
double diagPtrCell[MaxNumCells], psiPtrCell[MaxNumCells], ApsiPtrCell[MaxNumCells];
uint32_t uPtr[MaxNumFaces], lPtr[MaxNumFaces];
double lowerPtr[MaxNumFaces], upperPtr[MaxNumFaces];

double diagProd[MaxNumCells];
double offDiag[MaxNumCells];


inline void incrCount()
{
	uint8_t l = read_uint8("count_lock");
	pendingCount++;
	write_uint8("count_lock",l);
}

inline void decrCount()
{
	uint8_t l = read_uint8("count_lock");
	pendingCount--;
	write_uint8("count_lock",l);
}


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

// the first stage: start four parallel scalers.
void scaleEntries()
{
	uint32_t idx;
	for(idx = 0; idx < nCells; idx += 4)
	{
#ifdef PIPELINE
		loop_pipelining_on();
#endif
		uint32_t idx1 = idx + 1;
		uint32_t idx2 = idx + 2;
		uint32_t idx3 = idx + 3;

		double p0 = diagPtrCell[idx]*psiPtrCell[idx];
		double p1 = diagPtrCell[idx1]*psiPtrCell[idx1];
		double p2 = diagPtrCell[idx2]*psiPtrCell[idx2];
		double p3 = diagPtrCell[idx3]*psiPtrCell[idx3];

		ApsiPtrCell[idx] = p0;
		ApsiPtrCell[idx1] = p1;
		ApsiPtrCell[idx2] = p2;
		ApsiPtrCell[idx3] = p3;
	}
}


// remember to add the diagonal entry.. 
#define __Contrib(idx,u,l,pu,pl) {u = uPtr[idx]; l = lPtr[idx];\
      pu = (lowerPtr[idx]*psiPtrCell[l]);\
      pl = (upperPtr[idx]*psiPtrCell[u]);}



void productStage()
{
	uint32_t idx;
	for(idx = 0; idx < nFaces; idx += 2)
	{
#ifdef PIPELINE
		loop_pipelining_on();
#endif
		uint32_t u0,l0;
		double pu0,pl0;
		uint32_t u1,l1;
		double pu1,pl1;
		uint32_t idx1 = idx + 1;

		__Contrib(idx,u0,l0,pu0,pl0);
		__Contrib(idx1,u1,l1,pu1,pl1);

		double au0  = ApsiPtrCell[u0];
		double al0  = ApsiPtrCell[l0];
		double au1  = ApsiPtrCell[u1];
		double al1  = ApsiPtrCell[l1];

		uint8_t c01 = (u0 == l0);	
		uint8_t c02 = (u0 == u1);
		uint8_t c03 = (u0 == l1);
		uint8_t c12 = (l0 == u1);	
		uint8_t c13 = (l0 == l1);
		uint8_t c23 = (u1 == l1);	

		double x0 = (au0 + pu0);

		double x1_0 = (c01 ? x0 : al0);
		double x1 = x1_0 + pl0;
		
		double x2_0 = (c02 ? x0 : au1);
		double x2_1 = (c12 ? x1 : x2_0);
		double x2   = x2_1 + pu1;

		double x3_0 = (c03 ? x0 : al1);
		double x3_1 = (c13 ? x1 : x3_0);
		double x3_2 = (c23 ? x2 : x3_1);
		double x3   = x3_2 + pl1;

		ApsiPtrCell[u0] = x0; 
		ApsiPtrCell[l0] = x1;
		ApsiPtrCell[u1] = x2; 
		ApsiPtrCell[l1] = x3;
	}
}


void AMulMatVec()
{
	scaleEntries();
	__debugLog__
	productStage();
	__debugLog__
}
