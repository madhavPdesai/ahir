#include <stdlib.h>
#include <stdint.h>

uint64_t read_uint64(const char *id);
void write_uint64(const char *id, uint64_t data);
uint32_t read_uint32(const char *id);
void write_uint32(const char *id, uint32_t data);
uint16_t read_uint16(const char *id);
void write_uint16(const char *id, uint16_t data);
uint8_t read_uint8(const char *id);
void write_uint8(const char *id, uint8_t data);
void* read_pointer(const char *id);
void write_pointer(const char *id, void* data);
float read_float(const char *id);
void write_float(const char *id, float data);
double read_double(const char *id);
void write_double(const char *id, double data);

