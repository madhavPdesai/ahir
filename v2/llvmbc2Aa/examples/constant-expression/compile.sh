clang -std=gnu89 -emit-llvm -c main.c
llvm-dis main.o
opt -O3 main.o > main.opt.o
llvm-dis main.opt.o
#llvm-ld main.opt.o
llvm2aa main.o |vcFormat >  main.o.aa
llvm2aa main.opt.o |vcFormat >  main.opt.o.aa
#Aa2VC main.o.aa | vcFormat > main.o.aa.vc
#Aa2VC -O  main.o.aa | vcFormat > main.o.aa.O.vc
#vc2vhdl -t main -f main.o.aa.vc | vhdlFormat > main_o_aa_vc.vhdl
#vc2vhdl -t main -f main.o.aa.O.vc | vhdlFormat > main_o_aa_O_vc.vhdl
#../../llvm2aa main.opt.o | vcFormat > main.opt.o.aa

