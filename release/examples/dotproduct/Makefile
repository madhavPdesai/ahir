# build software version of testbench (to check the "desired behaviour")
IOLIB_INCLUDE=../../iolib/include
IOLIB_LIB=../../iolib/lib
SOCKETLIB_INCLUDE=../../CtestBench/include
SOCKETLIB_LIB=../../CtestBench/lib
VHDL_LIB=../../vhdl
VHDL_VHPI_LIB=../../CtestBench/vhdl
TOPMODULES=-t init -t dotp_pipelined_unrolled -t dotp_nonpipelined_unrolled -t dotp_pipelined -t dotp_nonpipelined
all: HW 


# steps from Aa to vhdl simulator.
HW: aa2vc vc2vhdl  vhdlsim

# Aa to vC
aa2vc: prog.aa
	AaOpt prog.aa | vcFormat > prog.opt.aa
	Aa2VC -O -C prog.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl  -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
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
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o *.vc *.cf *.*vhdl *.opt.aa vhdlCStubs.* *.vcd in_data* testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
