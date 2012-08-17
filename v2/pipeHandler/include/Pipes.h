#ifndef __Pipes_h__
#define __Pipes_h__

#include <stdlib.h>
#include <stdint.h>

uint64_t read_uint64(const char *id);
void write_uint64(const char *id, uint64_t data);
void read_uint64_n(const char *id, uint64_t* buf, int buf_len);
void write_uint64_n(const char *id, uint64_t* buf, int buf_len);

uint32_t read_uint32(const char *id);
void write_uint32(const char *id, uint32_t data);
void read_uint32_n(const char *id, uint32_t* buf, int buf_len);
void write_uint32_n(const char *id, uint32_t* buf, int buf_len);

uint16_t read_uint16(const char *id);
void write_uint16(const char *id, uint16_t data);
void read_uint16_n(const char *id, uint16_t* buf, int buf_len);
void write_uint16_n(const char *id, uint16_t* buf, int buf_len);


uint8_t read_uint8(const char *id);
void write_uint8(const char *id, uint8_t data);
void read_uint8_n(const char *id, uint8_t* buf, int buf_len);
void write_uint8_n(const char *id, uint8_t* buf, int buf_len);

uint32_t* read_uintptr(const char *id);
void write_uintptr(const char *id, uint32_t* data);

void* read_pointer(const char *id);
void write_pointer(const char *id, void* data);

float read_float32(const char *id);
void write_float32(const char *id, float data);
void read_float32_n(const char *id, float* buf, int buf_len);
void write_float32_n(const char *id, float* buf, int buf_len);


double read_float64(const char *id);
void write_float64(const char *id, double data);
void read_float64_n(const char *id, double* buf, int buf_len);
void write_float64_n(const char *id, double* buf, int buf_len);


#endif
