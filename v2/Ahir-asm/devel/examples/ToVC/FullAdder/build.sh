../../../bin/Aa2VC FullAdder.aa | ../../../../../libAhirV2/bin/vcFormat > FullAdder.vc
../../../../../libAhirV2/bin/vc2vhdl -t sum_mod -f FullAdder.vc | ../../../../../libAhirV2/bin/vhdlFormat > system.vhdl
