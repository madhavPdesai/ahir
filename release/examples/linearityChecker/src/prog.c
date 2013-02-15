#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

// PE_ARRAY_DIM must be a power of 2.
#define PE_ARRAY_DIM   2

// mask
#define SEL_MASK ~((uint32_t) PE_ARRAY_DIM) 

// There are N vectors v0, v1 ... vN-1.
// The vectors x0,x1,...xN-Omega correspond to v0,v1,...,vN-Omega
// and the vectors y0,y1,...,yN-Omega correspond to vOmega,vOmega+1....vN.
//
// All differences || xI - yJ || for I<=J need to be computed.
//
// The processing elements are indexed as (I,J), 0 <= I <= J <= PE_ARRAY_DIM.
// The element (I,J) will maintain all xP, yQ such that
// P mod PE_ARRAY_DIM = I and Q mod PE_ARRAY_DIM = J.
// 
// Each element (I,J) will then compute the differences for pairs
// XU,YW such that U <= W.
//
//

// 32 buffers each with 32 entries.
float local_vec[1024];

// globals
// vector size
uint32_t g_vec_size;
// number of vectors.
uint32_t g_num_vecs;


void init()
{
	int i;
	for(i = 0; i < 1024; i=i+32)
	{
		// load the buffer.
		write_uintptr("free_buffer_pipe",(uint32_t*) &(local_vec[i*32]));
	}
}

// transmit control information to the left border of the PE array.
void TxControl(uint32_t g_vec_size,uint32_t g_num_vecs)
{
	__WHC(0,0,g_vec_size)
	__WHC(0,0,g_num_vecs)
	__WHC(1,0,g_vec_size)
	__WHC(1,0,g_num_vecs)
}

// transmit data values to the the left and top borders
// of the PE array.
void TxValues()
{
	while(1)
	{
		uint32_t vec_id = read_uint32("tx_vec_id");
		if(vec_id == 0xffffffff)
		{
			__WHC(0,0,vec_id);
			__WHC(1,0,vec_id);
			__WVC(0,0,vec_id);
			__WVC(0,1,vec_id);
			continue;
		}

		float*   vec_ptr = (float*) read_uintptr("tx_vec_ptr");

		int VS = g_vec_size;

		int I;
		for(I=0; I < VS; I++)
		{
			// send vec_ptr[I] to all the input pipes inP0x
			float X = vec_ptr[I];
			if(vec_id < g_num_vecs - OMEGA)
			{
				if(!(vec_id & SEL_MASK))
				{
					__WHC(0,0,vec_id);
					__WHD(0,0,X)
				}
				else
				{
					__WVC(1,0,vec_id);
					__WHD(1,0,X)
				}
			}

			if(vec_id >= OMEGA)
			{
				if(!(vec_id & SEL_MASK))
				{
					__WVC(0,0,vec_id);
					__WVD(0,0,X)
				}
				else
				{
					__WVC(1,0,vec_id);
					__WVD(0,1,X)
				}
			}
		}
	}
}



void dispatcher()
{
	while(1)
	{
		g_vec_size      = read_uint8("vec_size_pipe");
		g_num_vecs      = read_uint32("num_vecs_pipe");
		TxControl(g_vec_size,g_num_vecs);
		
		int vec_id, vec_index;
		for(vec_id = 0; vec_id < g_num_vecs; vec_id++)
		{
			float local_vec[g_vec_size];
			float* lptr = read_uintptr("free_buffer_pipe");
			for(vec_index = 0; vec_index < g_vec_size; vec_index++)
			{
				*(lptr + vec_index) = read_float32("vec_value_pipe");
			}
			write_uint32("tx_vec_id", vec_id);
			write_uintptr("tx_vec_ptr", lptr);
		}
		write_uint32("tx_vec_id",0xffffffff);
	}
}

// collect the results of the differences and send the
// final value back to the base..
void collector()
{
	float v0, v1;
	while(1)
	{
		__RVR(0,0,v0);
		__RVR(0,1,v1);

		write_float32("result_pipe",fpadd32(v0,v1));
	}
}


