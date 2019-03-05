#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"
#include "pEMacro.h"


// There are N vectors v0, v1 ... vN-1.
// The vectors x0,x1,...xN-Omega correspond to v0,v1,...,vN-Omega
// and the vectors y0,y1,...,yN-Omega correspond to vOmega,vOmega+1....vN.
//
// All differences || xI - yJ || for I<=J need to be computed.
//
//


// storage for the vectors, divided into 4 blocks.
float X0[CHUNK_SIZE], X1[CHUNK_SIZE], X2[CHUNK_SIZE], X3[CHUNK_SIZE];

// number of vectors.
uint32_t g_num_vecs;


void dispatcher()
{
	while(1)
	{
		// start reading the vectors 
		int vec_id, vec_index;
		int Ecount = 0;
		int chunk_id = 0;
		int I0=0, I1=0, I2=0, I3=0;
		for(vec_id = 0; vec_id < NUM_VECS; vec_id++)
		{
			for(vec_index = 0; vec_index < VEC_SIZE; vec_index++)
			{
				float val = read_float32("input_data_pipe");
				if(Ecount == CHUNK_SIZE)
				{
					chunk_id++;
					Ecount = 0;
				}

#ifdef SW
				fprintf(stderr,"Read vector %d, index %d, val=%f, chunk-id %d.\n", vec_id, vec_index, val, chunk_id);
#endif
				switch(chunk_id)
				{
					case 0:  
						X0[I0] = val; I0++; break;
					case 1:
						X1[I1] = val; I1++; break;
					case 2:
						X2[I2] = val; I2++; break;
					case 3:
						X3[I3] = val; I3++; break;
					default:
						break;

				}
				Ecount++;
			}
		}

		write_uint8("start_dc_00",1);
		write_uint8("start_dc_01",1);
		write_uint8("start_dc_02",1);
		write_uint8("start_dc_03",1);
		write_uint8("start_dc_11",1);
		write_uint8("start_dc_12",1);
		write_uint8("start_dc_13",1);
		write_uint8("start_dc_22",1);
		write_uint8("start_dc_23",1);
		write_uint8("start_dc_33",1);

		uint32_t r00 = read_uint32("result_dc_00");
		uint32_t r01 = read_uint32("result_dc_01");
		uint32_t r02 = read_uint32("result_dc_02");
		uint32_t r03 = read_uint32("result_dc_03");
		uint32_t r11 = read_uint32("result_dc_11");
		uint32_t r12 = read_uint32("result_dc_12");
		uint32_t r13 = read_uint32("result_dc_13");
		uint32_t r22 = read_uint32("result_dc_22");
		uint32_t r23 = read_uint32("result_dc_23");
		uint32_t r33 = read_uint32("result_dc_33");

		uint32_t result =( ((r00 + r01) + (r02 + r03))) + (((r11 + r12) + r13) + (r22 + r23) + r33);
		write_uint32("final_result_pipe",result);
	}
}

#ifdef SW
inline uint32_t innerLoop(float* X, float* Y, uint32_t vsize, float epsilon)
{
	int K;
	float err=0.0;

	uint32_t result = 0;
	for(K=0; K < vsize;K++)
	{
		float terr = X[K] - Y[K];
		float aterr = ((terr < 0)? -terr : terr);
		err = ((err < aterr) ? aterr : err);
	}
	result = ((epsilon < err) ? 1 : 0);
	return(result);
}
#endif

// calculate all pairwise errors.
void dC00()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_00");
		__CrossProcess(X0,X0,0,result);
		write_uint32("result_dc_00", result);
	}
}


void dC01()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_01");
		__CrossProcess(X0,X1,CHUNK_SIZE,result);
		write_uint32("result_dc_01", result);
	}
}

void dC02()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_02");
		__CrossProcess(X0,X2,2*CHUNK_SIZE,result);
		write_uint32("result_dc_02", result);
	}
}

void dC03()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_03");
		__CrossProcess(X0,X3,3*CHUNK_SIZE,result);
		write_uint32("result_dc_03", result);
	}
}

void dC11()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_11");
		__CrossProcess(X1,X1,0,result);
		write_uint32("result_dc_11", result);
	}
}

void dC12()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_12");
		__CrossProcess(X1,X2,CHUNK_SIZE,result);
		write_uint32("result_dc_12", result);
	}
}

void dC13()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_13");
		__CrossProcess(X1,X3,2*CHUNK_SIZE,result);
		write_uint32("result_dc_13", result);
	}
}

void dC22()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_22");
		__CrossProcess(X2,X2,0,result);
		write_uint32("result_dc_22", result);
	}
}

void dC23()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_23");
		__CrossProcess(X2,X3,CHUNK_SIZE,result);
		write_uint32("result_dc_23", result);
	}
}

void dC33()
{
	uint32_t result;
	while(1)
	{
		uint8_t s = read_uint8("start_dc_33");
		__CrossProcess(X3,X3,0,result);
		write_uint32("result_dc_33", result);
	}
}
