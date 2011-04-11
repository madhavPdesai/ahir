/* author: Sameer Sahasrabudhe */
#ifndef AHIR_IOLIB_H
#define AHIR_IOLIB_H

#include <stdint.h>

float read_float32(char *id);
uint32_t read_uint32(char *id);

void write_float32(char *id, float data);
void write_uint32(char *id, uint32_t data);

#endif
