#include "pE00.h"

void pE00() 
{
	float X[4096], Y[4096];
	uint32_t vec_size, num_vecs,vec_index,I,J,K,XIDX,YIDX,NX,NY;
	while(1)
	{
		__RHC(__Row,__Col,vec_size);
		__RHC(__Row,__Col,num_vecs);
		XIDX=0; YIDX=0; NX=0; NY=0;
		while(1)
		{
			/*
			   wait for entries.. as soon as all the
			   vectors have been received, start doing
			   all the pairwise difference calculations
			   and add them up.  When done, wait for the
			   result from the right, add its own contribution
			   and send the sum to the left.
			   */
			__RHC(__Row,__Col,vec_index);

			char xdone = 0;
			if(vec_index != -1) {
				if((vec_index & SEL_MASK) == __Row) 
				{
					NX++;
					for(I=0;I<vec_size;I++)
					{
						__RHD(__Row,__Col,X[XIDX]); XIDX++;
					}
				}
				else
				{
					float tmp;
					for(I=0;I<vec_size;I++) {
						__RHD(__Row,__Col,tmp);
						// forward to the next column.
						__WHD(__Row,__NCol,tmp);
					}
				}
			}
			else
				xdone = 1;

			__RVC(__Row,__Col,vec_index);
			char ydone = 0;
			if(vec_index != -1) {
				if((vec_index & SEL_MASK) == __Col) 
				{
					NY++;
					for(I=0;I<vec_size;I++){
						__RVD(__Row,__Col,Y[YIDX]); YIDX++;
					}
				}
				else
				{
					float tmp;
					for(I=0;I<vec_size;I++) {
						__RVD(__Row,__Col,tmp);
						// forward to the next row.
						__WVD(__NRow,__Col,tmp);
					}
				}
			}
			else
				ydone = 1;

			if(xdone && ydone)
				break;
		}
		float result = 0.0;
		for(I=0; I < XIDX; I += vec_size) {
			for(J=0; J < YIDX; J += vec_size){
				float err = 0.0;
				for(K=I; K < vec_size; K++){
					float terr = X[I+K] - Y[J+K];
					float aterr = ((terr < 0)? -terr : terr);
					err = ((err < aterr) ? aterr : err);
				}
				result += ((EPSILON < err) ? 1.0 : 0.0);
			}
		}
		__WHR(__Row,__Col,result);
	}
}
