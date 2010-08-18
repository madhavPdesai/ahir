#include <stdio.h>
#include <aa_c_model.h>


// the main program which calls the shift register
int main(int argc, char* argv[])
{
	uint_10 a,b,c;

	a.__val = 5;
	shiftregister(a,&b);

	return(1);
}


// two foreign functions used by
// the shift-register
int Print(uint_10 a)
{
   printf("out: %d \n", a.__val);
   return(0);
}

int Read(uint_10 *a)
{
  static count=0;
  a->__val = count;
  printf("in: %d \n", a->__val);
  count++;	

  if(count == 1025)
	// EXIT if you have sent in enough stuff.
	exit(0); 
  return(0);
}
