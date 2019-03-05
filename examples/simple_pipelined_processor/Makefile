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
SW: processor.c  testbench.c 
	gcc -c -DSW -I$(IOLIB_INCLUDE) processor.c
	gcc -c -DSW -I$(IOLIB_INCLUDE) testbench.c
	gcc -o testbench_sw processor.o testbench.o -L$(IOLIB_LIB) -lio -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: processor.c 
	clang -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c processor.c
	#llvm-dis processor.o
	opt -O3	 processor.o > processor.opt.o
	llvm-dis processor.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  processor.opt.o
	llvm2aa processor.opt.o | vcFormat >  processor.opt.o.aa

# Aa to vC
aa2vc: processor.opt.o.aa processorSuper.aa
	Aa2VC -O -C processor.opt.o.aa | vcFormat > processor.opt.o.aa.vc
	Aa2VC -O -C processorSuper.aa  | vcFormat > processorSuper.vc

# vC to VHDL
vc2vhdl: processor.opt.o.aa.vc processorSuper.vc attr.vc
	vc2vhdl -C -e ahir_system -w -s ghdl -t run -t write_to_mem -T fetch -T decode -T execute -f processor.opt.o.aa.vc   -f attr.vc
	vc2vhdl -C -e ahir_system_super -w -s ghdl -t run -t write_to_mem -T fetch -T decode -T execute -f processorSuper.vc -f attr.vc
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	vhdlFormat < ahir_system_super.unformatted_vhdl > ahir_system_super.vhdl
	vhdlFormat < ahir_system_super_test_bench.unformatted_vhdl > ahir_system_super_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ghdlsim testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c testbench.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLibPipeHandler -lpthread

ghdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=ieee_proposed  $(VHDL_LIB)/ieee_proposed.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Utility_Package.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 
	ghdl -i --work=work ahir_system_super.vhdl
	ghdl -i --work=work ahir_system_super_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_super_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_sw testbench_hw ahir_system_*test_bench vhpi.log

PHONY: all clean	
