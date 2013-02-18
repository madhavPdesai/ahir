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
// The processing elements are indexed as (I,J), 0 <= I,J <= PE_ARRAY_DIM.
// The element (I,J) will maintain all xP, yQ such that
// P mod PE_ARRAY_DIM = I and Q mod PE_ARRAY_DIM = J.
// 
// Each processing element (I,J) will then compute the differences for pairs
// XU,YW such that U <= W.
//
//

// 32 buffers each with VEC_SIZE entries.
float vec_buffers[32*VEC_SIZE];

// globals
// number of vectors.
uint32_t g_num_vecs;


void init()
{
	int i;
	for(i = 0; i < 1024; i=i+VEC_SIZE)
	{
		// load the buffer.
		write_uintptr("free_buffer_pipe",(uint32_t*) &(vec_buffers[i*VEC_SIZE]));
	}
}

// transmit control information to the left border of the PE array.
void TxHControl(uint32_t val)
{
	__WHC(0,0,val);
	__WHC(1,0,val);
}

// transmit control information to the top border of the PE array.
void TxVControl(uint32_t val)
{
	__WVC(0,0,val);
	__WVC(0,1,val);
}
// transmit data values to the the left and top borders
// of the PE array.
void TxValues()
{
	while(1)
	{
		// wait to hear from tx_vec_id pipe, to get
		// a vector index.
		uint32_t vec_id = read_uint32("tx_vec_id");

		if(vec_id == 0xffffffff)
		{
			// if end-code is seen, continue waiting.
			// but forward end code to PE array
			// through the borders.
			TxHControl(vec_id);
			TxVControl(vec_id);
			continue;
		}


		// get the pointer to the vector buffer.
		float*   vec_ptr = (float*) read_uintptr("tx_vec_ptr");


		// find row indices which match the vec-index.
		char sendH0 = 0, sendH1 = 0;
		if(vec_id < g_num_vecs - OMEGA)
		{
			if(!(vec_id & SEL_MASK))
			{
				__WHC(0,0,vec_id);
				sendH0  = 1;
			}
			else
			{
				sendH1 = 1;
				__WHC(1,0,vec_id);
			}
		}


		// find column indices which match the vec-index.
		char sendV0 = 0, sendV1 = 0;
		if(vec_id >= OMEGA)
		{
			if(!(vec_id & SEL_MASK))
			{
				sendV0 = 1;
				__WVC(0,0,vec_id);
			}
			else
			{
				sendV1 = 1;
				__WVC(1,0,vec_id);
			}
		}


		// forward the vector values to appropriate
		// rows and columns.
		int I;
		for(I=0; I < VEC_SIZE; I++)
		{
			// send vec_ptr[I] to all the input pipes inP0x
			float X = vec_ptr[I];
			if(sendH0)
			   __WHD(0,0,X);
			else if(sendH1)
			   __WHD(1,0,X);

			if(sendV0)
			   __WVD(0,0,X);
			else if(sendV1)
			   __WVD(0,1,X);

		}

		// free the buffer.
		write_uintptr("free_buffer_pipe",(uint32_t*) vec_ptr);
	}
}



void dispatcher()
{
	init();

	while(1)
	{
		// get the number of vectors to be processed.
		g_num_vecs      = read_uint32("num_vecs_pipe");

		// transmit num_vec information to all the 
		// PE array borders..
		TxHControl(g_num_vecs);
		TxVControl(g_num_vecs);
		
		// start reading the vectors 
		int vec_id, vec_index;
		for(vec_id = 0; vec_id < g_num_vecs; vec_id++)
		{
			float* lptr = read_uintptr("free_buffer_pipe");
			for(vec_index = 0; vec_index < VEC_SIZE; vec_index++)
			{
				*(lptr + vec_index) = read_float32("vec_value_pipe");
			}

			// send local buffer ptr to value transmit pipe.
			write_uint32("tx_vec_id", vec_id);
			write_uintptr("tx_vec_ptr", (uint32_t*) lptr);
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
	
		// wait to hear from the bottom border
		// result pipes.
		__RVR(0,0,v0);
		__RVR(0,1,v1);

		write_float32("result_pipe",fpadd32(v0,v1));
	}
}


