#include <stdio.h>
int main()
{
	int a, c;
	float b;

        scanf("%x",&a);	
        scanf("%f",&b);	
        scanf("%x",&c);	

	unsigned int g = *((int*)(&b));

	printf("%x\n", a ^ (int)b ^ c);
	printf("%x\n", a ^ g ^ c);
}
