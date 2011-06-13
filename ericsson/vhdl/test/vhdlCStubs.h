#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <SocketLib.h>
void foo();
void in_ctrl_module();
void in_data_module();
uint8_t mem_load__(uint32_t address);
void mem_store__(uint32_t address,uint8_t data);
void out_ctrl_module();
void out_data_module();
