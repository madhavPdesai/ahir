#ifdef RUN
#include <stdio.h>
#endif

unsigned short a = 42;
unsigned short b = 7;
unsigned short d;

unsigned short alu(unsigned short opcode)
{
  unsigned short r;

  switch (opcode) {
    case 1:
      r = a + b;
      break;
    case 2:
      r = a - b;
      break;
    case 3:
      r = a * b;
      break;
    case 4:
      r = a ^ b;
      break;
    default:
      r = a & b;
      break;
  }

  d = r;
  return r;
}

unsigned short start()
{
  return alu(3);
}

#ifdef RUN
int main(void)
{
  printf("%d\n", start());
  return 0;
}
#endif
