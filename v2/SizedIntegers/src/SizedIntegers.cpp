#include <assert.h>
#include <SizedIntegers.h>

#define __nbytes(x) ((x % 8 == 0) ? x/8 : (x/8) + 1)

uint8_t* alloc_byte_array(uint32_t width)
{
	uint32_t nbytes = __nbytes(width);
	uint8_t* rv  = (uint8_t*) malloc(nbytes);
	int i;
	for(i = 0; i < nbytes; i++)
	{
		rv[i] = 0;
	}
	return(rv);
}

void init_sized_uint(sized_uint* t, uint32_t width)
{
	t->val = alloc_byte_array(width);
}

void init_sized_int(sized_int* t, uint32_t width)
{
	t->val = alloc_byte_array(width);
}

void free_sized_uint(sized_uint* t)
{
	if(t->val)
	{
	   free(t->val);
	   t->val = NULL;
	}
}
void free_sized_int(sized_int* t)
{
	if(t->val)
	{
	   free(t->val);
	   t->val = NULL;
	}
}

uint8_t  byte_array_to_uint8(uint8_t* t, uint32_t width)
{
	uint8_t rv = 0;
	if(width > 0)
		rv = t[0];
	return(rv);
}
uint16_t byte_array_to_uint16(uint8_t* t, uint32_t width)
{
	uint32_t nbytes = __nbytes(width);
	uint16_t rv = 0;
	int i;
	for(i = 0; i < 2; i++)
	{
		uint16_t cv = t[i];
		rv = rv | (cv << (8*i));
		if((i+1) == nbytes)
			break;
	}
	return(rv);
}
uint32_t byte_array_to_uint32(uint8_t* t, uint32_t width)
{
	uint32_t nbytes = __nbytes(width);
	uint32_t rv = 0;
	int i;
	for(i = 0; i < 4; i++)
	{
		uint32_t cv = t[i];
		rv = rv | (cv << (8*i));
		if((i+1) == nbytes)
			break;
	}
	return(rv);
}
uint64_t byte_array_to_uint64(uint8_t* t, uint32_t width)
{
	uint32_t nbytes = __nbytes(width);
	uint64_t rv = 0;
	int i;
	for(i = 0; i < 8; i++)
	{
		uint64_t cv = t[i];
		rv = rv | (cv << (8*i));
		if((i+1) == nbytes)
			break;
	}
	return(rv);
}

uint8_t byte_logical_op(AaOperation op, uint8_t f, uint8_t s)
{
	switch(op)
	{
		case __OR  :
			return(f | s);
		case __AND:
			return(f & s);
		case __XOR:
			return(f ^ s);
		case __NOR:
			return(~(f | s));
		case __NAND:
			return(~(f & s));
		case __XNOR:
			return(~(f ^ s));
		default:
			assert(0);
	}
}

void shift_or_rotate_op(uint8_t* f, uint8_t* s, uint8_t signed_flag, uint32_t width)
{
	uint32_t shift_width = byte_array_to_uint32(s, width);

	switch(op)
	{
		// IN PROGRESS.
		case __SHL:
		case __SHR:
		case __ASHR:
		case __ROR:
		case __ROL:
		default:
			assert(0);
	}	
}
			
void arithmetic_op(uint8_t* f,uint8_t* s,uint8_t* result,uint8_t signed_flag,uint32_t width)
{
	switch(op)
	{
		case __PLUS:
		case __MINUS:
		case __MUL:
		case __DIV:
		default:
			assert(0);
	}
}
			
void bitsel_op(uint8_t* f,uint8_t* s,uint8_t* result,uint8_t width)
{
	assert(0);
}
void concatenate_op(uint8_t* f, uint32_t f_width, uint8_t* s, uint32_t s_width, uint8_t* result)

void sized_binary_operation(uint8_t signed_flag, 
			    uint8_t* f, 
			    uint8_t* s, 
			    uint8_t* result, 
			    uint32_t width, 
		            AaOperation op)
{
	uint32_t nbytes = __nbytes(width);
	int i;
	switch(op)
	{
		case __OR  :
		case __AND:
		case __XOR:
		case __NOR:
		case __NAND:
		case __XNOR:
			for(i = 0; i < 	nbytes; i++)
				result[i] = byte_logical_op(op,f[i],s[i]);
			break;
		case __SHL:
		case __SHR:
		case __ASHR:
		case __ROR:
		case __ROL:
			shift_or_rotate_op(f,s,result,signed_flag,width);
			break;
		case __PLUS:
		case __MINUS:
		case __MUL:
		case __DIV:
			arithmetic_op(f,s,result,signed_flag, width);
		case __EQUAL:
		case __NOTEQUAL:
		case __LESS:
		case __LESSEQUAL:
		case __GREATER:
		case __GREATEREQUAL:
			comparison_op(f,s,result,signed_flag,width);
			break;
		case __BITSEL:
			bitsel_op(f,s,result,width);
			break;
		default:
			assert(0);
			break;
	}
}


void   sized_unary_operation(uint8_t* f, uint8_t* result, uint32_t width,  AaOperation op)
{
	uint32_t nbytes = __nbytes(width);
	int i;

	assert(0);
}

void   sized_slice_operation(uint8_t* dest, uint8_t* src, uint32_t low_index, uint32_t dest_width, uint32_t src_width);
{
	assert(0);
}

float  sized_to_float(uint8_t signed_flag, uint8_t* f, uint32_t width)
{
	uint32_t fval = byte_array_to_uint32(f,width);
	float ret_val = (float) fval;
	return(ret_val);
}

double sized_to_double(uint8_t signed_flag, uint8_t* f, uint32_t width)
{
	uint64_t fval = byte_array_to_uint64(f,width);
	double ret_val = (float) fval;
	return(ret_val);
}
