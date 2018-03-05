# Some useful references.
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/

# src file
SRC=./src

# make rules.
all: AA2C SW HW 
TOAA:c2llvmbc llvmbc2aa  aalink
TOVC:c2llvmbc llvmbc2aa  aalink aa2vc 
VC2VHDL: vc2vhdl  vhdlsim
AA2VHDLSIM: aa2vc  vc2vhdl  vhdlsim
TOVHDL:TOVC vc2vhdl

LLVM2AAOPTS=

# the top-level module.
TOPMODULES=-T firDaemon 


# to verify the Aa code, we convert it to C and test it.
AA2C: $(SRC)/prog.aa
	Aa2C -T firDaemon $(SRC)/prog.aa

#  the software test executable..
SW: AA2C SWW
SWW: aa_c_model.c  $(SRC)/testbench.c 
	gcc -g -c -DSW -I./ -I$(AHIR_INCLUDE) aa_c_model.c
	gcc -g -c -DSW -I./ -I$(SRC) -I$(AHIR_INCLUDE) $(SRC)/testbench.c
	gcc -g -o testbench_sw aa_c_model.o testbench.o -lBitVectors -lSockPipes -lPipeHandler -L $(AHIR_LIB) -lpthread


# three steps from Aa to vhdl simulator.
HW: aa2vc  vc2vhdl  vhdlsim

# Aa to vC
aa2vc: $(SRC)/prog.aa
	Aa2VC -O -C $(SRC)/prog.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -O -S 4 -I 2 -v -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc -L $(FUNCTIONLIB)/fpu.list
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c  -I$(SRC) -I./ -I$(AHIR_INCLUDE)
	gcc -c $(SRC)/testbench.c -I$(AHIR_INCLUDE) -I$(SRC) -I./ 
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw *.dot aa_c_model.*

PHONY: all clean	
