# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl/

all: SW HW 

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: src/processor.c  src/testbench.c 
	gcc -g -c -DSW -I$(AHIR_INCLUDE) src/processor.c
	gcc -g -c -DSW -I$(AHIR_INCLUDE) src/testbench.c
	gcc -g -o testbench_sw processor.o testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread

# four steps from C to vhdl simulation.
HW: aa2vc vc2vhdl vhdltb ghdlsim
TOVHDL: aa2vc vc2vhdl


# Aa to vC
aa2vc: src/processorSuper.aa
	AaOpt -B src/processorSuper.aa | vcFormat > processorSuper.opt.aa
	Aa2VC -O -C processorSuper.opt.aa  | vcFormat > processorSuper.vc

# vC to VHDL
TOPMODULES=-T fetch_daemon -T execute_daemon -T reg_read_daemon -T reg_write_daemon -t write_to_mem
vc2vhdl: processorSuper.vc
	vc2vhdl -v -D -O -C -e ahir_system -w -s ghdl $(TOPMODULES) -f processorSuper.vc
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	rm -f *.unformatted_vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdltb: src/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -c src/testbench.c -I./ -I$(AHIR_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLib -lpthread

ghdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_sw testbench_hw ahir_system_*test_bench vhpi.log

PHONY: all clean	
