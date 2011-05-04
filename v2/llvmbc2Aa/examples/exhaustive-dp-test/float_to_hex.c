#include <stdio.h>
int main()
{
	float x;
        scanf("%f",&x);	
	void* p = (void*) &x;
	unsigned int result = *((int*)p);
	printf("%x\n",result);
	printf("%x\n",(int)x);
	printf("%x\n",(unsigned int)x);

}
