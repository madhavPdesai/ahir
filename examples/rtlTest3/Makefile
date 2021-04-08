#!/bin/bash
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/

#all: toplevel  cmodel vhdltb vhdlsim

all: vhdlmodel vhdltb vhdlsim


# generate the integrated vhdl and C
vhdlmodel: src/STAGE.hsys src/SR3.hsys
	rm -rf vhdl
	mkdir vhdl
	hierSys2Vhdl -o vhdl src/STAGE.hsys 
	hierSys2Vhdl -o vhdl -a src/STAGE.hsys src/SR3.hsys
	formatVhdlFiles.py ./

# the VHDL simulation.
vhdltb:  src/STAGE.hsys src/SR3.hsys src/testbench.c
	rm -rf objhw
	mkdir objhw
	gcc -c ./src/testbench.c -I$(AHIR_INCLUDE) -I./src  -o objhw/testbench.o
	gcc -o ./bin/exec_hw  ./objhw/testbench.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread

vhdlsim: 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=SLIB vhdl/SLIB/STAGE.vhdl
	ghdl -i --work=TOPLEVEL vhdl/TOPLEVEL/SR3.vhdl
	ghdl -i --work=work vhdl/testbench/SR3_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi SR3_test_bench 

clean: 
	rm -rf vhdl/* aa2c/* objhw/ objsw/ ./bin/* *.o *.cf *.log *_test_bench *.ghw *_test_bench


PHONY: all clean	
