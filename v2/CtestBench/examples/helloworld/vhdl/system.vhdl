-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant mempool_base_address : std_logic_vector(0 downto 0) := "0";
  constant xx_xstr1_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr2_base_address : std_logic_vector(6 downto 0) := "0000000";
  constant xx_xstr_base_address : std_logic_vector(5 downto 0) := "000000";
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
entity bar is -- 
  generic (tag_length : integer); 
  port ( -- 
    a : in  std_logic_vector(31 downto 0);
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    midpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
    midpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
    midpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
    outpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    outpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    outpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity bar;
architecture Default of bar is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal ret_val_x_x_buffer :  std_logic_vector(31 downto 0);
  signal bar_CP_0_start: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_55_inst_req_0 : boolean;
  signal simple_obj_ref_55_inst_ack_0 : boolean;
  signal ptr_deref_58_store_0_req_0 : boolean;
  signal ptr_deref_58_store_0_ack_0 : boolean;
  signal ptr_deref_51_gather_scatter_req_0 : boolean;
  signal ptr_deref_51_gather_scatter_ack_0 : boolean;
  signal ptr_deref_51_store_0_req_0 : boolean;
  signal ptr_deref_51_store_0_ack_0 : boolean;
  signal ptr_deref_51_store_0_req_1 : boolean;
  signal ptr_deref_51_store_0_ack_1 : boolean;
  signal ptr_deref_58_gather_scatter_req_0 : boolean;
  signal ptr_deref_58_gather_scatter_ack_0 : boolean;
  signal ptr_deref_79_load_0_req_0 : boolean;
  signal ptr_deref_79_load_0_ack_0 : boolean;
  signal ptr_deref_58_store_0_req_1 : boolean;
  signal ptr_deref_58_store_0_ack_1 : boolean;
  signal ptr_deref_63_load_0_req_0 : boolean;
  signal ptr_deref_63_load_0_ack_0 : boolean;
  signal ptr_deref_63_load_0_req_1 : boolean;
  signal ptr_deref_63_load_0_ack_1 : boolean;
  signal ptr_deref_63_gather_scatter_req_0 : boolean;
  signal ptr_deref_63_gather_scatter_ack_0 : boolean;
  signal ptr_deref_67_load_0_req_0 : boolean;
  signal ptr_deref_67_load_0_ack_0 : boolean;
  signal ptr_deref_67_load_0_req_1 : boolean;
  signal ptr_deref_67_load_0_ack_1 : boolean;
  signal ptr_deref_67_gather_scatter_req_0 : boolean;
  signal ptr_deref_67_gather_scatter_ack_0 : boolean;
  signal binary_72_inst_req_0 : boolean;
  signal binary_72_inst_ack_0 : boolean;
  signal binary_72_inst_req_1 : boolean;
  signal binary_72_inst_ack_1 : boolean;
  signal simple_obj_ref_74_inst_req_0 : boolean;
  signal simple_obj_ref_74_inst_ack_0 : boolean;
  signal ptr_deref_79_load_0_req_1 : boolean;
  signal ptr_deref_79_load_0_ack_1 : boolean;
  signal ptr_deref_79_gather_scatter_req_0 : boolean;
  signal ptr_deref_79_gather_scatter_ack_0 : boolean;
  signal memory_space_4_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_4_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_4_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_4_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_4_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_4_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_4_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_4_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_4_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_4_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_4_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_4_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_4_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_4_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_4_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_4_sc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_5_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_5_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_5_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_5_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_5_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_5_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_5_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_5_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_5_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_5_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_5_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_5_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_5_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_5_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_5_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_5_sc_tag :  std_logic_vector(0 downto 0);
  -- 
begin --  
  -- output port buffering assignments
  ret_val_x_x <= ret_val_x_x_buffer; 
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
  bar_CP_0: Block -- control-path 
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_39_3_start : Boolean;
    signal branch_block_stmt_39_3_symbol : Boolean;
    -- 
  begin -- 
    bar_CP_0_start_interlock : pipeline_interlock -- 
      port map (trigger => start_req_symbol,
      enable =>  fin_ack_symbol, 
      symbol_out => bar_CP_0_start, 
      clk => clk, reset => reset); -- 
    start_ack_symbol <= Xexit_2_symbol;
    Xentry_1_symbol  <= bar_CP_0_start; -- transition $entry
    branch_block_stmt_39_3: Block -- branch_block_stmt_39 
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_39_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_39_x_xexit_x_xx_x7_symbol : Boolean;
      signal assign_stmt_45_to_assign_stmt_53_x_xentry_x_xx_x8_symbol : Boolean;
      signal assign_stmt_45_to_assign_stmt_53_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_56_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_56_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_60_to_assign_stmt_73_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_60_to_assign_stmt_73_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_76_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_76_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_80_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_80_x_xexit_x_xx_x17_symbol : Boolean;
      signal return_x_xx_x18_symbol : Boolean;
      signal merge_stmt_82_x_xexit_x_xx_x19_symbol : Boolean;
      signal assign_stmt_45_to_assign_stmt_53_20_start : Boolean;
      signal assign_stmt_45_to_assign_stmt_53_20_symbol : Boolean;
      signal assign_stmt_56_55_start : Boolean;
      signal assign_stmt_56_55_symbol : Boolean;
      signal assign_stmt_60_to_assign_stmt_73_66_start : Boolean;
      signal assign_stmt_60_to_assign_stmt_73_66_symbol : Boolean;
      signal assign_stmt_76_176_start : Boolean;
      signal assign_stmt_76_176_symbol : Boolean;
      signal assign_stmt_80_188_start : Boolean;
      signal assign_stmt_80_188_symbol : Boolean;
      signal return_x_xx_xPhiReq_222_start : Boolean;
      signal return_x_xx_xPhiReq_222_symbol : Boolean;
      signal merge_stmt_82_PhiReqMerge_225_symbol : Boolean;
      signal merge_stmt_82_PhiAck_226_start : Boolean;
      signal merge_stmt_82_PhiAck_226_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_39_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_39_3_start; -- transition branch_block_stmt_39/$entry
      branch_block_stmt_39_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_39/branch_block_stmt_39__entry__ (optimized away) 
      branch_block_stmt_39_x_xexit_x_xx_x7_symbol  <=  merge_stmt_82_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_39/branch_block_stmt_39__exit__ (optimized away) 
      assign_stmt_45_to_assign_stmt_53_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_39_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53__entry__ (optimized away) 
      assign_stmt_45_to_assign_stmt_53_x_xexit_x_xx_x9_symbol  <=  assign_stmt_45_to_assign_stmt_53_20_symbol; -- place branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53__exit__ (optimized away) 
      assign_stmt_56_x_xentry_x_xx_x10_symbol  <=  assign_stmt_45_to_assign_stmt_53_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_39/assign_stmt_56__entry__ (optimized away) 
      assign_stmt_56_x_xexit_x_xx_x11_symbol  <=  assign_stmt_56_55_symbol; -- place branch_block_stmt_39/assign_stmt_56__exit__ (optimized away) 
      assign_stmt_60_to_assign_stmt_73_x_xentry_x_xx_x12_symbol  <=  assign_stmt_56_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73__entry__ (optimized away) 
      assign_stmt_60_to_assign_stmt_73_x_xexit_x_xx_x13_symbol  <=  assign_stmt_60_to_assign_stmt_73_66_symbol; -- place branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73__exit__ (optimized away) 
      assign_stmt_76_x_xentry_x_xx_x14_symbol  <=  assign_stmt_60_to_assign_stmt_73_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_39/assign_stmt_76__entry__ (optimized away) 
      assign_stmt_76_x_xexit_x_xx_x15_symbol  <=  assign_stmt_76_176_symbol; -- place branch_block_stmt_39/assign_stmt_76__exit__ (optimized away) 
      assign_stmt_80_x_xentry_x_xx_x16_symbol  <=  assign_stmt_76_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_39/assign_stmt_80__entry__ (optimized away) 
      assign_stmt_80_x_xexit_x_xx_x17_symbol  <=  assign_stmt_80_188_symbol; -- place branch_block_stmt_39/assign_stmt_80__exit__ (optimized away) 
      return_x_xx_x18_symbol  <=  assign_stmt_80_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_39/return__ (optimized away) 
      merge_stmt_82_x_xexit_x_xx_x19_symbol  <=  merge_stmt_82_PhiAck_226_symbol; -- place branch_block_stmt_39/merge_stmt_82__exit__ (optimized away) 
      assign_stmt_45_to_assign_stmt_53_20: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53 
        signal Xentry_21_symbol: Boolean;
        signal Xexit_22_symbol: Boolean;
        signal assign_stmt_53_active_x_x23_symbol : Boolean;
        signal assign_stmt_53_completed_x_x24_symbol : Boolean;
        signal simple_obj_ref_52_complete_25_symbol : Boolean;
        signal ptr_deref_51_trigger_x_x26_symbol : Boolean;
        signal ptr_deref_51_active_x_x27_symbol : Boolean;
        signal ptr_deref_51_base_address_calculated_28_symbol : Boolean;
        signal ptr_deref_51_root_address_calculated_29_symbol : Boolean;
        signal ptr_deref_51_word_address_calculated_30_symbol : Boolean;
        signal ptr_deref_51_request_31_start : Boolean;
        signal ptr_deref_51_request_31_symbol : Boolean;
        signal ptr_deref_51_complete_44_start : Boolean;
        signal ptr_deref_51_complete_44_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_45_to_assign_stmt_53_20_start <= assign_stmt_45_to_assign_stmt_53_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_21_symbol  <= assign_stmt_45_to_assign_stmt_53_20_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/$entry
        assign_stmt_53_active_x_x23_symbol <= simple_obj_ref_52_complete_25_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/assign_stmt_53_active_
        assign_stmt_53_completed_x_x24_symbol <= ptr_deref_51_complete_44_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/assign_stmt_53_completed_
        simple_obj_ref_52_complete_25_symbol <= Xentry_21_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/simple_obj_ref_52_complete
        ptr_deref_51_trigger_x_x26_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_trigger_ 
          signal ptr_deref_51_trigger_x_x26_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_51_trigger_x_x26_predecessors(0) <= ptr_deref_51_word_address_calculated_30_symbol;
          ptr_deref_51_trigger_x_x26_predecessors(1) <= assign_stmt_53_active_x_x23_symbol;
          ptr_deref_51_trigger_x_x26_join: join -- 
            port map( -- 
              preds => ptr_deref_51_trigger_x_x26_predecessors,
              symbol_out => ptr_deref_51_trigger_x_x26_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_trigger_
        ptr_deref_51_active_x_x27_symbol <= ptr_deref_51_request_31_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_active_
        ptr_deref_51_base_address_calculated_28_symbol <= Xentry_21_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_base_address_calculated
        ptr_deref_51_root_address_calculated_29_symbol <= Xentry_21_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_root_address_calculated
        ptr_deref_51_word_address_calculated_30_symbol <= ptr_deref_51_root_address_calculated_29_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_word_address_calculated
        ptr_deref_51_request_31: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request 
          signal Xentry_32_symbol: Boolean;
          signal Xexit_33_symbol: Boolean;
          signal split_req_34_symbol : Boolean;
          signal split_ack_35_symbol : Boolean;
          signal word_access_36_start : Boolean;
          signal word_access_36_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_51_request_31_start <= ptr_deref_51_trigger_x_x26_symbol; -- control passed to block
          Xentry_32_symbol  <= ptr_deref_51_request_31_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/$entry
          split_req_34_symbol <= Xentry_32_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/split_req
          ptr_deref_51_gather_scatter_req_0 <= split_req_34_symbol; -- link to DP
          split_ack_35_symbol <= ptr_deref_51_gather_scatter_ack_0; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/split_ack
          word_access_36: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access 
            signal Xentry_37_symbol: Boolean;
            signal Xexit_38_symbol: Boolean;
            signal word_access_0_39_start : Boolean;
            signal word_access_0_39_symbol : Boolean;
            -- 
          begin -- 
            word_access_36_start <= split_ack_35_symbol; -- control passed to block
            Xentry_37_symbol  <= word_access_36_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/$entry
            word_access_0_39: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/word_access_0 
              signal Xentry_40_symbol: Boolean;
              signal Xexit_41_symbol: Boolean;
              signal rr_42_symbol : Boolean;
              signal ra_43_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_39_start <= Xentry_37_symbol; -- control passed to block
              Xentry_40_symbol  <= word_access_0_39_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/word_access_0/$entry
              rr_42_symbol <= Xentry_40_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/word_access_0/rr
              ptr_deref_51_store_0_req_0 <= rr_42_symbol; -- link to DP
              ra_43_symbol <= ptr_deref_51_store_0_ack_0; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/word_access_0/ra
              Xexit_41_symbol <= ra_43_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/word_access_0/$exit
              word_access_0_39_symbol <= Xexit_41_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/word_access_0
            Xexit_38_symbol <= word_access_0_39_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access/$exit
            word_access_36_symbol <= Xexit_38_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/word_access
          Xexit_33_symbol <= word_access_36_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request/$exit
          ptr_deref_51_request_31_symbol <= Xexit_33_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_request
        ptr_deref_51_complete_44: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete 
          signal Xentry_45_symbol: Boolean;
          signal Xexit_46_symbol: Boolean;
          signal word_access_47_start : Boolean;
          signal word_access_47_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_51_complete_44_start <= ptr_deref_51_active_x_x27_symbol; -- control passed to block
          Xentry_45_symbol  <= ptr_deref_51_complete_44_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/$entry
          word_access_47: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access 
            signal Xentry_48_symbol: Boolean;
            signal Xexit_49_symbol: Boolean;
            signal word_access_0_50_start : Boolean;
            signal word_access_0_50_symbol : Boolean;
            -- 
          begin -- 
            word_access_47_start <= Xentry_45_symbol; -- control passed to block
            Xentry_48_symbol  <= word_access_47_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/$entry
            word_access_0_50: Block -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/word_access_0 
              signal Xentry_51_symbol: Boolean;
              signal Xexit_52_symbol: Boolean;
              signal cr_53_symbol : Boolean;
              signal ca_54_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_50_start <= Xentry_48_symbol; -- control passed to block
              Xentry_51_symbol  <= word_access_0_50_start; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/word_access_0/$entry
              cr_53_symbol <= Xentry_51_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/word_access_0/cr
              ptr_deref_51_store_0_req_1 <= cr_53_symbol; -- link to DP
              ca_54_symbol <= ptr_deref_51_store_0_ack_1; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/word_access_0/ca
              Xexit_52_symbol <= ca_54_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/word_access_0/$exit
              word_access_0_50_symbol <= Xexit_52_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/word_access_0
            Xexit_49_symbol <= word_access_0_50_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access/$exit
            word_access_47_symbol <= Xexit_49_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/word_access
          Xexit_46_symbol <= word_access_47_symbol; -- transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete/$exit
          ptr_deref_51_complete_44_symbol <= Xexit_46_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/ptr_deref_51_complete
        Xexit_22_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/$exit 
          signal Xexit_22_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_22_predecessors(0) <= assign_stmt_53_completed_x_x24_symbol;
          Xexit_22_predecessors(1) <= ptr_deref_51_base_address_calculated_28_symbol;
          Xexit_22_join: join -- 
            port map( -- 
              preds => Xexit_22_predecessors,
              symbol_out => Xexit_22_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53/$exit
        assign_stmt_45_to_assign_stmt_53_20_symbol <= Xexit_22_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_45_to_assign_stmt_53
      assign_stmt_56_55: Block -- branch_block_stmt_39/assign_stmt_56 
        signal Xentry_56_symbol: Boolean;
        signal Xexit_57_symbol: Boolean;
        signal assign_stmt_56_active_x_x58_symbol : Boolean;
        signal assign_stmt_56_completed_x_x59_symbol : Boolean;
        signal simple_obj_ref_55_trigger_x_x60_symbol : Boolean;
        signal simple_obj_ref_55_complete_61_start : Boolean;
        signal simple_obj_ref_55_complete_61_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_56_55_start <= assign_stmt_56_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_56_symbol  <= assign_stmt_56_55_start; -- transition branch_block_stmt_39/assign_stmt_56/$entry
        assign_stmt_56_active_x_x58_symbol <= simple_obj_ref_55_complete_61_symbol; -- transition branch_block_stmt_39/assign_stmt_56/assign_stmt_56_active_
        assign_stmt_56_completed_x_x59_symbol <= assign_stmt_56_active_x_x58_symbol; -- transition branch_block_stmt_39/assign_stmt_56/assign_stmt_56_completed_
        simple_obj_ref_55_trigger_x_x60_symbol <= Xentry_56_symbol; -- transition branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_trigger_
        simple_obj_ref_55_complete_61: Block -- branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_complete 
          signal Xentry_62_symbol: Boolean;
          signal Xexit_63_symbol: Boolean;
          signal req_64_symbol : Boolean;
          signal ack_65_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_55_complete_61_start <= simple_obj_ref_55_trigger_x_x60_symbol; -- control passed to block
          Xentry_62_symbol  <= simple_obj_ref_55_complete_61_start; -- transition branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_complete/$entry
          req_64_symbol <= Xentry_62_symbol; -- transition branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_complete/req
          simple_obj_ref_55_inst_req_0 <= req_64_symbol; -- link to DP
          ack_65_symbol <= simple_obj_ref_55_inst_ack_0; -- transition branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_complete/ack
          Xexit_63_symbol <= ack_65_symbol; -- transition branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_complete/$exit
          simple_obj_ref_55_complete_61_symbol <= Xexit_63_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_56/simple_obj_ref_55_complete
        Xexit_57_symbol <= assign_stmt_56_completed_x_x59_symbol; -- transition branch_block_stmt_39/assign_stmt_56/$exit
        assign_stmt_56_55_symbol <= Xexit_57_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_56
      assign_stmt_60_to_assign_stmt_73_66: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73 
        signal Xentry_67_symbol: Boolean;
        signal Xexit_68_symbol: Boolean;
        signal assign_stmt_60_active_x_x69_symbol : Boolean;
        signal assign_stmt_60_completed_x_x70_symbol : Boolean;
        signal simple_obj_ref_59_complete_71_symbol : Boolean;
        signal ptr_deref_58_trigger_x_x72_symbol : Boolean;
        signal ptr_deref_58_active_x_x73_symbol : Boolean;
        signal ptr_deref_58_base_address_calculated_74_symbol : Boolean;
        signal ptr_deref_58_root_address_calculated_75_symbol : Boolean;
        signal ptr_deref_58_word_address_calculated_76_symbol : Boolean;
        signal ptr_deref_58_request_77_start : Boolean;
        signal ptr_deref_58_request_77_symbol : Boolean;
        signal ptr_deref_58_complete_90_start : Boolean;
        signal ptr_deref_58_complete_90_symbol : Boolean;
        signal assign_stmt_64_active_x_x101_symbol : Boolean;
        signal assign_stmt_64_completed_x_x102_symbol : Boolean;
        signal ptr_deref_63_trigger_x_x103_symbol : Boolean;
        signal ptr_deref_63_active_x_x104_symbol : Boolean;
        signal ptr_deref_63_base_address_calculated_105_symbol : Boolean;
        signal ptr_deref_63_root_address_calculated_106_symbol : Boolean;
        signal ptr_deref_63_word_address_calculated_107_symbol : Boolean;
        signal ptr_deref_63_request_108_start : Boolean;
        signal ptr_deref_63_request_108_symbol : Boolean;
        signal ptr_deref_63_complete_119_start : Boolean;
        signal ptr_deref_63_complete_119_symbol : Boolean;
        signal assign_stmt_68_active_x_x132_symbol : Boolean;
        signal assign_stmt_68_completed_x_x133_symbol : Boolean;
        signal ptr_deref_67_trigger_x_x134_symbol : Boolean;
        signal ptr_deref_67_active_x_x135_symbol : Boolean;
        signal ptr_deref_67_base_address_calculated_136_symbol : Boolean;
        signal ptr_deref_67_root_address_calculated_137_symbol : Boolean;
        signal ptr_deref_67_word_address_calculated_138_symbol : Boolean;
        signal ptr_deref_67_request_139_start : Boolean;
        signal ptr_deref_67_request_139_symbol : Boolean;
        signal ptr_deref_67_complete_150_start : Boolean;
        signal ptr_deref_67_complete_150_symbol : Boolean;
        signal assign_stmt_73_active_x_x163_symbol : Boolean;
        signal assign_stmt_73_completed_x_x164_symbol : Boolean;
        signal binary_72_active_x_x165_symbol : Boolean;
        signal binary_72_trigger_x_x166_symbol : Boolean;
        signal simple_obj_ref_70_complete_167_symbol : Boolean;
        signal simple_obj_ref_71_complete_168_symbol : Boolean;
        signal binary_72_complete_169_start : Boolean;
        signal binary_72_complete_169_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_60_to_assign_stmt_73_66_start <= assign_stmt_60_to_assign_stmt_73_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_67_symbol  <= assign_stmt_60_to_assign_stmt_73_66_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/$entry
        assign_stmt_60_active_x_x69_symbol <= simple_obj_ref_59_complete_71_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_60_active_
        assign_stmt_60_completed_x_x70_symbol <= ptr_deref_58_complete_90_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_60_completed_
        simple_obj_ref_59_complete_71_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/simple_obj_ref_59_complete
        ptr_deref_58_trigger_x_x72_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_trigger_ 
          signal ptr_deref_58_trigger_x_x72_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_58_trigger_x_x72_predecessors(0) <= ptr_deref_58_word_address_calculated_76_symbol;
          ptr_deref_58_trigger_x_x72_predecessors(1) <= assign_stmt_60_active_x_x69_symbol;
          ptr_deref_58_trigger_x_x72_join: join -- 
            port map( -- 
              preds => ptr_deref_58_trigger_x_x72_predecessors,
              symbol_out => ptr_deref_58_trigger_x_x72_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_trigger_
        ptr_deref_58_active_x_x73_symbol <= ptr_deref_58_request_77_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_active_
        ptr_deref_58_base_address_calculated_74_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_base_address_calculated
        ptr_deref_58_root_address_calculated_75_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_root_address_calculated
        ptr_deref_58_word_address_calculated_76_symbol <= ptr_deref_58_root_address_calculated_75_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_word_address_calculated
        ptr_deref_58_request_77: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request 
          signal Xentry_78_symbol: Boolean;
          signal Xexit_79_symbol: Boolean;
          signal split_req_80_symbol : Boolean;
          signal split_ack_81_symbol : Boolean;
          signal word_access_82_start : Boolean;
          signal word_access_82_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_58_request_77_start <= ptr_deref_58_trigger_x_x72_symbol; -- control passed to block
          Xentry_78_symbol  <= ptr_deref_58_request_77_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/$entry
          split_req_80_symbol <= Xentry_78_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/split_req
          ptr_deref_58_gather_scatter_req_0 <= split_req_80_symbol; -- link to DP
          split_ack_81_symbol <= ptr_deref_58_gather_scatter_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/split_ack
          word_access_82: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access 
            signal Xentry_83_symbol: Boolean;
            signal Xexit_84_symbol: Boolean;
            signal word_access_0_85_start : Boolean;
            signal word_access_0_85_symbol : Boolean;
            -- 
          begin -- 
            word_access_82_start <= split_ack_81_symbol; -- control passed to block
            Xentry_83_symbol  <= word_access_82_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/$entry
            word_access_0_85: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/word_access_0 
              signal Xentry_86_symbol: Boolean;
              signal Xexit_87_symbol: Boolean;
              signal rr_88_symbol : Boolean;
              signal ra_89_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_85_start <= Xentry_83_symbol; -- control passed to block
              Xentry_86_symbol  <= word_access_0_85_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/word_access_0/$entry
              rr_88_symbol <= Xentry_86_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/word_access_0/rr
              ptr_deref_58_store_0_req_0 <= rr_88_symbol; -- link to DP
              ra_89_symbol <= ptr_deref_58_store_0_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/word_access_0/ra
              Xexit_87_symbol <= ra_89_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/word_access_0/$exit
              word_access_0_85_symbol <= Xexit_87_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/word_access_0
            Xexit_84_symbol <= word_access_0_85_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access/$exit
            word_access_82_symbol <= Xexit_84_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/word_access
          Xexit_79_symbol <= word_access_82_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request/$exit
          ptr_deref_58_request_77_symbol <= Xexit_79_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_request
        ptr_deref_58_complete_90: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete 
          signal Xentry_91_symbol: Boolean;
          signal Xexit_92_symbol: Boolean;
          signal word_access_93_start : Boolean;
          signal word_access_93_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_58_complete_90_start <= ptr_deref_58_active_x_x73_symbol; -- control passed to block
          Xentry_91_symbol  <= ptr_deref_58_complete_90_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/$entry
          word_access_93: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access 
            signal Xentry_94_symbol: Boolean;
            signal Xexit_95_symbol: Boolean;
            signal word_access_0_96_start : Boolean;
            signal word_access_0_96_symbol : Boolean;
            -- 
          begin -- 
            word_access_93_start <= Xentry_91_symbol; -- control passed to block
            Xentry_94_symbol  <= word_access_93_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/$entry
            word_access_0_96: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/word_access_0 
              signal Xentry_97_symbol: Boolean;
              signal Xexit_98_symbol: Boolean;
              signal cr_99_symbol : Boolean;
              signal ca_100_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_96_start <= Xentry_94_symbol; -- control passed to block
              Xentry_97_symbol  <= word_access_0_96_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/word_access_0/$entry
              cr_99_symbol <= Xentry_97_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/word_access_0/cr
              ptr_deref_58_store_0_req_1 <= cr_99_symbol; -- link to DP
              ca_100_symbol <= ptr_deref_58_store_0_ack_1; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/word_access_0/ca
              Xexit_98_symbol <= ca_100_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/word_access_0/$exit
              word_access_0_96_symbol <= Xexit_98_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/word_access_0
            Xexit_95_symbol <= word_access_0_96_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access/$exit
            word_access_93_symbol <= Xexit_95_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/word_access
          Xexit_92_symbol <= word_access_93_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete/$exit
          ptr_deref_58_complete_90_symbol <= Xexit_92_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_58_complete
        assign_stmt_64_active_x_x101_symbol <= ptr_deref_63_complete_119_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_64_active_
        assign_stmt_64_completed_x_x102_symbol <= assign_stmt_64_active_x_x101_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_64_completed_
        ptr_deref_63_trigger_x_x103_symbol <= ptr_deref_63_word_address_calculated_107_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_trigger_
        ptr_deref_63_active_x_x104_symbol <= ptr_deref_63_request_108_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_active_
        ptr_deref_63_base_address_calculated_105_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_base_address_calculated
        ptr_deref_63_root_address_calculated_106_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_root_address_calculated
        ptr_deref_63_word_address_calculated_107_symbol <= ptr_deref_63_root_address_calculated_106_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_word_address_calculated
        ptr_deref_63_request_108: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request 
          signal Xentry_109_symbol: Boolean;
          signal Xexit_110_symbol: Boolean;
          signal word_access_111_start : Boolean;
          signal word_access_111_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_63_request_108_start <= ptr_deref_63_trigger_x_x103_symbol; -- control passed to block
          Xentry_109_symbol  <= ptr_deref_63_request_108_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/$entry
          word_access_111: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access 
            signal Xentry_112_symbol: Boolean;
            signal Xexit_113_symbol: Boolean;
            signal word_access_0_114_start : Boolean;
            signal word_access_0_114_symbol : Boolean;
            -- 
          begin -- 
            word_access_111_start <= Xentry_109_symbol; -- control passed to block
            Xentry_112_symbol  <= word_access_111_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/$entry
            word_access_0_114: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/word_access_0 
              signal Xentry_115_symbol: Boolean;
              signal Xexit_116_symbol: Boolean;
              signal rr_117_symbol : Boolean;
              signal ra_118_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_114_start <= Xentry_112_symbol; -- control passed to block
              Xentry_115_symbol  <= word_access_0_114_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/word_access_0/$entry
              rr_117_symbol <= Xentry_115_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/word_access_0/rr
              ptr_deref_63_load_0_req_0 <= rr_117_symbol; -- link to DP
              ra_118_symbol <= ptr_deref_63_load_0_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/word_access_0/ra
              Xexit_116_symbol <= ra_118_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/word_access_0/$exit
              word_access_0_114_symbol <= Xexit_116_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/word_access_0
            Xexit_113_symbol <= word_access_0_114_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access/$exit
            word_access_111_symbol <= Xexit_113_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/word_access
          Xexit_110_symbol <= word_access_111_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request/$exit
          ptr_deref_63_request_108_symbol <= Xexit_110_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_request
        ptr_deref_63_complete_119: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete 
          signal Xentry_120_symbol: Boolean;
          signal Xexit_121_symbol: Boolean;
          signal word_access_122_start : Boolean;
          signal word_access_122_symbol : Boolean;
          signal merge_req_130_symbol : Boolean;
          signal merge_ack_131_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_63_complete_119_start <= ptr_deref_63_active_x_x104_symbol; -- control passed to block
          Xentry_120_symbol  <= ptr_deref_63_complete_119_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/$entry
          word_access_122: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access 
            signal Xentry_123_symbol: Boolean;
            signal Xexit_124_symbol: Boolean;
            signal word_access_0_125_start : Boolean;
            signal word_access_0_125_symbol : Boolean;
            -- 
          begin -- 
            word_access_122_start <= Xentry_120_symbol; -- control passed to block
            Xentry_123_symbol  <= word_access_122_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/$entry
            word_access_0_125: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/word_access_0 
              signal Xentry_126_symbol: Boolean;
              signal Xexit_127_symbol: Boolean;
              signal cr_128_symbol : Boolean;
              signal ca_129_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_125_start <= Xentry_123_symbol; -- control passed to block
              Xentry_126_symbol  <= word_access_0_125_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/word_access_0/$entry
              cr_128_symbol <= Xentry_126_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/word_access_0/cr
              ptr_deref_63_load_0_req_1 <= cr_128_symbol; -- link to DP
              ca_129_symbol <= ptr_deref_63_load_0_ack_1; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/word_access_0/ca
              Xexit_127_symbol <= ca_129_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/word_access_0/$exit
              word_access_0_125_symbol <= Xexit_127_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/word_access_0
            Xexit_124_symbol <= word_access_0_125_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access/$exit
            word_access_122_symbol <= Xexit_124_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/word_access
          merge_req_130_symbol <= word_access_122_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/merge_req
          ptr_deref_63_gather_scatter_req_0 <= merge_req_130_symbol; -- link to DP
          merge_ack_131_symbol <= ptr_deref_63_gather_scatter_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/merge_ack
          Xexit_121_symbol <= merge_ack_131_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete/$exit
          ptr_deref_63_complete_119_symbol <= Xexit_121_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_63_complete
        assign_stmt_68_active_x_x132_symbol <= ptr_deref_67_complete_150_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_68_active_
        assign_stmt_68_completed_x_x133_symbol <= assign_stmt_68_active_x_x132_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_68_completed_
        ptr_deref_67_trigger_x_x134_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_trigger_ 
          signal ptr_deref_67_trigger_x_x134_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_67_trigger_x_x134_predecessors(0) <= ptr_deref_67_word_address_calculated_138_symbol;
          ptr_deref_67_trigger_x_x134_predecessors(1) <= ptr_deref_58_active_x_x73_symbol;
          ptr_deref_67_trigger_x_x134_join: join -- 
            port map( -- 
              preds => ptr_deref_67_trigger_x_x134_predecessors,
              symbol_out => ptr_deref_67_trigger_x_x134_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_trigger_
        ptr_deref_67_active_x_x135_symbol <= ptr_deref_67_request_139_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_active_
        ptr_deref_67_base_address_calculated_136_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_base_address_calculated
        ptr_deref_67_root_address_calculated_137_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_root_address_calculated
        ptr_deref_67_word_address_calculated_138_symbol <= ptr_deref_67_root_address_calculated_137_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_word_address_calculated
        ptr_deref_67_request_139: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request 
          signal Xentry_140_symbol: Boolean;
          signal Xexit_141_symbol: Boolean;
          signal word_access_142_start : Boolean;
          signal word_access_142_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_67_request_139_start <= ptr_deref_67_trigger_x_x134_symbol; -- control passed to block
          Xentry_140_symbol  <= ptr_deref_67_request_139_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/$entry
          word_access_142: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access 
            signal Xentry_143_symbol: Boolean;
            signal Xexit_144_symbol: Boolean;
            signal word_access_0_145_start : Boolean;
            signal word_access_0_145_symbol : Boolean;
            -- 
          begin -- 
            word_access_142_start <= Xentry_140_symbol; -- control passed to block
            Xentry_143_symbol  <= word_access_142_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/$entry
            word_access_0_145: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/word_access_0 
              signal Xentry_146_symbol: Boolean;
              signal Xexit_147_symbol: Boolean;
              signal rr_148_symbol : Boolean;
              signal ra_149_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_145_start <= Xentry_143_symbol; -- control passed to block
              Xentry_146_symbol  <= word_access_0_145_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/word_access_0/$entry
              rr_148_symbol <= Xentry_146_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/word_access_0/rr
              ptr_deref_67_load_0_req_0 <= rr_148_symbol; -- link to DP
              ra_149_symbol <= ptr_deref_67_load_0_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/word_access_0/ra
              Xexit_147_symbol <= ra_149_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/word_access_0/$exit
              word_access_0_145_symbol <= Xexit_147_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/word_access_0
            Xexit_144_symbol <= word_access_0_145_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access/$exit
            word_access_142_symbol <= Xexit_144_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/word_access
          Xexit_141_symbol <= word_access_142_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request/$exit
          ptr_deref_67_request_139_symbol <= Xexit_141_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_request
        ptr_deref_67_complete_150: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete 
          signal Xentry_151_symbol: Boolean;
          signal Xexit_152_symbol: Boolean;
          signal word_access_153_start : Boolean;
          signal word_access_153_symbol : Boolean;
          signal merge_req_161_symbol : Boolean;
          signal merge_ack_162_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_67_complete_150_start <= ptr_deref_67_active_x_x135_symbol; -- control passed to block
          Xentry_151_symbol  <= ptr_deref_67_complete_150_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/$entry
          word_access_153: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access 
            signal Xentry_154_symbol: Boolean;
            signal Xexit_155_symbol: Boolean;
            signal word_access_0_156_start : Boolean;
            signal word_access_0_156_symbol : Boolean;
            -- 
          begin -- 
            word_access_153_start <= Xentry_151_symbol; -- control passed to block
            Xentry_154_symbol  <= word_access_153_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/$entry
            word_access_0_156: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/word_access_0 
              signal Xentry_157_symbol: Boolean;
              signal Xexit_158_symbol: Boolean;
              signal cr_159_symbol : Boolean;
              signal ca_160_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_156_start <= Xentry_154_symbol; -- control passed to block
              Xentry_157_symbol  <= word_access_0_156_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/word_access_0/$entry
              cr_159_symbol <= Xentry_157_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/word_access_0/cr
              ptr_deref_67_load_0_req_1 <= cr_159_symbol; -- link to DP
              ca_160_symbol <= ptr_deref_67_load_0_ack_1; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/word_access_0/ca
              Xexit_158_symbol <= ca_160_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/word_access_0/$exit
              word_access_0_156_symbol <= Xexit_158_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/word_access_0
            Xexit_155_symbol <= word_access_0_156_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access/$exit
            word_access_153_symbol <= Xexit_155_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/word_access
          merge_req_161_symbol <= word_access_153_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/merge_req
          ptr_deref_67_gather_scatter_req_0 <= merge_req_161_symbol; -- link to DP
          merge_ack_162_symbol <= ptr_deref_67_gather_scatter_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/merge_ack
          Xexit_152_symbol <= merge_ack_162_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete/$exit
          ptr_deref_67_complete_150_symbol <= Xexit_152_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/ptr_deref_67_complete
        assign_stmt_73_active_x_x163_symbol <= binary_72_complete_169_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_73_active_
        assign_stmt_73_completed_x_x164_symbol <= assign_stmt_73_active_x_x163_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/assign_stmt_73_completed_
        binary_72_active_x_x165_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_active_ 
          signal binary_72_active_x_x165_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_72_active_x_x165_predecessors(0) <= binary_72_trigger_x_x166_symbol;
          binary_72_active_x_x165_predecessors(1) <= simple_obj_ref_70_complete_167_symbol;
          binary_72_active_x_x165_predecessors(2) <= simple_obj_ref_71_complete_168_symbol;
          binary_72_active_x_x165_join: join -- 
            port map( -- 
              preds => binary_72_active_x_x165_predecessors,
              symbol_out => binary_72_active_x_x165_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_active_
        binary_72_trigger_x_x166_symbol <= Xentry_67_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_trigger_
        simple_obj_ref_70_complete_167_symbol <= assign_stmt_64_completed_x_x102_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/simple_obj_ref_70_complete
        simple_obj_ref_71_complete_168_symbol <= assign_stmt_68_completed_x_x133_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/simple_obj_ref_71_complete
        binary_72_complete_169: Block -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete 
          signal Xentry_170_symbol: Boolean;
          signal Xexit_171_symbol: Boolean;
          signal rr_172_symbol : Boolean;
          signal ra_173_symbol : Boolean;
          signal cr_174_symbol : Boolean;
          signal ca_175_symbol : Boolean;
          -- 
        begin -- 
          binary_72_complete_169_start <= binary_72_active_x_x165_symbol; -- control passed to block
          Xentry_170_symbol  <= binary_72_complete_169_start; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete/$entry
          rr_172_symbol <= Xentry_170_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete/rr
          binary_72_inst_req_0 <= rr_172_symbol; -- link to DP
          ra_173_symbol <= binary_72_inst_ack_0; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete/ra
          cr_174_symbol <= ra_173_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete/cr
          binary_72_inst_req_1 <= cr_174_symbol; -- link to DP
          ca_175_symbol <= binary_72_inst_ack_1; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete/ca
          Xexit_171_symbol <= ca_175_symbol; -- transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete/$exit
          binary_72_complete_169_symbol <= Xexit_171_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/binary_72_complete
        Xexit_68_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/$exit 
          signal Xexit_68_predecessors: BooleanArray(4 downto 0);
          -- 
        begin -- 
          Xexit_68_predecessors(0) <= assign_stmt_60_completed_x_x70_symbol;
          Xexit_68_predecessors(1) <= ptr_deref_58_base_address_calculated_74_symbol;
          Xexit_68_predecessors(2) <= ptr_deref_63_base_address_calculated_105_symbol;
          Xexit_68_predecessors(3) <= ptr_deref_67_base_address_calculated_136_symbol;
          Xexit_68_predecessors(4) <= assign_stmt_73_completed_x_x164_symbol;
          Xexit_68_join: join -- 
            port map( -- 
              preds => Xexit_68_predecessors,
              symbol_out => Xexit_68_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73/$exit
        assign_stmt_60_to_assign_stmt_73_66_symbol <= Xexit_68_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_60_to_assign_stmt_73
      assign_stmt_76_176: Block -- branch_block_stmt_39/assign_stmt_76 
        signal Xentry_177_symbol: Boolean;
        signal Xexit_178_symbol: Boolean;
        signal assign_stmt_76_active_x_x179_symbol : Boolean;
        signal assign_stmt_76_completed_x_x180_symbol : Boolean;
        signal simple_obj_ref_75_complete_181_symbol : Boolean;
        signal simple_obj_ref_74_trigger_x_x182_symbol : Boolean;
        signal simple_obj_ref_74_complete_183_start : Boolean;
        signal simple_obj_ref_74_complete_183_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_76_176_start <= assign_stmt_76_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_177_symbol  <= assign_stmt_76_176_start; -- transition branch_block_stmt_39/assign_stmt_76/$entry
        assign_stmt_76_active_x_x179_symbol <= simple_obj_ref_75_complete_181_symbol; -- transition branch_block_stmt_39/assign_stmt_76/assign_stmt_76_active_
        assign_stmt_76_completed_x_x180_symbol <= simple_obj_ref_74_complete_183_symbol; -- transition branch_block_stmt_39/assign_stmt_76/assign_stmt_76_completed_
        simple_obj_ref_75_complete_181_symbol <= Xentry_177_symbol; -- transition branch_block_stmt_39/assign_stmt_76/simple_obj_ref_75_complete
        simple_obj_ref_74_trigger_x_x182_symbol <= assign_stmt_76_active_x_x179_symbol; -- transition branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_trigger_
        simple_obj_ref_74_complete_183: Block -- branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_complete 
          signal Xentry_184_symbol: Boolean;
          signal Xexit_185_symbol: Boolean;
          signal pipe_wreq_186_symbol : Boolean;
          signal pipe_wack_187_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_74_complete_183_start <= simple_obj_ref_74_trigger_x_x182_symbol; -- control passed to block
          Xentry_184_symbol  <= simple_obj_ref_74_complete_183_start; -- transition branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_complete/$entry
          pipe_wreq_186_symbol <= Xentry_184_symbol; -- transition branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_complete/pipe_wreq
          simple_obj_ref_74_inst_req_0 <= pipe_wreq_186_symbol; -- link to DP
          pipe_wack_187_symbol <= simple_obj_ref_74_inst_ack_0; -- transition branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_complete/pipe_wack
          Xexit_185_symbol <= pipe_wack_187_symbol; -- transition branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_complete/$exit
          simple_obj_ref_74_complete_183_symbol <= Xexit_185_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_76/simple_obj_ref_74_complete
        Xexit_178_symbol <= assign_stmt_76_completed_x_x180_symbol; -- transition branch_block_stmt_39/assign_stmt_76/$exit
        assign_stmt_76_176_symbol <= Xexit_178_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_76
      assign_stmt_80_188: Block -- branch_block_stmt_39/assign_stmt_80 
        signal Xentry_189_symbol: Boolean;
        signal Xexit_190_symbol: Boolean;
        signal assign_stmt_80_active_x_x191_symbol : Boolean;
        signal assign_stmt_80_completed_x_x192_symbol : Boolean;
        signal ptr_deref_79_trigger_x_x193_symbol : Boolean;
        signal ptr_deref_79_active_x_x194_symbol : Boolean;
        signal ptr_deref_79_base_address_calculated_195_symbol : Boolean;
        signal ptr_deref_79_root_address_calculated_196_symbol : Boolean;
        signal ptr_deref_79_word_address_calculated_197_symbol : Boolean;
        signal ptr_deref_79_request_198_start : Boolean;
        signal ptr_deref_79_request_198_symbol : Boolean;
        signal ptr_deref_79_complete_209_start : Boolean;
        signal ptr_deref_79_complete_209_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_80_188_start <= assign_stmt_80_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_189_symbol  <= assign_stmt_80_188_start; -- transition branch_block_stmt_39/assign_stmt_80/$entry
        assign_stmt_80_active_x_x191_symbol <= ptr_deref_79_complete_209_symbol; -- transition branch_block_stmt_39/assign_stmt_80/assign_stmt_80_active_
        assign_stmt_80_completed_x_x192_symbol <= assign_stmt_80_active_x_x191_symbol; -- transition branch_block_stmt_39/assign_stmt_80/assign_stmt_80_completed_
        ptr_deref_79_trigger_x_x193_symbol <= ptr_deref_79_word_address_calculated_197_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_trigger_
        ptr_deref_79_active_x_x194_symbol <= ptr_deref_79_request_198_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_active_
        ptr_deref_79_base_address_calculated_195_symbol <= Xentry_189_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_base_address_calculated
        ptr_deref_79_root_address_calculated_196_symbol <= Xentry_189_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_root_address_calculated
        ptr_deref_79_word_address_calculated_197_symbol <= ptr_deref_79_root_address_calculated_196_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_word_address_calculated
        ptr_deref_79_request_198: Block -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request 
          signal Xentry_199_symbol: Boolean;
          signal Xexit_200_symbol: Boolean;
          signal word_access_201_start : Boolean;
          signal word_access_201_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_79_request_198_start <= ptr_deref_79_trigger_x_x193_symbol; -- control passed to block
          Xentry_199_symbol  <= ptr_deref_79_request_198_start; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/$entry
          word_access_201: Block -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access 
            signal Xentry_202_symbol: Boolean;
            signal Xexit_203_symbol: Boolean;
            signal word_access_0_204_start : Boolean;
            signal word_access_0_204_symbol : Boolean;
            -- 
          begin -- 
            word_access_201_start <= Xentry_199_symbol; -- control passed to block
            Xentry_202_symbol  <= word_access_201_start; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/$entry
            word_access_0_204: Block -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/word_access_0 
              signal Xentry_205_symbol: Boolean;
              signal Xexit_206_symbol: Boolean;
              signal rr_207_symbol : Boolean;
              signal ra_208_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_204_start <= Xentry_202_symbol; -- control passed to block
              Xentry_205_symbol  <= word_access_0_204_start; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/word_access_0/$entry
              rr_207_symbol <= Xentry_205_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/word_access_0/rr
              ptr_deref_79_load_0_req_0 <= rr_207_symbol; -- link to DP
              ra_208_symbol <= ptr_deref_79_load_0_ack_0; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/word_access_0/ra
              Xexit_206_symbol <= ra_208_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/word_access_0/$exit
              word_access_0_204_symbol <= Xexit_206_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/word_access_0
            Xexit_203_symbol <= word_access_0_204_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access/$exit
            word_access_201_symbol <= Xexit_203_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/word_access
          Xexit_200_symbol <= word_access_201_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request/$exit
          ptr_deref_79_request_198_symbol <= Xexit_200_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_request
        ptr_deref_79_complete_209: Block -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete 
          signal Xentry_210_symbol: Boolean;
          signal Xexit_211_symbol: Boolean;
          signal word_access_212_start : Boolean;
          signal word_access_212_symbol : Boolean;
          signal merge_req_220_symbol : Boolean;
          signal merge_ack_221_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_79_complete_209_start <= ptr_deref_79_active_x_x194_symbol; -- control passed to block
          Xentry_210_symbol  <= ptr_deref_79_complete_209_start; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/$entry
          word_access_212: Block -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access 
            signal Xentry_213_symbol: Boolean;
            signal Xexit_214_symbol: Boolean;
            signal word_access_0_215_start : Boolean;
            signal word_access_0_215_symbol : Boolean;
            -- 
          begin -- 
            word_access_212_start <= Xentry_210_symbol; -- control passed to block
            Xentry_213_symbol  <= word_access_212_start; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/$entry
            word_access_0_215: Block -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/word_access_0 
              signal Xentry_216_symbol: Boolean;
              signal Xexit_217_symbol: Boolean;
              signal cr_218_symbol : Boolean;
              signal ca_219_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_215_start <= Xentry_213_symbol; -- control passed to block
              Xentry_216_symbol  <= word_access_0_215_start; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/word_access_0/$entry
              cr_218_symbol <= Xentry_216_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/word_access_0/cr
              ptr_deref_79_load_0_req_1 <= cr_218_symbol; -- link to DP
              ca_219_symbol <= ptr_deref_79_load_0_ack_1; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/word_access_0/ca
              Xexit_217_symbol <= ca_219_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/word_access_0/$exit
              word_access_0_215_symbol <= Xexit_217_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/word_access_0
            Xexit_214_symbol <= word_access_0_215_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access/$exit
            word_access_212_symbol <= Xexit_214_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/word_access
          merge_req_220_symbol <= word_access_212_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/merge_req
          ptr_deref_79_gather_scatter_req_0 <= merge_req_220_symbol; -- link to DP
          merge_ack_221_symbol <= ptr_deref_79_gather_scatter_ack_0; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/merge_ack
          Xexit_211_symbol <= merge_ack_221_symbol; -- transition branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete/$exit
          ptr_deref_79_complete_209_symbol <= Xexit_211_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_39/assign_stmt_80/ptr_deref_79_complete
        Xexit_190_block : Block -- non-trivial join transition branch_block_stmt_39/assign_stmt_80/$exit 
          signal Xexit_190_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_190_predecessors(0) <= assign_stmt_80_completed_x_x192_symbol;
          Xexit_190_predecessors(1) <= ptr_deref_79_base_address_calculated_195_symbol;
          Xexit_190_join: join -- 
            port map( -- 
              preds => Xexit_190_predecessors,
              symbol_out => Xexit_190_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_39/assign_stmt_80/$exit
        assign_stmt_80_188_symbol <= Xexit_190_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/assign_stmt_80
      return_x_xx_xPhiReq_222: Block -- branch_block_stmt_39/return___PhiReq 
        signal Xentry_223_symbol: Boolean;
        signal Xexit_224_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_222_start <= return_x_xx_x18_symbol; -- control passed to block
        Xentry_223_symbol  <= return_x_xx_xPhiReq_222_start; -- transition branch_block_stmt_39/return___PhiReq/$entry
        Xexit_224_symbol <= Xentry_223_symbol; -- transition branch_block_stmt_39/return___PhiReq/$exit
        return_x_xx_xPhiReq_222_symbol <= Xexit_224_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/return___PhiReq
      merge_stmt_82_PhiReqMerge_225_symbol  <=  return_x_xx_xPhiReq_222_symbol; -- place branch_block_stmt_39/merge_stmt_82_PhiReqMerge (optimized away) 
      merge_stmt_82_PhiAck_226: Block -- branch_block_stmt_39/merge_stmt_82_PhiAck 
        signal Xentry_227_symbol: Boolean;
        signal Xexit_228_symbol: Boolean;
        signal dummy_229_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_82_PhiAck_226_start <= merge_stmt_82_PhiReqMerge_225_symbol; -- control passed to block
        Xentry_227_symbol  <= merge_stmt_82_PhiAck_226_start; -- transition branch_block_stmt_39/merge_stmt_82_PhiAck/$entry
        dummy_229_symbol <= Xentry_227_symbol; -- transition branch_block_stmt_39/merge_stmt_82_PhiAck/dummy
        Xexit_228_symbol <= dummy_229_symbol; -- transition branch_block_stmt_39/merge_stmt_82_PhiAck/$exit
        merge_stmt_82_PhiAck_226_symbol <= Xexit_228_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_39/merge_stmt_82_PhiAck
      Xexit_5_symbol <= branch_block_stmt_39_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_39/$exit
      branch_block_stmt_39_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_39
    Xexit_2_symbol <= branch_block_stmt_39_3_symbol; -- transition $exit
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
    signal b_49 : std_logic_vector(31 downto 0);
    signal iNsTr_0_45 : std_logic_vector(31 downto 0);
    signal iNsTr_3_56 : std_logic_vector(31 downto 0);
    signal iNsTr_5_64 : std_logic_vector(31 downto 0);
    signal iNsTr_6_68 : std_logic_vector(31 downto 0);
    signal iNsTr_7_73 : std_logic_vector(31 downto 0);
    signal ptr_deref_51_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_51_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_51_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_58_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_58_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_58_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_63_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_63_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_67_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_67_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_79_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_79_word_address_0 : std_logic_vector(0 downto 0);
    signal xxbarxxbodyxxb_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxbarxxbodyxxiNsTr_0_alloc_base_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    b_49 <= "00000000000000000000000000000000";
    iNsTr_0_45 <= "00000000000000000000000000000000";
    ptr_deref_51_word_address_0 <= "0";
    ptr_deref_58_word_address_0 <= "0";
    ptr_deref_63_word_address_0 <= "0";
    ptr_deref_67_word_address_0 <= "0";
    ptr_deref_79_word_address_0 <= "0";
    xxbarxxbodyxxb_alloc_base_address <= "0";
    xxbarxxbodyxxiNsTr_0_alloc_base_address <= "0";
    ptr_deref_51_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_51_gather_scatter_ack_0 <= ptr_deref_51_gather_scatter_req_0;
      aggregated_sig <= a;
      ptr_deref_51_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_58_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_58_gather_scatter_ack_0 <= ptr_deref_58_gather_scatter_req_0;
      aggregated_sig <= iNsTr_3_56;
      ptr_deref_58_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_63_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_63_gather_scatter_ack_0 <= ptr_deref_63_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_63_data_0;
      iNsTr_5_64 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_67_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_67_gather_scatter_ack_0 <= ptr_deref_67_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_67_data_0;
      iNsTr_6_68 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_79_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_79_gather_scatter_ack_0 <= ptr_deref_79_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_79_data_0;
      ret_val_x_x_buffer <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_72_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_64 & iNsTr_6_68;
      iNsTr_7_73 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
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
          reqL => binary_72_inst_req_0,
          ackL => binary_72_inst_ack_0,
          reqR => binary_72_inst_req_1,
          ackR => binary_72_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared load operator group (0) : ptr_deref_63_load_0 ptr_deref_79_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_63_load_0_req_0;
      reqL(0) <= ptr_deref_79_load_0_req_0;
      ptr_deref_63_load_0_ack_0 <= ackL(1);
      ptr_deref_79_load_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_63_load_0_req_1;
      reqR(0) <= ptr_deref_79_load_0_req_1;
      ptr_deref_63_load_0_ack_1 <= ackR(1);
      ptr_deref_79_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_63_word_address_0 & ptr_deref_79_word_address_0;
      ptr_deref_63_data_0 <= data_out(63 downto 32);
      ptr_deref_79_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_4_lr_req(0),
          mack => memory_space_4_lr_ack(0),
          maddr => memory_space_4_lr_addr(0 downto 0),
          mtag => memory_space_4_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_4_lc_req(0),
          mack => memory_space_4_lc_ack(0),
          mdata => memory_space_4_lc_data(31 downto 0),
          mtag => memory_space_4_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_67_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_67_load_0_req_0;
      ptr_deref_67_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_67_load_0_req_1;
      ptr_deref_67_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_67_word_address_0;
      ptr_deref_67_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_5_lr_req(0),
          mack => memory_space_5_lr_ack(0),
          maddr => memory_space_5_lr_addr(0 downto 0),
          mtag => memory_space_5_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_5_lc_req(0),
          mack => memory_space_5_lc_ack(0),
          mdata => memory_space_5_lc_data(31 downto 0),
          mtag => memory_space_5_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared store operator group (0) : ptr_deref_51_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_51_store_0_req_0;
      ptr_deref_51_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_51_store_0_req_1;
      ptr_deref_51_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_51_word_address_0;
      data_in <= ptr_deref_51_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_4_sr_req(0),
          mack => memory_space_4_sr_ack(0),
          maddr => memory_space_4_sr_addr(0 downto 0),
          mdata => memory_space_4_sr_data(31 downto 0),
          mtag => memory_space_4_sr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 1,
          tag_length => 2 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_4_sc_req(0),
          mack => memory_space_4_sc_ack(0),
          mtag => memory_space_4_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_58_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_58_store_0_req_0;
      ptr_deref_58_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_58_store_0_req_1;
      ptr_deref_58_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_58_word_address_0;
      data_in <= ptr_deref_58_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        min_clock_period => true,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_5_sr_req(0),
          mack => memory_space_5_sr_ack(0),
          maddr => memory_space_5_sr_addr(0 downto 0),
          mdata => memory_space_5_sr_data(31 downto 0),
          mtag => memory_space_5_sr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 1,
          tag_length => 1 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_5_sc_req(0),
          mack => memory_space_5_sc_ack(0),
          mtag => memory_space_5_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared inport operator group (0) : simple_obj_ref_55_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_55_inst_req_0;
      simple_obj_ref_55_inst_ack_0 <= ack(0);
      iNsTr_3_56 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => midpipe_pipe_read_req(0),
          oack => midpipe_pipe_read_ack(0),
          odata => midpipe_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_74_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_74_inst_req_0;
      simple_obj_ref_74_inst_ack_0 <= ack(0);
      data_in <= iNsTr_7_73;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => outpipe_pipe_write_req(0),
          oack => outpipe_pipe_write_ack(0),
          odata => outpipe_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- 
  end Block; -- data_path
  RegisterBank_memory_space_4: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 2,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_4_lr_addr,
      lr_req_in => memory_space_4_lr_req,
      lr_ack_out => memory_space_4_lr_ack,
      lr_tag_in => memory_space_4_lr_tag,
      lc_req_in => memory_space_4_lc_req,
      lc_ack_out => memory_space_4_lc_ack,
      lc_data_out => memory_space_4_lc_data,
      lc_tag_out => memory_space_4_lc_tag,
      sr_addr_in => memory_space_4_sr_addr,
      sr_data_in => memory_space_4_sr_data,
      sr_req_in => memory_space_4_sr_req,
      sr_ack_out => memory_space_4_sr_ack,
      sr_tag_in => memory_space_4_sr_tag,
      sc_req_in=> memory_space_4_sc_req,
      sc_ack_out => memory_space_4_sc_ack,
      sc_tag_out => memory_space_4_sc_tag,
      clock => clk,
      reset => reset); -- 
  RegisterBank_memory_space_5: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_5_lr_addr,
      lr_req_in => memory_space_5_lr_req,
      lr_ack_out => memory_space_5_lr_ack,
      lr_tag_in => memory_space_5_lr_tag,
      lc_req_in => memory_space_5_lc_req,
      lc_ack_out => memory_space_5_lc_ack,
      lc_data_out => memory_space_5_lc_data,
      lc_tag_out => memory_space_5_lc_tag,
      sr_addr_in => memory_space_5_sr_addr,
      sr_data_in => memory_space_5_sr_data,
      sr_req_in => memory_space_5_sr_req,
      sr_ack_out => memory_space_5_sr_ack,
      sr_tag_in => memory_space_5_sr_tag,
      sc_req_in=> memory_space_5_sc_req,
      sc_ack_out => memory_space_5_sc_ack,
      sc_tag_out => memory_space_5_sc_tag,
      clock => clk,
      reset => reset); -- 
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
entity foo is -- 
  generic (tag_length : integer); 
  port ( -- 
    a : in  std_logic_vector(31 downto 0);
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start_req : in std_logic;
    start_ack : out std_logic;
    fin_req : in std_logic;
    fin_ack   : out std_logic;
    inpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
    inpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
    inpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
    midpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    midpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    midpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(tag_length-1 downto 0);
    tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
  );
  -- 
end entity foo;
architecture Default of foo is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  signal start_req_symbol: Boolean;
  signal start_ack_symbol: Boolean;
  signal fin_req_symbol: Boolean;
  signal fin_ack_symbol: Boolean;
  signal tag_push, tag_pop: std_logic; 
  signal start_ack_sig, fin_ack_sig: std_logic; 
  -- output port buffer signals
  signal ret_val_x_x_buffer :  std_logic_vector(31 downto 0);
  signal foo_CP_230_start: Boolean;
  -- links between control-path and data-path
  signal ptr_deref_100_gather_scatter_req_0 : boolean;
  signal ptr_deref_100_gather_scatter_ack_0 : boolean;
  signal ptr_deref_100_store_0_req_0 : boolean;
  signal ptr_deref_100_store_0_ack_0 : boolean;
  signal ptr_deref_100_store_0_req_1 : boolean;
  signal ptr_deref_100_store_0_ack_1 : boolean;
  signal simple_obj_ref_104_inst_req_0 : boolean;
  signal simple_obj_ref_104_inst_ack_0 : boolean;
  signal ptr_deref_107_gather_scatter_req_0 : boolean;
  signal ptr_deref_107_gather_scatter_ack_0 : boolean;
  signal ptr_deref_107_store_0_req_0 : boolean;
  signal ptr_deref_107_store_0_ack_0 : boolean;
  signal ptr_deref_107_store_0_req_1 : boolean;
  signal ptr_deref_107_store_0_ack_1 : boolean;
  signal ptr_deref_112_load_0_req_0 : boolean;
  signal ptr_deref_112_load_0_ack_0 : boolean;
  signal ptr_deref_112_load_0_req_1 : boolean;
  signal ptr_deref_112_load_0_ack_1 : boolean;
  signal ptr_deref_112_gather_scatter_req_0 : boolean;
  signal ptr_deref_112_gather_scatter_ack_0 : boolean;
  signal ptr_deref_116_load_0_req_0 : boolean;
  signal ptr_deref_116_load_0_ack_0 : boolean;
  signal ptr_deref_116_load_0_req_1 : boolean;
  signal ptr_deref_116_load_0_ack_1 : boolean;
  signal ptr_deref_116_gather_scatter_req_0 : boolean;
  signal ptr_deref_116_gather_scatter_ack_0 : boolean;
  signal binary_121_inst_req_0 : boolean;
  signal binary_121_inst_ack_0 : boolean;
  signal binary_121_inst_req_1 : boolean;
  signal binary_121_inst_ack_1 : boolean;
  signal simple_obj_ref_123_inst_req_0 : boolean;
  signal simple_obj_ref_123_inst_ack_0 : boolean;
  signal ptr_deref_128_load_0_req_0 : boolean;
  signal ptr_deref_128_load_0_ack_0 : boolean;
  signal ptr_deref_128_load_0_req_1 : boolean;
  signal ptr_deref_128_load_0_ack_1 : boolean;
  signal ptr_deref_128_gather_scatter_req_0 : boolean;
  signal ptr_deref_128_gather_scatter_ack_0 : boolean;
  signal memory_space_6_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_6_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_6_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_6_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_6_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_6_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_6_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_6_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_6_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_6_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_6_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_6_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_6_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_6_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_6_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_6_sc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_7_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_7_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_7_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_7_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_7_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_7_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_7_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_7_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_7_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_7_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_7_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_7_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_7_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_7_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_7_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_7_sc_tag :  std_logic_vector(0 downto 0);
  -- 
begin --  
  -- output port buffering assignments
  ret_val_x_x <= ret_val_x_x_buffer; 
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
  foo_CP_230: Block -- control-path 
    signal Xentry_231_symbol: Boolean;
    signal Xexit_232_symbol: Boolean;
    signal branch_block_stmt_88_233_start : Boolean;
    signal branch_block_stmt_88_233_symbol : Boolean;
    -- 
  begin -- 
    foo_CP_230_start_interlock : pipeline_interlock -- 
      port map (trigger => start_req_symbol,
      enable =>  fin_ack_symbol, 
      symbol_out => foo_CP_230_start, 
      clk => clk, reset => reset); -- 
    start_ack_symbol <= Xexit_232_symbol;
    Xentry_231_symbol  <= foo_CP_230_start; -- transition $entry
    branch_block_stmt_88_233: Block -- branch_block_stmt_88 
      signal Xentry_234_symbol: Boolean;
      signal Xexit_235_symbol: Boolean;
      signal branch_block_stmt_88_x_xentry_x_xx_x236_symbol : Boolean;
      signal branch_block_stmt_88_x_xexit_x_xx_x237_symbol : Boolean;
      signal assign_stmt_94_to_assign_stmt_102_x_xentry_x_xx_x238_symbol : Boolean;
      signal assign_stmt_94_to_assign_stmt_102_x_xexit_x_xx_x239_symbol : Boolean;
      signal assign_stmt_105_x_xentry_x_xx_x240_symbol : Boolean;
      signal assign_stmt_105_x_xexit_x_xx_x241_symbol : Boolean;
      signal assign_stmt_109_to_assign_stmt_122_x_xentry_x_xx_x242_symbol : Boolean;
      signal assign_stmt_109_to_assign_stmt_122_x_xexit_x_xx_x243_symbol : Boolean;
      signal assign_stmt_125_x_xentry_x_xx_x244_symbol : Boolean;
      signal assign_stmt_125_x_xexit_x_xx_x245_symbol : Boolean;
      signal assign_stmt_129_x_xentry_x_xx_x246_symbol : Boolean;
      signal assign_stmt_129_x_xexit_x_xx_x247_symbol : Boolean;
      signal return_x_xx_x248_symbol : Boolean;
      signal merge_stmt_131_x_xexit_x_xx_x249_symbol : Boolean;
      signal assign_stmt_94_to_assign_stmt_102_250_start : Boolean;
      signal assign_stmt_94_to_assign_stmt_102_250_symbol : Boolean;
      signal assign_stmt_105_285_start : Boolean;
      signal assign_stmt_105_285_symbol : Boolean;
      signal assign_stmt_109_to_assign_stmt_122_296_start : Boolean;
      signal assign_stmt_109_to_assign_stmt_122_296_symbol : Boolean;
      signal assign_stmt_125_406_start : Boolean;
      signal assign_stmt_125_406_symbol : Boolean;
      signal assign_stmt_129_418_start : Boolean;
      signal assign_stmt_129_418_symbol : Boolean;
      signal return_x_xx_xPhiReq_452_start : Boolean;
      signal return_x_xx_xPhiReq_452_symbol : Boolean;
      signal merge_stmt_131_PhiReqMerge_455_symbol : Boolean;
      signal merge_stmt_131_PhiAck_456_start : Boolean;
      signal merge_stmt_131_PhiAck_456_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_88_233_start <= Xentry_231_symbol; -- control passed to block
      Xentry_234_symbol  <= branch_block_stmt_88_233_start; -- transition branch_block_stmt_88/$entry
      branch_block_stmt_88_x_xentry_x_xx_x236_symbol  <=  Xentry_234_symbol; -- place branch_block_stmt_88/branch_block_stmt_88__entry__ (optimized away) 
      branch_block_stmt_88_x_xexit_x_xx_x237_symbol  <=  merge_stmt_131_x_xexit_x_xx_x249_symbol; -- place branch_block_stmt_88/branch_block_stmt_88__exit__ (optimized away) 
      assign_stmt_94_to_assign_stmt_102_x_xentry_x_xx_x238_symbol  <=  branch_block_stmt_88_x_xentry_x_xx_x236_symbol; -- place branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102__entry__ (optimized away) 
      assign_stmt_94_to_assign_stmt_102_x_xexit_x_xx_x239_symbol  <=  assign_stmt_94_to_assign_stmt_102_250_symbol; -- place branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102__exit__ (optimized away) 
      assign_stmt_105_x_xentry_x_xx_x240_symbol  <=  assign_stmt_94_to_assign_stmt_102_x_xexit_x_xx_x239_symbol; -- place branch_block_stmt_88/assign_stmt_105__entry__ (optimized away) 
      assign_stmt_105_x_xexit_x_xx_x241_symbol  <=  assign_stmt_105_285_symbol; -- place branch_block_stmt_88/assign_stmt_105__exit__ (optimized away) 
      assign_stmt_109_to_assign_stmt_122_x_xentry_x_xx_x242_symbol  <=  assign_stmt_105_x_xexit_x_xx_x241_symbol; -- place branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122__entry__ (optimized away) 
      assign_stmt_109_to_assign_stmt_122_x_xexit_x_xx_x243_symbol  <=  assign_stmt_109_to_assign_stmt_122_296_symbol; -- place branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122__exit__ (optimized away) 
      assign_stmt_125_x_xentry_x_xx_x244_symbol  <=  assign_stmt_109_to_assign_stmt_122_x_xexit_x_xx_x243_symbol; -- place branch_block_stmt_88/assign_stmt_125__entry__ (optimized away) 
      assign_stmt_125_x_xexit_x_xx_x245_symbol  <=  assign_stmt_125_406_symbol; -- place branch_block_stmt_88/assign_stmt_125__exit__ (optimized away) 
      assign_stmt_129_x_xentry_x_xx_x246_symbol  <=  assign_stmt_125_x_xexit_x_xx_x245_symbol; -- place branch_block_stmt_88/assign_stmt_129__entry__ (optimized away) 
      assign_stmt_129_x_xexit_x_xx_x247_symbol  <=  assign_stmt_129_418_symbol; -- place branch_block_stmt_88/assign_stmt_129__exit__ (optimized away) 
      return_x_xx_x248_symbol  <=  assign_stmt_129_x_xexit_x_xx_x247_symbol; -- place branch_block_stmt_88/return__ (optimized away) 
      merge_stmt_131_x_xexit_x_xx_x249_symbol  <=  merge_stmt_131_PhiAck_456_symbol; -- place branch_block_stmt_88/merge_stmt_131__exit__ (optimized away) 
      assign_stmt_94_to_assign_stmt_102_250: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102 
        signal Xentry_251_symbol: Boolean;
        signal Xexit_252_symbol: Boolean;
        signal assign_stmt_102_active_x_x253_symbol : Boolean;
        signal assign_stmt_102_completed_x_x254_symbol : Boolean;
        signal simple_obj_ref_101_complete_255_symbol : Boolean;
        signal ptr_deref_100_trigger_x_x256_symbol : Boolean;
        signal ptr_deref_100_active_x_x257_symbol : Boolean;
        signal ptr_deref_100_base_address_calculated_258_symbol : Boolean;
        signal ptr_deref_100_root_address_calculated_259_symbol : Boolean;
        signal ptr_deref_100_word_address_calculated_260_symbol : Boolean;
        signal ptr_deref_100_request_261_start : Boolean;
        signal ptr_deref_100_request_261_symbol : Boolean;
        signal ptr_deref_100_complete_274_start : Boolean;
        signal ptr_deref_100_complete_274_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_94_to_assign_stmt_102_250_start <= assign_stmt_94_to_assign_stmt_102_x_xentry_x_xx_x238_symbol; -- control passed to block
        Xentry_251_symbol  <= assign_stmt_94_to_assign_stmt_102_250_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/$entry
        assign_stmt_102_active_x_x253_symbol <= simple_obj_ref_101_complete_255_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/assign_stmt_102_active_
        assign_stmt_102_completed_x_x254_symbol <= ptr_deref_100_complete_274_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/assign_stmt_102_completed_
        simple_obj_ref_101_complete_255_symbol <= Xentry_251_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/simple_obj_ref_101_complete
        ptr_deref_100_trigger_x_x256_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_trigger_ 
          signal ptr_deref_100_trigger_x_x256_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_100_trigger_x_x256_predecessors(0) <= ptr_deref_100_word_address_calculated_260_symbol;
          ptr_deref_100_trigger_x_x256_predecessors(1) <= assign_stmt_102_active_x_x253_symbol;
          ptr_deref_100_trigger_x_x256_join: join -- 
            port map( -- 
              preds => ptr_deref_100_trigger_x_x256_predecessors,
              symbol_out => ptr_deref_100_trigger_x_x256_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_trigger_
        ptr_deref_100_active_x_x257_symbol <= ptr_deref_100_request_261_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_active_
        ptr_deref_100_base_address_calculated_258_symbol <= Xentry_251_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_base_address_calculated
        ptr_deref_100_root_address_calculated_259_symbol <= Xentry_251_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_root_address_calculated
        ptr_deref_100_word_address_calculated_260_symbol <= ptr_deref_100_root_address_calculated_259_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_word_address_calculated
        ptr_deref_100_request_261: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request 
          signal Xentry_262_symbol: Boolean;
          signal Xexit_263_symbol: Boolean;
          signal split_req_264_symbol : Boolean;
          signal split_ack_265_symbol : Boolean;
          signal word_access_266_start : Boolean;
          signal word_access_266_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_100_request_261_start <= ptr_deref_100_trigger_x_x256_symbol; -- control passed to block
          Xentry_262_symbol  <= ptr_deref_100_request_261_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/$entry
          split_req_264_symbol <= Xentry_262_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/split_req
          ptr_deref_100_gather_scatter_req_0 <= split_req_264_symbol; -- link to DP
          split_ack_265_symbol <= ptr_deref_100_gather_scatter_ack_0; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/split_ack
          word_access_266: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access 
            signal Xentry_267_symbol: Boolean;
            signal Xexit_268_symbol: Boolean;
            signal word_access_0_269_start : Boolean;
            signal word_access_0_269_symbol : Boolean;
            -- 
          begin -- 
            word_access_266_start <= split_ack_265_symbol; -- control passed to block
            Xentry_267_symbol  <= word_access_266_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/$entry
            word_access_0_269: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/word_access_0 
              signal Xentry_270_symbol: Boolean;
              signal Xexit_271_symbol: Boolean;
              signal rr_272_symbol : Boolean;
              signal ra_273_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_269_start <= Xentry_267_symbol; -- control passed to block
              Xentry_270_symbol  <= word_access_0_269_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/word_access_0/$entry
              rr_272_symbol <= Xentry_270_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/word_access_0/rr
              ptr_deref_100_store_0_req_0 <= rr_272_symbol; -- link to DP
              ra_273_symbol <= ptr_deref_100_store_0_ack_0; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/word_access_0/ra
              Xexit_271_symbol <= ra_273_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/word_access_0/$exit
              word_access_0_269_symbol <= Xexit_271_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/word_access_0
            Xexit_268_symbol <= word_access_0_269_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access/$exit
            word_access_266_symbol <= Xexit_268_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/word_access
          Xexit_263_symbol <= word_access_266_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request/$exit
          ptr_deref_100_request_261_symbol <= Xexit_263_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_request
        ptr_deref_100_complete_274: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete 
          signal Xentry_275_symbol: Boolean;
          signal Xexit_276_symbol: Boolean;
          signal word_access_277_start : Boolean;
          signal word_access_277_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_100_complete_274_start <= ptr_deref_100_active_x_x257_symbol; -- control passed to block
          Xentry_275_symbol  <= ptr_deref_100_complete_274_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/$entry
          word_access_277: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access 
            signal Xentry_278_symbol: Boolean;
            signal Xexit_279_symbol: Boolean;
            signal word_access_0_280_start : Boolean;
            signal word_access_0_280_symbol : Boolean;
            -- 
          begin -- 
            word_access_277_start <= Xentry_275_symbol; -- control passed to block
            Xentry_278_symbol  <= word_access_277_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/$entry
            word_access_0_280: Block -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/word_access_0 
              signal Xentry_281_symbol: Boolean;
              signal Xexit_282_symbol: Boolean;
              signal cr_283_symbol : Boolean;
              signal ca_284_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_280_start <= Xentry_278_symbol; -- control passed to block
              Xentry_281_symbol  <= word_access_0_280_start; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/word_access_0/$entry
              cr_283_symbol <= Xentry_281_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/word_access_0/cr
              ptr_deref_100_store_0_req_1 <= cr_283_symbol; -- link to DP
              ca_284_symbol <= ptr_deref_100_store_0_ack_1; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/word_access_0/ca
              Xexit_282_symbol <= ca_284_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/word_access_0/$exit
              word_access_0_280_symbol <= Xexit_282_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/word_access_0
            Xexit_279_symbol <= word_access_0_280_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access/$exit
            word_access_277_symbol <= Xexit_279_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/word_access
          Xexit_276_symbol <= word_access_277_symbol; -- transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete/$exit
          ptr_deref_100_complete_274_symbol <= Xexit_276_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/ptr_deref_100_complete
        Xexit_252_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/$exit 
          signal Xexit_252_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_252_predecessors(0) <= assign_stmt_102_completed_x_x254_symbol;
          Xexit_252_predecessors(1) <= ptr_deref_100_base_address_calculated_258_symbol;
          Xexit_252_join: join -- 
            port map( -- 
              preds => Xexit_252_predecessors,
              symbol_out => Xexit_252_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102/$exit
        assign_stmt_94_to_assign_stmt_102_250_symbol <= Xexit_252_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/assign_stmt_94_to_assign_stmt_102
      assign_stmt_105_285: Block -- branch_block_stmt_88/assign_stmt_105 
        signal Xentry_286_symbol: Boolean;
        signal Xexit_287_symbol: Boolean;
        signal assign_stmt_105_active_x_x288_symbol : Boolean;
        signal assign_stmt_105_completed_x_x289_symbol : Boolean;
        signal simple_obj_ref_104_trigger_x_x290_symbol : Boolean;
        signal simple_obj_ref_104_complete_291_start : Boolean;
        signal simple_obj_ref_104_complete_291_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_105_285_start <= assign_stmt_105_x_xentry_x_xx_x240_symbol; -- control passed to block
        Xentry_286_symbol  <= assign_stmt_105_285_start; -- transition branch_block_stmt_88/assign_stmt_105/$entry
        assign_stmt_105_active_x_x288_symbol <= simple_obj_ref_104_complete_291_symbol; -- transition branch_block_stmt_88/assign_stmt_105/assign_stmt_105_active_
        assign_stmt_105_completed_x_x289_symbol <= assign_stmt_105_active_x_x288_symbol; -- transition branch_block_stmt_88/assign_stmt_105/assign_stmt_105_completed_
        simple_obj_ref_104_trigger_x_x290_symbol <= Xentry_286_symbol; -- transition branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_trigger_
        simple_obj_ref_104_complete_291: Block -- branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_complete 
          signal Xentry_292_symbol: Boolean;
          signal Xexit_293_symbol: Boolean;
          signal req_294_symbol : Boolean;
          signal ack_295_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_104_complete_291_start <= simple_obj_ref_104_trigger_x_x290_symbol; -- control passed to block
          Xentry_292_symbol  <= simple_obj_ref_104_complete_291_start; -- transition branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_complete/$entry
          req_294_symbol <= Xentry_292_symbol; -- transition branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_complete/req
          simple_obj_ref_104_inst_req_0 <= req_294_symbol; -- link to DP
          ack_295_symbol <= simple_obj_ref_104_inst_ack_0; -- transition branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_complete/ack
          Xexit_293_symbol <= ack_295_symbol; -- transition branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_complete/$exit
          simple_obj_ref_104_complete_291_symbol <= Xexit_293_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_105/simple_obj_ref_104_complete
        Xexit_287_symbol <= assign_stmt_105_completed_x_x289_symbol; -- transition branch_block_stmt_88/assign_stmt_105/$exit
        assign_stmt_105_285_symbol <= Xexit_287_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/assign_stmt_105
      assign_stmt_109_to_assign_stmt_122_296: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122 
        signal Xentry_297_symbol: Boolean;
        signal Xexit_298_symbol: Boolean;
        signal assign_stmt_109_active_x_x299_symbol : Boolean;
        signal assign_stmt_109_completed_x_x300_symbol : Boolean;
        signal simple_obj_ref_108_complete_301_symbol : Boolean;
        signal ptr_deref_107_trigger_x_x302_symbol : Boolean;
        signal ptr_deref_107_active_x_x303_symbol : Boolean;
        signal ptr_deref_107_base_address_calculated_304_symbol : Boolean;
        signal ptr_deref_107_root_address_calculated_305_symbol : Boolean;
        signal ptr_deref_107_word_address_calculated_306_symbol : Boolean;
        signal ptr_deref_107_request_307_start : Boolean;
        signal ptr_deref_107_request_307_symbol : Boolean;
        signal ptr_deref_107_complete_320_start : Boolean;
        signal ptr_deref_107_complete_320_symbol : Boolean;
        signal assign_stmt_113_active_x_x331_symbol : Boolean;
        signal assign_stmt_113_completed_x_x332_symbol : Boolean;
        signal ptr_deref_112_trigger_x_x333_symbol : Boolean;
        signal ptr_deref_112_active_x_x334_symbol : Boolean;
        signal ptr_deref_112_base_address_calculated_335_symbol : Boolean;
        signal ptr_deref_112_root_address_calculated_336_symbol : Boolean;
        signal ptr_deref_112_word_address_calculated_337_symbol : Boolean;
        signal ptr_deref_112_request_338_start : Boolean;
        signal ptr_deref_112_request_338_symbol : Boolean;
        signal ptr_deref_112_complete_349_start : Boolean;
        signal ptr_deref_112_complete_349_symbol : Boolean;
        signal assign_stmt_117_active_x_x362_symbol : Boolean;
        signal assign_stmt_117_completed_x_x363_symbol : Boolean;
        signal ptr_deref_116_trigger_x_x364_symbol : Boolean;
        signal ptr_deref_116_active_x_x365_symbol : Boolean;
        signal ptr_deref_116_base_address_calculated_366_symbol : Boolean;
        signal ptr_deref_116_root_address_calculated_367_symbol : Boolean;
        signal ptr_deref_116_word_address_calculated_368_symbol : Boolean;
        signal ptr_deref_116_request_369_start : Boolean;
        signal ptr_deref_116_request_369_symbol : Boolean;
        signal ptr_deref_116_complete_380_start : Boolean;
        signal ptr_deref_116_complete_380_symbol : Boolean;
        signal assign_stmt_122_active_x_x393_symbol : Boolean;
        signal assign_stmt_122_completed_x_x394_symbol : Boolean;
        signal binary_121_active_x_x395_symbol : Boolean;
        signal binary_121_trigger_x_x396_symbol : Boolean;
        signal simple_obj_ref_119_complete_397_symbol : Boolean;
        signal simple_obj_ref_120_complete_398_symbol : Boolean;
        signal binary_121_complete_399_start : Boolean;
        signal binary_121_complete_399_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_109_to_assign_stmt_122_296_start <= assign_stmt_109_to_assign_stmt_122_x_xentry_x_xx_x242_symbol; -- control passed to block
        Xentry_297_symbol  <= assign_stmt_109_to_assign_stmt_122_296_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/$entry
        assign_stmt_109_active_x_x299_symbol <= simple_obj_ref_108_complete_301_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_109_active_
        assign_stmt_109_completed_x_x300_symbol <= ptr_deref_107_complete_320_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_109_completed_
        simple_obj_ref_108_complete_301_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/simple_obj_ref_108_complete
        ptr_deref_107_trigger_x_x302_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_trigger_ 
          signal ptr_deref_107_trigger_x_x302_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_107_trigger_x_x302_predecessors(0) <= ptr_deref_107_word_address_calculated_306_symbol;
          ptr_deref_107_trigger_x_x302_predecessors(1) <= assign_stmt_109_active_x_x299_symbol;
          ptr_deref_107_trigger_x_x302_join: join -- 
            port map( -- 
              preds => ptr_deref_107_trigger_x_x302_predecessors,
              symbol_out => ptr_deref_107_trigger_x_x302_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_trigger_
        ptr_deref_107_active_x_x303_symbol <= ptr_deref_107_request_307_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_active_
        ptr_deref_107_base_address_calculated_304_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_base_address_calculated
        ptr_deref_107_root_address_calculated_305_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_root_address_calculated
        ptr_deref_107_word_address_calculated_306_symbol <= ptr_deref_107_root_address_calculated_305_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_word_address_calculated
        ptr_deref_107_request_307: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request 
          signal Xentry_308_symbol: Boolean;
          signal Xexit_309_symbol: Boolean;
          signal split_req_310_symbol : Boolean;
          signal split_ack_311_symbol : Boolean;
          signal word_access_312_start : Boolean;
          signal word_access_312_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_107_request_307_start <= ptr_deref_107_trigger_x_x302_symbol; -- control passed to block
          Xentry_308_symbol  <= ptr_deref_107_request_307_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/$entry
          split_req_310_symbol <= Xentry_308_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/split_req
          ptr_deref_107_gather_scatter_req_0 <= split_req_310_symbol; -- link to DP
          split_ack_311_symbol <= ptr_deref_107_gather_scatter_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/split_ack
          word_access_312: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access 
            signal Xentry_313_symbol: Boolean;
            signal Xexit_314_symbol: Boolean;
            signal word_access_0_315_start : Boolean;
            signal word_access_0_315_symbol : Boolean;
            -- 
          begin -- 
            word_access_312_start <= split_ack_311_symbol; -- control passed to block
            Xentry_313_symbol  <= word_access_312_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/$entry
            word_access_0_315: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/word_access_0 
              signal Xentry_316_symbol: Boolean;
              signal Xexit_317_symbol: Boolean;
              signal rr_318_symbol : Boolean;
              signal ra_319_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_315_start <= Xentry_313_symbol; -- control passed to block
              Xentry_316_symbol  <= word_access_0_315_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/word_access_0/$entry
              rr_318_symbol <= Xentry_316_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/word_access_0/rr
              ptr_deref_107_store_0_req_0 <= rr_318_symbol; -- link to DP
              ra_319_symbol <= ptr_deref_107_store_0_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/word_access_0/ra
              Xexit_317_symbol <= ra_319_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/word_access_0/$exit
              word_access_0_315_symbol <= Xexit_317_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/word_access_0
            Xexit_314_symbol <= word_access_0_315_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access/$exit
            word_access_312_symbol <= Xexit_314_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/word_access
          Xexit_309_symbol <= word_access_312_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request/$exit
          ptr_deref_107_request_307_symbol <= Xexit_309_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_request
        ptr_deref_107_complete_320: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete 
          signal Xentry_321_symbol: Boolean;
          signal Xexit_322_symbol: Boolean;
          signal word_access_323_start : Boolean;
          signal word_access_323_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_107_complete_320_start <= ptr_deref_107_active_x_x303_symbol; -- control passed to block
          Xentry_321_symbol  <= ptr_deref_107_complete_320_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/$entry
          word_access_323: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access 
            signal Xentry_324_symbol: Boolean;
            signal Xexit_325_symbol: Boolean;
            signal word_access_0_326_start : Boolean;
            signal word_access_0_326_symbol : Boolean;
            -- 
          begin -- 
            word_access_323_start <= Xentry_321_symbol; -- control passed to block
            Xentry_324_symbol  <= word_access_323_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/$entry
            word_access_0_326: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/word_access_0 
              signal Xentry_327_symbol: Boolean;
              signal Xexit_328_symbol: Boolean;
              signal cr_329_symbol : Boolean;
              signal ca_330_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_326_start <= Xentry_324_symbol; -- control passed to block
              Xentry_327_symbol  <= word_access_0_326_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/word_access_0/$entry
              cr_329_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/word_access_0/cr
              ptr_deref_107_store_0_req_1 <= cr_329_symbol; -- link to DP
              ca_330_symbol <= ptr_deref_107_store_0_ack_1; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/word_access_0/ca
              Xexit_328_symbol <= ca_330_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/word_access_0/$exit
              word_access_0_326_symbol <= Xexit_328_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/word_access_0
            Xexit_325_symbol <= word_access_0_326_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access/$exit
            word_access_323_symbol <= Xexit_325_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/word_access
          Xexit_322_symbol <= word_access_323_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete/$exit
          ptr_deref_107_complete_320_symbol <= Xexit_322_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_107_complete
        assign_stmt_113_active_x_x331_symbol <= ptr_deref_112_complete_349_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_113_active_
        assign_stmt_113_completed_x_x332_symbol <= assign_stmt_113_active_x_x331_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_113_completed_
        ptr_deref_112_trigger_x_x333_symbol <= ptr_deref_112_word_address_calculated_337_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_trigger_
        ptr_deref_112_active_x_x334_symbol <= ptr_deref_112_request_338_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_active_
        ptr_deref_112_base_address_calculated_335_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_base_address_calculated
        ptr_deref_112_root_address_calculated_336_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_root_address_calculated
        ptr_deref_112_word_address_calculated_337_symbol <= ptr_deref_112_root_address_calculated_336_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_word_address_calculated
        ptr_deref_112_request_338: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request 
          signal Xentry_339_symbol: Boolean;
          signal Xexit_340_symbol: Boolean;
          signal word_access_341_start : Boolean;
          signal word_access_341_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_112_request_338_start <= ptr_deref_112_trigger_x_x333_symbol; -- control passed to block
          Xentry_339_symbol  <= ptr_deref_112_request_338_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/$entry
          word_access_341: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access 
            signal Xentry_342_symbol: Boolean;
            signal Xexit_343_symbol: Boolean;
            signal word_access_0_344_start : Boolean;
            signal word_access_0_344_symbol : Boolean;
            -- 
          begin -- 
            word_access_341_start <= Xentry_339_symbol; -- control passed to block
            Xentry_342_symbol  <= word_access_341_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/$entry
            word_access_0_344: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/word_access_0 
              signal Xentry_345_symbol: Boolean;
              signal Xexit_346_symbol: Boolean;
              signal rr_347_symbol : Boolean;
              signal ra_348_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_344_start <= Xentry_342_symbol; -- control passed to block
              Xentry_345_symbol  <= word_access_0_344_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/word_access_0/$entry
              rr_347_symbol <= Xentry_345_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/word_access_0/rr
              ptr_deref_112_load_0_req_0 <= rr_347_symbol; -- link to DP
              ra_348_symbol <= ptr_deref_112_load_0_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/word_access_0/ra
              Xexit_346_symbol <= ra_348_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/word_access_0/$exit
              word_access_0_344_symbol <= Xexit_346_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/word_access_0
            Xexit_343_symbol <= word_access_0_344_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access/$exit
            word_access_341_symbol <= Xexit_343_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/word_access
          Xexit_340_symbol <= word_access_341_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request/$exit
          ptr_deref_112_request_338_symbol <= Xexit_340_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_request
        ptr_deref_112_complete_349: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete 
          signal Xentry_350_symbol: Boolean;
          signal Xexit_351_symbol: Boolean;
          signal word_access_352_start : Boolean;
          signal word_access_352_symbol : Boolean;
          signal merge_req_360_symbol : Boolean;
          signal merge_ack_361_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_112_complete_349_start <= ptr_deref_112_active_x_x334_symbol; -- control passed to block
          Xentry_350_symbol  <= ptr_deref_112_complete_349_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/$entry
          word_access_352: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access 
            signal Xentry_353_symbol: Boolean;
            signal Xexit_354_symbol: Boolean;
            signal word_access_0_355_start : Boolean;
            signal word_access_0_355_symbol : Boolean;
            -- 
          begin -- 
            word_access_352_start <= Xentry_350_symbol; -- control passed to block
            Xentry_353_symbol  <= word_access_352_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/$entry
            word_access_0_355: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/word_access_0 
              signal Xentry_356_symbol: Boolean;
              signal Xexit_357_symbol: Boolean;
              signal cr_358_symbol : Boolean;
              signal ca_359_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_355_start <= Xentry_353_symbol; -- control passed to block
              Xentry_356_symbol  <= word_access_0_355_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/word_access_0/$entry
              cr_358_symbol <= Xentry_356_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/word_access_0/cr
              ptr_deref_112_load_0_req_1 <= cr_358_symbol; -- link to DP
              ca_359_symbol <= ptr_deref_112_load_0_ack_1; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/word_access_0/ca
              Xexit_357_symbol <= ca_359_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/word_access_0/$exit
              word_access_0_355_symbol <= Xexit_357_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/word_access_0
            Xexit_354_symbol <= word_access_0_355_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access/$exit
            word_access_352_symbol <= Xexit_354_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/word_access
          merge_req_360_symbol <= word_access_352_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/merge_req
          ptr_deref_112_gather_scatter_req_0 <= merge_req_360_symbol; -- link to DP
          merge_ack_361_symbol <= ptr_deref_112_gather_scatter_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/merge_ack
          Xexit_351_symbol <= merge_ack_361_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete/$exit
          ptr_deref_112_complete_349_symbol <= Xexit_351_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_112_complete
        assign_stmt_117_active_x_x362_symbol <= ptr_deref_116_complete_380_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_117_active_
        assign_stmt_117_completed_x_x363_symbol <= assign_stmt_117_active_x_x362_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_117_completed_
        ptr_deref_116_trigger_x_x364_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_trigger_ 
          signal ptr_deref_116_trigger_x_x364_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_116_trigger_x_x364_predecessors(0) <= ptr_deref_116_word_address_calculated_368_symbol;
          ptr_deref_116_trigger_x_x364_predecessors(1) <= ptr_deref_107_active_x_x303_symbol;
          ptr_deref_116_trigger_x_x364_join: join -- 
            port map( -- 
              preds => ptr_deref_116_trigger_x_x364_predecessors,
              symbol_out => ptr_deref_116_trigger_x_x364_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_trigger_
        ptr_deref_116_active_x_x365_symbol <= ptr_deref_116_request_369_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_active_
        ptr_deref_116_base_address_calculated_366_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_base_address_calculated
        ptr_deref_116_root_address_calculated_367_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_root_address_calculated
        ptr_deref_116_word_address_calculated_368_symbol <= ptr_deref_116_root_address_calculated_367_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_word_address_calculated
        ptr_deref_116_request_369: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request 
          signal Xentry_370_symbol: Boolean;
          signal Xexit_371_symbol: Boolean;
          signal word_access_372_start : Boolean;
          signal word_access_372_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_116_request_369_start <= ptr_deref_116_trigger_x_x364_symbol; -- control passed to block
          Xentry_370_symbol  <= ptr_deref_116_request_369_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/$entry
          word_access_372: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access 
            signal Xentry_373_symbol: Boolean;
            signal Xexit_374_symbol: Boolean;
            signal word_access_0_375_start : Boolean;
            signal word_access_0_375_symbol : Boolean;
            -- 
          begin -- 
            word_access_372_start <= Xentry_370_symbol; -- control passed to block
            Xentry_373_symbol  <= word_access_372_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/$entry
            word_access_0_375: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/word_access_0 
              signal Xentry_376_symbol: Boolean;
              signal Xexit_377_symbol: Boolean;
              signal rr_378_symbol : Boolean;
              signal ra_379_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_375_start <= Xentry_373_symbol; -- control passed to block
              Xentry_376_symbol  <= word_access_0_375_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/word_access_0/$entry
              rr_378_symbol <= Xentry_376_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/word_access_0/rr
              ptr_deref_116_load_0_req_0 <= rr_378_symbol; -- link to DP
              ra_379_symbol <= ptr_deref_116_load_0_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/word_access_0/ra
              Xexit_377_symbol <= ra_379_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/word_access_0/$exit
              word_access_0_375_symbol <= Xexit_377_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/word_access_0
            Xexit_374_symbol <= word_access_0_375_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access/$exit
            word_access_372_symbol <= Xexit_374_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/word_access
          Xexit_371_symbol <= word_access_372_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request/$exit
          ptr_deref_116_request_369_symbol <= Xexit_371_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_request
        ptr_deref_116_complete_380: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete 
          signal Xentry_381_symbol: Boolean;
          signal Xexit_382_symbol: Boolean;
          signal word_access_383_start : Boolean;
          signal word_access_383_symbol : Boolean;
          signal merge_req_391_symbol : Boolean;
          signal merge_ack_392_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_116_complete_380_start <= ptr_deref_116_active_x_x365_symbol; -- control passed to block
          Xentry_381_symbol  <= ptr_deref_116_complete_380_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/$entry
          word_access_383: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access 
            signal Xentry_384_symbol: Boolean;
            signal Xexit_385_symbol: Boolean;
            signal word_access_0_386_start : Boolean;
            signal word_access_0_386_symbol : Boolean;
            -- 
          begin -- 
            word_access_383_start <= Xentry_381_symbol; -- control passed to block
            Xentry_384_symbol  <= word_access_383_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/$entry
            word_access_0_386: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/word_access_0 
              signal Xentry_387_symbol: Boolean;
              signal Xexit_388_symbol: Boolean;
              signal cr_389_symbol : Boolean;
              signal ca_390_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_386_start <= Xentry_384_symbol; -- control passed to block
              Xentry_387_symbol  <= word_access_0_386_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/word_access_0/$entry
              cr_389_symbol <= Xentry_387_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/word_access_0/cr
              ptr_deref_116_load_0_req_1 <= cr_389_symbol; -- link to DP
              ca_390_symbol <= ptr_deref_116_load_0_ack_1; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/word_access_0/ca
              Xexit_388_symbol <= ca_390_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/word_access_0/$exit
              word_access_0_386_symbol <= Xexit_388_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/word_access_0
            Xexit_385_symbol <= word_access_0_386_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access/$exit
            word_access_383_symbol <= Xexit_385_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/word_access
          merge_req_391_symbol <= word_access_383_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/merge_req
          ptr_deref_116_gather_scatter_req_0 <= merge_req_391_symbol; -- link to DP
          merge_ack_392_symbol <= ptr_deref_116_gather_scatter_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/merge_ack
          Xexit_382_symbol <= merge_ack_392_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete/$exit
          ptr_deref_116_complete_380_symbol <= Xexit_382_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/ptr_deref_116_complete
        assign_stmt_122_active_x_x393_symbol <= binary_121_complete_399_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_122_active_
        assign_stmt_122_completed_x_x394_symbol <= assign_stmt_122_active_x_x393_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/assign_stmt_122_completed_
        binary_121_active_x_x395_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_active_ 
          signal binary_121_active_x_x395_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_121_active_x_x395_predecessors(0) <= binary_121_trigger_x_x396_symbol;
          binary_121_active_x_x395_predecessors(1) <= simple_obj_ref_119_complete_397_symbol;
          binary_121_active_x_x395_predecessors(2) <= simple_obj_ref_120_complete_398_symbol;
          binary_121_active_x_x395_join: join -- 
            port map( -- 
              preds => binary_121_active_x_x395_predecessors,
              symbol_out => binary_121_active_x_x395_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_active_
        binary_121_trigger_x_x396_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_trigger_
        simple_obj_ref_119_complete_397_symbol <= assign_stmt_113_completed_x_x332_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/simple_obj_ref_119_complete
        simple_obj_ref_120_complete_398_symbol <= assign_stmt_117_completed_x_x363_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/simple_obj_ref_120_complete
        binary_121_complete_399: Block -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete 
          signal Xentry_400_symbol: Boolean;
          signal Xexit_401_symbol: Boolean;
          signal rr_402_symbol : Boolean;
          signal ra_403_symbol : Boolean;
          signal cr_404_symbol : Boolean;
          signal ca_405_symbol : Boolean;
          -- 
        begin -- 
          binary_121_complete_399_start <= binary_121_active_x_x395_symbol; -- control passed to block
          Xentry_400_symbol  <= binary_121_complete_399_start; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete/$entry
          rr_402_symbol <= Xentry_400_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete/rr
          binary_121_inst_req_0 <= rr_402_symbol; -- link to DP
          ra_403_symbol <= binary_121_inst_ack_0; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete/ra
          cr_404_symbol <= ra_403_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete/cr
          binary_121_inst_req_1 <= cr_404_symbol; -- link to DP
          ca_405_symbol <= binary_121_inst_ack_1; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete/ca
          Xexit_401_symbol <= ca_405_symbol; -- transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete/$exit
          binary_121_complete_399_symbol <= Xexit_401_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/binary_121_complete
        Xexit_298_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/$exit 
          signal Xexit_298_predecessors: BooleanArray(4 downto 0);
          -- 
        begin -- 
          Xexit_298_predecessors(0) <= assign_stmt_109_completed_x_x300_symbol;
          Xexit_298_predecessors(1) <= ptr_deref_107_base_address_calculated_304_symbol;
          Xexit_298_predecessors(2) <= ptr_deref_112_base_address_calculated_335_symbol;
          Xexit_298_predecessors(3) <= ptr_deref_116_base_address_calculated_366_symbol;
          Xexit_298_predecessors(4) <= assign_stmt_122_completed_x_x394_symbol;
          Xexit_298_join: join -- 
            port map( -- 
              preds => Xexit_298_predecessors,
              symbol_out => Xexit_298_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122/$exit
        assign_stmt_109_to_assign_stmt_122_296_symbol <= Xexit_298_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/assign_stmt_109_to_assign_stmt_122
      assign_stmt_125_406: Block -- branch_block_stmt_88/assign_stmt_125 
        signal Xentry_407_symbol: Boolean;
        signal Xexit_408_symbol: Boolean;
        signal assign_stmt_125_active_x_x409_symbol : Boolean;
        signal assign_stmt_125_completed_x_x410_symbol : Boolean;
        signal simple_obj_ref_124_complete_411_symbol : Boolean;
        signal simple_obj_ref_123_trigger_x_x412_symbol : Boolean;
        signal simple_obj_ref_123_complete_413_start : Boolean;
        signal simple_obj_ref_123_complete_413_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_125_406_start <= assign_stmt_125_x_xentry_x_xx_x244_symbol; -- control passed to block
        Xentry_407_symbol  <= assign_stmt_125_406_start; -- transition branch_block_stmt_88/assign_stmt_125/$entry
        assign_stmt_125_active_x_x409_symbol <= simple_obj_ref_124_complete_411_symbol; -- transition branch_block_stmt_88/assign_stmt_125/assign_stmt_125_active_
        assign_stmt_125_completed_x_x410_symbol <= simple_obj_ref_123_complete_413_symbol; -- transition branch_block_stmt_88/assign_stmt_125/assign_stmt_125_completed_
        simple_obj_ref_124_complete_411_symbol <= Xentry_407_symbol; -- transition branch_block_stmt_88/assign_stmt_125/simple_obj_ref_124_complete
        simple_obj_ref_123_trigger_x_x412_symbol <= assign_stmt_125_active_x_x409_symbol; -- transition branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_trigger_
        simple_obj_ref_123_complete_413: Block -- branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_complete 
          signal Xentry_414_symbol: Boolean;
          signal Xexit_415_symbol: Boolean;
          signal pipe_wreq_416_symbol : Boolean;
          signal pipe_wack_417_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_123_complete_413_start <= simple_obj_ref_123_trigger_x_x412_symbol; -- control passed to block
          Xentry_414_symbol  <= simple_obj_ref_123_complete_413_start; -- transition branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_complete/$entry
          pipe_wreq_416_symbol <= Xentry_414_symbol; -- transition branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_complete/pipe_wreq
          simple_obj_ref_123_inst_req_0 <= pipe_wreq_416_symbol; -- link to DP
          pipe_wack_417_symbol <= simple_obj_ref_123_inst_ack_0; -- transition branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_complete/pipe_wack
          Xexit_415_symbol <= pipe_wack_417_symbol; -- transition branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_complete/$exit
          simple_obj_ref_123_complete_413_symbol <= Xexit_415_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_125/simple_obj_ref_123_complete
        Xexit_408_symbol <= assign_stmt_125_completed_x_x410_symbol; -- transition branch_block_stmt_88/assign_stmt_125/$exit
        assign_stmt_125_406_symbol <= Xexit_408_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/assign_stmt_125
      assign_stmt_129_418: Block -- branch_block_stmt_88/assign_stmt_129 
        signal Xentry_419_symbol: Boolean;
        signal Xexit_420_symbol: Boolean;
        signal assign_stmt_129_active_x_x421_symbol : Boolean;
        signal assign_stmt_129_completed_x_x422_symbol : Boolean;
        signal ptr_deref_128_trigger_x_x423_symbol : Boolean;
        signal ptr_deref_128_active_x_x424_symbol : Boolean;
        signal ptr_deref_128_base_address_calculated_425_symbol : Boolean;
        signal ptr_deref_128_root_address_calculated_426_symbol : Boolean;
        signal ptr_deref_128_word_address_calculated_427_symbol : Boolean;
        signal ptr_deref_128_request_428_start : Boolean;
        signal ptr_deref_128_request_428_symbol : Boolean;
        signal ptr_deref_128_complete_439_start : Boolean;
        signal ptr_deref_128_complete_439_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_129_418_start <= assign_stmt_129_x_xentry_x_xx_x246_symbol; -- control passed to block
        Xentry_419_symbol  <= assign_stmt_129_418_start; -- transition branch_block_stmt_88/assign_stmt_129/$entry
        assign_stmt_129_active_x_x421_symbol <= ptr_deref_128_complete_439_symbol; -- transition branch_block_stmt_88/assign_stmt_129/assign_stmt_129_active_
        assign_stmt_129_completed_x_x422_symbol <= assign_stmt_129_active_x_x421_symbol; -- transition branch_block_stmt_88/assign_stmt_129/assign_stmt_129_completed_
        ptr_deref_128_trigger_x_x423_symbol <= ptr_deref_128_word_address_calculated_427_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_trigger_
        ptr_deref_128_active_x_x424_symbol <= ptr_deref_128_request_428_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_active_
        ptr_deref_128_base_address_calculated_425_symbol <= Xentry_419_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_base_address_calculated
        ptr_deref_128_root_address_calculated_426_symbol <= Xentry_419_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_root_address_calculated
        ptr_deref_128_word_address_calculated_427_symbol <= ptr_deref_128_root_address_calculated_426_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_word_address_calculated
        ptr_deref_128_request_428: Block -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request 
          signal Xentry_429_symbol: Boolean;
          signal Xexit_430_symbol: Boolean;
          signal word_access_431_start : Boolean;
          signal word_access_431_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_128_request_428_start <= ptr_deref_128_trigger_x_x423_symbol; -- control passed to block
          Xentry_429_symbol  <= ptr_deref_128_request_428_start; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/$entry
          word_access_431: Block -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access 
            signal Xentry_432_symbol: Boolean;
            signal Xexit_433_symbol: Boolean;
            signal word_access_0_434_start : Boolean;
            signal word_access_0_434_symbol : Boolean;
            -- 
          begin -- 
            word_access_431_start <= Xentry_429_symbol; -- control passed to block
            Xentry_432_symbol  <= word_access_431_start; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/$entry
            word_access_0_434: Block -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/word_access_0 
              signal Xentry_435_symbol: Boolean;
              signal Xexit_436_symbol: Boolean;
              signal rr_437_symbol : Boolean;
              signal ra_438_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_434_start <= Xentry_432_symbol; -- control passed to block
              Xentry_435_symbol  <= word_access_0_434_start; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/word_access_0/$entry
              rr_437_symbol <= Xentry_435_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/word_access_0/rr
              ptr_deref_128_load_0_req_0 <= rr_437_symbol; -- link to DP
              ra_438_symbol <= ptr_deref_128_load_0_ack_0; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/word_access_0/ra
              Xexit_436_symbol <= ra_438_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/word_access_0/$exit
              word_access_0_434_symbol <= Xexit_436_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/word_access_0
            Xexit_433_symbol <= word_access_0_434_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access/$exit
            word_access_431_symbol <= Xexit_433_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/word_access
          Xexit_430_symbol <= word_access_431_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request/$exit
          ptr_deref_128_request_428_symbol <= Xexit_430_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_request
        ptr_deref_128_complete_439: Block -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete 
          signal Xentry_440_symbol: Boolean;
          signal Xexit_441_symbol: Boolean;
          signal word_access_442_start : Boolean;
          signal word_access_442_symbol : Boolean;
          signal merge_req_450_symbol : Boolean;
          signal merge_ack_451_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_128_complete_439_start <= ptr_deref_128_active_x_x424_symbol; -- control passed to block
          Xentry_440_symbol  <= ptr_deref_128_complete_439_start; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/$entry
          word_access_442: Block -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access 
            signal Xentry_443_symbol: Boolean;
            signal Xexit_444_symbol: Boolean;
            signal word_access_0_445_start : Boolean;
            signal word_access_0_445_symbol : Boolean;
            -- 
          begin -- 
            word_access_442_start <= Xentry_440_symbol; -- control passed to block
            Xentry_443_symbol  <= word_access_442_start; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/$entry
            word_access_0_445: Block -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/word_access_0 
              signal Xentry_446_symbol: Boolean;
              signal Xexit_447_symbol: Boolean;
              signal cr_448_symbol : Boolean;
              signal ca_449_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_445_start <= Xentry_443_symbol; -- control passed to block
              Xentry_446_symbol  <= word_access_0_445_start; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/word_access_0/$entry
              cr_448_symbol <= Xentry_446_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/word_access_0/cr
              ptr_deref_128_load_0_req_1 <= cr_448_symbol; -- link to DP
              ca_449_symbol <= ptr_deref_128_load_0_ack_1; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/word_access_0/ca
              Xexit_447_symbol <= ca_449_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/word_access_0/$exit
              word_access_0_445_symbol <= Xexit_447_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/word_access_0
            Xexit_444_symbol <= word_access_0_445_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access/$exit
            word_access_442_symbol <= Xexit_444_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/word_access
          merge_req_450_symbol <= word_access_442_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/merge_req
          ptr_deref_128_gather_scatter_req_0 <= merge_req_450_symbol; -- link to DP
          merge_ack_451_symbol <= ptr_deref_128_gather_scatter_ack_0; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/merge_ack
          Xexit_441_symbol <= merge_ack_451_symbol; -- transition branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete/$exit
          ptr_deref_128_complete_439_symbol <= Xexit_441_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_88/assign_stmt_129/ptr_deref_128_complete
        Xexit_420_block : Block -- non-trivial join transition branch_block_stmt_88/assign_stmt_129/$exit 
          signal Xexit_420_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_420_predecessors(0) <= assign_stmt_129_completed_x_x422_symbol;
          Xexit_420_predecessors(1) <= ptr_deref_128_base_address_calculated_425_symbol;
          Xexit_420_join: join -- 
            port map( -- 
              preds => Xexit_420_predecessors,
              symbol_out => Xexit_420_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_88/assign_stmt_129/$exit
        assign_stmt_129_418_symbol <= Xexit_420_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/assign_stmt_129
      return_x_xx_xPhiReq_452: Block -- branch_block_stmt_88/return___PhiReq 
        signal Xentry_453_symbol: Boolean;
        signal Xexit_454_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_452_start <= return_x_xx_x248_symbol; -- control passed to block
        Xentry_453_symbol  <= return_x_xx_xPhiReq_452_start; -- transition branch_block_stmt_88/return___PhiReq/$entry
        Xexit_454_symbol <= Xentry_453_symbol; -- transition branch_block_stmt_88/return___PhiReq/$exit
        return_x_xx_xPhiReq_452_symbol <= Xexit_454_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/return___PhiReq
      merge_stmt_131_PhiReqMerge_455_symbol  <=  return_x_xx_xPhiReq_452_symbol; -- place branch_block_stmt_88/merge_stmt_131_PhiReqMerge (optimized away) 
      merge_stmt_131_PhiAck_456: Block -- branch_block_stmt_88/merge_stmt_131_PhiAck 
        signal Xentry_457_symbol: Boolean;
        signal Xexit_458_symbol: Boolean;
        signal dummy_459_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_131_PhiAck_456_start <= merge_stmt_131_PhiReqMerge_455_symbol; -- control passed to block
        Xentry_457_symbol  <= merge_stmt_131_PhiAck_456_start; -- transition branch_block_stmt_88/merge_stmt_131_PhiAck/$entry
        dummy_459_symbol <= Xentry_457_symbol; -- transition branch_block_stmt_88/merge_stmt_131_PhiAck/dummy
        Xexit_458_symbol <= dummy_459_symbol; -- transition branch_block_stmt_88/merge_stmt_131_PhiAck/$exit
        merge_stmt_131_PhiAck_456_symbol <= Xexit_458_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_88/merge_stmt_131_PhiAck
      Xexit_235_symbol <= branch_block_stmt_88_x_xexit_x_xx_x237_symbol; -- transition branch_block_stmt_88/$exit
      branch_block_stmt_88_233_symbol <= Xexit_235_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_88
    Xexit_232_symbol <= branch_block_stmt_88_233_symbol; -- transition $exit
    fin_ack_symbol_join : Block -- non-trivial join transition fin_ack_symbol 
      signal fin_ack_symbol_predecessors: BooleanArray(1 downto 0);
      -- 
    begin -- 
      fin_ack_symbol_predecessors <= Xexit_232_symbol & fin_req_symbol;
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
    signal b_98 : std_logic_vector(31 downto 0);
    signal iNsTr_0_94 : std_logic_vector(31 downto 0);
    signal iNsTr_3_105 : std_logic_vector(31 downto 0);
    signal iNsTr_5_113 : std_logic_vector(31 downto 0);
    signal iNsTr_6_117 : std_logic_vector(31 downto 0);
    signal iNsTr_7_122 : std_logic_vector(31 downto 0);
    signal ptr_deref_100_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_100_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_100_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_107_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_107_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_107_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_112_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_112_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_116_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_116_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_128_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_128_word_address_0 : std_logic_vector(0 downto 0);
    signal xxfooxxbodyxxb_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxfooxxbodyxxiNsTr_0_alloc_base_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    b_98 <= "00000000000000000000000000000000";
    iNsTr_0_94 <= "00000000000000000000000000000000";
    ptr_deref_100_word_address_0 <= "0";
    ptr_deref_107_word_address_0 <= "0";
    ptr_deref_112_word_address_0 <= "0";
    ptr_deref_116_word_address_0 <= "0";
    ptr_deref_128_word_address_0 <= "0";
    xxfooxxbodyxxb_alloc_base_address <= "0";
    xxfooxxbodyxxiNsTr_0_alloc_base_address <= "0";
    ptr_deref_100_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_100_gather_scatter_ack_0 <= ptr_deref_100_gather_scatter_req_0;
      aggregated_sig <= a;
      ptr_deref_100_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_107_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_107_gather_scatter_ack_0 <= ptr_deref_107_gather_scatter_req_0;
      aggregated_sig <= iNsTr_3_105;
      ptr_deref_107_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_112_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_112_gather_scatter_ack_0 <= ptr_deref_112_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_112_data_0;
      iNsTr_5_113 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_116_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_116_gather_scatter_ack_0 <= ptr_deref_116_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_116_data_0;
      iNsTr_6_117 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_128_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_128_gather_scatter_ack_0 <= ptr_deref_128_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_128_data_0;
      ret_val_x_x_buffer <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_121_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_113 & iNsTr_6_117;
      iNsTr_7_122 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAdd",
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
          reqL => binary_121_inst_req_0,
          ackL => binary_121_inst_ack_0,
          reqR => binary_121_inst_req_1,
          ackR => binary_121_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared load operator group (0) : ptr_deref_112_load_0 ptr_deref_128_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_112_load_0_req_0;
      reqL(0) <= ptr_deref_128_load_0_req_0;
      ptr_deref_112_load_0_ack_0 <= ackL(1);
      ptr_deref_128_load_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_112_load_0_req_1;
      reqR(0) <= ptr_deref_128_load_0_req_1;
      ptr_deref_112_load_0_ack_1 <= ackR(1);
      ptr_deref_128_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_112_word_address_0 & ptr_deref_128_word_address_0;
      ptr_deref_112_data_0 <= data_out(63 downto 32);
      ptr_deref_128_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_6_lr_req(0),
          mack => memory_space_6_lr_ack(0),
          maddr => memory_space_6_lr_addr(0 downto 0),
          mtag => memory_space_6_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_6_lc_req(0),
          mack => memory_space_6_lc_ack(0),
          mdata => memory_space_6_lc_data(31 downto 0),
          mtag => memory_space_6_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_116_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_116_load_0_req_0;
      ptr_deref_116_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_116_load_0_req_1;
      ptr_deref_116_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_116_word_address_0;
      ptr_deref_116_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1, min_clock_period => true,
        no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_7_lr_req(0),
          mack => memory_space_7_lr_ack(0),
          maddr => memory_space_7_lr_addr(0 downto 0),
          mtag => memory_space_7_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_7_lc_req(0),
          mack => memory_space_7_lc_ack(0),
          mdata => memory_space_7_lc_data(31 downto 0),
          mtag => memory_space_7_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared store operator group (0) : ptr_deref_100_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_100_store_0_req_0;
      ptr_deref_100_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_100_store_0_req_1;
      ptr_deref_100_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_100_word_address_0;
      data_in <= ptr_deref_100_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        min_clock_period => true,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_6_sr_req(0),
          mack => memory_space_6_sr_ack(0),
          maddr => memory_space_6_sr_addr(0 downto 0),
          mdata => memory_space_6_sr_data(31 downto 0),
          mtag => memory_space_6_sr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 1,
          tag_length => 2 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_6_sc_req(0),
          mack => memory_space_6_sc_ack(0),
          mtag => memory_space_6_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_107_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_107_store_0_req_0;
      ptr_deref_107_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_107_store_0_req_1;
      ptr_deref_107_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_107_word_address_0;
      data_in <= ptr_deref_107_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        min_clock_period => true,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_7_sr_req(0),
          mack => memory_space_7_sr_ack(0),
          maddr => memory_space_7_sr_addr(0 downto 0),
          mdata => memory_space_7_sr_data(31 downto 0),
          mtag => memory_space_7_sr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 1,
          tag_length => 1 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_7_sc_req(0),
          mack => memory_space_7_sc_ack(0),
          mtag => memory_space_7_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared inport operator group (0) : simple_obj_ref_104_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_104_inst_req_0;
      simple_obj_ref_104_inst_ack_0 <= ack(0);
      iNsTr_3_105 <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => inpipe_pipe_read_req(0),
          oack => inpipe_pipe_read_ack(0),
          odata => inpipe_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_123_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_123_inst_req_0;
      simple_obj_ref_123_inst_ack_0 <= ack(0);
      data_in <= iNsTr_7_122;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => midpipe_pipe_write_req(0),
          oack => midpipe_pipe_write_ack(0),
          odata => midpipe_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- 
  end Block; -- data_path
  RegisterBank_memory_space_6: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 2,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_6_lr_addr,
      lr_req_in => memory_space_6_lr_req,
      lr_ack_out => memory_space_6_lr_ack,
      lr_tag_in => memory_space_6_lr_tag,
      lc_req_in => memory_space_6_lc_req,
      lc_ack_out => memory_space_6_lc_ack,
      lc_data_out => memory_space_6_lc_data,
      lc_tag_out => memory_space_6_lc_tag,
      sr_addr_in => memory_space_6_sr_addr,
      sr_data_in => memory_space_6_sr_data,
      sr_req_in => memory_space_6_sr_req,
      sr_ack_out => memory_space_6_sr_ack,
      sr_tag_in => memory_space_6_sr_tag,
      sc_req_in=> memory_space_6_sc_req,
      sc_ack_out => memory_space_6_sc_ack,
      sc_tag_out => memory_space_6_sc_tag,
      clock => clk,
      reset => reset); -- 
  RegisterBank_memory_space_7: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_7_lr_addr,
      lr_req_in => memory_space_7_lr_req,
      lr_ack_out => memory_space_7_lr_ack,
      lr_tag_in => memory_space_7_lr_tag,
      lc_req_in => memory_space_7_lc_req,
      lc_ack_out => memory_space_7_lc_ack,
      lc_data_out => memory_space_7_lc_data,
      lc_tag_out => memory_space_7_lc_tag,
      sr_addr_in => memory_space_7_sr_addr,
      sr_data_in => memory_space_7_sr_data,
      sr_req_in => memory_space_7_sr_req,
      sr_ack_out => memory_space_7_sr_ack,
      sr_tag_in => memory_space_7_sr_tag,
      sc_req_in=> memory_space_7_sc_req,
      sc_ack_out => memory_space_7_sc_ack,
      sc_tag_out => memory_space_7_sc_tag,
      clock => clk,
      reset => reset); -- 
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
entity test_system is  -- system 
  port (-- 
    bar_a : in  std_logic_vector(31 downto 0);
    bar_ret_val_x_x : out  std_logic_vector(31 downto 0);
    bar_tag_in: in std_logic_vector(0 downto 0);
    bar_tag_out: out std_logic_vector(0 downto 0);
    bar_start_req : in std_logic;
    bar_start_ack : out std_logic;
    bar_fin_req   : in std_logic;
    bar_fin_ack   : out std_logic;
    foo_a : in  std_logic_vector(31 downto 0);
    foo_ret_val_x_x : out  std_logic_vector(31 downto 0);
    foo_tag_in: in std_logic_vector(0 downto 0);
    foo_tag_out: out std_logic_vector(0 downto 0);
    foo_start_req : in std_logic;
    foo_start_ack : out std_logic;
    foo_fin_req   : in std_logic;
    foo_fin_ack   : out std_logic;
    clk : in std_logic;
    reset : in std_logic;
    inpipe_pipe_write_data: in std_logic_vector(31 downto 0);
    inpipe_pipe_write_req : in std_logic_vector(0 downto 0);
    inpipe_pipe_write_ack : out std_logic_vector(0 downto 0);
    outpipe_pipe_read_data: out std_logic_vector(31 downto 0);
    outpipe_pipe_read_req : in std_logic_vector(0 downto 0);
    outpipe_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
  -- 
end entity; 
architecture Default of test_system is -- system-architecture 
  -- interface signals to connect to memory space memory_space_0
  -- declarations related to module bar
  component bar is -- 
    generic (tag_length : integer); 
    port ( -- 
      a : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      midpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
      midpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
      midpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
      outpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      outpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      outpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- declarations related to module foo
  component foo is -- 
    generic (tag_length : integer); 
    port ( -- 
      a : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start_req : in std_logic;
      start_ack : out std_logic;
      fin_req : in std_logic;
      fin_ack   : out std_logic;
      inpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
      inpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
      inpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
      midpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      midpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      midpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(tag_length-1 downto 0);
      tag_out: out std_logic_vector(tag_length-1 downto 0) -- 
    );
    -- 
  end component;
  -- aggregate signals for read from pipe inpipe
  signal inpipe_pipe_read_data: std_logic_vector(31 downto 0);
  signal inpipe_pipe_read_req: std_logic_vector(0 downto 0);
  signal inpipe_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe midpipe
  signal midpipe_pipe_write_data: std_logic_vector(31 downto 0);
  signal midpipe_pipe_write_req: std_logic_vector(0 downto 0);
  signal midpipe_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe midpipe
  signal midpipe_pipe_read_data: std_logic_vector(31 downto 0);
  signal midpipe_pipe_read_req: std_logic_vector(0 downto 0);
  signal midpipe_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe outpipe
  signal outpipe_pipe_write_data: std_logic_vector(31 downto 0);
  signal outpipe_pipe_write_req: std_logic_vector(0 downto 0);
  signal outpipe_pipe_write_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module bar
  bar_instance:bar-- 
    generic map(tag_length => 1)
    port map(-- 
      a => bar_a,
      ret_val_x_x => bar_ret_val_x_x,
      start_req => bar_start_req,
      start_ack => bar_start_ack,
      fin_req => bar_fin_req,
      fin_ack => bar_fin_ack,
      clk => clk,
      reset => reset,
      midpipe_pipe_read_req => midpipe_pipe_read_req(0 downto 0),
      midpipe_pipe_read_ack => midpipe_pipe_read_ack(0 downto 0),
      midpipe_pipe_read_data => midpipe_pipe_read_data(31 downto 0),
      outpipe_pipe_write_req => outpipe_pipe_write_req(0 downto 0),
      outpipe_pipe_write_ack => outpipe_pipe_write_ack(0 downto 0),
      outpipe_pipe_write_data => outpipe_pipe_write_data(31 downto 0),
      tag_in => bar_tag_in,
      tag_out => bar_tag_out-- 
    ); -- 
  -- module foo
  foo_instance:foo-- 
    generic map(tag_length => 1)
    port map(-- 
      a => foo_a,
      ret_val_x_x => foo_ret_val_x_x,
      start_req => foo_start_req,
      start_ack => foo_start_ack,
      fin_req => foo_fin_req,
      fin_ack => foo_fin_ack,
      clk => clk,
      reset => reset,
      inpipe_pipe_read_req => inpipe_pipe_read_req(0 downto 0),
      inpipe_pipe_read_ack => inpipe_pipe_read_ack(0 downto 0),
      inpipe_pipe_read_data => inpipe_pipe_read_data(31 downto 0),
      midpipe_pipe_write_req => midpipe_pipe_write_req(0 downto 0),
      midpipe_pipe_write_ack => midpipe_pipe_write_ack(0 downto 0),
      midpipe_pipe_write_data => midpipe_pipe_write_data(31 downto 0),
      tag_in => foo_tag_in,
      tag_out => foo_tag_out-- 
    ); -- 
  inpipe_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => inpipe_pipe_read_req,
      read_ack => inpipe_pipe_read_ack,
      read_data => inpipe_pipe_read_data,
      write_req => inpipe_pipe_write_req,
      write_ack => inpipe_pipe_write_ack,
      write_data => inpipe_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  midpipe_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => midpipe_pipe_read_req,
      read_ack => midpipe_pipe_read_ack,
      read_data => midpipe_pipe_read_data,
      write_req => midpipe_pipe_write_req,
      write_ack => midpipe_pipe_write_ack,
      write_data => midpipe_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  outpipe_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => outpipe_pipe_read_req,
      read_ack => outpipe_pipe_read_ack,
      read_data => outpipe_pipe_read_data,
      write_req => outpipe_pipe_write_req,
      write_ack => outpipe_pipe_write_ack,
      write_data => outpipe_pipe_write_data,
      clk => clk,reset => reset -- 
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
use ahir.utilities.all;
library work;
use work.vc_system_package.all;
use work.Utility_Package.all;
use work.Vhpi_Foreign.all;
entity test_system_Test_Bench is -- 
  -- 
end entity;
architecture VhpiLink of test_system_Test_Bench is -- 
  component test_system is -- 
    port (-- 
      bar_a : in  std_logic_vector(31 downto 0);
      bar_ret_val_x_x : out  std_logic_vector(31 downto 0);
      bar_tag_in: in std_logic_vector(0 downto 0);
      bar_tag_out: out std_logic_vector(0 downto 0);
      bar_start_req : in std_logic;
      bar_start_ack : out std_logic;
      bar_fin_req   : in std_logic;
      bar_fin_ack   : out std_logic;
      foo_a : in  std_logic_vector(31 downto 0);
      foo_ret_val_x_x : out  std_logic_vector(31 downto 0);
      foo_tag_in: in std_logic_vector(0 downto 0);
      foo_tag_out: out std_logic_vector(0 downto 0);
      foo_start_req : in std_logic;
      foo_start_ack : out std_logic;
      foo_fin_req   : in std_logic;
      foo_fin_ack   : out std_logic;
      clk : in std_logic;
      reset : in std_logic;
      inpipe_pipe_write_data: in std_logic_vector(31 downto 0);
      inpipe_pipe_write_req : in std_logic_vector(0 downto 0);
      inpipe_pipe_write_ack : out std_logic_vector(0 downto 0);
      outpipe_pipe_read_data: out std_logic_vector(31 downto 0);
      outpipe_pipe_read_req : in std_logic_vector(0 downto 0);
      outpipe_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal bar_a :  std_logic_vector(31 downto 0) := (others => '0');
  signal bar_ret_val_x_x :   std_logic_vector(31 downto 0);
  signal bar_tag_in: std_logic_vector(0 downto 0);
  signal bar_tag_out: std_logic_vector(0 downto 0);
  signal bar_start_req : std_logic := '0';
  signal bar_start_ack : std_logic := '0';
  signal bar_fin_req   : std_logic := '0';
  signal bar_fin_ack   : std_logic := '0';
  signal foo_a :  std_logic_vector(31 downto 0) := (others => '0');
  signal foo_ret_val_x_x :   std_logic_vector(31 downto 0);
  signal foo_tag_in: std_logic_vector(0 downto 0);
  signal foo_tag_out: std_logic_vector(0 downto 0);
  signal foo_start_req : std_logic := '0';
  signal foo_start_ack : std_logic := '0';
  signal foo_fin_req   : std_logic := '0';
  signal foo_fin_ack   : std_logic := '0';
  -- write to pipe inpipe
  signal inpipe_pipe_write_data: std_logic_vector(31 downto 0);
  signal inpipe_pipe_write_req : std_logic_vector(0 downto 0) := (others => '0');
  signal inpipe_pipe_write_ack : std_logic_vector(0 downto 0);
  -- read from pipe outpipe
  signal outpipe_pipe_read_data: std_logic_vector(31 downto 0);
  signal outpipe_pipe_read_req : std_logic_vector(0 downto 0) := (others => '0');
  signal outpipe_pipe_read_ack : std_logic_vector(0 downto 0);
  -- 
begin --
  -- clock/reset generation 
  clk <= not clk after 5 ns;
  process
  begin --
    Vhpi_Initialize;
    wait until clk = '1';
    reset <= '0';
    while true loop --
      wait until clk = '0';
      Vhpi_Listen;
      Vhpi_Send;
      --
    end loop;
    wait;
    --
  end process;
  -- connect all the top-level modules to Vhpi
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns;
      obj_ref := Pack_String_To_VHPI_String("bar req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      bar_start_req <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("bar 0");
      Vhpi_Get_Port_Value(obj_ref,val_string, 32);
      bar_a <= Unpack_String(val_string,32);
      if bar_start_req = '1' then -- 
        while true loop --
          wait until clk = '1';
          if bar_start_ack = '1' then exit; end if;--
        end loop; 
        bar_start_req <= '0';
        bar_fin_req <= '1';
        while true loop -- 
          wait until clk = '1';
          if bar_fin_ack = '1' then exit; end if; --  
        end loop; 
        bar_fin_req <= '0';
        -- 
      end if; 
      obj_ref := Pack_String_To_Vhpi_String("bar ack");
      val_string := To_String(bar_fin_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("bar 0");
      val_string := Pack_SLV_To_Vhpi_String(bar_ret_val_x_x);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns;
      obj_ref := Pack_String_To_VHPI_String("foo req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      foo_start_req <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("foo 0");
      Vhpi_Get_Port_Value(obj_ref,val_string, 32);
      foo_a <= Unpack_String(val_string,32);
      if foo_start_req = '1' then -- 
        while true loop --
          wait until clk = '1';
          if foo_start_ack = '1' then exit; end if;--
        end loop; 
        foo_start_req <= '0';
        foo_fin_req <= '1';
        while true loop -- 
          wait until clk = '1';
          if foo_fin_ack = '1' then exit; end if; --  
        end loop; 
        foo_fin_req <= '0';
        -- 
      end if; 
      obj_ref := Pack_String_To_Vhpi_String("foo ack");
      val_string := To_String(foo_fin_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("foo 0");
      val_string := Pack_SLV_To_Vhpi_String(foo_ret_val_x_x);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns; 
      obj_ref := Pack_String_To_Vhpi_String("inpipe req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      inpipe_pipe_write_req <= Unpack_String(val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("inpipe 0");
      Vhpi_Get_Port_Value(obj_ref,val_string,32);
      inpipe_pipe_write_data <= Unpack_String(val_string,32);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("inpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(inpipe_pipe_write_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      -- 
    end loop;
    --
  end process;
  process
  variable val_string, obj_ref: VhpiString;
  begin --
    wait until reset = '0';
    while true loop -- 
      wait until clk = '0';
      wait for 1 ns; 
      obj_ref := Pack_String_To_Vhpi_String("outpipe req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      outpipe_pipe_read_req <= Unpack_String(val_string,1);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("outpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("outpipe 0");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_data);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  test_system_instance: test_system -- 
    port map ( -- 
      bar_a => bar_a,
      bar_ret_val_x_x => bar_ret_val_x_x,
      bar_tag_in => bar_tag_in,
      bar_tag_out => bar_tag_out,
      bar_start_req => bar_start_req,
      bar_start_ack => bar_start_ack,
      bar_fin_req  => bar_fin_req, 
      bar_fin_ack  => bar_fin_ack ,
      foo_a => foo_a,
      foo_ret_val_x_x => foo_ret_val_x_x,
      foo_tag_in => foo_tag_in,
      foo_tag_out => foo_tag_out,
      foo_start_req => foo_start_req,
      foo_start_ack => foo_start_ack,
      foo_fin_req  => foo_fin_req, 
      foo_fin_ack  => foo_fin_ack ,
      clk => clk,
      reset => reset,
      inpipe_pipe_write_data  => inpipe_pipe_write_data, 
      inpipe_pipe_write_req  => inpipe_pipe_write_req, 
      inpipe_pipe_write_ack  => inpipe_pipe_write_ack,
      outpipe_pipe_read_data  => outpipe_pipe_read_data, 
      outpipe_pipe_read_req  => outpipe_pipe_read_req, 
      outpipe_pipe_read_ack  => outpipe_pipe_read_ack ); -- 
  -- 
end VhpiLink;
