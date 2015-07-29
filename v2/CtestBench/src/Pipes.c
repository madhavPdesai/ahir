#include <stdlib.h>
#include <stdint.h>
#include <SocketLib.h>
#include <string.h>
#include <assert.h>
#include <SocketLib.h>
#include <Pipes.h>

uint8_t register_pipe(const char* id, int pipe_depth, int pipe_width, int lifo_mode)
{
	return(sock_register_pipe(id,pipe_depth,pipe_width,lifo_mode));
}

uint8_t register_port(const char* id, int pipe_width, int is_input)
{
	return(sock_register_port(id,pipe_width,is_input));
}

uint8_t register_signal(const char* id, int pipe_width)
{
	return(sock_register_port(id,pipe_width,0));
}

uint64_t read_uint64(const char *id)
{
	return(sock_read_uint64(id));
}
void write_uint64(const char *id, uint64_t data)
{
	sock_write_uint64(id,data);
}


// from pipe id, receive buf_len uint64_t's..
void read_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
	sock_read_uint64_n(id,buf,buf_len);
}

// to pipe id, send buf_len uint64_t's...
void write_uint64_n(const char *id, uint64_t* buf, int buf_len)
{
	sock_write_uint64_n(id,buf,buf_len);
}

uint32_t read_uint32(const char *id)
{
	return(sock_read_uint32(id));
}
void write_uint32(const char *id, uint32_t data)
{
	sock_write_uint32(id,data);
}

// from pipe id, receive buf_len uint32_t's..
void read_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
	sock_read_uint32_n(id,buf,buf_len);
}

// to pipe id, send buf_len uint32_t's...
void write_uint32_n(const char *id, uint32_t* buf, int buf_len)
{
	sock_write_uint32_n(id, buf, buf_len);
}

uint16_t read_uint16(const char *id)
{
	return(sock_read_uint16(id));
}

void write_uint16(const char *id, uint16_t data)
{
	sock_write_uint16(id,data);
}

// from pipe id, receive buf_len uint16_t's..
void read_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
	sock_read_uint16_n(id,buf,buf_len);
}

// to pipe id, send buf_len uint16_t's...
void write_uint16_n(const char *id, uint16_t* buf, int buf_len)
{
	sock_write_uint16_n(id,buf,buf_len);
}

uint8_t read_uint8(const char *id)
{
	return(sock_read_uint8(id));
}
void write_uint8(const char *id, uint8_t data)
{
	sock_write_uint8(id,data);
}

// from pipe id, receive buf_len uint8_t's..
void read_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
	sock_read_uint8_n(id,buf,buf_len);
}

// to pipe id, send buf_len uint8_t's...
void write_uint8_n(const char *id, uint8_t* buf, int buf_len)
{
	sock_write_uint8_n(id,buf,buf_len);
}

uint32_t* read_uintptr(const char *id)
{
	return(sock_read_uintptr(id));
}

void write_uintptr(const char *id, uint32_t* data)
{
	sock_write_uintptr(id,data);
}

void* read_pointer(const char *id)
{
	return(sock_read_pointer(id));
}
void write_pointer(const char *id, void* pdata)
{
	sock_write_pointer(id, pdata);
}
float read_float32(const char *id)
{
	return(sock_read_float32(id));
}
void write_float32(const char *id, float data)
{
	sock_write_float32(id,data);
}
void read_float32_n(const char *id, float* buf, int buf_len)
{
	sock_read_float32_n(id,buf,buf_len);
}

void write_float32_n(const char *id, float* buf, int buf_len)
{
	sock_write_float32_n(id,buf,buf_len);
}

double read_float64(const char *id)
{
	return(sock_read_float64(id));
}
void write_float64(const char *id, double data)
{
	sock_write_float64(id,data);
}
void read_float64_n(const char *id, double* buf, int buf_len)
{
	sock_read_float64_n(id,buf,buf_len);
}

void write_float64_n(const char *id, double* buf, int buf_len)
{
	sock_write_float64_n(id,buf,buf_len);
}


