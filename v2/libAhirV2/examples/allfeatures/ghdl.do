../../bin/vc2vhdl -t top -f system.vc | ../../bin/vhdlFormat > top.vhdl
ghdl --clean
ghdl --remove
ghdl -i --work=ahir ../../../../vhdl/operatorsV2/base/*.vhd
ghdl -i --work=ahir ../../../../vhdl/packagesV2/*.vhd
ghdl -i --work=ahir ../../../../vhdl/control-path/*.vhdl
ghdl -i --work=ahir ../../../../vhdl/memory_subsystem/*.vhd
ghdl -i --work=ieee_proposed ../../../../vhdl/ieee_proposed/tmp/*.vhdl
ghdl -i --work=work top.vhdl
ghdl  -m -g -Wl,lm -fexplicit test_system_test_bench

