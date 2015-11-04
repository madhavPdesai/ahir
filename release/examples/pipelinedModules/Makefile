# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
AHIR_VHDL=$(AHIR_RELEASE)/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary
#DEFS= -DADD -DMUL -DDOT -DCMP
#DEFS= -DADD
#DEFS= -DADD -DMUL -DSUB
#DEFS= -DCMP
#DEFS=-DBUG
DEFS= -DDOT -DCONCAT -DPMUX


#TOPMODULES=-t fpmul -t fpadd -t dotProduct -t fpcmplt -t fpcmpgt -t fpcmpeq -t fpsub
#TOPMODULES= -t fpadd
#TOPMODULES= -t fpadd -t fpmul -t fpsub -t fpincr
#TOPMODULES= -t fpsub
#TOPMODULES= -t fpcmplt -t fpcmpgt -t fpcmpeq -t fpsub
TOPMODULES= -t dotProduct -t concat -t pmux

all: SW HW 
TOVC: c2llvmbc llvmbc2aa aa2vc 
TOVHDL: TOVC vc2vhdl

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: prog.c prog.h testbench.c 
	gcc -c -DSW -I$(AHIR_INCLUDE) -I$(FUNCTIONLIB)/include $(DEFS) prog.c
	gcc -c -DSW -I$(AHIR_INCLUDE) -I$(FUNCTIONLIB)/include  $(DEFS)  testbench.c
	gcc -c -DSW -I$(AHIR_INCLUDE) -I$(FUNCTIONLIB)/include  $(DEFS)  $(FUNCTIONLIB)/src/fpu.c
	gcc -o testbench_sw prog.o fpu.o testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c prog.h testbench.c
	clang -O3 -std=gnu89 $(DEFS) -I$(FUNCTIONLIB)/include -I$(AHIR_INCLUDE) -emit-llvm -c prog.c
	llvm-dis prog.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.o
	llvm2aa --storageinit=true prog.o | vcFormat >  prog.aa

# Aa to vC
aa2vc: prog.aa pipelined.Aa
	AaLinkExtMem prog.aa pipelined.Aa | vcFormat > prog.linked.aa
	Aa2VC -O -C prog.linked.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -O -a -C  -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc 
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -c $(DEFS) testbench.c -I./ -I$(AHIR_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(AHIR_VHDL)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(AHIR_VHDL)/ahir.vhdl
	ghdl -i --work=ahir_ieee_proposed  $(AHIR_VHDL)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst

PHONY: all clean 
