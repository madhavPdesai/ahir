#include <uarith32.h>

uint32_t umul32_t (uint32_t A, uint32_t B)
{
	uint64_t A64 = A;
	uint64_t B64 = B;
	return(A*B);
}
