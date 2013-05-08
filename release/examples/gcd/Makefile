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
all: SW HW 

# llvm2aa opts: non-pipelined case, do not extract-do-while.
#LLVM2AAOPTS=
LLVM2AAOPTS=-extract_do_while=true --storageinit=true

#program defs: plain case, do not unroll
PROGDEFS=
#PROGDEFS=-DUNROLL

TOPMODULES=-T gcd_daemon 


# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: $(SRC)/gcd.c $(SRC)/divider.c $(SRC)/test_gcd.c  $(SRC)/gcd.h $(SRC)/test_gcd.c  $(SRC)/divider.h
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include -I$(SRC) $(SRC)/divider.c
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(FUNCTIONLIB)/include -I$(SRC) $(SRC)/gcd.c
	gcc -g -c -DSW $(PROGDEFS) -I$(PIPEHANDLER_INCLUDE) -I$(PTHREADUTILS_INCLUDE) -I$(SRC) $(SRC)/test_gcd.c
	gcc -g -o testbench_sw divider.o gcd.o test_gcd.o -L$(PIPEHANDLER_LIB) -lPipeHandler -lpthread

# five steps from C to vhdl simulator.
HW: c2llvmbc llvmbc2aa  aalink aa2vc  vc2vhdl  vhdlsim

AA2VHDL: aa2vc vc2vhdl vhdlsim

# C to llvm byte-code.. use clang.
c2llvmbc: $(SRC)/gcd.c $(SRC)/gcd.h $(SRC)/divider.c $(SRC)/divider.h
	clang -O3 -std=gnu89 $(PROGDEFS)  -I$(SOCKETLIB_INCLUDE) -I$(FUNCTIONLIB)/include -emit-llvm -c $(SRC)/gcd.c
	opt --indvars --loopsimplify gcd.o -o gcd.opt.o
	llvm-dis gcd.opt.o
	clang -O3 -std=gnu89 $(PROGDEFS)  -I$(SOCKETLIB_INCLUDE) -I$(FUNCTIONLIB)/include -emit-llvm -c $(SRC)/divider.c
	opt --indvars --loopsimplify divider.o -o divider.opt.o
	llvm-dis divider.opt.o

# llvm byte-code to Aa..
llvmbc2aa:  divider.opt.o  gcd.opt.o
	llvm2aa $(LLVM2AAOPTS)  divider.opt.o | vcFormat >  divider.aa
	llvm2aa $(LLVM2AAOPTS)  gcd.opt.o | vcFormat >  gcd.aa

# Aa to vC
aalink: divider.aa gcd.aa 
	AaLinkExtMem gcd.aa divider.aa | vcFormat > prog.linked.aa
	AaOpt prog.linked.aa | vcFormat > prog.linked.opt.aa

aa2vc: prog.linked.opt.aa
	Aa2VC -O -C prog.linked.opt.aa | vcFormat > prog.vc

# vC to VHDL
vc2vhdl: prog.vc
	vc2vhdl -S 4 -O -I 16 -v -q -a -C -e ahir_system -w -s ghdl $(TOPMODULES) -f prog.vc -L $(FUNCTIONLIB)/fpu.list
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/test_gcd.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c  -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -c $(SRC)/test_gcd.c -I$(PTHREADUTILS_INCLUDE) -I$(SRC) -I./ -I$(SOCKETLIB_INCLUDE)
	gcc -o testbench_hw test_gcd.o vhdlCStubs.o  -L$(SOCKETLIB_LIB) -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Utility_Package.vhdl
	ghdl -i --work=work $(VHDL_VHPI_LIB)/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(SOCKETLIB_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst pipeHandler.log *.xrpt _xmsgs *.ngc *.ghw *.srp

PHONY: all clean	
