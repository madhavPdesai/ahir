#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

void ctrl_module()
{
    while(1)
    {
       uint8_t foo_in_val = read_uint8("in_ctrl");
       write_uint8("out_ctrl", foo_in_val);
    }
}

void data_module()
{
    while(1)
    {
       uint64_t foo_in_val = read_uint64("in_data");
       write_uint64("out_data", foo_in_val);
    }
}

