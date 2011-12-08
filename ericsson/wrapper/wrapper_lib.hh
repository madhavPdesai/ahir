#include <stdint.h>
uint64_t swap_bytes64(uint64_t x);   // in wrapper_lib.aa
void send_packet(uint32_t pkt); // in wrapper_lib.aa
void receive_packet(uint32_t buf);  // in wrapper_lib.aa
uint32_t ahir_packet_get(); // in wrapper_lib.aa
void ahir_packet_free(uint32_t pkt); // in wrapper_lib.aa
void send_packet_noswap(uint32_t pkt); // in wrapper_lib.aa
void receive_packet_noswap(uint32_t buf);  // in wrapper_lib.aa
