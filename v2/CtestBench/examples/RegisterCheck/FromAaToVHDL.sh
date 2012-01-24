Aa2VC -C Reg.aa | vcFormat > Reg.vc
vc2vhdl -D -q -e ahir_system -w -C -s ghdl  -t read_mem -t write_mem -t init -f Reg.vc
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

