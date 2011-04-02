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
  signal binary_20_inst_req_0 : boolean;
  signal switch_stmt_27_branch_default_req_0 : boolean;
  signal switch_stmt_27_select_expr_0_req_0 : boolean;
  signal switch_stmt_27_select_expr_0_ack_0 : boolean;
  signal switch_stmt_27_select_expr_0_req_1 : boolean;
  signal switch_stmt_27_select_expr_0_ack_1 : boolean;
  signal switch_stmt_27_branch_0_req_0 : boolean;
  signal binary_20_inst_ack_0 : boolean;
  signal binary_20_inst_req_1 : boolean;
  signal binary_20_inst_ack_1 : boolean;
  signal switch_stmt_27_branch_1_req_0 : boolean;
  signal binary_25_inst_req_0 : boolean;
  signal binary_25_inst_ack_0 : boolean;
  signal binary_25_inst_req_1 : boolean;
  signal binary_25_inst_ack_1 : boolean;
  signal phi_stmt_8_req_0 : boolean;
  signal phi_stmt_12_req_0 : boolean;
  signal phi_stmt_8_req_1 : boolean;
  signal phi_stmt_12_req_1 : boolean;
  signal phi_stmt_8_ack_0 : boolean;
  signal switch_stmt_27_select_expr_1_req_0 : boolean;
  signal switch_stmt_27_select_expr_1_ack_0 : boolean;
  signal switch_stmt_27_select_expr_1_req_1 : boolean;
  signal switch_stmt_27_select_expr_1_ack_1 : boolean;
  signal phi_stmt_12_ack_0 : boolean;
  signal switch_stmt_27_select_expr_2_req_0 : boolean;
  signal switch_stmt_27_select_expr_2_ack_0 : boolean;
  signal switch_stmt_27_select_expr_2_req_1 : boolean;
  signal switch_stmt_27_select_expr_2_ack_1 : boolean;
  signal switch_stmt_27_branch_2_req_0 : boolean;
  signal switch_stmt_27_branch_0_ack_1 : boolean;
  signal switch_stmt_27_branch_1_ack_1 : boolean;
  signal switch_stmt_27_branch_2_ack_1 : boolean;
  signal switch_stmt_27_branch_default_ack_0 : boolean;
  signal binary_77_inst_req_1 : boolean;
  signal binary_77_inst_ack_1 : boolean;
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
    signal branch_block_stmt_41_129_symbol : Boolean;
    signal assign_stmt_73_233_symbol : Boolean;
    signal assign_stmt_78_238_symbol : Boolean;
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
      signal assign_stmt_21_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_21_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_26_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_26_x_xexit_x_xx_x13_symbol : Boolean;
      signal switch_stmt_27_x_xentry_x_xx_x14_symbol : Boolean;
      signal switch_stmt_27_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_21_16_symbol : Boolean;
      signal assign_stmt_26_29_symbol : Boolean;
      signal switch_stmt_27_dead_link_42_symbol : Boolean;
      signal switch_stmt_27_x_xcondition_check_place_x_xx_x46_symbol : Boolean;
      signal switch_stmt_27_x_xcondition_check_x_xx_x47_symbol : Boolean;
      signal switch_stmt_27_x_xselect_x_xx_x74_symbol : Boolean;
      signal switch_stmt_27_choice_0_75_symbol : Boolean;
      signal loopback_79_symbol : Boolean;
      signal switch_stmt_27_choice_1_80_symbol : Boolean;
      signal switch_stmt_27_choice_2_84_symbol : Boolean;
      signal switch_stmt_27_choice_default_88_symbol : Boolean;
      signal stmt_38_x_xentry_x_xx_x92_symbol : Boolean;
      signal stmt_38_x_xexit_x_xx_x93_symbol : Boolean;
      signal stmt_38_94_symbol : Boolean;
      signal merge_stmt_7_dead_link_97_symbol : Boolean;
      signal merge_stmt_7_x_xentry_x_xx_xPhiReq_101_symbol : Boolean;
      signal loopback_PhiReq_112_symbol : Boolean;
      signal merge_stmt_7_PhiReqMerge_123_symbol : Boolean;
      signal merge_stmt_7_PhiAck_124_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_6_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_6_3_start; -- transition branch_block_stmt_6/$entry
      branch_block_stmt_6_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_6/branch_block_stmt_6__entry__ (optimized away) 
      branch_block_stmt_6_x_xexit_x_xx_x7_symbol  <=  switch_stmt_27_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_6/branch_block_stmt_6__exit__ (optimized away) 
      merge_stmt_7_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_6_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_6/merge_stmt_7__entry__ (optimized away) 
      merge_stmt_7_x_xexit_x_xx_x9_symbol  <=  merge_stmt_7_dead_link_97_symbol or merge_stmt_7_PhiAck_124_symbol; -- place branch_block_stmt_6/merge_stmt_7__exit__ (optimized away) 
      assign_stmt_21_x_xentry_x_xx_x10_symbol  <=  merge_stmt_7_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_6/assign_stmt_21__entry__ (optimized away) 
      assign_stmt_21_x_xexit_x_xx_x11_symbol  <=  assign_stmt_21_16_symbol; -- place branch_block_stmt_6/assign_stmt_21__exit__ (optimized away) 
      assign_stmt_26_x_xentry_x_xx_x12_symbol  <=  assign_stmt_21_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_6/assign_stmt_26__entry__ (optimized away) 
      assign_stmt_26_x_xexit_x_xx_x13_symbol  <=  assign_stmt_26_29_symbol; -- place branch_block_stmt_6/assign_stmt_26__exit__ (optimized away) 
      switch_stmt_27_x_xentry_x_xx_x14_symbol  <=  assign_stmt_26_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_6/switch_stmt_27__entry__ (optimized away) 
      switch_stmt_27_x_xexit_x_xx_x15_symbol  <=  stmt_38_x_xexit_x_xx_x93_symbol or switch_stmt_27_dead_link_42_symbol; -- place branch_block_stmt_6/switch_stmt_27__exit__ (optimized away) 
      assign_stmt_21_16: Block -- branch_block_stmt_6/assign_stmt_21 
        signal assign_stmt_21_16_start: Boolean;
        signal Xentry_17_symbol: Boolean;
        signal Xexit_18_symbol: Boolean;
        signal binary_20_19_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_21_16_start <= assign_stmt_21_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_17_symbol  <= assign_stmt_21_16_start; -- transition branch_block_stmt_6/assign_stmt_21/$entry
        binary_20_19: Block -- branch_block_stmt_6/assign_stmt_21/binary_20 
          signal binary_20_19_start: Boolean;
          signal Xentry_20_symbol: Boolean;
          signal Xexit_21_symbol: Boolean;
          signal binary_20_inputs_22_symbol : Boolean;
          signal rr_25_symbol : Boolean;
          signal ra_26_symbol : Boolean;
          signal cr_27_symbol : Boolean;
          signal ca_28_symbol : Boolean;
          -- 
        begin -- 
          binary_20_19_start <= Xentry_17_symbol; -- control passed to block
          Xentry_20_symbol  <= binary_20_19_start; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/$entry
          binary_20_inputs_22: Block -- branch_block_stmt_6/assign_stmt_21/binary_20/binary_20_inputs 
            signal binary_20_inputs_22_start: Boolean;
            signal Xentry_23_symbol: Boolean;
            signal Xexit_24_symbol: Boolean;
            -- 
          begin -- 
            binary_20_inputs_22_start <= Xentry_20_symbol; -- control passed to block
            Xentry_23_symbol  <= binary_20_inputs_22_start; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/binary_20_inputs/$entry
            Xexit_24_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/binary_20_inputs/$exit
            binary_20_inputs_22_symbol <= Xexit_24_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_6/assign_stmt_21/binary_20/binary_20_inputs
          rr_25_symbol <= binary_20_inputs_22_symbol; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/rr
          binary_20_inst_req_0 <= rr_25_symbol; -- link to DP
          ra_26_symbol <= binary_20_inst_ack_0; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/ra
          cr_27_symbol <= ra_26_symbol; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/cr
          binary_20_inst_req_1 <= cr_27_symbol; -- link to DP
          ca_28_symbol <= binary_20_inst_ack_1; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/ca
          Xexit_21_symbol <= ca_28_symbol; -- transition branch_block_stmt_6/assign_stmt_21/binary_20/$exit
          binary_20_19_symbol <= Xexit_21_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/assign_stmt_21/binary_20
        Xexit_18_symbol <= binary_20_19_symbol; -- transition branch_block_stmt_6/assign_stmt_21/$exit
        assign_stmt_21_16_symbol <= Xexit_18_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/assign_stmt_21
      assign_stmt_26_29: Block -- branch_block_stmt_6/assign_stmt_26 
        signal assign_stmt_26_29_start: Boolean;
        signal Xentry_30_symbol: Boolean;
        signal Xexit_31_symbol: Boolean;
        signal binary_25_32_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_26_29_start <= assign_stmt_26_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_30_symbol  <= assign_stmt_26_29_start; -- transition branch_block_stmt_6/assign_stmt_26/$entry
        binary_25_32: Block -- branch_block_stmt_6/assign_stmt_26/binary_25 
          signal binary_25_32_start: Boolean;
          signal Xentry_33_symbol: Boolean;
          signal Xexit_34_symbol: Boolean;
          signal binary_25_inputs_35_symbol : Boolean;
          signal rr_38_symbol : Boolean;
          signal ra_39_symbol : Boolean;
          signal cr_40_symbol : Boolean;
          signal ca_41_symbol : Boolean;
          -- 
        begin -- 
          binary_25_32_start <= Xentry_30_symbol; -- control passed to block
          Xentry_33_symbol  <= binary_25_32_start; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/$entry
          binary_25_inputs_35: Block -- branch_block_stmt_6/assign_stmt_26/binary_25/binary_25_inputs 
            signal binary_25_inputs_35_start: Boolean;
            signal Xentry_36_symbol: Boolean;
            signal Xexit_37_symbol: Boolean;
            -- 
          begin -- 
            binary_25_inputs_35_start <= Xentry_33_symbol; -- control passed to block
            Xentry_36_symbol  <= binary_25_inputs_35_start; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/binary_25_inputs/$entry
            Xexit_37_symbol <= Xentry_36_symbol; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/binary_25_inputs/$exit
            binary_25_inputs_35_symbol <= Xexit_37_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_6/assign_stmt_26/binary_25/binary_25_inputs
          rr_38_symbol <= binary_25_inputs_35_symbol; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/rr
          binary_25_inst_req_0 <= rr_38_symbol; -- link to DP
          ra_39_symbol <= binary_25_inst_ack_0; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/ra
          cr_40_symbol <= ra_39_symbol; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/cr
          binary_25_inst_req_1 <= cr_40_symbol; -- link to DP
          ca_41_symbol <= binary_25_inst_ack_1; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/ca
          Xexit_34_symbol <= ca_41_symbol; -- transition branch_block_stmt_6/assign_stmt_26/binary_25/$exit
          binary_25_32_symbol <= Xexit_34_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/assign_stmt_26/binary_25
        Xexit_31_symbol <= binary_25_32_symbol; -- transition branch_block_stmt_6/assign_stmt_26/$exit
        assign_stmt_26_29_symbol <= Xexit_31_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/assign_stmt_26
      switch_stmt_27_dead_link_42: Block -- branch_block_stmt_6/switch_stmt_27_dead_link 
        signal switch_stmt_27_dead_link_42_start: Boolean;
        signal Xentry_43_symbol: Boolean;
        signal Xexit_44_symbol: Boolean;
        signal dead_transition_45_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_dead_link_42_start <= switch_stmt_27_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_43_symbol  <= switch_stmt_27_dead_link_42_start; -- transition branch_block_stmt_6/switch_stmt_27_dead_link/$entry
        dead_transition_45_symbol <= false;
        Xexit_44_symbol <= dead_transition_45_symbol; -- transition branch_block_stmt_6/switch_stmt_27_dead_link/$exit
        switch_stmt_27_dead_link_42_symbol <= Xexit_44_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_dead_link
      switch_stmt_27_x_xcondition_check_place_x_xx_x46_symbol  <=  switch_stmt_27_x_xentry_x_xx_x14_symbol; -- place branch_block_stmt_6/switch_stmt_27__condition_check_place__ (optimized away) 
      switch_stmt_27_x_xcondition_check_x_xx_x47: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__ 
        signal switch_stmt_27_x_xcondition_check_x_xx_x47_start: Boolean;
        signal Xentry_48_symbol: Boolean;
        signal Xexit_49_symbol: Boolean;
        signal condition_0_50_symbol : Boolean;
        signal condition_1_58_symbol : Boolean;
        signal condition_2_66_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_x_xcondition_check_x_xx_x47_start <= switch_stmt_27_x_xcondition_check_place_x_xx_x46_symbol; -- control passed to block
        Xentry_48_symbol  <= switch_stmt_27_x_xcondition_check_x_xx_x47_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/$entry
        condition_0_50: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0 
          signal condition_0_50_start: Boolean;
          signal Xentry_51_symbol: Boolean;
          signal Xexit_52_symbol: Boolean;
          signal rr_53_symbol : Boolean;
          signal ra_54_symbol : Boolean;
          signal cr_55_symbol : Boolean;
          signal ca_56_symbol : Boolean;
          signal cmp_57_symbol : Boolean;
          -- 
        begin -- 
          condition_0_50_start <= Xentry_48_symbol; -- control passed to block
          Xentry_51_symbol  <= condition_0_50_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/$entry
          rr_53_symbol <= Xentry_51_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/rr
          switch_stmt_27_select_expr_0_req_0 <= rr_53_symbol; -- link to DP
          ra_54_symbol <= switch_stmt_27_select_expr_0_ack_0; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/ra
          cr_55_symbol <= ra_54_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/cr
          switch_stmt_27_select_expr_0_req_1 <= cr_55_symbol; -- link to DP
          ca_56_symbol <= switch_stmt_27_select_expr_0_ack_1; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/ca
          cmp_57_symbol <= ca_56_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/cmp
          switch_stmt_27_branch_0_req_0 <= cmp_57_symbol; -- link to DP
          Xexit_52_symbol <= cmp_57_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0/$exit
          condition_0_50_symbol <= Xexit_52_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_0
        condition_1_58: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1 
          signal condition_1_58_start: Boolean;
          signal Xentry_59_symbol: Boolean;
          signal Xexit_60_symbol: Boolean;
          signal rr_61_symbol : Boolean;
          signal ra_62_symbol : Boolean;
          signal cr_63_symbol : Boolean;
          signal ca_64_symbol : Boolean;
          signal cmp_65_symbol : Boolean;
          -- 
        begin -- 
          condition_1_58_start <= Xentry_48_symbol; -- control passed to block
          Xentry_59_symbol  <= condition_1_58_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/$entry
          rr_61_symbol <= Xentry_59_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/rr
          switch_stmt_27_select_expr_1_req_0 <= rr_61_symbol; -- link to DP
          ra_62_symbol <= switch_stmt_27_select_expr_1_ack_0; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/ra
          cr_63_symbol <= ra_62_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/cr
          switch_stmt_27_select_expr_1_req_1 <= cr_63_symbol; -- link to DP
          ca_64_symbol <= switch_stmt_27_select_expr_1_ack_1; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/ca
          cmp_65_symbol <= ca_64_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/cmp
          switch_stmt_27_branch_1_req_0 <= cmp_65_symbol; -- link to DP
          Xexit_60_symbol <= cmp_65_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1/$exit
          condition_1_58_symbol <= Xexit_60_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_1
        condition_2_66: Block -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2 
          signal condition_2_66_start: Boolean;
          signal Xentry_67_symbol: Boolean;
          signal Xexit_68_symbol: Boolean;
          signal rr_69_symbol : Boolean;
          signal ra_70_symbol : Boolean;
          signal cr_71_symbol : Boolean;
          signal ca_72_symbol : Boolean;
          signal cmp_73_symbol : Boolean;
          -- 
        begin -- 
          condition_2_66_start <= Xentry_48_symbol; -- control passed to block
          Xentry_67_symbol  <= condition_2_66_start; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/$entry
          rr_69_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/rr
          switch_stmt_27_select_expr_2_req_0 <= rr_69_symbol; -- link to DP
          ra_70_symbol <= switch_stmt_27_select_expr_2_ack_0; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/ra
          cr_71_symbol <= ra_70_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/cr
          switch_stmt_27_select_expr_2_req_1 <= cr_71_symbol; -- link to DP
          ca_72_symbol <= switch_stmt_27_select_expr_2_ack_1; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/ca
          cmp_73_symbol <= ca_72_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/cmp
          switch_stmt_27_branch_2_req_0 <= cmp_73_symbol; -- link to DP
          Xexit_68_symbol <= cmp_73_symbol; -- transition branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2/$exit
          condition_2_66_symbol <= Xexit_68_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__/condition_2
        Xexit_49_block : Block -- non-trivial join transition branch_block_stmt_6/switch_stmt_27__condition_check__/$exit 
          signal Xexit_49_predecessors: BooleanArray(2 downto 0);
          signal Xexit_49_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_49_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_49_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_49_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_49_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_49_p2_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_49_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_49_p0_pred, Xexit_49_p0_succ, Xexit_49_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_49_p0_succ(0) <=  Xexit_49_symbol;
          Xexit_49_p0_pred(0) <=  condition_0_50_symbol;
          Xexit_49_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_49_p1_pred, Xexit_49_p1_succ, Xexit_49_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_49_p1_succ(0) <=  Xexit_49_symbol;
          Xexit_49_p1_pred(0) <=  condition_1_58_symbol;
          Xexit_49_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_49_p2_pred, Xexit_49_p2_succ, Xexit_49_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_49_p2_succ(0) <=  Xexit_49_symbol;
          Xexit_49_p2_pred(0) <=  condition_2_66_symbol;
          Xexit_49_symbol <= AndReduce(Xexit_49_predecessors); 
          switch_stmt_27_branch_default_req_0 <= Xexit_49_symbol; -- link to DP
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/switch_stmt_27__condition_check__/$exit
        switch_stmt_27_x_xcondition_check_x_xx_x47_symbol <= Xexit_49_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27__condition_check__
      switch_stmt_27_x_xselect_x_xx_x74_symbol  <=  switch_stmt_27_x_xcondition_check_x_xx_x47_symbol; -- place branch_block_stmt_6/switch_stmt_27__select__ (optimized away) 
      switch_stmt_27_choice_0_75: Block -- branch_block_stmt_6/switch_stmt_27_choice_0 
        signal switch_stmt_27_choice_0_75_start: Boolean;
        signal Xentry_76_symbol: Boolean;
        signal Xexit_77_symbol: Boolean;
        signal ack1_78_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_0_75_start <= switch_stmt_27_x_xselect_x_xx_x74_symbol; -- control passed to block
        Xentry_76_symbol  <= switch_stmt_27_choice_0_75_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_0/$entry
        ack1_78_symbol <= switch_stmt_27_branch_0_ack_1; -- transition branch_block_stmt_6/switch_stmt_27_choice_0/ack1
        Xexit_77_symbol <= ack1_78_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_0/$exit
        switch_stmt_27_choice_0_75_symbol <= Xexit_77_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_0
      loopback_79_symbol  <=  switch_stmt_27_choice_0_75_symbol or switch_stmt_27_choice_1_80_symbol or switch_stmt_27_choice_2_84_symbol; -- place branch_block_stmt_6/loopback (optimized away) 
      switch_stmt_27_choice_1_80: Block -- branch_block_stmt_6/switch_stmt_27_choice_1 
        signal switch_stmt_27_choice_1_80_start: Boolean;
        signal Xentry_81_symbol: Boolean;
        signal Xexit_82_symbol: Boolean;
        signal ack1_83_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_1_80_start <= switch_stmt_27_x_xselect_x_xx_x74_symbol; -- control passed to block
        Xentry_81_symbol  <= switch_stmt_27_choice_1_80_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_1/$entry
        ack1_83_symbol <= switch_stmt_27_branch_1_ack_1; -- transition branch_block_stmt_6/switch_stmt_27_choice_1/ack1
        Xexit_82_symbol <= ack1_83_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_1/$exit
        switch_stmt_27_choice_1_80_symbol <= Xexit_82_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_1
      switch_stmt_27_choice_2_84: Block -- branch_block_stmt_6/switch_stmt_27_choice_2 
        signal switch_stmt_27_choice_2_84_start: Boolean;
        signal Xentry_85_symbol: Boolean;
        signal Xexit_86_symbol: Boolean;
        signal ack1_87_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_2_84_start <= switch_stmt_27_x_xselect_x_xx_x74_symbol; -- control passed to block
        Xentry_85_symbol  <= switch_stmt_27_choice_2_84_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_2/$entry
        ack1_87_symbol <= switch_stmt_27_branch_2_ack_1; -- transition branch_block_stmt_6/switch_stmt_27_choice_2/ack1
        Xexit_86_symbol <= ack1_87_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_2/$exit
        switch_stmt_27_choice_2_84_symbol <= Xexit_86_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_2
      switch_stmt_27_choice_default_88: Block -- branch_block_stmt_6/switch_stmt_27_choice_default 
        signal switch_stmt_27_choice_default_88_start: Boolean;
        signal Xentry_89_symbol: Boolean;
        signal Xexit_90_symbol: Boolean;
        signal ack0_91_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_27_choice_default_88_start <= switch_stmt_27_x_xselect_x_xx_x74_symbol; -- control passed to block
        Xentry_89_symbol  <= switch_stmt_27_choice_default_88_start; -- transition branch_block_stmt_6/switch_stmt_27_choice_default/$entry
        ack0_91_symbol <= switch_stmt_27_branch_default_ack_0; -- transition branch_block_stmt_6/switch_stmt_27_choice_default/ack0
        Xexit_90_symbol <= ack0_91_symbol; -- transition branch_block_stmt_6/switch_stmt_27_choice_default/$exit
        switch_stmt_27_choice_default_88_symbol <= Xexit_90_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/switch_stmt_27_choice_default
      stmt_38_x_xentry_x_xx_x92_symbol  <=  switch_stmt_27_choice_default_88_symbol; -- place branch_block_stmt_6/stmt_38__entry__ (optimized away) 
      stmt_38_x_xexit_x_xx_x93_symbol  <=  stmt_38_94_symbol; -- place branch_block_stmt_6/stmt_38__exit__ (optimized away) 
      stmt_38_94: Block -- branch_block_stmt_6/stmt_38 
        signal stmt_38_94_start: Boolean;
        signal Xentry_95_symbol: Boolean;
        signal Xexit_96_symbol: Boolean;
        -- 
      begin -- 
        stmt_38_94_start <= stmt_38_x_xentry_x_xx_x92_symbol; -- control passed to block
        Xentry_95_symbol  <= stmt_38_94_start; -- transition branch_block_stmt_6/stmt_38/$entry
        Xexit_96_symbol <= Xentry_95_symbol; -- transition branch_block_stmt_6/stmt_38/$exit
        stmt_38_94_symbol <= Xexit_96_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/stmt_38
      merge_stmt_7_dead_link_97: Block -- branch_block_stmt_6/merge_stmt_7_dead_link 
        signal merge_stmt_7_dead_link_97_start: Boolean;
        signal Xentry_98_symbol: Boolean;
        signal Xexit_99_symbol: Boolean;
        signal dead_transition_100_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_7_dead_link_97_start <= merge_stmt_7_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_98_symbol  <= merge_stmt_7_dead_link_97_start; -- transition branch_block_stmt_6/merge_stmt_7_dead_link/$entry
        dead_transition_100_symbol <= false;
        Xexit_99_symbol <= dead_transition_100_symbol; -- transition branch_block_stmt_6/merge_stmt_7_dead_link/$exit
        merge_stmt_7_dead_link_97_symbol <= Xexit_99_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/merge_stmt_7_dead_link
      merge_stmt_7_x_xentry_x_xx_xPhiReq_101: Block -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq 
        signal merge_stmt_7_x_xentry_x_xx_xPhiReq_101_start: Boolean;
        signal Xentry_102_symbol: Boolean;
        signal Xexit_103_symbol: Boolean;
        signal phi_stmt_8_104_symbol : Boolean;
        signal phi_stmt_12_108_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_7_x_xentry_x_xx_xPhiReq_101_start <= merge_stmt_7_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_102_symbol  <= merge_stmt_7_x_xentry_x_xx_xPhiReq_101_start; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/$entry
        phi_stmt_8_104: Block -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8 
          signal phi_stmt_8_104_start: Boolean;
          signal Xentry_105_symbol: Boolean;
          signal Xexit_106_symbol: Boolean;
          signal phi_stmt_8_req_107_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_8_104_start <= Xentry_102_symbol; -- control passed to block
          Xentry_105_symbol  <= phi_stmt_8_104_start; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8/$entry
          phi_stmt_8_req_107_symbol <= Xentry_105_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8/phi_stmt_8_req
          phi_stmt_8_req_0 <= phi_stmt_8_req_107_symbol; -- link to DP
          Xexit_106_symbol <= phi_stmt_8_req_107_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8/$exit
          phi_stmt_8_104_symbol <= Xexit_106_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_8
        phi_stmt_12_108: Block -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12 
          signal phi_stmt_12_108_start: Boolean;
          signal Xentry_109_symbol: Boolean;
          signal Xexit_110_symbol: Boolean;
          signal phi_stmt_12_req_111_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_12_108_start <= Xentry_102_symbol; -- control passed to block
          Xentry_109_symbol  <= phi_stmt_12_108_start; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12/$entry
          phi_stmt_12_req_111_symbol <= Xentry_109_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12/phi_stmt_12_req
          phi_stmt_12_req_0 <= phi_stmt_12_req_111_symbol; -- link to DP
          Xexit_110_symbol <= phi_stmt_12_req_111_symbol; -- transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12/$exit
          phi_stmt_12_108_symbol <= Xexit_110_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq/phi_stmt_12
        Xexit_103_block : Block -- non-trivial join transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/$exit 
          signal Xexit_103_predecessors: BooleanArray(1 downto 0);
          signal Xexit_103_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_103_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_103_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_103_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_103_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_103_p0_pred, Xexit_103_p0_succ, Xexit_103_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_103_p0_succ(0) <=  Xexit_103_symbol;
          Xexit_103_p0_pred(0) <=  phi_stmt_8_104_symbol;
          Xexit_103_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_103_p1_pred, Xexit_103_p1_succ, Xexit_103_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_103_p1_succ(0) <=  Xexit_103_symbol;
          Xexit_103_p1_pred(0) <=  phi_stmt_12_108_symbol;
          Xexit_103_symbol <= AndReduce(Xexit_103_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/merge_stmt_7__entry___PhiReq/$exit
        merge_stmt_7_x_xentry_x_xx_xPhiReq_101_symbol <= Xexit_103_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/merge_stmt_7__entry___PhiReq
      loopback_PhiReq_112: Block -- branch_block_stmt_6/loopback_PhiReq 
        signal loopback_PhiReq_112_start: Boolean;
        signal Xentry_113_symbol: Boolean;
        signal Xexit_114_symbol: Boolean;
        signal phi_stmt_8_115_symbol : Boolean;
        signal phi_stmt_12_119_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_112_start <= loopback_79_symbol; -- control passed to block
        Xentry_113_symbol  <= loopback_PhiReq_112_start; -- transition branch_block_stmt_6/loopback_PhiReq/$entry
        phi_stmt_8_115: Block -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_8 
          signal phi_stmt_8_115_start: Boolean;
          signal Xentry_116_symbol: Boolean;
          signal Xexit_117_symbol: Boolean;
          signal phi_stmt_8_req_118_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_8_115_start <= Xentry_113_symbol; -- control passed to block
          Xentry_116_symbol  <= phi_stmt_8_115_start; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_8/$entry
          phi_stmt_8_req_118_symbol <= Xentry_116_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_8/phi_stmt_8_req
          phi_stmt_8_req_1 <= phi_stmt_8_req_118_symbol; -- link to DP
          Xexit_117_symbol <= phi_stmt_8_req_118_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_8/$exit
          phi_stmt_8_115_symbol <= Xexit_117_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_8
        phi_stmt_12_119: Block -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_12 
          signal phi_stmt_12_119_start: Boolean;
          signal Xentry_120_symbol: Boolean;
          signal Xexit_121_symbol: Boolean;
          signal phi_stmt_12_req_122_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_12_119_start <= Xentry_113_symbol; -- control passed to block
          Xentry_120_symbol  <= phi_stmt_12_119_start; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_12/$entry
          phi_stmt_12_req_122_symbol <= Xentry_120_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_12/phi_stmt_12_req
          phi_stmt_12_req_1 <= phi_stmt_12_req_122_symbol; -- link to DP
          Xexit_121_symbol <= phi_stmt_12_req_122_symbol; -- transition branch_block_stmt_6/loopback_PhiReq/phi_stmt_12/$exit
          phi_stmt_12_119_symbol <= Xexit_121_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_6/loopback_PhiReq/phi_stmt_12
        Xexit_114_block : Block -- non-trivial join transition branch_block_stmt_6/loopback_PhiReq/$exit 
          signal Xexit_114_predecessors: BooleanArray(1 downto 0);
          signal Xexit_114_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_114_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_114_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_114_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_114_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_114_p0_pred, Xexit_114_p0_succ, Xexit_114_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_114_p0_succ(0) <=  Xexit_114_symbol;
          Xexit_114_p0_pred(0) <=  phi_stmt_8_115_symbol;
          Xexit_114_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_114_p1_pred, Xexit_114_p1_succ, Xexit_114_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_114_p1_succ(0) <=  Xexit_114_symbol;
          Xexit_114_p1_pred(0) <=  phi_stmt_12_119_symbol;
          Xexit_114_symbol <= AndReduce(Xexit_114_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/loopback_PhiReq/$exit
        loopback_PhiReq_112_symbol <= Xexit_114_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/loopback_PhiReq
      merge_stmt_7_PhiReqMerge_123_symbol  <=  merge_stmt_7_x_xentry_x_xx_xPhiReq_101_symbol or loopback_PhiReq_112_symbol; -- place branch_block_stmt_6/merge_stmt_7_PhiReqMerge (optimized away) 
      merge_stmt_7_PhiAck_124: Block -- branch_block_stmt_6/merge_stmt_7_PhiAck 
        signal merge_stmt_7_PhiAck_124_start: Boolean;
        signal Xentry_125_symbol: Boolean;
        signal Xexit_126_symbol: Boolean;
        signal phi_stmt_8_ack_127_symbol : Boolean;
        signal phi_stmt_12_ack_128_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_7_PhiAck_124_start <= merge_stmt_7_PhiReqMerge_123_symbol; -- control passed to block
        Xentry_125_symbol  <= merge_stmt_7_PhiAck_124_start; -- transition branch_block_stmt_6/merge_stmt_7_PhiAck/$entry
        phi_stmt_8_ack_127_symbol <= phi_stmt_8_ack_0; -- transition branch_block_stmt_6/merge_stmt_7_PhiAck/phi_stmt_8_ack
        phi_stmt_12_ack_128_symbol <= phi_stmt_12_ack_0; -- transition branch_block_stmt_6/merge_stmt_7_PhiAck/phi_stmt_12_ack
        Xexit_126_block : Block -- non-trivial join transition branch_block_stmt_6/merge_stmt_7_PhiAck/$exit 
          signal Xexit_126_predecessors: BooleanArray(1 downto 0);
          signal Xexit_126_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_126_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_126_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_126_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_126_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_126_p0_pred, Xexit_126_p0_succ, Xexit_126_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_126_p0_succ(0) <=  Xexit_126_symbol;
          Xexit_126_p0_pred(0) <=  phi_stmt_8_ack_127_symbol;
          Xexit_126_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_126_p1_pred, Xexit_126_p1_succ, Xexit_126_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_126_p1_succ(0) <=  Xexit_126_symbol;
          Xexit_126_p1_pred(0) <=  phi_stmt_12_ack_128_symbol;
          Xexit_126_symbol <= AndReduce(Xexit_126_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_6/merge_stmt_7_PhiAck/$exit
        merge_stmt_7_PhiAck_124_symbol <= Xexit_126_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_6/merge_stmt_7_PhiAck
      Xexit_5_symbol <= branch_block_stmt_6_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_6/$exit
      branch_block_stmt_6_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_6
    branch_block_stmt_41_129: Block -- branch_block_stmt_41 
      signal branch_block_stmt_41_129_start: Boolean;
      signal Xentry_130_symbol: Boolean;
      signal Xexit_131_symbol: Boolean;
      signal branch_block_stmt_41_x_xentry_x_xx_x132_symbol : Boolean;
      signal branch_block_stmt_41_x_xexit_x_xx_x133_symbol : Boolean;
      signal merge_stmt_42_x_xentry_x_xx_x134_symbol : Boolean;
      signal merge_stmt_42_x_xexit_x_xx_x135_symbol : Boolean;
      signal assign_stmt_56_x_xentry_x_xx_x136_symbol : Boolean;
      signal assign_stmt_56_x_xexit_x_xx_x137_symbol : Boolean;
      signal assign_stmt_61_x_xentry_x_xx_x138_symbol : Boolean;
      signal assign_stmt_61_x_xexit_x_xx_x139_symbol : Boolean;
      signal if_stmt_62_x_xentry_x_xx_x140_symbol : Boolean;
      signal if_stmt_62_x_xexit_x_xx_x141_symbol : Boolean;
      signal assign_stmt_56_142_symbol : Boolean;
      signal assign_stmt_61_155_symbol : Boolean;
      signal if_stmt_62_dead_link_168_symbol : Boolean;
      signal if_stmt_62_eval_test_172_symbol : Boolean;
      signal binary_65_place_186_symbol : Boolean;
      signal if_stmt_62_if_link_187_symbol : Boolean;
      signal if_stmt_62_else_link_191_symbol : Boolean;
      signal loopback_195_symbol : Boolean;
      signal stmt_68_x_xentry_x_xx_x196_symbol : Boolean;
      signal stmt_68_x_xexit_x_xx_x197_symbol : Boolean;
      signal stmt_68_198_symbol : Boolean;
      signal merge_stmt_42_dead_link_201_symbol : Boolean;
      signal merge_stmt_42_x_xentry_x_xx_xPhiReq_205_symbol : Boolean;
      signal loopback_PhiReq_216_symbol : Boolean;
      signal merge_stmt_42_PhiReqMerge_227_symbol : Boolean;
      signal merge_stmt_42_PhiAck_228_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_41_129_start <= branch_block_stmt_6_3_symbol; -- control passed to block
      Xentry_130_symbol  <= branch_block_stmt_41_129_start; -- transition branch_block_stmt_41/$entry
      branch_block_stmt_41_x_xentry_x_xx_x132_symbol  <=  Xentry_130_symbol; -- place branch_block_stmt_41/branch_block_stmt_41__entry__ (optimized away) 
      branch_block_stmt_41_x_xexit_x_xx_x133_symbol  <=  if_stmt_62_x_xexit_x_xx_x141_symbol; -- place branch_block_stmt_41/branch_block_stmt_41__exit__ (optimized away) 
      merge_stmt_42_x_xentry_x_xx_x134_symbol  <=  branch_block_stmt_41_x_xentry_x_xx_x132_symbol; -- place branch_block_stmt_41/merge_stmt_42__entry__ (optimized away) 
      merge_stmt_42_x_xexit_x_xx_x135_symbol  <=  merge_stmt_42_dead_link_201_symbol or merge_stmt_42_PhiAck_228_symbol; -- place branch_block_stmt_41/merge_stmt_42__exit__ (optimized away) 
      assign_stmt_56_x_xentry_x_xx_x136_symbol  <=  merge_stmt_42_x_xexit_x_xx_x135_symbol; -- place branch_block_stmt_41/assign_stmt_56__entry__ (optimized away) 
      assign_stmt_56_x_xexit_x_xx_x137_symbol  <=  assign_stmt_56_142_symbol; -- place branch_block_stmt_41/assign_stmt_56__exit__ (optimized away) 
      assign_stmt_61_x_xentry_x_xx_x138_symbol  <=  assign_stmt_56_x_xexit_x_xx_x137_symbol; -- place branch_block_stmt_41/assign_stmt_61__entry__ (optimized away) 
      assign_stmt_61_x_xexit_x_xx_x139_symbol  <=  assign_stmt_61_155_symbol; -- place branch_block_stmt_41/assign_stmt_61__exit__ (optimized away) 
      if_stmt_62_x_xentry_x_xx_x140_symbol  <=  assign_stmt_61_x_xexit_x_xx_x139_symbol; -- place branch_block_stmt_41/if_stmt_62__entry__ (optimized away) 
      if_stmt_62_x_xexit_x_xx_x141_symbol  <=  stmt_68_x_xexit_x_xx_x197_symbol or if_stmt_62_dead_link_168_symbol or if_stmt_62_dead_link_168_symbol; -- place branch_block_stmt_41/if_stmt_62__exit__ (optimized away) 
      assign_stmt_56_142: Block -- branch_block_stmt_41/assign_stmt_56 
        signal assign_stmt_56_142_start: Boolean;
        signal Xentry_143_symbol: Boolean;
        signal Xexit_144_symbol: Boolean;
        signal binary_55_145_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_56_142_start <= assign_stmt_56_x_xentry_x_xx_x136_symbol; -- control passed to block
        Xentry_143_symbol  <= assign_stmt_56_142_start; -- transition branch_block_stmt_41/assign_stmt_56/$entry
        binary_55_145: Block -- branch_block_stmt_41/assign_stmt_56/binary_55 
          signal binary_55_145_start: Boolean;
          signal Xentry_146_symbol: Boolean;
          signal Xexit_147_symbol: Boolean;
          signal binary_55_inputs_148_symbol : Boolean;
          signal rr_151_symbol : Boolean;
          signal ra_152_symbol : Boolean;
          signal cr_153_symbol : Boolean;
          signal ca_154_symbol : Boolean;
          -- 
        begin -- 
          binary_55_145_start <= Xentry_143_symbol; -- control passed to block
          Xentry_146_symbol  <= binary_55_145_start; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/$entry
          binary_55_inputs_148: Block -- branch_block_stmt_41/assign_stmt_56/binary_55/binary_55_inputs 
            signal binary_55_inputs_148_start: Boolean;
            signal Xentry_149_symbol: Boolean;
            signal Xexit_150_symbol: Boolean;
            -- 
          begin -- 
            binary_55_inputs_148_start <= Xentry_146_symbol; -- control passed to block
            Xentry_149_symbol  <= binary_55_inputs_148_start; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/binary_55_inputs/$entry
            Xexit_150_symbol <= Xentry_149_symbol; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/binary_55_inputs/$exit
            binary_55_inputs_148_symbol <= Xexit_150_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_41/assign_stmt_56/binary_55/binary_55_inputs
          rr_151_symbol <= binary_55_inputs_148_symbol; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/rr
          binary_55_inst_req_0 <= rr_151_symbol; -- link to DP
          ra_152_symbol <= binary_55_inst_ack_0; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/ra
          cr_153_symbol <= ra_152_symbol; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/cr
          binary_55_inst_req_1 <= cr_153_symbol; -- link to DP
          ca_154_symbol <= binary_55_inst_ack_1; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/ca
          Xexit_147_symbol <= ca_154_symbol; -- transition branch_block_stmt_41/assign_stmt_56/binary_55/$exit
          binary_55_145_symbol <= Xexit_147_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/assign_stmt_56/binary_55
        Xexit_144_symbol <= binary_55_145_symbol; -- transition branch_block_stmt_41/assign_stmt_56/$exit
        assign_stmt_56_142_symbol <= Xexit_144_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/assign_stmt_56
      assign_stmt_61_155: Block -- branch_block_stmt_41/assign_stmt_61 
        signal assign_stmt_61_155_start: Boolean;
        signal Xentry_156_symbol: Boolean;
        signal Xexit_157_symbol: Boolean;
        signal binary_60_158_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_61_155_start <= assign_stmt_61_x_xentry_x_xx_x138_symbol; -- control passed to block
        Xentry_156_symbol  <= assign_stmt_61_155_start; -- transition branch_block_stmt_41/assign_stmt_61/$entry
        binary_60_158: Block -- branch_block_stmt_41/assign_stmt_61/binary_60 
          signal binary_60_158_start: Boolean;
          signal Xentry_159_symbol: Boolean;
          signal Xexit_160_symbol: Boolean;
          signal binary_60_inputs_161_symbol : Boolean;
          signal rr_164_symbol : Boolean;
          signal ra_165_symbol : Boolean;
          signal cr_166_symbol : Boolean;
          signal ca_167_symbol : Boolean;
          -- 
        begin -- 
          binary_60_158_start <= Xentry_156_symbol; -- control passed to block
          Xentry_159_symbol  <= binary_60_158_start; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/$entry
          binary_60_inputs_161: Block -- branch_block_stmt_41/assign_stmt_61/binary_60/binary_60_inputs 
            signal binary_60_inputs_161_start: Boolean;
            signal Xentry_162_symbol: Boolean;
            signal Xexit_163_symbol: Boolean;
            -- 
          begin -- 
            binary_60_inputs_161_start <= Xentry_159_symbol; -- control passed to block
            Xentry_162_symbol  <= binary_60_inputs_161_start; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/binary_60_inputs/$entry
            Xexit_163_symbol <= Xentry_162_symbol; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/binary_60_inputs/$exit
            binary_60_inputs_161_symbol <= Xexit_163_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_41/assign_stmt_61/binary_60/binary_60_inputs
          rr_164_symbol <= binary_60_inputs_161_symbol; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/rr
          binary_60_inst_req_0 <= rr_164_symbol; -- link to DP
          ra_165_symbol <= binary_60_inst_ack_0; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/ra
          cr_166_symbol <= ra_165_symbol; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/cr
          binary_60_inst_req_1 <= cr_166_symbol; -- link to DP
          ca_167_symbol <= binary_60_inst_ack_1; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/ca
          Xexit_160_symbol <= ca_167_symbol; -- transition branch_block_stmt_41/assign_stmt_61/binary_60/$exit
          binary_60_158_symbol <= Xexit_160_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/assign_stmt_61/binary_60
        Xexit_157_symbol <= binary_60_158_symbol; -- transition branch_block_stmt_41/assign_stmt_61/$exit
        assign_stmt_61_155_symbol <= Xexit_157_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/assign_stmt_61
      if_stmt_62_dead_link_168: Block -- branch_block_stmt_41/if_stmt_62_dead_link 
        signal if_stmt_62_dead_link_168_start: Boolean;
        signal Xentry_169_symbol: Boolean;
        signal Xexit_170_symbol: Boolean;
        signal dead_transition_171_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_dead_link_168_start <= if_stmt_62_x_xentry_x_xx_x140_symbol; -- control passed to block
        Xentry_169_symbol  <= if_stmt_62_dead_link_168_start; -- transition branch_block_stmt_41/if_stmt_62_dead_link/$entry
        dead_transition_171_symbol <= false;
        Xexit_170_symbol <= dead_transition_171_symbol; -- transition branch_block_stmt_41/if_stmt_62_dead_link/$exit
        if_stmt_62_dead_link_168_symbol <= Xexit_170_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_dead_link
      if_stmt_62_eval_test_172: Block -- branch_block_stmt_41/if_stmt_62_eval_test 
        signal if_stmt_62_eval_test_172_start: Boolean;
        signal Xentry_173_symbol: Boolean;
        signal Xexit_174_symbol: Boolean;
        signal binary_65_175_symbol : Boolean;
        signal branch_req_185_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_eval_test_172_start <= if_stmt_62_x_xentry_x_xx_x140_symbol; -- control passed to block
        Xentry_173_symbol  <= if_stmt_62_eval_test_172_start; -- transition branch_block_stmt_41/if_stmt_62_eval_test/$entry
        binary_65_175: Block -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65 
          signal binary_65_175_start: Boolean;
          signal Xentry_176_symbol: Boolean;
          signal Xexit_177_symbol: Boolean;
          signal binary_65_inputs_178_symbol : Boolean;
          signal rr_181_symbol : Boolean;
          signal ra_182_symbol : Boolean;
          signal cr_183_symbol : Boolean;
          signal ca_184_symbol : Boolean;
          -- 
        begin -- 
          binary_65_175_start <= Xentry_173_symbol; -- control passed to block
          Xentry_176_symbol  <= binary_65_175_start; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/$entry
          binary_65_inputs_178: Block -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs 
            signal binary_65_inputs_178_start: Boolean;
            signal Xentry_179_symbol: Boolean;
            signal Xexit_180_symbol: Boolean;
            -- 
          begin -- 
            binary_65_inputs_178_start <= Xentry_176_symbol; -- control passed to block
            Xentry_179_symbol  <= binary_65_inputs_178_start; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs/$entry
            Xexit_180_symbol <= Xentry_179_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs/$exit
            binary_65_inputs_178_symbol <= Xexit_180_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65/binary_65_inputs
          rr_181_symbol <= binary_65_inputs_178_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/rr
          binary_65_inst_req_0 <= rr_181_symbol; -- link to DP
          ra_182_symbol <= binary_65_inst_ack_0; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/ra
          cr_183_symbol <= ra_182_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/cr
          binary_65_inst_req_1 <= cr_183_symbol; -- link to DP
          ca_184_symbol <= binary_65_inst_ack_1; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/ca
          Xexit_177_symbol <= ca_184_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/binary_65/$exit
          binary_65_175_symbol <= Xexit_177_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/if_stmt_62_eval_test/binary_65
        branch_req_185_symbol <= binary_65_175_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/branch_req
        if_stmt_62_branch_req_0 <= branch_req_185_symbol; -- link to DP
        Xexit_174_symbol <= branch_req_185_symbol; -- transition branch_block_stmt_41/if_stmt_62_eval_test/$exit
        if_stmt_62_eval_test_172_symbol <= Xexit_174_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_eval_test
      binary_65_place_186_symbol  <=  if_stmt_62_eval_test_172_symbol; -- place branch_block_stmt_41/binary_65_place (optimized away) 
      if_stmt_62_if_link_187: Block -- branch_block_stmt_41/if_stmt_62_if_link 
        signal if_stmt_62_if_link_187_start: Boolean;
        signal Xentry_188_symbol: Boolean;
        signal Xexit_189_symbol: Boolean;
        signal if_choice_transition_190_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_if_link_187_start <= binary_65_place_186_symbol; -- control passed to block
        Xentry_188_symbol  <= if_stmt_62_if_link_187_start; -- transition branch_block_stmt_41/if_stmt_62_if_link/$entry
        if_choice_transition_190_symbol <= if_stmt_62_branch_ack_1; -- transition branch_block_stmt_41/if_stmt_62_if_link/if_choice_transition
        Xexit_189_symbol <= if_choice_transition_190_symbol; -- transition branch_block_stmt_41/if_stmt_62_if_link/$exit
        if_stmt_62_if_link_187_symbol <= Xexit_189_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_if_link
      if_stmt_62_else_link_191: Block -- branch_block_stmt_41/if_stmt_62_else_link 
        signal if_stmt_62_else_link_191_start: Boolean;
        signal Xentry_192_symbol: Boolean;
        signal Xexit_193_symbol: Boolean;
        signal else_choice_transition_194_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_62_else_link_191_start <= binary_65_place_186_symbol; -- control passed to block
        Xentry_192_symbol  <= if_stmt_62_else_link_191_start; -- transition branch_block_stmt_41/if_stmt_62_else_link/$entry
        else_choice_transition_194_symbol <= if_stmt_62_branch_ack_0; -- transition branch_block_stmt_41/if_stmt_62_else_link/else_choice_transition
        Xexit_193_symbol <= else_choice_transition_194_symbol; -- transition branch_block_stmt_41/if_stmt_62_else_link/$exit
        if_stmt_62_else_link_191_symbol <= Xexit_193_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/if_stmt_62_else_link
      loopback_195_symbol  <=  if_stmt_62_if_link_187_symbol; -- place branch_block_stmt_41/loopback (optimized away) 
      stmt_68_x_xentry_x_xx_x196_symbol  <=  if_stmt_62_else_link_191_symbol; -- place branch_block_stmt_41/stmt_68__entry__ (optimized away) 
      stmt_68_x_xexit_x_xx_x197_symbol  <=  stmt_68_198_symbol; -- place branch_block_stmt_41/stmt_68__exit__ (optimized away) 
      stmt_68_198: Block -- branch_block_stmt_41/stmt_68 
        signal stmt_68_198_start: Boolean;
        signal Xentry_199_symbol: Boolean;
        signal Xexit_200_symbol: Boolean;
        -- 
      begin -- 
        stmt_68_198_start <= stmt_68_x_xentry_x_xx_x196_symbol; -- control passed to block
        Xentry_199_symbol  <= stmt_68_198_start; -- transition branch_block_stmt_41/stmt_68/$entry
        Xexit_200_symbol <= Xentry_199_symbol; -- transition branch_block_stmt_41/stmt_68/$exit
        stmt_68_198_symbol <= Xexit_200_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/stmt_68
      merge_stmt_42_dead_link_201: Block -- branch_block_stmt_41/merge_stmt_42_dead_link 
        signal merge_stmt_42_dead_link_201_start: Boolean;
        signal Xentry_202_symbol: Boolean;
        signal Xexit_203_symbol: Boolean;
        signal dead_transition_204_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_42_dead_link_201_start <= merge_stmt_42_x_xentry_x_xx_x134_symbol; -- control passed to block
        Xentry_202_symbol  <= merge_stmt_42_dead_link_201_start; -- transition branch_block_stmt_41/merge_stmt_42_dead_link/$entry
        dead_transition_204_symbol <= false;
        Xexit_203_symbol <= dead_transition_204_symbol; -- transition branch_block_stmt_41/merge_stmt_42_dead_link/$exit
        merge_stmt_42_dead_link_201_symbol <= Xexit_203_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/merge_stmt_42_dead_link
      merge_stmt_42_x_xentry_x_xx_xPhiReq_205: Block -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq 
        signal merge_stmt_42_x_xentry_x_xx_xPhiReq_205_start: Boolean;
        signal Xentry_206_symbol: Boolean;
        signal Xexit_207_symbol: Boolean;
        signal phi_stmt_43_208_symbol : Boolean;
        signal phi_stmt_47_212_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_42_x_xentry_x_xx_xPhiReq_205_start <= merge_stmt_42_x_xentry_x_xx_x134_symbol; -- control passed to block
        Xentry_206_symbol  <= merge_stmt_42_x_xentry_x_xx_xPhiReq_205_start; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/$entry
        phi_stmt_43_208: Block -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43 
          signal phi_stmt_43_208_start: Boolean;
          signal Xentry_209_symbol: Boolean;
          signal Xexit_210_symbol: Boolean;
          signal phi_stmt_43_req_211_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_43_208_start <= Xentry_206_symbol; -- control passed to block
          Xentry_209_symbol  <= phi_stmt_43_208_start; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43/$entry
          phi_stmt_43_req_211_symbol <= Xentry_209_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43/phi_stmt_43_req
          phi_stmt_43_req_0 <= phi_stmt_43_req_211_symbol; -- link to DP
          Xexit_210_symbol <= phi_stmt_43_req_211_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43/$exit
          phi_stmt_43_208_symbol <= Xexit_210_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_43
        phi_stmt_47_212: Block -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47 
          signal phi_stmt_47_212_start: Boolean;
          signal Xentry_213_symbol: Boolean;
          signal Xexit_214_symbol: Boolean;
          signal phi_stmt_47_req_215_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_47_212_start <= Xentry_206_symbol; -- control passed to block
          Xentry_213_symbol  <= phi_stmt_47_212_start; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47/$entry
          phi_stmt_47_req_215_symbol <= Xentry_213_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47/phi_stmt_47_req
          phi_stmt_47_req_0 <= phi_stmt_47_req_215_symbol; -- link to DP
          Xexit_214_symbol <= phi_stmt_47_req_215_symbol; -- transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47/$exit
          phi_stmt_47_212_symbol <= Xexit_214_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq/phi_stmt_47
        Xexit_207_block : Block -- non-trivial join transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/$exit 
          signal Xexit_207_predecessors: BooleanArray(1 downto 0);
          signal Xexit_207_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_207_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_207_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_207_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_207_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_207_p0_pred, Xexit_207_p0_succ, Xexit_207_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_207_p0_succ(0) <=  Xexit_207_symbol;
          Xexit_207_p0_pred(0) <=  phi_stmt_43_208_symbol;
          Xexit_207_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_207_p1_pred, Xexit_207_p1_succ, Xexit_207_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_207_p1_succ(0) <=  Xexit_207_symbol;
          Xexit_207_p1_pred(0) <=  phi_stmt_47_212_symbol;
          Xexit_207_symbol <= AndReduce(Xexit_207_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/merge_stmt_42__entry___PhiReq/$exit
        merge_stmt_42_x_xentry_x_xx_xPhiReq_205_symbol <= Xexit_207_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/merge_stmt_42__entry___PhiReq
      loopback_PhiReq_216: Block -- branch_block_stmt_41/loopback_PhiReq 
        signal loopback_PhiReq_216_start: Boolean;
        signal Xentry_217_symbol: Boolean;
        signal Xexit_218_symbol: Boolean;
        signal phi_stmt_43_219_symbol : Boolean;
        signal phi_stmt_47_223_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_216_start <= loopback_195_symbol; -- control passed to block
        Xentry_217_symbol  <= loopback_PhiReq_216_start; -- transition branch_block_stmt_41/loopback_PhiReq/$entry
        phi_stmt_43_219: Block -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_43 
          signal phi_stmt_43_219_start: Boolean;
          signal Xentry_220_symbol: Boolean;
          signal Xexit_221_symbol: Boolean;
          signal phi_stmt_43_req_222_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_43_219_start <= Xentry_217_symbol; -- control passed to block
          Xentry_220_symbol  <= phi_stmt_43_219_start; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_43/$entry
          phi_stmt_43_req_222_symbol <= Xentry_220_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_43/phi_stmt_43_req
          phi_stmt_43_req_1 <= phi_stmt_43_req_222_symbol; -- link to DP
          Xexit_221_symbol <= phi_stmt_43_req_222_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_43/$exit
          phi_stmt_43_219_symbol <= Xexit_221_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_43
        phi_stmt_47_223: Block -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_47 
          signal phi_stmt_47_223_start: Boolean;
          signal Xentry_224_symbol: Boolean;
          signal Xexit_225_symbol: Boolean;
          signal phi_stmt_47_req_226_symbol : Boolean;
          -- 
        begin -- 
          phi_stmt_47_223_start <= Xentry_217_symbol; -- control passed to block
          Xentry_224_symbol  <= phi_stmt_47_223_start; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_47/$entry
          phi_stmt_47_req_226_symbol <= Xentry_224_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_47/phi_stmt_47_req
          phi_stmt_47_req_1 <= phi_stmt_47_req_226_symbol; -- link to DP
          Xexit_225_symbol <= phi_stmt_47_req_226_symbol; -- transition branch_block_stmt_41/loopback_PhiReq/phi_stmt_47/$exit
          phi_stmt_47_223_symbol <= Xexit_225_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_41/loopback_PhiReq/phi_stmt_47
        Xexit_218_block : Block -- non-trivial join transition branch_block_stmt_41/loopback_PhiReq/$exit 
          signal Xexit_218_predecessors: BooleanArray(1 downto 0);
          signal Xexit_218_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_218_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_218_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_218_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_218_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_218_p0_pred, Xexit_218_p0_succ, Xexit_218_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_218_p0_succ(0) <=  Xexit_218_symbol;
          Xexit_218_p0_pred(0) <=  phi_stmt_43_219_symbol;
          Xexit_218_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_218_p1_pred, Xexit_218_p1_succ, Xexit_218_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_218_p1_succ(0) <=  Xexit_218_symbol;
          Xexit_218_p1_pred(0) <=  phi_stmt_47_223_symbol;
          Xexit_218_symbol <= AndReduce(Xexit_218_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/loopback_PhiReq/$exit
        loopback_PhiReq_216_symbol <= Xexit_218_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/loopback_PhiReq
      merge_stmt_42_PhiReqMerge_227_symbol  <=  merge_stmt_42_x_xentry_x_xx_xPhiReq_205_symbol or loopback_PhiReq_216_symbol; -- place branch_block_stmt_41/merge_stmt_42_PhiReqMerge (optimized away) 
      merge_stmt_42_PhiAck_228: Block -- branch_block_stmt_41/merge_stmt_42_PhiAck 
        signal merge_stmt_42_PhiAck_228_start: Boolean;
        signal Xentry_229_symbol: Boolean;
        signal Xexit_230_symbol: Boolean;
        signal phi_stmt_43_ack_231_symbol : Boolean;
        signal phi_stmt_47_ack_232_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_42_PhiAck_228_start <= merge_stmt_42_PhiReqMerge_227_symbol; -- control passed to block
        Xentry_229_symbol  <= merge_stmt_42_PhiAck_228_start; -- transition branch_block_stmt_41/merge_stmt_42_PhiAck/$entry
        phi_stmt_43_ack_231_symbol <= phi_stmt_43_ack_0; -- transition branch_block_stmt_41/merge_stmt_42_PhiAck/phi_stmt_43_ack
        phi_stmt_47_ack_232_symbol <= phi_stmt_47_ack_0; -- transition branch_block_stmt_41/merge_stmt_42_PhiAck/phi_stmt_47_ack
        Xexit_230_block : Block -- non-trivial join transition branch_block_stmt_41/merge_stmt_42_PhiAck/$exit 
          signal Xexit_230_predecessors: BooleanArray(1 downto 0);
          signal Xexit_230_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_230_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_230_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_230_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_230_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_230_p0_pred, Xexit_230_p0_succ, Xexit_230_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_230_p0_succ(0) <=  Xexit_230_symbol;
          Xexit_230_p0_pred(0) <=  phi_stmt_43_ack_231_symbol;
          Xexit_230_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_230_p1_pred, Xexit_230_p1_succ, Xexit_230_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_230_p1_succ(0) <=  Xexit_230_symbol;
          Xexit_230_p1_pred(0) <=  phi_stmt_47_ack_232_symbol;
          Xexit_230_symbol <= AndReduce(Xexit_230_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_41/merge_stmt_42_PhiAck/$exit
        merge_stmt_42_PhiAck_228_symbol <= Xexit_230_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_41/merge_stmt_42_PhiAck
      Xexit_131_symbol <= branch_block_stmt_41_x_xexit_x_xx_x133_symbol; -- transition branch_block_stmt_41/$exit
      branch_block_stmt_41_129_symbol <= Xexit_131_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_41
    assign_stmt_73_233: Block -- assign_stmt_73 
      signal assign_stmt_73_233_start: Boolean;
      signal Xentry_234_symbol: Boolean;
      signal Xexit_235_symbol: Boolean;
      signal req_236_symbol : Boolean;
      signal ack_237_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_73_233_start <= branch_block_stmt_41_129_symbol; -- control passed to block
      Xentry_234_symbol  <= assign_stmt_73_233_start; -- transition assign_stmt_73/$entry
      req_236_symbol <= Xentry_234_symbol; -- transition assign_stmt_73/req
      simple_obj_ref_71_inst_req_0 <= req_236_symbol; -- link to DP
      ack_237_symbol <= simple_obj_ref_71_inst_ack_0; -- transition assign_stmt_73/ack
      Xexit_235_symbol <= ack_237_symbol; -- transition assign_stmt_73/$exit
      assign_stmt_73_233_symbol <= Xexit_235_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_73
    assign_stmt_78_238: Block -- assign_stmt_78 
      signal assign_stmt_78_238_start: Boolean;
      signal Xentry_239_symbol: Boolean;
      signal Xexit_240_symbol: Boolean;
      signal binary_77_241_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_78_238_start <= assign_stmt_73_233_symbol; -- control passed to block
      Xentry_239_symbol  <= assign_stmt_78_238_start; -- transition assign_stmt_78/$entry
      binary_77_241: Block -- assign_stmt_78/binary_77 
        signal binary_77_241_start: Boolean;
        signal Xentry_242_symbol: Boolean;
        signal Xexit_243_symbol: Boolean;
        signal binary_77_inputs_244_symbol : Boolean;
        signal rr_247_symbol : Boolean;
        signal ra_248_symbol : Boolean;
        signal cr_249_symbol : Boolean;
        signal ca_250_symbol : Boolean;
        -- 
      begin -- 
        binary_77_241_start <= Xentry_239_symbol; -- control passed to block
        Xentry_242_symbol  <= binary_77_241_start; -- transition assign_stmt_78/binary_77/$entry
        binary_77_inputs_244: Block -- assign_stmt_78/binary_77/binary_77_inputs 
          signal binary_77_inputs_244_start: Boolean;
          signal Xentry_245_symbol: Boolean;
          signal Xexit_246_symbol: Boolean;
          -- 
        begin -- 
          binary_77_inputs_244_start <= Xentry_242_symbol; -- control passed to block
          Xentry_245_symbol  <= binary_77_inputs_244_start; -- transition assign_stmt_78/binary_77/binary_77_inputs/$entry
          Xexit_246_symbol <= Xentry_245_symbol; -- transition assign_stmt_78/binary_77/binary_77_inputs/$exit
          binary_77_inputs_244_symbol <= Xexit_246_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_78/binary_77/binary_77_inputs
        rr_247_symbol <= binary_77_inputs_244_symbol; -- transition assign_stmt_78/binary_77/rr
        binary_77_inst_req_0 <= rr_247_symbol; -- link to DP
        ra_248_symbol <= binary_77_inst_ack_0; -- transition assign_stmt_78/binary_77/ra
        cr_249_symbol <= ra_248_symbol; -- transition assign_stmt_78/binary_77/cr
        binary_77_inst_req_1 <= cr_249_symbol; -- link to DP
        ca_250_symbol <= binary_77_inst_ack_1; -- transition assign_stmt_78/binary_77/ca
        Xexit_243_symbol <= ca_250_symbol; -- transition assign_stmt_78/binary_77/$exit
        binary_77_241_symbol <= Xexit_243_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_78/binary_77
      Xexit_240_symbol <= binary_77_241_symbol; -- transition assign_stmt_78/$exit
      assign_stmt_78_238_symbol <= Xexit_240_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_78
    Xexit_2_symbol <= assign_stmt_78_238_symbol; -- transition $exit
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
  signal sum_mod_a :  std_logic_vector(9 downto 0) := (2 => '1', others => '0');
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
