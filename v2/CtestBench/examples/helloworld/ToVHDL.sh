# functions in prog.c to be mapped to vhdl
# generate llvm-byte-code
clang -std=gnu89 -I../../../iolib/ -emit-llvm -c prog.c
# disassemble byte-code for human readibility.
llvm-dis prog.o
# llvm-bytecode to Aa
llvm2aa prog.o | vcFormat >  prog.o.aa
# map external memory references from system to
# internal object mempool (of size 1 byte).
AaLinkExtMem -I 1 -E mempool prog.o.aa | vcFormat > prog.o.linked.aa
# take linked Aa and convert to virtual circuit.
Aa2VC -O -I mempool -C prog.o.linked.aa | vcFormat > prog.o.linked.aa.vc
# take virtual circuit and convert to VHDL
# use -s ghdl if simulator is ghdl.  if -s is not used, default is  Modelsim.
 vc2vhdl -C -s ghdl -t foo -t bar -f prog.o.linked.aa.vc | vhdlFormat > prog_o_linked_aa_vc.vhdl
#vc2vhdl -C -t foo -t bar -f prog.o.linked.aa.vc | vhdlFormat > prog_o_linked_aa_vc.vhdl

