/*

Translated to C by Bonnie Toy 5/88
  (modified on 2/25/94  to fix a problem with daxpy  for
   unequal increments or equal increments not equal to 1.
     Jack Dongarra)

To compile single precision version for Sun-4:

	cc -DSP -O4 -fsingle -fsingle2 clinpack.c -lm

To compile double precision version for Sun-4:

	cc -DDP -O4 clinpack.c -lm

To obtain rolled source BLAS, add -DROLL to the command lines.
To obtain unrolled source BLAS, add -DUNROLL to the command lines.

You must specify one of -DSP or -DDP to compile correctly.

You must specify one of -DROLL or -DUNROLL to compile correctly.

*/

#define SP
#define ROLL

#define fabs(x) (x < 0.0 ? -x : x)

#ifdef SP
#define REAL float
#define ZERO 0.0
#define ONE 1.0
#define PREC "Single "
#endif

#ifdef DP
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "
#endif

#define NTIMES 10

#ifdef ROLL
#define ROLLING "Rolled "
#endif
#ifdef UNROLL
#define ROLLING "Unrolled "
#endif

int idamax(int n, REAL dx[], int incx);
void daxpy(int n, REAL da, REAL dx[], int incx, REAL dy[], int incy);
REAL ddot(int n, REAL dx[], int incx, REAL dy[], int incy);
void dgefa(REAL a[], int lda, int n, int ipvt[], int *info);
void dgesl(REAL a[], int lda, int n, int ipvt[], REAL b[], int job);
void dscal(int n, REAL da, REAL dx[], int incx);

float divide( float dividend, float divisor)
{
  float xi, ni, di, ret;
  char sign = 1;

  if (dividend < 0) {
      ni = -dividend;
      sign = -1;
  } else
      ni = dividend;
  
  if (divisor < 0) {
      di = -divisor;
      sign = -sign;
  } else
      di = divisor;

  while (di <= 0.5) {
    di = di * 2;
    ni = ni * 2;
  }

  while (di > 1) {
    di = di * 0.5;
    ni = ni * 0.5;
  }

  xi = (float)2.9142 - 2*di;

  xi = xi * (2 - di*xi);
  xi = xi * (2 - di*xi);
  xi = xi * (2 - di*xi);
  xi = xi * (2 - di*xi);

  ret = ni * xi;

  if (sign == 1)
      return ret;
  else
      return -ret;
}

/*----------------------*/ 
void dscal(int n, REAL da, REAL dx[], int incx)

/*     scales a vector by a constant.
      jack dongarra, linpack, 3/11/78.
*/
{
	int i,m,mp1,nincx;

	if(n <= 0)return;
	if(incx != 1) {

		/* code for increment not equal to 1 */

		nincx = n*incx;
		for (i = 0; i < nincx; i = i + incx)
			dx[i] = da*dx[i];
		return;
	}

	/* code for increment equal to 1 */

#ifdef ROLL
	for (i = 0; i < n; i++)
		dx[i] = da*dx[i];
#endif
#ifdef UNROLL

	m = n % 5;
	if (m != 0) {
		for (i = 0; i < m; i++)
			dx[i] = da*dx[i];
		if (n < 5) return;
	}
	for (i = m; i < n; i = i + 5){
		dx[i] = da*dx[i];
		dx[i+1] = da*dx[i+1];
		dx[i+2] = da*dx[i+2];
		dx[i+3] = da*dx[i+3];
		dx[i+4] = da*dx[i+4];
	}
#endif

}


/*----------------------*/ 
void dgefa(REAL a[], int lda, int n, int ipvt[], int *info)

/* We would like to declare a[][lda], but c does not allow it.  In this
function, references to a[i][j] are written a[lda*i+j].  */
/*
     dgefa factors a double precision matrix by gaussian elimination.

     dgefa is usually called by dgeco, but it can be called
     directly with a saving in time if  rcond  is not needed.
     (time for dgeco) = (1 + 9/n)*(time for dgefa) .

     on entry

        a       REAL precision[n][lda]
                the matrix to be factored.

        lda     integer
                the leading dimension of the array  a .

        n       integer
                the order of the matrix  a .

     on return

        a       an upper triangular matrix and the multipliers
                which were used to obtain it.
                the factorization can be written  a = l*u  where
                l  is a product of permutation and unit lower
                triangular matrices and  u  is upper triangular.

        ipvt    integer[n]
                an integer vector of pivot indices.

        info    integer
                = 0  normal value.
                = k  if  u[k][k] .eq. 0.0 .  this is not an error
                     condition for this subroutine, but it does
                     indicate that dgesl or dgedi will divide by zero
                     if called.  use  rcond  in dgeco for a reliable
                     indication of singularity.

     linpack. this version dated 08/14/78 .
     cleve moler, university of new mexico, argonne national lab.

     functions

     blas daxpy,dscal,idamax
*/

{
/*     internal variables	*/

REAL t;
int j,k,kp1,l,nm1;


/*     gaussian elimination with partial pivoting	*/

	*info = 0;
	nm1 = n - 1;
	if (nm1 >=  0) {
		for (k = 0; k < nm1; k++) {
			kp1 = k + 1;

          		/* find l = pivot index	*/

			l = idamax(n-k,&a[lda*k+k],1) + k;
			ipvt[k] = l;

			/* zero pivot implies this column already 
			   triangularized */

			if (a[lda*k+l] != ZERO) {

				/* interchange if necessary */

				if (l != k) {
					t = a[lda*k+l];
					a[lda*k+l] = a[lda*k+k];
					a[lda*k+k] = t; 
				}

				/* compute multipliers */

				t = divide(-ONE, a[lda*k+k]);
				dscal(n-(k+1),t,&a[lda*k+k+1],1);

				/* row elimination with column indexing */

				for (j = kp1; j < n; j++) {
					t = a[lda*j+l];
					if (l != k) {
						a[lda*j+l] = a[lda*j+k];
						a[lda*j+k] = t;
					}
					daxpy(n-(k+1),t,&a[lda*k+k+1],1,
					      &a[lda*j+k+1],1);
  				} 
  			}
			else { 
            			*info = k;
			}
		} 
	}
	ipvt[n-1] = n-1;
	if (a[lda*(n-1)+(n-1)] == ZERO) *info = n-1;
}

/*----------------------*/ 

void dgesl(REAL a[], int lda, int n, int ipvt[], REAL b[], int job)

/* We would like to declare a[][lda], but c does not allow it.  In this
function, references to a[i][j] are written a[lda*i+j].  */

/*
     dgesl solves the double precision system
     a * x = b  or  trans(a) * x = b
     using the factors computed by dgeco or dgefa.

     on entry

        a       double precision[n][lda]
                the output from dgeco or dgefa.

        lda     integer
                the leading dimension of the array  a .

        n       integer
                the order of the matrix  a .

        ipvt    integer[n]
                the pivot vector from dgeco or dgefa.

        b       double precision[n]
                the right hand side vector.

        job     integer
                = 0         to solve  a*x = b ,
                = nonzero   to solve  trans(a)*x = b  where
                            trans(a)  is the transpose.

    on return

        b       the solution vector  x .

     error condition

        a division by zero will occur if the input factor contains a
        zero on the diagonal.  technically this indicates singularity
        but it is often caused by improper arguments or improper
        setting of lda .  it will not occur if the subroutines are
        called correctly and if dgeco has set rcond .gt. 0.0
        or dgefa has set info .eq. 0 .

     to compute  inverse(a) * c  where  c  is a matrix
     with  p  columns
           dgeco(a,lda,n,ipvt,rcond,z)
           if (!rcond is too small){
           	for (j=0,j<p,j++)
              		dgesl(a,lda,n,ipvt,c[j][0],0);
	   }

     linpack. this version dated 08/14/78 .
     cleve moler, university of new mexico, argonne national lab.

     functions

     blas daxpy,ddot
*/
{
/*     internal variables	*/

	REAL t;
	int k,kb,l,nm1;

	nm1 = n - 1;
	if (job == 0) {

		/* job = 0 , solve  a * x = b
		   first solve  l*y = b    	*/

		if (nm1 >= 1) {
			for (k = 0; k < nm1; k++) {
				l = ipvt[k];
				t = b[l];
				if (l != k){ 
					b[l] = b[k];
					b[k] = t;
				}	
				daxpy(n-(k+1),t,&a[lda*k+k+1],1,&b[k+1],1);
			}
		} 

		/* now solve  u*x = y */

		for (kb = 0; kb < n; kb++) {
		    k = n - (kb + 1);
		    b[k] = divide(b[k],a[lda*k+k]);
		    t = -b[k];
		    daxpy(k,t,&a[lda*k+0],1,&b[0],1);
		}
	}
	else { 

		/* job = nonzero, solve  trans(a) * x = b
		   first solve  trans(u)*y = b 			*/

		for (k = 0; k < n; k++) {
			t = ddot(k,&a[lda*k+0],1,&b[0],1);
			b[k] = divide(b[k] - t ,a[lda*k+k]);
		}

		/* now solve trans(l)*x = y	*/

		if (nm1 >= 1) {
			for (kb = 1; kb < nm1; kb++) {
				k = n - (kb+1);
				b[k] = b[k] + ddot(n-(k+1),&a[lda*k+k+1],1,&b[k+1],1);
				l = ipvt[k];
				if (l != k) {
					t = b[l];
					b[l] = b[k];
					b[k] = t;
				}
			}
		}
	}
}

/*----------------------*/ 

void daxpy(int n, REAL da, REAL dx[], int incx, REAL dy[], int incy)
/*
     constant times a vector plus a vector.
     jack dongarra, linpack, 3/11/78.
*/
{
	int i,ix,iy,m,mp1;

	if(n <= 0) return;
	if (da == ZERO) return;

	if(incx != 1 || incy != 1) {

		/* code for unequal increments or equal increments
		   not equal to 1 					*/

		ix = 0;
		iy = 0;
		if(incx < 0) ix = (-n+1)*incx;
		if(incy < 0)iy = (-n+1)*incy;
		for (i = 0;i < n; i++) {
			dy[iy] = dy[iy] + da*dx[ix];
			ix = ix + incx;
			iy = iy + incy;
		}
      		return;
	}

	/* code for both increments equal to 1 */

#ifdef ROLL
	for (i = 0;i < n; i++) {
		dy[i] = dy[i] + da*dx[i];
	}
#endif
#ifdef UNROLL

	m = n % 4;
	if ( m != 0) {
		for (i = 0; i < m; i++) 
			dy[i] = dy[i] + da*dx[i];
		if (n < 4) return;
	}
	for (i = m; i < n; i = i + 4) {
		dy[i] = dy[i] + da*dx[i];
		dy[i+1] = dy[i+1] + da*dx[i+1];
		dy[i+2] = dy[i+2] + da*dx[i+2];
		dy[i+3] = dy[i+3] + da*dx[i+3];
	}
#endif
}
   
/*----------------------*/ 

REAL ddot(int n, REAL dx[], int incx, REAL dy[], int incy)
/*
     forms the dot product of two vectors.
     jack dongarra, linpack, 3/11/78.
*/
{
	REAL dtemp;
	int i,ix,iy,m,mp1;

	dtemp = ZERO;

	if(n <= 0) return(ZERO);

	if(incx != 1 || incy != 1) {

		/* code for unequal increments or equal increments
		   not equal to 1					*/

		ix = 0;
		iy = 0;
		if (incx < 0) ix = (-n+1)*incx;
		if (incy < 0) iy = (-n+1)*incy;
		for (i = 0;i < n; i++) {
			dtemp = dtemp + dx[ix]*dy[iy];
			ix = ix + incx;
			iy = iy + incy;
		}
		return(dtemp);
	}

	/* code for both increments equal to 1 */

#ifdef ROLL
	for (i=0;i < n; i++)
		dtemp = dtemp + dx[i]*dy[i];
	return(dtemp);
#endif
#ifdef UNROLL

	m = n % 5;
	if (m != 0) {
		for (i = 0; i < m; i++)
			dtemp = dtemp + dx[i]*dy[i];
		if (n < 5) return(dtemp);
	}
	for (i = m; i < n; i = i + 5) {
		dtemp = dtemp + dx[i]*dy[i] +
		dx[i+1]*dy[i+1] + dx[i+2]*dy[i+2] +
		dx[i+3]*dy[i+3] + dx[i+4]*dy[i+4];
	}
	return(dtemp);
#endif
}

/*----------------------*/ 
int idamax(int n, REAL dx[], int incx)

/*
     finds the index of element having max. absolute value.
     jack dongarra, linpack, 3/11/78.
*/

{
	REAL dmax;
	int i, ix, itemp;

	if( n < 1 ) return(-1);
	if(n ==1 ) return(0);
	if(incx != 1) {

		/* code for increment not equal to 1 */

		ix = 1;
		dmax = fabs(dx[0]);
		ix = ix + incx;
		for (i = 1; i < n; i++) {
			if(fabs(dx[ix]) > dmax)  {
				itemp = i;
				dmax = fabs(dx[ix]);
			}
			ix = ix + incx;
		}
	}
	else {

		/* code for increment equal to 1 */

		itemp = 0;
		dmax = fabs(dx[0]);
		for (i = 1; i < n; i++) {
			if(fabs(dx[i]) > dmax) {
				itemp = i;
				dmax = fabs(dx[i]);
			}
		}
	}
	return (itemp);
}

#define N 10
#define LDA 10

REAL a[N*LDA];

REAL b[N];

int ipvt[N];
int info;

#define next(x) ((x & 0x00100000) >> 20) ^ ((x & 0x00000100) >> 8) | (x << 1)

void matgen()
{
  int init, i, j;
  float aa;
  short reg = 1325;
  
  for (i = 0; i < N; i++) {
    b[i] = 0.0;
  }
  
  for (j = 0; j < N; j++) {
    for (i = 0; i < N; i++) {
      reg = next(reg);
      init = (int)reg;
      
      aa = divide((float)init, (float)4294967295.0);
      a[LDA*j+i] = aa;
      b[i] = b[i] + aa;
    }
  }
}

float start (void)
{
  matgen();
  dgefa(a,LDA,N,ipvt,&info);
  dgesl(a,LDA,N,ipvt,b,0);
  return b[0];
}

#ifdef RUN

#include <stdio.h>

REAL second()
{
#include <sys/time.h>
#include <sys/resource.h>

struct rusage ru;
REAL t ;

getrusage(RUSAGE_SELF,&ru) ;
 
t = (REAL) (ru.ru_utime.tv_sec+ru.ru_stime.tv_sec) + 
    ((REAL) (ru.ru_utime.tv_usec+ru.ru_stime.tv_usec))/1.0e6 ;
return t ;
}
 
int main (void)
{

    /* We would like to declare a[][lda], but c does not allow it. In
       this function, references to a[i][j] are written a[lda*i+j]. */

    int init, i, j;
    REAL t1, t2, t3;
    REAL A;
    
    init = 1325;
    
    for (i = 0; i < N; i++) {
	b[i] = 0.0;
    }
    
    for (j = 0; j < N; j++) {
	for (i = 0; i < N; i++) {
	    
	    init = 3125*init % 65536;
	    A = (init - 32768.0)/16384.0;
	    b[i] = b[i] + A;
	    a[LDA*j + i] = A;
	}
    }

    printf("%f\n", a[0]);
    dgefa(a,LDA,N,ipvt,&info);
    printf("%f\n", a[0]);
    printf("%f\n", b[0]);
    dgesl(a,LDA,N,ipvt,b,0);
    printf("%f\n", b[0]);
}

#endif
