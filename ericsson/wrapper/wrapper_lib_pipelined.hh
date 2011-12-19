#include <stdint.h>
void send_packet_pipeline(); // in wrapper_lib.aa
void receive_packet_pipeline();  // in wrapper_lib.aa
uint32_t ahir_packet_get(); // in wrapper_lib.aa
void ahir_packet_free(uint32_t pkt); // in wrapper_lib.aa
