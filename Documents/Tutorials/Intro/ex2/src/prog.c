#include <stdint.h> // for uint32_t
#include <Pipes.h>  // for pipes.

void maxDaemon()
{
  while(1)
  {
	uint32_t a  = read_uint32("in_data");
	uint32_t b  = read_uint32("in_data");
  	uint32_t c = ((a > b) ? a : b);
	write_uint32("out_data",c);
  }
}
