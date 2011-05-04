#include <stdlib.h>

int g[2] = {1, 1};
int f[2][2] = {1, 1, 1, 1};

int main()
{
  int b = g[0] + g[1] + f[0][0] + f[1][1];
  return(b);
}

