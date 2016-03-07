#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"

#ifndef SW
void __loop_pipelining_on__(uint32_t val, uint32_t buf, uint32_t extreme_flag);
void __guard__(uint8_t val);
void __cancel_guards__();
#endif

float coeff[ORDER];
float S[ORDER];

#define __STEP(N,k,y) { int J = i+k; int ci; \
			ci = ( (J <= N) ? (N-J) : (ORDER-(J-N)) );\
			float C = coeff[ci];\
			y += (C*S[J]);}
void fir()
{
	int i;
	for(i = 0; i < ORDER; i++)
	{
#ifndef SW
		__loop_pipelining_on__(8,1,0);
#endif
		coeff[i] = read_float32("coeff_pipe");
		S[i] = 0;
	}

#ifdef SW
	fprintf(stderr,"Rx completed.\n");
#endif
	int N = 0;
	i = 0;
	while(1)
	{
		if(i == 0) 
		{
			N = ((N == 0) ? (ORDER-1) : (N-1));
			S[N] = read_float32("in_data_pipe");
		}

#ifndef SW
		__loop_pipelining_on__(8,2,0);
#endif

		float y0=0, y1=0, y2=0, y3=0, y4=0, y5=0, y6=0, y7=0;
		float y8=0, y9=0, y10=0, y11=0, y12=0, y13=0, y14=0, y15=0;

		__STEP(N,0,y0);
		__STEP(N,1,y1);
		__STEP(N,2,y2);
		__STEP(N,3,y3);

		float s0 = ((y0+y1)+(y2+y3));

		__STEP(N,4,y4);
		__STEP(N,5,y5);
		__STEP(N,6,y6);
		__STEP(N,7,y7);

		float s1 = ((y4+y5)+(y6+y7));

		__STEP(N,8,y8);
		__STEP(N,9,y9);
		__STEP(N,10,y10);
		__STEP(N,11,y11);

		float s2 = ((y8+y9)+(y10+y11));

		__STEP(N,12,y12);
		__STEP(N,13,y13);
		__STEP(N,14,y14);
		__STEP(N,15,y15);

		float s3 = ((y12+y13)+(y14+y15));

		float y = ((s0+s1)+(s2+s3));	

			
		write_uint8("sum_flag",0);
		write_float32("sum_pipe",y);

		int ni = (i + 16);
		if(ni < ORDER)
		{
			i = ni;
		}
		else
		{
			write_uint8("sum_flag",1);
			i = 0;
		}
	}
}


void summer()
{
	float Y = 0;
	while(1)
	{
#ifndef SW
		__loop_pipelining_on__(8,1,0);
#endif
		uint8_t sflag = read_uint8("sum_flag");	

		if(sflag)
		{
			write_float32("out_data_pipe",Y);
			Y = 0;
		}
		else
		{
			Y = (Y + read_float32("sum_pipe"));
		}
	}
}

