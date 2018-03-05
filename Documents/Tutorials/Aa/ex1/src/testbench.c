#include <stdio.h>
#include <stdint.h>

#ifdef SW
#include "aa_c_model.h"
#endif

#ifdef SW
void  maxOfTwo(uint32_t, uint32_t, uint32_t*);
#else
uint32_t maxOfTwo(uint32_t, uint32_t);
#endif

int main(int argc, char* argv[])
{
  if(argc < 3)
  {
     fprintf(stderr, "%s <uint32_t> <uint32_t>\n", argv[0]);
     return(1);
  }
  uint32_t c;

#ifdef SW
  maxOfTwo(atoi(argv[1]), atoi(argv[2]), &c);
#else
  c = maxOfTwo(atoi(argv[1]), atoi(argv[2]));
#endif

  fprintf(stdout,"Result = %d.\n", c);
  return(0);
}

