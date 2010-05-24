#include "library.h"

int start(void)
{
  unsigned data = read("input");
  write("output", data);

  return 0;
}

