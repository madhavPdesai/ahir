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
// Author: Madhav Desai
// 
#include <string.h>
#include <assert.h>
#ifdef USE_GNUPTH
#include <pth.h>
#endif
#include <fcntl.h>
#include <SocketLib.h>

#define __SLEEP__(n) usleep(n)

void ADD_SPACE__(char* buf)
{
   int len = strlen(buf);
   buf[len] = ' ';
   buf[len+1] = 0;
}

// get a string out of  the string buffer.
char*    get_string(char* str, char** save_str)
{
  return(strtok_r(str," ", save_str));
}
void  append_string(char* strbuf, char* str)
{
  strcat(strbuf,str);
}

// str is a sequence of '0' and '1'.
uint64_t get_uint64_t(char* str, char** save_str)
{
#ifdef DEBUG
  if(str != NULL)
  	fprintf(stderr, "Info: in get_uint64_t, received string %s\n",str);
#endif

  char* pstr = strtok_r(str," ", save_str);
  if(pstr == NULL)
  {
	fprintf(stderr,"Error: tried to parse empty string in get_ function\n");
	return(0);
  }

#ifdef DEBUG
  fprintf(stderr, "Info: in get_uint64_t, received string %s\n",pstr);
#endif

  uint64_t ret_val  = 0;
  int max_index = strlen(pstr) - 1;
  uint64_t pos = 0;
  while(max_index >= 0)
    {
      if(pstr[max_index] == '1') 
	{
	  ret_val |= (((uint64_t) 1) << pos);
	}

      pos++;
      max_index--;

      if(pos == 64)
	break;
    }

  return(ret_val);
}
uint32_t get_uint32_t(char* str, char** save_str)
{
  return((uint32_t)(get_uint64_t(str, save_str)));
}

uint16_t get_uint16_t(char* str, char** ss)
{
  return((uint16_t)(get_uint64_t(str,ss)));
}

uint8_t  get_uint8_t(char* str, char** ss)
{
  return((uint8_t)(get_uint64_t(str,ss)));
}

float get_float(char* str, char** ss)
{
  uint32_t u = get_uint32_t(str,ss);
  float* ret_val_ptr = (float*)&u;
  float ret_val = *ret_val_ptr;
  return(ret_val);
}

double   get_double(char* str, char** ss)
{
  uint64_t u = get_uint64_t(str,ss);
  
  double* ret_val_ptr = ((double*) &u);
  double ret_val = *ret_val_ptr;
  return(ret_val);
}


// time-bomb ?  str may overflow..
void  append_uint64_t_inner(char* str, uint64_t u, int W)
{
  char* tbuf;
  int idx;

  tbuf = (char*) malloc((W+1)*sizeof(char));

  // null terminate
  for(idx = 0; idx < W; idx++)
    tbuf[idx] = '0';
  tbuf[W] = 0;

  int pos = 0;

  while(pos < W)
    {
      if((u >> pos) & 1)
	{
	  tbuf[(W-1)-pos] = '1';
	}

      pos++;
    }

  strcat(str, tbuf);
}

void  append_uint64_t(char* str, uint64_t u)
{
  append_uint64_t_inner(str,u,64);
}

void     append_uint32_t(char* str,uint32_t u)
{
  append_uint64_t_inner(str,(uint32_t)u,32);
}
void     append_uint16_t(char* str, uint16_t u)
{
  append_uint64_t_inner(str,(uint16_t)u,16);
}

void     append_uint8_t(char* str, uint8_t u)
{
  append_uint64_t_inner(str,(uint8_t)u,8);
}
void     append_float(char* str, float f)
{
  append_uint32_t(str, bitcast_float_to_uint32_t(f));
}
void     append_double(char* str, double f)
{
  append_uint64_t(str, bitcast_double_to_uint64_t(f));
}


// append the int in decimal form into the
// string.
void   append_int(char* str, int u)
{
  char buf[16];
  sprintf(buf,"%d",u);
  strcat(str,buf);
}

// useful conversions.
uint32_t bitcast_float_to_uint32_t(float f)
{
  return(*((uint32_t*)(&f)));
}
float    bitcast_uint32_t_to_float(uint32_t u)
{
  return(*((float*)(&u)));
}

uint64_t bitcast_double_to_uint64_t(double f)
{
  return(*((uint64_t*)(&f)));
}

double   bitcast_uint64_t_to_double(uint64_t u)
{
  return(*((double*)(&u)));
}


int extract_payload(char* receive_buffer,char* payload, int max_n)
{
  int hash_pos = 0;
  int ret_val = 0;
  while(receive_buffer[hash_pos] != '#')
    {
      if(receive_buffer[hash_pos] == 0) // end of string
	{
	  hash_pos = -1;
	  break;
	}
      hash_pos++;
    }

  if(hash_pos >= 0)
    {
      receive_buffer[hash_pos] = 0;
      ret_val = max_n - (hash_pos+1);
      bcopy(receive_buffer+(hash_pos+1),payload,ret_val);
    }

  return(ret_val);
}


void print_payload(FILE* log_file,char* send_buffer, int wlength, int nwords)
{
  fprintf(log_file,"Payload \n");
  int i;
  for(i = 0; i < nwords; i++)
    {
      char* ptr = send_buffer + (i*wlength/8);
      switch(wlength)
	{
	case 8:
	  fprintf(log_file,"\t %d\n", *((char*)ptr));
	  break;
	case 16:
	  fprintf(log_file,"\t %d\n", *((uint16_t*)ptr));
	  break;
	case 32:
	  fprintf(log_file,"\t %d\n", *((uint32_t*)ptr));
	  break;
	case 64:
	  fprintf(log_file,"\t %llu\n", *((uint64_t*)ptr));
	  break;
	default:
	  fprintf(log_file,"Error!\n");
	  return;
	}

    }
}

void pack_value(char* payload,int wlength,int offset, char* port_value)
{
  char* ptr = payload + (offset*wlength/8);
  char* ss = NULL;

  switch(wlength)
    {
    case 8:
      *((uint8_t*)ptr) = get_uint8_t(port_value,&ss);
      break;
    case 16:
      *((uint16_t*)ptr) = get_uint16_t(port_value,&ss);
      break;
    case 32:
      *((uint32_t*)ptr) = get_uint32_t(port_value,&ss);
      break;
    case 64:
      *((uint64_t*)ptr) = get_uint64_t(port_value,&ss);
      break;
    default:
      fprintf(stderr,"Error: unsupported data width %d\n", wlength);
      return;
    }
}


void unpack_value(char* payload,int wlength,int offset, char* port_value)
{
  char* ptr = payload + (offset*wlength/8);
  port_value[0] = 0;

  switch(wlength)
    {
    case 8:
      append_uint8_t(port_value, *((uint8_t*)ptr));
      break;
    case 16:
      append_uint16_t(port_value, *((uint16_t*)ptr));
      break;
    case 32:
      append_uint32_t(port_value, *((uint32_t*)ptr));
      break;
    case 64:
      append_uint64_t(port_value, *((uint64_t*)ptr));
      break;
    default:
      fprintf(stderr,"Error: unsupported data width %d\n", wlength);
      return;
    }
}

//
// create a server to listen for messages.
//
int create_server(int port_number, int max_connections)
{
  int sockfd;
  struct sockaddr_in serv_addr;
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  fprintf(stderr, "Info: opening socket for server on port %d \n",port_number);

  if (sockfd < 0)
    fprintf(stderr, "Error: in opening socket on port %d\n", port_number);

  bzero((char *) &serv_addr, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_addr.s_addr = INADDR_ANY;
  serv_addr.sin_port = htons(port_number);

  if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
    {
      fprintf(stderr,"Error: could not bind socket to port %d\n",port_number);
      close(sockfd);
      sockfd= -1;
    }
  else
    fprintf(stderr,"Info: finished binding socket to port %d\n",port_number);

  // start listening on the server.
  listen(sockfd,max_connections);

  return sockfd;
}


//
// ask the server to wait for a client connection
// and accept one connection if possible
// 
// uses select to make this non-blocking.
// 
int connect_to_client(int server_fd)
{
  int ret_val = 1;
  int newsockfd = -1;
  socklen_t clilen;
  struct sockaddr_in  cli_addr;
  fd_set c_set;
  struct timeval time_limit;

  time_limit.tv_sec = 0;
  time_limit.tv_usec = 1000;

  clilen = sizeof(cli_addr);

  FD_ZERO(&c_set);
  FD_SET(server_fd,&c_set);
  select(server_fd+1, &c_set,NULL,NULL,&time_limit);
  if(FD_ISSET(server_fd,&c_set))
    {
#ifdef USE_GNUPTH
      newsockfd = pth_accept(server_fd,(struct sockaddr *) &cli_addr,&clilen);
#else
      newsockfd = accept(server_fd,(struct sockaddr *) &cli_addr,&clilen);
#endif

      if (newsockfd >= 0)
	{
#ifdef DEBUG
	  fprintf(stderr,"Info: new client connection %d \n",newsockfd);
#endif
	}
      else
	{
	  fprintf(stderr,"Info: failed in accept()\n");	
	}
    }

  return(newsockfd);
}


// 
// use select to check if we can write to 
// the socket..
// 
int can_read_from_socket(int socket_id)
{
  struct timeval time_limit;
  time_limit.tv_sec = 0;
  time_limit.tv_usec = 1000;

  fd_set c_set;
  FD_ZERO(&c_set);
  FD_SET(socket_id,&c_set);      

  int npending = select(socket_id + 1, &c_set, NULL,NULL,&time_limit);

  return(FD_ISSET(socket_id,&c_set));
}


// 
// use select to check if we can write to 
// the socket..
// 
int can_write_to_socket(int socket_id)
{
  struct timeval time_limit;
  time_limit.tv_sec = 0;
  time_limit.tv_usec = 1000;

  fd_set c_set;
  FD_ZERO(&c_set);
  FD_SET(socket_id,&c_set);      

  int npending = select(socket_id + 1, NULL, &c_set,NULL,&time_limit);

  return(FD_ISSET(socket_id,&c_set));
}


// receive string from socket and put it inside buffer.
int receive_string(int sock_id, char* buffer, int max_byte_count)
{
  int nbytes = 0;

  assert(max_byte_count <= MAX_BUF_SIZE);

  while(1)
    {
      if(can_read_from_socket(sock_id))
	break;
      else
	__SLEEP__(1000);
    }

  
#ifdef USE_GNUPTH
  nbytes = pth_recv(sock_id,buffer,max_byte_count,0);
#else
  nbytes = recv(sock_id,buffer,max_byte_count,0);
#endif

  return(nbytes);
}



//
// will establish a connection, send the
// packet and block till a response is obtained.
// socket will be closed after the response
// is obtained..
//
// the buffer is used for the sent as well
// as the received data.
//
void send_packet_and_wait_for_response(char* buffer, int send_len, char* server_host_address, int server_port_number)
{
  int sockfd, n;
  struct sockaddr_in serv_addr;
  struct hostent *server;
  
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if (sockfd < 0)
    {
      fprintf(stderr,"Error: could not open client socket\n");
      return;
    }
  
  server = gethostbyname(server_host_address);
  if (server == NULL) 
    {
      fprintf(stderr, "Error: server host %s not found..\n",server_host_address);
      close(sockfd);
      sockfd = -1;
    }
  else
    {
      bzero((char *) &serv_addr, sizeof(serv_addr));
      serv_addr.sin_family = AF_INET;
      bcopy((char *)server->h_addr,(char *) &serv_addr.sin_addr.s_addr,server->h_length);
      serv_addr.sin_port = htons(server_port_number);

#ifdef DEBUG
      fprintf(stderr, "Info: connecting to server %s on port %d .......... \n",
	      server_host_address,
	      server_port_number);
#endif

      n =-1;

      while(n == -1)
      {
#ifdef USE_GNUPTH
	n=pth_connect(sockfd,(struct sockaddr*) &serv_addr,sizeof(serv_addr));
#else
	n=connect(sockfd,(struct sockaddr*) &serv_addr,sizeof(serv_addr));
#endif
      }
      
#ifdef DEBUG
      fprintf(stderr, "Info: successfully connected to server %s on port %d .......... \n",
	      server_host_address,
	      server_port_number);
#endif


      while(1)
	{
	  if(can_write_to_socket(sockfd))
	    break;

	  __SLEEP__(1000);
	}

#ifdef USE_GNUPTH
      pth_send(sockfd,buffer,send_len,0);
#else
      send(sockfd,buffer,send_len,0);
#endif

#ifdef DEBUG
      char payload[MAX_BUF_SIZE];
      int pl = extract_payload(buffer,payload,send_len);
      fprintf(stderr, "Info: sent message %s to server (payload of %d bytes)\n", buffer, pl);
      if(pl > 0)
	print_payload(stderr,payload,8,pl);
#endif
      while( (n = receive_string(sockfd,buffer, MAX_BUF_SIZE)) <= 0)
	{
		__SLEEP__(1000);
	}
	  
#ifdef DEBUG
      fprintf(stderr, "Info: received message %s from server\n", buffer);	  
      print_payload(stderr,buffer,8,n);
#endif
      close(sockfd);
    }
}


void set_non_blocking(int sock_id)
{
  int x;
  x=fcntl(sock_id,F_GETFL,0);
  fcntl(sock_id,F_SETFL,x | O_NONBLOCK);
}
