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
#ifndef __SOCKETLIB__
#define __SOCKETLIB__

//
// author: Madhav Desai
// some useful utilities to pack unpack data
// and send it a server on the local machine.
//

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>


// should be enough..
#define MAX_BUF_SIZE (16*4096)

// by default, we will stick to 9999
#define DEFAULT_SERVER_PORT  9999

// unlikely to have more than 16 active
// threads talking to the TB?
#define DEFAULT_MAX_CONNECTIONS 65535

void  ADD_SPACE__(char* buf);

// get a string out of  the string buffer.
char*    get_string(char* str, char** save_str);
void     append_string(char* str_buf, char* str);

// str is a sequence of '0' and '1'.
uint64_t get_uint64_t(char* str, char** save_str);
uint32_t get_uint32_t(char* str, char** save_str);
uint16_t get_uint16_t(char* str, char** save_str);
uint8_t  get_uint8_t(char* str, char** save_str);
float    get_float(char* str, char** save_str);
double   get_double(char* str, char** save_str);

void     append_uint64_t(char* str, uint64_t u);
void     append_uint32_t(char* str, uint32_t u);
void     append_uint16_t(char* str, uint16_t u);
void     append_uint8_t(char* str, uint8_t u);
void     append_float(char* str, float f);
void     append_double(char* str, double f);

#define get_int64_t(p,q)  ((int64_t)get_uint64_t(p,q))
#define get_int32_t(p,q)  ((int32_t)get_uint32_t(p,q))
#define get_int16_t(p,q)  ((int16_t)get_uint16_t(p,q))
#define get_int8_t(p,q)   ((int8_t)get_uint8_t(p,q))
#define append_int64_t(p,q)  append_uint64_t(p,q)
#define append_int32_t(p,q)  append_uint32_t(p,q)
#define append_int16_t(p,q)  append_uint16_t(p,q)
#define append_int8_t(p,q)   append_uint8_t(p,q)

// append the int in decimal form into the
// string.
void     append_int(char* str, int u);

// useful conversions.
uint32_t bitcast_float_to_uint32_t(float f);
float    bitcast_uint32_t_to_float(uint32_t u);
uint64_t bitcast_double_to_uint64_t(double f);
double   bitcast_uint64_t_to_double(uint64_t u);

// payload handling..
int extract_payload(char* receive_buffer,char* payload, int max_n);
void print_payload(FILE* log_file,char* send_buffer, int wlength, int nwords);
void pack_value(char* payload,int wlength,int offset, char* port_value);
void unpack_value(char* payload,int wlength,int offset, char* port_value);

//
// create a server to listen for messages.
//
int create_server(int port_number, int max_connections);


//
// ask the server to wait for a client connection
// and accept one connection if possible
// 
// uses select to make this non-blocking.
// 
int connect_to_client(int server_fd);


// 
// use select to check if we can read from
// the socket..
//
int can_read_from_socket(int socket_id);

// 
// use select to check if we can write to 
// the socket..
// 
int can_write_to_socket(int socket_id);


// receive string from socket and put it inside buffer.
int receive_string(int n, char* buffer, int max_byte_count);

//
// will establish a connection, send the
// packet and block till a response is obtained.
// socket will be closed after the response
// is obtained..
//
// the buffer is used for the sent as well
// as the received data.
//
void  send_packet_and_wait_for_response(char* buffer, int send_length, char* server_host_name, int server_port_number);



// set a socket into non-blocking mode
void set_non_blocking(int sock_id);

#endif 
