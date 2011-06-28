#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

uint64_t packet_data_buffer[2][256];
uint8_t  packet_control_buffer[2][256];

uint32_t store_packet(uint8_t* cptr, uint64_t* dptr);
void remove_packet(uint8_t* cptr, uint64_t* dptr, uint32_t pkt_length);

void get_packet()
{
  while(1)
    {
      uint32_t index = read_uint32("free_index_pipe"); // block till you get a free index.

      uint8_t* cptr = &(packet_control_buffer[index][0]);
      uint64_t* dptr = &(packet_data_buffer[index][0]);

      uint32_t  word_count = store_packet(cptr,dptr);
      write_uint32("send_msg", word_count);	
    }
}


void send_packet()
{
  uint32_t free_index = 0;
  write_uint32("free_index_pipe", free_index); // publish the free index.
  while(1)
    {
      uint32_t word_count = read_uint32("send_msg"); // wait for a message..
      write_uint32("free_index_pipe", 1 - free_index); // release the other buffer.
      uint8_t* cptr = &(packet_control_buffer[free_index][0]);
      uint64_t* dptr = &(packet_data_buffer[free_index][0]);

      remove_packet(cptr,dptr, word_count);
      free_index = 1 - free_index;
    }
}

