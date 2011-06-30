#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

void io_module()
{
    while(1)
    {
       uint64_t foo_in_val = read_uint64("foo_in");
       write_uint64("foo_out", foo_in_val);
    }
}

