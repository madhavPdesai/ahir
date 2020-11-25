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
#include <SocketLib.h>
#include <string.h>
#include <assert.h>
#include <SocketLib.h>
#include <SockPipes.h>


#define READ__(id,t,w)  sprintf(buffer, "piperead.single %s ", id);	\
  append_int(buffer,0);ADD_SPACE__(buffer);\
  append_int(buffer,1);ADD_SPACE__(buffer);\
  append_int(buffer,w);\
  send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);


#define WRITE__(id,t,w) sprintf(buffer, "pipewrite.single %s ", id);	\
  append_int(buffer,1);ADD_SPACE__(buffer);\
  append_##t(buffer,data);ADD_SPACE__(buffer);\
  append_int(buffer,0);\
  ADD_SPACE__(buffer);\
  append_int(buffer,w);\
  send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);


#define READ_BURST__(id,w,len,buf)  sprintf(buffer, "piperead.burst %s %d %d ",id,w,len); \
  send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999); \
  bcopy(buffer,buf,(len*w/8));

#define WRITE_BURST__(id,w,len,buf,send_len) sprintf(buffer, "pipewrite.burst %s %d %d #", id, w, len); \
  send_len=strlen(buffer)+(len*w/8);					\
			 bcopy(buf,buffer + strlen(buffer),(len*w/8)); \
			 send_packet_and_wait_for_response(buffer,send_len,"localhost",9999);
#define SOCKWARNBUFLENANDRETURN__(w, id, buf_len) {if(buf_len <= 0) {fprintf(stderr,"Warning: 0-length %s to pipe %s\n", (w ? "write" : "read"), id); return;} }


// register pipes will have no effect...  Assumption, at this
// point, pipes should have been checked out "correctly".
uint8_t sock_register_pipe(const char* id, int pipe_depth, int pipe_width, int lifo_mode)
{
  return(0);

  /*
  uint8_t ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  if(lifo_mode)
  	sprintf(buffer,"registerpipe.lifo %s %d %d", id, pipe_depth,pipe_width);
  else
  	sprintf(buffer,"registerpipe.fifo %s %d %d", id, pipe_depth,pipe_width);

  send_packet_and_wait_for_response(buffer,strlen(buffer),"localhost",9999);
#ifdef DEBUG
  fprintf(stderr,"Info: in sock_register_pipe, received %s\n", buffer);
#endif
  ret_val = get_uint8_t(buffer,&ss);
  return(ret_val);
  */
  
}

uint8_t sock_register_port(const char* id, int pipe_width, int is_input)
{
  return(0);
  /*
  uint8_t ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  sprintf(buffer,"registerpipe.flag %s %d %d", id, pipe_width, is_input);

  send_packet_and_wait_for_response(buffer,strlen(buffer),"localhost",9999);
#ifdef DEBUG
  fprintf(stderr,"Info: in sock_register_port, received %s\n", buffer);
#endif
  ret_val = get_uint8_t(buffer,&ss);
  return(ret_val);
  */
}

uint64_t sock_read_uint64(const char *id)
{
  uint64_t ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,uint64_t,64);
#ifdef DEBUG
  fprintf(stderr,"Info: in sock_read_uint64, received %s\n", buffer);
#endif
  ret_val = get_uint64_t(buffer,&ss);
  return(ret_val);
}
void sock_write_uint64(const char *id, uint64_t data)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  WRITE__(id,uint64_t,64);
}


// from pipe id, receive buf_len uint64_t's..
void sock_read_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
  SOCKWARNBUFLENANDRETURN__(0, id, buf_len);

  char buffer[MAX_BUF_SIZE+1024];

  if(buf_len*sizeof(uint64_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_read_uint64_n from pipe %s, read dropped.\n",id);
	return;
  }

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint64_t)); 
  if(buf_size > (MAX_BUF_SIZE + 1024))
  {
	fprintf(stderr, 
		"ERROR: buffer overflow due to excessively long pipe-name %s in sock_read_uint64_n, read dropped.\n",id);
	return;
  }


  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint64_t
  // items and memcpy it into buf.
  READ_BURST__(id,64,buf_len,buf);
  
}

// to pipe id, send buf_len uint64_t's...
void sock_write_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
  SOCKWARNBUFLENANDRETURN__(1, id, buf_len);

  if(buf_len*sizeof(uint64_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: buffer overflow in sock_write_uint64_n to pipe %s, write dropped.\n",id);
	return;
  }

  int send_len = 0;
  char buffer[MAX_BUF_SIZE+1024];

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint64_t)); 
  if(buf_size > (MAX_BUF_SIZE + 1024))
  {
	fprintf(stderr, 
		"ERROR: buffer overflow due to excessively long pipe-name %s in sock_write_uint64_n, write dropped.\n", id);
	return;
  }

  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint64_t))));

  // send a message with a character string header and a variable length data field.
  // The data field will start after the end of the character-string, on 
  // an 8-byte boundary.
  // for example:
  // "pipewrite.burst id 64 buf_len buf (aligned to 8 byte boundary)"
  // with spaces separating the fields..
  WRITE_BURST__(id,64,buf_len,buf,send_len);
}

uint32_t sock_read_uint32(const char *id)
{
  uint32_t ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,uint32_t,32);
  ret_val = get_uint32_t(buffer,&ss);
  return(ret_val);
}
void sock_write_uint32(const char *id, uint32_t data)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  WRITE__(id,uint32_t,32);
}

// from pipe id, receive buf_len uint32_t's..
void sock_read_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
  SOCKWARNBUFLENANDRETURN__(0, id, buf_len);

  char buffer[MAX_BUF_SIZE+1024];

  if(buf_len*sizeof(uint32_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_read_uint32_n from pipe %s, read dropped.\n",id);
	return;
  }

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint32_t));
  if(buf_size > MAX_BUF_SIZE+1024)
  {
	fprintf(stderr, 
		"ERROR: pipe-name %s is too long.. sock_read_uint32_n, read dropped.\n", id);
	return;
  }
  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint32_t
  // items and memcpy it into buf.
  READ_BURST__(id,32,buf_len,buf);
  
}

// to pipe id, send buf_len uint32_t's...
void sock_write_uint32_n(const char *id, uint32_t* buf, int buf_len)
{

  SOCKWARNBUFLENANDRETURN__(1, id, buf_len);

  if(buf_len*sizeof(uint32_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_write_uint32_n to pipe %s, write dropped.\n",id);
	return;
  }

  char buffer[MAX_BUF_SIZE+1024];

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint32_t));
  if(buf_size > MAX_BUF_SIZE+1024)
  {
	fprintf(stderr, 
		"ERROR: pipe-name %s is too long.. sock_write_uint32_n, write dropped.\n", id);
	return;
  }
  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint32_t))));

  // prepare message
  sprintf(buffer, "pipewrite.burst %s %d %d #", id, 32, buf_len);
  int prefix_len = strlen(buffer);
  int send_len = prefix_len+(buf_len*32/8);

  bcopy((char*)buf, &(buffer[prefix_len]),(buf_len*32/8));
  send_packet_and_wait_for_response(buffer,send_len,"localhost",9999);
}

uint16_t sock_read_uint16(const char *id)
{
  uint16_t ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,uint16_t,16);
  ret_val = get_uint16_t(buffer,&ss);
  return(ret_val);
}
void sock_write_uint16(const char *id, uint16_t data)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  WRITE__(id,uint16_t,16);
}

// from pipe id, receive buf_len uint16_t's..
void sock_read_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
  SOCKWARNBUFLENANDRETURN__(0, id, buf_len);
  char buffer[MAX_BUF_SIZE+1024];

  if(buf_len*sizeof(uint16_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_read_uint16_n to pipe %s, read dropped.\n",id);
	return;
  }

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint16_t));
  if(buf_size > MAX_BUF_SIZE+1024)
  {
	fprintf(stderr, 
		"ERROR: pipe-name %s is too long.. sock_read_uint16_n, read dropped.\n", id);
	return;
  }

  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint16_t
  // items and memcpy it into buf.
  READ_BURST__(id,16,buf_len,buf);
  
}

// to pipe id, send buf_len uint16_t's...
void sock_write_uint16_n(const char *id, uint16_t* buf, int buf_len)
{

  SOCKWARNBUFLENANDRETURN__(1, id, buf_len);
  if(buf_len*sizeof(uint16_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_write_uint16_n to pipe %s, write dropped.\n",id);
	return;
  }
  int send_len = 0;
  char buffer[MAX_BUF_SIZE+1024];

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint16_t));
  if(buf_size > MAX_BUF_SIZE+1024)
  {
	fprintf(stderr, 
		"ERROR: pipe-name %s is too long.. sock_write_uint16_n, write dropped.\n", id);
	return;
  }
  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint16_t))));

  // send a message with a character string header and a variable length data field.
  // The data field will start after the end of the character-string, on 
  // an 8-byte boundary.
  // for example:
  // "pipewrite.burst id 64 buf_len buf (aligned to 8 byte boundary)"
  // with spaces separating the fields..
  WRITE_BURST__(id,16,buf_len,buf,send_len);
}

uint8_t sock_read_uint8(const char *id)
{
  uint8_t ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,uint8_t,8);
  ret_val = get_uint8_t(buffer,&ss);
  return(ret_val);
}
void sock_write_uint8(const char *id, uint8_t data)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  WRITE__(id,uint8_t,8);
}

// from pipe id, receive buf_len uint8_t's..
void sock_read_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
  SOCKWARNBUFLENANDRETURN__(0, id, buf_len);
  if(buf_len*sizeof(uint8_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_read_uint8_n to pipe %s, read dropped.\n",id);
	return;
  }
  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint8_t));
  if(buf_size > MAX_BUF_SIZE+1024)
  {
	fprintf(stderr, 
		"ERROR: pipe-name %s is too long.. sock_read_uint8_n, read dropped.\n", id);
	return;
  }

  char buffer[MAX_BUF_SIZE+1024];


  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint8_t
  // items and memcpy it into buf.
  READ_BURST__(id,8,buf_len,buf);
  
}

// to pipe id, send buf_len uint8_t's...
void sock_write_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
  SOCKWARNBUFLENANDRETURN__(1, id, buf_len);

  if(buf_len*sizeof(uint8_t) > MAX_BUF_SIZE)
  {
	fprintf(stderr, 
		"ERROR: excessive buffer-length in sock_write_uint8_n to pipe %s, write dropped.\n",id);
	return;
  }

  int send_len = 0;
  char buffer[MAX_BUF_SIZE+1024];

  int buf_size = (strlen(id) + 25 + buf_len*sizeof(uint8_t));
  if(buf_size > MAX_BUF_SIZE+1024)
  {
	fprintf(stderr, 
		"ERROR: pipe-name %s is too long.. sock_write_uint8_n, write dropped.\n", id);
	return;
  }

  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint8_t))));

  // send a message with a character string header and a variable length data field.
  // The data field will start after the ned of the character-string, on 
  // an 8-byte boundary.
  // for example:
  // "pipewrite.burst id 64 buf_len buf (aligned to 8 byte boundary)"
  // with spaces separating the fields..
  WRITE_BURST__(id,8,buf_len,buf,send_len);
}

uint32_t* sock_read_uintptr(const char *id)
{
	return((uint32_t*) sock_read_pointer(id));
}

void sock_write_uintptr(const char *id, uint32_t* data)
{
	sock_write_pointer(id, (void*) data);
}

void* sock_read_pointer(const char *id)
{
  void* ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,void*,32);
  ret_val = (void*) get_uint32_t(buffer,&ss);
  return(ret_val);
}
void sock_write_pointer(const char *id, void* pdata)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  uint32_t data = (uint32_t)pdata;
  WRITE__(id,uint32_t,32);
}
float sock_read_float32(const char *id)
{
  float ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,float,32);
  ret_val = (float) get_float(buffer,&ss);
  return(ret_val);
}
void sock_write_float32(const char *id, float data)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  WRITE__(id,float,32);
}
void sock_read_float32_n(const char *id, float* buf, int buf_len)
{
  sock_read_uint32_n(id,(uint32_t*) buf,buf_len);
}

void sock_write_float32_n(const char *id, float* buf, int buf_len)
{
  sock_write_uint32_n(id, (uint32_t*) buf, buf_len);
}

double sock_read_float64(const char *id)
{
  double ret_val;
  char buffer[MAX_BUF_SIZE];
  char* ss;
  READ__(id,double,64);
  ret_val = (double) get_double(buffer,&ss);
  return(ret_val);

}
void sock_write_float64(const char *id, double data)
{
  char buffer[MAX_BUF_SIZE];
  char* ss;
  WRITE__(id,double,64);
}
void sock_read_float64_n(const char *id, double* buf, int buf_len)
{
  sock_read_uint64_n(id,(uint64_t*) buf,buf_len);
}

void sock_write_float64_n(const char *id, double* buf, int buf_len)
{
  sock_write_uint64_n(id, (uint64_t*) buf, buf_len);
}


