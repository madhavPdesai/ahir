#!/bin/bash
AHIR_RELEASE=/home/madhav/AHIR/gitHub/ahir/release
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/

#all: toplevel  cmodel vhdltb vhdlsim

all: toplevel cmodel


# generate the integrated vhdl and C
toplevel: src/shift_register.hsys
	#hierSys2Vhdl -s ghdl -o vhdl src/shift_register.hsys
	#formatVhdlFiles.py  vhdl/
	hierSys2C  -o aa2c src/shift_register.hsys

# now build the C code.
cmodel: src/shift_register.hsys src/testbench.c
	rm -rf objsw
	mkdir objsw
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./aa2c/ ./aa2c/_shift_register.c -o objsw/_shift_register.o
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./aa2c/ ./src/testbench.c -o objsw/testbench.o
	gcc -g -o  ./bin/exec_sw objsw/_shift_register.o objsw/testbench.o -L $(AHIR_LIB) -lBitVectors  -lPipeHandlerDebug -lpthread -lRtl2AaMatcher

# the VHDL simulation.
#vhdltb:  ./Stage1/stage1.aa ./Stage2/stage2.aa ./Testbench/testbench.c
	#rm -rf objhw
	#mkdir objhw
	#gcc -c ./src/testbench.c -I$(AHIR_INCLUDE) -I./src -I./aa2c/ -o objhw/testbench.o
	#gcc -o ./bin/exec_hw  ./objhw/testbench.o  -L$(AHIR_LIB) -lSocketLib -lpthread

#vhdlsim:
	#ghdl --clean
	#ghdl --remove
	#ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	#ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	#ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	#ghdl -i --work=S1 Stage1/vhdl/S1/Stage1.vhdl
	#ghdl -i --work=S2 Stage2/vhdl/S2/Stage2.vhdl
	#ghdl -i --work=TopLib vhdl/TopLib/Top.vhdl
	#ghdl -i --work=work vhdl/work/Top_test_bench.vhdl
	#ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi Top_test_bench 

clean: 
	rm -rf vhdl/* aa2c/* objhw/ objsw/ ./bin/* *.o *.cf *.log top_test_bench *.ghw


PHONY: all clean	
