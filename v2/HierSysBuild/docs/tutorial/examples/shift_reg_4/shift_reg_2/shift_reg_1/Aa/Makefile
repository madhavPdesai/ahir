# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/
SRC=./src
all: HW 
AA2C_PREFIX=shift_reg_lib_shift_reg_1_
TOVC:aalink aa2vc 
VC2VHDL: vc2vhdl  vhdlsim
AA2VHDLSIM: aa2vc  vc2vhdl  vhdlsim
TOVHDL:TOVC vc2vhdl

TOPMODULES=-T shift_reg_1_daemon 



# five steps from C to vhdl simulator.
HW: aalink aa2c aa2vc  vc2vhdl  

AA2VHDL: aa2vc vc2vhdl vhdlsim

# Aa to vC
aalink: ./shift_reg_1.aa 
	rm -rf .Aa
	mkdir .Aa
	AaLinkExtMem shift_reg_1.aa | vcFormat > .Aa/prog.linked.aa
	AaOpt -B .Aa/prog.linked.aa | vcFormat > .Aa/prog.linked.opt.aa

aa2vc: .Aa/prog.linked.opt.aa
	rm -rf .vC
	mkdir .vC
	Aa2VC -O -C .Aa/prog.linked.opt.aa | vcFormat > .vC/prog.vc

aa2c:  .Aa/prog.linked.opt.aa
	rm -rf aa2c
	mkdir aa2c
	Aa2C -P $(AA2C_PREFIX)  $(TOPMODULES) -o aa2c .Aa/prog.linked.opt.aa

# vC to VHDL
vc2vhdl: .vC/prog.vc
	rm -rf vhdl
	mkdir vhdl
	mkdir vhdl/shift_reg_lib
	mkdir vhdl/testbench
	rm -rf hsys
	mkdir hsys
	vc2vhdl -H -U -O -S 4 -I 2 -a -C -e shift_reg_1 -w -s ghdl -W shift_reg_lib $(TOPMODULES) -f .vC/prog.vc 
	vhdlFormat < shift_reg_1_global_package.unformatted_vhdl > vhdl/shift_reg_lib/shift_reg_1_global_package.vhdl
	vhdlFormat < shift_reg_1.unformatted_vhdl > vhdl/shift_reg_lib/shift_reg_1.vhdl
	vhdlFormat < shift_reg_1_test_bench.unformatted_vhdl > vhdl/testbench/shift_reg_1_test_bench.vhdl
	rm -f *.unformatted_vhdl
	mv *.hsys hsys


clean:
	rm -rf *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log *.lso xst .vC .Aa *.ngc *_xmsgs *.xrpt pipeHandler.log *.srp *.ghw *.dot hsys/*

PHONY: all clean	
