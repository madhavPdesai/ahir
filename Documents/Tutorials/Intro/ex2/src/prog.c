#include <stdint.h> // for uint32_t
#include <Pipes.h>  // for pipes.

//
// reads x(k) from input..
// Computes y(k) = 0.8*x(k) + 0.15*x(k-1) + 0.05*x(k-2)
// sends y(k) to output.
//
float x_vals[2];

//
// This is a daemon, which will be marked as a top-level
// always-running module.  It cannot have inputs/outputs.
//
void firDaemon()
{

  // circular queue..
  x_vals[0] = 0.0;
  x_vals[1] = 0.0;
  uint8_t head_pointer = 0;

  // fir loop.
  while(1)
  {
	float x  = read_float32("in_data");
	float y  = 0.8*x + (0.15*x_vals[head_pointer]) + (0.05*x_vals[(head_pointer+1)&0x1]);
	write_float32("out_data",y);
	head_pointer = (head_pointer + 1)&0x1;
	x_vals[head_pointer] = x;
  }
}
