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
#include <pthread.h>
#include <BitVectors.h>
	
void check_error(bit_vector* c, uint64_t A, uint64_t B, char* op_string,  uint64_t expected,  int* ret_val, uint64_t bit_width)
{
	uint64_t cval = bit_vector_to_uint64(0,c);
	uint64_t expected_val = truncate_uint64(expected,bit_width);

	if(cval != expected_val)
	{
		fprintf(stderr,"Error: A=%llx, B=%llx, %s = %llx, expected = %llx\n", A,B, op_string, cval, expected_val);
		*ret_val = 1;
	}

}

// checks set bit, get_bit
int check_bitsel(uint64_t bit_width)
{

	int ret_val = 0;
	bit_vector tv;
	bit_vector bit_pos;
	bit_vector bit_val;

	init_bit_vector(&tv,bit_width);
	init_bit_vector(&bit_pos, 32);
	init_bit_vector(&bit_val, 1);


	bit_vector_clear(&tv);

	//
	// an elementary march test... checks that
	//    each bit can be set and cleared.
	//    bit-sel correctly reads each bit.
	//
	uint64_t i;
	for(i = 0; i < bit_width; i++)
	{
		bit_vector_set_bit(&tv, i, 1);

		uint64_t j;
		for(j = 0; j < bit_width; j++)
		{
			bit_vector_assign_uint64(0,&bit_pos, j);
			bit_vector_bitsel(&tv, &bit_pos, &bit_val);
			uint8_t bv = bit_vector_get_bit(&tv,j);

			uint8_t bvs = bit_vector_to_uint64(0,&bit_val);

			if(bv != bvs)
			{
				fprintf(stderr,"Error: bit-value mismatch between get_bit and bitsel. (for bit_width=%llu)\n", bit_width);
				ret_val = 1;
			}


			if((i == j) && (bvs != 1))
			{
				fprintf(stderr,"Error: bit-value mismatch in march (for bit_width=%llu, index = %llu\n", bit_width, i);
				ret_val = 1;
			}
			if((i != j) && (bvs != 0))
			{
				fprintf(stderr,"Error: bit-value mismatch in march (for bit_width=%llu, index = %llu\n", bit_width, i);
				ret_val = 1;
			}
		}
		bit_vector_set_bit(&tv, i, 0);
	}

	return(ret_val);
}

int check_decode_encode()
{
	int ret_val = 0;

	__declare_bit_vector(u_256, 256);
	bit_vector_clear(&u_256);
	
	__declare_bit_vector(u_8, 8);
	bit_vector_clear(&u_8);



	int I;
	__declare_bit_vector(uu_256, 256);

	for(I=0; I < 256; I++)
	{
		bit_vector_clear(&u_256);
		bit_vector_set_bit(&u_256,I,1);

		bit_vector_encode(&u_256,&u_8);
		if(bit_vector_to_uint64(0,&u_8) != I)
		{
			fprintf(stderr,"Error: encode %s = %llx, expected %d\n",
					to_hex_string(&u_256), bit_vector_to_uint64(0,&u_8),
							I);
			ret_val = 1;
		}

		bit_vector_assign_uint64(0,&u_8, I);
		bit_vector_decode(&u_8, &uu_256);
		if((bit_vector_compare(0,&u_256, &uu_256) != IS_EQUAL))
		{
			fprintf(stderr,"Error: decode %d = %s, expected %s\n", I,
					to_hex_string(&uu_256), to_hex_string(&u_256));
			ret_val = 1;
		}
	}
	return(ret_val);
}

int check_reduce_operations()
{
	int ret_val = 0;
	__declare_bit_vector(u_8,8);	

	__declare_bit_vector(a_1,1);	
	__declare_bit_vector(o_1,1);	
	__declare_bit_vector(x_1,1);	

	int I;
	for(I=0; I < 256; I++)
	{
		bit_vector_assign_uint64(0, &u_8, I);

		uint8_t aI = (I == 255);
		uint8_t oI = (I != 0);
		uint8_t xI = ((I & 0x1) 
				^ ((I >> 1) & 0x1) 
				^ ((I >> 2) & 0x1) 
				^ ((I >> 3) & 0x1) 
				^ ((I >> 4) & 0x1) 
				^ ((I >> 5) & 0x1) 
				^ ((I >> 6) & 0x1) 
				^ ((I >> 7) & 0x1) );

		
		bit_vector_reduce_or(&u_8, &o_1);
		bit_vector_reduce_and(&u_8, &a_1);
		bit_vector_reduce_xor(&u_8, &x_1);

		if(bit_vector_to_uint64(0,&o_1) !=  oI)
		{
			fprintf(stderr,"Error: reduce | %s = %x, expected %x\n",
					to_string(&u_8), bit_vector_to_uint64(0,&o_1), oI); 
			ret_val = 1;
		}
		
		if(bit_vector_to_uint64(0,&a_1) !=  aI)
		{
			fprintf(stderr,"Error: reduce & %s = %x, expected %x\n",
					to_string(&u_8), bit_vector_to_uint64(0,&a_1), aI); 
			ret_val = 1;
		}

		if(bit_vector_to_uint64(0,&x_1) !=  xI)
		{
			fprintf(stderr,"Error: reduce & %s = %x, expected %x\n",
					to_string(&u_8), bit_vector_to_uint64(0,&x_1), xI); 
			ret_val = 1;
		}
	}
	return(ret_val);
}


//
// concatenate two numbers to produce a larger one.
//
int check_concatenate(uint64_t bit_width)
{
	int ret_val = 0;

	if(bit_width == 1)
		return(0);

	uint64_t s_width = bit_width/2;
	

	__declare_bit_vector(a,bit_width-s_width);
	__declare_bit_vector(b,s_width);
	__declare_bit_vector(c,bit_width-s_width);
	__declare_bit_vector(d,s_width);
	__declare_bit_vector(e,bit_width);


	bit_vector_assign_uint64(0,&a,0xf0);
	uint64_t aval = bit_vector_to_uint64(0,&a);
	bit_vector_assign_uint64(0,&b,0x0f);
	uint64_t bval = bit_vector_to_uint64(0,&b);

	bit_vector_concatenate(&a,&b,&e);

	bit_vector_slice(&e,&c,s_width);
	bit_vector_slice(&e,&d,0);

	if(bit_vector_compare(0,&b,&d) != IS_EQUAL)
	{
		ret_val = 1;
		fprintf(stderr,"Error: in check_concatenate for bit_width=%llu\n", bit_width);
	}
	if(bit_vector_compare(0,&a,&c) != IS_EQUAL)
	{
		ret_val = 1;
		fprintf(stderr,"Error: in check_concatenate for bit_width=%llu\n", bit_width);
	}

	return(ret_val);
}


int check_shifts(uint64_t bit_width)
{

	int ret_val = 0;	

	__declare_bit_vector(a,bit_width);
	bit_vector_set(&a);

	__declare_bit_vector(b,bit_width);
	bit_vector_clear(&b);

	__declare_bit_vector(ab, 2*bit_width);
	bit_vector_concatenate(&a, &b, &ab);

	__declare_bit_vector(e,bit_width);
	bit_vector_assign_uint64(0,&e, bit_width);

	__declare_bit_vector(all_ones,bit_width);
	bit_vector_set(&all_ones);

	__declare_bit_vector(all_zeros,bit_width);
	bit_vector_clear(&all_zeros);

	__declare_bit_vector(rsa_ab,2*bit_width);
	__declare_bit_vector(rsl_ab,2*bit_width);
	__declare_bit_vector(ls_ab,2*bit_width);


	__declare_bit_vector(tmp,bit_width);

	// rsa_ab should have all 1's in the lower half.
	//               all 1's in the upper half.
	bit_vector_shift_right(1, &ab, &e, &rsa_ab); 
	bit_vector_slice(&rsa_ab,&tmp,0);
	if(bit_vector_compare(0,&tmp,&all_ones) != 0)	
	{
		ret_val = 1;
		fprintf(stderr,"Error: shift-right-arithmetic for bit-width %llu, lower half mismatch\n", bit_width);
		fprintf(stderr,"\t expected\n\t%s,\n\t found\n\t%s\n", to_string(&all_ones), to_string(&tmp));
	}
	bit_vector_slice(&rsa_ab,&tmp,bit_width);
	if(bit_vector_compare(0,&tmp,&all_ones) != 0)	
	{
		ret_val = 1;
		fprintf(stderr,"Error: shift-right-arithmetic for bit-width %llu, upper half mismatch\n", bit_width);
		fprintf(stderr,"\t expected\n\t%s,\n\t found\n\t%s\n", to_string(&all_ones), to_string(&tmp));
	}



	// rsl_ab should have all 1's in the lower half
	//  and all 0's in the upper half.
	bit_vector_shift_right(0, &ab, &e, &rsl_ab); 
	bit_vector_slice(&rsl_ab,&tmp,0);
	if(bit_vector_compare(0,&tmp,&all_ones) != IS_EQUAL)	
	{
		ret_val = 1;
		fprintf(stderr,"Error: shift-right-logical for bit-width %llu, lower half mismatch\n", bit_width);
		fprintf(stderr,"\t expected\n\t%s,\n\t found\n\t%s\n", to_string(&all_ones), to_string(&tmp));
	}
	bit_vector_slice(&rsl_ab,&tmp,bit_width);
	if(bit_vector_compare(0,&tmp,&all_zeros) != 0)	
	{
		ret_val = 1;
		fprintf(stderr,"Error: shift-right-logical for bit-width %llu, upper half mismatch\n", bit_width);
		fprintf(stderr,"\t expected\n\t%s,\n\t found\n\t%s\n", to_string(&all_zeros), to_string(&tmp));
	}



	// ls_ab should be full of zeros.
	bit_vector_shift_left (&ab, &e, &ls_ab); 
	bit_vector_slice(&ls_ab,&tmp,0);
	if(bit_vector_compare(0,&tmp,&all_zeros) != 0)	
	{
		ret_val = 1;
		fprintf(stderr,"Error: shift-left for bit-width %llu, lower half mismatch\n", bit_width);
		fprintf(stderr,"\t expected\n\t%s,\n\t found\n\t%s\n", to_string(&all_zeros), to_string(&tmp));
	}
	bit_vector_slice(&rsl_ab,&tmp,bit_width);
	if(bit_vector_compare(0,&tmp,&all_zeros) != 0)	
	{
		ret_val = 1;
		fprintf(stderr,"Error: shift-left for bit-width %llu, upper half mismatch\n", bit_width);
		fprintf(stderr,"\t expected\n\t%s,\n\t found\n\t%s\n", to_string(&all_zeros), to_string(&tmp));
	}

	return(ret_val);
}

int check_rotates()
{
	int ret_val = 0;

	int I;
	for(I = 0; I < 1024; I++)
	{
		uint8_t A = rand();
		uint8_t B = rand() % 8;

		bit_vector p,q,sp;

		init_bit_vector(&p, 8);
		init_bit_vector(&q, 8);
		init_bit_vector(&sp, 8);

		bit_vector_assign_uint64(0,&p, A);
		bit_vector_assign_uint64(0,&sp, B);
		bit_vector_rotate_left(&p, &sp, &q);

		uint8_t result = bit_vector_to_uint64(0, &q);
		uint8_t expected_result = (A << B) | (A >> (8-B));

		if(expected_result != result)
		{
			fprintf(stderr,"Error: in rotate left.\n");
			ret_val = 1;
		}

		bit_vector_rotate_right(&p, &sp, &q);
		result = bit_vector_to_uint64(0, &q);
		expected_result = (A >> B) | (A << (8-B));

		if(expected_result != result)
		{
			fprintf(stderr,"Error: in rotate right.\n");
			ret_val = 1;
		}
	}
	return(ret_val);
}

int check_compares(uint64_t A, uint64_t B, uint64_t bit_width)
{

	int64_t sA = A;
	int64_t sB = B;
	uint8_t ret_val = 0;
	bit_vector a,b;
	init_bit_vector(&a, bit_width);
	init_bit_vector(&b, bit_width);

	bit_vector_assign_uint64(0,&a,A);
	bit_vector_assign_uint64(0,&b,B);


	bit_vector sa,sb;
	init_bit_vector(&sa, bit_width);
	init_bit_vector(&sb, bit_width);

	bit_vector_assign_uint64(1,&sa,sA);
	bit_vector_assign_uint64(1,&sb,sB);

	uint8_t cmp_result = bit_vector_compare(0,&a,&b);
	uint8_t ucmp = uint64_compare(0,A,B,bit_width);
	if(cmp_result != ucmp)
	{
		ret_val = 1;
		fprintf(stderr,"Error: unsigned compare mismatch for A=%llu, B=%llu, bit_width=%llu\n",A,B,bit_width);
	}

	cmp_result = bit_vector_compare(1,&sa,&sb);
	uint8_t scmp = uint64_compare(1,A,B,bit_width);
	if(cmp_result != scmp)
	{
		ret_val = 1;
		fprintf(stderr,"Error: signed compare mismatch for A=%lld, B=%lld, bit_width=%llu\n",sA,sB,bit_width);
	}

	return(ret_val);
}


int check_if_tests_passed(uint64_t def_size)
{
	int ret_val = 0;
	uint64_t A = rand();
	uint64_t B = rand();

	bit_vector a,b,c,d,e, sa,sb,sc;

	init_bit_vector(&a,def_size);
	init_bit_vector(&sa,def_size);
	init_bit_vector(&b,def_size);
	init_bit_vector(&sb,def_size);
	init_bit_vector(&c,def_size);
	init_bit_vector(&sc,def_size);


	bit_vector_assign_uint64(0,&a,A);
	bit_vector_assign_uint64(0,&b,B);

	bit_vector_assign_uint64(1,&sa,A);
	bit_vector_assign_uint64(1,&sb,B);

	bit_vector_assign_uint64(0,&c,0);
	bit_vector_assign_uint64(0,&sc,0);


	//
	// *,/ will be on truncated A,B values.
	//
	uint64_t Atrunc = truncate_uint64(A, def_size);
	uint64_t Btrunc = truncate_uint64(B, def_size);

	bit_vector_or(&(a),&(b),&(c));
	check_error(&c, A, B, "(A|B)", (A|B), &ret_val, def_size);

	bit_vector_and(&(a),&(b),&(c));
	check_error(&c, A, B, "(A&B)", (A&B), &ret_val, def_size);

	bit_vector_nor(&(a),&(b),&(c));
	check_error(&c, A, B, "~(A|B)", ~(A|B), &ret_val, def_size);

	bit_vector_nand(&(a),&(b),&(c));
	check_error(&c, A, B, "~(A&B)", ~(A&B), &ret_val, def_size);

	bit_vector_xor(&(a),&(b),&(c));
	check_error(&c, A, B, "(A^B)", (A^B), &ret_val, def_size);

	bit_vector_xnor(&(a),&(b),&(c));
	check_error(&c, A, B, "~(A^B)", ~(A^B), &ret_val, def_size);

	bit_vector_plus(&(a),&(b),&(c));
	check_error(&c, A, B, "(A+B)", (A+B), &ret_val, def_size);

	bit_vector_minus(&(a),&(b),&(c));
	check_error(&c, A, B, "(A-B)", (A-B), &ret_val, def_size);

	if(def_size <= 64)
	{
		bit_vector_mul(&(a),&(b),&(c));
		check_error(&c, Atrunc, Btrunc, "(A*B)", (Atrunc*Btrunc), &ret_val, def_size);

		if(Btrunc != 0)
		{
			bit_vector_div(&(a),&(b),&(c));
			check_error(&c, Atrunc, Btrunc, "(A/B)", (Atrunc/Btrunc), &ret_val, def_size);
		}

		bit_vector_smul(&(sa), &(sb), &(sc));
		check_error(&sc, Atrunc, Btrunc, "(A*B)", (Atrunc*Btrunc), &ret_val, def_size);
	}


	ret_val = check_bitsel(def_size) || ret_val;
	ret_val = check_concatenate(def_size) || ret_val;
	ret_val = check_shifts(def_size) || ret_val;
	ret_val = check_compares(truncate_uint64(A,def_size),truncate_uint64(B,def_size),def_size) || ret_val;

	return(ret_val);
}


int misc_tests()
{
	bit_vector konst;
	init_bit_vector(&konst, 4);
	bit_vector_clear(&konst);
	konst.val.byte_array[0] = 4;
	uint64_t kval = bit_vector_to_uint64(0, &konst);
	if(kval != 4)
		return(1);

	uint8_t ret_val = check_shifts(64);
	return(ret_val);
}

//
// usage
//    <program>  <lowest-word-length> <highest-word-length>
//
int main(int argc, char* argv[])
{

	srand(119);


	int fail_count = 0;
	int mret = misc_tests();
	if(mret)
	{
		fprintf(stderr,"Error: misc tests failed.\n");
		return(1);
	}
		

	uint64_t def_size;

	int L = 1;
	int H = 64;

	if(argc > 1)
		L = atoi(argv[1]);

	if(argc > 2)
		H = atoi(argv[2]);


	if(check_rotates())
	{
	    fprintf(stderr,"Error: rotate tests failed.\n");
	    fail_count++;
	}

	if(check_decode_encode())
	{
	    fprintf(stderr,"Error: decode-encode tests failed.\n");
	    fail_count++;
	}

	if(check_reduce_operations())
	{
	    fprintf(stderr,"Error: reduce-op tests failed.\n");
	    fail_count++;
	}

	for(def_size = L; def_size <= H; def_size++)
	{
		if(check_if_tests_passed(def_size))
		{
			fprintf(stderr,"Error: tests failed for bit-width %llu\n", def_size);
			fail_count++;
		}
	}

	if(fail_count > 0)
		fprintf(stderr,"Error: tests failed for %d bit-widths.\n", fail_count);
	else
		fprintf(stderr,"Info: tests passed for all bit-widths.\n");

	return(fail_count);
}


