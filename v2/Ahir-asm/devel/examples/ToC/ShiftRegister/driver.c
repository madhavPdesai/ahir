#include <stdio.h>
#include <aa_c_model.h>


// the main program which calls the shift register
int main(int argc, char* argv[])
{
	uint16_t a,b,c;
	a = 5;
	shiftregister(a,&b);

	return(1);
}


// two foreign functions used by
// the shift-register
int Print(uint16_t a)
{
   printf("out: %d \n", a);
   return(0);
}

int Read(uint16_t *a)
{
  static count=0;
  a = count;
  printf("in: %d \n", a);
  count++;	

  if(count == 1025)
	// EXIT if you have sent in enough stuff.
	exit(0); 
  return(0);
}
