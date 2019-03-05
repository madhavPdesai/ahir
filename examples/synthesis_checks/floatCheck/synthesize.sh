xst -ifn xilinx_synth.scr
netgen -w -ofmt=vhdl -fn ahir_system_synth.vhd
ghdlSanitize.sh ahir_system_synth.vhd ahir_system_synth.vhdl
