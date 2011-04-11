#ifdef RUN
#include <stdio.h>
#endif 
float a[1024];
float b[1024];
float c[1024];

void init(int n)
{
	int i;
	for(i = 0; i < n*n; i++)
	{
		a[i] = 1.0;
		b[i] = 1.0;
		c[i] = 0.0;
	}

}

float start(int N, float alpha, float beta)
{
  int i,j,k;
  int aidx, bidx, cidx;
  float t;

  if(N*N < 1024)
  {
  	for(i = 0; i < N; i++)
     	  for(k = 0; k < N; k++)
	  {
	    t = 0.0;
    	    for(j= 0; j < N; j++)
        	{
               		aidx = (i*N) + j;
               		bidx = (j*N) + k;
               		t += (a[aidx]*b[bidx]);
       		}	
            cidx = (i*N) + k;
	    c[cidx] =  beta*c[cidx] + alpha*t;
	  }

	return(c[0] + c[(N*N)-1]);
  }
  else 
   return(-1.0);
}

int main()
{
	init(2);
	float r = start(2,0.1,0.1);
#ifdef RUN
	printf("%f %x\n",r, (*((int*) &r)));
#endif
	return(0);
}

