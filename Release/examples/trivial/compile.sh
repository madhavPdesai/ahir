# to generate VHDL
# first use clang (or llvm-gcc) to generate llvm-byte-code
clang -std=gnu89 -emit-llvm -c add.c
#
# disassemble so that you can make sense of the llvm bc.
llvm-dis add.o
#
# its pretty sub-optimal
# lets optimize
opt -O3 add.o > add.opt.o
# 
# did it to better.
llvm-dis add.opt.o
#
# great, as simple as possible.
#
# OK, now take the llvm byte code 
# and generate an Aa description.
# (the pipe to vcFormat is to prettify the output)
 llvm2aa add.opt.o | vcFormat > add.opt.o.aa
#
# Now take the Aa code and generate a virtual
# circuit.. 
# the -O flag does dependency analysis in straight-line
# code and parallelizes it.
#
Aa2VC -O add.opt.o.aa | vcFormat > add.opt.o.aa.vc
#
# finally, generate vhdl from the vc description.
#
vc2vhdl -t add -f add.opt.o.aa.vc | vhdlFormat > add_opt_o_aa_vc.vhdl
#
# you can then simulate this VHDL description (compile
# and link with libraries ahir and ieee_proposed in the
# vhdl folder in the release directory).

