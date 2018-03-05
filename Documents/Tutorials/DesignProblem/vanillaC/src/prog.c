#include <stdint.h> // for uint32_t
#include <Pipes.h>  // for pipes.

// must be a power of 2.
#define ORDER 8

void pfirf ()
{
    int i;
    float taps[ORDER];
    float xvals[ORDER];
    for (i = 0; i < ORDER; i++)
    {
       taps[i] = read_float32("in_data");
       xvals [i] = 0;
    }
    int HEAD = ORDER-1;
    while (1)
    {
        float x = read_float32("in_data");
	xvals [HEAD] =  x;  
        float output_val = 0.0;
	for (i = 0; i < ORDER; i++)
            output_val += xvals [ (i + HEAD) & (ORDER - 1) ] * taps [(ORDER-1) -i]; 
        write_float32 ("out_data", output_val);
	HEAD = (HEAD - 1) & (ORDER - 1);
    }
}
