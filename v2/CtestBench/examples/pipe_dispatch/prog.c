#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

char dest1[16] = "dest1_pipe";
char dest2[16] = "dest2_pipe";

void pipe_dispatch_uint64(char* pipe_id, uint64_t data_val)
{
	if(pipe_id[4] == '1')
		write_uint64("dest1_pipe",data_val);
	else if (pipe_id[4] == '2')
		write_uint64("dest2_pipe",data_val);
}

void global_storage_initializer_();
void io_module()
{
    char* pipe_id;
  
    global_storage_initializer_();

    while(1)
    {
	pipe_id = dest1;
       	uint64_t foo_in_val = read_uint64("foo_in");
       	pipe_dispatch_uint64(pipe_id, foo_in_val);

	pipe_id = dest2;
       	foo_in_val = read_uint64("foo_in");
       	pipe_dispatch_uint64(pipe_id, foo_in_val);
    }
}


