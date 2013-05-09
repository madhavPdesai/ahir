#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthreadUtils.h>
#include <Pipes.h>
#include <pipeHandler.h>
#ifndef SW
#include "vhdlCStubs.h"
#endif
#include "divider.h"
#include "gcd.h"

to_string(char* str, uint16_t val)
{
	int i;
 	for(i = 0; i < 16; i++)
        {
		if(val & (1 << (15-i)))
			str[i] = '1';
		else
			str[i] = '0';
        }
	str[16] = 0;
}

#ifdef SW
DEFINE_THREAD(gcd_daemon);
#endif

int main(int argc, char* argv[])
{
        FILE* ofile1;
        FILE* ofile2;
        char ostr[17];
	uint16_t N[ORDER];

#ifdef SW
	init_pipe_handler();
	PTHREAD_DECL(gcd_daemon);
	PTHREAD_CREATE(gcd_daemon);
#endif

        ofile1 = fopen("gcd_inputs.txt","w");
        ofile2 = fopen("gcd_result.txt","w");

	int err = 0;
   
	uint16_t S = 1;
	if(argc > 1)
		S = atoi(argv[1]);
	fprintf(stderr,"Scale-factor = %d.\n",S);


	srand48(19);

	uint16_t i;
	for(i = 0; i < ORDER; i++)
	{
		N[i] = ((uint16_t) (0x0fff * drand48())) * S;
		fprintf(stderr,"N[%d] = %d\n", i, N[i]);
		write_uint16("in_data",N[i]);
		to_string(ostr,N[i]);
		fprintf(ofile1,"%s\n", ostr);
	}

	uint16_t g = read_uint16("out_data");
	fprintf(stderr,"GCD = %d.\n",g);
	to_string(ostr,g);
	fprintf(ofile2,"%s\n",ostr);

	uint32_t et = read_uint32("elapsed_time");
	fprintf(stderr,"Elapsed time = %u.\n", et);

	fclose(ofile1);
	fclose(ofile2);

#ifdef SW
	PTHREAD_CANCEL(gcd_daemon);
	close_pipe_handler();
#endif

	return(0);
}
