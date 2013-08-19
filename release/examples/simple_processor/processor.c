/*------------------------------------------------------------------*|
|* FILE:              cpu.c
|* DESCRIPTION:       CPU emulator
|* DATE:              2006.9.20
|* LANGUAGE PLATFORM: gcc 3.3.6 (Linux), TCC 1.01 (DOS)
|* AUTHOR:            Jeffrey A. Meunier
|* EMAIL:             jeffrey_a_meunier@yahoo.com
|*------------------------------------------------------------------*/
 
 
#include <stdio.h>
#include <stdint.h>
#include <iolib.h>
 
 
/* A word is an unsigned 16-bit value. */
typedef uint16_t word;
 
/* Each memory word and register can hold a 16-bit value, which
   ranges from 0 to 65535.
 
   The program counter can range from 0 to 65535, which means that
   the maximum size of a program is 65536 instructions.
*/
 
/* Let's use only 64 words of memory instead of 65536 words of memory */
#define MEM_SIZE 64
/* And let's have 16 registers.  This allows a register to be specified
   with 4 bits, or exactly one hexadecimal digit 0-F. */
#define REGS     16
 
 
/* Memory is an array of 16-bit words. */
/* This program counts from 5 to 0 and then halts. */
word mem[ MEM_SIZE ] = {0x5105,0x5201,0xE100,0xA103,0x2112,0x9083,0x0000};
/* To run a different program, the program must be hand-asembled and
   entered in place of the one found here. */
 
/* Create 16 registers and set them all to 0. */
word reg[ REGS ] = {0};
/* the program counter is register 15 */
#define PC 15
 
/* Variables used for decoding: */
word ir;                   /* instruction register */
word op, r1, r2, r3, imm;  /* operand number, register numbers, immediate value */
int16_t  offs;                 /* signed offset value */
 
/* This is used during memory address calculation */
word addr;
 
/* CPU flags */
uint8_t halt = 0;

// write-to-mem
inline void write_to_mem(uint16_t mem_addr, uint16_t mem_data)
{
   mem[mem_addr] = mem_data;
}

uint16_t read_from_mem(uint16_t mem_addr)
{
  return  mem[mem_addr];
}
 
/*------------------------------------------------------------------*|
|* Fetch the next instruction.
|* After a fetch, the PC points to the next instruction in memory.
|*------------------------------------------------------------------*/
inline void fetch()
{
  ir = read_from_mem( reg[ PC ] );
  reg[ PC ]++;
}
 
 
/*------------------------------------------------------------------*|
|* Decode the last instruction that was fetched.
|* All values are decoded (all 3 registers, immediate, and offset),
|* even if they are not needed.
|*------------------------------------------------------------------*/
inline void decode()
{
  op = ir >> 12;          /* get the operation code */
  r1 = (ir >> 8) & 0xF;   /* get the first register */
  r2 = (ir >> 4) & 0xF;   /* get the second register */
  r3 = ir & 0xF;          /* get the third register */
  imm = ir & 0xFF;        /* get the immediate value */
  offs = (imm > 127 ? (128 - imm) : imm) - 1;  /* get the offset, and subtract 1 because
                                                  the PC has already moved to next location */
}
 
 
/*------------------------------------------------------------------*|
|* Execute a decoded instruction.
|*------------------------------------------------------------------*/
inline void execute()
{
  /* force register 0 always to be 0 */
  reg[ 0 ] = 0;
  switch( op )
    {
    case 0:
      /* halt */
      /* halt the CPU */
      halt = 1;
      return;
 
    case 1:
      /* add r1, r2, r3 */
      /* add two registers, place in a third register */
      reg[ r1 ] = reg[ r2 ] + reg[ r3 ];
      break;
 
    case 2:
      /* sub r1, r2, r3 */
      /* subtract one register from another, place in a third register */
      reg[ r1 ] = reg[ r2 ] - reg[ r3 ];
      break;
 
    case 3:
      /* lw r1, r2, r3 */
      /* load a word from memory into register */
      addr = reg[ r2 ] + reg[ r3 ];
      reg[ r1 ] = mem[ addr ];
      break;
 
    case 4:
      /* sw r1, r2, r3 */
      /* store a word from register into memory */
      addr = reg[ r2 ] + reg[ r3 ];
      mem[ addr ] = reg[ r1 ];
      break;
 
    case 5:
      /* lli r1, immediate(8-bit) */
      /* load low half of register with an immediate value */
      reg[ r1 ] &= 0xFF00;
      reg[ r1 ] |= imm;
      break;
 
    case 6:
      /* lhi r1, immediage(8-bit) */
      /* load high half of register with an immediate value */
      reg[ r1 ] &= 0x00FF;
      reg[ r1 ] |= imm << 8;
      break;
 
    case 7:
      /* mv r1, r2 */
      /* copy contents of r2 into r1 */
      reg[ r1 ] = reg[ r2 ];
      break;
 
    case 8:
      /* jmp address(16-bit) */
      /* jump to a 16-bit address */
      addr = mem[ reg[ PC ] ];
      reg[ PC ] = addr;
      break;
 
    case 9:
      /* br r1, offset(8-bit signed) */
      /* branch to register + offset */
      reg[ PC ] += reg[ r1 ] + offs;
      break;
 
    case 0xA:
      /* br r1, offset(8-bit signed) */
      /* branch by offset if r1 == 0 */
      if( reg[ r1 ] == 0 )
        reg[ PC ] += offs;
      break;
 
    case 0xB:
      /* unused */
      break;
 
    case 0xC:
      /* unused */
      break;
 
    case 0xD:
      /* unused */
      break;
 
    case 0xE:
      /* out r1 */
      /* display the value of a register */
      write_uint16("out_port",reg[r1]);
      break;
 
    case 0xF:
      /* unused */
      break;
    }
}
 

#ifndef SW
void loop_pipelining_on(uint32_t val, uint32_t buf, uint32_t extreme_flag);
#endif
 
/*------------------------------------------------------------------*|
|* Run the CPU until it halts.
|*------------------------------------------------------------------*/
void run()
{
  int i;
  halt = 0;
  for(i=0; i < REGS; i++)
	reg[i] = 0;

  while( !halt )
    {
#ifndef SW
		loop_pipelining_on(16,32,1);
#endif
      fetch();
      decode();
      execute(); /* includes writeback */
    }
}
 
 
 
/*------------------------------------------------------------------*|
|* eof
|*------------------------------------------------------------------*/
 
