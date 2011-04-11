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
library work;
use work.vc_system_package.all;
entity sum_mod is -- 
  port ( -- 
    a : in  std_logic_vector(9 downto 0);
    b : out  std_logic_vector(9 downto 0);
    test : out  std_logic_vector(0 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity sum_mod;
architecture Default of sum_mod is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal binary_20_inst_ack_1 : boolean;
  signal binary_25_inst_req_0 : boolean;
  signal binary_25_inst_ack_0 : boolean;
  signal binary_25_inst_req_1 : boolean;
  signal binary_25_inst_ack_1 : boolean;
  signal binary_20_inst_req_0 : boolean;
  signal binary_20_inst_ack_0 : boolean;
  signal binary_20_inst_req_1 : boolean;
  signal switch_stmt_27_branch_default_req_0 : boolean;
  signal switch_stmt_27_branch_0_ack_1 : boolean;
  signal switch_stmt_27_branch_1_ack_1 : boolean;
  signal switch_stmt_27_branch_2_ack_1 : boolean;
  signal switch_stmt_27_branch_default_ack_0 : boolean;
  signal phi_stmt_8_req_0 : boolean;
  signal phi_stmt_12_req_0 : boolean;
  signal phi_stmt_12_req_1 : boolean;
  signal switch_stmt_27_select_expr_0_req_0 : boolean;
  signal switch_stmt_27_select_expr_0_ack_0 : boolean;
  signal switch_stmt_27_select_expr_0_req_1 : boolean;
  signal switch_stmt_27_select_expr_0_ack_1 : boolean;
  signal switch_stmt_27_branch_0_req_0 : boolean;
  signal switch_stmt_27_select_expr_1_req_0 : boolean;
  signal switch_stmt_27_select_expr_1_ack_0 : boolean;
  signal switch_stmt_27_select_expr_1_req_1 : boolean;
  signal switch_stmt_27_select_expr_1_ack_1 : boolean;
  signal switch_stmt_27_branch_1_req_0 : boolean;
  signal switch_stmt_27_select_expr_2_req_0 : boolean;
  signal switch_stmt_27_select_expr_2_ack_0 : boolean;
  signal switch_stmt_27_select_expr_2_req_1 : boolean;
  signal switch_stmt_27_select_expr_2_ack_1 : boolean;
  signal switch_stmt_27_branch_2_req_0 : boolean;
  signal phi_stmt_8_req_1 : boolean;
  signal phi_stmt_8_ack_0 : boolean;
  signal phi_stmt_12_ack_0 : boolean;
  signal binary_55_inst_req_0 : boolean;
  signal binary_55_inst_ack_0 : boolean;
  signal binary_55_inst_req_1 : boolean;
  signal binary_55_inst_ack_1 : boolean;
  signal binary_60_inst_req_0 : boolean;
  signal binary_60_inst_ack_0 : boolean;
  signal binary_60_inst_req_1 : boolean;
  signal binary_60_inst_ack_1 : boolean;
  signal binary_65_inst_req_0 : boolean;
  signal binary_65_inst_ack_0 : boolean;
  signal binary_65_inst_req_1 : boolean;
  signal binary_65_inst_ack_1 : boolean;
  signal if_stmt_62_branch_req_0 : boolean;
  signal if_stmt_62_branch_ack_1 : boolean;
  signal if_stmt_62_branch_ack_0 : boolean;
  signal phi_stmt_43_req_0 : boolean;
  signal phi_stmt_47_req_0 : boolean;
  signal phi_stmt_43_req_1 : boolean;
  signal phi_stmt_47_req_1 : boolean;
  signal phi_stmt_43_ack_0 : boolean;
  signal phi_stmt_47_ack_0 : boolean;
  signal simple_obj_ref_71_inst_req_0 : boolean;
  signal simple_obj_ref_71_inst_ack_0 : boolean;
  signal binary_77_inst_req_0 : boolean;
  signal binary_77_inst_ack_0 : boolean;
  signal binary_77_inst_req_1 : boolean;
  signal binary_77_inst_ack_1 : boolean;
  -- 
begin --  
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
  sum_mod_CP_0: Block -- control-path 
    signal sum_mod_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_6_3_symbol : Boolean;
    signal branch_block_stmt_41_124_symbol : Boolean;
    signal assign_stmt_73_to_assign_stmt_78_223_symbol : Boolean;
    -- 
  begin -- 
    sum_mod_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= sum_mod_CP_0_start; -- transition $entry
    branch_block_stmt_6_3: Block -- branch_block_stmt_6 
      signal branch_block_stmt_6_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_6_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_6_x_xexit_x_xx_x7_symbol : Boolean;
      signal merge_stmt_7_x_xentry_x_xx_x8_symbol : Boolean;
      signal merge_stmt_7_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_21_to_assign_stmt_26_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_21_to_assign_stmt_26_x_xexit_x_xx_x11_symbol : Boolean;
      signal switch_stmt_27_x_xentry_x_xx_x12_symbol : Boolean;
      signal switch_stmt_27_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_21_to_assign_stmt_26_14_symbol : Boolean;
      signal switch_stmt_27_dead_link_41_symbol : Boolean;
      signal switch_stmt_27_x_xcondition_check_place_x_xx_x45_symbol : Boolean;
      signal switch_stmt_27_x_xcondition_check_x_xx_x46_symbol : Boolean;
      signal switch_stmt_27_x_xselect_x_xx_x73_symbol : Boolean;
      signal switch_stmt_27_choice_0_74_symbol : Boolean;
      signal loopback_78_symbol : Boolean;
      signal switch_stmt_27_choice_1_79_symbol : Boolean;
      signal switch_stmt_27_choice_2_83_symbol : Boolean;
      signal switch_stmt_27_choice_default_87_symbol : Boolean;
      signal switch_stmt_27_choice_default_to_switch_stmt_27_x_xexit_x_xx_x91_symbol : Boolean;
      signal merge_stmt_7_dead_link_92_symbol : Boolean;
      signal merge_stmt_7_x_xentry_x_xx_xPhiReq_96_symbol : Boolean;
      signal loopback_PhiReq_107_symbol : Boolean;
      signal merge_stmt_7_PhiReqMerge_118_symbol : Boolean;
      signal merge_stmt_7_PhiAck_119_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_6_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_6_3_start; -- transition branch_block_stmt_6/$entry
      branch_block_stmt_6_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_6/branch_block_stmt_6__entry__ (optimized away) 
      branch_block_stmt_6_x_xexit_x_xx_x7_symbol  <=  switch_stmt_27_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_6/branch_block_stmt_6__exit__ (optimized away) 
      merge_stmt_7_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_6_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_6/merge_stmt_7__entry__ (optimized away) 
      merge_stmt_7_x_xexit_x_xx_x9_symbol  <=  merge_stmt_7_dead_link_92_symbol or merge_stmt_7_PhiAck_119_symbol; -- place branch_block_stmt_6/merge_stmt_7__exit__ (optimized away) 
      assign_stmt_21_to_assign_stmt_26_x_xentry_x_xx_x10_symbol  <=  merge_stmt_7_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26__entry__ (optimized away) 
      assign_stmt_21_to_assign_stmt_26_x_xexit_x_xx_x11_symbol  <=  assign_stmt_21_to_assign_stmt_26_14_symbol; -- place branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26__exit__ (optimized away) 
      switch_stmt_27_x_xentry_x_xx_x12_symbol  <=  assign_stmt_21_to_assign_stmt_26_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_6/switch_stmt_27__entry__ (optimized away) 
      switch_stmt_27_x_xexit_x_xx_x13_symbol  <=  switch_stmt_27_choice_default_to_switch_stmt_27_x_xexit_x_xx_x91_symbol or switch_stmt_27_dead_link_41_symbol; -- place branch_block_stmt_6/switch_stmt_27__exit__ (optimized away) 
      assign_stmt_21_to_assign_stmt_26_14: Block -- branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26 
        signal assign_stmt_21_to_assign_stmt_26_14_start: Boolean;
        signal Xentry_15_symbol: Boolean;
        signal Xexit_16_symbol: Boolean;
        signal assign_stmt_21_active_x_x17_symbol : Boolean;
        signal assign_stmt_21_completed_x_x18_symbol : Boolean;
        signal binary_20_active_x_x19_symbol : Boolean;
        signal binary_20_trigger_x_x20_symbol : Boolean;
        signal simple_obj_ref_18_complete_21_symbol : Boolean;
        signal binary_20_complete_22_symbol : Boolean;
        signal assign_stmt_26_active_x_x29_symbol : Boolean;
        signal assign_stmt_26_completed_x_x30_symbol : Boolean;
        signal binary_25_active_x_x31_symbol : Boolean;
        signal binary_25_trigger_x_x32_symbol : Boolean;
        signal simple_obj_ref_23_complete_33_symbol : Boolean;
        signal binary_25_complete_34_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_21_to_assign_stmt_26_14_start <= assign_stmt_21_to_assign_stmt_26_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_15_symbol  <= assign_stmt_21_to_assign_stmt_26_14_start; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/$entry
        assign_stmt_21_active_x_x17_symbol <= binary_20_complete_22_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/assign_stmt_21_active_
        assign_stmt_21_completed_x_x18_symbol <= assign_stmt_21_active_x_x17_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/assign_stmt_21_completed_
        binary_20_active_x_x19_block : Block -- non-trivial join transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_active_ 
          signal binary_20_active_x_x19_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_20_active_x_x19_predecessors(0) <= binary_20_trigger_x_x20_symbol;
          binary_20_active_x_x19_predecessors(1) <= simple_obj_ref_18_complete_21_symbol;
          binary_20_active_x_x19_join: join -- 
            port map( -- 
              preds => binary_20_active_x_x19_predecessors,
              symbol_out => binary_20_active_x_x19_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_active_
        binary_20_trigger_x_x20_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_trigger_
        simple_obj_ref_18_complete_21_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/simple_obj_ref_18_complete
        binary_20_complete_22: Block -- branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete 
          signal binary_20_complete_22_start: Boolean;
          signal Xentry_23_symbol: Boolean;
          signal Xexit_24_symbol: Boolean;
          signal rr_25_symbol : Boolean;
          signal ra_26_symbol : Boolean;
          signal cr_27_symbol : Boolean;
          signal ca_28_symbol : Boolean;
          -- 
        begin -- 
          binary_20_complete_22_start <= binary_20_active_x_x19_symbol; -- control passed to block
          Xentry_23_symbol  <= binary_20_complete_22_start; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete/$entry
          rr_25_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete/rr
          binary_20_inst_req_0 <= rr_25_symbol; -- link to DP
          ra_26_symbol <= binary_20_inst_ack_0; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete/ra
          cr_27_symbol <= ra_26_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete/cr
          binary_20_inst_req_1 <= cr_27_symbol; -- link to DP
          ca_28_symbol <= binary_20_inst_ack_1; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete/ca
          Xexit_24_symbol <= ca_28_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete/$exit
          binary_20_complete_22_symbol <= Xexit_24_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_20_complete
        assign_stmt_26_active_x_x29_symbol <= binary_25_complete_34_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/assign_stmt_26_active_
        assign_stmt_26_completed_x_x30_symbol <= assign_stmt_26_active_x_x29_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/assign_stmt_26_completed_
        binary_25_active_x_x31_block : Block -- non-trivial join transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_active_ 
          signal binary_25_active_x_x31_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_25_active_x_x31_predecessors(0) <= binary_25_trigger_x_x32_symbol;
          binary_25_active_x_x31_predecessors(1) <= simple_obj_ref_23_complete_33_symbol;
          binary_25_active_x_x31_join: join -- 
            port map( -- 
              preds => binary_25_active_x_x31_predecessors,
              symbol_out => binary_25_active_x_x31_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_active_
        binary_25_trigger_x_x32_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_trigger_
        simple_obj_ref_23_complete_33_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/simple_obj_ref_23_complete
        binary_25_complete_34: Block -- branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete 
          signal binary_25_complete_34_start: Boolean;
          signal Xentry_35_symbol: Boolean;
          signal Xexit_36_symbol: Boolean;
          signal rr_37_symbol : Boolean;
          signal ra_38_symbol : Boolean;
          signal cr_39_symbol : Boolean;
          signal ca_40_symbol : Boolean;
          -- 
        begin -- 
          binary_25_complete_34_start <= binary_25_active_x_x31_symbol; -- control passed to block
          Xentry_35_symbol  <= binary_25_complete_34_start; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete/$entry
          rr_37_symbol <= Xentry_35_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete/rr
          binary_25_inst_req_0 <= rr_37_symbol; -- link to DP
          ra_38_symbol <= binary_25_inst_ack_0; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete/ra
          cr_39_symbol <= ra_38_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete/cr
          binary_25_inst_req_1 <= cr_39_symbol; -- link to DP
          ca_40_symbol <= binary_25_inst_ack_1; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete/ca
          Xexit_36_symbol <= ca_40_symbol; -- transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete/$exit
          binary_25_complete_34_symbol <= Xexit_36_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/binary_25_complete
        Xexit_16_block : Block -- non-trivial join transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/$exit 
          signal Xexit_16_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_16_predecessors(0) <= assign_stmt_21_completed_x_x18_symbol;
          Xexit_16_predecessors(1) <= assign_stmt_26_completed_x_x30_symbol;
          Xexit_16_join: join -- 
            port map( -- 
              preds => Xexit_16_predecessors,
              symbol_out => Xexit_16_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26/$exit
        assign_stmt_21_to_assign_stmt_26_14_symbol <= Xexit_16_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/assign_stmt_21_to_assign_stmt_26
      switch_stmt_27_dead_link_41: Block -- branch_block_stmt_6/switch_stmt_27_dead_link 
        signal switch_stmt_27_dead_link_41_start: Boolean;
        signal Xentry_42_symbol: Boolean;
        signal Xexit_43_symbol: Boolean;
        signal dead_transition_44_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_dead_link_41_start <= switch_stmt_27_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_42_symbol  <= switch_stmt_27_dead_link_41_start; -- transition branch_block_stmt_6/switch_stmt_27_dead_link/$entry
        dead_transition_44_symbol <= false;
        Xexit_43_symbol <= dead_transition_44_symbol; -- transition branch_block_stmt_6/switch_stmt_27_dead_link/$exit
        switch_stmt_27_dead_link_41_symbol <= Xexit_43_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_dead_link
      switch_stmt_27_x_xcondition_check_place_x_xx_x45_symbol  <=  switch_stmt_27_x_xentry_x_xx_x12_symbol; -- place branch_block_stmt_6/switch_stmt_27__condition_check_place__ (optimized away) 
      switch_stmt_27_x_xcondition_check_x_xx_x46: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__ 
        signal switch_stmt_27_x_xcondition_check_x_xx_x46_start: Boolean;
        signal Xentry_47_symbol: Boolean;
        signal Xexit_48_symbol: Boolean;
        signal condition_0_49_symbol : Boolean;
        signal condition_1_57_symbol : Boolean;
        signal condition_2_65_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_x_xcondition_check_x_xx_x46_start <= switch_stmt_27_x_xcondition_check_place_x_xx_x45_symbol; -- control passed to block
        Xentry_47_symbol  <= switch_stmt_27_x_xcondition_check_x_xx_x46_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/$entry
        condition_0_49: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0 
          signal condition_0_49_start: Boolean;
          signal Xentry_50_symbol: Boolean;
          signal Xexit_51_symbol: Boolean;
          signal rr_52_symbol : Boolean;
          signal ra_53_symbol : Boolean;
          signal cr_54_symbol : Boolean;
          signal ca_55_symbol : Boolean;
          signal cmp_56_symbol : Boolean;
          -- 
        begin -- 
          condition_0_49_start <= Xentry_47_symbol; -- control passed to block
          Xentry_50_symbol  <= condition_0_49_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/$entry
          rr_52_symbol <= Xentry_50_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/rr
          switch_stmt_27_select_expr_0_req_0 <= rr_52_symbol; -- link to DP
          ra_53_symbol <= switch_stmt_27_select_expr_0_ack_0; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/ra
          cr_54_symbol <= ra_53_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/cr
          switch_stmt_27_select_expr_0_req_1 <= cr_54_symbol; -- link to DP
          ca_55_symbol <= switch_stmt_27_select_expr_0_ack_1; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/ca
          cmp_56_symbol <= ca_55_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/cmp
          switch_stmt_27_branch_0_req_0 <= cmp_56_symbol; -- link to DP
          Xexit_51_symbol <= cmp_56_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/$exit
          condition_0_49_symbol <= Xexit_51_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0
        condition_1_57: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1 
          signal condition_1_57_start: Boolean;
          signal Xentry_58_symbol: Boolean;
          signal Xexit_59_symbol: Boolean;
          signal rr_60_symbol : Boolean;
          signal ra_61_symbol : Boolean;
          signal cr_62_symbol : Boolean;
          signal ca_63_symbol : Boolean;
          signal cmp_64_symbol : Boolean;
          -- 
        begin -- 
          condition_1_57_start <= Xentry_47_symbol; -- control passed to block
          Xentry_58_symbol  <= condition_1_57_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/$entry
          rr_60_symbol <= Xentry_58_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/rr
          switch_stmt_27_select_expr_1_req_0 <= rr_60_symbol; -- link to DP
          ra_61_symbol <= switch_stmt_27_select_expr_1_ack_0; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/ra
          cr_62_symbol <= ra_61_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/cr
          switch_stmt_27_select_expr_1_req_1 <= cr_62_symbol; -- link to DP
          ca_63_symbol <= switch_stmt_27_select_expr_1_ack_1; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/ca
          cmp_64_symbol <= ca_63_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/cmp
          switch_stmt_27_branch_1_req_0 <= cmp_64_symbol; -- link to DP
          Xexit_59_symbol <= cmp_64_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/$exit
          condition_1_57_symbol <= Xexit_59_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1
        condition_2_65: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2 
          signal condition_2_65_start: Boolean;
          signal Xentry_66_symbol: Boolean;
          signal Xexit_67_symbol: Boolean;
          signal rr_68_symbol : Boolean;
          signal ra_69_symbol : Boolean;
          signal cr_70_symbol : Boolean;
          signal ca_71_symbol : Boolean;
          signal cmp_72_symbol : Boolean;
          -- 
        begin -- 
          condition_2_65_start <= Xentry_47_symbol; -- control passed to block
          Xentry_66_symbol  <= condition_2_65_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/$entry
          rr_68_symbol <= Xentry_66_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/rr
          switch_stmt_27_select_expr_2_req_0 <= rr_68_symbol; -- link to DP
          ra_69_symbol <= switch_stmt_27_select_expr_2_ack_0; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/ra
          cr_70_symbol <= ra_69_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/cr
          switch_stmt_27_select_expr_2_req_1 <= cr_70_symbol; -- link to DP
          ca_71_symbol <= switch_stmt_27_select_expr_2_ack_1; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/ca
          cmp_72_symbol <= ca_71_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/cmp
          switch_stmt_27_branch_2_req_0 <= cmp_72_symbol; -- link to DP
          Xexit_67_symbol <= cmp_72_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/$exit
          condition_2_65_symbol <= Xexit_67_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2
        Xexit_48_block : Block -- non-trivial join transition branch_block_stmt_6/switch_stmt_27__condition_check__/$exit 
          signal Xexit_48_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          Xexit_48_predecessors(0) <= condition_0_49_symbol;
          Xexit_48_predecessors(1) <= condition_1_57_symbol;
          Xexit_48_predecessors(2) <= condition_2_65_symbol;
          Xexit_48_join: join -- 
            port map( -- 
              preds => Xexit_48_predecessors,
              symbol_out => Xexit_48_symbol,
              clk => clk,
              reset => reset); -- 
          switch_stmt_27_branch_default_req_0 <= Xexit_48_symbol; -- link to DP
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/switch_stmt_27__condition_check__/$exit
        switch_stmt_27_x_xcondition_check_x_xx_x46_symbol <= Xexit_48_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__
      switch_stmt_27_x_xselect_x_xx_x73_symbol  <=  switch_stmt_27_x_xcondition_check_x_xx_x46_symbol; -- place branch_block_stmt_6/switch_stmt_27__select__ (optimized away) 
      switch_stmt_27_choice_0_74: Block -- branch_block_stmt_6/switch_stmt_27_choice_0 
        signal switch_stmt_27_choice_0_74_start: Boolean;
        signal Xentry_75_symbol: Boolean;
        signal Xexit_76_symbol: Boolean;
        signal ack1_77_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_0_74_start <= switch_stmt_27_x_xselect_x_xx_x73_symbol; -- control passed to block
        Xentry_75_symbol  <= switch_stmt_27_choice_0_74_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_0/$entry
        ack1_77_symbol <= switch_stmt_27_branch_0_ack_1; -- transition branch_block_stmt_6/switch_stmt_27_choice_0/ack1
        Xexit_76_symbol <= ack1_77_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_0/$exit
        switch_stmt_27_choice_0_74_symbol <= Xexit_76_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_0
      loopback_78_symbol  <=  switch_stmt_27_choice_0_74_symbol or switch_stmt_27_choice_1_79_symbol or switch_stmt_27_choice_2_83_symbol; -- place branch_block_stmt_6/loopback (optimized away) 
      switch_stmt_27_choice_1_79: Block -- branch_block_stmt_6/switch_stmt_27_choice_1 
        signal switch_stmt_27_choice_1_79_start: Boolean;
        signal Xentry_80_symbol: Boolean;
        signal Xexit_81_symbol: Boolean;
        signal ack1_82_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_1_79_start <= switch_stmt_27_x_xselect_x_xx_x73_symbol; -- control passed to block
        Xentry_80_symbol  <= switch_stmt_27_choice_1_79_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_1/$entry
        ack1_82_symbol <= switch_stmt_27_branch_1_ack_1; -- transition branch_block_stmt_6/switch_stmt_27_choice_1/ack1
        Xexit_81_symbol <= ack1_82_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_1/$exit
        switch_stmt_27_choice_1_79_symbol <= Xexit_81_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_1
      switch_stmt_27_choice_2_83: Block -- branch_block_stmt_6/switch_stmt_27_choice_2 
        signal switch_stmt_27_choice_2_83_start: Boolean;
        signal Xentry_84_symbol: Boolean;
        signal Xexit_85_symbol: Boolean;
        signal ack1_86_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_2_83_start <= switch_stmt_27_x_xselect_x_xx_x73_symbol; -- control passed to block
        Xentry_84_symbol  <= switch_stmt_27_choice_2_83_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_2/$entry
        ack1_86_symbol <= switch_stmt_27_branch_2_ack_1; -- transition branch_block_stmt_6/switch_stmt_27_choice_2/ack1
        Xexit_85_symbol <= ack1_86_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_2/$exit
        switch_stmt_27_choice_2_83_symbol <= Xexit_85_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_2
      switch_stmt_27_choice_default_87: Block -- branch_block_stmt_6/switch_stmt_27_choice_default 
        signal switch_stmt_27_choice_default_87_start: Boolean;
        signal Xentry_88_symbol: Boolean;
        signal Xexit_89_symbol: Boolean;
        signal ack0_90_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_default_87_start <= switch_stmt_27_x_xselect_x_xx_x73_symbol; -- control passed to block
        Xentry_88_symbol  <= switch_stmt_27_choice_default_87_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_default/$entry
        ack0_90_symbol <= switch_stmt_27_branch_default_ack_0; -- transition branch_block_stmt_6/switch_stmt_27_choice_default/ack0
        Xexit_89_symbol <= ack0_90_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_default/$exit
        switch_stmt_27_choice_default_87_symbol <= Xexit_89_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_default
      switch_stmt_27_choice_default_to_switch_stmt_27_x_xexit_x_xx_x91_symbol  <=  switch_stmt_27_choice_default_87_symbol; -- place branch_block_stmt_6/switch_stmt_27_choice_default_to_switch_stmt_27__exit__ (optimized away) 
      merge_stmt_7_dead_link_92: Block -- branch_block_stmt_6/merge_stmt_7_dead_link 
        signal merge_stmt_7_dead_link_92_start: Boolean;
        signal Xentry_93_symbol: Boolean;
        signal Xexit_94_symbol: Boolean;
        signal dead_transition_95_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_7_dead_link_92_start <= merge_stmt_7_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_93_symbol  <= merge_stmt_7_dead_link_92_start; -- transition branch_block_stmt_6/merge_stmt_7_dead_link/$entry
        dead_transition_95_symbol <= false;
        Xexit_94_symbol <= dead_transition_95_symbol; -- transition branch_block_stmt_6/merge_stmt_7_dead_link/$exit
        merge_stmt_7_dead_link_92_symbol <= Xexit_94_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/merge_stmt_7_dead_link
      merge_stmt_7_x_xentry_x_xx_xPhiReq_96: Block -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq 
        signal merge_stmt_7_x_xentry_x_xx_xPhiReq_96_start: Boolean;
        signal Xentry_97_symbol: Boolean;
        signal Xexit_98_symbol: Boolean;
        signal phi_stmt_8_99_symbol : Boolean;
        signal phi_stmt_12_103_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_7_x_xentry_x_xx_xPhiReq_96_start <= merge_stmt_7_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_97_symbol  <= merge_stmt_7_x_xentry_x_xx_xPhiReq_96_start; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/$entry
        phi_stmt_8_99: Block -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8 
          signal phi_stmt_8_99_start: Boolean;
          signal Xentry_100_symbol: Boolean;
          signal Xexit_101_symbol: Boolean;
          signal phi_stmt_8_req_102_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_8_99_start <= Xentry_97_symbol; -- control passed to block
          Xentry_100_symbol  <= phi_stmt_8_99_start; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8/$entry
          phi_stmt_8_req_102_symbol <= Xentry_100_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8/phi_stmt_8_req
          phi_stmt_8_req_0 <= phi_stmt_8_req_102_symbol; -- link to DP
          Xexit_101_symbol <= phi_stmt_8_req_102_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8/$exit
          phi_stmt_8_99_symbol <= Xexit_101_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8
        phi_stmt_12_103: Block -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12 
          signal phi_stmt_12_103_start: Boolean;
          signal Xentry_104_symbol: Boolean;
          signal Xexit_105_symbol: Boolean;
          signal phi_stmt_12_req_106_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_12_103_start <= Xentry_97_symbol; -- control passed to block
          Xentry_104_symbol  <= phi_stmt_12_103_start; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12/$entry
          phi_stmt_12_req_106_symbol <= Xentry_104_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12/phi_stmt_12_req
          phi_stmt_12_req_0 <= phi_stmt_12_req_106_symbol; -- link to DP
          Xexit_105_symbol <= phi_stmt_12_req_106_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12/$exit
          phi_stmt_12_103_symbol <= Xexit_105_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12
        Xexit_98_block : Block -- non-trivial join transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/$exit 
          signal Xexit_98_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_98_predecessors(0) <= phi_stmt_8_99_symbol;
          Xexit_98_predecessors(1) <= phi_stmt_12_103_symbol;
          Xexit_98_join: join -- 
            port map( -- 
              preds => Xexit_98_predecessors,
              symbol_out => Xexit_98_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/$exit
        merge_stmt_7_x_xentry_x_xx_xPhiReq_96_symbol <= Xexit_98_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq
      loopback_PhiReq_107: Block -- branch_block_stmt_6/loopback_PhiReq 
        signal loopback_PhiReq_107_start: Boolean;
        signal Xentry_108_symbol: Boolean;
        signal Xexit_109_symbol: Boolean;
        signal phi_stmt_8_110_symbol : Boolean;
        signal phi_stmt_12_114_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_107_start <= loopback_78_symbol; -- control passed to block
        Xentry_108_symbol  <= loopback_PhiReq_107_start; -- transition branch_block_stmt_6/loopback_PhiReq/$entry
        phi_stmt_8_110: Block -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_8 
          signal phi_stmt_8_110_start: Boolean;
          signal Xentry_111_symbol: Boolean;
          signal Xexit_112_symbol: Boolean;
          signal phi_stmt_8_req_113_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_8_110_start <= Xentry_108_symbol; -- control passed to block
          Xentry_111_symbol  <= phi_stmt_8_110_start; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_8/$entry
          phi_stmt_8_req_113_symbol <= Xentry_111_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_8/phi_stmt_8_req
          phi_stmt_8_req_1 <= phi_stmt_8_req_113_symbol; -- link to DP
          Xexit_112_symbol <= phi_stmt_8_req_113_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_8/$exit
          phi_stmt_8_110_symbol <= Xexit_112_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_8
        phi_stmt_12_114: Block -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_12 
          signal phi_stmt_12_114_start: Boolean;
          signal Xentry_115_symbol: Boolean;
          signal Xexit_116_symbol: Boolean;
          signal phi_stmt_12_req_117_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_12_114_start <= Xentry_108_symbol; -- control passed to block
          Xentry_115_symbol  <= phi_stmt_12_114_start; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_12/$entry
          phi_stmt_12_req_117_symbol <= Xentry_115_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_12/phi_stmt_12_req
          phi_stmt_12_req_1 <= phi_stmt_12_req_117_symbol; -- link to DP
          Xexit_116_symbol <= phi_stmt_12_req_117_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_12/$exit
          phi_stmt_12_114_symbol <= Xexit_116_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_12
        Xexit_109_block : Block -- non-trivial join transition branch_block_stmt_6/loopback_PhiReq/$exit 
          signal Xexit_109_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_109_predecessors(0) <= phi_stmt_8_110_symbol;
          Xexit_109_predecessors(1) <= phi_stmt_12_114_symbol;
          Xexit_109_join: join -- 
            port map( -- 
              preds => Xexit_109_predecessors,
              symbol_out => Xexit_109_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/loopback_PhiReq/$exit
        loopback_PhiReq_107_symbol <= Xexit_109_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/loopback_PhiReq
      merge_stmt_7_PhiReqMerge_118_symbol  <=  merge_stmt_7_x_xentry_x_xx_xPhiReq_96_symbol or loopback_PhiReq_107_symbol; -- place branch_block_stmt_6/merge_stmt_7_PhiReqMerge (optimized away) 
      merge_stmt_7_PhiAck_119: Block -- branch_block_stmt_6/merge_stmt_7_PhiAck 
        signal merge_stmt_7_PhiAck_119_start: Boolean;
        signal Xentry_120_symbol: Boolean;
        signal Xexit_121_symbol: Boolean;
        signal phi_stmt_8_ack_122_symbol : Boolean;
        signal phi_stmt_12_ack_123_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_7_PhiAck_119_start <= merge_stmt_7_PhiReqMerge_118_symbol; -- control passed to block
        Xentry_120_symbol  <= merge_stmt_7_PhiAck_119_start; -- transition branch_block_stmt_6/merge_stmt_7_PhiAck/$entry
        phi_stmt_8_ack_122_symbol <= phi_stmt_8_ack_0; -- transition branch_block_stmt_6/merge_stmt_7_PhiAck/phi_stmt_8_ack
        phi_stmt_12_ack_123_symbol <= phi_stmt_12_ack_0; -- transition branch_block_stmt_6/merge_stmt_7_PhiAck/phi_stmt_12_ack
        Xexit_121_block : Block -- non-trivial join transition branch_block_stmt_6/merge_stmt_7_PhiAck/$exit 
          signal Xexit_121_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_121_predecessors(0) <= phi_stmt_8_ack_122_symbol;
          Xexit_121_predecessors(1) <= phi_stmt_12_ack_123_symbol;
          Xexit_121_join: join -- 
            port map( -- 
              preds => Xexit_121_predecessors,
              symbol_out => Xexit_121_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/merge_stmt_7_PhiAck/$exit
        merge_stmt_7_PhiAck_119_symbol <= Xexit_121_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/merge_stmt_7_PhiAck
      Xexit_5_symbol <= branch_block_stmt_6_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_6/$exit
      branch_block_stmt_6_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_6
    branch_block_stmt_41_124: Block -- branch_block_stmt_41 
      signal branch_block_stmt_41_124_start: Boolean;
      signal Xentry_125_symbol: Boolean;
      signal Xexit_126_symbol: Boolean;
      signal branch_block_stmt_41_x_xentry_x_xx_x127_symbol : Boolean;
      signal branch_block_stmt_41_x_xexit_x_xx_x128_symbol : Boolean;
      signal merge_stmt_42_x_xentry_x_xx_x129_symbol : Boolean;
      signal merge_stmt_42_x_xexit_x_xx_x130_symbol : Boolean;
      signal assign_stmt_56_to_assign_stmt_61_x_xentry_x_xx_x131_symbol : Boolean;
      signal assign_stmt_56_to_assign_stmt_61_x_xexit_x_xx_x132_symbol : Boolean;
      signal if_stmt_62_x_xentry_x_xx_x133_symbol : Boolean;
      signal if_stmt_62_x_xexit_x_xx_x134_symbol : Boolean;
      signal assign_stmt_56_to_assign_stmt_61_135_symbol : Boolean;
      signal if_stmt_62_dead_link_162_symbol : Boolean;
      signal if_stmt_62_eval_test_166_symbol : Boolean;
      signal binary_65_place_180_symbol : Boolean;
      signal if_stmt_62_if_link_181_symbol : Boolean;
      signal if_stmt_62_else_link_185_symbol : Boolean;
      signal loopback_189_symbol : Boolean;
      signal if_stmt_62_else_link_to_if_stmt_62_x_xexit_x_xx_x190_symbol : Boolean;
      signal merge_stmt_42_dead_link_191_symbol : Boolean;
      signal merge_stmt_42_x_xentry_x_xx_xPhiReq_195_symbol : Boolean;
      signal loopback_PhiReq_206_symbol : Boolean;
      signal merge_stmt_42_PhiReqMerge_217_symbol : Boolean;
      signal merge_stmt_42_PhiAck_218_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_41_124_start <= branch_block_stmt_6_3_symbol; -- control passed to block
      Xentry_125_symbol  <= branch_block_stmt_41_124_start; -- transition branch_block_stmt_41/$entry
      branch_block_stmt_41_x_xentry_x_xx_x127_symbol  <=  Xentry_125_symbol; -- place branch_block_stmt_41/branch_block_stmt_41__entry__ (optimized away) 
      branch_block_stmt_41_x_xexit_x_xx_x128_symbol  <=  if_stmt_62_x_xexit_x_xx_x134_symbol; -- place branch_block_stmt_41/branch_block_stmt_41__exit__ (optimized away) 
      merge_stmt_42_x_xentry_x_xx_x129_symbol  <=  branch_block_stmt_41_x_xentry_x_xx_x127_symbol; -- place branch_block_stmt_41/merge_stmt_42__entry__ (optimized away) 
      merge_stmt_42_x_xexit_x_xx_x130_symbol  <=  merge_stmt_42_dead_link_191_symbol or merge_stmt_42_PhiAck_218_symbol; -- place branch_block_stmt_41/merge_stmt_42__exit__ (optimized away) 
      assign_stmt_56_to_assign_stmt_61_x_xentry_x_xx_x131_symbol  <=  merge_stmt_42_x_xexit_x_xx_x130_symbol; -- place branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61__entry__ (optimized away) 
      assign_stmt_56_to_assign_stmt_61_x_xexit_x_xx_x132_symbol  <=  assign_stmt_56_to_assign_stmt_61_135_symbol; -- place branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61__exit__ (optimized away) 
      if_stmt_62_x_xentry_x_xx_x133_symbol  <=  assign_stmt_56_to_assign_stmt_61_x_xexit_x_xx_x132_symbol; -- place branch_block_stmt_41/if_stmt_62__entry__ (optimized away) 
      if_stmt_62_x_xexit_x_xx_x134_symbol  <=  if_stmt_62_else_link_to_if_stmt_62_x_xexit_x_xx_x190_symbol or if_stmt_62_dead_link_162_symbol or if_stmt_62_dead_link_162_symbol; -- place branch_block_stmt_41/if_stmt_62__exit__ (optimized away) 
      assign_stmt_56_to_assign_stmt_61_135: Block -- branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61 
        signal assign_stmt_56_to_assign_stmt_61_135_start: Boolean;
        signal Xentry_136_symbol: Boolean;
        signal Xexit_137_symbol: Boolean;
        signal assign_stmt_56_active_x_x138_symbol : Boolean;
        signal assign_stmt_56_completed_x_x139_symbol : Boolean;
        signal binary_55_active_x_x140_symbol : Boolean;
        signal binary_55_trigger_x_x141_symbol : Boolean;
        signal simple_obj_ref_53_complete_142_symbol : Boolean;
        signal binary_55_complete_143_symbol : Boolean;
        signal assign_stmt_61_active_x_x150_symbol : Boolean;
        signal assign_stmt_61_completed_x_x151_symbol : Boolean;
        signal binary_60_active_x_x152_symbol : Boolean;
        signal binary_60_trigger_x_x153_symbol : Boolean;
        signal simple_obj_ref_58_complete_154_symbol : Boolean;
        signal binary_60_complete_155_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_56_to_assign_stmt_61_135_start <= assign_stmt_56_to_assign_stmt_61_x_xentry_x_xx_x131_symbol; -- control passed to block
        Xentry_136_symbol  <= assign_stmt_56_to_assign_stmt_61_135_start; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/$entry
        assign_stmt_56_active_x_x138_symbol <= binary_55_complete_143_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/assign_stmt_56_active_
        assign_stmt_56_completed_x_x139_symbol <= assign_stmt_56_active_x_x138_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/assign_stmt_56_completed_
        binary_55_active_x_x140_block : Block -- non-trivial join transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_active_ 
          signal binary_55_active_x_x140_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_55_active_x_x140_predecessors(0) <= binary_55_trigger_x_x141_symbol;
          binary_55_active_x_x140_predecessors(1) <= simple_obj_ref_53_complete_142_symbol;
          binary_55_active_x_x140_join: join -- 
            port map( -- 
              preds => binary_55_active_x_x140_predecessors,
              symbol_out => binary_55_active_x_x140_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_active_
        binary_55_trigger_x_x141_symbol <= Xentry_136_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_trigger_
        simple_obj_ref_53_complete_142_symbol <= Xentry_136_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/simple_obj_ref_53_complete
        binary_55_complete_143: Block -- branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete 
          signal binary_55_complete_143_start: Boolean;
          signal Xentry_144_symbol: Boolean;
          signal Xexit_145_symbol: Boolean;
          signal rr_146_symbol : Boolean;
          signal ra_147_symbol : Boolean;
          signal cr_148_symbol : Boolean;
          signal ca_149_symbol : Boolean;
          -- 
        begin -- 
          binary_55_complete_143_start <= binary_55_active_x_x140_symbol; -- control passed to block
          Xentry_144_symbol  <= binary_55_complete_143_start; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete/$entry
          rr_146_symbol <= Xentry_144_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete/rr
          binary_55_inst_req_0 <= rr_146_symbol; -- link to DP
          ra_147_symbol <= binary_55_inst_ack_0; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete/ra
          cr_148_symbol <= ra_147_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete/cr
          binary_55_inst_req_1 <= cr_148_symbol; -- link to DP
          ca_149_symbol <= binary_55_inst_ack_1; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete/ca
          Xexit_145_symbol <= ca_149_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete/$exit
          binary_55_complete_143_symbol <= Xexit_145_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_55_complete
        assign_stmt_61_active_x_x150_symbol <= binary_60_complete_155_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/assign_stmt_61_active_
        assign_stmt_61_completed_x_x151_symbol <= assign_stmt_61_active_x_x150_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/assign_stmt_61_completed_
        binary_60_active_x_x152_block : Block -- non-trivial join transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_active_ 
          signal binary_60_active_x_x152_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_60_active_x_x152_predecessors(0) <= binary_60_trigger_x_x153_symbol;
          binary_60_active_x_x152_predecessors(1) <= simple_obj_ref_58_complete_154_symbol;
          binary_60_active_x_x152_join: join -- 
            port map( -- 
              preds => binary_60_active_x_x152_predecessors,
              symbol_out => binary_60_active_x_x152_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_active_
        binary_60_trigger_x_x153_symbol <= Xentry_136_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_trigger_
        simple_obj_ref_58_complete_154_symbol <= Xentry_136_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/simple_obj_ref_58_complete
        binary_60_complete_155: Block -- branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete 
          signal binary_60_complete_155_start: Boolean;
          signal Xentry_156_symbol: Boolean;
          signal Xexit_157_symbol: Boolean;
          signal rr_158_symbol : Boolean;
          signal ra_159_symbol : Boolean;
          signal cr_160_symbol : Boolean;
          signal ca_161_symbol : Boolean;
          -- 
        begin -- 
          binary_60_complete_155_start <= binary_60_active_x_x152_symbol; -- control passed to block
          Xentry_156_symbol  <= binary_60_complete_155_start; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete/$entry
          rr_158_symbol <= Xentry_156_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete/rr
          binary_60_inst_req_0 <= rr_158_symbol; -- link to DP
          ra_159_symbol <= binary_60_inst_ack_0; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete/ra
          cr_160_symbol <= ra_159_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete/cr
          binary_60_inst_req_1 <= cr_160_symbol; -- link to DP
          ca_161_symbol <= binary_60_inst_ack_1; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete/ca
          Xexit_157_symbol <= ca_161_symbol; -- transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete/$exit
          binary_60_complete_155_symbol <= Xexit_157_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/binary_60_complete
        Xexit_137_block : Block -- non-trivial join transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/$exit 
          signal Xexit_137_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_137_predecessors(0) <= assign_stmt_56_completed_x_x139_symbol;
          Xexit_137_predecessors(1) <= assign_stmt_61_completed_x_x151_symbol;
          Xexit_137_join: join -- 
            port map( -- 
              preds => Xexit_137_predecessors,
              symbol_out => Xexit_137_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61/$exit
        assign_stmt_56_to_assign_stmt_61_135_symbol <= Xexit_137_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/assign_stmt_56_to_assign_stmt_61
      if_stmt_62_dead_link_162: Block -- branch_block_stmt_41/if_stmt_62_dead_link 
        signal if_stmt_62_dead_link_162_start: Boolean;
        signal Xentry_163_symbol: Boolean;
        signal Xexit_164_symbol: Boolean;
        signal dead_transition_165_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_dead_link_162_start <= if_stmt_62_x_xentry_x_xx_x133_symbol; -- control passed to block
        Xentry_163_symbol  <= if_stmt_62_dead_link_162_start; -- transition branch_block_stmt_41/if_stmt_62_dead_link/$entry
        dead_transition_165_symbol <= false;
        Xexit_164_symbol <= dead_transition_165_symbol; -- transition branch_block_stmt_41/if_stmt_62_dead_link/$exit
        if_stmt_62_dead_link_162_symbol <= Xexit_164_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_dead_link
      if_stmt_62_eval_test_166: Block -- branch_block_stmt_41/if_stmt_62_eval_test 
        signal if_stmt_62_eval_test_166_start: Boolean;
        signal Xentry_167_symbol: Boolean;
        signal Xexit_168_symbol: Boolean;
        signal binary_65_169_symbol : Boolean;
        signal branch_req_179_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_eval_test_166_start <= if_stmt_62_x_xentry_x_xx_x133_symbol; -- control passed to block
        Xentry_167_symbol  <= if_stmt_62_eval_test_166_start; -- transition branch_block_stmt_41/if_stmt_62_eval_test/$entry
        binary_65_169: Block -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65 
          signal binary_65_169_start: Boolean;
          signal Xentry_170_symbol: Boolean;
          signal Xexit_171_symbol: Boolean;
          signal binary_65_inputs_172_symbol : Boolean;
          signal rr_175_symbol : Boolean;
          signal ra_176_symbol : Boolean;
          signal cr_177_symbol : Boolean;
          signal ca_178_symbol : Boolean;
          -- 
        begin -- 
          binary_65_169_start <= Xentry_167_symbol; -- control passed to block
          Xentry_170_symbol  <= binary_65_169_start; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/$entry
          binary_65_inputs_172: Block -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs 
            signal binary_65_inputs_172_start: Boolean;
            signal Xentry_173_symbol: Boolean;
            signal Xexit_174_symbol: Boolean;
            -- 
          begin -- 
            binary_65_inputs_172_start <= Xentry_170_symbol; -- control passed to block
            Xentry_173_symbol  <= binary_65_inputs_172_start; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs/$entry
            Xexit_174_symbol <= Xentry_173_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs/$exit
            binary_65_inputs_172_symbol <= Xexit_174_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs
          rr_175_symbol <= binary_65_inputs_172_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/rr
          binary_65_inst_req_0 <= rr_175_symbol; -- link to DP
          ra_176_symbol <= binary_65_inst_ack_0; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/ra
          cr_177_symbol <= ra_176_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/cr
          binary_65_inst_req_1 <= cr_177_symbol; -- link to DP
          ca_178_symbol <= binary_65_inst_ack_1; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/ca
          Xexit_171_symbol <= ca_178_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/$exit
          binary_65_169_symbol <= Xexit_171_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65
        branch_req_179_symbol <= binary_65_169_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/branch_req
        if_stmt_62_branch_req_0 <= branch_req_179_symbol; -- link to DP
        Xexit_168_symbol <= branch_req_179_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/$exit
        if_stmt_62_eval_test_166_symbol <= Xexit_168_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_eval_test
      binary_65_place_180_symbol  <=  if_stmt_62_eval_test_166_symbol; -- place branch_block_stmt_41/binary_65_place (optimized away) 
      if_stmt_62_if_link_181: Block -- branch_block_stmt_41/if_stmt_62_if_link 
        signal if_stmt_62_if_link_181_start: Boolean;
        signal Xentry_182_symbol: Boolean;
        signal Xexit_183_symbol: Boolean;
        signal if_choice_transition_184_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_if_link_181_start <= binary_65_place_180_symbol; -- control passed to block
        Xentry_182_symbol  <= if_stmt_62_if_link_181_start; -- transition branch_block_stmt_41/if_stmt_62_if_link/$entry
        if_choice_transition_184_symbol <= if_stmt_62_branch_ack_1; -- transition branch_block_stmt_41/if_stmt_62_if_link/if_choice_transition
        Xexit_183_symbol <= if_choice_transition_184_symbol; -- transition branch_block_stmt_41/if_stmt_62_if_link/$exit
        if_stmt_62_if_link_181_symbol <= Xexit_183_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_if_link
      if_stmt_62_else_link_185: Block -- branch_block_stmt_41/if_stmt_62_else_link 
        signal if_stmt_62_else_link_185_start: Boolean;
        signal Xentry_186_symbol: Boolean;
        signal Xexit_187_symbol: Boolean;
        signal else_choice_transition_188_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_else_link_185_start <= binary_65_place_180_symbol; -- control passed to block
        Xentry_186_symbol  <= if_stmt_62_else_link_185_start; -- transition branch_block_stmt_41/if_stmt_62_else_link/$entry
        else_choice_transition_188_symbol <= if_stmt_62_branch_ack_0; -- transition branch_block_stmt_41/if_stmt_62_else_link/else_choice_transition
        Xexit_187_symbol <= else_choice_transition_188_symbol; -- transition branch_block_stmt_41/if_stmt_62_else_link/$exit
        if_stmt_62_else_link_185_symbol <= Xexit_187_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_else_link
      loopback_189_symbol  <=  if_stmt_62_if_link_181_symbol; -- place branch_block_stmt_41/loopback (optimized away) 
      if_stmt_62_else_link_to_if_stmt_62_x_xexit_x_xx_x190_symbol  <=  if_stmt_62_else_link_185_symbol; -- place branch_block_stmt_41/if_stmt_62_else_link_to_if_stmt_62__exit__ (optimized away) 
      merge_stmt_42_dead_link_191: Block -- branch_block_stmt_41/merge_stmt_42_dead_link 
        signal merge_stmt_42_dead_link_191_start: Boolean;
        signal Xentry_192_symbol: Boolean;
        signal Xexit_193_symbol: Boolean;
        signal dead_transition_194_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_42_dead_link_191_start <= merge_stmt_42_x_xentry_x_xx_x129_symbol; -- control passed to block
        Xentry_192_symbol  <= merge_stmt_42_dead_link_191_start; -- transition branch_block_stmt_41/merge_stmt_42_dead_link/$entry
        dead_transition_194_symbol <= false;
        Xexit_193_symbol <= dead_transition_194_symbol; -- transition branch_block_stmt_41/merge_stmt_42_dead_link/$exit
        merge_stmt_42_dead_link_191_symbol <= Xexit_193_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/merge_stmt_42_dead_link
      merge_stmt_42_x_xentry_x_xx_xPhiReq_195: Block -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq 
        signal merge_stmt_42_x_xentry_x_xx_xPhiReq_195_start: Boolean;
        signal Xentry_196_symbol: Boolean;
        signal Xexit_197_symbol: Boolean;
        signal phi_stmt_43_198_symbol : Boolean;
        signal phi_stmt_47_202_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_42_x_xentry_x_xx_xPhiReq_195_start <= merge_stmt_42_x_xentry_x_xx_x129_symbol; -- control passed to block
        Xentry_196_symbol  <= merge_stmt_42_x_xentry_x_xx_xPhiReq_195_start; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/$entry
        phi_stmt_43_198: Block -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43 
          signal phi_stmt_43_198_start: Boolean;
          signal Xentry_199_symbol: Boolean;
          signal Xexit_200_symbol: Boolean;
          signal phi_stmt_43_req_201_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_43_198_start <= Xentry_196_symbol; -- control passed to block
          Xentry_199_symbol  <= phi_stmt_43_198_start; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43/$entry
          phi_stmt_43_req_201_symbol <= Xentry_199_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43/phi_stmt_43_req
          phi_stmt_43_req_0 <= phi_stmt_43_req_201_symbol; -- link to DP
          Xexit_200_symbol <= phi_stmt_43_req_201_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43/$exit
          phi_stmt_43_198_symbol <= Xexit_200_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43
        phi_stmt_47_202: Block -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47 
          signal phi_stmt_47_202_start: Boolean;
          signal Xentry_203_symbol: Boolean;
          signal Xexit_204_symbol: Boolean;
          signal phi_stmt_47_req_205_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_47_202_start <= Xentry_196_symbol; -- control passed to block
          Xentry_203_symbol  <= phi_stmt_47_202_start; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47/$entry
          phi_stmt_47_req_205_symbol <= Xentry_203_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47/phi_stmt_47_req
          phi_stmt_47_req_0 <= phi_stmt_47_req_205_symbol; -- link to DP
          Xexit_204_symbol <= phi_stmt_47_req_205_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47/$exit
          phi_stmt_47_202_symbol <= Xexit_204_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47
        Xexit_197_block : Block -- non-trivial join transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/$exit 
          signal Xexit_197_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_197_predecessors(0) <= phi_stmt_43_198_symbol;
          Xexit_197_predecessors(1) <= phi_stmt_47_202_symbol;
          Xexit_197_join: join -- 
            port map( -- 
              preds => Xexit_197_predecessors,
              symbol_out => Xexit_197_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/$exit
        merge_stmt_42_x_xentry_x_xx_xPhiReq_195_symbol <= Xexit_197_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq
      loopback_PhiReq_206: Block -- branch_block_stmt_41/loopback_PhiReq 
        signal loopback_PhiReq_206_start: Boolean;
        signal Xentry_207_symbol: Boolean;
        signal Xexit_208_symbol: Boolean;
        signal phi_stmt_43_209_symbol : Boolean;
        signal phi_stmt_47_213_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_206_start <= loopback_189_symbol; -- control passed to block
        Xentry_207_symbol  <= loopback_PhiReq_206_start; -- transition branch_block_stmt_41/loopback_PhiReq/$entry
        phi_stmt_43_209: Block -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_43 
          signal phi_stmt_43_209_start: Boolean;
          signal Xentry_210_symbol: Boolean;
          signal Xexit_211_symbol: Boolean;
          signal phi_stmt_43_req_212_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_43_209_start <= Xentry_207_symbol; -- control passed to block
          Xentry_210_symbol  <= phi_stmt_43_209_start; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_43/$entry
          phi_stmt_43_req_212_symbol <= Xentry_210_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_43/phi_stmt_43_req
          phi_stmt_43_req_1 <= phi_stmt_43_req_212_symbol; -- link to DP
          Xexit_211_symbol <= phi_stmt_43_req_212_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_43/$exit
          phi_stmt_43_209_symbol <= Xexit_211_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_43
        phi_stmt_47_213: Block -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_47 
          signal phi_stmt_47_213_start: Boolean;
          signal Xentry_214_symbol: Boolean;
          signal Xexit_215_symbol: Boolean;
          signal phi_stmt_47_req_216_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_47_213_start <= Xentry_207_symbol; -- control passed to block
          Xentry_214_symbol  <= phi_stmt_47_213_start; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_47/$entry
          phi_stmt_47_req_216_symbol <= Xentry_214_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_47/phi_stmt_47_req
          phi_stmt_47_req_1 <= phi_stmt_47_req_216_symbol; -- link to DP
          Xexit_215_symbol <= phi_stmt_47_req_216_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_47/$exit
          phi_stmt_47_213_symbol <= Xexit_215_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_47
        Xexit_208_block : Block -- non-trivial join transition branch_block_stmt_41/loopback_PhiReq/$exit 
          signal Xexit_208_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_208_predecessors(0) <= phi_stmt_43_209_symbol;
          Xexit_208_predecessors(1) <= phi_stmt_47_213_symbol;
          Xexit_208_join: join -- 
            port map( -- 
              preds => Xexit_208_predecessors,
              symbol_out => Xexit_208_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/loopback_PhiReq/$exit
        loopback_PhiReq_206_symbol <= Xexit_208_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/loopback_PhiReq
      merge_stmt_42_PhiReqMerge_217_symbol  <=  merge_stmt_42_x_xentry_x_xx_xPhiReq_195_symbol or loopback_PhiReq_206_symbol; -- place branch_block_stmt_41/merge_stmt_42_PhiReqMerge (optimized away) 
      merge_stmt_42_PhiAck_218: Block -- branch_block_stmt_41/merge_stmt_42_PhiAck 
        signal merge_stmt_42_PhiAck_218_start: Boolean;
        signal Xentry_219_symbol: Boolean;
        signal Xexit_220_symbol: Boolean;
        signal phi_stmt_43_ack_221_symbol : Boolean;
        signal phi_stmt_47_ack_222_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_42_PhiAck_218_start <= merge_stmt_42_PhiReqMerge_217_symbol; -- control passed to block
        Xentry_219_symbol  <= merge_stmt_42_PhiAck_218_start; -- transition branch_block_stmt_41/merge_stmt_42_PhiAck/$entry
        phi_stmt_43_ack_221_symbol <= phi_stmt_43_ack_0; -- transition branch_block_stmt_41/merge_stmt_42_PhiAck/phi_stmt_43_ack
        phi_stmt_47_ack_222_symbol <= phi_stmt_47_ack_0; -- transition branch_block_stmt_41/merge_stmt_42_PhiAck/phi_stmt_47_ack
        Xexit_220_block : Block -- non-trivial join transition branch_block_stmt_41/merge_stmt_42_PhiAck/$exit 
          signal Xexit_220_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_220_predecessors(0) <= phi_stmt_43_ack_221_symbol;
          Xexit_220_predecessors(1) <= phi_stmt_47_ack_222_symbol;
          Xexit_220_join: join -- 
            port map( -- 
              preds => Xexit_220_predecessors,
              symbol_out => Xexit_220_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/merge_stmt_42_PhiAck/$exit
        merge_stmt_42_PhiAck_218_symbol <= Xexit_220_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/merge_stmt_42_PhiAck
      Xexit_126_symbol <= branch_block_stmt_41_x_xexit_x_xx_x128_symbol; -- transition branch_block_stmt_41/$exit
      branch_block_stmt_41_124_symbol <= Xexit_126_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_41
    assign_stmt_73_to_assign_stmt_78_223: Block -- assign_stmt_73_to_assign_stmt_78 
      signal assign_stmt_73_to_assign_stmt_78_223_start: Boolean;
      signal Xentry_224_symbol: Boolean;
      signal Xexit_225_symbol: Boolean;
      signal assign_stmt_73_active_x_x226_symbol : Boolean;
      signal assign_stmt_73_completed_x_x227_symbol : Boolean;
      signal simple_obj_ref_72_complete_228_symbol : Boolean;
      signal assign_stmt_73_register_229_symbol : Boolean;
      signal assign_stmt_78_active_x_x234_symbol : Boolean;
      signal assign_stmt_78_completed_x_x235_symbol : Boolean;
      signal binary_77_active_x_x236_symbol : Boolean;
      signal binary_77_trigger_x_x237_symbol : Boolean;
      signal simple_obj_ref_75_complete_238_symbol : Boolean;
      signal simple_obj_ref_76_complete_239_symbol : Boolean;
      signal binary_77_complete_240_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_73_to_assign_stmt_78_223_start <= branch_block_stmt_41_124_symbol; -- control passed to block
      Xentry_224_symbol  <= assign_stmt_73_to_assign_stmt_78_223_start; -- transition assign_stmt_73_to_assign_stmt_78/$entry
      assign_stmt_73_active_x_x226_symbol <= simple_obj_ref_72_complete_228_symbol; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_active_
      assign_stmt_73_completed_x_x227_block : Block -- non-trivial join transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_completed_ 
        signal assign_stmt_73_completed_x_x227_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        assign_stmt_73_completed_x_x227_predecessors(0) <= assign_stmt_73_active_x_x226_symbol;
        assign_stmt_73_completed_x_x227_predecessors(1) <= assign_stmt_73_register_229_symbol;
        assign_stmt_73_completed_x_x227_join: join -- 
          port map( -- 
            preds => assign_stmt_73_completed_x_x227_predecessors,
            symbol_out => assign_stmt_73_completed_x_x227_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_completed_
      simple_obj_ref_72_complete_228_symbol <= Xentry_224_symbol; -- transition assign_stmt_73_to_assign_stmt_78/simple_obj_ref_72_complete
      assign_stmt_73_register_229: Block -- assign_stmt_73_to_assign_stmt_78/assign_stmt_73_register 
        signal assign_stmt_73_register_229_start: Boolean;
        signal Xentry_230_symbol: Boolean;
        signal Xexit_231_symbol: Boolean;
        signal req_232_symbol : Boolean;
        signal ack_233_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_73_register_229_start <= assign_stmt_73_active_x_x226_symbol; -- control passed to block
        Xentry_230_symbol  <= assign_stmt_73_register_229_start; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_register/$entry
        req_232_symbol <= Xentry_230_symbol; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_register/req
        simple_obj_ref_71_inst_req_0 <= req_232_symbol; -- link to DP
        ack_233_symbol <= simple_obj_ref_71_inst_ack_0; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_register/ack
        Xexit_231_symbol <= ack_233_symbol; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_73_register/$exit
        assign_stmt_73_register_229_symbol <= Xexit_231_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_73_to_assign_stmt_78/assign_stmt_73_register
      assign_stmt_78_active_x_x234_symbol <= binary_77_complete_240_symbol; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_78_active_
      assign_stmt_78_completed_x_x235_symbol <= assign_stmt_78_active_x_x234_symbol; -- transition assign_stmt_73_to_assign_stmt_78/assign_stmt_78_completed_
      binary_77_active_x_x236_block : Block -- non-trivial join transition assign_stmt_73_to_assign_stmt_78/binary_77_active_ 
        signal binary_77_active_x_x236_predecessors: BooleanArray(2 downto 0);
        -- 
      begin -- 
        binary_77_active_x_x236_predecessors(0) <= binary_77_trigger_x_x237_symbol;
        binary_77_active_x_x236_predecessors(1) <= simple_obj_ref_75_complete_238_symbol;
        binary_77_active_x_x236_predecessors(2) <= simple_obj_ref_76_complete_239_symbol;
        binary_77_active_x_x236_join: join -- 
          port map( -- 
            preds => binary_77_active_x_x236_predecessors,
            symbol_out => binary_77_active_x_x236_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_73_to_assign_stmt_78/binary_77_active_
      binary_77_trigger_x_x237_symbol <= Xentry_224_symbol; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_trigger_
      simple_obj_ref_75_complete_238_symbol <= Xentry_224_symbol; -- transition assign_stmt_73_to_assign_stmt_78/simple_obj_ref_75_complete
      simple_obj_ref_76_complete_239_symbol <= Xentry_224_symbol; -- transition assign_stmt_73_to_assign_stmt_78/simple_obj_ref_76_complete
      binary_77_complete_240: Block -- assign_stmt_73_to_assign_stmt_78/binary_77_complete 
        signal binary_77_complete_240_start: Boolean;
        signal Xentry_241_symbol: Boolean;
        signal Xexit_242_symbol: Boolean;
        signal rr_243_symbol : Boolean;
        signal ra_244_symbol : Boolean;
        signal cr_245_symbol : Boolean;
        signal ca_246_symbol : Boolean;
        -- 
      begin -- 
        binary_77_complete_240_start <= binary_77_active_x_x236_symbol; -- control passed to block
        Xentry_241_symbol  <= binary_77_complete_240_start; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_complete/$entry
        rr_243_symbol <= Xentry_241_symbol; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_complete/rr
        binary_77_inst_req_0 <= rr_243_symbol; -- link to DP
        ra_244_symbol <= binary_77_inst_ack_0; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_complete/ra
        cr_245_symbol <= ra_244_symbol; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_complete/cr
        binary_77_inst_req_1 <= cr_245_symbol; -- link to DP
        ca_246_symbol <= binary_77_inst_ack_1; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_complete/ca
        Xexit_242_symbol <= ca_246_symbol; -- transition assign_stmt_73_to_assign_stmt_78/binary_77_complete/$exit
        binary_77_complete_240_symbol <= Xexit_242_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_73_to_assign_stmt_78/binary_77_complete
      Xexit_225_block : Block -- non-trivial join transition assign_stmt_73_to_assign_stmt_78/$exit 
        signal Xexit_225_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        Xexit_225_predecessors(0) <= assign_stmt_73_completed_x_x227_symbol;
        Xexit_225_predecessors(1) <= assign_stmt_78_completed_x_x235_symbol;
        Xexit_225_join: join -- 
          port map( -- 
            preds => Xexit_225_predecessors,
            symbol_out => Xexit_225_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_73_to_assign_stmt_78/$exit
      assign_stmt_73_to_assign_stmt_78_223_symbol <= Xexit_225_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_73_to_assign_stmt_78
    Xexit_2_symbol <= assign_stmt_73_to_assign_stmt_78_223_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal binary_65_wire : std_logic_vector(0 downto 0);
    signal expr_14_wire_constant : std_logic_vector(9 downto 0);
    signal expr_19_wire_constant : std_logic_vector(9 downto 0);
    signal expr_24_wire_constant : std_logic_vector(9 downto 0);
    signal expr_29_wire_constant : std_logic_vector(9 downto 0);
    signal expr_29_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_32_wire_constant : std_logic_vector(9 downto 0);
    signal expr_32_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_35_wire_constant : std_logic_vector(9 downto 0);
    signal expr_35_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_49_wire_constant : std_logic_vector(9 downto 0);
    signal expr_54_wire_constant : std_logic_vector(9 downto 0);
    signal expr_59_wire_constant : std_logic_vector(9 downto 0);
    signal expr_64_wire_constant : std_logic_vector(9 downto 0);
    signal loop_counter_43 : std_logic_vector(9 downto 0);
    signal loop_counter_8 : std_logic_vector(9 downto 0);
    signal new_loop_counter_21 : std_logic_vector(9 downto 0);
    signal new_loop_counter_56 : std_logic_vector(9 downto 0);
    signal t_26 : std_logic_vector(9 downto 0);
    signal t_61 : std_logic_vector(9 downto 0);
    signal temp_t_12 : std_logic_vector(9 downto 0);
    signal temp_t_47 : std_logic_vector(9 downto 0);
    -- 
  begin -- 
    expr_14_wire_constant <= "0000000000";
    expr_19_wire_constant <= "0000000001";
    expr_24_wire_constant <= "0000000001";
    expr_29_wire_constant <= "0000000001";
    expr_32_wire_constant <= "0000000010";
    expr_35_wire_constant <= "0000000011";
    expr_49_wire_constant <= "0000000000";
    expr_54_wire_constant <= "0000000001";
    expr_59_wire_constant <= "0000000001";
    expr_64_wire_constant <= "0000000000";
    phi_stmt_12: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_14_wire_constant & t_26;
      req <= phi_stmt_12_req_0 & phi_stmt_12_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_12_ack_0,
          idata => idata,
          odata => temp_t_12,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_12
    phi_stmt_43: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a & new_loop_counter_56;
      req <= phi_stmt_43_req_0 & phi_stmt_43_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_43_ack_0,
          idata => idata,
          odata => loop_counter_43,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_43
    phi_stmt_47: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_49_wire_constant & t_61;
      req <= phi_stmt_47_req_0 & phi_stmt_47_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_47_ack_0,
          idata => idata,
          odata => temp_t_47,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_47
    phi_stmt_8: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a & new_loop_counter_21;
      req <= phi_stmt_8_req_0 & phi_stmt_8_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_8_ack_0,
          idata => idata,
          odata => loop_counter_8,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_8
    simple_obj_ref_71_inst: RegisterBase generic map(in_data_width => 10,out_data_width => 10) -- 
      port map( din => t_26, dout => b, req => simple_obj_ref_71_inst_req_0, ack => simple_obj_ref_71_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_62_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= binary_65_wire;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_62_branch_req_0,
          ack0 => if_stmt_62_branch_ack_0,
          ack1 => if_stmt_62_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_27_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_29_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_27_branch_0_req_0,
          ack0 => open,
          ack1 => switch_stmt_27_branch_0_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_27_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_32_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_27_branch_1_req_0,
          ack0 => open,
          ack1 => switch_stmt_27_branch_1_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_27_branch_2: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_35_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_27_branch_2_req_0,
          ack0 => open,
          ack1 => switch_stmt_27_branch_2_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_27_branch_default: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(2 downto 0);
      begin 
      condition_sig <= expr_29_wire_constant_cmp & expr_32_wire_constant_cmp & expr_35_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 3)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_27_branch_default_req_0,
          ack0 => switch_stmt_27_branch_default_ack_0,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_20_inst binary_55_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(19 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= loop_counter_8 & loop_counter_43;
      new_loop_counter_21 <= data_out(19 downto 10);
      new_loop_counter_56 <= data_out(9 downto 0);
      reqL(1) <= binary_20_inst_req_0;
      reqL(0) <= binary_55_inst_req_0;
      binary_20_inst_ack_0 <= ackL(1);
      binary_55_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_20_inst_req_1;
      reqR(0) <= binary_55_inst_req_1;
      binary_20_inst_ack_1 <= ackR(1);
      binary_55_inst_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
        generic map ( -- 
          operator_id => "ApIntSub",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0000000001",
          use_constant  => true,
          zero_delay => false, 
          no_arbitration => true, 
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_25_inst binary_60_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(19 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= temp_t_12 & temp_t_47;
      t_26 <= data_out(19 downto 10);
      t_61 <= data_out(9 downto 0);
      reqL(1) <= binary_25_inst_req_0;
      reqL(0) <= binary_60_inst_req_0;
      binary_25_inst_ack_0 <= ackL(1);
      binary_60_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_25_inst_req_1;
      reqR(0) <= binary_60_inst_req_1;
      binary_25_inst_ack_1 <= ackR(1);
      binary_60_inst_ack_1 <= ackR(0);
      SplitOperator: SplitOperatorShared -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 10,
          constant_operand => "0000000001",
          use_constant  => true,
          zero_delay => false, 
          no_arbitration => true, 
          num_reqs => 2--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_65_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_56;
      binary_65_wire <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntUgt",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000000000",
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
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_77_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= t_26 & t_61;
      test <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 10, 
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
          reqL => binary_77_inst_req_0,
          ackL => binary_77_inst_ack_0,
          reqR => binary_77_inst_req_1,
          ackR => binary_77_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : switch_stmt_27_select_expr_0 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_21;
      expr_29_wire_constant_cmp <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_27_select_expr_0_req_0,
          ackL => switch_stmt_27_select_expr_0_ack_0,
          reqR => switch_stmt_27_select_expr_0_req_1,
          ackR => switch_stmt_27_select_expr_0_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : switch_stmt_27_select_expr_1 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_21;
      expr_32_wire_constant_cmp <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000000010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_27_select_expr_1_req_0,
          ackL => switch_stmt_27_select_expr_1_ack_0,
          reqR => switch_stmt_27_select_expr_1_req_1,
          ackR => switch_stmt_27_select_expr_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : switch_stmt_27_select_expr_2 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_21;
      expr_35_wire_constant_cmp <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 10,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000000011",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_27_select_expr_2_req_0,
          ackL => switch_stmt_27_select_expr_2_ack_0,
          reqR => switch_stmt_27_select_expr_2_req_1,
          ackR => switch_stmt_27_select_expr_2_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
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
library work;
use work.vc_system_package.all;
entity test_system is  -- system 
  port (-- 
    sum_mod_a : in  std_logic_vector(9 downto 0);
    sum_mod_b : out  std_logic_vector(9 downto 0);
    sum_mod_test : out  std_logic_vector(0 downto 0);
    sum_mod_tag_in: in std_logic_vector(0 downto 0);
    sum_mod_tag_out: out std_logic_vector(0 downto 0);
    sum_mod_start : in std_logic;
    sum_mod_fin   : out std_logic;
    clk : in std_logic;
    reset : in std_logic); -- 
  -- 
end entity; 
architecture Default of test_system is -- system-architecture 
  -- declarations related to module sum_mod
  component sum_mod is -- 
    port ( -- 
      a : in  std_logic_vector(9 downto 0);
      b : out  std_logic_vector(9 downto 0);
      test : out  std_logic_vector(0 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- 
begin -- 
  -- module sum_mod
  sum_mod_instance:sum_mod-- 
    port map(-- 
      a => sum_mod_a,
      b => sum_mod_b,
      test => sum_mod_test,
      start => sum_mod_start,
      fin => sum_mod_fin,
      clk => clk,
      reset => reset,
      tag_in => sum_mod_tag_in,
      tag_out => sum_mod_tag_out-- 
    ); -- 
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
library work;
use work.vc_system_package.all;
entity test_system_Test_Bench is -- 
  -- 
end entity;
architecture Default of test_system_Test_Bench is -- 
  component test_system is -- 
    port (-- 
      sum_mod_a : in  std_logic_vector(9 downto 0);
      sum_mod_b : out  std_logic_vector(9 downto 0);
      sum_mod_test : out  std_logic_vector(0 downto 0);
      sum_mod_tag_in: in std_logic_vector(0 downto 0);
      sum_mod_tag_out: out std_logic_vector(0 downto 0);
      sum_mod_start : in std_logic;
      sum_mod_fin   : out std_logic;
      clk : in std_logic;
      reset : in std_logic); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal sum_mod_a :  std_logic_vector(9 downto 0) := (others => '0');
  signal sum_mod_b :   std_logic_vector(9 downto 0);
  signal sum_mod_test :   std_logic_vector(0 downto 0);
  signal sum_mod_tag_in: std_logic_vector(0 downto 0);
  signal sum_mod_tag_out: std_logic_vector(0 downto 0);
  signal sum_mod_start : std_logic := '0';
  signal sum_mod_fin   : std_logic := '0';
  -- 
begin --
  -- clock/reset generation 
  clk <= not clk after 5 ns;
  process
  begin --
    wait until clk = '1';
    reset <= '0';
    wait;
    --
  end process;
  -- a rudimentary tb.. will start all the top-level modules ..
  process
  begin --
    wait until clk = '1';
    sum_mod_start <= '1';
    wait until clk = '1';
    sum_mod_start <= '0';
    while sum_mod_fin /= '1' loop -- 
      wait until clk = '1';
      -- 
    end loop;
    wait;
    --
  end process;
  test_system_instance: test_system -- 
    port map ( -- 
      sum_mod_a => sum_mod_a,
      sum_mod_b => sum_mod_b,
      sum_mod_test => sum_mod_test,
      sum_mod_tag_in => sum_mod_tag_in,
      sum_mod_tag_out => sum_mod_tag_out,
      sum_mod_start => sum_mod_start,
      sum_mod_fin  => sum_mod_fin ,
      clk => clk,
      reset => reset); -- 
  -- 
end Default;
