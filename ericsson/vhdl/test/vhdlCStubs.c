#include <vhdlCStubs.h>
void foo()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call foo ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void in_ctrl_module()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call in_ctrl_module ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void in_data_module()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call in_data_module ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void out_ctrl_module()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call out_ctrl_module ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void out_data_module()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call out_data_module ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
