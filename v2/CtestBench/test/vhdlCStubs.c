#include <vhdlCStubs.h>
#include <stdio.h>
uint32_t foo(uint32_t a)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call foo ");
append_int(buffer,1);ADD_SPACE__(buffer);
append_uint32_t(buffer,a);ADD_SPACE__(buffer);
append_int(buffer,1);ADD_SPACE__(buffer);
append_int(buffer,32);ADD_SPACE__(buffer);

send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint32_t ret_val__ = get_uint32_t(buffer,&ss);
return(ret_val__);
}
