#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

int foo(int a)
{
	return(2*a); 
}

void io_module()
{
    while(1)
    {
       int foo_in_val = read_uint32("foo_in");
       write_uint32("foo_out", foo(foo_in_val));
    }
}

