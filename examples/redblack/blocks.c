#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (void)
{
    int i;
    
    srand(time(NULL));

    for (i = 0; i < 1000; ++i) {
	printf("\n    <scalar type=\"uint\" size=\"1\">%d</scalar>", 1 + i*6);
    }

    printf("\n");
    return 0;
}
