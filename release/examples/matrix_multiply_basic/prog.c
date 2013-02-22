#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include "prog.h"

#define HALF_ORDER (ORDER >> 1)

float a_matrix_L[HALF_ORDER][ORDER];
float a_matrix_H[HALF_ORDER][ORDER];
float b_matrix_L[ORDER][HALF_ORDER];
float b_matrix_H[ORDER][HALF_ORDER];

float c_matrix_LL[HALF_ORDER][HALF_ORDER];
float c_matrix_LH[HALF_ORDER][HALF_ORDER];
float c_matrix_HH[HALF_ORDER][HALF_ORDER];
float c_matrix_HL[HALF_ORDER][HALF_ORDER];


void send_output()
{
	uint32_t i,j;
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			float v;
			if((i < HALF_ORDER) && (j < HALF_ORDER))
				write_float32("result_pipe",c_matrix_LL[i][j]);
			else if((i < HALF_ORDER) && (j >= HALF_ORDER))
				write_float32("result_pipe", c_matrix_LH[i][j-HALF_ORDER]);
			else if((i >= HALF_ORDER) && (j >= HALF_ORDER))
				write_float32("result_pipe", c_matrix_HH[i-HALF_ORDER][j-HALF_ORDER]);
			else
				write_float32("result_pipe", c_matrix_HL[i-HALF_ORDER][j]);
		}
	}
}

void get_input()
{
	uint32_t i,j;
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			float v = read_float32("in_data_pipe");
			if(i < HALF_ORDER)
				a_matrix_L[i][j] = v;
			else
				a_matrix_H[i-HALF_ORDER][j] = v;
		}
	}
#ifdef SW
	fprintf(stderr,"input_module: got a.\n");
#endif
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			float v = read_float32("in_data_pipe");
			if(j < HALF_ORDER)
				b_matrix_L[i][j] = v;
			else
				b_matrix_H[i][j-HALF_ORDER] = v;
		}
	}
#ifdef SW
	fprintf(stderr,"input_module: got b\n");
#endif
}

#define _baseBlock(i,j,a,b,v) {\
	float a0 = a[i][k];\
	float b0 = b[k][j];\
	float a1 = a[i][k1];\
	float b1 = b[k1][j];\
	float a2 = a[i][k2];\
	float b2 = b[k2][j];\
	float a3 = a[i][k3];\
	float b3 = b[k3][j];\
	v += ((a0*b0) + (a1*b1) + (a2*b2) + (a3*b3));\
}

void mmultiply()
{
	while(1)
	{
		get_input();
		write_uint8("start_LL",1);
		write_uint8("start_LH",1);
		write_uint8("start_HH",1);
		write_uint8("start_HL",1);

		
		uint8_t dLL = read_uint8("done_LL");
		uint8_t dLH = read_uint8("done_LH");
		uint8_t dHH = read_uint8("done_HH");
		uint8_t dHL = read_uint8("done_HL");

	
		send_output();
	}
}

#ifdef UNROLLED
void mmultiply_LL()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dLL = read_uint8("start_LL");
		for(i=0; i < HALF_ORDER; i+= 4)
		{
			uint32_t i1 = i+1; uint32_t i2 = i+2; uint32_t i3 = i+3;
			for (j = 0; j < HALF_ORDER; j+= 4)
			{
				uint32_t j1 = j+1; uint32_t j2 = j+2; uint32_t j3 = j+3;
				float v00 = 0, v01 = 0, v02 = 0, v03 = 0, v10 = 0, v11 = 0, v12 = 0, v13 = 0,
					v20 = 0, v21 = 0, v22 = 0, v23 = 0, v30 = 0, v31 = 0, v32 = 0, v33 = 0;

				for(k = 0; k < ORDER; k += 4)
				{ 
					uint32_t k1 = k+1; uint32_t k2 = k+2; uint32_t k3 = k+3;

					_baseBlock(i,j,a_matrix_L,b_matrix_L,v00);
					_baseBlock(i,j1,a_matrix_L,b_matrix_L,v01);
					_baseBlock(i,j2,a_matrix_L,b_matrix_L,v02);
					_baseBlock(i,j3,a_matrix_L,b_matrix_L,v03);

					_baseBlock(i1,j, a_matrix_L,b_matrix_L,v10);
					_baseBlock(i1,j1,a_matrix_L,b_matrix_L,v11);
					_baseBlock(i1,j2,a_matrix_L,b_matrix_L,v12);
					_baseBlock(i1,j3,a_matrix_L,b_matrix_L,v13);

					_baseBlock(i2,j, a_matrix_L,b_matrix_L,v20);
					_baseBlock(i2,j1,a_matrix_L,b_matrix_L,v21);
					_baseBlock(i2,j2,a_matrix_L,b_matrix_L,v22);
					_baseBlock(i2,j3,a_matrix_L,b_matrix_L,v23);

					_baseBlock(i3,j, a_matrix_L,b_matrix_L,v30);
					_baseBlock(i3,j1,a_matrix_L,b_matrix_L,v31);
					_baseBlock(i3,j2,a_matrix_L,b_matrix_L,v32);
					_baseBlock(i3,j3,a_matrix_L,b_matrix_L,v33);
				}

				c_matrix_LL[i][j]  = v00;
				c_matrix_LL[i][j1] = v01;
				c_matrix_LL[i][j2] = v02;
				c_matrix_LL[i][j3] = v03;

				c_matrix_LL[i1][j]  = v10;
				c_matrix_LL[i1][j1] = v11;
				c_matrix_LL[i1][j2] = v12;
				c_matrix_LL[i1][j3] = v13;

				c_matrix_LL[i2][j]  = v20;
				c_matrix_LL[i2][j1] = v21;
				c_matrix_LL[i2][j2] = v22;
				c_matrix_LL[i2][j3] = v23;

				c_matrix_LL[i3][j]  = v30;
				c_matrix_LL[i3][j1] = v31;
				c_matrix_LL[i3][j2] = v32;
				c_matrix_LL[i3][j3] = v33;
			}
		}
		write_uint8("done_LL",1);
	}
}

void mmultiply_LH()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dLH = read_uint8("start_LH");
		for(i=0; i < HALF_ORDER; i+= 4)
		{
			uint32_t i1 = i+1; uint32_t i2 = i+2; uint32_t i3 = i+3;
			for (j = 0; j < HALF_ORDER; j+= 4)
			{
				uint32_t j1 = j+1; uint32_t j2 = j+2; uint32_t j3 = j+3;
				float v00 = 0, v01 = 0, v02 = 0, v03 = 0, v10 = 0, v11 = 0, v12 = 0, v13 = 0,
					v20 = 0, v21 = 0, v22 = 0, v23 = 0, v30 = 0, v31 = 0, v32 = 0, v33 = 0;

				for(k = 0; k < ORDER; k += 4)
				{ 
					uint32_t k1 = k+1; uint32_t k2 = k+2; uint32_t k3 = k+3;

					_baseBlock(i,j,a_matrix_L,b_matrix_H,v00);
					_baseBlock(i,j1,a_matrix_L,b_matrix_H,v01);
					_baseBlock(i,j2,a_matrix_L,b_matrix_H,v02);
					_baseBlock(i,j3,a_matrix_L,b_matrix_H,v03);

					_baseBlock(i1,j, a_matrix_L,b_matrix_H,v10);
					_baseBlock(i1,j1,a_matrix_L,b_matrix_H,v11);
					_baseBlock(i1,j2,a_matrix_L,b_matrix_H,v12);
					_baseBlock(i1,j3,a_matrix_L,b_matrix_H,v13);

					_baseBlock(i2,j, a_matrix_L,b_matrix_H,v20);
					_baseBlock(i2,j1,a_matrix_L,b_matrix_H,v21);
					_baseBlock(i2,j2,a_matrix_L,b_matrix_H,v22);
					_baseBlock(i2,j3,a_matrix_L,b_matrix_H,v23);

					_baseBlock(i3,j, a_matrix_L,b_matrix_H,v30);
					_baseBlock(i3,j1,a_matrix_L,b_matrix_H,v31);
					_baseBlock(i3,j2,a_matrix_L,b_matrix_H,v32);
					_baseBlock(i3,j3,a_matrix_L,b_matrix_H,v33);
				}

				c_matrix_LH[i][j]  = v00;
				c_matrix_LH[i][j1] = v01;
				c_matrix_LH[i][j2] = v02;
				c_matrix_LH[i][j3] = v03;

				c_matrix_LH[i1][j]  = v10;
				c_matrix_LH[i1][j1] = v11;
				c_matrix_LH[i1][j2] = v12;
				c_matrix_LH[i1][j3] = v13;

				c_matrix_LH[i2][j]  = v20;
				c_matrix_LH[i2][j1] = v21;
				c_matrix_LH[i2][j2] = v22;
				c_matrix_LH[i2][j3] = v23;

				c_matrix_LH[i3][j]  = v30;
				c_matrix_LH[i3][j1] = v31;
				c_matrix_LH[i3][j2] = v32;
				c_matrix_LH[i3][j3] = v33;
			}
		}
		write_uint8("done_LH",1);
	}
}

void mmultiply_HH()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dHH = read_uint8("start_HH");
		for(i=0; i < HALF_ORDER; i+= 4)
		{
			uint32_t i1 = i+1; uint32_t i2 = i+2; uint32_t i3 = i+3;
			for (j = 0; j < HALF_ORDER; j+= 4)
			{
				uint32_t j1 = j+1; uint32_t j2 = j+2; uint32_t j3 = j+3;
				float v00 = 0, v01 = 0, v02 = 0, v03 = 0, v10 = 0, v11 = 0, v12 = 0, v13 = 0,
					v20 = 0, v21 = 0, v22 = 0, v23 = 0, v30 = 0, v31 = 0, v32 = 0, v33 = 0;

				for(k = 0; k < ORDER; k += 4)
				{ 
					uint32_t k1 = k+1; uint32_t k2 = k+2; uint32_t k3 = k+3;

					_baseBlock(i,j,a_matrix_H,b_matrix_H,v00);
					_baseBlock(i,j1,a_matrix_H,b_matrix_H,v01);
					_baseBlock(i,j2,a_matrix_H,b_matrix_H,v02);
					_baseBlock(i,j3,a_matrix_H,b_matrix_H,v03);

					_baseBlock(i1,j, a_matrix_H,b_matrix_H,v10);
					_baseBlock(i1,j1,a_matrix_H,b_matrix_H,v11);
					_baseBlock(i1,j2,a_matrix_H,b_matrix_H,v12);
					_baseBlock(i1,j3,a_matrix_H,b_matrix_H,v13);

					_baseBlock(i2,j, a_matrix_H,b_matrix_H,v20);
					_baseBlock(i2,j1,a_matrix_H,b_matrix_H,v21);
					_baseBlock(i2,j2,a_matrix_H,b_matrix_H,v22);
					_baseBlock(i2,j3,a_matrix_H,b_matrix_H,v23);

					_baseBlock(i3,j, a_matrix_H,b_matrix_H,v30);
					_baseBlock(i3,j1,a_matrix_H,b_matrix_H,v31);
					_baseBlock(i3,j2,a_matrix_H,b_matrix_H,v32);
					_baseBlock(i3,j3,a_matrix_H,b_matrix_H,v33);
				}

				c_matrix_HH[i][j]  = v00;
				c_matrix_HH[i][j1] = v01;
				c_matrix_HH[i][j2] = v02;
				c_matrix_HH[i][j3] = v03;

				c_matrix_HH[i1][j]  = v10;
				c_matrix_HH[i1][j1] = v11;
				c_matrix_HH[i1][j2] = v12;
				c_matrix_HH[i1][j3] = v13;

				c_matrix_HH[i2][j]  = v20;
				c_matrix_HH[i2][j1] = v21;
				c_matrix_HH[i2][j2] = v22;
				c_matrix_HH[i2][j3] = v23;

				c_matrix_HH[i3][j]  = v30;
				c_matrix_HH[i3][j1] = v31;
				c_matrix_HH[i3][j2] = v32;
				c_matrix_HH[i3][j3] = v33;
			}
		}
		write_uint8("done_HH",1);
	}
}

void mmultiply_HL()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dHL = read_uint8("start_HL");
		for(i=0; i < HALF_ORDER; i+= 4)
		{
			uint32_t i1 = i+1; uint32_t i2 = i+2; uint32_t i3 = i+3;
			for (j = 0; j < HALF_ORDER; j+= 4)
			{
				uint32_t j1 = j+1; uint32_t j2 = j+2; uint32_t j3 = j+3;
				float v00 = 0, v01 = 0, v02 = 0, v03 = 0, v10 = 0, v11 = 0, v12 = 0, v13 = 0,
					v20 = 0, v21 = 0, v22 = 0, v23 = 0, v30 = 0, v31 = 0, v32 = 0, v33 = 0;

				for(k = 0; k < ORDER; k += 4)
				{ 
					uint32_t k1 = k+1; uint32_t k2 = k+2; uint32_t k3 = k+3;

					_baseBlock(i,j,a_matrix_H,b_matrix_L,v00);
					_baseBlock(i,j1,a_matrix_H,b_matrix_L,v01);
					_baseBlock(i,j2,a_matrix_H,b_matrix_L,v02);
					_baseBlock(i,j3,a_matrix_H,b_matrix_L,v03);

					_baseBlock(i1,j, a_matrix_H,b_matrix_L,v10);
					_baseBlock(i1,j1,a_matrix_H,b_matrix_L,v11);
					_baseBlock(i1,j2,a_matrix_H,b_matrix_L,v12);
					_baseBlock(i1,j3,a_matrix_H,b_matrix_L,v13);

					_baseBlock(i2,j, a_matrix_H,b_matrix_L,v20);
					_baseBlock(i2,j1,a_matrix_H,b_matrix_L,v21);
					_baseBlock(i2,j2,a_matrix_H,b_matrix_L,v22);
					_baseBlock(i2,j3,a_matrix_H,b_matrix_L,v23);

					_baseBlock(i3,j, a_matrix_H,b_matrix_L,v30);
					_baseBlock(i3,j1,a_matrix_H,b_matrix_L,v31);
					_baseBlock(i3,j2,a_matrix_H,b_matrix_L,v32);
					_baseBlock(i3,j3,a_matrix_H,b_matrix_L,v33);
				}

				c_matrix_HL[i][j]  = v00;
				c_matrix_HL[i][j1] = v01;
				c_matrix_HL[i][j2] = v02;
				c_matrix_HL[i][j3] = v03;

				c_matrix_HL[i1][j]  = v10;
				c_matrix_HL[i1][j1] = v11;
				c_matrix_HL[i1][j2] = v12;
				c_matrix_HL[i1][j3] = v13;

				c_matrix_HL[i2][j]  = v20;
				c_matrix_HL[i2][j1] = v21;
				c_matrix_HL[i2][j2] = v22;
				c_matrix_HL[i2][j3] = v23;

				c_matrix_HL[i3][j]  = v30;
				c_matrix_HL[i3][j1] = v31;
				c_matrix_HL[i3][j2] = v32;
				c_matrix_HL[i3][j3] = v33;
			}
		}
		write_uint8("done_HL",1);
	}
}

#else

void mmultiply_LL()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dLL = read_uint8("start_LL");
		for(i=0; i < HALF_ORDER; i++)
		{
			for (j = 0; j < HALF_ORDER; j++)
			{
				float v = 0;
				for(k = 0; k < ORDER; k ++)
				{ 
					v += a_matrix_L[i][k]*b_matrix_L[k][j];
				}

				c_matrix_LL[i][j]  = v;
			}
		}
		write_uint8("done_LL",1);
	}
}

void mmultiply_LH()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dLH = read_uint8("start_LH");
		for(i=0; i < HALF_ORDER; i++)
		{
			for (j = 0; j < HALF_ORDER; j++)
			{
				float v = 0;
				for(k = 0; k < ORDER; k ++)
				{ 
					v += a_matrix_L[i][k]*b_matrix_H[k][j];
				}

				c_matrix_LH[i][j]  = v;
			}
		}
		write_uint8("done_LH",1);
	}
}

void mmultiply_HH()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dHH = read_uint8("start_HH");
		for(i=0; i < HALF_ORDER; i++)
		{
			for (j = 0; j < HALF_ORDER; j++)
			{
				float v = 0;
				for(k = 0; k < ORDER; k ++)
				{ 
					v += a_matrix_H[i][k]*b_matrix_H[k][j];
				}

				c_matrix_HH[i][j]  = v;
			}
		}
		write_uint8("done_HH",1);
	}
}

void mmultiply_HL()
{
	uint32_t i,j,k;
	while(1)
	{
		uint8_t dHL = read_uint8("start_HL");
		for(i=0; i < HALF_ORDER; i++)
		{
			for (j = 0; j < HALF_ORDER; j++)
			{
				float v=0;
				for(k = 0; k < ORDER; k ++)
				{ 
					v += a_matrix_H[i][k]*b_matrix_L[k][j];
				}

				c_matrix_HL[i][j]  = v;
			}
		}
		write_uint8("done_HL",1);
	}
}

#endif
