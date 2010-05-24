#include "iolib.h"

#include <stdio.h>
#include <errno.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <unistd.h>
#include <inttypes.h>

static FILE* open_for_reading(char *id)
{
  FILE *F = NULL;
  void *data = NULL;
  int mkfifo_status = 0;
  
  mkfifo_status = mkfifo(id, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
  if (mkfifo_status != 0) {
    if (errno != EEXIST)
      exit(0);
  /* } else {*/
    /* fprintf(stderr, "\ncreated fifo %s for reading.", id); */
  }

  F = fopen(id, "r");
  if (!F)
    exit(0);
  /* fprintf(stderr, "\nopened fifo %s for reading.", id); */
  
  return F;
}

float read_float32(char *id)
{
  float f;
  FILE *F = open_for_reading(id);
  fread(&f, sizeof(float), 1, F);
  return f;
}

uint32_t read_uint32(char *id)
{
  uint32_t i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(uint32_t), 1, F);
  return i;
}

static FILE* open_for_writing(char *id)
{
  FILE *F = NULL;
  int mkfifo_status;
  
  mkfifo_status = mkfifo(id, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
  if (mkfifo_status != 0) {
    if (errno != EEXIST)
      exit(0);
  /* } else { */
    /* fprintf(stderr, "\ncreated fifo %s for writing.", id); */
  }
  
  F = fopen(id, "w");
  if (!F)
    exit(0);
  
  return F;
}

void write_float32(char *id, float data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(float), 1, F);
  fclose(F);
}

void write_uint32(char *id, uint32_t data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint32_t), 1, F);
  fclose(F);
}

