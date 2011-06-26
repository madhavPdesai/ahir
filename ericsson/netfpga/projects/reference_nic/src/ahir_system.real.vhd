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
  signal simple_obj_ref_19_inst_req_0 : boolean;
  signal simple_obj_ref_19_inst_ack_0 : boolean;
  signal simple_obj_ref_17_inst_req_0 : boolean;
  signal simple_obj_ref_17_inst_ack_0 : boolean;
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
      signal assign_stmt_18_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_18_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_21_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_21_x_xexit_x_xx_x13_symbol : Boolean;
      signal bb_1_bb_1_14_symbol : Boolean;
      signal assign_stmt_18_15_symbol : Boolean;
      signal assign_stmt_21_26_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_38_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_41_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_44_symbol : Boolean;
      signal merge_stmt_15_PhiAck_45_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x9_symbol  <=  merge_stmt_15_PhiAck_45_symbol; -- place branch_block_stmt_13/merge_stmt_15__exit__ (optimized away) 
      assign_stmt_18_x_xentry_x_xx_x10_symbol  <=  merge_stmt_15_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/assign_stmt_18__entry__ (optimized away) 
      assign_stmt_18_x_xexit_x_xx_x11_symbol  <=  assign_stmt_18_15_symbol; -- place branch_block_stmt_13/assign_stmt_18__exit__ (optimized away) 
      assign_stmt_21_x_xentry_x_xx_x12_symbol  <=  assign_stmt_18_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_21__entry__ (optimized away) 
      assign_stmt_21_x_xexit_x_xx_x13_symbol  <=  assign_stmt_21_26_symbol; -- place branch_block_stmt_13/assign_stmt_21__exit__ (optimized away) 
      bb_1_bb_1_14_symbol  <=  assign_stmt_21_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/bb_1_bb_1 (optimized away) 
      assign_stmt_18_15: Block -- branch_block_stmt_13/assign_stmt_18 
        signal assign_stmt_18_15_start: Boolean;
        signal Xentry_16_symbol: Boolean;
        signal Xexit_17_symbol: Boolean;
        signal assign_stmt_18_active_x_x18_symbol : Boolean;
        signal assign_stmt_18_completed_x_x19_symbol : Boolean;
        signal simple_obj_ref_17_trigger_x_x20_symbol : Boolean;
        signal simple_obj_ref_17_complete_21_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_18_15_start <= assign_stmt_18_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_16_symbol  <= assign_stmt_18_15_start; -- transition branch_block_stmt_13/assign_stmt_18/$entry
        assign_stmt_18_active_x_x18_symbol <= simple_obj_ref_17_complete_21_symbol; -- transition branch_block_stmt_13/assign_stmt_18/assign_stmt_18_active_
        assign_stmt_18_completed_x_x19_symbol <= assign_stmt_18_active_x_x18_symbol; -- transition branch_block_stmt_13/assign_stmt_18/assign_stmt_18_completed_
        simple_obj_ref_17_trigger_x_x20_symbol <= Xentry_16_symbol; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_trigger_
        simple_obj_ref_17_complete_21: Block -- branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete 
          signal simple_obj_ref_17_complete_21_start: Boolean;
          signal Xentry_22_symbol: Boolean;
          signal Xexit_23_symbol: Boolean;
          signal req_24_symbol : Boolean;
          signal ack_25_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_17_complete_21_start <= simple_obj_ref_17_trigger_x_x20_symbol; -- control passed to block
          Xentry_22_symbol  <= simple_obj_ref_17_complete_21_start; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/$entry
          req_24_symbol <= Xentry_22_symbol; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/req
          simple_obj_ref_17_inst_req_0 <= req_24_symbol; -- link to DP
          ack_25_symbol <= simple_obj_ref_17_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/ack
          Xexit_23_symbol <= ack_25_symbol; -- transition branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete/$exit
          simple_obj_ref_17_complete_21_symbol <= Xexit_23_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_18/simple_obj_ref_17_complete
        Xexit_17_symbol <= assign_stmt_18_completed_x_x19_symbol; -- transition branch_block_stmt_13/assign_stmt_18/$exit
        assign_stmt_18_15_symbol <= Xexit_17_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_18
      assign_stmt_21_26: Block -- branch_block_stmt_13/assign_stmt_21 
        signal assign_stmt_21_26_start: Boolean;
        signal Xentry_27_symbol: Boolean;
        signal Xexit_28_symbol: Boolean;
        signal assign_stmt_21_active_x_x29_symbol : Boolean;
        signal assign_stmt_21_completed_x_x30_symbol : Boolean;
        signal simple_obj_ref_20_complete_31_symbol : Boolean;
        signal simple_obj_ref_19_trigger_x_x32_symbol : Boolean;
        signal simple_obj_ref_19_complete_33_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_21_26_start <= assign_stmt_21_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_27_symbol  <= assign_stmt_21_26_start; -- transition branch_block_stmt_13/assign_stmt_21/$entry
        assign_stmt_21_active_x_x29_symbol <= simple_obj_ref_20_complete_31_symbol; -- transition branch_block_stmt_13/assign_stmt_21/assign_stmt_21_active_
        assign_stmt_21_completed_x_x30_symbol <= simple_obj_ref_19_complete_33_symbol; -- transition branch_block_stmt_13/assign_stmt_21/assign_stmt_21_completed_
        simple_obj_ref_20_complete_31_symbol <= Xentry_27_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_20_complete
        simple_obj_ref_19_trigger_x_x32_symbol <= assign_stmt_21_active_x_x29_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_trigger_
        simple_obj_ref_19_complete_33: Block -- branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_complete 
          signal simple_obj_ref_19_complete_33_start: Boolean;
          signal Xentry_34_symbol: Boolean;
          signal Xexit_35_symbol: Boolean;
          signal pipe_wreq_36_symbol : Boolean;
          signal pipe_wack_37_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_19_complete_33_start <= simple_obj_ref_19_trigger_x_x32_symbol; -- control passed to block
          Xentry_34_symbol  <= simple_obj_ref_19_complete_33_start; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_complete/$entry
          pipe_wreq_36_symbol <= Xentry_34_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_complete/pipe_wreq
          simple_obj_ref_19_inst_req_0 <= pipe_wreq_36_symbol; -- link to DP
          pipe_wack_37_symbol <= simple_obj_ref_19_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_complete/pipe_wack
          Xexit_35_symbol <= pipe_wack_37_symbol; -- transition branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_complete/$exit
          simple_obj_ref_19_complete_33_symbol <= Xexit_35_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_21/simple_obj_ref_19_complete
        Xexit_28_symbol <= assign_stmt_21_completed_x_x30_symbol; -- transition branch_block_stmt_13/assign_stmt_21/$exit
        assign_stmt_21_26_symbol <= Xexit_28_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_21
      bb_0_bb_1_PhiReq_38: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_38_start: Boolean;
        signal Xentry_39_symbol: Boolean;
        signal Xexit_40_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_38_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_39_symbol  <= bb_0_bb_1_PhiReq_38_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        Xexit_40_symbol <= Xentry_39_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_38_symbol <= Xexit_40_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_41: Block -- branch_block_stmt_13/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_41_start: Boolean;
        signal Xentry_42_symbol: Boolean;
        signal Xexit_43_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_41_start <= bb_1_bb_1_14_symbol; -- control passed to block
        Xentry_42_symbol  <= bb_1_bb_1_PhiReq_41_start; -- transition branch_block_stmt_13/bb_1_bb_1_PhiReq/$entry
        Xexit_43_symbol <= Xentry_42_symbol; -- transition branch_block_stmt_13/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_41_symbol <= Xexit_43_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_1_PhiReq
      merge_stmt_15_PhiReqMerge_44_symbol  <=  bb_0_bb_1_PhiReq_38_symbol or bb_1_bb_1_PhiReq_41_symbol; -- place branch_block_stmt_13/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_45: Block -- branch_block_stmt_13/merge_stmt_15_PhiAck 
        signal merge_stmt_15_PhiAck_45_start: Boolean;
        signal Xentry_46_symbol: Boolean;
        signal Xexit_47_symbol: Boolean;
        signal dummy_48_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_45_start <= merge_stmt_15_PhiReqMerge_44_symbol; -- control passed to block
        Xentry_46_symbol  <= merge_stmt_15_PhiAck_45_start; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$entry
        dummy_48_symbol <= Xentry_46_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/dummy
        Xexit_47_symbol <= dummy_48_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_45_symbol <= Xexit_47_symbol; -- control passed from block 
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
    signal iNsTr_2_18 : std_logic_vector(7 downto 0);
    -- 
  begin -- 
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
    -- shared outport operator group (0) : simple_obj_ref_19_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_19_inst_req_0;
      simple_obj_ref_19_inst_ack_0 <= ack(0);
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
  signal simple_obj_ref_32_inst_ack_0 : boolean;
  signal simple_obj_ref_30_inst_req_0 : boolean;
  signal simple_obj_ref_30_inst_ack_0 : boolean;
  signal simple_obj_ref_32_inst_req_0 : boolean;
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
  data_module_CP_49: Block -- control-path 
    signal data_module_CP_49_start: Boolean;
    signal Xentry_50_symbol: Boolean;
    signal Xexit_51_symbol: Boolean;
    signal branch_block_stmt_26_52_symbol : Boolean;
    -- 
  begin -- 
    data_module_CP_49_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_50_symbol  <= data_module_CP_49_start; -- transition $entry
    branch_block_stmt_26_52: Block -- branch_block_stmt_26 
      signal branch_block_stmt_26_52_start: Boolean;
      signal Xentry_53_symbol: Boolean;
      signal Xexit_54_symbol: Boolean;
      signal branch_block_stmt_26_x_xentry_x_xx_x55_symbol : Boolean;
      signal branch_block_stmt_26_x_xexit_x_xx_x56_symbol : Boolean;
      signal bb_0_bb_1_57_symbol : Boolean;
      signal merge_stmt_28_x_xexit_x_xx_x58_symbol : Boolean;
      signal assign_stmt_31_x_xentry_x_xx_x59_symbol : Boolean;
      signal assign_stmt_31_x_xexit_x_xx_x60_symbol : Boolean;
      signal assign_stmt_34_x_xentry_x_xx_x61_symbol : Boolean;
      signal assign_stmt_34_x_xexit_x_xx_x62_symbol : Boolean;
      signal bb_1_bb_1_63_symbol : Boolean;
      signal assign_stmt_31_64_symbol : Boolean;
      signal assign_stmt_34_75_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_87_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_90_symbol : Boolean;
      signal merge_stmt_28_PhiReqMerge_93_symbol : Boolean;
      signal merge_stmt_28_PhiAck_94_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_26_52_start <= Xentry_50_symbol; -- control passed to block
      Xentry_53_symbol  <= branch_block_stmt_26_52_start; -- transition branch_block_stmt_26/$entry
      branch_block_stmt_26_x_xentry_x_xx_x55_symbol  <=  Xentry_53_symbol; -- place branch_block_stmt_26/branch_block_stmt_26__entry__ (optimized away) 
      branch_block_stmt_26_x_xexit_x_xx_x56_symbol  <=   false ; -- place branch_block_stmt_26/branch_block_stmt_26__exit__ (optimized away) 
      bb_0_bb_1_57_symbol  <=  branch_block_stmt_26_x_xentry_x_xx_x55_symbol; -- place branch_block_stmt_26/bb_0_bb_1 (optimized away) 
      merge_stmt_28_x_xexit_x_xx_x58_symbol  <=  merge_stmt_28_PhiAck_94_symbol; -- place branch_block_stmt_26/merge_stmt_28__exit__ (optimized away) 
      assign_stmt_31_x_xentry_x_xx_x59_symbol  <=  merge_stmt_28_x_xexit_x_xx_x58_symbol; -- place branch_block_stmt_26/assign_stmt_31__entry__ (optimized away) 
      assign_stmt_31_x_xexit_x_xx_x60_symbol  <=  assign_stmt_31_64_symbol; -- place branch_block_stmt_26/assign_stmt_31__exit__ (optimized away) 
      assign_stmt_34_x_xentry_x_xx_x61_symbol  <=  assign_stmt_31_x_xexit_x_xx_x60_symbol; -- place branch_block_stmt_26/assign_stmt_34__entry__ (optimized away) 
      assign_stmt_34_x_xexit_x_xx_x62_symbol  <=  assign_stmt_34_75_symbol; -- place branch_block_stmt_26/assign_stmt_34__exit__ (optimized away) 
      bb_1_bb_1_63_symbol  <=  assign_stmt_34_x_xexit_x_xx_x62_symbol; -- place branch_block_stmt_26/bb_1_bb_1 (optimized away) 
      assign_stmt_31_64: Block -- branch_block_stmt_26/assign_stmt_31 
        signal assign_stmt_31_64_start: Boolean;
        signal Xentry_65_symbol: Boolean;
        signal Xexit_66_symbol: Boolean;
        signal assign_stmt_31_active_x_x67_symbol : Boolean;
        signal assign_stmt_31_completed_x_x68_symbol : Boolean;
        signal simple_obj_ref_30_trigger_x_x69_symbol : Boolean;
        signal simple_obj_ref_30_complete_70_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_31_64_start <= assign_stmt_31_x_xentry_x_xx_x59_symbol; -- control passed to block
        Xentry_65_symbol  <= assign_stmt_31_64_start; -- transition branch_block_stmt_26/assign_stmt_31/$entry
        assign_stmt_31_active_x_x67_symbol <= simple_obj_ref_30_complete_70_symbol; -- transition branch_block_stmt_26/assign_stmt_31/assign_stmt_31_active_
        assign_stmt_31_completed_x_x68_symbol <= assign_stmt_31_active_x_x67_symbol; -- transition branch_block_stmt_26/assign_stmt_31/assign_stmt_31_completed_
        simple_obj_ref_30_trigger_x_x69_symbol <= Xentry_65_symbol; -- transition branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_trigger_
        simple_obj_ref_30_complete_70: Block -- branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_complete 
          signal simple_obj_ref_30_complete_70_start: Boolean;
          signal Xentry_71_symbol: Boolean;
          signal Xexit_72_symbol: Boolean;
          signal req_73_symbol : Boolean;
          signal ack_74_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_30_complete_70_start <= simple_obj_ref_30_trigger_x_x69_symbol; -- control passed to block
          Xentry_71_symbol  <= simple_obj_ref_30_complete_70_start; -- transition branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_complete/$entry
          req_73_symbol <= Xentry_71_symbol; -- transition branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_complete/req
          simple_obj_ref_30_inst_req_0 <= req_73_symbol; -- link to DP
          ack_74_symbol <= simple_obj_ref_30_inst_ack_0; -- transition branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_complete/ack
          Xexit_72_symbol <= ack_74_symbol; -- transition branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_complete/$exit
          simple_obj_ref_30_complete_70_symbol <= Xexit_72_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_26/assign_stmt_31/simple_obj_ref_30_complete
        Xexit_66_symbol <= assign_stmt_31_completed_x_x68_symbol; -- transition branch_block_stmt_26/assign_stmt_31/$exit
        assign_stmt_31_64_symbol <= Xexit_66_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_26/assign_stmt_31
      assign_stmt_34_75: Block -- branch_block_stmt_26/assign_stmt_34 
        signal assign_stmt_34_75_start: Boolean;
        signal Xentry_76_symbol: Boolean;
        signal Xexit_77_symbol: Boolean;
        signal assign_stmt_34_active_x_x78_symbol : Boolean;
        signal assign_stmt_34_completed_x_x79_symbol : Boolean;
        signal simple_obj_ref_33_complete_80_symbol : Boolean;
        signal simple_obj_ref_32_trigger_x_x81_symbol : Boolean;
        signal simple_obj_ref_32_complete_82_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_34_75_start <= assign_stmt_34_x_xentry_x_xx_x61_symbol; -- control passed to block
        Xentry_76_symbol  <= assign_stmt_34_75_start; -- transition branch_block_stmt_26/assign_stmt_34/$entry
        assign_stmt_34_active_x_x78_symbol <= simple_obj_ref_33_complete_80_symbol; -- transition branch_block_stmt_26/assign_stmt_34/assign_stmt_34_active_
        assign_stmt_34_completed_x_x79_symbol <= simple_obj_ref_32_complete_82_symbol; -- transition branch_block_stmt_26/assign_stmt_34/assign_stmt_34_completed_
        simple_obj_ref_33_complete_80_symbol <= Xentry_76_symbol; -- transition branch_block_stmt_26/assign_stmt_34/simple_obj_ref_33_complete
        simple_obj_ref_32_trigger_x_x81_symbol <= assign_stmt_34_active_x_x78_symbol; -- transition branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_trigger_
        simple_obj_ref_32_complete_82: Block -- branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_complete 
          signal simple_obj_ref_32_complete_82_start: Boolean;
          signal Xentry_83_symbol: Boolean;
          signal Xexit_84_symbol: Boolean;
          signal pipe_wreq_85_symbol : Boolean;
          signal pipe_wack_86_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_32_complete_82_start <= simple_obj_ref_32_trigger_x_x81_symbol; -- control passed to block
          Xentry_83_symbol  <= simple_obj_ref_32_complete_82_start; -- transition branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_complete/$entry
          pipe_wreq_85_symbol <= Xentry_83_symbol; -- transition branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_complete/pipe_wreq
          simple_obj_ref_32_inst_req_0 <= pipe_wreq_85_symbol; -- link to DP
          pipe_wack_86_symbol <= simple_obj_ref_32_inst_ack_0; -- transition branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_complete/pipe_wack
          Xexit_84_symbol <= pipe_wack_86_symbol; -- transition branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_complete/$exit
          simple_obj_ref_32_complete_82_symbol <= Xexit_84_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_26/assign_stmt_34/simple_obj_ref_32_complete
        Xexit_77_symbol <= assign_stmt_34_completed_x_x79_symbol; -- transition branch_block_stmt_26/assign_stmt_34/$exit
        assign_stmt_34_75_symbol <= Xexit_77_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_26/assign_stmt_34
      bb_0_bb_1_PhiReq_87: Block -- branch_block_stmt_26/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_87_start: Boolean;
        signal Xentry_88_symbol: Boolean;
        signal Xexit_89_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_87_start <= bb_0_bb_1_57_symbol; -- control passed to block
        Xentry_88_symbol  <= bb_0_bb_1_PhiReq_87_start; -- transition branch_block_stmt_26/bb_0_bb_1_PhiReq/$entry
        Xexit_89_symbol <= Xentry_88_symbol; -- transition branch_block_stmt_26/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_87_symbol <= Xexit_89_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_26/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_90: Block -- branch_block_stmt_26/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_90_start: Boolean;
        signal Xentry_91_symbol: Boolean;
        signal Xexit_92_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_90_start <= bb_1_bb_1_63_symbol; -- control passed to block
        Xentry_91_symbol  <= bb_1_bb_1_PhiReq_90_start; -- transition branch_block_stmt_26/bb_1_bb_1_PhiReq/$entry
        Xexit_92_symbol <= Xentry_91_symbol; -- transition branch_block_stmt_26/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_90_symbol <= Xexit_92_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_26/bb_1_bb_1_PhiReq
      merge_stmt_28_PhiReqMerge_93_symbol  <=  bb_0_bb_1_PhiReq_87_symbol or bb_1_bb_1_PhiReq_90_symbol; -- place branch_block_stmt_26/merge_stmt_28_PhiReqMerge (optimized away) 
      merge_stmt_28_PhiAck_94: Block -- branch_block_stmt_26/merge_stmt_28_PhiAck 
        signal merge_stmt_28_PhiAck_94_start: Boolean;
        signal Xentry_95_symbol: Boolean;
        signal Xexit_96_symbol: Boolean;
        signal dummy_97_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_28_PhiAck_94_start <= merge_stmt_28_PhiReqMerge_93_symbol; -- control passed to block
        Xentry_95_symbol  <= merge_stmt_28_PhiAck_94_start; -- transition branch_block_stmt_26/merge_stmt_28_PhiAck/$entry
        dummy_97_symbol <= Xentry_95_symbol; -- transition branch_block_stmt_26/merge_stmt_28_PhiAck/dummy
        Xexit_96_symbol <= dummy_97_symbol; -- transition branch_block_stmt_26/merge_stmt_28_PhiAck/$exit
        merge_stmt_28_PhiAck_94_symbol <= Xexit_96_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_26/merge_stmt_28_PhiAck
      Xexit_54_symbol <= branch_block_stmt_26_x_xexit_x_xx_x56_symbol; -- transition branch_block_stmt_26/$exit
      branch_block_stmt_26_52_symbol <= Xexit_54_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_26
    Xexit_51_symbol <= branch_block_stmt_26_52_symbol; -- transition $exit
    fin  <=  '1' when Xexit_51_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal iNsTr_2_31 : std_logic_vector(63 downto 0);
    -- 
  begin -- 
    -- shared inport operator group (0) : simple_obj_ref_30_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_30_inst_req_0;
      simple_obj_ref_30_inst_ack_0 <= ack(0);
      iNsTr_2_31 <= data_out(63 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_32_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_32_inst_req_0;
      simple_obj_ref_32_inst_ack_0 <= ack(0);
      data_in <= iNsTr_2_31;
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
