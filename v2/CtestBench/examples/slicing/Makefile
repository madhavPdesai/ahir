# build software version of testbench (to check the "desired behaviour")
IOLIB_INCLUDE=~/ahirgit/AHIR/v2/iolib/
IOLIB_LIB=~/ahirgit/AHIR/v2/iolib/
SOCKETLIB_INCLUDE=../../include
SOCKETLIB_LIB=../../lib
VHDL_LIB=~/ahirgit/AHIR/vhdl/release/
VHDL_VHPI_LIB=../../vhdl
all: HW 


# steps from Aa to vhdl simulator.
HW: aa2vc vc2vhdl vhdlsim

# Aa to vC
aa2vc: prog.aa
	Aa2VC -O -C prog.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -q -C -e ahir_system -w -s ghdl -t byteswap32 -t byteswap32_alt -f prog.vc
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
	rm -f *.o *.vc *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
