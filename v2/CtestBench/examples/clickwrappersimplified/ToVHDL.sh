# functions in prog.c to be mapped to vhdl
# generate llvm-byte-code
clang -DOPLU -std=gnu89 -I../../../iolib/ -emit-llvm -c prog.c
# disassemble byte-code for human readibility.
opt --instnamer -O3 prog.o > prog.opt.o
# llvm-bytecode to Aa
llvm-dis prog.opt.o
llvm2aa --modules=modules.txt --storageinit=true prog.opt.o | vcFormat >  prog.o.aa
# map external memory references from system to
# internal object mempool (of size 1 byte).
AaLinkExtMem -I 1 -E mempool prog.o.aa | vcFormat > prog.o.linked.aa
# take linked Aa and convert to virtual circuit.
Aa2VC -O -I mempool -C prog.o.linked.aa | vcFormat > prog.o.linked.aa.vc
#
# take virtual circuit and convert to VHDL
# NOTE: the -T option tells vc2vhdl that io_module is to be an ever-running
# top-level module, which will not need to be started from the outside, but
# will be free-running in the system (such modules cannot have input/output
# arguments, but can only listen/send on pipes).
#
 vc2vhdl -O -C -s modelsim -e ahir_system -w -T wrapper_input -T wrapper_output -T free_queue_manager -T output_port_lookup -f prog.o.linked.aa.vc 
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
