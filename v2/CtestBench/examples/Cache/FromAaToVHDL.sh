Aa2VC -O -C Cache.aa | vcFormat > Cache.vc
#
vc2vhdl -O -a -e ahir_system -w -C -s ghdl -t init_cache -t read_mem -t write_mem -f Cache.vc
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl

