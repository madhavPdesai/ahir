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

