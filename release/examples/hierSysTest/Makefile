#!/bin/bash
AHIR_RELEASE=/home/madhav/AHIR/gitHub/ahir/release
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/CtestBench/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/pipeHandler/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/pthreadUtils/include
GNUPTHUTILS_INCLUDE=$(AHIR_RELEASE)/GnuPthUtils/include
BITVECTOR_INCLUDE=$(AHIR_RELEASE)/BitVectors/include
BITVECTOR_LIB=$(AHIR_RELEASE)/BitVectors/lib
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
	hierSys2Vhdl -s ghdl -o vhdl  Stage1/pipes.aa Stage2/pipes.aa Stage1/vhdl/Stage1.hsys Stage2/vhdl/Stage2.hsys hello_world.hsys 
	hierSys2C  -o aa2c Stage1/pipes.aa Stage2/pipes.aa Stage1/vhdl/Stage1.hsys Stage2/vhdl/Stage2.hsys hello_world.hsys

# now build the C code.
cmodel:
	rm -rf objsw
	mkdir objsw
	gcc -g -c -DSW  -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -I$(BITVECTOR_INCLUDE)  -I./Stage1/aa2c/ ./Stage1/aa2c/S1_aa_c_model.c -o objsw/S1_aa_c_model.o
	gcc -g -c -DSW  -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -I$(BITVECTOR_INCLUDE)  -I./Stage2/aa2c/  ./Stage2/aa2c/S2_aa_c_model.c -o objsw/S2_aa_c_model.o
	gcc -g -c -DSW  -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -I$(BITVECTOR_INCLUDE)  -I./aa2c/ ./aa2c/_Top.c -o objsw/_Top.o
	gcc -g -c -DSW  -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -I./aa2c/ ./Testbench/testbench.c -o objsw/testbench.o
	gcc -g -o  ./bin/TopSW objsw/S1_aa_c_model.o objsw/S2_aa_c_model.o objsw/_Top.o objsw/testbench.o -L $(PIPEHANDLER_LIB) -L$(BITVECTOR_LIB) -lBitVectors  -lPipeHandler -lpthread

# the VHDL simulation.
vhdltb:  ./Stage1/stage1.aa ./Stage2/stage2.aa ./Testbench/testbench.c
	rm -rf objhw
	mkdir objhw
	gcc -c ./Testbench/testbench.c -I$(PTHREADUTILS_INCLUDE) -I./Testbench -I./aa2c/ -I$(SOCKETLIB_INCLUDE) -o objhw/testbench.o
	gcc -o ./bin/TopHW  ./objhw/testbench.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread

vhdlsim:
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=S1 Stage1/vhdl/Stage1_global_package.vhdl
	ghdl -i --work=S1 Stage1/vhdl/Stage1.vhdl
	ghdl -i --work=S2 Stage2/vhdl/Stage2_global_package.vhdl
	ghdl -i --work=S2 Stage2/vhdl/Stage2.vhdl
	ghdl -i --work=work Top.vhdl
	ghdl -i --work=work Top_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi Top_test_bench 

clean: 
	rm -rf Stage1/vhdl/* Stage1/aa2c/* Stage2/vhdl/* Stage2/aa2c/* objhw/ objsw/ ./bin/* *.*vhdl *.o *.cf *.log top_test_bench *.ghw


PHONY: all clean	
