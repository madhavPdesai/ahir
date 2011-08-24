Aa2VC -O -C processor.aa | vcFormat > processor.vc
vc2vhdl -e ahir_system -w -C -s ghdl -t run -t write_to_mem -t read_from_mem  -f processor.vc
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

