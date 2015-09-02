# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl/

all: SW HW AA2C

# compile with SW defined.
# note the use of IOLIB in building the testbench.
SW: src/processor.c  src/testbench.c 
	gcc -g -c -o objsw/processor.o -DSW -I$(AHIR_INCLUDE) src/processor.c
	gcc -g -c -o objsw/testbench.o -DSW -I$(AHIR_INCLUDE) src/testbench.c
	gcc -g -o testbench_sw objsw/processor.o objsw/testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread

# four steps from C to vhdl simulation.
HW: aa2vc vc2vhdl vhdltb ghdlsim 
TOVHDL: aa2vc vc2vhdl

# Aa 2 c
AA2C: src/processorSuper.aa
	Aa2C $(TOPMODULES) -o aa2c src/processorSuper.aa  
	gcc -g -c -o objaa2c/testbench.o -DAA2C -Iaa2c -I$(AHIR_INCLUDE) src/testbench.c
	gcc -g -c -o objaa2c/aa_c_model.o -Iaa2c -I$(AHIR_INCLUDE) aa2c/aa_c_model.c
	gcc -g -o testbench_aa2c objaa2c/aa_c_model.o objaa2c/testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread -lBitVectors

# Aa to vC
aa2vc: src/processorSuper.aa
	AaOpt -B src/processorSuper.aa | vcFormat > processorSuper.opt.aa
	Aa2VC -O -C processorSuper.opt.aa  | vcFormat > processorSuper.vc

# vC to VHDL
TOPMODULES=-T fetch_daemon -T execute_daemon -T reg_read_daemon -T reg_write_daemon 
topMODULES=-t write_to_mem

vc2vhdl: processorSuper.vc
	vc2vhdl -v -D -O -C -e ahir_system -w -s ghdl $(TOPMODULES) $(topMODULES)  -f processorSuper.vc
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	rm -f *.unformatted_vhdl

# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdltb: src/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c -o objhw/vhdlCStubs.o vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -c -o objhw/testbench.o src/testbench.c -I./ -I$(AHIR_INCLUDE)
	gcc -o testbench_hw objhw/testbench.o objhw/vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLib -lpthread

ghdlsim: ahir_system.vhdl ahir_system_test_bench.vhdl 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=work ahir_system_global_package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_* ahir_system_*test_bench vhpi.log *.dot *.ghw aa2c/*.* objsw/*.* objhw/*.* objaa2c/*.* *.vc

PHONY: all clean	
