clang -std=gnu89 -emit-llvm -c main.c
llvm-dis main.o
llvm2aa -storageinit main.o |vcFormat >  main.o.aa
Aa2VC -O  main.o.aa | vcFormat > main.o.aa.O.vc
vc2vhdl -O -t global_storage_initializer_ -t main -f main.o.aa.vc | vhdlFormat > main_o_aa_vc.vhdl

