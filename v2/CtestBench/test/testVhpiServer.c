#include <SocketLib.h>
#include <Vhpi.h>
#include <signal.h>


uint32_t pipe_data_in, pipe_data, foo_data;
uint8_t pipe_has_data, foo_is_called;
int cycle_count;
char* save_ptr = NULL;
uint8_t inpipe_req, outpipe_req, foo_req;

void Exit(int sig)
{
	fprintf(stderr, "## Break! ##\n");
	exit(0);
}


void do_foo_req()
{
  uint8_t port_buffer[1024];
  uint8_t val_buffer[1024];

  fprintf(stderr,"Info: (%d) in do_foo_req..\n", cycle_count);

  // now get req.
  sprintf(port_buffer,"foo req");
  Vhpi_Get_Port_Value(port_buffer,val_buffer,1);
  foo_req = get_uint8_t(val_buffer,&save_ptr);
  if(foo_req)
    {
      fprintf(stderr,"Info: (%d) foo req observed as asserted\n", cycle_count);
      sprintf(port_buffer,"foo 0");
      Vhpi_Get_Port_Value(port_buffer,val_buffer,1);
      foo_data = get_uint32_t(val_buffer,&save_ptr);
      fprintf(stderr,"Info: (%d) foo argument value is %d..\n", cycle_count, foo_data);
    }
}

void do_foo_ack()
{
  uint8_t port_buffer[1024];
  uint8_t val_buffer[1024];

  fprintf(stderr,"Info: (%d) in do_foo_ack..\n", cycle_count);

  if(foo_req)
    {
      // set ack to 1
      sprintf(port_buffer,"foo ack");
      sprintf(val_buffer,"1");
      Vhpi_Set_Port_Value(port_buffer,val_buffer,1);
      foo_is_called = 0;

      fprintf(stderr,"Info: (%d) foo ack asserted..\n", cycle_count);
    }
  else
    {
      // set ack to 0
      sprintf(port_buffer,"foo ack");
      sprintf(val_buffer,"0");
      Vhpi_Set_Port_Value(port_buffer,val_buffer,1);

      fprintf(stderr,"Info: (%d) foo ack de-asserted..\n", cycle_count);
    }

  // foo returns in to out.
  val_buffer[0] = 0;
  sprintf(port_buffer,"foo 0");
  append_uint32_t(val_buffer,foo_data);
  Vhpi_Set_Port_Value(port_buffer,val_buffer,32);

  fprintf(stderr,"Info: (%d) foo return value set to %d..\n", cycle_count, foo_data);
}

void do_out_pipe_req()
{
  fprintf(stderr,"Info: (%d) in do_out_pipe_req..\n", cycle_count);
  uint8_t port_buffer[1024];
  uint8_t val_buffer[1024];

  // now get req.
  sprintf(port_buffer,"outpipe req");
  Vhpi_Get_Port_Value(port_buffer,val_buffer,1);
  outpipe_req = get_uint8_t(val_buffer,&save_ptr);

  if(outpipe_req > 0)
    {
      fprintf(stderr,"Info: (%d) outpipe req observed as asserted..\n",cycle_count);
    }
}

void do_out_pipe_ack()
{
  fprintf(stderr,"Info: (%d) in do_out_pipe_ack..\n", cycle_count);
  uint8_t port_buffer[1024];
  uint8_t val_buffer[1024];

  if(pipe_has_data && outpipe_req)
    {
      // set ack to 1
      sprintf(port_buffer,"outpipe ack");
      sprintf(val_buffer,"1");
      Vhpi_Set_Port_Value(port_buffer,val_buffer,1);
      pipe_has_data = 0;
      fprintf(stderr,"Info: (%d) outpipe ack asserted..\n", cycle_count);
    }
  else
    {
      // set ack to 0
      sprintf(port_buffer,"outpipe ack");
      sprintf(val_buffer,"0");
      Vhpi_Set_Port_Value(port_buffer,val_buffer,1);
      fprintf(stderr,"Info: (%d) outpipe ack de-asserted..\n", cycle_count);
    }

  // write pipe_data to out..
  val_buffer[0] = 0;
  sprintf(port_buffer,"outpipe 0");
  append_uint32_t(val_buffer,pipe_data);
  Vhpi_Set_Port_Value(port_buffer,val_buffer,32);
  fprintf(stderr,"Info: (%d) outpipe data set to %d..\n", cycle_count, pipe_data);
}

void do_in_pipe_req()
{

  fprintf(stderr,"Info: (%d) in do_in_pipe_req..\n", cycle_count);
  char ack_flag = 0;

  uint8_t port_buffer[1024];
  uint8_t val_buffer[1024];

  sprintf(port_buffer,"inpipe req");
  Vhpi_Get_Port_Value(port_buffer,val_buffer,1);
  inpipe_req = get_uint8_t(val_buffer,&save_ptr);

  if(inpipe_req)
    {
      fprintf(stderr,"Info: (%d) inpipe req observed as asserted..\n", cycle_count);
    }

  sprintf(port_buffer,"inpipe 0");
  Vhpi_Get_Port_Value(port_buffer,val_buffer,32);
  pipe_data_in = get_uint32_t(val_buffer,&save_ptr);
  fprintf(stderr,"Info: (%d) read inpipe data %d..\n", cycle_count, pipe_data);
}

void do_in_pipe_ack()
{

  fprintf(stderr,"Info: (%d) in do_in_pipe_ack..\n", cycle_count);
  char ack_flag = 0;

  uint8_t port_buffer[1024];
  uint8_t val_buffer[1024];

  if(inpipe_req && !pipe_has_data)
    {
      // set ack to 1
      sprintf(port_buffer,"inpipe ack");
      ack_flag = 1;

      sprintf(val_buffer,"1");
      Vhpi_Set_Port_Value(port_buffer,val_buffer,1);
      fprintf(stderr,"Info: (%d) inpipe ack asserted..\n", cycle_count);

      pipe_has_data = 1;
      pipe_data = pipe_data_in;
    }
  else
    {
      // set ack to 1
      sprintf(port_buffer,"inpipe ack");
      sprintf(val_buffer,"0");
      Vhpi_Set_Port_Value(port_buffer,val_buffer,1);
      fprintf(stderr,"Info: (%d) inpipe ack de-asserted..\n", cycle_count);
    }
}

int main(int argc, char* argv[])
{

  fprintf(stderr,"Usage: Server <num-cycles>\n");

  int climit = 10;

  signal(SIGINT,  Exit);
  signal(SIGTERM, Exit);

  Vhpi_Initialize();

  if(argc > 1)
    climit = atoi(argv[1]);

  cycle_count = 0;
  pipe_has_data = 0;
  foo_is_called = 0;
  inpipe_req = 0;
  outpipe_req = 0;

  while(cycle_count < climit)
    {

      // phase 1
      Vhpi_Listen();
      Vhpi_Send();

      // phase 2
      do_foo_req();
      do_out_pipe_req();
      do_in_pipe_req();

      do_foo_ack();
      do_out_pipe_ack();
      do_in_pipe_ack();

      cycle_count++;

    }
  return(0);
}
