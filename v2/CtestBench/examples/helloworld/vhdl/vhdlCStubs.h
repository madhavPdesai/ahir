#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <Pipes.h>
#include <SocketLib.h>
uint32_t bar(uint32_t a);
uint32_t foo(uint32_t a);
uint8_t mem_load__(uint32_t address);
void mem_store__(uint32_t address,uint8_t data);
