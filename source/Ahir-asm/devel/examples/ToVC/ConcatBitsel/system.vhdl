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
    b : in  std_logic_vector(9 downto 0);
    aXb : out  std_logic_vector(19 downto 0);
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
  signal binary_55_inst_req_0 : boolean;
  signal binary_55_inst_ack_0 : boolean;
  signal binary_55_inst_req_1 : boolean;
  signal binary_45_inst_req_0 : boolean;
  signal binary_45_inst_ack_0 : boolean;
  signal binary_45_inst_req_1 : boolean;
  signal binary_45_inst_ack_1 : boolean;
  signal binary_50_inst_req_0 : boolean;
  signal binary_50_inst_ack_0 : boolean;
  signal binary_50_inst_req_1 : boolean;
  signal binary_50_inst_ack_1 : boolean;
  signal binary_52_inst_req_0 : boolean;
  signal binary_52_inst_ack_0 : boolean;
  signal binary_52_inst_req_1 : boolean;
  signal binary_52_inst_ack_1 : boolean;
  signal binary_55_inst_ack_1 : boolean;
  signal binary_57_inst_req_0 : boolean;
  signal binary_57_inst_ack_0 : boolean;
  signal binary_57_inst_req_1 : boolean;
  signal binary_57_inst_ack_1 : boolean;
  signal ternary_58_inst_req_0 : boolean;
  signal ternary_58_inst_ack_0 : boolean;
  signal binary_60_inst_req_0 : boolean;
  signal binary_60_inst_ack_0 : boolean;
  signal binary_60_inst_req_1 : boolean;
  signal binary_60_inst_ack_1 : boolean;
  signal binary_62_inst_req_0 : boolean;
  signal binary_62_inst_ack_0 : boolean;
  signal binary_62_inst_req_1 : boolean;
  signal binary_48_inst_req_0 : boolean;
  signal binary_48_inst_ack_0 : boolean;
  signal binary_48_inst_req_1 : boolean;
  signal binary_48_inst_ack_1 : boolean;
  signal binary_62_inst_ack_1 : boolean;
  signal binary_64_inst_req_0 : boolean;
  signal binary_64_inst_ack_0 : boolean;
  signal binary_64_inst_req_1 : boolean;
  signal binary_64_inst_ack_1 : boolean;
  signal type_cast_68_inst_req_0 : boolean;
  signal type_cast_68_inst_ack_0 : boolean;
  signal binary_75_inst_req_0 : boolean;
  signal binary_75_inst_ack_0 : boolean;
  signal binary_75_inst_req_1 : boolean;
  signal binary_75_inst_ack_1 : boolean;
  signal binary_78_inst_req_0 : boolean;
  signal binary_78_inst_ack_0 : boolean;
  signal binary_78_inst_req_1 : boolean;
  signal binary_78_inst_ack_1 : boolean;
  signal binary_80_inst_req_0 : boolean;
  signal binary_80_inst_ack_0 : boolean;
  signal binary_80_inst_req_1 : boolean;
  signal binary_80_inst_ack_1 : boolean;
  signal binary_82_inst_req_0 : boolean;
  signal binary_82_inst_ack_0 : boolean;
  signal binary_82_inst_req_1 : boolean;
  signal binary_82_inst_ack_1 : boolean;
  signal binary_85_inst_req_0 : boolean;
  signal binary_85_inst_ack_0 : boolean;
  signal binary_85_inst_req_1 : boolean;
  signal binary_85_inst_ack_1 : boolean;
  signal binary_87_inst_req_0 : boolean;
  signal binary_87_inst_ack_0 : boolean;
  signal binary_87_inst_req_1 : boolean;
  signal binary_87_inst_ack_1 : boolean;
  signal ternary_88_inst_req_0 : boolean;
  signal ternary_88_inst_ack_0 : boolean;
  signal binary_93_inst_req_0 : boolean;
  signal binary_93_inst_ack_0 : boolean;
  signal binary_93_inst_req_1 : boolean;
  signal binary_93_inst_ack_1 : boolean;
  signal type_cast_94_inst_req_0 : boolean;
  signal type_cast_94_inst_ack_0 : boolean;
  signal binary_100_inst_req_0 : boolean;
  signal binary_100_inst_ack_0 : boolean;
  signal binary_100_inst_req_1 : boolean;
  signal binary_100_inst_ack_1 : boolean;
  signal binary_105_inst_req_0 : boolean;
  signal binary_105_inst_ack_0 : boolean;
  signal binary_105_inst_req_1 : boolean;
  signal binary_105_inst_ack_1 : boolean;
  signal binary_111_inst_req_0 : boolean;
  signal binary_111_inst_ack_0 : boolean;
  signal binary_111_inst_req_1 : boolean;
  signal binary_111_inst_ack_1 : boolean;
  signal if_stmt_108_branch_req_0 : boolean;
  signal if_stmt_108_branch_ack_1 : boolean;
  signal if_stmt_108_branch_ack_0 : boolean;
  signal phi_stmt_23_req_0 : boolean;
  signal phi_stmt_27_req_0 : boolean;
  signal phi_stmt_31_req_0 : boolean;
  signal phi_stmt_35_req_0 : boolean;
  signal phi_stmt_23_req_1 : boolean;
  signal phi_stmt_27_req_1 : boolean;
  signal phi_stmt_31_req_1 : boolean;
  signal phi_stmt_35_req_1 : boolean;
  signal phi_stmt_23_ack_0 : boolean;
  signal phi_stmt_27_ack_0 : boolean;
  signal phi_stmt_31_ack_0 : boolean;
  signal phi_stmt_35_ack_0 : boolean;
  signal binary_120_inst_req_0 : boolean;
  signal binary_120_inst_ack_0 : boolean;
  signal binary_120_inst_req_1 : boolean;
  signal binary_120_inst_ack_1 : boolean;
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
    signal branch_block_stmt_21_3_symbol : Boolean;
    signal assign_stmt_121_296_symbol : Boolean;
    -- 
  begin -- 
    sum_mod_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= sum_mod_CP_0_start; -- transition $entry
    branch_block_stmt_21_3: Block -- branch_block_stmt_21 
      signal branch_block_stmt_21_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_21_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_21_x_xexit_x_xx_x7_symbol : Boolean;
      signal merge_stmt_22_x_xexit_x_xx_x8_symbol : Boolean;
      signal parallel_block_stmt_40_x_xentry_x_xx_x9_symbol : Boolean;
      signal parallel_block_stmt_40_x_xexit_x_xx_x10_symbol : Boolean;
      signal if_stmt_108_x_xentry_x_xx_x11_symbol : Boolean;
      signal parallel_block_stmt_40_12_symbol : Boolean;
      signal if_stmt_108_eval_test_245_symbol : Boolean;
      signal binary_111_place_259_symbol : Boolean;
      signal if_stmt_108_if_link_260_symbol : Boolean;
      signal if_stmt_108_else_link_264_symbol : Boolean;
      signal stmt_112_x_xentry_x_xx_x268_symbol : Boolean;
      signal stmt_112_x_xexit_x_xx_x269_symbol : Boolean;
      signal stmt_112_270_symbol : Boolean;
      signal loopback_273_symbol : Boolean;
      signal branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274_symbol : Boolean;
      signal loopback_PhiReq_281_symbol : Boolean;
      signal merge_stmt_22_PhiReqMerge_288_symbol : Boolean;
      signal merge_stmt_22_PhiAck_289_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_21_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_21_3_start; -- transition branch_block_stmt_21/$entry
      branch_block_stmt_21_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_21/branch_block_stmt_21__entry__ (optimized away) 
      branch_block_stmt_21_x_xexit_x_xx_x7_symbol  <=  stmt_112_x_xexit_x_xx_x269_symbol; -- place branch_block_stmt_21/branch_block_stmt_21__exit__ (optimized away) 
      merge_stmt_22_x_xexit_x_xx_x8_symbol  <=  merge_stmt_22_PhiAck_289_symbol; -- place branch_block_stmt_21/merge_stmt_22__exit__ (optimized away) 
      parallel_block_stmt_40_x_xentry_x_xx_x9_symbol  <=  merge_stmt_22_x_xexit_x_xx_x8_symbol; -- place branch_block_stmt_21/parallel_block_stmt_40__entry__ (optimized away) 
      parallel_block_stmt_40_x_xexit_x_xx_x10_symbol  <=  parallel_block_stmt_40_12_symbol; -- place branch_block_stmt_21/parallel_block_stmt_40__exit__ (optimized away) 
      if_stmt_108_x_xentry_x_xx_x11_symbol  <=  parallel_block_stmt_40_x_xexit_x_xx_x10_symbol; -- place branch_block_stmt_21/if_stmt_108__entry__ (optimized away) 
      parallel_block_stmt_40_12: Block -- branch_block_stmt_21/parallel_block_stmt_40 
        signal parallel_block_stmt_40_12_start: Boolean;
        signal Xentry_13_symbol: Boolean;
        signal Xexit_14_symbol: Boolean;
        signal series_block_stmt_41_15_symbol : Boolean;
        signal series_block_stmt_71_127_symbol : Boolean;
        signal assign_stmt_101_219_symbol : Boolean;
        signal assign_stmt_106_232_symbol : Boolean;
        -- 
      begin -- 
        parallel_block_stmt_40_12_start <= parallel_block_stmt_40_x_xentry_x_xx_x9_symbol; -- control passed to block
        Xentry_13_symbol  <= parallel_block_stmt_40_12_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/$entry
        series_block_stmt_41_15: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41 
          signal series_block_stmt_41_15_start: Boolean;
          signal Xentry_16_symbol: Boolean;
          signal Xexit_17_symbol: Boolean;
          signal assign_stmt_65_18_symbol : Boolean;
          signal assign_stmt_69_119_symbol : Boolean;
          -- 
        begin -- 
          series_block_stmt_41_15_start <= Xentry_13_symbol; -- control passed to block
          Xentry_16_symbol  <= series_block_stmt_41_15_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/$entry
          assign_stmt_65_18: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65 
            signal assign_stmt_65_18_start: Boolean;
            signal Xentry_19_symbol: Boolean;
            signal Xexit_20_symbol: Boolean;
            signal binary_64_21_symbol : Boolean;
            -- 
          begin -- 
            assign_stmt_65_18_start <= Xentry_16_symbol; -- control passed to block
            Xentry_19_symbol  <= assign_stmt_65_18_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/$entry
            binary_64_21: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64 
              signal binary_64_21_start: Boolean;
              signal Xentry_22_symbol: Boolean;
              signal Xexit_23_symbol: Boolean;
              signal binary_64_inputs_24_symbol : Boolean;
              signal rr_115_symbol : Boolean;
              signal ra_116_symbol : Boolean;
              signal cr_117_symbol : Boolean;
              signal ca_118_symbol : Boolean;
              -- 
            begin -- 
              binary_64_21_start <= Xentry_19_symbol; -- control passed to block
              Xentry_22_symbol  <= binary_64_21_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/$entry
              binary_64_inputs_24: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs 
                signal binary_64_inputs_24_start: Boolean;
                signal Xentry_25_symbol: Boolean;
                signal Xexit_26_symbol: Boolean;
                signal binary_62_27_symbol : Boolean;
                -- 
              begin -- 
                binary_64_inputs_24_start <= Xentry_22_symbol; -- control passed to block
                Xentry_25_symbol  <= binary_64_inputs_24_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/$entry
                binary_62_27: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62 
                  signal binary_62_27_start: Boolean;
                  signal Xentry_28_symbol: Boolean;
                  signal Xexit_29_symbol: Boolean;
                  signal binary_62_inputs_30_symbol : Boolean;
                  signal rr_111_symbol : Boolean;
                  signal ra_112_symbol : Boolean;
                  signal cr_113_symbol : Boolean;
                  signal ca_114_symbol : Boolean;
                  -- 
                begin -- 
                  binary_62_27_start <= Xentry_25_symbol; -- control passed to block
                  Xentry_28_symbol  <= binary_62_27_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/$entry
                  binary_62_inputs_30: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs 
                    signal binary_62_inputs_30_start: Boolean;
                    signal Xentry_31_symbol: Boolean;
                    signal Xexit_32_symbol: Boolean;
                    signal binary_60_33_symbol : Boolean;
                    -- 
                  begin -- 
                    binary_62_inputs_30_start <= Xentry_28_symbol; -- control passed to block
                    Xentry_31_symbol  <= binary_62_inputs_30_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/$entry
                    binary_60_33: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60 
                      signal binary_60_33_start: Boolean;
                      signal Xentry_34_symbol: Boolean;
                      signal Xexit_35_symbol: Boolean;
                      signal binary_60_inputs_36_symbol : Boolean;
                      signal rr_107_symbol : Boolean;
                      signal ra_108_symbol : Boolean;
                      signal cr_109_symbol : Boolean;
                      signal ca_110_symbol : Boolean;
                      -- 
                    begin -- 
                      binary_60_33_start <= Xentry_31_symbol; -- control passed to block
                      Xentry_34_symbol  <= binary_60_33_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/$entry
                      binary_60_inputs_36: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs 
                        signal binary_60_inputs_36_start: Boolean;
                        signal Xentry_37_symbol: Boolean;
                        signal Xexit_38_symbol: Boolean;
                        signal ternary_58_39_symbol : Boolean;
                        -- 
                      begin -- 
                        binary_60_inputs_36_start <= Xentry_34_symbol; -- control passed to block
                        Xentry_37_symbol  <= binary_60_inputs_36_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/$entry
                        ternary_58_39: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58 
                          signal ternary_58_39_start: Boolean;
                          signal Xentry_40_symbol: Boolean;
                          signal Xexit_41_symbol: Boolean;
                          signal ternary_58_inputs_42_symbol : Boolean;
                          signal req_105_symbol : Boolean;
                          signal ack_106_symbol : Boolean;
                          -- 
                        begin -- 
                          ternary_58_39_start <= Xentry_37_symbol; -- control passed to block
                          Xentry_40_symbol  <= ternary_58_39_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/$entry
                          ternary_58_inputs_42: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs 
                            signal ternary_58_inputs_42_start: Boolean;
                            signal Xentry_43_symbol: Boolean;
                            signal Xexit_44_symbol: Boolean;
                            signal binary_45_45_symbol : Boolean;
                            signal binary_52_55_symbol : Boolean;
                            signal binary_57_85_symbol : Boolean;
                            -- 
                          begin -- 
                            ternary_58_inputs_42_start <= Xentry_40_symbol; -- control passed to block
                            Xentry_43_symbol  <= ternary_58_inputs_42_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/$entry
                            binary_45_45: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45 
                              signal binary_45_45_start: Boolean;
                              signal Xentry_46_symbol: Boolean;
                              signal Xexit_47_symbol: Boolean;
                              signal binary_45_inputs_48_symbol : Boolean;
                              signal rr_51_symbol : Boolean;
                              signal ra_52_symbol : Boolean;
                              signal cr_53_symbol : Boolean;
                              signal ca_54_symbol : Boolean;
                              -- 
                            begin -- 
                              binary_45_45_start <= Xentry_43_symbol; -- control passed to block
                              Xentry_46_symbol  <= binary_45_45_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/$entry
                              binary_45_inputs_48: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/binary_45_inputs 
                                signal binary_45_inputs_48_start: Boolean;
                                signal Xentry_49_symbol: Boolean;
                                signal Xexit_50_symbol: Boolean;
                                -- 
                              begin -- 
                                binary_45_inputs_48_start <= Xentry_46_symbol; -- control passed to block
                                Xentry_49_symbol  <= binary_45_inputs_48_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/binary_45_inputs/$entry
                                Xexit_50_symbol <= Xentry_49_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/binary_45_inputs/$exit
                                binary_45_inputs_48_symbol <= Xexit_50_symbol; -- control passed from block 
                                -- 
                              end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/binary_45_inputs
                              rr_51_symbol <= binary_45_inputs_48_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/rr
                              binary_45_inst_req_0 <= rr_51_symbol; -- link to DP
                              ra_52_symbol <= binary_45_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/ra
                              cr_53_symbol <= ra_52_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/cr
                              binary_45_inst_req_1 <= cr_53_symbol; -- link to DP
                              ca_54_symbol <= binary_45_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/ca
                              Xexit_47_symbol <= ca_54_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45/$exit
                              binary_45_45_symbol <= Xexit_47_symbol; -- control passed from block 
                              -- 
                            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_45
                            binary_52_55: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52 
                              signal binary_52_55_start: Boolean;
                              signal Xentry_56_symbol: Boolean;
                              signal Xexit_57_symbol: Boolean;
                              signal binary_52_inputs_58_symbol : Boolean;
                              signal rr_81_symbol : Boolean;
                              signal ra_82_symbol : Boolean;
                              signal cr_83_symbol : Boolean;
                              signal ca_84_symbol : Boolean;
                              -- 
                            begin -- 
                              binary_52_55_start <= Xentry_43_symbol; -- control passed to block
                              Xentry_56_symbol  <= binary_52_55_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/$entry
                              binary_52_inputs_58: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs 
                                signal binary_52_inputs_58_start: Boolean;
                                signal Xentry_59_symbol: Boolean;
                                signal Xexit_60_symbol: Boolean;
                                signal binary_50_61_symbol : Boolean;
                                -- 
                              begin -- 
                                binary_52_inputs_58_start <= Xentry_56_symbol; -- control passed to block
                                Xentry_59_symbol  <= binary_52_inputs_58_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/$entry
                                binary_50_61: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50 
                                  signal binary_50_61_start: Boolean;
                                  signal Xentry_62_symbol: Boolean;
                                  signal Xexit_63_symbol: Boolean;
                                  signal binary_50_inputs_64_symbol : Boolean;
                                  signal rr_77_symbol : Boolean;
                                  signal ra_78_symbol : Boolean;
                                  signal cr_79_symbol : Boolean;
                                  signal ca_80_symbol : Boolean;
                                  -- 
                                begin -- 
                                  binary_50_61_start <= Xentry_59_symbol; -- control passed to block
                                  Xentry_62_symbol  <= binary_50_61_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/$entry
                                  binary_50_inputs_64: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs 
                                    signal binary_50_inputs_64_start: Boolean;
                                    signal Xentry_65_symbol: Boolean;
                                    signal Xexit_66_symbol: Boolean;
                                    signal binary_48_67_symbol : Boolean;
                                    -- 
                                  begin -- 
                                    binary_50_inputs_64_start <= Xentry_62_symbol; -- control passed to block
                                    Xentry_65_symbol  <= binary_50_inputs_64_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/$entry
                                    binary_48_67: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48 
                                      signal binary_48_67_start: Boolean;
                                      signal Xentry_68_symbol: Boolean;
                                      signal Xexit_69_symbol: Boolean;
                                      signal binary_48_inputs_70_symbol : Boolean;
                                      signal rr_73_symbol : Boolean;
                                      signal ra_74_symbol : Boolean;
                                      signal cr_75_symbol : Boolean;
                                      signal ca_76_symbol : Boolean;
                                      -- 
                                    begin -- 
                                      binary_48_67_start <= Xentry_65_symbol; -- control passed to block
                                      Xentry_68_symbol  <= binary_48_67_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/$entry
                                      binary_48_inputs_70: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/binary_48_inputs 
                                        signal binary_48_inputs_70_start: Boolean;
                                        signal Xentry_71_symbol: Boolean;
                                        signal Xexit_72_symbol: Boolean;
                                        -- 
                                      begin -- 
                                        binary_48_inputs_70_start <= Xentry_68_symbol; -- control passed to block
                                        Xentry_71_symbol  <= binary_48_inputs_70_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/binary_48_inputs/$entry
                                        Xexit_72_symbol <= Xentry_71_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/binary_48_inputs/$exit
                                        binary_48_inputs_70_symbol <= Xexit_72_symbol; -- control passed from block 
                                        -- 
                                      end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/binary_48_inputs
                                      rr_73_symbol <= binary_48_inputs_70_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/rr
                                      binary_48_inst_req_0 <= rr_73_symbol; -- link to DP
                                      ra_74_symbol <= binary_48_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/ra
                                      cr_75_symbol <= ra_74_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/cr
                                      binary_48_inst_req_1 <= cr_75_symbol; -- link to DP
                                      ca_76_symbol <= binary_48_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/ca
                                      Xexit_69_symbol <= ca_76_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48/$exit
                                      binary_48_67_symbol <= Xexit_69_symbol; -- control passed from block 
                                      -- 
                                    end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/binary_48
                                    Xexit_66_symbol <= binary_48_67_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs/$exit
                                    binary_50_inputs_64_symbol <= Xexit_66_symbol; -- control passed from block 
                                    -- 
                                  end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/binary_50_inputs
                                  rr_77_symbol <= binary_50_inputs_64_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/rr
                                  binary_50_inst_req_0 <= rr_77_symbol; -- link to DP
                                  ra_78_symbol <= binary_50_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/ra
                                  cr_79_symbol <= ra_78_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/cr
                                  binary_50_inst_req_1 <= cr_79_symbol; -- link to DP
                                  ca_80_symbol <= binary_50_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/ca
                                  Xexit_63_symbol <= ca_80_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50/$exit
                                  binary_50_61_symbol <= Xexit_63_symbol; -- control passed from block 
                                  -- 
                                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/binary_50
                                Xexit_60_symbol <= binary_50_61_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs/$exit
                                binary_52_inputs_58_symbol <= Xexit_60_symbol; -- control passed from block 
                                -- 
                              end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/binary_52_inputs
                              rr_81_symbol <= binary_52_inputs_58_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/rr
                              binary_52_inst_req_0 <= rr_81_symbol; -- link to DP
                              ra_82_symbol <= binary_52_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/ra
                              cr_83_symbol <= ra_82_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/cr
                              binary_52_inst_req_1 <= cr_83_symbol; -- link to DP
                              ca_84_symbol <= binary_52_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/ca
                              Xexit_57_symbol <= ca_84_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52/$exit
                              binary_52_55_symbol <= Xexit_57_symbol; -- control passed from block 
                              -- 
                            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_52
                            binary_57_85: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57 
                              signal binary_57_85_start: Boolean;
                              signal Xentry_86_symbol: Boolean;
                              signal Xexit_87_symbol: Boolean;
                              signal binary_57_inputs_88_symbol : Boolean;
                              signal rr_101_symbol : Boolean;
                              signal ra_102_symbol : Boolean;
                              signal cr_103_symbol : Boolean;
                              signal ca_104_symbol : Boolean;
                              -- 
                            begin -- 
                              binary_57_85_start <= Xentry_43_symbol; -- control passed to block
                              Xentry_86_symbol  <= binary_57_85_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/$entry
                              binary_57_inputs_88: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs 
                                signal binary_57_inputs_88_start: Boolean;
                                signal Xentry_89_symbol: Boolean;
                                signal Xexit_90_symbol: Boolean;
                                signal binary_55_91_symbol : Boolean;
                                -- 
                              begin -- 
                                binary_57_inputs_88_start <= Xentry_86_symbol; -- control passed to block
                                Xentry_89_symbol  <= binary_57_inputs_88_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/$entry
                                binary_55_91: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55 
                                  signal binary_55_91_start: Boolean;
                                  signal Xentry_92_symbol: Boolean;
                                  signal Xexit_93_symbol: Boolean;
                                  signal binary_55_inputs_94_symbol : Boolean;
                                  signal rr_97_symbol : Boolean;
                                  signal ra_98_symbol : Boolean;
                                  signal cr_99_symbol : Boolean;
                                  signal ca_100_symbol : Boolean;
                                  -- 
                                begin -- 
                                  binary_55_91_start <= Xentry_89_symbol; -- control passed to block
                                  Xentry_92_symbol  <= binary_55_91_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/$entry
                                  binary_55_inputs_94: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/binary_55_inputs 
                                    signal binary_55_inputs_94_start: Boolean;
                                    signal Xentry_95_symbol: Boolean;
                                    signal Xexit_96_symbol: Boolean;
                                    -- 
                                  begin -- 
                                    binary_55_inputs_94_start <= Xentry_92_symbol; -- control passed to block
                                    Xentry_95_symbol  <= binary_55_inputs_94_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/binary_55_inputs/$entry
                                    Xexit_96_symbol <= Xentry_95_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/binary_55_inputs/$exit
                                    binary_55_inputs_94_symbol <= Xexit_96_symbol; -- control passed from block 
                                    -- 
                                  end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/binary_55_inputs
                                  rr_97_symbol <= binary_55_inputs_94_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/rr
                                  binary_55_inst_req_0 <= rr_97_symbol; -- link to DP
                                  ra_98_symbol <= binary_55_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/ra
                                  cr_99_symbol <= ra_98_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/cr
                                  binary_55_inst_req_1 <= cr_99_symbol; -- link to DP
                                  ca_100_symbol <= binary_55_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/ca
                                  Xexit_93_symbol <= ca_100_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55/$exit
                                  binary_55_91_symbol <= Xexit_93_symbol; -- control passed from block 
                                  -- 
                                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/binary_55
                                Xexit_90_symbol <= binary_55_91_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs/$exit
                                binary_57_inputs_88_symbol <= Xexit_90_symbol; -- control passed from block 
                                -- 
                              end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/binary_57_inputs
                              rr_101_symbol <= binary_57_inputs_88_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/rr
                              binary_57_inst_req_0 <= rr_101_symbol; -- link to DP
                              ra_102_symbol <= binary_57_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/ra
                              cr_103_symbol <= ra_102_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/cr
                              binary_57_inst_req_1 <= cr_103_symbol; -- link to DP
                              ca_104_symbol <= binary_57_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/ca
                              Xexit_87_symbol <= ca_104_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57/$exit
                              binary_57_85_symbol <= Xexit_87_symbol; -- control passed from block 
                              -- 
                            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/binary_57
                            Xexit_44_block : Block -- non-trivial join transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/$exit 
                              signal Xexit_44_predecessors: BooleanArray(2 downto 0);
                              signal Xexit_44_p0_pred: BooleanArray(0 downto 0);
                              signal Xexit_44_p0_succ: BooleanArray(0 downto 0);
                              signal Xexit_44_p1_pred: BooleanArray(0 downto 0);
                              signal Xexit_44_p1_succ: BooleanArray(0 downto 0);
                              signal Xexit_44_p2_pred: BooleanArray(0 downto 0);
                              signal Xexit_44_p2_succ: BooleanArray(0 downto 0);
                              -- 
                            begin -- 
                              Xexit_44_0_place: Place -- 
                                generic map(marking => false)
                                port map( -- 
                                  Xexit_44_p0_pred, Xexit_44_p0_succ, Xexit_44_predecessors(0), clk, reset-- 
                                ); -- 
                              Xexit_44_p0_succ(0) <=  Xexit_44_symbol;
                              Xexit_44_p0_pred(0) <=  binary_45_45_symbol;
                              Xexit_44_1_place: Place -- 
                                generic map(marking => false)
                                port map( -- 
                                  Xexit_44_p1_pred, Xexit_44_p1_succ, Xexit_44_predecessors(1), clk, reset-- 
                                ); -- 
                              Xexit_44_p1_succ(0) <=  Xexit_44_symbol;
                              Xexit_44_p1_pred(0) <=  binary_52_55_symbol;
                              Xexit_44_2_place: Place -- 
                                generic map(marking => false)
                                port map( -- 
                                  Xexit_44_p2_pred, Xexit_44_p2_succ, Xexit_44_predecessors(2), clk, reset-- 
                                ); -- 
                              Xexit_44_p2_succ(0) <=  Xexit_44_symbol;
                              Xexit_44_p2_pred(0) <=  binary_57_85_symbol;
                              Xexit_44_symbol <= AndReduce(Xexit_44_predecessors); 
                              -- 
                            end Block; -- non-trivial join transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs/$exit
                            ternary_58_inputs_42_symbol <= Xexit_44_symbol; -- control passed from block 
                            -- 
                          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ternary_58_inputs
                          req_105_symbol <= ternary_58_inputs_42_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/req
                          ternary_58_inst_req_0 <= req_105_symbol; -- link to DP
                          ack_106_symbol <= ternary_58_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/ack
                          Xexit_41_symbol <= ack_106_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58/$exit
                          ternary_58_39_symbol <= Xexit_41_symbol; -- control passed from block 
                          -- 
                        end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/ternary_58
                        Xexit_38_symbol <= ternary_58_39_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs/$exit
                        binary_60_inputs_36_symbol <= Xexit_38_symbol; -- control passed from block 
                        -- 
                      end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/binary_60_inputs
                      rr_107_symbol <= binary_60_inputs_36_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/rr
                      binary_60_inst_req_0 <= rr_107_symbol; -- link to DP
                      ra_108_symbol <= binary_60_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/ra
                      cr_109_symbol <= ra_108_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/cr
                      binary_60_inst_req_1 <= cr_109_symbol; -- link to DP
                      ca_110_symbol <= binary_60_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/ca
                      Xexit_35_symbol <= ca_110_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60/$exit
                      binary_60_33_symbol <= Xexit_35_symbol; -- control passed from block 
                      -- 
                    end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/binary_60
                    Xexit_32_symbol <= binary_60_33_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs/$exit
                    binary_62_inputs_30_symbol <= Xexit_32_symbol; -- control passed from block 
                    -- 
                  end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/binary_62_inputs
                  rr_111_symbol <= binary_62_inputs_30_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/rr
                  binary_62_inst_req_0 <= rr_111_symbol; -- link to DP
                  ra_112_symbol <= binary_62_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/ra
                  cr_113_symbol <= ra_112_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/cr
                  binary_62_inst_req_1 <= cr_113_symbol; -- link to DP
                  ca_114_symbol <= binary_62_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/ca
                  Xexit_29_symbol <= ca_114_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62/$exit
                  binary_62_27_symbol <= Xexit_29_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/binary_62
                Xexit_26_symbol <= binary_62_27_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs/$exit
                binary_64_inputs_24_symbol <= Xexit_26_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/binary_64_inputs
              rr_115_symbol <= binary_64_inputs_24_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/rr
              binary_64_inst_req_0 <= rr_115_symbol; -- link to DP
              ra_116_symbol <= binary_64_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/ra
              cr_117_symbol <= ra_116_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/cr
              binary_64_inst_req_1 <= cr_117_symbol; -- link to DP
              ca_118_symbol <= binary_64_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/ca
              Xexit_23_symbol <= ca_118_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64/$exit
              binary_64_21_symbol <= Xexit_23_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/binary_64
            Xexit_20_symbol <= binary_64_21_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65/$exit
            assign_stmt_65_18_symbol <= Xexit_20_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_65
          assign_stmt_69_119: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69 
            signal assign_stmt_69_119_start: Boolean;
            signal Xentry_120_symbol: Boolean;
            signal Xexit_121_symbol: Boolean;
            signal type_cast_68_122_symbol : Boolean;
            -- 
          begin -- 
            assign_stmt_69_119_start <= assign_stmt_65_18_symbol; -- control passed to block
            Xentry_120_symbol  <= assign_stmt_69_119_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/$entry
            type_cast_68_122: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/type_cast_68 
              signal type_cast_68_122_start: Boolean;
              signal Xentry_123_symbol: Boolean;
              signal Xexit_124_symbol: Boolean;
              signal req_125_symbol : Boolean;
              signal ack_126_symbol : Boolean;
              -- 
            begin -- 
              type_cast_68_122_start <= Xentry_120_symbol; -- control passed to block
              Xentry_123_symbol  <= type_cast_68_122_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/type_cast_68/$entry
              req_125_symbol <= Xentry_123_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/type_cast_68/req
              type_cast_68_inst_req_0 <= req_125_symbol; -- link to DP
              ack_126_symbol <= type_cast_68_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/type_cast_68/ack
              Xexit_124_symbol <= ack_126_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/type_cast_68/$exit
              type_cast_68_122_symbol <= Xexit_124_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/type_cast_68
            Xexit_121_symbol <= type_cast_68_122_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69/$exit
            assign_stmt_69_119_symbol <= Xexit_121_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/assign_stmt_69
          Xexit_17_symbol <= assign_stmt_69_119_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41/$exit
          series_block_stmt_41_15_symbol <= Xexit_17_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_41
        series_block_stmt_71_127: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71 
          signal series_block_stmt_71_127_start: Boolean;
          signal Xentry_128_symbol: Boolean;
          signal Xexit_129_symbol: Boolean;
          signal assign_stmt_89_130_symbol : Boolean;
          signal assign_stmt_95_201_symbol : Boolean;
          -- 
        begin -- 
          series_block_stmt_71_127_start <= Xentry_13_symbol; -- control passed to block
          Xentry_128_symbol  <= series_block_stmt_71_127_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/$entry
          assign_stmt_89_130: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89 
            signal assign_stmt_89_130_start: Boolean;
            signal Xentry_131_symbol: Boolean;
            signal Xexit_132_symbol: Boolean;
            signal ternary_88_133_symbol : Boolean;
            -- 
          begin -- 
            assign_stmt_89_130_start <= Xentry_128_symbol; -- control passed to block
            Xentry_131_symbol  <= assign_stmt_89_130_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/$entry
            ternary_88_133: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88 
              signal ternary_88_133_start: Boolean;
              signal Xentry_134_symbol: Boolean;
              signal Xexit_135_symbol: Boolean;
              signal ternary_88_inputs_136_symbol : Boolean;
              signal req_199_symbol : Boolean;
              signal ack_200_symbol : Boolean;
              -- 
            begin -- 
              ternary_88_133_start <= Xentry_131_symbol; -- control passed to block
              Xentry_134_symbol  <= ternary_88_133_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/$entry
              ternary_88_inputs_136: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs 
                signal ternary_88_inputs_136_start: Boolean;
                signal Xentry_137_symbol: Boolean;
                signal Xexit_138_symbol: Boolean;
                signal binary_75_139_symbol : Boolean;
                signal binary_82_149_symbol : Boolean;
                signal binary_87_179_symbol : Boolean;
                -- 
              begin -- 
                ternary_88_inputs_136_start <= Xentry_134_symbol; -- control passed to block
                Xentry_137_symbol  <= ternary_88_inputs_136_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/$entry
                binary_75_139: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75 
                  signal binary_75_139_start: Boolean;
                  signal Xentry_140_symbol: Boolean;
                  signal Xexit_141_symbol: Boolean;
                  signal binary_75_inputs_142_symbol : Boolean;
                  signal rr_145_symbol : Boolean;
                  signal ra_146_symbol : Boolean;
                  signal cr_147_symbol : Boolean;
                  signal ca_148_symbol : Boolean;
                  -- 
                begin -- 
                  binary_75_139_start <= Xentry_137_symbol; -- control passed to block
                  Xentry_140_symbol  <= binary_75_139_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/$entry
                  binary_75_inputs_142: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/binary_75_inputs 
                    signal binary_75_inputs_142_start: Boolean;
                    signal Xentry_143_symbol: Boolean;
                    signal Xexit_144_symbol: Boolean;
                    -- 
                  begin -- 
                    binary_75_inputs_142_start <= Xentry_140_symbol; -- control passed to block
                    Xentry_143_symbol  <= binary_75_inputs_142_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/binary_75_inputs/$entry
                    Xexit_144_symbol <= Xentry_143_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/binary_75_inputs/$exit
                    binary_75_inputs_142_symbol <= Xexit_144_symbol; -- control passed from block 
                    -- 
                  end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/binary_75_inputs
                  rr_145_symbol <= binary_75_inputs_142_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/rr
                  binary_75_inst_req_0 <= rr_145_symbol; -- link to DP
                  ra_146_symbol <= binary_75_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/ra
                  cr_147_symbol <= ra_146_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/cr
                  binary_75_inst_req_1 <= cr_147_symbol; -- link to DP
                  ca_148_symbol <= binary_75_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/ca
                  Xexit_141_symbol <= ca_148_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75/$exit
                  binary_75_139_symbol <= Xexit_141_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_75
                binary_82_149: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82 
                  signal binary_82_149_start: Boolean;
                  signal Xentry_150_symbol: Boolean;
                  signal Xexit_151_symbol: Boolean;
                  signal binary_82_inputs_152_symbol : Boolean;
                  signal rr_175_symbol : Boolean;
                  signal ra_176_symbol : Boolean;
                  signal cr_177_symbol : Boolean;
                  signal ca_178_symbol : Boolean;
                  -- 
                begin -- 
                  binary_82_149_start <= Xentry_137_symbol; -- control passed to block
                  Xentry_150_symbol  <= binary_82_149_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/$entry
                  binary_82_inputs_152: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs 
                    signal binary_82_inputs_152_start: Boolean;
                    signal Xentry_153_symbol: Boolean;
                    signal Xexit_154_symbol: Boolean;
                    signal binary_80_155_symbol : Boolean;
                    -- 
                  begin -- 
                    binary_82_inputs_152_start <= Xentry_150_symbol; -- control passed to block
                    Xentry_153_symbol  <= binary_82_inputs_152_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/$entry
                    binary_80_155: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80 
                      signal binary_80_155_start: Boolean;
                      signal Xentry_156_symbol: Boolean;
                      signal Xexit_157_symbol: Boolean;
                      signal binary_80_inputs_158_symbol : Boolean;
                      signal rr_171_symbol : Boolean;
                      signal ra_172_symbol : Boolean;
                      signal cr_173_symbol : Boolean;
                      signal ca_174_symbol : Boolean;
                      -- 
                    begin -- 
                      binary_80_155_start <= Xentry_153_symbol; -- control passed to block
                      Xentry_156_symbol  <= binary_80_155_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/$entry
                      binary_80_inputs_158: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs 
                        signal binary_80_inputs_158_start: Boolean;
                        signal Xentry_159_symbol: Boolean;
                        signal Xexit_160_symbol: Boolean;
                        signal binary_78_161_symbol : Boolean;
                        -- 
                      begin -- 
                        binary_80_inputs_158_start <= Xentry_156_symbol; -- control passed to block
                        Xentry_159_symbol  <= binary_80_inputs_158_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/$entry
                        binary_78_161: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78 
                          signal binary_78_161_start: Boolean;
                          signal Xentry_162_symbol: Boolean;
                          signal Xexit_163_symbol: Boolean;
                          signal binary_78_inputs_164_symbol : Boolean;
                          signal rr_167_symbol : Boolean;
                          signal ra_168_symbol : Boolean;
                          signal cr_169_symbol : Boolean;
                          signal ca_170_symbol : Boolean;
                          -- 
                        begin -- 
                          binary_78_161_start <= Xentry_159_symbol; -- control passed to block
                          Xentry_162_symbol  <= binary_78_161_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/$entry
                          binary_78_inputs_164: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/binary_78_inputs 
                            signal binary_78_inputs_164_start: Boolean;
                            signal Xentry_165_symbol: Boolean;
                            signal Xexit_166_symbol: Boolean;
                            -- 
                          begin -- 
                            binary_78_inputs_164_start <= Xentry_162_symbol; -- control passed to block
                            Xentry_165_symbol  <= binary_78_inputs_164_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/binary_78_inputs/$entry
                            Xexit_166_symbol <= Xentry_165_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/binary_78_inputs/$exit
                            binary_78_inputs_164_symbol <= Xexit_166_symbol; -- control passed from block 
                            -- 
                          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/binary_78_inputs
                          rr_167_symbol <= binary_78_inputs_164_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/rr
                          binary_78_inst_req_0 <= rr_167_symbol; -- link to DP
                          ra_168_symbol <= binary_78_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/ra
                          cr_169_symbol <= ra_168_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/cr
                          binary_78_inst_req_1 <= cr_169_symbol; -- link to DP
                          ca_170_symbol <= binary_78_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/ca
                          Xexit_163_symbol <= ca_170_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78/$exit
                          binary_78_161_symbol <= Xexit_163_symbol; -- control passed from block 
                          -- 
                        end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/binary_78
                        Xexit_160_symbol <= binary_78_161_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs/$exit
                        binary_80_inputs_158_symbol <= Xexit_160_symbol; -- control passed from block 
                        -- 
                      end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/binary_80_inputs
                      rr_171_symbol <= binary_80_inputs_158_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/rr
                      binary_80_inst_req_0 <= rr_171_symbol; -- link to DP
                      ra_172_symbol <= binary_80_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/ra
                      cr_173_symbol <= ra_172_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/cr
                      binary_80_inst_req_1 <= cr_173_symbol; -- link to DP
                      ca_174_symbol <= binary_80_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/ca
                      Xexit_157_symbol <= ca_174_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80/$exit
                      binary_80_155_symbol <= Xexit_157_symbol; -- control passed from block 
                      -- 
                    end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/binary_80
                    Xexit_154_symbol <= binary_80_155_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs/$exit
                    binary_82_inputs_152_symbol <= Xexit_154_symbol; -- control passed from block 
                    -- 
                  end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/binary_82_inputs
                  rr_175_symbol <= binary_82_inputs_152_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/rr
                  binary_82_inst_req_0 <= rr_175_symbol; -- link to DP
                  ra_176_symbol <= binary_82_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/ra
                  cr_177_symbol <= ra_176_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/cr
                  binary_82_inst_req_1 <= cr_177_symbol; -- link to DP
                  ca_178_symbol <= binary_82_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/ca
                  Xexit_151_symbol <= ca_178_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82/$exit
                  binary_82_149_symbol <= Xexit_151_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_82
                binary_87_179: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87 
                  signal binary_87_179_start: Boolean;
                  signal Xentry_180_symbol: Boolean;
                  signal Xexit_181_symbol: Boolean;
                  signal binary_87_inputs_182_symbol : Boolean;
                  signal rr_195_symbol : Boolean;
                  signal ra_196_symbol : Boolean;
                  signal cr_197_symbol : Boolean;
                  signal ca_198_symbol : Boolean;
                  -- 
                begin -- 
                  binary_87_179_start <= Xentry_137_symbol; -- control passed to block
                  Xentry_180_symbol  <= binary_87_179_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/$entry
                  binary_87_inputs_182: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs 
                    signal binary_87_inputs_182_start: Boolean;
                    signal Xentry_183_symbol: Boolean;
                    signal Xexit_184_symbol: Boolean;
                    signal binary_85_185_symbol : Boolean;
                    -- 
                  begin -- 
                    binary_87_inputs_182_start <= Xentry_180_symbol; -- control passed to block
                    Xentry_183_symbol  <= binary_87_inputs_182_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/$entry
                    binary_85_185: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85 
                      signal binary_85_185_start: Boolean;
                      signal Xentry_186_symbol: Boolean;
                      signal Xexit_187_symbol: Boolean;
                      signal binary_85_inputs_188_symbol : Boolean;
                      signal rr_191_symbol : Boolean;
                      signal ra_192_symbol : Boolean;
                      signal cr_193_symbol : Boolean;
                      signal ca_194_symbol : Boolean;
                      -- 
                    begin -- 
                      binary_85_185_start <= Xentry_183_symbol; -- control passed to block
                      Xentry_186_symbol  <= binary_85_185_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/$entry
                      binary_85_inputs_188: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/binary_85_inputs 
                        signal binary_85_inputs_188_start: Boolean;
                        signal Xentry_189_symbol: Boolean;
                        signal Xexit_190_symbol: Boolean;
                        -- 
                      begin -- 
                        binary_85_inputs_188_start <= Xentry_186_symbol; -- control passed to block
                        Xentry_189_symbol  <= binary_85_inputs_188_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/binary_85_inputs/$entry
                        Xexit_190_symbol <= Xentry_189_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/binary_85_inputs/$exit
                        binary_85_inputs_188_symbol <= Xexit_190_symbol; -- control passed from block 
                        -- 
                      end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/binary_85_inputs
                      rr_191_symbol <= binary_85_inputs_188_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/rr
                      binary_85_inst_req_0 <= rr_191_symbol; -- link to DP
                      ra_192_symbol <= binary_85_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/ra
                      cr_193_symbol <= ra_192_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/cr
                      binary_85_inst_req_1 <= cr_193_symbol; -- link to DP
                      ca_194_symbol <= binary_85_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/ca
                      Xexit_187_symbol <= ca_194_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85/$exit
                      binary_85_185_symbol <= Xexit_187_symbol; -- control passed from block 
                      -- 
                    end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/binary_85
                    Xexit_184_symbol <= binary_85_185_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs/$exit
                    binary_87_inputs_182_symbol <= Xexit_184_symbol; -- control passed from block 
                    -- 
                  end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/binary_87_inputs
                  rr_195_symbol <= binary_87_inputs_182_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/rr
                  binary_87_inst_req_0 <= rr_195_symbol; -- link to DP
                  ra_196_symbol <= binary_87_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/ra
                  cr_197_symbol <= ra_196_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/cr
                  binary_87_inst_req_1 <= cr_197_symbol; -- link to DP
                  ca_198_symbol <= binary_87_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/ca
                  Xexit_181_symbol <= ca_198_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87/$exit
                  binary_87_179_symbol <= Xexit_181_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/binary_87
                Xexit_138_block : Block -- non-trivial join transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/$exit 
                  signal Xexit_138_predecessors: BooleanArray(2 downto 0);
                  signal Xexit_138_p0_pred: BooleanArray(0 downto 0);
                  signal Xexit_138_p0_succ: BooleanArray(0 downto 0);
                  signal Xexit_138_p1_pred: BooleanArray(0 downto 0);
                  signal Xexit_138_p1_succ: BooleanArray(0 downto 0);
                  signal Xexit_138_p2_pred: BooleanArray(0 downto 0);
                  signal Xexit_138_p2_succ: BooleanArray(0 downto 0);
                  -- 
                begin -- 
                  Xexit_138_0_place: Place -- 
                    generic map(marking => false)
                    port map( -- 
                      Xexit_138_p0_pred, Xexit_138_p0_succ, Xexit_138_predecessors(0), clk, reset-- 
                    ); -- 
                  Xexit_138_p0_succ(0) <=  Xexit_138_symbol;
                  Xexit_138_p0_pred(0) <=  binary_75_139_symbol;
                  Xexit_138_1_place: Place -- 
                    generic map(marking => false)
                    port map( -- 
                      Xexit_138_p1_pred, Xexit_138_p1_succ, Xexit_138_predecessors(1), clk, reset-- 
                    ); -- 
                  Xexit_138_p1_succ(0) <=  Xexit_138_symbol;
                  Xexit_138_p1_pred(0) <=  binary_82_149_symbol;
                  Xexit_138_2_place: Place -- 
                    generic map(marking => false)
                    port map( -- 
                      Xexit_138_p2_pred, Xexit_138_p2_succ, Xexit_138_predecessors(2), clk, reset-- 
                    ); -- 
                  Xexit_138_p2_succ(0) <=  Xexit_138_symbol;
                  Xexit_138_p2_pred(0) <=  binary_87_179_symbol;
                  Xexit_138_symbol <= AndReduce(Xexit_138_predecessors); 
                  -- 
                end Block; -- non-trivial join transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs/$exit
                ternary_88_inputs_136_symbol <= Xexit_138_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ternary_88_inputs
              req_199_symbol <= ternary_88_inputs_136_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/req
              ternary_88_inst_req_0 <= req_199_symbol; -- link to DP
              ack_200_symbol <= ternary_88_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/ack
              Xexit_135_symbol <= ack_200_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88/$exit
              ternary_88_133_symbol <= Xexit_135_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/ternary_88
            Xexit_132_symbol <= ternary_88_133_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89/$exit
            assign_stmt_89_130_symbol <= Xexit_132_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_89
          assign_stmt_95_201: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95 
            signal assign_stmt_95_201_start: Boolean;
            signal Xentry_202_symbol: Boolean;
            signal Xexit_203_symbol: Boolean;
            signal type_cast_94_204_symbol : Boolean;
            -- 
          begin -- 
            assign_stmt_95_201_start <= assign_stmt_89_130_symbol; -- control passed to block
            Xentry_202_symbol  <= assign_stmt_95_201_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/$entry
            type_cast_94_204: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94 
              signal type_cast_94_204_start: Boolean;
              signal Xentry_205_symbol: Boolean;
              signal Xexit_206_symbol: Boolean;
              signal binary_93_207_symbol : Boolean;
              signal req_217_symbol : Boolean;
              signal ack_218_symbol : Boolean;
              -- 
            begin -- 
              type_cast_94_204_start <= Xentry_202_symbol; -- control passed to block
              Xentry_205_symbol  <= type_cast_94_204_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/$entry
              binary_93_207: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93 
                signal binary_93_207_start: Boolean;
                signal Xentry_208_symbol: Boolean;
                signal Xexit_209_symbol: Boolean;
                signal binary_93_inputs_210_symbol : Boolean;
                signal rr_213_symbol : Boolean;
                signal ra_214_symbol : Boolean;
                signal cr_215_symbol : Boolean;
                signal ca_216_symbol : Boolean;
                -- 
              begin -- 
                binary_93_207_start <= Xentry_205_symbol; -- control passed to block
                Xentry_208_symbol  <= binary_93_207_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/$entry
                binary_93_inputs_210: Block -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/binary_93_inputs 
                  signal binary_93_inputs_210_start: Boolean;
                  signal Xentry_211_symbol: Boolean;
                  signal Xexit_212_symbol: Boolean;
                  -- 
                begin -- 
                  binary_93_inputs_210_start <= Xentry_208_symbol; -- control passed to block
                  Xentry_211_symbol  <= binary_93_inputs_210_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/binary_93_inputs/$entry
                  Xexit_212_symbol <= Xentry_211_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/binary_93_inputs/$exit
                  binary_93_inputs_210_symbol <= Xexit_212_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/binary_93_inputs
                rr_213_symbol <= binary_93_inputs_210_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/rr
                binary_93_inst_req_0 <= rr_213_symbol; -- link to DP
                ra_214_symbol <= binary_93_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/ra
                cr_215_symbol <= ra_214_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/cr
                binary_93_inst_req_1 <= cr_215_symbol; -- link to DP
                ca_216_symbol <= binary_93_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/ca
                Xexit_209_symbol <= ca_216_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93/$exit
                binary_93_207_symbol <= Xexit_209_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/binary_93
              req_217_symbol <= binary_93_207_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/req
              type_cast_94_inst_req_0 <= req_217_symbol; -- link to DP
              ack_218_symbol <= type_cast_94_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/ack
              Xexit_206_symbol <= ack_218_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94/$exit
              type_cast_94_204_symbol <= Xexit_206_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/type_cast_94
            Xexit_203_symbol <= type_cast_94_204_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95/$exit
            assign_stmt_95_201_symbol <= Xexit_203_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/assign_stmt_95
          Xexit_129_symbol <= assign_stmt_95_201_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71/$exit
          series_block_stmt_71_127_symbol <= Xexit_129_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_21/parallel_block_stmt_40/series_block_stmt_71
        assign_stmt_101_219: Block -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101 
          signal assign_stmt_101_219_start: Boolean;
          signal Xentry_220_symbol: Boolean;
          signal Xexit_221_symbol: Boolean;
          signal binary_100_222_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_101_219_start <= Xentry_13_symbol; -- control passed to block
          Xentry_220_symbol  <= assign_stmt_101_219_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/$entry
          binary_100_222: Block -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100 
            signal binary_100_222_start: Boolean;
            signal Xentry_223_symbol: Boolean;
            signal Xexit_224_symbol: Boolean;
            signal binary_100_inputs_225_symbol : Boolean;
            signal rr_228_symbol : Boolean;
            signal ra_229_symbol : Boolean;
            signal cr_230_symbol : Boolean;
            signal ca_231_symbol : Boolean;
            -- 
          begin -- 
            binary_100_222_start <= Xentry_220_symbol; -- control passed to block
            Xentry_223_symbol  <= binary_100_222_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/$entry
            binary_100_inputs_225: Block -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/binary_100_inputs 
              signal binary_100_inputs_225_start: Boolean;
              signal Xentry_226_symbol: Boolean;
              signal Xexit_227_symbol: Boolean;
              -- 
            begin -- 
              binary_100_inputs_225_start <= Xentry_223_symbol; -- control passed to block
              Xentry_226_symbol  <= binary_100_inputs_225_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/binary_100_inputs/$entry
              Xexit_227_symbol <= Xentry_226_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/binary_100_inputs/$exit
              binary_100_inputs_225_symbol <= Xexit_227_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/binary_100_inputs
            rr_228_symbol <= binary_100_inputs_225_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/rr
            binary_100_inst_req_0 <= rr_228_symbol; -- link to DP
            ra_229_symbol <= binary_100_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/ra
            cr_230_symbol <= ra_229_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/cr
            binary_100_inst_req_1 <= cr_230_symbol; -- link to DP
            ca_231_symbol <= binary_100_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/ca
            Xexit_224_symbol <= ca_231_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100/$exit
            binary_100_222_symbol <= Xexit_224_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/binary_100
          Xexit_221_symbol <= binary_100_222_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101/$exit
          assign_stmt_101_219_symbol <= Xexit_221_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_101
        assign_stmt_106_232: Block -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106 
          signal assign_stmt_106_232_start: Boolean;
          signal Xentry_233_symbol: Boolean;
          signal Xexit_234_symbol: Boolean;
          signal binary_105_235_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_106_232_start <= Xentry_13_symbol; -- control passed to block
          Xentry_233_symbol  <= assign_stmt_106_232_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/$entry
          binary_105_235: Block -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105 
            signal binary_105_235_start: Boolean;
            signal Xentry_236_symbol: Boolean;
            signal Xexit_237_symbol: Boolean;
            signal binary_105_inputs_238_symbol : Boolean;
            signal rr_241_symbol : Boolean;
            signal ra_242_symbol : Boolean;
            signal cr_243_symbol : Boolean;
            signal ca_244_symbol : Boolean;
            -- 
          begin -- 
            binary_105_235_start <= Xentry_233_symbol; -- control passed to block
            Xentry_236_symbol  <= binary_105_235_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/$entry
            binary_105_inputs_238: Block -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/binary_105_inputs 
              signal binary_105_inputs_238_start: Boolean;
              signal Xentry_239_symbol: Boolean;
              signal Xexit_240_symbol: Boolean;
              -- 
            begin -- 
              binary_105_inputs_238_start <= Xentry_236_symbol; -- control passed to block
              Xentry_239_symbol  <= binary_105_inputs_238_start; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/binary_105_inputs/$entry
              Xexit_240_symbol <= Xentry_239_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/binary_105_inputs/$exit
              binary_105_inputs_238_symbol <= Xexit_240_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/binary_105_inputs
            rr_241_symbol <= binary_105_inputs_238_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/rr
            binary_105_inst_req_0 <= rr_241_symbol; -- link to DP
            ra_242_symbol <= binary_105_inst_ack_0; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/ra
            cr_243_symbol <= ra_242_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/cr
            binary_105_inst_req_1 <= cr_243_symbol; -- link to DP
            ca_244_symbol <= binary_105_inst_ack_1; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/ca
            Xexit_237_symbol <= ca_244_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105/$exit
            binary_105_235_symbol <= Xexit_237_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/binary_105
          Xexit_234_symbol <= binary_105_235_symbol; -- transition branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106/$exit
          assign_stmt_106_232_symbol <= Xexit_234_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_21/parallel_block_stmt_40/assign_stmt_106
        Xexit_14_block : Block -- non-trivial join transition branch_block_stmt_21/parallel_block_stmt_40/$exit 
          signal Xexit_14_predecessors: BooleanArray(3 downto 0);
          signal Xexit_14_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_14_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_14_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_14_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_14_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_14_p2_succ: BooleanArray(0 downto 0);
          signal Xexit_14_p3_pred: BooleanArray(0 downto 0);
          signal Xexit_14_p3_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_14_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_14_p0_pred, Xexit_14_p0_succ, Xexit_14_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_14_p0_succ(0) <=  Xexit_14_symbol;
          Xexit_14_p0_pred(0) <=  series_block_stmt_41_15_symbol;
          Xexit_14_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_14_p1_pred, Xexit_14_p1_succ, Xexit_14_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_14_p1_succ(0) <=  Xexit_14_symbol;
          Xexit_14_p1_pred(0) <=  series_block_stmt_71_127_symbol;
          Xexit_14_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_14_p2_pred, Xexit_14_p2_succ, Xexit_14_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_14_p2_succ(0) <=  Xexit_14_symbol;
          Xexit_14_p2_pred(0) <=  assign_stmt_101_219_symbol;
          Xexit_14_3_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_14_p3_pred, Xexit_14_p3_succ, Xexit_14_predecessors(3), clk, reset-- 
            ); -- 
          Xexit_14_p3_succ(0) <=  Xexit_14_symbol;
          Xexit_14_p3_pred(0) <=  assign_stmt_106_232_symbol;
          Xexit_14_symbol <= AndReduce(Xexit_14_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_21/parallel_block_stmt_40/$exit
        parallel_block_stmt_40_12_symbol <= Xexit_14_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/parallel_block_stmt_40
      if_stmt_108_eval_test_245: Block -- branch_block_stmt_21/if_stmt_108_eval_test 
        signal if_stmt_108_eval_test_245_start: Boolean;
        signal Xentry_246_symbol: Boolean;
        signal Xexit_247_symbol: Boolean;
        signal binary_111_248_symbol : Boolean;
        signal branch_req_258_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_108_eval_test_245_start <= if_stmt_108_x_xentry_x_xx_x11_symbol; -- control passed to block
        Xentry_246_symbol  <= if_stmt_108_eval_test_245_start; -- transition branch_block_stmt_21/if_stmt_108_eval_test/$entry
        binary_111_248: Block -- branch_block_stmt_21/if_stmt_108_eval_test/binary_111 
          signal binary_111_248_start: Boolean;
          signal Xentry_249_symbol: Boolean;
          signal Xexit_250_symbol: Boolean;
          signal binary_111_inputs_251_symbol : Boolean;
          signal rr_254_symbol : Boolean;
          signal ra_255_symbol : Boolean;
          signal cr_256_symbol : Boolean;
          signal ca_257_symbol : Boolean;
          -- 
        begin -- 
          binary_111_248_start <= Xentry_246_symbol; -- control passed to block
          Xentry_249_symbol  <= binary_111_248_start; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/$entry
          binary_111_inputs_251: Block -- branch_block_stmt_21/if_stmt_108_eval_test/binary_111/binary_111_inputs 
            signal binary_111_inputs_251_start: Boolean;
            signal Xentry_252_symbol: Boolean;
            signal Xexit_253_symbol: Boolean;
            -- 
          begin -- 
            binary_111_inputs_251_start <= Xentry_249_symbol; -- control passed to block
            Xentry_252_symbol  <= binary_111_inputs_251_start; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/binary_111_inputs/$entry
            Xexit_253_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/binary_111_inputs/$exit
            binary_111_inputs_251_symbol <= Xexit_253_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_21/if_stmt_108_eval_test/binary_111/binary_111_inputs
          rr_254_symbol <= binary_111_inputs_251_symbol; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/rr
          binary_111_inst_req_0 <= rr_254_symbol; -- link to DP
          ra_255_symbol <= binary_111_inst_ack_0; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/ra
          cr_256_symbol <= ra_255_symbol; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/cr
          binary_111_inst_req_1 <= cr_256_symbol; -- link to DP
          ca_257_symbol <= binary_111_inst_ack_1; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/ca
          Xexit_250_symbol <= ca_257_symbol; -- transition branch_block_stmt_21/if_stmt_108_eval_test/binary_111/$exit
          binary_111_248_symbol <= Xexit_250_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_21/if_stmt_108_eval_test/binary_111
        branch_req_258_symbol <= binary_111_248_symbol; -- transition branch_block_stmt_21/if_stmt_108_eval_test/branch_req
        if_stmt_108_branch_req_0 <= branch_req_258_symbol; -- link to DP
        Xexit_247_symbol <= branch_req_258_symbol; -- transition branch_block_stmt_21/if_stmt_108_eval_test/$exit
        if_stmt_108_eval_test_245_symbol <= Xexit_247_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/if_stmt_108_eval_test
      binary_111_place_259_symbol  <=  if_stmt_108_eval_test_245_symbol; -- place branch_block_stmt_21/binary_111_place (optimized away) 
      if_stmt_108_if_link_260: Block -- branch_block_stmt_21/if_stmt_108_if_link 
        signal if_stmt_108_if_link_260_start: Boolean;
        signal Xentry_261_symbol: Boolean;
        signal Xexit_262_symbol: Boolean;
        signal if_choice_transition_263_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_108_if_link_260_start <= binary_111_place_259_symbol; -- control passed to block
        Xentry_261_symbol  <= if_stmt_108_if_link_260_start; -- transition branch_block_stmt_21/if_stmt_108_if_link/$entry
        if_choice_transition_263_symbol <= if_stmt_108_branch_ack_1; -- transition branch_block_stmt_21/if_stmt_108_if_link/if_choice_transition
        Xexit_262_symbol <= if_choice_transition_263_symbol; -- transition branch_block_stmt_21/if_stmt_108_if_link/$exit
        if_stmt_108_if_link_260_symbol <= Xexit_262_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/if_stmt_108_if_link
      if_stmt_108_else_link_264: Block -- branch_block_stmt_21/if_stmt_108_else_link 
        signal if_stmt_108_else_link_264_start: Boolean;
        signal Xentry_265_symbol: Boolean;
        signal Xexit_266_symbol: Boolean;
        signal else_choice_transition_267_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_108_else_link_264_start <= binary_111_place_259_symbol; -- control passed to block
        Xentry_265_symbol  <= if_stmt_108_else_link_264_start; -- transition branch_block_stmt_21/if_stmt_108_else_link/$entry
        else_choice_transition_267_symbol <= if_stmt_108_branch_ack_0; -- transition branch_block_stmt_21/if_stmt_108_else_link/else_choice_transition
        Xexit_266_symbol <= else_choice_transition_267_symbol; -- transition branch_block_stmt_21/if_stmt_108_else_link/$exit
        if_stmt_108_else_link_264_symbol <= Xexit_266_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/if_stmt_108_else_link
      stmt_112_x_xentry_x_xx_x268_symbol  <=  if_stmt_108_if_link_260_symbol; -- place branch_block_stmt_21/stmt_112__entry__ (optimized away) 
      stmt_112_x_xexit_x_xx_x269_symbol  <=  stmt_112_270_symbol; -- place branch_block_stmt_21/stmt_112__exit__ (optimized away) 
      stmt_112_270: Block -- branch_block_stmt_21/stmt_112 
        signal stmt_112_270_start: Boolean;
        signal Xentry_271_symbol: Boolean;
        signal Xexit_272_symbol: Boolean;
        -- 
      begin -- 
        stmt_112_270_start <= stmt_112_x_xentry_x_xx_x268_symbol; -- control passed to block
        Xentry_271_symbol  <= stmt_112_270_start; -- transition branch_block_stmt_21/stmt_112/$entry
        Xexit_272_symbol <= Xentry_271_symbol; -- transition branch_block_stmt_21/stmt_112/$exit
        stmt_112_270_symbol <= Xexit_272_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/stmt_112
      loopback_273_symbol  <=  if_stmt_108_else_link_264_symbol; -- place branch_block_stmt_21/loopback (optimized away) 
      branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274: Block -- branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq 
        signal branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274_start: Boolean;
        signal Xentry_275_symbol: Boolean;
        signal Xexit_276_symbol: Boolean;
        signal phi_stmt_23_req_277_symbol : Boolean;
        signal phi_stmt_27_req_278_symbol : Boolean;
        signal phi_stmt_31_req_279_symbol : Boolean;
        signal phi_stmt_35_req_280_symbol : Boolean;
        -- 
      begin -- 
        branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274_start <= branch_block_stmt_21_x_xentry_x_xx_x6_symbol; -- control passed to block
        Xentry_275_symbol  <= branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274_start; -- transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/$entry
        phi_stmt_23_req_277_symbol <= Xentry_275_symbol; -- transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/phi_stmt_23_req
        phi_stmt_23_req_0 <= phi_stmt_23_req_277_symbol; -- link to DP
        phi_stmt_27_req_278_symbol <= Xentry_275_symbol; -- transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/phi_stmt_27_req
        phi_stmt_27_req_0 <= phi_stmt_27_req_278_symbol; -- link to DP
        phi_stmt_31_req_279_symbol <= Xentry_275_symbol; -- transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/phi_stmt_31_req
        phi_stmt_31_req_0 <= phi_stmt_31_req_279_symbol; -- link to DP
        phi_stmt_35_req_280_symbol <= Xentry_275_symbol; -- transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/phi_stmt_35_req
        phi_stmt_35_req_0 <= phi_stmt_35_req_280_symbol; -- link to DP
        Xexit_276_block : Block -- non-trivial join transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/$exit 
          signal Xexit_276_predecessors: BooleanArray(3 downto 0);
          signal Xexit_276_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_276_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_276_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_276_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_276_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_276_p2_succ: BooleanArray(0 downto 0);
          signal Xexit_276_p3_pred: BooleanArray(0 downto 0);
          signal Xexit_276_p3_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_276_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_276_p0_pred, Xexit_276_p0_succ, Xexit_276_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_276_p0_succ(0) <=  Xexit_276_symbol;
          Xexit_276_p0_pred(0) <=  phi_stmt_23_req_277_symbol;
          Xexit_276_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_276_p1_pred, Xexit_276_p1_succ, Xexit_276_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_276_p1_succ(0) <=  Xexit_276_symbol;
          Xexit_276_p1_pred(0) <=  phi_stmt_27_req_278_symbol;
          Xexit_276_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_276_p2_pred, Xexit_276_p2_succ, Xexit_276_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_276_p2_succ(0) <=  Xexit_276_symbol;
          Xexit_276_p2_pred(0) <=  phi_stmt_31_req_279_symbol;
          Xexit_276_3_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_276_p3_pred, Xexit_276_p3_succ, Xexit_276_predecessors(3), clk, reset-- 
            ); -- 
          Xexit_276_p3_succ(0) <=  Xexit_276_symbol;
          Xexit_276_p3_pred(0) <=  phi_stmt_35_req_280_symbol;
          Xexit_276_symbol <= AndReduce(Xexit_276_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq/$exit
        branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274_symbol <= Xexit_276_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/branch_block_stmt_21__entry___PhiReq
      loopback_PhiReq_281: Block -- branch_block_stmt_21/loopback_PhiReq 
        signal loopback_PhiReq_281_start: Boolean;
        signal Xentry_282_symbol: Boolean;
        signal Xexit_283_symbol: Boolean;
        signal phi_stmt_23_req_284_symbol : Boolean;
        signal phi_stmt_27_req_285_symbol : Boolean;
        signal phi_stmt_31_req_286_symbol : Boolean;
        signal phi_stmt_35_req_287_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_281_start <= loopback_273_symbol; -- control passed to block
        Xentry_282_symbol  <= loopback_PhiReq_281_start; -- transition branch_block_stmt_21/loopback_PhiReq/$entry
        phi_stmt_23_req_284_symbol <= Xentry_282_symbol; -- transition branch_block_stmt_21/loopback_PhiReq/phi_stmt_23_req
        phi_stmt_23_req_1 <= phi_stmt_23_req_284_symbol; -- link to DP
        phi_stmt_27_req_285_symbol <= Xentry_282_symbol; -- transition branch_block_stmt_21/loopback_PhiReq/phi_stmt_27_req
        phi_stmt_27_req_1 <= phi_stmt_27_req_285_symbol; -- link to DP
        phi_stmt_31_req_286_symbol <= Xentry_282_symbol; -- transition branch_block_stmt_21/loopback_PhiReq/phi_stmt_31_req
        phi_stmt_31_req_1 <= phi_stmt_31_req_286_symbol; -- link to DP
        phi_stmt_35_req_287_symbol <= Xentry_282_symbol; -- transition branch_block_stmt_21/loopback_PhiReq/phi_stmt_35_req
        phi_stmt_35_req_1 <= phi_stmt_35_req_287_symbol; -- link to DP
        Xexit_283_block : Block -- non-trivial join transition branch_block_stmt_21/loopback_PhiReq/$exit 
          signal Xexit_283_predecessors: BooleanArray(3 downto 0);
          signal Xexit_283_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_283_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_283_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_283_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_283_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_283_p2_succ: BooleanArray(0 downto 0);
          signal Xexit_283_p3_pred: BooleanArray(0 downto 0);
          signal Xexit_283_p3_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_283_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_283_p0_pred, Xexit_283_p0_succ, Xexit_283_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_283_p0_succ(0) <=  Xexit_283_symbol;
          Xexit_283_p0_pred(0) <=  phi_stmt_23_req_284_symbol;
          Xexit_283_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_283_p1_pred, Xexit_283_p1_succ, Xexit_283_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_283_p1_succ(0) <=  Xexit_283_symbol;
          Xexit_283_p1_pred(0) <=  phi_stmt_27_req_285_symbol;
          Xexit_283_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_283_p2_pred, Xexit_283_p2_succ, Xexit_283_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_283_p2_succ(0) <=  Xexit_283_symbol;
          Xexit_283_p2_pred(0) <=  phi_stmt_31_req_286_symbol;
          Xexit_283_3_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_283_p3_pred, Xexit_283_p3_succ, Xexit_283_predecessors(3), clk, reset-- 
            ); -- 
          Xexit_283_p3_succ(0) <=  Xexit_283_symbol;
          Xexit_283_p3_pred(0) <=  phi_stmt_35_req_287_symbol;
          Xexit_283_symbol <= AndReduce(Xexit_283_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_21/loopback_PhiReq/$exit
        loopback_PhiReq_281_symbol <= Xexit_283_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/loopback_PhiReq
      merge_stmt_22_PhiReqMerge_288_symbol  <=  branch_block_stmt_21_x_xentry_x_xx_xPhiReq_274_symbol or loopback_PhiReq_281_symbol; -- place branch_block_stmt_21/merge_stmt_22_PhiReqMerge (optimized away) 
      merge_stmt_22_PhiAck_289: Block -- branch_block_stmt_21/merge_stmt_22_PhiAck 
        signal merge_stmt_22_PhiAck_289_start: Boolean;
        signal Xentry_290_symbol: Boolean;
        signal Xexit_291_symbol: Boolean;
        signal phi_stmt_23_ack_292_symbol : Boolean;
        signal phi_stmt_27_ack_293_symbol : Boolean;
        signal phi_stmt_31_ack_294_symbol : Boolean;
        signal phi_stmt_35_ack_295_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_22_PhiAck_289_start <= merge_stmt_22_PhiReqMerge_288_symbol; -- control passed to block
        Xentry_290_symbol  <= merge_stmt_22_PhiAck_289_start; -- transition branch_block_stmt_21/merge_stmt_22_PhiAck/$entry
        phi_stmt_23_ack_292_symbol <= phi_stmt_23_ack_0; -- transition branch_block_stmt_21/merge_stmt_22_PhiAck/phi_stmt_23_ack
        phi_stmt_27_ack_293_symbol <= phi_stmt_27_ack_0; -- transition branch_block_stmt_21/merge_stmt_22_PhiAck/phi_stmt_27_ack
        phi_stmt_31_ack_294_symbol <= phi_stmt_31_ack_0; -- transition branch_block_stmt_21/merge_stmt_22_PhiAck/phi_stmt_31_ack
        phi_stmt_35_ack_295_symbol <= phi_stmt_35_ack_0; -- transition branch_block_stmt_21/merge_stmt_22_PhiAck/phi_stmt_35_ack
        Xexit_291_block : Block -- non-trivial join transition branch_block_stmt_21/merge_stmt_22_PhiAck/$exit 
          signal Xexit_291_predecessors: BooleanArray(3 downto 0);
          signal Xexit_291_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_291_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_291_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_291_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_291_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_291_p2_succ: BooleanArray(0 downto 0);
          signal Xexit_291_p3_pred: BooleanArray(0 downto 0);
          signal Xexit_291_p3_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_291_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_291_p0_pred, Xexit_291_p0_succ, Xexit_291_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_291_p0_succ(0) <=  Xexit_291_symbol;
          Xexit_291_p0_pred(0) <=  phi_stmt_23_ack_292_symbol;
          Xexit_291_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_291_p1_pred, Xexit_291_p1_succ, Xexit_291_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_291_p1_succ(0) <=  Xexit_291_symbol;
          Xexit_291_p1_pred(0) <=  phi_stmt_27_ack_293_symbol;
          Xexit_291_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_291_p2_pred, Xexit_291_p2_succ, Xexit_291_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_291_p2_succ(0) <=  Xexit_291_symbol;
          Xexit_291_p2_pred(0) <=  phi_stmt_31_ack_294_symbol;
          Xexit_291_3_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_291_p3_pred, Xexit_291_p3_succ, Xexit_291_predecessors(3), clk, reset-- 
            ); -- 
          Xexit_291_p3_succ(0) <=  Xexit_291_symbol;
          Xexit_291_p3_pred(0) <=  phi_stmt_35_ack_295_symbol;
          Xexit_291_symbol <= AndReduce(Xexit_291_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_21/merge_stmt_22_PhiAck/$exit
        merge_stmt_22_PhiAck_289_symbol <= Xexit_291_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_21/merge_stmt_22_PhiAck
      Xexit_5_symbol <= branch_block_stmt_21_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_21/$exit
      branch_block_stmt_21_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_21
    assign_stmt_121_296: Block -- assign_stmt_121 
      signal assign_stmt_121_296_start: Boolean;
      signal Xentry_297_symbol: Boolean;
      signal Xexit_298_symbol: Boolean;
      signal binary_120_299_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_121_296_start <= branch_block_stmt_21_3_symbol; -- control passed to block
      Xentry_297_symbol  <= assign_stmt_121_296_start; -- transition assign_stmt_121/$entry
      binary_120_299: Block -- assign_stmt_121/binary_120 
        signal binary_120_299_start: Boolean;
        signal Xentry_300_symbol: Boolean;
        signal Xexit_301_symbol: Boolean;
        signal binary_120_inputs_302_symbol : Boolean;
        signal rr_305_symbol : Boolean;
        signal ra_306_symbol : Boolean;
        signal cr_307_symbol : Boolean;
        signal ca_308_symbol : Boolean;
        -- 
      begin -- 
        binary_120_299_start <= Xentry_297_symbol; -- control passed to block
        Xentry_300_symbol  <= binary_120_299_start; -- transition assign_stmt_121/binary_120/$entry
        binary_120_inputs_302: Block -- assign_stmt_121/binary_120/binary_120_inputs 
          signal binary_120_inputs_302_start: Boolean;
          signal Xentry_303_symbol: Boolean;
          signal Xexit_304_symbol: Boolean;
          -- 
        begin -- 
          binary_120_inputs_302_start <= Xentry_300_symbol; -- control passed to block
          Xentry_303_symbol  <= binary_120_inputs_302_start; -- transition assign_stmt_121/binary_120/binary_120_inputs/$entry
          Xexit_304_symbol <= Xentry_303_symbol; -- transition assign_stmt_121/binary_120/binary_120_inputs/$exit
          binary_120_inputs_302_symbol <= Xexit_304_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_121/binary_120/binary_120_inputs
        rr_305_symbol <= binary_120_inputs_302_symbol; -- transition assign_stmt_121/binary_120/rr
        binary_120_inst_req_0 <= rr_305_symbol; -- link to DP
        ra_306_symbol <= binary_120_inst_ack_0; -- transition assign_stmt_121/binary_120/ra
        cr_307_symbol <= ra_306_symbol; -- transition assign_stmt_121/binary_120/cr
        binary_120_inst_req_1 <= cr_307_symbol; -- link to DP
        ca_308_symbol <= binary_120_inst_ack_1; -- transition assign_stmt_121/binary_120/ca
        Xexit_301_symbol <= ca_308_symbol; -- transition assign_stmt_121/binary_120/$exit
        binary_120_299_symbol <= Xexit_301_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_121/binary_120
      Xexit_298_symbol <= binary_120_299_symbol; -- transition assign_stmt_121/$exit
      assign_stmt_121_296_symbol <= Xexit_298_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_121
    Xexit_2_symbol <= assign_stmt_121_296_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal a_0_31 : std_logic_vector(9 downto 0);
    signal a_1_106 : std_logic_vector(9 downto 0);
    signal binary_111_wire : std_logic_vector(0 downto 0);
    signal binary_45_wire : std_logic_vector(0 downto 0);
    signal binary_48_wire : std_logic_vector(9 downto 0);
    signal binary_50_wire : std_logic_vector(10 downto 0);
    signal binary_52_wire : std_logic_vector(10 downto 0);
    signal binary_55_wire : std_logic_vector(10 downto 0);
    signal binary_57_wire : std_logic_vector(10 downto 0);
    signal binary_60_wire : std_logic_vector(0 downto 0);
    signal binary_62_wire : std_logic_vector(10 downto 0);
    signal binary_75_wire : std_logic_vector(0 downto 0);
    signal binary_78_wire : std_logic_vector(9 downto 0);
    signal binary_80_wire : std_logic_vector(10 downto 0);
    signal binary_82_wire : std_logic_vector(10 downto 0);
    signal binary_85_wire : std_logic_vector(10 downto 0);
    signal binary_87_wire : std_logic_vector(10 downto 0);
    signal binary_93_wire : std_logic_vector(10 downto 0);
    signal ctr_101 : std_logic_vector(10 downto 0);
    signal ctr_35 : std_logic_vector(10 downto 0);
    signal expr_104_wire_constant : std_logic_vector(3 downto 0);
    signal expr_110_wire_constant : std_logic_vector(3 downto 0);
    signal expr_25_wire_constant : std_logic_vector(9 downto 0);
    signal expr_29_wire_constant : std_logic_vector(9 downto 0);
    signal expr_44_wire_constant : std_logic_vector(3 downto 0);
    signal expr_51_wire_constant : std_logic_vector(3 downto 0);
    signal expr_56_wire_constant : std_logic_vector(3 downto 0);
    signal expr_59_wire_constant : std_logic_vector(3 downto 0);
    signal expr_63_wire_constant : std_logic_vector(3 downto 0);
    signal expr_74_wire_constant : std_logic_vector(3 downto 0);
    signal expr_81_wire_constant : std_logic_vector(3 downto 0);
    signal expr_86_wire_constant : std_logic_vector(3 downto 0);
    signal expr_92_wire_constant : std_logic_vector(3 downto 0);
    signal expr_99_wire_constant : std_logic_vector(3 downto 0);
    signal nu_89 : std_logic_vector(10 downto 0);
    signal nv_65 : std_logic_vector(10 downto 0);
    signal simple_obj_ref_37_wire_constant : std_logic_vector(10 downto 0);
    signal simple_obj_ref_49_wire_constant : std_logic_vector(0 downto 0);
    signal simple_obj_ref_54_wire_constant : std_logic_vector(0 downto 0);
    signal simple_obj_ref_79_wire_constant : std_logic_vector(0 downto 0);
    signal simple_obj_ref_84_wire_constant : std_logic_vector(0 downto 0);
    signal ternary_58_wire : std_logic_vector(10 downto 0);
    signal u_95 : std_logic_vector(9 downto 0);
    signal u_in_23 : std_logic_vector(9 downto 0);
    signal v_69 : std_logic_vector(9 downto 0);
    signal v_in_27 : std_logic_vector(9 downto 0);
    signal xxsum_modxxcount : std_logic_vector(10 downto 0);
    signal xxsum_modxxz1 : std_logic_vector(0 downto 0);
    signal xxsum_modxxz9 : std_logic_vector(8 downto 0);
    -- 
  begin -- 
    expr_104_wire_constant <= "0001";
    expr_110_wire_constant <= "0000";
    expr_25_wire_constant <= "0000000000";
    expr_29_wire_constant <= "0000000000";
    expr_44_wire_constant <= "0000";
    expr_51_wire_constant <= "0001";
    expr_56_wire_constant <= "0001";
    expr_59_wire_constant <= "0000";
    expr_63_wire_constant <= "0001";
    expr_74_wire_constant <= "0000";
    expr_81_wire_constant <= "0001";
    expr_86_wire_constant <= "0001";
    expr_92_wire_constant <= "0001";
    expr_99_wire_constant <= "0001";
    simple_obj_ref_37_wire_constant <= "10000000000";
    simple_obj_ref_49_wire_constant <= "0";
    simple_obj_ref_54_wire_constant <= "0";
    simple_obj_ref_79_wire_constant <= "0";
    simple_obj_ref_84_wire_constant <= "0";
    xxsum_modxxcount <= "10000000000";
    xxsum_modxxz1 <= "0";
    xxsum_modxxz9 <= "000000000";
    phi_stmt_23: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_25_wire_constant & u_95;
      req <= phi_stmt_23_req_0 & phi_stmt_23_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_23_ack_0,
          idata => idata,
          odata => u_in_23,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_23
    phi_stmt_27: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_29_wire_constant & v_69;
      req <= phi_stmt_27_req_0 & phi_stmt_27_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_27_ack_0,
          idata => idata,
          odata => v_in_27,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_27
    phi_stmt_31: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= a & a_1_106;
      req <= phi_stmt_31_req_0 & phi_stmt_31_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_31_ack_0,
          idata => idata,
          odata => a_0_31,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_31
    phi_stmt_35: Block -- phi operator 
      signal idata: std_logic_vector(21 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= simple_obj_ref_37_wire_constant & ctr_101;
      req <= phi_stmt_35_req_0 & phi_stmt_35_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 11) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_35_ack_0,
          idata => idata,
          odata => ctr_35,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_35
    ternary_58_inst: SelectBase generic map(data_width => 11) -- 
      port map( x => binary_52_wire, y => binary_57_wire, sel => binary_45_wire, z => ternary_58_wire, req => ternary_58_inst_req_0, ack => ternary_58_inst_ack_0, clk => clk, reset => reset); -- 
    ternary_88_inst: SelectBase generic map(data_width => 11) -- 
      port map( x => binary_82_wire, y => binary_87_wire, sel => binary_75_wire, z => nu_89, req => ternary_88_inst_req_0, ack => ternary_88_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_68_inst: RegisterBase generic map(in_data_width => 11,out_data_width => 10) -- 
      port map( din => nv_65, dout => v_69, req => type_cast_68_inst_req_0, ack => type_cast_68_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_94_inst: RegisterBase generic map(in_data_width => 11,out_data_width => 10) -- 
      port map( din => binary_93_wire, dout => u_95, req => type_cast_94_inst_req_0, ack => type_cast_94_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_108_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= binary_111_wire;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_108_branch_req_0,
          ack0 => if_stmt_108_branch_ack_0,
          ack1 => if_stmt_108_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_100_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= ctr_35;
      ctr_101 <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_100_inst_req_0,
          ackL => binary_100_inst_ack_0,
          reqR => binary_100_inst_req_1,
          ackR => binary_100_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_105_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= a_0_31;
      a_1_106 <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
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
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_105_inst_req_0,
          ackL => binary_105_inst_ack_0,
          reqR => binary_105_inst_req_1,
          ackR => binary_105_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_111_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= ctr_101;
      binary_111_wire <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApBitsel",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_111_inst_req_0,
          ackL => binary_111_inst_ack_0,
          reqR => binary_111_inst_req_1,
          ackR => binary_111_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_120_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(19 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_95 & v_69;
      aXb <= data_out(19 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApConcat",
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
          owidth => 20,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_120_inst_req_0,
          ackL => binary_120_inst_ack_0,
          reqR => binary_120_inst_req_1,
          ackR => binary_120_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_45_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= a_0_31;
      binary_45_wire <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApBitsel",
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
          constant_operand => "0000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_45_inst_req_0,
          ackL => binary_45_inst_ack_0,
          reqR => binary_45_inst_req_1,
          ackR => binary_45_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_48_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_in_23 & b;
      binary_48_wire <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
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
          owidth => 10,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_48_inst_req_0,
          ackL => binary_48_inst_ack_0,
          reqR => binary_48_inst_req_1,
          ackR => binary_48_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_50_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_48_wire;
      binary_50_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApConcat",
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
          owidth => 11,
          constant_operand => "0",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_50_inst_req_0,
          ackL => binary_50_inst_ack_0,
          reqR => binary_50_inst_req_1,
          ackR => binary_50_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_52_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_50_wire;
      binary_52_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_52_inst_req_0,
          ackL => binary_52_inst_ack_0,
          reqR => binary_52_inst_req_1,
          ackR => binary_52_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_55_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_in_23;
      binary_55_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApConcat",
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
          owidth => 11,
          constant_operand => "0",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_55_inst_req_0,
          ackL => binary_55_inst_ack_0,
          reqR => binary_55_inst_req_1,
          ackR => binary_55_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_57_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_55_wire;
      binary_57_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
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
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_60_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= ternary_58_wire;
      binary_60_wire <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApBitsel",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_60_inst_req_0,
          ackL => binary_60_inst_ack_0,
          reqR => binary_60_inst_req_1,
          ackR => binary_60_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : binary_62_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_60_wire & v_in_27;
      binary_62_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApConcat",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 1,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 10, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_62_inst_req_0,
          ackL => binary_62_inst_ack_0,
          reqR => binary_62_inst_req_1,
          ackR => binary_62_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared split operator group (12) : binary_64_inst 
    SplitOperatorGroup12: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_62_wire;
      nv_65 <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_64_inst_req_0,
          ackL => binary_64_inst_ack_0,
          reqR => binary_64_inst_req_1,
          ackR => binary_64_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 12
    -- shared split operator group (13) : binary_75_inst 
    SplitOperatorGroup13: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= a_0_31;
      binary_75_wire <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApBitsel",
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
          constant_operand => "0000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
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
    end Block; -- split operator group 13
    -- shared split operator group (14) : binary_78_inst 
    SplitOperatorGroup14: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_in_23 & b;
      binary_78_wire <= data_out(9 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
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
          owidth => 10,
          constant_operand => "0",
          use_constant  => false,
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
    end Block; -- split operator group 14
    -- shared split operator group (15) : binary_80_inst 
    SplitOperatorGroup15: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_78_wire;
      binary_80_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApConcat",
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
          owidth => 11,
          constant_operand => "0",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
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
    end Block; -- split operator group 15
    -- shared split operator group (16) : binary_82_inst 
    SplitOperatorGroup16: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_80_wire;
      binary_82_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
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
    end Block; -- split operator group 16
    -- shared split operator group (17) : binary_85_inst 
    SplitOperatorGroup17: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_in_23;
      binary_85_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApConcat",
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
          owidth => 11,
          constant_operand => "0",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_85_inst_req_0,
          ackL => binary_85_inst_ack_0,
          reqR => binary_85_inst_req_1,
          ackR => binary_85_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 17
    -- shared split operator group (18) : binary_87_inst 
    SplitOperatorGroup18: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_85_wire;
      binary_87_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_87_inst_req_0,
          ackL => binary_87_inst_ack_0,
          reqR => binary_87_inst_req_1,
          ackR => binary_87_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 18
    -- shared split operator group (19) : binary_93_inst 
    SplitOperatorGroup19: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= nu_89;
      binary_93_wire <= data_out(10 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 11,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 11,
          constant_operand => "0001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_93_inst_req_0,
          ackL => binary_93_inst_ack_0,
          reqR => binary_93_inst_req_1,
          ackR => binary_93_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 19
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
    sum_mod_b : in  std_logic_vector(9 downto 0);
    sum_mod_aXb : out  std_logic_vector(19 downto 0);
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
      b : in  std_logic_vector(9 downto 0);
      aXb : out  std_logic_vector(19 downto 0);
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
      aXb => sum_mod_aXb,
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
      sum_mod_b : in  std_logic_vector(9 downto 0);
      sum_mod_aXb : out  std_logic_vector(19 downto 0);
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
  signal sum_mod_b :  std_logic_vector(9 downto 0);
  signal sum_mod_aXb :   std_logic_vector(19 downto 0);
  signal sum_mod_tag_in: std_logic_vector(0 downto 0);
  signal sum_mod_tag_out: std_logic_vector(0 downto 0);
  signal sum_mod_start : std_logic := '0';
  signal sum_mod_fin   : std_logic := '0';
  -- 
begin --

  clk <= not clk after 5 ns;
  sum_mod_a <= (1 => '1', 0 => '1', others => '0');
  sum_mod_b <= (1 => '1', 0 => '1', others => '0');
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
      sum_mod_aXb => sum_mod_aXb,
      sum_mod_tag_in => sum_mod_tag_in,
      sum_mod_tag_out => sum_mod_tag_out,
      sum_mod_start => sum_mod_start,
      sum_mod_fin  => sum_mod_fin ,
      clk => clk,
      reset => reset); -- 
  -- 
end Default;
