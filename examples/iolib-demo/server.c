#include "../../iolib/iolib.h"

#ifdef RUN
#include <stdio.h>

int main(void)

#else
int start(void)
#endif
{
  uint32_t apl;
  float ong;
  
  while (1) {
    apl = read_uint32("apples");
    #ifdef RUN
    fprintf(stderr, "\ngot an apple: %d.", apl);
    #endif
    
    ong = (float)apl;
    write_float32("oranges", ong);
    #ifdef RUN
    fprintf(stderr, "\nsent an orange: %f.", ong);
    #endif
  }

  #ifdef RUN
  fprintf(stderr, "\n");
  #endif
  return 0;
}
