# to compile the program and run it "in the usual way"
# you will need to build two executables and
# link to the pipe library libio.a
gcc -DFOO -I../../iolib/ -L../../iolib/ -o foo main.c -lio
gcc -DBAR -I../../iolib/ -L../../iolib/ -o bar main.c -lio
#
# start foo and bar simultaneously and
# they will communicate and exit.
#
# to generate VHDL
# first use clang (or llvm-gcc) to generate llvm-byte-code
clang -std=gnu89 -emit-llvm -c main.c
#
# disassemble so that you can make sense of the llvm bc.
llvm-dis main.o
#
# OK, now take the llvm byte code 
# and generate an Aa description.
# (the pipe to vcFormat is to prettify the output)
llvm2aa main.o | vcFormat > main.o.aa
#
# Now take the Aa code and generate a virtual
# circuit.. 
# the -O flag does dependency analysis in straight-line
# code and parallelizes it.
#
Aa2VC -O main.o.aa | vcFormat > main.o.aa.vc
#
# finally, generate vhdl from the vc description.
#
vc2vhdl -t foo -t bar -f main.o.aa.vc | vhdlFormat > main_o_aa_vc.vhdl
#
# you can then simulate this VHDL description (compile
# and link with libraries ahir and ieee_proposed in the
# vhdl folder in the release directory).
#

