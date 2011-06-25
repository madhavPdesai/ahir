-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant xx_xstr1_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr2_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr3_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr_base_address : std_logic_vector(3 downto 0) := "0000";
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
entity ctrl_module is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity ctrl_module;
architecture Default of ctrl_module is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal type_cast_23_inst_req_0 : boolean;
  signal type_cast_23_inst_ack_0 : boolean;
  signal type_cast_32_inst_req_0 : boolean;
  signal type_cast_32_inst_ack_0 : boolean;
  signal simple_obj_ref_30_inst_req_0 : boolean;
  signal simple_obj_ref_30_inst_ack_0 : boolean;
  signal simple_obj_ref_22_inst_req_0 : boolean;
  signal simple_obj_ref_22_inst_ack_0 : boolean;
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
  ctrl_module_CP_0: Block -- control-path 
    signal ctrl_module_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_13_3_symbol : Boolean;
    -- 
  begin -- 
    ctrl_module_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= ctrl_module_CP_0_start; -- transition $entry
    branch_block_stmt_13_3: Block -- branch_block_stmt_13 
      signal branch_block_stmt_13_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_13_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_13_x_xexit_x_xx_x7_symbol : Boolean;
      signal bb_0_bb_1_8_symbol : Boolean;
      signal merge_stmt_15_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_20_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_20_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_24_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_24_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_29_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_29_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_33_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_33_x_xexit_x_xx_x17_symbol : Boolean;
      signal bb_1_bb_1_18_symbol : Boolean;
      signal assign_stmt_20_19_symbol : Boolean;
      signal assign_stmt_24_22_symbol : Boolean;
      signal assign_stmt_29_40_symbol : Boolean;
      signal assign_stmt_33_43_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_62_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_65_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_68_symbol : Boolean;
      signal merge_stmt_15_PhiAck_69_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x9_symbol  <=  merge_stmt_15_PhiAck_69_symbol; -- place branch_block_stmt_13/merge_stmt_15__exit__ (optimized away) 
      assign_stmt_20_x_xentry_x_xx_x10_symbol  <=  merge_stmt_15_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/assign_stmt_20__entry__ (optimized away) 
      assign_stmt_20_x_xexit_x_xx_x11_symbol  <=  assign_stmt_20_19_symbol; -- place branch_block_stmt_13/assign_stmt_20__exit__ (optimized away) 
      assign_stmt_24_x_xentry_x_xx_x12_symbol  <=  assign_stmt_20_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_24__entry__ (optimized away) 
      assign_stmt_24_x_xexit_x_xx_x13_symbol  <=  assign_stmt_24_22_symbol; -- place branch_block_stmt_13/assign_stmt_24__exit__ (optimized away) 
      assign_stmt_29_x_xentry_x_xx_x14_symbol  <=  assign_stmt_24_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/assign_stmt_29__entry__ (optimized away) 
      assign_stmt_29_x_xexit_x_xx_x15_symbol  <=  assign_stmt_29_40_symbol; -- place branch_block_stmt_13/assign_stmt_29__exit__ (optimized away) 
      assign_stmt_33_x_xentry_x_xx_x16_symbol  <=  assign_stmt_29_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_13/assign_stmt_33__entry__ (optimized away) 
      assign_stmt_33_x_xexit_x_xx_x17_symbol  <=  assign_stmt_33_43_symbol; -- place branch_block_stmt_13/assign_stmt_33__exit__ (optimized away) 
      bb_1_bb_1_18_symbol  <=  assign_stmt_33_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_13/bb_1_bb_1 (optimized away) 
      assign_stmt_20_19: Block -- branch_block_stmt_13/assign_stmt_20 
        signal assign_stmt_20_19_start: Boolean;
        signal Xentry_20_symbol: Boolean;
        signal Xexit_21_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_20_19_start <= assign_stmt_20_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_20_symbol  <= assign_stmt_20_19_start; -- transition branch_block_stmt_13/assign_stmt_20/$entry
        Xexit_21_symbol <= Xentry_20_symbol; -- transition branch_block_stmt_13/assign_stmt_20/$exit
        assign_stmt_20_19_symbol <= Xexit_21_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_20
      assign_stmt_24_22: Block -- branch_block_stmt_13/assign_stmt_24 
        signal assign_stmt_24_22_start: Boolean;
        signal Xentry_23_symbol: Boolean;
        signal Xexit_24_symbol: Boolean;
        signal assign_stmt_24_active_x_x25_symbol : Boolean;
        signal assign_stmt_24_completed_x_x26_symbol : Boolean;
        signal type_cast_23_active_x_x27_symbol : Boolean;
        signal type_cast_23_trigger_x_x28_symbol : Boolean;
        signal simple_obj_ref_22_trigger_x_x29_symbol : Boolean;
        signal simple_obj_ref_22_complete_30_symbol : Boolean;
        signal type_cast_23_complete_35_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_24_22_start <= assign_stmt_24_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_23_symbol  <= assign_stmt_24_22_start; -- transition branch_block_stmt_13/assign_stmt_24/$entry
        assign_stmt_24_active_x_x25_symbol <= type_cast_23_complete_35_symbol; -- transition branch_block_stmt_13/assign_stmt_24/assign_stmt_24_active_
        assign_stmt_24_completed_x_x26_symbol <= assign_stmt_24_active_x_x25_symbol; -- transition branch_block_stmt_13/assign_stmt_24/assign_stmt_24_completed_
        type_cast_23_active_x_x27_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_24/type_cast_23_active_ 
          signal type_cast_23_active_x_x27_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_23_active_x_x27_predecessors(0) <= type_cast_23_trigger_x_x28_symbol;
          type_cast_23_active_x_x27_predecessors(1) <= simple_obj_ref_22_complete_30_symbol;
          type_cast_23_active_x_x27_join: join -- 
            port map( -- 
              preds => type_cast_23_active_x_x27_predecessors,
              symbol_out => type_cast_23_active_x_x27_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_24/type_cast_23_active_
        type_cast_23_trigger_x_x28_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_13/assign_stmt_24/type_cast_23_trigger_
        simple_obj_ref_22_trigger_x_x29_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_trigger_
        simple_obj_ref_22_complete_30: Block -- branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_complete 
          signal simple_obj_ref_22_complete_30_start: Boolean;
          signal Xentry_31_symbol: Boolean;
          signal Xexit_32_symbol: Boolean;
          signal req_33_symbol : Boolean;
          signal ack_34_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_22_complete_30_start <= simple_obj_ref_22_trigger_x_x29_symbol; -- control passed to block
          Xentry_31_symbol  <= simple_obj_ref_22_complete_30_start; -- transition branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_complete/$entry
          req_33_symbol <= Xentry_31_symbol; -- transition branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_complete/req
          simple_obj_ref_22_inst_req_0 <= req_33_symbol; -- link to DP
          ack_34_symbol <= simple_obj_ref_22_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_complete/ack
          Xexit_32_symbol <= ack_34_symbol; -- transition branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_complete/$exit
          simple_obj_ref_22_complete_30_symbol <= Xexit_32_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_24/simple_obj_ref_22_complete
        type_cast_23_complete_35: Block -- branch_block_stmt_13/assign_stmt_24/type_cast_23_complete 
          signal type_cast_23_complete_35_start: Boolean;
          signal Xentry_36_symbol: Boolean;
          signal Xexit_37_symbol: Boolean;
          signal req_38_symbol : Boolean;
          signal ack_39_symbol : Boolean;
          -- 
        begin -- 
          type_cast_23_complete_35_start <= type_cast_23_active_x_x27_symbol; -- control passed to block
          Xentry_36_symbol  <= type_cast_23_complete_35_start; -- transition branch_block_stmt_13/assign_stmt_24/type_cast_23_complete/$entry
          req_38_symbol <= Xentry_36_symbol; -- transition branch_block_stmt_13/assign_stmt_24/type_cast_23_complete/req
          type_cast_23_inst_req_0 <= req_38_symbol; -- link to DP
          ack_39_symbol <= type_cast_23_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_24/type_cast_23_complete/ack
          Xexit_37_symbol <= ack_39_symbol; -- transition branch_block_stmt_13/assign_stmt_24/type_cast_23_complete/$exit
          type_cast_23_complete_35_symbol <= Xexit_37_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_24/type_cast_23_complete
        Xexit_24_symbol <= assign_stmt_24_completed_x_x26_symbol; -- transition branch_block_stmt_13/assign_stmt_24/$exit
        assign_stmt_24_22_symbol <= Xexit_24_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_24
      assign_stmt_29_40: Block -- branch_block_stmt_13/assign_stmt_29 
        signal assign_stmt_29_40_start: Boolean;
        signal Xentry_41_symbol: Boolean;
        signal Xexit_42_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_29_40_start <= assign_stmt_29_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_41_symbol  <= assign_stmt_29_40_start; -- transition branch_block_stmt_13/assign_stmt_29/$entry
        Xexit_42_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_13/assign_stmt_29/$exit
        assign_stmt_29_40_symbol <= Xexit_42_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_29
      assign_stmt_33_43: Block -- branch_block_stmt_13/assign_stmt_33 
        signal assign_stmt_33_43_start: Boolean;
        signal Xentry_44_symbol: Boolean;
        signal Xexit_45_symbol: Boolean;
        signal assign_stmt_33_active_x_x46_symbol : Boolean;
        signal assign_stmt_33_completed_x_x47_symbol : Boolean;
        signal type_cast_32_active_x_x48_symbol : Boolean;
        signal type_cast_32_trigger_x_x49_symbol : Boolean;
        signal simple_obj_ref_31_complete_50_symbol : Boolean;
        signal type_cast_32_complete_51_symbol : Boolean;
        signal simple_obj_ref_30_trigger_x_x56_symbol : Boolean;
        signal simple_obj_ref_30_complete_57_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_33_43_start <= assign_stmt_33_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_44_symbol  <= assign_stmt_33_43_start; -- transition branch_block_stmt_13/assign_stmt_33/$entry
        assign_stmt_33_active_x_x46_symbol <= type_cast_32_complete_51_symbol; -- transition branch_block_stmt_13/assign_stmt_33/assign_stmt_33_active_
        assign_stmt_33_completed_x_x47_symbol <= simple_obj_ref_30_complete_57_symbol; -- transition branch_block_stmt_13/assign_stmt_33/assign_stmt_33_completed_
        type_cast_32_active_x_x48_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_33/type_cast_32_active_ 
          signal type_cast_32_active_x_x48_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_32_active_x_x48_predecessors(0) <= type_cast_32_trigger_x_x49_symbol;
          type_cast_32_active_x_x48_predecessors(1) <= simple_obj_ref_31_complete_50_symbol;
          type_cast_32_active_x_x48_join: join -- 
            port map( -- 
              preds => type_cast_32_active_x_x48_predecessors,
              symbol_out => type_cast_32_active_x_x48_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_33/type_cast_32_active_
        type_cast_32_trigger_x_x49_symbol <= Xentry_44_symbol; -- transition branch_block_stmt_13/assign_stmt_33/type_cast_32_trigger_
        simple_obj_ref_31_complete_50_symbol <= Xentry_44_symbol; -- transition branch_block_stmt_13/assign_stmt_33/simple_obj_ref_31_complete
        type_cast_32_complete_51: Block -- branch_block_stmt_13/assign_stmt_33/type_cast_32_complete 
          signal type_cast_32_complete_51_start: Boolean;
          signal Xentry_52_symbol: Boolean;
          signal Xexit_53_symbol: Boolean;
          signal req_54_symbol : Boolean;
          signal ack_55_symbol : Boolean;
          -- 
        begin -- 
          type_cast_32_complete_51_start <= type_cast_32_active_x_x48_symbol; -- control passed to block
          Xentry_52_symbol  <= type_cast_32_complete_51_start; -- transition branch_block_stmt_13/assign_stmt_33/type_cast_32_complete/$entry
          req_54_symbol <= Xentry_52_symbol; -- transition branch_block_stmt_13/assign_stmt_33/type_cast_32_complete/req
          type_cast_32_inst_req_0 <= req_54_symbol; -- link to DP
          ack_55_symbol <= type_cast_32_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_33/type_cast_32_complete/ack
          Xexit_53_symbol <= ack_55_symbol; -- transition branch_block_stmt_13/assign_stmt_33/type_cast_32_complete/$exit
          type_cast_32_complete_51_symbol <= Xexit_53_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_33/type_cast_32_complete
        simple_obj_ref_30_trigger_x_x56_symbol <= assign_stmt_33_active_x_x46_symbol; -- transition branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_trigger_
        simple_obj_ref_30_complete_57: Block -- branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_complete 
          signal simple_obj_ref_30_complete_57_start: Boolean;
          signal Xentry_58_symbol: Boolean;
          signal Xexit_59_symbol: Boolean;
          signal pipe_wreq_60_symbol : Boolean;
          signal pipe_wack_61_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_30_complete_57_start <= simple_obj_ref_30_trigger_x_x56_symbol; -- control passed to block
          Xentry_58_symbol  <= simple_obj_ref_30_complete_57_start; -- transition branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_complete/$entry
          pipe_wreq_60_symbol <= Xentry_58_symbol; -- transition branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_complete/pipe_wreq
          simple_obj_ref_30_inst_req_0 <= pipe_wreq_60_symbol; -- link to DP
          pipe_wack_61_symbol <= simple_obj_ref_30_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_complete/pipe_wack
          Xexit_59_symbol <= pipe_wack_61_symbol; -- transition branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_complete/$exit
          simple_obj_ref_30_complete_57_symbol <= Xexit_59_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_33/simple_obj_ref_30_complete
        Xexit_45_symbol <= assign_stmt_33_completed_x_x47_symbol; -- transition branch_block_stmt_13/assign_stmt_33/$exit
        assign_stmt_33_43_symbol <= Xexit_45_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_33
      bb_0_bb_1_PhiReq_62: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_62_start: Boolean;
        signal Xentry_63_symbol: Boolean;
        signal Xexit_64_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_62_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_63_symbol  <= bb_0_bb_1_PhiReq_62_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        Xexit_64_symbol <= Xentry_63_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_62_symbol <= Xexit_64_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_65: Block -- branch_block_stmt_13/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_65_start: Boolean;
        signal Xentry_66_symbol: Boolean;
        signal Xexit_67_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_65_start <= bb_1_bb_1_18_symbol; -- control passed to block
        Xentry_66_symbol  <= bb_1_bb_1_PhiReq_65_start; -- transition branch_block_stmt_13/bb_1_bb_1_PhiReq/$entry
        Xexit_67_symbol <= Xentry_66_symbol; -- transition branch_block_stmt_13/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_65_symbol <= Xexit_67_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_1_PhiReq
      merge_stmt_15_PhiReqMerge_68_symbol  <=  bb_0_bb_1_PhiReq_62_symbol or bb_1_bb_1_PhiReq_65_symbol; -- place branch_block_stmt_13/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_69: Block -- branch_block_stmt_13/merge_stmt_15_PhiAck 
        signal merge_stmt_15_PhiAck_69_start: Boolean;
        signal Xentry_70_symbol: Boolean;
        signal Xexit_71_symbol: Boolean;
        signal dummy_72_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_69_start <= merge_stmt_15_PhiReqMerge_68_symbol; -- control passed to block
        Xentry_70_symbol  <= merge_stmt_15_PhiAck_69_start; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$entry
        dummy_72_symbol <= Xentry_70_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/dummy
        Xexit_71_symbol <= dummy_72_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_69_symbol <= Xexit_71_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_15_PhiAck
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
    signal iNsTr_1_20 : std_logic_vector(31 downto 0);
    signal iNsTr_2_24 : std_logic_vector(7 downto 0);
    signal iNsTr_3_29 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_22_wire : std_logic_vector(7 downto 0);
    signal type_cast_32_wire : std_logic_vector(7 downto 0);
    -- 
  begin -- 
    iNsTr_1_20 <= "00000000000000000000000000000000";
    iNsTr_3_29 <= "00000000000000000000000000000000";
    type_cast_23_inst: RegisterBase generic map(in_data_width => 8,out_data_width => 8) -- 
      port map( din => simple_obj_ref_22_wire, dout => iNsTr_2_24, req => type_cast_23_inst_req_0, ack => type_cast_23_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_32_inst: RegisterBase generic map(in_data_width => 8,out_data_width => 8) -- 
      port map( din => iNsTr_2_24, dout => type_cast_32_wire, req => type_cast_32_inst_req_0, ack => type_cast_32_inst_ack_0, clk => clk, reset => reset); -- 
    -- shared inport operator group (0) : simple_obj_ref_22_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_22_inst_req_0;
      simple_obj_ref_22_inst_ack_0 <= ack(0);
      simple_obj_ref_22_wire <= data_out(7 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_30_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_30_inst_req_0;
      simple_obj_ref_30_inst_ack_0 <= ack(0);
      data_in <= type_cast_32_wire;
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
entity data_module is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity data_module;
architecture Default of data_module is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_55_inst_req_0 : boolean;
  signal simple_obj_ref_55_inst_ack_0 : boolean;
  signal simple_obj_ref_47_inst_req_0 : boolean;
  signal simple_obj_ref_47_inst_ack_0 : boolean;
  signal type_cast_48_inst_req_0 : boolean;
  signal type_cast_48_inst_ack_0 : boolean;
  signal type_cast_57_inst_req_0 : boolean;
  signal type_cast_57_inst_ack_0 : boolean;
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
  data_module_CP_73: Block -- control-path 
    signal data_module_CP_73_start: Boolean;
    signal Xentry_74_symbol: Boolean;
    signal Xexit_75_symbol: Boolean;
    signal branch_block_stmt_38_76_symbol : Boolean;
    -- 
  begin -- 
    data_module_CP_73_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_74_symbol  <= data_module_CP_73_start; -- transition $entry
    branch_block_stmt_38_76: Block -- branch_block_stmt_38 
      signal branch_block_stmt_38_76_start: Boolean;
      signal Xentry_77_symbol: Boolean;
      signal Xexit_78_symbol: Boolean;
      signal branch_block_stmt_38_x_xentry_x_xx_x79_symbol : Boolean;
      signal branch_block_stmt_38_x_xexit_x_xx_x80_symbol : Boolean;
      signal bb_0_bb_1_81_symbol : Boolean;
      signal merge_stmt_40_x_xexit_x_xx_x82_symbol : Boolean;
      signal assign_stmt_45_x_xentry_x_xx_x83_symbol : Boolean;
      signal assign_stmt_45_x_xexit_x_xx_x84_symbol : Boolean;
      signal assign_stmt_49_x_xentry_x_xx_x85_symbol : Boolean;
      signal assign_stmt_49_x_xexit_x_xx_x86_symbol : Boolean;
      signal assign_stmt_54_x_xentry_x_xx_x87_symbol : Boolean;
      signal assign_stmt_54_x_xexit_x_xx_x88_symbol : Boolean;
      signal assign_stmt_58_x_xentry_x_xx_x89_symbol : Boolean;
      signal assign_stmt_58_x_xexit_x_xx_x90_symbol : Boolean;
      signal bb_1_bb_1_91_symbol : Boolean;
      signal assign_stmt_45_92_symbol : Boolean;
      signal assign_stmt_49_95_symbol : Boolean;
      signal assign_stmt_54_113_symbol : Boolean;
      signal assign_stmt_58_116_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_135_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_138_symbol : Boolean;
      signal merge_stmt_40_PhiReqMerge_141_symbol : Boolean;
      signal merge_stmt_40_PhiAck_142_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_38_76_start <= Xentry_74_symbol; -- control passed to block
      Xentry_77_symbol  <= branch_block_stmt_38_76_start; -- transition branch_block_stmt_38/$entry
      branch_block_stmt_38_x_xentry_x_xx_x79_symbol  <=  Xentry_77_symbol; -- place branch_block_stmt_38/branch_block_stmt_38__entry__ (optimized away) 
      branch_block_stmt_38_x_xexit_x_xx_x80_symbol  <=   false ; -- place branch_block_stmt_38/branch_block_stmt_38__exit__ (optimized away) 
      bb_0_bb_1_81_symbol  <=  branch_block_stmt_38_x_xentry_x_xx_x79_symbol; -- place branch_block_stmt_38/bb_0_bb_1 (optimized away) 
      merge_stmt_40_x_xexit_x_xx_x82_symbol  <=  merge_stmt_40_PhiAck_142_symbol; -- place branch_block_stmt_38/merge_stmt_40__exit__ (optimized away) 
      assign_stmt_45_x_xentry_x_xx_x83_symbol  <=  merge_stmt_40_x_xexit_x_xx_x82_symbol; -- place branch_block_stmt_38/assign_stmt_45__entry__ (optimized away) 
      assign_stmt_45_x_xexit_x_xx_x84_symbol  <=  assign_stmt_45_92_symbol; -- place branch_block_stmt_38/assign_stmt_45__exit__ (optimized away) 
      assign_stmt_49_x_xentry_x_xx_x85_symbol  <=  assign_stmt_45_x_xexit_x_xx_x84_symbol; -- place branch_block_stmt_38/assign_stmt_49__entry__ (optimized away) 
      assign_stmt_49_x_xexit_x_xx_x86_symbol  <=  assign_stmt_49_95_symbol; -- place branch_block_stmt_38/assign_stmt_49__exit__ (optimized away) 
      assign_stmt_54_x_xentry_x_xx_x87_symbol  <=  assign_stmt_49_x_xexit_x_xx_x86_symbol; -- place branch_block_stmt_38/assign_stmt_54__entry__ (optimized away) 
      assign_stmt_54_x_xexit_x_xx_x88_symbol  <=  assign_stmt_54_113_symbol; -- place branch_block_stmt_38/assign_stmt_54__exit__ (optimized away) 
      assign_stmt_58_x_xentry_x_xx_x89_symbol  <=  assign_stmt_54_x_xexit_x_xx_x88_symbol; -- place branch_block_stmt_38/assign_stmt_58__entry__ (optimized away) 
      assign_stmt_58_x_xexit_x_xx_x90_symbol  <=  assign_stmt_58_116_symbol; -- place branch_block_stmt_38/assign_stmt_58__exit__ (optimized away) 
      bb_1_bb_1_91_symbol  <=  assign_stmt_58_x_xexit_x_xx_x90_symbol; -- place branch_block_stmt_38/bb_1_bb_1 (optimized away) 
      assign_stmt_45_92: Block -- branch_block_stmt_38/assign_stmt_45 
        signal assign_stmt_45_92_start: Boolean;
        signal Xentry_93_symbol: Boolean;
        signal Xexit_94_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_45_92_start <= assign_stmt_45_x_xentry_x_xx_x83_symbol; -- control passed to block
        Xentry_93_symbol  <= assign_stmt_45_92_start; -- transition branch_block_stmt_38/assign_stmt_45/$entry
        Xexit_94_symbol <= Xentry_93_symbol; -- transition branch_block_stmt_38/assign_stmt_45/$exit
        assign_stmt_45_92_symbol <= Xexit_94_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/assign_stmt_45
      assign_stmt_49_95: Block -- branch_block_stmt_38/assign_stmt_49 
        signal assign_stmt_49_95_start: Boolean;
        signal Xentry_96_symbol: Boolean;
        signal Xexit_97_symbol: Boolean;
        signal assign_stmt_49_active_x_x98_symbol : Boolean;
        signal assign_stmt_49_completed_x_x99_symbol : Boolean;
        signal type_cast_48_active_x_x100_symbol : Boolean;
        signal type_cast_48_trigger_x_x101_symbol : Boolean;
        signal simple_obj_ref_47_trigger_x_x102_symbol : Boolean;
        signal simple_obj_ref_47_complete_103_symbol : Boolean;
        signal type_cast_48_complete_108_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_49_95_start <= assign_stmt_49_x_xentry_x_xx_x85_symbol; -- control passed to block
        Xentry_96_symbol  <= assign_stmt_49_95_start; -- transition branch_block_stmt_38/assign_stmt_49/$entry
        assign_stmt_49_active_x_x98_symbol <= type_cast_48_complete_108_symbol; -- transition branch_block_stmt_38/assign_stmt_49/assign_stmt_49_active_
        assign_stmt_49_completed_x_x99_symbol <= assign_stmt_49_active_x_x98_symbol; -- transition branch_block_stmt_38/assign_stmt_49/assign_stmt_49_completed_
        type_cast_48_active_x_x100_block : Block -- non-trivial join transition branch_block_stmt_38/assign_stmt_49/type_cast_48_active_ 
          signal type_cast_48_active_x_x100_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_48_active_x_x100_predecessors(0) <= type_cast_48_trigger_x_x101_symbol;
          type_cast_48_active_x_x100_predecessors(1) <= simple_obj_ref_47_complete_103_symbol;
          type_cast_48_active_x_x100_join: join -- 
            port map( -- 
              preds => type_cast_48_active_x_x100_predecessors,
              symbol_out => type_cast_48_active_x_x100_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_38/assign_stmt_49/type_cast_48_active_
        type_cast_48_trigger_x_x101_symbol <= Xentry_96_symbol; -- transition branch_block_stmt_38/assign_stmt_49/type_cast_48_trigger_
        simple_obj_ref_47_trigger_x_x102_symbol <= Xentry_96_symbol; -- transition branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_trigger_
        simple_obj_ref_47_complete_103: Block -- branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_complete 
          signal simple_obj_ref_47_complete_103_start: Boolean;
          signal Xentry_104_symbol: Boolean;
          signal Xexit_105_symbol: Boolean;
          signal req_106_symbol : Boolean;
          signal ack_107_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_47_complete_103_start <= simple_obj_ref_47_trigger_x_x102_symbol; -- control passed to block
          Xentry_104_symbol  <= simple_obj_ref_47_complete_103_start; -- transition branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_complete/$entry
          req_106_symbol <= Xentry_104_symbol; -- transition branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_complete/req
          simple_obj_ref_47_inst_req_0 <= req_106_symbol; -- link to DP
          ack_107_symbol <= simple_obj_ref_47_inst_ack_0; -- transition branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_complete/ack
          Xexit_105_symbol <= ack_107_symbol; -- transition branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_complete/$exit
          simple_obj_ref_47_complete_103_symbol <= Xexit_105_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_38/assign_stmt_49/simple_obj_ref_47_complete
        type_cast_48_complete_108: Block -- branch_block_stmt_38/assign_stmt_49/type_cast_48_complete 
          signal type_cast_48_complete_108_start: Boolean;
          signal Xentry_109_symbol: Boolean;
          signal Xexit_110_symbol: Boolean;
          signal req_111_symbol : Boolean;
          signal ack_112_symbol : Boolean;
          -- 
        begin -- 
          type_cast_48_complete_108_start <= type_cast_48_active_x_x100_symbol; -- control passed to block
          Xentry_109_symbol  <= type_cast_48_complete_108_start; -- transition branch_block_stmt_38/assign_stmt_49/type_cast_48_complete/$entry
          req_111_symbol <= Xentry_109_symbol; -- transition branch_block_stmt_38/assign_stmt_49/type_cast_48_complete/req
          type_cast_48_inst_req_0 <= req_111_symbol; -- link to DP
          ack_112_symbol <= type_cast_48_inst_ack_0; -- transition branch_block_stmt_38/assign_stmt_49/type_cast_48_complete/ack
          Xexit_110_symbol <= ack_112_symbol; -- transition branch_block_stmt_38/assign_stmt_49/type_cast_48_complete/$exit
          type_cast_48_complete_108_symbol <= Xexit_110_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_38/assign_stmt_49/type_cast_48_complete
        Xexit_97_symbol <= assign_stmt_49_completed_x_x99_symbol; -- transition branch_block_stmt_38/assign_stmt_49/$exit
        assign_stmt_49_95_symbol <= Xexit_97_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/assign_stmt_49
      assign_stmt_54_113: Block -- branch_block_stmt_38/assign_stmt_54 
        signal assign_stmt_54_113_start: Boolean;
        signal Xentry_114_symbol: Boolean;
        signal Xexit_115_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_54_113_start <= assign_stmt_54_x_xentry_x_xx_x87_symbol; -- control passed to block
        Xentry_114_symbol  <= assign_stmt_54_113_start; -- transition branch_block_stmt_38/assign_stmt_54/$entry
        Xexit_115_symbol <= Xentry_114_symbol; -- transition branch_block_stmt_38/assign_stmt_54/$exit
        assign_stmt_54_113_symbol <= Xexit_115_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/assign_stmt_54
      assign_stmt_58_116: Block -- branch_block_stmt_38/assign_stmt_58 
        signal assign_stmt_58_116_start: Boolean;
        signal Xentry_117_symbol: Boolean;
        signal Xexit_118_symbol: Boolean;
        signal assign_stmt_58_active_x_x119_symbol : Boolean;
        signal assign_stmt_58_completed_x_x120_symbol : Boolean;
        signal type_cast_57_active_x_x121_symbol : Boolean;
        signal type_cast_57_trigger_x_x122_symbol : Boolean;
        signal simple_obj_ref_56_complete_123_symbol : Boolean;
        signal type_cast_57_complete_124_symbol : Boolean;
        signal simple_obj_ref_55_trigger_x_x129_symbol : Boolean;
        signal simple_obj_ref_55_complete_130_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_58_116_start <= assign_stmt_58_x_xentry_x_xx_x89_symbol; -- control passed to block
        Xentry_117_symbol  <= assign_stmt_58_116_start; -- transition branch_block_stmt_38/assign_stmt_58/$entry
        assign_stmt_58_active_x_x119_symbol <= type_cast_57_complete_124_symbol; -- transition branch_block_stmt_38/assign_stmt_58/assign_stmt_58_active_
        assign_stmt_58_completed_x_x120_symbol <= simple_obj_ref_55_complete_130_symbol; -- transition branch_block_stmt_38/assign_stmt_58/assign_stmt_58_completed_
        type_cast_57_active_x_x121_block : Block -- non-trivial join transition branch_block_stmt_38/assign_stmt_58/type_cast_57_active_ 
          signal type_cast_57_active_x_x121_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_57_active_x_x121_predecessors(0) <= type_cast_57_trigger_x_x122_symbol;
          type_cast_57_active_x_x121_predecessors(1) <= simple_obj_ref_56_complete_123_symbol;
          type_cast_57_active_x_x121_join: join -- 
            port map( -- 
              preds => type_cast_57_active_x_x121_predecessors,
              symbol_out => type_cast_57_active_x_x121_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_38/assign_stmt_58/type_cast_57_active_
        type_cast_57_trigger_x_x122_symbol <= Xentry_117_symbol; -- transition branch_block_stmt_38/assign_stmt_58/type_cast_57_trigger_
        simple_obj_ref_56_complete_123_symbol <= Xentry_117_symbol; -- transition branch_block_stmt_38/assign_stmt_58/simple_obj_ref_56_complete
        type_cast_57_complete_124: Block -- branch_block_stmt_38/assign_stmt_58/type_cast_57_complete 
          signal type_cast_57_complete_124_start: Boolean;
          signal Xentry_125_symbol: Boolean;
          signal Xexit_126_symbol: Boolean;
          signal req_127_symbol : Boolean;
          signal ack_128_symbol : Boolean;
          -- 
        begin -- 
          type_cast_57_complete_124_start <= type_cast_57_active_x_x121_symbol; -- control passed to block
          Xentry_125_symbol  <= type_cast_57_complete_124_start; -- transition branch_block_stmt_38/assign_stmt_58/type_cast_57_complete/$entry
          req_127_symbol <= Xentry_125_symbol; -- transition branch_block_stmt_38/assign_stmt_58/type_cast_57_complete/req
          type_cast_57_inst_req_0 <= req_127_symbol; -- link to DP
          ack_128_symbol <= type_cast_57_inst_ack_0; -- transition branch_block_stmt_38/assign_stmt_58/type_cast_57_complete/ack
          Xexit_126_symbol <= ack_128_symbol; -- transition branch_block_stmt_38/assign_stmt_58/type_cast_57_complete/$exit
          type_cast_57_complete_124_symbol <= Xexit_126_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_38/assign_stmt_58/type_cast_57_complete
        simple_obj_ref_55_trigger_x_x129_symbol <= assign_stmt_58_active_x_x119_symbol; -- transition branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_trigger_
        simple_obj_ref_55_complete_130: Block -- branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_complete 
          signal simple_obj_ref_55_complete_130_start: Boolean;
          signal Xentry_131_symbol: Boolean;
          signal Xexit_132_symbol: Boolean;
          signal pipe_wreq_133_symbol : Boolean;
          signal pipe_wack_134_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_55_complete_130_start <= simple_obj_ref_55_trigger_x_x129_symbol; -- control passed to block
          Xentry_131_symbol  <= simple_obj_ref_55_complete_130_start; -- transition branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_complete/$entry
          pipe_wreq_133_symbol <= Xentry_131_symbol; -- transition branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_complete/pipe_wreq
          simple_obj_ref_55_inst_req_0 <= pipe_wreq_133_symbol; -- link to DP
          pipe_wack_134_symbol <= simple_obj_ref_55_inst_ack_0; -- transition branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_complete/pipe_wack
          Xexit_132_symbol <= pipe_wack_134_symbol; -- transition branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_complete/$exit
          simple_obj_ref_55_complete_130_symbol <= Xexit_132_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_38/assign_stmt_58/simple_obj_ref_55_complete
        Xexit_118_symbol <= assign_stmt_58_completed_x_x120_symbol; -- transition branch_block_stmt_38/assign_stmt_58/$exit
        assign_stmt_58_116_symbol <= Xexit_118_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/assign_stmt_58
      bb_0_bb_1_PhiReq_135: Block -- branch_block_stmt_38/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_135_start: Boolean;
        signal Xentry_136_symbol: Boolean;
        signal Xexit_137_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_135_start <= bb_0_bb_1_81_symbol; -- control passed to block
        Xentry_136_symbol  <= bb_0_bb_1_PhiReq_135_start; -- transition branch_block_stmt_38/bb_0_bb_1_PhiReq/$entry
        Xexit_137_symbol <= Xentry_136_symbol; -- transition branch_block_stmt_38/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_135_symbol <= Xexit_137_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_138: Block -- branch_block_stmt_38/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_138_start: Boolean;
        signal Xentry_139_symbol: Boolean;
        signal Xexit_140_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_138_start <= bb_1_bb_1_91_symbol; -- control passed to block
        Xentry_139_symbol  <= bb_1_bb_1_PhiReq_138_start; -- transition branch_block_stmt_38/bb_1_bb_1_PhiReq/$entry
        Xexit_140_symbol <= Xentry_139_symbol; -- transition branch_block_stmt_38/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_138_symbol <= Xexit_140_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/bb_1_bb_1_PhiReq
      merge_stmt_40_PhiReqMerge_141_symbol  <=  bb_0_bb_1_PhiReq_135_symbol or bb_1_bb_1_PhiReq_138_symbol; -- place branch_block_stmt_38/merge_stmt_40_PhiReqMerge (optimized away) 
      merge_stmt_40_PhiAck_142: Block -- branch_block_stmt_38/merge_stmt_40_PhiAck 
        signal merge_stmt_40_PhiAck_142_start: Boolean;
        signal Xentry_143_symbol: Boolean;
        signal Xexit_144_symbol: Boolean;
        signal dummy_145_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_40_PhiAck_142_start <= merge_stmt_40_PhiReqMerge_141_symbol; -- control passed to block
        Xentry_143_symbol  <= merge_stmt_40_PhiAck_142_start; -- transition branch_block_stmt_38/merge_stmt_40_PhiAck/$entry
        dummy_145_symbol <= Xentry_143_symbol; -- transition branch_block_stmt_38/merge_stmt_40_PhiAck/dummy
        Xexit_144_symbol <= dummy_145_symbol; -- transition branch_block_stmt_38/merge_stmt_40_PhiAck/$exit
        merge_stmt_40_PhiAck_142_symbol <= Xexit_144_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_38/merge_stmt_40_PhiAck
      Xexit_78_symbol <= branch_block_stmt_38_x_xexit_x_xx_x80_symbol; -- transition branch_block_stmt_38/$exit
      branch_block_stmt_38_76_symbol <= Xexit_78_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_38
    Xexit_75_symbol <= branch_block_stmt_38_76_symbol; -- transition $exit
    fin  <=  '1' when Xexit_75_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal iNsTr_1_45 : std_logic_vector(31 downto 0);
    signal iNsTr_2_49 : std_logic_vector(63 downto 0);
    signal iNsTr_3_54 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_47_wire : std_logic_vector(63 downto 0);
    signal type_cast_57_wire : std_logic_vector(63 downto 0);
    -- 
  begin -- 
    iNsTr_1_45 <= "00000000000000000000000000000000";
    iNsTr_3_54 <= "00000000000000000000000000000000";
    type_cast_48_inst: RegisterBase generic map(in_data_width => 64,out_data_width => 64) -- 
      port map( din => simple_obj_ref_47_wire, dout => iNsTr_2_49, req => type_cast_48_inst_req_0, ack => type_cast_48_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_57_inst: RegisterBase generic map(in_data_width => 64,out_data_width => 64) -- 
      port map( din => iNsTr_2_49, dout => type_cast_57_wire, req => type_cast_57_inst_req_0, ack => type_cast_57_inst_ack_0, clk => clk, reset => reset); -- 
    -- shared inport operator group (0) : simple_obj_ref_47_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_47_inst_req_0;
      simple_obj_ref_47_inst_ack_0 <= ack(0);
      simple_obj_ref_47_wire <= data_out(63 downto 0);
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
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_55_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_55_inst_req_0;
      simple_obj_ref_55_inst_ack_0 <= ack(0);
      data_in <= type_cast_57_wire;
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
    end Block; -- outport group 0
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
  -- declarations related to module ctrl_module
  component ctrl_module is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module ctrl_module
  signal ctrl_module_tag_in    : std_logic_vector(0 downto 0);
  signal ctrl_module_tag_out   : std_logic_vector(0 downto 0);
  signal ctrl_module_start : std_logic;
  signal ctrl_module_fin   : std_logic;
  -- declarations related to module data_module
  component data_module is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module data_module
  signal data_module_tag_in    : std_logic_vector(0 downto 0);
  signal data_module_tag_out   : std_logic_vector(0 downto 0);
  signal data_module_start : std_logic;
  signal data_module_fin   : std_logic;
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
  -- module ctrl_module
  ctrl_module_instance:ctrl_module-- 
    port map(-- 
      start => ctrl_module_start,
      fin => ctrl_module_fin,
      clk => clk,
      reset => reset,
      in_ctrl_pipe_read_req => in_ctrl_pipe_read_req(0 downto 0),
      in_ctrl_pipe_read_ack => in_ctrl_pipe_read_ack(0 downto 0),
      in_ctrl_pipe_read_data => in_ctrl_pipe_read_data(7 downto 0),
      out_ctrl_pipe_write_req => out_ctrl_pipe_write_req(0 downto 0),
      out_ctrl_pipe_write_ack => out_ctrl_pipe_write_ack(0 downto 0),
      out_ctrl_pipe_write_data => out_ctrl_pipe_write_data(7 downto 0),
      tag_in => ctrl_module_tag_in,
      tag_out => ctrl_module_tag_out-- 
    ); -- 
  -- module will be run forever 
  ctrl_module_tag_in <= (others => '0');
  ctrl_module_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => ctrl_module_start, fin => ctrl_module_fin);
  -- module data_module
  data_module_instance:data_module-- 
    port map(-- 
      start => data_module_start,
      fin => data_module_fin,
      clk => clk,
      reset => reset,
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(63 downto 0),
      out_data_pipe_write_req => out_data_pipe_write_req(0 downto 0),
      out_data_pipe_write_ack => out_data_pipe_write_ack(0 downto 0),
      out_data_pipe_write_data => out_data_pipe_write_data(63 downto 0),
      tag_in => data_module_tag_in,
      tag_out => data_module_tag_out-- 
    ); -- 
  -- module will be run forever 
  data_module_tag_in <= (others => '0');
  data_module_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => data_module_start, fin => data_module_fin);
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
