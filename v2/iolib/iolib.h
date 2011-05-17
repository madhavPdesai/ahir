/* author: Sameer Sahasrabudhe */
#ifndef AHIR_IOLIB_H
#define AHIR_IOLIB_H

#include <stdint.h>

double read_float64(char *id);
float read_float32(char *id);
uint64_t read_uint64(char *id);
uint32_t read_uint32(char *id);
void* read_pointer(char *id);
uint16_t read_uint16(char *id);
uint8_t read_uint8(char *id);

void write_float64(char *id, double data);
void write_float32(char *id, float data);
void write_uint64(char *id, uint64_t data);
void write_uint32(char *id, uint32_t data);
void write_pointer(char *id, void* data);
void write_uint16(char *id, uint16_t data);
void write_uint8(char *id, uint8_t data);

#endif