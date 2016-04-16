ghdl -a --work=ahir_ieee_proposed $AHIR_RELEASE/vhdl/aHiR_ieee_proposed.vhdl
ghdl -a --work=ahir $AHIR_RELEASE/vhdl/ahir.vhdl
ghdl -a --work=ahir ApIntComponents.vhd
ghdl -a GenericApIntArithOperator.vhd
ghdl -a GenericBinaryApIntOperatorPipelined.vhd
ghdl -a PipelinedApIntOperator.vhd
ghdl -a UnsignedAdderSubtractor_n_n_n.vhd
ghdl -a UnsignedMultiplier_n_n_2n.vhd
ghdl -a UnsignedShifter_n_n_n.vhd
