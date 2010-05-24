#include "iolib.h"

#include <stdio.h>
#include <errno.h>
#include <sys/stat.h>           /* for mkfifo() flags */
#include <stdlib.h>             /* for exit() */
#include <fcntl.h>              /* for open() flags */

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

float read_float32(char *id)
{
  float f;
  FILE *F = open_for_reading(id);
  fread(&f, sizeof(float), 1, F);
  fclose(F);
  return f;
}

uint32_t read_uint32(char *id)
{
  uint32_t i;
  FILE *F = open_for_reading(id);
  fread(&i, sizeof(uint32_t), 1, F);
  fclose(F);
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

