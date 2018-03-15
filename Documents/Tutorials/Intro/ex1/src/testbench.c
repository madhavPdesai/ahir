#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
uint32_t maxOfTwo(uint32_t, uint32_t);

int main(int argc, char* argv[])
{
  if(argc < 3)
  {
     fprintf(stderr, "%s <uint32_t> <uint32_t>\n", argv[0]);
     return(1);
  }
  uint32_t c = maxOfTwo(atoi(argv[1]), atoi(argv[2]));
  fprintf(stdout,"Result = %d.\n", c);
  return(0);
}

