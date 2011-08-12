#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <iolib.h>

#define BRAM_MASK ((uintptr_t)(0x7ff)) // 11 LSBs for a 2kb BRAM
#define BRAM_SIZE (BRAM_MASK + 1)
#define BRAM_START(p) ((uintptr_t)(p) & ~BRAM_MASK)
#define BRAM_END(p) ((uintptr_t)(p) | BRAM_MASK)

#define FREE_QUEUE_SIZE 16
#define RAM_SIZE (FREE_QUEUE_SIZE * BRAM_SIZE)
#define FREE_QUEUE_PUT 1
#define FREE_QUEUE_GET 2
#define FREE_QUEUE_OK  3
#define FREE_QUEUE_FAIL  4

uint32_t* ahir_packet_get()
{
    uint32_t* buf;

start:
    // Get a free memory slot for a packet.
    write_uint8("free_queue_request", FREE_QUEUE_GET);
    if (read_uint8("free_queue_ack") == FREE_QUEUE_OK) {
        buf = (uint32_t*) read_uint32("free_queue_get");
    } else {
        goto start;
    }

    return buf;
}

void ahir_packet_free(uint32_t* ptr)
{
    write_uint8("free_queue_request", FREE_QUEUE_PUT);
    write_uint32("free_queue_put", (uint32_t) ptr);
}


uint8_t free_queue_ram[RAM_SIZE];
uint8_t free_queue[FREE_QUEUE_SIZE];

void free_queue_manager()
{
    int i;

    for (i = 0; i < FREE_QUEUE_SIZE; ++i) {
        free_queue[i] = 1;
    }

    while (1) {
        uint8_t command = read_uint8("free_queue_request");
        if (command == FREE_QUEUE_GET) {
            int i, found = 0;
            uint32_t ptr;
            for (i = 0; i < FREE_QUEUE_SIZE; ++i) {
                if (free_queue[i] == 1) {
                    ptr = (uint32_t)(free_queue_ram + i * BRAM_SIZE);
                    free_queue[i] = 0;
                    found = 1;
                    break;
                }
            }
            if (found == 1) {
                write_uint8("free_queue_ack", FREE_QUEUE_OK);
                write_uint32("free_queue_get", ptr);
            } else {
                write_uint8("free_queue_ack", FREE_QUEUE_FAIL);
            }
        }       
        else if (command == FREE_QUEUE_PUT) {
            uint32_t ptr = read_uint32("free_queue_put");
            int i = 0;
            while (ptr > ((i + 1) * BRAM_SIZE))
                i++;
            if (i < FREE_QUEUE_SIZE)
                free_queue[i] = 1;
        }
    }
}

void wrapper_input()
{
    while (1) {
        uint8_t *buf = (uint8_t *)ahir_packet_get();
        int word = 0;

        // Pointer to packet data. See click/packet.hh.
        uint8_t *pkt_data = (buf + 180);

        while (1) {
            // Read data and ctrl from NetFPGA.
            uint64_t indata = read_uint64("in_data");
            uint8_t  inctrl = read_uint8("in_ctrl");

            // We swap bytes on input and back on output, as NetFPGA
            // uses a different order than Click.
            uint8_t *p = (uint8_t *)&indata;

            switch (inctrl) {
                case 0xff: // IOQ
                    buf[0] = p[7];
                    buf[1] = p[6];
                    buf[2] = p[5];
                    buf[3] = p[4];
                    buf[4] = p[3];
                    buf[5] = p[2];
                    buf[6] = p[1];
                    buf[7] = p[0];
                    break;
                case 0x00: // Data
                    pkt_data[word * 8 + 0] = p[7];
                    pkt_data[word * 8 + 1] = p[6];
                    pkt_data[word * 8 + 2] = p[5];
                    pkt_data[word * 8 + 3] = p[4];
                    pkt_data[word * 8 + 4] = p[3];
                    pkt_data[word * 8 + 5] = p[2];
                    pkt_data[word * 8 + 6] = p[1];
                    pkt_data[word * 8 + 7] = p[0];
                    word++;
                    break;
                case 0x01: // Last word, 8 bytes
                case 0x02: // Last word, 7 bytes
                case 0x04: // Last word, 6 bytes
                case 0x08: // Last word, 5 bytes
                case 0x10: // Last word, 4 bytes
                case 0x20: // Last word, 3 bytes
                case 0x40: // Last word, 2 bytes
                case 0x80: // Last word, 1 byte
                    pkt_data[word * 8 + 0] = p[7];
                    pkt_data[word * 8 + 1] = p[6];
                    pkt_data[word * 8 + 2] = p[5];
                    pkt_data[word * 8 + 3] = p[4];
                    pkt_data[word * 8 + 4] = p[3];
                    pkt_data[word * 8 + 5] = p[2];
                    pkt_data[word * 8 + 6] = p[1];
                    pkt_data[word * 8 + 7] = p[0];
                    word++;
                    goto done;
                    break;
                default:   // Something else like "other module header"
                    break;
            }
        }

done:
        // Write out packet to FromFPGA element.
        write_uint32("midpipe", (uint32_t)buf);
    }
}

void wrapper_output()
{
    while (1) {
        uint16_t i;

        // Get a pointer to the packet data from the ToFPGA element.
        uint8_t *pkt = (uint8_t *)read_uint32("midpipe");

        // Pointer to the beginning of memory block.
        uint8_t *buf = (uint8_t *)BRAM_START(pkt);

        // Get lengths and ports. These were mapped from Click by ToFPGA.
        uint16_t *dst_port = ((uint16_t *)buf);

        uint16_t wlen_h = *((uint16_t *)buf + 1);
        uint16_t wlen_l = *((uint16_t *)buf + 1);
        uint16_t wlen = ((wlen_l << 8) | (wlen_h >> 8));

        uint16_t src_port_h = *((uint16_t *)buf + 2);
        uint16_t src_port_l = *((uint16_t *)buf + 2);
        uint16_t src_port = ((src_port_l << 8) | (src_port_h >> 8));

        uint16_t blen_h = *((uint16_t *)buf + 3);
        uint16_t blen_l = *((uint16_t *)buf + 3);
        uint16_t blen = ((blen_l << 8) | (blen_h >> 8));

        // XXX Manually set dst port. Should be done in ToFPGA.
        uint16_t decoded_src = (1 << src_port);
        *dst_port = ((src_port & 0x1) ?
                        (decoded_src >> 1) : (decoded_src << 1));

        // Write out the IOQ.
        uint8_t outctrl = 0xFF;
        uint64_t outdata;
        uint8_t *p = (uint8_t *)&outdata;
        p[0] = buf[7];
        p[1] = buf[6];
        p[2] = buf[5];
        p[3] = buf[4];
        p[4] = buf[3];
        p[5] = buf[2];
        p[6] = buf[0]; // Swap byte order for dst_port
        p[7] = buf[1];

        write_uint8("out_ctrl", outctrl);
        write_uint64("out_data", outdata);

        // Write out full 64-bit words of data.
        outctrl = 0;
        for (i = 0; i < wlen - 1; ++i) {
            p[0] = pkt[i * 8 + 7];
            p[1] = pkt[i * 8 + 6];
            p[2] = pkt[i * 8 + 5];
            p[3] = pkt[i * 8 + 4];
            p[4] = pkt[i * 8 + 3];
            p[5] = pkt[i * 8 + 2];
            p[6] = pkt[i * 8 + 1];
            p[7] = pkt[i * 8 + 0];
            write_uint8("out_ctrl", outctrl);
            write_uint64("out_data", outdata);
        }

        // Write out the last (partial) word.
        // Control bus has one bit set to mark the last byte.
        // E.g. 2 bytes in the last word, outctrl = 01000000.
        outctrl = ((uint8_t)0x80) >> ((blen & 7) - 1);
        p[0] = pkt[i * 8 + 7];
        p[1] = pkt[i * 8 + 6];
        p[2] = pkt[i * 8 + 5];
        p[3] = pkt[i * 8 + 4];
        p[4] = pkt[i * 8 + 3];
        p[5] = pkt[i * 8 + 2];
        p[6] = pkt[i * 8 + 1];
        p[7] = pkt[i * 8 + 0];

        write_uint8("out_ctrl", outctrl);
        write_uint64("out_data", outdata);

        // Free memory.
        ahir_packet_free((uint32_t*)pkt);
    }
}
