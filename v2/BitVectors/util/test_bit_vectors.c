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

void check_bitsel(uint64_t bit_width)
{
}

void check_concatenate(uint64_t bit_width)
{
}

void check_slice(uint64_t bit_width)
{
}

void check_shifts(uint64_t bit_width)
{
}


int check_if_tests_passed(uint64_t def_size)
{
	int ret_val = 0;
	uint64_t A = rand();
	uint64_t B = rand();

	bit_vector a,b,c,d,e;

	init_bit_vector(&a,def_size);
	init_bit_vector(&b,def_size);
	init_bit_vector(&c,def_size);


	bit_vector_assign_uint64(0,&a,A);
	bit_vector_assign_uint64(0,&b,B);


	bit_vector_assign_uint64(0,&c,0);


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

	bit_vector_mul(&(a),&(b),&(c));
	check_error(&c, Atrunc, Btrunc, "(A*B)", (Atrunc*Btrunc), &ret_val, def_size);

	if(Btrunc != 0)
	{
		bit_vector_div(&(a),&(b),&(c));
		check_error(&c, Atrunc, Btrunc, "(A/B)", (Atrunc/Btrunc), &ret_val, def_size);
	}

	return(ret_val);
}

//
// usage
//    <program>  <lowest-word-length> <highest-word-length>
//
int main(int argc, char* argv[])
{



	int fail_count = 0;
	uint64_t def_size;

	int L = 1;
	int H = 64;

	if(argc > 1)
		L = atoi(argv[1]);

	if(argc > 2)
		H = atoi(argv[2]);

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


