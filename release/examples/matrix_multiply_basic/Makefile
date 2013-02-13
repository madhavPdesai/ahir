# build software version of testbench (to check the "desired behaviour")
SOCKETLIB_INCLUDE=../../CtestBench/include
SOCKETLIB_LIB=../../CtestBench/lib
PIPEHANDLER_INCLUDE=../../pipeHandler/include
PIPEHANDLER_LIB=../../pipeHandler/lib
PTHREADUTILS_INCLUDE=../../pthreadUtils/include
VHDL_LIB=../../vhdl
VHDL_VHPI_LIB=../../CtestBench/vhdl
FUNCTIONLIB=../../../v2/functionLibrary/
all: SW HW 
LLVM2AAOPTS=-extract_do_while=true --storageinit=true
#LLVM2AAOPTS=--storageinit=true


PROGDEFS=
#PROGDEFS=-DALT

TOPMODULES=-T mmultiply


# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: prog.c prog.h testbench.c 
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include prog.c
	gcc -g -c -DSW -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include $(FUNCTIONLIB)/src/fpu.c
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE)  testbench.c
	gcc -g -o testbench_sw prog.o testbench.o fpu.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa  aa2vc  vc2vhdl  vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c prog.h
	clang -O3 -std=gnu89 $(PROGDEFS)  -I$(SOCKETLIB_INCLUDE) -I$(FUNCTIONLIB)/include -emit-llvm -c prog.c
	opt --indvars --loopsimplify prog.o -o prog.opt.o
	llvm-dis prog.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.opt.o 
	llvm2aa $(LLVM2AAOPTS)  prog.opt.o | vcFormat >  prog.aa

# Aa to vC
aa2vc: prog.aa $(FUNCTIONLIB)/Aa/fpu.aa
	AaLinkExtMem prog.aa $(FUNCTIONLIB)/Aa/fpu.aa | vcFormat > prog.linked.aa
	AaOpt  prog.linked.aa | vcFormat > prog.linked.opt.aa
	Aa2VC -O -C prog.linked.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -S 4 -O -I 16 -v -q -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc -L $(FUNCTIONLIB)/fpu.list
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c testbench.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Utility_Package.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst

PHONY: all clean	
