#include <stdlib.h>
#ifdef RUN
#include <stdio.h>
#endif


float mul(float a, float b)
{
	float tmp = a*b;
	return(tmp);
}


int main()
{
  float c = mul(5.3,2.5);

#ifdef RUN
  printf("%f\n",c);
#endif

  if(c == (5.3*2.5))
	return(1);
  else
	return(0);
}

