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
		 )
{
  int cell,face;
    for (cell=0; cell<numCells; cell++)
    {
        TpsiPtrCell[cell] = diagPtrCell[cell]*psiPtrCell[cell];
    }

    for (face=0; face<numFace; face++)
    {
        TpsiPtrCell[uPtr[face]] += upperPtr[face]*psiPtrCell[lPtr[face]];
        TpsiPtrCell[lPtr[face]] += lowerPtr[face]*psiPtrCell[uPtr[face]];
    }
}

// void sumAMatVec( 
// 		const int numCells,
// 		const int numFace,
// 		double *sumAPtrCell,
// 		const double *diagPtrCell,
// 		const int *lPtr,
// 		const int *uPtr,
// 		const double *lowerPtr,
// 		const double *upperPtr
// 		 )
// {
//     for (int cell=0; cell<numCells; cell++)
//     {
//       sumAPtrCell[cell] = diagPtrCell[cell];
//     }

//     for (int face=0; face<numFace; face++)
//     {
//       sumAPtrCell[uPtr[face]] += lowerPtr[face];
//       sumAPtrCell[lPtr[face]] += upperPtr[face];
//     }
// }
