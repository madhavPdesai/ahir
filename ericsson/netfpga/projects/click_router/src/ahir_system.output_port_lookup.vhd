-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant xx_xstr1_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr2_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr3_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr_base_address : std_logic_vector(6 downto 0) := "0000000";
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
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
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
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity output_port_lookup;
architecture Default of output_port_lookup is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal output_port_lookup_CP_0_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_24_inst_req_0 : boolean;
  signal simple_obj_ref_24_inst_ack_0 : boolean;
  signal simple_obj_ref_33_inst_req_0 : boolean;
  signal simple_obj_ref_33_inst_ack_0 : boolean;
  signal binary_39_inst_req_0 : boolean;
  signal binary_39_inst_ack_0 : boolean;
  signal binary_39_inst_req_1 : boolean;
  signal binary_39_inst_ack_1 : boolean;
  signal if_stmt_42_branch_req_0 : boolean;
  signal if_stmt_42_branch_ack_1 : boolean;
  signal if_stmt_42_branch_ack_0 : boolean;
  signal binary_53_inst_req_0 : boolean;
  signal binary_53_inst_ack_0 : boolean;
  signal binary_53_inst_req_1 : boolean;
  signal binary_53_inst_ack_1 : boolean;
  signal type_cast_57_inst_req_0 : boolean;
  signal type_cast_57_inst_ack_0 : boolean;
  signal binary_63_inst_req_0 : boolean;
  signal binary_63_inst_ack_0 : boolean;
  signal binary_63_inst_req_1 : boolean;
  signal binary_63_inst_ack_1 : boolean;
  signal binary_69_inst_req_0 : boolean;
  signal binary_69_inst_ack_0 : boolean;
  signal binary_69_inst_req_1 : boolean;
  signal binary_69_inst_ack_1 : boolean;
  signal binary_75_inst_req_0 : boolean;
  signal binary_75_inst_ack_0 : boolean;
  signal binary_75_inst_req_1 : boolean;
  signal binary_75_inst_ack_1 : boolean;
  signal type_cast_136_inst_req_0 : boolean;
  signal type_cast_136_inst_ack_0 : boolean;
  signal phi_stmt_133_req_0 : boolean;
  signal type_cast_80_inst_req_0 : boolean;
  signal type_cast_80_inst_ack_0 : boolean;
  signal binary_84_inst_req_0 : boolean;
  signal binary_84_inst_ack_0 : boolean;
  signal binary_84_inst_req_1 : boolean;
  signal binary_84_inst_ack_1 : boolean;
  signal binary_90_inst_req_0 : boolean;
  signal binary_90_inst_ack_0 : boolean;
  signal binary_90_inst_req_1 : boolean;
  signal binary_90_inst_ack_1 : boolean;
  signal binary_96_inst_req_0 : boolean;
  signal binary_96_inst_ack_0 : boolean;
  signal binary_96_inst_req_1 : boolean;
  signal binary_96_inst_ack_1 : boolean;
  signal binary_102_inst_req_0 : boolean;
  signal binary_102_inst_ack_0 : boolean;
  signal binary_102_inst_req_1 : boolean;
  signal binary_102_inst_ack_1 : boolean;
  signal ternary_108_inst_req_0 : boolean;
  signal ternary_108_inst_ack_0 : boolean;
  signal type_cast_112_inst_req_0 : boolean;
  signal type_cast_112_inst_ack_0 : boolean;
  signal binary_118_inst_req_0 : boolean;
  signal binary_118_inst_ack_0 : boolean;
  signal binary_118_inst_req_1 : boolean;
  signal binary_118_inst_ack_1 : boolean;
  signal binary_124_inst_req_0 : boolean;
  signal binary_124_inst_ack_0 : boolean;
  signal binary_124_inst_req_1 : boolean;
  signal binary_124_inst_ack_1 : boolean;
  signal binary_129_inst_req_0 : boolean;
  signal binary_129_inst_ack_0 : boolean;
  signal binary_129_inst_req_1 : boolean;
  signal binary_129_inst_ack_1 : boolean;
  signal simple_obj_ref_146_inst_req_0 : boolean;
  signal simple_obj_ref_146_inst_ack_0 : boolean;
  signal simple_obj_ref_155_inst_req_0 : boolean;
  signal simple_obj_ref_155_inst_ack_0 : boolean;
  signal type_cast_138_inst_req_0 : boolean;
  signal type_cast_138_inst_ack_0 : boolean;
  signal phi_stmt_133_req_1 : boolean;
  signal phi_stmt_133_ack_0 : boolean;
  -- 
begin --  
  -- output port buffering assignments
  -- level-to-pulse translation..
  l2pStart: level_to_pulse -- 
    port map(clk => clk, reset =>reset, lreq => start_req, lack => start_ack_sig, preq => start_req_symbol, pack => start_ack_symbol); -- 
  start_ack <= start_ack_sig; 
  l2pFin: level_to_pulse -- 
    port map(clk => clk, reset =>reset, lreq => fin_req, lack => fin_ack_sig, preq => fin_req_symbol, pack => fin_ack_symbol); -- 
  fin_ack <= fin_ack_sig; 
  tag_push <= '1' when start_req_symbol else '0'; 
  tag_pop  <= fin_req and fin_ack_sig ; 
  tagQueue: QueueBase generic map(data_width => 1, queue_depth => 1 + 1) -- 
    port map(pop_req => tag_pop, pop_ack => open, 
    push_req => tag_push, push_ack => open, 
    data_out => tag_out, data_in => tag_in, 
    clk => clk, reset => reset); -- 
  -- the control path
  always_true_symbol <= true; 
  output_port_lookup_CP_0: Block -- control-path 
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_13_3_start : Boolean;
    signal branch_block_stmt_13_3_symbol : Boolean;
    -- 
  begin -- 
    output_port_lookup_CP_0_start_interlock : pipeline_interlock -- 
      port map (trigger => start_req_symbol,
      enable =>  fin_ack_symbol, 
      symbol_out => output_port_lookup_CP_0_start, 
      clk => clk, reset => reset); -- 
    start_ack_symbol <= Xexit_2_symbol;
    Xentry_1_symbol  <= output_port_lookup_CP_0_start; -- transition $entry
    branch_block_stmt_13_3: Block -- branch_block_stmt_13 
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_13_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_13_x_xexit_x_xx_x7_symbol : Boolean;
      signal bb_0_bb_1_8_symbol : Boolean;
      signal merge_stmt_15_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_22_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_22_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_25_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_25_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_31_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_31_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_34_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_34_x_xexit_x_xx_x17_symbol : Boolean;
      signal assign_stmt_41_x_xentry_x_xx_x18_symbol : Boolean;
      signal assign_stmt_41_x_xexit_x_xx_x19_symbol : Boolean;
      signal if_stmt_42_x_xentry_x_xx_x20_symbol : Boolean;
      signal if_stmt_42_x_xexit_x_xx_x21_symbol : Boolean;
      signal merge_stmt_48_x_xentry_x_xx_x22_symbol : Boolean;
      signal merge_stmt_48_x_xexit_x_xx_x23_symbol : Boolean;
      signal assign_stmt_54_to_assign_stmt_130_x_xentry_x_xx_x24_symbol : Boolean;
      signal assign_stmt_54_to_assign_stmt_130_x_xexit_x_xx_x25_symbol : Boolean;
      signal bb_2_bb_3_26_symbol : Boolean;
      signal merge_stmt_132_x_xexit_x_xx_x27_symbol : Boolean;
      signal assign_stmt_145_x_xentry_x_xx_x28_symbol : Boolean;
      signal assign_stmt_145_x_xexit_x_xx_x29_symbol : Boolean;
      signal assign_stmt_148_x_xentry_x_xx_x30_symbol : Boolean;
      signal assign_stmt_148_x_xexit_x_xx_x31_symbol : Boolean;
      signal assign_stmt_154_x_xentry_x_xx_x32_symbol : Boolean;
      signal assign_stmt_154_x_xexit_x_xx_x33_symbol : Boolean;
      signal assign_stmt_157_x_xentry_x_xx_x34_symbol : Boolean;
      signal assign_stmt_157_x_xexit_x_xx_x35_symbol : Boolean;
      signal bb_3_bb_1_36_symbol : Boolean;
      signal assign_stmt_22_37_start : Boolean;
      signal assign_stmt_22_37_symbol : Boolean;
      signal assign_stmt_25_40_start : Boolean;
      signal assign_stmt_25_40_symbol : Boolean;
      signal assign_stmt_31_51_start : Boolean;
      signal assign_stmt_31_51_symbol : Boolean;
      signal assign_stmt_34_54_start : Boolean;
      signal assign_stmt_34_54_symbol : Boolean;
      signal assign_stmt_41_65_start : Boolean;
      signal assign_stmt_41_65_symbol : Boolean;
      signal if_stmt_42_dead_link_80_start : Boolean;
      signal if_stmt_42_dead_link_80_symbol : Boolean;
      signal if_stmt_42_eval_test_84_start : Boolean;
      signal if_stmt_42_eval_test_84_symbol : Boolean;
      signal simple_obj_ref_43_place_88_symbol : Boolean;
      signal if_stmt_42_if_link_89_start : Boolean;
      signal if_stmt_42_if_link_89_symbol : Boolean;
      signal if_stmt_42_else_link_93_start : Boolean;
      signal if_stmt_42_else_link_93_symbol : Boolean;
      signal bb_1_bb_2_97_symbol : Boolean;
      signal bb_1_bb_3_98_symbol : Boolean;
      signal assign_stmt_54_to_assign_stmt_130_99_start : Boolean;
      signal assign_stmt_54_to_assign_stmt_130_99_symbol : Boolean;
      signal assign_stmt_145_274_start : Boolean;
      signal assign_stmt_145_274_symbol : Boolean;
      signal assign_stmt_148_277_start : Boolean;
      signal assign_stmt_148_277_symbol : Boolean;
      signal assign_stmt_154_289_start : Boolean;
      signal assign_stmt_154_289_symbol : Boolean;
      signal assign_stmt_157_292_start : Boolean;
      signal assign_stmt_157_292_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_304_start : Boolean;
      signal bb_0_bb_1_PhiReq_304_symbol : Boolean;
      signal bb_3_bb_1_PhiReq_307_start : Boolean;
      signal bb_3_bb_1_PhiReq_307_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_310_symbol : Boolean;
      signal merge_stmt_15_PhiAck_311_start : Boolean;
      signal merge_stmt_15_PhiAck_311_symbol : Boolean;
      signal merge_stmt_48_dead_link_315_start : Boolean;
      signal merge_stmt_48_dead_link_315_symbol : Boolean;
      signal bb_1_bb_2_PhiReq_319_start : Boolean;
      signal bb_1_bb_2_PhiReq_319_symbol : Boolean;
      signal merge_stmt_48_PhiReqMerge_322_symbol : Boolean;
      signal merge_stmt_48_PhiAck_323_start : Boolean;
      signal merge_stmt_48_PhiAck_323_symbol : Boolean;
      signal bb_1_bb_3_PhiReq_327_start : Boolean;
      signal bb_1_bb_3_PhiReq_327_symbol : Boolean;
      signal bb_2_bb_3_PhiReq_347_start : Boolean;
      signal bb_2_bb_3_PhiReq_347_symbol : Boolean;
      signal merge_stmt_132_PhiReqMerge_367_symbol : Boolean;
      signal merge_stmt_132_PhiAck_368_start : Boolean;
      signal merge_stmt_132_PhiAck_368_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x9_symbol  <=  merge_stmt_15_PhiAck_311_symbol; -- place branch_block_stmt_13/merge_stmt_15__exit__ (optimized away) 
      assign_stmt_22_x_xentry_x_xx_x10_symbol  <=  merge_stmt_15_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/assign_stmt_22__entry__ (optimized away) 
      assign_stmt_22_x_xexit_x_xx_x11_symbol  <=  assign_stmt_22_37_symbol; -- place branch_block_stmt_13/assign_stmt_22__exit__ (optimized away) 
      assign_stmt_25_x_xentry_x_xx_x12_symbol  <=  assign_stmt_22_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_25__entry__ (optimized away) 
      assign_stmt_25_x_xexit_x_xx_x13_symbol  <=  assign_stmt_25_40_symbol; -- place branch_block_stmt_13/assign_stmt_25__exit__ (optimized away) 
      assign_stmt_31_x_xentry_x_xx_x14_symbol  <=  assign_stmt_25_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/assign_stmt_31__entry__ (optimized away) 
      assign_stmt_31_x_xexit_x_xx_x15_symbol  <=  assign_stmt_31_51_symbol; -- place branch_block_stmt_13/assign_stmt_31__exit__ (optimized away) 
      assign_stmt_34_x_xentry_x_xx_x16_symbol  <=  assign_stmt_31_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_13/assign_stmt_34__entry__ (optimized away) 
      assign_stmt_34_x_xexit_x_xx_x17_symbol  <=  assign_stmt_34_54_symbol; -- place branch_block_stmt_13/assign_stmt_34__exit__ (optimized away) 
      assign_stmt_41_x_xentry_x_xx_x18_symbol  <=  assign_stmt_34_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_13/assign_stmt_41__entry__ (optimized away) 
      assign_stmt_41_x_xexit_x_xx_x19_symbol  <=  assign_stmt_41_65_symbol; -- place branch_block_stmt_13/assign_stmt_41__exit__ (optimized away) 
      if_stmt_42_x_xentry_x_xx_x20_symbol  <=  assign_stmt_41_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_13/if_stmt_42__entry__ (optimized away) 
      if_stmt_42_x_xexit_x_xx_x21_symbol  <=  if_stmt_42_dead_link_80_symbol; -- place branch_block_stmt_13/if_stmt_42__exit__ (optimized away) 
      merge_stmt_48_x_xentry_x_xx_x22_symbol  <=  if_stmt_42_x_xexit_x_xx_x21_symbol; -- place branch_block_stmt_13/merge_stmt_48__entry__ (optimized away) 
      merge_stmt_48_x_xexit_x_xx_x23_symbol  <=  merge_stmt_48_dead_link_315_symbol or merge_stmt_48_PhiAck_323_symbol; -- place branch_block_stmt_13/merge_stmt_48__exit__ (optimized away) 
      assign_stmt_54_to_assign_stmt_130_x_xentry_x_xx_x24_symbol  <=  merge_stmt_48_x_xexit_x_xx_x23_symbol; -- place branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130__entry__ (optimized away) 
      assign_stmt_54_to_assign_stmt_130_x_xexit_x_xx_x25_symbol  <=  assign_stmt_54_to_assign_stmt_130_99_symbol; -- place branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130__exit__ (optimized away) 
      bb_2_bb_3_26_symbol  <=  assign_stmt_54_to_assign_stmt_130_x_xexit_x_xx_x25_symbol; -- place branch_block_stmt_13/bb_2_bb_3 (optimized away) 
      merge_stmt_132_x_xexit_x_xx_x27_symbol  <=  merge_stmt_132_PhiAck_368_symbol; -- place branch_block_stmt_13/merge_stmt_132__exit__ (optimized away) 
      assign_stmt_145_x_xentry_x_xx_x28_symbol  <=  merge_stmt_132_x_xexit_x_xx_x27_symbol; -- place branch_block_stmt_13/assign_stmt_145__entry__ (optimized away) 
      assign_stmt_145_x_xexit_x_xx_x29_symbol  <=  assign_stmt_145_274_symbol; -- place branch_block_stmt_13/assign_stmt_145__exit__ (optimized away) 
      assign_stmt_148_x_xentry_x_xx_x30_symbol  <=  assign_stmt_145_x_xexit_x_xx_x29_symbol; -- place branch_block_stmt_13/assign_stmt_148__entry__ (optimized away) 
      assign_stmt_148_x_xexit_x_xx_x31_symbol  <=  assign_stmt_148_277_symbol; -- place branch_block_stmt_13/assign_stmt_148__exit__ (optimized away) 
      assign_stmt_154_x_xentry_x_xx_x32_symbol  <=  assign_stmt_148_x_xexit_x_xx_x31_symbol; -- place branch_block_stmt_13/assign_stmt_154__entry__ (optimized away) 
      assign_stmt_154_x_xexit_x_xx_x33_symbol  <=  assign_stmt_154_289_symbol; -- place branch_block_stmt_13/assign_stmt_154__exit__ (optimized away) 
      assign_stmt_157_x_xentry_x_xx_x34_symbol  <=  assign_stmt_154_x_xexit_x_xx_x33_symbol; -- place branch_block_stmt_13/assign_stmt_157__entry__ (optimized away) 
      assign_stmt_157_x_xexit_x_xx_x35_symbol  <=  assign_stmt_157_292_symbol; -- place branch_block_stmt_13/assign_stmt_157__exit__ (optimized away) 
      bb_3_bb_1_36_symbol  <=  assign_stmt_157_x_xexit_x_xx_x35_symbol; -- place branch_block_stmt_13/bb_3_bb_1 (optimized away) 
      assign_stmt_22_37: Block -- branch_block_stmt_13/assign_stmt_22 
        signal Xentry_38_symbol: Boolean;
        signal Xexit_39_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_22_37_start <= assign_stmt_22_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_38_symbol  <= assign_stmt_22_37_start; -- transition branch_block_stmt_13/assign_stmt_22/$entry
        Xexit_39_symbol <= Xentry_38_symbol; -- transition branch_block_stmt_13/assign_stmt_22/$exit
        assign_stmt_22_37_symbol <= Xexit_39_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_22
      assign_stmt_25_40: Block -- branch_block_stmt_13/assign_stmt_25 
        signal Xentry_41_symbol: Boolean;
        signal Xexit_42_symbol: Boolean;
        signal assign_stmt_25_active_x_x43_symbol : Boolean;
        signal assign_stmt_25_completed_x_x44_symbol : Boolean;
        signal simple_obj_ref_24_trigger_x_x45_symbol : Boolean;
        signal simple_obj_ref_24_complete_46_start : Boolean;
        signal simple_obj_ref_24_complete_46_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_25_40_start <= assign_stmt_25_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_41_symbol  <= assign_stmt_25_40_start; -- transition branch_block_stmt_13/assign_stmt_25/$entry
        assign_stmt_25_active_x_x43_symbol <= simple_obj_ref_24_complete_46_symbol; -- transition branch_block_stmt_13/assign_stmt_25/assign_stmt_25_active_
        assign_stmt_25_completed_x_x44_symbol <= assign_stmt_25_active_x_x43_symbol; -- transition branch_block_stmt_13/assign_stmt_25/assign_stmt_25_completed_
        simple_obj_ref_24_trigger_x_x45_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_trigger_
        simple_obj_ref_24_complete_46: Block -- branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete 
          signal Xentry_47_symbol: Boolean;
          signal Xexit_48_symbol: Boolean;
          signal req_49_symbol : Boolean;
          signal ack_50_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_24_complete_46_start <= simple_obj_ref_24_trigger_x_x45_symbol; -- control passed to block
          Xentry_47_symbol  <= simple_obj_ref_24_complete_46_start; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/$entry
          req_49_symbol <= Xentry_47_symbol; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/req
          simple_obj_ref_24_inst_req_0 <= req_49_symbol; -- link to DP
          ack_50_symbol <= simple_obj_ref_24_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/ack
          Xexit_48_symbol <= ack_50_symbol; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/$exit
          simple_obj_ref_24_complete_46_symbol <= Xexit_48_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete
        Xexit_42_symbol <= assign_stmt_25_completed_x_x44_symbol; -- transition branch_block_stmt_13/assign_stmt_25/$exit
        assign_stmt_25_40_symbol <= Xexit_42_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_25
      assign_stmt_31_51: Block -- branch_block_stmt_13/assign_stmt_31 
        signal Xentry_52_symbol: Boolean;
        signal Xexit_53_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_31_51_start <= assign_stmt_31_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_52_symbol  <= assign_stmt_31_51_start; -- transition branch_block_stmt_13/assign_stmt_31/$entry
        Xexit_53_symbol <= Xentry_52_symbol; -- transition branch_block_stmt_13/assign_stmt_31/$exit
        assign_stmt_31_51_symbol <= Xexit_53_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_31
      assign_stmt_34_54: Block -- branch_block_stmt_13/assign_stmt_34 
        signal Xentry_55_symbol: Boolean;
        signal Xexit_56_symbol: Boolean;
        signal assign_stmt_34_active_x_x57_symbol : Boolean;
        signal assign_stmt_34_completed_x_x58_symbol : Boolean;
        signal simple_obj_ref_33_trigger_x_x59_symbol : Boolean;
        signal simple_obj_ref_33_complete_60_start : Boolean;
        signal simple_obj_ref_33_complete_60_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_34_54_start <= assign_stmt_34_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_55_symbol  <= assign_stmt_34_54_start; -- transition branch_block_stmt_13/assign_stmt_34/$entry
        assign_stmt_34_active_x_x57_symbol <= simple_obj_ref_33_complete_60_symbol; -- transition branch_block_stmt_13/assign_stmt_34/assign_stmt_34_active_
        assign_stmt_34_completed_x_x58_symbol <= assign_stmt_34_active_x_x57_symbol; -- transition branch_block_stmt_13/assign_stmt_34/assign_stmt_34_completed_
        simple_obj_ref_33_trigger_x_x59_symbol <= Xentry_55_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_trigger_
        simple_obj_ref_33_complete_60: Block -- branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete 
          signal Xentry_61_symbol: Boolean;
          signal Xexit_62_symbol: Boolean;
          signal req_63_symbol : Boolean;
          signal ack_64_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_33_complete_60_start <= simple_obj_ref_33_trigger_x_x59_symbol; -- control passed to block
          Xentry_61_symbol  <= simple_obj_ref_33_complete_60_start; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete/$entry
          req_63_symbol <= Xentry_61_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete/req
          simple_obj_ref_33_inst_req_0 <= req_63_symbol; -- link to DP
          ack_64_symbol <= simple_obj_ref_33_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete/ack
          Xexit_62_symbol <= ack_64_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete/$exit
          simple_obj_ref_33_complete_60_symbol <= Xexit_62_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete
        Xexit_56_symbol <= assign_stmt_34_completed_x_x58_symbol; -- transition branch_block_stmt_13/assign_stmt_34/$exit
        assign_stmt_34_54_symbol <= Xexit_56_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_34
      assign_stmt_41_65: Block -- branch_block_stmt_13/assign_stmt_41 
        signal Xentry_66_symbol: Boolean;
        signal Xexit_67_symbol: Boolean;
        signal assign_stmt_41_active_x_x68_symbol : Boolean;
        signal assign_stmt_41_completed_x_x69_symbol : Boolean;
        signal binary_39_active_x_x70_symbol : Boolean;
        signal binary_39_trigger_x_x71_symbol : Boolean;
        signal simple_obj_ref_36_complete_72_symbol : Boolean;
        signal binary_39_complete_73_start : Boolean;
        signal binary_39_complete_73_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_41_65_start <= assign_stmt_41_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_66_symbol  <= assign_stmt_41_65_start; -- transition branch_block_stmt_13/assign_stmt_41/$entry
        assign_stmt_41_active_x_x68_symbol <= binary_39_complete_73_symbol; -- transition branch_block_stmt_13/assign_stmt_41/assign_stmt_41_active_
        assign_stmt_41_completed_x_x69_symbol <= assign_stmt_41_active_x_x68_symbol; -- transition branch_block_stmt_13/assign_stmt_41/assign_stmt_41_completed_
        binary_39_active_x_x70_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41/binary_39_active_ 
          signal binary_39_active_x_x70_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_39_active_x_x70_predecessors(0) <= binary_39_trigger_x_x71_symbol;
          binary_39_active_x_x70_predecessors(1) <= simple_obj_ref_36_complete_72_symbol;
          binary_39_active_x_x70_join: join -- 
            port map( -- 
              preds => binary_39_active_x_x70_predecessors,
              symbol_out => binary_39_active_x_x70_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41/binary_39_active_
        binary_39_trigger_x_x71_symbol <= Xentry_66_symbol; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_trigger_
        simple_obj_ref_36_complete_72_symbol <= Xentry_66_symbol; -- transition branch_block_stmt_13/assign_stmt_41/simple_obj_ref_36_complete
        binary_39_complete_73: Block -- branch_block_stmt_13/assign_stmt_41/binary_39_complete 
          signal Xentry_74_symbol: Boolean;
          signal Xexit_75_symbol: Boolean;
          signal rr_76_symbol : Boolean;
          signal ra_77_symbol : Boolean;
          signal cr_78_symbol : Boolean;
          signal ca_79_symbol : Boolean;
          -- 
        begin -- 
          binary_39_complete_73_start <= binary_39_active_x_x70_symbol; -- control passed to block
          Xentry_74_symbol  <= binary_39_complete_73_start; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_complete/$entry
          rr_76_symbol <= Xentry_74_symbol; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_complete/rr
          binary_39_inst_req_0 <= rr_76_symbol; -- link to DP
          ra_77_symbol <= binary_39_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_complete/ra
          cr_78_symbol <= ra_77_symbol; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_complete/cr
          binary_39_inst_req_1 <= cr_78_symbol; -- link to DP
          ca_79_symbol <= binary_39_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_complete/ca
          Xexit_75_symbol <= ca_79_symbol; -- transition branch_block_stmt_13/assign_stmt_41/binary_39_complete/$exit
          binary_39_complete_73_symbol <= Xexit_75_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41/binary_39_complete
        Xexit_67_symbol <= assign_stmt_41_completed_x_x69_symbol; -- transition branch_block_stmt_13/assign_stmt_41/$exit
        assign_stmt_41_65_symbol <= Xexit_67_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_41
      if_stmt_42_dead_link_80: Block -- branch_block_stmt_13/if_stmt_42_dead_link 
        signal Xentry_81_symbol: Boolean;
        signal Xexit_82_symbol: Boolean;
        signal dead_transition_83_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_42_dead_link_80_start <= if_stmt_42_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_81_symbol  <= if_stmt_42_dead_link_80_start; -- transition branch_block_stmt_13/if_stmt_42_dead_link/$entry
        dead_transition_83_symbol <= false;
        Xexit_82_symbol <= dead_transition_83_symbol; -- transition branch_block_stmt_13/if_stmt_42_dead_link/$exit
        if_stmt_42_dead_link_80_symbol <= Xexit_82_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_42_dead_link
      if_stmt_42_eval_test_84: Block -- branch_block_stmt_13/if_stmt_42_eval_test 
        signal Xentry_85_symbol: Boolean;
        signal Xexit_86_symbol: Boolean;
        signal branch_req_87_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_42_eval_test_84_start <= if_stmt_42_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_85_symbol  <= if_stmt_42_eval_test_84_start; -- transition branch_block_stmt_13/if_stmt_42_eval_test/$entry
        branch_req_87_symbol <= Xentry_85_symbol; -- transition branch_block_stmt_13/if_stmt_42_eval_test/branch_req
        if_stmt_42_branch_req_0 <= branch_req_87_symbol; -- link to DP
        Xexit_86_symbol <= branch_req_87_symbol; -- transition branch_block_stmt_13/if_stmt_42_eval_test/$exit
        if_stmt_42_eval_test_84_symbol <= Xexit_86_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_42_eval_test
      simple_obj_ref_43_place_88_symbol  <=  if_stmt_42_eval_test_84_symbol; -- place branch_block_stmt_13/simple_obj_ref_43_place (optimized away) 
      if_stmt_42_if_link_89: Block -- branch_block_stmt_13/if_stmt_42_if_link 
        signal Xentry_90_symbol: Boolean;
        signal Xexit_91_symbol: Boolean;
        signal if_choice_transition_92_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_42_if_link_89_start <= simple_obj_ref_43_place_88_symbol; -- control passed to block
        Xentry_90_symbol  <= if_stmt_42_if_link_89_start; -- transition branch_block_stmt_13/if_stmt_42_if_link/$entry
        if_choice_transition_92_symbol <= if_stmt_42_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_42_if_link/if_choice_transition
        Xexit_91_symbol <= if_choice_transition_92_symbol; -- transition branch_block_stmt_13/if_stmt_42_if_link/$exit
        if_stmt_42_if_link_89_symbol <= Xexit_91_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_42_if_link
      if_stmt_42_else_link_93: Block -- branch_block_stmt_13/if_stmt_42_else_link 
        signal Xentry_94_symbol: Boolean;
        signal Xexit_95_symbol: Boolean;
        signal else_choice_transition_96_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_42_else_link_93_start <= simple_obj_ref_43_place_88_symbol; -- control passed to block
        Xentry_94_symbol  <= if_stmt_42_else_link_93_start; -- transition branch_block_stmt_13/if_stmt_42_else_link/$entry
        else_choice_transition_96_symbol <= if_stmt_42_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_42_else_link/else_choice_transition
        Xexit_95_symbol <= else_choice_transition_96_symbol; -- transition branch_block_stmt_13/if_stmt_42_else_link/$exit
        if_stmt_42_else_link_93_symbol <= Xexit_95_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_42_else_link
      bb_1_bb_2_97_symbol  <=  if_stmt_42_if_link_89_symbol; -- place branch_block_stmt_13/bb_1_bb_2 (optimized away) 
      bb_1_bb_3_98_symbol  <=  if_stmt_42_else_link_93_symbol; -- place branch_block_stmt_13/bb_1_bb_3 (optimized away) 
      assign_stmt_54_to_assign_stmt_130_99: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130 
        signal Xentry_100_symbol: Boolean;
        signal Xexit_101_symbol: Boolean;
        signal assign_stmt_54_active_x_x102_symbol : Boolean;
        signal assign_stmt_54_completed_x_x103_symbol : Boolean;
        signal binary_53_active_x_x104_symbol : Boolean;
        signal binary_53_trigger_x_x105_symbol : Boolean;
        signal simple_obj_ref_50_complete_106_symbol : Boolean;
        signal binary_53_complete_107_start : Boolean;
        signal binary_53_complete_107_symbol : Boolean;
        signal assign_stmt_58_active_x_x114_symbol : Boolean;
        signal assign_stmt_58_completed_x_x115_symbol : Boolean;
        signal type_cast_57_active_x_x116_symbol : Boolean;
        signal type_cast_57_trigger_x_x117_symbol : Boolean;
        signal simple_obj_ref_56_complete_118_symbol : Boolean;
        signal type_cast_57_complete_119_start : Boolean;
        signal type_cast_57_complete_119_symbol : Boolean;
        signal assign_stmt_64_active_x_x124_symbol : Boolean;
        signal assign_stmt_64_completed_x_x125_symbol : Boolean;
        signal binary_63_active_x_x126_symbol : Boolean;
        signal binary_63_trigger_x_x127_symbol : Boolean;
        signal simple_obj_ref_60_complete_128_symbol : Boolean;
        signal binary_63_complete_129_start : Boolean;
        signal binary_63_complete_129_symbol : Boolean;
        signal assign_stmt_70_active_x_x136_symbol : Boolean;
        signal assign_stmt_70_completed_x_x137_symbol : Boolean;
        signal binary_69_active_x_x138_symbol : Boolean;
        signal binary_69_trigger_x_x139_symbol : Boolean;
        signal simple_obj_ref_68_complete_140_symbol : Boolean;
        signal binary_69_complete_141_start : Boolean;
        signal binary_69_complete_141_symbol : Boolean;
        signal assign_stmt_76_active_x_x148_symbol : Boolean;
        signal assign_stmt_76_completed_x_x149_symbol : Boolean;
        signal binary_75_active_x_x150_symbol : Boolean;
        signal binary_75_trigger_x_x151_symbol : Boolean;
        signal simple_obj_ref_72_complete_152_symbol : Boolean;
        signal binary_75_complete_153_start : Boolean;
        signal binary_75_complete_153_symbol : Boolean;
        signal assign_stmt_85_active_x_x160_symbol : Boolean;
        signal assign_stmt_85_completed_x_x161_symbol : Boolean;
        signal binary_84_active_x_x162_symbol : Boolean;
        signal binary_84_trigger_x_x163_symbol : Boolean;
        signal type_cast_80_active_x_x164_symbol : Boolean;
        signal type_cast_80_trigger_x_x165_symbol : Boolean;
        signal simple_obj_ref_79_complete_166_symbol : Boolean;
        signal type_cast_80_complete_167_start : Boolean;
        signal type_cast_80_complete_167_symbol : Boolean;
        signal binary_84_complete_172_start : Boolean;
        signal binary_84_complete_172_symbol : Boolean;
        signal assign_stmt_91_active_x_x179_symbol : Boolean;
        signal assign_stmt_91_completed_x_x180_symbol : Boolean;
        signal binary_90_active_x_x181_symbol : Boolean;
        signal binary_90_trigger_x_x182_symbol : Boolean;
        signal simple_obj_ref_87_complete_183_symbol : Boolean;
        signal binary_90_complete_184_start : Boolean;
        signal binary_90_complete_184_symbol : Boolean;
        signal assign_stmt_97_active_x_x191_symbol : Boolean;
        signal assign_stmt_97_completed_x_x192_symbol : Boolean;
        signal binary_96_active_x_x193_symbol : Boolean;
        signal binary_96_trigger_x_x194_symbol : Boolean;
        signal simple_obj_ref_93_complete_195_symbol : Boolean;
        signal binary_96_complete_196_start : Boolean;
        signal binary_96_complete_196_symbol : Boolean;
        signal assign_stmt_103_active_x_x203_symbol : Boolean;
        signal assign_stmt_103_completed_x_x204_symbol : Boolean;
        signal binary_102_active_x_x205_symbol : Boolean;
        signal binary_102_trigger_x_x206_symbol : Boolean;
        signal simple_obj_ref_99_complete_207_symbol : Boolean;
        signal binary_102_complete_208_start : Boolean;
        signal binary_102_complete_208_symbol : Boolean;
        signal assign_stmt_109_active_x_x215_symbol : Boolean;
        signal assign_stmt_109_completed_x_x216_symbol : Boolean;
        signal ternary_108_trigger_x_x217_symbol : Boolean;
        signal ternary_108_active_x_x218_symbol : Boolean;
        signal simple_obj_ref_105_complete_219_symbol : Boolean;
        signal simple_obj_ref_106_complete_220_symbol : Boolean;
        signal simple_obj_ref_107_complete_221_symbol : Boolean;
        signal ternary_108_complete_222_start : Boolean;
        signal ternary_108_complete_222_symbol : Boolean;
        signal assign_stmt_113_active_x_x227_symbol : Boolean;
        signal assign_stmt_113_completed_x_x228_symbol : Boolean;
        signal type_cast_112_active_x_x229_symbol : Boolean;
        signal type_cast_112_trigger_x_x230_symbol : Boolean;
        signal simple_obj_ref_111_complete_231_symbol : Boolean;
        signal type_cast_112_complete_232_start : Boolean;
        signal type_cast_112_complete_232_symbol : Boolean;
        signal assign_stmt_119_active_x_x237_symbol : Boolean;
        signal assign_stmt_119_completed_x_x238_symbol : Boolean;
        signal binary_118_active_x_x239_symbol : Boolean;
        signal binary_118_trigger_x_x240_symbol : Boolean;
        signal simple_obj_ref_115_complete_241_symbol : Boolean;
        signal binary_118_complete_242_start : Boolean;
        signal binary_118_complete_242_symbol : Boolean;
        signal assign_stmt_125_active_x_x249_symbol : Boolean;
        signal assign_stmt_125_completed_x_x250_symbol : Boolean;
        signal binary_124_active_x_x251_symbol : Boolean;
        signal binary_124_trigger_x_x252_symbol : Boolean;
        signal simple_obj_ref_121_complete_253_symbol : Boolean;
        signal binary_124_complete_254_start : Boolean;
        signal binary_124_complete_254_symbol : Boolean;
        signal assign_stmt_130_active_x_x261_symbol : Boolean;
        signal assign_stmt_130_completed_x_x262_symbol : Boolean;
        signal binary_129_active_x_x263_symbol : Boolean;
        signal binary_129_trigger_x_x264_symbol : Boolean;
        signal simple_obj_ref_127_complete_265_symbol : Boolean;
        signal simple_obj_ref_128_complete_266_symbol : Boolean;
        signal binary_129_complete_267_start : Boolean;
        signal binary_129_complete_267_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_54_to_assign_stmt_130_99_start <= assign_stmt_54_to_assign_stmt_130_x_xentry_x_xx_x24_symbol; -- control passed to block
        Xentry_100_symbol  <= assign_stmt_54_to_assign_stmt_130_99_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/$entry
        assign_stmt_54_active_x_x102_symbol <= binary_53_complete_107_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_54_active_
        assign_stmt_54_completed_x_x103_symbol <= assign_stmt_54_active_x_x102_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_54_completed_
        binary_53_active_x_x104_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_active_ 
          signal binary_53_active_x_x104_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_53_active_x_x104_predecessors(0) <= binary_53_trigger_x_x105_symbol;
          binary_53_active_x_x104_predecessors(1) <= simple_obj_ref_50_complete_106_symbol;
          binary_53_active_x_x104_join: join -- 
            port map( -- 
              preds => binary_53_active_x_x104_predecessors,
              symbol_out => binary_53_active_x_x104_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_active_
        binary_53_trigger_x_x105_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_trigger_
        simple_obj_ref_50_complete_106_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_50_complete
        binary_53_complete_107: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete 
          signal Xentry_108_symbol: Boolean;
          signal Xexit_109_symbol: Boolean;
          signal rr_110_symbol : Boolean;
          signal ra_111_symbol : Boolean;
          signal cr_112_symbol : Boolean;
          signal ca_113_symbol : Boolean;
          -- 
        begin -- 
          binary_53_complete_107_start <= binary_53_active_x_x104_symbol; -- control passed to block
          Xentry_108_symbol  <= binary_53_complete_107_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete/$entry
          rr_110_symbol <= Xentry_108_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete/rr
          binary_53_inst_req_0 <= rr_110_symbol; -- link to DP
          ra_111_symbol <= binary_53_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete/ra
          cr_112_symbol <= ra_111_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete/cr
          binary_53_inst_req_1 <= cr_112_symbol; -- link to DP
          ca_113_symbol <= binary_53_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete/ca
          Xexit_109_symbol <= ca_113_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete/$exit
          binary_53_complete_107_symbol <= Xexit_109_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_53_complete
        assign_stmt_58_active_x_x114_symbol <= type_cast_57_complete_119_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_58_active_
        assign_stmt_58_completed_x_x115_symbol <= assign_stmt_58_active_x_x114_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_58_completed_
        type_cast_57_active_x_x116_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_active_ 
          signal type_cast_57_active_x_x116_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_57_active_x_x116_predecessors(0) <= type_cast_57_trigger_x_x117_symbol;
          type_cast_57_active_x_x116_predecessors(1) <= simple_obj_ref_56_complete_118_symbol;
          type_cast_57_active_x_x116_join: join -- 
            port map( -- 
              preds => type_cast_57_active_x_x116_predecessors,
              symbol_out => type_cast_57_active_x_x116_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_active_
        type_cast_57_trigger_x_x117_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_trigger_
        simple_obj_ref_56_complete_118_symbol <= assign_stmt_54_completed_x_x103_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_56_complete
        type_cast_57_complete_119: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_complete 
          signal Xentry_120_symbol: Boolean;
          signal Xexit_121_symbol: Boolean;
          signal req_122_symbol : Boolean;
          signal ack_123_symbol : Boolean;
          -- 
        begin -- 
          type_cast_57_complete_119_start <= type_cast_57_active_x_x116_symbol; -- control passed to block
          Xentry_120_symbol  <= type_cast_57_complete_119_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_complete/$entry
          req_122_symbol <= Xentry_120_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_complete/req
          type_cast_57_inst_req_0 <= req_122_symbol; -- link to DP
          ack_123_symbol <= type_cast_57_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_complete/ack
          Xexit_121_symbol <= ack_123_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_complete/$exit
          type_cast_57_complete_119_symbol <= Xexit_121_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_57_complete
        assign_stmt_64_active_x_x124_symbol <= binary_63_complete_129_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_64_active_
        assign_stmt_64_completed_x_x125_symbol <= assign_stmt_64_active_x_x124_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_64_completed_
        binary_63_active_x_x126_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_active_ 
          signal binary_63_active_x_x126_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_63_active_x_x126_predecessors(0) <= binary_63_trigger_x_x127_symbol;
          binary_63_active_x_x126_predecessors(1) <= simple_obj_ref_60_complete_128_symbol;
          binary_63_active_x_x126_join: join -- 
            port map( -- 
              preds => binary_63_active_x_x126_predecessors,
              symbol_out => binary_63_active_x_x126_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_active_
        binary_63_trigger_x_x127_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_trigger_
        simple_obj_ref_60_complete_128_symbol <= assign_stmt_58_completed_x_x115_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_60_complete
        binary_63_complete_129: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete 
          signal Xentry_130_symbol: Boolean;
          signal Xexit_131_symbol: Boolean;
          signal rr_132_symbol : Boolean;
          signal ra_133_symbol : Boolean;
          signal cr_134_symbol : Boolean;
          signal ca_135_symbol : Boolean;
          -- 
        begin -- 
          binary_63_complete_129_start <= binary_63_active_x_x126_symbol; -- control passed to block
          Xentry_130_symbol  <= binary_63_complete_129_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete/$entry
          rr_132_symbol <= Xentry_130_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete/rr
          binary_63_inst_req_0 <= rr_132_symbol; -- link to DP
          ra_133_symbol <= binary_63_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete/ra
          cr_134_symbol <= ra_133_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete/cr
          binary_63_inst_req_1 <= cr_134_symbol; -- link to DP
          ca_135_symbol <= binary_63_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete/ca
          Xexit_131_symbol <= ca_135_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete/$exit
          binary_63_complete_129_symbol <= Xexit_131_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_63_complete
        assign_stmt_70_active_x_x136_symbol <= binary_69_complete_141_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_70_active_
        assign_stmt_70_completed_x_x137_symbol <= assign_stmt_70_active_x_x136_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_70_completed_
        binary_69_active_x_x138_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_active_ 
          signal binary_69_active_x_x138_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_69_active_x_x138_predecessors(0) <= binary_69_trigger_x_x139_symbol;
          binary_69_active_x_x138_predecessors(1) <= simple_obj_ref_68_complete_140_symbol;
          binary_69_active_x_x138_join: join -- 
            port map( -- 
              preds => binary_69_active_x_x138_predecessors,
              symbol_out => binary_69_active_x_x138_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_active_
        binary_69_trigger_x_x139_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_trigger_
        simple_obj_ref_68_complete_140_symbol <= assign_stmt_64_completed_x_x125_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_68_complete
        binary_69_complete_141: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete 
          signal Xentry_142_symbol: Boolean;
          signal Xexit_143_symbol: Boolean;
          signal rr_144_symbol : Boolean;
          signal ra_145_symbol : Boolean;
          signal cr_146_symbol : Boolean;
          signal ca_147_symbol : Boolean;
          -- 
        begin -- 
          binary_69_complete_141_start <= binary_69_active_x_x138_symbol; -- control passed to block
          Xentry_142_symbol  <= binary_69_complete_141_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete/$entry
          rr_144_symbol <= Xentry_142_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete/rr
          binary_69_inst_req_0 <= rr_144_symbol; -- link to DP
          ra_145_symbol <= binary_69_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete/ra
          cr_146_symbol <= ra_145_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete/cr
          binary_69_inst_req_1 <= cr_146_symbol; -- link to DP
          ca_147_symbol <= binary_69_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete/ca
          Xexit_143_symbol <= ca_147_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete/$exit
          binary_69_complete_141_symbol <= Xexit_143_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_69_complete
        assign_stmt_76_active_x_x148_symbol <= binary_75_complete_153_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_76_active_
        assign_stmt_76_completed_x_x149_symbol <= assign_stmt_76_active_x_x148_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_76_completed_
        binary_75_active_x_x150_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_active_ 
          signal binary_75_active_x_x150_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_75_active_x_x150_predecessors(0) <= binary_75_trigger_x_x151_symbol;
          binary_75_active_x_x150_predecessors(1) <= simple_obj_ref_72_complete_152_symbol;
          binary_75_active_x_x150_join: join -- 
            port map( -- 
              preds => binary_75_active_x_x150_predecessors,
              symbol_out => binary_75_active_x_x150_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_active_
        binary_75_trigger_x_x151_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_trigger_
        simple_obj_ref_72_complete_152_symbol <= assign_stmt_54_completed_x_x103_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_72_complete
        binary_75_complete_153: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete 
          signal Xentry_154_symbol: Boolean;
          signal Xexit_155_symbol: Boolean;
          signal rr_156_symbol : Boolean;
          signal ra_157_symbol : Boolean;
          signal cr_158_symbol : Boolean;
          signal ca_159_symbol : Boolean;
          -- 
        begin -- 
          binary_75_complete_153_start <= binary_75_active_x_x150_symbol; -- control passed to block
          Xentry_154_symbol  <= binary_75_complete_153_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete/$entry
          rr_156_symbol <= Xentry_154_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete/rr
          binary_75_inst_req_0 <= rr_156_symbol; -- link to DP
          ra_157_symbol <= binary_75_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete/ra
          cr_158_symbol <= ra_157_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete/cr
          binary_75_inst_req_1 <= cr_158_symbol; -- link to DP
          ca_159_symbol <= binary_75_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete/ca
          Xexit_155_symbol <= ca_159_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete/$exit
          binary_75_complete_153_symbol <= Xexit_155_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_75_complete
        assign_stmt_85_active_x_x160_symbol <= binary_84_complete_172_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_85_active_
        assign_stmt_85_completed_x_x161_symbol <= assign_stmt_85_active_x_x160_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_85_completed_
        binary_84_active_x_x162_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_active_ 
          signal binary_84_active_x_x162_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_84_active_x_x162_predecessors(0) <= binary_84_trigger_x_x163_symbol;
          binary_84_active_x_x162_predecessors(1) <= type_cast_80_complete_167_symbol;
          binary_84_active_x_x162_join: join -- 
            port map( -- 
              preds => binary_84_active_x_x162_predecessors,
              symbol_out => binary_84_active_x_x162_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_active_
        binary_84_trigger_x_x163_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_trigger_
        type_cast_80_active_x_x164_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_active_ 
          signal type_cast_80_active_x_x164_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_80_active_x_x164_predecessors(0) <= type_cast_80_trigger_x_x165_symbol;
          type_cast_80_active_x_x164_predecessors(1) <= simple_obj_ref_79_complete_166_symbol;
          type_cast_80_active_x_x164_join: join -- 
            port map( -- 
              preds => type_cast_80_active_x_x164_predecessors,
              symbol_out => type_cast_80_active_x_x164_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_active_
        type_cast_80_trigger_x_x165_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_trigger_
        simple_obj_ref_79_complete_166_symbol <= assign_stmt_76_completed_x_x149_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_79_complete
        type_cast_80_complete_167: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_complete 
          signal Xentry_168_symbol: Boolean;
          signal Xexit_169_symbol: Boolean;
          signal req_170_symbol : Boolean;
          signal ack_171_symbol : Boolean;
          -- 
        begin -- 
          type_cast_80_complete_167_start <= type_cast_80_active_x_x164_symbol; -- control passed to block
          Xentry_168_symbol  <= type_cast_80_complete_167_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_complete/$entry
          req_170_symbol <= Xentry_168_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_complete/req
          type_cast_80_inst_req_0 <= req_170_symbol; -- link to DP
          ack_171_symbol <= type_cast_80_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_complete/ack
          Xexit_169_symbol <= ack_171_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_complete/$exit
          type_cast_80_complete_167_symbol <= Xexit_169_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_80_complete
        binary_84_complete_172: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete 
          signal Xentry_173_symbol: Boolean;
          signal Xexit_174_symbol: Boolean;
          signal rr_175_symbol : Boolean;
          signal ra_176_symbol : Boolean;
          signal cr_177_symbol : Boolean;
          signal ca_178_symbol : Boolean;
          -- 
        begin -- 
          binary_84_complete_172_start <= binary_84_active_x_x162_symbol; -- control passed to block
          Xentry_173_symbol  <= binary_84_complete_172_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete/$entry
          rr_175_symbol <= Xentry_173_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete/rr
          binary_84_inst_req_0 <= rr_175_symbol; -- link to DP
          ra_176_symbol <= binary_84_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete/ra
          cr_177_symbol <= ra_176_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete/cr
          binary_84_inst_req_1 <= cr_177_symbol; -- link to DP
          ca_178_symbol <= binary_84_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete/ca
          Xexit_174_symbol <= ca_178_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete/$exit
          binary_84_complete_172_symbol <= Xexit_174_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_84_complete
        assign_stmt_91_active_x_x179_symbol <= binary_90_complete_184_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_91_active_
        assign_stmt_91_completed_x_x180_symbol <= assign_stmt_91_active_x_x179_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_91_completed_
        binary_90_active_x_x181_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_active_ 
          signal binary_90_active_x_x181_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_90_active_x_x181_predecessors(0) <= binary_90_trigger_x_x182_symbol;
          binary_90_active_x_x181_predecessors(1) <= simple_obj_ref_87_complete_183_symbol;
          binary_90_active_x_x181_join: join -- 
            port map( -- 
              preds => binary_90_active_x_x181_predecessors,
              symbol_out => binary_90_active_x_x181_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_active_
        binary_90_trigger_x_x182_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_trigger_
        simple_obj_ref_87_complete_183_symbol <= assign_stmt_70_completed_x_x137_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_87_complete
        binary_90_complete_184: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete 
          signal Xentry_185_symbol: Boolean;
          signal Xexit_186_symbol: Boolean;
          signal rr_187_symbol : Boolean;
          signal ra_188_symbol : Boolean;
          signal cr_189_symbol : Boolean;
          signal ca_190_symbol : Boolean;
          -- 
        begin -- 
          binary_90_complete_184_start <= binary_90_active_x_x181_symbol; -- control passed to block
          Xentry_185_symbol  <= binary_90_complete_184_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete/$entry
          rr_187_symbol <= Xentry_185_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete/rr
          binary_90_inst_req_0 <= rr_187_symbol; -- link to DP
          ra_188_symbol <= binary_90_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete/ra
          cr_189_symbol <= ra_188_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete/cr
          binary_90_inst_req_1 <= cr_189_symbol; -- link to DP
          ca_190_symbol <= binary_90_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete/ca
          Xexit_186_symbol <= ca_190_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete/$exit
          binary_90_complete_184_symbol <= Xexit_186_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_90_complete
        assign_stmt_97_active_x_x191_symbol <= binary_96_complete_196_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_97_active_
        assign_stmt_97_completed_x_x192_symbol <= assign_stmt_97_active_x_x191_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_97_completed_
        binary_96_active_x_x193_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_active_ 
          signal binary_96_active_x_x193_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_96_active_x_x193_predecessors(0) <= binary_96_trigger_x_x194_symbol;
          binary_96_active_x_x193_predecessors(1) <= simple_obj_ref_93_complete_195_symbol;
          binary_96_active_x_x193_join: join -- 
            port map( -- 
              preds => binary_96_active_x_x193_predecessors,
              symbol_out => binary_96_active_x_x193_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_active_
        binary_96_trigger_x_x194_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_trigger_
        simple_obj_ref_93_complete_195_symbol <= assign_stmt_91_completed_x_x180_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_93_complete
        binary_96_complete_196: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete 
          signal Xentry_197_symbol: Boolean;
          signal Xexit_198_symbol: Boolean;
          signal rr_199_symbol : Boolean;
          signal ra_200_symbol : Boolean;
          signal cr_201_symbol : Boolean;
          signal ca_202_symbol : Boolean;
          -- 
        begin -- 
          binary_96_complete_196_start <= binary_96_active_x_x193_symbol; -- control passed to block
          Xentry_197_symbol  <= binary_96_complete_196_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete/$entry
          rr_199_symbol <= Xentry_197_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete/rr
          binary_96_inst_req_0 <= rr_199_symbol; -- link to DP
          ra_200_symbol <= binary_96_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete/ra
          cr_201_symbol <= ra_200_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete/cr
          binary_96_inst_req_1 <= cr_201_symbol; -- link to DP
          ca_202_symbol <= binary_96_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete/ca
          Xexit_198_symbol <= ca_202_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete/$exit
          binary_96_complete_196_symbol <= Xexit_198_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_96_complete
        assign_stmt_103_active_x_x203_symbol <= binary_102_complete_208_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_103_active_
        assign_stmt_103_completed_x_x204_symbol <= assign_stmt_103_active_x_x203_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_103_completed_
        binary_102_active_x_x205_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_active_ 
          signal binary_102_active_x_x205_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_102_active_x_x205_predecessors(0) <= binary_102_trigger_x_x206_symbol;
          binary_102_active_x_x205_predecessors(1) <= simple_obj_ref_99_complete_207_symbol;
          binary_102_active_x_x205_join: join -- 
            port map( -- 
              preds => binary_102_active_x_x205_predecessors,
              symbol_out => binary_102_active_x_x205_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_active_
        binary_102_trigger_x_x206_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_trigger_
        simple_obj_ref_99_complete_207_symbol <= assign_stmt_70_completed_x_x137_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_99_complete
        binary_102_complete_208: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete 
          signal Xentry_209_symbol: Boolean;
          signal Xexit_210_symbol: Boolean;
          signal rr_211_symbol : Boolean;
          signal ra_212_symbol : Boolean;
          signal cr_213_symbol : Boolean;
          signal ca_214_symbol : Boolean;
          -- 
        begin -- 
          binary_102_complete_208_start <= binary_102_active_x_x205_symbol; -- control passed to block
          Xentry_209_symbol  <= binary_102_complete_208_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete/$entry
          rr_211_symbol <= Xentry_209_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete/rr
          binary_102_inst_req_0 <= rr_211_symbol; -- link to DP
          ra_212_symbol <= binary_102_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete/ra
          cr_213_symbol <= ra_212_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete/cr
          binary_102_inst_req_1 <= cr_213_symbol; -- link to DP
          ca_214_symbol <= binary_102_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete/ca
          Xexit_210_symbol <= ca_214_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete/$exit
          binary_102_complete_208_symbol <= Xexit_210_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_102_complete
        assign_stmt_109_active_x_x215_symbol <= ternary_108_complete_222_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_109_active_
        assign_stmt_109_completed_x_x216_symbol <= assign_stmt_109_active_x_x215_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_109_completed_
        ternary_108_trigger_x_x217_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_trigger_
        ternary_108_active_x_x218_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_active_ 
          signal ternary_108_active_x_x218_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          ternary_108_active_x_x218_predecessors(0) <= ternary_108_trigger_x_x217_symbol;
          ternary_108_active_x_x218_predecessors(1) <= simple_obj_ref_105_complete_219_symbol;
          ternary_108_active_x_x218_predecessors(2) <= simple_obj_ref_106_complete_220_symbol;
          ternary_108_active_x_x218_predecessors(3) <= simple_obj_ref_107_complete_221_symbol;
          ternary_108_active_x_x218_join: join -- 
            port map( -- 
              preds => ternary_108_active_x_x218_predecessors,
              symbol_out => ternary_108_active_x_x218_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_active_
        simple_obj_ref_105_complete_219_symbol <= assign_stmt_85_completed_x_x161_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_105_complete
        simple_obj_ref_106_complete_220_symbol <= assign_stmt_97_completed_x_x192_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_106_complete
        simple_obj_ref_107_complete_221_symbol <= assign_stmt_103_completed_x_x204_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_107_complete
        ternary_108_complete_222: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_complete 
          signal Xentry_223_symbol: Boolean;
          signal Xexit_224_symbol: Boolean;
          signal req_225_symbol : Boolean;
          signal ack_226_symbol : Boolean;
          -- 
        begin -- 
          ternary_108_complete_222_start <= ternary_108_active_x_x218_symbol; -- control passed to block
          Xentry_223_symbol  <= ternary_108_complete_222_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_complete/$entry
          req_225_symbol <= Xentry_223_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_complete/req
          ternary_108_inst_req_0 <= req_225_symbol; -- link to DP
          ack_226_symbol <= ternary_108_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_complete/ack
          Xexit_224_symbol <= ack_226_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_complete/$exit
          ternary_108_complete_222_symbol <= Xexit_224_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/ternary_108_complete
        assign_stmt_113_active_x_x227_symbol <= type_cast_112_complete_232_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_113_active_
        assign_stmt_113_completed_x_x228_symbol <= assign_stmt_113_active_x_x227_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_113_completed_
        type_cast_112_active_x_x229_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_active_ 
          signal type_cast_112_active_x_x229_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_112_active_x_x229_predecessors(0) <= type_cast_112_trigger_x_x230_symbol;
          type_cast_112_active_x_x229_predecessors(1) <= simple_obj_ref_111_complete_231_symbol;
          type_cast_112_active_x_x229_join: join -- 
            port map( -- 
              preds => type_cast_112_active_x_x229_predecessors,
              symbol_out => type_cast_112_active_x_x229_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_active_
        type_cast_112_trigger_x_x230_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_trigger_
        simple_obj_ref_111_complete_231_symbol <= assign_stmt_109_completed_x_x216_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_111_complete
        type_cast_112_complete_232: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_complete 
          signal Xentry_233_symbol: Boolean;
          signal Xexit_234_symbol: Boolean;
          signal req_235_symbol : Boolean;
          signal ack_236_symbol : Boolean;
          -- 
        begin -- 
          type_cast_112_complete_232_start <= type_cast_112_active_x_x229_symbol; -- control passed to block
          Xentry_233_symbol  <= type_cast_112_complete_232_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_complete/$entry
          req_235_symbol <= Xentry_233_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_complete/req
          type_cast_112_inst_req_0 <= req_235_symbol; -- link to DP
          ack_236_symbol <= type_cast_112_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_complete/ack
          Xexit_234_symbol <= ack_236_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_complete/$exit
          type_cast_112_complete_232_symbol <= Xexit_234_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/type_cast_112_complete
        assign_stmt_119_active_x_x237_symbol <= binary_118_complete_242_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_119_active_
        assign_stmt_119_completed_x_x238_symbol <= assign_stmt_119_active_x_x237_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_119_completed_
        binary_118_active_x_x239_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_active_ 
          signal binary_118_active_x_x239_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_118_active_x_x239_predecessors(0) <= binary_118_trigger_x_x240_symbol;
          binary_118_active_x_x239_predecessors(1) <= simple_obj_ref_115_complete_241_symbol;
          binary_118_active_x_x239_join: join -- 
            port map( -- 
              preds => binary_118_active_x_x239_predecessors,
              symbol_out => binary_118_active_x_x239_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_active_
        binary_118_trigger_x_x240_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_trigger_
        simple_obj_ref_115_complete_241_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_115_complete
        binary_118_complete_242: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete 
          signal Xentry_243_symbol: Boolean;
          signal Xexit_244_symbol: Boolean;
          signal rr_245_symbol : Boolean;
          signal ra_246_symbol : Boolean;
          signal cr_247_symbol : Boolean;
          signal ca_248_symbol : Boolean;
          -- 
        begin -- 
          binary_118_complete_242_start <= binary_118_active_x_x239_symbol; -- control passed to block
          Xentry_243_symbol  <= binary_118_complete_242_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete/$entry
          rr_245_symbol <= Xentry_243_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete/rr
          binary_118_inst_req_0 <= rr_245_symbol; -- link to DP
          ra_246_symbol <= binary_118_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete/ra
          cr_247_symbol <= ra_246_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete/cr
          binary_118_inst_req_1 <= cr_247_symbol; -- link to DP
          ca_248_symbol <= binary_118_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete/ca
          Xexit_244_symbol <= ca_248_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete/$exit
          binary_118_complete_242_symbol <= Xexit_244_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_118_complete
        assign_stmt_125_active_x_x249_symbol <= binary_124_complete_254_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_125_active_
        assign_stmt_125_completed_x_x250_symbol <= assign_stmt_125_active_x_x249_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_125_completed_
        binary_124_active_x_x251_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_active_ 
          signal binary_124_active_x_x251_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_124_active_x_x251_predecessors(0) <= binary_124_trigger_x_x252_symbol;
          binary_124_active_x_x251_predecessors(1) <= simple_obj_ref_121_complete_253_symbol;
          binary_124_active_x_x251_join: join -- 
            port map( -- 
              preds => binary_124_active_x_x251_predecessors,
              symbol_out => binary_124_active_x_x251_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_active_
        binary_124_trigger_x_x252_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_trigger_
        simple_obj_ref_121_complete_253_symbol <= assign_stmt_113_completed_x_x228_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_121_complete
        binary_124_complete_254: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete 
          signal Xentry_255_symbol: Boolean;
          signal Xexit_256_symbol: Boolean;
          signal rr_257_symbol : Boolean;
          signal ra_258_symbol : Boolean;
          signal cr_259_symbol : Boolean;
          signal ca_260_symbol : Boolean;
          -- 
        begin -- 
          binary_124_complete_254_start <= binary_124_active_x_x251_symbol; -- control passed to block
          Xentry_255_symbol  <= binary_124_complete_254_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete/$entry
          rr_257_symbol <= Xentry_255_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete/rr
          binary_124_inst_req_0 <= rr_257_symbol; -- link to DP
          ra_258_symbol <= binary_124_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete/ra
          cr_259_symbol <= ra_258_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete/cr
          binary_124_inst_req_1 <= cr_259_symbol; -- link to DP
          ca_260_symbol <= binary_124_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete/ca
          Xexit_256_symbol <= ca_260_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete/$exit
          binary_124_complete_254_symbol <= Xexit_256_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_124_complete
        assign_stmt_130_active_x_x261_symbol <= binary_129_complete_267_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_130_active_
        assign_stmt_130_completed_x_x262_symbol <= assign_stmt_130_active_x_x261_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/assign_stmt_130_completed_
        binary_129_active_x_x263_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_active_ 
          signal binary_129_active_x_x263_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_129_active_x_x263_predecessors(0) <= binary_129_trigger_x_x264_symbol;
          binary_129_active_x_x263_predecessors(1) <= simple_obj_ref_127_complete_265_symbol;
          binary_129_active_x_x263_predecessors(2) <= simple_obj_ref_128_complete_266_symbol;
          binary_129_active_x_x263_join: join -- 
            port map( -- 
              preds => binary_129_active_x_x263_predecessors,
              symbol_out => binary_129_active_x_x263_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_active_
        binary_129_trigger_x_x264_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_trigger_
        simple_obj_ref_127_complete_265_symbol <= assign_stmt_125_completed_x_x250_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_127_complete
        simple_obj_ref_128_complete_266_symbol <= assign_stmt_119_completed_x_x238_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/simple_obj_ref_128_complete
        binary_129_complete_267: Block -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete 
          signal Xentry_268_symbol: Boolean;
          signal Xexit_269_symbol: Boolean;
          signal rr_270_symbol : Boolean;
          signal ra_271_symbol : Boolean;
          signal cr_272_symbol : Boolean;
          signal ca_273_symbol : Boolean;
          -- 
        begin -- 
          binary_129_complete_267_start <= binary_129_active_x_x263_symbol; -- control passed to block
          Xentry_268_symbol  <= binary_129_complete_267_start; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete/$entry
          rr_270_symbol <= Xentry_268_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete/rr
          binary_129_inst_req_0 <= rr_270_symbol; -- link to DP
          ra_271_symbol <= binary_129_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete/ra
          cr_272_symbol <= ra_271_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete/cr
          binary_129_inst_req_1 <= cr_272_symbol; -- link to DP
          ca_273_symbol <= binary_129_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete/ca
          Xexit_269_symbol <= ca_273_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete/$exit
          binary_129_complete_267_symbol <= Xexit_269_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/binary_129_complete
        Xexit_101_symbol <= assign_stmt_130_completed_x_x262_symbol; -- transition branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130/$exit
        assign_stmt_54_to_assign_stmt_130_99_symbol <= Xexit_101_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_54_to_assign_stmt_130
      assign_stmt_145_274: Block -- branch_block_stmt_13/assign_stmt_145 
        signal Xentry_275_symbol: Boolean;
        signal Xexit_276_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_145_274_start <= assign_stmt_145_x_xentry_x_xx_x28_symbol; -- control passed to block
        Xentry_275_symbol  <= assign_stmt_145_274_start; -- transition branch_block_stmt_13/assign_stmt_145/$entry
        Xexit_276_symbol <= Xentry_275_symbol; -- transition branch_block_stmt_13/assign_stmt_145/$exit
        assign_stmt_145_274_symbol <= Xexit_276_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_145
      assign_stmt_148_277: Block -- branch_block_stmt_13/assign_stmt_148 
        signal Xentry_278_symbol: Boolean;
        signal Xexit_279_symbol: Boolean;
        signal assign_stmt_148_active_x_x280_symbol : Boolean;
        signal assign_stmt_148_completed_x_x281_symbol : Boolean;
        signal simple_obj_ref_147_complete_282_symbol : Boolean;
        signal simple_obj_ref_146_trigger_x_x283_symbol : Boolean;
        signal simple_obj_ref_146_complete_284_start : Boolean;
        signal simple_obj_ref_146_complete_284_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_148_277_start <= assign_stmt_148_x_xentry_x_xx_x30_symbol; -- control passed to block
        Xentry_278_symbol  <= assign_stmt_148_277_start; -- transition branch_block_stmt_13/assign_stmt_148/$entry
        assign_stmt_148_active_x_x280_symbol <= simple_obj_ref_147_complete_282_symbol; -- transition branch_block_stmt_13/assign_stmt_148/assign_stmt_148_active_
        assign_stmt_148_completed_x_x281_symbol <= simple_obj_ref_146_complete_284_symbol; -- transition branch_block_stmt_13/assign_stmt_148/assign_stmt_148_completed_
        simple_obj_ref_147_complete_282_symbol <= Xentry_278_symbol; -- transition branch_block_stmt_13/assign_stmt_148/simple_obj_ref_147_complete
        simple_obj_ref_146_trigger_x_x283_symbol <= assign_stmt_148_active_x_x280_symbol; -- transition branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_trigger_
        simple_obj_ref_146_complete_284: Block -- branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_complete 
          signal Xentry_285_symbol: Boolean;
          signal Xexit_286_symbol: Boolean;
          signal pipe_wreq_287_symbol : Boolean;
          signal pipe_wack_288_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_146_complete_284_start <= simple_obj_ref_146_trigger_x_x283_symbol; -- control passed to block
          Xentry_285_symbol  <= simple_obj_ref_146_complete_284_start; -- transition branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_complete/$entry
          pipe_wreq_287_symbol <= Xentry_285_symbol; -- transition branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_complete/pipe_wreq
          simple_obj_ref_146_inst_req_0 <= pipe_wreq_287_symbol; -- link to DP
          pipe_wack_288_symbol <= simple_obj_ref_146_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_complete/pipe_wack
          Xexit_286_symbol <= pipe_wack_288_symbol; -- transition branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_complete/$exit
          simple_obj_ref_146_complete_284_symbol <= Xexit_286_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_148/simple_obj_ref_146_complete
        Xexit_279_symbol <= assign_stmt_148_completed_x_x281_symbol; -- transition branch_block_stmt_13/assign_stmt_148/$exit
        assign_stmt_148_277_symbol <= Xexit_279_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_148
      assign_stmt_154_289: Block -- branch_block_stmt_13/assign_stmt_154 
        signal Xentry_290_symbol: Boolean;
        signal Xexit_291_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_154_289_start <= assign_stmt_154_x_xentry_x_xx_x32_symbol; -- control passed to block
        Xentry_290_symbol  <= assign_stmt_154_289_start; -- transition branch_block_stmt_13/assign_stmt_154/$entry
        Xexit_291_symbol <= Xentry_290_symbol; -- transition branch_block_stmt_13/assign_stmt_154/$exit
        assign_stmt_154_289_symbol <= Xexit_291_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_154
      assign_stmt_157_292: Block -- branch_block_stmt_13/assign_stmt_157 
        signal Xentry_293_symbol: Boolean;
        signal Xexit_294_symbol: Boolean;
        signal assign_stmt_157_active_x_x295_symbol : Boolean;
        signal assign_stmt_157_completed_x_x296_symbol : Boolean;
        signal simple_obj_ref_156_complete_297_symbol : Boolean;
        signal simple_obj_ref_155_trigger_x_x298_symbol : Boolean;
        signal simple_obj_ref_155_complete_299_start : Boolean;
        signal simple_obj_ref_155_complete_299_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_157_292_start <= assign_stmt_157_x_xentry_x_xx_x34_symbol; -- control passed to block
        Xentry_293_symbol  <= assign_stmt_157_292_start; -- transition branch_block_stmt_13/assign_stmt_157/$entry
        assign_stmt_157_active_x_x295_symbol <= simple_obj_ref_156_complete_297_symbol; -- transition branch_block_stmt_13/assign_stmt_157/assign_stmt_157_active_
        assign_stmt_157_completed_x_x296_symbol <= simple_obj_ref_155_complete_299_symbol; -- transition branch_block_stmt_13/assign_stmt_157/assign_stmt_157_completed_
        simple_obj_ref_156_complete_297_symbol <= Xentry_293_symbol; -- transition branch_block_stmt_13/assign_stmt_157/simple_obj_ref_156_complete
        simple_obj_ref_155_trigger_x_x298_symbol <= assign_stmt_157_active_x_x295_symbol; -- transition branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_trigger_
        simple_obj_ref_155_complete_299: Block -- branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_complete 
          signal Xentry_300_symbol: Boolean;
          signal Xexit_301_symbol: Boolean;
          signal pipe_wreq_302_symbol : Boolean;
          signal pipe_wack_303_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_155_complete_299_start <= simple_obj_ref_155_trigger_x_x298_symbol; -- control passed to block
          Xentry_300_symbol  <= simple_obj_ref_155_complete_299_start; -- transition branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_complete/$entry
          pipe_wreq_302_symbol <= Xentry_300_symbol; -- transition branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_complete/pipe_wreq
          simple_obj_ref_155_inst_req_0 <= pipe_wreq_302_symbol; -- link to DP
          pipe_wack_303_symbol <= simple_obj_ref_155_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_complete/pipe_wack
          Xexit_301_symbol <= pipe_wack_303_symbol; -- transition branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_complete/$exit
          simple_obj_ref_155_complete_299_symbol <= Xexit_301_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_157/simple_obj_ref_155_complete
        Xexit_294_symbol <= assign_stmt_157_completed_x_x296_symbol; -- transition branch_block_stmt_13/assign_stmt_157/$exit
        assign_stmt_157_292_symbol <= Xexit_294_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_157
      bb_0_bb_1_PhiReq_304: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal Xentry_305_symbol: Boolean;
        signal Xexit_306_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_304_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_305_symbol  <= bb_0_bb_1_PhiReq_304_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        Xexit_306_symbol <= Xentry_305_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_304_symbol <= Xexit_306_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_3_bb_1_PhiReq_307: Block -- branch_block_stmt_13/bb_3_bb_1_PhiReq 
        signal Xentry_308_symbol: Boolean;
        signal Xexit_309_symbol: Boolean;
        -- 
      begin -- 
        bb_3_bb_1_PhiReq_307_start <= bb_3_bb_1_36_symbol; -- control passed to block
        Xentry_308_symbol  <= bb_3_bb_1_PhiReq_307_start; -- transition branch_block_stmt_13/bb_3_bb_1_PhiReq/$entry
        Xexit_309_symbol <= Xentry_308_symbol; -- transition branch_block_stmt_13/bb_3_bb_1_PhiReq/$exit
        bb_3_bb_1_PhiReq_307_symbol <= Xexit_309_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_3_bb_1_PhiReq
      merge_stmt_15_PhiReqMerge_310_symbol  <=  bb_0_bb_1_PhiReq_304_symbol or bb_3_bb_1_PhiReq_307_symbol; -- place branch_block_stmt_13/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_311: Block -- branch_block_stmt_13/merge_stmt_15_PhiAck 
        signal Xentry_312_symbol: Boolean;
        signal Xexit_313_symbol: Boolean;
        signal dummy_314_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_311_start <= merge_stmt_15_PhiReqMerge_310_symbol; -- control passed to block
        Xentry_312_symbol  <= merge_stmt_15_PhiAck_311_start; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$entry
        dummy_314_symbol <= Xentry_312_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/dummy
        Xexit_313_symbol <= dummy_314_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_311_symbol <= Xexit_313_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_15_PhiAck
      merge_stmt_48_dead_link_315: Block -- branch_block_stmt_13/merge_stmt_48_dead_link 
        signal Xentry_316_symbol: Boolean;
        signal Xexit_317_symbol: Boolean;
        signal dead_transition_318_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_48_dead_link_315_start <= merge_stmt_48_x_xentry_x_xx_x22_symbol; -- control passed to block
        Xentry_316_symbol  <= merge_stmt_48_dead_link_315_start; -- transition branch_block_stmt_13/merge_stmt_48_dead_link/$entry
        dead_transition_318_symbol <= false;
        Xexit_317_symbol <= dead_transition_318_symbol; -- transition branch_block_stmt_13/merge_stmt_48_dead_link/$exit
        merge_stmt_48_dead_link_315_symbol <= Xexit_317_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_48_dead_link
      bb_1_bb_2_PhiReq_319: Block -- branch_block_stmt_13/bb_1_bb_2_PhiReq 
        signal Xentry_320_symbol: Boolean;
        signal Xexit_321_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_2_PhiReq_319_start <= bb_1_bb_2_97_symbol; -- control passed to block
        Xentry_320_symbol  <= bb_1_bb_2_PhiReq_319_start; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$entry
        Xexit_321_symbol <= Xentry_320_symbol; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$exit
        bb_1_bb_2_PhiReq_319_symbol <= Xexit_321_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_2_PhiReq
      merge_stmt_48_PhiReqMerge_322_symbol  <=  bb_1_bb_2_PhiReq_319_symbol; -- place branch_block_stmt_13/merge_stmt_48_PhiReqMerge (optimized away) 
      merge_stmt_48_PhiAck_323: Block -- branch_block_stmt_13/merge_stmt_48_PhiAck 
        signal Xentry_324_symbol: Boolean;
        signal Xexit_325_symbol: Boolean;
        signal dummy_326_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_48_PhiAck_323_start <= merge_stmt_48_PhiReqMerge_322_symbol; -- control passed to block
        Xentry_324_symbol  <= merge_stmt_48_PhiAck_323_start; -- transition branch_block_stmt_13/merge_stmt_48_PhiAck/$entry
        dummy_326_symbol <= Xentry_324_symbol; -- transition branch_block_stmt_13/merge_stmt_48_PhiAck/dummy
        Xexit_325_symbol <= dummy_326_symbol; -- transition branch_block_stmt_13/merge_stmt_48_PhiAck/$exit
        merge_stmt_48_PhiAck_323_symbol <= Xexit_325_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_48_PhiAck
      bb_1_bb_3_PhiReq_327: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq 
        signal Xentry_328_symbol: Boolean;
        signal Xexit_329_symbol: Boolean;
        signal phi_stmt_133_330_start : Boolean;
        signal phi_stmt_133_330_symbol : Boolean;
        -- 
      begin -- 
        bb_1_bb_3_PhiReq_327_start <= bb_1_bb_3_98_symbol; -- control passed to block
        Xentry_328_symbol  <= bb_1_bb_3_PhiReq_327_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/$entry
        phi_stmt_133_330: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133 
          signal Xentry_331_symbol: Boolean;
          signal Xexit_332_symbol: Boolean;
          signal phi_stmt_133_sources_333_start : Boolean;
          signal phi_stmt_133_sources_333_symbol : Boolean;
          signal phi_stmt_133_req_346_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_133_330_start <= Xentry_328_symbol; -- control passed to block
          Xentry_331_symbol  <= phi_stmt_133_330_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/$entry
          phi_stmt_133_sources_333: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources 
            signal Xentry_334_symbol: Boolean;
            signal Xexit_335_symbol: Boolean;
            signal type_cast_136_336_start : Boolean;
            signal type_cast_136_336_symbol : Boolean;
            signal type_cast_138_341_start : Boolean;
            signal type_cast_138_341_symbol : Boolean;
            -- 
          begin -- 
            phi_stmt_133_sources_333_start <= Xentry_331_symbol; -- control passed to block
            Xentry_334_symbol  <= phi_stmt_133_sources_333_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/$entry
            type_cast_136_336: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136 
              signal Xentry_337_symbol: Boolean;
              signal Xexit_338_symbol: Boolean;
              signal req_339_symbol : Boolean;
              signal ack_340_symbol : Boolean;
              -- 
            begin -- 
              type_cast_136_336_start <= Xentry_334_symbol; -- control passed to block
              Xentry_337_symbol  <= type_cast_136_336_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/$entry
              req_339_symbol <= Xentry_337_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/req
              ack_340_symbol <= req_339_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/ack
              Xexit_338_symbol <= ack_340_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/$exit
              type_cast_136_336_symbol <= Xexit_338_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136
            type_cast_138_341: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138 
              signal Xentry_342_symbol: Boolean;
              signal Xexit_343_symbol: Boolean;
              signal req_344_symbol : Boolean;
              signal ack_345_symbol : Boolean;
              -- 
            begin -- 
              type_cast_138_341_start <= Xentry_334_symbol; -- control passed to block
              Xentry_342_symbol  <= type_cast_138_341_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/$entry
              req_344_symbol <= Xentry_342_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/req
              type_cast_138_inst_req_0 <= req_344_symbol; -- link to DP
              ack_345_symbol <= type_cast_138_inst_ack_0; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/ack
              Xexit_343_symbol <= ack_345_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/$exit
              type_cast_138_341_symbol <= Xexit_343_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138
            Xexit_335_block : Block -- non-trivial join transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/$exit 
              signal Xexit_335_predecessors: BooleanArray(1 downto 0);
              -- 
            begin -- 
              Xexit_335_predecessors(0) <= type_cast_136_336_symbol;
              Xexit_335_predecessors(1) <= type_cast_138_341_symbol;
              Xexit_335_join: join -- 
                port map( -- 
                  preds => Xexit_335_predecessors,
                  symbol_out => Xexit_335_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/$exit
            phi_stmt_133_sources_333_symbol <= Xexit_335_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources
          phi_stmt_133_req_346_symbol <= phi_stmt_133_sources_333_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_req
          phi_stmt_133_req_1 <= phi_stmt_133_req_346_symbol; -- link to DP
          Xexit_332_symbol <= phi_stmt_133_req_346_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133/$exit
          phi_stmt_133_330_symbol <= Xexit_332_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_133
        Xexit_329_symbol <= phi_stmt_133_330_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/$exit
        bb_1_bb_3_PhiReq_327_symbol <= Xexit_329_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq
      bb_2_bb_3_PhiReq_347: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq 
        signal Xentry_348_symbol: Boolean;
        signal Xexit_349_symbol: Boolean;
        signal phi_stmt_133_350_start : Boolean;
        signal phi_stmt_133_350_symbol : Boolean;
        -- 
      begin -- 
        bb_2_bb_3_PhiReq_347_start <= bb_2_bb_3_26_symbol; -- control passed to block
        Xentry_348_symbol  <= bb_2_bb_3_PhiReq_347_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/$entry
        phi_stmt_133_350: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133 
          signal Xentry_351_symbol: Boolean;
          signal Xexit_352_symbol: Boolean;
          signal phi_stmt_133_sources_353_start : Boolean;
          signal phi_stmt_133_sources_353_symbol : Boolean;
          signal phi_stmt_133_req_366_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_133_350_start <= Xentry_348_symbol; -- control passed to block
          Xentry_351_symbol  <= phi_stmt_133_350_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/$entry
          phi_stmt_133_sources_353: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources 
            signal Xentry_354_symbol: Boolean;
            signal Xexit_355_symbol: Boolean;
            signal type_cast_136_356_start : Boolean;
            signal type_cast_136_356_symbol : Boolean;
            signal type_cast_138_361_start : Boolean;
            signal type_cast_138_361_symbol : Boolean;
            -- 
          begin -- 
            phi_stmt_133_sources_353_start <= Xentry_351_symbol; -- control passed to block
            Xentry_354_symbol  <= phi_stmt_133_sources_353_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/$entry
            type_cast_136_356: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136 
              signal Xentry_357_symbol: Boolean;
              signal Xexit_358_symbol: Boolean;
              signal req_359_symbol : Boolean;
              signal ack_360_symbol : Boolean;
              -- 
            begin -- 
              type_cast_136_356_start <= Xentry_354_symbol; -- control passed to block
              Xentry_357_symbol  <= type_cast_136_356_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/$entry
              req_359_symbol <= Xentry_357_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/req
              type_cast_136_inst_req_0 <= req_359_symbol; -- link to DP
              ack_360_symbol <= type_cast_136_inst_ack_0; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/ack
              Xexit_358_symbol <= ack_360_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136/$exit
              type_cast_136_356_symbol <= Xexit_358_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_136
            type_cast_138_361: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138 
              signal Xentry_362_symbol: Boolean;
              signal Xexit_363_symbol: Boolean;
              signal req_364_symbol : Boolean;
              signal ack_365_symbol : Boolean;
              -- 
            begin -- 
              type_cast_138_361_start <= Xentry_354_symbol; -- control passed to block
              Xentry_362_symbol  <= type_cast_138_361_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/$entry
              req_364_symbol <= Xentry_362_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/req
              ack_365_symbol <= req_364_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/ack
              Xexit_363_symbol <= ack_365_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138/$exit
              type_cast_138_361_symbol <= Xexit_363_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/type_cast_138
            Xexit_355_block : Block -- non-trivial join transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/$exit 
              signal Xexit_355_predecessors: BooleanArray(1 downto 0);
              -- 
            begin -- 
              Xexit_355_predecessors(0) <= type_cast_136_356_symbol;
              Xexit_355_predecessors(1) <= type_cast_138_361_symbol;
              Xexit_355_join: join -- 
                port map( -- 
                  preds => Xexit_355_predecessors,
                  symbol_out => Xexit_355_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources/$exit
            phi_stmt_133_sources_353_symbol <= Xexit_355_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_sources
          phi_stmt_133_req_366_symbol <= phi_stmt_133_sources_353_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/phi_stmt_133_req
          phi_stmt_133_req_0 <= phi_stmt_133_req_366_symbol; -- link to DP
          Xexit_352_symbol <= phi_stmt_133_req_366_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133/$exit
          phi_stmt_133_350_symbol <= Xexit_352_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_133
        Xexit_349_symbol <= phi_stmt_133_350_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/$exit
        bb_2_bb_3_PhiReq_347_symbol <= Xexit_349_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq
      merge_stmt_132_PhiReqMerge_367_symbol  <=  bb_1_bb_3_PhiReq_327_symbol or bb_2_bb_3_PhiReq_347_symbol; -- place branch_block_stmt_13/merge_stmt_132_PhiReqMerge (optimized away) 
      merge_stmt_132_PhiAck_368: Block -- branch_block_stmt_13/merge_stmt_132_PhiAck 
        signal Xentry_369_symbol: Boolean;
        signal Xexit_370_symbol: Boolean;
        signal phi_stmt_133_ack_371_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_132_PhiAck_368_start <= merge_stmt_132_PhiReqMerge_367_symbol; -- control passed to block
        Xentry_369_symbol  <= merge_stmt_132_PhiAck_368_start; -- transition branch_block_stmt_13/merge_stmt_132_PhiAck/$entry
        phi_stmt_133_ack_371_symbol <= phi_stmt_133_ack_0; -- transition branch_block_stmt_13/merge_stmt_132_PhiAck/phi_stmt_133_ack
        Xexit_370_symbol <= phi_stmt_133_ack_371_symbol; -- transition branch_block_stmt_13/merge_stmt_132_PhiAck/$exit
        merge_stmt_132_PhiAck_368_symbol <= Xexit_370_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_132_PhiAck
      Xexit_5_symbol <= branch_block_stmt_13_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_13/$exit
      branch_block_stmt_13_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_13
    Xexit_2_symbol <= branch_block_stmt_13_3_symbol; -- transition $exit
    fin_ack_symbol_join : Block -- non-trivial join transition fin_ack_symbol 
      signal fin_ack_symbol_predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      fin_ack_symbol_predecessors <= Xexit_2_symbol & fin_req_symbol;
      fin_ack_symbol_join_instance: join -- 
        port map( -- 
          clk => clk, reset => reset, 
          preds => fin_ack_symbol_predecessors,
          symbol_out => fin_ack_symbol); -- 
      end block; --
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal datax_x0_133 : std_logic_vector(63 downto 0);
    signal iNsTr_10_76 : std_logic_vector(63 downto 0);
    signal iNsTr_11_85 : std_logic_vector(0 downto 0);
    signal iNsTr_12_91 : std_logic_vector(31 downto 0);
    signal iNsTr_13_97 : std_logic_vector(31 downto 0);
    signal iNsTr_14_103 : std_logic_vector(31 downto 0);
    signal iNsTr_15_109 : std_logic_vector(31 downto 0);
    signal iNsTr_16_113 : std_logic_vector(63 downto 0);
    signal iNsTr_17_119 : std_logic_vector(63 downto 0);
    signal iNsTr_18_125 : std_logic_vector(63 downto 0);
    signal iNsTr_19_130 : std_logic_vector(63 downto 0);
    signal iNsTr_1_22 : std_logic_vector(31 downto 0);
    signal iNsTr_21_145 : std_logic_vector(31 downto 0);
    signal iNsTr_23_154 : std_logic_vector(31 downto 0);
    signal iNsTr_2_25 : std_logic_vector(7 downto 0);
    signal iNsTr_3_31 : std_logic_vector(31 downto 0);
    signal iNsTr_4_34 : std_logic_vector(63 downto 0);
    signal iNsTr_5_41 : std_logic_vector(0 downto 0);
    signal iNsTr_7_54 : std_logic_vector(63 downto 0);
    signal iNsTr_8_64 : std_logic_vector(31 downto 0);
    signal iNsTr_9_70 : std_logic_vector(31 downto 0);
    signal tmp_58 : std_logic_vector(31 downto 0);
    signal type_cast_101_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_117_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_123_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_136_wire : std_logic_vector(63 downto 0);
    signal type_cast_138_wire : std_logic_vector(63 downto 0);
    signal type_cast_38_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_52_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_62_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_67_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_74_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_80_wire : std_logic_vector(63 downto 0);
    signal type_cast_83_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_89_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_95_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    iNsTr_1_22 <= "00000000000000000000000000000000";
    iNsTr_21_145 <= "00000000000000000000000000000000";
    iNsTr_23_154 <= "00000000000000000000000000000000";
    iNsTr_3_31 <= "00000000000000000000000000000000";
    type_cast_101_wire_constant <= "00000000000000000000000000000001";
    type_cast_117_wire_constant <= "0000000000000000111111111111111111111111111111111111111111111111";
    type_cast_123_wire_constant <= "0000000000000000000000000000000000000000000000000000000000110000";
    type_cast_38_wire_constant <= "11111111";
    type_cast_52_wire_constant <= "0000000000000000000000000000000000000000000000000000000000010000";
    type_cast_62_wire_constant <= "00000000000000001111111111111111";
    type_cast_67_wire_constant <= "00000000000000000000000000000001";
    type_cast_74_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000001";
    type_cast_83_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000000";
    type_cast_89_wire_constant <= "00000000000000000000000000000001";
    type_cast_95_wire_constant <= "00000000000000000111111111111111";
    phi_stmt_133: Block -- phi operator 
      signal idata: std_logic_vector(127 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_136_wire & type_cast_138_wire;
      req <= phi_stmt_133_req_0 & phi_stmt_133_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 64) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_133_ack_0,
          idata => idata,
          odata => datax_x0_133,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_133
    ternary_108_inst: SelectBase generic map(data_width => 32) -- 
      port map( x => iNsTr_13_97, y => iNsTr_14_103, sel => iNsTr_11_85, z => iNsTr_15_109, req => ternary_108_inst_req_0, ack => ternary_108_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_112_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 64, flow_through => false ) 
      port map( din => iNsTr_15_109, dout => iNsTr_16_113, req => type_cast_112_inst_req_0, ack => type_cast_112_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_136_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_19_130, dout => type_cast_136_wire, req => type_cast_136_inst_req_0, ack => type_cast_136_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_138_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_4_34, dout => type_cast_138_wire, req => type_cast_138_inst_req_0, ack => type_cast_138_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_57_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_7_54, dout => tmp_58, req => type_cast_57_inst_req_0, ack => type_cast_57_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_80_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_10_76, dout => type_cast_80_wire, req => type_cast_80_inst_req_0, ack => type_cast_80_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_42_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_5_41;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_42_branch_req_0,
          ack0 => if_stmt_42_branch_ack_0,
          ack1 => if_stmt_42_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_102_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_70;
      iNsTr_14_103 <= data_out(31 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_102_inst_req_0,
          ackL => binary_102_inst_ack_0,
          reqR => binary_102_inst_req_1,
          ackR => binary_102_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_118_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_34;
      iNsTr_17_119 <= data_out(63 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_118_inst_req_0,
          ackL => binary_118_inst_ack_0,
          reqR => binary_118_inst_req_1,
          ackR => binary_118_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_124_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_16_113;
      iNsTr_18_125 <= data_out(63 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_124_inst_req_0,
          ackL => binary_124_inst_ack_0,
          reqR => binary_124_inst_req_1,
          ackR => binary_124_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_129_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_18_125 & iNsTr_17_119;
      iNsTr_19_130 <= data_out(63 downto 0);
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
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_129_inst_req_0,
          ackL => binary_129_inst_ack_0,
          reqR => binary_129_inst_req_1,
          ackR => binary_129_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_39_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_25;
      iNsTr_5_41 <= data_out(0 downto 0);
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
          constant_width => 8,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_39_inst_req_0,
          ackL => binary_39_inst_ack_0,
          reqR => binary_39_inst_req_1,
          ackR => binary_39_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_53_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_34;
      iNsTr_7_54 <= data_out(63 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_53_inst_req_0,
          ackL => binary_53_inst_ack_0,
          reqR => binary_53_inst_req_1,
          ackR => binary_53_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_63_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp_58;
      iNsTr_8_64 <= data_out(31 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_63_inst_req_0,
          ackL => binary_63_inst_ack_0,
          reqR => binary_63_inst_req_1,
          ackR => binary_63_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_69_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_67_wire_constant & iNsTr_8_64;
      iNsTr_9_70 <= data_out(31 downto 0);
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
          constant_width => 1,
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_69_inst_req_0,
          ackL => binary_69_inst_ack_0,
          reqR => binary_69_inst_req_1,
          ackR => binary_69_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_75_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_7_54;
      iNsTr_10_76 <= data_out(63 downto 0);
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
          constant_operand => "0000000000000000000000000000000000000000000000000000000000000001",
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_75_inst_req_0,
          ackL => binary_75_inst_ack_0,
          reqR => binary_75_inst_req_1,
          ackR => binary_75_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_84_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_80_wire;
      iNsTr_11_85 <= data_out(0 downto 0);
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
          constant_width => 64,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_84_inst_req_0,
          ackL => binary_84_inst_ack_0,
          reqR => binary_84_inst_req_1,
          ackR => binary_84_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_90_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_70;
      iNsTr_12_91 <= data_out(31 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_90_inst_req_0,
          ackL => binary_90_inst_ack_0,
          reqR => binary_90_inst_req_1,
          ackR => binary_90_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_96_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_91;
      iNsTr_13_97 <= data_out(31 downto 0);
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
          constant_width => 32,
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_96_inst_req_0,
          ackL => binary_96_inst_ack_0,
          reqR => binary_96_inst_req_1,
          ackR => binary_96_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared inport operator group (0) : simple_obj_ref_24_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_24_inst_req_0;
      simple_obj_ref_24_inst_ack_0 <= ack(0);
      iNsTr_2_25 <= data_out(7 downto 0);
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
    -- shared inport operator group (1) : simple_obj_ref_33_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_33_inst_req_0;
      simple_obj_ref_33_inst_ack_0 <= ack(0);
      iNsTr_4_34 <= data_out(63 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_146_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_146_inst_req_0;
      simple_obj_ref_146_inst_ack_0 <= ack(0);
      data_in <= iNsTr_2_25;
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
    -- shared outport operator group (1) : simple_obj_ref_155_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_155_inst_req_0;
      simple_obj_ref_155_inst_ack_0 <= ack(0);
      data_in <= datax_x0_133;
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
  -- interface signals to connect to memory space memory_space_0
  -- interface signals to connect to memory space memory_space_1
  -- interface signals to connect to memory space memory_space_2
  -- interface signals to connect to memory space memory_space_3
  -- declarations related to module output_port_lookup
  component output_port_lookup is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
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
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module output_port_lookup
  signal output_port_lookup_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal output_port_lookup_tag_out   : std_logic_vector(0 downto 0);
  signal output_port_lookup_start_req : std_logic;
  signal output_port_lookup_start_ack : std_logic;
  signal output_port_lookup_fin_req   : std_logic;
  signal output_port_lookup_fin_ack : std_logic;
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
    generic map(tag_length => 1)
    port map(-- 
      start_req => output_port_lookup_start_req,
      start_ack => output_port_lookup_start_ack,
      fin_req => output_port_lookup_fin_req,
      fin_ack => output_port_lookup_fin_ack,
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
  output_port_lookup_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => output_port_lookup_start_req, start_ack => output_port_lookup_start_ack,  fin_req => output_port_lookup_fin_req,  fin_ack => output_port_lookup_fin_ack);
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
