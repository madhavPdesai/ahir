#include <pth.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>


// shows the use of the pipeHandler.
int main(int argc, char* argv[])
{

	pth_init();

	// must be initialized before doing anything
        init_pipe_handler();

	// register a FIFO pipe test_pipe with
	// depth 32, word-width 32.
	register_pipe("test_pipe",32,32,0);
	register_pipe("test_pipe_64",1,64,0);

	// write a integer to test_pipe.
	write_uint32("test_pipe",1);
	uint64_t tmp = 1;
	tmp = tmp | (tmp << 32);
	write_uint64("test_pipe_64",tmp);

	// read back and print integer.
	uint32_t v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received uint32_t %d\n", v);

	uint64_t v64 = read_uint64("test_pipe_64");
	fprintf(stderr,"TEST: received uint64_t %llu\n", v64);

	// write another integer
	write_uint32("test_pipe",1);

	// read back and print integer.
	v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received %d\n", v);

	// close the handler.
        close_pipe_handler();
        return(0);
}
