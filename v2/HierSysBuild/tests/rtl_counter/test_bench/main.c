#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include "pipeHandler.h"
#include "SockPipes.h"

int main (int argc, char* argv[])
{
	sock_write_uint8("UP", 1);
}

