#include "../iolib.h"
#define RUN

#ifdef RUN
#include <stdio.h>
int main(void)
#else
int start(void)
#endif
{
  int i;
  uint32_t apl;
  float ong;
  
  for (i = 0; i < 10; ++i) {
    apl = read_uint32("apples");
    #ifdef RUN
    fprintf(stderr, "\n(%d) got an apple: %d.", i, apl);
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
