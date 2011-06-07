# functions in ahir_system_wrapper.c to be mapped to vhdl
# generate llvm-byte-code
clang -std=gnu89 -I./ -I../../../v2/iolib/ -emit-llvm -c ahir_system_wrapper.c
llvm-dis ahir_system_wrapper.o
llvm2aa ahir_system_wrapper.o | vcFormat >  ahir_system_wrapper.o.aa
AaLinkExtMem -I 1 -E mempool ahir_system_wrapper.o.aa | vcFormat > ahir_system_wrapper.o.linked.aa
Aa2VC -O -I mempool -C ahir_system_wrapper.o.linked.aa | vcFormat > ahir_system_wrapper.o.linked.aa.vc
vc2vhdl -C -s ghdl -T input_module -T output_module -T free_queue_manager -f ahir_system_wrapper.o.linked.aa.vc | vhdlFormat > ahir_system_wrapper_o_linked_aa_vc.vhdl

