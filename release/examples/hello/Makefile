# build software version of testbench (to check the "desired behaviour")
IOLIB_INCLUDE=../../iolib/include
IOLIB_LIB=../../iolib/lib
SOCKETLIB_INCLUDE=../../CtestBench/include
SOCKETLIB_LIB=../../CtestBench/lib
VHDL_LIB=../../vhdl
VHDL_VHPI_LIB=../../CtestBench/vhdl
all: SW HW 

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: prog.c prog.h testbench.c 
	gcc -c -DSW -I$(IOLIB_INCLUDE) prog.c
	gcc -c -DSW -I$(IOLIB_INCLUDE) testbench.c
	gcc -o testbench_sw prog.o testbench.o -L$(IOLIB_LIB) -lio -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c prog.h testbench.c
	clang -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c prog.c
	llvm-dis prog.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.o
	llvm2aa --storageinit=true prog.o | vcFormat >  prog.aa

# Aa to vC
aa2vc: prog.aa
	AaLinkExtMem prog.aa | vcFormat > prog.linked.aa
	Aa2VC -O -C prog.linked.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -C -e ahir_system -w -s ghdl -T accumulate -t set_sum -t get_sum -t global_storage_initializer_ -f prog.vc 
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c testbench.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=ieee_proposed  $(VHDL_LIB)/ieee_proposed.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Utility_Package.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc

PHONY: all clean	
