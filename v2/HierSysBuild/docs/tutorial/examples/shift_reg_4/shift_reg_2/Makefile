#
# This makefile only builds the VHDL for shift_reg_2!
#

PIPES=../pipes.aa 

all: shift_reg_2.hsys  $(PIPES)
	buildHierarchicalModel.py  -s ghdl -a shift_reg_lib_shift_reg_2 -H $(PIPES)


clean:
	rm -rf lib/*.a objsw/*.o vhdl/*  aa2c/*.* *.c *.h *.txt *.log


PHONY: all clean tests

