#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <iolib.h>
#include "wrapper_lib.hh"


// Copied from click/include/click/packet.hh
#define BRAM_MASK ((uintptr_t)(0x7ff)) // 11 LSBs for a 2kb BRAM
#define BRAM_SIZE (BRAM_MASK + 1)
#define BRAM_START(p) ((uintptr_t)(p) & ~BRAM_MASK)
#define BRAM_END(p) ((uintptr_t)(p) | BRAM_MASK)

#define FREE_QUEUE_SIZE 8
#define RAM_SIZE (FREE_QUEUE_SIZE * BRAM_SIZE)

typedef struct free_queue_ram_block {
    uint8_t block[BRAM_SIZE];
} fqrb_t;

fqrb_t free_queue_ram[FREE_QUEUE_SIZE];

#define WORD_SWAPPING 1

void global_storage_initializer_();  // generated automatically by link-ext-mem


void free_queue_init()
{

    // charge free_queue_pipe..  its depth must be = FREE_QUEUE_SIZE
    for (int i = 0; i < FREE_QUEUE_SIZE; ++i) {
	write_uint32("free_queue_pipe", ((uint32_t) (&(free_queue_ram[i].block[0]))));
    }

}

void wrapper_input()
{
    uint32_t buf;
    int word;

    global_storage_initializer_();
    free_queue_init();

    while (1) {
        buf =  ahir_packet_get();
	receive_packet(buf); // in wrapper_lib.aa


        // Write out packet to FromFPGA element.
        write_uintptr("fromfpga_in0", (uint32_t*) buf);
    }
}

void wrapper_output()
{

    while (1) {
        uint16_t i;
        uint32_t pkt;

        // Get a pointer to the packet data from the ToFPGA element.
        uint32_t port_number = read_uint32("tofpga_port_number");

        switch (port_number) {
#ifdef PORT0
            case 1:
                pkt = (uint32_t)read_uintptr("tofpga0_out0");
                break;
#endif
#ifdef PORT1
            case 2:
                pkt = (uint32_t)read_uintptr("tofpga1_out0");
                break;
#endif
#ifdef PORT2
            case 3:
                pkt = (uint32_t)read_uintptr("tofpga2_out0");
                break;
#endif
#ifdef PORT3
            case 4:
                pkt = (uint32_t)read_uintptr("tofpga3_out0");
                break;
#endif
        }

	send_packet(pkt); // in wrapper_lib.aa

        // Free memory.
	ahir_packet_free((uint32_t) pkt); // in wrapper_lib.aa
    }
}
