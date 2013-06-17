# build software version of testbench (to check the "desired behaviour")
AHIR_RELEASE=/home/madhav/ahirgit/ahir/release/
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/CtestBench/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/pipeHandler/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/pthreadUtils/include
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
SRC=./src

OBJSW=./objsw

all: SW HW 

toAA: c2llvmbc llvmbc2aa  aalink 
toVC: toAA aa2vc
toVHDL: toVC vc2vhdl

#CCSW=clang
#CCSW_OPTS=-std=gnu89
CCSW=gcc
CCSW_OPTS=-g



# llvm2aa opts: non-pipelined case, do not extract-do-while.
#LLVM2AAOPTS=
LLVM2AAOPTS=-extract_do_while=true -pipedepths=pipedepths.txt

PROGDEFS=-DPIPELINE
#PROGDEFS=-DNPIPELINE
TOPMODULES=-T MatMulDaemon  -T getDiagPtr -T getLPtr -T getUPtr -T getLowerPtr -T getUpperPtr -T getB 


OPTOPTIONS=-O3 --indvars --loopsimplify

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: $(SRC)/MatMulVec.c $(SRC)/MatMulDriver.c  $(SRC)/MatMulVec.h  $(FUNCTIONLIB)/src/timer.c 
	$(CCSW) $(CCSW_OPTS) -c -o $(OBJSW)/MatMulVec.o -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include -I$(SRC) $(SRC)/MatMulVec.c
	$(CCSW) $(CCSW_OPTS) -c -DSW -o $(OBJSW)/MatMulDriver.o  $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include -I$(SRC) -I$(PTHREADUTILS_INCLUDE)  $(SRC)/MatMulDriver.c
	$(CCSW) $(CCSW_OPTS) -c -DSW -o $(OBJSW)/timer.o $(PROGDEFS) -I$(FUNCTIONLIB)/include -I$(SRC) $(FUNCTIONLIB)/src/timer.c
	$(CCSW) -g -o testbench_sw $(OBJSW)/MatMulVec.o $(OBJSW)/MatMulDriver.o $(OBJSW)/timer.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread -lrt -lm

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa  aalink aa2vc  vc2vhdl  vhdlsim

AA2VHDL: aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: $(SRC)/MatMulVec.c $(SRC)/MatMulVec.h 
	clang -std=gnu89 $(PROGDEFS)  -I$(SOCKETLIB_INCLUDE) -I$(FUNCTIONLIB)/include -emit-llvm -c $(SRC)/MatMulVec.c
	opt $(OPTOPTIONS) MatMulVec.o -o MatMulVec.opt.o
	llvm-dis MatMulVec.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  MatMulVec.opt.o 
	llvm2aa $(LLVM2AAOPTS)  MatMulVec.opt.o | vcFormat >  MatMulVec.aa

# Aa to vC
aalink: MatMulVec.aa 
	AaLinkExtMem -I 1024 -E null_pool MatMulVec.aa $(FUNCTIONLIB)/Aa/timer.aa | vcFormat > MatMulVec.linked.aa
	AaOpt -B -I null_pool MatMulVec.linked.aa | vcFormat > MatMulVec.linked.opt.aa

aa2vc: MatMulVec.linked.opt.aa
	Aa2VC -O -C MatMulVec.linked.opt.aa | vcFormat > MatMulVec.vc

# vC to VHDL
vc2vhdl: MatMulVec.vc
	vc2vhdl -D -S 4 -O -I 16 -v -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f MatMulVec.vc -L $(FUNCTIONLIB)/timer.list
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: TB GHDL

TB:   $(SRC)/MatMulDriver.c vhdlCStubs.h vhdlCStubs.c
	gcc -c -g vhdlCStubs.c  -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c -g $(SRC)/MatMulDriver.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw MatMulDriver.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread

GHDL:  ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/MatMulDriver.c vhdlCStubs.h vhdlCStubs.c
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst pipeHandler.log *.xrpt _xmsgs *.ngc *.ghw *.srp

PHONY: all clean	
