#include <stdio.h>
#include <aa_c_model.h>
int main(int argc, char* argv[])
{
	int a,b;
	pointer pa,pb;

	a = 5;
	pa.__val = (void*) (&a);

	passpointer(pa,&pb);

	b = *((int*) (pb.__val));

	printf("%d\n",b);
	return(1);
}


int Increment(pointer pa, pointer* pb)
{
   if(pb->__val == NULL)
	pb->__val = (int*) calloc(1,sizeof(int));

   *((int*)(pb->__val)) = *((int*)(pa.__val)) + 1;
   return(0);
}
