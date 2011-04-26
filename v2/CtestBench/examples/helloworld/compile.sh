clang -std=gnu89 -emit-llvm -c main.c
llvm-dis main.o
llvm2aa main.o |vcFormat >  main.o.aa
AaLinkExtMem -I 1 -E mempool main.o.aa | vcFormat > main.o.linked.aa
Aa2VC -I mempool -C main.o.linked.aa | vcFormat > main.o.linked.aa.vc
vc2vhdl -C -t foo -t bar -f main.o.linked.aa.vc | vhdlFormat > main_o_linked_aa_vc.vhdl

