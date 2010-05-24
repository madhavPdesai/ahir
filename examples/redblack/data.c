#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (void)
{
    int key, ks;
    int data, ds;
    int i;
    
    srand(time(NULL));

    for (i = 0; i < 1000; ++i) {
	key = rand();
	ks = rand() % 2;
	if (ks)
	    key = -key;

	data = rand();
	ds = rand() % 2;
	if (ds)
	    data = -data;
	printf("\n{%d,%d},", key, data);
    }

    printf("\n");
    return 0;
}
