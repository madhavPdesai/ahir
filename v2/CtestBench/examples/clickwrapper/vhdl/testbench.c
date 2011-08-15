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

    // Construct and write out the IOQ.
    ioq_t ioq;
    ioq.v = 0;

    uint16_t words = len >> 3;
    if ((len & 7) != 0)
        words++;

    ioq.f.srcp = htons(1);
    ioq.f.wlen = htons(words);
    ioq.f.dstp = htons(1);
    ioq.f.blen = htons(len);

    uint8_t outctrl = 0xff;
    uint64_t outdata = ioq.v;
    write_uint64("in_data", outdata);
    write_uint8("in_ctrl", outctrl);

    printf("Wrote the IOQ (%llx).\n", outdata);

    // Write out full 64-bit words of data.
    outctrl = 0;
    uint16_t i;
    for (i = 0; i < words - 1; ++i) {
        word_t w;
        w.v = 0;
        int j;
        for (j = 0; j < 8; ++j)
            w.s.b[j] = buf[i * 8 + j];
        write_uint64("in_data", w.v);
        write_uint8("in_ctrl", outctrl);
        printf("Wrote data word %u (%llx).\n", i, w.v);
    }

    // Write out the last (partial) word.
    // Control bus has one bit set to mark the last byte.
    // E.g. 2 bytes in the last word, outctrl = 01000000.
    outctrl = ((uint8_t)0x80) >> ((len & 7) - 1);
    word_t w;
    w.v = 0;
    int j;
    for (j = 0; j < 8; ++j)
        w.s.b[j] = buf[i * 8 + j];

    write_uint64("in_data", w.v);
    write_uint8("in_ctrl", outctrl);

    printf("Wrote the last data word, #%u (%llx).\n", i, w.v);
}

void *read_pipe_(void *args)
{
    int i = 0, j = 0, len = 0;
    uint8_t *buf = (uint8_t *)(((FnArgs *)args)->buf);
    ioq_t ioq;
    ioq.v = 0;
    word_t w;
    w.v = 0;

    while (1) {
        // Read data and ctrl from wrapper_output.
        uint8_t  inctrl = read_uint8("out_ctrl");
        uint64_t indata = read_uint64("out_data");
        uint16_t word_count;

        switch (inctrl) {
            case 0xff:
		word_count = 0;
                ioq.v = indata;

                printf("Read the IOQ:\n");
                printf("srcp: %04x\n", ntohs(ioq.f.srcp));
                printf("wlen: %04x\n", ntohs(ioq.f.wlen));
                printf("dstp: %04x\n", ntohs(ioq.f.dstp));
                printf("blen: %04x\n", ntohs(ioq.f.blen));

                break;
            case 0x00:
                printf("Read a data word (%d): %llx \n", word_count, indata);
		word_count++;
                w.v = indata;
                for (j = 0; j < 8; ++j)
                    buf[i * 8 + j] = w.s.b[j];
                i++;
                break;
            case 0x01: // Last word, 8 bytes
            case 0x02: // Last word, 7 bytes
            case 0x04: // Last word, 6 bytes
            case 0x08: // Last word, 5 bytes
            case 0x10: // Last word, 4 bytes
            case 0x20: // Last word, 3 bytes
            case 0x40: // Last word, 2 bytes
            case 0x80: // Last word, 1 byte
                printf("Read the last data word (%d): %llx.\n", word_count,indata);
                w.v = indata;
                for (j = 0; j < 8; ++j)
                    buf[i * 8 + j] = w.s.b[j];
                i++;
                goto done;
                break;
            default:
                printf("Unknown control bus signal.\n");
                break;
        }
        if(word_count == 255)
	{
            printf("whoops! read 256 words, end-of-packet not seen.\n");
	    goto done;
	}
    }

done:

    printf("Read %d bytes from netfpga wrapper:", ntohs(ioq.f.blen));
    for (i = 0; i < ntohs(ioq.f.blen); i++) {
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
    int i;

    uint8_t ok_ping[104] = {
        0x00, 0x15, 0x17, 0x79, 0x5b, 0xe3, 0xbc, 0xae,
        0xc5, 0x77, 0xed, 0xfa, 0x08, 0x00, 0x45, 0x00,
        0x00, 0x54, 0x00, 0x00, 0x40, 0x00, 0x40, 0x01,
        0x93, 0xad, 0xc1, 0xea, 0xdb, 0x0f, 0x0a, 0x00,
        0x00, 0x02, 0x08, 0x00, 0x01, 0x68, 0x4c, 0x54,
        0x00, 0x06, 0x93, 0x21, 0xf2, 0x4d, 0x00, 0x00,
        0x00, 0x00, 0x59, 0xfb, 0x0c, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
        0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d,
        0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
        0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
        0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
        0x36, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };

    uint8_t bad_cksum[98] = {
        0x00, 0x15, 0x17, 0x79, 0x5b, 0xe3, 0x00, 0x26,
        0xb0, 0xe2, 0xab, 0x30, 0x08, 0x00, 0x45, 0x00,
        0x00, 0x54, 0x1e, 0x5b, 0x00, 0x00, 0x40, 0x01,
        0x00, 0x00, 0xc1, 0xea, 0xdb, 0x0d, 0x0a, 0x00,
        0x00, 0x02, 0x08, 0x00, 0x5f, 0xcc, 0x9f, 0x26,
        0x00, 0x00, 0x4c, 0xb5, 0x96, 0x02, 0x00, 0x03,
        0x2b, 0x4f, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
        0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
        0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d,
        0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
        0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
        0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
        0x36, 0x37 };

    uint8_t arp[98] = {
        0x00, 0x15, 0x17, 0x79, 0x5b, 0xe3, 0x00, 0x26,
        0xb0, 0xe2, 0xab, 0x30, 0x08, 0x06, 0x45, 0x00,
        0x00, 0x54, 0x1e, 0x5b, 0x00, 0x00, 0x40, 0x01,
        0x00, 0x00, 0xc1, 0xea, 0xdb, 0x0d, 0x0a, 0x00,
        0x00, 0x02, 0x08, 0x00, 0x5f, 0xcc, 0x9f, 0x26,
        0x00, 0x00, 0x4c, 0xb5, 0x96, 0x02, 0x00, 0x03,
        0x2b, 0x4f, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
        0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15,
        0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d,
        0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
        0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
        0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
        0x36, 0x37 };

    memset(buf, 0, 4096);
    signal(SIGINT, signal_handler);
    signal(SIGTERM, signal_handler);

    wrapper_input_args.ret_val = &wrapper_input_ret;
    wrapper_output_args.ret_val = &wrapper_output_ret;
    write_args.buf = ok_ping;
    write_args.len = 98;
    write_args.ret_val = &write_ret;
    read_args.buf = buf;
    read_args.len = 98;
    read_args.ret_val = &read_ret;

    // pthread_create(&wrapper_input_t, NULL, &wrapper_input_,
                   // (void *)&wrapper_input_args);
    // pthread_create(&wrapper_output_t, NULL, &wrapper_output_,
                   // (void *)&wrapper_output_args);
    pthread_create(&write_t, NULL, &write_pipe_, (void *)&write_args);
    pthread_create(&read_t, NULL, &read_pipe_, (void *)&read_args);
    // pthread_create(&fqm_t, NULL, &free_queue_manager_, (void *)NULL);

    pthread_join(write_t, NULL);
    pthread_join(read_t, NULL);

    sleep(3);

    // pthread_cancel(wrapper_input_t);
    // pthread_cancel(wrapper_output_t);
    // pthread_cancel(fqm_t);
}
