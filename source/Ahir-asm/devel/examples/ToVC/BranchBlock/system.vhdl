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
  signal binary_28_inst_req_0 : boolean;
  signal binary_28_inst_ack_0 : boolean;
  signal binary_28_inst_req_1 : boolean;
  signal binary_28_inst_ack_1 : boolean;
  signal binary_23_inst_req_0 : boolean;
  signal binary_23_inst_ack_0 : boolean;
  signal binary_23_inst_req_1 : boolean;
  signal binary_23_inst_ack_1 : boolean;
  signal switch_stmt_30_branch_1_req_0 : boolean;
  signal switch_stmt_30_branch_2_ack_1 : boolean;
  signal switch_stmt_30_branch_default_ack_0 : boolean;
  signal phi_stmt_11_req_0 : boolean;
  signal phi_stmt_15_req_0 : boolean;
  signal phi_stmt_11_req_1 : boolean;
  signal switch_stmt_30_branch_default_req_0 : boolean;
  signal switch_stmt_30_select_expr_0_req_0 : boolean;
  signal switch_stmt_30_select_expr_0_ack_0 : boolean;
  signal switch_stmt_30_select_expr_0_req_1 : boolean;
  signal switch_stmt_30_select_expr_0_ack_1 : boolean;
  signal switch_stmt_30_branch_0_req_0 : boolean;
  signal switch_stmt_30_select_expr_1_req_0 : boolean;
  signal switch_stmt_30_select_expr_1_ack_0 : boolean;
  signal switch_stmt_30_select_expr_1_req_1 : boolean;
  signal switch_stmt_30_select_expr_1_ack_1 : boolean;
  signal phi_stmt_11_ack_0 : boolean;
  signal phi_stmt_15_ack_0 : boolean;
  signal switch_stmt_30_select_expr_2_req_0 : boolean;
  signal switch_stmt_30_select_expr_2_ack_0 : boolean;
  signal switch_stmt_30_select_expr_2_req_1 : boolean;
  signal switch_stmt_30_select_expr_2_ack_1 : boolean;
  signal switch_stmt_30_branch_2_req_0 : boolean;
  signal switch_stmt_30_branch_0_ack_1 : boolean;
  signal switch_stmt_30_branch_1_ack_1 : boolean;
  signal phi_stmt_15_req_1 : boolean;
  signal binary_80_inst_ack_0 : boolean;
  signal binary_80_inst_req_1 : boolean;
  signal binary_80_inst_ack_1 : boolean;
  signal binary_58_inst_req_0 : boolean;
  signal binary_58_inst_ack_0 : boolean;
  signal binary_58_inst_req_1 : boolean;
  signal binary_58_inst_ack_1 : boolean;
  signal binary_63_inst_req_0 : boolean;
  signal binary_63_inst_ack_0 : boolean;
  signal binary_63_inst_req_1 : boolean;
  signal binary_63_inst_ack_1 : boolean;
  signal binary_68_inst_req_0 : boolean;
  signal binary_68_inst_ack_0 : boolean;
  signal binary_68_inst_req_1 : boolean;
  signal binary_68_inst_ack_1 : boolean;
  signal if_stmt_65_branch_req_0 : boolean;
  signal if_stmt_65_branch_ack_1 : boolean;
  signal if_stmt_65_branch_ack_0 : boolean;
  signal phi_stmt_46_req_0 : boolean;
  signal phi_stmt_50_req_0 : boolean;
  signal phi_stmt_46_req_1 : boolean;
  signal phi_stmt_50_req_1 : boolean;
  signal phi_stmt_46_ack_0 : boolean;
  signal phi_stmt_50_ack_0 : boolean;
  signal simple_obj_ref_74_inst_req_0 : boolean;
  signal simple_obj_ref_74_inst_ack_0 : boolean;
  signal binary_80_inst_req_0 : boolean;
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
    signal assign_stmt_8_3_symbol : Boolean;
    signal branch_block_stmt_9_7_symbol : Boolean;
    signal branch_block_stmt_44_133_symbol : Boolean;
    signal assign_stmt_76_237_symbol : Boolean;
    signal assign_stmt_81_242_symbol : Boolean;
    -- 
  begin -- 
    sum_mod_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= sum_mod_CP_0_start; -- transition $entry
    assign_stmt_8_3: Block -- assign_stmt_8 
      signal assign_stmt_8_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal dummy_6_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_8_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= assign_stmt_8_3_start; -- transition assign_stmt_8/$entry
      dummy_6_symbol <= Xentry_4_symbol; -- transition assign_stmt_8/dummy
      Xexit_5_symbol <= dummy_6_symbol; -- transition assign_stmt_8/$exit
      assign_stmt_8_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_8
    branch_block_stmt_9_7: Block -- branch_block_stmt_9 
      signal branch_block_stmt_9_7_start: Boolean;
      signal Xentry_8_symbol: Boolean;
      signal Xexit_9_symbol: Boolean;
      signal branch_block_stmt_9_x_xentry_x_xx_x10_symbol : Boolean;
      signal branch_block_stmt_9_x_xexit_x_xx_x11_symbol : Boolean;
      signal merge_stmt_10_x_xentry_x_xx_x12_symbol : Boolean;
      signal merge_stmt_10_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_24_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_24_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_29_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_29_x_xexit_x_xx_x17_symbol : Boolean;
      signal switch_stmt_30_x_xentry_x_xx_x18_symbol : Boolean;
      signal switch_stmt_30_x_xexit_x_xx_x19_symbol : Boolean;
      signal assign_stmt_24_20_symbol : Boolean;
      signal assign_stmt_29_33_symbol : Boolean;
      signal switch_stmt_30_dead_link_46_symbol : Boolean;
      signal switch_stmt_30_x_xcondition_check_place_x_xx_x50_symbol : Boolean;
      signal switch_stmt_30_x_xcondition_check_x_xx_x51_symbol : Boolean;
      signal switch_stmt_30_x_xselect_x_xx_x78_symbol : Boolean;
      signal switch_stmt_30_choice_0_79_symbol : Boolean;
      signal loopback_83_symbol : Boolean;
      signal switch_stmt_30_choice_1_84_symbol : Boolean;
      signal switch_stmt_30_choice_2_88_symbol : Boolean;
      signal switch_stmt_30_choice_default_92_symbol : Boolean;
      signal stmt_41_x_xentry_x_xx_x96_symbol : Boolean;
      signal stmt_41_x_xexit_x_xx_x97_symbol : Boolean;
      signal stmt_41_98_symbol : Boolean;
      signal merge_stmt_10_dead_link_101_symbol : Boolean;
      signal merge_stmt_10_x_xentry_x_xx_xPhiReq_105_symbol : Boolean;
      signal loopback_PhiReq_116_symbol : Boolean;
      signal merge_stmt_10_PhiReqMerge_127_symbol : Boolean;
      signal merge_stmt_10_PhiAck_128_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_9_7_start <= assign_stmt_8_3_symbol; -- control passed to block
      Xentry_8_symbol  <= branch_block_stmt_9_7_start; -- transition branch_block_stmt_9/$entry
      branch_block_stmt_9_x_xentry_x_xx_x10_symbol  <=  Xentry_8_symbol; -- place branch_block_stmt_9/branch_block_stmt_9__entry__ (optimized away) 
      branch_block_stmt_9_x_xexit_x_xx_x11_symbol  <=  switch_stmt_30_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_9/branch_block_stmt_9__exit__ (optimized away) 
      merge_stmt_10_x_xentry_x_xx_x12_symbol  <=  branch_block_stmt_9_x_xentry_x_xx_x10_symbol; -- place branch_block_stmt_9/merge_stmt_10__entry__ (optimized away) 
      merge_stmt_10_x_xexit_x_xx_x13_symbol  <=  merge_stmt_10_dead_link_101_symbol or merge_stmt_10_PhiAck_128_symbol; -- place branch_block_stmt_9/merge_stmt_10__exit__ (optimized away) 
      assign_stmt_24_x_xentry_x_xx_x14_symbol  <=  merge_stmt_10_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_9/assign_stmt_24__entry__ (optimized away) 
      assign_stmt_24_x_xexit_x_xx_x15_symbol  <=  assign_stmt_24_20_symbol; -- place branch_block_stmt_9/assign_stmt_24__exit__ (optimized away) 
      assign_stmt_29_x_xentry_x_xx_x16_symbol  <=  assign_stmt_24_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_9/assign_stmt_29__entry__ (optimized away) 
      assign_stmt_29_x_xexit_x_xx_x17_symbol  <=  assign_stmt_29_33_symbol; -- place branch_block_stmt_9/assign_stmt_29__exit__ (optimized away) 
      switch_stmt_30_x_xentry_x_xx_x18_symbol  <=  assign_stmt_29_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_9/switch_stmt_30__entry__ (optimized away) 
      switch_stmt_30_x_xexit_x_xx_x19_symbol  <=  stmt_41_x_xexit_x_xx_x97_symbol or switch_stmt_30_dead_link_46_symbol; -- place branch_block_stmt_9/switch_stmt_30__exit__ (optimized away) 
      assign_stmt_24_20: Block -- branch_block_stmt_9/assign_stmt_24 
        signal assign_stmt_24_20_start: Boolean;
        signal Xentry_21_symbol: Boolean;
        signal Xexit_22_symbol: Boolean;
        signal binary_23_23_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_24_20_start <= assign_stmt_24_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_21_symbol  <= assign_stmt_24_20_start; -- transition branch_block_stmt_9/assign_stmt_24/$entry
        binary_23_23: Block -- branch_block_stmt_9/assign_stmt_24/binary_23 
          signal binary_23_23_start: Boolean;
          signal Xentry_24_symbol: Boolean;
          signal Xexit_25_symbol: Boolean;
          signal binary_23_inputs_26_symbol : Boolean;
          signal rr_29_symbol : Boolean;
          signal ra_30_symbol : Boolean;
          signal cr_31_symbol : Boolean;
          signal ca_32_symbol : Boolean;
          -- 
        begin -- 
          binary_23_23_start <= Xentry_21_symbol; -- control passed to block
          Xentry_24_symbol  <= binary_23_23_start; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/$entry
          binary_23_inputs_26: Block -- branch_block_stmt_9/assign_stmt_24/binary_23/binary_23_inputs 
            signal binary_23_inputs_26_start: Boolean;
            signal Xentry_27_symbol: Boolean;
            signal Xexit_28_symbol: Boolean;
            -- 
          begin -- 
            binary_23_inputs_26_start <= Xentry_24_symbol; -- control passed to block
            Xentry_27_symbol  <= binary_23_inputs_26_start; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/binary_23_inputs/$entry
            Xexit_28_symbol <= Xentry_27_symbol; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/binary_23_inputs/$exit
            binary_23_inputs_26_symbol <= Xexit_28_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_9/assign_stmt_24/binary_23/binary_23_inputs
          rr_29_symbol <= binary_23_inputs_26_symbol; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/rr
          binary_23_inst_req_0 <= rr_29_symbol; -- link to DP
          ra_30_symbol <= binary_23_inst_ack_0; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/ra
          cr_31_symbol <= ra_30_symbol; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/cr
          binary_23_inst_req_1 <= cr_31_symbol; -- link to DP
          ca_32_symbol <= binary_23_inst_ack_1; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/ca
          Xexit_25_symbol <= ca_32_symbol; -- transition branch_block_stmt_9/assign_stmt_24/binary_23/$exit
          binary_23_23_symbol <= Xexit_25_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/assign_stmt_24/binary_23
        Xexit_22_symbol <= binary_23_23_symbol; -- transition branch_block_stmt_9/assign_stmt_24/$exit
        assign_stmt_24_20_symbol <= Xexit_22_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/assign_stmt_24
      assign_stmt_29_33: Block -- branch_block_stmt_9/assign_stmt_29 
        signal assign_stmt_29_33_start: Boolean;
        signal Xentry_34_symbol: Boolean;
        signal Xexit_35_symbol: Boolean;
        signal binary_28_36_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_29_33_start <= assign_stmt_29_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_34_symbol  <= assign_stmt_29_33_start; -- transition branch_block_stmt_9/assign_stmt_29/$entry
        binary_28_36: Block -- branch_block_stmt_9/assign_stmt_29/binary_28 
          signal binary_28_36_start: Boolean;
          signal Xentry_37_symbol: Boolean;
          signal Xexit_38_symbol: Boolean;
          signal binary_28_inputs_39_symbol : Boolean;
          signal rr_42_symbol : Boolean;
          signal ra_43_symbol : Boolean;
          signal cr_44_symbol : Boolean;
          signal ca_45_symbol : Boolean;
          -- 
        begin -- 
          binary_28_36_start <= Xentry_34_symbol; -- control passed to block
          Xentry_37_symbol  <= binary_28_36_start; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/$entry
          binary_28_inputs_39: Block -- branch_block_stmt_9/assign_stmt_29/binary_28/binary_28_inputs 
            signal binary_28_inputs_39_start: Boolean;
            signal Xentry_40_symbol: Boolean;
            signal Xexit_41_symbol: Boolean;
            -- 
          begin -- 
            binary_28_inputs_39_start <= Xentry_37_symbol; -- control passed to block
            Xentry_40_symbol  <= binary_28_inputs_39_start; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/binary_28_inputs/$entry
            Xexit_41_symbol <= Xentry_40_symbol; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/binary_28_inputs/$exit
            binary_28_inputs_39_symbol <= Xexit_41_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_9/assign_stmt_29/binary_28/binary_28_inputs
          rr_42_symbol <= binary_28_inputs_39_symbol; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/rr
          binary_28_inst_req_0 <= rr_42_symbol; -- link to DP
          ra_43_symbol <= binary_28_inst_ack_0; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/ra
          cr_44_symbol <= ra_43_symbol; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/cr
          binary_28_inst_req_1 <= cr_44_symbol; -- link to DP
          ca_45_symbol <= binary_28_inst_ack_1; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/ca
          Xexit_38_symbol <= ca_45_symbol; -- transition branch_block_stmt_9/assign_stmt_29/binary_28/$exit
          binary_28_36_symbol <= Xexit_38_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/assign_stmt_29/binary_28
        Xexit_35_symbol <= binary_28_36_symbol; -- transition branch_block_stmt_9/assign_stmt_29/$exit
        assign_stmt_29_33_symbol <= Xexit_35_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/assign_stmt_29
      switch_stmt_30_dead_link_46: Block -- branch_block_stmt_9/switch_stmt_30_dead_link 
        signal switch_stmt_30_dead_link_46_start: Boolean;
        signal Xentry_47_symbol: Boolean;
        signal Xexit_48_symbol: Boolean;
        signal dead_transition_49_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_30_dead_link_46_start <= switch_stmt_30_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_47_symbol  <= switch_stmt_30_dead_link_46_start; -- transition branch_block_stmt_9/switch_stmt_30_dead_link/$entry
        dead_transition_49_symbol <= false;
        Xexit_48_symbol <= dead_transition_49_symbol; -- transition branch_block_stmt_9/switch_stmt_30_dead_link/$exit
        switch_stmt_30_dead_link_46_symbol <= Xexit_48_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/switch_stmt_30_dead_link
      switch_stmt_30_x_xcondition_check_place_x_xx_x50_symbol  <=  switch_stmt_30_x_xentry_x_xx_x18_symbol; -- place branch_block_stmt_9/switch_stmt_30__condition_check_place__ (optimized away) 
      switch_stmt_30_x_xcondition_check_x_xx_x51: Block -- branch_block_stmt_9/switch_stmt_30__condition_check__ 
        signal switch_stmt_30_x_xcondition_check_x_xx_x51_start: Boolean;
        signal Xentry_52_symbol: Boolean;
        signal Xexit_53_symbol: Boolean;
        signal condition_0_54_symbol : Boolean;
        signal condition_1_62_symbol : Boolean;
        signal condition_2_70_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_30_x_xcondition_check_x_xx_x51_start <= switch_stmt_30_x_xcondition_check_place_x_xx_x50_symbol; -- control passed to block
        Xentry_52_symbol  <= switch_stmt_30_x_xcondition_check_x_xx_x51_start; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/$entry
        condition_0_54: Block -- branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0 
          signal condition_0_54_start: Boolean;
          signal Xentry_55_symbol: Boolean;
          signal Xexit_56_symbol: Boolean;
          signal rr_57_symbol : Boolean;
          signal ra_58_symbol : Boolean;
          signal cr_59_symbol : Boolean;
          signal ca_60_symbol : Boolean;
          signal cmp_61_symbol : Boolean;
          -- 
        begin -- 
          condition_0_54_start <= Xentry_52_symbol; -- control passed to block
          Xentry_55_symbol  <= condition_0_54_start; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/$entry
          rr_57_symbol <= Xentry_55_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/rr
          switch_stmt_30_select_expr_0_req_0 <= rr_57_symbol; -- link to DP
          ra_58_symbol <= switch_stmt_30_select_expr_0_ack_0; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/ra
          cr_59_symbol <= ra_58_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/cr
          switch_stmt_30_select_expr_0_req_1 <= cr_59_symbol; -- link to DP
          ca_60_symbol <= switch_stmt_30_select_expr_0_ack_1; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/ca
          cmp_61_symbol <= ca_60_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/cmp
          switch_stmt_30_branch_0_req_0 <= cmp_61_symbol; -- link to DP
          Xexit_56_symbol <= cmp_61_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0/$exit
          condition_0_54_symbol <= Xexit_56_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/switch_stmt_30__condition_check__/condition_0
        condition_1_62: Block -- branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1 
          signal condition_1_62_start: Boolean;
          signal Xentry_63_symbol: Boolean;
          signal Xexit_64_symbol: Boolean;
          signal rr_65_symbol : Boolean;
          signal ra_66_symbol : Boolean;
          signal cr_67_symbol : Boolean;
          signal ca_68_symbol : Boolean;
          signal cmp_69_symbol : Boolean;
          -- 
        begin -- 
          condition_1_62_start <= Xentry_52_symbol; -- control passed to block
          Xentry_63_symbol  <= condition_1_62_start; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/$entry
          rr_65_symbol <= Xentry_63_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/rr
          switch_stmt_30_select_expr_1_req_0 <= rr_65_symbol; -- link to DP
          ra_66_symbol <= switch_stmt_30_select_expr_1_ack_0; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/ra
          cr_67_symbol <= ra_66_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/cr
          switch_stmt_30_select_expr_1_req_1 <= cr_67_symbol; -- link to DP
          ca_68_symbol <= switch_stmt_30_select_expr_1_ack_1; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/ca
          cmp_69_symbol <= ca_68_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/cmp
          switch_stmt_30_branch_1_req_0 <= cmp_69_symbol; -- link to DP
          Xexit_64_symbol <= cmp_69_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1/$exit
          condition_1_62_symbol <= Xexit_64_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/switch_stmt_30__condition_check__/condition_1
        condition_2_70: Block -- branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2 
          signal condition_2_70_start: Boolean;
          signal Xentry_71_symbol: Boolean;
          signal Xexit_72_symbol: Boolean;
          signal rr_73_symbol : Boolean;
          signal ra_74_symbol : Boolean;
          signal cr_75_symbol : Boolean;
          signal ca_76_symbol : Boolean;
          signal cmp_77_symbol : Boolean;
          -- 
        begin -- 
          condition_2_70_start <= Xentry_52_symbol; -- control passed to block
          Xentry_71_symbol  <= condition_2_70_start; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/$entry
          rr_73_symbol <= Xentry_71_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/rr
          switch_stmt_30_select_expr_2_req_0 <= rr_73_symbol; -- link to DP
          ra_74_symbol <= switch_stmt_30_select_expr_2_ack_0; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/ra
          cr_75_symbol <= ra_74_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/cr
          switch_stmt_30_select_expr_2_req_1 <= cr_75_symbol; -- link to DP
          ca_76_symbol <= switch_stmt_30_select_expr_2_ack_1; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/ca
          cmp_77_symbol <= ca_76_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/cmp
          switch_stmt_30_branch_2_req_0 <= cmp_77_symbol; -- link to DP
          Xexit_72_symbol <= cmp_77_symbol; -- transition branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2/$exit
          condition_2_70_symbol <= Xexit_72_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/switch_stmt_30__condition_check__/condition_2
        Xexit_53_block : Block -- non-trivial join transition branch_block_stmt_9/switch_stmt_30__condition_check__/$exit 
          signal Xexit_53_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          Xexit_53_predecessors(0) <= condition_0_54_symbol;
          Xexit_53_predecessors(1) <= condition_1_62_symbol;
          Xexit_53_predecessors(2) <= condition_2_70_symbol;
          Xexit_53_join: join -- 
            port map( -- 
              preds => Xexit_53_predecessors,
              symbol_out => Xexit_53_symbol,
              clk => clk,
              reset => reset); -- 
          switch_stmt_30_branch_default_req_0 <= Xexit_53_symbol; -- link to DP
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_9/switch_stmt_30__condition_check__/$exit
        switch_stmt_30_x_xcondition_check_x_xx_x51_symbol <= Xexit_53_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/switch_stmt_30__condition_check__
      switch_stmt_30_x_xselect_x_xx_x78_symbol  <=  switch_stmt_30_x_xcondition_check_x_xx_x51_symbol; -- place branch_block_stmt_9/switch_stmt_30__select__ (optimized away) 
      switch_stmt_30_choice_0_79: Block -- branch_block_stmt_9/switch_stmt_30_choice_0 
        signal switch_stmt_30_choice_0_79_start: Boolean;
        signal Xentry_80_symbol: Boolean;
        signal Xexit_81_symbol: Boolean;
        signal ack1_82_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_30_choice_0_79_start <= switch_stmt_30_x_xselect_x_xx_x78_symbol; -- control passed to block
        Xentry_80_symbol  <= switch_stmt_30_choice_0_79_start; -- transition branch_block_stmt_9/switch_stmt_30_choice_0/$entry
        ack1_82_symbol <= switch_stmt_30_branch_0_ack_1; -- transition branch_block_stmt_9/switch_stmt_30_choice_0/ack1
        Xexit_81_symbol <= ack1_82_symbol; -- transition branch_block_stmt_9/switch_stmt_30_choice_0/$exit
        switch_stmt_30_choice_0_79_symbol <= Xexit_81_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/switch_stmt_30_choice_0
      loopback_83_symbol  <=  switch_stmt_30_choice_0_79_symbol or switch_stmt_30_choice_1_84_symbol or switch_stmt_30_choice_2_88_symbol; -- place branch_block_stmt_9/loopback (optimized away) 
      switch_stmt_30_choice_1_84: Block -- branch_block_stmt_9/switch_stmt_30_choice_1 
        signal switch_stmt_30_choice_1_84_start: Boolean;
        signal Xentry_85_symbol: Boolean;
        signal Xexit_86_symbol: Boolean;
        signal ack1_87_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_30_choice_1_84_start <= switch_stmt_30_x_xselect_x_xx_x78_symbol; -- control passed to block
        Xentry_85_symbol  <= switch_stmt_30_choice_1_84_start; -- transition branch_block_stmt_9/switch_stmt_30_choice_1/$entry
        ack1_87_symbol <= switch_stmt_30_branch_1_ack_1; -- transition branch_block_stmt_9/switch_stmt_30_choice_1/ack1
        Xexit_86_symbol <= ack1_87_symbol; -- transition branch_block_stmt_9/switch_stmt_30_choice_1/$exit
        switch_stmt_30_choice_1_84_symbol <= Xexit_86_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/switch_stmt_30_choice_1
      switch_stmt_30_choice_2_88: Block -- branch_block_stmt_9/switch_stmt_30_choice_2 
        signal switch_stmt_30_choice_2_88_start: Boolean;
        signal Xentry_89_symbol: Boolean;
        signal Xexit_90_symbol: Boolean;
        signal ack1_91_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_30_choice_2_88_start <= switch_stmt_30_x_xselect_x_xx_x78_symbol; -- control passed to block
        Xentry_89_symbol  <= switch_stmt_30_choice_2_88_start; -- transition branch_block_stmt_9/switch_stmt_30_choice_2/$entry
        ack1_91_symbol <= switch_stmt_30_branch_2_ack_1; -- transition branch_block_stmt_9/switch_stmt_30_choice_2/ack1
        Xexit_90_symbol <= ack1_91_symbol; -- transition branch_block_stmt_9/switch_stmt_30_choice_2/$exit
        switch_stmt_30_choice_2_88_symbol <= Xexit_90_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/switch_stmt_30_choice_2
      switch_stmt_30_choice_default_92: Block -- branch_block_stmt_9/switch_stmt_30_choice_default 
        signal switch_stmt_30_choice_default_92_start: Boolean;
        signal Xentry_93_symbol: Boolean;
        signal Xexit_94_symbol: Boolean;
        signal ack0_95_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_30_choice_default_92_start <= switch_stmt_30_x_xselect_x_xx_x78_symbol; -- control passed to block
        Xentry_93_symbol  <= switch_stmt_30_choice_default_92_start; -- transition branch_block_stmt_9/switch_stmt_30_choice_default/$entry
        ack0_95_symbol <= switch_stmt_30_branch_default_ack_0; -- transition branch_block_stmt_9/switch_stmt_30_choice_default/ack0
        Xexit_94_symbol <= ack0_95_symbol; -- transition branch_block_stmt_9/switch_stmt_30_choice_default/$exit
        switch_stmt_30_choice_default_92_symbol <= Xexit_94_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/switch_stmt_30_choice_default
      stmt_41_x_xentry_x_xx_x96_symbol  <=  switch_stmt_30_choice_default_92_symbol; -- place branch_block_stmt_9/stmt_41__entry__ (optimized away) 
      stmt_41_x_xexit_x_xx_x97_symbol  <=  stmt_41_98_symbol; -- place branch_block_stmt_9/stmt_41__exit__ (optimized away) 
      stmt_41_98: Block -- branch_block_stmt_9/stmt_41 
        signal stmt_41_98_start: Boolean;
        signal Xentry_99_symbol: Boolean;
        signal Xexit_100_symbol: Boolean;
        -- 
      begin -- 
        stmt_41_98_start <= stmt_41_x_xentry_x_xx_x96_symbol; -- control passed to block
        Xentry_99_symbol  <= stmt_41_98_start; -- transition branch_block_stmt_9/stmt_41/$entry
        Xexit_100_symbol <= Xentry_99_symbol; -- transition branch_block_stmt_9/stmt_41/$exit
        stmt_41_98_symbol <= Xexit_100_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/stmt_41
      merge_stmt_10_dead_link_101: Block -- branch_block_stmt_9/merge_stmt_10_dead_link 
        signal merge_stmt_10_dead_link_101_start: Boolean;
        signal Xentry_102_symbol: Boolean;
        signal Xexit_103_symbol: Boolean;
        signal dead_transition_104_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_10_dead_link_101_start <= merge_stmt_10_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_102_symbol  <= merge_stmt_10_dead_link_101_start; -- transition branch_block_stmt_9/merge_stmt_10_dead_link/$entry
        dead_transition_104_symbol <= false;
        Xexit_103_symbol <= dead_transition_104_symbol; -- transition branch_block_stmt_9/merge_stmt_10_dead_link/$exit
        merge_stmt_10_dead_link_101_symbol <= Xexit_103_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/merge_stmt_10_dead_link
      merge_stmt_10_x_xentry_x_xx_xPhiReq_105: Block -- branch_block_stmt_9/merge_stmt_10__entry___PhiReq 
        signal merge_stmt_10_x_xentry_x_xx_xPhiReq_105_start: Boolean;
        signal Xentry_106_symbol: Boolean;
        signal Xexit_107_symbol: Boolean;
        signal phi_stmt_11_108_symbol : Boolean;
        signal phi_stmt_15_112_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_10_x_xentry_x_xx_xPhiReq_105_start <= merge_stmt_10_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_106_symbol  <= merge_stmt_10_x_xentry_x_xx_xPhiReq_105_start; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/$entry
        phi_stmt_11_108: Block -- branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11 
          signal phi_stmt_11_108_start: Boolean;
          signal Xentry_109_symbol: Boolean;
          signal Xexit_110_symbol: Boolean;
          signal phi_stmt_11_req_111_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_11_108_start <= Xentry_106_symbol; -- control passed to block
          Xentry_109_symbol  <= phi_stmt_11_108_start; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/$entry
          phi_stmt_11_req_111_symbol <= Xentry_109_symbol; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/phi_stmt_11_req
          phi_stmt_11_req_0 <= phi_stmt_11_req_111_symbol; -- link to DP
          Xexit_110_symbol <= phi_stmt_11_req_111_symbol; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11/$exit
          phi_stmt_11_108_symbol <= Xexit_110_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_11
        phi_stmt_15_112: Block -- branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_15 
          signal phi_stmt_15_112_start: Boolean;
          signal Xentry_113_symbol: Boolean;
          signal Xexit_114_symbol: Boolean;
          signal phi_stmt_15_req_115_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_15_112_start <= Xentry_106_symbol; -- control passed to block
          Xentry_113_symbol  <= phi_stmt_15_112_start; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_15/$entry
          phi_stmt_15_req_115_symbol <= Xentry_113_symbol; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_15/phi_stmt_15_req
          phi_stmt_15_req_0 <= phi_stmt_15_req_115_symbol; -- link to DP
          Xexit_114_symbol <= phi_stmt_15_req_115_symbol; -- transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_15/$exit
          phi_stmt_15_112_symbol <= Xexit_114_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/merge_stmt_10__entry___PhiReq/phi_stmt_15
        Xexit_107_block : Block -- non-trivial join transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/$exit 
          signal Xexit_107_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_107_predecessors(0) <= phi_stmt_11_108_symbol;
          Xexit_107_predecessors(1) <= phi_stmt_15_112_symbol;
          Xexit_107_join: join -- 
            port map( -- 
              preds => Xexit_107_predecessors,
              symbol_out => Xexit_107_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_9/merge_stmt_10__entry___PhiReq/$exit
        merge_stmt_10_x_xentry_x_xx_xPhiReq_105_symbol <= Xexit_107_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/merge_stmt_10__entry___PhiReq
      loopback_PhiReq_116: Block -- branch_block_stmt_9/loopback_PhiReq 
        signal loopback_PhiReq_116_start: Boolean;
        signal Xentry_117_symbol: Boolean;
        signal Xexit_118_symbol: Boolean;
        signal phi_stmt_11_119_symbol : Boolean;
        signal phi_stmt_15_123_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_116_start <= loopback_83_symbol; -- control passed to block
        Xentry_117_symbol  <= loopback_PhiReq_116_start; -- transition branch_block_stmt_9/loopback_PhiReq/$entry
        phi_stmt_11_119: Block -- branch_block_stmt_9/loopback_PhiReq/phi_stmt_11 
          signal phi_stmt_11_119_start: Boolean;
          signal Xentry_120_symbol: Boolean;
          signal Xexit_121_symbol: Boolean;
          signal phi_stmt_11_req_122_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_11_119_start <= Xentry_117_symbol; -- control passed to block
          Xentry_120_symbol  <= phi_stmt_11_119_start; -- transition branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/$entry
          phi_stmt_11_req_122_symbol <= Xentry_120_symbol; -- transition branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/phi_stmt_11_req
          phi_stmt_11_req_1 <= phi_stmt_11_req_122_symbol; -- link to DP
          Xexit_121_symbol <= phi_stmt_11_req_122_symbol; -- transition branch_block_stmt_9/loopback_PhiReq/phi_stmt_11/$exit
          phi_stmt_11_119_symbol <= Xexit_121_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/loopback_PhiReq/phi_stmt_11
        phi_stmt_15_123: Block -- branch_block_stmt_9/loopback_PhiReq/phi_stmt_15 
          signal phi_stmt_15_123_start: Boolean;
          signal Xentry_124_symbol: Boolean;
          signal Xexit_125_symbol: Boolean;
          signal phi_stmt_15_req_126_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_15_123_start <= Xentry_117_symbol; -- control passed to block
          Xentry_124_symbol  <= phi_stmt_15_123_start; -- transition branch_block_stmt_9/loopback_PhiReq/phi_stmt_15/$entry
          phi_stmt_15_req_126_symbol <= Xentry_124_symbol; -- transition branch_block_stmt_9/loopback_PhiReq/phi_stmt_15/phi_stmt_15_req
          phi_stmt_15_req_1 <= phi_stmt_15_req_126_symbol; -- link to DP
          Xexit_125_symbol <= phi_stmt_15_req_126_symbol; -- transition branch_block_stmt_9/loopback_PhiReq/phi_stmt_15/$exit
          phi_stmt_15_123_symbol <= Xexit_125_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_9/loopback_PhiReq/phi_stmt_15
        Xexit_118_block : Block -- non-trivial join transition branch_block_stmt_9/loopback_PhiReq/$exit 
          signal Xexit_118_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_118_predecessors(0) <= phi_stmt_11_119_symbol;
          Xexit_118_predecessors(1) <= phi_stmt_15_123_symbol;
          Xexit_118_join: join -- 
            port map( -- 
              preds => Xexit_118_predecessors,
              symbol_out => Xexit_118_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_9/loopback_PhiReq/$exit
        loopback_PhiReq_116_symbol <= Xexit_118_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/loopback_PhiReq
      merge_stmt_10_PhiReqMerge_127_symbol  <=  merge_stmt_10_x_xentry_x_xx_xPhiReq_105_symbol or loopback_PhiReq_116_symbol; -- place branch_block_stmt_9/merge_stmt_10_PhiReqMerge (optimized away) 
      merge_stmt_10_PhiAck_128: Block -- branch_block_stmt_9/merge_stmt_10_PhiAck 
        signal merge_stmt_10_PhiAck_128_start: Boolean;
        signal Xentry_129_symbol: Boolean;
        signal Xexit_130_symbol: Boolean;
        signal phi_stmt_11_ack_131_symbol : Boolean;
        signal phi_stmt_15_ack_132_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_10_PhiAck_128_start <= merge_stmt_10_PhiReqMerge_127_symbol; -- control passed to block
        Xentry_129_symbol  <= merge_stmt_10_PhiAck_128_start; -- transition branch_block_stmt_9/merge_stmt_10_PhiAck/$entry
        phi_stmt_11_ack_131_symbol <= phi_stmt_11_ack_0; -- transition branch_block_stmt_9/merge_stmt_10_PhiAck/phi_stmt_11_ack
        phi_stmt_15_ack_132_symbol <= phi_stmt_15_ack_0; -- transition branch_block_stmt_9/merge_stmt_10_PhiAck/phi_stmt_15_ack
        Xexit_130_block : Block -- non-trivial join transition branch_block_stmt_9/merge_stmt_10_PhiAck/$exit 
          signal Xexit_130_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_130_predecessors(0) <= phi_stmt_11_ack_131_symbol;
          Xexit_130_predecessors(1) <= phi_stmt_15_ack_132_symbol;
          Xexit_130_join: join -- 
            port map( -- 
              preds => Xexit_130_predecessors,
              symbol_out => Xexit_130_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_9/merge_stmt_10_PhiAck/$exit
        merge_stmt_10_PhiAck_128_symbol <= Xexit_130_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_9/merge_stmt_10_PhiAck
      Xexit_9_symbol <= branch_block_stmt_9_x_xexit_x_xx_x11_symbol; -- transition branch_block_stmt_9/$exit
      branch_block_stmt_9_7_symbol <= Xexit_9_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_9
    branch_block_stmt_44_133: Block -- branch_block_stmt_44 
      signal branch_block_stmt_44_133_start: Boolean;
      signal Xentry_134_symbol: Boolean;
      signal Xexit_135_symbol: Boolean;
      signal branch_block_stmt_44_x_xentry_x_xx_x136_symbol : Boolean;
      signal branch_block_stmt_44_x_xexit_x_xx_x137_symbol : Boolean;
      signal merge_stmt_45_x_xentry_x_xx_x138_symbol : Boolean;
      signal merge_stmt_45_x_xexit_x_xx_x139_symbol : Boolean;
      signal assign_stmt_59_x_xentry_x_xx_x140_symbol : Boolean;
      signal assign_stmt_59_x_xexit_x_xx_x141_symbol : Boolean;
      signal assign_stmt_64_x_xentry_x_xx_x142_symbol : Boolean;
      signal assign_stmt_64_x_xexit_x_xx_x143_symbol : Boolean;
      signal if_stmt_65_x_xentry_x_xx_x144_symbol : Boolean;
      signal if_stmt_65_x_xexit_x_xx_x145_symbol : Boolean;
      signal assign_stmt_59_146_symbol : Boolean;
      signal assign_stmt_64_159_symbol : Boolean;
      signal if_stmt_65_dead_link_172_symbol : Boolean;
      signal if_stmt_65_eval_test_176_symbol : Boolean;
      signal binary_68_place_190_symbol : Boolean;
      signal if_stmt_65_if_link_191_symbol : Boolean;
      signal if_stmt_65_else_link_195_symbol : Boolean;
      signal loopback_199_symbol : Boolean;
      signal stmt_71_x_xentry_x_xx_x200_symbol : Boolean;
      signal stmt_71_x_xexit_x_xx_x201_symbol : Boolean;
      signal stmt_71_202_symbol : Boolean;
      signal merge_stmt_45_dead_link_205_symbol : Boolean;
      signal merge_stmt_45_x_xentry_x_xx_xPhiReq_209_symbol : Boolean;
      signal loopback_PhiReq_220_symbol : Boolean;
      signal merge_stmt_45_PhiReqMerge_231_symbol : Boolean;
      signal merge_stmt_45_PhiAck_232_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_44_133_start <= branch_block_stmt_9_7_symbol; -- control passed to block
      Xentry_134_symbol  <= branch_block_stmt_44_133_start; -- transition branch_block_stmt_44/$entry
      branch_block_stmt_44_x_xentry_x_xx_x136_symbol  <=  Xentry_134_symbol; -- place branch_block_stmt_44/branch_block_stmt_44__entry__ (optimized away) 
      branch_block_stmt_44_x_xexit_x_xx_x137_symbol  <=  if_stmt_65_x_xexit_x_xx_x145_symbol; -- place branch_block_stmt_44/branch_block_stmt_44__exit__ (optimized away) 
      merge_stmt_45_x_xentry_x_xx_x138_symbol  <=  branch_block_stmt_44_x_xentry_x_xx_x136_symbol; -- place branch_block_stmt_44/merge_stmt_45__entry__ (optimized away) 
      merge_stmt_45_x_xexit_x_xx_x139_symbol  <=  merge_stmt_45_dead_link_205_symbol or merge_stmt_45_PhiAck_232_symbol; -- place branch_block_stmt_44/merge_stmt_45__exit__ (optimized away) 
      assign_stmt_59_x_xentry_x_xx_x140_symbol  <=  merge_stmt_45_x_xexit_x_xx_x139_symbol; -- place branch_block_stmt_44/assign_stmt_59__entry__ (optimized away) 
      assign_stmt_59_x_xexit_x_xx_x141_symbol  <=  assign_stmt_59_146_symbol; -- place branch_block_stmt_44/assign_stmt_59__exit__ (optimized away) 
      assign_stmt_64_x_xentry_x_xx_x142_symbol  <=  assign_stmt_59_x_xexit_x_xx_x141_symbol; -- place branch_block_stmt_44/assign_stmt_64__entry__ (optimized away) 
      assign_stmt_64_x_xexit_x_xx_x143_symbol  <=  assign_stmt_64_159_symbol; -- place branch_block_stmt_44/assign_stmt_64__exit__ (optimized away) 
      if_stmt_65_x_xentry_x_xx_x144_symbol  <=  assign_stmt_64_x_xexit_x_xx_x143_symbol; -- place branch_block_stmt_44/if_stmt_65__entry__ (optimized away) 
      if_stmt_65_x_xexit_x_xx_x145_symbol  <=  stmt_71_x_xexit_x_xx_x201_symbol or if_stmt_65_dead_link_172_symbol or if_stmt_65_dead_link_172_symbol; -- place branch_block_stmt_44/if_stmt_65__exit__ (optimized away) 
      assign_stmt_59_146: Block -- branch_block_stmt_44/assign_stmt_59 
        signal assign_stmt_59_146_start: Boolean;
        signal Xentry_147_symbol: Boolean;
        signal Xexit_148_symbol: Boolean;
        signal binary_58_149_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_59_146_start <= assign_stmt_59_x_xentry_x_xx_x140_symbol; -- control passed to block
        Xentry_147_symbol  <= assign_stmt_59_146_start; -- transition branch_block_stmt_44/assign_stmt_59/$entry
        binary_58_149: Block -- branch_block_stmt_44/assign_stmt_59/binary_58 
          signal binary_58_149_start: Boolean;
          signal Xentry_150_symbol: Boolean;
          signal Xexit_151_symbol: Boolean;
          signal binary_58_inputs_152_symbol : Boolean;
          signal rr_155_symbol : Boolean;
          signal ra_156_symbol : Boolean;
          signal cr_157_symbol : Boolean;
          signal ca_158_symbol : Boolean;
          -- 
        begin -- 
          binary_58_149_start <= Xentry_147_symbol; -- control passed to block
          Xentry_150_symbol  <= binary_58_149_start; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/$entry
          binary_58_inputs_152: Block -- branch_block_stmt_44/assign_stmt_59/binary_58/binary_58_inputs 
            signal binary_58_inputs_152_start: Boolean;
            signal Xentry_153_symbol: Boolean;
            signal Xexit_154_symbol: Boolean;
            -- 
          begin -- 
            binary_58_inputs_152_start <= Xentry_150_symbol; -- control passed to block
            Xentry_153_symbol  <= binary_58_inputs_152_start; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/binary_58_inputs/$entry
            Xexit_154_symbol <= Xentry_153_symbol; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/binary_58_inputs/$exit
            binary_58_inputs_152_symbol <= Xexit_154_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_44/assign_stmt_59/binary_58/binary_58_inputs
          rr_155_symbol <= binary_58_inputs_152_symbol; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/rr
          binary_58_inst_req_0 <= rr_155_symbol; -- link to DP
          ra_156_symbol <= binary_58_inst_ack_0; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/ra
          cr_157_symbol <= ra_156_symbol; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/cr
          binary_58_inst_req_1 <= cr_157_symbol; -- link to DP
          ca_158_symbol <= binary_58_inst_ack_1; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/ca
          Xexit_151_symbol <= ca_158_symbol; -- transition branch_block_stmt_44/assign_stmt_59/binary_58/$exit
          binary_58_149_symbol <= Xexit_151_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/assign_stmt_59/binary_58
        Xexit_148_symbol <= binary_58_149_symbol; -- transition branch_block_stmt_44/assign_stmt_59/$exit
        assign_stmt_59_146_symbol <= Xexit_148_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/assign_stmt_59
      assign_stmt_64_159: Block -- branch_block_stmt_44/assign_stmt_64 
        signal assign_stmt_64_159_start: Boolean;
        signal Xentry_160_symbol: Boolean;
        signal Xexit_161_symbol: Boolean;
        signal binary_63_162_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_64_159_start <= assign_stmt_64_x_xentry_x_xx_x142_symbol; -- control passed to block
        Xentry_160_symbol  <= assign_stmt_64_159_start; -- transition branch_block_stmt_44/assign_stmt_64/$entry
        binary_63_162: Block -- branch_block_stmt_44/assign_stmt_64/binary_63 
          signal binary_63_162_start: Boolean;
          signal Xentry_163_symbol: Boolean;
          signal Xexit_164_symbol: Boolean;
          signal binary_63_inputs_165_symbol : Boolean;
          signal rr_168_symbol : Boolean;
          signal ra_169_symbol : Boolean;
          signal cr_170_symbol : Boolean;
          signal ca_171_symbol : Boolean;
          -- 
        begin -- 
          binary_63_162_start <= Xentry_160_symbol; -- control passed to block
          Xentry_163_symbol  <= binary_63_162_start; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/$entry
          binary_63_inputs_165: Block -- branch_block_stmt_44/assign_stmt_64/binary_63/binary_63_inputs 
            signal binary_63_inputs_165_start: Boolean;
            signal Xentry_166_symbol: Boolean;
            signal Xexit_167_symbol: Boolean;
            -- 
          begin -- 
            binary_63_inputs_165_start <= Xentry_163_symbol; -- control passed to block
            Xentry_166_symbol  <= binary_63_inputs_165_start; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/binary_63_inputs/$entry
            Xexit_167_symbol <= Xentry_166_symbol; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/binary_63_inputs/$exit
            binary_63_inputs_165_symbol <= Xexit_167_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_44/assign_stmt_64/binary_63/binary_63_inputs
          rr_168_symbol <= binary_63_inputs_165_symbol; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/rr
          binary_63_inst_req_0 <= rr_168_symbol; -- link to DP
          ra_169_symbol <= binary_63_inst_ack_0; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/ra
          cr_170_symbol <= ra_169_symbol; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/cr
          binary_63_inst_req_1 <= cr_170_symbol; -- link to DP
          ca_171_symbol <= binary_63_inst_ack_1; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/ca
          Xexit_164_symbol <= ca_171_symbol; -- transition branch_block_stmt_44/assign_stmt_64/binary_63/$exit
          binary_63_162_symbol <= Xexit_164_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/assign_stmt_64/binary_63
        Xexit_161_symbol <= binary_63_162_symbol; -- transition branch_block_stmt_44/assign_stmt_64/$exit
        assign_stmt_64_159_symbol <= Xexit_161_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/assign_stmt_64
      if_stmt_65_dead_link_172: Block -- branch_block_stmt_44/if_stmt_65_dead_link 
        signal if_stmt_65_dead_link_172_start: Boolean;
        signal Xentry_173_symbol: Boolean;
        signal Xexit_174_symbol: Boolean;
        signal dead_transition_175_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_65_dead_link_172_start <= if_stmt_65_x_xentry_x_xx_x144_symbol; -- control passed to block
        Xentry_173_symbol  <= if_stmt_65_dead_link_172_start; -- transition branch_block_stmt_44/if_stmt_65_dead_link/$entry
        dead_transition_175_symbol <= false;
        Xexit_174_symbol <= dead_transition_175_symbol; -- transition branch_block_stmt_44/if_stmt_65_dead_link/$exit
        if_stmt_65_dead_link_172_symbol <= Xexit_174_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/if_stmt_65_dead_link
      if_stmt_65_eval_test_176: Block -- branch_block_stmt_44/if_stmt_65_eval_test 
        signal if_stmt_65_eval_test_176_start: Boolean;
        signal Xentry_177_symbol: Boolean;
        signal Xexit_178_symbol: Boolean;
        signal binary_68_179_symbol : Boolean;
        signal branch_req_189_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_65_eval_test_176_start <= if_stmt_65_x_xentry_x_xx_x144_symbol; -- control passed to block
        Xentry_177_symbol  <= if_stmt_65_eval_test_176_start; -- transition branch_block_stmt_44/if_stmt_65_eval_test/$entry
        binary_68_179: Block -- branch_block_stmt_44/if_stmt_65_eval_test/binary_68 
          signal binary_68_179_start: Boolean;
          signal Xentry_180_symbol: Boolean;
          signal Xexit_181_symbol: Boolean;
          signal binary_68_inputs_182_symbol : Boolean;
          signal rr_185_symbol : Boolean;
          signal ra_186_symbol : Boolean;
          signal cr_187_symbol : Boolean;
          signal ca_188_symbol : Boolean;
          -- 
        begin -- 
          binary_68_179_start <= Xentry_177_symbol; -- control passed to block
          Xentry_180_symbol  <= binary_68_179_start; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/$entry
          binary_68_inputs_182: Block -- branch_block_stmt_44/if_stmt_65_eval_test/binary_68/binary_68_inputs 
            signal binary_68_inputs_182_start: Boolean;
            signal Xentry_183_symbol: Boolean;
            signal Xexit_184_symbol: Boolean;
            -- 
          begin -- 
            binary_68_inputs_182_start <= Xentry_180_symbol; -- control passed to block
            Xentry_183_symbol  <= binary_68_inputs_182_start; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/binary_68_inputs/$entry
            Xexit_184_symbol <= Xentry_183_symbol; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/binary_68_inputs/$exit
            binary_68_inputs_182_symbol <= Xexit_184_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_44/if_stmt_65_eval_test/binary_68/binary_68_inputs
          rr_185_symbol <= binary_68_inputs_182_symbol; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/rr
          binary_68_inst_req_0 <= rr_185_symbol; -- link to DP
          ra_186_symbol <= binary_68_inst_ack_0; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/ra
          cr_187_symbol <= ra_186_symbol; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/cr
          binary_68_inst_req_1 <= cr_187_symbol; -- link to DP
          ca_188_symbol <= binary_68_inst_ack_1; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/ca
          Xexit_181_symbol <= ca_188_symbol; -- transition branch_block_stmt_44/if_stmt_65_eval_test/binary_68/$exit
          binary_68_179_symbol <= Xexit_181_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/if_stmt_65_eval_test/binary_68
        branch_req_189_symbol <= binary_68_179_symbol; -- transition branch_block_stmt_44/if_stmt_65_eval_test/branch_req
        if_stmt_65_branch_req_0 <= branch_req_189_symbol; -- link to DP
        Xexit_178_symbol <= branch_req_189_symbol; -- transition branch_block_stmt_44/if_stmt_65_eval_test/$exit
        if_stmt_65_eval_test_176_symbol <= Xexit_178_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/if_stmt_65_eval_test
      binary_68_place_190_symbol  <=  if_stmt_65_eval_test_176_symbol; -- place branch_block_stmt_44/binary_68_place (optimized away) 
      if_stmt_65_if_link_191: Block -- branch_block_stmt_44/if_stmt_65_if_link 
        signal if_stmt_65_if_link_191_start: Boolean;
        signal Xentry_192_symbol: Boolean;
        signal Xexit_193_symbol: Boolean;
        signal if_choice_transition_194_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_65_if_link_191_start <= binary_68_place_190_symbol; -- control passed to block
        Xentry_192_symbol  <= if_stmt_65_if_link_191_start; -- transition branch_block_stmt_44/if_stmt_65_if_link/$entry
        if_choice_transition_194_symbol <= if_stmt_65_branch_ack_1; -- transition branch_block_stmt_44/if_stmt_65_if_link/if_choice_transition
        Xexit_193_symbol <= if_choice_transition_194_symbol; -- transition branch_block_stmt_44/if_stmt_65_if_link/$exit
        if_stmt_65_if_link_191_symbol <= Xexit_193_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/if_stmt_65_if_link
      if_stmt_65_else_link_195: Block -- branch_block_stmt_44/if_stmt_65_else_link 
        signal if_stmt_65_else_link_195_start: Boolean;
        signal Xentry_196_symbol: Boolean;
        signal Xexit_197_symbol: Boolean;
        signal else_choice_transition_198_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_65_else_link_195_start <= binary_68_place_190_symbol; -- control passed to block
        Xentry_196_symbol  <= if_stmt_65_else_link_195_start; -- transition branch_block_stmt_44/if_stmt_65_else_link/$entry
        else_choice_transition_198_symbol <= if_stmt_65_branch_ack_0; -- transition branch_block_stmt_44/if_stmt_65_else_link/else_choice_transition
        Xexit_197_symbol <= else_choice_transition_198_symbol; -- transition branch_block_stmt_44/if_stmt_65_else_link/$exit
        if_stmt_65_else_link_195_symbol <= Xexit_197_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/if_stmt_65_else_link
      loopback_199_symbol  <=  if_stmt_65_if_link_191_symbol; -- place branch_block_stmt_44/loopback (optimized away) 
      stmt_71_x_xentry_x_xx_x200_symbol  <=  if_stmt_65_else_link_195_symbol; -- place branch_block_stmt_44/stmt_71__entry__ (optimized away) 
      stmt_71_x_xexit_x_xx_x201_symbol  <=  stmt_71_202_symbol; -- place branch_block_stmt_44/stmt_71__exit__ (optimized away) 
      stmt_71_202: Block -- branch_block_stmt_44/stmt_71 
        signal stmt_71_202_start: Boolean;
        signal Xentry_203_symbol: Boolean;
        signal Xexit_204_symbol: Boolean;
        -- 
      begin -- 
        stmt_71_202_start <= stmt_71_x_xentry_x_xx_x200_symbol; -- control passed to block
        Xentry_203_symbol  <= stmt_71_202_start; -- transition branch_block_stmt_44/stmt_71/$entry
        Xexit_204_symbol <= Xentry_203_symbol; -- transition branch_block_stmt_44/stmt_71/$exit
        stmt_71_202_symbol <= Xexit_204_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/stmt_71
      merge_stmt_45_dead_link_205: Block -- branch_block_stmt_44/merge_stmt_45_dead_link 
        signal merge_stmt_45_dead_link_205_start: Boolean;
        signal Xentry_206_symbol: Boolean;
        signal Xexit_207_symbol: Boolean;
        signal dead_transition_208_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_45_dead_link_205_start <= merge_stmt_45_x_xentry_x_xx_x138_symbol; -- control passed to block
        Xentry_206_symbol  <= merge_stmt_45_dead_link_205_start; -- transition branch_block_stmt_44/merge_stmt_45_dead_link/$entry
        dead_transition_208_symbol <= false;
        Xexit_207_symbol <= dead_transition_208_symbol; -- transition branch_block_stmt_44/merge_stmt_45_dead_link/$exit
        merge_stmt_45_dead_link_205_symbol <= Xexit_207_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/merge_stmt_45_dead_link
      merge_stmt_45_x_xentry_x_xx_xPhiReq_209: Block -- branch_block_stmt_44/merge_stmt_45__entry___PhiReq 
        signal merge_stmt_45_x_xentry_x_xx_xPhiReq_209_start: Boolean;
        signal Xentry_210_symbol: Boolean;
        signal Xexit_211_symbol: Boolean;
        signal phi_stmt_46_212_symbol : Boolean;
        signal phi_stmt_50_216_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_45_x_xentry_x_xx_xPhiReq_209_start <= merge_stmt_45_x_xentry_x_xx_x138_symbol; -- control passed to block
        Xentry_210_symbol  <= merge_stmt_45_x_xentry_x_xx_xPhiReq_209_start; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/$entry
        phi_stmt_46_212: Block -- branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_46 
          signal phi_stmt_46_212_start: Boolean;
          signal Xentry_213_symbol: Boolean;
          signal Xexit_214_symbol: Boolean;
          signal phi_stmt_46_req_215_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_46_212_start <= Xentry_210_symbol; -- control passed to block
          Xentry_213_symbol  <= phi_stmt_46_212_start; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_46/$entry
          phi_stmt_46_req_215_symbol <= Xentry_213_symbol; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_46/phi_stmt_46_req
          phi_stmt_46_req_0 <= phi_stmt_46_req_215_symbol; -- link to DP
          Xexit_214_symbol <= phi_stmt_46_req_215_symbol; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_46/$exit
          phi_stmt_46_212_symbol <= Xexit_214_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_46
        phi_stmt_50_216: Block -- branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_50 
          signal phi_stmt_50_216_start: Boolean;
          signal Xentry_217_symbol: Boolean;
          signal Xexit_218_symbol: Boolean;
          signal phi_stmt_50_req_219_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_50_216_start <= Xentry_210_symbol; -- control passed to block
          Xentry_217_symbol  <= phi_stmt_50_216_start; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_50/$entry
          phi_stmt_50_req_219_symbol <= Xentry_217_symbol; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_50/phi_stmt_50_req
          phi_stmt_50_req_0 <= phi_stmt_50_req_219_symbol; -- link to DP
          Xexit_218_symbol <= phi_stmt_50_req_219_symbol; -- transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_50/$exit
          phi_stmt_50_216_symbol <= Xexit_218_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/merge_stmt_45__entry___PhiReq/phi_stmt_50
        Xexit_211_block : Block -- non-trivial join transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/$exit 
          signal Xexit_211_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_211_predecessors(0) <= phi_stmt_46_212_symbol;
          Xexit_211_predecessors(1) <= phi_stmt_50_216_symbol;
          Xexit_211_join: join -- 
            port map( -- 
              preds => Xexit_211_predecessors,
              symbol_out => Xexit_211_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_44/merge_stmt_45__entry___PhiReq/$exit
        merge_stmt_45_x_xentry_x_xx_xPhiReq_209_symbol <= Xexit_211_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/merge_stmt_45__entry___PhiReq
      loopback_PhiReq_220: Block -- branch_block_stmt_44/loopback_PhiReq 
        signal loopback_PhiReq_220_start: Boolean;
        signal Xentry_221_symbol: Boolean;
        signal Xexit_222_symbol: Boolean;
        signal phi_stmt_46_223_symbol : Boolean;
        signal phi_stmt_50_227_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_220_start <= loopback_199_symbol; -- control passed to block
        Xentry_221_symbol  <= loopback_PhiReq_220_start; -- transition branch_block_stmt_44/loopback_PhiReq/$entry
        phi_stmt_46_223: Block -- branch_block_stmt_44/loopback_PhiReq/phi_stmt_46 
          signal phi_stmt_46_223_start: Boolean;
          signal Xentry_224_symbol: Boolean;
          signal Xexit_225_symbol: Boolean;
          signal phi_stmt_46_req_226_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_46_223_start <= Xentry_221_symbol; -- control passed to block
          Xentry_224_symbol  <= phi_stmt_46_223_start; -- transition branch_block_stmt_44/loopback_PhiReq/phi_stmt_46/$entry
          phi_stmt_46_req_226_symbol <= Xentry_224_symbol; -- transition branch_block_stmt_44/loopback_PhiReq/phi_stmt_46/phi_stmt_46_req
          phi_stmt_46_req_1 <= phi_stmt_46_req_226_symbol; -- link to DP
          Xexit_225_symbol <= phi_stmt_46_req_226_symbol; -- transition branch_block_stmt_44/loopback_PhiReq/phi_stmt_46/$exit
          phi_stmt_46_223_symbol <= Xexit_225_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/loopback_PhiReq/phi_stmt_46
        phi_stmt_50_227: Block -- branch_block_stmt_44/loopback_PhiReq/phi_stmt_50 
          signal phi_stmt_50_227_start: Boolean;
          signal Xentry_228_symbol: Boolean;
          signal Xexit_229_symbol: Boolean;
          signal phi_stmt_50_req_230_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_50_227_start <= Xentry_221_symbol; -- control passed to block
          Xentry_228_symbol  <= phi_stmt_50_227_start; -- transition branch_block_stmt_44/loopback_PhiReq/phi_stmt_50/$entry
          phi_stmt_50_req_230_symbol <= Xentry_228_symbol; -- transition branch_block_stmt_44/loopback_PhiReq/phi_stmt_50/phi_stmt_50_req
          phi_stmt_50_req_1 <= phi_stmt_50_req_230_symbol; -- link to DP
          Xexit_229_symbol <= phi_stmt_50_req_230_symbol; -- transition branch_block_stmt_44/loopback_PhiReq/phi_stmt_50/$exit
          phi_stmt_50_227_symbol <= Xexit_229_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_44/loopback_PhiReq/phi_stmt_50
        Xexit_222_block : Block -- non-trivial join transition branch_block_stmt_44/loopback_PhiReq/$exit 
          signal Xexit_222_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_222_predecessors(0) <= phi_stmt_46_223_symbol;
          Xexit_222_predecessors(1) <= phi_stmt_50_227_symbol;
          Xexit_222_join: join -- 
            port map( -- 
              preds => Xexit_222_predecessors,
              symbol_out => Xexit_222_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_44/loopback_PhiReq/$exit
        loopback_PhiReq_220_symbol <= Xexit_222_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/loopback_PhiReq
      merge_stmt_45_PhiReqMerge_231_symbol  <=  merge_stmt_45_x_xentry_x_xx_xPhiReq_209_symbol or loopback_PhiReq_220_symbol; -- place branch_block_stmt_44/merge_stmt_45_PhiReqMerge (optimized away) 
      merge_stmt_45_PhiAck_232: Block -- branch_block_stmt_44/merge_stmt_45_PhiAck 
        signal merge_stmt_45_PhiAck_232_start: Boolean;
        signal Xentry_233_symbol: Boolean;
        signal Xexit_234_symbol: Boolean;
        signal phi_stmt_46_ack_235_symbol : Boolean;
        signal phi_stmt_50_ack_236_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_45_PhiAck_232_start <= merge_stmt_45_PhiReqMerge_231_symbol; -- control passed to block
        Xentry_233_symbol  <= merge_stmt_45_PhiAck_232_start; -- transition branch_block_stmt_44/merge_stmt_45_PhiAck/$entry
        phi_stmt_46_ack_235_symbol <= phi_stmt_46_ack_0; -- transition branch_block_stmt_44/merge_stmt_45_PhiAck/phi_stmt_46_ack
        phi_stmt_50_ack_236_symbol <= phi_stmt_50_ack_0; -- transition branch_block_stmt_44/merge_stmt_45_PhiAck/phi_stmt_50_ack
        Xexit_234_block : Block -- non-trivial join transition branch_block_stmt_44/merge_stmt_45_PhiAck/$exit 
          signal Xexit_234_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_234_predecessors(0) <= phi_stmt_46_ack_235_symbol;
          Xexit_234_predecessors(1) <= phi_stmt_50_ack_236_symbol;
          Xexit_234_join: join -- 
            port map( -- 
              preds => Xexit_234_predecessors,
              symbol_out => Xexit_234_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_44/merge_stmt_45_PhiAck/$exit
        merge_stmt_45_PhiAck_232_symbol <= Xexit_234_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_44/merge_stmt_45_PhiAck
      Xexit_135_symbol <= branch_block_stmt_44_x_xexit_x_xx_x137_symbol; -- transition branch_block_stmt_44/$exit
      branch_block_stmt_44_133_symbol <= Xexit_135_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_44
    assign_stmt_76_237: Block -- assign_stmt_76 
      signal assign_stmt_76_237_start: Boolean;
      signal Xentry_238_symbol: Boolean;
      signal Xexit_239_symbol: Boolean;
      signal req_240_symbol : Boolean;
      signal ack_241_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_76_237_start <= branch_block_stmt_44_133_symbol; -- control passed to block
      Xentry_238_symbol  <= assign_stmt_76_237_start; -- transition assign_stmt_76/$entry
      req_240_symbol <= Xentry_238_symbol; -- transition assign_stmt_76/req
      simple_obj_ref_74_inst_req_0 <= req_240_symbol; -- link to DP
      ack_241_symbol <= simple_obj_ref_74_inst_ack_0; -- transition assign_stmt_76/ack
      Xexit_239_symbol <= ack_241_symbol; -- transition assign_stmt_76/$exit
      assign_stmt_76_237_symbol <= Xexit_239_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_76
    assign_stmt_81_242: Block -- assign_stmt_81 
      signal assign_stmt_81_242_start: Boolean;
      signal Xentry_243_symbol: Boolean;
      signal Xexit_244_symbol: Boolean;
      signal binary_80_245_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_81_242_start <= assign_stmt_76_237_symbol; -- control passed to block
      Xentry_243_symbol  <= assign_stmt_81_242_start; -- transition assign_stmt_81/$entry
      binary_80_245: Block -- assign_stmt_81/binary_80 
        signal binary_80_245_start: Boolean;
        signal Xentry_246_symbol: Boolean;
        signal Xexit_247_symbol: Boolean;
        signal binary_80_inputs_248_symbol : Boolean;
        signal rr_251_symbol : Boolean;
        signal ra_252_symbol : Boolean;
        signal cr_253_symbol : Boolean;
        signal ca_254_symbol : Boolean;
        -- 
      begin -- 
        binary_80_245_start <= Xentry_243_symbol; -- control passed to block
        Xentry_246_symbol  <= binary_80_245_start; -- transition assign_stmt_81/binary_80/$entry
        binary_80_inputs_248: Block -- assign_stmt_81/binary_80/binary_80_inputs 
          signal binary_80_inputs_248_start: Boolean;
          signal Xentry_249_symbol: Boolean;
          signal Xexit_250_symbol: Boolean;
          -- 
        begin -- 
          binary_80_inputs_248_start <= Xentry_246_symbol; -- control passed to block
          Xentry_249_symbol  <= binary_80_inputs_248_start; -- transition assign_stmt_81/binary_80/binary_80_inputs/$entry
          Xexit_250_symbol <= Xentry_249_symbol; -- transition assign_stmt_81/binary_80/binary_80_inputs/$exit
          binary_80_inputs_248_symbol <= Xexit_250_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_81/binary_80/binary_80_inputs
        rr_251_symbol <= binary_80_inputs_248_symbol; -- transition assign_stmt_81/binary_80/rr
        binary_80_inst_req_0 <= rr_251_symbol; -- link to DP
        ra_252_symbol <= binary_80_inst_ack_0; -- transition assign_stmt_81/binary_80/ra
        cr_253_symbol <= ra_252_symbol; -- transition assign_stmt_81/binary_80/cr
        binary_80_inst_req_1 <= cr_253_symbol; -- link to DP
        ca_254_symbol <= binary_80_inst_ack_1; -- transition assign_stmt_81/binary_80/ca
        Xexit_247_symbol <= ca_254_symbol; -- transition assign_stmt_81/binary_80/$exit
        binary_80_245_symbol <= Xexit_247_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_81/binary_80
      Xexit_244_symbol <= binary_80_245_symbol; -- transition assign_stmt_81/$exit
      assign_stmt_81_242_symbol <= Xexit_244_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_81
    Xexit_2_symbol <= assign_stmt_81_242_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal a_8 : std_logic_vector(9 downto 0);
    signal binary_68_wire : std_logic_vector(0 downto 0);
    signal expr_17_wire_constant : std_logic_vector(9 downto 0);
    signal expr_22_wire_constant : std_logic_vector(9 downto 0);
    signal expr_27_wire_constant : std_logic_vector(9 downto 0);
    signal expr_32_wire_constant : std_logic_vector(9 downto 0);
    signal expr_32_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_35_wire_constant : std_logic_vector(9 downto 0);
    signal expr_35_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_38_wire_constant : std_logic_vector(9 downto 0);
    signal expr_38_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_52_wire_constant : std_logic_vector(9 downto 0);
    signal expr_57_wire_constant : std_logic_vector(9 downto 0);
    signal expr_62_wire_constant : std_logic_vector(9 downto 0);
    signal expr_67_wire_constant : std_logic_vector(9 downto 0);
    signal loop_counter_11 : std_logic_vector(9 downto 0);
    signal loop_counter_46 : std_logic_vector(9 downto 0);
    signal new_loop_counter_24 : std_logic_vector(9 downto 0);
    signal new_loop_counter_59 : std_logic_vector(9 downto 0);
    signal t_29 : std_logic_vector(9 downto 0);
    signal t_64 : std_logic_vector(9 downto 0);
    signal temp_t_15 : std_logic_vector(9 downto 0);
    signal temp_t_50 : std_logic_vector(9 downto 0);
    -- 
  begin -- 
    a_8 <= "0000000011";
    expr_17_wire_constant <= "0000000000";
    expr_22_wire_constant <= "0000000001";
    expr_27_wire_constant <= "0000000001";
    expr_32_wire_constant <= "0000000001";
    expr_35_wire_constant <= "0000000010";
    expr_38_wire_constant <= "0000000011";
    expr_52_wire_constant <= "0000000000";
    expr_57_wire_constant <= "0000000001";
    expr_62_wire_constant <= "0000000001";
    expr_67_wire_constant <= "0000000000";
    phi_stmt_11: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a_8 & new_loop_counter_24;
      req <= phi_stmt_11_req_0 & phi_stmt_11_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_11_ack_0,
          idata => idata,
          odata => loop_counter_11,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_11
    phi_stmt_15: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_17_wire_constant & t_29;
      req <= phi_stmt_15_req_0 & phi_stmt_15_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_15_ack_0,
          idata => idata,
          odata => temp_t_15,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_15
    phi_stmt_46: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a_8 & new_loop_counter_59;
      req <= phi_stmt_46_req_0 & phi_stmt_46_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_46_ack_0,
          idata => idata,
          odata => loop_counter_46,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_46
    phi_stmt_50: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_52_wire_constant & t_64;
      req <= phi_stmt_50_req_0 & phi_stmt_50_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_50_ack_0,
          idata => idata,
          odata => temp_t_50,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_50
    simple_obj_ref_74_inst: RegisterBase generic map(in_data_width => 10,out_data_width => 10) -- 
      port map( din => t_29, dout => b, req => simple_obj_ref_74_inst_req_0, ack => simple_obj_ref_74_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_65_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= binary_68_wire;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_65_branch_req_0,
          ack0 => if_stmt_65_branch_ack_0,
          ack1 => if_stmt_65_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_30_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_32_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_30_branch_0_req_0,
          ack0 => open,
          ack1 => switch_stmt_30_branch_0_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_30_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_35_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_30_branch_1_req_0,
          ack0 => open,
          ack1 => switch_stmt_30_branch_1_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_30_branch_2: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_38_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_30_branch_2_req_0,
          ack0 => open,
          ack1 => switch_stmt_30_branch_2_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_30_branch_default: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(2 downto 0);
      begin 
      condition_sig <= expr_32_wire_constant_cmp & expr_35_wire_constant_cmp & expr_38_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 3)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_30_branch_default_req_0,
          ack0 => switch_stmt_30_branch_default_ack_0,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_23_inst binary_58_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(19 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= loop_counter_11 & loop_counter_46;
      new_loop_counter_24 <= data_out(19 downto 10);
      new_loop_counter_59 <= data_out(9 downto 0);
      reqL(1) <= binary_23_inst_req_0;
      reqL(0) <= binary_58_inst_req_0;
      binary_23_inst_ack_0 <= ackL(1);
      binary_58_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_23_inst_req_1;
      reqR(0) <= binary_58_inst_req_1;
      binary_23_inst_ack_1 <= ackR(1);
      binary_58_inst_ack_1 <= ackR(0);
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
    -- shared split operator group (1) : binary_28_inst binary_63_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(19 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      data_in <= temp_t_15 & temp_t_50;
      t_29 <= data_out(19 downto 10);
      t_64 <= data_out(9 downto 0);
      reqL(1) <= binary_28_inst_req_0;
      reqL(0) <= binary_63_inst_req_0;
      binary_28_inst_ack_0 <= ackL(1);
      binary_63_inst_ack_0 <= ackL(0);
      reqR(1) <= binary_28_inst_req_1;
      reqR(0) <= binary_63_inst_req_1;
      binary_28_inst_ack_1 <= ackR(1);
      binary_63_inst_ack_1 <= ackR(0);
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
    -- shared split operator group (2) : binary_68_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_59;
      binary_68_wire <= data_out(0 downto 0);
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
          reqL => binary_68_inst_req_0,
          ackL => binary_68_inst_ack_0,
          reqR => binary_68_inst_req_1,
          ackR => binary_68_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_80_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= t_29 & t_64;
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
          reqL => binary_80_inst_req_0,
          ackL => binary_80_inst_ack_0,
          reqR => binary_80_inst_req_1,
          ackR => binary_80_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : switch_stmt_30_select_expr_0 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_24;
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
          constant_operand => "0000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_30_select_expr_0_req_0,
          ackL => switch_stmt_30_select_expr_0_ack_0,
          reqR => switch_stmt_30_select_expr_0_req_1,
          ackR => switch_stmt_30_select_expr_0_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : switch_stmt_30_select_expr_1 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_24;
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
          constant_operand => "0000000010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_30_select_expr_1_req_0,
          ackL => switch_stmt_30_select_expr_1_ack_0,
          reqR => switch_stmt_30_select_expr_1_req_1,
          ackR => switch_stmt_30_select_expr_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : switch_stmt_30_select_expr_2 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= new_loop_counter_24;
      expr_38_wire_constant_cmp <= data_out(0 downto 0);
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
          reqL => switch_stmt_30_select_expr_2_req_0,
          ackL => switch_stmt_30_select_expr_2_ack_0,
          reqR => switch_stmt_30_select_expr_2_req_1,
          ackR => switch_stmt_30_select_expr_2_ack_1,
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
