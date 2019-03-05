# build software version of testbench (to check the "desired behaviour")
IOLIB_INCLUDE=../../iolib/include
IOLIB_LIB=../../iolib/lib
SOCKETLIB_INCLUDE=../../CtestBench/include
SOCKETLIB_LIB=../../CtestBench/lib
VHDL_LIB=../../vhdl
VHDL_VHPI_LIB=../../CtestBench/vhdl
XILINX_SETTINGS=/home/madhav/Xilinx10.1/ISE/settings32.sh
TOPMODS=-t PlantSeeds -t Random -t Initialize -t SelectStream -t PutSeed -t GetSeed
all: SW HW 

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: rngs.c divider.c divider.h rngs.h testbench.c 
	gcc -c -O3 -DSW  -I$(IOLIB_INCLUDE) rngs.c
	gcc -c -O3 -DSW  -I$(IOLIB_INCLUDE) divider.c
	gcc -c -O3 -DSW  -I$(IOLIB_INCLUDE) testbench.c
	gcc -o testbench_sw rngs.o divider.o testbench.o -L$(IOLIB_LIB) -lio -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: rngs.c divider.c divider.h rngs.h testbench.c 
	clang -DSW -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c divider.c
	clang -DSW -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c rngs.c
	llvm-ld -link-as-library divider.o rngs.o -b rngs.linked.o
	opt -O3 -instnamer rngs.linked.o > rngs.linked.o.opt
	llvm-dis rngs.linked.o.opt

# llvm byte-code to Aa..
llvmbc2aa:  rngs.linked.o.opt
	llvm2aa --storageinit=true rngs.linked.o.opt | vcFormat >  rngs_divider.aa

# Aa to vC
aa2vc: rngs_divider.aa
	AaLinkExtMem rngs_divider.aa | vcFormat > rngs_divider_linked.aa
	Aa2VC -O -C rngs_divider_linked.aa | vcFormat > rngs_divider.vc

# vC to VHDL
vc2vhdl: rngs_divider.vc
	vc2vhdl -C -e ahir_system -w -s ghdl -t Random -t Initialize -t SelectStream -t PutSeed -f rngs_divider.vc
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
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 



clean:
	rm -f *.vc *.aa *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_sw testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
