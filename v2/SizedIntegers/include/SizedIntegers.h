#ifndef __SizedIntegers_h__
#define __SizedIntegers_h__

#include <stdlib.h>
#include <stdint.h>
#include <AaEnums.h>


typedef struct sized_u8_array_
{
 	uint8_t* byte_array;
	uint32_t array_size; 
} sized_u8_array;

void allocate_sized_u8_array(sized_u8_array* a, uint32_t sz)
{
   byte_array = calloc(1, sz*sizeof(uint8_t));
}
void free_sized_u8_array(sized_u8_array* a)
{
	cfree a->byte_array;
}
typedef struct _sized_uint_ { 
	// little endian uinteger representation.
	// val[0] is the least-significant byte.
	sized_u8_array val;
	uint32_t   width;
} sized_uint;

typedef struct _sized_int_ { 
	// little endian integer representation.
	sized_u8_array val;
	uint32_t   width;
} sized_int;


void init_sized_uint(sized_uint* t, uint32_t width);
void init_sized_int(sized_int* t,   uint32_t width);

void free_sized_uint(sized_uint* t);
void free_sized_int(sized_int* t);


//
// upper overflow bits are thrown away.
// OR
// zero-extend upper bits.
//
uint8_t  byte_array_to_uint8(sized_u8_array* t);
uint16_t byte_array_to_uint16(sized_u8_array* t);
uint32_t byte_array_to_uint32(sized_u8_array* t);
uint64_t byte_array_to_uint64(sized_u8_array* t);


void __sized_or(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_nor(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_and(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_nand(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_xor(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_xnor(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);

void __sized_plus(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, sized_u8_array* signed_flag, uint32_t width);
void __sized_minus(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, sized_u8_array* signed_flag, uint32_t width);
void __sized_mul(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, sized_u8_array* signed_flag, uint32_t width);
void __sized_div(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, sized_u8_array* signed_flag, uint32_t width);

void __sized_bitsel(sized_u8_array** f,sized_u8_array** s,sized_u8_array** result,sized_u8_array* width);
void __sized_concatenate(sized_u8_array** f, uint32_t f_width, sized_u8_array** s, uint32_t s_width, sized_u8_array** result);
void __sized_slice(sized_u8_array** src, sized_u8_array** dest, uint32_t low_index, uint32_t src_width, uint32_t dest_width);

float  __sized_to_float(sized_u8_array* signed_flag, sized_u8_array** f, uint32_t width);
double __sized_to_double(sized_u8_array* signed_flag, sized_u8_array** f, uint32_t width);

void __sized_shift_right(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, sized_u8_array* signed_flag, uint32_t width);
void __sized_shift_left(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_rotate_left(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);
void __sized_rotate_right(sized_u8_array** r, sized_u8_array** s, sized_u8_array** t, uint32_t width);

#endif;
