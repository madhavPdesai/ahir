#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <Pipes.h>
#include <SocketLib.h>
void decode();
void execute();
void fetch();
uint8_t mem_load__(uint32_t address);
void mem_store__(uint32_t address,uint8_t data);
uint16_t read_from_mem(uint16_t mem_addr);
void run();
void write_to_mem(uint16_t mem_addr,uint16_t mem_data);
