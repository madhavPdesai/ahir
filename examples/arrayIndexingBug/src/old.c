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


// all arrays will be statically declared, and will
// have a maximum size.  
double diagPtrCell[BUFSIZE], psiPtrCell[BUFSIZE], ApsiPtrCell[BUFSIZE];
uint32_t uPtr[BUFSIZE], lPtr[BUFSIZE];
double lowerPtr[BUFSIZE], upperPtr[BUFSIZE];

// listen in and get matrix etc..
void MatMulDaemon()
{
	uint8_t new_problem = 1;
	uint32_t dbg_time;
	
	while(1)
	{
		if(new_problem)
		{
			new_problem = 0;
	
			RFLOAT64BURST("diag_ptr_pipe", diagPtrCell, BUFSIZE);

			write_uint8("debug_pipe", 0);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RUINT32BURST("uptr_pipe", uPtr, BUFSIZE);
			write_uint8("debug_pipe", 1);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RUINT32BURST("lptr_pipe", lPtr, BUFSIZE);
			write_uint8("debug_pipe", 2);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RFLOAT64BURST("upper_ptr_pipe", upperPtr, BUFSIZE);
			write_uint8("debug_pipe", 3);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RFLOAT64BURST("lower_ptr_pipe", lowerPtr, BUFSIZE);
			write_uint8("debug_pipe", 4);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);
		}

		RFLOAT64BURST("b_pipe",psiPtrCell,BUFSIZE);
		write_uint8("debug_pipe", 5);

		dbg_time = getClockTime();	
		write_uint32("debug_timer_pipe", dbg_time);

  		AMulMatVec();

		WFLOAT64BURST("Axb_pipe", ApsiPtrCell, BUFSIZE);

		write_uint8("debug_pipe", 8);
		dbg_time = getClockTime();	
		write_uint32("debug_timer_pipe", dbg_time);


		// read new_problem.. if it is 1, go back and
		// repopulate the matrices.
		new_problem = read_uint8("new_problem_pipe");
	}
}


void AMulMatVec()
{
  uint32_t cell,face;
  uint32_t dbg_time;

    // unroll by 8.
#ifdef UNROLL
    uint32_t ncells_r = ((BUFSIZE << 2) >> 2);
    for(cell = 0; cell < ncells_r; cell=cell+4)
    {
	loop_pipelining_on();

	uint32_t c0 = cell;
	uint32_t c1 = cell+1;
	uint32_t c2 = cell+2;
	uint32_t c3 = cell+3;


        double p0 = diagPtrCell[c0]*psiPtrCell[c0];
        double p1 = diagPtrCell[c1]*psiPtrCell[c1];
        double p2 = diagPtrCell[c2]*psiPtrCell[c2];
        double p3 = diagPtrCell[c3]*psiPtrCell[c3];

        ApsiPtrCell[c0] = p0;
        ApsiPtrCell[c1] = p1;
        ApsiPtrCell[c2] = p2;
        ApsiPtrCell[c3] = p3;
    }
#else
  uint32_t ncells_r = 0;
#endif
   
    // residual..
    for(cell = ncells_r; cell < BUFSIZE; cell++)
    {
        ApsiPtrCell[cell] = diagPtrCell[cell]*psiPtrCell[cell];
    }
		
    write_uint8("debug_pipe", 6);
    dbg_time = getClockTime();	
    write_uint32("debug_timer_pipe", dbg_time);
    
#ifdef UNROLL
    uint32_t nfaces_r = ((BUFSIZE << 2) >> 2);
    for(face = 0; face < nfaces_r; face = face+4)
    {
      loop_pipelining_on();
      uint32_t f0 = face;
      uint32_t f1 = face+1;
      uint32_t f2 = face+2;
      uint32_t f3 = face+3;

	uint32_t u0 = uPtr[f0];
	uint32_t u1 = uPtr[f1];
	uint32_t u2 = uPtr[f2];
	uint32_t u3 = uPtr[f3];

	uint32_t l0 = lPtr[f0];
	uint32_t l1 = lPtr[f1];
	uint32_t l2 = lPtr[f2];
	uint32_t l3 = lPtr[f3];

	double pu0 = lowerPtr[f0]*psiPtrCell[l0];
	double pl0 = upperPtr[f0]*psiPtrCell[u0];

	double pu1 = lowerPtr[f1]*psiPtrCell[l1];
	double pl1 = upperPtr[f1]*psiPtrCell[u1];

	double pu2 = lowerPtr[f2]*psiPtrCell[l2];
	double pl2 = upperPtr[f2]*psiPtrCell[u2];

	double pu3 = lowerPtr[f3]*psiPtrCell[l3];
	double pl3 = upperPtr[f3]*psiPtrCell[u3];

#define _Contrib(x) {uint32_t u0 = uPtr[x]; uint32_t l0 = lPtr[x];\
      double pu = lowerPtr[x]*psiPtrCell[l0];\
      double pl = upperPtr[x]*psiPtrCell[u0];\
      ApsiPtrCell[u0] += pu;\
      ApsiPtrCell[l0] += pl;}

      ApsiPtrCell[u0] += pu0;
      ApsiPtrCell[l0] += pl0;

      ApsiPtrCell[u1] += pu1;
      ApsiPtrCell[l1] += pl1;

      ApsiPtrCell[u2] += pu2;
      ApsiPtrCell[l2] += pl2;

      ApsiPtrCell[u3] += pu3;
      ApsiPtrCell[l3] += pl3;

    }
#else
    uint32_t nfaces_r = 0;
#endif

    for(face = nfaces_r; face < BUFSIZE; face++)
    {
      ApsiPtrCell[uPtr[face]] += lowerPtr[face]*psiPtrCell[lPtr[face]];
      ApsiPtrCell[lPtr[face]] += upperPtr[face]*psiPtrCell[uPtr[face]];
    }

    write_uint8("debug_pipe", 7);
    dbg_time = getClockTime();	
    write_uint32("debug_timer_pipe", dbg_time);
}

