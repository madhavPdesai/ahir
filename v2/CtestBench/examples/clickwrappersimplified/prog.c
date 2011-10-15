#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <iolib.h>

#define BRAM_SIZE 256

#define FREE_QUEUE_SIZE 4
#define RAM_SIZE (FREE_QUEUE_SIZE * BRAM_SIZE)
#define FREE_QUEUE_PUT 1
#define FREE_QUEUE_GET 2
#define FREE_QUEUE_OK  3
#define FREE_QUEUE_FAIL  4

#define SRC_MASK 0xffff0000
#define DEST_MASK (((uint64_t) 0xffff) << 48)

void output_port_lookup()
{
      uint8_t ctrl;
      uint64_t data;

#ifdef GSI
      uint8_t start_flag = read_uint8("start_output_port_lookup");
#endif

      while(1)
      {
	ctrl = read_uint8("op_lut_ctrl");
	data = read_uint64("op_lut_data");

#ifdef OPLU
	if(ctrl == 0xff)
	{
		uint16_t src_id = ((data & SRC_MASK) >> 16);
		uint16_t decoded_src = (1 << src_id);
		uint64_t dest_id = ((src_id & 0x1) ? (decoded_src >> 1) : (decoded_src << 1));

		data = (data & ~DEST_MASK) | (dest_id << 48);
	}
#endif 

	write_uint8("out_ctrl",ctrl);
	write_uint64("out_data",data);
      }
}

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

#ifdef GSI
void global_storage_initializer_();
#endif
void free_queue_manager()
{
    int i;

#ifdef GSI
    global_storage_initializer_();
    write_uint8("start_wrapper_input",1);
    write_uint8("start_wrapper_output",1);
    write_uint8("start_output_port_lookup",1);
#endif

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

#ifdef GSI
    uint8_t start_flag = read_uint8("start_wrapper_input");
#endif
    uint8_t lastctrl = 1;
    while (1) {
        uint8_t *buf = (uint8_t *)ahir_packet_get();
        int word = 0;

        uint8_t *pkt_data = (buf + 0);

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
		    word++;
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
                default:   // Something else like "other module header"
                    lastctrl = inctrl;
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
            }
        }

done:
        // Write out packet to FromFPGA element.
        write_uint32("midpipe", (uint32_t)buf);
        write_uint8("last_ctrl", lastctrl);
        write_uint32("pkt_length", word);
    }
}

void wrapper_output()
{
#ifdef GSI
    uint8_t start_flag = read_uint8("start_wrapper_output");
#endif
    while (1) {
        uint16_t i;

        // Get a pointer to the packet data from the ToFPGA element.
        uint8_t *pkt = (uint8_t *)read_uint32("midpipe");
        uint32_t pklen = read_uint32("pkt_length");
        uint8_t lastctrl = read_uint8("last_ctrl");

        // Pointer to the beginning of memory block.
        uint8_t *buf = pkt;


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

        write_uint8("op_lut_ctrl", outctrl);
        write_uint64("op_lut_data", outdata);
	
        //printf("wrapper-output-pktdata=%llx\n", outdata);

        outctrl = 0;
        for (i = 1; i < pklen-1; ++i) {
            p[0] = pkt[i * 8 + 7];
            p[1] = pkt[i * 8 + 6];
            p[2] = pkt[i * 8 + 5];
            p[3] = pkt[i * 8 + 4];
            p[4] = pkt[i * 8 + 3];
            p[5] = pkt[i * 8 + 2];
            p[6] = pkt[i * 8 + 1];
            p[7] = pkt[i * 8 + 0];
            write_uint8("op_lut_ctrl", outctrl);
            write_uint64("op_lut_data", outdata);

            //printf("wrapper-output-pktdata=%llx\n", outdata);
        }

        outctrl = lastctrl;
        p[0] = pkt[i * 8 + 7];
        p[1] = pkt[i * 8 + 6];
        p[2] = pkt[i * 8 + 5];
        p[3] = pkt[i * 8 + 4];
        p[4] = pkt[i * 8 + 3];
        p[5] = pkt[i * 8 + 2];
        p[6] = pkt[i * 8 + 1];
        p[7] = pkt[i * 8 + 0];

        write_uint8("op_lut_ctrl", outctrl);
        write_uint64("op_lut_data", outdata);
        
        //printf("wrapper-output-pktdata=%llx\n", outdata);

        // Free memory.
        ahir_packet_free((uint32_t*)pkt);
    }
}
