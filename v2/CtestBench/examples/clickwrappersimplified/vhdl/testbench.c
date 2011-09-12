#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include "vhdlCStubs.h"

void signal_handler(int sig)
{
    fprintf(stderr, "## Break! ##\n");
    exit(0);
}

typedef struct _FnArgs FnArgs;
struct _FnArgs
{
    void *buf;
    uint16_t len;
    int *ret_val;
};

typedef union {
    uint64_t v;
    struct {
        uint16_t srcp;
        uint16_t wlen;
        uint16_t dstp;
        uint16_t blen;
    } f;
} ioq_t;

typedef union {
    uint64_t v;
    struct {
        uint8_t b[8];
    } s;
} word_t;

void *wrapper_input_(void* args)
{
    wrapper_input();
}

void *wrapper_output_(void* args)
{
    wrapper_output();
}

void *free_queue_manager_(void* args)
{
    free_queue_manager();
}

void *write_pipe_(void *args)
{
    uint16_t len = (uint16_t)(((FnArgs *)args)->len);
    uint8_t *buf = (uint8_t *)(((FnArgs *)args)->buf);
    uint16_t word_count = 0;
    uint64_t* wptr = (uint64_t*) buf;

    uint8_t outctrl = 0xff;
    uint64_t outdata = wptr[word_count];

    write_uint64("in_data", outdata);
    write_uint8("in_ctrl", outctrl);
    
    printf("Wrote data word %u (%llx).\n",word_count, outdata);
    word_count++;


    // Write out full 64-bit words of data.
    outctrl = 0;
    uint16_t i;
    for (i = 1; i < 31; ++i) {

	outdata = wptr[word_count];

        write_uint64("in_data", outdata);
        write_uint8("in_ctrl", outctrl);

        printf("Wrote data word %u (%llx).\n",word_count, outdata);
    	word_count++;
    }

    outctrl = 1;
    outdata = wptr[word_count];
    write_uint64("in_data", outdata);
    write_uint8("in_ctrl", outctrl);
    printf("Wrote data word %u (%llx).\n",word_count, outdata);
}

void *read_pipe_(void *args)
{
    int i = 0, j = 0, len = 0;
    uint8_t *buf = (uint8_t *)(((FnArgs *)args)->buf);
    int word_count = 0; 
    uint16_t byte_count;
    while (1) {
        // Read data and ctrl from wrapper_output.
        uint8_t  inctrl = read_uint8("out_ctrl");
        uint64_t indata = read_uint64("out_data");

        printf("Read a data word(%d):%x     %llx. \n", word_count, inctrl, indata);
	word_count++;


	uint8_t *p = (uint8_t*) &indata;

        switch (inctrl) {
            case 0xff:
		byte_count = 0;
                for (j = 0; j < 8; ++j)
                {
                    buf[byte_count] = p[j];
		    byte_count++;
		}
                break;
            case 0x00:
                for (j = 0; j < 8; ++j)
                {
                    buf[byte_count] = p[j];
		    byte_count++;
		}
                break;
            default:
                for (j = 0; j < 8; ++j)
                {
                    buf[byte_count] = p[j];
		    byte_count++;
		}
                goto done;
                break;
        }
    }

done:

    for (i = 0; i < byte_count; i++) {
        if (i % 8 == 0)
            printf("\n");
        printf("%02x ", buf[i]);
    }
    printf("\n");
}

int
main(int argc, char* argv[])
{
    pthread_t wrapper_input_t, wrapper_output_t, write_t, read_t;
    pthread_t fqm_t;
    int wrapper_input_ret, wrapper_output_ret, write_ret, read_ret;
    FnArgs wrapper_input_args, wrapper_output_args, write_args, read_args;
    uint8_t buf[4096];
    uint8_t packet[256];
    int i;

    for(i=0; i < 256; i++)
    {
	packet[i] = i % 256;
    }


    memset(buf, 0, 4096);
    signal(SIGINT, signal_handler);
    signal(SIGTERM, signal_handler);

    wrapper_input_args.ret_val = &wrapper_input_ret;
    wrapper_output_args.ret_val = &wrapper_output_ret;
    write_args.buf = packet;
    write_args.len = 256;
    write_args.ret_val = &write_ret;
    read_args.buf = buf;
    read_args.len = 98;
    read_args.ret_val = &read_ret;

    //pthread_create(&wrapper_input_t, NULL, &wrapper_input_,
                   //(void *)&wrapper_input_args);
    //pthread_create(&wrapper_output_t, NULL, &wrapper_output_,
                   //(void *)&wrapper_output_args);
    pthread_create(&write_t, NULL, &write_pipe_, (void *)&write_args);
    pthread_create(&read_t, NULL, &read_pipe_, (void *)&read_args);
    //pthread_create(&fqm_t, NULL, &free_queue_manager_, (void *)NULL);

    pthread_join(write_t, NULL);
    pthread_join(read_t, NULL);

    sleep(3);

    //pthread_cancel(wrapper_input_t);
    //pthread_cancel(wrapper_output_t);
    //pthread_cancel(fqm_t);
}
