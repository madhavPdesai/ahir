#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"


float a_matrix[ORDER][ORDER];
float b_matrix[ORDER][ORDER];
float c_matrix[ORDER][ORDER];


void send_output()
{
	uint32_t i,j;
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
		{
			write_float32("result_pipe",c_matrix[i][j]);
		}
	}
}

void get_input()
{
	uint32_t i,j;
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
			a_matrix[i][j] = read_float32("in_data_pipe");
	}
#ifdef SW
	fprintf(stderr,"input_module: got a\n");
#endif
	for(i=0; i < ORDER; i++)
	{
		for (j = 0; j < ORDER; j++)
			b_matrix[i][j] = read_float32("in_data_pipe");
	}
#ifdef SW
	fprintf(stderr,"input_module: got b\n");
#endif
}

void mmultiply()
{
	uint32_t i,j,k;
	while(1)
	{
		get_input();

		for(i=0; i < ORDER; i++)
		{
			for (j = 0; j < ORDER; j++)
			{
				float val = 0;
				for(k = 0; k < ORDER; k++)
				{ 
					float a = a_matrix[i][k];
					float b = b_matrix[k][j];
					val += (a*b);
				}
				c_matrix[i][j] = val;
			}
		}

		send_output();
	}
}

