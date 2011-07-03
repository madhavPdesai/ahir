-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  -- 
end package vc_system_package;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.utilities.all;
library work;
use work.vc_system_package.all;
entity output_port_lookup is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity output_port_lookup;
architecture Default of output_port_lookup is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- output port buffer signals
  -- links between control-path and data-path
  signal simple_obj_ref_28_inst_req_0 : boolean;
  signal simple_obj_ref_28_inst_ack_0 : boolean;
  signal binary_34_inst_req_0 : boolean;
  signal binary_34_inst_ack_0 : boolean;
  signal binary_34_inst_req_1 : boolean;
  signal binary_34_inst_ack_1 : boolean;
  signal binary_41_inst_req_0 : boolean;
  signal binary_41_inst_ack_0 : boolean;
  signal binary_41_inst_req_1 : boolean;
  signal binary_41_inst_ack_1 : boolean;
  signal simple_obj_ref_25_inst_req_0 : boolean;
  signal simple_obj_ref_25_inst_ack_0 : boolean;
  signal binary_46_inst_req_0 : boolean;
  signal binary_46_inst_ack_0 : boolean;
  signal binary_46_inst_req_1 : boolean;
  signal binary_46_inst_ack_1 : boolean;
  signal binary_91_inst_req_0 : boolean;
  signal binary_91_inst_ack_0 : boolean;
  signal binary_91_inst_req_1 : boolean;
  signal binary_91_inst_ack_1 : boolean;
  signal if_stmt_48_branch_req_0 : boolean;
  signal if_stmt_48_branch_ack_1 : boolean;
  signal if_stmt_48_branch_ack_0 : boolean;
  signal binary_59_inst_req_0 : boolean;
  signal binary_59_inst_ack_0 : boolean;
  signal binary_59_inst_req_1 : boolean;
  signal binary_59_inst_ack_1 : boolean;
  signal binary_65_inst_req_0 : boolean;
  signal binary_65_inst_ack_0 : boolean;
  signal binary_65_inst_req_1 : boolean;
  signal binary_65_inst_ack_1 : boolean;
  signal type_cast_70_inst_req_0 : boolean;
  signal type_cast_70_inst_ack_0 : boolean;
  signal binary_76_inst_req_0 : boolean;
  signal binary_76_inst_ack_0 : boolean;
  signal binary_76_inst_req_1 : boolean;
  signal binary_76_inst_ack_1 : boolean;
  signal binary_82_inst_req_0 : boolean;
  signal binary_82_inst_ack_0 : boolean;
  signal binary_82_inst_req_1 : boolean;
  signal binary_82_inst_ack_1 : boolean;
  signal type_cast_87_inst_req_0 : boolean;
  signal type_cast_87_inst_ack_0 : boolean;
  signal phi_stmt_16_ack_0 : boolean;
  signal binary_97_inst_req_0 : boolean;
  signal binary_97_inst_ack_0 : boolean;
  signal binary_97_inst_req_1 : boolean;
  signal binary_97_inst_ack_1 : boolean;
  signal binary_103_inst_req_0 : boolean;
  signal binary_103_inst_ack_0 : boolean;
  signal binary_103_inst_req_1 : boolean;
  signal binary_103_inst_ack_1 : boolean;
  signal binary_109_inst_req_0 : boolean;
  signal binary_109_inst_ack_0 : boolean;
  signal binary_109_inst_req_1 : boolean;
  signal binary_109_inst_ack_1 : boolean;
  signal ternary_115_inst_req_0 : boolean;
  signal ternary_115_inst_ack_0 : boolean;
  signal type_cast_119_inst_req_0 : boolean;
  signal type_cast_119_inst_ack_0 : boolean;
  signal binary_125_inst_req_0 : boolean;
  signal binary_125_inst_ack_0 : boolean;
  signal binary_125_inst_req_1 : boolean;
  signal binary_125_inst_ack_1 : boolean;
  signal binary_131_inst_req_0 : boolean;
  signal binary_131_inst_ack_0 : boolean;
  signal binary_131_inst_req_1 : boolean;
  signal binary_131_inst_ack_1 : boolean;
  signal binary_136_inst_req_0 : boolean;
  signal binary_136_inst_ack_0 : boolean;
  signal binary_136_inst_req_1 : boolean;
  signal binary_136_inst_ack_1 : boolean;
  signal binary_144_inst_req_0 : boolean;
  signal binary_144_inst_ack_0 : boolean;
  signal binary_144_inst_req_1 : boolean;
  signal binary_144_inst_ack_1 : boolean;
  signal if_stmt_146_branch_req_0 : boolean;
  signal if_stmt_146_branch_ack_1 : boolean;
  signal if_stmt_146_branch_ack_0 : boolean;
  signal simple_obj_ref_174_inst_req_0 : boolean;
  signal simple_obj_ref_174_inst_ack_0 : boolean;
  signal simple_obj_ref_177_inst_req_0 : boolean;
  signal simple_obj_ref_177_inst_ack_0 : boolean;
  signal phi_stmt_16_req_0 : boolean;
  signal type_cast_22_inst_req_0 : boolean;
  signal type_cast_22_inst_ack_0 : boolean;
  signal phi_stmt_16_req_1 : boolean;
  signal type_cast_158_inst_req_0 : boolean;
  signal type_cast_158_inst_ack_0 : boolean;
  signal phi_stmt_155_req_0 : boolean;
  signal phi_stmt_163_req_0 : boolean;
  signal type_cast_162_inst_req_0 : boolean;
  signal type_cast_162_inst_ack_0 : boolean;
  signal phi_stmt_155_req_2 : boolean;
  signal type_cast_172_inst_req_0 : boolean;
  signal type_cast_172_inst_ack_0 : boolean;
  signal phi_stmt_163_req_2 : boolean;
  signal type_cast_160_inst_req_0 : boolean;
  signal type_cast_160_inst_ack_0 : boolean;
  signal phi_stmt_155_req_1 : boolean;
  signal phi_stmt_163_req_1 : boolean;
  signal phi_stmt_155_ack_0 : boolean;
  signal phi_stmt_163_ack_0 : boolean;
  -- 
begin --  
  -- output port buffering assignments
  -- tag register
  process(clk) 
  begin -- 
    if clk'event and clk = '1' then -- 
      if start='1' then -- 
        tag_out <= tag_in; -- 
      end if; -- 
    end if; -- 
  end process;
  -- the control path
  always_true_symbol <= true; 
  output_port_lookup_CP_0: Block -- control-path 
    signal output_port_lookup_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_13_3_symbol : Boolean;
    -- 
  begin -- 
    output_port_lookup_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= output_port_lookup_CP_0_start; -- transition $entry
    branch_block_stmt_13_3: Block -- branch_block_stmt_13 
      signal branch_block_stmt_13_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_13_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_13_x_xexit_x_xx_x7_symbol : Boolean;
      signal bb_0_bb_1_8_symbol : Boolean;
      signal merge_stmt_15_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_26_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_26_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_29_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_29_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_36_to_assign_stmt_47_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_36_to_assign_stmt_47_x_xexit_x_xx_x15_symbol : Boolean;
      signal if_stmt_48_x_xentry_x_xx_x16_symbol : Boolean;
      signal if_stmt_48_x_xexit_x_xx_x17_symbol : Boolean;
      signal merge_stmt_54_x_xentry_x_xx_x18_symbol : Boolean;
      signal merge_stmt_54_x_xexit_x_xx_x19_symbol : Boolean;
      signal assign_stmt_60_to_assign_stmt_137_x_xentry_x_xx_x20_symbol : Boolean;
      signal assign_stmt_60_to_assign_stmt_137_x_xexit_x_xx_x21_symbol : Boolean;
      signal bb_2_bb_5_22_symbol : Boolean;
      signal merge_stmt_139_x_xexit_x_xx_x23_symbol : Boolean;
      signal assign_stmt_145_x_xentry_x_xx_x24_symbol : Boolean;
      signal assign_stmt_145_x_xexit_x_xx_x25_symbol : Boolean;
      signal if_stmt_146_x_xentry_x_xx_x26_symbol : Boolean;
      signal if_stmt_146_x_xexit_x_xx_x27_symbol : Boolean;
      signal merge_stmt_152_x_xentry_x_xx_x28_symbol : Boolean;
      signal merge_stmt_152_x_xexit_x_xx_x29_symbol : Boolean;
      signal bb_4_bb_5_30_symbol : Boolean;
      signal merge_stmt_154_x_xexit_x_xx_x31_symbol : Boolean;
      signal assign_stmt_176_x_xentry_x_xx_x32_symbol : Boolean;
      signal assign_stmt_176_x_xexit_x_xx_x33_symbol : Boolean;
      signal assign_stmt_179_x_xentry_x_xx_x34_symbol : Boolean;
      signal assign_stmt_179_x_xexit_x_xx_x35_symbol : Boolean;
      signal bb_5_bb_1_36_symbol : Boolean;
      signal assign_stmt_26_37_symbol : Boolean;
      signal assign_stmt_29_48_symbol : Boolean;
      signal assign_stmt_36_to_assign_stmt_47_59_symbol : Boolean;
      signal if_stmt_48_dead_link_99_symbol : Boolean;
      signal if_stmt_48_eval_test_103_symbol : Boolean;
      signal simple_obj_ref_49_place_107_symbol : Boolean;
      signal if_stmt_48_if_link_108_symbol : Boolean;
      signal if_stmt_48_else_link_112_symbol : Boolean;
      signal bb_1_bb_2_116_symbol : Boolean;
      signal bb_1_bb_3_117_symbol : Boolean;
      signal assign_stmt_60_to_assign_stmt_137_118_symbol : Boolean;
      signal assign_stmt_145_293_symbol : Boolean;
      signal if_stmt_146_dead_link_308_symbol : Boolean;
      signal if_stmt_146_eval_test_312_symbol : Boolean;
      signal simple_obj_ref_147_place_316_symbol : Boolean;
      signal if_stmt_146_if_link_317_symbol : Boolean;
      signal if_stmt_146_else_link_321_symbol : Boolean;
      signal bb_3_bb_5_325_symbol : Boolean;
      signal bb_3_bb_4_326_symbol : Boolean;
      signal assign_stmt_176_327_symbol : Boolean;
      signal assign_stmt_179_339_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_351_symbol : Boolean;
      signal bb_5_bb_1_PhiReq_363_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_375_symbol : Boolean;
      signal merge_stmt_15_PhiAck_376_symbol : Boolean;
      signal merge_stmt_54_dead_link_380_symbol : Boolean;
      signal bb_1_bb_2_PhiReq_384_symbol : Boolean;
      signal merge_stmt_54_PhiReqMerge_387_symbol : Boolean;
      signal merge_stmt_54_PhiAck_388_symbol : Boolean;
      signal bb_1_bb_3_PhiReq_392_symbol : Boolean;
      signal merge_stmt_139_PhiReqMerge_395_symbol : Boolean;
      signal merge_stmt_139_PhiAck_396_symbol : Boolean;
      signal merge_stmt_152_dead_link_400_symbol : Boolean;
      signal bb_3_bb_4_PhiReq_404_symbol : Boolean;
      signal merge_stmt_152_PhiReqMerge_407_symbol : Boolean;
      signal merge_stmt_152_PhiAck_408_symbol : Boolean;
      signal bb_2_bb_5_PhiReq_412_symbol : Boolean;
      signal bb_3_bb_5_PhiReq_443_symbol : Boolean;
      signal bb_4_bb_5_PhiReq_474_symbol : Boolean;
      signal merge_stmt_154_PhiReqMerge_505_symbol : Boolean;
      signal merge_stmt_154_PhiAck_506_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x9_symbol  <=  merge_stmt_15_PhiAck_376_symbol; -- place branch_block_stmt_13/merge_stmt_15__exit__ (optimized away) 
      assign_stmt_26_x_xentry_x_xx_x10_symbol  <=  merge_stmt_15_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/assign_stmt_26__entry__ (optimized away) 
      assign_stmt_26_x_xexit_x_xx_x11_symbol  <=  assign_stmt_26_37_symbol; -- place branch_block_stmt_13/assign_stmt_26__exit__ (optimized away) 
      assign_stmt_29_x_xentry_x_xx_x12_symbol  <=  assign_stmt_26_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_29__entry__ (optimized away) 
      assign_stmt_29_x_xexit_x_xx_x13_symbol  <=  assign_stmt_29_48_symbol; -- place branch_block_stmt_13/assign_stmt_29__exit__ (optimized away) 
      assign_stmt_36_to_assign_stmt_47_x_xentry_x_xx_x14_symbol  <=  assign_stmt_29_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47__entry__ (optimized away) 
      assign_stmt_36_to_assign_stmt_47_x_xexit_x_xx_x15_symbol  <=  assign_stmt_36_to_assign_stmt_47_59_symbol; -- place branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47__exit__ (optimized away) 
      if_stmt_48_x_xentry_x_xx_x16_symbol  <=  assign_stmt_36_to_assign_stmt_47_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_13/if_stmt_48__entry__ (optimized away) 
      if_stmt_48_x_xexit_x_xx_x17_symbol  <=  if_stmt_48_dead_link_99_symbol; -- place branch_block_stmt_13/if_stmt_48__exit__ (optimized away) 
      merge_stmt_54_x_xentry_x_xx_x18_symbol  <=  if_stmt_48_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_13/merge_stmt_54__entry__ (optimized away) 
      merge_stmt_54_x_xexit_x_xx_x19_symbol  <=  merge_stmt_54_dead_link_380_symbol or merge_stmt_54_PhiAck_388_symbol; -- place branch_block_stmt_13/merge_stmt_54__exit__ (optimized away) 
      assign_stmt_60_to_assign_stmt_137_x_xentry_x_xx_x20_symbol  <=  merge_stmt_54_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137__entry__ (optimized away) 
      assign_stmt_60_to_assign_stmt_137_x_xexit_x_xx_x21_symbol  <=  assign_stmt_60_to_assign_stmt_137_118_symbol; -- place branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137__exit__ (optimized away) 
      bb_2_bb_5_22_symbol  <=  assign_stmt_60_to_assign_stmt_137_x_xexit_x_xx_x21_symbol; -- place branch_block_stmt_13/bb_2_bb_5 (optimized away) 
      merge_stmt_139_x_xexit_x_xx_x23_symbol  <=  merge_stmt_139_PhiAck_396_symbol; -- place branch_block_stmt_13/merge_stmt_139__exit__ (optimized away) 
      assign_stmt_145_x_xentry_x_xx_x24_symbol  <=  merge_stmt_139_x_xexit_x_xx_x23_symbol; -- place branch_block_stmt_13/assign_stmt_145__entry__ (optimized away) 
      assign_stmt_145_x_xexit_x_xx_x25_symbol  <=  assign_stmt_145_293_symbol; -- place branch_block_stmt_13/assign_stmt_145__exit__ (optimized away) 
      if_stmt_146_x_xentry_x_xx_x26_symbol  <=  assign_stmt_145_x_xexit_x_xx_x25_symbol; -- place branch_block_stmt_13/if_stmt_146__entry__ (optimized away) 
      if_stmt_146_x_xexit_x_xx_x27_symbol  <=  if_stmt_146_dead_link_308_symbol; -- place branch_block_stmt_13/if_stmt_146__exit__ (optimized away) 
      merge_stmt_152_x_xentry_x_xx_x28_symbol  <=  if_stmt_146_x_xexit_x_xx_x27_symbol; -- place branch_block_stmt_13/merge_stmt_152__entry__ (optimized away) 
      merge_stmt_152_x_xexit_x_xx_x29_symbol  <=  merge_stmt_152_dead_link_400_symbol or merge_stmt_152_PhiAck_408_symbol; -- place branch_block_stmt_13/merge_stmt_152__exit__ (optimized away) 
      bb_4_bb_5_30_symbol  <=  merge_stmt_152_x_xexit_x_xx_x29_symbol; -- place branch_block_stmt_13/bb_4_bb_5 (optimized away) 
      merge_stmt_154_x_xexit_x_xx_x31_symbol  <=  merge_stmt_154_PhiAck_506_symbol; -- place branch_block_stmt_13/merge_stmt_154__exit__ (optimized away) 
      assign_stmt_176_x_xentry_x_xx_x32_symbol  <=  merge_stmt_154_x_xexit_x_xx_x31_symbol; -- place branch_block_stmt_13/assign_stmt_176__entry__ (optimized away) 
      assign_stmt_176_x_xexit_x_xx_x33_symbol  <=  assign_stmt_176_327_symbol; -- place branch_block_stmt_13/assign_stmt_176__exit__ (optimized away) 
      assign_stmt_179_x_xentry_x_xx_x34_symbol  <=  assign_stmt_176_x_xexit_x_xx_x33_symbol; -- place branch_block_stmt_13/assign_stmt_179__entry__ (optimized away) 
      assign_stmt_179_x_xexit_x_xx_x35_symbol  <=  assign_stmt_179_339_symbol; -- place branch_block_stmt_13/assign_stmt_179__exit__ (optimized away) 
      bb_5_bb_1_36_symbol  <=  assign_stmt_179_x_xexit_x_xx_x35_symbol; -- place branch_block_stmt_13/bb_5_bb_1 (optimized away) 
      assign_stmt_26_37: Block -- branch_block_stmt_13/assign_stmt_26 
        signal assign_stmt_26_37_start: Boolean;
        signal Xentry_38_symbol: Boolean;
        signal Xexit_39_symbol: Boolean;
        signal assign_stmt_26_active_x_x40_symbol : Boolean;
        signal assign_stmt_26_completed_x_x41_symbol : Boolean;
        signal simple_obj_ref_25_trigger_x_x42_symbol : Boolean;
        signal simple_obj_ref_25_complete_43_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_26_37_start <= assign_stmt_26_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_38_symbol  <= assign_stmt_26_37_start; -- transition branch_block_stmt_13/assign_stmt_26/$entry
        assign_stmt_26_active_x_x40_symbol <= simple_obj_ref_25_complete_43_symbol; -- transition branch_block_stmt_13/assign_stmt_26/assign_stmt_26_active_
        assign_stmt_26_completed_x_x41_symbol <= assign_stmt_26_active_x_x40_symbol; -- transition branch_block_stmt_13/assign_stmt_26/assign_stmt_26_completed_
        simple_obj_ref_25_trigger_x_x42_symbol <= Xentry_38_symbol; -- transition branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_trigger_
        simple_obj_ref_25_complete_43: Block -- branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_complete 
          signal simple_obj_ref_25_complete_43_start: Boolean;
          signal Xentry_44_symbol: Boolean;
          signal Xexit_45_symbol: Boolean;
          signal req_46_symbol : Boolean;
          signal ack_47_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_25_complete_43_start <= simple_obj_ref_25_trigger_x_x42_symbol; -- control passed to block
          Xentry_44_symbol  <= simple_obj_ref_25_complete_43_start; -- transition branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_complete/$entry
          req_46_symbol <= Xentry_44_symbol; -- transition branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_complete/req
          simple_obj_ref_25_inst_req_0 <= req_46_symbol; -- link to DP
          ack_47_symbol <= simple_obj_ref_25_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_complete/ack
          Xexit_45_symbol <= ack_47_symbol; -- transition branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_complete/$exit
          simple_obj_ref_25_complete_43_symbol <= Xexit_45_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_26/simple_obj_ref_25_complete
        Xexit_39_symbol <= assign_stmt_26_completed_x_x41_symbol; -- transition branch_block_stmt_13/assign_stmt_26/$exit
        assign_stmt_26_37_symbol <= Xexit_39_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_26
      assign_stmt_29_48: Block -- branch_block_stmt_13/assign_stmt_29 
        signal assign_stmt_29_48_start: Boolean;
        signal Xentry_49_symbol: Boolean;
        signal Xexit_50_symbol: Boolean;
        signal assign_stmt_29_active_x_x51_symbol : Boolean;
        signal assign_stmt_29_completed_x_x52_symbol : Boolean;
        signal simple_obj_ref_28_trigger_x_x53_symbol : Boolean;
        signal simple_obj_ref_28_complete_54_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_29_48_start <= assign_stmt_29_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_49_symbol  <= assign_stmt_29_48_start; -- transition branch_block_stmt_13/assign_stmt_29/$entry
        assign_stmt_29_active_x_x51_symbol <= simple_obj_ref_28_complete_54_symbol; -- transition branch_block_stmt_13/assign_stmt_29/assign_stmt_29_active_
        assign_stmt_29_completed_x_x52_symbol <= assign_stmt_29_active_x_x51_symbol; -- transition branch_block_stmt_13/assign_stmt_29/assign_stmt_29_completed_
        simple_obj_ref_28_trigger_x_x53_symbol <= Xentry_49_symbol; -- transition branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_trigger_
        simple_obj_ref_28_complete_54: Block -- branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_complete 
          signal simple_obj_ref_28_complete_54_start: Boolean;
          signal Xentry_55_symbol: Boolean;
          signal Xexit_56_symbol: Boolean;
          signal req_57_symbol : Boolean;
          signal ack_58_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_28_complete_54_start <= simple_obj_ref_28_trigger_x_x53_symbol; -- control passed to block
          Xentry_55_symbol  <= simple_obj_ref_28_complete_54_start; -- transition branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_complete/$entry
          req_57_symbol <= Xentry_55_symbol; -- transition branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_complete/req
          simple_obj_ref_28_inst_req_0 <= req_57_symbol; -- link to DP
          ack_58_symbol <= simple_obj_ref_28_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_complete/ack
          Xexit_56_symbol <= ack_58_symbol; -- transition branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_complete/$exit
          simple_obj_ref_28_complete_54_symbol <= Xexit_56_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_29/simple_obj_ref_28_complete
        Xexit_50_symbol <= assign_stmt_29_completed_x_x52_symbol; -- transition branch_block_stmt_13/assign_stmt_29/$exit
        assign_stmt_29_48_symbol <= Xexit_50_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_29
      assign_stmt_36_to_assign_stmt_47_59: Block -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47 
        signal assign_stmt_36_to_assign_stmt_47_59_start: Boolean;
        signal Xentry_60_symbol: Boolean;
        signal Xexit_61_symbol: Boolean;
        signal assign_stmt_36_active_x_x62_symbol : Boolean;
        signal assign_stmt_36_completed_x_x63_symbol : Boolean;
        signal binary_34_active_x_x64_symbol : Boolean;
        signal binary_34_trigger_x_x65_symbol : Boolean;
        signal simple_obj_ref_31_complete_66_symbol : Boolean;
        signal binary_34_complete_67_symbol : Boolean;
        signal assign_stmt_42_active_x_x74_symbol : Boolean;
        signal assign_stmt_42_completed_x_x75_symbol : Boolean;
        signal binary_41_active_x_x76_symbol : Boolean;
        signal binary_41_trigger_x_x77_symbol : Boolean;
        signal simple_obj_ref_38_complete_78_symbol : Boolean;
        signal binary_41_complete_79_symbol : Boolean;
        signal assign_stmt_47_active_x_x86_symbol : Boolean;
        signal assign_stmt_47_completed_x_x87_symbol : Boolean;
        signal binary_46_active_x_x88_symbol : Boolean;
        signal binary_46_trigger_x_x89_symbol : Boolean;
        signal simple_obj_ref_44_complete_90_symbol : Boolean;
        signal simple_obj_ref_45_complete_91_symbol : Boolean;
        signal binary_46_complete_92_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_36_to_assign_stmt_47_59_start <= assign_stmt_36_to_assign_stmt_47_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_60_symbol  <= assign_stmt_36_to_assign_stmt_47_59_start; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/$entry
        assign_stmt_36_active_x_x62_symbol <= binary_34_complete_67_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/assign_stmt_36_active_
        assign_stmt_36_completed_x_x63_symbol <= assign_stmt_36_active_x_x62_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/assign_stmt_36_completed_
        binary_34_active_x_x64_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_active_ 
          signal binary_34_active_x_x64_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_34_active_x_x64_predecessors(0) <= binary_34_trigger_x_x65_symbol;
          binary_34_active_x_x64_predecessors(1) <= simple_obj_ref_31_complete_66_symbol;
          binary_34_active_x_x64_join: join -- 
            port map( -- 
              preds => binary_34_active_x_x64_predecessors,
              symbol_out => binary_34_active_x_x64_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_active_
        binary_34_trigger_x_x65_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_trigger_
        simple_obj_ref_31_complete_66_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/simple_obj_ref_31_complete
        binary_34_complete_67: Block -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete 
          signal binary_34_complete_67_start: Boolean;
          signal Xentry_68_symbol: Boolean;
          signal Xexit_69_symbol: Boolean;
          signal rr_70_symbol : Boolean;
          signal ra_71_symbol : Boolean;
          signal cr_72_symbol : Boolean;
          signal ca_73_symbol : Boolean;
          -- 
        begin -- 
          binary_34_complete_67_start <= binary_34_active_x_x64_symbol; -- control passed to block
          Xentry_68_symbol  <= binary_34_complete_67_start; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete/$entry
          rr_70_symbol <= Xentry_68_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete/rr
          binary_34_inst_req_0 <= rr_70_symbol; -- link to DP
          ra_71_symbol <= binary_34_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete/ra
          cr_72_symbol <= ra_71_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete/cr
          binary_34_inst_req_1 <= cr_72_symbol; -- link to DP
          ca_73_symbol <= binary_34_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete/ca
          Xexit_69_symbol <= ca_73_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete/$exit
          binary_34_complete_67_symbol <= Xexit_69_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_34_complete
        assign_stmt_42_active_x_x74_symbol <= binary_41_complete_79_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/assign_stmt_42_active_
        assign_stmt_42_completed_x_x75_symbol <= assign_stmt_42_active_x_x74_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/assign_stmt_42_completed_
        binary_41_active_x_x76_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_active_ 
          signal binary_41_active_x_x76_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_41_active_x_x76_predecessors(0) <= binary_41_trigger_x_x77_symbol;
          binary_41_active_x_x76_predecessors(1) <= simple_obj_ref_38_complete_78_symbol;
          binary_41_active_x_x76_join: join -- 
            port map( -- 
              preds => binary_41_active_x_x76_predecessors,
              symbol_out => binary_41_active_x_x76_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_active_
        binary_41_trigger_x_x77_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_trigger_
        simple_obj_ref_38_complete_78_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/simple_obj_ref_38_complete
        binary_41_complete_79: Block -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete 
          signal binary_41_complete_79_start: Boolean;
          signal Xentry_80_symbol: Boolean;
          signal Xexit_81_symbol: Boolean;
          signal rr_82_symbol : Boolean;
          signal ra_83_symbol : Boolean;
          signal cr_84_symbol : Boolean;
          signal ca_85_symbol : Boolean;
          -- 
        begin -- 
          binary_41_complete_79_start <= binary_41_active_x_x76_symbol; -- control passed to block
          Xentry_80_symbol  <= binary_41_complete_79_start; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete/$entry
          rr_82_symbol <= Xentry_80_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete/rr
          binary_41_inst_req_0 <= rr_82_symbol; -- link to DP
          ra_83_symbol <= binary_41_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete/ra
          cr_84_symbol <= ra_83_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete/cr
          binary_41_inst_req_1 <= cr_84_symbol; -- link to DP
          ca_85_symbol <= binary_41_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete/ca
          Xexit_81_symbol <= ca_85_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete/$exit
          binary_41_complete_79_symbol <= Xexit_81_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_41_complete
        assign_stmt_47_active_x_x86_symbol <= binary_46_complete_92_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/assign_stmt_47_active_
        assign_stmt_47_completed_x_x87_symbol <= assign_stmt_47_active_x_x86_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/assign_stmt_47_completed_
        binary_46_active_x_x88_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_active_ 
          signal binary_46_active_x_x88_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_46_active_x_x88_predecessors(0) <= binary_46_trigger_x_x89_symbol;
          binary_46_active_x_x88_predecessors(1) <= simple_obj_ref_44_complete_90_symbol;
          binary_46_active_x_x88_predecessors(2) <= simple_obj_ref_45_complete_91_symbol;
          binary_46_active_x_x88_join: join -- 
            port map( -- 
              preds => binary_46_active_x_x88_predecessors,
              symbol_out => binary_46_active_x_x88_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_active_
        binary_46_trigger_x_x89_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_trigger_
        simple_obj_ref_44_complete_90_symbol <= assign_stmt_36_completed_x_x63_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/simple_obj_ref_44_complete
        simple_obj_ref_45_complete_91_symbol <= assign_stmt_42_completed_x_x75_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/simple_obj_ref_45_complete
        binary_46_complete_92: Block -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete 
          signal binary_46_complete_92_start: Boolean;
          signal Xentry_93_symbol: Boolean;
          signal Xexit_94_symbol: Boolean;
          signal rr_95_symbol : Boolean;
          signal ra_96_symbol : Boolean;
          signal cr_97_symbol : Boolean;
          signal ca_98_symbol : Boolean;
          -- 
        begin -- 
          binary_46_complete_92_start <= binary_46_active_x_x88_symbol; -- control passed to block
          Xentry_93_symbol  <= binary_46_complete_92_start; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete/$entry
          rr_95_symbol <= Xentry_93_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete/rr
          binary_46_inst_req_0 <= rr_95_symbol; -- link to DP
          ra_96_symbol <= binary_46_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete/ra
          cr_97_symbol <= ra_96_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete/cr
          binary_46_inst_req_1 <= cr_97_symbol; -- link to DP
          ca_98_symbol <= binary_46_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete/ca
          Xexit_94_symbol <= ca_98_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete/$exit
          binary_46_complete_92_symbol <= Xexit_94_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/binary_46_complete
        Xexit_61_symbol <= assign_stmt_47_completed_x_x87_symbol; -- transition branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47/$exit
        assign_stmt_36_to_assign_stmt_47_59_symbol <= Xexit_61_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_36_to_assign_stmt_47
      if_stmt_48_dead_link_99: Block -- branch_block_stmt_13/if_stmt_48_dead_link 
        signal if_stmt_48_dead_link_99_start: Boolean;
        signal Xentry_100_symbol: Boolean;
        signal Xexit_101_symbol: Boolean;
        signal dead_transition_102_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_48_dead_link_99_start <= if_stmt_48_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_100_symbol  <= if_stmt_48_dead_link_99_start; -- transition branch_block_stmt_13/if_stmt_48_dead_link/$entry
        dead_transition_102_symbol <= false;
        Xexit_101_symbol <= dead_transition_102_symbol; -- transition branch_block_stmt_13/if_stmt_48_dead_link/$exit
        if_stmt_48_dead_link_99_symbol <= Xexit_101_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_48_dead_link
      if_stmt_48_eval_test_103: Block -- branch_block_stmt_13/if_stmt_48_eval_test 
        signal if_stmt_48_eval_test_103_start: Boolean;
        signal Xentry_104_symbol: Boolean;
        signal Xexit_105_symbol: Boolean;
        signal branch_req_106_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_48_eval_test_103_start <= if_stmt_48_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_104_symbol  <= if_stmt_48_eval_test_103_start; -- transition branch_block_stmt_13/if_stmt_48_eval_test/$entry
        branch_req_106_symbol <= Xentry_104_symbol; -- transition branch_block_stmt_13/if_stmt_48_eval_test/branch_req
        if_stmt_48_branch_req_0 <= branch_req_106_symbol; -- link to DP
        Xexit_105_symbol <= branch_req_106_symbol; -- transition branch_block_stmt_13/if_stmt_48_eval_test/$exit
        if_stmt_48_eval_test_103_symbol <= Xexit_105_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_48_eval_test
      simple_obj_ref_49_place_107_symbol  <=  if_stmt_48_eval_test_103_symbol; -- place branch_block_stmt_13/simple_obj_ref_49_place (optimized away) 
      if_stmt_48_if_link_108: Block -- branch_block_stmt_13/if_stmt_48_if_link 
        signal if_stmt_48_if_link_108_start: Boolean;
        signal Xentry_109_symbol: Boolean;
        signal Xexit_110_symbol: Boolean;
        signal if_choice_transition_111_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_48_if_link_108_start <= simple_obj_ref_49_place_107_symbol; -- control passed to block
        Xentry_109_symbol  <= if_stmt_48_if_link_108_start; -- transition branch_block_stmt_13/if_stmt_48_if_link/$entry
        if_choice_transition_111_symbol <= if_stmt_48_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_48_if_link/if_choice_transition
        Xexit_110_symbol <= if_choice_transition_111_symbol; -- transition branch_block_stmt_13/if_stmt_48_if_link/$exit
        if_stmt_48_if_link_108_symbol <= Xexit_110_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_48_if_link
      if_stmt_48_else_link_112: Block -- branch_block_stmt_13/if_stmt_48_else_link 
        signal if_stmt_48_else_link_112_start: Boolean;
        signal Xentry_113_symbol: Boolean;
        signal Xexit_114_symbol: Boolean;
        signal else_choice_transition_115_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_48_else_link_112_start <= simple_obj_ref_49_place_107_symbol; -- control passed to block
        Xentry_113_symbol  <= if_stmt_48_else_link_112_start; -- transition branch_block_stmt_13/if_stmt_48_else_link/$entry
        else_choice_transition_115_symbol <= if_stmt_48_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_48_else_link/else_choice_transition
        Xexit_114_symbol <= else_choice_transition_115_symbol; -- transition branch_block_stmt_13/if_stmt_48_else_link/$exit
        if_stmt_48_else_link_112_symbol <= Xexit_114_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_48_else_link
      bb_1_bb_2_116_symbol  <=  if_stmt_48_if_link_108_symbol; -- place branch_block_stmt_13/bb_1_bb_2 (optimized away) 
      bb_1_bb_3_117_symbol  <=  if_stmt_48_else_link_112_symbol; -- place branch_block_stmt_13/bb_1_bb_3 (optimized away) 
      assign_stmt_60_to_assign_stmt_137_118: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137 
        signal assign_stmt_60_to_assign_stmt_137_118_start: Boolean;
        signal Xentry_119_symbol: Boolean;
        signal Xexit_120_symbol: Boolean;
        signal assign_stmt_60_active_x_x121_symbol : Boolean;
        signal assign_stmt_60_completed_x_x122_symbol : Boolean;
        signal binary_59_active_x_x123_symbol : Boolean;
        signal binary_59_trigger_x_x124_symbol : Boolean;
        signal simple_obj_ref_56_complete_125_symbol : Boolean;
        signal binary_59_complete_126_symbol : Boolean;
        signal assign_stmt_66_active_x_x133_symbol : Boolean;
        signal assign_stmt_66_completed_x_x134_symbol : Boolean;
        signal binary_65_active_x_x135_symbol : Boolean;
        signal binary_65_trigger_x_x136_symbol : Boolean;
        signal simple_obj_ref_62_complete_137_symbol : Boolean;
        signal binary_65_complete_138_symbol : Boolean;
        signal assign_stmt_71_active_x_x145_symbol : Boolean;
        signal assign_stmt_71_completed_x_x146_symbol : Boolean;
        signal type_cast_70_active_x_x147_symbol : Boolean;
        signal type_cast_70_trigger_x_x148_symbol : Boolean;
        signal simple_obj_ref_69_complete_149_symbol : Boolean;
        signal type_cast_70_complete_150_symbol : Boolean;
        signal assign_stmt_77_active_x_x155_symbol : Boolean;
        signal assign_stmt_77_completed_x_x156_symbol : Boolean;
        signal binary_76_active_x_x157_symbol : Boolean;
        signal binary_76_trigger_x_x158_symbol : Boolean;
        signal simple_obj_ref_73_complete_159_symbol : Boolean;
        signal binary_76_complete_160_symbol : Boolean;
        signal assign_stmt_83_active_x_x167_symbol : Boolean;
        signal assign_stmt_83_completed_x_x168_symbol : Boolean;
        signal binary_82_active_x_x169_symbol : Boolean;
        signal binary_82_trigger_x_x170_symbol : Boolean;
        signal simple_obj_ref_81_complete_171_symbol : Boolean;
        signal binary_82_complete_172_symbol : Boolean;
        signal assign_stmt_92_active_x_x179_symbol : Boolean;
        signal assign_stmt_92_completed_x_x180_symbol : Boolean;
        signal binary_91_active_x_x181_symbol : Boolean;
        signal binary_91_trigger_x_x182_symbol : Boolean;
        signal type_cast_87_active_x_x183_symbol : Boolean;
        signal type_cast_87_trigger_x_x184_symbol : Boolean;
        signal simple_obj_ref_86_complete_185_symbol : Boolean;
        signal type_cast_87_complete_186_symbol : Boolean;
        signal binary_91_complete_191_symbol : Boolean;
        signal assign_stmt_98_active_x_x198_symbol : Boolean;
        signal assign_stmt_98_completed_x_x199_symbol : Boolean;
        signal binary_97_active_x_x200_symbol : Boolean;
        signal binary_97_trigger_x_x201_symbol : Boolean;
        signal simple_obj_ref_94_complete_202_symbol : Boolean;
        signal binary_97_complete_203_symbol : Boolean;
        signal assign_stmt_104_active_x_x210_symbol : Boolean;
        signal assign_stmt_104_completed_x_x211_symbol : Boolean;
        signal binary_103_active_x_x212_symbol : Boolean;
        signal binary_103_trigger_x_x213_symbol : Boolean;
        signal simple_obj_ref_100_complete_214_symbol : Boolean;
        signal binary_103_complete_215_symbol : Boolean;
        signal assign_stmt_110_active_x_x222_symbol : Boolean;
        signal assign_stmt_110_completed_x_x223_symbol : Boolean;
        signal binary_109_active_x_x224_symbol : Boolean;
        signal binary_109_trigger_x_x225_symbol : Boolean;
        signal simple_obj_ref_106_complete_226_symbol : Boolean;
        signal binary_109_complete_227_symbol : Boolean;
        signal assign_stmt_116_active_x_x234_symbol : Boolean;
        signal assign_stmt_116_completed_x_x235_symbol : Boolean;
        signal ternary_115_trigger_x_x236_symbol : Boolean;
        signal ternary_115_active_x_x237_symbol : Boolean;
        signal simple_obj_ref_112_complete_238_symbol : Boolean;
        signal simple_obj_ref_113_complete_239_symbol : Boolean;
        signal simple_obj_ref_114_complete_240_symbol : Boolean;
        signal ternary_115_complete_241_symbol : Boolean;
        signal assign_stmt_120_active_x_x246_symbol : Boolean;
        signal assign_stmt_120_completed_x_x247_symbol : Boolean;
        signal type_cast_119_active_x_x248_symbol : Boolean;
        signal type_cast_119_trigger_x_x249_symbol : Boolean;
        signal simple_obj_ref_118_complete_250_symbol : Boolean;
        signal type_cast_119_complete_251_symbol : Boolean;
        signal assign_stmt_126_active_x_x256_symbol : Boolean;
        signal assign_stmt_126_completed_x_x257_symbol : Boolean;
        signal binary_125_active_x_x258_symbol : Boolean;
        signal binary_125_trigger_x_x259_symbol : Boolean;
        signal simple_obj_ref_122_complete_260_symbol : Boolean;
        signal binary_125_complete_261_symbol : Boolean;
        signal assign_stmt_132_active_x_x268_symbol : Boolean;
        signal assign_stmt_132_completed_x_x269_symbol : Boolean;
        signal binary_131_active_x_x270_symbol : Boolean;
        signal binary_131_trigger_x_x271_symbol : Boolean;
        signal simple_obj_ref_128_complete_272_symbol : Boolean;
        signal binary_131_complete_273_symbol : Boolean;
        signal assign_stmt_137_active_x_x280_symbol : Boolean;
        signal assign_stmt_137_completed_x_x281_symbol : Boolean;
        signal binary_136_active_x_x282_symbol : Boolean;
        signal binary_136_trigger_x_x283_symbol : Boolean;
        signal simple_obj_ref_134_complete_284_symbol : Boolean;
        signal simple_obj_ref_135_complete_285_symbol : Boolean;
        signal binary_136_complete_286_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_60_to_assign_stmt_137_118_start <= assign_stmt_60_to_assign_stmt_137_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_119_symbol  <= assign_stmt_60_to_assign_stmt_137_118_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/$entry
        assign_stmt_60_active_x_x121_symbol <= binary_59_complete_126_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_60_active_
        assign_stmt_60_completed_x_x122_symbol <= assign_stmt_60_active_x_x121_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_60_completed_
        binary_59_active_x_x123_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_active_ 
          signal binary_59_active_x_x123_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_59_active_x_x123_predecessors(0) <= binary_59_trigger_x_x124_symbol;
          binary_59_active_x_x123_predecessors(1) <= simple_obj_ref_56_complete_125_symbol;
          binary_59_active_x_x123_join: join -- 
            port map( -- 
              preds => binary_59_active_x_x123_predecessors,
              symbol_out => binary_59_active_x_x123_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_active_
        binary_59_trigger_x_x124_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_trigger_
        simple_obj_ref_56_complete_125_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_56_complete
        binary_59_complete_126: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete 
          signal binary_59_complete_126_start: Boolean;
          signal Xentry_127_symbol: Boolean;
          signal Xexit_128_symbol: Boolean;
          signal rr_129_symbol : Boolean;
          signal ra_130_symbol : Boolean;
          signal cr_131_symbol : Boolean;
          signal ca_132_symbol : Boolean;
          -- 
        begin -- 
          binary_59_complete_126_start <= binary_59_active_x_x123_symbol; -- control passed to block
          Xentry_127_symbol  <= binary_59_complete_126_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete/$entry
          rr_129_symbol <= Xentry_127_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete/rr
          binary_59_inst_req_0 <= rr_129_symbol; -- link to DP
          ra_130_symbol <= binary_59_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete/ra
          cr_131_symbol <= ra_130_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete/cr
          binary_59_inst_req_1 <= cr_131_symbol; -- link to DP
          ca_132_symbol <= binary_59_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete/ca
          Xexit_128_symbol <= ca_132_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete/$exit
          binary_59_complete_126_symbol <= Xexit_128_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_59_complete
        assign_stmt_66_active_x_x133_symbol <= binary_65_complete_138_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_66_active_
        assign_stmt_66_completed_x_x134_symbol <= assign_stmt_66_active_x_x133_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_66_completed_
        binary_65_active_x_x135_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_active_ 
          signal binary_65_active_x_x135_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_65_active_x_x135_predecessors(0) <= binary_65_trigger_x_x136_symbol;
          binary_65_active_x_x135_predecessors(1) <= simple_obj_ref_62_complete_137_symbol;
          binary_65_active_x_x135_join: join -- 
            port map( -- 
              preds => binary_65_active_x_x135_predecessors,
              symbol_out => binary_65_active_x_x135_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_active_
        binary_65_trigger_x_x136_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_trigger_
        simple_obj_ref_62_complete_137_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_62_complete
        binary_65_complete_138: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete 
          signal binary_65_complete_138_start: Boolean;
          signal Xentry_139_symbol: Boolean;
          signal Xexit_140_symbol: Boolean;
          signal rr_141_symbol : Boolean;
          signal ra_142_symbol : Boolean;
          signal cr_143_symbol : Boolean;
          signal ca_144_symbol : Boolean;
          -- 
        begin -- 
          binary_65_complete_138_start <= binary_65_active_x_x135_symbol; -- control passed to block
          Xentry_139_symbol  <= binary_65_complete_138_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete/$entry
          rr_141_symbol <= Xentry_139_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete/rr
          binary_65_inst_req_0 <= rr_141_symbol; -- link to DP
          ra_142_symbol <= binary_65_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete/ra
          cr_143_symbol <= ra_142_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete/cr
          binary_65_inst_req_1 <= cr_143_symbol; -- link to DP
          ca_144_symbol <= binary_65_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete/ca
          Xexit_140_symbol <= ca_144_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete/$exit
          binary_65_complete_138_symbol <= Xexit_140_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_65_complete
        assign_stmt_71_active_x_x145_symbol <= type_cast_70_complete_150_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_71_active_
        assign_stmt_71_completed_x_x146_symbol <= assign_stmt_71_active_x_x145_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_71_completed_
        type_cast_70_active_x_x147_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_active_ 
          signal type_cast_70_active_x_x147_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_70_active_x_x147_predecessors(0) <= type_cast_70_trigger_x_x148_symbol;
          type_cast_70_active_x_x147_predecessors(1) <= simple_obj_ref_69_complete_149_symbol;
          type_cast_70_active_x_x147_join: join -- 
            port map( -- 
              preds => type_cast_70_active_x_x147_predecessors,
              symbol_out => type_cast_70_active_x_x147_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_active_
        type_cast_70_trigger_x_x148_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_trigger_
        simple_obj_ref_69_complete_149_symbol <= assign_stmt_66_completed_x_x134_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_69_complete
        type_cast_70_complete_150: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_complete 
          signal type_cast_70_complete_150_start: Boolean;
          signal Xentry_151_symbol: Boolean;
          signal Xexit_152_symbol: Boolean;
          signal req_153_symbol : Boolean;
          signal ack_154_symbol : Boolean;
          -- 
        begin -- 
          type_cast_70_complete_150_start <= type_cast_70_active_x_x147_symbol; -- control passed to block
          Xentry_151_symbol  <= type_cast_70_complete_150_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_complete/$entry
          req_153_symbol <= Xentry_151_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_complete/req
          type_cast_70_inst_req_0 <= req_153_symbol; -- link to DP
          ack_154_symbol <= type_cast_70_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_complete/ack
          Xexit_152_symbol <= ack_154_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_complete/$exit
          type_cast_70_complete_150_symbol <= Xexit_152_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_70_complete
        assign_stmt_77_active_x_x155_symbol <= binary_76_complete_160_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_77_active_
        assign_stmt_77_completed_x_x156_symbol <= assign_stmt_77_active_x_x155_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_77_completed_
        binary_76_active_x_x157_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_active_ 
          signal binary_76_active_x_x157_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_76_active_x_x157_predecessors(0) <= binary_76_trigger_x_x158_symbol;
          binary_76_active_x_x157_predecessors(1) <= simple_obj_ref_73_complete_159_symbol;
          binary_76_active_x_x157_join: join -- 
            port map( -- 
              preds => binary_76_active_x_x157_predecessors,
              symbol_out => binary_76_active_x_x157_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_active_
        binary_76_trigger_x_x158_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_trigger_
        simple_obj_ref_73_complete_159_symbol <= assign_stmt_71_completed_x_x146_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_73_complete
        binary_76_complete_160: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete 
          signal binary_76_complete_160_start: Boolean;
          signal Xentry_161_symbol: Boolean;
          signal Xexit_162_symbol: Boolean;
          signal rr_163_symbol : Boolean;
          signal ra_164_symbol : Boolean;
          signal cr_165_symbol : Boolean;
          signal ca_166_symbol : Boolean;
          -- 
        begin -- 
          binary_76_complete_160_start <= binary_76_active_x_x157_symbol; -- control passed to block
          Xentry_161_symbol  <= binary_76_complete_160_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete/$entry
          rr_163_symbol <= Xentry_161_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete/rr
          binary_76_inst_req_0 <= rr_163_symbol; -- link to DP
          ra_164_symbol <= binary_76_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete/ra
          cr_165_symbol <= ra_164_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete/cr
          binary_76_inst_req_1 <= cr_165_symbol; -- link to DP
          ca_166_symbol <= binary_76_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete/ca
          Xexit_162_symbol <= ca_166_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete/$exit
          binary_76_complete_160_symbol <= Xexit_162_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_76_complete
        assign_stmt_83_active_x_x167_symbol <= binary_82_complete_172_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_83_active_
        assign_stmt_83_completed_x_x168_symbol <= assign_stmt_83_active_x_x167_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_83_completed_
        binary_82_active_x_x169_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_active_ 
          signal binary_82_active_x_x169_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_82_active_x_x169_predecessors(0) <= binary_82_trigger_x_x170_symbol;
          binary_82_active_x_x169_predecessors(1) <= simple_obj_ref_81_complete_171_symbol;
          binary_82_active_x_x169_join: join -- 
            port map( -- 
              preds => binary_82_active_x_x169_predecessors,
              symbol_out => binary_82_active_x_x169_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_active_
        binary_82_trigger_x_x170_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_trigger_
        simple_obj_ref_81_complete_171_symbol <= assign_stmt_77_completed_x_x156_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_81_complete
        binary_82_complete_172: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete 
          signal binary_82_complete_172_start: Boolean;
          signal Xentry_173_symbol: Boolean;
          signal Xexit_174_symbol: Boolean;
          signal rr_175_symbol : Boolean;
          signal ra_176_symbol : Boolean;
          signal cr_177_symbol : Boolean;
          signal ca_178_symbol : Boolean;
          -- 
        begin -- 
          binary_82_complete_172_start <= binary_82_active_x_x169_symbol; -- control passed to block
          Xentry_173_symbol  <= binary_82_complete_172_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete/$entry
          rr_175_symbol <= Xentry_173_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete/rr
          binary_82_inst_req_0 <= rr_175_symbol; -- link to DP
          ra_176_symbol <= binary_82_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete/ra
          cr_177_symbol <= ra_176_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete/cr
          binary_82_inst_req_1 <= cr_177_symbol; -- link to DP
          ca_178_symbol <= binary_82_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete/ca
          Xexit_174_symbol <= ca_178_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete/$exit
          binary_82_complete_172_symbol <= Xexit_174_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_82_complete
        assign_stmt_92_active_x_x179_symbol <= binary_91_complete_191_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_92_active_
        assign_stmt_92_completed_x_x180_symbol <= assign_stmt_92_active_x_x179_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_92_completed_
        binary_91_active_x_x181_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_active_ 
          signal binary_91_active_x_x181_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_91_active_x_x181_predecessors(0) <= binary_91_trigger_x_x182_symbol;
          binary_91_active_x_x181_predecessors(1) <= type_cast_87_complete_186_symbol;
          binary_91_active_x_x181_join: join -- 
            port map( -- 
              preds => binary_91_active_x_x181_predecessors,
              symbol_out => binary_91_active_x_x181_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_active_
        binary_91_trigger_x_x182_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_trigger_
        type_cast_87_active_x_x183_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_active_ 
          signal type_cast_87_active_x_x183_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_87_active_x_x183_predecessors(0) <= type_cast_87_trigger_x_x184_symbol;
          type_cast_87_active_x_x183_predecessors(1) <= simple_obj_ref_86_complete_185_symbol;
          type_cast_87_active_x_x183_join: join -- 
            port map( -- 
              preds => type_cast_87_active_x_x183_predecessors,
              symbol_out => type_cast_87_active_x_x183_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_active_
        type_cast_87_trigger_x_x184_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_trigger_
        simple_obj_ref_86_complete_185_symbol <= assign_stmt_60_completed_x_x122_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_86_complete
        type_cast_87_complete_186: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_complete 
          signal type_cast_87_complete_186_start: Boolean;
          signal Xentry_187_symbol: Boolean;
          signal Xexit_188_symbol: Boolean;
          signal req_189_symbol : Boolean;
          signal ack_190_symbol : Boolean;
          -- 
        begin -- 
          type_cast_87_complete_186_start <= type_cast_87_active_x_x183_symbol; -- control passed to block
          Xentry_187_symbol  <= type_cast_87_complete_186_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_complete/$entry
          req_189_symbol <= Xentry_187_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_complete/req
          type_cast_87_inst_req_0 <= req_189_symbol; -- link to DP
          ack_190_symbol <= type_cast_87_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_complete/ack
          Xexit_188_symbol <= ack_190_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_complete/$exit
          type_cast_87_complete_186_symbol <= Xexit_188_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_87_complete
        binary_91_complete_191: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete 
          signal binary_91_complete_191_start: Boolean;
          signal Xentry_192_symbol: Boolean;
          signal Xexit_193_symbol: Boolean;
          signal rr_194_symbol : Boolean;
          signal ra_195_symbol : Boolean;
          signal cr_196_symbol : Boolean;
          signal ca_197_symbol : Boolean;
          -- 
        begin -- 
          binary_91_complete_191_start <= binary_91_active_x_x181_symbol; -- control passed to block
          Xentry_192_symbol  <= binary_91_complete_191_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete/$entry
          rr_194_symbol <= Xentry_192_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete/rr
          binary_91_inst_req_0 <= rr_194_symbol; -- link to DP
          ra_195_symbol <= binary_91_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete/ra
          cr_196_symbol <= ra_195_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete/cr
          binary_91_inst_req_1 <= cr_196_symbol; -- link to DP
          ca_197_symbol <= binary_91_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete/ca
          Xexit_193_symbol <= ca_197_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete/$exit
          binary_91_complete_191_symbol <= Xexit_193_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_91_complete
        assign_stmt_98_active_x_x198_symbol <= binary_97_complete_203_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_98_active_
        assign_stmt_98_completed_x_x199_symbol <= assign_stmt_98_active_x_x198_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_98_completed_
        binary_97_active_x_x200_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_active_ 
          signal binary_97_active_x_x200_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_97_active_x_x200_predecessors(0) <= binary_97_trigger_x_x201_symbol;
          binary_97_active_x_x200_predecessors(1) <= simple_obj_ref_94_complete_202_symbol;
          binary_97_active_x_x200_join: join -- 
            port map( -- 
              preds => binary_97_active_x_x200_predecessors,
              symbol_out => binary_97_active_x_x200_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_active_
        binary_97_trigger_x_x201_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_trigger_
        simple_obj_ref_94_complete_202_symbol <= assign_stmt_83_completed_x_x168_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_94_complete
        binary_97_complete_203: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete 
          signal binary_97_complete_203_start: Boolean;
          signal Xentry_204_symbol: Boolean;
          signal Xexit_205_symbol: Boolean;
          signal rr_206_symbol : Boolean;
          signal ra_207_symbol : Boolean;
          signal cr_208_symbol : Boolean;
          signal ca_209_symbol : Boolean;
          -- 
        begin -- 
          binary_97_complete_203_start <= binary_97_active_x_x200_symbol; -- control passed to block
          Xentry_204_symbol  <= binary_97_complete_203_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete/$entry
          rr_206_symbol <= Xentry_204_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete/rr
          binary_97_inst_req_0 <= rr_206_symbol; -- link to DP
          ra_207_symbol <= binary_97_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete/ra
          cr_208_symbol <= ra_207_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete/cr
          binary_97_inst_req_1 <= cr_208_symbol; -- link to DP
          ca_209_symbol <= binary_97_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete/ca
          Xexit_205_symbol <= ca_209_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete/$exit
          binary_97_complete_203_symbol <= Xexit_205_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_97_complete
        assign_stmt_104_active_x_x210_symbol <= binary_103_complete_215_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_104_active_
        assign_stmt_104_completed_x_x211_symbol <= assign_stmt_104_active_x_x210_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_104_completed_
        binary_103_active_x_x212_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_active_ 
          signal binary_103_active_x_x212_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_103_active_x_x212_predecessors(0) <= binary_103_trigger_x_x213_symbol;
          binary_103_active_x_x212_predecessors(1) <= simple_obj_ref_100_complete_214_symbol;
          binary_103_active_x_x212_join: join -- 
            port map( -- 
              preds => binary_103_active_x_x212_predecessors,
              symbol_out => binary_103_active_x_x212_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_active_
        binary_103_trigger_x_x213_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_trigger_
        simple_obj_ref_100_complete_214_symbol <= assign_stmt_98_completed_x_x199_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_100_complete
        binary_103_complete_215: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete 
          signal binary_103_complete_215_start: Boolean;
          signal Xentry_216_symbol: Boolean;
          signal Xexit_217_symbol: Boolean;
          signal rr_218_symbol : Boolean;
          signal ra_219_symbol : Boolean;
          signal cr_220_symbol : Boolean;
          signal ca_221_symbol : Boolean;
          -- 
        begin -- 
          binary_103_complete_215_start <= binary_103_active_x_x212_symbol; -- control passed to block
          Xentry_216_symbol  <= binary_103_complete_215_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete/$entry
          rr_218_symbol <= Xentry_216_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete/rr
          binary_103_inst_req_0 <= rr_218_symbol; -- link to DP
          ra_219_symbol <= binary_103_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete/ra
          cr_220_symbol <= ra_219_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete/cr
          binary_103_inst_req_1 <= cr_220_symbol; -- link to DP
          ca_221_symbol <= binary_103_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete/ca
          Xexit_217_symbol <= ca_221_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete/$exit
          binary_103_complete_215_symbol <= Xexit_217_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_103_complete
        assign_stmt_110_active_x_x222_symbol <= binary_109_complete_227_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_110_active_
        assign_stmt_110_completed_x_x223_symbol <= assign_stmt_110_active_x_x222_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_110_completed_
        binary_109_active_x_x224_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_active_ 
          signal binary_109_active_x_x224_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_109_active_x_x224_predecessors(0) <= binary_109_trigger_x_x225_symbol;
          binary_109_active_x_x224_predecessors(1) <= simple_obj_ref_106_complete_226_symbol;
          binary_109_active_x_x224_join: join -- 
            port map( -- 
              preds => binary_109_active_x_x224_predecessors,
              symbol_out => binary_109_active_x_x224_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_active_
        binary_109_trigger_x_x225_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_trigger_
        simple_obj_ref_106_complete_226_symbol <= assign_stmt_83_completed_x_x168_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_106_complete
        binary_109_complete_227: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete 
          signal binary_109_complete_227_start: Boolean;
          signal Xentry_228_symbol: Boolean;
          signal Xexit_229_symbol: Boolean;
          signal rr_230_symbol : Boolean;
          signal ra_231_symbol : Boolean;
          signal cr_232_symbol : Boolean;
          signal ca_233_symbol : Boolean;
          -- 
        begin -- 
          binary_109_complete_227_start <= binary_109_active_x_x224_symbol; -- control passed to block
          Xentry_228_symbol  <= binary_109_complete_227_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete/$entry
          rr_230_symbol <= Xentry_228_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete/rr
          binary_109_inst_req_0 <= rr_230_symbol; -- link to DP
          ra_231_symbol <= binary_109_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete/ra
          cr_232_symbol <= ra_231_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete/cr
          binary_109_inst_req_1 <= cr_232_symbol; -- link to DP
          ca_233_symbol <= binary_109_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete/ca
          Xexit_229_symbol <= ca_233_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete/$exit
          binary_109_complete_227_symbol <= Xexit_229_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_109_complete
        assign_stmt_116_active_x_x234_symbol <= ternary_115_complete_241_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_116_active_
        assign_stmt_116_completed_x_x235_symbol <= assign_stmt_116_active_x_x234_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_116_completed_
        ternary_115_trigger_x_x236_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_trigger_
        ternary_115_active_x_x237_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_active_ 
          signal ternary_115_active_x_x237_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          ternary_115_active_x_x237_predecessors(0) <= ternary_115_trigger_x_x236_symbol;
          ternary_115_active_x_x237_predecessors(1) <= simple_obj_ref_112_complete_238_symbol;
          ternary_115_active_x_x237_predecessors(2) <= simple_obj_ref_113_complete_239_symbol;
          ternary_115_active_x_x237_predecessors(3) <= simple_obj_ref_114_complete_240_symbol;
          ternary_115_active_x_x237_join: join -- 
            port map( -- 
              preds => ternary_115_active_x_x237_predecessors,
              symbol_out => ternary_115_active_x_x237_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_active_
        simple_obj_ref_112_complete_238_symbol <= assign_stmt_92_completed_x_x180_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_112_complete
        simple_obj_ref_113_complete_239_symbol <= assign_stmt_104_completed_x_x211_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_113_complete
        simple_obj_ref_114_complete_240_symbol <= assign_stmt_110_completed_x_x223_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_114_complete
        ternary_115_complete_241: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_complete 
          signal ternary_115_complete_241_start: Boolean;
          signal Xentry_242_symbol: Boolean;
          signal Xexit_243_symbol: Boolean;
          signal req_244_symbol : Boolean;
          signal ack_245_symbol : Boolean;
          -- 
        begin -- 
          ternary_115_complete_241_start <= ternary_115_active_x_x237_symbol; -- control passed to block
          Xentry_242_symbol  <= ternary_115_complete_241_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_complete/$entry
          req_244_symbol <= Xentry_242_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_complete/req
          ternary_115_inst_req_0 <= req_244_symbol; -- link to DP
          ack_245_symbol <= ternary_115_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_complete/ack
          Xexit_243_symbol <= ack_245_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_complete/$exit
          ternary_115_complete_241_symbol <= Xexit_243_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/ternary_115_complete
        assign_stmt_120_active_x_x246_symbol <= type_cast_119_complete_251_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_120_active_
        assign_stmt_120_completed_x_x247_symbol <= assign_stmt_120_active_x_x246_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_120_completed_
        type_cast_119_active_x_x248_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_active_ 
          signal type_cast_119_active_x_x248_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_119_active_x_x248_predecessors(0) <= type_cast_119_trigger_x_x249_symbol;
          type_cast_119_active_x_x248_predecessors(1) <= simple_obj_ref_118_complete_250_symbol;
          type_cast_119_active_x_x248_join: join -- 
            port map( -- 
              preds => type_cast_119_active_x_x248_predecessors,
              symbol_out => type_cast_119_active_x_x248_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_active_
        type_cast_119_trigger_x_x249_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_trigger_
        simple_obj_ref_118_complete_250_symbol <= assign_stmt_116_completed_x_x235_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_118_complete
        type_cast_119_complete_251: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_complete 
          signal type_cast_119_complete_251_start: Boolean;
          signal Xentry_252_symbol: Boolean;
          signal Xexit_253_symbol: Boolean;
          signal req_254_symbol : Boolean;
          signal ack_255_symbol : Boolean;
          -- 
        begin -- 
          type_cast_119_complete_251_start <= type_cast_119_active_x_x248_symbol; -- control passed to block
          Xentry_252_symbol  <= type_cast_119_complete_251_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_complete/$entry
          req_254_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_complete/req
          type_cast_119_inst_req_0 <= req_254_symbol; -- link to DP
          ack_255_symbol <= type_cast_119_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_complete/ack
          Xexit_253_symbol <= ack_255_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_complete/$exit
          type_cast_119_complete_251_symbol <= Xexit_253_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/type_cast_119_complete
        assign_stmt_126_active_x_x256_symbol <= binary_125_complete_261_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_126_active_
        assign_stmt_126_completed_x_x257_symbol <= assign_stmt_126_active_x_x256_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_126_completed_
        binary_125_active_x_x258_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_active_ 
          signal binary_125_active_x_x258_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_125_active_x_x258_predecessors(0) <= binary_125_trigger_x_x259_symbol;
          binary_125_active_x_x258_predecessors(1) <= simple_obj_ref_122_complete_260_symbol;
          binary_125_active_x_x258_join: join -- 
            port map( -- 
              preds => binary_125_active_x_x258_predecessors,
              symbol_out => binary_125_active_x_x258_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_active_
        binary_125_trigger_x_x259_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_trigger_
        simple_obj_ref_122_complete_260_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_122_complete
        binary_125_complete_261: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete 
          signal binary_125_complete_261_start: Boolean;
          signal Xentry_262_symbol: Boolean;
          signal Xexit_263_symbol: Boolean;
          signal rr_264_symbol : Boolean;
          signal ra_265_symbol : Boolean;
          signal cr_266_symbol : Boolean;
          signal ca_267_symbol : Boolean;
          -- 
        begin -- 
          binary_125_complete_261_start <= binary_125_active_x_x258_symbol; -- control passed to block
          Xentry_262_symbol  <= binary_125_complete_261_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete/$entry
          rr_264_symbol <= Xentry_262_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete/rr
          binary_125_inst_req_0 <= rr_264_symbol; -- link to DP
          ra_265_symbol <= binary_125_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete/ra
          cr_266_symbol <= ra_265_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete/cr
          binary_125_inst_req_1 <= cr_266_symbol; -- link to DP
          ca_267_symbol <= binary_125_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete/ca
          Xexit_263_symbol <= ca_267_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete/$exit
          binary_125_complete_261_symbol <= Xexit_263_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_125_complete
        assign_stmt_132_active_x_x268_symbol <= binary_131_complete_273_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_132_active_
        assign_stmt_132_completed_x_x269_symbol <= assign_stmt_132_active_x_x268_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_132_completed_
        binary_131_active_x_x270_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_active_ 
          signal binary_131_active_x_x270_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_131_active_x_x270_predecessors(0) <= binary_131_trigger_x_x271_symbol;
          binary_131_active_x_x270_predecessors(1) <= simple_obj_ref_128_complete_272_symbol;
          binary_131_active_x_x270_join: join -- 
            port map( -- 
              preds => binary_131_active_x_x270_predecessors,
              symbol_out => binary_131_active_x_x270_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_active_
        binary_131_trigger_x_x271_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_trigger_
        simple_obj_ref_128_complete_272_symbol <= assign_stmt_120_completed_x_x247_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_128_complete
        binary_131_complete_273: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete 
          signal binary_131_complete_273_start: Boolean;
          signal Xentry_274_symbol: Boolean;
          signal Xexit_275_symbol: Boolean;
          signal rr_276_symbol : Boolean;
          signal ra_277_symbol : Boolean;
          signal cr_278_symbol : Boolean;
          signal ca_279_symbol : Boolean;
          -- 
        begin -- 
          binary_131_complete_273_start <= binary_131_active_x_x270_symbol; -- control passed to block
          Xentry_274_symbol  <= binary_131_complete_273_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete/$entry
          rr_276_symbol <= Xentry_274_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete/rr
          binary_131_inst_req_0 <= rr_276_symbol; -- link to DP
          ra_277_symbol <= binary_131_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete/ra
          cr_278_symbol <= ra_277_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete/cr
          binary_131_inst_req_1 <= cr_278_symbol; -- link to DP
          ca_279_symbol <= binary_131_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete/ca
          Xexit_275_symbol <= ca_279_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete/$exit
          binary_131_complete_273_symbol <= Xexit_275_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_131_complete
        assign_stmt_137_active_x_x280_symbol <= binary_136_complete_286_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_137_active_
        assign_stmt_137_completed_x_x281_symbol <= assign_stmt_137_active_x_x280_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/assign_stmt_137_completed_
        binary_136_active_x_x282_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_active_ 
          signal binary_136_active_x_x282_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_136_active_x_x282_predecessors(0) <= binary_136_trigger_x_x283_symbol;
          binary_136_active_x_x282_predecessors(1) <= simple_obj_ref_134_complete_284_symbol;
          binary_136_active_x_x282_predecessors(2) <= simple_obj_ref_135_complete_285_symbol;
          binary_136_active_x_x282_join: join -- 
            port map( -- 
              preds => binary_136_active_x_x282_predecessors,
              symbol_out => binary_136_active_x_x282_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_active_
        binary_136_trigger_x_x283_symbol <= Xentry_119_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_trigger_
        simple_obj_ref_134_complete_284_symbol <= assign_stmt_132_completed_x_x269_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_134_complete
        simple_obj_ref_135_complete_285_symbol <= assign_stmt_126_completed_x_x257_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/simple_obj_ref_135_complete
        binary_136_complete_286: Block -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete 
          signal binary_136_complete_286_start: Boolean;
          signal Xentry_287_symbol: Boolean;
          signal Xexit_288_symbol: Boolean;
          signal rr_289_symbol : Boolean;
          signal ra_290_symbol : Boolean;
          signal cr_291_symbol : Boolean;
          signal ca_292_symbol : Boolean;
          -- 
        begin -- 
          binary_136_complete_286_start <= binary_136_active_x_x282_symbol; -- control passed to block
          Xentry_287_symbol  <= binary_136_complete_286_start; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete/$entry
          rr_289_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete/rr
          binary_136_inst_req_0 <= rr_289_symbol; -- link to DP
          ra_290_symbol <= binary_136_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete/ra
          cr_291_symbol <= ra_290_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete/cr
          binary_136_inst_req_1 <= cr_291_symbol; -- link to DP
          ca_292_symbol <= binary_136_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete/ca
          Xexit_288_symbol <= ca_292_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete/$exit
          binary_136_complete_286_symbol <= Xexit_288_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/binary_136_complete
        Xexit_120_symbol <= assign_stmt_137_completed_x_x281_symbol; -- transition branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137/$exit
        assign_stmt_60_to_assign_stmt_137_118_symbol <= Xexit_120_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_60_to_assign_stmt_137
      assign_stmt_145_293: Block -- branch_block_stmt_13/assign_stmt_145 
        signal assign_stmt_145_293_start: Boolean;
        signal Xentry_294_symbol: Boolean;
        signal Xexit_295_symbol: Boolean;
        signal assign_stmt_145_active_x_x296_symbol : Boolean;
        signal assign_stmt_145_completed_x_x297_symbol : Boolean;
        signal binary_144_active_x_x298_symbol : Boolean;
        signal binary_144_trigger_x_x299_symbol : Boolean;
        signal simple_obj_ref_141_complete_300_symbol : Boolean;
        signal binary_144_complete_301_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_145_293_start <= assign_stmt_145_x_xentry_x_xx_x24_symbol; -- control passed to block
        Xentry_294_symbol  <= assign_stmt_145_293_start; -- transition branch_block_stmt_13/assign_stmt_145/$entry
        assign_stmt_145_active_x_x296_symbol <= binary_144_complete_301_symbol; -- transition branch_block_stmt_13/assign_stmt_145/assign_stmt_145_active_
        assign_stmt_145_completed_x_x297_symbol <= assign_stmt_145_active_x_x296_symbol; -- transition branch_block_stmt_13/assign_stmt_145/assign_stmt_145_completed_
        binary_144_active_x_x298_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_145/binary_144_active_ 
          signal binary_144_active_x_x298_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_144_active_x_x298_predecessors(0) <= binary_144_trigger_x_x299_symbol;
          binary_144_active_x_x298_predecessors(1) <= simple_obj_ref_141_complete_300_symbol;
          binary_144_active_x_x298_join: join -- 
            port map( -- 
              preds => binary_144_active_x_x298_predecessors,
              symbol_out => binary_144_active_x_x298_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_145/binary_144_active_
        binary_144_trigger_x_x299_symbol <= Xentry_294_symbol; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_trigger_
        simple_obj_ref_141_complete_300_symbol <= Xentry_294_symbol; -- transition branch_block_stmt_13/assign_stmt_145/simple_obj_ref_141_complete
        binary_144_complete_301: Block -- branch_block_stmt_13/assign_stmt_145/binary_144_complete 
          signal binary_144_complete_301_start: Boolean;
          signal Xentry_302_symbol: Boolean;
          signal Xexit_303_symbol: Boolean;
          signal rr_304_symbol : Boolean;
          signal ra_305_symbol : Boolean;
          signal cr_306_symbol : Boolean;
          signal ca_307_symbol : Boolean;
          -- 
        begin -- 
          binary_144_complete_301_start <= binary_144_active_x_x298_symbol; -- control passed to block
          Xentry_302_symbol  <= binary_144_complete_301_start; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_complete/$entry
          rr_304_symbol <= Xentry_302_symbol; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_complete/rr
          binary_144_inst_req_0 <= rr_304_symbol; -- link to DP
          ra_305_symbol <= binary_144_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_complete/ra
          cr_306_symbol <= ra_305_symbol; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_complete/cr
          binary_144_inst_req_1 <= cr_306_symbol; -- link to DP
          ca_307_symbol <= binary_144_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_complete/ca
          Xexit_303_symbol <= ca_307_symbol; -- transition branch_block_stmt_13/assign_stmt_145/binary_144_complete/$exit
          binary_144_complete_301_symbol <= Xexit_303_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_145/binary_144_complete
        Xexit_295_symbol <= assign_stmt_145_completed_x_x297_symbol; -- transition branch_block_stmt_13/assign_stmt_145/$exit
        assign_stmt_145_293_symbol <= Xexit_295_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_145
      if_stmt_146_dead_link_308: Block -- branch_block_stmt_13/if_stmt_146_dead_link 
        signal if_stmt_146_dead_link_308_start: Boolean;
        signal Xentry_309_symbol: Boolean;
        signal Xexit_310_symbol: Boolean;
        signal dead_transition_311_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_146_dead_link_308_start <= if_stmt_146_x_xentry_x_xx_x26_symbol; -- control passed to block
        Xentry_309_symbol  <= if_stmt_146_dead_link_308_start; -- transition branch_block_stmt_13/if_stmt_146_dead_link/$entry
        dead_transition_311_symbol <= false;
        Xexit_310_symbol <= dead_transition_311_symbol; -- transition branch_block_stmt_13/if_stmt_146_dead_link/$exit
        if_stmt_146_dead_link_308_symbol <= Xexit_310_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_146_dead_link
      if_stmt_146_eval_test_312: Block -- branch_block_stmt_13/if_stmt_146_eval_test 
        signal if_stmt_146_eval_test_312_start: Boolean;
        signal Xentry_313_symbol: Boolean;
        signal Xexit_314_symbol: Boolean;
        signal branch_req_315_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_146_eval_test_312_start <= if_stmt_146_x_xentry_x_xx_x26_symbol; -- control passed to block
        Xentry_313_symbol  <= if_stmt_146_eval_test_312_start; -- transition branch_block_stmt_13/if_stmt_146_eval_test/$entry
        branch_req_315_symbol <= Xentry_313_symbol; -- transition branch_block_stmt_13/if_stmt_146_eval_test/branch_req
        if_stmt_146_branch_req_0 <= branch_req_315_symbol; -- link to DP
        Xexit_314_symbol <= branch_req_315_symbol; -- transition branch_block_stmt_13/if_stmt_146_eval_test/$exit
        if_stmt_146_eval_test_312_symbol <= Xexit_314_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_146_eval_test
      simple_obj_ref_147_place_316_symbol  <=  if_stmt_146_eval_test_312_symbol; -- place branch_block_stmt_13/simple_obj_ref_147_place (optimized away) 
      if_stmt_146_if_link_317: Block -- branch_block_stmt_13/if_stmt_146_if_link 
        signal if_stmt_146_if_link_317_start: Boolean;
        signal Xentry_318_symbol: Boolean;
        signal Xexit_319_symbol: Boolean;
        signal if_choice_transition_320_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_146_if_link_317_start <= simple_obj_ref_147_place_316_symbol; -- control passed to block
        Xentry_318_symbol  <= if_stmt_146_if_link_317_start; -- transition branch_block_stmt_13/if_stmt_146_if_link/$entry
        if_choice_transition_320_symbol <= if_stmt_146_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_146_if_link/if_choice_transition
        Xexit_319_symbol <= if_choice_transition_320_symbol; -- transition branch_block_stmt_13/if_stmt_146_if_link/$exit
        if_stmt_146_if_link_317_symbol <= Xexit_319_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_146_if_link
      if_stmt_146_else_link_321: Block -- branch_block_stmt_13/if_stmt_146_else_link 
        signal if_stmt_146_else_link_321_start: Boolean;
        signal Xentry_322_symbol: Boolean;
        signal Xexit_323_symbol: Boolean;
        signal else_choice_transition_324_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_146_else_link_321_start <= simple_obj_ref_147_place_316_symbol; -- control passed to block
        Xentry_322_symbol  <= if_stmt_146_else_link_321_start; -- transition branch_block_stmt_13/if_stmt_146_else_link/$entry
        else_choice_transition_324_symbol <= if_stmt_146_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_146_else_link/else_choice_transition
        Xexit_323_symbol <= else_choice_transition_324_symbol; -- transition branch_block_stmt_13/if_stmt_146_else_link/$exit
        if_stmt_146_else_link_321_symbol <= Xexit_323_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_146_else_link
      bb_3_bb_5_325_symbol  <=  if_stmt_146_if_link_317_symbol; -- place branch_block_stmt_13/bb_3_bb_5 (optimized away) 
      bb_3_bb_4_326_symbol  <=  if_stmt_146_else_link_321_symbol; -- place branch_block_stmt_13/bb_3_bb_4 (optimized away) 
      assign_stmt_176_327: Block -- branch_block_stmt_13/assign_stmt_176 
        signal assign_stmt_176_327_start: Boolean;
        signal Xentry_328_symbol: Boolean;
        signal Xexit_329_symbol: Boolean;
        signal assign_stmt_176_active_x_x330_symbol : Boolean;
        signal assign_stmt_176_completed_x_x331_symbol : Boolean;
        signal simple_obj_ref_175_complete_332_symbol : Boolean;
        signal simple_obj_ref_174_trigger_x_x333_symbol : Boolean;
        signal simple_obj_ref_174_complete_334_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_176_327_start <= assign_stmt_176_x_xentry_x_xx_x32_symbol; -- control passed to block
        Xentry_328_symbol  <= assign_stmt_176_327_start; -- transition branch_block_stmt_13/assign_stmt_176/$entry
        assign_stmt_176_active_x_x330_symbol <= simple_obj_ref_175_complete_332_symbol; -- transition branch_block_stmt_13/assign_stmt_176/assign_stmt_176_active_
        assign_stmt_176_completed_x_x331_symbol <= simple_obj_ref_174_complete_334_symbol; -- transition branch_block_stmt_13/assign_stmt_176/assign_stmt_176_completed_
        simple_obj_ref_175_complete_332_symbol <= Xentry_328_symbol; -- transition branch_block_stmt_13/assign_stmt_176/simple_obj_ref_175_complete
        simple_obj_ref_174_trigger_x_x333_symbol <= assign_stmt_176_active_x_x330_symbol; -- transition branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_trigger_
        simple_obj_ref_174_complete_334: Block -- branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_complete 
          signal simple_obj_ref_174_complete_334_start: Boolean;
          signal Xentry_335_symbol: Boolean;
          signal Xexit_336_symbol: Boolean;
          signal pipe_wreq_337_symbol : Boolean;
          signal pipe_wack_338_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_174_complete_334_start <= simple_obj_ref_174_trigger_x_x333_symbol; -- control passed to block
          Xentry_335_symbol  <= simple_obj_ref_174_complete_334_start; -- transition branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_complete/$entry
          pipe_wreq_337_symbol <= Xentry_335_symbol; -- transition branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_complete/pipe_wreq
          simple_obj_ref_174_inst_req_0 <= pipe_wreq_337_symbol; -- link to DP
          pipe_wack_338_symbol <= simple_obj_ref_174_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_complete/pipe_wack
          Xexit_336_symbol <= pipe_wack_338_symbol; -- transition branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_complete/$exit
          simple_obj_ref_174_complete_334_symbol <= Xexit_336_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_176/simple_obj_ref_174_complete
        Xexit_329_symbol <= assign_stmt_176_completed_x_x331_symbol; -- transition branch_block_stmt_13/assign_stmt_176/$exit
        assign_stmt_176_327_symbol <= Xexit_329_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_176
      assign_stmt_179_339: Block -- branch_block_stmt_13/assign_stmt_179 
        signal assign_stmt_179_339_start: Boolean;
        signal Xentry_340_symbol: Boolean;
        signal Xexit_341_symbol: Boolean;
        signal assign_stmt_179_active_x_x342_symbol : Boolean;
        signal assign_stmt_179_completed_x_x343_symbol : Boolean;
        signal simple_obj_ref_178_complete_344_symbol : Boolean;
        signal simple_obj_ref_177_trigger_x_x345_symbol : Boolean;
        signal simple_obj_ref_177_complete_346_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_179_339_start <= assign_stmt_179_x_xentry_x_xx_x34_symbol; -- control passed to block
        Xentry_340_symbol  <= assign_stmt_179_339_start; -- transition branch_block_stmt_13/assign_stmt_179/$entry
        assign_stmt_179_active_x_x342_symbol <= simple_obj_ref_178_complete_344_symbol; -- transition branch_block_stmt_13/assign_stmt_179/assign_stmt_179_active_
        assign_stmt_179_completed_x_x343_symbol <= simple_obj_ref_177_complete_346_symbol; -- transition branch_block_stmt_13/assign_stmt_179/assign_stmt_179_completed_
        simple_obj_ref_178_complete_344_symbol <= Xentry_340_symbol; -- transition branch_block_stmt_13/assign_stmt_179/simple_obj_ref_178_complete
        simple_obj_ref_177_trigger_x_x345_symbol <= assign_stmt_179_active_x_x342_symbol; -- transition branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_trigger_
        simple_obj_ref_177_complete_346: Block -- branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_complete 
          signal simple_obj_ref_177_complete_346_start: Boolean;
          signal Xentry_347_symbol: Boolean;
          signal Xexit_348_symbol: Boolean;
          signal pipe_wreq_349_symbol : Boolean;
          signal pipe_wack_350_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_177_complete_346_start <= simple_obj_ref_177_trigger_x_x345_symbol; -- control passed to block
          Xentry_347_symbol  <= simple_obj_ref_177_complete_346_start; -- transition branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_complete/$entry
          pipe_wreq_349_symbol <= Xentry_347_symbol; -- transition branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_complete/pipe_wreq
          simple_obj_ref_177_inst_req_0 <= pipe_wreq_349_symbol; -- link to DP
          pipe_wack_350_symbol <= simple_obj_ref_177_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_complete/pipe_wack
          Xexit_348_symbol <= pipe_wack_350_symbol; -- transition branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_complete/$exit
          simple_obj_ref_177_complete_346_symbol <= Xexit_348_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_179/simple_obj_ref_177_complete
        Xexit_341_symbol <= assign_stmt_179_completed_x_x343_symbol; -- transition branch_block_stmt_13/assign_stmt_179/$exit
        assign_stmt_179_339_symbol <= Xexit_341_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_179
      bb_0_bb_1_PhiReq_351: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_351_start: Boolean;
        signal Xentry_352_symbol: Boolean;
        signal Xexit_353_symbol: Boolean;
        signal phi_stmt_16_354_symbol : Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_351_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_352_symbol  <= bb_0_bb_1_PhiReq_351_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        phi_stmt_16_354: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16 
          signal phi_stmt_16_354_start: Boolean;
          signal Xentry_355_symbol: Boolean;
          signal Xexit_356_symbol: Boolean;
          signal type_cast_22_357_symbol : Boolean;
          signal phi_stmt_16_req_362_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_16_354_start <= Xentry_352_symbol; -- control passed to block
          Xentry_355_symbol  <= phi_stmt_16_354_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/$entry
          type_cast_22_357: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/type_cast_22 
            signal type_cast_22_357_start: Boolean;
            signal Xentry_358_symbol: Boolean;
            signal Xexit_359_symbol: Boolean;
            signal req_360_symbol : Boolean;
            signal ack_361_symbol : Boolean;
            -- 
          begin -- 
            type_cast_22_357_start <= Xentry_355_symbol; -- control passed to block
            Xentry_358_symbol  <= type_cast_22_357_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/type_cast_22/$entry
            req_360_symbol <= Xentry_358_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/type_cast_22/req
            ack_361_symbol <= req_360_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/type_cast_22/ack
            Xexit_359_symbol <= ack_361_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/type_cast_22/$exit
            type_cast_22_357_symbol <= Xexit_359_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/type_cast_22
          phi_stmt_16_req_362_symbol <= type_cast_22_357_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/phi_stmt_16_req
          phi_stmt_16_req_0 <= phi_stmt_16_req_362_symbol; -- link to DP
          Xexit_356_symbol <= phi_stmt_16_req_362_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16/$exit
          phi_stmt_16_354_symbol <= Xexit_356_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq/phi_stmt_16
        Xexit_353_symbol <= phi_stmt_16_354_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_351_symbol <= Xexit_353_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_5_bb_1_PhiReq_363: Block -- branch_block_stmt_13/bb_5_bb_1_PhiReq 
        signal bb_5_bb_1_PhiReq_363_start: Boolean;
        signal Xentry_364_symbol: Boolean;
        signal Xexit_365_symbol: Boolean;
        signal phi_stmt_16_366_symbol : Boolean;
        -- 
      begin -- 
        bb_5_bb_1_PhiReq_363_start <= bb_5_bb_1_36_symbol; -- control passed to block
        Xentry_364_symbol  <= bb_5_bb_1_PhiReq_363_start; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/$entry
        phi_stmt_16_366: Block -- branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16 
          signal phi_stmt_16_366_start: Boolean;
          signal Xentry_367_symbol: Boolean;
          signal Xexit_368_symbol: Boolean;
          signal type_cast_22_369_symbol : Boolean;
          signal phi_stmt_16_req_374_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_16_366_start <= Xentry_364_symbol; -- control passed to block
          Xentry_367_symbol  <= phi_stmt_16_366_start; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/$entry
          type_cast_22_369: Block -- branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/type_cast_22 
            signal type_cast_22_369_start: Boolean;
            signal Xentry_370_symbol: Boolean;
            signal Xexit_371_symbol: Boolean;
            signal req_372_symbol : Boolean;
            signal ack_373_symbol : Boolean;
            -- 
          begin -- 
            type_cast_22_369_start <= Xentry_367_symbol; -- control passed to block
            Xentry_370_symbol  <= type_cast_22_369_start; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/type_cast_22/$entry
            req_372_symbol <= Xentry_370_symbol; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/type_cast_22/req
            type_cast_22_inst_req_0 <= req_372_symbol; -- link to DP
            ack_373_symbol <= type_cast_22_inst_ack_0; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/type_cast_22/ack
            Xexit_371_symbol <= ack_373_symbol; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/type_cast_22/$exit
            type_cast_22_369_symbol <= Xexit_371_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/type_cast_22
          phi_stmt_16_req_374_symbol <= type_cast_22_369_symbol; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/phi_stmt_16_req
          phi_stmt_16_req_1 <= phi_stmt_16_req_374_symbol; -- link to DP
          Xexit_368_symbol <= phi_stmt_16_req_374_symbol; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16/$exit
          phi_stmt_16_366_symbol <= Xexit_368_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_5_bb_1_PhiReq/phi_stmt_16
        Xexit_365_symbol <= phi_stmt_16_366_symbol; -- transition branch_block_stmt_13/bb_5_bb_1_PhiReq/$exit
        bb_5_bb_1_PhiReq_363_symbol <= Xexit_365_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_5_bb_1_PhiReq
      merge_stmt_15_PhiReqMerge_375_symbol  <=  bb_0_bb_1_PhiReq_351_symbol or bb_5_bb_1_PhiReq_363_symbol; -- place branch_block_stmt_13/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_376: Block -- branch_block_stmt_13/merge_stmt_15_PhiAck 
        signal merge_stmt_15_PhiAck_376_start: Boolean;
        signal Xentry_377_symbol: Boolean;
        signal Xexit_378_symbol: Boolean;
        signal phi_stmt_16_ack_379_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_376_start <= merge_stmt_15_PhiReqMerge_375_symbol; -- control passed to block
        Xentry_377_symbol  <= merge_stmt_15_PhiAck_376_start; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$entry
        phi_stmt_16_ack_379_symbol <= phi_stmt_16_ack_0; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/phi_stmt_16_ack
        Xexit_378_symbol <= phi_stmt_16_ack_379_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_376_symbol <= Xexit_378_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_15_PhiAck
      merge_stmt_54_dead_link_380: Block -- branch_block_stmt_13/merge_stmt_54_dead_link 
        signal merge_stmt_54_dead_link_380_start: Boolean;
        signal Xentry_381_symbol: Boolean;
        signal Xexit_382_symbol: Boolean;
        signal dead_transition_383_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_54_dead_link_380_start <= merge_stmt_54_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_381_symbol  <= merge_stmt_54_dead_link_380_start; -- transition branch_block_stmt_13/merge_stmt_54_dead_link/$entry
        dead_transition_383_symbol <= false;
        Xexit_382_symbol <= dead_transition_383_symbol; -- transition branch_block_stmt_13/merge_stmt_54_dead_link/$exit
        merge_stmt_54_dead_link_380_symbol <= Xexit_382_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_54_dead_link
      bb_1_bb_2_PhiReq_384: Block -- branch_block_stmt_13/bb_1_bb_2_PhiReq 
        signal bb_1_bb_2_PhiReq_384_start: Boolean;
        signal Xentry_385_symbol: Boolean;
        signal Xexit_386_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_2_PhiReq_384_start <= bb_1_bb_2_116_symbol; -- control passed to block
        Xentry_385_symbol  <= bb_1_bb_2_PhiReq_384_start; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$entry
        Xexit_386_symbol <= Xentry_385_symbol; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$exit
        bb_1_bb_2_PhiReq_384_symbol <= Xexit_386_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_2_PhiReq
      merge_stmt_54_PhiReqMerge_387_symbol  <=  bb_1_bb_2_PhiReq_384_symbol; -- place branch_block_stmt_13/merge_stmt_54_PhiReqMerge (optimized away) 
      merge_stmt_54_PhiAck_388: Block -- branch_block_stmt_13/merge_stmt_54_PhiAck 
        signal merge_stmt_54_PhiAck_388_start: Boolean;
        signal Xentry_389_symbol: Boolean;
        signal Xexit_390_symbol: Boolean;
        signal dummy_391_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_54_PhiAck_388_start <= merge_stmt_54_PhiReqMerge_387_symbol; -- control passed to block
        Xentry_389_symbol  <= merge_stmt_54_PhiAck_388_start; -- transition branch_block_stmt_13/merge_stmt_54_PhiAck/$entry
        dummy_391_symbol <= Xentry_389_symbol; -- transition branch_block_stmt_13/merge_stmt_54_PhiAck/dummy
        Xexit_390_symbol <= dummy_391_symbol; -- transition branch_block_stmt_13/merge_stmt_54_PhiAck/$exit
        merge_stmt_54_PhiAck_388_symbol <= Xexit_390_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_54_PhiAck
      bb_1_bb_3_PhiReq_392: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq 
        signal bb_1_bb_3_PhiReq_392_start: Boolean;
        signal Xentry_393_symbol: Boolean;
        signal Xexit_394_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_3_PhiReq_392_start <= bb_1_bb_3_117_symbol; -- control passed to block
        Xentry_393_symbol  <= bb_1_bb_3_PhiReq_392_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/$entry
        Xexit_394_symbol <= Xentry_393_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/$exit
        bb_1_bb_3_PhiReq_392_symbol <= Xexit_394_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq
      merge_stmt_139_PhiReqMerge_395_symbol  <=  bb_1_bb_3_PhiReq_392_symbol; -- place branch_block_stmt_13/merge_stmt_139_PhiReqMerge (optimized away) 
      merge_stmt_139_PhiAck_396: Block -- branch_block_stmt_13/merge_stmt_139_PhiAck 
        signal merge_stmt_139_PhiAck_396_start: Boolean;
        signal Xentry_397_symbol: Boolean;
        signal Xexit_398_symbol: Boolean;
        signal dummy_399_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_139_PhiAck_396_start <= merge_stmt_139_PhiReqMerge_395_symbol; -- control passed to block
        Xentry_397_symbol  <= merge_stmt_139_PhiAck_396_start; -- transition branch_block_stmt_13/merge_stmt_139_PhiAck/$entry
        dummy_399_symbol <= Xentry_397_symbol; -- transition branch_block_stmt_13/merge_stmt_139_PhiAck/dummy
        Xexit_398_symbol <= dummy_399_symbol; -- transition branch_block_stmt_13/merge_stmt_139_PhiAck/$exit
        merge_stmt_139_PhiAck_396_symbol <= Xexit_398_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_139_PhiAck
      merge_stmt_152_dead_link_400: Block -- branch_block_stmt_13/merge_stmt_152_dead_link 
        signal merge_stmt_152_dead_link_400_start: Boolean;
        signal Xentry_401_symbol: Boolean;
        signal Xexit_402_symbol: Boolean;
        signal dead_transition_403_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_152_dead_link_400_start <= merge_stmt_152_x_xentry_x_xx_x28_symbol; -- control passed to block
        Xentry_401_symbol  <= merge_stmt_152_dead_link_400_start; -- transition branch_block_stmt_13/merge_stmt_152_dead_link/$entry
        dead_transition_403_symbol <= false;
        Xexit_402_symbol <= dead_transition_403_symbol; -- transition branch_block_stmt_13/merge_stmt_152_dead_link/$exit
        merge_stmt_152_dead_link_400_symbol <= Xexit_402_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_152_dead_link
      bb_3_bb_4_PhiReq_404: Block -- branch_block_stmt_13/bb_3_bb_4_PhiReq 
        signal bb_3_bb_4_PhiReq_404_start: Boolean;
        signal Xentry_405_symbol: Boolean;
        signal Xexit_406_symbol: Boolean;
        -- 
      begin -- 
        bb_3_bb_4_PhiReq_404_start <= bb_3_bb_4_326_symbol; -- control passed to block
        Xentry_405_symbol  <= bb_3_bb_4_PhiReq_404_start; -- transition branch_block_stmt_13/bb_3_bb_4_PhiReq/$entry
        Xexit_406_symbol <= Xentry_405_symbol; -- transition branch_block_stmt_13/bb_3_bb_4_PhiReq/$exit
        bb_3_bb_4_PhiReq_404_symbol <= Xexit_406_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_3_bb_4_PhiReq
      merge_stmt_152_PhiReqMerge_407_symbol  <=  bb_3_bb_4_PhiReq_404_symbol; -- place branch_block_stmt_13/merge_stmt_152_PhiReqMerge (optimized away) 
      merge_stmt_152_PhiAck_408: Block -- branch_block_stmt_13/merge_stmt_152_PhiAck 
        signal merge_stmt_152_PhiAck_408_start: Boolean;
        signal Xentry_409_symbol: Boolean;
        signal Xexit_410_symbol: Boolean;
        signal dummy_411_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_152_PhiAck_408_start <= merge_stmt_152_PhiReqMerge_407_symbol; -- control passed to block
        Xentry_409_symbol  <= merge_stmt_152_PhiAck_408_start; -- transition branch_block_stmt_13/merge_stmt_152_PhiAck/$entry
        dummy_411_symbol <= Xentry_409_symbol; -- transition branch_block_stmt_13/merge_stmt_152_PhiAck/dummy
        Xexit_410_symbol <= dummy_411_symbol; -- transition branch_block_stmt_13/merge_stmt_152_PhiAck/$exit
        merge_stmt_152_PhiAck_408_symbol <= Xexit_410_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_152_PhiAck
      bb_2_bb_5_PhiReq_412: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq 
        signal bb_2_bb_5_PhiReq_412_start: Boolean;
        signal Xentry_413_symbol: Boolean;
        signal Xexit_414_symbol: Boolean;
        signal phi_stmt_155_415_symbol : Boolean;
        signal phi_stmt_163_434_symbol : Boolean;
        -- 
      begin -- 
        bb_2_bb_5_PhiReq_412_start <= bb_2_bb_5_22_symbol; -- control passed to block
        Xentry_413_symbol  <= bb_2_bb_5_PhiReq_412_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/$entry
        phi_stmt_155_415: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155 
          signal phi_stmt_155_415_start: Boolean;
          signal Xentry_416_symbol: Boolean;
          signal Xexit_417_symbol: Boolean;
          signal type_cast_158_418_symbol : Boolean;
          signal type_cast_160_423_symbol : Boolean;
          signal type_cast_162_428_symbol : Boolean;
          signal phi_stmt_155_req_433_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_155_415_start <= Xentry_413_symbol; -- control passed to block
          Xentry_416_symbol  <= phi_stmt_155_415_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/$entry
          type_cast_158_418: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_158 
            signal type_cast_158_418_start: Boolean;
            signal Xentry_419_symbol: Boolean;
            signal Xexit_420_symbol: Boolean;
            signal req_421_symbol : Boolean;
            signal ack_422_symbol : Boolean;
            -- 
          begin -- 
            type_cast_158_418_start <= Xentry_416_symbol; -- control passed to block
            Xentry_419_symbol  <= type_cast_158_418_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_158/$entry
            req_421_symbol <= Xentry_419_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_158/req
            type_cast_158_inst_req_0 <= req_421_symbol; -- link to DP
            ack_422_symbol <= type_cast_158_inst_ack_0; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_158/ack
            Xexit_420_symbol <= ack_422_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_158/$exit
            type_cast_158_418_symbol <= Xexit_420_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_158
          type_cast_160_423: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_160 
            signal type_cast_160_423_start: Boolean;
            signal Xentry_424_symbol: Boolean;
            signal Xexit_425_symbol: Boolean;
            signal req_426_symbol : Boolean;
            signal ack_427_symbol : Boolean;
            -- 
          begin -- 
            type_cast_160_423_start <= type_cast_158_418_symbol; -- control passed to block
            Xentry_424_symbol  <= type_cast_160_423_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_160/$entry
            req_426_symbol <= Xentry_424_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_160/req
            ack_427_symbol <= req_426_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_160/ack
            Xexit_425_symbol <= ack_427_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_160/$exit
            type_cast_160_423_symbol <= Xexit_425_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_160
          type_cast_162_428: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_162 
            signal type_cast_162_428_start: Boolean;
            signal Xentry_429_symbol: Boolean;
            signal Xexit_430_symbol: Boolean;
            signal req_431_symbol : Boolean;
            signal ack_432_symbol : Boolean;
            -- 
          begin -- 
            type_cast_162_428_start <= type_cast_160_423_symbol; -- control passed to block
            Xentry_429_symbol  <= type_cast_162_428_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_162/$entry
            req_431_symbol <= Xentry_429_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_162/req
            ack_432_symbol <= req_431_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_162/ack
            Xexit_430_symbol <= ack_432_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_162/$exit
            type_cast_162_428_symbol <= Xexit_430_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/type_cast_162
          phi_stmt_155_req_433_symbol <= type_cast_162_428_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/phi_stmt_155_req
          phi_stmt_155_req_0 <= phi_stmt_155_req_433_symbol; -- link to DP
          Xexit_417_symbol <= phi_stmt_155_req_433_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155/$exit
          phi_stmt_155_415_symbol <= Xexit_417_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_155
        phi_stmt_163_434: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163 
          signal phi_stmt_163_434_start: Boolean;
          signal Xentry_435_symbol: Boolean;
          signal Xexit_436_symbol: Boolean;
          signal type_cast_172_437_symbol : Boolean;
          signal phi_stmt_163_req_442_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_163_434_start <= Xentry_413_symbol; -- control passed to block
          Xentry_435_symbol  <= phi_stmt_163_434_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/$entry
          type_cast_172_437: Block -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/type_cast_172 
            signal type_cast_172_437_start: Boolean;
            signal Xentry_438_symbol: Boolean;
            signal Xexit_439_symbol: Boolean;
            signal req_440_symbol : Boolean;
            signal ack_441_symbol : Boolean;
            -- 
          begin -- 
            type_cast_172_437_start <= Xentry_435_symbol; -- control passed to block
            Xentry_438_symbol  <= type_cast_172_437_start; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/type_cast_172/$entry
            req_440_symbol <= Xentry_438_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/type_cast_172/req
            ack_441_symbol <= req_440_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/type_cast_172/ack
            Xexit_439_symbol <= ack_441_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/type_cast_172/$exit
            type_cast_172_437_symbol <= Xexit_439_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/type_cast_172
          phi_stmt_163_req_442_symbol <= type_cast_172_437_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/phi_stmt_163_req
          phi_stmt_163_req_0 <= phi_stmt_163_req_442_symbol; -- link to DP
          Xexit_436_symbol <= phi_stmt_163_req_442_symbol; -- transition branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163/$exit
          phi_stmt_163_434_symbol <= Xexit_436_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq/phi_stmt_163
        Xexit_414_block : Block -- non-trivial join transition branch_block_stmt_13/bb_2_bb_5_PhiReq/$exit 
          signal Xexit_414_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_414_predecessors(0) <= phi_stmt_155_415_symbol;
          Xexit_414_predecessors(1) <= phi_stmt_163_434_symbol;
          Xexit_414_join: join -- 
            port map( -- 
              preds => Xexit_414_predecessors,
              symbol_out => Xexit_414_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/bb_2_bb_5_PhiReq/$exit
        bb_2_bb_5_PhiReq_412_symbol <= Xexit_414_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_2_bb_5_PhiReq
      bb_3_bb_5_PhiReq_443: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq 
        signal bb_3_bb_5_PhiReq_443_start: Boolean;
        signal Xentry_444_symbol: Boolean;
        signal Xexit_445_symbol: Boolean;
        signal phi_stmt_155_446_symbol : Boolean;
        signal phi_stmt_163_465_symbol : Boolean;
        -- 
      begin -- 
        bb_3_bb_5_PhiReq_443_start <= bb_3_bb_5_325_symbol; -- control passed to block
        Xentry_444_symbol  <= bb_3_bb_5_PhiReq_443_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/$entry
        phi_stmt_155_446: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155 
          signal phi_stmt_155_446_start: Boolean;
          signal Xentry_447_symbol: Boolean;
          signal Xexit_448_symbol: Boolean;
          signal type_cast_158_449_symbol : Boolean;
          signal type_cast_160_454_symbol : Boolean;
          signal type_cast_162_459_symbol : Boolean;
          signal phi_stmt_155_req_464_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_155_446_start <= Xentry_444_symbol; -- control passed to block
          Xentry_447_symbol  <= phi_stmt_155_446_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/$entry
          type_cast_158_449: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_158 
            signal type_cast_158_449_start: Boolean;
            signal Xentry_450_symbol: Boolean;
            signal Xexit_451_symbol: Boolean;
            signal req_452_symbol : Boolean;
            signal ack_453_symbol : Boolean;
            -- 
          begin -- 
            type_cast_158_449_start <= Xentry_447_symbol; -- control passed to block
            Xentry_450_symbol  <= type_cast_158_449_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_158/$entry
            req_452_symbol <= Xentry_450_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_158/req
            ack_453_symbol <= req_452_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_158/ack
            Xexit_451_symbol <= ack_453_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_158/$exit
            type_cast_158_449_symbol <= Xexit_451_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_158
          type_cast_160_454: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_160 
            signal type_cast_160_454_start: Boolean;
            signal Xentry_455_symbol: Boolean;
            signal Xexit_456_symbol: Boolean;
            signal req_457_symbol : Boolean;
            signal ack_458_symbol : Boolean;
            -- 
          begin -- 
            type_cast_160_454_start <= type_cast_158_449_symbol; -- control passed to block
            Xentry_455_symbol  <= type_cast_160_454_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_160/$entry
            req_457_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_160/req
            ack_458_symbol <= req_457_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_160/ack
            Xexit_456_symbol <= ack_458_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_160/$exit
            type_cast_160_454_symbol <= Xexit_456_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_160
          type_cast_162_459: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_162 
            signal type_cast_162_459_start: Boolean;
            signal Xentry_460_symbol: Boolean;
            signal Xexit_461_symbol: Boolean;
            signal req_462_symbol : Boolean;
            signal ack_463_symbol : Boolean;
            -- 
          begin -- 
            type_cast_162_459_start <= type_cast_160_454_symbol; -- control passed to block
            Xentry_460_symbol  <= type_cast_162_459_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_162/$entry
            req_462_symbol <= Xentry_460_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_162/req
            type_cast_162_inst_req_0 <= req_462_symbol; -- link to DP
            ack_463_symbol <= type_cast_162_inst_ack_0; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_162/ack
            Xexit_461_symbol <= ack_463_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_162/$exit
            type_cast_162_459_symbol <= Xexit_461_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/type_cast_162
          phi_stmt_155_req_464_symbol <= type_cast_162_459_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/phi_stmt_155_req
          phi_stmt_155_req_2 <= phi_stmt_155_req_464_symbol; -- link to DP
          Xexit_448_symbol <= phi_stmt_155_req_464_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155/$exit
          phi_stmt_155_446_symbol <= Xexit_448_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_155
        phi_stmt_163_465: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163 
          signal phi_stmt_163_465_start: Boolean;
          signal Xentry_466_symbol: Boolean;
          signal Xexit_467_symbol: Boolean;
          signal type_cast_172_468_symbol : Boolean;
          signal phi_stmt_163_req_473_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_163_465_start <= Xentry_444_symbol; -- control passed to block
          Xentry_466_symbol  <= phi_stmt_163_465_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/$entry
          type_cast_172_468: Block -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/type_cast_172 
            signal type_cast_172_468_start: Boolean;
            signal Xentry_469_symbol: Boolean;
            signal Xexit_470_symbol: Boolean;
            signal req_471_symbol : Boolean;
            signal ack_472_symbol : Boolean;
            -- 
          begin -- 
            type_cast_172_468_start <= Xentry_466_symbol; -- control passed to block
            Xentry_469_symbol  <= type_cast_172_468_start; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/type_cast_172/$entry
            req_471_symbol <= Xentry_469_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/type_cast_172/req
            type_cast_172_inst_req_0 <= req_471_symbol; -- link to DP
            ack_472_symbol <= type_cast_172_inst_ack_0; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/type_cast_172/ack
            Xexit_470_symbol <= ack_472_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/type_cast_172/$exit
            type_cast_172_468_symbol <= Xexit_470_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/type_cast_172
          phi_stmt_163_req_473_symbol <= type_cast_172_468_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/phi_stmt_163_req
          phi_stmt_163_req_2 <= phi_stmt_163_req_473_symbol; -- link to DP
          Xexit_467_symbol <= phi_stmt_163_req_473_symbol; -- transition branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163/$exit
          phi_stmt_163_465_symbol <= Xexit_467_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq/phi_stmt_163
        Xexit_445_block : Block -- non-trivial join transition branch_block_stmt_13/bb_3_bb_5_PhiReq/$exit 
          signal Xexit_445_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_445_predecessors(0) <= phi_stmt_155_446_symbol;
          Xexit_445_predecessors(1) <= phi_stmt_163_465_symbol;
          Xexit_445_join: join -- 
            port map( -- 
              preds => Xexit_445_predecessors,
              symbol_out => Xexit_445_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/bb_3_bb_5_PhiReq/$exit
        bb_3_bb_5_PhiReq_443_symbol <= Xexit_445_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_3_bb_5_PhiReq
      bb_4_bb_5_PhiReq_474: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq 
        signal bb_4_bb_5_PhiReq_474_start: Boolean;
        signal Xentry_475_symbol: Boolean;
        signal Xexit_476_symbol: Boolean;
        signal phi_stmt_155_477_symbol : Boolean;
        signal phi_stmt_163_496_symbol : Boolean;
        -- 
      begin -- 
        bb_4_bb_5_PhiReq_474_start <= bb_4_bb_5_30_symbol; -- control passed to block
        Xentry_475_symbol  <= bb_4_bb_5_PhiReq_474_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/$entry
        phi_stmt_155_477: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155 
          signal phi_stmt_155_477_start: Boolean;
          signal Xentry_478_symbol: Boolean;
          signal Xexit_479_symbol: Boolean;
          signal type_cast_158_480_symbol : Boolean;
          signal type_cast_160_485_symbol : Boolean;
          signal type_cast_162_490_symbol : Boolean;
          signal phi_stmt_155_req_495_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_155_477_start <= Xentry_475_symbol; -- control passed to block
          Xentry_478_symbol  <= phi_stmt_155_477_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/$entry
          type_cast_158_480: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_158 
            signal type_cast_158_480_start: Boolean;
            signal Xentry_481_symbol: Boolean;
            signal Xexit_482_symbol: Boolean;
            signal req_483_symbol : Boolean;
            signal ack_484_symbol : Boolean;
            -- 
          begin -- 
            type_cast_158_480_start <= Xentry_478_symbol; -- control passed to block
            Xentry_481_symbol  <= type_cast_158_480_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_158/$entry
            req_483_symbol <= Xentry_481_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_158/req
            ack_484_symbol <= req_483_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_158/ack
            Xexit_482_symbol <= ack_484_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_158/$exit
            type_cast_158_480_symbol <= Xexit_482_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_158
          type_cast_160_485: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_160 
            signal type_cast_160_485_start: Boolean;
            signal Xentry_486_symbol: Boolean;
            signal Xexit_487_symbol: Boolean;
            signal req_488_symbol : Boolean;
            signal ack_489_symbol : Boolean;
            -- 
          begin -- 
            type_cast_160_485_start <= type_cast_158_480_symbol; -- control passed to block
            Xentry_486_symbol  <= type_cast_160_485_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_160/$entry
            req_488_symbol <= Xentry_486_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_160/req
            type_cast_160_inst_req_0 <= req_488_symbol; -- link to DP
            ack_489_symbol <= type_cast_160_inst_ack_0; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_160/ack
            Xexit_487_symbol <= ack_489_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_160/$exit
            type_cast_160_485_symbol <= Xexit_487_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_160
          type_cast_162_490: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_162 
            signal type_cast_162_490_start: Boolean;
            signal Xentry_491_symbol: Boolean;
            signal Xexit_492_symbol: Boolean;
            signal req_493_symbol : Boolean;
            signal ack_494_symbol : Boolean;
            -- 
          begin -- 
            type_cast_162_490_start <= type_cast_160_485_symbol; -- control passed to block
            Xentry_491_symbol  <= type_cast_162_490_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_162/$entry
            req_493_symbol <= Xentry_491_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_162/req
            ack_494_symbol <= req_493_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_162/ack
            Xexit_492_symbol <= ack_494_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_162/$exit
            type_cast_162_490_symbol <= Xexit_492_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/type_cast_162
          phi_stmt_155_req_495_symbol <= type_cast_162_490_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/phi_stmt_155_req
          phi_stmt_155_req_1 <= phi_stmt_155_req_495_symbol; -- link to DP
          Xexit_479_symbol <= phi_stmt_155_req_495_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155/$exit
          phi_stmt_155_477_symbol <= Xexit_479_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_155
        phi_stmt_163_496: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163 
          signal phi_stmt_163_496_start: Boolean;
          signal Xentry_497_symbol: Boolean;
          signal Xexit_498_symbol: Boolean;
          signal type_cast_172_499_symbol : Boolean;
          signal phi_stmt_163_req_504_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_163_496_start <= Xentry_475_symbol; -- control passed to block
          Xentry_497_symbol  <= phi_stmt_163_496_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/$entry
          type_cast_172_499: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/type_cast_172 
            signal type_cast_172_499_start: Boolean;
            signal Xentry_500_symbol: Boolean;
            signal Xexit_501_symbol: Boolean;
            signal req_502_symbol : Boolean;
            signal ack_503_symbol : Boolean;
            -- 
          begin -- 
            type_cast_172_499_start <= Xentry_497_symbol; -- control passed to block
            Xentry_500_symbol  <= type_cast_172_499_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/type_cast_172/$entry
            req_502_symbol <= Xentry_500_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/type_cast_172/req
            ack_503_symbol <= req_502_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/type_cast_172/ack
            Xexit_501_symbol <= ack_503_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/type_cast_172/$exit
            type_cast_172_499_symbol <= Xexit_501_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/type_cast_172
          phi_stmt_163_req_504_symbol <= type_cast_172_499_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/phi_stmt_163_req
          phi_stmt_163_req_1 <= phi_stmt_163_req_504_symbol; -- link to DP
          Xexit_498_symbol <= phi_stmt_163_req_504_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163/$exit
          phi_stmt_163_496_symbol <= Xexit_498_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq/phi_stmt_163
        Xexit_476_block : Block -- non-trivial join transition branch_block_stmt_13/bb_4_bb_5_PhiReq/$exit 
          signal Xexit_476_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_476_predecessors(0) <= phi_stmt_155_477_symbol;
          Xexit_476_predecessors(1) <= phi_stmt_163_496_symbol;
          Xexit_476_join: join -- 
            port map( -- 
              preds => Xexit_476_predecessors,
              symbol_out => Xexit_476_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/bb_4_bb_5_PhiReq/$exit
        bb_4_bb_5_PhiReq_474_symbol <= Xexit_476_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq
      merge_stmt_154_PhiReqMerge_505_symbol  <=  bb_2_bb_5_PhiReq_412_symbol or bb_3_bb_5_PhiReq_443_symbol or bb_4_bb_5_PhiReq_474_symbol; -- place branch_block_stmt_13/merge_stmt_154_PhiReqMerge (optimized away) 
      merge_stmt_154_PhiAck_506: Block -- branch_block_stmt_13/merge_stmt_154_PhiAck 
        signal merge_stmt_154_PhiAck_506_start: Boolean;
        signal Xentry_507_symbol: Boolean;
        signal Xexit_508_symbol: Boolean;
        signal phi_stmt_155_ack_509_symbol : Boolean;
        signal phi_stmt_163_ack_510_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_154_PhiAck_506_start <= merge_stmt_154_PhiReqMerge_505_symbol; -- control passed to block
        Xentry_507_symbol  <= merge_stmt_154_PhiAck_506_start; -- transition branch_block_stmt_13/merge_stmt_154_PhiAck/$entry
        phi_stmt_155_ack_509_symbol <= phi_stmt_155_ack_0; -- transition branch_block_stmt_13/merge_stmt_154_PhiAck/phi_stmt_155_ack
        phi_stmt_163_ack_510_symbol <= phi_stmt_163_ack_0; -- transition branch_block_stmt_13/merge_stmt_154_PhiAck/phi_stmt_163_ack
        Xexit_508_block : Block -- non-trivial join transition branch_block_stmt_13/merge_stmt_154_PhiAck/$exit 
          signal Xexit_508_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_508_predecessors(0) <= phi_stmt_155_ack_509_symbol;
          Xexit_508_predecessors(1) <= phi_stmt_163_ack_510_symbol;
          Xexit_508_join: join -- 
            port map( -- 
              preds => Xexit_508_predecessors,
              symbol_out => Xexit_508_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/merge_stmt_154_PhiAck/$exit
        merge_stmt_154_PhiAck_506_symbol <= Xexit_508_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_154_PhiAck
      Xexit_5_symbol <= branch_block_stmt_13_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_13/$exit
      branch_block_stmt_13_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_13
    Xexit_2_symbol <= branch_block_stmt_13_3_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal curr_statex_x0_163 : std_logic_vector(7 downto 0);
    signal curr_statex_x1_16 : std_logic_vector(7 downto 0);
    signal iNsTr_10_71 : std_logic_vector(31 downto 0);
    signal iNsTr_11_77 : std_logic_vector(31 downto 0);
    signal iNsTr_12_83 : std_logic_vector(31 downto 0);
    signal iNsTr_13_92 : std_logic_vector(0 downto 0);
    signal iNsTr_14_98 : std_logic_vector(31 downto 0);
    signal iNsTr_15_104 : std_logic_vector(31 downto 0);
    signal iNsTr_16_110 : std_logic_vector(31 downto 0);
    signal iNsTr_17_116 : std_logic_vector(31 downto 0);
    signal iNsTr_18_120 : std_logic_vector(63 downto 0);
    signal iNsTr_19_126 : std_logic_vector(63 downto 0);
    signal iNsTr_20_132 : std_logic_vector(63 downto 0);
    signal iNsTr_21_137 : std_logic_vector(63 downto 0);
    signal iNsTr_23_145 : std_logic_vector(0 downto 0);
    signal iNsTr_2_26 : std_logic_vector(7 downto 0);
    signal iNsTr_4_29 : std_logic_vector(63 downto 0);
    signal iNsTr_5_36 : std_logic_vector(0 downto 0);
    signal iNsTr_6_42 : std_logic_vector(0 downto 0);
    signal iNsTr_8_60 : std_logic_vector(63 downto 0);
    signal iNsTr_9_66 : std_logic_vector(63 downto 0);
    signal indatax_x0_155 : std_logic_vector(63 downto 0);
    signal orx_xcond_47 : std_logic_vector(0 downto 0);
    signal type_cast_102_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_108_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_124_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_130_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_143_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_158_wire : std_logic_vector(63 downto 0);
    signal type_cast_160_wire : std_logic_vector(63 downto 0);
    signal type_cast_162_wire : std_logic_vector(63 downto 0);
    signal type_cast_167_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_170_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_172_wire : std_logic_vector(7 downto 0);
    signal type_cast_20_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_22_wire : std_logic_vector(7 downto 0);
    signal type_cast_33_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_40_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_58_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_64_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_75_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_80_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_87_wire : std_logic_vector(63 downto 0);
    signal type_cast_90_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_96_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    type_cast_102_wire_constant <= "00000000000000000111111111111111";
    type_cast_108_wire_constant <= "00000000000000000000000000000001";
    type_cast_124_wire_constant <= "0000000000000000111111111111111111111111111111111111111111111111";
    type_cast_130_wire_constant <= "0000000000000000000000000000000000000000000000000000000000110000";
    type_cast_143_wire_constant <= "00000000";
    type_cast_167_wire_constant <= "00000001";
    type_cast_170_wire_constant <= "00000000";
    type_cast_20_wire_constant <= "00000000";
    type_cast_33_wire_constant <= "00000000";
    type_cast_40_wire_constant <= "11111111";
    type_cast_58_wire_constant <= "0000000000000000000000000000000000000000000000010000000000000000";
    type_cast_64_wire_constant <= "0000000000000000000000000000000000000000000000000000000000010000";
    type_cast_75_wire_constant <= "00000000000000001111111111111111";
    type_cast_80_wire_constant <= "00000000000000000000000000000001";
    type_cast_90_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000000";
    type_cast_96_wire_constant <= "00000000000000000000000000000001";
    phi_stmt_155: Block -- phi operator 
      signal idata: std_logic_vector(191 downto 0);
      signal req: BooleanArray(2 downto 0);
      --
    begin -- 
      idata <= type_cast_158_wire & type_cast_160_wire & type_cast_162_wire;
      req <= phi_stmt_155_req_0 & phi_stmt_155_req_1 & phi_stmt_155_req_2;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 3,
          data_width => 64) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_155_ack_0,
          idata => idata,
          odata => indatax_x0_155,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_155
    phi_stmt_16: Block -- phi operator 
      signal idata: std_logic_vector(15 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_20_wire_constant & type_cast_22_wire;
      req <= phi_stmt_16_req_0 & phi_stmt_16_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_16_ack_0,
          idata => idata,
          odata => curr_statex_x1_16,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_16
    phi_stmt_163: Block -- phi operator 
      signal idata: std_logic_vector(23 downto 0);
      signal req: BooleanArray(2 downto 0);
      --
    begin -- 
      idata <= type_cast_167_wire_constant & type_cast_170_wire_constant & type_cast_172_wire;
      req <= phi_stmt_163_req_0 & phi_stmt_163_req_1 & phi_stmt_163_req_2;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 3,
          data_width => 8) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_163_ack_0,
          idata => idata,
          odata => curr_statex_x0_163,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_163
    ternary_115_inst: SelectBase generic map(data_width => 32) -- 
      port map( x => iNsTr_15_104, y => iNsTr_16_110, sel => iNsTr_13_92, z => iNsTr_17_116, req => ternary_115_inst_req_0, ack => ternary_115_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_119_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 64, flow_through => false ) 
      port map( din => iNsTr_17_116, dout => iNsTr_18_120, req => type_cast_119_inst_req_0, ack => type_cast_119_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_158_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_21_137, dout => type_cast_158_wire, req => type_cast_158_inst_req_0, ack => type_cast_158_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_160_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_4_29, dout => type_cast_160_wire, req => type_cast_160_inst_req_0, ack => type_cast_160_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_162_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_4_29, dout => type_cast_162_wire, req => type_cast_162_inst_req_0, ack => type_cast_162_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_172_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 8, flow_through => true ) 
      port map( din => curr_statex_x1_16, dout => type_cast_172_wire, req => type_cast_172_inst_req_0, ack => type_cast_172_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_22_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 8, flow_through => true ) 
      port map( din => curr_statex_x0_163, dout => type_cast_22_wire, req => type_cast_22_inst_req_0, ack => type_cast_22_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_70_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_9_66, dout => iNsTr_10_71, req => type_cast_70_inst_req_0, ack => type_cast_70_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_87_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_8_60, dout => type_cast_87_wire, req => type_cast_87_inst_req_0, ack => type_cast_87_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_146_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_23_145;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_146_branch_req_0,
          ack0 => if_stmt_146_branch_ack_0,
          ack1 => if_stmt_146_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_48_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= orx_xcond_47;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_48_branch_req_0,
          ack0 => if_stmt_48_branch_ack_0,
          ack1 => if_stmt_48_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_103_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_14_98;
      iNsTr_15_104 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000111111111111111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_103_inst_req_0,
          ackL => binary_103_inst_ack_0,
          reqR => binary_103_inst_req_1,
          ackR => binary_103_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_109_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_83;
      iNsTr_16_110 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntSHL",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_109_inst_req_0,
          ackL => binary_109_inst_ack_0,
          reqR => binary_109_inst_req_1,
          ackR => binary_109_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_125_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_29;
      iNsTr_19_126 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000111111111111111111111111111111111111111111111111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_125_inst_req_0,
          ackL => binary_125_inst_ack_0,
          reqR => binary_125_inst_req_1,
          ackR => binary_125_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_131_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_18_120;
      iNsTr_20_132 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntSHL",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000000000000000000000000000000000000000000000110000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_131_inst_req_0,
          ackL => binary_131_inst_ack_0,
          reqR => binary_131_inst_req_1,
          ackR => binary_131_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_136_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_20_132 & iNsTr_19_126;
      iNsTr_21_137 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 64, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_136_inst_req_0,
          ackL => binary_136_inst_ack_0,
          reqR => binary_136_inst_req_1,
          ackR => binary_136_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_34_inst binary_144_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(15 downto 0);
      signal data_out: std_logic_vector(1 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= curr_statex_x1_16 & iNsTr_2_26;
      iNsTr_5_36 <= data_out(1 downto 1);
      iNsTr_23_145 <= data_out(0 downto 0);
      reqL(1) <= binary_34_inst_req_0;
      reqL(0) <= binary_144_inst_req_0;
      binary_34_inst_ack_0 <= ackL(1);
      binary_144_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_34_inst_req_1;
      reqR(0) <= binary_144_inst_req_1;
      binary_34_inst_ack_1 <= ackR(1);
      binary_144_inst_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000000",
          use_constant  => true,
          zero_delay => false, 
          no_arbitration => true,
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_41_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_26;
      iNsTr_6_42 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "11111111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_41_inst_req_0,
          ackL => binary_41_inst_ack_0,
          reqR => binary_41_inst_req_1,
          ackR => binary_41_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_46_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_36 & iNsTr_6_42;
      orx_xcond_47 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 1,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 1, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_46_inst_req_0,
          ackL => binary_46_inst_ack_0,
          reqR => binary_46_inst_req_1,
          ackR => binary_46_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_59_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_29;
      iNsTr_8_60 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000000000000000000000000000000000010000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_59_inst_req_0,
          ackL => binary_59_inst_ack_0,
          reqR => binary_59_inst_req_1,
          ackR => binary_59_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_65_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_29;
      iNsTr_9_66 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000000000000000000000000000000000000000000000010000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_65_inst_req_0,
          ackL => binary_65_inst_ack_0,
          reqR => binary_65_inst_req_1,
          ackR => binary_65_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_76_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_10_71;
      iNsTr_11_77 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000001111111111111111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_76_inst_req_0,
          ackL => binary_76_inst_ack_0,
          reqR => binary_76_inst_req_1,
          ackR => binary_76_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_82_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_80_wire_constant & iNsTr_11_77;
      iNsTr_12_83 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntSHL",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 32, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_82_inst_req_0,
          ackL => binary_82_inst_ack_0,
          reqR => binary_82_inst_req_1,
          ackR => binary_82_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared split operator group (12) : binary_91_inst 
    SplitOperatorGroup12: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_87_wire;
      iNsTr_13_92 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntNe",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000000000000000000000000000000000000000000000000000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_91_inst_req_0,
          ackL => binary_91_inst_ack_0,
          reqR => binary_91_inst_req_1,
          ackR => binary_91_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 12
    -- shared split operator group (13) : binary_97_inst 
    SplitOperatorGroup13: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_83;
      iNsTr_14_98 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_97_inst_req_0,
          ackL => binary_97_inst_ack_0,
          reqR => binary_97_inst_req_1,
          ackR => binary_97_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 13
    -- shared inport operator group (0) : simple_obj_ref_25_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_25_inst_req_0;
      simple_obj_ref_25_inst_ack_0 <= ack(0);
      iNsTr_2_26 <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => in_ctrl_pipe_read_req(0),
          oack => in_ctrl_pipe_read_ack(0),
          odata => in_ctrl_pipe_read_data(7 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : simple_obj_ref_28_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_28_inst_req_0;
      simple_obj_ref_28_inst_ack_0 <= ack(0);
      iNsTr_4_29 <= data_out(63 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 64,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => in_data_pipe_read_req(0),
          oack => in_data_pipe_read_ack(0),
          odata => in_data_pipe_read_data(63 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : simple_obj_ref_174_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_174_inst_req_0;
      simple_obj_ref_174_inst_ack_0 <= ack(0);
      data_in <= iNsTr_2_26;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => out_ctrl_pipe_write_req(0),
          oack => out_ctrl_pipe_write_ack(0),
          odata => out_ctrl_pipe_write_data(7 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : simple_obj_ref_177_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_177_inst_req_0;
      simple_obj_ref_177_inst_ack_0 <= ack(0);
      data_in <= indatax_x0_155;
      outport: OutputPort -- 
        generic map ( data_width => 64,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => out_data_pipe_write_req(0),
          oack => out_data_pipe_write_ack(0),
          odata => out_data_pipe_write_data(63 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- 
  end Block; -- data_path
  -- 
end Default;
library ieee;
use ieee.std_logic_1164.all;
library ahir;
use ahir.memory_subsystem_package.all;
use ahir.types.all;
use ahir.subprograms.all;
use ahir.components.all;
use ahir.basecomponents.all;
use ahir.operatorpackage.all;
use ahir.utilities.all;
library work;
use work.vc_system_package.all;
entity ahir_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    in_ctrl_pipe_write_data: in std_logic_vector(7 downto 0);
    in_ctrl_pipe_write_req : in std_logic_vector(0 downto 0);
    in_ctrl_pipe_write_ack : out std_logic_vector(0 downto 0);
    in_data_pipe_write_data: in std_logic_vector(63 downto 0);
    in_data_pipe_write_req : in std_logic_vector(0 downto 0);
    in_data_pipe_write_ack : out std_logic_vector(0 downto 0);
    out_ctrl_pipe_read_data: out std_logic_vector(7 downto 0);
    out_ctrl_pipe_read_req : in std_logic_vector(0 downto 0);
    out_ctrl_pipe_read_ack : out std_logic_vector(0 downto 0);
    out_data_pipe_read_data: out std_logic_vector(63 downto 0);
    out_data_pipe_read_req : in std_logic_vector(0 downto 0);
    out_data_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of ahir_system is -- system-architecture 
  -- declarations related to module output_port_lookup
  component output_port_lookup is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module output_port_lookup
  signal output_port_lookup_tag_in    : std_logic_vector(0 downto 0);
  signal output_port_lookup_tag_out   : std_logic_vector(0 downto 0);
  signal output_port_lookup_start : std_logic;
  signal output_port_lookup_fin   : std_logic;
  -- aggregate signals for read from pipe in_ctrl
  signal in_ctrl_pipe_read_data: std_logic_vector(7 downto 0);
  signal in_ctrl_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_ctrl_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe in_data
  signal in_data_pipe_read_data: std_logic_vector(63 downto 0);
  signal in_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal in_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_ctrl
  signal out_ctrl_pipe_write_data: std_logic_vector(7 downto 0);
  signal out_ctrl_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_ctrl_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe out_data
  signal out_data_pipe_write_data: std_logic_vector(63 downto 0);
  signal out_data_pipe_write_req: std_logic_vector(0 downto 0);
  signal out_data_pipe_write_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module output_port_lookup
  output_port_lookup_instance:output_port_lookup-- 
    port map(-- 
      start => output_port_lookup_start,
      fin => output_port_lookup_fin,
      clk => clk,
      reset => reset,
      in_ctrl_pipe_read_req => in_ctrl_pipe_read_req(0 downto 0),
      in_ctrl_pipe_read_ack => in_ctrl_pipe_read_ack(0 downto 0),
      in_ctrl_pipe_read_data => in_ctrl_pipe_read_data(7 downto 0),
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(63 downto 0),
      out_ctrl_pipe_write_req => out_ctrl_pipe_write_req(0 downto 0),
      out_ctrl_pipe_write_ack => out_ctrl_pipe_write_ack(0 downto 0),
      out_ctrl_pipe_write_data => out_ctrl_pipe_write_data(7 downto 0),
      out_data_pipe_write_req => out_data_pipe_write_req(0 downto 0),
      out_data_pipe_write_ack => out_data_pipe_write_ack(0 downto 0),
      out_data_pipe_write_data => out_data_pipe_write_data(63 downto 0),
      tag_in => output_port_lookup_tag_in,
      tag_out => output_port_lookup_tag_out-- 
    ); -- 
  -- module will be run forever 
  output_port_lookup_tag_in <= (others => '0');
  output_port_lookup_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => output_port_lookup_start, fin => output_port_lookup_fin);
  in_ctrl_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => in_ctrl_pipe_read_req,
      read_ack => in_ctrl_pipe_read_ack,
      read_data => in_ctrl_pipe_read_data,
      write_req => in_ctrl_pipe_write_req,
      write_ack => in_ctrl_pipe_write_ack,
      write_data => in_ctrl_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  in_data_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 64,
      depth => 1 --
    )
    port map( -- 
      read_req => in_data_pipe_read_req,
      read_ack => in_data_pipe_read_ack,
      read_data => in_data_pipe_read_data,
      write_req => in_data_pipe_write_req,
      write_ack => in_data_pipe_write_ack,
      write_data => in_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_ctrl_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => out_ctrl_pipe_read_req,
      read_ack => out_ctrl_pipe_read_ack,
      read_data => out_ctrl_pipe_read_data,
      write_req => out_ctrl_pipe_write_req,
      write_ack => out_ctrl_pipe_write_ack,
      write_data => out_ctrl_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  out_data_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 64,
      depth => 1 --
    )
    port map( -- 
      read_req => out_data_pipe_read_req,
      read_ack => out_data_pipe_read_ack,
      read_data => out_data_pipe_read_data,
      write_req => out_data_pipe_write_req,
      write_ack => out_data_pipe_write_ack,
      write_data => out_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  -- 
end Default;
