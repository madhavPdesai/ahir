#include <stdio.h>
#include <stdint.h>

#ifdef SW
#include "prog.h"
#else
#include "vhdlCStubs.h"
#endif

int main()
{
	uint64_t a  = checkMux(0,0);
	uint64_t b  = checkMux(0,1);
	uint64_t c  = checkMux(1,0);
	uint64_t d  = checkMux(1,1);
	printf("%llu\n",a);
	printf("%llu\n",b);
	printf("%llu\n",c);
	printf("%llu\n",d);

	return 0;
}
