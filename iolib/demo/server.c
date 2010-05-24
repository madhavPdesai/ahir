#include "../iolib.h"
#include <stdio.h>

int main (void)
{
  int i;
  uint32_t apl;
  float ong;
  
  for (i = 0; i < 10; ++i) {
    apl = read_uint32("apples");
    fprintf(stderr, "\n(%d) got an apple: %d.", i, apl);
    ong = (float)apl;
    write_float32("oranges", ong);
    fprintf(stderr, "\nsent an orange: %f.", ong);
  }

  fprintf(stderr, "\n");
  return 0;
}
