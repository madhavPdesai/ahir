#include <stdlib.h>


int add_slave(int a, int b)
{
	return(a+b);
}

int add(int a, int b)
{
	return(add_slave(a,b));
}
