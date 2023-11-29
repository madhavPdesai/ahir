# build software version of testbench (to check the "desired behaviour")
IOLIB_INCLUDE=$(AHIR_RELEASE)/include
IOLIB_LIB=$(AHIR_RELEASE)/lib
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/vhdl
all: SW HW 
 
TOVC: c2llvmbc llvmbc2aa aaopt aa2vc 
TOVHDL: TOVC vc2vhdl
AA2VHDL: aa2vc vc2vhdl

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: processor.c  testbench.c 
	gcc -c -DSW -I$(IOLIB_INCLUDE) processor.c
	gcc -c -DSW -I$(IOLIB_INCLUDE) testbench.c
	gcc -o testbench_sw processor.o testbench.o -L$(IOLIB_LIB) -lio -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aaopt aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: processor.c testbench.c
	clang -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c processor.c
	#llvm-dis processor.o
	opt -O3	 processor.o > processor.opt.o
	llvm-dis processor.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  processor.opt.o
	llvm2aa processor.opt.o | vcFormat >  processor.opt.o.aa

# AaOpt
aaopt: processor.opt.o.aa processorOptimized.Aa
	AaOpt  -B processor.opt.o.aa processorOptimized.Aa | vcFormat > processor.aa

# Aa to vC
aa2vc: processor.aa
	Aa2VC -O -C processor.aa | vcFormat > processor.vc

# vC to VHDL
vc2vhdl: processor.vc
	vc2vhdl -O -C -e ahir_system -w -s ghdl -T ifetch -T execute -T registerFile -t write_to_mem -f processor.vc
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
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_sw testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
