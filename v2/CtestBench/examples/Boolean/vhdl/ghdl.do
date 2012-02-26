ghdl --clean
ghdl --remove
ghdl -i --work=ahir  /home/madhav/ahirgit/ahir/vhdl/release/ahir.vhdl
ghdl -i --work=ieee_proposed /home/madhav/ahirgit/ahir/vhdl/release/ieee_proposed.vhdl
ghdl -i --work=work /home/madhav/ahirgit/ahir/v2/CtestBench/vhdl/Utility_Package.vhdl
ghdl -i --work=work /home/madhav/ahirgit/ahir/v2/CtestBench/vhdl/Vhpi_Package.vhdl
ghdl -i --work=work ahir_system*.vhdl
ghdl -m --work=work -Wc,-g -Wl,-L/home/madhav/ahirgit/ahir/v2/CtestBench/lib -Wl,-lVhpi ahir_system_test_bench 
