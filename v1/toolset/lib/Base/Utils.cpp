#include "Utils.hpp"

#include <sstream>
#include <assert.h>

std::string hls::create_bitstring(unsigned value, unsigned size)
{
  assert(size <= sizeof(unsigned));

  std::ostringstream buf;

  unsigned mask = 1 << size;
  while (size > 0) {
    buf << (value & mask ? '1' : '0');
    mask >>= 1;
  }
}

