#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
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
#define N 3
float a_matrix[N][N], b_matrix[N][N], expected_c_matrix[N][N], c_matrix[N][N];

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

#ifdef SW
void *free_queue_manager_(void* fargs)
{
   free_queue_manager();
}

void *proc0_(void* fargs)
{
   proc0();
}

void *proc1_(void* fargs)
{
   proc1();
}

void *proc2_(void* fargs)
{
   proc2();
}

void *proc3_(void* fargs)
{
   proc3();
}

void *input_module_(void* fargs)
{
   input_module();
}

void *output_module_(void* fargs)
{
   output_module();
}

#endif

void *write_pipe_(void* fargs)
{
	write_uint32("in_dimension_pipe",N);
	write_float32_n("in_data_pipe",(float*)a_matrix, N*N);
	write_float32_n("in_data_pipe",(float*)b_matrix, N*N);
}


void *read_pipe_(void* fargs)
{
	uint32_t i;
        for(i = 0; i < N*N; i++) 
	{
		uint32_t row_id  = read_uint32("row_id_pipe");
		uint32_t col_id  = read_uint32("col_id_pipe");
		c_matrix[row_id][col_id]= read_float32("out_data_pipe");
	}
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);
  	signal(SIGSEGV, Exit);

        int i,j,k;

        srand48(100);

        for(i = 0; i < N; i++)
	{
        	for(j = 0; j < N; j++)
		{
			a_matrix[i][j] = 1.0;
			b_matrix[i][j] = 1.0;
		}
	}

        for(i = 0; i < N; i++)
	{
        	for(j = 0; j < N; j++)
		{
			expected_c_matrix[i][j] = 0;
        		for(k = 0; k < N; k++)
				expected_c_matrix[i][j] += a_matrix[k][i] * b_matrix[k][j];
		}
	}
	
#ifdef SW
	init_pipe_handler();
#endif

        pthread_t write_t, read_t;
	pthread_create(&write_t,NULL,&write_pipe_,NULL);
	pthread_create(&read_t,NULL,&read_pipe_,NULL);

#ifdef SW
	pthread_t input_module_t,output_module_t,free_queue_manager_t,proc0_t,proc1_t, proc2_t, proc3_t;
	pthread_create(&input_module_t,NULL,&input_module_,NULL);
	pthread_create(&output_module_t,NULL,&output_module_,NULL);
	pthread_create(&free_queue_manager_t,NULL,&free_queue_manager_,NULL);
	pthread_create(&proc0_t,NULL,&proc0_,NULL);
	pthread_create(&proc1_t,NULL,&proc1_,NULL);
	pthread_create(&proc2_t,NULL,&proc2_,NULL);
	pthread_create(&proc3_t,NULL,&proc3_,NULL);

#endif


	pthread_join(write_t,NULL);
	pthread_join(read_t,NULL);

 	fprintf(stdout,"from out_data, we read\n ");
        for(i = 0; i < N; i++)
	{
        	for(j = 0; j < N; j++)
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
	pthread_cancel(input_module_t);
	pthread_cancel(output_module_t);
	pthread_cancel(free_queue_manager_t);
	pthread_cancel(proc0_t);
	pthread_cancel(proc1_t);
	pthread_cancel(proc2_t);
	pthread_cancel(proc3_t);
#endif
#ifdef SW
	close_pipe_handler();
#endif
}
