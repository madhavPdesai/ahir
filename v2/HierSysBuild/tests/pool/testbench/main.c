#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <Pipes.h>
#include <SYS_LIB_sys.h>

int main (int argc, char* argv[])
{
	int err_flag = 0;
#ifdef SW
	SYS_LIB_start_daemons (NULL,0);
#endif
	uint8_t I;
	for(I=0; I < 16;I++)
	{
		write_uint8("DATA_IN",I);
		uint8_t J = read_uint8("DATA_OUT");
		if(2*I != J)
		{
			fprintf(stderr,"Error:expected %d, found %d\n", 2*I,J);
			err_flag =1;
		}
		else
		{
			fprintf(stderr,"Info:expected %d, found %d\n", 2*I,J);
		}
	}
#ifdef SW
	SYS_LIB_stop_daemons ();
#endif
	return(err_flag);
}

