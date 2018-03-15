// TESTBENCH.
#include <stdio.h>  // fprintf
#include <stdint.h> // uint
#include <Pipes.h>  // read_/write_ 
#include <pthreadUtils.h>  // for thread define/create etc.
#include <pthread.h>

#ifndef SW
#include <vhdlCStubs.h>
#endif


#ifdef SW
void sort_daemon();
// macro defined in ahir_release/include/pthreadUtils.h
DEFINE_THREAD (sort_daemon);  // to define a thread which starts sort_daemon.
#endif


int main (int argc, char* argv[])
{

	int err_flag = 0;
	int I;

#ifdef SW
	// declare and create sort-daemon thread.
	// macros defined in ahir_release/include/pthreadUtils.h
	PTHREAD_DECL(sort_daemon);
	//  This will start the thread sort_daemon...
	PTHREAD_CREATE(sort_daemon);
#endif

	// send 16 numbers in reversed order...
	for (I = 0; I < 16; I++)
	{
		write_uint8("in_data", (15-I));
	}

	// Now try to read 16 numbers and check if
	// we get what we expect..
	for (I = 0; I < 16; I++)
	{
		uint8_t V = read_uint8("out_data");
		if (((int) V) != I)
		{
			fprintf(stderr,"Error: expected %d, received %d\n", I, V);
			err_flag = 1;
		}
		else
		{
			fprintf(stderr,"Info: expected %d, received %d\n", I, V);
		}
	}

	return(err_flag);	
	
}
