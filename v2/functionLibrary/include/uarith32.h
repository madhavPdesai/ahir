#ifndef _uarith32_h__
#define _uarith32_h__

#include <stdint.h>

uint64_t umul32(uint32_t, uint32_t);
// 
// These two cannot be called from C.
//uint32_t ushift32(uint32_t, uint32_t);
//uint32_t uaddsub32(uint32_t, uint32_t);

#endif
