set AHIR_RELEASE $::env(AHIR_RELEASE)
set AJIT_PROJECT_HOME $::env(AJIT_PROJECT_HOME)
read_vhdl -library aHiR_ieee_proposed $AHIR_RELEASE/vhdl/aHiR_ieee_proposed.vhdl
read_vhdl -library ahir $AHIR_RELEASE/vhdl/ahirXilinx.vhdl
read_vhdl -library work ../ahir_system_global_package.vhdl
read_vhdl -library work ../ahir_system.vhdl
read_xdc ./clocking.xdc 
synth_design -mode out_of_context -fsm_extraction off -top ahir_system -part xc7a35tcpg236-3
opt_design
write_edif -force ahir_system.edn
report_timing_summary -file timing.postsynth.rpt -nworst 10
report_utilization -file utilization_post_synth.rpt
report_utilization -hierarchical -file utilization_post_synth.hierarchical.rpt
