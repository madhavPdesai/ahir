#include <vhdlCStubs.h>
void maxDaemon()
{
char buffer[1024];  char* ss;  sprintf(buffer, "call maxDaemon ");
append_int(buffer,0); ADD_SPACE__(buffer);
append_int(buffer,0); ADD_SPACE__(buffer);
send_packet_and_wait_for_response(buffer,strlen(buffer)+1,"localhost",9999);
return;
}
