ghdl --clean
ghdl --remove
ghdl -i --work=ahir  $AHIR_HOME/vhdl/release/ahir.vhdl
ghdl -i --work=ieee_proposed $AHIR_HOME/vhdl/release/ieee_proposed.vhdl
ghdl -i --work=work FifoTB.vhd
ghdl -m --work=work -Wc,-g FifoTest 
