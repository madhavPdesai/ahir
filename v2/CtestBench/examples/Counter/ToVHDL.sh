Aa2VC -O -C prog.aa | vcFormat > prog.aa.vc
vc2vhdl -C -e ahir_system -w -s ghdl -T counter -f prog.aa.vc 
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

