#include <pthread.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>

int TSIZE = 10000;
void Sender()
{
	uint32_t word;
	for(word = 0; word < TSIZE; word++)
	{
		write_uint32("S_to_R",word);
		uint32_t rword = read_uint32("R_to_S");
		if(rword != word)
		{
			fprintf(stderr,"Error: Sender received incorrect response: %d (expected %d).\n", rword, word);
		}
	}
	fprintf(stderr,"Info: Sender done.\n");
}

void Receiver()
{
	uint32_t word;
	while(1)
	{

		word = read_uint32("S_to_R");
		write_uint32("R_to_S", word);
	}
}

DEFINE_THREAD(Sender);
DEFINE_THREAD(Receiver);

int main(int argc, char* argv[])
{
	if(argc > 1)
	{
		TSIZE = atoi(argv[1]);
	}

	fprintf(stderr,"Info: Test-size = %d.\n", TSIZE);

        init_pipe_handler();
	register_pipe("S_to_R",32,32, 0);
	register_pipe("R_to_S",32,32, 0);

	PTHREAD_DECL(Sender);
	PTHREAD_CREATE(Sender);
	PTHREAD_DECL(Receiver);
	PTHREAD_CREATE(Receiver);

	PTHREAD_JOIN(Sender);
	PTHREAD_CANCEL(Receiver);
	close_pipe_handler();
}
