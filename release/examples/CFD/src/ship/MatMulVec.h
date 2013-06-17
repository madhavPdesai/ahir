/*---------------------------------------------------------------------------*\
 
Description
    C Kernel to multiply a given vector (second argument) by the matrix or its transpose
    and return the result in the first argument for OpenFOAM.

Written by
    S. Gopalakrishnan
    Dept. of Mechanical Engg
    Indian Institute of Technology Bombay
    March 2013

Modified for translation-to-hardware by M. P. Desai

\*---------------------------------------------------------------------------*/
// the main routine..  arguments are promoted to globals.
void AMulMatVec( 
		//const int numCells,
		//const int numFace,
		//double *ApsiPtrCell,
		//const double *diagPtrCell,
		//const double *psiPtrCell,
		//const int *lPtr,
		//const int *uPtr,
		//const double *lowerPtr,
		//const double *upperPtr
		 );


// a Daemon (in hardware) which receives the matrix, vector values
// through a pipe from the software driver, calls AMulMatVec and
// returns the result to software through a pipe.
void MatMulDaemon();

