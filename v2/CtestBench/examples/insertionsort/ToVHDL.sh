#
# use clang to generate llvm bytecode.
clang -std=gnu89 -emit-llvm -I../../../iolib/  -c insertionsort.c
#
# disassemble to make it visible
llvm-dis insertionsort.o
#
# llvm-byte-code to aa
#   (note: initialization is ignored, all functions converted)
llvm2aa insertionsort.o |vcFormat >  insertionsort.o.aa
#
# link to external memory object (mempool) which
# is kept inside the system and has size 1 byte..
#
AaLinkExtMem -I 1 -E mempool insertionsort.o.aa  | vcFormat > insertionsort.o.linked.aa
#
# convert linked.aa to vc
#   (note: mempool is external storage object kept inside the system)
# -C flag is specified: this will print C stubs (in vhdlCStubs.h/c)
#
Aa2VC -O -C -I mempool insertionsort.o.linked.aa | vcFormat  > insertionsort.o.linked.aa.vc
#
# convert vc to VHDL
# -C flag is specified:   generated VHDL testbench will link to Modelsim FLI
#
vc2vhdl -O -C -t start -f insertionsort.o.linked.aa.vc | vhdlFormat > insertionsort_o_linked_aa_vc.vhdl
