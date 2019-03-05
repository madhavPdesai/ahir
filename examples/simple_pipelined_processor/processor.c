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

/* 16 regs */
word reg[ REGS ];

/* the program counter is register 15 */
#define PC 15
 
 
 

// write-to-mem
void write_to_mem(uint16_t mem_addr, uint16_t mem_data)
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
void fetch()
{
  while(1)
  {
	uint16_t pc = read_uint16("next_pc");
  	write_uint16("ir_pipe", mem[pc]);
        write_uint16("pc_to_decode", pc);
  }
}
 
 
/*------------------------------------------------------------------*|
|* Decode the last instruction that was fetched.
|* All values are decoded (all 3 registers, immediate, and offset),
|* even if they are not needed.
|*------------------------------------------------------------------*/
void decode()
{
  while(1)
  {
  	uint16_t ir = read_uint16("ir_pipe");
  	uint16_t op = ir >> 12;          /* get the operation code */
        uint16_t pc = read_uint16("pc_to_decode");
        if(op != 0 && ((op < 8)  || (op > 10)))
        {
		write_uint16("next_pc", pc+1);
        }
  	uint16_t r1 = (ir >> 8) & 0xF;   /* get the first register */
  	uint16_t r2 = (ir >> 4) & 0xF;   /* get the second register */
  	uint16_t r3 = ir & 0xF;          /* get the third register */
  	uint16_t imm = ir & 0xFF;        /* get the immediate value */
  	uint16_t offs = (imm > 127 ? (128 - imm) : imm) - 1;  /* get the offset, and subtract 1 because
                                                  	the PC has already moved to next location */
        write_uint16("op_pipe", op);
        write_uint16("r1_pipe", r1);
        write_uint16("r2_pipe", r2);
        write_uint16("r3_pipe", r3);
        write_uint16("imm_pipe", imm);
        write_uint16("offs_pipe", offs);
        write_uint16("pc_to_execute",pc);
  }
}
 
 
/*------------------------------------------------------------------*|
|* Execute a decoded instruction.
|*------------------------------------------------------------------*/
void execute()
{
  while(1)
  {
  	uint16_t op, r1, r2, r3, offs, imm, pc, addr;

  	/* force register 0 always to be 0 */
  	reg[ 0 ] = 0;
  	op  = read_uint16("op_pipe");
  	r1  = read_uint16("r1_pipe"); 
  	r2  = read_uint16("r2_pipe"); 
  	r3  = read_uint16("r3_pipe"); 
  	imm = read_uint16("imm_pipe");
  	offs = read_uint16("offs_pipe");
        pc = read_uint16("pc_to_execute");

        
	
  	switch( op )
    	{
    	case 0:
      	/* halt the CPU */
      		write_uint16("halt_pipe",1);
 
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
      	addr = mem[ pc + 1];
        write_uint16("next_pc", addr);
      	break;
 	
    	case 9:
      	/* br r1, offset(8-bit signed) */
      	/* branch to register + offset */
        write_uint16("next_pc", reg[ r1 ] + (pc + offs));
      	break;
 
    case 0xA:
      /* br r1, offset(8-bit signed) */
      /* branch by offset if r1 == 0 */
      write_uint16("next_pc", reg[r1] ? pc + 1 : pc + offs);
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
}
 
 
/*------------------------------------------------------------------*|
|* Run the CPU until it halts.
|*------------------------------------------------------------------*/
void run()
{
  int i;
  reg[PC] = 0;

  write_uint16("next_pc", 0);

  // wait for halt-signal.. if received stop.
  uint16_t new_halt = read_uint16("halt_pipe");
}
 
 
 
/*------------------------------------------------------------------*|
|* eof
|*------------------------------------------------------------------*/
 
