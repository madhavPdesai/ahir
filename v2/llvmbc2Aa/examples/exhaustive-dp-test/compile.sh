# reference 
gcc -DRUN -o test  test.c
# use clang to generate llvm byte-code
clang -std=gnu89 -emit-llvm -c test.c
# optimize 
# opt -O3 test.o > test.opt.o
# dis-assemble to take a look
#../../llvm2aa test.opt.o | vcFormat > test.opt.o.aa
llvm2aa test.o | vcFormat > test.o.aa
# aa description translated to vc.
# -O is used to parallelize series blocks
# of statements.
Aa2VC -O test.o.aa | vcFormat > test.o.aa.vc
# vc to vhdl.
vc2vhdl -O -t main -e ahir_system -w -f test.o.aa.vc 
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

