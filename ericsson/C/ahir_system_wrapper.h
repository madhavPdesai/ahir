#include <stdlib.h>
#include <stdint.h>
#include <iolib.h>
#include <stdio.h>


#define FREE_LIST_PUT 1
#define FREE_LIST_GET 2

#define FREE_LIST_SIZE 2
#define MAX_PKT_SIZE 4096


// Pipe names
#define NETFPGA_INCOMING_DATA "in_data"   // data in to NetFPGA wrapper
#define NETFPGA_INCOMING_CONTROL "in_ctrl" // control in to NetFPGA wrapper

#define NETFPGA_OUTGOING_DATA "out_data" // data out from NetFPGA wrapper
#define NETFPGA_OUTGOING_CONTROL "out_ctrl" // control out from NetFPGA wrapper

#define TO_AHIR_SYSTEM  "fromfpga_in0"
#define FROM_AHIR_SYSTEM "dst_out0"

#define DATA_OFFSET_IN_PACKET   8       // bytes.

#define WORD_LENGTH_MASK        0x00ff0000 // bits 47 downto 32
#define BYTE_LENGTH_MASK        0x000000ff // bits 15 downto 0

typedef struct Link_ Link;


struct Link_
{
	Link* next;
	uint8_t pkt[MAX_PKT_SIZE];
};

void free_queue_manager();
void input_module();
void output_module();
