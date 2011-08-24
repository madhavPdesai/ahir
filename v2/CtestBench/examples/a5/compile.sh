clang -std=gnu89 -emit-llvm -c a5.c
llvm-dis a5.o
opt -O3 a5.o > a5.opt.o
llvm-dis a5.opt.o
llvm-ld a5.opt.o
#../../llvm2aa a5.o |vcFormat >  a5.o.aa
../../llvm2aa a5.opt.o | vcFormat > a5.opt.o.aa
AaLinkExtMem -I 1 -E mempool a5.opt.o.aa | vcFormat > a5.opt.o.linked.aa
Aa2VC -O -I mempool a5.opt.o.linked.aa | vcFormat > a5.opt.o.linked.aa.vc
vc2vhdl -t main -f a5.opt.o.linked.aa.vc | vhdlFormat > a5_opt_o_linked_aa_vc.vhdl
vc2vhdl -O -t main -f a5.opt.o.linked.aa.vc | vhdlFormat > a5_opt_o_linked_aa_vc_o.vhdl

