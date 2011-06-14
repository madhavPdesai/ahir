/* author: Sameer Sahasrabudhe */
#ifndef AHIR_IOLIB_H
#define AHIR_IOLIB_H

#include <stdint.h>

double read_float64(char *id);
float read_float32(char *id);
uint64_t read_uint64(char *id);
uint32_t read_uint32(char *id);
uint32_t* read_uintptr(char *id);
void* read_pointer(char *id);
uint16_t read_uint16(char *id);
uint8_t read_uint8(char *id);

void write_float64(char *id, double data);
void write_float32(char *id, float data);
void write_uint64(char *id, uint64_t data);
void write_uint32(char *id, uint32_t data);
void write_uintptr(char *id, uint32_t* data);
void write_pointer(char *id, void* data);
void write_uint16(char *id, uint16_t data);
void write_uint8(char *id, uint8_t data);


void read_uint64_n(const char *id, uint64_t* buf, int buf_len);
void write_uint64_n(const char *id, uint64_t* buf, int buf_len);

void read_uint32_n(const char *id, uint32_t* buf, int buf_len);
void write_uint32_n(const char *id, uint32_t* buf, int buf_len);

void read_uint16_n(const char *id, uint16_t* buf, int buf_len);
void write_uint16_n(const char *id, uint16_t* buf, int buf_len);

void read_uint8_n(const char *id, uint8_t* buf, int buf_len);
void write_uint8_n(const char *id, uint8_t* buf, int buf_len);

void read_float64_n(const char *id, double* buf, int buf_len);
void write_float64_n(const char *id, double* buf, int buf_len);

void read_float32_n(const char *id, float* buf, int buf_len);
void write_float32_n(const char *id, float* buf, int buf_len);

#endif
