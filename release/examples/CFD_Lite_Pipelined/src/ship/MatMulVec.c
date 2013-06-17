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
			
			nCells = read_uint32("num_cells_pipe");
			nFaces = read_uint32("num_faces_pipe");
	
			RFLOAT64BURST("diag_ptr_pipe", diagPtrCell, nCells);

			write_uint8("debug_pipe", 0);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RUINT32BURST("uptr_pipe", uPtr, nFaces);
			write_uint8("debug_pipe", 1);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RUINT32BURST("lptr_pipe", lPtr, nFaces);
			write_uint8("debug_pipe", 2);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RFLOAT64BURST("upper_ptr_pipe", upperPtr, nFaces);
			write_uint8("debug_pipe", 3);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);

			RFLOAT64BURST("lower_ptr_pipe", lowerPtr, nFaces);
			write_uint8("debug_pipe", 4);

			dbg_time = getClockTime();	
			write_uint32("debug_timer_pipe", dbg_time);
		}

		RFLOAT64BURST("b_pipe",psiPtrCell,nCells);
		write_uint8("debug_pipe", 5);

		dbg_time = getClockTime();	
		write_uint32("debug_timer_pipe", dbg_time);

  		AMulMatVec();
		write_uint8("debug_pipe", 6);

		dbg_time = getClockTime();	
		write_uint32("debug_timer_pipe", dbg_time);

		WFLOAT64BURST("Axb_pipe", ApsiPtrCell, nCells);
		write_uint8("debug_pipe", 7);

		dbg_time = getClockTime();	
		write_uint32("debug_timer_pipe", dbg_time);


		// read new_problem.. if it is 1, go back and
		// repopulate the matrices.
		new_problem = read_uint8("new_problem_pipe");
	}
}

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
void AMulMatVec()
{
  uint32_t cell,face;
  uint32_t dbg_time;
    for(cell = 0; cell < nCells; cell++)
    {
	loop_pipelining_on();
        ApsiPtrCell[cell] = diagPtrCell[cell]*psiPtrCell[cell];
	write_uint8("debug_pipe",cell);
	dbg_time = getClockTime();	
	write_uint32("debug_timer_pipe", dbg_time);
    }
    
  
  
    for(face = 0; face < nFaces; face++)
    {
      loop_pipelining_on();
      ApsiPtrCell[uPtr[face]] += lowerPtr[face]*psiPtrCell[lPtr[face]];
      ApsiPtrCell[lPtr[face]] += upperPtr[face]*psiPtrCell[uPtr[face]];
      write_uint8("debug_pipe",face);
      dbg_time = getClockTime();	
      write_uint32("debug_timer_pipe", dbg_time);
    }
}

