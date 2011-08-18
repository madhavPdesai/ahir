# build software version of testbench (to check the "desired behaviour")
# note: read/write functions will be found in ../../../iolib/
all: SW HW 

SW: prog.c prog.h testbench.c 
	gcc -c -DSW -I../../../iolib prog.c
	gcc -c -DSW -I../../../iolib testbench.c
	gcc -o testbench_sw prog.o testbench.o -L../../../iolib -lio -lpthread

HW: prog.c prog.h testbench.c
	clang -std=gnu89 -I../../../iolib/ -emit-llvm -c prog.c
	#llvm-dis prog.o
	opt -O3	 prog.o > prog.opt.o
	#llvm-dis prog.opt.o
	llvm2aa prog.opt.o | vcFormat >  prog.opt.o.aa
	Aa2VC -O -C prog.opt.o.aa | vcFormat > prog.opt.o.aa.vc
	vc2vhdl -C -e ahir_system -w -s ghdl -T accumulate -t set_sum -t get_sum -f prog.opt.o.aa.vc 
	vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
	vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
	gcc -c vhdlCStubs.c -I./ -I../../include 
	gcc -c testbench.c -I./ -I../../include
	gcc -o testbench_hw testbench.o vhdlCStubs.o  -L../../lib -lSocketLib -lpthread
	ghdl --clean
	ghdl --remove
	ghdl -i --work=ahir  /home/madhav/ahirgit/AHIR/vhdl/release/ahir.vhdl
	ghdl -i --work=ieee_proposed  /home/madhav/ahirgit/AHIR/vhdl/release/ieee_proposed.vhdl
	ghdl -i --work=work /home/madhav/ahirgit/AHIR/v2/CtestBench/vhdl/Utility_Package.vhdl
	ghdl -i --work=work /home/madhav/ahirgit/AHIR/v2/CtestBench/vhdl/Vhpi_Package.vhdl
	ghdl -i --work=work ahir_system.vhdl
	ghdl -i --work=work ahir_system_test_bench.vhdl
	ghdl -m --work=work -Wc,-g -Wl,-L/home/madhav/ahirgit/AHIR/v2/CtestBench/lib -Wl,-lVhpi ahir_system_test_bench 

clean:
	rm -f *.o* *.cf *.*vhdl vhdlCStubs.* *.vcd in_data* out_data* testbench_sw testbench_hw ahir_system_test_bench vhpi.log

PHONY: all clean	
