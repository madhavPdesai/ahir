#include <pthread.h>
#include <Pipes.h>
#include <pipeHandler.h>
#include <stdint.h>
#include <stdio.h>

void Sender()
{
	uint32_t word;
	for(word = 0; word < 10; word++)
	{
		write_uint32("test_fifo",word);
		fprintf(stdout,"Sent:fifo: %d\n", word);
		write_float32("test_lifo",(float)word);
		fprintf(stdout,"Sent:lifo: %f\n", (float) word);
	}
}

void Receiver()
{
	uint32_t word;
	float fword;
        uint32_t idx;
	for(idx = 0; idx < 10; idx++)
	{
		fword = read_float32("test_lifo");
		fprintf(stdout,"Received:lifo: %f\n", fword);

		word = read_uint32("test_fifo");
		fprintf(stdout,"Received:fifo: %d\n", word);
	}
}

int main(int argc, char* argv[])
{
        init_pipe_handler();
	register_pipe("test_fifo",32,32, 0);// last arg = 1 => FIFO
	register_pipe("test_lifo",32,32, 1);// last arg = 1 => LIFO

	Sender(); // write 10 words into both pipes.
	Receiver(); // read back 10 words from both pipes.

        close_pipe_handler();
}
