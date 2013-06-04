#ifndef __Vhpi_h__
#define __Vhpi_h__

#include <stdint.h>

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
  
  char* payload;


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

