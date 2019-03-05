#define __CrossProcess(X,Y,Offset,result) {\
	result = 0;\
	int xstart = 0;\
	int ystart;\
	if(Offset > OMEGA*VEC_SIZE) \
		ystart = 0;\
	else\
		ystart = ((OMEGA*VEC_SIZE) - Offset)/VEC_SIZE;\
	int I,J,K;\
	for(J=ystart; J < CHUNK_SIZE/VEC_SIZE; J++)\
	{\
		for(I=xstart; I < CHUNK_SIZE/VEC_SIZE; I++)\
		{\
			float err = 0.0;\
			result += innerLoop(&(X[I]),&(Y[J]),(uint32_t) VEC_SIZE,(float) EPSILON);\
		}\
	}\
}

