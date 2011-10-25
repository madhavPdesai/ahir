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
entity ctrl_module is -- 
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
    out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity ctrl_module;
architecture Default of ctrl_module is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal ctrl_module_CP_0_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_32_inst_req_0 : boolean;
  signal simple_obj_ref_32_inst_ack_0 : boolean;
  signal simple_obj_ref_24_inst_req_0 : boolean;
  signal simple_obj_ref_24_inst_ack_0 : boolean;
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
  ctrl_module_CP_0: Block -- control-path 
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_13_3_start : Boolean;
    signal branch_block_stmt_13_3_symbol : Boolean;
    -- 
  begin -- 
    ctrl_module_CP_0_start_interlock : pipeline_interlock -- 
      port map (trigger => start_req_symbol,
      enable =>  fin_ack_symbol, 
      symbol_out => ctrl_module_CP_0_start, 
      clk => clk, reset => reset); -- 
    start_ack_symbol <= Xexit_2_symbol;
    Xentry_1_symbol  <= ctrl_module_CP_0_start; -- transition $entry
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
      signal bb_1_bb_1_18_symbol : Boolean;
      signal assign_stmt_22_19_start : Boolean;
      signal assign_stmt_22_19_symbol : Boolean;
      signal assign_stmt_25_22_start : Boolean;
      signal assign_stmt_25_22_symbol : Boolean;
      signal assign_stmt_31_33_start : Boolean;
      signal assign_stmt_31_33_symbol : Boolean;
      signal assign_stmt_34_36_start : Boolean;
      signal assign_stmt_34_36_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_48_start : Boolean;
      signal bb_0_bb_1_PhiReq_48_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_51_start : Boolean;
      signal bb_1_bb_1_PhiReq_51_symbol : Boolean;
      signal merge_stmt_15_PhiReqMerge_54_symbol : Boolean;
      signal merge_stmt_15_PhiAck_55_start : Boolean;
      signal merge_stmt_15_PhiAck_55_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_15_x_xexit_x_xx_x9_symbol  <=  merge_stmt_15_PhiAck_55_symbol; -- place branch_block_stmt_13/merge_stmt_15__exit__ (optimized away) 
      assign_stmt_22_x_xentry_x_xx_x10_symbol  <=  merge_stmt_15_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/assign_stmt_22__entry__ (optimized away) 
      assign_stmt_22_x_xexit_x_xx_x11_symbol  <=  assign_stmt_22_19_symbol; -- place branch_block_stmt_13/assign_stmt_22__exit__ (optimized away) 
      assign_stmt_25_x_xentry_x_xx_x12_symbol  <=  assign_stmt_22_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_25__entry__ (optimized away) 
      assign_stmt_25_x_xexit_x_xx_x13_symbol  <=  assign_stmt_25_22_symbol; -- place branch_block_stmt_13/assign_stmt_25__exit__ (optimized away) 
      assign_stmt_31_x_xentry_x_xx_x14_symbol  <=  assign_stmt_25_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/assign_stmt_31__entry__ (optimized away) 
      assign_stmt_31_x_xexit_x_xx_x15_symbol  <=  assign_stmt_31_33_symbol; -- place branch_block_stmt_13/assign_stmt_31__exit__ (optimized away) 
      assign_stmt_34_x_xentry_x_xx_x16_symbol  <=  assign_stmt_31_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_13/assign_stmt_34__entry__ (optimized away) 
      assign_stmt_34_x_xexit_x_xx_x17_symbol  <=  assign_stmt_34_36_symbol; -- place branch_block_stmt_13/assign_stmt_34__exit__ (optimized away) 
      bb_1_bb_1_18_symbol  <=  assign_stmt_34_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_13/bb_1_bb_1 (optimized away) 
      assign_stmt_22_19: Block -- branch_block_stmt_13/assign_stmt_22 
        signal Xentry_20_symbol: Boolean;
        signal Xexit_21_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_22_19_start <= assign_stmt_22_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_20_symbol  <= assign_stmt_22_19_start; -- transition branch_block_stmt_13/assign_stmt_22/$entry
        Xexit_21_symbol <= Xentry_20_symbol; -- transition branch_block_stmt_13/assign_stmt_22/$exit
        assign_stmt_22_19_symbol <= Xexit_21_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_22
      assign_stmt_25_22: Block -- branch_block_stmt_13/assign_stmt_25 
        signal Xentry_23_symbol: Boolean;
        signal Xexit_24_symbol: Boolean;
        signal assign_stmt_25_active_x_x25_symbol : Boolean;
        signal assign_stmt_25_completed_x_x26_symbol : Boolean;
        signal simple_obj_ref_24_trigger_x_x27_symbol : Boolean;
        signal simple_obj_ref_24_complete_28_start : Boolean;
        signal simple_obj_ref_24_complete_28_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_25_22_start <= assign_stmt_25_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_23_symbol  <= assign_stmt_25_22_start; -- transition branch_block_stmt_13/assign_stmt_25/$entry
        assign_stmt_25_active_x_x25_symbol <= simple_obj_ref_24_complete_28_symbol; -- transition branch_block_stmt_13/assign_stmt_25/assign_stmt_25_active_
        assign_stmt_25_completed_x_x26_symbol <= assign_stmt_25_active_x_x25_symbol; -- transition branch_block_stmt_13/assign_stmt_25/assign_stmt_25_completed_
        simple_obj_ref_24_trigger_x_x27_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_trigger_
        simple_obj_ref_24_complete_28: Block -- branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete 
          signal Xentry_29_symbol: Boolean;
          signal Xexit_30_symbol: Boolean;
          signal req_31_symbol : Boolean;
          signal ack_32_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_24_complete_28_start <= simple_obj_ref_24_trigger_x_x27_symbol; -- control passed to block
          Xentry_29_symbol  <= simple_obj_ref_24_complete_28_start; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/$entry
          req_31_symbol <= Xentry_29_symbol; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/req
          simple_obj_ref_24_inst_req_0 <= req_31_symbol; -- link to DP
          ack_32_symbol <= simple_obj_ref_24_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/ack
          Xexit_30_symbol <= ack_32_symbol; -- transition branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete/$exit
          simple_obj_ref_24_complete_28_symbol <= Xexit_30_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_25/simple_obj_ref_24_complete
        Xexit_24_symbol <= assign_stmt_25_completed_x_x26_symbol; -- transition branch_block_stmt_13/assign_stmt_25/$exit
        assign_stmt_25_22_symbol <= Xexit_24_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_25
      assign_stmt_31_33: Block -- branch_block_stmt_13/assign_stmt_31 
        signal Xentry_34_symbol: Boolean;
        signal Xexit_35_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_31_33_start <= assign_stmt_31_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_34_symbol  <= assign_stmt_31_33_start; -- transition branch_block_stmt_13/assign_stmt_31/$entry
        Xexit_35_symbol <= Xentry_34_symbol; -- transition branch_block_stmt_13/assign_stmt_31/$exit
        assign_stmt_31_33_symbol <= Xexit_35_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_31
      assign_stmt_34_36: Block -- branch_block_stmt_13/assign_stmt_34 
        signal Xentry_37_symbol: Boolean;
        signal Xexit_38_symbol: Boolean;
        signal assign_stmt_34_active_x_x39_symbol : Boolean;
        signal assign_stmt_34_completed_x_x40_symbol : Boolean;
        signal simple_obj_ref_33_complete_41_symbol : Boolean;
        signal simple_obj_ref_32_trigger_x_x42_symbol : Boolean;
        signal simple_obj_ref_32_complete_43_start : Boolean;
        signal simple_obj_ref_32_complete_43_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_34_36_start <= assign_stmt_34_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_37_symbol  <= assign_stmt_34_36_start; -- transition branch_block_stmt_13/assign_stmt_34/$entry
        assign_stmt_34_active_x_x39_symbol <= simple_obj_ref_33_complete_41_symbol; -- transition branch_block_stmt_13/assign_stmt_34/assign_stmt_34_active_
        assign_stmt_34_completed_x_x40_symbol <= simple_obj_ref_32_complete_43_symbol; -- transition branch_block_stmt_13/assign_stmt_34/assign_stmt_34_completed_
        simple_obj_ref_33_complete_41_symbol <= Xentry_37_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_33_complete
        simple_obj_ref_32_trigger_x_x42_symbol <= assign_stmt_34_active_x_x39_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_trigger_
        simple_obj_ref_32_complete_43: Block -- branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_complete 
          signal Xentry_44_symbol: Boolean;
          signal Xexit_45_symbol: Boolean;
          signal pipe_wreq_46_symbol : Boolean;
          signal pipe_wack_47_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_32_complete_43_start <= simple_obj_ref_32_trigger_x_x42_symbol; -- control passed to block
          Xentry_44_symbol  <= simple_obj_ref_32_complete_43_start; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_complete/$entry
          pipe_wreq_46_symbol <= Xentry_44_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_complete/pipe_wreq
          simple_obj_ref_32_inst_req_0 <= pipe_wreq_46_symbol; -- link to DP
          pipe_wack_47_symbol <= simple_obj_ref_32_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_complete/pipe_wack
          Xexit_45_symbol <= pipe_wack_47_symbol; -- transition branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_complete/$exit
          simple_obj_ref_32_complete_43_symbol <= Xexit_45_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_34/simple_obj_ref_32_complete
        Xexit_38_symbol <= assign_stmt_34_completed_x_x40_symbol; -- transition branch_block_stmt_13/assign_stmt_34/$exit
        assign_stmt_34_36_symbol <= Xexit_38_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_34
      bb_0_bb_1_PhiReq_48: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal Xentry_49_symbol: Boolean;
        signal Xexit_50_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_48_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_49_symbol  <= bb_0_bb_1_PhiReq_48_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        Xexit_50_symbol <= Xentry_49_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_48_symbol <= Xexit_50_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_51: Block -- branch_block_stmt_13/bb_1_bb_1_PhiReq 
        signal Xentry_52_symbol: Boolean;
        signal Xexit_53_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_51_start <= bb_1_bb_1_18_symbol; -- control passed to block
        Xentry_52_symbol  <= bb_1_bb_1_PhiReq_51_start; -- transition branch_block_stmt_13/bb_1_bb_1_PhiReq/$entry
        Xexit_53_symbol <= Xentry_52_symbol; -- transition branch_block_stmt_13/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_51_symbol <= Xexit_53_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_1_PhiReq
      merge_stmt_15_PhiReqMerge_54_symbol  <=  bb_0_bb_1_PhiReq_48_symbol or bb_1_bb_1_PhiReq_51_symbol; -- place branch_block_stmt_13/merge_stmt_15_PhiReqMerge (optimized away) 
      merge_stmt_15_PhiAck_55: Block -- branch_block_stmt_13/merge_stmt_15_PhiAck 
        signal Xentry_56_symbol: Boolean;
        signal Xexit_57_symbol: Boolean;
        signal dummy_58_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_15_PhiAck_55_start <= merge_stmt_15_PhiReqMerge_54_symbol; -- control passed to block
        Xentry_56_symbol  <= merge_stmt_15_PhiAck_55_start; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$entry
        dummy_58_symbol <= Xentry_56_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/dummy
        Xexit_57_symbol <= dummy_58_symbol; -- transition branch_block_stmt_13/merge_stmt_15_PhiAck/$exit
        merge_stmt_15_PhiAck_55_symbol <= Xexit_57_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_15_PhiAck
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
    signal iNsTr_1_22 : std_logic_vector(31 downto 0);
    signal iNsTr_2_25 : std_logic_vector(7 downto 0);
    signal iNsTr_3_31 : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    iNsTr_1_22 <= "00000000000000000000000000000000";
    iNsTr_3_31 <= "00000000000000000000000000000000";
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
    -- shared outport operator group (0) : simple_obj_ref_32_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_32_inst_req_0;
      simple_obj_ref_32_inst_ack_0 <= ack(0);
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
  generic (tag_length : integer); 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity data_module;
architecture Default of data_module is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal data_module_CP_59_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_49_inst_req_0 : boolean;
  signal simple_obj_ref_49_inst_ack_0 : boolean;
  signal simple_obj_ref_57_inst_req_0 : boolean;
  signal simple_obj_ref_57_inst_ack_0 : boolean;
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
  data_module_CP_59: Block -- control-path 
    signal Xentry_60_symbol: Boolean;
    signal Xexit_61_symbol: Boolean;
    signal branch_block_stmt_39_62_start : Boolean;
    signal branch_block_stmt_39_62_symbol : Boolean;
    -- 
  begin -- 
    data_module_CP_59_start_interlock : pipeline_interlock -- 
      port map (trigger => start_req_symbol,
      enable =>  fin_ack_symbol, 
      symbol_out => data_module_CP_59_start, 
      clk => clk, reset => reset); -- 
    start_ack_symbol <= Xexit_61_symbol;
    Xentry_60_symbol  <= data_module_CP_59_start; -- transition $entry
    branch_block_stmt_39_62: Block -- branch_block_stmt_39 
      signal Xentry_63_symbol: Boolean;
      signal Xexit_64_symbol: Boolean;
      signal branch_block_stmt_39_x_xentry_x_xx_x65_symbol : Boolean;
      signal branch_block_stmt_39_x_xexit_x_xx_x66_symbol : Boolean;
      signal bb_0_bb_1_67_symbol : Boolean;
      signal merge_stmt_41_x_xexit_x_xx_x68_symbol : Boolean;
      signal assign_stmt_47_x_xentry_x_xx_x69_symbol : Boolean;
      signal assign_stmt_47_x_xexit_x_xx_x70_symbol : Boolean;
      signal assign_stmt_50_x_xentry_x_xx_x71_symbol : Boolean;
      signal assign_stmt_50_x_xexit_x_xx_x72_symbol : Boolean;
      signal assign_stmt_56_x_xentry_x_xx_x73_symbol : Boolean;
      signal assign_stmt_56_x_xexit_x_xx_x74_symbol : Boolean;
      signal assign_stmt_59_x_xentry_x_xx_x75_symbol : Boolean;
      signal assign_stmt_59_x_xexit_x_xx_x76_symbol : Boolean;
      signal bb_1_bb_1_77_symbol : Boolean;
      signal assign_stmt_47_78_start : Boolean;
      signal assign_stmt_47_78_symbol : Boolean;
      signal assign_stmt_50_81_start : Boolean;
      signal assign_stmt_50_81_symbol : Boolean;
      signal assign_stmt_56_92_start : Boolean;
      signal assign_stmt_56_92_symbol : Boolean;
      signal assign_stmt_59_95_start : Boolean;
      signal assign_stmt_59_95_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_107_start : Boolean;
      signal bb_0_bb_1_PhiReq_107_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_110_start : Boolean;
      signal bb_1_bb_1_PhiReq_110_symbol : Boolean;
      signal merge_stmt_41_PhiReqMerge_113_symbol : Boolean;
      signal merge_stmt_41_PhiAck_114_start : Boolean;
      signal merge_stmt_41_PhiAck_114_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_39_62_start <= Xentry_60_symbol; -- control passed to block
      Xentry_63_symbol  <= branch_block_stmt_39_62_start; -- transition branch_block_stmt_39/$entry
      branch_block_stmt_39_x_xentry_x_xx_x65_symbol  <=  Xentry_63_symbol; -- place branch_block_stmt_39/branch_block_stmt_39__entry__ (optimized away) 
      branch_block_stmt_39_x_xexit_x_xx_x66_symbol  <=   false ; -- place branch_block_stmt_39/branch_block_stmt_39__exit__ (optimized away) 
      bb_0_bb_1_67_symbol  <=  branch_block_stmt_39_x_xentry_x_xx_x65_symbol; -- place branch_block_stmt_39/bb_0_bb_1 (optimized away) 
      merge_stmt_41_x_xexit_x_xx_x68_symbol  <=  merge_stmt_41_PhiAck_114_symbol; -- place branch_block_stmt_39/merge_stmt_41__exit__ (optimized away) 
      assign_stmt_47_x_xentry_x_xx_x69_symbol  <=  merge_stmt_41_x_xexit_x_xx_x68_symbol; -- place branch_block_stmt_39/assign_stmt_47__entry__ (optimized away) 
      assign_stmt_47_x_xexit_x_xx_x70_symbol  <=  assign_stmt_47_78_symbol; -- place branch_block_stmt_39/assign_stmt_47__exit__ (optimized away) 
      assign_stmt_50_x_xentry_x_xx_x71_symbol  <=  assign_stmt_47_x_xexit_x_xx_x70_symbol; -- place branch_block_stmt_39/assign_stmt_50__entry__ (optimized away) 
      assign_stmt_50_x_xexit_x_xx_x72_symbol  <=  assign_stmt_50_81_symbol; -- place branch_block_stmt_39/assign_stmt_50__exit__ (optimized away) 
      assign_stmt_56_x_xentry_x_xx_x73_symbol  <=  assign_stmt_50_x_xexit_x_xx_x72_symbol; -- place branch_block_stmt_39/assign_stmt_56__entry__ (optimized away) 
      assign_stmt_56_x_xexit_x_xx_x74_symbol  <=  assign_stmt_56_92_symbol; -- place branch_block_stmt_39/assign_stmt_56__exit__ (optimized away) 
      assign_stmt_59_x_xentry_x_xx_x75_symbol  <=  assign_stmt_56_x_xexit_x_xx_x74_symbol; -- place branch_block_stmt_39/assign_stmt_59__entry__ (optimized away) 
      assign_stmt_59_x_xexit_x_xx_x76_symbol  <=  assign_stmt_59_95_symbol; -- place branch_block_stmt_39/assign_stmt_59__exit__ (optimized away) 
      bb_1_bb_1_77_symbol  <=  assign_stmt_59_x_xexit_x_xx_x76_symbol; -- place branch_block_stmt_39/bb_1_bb_1 (optimized away) 
      assign_stmt_47_78: Block -- branch_block_stmt_39/assign_stmt_47 
        signal Xentry_79_symbol: Boolean;
        signal Xexit_80_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_47_78_start <= assign_stmt_47_x_xentry_x_xx_x69_symbol; -- control passed to block
        Xentry_79_symbol  <= assign_stmt_47_78_start; -- transition branch_block_stmt_39/assign_stmt_47/$entry
        Xexit_80_symbol <= Xentry_79_symbol; -- transition branch_block_stmt_39/assign_stmt_47/$exit
        assign_stmt_47_78_symbol <= Xexit_80_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_47
      assign_stmt_50_81: Block -- branch_block_stmt_39/assign_stmt_50 
        signal Xentry_82_symbol: Boolean;
        signal Xexit_83_symbol: Boolean;
        signal assign_stmt_50_active_x_x84_symbol : Boolean;
        signal assign_stmt_50_completed_x_x85_symbol : Boolean;
        signal simple_obj_ref_49_trigger_x_x86_symbol : Boolean;
        signal simple_obj_ref_49_complete_87_start : Boolean;
        signal simple_obj_ref_49_complete_87_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_50_81_start <= assign_stmt_50_x_xentry_x_xx_x71_symbol; -- control passed to block
        Xentry_82_symbol  <= assign_stmt_50_81_start; -- transition branch_block_stmt_39/assign_stmt_50/$entry
        assign_stmt_50_active_x_x84_symbol <= simple_obj_ref_49_complete_87_symbol; -- transition branch_block_stmt_39/assign_stmt_50/assign_stmt_50_active_
        assign_stmt_50_completed_x_x85_symbol <= assign_stmt_50_active_x_x84_symbol; -- transition branch_block_stmt_39/assign_stmt_50/assign_stmt_50_completed_
        simple_obj_ref_49_trigger_x_x86_symbol <= Xentry_82_symbol; -- transition branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_trigger_
        simple_obj_ref_49_complete_87: Block -- branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_complete 
          signal Xentry_88_symbol: Boolean;
          signal Xexit_89_symbol: Boolean;
          signal req_90_symbol : Boolean;
          signal ack_91_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_49_complete_87_start <= simple_obj_ref_49_trigger_x_x86_symbol; -- control passed to block
          Xentry_88_symbol  <= simple_obj_ref_49_complete_87_start; -- transition branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_complete/$entry
          req_90_symbol <= Xentry_88_symbol; -- transition branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_complete/req
          simple_obj_ref_49_inst_req_0 <= req_90_symbol; -- link to DP
          ack_91_symbol <= simple_obj_ref_49_inst_ack_0; -- transition branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_complete/ack
          Xexit_89_symbol <= ack_91_symbol; -- transition branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_complete/$exit
          simple_obj_ref_49_complete_87_symbol <= Xexit_89_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_50/simple_obj_ref_49_complete
        Xexit_83_symbol <= assign_stmt_50_completed_x_x85_symbol; -- transition branch_block_stmt_39/assign_stmt_50/$exit
        assign_stmt_50_81_symbol <= Xexit_83_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_50
      assign_stmt_56_92: Block -- branch_block_stmt_39/assign_stmt_56 
        signal Xentry_93_symbol: Boolean;
        signal Xexit_94_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_56_92_start <= assign_stmt_56_x_xentry_x_xx_x73_symbol; -- control passed to block
        Xentry_93_symbol  <= assign_stmt_56_92_start; -- transition branch_block_stmt_39/assign_stmt_56/$entry
        Xexit_94_symbol <= Xentry_93_symbol; -- transition branch_block_stmt_39/assign_stmt_56/$exit
        assign_stmt_56_92_symbol <= Xexit_94_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_56
      assign_stmt_59_95: Block -- branch_block_stmt_39/assign_stmt_59 
        signal Xentry_96_symbol: Boolean;
        signal Xexit_97_symbol: Boolean;
        signal assign_stmt_59_active_x_x98_symbol : Boolean;
        signal assign_stmt_59_completed_x_x99_symbol : Boolean;
        signal simple_obj_ref_58_complete_100_symbol : Boolean;
        signal simple_obj_ref_57_trigger_x_x101_symbol : Boolean;
        signal simple_obj_ref_57_complete_102_start : Boolean;
        signal simple_obj_ref_57_complete_102_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_59_95_start <= assign_stmt_59_x_xentry_x_xx_x75_symbol; -- control passed to block
        Xentry_96_symbol  <= assign_stmt_59_95_start; -- transition branch_block_stmt_39/assign_stmt_59/$entry
        assign_stmt_59_active_x_x98_symbol <= simple_obj_ref_58_complete_100_symbol; -- transition branch_block_stmt_39/assign_stmt_59/assign_stmt_59_active_
        assign_stmt_59_completed_x_x99_symbol <= simple_obj_ref_57_complete_102_symbol; -- transition branch_block_stmt_39/assign_stmt_59/assign_stmt_59_completed_
        simple_obj_ref_58_complete_100_symbol <= Xentry_96_symbol; -- transition branch_block_stmt_39/assign_stmt_59/simple_obj_ref_58_complete
        simple_obj_ref_57_trigger_x_x101_symbol <= assign_stmt_59_active_x_x98_symbol; -- transition branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_trigger_
        simple_obj_ref_57_complete_102: Block -- branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_complete 
          signal Xentry_103_symbol: Boolean;
          signal Xexit_104_symbol: Boolean;
          signal pipe_wreq_105_symbol : Boolean;
          signal pipe_wack_106_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_57_complete_102_start <= simple_obj_ref_57_trigger_x_x101_symbol; -- control passed to block
          Xentry_103_symbol  <= simple_obj_ref_57_complete_102_start; -- transition branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_complete/$entry
          pipe_wreq_105_symbol <= Xentry_103_symbol; -- transition branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_complete/pipe_wreq
          simple_obj_ref_57_inst_req_0 <= pipe_wreq_105_symbol; -- link to DP
          pipe_wack_106_symbol <= simple_obj_ref_57_inst_ack_0; -- transition branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_complete/pipe_wack
          Xexit_104_symbol <= pipe_wack_106_symbol; -- transition branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_complete/$exit
          simple_obj_ref_57_complete_102_symbol <= Xexit_104_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_59/simple_obj_ref_57_complete
        Xexit_97_symbol <= assign_stmt_59_completed_x_x99_symbol; -- transition branch_block_stmt_39/assign_stmt_59/$exit
        assign_stmt_59_95_symbol <= Xexit_97_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_59
      bb_0_bb_1_PhiReq_107: Block -- branch_block_stmt_39/bb_0_bb_1_PhiReq 
        signal Xentry_108_symbol: Boolean;
        signal Xexit_109_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_107_start <= bb_0_bb_1_67_symbol; -- control passed to block
        Xentry_108_symbol  <= bb_0_bb_1_PhiReq_107_start; -- transition branch_block_stmt_39/bb_0_bb_1_PhiReq/$entry
        Xexit_109_symbol <= Xentry_108_symbol; -- transition branch_block_stmt_39/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_107_symbol <= Xexit_109_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_110: Block -- branch_block_stmt_39/bb_1_bb_1_PhiReq 
        signal Xentry_111_symbol: Boolean;
        signal Xexit_112_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_110_start <= bb_1_bb_1_77_symbol; -- control passed to block
        Xentry_111_symbol  <= bb_1_bb_1_PhiReq_110_start; -- transition branch_block_stmt_39/bb_1_bb_1_PhiReq/$entry
        Xexit_112_symbol <= Xentry_111_symbol; -- transition branch_block_stmt_39/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_110_symbol <= Xexit_112_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/bb_1_bb_1_PhiReq
      merge_stmt_41_PhiReqMerge_113_symbol  <=  bb_0_bb_1_PhiReq_107_symbol or bb_1_bb_1_PhiReq_110_symbol; -- place branch_block_stmt_39/merge_stmt_41_PhiReqMerge (optimized away) 
      merge_stmt_41_PhiAck_114: Block -- branch_block_stmt_39/merge_stmt_41_PhiAck 
        signal Xentry_115_symbol: Boolean;
        signal Xexit_116_symbol: Boolean;
        signal dummy_117_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_41_PhiAck_114_start <= merge_stmt_41_PhiReqMerge_113_symbol; -- control passed to block
        Xentry_115_symbol  <= merge_stmt_41_PhiAck_114_start; -- transition branch_block_stmt_39/merge_stmt_41_PhiAck/$entry
        dummy_117_symbol <= Xentry_115_symbol; -- transition branch_block_stmt_39/merge_stmt_41_PhiAck/dummy
        Xexit_116_symbol <= dummy_117_symbol; -- transition branch_block_stmt_39/merge_stmt_41_PhiAck/$exit
        merge_stmt_41_PhiAck_114_symbol <= Xexit_116_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/merge_stmt_41_PhiAck
      Xexit_64_symbol <= branch_block_stmt_39_x_xexit_x_xx_x66_symbol; -- transition branch_block_stmt_39/$exit
      branch_block_stmt_39_62_symbol <= Xexit_64_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_39
    Xexit_61_symbol <= branch_block_stmt_39_62_symbol; -- transition $exit
    fin_ack_symbol_join : Block -- non-trivial join transition fin_ack_symbol 
      signal fin_ack_symbol_predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      fin_ack_symbol_predecessors <= Xexit_61_symbol & fin_req_symbol;
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
    signal iNsTr_1_47 : std_logic_vector(31 downto 0);
    signal iNsTr_2_50 : std_logic_vector(63 downto 0);
    signal iNsTr_3_56 : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    iNsTr_1_47 <= "00000000000000000000000000000000";
    iNsTr_3_56 <= "00000000000000000000000000000000";
    -- shared inport operator group (0) : simple_obj_ref_49_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_49_inst_req_0;
      simple_obj_ref_49_inst_ack_0 <= ack(0);
      iNsTr_2_50 <= data_out(63 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_57_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_57_inst_req_0;
      simple_obj_ref_57_inst_ack_0 <= ack(0);
      data_in <= iNsTr_2_50;
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
      out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module ctrl_module
  signal ctrl_module_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal ctrl_module_tag_out   : std_logic_vector(0 downto 0);
  signal ctrl_module_start_req : std_logic;
  signal ctrl_module_start_ack : std_logic;
  signal ctrl_module_fin_req   : std_logic;
  signal ctrl_module_fin_ack : std_logic;
  -- declarations related to module data_module
  component data_module is -- 
    generic (tag_length : integer); 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- argument signals for module data_module
  signal data_module_tag_in    : std_logic_vector(0 downto 0) := (others => '0');
  signal data_module_tag_out   : std_logic_vector(0 downto 0);
  signal data_module_start_req : std_logic;
  signal data_module_start_ack : std_logic;
  signal data_module_fin_req   : std_logic;
  signal data_module_fin_ack : std_logic;
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
    generic map(tag_length => 1)
    port map(-- 
      start_req => ctrl_module_start_req,
      start_ack => ctrl_module_start_ack,
      fin_req => ctrl_module_fin_req,
      fin_ack => ctrl_module_fin_ack,
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
  ctrl_module_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => ctrl_module_start_req, start_ack => ctrl_module_start_ack,  fin_req => ctrl_module_fin_req,  fin_ack => ctrl_module_fin_ack);
  -- module data_module
  data_module_instance:data_module-- 
    generic map(tag_length => 1)
    port map(-- 
      start_req => data_module_start_req,
      start_ack => data_module_start_ack,
      fin_req => data_module_fin_req,
      fin_ack => data_module_fin_ack,
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
  data_module_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start_req => data_module_start_req, start_ack => data_module_start_ack,  fin_req => data_module_fin_req,  fin_ack => data_module_fin_ack);
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
