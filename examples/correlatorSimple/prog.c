#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

#ifdef SW
const int debug_print_on = 1;
void loop_pipelining_on(uint32_t d) {}
#else
const int debug_print_on = 0;
void loop_pipelining_on(uint32_t d);
#endif

#define NUM_VECS_BY_2 (NUM_VECS >> 1)

#ifdef USE2
float check_vectors_0[NUM_VECS_BY_2][ORDER];
float ref_vector_0[ORDER];
float check_vectors_1[NUM_VECS_BY_2][ORDER];
float ref_vector_1[ORDER];
#else
float check_vectors[NUM_VECS][ORDER];
float ref_vector[ORDER];
#endif


void get_input()
{
	uint32_t i,j;
	for (j = 0; j < ORDER; j++)
	{
		float v = read_float32("ref_vector_pipe");

		// two copies of ref-vector..
#ifdef USE2
		ref_vector_0[j] = v;
		ref_vector_1[j] = v;

		for(i=0; i < NUM_VECS_BY_2; i++)
		{
			float v = read_float32("check_vector_pipe");
			check_vectors_0[i][j] = v;
		}
		for(i=0; i < NUM_VECS_BY_2; i++)
		{
			float v = read_float32("check_vector_pipe");
			check_vectors_1[i][j] = v;
		}
#else
		ref_vector[j] = v;
		for(i = 0; i  < NUM_VECS; i++)
		{
			float v = read_float32("check_vector_pipe");
			check_vectors[i][j] = v;
		}
#endif
	}

#ifdef SW
	fprintf(stderr,"input_module: got ref and check vectors.\n");
#endif
}

#define __innerLoopBody(j,ref_vector, check_vectors) {\
	uint32_t j0 = j;\
	uint32_t j1 = j + 1;\
	uint32_t j2 = j + 2;\
	uint32_t j3 = j + 3;\
	\
	float rv0 = ref_vector[j0];\
	float rv1 = ref_vector[j1];\
	float rv2 = ref_vector[j2];\
	float rv3 = ref_vector[j3];\
	\
	float c00 = check_vectors[i][j0]*rv0;\
	float c10 = check_vectors[i1][j0]*rv0;\
	float c20 = check_vectors[i2][j0]*rv0;\
	float c30 = check_vectors[i3][j0]*rv0;\
	\
	float c01 =  check_vectors[i][j1]*rv1;\
	float c11 = check_vectors[i1][j1]*rv1;\
	float c21 = check_vectors[i2][j1]*rv1;\
	float c31 = check_vectors[i3][j1]*rv1;\
	\
	float c02 =  check_vectors[i][j2]*rv2;\
	float c12 = check_vectors[i1][j2]*rv2;\
	float c22 = check_vectors[i2][j2]*rv2;\
	float c32 = check_vectors[i3][j2]*rv2;\
	\
	float c03 =  check_vectors[i][j3]*rv3;\
	float c13 = check_vectors[i1][j3]*rv3;\
	float c23 = check_vectors[i2][j3]*rv3;\
	float c33 = check_vectors[i3][j3]*rv3;\
	\
	c0 += (c00 + c01) + (c02 + c03);\
	c1 += (c10 + c11) + (c12 + c13);\
	c2 += (c20 + c21) + (c22 + c23);\
	c3 += (c30 + c31) + (c32 + c33);\
	\
	if(debug_print_on)\
	{\
		float c00_01 = c00 + c01;\
		float c02_03 = c02 + c03;\
		fprintf(stdout,"c00 = %x, c01 = %x, c02 = %x, c03 = %x.\n", \
			*((uint32_t*) &c00),\
			*((uint32_t*) &c01),\
			*((uint32_t*) &c02),\
			*((uint32_t*) &c03));\
		fprintf(stdout,"c00 + c01 = %x, c02 + c03 = %x.\n", \
			*((uint32_t*) &c00_01),\
			*((uint32_t*) &c02_03));\
		fprintf(stdout,"c10 = %x, c11 = %x, c12 = %x, c13 = %x.\n", \
			*((uint32_t*) &c10),\
			*((uint32_t*) &c11),\
			*((uint32_t*) &c12),\
			*((uint32_t*) &c13));\
		fprintf(stdout,"c0 = %x, c1 = %x, c2 = %x, c3 = %x.\n", \
			*((uint32_t*) &c0),\
			*((uint32_t*) &c1),\
			*((uint32_t*) &c2),\
			*((uint32_t*) &c3));\
	}\
}


#define __correlatorBase(rv,cv,bc,bi,nvecs) { int i,j;\
\
		float c0, c1, c2, c3;\
		float bc0=0, bc1=0, bc2=0, bc3=0;\
		uint32_t bi0, bi1, bi2, bi3;\
		for(i=0; i < nvecs; i += 4)\
		{\
\
			c0 = 0; c1 = 0; c2 = 0; c3 = 0;\
			uint32_t i1 = i + 1;\
			uint32_t i2 = i + 2;\
			uint32_t i3 = i + 3;\
\
			for (j = 0; j < ORDER; j += 4)\
			{\
				loop_pipelining_on(3);\
				__innerLoopBody(j,rv,cv);\
			}\
\
			uint8_t s0 = (c0 > bc0);\
			uint8_t s1 = (c1 > bc1);\
			uint8_t s2 = (c2 > bc2);\
			uint8_t s3 = (c3 > bc3);\
\
			bc0 = (s0 ? c0 : bc0);\
			bi0 = (s0 ? i  : bi0);\
\
			bc1 = (s1 ? c1 : bc1);\
			bi1 = (s1 ? i1  : bi1);\
\
			bc2 = (s2 ? c2 : bc2);\
			bi2 = (s2 ? i2  : bi2);\
\
			bc3 = (s3 ? c3 : bc3);\
			bi3 = (s3 ? i3  : bi3);\
		}\
\
		bc = 0;\
		bi = 0;\
\
		if(bc0 > bc)\
		{\
			bc = bc0;\
			bi = bi0;\
		}\
\
		if(bc1 > bc)\
		{\
			bc = bc1;\
			bi = bi1;\
		}\
\
		if(bc2 > bc)\
		{\
			bc = bc2;\
			bi = bi2;\
		}\
\
		if(bc3 > bc)\
		{\
			bc = bc3;\
			bi = bi3;\
		}\
\
	}
void correlator()
{
	uint32_t i,j,k;

	float bc;
	uint32_t bi;

	while(1)
	{
		float best_corr;
		uint32_t best_index;
		get_input();

		write_uint8("start_slave_0",1);
#ifdef USE2
		write_uint8("start_slave_1",1);
		float bc0 = read_float32("best_correlation_0_pipe");
		uint32_t bi0 = read_uint32("best_index_0_pipe");

		float bc1 = read_float32("best_correlation_1_pipe");
		uint32_t bi1 = read_uint32("best_index_1_pipe");

		uint32_t cr = (bc0 < bc1);
		bc = (cr ? bc1 : bc0);
		bi = (cr ? bi1 : bi0);

#else
		bc = read_float32("best_correlation_0_pipe");
		bi = read_uint32("best_index_0_pipe");
#endif
		write_float32("best_correlation_pipe", bc);
		write_uint32("best_index_pipe", bi);
	}
}

void slave_0()
{
	while(1)
	{
		uint8_t s = read_uint8("start_slave_0");
		float bc;
		int bi;

#ifdef USE2
		__correlatorBase(ref_vector_0, check_vectors_0, bc, bi, NUM_VECS_BY_2);
		write_float32("best_correlation_0_pipe",bc);
		write_uint32("best_index_0_pipe",bi);
#else
		__correlatorBase(ref_vector, check_vectors, bc, bi, NUM_VECS);
		write_float32("best_correlation_0_pipe",bc);
		write_uint32("best_index_0_pipe",bi);
#endif

	}
}

#ifdef USE2

void slave_1()
{
	while(1)
	{
		uint8_t s = read_uint8("start_slave_1");
		float bc;
		int bi;

		__correlatorBase(ref_vector_1, check_vectors_1, bc, bi, NUM_VECS_BY_2);

		write_float32("best_correlation_1_pipe",bc);
		write_uint32("best_index_1_pipe",bi);
	}
}

#endif
