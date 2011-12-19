#ifndef READWRITE_HH
#define READWRITE_HH

#include <stdint.h>

float read_float32(const char *id);
uint32_t read_uint32(const char *id);
uint8_t read_uint8(const char *id);
uintptr_t read_uintptr(const char *id);

void write_float32(const char *id, float data);
void write_uint32(const char *id, uint32_t data);
void write_uint8(const char *id, uint8_t data);
void write_uintptr(const char *id, uintptr_t data);

#endif
