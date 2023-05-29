ghdl --clean
ghdl --remove
ghdl -i --work=GhdlLink $AHIR_RELEASE/vhdl/GhdlLink.vhdl
ghdl -i --work=aHiR_ieee_proposed $AHIR_RELEASE/vhdl/aHiR_ieee_proposed.vhdl
ghdl -i --work=ahir $AHIR_RELEASE/vhdl/ahir.vhdl
ghdl -i --work=shift_reg_lib ../shift_reg_2/shift_reg_1/Aa/vhdl/shift_reg_lib/shift_reg_1.vhdl
ghdl -i --work=shift_reg_lib ../shift_reg_2/shift_reg_1/Aa/vhdl/shift_reg_lib/shift_reg_1_global_package.vhdl
ghdl -i --work=shift_reg_lib ../shift_reg_2/vhdl/shift_reg_lib/shift_reg_2.vhdl
ghdl -i --work=shift_reg_lib ../vhdl/shift_reg_lib/shift_reg_4.vhdl
ghdl -i --work=work ../vhdl/testbench/shift_reg_4_test_bench.vhdl
ghdl -m --work=work -Wl,-L/home/madhav/AjitToolChain/ahir_release/lib -Wl,-lVhpi shift_reg_4_test_bench
