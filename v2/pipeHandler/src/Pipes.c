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
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <bits/wordsize.h>
#include <Pipes.h>
#include <pipeHandler.h>

#ifndef USE_GNUPTH
#include <pthread.h>
#include <pthreadUtils.h>
#else
#include <pth.h>
#include <GnuPthUtils.h>
#endif 

#define WARNBUFLEN___(w, id,b) {fprintf(stderr,"Warning:  0-length %s to pipe %s\n", (w ? "write" : "read"), id);}

MUTEX_DECL(log_mutex);
#define __LOCKLOG__  MUTEX_LOCK(log_mutex);
#define __UNLOCKLOG__  MUTEX_UNLOCK(log_mutex);

#ifndef USE_GNUPTH
#define __SLEEP__(n) sched_yield();
#else
#define __SLEEP__(n) pth_yield(NULL);
#endif

#define READ_BURST__(id, width, buf_len, buf) { uint32_t words_read = 0;\
	while(1)\
	{\
		words_read += read_from_pipe((char*) id, width, buf_len - words_read, (void*) (buf + words_read));\
		if(words_read == buf_len)\
		break;\
		else\
		__SLEEP__(1);\
	} }

#define WRITE_BURST__(id, width, buf_len,buf) { uint32_t words_written = 0;\
	while(1)\
	{\
		words_written += write_to_pipe((char*) id, width, buf_len - words_written, (void*) (buf + words_written));\
		if(words_written == buf_len)\
		break;\
		else\
		__SLEEP__(1);\
	} }

uint64_t read_uint64(const char *id)
{
	uint64_t ret_val;
	uint64_t* buf = &ret_val;
	READ_BURST__(id, 64, 1, buf);

#ifdef DEBUG
	__LOCKLOG__
	fprintf(stderr,"Info:read_uint64: read %s.\n", id);
	fflush(stderr);
	__UNLOCKLOG__
#endif
	return(ret_val);
}

void write_uint64(const char *id, uint64_t data)
{
	uint64_t* buf = &data;
	WRITE_BURST__(id, 64, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
	fprintf(stderr,"Info:write_uint64: write %s (%llu)\n", id,data);
	fflush(stderr);
	__UNLOCKLOG__
#endif
}


// from pipe id, receive buf_len uint64_t's..
void read_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
	if(buf_len > 0)
	{	
		READ_BURST__(id,64,buf_len,buf);
	}
	else
		WARNBUFLEN___(0, id, buf_len);
}

// to pipe id, send buf_len uint64_t's...
void write_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
	if(buf_len > 0)
	{	
		WRITE_BURST__(id,64,buf_len,buf);
	}
	else
		WARNBUFLEN___(1, id, buf_len);
}

uint32_t read_uint32(const char *id)
{
	uint32_t ret_val;
	uint32_t* buf = &ret_val;
#ifdef DEBUG
	__LOCKLOG__
	fprintf(stderr,"Info:read_uint32: started read %s.\n", id);
	fflush(stderr);
	__UNLOCKLOG__
#endif
	READ_BURST__(id, 32, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
	fprintf(stderr,"Info:read_uint32: finished read %s, returned 0x%08x.\n", id, ret_val);
	fflush(stderr);
	__UNLOCKLOG__
#endif
	return(ret_val);
}
void write_uint32(const char *id, uint32_t data)
{
	uint32_t* buf = &data;
#ifdef DEBUG
	__LOCKLOG__
	fprintf(stderr,"Info:write_uint32: started write %s (%u)\n", id,data);
	fflush(stderr);
	__UNLOCKLOG__
#endif
	WRITE_BURST__(id, 32, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
	fprintf(stderr,"Info:write_uint32: finished write %s (%u)\n", id,data);
	fflush(stderr);
	__UNLOCKLOG__
#endif
}

// from pipe id, receive buf_len uint32_t's..
void read_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
	if(buf_len > 0)
	{
		READ_BURST__(id,32,buf_len,buf);
	}
	else
		WARNBUFLEN___(0, id, buf_len);
}

// to pipe id, send buf_len uint32_t's...
void write_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
	if(buf_len > 0)
	{
		WRITE_BURST__(id, 32, buf_len, buf);
	}
	else
		WARNBUFLEN___(1, id, buf_len);
}

uint16_t read_uint16(const char *id)
{
	uint16_t ret_val;
	uint16_t* buf = &ret_val;
	READ_BURST__(id, 16, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
		fprintf(stderr,"Info:read_uint16: read %s.\n", id);
	fflush(stderr);
	__UNLOCKLOG__
#endif
		return(ret_val);
}
void write_uint16(const char *id, uint16_t data)
{
	uint16_t* buf = &data;
	WRITE_BURST__(id, 16, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
		fprintf(stderr,"Info:write_uint16: write %s (%u)\n", id,data);
	fflush(stderr);
	__UNLOCKLOG__
#endif
}

// from pipe id, receive buf_len uint16_t's..
void read_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
	if(buf_len > 0)
	{
		READ_BURST__(id,16,buf_len,buf);
	}
	else
		WARNBUFLEN___(0, id, buf_len);
}

// to pipe id, send buf_len uint16_t's...
void write_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
	if(buf_len > 0)
	{
		WRITE_BURST__(id, 16, buf_len, buf);
	}
	else
		WARNBUFLEN___(1, id, buf_len);
}

uint8_t read_uint8(const char *id)
{
	uint8_t ret_val;
	uint8_t* buf = &ret_val;
#ifdef DEBUG
	__LOCKLOG__
		fprintf(stderr,"Info:read_uint8: started read %s.\n", id, ret_val);
	fflush(stderr);
	__UNLOCKLOG__
#endif
		READ_BURST__(id, 8, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
		fprintf(stderr,"Info:read_uint8: finished read %s, returned %x.\n", id, ret_val);
	fflush(stderr);
	__UNLOCKLOG__
#endif
		return(ret_val);
}
void write_uint8(const char *id, uint8_t data)
{
	uint8_t* buf = &data;
#ifdef DEBUG
	__LOCKLOG__
		fprintf(stderr,"Info:write_uint8: started write %s (%u)\n", id,data);
	fflush(stderr);
	__UNLOCKLOG__
#endif
		WRITE_BURST__(id, 8, 1, buf);
#ifdef DEBUG
	__LOCKLOG__
		fprintf(stderr,"Info:write_uint8: finished write %s (%u)\n", id,data);
	fflush(stderr);
	__UNLOCKLOG__
#endif
}

// from pipe id, receive buf_len uint8_t's..
void read_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
	if(buf_len > 0)
	{
		READ_BURST__(id,8,buf_len,buf);
	}
	else
		WARNBUFLEN___(0, id, buf_len);
}

// to pipe id, send buf_len uint8_t's...
void write_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
	if(buf_len > 0)
	{
		WRITE_BURST__(id, 8, buf_len, buf);
	}
	else
		WARNBUFLEN___(1, id, buf_len);
}

uint32_t* read_uintptr(const char *id)
{
	return((uint32_t*) read_pointer(id));

}

void write_uintptr(const char *id, uint32_t* data)
{
	write_pointer(id, (void*) data);
}

void* read_pointer(const char *id)
{
#if __WORD_SIZE==32
  return((void*) read_uint32(id));
#else
  return((void*) read_uint64(id));
#endif
}

void write_pointer(const char *id, void* pdata)
{
#if __WORD_SIZE==32
	write_uint32(id, (uint32_t) pdata);
#else
	write_uint64(id, (uint64_t) pdata);
#endif
}

float read_float32(const char *id)
{
	float ret_val;
	float* buf = &ret_val;
	READ_BURST__(id, 32, 1, buf);
	return(ret_val);
}
void write_float32(const char *id, float data)
{
	float* buf = &data;
	WRITE_BURST__(id, 32, 1, buf);
}

void read_float32_n(const char *id, float* buf, int buf_len)
{
	if(buf_len > 0)
	{
		read_uint32_n(id,(uint32_t*) buf,buf_len);
	}
	else
		WARNBUFLEN___(0, id, buf_len);
}

void write_float32_n(const char *id, float* buf, int buf_len)
{
	if(buf_len > 0)
	{
		write_uint32_n(id, (uint32_t*) buf, buf_len);
	}
	else
		WARNBUFLEN___(1, id, buf_len);
}

double read_float64(const char *id)
{
	double ret_val;
	double* buf = &ret_val;
	READ_BURST__(id, 64, 1, buf);
	return(ret_val);
}
void write_float64(const char *id, double data)
{
	double* buf = &data;
	WRITE_BURST__(id, 64, 1, buf);
}
void read_float64_n(const char *id, double* buf, int buf_len)
{
	if(buf_len > 0)
	{
		read_uint64_n(id,(uint64_t*) buf,buf_len);
	}
	else
		WARNBUFLEN___(0, id, buf_len);
}

void write_float64_n(const char *id, double* buf, int buf_len)
{
	if(buf_len > 0)
	{
		write_uint64_n(id, (uint64_t*) buf, buf_len);
	}
	else
		WARNBUFLEN___(1, id, buf_len);
}


