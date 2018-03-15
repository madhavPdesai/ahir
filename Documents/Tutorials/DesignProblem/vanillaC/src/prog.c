#include <stdint.h> // for uint32_t
#include <Pipes.h>  // for pipes.

// must be a power of 2.
#define ORDER 8

void pfirf ()
{
    int i;

    // taps and saved input values
    float taps[ORDER];
    float xvals[ORDER];

    // initialize taps and xvals.
    for (i = 0; i < ORDER; i++)
    {
       taps[i] = read_float32("in_data");
       xvals [i] = 0;
    }

    // x values will be organized as a circular
    // queue.  
    int HEAD = ORDER-1;
    while (1)
    {
	// incoming x, put at head.
        float x = read_float32("in_data");
	xvals [HEAD] =  x;  

	// inner loop computes the FIR value.
        float output_val = 0.0;
	for (i = 0; i < ORDER; i++)
            output_val += xvals [ (i + HEAD) & (ORDER - 1) ] * taps [(ORDER-1) -i]; 

	// send out the FIR output.
        write_float32 ("out_data", output_val);

	// adjust head.
	HEAD = (HEAD - 1) & (ORDER - 1);
    }
}
