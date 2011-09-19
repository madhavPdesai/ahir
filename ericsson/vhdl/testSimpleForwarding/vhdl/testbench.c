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

void *ctrl_module_(void* fargs)
{
   ctrl_module();
}
void *data_module_(void* fargs)
{
   data_module();
}

void *write_pipe_data_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	write_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
	write_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
	write_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
	write_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
}
void *write_pipe_ctrl_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	write_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
	write_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
	write_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
	write_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
}
void *read_pipe_data_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	read_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
	read_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
	read_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
	read_uint64_n(aa->name,(uint64_t*)(aa->data), 10);
}
void *read_pipe_ctrl_(void* a)
{
	PipeArgs* aa = (PipeArgs*) a;
	read_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
	read_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
	read_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
	read_uint8_n(aa->name,(uint8_t*)(aa->data), 10);
}


int main(int argc, char* argv[])
{
	signal(SIGINT,  Exit);
  	signal(SIGTERM, Exit);

	uint64_t pipe_data_in[10], pipe_data_out[10];
	uint8_t pipe_ctrl_in[10], pipe_ctrl_out[10];
        int i;
	
        for(i = 0; i < 10; i++)
	{
		pipe_data_in[i] = i;
		pipe_ctrl_in[i] = 0;
	}

	pipe_ctrl_in[0] = 0xff;
	pipe_ctrl_in[9] = 0x1;

 	fprintf(stdout,"to in_ctrl and in_data, we send:\n");
        for(i = 0; i < 10; i++) 
 	   fprintf(stdout," ctrl %0x data %0llx\n", pipe_ctrl_in[i], pipe_data_in[i]);

	pthread_t foo_t, c_t, d_t, wc_t, wd_t, rc_t, rd_t;

	//pthread_create(&c_t,NULL,&ctrl_module_,NULL);
	//pthread_create(&d_t,NULL,&data_module_,NULL);

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
        for(i = 0; i < 10; i++) 
 	   fprintf(stdout," ctrl %0x data %0llx\n", pipe_ctrl_out[i], pipe_data_out[i]);

	//pthread_cancel(c_t);
	//pthread_cancel(d_t);
}
