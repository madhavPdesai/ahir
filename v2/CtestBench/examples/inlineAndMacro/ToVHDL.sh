AaLinkExtMem prog.aa | vcFormat > prog.opt.aa
Aa2VC -O -C prog.opt.aa | vcFormat > prog.opt.aa.vc
vc2vhdl -C -e ahir_system -w -s ghdl -T io_module -f prog.opt.aa.vc 
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

