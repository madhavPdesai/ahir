# to compile the program and run it "in the usual way"
#   note the RUN define.
gcc -DRUN -o sqroot sqroot.c
#
# to generate VHDL
# first use clang (or llvm-gcc) to generate llvm-byte-code
clang -std=gnu89 -emit-llvm -c sqroot.c
#
# disassemble so that you can make sense of the llvm bc.
llvm-dis sqroot.o
#
# OK, now take the llvm byte code 
# and generate an Aa description.
# (the pipe to vcFormat is to prettify the output)
llvm2aa --storageinit=true sqroot.o | vcFormat > sqroot.o.aa
#
# Now take the Aa code and generate a virtual
# circuit.. 
# the -O flag does dependency analysis in straight-line
# code and parallelizes it.
#
Aa2VC -O sqroot.o.aa | vcFormat > sqroot.o.aa.vc
#
# finally, generate vhdl from the vc description.
#
vc2vhdl -O -t main -e ahir_system -f sqroot.o.aa.vc | vhdlFormat > sqroot_o_aa_vc.vhdl
#
# you can then simulate this VHDL description (compile
# and link with libraries ahir and ieee_proposed in the
# vhdl folder in the release directory).

