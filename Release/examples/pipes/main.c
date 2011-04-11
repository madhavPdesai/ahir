#include <stdlib.h>
#include <stdint.h>

float read_float32(const char *id);
uint32_t read_uint32(const char *id);

void write_float32(const char *id, float data);
void write_uint32(const char *id, uint32_t data);


// To get a "software" model, you will need to
// create two executables which will use the
// named pipes to communicate.
//
// gcc -DFOO -o foo main.c 
//    will produce foo.
//
// gcc -DBAR -o bar main.c 
//    will produce bar
//
// run foo and bar as two distinct processes
// they will exchange information and terminate.
//
// To get the hardware module compile without
// defining FOO, BAR.  This will generate
// two VHDL modules, which communicate through
// the pipes.
#ifdef FOO
int main()
{
	return(foo(10));
}
#endif 

#ifdef BAR
int main()
{
	return(bar());
}
#endif

int foo(int a)
{
	
	int b;

	write_uint32("pipe1",a);
	b = read_uint32("pipe2");

	return(b);
}

int bar()
{
	int b;

	b = read_uint32("pipe1");
	write_uint32("pipe2",b);

	return(1);
}

