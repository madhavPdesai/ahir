#include <stdint.h>
#include <stdio.h>
#include <aa_c_model.h>
#include <pthreadUtils.h>


// the main program which calls the shift register
int main(int argc, char* argv[])
{
	uint32_t rv; 
	__init_aa_globals__();
	Test(&rv);
	fprintf(stderr,"%x\n", rv);
	return(1);
}
