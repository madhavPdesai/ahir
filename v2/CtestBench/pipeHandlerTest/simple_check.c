#include <pthread.h>
#include <SocketLib.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>

void* pipeHandler__()
{
	pipeHandler();
}


int main(int argc, char* argv[])
{
	pthread_t phandler_t;
	pthread_create(&phandler_t,NULL,&pipeHandler__,NULL);

	register_pipe("test_pipe",32,32,0);
	usleep(1000);

	write_uint32("test_pipe",0);
	uint32_t v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received %d\n", v);

	write_uint32("test_pipe",1);
	v = read_uint32("test_pipe");
	fprintf(stderr,"TEST: received %d\n", v);

        killPipeHandler();
}
