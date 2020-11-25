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
#ifndef __Vhpi_h__
#define __Vhpi_h__

#include <stdint.h>

#define MAX_PAYLOAD_LENGTH 	(16*4096)

// author: Madhav P. Desai
// jacket functions to enable VHPI direct interface
// to VHDL only simulators supporting VHPI.  

typedef struct _Port Port;
struct _Port
{
  int index;
  int width;
  char* port_value;
};

typedef struct _PortLink PortLink;
struct _PortLink
{
  Port* port;
  PortLink* next;
  PortLink* prev;
};


typedef struct _PortList PortList;
struct _PortList
{
  PortLink* head;
  PortLink* tail;
};

typedef struct _JobLink JobLink;
struct _JobLink
{
  char is_pipe_read_access;
  char is_pipe_write_access;
  char is_module_access;
  char request_sent;
  char ack_received;

  // burst related stuff..
  char is_burst_access;
  int word_length; // in bytes
  int number_of_words_requested;

  char ack_leads_req;
  char increment_word_count;
  int active_word_count;
  
  char payload[MAX_PAYLOAD_LENGTH];


  int socket_id;

  char* name;
  Port* req_port;
  Port* ack_port;

  PortList inports;
  PortList outports;

  JobLink* next;
  JobLink* prev;

  int64_t index;
};

typedef struct _JobList JobList;
struct _JobList
{
  JobLink* head;
  JobLink* tail;
};

void   Vhpi_Initialize();
void   Vhpi_Close();
void   Vhpi_Listen();
void   Vhpi_Send();
void   Vhpi_Set_Port_Value(char* reg_name, char* reg_value, int reg_width);
void   Vhpi_Get_Port_Value(char* reg_name, char* reg_value, int reg_width);
void   Vhpi_Log(char* message_string);


// the a$*@&% at Mentor do not support VHPI.
#ifdef MODELSIM

#include <mti.h>
void Modelsim_FLI_Initialize();
void Modelsim_FLI_Close();
void Modelsim_FLI_Listen();
void Modelsim_FLI_Send();
void Modelsim_FLI_Set_Port_Value(mtiVariableIdT reg_id, mtiVariableIdT reg_val_id, int reg_width);
void Modelsim_FLI_Get_Port_Value(mtiVariableIdT reg_id, mtiVariableIdT reg_val_id, int reg_width);
void Modelsim_FLI_To_String(char* ret_string, mtiVariableIdT vsim_str);
void String_To_Modelsim_FLI(mtiVariableIdT vsim_str, char* from_string);
void Modelsim_FLI_Log(mtiVariableIdT vsim_str);

#endif

#endif // _Vhpi_h

