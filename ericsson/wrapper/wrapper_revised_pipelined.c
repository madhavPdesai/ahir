#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <iolib.h>
#include "wrapper_lib_pipelined.hh"

// Copied from click/include/click/packet.hh
#define BRAM_MASK ((uintptr_t)(0x7ff)) // 11 LSBs for a 2kb BRAM
#define BRAM_SIZE (BRAM_MASK + 1)
#define BRAM_START(p) ((uintptr_t)(p) & ~BRAM_MASK)
#define BRAM_END(p) ((uintptr_t)(p) | BRAM_MASK)

#define FREE_QUEUE_SIZE 16
#define RAM_SIZE (FREE_QUEUE_SIZE * BRAM_SIZE)

typedef struct free_queue_ram_block {
    uint8_t block[BRAM_SIZE];
} fqrb_t;

fqrb_t free_queue_ram[FREE_QUEUE_SIZE];

#define WORD_SWAPPING 1

void global_storage_initializer_(); // generated automatically by link-ext-mem

void free_queue_init()
{
    // charge free_queue_pipe..  its depth must be = FREE_QUEUE_SIZE
    for (int i = 0; i < FREE_QUEUE_SIZE; ++i) {
        write_uint32("free_queue_pipe",
                     ((uint32_t)(&(free_queue_ram[i].block[0]))));
    }
}

// wrapper input does not do much now.  It does some
// initializes and starts listening on receive_packet_pipe.
// (receive_packet_pipe is fed from receive_packet_pipeline
// in wrapper_lib_pipelined.aa).
// whatever is received is forwarded to fromfpga_in0
void wrapper_input()
{
    uint8_t *buf;
    int word;

    global_storage_initializer_();
    free_queue_init();

    while(1)
    {
	// wait to receive packet buffer pointer from receive_packet_pipeline.
	// and forward to fromfpga
    	uint32_t* buf = read_uintptr("receive_packet_pipe");
	write_uintptr("fromfpga_in0", buf);
    }
}

// wrapper_output gets the packet pointer 
// and forwards it to send_packet_pipe.
// The send_packet_pipeline in wrapper_lib_pipelined.aa
// does the rest (forwarding data out to out_data).
void wrapper_output()
{
    while (1) {
        uint16_t i;
        uint8_t *pkt;

        // Get a pointer to the packet data from the ToFPGA element.
        uint32_t port_number = read_uint32("tofpga_port_number");

        switch (port_number) {
#ifdef PORT0
            case 1:
#ifdef MODELSIM_TESTBENCH
                write_uint32("printf_debug_pipe", 0xbeef01);
#endif
                pkt = (uint8_t *)read_uintptr("tofpga0_out0");
                break;
#endif
#ifdef PORT1
            case 2:
#ifdef MODELSIM_TESTBENCH
                write_uint32("printf_debug_pipe", 0xbeef02);
#endif
                pkt = (uint8_t *)read_uintptr("tofpga1_out0");
                break;
#endif
#ifdef PORT2
            case 3:
#ifdef MODELSIM_TESTBENCH
                write_uint32("printf_debug_pipe", 0xbeef03);
#endif
                pkt = (uint8_t *)read_uintptr("tofpga2_out0");
                break;
#endif
#ifdef PORT3
            case 4:
#ifdef MODELSIM_TESTBENCH
                write_uint32("printf_debug_pipe", 0xbeef04);
#endif
                pkt = (uint8_t *)read_uintptr("tofpga3_out0");
                break;
#endif
        }

	// forward to send packet pipeline.
        write_uint32("send_packet_pipe",(uint32_t) pkt);
    }
}
