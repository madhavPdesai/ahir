#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>

typedef struct _Job
{
	uint32_t dimension;
	uint32_t row_id;
	uint32_t col_id;
	uint32_t a;
        uint32_t b;
	float result;
} Job;


float a_matrix[1024];
float b_matrix[1024];


#define FREE_LIST_PUT 1
#define FREE_LIST_GET 2

#define FREE_LIST_SIZE 10
typedef struct Link_ Link;

struct Link_
{
        int32_t index;
	int32_t next;
	Job job;
};

Link free_list[FREE_LIST_SIZE];
int32_t head;

float mul32(float a, float b)
{
   return(a*b);
}

float add32(float a, float b)
{
   return(a+b);
}

#define PROC_ while(1) {\
        uint32_t ret_val = 0;\
        int32_t fid = (int32_t) read_uint32("job_queue_pipe");\
	uint32_t aindex = free_list[fid].job.a;\
	uint32_t bindex = free_list[fid].job.b;\
        uint32_t dimension = free_list[fid].job.dimension;\
        int i,iF;\
        ret_val = 0;\
	for(i = 0, iF = 4*(dimension/4); i < iF; i=i+4)\
	{\
		ret_val = add32(ret_val , mul32(a_matrix[(i+aindex)] , b_matrix[(i+bindex)]));\
		ret_val = add32(ret_val , mul32(a_matrix[((i+1)+aindex)] , b_matrix[((i+1)+bindex)]));\
		ret_val = add32(ret_val , mul32(a_matrix[((i+2)+aindex)] , b_matrix[((i+2)+bindex)]));\
		ret_val = add32(ret_val , mul32(a_matrix[((i+3)+aindex)] , b_matrix[((i+3)+bindex)]));\
	}\
	for(i = iF ; i < dimension; i++)\
	{\
		ret_val = add32(ret_val , mul32(a_matrix[(i+aindex)] , b_matrix[(i+bindex)]));\
	}\
	free_list[fid].job.result = ret_val;\
	write_uint32("result_queue_pipe",fid);\
    }

void free_queue_manager()
{
	uint32_t i;

	for(i = 0; i < FREE_LIST_SIZE-1; i++)
	{
		free_list[i].index = i;
		free_list[i].next = i+1;
	}
	free_list[FREE_LIST_SIZE-1].index = FREE_LIST_SIZE-1;
	free_list[FREE_LIST_SIZE-1].next = -1;

 	head = 0;
	
	while(1)
	{
		uint8_t command = read_uint8("free_queue_request_pipe");
		if(command == FREE_LIST_GET)
		{
			int32_t ret = head;
			if(head != -1)
                        {
				head = free_list[head].next;
			}
			write_uint32("free_queue_get_pipe", ret);
		}	
		else if(command == FREE_LIST_PUT)
		{
			int32_t put_link = (int32_t) read_uint32("free_queue_put_pipe");
			free_list[put_link].next = head;
			head = put_link;
		}
#ifdef RUN
		else
			fprintf(stderr,"Error: unknown free list command\n");

		usleep(1);
#endif

	}
}


void proc0()
{
	PROC_
}

void proc1()
{
	PROC_
}

void proc2()
{
	PROC_
}

void proc3()
{
	PROC_
}

void input_module()
{
	while(1)
	{
		uint32_t dimension = read_uint32("in_dimension_pipe");
#ifdef RUN
		fprintf(stderr,"input_module: got dimension %d\n",dimension);
#endif
		uint32_t matrix_size = dimension*dimension;
		
		uint32_t i;
		for(i=0; i < matrix_size; i++)
			a_matrix[i] = read_float32("in_data_pipe");
#ifdef RUN
		fprintf(stderr,"input_module: got a\n");
#endif
		for(i=0; i < matrix_size; i++)
			b_matrix[i] = read_float32("in_data_pipe");
#ifdef RUN
		fprintf(stderr,"input_module: got b\n");
#endif


		uint32_t ioffset = 0;
		for(i=0, ioffset=0; i < dimension; i++)
		{
		    uint32_t joffset = 0;
		    uint32_t j;
		    for(j = 0, joffset = 0; j < dimension; j++)
		    {
			int32_t fid;
			while(1)
			{
				write_uint8("free_queue_request_pipe", FREE_LIST_GET);
				fid  =  (int32_t) read_uint32("free_queue_get_pipe");
				if(fid >= 0)
					break;
#ifdef RUN
				usleep(100);
#endif
			}

#ifdef RUN
			fprintf(stderr,"input_module: got free slot\n");
#endif
                	free_list[fid].job.dimension = dimension;
			free_list[fid].job.a = ioffset;
			free_list[fid].job.b = joffset;
			free_list[fid].job.col_id = j;
			free_list[fid].job.row_id = i;

			write_uint32("job_queue_pipe", fid);
#ifdef RUN
			fprintf(stderr,"input_module: sent job \n");
#endif
			joffset = (joffset+dimension);
                    }
		    ioffset = (ioffset+dimension);
		}

	}
}

void output_module()
{
	while(1)
	{
		int32_t fid = (int32_t) read_uint32("result_queue_pipe");

#ifdef RUN
		fprintf(stderr,"output_module: got result %f\n", free_list[fid].job.result);
#endif
		write_uint32("row_id_pipe", free_list[fid].job.row_id);
		write_uint32("col_id_pipe", free_list[fid].job.col_id);
		write_float32("out_data_pipe", free_list[fid].job.result);
#ifdef RUN
		fprintf(stderr,"output_module: sent result\n");
#endif

		write_uint8("free_queue_request_pipe", FREE_LIST_PUT);
		write_uint32("free_queue_put_pipe", fid);

#ifdef RUN
		fprintf(stderr,"output_module: released slot\n");
#endif
	}
}

