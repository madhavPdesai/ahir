#include <assert.h>
#include <BitVectors.h>

#define __nbytes(x) ((x % 8 == 0) ? x/8 : (x/8) + 1)
// ---------------  local functions --------------------------------------
uint64_t unpack_bit_vector_into_uint64(uint8_t signed_flag, bit_vector* bv)
{
	uint64_t word = 0;
	uint8_t neg_flag = 0;
	if(signed_flag && __sign_bit(bv)) // negative number.
	{
		neg_flag = 1;
	}

	if(neg_flag) 
		word = -1;	 
	else 
		word = 0;

	uint8_t* word_ptr = (uint8_t*) &word;
        uint32_t asize = __array_size(bv);
	if(asize > 0)
	{
		int i;
		for (i=0; i < 8; i++)
		{
			if(i >= asize)
				break;
			if(neg_flag)
				word_ptr[i] = word_ptr[i] & __get_byte(bv,i);
			else
				word_ptr[i] = word_ptr[i] | __get_byte(bv,i);
		}
	}
	return(word);
}


void  pack_uint64_into_bit_vector(uint8_t signed_flag, uint64_t word, bit_vector* bv)
{
	uint8_t def_byte = 0; 
	uint8_t neg_flag = 0;
	if(signed_flag && (word >> 63))
	{
		neg_flag = 1;
	}
	if (neg_flag) 
		def_byte = 0xff; 
	int i;
	uint8_t* word_ptr = (uint8_t*) &word;
	for (i=0; i < 8; i++)  // uint64_t
	{
		if(i >= __array_size(bv))
			 break;
		uint8_t nb = word_ptr[i];
		if(neg_flag)
			__set_byte(bv,i,(nb & def_byte));
		else
			__set_byte(bv,i,(nb | def_byte));
	}
}


uint64_t truncate_uint64(uint64_t val, uint32_t bit_width)
{
	uint64_t trunc_mask = ~0;
	if(bit_width < 64)
		trunc_mask = ((((uint64_t) 0x1) << bit_width)-1);

	uint64_t ret_val = val & trunc_mask;
	return(ret_val);
}

void allocate_sized_u8_array(sized_u8_array* a, uint32_t sz)
{
	a->byte_array = calloc(1, sz*sizeof(uint8_t));
	a->array_size = sz;

}
void free_sized_u8_array(sized_u8_array* a)
{
	cfree (a->byte_array);
}


void init_bit_vector(bit_vector* t, uint32_t width)
{
	allocate_sized_u8_array(&(t->val), __nbytes(width));;
	t->width = width;
}


void free_bit_vector(bit_vector* t)
{
	free_sized_u8_array(&(t->val));
}

void print_bit_vector(bit_vector* t, FILE* ofile)
{
	int I;
	for(I=t->width-1; I>=0; I--)
	{
		fprintf(ofile,"%u", bit_vector_get_bit(t,I));
	}
}

void printf_bit_vector(bit_vector* t)
{
	print_bit_vector(t,stderr);
}

char to_string_buffer[4096];
char* to_string(bit_vector* t)
{
	int QUAD = 4;
	int I;

	sprintf(to_string_buffer,"");

	for(I=t->width-1; I>=0; I--)
	{
		char buf[16];
		QUAD--;
		if(QUAD == 0)
		{
			sprintf(buf," ");
			QUAD = 4;
		}
		
		sprintf(buf,"%u", bit_vector_get_bit(t,I));
		strcat(to_string_buffer, buf);
	}
	return(to_string_buffer);
}

// -----------------   utility functions.
uint32_t  __array_size(bit_vector* x)
{
	return(x->val.array_size);
} 
void      __set_byte(bit_vector* x, uint32_t byte_index, uint8_t v)
{
	if(byte_index < __array_size(x))
		x->val.byte_array[byte_index] = v;
}

uint8_t   __get_byte(bit_vector* x, uint32_t byte_index)
{
	if(byte_index < __array_size(x))
		return(x->val.byte_array[byte_index]);
	else
		return(0);
}

uint8_t   __sign_bit(bit_vector* x) 
{
	//
	// the location of the  most-significant byte.
	//
	uint32_t byte_position = (x->width-1)/8;


	//
	// position of the sign-bit in the
	// MSByte.
	//
	uint32_t offset = (x->width - 1) % 8;
	uint8_t bit_pos_mask = (0x1 << offset);

	// check the bit.
	if(__get_byte(x,byte_position) & bit_pos_mask)
		return(1);
	else
		return(0);
}
// ----------------   initialization, conversions to C types.  --------------------
uint64_t  bit_vector_to_uint64(uint8_t signed_flag, bit_vector* t)
{
	uint64_t rv = 0;
	rv = unpack_bit_vector_into_uint64(signed_flag,t);


	// truncate high order bits if non-negative.
	if(!signed_flag || __sign_bit(t))
	{
		rv = truncate_uint64(rv, t->width);
	}

	return(rv);
}

float     bit_vector_to_float(uint8_t signed_flag, bit_vector* t)
{
  float rv = 0;
  if(signed_flag)
    {
      int64_t v = bit_vector_to_uint64(signed_flag, t);
      rv =  v;
    }
  else
    {
      uint64_t v = bit_vector_to_uint64(signed_flag, t);
      rv =  v;
    }
}

double    bit_vector_to_double(uint8_t signed_flag, bit_vector* t)
{
  double rv = 0;
  if(signed_flag)
    {
      int64_t v = bit_vector_to_uint64(signed_flag, t);
      rv =  v;
    }
  else
    {
      uint64_t v = bit_vector_to_uint64(signed_flag, t);
      rv =  v;
    }
}


// ----------                assignments -----------------------------
void bit_vector_assign_bit_vector(uint8_t signed_flag, bit_vector* src, bit_vector* dest)
{
	uint32_t min_width = __min(src->width,dest->width);
	uint32_t J;
	uint8_t neg_flag = 0;

	bit_vector_clear(dest);

	for(J=0; J < min_width; J++)
	{
	  uint8_t tb = bit_vector_get_bit(src,J);
	  bit_vector_set_bit(dest,J, tb);
	}

	if(signed_flag && __sign_bit(src))
	  {
	    // sign-extend in dest.
	    int I;
	    for(I = src->width; I <= dest->width; I++)
	      {
		bit_vector_set_bit(dest, I, 1);
	      }
	  }
}

void bit_vector_assign_uint64(uint8_t signed_flag, bit_vector* s, uint64_t u)
{
	pack_uint64_into_bit_vector(signed_flag, u, s);
}
// type conversion as in C
void bit_vector_assign_float(uint8_t signed_flag, bit_vector* s, float f)
{
  if(signed_flag)
    {
      int64_t v = f;
      pack_uint64_into_bit_vector(signed_flag, v, s);
    }
  else
    {
      uint64_t v = f;
      pack_uint64_into_bit_vector(signed_flag, v, s);
    }
}
void bit_vector_assign_double(uint8_t signed_flag, bit_vector* s, double d)
{
 if(signed_flag)
    {
      int64_t v = d;
      pack_uint64_into_bit_vector(signed_flag, v, s);
    }
  else
    {
      uint64_t v = d;
      pack_uint64_into_bit_vector(signed_flag, v,s );
    }
}



void bit_vector_clear(bit_vector* s)
{
	uint32_t asize = __array_size(s);
	uint32_t i;
	for(i = 0; i < asize; i++)
		__set_byte(s,i,0);
}

void bit_vector_set(bit_vector* s)
{
	uint32_t asize = __array_size(s);
	uint32_t i;
	for(i = 0; i < asize; i++)
		__set_byte(s,i,0xff);
}

// ------------------            bit-wise operations
void bit_vector_or(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == s->width); assert(s->width == t->width);
	int i;
	uint32_t asize = __array_size(r);
	for(i = 0; i < asize; i++)
		__set_byte(t,i, (__get_byte(r,i) | __get_byte(s,i)));
}

void bit_vector_nor(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == s->width); assert(s->width == t->width);
	int i;
	uint32_t asize = __array_size(r);
	for(i = 0; i < asize; i++)
		__set_byte(t,i, (~(__get_byte(r,i) | __get_byte(s,i))));
}
void bit_vector_and(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == s->width); assert(s->width == t->width);
	int i;
	uint32_t asize = __array_size(r);
	for(i = 0; i < asize; i++)
		__set_byte(t,i, (__get_byte(r,i) & __get_byte(s,i)));
}
void bit_vector_nand(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == s->width); assert(s->width == t->width);
	int i;
	uint32_t asize = __array_size(r);
	for(i = 0; i < asize; i++)
		__set_byte(t,i, (~(__get_byte(r,i) & __get_byte(s,i))));
}
void bit_vector_xor(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == s->width); assert(s->width == t->width);
	int i;
	uint32_t asize = __array_size(r);
	for(i = 0; i < asize; i++)
		__set_byte(t,i, (__get_byte(r,i) ^ __get_byte(s,i)));
}
void bit_vector_xnor(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == s->width); assert(s->width == t->width);
	int i;
	uint32_t asize = __array_size(r);
	for(i = 0; i < asize; i++)
		__set_byte(t,i, (~(__get_byte(r,i) ^ __get_byte(s,i))));
}

void  bit_vector_not(bit_vector* src, bit_vector* dest)
{
	assert(__array_size(src) == __array_size(dest));
	uint32_t J;
	uint32_t nbytes = __array_size(src);
	for(J=0; J < nbytes; J++)
	{
		__set_byte(dest,J,~(__get_byte(src,J)));
	}
}


// -----------------------------------  arithmetic ---------------------
// ++
void bit_vector_increment(bit_vector* s)
{
	uint16_t curr_carry = 1;
	int i;
	for(i = 0; i < __array_size(s); i++)
	{
		uint16_t op =  __get_byte(s,i);
		uint16_t result = op + curr_carry;
		if(result & 0xff00)
			curr_carry = 1;
		else
			curr_carry = 0;
		__set_byte(s,i,result);
	}
}

void bit_vector_plus(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(__array_size(r) == __array_size(s));
	assert(__array_size(t) == __array_size(s));
	uint32_t asize = __array_size(r);
	uint16_t curr_carry = 0;
	
	int i;
	for(i = 0; i < asize; i++)
	{
		uint16_t op1 =  __get_byte(r,i);
		uint16_t op2 =  __get_byte(s,i);
		uint16_t result = (op1 + op2) + curr_carry;
		if(result & 0xff00)
			curr_carry = 1;
		else
			curr_carry = 0;

		__set_byte(t,i,(result & 0xff));
	}
}

void bit_vector_minus(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(__array_size(r) == __array_size(s));
	assert(__array_size(t) == __array_size(s));
	bit_vector_not(s,t);
	bit_vector_plus(r,t,t);
	bit_vector_increment(t);
}

// support this only for widths up to 64.
void bit_vector_mul(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(__array_size(r) == __array_size(s));
	assert(__array_size(t) == __array_size(s));

	uint64_t op1,op2;
	op1 = bit_vector_to_uint64(0,r);
	op2 = bit_vector_to_uint64(0,s);

	uint64_t result = op1*op2;
	bit_vector_assign_uint64(0,t,result);
}

//
// support this only for widths up to 64..
//
void bit_vector_div(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(__array_size(r) == __array_size(s));
	assert(__array_size(t) == __array_size(s));

	uint64_t op1,op2;
	op1 = bit_vector_to_uint64(0,r);
	op2 = bit_vector_to_uint64(0,s);


	uint64_t result = 0;
	if(op2 != 0)
		result = op1/op2;
	else
	{
		fprintf(stderr,"Error: divide by 0... %lld/%lld for bit-width %d.\n", op1,op2,r->width);
	}

	pack_uint64_into_bit_vector(0,result,t);
}

void bit_vector_set_bit(bit_vector* f, uint32_t bp, uint8_t bv)
{
	if (bp < f->width)
	{
		uint64_t byte_id = bp/8;
		uint64_t byte_mask = (bv ? (((uint64_t) 0x1) <<  (bp%8)) : ~(((uint64_t) 0x1) << (bp%8)));
		if(bv)
			__set_byte(f,byte_id, (__get_byte(f,byte_id) | byte_mask));
		else
			__set_byte(f,byte_id, (__get_byte(f,byte_id) & byte_mask));
	}
}
uint8_t bit_vector_get_bit(bit_vector* f, uint32_t bp)
{
	uint8_t ret_val = 0;
	if (bp < f->width)
	{
		uint64_t byte_id = bp/8;
		uint64_t byte_mask = (((uint64_t) 0x1) <<  (bp%8));
		if(__get_byte(f,byte_id) & byte_mask)
			ret_val = 1;
	}
	return(ret_val);
}

void bit_vector_bitsel(bit_vector* f,bit_vector* s,bit_vector* result)
{
	uint64_t sv;
	sv = bit_vector_to_uint64(0,s);
	bit_vector_assign_uint64(0,result, bit_vector_get_bit(f,sv));
}

// the next two are a bit inefficient..
void bit_vector_concatenate(bit_vector* f, bit_vector* s, bit_vector* result)
{
	assert(result->width == (f->width + s->width));
	int I = 0;
	int J;
	for(J = 0; J < s->width; J++)
	{
		bit_vector_set_bit(result,J,bit_vector_get_bit(s,J));	
	}
	for(J = 0; J < f->width; J++)
	{
		bit_vector_set_bit(result,J + s->width,bit_vector_get_bit(f,J));	
	}
}

// slice src starting from low_index upwards to fill dest.
void bit_vector_slice(bit_vector* src, bit_vector* dest, uint32_t low_index)
{
	// src should have enough width..  
	// src->width-1 >= low_index + dest->width  - 1.
	assert(src->width >= low_index + dest->width);

	int J;
	uint32_t high_index =  low_index + dest->width - 1;
	for(J = low_index; J <= high_index; J++)
	{
		bit_vector_set_bit(dest, J-low_index, bit_vector_get_bit(src,J));
	}
}

// insert src into dest starting at low_index.
void bit_vector_insert(bit_vector* src, bit_vector* dest, uint32_t low_index)
{
	assert(dest->width >= low_index + src->width);

	int J;
	for(J = 0; J < src->width; J++)
	{
		bit_vector_set_bit(dest, J+low_index, bit_vector_get_bit(src,J));
	}
}

// -----------------------   shifts and rotates. -------------------------------
void bit_vector_shift_right(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	// clear it.
	bit_vector_assign_uint64(0,t,0);


	uint8_t sign_val = 0;
	if(signed_flag)
	{
		if(__sign_bit(r))
		{
			sign_val = 1;
			bit_vector_not(t,t);
		}
	}

	uint32_t shift_amount = bit_vector_to_uint64(0,s);
	if(shift_amount < t->width)
	{
		int I;
		for(I=shift_amount; I < t->width; I++)
		{
			bit_vector_set_bit(t,I-shift_amount, bit_vector_get_bit(r,I));
		}
	}

}
void bit_vector_shift_left(bit_vector* r, bit_vector* s, bit_vector* t)
{
	bit_vector_assign_uint64(0,t,0);
	uint32_t shift_amount = bit_vector_to_uint64(0,s);

	if(shift_amount < t->width)
	{
		int I;
		for(I=0; I < (r->width - shift_amount); I++)
		{
			bit_vector_set_bit(t,I+shift_amount, bit_vector_get_bit(r,I));
		}
	}
}
void bit_vector_rotate_left(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == t->width);
	uint32_t rotate_amount = bit_vector_to_uint64(0,s);
	uint32_t word_size = r->width;

	int I;
	for(I=0; I < word_size; I++)
	{
		bit_vector_set_bit(t,((I+rotate_amount)%word_size), bit_vector_get_bit(r,I));
	}
}
void bit_vector_rotate_right(bit_vector* r, bit_vector* s, bit_vector* t)
{
	assert(r->width == t->width);
	uint32_t rotate_amount = bit_vector_to_uint64(0,s);
	uint32_t word_size = r->width;

	int I;
	for(I=rotate_amount; I < (word_size + rotate_amount); I++)
	{
		bit_vector_set_bit(t,((I-rotate_amount)%word_size), bit_vector_get_bit(r,(I%word_size)));
	}
}

// --------------------    comparisons -------------------------------------
// returns 0 if equal, 1 if r > s, 2 if r < s.
uint8_t uint64_compare(uint8_t signed_flag, uint64_t a, uint64_t b, uint64_t width)
{
	if(width > 64)
		width = 64;
	
	// signs.
	uint8_t sa = (signed_flag ? ((a & (((uint64_t) 0x1) << width-1)) != 0) : 0);
	uint8_t sb = (signed_flag ? ((b & (((uint64_t) 0x1) << width-1)) != 0) : 0);

	if(sa && !sb)
		return(IS_LESS);
	else if(!sa && sb)
		return(IS_GREATER);

	// sign-extend.
	// 
	uint64_t sign_extend_mask = (((int64_t ) -1)  << width);
	if(sa)
	{
		a = a | sign_extend_mask;
	}
	if(sb)
	{
		b = b | sign_extend_mask;
	}


	if(a == b)
		return(IS_EQUAL);
	else if(a < b)
	{
		if(sa && sb)
			return(IS_GREATER);
		else
			return(IS_LESS);
	}
	else
	{
		if(sa && sb)
			return(IS_LESS);
		else
			return(IS_GREATER);
	}
}

// returns 0 if equal, 1 if r > s, 2 if r < s.
uint8_t bit_vector_compare(uint8_t signed_flag, bit_vector* r, bit_vector* s)
{
	// raw comparison only between bit-vectors of 
	// equal length.
	assert(r->width == s->width);

	// raw comparison.
	int i;
	uint8_t re = 1;
	uint8_t rg = 0;
	uint8_t rl = 0;

	uint8_t sr = (signed_flag ? __sign_bit(r) : 0);
	uint8_t ss = (signed_flag ? __sign_bit(s) : 0);

	if(sr && !ss)
	{ // r is negative and s is positive
		return(IS_LESS);
	}
	else if(!sr && ss)
	{// r is positive, s is negative.
		return(IS_GREATER);
	}
	
	
	// both signs are the same.
	for(i = r->width-1; i >= 0; i--)
	{
		uint8_t rb = bit_vector_get_bit(r,i); 
		uint8_t sb = bit_vector_get_bit(s,i); 
		if(re && (rb && !sb))
		{
			re = 0;
			rg = 1;
			break;
		}
		else if(re && (!rb && sb))
		{
			re = 0;
			rl = 1;
			break;
		}
	}


	if(sr && ss)
	{ // both negative.. swap rl, rg.
		uint8_t tmp = rg;
		rg = rl;
		rl = rg;
	}

	if(re)
		return(IS_EQUAL);
	else if(rg) 
		return(IS_GREATER);
	else
		return(IS_LESS);
}

void bit_vector_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	uint64_t tval = 0;
	if(bit_vector_compare(signed_flag,r,s) == IS_EQUAL)
		tval = 1;
	bit_vector_assign_uint64(0,t,tval);
		
}
void bit_vector_not_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	uint64_t tval = 1;
	if(bit_vector_compare(signed_flag,r,s) == IS_EQUAL)
		tval = 0;
	bit_vector_assign_uint64(0,t,tval);
}
void bit_vector_less(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	uint64_t tval = 0;
	if(bit_vector_compare(signed_flag,r,s) == IS_LESS)
		tval = 1;
	bit_vector_assign_uint64(0,t,tval);
}
void bit_vector_less_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	uint64_t tval = 0;
	uint8_t cmp_result = bit_vector_compare(signed_flag,r,s);
	if((cmp_result == IS_LESS) || (cmp_result == IS_EQUAL))
		tval = 1;
	bit_vector_assign_uint64(0,t,tval);
}
void bit_vector_greater(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	uint64_t tval = 0;
	if(bit_vector_compare(signed_flag,r,s) == IS_GREATER)
		tval = 1;
	bit_vector_assign_uint64(0,t,tval);
}
void bit_vector_greater_equal(uint8_t signed_flag, bit_vector* r, bit_vector* s, bit_vector* t)
{
	uint64_t tval = 0;
	uint8_t cmp_result = bit_vector_compare(signed_flag,r,s);
	if((cmp_result == IS_GREATER) || (cmp_result == IS_EQUAL))
		tval = 1;
	bit_vector_assign_uint64(0,t,tval);
}


