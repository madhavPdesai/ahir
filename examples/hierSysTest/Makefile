#!/bin/bash
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/

all: stages  toplevel  cmodel vhdltb vhdlsim
toSW: stages toplevel cmodel 

# build the lower levels.
stages:  ./Stage1/stage1.aa ./Stage2/stage2.aa
	cd Stage1 && $(MAKE)
	cd Stage2 && $(MAKE)

# generate the integrated vhdl and C
toplevel: hello_world.hsys
	hierSys2Vhdl -a -s ghdl -o vhdl  Stage1/pipes.aa Stage2/pipes.aa Stage1/vhdl/Stage1.hsys Stage2/vhdl/Stage2.hsys hello_world.hsys 
	formatVhdlFiles.py  vhdl/
	hierSys2C  -o aa2c Stage1/pipes.aa Stage2/pipes.aa Stage1/vhdl/Stage1.hsys Stage2/vhdl/Stage2.hsys hello_world.hsys

partition:
	hierSysPartition Stage1/pipes.aa Stage2/pipes.aa Stage1/vhdl/Stage1.hsys Stage2/vhdl/Stage2.hsys hello_world.hsys 

# now build the C code.
cmodel:
	rm -rf objsw
	mkdir objsw
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./Stage1/aa2c/ ./Stage1/aa2c/S1_Stage1_aa_c_model.c -o objsw/S1_aa_c_model.o
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./Stage2/aa2c/  ./Stage2/aa2c/S2_Stage2_aa_c_model.c -o objsw/S2_aa_c_model.o
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./aa2c/ ./aa2c/_Top.c -o objsw/_Top.o
	gcc -g -c -DSW  -I$(AHIR_INCLUDE)  -I./aa2c/ ./Testbench/testbench.c -o objsw/testbench.o
	gcc -g -o  ./bin/TopSW objsw/S1_aa_c_model.o objsw/S2_aa_c_model.o objsw/_Top.o objsw/testbench.o -L $(AHIR_LIB) -lBitVectors  -lPipeHandler -lpthread -lSockPipes

# the VHDL simulation.
vhdltb:  ./Stage1/stage1.aa ./Stage2/stage2.aa ./Testbench/testbench.c
	rm -rf objhw
	mkdir objhw
	gcc -c ./Testbench/testbench.c -I$(AHIR_INCLUDE) -I./Testbench -I./aa2c/ -o objhw/testbench.o
	gcc -o ./bin/TopHW  ./objhw/testbench.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread -LBitVectors

vhdlsim:
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=S1 Stage1/vhdl/S1/Stage1.vhdl
	ghdl -i --work=S2 Stage2/vhdl/S2/Stage2.vhdl
	ghdl -i --work=TopLib vhdl/TopLib/Top.vhdl
	ghdl -i --work=work vhdl/testbench/Top_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi Top_test_bench 

clean: 
	rm -rf Stage1/vhdl/* Stage1/aa2c/* Stage2/vhdl/* Stage2/aa2c/* objhw/ objsw/ ./bin/* vhdl/* *.o *.cf *.log top_test_bench *.ghw


PHONY: all clean	
