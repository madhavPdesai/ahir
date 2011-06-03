ghdl --clean
ghdl --remove
ghdl -i --work=ahir  /home/madhav/ahirgit/AHIR/vhdl/control-path/*.vhdl
ghdl -i --work=ahir  /home/madhav/ahirgit/AHIR/vhdl/operatorsV2/base/*.vhd
ghdl -i --work=ahir /home/madhav/ahirgit/AHIR/vhdl/packagesV2/*.vhd
ghdl -i --work=ahir /home/madhav/ahirgit/AHIR/vhdl/memory_subsystem/*.vhd
ghdl -i --work=ieee_proposed /home/madhav/ahirgit/AHIR/vhdl/ieee_proposed/trimmed/*.vhd
ghdl -i --work=work /home/madhav/ahirgit/AHIR/v2/CtestBench/vhdl/Utility_Package.vhdl
ghdl -i --work=work /home/madhav/ahirgit/AHIR/v2/CtestBench/vhdl/Vhpi_Package.vhdl
ghdl -i --work=work system.vhdl
ghdl -m --work=work -Wc,-g -Wl,-L/home/madhav/ahirgit/AHIR/v2/CtestBench/lib -Wl,-lVhpi test_system_test_bench 
