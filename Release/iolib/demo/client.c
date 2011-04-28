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
  uint64_t apl64;
  uint32_t i, apl;
  uint16_t apl16;
  uint8_t apl8,my_apl8;
  void *sptr, *rptr;
  double ong64, my_ong64;
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
    my_ong64 = (double)apl;
    apl64  = (uint64_t)apl;
    apl16  = (uint16_t)apl;
    my_apl8  = (uint8_t)apl16;
    
    write_uint64("apples", apl64);
    #ifdef RUN
    fprintf(stderr, "\n(%d.a) sent a 64-bit apple: %d.", i, apl64);
    #endif
    
    ong64 = read_float64("oranges");

    #ifdef RUN
    fprintf(stderr, "\ngot a (double) orange: %le.", ong64);
    #endif

    failure |= (my_ong64 != ong64);

    write_uint32("apples", apl);
    #ifdef RUN
    fprintf(stderr, "\n(%d.b) sent a 32-bit apple: %d.", i, apl);
    #endif

    ong = read_float32("oranges");
    #ifdef RUN
    fprintf(stderr, "\ngot a (float) orange: %f.", ong);
    #endif
    
    failure |= (my_ong != ong);

    write_uint16("apples", apl16);
    #ifdef RUN
    fprintf(stderr, "\n(%d.c) sent a 16-bit apple: %d.", i, apl16);
    #endif

    apl8 = read_uint8("oranges");
    #ifdef RUN
    fprintf(stderr, "\ngot an 8-bit orange: %d.", apl8);
    #endif

    sptr = (void*) &apl;
    write_pointer("apples", sptr);
    #ifdef RUN
    fprintf(stderr, "\n(%d.d) sent a pointer apple: %d.", i, (unsigned int)sptr);
    #endif

    rptr = read_pointer("oranges");
    #ifdef RUN
    fprintf(stderr, "\ngot a pointer orange: %d.",(unsigned int) rptr);
    #endif
    
    failure |= (sptr != rptr);
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
