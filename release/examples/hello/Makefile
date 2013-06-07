# build software version of testbench (to check the "desired behaviour")
SOCKETLIB_INCLUDE=../../CtestBench/include
SOCKETLIB_LIB=../../CtestBench/lib
PIPEHANDLER_INCLUDE=../../pipeHandler/include
PIPEHANDLER_LIB=../../pipeHandler/lib
VHDL_LIB=../../vhdl
VHDL_VHPI_LIB=../../CtestBench/vhdl
all: SW HW 

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: prog.c prog.h testbench.c 
	gcc -c -DSW -I$(PIPEHANDLER_INCLUDE) prog.c
	gcc -c -DSW -I$(PIPEHANDLER_INCLUDE) testbench.c
	gcc -o testbench_sw prog.o testbench.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c prog.h testbench.c
	clang -std=gnu89 -I$(SOCKETLIB_INCLUDE) -emit-llvm -c prog.c
	llvm-dis prog.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.o
	llvm2aa --storageinit=true prog.o | vcFormat >  prog.aa
#       --storageinit=true  means that llvm2aa will generate
#                           an initialization routine which
#                           must be called on the hardware 
#                           side from somewhere in prog.c

# Aa to vC
aa2vc: prog.aa
	AaLinkExtMem prog.aa | vcFormat > prog.linked.aa
	Aa2VC -O -C prog.linked.aa | vcFormat > prog.vc
#  Aa2VC -O  tries to extract parallelism in basic blocks
#        -C  produces C wrappers of all modules in the .aa file.
#            these can be used to simulate the hardware using
#            the software testbench itself.

# vC to VHDL
# options: -D produces debug logging in the generated VHDL
#             dont use it if you want to synthesize the VHDL
#          -C produces a VHDL wrapper testbench which can
#             connect directly to testbench.c 
#          -w produces VHDL files.
#          -s ghdl   (use if GHDL is your simulator). 
#
VC2VHDLOPTS=-D -C -w -s ghdl 

# top-level modules
#  -T <mod> means that mod is a daemon (once started will be run forever)
#  -t <mod> means mod is callable from the system ports..
TOPMODULES=-T accumulate -t set_sum -t get_sum -t global_storage_initializer_
vc2vhdl: prog.vc
	vc2vhdl $(VC2VHDLOPTS) -e ahir_system $(TOPMODULES) -f prog.vc
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: TB GHDL

TB: testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c testbench.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread

GHDL: ahir_system.vhdl ahir_system_test_bench.vhdl 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=ahir_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc

PHONY: all clean	
