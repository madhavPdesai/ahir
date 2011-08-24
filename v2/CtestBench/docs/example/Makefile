# build software version of testbench (to check the "desired behaviour")
# note: read/write functions will be found in ../../../iolib/
IOLIB_INCLUDE=../../../iolib
IOLIB_LIB=../../../iolib
SOCKETLIB_INCLUDE=../../include
SOCKETLIB_LIB=../../lib
VHDL_LIB=/home/madhav/ahirgit/AHIR/vhdl/release
VHDL_VHPI_LIB=../../vhdl
all: SW HW 

SW: prog.c prog.h testbench.c 
	gcc -c -DSW -I$(IOLIB_INCLUDE) prog.c
	gcc -c -DSW -I$(IOLIB_INCLUDE) testbench.c
	gcc -o testbench_sw prog.o testbench.o -L$(IOLIB_LIB) -lio -lpthread

HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

c2llvmbc: prog.c prog.h testbench.c
	clang -std=gnu89 -I$(IOLIB_INCLUDE) -emit-llvm -c prog.c
	#llvm-dis prog.o
	opt -O3	 prog.o > prog.opt.o
	llvm-dis prog.opt.o

llvmbc2aa:  prog.opt.o
	llvm2aa prog.opt.o | vcFormat >  prog.opt.o.aa

aa2vc: prog.opt.o.aa
	Aa2VC -O -C prog.opt.o.aa | vcFormat > prog.opt.o.aa.vc

vc2vhdl: prog.opt.o.aa.vc
	vc2vhdl -C -e ahir_system -w -s ghdl -T accumulate -t set_sum -t get_sum -f prog.opt.o.aa.vc 
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

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
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
