#include <stdlib.h>
#include <stdint.h>
#include <SocketLib.h>
#include <string.h>
#include <assert.h>

#define READ__(id,t,w)  sprintf(buffer, "piperead.single %s ", id);	\
  append_int(buffer,0);ADD_SPACE__(buffer);\
  append_int(buffer,1);ADD_SPACE__(buffer);\
  append_int(buffer,w);\
  send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);


#define WRITE__(id,t,w) sprintf(buffer, "pipewrite.single %s ", id);	\
  append_int(buffer,1);ADD_SPACE__(buffer);\
  append_##t(buffer,data);ADD_SPACE__(buffer);\
  append_int(buffer,0);\
  send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);


#define READ_BURST__(id,w,len,buf)  sprintf(buffer, "piperead.burst %s %d %d ",id,w,len); \
  send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999); \
  bcopy(buffer,buf,(len*w/8));

#define WRITE_BURST__(id,w,len,buf,send_len) sprintf(buffer, "pipewrite.burst %s %d %d #", id, w, len); \
  send_len=strlen(buffer)+(len*w/8);					\
			 bcopy(buf,buffer + strlen(buffer),(len*w/8)); \
			 send_packet_and_wait_for_response(buffer,send_len,"localhost",9999);

uint64_t read_uint64(const char *id)
{
  uint64_t ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,uint64_t,64);
  ret_val = get_uint64_t(buffer,&ss);
  return(ret_val);
}
void write_uint64(const char *id, uint64_t data)
{
  char buffer[4096];
  char* ss;
  WRITE__(id,uint64_t,64);
}

// from pipe id, receive buf_len uint64_t's..
void read_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
  char buffer[5000];

  assert(buf_len*8 < 4096);

  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint64_t
  // items and memcpy it into buf.
  READ_BURST__(id,64,buf_len,buf);
  
}

// to pipe id, send buf_len uint64_t's...
void write_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
  int send_len = 0;
  char buffer[5000];

  assert(strlen(id) + 25 + buf_len*sizeof(uint64_t)< 5000);
  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint64_t))));

  // send a message with a character string header and a variable length data field.
  // The data field will start after the ned of the character-string, on 
  // an 8-byte boundary.
  // for example:
  // "pipewrite.burst id 64 buf_len buf (aligned to 8 byte boundary)"
  // with spaces separating the fields..
  WRITE_BURST__(id,64,buf_len,buf,send_len);
}

uint32_t read_uint32(const char *id)
{
  uint32_t ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,uint32_t,32);
  ret_val = get_uint32_t(buffer,&ss);
  return(ret_val);
}
void write_uint32(const char *id, uint32_t data)
{
  char buffer[4096];
  char* ss;
  WRITE__(id,uint32_t,32);
}

// from pipe id, receive buf_len uint32_t's..
void read_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
  char buffer[5000];

  assert(buf_len*sizeof(uint32_t) < 4096);

  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint32_t
  // items and memcpy it into buf.
  READ_BURST__(id,32,buf_len,buf);
  
}

// to pipe id, send buf_len uint32_t's...
void write_uint32_n(const char *id, uint32_t* buf, int buf_len)
{

  char buffer[5000];

  assert(strlen(id) + 25 + buf_len*sizeof(uint32_t)< 5000);
  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint32_t))));

  // prepare message
  sprintf(buffer, "pipewrite.burst %s %d %d #", id, 32, buf_len);
  int prefix_len = strlen(buffer);
  int send_len = prefix_len+(buf_len*32/8);

  bcopy((char*)buf, &(buffer[prefix_len]),(buf_len*32/8));
  send_packet_and_wait_for_response(buffer,send_len,"localhost",9999);
}

uint16_t read_uint16(const char *id)
{
  uint16_t ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,uint16_t,16);
  ret_val = get_uint16_t(buffer,&ss);
  return(ret_val);
}
void write_uint16(const char *id, uint16_t data)
{
  char buffer[4096];
  char* ss;
  WRITE__(id,uint16_t,16);
}

// from pipe id, receive buf_len uint16_t's..
void read_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
  char buffer[5000];

  assert(buf_len*sizeof(uint16_t) < 4096);

  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint16_t
  // items and memcpy it into buf.
  READ_BURST__(id,16,buf_len,buf);
  
}

// to pipe id, send buf_len uint16_t's...
void write_uint16_n(const char *id, uint16_t* buf, int buf_len)
{

  int send_len = 0;
  char buffer[5000];

  assert(strlen(id) + 25 + buf_len*sizeof(uint16_t)< 5000);
  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint16_t))));



  // send a message with a character string header and a variable length data field.
  // The data field will start after the ned of the character-string, on 
  // an 8-byte boundary.
  // for example:
  // "pipewrite.burst id 64 buf_len buf (aligned to 8 byte boundary)"
  // with spaces separating the fields..
  WRITE_BURST__(id,16,buf_len,buf,send_len);
}

uint8_t read_uint8(const char *id)
{
  uint8_t ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,uint8_t,8);
  ret_val = get_uint8_t(buffer,&ss);
  return(ret_val);
}
void write_uint8(const char *id, uint8_t data)
{
  char buffer[4096];
  char* ss;
  WRITE__(id,uint8_t,8);
}

// from pipe id, receive buf_len uint8_t's..
void read_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
  char buffer[5000];

  assert(buf_len*sizeof(uint8_t) < 4096);

  // send a request packet of the form
  // "piperead.burst <pipe-name> 64 buf_len"
  // receive a packet which has exactly buf_len uint8_t
  // items and memcpy it into buf.
  READ_BURST__(id,8,buf_len,buf);
  
}

// to pipe id, send buf_len uint8_t's...
void write_uint8_n(const char *id, uint8_t* buf, int buf_len)
{

  int send_len = 0;
  char buffer[5000];

  assert(strlen(id) + 25 + buf_len*sizeof(uint8_t)< 5000);
  bzero(buffer,(strlen(id) + 25 +(buf_len*sizeof(uint8_t))));

  // send a message with a character string header and a variable length data field.
  // The data field will start after the ned of the character-string, on 
  // an 8-byte boundary.
  // for example:
  // "pipewrite.burst id 64 buf_len buf (aligned to 8 byte boundary)"
  // with spaces separating the fields..
  WRITE_BURST__(id,8,buf_len,buf,send_len);
}

void* read_pointer(const char *id)
{
  void* ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,void*,32);
  ret_val = (void*) get_uint32_t(buffer,&ss);
  return(ret_val);
}
void write_pointer(const char *id, void* pdata)
{
  char buffer[4096];
  char* ss;
  uint32_t data = (uint32_t)pdata;
  WRITE__(id,uint32_t,32);
}
float read_float(const char *id)
{
  float ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,float,32);
  ret_val = (float) get_float(buffer,&ss);
  return(ret_val);
}
void write_float(const char *id, float data)
{
  char buffer[4096];
  char* ss;
  WRITE__(id,float,32);
}
double read_double(const char *id)
{
  double ret_val;
  char buffer[4096];
  char* ss;
  READ__(id,double,64);
  ret_val = (double) get_double(buffer,&ss);
  return(ret_val);

}
void write_double(const char *id, double data)
{
  char buffer[4096];
  char* ss;
  WRITE__(id,double,64);
}
