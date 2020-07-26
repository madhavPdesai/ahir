#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <Pipes.h>
#include <SR4_sr4.h>

int main (int argc, char* argv[])
{
	int err_flag = 0;
	SR4_start_daemons (NULL,0);
	uint16_t I;
	for(I=0; I < 16;I++)
	{
		write_uint16("A",I);
		uint16_t J = read_uint16("B");
		if(16*I != J)
		{
			fprintf(stderr,"Error:expected %d, found %d\n", 16*I,J);
			err_flag =1;
		}
		else
		{
			fprintf(stderr,"Info:expected %d, found %d\n", 16*I,J);
		}
	}
	SR4_stop_daemons ();
	return(err_flag);
}

