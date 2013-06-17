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

// for convenience.. global pointers.
double *ApsiPtr,*diagPtr,*psiPtr,*lowerPtr_t,*upperPtr_t;
uint32_t *uPtr_t = NULL,*lPtr_t = NULL;

// In the SW version, we will start the Daemon from here.
// In the hardware version, the Daemon is on the hardware
// side, and thus need not be started.
#ifdef SW
DEFINE_THREAD(MatMulDaemon);
DEFINE_THREAD(getDiagPtr);
DEFINE_THREAD(getLPtr);
DEFINE_THREAD(getUPtr);
DEFINE_THREAD(getLowerPtr);
DEFINE_THREAD(getUpperPtr);
DEFINE_THREAD(getB);

#ifdef PARALLELIZED
DEFINE_THREAD(initTemps);
DEFINE_THREAD(Scale0);
DEFINE_THREAD(Scale1);
DEFINE_THREAD(ProductStage0);
DEFINE_THREAD(ProductStage1);
#ifdef USE4
DEFINE_THREAD(Scale2);
DEFINE_THREAD(Scale3);
DEFINE_THREAD(ProductStage2);
DEFINE_THREAD(ProductStage3);
#endif
#endif
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
		uint32_t *lPtr_t,
		uint32_t *uPtr_t,
		double *lowerPtr_t,
		double *upperPtr_t
		)
{
	int cell,face;
	for (cell=0; cell<numCells; cell++)
	{
		ApsiPtrCell[cell] = diagPtrCell[cell]*psiPtrCell[cell];
	}



	for (face=0; face<numFace; face++)
	{
		ApsiPtrCell[uPtr_t[face]] += lowerPtr_t[face]*psiPtrCell[lPtr_t[face]];
		ApsiPtrCell[lPtr_t[face]] += upperPtr_t[face]*psiPtrCell[uPtr_t[face]];
	}


}

void sendDiagPtr(void* s)
{
	int n  = *((int*)s);
	WFLOAT64BURST("diag_ptr_pipe", diagPtr, n);
}

void sendLPtr(void* s)
{
	int n  = *((int*)s);
	WUINT32BURST("lptr_pipe", lPtr_t, n);
}
void sendUPtr(void* s)
{
	int n  = *((int*)s);
	WUINT32BURST("uptr_pipe", uPtr_t, n);
}
void sendUpperPtr(void* s)
{
	int n  = *((int*)s);
	WFLOAT64BURST("upper_ptr_pipe", upperPtr_t, n);
}
void sendLowerPtr(void* s)
{
	int n  = *((int*)s);
	WFLOAT64BURST("lower_ptr_pipe", lowerPtr_t, n);
}
void sendB(void* s)
{
	int n  = *((int*)s);
	WFLOAT64BURST("b_pipe", psiPtr, n);
}


DEFINE_THREAD_WITH_ARG(sendDiagPtr);
DEFINE_THREAD_WITH_ARG(sendLPtr);
DEFINE_THREAD_WITH_ARG(sendUPtr);
DEFINE_THREAD_WITH_ARG(sendLowerPtr);
DEFINE_THREAD_WITH_ARG(sendUpperPtr);
DEFINE_THREAD_WITH_ARG(sendB);

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
	init_pipe_handler_with_log("pipeHandler.log");
	PTHREAD_DECL(MatMulDaemon);
	PTHREAD_CREATE(MatMulDaemon);

	PTHREAD_DECL(getDiagPtr);
	PTHREAD_DECL(getLPtr);
	PTHREAD_DECL(getUPtr);
	PTHREAD_DECL(getLowerPtr);
	PTHREAD_DECL(getUpperPtr);
	PTHREAD_DECL(getB);

	PTHREAD_CREATE(getDiagPtr);
	PTHREAD_CREATE(getLPtr);
	PTHREAD_CREATE(getUPtr);
	PTHREAD_CREATE(getLowerPtr);
	PTHREAD_CREATE(getUpperPtr);
	PTHREAD_CREATE(getB);

#ifdef PARALLELIZED
	PTHREAD_DECL(initTemps);
	PTHREAD_DECL(Scale0);
	PTHREAD_DECL(Scale1);
	PTHREAD_DECL(ProductStage0);
	PTHREAD_DECL(ProductStage1);
	PTHREAD_CREATE(initTemps);
	PTHREAD_CREATE(Scale0);
	PTHREAD_CREATE(Scale1);
	PTHREAD_CREATE(ProductStage0);
	PTHREAD_CREATE(ProductStage1);
#ifdef USE4
	PTHREAD_DECL(Scale2);
	PTHREAD_DECL(Scale3);
	PTHREAD_DECL(ProductStage2);
	PTHREAD_DECL(ProductStage3);
	PTHREAD_CREATE(Scale2);
	PTHREAD_CREATE(Scale3);
	PTHREAD_CREATE(ProductStage2);
	PTHREAD_CREATE(ProductStage3);
#endif
#endif
#endif

	// debug thread to keep getting info from
	// HW.
	PTHREAD_DECL(debugLog);
	PTHREAD_CREATE(debugLog);


	// send data threads.. this will
	// send all the data in parallel.. faster sims!
	PTHREAD_DECL(sendDiagPtr);
	PTHREAD_DECL(sendLPtr);
	PTHREAD_DECL(sendUPtr);
	PTHREAD_DECL(sendLowerPtr);
	PTHREAD_DECL(sendUpperPtr);
	PTHREAD_DECL(sendB);


	int ret_val = 0;
	{
		FILE *fp;
		uint32_t nCells, nFaces;
		srand48(1193);


		nCells = ORDER;
		nFaces = ORDER;

		uint32_t cell,face;
		struct timeval t1_s,t1_e;
		fp = fopen (argv[1], "rt");

		uPtr_t=(uint32_t*)malloc(nFaces*sizeof(uint32_t));
		lPtr_t=(uint32_t*)malloc(nFaces*sizeof(uint32_t));
		upperPtr_t=(double*)malloc(nFaces*sizeof(double));
		lowerPtr_t=(double*)malloc(nFaces*sizeof(double));
		ApsiPtr=(double*)malloc(nCells*sizeof(double));
		double* refApsiPtr=(double*)malloc(nCells*sizeof(double));
		psiPtr=(double*)malloc(nCells*sizeof(double));
		diagPtr=(double*)malloc(nCells*sizeof(double));

		for(face=0;face<nFaces; face++)
		{
			lPtr_t[face] = face; uPtr_t[face] = face;
		}
		for(face=0;face<nFaces; face++)
		{
			lowerPtr_t[face] = drand48(); upperPtr_t[face] = drand48();
		}
		for(cell=0;cell<nCells;cell++)
		{
			diagPtr[cell] = drand48();  psiPtr[cell] = drand48();
		}

		gettimeofday(&t1_s,0);

		// here's where we send the information to the hardware
		// Send the A matrix.  
		fprintf(stderr,"Sending numCells = %u, numFaces = %u.\n", nCells, nFaces);
		write_uint32("num_cells_pipe", nCells);
		write_uint32("num_faces_pipe", nFaces);
		fprintf(stderr,"Sent numCells = %u, numFaces = %u.\n", nCells, nFaces);

		PTHREAD_CREATE_WITH_ARG(sendDiagPtr,&nCells);
		PTHREAD_CREATE_WITH_ARG(sendLPtr,&nFaces);
		PTHREAD_CREATE_WITH_ARG(sendUPtr,&nFaces);
		PTHREAD_CREATE_WITH_ARG(sendLowerPtr,&nFaces);
		PTHREAD_CREATE_WITH_ARG(sendUpperPtr,&nFaces);
		PTHREAD_CREATE_WITH_ARG(sendB,&nCells);


		PTHREAD_JOIN(sendDiagPtr);
		PTHREAD_JOIN(sendLPtr);
		PTHREAD_JOIN(sendUPtr);
		PTHREAD_JOIN(sendLowerPtr);
		PTHREAD_JOIN(sendUpperPtr);
		PTHREAD_JOIN(sendB);

		fprintf(stderr,"Finished sending info to HW.\n");
	
		// wait to receive and unpack A.b
		receiveAndUnpack(ApsiPtr,nCells); 

		gettimeofday(&t1_e,0);

		double time_d = (t1_e.tv_sec-t1_s.tv_sec)*1000000 + t1_e.tv_usec - t1_s.tv_usec;
		printf(" \n Time taken is %f microseconds \n",time_d);


		// for reference, we compute the product using the existing
		// soft function.
		refAMulMatVec(nCells,nFaces,refApsiPtr,diagPtr,psiPtr,lPtr_t,uPtr_t,lowerPtr_t,upperPtr_t); 

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
			//else
			//fprintf(stderr, "Info: entry %d, expected %le, received %le.\n",
			//idx, refApsiPtr[idx], ApsiPtr[idx]);
		}
		if(ret_val == 0)
			fprintf(stderr,"Info: successful run.. no errors.\n");
	}
#ifdef SW
	PTHREAD_CANCEL(MatMulDaemon);
	PTHREAD_CANCEL(getDiagPtr);
	PTHREAD_CANCEL(getLPtr);
	PTHREAD_CANCEL(getUPtr);
	PTHREAD_CANCEL(getLowerPtr);
	PTHREAD_CANCEL(getUpperPtr);
	PTHREAD_CANCEL(getB);
	close_pipe_handler();
#ifdef PARALLELIZED
	PTHREAD_CANCEL(initTemps);
	PTHREAD_CANCEL(Scale0);
	PTHREAD_CANCEL(Scale1);
	PTHREAD_CANCEL(ProductStage0);
	PTHREAD_CANCEL(ProductStage1);
#ifdef USE4
	PTHREAD_CANCEL(Scale2);
	PTHREAD_CANCEL(Scale3);
	PTHREAD_CANCEL(ProductStage2);
	PTHREAD_CANCEL(ProductStage3);
#endif
#endif
#endif
	PTHREAD_CANCEL(debugLog);
	PTHREAD_CANCEL(sendDiagPtr);
	PTHREAD_CANCEL(sendLPtr);
	PTHREAD_CANCEL(sendUPtr);
	PTHREAD_CANCEL(sendLowerPtr);
	PTHREAD_CANCEL(sendUpperPtr);
	PTHREAD_CANCEL(sendB);
	return (ret_val);
}
