# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
AHIR_VHDL=$(AHIR_RELEASE)/vhdl
all: HW 


# steps from Aa to vhdl simulator.
HW: aa2vc vc2vhdl vhdlsim

# Aa to vC
aa2vc: prog.aa
	Aa2VC -O -C prog.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -C -e ahir_system -w -s ghdl -t test_prog -t test_prog_alt -f prog.vc
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -c testbench.c -I./ -I$(AHIR_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(AHIR_VHDL)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(AHIR_VHDL)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(AHIR_VHDL)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o *.vc *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
