/*---------------------------------------------------------------------------*\

  Description
  C Driver to test C Kernel to multiply a given vector (second argument) by the matrix or its transpose
  and return the result in the first argument for OpenFOAM.

  Written by
  S. Gopalakrishnan
  Dept. of Mechanical Engg.
  Indian Institute of Technology Bombay
  April 2013

  Modified for translation-to-hardware by M. P. Desai

  \*---------------------------------------------------------------------------*/
#include <pthread.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif
#include "MatMulVec.h"
#include "Macros.h"

// In the SW version, we will start the Daemon from here.
// In the hardware version, the Daemon is on the hardware
// side, and thus need not be started.
#ifdef SW
DEFINE_THREAD(MatMulDaemon);
#endif

// A temporary thread to track execution progress.
void debugLog()
{
	while(1)
	{
		uint8_t dbg = read_uint8("debug_pipe");
		fprintf(stderr,"Info: debug_pipe = %u.\n",dbg);

		uint32_t dbg_time = read_uint32("debug_timer_pipe");
		fprintf(stderr,"Info: debug_timer_pipe = %u.\n",dbg_time);
	}
}

// debug thread exists in SW and HW versions.
DEFINE_THREAD(debugLog);

// the reference implementation.. used to check
// the hardware results.
void refAMulMatVec( 
		uint32_t numCells,
		uint32_t numFace,
		double *ApsiPtrCell,
		double *diagPtrCell,
		double *psiPtrCell,
		uint32_t *lPtr,
		uint32_t *uPtr,
		double *lowerPtr,
		double *upperPtr
		)
{
	int cell,face;
	for (cell=0; cell<numCells; cell++)
	{
		ApsiPtrCell[cell] = diagPtrCell[cell]*psiPtrCell[cell];
	}



	for (face=0; face<numFace; face++)
	{
		ApsiPtrCell[uPtr[face]] += lowerPtr[face]*psiPtrCell[lPtr[face]];
		ApsiPtrCell[lPtr[face]] += upperPtr[face]*psiPtrCell[uPtr[face]];
	}


}


// utility function.. sends the matrix info to HW
void packAndSendA( 
		int numCells,
		int numFace,
		double *diagPtrCell,
		int *lPtr,
		int *uPtr,
		double *lowerPtr,
		double *upperPtr
		)
{
	write_uint32("num_cells_pipe", numCells);
	write_uint32("num_faces_pipe", numFace);

	fprintf(stderr,"Sent numCells = %u, numFaces = %u.\n", numCells, numFace);

	WFLOAT64BURST("diag_ptr_pipe", diagPtrCell, numCells);
	fprintf(stderr,"Sent diagPtrCell.\n");

	write_uint32_n("uptr_pipe", uPtr, numFace);
	fprintf(stderr,"Sent uPtr.\n");
	write_uint32_n("lptr_pipe", lPtr, numFace);
	fprintf(stderr,"Sent lPtr.\n");

	WFLOAT64BURST("upper_ptr_pipe", upperPtr, numFace);
	fprintf(stderr,"Sent upperPtr.\n");

	WFLOAT64BURST("lower_ptr_pipe", lowerPtr, numFace);
	fprintf(stderr,"Sent lowerPtr.\n");
}

// utility function.. sends rhs vector to HW.
void packAndSendB(double *B, uint32_t numCells)
{
	WFLOAT64BURST("b_pipe", B, numCells);
	fprintf(stderr,"Sent B.\n");
}

// utility function.. receives matrix-vector product result from HW.
void receiveAndUnpack(double* AxB, uint32_t numCells)
{
	RFLOAT64BURST("Axb_pipe", AxB, numCells);
	fprintf(stderr,"Received AxB.\n");
}

// the driver..
int main(int argc, char *argv[])
{

	// In the SW version, the Daemon is started as a thread.
#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(MatMulDaemon);
	PTHREAD_CREATE(MatMulDaemon);
#endif

	// debug thread to keep getting info from
	// HW.
	PTHREAD_DECL(debugLog);
	PTHREAD_CREATE(debugLog);

	int ret_val = 0;
	if ( argc != 2 ) /* argc should be 2 for correct execution */
	{
		/* We print argv[0] assuming it is the program name */
		printf( "usage: %s filename", argv[0] );
		return(1);
	}
	else
	{
		FILE *fp;
		uint32_t nCells, nFaces;

		double *ApsiPtr,*diagPtr,*psiPtr,*lowerPtr,*upperPtr;
		double *refApsiPtr;

		uint32_t *uPtr,*lPtr;
		uint32_t cell,face;
		struct timeval t1_s,t1_e;
		fp = fopen (argv[1], "rt");

		fscanf(fp, "%d %d", &nCells, &nFaces);

		uPtr=(uint32_t*)malloc(nFaces*sizeof(uint32_t));
		lPtr=(uint32_t*)malloc(nFaces*sizeof(uint32_t));
		upperPtr=(double*)malloc(nFaces*sizeof(double));
		lowerPtr=(double*)malloc(nFaces*sizeof(double));
		ApsiPtr=(double*)malloc(nCells*sizeof(double));
		refApsiPtr=(double*)malloc(nCells*sizeof(double));
		psiPtr=(double*)malloc(nCells*sizeof(double));
		diagPtr=(double*)malloc(nCells*sizeof(double));

		for(face=0;face<nFaces; face++)
			fscanf(fp, "%d %d", &lPtr[face], &uPtr[face]);
		for(face=0;face<nFaces; face++)
			fscanf(fp, "%lf %lf", &lowerPtr[face], &upperPtr[face]);
		for(cell=0;cell<nCells;cell++)
			fscanf(fp, "%lf %lf", &diagPtr[cell], &psiPtr[cell]);

		gettimeofday(&t1_s,0);

		// here's where we send the information to the hardware
		// Send the A matrix.  
		packAndSendA(nCells,nFaces,diagPtr,lPtr,uPtr,lowerPtr,upperPtr); 

		// Send the b vector.  Note that for the same A,
		// we can send multiple b's.
		packAndSendB(psiPtr, nCells); 

		// wait to receive and unpack A.b
		receiveAndUnpack(ApsiPtr,nCells); 

		gettimeofday(&t1_e,0);

		double time_d = (t1_e.tv_sec-t1_s.tv_sec)*1000000 + t1_e.tv_usec - t1_s.tv_usec;
		printf(" \n Time taken is %f microseconds \n",time_d);


		// for reference, we compute the product using the existing
		// soft function.
		refAMulMatVec(nCells,nFaces,refApsiPtr,diagPtr,psiPtr,lPtr,uPtr,lowerPtr,upperPtr); 

		// compare, with a tolerance of EPSILON
		uint32_t idx;
		for(idx = 0; idx < nCells; idx++)
		{
			if(fabs(refApsiPtr[idx] - ApsiPtr[idx]) > EPSILON)
			{
				fprintf(stderr, "Error: entry %d, expected %le, received %le.\n",
						idx, refApsiPtr[idx], ApsiPtr[idx]);
				ret_val = 1;
			}
		}
		if(ret_val == 0)
			fprintf(stderr,"Info: successful run.. no errors.\n");
	}
#ifdef SW
	PTHREAD_CANCEL(MatMulDaemon);
	close_pipe_handler();
#endif
	PTHREAD_CANCEL(debugLog);
	return (ret_val);
}
