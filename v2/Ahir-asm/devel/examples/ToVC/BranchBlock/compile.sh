Aa2VC BranchBlock.aa | vcFormat > BranchBlock.vc
vc2vhdl -t sum_mod -f BranchBlock.vc | vhdlFormat > system.vhdl
vc2vhdl -O -t sum_mod -f BranchBlock.vc | vhdlFormat > system_optimized.vhdl
