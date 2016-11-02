//
// Copyright (C) 2010-: Madhav P. Desai
// All Rights Reserved.
//  
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal with the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimers.
//  * Redistributions in binary form must reproduce the above
//    copyright notice, this list of conditions and the following
//    disclaimers in the documentation and/or other materials provided
//    with the distribution.
//  * Neither the names of the AHIR Team, the Indian Institute of
//    Technology Bombay, nor the names of its contributors may be used
//    to endorse or promote products derived from this Software
//    without specific prior written permission.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
// ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
/* author: Sameer Sahasrabudhe */
#include "iolib.h"

#include <stdio.h>
#include <errno.h>
#include <sys/stat.h>           /* for mkfifo() flags */
#include <stdlib.h>             /* for exit() */
#include <fcntl.h>              /* for open() flags */
#include <string.h>
#include <assert.h>

typedef struct PipeWidthRec_ PipeWidthRec;
struct PipeWidthRec_
{
  char* pipe_name;
  int pipe_width;
  PipeWidthRec* next;
};

PipeWidthRec* pipe_width_list = NULL;

int Add_Pipe(char* pipe_name, int pipe_width)
{
	char no_match = 1;
	PipeWidthRec* curr = pipe_width_list;
	while(curr != NULL)
	{
		if(strcmp(curr->pipe_name,pipe_name) == 0)
		{
			no_match = 0;
			if(curr->pipe_width != pipe_width)
			{	
				fprintf(stderr, "\nError: in iolib.. pipe %s has multiple width access (%d, %d)\n",
					pipe_name, curr->pipe_width, pipe_width);
				return(1);
			}
			break;
		}
		curr = curr->next;
	}

	if(no_match)
	{
		PipeWidthRec* new_rec = (PipeWidthRec*) malloc(sizeof(PipeWidthRec));
		new_rec->pipe_name = strdup(pipe_name);
		new_rec->pipe_width = pipe_width;
		new_rec->next = pipe_width_list;
		pipe_width_list = new_rec;
	}

	return(0);
}

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

  int n = 0;
  while((n=fread(&txt, sizeof(char), 1, F)) == 0);

  fclose(F);

  assert(txt == 0);
}


double read_float64(char *id)
{
  double f = 0.0;

  if(Add_Pipe(id,64))
	return f;

  FILE *F = open_for_reading(id);

  while(fread(&f, sizeof(double), 1, F) == 0)
  {
	usleep(1000);
  }

  fclose(F);
  send_ack(id);
  return f;
}

float read_float32(char *id)
{
  float f = 0.0;

  if(Add_Pipe(id,32))
	return f;

  FILE *F = open_for_reading(id);
  while(fread(&f, sizeof(float), 1, F) == 0)
  {
	usleep(1000);
  }
	
  fclose(F);
  send_ack(id);
  return f;
}

uint64_t read_uint64(char *id)
{
  uint64_t i = 0;

  if(Add_Pipe(id,64))
	return i;

  FILE *F = open_for_reading(id);
  while(fread(&i, sizeof(uint64_t), 1, F) == 0)
  {
	usleep(1000);
  }
	
  fclose(F);
  send_ack(id);
  return i;
}

uint32_t read_uint32(char *id)
{
  uint32_t i=0;
  if(Add_Pipe(id,32))
	return i;
  FILE *F = open_for_reading(id);
  while(fread(&i, sizeof(uint32_t), 1, F) == 0)
  {
	usleep(1000);
  }
	
  fclose(F);
  send_ack(id);
  return i;
}

uint32_t* read_uintptr(char *id)
{
	return((uint32_t*) read_pointer(id));
}

void* read_pointer(char *id)
{
  void* i = NULL;
  if(Add_Pipe(id,8*sizeof(void*)))
	return i;

  FILE *F = open_for_reading(id);
  while(fread(&i, sizeof(void*), 1, F) == 0) 
  {
	usleep(1000);
  }
  fclose(F);
  send_ack(id);
  return i;
}

uint16_t read_uint16(char *id)
{
  uint16_t i=0;
  if(Add_Pipe(id,16))
	return i;
  FILE *F = open_for_reading(id);
  while(fread(&i, sizeof(uint16_t), 1, F) == 0)
  {
	usleep(1000);
  }
	
  fclose(F);
  send_ack(id);
  return i;
}

uint8_t read_uint8(char *id)
{
  uint8_t i=0;
  if(Add_Pipe(id,8))
	return i;
  FILE *F = open_for_reading(id);
  while(fread(&i, sizeof(uint8_t), 1, F) == 0)
  {
	usleep(1000);
  }
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
  if(Add_Pipe(id,64))
	return;

  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(double), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_float32(char *id, float data)
{
  if(Add_Pipe(id,32))
	return;

  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(float), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint64(char *id, uint64_t data)
{
  if(Add_Pipe(id,64))
	return;

  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint64_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint32(char *id, uint32_t data)
{
  if(Add_Pipe(id,32))
	return;
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint32_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uintptr(char *id, uint32_t* data)
{
	write_pointer(id,(void*) data);
}

void write_pointer(char *id, void* data)
{
  if(Add_Pipe(id,8*sizeof(void*)))
	return;
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(void*), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint16(char *id, uint16_t data)
{
  if(Add_Pipe(id,16))
	return;
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint16_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}

void write_uint8(char *id, uint8_t data)
{
  if(Add_Pipe(id,8))
	return;
  FILE *F = open_for_writing(id);
  fwrite(&data, sizeof(uint8_t), 1, F);
  fclose(F);
  wait_for_ack(id);
}



// burst read/write..
void read_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      buf[i] = read_uint64((char*) id);
    }
}
void write_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      write_uint64((char*) id,buf[i]);
    }
}



void read_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      buf[i] = read_uint32((char*) id);
    }
}
void write_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      write_uint32((char*) id,buf[i]);
    }
}


void read_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      buf[i] = read_uint16((char*) id);
    }
}
void write_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      write_uint16((char*) id,buf[i]);
    }
}

void read_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      buf[i] = read_uint8((char*) id);
    }
}

void write_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      write_uint8((char*) id,buf[i]);
    }
}



void read_float64_n(const char *id, double* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      buf[i] = read_float64((char*) id);
    }
}
void write_float64_n(const char *id, double* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      write_float64((char*) id,buf[i]);
    }
}
void read_float32_n(const char *id, float* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      buf[i] = read_float32((char*) id);
    }
}
void write_float32_n(const char *id, float* buf, int buf_len)
{
  int i;
  for(i = 0; i < buf_len; i++)
    {
      write_float32((char*) id,buf[i]);
    }
}



