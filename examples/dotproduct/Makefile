# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include 
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl

#TOPMODULES=-t init -t dotp_experimental
#DEFS=-DEXPERIMENTAL

TOPMODULES=-t init -t dotp_pipelined_unrolled -t dotp_nonpipelined_unrolled -t dotp_pipelined -t dotp_nonpipelined
DEFS=-DPIPELINEDUNROLLED -DPIPELINED -DNONPIPELINEDUNROLLED -DNONPIPELINED

#TOPMODULES=-t init -t dotp_pipelined_unrolled
#DEFS=-DPIPELINEDUNROLLED

VC2VHDLOPTS=-q -a -O -C -w -s ghdl -I 8 -S 3 -D
all: HW 


# steps from Aa to vhdl simulator.
HW: aa2vc vc2vhdl  vhdlsim

# Aa to vC
aa2vc: prog.aa
	AaOpt prog.aa | vcFormat > prog.opt.aa
	Aa2VC -O -C prog.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl $(VC2VHDLOPTS) -e ahir_system $(TOPMODULES) -f prog.vc 
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: TB GHDL
TB:  testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -g -c vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -g -c testbench.c $(DEFS) -I./ -I$(AHIR_INCLUDE)
	gcc -g -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread

GHDL:	ahir_system.vhdl ahir_system_test_bench.vhdl 	
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o *.vc *.cf *.*vhdl *.opt.aa vhdlCStubs.* *.vcd in_data* testbench_hw ahir_system_test_bench vhpi.log
	rm -f run.ghw

PHONY: all clean	
