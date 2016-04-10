# build software version of testbench (to check the "desired behaviour")
SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl/
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
#DEFS= -DADD -DMUL -DDOT -DCMP
DEFS= -DADD -DMUL -DFLOATRESIZE
#DEFS= -DADD -DMUL -DSUB -DTOINT
#DEFS= -DCMP
#DEFS=-DBUG
#DEFS=-DDOUBLEBUG


#TOPMODULES=-t fpmul -t fpadd -t dotProduct -t fpcmplt -t fpcmpgt -t fpcmpeq -t fpsub
TOPMODULES= -t fpadd -t fpincr -t fpmul -t double_to_float -t float_to_double
#TOPMODULES= -t fpadd -t fpmul -t fpsub -t fpincr -t fp2int -t fp2uint -t fpincrd
#TOPMODULES= -t fpsub
#TOPMODULES= -t fpcmplt -t fpcmpgt -t fpcmpeq -t fpsub
#TOPMODULES= -t fpincrd

all: SW HW 

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: prog.c prog.h testbench.c 
	gcc -c -DSW -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include $(DEFS) prog.c
	gcc -c -DSW -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include  $(DEFS)  testbench.c
	gcc -c -DSW -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include  $(DEFS)  $(FUNCTIONLIB)/src/fpu.c
	gcc -o testbench_sw prog.o fpu.o testbench.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl vhdlsim
TOVHDL: c2llvmbc llvmbc2aa aa2vc vc2vhdl 

# C to llvm byte-code.. use clang.
c2llvmbc: prog.c prog.h testbench.c
	clang -O3 -std=gnu89 $(DEFS) -I$(FUNCTIONLIB)/include -I$(SOCKETLIB_INCLUDE) -emit-llvm -c prog.c
	llvm-dis prog.o

# llvm byte-code to Aa..
llvmbc2aa:  prog.o
	llvm2aa --storageinit=true prog.o | vcFormat >  prog.aa

# Aa to vC
aa2vc: prog.aa
	AaLinkExtMem prog.aa $(FUNCTIONLIB)/Aa/fpu.aa | vcFormat > prog.linked.aa
	Aa2VC -O -C prog.linked.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -a -q -C -e ahir_system -w -s ghdl $(TOPMODULES) -L $(FUNCTIONLIB)/fpu.list -f prog.vc 
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c $(DEFS) testbench.c -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=ahir_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
UNISIM=$(AHIR_RELEASE)/vhdl/ghdl/unisim
postsynthvhdlsim: ahir_system_synth.vhd ahir_system_test_bench.vhdl 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=ahir_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work --ieee=synopsys -fexplicit -P$(UNISIM) ahir_system_global_package.vhdl
	ghdl -i --work=work --ieee=synopsys -fexplicit -P$(UNISIM) ahir_system_synth.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work --ieee=synopsys -fexplicit -P$(UNISIM) -Wc,-g -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst

PHONY: all clean postsynthvhdlsim
