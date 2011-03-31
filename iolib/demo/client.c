#include "../iolib.h"
#define RUN

#ifdef RUN
#include <stdlib.h>
#include <stdio.h>

int main (void)
#else
int start (void)
#endif
{
  uint32_t i, apl;
  float ong, my_ong;
  int failure = 0;

  i = 0;

  while (i < 10) {
    #ifdef RUN
    apl = rand();
    #else
    apl = i + 1;
    #endif
    my_ong = (float)apl;
    
    write_uint32("apples", apl);
    #ifdef RUN
    fprintf(stderr, "\n(%d) sent an apple: %d.", i, apl);
    #endif
    
    ong = read_float32("oranges");
    #ifdef RUN
    fprintf(stderr, "\ngot an orange: %f.", ong);
    #endif
    
    failure |= (my_ong != ong);
    ++i;
  }

  #ifdef RUN
  if (failure == 0)
    fprintf(stderr, "\nAll conversions successful.\n");
  else
    fprintf(stderr, "\nSome conversion(s) failed.\n");
  #endif
    
  return failure;
}
