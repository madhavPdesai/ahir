#include <stdint.h>
#include <string.h>
#include "llvm_intrinsics.h"


void llvm_memcpy_u64(uint64_t* dest, uint64_t* src, uint32_t len)
{
	memcpy((void*)dest, (void*)src, len*8);
}

void llvm_memmove_u64(uint64_t* dest, uint64_t* src, uint32_t len)
{
	memmove((void*)dest, (void*)src, len*8);
}

#define _MemSetMacro__ {int idx; for(idx = 0; idx < len; idx++) dest[idx] = val;}
void llvm_memset_u64(uint64_t* dest, uint64_t val, uint32_t len)
{
	_MemSetMacro__
}

void llvm_memcpy_u32(uint32_t* dest, uint32_t* src, uint32_t len)
{
	memcpy((void*)dest, (void*)src, len*4);
}
void llvm_memmove_u32(uint32_t* dest, uint32_t* src, uint32_t len)
{
	memmove((void*)dest, (void*)src, len*4);
}
void llvm_memset_u32(uint32_t* dest, uint32_t val, uint32_t len)
{
	_MemSetMacro__
}
void llvm_memcpy_u16(uint16_t* dest, uint16_t* src, uint32_t len)
{
	memcpy((void*)dest, (void*)src, len*2);
}
void llvm_memmove_u16(uint16_t* dest, uint16_t* src, uint32_t len)
{
	memmove((void*)dest, (void*)src, len*2);
}
void llvm_memset_u16(uint16_t* dest, uint16_t val, uint32_t len)
{
	_MemSetMacro__
}

void llvm_memcpy_u8(uint8_t* dest, uint8_t* src, uint32_t len)
{
	memcpy((void*)dest, (void*)src, len);
}
void llvm_memmove_u8(uint8_t* dest, uint8_t* src, uint32_t len)
{
	memmove((void*)dest, (void*)src, len);
}
void llvm_memset_u8(uint8_t* dest, uint8_t val, uint32_t len)
{
	_MemSetMacro__
}

