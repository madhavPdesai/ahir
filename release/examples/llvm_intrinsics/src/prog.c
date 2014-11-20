#include <stdint.h>
void llvm_memcpy_u32(uint32_t* dest, uint32_t* src, uint32_t len);
void llvm_memmove_u32(uint32_t* dest, uint32_t* src, uint32_t len);
void llvm_memset_u32(uint32_t* dest, uint32_t val, uint32_t len);


uint32_t A[16];

void runDaemon()
{
	while(1)
	{
		uint32_t idx;

		for(idx = 0; idx < 16; idx++)
		{
			A[idx] = read_uint32("in_pipe");
		}

		// copy 4..7 into 0...3
		// new state of array
		// 0 1 2 3 4 5 6 7 8 9 10 11  15
		// 4 5 6 7 4 5 6 7 8 9 10 ... 15
		llvm_memcpy_u32(&A[0],&A[4],4);

		// copy 8,9 into 7,8
		// new state of array
		// 0 1 2 3 4 5 6 7 8 9 10 11..15
		// 4 5 6 7 4 5 6 8 9 9 10 ... 15
		llvm_memmove_u32(&A[7],&A[8],2);

		// copy 10,11,12 into 12,13,14
		// new state of array
		// 4 5 6 7 4 5 6 8 9 9 10 11 10 11 12 15
		llvm_memmove_u32(&A[12], &A[10], 3);

		// set 14,15 to 0.
		// new state of array
		// 4 5 6 7 4 5 6 8 9 9 10 11 10 11 0 0
		llvm_memset_u32(&A[14],0,2);

		for(idx = 0; idx < 16; idx++)
		{
			write_uint32("out_pipe", A[idx]);
		}
	}
}
