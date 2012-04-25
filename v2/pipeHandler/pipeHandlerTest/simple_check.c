#include <pthread.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>


// shows the use of the pipeHandler.
int main(int argc, char* argv[])
{
	// must be initialized before doing anything
        init_pipe_handler();

	// register a FIFO pipe test_pipe with
	// word-width 32, depth 32.
	register_pipe("test_pipe",32,32,0);

	// write a integer to test_pipe.
	write_uint32("test_pipe",0);

	// read back and print integer.
	uint32_t v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received %d\n", v);


	// write another integer
	write_uint32("test_pipe",1);

	// read back and print integer.
	v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received %d\n", v);

	// close the handler.
        close_pipe_handler();
        return(0);
}
