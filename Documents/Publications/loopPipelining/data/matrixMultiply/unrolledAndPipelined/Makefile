# build software version of testbench (to check the "desired behaviour")
AHIR_RELEASE=/home/madhav/ahirgit/ahir/release/
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/CtestBench/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/pipeHandler/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/pthreadUtils/include
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
SRC=../src
all: SW HW 

# llvm2aa opts: pipelined case, extract-do-while.
#LLVM2AAOPTS=--storageinit=true
LLVM2AAOPTS=-extract_do_while=true --storageinit=true

#program defs: unrolled case
#PROGDEFS=
PROGDEFS=-DUNROLL

OPTOPTIONS=-O3 --loop-unroll --indvars --loopsimplify 
#OPTOPTIONS=--indvars --loopsimplify 

TOPMODULES=-T mmultiply 


# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: $(SRC)/prog.c $(SRC)/prog.h $(SRC)/testbench.c 
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include -I$(SRC) $(SRC)/prog.c
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -I$(SRC) $(SRC)/testbench.c
	gcc -g -o testbench_sw prog.o testbench.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa  aalink aa2vc  vc2vhdl  vhdlsim

AA2VHDL: aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: $(SRC)/prog.c $(SRC)/prog.h
	clang  -std=gnu89 $(PROGDEFS)  -I$(SOCKETLIB_INCLUDE) -I$(FUNCTIONLIB)/include -emit-llvm -c $(SRC)/prog.c
	opt $(OPTOPTIONS) prog.o -o prog.opt.o
	llvm-dis prog.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.opt.o 
	llvm2aa $(LLVM2AAOPTS)  prog.opt.o | vcFormat >  prog.aa

# Aa to vC
aalink: prog.aa $(FUNCTIONLIB)/Aa/fpu.aa
	AaLinkExtMem prog.aa $(FUNCTIONLIB)/Aa/fpu.aa | vcFormat > prog.linked.aa
	AaOpt prog.linked.aa | vcFormat > prog.linked.opt.aa

aa2vc: prog.linked.opt.aa
	Aa2VC -O -C prog.linked.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -S 4 -O -I 16 -v -q -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc -L $(FUNCTIONLIB)/fpu.list
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim:  TB GHDL


TB: $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c  -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c $(SRC)/testbench.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread

GHDL: ahir_system.vhdl ahir_system_test_bench.vhdl
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Utility_Package.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *.xrpt _xmsgs *.ghw Synth.srp pipeHandler.log

PHONY: all clean	
