#include <stdlib.h>


int sub_slave(int a, int b)
{
	return(a-b);
}

int sub(int a, int b)
{
	int t[2];
	t[0] = a;
	t[1] = b;
	return(sub_slave(t[0],t[1]));
}

int main(int argc, char* argv[])
{
	int a = atoi(argv[1]);
	int b = atoi(argv[2]);
	int c;
	int d;
	c = a - b;
	d = a*b;
	if(a < b)
	{
		c = -c;
		d = 1/d;
	}
	c = c+d;
	return(c);
}
