rm -f *.cf *.o
ghdl -a --ieee=synopsys --no-vital-checks --work=unisim -fexplicit unisim_VCOMP.vhd
ghdl -a --ieee=synopsys --no-vital-checks --work=unisim -fexplicit unisim_VPKG.vhd
ghdl -a --ieee=synopsys --no-vital-checks --work=unisim -fexplicit primitive/*.vhd
