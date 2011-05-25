#include <vhdlCStubs.h>
uint32_t bar(uint32_t a)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call bar ");
append_int(buffer,1); ADD_SPACE__(buffer);
append_uint32_t(buffer,a); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint32_t ret_val__ = get_uint32_t(buffer,&ss);
return(ret_val__);
}
uint32_t foo(uint32_t a)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call foo ");
append_int(buffer,1); ADD_SPACE__(buffer);
append_uint32_t(buffer,a); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint32_t ret_val__ = get_uint32_t(buffer,&ss);
return(ret_val__);
}
uint8_t mem_load__(uint32_t address)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call mem_load__ ");
append_int(buffer,1); ADD_SPACE__(buffer);
append_uint32_t(buffer,address); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,8); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint8_t data = get_uint8_t(buffer,&ss);
return(data);
}
void mem_store__(uint32_t address,uint8_t data)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call mem_store__ ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_uint32_t(buffer,address); ADD_SPACE__(buffer);
append_uint8_t(buffer,data); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
