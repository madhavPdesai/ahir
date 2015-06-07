SOCKETLIB_INCLUDE=$(AHIR_RELEASE)/CtestBench/include
SOCKETLIB_LIB=$(AHIR_RELEASE)/CtestBench/lib
PIPEHANDLER_INCLUDE=$(AHIR_RELEASE)/pipeHandler/include
PIPEHANDLER_LIB=$(AHIR_RELEASE)/pipeHandler/lib
PTHREADUTILS_INCLUDE=$(AHIR_RELEASE)/pthreadUtils/include
GNUPTHUTILS_INCLUDE=$(AHIR_RELEASE)/GnuPthUtils/include
VHDL_LIB=$(AHIR_RELEASE)/vhdl
VHDL_VHPI_LIB=$(AHIR_RELEASE)/CtestBench/vhdl
FUNCTIONLIB=$(AHIR_RELEASE)/functionLibrary/

TOPMODULES=-t fpmul64 -t fpadd64 -t fpsub64 -t fpdiv64 -t fpsqrt64 
all: aa2c_tests

# Aa2C tests
aa2c_tests: fpu.aa
	Aa2C fpu.aa 
	indent aa_c_model.c
	indent aa_c_model.h
	gcc -g -c -I./ -I$(AHIR_RELEASE)/include/   aa_c_model.c 
	gcc -g -I./ -I$(AHIR_RELEASE)/include/ -I ./ -c test_fpu_aa.c
	gcc -g -o test_fpu_aa test_fpu_aa.o aa_c_model.o -L$(AHIR_RELEASE)/lib -lm -lBitVectors


clean:
	rm -rf aa_c_model.* test_fpu_aa *.o 
