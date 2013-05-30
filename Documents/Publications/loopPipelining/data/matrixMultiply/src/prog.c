#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"


float a_matrix[ORDER][ORDER];
float b_matrix[ORDER][ORDER];
float c_matrix[ORDER][ORDER];

void send_output()
{
#ifndef PERFONLY
	uint32_t i,j;
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			write_float32("result_pipe",c_matrix[i][j]);
		}
	}
#else
	write_float32("result_pipe",0.0);
#endif 
}

void get_input()
{
#ifndef PERFONLY
	uint32_t i,j;
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			float v = read_float32("in_data_pipe");
			a_matrix[i][j] = v;
		}
	}
#else
	float v = read_float32("in_data_pipe");
#endif

#ifdef SW
	fprintf(stderr,"input_module: got a.\n");
#endif
#ifndef PERFONLY
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			float v = read_float32("in_data_pipe");
			b_matrix[i][j] = v;
		}
	}
#else
	v = read_float32("in_data_pipe");
#endif 

#ifdef SW
	fprintf(stderr,"input_module: got b\n");
#endif
}

#define _baseBlock(i,j,v) {\
	float a0 = a_matrix[i][k];\
	float b0 = b_matrix[k][j];\
	float a1 = a_matrix[i][k1];\
	float b1 = b_matrix[k1][j];\
	float a2 = a_matrix[i][k2];\
	float b2 = b_matrix[k2][j];\
	float a3 = a_matrix[i][k3];\
	float b3 = b_matrix[k3][j];\
	v += ( ((a0*b0) + (a1*b1)) + ((a2*b2) + (a3*b3)) );\
}

void mmultiply()
{
	while(1)
	{
		get_input();
		mmultiply_base();
		send_output();
	}
}

#ifdef UNROLL
void mmultiply_base()
{
	uint32_t i,j,k;
	for(i=0; i < ORDER; i+= 4)
	{
		uint32_t i1 = i+1; uint32_t i2 = i+2; uint32_t i3 = i+3;
		for (j = 0; j < ORDER; j+= 4)
		{
			uint32_t j1 = j+1; uint32_t j2 = j+2; uint32_t j3 = j+3;
			float v00 = 0, v01 = 0, v02 = 0, v03 = 0, v10 = 0, v11 = 0, v12 = 0, v13 = 0,
				v20 = 0, v21 = 0, v22 = 0, v23 = 0, v30 = 0, v31 = 0, v32 = 0, v33 = 0;

			for(k = 0; k < ORDER; k += 4)
			{ 
				uint32_t k1 = k+1; uint32_t k2 = k+2; uint32_t k3 = k+3;
					_baseBlock(i,j,v00);
					_baseBlock(i,j1,v01);
					_baseBlock(i,j2,v02);
					_baseBlock(i,j3,v03);

					_baseBlock(i1,j,v10);
					_baseBlock(i1,j1,v11);
					_baseBlock(i1,j2,v12);
					_baseBlock(i1,j3,v13);

					_baseBlock(i2,j, v20);
					_baseBlock(i2,j1,v21);
					_baseBlock(i2,j2,v22);
					_baseBlock(i2,j3,v23);

					_baseBlock(i3,j, v30);
					_baseBlock(i3,j1,v31);
					_baseBlock(i3,j2,v32);
					_baseBlock(i3,j3,v33);
			}

			c_matrix[i][j]  = v00;
			c_matrix[i][j1] = v01;
			c_matrix[i][j2] = v02;
			c_matrix[i][j3] = v03;

			c_matrix[i1][j]  = v10;
			c_matrix[i1][j1] = v11;
			c_matrix[i1][j2] = v12;
			c_matrix[i1][j3] = v13;

			c_matrix[i2][j]  = v20;
			c_matrix[i2][j1] = v21;
			c_matrix[i2][j2] = v22;
			c_matrix[i2][j3] = v23;

			c_matrix[i3][j]  = v30;
			c_matrix[i3][j1] = v31;
			c_matrix[i3][j2] = v32;
			c_matrix[i3][j3] = v33;
		}
	}
}
#else
void mmultiply_base()
{
	uint32_t i,j,k;
	for(i=0; i < ORDER; i++) 
	{
		for (j = 0; j < ORDER; j++)
		{
			float v = 0;
			for(k = 0; k < ORDER; k++)
			{ 
				v += (a_matrix[i][k] * b_matrix[k][j]);
			}

			c_matrix[i][j]  = v;
		}
	}
}
#endif
