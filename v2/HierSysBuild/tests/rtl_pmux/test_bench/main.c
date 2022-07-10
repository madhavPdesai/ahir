#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include "pipeHandler.h"
#include "SockPipes.h"

int main (int argc, char* argv[])
{
	sock_write_uint8("In_1", 1);
	uint8_t r = sock_read_uint8 ("Out_1");

	sock_write_uint8("In_2", 2);
	r = sock_read_uint8 ("Out_1");

	sock_write_uint8("In_1", 3);
	r = sock_read_uint8 ("Out_1");

	sock_write_uint8("In_2", 4);
	r = sock_read_uint8 ("Out_1");

}

