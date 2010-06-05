// system memory, of which first 2048 words
// (each word = uint) reserved for instruction
// and last 2048 words reserved for data.
unsigned int system_memory[4096];
unsigned int int_regs[32];

// program counter.
unsigned int pc;

// instruction format
// bits 31:28 opcode
// 
// for reg,reg -> reg operations
//      +,-,gt,eq,lt,*
//      shra,shr,shl (src-reg-2 specifies amount of shift)
//      
//   bits 27:22 dest-reg
//   bits 21:17 src-reg-1
//   bits 16:12 src-reg-2
//
// for load
//
//   bits 27:22 dest-reg
//   bits 21:17 addr-reg
//
// for store
//   bits 27:22 src-reg
//   bits 21:17 addr-reg
//  

#define OpCode(x) (x >> 28)
#define RR2RDest(x) ((x << 4)>>28)
#define RR2RSrc1(x) ((x << 8)>>28)
#define RR2RSrc2(x) ((x << 12)>>28)
#define LS_DestSrc(x)   ((x << 4)>>28)
#define S_Src(x)    ((x << 4)>>28)
#define L_Addr(x)   ((x << 8)>>28)
#define ImmVal(x)   ((x << 4)>>4)
#define ADD  1
#define SUB  2
#define MUL  3
#define SHR  4
#define SHL  5
#define JMP 6
#define HALT 15



int Execute(unsigned int instr, unsigned int curr_pc, unsigned int* next_pc);

int start(unsigned int pc_start)
{
	unsigned int curr_instr, next_pc;
	int i_status;
	
	
	pc = pc_start;

	while(1)
	{
		curr_instr = system_memory[pc];
		i_status = Execute(curr_instr,pc,&next_pc);
		if(i_status == 1)
			break;
		pc = next_pc;
	}
	return(1);
}

int Execute(unsigned int instr, unsigned int curr_pc, unsigned int* next_pc)
{
	unsigned int op_code = OpCode(instr);
	int ret_val;
	
	ret_val = 0;
	*next_pc = curr_pc + 1;

	if(op_code == ADD)
	{
		int_regs[RR2RDest(instr)] = int_regs[RR2RSrc1(instr)] + int_regs[RR2RSrc2(instr)];
	}
	if(op_code == SUB)
	{
		int_regs[RR2RDest(instr)] = int_regs[RR2RSrc1(instr)] - int_regs[RR2RSrc2(instr)];
	}
	if(op_code == SHR)
	{
		int_regs[RR2RDest(instr)] = int_regs[RR2RSrc1(instr)] >> int_regs[RR2RSrc2(instr)];
	}
	if(op_code == SHL)
	{
		int_regs[RR2RDest(instr)] = int_regs[RR2RSrc1(instr)] << int_regs[RR2RSrc2(instr)];
	}
	if(op_code == JMP)
	{
		*next_pc = ImmVal(instr);
	}
	if(op_code == HALT)
	{
		ret_val = 1;
		*next_pc = 0;
	}
	return(ret_val);
}

