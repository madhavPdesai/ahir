gcc -g -c -DRUN testbench.c
gcc -g -c -DRUN quicksort.c
gcc -g -DRUN -o quicksort quicksort.o testbench.o
clang -std=gnu89 -emit-llvm -c quicksort.c
opt -O3 quicksort.o > quicksort.opt.o
llvm-dis quicksort.opt.o
llvm2aa quicksort.opt.o |vcFormat >  quicksort.opt.o.aa
llvm2aa quicksort.o |vcFormat >  quicksort.o.aa
AaLinkExtMem -I 1 -E mempool quicksort.o.aa  | vcFormat > quicksort.o.linked.aa
#AaLinkExtMem -I 1 -E mempool quicksort.opt.o.aa  | vcFormat > quicksort.opt.o.linked.aa
# this generates C stubs.
Aa2VC -O -C  -I mempool quicksort.o.linked.aa | vcFormat  > quicksort.o.linked.aa.vc
#Aa2VC -C -O -I mempool quicksort.opt.o.linked.aa | vcFormat  > quicksort.opt.o.linked.aa.vc
vc2vhdl -O  -e ahir_system -w -s ghdl -C -t main_inner -f quicksort.o.linked.aa.vc 
#vc2vhdl -C -t main_inner -f quicksort.opt.o.linked.aa.vc | vhdlFormat > quicksort_opt_o_linked_aa_vc.vhdl
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

