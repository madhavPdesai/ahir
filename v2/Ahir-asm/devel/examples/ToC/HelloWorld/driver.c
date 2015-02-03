#include <stdio.h>
#include <aa_c_model.h>


// the main program which calls the shift register
int main(int argc, char* argv[])
{
	uint32_t c;
	__init_aa_globals__();
	sum_mod_wrap(15,15,&c);
	fprintf(stderr,"c = %x\n", c);
	return(1);
}

