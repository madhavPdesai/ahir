#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

void in_ctrl_module()
{
    while(1)
    {
       uint8_t foo_in_val = read_uint8("in_ctrl");
#ifdef RUN
	fprintf(stderr,"in_ctrl_module: read ctrl=%x\n", foo_in_val);
#endif
       write_uint8("ctrl_from_tb", foo_in_val);
    }
}

void in_data_module()
{
    while(1)
    {
       uint64_t foo_in_val = read_uint64("in_data");
#ifdef RUN
	fprintf(stderr,"in_data_module: read data=%llx\n", foo_in_val);
#endif
       write_uint64("data_from_tb", foo_in_val);
    }
}


// forward..
void foo()
{
	while(1)
	{
		uint64_t data = read_uint64("data_from_tb");
		uint8_t ctrl = read_uint8("ctrl_from_tb");
#ifdef RUN
		fprintf(stderr,"foo: read ctrl=%x, data=%llx\n", ctrl,data);
#endif 
		write_uint64("data_to_tb", data);
		write_uint8("ctrl_to_tb", ctrl);
	}
}

void out_ctrl_module()
{
    while(1)
    {
       uint8_t foo_in_val = read_uint8("ctrl_to_tb");
#ifdef RUN
	fprintf(stderr,"out_ctrl_module: read ctrl=%x\n", foo_in_val);
#endif
       write_uint8("out_ctrl", foo_in_val);
    }
}

void out_data_module()
{
    while(1)
    {
       uint64_t foo_in_val = read_uint64("data_to_tb");
#ifdef RUN
	fprintf(stderr,"out_data_module: read data=%llx\n", foo_in_val);
#endif
       write_uint64("out_data", foo_in_val);
    }
}
