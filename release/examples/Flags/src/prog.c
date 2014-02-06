#include <stdlib.h>
#include <stdint.h>
#include <Pipes.h>
#include <stdio.h>
#include <fpu.h>
#include "prog.h"


void mullerCElement()
{
	uint8_t q = 0;
	while(1)
	{
		if(q == 0)
		{
			while(1)
			{
				uint8_t a = read_uint8("a");
				uint8_t b = read_uint8("b");
				if((a != 0) && (b != 0))
					break;
			}
			q = 1;
			write_uint8("q",1);
		}
		else
		{
			while(1)
			{
				uint8_t a = read_uint8("a");
				uint8_t b = read_uint8("b");
				if((a == 0) && (b == 0))
					break;
			}
			q = 0;
			write_uint8("q",0);
		}
	}
}

