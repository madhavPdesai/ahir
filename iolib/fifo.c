#include "iolib.h"
#include "portmap.h"

#include <inttypes.h>

float read_float32(char *id)
{
  FILE *F = port2fifo(id, 1);
  float f;
  fread(&f, sizeof(float), 1, F);
  return f;
}

uint32_t read_uint32(char *id)
{
  FILE *F = port2fifo(id, 1);
  uint32_t i;

  fread(&i, sizeof(uint32_t), 1, F);
  return i;
}

void write_float32(char *id, float data)
{
  FILE *F = port2fifo(id, 0);
  fwrite(&data, sizeof(float), 1, F);
  fflush(F);
}

void write_uint32(char *id, uint32_t data)
{
  FILE *F = port2fifo(id, 0);
  fwrite(&data, sizeof(uint32_t), 1, F);
}

