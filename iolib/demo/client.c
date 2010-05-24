#include "../iolib.h"
#include <stdlib.h>
#include <stdio.h>

int main (void)
{
  uint32_t i, apl;
  float ong, my_ong;
  int failure = 0;

  i = 0;

  while (i < 10) {
    apl = rand();
    my_ong = (float)apl;
    write_uint32("apples", apl);
    fprintf(stderr, "\n(%d) sent an apple: %d.", i, apl);
    ong = read_float32("oranges");
    fprintf(stderr, "\ngot an orange: %f.", ong);
    failure |= (my_ong != ong);
    ++i;
  }

  if (failure == 0)
    fprintf(stderr, "\nAll conversions successful.\n");
  else
    fprintf(stderr, "\nSome conversion(s) failed.\n");
    
  return 0;
}
