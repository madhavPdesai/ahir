#ifdef RUN
#include <stdio.h>
#endif

unsigned R1;
unsigned R2;
unsigned R3;

#define R1TAP 0x00000001
#define R2TAP 0x00001000
#define R3TAP 0x01000000

unsigned lfsr()
{
  unsigned R1bit = (R1 & R1TAP);
  unsigned R2bit = (R2 & R2TAP) >> 12;
  unsigned R3bit = (R3 & R3TAP) >> 24;

  unsigned tempR1 = R1;
  unsigned tempR2 = R2;
  unsigned tempR3 = R3;

  unsigned out = R1bit ^ R2bit ^ R3bit;
  
  unsigned TR1 = (tempR1 << 1) | out;
  unsigned TR2 = (tempR2 << 1) | out;
  unsigned TR3 = (tempR3 << 1) | out;
  
  R3 = (R1bit & R2bit & ~R3bit) ? TR3 : tempR3;

  R1 = (R2bit & R3bit & ~R1bit) ? TR1 : tempR1;

  R2 = (R3bit & R1bit & ~R2bit) ? TR2 : tempR2;

  return R1 ^ R2 ^ R3;
}

unsigned start(void)
{
  R1 = 446393;
  R2 = 2555905;
  R3 = 6399158;

  return lfsr();
}

#ifdef RUN
int main(void)
{
  printf("%d\n", start());
}
#endif
