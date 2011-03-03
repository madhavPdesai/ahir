../../../bin/Aa2VC ShiftRegister.aa | ../../../../../libAhirV2/bin/vcFormat > ShiftRegister.vc
../../../../../libAhirV2/bin/vc2vhdl -t sum_mod -f ShiftRegister.vc | ../../../../../libAhirV2/bin/vhdlFormat > system.vhdl
