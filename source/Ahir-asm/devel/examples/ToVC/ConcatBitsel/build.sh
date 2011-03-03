../../../bin/Aa2VC ConcatBitsel.aa | ../../../../../libAhirV2/bin/vcFormat > ConcatBitsel.vc
../../../../../libAhirV2/bin/vc2vhdl -t sum_mod -f ConcatBitsel.vc | ../../../../../libAhirV2/bin/vhdlFormat > system.vhdl
