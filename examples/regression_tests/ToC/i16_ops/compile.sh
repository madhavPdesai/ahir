AaLinkExtMem i16_ops.aa utils.aa | vcFormat > linked.aa
Aa2C linked.aa
indent aa_c_model.c
indent aa_c_model.h
gcc -DAA2C -gdwarf-2 -g3  -c -I$AHIR_RELEASE/include -I./ aa_c_model.c
gcc -DAA2C -gdwarf-2 -g3  -c -I$AHIR_RELEASE/include -I./ driver.c
gcc -gdwarf-2 -g3  -o driver  aa_c_model.o driver.o -L$AHIR_RELEASE/lib  -lBitVectors -lSockPipes -lPipeHandler -lpthread
rm *.o *~
Aa2VC -O -C  linked.aa | vcFormat > linked.vc
vc2vhdl -t smul -t sadd -t ssub -t fdotP -f linked.vc -O -C -a -e ahir_system -w -s ghdl   
vhdlFormat < ahir_system_global_package.unformatted_vhdl > ahir_system_global_package.vhdl
vhdlFormat < ahir_system.unformatted_vhdl > ahir_system.vhdl
vhdlFormat < ahir_system_test_bench.unformatted_vhdl > ahir_system_test_bench.vhdl
gcc -gdwarf-2 -g3  -c -I$AHIR_RELEASE/include -I./ vhdlCStubs.c
gcc -gdwarf-2 -g3  -c -I$AHIR_RELEASE/include -I./ driver.c
gcc -gdwarf-2 -g3 -o driver_hw driver.o vhdlCStubs.o  -L$AHIR_RELEASE/lib -lSockPipes -lSocketLibPipeHandler -lpthread
ghdl --clean
ghdl --remove
ghdl -i --work=GhdlLink  $AHIR_RELEASE/vhdl/GhdlLink.vhdl
ghdl -i --work=aHiR_ieee_proposed  $AHIR_RELEASE/vhdl/aHiR_ieee_proposed.vhdl
ghdl -i --work=ahir  $AHIR_RELEASE/vhdl/ahir.vhdl
ghdl -i --work=work ahir_system_global_package.vhdl
ghdl -i --work=work ahir_system.vhdl
ghdl -i --work=work ahir_system_test_bench.vhdl
ghdl -m --work=work -Wl,-L$AHIR_RELEASE/lib -Wl,-lVhpi ahir_system_test_bench 
