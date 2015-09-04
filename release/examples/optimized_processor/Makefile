# build software version of testbench (to check the "desired behaviour")
AHIR_INCLUDE=$(AHIR_RELEASE)/include
AHIR_LIB=$(AHIR_RELEASE)/lib
VHDL_LIB=$(AHIR_RELEASE)/vhdl/

TOPMODULES=-T decode_daemon -T fetch_daemon -T execute_daemon -T reg_read_daemon -T reg_write_daemon  -T writeback_daemon -T write_to_mem_daemon -T mem_data_access_daemon -T mem_instr_access_daemon 

CORETOPMODULES=-T decode_daemon -T fetch_daemon -T execute_daemon -T writeback_daemon
MEMTOPMODULES=-T write_to_mem_daemon -T mem_data_access_daemon -T mem_instr_access_daemon 
REGFILETOPMODULES=-T reg_read_daemon -T reg_write_daemon  
all: SW HW AA2C

# compile with SW defined.
SW: testbench/processor.c  testbench/testbench.c 
	gcc -g -c -o objsw/processor.o -DSW -I$(AHIR_INCLUDE) testbench/processor.c
	gcc -g -c -o objsw/testbench.o -DSW -I$(AHIR_INCLUDE) testbench/testbench.c
	gcc -g -o testbench_sw objsw/processor.o objsw/testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread

# four steps from C to vhdl simulation.
HW: aa2vc vc2vhdl vhdltb ghdlsim 
TOVHDL: aa2vc vc2vhdl


# Aa 2 c
AAFILES=common/constants.aa common/pipes.aa core/core.aa mem/mem.aa regfile/regfile.aa 
AA2C: $(AAFILES) testbench/testbench.c
	Aa2C $(TOPMODULES) -o aa2c $(AAFILES)
	gcc -g -c -o objaa2c/testbench.o -DAA2C -Iaa2c -I$(AHIR_INCLUDE) testbench/testbench.c
	gcc -g -c -o objaa2c/aa_c_model.o -Iaa2c -I$(AHIR_INCLUDE) aa2c/aa_c_model.c
	gcc -g -o testbench_aa2c objaa2c/aa_c_model.o objaa2c/testbench.o -L$(AHIR_LIB) -lPipeHandler -lpthread -lBitVectors

# Aa to vC
aa2vc: $(AAFILES)
	AaOpt -B $(AAFILES) | vcFormat > processor.opt.aa
	Aa2VC -O -C processor.opt.aa  | vcFormat > processor.vc

# vC to VHDL

vc2vhdl: core mem regfile processor

core: processor.vc
	vc2vhdl -H -v -D -O -C -e core -w -s ghdl $(CORETOPMODULES) -f processor.vc
	vhdlFormat < core_test_bench.unformatted_vhdl > vhdl/core_test_bench.vhdl
	vhdlFormat < core_global_package.unformatted_vhdl > vhdl/core_global_package.vhdl
	vhdlFormat < core.unformatted_vhdl > vhdl/core.vhdl
	rm -f *.unformatted_vhdl

mem: processor.vc
	vc2vhdl -H -v -D -O -C -e mem -w -s ghdl $(MEMTOPMODULES) -f processor.vc
	vhdlFormat < mem_test_bench.unformatted_vhdl > vhdl/mem_test_bench.vhdl
	vhdlFormat < mem_global_package.unformatted_vhdl > vhdl/mem_global_package.vhdl
	vhdlFormat < mem.unformatted_vhdl > vhdl/mem.vhdl
	rm -f *.unformatted_vhdl

regfile: processor.vc
	vc2vhdl -H -v -D -O -C -e regfile -w -s ghdl $(REGFILETOPMODULES) -f processor.vc
	vhdlFormat < regfile_test_bench.unformatted_vhdl > vhdl/regfile_test_bench.vhdl
	vhdlFormat < regfile_global_package.unformatted_vhdl > vhdl/regfile_global_package.vhdl
	vhdlFormat < regfile.unformatted_vhdl > vhdl/regfile.vhdl
	rm -f *.unformatted_vhdl


processor: processor.hsys common/pipes.aa 
	hierSys2Vhdl  -o vhdl -s ghdl common/pipes.aa core.hsys mem.hsys regfile.hsys processor.hsys
	vhdlFormat < vhdl/work/processor_test_bench.unformatted_vhdl > vhdl/processor_test_bench.vhdl
	vhdlFormat < vhdl/work/processor.unformatted_vhdl > vhdl/processor.vhdl
	rm -rf vhdl/work


# build testbench and ghdl executable
# note the use of SOCKETLIB in building the testbench.
vhdltb: testbench/testbench.c vhdlCStubs.h vhdlCStubs.c
	gcc -c -o objhw/vhdlCStubs.o vhdlCStubs.c -I./ -I$(AHIR_INCLUDE)
	gcc -c -o objhw/testbench.o testbench/testbench.c -I./ -I$(AHIR_INCLUDE)
	gcc -o testbench_hw objhw/testbench.o objhw/vhdlCStubs.o  -L$(AHIR_LIB) -lSocketLib -lpthread

ghdlsim: vhdl/processor.vhdl vhdl/processor_test_bench.vhdl 
	ghdl --clean
	ghdl --remove
	ghdl -i --work=GhdlLink  $(VHDL_LIB)/GhdlLink.vhdl
	ghdl -i --work=aHiR_ieee_proposed  $(VHDL_LIB)/aHiR_ieee_proposed.vhdl
	ghdl -i --work=ahir  $(VHDL_LIB)/ahir.vhdl
	ghdl -i --work=work vhdl/core_global_package.vhdl
	ghdl -i --work=work vhdl/core.vhdl
	ghdl -i --work=work vhdl/mem_global_package.vhdl
	ghdl -i --work=work vhdl/mem.vhdl
	ghdl -i --work=work vhdl/regfile_global_package.vhdl
	ghdl -i --work=work vhdl/regfile.vhdl
	ghdl -i --work=work vhdl/processor.vhdl
	ghdl -i --work=work vhdl/processor_test_bench.vhdl
	ghdl -m --work=work -Wl,-L$(AHIR_LIB) -Wl,-lVhpi processor_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_port* testbench_* ahir_system_*test_bench vhpi.log *.dot *.ghw aa2c/*.* objsw/*.* objhw/*.* objaa2c/*.* *.vc vhdl/*.*

PHONY: all clean	
