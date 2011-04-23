#include <vhdlCStubs.h>
uint32_t bar(uint32_t a)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call bar ");
append_int(buffer,1);
append_uint32_t(buffer,a);
append_int(buffer,1);
append_int(buffer,32);
send_packet_and_wait_for_response(buffer,"localhost",9999);
uint32_t ret_val__ = get_uint32_t(buffer,&ss);
return(ret_val__);
}
uint32_t foo(uint32_t a)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call foo ");
append_int(buffer,1);
append_uint32_t(buffer,a);
append_int(buffer,1);
append_int(buffer,32);
send_packet_and_wait_for_response(buffer,"localhost",9999);
uint32_t ret_val__ = get_uint32_t(buffer,&ss);
return(ret_val__);
}
