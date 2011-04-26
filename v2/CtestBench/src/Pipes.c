#include <stdlib.h>
#include <stdint.h>
#include <SocketLib.h>

#define READ__(id,t,w)  sprintf(buffer, "piperead %s", id);	\
  append_int(buffer,0);\
  append_int(buffer,1);\
  append_int(buffer,w);\
  send_packet_and_wait_for_response(buffer,"localhost",9999);


#define WRITE__(id,t,w) sprintf(buffer, "pipewrite %s", id);	\
  append_int(buffer,1);\
  append_##t(buffer,data);\
  append_int(buffer,0);\
  send_packet_and_wait_for_response(buffer,"localhost",9999);


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
