../../../bin/Aa2VC Shifts.aa | ../../../../../libAhirV2/bin/vcFormat > Shifts.vc
../../../../../libAhirV2/bin/vc2vhdl -t sum_mod -f Shifts.vc | ../../../../../libAhirV2/bin/vhdlFormat > system.vhdl
