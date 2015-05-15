#!/bin/bash
AHIR_RELEASE=~/AHIR/gitHub/ahir/release
SOCKETLIB_INCLUDE=$AHIR_RELEASE/CtestBench/include
SOCKETLIB_LIB=$AHIR_RELEASE/CtestBench/lib
PIPEHANDLER_INCLUDE=$AHIR_RELEASE/pipeHandler/include
PIPEHANDLER_LIB=$AHIR_RELEASE/pipeHandler/lib
PTHREADUTILS_INCLUDE=$AHIR_RELEASE/pthreadUtils/include
GNUPTHUTILS_INCLUDE=$AHIR_RELEASE/GnuPthUtils/include
BITVECTOR_INCLUDE=$AHIR_RELEASE/BitVectors/include
BITVECTOR_LIB=$AHIR_RELEASE/BitVectors/lib
VHDL_LIB=$AHIR_RELEASE/vhdl
VHDL_VHPI_LIB=$AHIR_RELEASE/CtestBench/vhdl
FUNCTIONLIB=$AHIR_RELEASE/functionLibrary/
# build the lower levels.
cd Stage1
./generate_c.sh
./generate_vhdl.sh
cd ../Stage2
./generate_c.sh
./generate_vhdl.sh
cd ../
# generate the integrated vhdl and C
hierSys2Vhdl -s ghdl hello_world.hsys
vhdlFormat < Top_test_bench.unformatted_vhdl > Top_test_bench.vhdl
vhdlFormat < Top.unformatted_vhdl > Top.vhdl
hierSys2C  hello_world.hsys
# now build the C code.
rm -rf objsw
mkdir objsw
gcc -g -c -DSW  -I$PIPEHANDLER_INCLUDE -I$PTHREADUTILS_INCLUDE -I$BITVECTOR_INCLUDE  -I./Stage1 ./Stage1/S1_aa_c_model.c -o objsw/S1_aa_c_model.o
gcc -g -c -DSW  -I$PIPEHANDLER_INCLUDE -I$PTHREADUTILS_INCLUDE -I$BITVECTOR_INCLUDE  -I./Stage2 ./Stage2/S2_aa_c_model.c -o objsw/S2_aa_c_model.o
gcc -g -c -DSW  -I$PIPEHANDLER_INCLUDE -I$PTHREADUTILS_INCLUDE -I$BITVECTOR_INCLUDE  -I./ ./_Top.c -o objsw/_Top.o
gcc -g -c -DSW  -I$PIPEHANDLER_INCLUDE -I$PTHREADUTILS_INCLUDE -I./ ./Testbench/testbench.c -o objsw/testbench.o
gcc -g -o  TopSW objsw/S1_aa_c_model.o objsw/S2_aa_c_model.o objsw/_Top.o objsw/testbench.o -L $PIPEHANDLER_LIB -L$BITVECTOR_LIB -lBitVectors  -lPipeHandler -lpthread

