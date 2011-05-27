clang -std=gnu89 -emit-llvm -c main.c
llvm-dis main.o
opt -O3 main.o > main.opt.o
llvm-dis main.opt.o
llvm-ld main.opt.o
llvm2aa -constprop main.o |vcFormat >  main.o.aa
Aa2VC main.o.aa | vcFormat > main.o.aa.vc
Aa2VC -O main.o.aa | vcFormat > main.o.aa.O.vc
vc2vhdl -t foo -t bar -f main.o.aa.vc | vhdlFormat > main_o_aa_vc.vhdl
vc2vhdl -t foo -t bar -f main.o.aa.O.vc | vhdlFormat > main_o_aa_O_vc.vhdl
llvm2aa -constprop main.opt.o | vcFormat > main.opt.o.aa
Aa2VC main.opt.o.aa | vcFormat > main.opt.o.aa.vc
Aa2VC -O main.opt.o.aa | vcFormat > main.opt.o.aa.O.vc
vc2vhdl -t foo -t bar -f main.opt.o.aa.vc | vhdlFormat > main_opt_o_aa_vc.vhdl
vc2vhdl -t foo -t bar -f main.opt.o.aa.O.vc | vhdlFormat > main_opt_o_aa_O_vc.vhdl
vc2vhdl -O -t foo -t bar -f main.opt.o.aa.O.vc | vhdlFormat > main_opt_o_aa_O_vc_O.vhdl

