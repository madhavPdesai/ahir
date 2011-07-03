#include <stdio.h>
#include <stdint.h>
#include <iolib.h>
#define SRC_MASK 0xffff0000
#define DEST_MASK (((uint64_t) 0xffff) << 48)
void output_port_lookup()
{
      uint8_t ctrl;
      uint64_t data;
      while(1)
      {
	ctrl = read_uint8("in_ctrl");
	data = read_uint64("in_data");

	if(ctrl == 0xff)
	{
		uint16_t src_id = ((data & SRC_MASK) >> 16);
		uint16_t decoded_src = (1 << src_id);
		uint64_t dest_id = ((src_id & 0x1) ? (decoded_src >> 1) : (decoded_src << 1));

		data = (data & ~DEST_MASK) | (dest_id << 48);
	}

	write_uint8("out_ctrl",ctrl);
	write_uint64("out_data",data);
      }
}
