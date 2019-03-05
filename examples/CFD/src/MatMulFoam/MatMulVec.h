/*---------------------------------------------------------------------------*\
 
Description
    C Kernel to multiply a given vector (second argument) by the matrix or its transpose
    and return the result in the first argument for OpenFOAM.

Written by
    S. Gopalakrishnan
    Dept. of Mechanical Engg
    Indian Institute of Technology Bombay
    March 2013

\*---------------------------------------------------------------------------*/
void AMulMatVec( 
		const int numCells,
		const int numFace,
		double *ApsiPtrCell,
		const double *diagPtrCell,
		const double *psiPtrCell,
		const int *lPtr,
		const int *uPtr,
		const double *lowerPtr,
		const double *upperPtr
		 );

void TMulMatVec( 
		const int numCells,
		const int numFace,
		double *TpsiPtrCell,
		const double *diagPtrCell,
		const double *psiPtrCell,
		const int *lPtr,
		const int *uPtr,
		const double *lowerPtr,
		const double *upperPtr
		 );

void sumAMatVec( 
		const int numCells,
		const int numFace,
		double *sumAPtrCell,
		const double *diagPtrCell,
		const int *lPtr,
		const int *uPtr,
		const double *lowerPtr,
		const double *upperPtr
		 );
