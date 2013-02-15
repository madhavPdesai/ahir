#define __Row 0
#define __Col 0
#define __NRow 1
#define __NCol 1
#define __PRow -1
void pE00() 
{
	float X[4096], Y[4096];
	uint32_t vec_size, num_vecs,vec_index,I,J,K,XIDX,YIDX,NX,NY;
	__pE;
}

#undef __Row 
#undef __Col 
#undef __NRow 
#undef __NCol 
#undef __PRow 

#define __Row 0
#define __Col 1
#define __NRow 1
#define __NCol -1
#define __PRow -1

void pE01()
{
	float X[4096], Y[4096];
	uint32_t vec_size, num_vecs,vec_index,I,J,K,XIDX,YIDX,NX,NY;
	__pE(0,1,1,-1);
}

#undef __Row 
#undef __Col 
#undef __NRow 
#undef __NCol 
#undef __PRow 

#define __Row 1
#define __Col 1
#define __NRow -1
#define __NCol -1
#define __PRow 0
void pE11()
{
	float X[4096], Y[4096];
	uint32_t vec_size, num_vecs,vec_index,I,J,K,XIDX,YIDX,NX,NY;
	__pE(1,1,-1,-1);
}

#undef __Row 
#undef __Col 
#undef __NRow 
#undef __NCol 
#undef __PRow 

#define __Row 1
#define __Col 0
#define __NRow -1
#define __NCol 1
#define __PRow 0
void pE10()
{
	float X[4096], Y[4096];
	uint32_t vec_size, num_vecs,vec_index,I,J,K,XIDX,YIDX,NX,NY;
	__pE(1,0,-1,1);
}
