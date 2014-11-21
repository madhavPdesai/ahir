#ifndef _llvm_intrinsics_h__
#define _llvm_intrinsics_h__
#include <stdint.h>
void llvm_memcpy_u64(uint64_t* dest, uint64_t* src, uint32_t len);
void llvm_memmove_u64(uint64_t* dest, uint64_t* src, uint32_t len);
void llvm_memset_u64(uint64_t* dest, uint64_t val, uint32_t len);

void llvm_memcpy_u32(uint32_t* dest, uint32_t* src, uint32_t len);
void llvm_memmove_u32(uint32_t* dest, uint32_t* src, uint32_t len);
void llvm_memset_u32(uint32_t* dest, uint32_t val, uint32_t len);

void llvm_memcpy_u16(uint16_t* dest, uint16_t* src, uint32_t len);
void llvm_memmove_u16(uint16_t* dest, uint16_t* src, uint32_t len);
void llvm_memset_u16(uint16_t* dest, uint16_t val, uint32_t len);

void llvm_memcpy_u8(uint8_t* dest, uint8_t* src, uint32_t len);
void llvm_memmove_u8(uint8_t* dest, uint8_t* src, uint32_t len);
void llvm_memset_u8(uint8_t* dest, uint8_t val, uint32_t len);

#endif 
