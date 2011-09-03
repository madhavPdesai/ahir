IOLIB_INCLUDE=../../../iolib
IOLIB_LIB=../../../iolib
SOCKETLIB_INCLUDE=../../include
SOCKETLIB_LIB=../../lib
VHDL_LIB=../../../../vhdl/release
VHDL_VHPI_LIB=../../vhdl
SIMULATOR=ghdl
all: HW 


# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c testbench.c
	clang -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c prog.c
	llvm-dis prog.o
	opt -O3 --instnamer prog.o > prog.bc
	llvm-dis prog.bc

# llvm byte-code to Aa..
llvmbc2aa:  prog.bc
	llvm2aa --storageinit --modules=modules.txt prog.bc | vcFormat >  prog.aa

# Aa to vC
aa2vc: prog.aa
	Aa2VC -O -C prog.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -C -e ahir_system -w -s $(SIMULATOR) -T io_module -f prog.vc 
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
	rm -f *.o *.aa *.vc  *.bc *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* dest*_pipe* foo_in*  testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
