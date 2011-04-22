#ifndef __Vhpi_h__
#define __Vhpi_h__

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

  int socket_id;

  char* name;

  Port* req_port;
  Port* ack_port;

  PortList inports;
  PortList outports;

  JobLink* next;
  JobLink* prev;
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
void   Vhpi_Set_Register(char* reg_name, char* reg_value);
void   Vhpi_Get_Register(char* reg_name, char* reg_value);

#endif // _Vhpi_h

