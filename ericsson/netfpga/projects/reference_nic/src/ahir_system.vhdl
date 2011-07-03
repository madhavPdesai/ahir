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
  signal simple_obj_ref_17_inst_req_0 : boolean;
  signal simple_obj_ref_17_inst_ack_0 : boolean;
  signal binary_26_inst_req_0 : boolean;
  signal binary_26_inst_ack_0 : boolean;
  signal binary_26_inst_req_1 : boolean;
  signal binary_26_inst_ack_1 : boolean;
  signal if_stmt_29_branch_req_0 : boolean;
  signal if_stmt_29_branch_ack_1 : boolean;
  signal if_stmt_29_branch_ack_0 : boolean;
  signal simple_obj_ref_20_inst_req_0 : boolean;
  signal simple_obj_ref_20_inst_ack_0 : boolean;
  signal binary_40_inst_req_0 : boolean;
  signal binary_40_inst_ack_0 : boolean;
  signal binary_40_inst_req_1 : boolean;
  signal binary_40_inst_ack_1 : boolean;
  signal type_cast_45_inst_req_0 : boolean;
  signal type_cast_45_inst_ack_0 : boolean;
  signal binary_51_inst_req_0 : boolean;
  signal binary_51_inst_ack_0 : boolean;
  signal binary_51_inst_req_1 : boolean;
  signal binary_51_inst_ack_1 : boolean;
  signal binary_57_inst_req_0 : boolean;
  signal binary_57_inst_ack_0 : boolean;
  signal binary_57_inst_req_1 : boolean;
  signal binary_57_inst_ack_1 : boolean;
  signal binary_63_inst_req_0 : boolean;
  signal binary_63_inst_ack_0 : boolean;
  signal binary_63_inst_req_1 : boolean;
  signal binary_63_inst_ack_1 : boolean;
  signal type_cast_68_inst_req_0 : boolean;
  signal type_cast_68_inst_ack_0 : boolean;
  signal binary_72_inst_req_0 : boolean;
  signal binary_72_inst_ack_0 : boolean;
  signal binary_72_inst_req_1 : boolean;
  signal binary_72_inst_ack_1 : boolean;
  signal binary_78_inst_req_0 : boolean;
  signal binary_78_inst_ack_0 : boolean;
  signal binary_78_inst_req_1 : boolean;
  signal binary_78_inst_ack_1 : boolean;
  signal binary_84_inst_req_0 : boolean;
  signal binary_84_inst_ack_0 : boolean;
  signal binary_84_inst_req_1 : boolean;
  signal binary_84_inst_ack_1 : boolean;
  signal binary_90_inst_req_0 : boolean;
  signal binary_90_inst_ack_0 : boolean;
  signal binary_90_inst_req_1 : boolean;
  signal binary_90_inst_ack_1 : boolean;
  signal ternary_96_inst_req_0 : boolean;
  signal ternary_96_inst_ack_0 : boolean;
  signal type_cast_100_inst_req_0 : boolean;
  signal type_cast_100_inst_ack_0 : boolean;
  signal binary_106_inst_req_0 : boolean;
  signal binary_106_inst_ack_0 : boolean;
  signal binary_106_inst_req_1 : boolean;
  signal binary_106_inst_ack_1 : boolean;
  signal binary_112_inst_req_0 : boolean;
  signal binary_112_inst_ack_0 : boolean;
  signal binary_112_inst_req_1 : boolean;
  signal binary_112_inst_ack_1 : boolean;
  signal binary_117_inst_req_0 : boolean;
  signal binary_117_inst_ack_0 : boolean;
  signal binary_117_inst_req_1 : boolean;
  signal binary_117_inst_ack_1 : boolean;
  signal simple_obj_ref_128_inst_req_0 : boolean;
  signal simple_obj_ref_128_inst_ack_0 : boolean;
  signal simple_obj_ref_131_inst_req_0 : boolean;
  signal simple_obj_ref_131_inst_ack_0 : boolean;
  signal type_cast_126_inst_req_0 : boolean;
  signal type_cast_126_inst_ack_0 : boolean;
  signal phi_stmt_121_req_1 : boolean;
  signal type_cast_124_inst_req_0 : boolean;
  signal type_cast_124_inst_ack_0 : boolean;
  signal phi_stmt_121_req_0 : boolean;
  signal phi_stmt_121_ack_0 : boolean;
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
      signal assign_stmt_18_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_18_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_21_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_21_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_28_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_28_x_xexit_x_xx_x15_symbol : Boolean;
      signal if_stmt_29_x_xentry_x_xx_x16_symbol : Boolean;
      signal if_stmt_29_x_xexit_x_xx_x17_symbol : Boolean;
      signal merge_stmt_35_x_xentry_x_xx_x18_symbol : Boolean;
      signal merge_stmt_35_x_xexit_x_xx_x19_symbol : Boolean;
      signal assign_stmt_41_to_assign_stmt_118_x_xentry_x_xx_x20_symbol : Boolean;
      signal assign_stmt_41_to_assign_stmt_118_x_xexit_x_xx_x21_symbol : Boolean;
      signal bb_2_bb_3_22_symbol : Boolean;
      signal merge_stmt_120_x_xexit_x_xx_x23_symbol : Boolean;
      signal assign_stmt_130_x_xentry_x_xx_x24_symbol : Boolean;
      signal assign_stmt_130_x_xexit_x_xx_x25_symbol : Boolean;
      signal assign_stmt_133_x_xentry_x_xx_x26_symbol : Boolean;
      signal assign_stmt_133_x_xexit_x_xx_x27_symbol : Boolean;
      signal bb_3_bb_1_28_symbol : Boolean;
      signal assign_stmt_18_29_symbol : Boolean;
      signal assign_stmt_21_40_symbol : Boolean;
      signal assign_stmt_28_51_symbol : Boolean;
      signal if_stmt_29_dead_link_66_symbol : Boolean;
      signal if_stmt_29_eval_test_70_symbol : Boolean;
      signal simple_obj_ref_30_place_74_symbol : Boolean;
      signal if_stmt_29_if_link_75_symbol : Boolean;
      signal if_stmt_29_else_link_79_symbol : Boolean;
      signal bb_1_bb_2_83_symbol : Boolean;
      signal bb_1_bb_3_84_symbol : Boolean;
      signal assign_stmt_41_to_assign_stmt_118_85_symbol : Boolean;
      signal assign_stmt_130_260_symbol : Boolean;
      signal assign_stmt_133_272_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_284_symbol : Boolean;
      signal bb_3_bb_1_PhiReq_287_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_290_symbol : Boolean;
      signal merge_stmt_15_PhiAck_291_symbol : Boolean;
      signal merge_stmt_35_dead_link_295_symbol : Boolean;
      signal bb_1_bb_2_PhiReq_299_symbol : Boolean;
      signal merge_stmt_35_PhiReqMerge_302_symbol : Boolean;
      signal merge_stmt_35_PhiAck_303_symbol : Boolean;
      signal bb_1_bb_3_PhiReq_307_symbol : Boolean;
      signal bb_2_bb_3_PhiReq_324_symbol : Boolean;
      signal merge_stmt_120_PhiReqMerge_341_symbol : Boolean;
      signal merge_stmt_120_PhiAck_342_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x9_symbol  <=  merge_stmt_15_PhiAck_291_symbol; -- place branch_block_stmt_13/merge_stmt_15__exit__ (optimized away) 
      assign_stmt_18_x_xentry_x_xx_x10_symbol  <=  merge_stmt_15_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/assign_stmt_18__entry__ (optimized away) 
      assign_stmt_18_x_xexit_x_xx_x11_symbol  <=  assign_stmt_18_29_symbol; -- place branch_block_stmt_13/assign_stmt_18__exit__ (optimized away) 
      assign_stmt_21_x_xentry_x_xx_x12_symbol  <=  assign_stmt_18_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_21__entry__ (optimized away) 
      assign_stmt_21_x_xexit_x_xx_x13_symbol  <=  assign_stmt_21_40_symbol; -- place branch_block_stmt_13/assign_stmt_21__exit__ (optimized away) 
      assign_stmt_28_x_xentry_x_xx_x14_symbol  <=  assign_stmt_21_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/assign_stmt_28__entry__ (optimized away) 
      assign_stmt_28_x_xexit_x_xx_x15_symbol  <=  assign_stmt_28_51_symbol; -- place branch_block_stmt_13/assign_stmt_28__exit__ (optimized away) 
      if_stmt_29_x_xentry_x_xx_x16_symbol  <=  assign_stmt_28_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_13/if_stmt_29__entry__ (optimized away) 
      if_stmt_29_x_xexit_x_xx_x17_symbol  <=  if_stmt_29_dead_link_66_symbol; -- place branch_block_stmt_13/if_stmt_29__exit__ (optimized away) 
      merge_stmt_35_x_xentry_x_xx_x18_symbol  <=  if_stmt_29_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_13/merge_stmt_35__entry__ (optimized away) 
      merge_stmt_35_x_xexit_x_xx_x19_symbol  <=  merge_stmt_35_dead_link_295_symbol or merge_stmt_35_PhiAck_303_symbol; -- place branch_block_stmt_13/merge_stmt_35__exit__ (optimized away) 
      assign_stmt_41_to_assign_stmt_118_x_xentry_x_xx_x20_symbol  <=  merge_stmt_35_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118__entry__ (optimized away) 
      assign_stmt_41_to_assign_stmt_118_x_xexit_x_xx_x21_symbol  <=  assign_stmt_41_to_assign_stmt_118_85_symbol; -- place branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118__exit__ (optimized away) 
      bb_2_bb_3_22_symbol  <=  assign_stmt_41_to_assign_stmt_118_x_xexit_x_xx_x21_symbol; -- place branch_block_stmt_13/bb_2_bb_3 (optimized away) 
      merge_stmt_120_x_xexit_x_xx_x23_symbol  <=  merge_stmt_120_PhiAck_342_symbol; -- place branch_block_stmt_13/merge_stmt_120__exit__ (optimized away) 
      assign_stmt_130_x_xentry_x_xx_x24_symbol  <=  merge_stmt_120_x_xexit_x_xx_x23_symbol; -- place branch_block_stmt_13/assign_stmt_130__entry__ (optimized away) 
      assign_stmt_130_x_xexit_x_xx_x25_symbol  <=  assign_stmt_130_260_symbol; -- place branch_block_stmt_13/assign_stmt_130__exit__ (optimized away) 
      assign_stmt_133_x_xentry_x_xx_x26_symbol  <=  assign_stmt_130_x_xexit_x_xx_x25_symbol; -- place branch_block_stmt_13/assign_stmt_133__entry__ (optimized away) 
      assign_stmt_133_x_xexit_x_xx_x27_symbol  <=  assign_stmt_133_272_symbol; -- place branch_block_stmt_13/assign_stmt_133__exit__ (optimized away) 
      bb_3_bb_1_28_symbol  <=  assign_stmt_133_x_xexit_x_xx_x27_symbol; -- place branch_block_stmt_13/bb_3_bb_1 (optimized away) 
      assign_stmt_18_29: Block -- branch_block_stmt_13/assign_stmt_18 
        signal assign_stmt_18_29_start: Boolean;
        signal Xentry_30_symbol: Boolean;
        signal Xexit_31_symbol: Boolean;
        signal assign_stmt_18_active_x_x32_symbol : Boolean;
        signal assign_stmt_18_completed_x_x33_symbol : Boolean;
        signal simple_obj_ref_17_trigger_x_x34_symbol : Boolean;
        signal simple_obj_ref_17_complete_35_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_18_29_start <= assign_stmt_18_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_30_symbol  <= assign_stmt_18_29_start; -- transition branch_block_stmt_13/assign_stmt_18/$entry
        assign_stmt_18_active_x_x32_symbol <= simple_obj_ref_17_complete_35_symbol; -- transition branch_block_stmt_13/assign_stmt_18/assign_stmt_18_active_
        assign_stmt_18_completed_x_x33_symbol <= assign_stmt_18_active_x_x32_symbol; -- transition branch_block_stmt_13/assign_stmt_18/assign_stmt_18_completed_
        simple_obj_ref_17_trigger_x_x34_symbol <= Xentry_30_symbol; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_trigger_
        simple_obj_ref_17_complete_35: Block -- branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete 
          signal simple_obj_ref_17_complete_35_start: Boolean;
          signal Xentry_36_symbol: Boolean;
          signal Xexit_37_symbol: Boolean;
          signal req_38_symbol : Boolean;
          signal ack_39_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_17_complete_35_start <= simple_obj_ref_17_trigger_x_x34_symbol; -- control passed to block
          Xentry_36_symbol  <= simple_obj_ref_17_complete_35_start; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/$entry
          req_38_symbol <= Xentry_36_symbol; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/req
          simple_obj_ref_17_inst_req_0 <= req_38_symbol; -- link to DP
          ack_39_symbol <= simple_obj_ref_17_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/ack
          Xexit_37_symbol <= ack_39_symbol; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/$exit
          simple_obj_ref_17_complete_35_symbol <= Xexit_37_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete
        Xexit_31_symbol <= assign_stmt_18_completed_x_x33_symbol; -- transition branch_block_stmt_13/assign_stmt_18/$exit
        assign_stmt_18_29_symbol <= Xexit_31_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_18
      assign_stmt_21_40: Block -- branch_block_stmt_13/assign_stmt_21 
        signal assign_stmt_21_40_start: Boolean;
        signal Xentry_41_symbol: Boolean;
        signal Xexit_42_symbol: Boolean;
        signal assign_stmt_21_active_x_x43_symbol : Boolean;
        signal assign_stmt_21_completed_x_x44_symbol : Boolean;
        signal simple_obj_ref_20_trigger_x_x45_symbol : Boolean;
        signal simple_obj_ref_20_complete_46_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_21_40_start <= assign_stmt_21_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_41_symbol  <= assign_stmt_21_40_start; -- transition branch_block_stmt_13/assign_stmt_21/$entry
        assign_stmt_21_active_x_x43_symbol <= simple_obj_ref_20_complete_46_symbol; -- transition branch_block_stmt_13/assign_stmt_21/assign_stmt_21_active_
        assign_stmt_21_completed_x_x44_symbol <= assign_stmt_21_active_x_x43_symbol; -- transition branch_block_stmt_13/assign_stmt_21/assign_stmt_21_completed_
        simple_obj_ref_20_trigger_x_x45_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_trigger_
        simple_obj_ref_20_complete_46: Block -- branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete 
          signal simple_obj_ref_20_complete_46_start: Boolean;
          signal Xentry_47_symbol: Boolean;
          signal Xexit_48_symbol: Boolean;
          signal req_49_symbol : Boolean;
          signal ack_50_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_20_complete_46_start <= simple_obj_ref_20_trigger_x_x45_symbol; -- control passed to block
          Xentry_47_symbol  <= simple_obj_ref_20_complete_46_start; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete/$entry
          req_49_symbol <= Xentry_47_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete/req
          simple_obj_ref_20_inst_req_0 <= req_49_symbol; -- link to DP
          ack_50_symbol <= simple_obj_ref_20_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete/ack
          Xexit_48_symbol <= ack_50_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete/$exit
          simple_obj_ref_20_complete_46_symbol <= Xexit_48_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete
        Xexit_42_symbol <= assign_stmt_21_completed_x_x44_symbol; -- transition branch_block_stmt_13/assign_stmt_21/$exit
        assign_stmt_21_40_symbol <= Xexit_42_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_21
      assign_stmt_28_51: Block -- branch_block_stmt_13/assign_stmt_28 
        signal assign_stmt_28_51_start: Boolean;
        signal Xentry_52_symbol: Boolean;
        signal Xexit_53_symbol: Boolean;
        signal assign_stmt_28_active_x_x54_symbol : Boolean;
        signal assign_stmt_28_completed_x_x55_symbol : Boolean;
        signal binary_26_active_x_x56_symbol : Boolean;
        signal binary_26_trigger_x_x57_symbol : Boolean;
        signal simple_obj_ref_23_complete_58_symbol : Boolean;
        signal binary_26_complete_59_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_28_51_start <= assign_stmt_28_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_52_symbol  <= assign_stmt_28_51_start; -- transition branch_block_stmt_13/assign_stmt_28/$entry
        assign_stmt_28_active_x_x54_symbol <= binary_26_complete_59_symbol; -- transition branch_block_stmt_13/assign_stmt_28/assign_stmt_28_active_
        assign_stmt_28_completed_x_x55_symbol <= assign_stmt_28_active_x_x54_symbol; -- transition branch_block_stmt_13/assign_stmt_28/assign_stmt_28_completed_
        binary_26_active_x_x56_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_28/binary_26_active_ 
          signal binary_26_active_x_x56_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_26_active_x_x56_predecessors(0) <= binary_26_trigger_x_x57_symbol;
          binary_26_active_x_x56_predecessors(1) <= simple_obj_ref_23_complete_58_symbol;
          binary_26_active_x_x56_join: join -- 
            port map( -- 
              preds => binary_26_active_x_x56_predecessors,
              symbol_out => binary_26_active_x_x56_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_28/binary_26_active_
        binary_26_trigger_x_x57_symbol <= Xentry_52_symbol; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_trigger_
        simple_obj_ref_23_complete_58_symbol <= Xentry_52_symbol; -- transition branch_block_stmt_13/assign_stmt_28/simple_obj_ref_23_complete
        binary_26_complete_59: Block -- branch_block_stmt_13/assign_stmt_28/binary_26_complete 
          signal binary_26_complete_59_start: Boolean;
          signal Xentry_60_symbol: Boolean;
          signal Xexit_61_symbol: Boolean;
          signal rr_62_symbol : Boolean;
          signal ra_63_symbol : Boolean;
          signal cr_64_symbol : Boolean;
          signal ca_65_symbol : Boolean;
          -- 
        begin -- 
          binary_26_complete_59_start <= binary_26_active_x_x56_symbol; -- control passed to block
          Xentry_60_symbol  <= binary_26_complete_59_start; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_complete/$entry
          rr_62_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_complete/rr
          binary_26_inst_req_0 <= rr_62_symbol; -- link to DP
          ra_63_symbol <= binary_26_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_complete/ra
          cr_64_symbol <= ra_63_symbol; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_complete/cr
          binary_26_inst_req_1 <= cr_64_symbol; -- link to DP
          ca_65_symbol <= binary_26_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_complete/ca
          Xexit_61_symbol <= ca_65_symbol; -- transition branch_block_stmt_13/assign_stmt_28/binary_26_complete/$exit
          binary_26_complete_59_symbol <= Xexit_61_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_28/binary_26_complete
        Xexit_53_symbol <= assign_stmt_28_completed_x_x55_symbol; -- transition branch_block_stmt_13/assign_stmt_28/$exit
        assign_stmt_28_51_symbol <= Xexit_53_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_28
      if_stmt_29_dead_link_66: Block -- branch_block_stmt_13/if_stmt_29_dead_link 
        signal if_stmt_29_dead_link_66_start: Boolean;
        signal Xentry_67_symbol: Boolean;
        signal Xexit_68_symbol: Boolean;
        signal dead_transition_69_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_29_dead_link_66_start <= if_stmt_29_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_67_symbol  <= if_stmt_29_dead_link_66_start; -- transition branch_block_stmt_13/if_stmt_29_dead_link/$entry
        dead_transition_69_symbol <= false;
        Xexit_68_symbol <= dead_transition_69_symbol; -- transition branch_block_stmt_13/if_stmt_29_dead_link/$exit
        if_stmt_29_dead_link_66_symbol <= Xexit_68_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_29_dead_link
      if_stmt_29_eval_test_70: Block -- branch_block_stmt_13/if_stmt_29_eval_test 
        signal if_stmt_29_eval_test_70_start: Boolean;
        signal Xentry_71_symbol: Boolean;
        signal Xexit_72_symbol: Boolean;
        signal branch_req_73_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_29_eval_test_70_start <= if_stmt_29_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_71_symbol  <= if_stmt_29_eval_test_70_start; -- transition branch_block_stmt_13/if_stmt_29_eval_test/$entry
        branch_req_73_symbol <= Xentry_71_symbol; -- transition branch_block_stmt_13/if_stmt_29_eval_test/branch_req
        if_stmt_29_branch_req_0 <= branch_req_73_symbol; -- link to DP
        Xexit_72_symbol <= branch_req_73_symbol; -- transition branch_block_stmt_13/if_stmt_29_eval_test/$exit
        if_stmt_29_eval_test_70_symbol <= Xexit_72_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_29_eval_test
      simple_obj_ref_30_place_74_symbol  <=  if_stmt_29_eval_test_70_symbol; -- place branch_block_stmt_13/simple_obj_ref_30_place (optimized away) 
      if_stmt_29_if_link_75: Block -- branch_block_stmt_13/if_stmt_29_if_link 
        signal if_stmt_29_if_link_75_start: Boolean;
        signal Xentry_76_symbol: Boolean;
        signal Xexit_77_symbol: Boolean;
        signal if_choice_transition_78_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_29_if_link_75_start <= simple_obj_ref_30_place_74_symbol; -- control passed to block
        Xentry_76_symbol  <= if_stmt_29_if_link_75_start; -- transition branch_block_stmt_13/if_stmt_29_if_link/$entry
        if_choice_transition_78_symbol <= if_stmt_29_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_29_if_link/if_choice_transition
        Xexit_77_symbol <= if_choice_transition_78_symbol; -- transition branch_block_stmt_13/if_stmt_29_if_link/$exit
        if_stmt_29_if_link_75_symbol <= Xexit_77_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_29_if_link
      if_stmt_29_else_link_79: Block -- branch_block_stmt_13/if_stmt_29_else_link 
        signal if_stmt_29_else_link_79_start: Boolean;
        signal Xentry_80_symbol: Boolean;
        signal Xexit_81_symbol: Boolean;
        signal else_choice_transition_82_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_29_else_link_79_start <= simple_obj_ref_30_place_74_symbol; -- control passed to block
        Xentry_80_symbol  <= if_stmt_29_else_link_79_start; -- transition branch_block_stmt_13/if_stmt_29_else_link/$entry
        else_choice_transition_82_symbol <= if_stmt_29_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_29_else_link/else_choice_transition
        Xexit_81_symbol <= else_choice_transition_82_symbol; -- transition branch_block_stmt_13/if_stmt_29_else_link/$exit
        if_stmt_29_else_link_79_symbol <= Xexit_81_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_29_else_link
      bb_1_bb_2_83_symbol  <=  if_stmt_29_if_link_75_symbol; -- place branch_block_stmt_13/bb_1_bb_2 (optimized away) 
      bb_1_bb_3_84_symbol  <=  if_stmt_29_else_link_79_symbol; -- place branch_block_stmt_13/bb_1_bb_3 (optimized away) 
      assign_stmt_41_to_assign_stmt_118_85: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118 
        signal assign_stmt_41_to_assign_stmt_118_85_start: Boolean;
        signal Xentry_86_symbol: Boolean;
        signal Xexit_87_symbol: Boolean;
        signal assign_stmt_41_active_x_x88_symbol : Boolean;
        signal assign_stmt_41_completed_x_x89_symbol : Boolean;
        signal binary_40_active_x_x90_symbol : Boolean;
        signal binary_40_trigger_x_x91_symbol : Boolean;
        signal simple_obj_ref_37_complete_92_symbol : Boolean;
        signal binary_40_complete_93_symbol : Boolean;
        signal assign_stmt_46_active_x_x100_symbol : Boolean;
        signal assign_stmt_46_completed_x_x101_symbol : Boolean;
        signal type_cast_45_active_x_x102_symbol : Boolean;
        signal type_cast_45_trigger_x_x103_symbol : Boolean;
        signal simple_obj_ref_44_complete_104_symbol : Boolean;
        signal type_cast_45_complete_105_symbol : Boolean;
        signal assign_stmt_52_active_x_x110_symbol : Boolean;
        signal assign_stmt_52_completed_x_x111_symbol : Boolean;
        signal binary_51_active_x_x112_symbol : Boolean;
        signal binary_51_trigger_x_x113_symbol : Boolean;
        signal simple_obj_ref_48_complete_114_symbol : Boolean;
        signal binary_51_complete_115_symbol : Boolean;
        signal assign_stmt_58_active_x_x122_symbol : Boolean;
        signal assign_stmt_58_completed_x_x123_symbol : Boolean;
        signal binary_57_active_x_x124_symbol : Boolean;
        signal binary_57_trigger_x_x125_symbol : Boolean;
        signal simple_obj_ref_56_complete_126_symbol : Boolean;
        signal binary_57_complete_127_symbol : Boolean;
        signal assign_stmt_64_active_x_x134_symbol : Boolean;
        signal assign_stmt_64_completed_x_x135_symbol : Boolean;
        signal binary_63_active_x_x136_symbol : Boolean;
        signal binary_63_trigger_x_x137_symbol : Boolean;
        signal simple_obj_ref_60_complete_138_symbol : Boolean;
        signal binary_63_complete_139_symbol : Boolean;
        signal assign_stmt_73_active_x_x146_symbol : Boolean;
        signal assign_stmt_73_completed_x_x147_symbol : Boolean;
        signal binary_72_active_x_x148_symbol : Boolean;
        signal binary_72_trigger_x_x149_symbol : Boolean;
        signal type_cast_68_active_x_x150_symbol : Boolean;
        signal type_cast_68_trigger_x_x151_symbol : Boolean;
        signal simple_obj_ref_67_complete_152_symbol : Boolean;
        signal type_cast_68_complete_153_symbol : Boolean;
        signal binary_72_complete_158_symbol : Boolean;
        signal assign_stmt_79_active_x_x165_symbol : Boolean;
        signal assign_stmt_79_completed_x_x166_symbol : Boolean;
        signal binary_78_active_x_x167_symbol : Boolean;
        signal binary_78_trigger_x_x168_symbol : Boolean;
        signal simple_obj_ref_75_complete_169_symbol : Boolean;
        signal binary_78_complete_170_symbol : Boolean;
        signal assign_stmt_85_active_x_x177_symbol : Boolean;
        signal assign_stmt_85_completed_x_x178_symbol : Boolean;
        signal binary_84_active_x_x179_symbol : Boolean;
        signal binary_84_trigger_x_x180_symbol : Boolean;
        signal simple_obj_ref_81_complete_181_symbol : Boolean;
        signal binary_84_complete_182_symbol : Boolean;
        signal assign_stmt_91_active_x_x189_symbol : Boolean;
        signal assign_stmt_91_completed_x_x190_symbol : Boolean;
        signal binary_90_active_x_x191_symbol : Boolean;
        signal binary_90_trigger_x_x192_symbol : Boolean;
        signal simple_obj_ref_87_complete_193_symbol : Boolean;
        signal binary_90_complete_194_symbol : Boolean;
        signal assign_stmt_97_active_x_x201_symbol : Boolean;
        signal assign_stmt_97_completed_x_x202_symbol : Boolean;
        signal ternary_96_trigger_x_x203_symbol : Boolean;
        signal ternary_96_active_x_x204_symbol : Boolean;
        signal simple_obj_ref_93_complete_205_symbol : Boolean;
        signal simple_obj_ref_94_complete_206_symbol : Boolean;
        signal simple_obj_ref_95_complete_207_symbol : Boolean;
        signal ternary_96_complete_208_symbol : Boolean;
        signal assign_stmt_101_active_x_x213_symbol : Boolean;
        signal assign_stmt_101_completed_x_x214_symbol : Boolean;
        signal type_cast_100_active_x_x215_symbol : Boolean;
        signal type_cast_100_trigger_x_x216_symbol : Boolean;
        signal simple_obj_ref_99_complete_217_symbol : Boolean;
        signal type_cast_100_complete_218_symbol : Boolean;
        signal assign_stmt_107_active_x_x223_symbol : Boolean;
        signal assign_stmt_107_completed_x_x224_symbol : Boolean;
        signal binary_106_active_x_x225_symbol : Boolean;
        signal binary_106_trigger_x_x226_symbol : Boolean;
        signal simple_obj_ref_103_complete_227_symbol : Boolean;
        signal binary_106_complete_228_symbol : Boolean;
        signal assign_stmt_113_active_x_x235_symbol : Boolean;
        signal assign_stmt_113_completed_x_x236_symbol : Boolean;
        signal binary_112_active_x_x237_symbol : Boolean;
        signal binary_112_trigger_x_x238_symbol : Boolean;
        signal simple_obj_ref_109_complete_239_symbol : Boolean;
        signal binary_112_complete_240_symbol : Boolean;
        signal assign_stmt_118_active_x_x247_symbol : Boolean;
        signal assign_stmt_118_completed_x_x248_symbol : Boolean;
        signal binary_117_active_x_x249_symbol : Boolean;
        signal binary_117_trigger_x_x250_symbol : Boolean;
        signal simple_obj_ref_115_complete_251_symbol : Boolean;
        signal simple_obj_ref_116_complete_252_symbol : Boolean;
        signal binary_117_complete_253_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_41_to_assign_stmt_118_85_start <= assign_stmt_41_to_assign_stmt_118_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_86_symbol  <= assign_stmt_41_to_assign_stmt_118_85_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/$entry
        assign_stmt_41_active_x_x88_symbol <= binary_40_complete_93_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_41_active_
        assign_stmt_41_completed_x_x89_symbol <= assign_stmt_41_active_x_x88_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_41_completed_
        binary_40_active_x_x90_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_active_ 
          signal binary_40_active_x_x90_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_40_active_x_x90_predecessors(0) <= binary_40_trigger_x_x91_symbol;
          binary_40_active_x_x90_predecessors(1) <= simple_obj_ref_37_complete_92_symbol;
          binary_40_active_x_x90_join: join -- 
            port map( -- 
              preds => binary_40_active_x_x90_predecessors,
              symbol_out => binary_40_active_x_x90_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_active_
        binary_40_trigger_x_x91_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_trigger_
        simple_obj_ref_37_complete_92_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_37_complete
        binary_40_complete_93: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete 
          signal binary_40_complete_93_start: Boolean;
          signal Xentry_94_symbol: Boolean;
          signal Xexit_95_symbol: Boolean;
          signal rr_96_symbol : Boolean;
          signal ra_97_symbol : Boolean;
          signal cr_98_symbol : Boolean;
          signal ca_99_symbol : Boolean;
          -- 
        begin -- 
          binary_40_complete_93_start <= binary_40_active_x_x90_symbol; -- control passed to block
          Xentry_94_symbol  <= binary_40_complete_93_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete/$entry
          rr_96_symbol <= Xentry_94_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete/rr
          binary_40_inst_req_0 <= rr_96_symbol; -- link to DP
          ra_97_symbol <= binary_40_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete/ra
          cr_98_symbol <= ra_97_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete/cr
          binary_40_inst_req_1 <= cr_98_symbol; -- link to DP
          ca_99_symbol <= binary_40_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete/ca
          Xexit_95_symbol <= ca_99_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete/$exit
          binary_40_complete_93_symbol <= Xexit_95_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_40_complete
        assign_stmt_46_active_x_x100_symbol <= type_cast_45_complete_105_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_46_active_
        assign_stmt_46_completed_x_x101_symbol <= assign_stmt_46_active_x_x100_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_46_completed_
        type_cast_45_active_x_x102_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_active_ 
          signal type_cast_45_active_x_x102_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_45_active_x_x102_predecessors(0) <= type_cast_45_trigger_x_x103_symbol;
          type_cast_45_active_x_x102_predecessors(1) <= simple_obj_ref_44_complete_104_symbol;
          type_cast_45_active_x_x102_join: join -- 
            port map( -- 
              preds => type_cast_45_active_x_x102_predecessors,
              symbol_out => type_cast_45_active_x_x102_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_active_
        type_cast_45_trigger_x_x103_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_trigger_
        simple_obj_ref_44_complete_104_symbol <= assign_stmt_41_completed_x_x89_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_44_complete
        type_cast_45_complete_105: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_complete 
          signal type_cast_45_complete_105_start: Boolean;
          signal Xentry_106_symbol: Boolean;
          signal Xexit_107_symbol: Boolean;
          signal req_108_symbol : Boolean;
          signal ack_109_symbol : Boolean;
          -- 
        begin -- 
          type_cast_45_complete_105_start <= type_cast_45_active_x_x102_symbol; -- control passed to block
          Xentry_106_symbol  <= type_cast_45_complete_105_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_complete/$entry
          req_108_symbol <= Xentry_106_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_complete/req
          type_cast_45_inst_req_0 <= req_108_symbol; -- link to DP
          ack_109_symbol <= type_cast_45_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_complete/ack
          Xexit_107_symbol <= ack_109_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_complete/$exit
          type_cast_45_complete_105_symbol <= Xexit_107_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_45_complete
        assign_stmt_52_active_x_x110_symbol <= binary_51_complete_115_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_52_active_
        assign_stmt_52_completed_x_x111_symbol <= assign_stmt_52_active_x_x110_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_52_completed_
        binary_51_active_x_x112_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_active_ 
          signal binary_51_active_x_x112_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_51_active_x_x112_predecessors(0) <= binary_51_trigger_x_x113_symbol;
          binary_51_active_x_x112_predecessors(1) <= simple_obj_ref_48_complete_114_symbol;
          binary_51_active_x_x112_join: join -- 
            port map( -- 
              preds => binary_51_active_x_x112_predecessors,
              symbol_out => binary_51_active_x_x112_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_active_
        binary_51_trigger_x_x113_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_trigger_
        simple_obj_ref_48_complete_114_symbol <= assign_stmt_46_completed_x_x101_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_48_complete
        binary_51_complete_115: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete 
          signal binary_51_complete_115_start: Boolean;
          signal Xentry_116_symbol: Boolean;
          signal Xexit_117_symbol: Boolean;
          signal rr_118_symbol : Boolean;
          signal ra_119_symbol : Boolean;
          signal cr_120_symbol : Boolean;
          signal ca_121_symbol : Boolean;
          -- 
        begin -- 
          binary_51_complete_115_start <= binary_51_active_x_x112_symbol; -- control passed to block
          Xentry_116_symbol  <= binary_51_complete_115_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete/$entry
          rr_118_symbol <= Xentry_116_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete/rr
          binary_51_inst_req_0 <= rr_118_symbol; -- link to DP
          ra_119_symbol <= binary_51_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete/ra
          cr_120_symbol <= ra_119_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete/cr
          binary_51_inst_req_1 <= cr_120_symbol; -- link to DP
          ca_121_symbol <= binary_51_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete/ca
          Xexit_117_symbol <= ca_121_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete/$exit
          binary_51_complete_115_symbol <= Xexit_117_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_51_complete
        assign_stmt_58_active_x_x122_symbol <= binary_57_complete_127_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_58_active_
        assign_stmt_58_completed_x_x123_symbol <= assign_stmt_58_active_x_x122_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_58_completed_
        binary_57_active_x_x124_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_active_ 
          signal binary_57_active_x_x124_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_57_active_x_x124_predecessors(0) <= binary_57_trigger_x_x125_symbol;
          binary_57_active_x_x124_predecessors(1) <= simple_obj_ref_56_complete_126_symbol;
          binary_57_active_x_x124_join: join -- 
            port map( -- 
              preds => binary_57_active_x_x124_predecessors,
              symbol_out => binary_57_active_x_x124_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_active_
        binary_57_trigger_x_x125_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_trigger_
        simple_obj_ref_56_complete_126_symbol <= assign_stmt_52_completed_x_x111_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_56_complete
        binary_57_complete_127: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete 
          signal binary_57_complete_127_start: Boolean;
          signal Xentry_128_symbol: Boolean;
          signal Xexit_129_symbol: Boolean;
          signal rr_130_symbol : Boolean;
          signal ra_131_symbol : Boolean;
          signal cr_132_symbol : Boolean;
          signal ca_133_symbol : Boolean;
          -- 
        begin -- 
          binary_57_complete_127_start <= binary_57_active_x_x124_symbol; -- control passed to block
          Xentry_128_symbol  <= binary_57_complete_127_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete/$entry
          rr_130_symbol <= Xentry_128_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete/rr
          binary_57_inst_req_0 <= rr_130_symbol; -- link to DP
          ra_131_symbol <= binary_57_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete/ra
          cr_132_symbol <= ra_131_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete/cr
          binary_57_inst_req_1 <= cr_132_symbol; -- link to DP
          ca_133_symbol <= binary_57_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete/ca
          Xexit_129_symbol <= ca_133_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete/$exit
          binary_57_complete_127_symbol <= Xexit_129_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_57_complete
        assign_stmt_64_active_x_x134_symbol <= binary_63_complete_139_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_64_active_
        assign_stmt_64_completed_x_x135_symbol <= assign_stmt_64_active_x_x134_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_64_completed_
        binary_63_active_x_x136_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_active_ 
          signal binary_63_active_x_x136_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_63_active_x_x136_predecessors(0) <= binary_63_trigger_x_x137_symbol;
          binary_63_active_x_x136_predecessors(1) <= simple_obj_ref_60_complete_138_symbol;
          binary_63_active_x_x136_join: join -- 
            port map( -- 
              preds => binary_63_active_x_x136_predecessors,
              symbol_out => binary_63_active_x_x136_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_active_
        binary_63_trigger_x_x137_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_trigger_
        simple_obj_ref_60_complete_138_symbol <= assign_stmt_41_completed_x_x89_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_60_complete
        binary_63_complete_139: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete 
          signal binary_63_complete_139_start: Boolean;
          signal Xentry_140_symbol: Boolean;
          signal Xexit_141_symbol: Boolean;
          signal rr_142_symbol : Boolean;
          signal ra_143_symbol : Boolean;
          signal cr_144_symbol : Boolean;
          signal ca_145_symbol : Boolean;
          -- 
        begin -- 
          binary_63_complete_139_start <= binary_63_active_x_x136_symbol; -- control passed to block
          Xentry_140_symbol  <= binary_63_complete_139_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete/$entry
          rr_142_symbol <= Xentry_140_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete/rr
          binary_63_inst_req_0 <= rr_142_symbol; -- link to DP
          ra_143_symbol <= binary_63_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete/ra
          cr_144_symbol <= ra_143_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete/cr
          binary_63_inst_req_1 <= cr_144_symbol; -- link to DP
          ca_145_symbol <= binary_63_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete/ca
          Xexit_141_symbol <= ca_145_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete/$exit
          binary_63_complete_139_symbol <= Xexit_141_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_63_complete
        assign_stmt_73_active_x_x146_symbol <= binary_72_complete_158_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_73_active_
        assign_stmt_73_completed_x_x147_symbol <= assign_stmt_73_active_x_x146_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_73_completed_
        binary_72_active_x_x148_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_active_ 
          signal binary_72_active_x_x148_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_72_active_x_x148_predecessors(0) <= binary_72_trigger_x_x149_symbol;
          binary_72_active_x_x148_predecessors(1) <= type_cast_68_complete_153_symbol;
          binary_72_active_x_x148_join: join -- 
            port map( -- 
              preds => binary_72_active_x_x148_predecessors,
              symbol_out => binary_72_active_x_x148_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_active_
        binary_72_trigger_x_x149_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_trigger_
        type_cast_68_active_x_x150_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_active_ 
          signal type_cast_68_active_x_x150_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_68_active_x_x150_predecessors(0) <= type_cast_68_trigger_x_x151_symbol;
          type_cast_68_active_x_x150_predecessors(1) <= simple_obj_ref_67_complete_152_symbol;
          type_cast_68_active_x_x150_join: join -- 
            port map( -- 
              preds => type_cast_68_active_x_x150_predecessors,
              symbol_out => type_cast_68_active_x_x150_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_active_
        type_cast_68_trigger_x_x151_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_trigger_
        simple_obj_ref_67_complete_152_symbol <= assign_stmt_64_completed_x_x135_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_67_complete
        type_cast_68_complete_153: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_complete 
          signal type_cast_68_complete_153_start: Boolean;
          signal Xentry_154_symbol: Boolean;
          signal Xexit_155_symbol: Boolean;
          signal req_156_symbol : Boolean;
          signal ack_157_symbol : Boolean;
          -- 
        begin -- 
          type_cast_68_complete_153_start <= type_cast_68_active_x_x150_symbol; -- control passed to block
          Xentry_154_symbol  <= type_cast_68_complete_153_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_complete/$entry
          req_156_symbol <= Xentry_154_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_complete/req
          type_cast_68_inst_req_0 <= req_156_symbol; -- link to DP
          ack_157_symbol <= type_cast_68_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_complete/ack
          Xexit_155_symbol <= ack_157_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_complete/$exit
          type_cast_68_complete_153_symbol <= Xexit_155_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_68_complete
        binary_72_complete_158: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete 
          signal binary_72_complete_158_start: Boolean;
          signal Xentry_159_symbol: Boolean;
          signal Xexit_160_symbol: Boolean;
          signal rr_161_symbol : Boolean;
          signal ra_162_symbol : Boolean;
          signal cr_163_symbol : Boolean;
          signal ca_164_symbol : Boolean;
          -- 
        begin -- 
          binary_72_complete_158_start <= binary_72_active_x_x148_symbol; -- control passed to block
          Xentry_159_symbol  <= binary_72_complete_158_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete/$entry
          rr_161_symbol <= Xentry_159_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete/rr
          binary_72_inst_req_0 <= rr_161_symbol; -- link to DP
          ra_162_symbol <= binary_72_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete/ra
          cr_163_symbol <= ra_162_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete/cr
          binary_72_inst_req_1 <= cr_163_symbol; -- link to DP
          ca_164_symbol <= binary_72_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete/ca
          Xexit_160_symbol <= ca_164_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete/$exit
          binary_72_complete_158_symbol <= Xexit_160_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_72_complete
        assign_stmt_79_active_x_x165_symbol <= binary_78_complete_170_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_79_active_
        assign_stmt_79_completed_x_x166_symbol <= assign_stmt_79_active_x_x165_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_79_completed_
        binary_78_active_x_x167_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_active_ 
          signal binary_78_active_x_x167_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_78_active_x_x167_predecessors(0) <= binary_78_trigger_x_x168_symbol;
          binary_78_active_x_x167_predecessors(1) <= simple_obj_ref_75_complete_169_symbol;
          binary_78_active_x_x167_join: join -- 
            port map( -- 
              preds => binary_78_active_x_x167_predecessors,
              symbol_out => binary_78_active_x_x167_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_active_
        binary_78_trigger_x_x168_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_trigger_
        simple_obj_ref_75_complete_169_symbol <= assign_stmt_58_completed_x_x123_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_75_complete
        binary_78_complete_170: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete 
          signal binary_78_complete_170_start: Boolean;
          signal Xentry_171_symbol: Boolean;
          signal Xexit_172_symbol: Boolean;
          signal rr_173_symbol : Boolean;
          signal ra_174_symbol : Boolean;
          signal cr_175_symbol : Boolean;
          signal ca_176_symbol : Boolean;
          -- 
        begin -- 
          binary_78_complete_170_start <= binary_78_active_x_x167_symbol; -- control passed to block
          Xentry_171_symbol  <= binary_78_complete_170_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete/$entry
          rr_173_symbol <= Xentry_171_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete/rr
          binary_78_inst_req_0 <= rr_173_symbol; -- link to DP
          ra_174_symbol <= binary_78_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete/ra
          cr_175_symbol <= ra_174_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete/cr
          binary_78_inst_req_1 <= cr_175_symbol; -- link to DP
          ca_176_symbol <= binary_78_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete/ca
          Xexit_172_symbol <= ca_176_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete/$exit
          binary_78_complete_170_symbol <= Xexit_172_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_78_complete
        assign_stmt_85_active_x_x177_symbol <= binary_84_complete_182_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_85_active_
        assign_stmt_85_completed_x_x178_symbol <= assign_stmt_85_active_x_x177_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_85_completed_
        binary_84_active_x_x179_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_active_ 
          signal binary_84_active_x_x179_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_84_active_x_x179_predecessors(0) <= binary_84_trigger_x_x180_symbol;
          binary_84_active_x_x179_predecessors(1) <= simple_obj_ref_81_complete_181_symbol;
          binary_84_active_x_x179_join: join -- 
            port map( -- 
              preds => binary_84_active_x_x179_predecessors,
              symbol_out => binary_84_active_x_x179_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_active_
        binary_84_trigger_x_x180_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_trigger_
        simple_obj_ref_81_complete_181_symbol <= assign_stmt_79_completed_x_x166_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_81_complete
        binary_84_complete_182: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete 
          signal binary_84_complete_182_start: Boolean;
          signal Xentry_183_symbol: Boolean;
          signal Xexit_184_symbol: Boolean;
          signal rr_185_symbol : Boolean;
          signal ra_186_symbol : Boolean;
          signal cr_187_symbol : Boolean;
          signal ca_188_symbol : Boolean;
          -- 
        begin -- 
          binary_84_complete_182_start <= binary_84_active_x_x179_symbol; -- control passed to block
          Xentry_183_symbol  <= binary_84_complete_182_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete/$entry
          rr_185_symbol <= Xentry_183_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete/rr
          binary_84_inst_req_0 <= rr_185_symbol; -- link to DP
          ra_186_symbol <= binary_84_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete/ra
          cr_187_symbol <= ra_186_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete/cr
          binary_84_inst_req_1 <= cr_187_symbol; -- link to DP
          ca_188_symbol <= binary_84_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete/ca
          Xexit_184_symbol <= ca_188_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete/$exit
          binary_84_complete_182_symbol <= Xexit_184_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_84_complete
        assign_stmt_91_active_x_x189_symbol <= binary_90_complete_194_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_91_active_
        assign_stmt_91_completed_x_x190_symbol <= assign_stmt_91_active_x_x189_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_91_completed_
        binary_90_active_x_x191_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_active_ 
          signal binary_90_active_x_x191_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_90_active_x_x191_predecessors(0) <= binary_90_trigger_x_x192_symbol;
          binary_90_active_x_x191_predecessors(1) <= simple_obj_ref_87_complete_193_symbol;
          binary_90_active_x_x191_join: join -- 
            port map( -- 
              preds => binary_90_active_x_x191_predecessors,
              symbol_out => binary_90_active_x_x191_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_active_
        binary_90_trigger_x_x192_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_trigger_
        simple_obj_ref_87_complete_193_symbol <= assign_stmt_58_completed_x_x123_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_87_complete
        binary_90_complete_194: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete 
          signal binary_90_complete_194_start: Boolean;
          signal Xentry_195_symbol: Boolean;
          signal Xexit_196_symbol: Boolean;
          signal rr_197_symbol : Boolean;
          signal ra_198_symbol : Boolean;
          signal cr_199_symbol : Boolean;
          signal ca_200_symbol : Boolean;
          -- 
        begin -- 
          binary_90_complete_194_start <= binary_90_active_x_x191_symbol; -- control passed to block
          Xentry_195_symbol  <= binary_90_complete_194_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete/$entry
          rr_197_symbol <= Xentry_195_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete/rr
          binary_90_inst_req_0 <= rr_197_symbol; -- link to DP
          ra_198_symbol <= binary_90_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete/ra
          cr_199_symbol <= ra_198_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete/cr
          binary_90_inst_req_1 <= cr_199_symbol; -- link to DP
          ca_200_symbol <= binary_90_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete/ca
          Xexit_196_symbol <= ca_200_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete/$exit
          binary_90_complete_194_symbol <= Xexit_196_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_90_complete
        assign_stmt_97_active_x_x201_symbol <= ternary_96_complete_208_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_97_active_
        assign_stmt_97_completed_x_x202_symbol <= assign_stmt_97_active_x_x201_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_97_completed_
        ternary_96_trigger_x_x203_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_trigger_
        ternary_96_active_x_x204_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_active_ 
          signal ternary_96_active_x_x204_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          ternary_96_active_x_x204_predecessors(0) <= ternary_96_trigger_x_x203_symbol;
          ternary_96_active_x_x204_predecessors(1) <= simple_obj_ref_93_complete_205_symbol;
          ternary_96_active_x_x204_predecessors(2) <= simple_obj_ref_94_complete_206_symbol;
          ternary_96_active_x_x204_predecessors(3) <= simple_obj_ref_95_complete_207_symbol;
          ternary_96_active_x_x204_join: join -- 
            port map( -- 
              preds => ternary_96_active_x_x204_predecessors,
              symbol_out => ternary_96_active_x_x204_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_active_
        simple_obj_ref_93_complete_205_symbol <= assign_stmt_73_completed_x_x147_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_93_complete
        simple_obj_ref_94_complete_206_symbol <= assign_stmt_85_completed_x_x178_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_94_complete
        simple_obj_ref_95_complete_207_symbol <= assign_stmt_91_completed_x_x190_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_95_complete
        ternary_96_complete_208: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_complete 
          signal ternary_96_complete_208_start: Boolean;
          signal Xentry_209_symbol: Boolean;
          signal Xexit_210_symbol: Boolean;
          signal req_211_symbol : Boolean;
          signal ack_212_symbol : Boolean;
          -- 
        begin -- 
          ternary_96_complete_208_start <= ternary_96_active_x_x204_symbol; -- control passed to block
          Xentry_209_symbol  <= ternary_96_complete_208_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_complete/$entry
          req_211_symbol <= Xentry_209_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_complete/req
          ternary_96_inst_req_0 <= req_211_symbol; -- link to DP
          ack_212_symbol <= ternary_96_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_complete/ack
          Xexit_210_symbol <= ack_212_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_complete/$exit
          ternary_96_complete_208_symbol <= Xexit_210_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/ternary_96_complete
        assign_stmt_101_active_x_x213_symbol <= type_cast_100_complete_218_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_101_active_
        assign_stmt_101_completed_x_x214_symbol <= assign_stmt_101_active_x_x213_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_101_completed_
        type_cast_100_active_x_x215_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_active_ 
          signal type_cast_100_active_x_x215_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_100_active_x_x215_predecessors(0) <= type_cast_100_trigger_x_x216_symbol;
          type_cast_100_active_x_x215_predecessors(1) <= simple_obj_ref_99_complete_217_symbol;
          type_cast_100_active_x_x215_join: join -- 
            port map( -- 
              preds => type_cast_100_active_x_x215_predecessors,
              symbol_out => type_cast_100_active_x_x215_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_active_
        type_cast_100_trigger_x_x216_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_trigger_
        simple_obj_ref_99_complete_217_symbol <= assign_stmt_97_completed_x_x202_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_99_complete
        type_cast_100_complete_218: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_complete 
          signal type_cast_100_complete_218_start: Boolean;
          signal Xentry_219_symbol: Boolean;
          signal Xexit_220_symbol: Boolean;
          signal req_221_symbol : Boolean;
          signal ack_222_symbol : Boolean;
          -- 
        begin -- 
          type_cast_100_complete_218_start <= type_cast_100_active_x_x215_symbol; -- control passed to block
          Xentry_219_symbol  <= type_cast_100_complete_218_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_complete/$entry
          req_221_symbol <= Xentry_219_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_complete/req
          type_cast_100_inst_req_0 <= req_221_symbol; -- link to DP
          ack_222_symbol <= type_cast_100_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_complete/ack
          Xexit_220_symbol <= ack_222_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_complete/$exit
          type_cast_100_complete_218_symbol <= Xexit_220_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/type_cast_100_complete
        assign_stmt_107_active_x_x223_symbol <= binary_106_complete_228_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_107_active_
        assign_stmt_107_completed_x_x224_symbol <= assign_stmt_107_active_x_x223_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_107_completed_
        binary_106_active_x_x225_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_active_ 
          signal binary_106_active_x_x225_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_106_active_x_x225_predecessors(0) <= binary_106_trigger_x_x226_symbol;
          binary_106_active_x_x225_predecessors(1) <= simple_obj_ref_103_complete_227_symbol;
          binary_106_active_x_x225_join: join -- 
            port map( -- 
              preds => binary_106_active_x_x225_predecessors,
              symbol_out => binary_106_active_x_x225_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_active_
        binary_106_trigger_x_x226_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_trigger_
        simple_obj_ref_103_complete_227_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_103_complete
        binary_106_complete_228: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete 
          signal binary_106_complete_228_start: Boolean;
          signal Xentry_229_symbol: Boolean;
          signal Xexit_230_symbol: Boolean;
          signal rr_231_symbol : Boolean;
          signal ra_232_symbol : Boolean;
          signal cr_233_symbol : Boolean;
          signal ca_234_symbol : Boolean;
          -- 
        begin -- 
          binary_106_complete_228_start <= binary_106_active_x_x225_symbol; -- control passed to block
          Xentry_229_symbol  <= binary_106_complete_228_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete/$entry
          rr_231_symbol <= Xentry_229_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete/rr
          binary_106_inst_req_0 <= rr_231_symbol; -- link to DP
          ra_232_symbol <= binary_106_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete/ra
          cr_233_symbol <= ra_232_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete/cr
          binary_106_inst_req_1 <= cr_233_symbol; -- link to DP
          ca_234_symbol <= binary_106_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete/ca
          Xexit_230_symbol <= ca_234_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete/$exit
          binary_106_complete_228_symbol <= Xexit_230_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_106_complete
        assign_stmt_113_active_x_x235_symbol <= binary_112_complete_240_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_113_active_
        assign_stmt_113_completed_x_x236_symbol <= assign_stmt_113_active_x_x235_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_113_completed_
        binary_112_active_x_x237_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_active_ 
          signal binary_112_active_x_x237_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_112_active_x_x237_predecessors(0) <= binary_112_trigger_x_x238_symbol;
          binary_112_active_x_x237_predecessors(1) <= simple_obj_ref_109_complete_239_symbol;
          binary_112_active_x_x237_join: join -- 
            port map( -- 
              preds => binary_112_active_x_x237_predecessors,
              symbol_out => binary_112_active_x_x237_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_active_
        binary_112_trigger_x_x238_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_trigger_
        simple_obj_ref_109_complete_239_symbol <= assign_stmt_101_completed_x_x214_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_109_complete
        binary_112_complete_240: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete 
          signal binary_112_complete_240_start: Boolean;
          signal Xentry_241_symbol: Boolean;
          signal Xexit_242_symbol: Boolean;
          signal rr_243_symbol : Boolean;
          signal ra_244_symbol : Boolean;
          signal cr_245_symbol : Boolean;
          signal ca_246_symbol : Boolean;
          -- 
        begin -- 
          binary_112_complete_240_start <= binary_112_active_x_x237_symbol; -- control passed to block
          Xentry_241_symbol  <= binary_112_complete_240_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete/$entry
          rr_243_symbol <= Xentry_241_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete/rr
          binary_112_inst_req_0 <= rr_243_symbol; -- link to DP
          ra_244_symbol <= binary_112_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete/ra
          cr_245_symbol <= ra_244_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete/cr
          binary_112_inst_req_1 <= cr_245_symbol; -- link to DP
          ca_246_symbol <= binary_112_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete/ca
          Xexit_242_symbol <= ca_246_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete/$exit
          binary_112_complete_240_symbol <= Xexit_242_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_112_complete
        assign_stmt_118_active_x_x247_symbol <= binary_117_complete_253_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_118_active_
        assign_stmt_118_completed_x_x248_symbol <= assign_stmt_118_active_x_x247_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/assign_stmt_118_completed_
        binary_117_active_x_x249_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_active_ 
          signal binary_117_active_x_x249_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_117_active_x_x249_predecessors(0) <= binary_117_trigger_x_x250_symbol;
          binary_117_active_x_x249_predecessors(1) <= simple_obj_ref_115_complete_251_symbol;
          binary_117_active_x_x249_predecessors(2) <= simple_obj_ref_116_complete_252_symbol;
          binary_117_active_x_x249_join: join -- 
            port map( -- 
              preds => binary_117_active_x_x249_predecessors,
              symbol_out => binary_117_active_x_x249_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_active_
        binary_117_trigger_x_x250_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_trigger_
        simple_obj_ref_115_complete_251_symbol <= assign_stmt_113_completed_x_x236_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_115_complete
        simple_obj_ref_116_complete_252_symbol <= assign_stmt_107_completed_x_x224_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/simple_obj_ref_116_complete
        binary_117_complete_253: Block -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete 
          signal binary_117_complete_253_start: Boolean;
          signal Xentry_254_symbol: Boolean;
          signal Xexit_255_symbol: Boolean;
          signal rr_256_symbol : Boolean;
          signal ra_257_symbol : Boolean;
          signal cr_258_symbol : Boolean;
          signal ca_259_symbol : Boolean;
          -- 
        begin -- 
          binary_117_complete_253_start <= binary_117_active_x_x249_symbol; -- control passed to block
          Xentry_254_symbol  <= binary_117_complete_253_start; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete/$entry
          rr_256_symbol <= Xentry_254_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete/rr
          binary_117_inst_req_0 <= rr_256_symbol; -- link to DP
          ra_257_symbol <= binary_117_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete/ra
          cr_258_symbol <= ra_257_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete/cr
          binary_117_inst_req_1 <= cr_258_symbol; -- link to DP
          ca_259_symbol <= binary_117_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete/ca
          Xexit_255_symbol <= ca_259_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete/$exit
          binary_117_complete_253_symbol <= Xexit_255_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/binary_117_complete
        Xexit_87_symbol <= assign_stmt_118_completed_x_x248_symbol; -- transition branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118/$exit
        assign_stmt_41_to_assign_stmt_118_85_symbol <= Xexit_87_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_41_to_assign_stmt_118
      assign_stmt_130_260: Block -- branch_block_stmt_13/assign_stmt_130 
        signal assign_stmt_130_260_start: Boolean;
        signal Xentry_261_symbol: Boolean;
        signal Xexit_262_symbol: Boolean;
        signal assign_stmt_130_active_x_x263_symbol : Boolean;
        signal assign_stmt_130_completed_x_x264_symbol : Boolean;
        signal simple_obj_ref_129_complete_265_symbol : Boolean;
        signal simple_obj_ref_128_trigger_x_x266_symbol : Boolean;
        signal simple_obj_ref_128_complete_267_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_130_260_start <= assign_stmt_130_x_xentry_x_xx_x24_symbol; -- control passed to block
        Xentry_261_symbol  <= assign_stmt_130_260_start; -- transition branch_block_stmt_13/assign_stmt_130/$entry
        assign_stmt_130_active_x_x263_symbol <= simple_obj_ref_129_complete_265_symbol; -- transition branch_block_stmt_13/assign_stmt_130/assign_stmt_130_active_
        assign_stmt_130_completed_x_x264_symbol <= simple_obj_ref_128_complete_267_symbol; -- transition branch_block_stmt_13/assign_stmt_130/assign_stmt_130_completed_
        simple_obj_ref_129_complete_265_symbol <= Xentry_261_symbol; -- transition branch_block_stmt_13/assign_stmt_130/simple_obj_ref_129_complete
        simple_obj_ref_128_trigger_x_x266_symbol <= assign_stmt_130_active_x_x263_symbol; -- transition branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_trigger_
        simple_obj_ref_128_complete_267: Block -- branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_complete 
          signal simple_obj_ref_128_complete_267_start: Boolean;
          signal Xentry_268_symbol: Boolean;
          signal Xexit_269_symbol: Boolean;
          signal pipe_wreq_270_symbol : Boolean;
          signal pipe_wack_271_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_128_complete_267_start <= simple_obj_ref_128_trigger_x_x266_symbol; -- control passed to block
          Xentry_268_symbol  <= simple_obj_ref_128_complete_267_start; -- transition branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_complete/$entry
          pipe_wreq_270_symbol <= Xentry_268_symbol; -- transition branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_complete/pipe_wreq
          simple_obj_ref_128_inst_req_0 <= pipe_wreq_270_symbol; -- link to DP
          pipe_wack_271_symbol <= simple_obj_ref_128_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_complete/pipe_wack
          Xexit_269_symbol <= pipe_wack_271_symbol; -- transition branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_complete/$exit
          simple_obj_ref_128_complete_267_symbol <= Xexit_269_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_130/simple_obj_ref_128_complete
        Xexit_262_symbol <= assign_stmt_130_completed_x_x264_symbol; -- transition branch_block_stmt_13/assign_stmt_130/$exit
        assign_stmt_130_260_symbol <= Xexit_262_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_130
      assign_stmt_133_272: Block -- branch_block_stmt_13/assign_stmt_133 
        signal assign_stmt_133_272_start: Boolean;
        signal Xentry_273_symbol: Boolean;
        signal Xexit_274_symbol: Boolean;
        signal assign_stmt_133_active_x_x275_symbol : Boolean;
        signal assign_stmt_133_completed_x_x276_symbol : Boolean;
        signal simple_obj_ref_132_complete_277_symbol : Boolean;
        signal simple_obj_ref_131_trigger_x_x278_symbol : Boolean;
        signal simple_obj_ref_131_complete_279_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_133_272_start <= assign_stmt_133_x_xentry_x_xx_x26_symbol; -- control passed to block
        Xentry_273_symbol  <= assign_stmt_133_272_start; -- transition branch_block_stmt_13/assign_stmt_133/$entry
        assign_stmt_133_active_x_x275_symbol <= simple_obj_ref_132_complete_277_symbol; -- transition branch_block_stmt_13/assign_stmt_133/assign_stmt_133_active_
        assign_stmt_133_completed_x_x276_symbol <= simple_obj_ref_131_complete_279_symbol; -- transition branch_block_stmt_13/assign_stmt_133/assign_stmt_133_completed_
        simple_obj_ref_132_complete_277_symbol <= Xentry_273_symbol; -- transition branch_block_stmt_13/assign_stmt_133/simple_obj_ref_132_complete
        simple_obj_ref_131_trigger_x_x278_symbol <= assign_stmt_133_active_x_x275_symbol; -- transition branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_trigger_
        simple_obj_ref_131_complete_279: Block -- branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_complete 
          signal simple_obj_ref_131_complete_279_start: Boolean;
          signal Xentry_280_symbol: Boolean;
          signal Xexit_281_symbol: Boolean;
          signal pipe_wreq_282_symbol : Boolean;
          signal pipe_wack_283_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_131_complete_279_start <= simple_obj_ref_131_trigger_x_x278_symbol; -- control passed to block
          Xentry_280_symbol  <= simple_obj_ref_131_complete_279_start; -- transition branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_complete/$entry
          pipe_wreq_282_symbol <= Xentry_280_symbol; -- transition branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_complete/pipe_wreq
          simple_obj_ref_131_inst_req_0 <= pipe_wreq_282_symbol; -- link to DP
          pipe_wack_283_symbol <= simple_obj_ref_131_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_complete/pipe_wack
          Xexit_281_symbol <= pipe_wack_283_symbol; -- transition branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_complete/$exit
          simple_obj_ref_131_complete_279_symbol <= Xexit_281_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_133/simple_obj_ref_131_complete
        Xexit_274_symbol <= assign_stmt_133_completed_x_x276_symbol; -- transition branch_block_stmt_13/assign_stmt_133/$exit
        assign_stmt_133_272_symbol <= Xexit_274_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_133
      bb_0_bb_1_PhiReq_284: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_284_start: Boolean;
        signal Xentry_285_symbol: Boolean;
        signal Xexit_286_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_284_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_285_symbol  <= bb_0_bb_1_PhiReq_284_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        Xexit_286_symbol <= Xentry_285_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_284_symbol <= Xexit_286_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_3_bb_1_PhiReq_287: Block -- branch_block_stmt_13/bb_3_bb_1_PhiReq 
        signal bb_3_bb_1_PhiReq_287_start: Boolean;
        signal Xentry_288_symbol: Boolean;
        signal Xexit_289_symbol: Boolean;
        -- 
      begin -- 
        bb_3_bb_1_PhiReq_287_start <= bb_3_bb_1_28_symbol; -- control passed to block
        Xentry_288_symbol  <= bb_3_bb_1_PhiReq_287_start; -- transition branch_block_stmt_13/bb_3_bb_1_PhiReq/$entry
        Xexit_289_symbol <= Xentry_288_symbol; -- transition branch_block_stmt_13/bb_3_bb_1_PhiReq/$exit
        bb_3_bb_1_PhiReq_287_symbol <= Xexit_289_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_3_bb_1_PhiReq
      merge_stmt_15_PhiReqMerge_290_symbol  <=  bb_0_bb_1_PhiReq_284_symbol or bb_3_bb_1_PhiReq_287_symbol; -- place branch_block_stmt_13/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_291: Block -- branch_block_stmt_13/merge_stmt_15_PhiAck 
        signal merge_stmt_15_PhiAck_291_start: Boolean;
        signal Xentry_292_symbol: Boolean;
        signal Xexit_293_symbol: Boolean;
        signal dummy_294_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_291_start <= merge_stmt_15_PhiReqMerge_290_symbol; -- control passed to block
        Xentry_292_symbol  <= merge_stmt_15_PhiAck_291_start; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$entry
        dummy_294_symbol <= Xentry_292_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/dummy
        Xexit_293_symbol <= dummy_294_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_291_symbol <= Xexit_293_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_15_PhiAck
      merge_stmt_35_dead_link_295: Block -- branch_block_stmt_13/merge_stmt_35_dead_link 
        signal merge_stmt_35_dead_link_295_start: Boolean;
        signal Xentry_296_symbol: Boolean;
        signal Xexit_297_symbol: Boolean;
        signal dead_transition_298_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_35_dead_link_295_start <= merge_stmt_35_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_296_symbol  <= merge_stmt_35_dead_link_295_start; -- transition branch_block_stmt_13/merge_stmt_35_dead_link/$entry
        dead_transition_298_symbol <= false;
        Xexit_297_symbol <= dead_transition_298_symbol; -- transition branch_block_stmt_13/merge_stmt_35_dead_link/$exit
        merge_stmt_35_dead_link_295_symbol <= Xexit_297_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_35_dead_link
      bb_1_bb_2_PhiReq_299: Block -- branch_block_stmt_13/bb_1_bb_2_PhiReq 
        signal bb_1_bb_2_PhiReq_299_start: Boolean;
        signal Xentry_300_symbol: Boolean;
        signal Xexit_301_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_2_PhiReq_299_start <= bb_1_bb_2_83_symbol; -- control passed to block
        Xentry_300_symbol  <= bb_1_bb_2_PhiReq_299_start; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$entry
        Xexit_301_symbol <= Xentry_300_symbol; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$exit
        bb_1_bb_2_PhiReq_299_symbol <= Xexit_301_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_2_PhiReq
      merge_stmt_35_PhiReqMerge_302_symbol  <=  bb_1_bb_2_PhiReq_299_symbol; -- place branch_block_stmt_13/merge_stmt_35_PhiReqMerge (optimized away) 
      merge_stmt_35_PhiAck_303: Block -- branch_block_stmt_13/merge_stmt_35_PhiAck 
        signal merge_stmt_35_PhiAck_303_start: Boolean;
        signal Xentry_304_symbol: Boolean;
        signal Xexit_305_symbol: Boolean;
        signal dummy_306_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_35_PhiAck_303_start <= merge_stmt_35_PhiReqMerge_302_symbol; -- control passed to block
        Xentry_304_symbol  <= merge_stmt_35_PhiAck_303_start; -- transition branch_block_stmt_13/merge_stmt_35_PhiAck/$entry
        dummy_306_symbol <= Xentry_304_symbol; -- transition branch_block_stmt_13/merge_stmt_35_PhiAck/dummy
        Xexit_305_symbol <= dummy_306_symbol; -- transition branch_block_stmt_13/merge_stmt_35_PhiAck/$exit
        merge_stmt_35_PhiAck_303_symbol <= Xexit_305_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_35_PhiAck
      bb_1_bb_3_PhiReq_307: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq 
        signal bb_1_bb_3_PhiReq_307_start: Boolean;
        signal Xentry_308_symbol: Boolean;
        signal Xexit_309_symbol: Boolean;
        signal phi_stmt_121_310_symbol : Boolean;
        -- 
      begin -- 
        bb_1_bb_3_PhiReq_307_start <= bb_1_bb_3_84_symbol; -- control passed to block
        Xentry_308_symbol  <= bb_1_bb_3_PhiReq_307_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/$entry
        phi_stmt_121_310: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121 
          signal phi_stmt_121_310_start: Boolean;
          signal Xentry_311_symbol: Boolean;
          signal Xexit_312_symbol: Boolean;
          signal type_cast_124_313_symbol : Boolean;
          signal type_cast_126_318_symbol : Boolean;
          signal phi_stmt_121_req_323_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_121_310_start <= Xentry_308_symbol; -- control passed to block
          Xentry_311_symbol  <= phi_stmt_121_310_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/$entry
          type_cast_124_313: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_124 
            signal type_cast_124_313_start: Boolean;
            signal Xentry_314_symbol: Boolean;
            signal Xexit_315_symbol: Boolean;
            signal req_316_symbol : Boolean;
            signal ack_317_symbol : Boolean;
            -- 
          begin -- 
            type_cast_124_313_start <= Xentry_311_symbol; -- control passed to block
            Xentry_314_symbol  <= type_cast_124_313_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_124/$entry
            req_316_symbol <= Xentry_314_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_124/req
            ack_317_symbol <= req_316_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_124/ack
            Xexit_315_symbol <= ack_317_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_124/$exit
            type_cast_124_313_symbol <= Xexit_315_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_124
          type_cast_126_318: Block -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_126 
            signal type_cast_126_318_start: Boolean;
            signal Xentry_319_symbol: Boolean;
            signal Xexit_320_symbol: Boolean;
            signal req_321_symbol : Boolean;
            signal ack_322_symbol : Boolean;
            -- 
          begin -- 
            type_cast_126_318_start <= type_cast_124_313_symbol; -- control passed to block
            Xentry_319_symbol  <= type_cast_126_318_start; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_126/$entry
            req_321_symbol <= Xentry_319_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_126/req
            type_cast_126_inst_req_0 <= req_321_symbol; -- link to DP
            ack_322_symbol <= type_cast_126_inst_ack_0; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_126/ack
            Xexit_320_symbol <= ack_322_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_126/$exit
            type_cast_126_318_symbol <= Xexit_320_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/type_cast_126
          phi_stmt_121_req_323_symbol <= type_cast_126_318_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/phi_stmt_121_req
          phi_stmt_121_req_1 <= phi_stmt_121_req_323_symbol; -- link to DP
          Xexit_312_symbol <= phi_stmt_121_req_323_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121/$exit
          phi_stmt_121_310_symbol <= Xexit_312_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq/phi_stmt_121
        Xexit_309_symbol <= phi_stmt_121_310_symbol; -- transition branch_block_stmt_13/bb_1_bb_3_PhiReq/$exit
        bb_1_bb_3_PhiReq_307_symbol <= Xexit_309_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_3_PhiReq
      bb_2_bb_3_PhiReq_324: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq 
        signal bb_2_bb_3_PhiReq_324_start: Boolean;
        signal Xentry_325_symbol: Boolean;
        signal Xexit_326_symbol: Boolean;
        signal phi_stmt_121_327_symbol : Boolean;
        -- 
      begin -- 
        bb_2_bb_3_PhiReq_324_start <= bb_2_bb_3_22_symbol; -- control passed to block
        Xentry_325_symbol  <= bb_2_bb_3_PhiReq_324_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/$entry
        phi_stmt_121_327: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121 
          signal phi_stmt_121_327_start: Boolean;
          signal Xentry_328_symbol: Boolean;
          signal Xexit_329_symbol: Boolean;
          signal type_cast_124_330_symbol : Boolean;
          signal type_cast_126_335_symbol : Boolean;
          signal phi_stmt_121_req_340_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_121_327_start <= Xentry_325_symbol; -- control passed to block
          Xentry_328_symbol  <= phi_stmt_121_327_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/$entry
          type_cast_124_330: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_124 
            signal type_cast_124_330_start: Boolean;
            signal Xentry_331_symbol: Boolean;
            signal Xexit_332_symbol: Boolean;
            signal req_333_symbol : Boolean;
            signal ack_334_symbol : Boolean;
            -- 
          begin -- 
            type_cast_124_330_start <= Xentry_328_symbol; -- control passed to block
            Xentry_331_symbol  <= type_cast_124_330_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_124/$entry
            req_333_symbol <= Xentry_331_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_124/req
            type_cast_124_inst_req_0 <= req_333_symbol; -- link to DP
            ack_334_symbol <= type_cast_124_inst_ack_0; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_124/ack
            Xexit_332_symbol <= ack_334_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_124/$exit
            type_cast_124_330_symbol <= Xexit_332_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_124
          type_cast_126_335: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_126 
            signal type_cast_126_335_start: Boolean;
            signal Xentry_336_symbol: Boolean;
            signal Xexit_337_symbol: Boolean;
            signal req_338_symbol : Boolean;
            signal ack_339_symbol : Boolean;
            -- 
          begin -- 
            type_cast_126_335_start <= type_cast_124_330_symbol; -- control passed to block
            Xentry_336_symbol  <= type_cast_126_335_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_126/$entry
            req_338_symbol <= Xentry_336_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_126/req
            ack_339_symbol <= req_338_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_126/ack
            Xexit_337_symbol <= ack_339_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_126/$exit
            type_cast_126_335_symbol <= Xexit_337_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/type_cast_126
          phi_stmt_121_req_340_symbol <= type_cast_126_335_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/phi_stmt_121_req
          phi_stmt_121_req_0 <= phi_stmt_121_req_340_symbol; -- link to DP
          Xexit_329_symbol <= phi_stmt_121_req_340_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121/$exit
          phi_stmt_121_327_symbol <= Xexit_329_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq/phi_stmt_121
        Xexit_326_symbol <= phi_stmt_121_327_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/$exit
        bb_2_bb_3_PhiReq_324_symbol <= Xexit_326_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq
      merge_stmt_120_PhiReqMerge_341_symbol  <=  bb_1_bb_3_PhiReq_307_symbol or bb_2_bb_3_PhiReq_324_symbol; -- place branch_block_stmt_13/merge_stmt_120_PhiReqMerge (optimized away) 
      merge_stmt_120_PhiAck_342: Block -- branch_block_stmt_13/merge_stmt_120_PhiAck 
        signal merge_stmt_120_PhiAck_342_start: Boolean;
        signal Xentry_343_symbol: Boolean;
        signal Xexit_344_symbol: Boolean;
        signal phi_stmt_121_ack_345_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_120_PhiAck_342_start <= merge_stmt_120_PhiReqMerge_341_symbol; -- control passed to block
        Xentry_343_symbol  <= merge_stmt_120_PhiAck_342_start; -- transition branch_block_stmt_13/merge_stmt_120_PhiAck/$entry
        phi_stmt_121_ack_345_symbol <= phi_stmt_121_ack_0; -- transition branch_block_stmt_13/merge_stmt_120_PhiAck/phi_stmt_121_ack
        Xexit_344_symbol <= phi_stmt_121_ack_345_symbol; -- transition branch_block_stmt_13/merge_stmt_120_PhiAck/$exit
        merge_stmt_120_PhiAck_342_symbol <= Xexit_344_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_120_PhiAck
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
    signal datax_x0_121 : std_logic_vector(63 downto 0);
    signal iNsTr_10_64 : std_logic_vector(63 downto 0);
    signal iNsTr_11_73 : std_logic_vector(0 downto 0);
    signal iNsTr_12_79 : std_logic_vector(31 downto 0);
    signal iNsTr_13_85 : std_logic_vector(31 downto 0);
    signal iNsTr_14_91 : std_logic_vector(31 downto 0);
    signal iNsTr_15_97 : std_logic_vector(31 downto 0);
    signal iNsTr_16_101 : std_logic_vector(63 downto 0);
    signal iNsTr_17_107 : std_logic_vector(63 downto 0);
    signal iNsTr_18_113 : std_logic_vector(63 downto 0);
    signal iNsTr_19_118 : std_logic_vector(63 downto 0);
    signal iNsTr_2_18 : std_logic_vector(7 downto 0);
    signal iNsTr_4_21 : std_logic_vector(63 downto 0);
    signal iNsTr_5_28 : std_logic_vector(0 downto 0);
    signal iNsTr_7_41 : std_logic_vector(63 downto 0);
    signal iNsTr_8_52 : std_logic_vector(31 downto 0);
    signal iNsTr_9_58 : std_logic_vector(31 downto 0);
    signal tmp_46 : std_logic_vector(31 downto 0);
    signal type_cast_105_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_111_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_124_wire : std_logic_vector(63 downto 0);
    signal type_cast_126_wire : std_logic_vector(63 downto 0);
    signal type_cast_25_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_39_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_50_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_55_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_62_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_68_wire : std_logic_vector(63 downto 0);
    signal type_cast_71_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_77_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_83_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_89_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    type_cast_105_wire_constant <= "0000000000000000111111111111111111111111111111111111111111111111";
    type_cast_111_wire_constant <= "0000000000000000000000000000000000000000000000000000000000110000";
    type_cast_25_wire_constant <= "11111111";
    type_cast_39_wire_constant <= "0000000000000000000000000000000000000000000000000000000000010000";
    type_cast_50_wire_constant <= "00000000000000001111111111111111";
    type_cast_55_wire_constant <= "00000000000000000000000000000001";
    type_cast_62_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000001";
    type_cast_71_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000000";
    type_cast_77_wire_constant <= "00000000000000000000000000000001";
    type_cast_83_wire_constant <= "00000000000000000111111111111111";
    type_cast_89_wire_constant <= "00000000000000000000000000000001";
    phi_stmt_121: Block -- phi operator 
      signal idata: std_logic_vector(127 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= type_cast_124_wire & type_cast_126_wire;
      req <= phi_stmt_121_req_0 & phi_stmt_121_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 64) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_121_ack_0,
          idata => idata,
          odata => datax_x0_121,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_121
    ternary_96_inst: SelectBase generic map(data_width => 32) -- 
      port map( x => iNsTr_13_85, y => iNsTr_14_91, sel => iNsTr_11_73, z => iNsTr_15_97, req => ternary_96_inst_req_0, ack => ternary_96_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_100_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 64, flow_through => false ) 
      port map( din => iNsTr_15_97, dout => iNsTr_16_101, req => type_cast_100_inst_req_0, ack => type_cast_100_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_124_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_19_118, dout => type_cast_124_wire, req => type_cast_124_inst_req_0, ack => type_cast_124_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_126_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_4_21, dout => type_cast_126_wire, req => type_cast_126_inst_req_0, ack => type_cast_126_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_45_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_7_41, dout => tmp_46, req => type_cast_45_inst_req_0, ack => type_cast_45_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_68_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_10_64, dout => type_cast_68_wire, req => type_cast_68_inst_req_0, ack => type_cast_68_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_29_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_5_28;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_29_branch_req_0,
          ack0 => if_stmt_29_branch_ack_0,
          ack1 => if_stmt_29_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_106_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_21;
      iNsTr_17_107 <= data_out(63 downto 0);
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
          reqL => binary_106_inst_req_0,
          ackL => binary_106_inst_ack_0,
          reqR => binary_106_inst_req_1,
          ackR => binary_106_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_112_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_16_101;
      iNsTr_18_113 <= data_out(63 downto 0);
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
          reqL => binary_112_inst_req_0,
          ackL => binary_112_inst_ack_0,
          reqR => binary_112_inst_req_1,
          ackR => binary_112_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_117_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_18_113 & iNsTr_17_107;
      iNsTr_19_118 <= data_out(63 downto 0);
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
          reqL => binary_117_inst_req_0,
          ackL => binary_117_inst_ack_0,
          reqR => binary_117_inst_req_1,
          ackR => binary_117_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_26_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_2_18;
      iNsTr_5_28 <= data_out(0 downto 0);
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
          reqL => binary_26_inst_req_0,
          ackL => binary_26_inst_ack_0,
          reqR => binary_26_inst_req_1,
          ackR => binary_26_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_40_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_21;
      iNsTr_7_41 <= data_out(63 downto 0);
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
          reqL => binary_40_inst_req_0,
          ackL => binary_40_inst_ack_0,
          reqR => binary_40_inst_req_1,
          ackR => binary_40_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_51_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= tmp_46;
      iNsTr_8_52 <= data_out(31 downto 0);
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
          reqL => binary_51_inst_req_0,
          ackL => binary_51_inst_ack_0,
          reqR => binary_51_inst_req_1,
          ackR => binary_51_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_57_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_55_wire_constant & iNsTr_8_52;
      iNsTr_9_58 <= data_out(31 downto 0);
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
          reqL => binary_57_inst_req_0,
          ackL => binary_57_inst_ack_0,
          reqR => binary_57_inst_req_1,
          ackR => binary_57_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_63_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_7_41;
      iNsTr_10_64 <= data_out(63 downto 0);
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
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_72_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_68_wire;
      iNsTr_11_73 <= data_out(0 downto 0);
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
          reqL => binary_72_inst_req_0,
          ackL => binary_72_inst_ack_0,
          reqR => binary_72_inst_req_1,
          ackR => binary_72_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_78_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_58;
      iNsTr_12_79 <= data_out(31 downto 0);
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
          reqL => binary_78_inst_req_0,
          ackL => binary_78_inst_ack_0,
          reqR => binary_78_inst_req_1,
          ackR => binary_78_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_84_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_12_79;
      iNsTr_13_85 <= data_out(31 downto 0);
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
          reqL => binary_84_inst_req_0,
          ackL => binary_84_inst_ack_0,
          reqR => binary_84_inst_req_1,
          ackR => binary_84_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_90_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_58;
      iNsTr_14_91 <= data_out(31 downto 0);
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
          reqL => binary_90_inst_req_0,
          ackL => binary_90_inst_ack_0,
          reqR => binary_90_inst_req_1,
          ackR => binary_90_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared inport operator group (0) : simple_obj_ref_17_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_17_inst_req_0;
      simple_obj_ref_17_inst_ack_0 <= ack(0);
      iNsTr_2_18 <= data_out(7 downto 0);
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
    -- shared inport operator group (1) : simple_obj_ref_20_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_20_inst_req_0;
      simple_obj_ref_20_inst_ack_0 <= ack(0);
      iNsTr_4_21 <= data_out(63 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_128_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_128_inst_req_0;
      simple_obj_ref_128_inst_ack_0 <= ack(0);
      data_in <= iNsTr_2_18;
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
    -- shared outport operator group (1) : simple_obj_ref_131_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_131_inst_req_0;
      simple_obj_ref_131_inst_ack_0 <= ack(0);
      data_in <= datax_x0_121;
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
