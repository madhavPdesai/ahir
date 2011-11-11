#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <Pipes.h>
#include <SocketLib.h>
void ahir_packet_free(uint32_t* ptr);
uint32_t* ahir_packet_get();
void free_queue_manager();
void global_storage_initializer_();
uint8_t mem_load__(uint32_t address);
void mem_store__(uint32_t address,uint8_t data);
void output_port_lookup();
void wrapper_input();
void wrapper_output();
