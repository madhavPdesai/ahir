#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include "prog.h"
//
// the next two inclusions are
// to be used in the software version
//  
#ifdef SW
#include <pipeHandler.h>
#include <Pipes.h>
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

//
//
float a_matrix[ORDER][ORDER], b_matrix[ORDER][ORDER], expected_c_matrix[ORDER][ORDER], c_matrix[ORDER][ORDER];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

#ifdef SW
void *mmultiply__(void* fargs)
{
    mmultiply();
}
#endif

void write_matrices()
{
	uint32_t i,j;
        for(i = 0; i < ORDER; i++) 
	{
        	for(j = 0; j < ORDER; j++) 
		{
			write_float32("in_data_pipe",a_matrix[i][j]);
		}
	}

        for(i = 0; i < ORDER; i++) 
	{
        	for(j = 0; j < ORDER; j++) 
		{
			write_float32("in_data_pipe",b_matrix[i][j]);
		}
	}
}


void read_result_matrix()
{
	uint32_t i,j;
        for(i = 0; i < ORDER; i++) 
	{
        	for(j = 0; j < ORDER; j++) 
		{
			c_matrix[i][j]= read_float32("result_pipe");
		}
	}
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
  	signal(SIGSEGV, Exit);

        int i,j,k;

        srand48(100);

        for(i = 0; i < ORDER; i++)
	{
        	for(j = 0; j < ORDER; j++)
		{
			a_matrix[i][j] = drand48();
			b_matrix[i][j] = drand48();
		}
	}

        for(i = 0; i < ORDER; i++)
	{
        	for(j = 0; j < ORDER; j++)
		{
			expected_c_matrix[i][j] = 0;
        		for(k = 0; k < ORDER; k++)
				expected_c_matrix[i][j] += a_matrix[i][k] * b_matrix[k][j];
		}
	}
	
#ifdef SW
	init_pipe_handler();
#endif


#ifdef SW
	pthread_t mmultiply_t;
	pthread_create(&mmultiply_t,NULL,&mmultiply__,NULL);
#endif

	write_matrices();
	read_result_matrix();



 	fprintf(stdout,"results: \n ");
        for(i = 0; i < ORDER; i++)
	{
        	for(j = 0; j < ORDER; j++)
		{
                	if(expected_c_matrix[i][j] == c_matrix[i][j])
				fprintf(stdout,"result[%d][%d] = %f\n", i, j, c_matrix[i][j]);
			else
				fprintf(stdout,"Error: result[%d][%d] = %f, expected = %f\n", 
					i, j, c_matrix[i][j], expected_c_matrix[i][j]);
			
		}
	}
 	fprintf(stdout,"done\n");

#ifdef SW
	pthread_cancel(mmultiply_t);
	close_pipe_handler();
#endif
}
