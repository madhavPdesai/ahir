#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

char dest1[16] = "dest1_pipe";
char dest2[16] = "dest2_pipe";

int my_strcmp(char* s1, char* s2)
{
	int i = 0;
	while((s1[i] != 0) && (s2[i] != 0))
	{	
		if(s1[i] != s2[i])
			return(1);
		i++;
	}
	return(0);
}

void pipe_dispatch_uint64(char* pipe_id, uint64_t data_val)
{
	if(my_strcmp(pipe_id,"dest1_pipe") == 0)
		write_uint64("dest1_pipe",data_val);
	else if(my_strcmp(pipe_id,"dest2_pipe") == 0)
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


