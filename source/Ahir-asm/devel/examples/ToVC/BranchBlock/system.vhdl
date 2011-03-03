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
    c : out  std_logic_vector(9 downto 0);
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
  signal branch_block_stmt_5Xassign_stmt_25Xbinary_24Xrr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xassign_stmt_25Xbinary_24Xra_dp_to_cp : boolean;
  signal branch_block_stmt_5Xassign_stmt_25Xbinary_24Xcr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xassign_stmt_25Xbinary_24Xca_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXXexit_cp_to_dp : boolean;
  signal branch_block_stmt_5Xassign_stmt_20Xbinary_19Xrr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xassign_stmt_20Xbinary_19Xra_dp_to_cp : boolean;
  signal branch_block_stmt_5Xassign_stmt_20Xbinary_19Xcr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xassign_stmt_20Xbinary_19Xca_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_choice_2Xack1_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_choice_defaultXack0_dp_to_cp : boolean;
  signal branch_block_stmt_5Xbranch_block_stmt_5_x_xentry_x_xx_xPhiReqXphi_stmt_7_req_cp_to_dp : boolean;
  signal branch_block_stmt_5Xbranch_block_stmt_5_x_xentry_x_xx_xPhiReqXphi_stmt_11_req_cp_to_dp : boolean;
  signal branch_block_stmt_5Xloopback_PhiReqXphi_stmt_7_req_cp_to_dp : boolean;
  signal branch_block_stmt_5Xloopback_PhiReqXphi_stmt_11_req_cp_to_dp : boolean;
  signal branch_block_stmt_5Xmerge_stmt_6_PhiAckXphi_stmt_7_ack_dp_to_cp : boolean;
  signal branch_block_stmt_5Xmerge_stmt_6_PhiAckXphi_stmt_11_ack_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xrr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xra_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xcr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xca_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xcmp_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xrr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xra_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xcr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xca_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xcmp_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xrr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xra_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xcr_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xca_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xcmp_cp_to_dp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_choice_0Xack1_dp_to_cp : boolean;
  signal branch_block_stmt_5Xswitch_stmt_26_choice_1Xack1_dp_to_cp : boolean;
  signal assign_stmt_42Xreq_cp_to_dp : boolean;
  signal assign_stmt_42Xack_dp_to_cp : boolean;
  signal assign_stmt_45Xreq_cp_to_dp : boolean;
  signal assign_stmt_45Xack_dp_to_cp : boolean;
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
    signal branch_block_stmt_5_3_symbol : Boolean;
    signal assign_stmt_42_107_symbol : Boolean;
    signal assign_stmt_45_112_symbol : Boolean;
    -- 
  begin -- 
    sum_mod_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= sum_mod_CP_0_start; -- transition $entry
    branch_block_stmt_5_3: Block -- branch_block_stmt_5 
      signal branch_block_stmt_5_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_5_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_5_x_xexit_x_xx_x7_symbol : Boolean;
      signal merge_stmt_6_x_xexit_x_xx_x8_symbol : Boolean;
      signal assign_stmt_20_x_xentry_x_xx_x9_symbol : Boolean;
      signal assign_stmt_20_x_xexit_x_xx_x10_symbol : Boolean;
      signal assign_stmt_25_x_xentry_x_xx_x11_symbol : Boolean;
      signal assign_stmt_25_x_xexit_x_xx_x12_symbol : Boolean;
      signal switch_stmt_26_x_xentry_x_xx_x13_symbol : Boolean;
      signal assign_stmt_20_14_symbol : Boolean;
      signal assign_stmt_25_27_symbol : Boolean;
      signal switch_stmt_26_x_xcondition_check_place_x_xx_x40_symbol : Boolean;
      signal switch_stmt_26_x_xcondition_check_x_xx_x41_symbol : Boolean;
      signal switch_stmt_26_x_xselect_x_xx_x68_symbol : Boolean;
      signal switch_stmt_26_choice_0_69_symbol : Boolean;
      signal loopback_73_symbol : Boolean;
      signal switch_stmt_26_choice_1_74_symbol : Boolean;
      signal switch_stmt_26_choice_2_78_symbol : Boolean;
      signal switch_stmt_26_choice_default_82_symbol : Boolean;
      signal stmt_37_x_xentry_x_xx_x86_symbol : Boolean;
      signal stmt_37_x_xexit_x_xx_x87_symbol : Boolean;
      signal stmt_37_88_symbol : Boolean;
      signal branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91_symbol : Boolean;
      signal loopback_PhiReq_96_symbol : Boolean;
      signal merge_stmt_6_PhiReqMerge_101_symbol : Boolean;
      signal merge_stmt_6_PhiAck_102_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_5_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_5_3_start; -- transition branch_block_stmt_5/$entry
      branch_block_stmt_5_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_5/branch_block_stmt_5__entry__ (optimized away) 
      branch_block_stmt_5_x_xexit_x_xx_x7_symbol  <=  stmt_37_x_xexit_x_xx_x87_symbol; -- place branch_block_stmt_5/branch_block_stmt_5__exit__ (optimized away) 
      merge_stmt_6_x_xexit_x_xx_x8_symbol  <=  merge_stmt_6_PhiAck_102_symbol; -- place branch_block_stmt_5/merge_stmt_6__exit__ (optimized away) 
      assign_stmt_20_x_xentry_x_xx_x9_symbol  <=  merge_stmt_6_x_xexit_x_xx_x8_symbol; -- place branch_block_stmt_5/assign_stmt_20__entry__ (optimized away) 
      assign_stmt_20_x_xexit_x_xx_x10_symbol  <=  assign_stmt_20_14_symbol; -- place branch_block_stmt_5/assign_stmt_20__exit__ (optimized away) 
      assign_stmt_25_x_xentry_x_xx_x11_symbol  <=  assign_stmt_20_x_xexit_x_xx_x10_symbol; -- place branch_block_stmt_5/assign_stmt_25__entry__ (optimized away) 
      assign_stmt_25_x_xexit_x_xx_x12_symbol  <=  assign_stmt_25_27_symbol; -- place branch_block_stmt_5/assign_stmt_25__exit__ (optimized away) 
      switch_stmt_26_x_xentry_x_xx_x13_symbol  <=  assign_stmt_25_x_xexit_x_xx_x12_symbol; -- place branch_block_stmt_5/switch_stmt_26__entry__ (optimized away) 
      assign_stmt_20_14: Block -- branch_block_stmt_5/assign_stmt_20 
        signal assign_stmt_20_14_start: Boolean;
        signal Xentry_15_symbol: Boolean;
        signal Xexit_16_symbol: Boolean;
        signal binary_19_17_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_20_14_start <= assign_stmt_20_x_xentry_x_xx_x9_symbol; -- control passed to block
        Xentry_15_symbol  <= assign_stmt_20_14_start; -- transition branch_block_stmt_5/assign_stmt_20/$entry
        binary_19_17: Block -- branch_block_stmt_5/assign_stmt_20/binary_19 
          signal binary_19_17_start: Boolean;
          signal Xentry_18_symbol: Boolean;
          signal Xexit_19_symbol: Boolean;
          signal binary_19_inputs_20_symbol : Boolean;
          signal rr_23_symbol : Boolean;
          signal ra_24_symbol : Boolean;
          signal cr_25_symbol : Boolean;
          signal ca_26_symbol : Boolean;
          -- 
        begin -- 
          binary_19_17_start <= Xentry_15_symbol; -- control passed to block
          Xentry_18_symbol  <= binary_19_17_start; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/$entry
          binary_19_inputs_20: Block -- branch_block_stmt_5/assign_stmt_20/binary_19/binary_19_inputs 
            signal binary_19_inputs_20_start: Boolean;
            signal Xentry_21_symbol: Boolean;
            signal Xexit_22_symbol: Boolean;
            -- 
          begin -- 
            binary_19_inputs_20_start <= Xentry_18_symbol; -- control passed to block
            Xentry_21_symbol  <= binary_19_inputs_20_start; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/binary_19_inputs/$entry
            Xexit_22_symbol <= Xentry_21_symbol; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/binary_19_inputs/$exit
            binary_19_inputs_20_symbol <= Xexit_22_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_5/assign_stmt_20/binary_19/binary_19_inputs
          rr_23_symbol <= binary_19_inputs_20_symbol; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/rr
          branch_block_stmt_5Xassign_stmt_20Xbinary_19Xrr_cp_to_dp <= rr_23_symbol; -- link to DP
          ra_24_symbol <= branch_block_stmt_5Xassign_stmt_20Xbinary_19Xra_dp_to_cp; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/ra
          cr_25_symbol <= ra_24_symbol; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/cr
          branch_block_stmt_5Xassign_stmt_20Xbinary_19Xcr_cp_to_dp <= cr_25_symbol; -- link to DP
          ca_26_symbol <= branch_block_stmt_5Xassign_stmt_20Xbinary_19Xca_dp_to_cp; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/ca
          Xexit_19_symbol <= ca_26_symbol; -- transition branch_block_stmt_5/assign_stmt_20/binary_19/$exit
          binary_19_17_symbol <= Xexit_19_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_5/assign_stmt_20/binary_19
        Xexit_16_symbol <= binary_19_17_symbol; -- transition branch_block_stmt_5/assign_stmt_20/$exit
        assign_stmt_20_14_symbol <= Xexit_16_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/assign_stmt_20
      assign_stmt_25_27: Block -- branch_block_stmt_5/assign_stmt_25 
        signal assign_stmt_25_27_start: Boolean;
        signal Xentry_28_symbol: Boolean;
        signal Xexit_29_symbol: Boolean;
        signal binary_24_30_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_25_27_start <= assign_stmt_25_x_xentry_x_xx_x11_symbol; -- control passed to block
        Xentry_28_symbol  <= assign_stmt_25_27_start; -- transition branch_block_stmt_5/assign_stmt_25/$entry
        binary_24_30: Block -- branch_block_stmt_5/assign_stmt_25/binary_24 
          signal binary_24_30_start: Boolean;
          signal Xentry_31_symbol: Boolean;
          signal Xexit_32_symbol: Boolean;
          signal binary_24_inputs_33_symbol : Boolean;
          signal rr_36_symbol : Boolean;
          signal ra_37_symbol : Boolean;
          signal cr_38_symbol : Boolean;
          signal ca_39_symbol : Boolean;
          -- 
        begin -- 
          binary_24_30_start <= Xentry_28_symbol; -- control passed to block
          Xentry_31_symbol  <= binary_24_30_start; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/$entry
          binary_24_inputs_33: Block -- branch_block_stmt_5/assign_stmt_25/binary_24/binary_24_inputs 
            signal binary_24_inputs_33_start: Boolean;
            signal Xentry_34_symbol: Boolean;
            signal Xexit_35_symbol: Boolean;
            -- 
          begin -- 
            binary_24_inputs_33_start <= Xentry_31_symbol; -- control passed to block
            Xentry_34_symbol  <= binary_24_inputs_33_start; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/binary_24_inputs/$entry
            Xexit_35_symbol <= Xentry_34_symbol; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/binary_24_inputs/$exit
            binary_24_inputs_33_symbol <= Xexit_35_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_5/assign_stmt_25/binary_24/binary_24_inputs
          rr_36_symbol <= binary_24_inputs_33_symbol; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/rr
          branch_block_stmt_5Xassign_stmt_25Xbinary_24Xrr_cp_to_dp <= rr_36_symbol; -- link to DP
          ra_37_symbol <= branch_block_stmt_5Xassign_stmt_25Xbinary_24Xra_dp_to_cp; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/ra
          cr_38_symbol <= ra_37_symbol; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/cr
          branch_block_stmt_5Xassign_stmt_25Xbinary_24Xcr_cp_to_dp <= cr_38_symbol; -- link to DP
          ca_39_symbol <= branch_block_stmt_5Xassign_stmt_25Xbinary_24Xca_dp_to_cp; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/ca
          Xexit_32_symbol <= ca_39_symbol; -- transition branch_block_stmt_5/assign_stmt_25/binary_24/$exit
          binary_24_30_symbol <= Xexit_32_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_5/assign_stmt_25/binary_24
        Xexit_29_symbol <= binary_24_30_symbol; -- transition branch_block_stmt_5/assign_stmt_25/$exit
        assign_stmt_25_27_symbol <= Xexit_29_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/assign_stmt_25
      switch_stmt_26_x_xcondition_check_place_x_xx_x40_symbol  <=  switch_stmt_26_x_xentry_x_xx_x13_symbol; -- place branch_block_stmt_5/switch_stmt_26__condition_check_place__ (optimized away) 
      switch_stmt_26_x_xcondition_check_x_xx_x41: Block -- branch_block_stmt_5/switch_stmt_26__condition_check__ 
        signal switch_stmt_26_x_xcondition_check_x_xx_x41_start: Boolean;
        signal Xentry_42_symbol: Boolean;
        signal Xexit_43_symbol: Boolean;
        signal condition_0_44_symbol : Boolean;
        signal condition_1_52_symbol : Boolean;
        signal condition_2_60_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_26_x_xcondition_check_x_xx_x41_start <= switch_stmt_26_x_xcondition_check_place_x_xx_x40_symbol; -- control passed to block
        Xentry_42_symbol  <= switch_stmt_26_x_xcondition_check_x_xx_x41_start; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/$entry
        condition_0_44: Block -- branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0 
          signal condition_0_44_start: Boolean;
          signal Xentry_45_symbol: Boolean;
          signal Xexit_46_symbol: Boolean;
          signal rr_47_symbol : Boolean;
          signal ra_48_symbol : Boolean;
          signal cr_49_symbol : Boolean;
          signal ca_50_symbol : Boolean;
          signal cmp_51_symbol : Boolean;
          -- 
        begin -- 
          condition_0_44_start <= Xentry_42_symbol; -- control passed to block
          Xentry_45_symbol  <= condition_0_44_start; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/$entry
          rr_47_symbol <= Xentry_45_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/rr
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xrr_cp_to_dp <= rr_47_symbol; -- link to DP
          ra_48_symbol <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xra_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/ra
          cr_49_symbol <= ra_48_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/cr
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xcr_cp_to_dp <= cr_49_symbol; -- link to DP
          ca_50_symbol <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xca_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/ca
          cmp_51_symbol <= ca_50_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/cmp
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xcmp_cp_to_dp <= cmp_51_symbol; -- link to DP
          Xexit_46_symbol <= cmp_51_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0/$exit
          condition_0_44_symbol <= Xexit_46_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_5/switch_stmt_26__condition_check__/condition_0
        condition_1_52: Block -- branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1 
          signal condition_1_52_start: Boolean;
          signal Xentry_53_symbol: Boolean;
          signal Xexit_54_symbol: Boolean;
          signal rr_55_symbol : Boolean;
          signal ra_56_symbol : Boolean;
          signal cr_57_symbol : Boolean;
          signal ca_58_symbol : Boolean;
          signal cmp_59_symbol : Boolean;
          -- 
        begin -- 
          condition_1_52_start <= Xentry_42_symbol; -- control passed to block
          Xentry_53_symbol  <= condition_1_52_start; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/$entry
          rr_55_symbol <= Xentry_53_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/rr
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xrr_cp_to_dp <= rr_55_symbol; -- link to DP
          ra_56_symbol <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xra_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/ra
          cr_57_symbol <= ra_56_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/cr
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xcr_cp_to_dp <= cr_57_symbol; -- link to DP
          ca_58_symbol <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xca_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/ca
          cmp_59_symbol <= ca_58_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/cmp
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xcmp_cp_to_dp <= cmp_59_symbol; -- link to DP
          Xexit_54_symbol <= cmp_59_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1/$exit
          condition_1_52_symbol <= Xexit_54_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_5/switch_stmt_26__condition_check__/condition_1
        condition_2_60: Block -- branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2 
          signal condition_2_60_start: Boolean;
          signal Xentry_61_symbol: Boolean;
          signal Xexit_62_symbol: Boolean;
          signal rr_63_symbol : Boolean;
          signal ra_64_symbol : Boolean;
          signal cr_65_symbol : Boolean;
          signal ca_66_symbol : Boolean;
          signal cmp_67_symbol : Boolean;
          -- 
        begin -- 
          condition_2_60_start <= Xentry_42_symbol; -- control passed to block
          Xentry_61_symbol  <= condition_2_60_start; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/$entry
          rr_63_symbol <= Xentry_61_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/rr
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xrr_cp_to_dp <= rr_63_symbol; -- link to DP
          ra_64_symbol <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xra_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/ra
          cr_65_symbol <= ra_64_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/cr
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xcr_cp_to_dp <= cr_65_symbol; -- link to DP
          ca_66_symbol <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xca_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/ca
          cmp_67_symbol <= ca_66_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/cmp
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xcmp_cp_to_dp <= cmp_67_symbol; -- link to DP
          Xexit_62_symbol <= cmp_67_symbol; -- transition branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2/$exit
          condition_2_60_symbol <= Xexit_62_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_5/switch_stmt_26__condition_check__/condition_2
        Xexit_43_block : Block -- non-trivial join transition branch_block_stmt_5/switch_stmt_26__condition_check__/$exit 
          signal Xexit_43_predecessors: BooleanArray(2 downto 0);
          signal Xexit_43_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_43_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_43_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_43_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_43_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_43_p2_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_43_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_43_p0_pred, Xexit_43_p0_succ, Xexit_43_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_43_p0_succ(0) <=  Xexit_43_symbol;
          Xexit_43_p0_pred(0) <=  condition_0_44_symbol;
          Xexit_43_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_43_p1_pred, Xexit_43_p1_succ, Xexit_43_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_43_p1_succ(0) <=  Xexit_43_symbol;
          Xexit_43_p1_pred(0) <=  condition_1_52_symbol;
          Xexit_43_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_43_p2_pred, Xexit_43_p2_succ, Xexit_43_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_43_p2_succ(0) <=  Xexit_43_symbol;
          Xexit_43_p2_pred(0) <=  condition_2_60_symbol;
          Xexit_43_symbol <= AndReduce(Xexit_43_predecessors); 
          branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXXexit_cp_to_dp <= Xexit_43_symbol; -- link to DP
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_5/switch_stmt_26__condition_check__/$exit
        switch_stmt_26_x_xcondition_check_x_xx_x41_symbol <= Xexit_43_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/switch_stmt_26__condition_check__
      switch_stmt_26_x_xselect_x_xx_x68_symbol  <=  switch_stmt_26_x_xcondition_check_x_xx_x41_symbol; -- place branch_block_stmt_5/switch_stmt_26__select__ (optimized away) 
      switch_stmt_26_choice_0_69: Block -- branch_block_stmt_5/switch_stmt_26_choice_0 
        signal switch_stmt_26_choice_0_69_start: Boolean;
        signal Xentry_70_symbol: Boolean;
        signal Xexit_71_symbol: Boolean;
        signal ack1_72_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_26_choice_0_69_start <= switch_stmt_26_x_xselect_x_xx_x68_symbol; -- control passed to block
        Xentry_70_symbol  <= switch_stmt_26_choice_0_69_start; -- transition branch_block_stmt_5/switch_stmt_26_choice_0/$entry
        ack1_72_symbol <= branch_block_stmt_5Xswitch_stmt_26_choice_0Xack1_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26_choice_0/ack1
        Xexit_71_symbol <= ack1_72_symbol; -- transition branch_block_stmt_5/switch_stmt_26_choice_0/$exit
        switch_stmt_26_choice_0_69_symbol <= Xexit_71_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/switch_stmt_26_choice_0
      loopback_73_symbol  <=  switch_stmt_26_choice_0_69_symbol or switch_stmt_26_choice_1_74_symbol or switch_stmt_26_choice_2_78_symbol; -- place branch_block_stmt_5/loopback (optimized away) 
      switch_stmt_26_choice_1_74: Block -- branch_block_stmt_5/switch_stmt_26_choice_1 
        signal switch_stmt_26_choice_1_74_start: Boolean;
        signal Xentry_75_symbol: Boolean;
        signal Xexit_76_symbol: Boolean;
        signal ack1_77_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_26_choice_1_74_start <= switch_stmt_26_x_xselect_x_xx_x68_symbol; -- control passed to block
        Xentry_75_symbol  <= switch_stmt_26_choice_1_74_start; -- transition branch_block_stmt_5/switch_stmt_26_choice_1/$entry
        ack1_77_symbol <= branch_block_stmt_5Xswitch_stmt_26_choice_1Xack1_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26_choice_1/ack1
        Xexit_76_symbol <= ack1_77_symbol; -- transition branch_block_stmt_5/switch_stmt_26_choice_1/$exit
        switch_stmt_26_choice_1_74_symbol <= Xexit_76_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/switch_stmt_26_choice_1
      switch_stmt_26_choice_2_78: Block -- branch_block_stmt_5/switch_stmt_26_choice_2 
        signal switch_stmt_26_choice_2_78_start: Boolean;
        signal Xentry_79_symbol: Boolean;
        signal Xexit_80_symbol: Boolean;
        signal ack1_81_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_26_choice_2_78_start <= switch_stmt_26_x_xselect_x_xx_x68_symbol; -- control passed to block
        Xentry_79_symbol  <= switch_stmt_26_choice_2_78_start; -- transition branch_block_stmt_5/switch_stmt_26_choice_2/$entry
        ack1_81_symbol <= branch_block_stmt_5Xswitch_stmt_26_choice_2Xack1_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26_choice_2/ack1
        Xexit_80_symbol <= ack1_81_symbol; -- transition branch_block_stmt_5/switch_stmt_26_choice_2/$exit
        switch_stmt_26_choice_2_78_symbol <= Xexit_80_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/switch_stmt_26_choice_2
      switch_stmt_26_choice_default_82: Block -- branch_block_stmt_5/switch_stmt_26_choice_default 
        signal switch_stmt_26_choice_default_82_start: Boolean;
        signal Xentry_83_symbol: Boolean;
        signal Xexit_84_symbol: Boolean;
        signal ack0_85_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_26_choice_default_82_start <= switch_stmt_26_x_xselect_x_xx_x68_symbol; -- control passed to block
        Xentry_83_symbol  <= switch_stmt_26_choice_default_82_start; -- transition branch_block_stmt_5/switch_stmt_26_choice_default/$entry
        ack0_85_symbol <= branch_block_stmt_5Xswitch_stmt_26_choice_defaultXack0_dp_to_cp; -- transition branch_block_stmt_5/switch_stmt_26_choice_default/ack0
        Xexit_84_symbol <= ack0_85_symbol; -- transition branch_block_stmt_5/switch_stmt_26_choice_default/$exit
        switch_stmt_26_choice_default_82_symbol <= Xexit_84_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/switch_stmt_26_choice_default
      stmt_37_x_xentry_x_xx_x86_symbol  <=  switch_stmt_26_choice_default_82_symbol; -- place branch_block_stmt_5/stmt_37__entry__ (optimized away) 
      stmt_37_x_xexit_x_xx_x87_symbol  <=  stmt_37_88_symbol; -- place branch_block_stmt_5/stmt_37__exit__ (optimized away) 
      stmt_37_88: Block -- branch_block_stmt_5/stmt_37 
        signal stmt_37_88_start: Boolean;
        signal Xentry_89_symbol: Boolean;
        signal Xexit_90_symbol: Boolean;
        -- 
      begin -- 
        stmt_37_88_start <= stmt_37_x_xentry_x_xx_x86_symbol; -- control passed to block
        Xentry_89_symbol  <= stmt_37_88_start; -- transition branch_block_stmt_5/stmt_37/$entry
        Xexit_90_symbol <= Xentry_89_symbol; -- transition branch_block_stmt_5/stmt_37/$exit
        stmt_37_88_symbol <= Xexit_90_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/stmt_37
      branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91: Block -- branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq 
        signal branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91_start: Boolean;
        signal Xentry_92_symbol: Boolean;
        signal Xexit_93_symbol: Boolean;
        signal phi_stmt_7_req_94_symbol : Boolean;
        signal phi_stmt_11_req_95_symbol : Boolean;
        -- 
      begin -- 
        branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91_start <= branch_block_stmt_5_x_xentry_x_xx_x6_symbol; -- control passed to block
        Xentry_92_symbol  <= branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91_start; -- transition branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq/$entry
        phi_stmt_7_req_94_symbol <= Xentry_92_symbol; -- transition branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq/phi_stmt_7_req
        branch_block_stmt_5Xbranch_block_stmt_5_x_xentry_x_xx_xPhiReqXphi_stmt_7_req_cp_to_dp <= phi_stmt_7_req_94_symbol; -- link to DP
        phi_stmt_11_req_95_symbol <= Xentry_92_symbol; -- transition branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq/phi_stmt_11_req
        branch_block_stmt_5Xbranch_block_stmt_5_x_xentry_x_xx_xPhiReqXphi_stmt_11_req_cp_to_dp <= phi_stmt_11_req_95_symbol; -- link to DP
        Xexit_93_block : Block -- non-trivial join transition branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq/$exit 
          signal Xexit_93_predecessors: BooleanArray(1 downto 0);
          signal Xexit_93_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_93_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_93_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_93_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_93_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_93_p0_pred, Xexit_93_p0_succ, Xexit_93_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_93_p0_succ(0) <=  Xexit_93_symbol;
          Xexit_93_p0_pred(0) <=  phi_stmt_7_req_94_symbol;
          Xexit_93_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_93_p1_pred, Xexit_93_p1_succ, Xexit_93_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_93_p1_succ(0) <=  Xexit_93_symbol;
          Xexit_93_p1_pred(0) <=  phi_stmt_11_req_95_symbol;
          Xexit_93_symbol <= AndReduce(Xexit_93_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq/$exit
        branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91_symbol <= Xexit_93_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/branch_block_stmt_5__entry___PhiReq
      loopback_PhiReq_96: Block -- branch_block_stmt_5/loopback_PhiReq 
        signal loopback_PhiReq_96_start: Boolean;
        signal Xentry_97_symbol: Boolean;
        signal Xexit_98_symbol: Boolean;
        signal phi_stmt_7_req_99_symbol : Boolean;
        signal phi_stmt_11_req_100_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_96_start <= loopback_73_symbol; -- control passed to block
        Xentry_97_symbol  <= loopback_PhiReq_96_start; -- transition branch_block_stmt_5/loopback_PhiReq/$entry
        phi_stmt_7_req_99_symbol <= Xentry_97_symbol; -- transition branch_block_stmt_5/loopback_PhiReq/phi_stmt_7_req
        branch_block_stmt_5Xloopback_PhiReqXphi_stmt_7_req_cp_to_dp <= phi_stmt_7_req_99_symbol; -- link to DP
        phi_stmt_11_req_100_symbol <= Xentry_97_symbol; -- transition branch_block_stmt_5/loopback_PhiReq/phi_stmt_11_req
        branch_block_stmt_5Xloopback_PhiReqXphi_stmt_11_req_cp_to_dp <= phi_stmt_11_req_100_symbol; -- link to DP
        Xexit_98_block : Block -- non-trivial join transition branch_block_stmt_5/loopback_PhiReq/$exit 
          signal Xexit_98_predecessors: BooleanArray(1 downto 0);
          signal Xexit_98_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_98_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_98_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_98_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_98_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_98_p0_pred, Xexit_98_p0_succ, Xexit_98_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_98_p0_succ(0) <=  Xexit_98_symbol;
          Xexit_98_p0_pred(0) <=  phi_stmt_7_req_99_symbol;
          Xexit_98_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_98_p1_pred, Xexit_98_p1_succ, Xexit_98_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_98_p1_succ(0) <=  Xexit_98_symbol;
          Xexit_98_p1_pred(0) <=  phi_stmt_11_req_100_symbol;
          Xexit_98_symbol <= AndReduce(Xexit_98_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_5/loopback_PhiReq/$exit
        loopback_PhiReq_96_symbol <= Xexit_98_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/loopback_PhiReq
      merge_stmt_6_PhiReqMerge_101_symbol  <=  branch_block_stmt_5_x_xentry_x_xx_xPhiReq_91_symbol or loopback_PhiReq_96_symbol; -- place branch_block_stmt_5/merge_stmt_6_PhiReqMerge (optimized away) 
      merge_stmt_6_PhiAck_102: Block -- branch_block_stmt_5/merge_stmt_6_PhiAck 
        signal merge_stmt_6_PhiAck_102_start: Boolean;
        signal Xentry_103_symbol: Boolean;
        signal Xexit_104_symbol: Boolean;
        signal phi_stmt_7_ack_105_symbol : Boolean;
        signal phi_stmt_11_ack_106_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_6_PhiAck_102_start <= merge_stmt_6_PhiReqMerge_101_symbol; -- control passed to block
        Xentry_103_symbol  <= merge_stmt_6_PhiAck_102_start; -- transition branch_block_stmt_5/merge_stmt_6_PhiAck/$entry
        phi_stmt_7_ack_105_symbol <= branch_block_stmt_5Xmerge_stmt_6_PhiAckXphi_stmt_7_ack_dp_to_cp; -- transition branch_block_stmt_5/merge_stmt_6_PhiAck/phi_stmt_7_ack
        phi_stmt_11_ack_106_symbol <= branch_block_stmt_5Xmerge_stmt_6_PhiAckXphi_stmt_11_ack_dp_to_cp; -- transition branch_block_stmt_5/merge_stmt_6_PhiAck/phi_stmt_11_ack
        Xexit_104_block : Block -- non-trivial join transition branch_block_stmt_5/merge_stmt_6_PhiAck/$exit 
          signal Xexit_104_predecessors: BooleanArray(1 downto 0);
          signal Xexit_104_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_104_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_104_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_104_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_104_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_104_p0_pred, Xexit_104_p0_succ, Xexit_104_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_104_p0_succ(0) <=  Xexit_104_symbol;
          Xexit_104_p0_pred(0) <=  phi_stmt_7_ack_105_symbol;
          Xexit_104_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_104_p1_pred, Xexit_104_p1_succ, Xexit_104_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_104_p1_succ(0) <=  Xexit_104_symbol;
          Xexit_104_p1_pred(0) <=  phi_stmt_11_ack_106_symbol;
          Xexit_104_symbol <= AndReduce(Xexit_104_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_5/merge_stmt_6_PhiAck/$exit
        merge_stmt_6_PhiAck_102_symbol <= Xexit_104_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_5/merge_stmt_6_PhiAck
      Xexit_5_symbol <= branch_block_stmt_5_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_5/$exit
      branch_block_stmt_5_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_5
    assign_stmt_42_107: Block -- assign_stmt_42 
      signal assign_stmt_42_107_start: Boolean;
      signal Xentry_108_symbol: Boolean;
      signal Xexit_109_symbol: Boolean;
      signal req_110_symbol : Boolean;
      signal ack_111_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_42_107_start <= branch_block_stmt_5_3_symbol; -- control passed to block
      Xentry_108_symbol  <= assign_stmt_42_107_start; -- transition assign_stmt_42/$entry
      req_110_symbol <= Xentry_108_symbol; -- transition assign_stmt_42/req
      assign_stmt_42Xreq_cp_to_dp <= req_110_symbol; -- link to DP
      ack_111_symbol <= assign_stmt_42Xack_dp_to_cp; -- transition assign_stmt_42/ack
      Xexit_109_symbol <= ack_111_symbol; -- transition assign_stmt_42/$exit
      assign_stmt_42_107_symbol <= Xexit_109_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_42
    assign_stmt_45_112: Block -- assign_stmt_45 
      signal assign_stmt_45_112_start: Boolean;
      signal Xentry_113_symbol: Boolean;
      signal Xexit_114_symbol: Boolean;
      signal req_115_symbol : Boolean;
      signal ack_116_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_45_112_start <= assign_stmt_42_107_symbol; -- control passed to block
      Xentry_113_symbol  <= assign_stmt_45_112_start; -- transition assign_stmt_45/$entry
      req_115_symbol <= Xentry_113_symbol; -- transition assign_stmt_45/req
      assign_stmt_45Xreq_cp_to_dp <= req_115_symbol; -- link to DP
      ack_116_symbol <= assign_stmt_45Xack_dp_to_cp; -- transition assign_stmt_45/ack
      Xexit_114_symbol <= ack_116_symbol; -- transition assign_stmt_45/$exit
      assign_stmt_45_112_symbol <= Xexit_114_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_45
    Xexit_2_symbol <= assign_stmt_45_112_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal expr_13_wire_constant : std_logic_vector(9 downto 0);
    signal expr_18_wire_constant : std_logic_vector(9 downto 0);
    signal expr_23_wire_constant : std_logic_vector(9 downto 0);
    signal expr_28_wire_constant : std_logic_vector(9 downto 0);
    signal expr_28_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_31_wire_constant : std_logic_vector(9 downto 0);
    signal expr_31_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_34_wire_constant : std_logic_vector(9 downto 0);
    signal expr_34_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal loop_counter_7 : std_logic_vector(9 downto 0);
    signal new_loop_counter_20 : std_logic_vector(9 downto 0);
    signal t_25 : std_logic_vector(9 downto 0);
    signal temp_t_11 : std_logic_vector(9 downto 0);
    -- 
  begin -- 
    expr_13_wire_constant <= "0000000000";
    expr_18_wire_constant <= "0000000001";
    expr_23_wire_constant <= "0000000001";
    expr_28_wire_constant <= "0000000001";
    expr_31_wire_constant <= "0000000010";
    expr_34_wire_constant <= "0000000011";
    phi_stmt_11: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_13_wire_constant & t_25;
      req <= branch_block_stmt_5Xbranch_block_stmt_5_x_xentry_x_xx_xPhiReqXphi_stmt_11_req_cp_to_dp & branch_block_stmt_5Xloopback_PhiReqXphi_stmt_11_req_cp_to_dp;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => branch_block_stmt_5Xmerge_stmt_6_PhiAckXphi_stmt_11_ack_dp_to_cp,
          idata => idata,
          odata => temp_t_11,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_11
    phi_stmt_7: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a & new_loop_counter_20;
      req <= branch_block_stmt_5Xbranch_block_stmt_5_x_xentry_x_xx_xPhiReqXphi_stmt_7_req_cp_to_dp & branch_block_stmt_5Xloopback_PhiReqXphi_stmt_7_req_cp_to_dp;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => branch_block_stmt_5Xmerge_stmt_6_PhiAckXphi_stmt_7_ack_dp_to_cp,
          idata => idata,
          odata => loop_counter_7,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_7
    simple_obj_ref_40_inst: RegisterBase generic map(in_data_width => 10,out_data_width => 10) -- 
      port map( din => t_25, dout => b, req => assign_stmt_42Xreq_cp_to_dp, ack => assign_stmt_42Xack_dp_to_cp, clk => clk, reset => reset); -- 
    simple_obj_ref_43_inst: RegisterBase generic map(in_data_width => 10,out_data_width => 10) -- 
      port map( din => t_25, dout => c, req => assign_stmt_45Xreq_cp_to_dp, ack => assign_stmt_45Xack_dp_to_cp, clk => clk, reset => reset); -- 
    switch_stmt_26_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_28_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xcmp_cp_to_dp,
          ack0 => open,
          ack1 => branch_block_stmt_5Xswitch_stmt_26_choice_0Xack1_dp_to_cp,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_26_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_31_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xcmp_cp_to_dp,
          ack0 => open,
          ack1 => branch_block_stmt_5Xswitch_stmt_26_choice_1Xack1_dp_to_cp,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_26_branch_2: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_34_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xcmp_cp_to_dp,
          ack0 => open,
          ack1 => branch_block_stmt_5Xswitch_stmt_26_choice_2Xack1_dp_to_cp,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_26_branch_default_x: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(2 downto 0);
      begin 
      condition_sig <= expr_28_wire_constant_cmp & expr_31_wire_constant_cmp & expr_34_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 3)
        port map( -- 
          condition => condition_sig,
          req => branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXXexit_cp_to_dp,
          ack0 => branch_block_stmt_5Xswitch_stmt_26_choice_defaultXack0_dp_to_cp,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_19_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= branch_block_stmt_5Xassign_stmt_20Xbinary_19Xrr_cp_to_dp;
      branch_block_stmt_5Xassign_stmt_20Xbinary_19Xra_dp_to_cp <= ackL(0);
      reqR(0) <= branch_block_stmt_5Xassign_stmt_20Xbinary_19Xcr_cp_to_dp;
      branch_block_stmt_5Xassign_stmt_20Xbinary_19Xca_dp_to_cp <= ackR(0);
      data_in <= loop_counter_7;
      new_loop_counter_20 <= data_out(9 downto 0);
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
          num_reqs => 1--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_24_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= branch_block_stmt_5Xassign_stmt_25Xbinary_24Xrr_cp_to_dp;
      branch_block_stmt_5Xassign_stmt_25Xbinary_24Xra_dp_to_cp <= ackL(0);
      reqR(0) <= branch_block_stmt_5Xassign_stmt_25Xbinary_24Xcr_cp_to_dp;
      branch_block_stmt_5Xassign_stmt_25Xbinary_24Xca_dp_to_cp <= ackR(0);
      data_in <= temp_t_11;
      t_25 <= data_out(9 downto 0);
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
          num_reqs => 1--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : switch_stmt_26_select_expr_0 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xrr_cp_to_dp;
      branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xra_dp_to_cp <= ackL(0);
      reqR(0) <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xcr_cp_to_dp;
      branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_0Xca_dp_to_cp <= ackR(0);
      data_in <= new_loop_counter_20;
      expr_28_wire_constant_cmp <= data_out(0 downto 0);
      SplitOperator: SplitOperatorShared -- 
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
          no_arbitration => true, 
          num_reqs => 1--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : switch_stmt_26_select_expr_1 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xrr_cp_to_dp;
      branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xra_dp_to_cp <= ackL(0);
      reqR(0) <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xcr_cp_to_dp;
      branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_1Xca_dp_to_cp <= ackR(0);
      data_in <= new_loop_counter_20;
      expr_31_wire_constant_cmp <= data_out(0 downto 0);
      SplitOperator: SplitOperatorShared -- 
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
          no_arbitration => true, 
          num_reqs => 1--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : switch_stmt_26_select_expr_2 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xrr_cp_to_dp;
      branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xra_dp_to_cp <= ackL(0);
      reqR(0) <= branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xcr_cp_to_dp;
      branch_block_stmt_5Xswitch_stmt_26_x_xcondition_check_x_xXcondition_2Xca_dp_to_cp <= ackR(0);
      data_in <= new_loop_counter_20;
      expr_34_wire_constant_cmp <= data_out(0 downto 0);
      SplitOperator: SplitOperatorShared -- 
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
          no_arbitration => true, 
          num_reqs => 1--
        ) -- 
      port map ( reqL => reqL , ackL => ackL, reqR => reqR, ackR => ackR, dataL => data_in, dataR => data_out, clk => clk, reset => reset);
      -- 
    end Block; -- split operator group 4
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
    sum_mod_c : out  std_logic_vector(9 downto 0);
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
      c : out  std_logic_vector(9 downto 0);
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
      c => sum_mod_c,
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
      sum_mod_c : out  std_logic_vector(9 downto 0);
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
  signal sum_mod_a :  std_logic_vector(9 downto 0);
  signal sum_mod_b :   std_logic_vector(9 downto 0);
  signal sum_mod_c :   std_logic_vector(9 downto 0);
  signal sum_mod_tag_in: std_logic_vector(0 downto 0);
  signal sum_mod_tag_out: std_logic_vector(0 downto 0);
  signal sum_mod_start : std_logic := '0';
  signal sum_mod_fin   : std_logic := '0';
  -- 
begin --
  clk <= not clk after 5 ns;
  sum_mod_a <= (1 => '1', 0 => '1', others => '0');
  process
  begin
	wait until clk = '1';
	reset <= '0'; 
	sum_mod_start <= '1';
	wait until clk = '1';
	sum_mod_start <= '0';
	while sum_mod_fin /= '1' loop
		wait until clk = '1';
	end loop;
  	wait;
  end process;

  test_system_instance: test_system -- 
    port map ( -- 
      sum_mod_a => sum_mod_a,
      sum_mod_b => sum_mod_b,
      sum_mod_c => sum_mod_c,
      sum_mod_tag_in => sum_mod_tag_in,
      sum_mod_tag_out => sum_mod_tag_out,
      sum_mod_start => sum_mod_start,
      sum_mod_fin  => sum_mod_fin ,
      clk => clk,
      reset => reset); -- 
  -- 
end Default;
