/*---------------------------------------------------------------------------*\
 
Description
    C Driver to test C Kernel to multiply a given vector (second argument) by the matrix or its transpose
    and return the result in the first argument for OpenFOAM.

Written by
    S. Gopalakrishnan
    Dept. of Mechanical Engg.
    Indian Institute of Technology Bombay
    April 2013

\*---------------------------------------------------------------------------*/
#include "stdio.h"
#include "stdlib.h"
#include "MatMulVec.h"

int main(int argc, char *argv[])

{
  if ( argc != 2 ) /* argc should be 2 for correct execution */
    {
        /* We print argv[0] assuming it is the program name */
        printf( "usage: %s filename", argv[0] );
    }
  else
    {
  FILE *fp;
  int nCells, nFaces;
  double *ApsiPtr,*diagPtr,*psiPtr,*lowerPtr,*upperPtr;
  int *uPtr,*lPtr;
  int cell,face;
  struct timeval t1_s,t1_e;
  fp = fopen (argv[1], "rt");

  fscanf(fp, "%d %d", &nCells, &nFaces);

  uPtr=(int*)malloc(nFaces*sizeof(int));
  lPtr=(int*)malloc(nFaces*sizeof(int));
  upperPtr=(double*)malloc(nFaces*sizeof(double));
  lowerPtr=(double*)malloc(nFaces*sizeof(double));
  ApsiPtr=(double*)malloc(nCells*sizeof(double));
  psiPtr=(double*)malloc(nCells*sizeof(double));
  diagPtr=(double*)malloc(nCells*sizeof(double));

  for(face=0;face<nFaces; face++)
    fscanf(fp, "%d %d", &lPtr[face], &uPtr[face]);
  for(face=0;face<nFaces; face++)
    fscanf(fp, "%lf %lf", &lowerPtr[face], &upperPtr[face]);
  for(cell=0;cell<nCells;cell++)
    fscanf(fp, "%lf %lf", &diagPtr[cell], &psiPtr[cell]);

  gettimeofday(&t1_s,0);
  AMulMatVec(nCells,nFaces,ApsiPtr,diagPtr,psiPtr,lPtr,uPtr,lowerPtr,upperPtr); 
  gettimeofday(&t1_e,0);
  double time_d = (t1_e.tv_sec-t1_s.tv_sec)*1000000 + t1_e.tv_usec - t1_s.tv_usec;
  printf(" \n Time taken is %f microseconds \n",time_d);
    }

  return 0;
}
