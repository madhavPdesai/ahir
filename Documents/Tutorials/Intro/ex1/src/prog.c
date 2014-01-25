#include <stdint.h> // for uint32_t

uint32_t maxOfTwo(uint32_t a, uint32_t b)
{
  uint32_t c = ((a > b) ? a : b);
  return(c);
}
