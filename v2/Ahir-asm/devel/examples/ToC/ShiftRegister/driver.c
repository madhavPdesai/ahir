#include <stdio.h>
#include <aa_c_model.h>
#include <pthreadUtils.h>


// the main program which calls the shift register
int main(int argc, char* argv[])
{
	init_pipe_handler_with_log();

	start_daemons();

	uint8_t done = read_uint8("done_pipe");

	stop_daemons();
	close_pipe_handler();
	return(1);
}


// two foreign functions used by
// the shift-register
void Print(uint16_t a)
{
  static count=0;
   printf("out: %d \n", a);
   count++;

   // stop after 16 have been received.
   if(count == 16)
	write_uint8("done_pipe",1);

   return(0);
}

void Read(uint16_t *a)
{
  static count=1;
  *a = count;
  printf("in: %d \n", *a);
  count++;	

  if(count == 1025)
	// EXIT if you have sent in enough stuff.
	exit(0); 
  return(0);
}
