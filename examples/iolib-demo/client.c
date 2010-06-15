#include "../../iolib/iolib.h"

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

  for (i = 0; i < 10; ++i) {
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

    apl = apl << 1;
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
  }

  #ifdef RUN
  if (failure == 0)
    fprintf(stderr, "\nAll conversions successful.\n");
  else
    fprintf(stderr, "\nSome conversion(s) failed.\n");
  #endif
    
  return failure;
}
