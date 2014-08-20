#include <vhdlCStubs.h>
float fpadd32(float L,float R)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpadd32 ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_float(buffer,L); ADD_SPACE__(buffer);
append_float(buffer,R); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
float ret_val_x_x = get_float(buffer,&ss);
return(ret_val_x_x);
}
double fpadd64(double L,double R)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpadd64 ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_double(buffer,L); ADD_SPACE__(buffer);
append_double(buffer,R); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,64); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
double ret_val_x_x = get_double(buffer,&ss);
return(ret_val_x_x);
}
float fpmul32(float L,float R)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpmul32 ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_float(buffer,L); ADD_SPACE__(buffer);
append_float(buffer,R); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
float ret_val_x_x = get_float(buffer,&ss);
return(ret_val_x_x);
}
double fpmul64(double L,double R)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpmul64 ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_double(buffer,L); ADD_SPACE__(buffer);
append_double(buffer,R); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,64); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
double ret_val_x_x = get_double(buffer,&ss);
return(ret_val_x_x);
}
float fpsub32(float L,float R)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpsub32 ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_float(buffer,L); ADD_SPACE__(buffer);
append_float(buffer,R); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
float ret_val_x_x = get_float(buffer,&ss);
return(ret_val_x_x);
}
double fpsub64(double L,double R)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpsub64 ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_double(buffer,L); ADD_SPACE__(buffer);
append_double(buffer,R); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,64); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
double ret_val_x_x = get_double(buffer,&ss);
return(ret_val_x_x);
}
float fpu32(float L,float R,uint8_t OP_ID)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpu32 ");
append_int(buffer,3); ADD_SPACE__(buffer);
append_float(buffer,L); ADD_SPACE__(buffer);
append_float(buffer,R); ADD_SPACE__(buffer);
append_uint8_t(buffer,OP_ID); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
float ret_val_x_x = get_float(buffer,&ss);
return(ret_val_x_x);
}
double fpu64(double L,double R,uint16_t OP_ID)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call fpu64 ");
append_int(buffer,3); ADD_SPACE__(buffer);
append_double(buffer,L); ADD_SPACE__(buffer);
append_double(buffer,R); ADD_SPACE__(buffer);
append_uint16_t(buffer,OP_ID); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,64); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
double ret_val_x_x = get_double(buffer,&ss);
return(ret_val_x_x);
}
void get_input()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call get_input ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void global_storage_initializer_()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call global_storage_initializer_ ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void mmultiply()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call mmultiply ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void mmultiply_base()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call mmultiply_base ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void progx_xoptx_xo_storage_initializer_()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call progx_xoptx_xo_storage_initializer_ ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
void send_output()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call send_output ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
