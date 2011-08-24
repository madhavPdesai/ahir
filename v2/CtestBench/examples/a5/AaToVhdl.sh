Aa2VC -O -C prog.opt.o.aa.optimized | vcFormat > prog.opt.o.aa.vc
#
# take virtual circuit and convert to VHDL
# NOTE: the -T option tells vc2vhdl that io_module is to be an ever-running
# top-level module, which will not need to be started from the outside, but
# will be free-running in the system (such modules cannot have input/output
# arguments, but can only listen/send on pipes).
#
# uncomment next line if you are using modelsim
# vc2vhdl -C -s modelsim -T io_module -f prog.o.linked.aa.vc | vhdlFormat > prog_o_linked_aa_vc.vhdl
# comment next line if you are using modelsim
vc2vhdl -C -O -e ahir_system -w -s ghdl -t main_inner -f prog.opt.o.aa.vc 
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

