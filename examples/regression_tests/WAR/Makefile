# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
SRC=./src

#TOPMODULES=-t init -t dotp_experimental
#DEFS=-DEXPERIMENTAL

TOPMODULES=-t init -t dot_product -t dot_product_unrolled

VC2VHDLOPTS=-a -O -C -w -s ghdl -D
all: HW 


# steps from Aa to vhdl simulator.
HW: aalink aa2vc vc2vhdl  vhdlsim

# Aa to vC
aalink: $(SRC)/prog.aa
	AaOpt -B $(SRC)/prog.aa | vcFormat > prog.opt.aa

aa2vc:  prog.opt.aa
	Aa2VC -O -C prog.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl $(VC2VHDLOPTS) -e ahir_system $(TOPMODULES) -f prog.vc 
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
vhdlsim: TB GHDL
TB:  $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -g -c vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -g -c $(SRC)/testbench.c $(DEFS) -I./ -I$(AHIR_INCLUDE)
	gcc -g -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread

GHDL:	ahir_system.vhdl ahir_system_test_bench.vhdl 	
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=GhdlLink $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o *.vc *.cf *.*vhdl *.opt.aa vhdlCStubs.* *.vcd in_data* testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
