# build software version of testbench (to check the "desired behaviour")
PIPEHANDLER_INCLUDE=../../pipeHandler/include
PIPEHANDLER_LIB=../../pipeHandler/lib
SOCKETLIB_INCLUDE=../../CtestBench/include
SOCKETLIB_LIB=../../CtestBench/lib
VHDL_LIB=../../vhdl
VHDL_VHPI_LIB=../../CtestBench/vhdl
FUNCTIONLIB=../../functionLibrary
LLVMOPTS=--pipedepths=pipedepths -extract_do_while=true
#LLVMOPTS=--pipedepths=pipedepths 
all: SW HW 

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: prog.c  testbench.c 
	gcc -g -c -DSW -DRUN -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include prog.c
	gcc -g  -c -DSW -DRUN -I$(PIPEHANDLER_INCLUDE) testbench.c
	gcc -g -c -DSW -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include $(FUNCTIONLIB)/src/fpu.c
	gcc -g -o testbench_sw prog.o fpu.o testbench.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c testbench.c 
	clang -std=gnu89 -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include -emit-llvm -c prog.c
	opt -O3	--instnamer prog.o > prog.opt.o
	llvm-dis prog.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.opt.o 
	llvm2aa  $(LLVMOPTS) prog.opt.o | vcFormat >  prog.opt.o.aa

# Aa to vC
aa2vc: prog.opt.o.aa 
	AaOpt prog.opt.o.aa  $(FUNCTIONLIB)/Aa/fpu.aa | vcFormat > prog.aa
	Aa2VC -O -C prog.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -a -C -e ahir_system -w -s ghdl -L $(FUNCTIONLIB)/fpu.list -T input_module -T free_queue_manager -T output_module -T proc0 -T proc1 -T proc2 -T proc3 -f prog.vc 
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c testbench.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLibPipeHandler -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=ieee_proposed  $(VHDL_LIB)/ieee_proposed.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Utility_Package.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_sw testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
