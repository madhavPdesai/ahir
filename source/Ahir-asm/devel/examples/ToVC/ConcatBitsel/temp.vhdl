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
  signal binary_42_inst_req_0 : boolean;
  signal binary_42_inst_ack_0 : boolean;
  signal binary_42_inst_req_1 : boolean;
  signal binary_42_inst_ack_1 : boolean;
  signal binary_44_inst_req_0 : boolean;
  signal binary_44_inst_ack_0 : boolean;
  signal binary_44_inst_req_1 : boolean;
  signal binary_44_inst_ack_1 : boolean;
  signal type_cast_79_inst_req_0 : boolean;
  signal type_cast_79_inst_ack_0 : boolean;
  signal binary_50_inst_req_0 : boolean;
  signal binary_50_inst_ack_0 : boolean;
  signal binary_50_inst_req_1 : boolean;
  signal binary_50_inst_ack_1 : boolean;
  signal if_stmt_47_branch_req_0 : boolean;
  signal if_stmt_47_branch_ack_1 : boolean;
  signal binary_33_inst_req_0 : boolean;
  signal binary_33_inst_ack_0 : boolean;
  signal binary_33_inst_req_1 : boolean;
  signal binary_33_inst_ack_1 : boolean;
  signal binary_35_inst_req_0 : boolean;
  signal binary_35_inst_ack_0 : boolean;
  signal binary_35_inst_req_1 : boolean;
  signal binary_35_inst_ack_1 : boolean;
  signal binary_37_inst_req_0 : boolean;
  signal binary_37_inst_ack_0 : boolean;
  signal binary_37_inst_req_1 : boolean;
  signal binary_37_inst_ack_1 : boolean;
  signal if_stmt_47_branch_ack_0 : boolean;
  signal binary_64_inst_req_0 : boolean;
  signal binary_64_inst_ack_0 : boolean;
  signal binary_64_inst_req_1 : boolean;
  signal binary_64_inst_ack_1 : boolean;
  signal binary_66_inst_req_0 : boolean;
  signal binary_66_inst_ack_0 : boolean;
  signal binary_66_inst_req_1 : boolean;
  signal binary_66_inst_ack_1 : boolean;
  signal binary_68_inst_req_0 : boolean;
  signal binary_68_inst_ack_0 : boolean;
  signal binary_68_inst_req_1 : boolean;
  signal binary_68_inst_ack_1 : boolean;
  signal binary_74_inst_req_0 : boolean;
  signal binary_74_inst_ack_0 : boolean;
  signal binary_74_inst_req_1 : boolean;
  signal binary_74_inst_ack_1 : boolean;
  signal type_cast_75_inst_req_0 : boolean;
  signal type_cast_75_inst_ack_0 : boolean;
  signal binary_84_inst_req_0 : boolean;
  signal binary_84_inst_ack_0 : boolean;
  signal binary_84_inst_req_1 : boolean;
  signal binary_84_inst_ack_1 : boolean;
  signal binary_90_inst_req_0 : boolean;
  signal binary_90_inst_ack_0 : boolean;
  signal binary_90_inst_req_1 : boolean;
  signal binary_90_inst_ack_1 : boolean;
  signal if_stmt_87_branch_req_0 : boolean;
  signal if_stmt_87_branch_ack_1 : boolean;
  signal if_stmt_87_branch_ack_0 : boolean;
  signal phi_stmt_16_req_0 : boolean;
  signal phi_stmt_20_req_0 : boolean;
  signal phi_stmt_24_req_0 : boolean;
  signal phi_stmt_16_req_1 : boolean;
  signal phi_stmt_20_req_1 : boolean;
  signal phi_stmt_24_req_1 : boolean;
  signal phi_stmt_16_ack_0 : boolean;
  signal phi_stmt_20_ack_0 : boolean;
  signal phi_stmt_24_ack_0 : boolean;
  signal phi_stmt_56_req_1 : boolean;
  signal phi_stmt_56_req_0 : boolean;
  signal phi_stmt_56_ack_0 : boolean;
  signal binary_99_inst_req_0 : boolean;
  signal binary_99_inst_ack_0 : boolean;
  signal binary_99_inst_req_1 : boolean;
  signal binary_99_inst_ack_1 : boolean;
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
    signal branch_block_stmt_14_3_symbol : Boolean;
    signal assign_stmt_100_238_symbol : Boolean;
    -- 
  begin -- 
    sum_mod_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= sum_mod_CP_0_start; -- transition $entry
    branch_block_stmt_14_3: Block -- branch_block_stmt_14 
      signal branch_block_stmt_14_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_14_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_14_x_xexit_x_xx_x7_symbol : Boolean;
      signal merge_stmt_15_x_xexit_x_xx_x8_symbol : Boolean;
      signal parallel_block_stmt_29_x_xentry_x_xx_x9_symbol : Boolean;
      signal parallel_block_stmt_29_x_xexit_x_xx_x10_symbol : Boolean;
      signal if_stmt_47_x_xentry_x_xx_x11_symbol : Boolean;
      signal merge_stmt_55_x_xexit_x_xx_x12_symbol : Boolean;
      signal assign_stmt_69_x_xentry_x_xx_x13_symbol : Boolean;
      signal assign_stmt_69_x_xexit_x_xx_x14_symbol : Boolean;
      signal parallel_block_stmt_70_x_xentry_x_xx_x15_symbol : Boolean;
      signal parallel_block_stmt_70_x_xexit_x_xx_x16_symbol : Boolean;
      signal if_stmt_87_x_xentry_x_xx_x17_symbol : Boolean;
      signal parallel_block_stmt_29_18_symbol : Boolean;
      signal if_stmt_47_eval_test_77_symbol : Boolean;
      signal binary_50_place_91_symbol : Boolean;
      signal if_stmt_47_if_link_92_symbol : Boolean;
      signal if_stmt_47_else_link_96_symbol : Boolean;
      signal if1_100_symbol : Boolean;
      signal if0_101_symbol : Boolean;
      signal assign_stmt_69_102_symbol : Boolean;
      signal parallel_block_stmt_70_135_symbol : Boolean;
      signal if_stmt_87_eval_test_177_symbol : Boolean;
      signal binary_90_place_191_symbol : Boolean;
      signal if_stmt_87_if_link_192_symbol : Boolean;
      signal if_stmt_87_else_link_196_symbol : Boolean;
      signal stmt_91_x_xentry_x_xx_x200_symbol : Boolean;
      signal stmt_91_x_xexit_x_xx_x201_symbol : Boolean;
      signal stmt_91_202_symbol : Boolean;
      signal loopback_205_symbol : Boolean;
      signal branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206_symbol : Boolean;
      signal loopback_PhiReq_212_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_218_symbol : Boolean;
      signal merge_stmt_15_PhiAck_219_symbol : Boolean;
      signal if0_PhiReq_225_symbol : Boolean;
      signal if1_PhiReq_229_symbol : Boolean;
      signal merge_stmt_55_PhiReqMerge_233_symbol : Boolean;
      signal merge_stmt_55_PhiAck_234_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_14_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_14_3_start; -- transition branch_block_stmt_14/$entry
      branch_block_stmt_14_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_14/branch_block_stmt_14__entry__ (optimized away) 
      branch_block_stmt_14_x_xexit_x_xx_x7_symbol  <=  stmt_91_x_xexit_x_xx_x201_symbol; -- place branch_block_stmt_14/branch_block_stmt_14__exit__ (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x8_symbol  <=  merge_stmt_15_PhiAck_219_symbol; -- place branch_block_stmt_14/merge_stmt_15__exit__ (optimized away) 
      parallel_block_stmt_29_x_xentry_x_xx_x9_symbol  <=  merge_stmt_15_x_xexit_x_xx_x8_symbol; -- place branch_block_stmt_14/parallel_block_stmt_29__entry__ (optimized away) 
      parallel_block_stmt_29_x_xexit_x_xx_x10_symbol  <=  parallel_block_stmt_29_18_symbol; -- place branch_block_stmt_14/parallel_block_stmt_29__exit__ (optimized away) 
      if_stmt_47_x_xentry_x_xx_x11_symbol  <=  parallel_block_stmt_29_x_xexit_x_xx_x10_symbol; -- place branch_block_stmt_14/if_stmt_47__entry__ (optimized away) 
      merge_stmt_55_x_xexit_x_xx_x12_symbol  <=  merge_stmt_55_PhiAck_234_symbol; -- place branch_block_stmt_14/merge_stmt_55__exit__ (optimized away) 
      assign_stmt_69_x_xentry_x_xx_x13_symbol  <=  merge_stmt_55_x_xexit_x_xx_x12_symbol; -- place branch_block_stmt_14/assign_stmt_69__entry__ (optimized away) 
      assign_stmt_69_x_xexit_x_xx_x14_symbol  <=  assign_stmt_69_102_symbol; -- place branch_block_stmt_14/assign_stmt_69__exit__ (optimized away) 
      parallel_block_stmt_70_x_xentry_x_xx_x15_symbol  <=  assign_stmt_69_x_xexit_x_xx_x14_symbol; -- place branch_block_stmt_14/parallel_block_stmt_70__entry__ (optimized away) 
      parallel_block_stmt_70_x_xexit_x_xx_x16_symbol  <=  parallel_block_stmt_70_135_symbol; -- place branch_block_stmt_14/parallel_block_stmt_70__exit__ (optimized away) 
      if_stmt_87_x_xentry_x_xx_x17_symbol  <=  parallel_block_stmt_70_x_xexit_x_xx_x16_symbol; -- place branch_block_stmt_14/if_stmt_87__entry__ (optimized away) 
      parallel_block_stmt_29_18: Block -- branch_block_stmt_14/parallel_block_stmt_29 
        signal parallel_block_stmt_29_18_start: Boolean;
        signal Xentry_19_symbol: Boolean;
        signal Xexit_20_symbol: Boolean;
        signal assign_stmt_38_21_symbol : Boolean;
        signal assign_stmt_45_54_symbol : Boolean;
        -- 
      begin -- 
        parallel_block_stmt_29_18_start <= parallel_block_stmt_29_x_xentry_x_xx_x9_symbol; -- control passed to block
        Xentry_19_symbol  <= parallel_block_stmt_29_18_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/$entry
        assign_stmt_38_21: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38 
          signal assign_stmt_38_21_start: Boolean;
          signal Xentry_22_symbol: Boolean;
          signal Xexit_23_symbol: Boolean;
          signal binary_37_24_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_38_21_start <= Xentry_19_symbol; -- control passed to block
          Xentry_22_symbol  <= assign_stmt_38_21_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/$entry
          binary_37_24: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37 
            signal binary_37_24_start: Boolean;
            signal Xentry_25_symbol: Boolean;
            signal Xexit_26_symbol: Boolean;
            signal binary_37_inputs_27_symbol : Boolean;
            signal rr_50_symbol : Boolean;
            signal ra_51_symbol : Boolean;
            signal cr_52_symbol : Boolean;
            signal ca_53_symbol : Boolean;
            -- 
          begin -- 
            binary_37_24_start <= Xentry_22_symbol; -- control passed to block
            Xentry_25_symbol  <= binary_37_24_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/$entry
            binary_37_inputs_27: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs 
              signal binary_37_inputs_27_start: Boolean;
              signal Xentry_28_symbol: Boolean;
              signal Xexit_29_symbol: Boolean;
              signal binary_35_30_symbol : Boolean;
              -- 
            begin -- 
              binary_37_inputs_27_start <= Xentry_25_symbol; -- control passed to block
              Xentry_28_symbol  <= binary_37_inputs_27_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/$entry
              binary_35_30: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35 
                signal binary_35_30_start: Boolean;
                signal Xentry_31_symbol: Boolean;
                signal Xexit_32_symbol: Boolean;
                signal binary_35_inputs_33_symbol : Boolean;
                signal rr_46_symbol : Boolean;
                signal ra_47_symbol : Boolean;
                signal cr_48_symbol : Boolean;
                signal ca_49_symbol : Boolean;
                -- 
              begin -- 
                binary_35_30_start <= Xentry_28_symbol; -- control passed to block
                Xentry_31_symbol  <= binary_35_30_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/$entry
                binary_35_inputs_33: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs 
                  signal binary_35_inputs_33_start: Boolean;
                  signal Xentry_34_symbol: Boolean;
                  signal Xexit_35_symbol: Boolean;
                  signal binary_33_36_symbol : Boolean;
                  -- 
                begin -- 
                  binary_35_inputs_33_start <= Xentry_31_symbol; -- control passed to block
                  Xentry_34_symbol  <= binary_35_inputs_33_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/$entry
                  binary_33_36: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33 
                    signal binary_33_36_start: Boolean;
                    signal Xentry_37_symbol: Boolean;
                    signal Xexit_38_symbol: Boolean;
                    signal binary_33_inputs_39_symbol : Boolean;
                    signal rr_42_symbol : Boolean;
                    signal ra_43_symbol : Boolean;
                    signal cr_44_symbol : Boolean;
                    signal ca_45_symbol : Boolean;
                    -- 
                  begin -- 
                    binary_33_36_start <= Xentry_34_symbol; -- control passed to block
                    Xentry_37_symbol  <= binary_33_36_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/$entry
                    binary_33_inputs_39: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/binary_33_inputs 
                      signal binary_33_inputs_39_start: Boolean;
                      signal Xentry_40_symbol: Boolean;
                      signal Xexit_41_symbol: Boolean;
                      -- 
                    begin -- 
                      binary_33_inputs_39_start <= Xentry_37_symbol; -- control passed to block
                      Xentry_40_symbol  <= binary_33_inputs_39_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/binary_33_inputs/$entry
                      Xexit_41_symbol <= Xentry_40_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/binary_33_inputs/$exit
                      binary_33_inputs_39_symbol <= Xexit_41_symbol; -- control passed from block 
                      -- 
                    end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/binary_33_inputs
                    rr_42_symbol <= binary_33_inputs_39_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/rr
                    binary_33_inst_req_0 <= rr_42_symbol; -- link to DP
                    ra_43_symbol <= binary_33_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/ra
                    cr_44_symbol <= ra_43_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/cr
                    binary_33_inst_req_1 <= cr_44_symbol; -- link to DP
                    ca_45_symbol <= binary_33_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/ca
                    Xexit_38_symbol <= ca_45_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33/$exit
                    binary_33_36_symbol <= Xexit_38_symbol; -- control passed from block 
                    -- 
                  end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/binary_33
                  Xexit_35_symbol <= binary_33_36_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs/$exit
                  binary_35_inputs_33_symbol <= Xexit_35_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/binary_35_inputs
                rr_46_symbol <= binary_35_inputs_33_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/rr
                binary_35_inst_req_0 <= rr_46_symbol; -- link to DP
                ra_47_symbol <= binary_35_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/ra
                cr_48_symbol <= ra_47_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/cr
                binary_35_inst_req_1 <= cr_48_symbol; -- link to DP
                ca_49_symbol <= binary_35_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/ca
                Xexit_32_symbol <= ca_49_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35/$exit
                binary_35_30_symbol <= Xexit_32_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/binary_35
              Xexit_29_symbol <= binary_35_30_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs/$exit
              binary_37_inputs_27_symbol <= Xexit_29_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/binary_37_inputs
            rr_50_symbol <= binary_37_inputs_27_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/rr
            binary_37_inst_req_0 <= rr_50_symbol; -- link to DP
            ra_51_symbol <= binary_37_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/ra
            cr_52_symbol <= ra_51_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/cr
            binary_37_inst_req_1 <= cr_52_symbol; -- link to DP
            ca_53_symbol <= binary_37_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/ca
            Xexit_26_symbol <= ca_53_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37/$exit
            binary_37_24_symbol <= Xexit_26_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/binary_37
          Xexit_23_symbol <= binary_37_24_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38/$exit
          assign_stmt_38_21_symbol <= Xexit_23_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_38
        assign_stmt_45_54: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45 
          signal assign_stmt_45_54_start: Boolean;
          signal Xentry_55_symbol: Boolean;
          signal Xexit_56_symbol: Boolean;
          signal binary_44_57_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_45_54_start <= Xentry_19_symbol; -- control passed to block
          Xentry_55_symbol  <= assign_stmt_45_54_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/$entry
          binary_44_57: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44 
            signal binary_44_57_start: Boolean;
            signal Xentry_58_symbol: Boolean;
            signal Xexit_59_symbol: Boolean;
            signal binary_44_inputs_60_symbol : Boolean;
            signal rr_73_symbol : Boolean;
            signal ra_74_symbol : Boolean;
            signal cr_75_symbol : Boolean;
            signal ca_76_symbol : Boolean;
            -- 
          begin -- 
            binary_44_57_start <= Xentry_55_symbol; -- control passed to block
            Xentry_58_symbol  <= binary_44_57_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/$entry
            binary_44_inputs_60: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs 
              signal binary_44_inputs_60_start: Boolean;
              signal Xentry_61_symbol: Boolean;
              signal Xexit_62_symbol: Boolean;
              signal binary_42_63_symbol : Boolean;
              -- 
            begin -- 
              binary_44_inputs_60_start <= Xentry_58_symbol; -- control passed to block
              Xentry_61_symbol  <= binary_44_inputs_60_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/$entry
              binary_42_63: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42 
                signal binary_42_63_start: Boolean;
                signal Xentry_64_symbol: Boolean;
                signal Xexit_65_symbol: Boolean;
                signal binary_42_inputs_66_symbol : Boolean;
                signal rr_69_symbol : Boolean;
                signal ra_70_symbol : Boolean;
                signal cr_71_symbol : Boolean;
                signal ca_72_symbol : Boolean;
                -- 
              begin -- 
                binary_42_63_start <= Xentry_61_symbol; -- control passed to block
                Xentry_64_symbol  <= binary_42_63_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/$entry
                binary_42_inputs_66: Block -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/binary_42_inputs 
                  signal binary_42_inputs_66_start: Boolean;
                  signal Xentry_67_symbol: Boolean;
                  signal Xexit_68_symbol: Boolean;
                  -- 
                begin -- 
                  binary_42_inputs_66_start <= Xentry_64_symbol; -- control passed to block
                  Xentry_67_symbol  <= binary_42_inputs_66_start; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/binary_42_inputs/$entry
                  Xexit_68_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/binary_42_inputs/$exit
                  binary_42_inputs_66_symbol <= Xexit_68_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/binary_42_inputs
                rr_69_symbol <= binary_42_inputs_66_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/rr
                binary_42_inst_req_0 <= rr_69_symbol; -- link to DP
                ra_70_symbol <= binary_42_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/ra
                cr_71_symbol <= ra_70_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/cr
                binary_42_inst_req_1 <= cr_71_symbol; -- link to DP
                ca_72_symbol <= binary_42_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/ca
                Xexit_65_symbol <= ca_72_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42/$exit
                binary_42_63_symbol <= Xexit_65_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/binary_42
              Xexit_62_symbol <= binary_42_63_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs/$exit
              binary_44_inputs_60_symbol <= Xexit_62_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/binary_44_inputs
            rr_73_symbol <= binary_44_inputs_60_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/rr
            binary_44_inst_req_0 <= rr_73_symbol; -- link to DP
            ra_74_symbol <= binary_44_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/ra
            cr_75_symbol <= ra_74_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/cr
            binary_44_inst_req_1 <= cr_75_symbol; -- link to DP
            ca_76_symbol <= binary_44_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/ca
            Xexit_59_symbol <= ca_76_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44/$exit
            binary_44_57_symbol <= Xexit_59_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/binary_44
          Xexit_56_symbol <= binary_44_57_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45/$exit
          assign_stmt_45_54_symbol <= Xexit_56_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/parallel_block_stmt_29/assign_stmt_45
        Xexit_20_block : Block -- non-trivial join transition branch_block_stmt_14/parallel_block_stmt_29/$exit 
          signal Xexit_20_predecessors: BooleanArray(1 downto 0);
          signal Xexit_20_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_20_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_20_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_20_p1_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_20_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_20_p0_pred, Xexit_20_p0_succ, Xexit_20_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_20_p0_succ(0) <=  Xexit_20_symbol;
          Xexit_20_p0_pred(0) <=  assign_stmt_38_21_symbol;
          Xexit_20_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_20_p1_pred, Xexit_20_p1_succ, Xexit_20_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_20_p1_succ(0) <=  Xexit_20_symbol;
          Xexit_20_p1_pred(0) <=  assign_stmt_45_54_symbol;
          Xexit_20_symbol <= AndReduce(Xexit_20_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_14/parallel_block_stmt_29/$exit
        parallel_block_stmt_29_18_symbol <= Xexit_20_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/parallel_block_stmt_29
      if_stmt_47_eval_test_77: Block -- branch_block_stmt_14/if_stmt_47_eval_test 
        signal if_stmt_47_eval_test_77_start: Boolean;
        signal Xentry_78_symbol: Boolean;
        signal Xexit_79_symbol: Boolean;
        signal binary_50_80_symbol : Boolean;
        signal branch_req_90_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_47_eval_test_77_start <= if_stmt_47_x_xentry_x_xx_x11_symbol; -- control passed to block
        Xentry_78_symbol  <= if_stmt_47_eval_test_77_start; -- transition branch_block_stmt_14/if_stmt_47_eval_test/$entry
        binary_50_80: Block -- branch_block_stmt_14/if_stmt_47_eval_test/binary_50 
          signal binary_50_80_start: Boolean;
          signal Xentry_81_symbol: Boolean;
          signal Xexit_82_symbol: Boolean;
          signal binary_50_inputs_83_symbol : Boolean;
          signal rr_86_symbol : Boolean;
          signal ra_87_symbol : Boolean;
          signal cr_88_symbol : Boolean;
          signal ca_89_symbol : Boolean;
          -- 
        begin -- 
          binary_50_80_start <= Xentry_78_symbol; -- control passed to block
          Xentry_81_symbol  <= binary_50_80_start; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/$entry
          binary_50_inputs_83: Block -- branch_block_stmt_14/if_stmt_47_eval_test/binary_50/binary_50_inputs 
            signal binary_50_inputs_83_start: Boolean;
            signal Xentry_84_symbol: Boolean;
            signal Xexit_85_symbol: Boolean;
            -- 
          begin -- 
            binary_50_inputs_83_start <= Xentry_81_symbol; -- control passed to block
            Xentry_84_symbol  <= binary_50_inputs_83_start; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/binary_50_inputs/$entry
            Xexit_85_symbol <= Xentry_84_symbol; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/binary_50_inputs/$exit
            binary_50_inputs_83_symbol <= Xexit_85_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/if_stmt_47_eval_test/binary_50/binary_50_inputs
          rr_86_symbol <= binary_50_inputs_83_symbol; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/rr
          binary_50_inst_req_0 <= rr_86_symbol; -- link to DP
          ra_87_symbol <= binary_50_inst_ack_0; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/ra
          cr_88_symbol <= ra_87_symbol; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/cr
          binary_50_inst_req_1 <= cr_88_symbol; -- link to DP
          ca_89_symbol <= binary_50_inst_ack_1; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/ca
          Xexit_82_symbol <= ca_89_symbol; -- transition branch_block_stmt_14/if_stmt_47_eval_test/binary_50/$exit
          binary_50_80_symbol <= Xexit_82_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/if_stmt_47_eval_test/binary_50
        branch_req_90_symbol <= binary_50_80_symbol; -- transition branch_block_stmt_14/if_stmt_47_eval_test/branch_req
        if_stmt_47_branch_req_0 <= branch_req_90_symbol; -- link to DP
        Xexit_79_symbol <= branch_req_90_symbol; -- transition branch_block_stmt_14/if_stmt_47_eval_test/$exit
        if_stmt_47_eval_test_77_symbol <= Xexit_79_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if_stmt_47_eval_test
      binary_50_place_91_symbol  <=  if_stmt_47_eval_test_77_symbol; -- place branch_block_stmt_14/binary_50_place (optimized away) 
      if_stmt_47_if_link_92: Block -- branch_block_stmt_14/if_stmt_47_if_link 
        signal if_stmt_47_if_link_92_start: Boolean;
        signal Xentry_93_symbol: Boolean;
        signal Xexit_94_symbol: Boolean;
        signal if_choice_transition_95_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_47_if_link_92_start <= binary_50_place_91_symbol; -- control passed to block
        Xentry_93_symbol  <= if_stmt_47_if_link_92_start; -- transition branch_block_stmt_14/if_stmt_47_if_link/$entry
        if_choice_transition_95_symbol <= if_stmt_47_branch_ack_1; -- transition branch_block_stmt_14/if_stmt_47_if_link/if_choice_transition
        Xexit_94_symbol <= if_choice_transition_95_symbol; -- transition branch_block_stmt_14/if_stmt_47_if_link/$exit
        if_stmt_47_if_link_92_symbol <= Xexit_94_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if_stmt_47_if_link
      if_stmt_47_else_link_96: Block -- branch_block_stmt_14/if_stmt_47_else_link 
        signal if_stmt_47_else_link_96_start: Boolean;
        signal Xentry_97_symbol: Boolean;
        signal Xexit_98_symbol: Boolean;
        signal else_choice_transition_99_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_47_else_link_96_start <= binary_50_place_91_symbol; -- control passed to block
        Xentry_97_symbol  <= if_stmt_47_else_link_96_start; -- transition branch_block_stmt_14/if_stmt_47_else_link/$entry
        else_choice_transition_99_symbol <= if_stmt_47_branch_ack_0; -- transition branch_block_stmt_14/if_stmt_47_else_link/else_choice_transition
        Xexit_98_symbol <= else_choice_transition_99_symbol; -- transition branch_block_stmt_14/if_stmt_47_else_link/$exit
        if_stmt_47_else_link_96_symbol <= Xexit_98_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if_stmt_47_else_link
      if1_100_symbol  <=  if_stmt_47_if_link_92_symbol; -- place branch_block_stmt_14/if1 (optimized away) 
      if0_101_symbol  <=  if_stmt_47_else_link_96_symbol; -- place branch_block_stmt_14/if0 (optimized away) 
      assign_stmt_69_102: Block -- branch_block_stmt_14/assign_stmt_69 
        signal assign_stmt_69_102_start: Boolean;
        signal Xentry_103_symbol: Boolean;
        signal Xexit_104_symbol: Boolean;
        signal binary_68_105_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_69_102_start <= assign_stmt_69_x_xentry_x_xx_x13_symbol; -- control passed to block
        Xentry_103_symbol  <= assign_stmt_69_102_start; -- transition branch_block_stmt_14/assign_stmt_69/$entry
        binary_68_105: Block -- branch_block_stmt_14/assign_stmt_69/binary_68 
          signal binary_68_105_start: Boolean;
          signal Xentry_106_symbol: Boolean;
          signal Xexit_107_symbol: Boolean;
          signal binary_68_inputs_108_symbol : Boolean;
          signal rr_131_symbol : Boolean;
          signal ra_132_symbol : Boolean;
          signal cr_133_symbol : Boolean;
          signal ca_134_symbol : Boolean;
          -- 
        begin -- 
          binary_68_105_start <= Xentry_103_symbol; -- control passed to block
          Xentry_106_symbol  <= binary_68_105_start; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/$entry
          binary_68_inputs_108: Block -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs 
            signal binary_68_inputs_108_start: Boolean;
            signal Xentry_109_symbol: Boolean;
            signal Xexit_110_symbol: Boolean;
            signal binary_66_111_symbol : Boolean;
            -- 
          begin -- 
            binary_68_inputs_108_start <= Xentry_106_symbol; -- control passed to block
            Xentry_109_symbol  <= binary_68_inputs_108_start; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/$entry
            binary_66_111: Block -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66 
              signal binary_66_111_start: Boolean;
              signal Xentry_112_symbol: Boolean;
              signal Xexit_113_symbol: Boolean;
              signal binary_66_inputs_114_symbol : Boolean;
              signal rr_127_symbol : Boolean;
              signal ra_128_symbol : Boolean;
              signal cr_129_symbol : Boolean;
              signal ca_130_symbol : Boolean;
              -- 
            begin -- 
              binary_66_111_start <= Xentry_109_symbol; -- control passed to block
              Xentry_112_symbol  <= binary_66_111_start; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/$entry
              binary_66_inputs_114: Block -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs 
                signal binary_66_inputs_114_start: Boolean;
                signal Xentry_115_symbol: Boolean;
                signal Xexit_116_symbol: Boolean;
                signal binary_64_117_symbol : Boolean;
                -- 
              begin -- 
                binary_66_inputs_114_start <= Xentry_112_symbol; -- control passed to block
                Xentry_115_symbol  <= binary_66_inputs_114_start; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/$entry
                binary_64_117: Block -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64 
                  signal binary_64_117_start: Boolean;
                  signal Xentry_118_symbol: Boolean;
                  signal Xexit_119_symbol: Boolean;
                  signal binary_64_inputs_120_symbol : Boolean;
                  signal rr_123_symbol : Boolean;
                  signal ra_124_symbol : Boolean;
                  signal cr_125_symbol : Boolean;
                  signal ca_126_symbol : Boolean;
                  -- 
                begin -- 
                  binary_64_117_start <= Xentry_115_symbol; -- control passed to block
                  Xentry_118_symbol  <= binary_64_117_start; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/$entry
                  binary_64_inputs_120: Block -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/binary_64_inputs 
                    signal binary_64_inputs_120_start: Boolean;
                    signal Xentry_121_symbol: Boolean;
                    signal Xexit_122_symbol: Boolean;
                    -- 
                  begin -- 
                    binary_64_inputs_120_start <= Xentry_118_symbol; -- control passed to block
                    Xentry_121_symbol  <= binary_64_inputs_120_start; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/binary_64_inputs/$entry
                    Xexit_122_symbol <= Xentry_121_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/binary_64_inputs/$exit
                    binary_64_inputs_120_symbol <= Xexit_122_symbol; -- control passed from block 
                    -- 
                  end Block; -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/binary_64_inputs
                  rr_123_symbol <= binary_64_inputs_120_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/rr
                  binary_64_inst_req_0 <= rr_123_symbol; -- link to DP
                  ra_124_symbol <= binary_64_inst_ack_0; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/ra
                  cr_125_symbol <= ra_124_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/cr
                  binary_64_inst_req_1 <= cr_125_symbol; -- link to DP
                  ca_126_symbol <= binary_64_inst_ack_1; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/ca
                  Xexit_119_symbol <= ca_126_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64/$exit
                  binary_64_117_symbol <= Xexit_119_symbol; -- control passed from block 
                  -- 
                end Block; -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/binary_64
                Xexit_116_symbol <= binary_64_117_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs/$exit
                binary_66_inputs_114_symbol <= Xexit_116_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/binary_66_inputs
              rr_127_symbol <= binary_66_inputs_114_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/rr
              binary_66_inst_req_0 <= rr_127_symbol; -- link to DP
              ra_128_symbol <= binary_66_inst_ack_0; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/ra
              cr_129_symbol <= ra_128_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/cr
              binary_66_inst_req_1 <= cr_129_symbol; -- link to DP
              ca_130_symbol <= binary_66_inst_ack_1; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/ca
              Xexit_113_symbol <= ca_130_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66/$exit
              binary_66_111_symbol <= Xexit_113_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/binary_66
            Xexit_110_symbol <= binary_66_111_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs/$exit
            binary_68_inputs_108_symbol <= Xexit_110_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/assign_stmt_69/binary_68/binary_68_inputs
          rr_131_symbol <= binary_68_inputs_108_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/rr
          binary_68_inst_req_0 <= rr_131_symbol; -- link to DP
          ra_132_symbol <= binary_68_inst_ack_0; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/ra
          cr_133_symbol <= ra_132_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/cr
          binary_68_inst_req_1 <= cr_133_symbol; -- link to DP
          ca_134_symbol <= binary_68_inst_ack_1; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/ca
          Xexit_107_symbol <= ca_134_symbol; -- transition branch_block_stmt_14/assign_stmt_69/binary_68/$exit
          binary_68_105_symbol <= Xexit_107_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/assign_stmt_69/binary_68
        Xexit_104_symbol <= binary_68_105_symbol; -- transition branch_block_stmt_14/assign_stmt_69/$exit
        assign_stmt_69_102_symbol <= Xexit_104_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/assign_stmt_69
      parallel_block_stmt_70_135: Block -- branch_block_stmt_14/parallel_block_stmt_70 
        signal parallel_block_stmt_70_135_start: Boolean;
        signal Xentry_136_symbol: Boolean;
        signal Xexit_137_symbol: Boolean;
        signal assign_stmt_76_138_symbol : Boolean;
        signal assign_stmt_80_156_symbol : Boolean;
        signal assign_stmt_85_164_symbol : Boolean;
        -- 
      begin -- 
        parallel_block_stmt_70_135_start <= parallel_block_stmt_70_x_xentry_x_xx_x15_symbol; -- control passed to block
        Xentry_136_symbol  <= parallel_block_stmt_70_135_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/$entry
        assign_stmt_76_138: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76 
          signal assign_stmt_76_138_start: Boolean;
          signal Xentry_139_symbol: Boolean;
          signal Xexit_140_symbol: Boolean;
          signal type_cast_75_141_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_76_138_start <= Xentry_136_symbol; -- control passed to block
          Xentry_139_symbol  <= assign_stmt_76_138_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/$entry
          type_cast_75_141: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75 
            signal type_cast_75_141_start: Boolean;
            signal Xentry_142_symbol: Boolean;
            signal Xexit_143_symbol: Boolean;
            signal binary_74_144_symbol : Boolean;
            signal req_154_symbol : Boolean;
            signal ack_155_symbol : Boolean;
            -- 
          begin -- 
            type_cast_75_141_start <= Xentry_139_symbol; -- control passed to block
            Xentry_142_symbol  <= type_cast_75_141_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/$entry
            binary_74_144: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74 
              signal binary_74_144_start: Boolean;
              signal Xentry_145_symbol: Boolean;
              signal Xexit_146_symbol: Boolean;
              signal binary_74_inputs_147_symbol : Boolean;
              signal rr_150_symbol : Boolean;
              signal ra_151_symbol : Boolean;
              signal cr_152_symbol : Boolean;
              signal ca_153_symbol : Boolean;
              -- 
            begin -- 
              binary_74_144_start <= Xentry_142_symbol; -- control passed to block
              Xentry_145_symbol  <= binary_74_144_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/$entry
              binary_74_inputs_147: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/binary_74_inputs 
                signal binary_74_inputs_147_start: Boolean;
                signal Xentry_148_symbol: Boolean;
                signal Xexit_149_symbol: Boolean;
                -- 
              begin -- 
                binary_74_inputs_147_start <= Xentry_145_symbol; -- control passed to block
                Xentry_148_symbol  <= binary_74_inputs_147_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/binary_74_inputs/$entry
                Xexit_149_symbol <= Xentry_148_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/binary_74_inputs/$exit
                binary_74_inputs_147_symbol <= Xexit_149_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/binary_74_inputs
              rr_150_symbol <= binary_74_inputs_147_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/rr
              binary_74_inst_req_0 <= rr_150_symbol; -- link to DP
              ra_151_symbol <= binary_74_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/ra
              cr_152_symbol <= ra_151_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/cr
              binary_74_inst_req_1 <= cr_152_symbol; -- link to DP
              ca_153_symbol <= binary_74_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/ca
              Xexit_146_symbol <= ca_153_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74/$exit
              binary_74_144_symbol <= Xexit_146_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/binary_74
            req_154_symbol <= binary_74_144_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/req
            type_cast_75_inst_req_0 <= req_154_symbol; -- link to DP
            ack_155_symbol <= type_cast_75_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/ack
            Xexit_143_symbol <= ack_155_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75/$exit
            type_cast_75_141_symbol <= Xexit_143_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/type_cast_75
          Xexit_140_symbol <= type_cast_75_141_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76/$exit
          assign_stmt_76_138_symbol <= Xexit_140_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_76
        assign_stmt_80_156: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80 
          signal assign_stmt_80_156_start: Boolean;
          signal Xentry_157_symbol: Boolean;
          signal Xexit_158_symbol: Boolean;
          signal type_cast_79_159_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_80_156_start <= Xentry_136_symbol; -- control passed to block
          Xentry_157_symbol  <= assign_stmt_80_156_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/$entry
          type_cast_79_159: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/type_cast_79 
            signal type_cast_79_159_start: Boolean;
            signal Xentry_160_symbol: Boolean;
            signal Xexit_161_symbol: Boolean;
            signal req_162_symbol : Boolean;
            signal ack_163_symbol : Boolean;
            -- 
          begin -- 
            type_cast_79_159_start <= Xentry_157_symbol; -- control passed to block
            Xentry_160_symbol  <= type_cast_79_159_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/type_cast_79/$entry
            req_162_symbol <= Xentry_160_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/type_cast_79/req
            type_cast_79_inst_req_0 <= req_162_symbol; -- link to DP
            ack_163_symbol <= type_cast_79_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/type_cast_79/ack
            Xexit_161_symbol <= ack_163_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/type_cast_79/$exit
            type_cast_79_159_symbol <= Xexit_161_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/type_cast_79
          Xexit_158_symbol <= type_cast_79_159_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80/$exit
          assign_stmt_80_156_symbol <= Xexit_158_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_80
        assign_stmt_85_164: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85 
          signal assign_stmt_85_164_start: Boolean;
          signal Xentry_165_symbol: Boolean;
          signal Xexit_166_symbol: Boolean;
          signal binary_84_167_symbol : Boolean;
          -- 
        begin -- 
          assign_stmt_85_164_start <= Xentry_136_symbol; -- control passed to block
          Xentry_165_symbol  <= assign_stmt_85_164_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/$entry
          binary_84_167: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84 
            signal binary_84_167_start: Boolean;
            signal Xentry_168_symbol: Boolean;
            signal Xexit_169_symbol: Boolean;
            signal binary_84_inputs_170_symbol : Boolean;
            signal rr_173_symbol : Boolean;
            signal ra_174_symbol : Boolean;
            signal cr_175_symbol : Boolean;
            signal ca_176_symbol : Boolean;
            -- 
          begin -- 
            binary_84_167_start <= Xentry_165_symbol; -- control passed to block
            Xentry_168_symbol  <= binary_84_167_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/$entry
            binary_84_inputs_170: Block -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/binary_84_inputs 
              signal binary_84_inputs_170_start: Boolean;
              signal Xentry_171_symbol: Boolean;
              signal Xexit_172_symbol: Boolean;
              -- 
            begin -- 
              binary_84_inputs_170_start <= Xentry_168_symbol; -- control passed to block
              Xentry_171_symbol  <= binary_84_inputs_170_start; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/binary_84_inputs/$entry
              Xexit_172_symbol <= Xentry_171_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/binary_84_inputs/$exit
              binary_84_inputs_170_symbol <= Xexit_172_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/binary_84_inputs
            rr_173_symbol <= binary_84_inputs_170_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/rr
            binary_84_inst_req_0 <= rr_173_symbol; -- link to DP
            ra_174_symbol <= binary_84_inst_ack_0; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/ra
            cr_175_symbol <= ra_174_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/cr
            binary_84_inst_req_1 <= cr_175_symbol; -- link to DP
            ca_176_symbol <= binary_84_inst_ack_1; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/ca
            Xexit_169_symbol <= ca_176_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84/$exit
            binary_84_167_symbol <= Xexit_169_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/binary_84
          Xexit_166_symbol <= binary_84_167_symbol; -- transition branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85/$exit
          assign_stmt_85_164_symbol <= Xexit_166_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/parallel_block_stmt_70/assign_stmt_85
        Xexit_137_block : Block -- non-trivial join transition branch_block_stmt_14/parallel_block_stmt_70/$exit 
          signal Xexit_137_predecessors: BooleanArray(2 downto 0);
          signal Xexit_137_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_137_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_137_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_137_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_137_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_137_p2_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_137_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_137_p0_pred, Xexit_137_p0_succ, Xexit_137_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_137_p0_succ(0) <=  Xexit_137_symbol;
          Xexit_137_p0_pred(0) <=  assign_stmt_76_138_symbol;
          Xexit_137_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_137_p1_pred, Xexit_137_p1_succ, Xexit_137_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_137_p1_succ(0) <=  Xexit_137_symbol;
          Xexit_137_p1_pred(0) <=  assign_stmt_80_156_symbol;
          Xexit_137_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_137_p2_pred, Xexit_137_p2_succ, Xexit_137_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_137_p2_succ(0) <=  Xexit_137_symbol;
          Xexit_137_p2_pred(0) <=  assign_stmt_85_164_symbol;
          Xexit_137_symbol <= AndReduce(Xexit_137_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_14/parallel_block_stmt_70/$exit
        parallel_block_stmt_70_135_symbol <= Xexit_137_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/parallel_block_stmt_70
      if_stmt_87_eval_test_177: Block -- branch_block_stmt_14/if_stmt_87_eval_test 
        signal if_stmt_87_eval_test_177_start: Boolean;
        signal Xentry_178_symbol: Boolean;
        signal Xexit_179_symbol: Boolean;
        signal binary_90_180_symbol : Boolean;
        signal branch_req_190_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_87_eval_test_177_start <= if_stmt_87_x_xentry_x_xx_x17_symbol; -- control passed to block
        Xentry_178_symbol  <= if_stmt_87_eval_test_177_start; -- transition branch_block_stmt_14/if_stmt_87_eval_test/$entry
        binary_90_180: Block -- branch_block_stmt_14/if_stmt_87_eval_test/binary_90 
          signal binary_90_180_start: Boolean;
          signal Xentry_181_symbol: Boolean;
          signal Xexit_182_symbol: Boolean;
          signal binary_90_inputs_183_symbol : Boolean;
          signal rr_186_symbol : Boolean;
          signal ra_187_symbol : Boolean;
          signal cr_188_symbol : Boolean;
          signal ca_189_symbol : Boolean;
          -- 
        begin -- 
          binary_90_180_start <= Xentry_178_symbol; -- control passed to block
          Xentry_181_symbol  <= binary_90_180_start; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/$entry
          binary_90_inputs_183: Block -- branch_block_stmt_14/if_stmt_87_eval_test/binary_90/binary_90_inputs 
            signal binary_90_inputs_183_start: Boolean;
            signal Xentry_184_symbol: Boolean;
            signal Xexit_185_symbol: Boolean;
            -- 
          begin -- 
            binary_90_inputs_183_start <= Xentry_181_symbol; -- control passed to block
            Xentry_184_symbol  <= binary_90_inputs_183_start; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/binary_90_inputs/$entry
            Xexit_185_symbol <= Xentry_184_symbol; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/binary_90_inputs/$exit
            binary_90_inputs_183_symbol <= Xexit_185_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_14/if_stmt_87_eval_test/binary_90/binary_90_inputs
          rr_186_symbol <= binary_90_inputs_183_symbol; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/rr
          binary_90_inst_req_0 <= rr_186_symbol; -- link to DP
          ra_187_symbol <= binary_90_inst_ack_0; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/ra
          cr_188_symbol <= ra_187_symbol; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/cr
          binary_90_inst_req_1 <= cr_188_symbol; -- link to DP
          ca_189_symbol <= binary_90_inst_ack_1; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/ca
          Xexit_182_symbol <= ca_189_symbol; -- transition branch_block_stmt_14/if_stmt_87_eval_test/binary_90/$exit
          binary_90_180_symbol <= Xexit_182_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_14/if_stmt_87_eval_test/binary_90
        branch_req_190_symbol <= binary_90_180_symbol; -- transition branch_block_stmt_14/if_stmt_87_eval_test/branch_req
        if_stmt_87_branch_req_0 <= branch_req_190_symbol; -- link to DP
        Xexit_179_symbol <= branch_req_190_symbol; -- transition branch_block_stmt_14/if_stmt_87_eval_test/$exit
        if_stmt_87_eval_test_177_symbol <= Xexit_179_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if_stmt_87_eval_test
      binary_90_place_191_symbol  <=  if_stmt_87_eval_test_177_symbol; -- place branch_block_stmt_14/binary_90_place (optimized away) 
      if_stmt_87_if_link_192: Block -- branch_block_stmt_14/if_stmt_87_if_link 
        signal if_stmt_87_if_link_192_start: Boolean;
        signal Xentry_193_symbol: Boolean;
        signal Xexit_194_symbol: Boolean;
        signal if_choice_transition_195_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_87_if_link_192_start <= binary_90_place_191_symbol; -- control passed to block
        Xentry_193_symbol  <= if_stmt_87_if_link_192_start; -- transition branch_block_stmt_14/if_stmt_87_if_link/$entry
        if_choice_transition_195_symbol <= if_stmt_87_branch_ack_1; -- transition branch_block_stmt_14/if_stmt_87_if_link/if_choice_transition
        Xexit_194_symbol <= if_choice_transition_195_symbol; -- transition branch_block_stmt_14/if_stmt_87_if_link/$exit
        if_stmt_87_if_link_192_symbol <= Xexit_194_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if_stmt_87_if_link
      if_stmt_87_else_link_196: Block -- branch_block_stmt_14/if_stmt_87_else_link 
        signal if_stmt_87_else_link_196_start: Boolean;
        signal Xentry_197_symbol: Boolean;
        signal Xexit_198_symbol: Boolean;
        signal else_choice_transition_199_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_87_else_link_196_start <= binary_90_place_191_symbol; -- control passed to block
        Xentry_197_symbol  <= if_stmt_87_else_link_196_start; -- transition branch_block_stmt_14/if_stmt_87_else_link/$entry
        else_choice_transition_199_symbol <= if_stmt_87_branch_ack_0; -- transition branch_block_stmt_14/if_stmt_87_else_link/else_choice_transition
        Xexit_198_symbol <= else_choice_transition_199_symbol; -- transition branch_block_stmt_14/if_stmt_87_else_link/$exit
        if_stmt_87_else_link_196_symbol <= Xexit_198_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if_stmt_87_else_link
      stmt_91_x_xentry_x_xx_x200_symbol  <=  if_stmt_87_if_link_192_symbol; -- place branch_block_stmt_14/stmt_91__entry__ (optimized away) 
      stmt_91_x_xexit_x_xx_x201_symbol  <=  stmt_91_202_symbol; -- place branch_block_stmt_14/stmt_91__exit__ (optimized away) 
      stmt_91_202: Block -- branch_block_stmt_14/stmt_91 
        signal stmt_91_202_start: Boolean;
        signal Xentry_203_symbol: Boolean;
        signal Xexit_204_symbol: Boolean;
        -- 
      begin -- 
        stmt_91_202_start <= stmt_91_x_xentry_x_xx_x200_symbol; -- control passed to block
        Xentry_203_symbol  <= stmt_91_202_start; -- transition branch_block_stmt_14/stmt_91/$entry
        Xexit_204_symbol <= Xentry_203_symbol; -- transition branch_block_stmt_14/stmt_91/$exit
        stmt_91_202_symbol <= Xexit_204_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/stmt_91
      loopback_205_symbol  <=  if_stmt_87_else_link_196_symbol; -- place branch_block_stmt_14/loopback (optimized away) 
      branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206: Block -- branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq 
        signal branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206_start: Boolean;
        signal Xentry_207_symbol: Boolean;
        signal Xexit_208_symbol: Boolean;
        signal phi_stmt_16_req_209_symbol : Boolean;
        signal phi_stmt_20_req_210_symbol : Boolean;
        signal phi_stmt_24_req_211_symbol : Boolean;
        -- 
      begin -- 
        branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206_start <= branch_block_stmt_14_x_xentry_x_xx_x6_symbol; -- control passed to block
        Xentry_207_symbol  <= branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206_start; -- transition branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq/$entry
        phi_stmt_16_req_209_symbol <= Xentry_207_symbol; -- transition branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq/phi_stmt_16_req
        phi_stmt_16_req_0 <= phi_stmt_16_req_209_symbol; -- link to DP
        phi_stmt_20_req_210_symbol <= Xentry_207_symbol; -- transition branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq/phi_stmt_20_req
        phi_stmt_20_req_0 <= phi_stmt_20_req_210_symbol; -- link to DP
        phi_stmt_24_req_211_symbol <= Xentry_207_symbol; -- transition branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq/phi_stmt_24_req
        phi_stmt_24_req_0 <= phi_stmt_24_req_211_symbol; -- link to DP
        Xexit_208_block : Block -- non-trivial join transition branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq/$exit 
          signal Xexit_208_predecessors: BooleanArray(2 downto 0);
          signal Xexit_208_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_208_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_208_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_208_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_208_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_208_p2_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_208_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_208_p0_pred, Xexit_208_p0_succ, Xexit_208_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_208_p0_succ(0) <=  Xexit_208_symbol;
          Xexit_208_p0_pred(0) <=  phi_stmt_16_req_209_symbol;
          Xexit_208_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_208_p1_pred, Xexit_208_p1_succ, Xexit_208_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_208_p1_succ(0) <=  Xexit_208_symbol;
          Xexit_208_p1_pred(0) <=  phi_stmt_20_req_210_symbol;
          Xexit_208_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_208_p2_pred, Xexit_208_p2_succ, Xexit_208_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_208_p2_succ(0) <=  Xexit_208_symbol;
          Xexit_208_p2_pred(0) <=  phi_stmt_24_req_211_symbol;
          Xexit_208_symbol <= AndReduce(Xexit_208_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq/$exit
        branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206_symbol <= Xexit_208_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/branch_block_stmt_14__entry___PhiReq
      loopback_PhiReq_212: Block -- branch_block_stmt_14/loopback_PhiReq 
        signal loopback_PhiReq_212_start: Boolean;
        signal Xentry_213_symbol: Boolean;
        signal Xexit_214_symbol: Boolean;
        signal phi_stmt_16_req_215_symbol : Boolean;
        signal phi_stmt_20_req_216_symbol : Boolean;
        signal phi_stmt_24_req_217_symbol : Boolean;
        -- 
      begin -- 
        loopback_PhiReq_212_start <= loopback_205_symbol; -- control passed to block
        Xentry_213_symbol  <= loopback_PhiReq_212_start; -- transition branch_block_stmt_14/loopback_PhiReq/$entry
        phi_stmt_16_req_215_symbol <= Xentry_213_symbol; -- transition branch_block_stmt_14/loopback_PhiReq/phi_stmt_16_req
        phi_stmt_16_req_1 <= phi_stmt_16_req_215_symbol; -- link to DP
        phi_stmt_20_req_216_symbol <= Xentry_213_symbol; -- transition branch_block_stmt_14/loopback_PhiReq/phi_stmt_20_req
        phi_stmt_20_req_1 <= phi_stmt_20_req_216_symbol; -- link to DP
        phi_stmt_24_req_217_symbol <= Xentry_213_symbol; -- transition branch_block_stmt_14/loopback_PhiReq/phi_stmt_24_req
        phi_stmt_24_req_1 <= phi_stmt_24_req_217_symbol; -- link to DP
        Xexit_214_block : Block -- non-trivial join transition branch_block_stmt_14/loopback_PhiReq/$exit 
          signal Xexit_214_predecessors: BooleanArray(2 downto 0);
          signal Xexit_214_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_214_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_214_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_214_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_214_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_214_p2_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_214_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_214_p0_pred, Xexit_214_p0_succ, Xexit_214_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_214_p0_succ(0) <=  Xexit_214_symbol;
          Xexit_214_p0_pred(0) <=  phi_stmt_16_req_215_symbol;
          Xexit_214_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_214_p1_pred, Xexit_214_p1_succ, Xexit_214_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_214_p1_succ(0) <=  Xexit_214_symbol;
          Xexit_214_p1_pred(0) <=  phi_stmt_20_req_216_symbol;
          Xexit_214_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_214_p2_pred, Xexit_214_p2_succ, Xexit_214_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_214_p2_succ(0) <=  Xexit_214_symbol;
          Xexit_214_p2_pred(0) <=  phi_stmt_24_req_217_symbol;
          Xexit_214_symbol <= AndReduce(Xexit_214_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_14/loopback_PhiReq/$exit
        loopback_PhiReq_212_symbol <= Xexit_214_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/loopback_PhiReq
      merge_stmt_15_PhiReqMerge_218_symbol  <=  branch_block_stmt_14_x_xentry_x_xx_xPhiReq_206_symbol or loopback_PhiReq_212_symbol; -- place branch_block_stmt_14/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_219: Block -- branch_block_stmt_14/merge_stmt_15_PhiAck 
        signal merge_stmt_15_PhiAck_219_start: Boolean;
        signal Xentry_220_symbol: Boolean;
        signal Xexit_221_symbol: Boolean;
        signal phi_stmt_16_ack_222_symbol : Boolean;
        signal phi_stmt_20_ack_223_symbol : Boolean;
        signal phi_stmt_24_ack_224_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_219_start <= merge_stmt_15_PhiReqMerge_218_symbol; -- control passed to block
        Xentry_220_symbol  <= merge_stmt_15_PhiAck_219_start; -- transition branch_block_stmt_14/merge_stmt_15_PhiAck/$entry
        phi_stmt_16_ack_222_symbol <= phi_stmt_16_ack_0; -- transition branch_block_stmt_14/merge_stmt_15_PhiAck/phi_stmt_16_ack
        phi_stmt_20_ack_223_symbol <= phi_stmt_20_ack_0; -- transition branch_block_stmt_14/merge_stmt_15_PhiAck/phi_stmt_20_ack
        phi_stmt_24_ack_224_symbol <= phi_stmt_24_ack_0; -- transition branch_block_stmt_14/merge_stmt_15_PhiAck/phi_stmt_24_ack
        Xexit_221_block : Block -- non-trivial join transition branch_block_stmt_14/merge_stmt_15_PhiAck/$exit 
          signal Xexit_221_predecessors: BooleanArray(2 downto 0);
          signal Xexit_221_p0_pred: BooleanArray(0 downto 0);
          signal Xexit_221_p0_succ: BooleanArray(0 downto 0);
          signal Xexit_221_p1_pred: BooleanArray(0 downto 0);
          signal Xexit_221_p1_succ: BooleanArray(0 downto 0);
          signal Xexit_221_p2_pred: BooleanArray(0 downto 0);
          signal Xexit_221_p2_succ: BooleanArray(0 downto 0);
          -- 
        begin -- 
          Xexit_221_0_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_221_p0_pred, Xexit_221_p0_succ, Xexit_221_predecessors(0), clk, reset-- 
            ); -- 
          Xexit_221_p0_succ(0) <=  Xexit_221_symbol;
          Xexit_221_p0_pred(0) <=  phi_stmt_16_ack_222_symbol;
          Xexit_221_1_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_221_p1_pred, Xexit_221_p1_succ, Xexit_221_predecessors(1), clk, reset-- 
            ); -- 
          Xexit_221_p1_succ(0) <=  Xexit_221_symbol;
          Xexit_221_p1_pred(0) <=  phi_stmt_20_ack_223_symbol;
          Xexit_221_2_place: Place -- 
            generic map(marking => false)
            port map( -- 
              Xexit_221_p2_pred, Xexit_221_p2_succ, Xexit_221_predecessors(2), clk, reset-- 
            ); -- 
          Xexit_221_p2_succ(0) <=  Xexit_221_symbol;
          Xexit_221_p2_pred(0) <=  phi_stmt_24_ack_224_symbol;
          Xexit_221_symbol <= AndReduce(Xexit_221_predecessors); 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_14/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_219_symbol <= Xexit_221_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/merge_stmt_15_PhiAck
      if0_PhiReq_225: Block -- branch_block_stmt_14/if0_PhiReq 
        signal if0_PhiReq_225_start: Boolean;
        signal Xentry_226_symbol: Boolean;
        signal Xexit_227_symbol: Boolean;
        signal phi_stmt_56_req_228_symbol : Boolean;
        -- 
      begin -- 
        if0_PhiReq_225_start <= if0_101_symbol; -- control passed to block
        Xentry_226_symbol  <= if0_PhiReq_225_start; -- transition branch_block_stmt_14/if0_PhiReq/$entry
        phi_stmt_56_req_228_symbol <= Xentry_226_symbol; -- transition branch_block_stmt_14/if0_PhiReq/phi_stmt_56_req
        phi_stmt_56_req_1 <= phi_stmt_56_req_228_symbol; -- link to DP
        Xexit_227_symbol <= phi_stmt_56_req_228_symbol; -- transition branch_block_stmt_14/if0_PhiReq/$exit
        if0_PhiReq_225_symbol <= Xexit_227_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if0_PhiReq
      if1_PhiReq_229: Block -- branch_block_stmt_14/if1_PhiReq 
        signal if1_PhiReq_229_start: Boolean;
        signal Xentry_230_symbol: Boolean;
        signal Xexit_231_symbol: Boolean;
        signal phi_stmt_56_req_232_symbol : Boolean;
        -- 
      begin -- 
        if1_PhiReq_229_start <= if1_100_symbol; -- control passed to block
        Xentry_230_symbol  <= if1_PhiReq_229_start; -- transition branch_block_stmt_14/if1_PhiReq/$entry
        phi_stmt_56_req_232_symbol <= Xentry_230_symbol; -- transition branch_block_stmt_14/if1_PhiReq/phi_stmt_56_req
        phi_stmt_56_req_0 <= phi_stmt_56_req_232_symbol; -- link to DP
        Xexit_231_symbol <= phi_stmt_56_req_232_symbol; -- transition branch_block_stmt_14/if1_PhiReq/$exit
        if1_PhiReq_229_symbol <= Xexit_231_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/if1_PhiReq
      merge_stmt_55_PhiReqMerge_233_symbol  <=  if0_PhiReq_225_symbol or if1_PhiReq_229_symbol; -- place branch_block_stmt_14/merge_stmt_55_PhiReqMerge (optimized away) 
      merge_stmt_55_PhiAck_234: Block -- branch_block_stmt_14/merge_stmt_55_PhiAck 
        signal merge_stmt_55_PhiAck_234_start: Boolean;
        signal Xentry_235_symbol: Boolean;
        signal Xexit_236_symbol: Boolean;
        signal phi_stmt_56_ack_237_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_55_PhiAck_234_start <= merge_stmt_55_PhiReqMerge_233_symbol; -- control passed to block
        Xentry_235_symbol  <= merge_stmt_55_PhiAck_234_start; -- transition branch_block_stmt_14/merge_stmt_55_PhiAck/$entry
        phi_stmt_56_ack_237_symbol <= phi_stmt_56_ack_0; -- transition branch_block_stmt_14/merge_stmt_55_PhiAck/phi_stmt_56_ack
        Xexit_236_symbol <= phi_stmt_56_ack_237_symbol; -- transition branch_block_stmt_14/merge_stmt_55_PhiAck/$exit
        merge_stmt_55_PhiAck_234_symbol <= Xexit_236_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_14/merge_stmt_55_PhiAck
      Xexit_5_symbol <= branch_block_stmt_14_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_14/$exit
      branch_block_stmt_14_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_14
    assign_stmt_100_238: Block -- assign_stmt_100 
      signal assign_stmt_100_238_start: Boolean;
      signal Xentry_239_symbol: Boolean;
      signal Xexit_240_symbol: Boolean;
      signal binary_99_241_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_100_238_start <= branch_block_stmt_14_3_symbol; -- control passed to block
      Xentry_239_symbol  <= assign_stmt_100_238_start; -- transition assign_stmt_100/$entry
      binary_99_241: Block -- assign_stmt_100/binary_99 
        signal binary_99_241_start: Boolean;
        signal Xentry_242_symbol: Boolean;
        signal Xexit_243_symbol: Boolean;
        signal binary_99_inputs_244_symbol : Boolean;
        signal rr_247_symbol : Boolean;
        signal ra_248_symbol : Boolean;
        signal cr_249_symbol : Boolean;
        signal ca_250_symbol : Boolean;
        -- 
      begin -- 
        binary_99_241_start <= Xentry_239_symbol; -- control passed to block
        Xentry_242_symbol  <= binary_99_241_start; -- transition assign_stmt_100/binary_99/$entry
        binary_99_inputs_244: Block -- assign_stmt_100/binary_99/binary_99_inputs 
          signal binary_99_inputs_244_start: Boolean;
          signal Xentry_245_symbol: Boolean;
          signal Xexit_246_symbol: Boolean;
          -- 
        begin -- 
          binary_99_inputs_244_start <= Xentry_242_symbol; -- control passed to block
          Xentry_245_symbol  <= binary_99_inputs_244_start; -- transition assign_stmt_100/binary_99/binary_99_inputs/$entry
          Xexit_246_symbol <= Xentry_245_symbol; -- transition assign_stmt_100/binary_99/binary_99_inputs/$exit
          binary_99_inputs_244_symbol <= Xexit_246_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_100/binary_99/binary_99_inputs
        rr_247_symbol <= binary_99_inputs_244_symbol; -- transition assign_stmt_100/binary_99/rr
        binary_99_inst_req_0 <= rr_247_symbol; -- link to DP
        ra_248_symbol <= binary_99_inst_ack_0; -- transition assign_stmt_100/binary_99/ra
        cr_249_symbol <= ra_248_symbol; -- transition assign_stmt_100/binary_99/cr
        binary_99_inst_req_1 <= cr_249_symbol; -- link to DP
        ca_250_symbol <= binary_99_inst_ack_1; -- transition assign_stmt_100/binary_99/ca
        Xexit_243_symbol <= ca_250_symbol; -- transition assign_stmt_100/binary_99/$exit
        binary_99_241_symbol <= Xexit_243_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_100/binary_99
      Xexit_240_symbol <= binary_99_241_symbol; -- transition assign_stmt_100/$exit
      assign_stmt_100_238_symbol <= Xexit_240_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_100
    Xexit_2_symbol <= assign_stmt_100_238_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal binary_33_wire : std_logic_vector(9 downto 0);
    signal binary_35_wire : std_logic_vector(10 downto 0);
    signal binary_42_wire : std_logic_vector(10 downto 0);
    signal binary_50_wire : std_logic_vector(0 downto 0);
    signal binary_64_wire : std_logic_vector(0 downto 0);
    signal binary_66_wire : std_logic_vector(10 downto 0);
    signal binary_74_wire : std_logic_vector(10 downto 0);
    signal binary_90_wire : std_logic_vector(0 downto 0);
    signal count_85 : std_logic_vector(3 downto 0);
    signal count_in_24 : std_logic_vector(3 downto 0);
    signal expr_18_wire_constant : std_logic_vector(9 downto 0);
    signal expr_22_wire_constant : std_logic_vector(9 downto 0);
    signal expr_26_wire_constant : std_logic_vector(3 downto 0);
    signal expr_36_wire_constant : std_logic_vector(3 downto 0);
    signal expr_43_wire_constant : std_logic_vector(3 downto 0);
    signal expr_63_wire_constant : std_logic_vector(3 downto 0);
    signal expr_67_wire_constant : std_logic_vector(3 downto 0);
    signal expr_73_wire_constant : std_logic_vector(3 downto 0);
    signal expr_83_wire_constant : std_logic_vector(3 downto 0);
    signal expr_89_wire_constant : std_logic_vector(3 downto 0);
    signal nu_56 : std_logic_vector(10 downto 0);
    signal nu_else_45 : std_logic_vector(10 downto 0);
    signal nu_if_38 : std_logic_vector(10 downto 0);
    signal nv_69 : std_logic_vector(10 downto 0);
    signal simple_obj_ref_34_wire_constant : std_logic_vector(0 downto 0);
    signal simple_obj_ref_41_wire_constant : std_logic_vector(0 downto 0);
    signal u_76 : std_logic_vector(9 downto 0);
    signal u_in_16 : std_logic_vector(9 downto 0);
    signal v_80 : std_logic_vector(9 downto 0);
    signal v_in_20 : std_logic_vector(9 downto 0);
    signal xxsum_modxxz1 : std_logic_vector(0 downto 0);
    signal xxsum_modxxz9 : std_logic_vector(8 downto 0);
    -- 
  begin -- 
    expr_18_wire_constant <= "0000000000";
    expr_22_wire_constant <= "0000000000";
    expr_26_wire_constant <= "0000";
    expr_36_wire_constant <= "0001";
    expr_43_wire_constant <= "0001";
    expr_63_wire_constant <= "0000";
    expr_67_wire_constant <= "0001";
    expr_73_wire_constant <= "0001";
    expr_83_wire_constant <= "0001";
    expr_89_wire_constant <= "1010";
    simple_obj_ref_34_wire_constant <= "0";
    simple_obj_ref_41_wire_constant <= "0";
    xxsum_modxxz1 <= "0";
    xxsum_modxxz9 <= "000000000";
    phi_stmt_16: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_18_wire_constant & u_76;
      req <= phi_stmt_16_req_0 & phi_stmt_16_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_16_ack_0,
          idata => idata,
          odata => u_in_16,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_16
    phi_stmt_20: Block -- phi operator 
      signal idata: std_logic_vector(19 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_22_wire_constant & v_80;
      req <= phi_stmt_20_req_0 & phi_stmt_20_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 10) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_20_ack_0,
          idata => idata,
          odata => v_in_20,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_20
    phi_stmt_24: Block -- phi operator 
      signal idata: std_logic_vector(7 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= expr_26_wire_constant & count_85;
      req <= phi_stmt_24_req_0 & phi_stmt_24_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 4) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_24_ack_0,
          idata => idata,
          odata => count_in_24,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_24
    phi_stmt_56: Block -- phi operator 
      signal idata: std_logic_vector(21 downto 0);
      signal req: BooleanArray(1 downto 0);
      --
    begin -- 
      idata <= nu_if_38 & nu_else_45;
      req <= phi_stmt_56_req_0 & phi_stmt_56_req_1;
      phi: PhiBase -- 
        generic map( -- 
          num_reqs => 2,
          data_width => 11) -- 
        port map( -- 
          req => req, 
          ack => phi_stmt_56_ack_0,
          idata => idata,
          odata => nu_56,
          clk => clk,
          reset => reset ); -- 
      -- 
    end Block; -- phi operator phi_stmt_56
    type_cast_75_inst: RegisterBase generic map(in_data_width => 11,out_data_width => 10) -- 
      port map( din => binary_74_wire, dout => u_76, req => type_cast_75_inst_req_0, ack => type_cast_75_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_79_inst: RegisterBase generic map(in_data_width => 11,out_data_width => 10) -- 
      port map( din => nv_69, dout => v_80, req => type_cast_79_inst_req_0, ack => type_cast_79_inst_ack_0, clk => clk, reset => reset); -- 
    if_stmt_47_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= binary_50_wire;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_47_branch_req_0,
          ack0 => if_stmt_47_branch_ack_0,
          ack1 => if_stmt_47_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_87_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= binary_90_wire;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_87_branch_req_0,
          ack0 => if_stmt_87_branch_ack_0,
          ack1 => if_stmt_87_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_33_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(9 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_in_16 & b;
      binary_33_wire <= data_out(9 downto 0);
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
          reqL => binary_33_inst_req_0,
          ackL => binary_33_inst_ack_0,
          reqR => binary_33_inst_req_1,
          ackR => binary_33_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_35_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_33_wire;
      binary_35_wire <= data_out(10 downto 0);
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
          reqL => binary_35_inst_req_0,
          ackL => binary_35_inst_ack_0,
          reqR => binary_35_inst_req_1,
          ackR => binary_35_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_37_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_35_wire;
      nu_if_38 <= data_out(10 downto 0);
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
          reqL => binary_37_inst_req_0,
          ackL => binary_37_inst_ack_0,
          reqR => binary_37_inst_req_1,
          ackR => binary_37_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_42_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(9 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_in_16;
      binary_42_wire <= data_out(10 downto 0);
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
          reqL => binary_42_inst_req_0,
          ackL => binary_42_inst_ack_0,
          reqR => binary_42_inst_req_1,
          ackR => binary_42_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_44_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_42_wire;
      nu_else_45 <= data_out(10 downto 0);
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
          reqL => binary_44_inst_req_0,
          ackL => binary_44_inst_ack_0,
          reqR => binary_44_inst_req_1,
          ackR => binary_44_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_50_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(13 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= a & count_in_24;
      binary_50_wire <= data_out(0 downto 0);
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
          iwidth_2      => 4, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0",
          use_constant  => false,
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
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_64_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= nu_56;
      binary_64_wire <= data_out(0 downto 0);
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
          reqL => binary_64_inst_req_0,
          ackL => binary_64_inst_ack_0,
          reqR => binary_64_inst_req_1,
          ackR => binary_64_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_66_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_64_wire & v_in_20;
      binary_66_wire <= data_out(10 downto 0);
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
          reqL => binary_66_inst_req_0,
          ackL => binary_66_inst_ack_0,
          reqR => binary_66_inst_req_1,
          ackR => binary_66_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_68_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_66_wire;
      nv_69 <= data_out(10 downto 0);
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
          reqL => binary_68_inst_req_0,
          ackL => binary_68_inst_ack_0,
          reqR => binary_68_inst_req_1,
          ackR => binary_68_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_74_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(10 downto 0);
      signal data_out: std_logic_vector(10 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= nu_56;
      binary_74_wire <= data_out(10 downto 0);
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
          reqL => binary_74_inst_req_0,
          ackL => binary_74_inst_ack_0,
          reqR => binary_74_inst_req_1,
          ackR => binary_74_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_84_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(3 downto 0);
      signal data_out: std_logic_vector(3 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= count_in_24;
      count_85 <= data_out(3 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 4,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 4,
          constant_operand => "0001",
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
      signal data_in: std_logic_vector(3 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= count_85;
      binary_90_wire <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 4,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "1010",
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
    -- shared split operator group (12) : binary_99_inst 
    SplitOperatorGroup12: Block -- 
      signal data_in: std_logic_vector(19 downto 0);
      signal data_out: std_logic_vector(19 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= u_76 & v_80;
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
          reqL => binary_99_inst_req_0,
          ackL => binary_99_inst_ack_0,
          reqR => binary_99_inst_req_1,
          ackR => binary_99_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 12
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
