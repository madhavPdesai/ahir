ghdl --clean
ghdl --remove
ghdl -i --work=GhdlLink /home/madhav/AHIR/gitHub/ahir/release/vhdl/GhdlLink.vhdl
ghdl -i --work=aHiR_ieee_proposed /home/madhav/AHIR/gitHub/ahir/release/vhdl/aHiR_ieee_proposed.vhdl
ghdl -i --work=ahir /home/madhav/AHIR/gitHub/ahir/release/vhdl/ahir.vhdl
ghdl -i --work=AjitCustom /home/madhav/AjitProject/Git/AjitRepoV2/processor/vhdl/lib/AjitCustom.vhdl
ghdl -i --work=SYS_LIB /home/madhav/AHIR/gitHub/ahir/v2/HierSysBuild/tests/rtl_counter/vhdl/SYS_LIB/sys.vhdl
ghdl -i --work=work /home/madhav/AHIR/gitHub/ahir/v2/HierSysBuild/tests/rtl_counter/vhdl/testbench/sys_test_bench.vhdl
ghdl -m --work=work -Wl,-L/home/madhav/AHIR/gitHub/ahir/release/lib -Wl,-lVhpi sys_test_bench
