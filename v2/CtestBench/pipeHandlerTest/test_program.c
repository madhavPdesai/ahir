#include <pthread.h>
#include <SocketLib.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>

void* pipeHandler__()
{
	pipeHandler();
}

void* Sender()
{
	uint32_t word;
	for(word = 0; word < 10; word++)
	{
		write_uint32("test_pipe",word);
		fprintf(stdout,"Sent: %d\n", word);
		write_float32("test_pipe",(float)word);
		fprintf(stdout,"Sent: %f\n", (float) word);
	}
}

void* Receiver()
{
	uint32_t word;
	float fword;
	while(1)
	{
		word = read_uint32("test_pipe");
		fprintf(stdout,"Received: %d\n", word);
		fword = read_float32("test_pipe");
		fprintf(stdout,"Received: %f\n", fword);
	}
}

int main(int argc, char* argv[])
{
	pthread_t phandler_t, sender_t, receiver_t;
	pthread_create(&phandler_t,NULL,&pipeHandler__,NULL);

	register_pipe("test_pipe",32,32);

	pthread_create(&sender_t,NULL,&Sender,NULL);
	pthread_create(&receiver_t,NULL,&Receiver,NULL);

	pthread_join(sender_t,NULL);
	usleep(1000);
	pthread_cancel(receiver_t);
	
	killPipeHandler();
	pthread_join(phandler_t,NULL);
}
