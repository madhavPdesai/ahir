#ifdef RUN
#include <stdio.h>
#endif

float x, y;

float add(float a, float b)
{
  return a + b;
}

float start(void)
{
  x = 3.14159;
  y = -4.2;

  return add(x, y);
}

#ifdef RUN
int main (void)
{
  printf("%f\n", start());
}
#endif
