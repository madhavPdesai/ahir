#ifndef __BitVectors_h__
#define __BitVectors_h__

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>


typedef struct sized_u8_array_
{
 	uint8_t* byte_array;
	uint32_t array_size; 
} sized_u8_array;

void allocate_sized_u8_array(sized_u8_array* a, uint32_t sz);
void free_sized_u8_array(sized_u8_array* a);

uint64_t truncate_uint64(uint64_t val, uint32_t bit_width);

#define __min(x,y) (((x) < (y)) ? (x) : (y))
#define __max(x,y) (((x) > (y)) ? (x) : (y))

typedef struct _bit_vector_ { 
	// little endian uinteger representation.
	// val[0] is the least-significant byte.
	sized_u8_array val;
	uint32_t   width;
} bit_vector;


#define __declare_bit_vector(x,w) bit_vector x; init_bit_vector(&x,w);
#define __declare_bit_vector(x,w)  bit_vector x; init_bit_vector(&x,w);
uint32_t  __array_size(bit_vector* x);
void      __set_byte(bit_vector* x, uint32_t byte_index, uint8_t v);
uint8_t   __get_byte(bit_vector* x, uint32_t byte_index);
uint8_t   __sign_bit(bit_vector* x);

void init_bit_vector(bit_vector* t, uint32_t width);
void free_bit_vector(bit_vector* t);
void print_bit_vector(bit_vector* t, FILE* ofile);



// ---------------         initialization, int conversions ------------------------
//  note: we will provide conversions only to uint64.  Conversions to
//        other types can be taken care of by C.
//
uint64_t  bit_vector_to_uint64(uint8_t signed_flag, bit_vector* t);

//
// convert to bit-vector.. 
//
void uint64_to_bit_vector(uint8_t signed_flag, uint64_t v, bit_vector* t);


// ------            assignments  -------------------------------------
void bit_vector_assign_bit_vector(bit_vector* src, bit_vector* dest);
void bit_vector_assign_uint64(uint8_t signed_flag, bit_vector* s, uint64_t u);
void bit_vector_clear(bit_vector* s); // clear all bits.
void bit_vector_set(bit_vector* s);   // set all bits to 1.


//  --------------  bitwise operations -----------------------------------
void bit_vector_or(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_nor(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_and(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_nand(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_xor(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_xnor(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_not(bit_vector* src, bit_vector* dest);

// ---------------  2s complement arithmetic operations -------------------
void bit_vector_increment(bit_vector* s);      
void bit_vector_plus(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_minus(bit_vector* r, bit_vector* s, bit_vector* t);
// ----------- this have a width limit of 64. ----------------------------
//             (need to relax this.... later!)
void bit_vector_mul(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_div(bit_vector* r, bit_vector* s, bit_vector* t);


// ---------------------- bit manipulation --------------------------------------
//  most of these are quite inefficiently implemented as of now.
void bit_vector_set_bit(bit_vector* f, uint32_t bit_index, uint8_t bit_value);
uint8_t bit_vector_get_bit(bit_vector* f, uint32_t bit_index);

void  bit_vector_bitsel(bit_vector* f,bit_vector* s,bit_vector* result);
void  bit_vector_concatenate(bit_vector* f, bit_vector* s,  bit_vector* result);
void  bit_vector_slice(bit_vector* src, bit_vector* dest, uint32_t low_index);
void  bit_vector_insert(bit_vector* src, bit_vector* dest, uint32_t low_index);

//
// shifts and rotates.. note that shift_right uses signed_flag for differentiating
// between logical and arithmetic shifts.
//
void bit_vector_shift_right(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_shift_left(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_rotate_left(bit_vector* r,  bit_vector* s, bit_vector* t);
void bit_vector_rotate_right(bit_vector* r,  bit_vector* s, bit_vector* t);

// --------------------    comparisons -------------------------------------
// returns 0 if equal, 1 if r > s, 2 if r < s.
#define IS_EQUAL        0
#define IS_GREATER      1
#define IS_LESS         2
uint8_t uint64_compare(uint8_t signed_flag, uint64_t a, uint64_t b, uint64_t width);
uint8_t bit_vector_compare(uint8_t signed_flag, bit_vector* r, bit_vector* s);
void bit_vector_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_less(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_less_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_greater(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_greater_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);

#endif
