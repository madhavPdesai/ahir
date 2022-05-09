//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
#ifndef __BitVectors_h__
#define __BitVectors_h__

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>


void __trace(int print_flag, const char* trace_string, int trace_index);

typedef struct sized_u8_array_
{
 	uint8_t* byte_array;

	// if set, the corresponding bit is not 
	// defined.. (like an X).
 	uint8_t* undefined_byte_array;

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


#define __declare_bit_vector(x,w) bit_vector x =  {.width = 0}; init_bit_vector(&x,w);
#define __declare_static_bit_vector(x,w) static bit_vector x = {.width = 0}; init_static_bit_vector(&x,w);
#define __allocate_bit_vector(x,w) {x = (bit_vector*) calloc(1, sizeof(bit_vector)); init_bit_vector( x , w);}

uint32_t  __array_size(bit_vector* x);
void      __set_byte(bit_vector* x, uint32_t byte_index, uint8_t v);
uint8_t   __get_byte(bit_vector* x, uint32_t byte_index);
void      __set_undefined_byte(bit_vector* x, uint32_t byte_index, uint8_t v);
uint8_t   __get_undefined_byte(bit_vector* x, uint32_t byte_index);
uint8_t   __sign_bit(bit_vector* x);

void init_bit_vector(bit_vector* t, uint32_t width);
void init_static_bit_vector(bit_vector* t, uint32_t width);
void free_bit_vector(bit_vector* t);
void print_bit_vector(bit_vector* t, FILE* ofile);
void printf_bit_vector(bit_vector* t);
char* to_string(bit_vector* t);
char* to_hex_string(bit_vector* t);

uint8_t is_undefined_bit(bit_vector* t, uint32_t index);
uint8_t has_undefined_bit(bit_vector* t);

// ---------------         test functions   ------------------------

// return true if all bits are cleared.
uint8_t bit_vector_is_zero(bit_vector* t);


// ---------------         initialization, int conversions ------------------------
//  note: we will provide conversions only to uint64.  Conversions to
//        other types can be taken care of by C.
//
void      bit_vector_clear_unused_bits(bit_vector* t);
uint64_t  bit_vector_to_uint64(uint8_t signed_flag, bit_vector* t);
float     bit_vector_to_float(uint8_t signed_flag, bit_vector* t);
double    bit_vector_to_double(uint8_t signed_flag, bit_vector* t);


// very useful.. keep it around.
void bit_vector_assign_uint64(uint8_t signed_flag, bit_vector* dest, uint64_t src);
void bit_vector_assign_float(uint8_t signed_flag, bit_vector* dest, float src);
void bit_vector_assign_double(uint8_t signed_flag, bit_vector* dest, double src);
void bit_vector_assign_string(bit_vector* dest, char* init_string);


// ------          standard  casts, bitcasts  ------------------------------------- //
void bit_vector_cast_to_bit_vector(uint8_t signed_flag, bit_vector* dest, bit_vector* src);
void bit_vector_bitcast_to_bit_vector(bit_vector* dest, bit_vector* src);


void bit_vector_cast_to_uint64(uint8_t signed_flag, uint64_t* dest, bit_vector* src);
void bit_vector_bitcast_to_uint64( uint64_t* dest, bit_vector* src);
void uint64_cast_to_bit_vector(uint8_t signed_flag, bit_vector* dest, uint64_t* src);
void uint64_bitcast_to_bit_vector( bit_vector* dest, uint64_t* src);


void bit_vector_cast_to_float(uint8_t signed_flag, float* dest, bit_vector* src);
void bit_vector_bitcast_to_float(float* dest, bit_vector* src);
void float_cast_to_bit_vector(uint8_t signed_flag, bit_vector* dest, float* f);
void float_bitcast_to_bit_vector(bit_vector* s, float* f);

void bit_vector_cast_to_double(uint8_t signed_flag, double* dest, bit_vector* src);
void bit_vector_bitcast_to_double(double* dest, bit_vector* src);
void double_cast_to_bit_vector(uint8_t signed_flag, bit_vector* dest, double* f);
void double_bitcast_to_bit_vector(bit_vector* s, double* f);


// clear and set.
void bit_vector_clear(bit_vector* s); // clear all bits.
void bit_vector_set(bit_vector* s);   // set all bits to 1.

// mark as undefined, etc.
void bit_vector_set_undefined(bit_vector* s);     // set all undefined bits to 1.
void bit_vector_clear_undefined(bit_vector* s);   // clear all undefined bits to 0.


//  --------------  bitwise operations -----------------------------------
// (r op s) = t.
void bit_vector_or(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_nor(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_and(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_nand(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_xor(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_xnor(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_not(bit_vector* src, bit_vector* dest);

void bit_vector_reduce_or(bit_vector* src, bit_vector* dest);
void bit_vector_reduce_and(bit_vector* src, bit_vector* dest);
void bit_vector_reduce_xor(bit_vector* src, bit_vector* dest);

void bit_vector_decode(bit_vector* src, bit_vector* dest);
void bit_vector_encode(bit_vector* src, bit_vector* dest);
void bit_vector_priority_encode(bit_vector* src, bit_vector* dest);




// ---------------  2s complement arithmetic operations -------------------
void bit_vector_increment(bit_vector* s);      
void bit_vector_plus(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_minus(bit_vector* r, bit_vector* s, bit_vector* t);
// ----------- this have a width limit of 64. ----------------------------
//             (need to relax this.... later!)
void bit_vector_mul(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_div(bit_vector* r, bit_vector* s, bit_vector* t);

void bit_vector_smul(bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_sdiv(bit_vector* r, bit_vector* s, bit_vector* t);


// ---------------------- bit manipulation --------------------------------------
//  most of these are quite inefficiently implemented as of now.
void bit_vector_set_bit(bit_vector* f, uint32_t bit_index, uint8_t bit_value);
void bit_vector_set_undefined_bit(bit_vector* f, uint32_t bit_index, uint8_t bit_value);

uint8_t bit_vector_get_bit(bit_vector* f, uint32_t bit_index);
uint8_t bit_vector_get_undefined_bit(bit_vector* f, uint32_t bit_index);

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
#define IS_UNDEFINED    3  // comparison between undef numbers.

uint8_t uint64_compare(uint8_t signed_flag, uint64_t a, uint64_t b, uint64_t width);
uint8_t bit_vector_compare(uint8_t signed_flag, bit_vector* r, bit_vector* s);
void bit_vector_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_not_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_less(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_less_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_greater(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);
void bit_vector_greater_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t);

// unordered?
uint8_t fp32_unordered(float a, float b);
uint8_t fp64_unordered(double a, double b);


// pipe accesses.
void write_bit_vector_to_pipe(char* pipe_name, bit_vector* bv);
void read_bit_vector_from_pipe(char* pipe_name, bit_vector* bv);
void sock_write_bit_vector_to_pipe(char* pipe_name, bit_vector* bv);
void sock_read_bit_vector_from_pipe(char* pipe_name, bit_vector* bv);

uint64_t get_allocated_byte_count();
#endif
