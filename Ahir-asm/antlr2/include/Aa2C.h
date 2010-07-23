#ifndef _AA_2_C__
#define _AA_2_C_

#include <stdint.h>

// all types from uint1 to uint8 will
// be implemented by uint8_t
// all types from uint9 to uint 16 will
// be implemented by uint16_t etc.
typedef uint8_t uint_8;
typedef uint16_t uint_16;
typedef uint32_t uint_32;
typedef uint64_t uint_64;

typedef int8_t int_8;
typedef int16_t int_16;
typedef int32_t int_32;
typedef int64_t int_64;

// only two floating point types will
// be supported for now...
typedef float float_8_23;
typedef double float_11_52;

#endif
