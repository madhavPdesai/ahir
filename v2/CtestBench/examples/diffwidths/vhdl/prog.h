#define WRITE_UINT8_N(pipe_id,buf,len)  {int _I=0; while(_I < len) { write_uint8(pipe_id,*(((char*)buf)+_I)); _I++ ;}}
void io_module();
