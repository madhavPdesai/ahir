#include <stdlib.h>

int g[2];

int sub_slave(int a, int b)
{
	return(g[0] +  a-b);
}

int sub(int a, int b)
{
	int t[2];
	t[0] = a;
	t[1] = b;
	g[0] = 1;
	return(sub_slave(t[0],t[1]));
}

int main()
{
  int c = sub(5,2);
  if(c == 4)
	return(1);
  else
	return(0);
}

