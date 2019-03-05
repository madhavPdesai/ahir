# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
SRC=./src
all: SW HW VHDLSIM

#  This produces a software test executable
SW: $(SRC)/prog.c $(SRC)/testbench.c 
	gcc  -g -c -DSW -I$(SRC) -I$(AHIR_INCLUDE) $(SRC)/prog.c
	gcc  -g -c -DSW -I$(SRC) -I$(AHIR_INCLUDE) $(SRC)/testbench.c
	gcc  -g -o testbench_sw prog.o testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread

HW: c2llvmbc llvmbc2aa aa2vc vc2vhdl

#llvmbc2aa aa2vc vc2vhdl

c2llvmbc: $(SRC)/prog.c 
	clang -O3 -std=gnu89 -I$(AHIR_INCLUDE) -emit-llvm -c $(SRC)/prog.c
	opt --indvars --loopsimplify prog.o -o prog.opt.o
	llvm-dis prog.opt.o

llvmbc2aa: prog.opt.o 
	llvm2aa -pipedepths=pipedepths.txt prog.opt.o | vcFormat > prog.aa

aa2vc: prog.aa
	# -C: generate vhdlCStubs for verification of hardware.
	# -O: optimize hardware
	Aa2VC -C -O prog.aa | vcFormat > prog.vc

vc2vhdl: prog.vc
	# -T sortDaemon: top-level module is sortDaemon, and this is started
	#		  by default.
	# -O : optimize
	# -e ahir_system: Vhdl toplevel entity name is ahir_system.
	# -f prog.vc:   prog.vc is an input VC file. 
	# -w: create output vhdl files named ahir_system*.unformatted_vhdl
	# -C: create testbench to connect to C testbench
	vc2vhdl -T sortDaemon -O -e ahir_system -f prog.vc -w -C
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl


VHDLSIM: ahir_system.vhdl ahir_system_test_bench.vhdl $(SRC)/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c vhdlCStubs.c  -I$(SRC) -I./ -I$(AHIR_INCLUDE)
	gcc -c $(SRC)/testbench.c -I$(AHIR_INCLUDE) -I$(SRC) -I./ 
	# Note: use SocketLibPipeHandler instead of of PipeHandler!
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLibPipeHandler -lpthread
	#  GHDL model building commands.... 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

	
	
clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.aa *.vc *.lso xst *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw *.dot



PHONY: all clean	
