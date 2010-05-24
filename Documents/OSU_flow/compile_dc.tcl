
set ahir_home [getenv "AHIR_HOME"]

if {![info exists ahir_home]} {
  echo "Environment variable \$AHIR_HOME not set."
  quit
}
source "$ahir_home/conf.dc.tcl"

set hdl_format "vhdl"

#/* The name of the clock pin. If no clock-pin     */
#/* exists, pick anything                          */
set my_clock_pin clk

#/* Target frequency in MHz for optimization       */
set my_clk_freq_MHz 50

#/* Delay of input signals (Clock-to-Q, Package etc.)  */
set my_input_delay_ns 1

#/* Reserved time for output signals (Holdtime etc.)   */
set my_output_delay_ns 1

# Currently, this is used to create the list of files to be compiled
source conf.dc.tcl

#/**************************************************/
#/* No modifications needed below                  */
#/**************************************************/
set OSUcells [format "%s%s"  [getenv "OSUcells"] "/lib/tsmc018/lib"]
set search_path [concat  $search_path $OSUcells]
set alib_library_analysis_path $OSUcells

set link_library [set target_library [concat  [list osu018_stdcells.db] [list dw_foundation.sldb]]]
set target_library "osu018_stdcells.db"
define_design_lib WORK -path ./WORK
set verilogout_show_unconnected_pins "true"
set_ultra_optimization true
set_ultra_optimization -force

redirect analyze.log {analyze -f $hdl_format $my_hdl_files}

redirect elaborate.log {elaborate [format "%s%s" $my_toplevel "_config"]}

current_design $my_toplevel

redirect link.log {link}
redirect uniquify.log {uniquify}

set my_period [expr 1000 / $my_clk_freq_MHz]

set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   set clk_name $my_clock_pin
   create_clock -period $my_period $clk_name
} else {
   set clk_name vclk
   create_clock -period $my_period -name $clk_name
}

set_driving_cell  -lib_cell INVX8  [all_inputs]
set_input_delay $my_input_delay_ns -clock $clk_name [remove_from_collection [all_inputs] $my_clock_pin]
set_output_delay $my_output_delay_ns -clock $clk_name [all_outputs]

redirect compile.log {compile -ungroup_all -map_effort medium}

redirect -append compile.log {compile -incremental_mapping -map_effort medium}

redirect check_design.log {check_design}
redirect constraints.log {report_constraint -all_violators}

write -f verilog -output [format "%s%s"  $my_toplevel ".vh"]
write -f vhdl -output [format "%s%s"  $my_toplevel ".netlist.vhdl"]
write -f db -hier -output [format "%s%s"  $my_toplevel ".db"]

write_sdc [format "%s%s"  $my_toplevel ".sdc"]

redirect timing.rep { report_timing }
redirect cell.rep { report_cell }
redirect power.rep { report_power }

quit
