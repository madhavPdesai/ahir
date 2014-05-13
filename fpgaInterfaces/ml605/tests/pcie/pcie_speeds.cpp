#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "timer.h"
#include <riffa.h>

using namespace std;



fpga_t * fpga;
int beginSend = 0;
int beginRecv = 0;
int end = 0;
int numWords = 8388608*2; 


void * sender_fxn(void *) 
{
	unsigned int * sendbuf;
	GET_TIME_INIT(2);
	sendbuf = (unsigned int *)malloc(numWords<<2);
	for (int i = 0; i<numWords; i++)
	{
		sendbuf[i] = i*2 + i%10;
	}
	cout << "reached here in TX" << endl;
	int sent;
	while(!beginRecv);
	beginSend = 1;	
	GET_TIME_VAL(0);
	sent = fpga_send(fpga, 0,sendbuf, numWords, 0, 1, 2000);
	GET_TIME_VAL(1);
	if (1) 
	{
		printf("Sent %d words, expecting %d. Exiting.\n", sent, numWords);
		end = 1;
	}			

	for (int i=0; i<10; i++)
	{
		cout << "sent word " << i << " is "<< sendbuf[i] << endl;
	}
	printf("sending bw: %f MB/s %fms\n", sent*4.0/1024/1024/((TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0))/1000.0), (TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0)) );
	while(!end);

	if (sendbuf != NULL)
		sendbuf = NULL;
}


void * receiver_fxn(void *) 
{
	unsigned int * recvbuf;
	GET_TIME_INIT(2);
	recvbuf = (unsigned int *)malloc((numWords)<<2);
	for (int i = 0; i<numWords; i++)
	{
		recvbuf[i] = 0;
	}
	int rc;
	cout << "reached here in rx" << endl;
	beginRecv = 1;
	while (!beginSend){;};
	// Create the receive buffer
	GET_TIME_VAL(0);		
	// Wait for the filtered data to come back.
	rc = fpga_recv(fpga, 0, recvbuf, numWords, 2000);
	GET_TIME_VAL(1);
	if (1) 
	{
		printf("Received %d words, expecting %d. Exiting.\n", rc, numWords);
	}			
	

	for (int i=0; i<10; i++)
	{
		cout << "received word " << i << " is " << recvbuf[i] << endl;
	}
	printf("recv bw: %f MB/s %fms\n", rc*4.0/1024/1024/((TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0))/1000.0), (TIME_VAL_TO_MS(1) - TIME_VAL_TO_MS(0)) );

	if (recvbuf != NULL)
		recvbuf = NULL;
}


int main( int argc, const char** argv ) 
{
	pthread_t sender; 
	pthread_t receiver; 

	if (argc<2)
	{
		fprintf(stderr, "supply fpga number. Format ./tb <index>\n");
		return 1;
	}
	fpga = fpga_open(atoi(argv[1]));
    	if(fpga == NULL)
    	{
    	    cerr << "ERROR: Could not open FPGA " << atoi(argv[1]) << "!" << endl;
    	    return -1;
    	}


	fpga_reset(fpga);

    	pthread_create(&sender, NULL, sender_fxn, NULL);
    	pthread_create(&receiver, NULL, receiver_fxn, NULL);
    	pthread_join(sender, NULL);
    	pthread_join(receiver, NULL);

    	return 0;
}

