#include <stdlib.h>
int g[10];

void cpy(int* a)
{
	*(a+1) = *a;
}

int main(int a)
{
	cpy(&(g[0]));
	return(g[1]);
}

