#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>

uint64_t packet_data_buffer[2][256];
uint8_t  packet_control_buffer[2][256];


void get_packet()
{
  uint8_t word_count = 0;
  uint8_t pkt_active = 0;
   
  while(1)
    {
      uint8_t index = read_uint8("free_index_pipe"); // block till you get a free index.
      word_count = 0;

      while(1) // read and store the packet.
	{
	  uint8_t ctrl_val = read_uint8("in_ctrl");
	  uint64_t data_val = read_uint64("in_data");

	  packet_control_buffer[index][word_count] = ctrl_val;
	  packet_data_buffer[index][word_count] = data_val;	

	  if(ctrl_val != 0 && ctrl_val != 0xff)
	    {
	      write_uint8("send_msg", word_count);	
	      break;
	    }
	  
	  word_count++;
    	}
    }
}

void send_packet()
{
  uint8_t free_index = 0;
  write_uint8("free_index_pipe", free_index); // publish the free index.
  while(1)
    {
      uint8_t word_count = read_uint8("send_msg"); // wait for a message..
      write_uint8("free_index_pipe", 1 - free_index); // release the other buffer.

      int wc;
      for(wc = 0; wc <= word_count; wc++)
	{
	  uint8_t ctrl_val = packet_control_buffer[free_index][wc];
	  uint64_t data_val = packet_data_buffer[free_index][wc];

	  write_uint8("out_ctrl",ctrl_val);
	  write_uint64("out_data", data_val);
	}

      free_index = 1 - free_index;
    }
}

