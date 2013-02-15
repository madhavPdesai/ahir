#define __pE {\
	while(1)\
	{\
		__RHC(__Row,__Col,vec_size);\
		__RHC(__Row,__Col,num_vecs);\
		XIDX=0; YIDX=0; NX=0; NY=0;\
		while(1)\
		{\
			__RHC(__Row,__Col,vec_index);\
			char xdone = 0;\
			if(vec_index != -1) {\
				if((vec_index & SEL_MASK) == __Row) \
				{\
					NX++;\
					for(I=0;I<vec_size;I++)\
					{\
						__RHD(__Row,__Col,X[XIDX]); XIDX++;\
					}\
				}\
				else\
				{\
					__WHC(__Row,__NCol,vec_index);\
					float tmp;\
					for(I=0;I<vec_size;I++) {\
						__RHD(__Row,__Col,tmp);\
						__WHD(__Row,__NCol,tmp);\
					}\
				}\
			}\
			else\
			{\
#if (__NCol >= 0)\
				__WHC(__Row,__NCol,vec_index);\
#endif\
				xdone = 1;\
			}\
			__RVC(__Row,__Col,vec_index);\
			char ydone = 0;\
			if(vec_index != -1) {\
				if((vec_index & SEL_MASK) == __Col) \
				{\
					NY++;\
					for(I=0;I<vec_size;I++){\
						__RVD(__Row,__Col,Y[YIDX]); YIDX++;\
					}\
				}\
				else\
				{\
#if (__NRow >= 0) \
					__WVC(__NRow,__Col,vec_index);\
#endif\
					float tmp;\
					for(I=0;I<vec_size;I++) {\
						__RVD(__Row,__Col,tmp);\
#if (__NRow >= 0) \
						__WVD(__NRow,__Col,tmp);\
#endif\
					}\
				}\
			}\
			else\
			{\
#if (__NRow >= 0) \
				__WVC(__NRow,__Col,vec_index);\
#endif\
				ydone = 1;\
			}\
			if(xdone && ydone)\
				break;\
		}\
		float result = 0.0;\
		for(I=0; I < XIDX; I += vec_size) {\
			for(J=0; J < YIDX; J += vec_size){\
				float err = 0.0;\
				for(K=I; K < vec_size; K++){\
					float terr = X[I+K] - Y[J+K];\
					float aterr = ((terr < 0)? -terr : terr);\
					err = ((err < aterr) ? aterr : err);\
				}\
				result += ((EPSILON < err) ? 1.0 : 0.0);\
			}\
		}\
#if (__PRow >= 0) \
		float presult = 0.0;\
		__RVR(__PRow,__Col,presult);\
		result += presult;\
#endif\
		__WVR(__Row,__Col,result);\
	}\
}
