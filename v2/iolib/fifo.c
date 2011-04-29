/* author: Sameer Sahasrabudhe */
#include "iolib.h"

#include <stdio.h>
#include <errno.h>
#include <sys/stat.h>           /* for mkfifo() flags */
#include <stdlib.h>             /* for exit() */
#include <fcntl.h>              /* for open() flags */
#include <string.h>
#include <assert.h>

static FILE* open_for_reading(char *id)
{
  FILE *F = NULL;
  void *data = NULL;
  int mkfifo_status = 0;
  
  /* The reader never creates a FIFO. It goes into a loop with sleep()
     for one second, waiting for the FIFO to be created by the
     writer. */
  F = fopen(id, "r");
  while (!F) {
    sleep(1);
    F = fopen(id, "r");
  }

  /* fprintf(stderr, "\nopened FIFO %s for reading.", id); */
  
  return F;
}

static FILE* open_for_writing(char*);
void send_ack(char* id)
{
  char txt = 0;
  char* buffer = (char*) malloc(strlen(id) + 5);
  sprintf(buffer,"%s.ack",id);

  FILE *F = open_for_writing(buffer);
  fwrite(&txt, sizeof(char), 1, F);
  fclose(F);
}

void wait_for_ack(char* id)
{
  char txt;
  char* buffer = (char*) malloc(strlen(id) + 5);
  sprintf(buffer,"%s.ack",id);

  FILE *F = open_for_reading(buffer);
  fread(&txt, sizeof(char), 1, F);
  fclose(F);

  assert(txt == 0);
}


double read_float64(char *id)
{
  double f;
  FILE *F = open_for_reading(id);
  fread(&f, sizeof(double), 1, F);
  fclose(F);
  send_ack(id);
  return f;
}

float read_float32(char *id)
{
  float f;
  FILE *F = open_for_reading(id);
  fread(&f, sizeof(float), 1, F);
  fclose(F);
  send_ack(id);
  return f;
}

uint64_t read_uint64(char *id)
{
  uint64_t i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(uint64_t), 1, F);
  fclose(F);
  send_ack(id);
  return i;
}

uint32_t read_uint32(char *id)
{
  uint32_t i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(uint32_t), 1, F);
  fclose(F);
  send_ack(id);
  return i;
}

void* read_pointer(char *id)
{
  void* i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(void*), 1, F);
  fclose(F);
  send_ack(id);
  return i;
}

uint16_t read_uint16(char *id)
{
  uint16_t i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(uint16_t), 1, F);
  fclose(F);
  send_ack(id);
  return i;
}

uint8_t read_uint8(char *id)
{
  uint8_t i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(uint8_t), 1, F);
  fclose(F);
  send_ack(id);
  return i;
}

static FILE* open_for_writing(char *id)
{
  FILE *F = NULL;
  int mkfifo_status;
  int fd;

  /* Try to open a FIFO for writing, without creating it. Have to use
     open() and not fopen() here, because the latter always creates a
     simple file if the named object does not exist. */
  fd = open(id, O_WRONLY);
  
  if (fd == -1) {
    if (errno == ENOENT) {
      /* The FIFO doesn't exist, so we create it. We could have
         directly tried mkfifo() in place of open(). This would
         eliminate the later call to fdopen(), but the untested
         assumption is that open() followed by fdopen() is cheaper
         than mkfifo() when the FIFO already exists. */
      mkfifo_status = mkfifo(id, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
      if (mkfifo_status != 0) {
        exit(0);
      }
      fd = open(id, O_WRONLY);
      if (fd == -1)             /* paranoia... */
        exit(0);
    } else
      /* open() failed even when the FIFO exists. */
      exit(0);
  }
  /* fprintf(stderr, "\ncreated FIFO %s for writing.", id); */

  /* Since open() returns a file descripter, we have to associate it
     with a stream before returning. */
  F = fdopen(fd, "w");
  if (!F)                       /* ... bordering on OCD? */
    exit(0);
  
  return F;
}

void write_float64(char *id, double data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(double), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_float32(char *id, float data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(float), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint64(char *id, uint64_t data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint64_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint32(char *id, uint32_t data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint32_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_pointer(char *id, void* data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(void*), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint16(char *id, uint16_t data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint16_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint8(char *id, uint8_t data)
{
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint8_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}
