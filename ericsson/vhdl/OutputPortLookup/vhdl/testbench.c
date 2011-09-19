#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
//
// the next two inclusions are
// to be used in the software version
//  
#include <vhdlCStubs.h>
//
//

#define N 10
#define PKT_LENGTH 16


typedef struct PipeArgs_ PipeArgs;
struct PipeArgs_
{
	char* name;
	void* data;
};

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}

void *output_port_lookup_(void* fargs)
{
   output_port_lookup();
}

void *write_pipe_data_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	write_uint64_n(aa->name,(uint64_t*)(aa->data), PKT_LENGTH*N);
}
void *write_pipe_ctrl_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	write_uint8_n(aa->name,(uint8_t*)(aa->data), PKT_LENGTH*N);
}
void *read_pipe_data_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	read_uint64_n(aa->name,(uint64_t*)(aa->data), PKT_LENGTH*N);
}
void *read_pipe_ctrl_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	read_uint8_n(aa->name,(uint8_t*)(aa->data), PKT_LENGTH*N);
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint64_t pipe_data_in[PKT_LENGTH*N], pipe_data_out[PKT_LENGTH*N];
	uint8_t pipe_ctrl_in[PKT_LENGTH*N], pipe_ctrl_out[PKT_LENGTH*N];
        int i,j;

	// N packets, each of PKT_LENGTH words..
        for(i = 0; i < N; i++)
	{
	  pipe_data_in[PKT_LENGTH*i] = (((uint64_t) PKT_LENGTH) << ((uint64_t) 32)) | ((uint64_t) i);
	  pipe_ctrl_in[PKT_LENGTH*i] = 0xff;
	  for(j = 1; j < PKT_LENGTH-1; j++)
	    {
	      pipe_data_in[(PKT_LENGTH*i)+j] = i;
	      pipe_ctrl_in[(PKT_LENGTH*i)+j] = 0;		    
	    }
	  pipe_data_in[(PKT_LENGTH*(i+1))-1] = i;
	  pipe_ctrl_in[(PKT_LENGTH*(i+1))-1] = 1;		    
	}

 	fprintf(stdout,"to in_ctrl and in_data, we send:\n");
        for(i = 0; i < PKT_LENGTH*N; i++) 
 	  fprintf(stdout," ctrl %0x data %0llx\n", pipe_ctrl_in[i], pipe_data_in[i]);

 	fprintf(stdout,"creating threads:\n");
	pthread_t op_lu_t,  wc_t, wd_t, rc_t, rd_t;

	//pthread_create(&op_lu_t,NULL,&output_port_lookup_,NULL);

	PipeArgs wc = {strdup("in_ctrl"), (void*) pipe_ctrl_in};
	PipeArgs wd = {strdup("in_data"), (void*) pipe_data_in};
	PipeArgs rc = {strdup("out_ctrl"), (void*) pipe_ctrl_out};
	PipeArgs rd = {strdup("out_data"), (void*) pipe_data_out};

	pthread_create(&wc_t,NULL,&write_pipe_ctrl_,(void*)&wc);
	pthread_create(&wd_t,NULL,&write_pipe_data_,(void*)&wd);
	pthread_create(&rc_t,NULL,&read_pipe_ctrl_,(void*)&rc);
	pthread_create(&rd_t,NULL,&read_pipe_data_,(void*)&rd);


	pthread_join(wc_t,NULL);
	pthread_join(wd_t,NULL);
	pthread_join(rc_t,NULL);
	pthread_join(rd_t,NULL);


 	fprintf(stdout,"from out_ctrl and out_data, we read:\n");
        for(i = 0; i < PKT_LENGTH*N; i++) 
 	   fprintf(stdout," ctrl %0x data %0llx\n", pipe_ctrl_out[i], pipe_data_out[i]);

	//pthread_cancel(op_lu_t);
}
