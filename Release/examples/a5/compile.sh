# to compile the program and run it "in the usual way"
#   note the RUN define.
gcc -DRUN -o a5 a5.c
#
# to generate VHDL
# first use clang (or llvm-gcc) to generate llvm-byte-code
clang -std=gnu89 -emit-llvm -c a5.c
#
# disassemble so that you can make sense of the llvm bc.
llvm-dis a5.o
#
# lets do some serious optimization (O3)
opt -O3 a5.o > a5.opt.o
#
# disassemble this as well..
llvm-dis a5.opt.o
#
# OK, now take the llvm byte code (optimized)
# and generate an Aa description.
# (the pipe to vcFormat is to prettify the output)
 llvm2aa a5.opt.o | vcFormat > a5.opt.o.aa
#
# if you want to try the unoptimized byte-code, uncomment
# the following line
# llvm2aa a5.o |vcFormat >  a5.o.aa
#
# Now take the Aa code and generate a virtual
# circuit.. 
# the -O flag does dependency analysis in straight-line
# code and parallelizes it.
#
Aa2VC -O a5.opt.o.aa | vcFormat > a5.opt.o.aa.vc
#
# finally, generate vhdl from the vc description.
#
vc2vhdl -t main -f a5.opt.o.aa.vc | vhdlFormat > a5_opt_o_aa_vc.vhdl
#
# you can then simulate this VHDL description (compile
# and link with libraries ahir and ieee_proposed in the
# vhdl folder in the release directory).

