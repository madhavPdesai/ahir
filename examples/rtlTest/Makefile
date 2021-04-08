#!/bin/bash
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/

#all: toplevel  cmodel vhdltb vhdlsim

all: toplevel cmodel vhdlmodel vhdltb vhdlsim


# generate the integrated vhdl and C
toplevel: src/shift_register.hsys
	#hierSys2Vhdl -s ghdl -o vhdl src/shift_register.hsys
	#formatVhdlFiles.py  vhdl/
	rm -rf aa2c
	mkdir aa2c
	hierSys2C  -o aa2c src/shift_register.hsys
	indent aa2c/*.c
	indent aa2c/*.h

# now build the C code.
cmodel: src/shift_register.hsys src/testbench.c
	rm -rf objsw
	mkdir objsw
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./aa2c/ ./aa2c/_shift_register.c -o objsw/_shift_register.o
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./aa2c/ ./src/testbench.c -o objsw/testbench.o
	gcc -g -o  ./bin/exec_sw objsw/_shift_register.o objsw/testbench.o -L $(AHIR_LIB) -lBitVectors  -lPipeHandlerDebugPthreads -lSockPipes  -lpthread -lRtl2AaMatcher

vhdlmodel: src/shift_register.hsys
	rm -rf vhdl
	mkdir vhdl
	hierSys2Vhdl -o vhdl src/shift_register.hsys
	formatVhdlFiles.py ./

# the VHDL simulation.
vhdltb:  src/shift_register.hsys src/testbench.c
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
	ghdl -i --work=work vhdl/work/shift_register.vhdl
	ghdl -i --work=work vhdl/testbench/shift_register_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi shift_register_test_bench 

clean: 
	rm -rf vhdl/* aa2c/* objhw/ objsw/ ./bin/* *.o *.cf *.log top_test_bench *.ghw *_test_bench


PHONY: all clean	
