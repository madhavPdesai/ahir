# build software version of testbench (to check the "desired behaviour")
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/CtestBench/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/pipeHandler/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/pthreadUtils/include
GNUPTHUTILS_INCLUDE=$(AHIR_RELEASE)/GnuPthUtils/include
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
SRC=./
INCLUDE=../../include


# llvm2aa opts: pipelined case, extract-do-while.
#LLVM2AAOPTS=--storageinit=true
LLVM2AAOPTS=-extract_do_while=true --storageinit=true -pipedepths=pipedepths.txt

TOPMODULES=-T vectorSum 

all: c2llvmbc llvmbc2aa aalink

# C to llvm byte-code.. use clang.
c2llvmbc: $(SRC)/fpu.c 
	clang -O3 -std=gnu89  -I$(INCLUDE) -emit-llvm -c $(SRC)/fpu.c
	opt --indvars --loopsimplify fpu.o -o fpu.opt.o
	llvm-dis fpu.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  fpu.opt.o 
	llvm2aa $(LLVM2AAOPTS)  fpu.opt.o | vcFormat >  fpu.aa

# Aa to vC
aalink: fpu.aa 
	AaLinkExtMem fpu.aa ../fpu.aa  | vcFormat > fpu.linked.aa
	AaOpt -B fpu.linked.aa | vcFormat > fpu.linked.opt.aa


clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw *.dot

PHONY: all clean	
