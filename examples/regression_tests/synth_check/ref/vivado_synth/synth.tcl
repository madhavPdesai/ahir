read_vhdl -library work ../shift_register.vhdl
read_xdc ./clocking.xdc 
synth_design -mode out_of_context -fsm_extraction off -top shift_register -part xc7a35tcpg236-3
write_edif -force shift_register.edn
report_timing_summary -file timing.postsynth.rpt -nworst 10
report_utilization -file utilization_post_synth.rpt
report_utilization -hierarchical -file utilization_post_synth.hierarchical.rpt
