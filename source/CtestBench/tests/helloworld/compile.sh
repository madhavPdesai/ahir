clang -std=gnu89 -emit-llvm -c main.c
llvm-dis main.o
llvm2aa main.o |vcFormat >  main.o.aa
Aa2VC -C main.o.aa | vcFormat > main.o.aa.vc
vc2vhdl -C -t foo -t bar -f main.o.aa.vc | vhdlFormat > main_o_aa_vc.vhdl

