#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "divider.h"

int main(int argc, char* argv[])
{
	int err = 0;
	int nsamples = 10;
	if(argc > 1)
		nsamples = atoi(argv[1]);

	if(nsamples < 0)
		nsamples = 10;

	srand48(19);

        // check if divide by 1 works.
        uint16_t tmp, rmndr;
        tmp = udiv16(13,1, &rmndr);
        if(tmp != 13) 
        {
		fprintf(stderr,"Error: 13/1 = %d, expected 13\n",tmp);
		err = 1;
        }

        tmp = udiv16(1,1,&rmndr);
        if(tmp != 1) 
        {
		fprintf(stderr,"Error: 1/1 = %d, expected 1\n",tmp);
		err = 1;
	}
 
	while(nsamples > 0)
	{
		uint16_t Q = (uint16_t) (0xffff * drand48());
		uint16_t D = (uint16_t) (0xffff * drand48());
		uint16_t R;

		uint16_t Qc = udiv16(Q,D,&R);
		if(Qc != (Q/D))
		{
			err = 1;
			fprintf(stderr,"Error: %d/%d = %d, expected %d\n", Q,D,Qc, (Q/D));
		}

		if(R != (Q % D))
		{
			fprintf(stderr,"Error: %d mod %d = %d, expected %d\n", Q,D,R,(Q % D));
			err = 1;
		}

		nsamples--;
	}

	if(!err)
		fprintf(stderr,"Success: all tests passed.\n");
	return(err);
}
