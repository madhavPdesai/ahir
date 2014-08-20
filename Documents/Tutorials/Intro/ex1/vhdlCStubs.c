#include <vhdlCStubs.h>
uint32_t maxOfTwo(uint32_t a,uint32_t b)
{
char buffer[1024];  char* ss;  sprintf(buffer, "call maxOfTwo ");
append_int(buffer,2); ADD_SPACE__(buffer);
append_uint32_t(buffer,a); ADD_SPACE__(buffer);
append_uint32_t(buffer,b); ADD_SPACE__(buffer);
append_int(buffer,1); ADD_SPACE__(buffer);
append_int(buffer,32); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
uint32_t ret_val__ = get_uint32_t(buffer,&ss);
return(ret_val__);
}
