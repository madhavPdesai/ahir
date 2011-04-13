-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant g_base_address : std_logic_vector(0 downto 0) := "0";
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
entity main is -- 
  port ( -- 
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    sub_call_reqs : out  std_logic_vector(0 downto 0);
    sub_call_acks : in   std_logic_vector(0 downto 0);
    sub_call_data : out  std_logic_vector(63 downto 0);
    sub_call_tag  :  out  std_logic_vector(0 downto 0);
    sub_return_reqs : out  std_logic_vector(0 downto 0);
    sub_return_acks : in   std_logic_vector(0 downto 0);
    sub_return_data : in   std_logic_vector(31 downto 0);
    sub_return_tag :  in   std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity main;
architecture Default of main is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_183_load_0_req_1 : boolean;
  signal binary_154_inst_ack_1 : boolean;
  signal binary_154_inst_req_1 : boolean;
  signal binary_154_inst_ack_0 : boolean;
  signal simple_obj_ref_145_store_0_req_0 : boolean;
  signal simple_obj_ref_177_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_177_gather_scatter_req_0 : boolean;
  signal binary_154_inst_req_0 : boolean;
  signal simple_obj_ref_183_load_0_req_0 : boolean;
  signal simple_obj_ref_164_store_0_ack_0 : boolean;
  signal simple_obj_ref_169_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_138_store_0_ack_1 : boolean;
  signal simple_obj_ref_138_store_0_req_1 : boolean;
  signal simple_obj_ref_164_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_183_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_164_store_0_req_0 : boolean;
  signal simple_obj_ref_177_store_0_req_0 : boolean;
  signal simple_obj_ref_183_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_175_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_149_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_175_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_175_load_0_ack_1 : boolean;
  signal simple_obj_ref_169_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_149_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_169_store_0_ack_0 : boolean;
  signal simple_obj_ref_177_store_0_req_1 : boolean;
  signal simple_obj_ref_138_store_0_ack_0 : boolean;
  signal simple_obj_ref_138_store_0_req_0 : boolean;
  signal simple_obj_ref_175_load_0_req_1 : boolean;
  signal simple_obj_ref_169_store_0_req_0 : boolean;
  signal simple_obj_ref_149_load_0_ack_1 : boolean;
  signal simple_obj_ref_183_load_0_ack_1 : boolean;
  signal simple_obj_ref_149_load_0_req_1 : boolean;
  signal simple_obj_ref_145_gather_scatter_ack_0 : boolean;
  signal call_stmt_144_call_ack_1 : boolean;
  signal simple_obj_ref_138_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_175_load_0_ack_0 : boolean;
  signal call_stmt_144_call_req_1 : boolean;
  signal simple_obj_ref_175_load_0_req_0 : boolean;
  signal simple_obj_ref_138_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_149_load_0_ack_0 : boolean;
  signal simple_obj_ref_149_load_0_req_0 : boolean;
  signal simple_obj_ref_164_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_164_store_0_ack_1 : boolean;
  signal if_stmt_157_branch_ack_1 : boolean;
  signal call_stmt_144_call_ack_0 : boolean;
  signal call_stmt_144_call_req_0 : boolean;
  signal simple_obj_ref_177_store_0_ack_1 : boolean;
  signal simple_obj_ref_164_store_0_req_1 : boolean;
  signal simple_obj_ref_145_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_183_load_0_ack_0 : boolean;
  signal if_stmt_157_branch_req_0 : boolean;
  signal simple_obj_ref_145_store_0_ack_1 : boolean;
  signal simple_obj_ref_145_store_0_req_1 : boolean;
  signal simple_obj_ref_169_store_0_ack_1 : boolean;
  signal simple_obj_ref_169_store_0_req_1 : boolean;
  signal simple_obj_ref_177_store_0_ack_0 : boolean;
  signal if_stmt_157_branch_ack_0 : boolean;
  signal simple_obj_ref_145_store_0_ack_0 : boolean;
  signal memory_space_10_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_10_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_10_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_10_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_10_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_10_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_10_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_10_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_10_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_10_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_10_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_10_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_10_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_10_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_10_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_10_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_8_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_8_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_8_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_8_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_8_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_8_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_8_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_8_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_8_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_8_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_8_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_8_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_8_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_8_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_8_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_8_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_9_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_9_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_9_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_9_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_9_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_9_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_9_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_9_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_9_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_9_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_9_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_9_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_9_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_9_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_9_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_9_sc_tag :  std_logic_vector(1 downto 0);
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
  main_CP_679: Block -- control-path 
    signal main_CP_679_start: Boolean;
    signal Xentry_680_symbol: Boolean;
    signal Xexit_681_symbol: Boolean;
    signal branch_block_stmt_135_682_symbol : Boolean;
    -- 
  begin -- 
    main_CP_679_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_680_symbol  <= main_CP_679_start; -- transition $entry
    branch_block_stmt_135_682: Block -- branch_block_stmt_135 
      signal branch_block_stmt_135_682_start: Boolean;
      signal Xentry_683_symbol: Boolean;
      signal Xexit_684_symbol: Boolean;
      signal branch_block_stmt_135_x_xentry_x_xx_x685_symbol : Boolean;
      signal branch_block_stmt_135_x_xexit_x_xx_x686_symbol : Boolean;
      signal assign_stmt_140_x_xentry_x_xx_x687_symbol : Boolean;
      signal assign_stmt_140_x_xexit_x_xx_x688_symbol : Boolean;
      signal call_stmt_144_x_xentry_x_xx_x689_symbol : Boolean;
      signal call_stmt_144_x_xexit_x_xx_x690_symbol : Boolean;
      signal assign_stmt_147_to_assign_stmt_156_x_xentry_x_xx_x691_symbol : Boolean;
      signal assign_stmt_147_to_assign_stmt_156_x_xexit_x_xx_x692_symbol : Boolean;
      signal if_stmt_157_x_xentry_x_xx_x693_symbol : Boolean;
      signal if_stmt_157_x_xexit_x_xx_x694_symbol : Boolean;
      signal merge_stmt_163_x_xentry_x_xx_x695_symbol : Boolean;
      signal merge_stmt_163_x_xexit_x_xx_x696_symbol : Boolean;
      signal assign_stmt_166_x_xentry_x_xx_x697_symbol : Boolean;
      signal assign_stmt_166_x_xexit_x_xx_x698_symbol : Boolean;
      signal bb_1_bb_3_699_symbol : Boolean;
      signal merge_stmt_168_x_xexit_x_xx_x700_symbol : Boolean;
      signal assign_stmt_171_x_xentry_x_xx_x701_symbol : Boolean;
      signal assign_stmt_171_x_xexit_x_xx_x702_symbol : Boolean;
      signal bb_2_bb_3_703_symbol : Boolean;
      signal merge_stmt_173_x_xexit_x_xx_x704_symbol : Boolean;
      signal assign_stmt_176_to_assign_stmt_179_x_xentry_x_xx_x705_symbol : Boolean;
      signal assign_stmt_176_to_assign_stmt_179_x_xexit_x_xx_x706_symbol : Boolean;
      signal return_x_xx_x707_symbol : Boolean;
      signal merge_stmt_181_x_xexit_x_xx_x708_symbol : Boolean;
      signal assign_stmt_184_x_xentry_x_xx_x709_symbol : Boolean;
      signal assign_stmt_184_x_xexit_x_xx_x710_symbol : Boolean;
      signal assign_stmt_140_711_symbol : Boolean;
      signal call_stmt_144_744_symbol : Boolean;
      signal assign_stmt_147_to_assign_stmt_156_761_symbol : Boolean;
      signal if_stmt_157_dead_link_837_symbol : Boolean;
      signal if_stmt_157_eval_test_841_symbol : Boolean;
      signal simple_obj_ref_158_place_845_symbol : Boolean;
      signal if_stmt_157_if_link_846_symbol : Boolean;
      signal if_stmt_157_else_link_850_symbol : Boolean;
      signal bb_0_bb_1_854_symbol : Boolean;
      signal bb_0_bb_2_855_symbol : Boolean;
      signal assign_stmt_166_856_symbol : Boolean;
      signal assign_stmt_171_889_symbol : Boolean;
      signal assign_stmt_176_to_assign_stmt_179_922_symbol : Boolean;
      signal assign_stmt_184_986_symbol : Boolean;
      signal merge_stmt_163_dead_link_1019_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_1023_symbol : Boolean;
      signal merge_stmt_163_PhiReqMerge_1026_symbol : Boolean;
      signal merge_stmt_163_PhiAck_1027_symbol : Boolean;
      signal bb_0_bb_2_PhiReq_1031_symbol : Boolean;
      signal merge_stmt_168_PhiReqMerge_1034_symbol : Boolean;
      signal merge_stmt_168_PhiAck_1035_symbol : Boolean;
      signal bb_1_bb_3_PhiReq_1039_symbol : Boolean;
      signal bb_2_bb_3_PhiReq_1042_symbol : Boolean;
      signal merge_stmt_173_PhiReqMerge_1045_symbol : Boolean;
      signal merge_stmt_173_PhiAck_1046_symbol : Boolean;
      signal return_x_xx_xPhiReq_1050_symbol : Boolean;
      signal merge_stmt_181_PhiReqMerge_1053_symbol : Boolean;
      signal merge_stmt_181_PhiAck_1054_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_135_682_start <= Xentry_680_symbol; -- control passed to block
      Xentry_683_symbol  <= branch_block_stmt_135_682_start; -- transition branch_block_stmt_135/$entry
      branch_block_stmt_135_x_xentry_x_xx_x685_symbol  <=  Xentry_683_symbol; -- place branch_block_stmt_135/branch_block_stmt_135__entry__ (optimized away) 
      branch_block_stmt_135_x_xexit_x_xx_x686_symbol  <=  assign_stmt_184_x_xexit_x_xx_x710_symbol; -- place branch_block_stmt_135/branch_block_stmt_135__exit__ (optimized away) 
      assign_stmt_140_x_xentry_x_xx_x687_symbol  <=  branch_block_stmt_135_x_xentry_x_xx_x685_symbol; -- place branch_block_stmt_135/assign_stmt_140__entry__ (optimized away) 
      assign_stmt_140_x_xexit_x_xx_x688_symbol  <=  assign_stmt_140_711_symbol; -- place branch_block_stmt_135/assign_stmt_140__exit__ (optimized away) 
      call_stmt_144_x_xentry_x_xx_x689_symbol  <=  assign_stmt_140_x_xexit_x_xx_x688_symbol; -- place branch_block_stmt_135/call_stmt_144__entry__ (optimized away) 
      call_stmt_144_x_xexit_x_xx_x690_symbol  <=  call_stmt_144_744_symbol; -- place branch_block_stmt_135/call_stmt_144__exit__ (optimized away) 
      assign_stmt_147_to_assign_stmt_156_x_xentry_x_xx_x691_symbol  <=  call_stmt_144_x_xexit_x_xx_x690_symbol; -- place branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156__entry__ (optimized away) 
      assign_stmt_147_to_assign_stmt_156_x_xexit_x_xx_x692_symbol  <=  assign_stmt_147_to_assign_stmt_156_761_symbol; -- place branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156__exit__ (optimized away) 
      if_stmt_157_x_xentry_x_xx_x693_symbol  <=  assign_stmt_147_to_assign_stmt_156_x_xexit_x_xx_x692_symbol; -- place branch_block_stmt_135/if_stmt_157__entry__ (optimized away) 
      if_stmt_157_x_xexit_x_xx_x694_symbol  <=  if_stmt_157_dead_link_837_symbol or if_stmt_157_dead_link_837_symbol; -- place branch_block_stmt_135/if_stmt_157__exit__ (optimized away) 
      merge_stmt_163_x_xentry_x_xx_x695_symbol  <=  if_stmt_157_x_xexit_x_xx_x694_symbol; -- place branch_block_stmt_135/merge_stmt_163__entry__ (optimized away) 
      merge_stmt_163_x_xexit_x_xx_x696_symbol  <=  merge_stmt_163_dead_link_1019_symbol or merge_stmt_163_PhiAck_1027_symbol; -- place branch_block_stmt_135/merge_stmt_163__exit__ (optimized away) 
      assign_stmt_166_x_xentry_x_xx_x697_symbol  <=  merge_stmt_163_x_xexit_x_xx_x696_symbol; -- place branch_block_stmt_135/assign_stmt_166__entry__ (optimized away) 
      assign_stmt_166_x_xexit_x_xx_x698_symbol  <=  assign_stmt_166_856_symbol; -- place branch_block_stmt_135/assign_stmt_166__exit__ (optimized away) 
      bb_1_bb_3_699_symbol  <=  assign_stmt_166_x_xexit_x_xx_x698_symbol; -- place branch_block_stmt_135/bb_1_bb_3 (optimized away) 
      merge_stmt_168_x_xexit_x_xx_x700_symbol  <=  merge_stmt_168_PhiAck_1035_symbol; -- place branch_block_stmt_135/merge_stmt_168__exit__ (optimized away) 
      assign_stmt_171_x_xentry_x_xx_x701_symbol  <=  merge_stmt_168_x_xexit_x_xx_x700_symbol; -- place branch_block_stmt_135/assign_stmt_171__entry__ (optimized away) 
      assign_stmt_171_x_xexit_x_xx_x702_symbol  <=  assign_stmt_171_889_symbol; -- place branch_block_stmt_135/assign_stmt_171__exit__ (optimized away) 
      bb_2_bb_3_703_symbol  <=  assign_stmt_171_x_xexit_x_xx_x702_symbol; -- place branch_block_stmt_135/bb_2_bb_3 (optimized away) 
      merge_stmt_173_x_xexit_x_xx_x704_symbol  <=  merge_stmt_173_PhiAck_1046_symbol; -- place branch_block_stmt_135/merge_stmt_173__exit__ (optimized away) 
      assign_stmt_176_to_assign_stmt_179_x_xentry_x_xx_x705_symbol  <=  merge_stmt_173_x_xexit_x_xx_x704_symbol; -- place branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179__entry__ (optimized away) 
      assign_stmt_176_to_assign_stmt_179_x_xexit_x_xx_x706_symbol  <=  assign_stmt_176_to_assign_stmt_179_922_symbol; -- place branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179__exit__ (optimized away) 
      return_x_xx_x707_symbol  <=  assign_stmt_176_to_assign_stmt_179_x_xexit_x_xx_x706_symbol; -- place branch_block_stmt_135/return__ (optimized away) 
      merge_stmt_181_x_xexit_x_xx_x708_symbol  <=  merge_stmt_181_PhiAck_1054_symbol; -- place branch_block_stmt_135/merge_stmt_181__exit__ (optimized away) 
      assign_stmt_184_x_xentry_x_xx_x709_symbol  <=  merge_stmt_181_x_xexit_x_xx_x708_symbol; -- place branch_block_stmt_135/assign_stmt_184__entry__ (optimized away) 
      assign_stmt_184_x_xexit_x_xx_x710_symbol  <=  assign_stmt_184_986_symbol; -- place branch_block_stmt_135/assign_stmt_184__exit__ (optimized away) 
      assign_stmt_140_711: Block -- branch_block_stmt_135/assign_stmt_140 
        signal assign_stmt_140_711_start: Boolean;
        signal Xentry_712_symbol: Boolean;
        signal Xexit_713_symbol: Boolean;
        signal assign_stmt_140_active_x_x714_symbol : Boolean;
        signal assign_stmt_140_completed_x_x715_symbol : Boolean;
        signal simple_obj_ref_138_trigger_x_x716_symbol : Boolean;
        signal simple_obj_ref_138_active_x_x717_symbol : Boolean;
        signal simple_obj_ref_138_root_address_calculated_718_symbol : Boolean;
        signal simple_obj_ref_138_word_address_calculated_719_symbol : Boolean;
        signal simple_obj_ref_138_request_720_symbol : Boolean;
        signal simple_obj_ref_138_complete_733_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_140_711_start <= assign_stmt_140_x_xentry_x_xx_x687_symbol; -- control passed to block
        Xentry_712_symbol  <= assign_stmt_140_711_start; -- transition branch_block_stmt_135/assign_stmt_140/$entry
        assign_stmt_140_active_x_x714_symbol <= Xentry_712_symbol; -- transition branch_block_stmt_135/assign_stmt_140/assign_stmt_140_active_
        assign_stmt_140_completed_x_x715_symbol <= simple_obj_ref_138_complete_733_symbol; -- transition branch_block_stmt_135/assign_stmt_140/assign_stmt_140_completed_
        simple_obj_ref_138_trigger_x_x716_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_trigger_ 
          signal simple_obj_ref_138_trigger_x_x716_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_138_trigger_x_x716_predecessors(0) <= simple_obj_ref_138_word_address_calculated_719_symbol;
          simple_obj_ref_138_trigger_x_x716_predecessors(1) <= assign_stmt_140_active_x_x714_symbol;
          simple_obj_ref_138_trigger_x_x716_join: join -- 
            port map( -- 
              preds => simple_obj_ref_138_trigger_x_x716_predecessors,
              symbol_out => simple_obj_ref_138_trigger_x_x716_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_trigger_
        simple_obj_ref_138_active_x_x717_symbol <= simple_obj_ref_138_request_720_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_active_
        simple_obj_ref_138_root_address_calculated_718_symbol <= Xentry_712_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_root_address_calculated
        simple_obj_ref_138_word_address_calculated_719_symbol <= simple_obj_ref_138_root_address_calculated_718_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_word_address_calculated
        simple_obj_ref_138_request_720: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request 
          signal simple_obj_ref_138_request_720_start: Boolean;
          signal Xentry_721_symbol: Boolean;
          signal Xexit_722_symbol: Boolean;
          signal split_req_723_symbol : Boolean;
          signal split_ack_724_symbol : Boolean;
          signal word_access_725_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_138_request_720_start <= simple_obj_ref_138_trigger_x_x716_symbol; -- control passed to block
          Xentry_721_symbol  <= simple_obj_ref_138_request_720_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/$entry
          split_req_723_symbol <= Xentry_721_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/split_req
          simple_obj_ref_138_gather_scatter_req_0 <= split_req_723_symbol; -- link to DP
          split_ack_724_symbol <= simple_obj_ref_138_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/split_ack
          word_access_725: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access 
            signal word_access_725_start: Boolean;
            signal Xentry_726_symbol: Boolean;
            signal Xexit_727_symbol: Boolean;
            signal word_access_0_728_symbol : Boolean;
            -- 
          begin -- 
            word_access_725_start <= split_ack_724_symbol; -- control passed to block
            Xentry_726_symbol  <= word_access_725_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/$entry
            word_access_0_728: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/word_access_0 
              signal word_access_0_728_start: Boolean;
              signal Xentry_729_symbol: Boolean;
              signal Xexit_730_symbol: Boolean;
              signal rr_731_symbol : Boolean;
              signal ra_732_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_728_start <= Xentry_726_symbol; -- control passed to block
              Xentry_729_symbol  <= word_access_0_728_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/word_access_0/$entry
              rr_731_symbol <= Xentry_729_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/word_access_0/rr
              simple_obj_ref_138_store_0_req_0 <= rr_731_symbol; -- link to DP
              ra_732_symbol <= simple_obj_ref_138_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/word_access_0/ra
              Xexit_730_symbol <= ra_732_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/word_access_0/$exit
              word_access_0_728_symbol <= Xexit_730_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/word_access_0
            Xexit_727_symbol <= word_access_0_728_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access/$exit
            word_access_725_symbol <= Xexit_727_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/word_access
          Xexit_722_symbol <= word_access_725_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request/$exit
          simple_obj_ref_138_request_720_symbol <= Xexit_722_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_request
        simple_obj_ref_138_complete_733: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete 
          signal simple_obj_ref_138_complete_733_start: Boolean;
          signal Xentry_734_symbol: Boolean;
          signal Xexit_735_symbol: Boolean;
          signal word_access_736_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_138_complete_733_start <= simple_obj_ref_138_active_x_x717_symbol; -- control passed to block
          Xentry_734_symbol  <= simple_obj_ref_138_complete_733_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/$entry
          word_access_736: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access 
            signal word_access_736_start: Boolean;
            signal Xentry_737_symbol: Boolean;
            signal Xexit_738_symbol: Boolean;
            signal word_access_0_739_symbol : Boolean;
            -- 
          begin -- 
            word_access_736_start <= Xentry_734_symbol; -- control passed to block
            Xentry_737_symbol  <= word_access_736_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/$entry
            word_access_0_739: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/word_access_0 
              signal word_access_0_739_start: Boolean;
              signal Xentry_740_symbol: Boolean;
              signal Xexit_741_symbol: Boolean;
              signal cr_742_symbol : Boolean;
              signal ca_743_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_739_start <= Xentry_737_symbol; -- control passed to block
              Xentry_740_symbol  <= word_access_0_739_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/word_access_0/$entry
              cr_742_symbol <= Xentry_740_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/word_access_0/cr
              simple_obj_ref_138_store_0_req_1 <= cr_742_symbol; -- link to DP
              ca_743_symbol <= simple_obj_ref_138_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/word_access_0/ca
              Xexit_741_symbol <= ca_743_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/word_access_0/$exit
              word_access_0_739_symbol <= Xexit_741_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/word_access_0
            Xexit_738_symbol <= word_access_0_739_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access/$exit
            word_access_736_symbol <= Xexit_738_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/word_access
          Xexit_735_symbol <= word_access_736_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete/$exit
          simple_obj_ref_138_complete_733_symbol <= Xexit_735_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138_complete
        Xexit_713_symbol <= assign_stmt_140_completed_x_x715_symbol; -- transition branch_block_stmt_135/assign_stmt_140/$exit
        assign_stmt_140_711_symbol <= Xexit_713_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_140
      call_stmt_144_744: Block -- branch_block_stmt_135/call_stmt_144 
        signal call_stmt_144_744_start: Boolean;
        signal Xentry_745_symbol: Boolean;
        signal Xexit_746_symbol: Boolean;
        signal call_stmt_144_active_x_x747_symbol : Boolean;
        signal call_stmt_144_in_progress_748_symbol : Boolean;
        signal call_stmt_144_start_749_symbol : Boolean;
        signal call_stmt_144_complete_754_symbol : Boolean;
        signal call_stmt_144_call_complete_759_symbol : Boolean;
        signal call_stmt_144_completed_x_x760_symbol : Boolean;
        -- 
      begin -- 
        call_stmt_144_744_start <= call_stmt_144_x_xentry_x_xx_x689_symbol; -- control passed to block
        Xentry_745_symbol  <= call_stmt_144_744_start; -- transition branch_block_stmt_135/call_stmt_144/$entry
        call_stmt_144_active_x_x747_symbol <= Xentry_745_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_active_
        call_stmt_144_in_progress_748_symbol <= call_stmt_144_start_749_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_in_progress
        call_stmt_144_start_749: Block -- branch_block_stmt_135/call_stmt_144/call_stmt_144_start 
          signal call_stmt_144_start_749_start: Boolean;
          signal Xentry_750_symbol: Boolean;
          signal Xexit_751_symbol: Boolean;
          signal crr_752_symbol : Boolean;
          signal cra_753_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_144_start_749_start <= call_stmt_144_active_x_x747_symbol; -- control passed to block
          Xentry_750_symbol  <= call_stmt_144_start_749_start; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_start/$entry
          crr_752_symbol <= Xentry_750_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_start/crr
          call_stmt_144_call_req_0 <= crr_752_symbol; -- link to DP
          cra_753_symbol <= call_stmt_144_call_ack_0; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_start/cra
          Xexit_751_symbol <= cra_753_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_start/$exit
          call_stmt_144_start_749_symbol <= Xexit_751_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/call_stmt_144/call_stmt_144_start
        call_stmt_144_complete_754: Block -- branch_block_stmt_135/call_stmt_144/call_stmt_144_complete 
          signal call_stmt_144_complete_754_start: Boolean;
          signal Xentry_755_symbol: Boolean;
          signal Xexit_756_symbol: Boolean;
          signal ccr_757_symbol : Boolean;
          signal cca_758_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_144_complete_754_start <= call_stmt_144_in_progress_748_symbol; -- control passed to block
          Xentry_755_symbol  <= call_stmt_144_complete_754_start; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_complete/$entry
          ccr_757_symbol <= Xentry_755_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_complete/ccr
          call_stmt_144_call_req_1 <= ccr_757_symbol; -- link to DP
          cca_758_symbol <= call_stmt_144_call_ack_1; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_complete/cca
          Xexit_756_symbol <= cca_758_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_complete/$exit
          call_stmt_144_complete_754_symbol <= Xexit_756_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/call_stmt_144/call_stmt_144_complete
        call_stmt_144_call_complete_759_symbol <= call_stmt_144_complete_754_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_call_complete
        call_stmt_144_completed_x_x760_symbol <= call_stmt_144_call_complete_759_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_completed_
        Xexit_746_symbol <= call_stmt_144_completed_x_x760_symbol; -- transition branch_block_stmt_135/call_stmt_144/$exit
        call_stmt_144_744_symbol <= Xexit_746_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/call_stmt_144
      assign_stmt_147_to_assign_stmt_156_761: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156 
        signal assign_stmt_147_to_assign_stmt_156_761_start: Boolean;
        signal Xentry_762_symbol: Boolean;
        signal Xexit_763_symbol: Boolean;
        signal assign_stmt_147_active_x_x764_symbol : Boolean;
        signal assign_stmt_147_completed_x_x765_symbol : Boolean;
        signal simple_obj_ref_146_complete_766_symbol : Boolean;
        signal simple_obj_ref_145_trigger_x_x767_symbol : Boolean;
        signal simple_obj_ref_145_active_x_x768_symbol : Boolean;
        signal simple_obj_ref_145_root_address_calculated_769_symbol : Boolean;
        signal simple_obj_ref_145_word_address_calculated_770_symbol : Boolean;
        signal simple_obj_ref_145_request_771_symbol : Boolean;
        signal simple_obj_ref_145_complete_784_symbol : Boolean;
        signal assign_stmt_150_active_x_x795_symbol : Boolean;
        signal assign_stmt_150_completed_x_x796_symbol : Boolean;
        signal simple_obj_ref_149_trigger_x_x797_symbol : Boolean;
        signal simple_obj_ref_149_active_x_x798_symbol : Boolean;
        signal simple_obj_ref_149_root_address_calculated_799_symbol : Boolean;
        signal simple_obj_ref_149_word_address_calculated_800_symbol : Boolean;
        signal simple_obj_ref_149_request_801_symbol : Boolean;
        signal simple_obj_ref_149_complete_812_symbol : Boolean;
        signal assign_stmt_156_active_x_x825_symbol : Boolean;
        signal assign_stmt_156_completed_x_x826_symbol : Boolean;
        signal binary_154_active_x_x827_symbol : Boolean;
        signal binary_154_trigger_x_x828_symbol : Boolean;
        signal simple_obj_ref_152_complete_829_symbol : Boolean;
        signal binary_154_complete_830_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_147_to_assign_stmt_156_761_start <= assign_stmt_147_to_assign_stmt_156_x_xentry_x_xx_x691_symbol; -- control passed to block
        Xentry_762_symbol  <= assign_stmt_147_to_assign_stmt_156_761_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/$entry
        assign_stmt_147_active_x_x764_symbol <= simple_obj_ref_146_complete_766_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/assign_stmt_147_active_
        assign_stmt_147_completed_x_x765_symbol <= simple_obj_ref_145_complete_784_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/assign_stmt_147_completed_
        simple_obj_ref_146_complete_766_symbol <= Xentry_762_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_146_complete
        simple_obj_ref_145_trigger_x_x767_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_trigger_ 
          signal simple_obj_ref_145_trigger_x_x767_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_145_trigger_x_x767_predecessors(0) <= simple_obj_ref_145_word_address_calculated_770_symbol;
          simple_obj_ref_145_trigger_x_x767_predecessors(1) <= assign_stmt_147_active_x_x764_symbol;
          simple_obj_ref_145_trigger_x_x767_join: join -- 
            port map( -- 
              preds => simple_obj_ref_145_trigger_x_x767_predecessors,
              symbol_out => simple_obj_ref_145_trigger_x_x767_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_trigger_
        simple_obj_ref_145_active_x_x768_symbol <= simple_obj_ref_145_request_771_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_active_
        simple_obj_ref_145_root_address_calculated_769_symbol <= Xentry_762_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_root_address_calculated
        simple_obj_ref_145_word_address_calculated_770_symbol <= simple_obj_ref_145_root_address_calculated_769_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_word_address_calculated
        simple_obj_ref_145_request_771: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request 
          signal simple_obj_ref_145_request_771_start: Boolean;
          signal Xentry_772_symbol: Boolean;
          signal Xexit_773_symbol: Boolean;
          signal split_req_774_symbol : Boolean;
          signal split_ack_775_symbol : Boolean;
          signal word_access_776_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_145_request_771_start <= simple_obj_ref_145_trigger_x_x767_symbol; -- control passed to block
          Xentry_772_symbol  <= simple_obj_ref_145_request_771_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/$entry
          split_req_774_symbol <= Xentry_772_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/split_req
          simple_obj_ref_145_gather_scatter_req_0 <= split_req_774_symbol; -- link to DP
          split_ack_775_symbol <= simple_obj_ref_145_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/split_ack
          word_access_776: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access 
            signal word_access_776_start: Boolean;
            signal Xentry_777_symbol: Boolean;
            signal Xexit_778_symbol: Boolean;
            signal word_access_0_779_symbol : Boolean;
            -- 
          begin -- 
            word_access_776_start <= split_ack_775_symbol; -- control passed to block
            Xentry_777_symbol  <= word_access_776_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/$entry
            word_access_0_779: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/word_access_0 
              signal word_access_0_779_start: Boolean;
              signal Xentry_780_symbol: Boolean;
              signal Xexit_781_symbol: Boolean;
              signal rr_782_symbol : Boolean;
              signal ra_783_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_779_start <= Xentry_777_symbol; -- control passed to block
              Xentry_780_symbol  <= word_access_0_779_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/word_access_0/$entry
              rr_782_symbol <= Xentry_780_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/word_access_0/rr
              simple_obj_ref_145_store_0_req_0 <= rr_782_symbol; -- link to DP
              ra_783_symbol <= simple_obj_ref_145_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/word_access_0/ra
              Xexit_781_symbol <= ra_783_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/word_access_0/$exit
              word_access_0_779_symbol <= Xexit_781_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/word_access_0
            Xexit_778_symbol <= word_access_0_779_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access/$exit
            word_access_776_symbol <= Xexit_778_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/word_access
          Xexit_773_symbol <= word_access_776_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request/$exit
          simple_obj_ref_145_request_771_symbol <= Xexit_773_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_request
        simple_obj_ref_145_complete_784: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete 
          signal simple_obj_ref_145_complete_784_start: Boolean;
          signal Xentry_785_symbol: Boolean;
          signal Xexit_786_symbol: Boolean;
          signal word_access_787_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_145_complete_784_start <= simple_obj_ref_145_active_x_x768_symbol; -- control passed to block
          Xentry_785_symbol  <= simple_obj_ref_145_complete_784_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/$entry
          word_access_787: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access 
            signal word_access_787_start: Boolean;
            signal Xentry_788_symbol: Boolean;
            signal Xexit_789_symbol: Boolean;
            signal word_access_0_790_symbol : Boolean;
            -- 
          begin -- 
            word_access_787_start <= Xentry_785_symbol; -- control passed to block
            Xentry_788_symbol  <= word_access_787_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/$entry
            word_access_0_790: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/word_access_0 
              signal word_access_0_790_start: Boolean;
              signal Xentry_791_symbol: Boolean;
              signal Xexit_792_symbol: Boolean;
              signal cr_793_symbol : Boolean;
              signal ca_794_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_790_start <= Xentry_788_symbol; -- control passed to block
              Xentry_791_symbol  <= word_access_0_790_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/word_access_0/$entry
              cr_793_symbol <= Xentry_791_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/word_access_0/cr
              simple_obj_ref_145_store_0_req_1 <= cr_793_symbol; -- link to DP
              ca_794_symbol <= simple_obj_ref_145_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/word_access_0/ca
              Xexit_792_symbol <= ca_794_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/word_access_0/$exit
              word_access_0_790_symbol <= Xexit_792_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/word_access_0
            Xexit_789_symbol <= word_access_0_790_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access/$exit
            word_access_787_symbol <= Xexit_789_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/word_access
          Xexit_786_symbol <= word_access_787_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete/$exit
          simple_obj_ref_145_complete_784_symbol <= Xexit_786_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_145_complete
        assign_stmt_150_active_x_x795_symbol <= simple_obj_ref_149_complete_812_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/assign_stmt_150_active_
        assign_stmt_150_completed_x_x796_symbol <= assign_stmt_150_active_x_x795_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/assign_stmt_150_completed_
        simple_obj_ref_149_trigger_x_x797_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_trigger_ 
          signal simple_obj_ref_149_trigger_x_x797_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_149_trigger_x_x797_predecessors(0) <= simple_obj_ref_149_word_address_calculated_800_symbol;
          simple_obj_ref_149_trigger_x_x797_predecessors(1) <= simple_obj_ref_145_active_x_x768_symbol;
          simple_obj_ref_149_trigger_x_x797_join: join -- 
            port map( -- 
              preds => simple_obj_ref_149_trigger_x_x797_predecessors,
              symbol_out => simple_obj_ref_149_trigger_x_x797_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_trigger_
        simple_obj_ref_149_active_x_x798_symbol <= simple_obj_ref_149_request_801_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_active_
        simple_obj_ref_149_root_address_calculated_799_symbol <= Xentry_762_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_root_address_calculated
        simple_obj_ref_149_word_address_calculated_800_symbol <= simple_obj_ref_149_root_address_calculated_799_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_word_address_calculated
        simple_obj_ref_149_request_801: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request 
          signal simple_obj_ref_149_request_801_start: Boolean;
          signal Xentry_802_symbol: Boolean;
          signal Xexit_803_symbol: Boolean;
          signal word_access_804_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_149_request_801_start <= simple_obj_ref_149_trigger_x_x797_symbol; -- control passed to block
          Xentry_802_symbol  <= simple_obj_ref_149_request_801_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/$entry
          word_access_804: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access 
            signal word_access_804_start: Boolean;
            signal Xentry_805_symbol: Boolean;
            signal Xexit_806_symbol: Boolean;
            signal word_access_0_807_symbol : Boolean;
            -- 
          begin -- 
            word_access_804_start <= Xentry_802_symbol; -- control passed to block
            Xentry_805_symbol  <= word_access_804_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/$entry
            word_access_0_807: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/word_access_0 
              signal word_access_0_807_start: Boolean;
              signal Xentry_808_symbol: Boolean;
              signal Xexit_809_symbol: Boolean;
              signal rr_810_symbol : Boolean;
              signal ra_811_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_807_start <= Xentry_805_symbol; -- control passed to block
              Xentry_808_symbol  <= word_access_0_807_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/word_access_0/$entry
              rr_810_symbol <= Xentry_808_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/word_access_0/rr
              simple_obj_ref_149_load_0_req_0 <= rr_810_symbol; -- link to DP
              ra_811_symbol <= simple_obj_ref_149_load_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/word_access_0/ra
              Xexit_809_symbol <= ra_811_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/word_access_0/$exit
              word_access_0_807_symbol <= Xexit_809_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/word_access_0
            Xexit_806_symbol <= word_access_0_807_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access/$exit
            word_access_804_symbol <= Xexit_806_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/word_access
          Xexit_803_symbol <= word_access_804_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request/$exit
          simple_obj_ref_149_request_801_symbol <= Xexit_803_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_request
        simple_obj_ref_149_complete_812: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete 
          signal simple_obj_ref_149_complete_812_start: Boolean;
          signal Xentry_813_symbol: Boolean;
          signal Xexit_814_symbol: Boolean;
          signal word_access_815_symbol : Boolean;
          signal merge_req_823_symbol : Boolean;
          signal merge_ack_824_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_149_complete_812_start <= simple_obj_ref_149_active_x_x798_symbol; -- control passed to block
          Xentry_813_symbol  <= simple_obj_ref_149_complete_812_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/$entry
          word_access_815: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access 
            signal word_access_815_start: Boolean;
            signal Xentry_816_symbol: Boolean;
            signal Xexit_817_symbol: Boolean;
            signal word_access_0_818_symbol : Boolean;
            -- 
          begin -- 
            word_access_815_start <= Xentry_813_symbol; -- control passed to block
            Xentry_816_symbol  <= word_access_815_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/$entry
            word_access_0_818: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/word_access_0 
              signal word_access_0_818_start: Boolean;
              signal Xentry_819_symbol: Boolean;
              signal Xexit_820_symbol: Boolean;
              signal cr_821_symbol : Boolean;
              signal ca_822_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_818_start <= Xentry_816_symbol; -- control passed to block
              Xentry_819_symbol  <= word_access_0_818_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/word_access_0/$entry
              cr_821_symbol <= Xentry_819_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/word_access_0/cr
              simple_obj_ref_149_load_0_req_1 <= cr_821_symbol; -- link to DP
              ca_822_symbol <= simple_obj_ref_149_load_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/word_access_0/ca
              Xexit_820_symbol <= ca_822_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/word_access_0/$exit
              word_access_0_818_symbol <= Xexit_820_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/word_access_0
            Xexit_817_symbol <= word_access_0_818_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access/$exit
            word_access_815_symbol <= Xexit_817_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/word_access
          merge_req_823_symbol <= word_access_815_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/merge_req
          simple_obj_ref_149_gather_scatter_req_0 <= merge_req_823_symbol; -- link to DP
          merge_ack_824_symbol <= simple_obj_ref_149_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/merge_ack
          Xexit_814_symbol <= merge_ack_824_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete/$exit
          simple_obj_ref_149_complete_812_symbol <= Xexit_814_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_149_complete
        assign_stmt_156_active_x_x825_symbol <= binary_154_complete_830_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/assign_stmt_156_active_
        assign_stmt_156_completed_x_x826_symbol <= assign_stmt_156_active_x_x825_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/assign_stmt_156_completed_
        binary_154_active_x_x827_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_active_ 
          signal binary_154_active_x_x827_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_154_active_x_x827_predecessors(0) <= binary_154_trigger_x_x828_symbol;
          binary_154_active_x_x827_predecessors(1) <= simple_obj_ref_152_complete_829_symbol;
          binary_154_active_x_x827_join: join -- 
            port map( -- 
              preds => binary_154_active_x_x827_predecessors,
              symbol_out => binary_154_active_x_x827_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_active_
        binary_154_trigger_x_x828_symbol <= Xentry_762_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_trigger_
        simple_obj_ref_152_complete_829_symbol <= assign_stmt_150_completed_x_x796_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/simple_obj_ref_152_complete
        binary_154_complete_830: Block -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete 
          signal binary_154_complete_830_start: Boolean;
          signal Xentry_831_symbol: Boolean;
          signal Xexit_832_symbol: Boolean;
          signal rr_833_symbol : Boolean;
          signal ra_834_symbol : Boolean;
          signal cr_835_symbol : Boolean;
          signal ca_836_symbol : Boolean;
          -- 
        begin -- 
          binary_154_complete_830_start <= binary_154_active_x_x827_symbol; -- control passed to block
          Xentry_831_symbol  <= binary_154_complete_830_start; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete/$entry
          rr_833_symbol <= Xentry_831_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete/rr
          binary_154_inst_req_0 <= rr_833_symbol; -- link to DP
          ra_834_symbol <= binary_154_inst_ack_0; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete/ra
          cr_835_symbol <= ra_834_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete/cr
          binary_154_inst_req_1 <= cr_835_symbol; -- link to DP
          ca_836_symbol <= binary_154_inst_ack_1; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete/ca
          Xexit_832_symbol <= ca_836_symbol; -- transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete/$exit
          binary_154_complete_830_symbol <= Xexit_832_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/binary_154_complete
        Xexit_763_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/$exit 
          signal Xexit_763_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_763_predecessors(0) <= assign_stmt_147_completed_x_x765_symbol;
          Xexit_763_predecessors(1) <= assign_stmt_156_completed_x_x826_symbol;
          Xexit_763_join: join -- 
            port map( -- 
              preds => Xexit_763_predecessors,
              symbol_out => Xexit_763_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156/$exit
        assign_stmt_147_to_assign_stmt_156_761_symbol <= Xexit_763_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_147_to_assign_stmt_156
      if_stmt_157_dead_link_837: Block -- branch_block_stmt_135/if_stmt_157_dead_link 
        signal if_stmt_157_dead_link_837_start: Boolean;
        signal Xentry_838_symbol: Boolean;
        signal Xexit_839_symbol: Boolean;
        signal dead_transition_840_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_dead_link_837_start <= if_stmt_157_x_xentry_x_xx_x693_symbol; -- control passed to block
        Xentry_838_symbol  <= if_stmt_157_dead_link_837_start; -- transition branch_block_stmt_135/if_stmt_157_dead_link/$entry
        dead_transition_840_symbol <= false;
        Xexit_839_symbol <= dead_transition_840_symbol; -- transition branch_block_stmt_135/if_stmt_157_dead_link/$exit
        if_stmt_157_dead_link_837_symbol <= Xexit_839_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_dead_link
      if_stmt_157_eval_test_841: Block -- branch_block_stmt_135/if_stmt_157_eval_test 
        signal if_stmt_157_eval_test_841_start: Boolean;
        signal Xentry_842_symbol: Boolean;
        signal Xexit_843_symbol: Boolean;
        signal branch_req_844_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_eval_test_841_start <= if_stmt_157_x_xentry_x_xx_x693_symbol; -- control passed to block
        Xentry_842_symbol  <= if_stmt_157_eval_test_841_start; -- transition branch_block_stmt_135/if_stmt_157_eval_test/$entry
        branch_req_844_symbol <= Xentry_842_symbol; -- transition branch_block_stmt_135/if_stmt_157_eval_test/branch_req
        if_stmt_157_branch_req_0 <= branch_req_844_symbol; -- link to DP
        Xexit_843_symbol <= branch_req_844_symbol; -- transition branch_block_stmt_135/if_stmt_157_eval_test/$exit
        if_stmt_157_eval_test_841_symbol <= Xexit_843_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_eval_test
      simple_obj_ref_158_place_845_symbol  <=  if_stmt_157_eval_test_841_symbol; -- place branch_block_stmt_135/simple_obj_ref_158_place (optimized away) 
      if_stmt_157_if_link_846: Block -- branch_block_stmt_135/if_stmt_157_if_link 
        signal if_stmt_157_if_link_846_start: Boolean;
        signal Xentry_847_symbol: Boolean;
        signal Xexit_848_symbol: Boolean;
        signal if_choice_transition_849_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_if_link_846_start <= simple_obj_ref_158_place_845_symbol; -- control passed to block
        Xentry_847_symbol  <= if_stmt_157_if_link_846_start; -- transition branch_block_stmt_135/if_stmt_157_if_link/$entry
        if_choice_transition_849_symbol <= if_stmt_157_branch_ack_1; -- transition branch_block_stmt_135/if_stmt_157_if_link/if_choice_transition
        Xexit_848_symbol <= if_choice_transition_849_symbol; -- transition branch_block_stmt_135/if_stmt_157_if_link/$exit
        if_stmt_157_if_link_846_symbol <= Xexit_848_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_if_link
      if_stmt_157_else_link_850: Block -- branch_block_stmt_135/if_stmt_157_else_link 
        signal if_stmt_157_else_link_850_start: Boolean;
        signal Xentry_851_symbol: Boolean;
        signal Xexit_852_symbol: Boolean;
        signal else_choice_transition_853_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_else_link_850_start <= simple_obj_ref_158_place_845_symbol; -- control passed to block
        Xentry_851_symbol  <= if_stmt_157_else_link_850_start; -- transition branch_block_stmt_135/if_stmt_157_else_link/$entry
        else_choice_transition_853_symbol <= if_stmt_157_branch_ack_0; -- transition branch_block_stmt_135/if_stmt_157_else_link/else_choice_transition
        Xexit_852_symbol <= else_choice_transition_853_symbol; -- transition branch_block_stmt_135/if_stmt_157_else_link/$exit
        if_stmt_157_else_link_850_symbol <= Xexit_852_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_else_link
      bb_0_bb_1_854_symbol  <=  if_stmt_157_if_link_846_symbol; -- place branch_block_stmt_135/bb_0_bb_1 (optimized away) 
      bb_0_bb_2_855_symbol  <=  if_stmt_157_else_link_850_symbol; -- place branch_block_stmt_135/bb_0_bb_2 (optimized away) 
      assign_stmt_166_856: Block -- branch_block_stmt_135/assign_stmt_166 
        signal assign_stmt_166_856_start: Boolean;
        signal Xentry_857_symbol: Boolean;
        signal Xexit_858_symbol: Boolean;
        signal assign_stmt_166_active_x_x859_symbol : Boolean;
        signal assign_stmt_166_completed_x_x860_symbol : Boolean;
        signal simple_obj_ref_164_trigger_x_x861_symbol : Boolean;
        signal simple_obj_ref_164_active_x_x862_symbol : Boolean;
        signal simple_obj_ref_164_root_address_calculated_863_symbol : Boolean;
        signal simple_obj_ref_164_word_address_calculated_864_symbol : Boolean;
        signal simple_obj_ref_164_request_865_symbol : Boolean;
        signal simple_obj_ref_164_complete_878_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_166_856_start <= assign_stmt_166_x_xentry_x_xx_x697_symbol; -- control passed to block
        Xentry_857_symbol  <= assign_stmt_166_856_start; -- transition branch_block_stmt_135/assign_stmt_166/$entry
        assign_stmt_166_active_x_x859_symbol <= Xentry_857_symbol; -- transition branch_block_stmt_135/assign_stmt_166/assign_stmt_166_active_
        assign_stmt_166_completed_x_x860_symbol <= simple_obj_ref_164_complete_878_symbol; -- transition branch_block_stmt_135/assign_stmt_166/assign_stmt_166_completed_
        simple_obj_ref_164_trigger_x_x861_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_trigger_ 
          signal simple_obj_ref_164_trigger_x_x861_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_164_trigger_x_x861_predecessors(0) <= simple_obj_ref_164_word_address_calculated_864_symbol;
          simple_obj_ref_164_trigger_x_x861_predecessors(1) <= assign_stmt_166_active_x_x859_symbol;
          simple_obj_ref_164_trigger_x_x861_join: join -- 
            port map( -- 
              preds => simple_obj_ref_164_trigger_x_x861_predecessors,
              symbol_out => simple_obj_ref_164_trigger_x_x861_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_trigger_
        simple_obj_ref_164_active_x_x862_symbol <= simple_obj_ref_164_request_865_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_active_
        simple_obj_ref_164_root_address_calculated_863_symbol <= Xentry_857_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_root_address_calculated
        simple_obj_ref_164_word_address_calculated_864_symbol <= simple_obj_ref_164_root_address_calculated_863_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_word_address_calculated
        simple_obj_ref_164_request_865: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request 
          signal simple_obj_ref_164_request_865_start: Boolean;
          signal Xentry_866_symbol: Boolean;
          signal Xexit_867_symbol: Boolean;
          signal split_req_868_symbol : Boolean;
          signal split_ack_869_symbol : Boolean;
          signal word_access_870_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_164_request_865_start <= simple_obj_ref_164_trigger_x_x861_symbol; -- control passed to block
          Xentry_866_symbol  <= simple_obj_ref_164_request_865_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/$entry
          split_req_868_symbol <= Xentry_866_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/split_req
          simple_obj_ref_164_gather_scatter_req_0 <= split_req_868_symbol; -- link to DP
          split_ack_869_symbol <= simple_obj_ref_164_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/split_ack
          word_access_870: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access 
            signal word_access_870_start: Boolean;
            signal Xentry_871_symbol: Boolean;
            signal Xexit_872_symbol: Boolean;
            signal word_access_0_873_symbol : Boolean;
            -- 
          begin -- 
            word_access_870_start <= split_ack_869_symbol; -- control passed to block
            Xentry_871_symbol  <= word_access_870_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/$entry
            word_access_0_873: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/word_access_0 
              signal word_access_0_873_start: Boolean;
              signal Xentry_874_symbol: Boolean;
              signal Xexit_875_symbol: Boolean;
              signal rr_876_symbol : Boolean;
              signal ra_877_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_873_start <= Xentry_871_symbol; -- control passed to block
              Xentry_874_symbol  <= word_access_0_873_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/word_access_0/$entry
              rr_876_symbol <= Xentry_874_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/word_access_0/rr
              simple_obj_ref_164_store_0_req_0 <= rr_876_symbol; -- link to DP
              ra_877_symbol <= simple_obj_ref_164_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/word_access_0/ra
              Xexit_875_symbol <= ra_877_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/word_access_0/$exit
              word_access_0_873_symbol <= Xexit_875_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/word_access_0
            Xexit_872_symbol <= word_access_0_873_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access/$exit
            word_access_870_symbol <= Xexit_872_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/word_access
          Xexit_867_symbol <= word_access_870_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request/$exit
          simple_obj_ref_164_request_865_symbol <= Xexit_867_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_request
        simple_obj_ref_164_complete_878: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete 
          signal simple_obj_ref_164_complete_878_start: Boolean;
          signal Xentry_879_symbol: Boolean;
          signal Xexit_880_symbol: Boolean;
          signal word_access_881_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_164_complete_878_start <= simple_obj_ref_164_active_x_x862_symbol; -- control passed to block
          Xentry_879_symbol  <= simple_obj_ref_164_complete_878_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/$entry
          word_access_881: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access 
            signal word_access_881_start: Boolean;
            signal Xentry_882_symbol: Boolean;
            signal Xexit_883_symbol: Boolean;
            signal word_access_0_884_symbol : Boolean;
            -- 
          begin -- 
            word_access_881_start <= Xentry_879_symbol; -- control passed to block
            Xentry_882_symbol  <= word_access_881_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/$entry
            word_access_0_884: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/word_access_0 
              signal word_access_0_884_start: Boolean;
              signal Xentry_885_symbol: Boolean;
              signal Xexit_886_symbol: Boolean;
              signal cr_887_symbol : Boolean;
              signal ca_888_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_884_start <= Xentry_882_symbol; -- control passed to block
              Xentry_885_symbol  <= word_access_0_884_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/word_access_0/$entry
              cr_887_symbol <= Xentry_885_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/word_access_0/cr
              simple_obj_ref_164_store_0_req_1 <= cr_887_symbol; -- link to DP
              ca_888_symbol <= simple_obj_ref_164_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/word_access_0/ca
              Xexit_886_symbol <= ca_888_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/word_access_0/$exit
              word_access_0_884_symbol <= Xexit_886_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/word_access_0
            Xexit_883_symbol <= word_access_0_884_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access/$exit
            word_access_881_symbol <= Xexit_883_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/word_access
          Xexit_880_symbol <= word_access_881_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete/$exit
          simple_obj_ref_164_complete_878_symbol <= Xexit_880_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164_complete
        Xexit_858_symbol <= assign_stmt_166_completed_x_x860_symbol; -- transition branch_block_stmt_135/assign_stmt_166/$exit
        assign_stmt_166_856_symbol <= Xexit_858_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_166
      assign_stmt_171_889: Block -- branch_block_stmt_135/assign_stmt_171 
        signal assign_stmt_171_889_start: Boolean;
        signal Xentry_890_symbol: Boolean;
        signal Xexit_891_symbol: Boolean;
        signal assign_stmt_171_active_x_x892_symbol : Boolean;
        signal assign_stmt_171_completed_x_x893_symbol : Boolean;
        signal simple_obj_ref_169_trigger_x_x894_symbol : Boolean;
        signal simple_obj_ref_169_active_x_x895_symbol : Boolean;
        signal simple_obj_ref_169_root_address_calculated_896_symbol : Boolean;
        signal simple_obj_ref_169_word_address_calculated_897_symbol : Boolean;
        signal simple_obj_ref_169_request_898_symbol : Boolean;
        signal simple_obj_ref_169_complete_911_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_171_889_start <= assign_stmt_171_x_xentry_x_xx_x701_symbol; -- control passed to block
        Xentry_890_symbol  <= assign_stmt_171_889_start; -- transition branch_block_stmt_135/assign_stmt_171/$entry
        assign_stmt_171_active_x_x892_symbol <= Xentry_890_symbol; -- transition branch_block_stmt_135/assign_stmt_171/assign_stmt_171_active_
        assign_stmt_171_completed_x_x893_symbol <= simple_obj_ref_169_complete_911_symbol; -- transition branch_block_stmt_135/assign_stmt_171/assign_stmt_171_completed_
        simple_obj_ref_169_trigger_x_x894_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_trigger_ 
          signal simple_obj_ref_169_trigger_x_x894_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_169_trigger_x_x894_predecessors(0) <= simple_obj_ref_169_word_address_calculated_897_symbol;
          simple_obj_ref_169_trigger_x_x894_predecessors(1) <= assign_stmt_171_active_x_x892_symbol;
          simple_obj_ref_169_trigger_x_x894_join: join -- 
            port map( -- 
              preds => simple_obj_ref_169_trigger_x_x894_predecessors,
              symbol_out => simple_obj_ref_169_trigger_x_x894_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_trigger_
        simple_obj_ref_169_active_x_x895_symbol <= simple_obj_ref_169_request_898_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_active_
        simple_obj_ref_169_root_address_calculated_896_symbol <= Xentry_890_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_root_address_calculated
        simple_obj_ref_169_word_address_calculated_897_symbol <= simple_obj_ref_169_root_address_calculated_896_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_word_address_calculated
        simple_obj_ref_169_request_898: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request 
          signal simple_obj_ref_169_request_898_start: Boolean;
          signal Xentry_899_symbol: Boolean;
          signal Xexit_900_symbol: Boolean;
          signal split_req_901_symbol : Boolean;
          signal split_ack_902_symbol : Boolean;
          signal word_access_903_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_169_request_898_start <= simple_obj_ref_169_trigger_x_x894_symbol; -- control passed to block
          Xentry_899_symbol  <= simple_obj_ref_169_request_898_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/$entry
          split_req_901_symbol <= Xentry_899_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/split_req
          simple_obj_ref_169_gather_scatter_req_0 <= split_req_901_symbol; -- link to DP
          split_ack_902_symbol <= simple_obj_ref_169_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/split_ack
          word_access_903: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access 
            signal word_access_903_start: Boolean;
            signal Xentry_904_symbol: Boolean;
            signal Xexit_905_symbol: Boolean;
            signal word_access_0_906_symbol : Boolean;
            -- 
          begin -- 
            word_access_903_start <= split_ack_902_symbol; -- control passed to block
            Xentry_904_symbol  <= word_access_903_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/$entry
            word_access_0_906: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/word_access_0 
              signal word_access_0_906_start: Boolean;
              signal Xentry_907_symbol: Boolean;
              signal Xexit_908_symbol: Boolean;
              signal rr_909_symbol : Boolean;
              signal ra_910_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_906_start <= Xentry_904_symbol; -- control passed to block
              Xentry_907_symbol  <= word_access_0_906_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/word_access_0/$entry
              rr_909_symbol <= Xentry_907_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/word_access_0/rr
              simple_obj_ref_169_store_0_req_0 <= rr_909_symbol; -- link to DP
              ra_910_symbol <= simple_obj_ref_169_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/word_access_0/ra
              Xexit_908_symbol <= ra_910_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/word_access_0/$exit
              word_access_0_906_symbol <= Xexit_908_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/word_access_0
            Xexit_905_symbol <= word_access_0_906_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access/$exit
            word_access_903_symbol <= Xexit_905_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/word_access
          Xexit_900_symbol <= word_access_903_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request/$exit
          simple_obj_ref_169_request_898_symbol <= Xexit_900_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_request
        simple_obj_ref_169_complete_911: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete 
          signal simple_obj_ref_169_complete_911_start: Boolean;
          signal Xentry_912_symbol: Boolean;
          signal Xexit_913_symbol: Boolean;
          signal word_access_914_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_169_complete_911_start <= simple_obj_ref_169_active_x_x895_symbol; -- control passed to block
          Xentry_912_symbol  <= simple_obj_ref_169_complete_911_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/$entry
          word_access_914: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access 
            signal word_access_914_start: Boolean;
            signal Xentry_915_symbol: Boolean;
            signal Xexit_916_symbol: Boolean;
            signal word_access_0_917_symbol : Boolean;
            -- 
          begin -- 
            word_access_914_start <= Xentry_912_symbol; -- control passed to block
            Xentry_915_symbol  <= word_access_914_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/$entry
            word_access_0_917: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/word_access_0 
              signal word_access_0_917_start: Boolean;
              signal Xentry_918_symbol: Boolean;
              signal Xexit_919_symbol: Boolean;
              signal cr_920_symbol : Boolean;
              signal ca_921_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_917_start <= Xentry_915_symbol; -- control passed to block
              Xentry_918_symbol  <= word_access_0_917_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/word_access_0/$entry
              cr_920_symbol <= Xentry_918_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/word_access_0/cr
              simple_obj_ref_169_store_0_req_1 <= cr_920_symbol; -- link to DP
              ca_921_symbol <= simple_obj_ref_169_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/word_access_0/ca
              Xexit_919_symbol <= ca_921_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/word_access_0/$exit
              word_access_0_917_symbol <= Xexit_919_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/word_access_0
            Xexit_916_symbol <= word_access_0_917_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access/$exit
            word_access_914_symbol <= Xexit_916_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/word_access
          Xexit_913_symbol <= word_access_914_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete/$exit
          simple_obj_ref_169_complete_911_symbol <= Xexit_913_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169_complete
        Xexit_891_symbol <= assign_stmt_171_completed_x_x893_symbol; -- transition branch_block_stmt_135/assign_stmt_171/$exit
        assign_stmt_171_889_symbol <= Xexit_891_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_171
      assign_stmt_176_to_assign_stmt_179_922: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179 
        signal assign_stmt_176_to_assign_stmt_179_922_start: Boolean;
        signal Xentry_923_symbol: Boolean;
        signal Xexit_924_symbol: Boolean;
        signal assign_stmt_176_active_x_x925_symbol : Boolean;
        signal assign_stmt_176_completed_x_x926_symbol : Boolean;
        signal simple_obj_ref_175_trigger_x_x927_symbol : Boolean;
        signal simple_obj_ref_175_active_x_x928_symbol : Boolean;
        signal simple_obj_ref_175_root_address_calculated_929_symbol : Boolean;
        signal simple_obj_ref_175_word_address_calculated_930_symbol : Boolean;
        signal simple_obj_ref_175_request_931_symbol : Boolean;
        signal simple_obj_ref_175_complete_942_symbol : Boolean;
        signal assign_stmt_179_active_x_x955_symbol : Boolean;
        signal assign_stmt_179_completed_x_x956_symbol : Boolean;
        signal simple_obj_ref_178_complete_957_symbol : Boolean;
        signal simple_obj_ref_177_trigger_x_x958_symbol : Boolean;
        signal simple_obj_ref_177_active_x_x959_symbol : Boolean;
        signal simple_obj_ref_177_root_address_calculated_960_symbol : Boolean;
        signal simple_obj_ref_177_word_address_calculated_961_symbol : Boolean;
        signal simple_obj_ref_177_request_962_symbol : Boolean;
        signal simple_obj_ref_177_complete_975_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_176_to_assign_stmt_179_922_start <= assign_stmt_176_to_assign_stmt_179_x_xentry_x_xx_x705_symbol; -- control passed to block
        Xentry_923_symbol  <= assign_stmt_176_to_assign_stmt_179_922_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/$entry
        assign_stmt_176_active_x_x925_symbol <= simple_obj_ref_175_complete_942_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/assign_stmt_176_active_
        assign_stmt_176_completed_x_x926_symbol <= assign_stmt_176_active_x_x925_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/assign_stmt_176_completed_
        simple_obj_ref_175_trigger_x_x927_symbol <= simple_obj_ref_175_word_address_calculated_930_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_trigger_
        simple_obj_ref_175_active_x_x928_symbol <= simple_obj_ref_175_request_931_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_active_
        simple_obj_ref_175_root_address_calculated_929_symbol <= Xentry_923_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_root_address_calculated
        simple_obj_ref_175_word_address_calculated_930_symbol <= simple_obj_ref_175_root_address_calculated_929_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_word_address_calculated
        simple_obj_ref_175_request_931: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request 
          signal simple_obj_ref_175_request_931_start: Boolean;
          signal Xentry_932_symbol: Boolean;
          signal Xexit_933_symbol: Boolean;
          signal word_access_934_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_175_request_931_start <= simple_obj_ref_175_trigger_x_x927_symbol; -- control passed to block
          Xentry_932_symbol  <= simple_obj_ref_175_request_931_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/$entry
          word_access_934: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access 
            signal word_access_934_start: Boolean;
            signal Xentry_935_symbol: Boolean;
            signal Xexit_936_symbol: Boolean;
            signal word_access_0_937_symbol : Boolean;
            -- 
          begin -- 
            word_access_934_start <= Xentry_932_symbol; -- control passed to block
            Xentry_935_symbol  <= word_access_934_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/$entry
            word_access_0_937: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/word_access_0 
              signal word_access_0_937_start: Boolean;
              signal Xentry_938_symbol: Boolean;
              signal Xexit_939_symbol: Boolean;
              signal rr_940_symbol : Boolean;
              signal ra_941_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_937_start <= Xentry_935_symbol; -- control passed to block
              Xentry_938_symbol  <= word_access_0_937_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/word_access_0/$entry
              rr_940_symbol <= Xentry_938_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/word_access_0/rr
              simple_obj_ref_175_load_0_req_0 <= rr_940_symbol; -- link to DP
              ra_941_symbol <= simple_obj_ref_175_load_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/word_access_0/ra
              Xexit_939_symbol <= ra_941_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/word_access_0/$exit
              word_access_0_937_symbol <= Xexit_939_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/word_access_0
            Xexit_936_symbol <= word_access_0_937_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access/$exit
            word_access_934_symbol <= Xexit_936_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/word_access
          Xexit_933_symbol <= word_access_934_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request/$exit
          simple_obj_ref_175_request_931_symbol <= Xexit_933_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_request
        simple_obj_ref_175_complete_942: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete 
          signal simple_obj_ref_175_complete_942_start: Boolean;
          signal Xentry_943_symbol: Boolean;
          signal Xexit_944_symbol: Boolean;
          signal word_access_945_symbol : Boolean;
          signal merge_req_953_symbol : Boolean;
          signal merge_ack_954_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_175_complete_942_start <= simple_obj_ref_175_active_x_x928_symbol; -- control passed to block
          Xentry_943_symbol  <= simple_obj_ref_175_complete_942_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/$entry
          word_access_945: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access 
            signal word_access_945_start: Boolean;
            signal Xentry_946_symbol: Boolean;
            signal Xexit_947_symbol: Boolean;
            signal word_access_0_948_symbol : Boolean;
            -- 
          begin -- 
            word_access_945_start <= Xentry_943_symbol; -- control passed to block
            Xentry_946_symbol  <= word_access_945_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/$entry
            word_access_0_948: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/word_access_0 
              signal word_access_0_948_start: Boolean;
              signal Xentry_949_symbol: Boolean;
              signal Xexit_950_symbol: Boolean;
              signal cr_951_symbol : Boolean;
              signal ca_952_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_948_start <= Xentry_946_symbol; -- control passed to block
              Xentry_949_symbol  <= word_access_0_948_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/word_access_0/$entry
              cr_951_symbol <= Xentry_949_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/word_access_0/cr
              simple_obj_ref_175_load_0_req_1 <= cr_951_symbol; -- link to DP
              ca_952_symbol <= simple_obj_ref_175_load_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/word_access_0/ca
              Xexit_950_symbol <= ca_952_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/word_access_0/$exit
              word_access_0_948_symbol <= Xexit_950_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/word_access_0
            Xexit_947_symbol <= word_access_0_948_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access/$exit
            word_access_945_symbol <= Xexit_947_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/word_access
          merge_req_953_symbol <= word_access_945_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/merge_req
          simple_obj_ref_175_gather_scatter_req_0 <= merge_req_953_symbol; -- link to DP
          merge_ack_954_symbol <= simple_obj_ref_175_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/merge_ack
          Xexit_944_symbol <= merge_ack_954_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete/$exit
          simple_obj_ref_175_complete_942_symbol <= Xexit_944_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_175_complete
        assign_stmt_179_active_x_x955_symbol <= simple_obj_ref_178_complete_957_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/assign_stmt_179_active_
        assign_stmt_179_completed_x_x956_symbol <= simple_obj_ref_177_complete_975_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/assign_stmt_179_completed_
        simple_obj_ref_178_complete_957_symbol <= assign_stmt_176_completed_x_x926_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_178_complete
        simple_obj_ref_177_trigger_x_x958_block : Block -- non-trivial join transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_trigger_ 
          signal simple_obj_ref_177_trigger_x_x958_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_177_trigger_x_x958_predecessors(0) <= simple_obj_ref_177_word_address_calculated_961_symbol;
          simple_obj_ref_177_trigger_x_x958_predecessors(1) <= assign_stmt_179_active_x_x955_symbol;
          simple_obj_ref_177_trigger_x_x958_join: join -- 
            port map( -- 
              preds => simple_obj_ref_177_trigger_x_x958_predecessors,
              symbol_out => simple_obj_ref_177_trigger_x_x958_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_trigger_
        simple_obj_ref_177_active_x_x959_symbol <= simple_obj_ref_177_request_962_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_active_
        simple_obj_ref_177_root_address_calculated_960_symbol <= Xentry_923_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_root_address_calculated
        simple_obj_ref_177_word_address_calculated_961_symbol <= simple_obj_ref_177_root_address_calculated_960_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_word_address_calculated
        simple_obj_ref_177_request_962: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request 
          signal simple_obj_ref_177_request_962_start: Boolean;
          signal Xentry_963_symbol: Boolean;
          signal Xexit_964_symbol: Boolean;
          signal split_req_965_symbol : Boolean;
          signal split_ack_966_symbol : Boolean;
          signal word_access_967_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_177_request_962_start <= simple_obj_ref_177_trigger_x_x958_symbol; -- control passed to block
          Xentry_963_symbol  <= simple_obj_ref_177_request_962_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/$entry
          split_req_965_symbol <= Xentry_963_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/split_req
          simple_obj_ref_177_gather_scatter_req_0 <= split_req_965_symbol; -- link to DP
          split_ack_966_symbol <= simple_obj_ref_177_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/split_ack
          word_access_967: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access 
            signal word_access_967_start: Boolean;
            signal Xentry_968_symbol: Boolean;
            signal Xexit_969_symbol: Boolean;
            signal word_access_0_970_symbol : Boolean;
            -- 
          begin -- 
            word_access_967_start <= split_ack_966_symbol; -- control passed to block
            Xentry_968_symbol  <= word_access_967_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/$entry
            word_access_0_970: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/word_access_0 
              signal word_access_0_970_start: Boolean;
              signal Xentry_971_symbol: Boolean;
              signal Xexit_972_symbol: Boolean;
              signal rr_973_symbol : Boolean;
              signal ra_974_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_970_start <= Xentry_968_symbol; -- control passed to block
              Xentry_971_symbol  <= word_access_0_970_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/word_access_0/$entry
              rr_973_symbol <= Xentry_971_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/word_access_0/rr
              simple_obj_ref_177_store_0_req_0 <= rr_973_symbol; -- link to DP
              ra_974_symbol <= simple_obj_ref_177_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/word_access_0/ra
              Xexit_972_symbol <= ra_974_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/word_access_0/$exit
              word_access_0_970_symbol <= Xexit_972_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/word_access_0
            Xexit_969_symbol <= word_access_0_970_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access/$exit
            word_access_967_symbol <= Xexit_969_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/word_access
          Xexit_964_symbol <= word_access_967_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request/$exit
          simple_obj_ref_177_request_962_symbol <= Xexit_964_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_request
        simple_obj_ref_177_complete_975: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete 
          signal simple_obj_ref_177_complete_975_start: Boolean;
          signal Xentry_976_symbol: Boolean;
          signal Xexit_977_symbol: Boolean;
          signal word_access_978_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_177_complete_975_start <= simple_obj_ref_177_active_x_x959_symbol; -- control passed to block
          Xentry_976_symbol  <= simple_obj_ref_177_complete_975_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/$entry
          word_access_978: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access 
            signal word_access_978_start: Boolean;
            signal Xentry_979_symbol: Boolean;
            signal Xexit_980_symbol: Boolean;
            signal word_access_0_981_symbol : Boolean;
            -- 
          begin -- 
            word_access_978_start <= Xentry_976_symbol; -- control passed to block
            Xentry_979_symbol  <= word_access_978_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/$entry
            word_access_0_981: Block -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/word_access_0 
              signal word_access_0_981_start: Boolean;
              signal Xentry_982_symbol: Boolean;
              signal Xexit_983_symbol: Boolean;
              signal cr_984_symbol : Boolean;
              signal ca_985_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_981_start <= Xentry_979_symbol; -- control passed to block
              Xentry_982_symbol  <= word_access_0_981_start; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/word_access_0/$entry
              cr_984_symbol <= Xentry_982_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/word_access_0/cr
              simple_obj_ref_177_store_0_req_1 <= cr_984_symbol; -- link to DP
              ca_985_symbol <= simple_obj_ref_177_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/word_access_0/ca
              Xexit_983_symbol <= ca_985_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/word_access_0/$exit
              word_access_0_981_symbol <= Xexit_983_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/word_access_0
            Xexit_980_symbol <= word_access_0_981_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access/$exit
            word_access_978_symbol <= Xexit_980_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/word_access
          Xexit_977_symbol <= word_access_978_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete/$exit
          simple_obj_ref_177_complete_975_symbol <= Xexit_977_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/simple_obj_ref_177_complete
        Xexit_924_symbol <= assign_stmt_179_completed_x_x956_symbol; -- transition branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179/$exit
        assign_stmt_176_to_assign_stmt_179_922_symbol <= Xexit_924_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_176_to_assign_stmt_179
      assign_stmt_184_986: Block -- branch_block_stmt_135/assign_stmt_184 
        signal assign_stmt_184_986_start: Boolean;
        signal Xentry_987_symbol: Boolean;
        signal Xexit_988_symbol: Boolean;
        signal assign_stmt_184_active_x_x989_symbol : Boolean;
        signal assign_stmt_184_completed_x_x990_symbol : Boolean;
        signal simple_obj_ref_183_trigger_x_x991_symbol : Boolean;
        signal simple_obj_ref_183_active_x_x992_symbol : Boolean;
        signal simple_obj_ref_183_root_address_calculated_993_symbol : Boolean;
        signal simple_obj_ref_183_word_address_calculated_994_symbol : Boolean;
        signal simple_obj_ref_183_request_995_symbol : Boolean;
        signal simple_obj_ref_183_complete_1006_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_184_986_start <= assign_stmt_184_x_xentry_x_xx_x709_symbol; -- control passed to block
        Xentry_987_symbol  <= assign_stmt_184_986_start; -- transition branch_block_stmt_135/assign_stmt_184/$entry
        assign_stmt_184_active_x_x989_symbol <= simple_obj_ref_183_complete_1006_symbol; -- transition branch_block_stmt_135/assign_stmt_184/assign_stmt_184_active_
        assign_stmt_184_completed_x_x990_symbol <= assign_stmt_184_active_x_x989_symbol; -- transition branch_block_stmt_135/assign_stmt_184/assign_stmt_184_completed_
        simple_obj_ref_183_trigger_x_x991_symbol <= simple_obj_ref_183_word_address_calculated_994_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_trigger_
        simple_obj_ref_183_active_x_x992_symbol <= simple_obj_ref_183_request_995_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_active_
        simple_obj_ref_183_root_address_calculated_993_symbol <= Xentry_987_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_root_address_calculated
        simple_obj_ref_183_word_address_calculated_994_symbol <= simple_obj_ref_183_root_address_calculated_993_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_word_address_calculated
        simple_obj_ref_183_request_995: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request 
          signal simple_obj_ref_183_request_995_start: Boolean;
          signal Xentry_996_symbol: Boolean;
          signal Xexit_997_symbol: Boolean;
          signal word_access_998_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_183_request_995_start <= simple_obj_ref_183_trigger_x_x991_symbol; -- control passed to block
          Xentry_996_symbol  <= simple_obj_ref_183_request_995_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/$entry
          word_access_998: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access 
            signal word_access_998_start: Boolean;
            signal Xentry_999_symbol: Boolean;
            signal Xexit_1000_symbol: Boolean;
            signal word_access_0_1001_symbol : Boolean;
            -- 
          begin -- 
            word_access_998_start <= Xentry_996_symbol; -- control passed to block
            Xentry_999_symbol  <= word_access_998_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/$entry
            word_access_0_1001: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/word_access_0 
              signal word_access_0_1001_start: Boolean;
              signal Xentry_1002_symbol: Boolean;
              signal Xexit_1003_symbol: Boolean;
              signal rr_1004_symbol : Boolean;
              signal ra_1005_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1001_start <= Xentry_999_symbol; -- control passed to block
              Xentry_1002_symbol  <= word_access_0_1001_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/word_access_0/$entry
              rr_1004_symbol <= Xentry_1002_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/word_access_0/rr
              simple_obj_ref_183_load_0_req_0 <= rr_1004_symbol; -- link to DP
              ra_1005_symbol <= simple_obj_ref_183_load_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/word_access_0/ra
              Xexit_1003_symbol <= ra_1005_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/word_access_0/$exit
              word_access_0_1001_symbol <= Xexit_1003_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/word_access_0
            Xexit_1000_symbol <= word_access_0_1001_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access/$exit
            word_access_998_symbol <= Xexit_1000_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/word_access
          Xexit_997_symbol <= word_access_998_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request/$exit
          simple_obj_ref_183_request_995_symbol <= Xexit_997_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_request
        simple_obj_ref_183_complete_1006: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete 
          signal simple_obj_ref_183_complete_1006_start: Boolean;
          signal Xentry_1007_symbol: Boolean;
          signal Xexit_1008_symbol: Boolean;
          signal word_access_1009_symbol : Boolean;
          signal merge_req_1017_symbol : Boolean;
          signal merge_ack_1018_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_183_complete_1006_start <= simple_obj_ref_183_active_x_x992_symbol; -- control passed to block
          Xentry_1007_symbol  <= simple_obj_ref_183_complete_1006_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/$entry
          word_access_1009: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access 
            signal word_access_1009_start: Boolean;
            signal Xentry_1010_symbol: Boolean;
            signal Xexit_1011_symbol: Boolean;
            signal word_access_0_1012_symbol : Boolean;
            -- 
          begin -- 
            word_access_1009_start <= Xentry_1007_symbol; -- control passed to block
            Xentry_1010_symbol  <= word_access_1009_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/$entry
            word_access_0_1012: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/word_access_0 
              signal word_access_0_1012_start: Boolean;
              signal Xentry_1013_symbol: Boolean;
              signal Xexit_1014_symbol: Boolean;
              signal cr_1015_symbol : Boolean;
              signal ca_1016_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1012_start <= Xentry_1010_symbol; -- control passed to block
              Xentry_1013_symbol  <= word_access_0_1012_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/word_access_0/$entry
              cr_1015_symbol <= Xentry_1013_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/word_access_0/cr
              simple_obj_ref_183_load_0_req_1 <= cr_1015_symbol; -- link to DP
              ca_1016_symbol <= simple_obj_ref_183_load_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/word_access_0/ca
              Xexit_1014_symbol <= ca_1016_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/word_access_0/$exit
              word_access_0_1012_symbol <= Xexit_1014_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/word_access_0
            Xexit_1011_symbol <= word_access_0_1012_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access/$exit
            word_access_1009_symbol <= Xexit_1011_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/word_access
          merge_req_1017_symbol <= word_access_1009_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/merge_req
          simple_obj_ref_183_gather_scatter_req_0 <= merge_req_1017_symbol; -- link to DP
          merge_ack_1018_symbol <= simple_obj_ref_183_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/merge_ack
          Xexit_1008_symbol <= merge_ack_1018_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete/$exit
          simple_obj_ref_183_complete_1006_symbol <= Xexit_1008_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183_complete
        Xexit_988_symbol <= assign_stmt_184_completed_x_x990_symbol; -- transition branch_block_stmt_135/assign_stmt_184/$exit
        assign_stmt_184_986_symbol <= Xexit_988_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_184
      merge_stmt_163_dead_link_1019: Block -- branch_block_stmt_135/merge_stmt_163_dead_link 
        signal merge_stmt_163_dead_link_1019_start: Boolean;
        signal Xentry_1020_symbol: Boolean;
        signal Xexit_1021_symbol: Boolean;
        signal dead_transition_1022_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_163_dead_link_1019_start <= merge_stmt_163_x_xentry_x_xx_x695_symbol; -- control passed to block
        Xentry_1020_symbol  <= merge_stmt_163_dead_link_1019_start; -- transition branch_block_stmt_135/merge_stmt_163_dead_link/$entry
        dead_transition_1022_symbol <= false;
        Xexit_1021_symbol <= dead_transition_1022_symbol; -- transition branch_block_stmt_135/merge_stmt_163_dead_link/$exit
        merge_stmt_163_dead_link_1019_symbol <= Xexit_1021_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_163_dead_link
      bb_0_bb_1_PhiReq_1023: Block -- branch_block_stmt_135/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_1023_start: Boolean;
        signal Xentry_1024_symbol: Boolean;
        signal Xexit_1025_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_1023_start <= bb_0_bb_1_854_symbol; -- control passed to block
        Xentry_1024_symbol  <= bb_0_bb_1_PhiReq_1023_start; -- transition branch_block_stmt_135/bb_0_bb_1_PhiReq/$entry
        Xexit_1025_symbol <= Xentry_1024_symbol; -- transition branch_block_stmt_135/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_1023_symbol <= Xexit_1025_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_0_bb_1_PhiReq
      merge_stmt_163_PhiReqMerge_1026_symbol  <=  bb_0_bb_1_PhiReq_1023_symbol; -- place branch_block_stmt_135/merge_stmt_163_PhiReqMerge (optimized away) 
      merge_stmt_163_PhiAck_1027: Block -- branch_block_stmt_135/merge_stmt_163_PhiAck 
        signal merge_stmt_163_PhiAck_1027_start: Boolean;
        signal Xentry_1028_symbol: Boolean;
        signal Xexit_1029_symbol: Boolean;
        signal dummy_1030_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_163_PhiAck_1027_start <= merge_stmt_163_PhiReqMerge_1026_symbol; -- control passed to block
        Xentry_1028_symbol  <= merge_stmt_163_PhiAck_1027_start; -- transition branch_block_stmt_135/merge_stmt_163_PhiAck/$entry
        dummy_1030_symbol <= Xentry_1028_symbol; -- transition branch_block_stmt_135/merge_stmt_163_PhiAck/dummy
        Xexit_1029_symbol <= dummy_1030_symbol; -- transition branch_block_stmt_135/merge_stmt_163_PhiAck/$exit
        merge_stmt_163_PhiAck_1027_symbol <= Xexit_1029_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_163_PhiAck
      bb_0_bb_2_PhiReq_1031: Block -- branch_block_stmt_135/bb_0_bb_2_PhiReq 
        signal bb_0_bb_2_PhiReq_1031_start: Boolean;
        signal Xentry_1032_symbol: Boolean;
        signal Xexit_1033_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_2_PhiReq_1031_start <= bb_0_bb_2_855_symbol; -- control passed to block
        Xentry_1032_symbol  <= bb_0_bb_2_PhiReq_1031_start; -- transition branch_block_stmt_135/bb_0_bb_2_PhiReq/$entry
        Xexit_1033_symbol <= Xentry_1032_symbol; -- transition branch_block_stmt_135/bb_0_bb_2_PhiReq/$exit
        bb_0_bb_2_PhiReq_1031_symbol <= Xexit_1033_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_0_bb_2_PhiReq
      merge_stmt_168_PhiReqMerge_1034_symbol  <=  bb_0_bb_2_PhiReq_1031_symbol; -- place branch_block_stmt_135/merge_stmt_168_PhiReqMerge (optimized away) 
      merge_stmt_168_PhiAck_1035: Block -- branch_block_stmt_135/merge_stmt_168_PhiAck 
        signal merge_stmt_168_PhiAck_1035_start: Boolean;
        signal Xentry_1036_symbol: Boolean;
        signal Xexit_1037_symbol: Boolean;
        signal dummy_1038_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_168_PhiAck_1035_start <= merge_stmt_168_PhiReqMerge_1034_symbol; -- control passed to block
        Xentry_1036_symbol  <= merge_stmt_168_PhiAck_1035_start; -- transition branch_block_stmt_135/merge_stmt_168_PhiAck/$entry
        dummy_1038_symbol <= Xentry_1036_symbol; -- transition branch_block_stmt_135/merge_stmt_168_PhiAck/dummy
        Xexit_1037_symbol <= dummy_1038_symbol; -- transition branch_block_stmt_135/merge_stmt_168_PhiAck/$exit
        merge_stmt_168_PhiAck_1035_symbol <= Xexit_1037_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_168_PhiAck
      bb_1_bb_3_PhiReq_1039: Block -- branch_block_stmt_135/bb_1_bb_3_PhiReq 
        signal bb_1_bb_3_PhiReq_1039_start: Boolean;
        signal Xentry_1040_symbol: Boolean;
        signal Xexit_1041_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_3_PhiReq_1039_start <= bb_1_bb_3_699_symbol; -- control passed to block
        Xentry_1040_symbol  <= bb_1_bb_3_PhiReq_1039_start; -- transition branch_block_stmt_135/bb_1_bb_3_PhiReq/$entry
        Xexit_1041_symbol <= Xentry_1040_symbol; -- transition branch_block_stmt_135/bb_1_bb_3_PhiReq/$exit
        bb_1_bb_3_PhiReq_1039_symbol <= Xexit_1041_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_1_bb_3_PhiReq
      bb_2_bb_3_PhiReq_1042: Block -- branch_block_stmt_135/bb_2_bb_3_PhiReq 
        signal bb_2_bb_3_PhiReq_1042_start: Boolean;
        signal Xentry_1043_symbol: Boolean;
        signal Xexit_1044_symbol: Boolean;
        -- 
      begin -- 
        bb_2_bb_3_PhiReq_1042_start <= bb_2_bb_3_703_symbol; -- control passed to block
        Xentry_1043_symbol  <= bb_2_bb_3_PhiReq_1042_start; -- transition branch_block_stmt_135/bb_2_bb_3_PhiReq/$entry
        Xexit_1044_symbol <= Xentry_1043_symbol; -- transition branch_block_stmt_135/bb_2_bb_3_PhiReq/$exit
        bb_2_bb_3_PhiReq_1042_symbol <= Xexit_1044_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_2_bb_3_PhiReq
      merge_stmt_173_PhiReqMerge_1045_symbol  <=  bb_1_bb_3_PhiReq_1039_symbol or bb_2_bb_3_PhiReq_1042_symbol; -- place branch_block_stmt_135/merge_stmt_173_PhiReqMerge (optimized away) 
      merge_stmt_173_PhiAck_1046: Block -- branch_block_stmt_135/merge_stmt_173_PhiAck 
        signal merge_stmt_173_PhiAck_1046_start: Boolean;
        signal Xentry_1047_symbol: Boolean;
        signal Xexit_1048_symbol: Boolean;
        signal dummy_1049_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_173_PhiAck_1046_start <= merge_stmt_173_PhiReqMerge_1045_symbol; -- control passed to block
        Xentry_1047_symbol  <= merge_stmt_173_PhiAck_1046_start; -- transition branch_block_stmt_135/merge_stmt_173_PhiAck/$entry
        dummy_1049_symbol <= Xentry_1047_symbol; -- transition branch_block_stmt_135/merge_stmt_173_PhiAck/dummy
        Xexit_1048_symbol <= dummy_1049_symbol; -- transition branch_block_stmt_135/merge_stmt_173_PhiAck/$exit
        merge_stmt_173_PhiAck_1046_symbol <= Xexit_1048_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_173_PhiAck
      return_x_xx_xPhiReq_1050: Block -- branch_block_stmt_135/return___PhiReq 
        signal return_x_xx_xPhiReq_1050_start: Boolean;
        signal Xentry_1051_symbol: Boolean;
        signal Xexit_1052_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_1050_start <= return_x_xx_x707_symbol; -- control passed to block
        Xentry_1051_symbol  <= return_x_xx_xPhiReq_1050_start; -- transition branch_block_stmt_135/return___PhiReq/$entry
        Xexit_1052_symbol <= Xentry_1051_symbol; -- transition branch_block_stmt_135/return___PhiReq/$exit
        return_x_xx_xPhiReq_1050_symbol <= Xexit_1052_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/return___PhiReq
      merge_stmt_181_PhiReqMerge_1053_symbol  <=  return_x_xx_xPhiReq_1050_symbol; -- place branch_block_stmt_135/merge_stmt_181_PhiReqMerge (optimized away) 
      merge_stmt_181_PhiAck_1054: Block -- branch_block_stmt_135/merge_stmt_181_PhiAck 
        signal merge_stmt_181_PhiAck_1054_start: Boolean;
        signal Xentry_1055_symbol: Boolean;
        signal Xexit_1056_symbol: Boolean;
        signal dummy_1057_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_181_PhiAck_1054_start <= merge_stmt_181_PhiReqMerge_1053_symbol; -- control passed to block
        Xentry_1055_symbol  <= merge_stmt_181_PhiAck_1054_start; -- transition branch_block_stmt_135/merge_stmt_181_PhiAck/$entry
        dummy_1057_symbol <= Xentry_1055_symbol; -- transition branch_block_stmt_135/merge_stmt_181_PhiAck/dummy
        Xexit_1056_symbol <= dummy_1057_symbol; -- transition branch_block_stmt_135/merge_stmt_181_PhiAck/$exit
        merge_stmt_181_PhiAck_1054_symbol <= Xexit_1056_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_181_PhiAck
      Xexit_684_symbol <= branch_block_stmt_135_x_xexit_x_xx_x686_symbol; -- transition branch_block_stmt_135/$exit
      branch_block_stmt_135_682_symbol <= Xexit_684_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_135
    Xexit_681_symbol <= branch_block_stmt_135_682_symbol; -- transition $exit
    fin  <=  '1' when Xexit_681_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal expr_139_wire_constant : std_logic_vector(31 downto 0);
    signal expr_141_wire_constant : std_logic_vector(31 downto 0);
    signal expr_142_wire_constant : std_logic_vector(31 downto 0);
    signal expr_153_wire_constant : std_logic_vector(31 downto 0);
    signal expr_165_wire_constant : std_logic_vector(31 downto 0);
    signal expr_170_wire_constant : std_logic_vector(31 downto 0);
    signal iNsTr_11_176 : std_logic_vector(31 downto 0);
    signal iNsTr_2_144 : std_logic_vector(31 downto 0);
    signal iNsTr_4_150 : std_logic_vector(31 downto 0);
    signal iNsTr_5_156 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_138_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_138_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_145_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_145_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_149_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_149_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_164_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_164_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_169_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_169_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_175_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_175_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_177_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_177_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_183_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_183_word_address_0 : std_logic_vector(0 downto 0);
    signal xxmainxxbodyxxc_base_address : std_logic_vector(0 downto 0);
    signal xxmainxxbodyxxiNsTr_0_base_address : std_logic_vector(0 downto 0);
    signal xxmainxxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    expr_139_wire_constant <= "00000000000000000000000000000000";
    expr_141_wire_constant <= "00000000000000000000000000000000";
    expr_142_wire_constant <= "00000000000000000000000000000000";
    expr_153_wire_constant <= "00000000000000000000000000000000";
    expr_165_wire_constant <= "00000000000000000000000000000000";
    expr_170_wire_constant <= "00000000000000000000000000000000";
    simple_obj_ref_138_word_address_0 <= "0";
    simple_obj_ref_145_word_address_0 <= "0";
    simple_obj_ref_149_word_address_0 <= "0";
    simple_obj_ref_164_word_address_0 <= "0";
    simple_obj_ref_169_word_address_0 <= "0";
    simple_obj_ref_175_word_address_0 <= "0";
    simple_obj_ref_177_word_address_0 <= "0";
    simple_obj_ref_183_word_address_0 <= "0";
    xxmainxxbodyxxc_base_address <= "0";
    xxmainxxbodyxxiNsTr_0_base_address <= "0";
    xxmainxxstored_ret_val_x_xx_xbase_address <= "0";
    simple_obj_ref_138_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_138_gather_scatter_ack_0 <= simple_obj_ref_138_gather_scatter_req_0;
      aggregated_sig <= expr_139_wire_constant;
      simple_obj_ref_138_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_145_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_145_gather_scatter_ack_0 <= simple_obj_ref_145_gather_scatter_req_0;
      aggregated_sig <= iNsTr_2_144;
      simple_obj_ref_145_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_149_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_149_gather_scatter_ack_0 <= simple_obj_ref_149_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_149_data_0;
      iNsTr_4_150 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_164_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_164_gather_scatter_ack_0 <= simple_obj_ref_164_gather_scatter_req_0;
      aggregated_sig <= expr_165_wire_constant;
      simple_obj_ref_164_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_169_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_169_gather_scatter_ack_0 <= simple_obj_ref_169_gather_scatter_req_0;
      aggregated_sig <= expr_170_wire_constant;
      simple_obj_ref_169_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_175_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_175_gather_scatter_ack_0 <= simple_obj_ref_175_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_175_data_0;
      iNsTr_11_176 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_177_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_177_gather_scatter_ack_0 <= simple_obj_ref_177_gather_scatter_req_0;
      aggregated_sig <= iNsTr_11_176;
      simple_obj_ref_177_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_183_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_183_gather_scatter_ack_0 <= simple_obj_ref_183_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_183_data_0;
      ret_val_x_x <= aggregated_sig(31 downto 0);
      --
    end Block;
    if_stmt_157_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_5_156;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_157_branch_req_0,
          ack0 => if_stmt_157_branch_ack_0,
          ack1 => if_stmt_157_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_154_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_150;
      iNsTr_5_156 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 32,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000000000000000000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_154_inst_req_0,
          ackL => binary_154_inst_ack_0,
          reqR => binary_154_inst_req_1,
          ackR => binary_154_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared load operator group (0) : simple_obj_ref_149_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_149_load_0_req_0;
      simple_obj_ref_149_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_149_load_0_req_1;
      simple_obj_ref_149_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_149_word_address_0;
      simple_obj_ref_149_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_10_lr_req(0),
          mack => memory_space_10_lr_ack(0),
          maddr => memory_space_10_lr_addr(0 downto 0),
          mtag => memory_space_10_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_10_lc_req(0),
          mack => memory_space_10_lc_ack(0),
          mdata => memory_space_10_lc_data(31 downto 0),
          mtag => memory_space_10_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_175_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_175_load_0_req_0;
      simple_obj_ref_175_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_175_load_0_req_1;
      simple_obj_ref_175_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_175_word_address_0;
      simple_obj_ref_175_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_9_lr_req(0),
          mack => memory_space_9_lr_ack(0),
          maddr => memory_space_9_lr_addr(0 downto 0),
          mtag => memory_space_9_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_9_lc_req(0),
          mack => memory_space_9_lc_ack(0),
          mdata => memory_space_9_lc_data(31 downto 0),
          mtag => memory_space_9_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : simple_obj_ref_183_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_183_load_0_req_0;
      simple_obj_ref_183_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_183_load_0_req_1;
      simple_obj_ref_183_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_183_word_address_0;
      simple_obj_ref_183_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_8_lr_req(0),
          mack => memory_space_8_lr_ack(0),
          maddr => memory_space_8_lr_addr(0 downto 0),
          mtag => memory_space_8_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_8_lc_req(0),
          mack => memory_space_8_lc_ack(0),
          mdata => memory_space_8_lc_data(31 downto 0),
          mtag => memory_space_8_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared store operator group (0) : simple_obj_ref_169_store_0 simple_obj_ref_164_store_0 simple_obj_ref_138_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
      signal data_in: std_logic_vector(95 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= simple_obj_ref_169_store_0_req_0;
      reqL(1) <= simple_obj_ref_164_store_0_req_0;
      reqL(0) <= simple_obj_ref_138_store_0_req_0;
      simple_obj_ref_169_store_0_ack_0 <= ackL(2);
      simple_obj_ref_164_store_0_ack_0 <= ackL(1);
      simple_obj_ref_138_store_0_ack_0 <= ackL(0);
      reqR(2) <= simple_obj_ref_169_store_0_req_1;
      reqR(1) <= simple_obj_ref_164_store_0_req_1;
      reqR(0) <= simple_obj_ref_138_store_0_req_1;
      simple_obj_ref_169_store_0_ack_1 <= ackR(2);
      simple_obj_ref_164_store_0_ack_1 <= ackR(1);
      simple_obj_ref_138_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_169_word_address_0 & simple_obj_ref_164_word_address_0 & simple_obj_ref_138_word_address_0;
      data_in <= simple_obj_ref_169_data_0 & simple_obj_ref_164_data_0 & simple_obj_ref_138_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 3,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_9_sr_req(0),
          mack => memory_space_9_sr_ack(0),
          maddr => memory_space_9_sr_addr(0 downto 0),
          mdata => memory_space_9_sr_data(31 downto 0),
          mtag => memory_space_9_sr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 3,
          tag_length => 2 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_9_sc_req(0),
          mack => memory_space_9_sc_ack(0),
          mtag => memory_space_9_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : simple_obj_ref_145_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_145_store_0_req_0;
      simple_obj_ref_145_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_145_store_0_req_1;
      simple_obj_ref_145_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_145_word_address_0;
      data_in <= simple_obj_ref_145_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_10_sr_req(0),
          mack => memory_space_10_sr_ack(0),
          maddr => memory_space_10_sr_addr(0 downto 0),
          mdata => memory_space_10_sr_data(31 downto 0),
          mtag => memory_space_10_sr_tag(0 downto 0),
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
          mreq => memory_space_10_sc_req(0),
          mack => memory_space_10_sc_ack(0),
          mtag => memory_space_10_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : simple_obj_ref_177_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_177_store_0_req_0;
      simple_obj_ref_177_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_177_store_0_req_1;
      simple_obj_ref_177_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_177_word_address_0;
      data_in <= simple_obj_ref_177_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_8_sr_req(0),
          mack => memory_space_8_sr_ack(0),
          maddr => memory_space_8_sr_addr(0 downto 0),
          mdata => memory_space_8_sr_data(31 downto 0),
          mtag => memory_space_8_sr_tag(0 downto 0),
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
          mreq => memory_space_8_sc_req(0),
          mack => memory_space_8_sc_ack(0),
          mtag => memory_space_8_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared call operator group (0) : call_stmt_144_call 
    CallGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_144_call_req_0;
      call_stmt_144_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_144_call_req_1;
      call_stmt_144_call_ack_1 <= ackR(0);
      data_in <= expr_141_wire_constant & expr_142_wire_constant;
      iNsTr_2_144 <= data_out(31 downto 0);
      CallReq: InputMuxBase -- 
        generic map (  iwidth => 64, owidth => 64, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          reqR => sub_call_reqs(0),
          ackR => sub_call_acks(0),
          dataR => sub_call_data(63 downto 0),
          tagR => sub_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBase -- 
        generic map ( 
        iwidth => 32, owidth => 32, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          reqL => sub_return_acks(0), -- cross-over
          ackL => sub_return_reqs(0), -- cross-over
          dataL => sub_return_data(31 downto 0),
          tagL => sub_return_tag(0 downto 0),
          clk => clk,
          reset => reset -- 
        ); -- 
      -- 
    end Block; -- call group 0
    -- 
  end Block; -- data_path
  RegisterBank_memory_space_10: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_10_lr_addr,
      lr_req_in => memory_space_10_lr_req,
      lr_ack_out => memory_space_10_lr_ack,
      lr_tag_in => memory_space_10_lr_tag,
      lc_req_in => memory_space_10_lc_req,
      lc_ack_out => memory_space_10_lc_ack,
      lc_data_out => memory_space_10_lc_data,
      lc_tag_out => memory_space_10_lc_tag,
      sr_addr_in => memory_space_10_sr_addr,
      sr_data_in => memory_space_10_sr_data,
      sr_req_in => memory_space_10_sr_req,
      sr_ack_out => memory_space_10_sr_ack,
      sr_tag_in => memory_space_10_sr_tag,
      sc_req_in=> memory_space_10_sc_req,
      sc_ack_out => memory_space_10_sc_ack,
      sc_tag_out => memory_space_10_sc_tag,
      clock => clk,
      reset => reset); -- 
  RegisterBank_memory_space_8: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_8_lr_addr,
      lr_req_in => memory_space_8_lr_req,
      lr_ack_out => memory_space_8_lr_ack,
      lr_tag_in => memory_space_8_lr_tag,
      lc_req_in => memory_space_8_lc_req,
      lc_ack_out => memory_space_8_lc_ack,
      lc_data_out => memory_space_8_lc_data,
      lc_tag_out => memory_space_8_lc_tag,
      sr_addr_in => memory_space_8_sr_addr,
      sr_data_in => memory_space_8_sr_data,
      sr_req_in => memory_space_8_sr_req,
      sr_ack_out => memory_space_8_sr_ack,
      sr_tag_in => memory_space_8_sr_tag,
      sc_req_in=> memory_space_8_sc_req,
      sc_ack_out => memory_space_8_sc_ack,
      sc_tag_out => memory_space_8_sc_tag,
      clock => clk,
      reset => reset); -- 
  RegisterBank_memory_space_9: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 2,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_9_lr_addr,
      lr_req_in => memory_space_9_lr_req,
      lr_ack_out => memory_space_9_lr_ack,
      lr_tag_in => memory_space_9_lr_tag,
      lc_req_in => memory_space_9_lc_req,
      lc_ack_out => memory_space_9_lc_ack,
      lc_data_out => memory_space_9_lc_data,
      lc_tag_out => memory_space_9_lc_tag,
      sr_addr_in => memory_space_9_sr_addr,
      sr_data_in => memory_space_9_sr_data,
      sr_req_in => memory_space_9_sr_req,
      sr_ack_out => memory_space_9_sr_ack,
      sr_tag_in => memory_space_9_sr_tag,
      sc_req_in=> memory_space_9_sc_req,
      sc_ack_out => memory_space_9_sc_ack,
      sc_tag_out => memory_space_9_sc_tag,
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
library work;
use work.vc_system_package.all;
entity sub is -- 
  port ( -- 
    a : in  std_logic_vector(31 downto 0);
    b : in  std_logic_vector(31 downto 0);
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(0 downto 0);
    sub_slave_call_reqs : out  std_logic_vector(0 downto 0);
    sub_slave_call_acks : in   std_logic_vector(0 downto 0);
    sub_slave_call_data : out  std_logic_vector(63 downto 0);
    sub_slave_call_tag  :  out  std_logic_vector(0 downto 0);
    sub_slave_return_reqs : out  std_logic_vector(0 downto 0);
    sub_slave_return_acks : in   std_logic_vector(0 downto 0);
    sub_slave_return_data : in   std_logic_vector(31 downto 0);
    sub_slave_return_tag :  in   std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity sub;
architecture Default of sub is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_128_load_0_req_0 : boolean;
  signal simple_obj_ref_128_load_0_ack_0 : boolean;
  signal simple_obj_ref_128_load_0_req_1 : boolean;
  signal simple_obj_ref_128_load_0_ack_1 : boolean;
  signal simple_obj_ref_128_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_128_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_61_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_61_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_61_store_0_req_0 : boolean;
  signal simple_obj_ref_61_store_0_ack_0 : boolean;
  signal simple_obj_ref_61_store_0_req_1 : boolean;
  signal simple_obj_ref_61_store_0_ack_1 : boolean;
  signal simple_obj_ref_64_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_64_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_64_store_0_req_0 : boolean;
  signal simple_obj_ref_64_store_0_ack_0 : boolean;
  signal simple_obj_ref_64_store_0_req_1 : boolean;
  signal simple_obj_ref_64_store_0_ack_1 : boolean;
  signal simple_obj_ref_68_load_0_req_0 : boolean;
  signal simple_obj_ref_68_load_0_ack_0 : boolean;
  signal simple_obj_ref_68_load_0_req_1 : boolean;
  signal simple_obj_ref_68_load_0_ack_1 : boolean;
  signal simple_obj_ref_68_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_68_gather_scatter_ack_0 : boolean;
  signal ptr_deref_76_gather_scatter_req_0 : boolean;
  signal ptr_deref_76_gather_scatter_ack_0 : boolean;
  signal ptr_deref_76_store_0_req_0 : boolean;
  signal ptr_deref_76_store_0_ack_0 : boolean;
  signal ptr_deref_76_store_0_req_1 : boolean;
  signal ptr_deref_76_store_0_ack_1 : boolean;
  signal simple_obj_ref_80_load_0_req_0 : boolean;
  signal simple_obj_ref_80_load_0_ack_0 : boolean;
  signal simple_obj_ref_80_load_0_req_1 : boolean;
  signal simple_obj_ref_80_load_0_ack_1 : boolean;
  signal simple_obj_ref_80_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_80_gather_scatter_ack_0 : boolean;
  signal ptr_deref_88_gather_scatter_req_0 : boolean;
  signal ptr_deref_88_gather_scatter_ack_0 : boolean;
  signal ptr_deref_88_store_0_req_0 : boolean;
  signal ptr_deref_88_store_0_ack_0 : boolean;
  signal ptr_deref_88_store_0_req_1 : boolean;
  signal ptr_deref_88_store_0_ack_1 : boolean;
  signal ptr_deref_97_base_resize_req_0 : boolean;
  signal ptr_deref_97_base_resize_ack_0 : boolean;
  signal ptr_deref_97_root_address_inst_req_0 : boolean;
  signal ptr_deref_97_root_address_inst_ack_0 : boolean;
  signal ptr_deref_97_addr_0_req_0 : boolean;
  signal ptr_deref_97_addr_0_ack_0 : boolean;
  signal ptr_deref_97_gather_scatter_req_0 : boolean;
  signal ptr_deref_97_gather_scatter_ack_0 : boolean;
  signal ptr_deref_97_store_0_req_0 : boolean;
  signal ptr_deref_97_store_0_ack_0 : boolean;
  signal ptr_deref_97_store_0_req_1 : boolean;
  signal ptr_deref_97_store_0_ack_1 : boolean;
  signal ptr_deref_107_load_0_req_0 : boolean;
  signal ptr_deref_107_load_0_ack_0 : boolean;
  signal ptr_deref_107_load_0_req_1 : boolean;
  signal ptr_deref_107_load_0_ack_1 : boolean;
  signal ptr_deref_107_gather_scatter_req_0 : boolean;
  signal ptr_deref_107_gather_scatter_ack_0 : boolean;
  signal ptr_deref_116_load_0_req_0 : boolean;
  signal ptr_deref_116_load_0_ack_0 : boolean;
  signal ptr_deref_116_load_0_req_1 : boolean;
  signal ptr_deref_116_load_0_ack_1 : boolean;
  signal ptr_deref_116_gather_scatter_req_0 : boolean;
  signal ptr_deref_116_gather_scatter_ack_0 : boolean;
  signal call_stmt_121_call_req_0 : boolean;
  signal call_stmt_121_call_ack_0 : boolean;
  signal call_stmt_121_call_req_1 : boolean;
  signal call_stmt_121_call_ack_1 : boolean;
  signal simple_obj_ref_122_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_122_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_122_store_0_req_0 : boolean;
  signal simple_obj_ref_122_store_0_ack_0 : boolean;
  signal simple_obj_ref_122_store_0_req_1 : boolean;
  signal simple_obj_ref_122_store_0_ack_1 : boolean;
  signal memory_space_4_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_4_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_4_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_4_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_4_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_4_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_4_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_4_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_4_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_4_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_4_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_4_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_4_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_4_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_4_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_4_sc_tag :  std_logic_vector(0 downto 0);
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
  signal memory_space_6_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_6_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_6_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_6_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_6_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_6_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_6_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_6_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_6_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_6_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_6_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_6_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_6_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_6_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_6_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_6_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_7_lr_req :  std_logic_vector(1 downto 0);
  signal memory_space_7_lr_ack : std_logic_vector(1 downto 0);
  signal memory_space_7_lr_addr : std_logic_vector(1 downto 0);
  signal memory_space_7_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_7_lc_req : std_logic_vector(1 downto 0);
  signal memory_space_7_lc_ack :  std_logic_vector(1 downto 0);
  signal memory_space_7_lc_data : std_logic_vector(63 downto 0);
  signal memory_space_7_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_7_sr_req :  std_logic_vector(1 downto 0);
  signal memory_space_7_sr_ack : std_logic_vector(1 downto 0);
  signal memory_space_7_sr_addr : std_logic_vector(1 downto 0);
  signal memory_space_7_sr_data : std_logic_vector(63 downto 0);
  signal memory_space_7_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_7_sc_req : std_logic_vector(1 downto 0);
  signal memory_space_7_sc_ack :  std_logic_vector(1 downto 0);
  signal memory_space_7_sc_tag :  std_logic_vector(1 downto 0);
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
  sub_CP_268: Block -- control-path 
    signal sub_CP_268_start: Boolean;
    signal Xentry_269_symbol: Boolean;
    signal Xexit_270_symbol: Boolean;
    signal branch_block_stmt_57_271_symbol : Boolean;
    -- 
  begin -- 
    sub_CP_268_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_269_symbol  <= sub_CP_268_start; -- transition $entry
    branch_block_stmt_57_271: Block -- branch_block_stmt_57 
      signal branch_block_stmt_57_271_start: Boolean;
      signal Xentry_272_symbol: Boolean;
      signal Xexit_273_symbol: Boolean;
      signal branch_block_stmt_57_x_xentry_x_xx_x274_symbol : Boolean;
      signal branch_block_stmt_57_x_xexit_x_xx_x275_symbol : Boolean;
      signal assign_stmt_63_to_assign_stmt_117_x_xentry_x_xx_x276_symbol : Boolean;
      signal assign_stmt_63_to_assign_stmt_117_x_xexit_x_xx_x277_symbol : Boolean;
      signal call_stmt_121_x_xentry_x_xx_x278_symbol : Boolean;
      signal call_stmt_121_x_xexit_x_xx_x279_symbol : Boolean;
      signal assign_stmt_124_x_xentry_x_xx_x280_symbol : Boolean;
      signal assign_stmt_124_x_xexit_x_xx_x281_symbol : Boolean;
      signal return_x_xx_x282_symbol : Boolean;
      signal merge_stmt_126_x_xexit_x_xx_x283_symbol : Boolean;
      signal assign_stmt_129_x_xentry_x_xx_x284_symbol : Boolean;
      signal assign_stmt_129_x_xexit_x_xx_x285_symbol : Boolean;
      signal assign_stmt_63_to_assign_stmt_117_286_symbol : Boolean;
      signal call_stmt_121_585_symbol : Boolean;
      signal assign_stmt_124_604_symbol : Boolean;
      signal assign_stmt_129_638_symbol : Boolean;
      signal return_x_xx_xPhiReq_671_symbol : Boolean;
      signal merge_stmt_126_PhiReqMerge_674_symbol : Boolean;
      signal merge_stmt_126_PhiAck_675_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_57_271_start <= Xentry_269_symbol; -- control passed to block
      Xentry_272_symbol  <= branch_block_stmt_57_271_start; -- transition branch_block_stmt_57/$entry
      branch_block_stmt_57_x_xentry_x_xx_x274_symbol  <=  Xentry_272_symbol; -- place branch_block_stmt_57/branch_block_stmt_57__entry__ (optimized away) 
      branch_block_stmt_57_x_xexit_x_xx_x275_symbol  <=  assign_stmt_129_x_xexit_x_xx_x285_symbol; -- place branch_block_stmt_57/branch_block_stmt_57__exit__ (optimized away) 
      assign_stmt_63_to_assign_stmt_117_x_xentry_x_xx_x276_symbol  <=  branch_block_stmt_57_x_xentry_x_xx_x274_symbol; -- place branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117__entry__ (optimized away) 
      assign_stmt_63_to_assign_stmt_117_x_xexit_x_xx_x277_symbol  <=  assign_stmt_63_to_assign_stmt_117_286_symbol; -- place branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117__exit__ (optimized away) 
      call_stmt_121_x_xentry_x_xx_x278_symbol  <=  assign_stmt_63_to_assign_stmt_117_x_xexit_x_xx_x277_symbol; -- place branch_block_stmt_57/call_stmt_121__entry__ (optimized away) 
      call_stmt_121_x_xexit_x_xx_x279_symbol  <=  call_stmt_121_585_symbol; -- place branch_block_stmt_57/call_stmt_121__exit__ (optimized away) 
      assign_stmt_124_x_xentry_x_xx_x280_symbol  <=  call_stmt_121_x_xexit_x_xx_x279_symbol; -- place branch_block_stmt_57/assign_stmt_124__entry__ (optimized away) 
      assign_stmt_124_x_xexit_x_xx_x281_symbol  <=  assign_stmt_124_604_symbol; -- place branch_block_stmt_57/assign_stmt_124__exit__ (optimized away) 
      return_x_xx_x282_symbol  <=  assign_stmt_124_x_xexit_x_xx_x281_symbol; -- place branch_block_stmt_57/return__ (optimized away) 
      merge_stmt_126_x_xexit_x_xx_x283_symbol  <=  merge_stmt_126_PhiAck_675_symbol; -- place branch_block_stmt_57/merge_stmt_126__exit__ (optimized away) 
      assign_stmt_129_x_xentry_x_xx_x284_symbol  <=  merge_stmt_126_x_xexit_x_xx_x283_symbol; -- place branch_block_stmt_57/assign_stmt_129__entry__ (optimized away) 
      assign_stmt_129_x_xexit_x_xx_x285_symbol  <=  assign_stmt_129_638_symbol; -- place branch_block_stmt_57/assign_stmt_129__exit__ (optimized away) 
      assign_stmt_63_to_assign_stmt_117_286: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117 
        signal assign_stmt_63_to_assign_stmt_117_286_start: Boolean;
        signal Xentry_287_symbol: Boolean;
        signal Xexit_288_symbol: Boolean;
        signal assign_stmt_63_active_x_x289_symbol : Boolean;
        signal assign_stmt_63_completed_x_x290_symbol : Boolean;
        signal simple_obj_ref_62_complete_291_symbol : Boolean;
        signal simple_obj_ref_61_trigger_x_x292_symbol : Boolean;
        signal simple_obj_ref_61_active_x_x293_symbol : Boolean;
        signal simple_obj_ref_61_root_address_calculated_294_symbol : Boolean;
        signal simple_obj_ref_61_word_address_calculated_295_symbol : Boolean;
        signal simple_obj_ref_61_request_296_symbol : Boolean;
        signal simple_obj_ref_61_complete_309_symbol : Boolean;
        signal assign_stmt_66_active_x_x320_symbol : Boolean;
        signal assign_stmt_66_completed_x_x321_symbol : Boolean;
        signal simple_obj_ref_65_complete_322_symbol : Boolean;
        signal simple_obj_ref_64_trigger_x_x323_symbol : Boolean;
        signal simple_obj_ref_64_active_x_x324_symbol : Boolean;
        signal simple_obj_ref_64_root_address_calculated_325_symbol : Boolean;
        signal simple_obj_ref_64_word_address_calculated_326_symbol : Boolean;
        signal simple_obj_ref_64_request_327_symbol : Boolean;
        signal simple_obj_ref_64_complete_340_symbol : Boolean;
        signal assign_stmt_69_active_x_x351_symbol : Boolean;
        signal assign_stmt_69_completed_x_x352_symbol : Boolean;
        signal simple_obj_ref_68_trigger_x_x353_symbol : Boolean;
        signal simple_obj_ref_68_active_x_x354_symbol : Boolean;
        signal simple_obj_ref_68_root_address_calculated_355_symbol : Boolean;
        signal simple_obj_ref_68_word_address_calculated_356_symbol : Boolean;
        signal simple_obj_ref_68_request_357_symbol : Boolean;
        signal simple_obj_ref_68_complete_368_symbol : Boolean;
        signal assign_stmt_78_active_x_x381_symbol : Boolean;
        signal assign_stmt_78_completed_x_x382_symbol : Boolean;
        signal simple_obj_ref_77_complete_383_symbol : Boolean;
        signal ptr_deref_76_trigger_x_x384_symbol : Boolean;
        signal ptr_deref_76_active_x_x385_symbol : Boolean;
        signal ptr_deref_76_base_address_calculated_386_symbol : Boolean;
        signal ptr_deref_76_root_address_calculated_387_symbol : Boolean;
        signal ptr_deref_76_word_address_calculated_388_symbol : Boolean;
        signal ptr_deref_76_request_389_symbol : Boolean;
        signal ptr_deref_76_complete_402_symbol : Boolean;
        signal assign_stmt_81_active_x_x413_symbol : Boolean;
        signal assign_stmt_81_completed_x_x414_symbol : Boolean;
        signal simple_obj_ref_80_trigger_x_x415_symbol : Boolean;
        signal simple_obj_ref_80_active_x_x416_symbol : Boolean;
        signal simple_obj_ref_80_root_address_calculated_417_symbol : Boolean;
        signal simple_obj_ref_80_word_address_calculated_418_symbol : Boolean;
        signal simple_obj_ref_80_request_419_symbol : Boolean;
        signal simple_obj_ref_80_complete_430_symbol : Boolean;
        signal assign_stmt_90_active_x_x443_symbol : Boolean;
        signal assign_stmt_90_completed_x_x444_symbol : Boolean;
        signal simple_obj_ref_89_complete_445_symbol : Boolean;
        signal ptr_deref_88_trigger_x_x446_symbol : Boolean;
        signal ptr_deref_88_active_x_x447_symbol : Boolean;
        signal ptr_deref_88_base_address_calculated_448_symbol : Boolean;
        signal ptr_deref_88_root_address_calculated_449_symbol : Boolean;
        signal ptr_deref_88_word_address_calculated_450_symbol : Boolean;
        signal ptr_deref_88_request_451_symbol : Boolean;
        signal ptr_deref_88_complete_464_symbol : Boolean;
        signal assign_stmt_99_active_x_x475_symbol : Boolean;
        signal assign_stmt_99_completed_x_x476_symbol : Boolean;
        signal ptr_deref_97_trigger_x_x477_symbol : Boolean;
        signal ptr_deref_97_active_x_x478_symbol : Boolean;
        signal ptr_deref_97_base_address_calculated_479_symbol : Boolean;
        signal simple_obj_ref_96_complete_480_symbol : Boolean;
        signal ptr_deref_97_root_address_calculated_481_symbol : Boolean;
        signal ptr_deref_97_word_address_calculated_482_symbol : Boolean;
        signal ptr_deref_97_base_address_resized_483_symbol : Boolean;
        signal ptr_deref_97_base_addr_resize_484_symbol : Boolean;
        signal ptr_deref_97_base_plus_offset_489_symbol : Boolean;
        signal ptr_deref_97_word_addrgen_494_symbol : Boolean;
        signal ptr_deref_97_request_499_symbol : Boolean;
        signal ptr_deref_97_complete_512_symbol : Boolean;
        signal assign_stmt_108_active_x_x523_symbol : Boolean;
        signal assign_stmt_108_completed_x_x524_symbol : Boolean;
        signal ptr_deref_107_trigger_x_x525_symbol : Boolean;
        signal ptr_deref_107_active_x_x526_symbol : Boolean;
        signal ptr_deref_107_base_address_calculated_527_symbol : Boolean;
        signal ptr_deref_107_root_address_calculated_528_symbol : Boolean;
        signal ptr_deref_107_word_address_calculated_529_symbol : Boolean;
        signal ptr_deref_107_request_530_symbol : Boolean;
        signal ptr_deref_107_complete_541_symbol : Boolean;
        signal assign_stmt_117_active_x_x554_symbol : Boolean;
        signal assign_stmt_117_completed_x_x555_symbol : Boolean;
        signal ptr_deref_116_trigger_x_x556_symbol : Boolean;
        signal ptr_deref_116_active_x_x557_symbol : Boolean;
        signal ptr_deref_116_base_address_calculated_558_symbol : Boolean;
        signal ptr_deref_116_root_address_calculated_559_symbol : Boolean;
        signal ptr_deref_116_word_address_calculated_560_symbol : Boolean;
        signal ptr_deref_116_request_561_symbol : Boolean;
        signal ptr_deref_116_complete_572_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_63_to_assign_stmt_117_286_start <= assign_stmt_63_to_assign_stmt_117_x_xentry_x_xx_x276_symbol; -- control passed to block
        Xentry_287_symbol  <= assign_stmt_63_to_assign_stmt_117_286_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/$entry
        assign_stmt_63_active_x_x289_symbol <= simple_obj_ref_62_complete_291_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_63_active_
        assign_stmt_63_completed_x_x290_symbol <= simple_obj_ref_61_complete_309_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_63_completed_
        simple_obj_ref_62_complete_291_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_62_complete
        simple_obj_ref_61_trigger_x_x292_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_trigger_ 
          signal simple_obj_ref_61_trigger_x_x292_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_61_trigger_x_x292_predecessors(0) <= simple_obj_ref_61_word_address_calculated_295_symbol;
          simple_obj_ref_61_trigger_x_x292_predecessors(1) <= assign_stmt_63_active_x_x289_symbol;
          simple_obj_ref_61_trigger_x_x292_join: join -- 
            port map( -- 
              preds => simple_obj_ref_61_trigger_x_x292_predecessors,
              symbol_out => simple_obj_ref_61_trigger_x_x292_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_trigger_
        simple_obj_ref_61_active_x_x293_symbol <= simple_obj_ref_61_request_296_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_active_
        simple_obj_ref_61_root_address_calculated_294_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_root_address_calculated
        simple_obj_ref_61_word_address_calculated_295_symbol <= simple_obj_ref_61_root_address_calculated_294_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_word_address_calculated
        simple_obj_ref_61_request_296: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request 
          signal simple_obj_ref_61_request_296_start: Boolean;
          signal Xentry_297_symbol: Boolean;
          signal Xexit_298_symbol: Boolean;
          signal split_req_299_symbol : Boolean;
          signal split_ack_300_symbol : Boolean;
          signal word_access_301_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_61_request_296_start <= simple_obj_ref_61_trigger_x_x292_symbol; -- control passed to block
          Xentry_297_symbol  <= simple_obj_ref_61_request_296_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/$entry
          split_req_299_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/split_req
          simple_obj_ref_61_gather_scatter_req_0 <= split_req_299_symbol; -- link to DP
          split_ack_300_symbol <= simple_obj_ref_61_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/split_ack
          word_access_301: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access 
            signal word_access_301_start: Boolean;
            signal Xentry_302_symbol: Boolean;
            signal Xexit_303_symbol: Boolean;
            signal word_access_0_304_symbol : Boolean;
            -- 
          begin -- 
            word_access_301_start <= split_ack_300_symbol; -- control passed to block
            Xentry_302_symbol  <= word_access_301_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/$entry
            word_access_0_304: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/word_access_0 
              signal word_access_0_304_start: Boolean;
              signal Xentry_305_symbol: Boolean;
              signal Xexit_306_symbol: Boolean;
              signal rr_307_symbol : Boolean;
              signal ra_308_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_304_start <= Xentry_302_symbol; -- control passed to block
              Xentry_305_symbol  <= word_access_0_304_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/word_access_0/$entry
              rr_307_symbol <= Xentry_305_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/word_access_0/rr
              simple_obj_ref_61_store_0_req_0 <= rr_307_symbol; -- link to DP
              ra_308_symbol <= simple_obj_ref_61_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/word_access_0/ra
              Xexit_306_symbol <= ra_308_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/word_access_0/$exit
              word_access_0_304_symbol <= Xexit_306_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/word_access_0
            Xexit_303_symbol <= word_access_0_304_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access/$exit
            word_access_301_symbol <= Xexit_303_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/word_access
          Xexit_298_symbol <= word_access_301_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request/$exit
          simple_obj_ref_61_request_296_symbol <= Xexit_298_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_request
        simple_obj_ref_61_complete_309: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete 
          signal simple_obj_ref_61_complete_309_start: Boolean;
          signal Xentry_310_symbol: Boolean;
          signal Xexit_311_symbol: Boolean;
          signal word_access_312_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_61_complete_309_start <= simple_obj_ref_61_active_x_x293_symbol; -- control passed to block
          Xentry_310_symbol  <= simple_obj_ref_61_complete_309_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/$entry
          word_access_312: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access 
            signal word_access_312_start: Boolean;
            signal Xentry_313_symbol: Boolean;
            signal Xexit_314_symbol: Boolean;
            signal word_access_0_315_symbol : Boolean;
            -- 
          begin -- 
            word_access_312_start <= Xentry_310_symbol; -- control passed to block
            Xentry_313_symbol  <= word_access_312_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/$entry
            word_access_0_315: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/word_access_0 
              signal word_access_0_315_start: Boolean;
              signal Xentry_316_symbol: Boolean;
              signal Xexit_317_symbol: Boolean;
              signal cr_318_symbol : Boolean;
              signal ca_319_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_315_start <= Xentry_313_symbol; -- control passed to block
              Xentry_316_symbol  <= word_access_0_315_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/word_access_0/$entry
              cr_318_symbol <= Xentry_316_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/word_access_0/cr
              simple_obj_ref_61_store_0_req_1 <= cr_318_symbol; -- link to DP
              ca_319_symbol <= simple_obj_ref_61_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/word_access_0/ca
              Xexit_317_symbol <= ca_319_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/word_access_0/$exit
              word_access_0_315_symbol <= Xexit_317_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/word_access_0
            Xexit_314_symbol <= word_access_0_315_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access/$exit
            word_access_312_symbol <= Xexit_314_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/word_access
          Xexit_311_symbol <= word_access_312_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete/$exit
          simple_obj_ref_61_complete_309_symbol <= Xexit_311_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_61_complete
        assign_stmt_66_active_x_x320_symbol <= simple_obj_ref_65_complete_322_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_66_active_
        assign_stmt_66_completed_x_x321_symbol <= simple_obj_ref_64_complete_340_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_66_completed_
        simple_obj_ref_65_complete_322_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_65_complete
        simple_obj_ref_64_trigger_x_x323_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_trigger_ 
          signal simple_obj_ref_64_trigger_x_x323_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_64_trigger_x_x323_predecessors(0) <= simple_obj_ref_64_word_address_calculated_326_symbol;
          simple_obj_ref_64_trigger_x_x323_predecessors(1) <= assign_stmt_66_active_x_x320_symbol;
          simple_obj_ref_64_trigger_x_x323_join: join -- 
            port map( -- 
              preds => simple_obj_ref_64_trigger_x_x323_predecessors,
              symbol_out => simple_obj_ref_64_trigger_x_x323_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_trigger_
        simple_obj_ref_64_active_x_x324_symbol <= simple_obj_ref_64_request_327_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_active_
        simple_obj_ref_64_root_address_calculated_325_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_root_address_calculated
        simple_obj_ref_64_word_address_calculated_326_symbol <= simple_obj_ref_64_root_address_calculated_325_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_word_address_calculated
        simple_obj_ref_64_request_327: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request 
          signal simple_obj_ref_64_request_327_start: Boolean;
          signal Xentry_328_symbol: Boolean;
          signal Xexit_329_symbol: Boolean;
          signal split_req_330_symbol : Boolean;
          signal split_ack_331_symbol : Boolean;
          signal word_access_332_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_64_request_327_start <= simple_obj_ref_64_trigger_x_x323_symbol; -- control passed to block
          Xentry_328_symbol  <= simple_obj_ref_64_request_327_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/$entry
          split_req_330_symbol <= Xentry_328_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/split_req
          simple_obj_ref_64_gather_scatter_req_0 <= split_req_330_symbol; -- link to DP
          split_ack_331_symbol <= simple_obj_ref_64_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/split_ack
          word_access_332: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access 
            signal word_access_332_start: Boolean;
            signal Xentry_333_symbol: Boolean;
            signal Xexit_334_symbol: Boolean;
            signal word_access_0_335_symbol : Boolean;
            -- 
          begin -- 
            word_access_332_start <= split_ack_331_symbol; -- control passed to block
            Xentry_333_symbol  <= word_access_332_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/$entry
            word_access_0_335: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/word_access_0 
              signal word_access_0_335_start: Boolean;
              signal Xentry_336_symbol: Boolean;
              signal Xexit_337_symbol: Boolean;
              signal rr_338_symbol : Boolean;
              signal ra_339_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_335_start <= Xentry_333_symbol; -- control passed to block
              Xentry_336_symbol  <= word_access_0_335_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/word_access_0/$entry
              rr_338_symbol <= Xentry_336_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/word_access_0/rr
              simple_obj_ref_64_store_0_req_0 <= rr_338_symbol; -- link to DP
              ra_339_symbol <= simple_obj_ref_64_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/word_access_0/ra
              Xexit_337_symbol <= ra_339_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/word_access_0/$exit
              word_access_0_335_symbol <= Xexit_337_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/word_access_0
            Xexit_334_symbol <= word_access_0_335_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access/$exit
            word_access_332_symbol <= Xexit_334_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/word_access
          Xexit_329_symbol <= word_access_332_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request/$exit
          simple_obj_ref_64_request_327_symbol <= Xexit_329_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_request
        simple_obj_ref_64_complete_340: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete 
          signal simple_obj_ref_64_complete_340_start: Boolean;
          signal Xentry_341_symbol: Boolean;
          signal Xexit_342_symbol: Boolean;
          signal word_access_343_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_64_complete_340_start <= simple_obj_ref_64_active_x_x324_symbol; -- control passed to block
          Xentry_341_symbol  <= simple_obj_ref_64_complete_340_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/$entry
          word_access_343: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access 
            signal word_access_343_start: Boolean;
            signal Xentry_344_symbol: Boolean;
            signal Xexit_345_symbol: Boolean;
            signal word_access_0_346_symbol : Boolean;
            -- 
          begin -- 
            word_access_343_start <= Xentry_341_symbol; -- control passed to block
            Xentry_344_symbol  <= word_access_343_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/$entry
            word_access_0_346: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/word_access_0 
              signal word_access_0_346_start: Boolean;
              signal Xentry_347_symbol: Boolean;
              signal Xexit_348_symbol: Boolean;
              signal cr_349_symbol : Boolean;
              signal ca_350_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_346_start <= Xentry_344_symbol; -- control passed to block
              Xentry_347_symbol  <= word_access_0_346_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/word_access_0/$entry
              cr_349_symbol <= Xentry_347_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/word_access_0/cr
              simple_obj_ref_64_store_0_req_1 <= cr_349_symbol; -- link to DP
              ca_350_symbol <= simple_obj_ref_64_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/word_access_0/ca
              Xexit_348_symbol <= ca_350_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/word_access_0/$exit
              word_access_0_346_symbol <= Xexit_348_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/word_access_0
            Xexit_345_symbol <= word_access_0_346_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access/$exit
            word_access_343_symbol <= Xexit_345_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/word_access
          Xexit_342_symbol <= word_access_343_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete/$exit
          simple_obj_ref_64_complete_340_symbol <= Xexit_342_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_64_complete
        assign_stmt_69_active_x_x351_symbol <= simple_obj_ref_68_complete_368_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_69_active_
        assign_stmt_69_completed_x_x352_symbol <= assign_stmt_69_active_x_x351_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_69_completed_
        simple_obj_ref_68_trigger_x_x353_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_trigger_ 
          signal simple_obj_ref_68_trigger_x_x353_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_68_trigger_x_x353_predecessors(0) <= simple_obj_ref_68_word_address_calculated_356_symbol;
          simple_obj_ref_68_trigger_x_x353_predecessors(1) <= simple_obj_ref_61_active_x_x293_symbol;
          simple_obj_ref_68_trigger_x_x353_join: join -- 
            port map( -- 
              preds => simple_obj_ref_68_trigger_x_x353_predecessors,
              symbol_out => simple_obj_ref_68_trigger_x_x353_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_trigger_
        simple_obj_ref_68_active_x_x354_symbol <= simple_obj_ref_68_request_357_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_active_
        simple_obj_ref_68_root_address_calculated_355_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_root_address_calculated
        simple_obj_ref_68_word_address_calculated_356_symbol <= simple_obj_ref_68_root_address_calculated_355_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_word_address_calculated
        simple_obj_ref_68_request_357: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request 
          signal simple_obj_ref_68_request_357_start: Boolean;
          signal Xentry_358_symbol: Boolean;
          signal Xexit_359_symbol: Boolean;
          signal word_access_360_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_68_request_357_start <= simple_obj_ref_68_trigger_x_x353_symbol; -- control passed to block
          Xentry_358_symbol  <= simple_obj_ref_68_request_357_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/$entry
          word_access_360: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access 
            signal word_access_360_start: Boolean;
            signal Xentry_361_symbol: Boolean;
            signal Xexit_362_symbol: Boolean;
            signal word_access_0_363_symbol : Boolean;
            -- 
          begin -- 
            word_access_360_start <= Xentry_358_symbol; -- control passed to block
            Xentry_361_symbol  <= word_access_360_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/$entry
            word_access_0_363: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/word_access_0 
              signal word_access_0_363_start: Boolean;
              signal Xentry_364_symbol: Boolean;
              signal Xexit_365_symbol: Boolean;
              signal rr_366_symbol : Boolean;
              signal ra_367_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_363_start <= Xentry_361_symbol; -- control passed to block
              Xentry_364_symbol  <= word_access_0_363_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/word_access_0/$entry
              rr_366_symbol <= Xentry_364_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/word_access_0/rr
              simple_obj_ref_68_load_0_req_0 <= rr_366_symbol; -- link to DP
              ra_367_symbol <= simple_obj_ref_68_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/word_access_0/ra
              Xexit_365_symbol <= ra_367_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/word_access_0/$exit
              word_access_0_363_symbol <= Xexit_365_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/word_access_0
            Xexit_362_symbol <= word_access_0_363_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access/$exit
            word_access_360_symbol <= Xexit_362_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/word_access
          Xexit_359_symbol <= word_access_360_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request/$exit
          simple_obj_ref_68_request_357_symbol <= Xexit_359_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_request
        simple_obj_ref_68_complete_368: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete 
          signal simple_obj_ref_68_complete_368_start: Boolean;
          signal Xentry_369_symbol: Boolean;
          signal Xexit_370_symbol: Boolean;
          signal word_access_371_symbol : Boolean;
          signal merge_req_379_symbol : Boolean;
          signal merge_ack_380_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_68_complete_368_start <= simple_obj_ref_68_active_x_x354_symbol; -- control passed to block
          Xentry_369_symbol  <= simple_obj_ref_68_complete_368_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/$entry
          word_access_371: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access 
            signal word_access_371_start: Boolean;
            signal Xentry_372_symbol: Boolean;
            signal Xexit_373_symbol: Boolean;
            signal word_access_0_374_symbol : Boolean;
            -- 
          begin -- 
            word_access_371_start <= Xentry_369_symbol; -- control passed to block
            Xentry_372_symbol  <= word_access_371_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/$entry
            word_access_0_374: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/word_access_0 
              signal word_access_0_374_start: Boolean;
              signal Xentry_375_symbol: Boolean;
              signal Xexit_376_symbol: Boolean;
              signal cr_377_symbol : Boolean;
              signal ca_378_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_374_start <= Xentry_372_symbol; -- control passed to block
              Xentry_375_symbol  <= word_access_0_374_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/word_access_0/$entry
              cr_377_symbol <= Xentry_375_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/word_access_0/cr
              simple_obj_ref_68_load_0_req_1 <= cr_377_symbol; -- link to DP
              ca_378_symbol <= simple_obj_ref_68_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/word_access_0/ca
              Xexit_376_symbol <= ca_378_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/word_access_0/$exit
              word_access_0_374_symbol <= Xexit_376_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/word_access_0
            Xexit_373_symbol <= word_access_0_374_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access/$exit
            word_access_371_symbol <= Xexit_373_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/word_access
          merge_req_379_symbol <= word_access_371_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/merge_req
          simple_obj_ref_68_gather_scatter_req_0 <= merge_req_379_symbol; -- link to DP
          merge_ack_380_symbol <= simple_obj_ref_68_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/merge_ack
          Xexit_370_symbol <= merge_ack_380_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete/$exit
          simple_obj_ref_68_complete_368_symbol <= Xexit_370_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_68_complete
        assign_stmt_78_active_x_x381_symbol <= simple_obj_ref_77_complete_383_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_78_active_
        assign_stmt_78_completed_x_x382_symbol <= ptr_deref_76_complete_402_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_78_completed_
        simple_obj_ref_77_complete_383_symbol <= assign_stmt_69_completed_x_x352_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_77_complete
        ptr_deref_76_trigger_x_x384_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_trigger_ 
          signal ptr_deref_76_trigger_x_x384_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_76_trigger_x_x384_predecessors(0) <= ptr_deref_76_word_address_calculated_388_symbol;
          ptr_deref_76_trigger_x_x384_predecessors(1) <= assign_stmt_78_active_x_x381_symbol;
          ptr_deref_76_trigger_x_x384_join: join -- 
            port map( -- 
              preds => ptr_deref_76_trigger_x_x384_predecessors,
              symbol_out => ptr_deref_76_trigger_x_x384_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_trigger_
        ptr_deref_76_active_x_x385_symbol <= ptr_deref_76_request_389_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_active_
        ptr_deref_76_base_address_calculated_386_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_base_address_calculated
        ptr_deref_76_root_address_calculated_387_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_root_address_calculated
        ptr_deref_76_word_address_calculated_388_symbol <= ptr_deref_76_root_address_calculated_387_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_word_address_calculated
        ptr_deref_76_request_389: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request 
          signal ptr_deref_76_request_389_start: Boolean;
          signal Xentry_390_symbol: Boolean;
          signal Xexit_391_symbol: Boolean;
          signal split_req_392_symbol : Boolean;
          signal split_ack_393_symbol : Boolean;
          signal word_access_394_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_76_request_389_start <= ptr_deref_76_trigger_x_x384_symbol; -- control passed to block
          Xentry_390_symbol  <= ptr_deref_76_request_389_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/$entry
          split_req_392_symbol <= Xentry_390_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/split_req
          ptr_deref_76_gather_scatter_req_0 <= split_req_392_symbol; -- link to DP
          split_ack_393_symbol <= ptr_deref_76_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/split_ack
          word_access_394: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access 
            signal word_access_394_start: Boolean;
            signal Xentry_395_symbol: Boolean;
            signal Xexit_396_symbol: Boolean;
            signal word_access_0_397_symbol : Boolean;
            -- 
          begin -- 
            word_access_394_start <= split_ack_393_symbol; -- control passed to block
            Xentry_395_symbol  <= word_access_394_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/$entry
            word_access_0_397: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/word_access_0 
              signal word_access_0_397_start: Boolean;
              signal Xentry_398_symbol: Boolean;
              signal Xexit_399_symbol: Boolean;
              signal rr_400_symbol : Boolean;
              signal ra_401_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_397_start <= Xentry_395_symbol; -- control passed to block
              Xentry_398_symbol  <= word_access_0_397_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/word_access_0/$entry
              rr_400_symbol <= Xentry_398_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/word_access_0/rr
              ptr_deref_76_store_0_req_0 <= rr_400_symbol; -- link to DP
              ra_401_symbol <= ptr_deref_76_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/word_access_0/ra
              Xexit_399_symbol <= ra_401_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/word_access_0/$exit
              word_access_0_397_symbol <= Xexit_399_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/word_access_0
            Xexit_396_symbol <= word_access_0_397_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access/$exit
            word_access_394_symbol <= Xexit_396_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/word_access
          Xexit_391_symbol <= word_access_394_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request/$exit
          ptr_deref_76_request_389_symbol <= Xexit_391_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_request
        ptr_deref_76_complete_402: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete 
          signal ptr_deref_76_complete_402_start: Boolean;
          signal Xentry_403_symbol: Boolean;
          signal Xexit_404_symbol: Boolean;
          signal word_access_405_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_76_complete_402_start <= ptr_deref_76_active_x_x385_symbol; -- control passed to block
          Xentry_403_symbol  <= ptr_deref_76_complete_402_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/$entry
          word_access_405: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access 
            signal word_access_405_start: Boolean;
            signal Xentry_406_symbol: Boolean;
            signal Xexit_407_symbol: Boolean;
            signal word_access_0_408_symbol : Boolean;
            -- 
          begin -- 
            word_access_405_start <= Xentry_403_symbol; -- control passed to block
            Xentry_406_symbol  <= word_access_405_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/$entry
            word_access_0_408: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/word_access_0 
              signal word_access_0_408_start: Boolean;
              signal Xentry_409_symbol: Boolean;
              signal Xexit_410_symbol: Boolean;
              signal cr_411_symbol : Boolean;
              signal ca_412_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_408_start <= Xentry_406_symbol; -- control passed to block
              Xentry_409_symbol  <= word_access_0_408_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/word_access_0/$entry
              cr_411_symbol <= Xentry_409_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/word_access_0/cr
              ptr_deref_76_store_0_req_1 <= cr_411_symbol; -- link to DP
              ca_412_symbol <= ptr_deref_76_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/word_access_0/ca
              Xexit_410_symbol <= ca_412_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/word_access_0/$exit
              word_access_0_408_symbol <= Xexit_410_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/word_access_0
            Xexit_407_symbol <= word_access_0_408_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access/$exit
            word_access_405_symbol <= Xexit_407_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/word_access
          Xexit_404_symbol <= word_access_405_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete/$exit
          ptr_deref_76_complete_402_symbol <= Xexit_404_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_76_complete
        assign_stmt_81_active_x_x413_symbol <= simple_obj_ref_80_complete_430_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_81_active_
        assign_stmt_81_completed_x_x414_symbol <= assign_stmt_81_active_x_x413_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_81_completed_
        simple_obj_ref_80_trigger_x_x415_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_trigger_ 
          signal simple_obj_ref_80_trigger_x_x415_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_80_trigger_x_x415_predecessors(0) <= simple_obj_ref_80_word_address_calculated_418_symbol;
          simple_obj_ref_80_trigger_x_x415_predecessors(1) <= simple_obj_ref_64_active_x_x324_symbol;
          simple_obj_ref_80_trigger_x_x415_join: join -- 
            port map( -- 
              preds => simple_obj_ref_80_trigger_x_x415_predecessors,
              symbol_out => simple_obj_ref_80_trigger_x_x415_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_trigger_
        simple_obj_ref_80_active_x_x416_symbol <= simple_obj_ref_80_request_419_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_active_
        simple_obj_ref_80_root_address_calculated_417_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_root_address_calculated
        simple_obj_ref_80_word_address_calculated_418_symbol <= simple_obj_ref_80_root_address_calculated_417_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_word_address_calculated
        simple_obj_ref_80_request_419: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request 
          signal simple_obj_ref_80_request_419_start: Boolean;
          signal Xentry_420_symbol: Boolean;
          signal Xexit_421_symbol: Boolean;
          signal word_access_422_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_80_request_419_start <= simple_obj_ref_80_trigger_x_x415_symbol; -- control passed to block
          Xentry_420_symbol  <= simple_obj_ref_80_request_419_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/$entry
          word_access_422: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access 
            signal word_access_422_start: Boolean;
            signal Xentry_423_symbol: Boolean;
            signal Xexit_424_symbol: Boolean;
            signal word_access_0_425_symbol : Boolean;
            -- 
          begin -- 
            word_access_422_start <= Xentry_420_symbol; -- control passed to block
            Xentry_423_symbol  <= word_access_422_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/$entry
            word_access_0_425: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/word_access_0 
              signal word_access_0_425_start: Boolean;
              signal Xentry_426_symbol: Boolean;
              signal Xexit_427_symbol: Boolean;
              signal rr_428_symbol : Boolean;
              signal ra_429_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_425_start <= Xentry_423_symbol; -- control passed to block
              Xentry_426_symbol  <= word_access_0_425_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/word_access_0/$entry
              rr_428_symbol <= Xentry_426_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/word_access_0/rr
              simple_obj_ref_80_load_0_req_0 <= rr_428_symbol; -- link to DP
              ra_429_symbol <= simple_obj_ref_80_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/word_access_0/ra
              Xexit_427_symbol <= ra_429_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/word_access_0/$exit
              word_access_0_425_symbol <= Xexit_427_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/word_access_0
            Xexit_424_symbol <= word_access_0_425_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access/$exit
            word_access_422_symbol <= Xexit_424_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/word_access
          Xexit_421_symbol <= word_access_422_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request/$exit
          simple_obj_ref_80_request_419_symbol <= Xexit_421_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_request
        simple_obj_ref_80_complete_430: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete 
          signal simple_obj_ref_80_complete_430_start: Boolean;
          signal Xentry_431_symbol: Boolean;
          signal Xexit_432_symbol: Boolean;
          signal word_access_433_symbol : Boolean;
          signal merge_req_441_symbol : Boolean;
          signal merge_ack_442_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_80_complete_430_start <= simple_obj_ref_80_active_x_x416_symbol; -- control passed to block
          Xentry_431_symbol  <= simple_obj_ref_80_complete_430_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/$entry
          word_access_433: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access 
            signal word_access_433_start: Boolean;
            signal Xentry_434_symbol: Boolean;
            signal Xexit_435_symbol: Boolean;
            signal word_access_0_436_symbol : Boolean;
            -- 
          begin -- 
            word_access_433_start <= Xentry_431_symbol; -- control passed to block
            Xentry_434_symbol  <= word_access_433_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/$entry
            word_access_0_436: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/word_access_0 
              signal word_access_0_436_start: Boolean;
              signal Xentry_437_symbol: Boolean;
              signal Xexit_438_symbol: Boolean;
              signal cr_439_symbol : Boolean;
              signal ca_440_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_436_start <= Xentry_434_symbol; -- control passed to block
              Xentry_437_symbol  <= word_access_0_436_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/word_access_0/$entry
              cr_439_symbol <= Xentry_437_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/word_access_0/cr
              simple_obj_ref_80_load_0_req_1 <= cr_439_symbol; -- link to DP
              ca_440_symbol <= simple_obj_ref_80_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/word_access_0/ca
              Xexit_438_symbol <= ca_440_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/word_access_0/$exit
              word_access_0_436_symbol <= Xexit_438_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/word_access_0
            Xexit_435_symbol <= word_access_0_436_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access/$exit
            word_access_433_symbol <= Xexit_435_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/word_access
          merge_req_441_symbol <= word_access_433_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/merge_req
          simple_obj_ref_80_gather_scatter_req_0 <= merge_req_441_symbol; -- link to DP
          merge_ack_442_symbol <= simple_obj_ref_80_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/merge_ack
          Xexit_432_symbol <= merge_ack_442_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete/$exit
          simple_obj_ref_80_complete_430_symbol <= Xexit_432_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_80_complete
        assign_stmt_90_active_x_x443_symbol <= simple_obj_ref_89_complete_445_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_90_active_
        assign_stmt_90_completed_x_x444_symbol <= ptr_deref_88_complete_464_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_90_completed_
        simple_obj_ref_89_complete_445_symbol <= assign_stmt_81_completed_x_x414_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_89_complete
        ptr_deref_88_trigger_x_x446_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_trigger_ 
          signal ptr_deref_88_trigger_x_x446_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_88_trigger_x_x446_predecessors(0) <= ptr_deref_88_word_address_calculated_450_symbol;
          ptr_deref_88_trigger_x_x446_predecessors(1) <= assign_stmt_90_active_x_x443_symbol;
          ptr_deref_88_trigger_x_x446_predecessors(2) <= ptr_deref_76_active_x_x385_symbol;
          ptr_deref_88_trigger_x_x446_join: join -- 
            port map( -- 
              preds => ptr_deref_88_trigger_x_x446_predecessors,
              symbol_out => ptr_deref_88_trigger_x_x446_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_trigger_
        ptr_deref_88_active_x_x447_symbol <= ptr_deref_88_request_451_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_active_
        ptr_deref_88_base_address_calculated_448_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_base_address_calculated
        ptr_deref_88_root_address_calculated_449_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_root_address_calculated
        ptr_deref_88_word_address_calculated_450_symbol <= ptr_deref_88_root_address_calculated_449_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_word_address_calculated
        ptr_deref_88_request_451: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request 
          signal ptr_deref_88_request_451_start: Boolean;
          signal Xentry_452_symbol: Boolean;
          signal Xexit_453_symbol: Boolean;
          signal split_req_454_symbol : Boolean;
          signal split_ack_455_symbol : Boolean;
          signal word_access_456_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_request_451_start <= ptr_deref_88_trigger_x_x446_symbol; -- control passed to block
          Xentry_452_symbol  <= ptr_deref_88_request_451_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/$entry
          split_req_454_symbol <= Xentry_452_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/split_req
          ptr_deref_88_gather_scatter_req_0 <= split_req_454_symbol; -- link to DP
          split_ack_455_symbol <= ptr_deref_88_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/split_ack
          word_access_456: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access 
            signal word_access_456_start: Boolean;
            signal Xentry_457_symbol: Boolean;
            signal Xexit_458_symbol: Boolean;
            signal word_access_0_459_symbol : Boolean;
            -- 
          begin -- 
            word_access_456_start <= split_ack_455_symbol; -- control passed to block
            Xentry_457_symbol  <= word_access_456_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/$entry
            word_access_0_459: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/word_access_0 
              signal word_access_0_459_start: Boolean;
              signal Xentry_460_symbol: Boolean;
              signal Xexit_461_symbol: Boolean;
              signal rr_462_symbol : Boolean;
              signal ra_463_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_459_start <= Xentry_457_symbol; -- control passed to block
              Xentry_460_symbol  <= word_access_0_459_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/word_access_0/$entry
              rr_462_symbol <= Xentry_460_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/word_access_0/rr
              ptr_deref_88_store_0_req_0 <= rr_462_symbol; -- link to DP
              ra_463_symbol <= ptr_deref_88_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/word_access_0/ra
              Xexit_461_symbol <= ra_463_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/word_access_0/$exit
              word_access_0_459_symbol <= Xexit_461_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/word_access_0
            Xexit_458_symbol <= word_access_0_459_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access/$exit
            word_access_456_symbol <= Xexit_458_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/word_access
          Xexit_453_symbol <= word_access_456_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request/$exit
          ptr_deref_88_request_451_symbol <= Xexit_453_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_request
        ptr_deref_88_complete_464: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete 
          signal ptr_deref_88_complete_464_start: Boolean;
          signal Xentry_465_symbol: Boolean;
          signal Xexit_466_symbol: Boolean;
          signal word_access_467_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_complete_464_start <= ptr_deref_88_active_x_x447_symbol; -- control passed to block
          Xentry_465_symbol  <= ptr_deref_88_complete_464_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/$entry
          word_access_467: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access 
            signal word_access_467_start: Boolean;
            signal Xentry_468_symbol: Boolean;
            signal Xexit_469_symbol: Boolean;
            signal word_access_0_470_symbol : Boolean;
            -- 
          begin -- 
            word_access_467_start <= Xentry_465_symbol; -- control passed to block
            Xentry_468_symbol  <= word_access_467_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/$entry
            word_access_0_470: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/word_access_0 
              signal word_access_0_470_start: Boolean;
              signal Xentry_471_symbol: Boolean;
              signal Xexit_472_symbol: Boolean;
              signal cr_473_symbol : Boolean;
              signal ca_474_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_470_start <= Xentry_468_symbol; -- control passed to block
              Xentry_471_symbol  <= word_access_0_470_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/word_access_0/$entry
              cr_473_symbol <= Xentry_471_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/word_access_0/cr
              ptr_deref_88_store_0_req_1 <= cr_473_symbol; -- link to DP
              ca_474_symbol <= ptr_deref_88_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/word_access_0/ca
              Xexit_472_symbol <= ca_474_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/word_access_0/$exit
              word_access_0_470_symbol <= Xexit_472_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/word_access_0
            Xexit_469_symbol <= word_access_0_470_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access/$exit
            word_access_467_symbol <= Xexit_469_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/word_access
          Xexit_466_symbol <= word_access_467_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete/$exit
          ptr_deref_88_complete_464_symbol <= Xexit_466_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_88_complete
        assign_stmt_99_active_x_x475_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_99_active_
        assign_stmt_99_completed_x_x476_symbol <= ptr_deref_97_complete_512_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_99_completed_
        ptr_deref_97_trigger_x_x477_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_trigger_ 
          signal ptr_deref_97_trigger_x_x477_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_97_trigger_x_x477_predecessors(0) <= ptr_deref_97_word_address_calculated_482_symbol;
          ptr_deref_97_trigger_x_x477_predecessors(1) <= ptr_deref_97_base_address_calculated_479_symbol;
          ptr_deref_97_trigger_x_x477_predecessors(2) <= assign_stmt_99_active_x_x475_symbol;
          ptr_deref_97_trigger_x_x477_join: join -- 
            port map( -- 
              preds => ptr_deref_97_trigger_x_x477_predecessors,
              symbol_out => ptr_deref_97_trigger_x_x477_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_trigger_
        ptr_deref_97_active_x_x478_symbol <= ptr_deref_97_request_499_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_active_
        ptr_deref_97_base_address_calculated_479_symbol <= simple_obj_ref_96_complete_480_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_address_calculated
        simple_obj_ref_96_complete_480_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/simple_obj_ref_96_complete
        ptr_deref_97_root_address_calculated_481_symbol <= ptr_deref_97_base_plus_offset_489_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_root_address_calculated
        ptr_deref_97_word_address_calculated_482_symbol <= ptr_deref_97_word_addrgen_494_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_address_calculated
        ptr_deref_97_base_address_resized_483_symbol <= ptr_deref_97_base_addr_resize_484_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_address_resized
        ptr_deref_97_base_addr_resize_484: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_addr_resize 
          signal ptr_deref_97_base_addr_resize_484_start: Boolean;
          signal Xentry_485_symbol: Boolean;
          signal Xexit_486_symbol: Boolean;
          signal base_resize_req_487_symbol : Boolean;
          signal base_resize_ack_488_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_97_base_addr_resize_484_start <= ptr_deref_97_base_address_calculated_479_symbol; -- control passed to block
          Xentry_485_symbol  <= ptr_deref_97_base_addr_resize_484_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_addr_resize/$entry
          base_resize_req_487_symbol <= Xentry_485_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_addr_resize/base_resize_req
          ptr_deref_97_base_resize_req_0 <= base_resize_req_487_symbol; -- link to DP
          base_resize_ack_488_symbol <= ptr_deref_97_base_resize_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_addr_resize/base_resize_ack
          Xexit_486_symbol <= base_resize_ack_488_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_addr_resize/$exit
          ptr_deref_97_base_addr_resize_484_symbol <= Xexit_486_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_addr_resize
        ptr_deref_97_base_plus_offset_489: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_plus_offset 
          signal ptr_deref_97_base_plus_offset_489_start: Boolean;
          signal Xentry_490_symbol: Boolean;
          signal Xexit_491_symbol: Boolean;
          signal sum_rename_req_492_symbol : Boolean;
          signal sum_rename_ack_493_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_97_base_plus_offset_489_start <= ptr_deref_97_base_address_resized_483_symbol; -- control passed to block
          Xentry_490_symbol  <= ptr_deref_97_base_plus_offset_489_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_plus_offset/$entry
          sum_rename_req_492_symbol <= Xentry_490_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_plus_offset/sum_rename_req
          ptr_deref_97_root_address_inst_req_0 <= sum_rename_req_492_symbol; -- link to DP
          sum_rename_ack_493_symbol <= ptr_deref_97_root_address_inst_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_plus_offset/sum_rename_ack
          Xexit_491_symbol <= sum_rename_ack_493_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_plus_offset/$exit
          ptr_deref_97_base_plus_offset_489_symbol <= Xexit_491_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_base_plus_offset
        ptr_deref_97_word_addrgen_494: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_addrgen 
          signal ptr_deref_97_word_addrgen_494_start: Boolean;
          signal Xentry_495_symbol: Boolean;
          signal Xexit_496_symbol: Boolean;
          signal root_rename_req_497_symbol : Boolean;
          signal root_rename_ack_498_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_97_word_addrgen_494_start <= ptr_deref_97_root_address_calculated_481_symbol; -- control passed to block
          Xentry_495_symbol  <= ptr_deref_97_word_addrgen_494_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_addrgen/$entry
          root_rename_req_497_symbol <= Xentry_495_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_addrgen/root_rename_req
          ptr_deref_97_addr_0_req_0 <= root_rename_req_497_symbol; -- link to DP
          root_rename_ack_498_symbol <= ptr_deref_97_addr_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_addrgen/root_rename_ack
          Xexit_496_symbol <= root_rename_ack_498_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_addrgen/$exit
          ptr_deref_97_word_addrgen_494_symbol <= Xexit_496_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_word_addrgen
        ptr_deref_97_request_499: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request 
          signal ptr_deref_97_request_499_start: Boolean;
          signal Xentry_500_symbol: Boolean;
          signal Xexit_501_symbol: Boolean;
          signal split_req_502_symbol : Boolean;
          signal split_ack_503_symbol : Boolean;
          signal word_access_504_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_97_request_499_start <= ptr_deref_97_trigger_x_x477_symbol; -- control passed to block
          Xentry_500_symbol  <= ptr_deref_97_request_499_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/$entry
          split_req_502_symbol <= Xentry_500_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/split_req
          ptr_deref_97_gather_scatter_req_0 <= split_req_502_symbol; -- link to DP
          split_ack_503_symbol <= ptr_deref_97_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/split_ack
          word_access_504: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access 
            signal word_access_504_start: Boolean;
            signal Xentry_505_symbol: Boolean;
            signal Xexit_506_symbol: Boolean;
            signal word_access_0_507_symbol : Boolean;
            -- 
          begin -- 
            word_access_504_start <= split_ack_503_symbol; -- control passed to block
            Xentry_505_symbol  <= word_access_504_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/$entry
            word_access_0_507: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/word_access_0 
              signal word_access_0_507_start: Boolean;
              signal Xentry_508_symbol: Boolean;
              signal Xexit_509_symbol: Boolean;
              signal rr_510_symbol : Boolean;
              signal ra_511_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_507_start <= Xentry_505_symbol; -- control passed to block
              Xentry_508_symbol  <= word_access_0_507_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/word_access_0/$entry
              rr_510_symbol <= Xentry_508_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/word_access_0/rr
              ptr_deref_97_store_0_req_0 <= rr_510_symbol; -- link to DP
              ra_511_symbol <= ptr_deref_97_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/word_access_0/ra
              Xexit_509_symbol <= ra_511_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/word_access_0/$exit
              word_access_0_507_symbol <= Xexit_509_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/word_access_0
            Xexit_506_symbol <= word_access_0_507_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access/$exit
            word_access_504_symbol <= Xexit_506_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/word_access
          Xexit_501_symbol <= word_access_504_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request/$exit
          ptr_deref_97_request_499_symbol <= Xexit_501_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_request
        ptr_deref_97_complete_512: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete 
          signal ptr_deref_97_complete_512_start: Boolean;
          signal Xentry_513_symbol: Boolean;
          signal Xexit_514_symbol: Boolean;
          signal word_access_515_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_97_complete_512_start <= ptr_deref_97_active_x_x478_symbol; -- control passed to block
          Xentry_513_symbol  <= ptr_deref_97_complete_512_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/$entry
          word_access_515: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access 
            signal word_access_515_start: Boolean;
            signal Xentry_516_symbol: Boolean;
            signal Xexit_517_symbol: Boolean;
            signal word_access_0_518_symbol : Boolean;
            -- 
          begin -- 
            word_access_515_start <= Xentry_513_symbol; -- control passed to block
            Xentry_516_symbol  <= word_access_515_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/$entry
            word_access_0_518: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/word_access_0 
              signal word_access_0_518_start: Boolean;
              signal Xentry_519_symbol: Boolean;
              signal Xexit_520_symbol: Boolean;
              signal cr_521_symbol : Boolean;
              signal ca_522_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_518_start <= Xentry_516_symbol; -- control passed to block
              Xentry_519_symbol  <= word_access_0_518_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/word_access_0/$entry
              cr_521_symbol <= Xentry_519_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/word_access_0/cr
              ptr_deref_97_store_0_req_1 <= cr_521_symbol; -- link to DP
              ca_522_symbol <= ptr_deref_97_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/word_access_0/ca
              Xexit_520_symbol <= ca_522_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/word_access_0/$exit
              word_access_0_518_symbol <= Xexit_520_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/word_access_0
            Xexit_517_symbol <= word_access_0_518_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access/$exit
            word_access_515_symbol <= Xexit_517_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/word_access
          Xexit_514_symbol <= word_access_515_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete/$exit
          ptr_deref_97_complete_512_symbol <= Xexit_514_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_97_complete
        assign_stmt_108_active_x_x523_symbol <= ptr_deref_107_complete_541_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_108_active_
        assign_stmt_108_completed_x_x524_symbol <= assign_stmt_108_active_x_x523_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_108_completed_
        ptr_deref_107_trigger_x_x525_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_trigger_ 
          signal ptr_deref_107_trigger_x_x525_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_107_trigger_x_x525_predecessors(0) <= ptr_deref_107_word_address_calculated_529_symbol;
          ptr_deref_107_trigger_x_x525_predecessors(1) <= ptr_deref_88_active_x_x447_symbol;
          ptr_deref_107_trigger_x_x525_join: join -- 
            port map( -- 
              preds => ptr_deref_107_trigger_x_x525_predecessors,
              symbol_out => ptr_deref_107_trigger_x_x525_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_trigger_
        ptr_deref_107_active_x_x526_symbol <= ptr_deref_107_request_530_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_active_
        ptr_deref_107_base_address_calculated_527_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_base_address_calculated
        ptr_deref_107_root_address_calculated_528_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_root_address_calculated
        ptr_deref_107_word_address_calculated_529_symbol <= ptr_deref_107_root_address_calculated_528_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_word_address_calculated
        ptr_deref_107_request_530: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request 
          signal ptr_deref_107_request_530_start: Boolean;
          signal Xentry_531_symbol: Boolean;
          signal Xexit_532_symbol: Boolean;
          signal word_access_533_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_107_request_530_start <= ptr_deref_107_trigger_x_x525_symbol; -- control passed to block
          Xentry_531_symbol  <= ptr_deref_107_request_530_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/$entry
          word_access_533: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access 
            signal word_access_533_start: Boolean;
            signal Xentry_534_symbol: Boolean;
            signal Xexit_535_symbol: Boolean;
            signal word_access_0_536_symbol : Boolean;
            -- 
          begin -- 
            word_access_533_start <= Xentry_531_symbol; -- control passed to block
            Xentry_534_symbol  <= word_access_533_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/$entry
            word_access_0_536: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/word_access_0 
              signal word_access_0_536_start: Boolean;
              signal Xentry_537_symbol: Boolean;
              signal Xexit_538_symbol: Boolean;
              signal rr_539_symbol : Boolean;
              signal ra_540_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_536_start <= Xentry_534_symbol; -- control passed to block
              Xentry_537_symbol  <= word_access_0_536_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/word_access_0/$entry
              rr_539_symbol <= Xentry_537_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/word_access_0/rr
              ptr_deref_107_load_0_req_0 <= rr_539_symbol; -- link to DP
              ra_540_symbol <= ptr_deref_107_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/word_access_0/ra
              Xexit_538_symbol <= ra_540_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/word_access_0/$exit
              word_access_0_536_symbol <= Xexit_538_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/word_access_0
            Xexit_535_symbol <= word_access_0_536_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access/$exit
            word_access_533_symbol <= Xexit_535_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/word_access
          Xexit_532_symbol <= word_access_533_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request/$exit
          ptr_deref_107_request_530_symbol <= Xexit_532_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_request
        ptr_deref_107_complete_541: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete 
          signal ptr_deref_107_complete_541_start: Boolean;
          signal Xentry_542_symbol: Boolean;
          signal Xexit_543_symbol: Boolean;
          signal word_access_544_symbol : Boolean;
          signal merge_req_552_symbol : Boolean;
          signal merge_ack_553_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_107_complete_541_start <= ptr_deref_107_active_x_x526_symbol; -- control passed to block
          Xentry_542_symbol  <= ptr_deref_107_complete_541_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/$entry
          word_access_544: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access 
            signal word_access_544_start: Boolean;
            signal Xentry_545_symbol: Boolean;
            signal Xexit_546_symbol: Boolean;
            signal word_access_0_547_symbol : Boolean;
            -- 
          begin -- 
            word_access_544_start <= Xentry_542_symbol; -- control passed to block
            Xentry_545_symbol  <= word_access_544_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/$entry
            word_access_0_547: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/word_access_0 
              signal word_access_0_547_start: Boolean;
              signal Xentry_548_symbol: Boolean;
              signal Xexit_549_symbol: Boolean;
              signal cr_550_symbol : Boolean;
              signal ca_551_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_547_start <= Xentry_545_symbol; -- control passed to block
              Xentry_548_symbol  <= word_access_0_547_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/word_access_0/$entry
              cr_550_symbol <= Xentry_548_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/word_access_0/cr
              ptr_deref_107_load_0_req_1 <= cr_550_symbol; -- link to DP
              ca_551_symbol <= ptr_deref_107_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/word_access_0/ca
              Xexit_549_symbol <= ca_551_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/word_access_0/$exit
              word_access_0_547_symbol <= Xexit_549_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/word_access_0
            Xexit_546_symbol <= word_access_0_547_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access/$exit
            word_access_544_symbol <= Xexit_546_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/word_access
          merge_req_552_symbol <= word_access_544_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/merge_req
          ptr_deref_107_gather_scatter_req_0 <= merge_req_552_symbol; -- link to DP
          merge_ack_553_symbol <= ptr_deref_107_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/merge_ack
          Xexit_543_symbol <= merge_ack_553_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete/$exit
          ptr_deref_107_complete_541_symbol <= Xexit_543_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_107_complete
        assign_stmt_117_active_x_x554_symbol <= ptr_deref_116_complete_572_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_117_active_
        assign_stmt_117_completed_x_x555_symbol <= assign_stmt_117_active_x_x554_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/assign_stmt_117_completed_
        ptr_deref_116_trigger_x_x556_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_trigger_ 
          signal ptr_deref_116_trigger_x_x556_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_116_trigger_x_x556_predecessors(0) <= ptr_deref_116_word_address_calculated_560_symbol;
          ptr_deref_116_trigger_x_x556_predecessors(1) <= ptr_deref_88_active_x_x447_symbol;
          ptr_deref_116_trigger_x_x556_join: join -- 
            port map( -- 
              preds => ptr_deref_116_trigger_x_x556_predecessors,
              symbol_out => ptr_deref_116_trigger_x_x556_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_trigger_
        ptr_deref_116_active_x_x557_symbol <= ptr_deref_116_request_561_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_active_
        ptr_deref_116_base_address_calculated_558_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_base_address_calculated
        ptr_deref_116_root_address_calculated_559_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_root_address_calculated
        ptr_deref_116_word_address_calculated_560_symbol <= ptr_deref_116_root_address_calculated_559_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_word_address_calculated
        ptr_deref_116_request_561: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request 
          signal ptr_deref_116_request_561_start: Boolean;
          signal Xentry_562_symbol: Boolean;
          signal Xexit_563_symbol: Boolean;
          signal word_access_564_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_116_request_561_start <= ptr_deref_116_trigger_x_x556_symbol; -- control passed to block
          Xentry_562_symbol  <= ptr_deref_116_request_561_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/$entry
          word_access_564: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access 
            signal word_access_564_start: Boolean;
            signal Xentry_565_symbol: Boolean;
            signal Xexit_566_symbol: Boolean;
            signal word_access_0_567_symbol : Boolean;
            -- 
          begin -- 
            word_access_564_start <= Xentry_562_symbol; -- control passed to block
            Xentry_565_symbol  <= word_access_564_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/$entry
            word_access_0_567: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/word_access_0 
              signal word_access_0_567_start: Boolean;
              signal Xentry_568_symbol: Boolean;
              signal Xexit_569_symbol: Boolean;
              signal rr_570_symbol : Boolean;
              signal ra_571_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_567_start <= Xentry_565_symbol; -- control passed to block
              Xentry_568_symbol  <= word_access_0_567_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/word_access_0/$entry
              rr_570_symbol <= Xentry_568_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/word_access_0/rr
              ptr_deref_116_load_0_req_0 <= rr_570_symbol; -- link to DP
              ra_571_symbol <= ptr_deref_116_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/word_access_0/ra
              Xexit_569_symbol <= ra_571_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/word_access_0/$exit
              word_access_0_567_symbol <= Xexit_569_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/word_access_0
            Xexit_566_symbol <= word_access_0_567_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access/$exit
            word_access_564_symbol <= Xexit_566_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/word_access
          Xexit_563_symbol <= word_access_564_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request/$exit
          ptr_deref_116_request_561_symbol <= Xexit_563_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_request
        ptr_deref_116_complete_572: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete 
          signal ptr_deref_116_complete_572_start: Boolean;
          signal Xentry_573_symbol: Boolean;
          signal Xexit_574_symbol: Boolean;
          signal word_access_575_symbol : Boolean;
          signal merge_req_583_symbol : Boolean;
          signal merge_ack_584_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_116_complete_572_start <= ptr_deref_116_active_x_x557_symbol; -- control passed to block
          Xentry_573_symbol  <= ptr_deref_116_complete_572_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/$entry
          word_access_575: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access 
            signal word_access_575_start: Boolean;
            signal Xentry_576_symbol: Boolean;
            signal Xexit_577_symbol: Boolean;
            signal word_access_0_578_symbol : Boolean;
            -- 
          begin -- 
            word_access_575_start <= Xentry_573_symbol; -- control passed to block
            Xentry_576_symbol  <= word_access_575_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/$entry
            word_access_0_578: Block -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/word_access_0 
              signal word_access_0_578_start: Boolean;
              signal Xentry_579_symbol: Boolean;
              signal Xexit_580_symbol: Boolean;
              signal cr_581_symbol : Boolean;
              signal ca_582_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_578_start <= Xentry_576_symbol; -- control passed to block
              Xentry_579_symbol  <= word_access_0_578_start; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/word_access_0/$entry
              cr_581_symbol <= Xentry_579_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/word_access_0/cr
              ptr_deref_116_load_0_req_1 <= cr_581_symbol; -- link to DP
              ca_582_symbol <= ptr_deref_116_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/word_access_0/ca
              Xexit_580_symbol <= ca_582_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/word_access_0/$exit
              word_access_0_578_symbol <= Xexit_580_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/word_access_0
            Xexit_577_symbol <= word_access_0_578_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access/$exit
            word_access_575_symbol <= Xexit_577_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/word_access
          merge_req_583_symbol <= word_access_575_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/merge_req
          ptr_deref_116_gather_scatter_req_0 <= merge_req_583_symbol; -- link to DP
          merge_ack_584_symbol <= ptr_deref_116_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/merge_ack
          Xexit_574_symbol <= merge_ack_584_symbol; -- transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete/$exit
          ptr_deref_116_complete_572_symbol <= Xexit_574_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/ptr_deref_116_complete
        Xexit_288_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/$exit 
          signal Xexit_288_predecessors: BooleanArray(10 downto 0);
          -- 
        begin -- 
          Xexit_288_predecessors(0) <= assign_stmt_63_completed_x_x290_symbol;
          Xexit_288_predecessors(1) <= assign_stmt_66_completed_x_x321_symbol;
          Xexit_288_predecessors(2) <= assign_stmt_78_completed_x_x382_symbol;
          Xexit_288_predecessors(3) <= ptr_deref_76_base_address_calculated_386_symbol;
          Xexit_288_predecessors(4) <= assign_stmt_90_completed_x_x444_symbol;
          Xexit_288_predecessors(5) <= ptr_deref_88_base_address_calculated_448_symbol;
          Xexit_288_predecessors(6) <= assign_stmt_99_completed_x_x476_symbol;
          Xexit_288_predecessors(7) <= assign_stmt_108_completed_x_x524_symbol;
          Xexit_288_predecessors(8) <= ptr_deref_107_base_address_calculated_527_symbol;
          Xexit_288_predecessors(9) <= assign_stmt_117_completed_x_x555_symbol;
          Xexit_288_predecessors(10) <= ptr_deref_116_base_address_calculated_558_symbol;
          Xexit_288_join: join -- 
            port map( -- 
              preds => Xexit_288_predecessors,
              symbol_out => Xexit_288_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117/$exit
        assign_stmt_63_to_assign_stmt_117_286_symbol <= Xexit_288_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_63_to_assign_stmt_117
      call_stmt_121_585: Block -- branch_block_stmt_57/call_stmt_121 
        signal call_stmt_121_585_start: Boolean;
        signal Xentry_586_symbol: Boolean;
        signal Xexit_587_symbol: Boolean;
        signal simple_obj_ref_118_complete_588_symbol : Boolean;
        signal simple_obj_ref_119_complete_589_symbol : Boolean;
        signal call_stmt_121_active_x_x590_symbol : Boolean;
        signal call_stmt_121_in_progress_591_symbol : Boolean;
        signal call_stmt_121_start_592_symbol : Boolean;
        signal call_stmt_121_complete_597_symbol : Boolean;
        signal call_stmt_121_call_complete_602_symbol : Boolean;
        signal call_stmt_121_completed_x_x603_symbol : Boolean;
        -- 
      begin -- 
        call_stmt_121_585_start <= call_stmt_121_x_xentry_x_xx_x278_symbol; -- control passed to block
        Xentry_586_symbol  <= call_stmt_121_585_start; -- transition branch_block_stmt_57/call_stmt_121/$entry
        simple_obj_ref_118_complete_588_symbol <= Xentry_586_symbol; -- transition branch_block_stmt_57/call_stmt_121/simple_obj_ref_118_complete
        simple_obj_ref_119_complete_589_symbol <= Xentry_586_symbol; -- transition branch_block_stmt_57/call_stmt_121/simple_obj_ref_119_complete
        call_stmt_121_active_x_x590_block : Block -- non-trivial join transition branch_block_stmt_57/call_stmt_121/call_stmt_121_active_ 
          signal call_stmt_121_active_x_x590_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          call_stmt_121_active_x_x590_predecessors(0) <= simple_obj_ref_118_complete_588_symbol;
          call_stmt_121_active_x_x590_predecessors(1) <= simple_obj_ref_119_complete_589_symbol;
          call_stmt_121_active_x_x590_join: join -- 
            port map( -- 
              preds => call_stmt_121_active_x_x590_predecessors,
              symbol_out => call_stmt_121_active_x_x590_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/call_stmt_121/call_stmt_121_active_
        call_stmt_121_in_progress_591_symbol <= call_stmt_121_start_592_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_in_progress
        call_stmt_121_start_592: Block -- branch_block_stmt_57/call_stmt_121/call_stmt_121_start 
          signal call_stmt_121_start_592_start: Boolean;
          signal Xentry_593_symbol: Boolean;
          signal Xexit_594_symbol: Boolean;
          signal crr_595_symbol : Boolean;
          signal cra_596_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_121_start_592_start <= call_stmt_121_active_x_x590_symbol; -- control passed to block
          Xentry_593_symbol  <= call_stmt_121_start_592_start; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_start/$entry
          crr_595_symbol <= Xentry_593_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_start/crr
          call_stmt_121_call_req_0 <= crr_595_symbol; -- link to DP
          cra_596_symbol <= call_stmt_121_call_ack_0; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_start/cra
          Xexit_594_symbol <= cra_596_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_start/$exit
          call_stmt_121_start_592_symbol <= Xexit_594_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/call_stmt_121/call_stmt_121_start
        call_stmt_121_complete_597: Block -- branch_block_stmt_57/call_stmt_121/call_stmt_121_complete 
          signal call_stmt_121_complete_597_start: Boolean;
          signal Xentry_598_symbol: Boolean;
          signal Xexit_599_symbol: Boolean;
          signal ccr_600_symbol : Boolean;
          signal cca_601_symbol : Boolean;
          -- 
        begin -- 
          call_stmt_121_complete_597_start <= call_stmt_121_in_progress_591_symbol; -- control passed to block
          Xentry_598_symbol  <= call_stmt_121_complete_597_start; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_complete/$entry
          ccr_600_symbol <= Xentry_598_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_complete/ccr
          call_stmt_121_call_req_1 <= ccr_600_symbol; -- link to DP
          cca_601_symbol <= call_stmt_121_call_ack_1; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_complete/cca
          Xexit_599_symbol <= cca_601_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_complete/$exit
          call_stmt_121_complete_597_symbol <= Xexit_599_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/call_stmt_121/call_stmt_121_complete
        call_stmt_121_call_complete_602_symbol <= call_stmt_121_complete_597_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_call_complete
        call_stmt_121_completed_x_x603_symbol <= call_stmt_121_call_complete_602_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_completed_
        Xexit_587_symbol <= call_stmt_121_completed_x_x603_symbol; -- transition branch_block_stmt_57/call_stmt_121/$exit
        call_stmt_121_585_symbol <= Xexit_587_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/call_stmt_121
      assign_stmt_124_604: Block -- branch_block_stmt_57/assign_stmt_124 
        signal assign_stmt_124_604_start: Boolean;
        signal Xentry_605_symbol: Boolean;
        signal Xexit_606_symbol: Boolean;
        signal assign_stmt_124_active_x_x607_symbol : Boolean;
        signal assign_stmt_124_completed_x_x608_symbol : Boolean;
        signal simple_obj_ref_123_complete_609_symbol : Boolean;
        signal simple_obj_ref_122_trigger_x_x610_symbol : Boolean;
        signal simple_obj_ref_122_active_x_x611_symbol : Boolean;
        signal simple_obj_ref_122_root_address_calculated_612_symbol : Boolean;
        signal simple_obj_ref_122_word_address_calculated_613_symbol : Boolean;
        signal simple_obj_ref_122_request_614_symbol : Boolean;
        signal simple_obj_ref_122_complete_627_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_124_604_start <= assign_stmt_124_x_xentry_x_xx_x280_symbol; -- control passed to block
        Xentry_605_symbol  <= assign_stmt_124_604_start; -- transition branch_block_stmt_57/assign_stmt_124/$entry
        assign_stmt_124_active_x_x607_symbol <= simple_obj_ref_123_complete_609_symbol; -- transition branch_block_stmt_57/assign_stmt_124/assign_stmt_124_active_
        assign_stmt_124_completed_x_x608_symbol <= simple_obj_ref_122_complete_627_symbol; -- transition branch_block_stmt_57/assign_stmt_124/assign_stmt_124_completed_
        simple_obj_ref_123_complete_609_symbol <= Xentry_605_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_123_complete
        simple_obj_ref_122_trigger_x_x610_block : Block -- non-trivial join transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_trigger_ 
          signal simple_obj_ref_122_trigger_x_x610_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_122_trigger_x_x610_predecessors(0) <= simple_obj_ref_122_word_address_calculated_613_symbol;
          simple_obj_ref_122_trigger_x_x610_predecessors(1) <= assign_stmt_124_active_x_x607_symbol;
          simple_obj_ref_122_trigger_x_x610_join: join -- 
            port map( -- 
              preds => simple_obj_ref_122_trigger_x_x610_predecessors,
              symbol_out => simple_obj_ref_122_trigger_x_x610_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_trigger_
        simple_obj_ref_122_active_x_x611_symbol <= simple_obj_ref_122_request_614_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_active_
        simple_obj_ref_122_root_address_calculated_612_symbol <= Xentry_605_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_root_address_calculated
        simple_obj_ref_122_word_address_calculated_613_symbol <= simple_obj_ref_122_root_address_calculated_612_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_word_address_calculated
        simple_obj_ref_122_request_614: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request 
          signal simple_obj_ref_122_request_614_start: Boolean;
          signal Xentry_615_symbol: Boolean;
          signal Xexit_616_symbol: Boolean;
          signal split_req_617_symbol : Boolean;
          signal split_ack_618_symbol : Boolean;
          signal word_access_619_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_122_request_614_start <= simple_obj_ref_122_trigger_x_x610_symbol; -- control passed to block
          Xentry_615_symbol  <= simple_obj_ref_122_request_614_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/$entry
          split_req_617_symbol <= Xentry_615_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/split_req
          simple_obj_ref_122_gather_scatter_req_0 <= split_req_617_symbol; -- link to DP
          split_ack_618_symbol <= simple_obj_ref_122_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/split_ack
          word_access_619: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access 
            signal word_access_619_start: Boolean;
            signal Xentry_620_symbol: Boolean;
            signal Xexit_621_symbol: Boolean;
            signal word_access_0_622_symbol : Boolean;
            -- 
          begin -- 
            word_access_619_start <= split_ack_618_symbol; -- control passed to block
            Xentry_620_symbol  <= word_access_619_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/$entry
            word_access_0_622: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/word_access_0 
              signal word_access_0_622_start: Boolean;
              signal Xentry_623_symbol: Boolean;
              signal Xexit_624_symbol: Boolean;
              signal rr_625_symbol : Boolean;
              signal ra_626_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_622_start <= Xentry_620_symbol; -- control passed to block
              Xentry_623_symbol  <= word_access_0_622_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/word_access_0/$entry
              rr_625_symbol <= Xentry_623_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/word_access_0/rr
              simple_obj_ref_122_store_0_req_0 <= rr_625_symbol; -- link to DP
              ra_626_symbol <= simple_obj_ref_122_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/word_access_0/ra
              Xexit_624_symbol <= ra_626_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/word_access_0/$exit
              word_access_0_622_symbol <= Xexit_624_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/word_access_0
            Xexit_621_symbol <= word_access_0_622_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access/$exit
            word_access_619_symbol <= Xexit_621_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/word_access
          Xexit_616_symbol <= word_access_619_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request/$exit
          simple_obj_ref_122_request_614_symbol <= Xexit_616_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_request
        simple_obj_ref_122_complete_627: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete 
          signal simple_obj_ref_122_complete_627_start: Boolean;
          signal Xentry_628_symbol: Boolean;
          signal Xexit_629_symbol: Boolean;
          signal word_access_630_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_122_complete_627_start <= simple_obj_ref_122_active_x_x611_symbol; -- control passed to block
          Xentry_628_symbol  <= simple_obj_ref_122_complete_627_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/$entry
          word_access_630: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access 
            signal word_access_630_start: Boolean;
            signal Xentry_631_symbol: Boolean;
            signal Xexit_632_symbol: Boolean;
            signal word_access_0_633_symbol : Boolean;
            -- 
          begin -- 
            word_access_630_start <= Xentry_628_symbol; -- control passed to block
            Xentry_631_symbol  <= word_access_630_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/$entry
            word_access_0_633: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/word_access_0 
              signal word_access_0_633_start: Boolean;
              signal Xentry_634_symbol: Boolean;
              signal Xexit_635_symbol: Boolean;
              signal cr_636_symbol : Boolean;
              signal ca_637_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_633_start <= Xentry_631_symbol; -- control passed to block
              Xentry_634_symbol  <= word_access_0_633_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/word_access_0/$entry
              cr_636_symbol <= Xentry_634_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/word_access_0/cr
              simple_obj_ref_122_store_0_req_1 <= cr_636_symbol; -- link to DP
              ca_637_symbol <= simple_obj_ref_122_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/word_access_0/ca
              Xexit_635_symbol <= ca_637_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/word_access_0/$exit
              word_access_0_633_symbol <= Xexit_635_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/word_access_0
            Xexit_632_symbol <= word_access_0_633_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access/$exit
            word_access_630_symbol <= Xexit_632_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/word_access
          Xexit_629_symbol <= word_access_630_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete/$exit
          simple_obj_ref_122_complete_627_symbol <= Xexit_629_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122_complete
        Xexit_606_symbol <= assign_stmt_124_completed_x_x608_symbol; -- transition branch_block_stmt_57/assign_stmt_124/$exit
        assign_stmt_124_604_symbol <= Xexit_606_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_124
      assign_stmt_129_638: Block -- branch_block_stmt_57/assign_stmt_129 
        signal assign_stmt_129_638_start: Boolean;
        signal Xentry_639_symbol: Boolean;
        signal Xexit_640_symbol: Boolean;
        signal assign_stmt_129_active_x_x641_symbol : Boolean;
        signal assign_stmt_129_completed_x_x642_symbol : Boolean;
        signal simple_obj_ref_128_trigger_x_x643_symbol : Boolean;
        signal simple_obj_ref_128_active_x_x644_symbol : Boolean;
        signal simple_obj_ref_128_root_address_calculated_645_symbol : Boolean;
        signal simple_obj_ref_128_word_address_calculated_646_symbol : Boolean;
        signal simple_obj_ref_128_request_647_symbol : Boolean;
        signal simple_obj_ref_128_complete_658_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_129_638_start <= assign_stmt_129_x_xentry_x_xx_x284_symbol; -- control passed to block
        Xentry_639_symbol  <= assign_stmt_129_638_start; -- transition branch_block_stmt_57/assign_stmt_129/$entry
        assign_stmt_129_active_x_x641_symbol <= simple_obj_ref_128_complete_658_symbol; -- transition branch_block_stmt_57/assign_stmt_129/assign_stmt_129_active_
        assign_stmt_129_completed_x_x642_symbol <= assign_stmt_129_active_x_x641_symbol; -- transition branch_block_stmt_57/assign_stmt_129/assign_stmt_129_completed_
        simple_obj_ref_128_trigger_x_x643_symbol <= simple_obj_ref_128_word_address_calculated_646_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_trigger_
        simple_obj_ref_128_active_x_x644_symbol <= simple_obj_ref_128_request_647_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_active_
        simple_obj_ref_128_root_address_calculated_645_symbol <= Xentry_639_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_root_address_calculated
        simple_obj_ref_128_word_address_calculated_646_symbol <= simple_obj_ref_128_root_address_calculated_645_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_word_address_calculated
        simple_obj_ref_128_request_647: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request 
          signal simple_obj_ref_128_request_647_start: Boolean;
          signal Xentry_648_symbol: Boolean;
          signal Xexit_649_symbol: Boolean;
          signal word_access_650_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_128_request_647_start <= simple_obj_ref_128_trigger_x_x643_symbol; -- control passed to block
          Xentry_648_symbol  <= simple_obj_ref_128_request_647_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/$entry
          word_access_650: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access 
            signal word_access_650_start: Boolean;
            signal Xentry_651_symbol: Boolean;
            signal Xexit_652_symbol: Boolean;
            signal word_access_0_653_symbol : Boolean;
            -- 
          begin -- 
            word_access_650_start <= Xentry_648_symbol; -- control passed to block
            Xentry_651_symbol  <= word_access_650_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/$entry
            word_access_0_653: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/word_access_0 
              signal word_access_0_653_start: Boolean;
              signal Xentry_654_symbol: Boolean;
              signal Xexit_655_symbol: Boolean;
              signal rr_656_symbol : Boolean;
              signal ra_657_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_653_start <= Xentry_651_symbol; -- control passed to block
              Xentry_654_symbol  <= word_access_0_653_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/word_access_0/$entry
              rr_656_symbol <= Xentry_654_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/word_access_0/rr
              simple_obj_ref_128_load_0_req_0 <= rr_656_symbol; -- link to DP
              ra_657_symbol <= simple_obj_ref_128_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/word_access_0/ra
              Xexit_655_symbol <= ra_657_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/word_access_0/$exit
              word_access_0_653_symbol <= Xexit_655_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/word_access_0
            Xexit_652_symbol <= word_access_0_653_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access/$exit
            word_access_650_symbol <= Xexit_652_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/word_access
          Xexit_649_symbol <= word_access_650_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request/$exit
          simple_obj_ref_128_request_647_symbol <= Xexit_649_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_request
        simple_obj_ref_128_complete_658: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete 
          signal simple_obj_ref_128_complete_658_start: Boolean;
          signal Xentry_659_symbol: Boolean;
          signal Xexit_660_symbol: Boolean;
          signal word_access_661_symbol : Boolean;
          signal merge_req_669_symbol : Boolean;
          signal merge_ack_670_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_128_complete_658_start <= simple_obj_ref_128_active_x_x644_symbol; -- control passed to block
          Xentry_659_symbol  <= simple_obj_ref_128_complete_658_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/$entry
          word_access_661: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access 
            signal word_access_661_start: Boolean;
            signal Xentry_662_symbol: Boolean;
            signal Xexit_663_symbol: Boolean;
            signal word_access_0_664_symbol : Boolean;
            -- 
          begin -- 
            word_access_661_start <= Xentry_659_symbol; -- control passed to block
            Xentry_662_symbol  <= word_access_661_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/$entry
            word_access_0_664: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/word_access_0 
              signal word_access_0_664_start: Boolean;
              signal Xentry_665_symbol: Boolean;
              signal Xexit_666_symbol: Boolean;
              signal cr_667_symbol : Boolean;
              signal ca_668_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_664_start <= Xentry_662_symbol; -- control passed to block
              Xentry_665_symbol  <= word_access_0_664_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/word_access_0/$entry
              cr_667_symbol <= Xentry_665_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/word_access_0/cr
              simple_obj_ref_128_load_0_req_1 <= cr_667_symbol; -- link to DP
              ca_668_symbol <= simple_obj_ref_128_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/word_access_0/ca
              Xexit_666_symbol <= ca_668_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/word_access_0/$exit
              word_access_0_664_symbol <= Xexit_666_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/word_access_0
            Xexit_663_symbol <= word_access_0_664_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access/$exit
            word_access_661_symbol <= Xexit_663_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/word_access
          merge_req_669_symbol <= word_access_661_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/merge_req
          simple_obj_ref_128_gather_scatter_req_0 <= merge_req_669_symbol; -- link to DP
          merge_ack_670_symbol <= simple_obj_ref_128_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/merge_ack
          Xexit_660_symbol <= merge_ack_670_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete/$exit
          simple_obj_ref_128_complete_658_symbol <= Xexit_660_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128_complete
        Xexit_640_symbol <= assign_stmt_129_completed_x_x642_symbol; -- transition branch_block_stmt_57/assign_stmt_129/$exit
        assign_stmt_129_638_symbol <= Xexit_640_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_129
      return_x_xx_xPhiReq_671: Block -- branch_block_stmt_57/return___PhiReq 
        signal return_x_xx_xPhiReq_671_start: Boolean;
        signal Xentry_672_symbol: Boolean;
        signal Xexit_673_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_671_start <= return_x_xx_x282_symbol; -- control passed to block
        Xentry_672_symbol  <= return_x_xx_xPhiReq_671_start; -- transition branch_block_stmt_57/return___PhiReq/$entry
        Xexit_673_symbol <= Xentry_672_symbol; -- transition branch_block_stmt_57/return___PhiReq/$exit
        return_x_xx_xPhiReq_671_symbol <= Xexit_673_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/return___PhiReq
      merge_stmt_126_PhiReqMerge_674_symbol  <=  return_x_xx_xPhiReq_671_symbol; -- place branch_block_stmt_57/merge_stmt_126_PhiReqMerge (optimized away) 
      merge_stmt_126_PhiAck_675: Block -- branch_block_stmt_57/merge_stmt_126_PhiAck 
        signal merge_stmt_126_PhiAck_675_start: Boolean;
        signal Xentry_676_symbol: Boolean;
        signal Xexit_677_symbol: Boolean;
        signal dummy_678_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_126_PhiAck_675_start <= merge_stmt_126_PhiReqMerge_674_symbol; -- control passed to block
        Xentry_676_symbol  <= merge_stmt_126_PhiAck_675_start; -- transition branch_block_stmt_57/merge_stmt_126_PhiAck/$entry
        dummy_678_symbol <= Xentry_676_symbol; -- transition branch_block_stmt_57/merge_stmt_126_PhiAck/dummy
        Xexit_677_symbol <= dummy_678_symbol; -- transition branch_block_stmt_57/merge_stmt_126_PhiAck/$exit
        merge_stmt_126_PhiAck_675_symbol <= Xexit_677_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/merge_stmt_126_PhiAck
      Xexit_273_symbol <= branch_block_stmt_57_x_xexit_x_xx_x275_symbol; -- transition branch_block_stmt_57/$exit
      branch_block_stmt_57_271_symbol <= Xexit_273_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_57
    Xexit_270_symbol <= branch_block_stmt_57_271_symbol; -- transition $exit
    fin  <=  '1' when Xexit_270_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal expr_98_wire_constant : std_logic_vector(31 downto 0);
    signal iNsTr_10_95 : std_logic_vector(31 downto 0);
    signal iNsTr_12_104 : std_logic_vector(31 downto 0);
    signal iNsTr_13_108 : std_logic_vector(31 downto 0);
    signal iNsTr_14_113 : std_logic_vector(31 downto 0);
    signal iNsTr_15_117 : std_logic_vector(31 downto 0);
    signal iNsTr_16_121 : std_logic_vector(31 downto 0);
    signal iNsTr_4_69 : std_logic_vector(31 downto 0);
    signal iNsTr_5_74 : std_logic_vector(31 downto 0);
    signal iNsTr_7_81 : std_logic_vector(31 downto 0);
    signal iNsTr_8_86 : std_logic_vector(31 downto 0);
    signal ptr_deref_107_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_107_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_116_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_116_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_76_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_76_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_76_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_88_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_88_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_88_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_97_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_97_resized_base_address : std_logic_vector(0 downto 0);
    signal ptr_deref_97_root_address : std_logic_vector(0 downto 0);
    signal ptr_deref_97_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_97_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_97_word_offset_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_122_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_122_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_128_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_128_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_61_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_61_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_64_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_64_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_68_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_68_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_80_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_80_word_address_0 : std_logic_vector(0 downto 0);
    signal xxsubxxbodyxxiNsTr_0_base_address : std_logic_vector(0 downto 0);
    signal xxsubxxbodyxxiNsTr_1_base_address : std_logic_vector(0 downto 0);
    signal xxsubxxbodyxxt_base_address : std_logic_vector(0 downto 0);
    signal xxsubxxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    expr_98_wire_constant <= "00000000000000000000000000000000";
    iNsTr_10_95 <= "00000000000000000000000000000000";
    iNsTr_12_104 <= "00000000000000000000000000000000";
    iNsTr_14_113 <= "00000000000000000000000000000000";
    iNsTr_5_74 <= "00000000000000000000000000000000";
    iNsTr_8_86 <= "00000000000000000000000000000000";
    ptr_deref_107_word_address_0 <= "0";
    ptr_deref_116_word_address_0 <= "0";
    ptr_deref_76_word_address_0 <= "0";
    ptr_deref_88_word_address_0 <= "0";
    ptr_deref_97_word_offset_0 <= "0";
    simple_obj_ref_122_word_address_0 <= "0";
    simple_obj_ref_128_word_address_0 <= "0";
    simple_obj_ref_61_word_address_0 <= "0";
    simple_obj_ref_64_word_address_0 <= "0";
    simple_obj_ref_68_word_address_0 <= "0";
    simple_obj_ref_80_word_address_0 <= "0";
    xxsubxxbodyxxiNsTr_0_base_address <= "0";
    xxsubxxbodyxxiNsTr_1_base_address <= "0";
    xxsubxxbodyxxt_base_address <= "0";
    xxsubxxstored_ret_val_x_xx_xbase_address <= "0";
    ptr_deref_97_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 1) -- 
      port map( din => iNsTr_10_95, dout => ptr_deref_97_resized_base_address, req => ptr_deref_97_base_resize_req_0, ack => ptr_deref_97_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_107_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_107_gather_scatter_ack_0 <= ptr_deref_107_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_107_data_0;
      iNsTr_13_108 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_116_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_116_gather_scatter_ack_0 <= ptr_deref_116_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_116_data_0;
      iNsTr_15_117 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_76_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_76_gather_scatter_ack_0 <= ptr_deref_76_gather_scatter_req_0;
      aggregated_sig <= iNsTr_4_69;
      ptr_deref_76_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_88_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_88_gather_scatter_ack_0 <= ptr_deref_88_gather_scatter_req_0;
      aggregated_sig <= iNsTr_7_81;
      ptr_deref_88_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_97_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      ptr_deref_97_addr_0_ack_0 <= ptr_deref_97_addr_0_req_0;
      aggregated_sig <= ptr_deref_97_root_address;
      ptr_deref_97_word_address_0 <= aggregated_sig(0 downto 0);
      --
    end Block;
    ptr_deref_97_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_97_gather_scatter_ack_0 <= ptr_deref_97_gather_scatter_req_0;
      aggregated_sig <= expr_98_wire_constant;
      ptr_deref_97_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_97_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      ptr_deref_97_root_address_inst_ack_0 <= ptr_deref_97_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_97_resized_base_address;
      ptr_deref_97_root_address <= aggregated_sig(0 downto 0);
      --
    end Block;
    simple_obj_ref_122_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_122_gather_scatter_ack_0 <= simple_obj_ref_122_gather_scatter_req_0;
      aggregated_sig <= iNsTr_16_121;
      simple_obj_ref_122_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_128_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_128_gather_scatter_ack_0 <= simple_obj_ref_128_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_128_data_0;
      ret_val_x_x <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_61_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_61_gather_scatter_ack_0 <= simple_obj_ref_61_gather_scatter_req_0;
      aggregated_sig <= a;
      simple_obj_ref_61_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_64_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_64_gather_scatter_ack_0 <= simple_obj_ref_64_gather_scatter_req_0;
      aggregated_sig <= b;
      simple_obj_ref_64_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_68_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_68_gather_scatter_ack_0 <= simple_obj_ref_68_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_68_data_0;
      iNsTr_4_69 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_80_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_80_gather_scatter_ack_0 <= simple_obj_ref_80_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_80_data_0;
      iNsTr_7_81 <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared load operator group (0) : ptr_deref_107_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_107_load_0_req_0;
      ptr_deref_107_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_107_load_0_req_1;
      ptr_deref_107_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_107_word_address_0;
      ptr_deref_107_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_7_lr_req(1),
          mack => memory_space_7_lr_ack(1),
          maddr => memory_space_7_lr_addr(1 downto 1),
          mtag => memory_space_7_lr_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_7_lc_req(1),
          mack => memory_space_7_lc_ack(1),
          mdata => memory_space_7_lc_data(63 downto 32),
          mtag => memory_space_7_lc_tag(1 downto 1),
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
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
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
    -- shared load operator group (2) : simple_obj_ref_128_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_128_load_0_req_0;
      simple_obj_ref_128_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_128_load_0_req_1;
      simple_obj_ref_128_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_128_word_address_0;
      simple_obj_ref_128_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_4_lr_req(0),
          mack => memory_space_4_lr_ack(0),
          maddr => memory_space_4_lr_addr(0 downto 0),
          mtag => memory_space_4_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_4_lc_req(0),
          mack => memory_space_4_lc_ack(0),
          mdata => memory_space_4_lc_data(31 downto 0),
          mtag => memory_space_4_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : simple_obj_ref_68_load_0 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_68_load_0_req_0;
      simple_obj_ref_68_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_68_load_0_req_1;
      simple_obj_ref_68_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_68_word_address_0;
      simple_obj_ref_68_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
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
    end Block; -- load group 3
    -- shared load operator group (4) : simple_obj_ref_80_load_0 
    LoadGroup4: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_80_load_0_req_0;
      simple_obj_ref_80_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_80_load_0_req_1;
      simple_obj_ref_80_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_80_word_address_0;
      simple_obj_ref_80_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_6_lr_req(0),
          mack => memory_space_6_lr_ack(0),
          maddr => memory_space_6_lr_addr(0 downto 0),
          mtag => memory_space_6_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_6_lc_req(0),
          mack => memory_space_6_lc_ack(0),
          mdata => memory_space_6_lc_data(31 downto 0),
          mtag => memory_space_6_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 4
    -- shared store operator group (0) : ptr_deref_76_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_76_store_0_req_0;
      ptr_deref_76_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_76_store_0_req_1;
      ptr_deref_76_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_76_word_address_0;
      data_in <= ptr_deref_76_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_7_sr_req(1),
          mack => memory_space_7_sr_ack(1),
          maddr => memory_space_7_sr_addr(1 downto 1),
          mdata => memory_space_7_sr_data(63 downto 32),
          mtag => memory_space_7_sr_tag(1 downto 1),
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
          mreq => memory_space_7_sc_req(1),
          mack => memory_space_7_sc_ack(1),
          mtag => memory_space_7_sc_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_88_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_88_store_0_req_0;
      ptr_deref_88_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_88_store_0_req_1;
      ptr_deref_88_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_88_word_address_0;
      data_in <= ptr_deref_88_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
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
    -- shared store operator group (2) : ptr_deref_97_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_97_store_0_req_0;
      ptr_deref_97_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_97_store_0_req_1;
      ptr_deref_97_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_97_word_address_0;
      data_in <= ptr_deref_97_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(0),
          mack => memory_space_0_sr_ack(0),
          maddr => memory_space_0_sr_addr(0 downto 0),
          mdata => memory_space_0_sr_data(31 downto 0),
          mtag => memory_space_0_sr_tag(0 downto 0),
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
          mreq => memory_space_0_sc_req(0),
          mack => memory_space_0_sc_ack(0),
          mtag => memory_space_0_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared store operator group (3) : simple_obj_ref_122_store_0 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_122_store_0_req_0;
      simple_obj_ref_122_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_122_store_0_req_1;
      simple_obj_ref_122_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_122_word_address_0;
      data_in <= simple_obj_ref_122_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
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
          mtag => memory_space_4_sr_tag(0 downto 0),
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
          mreq => memory_space_4_sc_req(0),
          mack => memory_space_4_sc_ack(0),
          mtag => memory_space_4_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 3
    -- shared store operator group (4) : simple_obj_ref_61_store_0 
    StoreGroup4: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_61_store_0_req_0;
      simple_obj_ref_61_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_61_store_0_req_1;
      simple_obj_ref_61_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_61_word_address_0;
      data_in <= simple_obj_ref_61_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
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
    end Block; -- store group 4
    -- shared store operator group (5) : simple_obj_ref_64_store_0 
    StoreGroup5: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_64_store_0_req_0;
      simple_obj_ref_64_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_64_store_0_req_1;
      simple_obj_ref_64_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_64_word_address_0;
      data_in <= simple_obj_ref_64_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
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
          mtag => memory_space_6_sr_tag(0 downto 0),
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
          mreq => memory_space_6_sc_req(0),
          mack => memory_space_6_sc_ack(0),
          mtag => memory_space_6_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 5
    -- shared call operator group (0) : call_stmt_121_call 
    CallGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= call_stmt_121_call_req_0;
      call_stmt_121_call_ack_0 <= ackL(0);
      reqR(0) <= call_stmt_121_call_req_1;
      call_stmt_121_call_ack_1 <= ackR(0);
      data_in <= iNsTr_13_108 & iNsTr_15_117;
      iNsTr_16_121 <= data_out(31 downto 0);
      CallReq: InputMuxBase -- 
        generic map (  iwidth => 64, owidth => 64, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          reqR => sub_slave_call_reqs(0),
          ackR => sub_slave_call_acks(0),
          dataR => sub_slave_call_data(63 downto 0),
          tagR => sub_slave_call_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      CallComplete: OutputDemuxBase -- 
        generic map ( 
        iwidth => 32, owidth => 32, twidth => 1, nreqs => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          reqL => sub_slave_return_acks(0), -- cross-over
          ackL => sub_slave_return_reqs(0), -- cross-over
          dataL => sub_slave_return_data(31 downto 0),
          tagL => sub_slave_return_tag(0 downto 0),
          clk => clk,
          reset => reset -- 
        ); -- 
      -- 
    end Block; -- call group 0
    -- 
  end Block; -- data_path
  RegisterBank_memory_space_4: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
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
  RegisterBank_memory_space_6: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
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
      num_loads => 2,
      num_stores => 2,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 2) -- 
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
library work;
use work.vc_system_package.all;
entity sub_slave is -- 
  port ( -- 
    a : in  std_logic_vector(31 downto 0);
    b : in  std_logic_vector(31 downto 0);
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity sub_slave;
architecture Default of sub_slave is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal simple_obj_ref_14_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_14_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_14_store_0_req_0 : boolean;
  signal simple_obj_ref_14_store_0_ack_0 : boolean;
  signal simple_obj_ref_14_store_0_req_1 : boolean;
  signal simple_obj_ref_14_store_0_ack_1 : boolean;
  signal simple_obj_ref_11_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_11_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_11_store_0_req_0 : boolean;
  signal simple_obj_ref_11_store_0_ack_0 : boolean;
  signal ptr_deref_24_load_0_req_1 : boolean;
  signal ptr_deref_24_load_0_ack_1 : boolean;
  signal ptr_deref_24_gather_scatter_req_0 : boolean;
  signal ptr_deref_24_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_11_store_0_req_1 : boolean;
  signal simple_obj_ref_11_store_0_ack_1 : boolean;
  signal ptr_deref_24_load_0_req_0 : boolean;
  signal ptr_deref_24_load_0_ack_0 : boolean;
  signal simple_obj_ref_42_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_42_store_0_req_0 : boolean;
  signal simple_obj_ref_42_store_0_ack_0 : boolean;
  signal simple_obj_ref_27_load_0_req_0 : boolean;
  signal simple_obj_ref_27_load_0_ack_0 : boolean;
  signal simple_obj_ref_27_load_0_req_1 : boolean;
  signal simple_obj_ref_27_load_0_ack_1 : boolean;
  signal simple_obj_ref_27_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_27_gather_scatter_ack_0 : boolean;
  signal binary_32_inst_req_0 : boolean;
  signal binary_32_inst_ack_0 : boolean;
  signal binary_32_inst_req_1 : boolean;
  signal binary_32_inst_ack_1 : boolean;
  signal simple_obj_ref_35_load_0_req_0 : boolean;
  signal simple_obj_ref_35_load_0_ack_0 : boolean;
  signal simple_obj_ref_35_load_0_req_1 : boolean;
  signal simple_obj_ref_35_load_0_ack_1 : boolean;
  signal simple_obj_ref_35_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_35_gather_scatter_ack_0 : boolean;
  signal binary_40_inst_req_0 : boolean;
  signal binary_40_inst_ack_0 : boolean;
  signal binary_40_inst_req_1 : boolean;
  signal binary_40_inst_ack_1 : boolean;
  signal simple_obj_ref_42_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_42_store_0_req_1 : boolean;
  signal simple_obj_ref_42_store_0_ack_1 : boolean;
  signal simple_obj_ref_48_load_0_req_0 : boolean;
  signal simple_obj_ref_48_load_0_ack_0 : boolean;
  signal simple_obj_ref_48_load_0_req_1 : boolean;
  signal simple_obj_ref_48_load_0_ack_1 : boolean;
  signal simple_obj_ref_48_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_48_gather_scatter_ack_0 : boolean;
  signal memory_space_1_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_1_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_1_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_1_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_1_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_1_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_1_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_1_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_1_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_1_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_1_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_1_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_1_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_1_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_1_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_2_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_2_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_2_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_2_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_2_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_2_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_2_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_2_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_3_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_3_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_3_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_3_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_3_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_3_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_3_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_3_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_3_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_3_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_3_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_3_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_3_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_3_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_3_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_3_sc_tag :  std_logic_vector(0 downto 0);
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
  sub_slave_CP_0: Block -- control-path 
    signal sub_slave_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_8_3_symbol : Boolean;
    -- 
  begin -- 
    sub_slave_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= sub_slave_CP_0_start; -- transition $entry
    branch_block_stmt_8_3: Block -- branch_block_stmt_8 
      signal branch_block_stmt_8_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_8_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_8_x_xexit_x_xx_x7_symbol : Boolean;
      signal assign_stmt_13_to_assign_stmt_44_x_xentry_x_xx_x8_symbol : Boolean;
      signal assign_stmt_13_to_assign_stmt_44_x_xexit_x_xx_x9_symbol : Boolean;
      signal return_x_xx_x10_symbol : Boolean;
      signal merge_stmt_46_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_49_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_49_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_13_to_assign_stmt_44_14_symbol : Boolean;
      signal assign_stmt_49_227_symbol : Boolean;
      signal return_x_xx_xPhiReq_260_symbol : Boolean;
      signal merge_stmt_46_PhiReqMerge_263_symbol : Boolean;
      signal merge_stmt_46_PhiAck_264_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_8_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_8_3_start; -- transition branch_block_stmt_8/$entry
      branch_block_stmt_8_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_8/branch_block_stmt_8__entry__ (optimized away) 
      branch_block_stmt_8_x_xexit_x_xx_x7_symbol  <=  assign_stmt_49_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_8/branch_block_stmt_8__exit__ (optimized away) 
      assign_stmt_13_to_assign_stmt_44_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_8_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44__entry__ (optimized away) 
      assign_stmt_13_to_assign_stmt_44_x_xexit_x_xx_x9_symbol  <=  assign_stmt_13_to_assign_stmt_44_14_symbol; -- place branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44__exit__ (optimized away) 
      return_x_xx_x10_symbol  <=  assign_stmt_13_to_assign_stmt_44_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_8/return__ (optimized away) 
      merge_stmt_46_x_xexit_x_xx_x11_symbol  <=  merge_stmt_46_PhiAck_264_symbol; -- place branch_block_stmt_8/merge_stmt_46__exit__ (optimized away) 
      assign_stmt_49_x_xentry_x_xx_x12_symbol  <=  merge_stmt_46_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_8/assign_stmt_49__entry__ (optimized away) 
      assign_stmt_49_x_xexit_x_xx_x13_symbol  <=  assign_stmt_49_227_symbol; -- place branch_block_stmt_8/assign_stmt_49__exit__ (optimized away) 
      assign_stmt_13_to_assign_stmt_44_14: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44 
        signal assign_stmt_13_to_assign_stmt_44_14_start: Boolean;
        signal Xentry_15_symbol: Boolean;
        signal Xexit_16_symbol: Boolean;
        signal assign_stmt_13_active_x_x17_symbol : Boolean;
        signal assign_stmt_13_completed_x_x18_symbol : Boolean;
        signal simple_obj_ref_12_complete_19_symbol : Boolean;
        signal simple_obj_ref_11_trigger_x_x20_symbol : Boolean;
        signal simple_obj_ref_11_active_x_x21_symbol : Boolean;
        signal simple_obj_ref_11_root_address_calculated_22_symbol : Boolean;
        signal simple_obj_ref_11_word_address_calculated_23_symbol : Boolean;
        signal simple_obj_ref_11_request_24_symbol : Boolean;
        signal simple_obj_ref_11_complete_37_symbol : Boolean;
        signal assign_stmt_16_active_x_x48_symbol : Boolean;
        signal assign_stmt_16_completed_x_x49_symbol : Boolean;
        signal simple_obj_ref_15_complete_50_symbol : Boolean;
        signal simple_obj_ref_14_trigger_x_x51_symbol : Boolean;
        signal simple_obj_ref_14_active_x_x52_symbol : Boolean;
        signal simple_obj_ref_14_root_address_calculated_53_symbol : Boolean;
        signal simple_obj_ref_14_word_address_calculated_54_symbol : Boolean;
        signal simple_obj_ref_14_request_55_symbol : Boolean;
        signal simple_obj_ref_14_complete_68_symbol : Boolean;
        signal assign_stmt_25_active_x_x79_symbol : Boolean;
        signal assign_stmt_25_completed_x_x80_symbol : Boolean;
        signal ptr_deref_24_trigger_x_x81_symbol : Boolean;
        signal ptr_deref_24_active_x_x82_symbol : Boolean;
        signal ptr_deref_24_base_address_calculated_83_symbol : Boolean;
        signal ptr_deref_24_root_address_calculated_84_symbol : Boolean;
        signal ptr_deref_24_word_address_calculated_85_symbol : Boolean;
        signal ptr_deref_24_request_86_symbol : Boolean;
        signal ptr_deref_24_complete_97_symbol : Boolean;
        signal assign_stmt_28_active_x_x110_symbol : Boolean;
        signal assign_stmt_28_completed_x_x111_symbol : Boolean;
        signal simple_obj_ref_27_trigger_x_x112_symbol : Boolean;
        signal simple_obj_ref_27_active_x_x113_symbol : Boolean;
        signal simple_obj_ref_27_root_address_calculated_114_symbol : Boolean;
        signal simple_obj_ref_27_word_address_calculated_115_symbol : Boolean;
        signal simple_obj_ref_27_request_116_symbol : Boolean;
        signal simple_obj_ref_27_complete_127_symbol : Boolean;
        signal assign_stmt_33_active_x_x140_symbol : Boolean;
        signal assign_stmt_33_completed_x_x141_symbol : Boolean;
        signal binary_32_active_x_x142_symbol : Boolean;
        signal binary_32_trigger_x_x143_symbol : Boolean;
        signal simple_obj_ref_30_complete_144_symbol : Boolean;
        signal simple_obj_ref_31_complete_145_symbol : Boolean;
        signal binary_32_complete_146_symbol : Boolean;
        signal assign_stmt_36_active_x_x153_symbol : Boolean;
        signal assign_stmt_36_completed_x_x154_symbol : Boolean;
        signal simple_obj_ref_35_trigger_x_x155_symbol : Boolean;
        signal simple_obj_ref_35_active_x_x156_symbol : Boolean;
        signal simple_obj_ref_35_root_address_calculated_157_symbol : Boolean;
        signal simple_obj_ref_35_word_address_calculated_158_symbol : Boolean;
        signal simple_obj_ref_35_request_159_symbol : Boolean;
        signal simple_obj_ref_35_complete_170_symbol : Boolean;
        signal assign_stmt_41_active_x_x183_symbol : Boolean;
        signal assign_stmt_41_completed_x_x184_symbol : Boolean;
        signal binary_40_active_x_x185_symbol : Boolean;
        signal binary_40_trigger_x_x186_symbol : Boolean;
        signal simple_obj_ref_38_complete_187_symbol : Boolean;
        signal simple_obj_ref_39_complete_188_symbol : Boolean;
        signal binary_40_complete_189_symbol : Boolean;
        signal assign_stmt_44_active_x_x196_symbol : Boolean;
        signal assign_stmt_44_completed_x_x197_symbol : Boolean;
        signal simple_obj_ref_43_complete_198_symbol : Boolean;
        signal simple_obj_ref_42_trigger_x_x199_symbol : Boolean;
        signal simple_obj_ref_42_active_x_x200_symbol : Boolean;
        signal simple_obj_ref_42_root_address_calculated_201_symbol : Boolean;
        signal simple_obj_ref_42_word_address_calculated_202_symbol : Boolean;
        signal simple_obj_ref_42_request_203_symbol : Boolean;
        signal simple_obj_ref_42_complete_216_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_13_to_assign_stmt_44_14_start <= assign_stmt_13_to_assign_stmt_44_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_15_symbol  <= assign_stmt_13_to_assign_stmt_44_14_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/$entry
        assign_stmt_13_active_x_x17_symbol <= simple_obj_ref_12_complete_19_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_13_active_
        assign_stmt_13_completed_x_x18_symbol <= simple_obj_ref_11_complete_37_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_13_completed_
        simple_obj_ref_12_complete_19_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_12_complete
        simple_obj_ref_11_trigger_x_x20_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_trigger_ 
          signal simple_obj_ref_11_trigger_x_x20_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_11_trigger_x_x20_predecessors(0) <= simple_obj_ref_11_word_address_calculated_23_symbol;
          simple_obj_ref_11_trigger_x_x20_predecessors(1) <= assign_stmt_13_active_x_x17_symbol;
          simple_obj_ref_11_trigger_x_x20_join: join -- 
            port map( -- 
              preds => simple_obj_ref_11_trigger_x_x20_predecessors,
              symbol_out => simple_obj_ref_11_trigger_x_x20_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_trigger_
        simple_obj_ref_11_active_x_x21_symbol <= simple_obj_ref_11_request_24_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_active_
        simple_obj_ref_11_root_address_calculated_22_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_root_address_calculated
        simple_obj_ref_11_word_address_calculated_23_symbol <= simple_obj_ref_11_root_address_calculated_22_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_word_address_calculated
        simple_obj_ref_11_request_24: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request 
          signal simple_obj_ref_11_request_24_start: Boolean;
          signal Xentry_25_symbol: Boolean;
          signal Xexit_26_symbol: Boolean;
          signal split_req_27_symbol : Boolean;
          signal split_ack_28_symbol : Boolean;
          signal word_access_29_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_11_request_24_start <= simple_obj_ref_11_trigger_x_x20_symbol; -- control passed to block
          Xentry_25_symbol  <= simple_obj_ref_11_request_24_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/$entry
          split_req_27_symbol <= Xentry_25_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/split_req
          simple_obj_ref_11_gather_scatter_req_0 <= split_req_27_symbol; -- link to DP
          split_ack_28_symbol <= simple_obj_ref_11_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/split_ack
          word_access_29: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access 
            signal word_access_29_start: Boolean;
            signal Xentry_30_symbol: Boolean;
            signal Xexit_31_symbol: Boolean;
            signal word_access_0_32_symbol : Boolean;
            -- 
          begin -- 
            word_access_29_start <= split_ack_28_symbol; -- control passed to block
            Xentry_30_symbol  <= word_access_29_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/$entry
            word_access_0_32: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/word_access_0 
              signal word_access_0_32_start: Boolean;
              signal Xentry_33_symbol: Boolean;
              signal Xexit_34_symbol: Boolean;
              signal rr_35_symbol : Boolean;
              signal ra_36_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_32_start <= Xentry_30_symbol; -- control passed to block
              Xentry_33_symbol  <= word_access_0_32_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/word_access_0/$entry
              rr_35_symbol <= Xentry_33_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/word_access_0/rr
              simple_obj_ref_11_store_0_req_0 <= rr_35_symbol; -- link to DP
              ra_36_symbol <= simple_obj_ref_11_store_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/word_access_0/ra
              Xexit_34_symbol <= ra_36_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/word_access_0/$exit
              word_access_0_32_symbol <= Xexit_34_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/word_access_0
            Xexit_31_symbol <= word_access_0_32_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access/$exit
            word_access_29_symbol <= Xexit_31_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/word_access
          Xexit_26_symbol <= word_access_29_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request/$exit
          simple_obj_ref_11_request_24_symbol <= Xexit_26_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_request
        simple_obj_ref_11_complete_37: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete 
          signal simple_obj_ref_11_complete_37_start: Boolean;
          signal Xentry_38_symbol: Boolean;
          signal Xexit_39_symbol: Boolean;
          signal word_access_40_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_11_complete_37_start <= simple_obj_ref_11_active_x_x21_symbol; -- control passed to block
          Xentry_38_symbol  <= simple_obj_ref_11_complete_37_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/$entry
          word_access_40: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access 
            signal word_access_40_start: Boolean;
            signal Xentry_41_symbol: Boolean;
            signal Xexit_42_symbol: Boolean;
            signal word_access_0_43_symbol : Boolean;
            -- 
          begin -- 
            word_access_40_start <= Xentry_38_symbol; -- control passed to block
            Xentry_41_symbol  <= word_access_40_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/$entry
            word_access_0_43: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/word_access_0 
              signal word_access_0_43_start: Boolean;
              signal Xentry_44_symbol: Boolean;
              signal Xexit_45_symbol: Boolean;
              signal cr_46_symbol : Boolean;
              signal ca_47_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_43_start <= Xentry_41_symbol; -- control passed to block
              Xentry_44_symbol  <= word_access_0_43_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/word_access_0/$entry
              cr_46_symbol <= Xentry_44_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/word_access_0/cr
              simple_obj_ref_11_store_0_req_1 <= cr_46_symbol; -- link to DP
              ca_47_symbol <= simple_obj_ref_11_store_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/word_access_0/ca
              Xexit_45_symbol <= ca_47_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/word_access_0/$exit
              word_access_0_43_symbol <= Xexit_45_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/word_access_0
            Xexit_42_symbol <= word_access_0_43_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access/$exit
            word_access_40_symbol <= Xexit_42_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/word_access
          Xexit_39_symbol <= word_access_40_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete/$exit
          simple_obj_ref_11_complete_37_symbol <= Xexit_39_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_11_complete
        assign_stmt_16_active_x_x48_symbol <= simple_obj_ref_15_complete_50_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_16_active_
        assign_stmt_16_completed_x_x49_symbol <= simple_obj_ref_14_complete_68_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_16_completed_
        simple_obj_ref_15_complete_50_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_15_complete
        simple_obj_ref_14_trigger_x_x51_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_trigger_ 
          signal simple_obj_ref_14_trigger_x_x51_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_14_trigger_x_x51_predecessors(0) <= simple_obj_ref_14_word_address_calculated_54_symbol;
          simple_obj_ref_14_trigger_x_x51_predecessors(1) <= assign_stmt_16_active_x_x48_symbol;
          simple_obj_ref_14_trigger_x_x51_join: join -- 
            port map( -- 
              preds => simple_obj_ref_14_trigger_x_x51_predecessors,
              symbol_out => simple_obj_ref_14_trigger_x_x51_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_trigger_
        simple_obj_ref_14_active_x_x52_symbol <= simple_obj_ref_14_request_55_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_active_
        simple_obj_ref_14_root_address_calculated_53_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_root_address_calculated
        simple_obj_ref_14_word_address_calculated_54_symbol <= simple_obj_ref_14_root_address_calculated_53_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_word_address_calculated
        simple_obj_ref_14_request_55: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request 
          signal simple_obj_ref_14_request_55_start: Boolean;
          signal Xentry_56_symbol: Boolean;
          signal Xexit_57_symbol: Boolean;
          signal split_req_58_symbol : Boolean;
          signal split_ack_59_symbol : Boolean;
          signal word_access_60_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_14_request_55_start <= simple_obj_ref_14_trigger_x_x51_symbol; -- control passed to block
          Xentry_56_symbol  <= simple_obj_ref_14_request_55_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/$entry
          split_req_58_symbol <= Xentry_56_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/split_req
          simple_obj_ref_14_gather_scatter_req_0 <= split_req_58_symbol; -- link to DP
          split_ack_59_symbol <= simple_obj_ref_14_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/split_ack
          word_access_60: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access 
            signal word_access_60_start: Boolean;
            signal Xentry_61_symbol: Boolean;
            signal Xexit_62_symbol: Boolean;
            signal word_access_0_63_symbol : Boolean;
            -- 
          begin -- 
            word_access_60_start <= split_ack_59_symbol; -- control passed to block
            Xentry_61_symbol  <= word_access_60_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/$entry
            word_access_0_63: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/word_access_0 
              signal word_access_0_63_start: Boolean;
              signal Xentry_64_symbol: Boolean;
              signal Xexit_65_symbol: Boolean;
              signal rr_66_symbol : Boolean;
              signal ra_67_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_63_start <= Xentry_61_symbol; -- control passed to block
              Xentry_64_symbol  <= word_access_0_63_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/word_access_0/$entry
              rr_66_symbol <= Xentry_64_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/word_access_0/rr
              simple_obj_ref_14_store_0_req_0 <= rr_66_symbol; -- link to DP
              ra_67_symbol <= simple_obj_ref_14_store_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/word_access_0/ra
              Xexit_65_symbol <= ra_67_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/word_access_0/$exit
              word_access_0_63_symbol <= Xexit_65_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/word_access_0
            Xexit_62_symbol <= word_access_0_63_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access/$exit
            word_access_60_symbol <= Xexit_62_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/word_access
          Xexit_57_symbol <= word_access_60_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request/$exit
          simple_obj_ref_14_request_55_symbol <= Xexit_57_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_request
        simple_obj_ref_14_complete_68: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete 
          signal simple_obj_ref_14_complete_68_start: Boolean;
          signal Xentry_69_symbol: Boolean;
          signal Xexit_70_symbol: Boolean;
          signal word_access_71_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_14_complete_68_start <= simple_obj_ref_14_active_x_x52_symbol; -- control passed to block
          Xentry_69_symbol  <= simple_obj_ref_14_complete_68_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/$entry
          word_access_71: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access 
            signal word_access_71_start: Boolean;
            signal Xentry_72_symbol: Boolean;
            signal Xexit_73_symbol: Boolean;
            signal word_access_0_74_symbol : Boolean;
            -- 
          begin -- 
            word_access_71_start <= Xentry_69_symbol; -- control passed to block
            Xentry_72_symbol  <= word_access_71_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/$entry
            word_access_0_74: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/word_access_0 
              signal word_access_0_74_start: Boolean;
              signal Xentry_75_symbol: Boolean;
              signal Xexit_76_symbol: Boolean;
              signal cr_77_symbol : Boolean;
              signal ca_78_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_74_start <= Xentry_72_symbol; -- control passed to block
              Xentry_75_symbol  <= word_access_0_74_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/word_access_0/$entry
              cr_77_symbol <= Xentry_75_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/word_access_0/cr
              simple_obj_ref_14_store_0_req_1 <= cr_77_symbol; -- link to DP
              ca_78_symbol <= simple_obj_ref_14_store_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/word_access_0/ca
              Xexit_76_symbol <= ca_78_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/word_access_0/$exit
              word_access_0_74_symbol <= Xexit_76_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/word_access_0
            Xexit_73_symbol <= word_access_0_74_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access/$exit
            word_access_71_symbol <= Xexit_73_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/word_access
          Xexit_70_symbol <= word_access_71_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete/$exit
          simple_obj_ref_14_complete_68_symbol <= Xexit_70_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_14_complete
        assign_stmt_25_active_x_x79_symbol <= ptr_deref_24_complete_97_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_25_active_
        assign_stmt_25_completed_x_x80_symbol <= assign_stmt_25_active_x_x79_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_25_completed_
        ptr_deref_24_trigger_x_x81_symbol <= ptr_deref_24_word_address_calculated_85_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_trigger_
        ptr_deref_24_active_x_x82_symbol <= ptr_deref_24_request_86_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_active_
        ptr_deref_24_base_address_calculated_83_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_base_address_calculated
        ptr_deref_24_root_address_calculated_84_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_root_address_calculated
        ptr_deref_24_word_address_calculated_85_symbol <= ptr_deref_24_root_address_calculated_84_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_word_address_calculated
        ptr_deref_24_request_86: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request 
          signal ptr_deref_24_request_86_start: Boolean;
          signal Xentry_87_symbol: Boolean;
          signal Xexit_88_symbol: Boolean;
          signal word_access_89_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_24_request_86_start <= ptr_deref_24_trigger_x_x81_symbol; -- control passed to block
          Xentry_87_symbol  <= ptr_deref_24_request_86_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/$entry
          word_access_89: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access 
            signal word_access_89_start: Boolean;
            signal Xentry_90_symbol: Boolean;
            signal Xexit_91_symbol: Boolean;
            signal word_access_0_92_symbol : Boolean;
            -- 
          begin -- 
            word_access_89_start <= Xentry_87_symbol; -- control passed to block
            Xentry_90_symbol  <= word_access_89_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/$entry
            word_access_0_92: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/word_access_0 
              signal word_access_0_92_start: Boolean;
              signal Xentry_93_symbol: Boolean;
              signal Xexit_94_symbol: Boolean;
              signal rr_95_symbol : Boolean;
              signal ra_96_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_92_start <= Xentry_90_symbol; -- control passed to block
              Xentry_93_symbol  <= word_access_0_92_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/word_access_0/$entry
              rr_95_symbol <= Xentry_93_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/word_access_0/rr
              ptr_deref_24_load_0_req_0 <= rr_95_symbol; -- link to DP
              ra_96_symbol <= ptr_deref_24_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/word_access_0/ra
              Xexit_94_symbol <= ra_96_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/word_access_0/$exit
              word_access_0_92_symbol <= Xexit_94_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/word_access_0
            Xexit_91_symbol <= word_access_0_92_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access/$exit
            word_access_89_symbol <= Xexit_91_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/word_access
          Xexit_88_symbol <= word_access_89_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request/$exit
          ptr_deref_24_request_86_symbol <= Xexit_88_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_request
        ptr_deref_24_complete_97: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete 
          signal ptr_deref_24_complete_97_start: Boolean;
          signal Xentry_98_symbol: Boolean;
          signal Xexit_99_symbol: Boolean;
          signal word_access_100_symbol : Boolean;
          signal merge_req_108_symbol : Boolean;
          signal merge_ack_109_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_24_complete_97_start <= ptr_deref_24_active_x_x82_symbol; -- control passed to block
          Xentry_98_symbol  <= ptr_deref_24_complete_97_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/$entry
          word_access_100: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access 
            signal word_access_100_start: Boolean;
            signal Xentry_101_symbol: Boolean;
            signal Xexit_102_symbol: Boolean;
            signal word_access_0_103_symbol : Boolean;
            -- 
          begin -- 
            word_access_100_start <= Xentry_98_symbol; -- control passed to block
            Xentry_101_symbol  <= word_access_100_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/$entry
            word_access_0_103: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/word_access_0 
              signal word_access_0_103_start: Boolean;
              signal Xentry_104_symbol: Boolean;
              signal Xexit_105_symbol: Boolean;
              signal cr_106_symbol : Boolean;
              signal ca_107_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_103_start <= Xentry_101_symbol; -- control passed to block
              Xentry_104_symbol  <= word_access_0_103_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/word_access_0/$entry
              cr_106_symbol <= Xentry_104_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/word_access_0/cr
              ptr_deref_24_load_0_req_1 <= cr_106_symbol; -- link to DP
              ca_107_symbol <= ptr_deref_24_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/word_access_0/ca
              Xexit_105_symbol <= ca_107_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/word_access_0/$exit
              word_access_0_103_symbol <= Xexit_105_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/word_access_0
            Xexit_102_symbol <= word_access_0_103_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access/$exit
            word_access_100_symbol <= Xexit_102_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/word_access
          merge_req_108_symbol <= word_access_100_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/merge_req
          ptr_deref_24_gather_scatter_req_0 <= merge_req_108_symbol; -- link to DP
          merge_ack_109_symbol <= ptr_deref_24_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/merge_ack
          Xexit_99_symbol <= merge_ack_109_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete/$exit
          ptr_deref_24_complete_97_symbol <= Xexit_99_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/ptr_deref_24_complete
        assign_stmt_28_active_x_x110_symbol <= simple_obj_ref_27_complete_127_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_28_active_
        assign_stmt_28_completed_x_x111_symbol <= assign_stmt_28_active_x_x110_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_28_completed_
        simple_obj_ref_27_trigger_x_x112_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_trigger_ 
          signal simple_obj_ref_27_trigger_x_x112_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_27_trigger_x_x112_predecessors(0) <= simple_obj_ref_27_word_address_calculated_115_symbol;
          simple_obj_ref_27_trigger_x_x112_predecessors(1) <= simple_obj_ref_11_active_x_x21_symbol;
          simple_obj_ref_27_trigger_x_x112_join: join -- 
            port map( -- 
              preds => simple_obj_ref_27_trigger_x_x112_predecessors,
              symbol_out => simple_obj_ref_27_trigger_x_x112_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_trigger_
        simple_obj_ref_27_active_x_x113_symbol <= simple_obj_ref_27_request_116_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_active_
        simple_obj_ref_27_root_address_calculated_114_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_root_address_calculated
        simple_obj_ref_27_word_address_calculated_115_symbol <= simple_obj_ref_27_root_address_calculated_114_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_word_address_calculated
        simple_obj_ref_27_request_116: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request 
          signal simple_obj_ref_27_request_116_start: Boolean;
          signal Xentry_117_symbol: Boolean;
          signal Xexit_118_symbol: Boolean;
          signal word_access_119_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_27_request_116_start <= simple_obj_ref_27_trigger_x_x112_symbol; -- control passed to block
          Xentry_117_symbol  <= simple_obj_ref_27_request_116_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/$entry
          word_access_119: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access 
            signal word_access_119_start: Boolean;
            signal Xentry_120_symbol: Boolean;
            signal Xexit_121_symbol: Boolean;
            signal word_access_0_122_symbol : Boolean;
            -- 
          begin -- 
            word_access_119_start <= Xentry_117_symbol; -- control passed to block
            Xentry_120_symbol  <= word_access_119_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/$entry
            word_access_0_122: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/word_access_0 
              signal word_access_0_122_start: Boolean;
              signal Xentry_123_symbol: Boolean;
              signal Xexit_124_symbol: Boolean;
              signal rr_125_symbol : Boolean;
              signal ra_126_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_122_start <= Xentry_120_symbol; -- control passed to block
              Xentry_123_symbol  <= word_access_0_122_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/word_access_0/$entry
              rr_125_symbol <= Xentry_123_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/word_access_0/rr
              simple_obj_ref_27_load_0_req_0 <= rr_125_symbol; -- link to DP
              ra_126_symbol <= simple_obj_ref_27_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/word_access_0/ra
              Xexit_124_symbol <= ra_126_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/word_access_0/$exit
              word_access_0_122_symbol <= Xexit_124_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/word_access_0
            Xexit_121_symbol <= word_access_0_122_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access/$exit
            word_access_119_symbol <= Xexit_121_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/word_access
          Xexit_118_symbol <= word_access_119_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request/$exit
          simple_obj_ref_27_request_116_symbol <= Xexit_118_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_request
        simple_obj_ref_27_complete_127: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete 
          signal simple_obj_ref_27_complete_127_start: Boolean;
          signal Xentry_128_symbol: Boolean;
          signal Xexit_129_symbol: Boolean;
          signal word_access_130_symbol : Boolean;
          signal merge_req_138_symbol : Boolean;
          signal merge_ack_139_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_27_complete_127_start <= simple_obj_ref_27_active_x_x113_symbol; -- control passed to block
          Xentry_128_symbol  <= simple_obj_ref_27_complete_127_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/$entry
          word_access_130: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access 
            signal word_access_130_start: Boolean;
            signal Xentry_131_symbol: Boolean;
            signal Xexit_132_symbol: Boolean;
            signal word_access_0_133_symbol : Boolean;
            -- 
          begin -- 
            word_access_130_start <= Xentry_128_symbol; -- control passed to block
            Xentry_131_symbol  <= word_access_130_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/$entry
            word_access_0_133: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/word_access_0 
              signal word_access_0_133_start: Boolean;
              signal Xentry_134_symbol: Boolean;
              signal Xexit_135_symbol: Boolean;
              signal cr_136_symbol : Boolean;
              signal ca_137_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_133_start <= Xentry_131_symbol; -- control passed to block
              Xentry_134_symbol  <= word_access_0_133_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/word_access_0/$entry
              cr_136_symbol <= Xentry_134_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/word_access_0/cr
              simple_obj_ref_27_load_0_req_1 <= cr_136_symbol; -- link to DP
              ca_137_symbol <= simple_obj_ref_27_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/word_access_0/ca
              Xexit_135_symbol <= ca_137_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/word_access_0/$exit
              word_access_0_133_symbol <= Xexit_135_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/word_access_0
            Xexit_132_symbol <= word_access_0_133_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access/$exit
            word_access_130_symbol <= Xexit_132_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/word_access
          merge_req_138_symbol <= word_access_130_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/merge_req
          simple_obj_ref_27_gather_scatter_req_0 <= merge_req_138_symbol; -- link to DP
          merge_ack_139_symbol <= simple_obj_ref_27_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/merge_ack
          Xexit_129_symbol <= merge_ack_139_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete/$exit
          simple_obj_ref_27_complete_127_symbol <= Xexit_129_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_27_complete
        assign_stmt_33_active_x_x140_symbol <= binary_32_complete_146_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_33_active_
        assign_stmt_33_completed_x_x141_symbol <= assign_stmt_33_active_x_x140_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_33_completed_
        binary_32_active_x_x142_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_active_ 
          signal binary_32_active_x_x142_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_32_active_x_x142_predecessors(0) <= binary_32_trigger_x_x143_symbol;
          binary_32_active_x_x142_predecessors(1) <= simple_obj_ref_30_complete_144_symbol;
          binary_32_active_x_x142_predecessors(2) <= simple_obj_ref_31_complete_145_symbol;
          binary_32_active_x_x142_join: join -- 
            port map( -- 
              preds => binary_32_active_x_x142_predecessors,
              symbol_out => binary_32_active_x_x142_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_active_
        binary_32_trigger_x_x143_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_trigger_
        simple_obj_ref_30_complete_144_symbol <= assign_stmt_25_completed_x_x80_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_30_complete
        simple_obj_ref_31_complete_145_symbol <= assign_stmt_28_completed_x_x111_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_31_complete
        binary_32_complete_146: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete 
          signal binary_32_complete_146_start: Boolean;
          signal Xentry_147_symbol: Boolean;
          signal Xexit_148_symbol: Boolean;
          signal rr_149_symbol : Boolean;
          signal ra_150_symbol : Boolean;
          signal cr_151_symbol : Boolean;
          signal ca_152_symbol : Boolean;
          -- 
        begin -- 
          binary_32_complete_146_start <= binary_32_active_x_x142_symbol; -- control passed to block
          Xentry_147_symbol  <= binary_32_complete_146_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete/$entry
          rr_149_symbol <= Xentry_147_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete/rr
          binary_32_inst_req_0 <= rr_149_symbol; -- link to DP
          ra_150_symbol <= binary_32_inst_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete/ra
          cr_151_symbol <= ra_150_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete/cr
          binary_32_inst_req_1 <= cr_151_symbol; -- link to DP
          ca_152_symbol <= binary_32_inst_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete/ca
          Xexit_148_symbol <= ca_152_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete/$exit
          binary_32_complete_146_symbol <= Xexit_148_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_32_complete
        assign_stmt_36_active_x_x153_symbol <= simple_obj_ref_35_complete_170_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_36_active_
        assign_stmt_36_completed_x_x154_symbol <= assign_stmt_36_active_x_x153_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_36_completed_
        simple_obj_ref_35_trigger_x_x155_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_trigger_ 
          signal simple_obj_ref_35_trigger_x_x155_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_35_trigger_x_x155_predecessors(0) <= simple_obj_ref_35_word_address_calculated_158_symbol;
          simple_obj_ref_35_trigger_x_x155_predecessors(1) <= simple_obj_ref_14_active_x_x52_symbol;
          simple_obj_ref_35_trigger_x_x155_join: join -- 
            port map( -- 
              preds => simple_obj_ref_35_trigger_x_x155_predecessors,
              symbol_out => simple_obj_ref_35_trigger_x_x155_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_trigger_
        simple_obj_ref_35_active_x_x156_symbol <= simple_obj_ref_35_request_159_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_active_
        simple_obj_ref_35_root_address_calculated_157_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_root_address_calculated
        simple_obj_ref_35_word_address_calculated_158_symbol <= simple_obj_ref_35_root_address_calculated_157_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_word_address_calculated
        simple_obj_ref_35_request_159: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request 
          signal simple_obj_ref_35_request_159_start: Boolean;
          signal Xentry_160_symbol: Boolean;
          signal Xexit_161_symbol: Boolean;
          signal word_access_162_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_35_request_159_start <= simple_obj_ref_35_trigger_x_x155_symbol; -- control passed to block
          Xentry_160_symbol  <= simple_obj_ref_35_request_159_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/$entry
          word_access_162: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access 
            signal word_access_162_start: Boolean;
            signal Xentry_163_symbol: Boolean;
            signal Xexit_164_symbol: Boolean;
            signal word_access_0_165_symbol : Boolean;
            -- 
          begin -- 
            word_access_162_start <= Xentry_160_symbol; -- control passed to block
            Xentry_163_symbol  <= word_access_162_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/$entry
            word_access_0_165: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/word_access_0 
              signal word_access_0_165_start: Boolean;
              signal Xentry_166_symbol: Boolean;
              signal Xexit_167_symbol: Boolean;
              signal rr_168_symbol : Boolean;
              signal ra_169_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_165_start <= Xentry_163_symbol; -- control passed to block
              Xentry_166_symbol  <= word_access_0_165_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/word_access_0/$entry
              rr_168_symbol <= Xentry_166_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/word_access_0/rr
              simple_obj_ref_35_load_0_req_0 <= rr_168_symbol; -- link to DP
              ra_169_symbol <= simple_obj_ref_35_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/word_access_0/ra
              Xexit_167_symbol <= ra_169_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/word_access_0/$exit
              word_access_0_165_symbol <= Xexit_167_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/word_access_0
            Xexit_164_symbol <= word_access_0_165_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access/$exit
            word_access_162_symbol <= Xexit_164_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/word_access
          Xexit_161_symbol <= word_access_162_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request/$exit
          simple_obj_ref_35_request_159_symbol <= Xexit_161_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_request
        simple_obj_ref_35_complete_170: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete 
          signal simple_obj_ref_35_complete_170_start: Boolean;
          signal Xentry_171_symbol: Boolean;
          signal Xexit_172_symbol: Boolean;
          signal word_access_173_symbol : Boolean;
          signal merge_req_181_symbol : Boolean;
          signal merge_ack_182_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_35_complete_170_start <= simple_obj_ref_35_active_x_x156_symbol; -- control passed to block
          Xentry_171_symbol  <= simple_obj_ref_35_complete_170_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/$entry
          word_access_173: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access 
            signal word_access_173_start: Boolean;
            signal Xentry_174_symbol: Boolean;
            signal Xexit_175_symbol: Boolean;
            signal word_access_0_176_symbol : Boolean;
            -- 
          begin -- 
            word_access_173_start <= Xentry_171_symbol; -- control passed to block
            Xentry_174_symbol  <= word_access_173_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/$entry
            word_access_0_176: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/word_access_0 
              signal word_access_0_176_start: Boolean;
              signal Xentry_177_symbol: Boolean;
              signal Xexit_178_symbol: Boolean;
              signal cr_179_symbol : Boolean;
              signal ca_180_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_176_start <= Xentry_174_symbol; -- control passed to block
              Xentry_177_symbol  <= word_access_0_176_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/word_access_0/$entry
              cr_179_symbol <= Xentry_177_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/word_access_0/cr
              simple_obj_ref_35_load_0_req_1 <= cr_179_symbol; -- link to DP
              ca_180_symbol <= simple_obj_ref_35_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/word_access_0/ca
              Xexit_178_symbol <= ca_180_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/word_access_0/$exit
              word_access_0_176_symbol <= Xexit_178_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/word_access_0
            Xexit_175_symbol <= word_access_0_176_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access/$exit
            word_access_173_symbol <= Xexit_175_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/word_access
          merge_req_181_symbol <= word_access_173_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/merge_req
          simple_obj_ref_35_gather_scatter_req_0 <= merge_req_181_symbol; -- link to DP
          merge_ack_182_symbol <= simple_obj_ref_35_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/merge_ack
          Xexit_172_symbol <= merge_ack_182_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete/$exit
          simple_obj_ref_35_complete_170_symbol <= Xexit_172_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_35_complete
        assign_stmt_41_active_x_x183_symbol <= binary_40_complete_189_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_41_active_
        assign_stmt_41_completed_x_x184_symbol <= assign_stmt_41_active_x_x183_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_41_completed_
        binary_40_active_x_x185_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_active_ 
          signal binary_40_active_x_x185_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_40_active_x_x185_predecessors(0) <= binary_40_trigger_x_x186_symbol;
          binary_40_active_x_x185_predecessors(1) <= simple_obj_ref_38_complete_187_symbol;
          binary_40_active_x_x185_predecessors(2) <= simple_obj_ref_39_complete_188_symbol;
          binary_40_active_x_x185_join: join -- 
            port map( -- 
              preds => binary_40_active_x_x185_predecessors,
              symbol_out => binary_40_active_x_x185_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_active_
        binary_40_trigger_x_x186_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_trigger_
        simple_obj_ref_38_complete_187_symbol <= assign_stmt_33_completed_x_x141_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_38_complete
        simple_obj_ref_39_complete_188_symbol <= assign_stmt_36_completed_x_x154_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_39_complete
        binary_40_complete_189: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete 
          signal binary_40_complete_189_start: Boolean;
          signal Xentry_190_symbol: Boolean;
          signal Xexit_191_symbol: Boolean;
          signal rr_192_symbol : Boolean;
          signal ra_193_symbol : Boolean;
          signal cr_194_symbol : Boolean;
          signal ca_195_symbol : Boolean;
          -- 
        begin -- 
          binary_40_complete_189_start <= binary_40_active_x_x185_symbol; -- control passed to block
          Xentry_190_symbol  <= binary_40_complete_189_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete/$entry
          rr_192_symbol <= Xentry_190_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete/rr
          binary_40_inst_req_0 <= rr_192_symbol; -- link to DP
          ra_193_symbol <= binary_40_inst_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete/ra
          cr_194_symbol <= ra_193_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete/cr
          binary_40_inst_req_1 <= cr_194_symbol; -- link to DP
          ca_195_symbol <= binary_40_inst_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete/ca
          Xexit_191_symbol <= ca_195_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete/$exit
          binary_40_complete_189_symbol <= Xexit_191_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/binary_40_complete
        assign_stmt_44_active_x_x196_symbol <= simple_obj_ref_43_complete_198_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_44_active_
        assign_stmt_44_completed_x_x197_symbol <= simple_obj_ref_42_complete_216_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/assign_stmt_44_completed_
        simple_obj_ref_43_complete_198_symbol <= assign_stmt_41_completed_x_x184_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_43_complete
        simple_obj_ref_42_trigger_x_x199_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_trigger_ 
          signal simple_obj_ref_42_trigger_x_x199_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_42_trigger_x_x199_predecessors(0) <= simple_obj_ref_42_word_address_calculated_202_symbol;
          simple_obj_ref_42_trigger_x_x199_predecessors(1) <= assign_stmt_44_active_x_x196_symbol;
          simple_obj_ref_42_trigger_x_x199_join: join -- 
            port map( -- 
              preds => simple_obj_ref_42_trigger_x_x199_predecessors,
              symbol_out => simple_obj_ref_42_trigger_x_x199_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_trigger_
        simple_obj_ref_42_active_x_x200_symbol <= simple_obj_ref_42_request_203_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_active_
        simple_obj_ref_42_root_address_calculated_201_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_root_address_calculated
        simple_obj_ref_42_word_address_calculated_202_symbol <= simple_obj_ref_42_root_address_calculated_201_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_word_address_calculated
        simple_obj_ref_42_request_203: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request 
          signal simple_obj_ref_42_request_203_start: Boolean;
          signal Xentry_204_symbol: Boolean;
          signal Xexit_205_symbol: Boolean;
          signal split_req_206_symbol : Boolean;
          signal split_ack_207_symbol : Boolean;
          signal word_access_208_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_42_request_203_start <= simple_obj_ref_42_trigger_x_x199_symbol; -- control passed to block
          Xentry_204_symbol  <= simple_obj_ref_42_request_203_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/$entry
          split_req_206_symbol <= Xentry_204_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/split_req
          simple_obj_ref_42_gather_scatter_req_0 <= split_req_206_symbol; -- link to DP
          split_ack_207_symbol <= simple_obj_ref_42_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/split_ack
          word_access_208: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access 
            signal word_access_208_start: Boolean;
            signal Xentry_209_symbol: Boolean;
            signal Xexit_210_symbol: Boolean;
            signal word_access_0_211_symbol : Boolean;
            -- 
          begin -- 
            word_access_208_start <= split_ack_207_symbol; -- control passed to block
            Xentry_209_symbol  <= word_access_208_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/$entry
            word_access_0_211: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/word_access_0 
              signal word_access_0_211_start: Boolean;
              signal Xentry_212_symbol: Boolean;
              signal Xexit_213_symbol: Boolean;
              signal rr_214_symbol : Boolean;
              signal ra_215_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_211_start <= Xentry_209_symbol; -- control passed to block
              Xentry_212_symbol  <= word_access_0_211_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/word_access_0/$entry
              rr_214_symbol <= Xentry_212_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/word_access_0/rr
              simple_obj_ref_42_store_0_req_0 <= rr_214_symbol; -- link to DP
              ra_215_symbol <= simple_obj_ref_42_store_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/word_access_0/ra
              Xexit_213_symbol <= ra_215_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/word_access_0/$exit
              word_access_0_211_symbol <= Xexit_213_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/word_access_0
            Xexit_210_symbol <= word_access_0_211_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access/$exit
            word_access_208_symbol <= Xexit_210_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/word_access
          Xexit_205_symbol <= word_access_208_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request/$exit
          simple_obj_ref_42_request_203_symbol <= Xexit_205_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_request
        simple_obj_ref_42_complete_216: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete 
          signal simple_obj_ref_42_complete_216_start: Boolean;
          signal Xentry_217_symbol: Boolean;
          signal Xexit_218_symbol: Boolean;
          signal word_access_219_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_42_complete_216_start <= simple_obj_ref_42_active_x_x200_symbol; -- control passed to block
          Xentry_217_symbol  <= simple_obj_ref_42_complete_216_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/$entry
          word_access_219: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access 
            signal word_access_219_start: Boolean;
            signal Xentry_220_symbol: Boolean;
            signal Xexit_221_symbol: Boolean;
            signal word_access_0_222_symbol : Boolean;
            -- 
          begin -- 
            word_access_219_start <= Xentry_217_symbol; -- control passed to block
            Xentry_220_symbol  <= word_access_219_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/$entry
            word_access_0_222: Block -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/word_access_0 
              signal word_access_0_222_start: Boolean;
              signal Xentry_223_symbol: Boolean;
              signal Xexit_224_symbol: Boolean;
              signal cr_225_symbol : Boolean;
              signal ca_226_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_222_start <= Xentry_220_symbol; -- control passed to block
              Xentry_223_symbol  <= word_access_0_222_start; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/word_access_0/$entry
              cr_225_symbol <= Xentry_223_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/word_access_0/cr
              simple_obj_ref_42_store_0_req_1 <= cr_225_symbol; -- link to DP
              ca_226_symbol <= simple_obj_ref_42_store_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/word_access_0/ca
              Xexit_224_symbol <= ca_226_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/word_access_0/$exit
              word_access_0_222_symbol <= Xexit_224_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/word_access_0
            Xexit_221_symbol <= word_access_0_222_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access/$exit
            word_access_219_symbol <= Xexit_221_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/word_access
          Xexit_218_symbol <= word_access_219_symbol; -- transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete/$exit
          simple_obj_ref_42_complete_216_symbol <= Xexit_218_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/simple_obj_ref_42_complete
        Xexit_16_block : Block -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/$exit 
          signal Xexit_16_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          Xexit_16_predecessors(0) <= assign_stmt_13_completed_x_x18_symbol;
          Xexit_16_predecessors(1) <= assign_stmt_16_completed_x_x49_symbol;
          Xexit_16_predecessors(2) <= ptr_deref_24_base_address_calculated_83_symbol;
          Xexit_16_predecessors(3) <= assign_stmt_44_completed_x_x197_symbol;
          Xexit_16_join: join -- 
            port map( -- 
              preds => Xexit_16_predecessors,
              symbol_out => Xexit_16_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44/$exit
        assign_stmt_13_to_assign_stmt_44_14_symbol <= Xexit_16_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_13_to_assign_stmt_44
      assign_stmt_49_227: Block -- branch_block_stmt_8/assign_stmt_49 
        signal assign_stmt_49_227_start: Boolean;
        signal Xentry_228_symbol: Boolean;
        signal Xexit_229_symbol: Boolean;
        signal assign_stmt_49_active_x_x230_symbol : Boolean;
        signal assign_stmt_49_completed_x_x231_symbol : Boolean;
        signal simple_obj_ref_48_trigger_x_x232_symbol : Boolean;
        signal simple_obj_ref_48_active_x_x233_symbol : Boolean;
        signal simple_obj_ref_48_root_address_calculated_234_symbol : Boolean;
        signal simple_obj_ref_48_word_address_calculated_235_symbol : Boolean;
        signal simple_obj_ref_48_request_236_symbol : Boolean;
        signal simple_obj_ref_48_complete_247_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_49_227_start <= assign_stmt_49_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_228_symbol  <= assign_stmt_49_227_start; -- transition branch_block_stmt_8/assign_stmt_49/$entry
        assign_stmt_49_active_x_x230_symbol <= simple_obj_ref_48_complete_247_symbol; -- transition branch_block_stmt_8/assign_stmt_49/assign_stmt_49_active_
        assign_stmt_49_completed_x_x231_symbol <= assign_stmt_49_active_x_x230_symbol; -- transition branch_block_stmt_8/assign_stmt_49/assign_stmt_49_completed_
        simple_obj_ref_48_trigger_x_x232_symbol <= simple_obj_ref_48_word_address_calculated_235_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_trigger_
        simple_obj_ref_48_active_x_x233_symbol <= simple_obj_ref_48_request_236_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_active_
        simple_obj_ref_48_root_address_calculated_234_symbol <= Xentry_228_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_root_address_calculated
        simple_obj_ref_48_word_address_calculated_235_symbol <= simple_obj_ref_48_root_address_calculated_234_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_word_address_calculated
        simple_obj_ref_48_request_236: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request 
          signal simple_obj_ref_48_request_236_start: Boolean;
          signal Xentry_237_symbol: Boolean;
          signal Xexit_238_symbol: Boolean;
          signal word_access_239_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_48_request_236_start <= simple_obj_ref_48_trigger_x_x232_symbol; -- control passed to block
          Xentry_237_symbol  <= simple_obj_ref_48_request_236_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/$entry
          word_access_239: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access 
            signal word_access_239_start: Boolean;
            signal Xentry_240_symbol: Boolean;
            signal Xexit_241_symbol: Boolean;
            signal word_access_0_242_symbol : Boolean;
            -- 
          begin -- 
            word_access_239_start <= Xentry_237_symbol; -- control passed to block
            Xentry_240_symbol  <= word_access_239_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/$entry
            word_access_0_242: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/word_access_0 
              signal word_access_0_242_start: Boolean;
              signal Xentry_243_symbol: Boolean;
              signal Xexit_244_symbol: Boolean;
              signal rr_245_symbol : Boolean;
              signal ra_246_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_242_start <= Xentry_240_symbol; -- control passed to block
              Xentry_243_symbol  <= word_access_0_242_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/word_access_0/$entry
              rr_245_symbol <= Xentry_243_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/word_access_0/rr
              simple_obj_ref_48_load_0_req_0 <= rr_245_symbol; -- link to DP
              ra_246_symbol <= simple_obj_ref_48_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/word_access_0/ra
              Xexit_244_symbol <= ra_246_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/word_access_0/$exit
              word_access_0_242_symbol <= Xexit_244_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/word_access_0
            Xexit_241_symbol <= word_access_0_242_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access/$exit
            word_access_239_symbol <= Xexit_241_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/word_access
          Xexit_238_symbol <= word_access_239_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request/$exit
          simple_obj_ref_48_request_236_symbol <= Xexit_238_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_request
        simple_obj_ref_48_complete_247: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete 
          signal simple_obj_ref_48_complete_247_start: Boolean;
          signal Xentry_248_symbol: Boolean;
          signal Xexit_249_symbol: Boolean;
          signal word_access_250_symbol : Boolean;
          signal merge_req_258_symbol : Boolean;
          signal merge_ack_259_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_48_complete_247_start <= simple_obj_ref_48_active_x_x233_symbol; -- control passed to block
          Xentry_248_symbol  <= simple_obj_ref_48_complete_247_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/$entry
          word_access_250: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access 
            signal word_access_250_start: Boolean;
            signal Xentry_251_symbol: Boolean;
            signal Xexit_252_symbol: Boolean;
            signal word_access_0_253_symbol : Boolean;
            -- 
          begin -- 
            word_access_250_start <= Xentry_248_symbol; -- control passed to block
            Xentry_251_symbol  <= word_access_250_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/$entry
            word_access_0_253: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/word_access_0 
              signal word_access_0_253_start: Boolean;
              signal Xentry_254_symbol: Boolean;
              signal Xexit_255_symbol: Boolean;
              signal cr_256_symbol : Boolean;
              signal ca_257_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_253_start <= Xentry_251_symbol; -- control passed to block
              Xentry_254_symbol  <= word_access_0_253_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/word_access_0/$entry
              cr_256_symbol <= Xentry_254_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/word_access_0/cr
              simple_obj_ref_48_load_0_req_1 <= cr_256_symbol; -- link to DP
              ca_257_symbol <= simple_obj_ref_48_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/word_access_0/ca
              Xexit_255_symbol <= ca_257_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/word_access_0/$exit
              word_access_0_253_symbol <= Xexit_255_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/word_access_0
            Xexit_252_symbol <= word_access_0_253_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access/$exit
            word_access_250_symbol <= Xexit_252_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/word_access
          merge_req_258_symbol <= word_access_250_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/merge_req
          simple_obj_ref_48_gather_scatter_req_0 <= merge_req_258_symbol; -- link to DP
          merge_ack_259_symbol <= simple_obj_ref_48_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/merge_ack
          Xexit_249_symbol <= merge_ack_259_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete/$exit
          simple_obj_ref_48_complete_247_symbol <= Xexit_249_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48_complete
        Xexit_229_symbol <= assign_stmt_49_completed_x_x231_symbol; -- transition branch_block_stmt_8/assign_stmt_49/$exit
        assign_stmt_49_227_symbol <= Xexit_229_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_49
      return_x_xx_xPhiReq_260: Block -- branch_block_stmt_8/return___PhiReq 
        signal return_x_xx_xPhiReq_260_start: Boolean;
        signal Xentry_261_symbol: Boolean;
        signal Xexit_262_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_260_start <= return_x_xx_x10_symbol; -- control passed to block
        Xentry_261_symbol  <= return_x_xx_xPhiReq_260_start; -- transition branch_block_stmt_8/return___PhiReq/$entry
        Xexit_262_symbol <= Xentry_261_symbol; -- transition branch_block_stmt_8/return___PhiReq/$exit
        return_x_xx_xPhiReq_260_symbol <= Xexit_262_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/return___PhiReq
      merge_stmt_46_PhiReqMerge_263_symbol  <=  return_x_xx_xPhiReq_260_symbol; -- place branch_block_stmt_8/merge_stmt_46_PhiReqMerge (optimized away) 
      merge_stmt_46_PhiAck_264: Block -- branch_block_stmt_8/merge_stmt_46_PhiAck 
        signal merge_stmt_46_PhiAck_264_start: Boolean;
        signal Xentry_265_symbol: Boolean;
        signal Xexit_266_symbol: Boolean;
        signal dummy_267_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_46_PhiAck_264_start <= merge_stmt_46_PhiReqMerge_263_symbol; -- control passed to block
        Xentry_265_symbol  <= merge_stmt_46_PhiAck_264_start; -- transition branch_block_stmt_8/merge_stmt_46_PhiAck/$entry
        dummy_267_symbol <= Xentry_265_symbol; -- transition branch_block_stmt_8/merge_stmt_46_PhiAck/dummy
        Xexit_266_symbol <= dummy_267_symbol; -- transition branch_block_stmt_8/merge_stmt_46_PhiAck/$exit
        merge_stmt_46_PhiAck_264_symbol <= Xexit_266_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/merge_stmt_46_PhiAck
      Xexit_5_symbol <= branch_block_stmt_8_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_8/$exit
      branch_block_stmt_8_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_8
    Xexit_2_symbol <= branch_block_stmt_8_3_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal iNsTr_4_21 : std_logic_vector(31 downto 0);
    signal iNsTr_5_25 : std_logic_vector(31 downto 0);
    signal iNsTr_6_28 : std_logic_vector(31 downto 0);
    signal iNsTr_7_33 : std_logic_vector(31 downto 0);
    signal iNsTr_8_36 : std_logic_vector(31 downto 0);
    signal iNsTr_9_41 : std_logic_vector(31 downto 0);
    signal ptr_deref_24_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_24_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_11_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_11_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_14_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_14_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_27_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_27_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_35_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_35_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_42_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_42_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_48_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_48_word_address_0 : std_logic_vector(0 downto 0);
    signal xxsub_slavexxbodyxxiNsTr_0_base_address : std_logic_vector(0 downto 0);
    signal xxsub_slavexxbodyxxiNsTr_1_base_address : std_logic_vector(0 downto 0);
    signal xxsub_slavexxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    iNsTr_4_21 <= "00000000000000000000000000000000";
    ptr_deref_24_word_address_0 <= "0";
    simple_obj_ref_11_word_address_0 <= "0";
    simple_obj_ref_14_word_address_0 <= "0";
    simple_obj_ref_27_word_address_0 <= "0";
    simple_obj_ref_35_word_address_0 <= "0";
    simple_obj_ref_42_word_address_0 <= "0";
    simple_obj_ref_48_word_address_0 <= "0";
    xxsub_slavexxbodyxxiNsTr_0_base_address <= "0";
    xxsub_slavexxbodyxxiNsTr_1_base_address <= "0";
    xxsub_slavexxstored_ret_val_x_xx_xbase_address <= "0";
    ptr_deref_24_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_24_gather_scatter_ack_0 <= ptr_deref_24_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_24_data_0;
      iNsTr_5_25 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_11_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_11_gather_scatter_ack_0 <= simple_obj_ref_11_gather_scatter_req_0;
      aggregated_sig <= a;
      simple_obj_ref_11_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_14_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_14_gather_scatter_ack_0 <= simple_obj_ref_14_gather_scatter_req_0;
      aggregated_sig <= b;
      simple_obj_ref_14_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_27_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_27_gather_scatter_ack_0 <= simple_obj_ref_27_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_27_data_0;
      iNsTr_6_28 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_35_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_35_gather_scatter_ack_0 <= simple_obj_ref_35_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_35_data_0;
      iNsTr_8_36 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_42_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_42_gather_scatter_ack_0 <= simple_obj_ref_42_gather_scatter_req_0;
      aggregated_sig <= iNsTr_9_41;
      simple_obj_ref_42_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_48_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_48_gather_scatter_ack_0 <= simple_obj_ref_48_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_48_data_0;
      ret_val_x_x <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_32_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_25 & iNsTr_6_28;
      iNsTr_7_33 <= data_out(31 downto 0);
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
          reqL => binary_32_inst_req_0,
          ackL => binary_32_inst_ack_0,
          reqR => binary_32_inst_req_1,
          ackR => binary_32_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_40_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_7_33 & iNsTr_8_36;
      iNsTr_9_41 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntSub",
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
          reqL => binary_40_inst_req_0,
          ackL => binary_40_inst_ack_0,
          reqR => binary_40_inst_req_1,
          ackR => binary_40_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared load operator group (0) : ptr_deref_24_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_24_load_0_req_0;
      ptr_deref_24_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_24_load_0_req_1;
      ptr_deref_24_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_24_word_address_0;
      ptr_deref_24_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(0 downto 0),
          mtag => memory_space_0_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(31 downto 0),
          mtag => memory_space_0_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_27_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_27_load_0_req_0;
      simple_obj_ref_27_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_27_load_0_req_1;
      simple_obj_ref_27_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_27_word_address_0;
      simple_obj_ref_27_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_2_lr_req(0),
          mack => memory_space_2_lr_ack(0),
          maddr => memory_space_2_lr_addr(0 downto 0),
          mtag => memory_space_2_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_2_lc_req(0),
          mack => memory_space_2_lc_ack(0),
          mdata => memory_space_2_lc_data(31 downto 0),
          mtag => memory_space_2_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : simple_obj_ref_35_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_35_load_0_req_0;
      simple_obj_ref_35_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_35_load_0_req_1;
      simple_obj_ref_35_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_35_word_address_0;
      simple_obj_ref_35_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_3_lr_req(0),
          mack => memory_space_3_lr_ack(0),
          maddr => memory_space_3_lr_addr(0 downto 0),
          mtag => memory_space_3_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_3_lc_req(0),
          mack => memory_space_3_lc_ack(0),
          mdata => memory_space_3_lc_data(31 downto 0),
          mtag => memory_space_3_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : simple_obj_ref_48_load_0 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_48_load_0_req_0;
      simple_obj_ref_48_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_48_load_0_req_1;
      simple_obj_ref_48_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_48_word_address_0;
      simple_obj_ref_48_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(0 downto 0),
          mtag => memory_space_1_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_1_lc_req(0),
          mack => memory_space_1_lc_ack(0),
          mdata => memory_space_1_lc_data(31 downto 0),
          mtag => memory_space_1_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 3
    -- shared store operator group (0) : simple_obj_ref_11_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_11_store_0_req_0;
      simple_obj_ref_11_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_11_store_0_req_1;
      simple_obj_ref_11_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_11_word_address_0;
      data_in <= simple_obj_ref_11_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_2_sr_req(0),
          mack => memory_space_2_sr_ack(0),
          maddr => memory_space_2_sr_addr(0 downto 0),
          mdata => memory_space_2_sr_data(31 downto 0),
          mtag => memory_space_2_sr_tag(0 downto 0),
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
          mreq => memory_space_2_sc_req(0),
          mack => memory_space_2_sc_ack(0),
          mtag => memory_space_2_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : simple_obj_ref_14_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_14_store_0_req_0;
      simple_obj_ref_14_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_14_store_0_req_1;
      simple_obj_ref_14_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_14_word_address_0;
      data_in <= simple_obj_ref_14_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_3_sr_req(0),
          mack => memory_space_3_sr_ack(0),
          maddr => memory_space_3_sr_addr(0 downto 0),
          mdata => memory_space_3_sr_data(31 downto 0),
          mtag => memory_space_3_sr_tag(0 downto 0),
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
          mreq => memory_space_3_sc_req(0),
          mack => memory_space_3_sc_ack(0),
          mtag => memory_space_3_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : simple_obj_ref_42_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_42_store_0_req_0;
      simple_obj_ref_42_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_42_store_0_req_1;
      simple_obj_ref_42_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_42_word_address_0;
      data_in <= simple_obj_ref_42_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(0),
          mack => memory_space_1_sr_ack(0),
          maddr => memory_space_1_sr_addr(0 downto 0),
          mdata => memory_space_1_sr_data(31 downto 0),
          mtag => memory_space_1_sr_tag(0 downto 0),
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
          mreq => memory_space_1_sc_req(0),
          mack => memory_space_1_sc_ack(0),
          mtag => memory_space_1_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- 
  end Block; -- data_path
  RegisterBank_memory_space_1: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_1_lr_addr,
      lr_req_in => memory_space_1_lr_req,
      lr_ack_out => memory_space_1_lr_ack,
      lr_tag_in => memory_space_1_lr_tag,
      lc_req_in => memory_space_1_lc_req,
      lc_ack_out => memory_space_1_lc_ack,
      lc_data_out => memory_space_1_lc_data,
      lc_tag_out => memory_space_1_lc_tag,
      sr_addr_in => memory_space_1_sr_addr,
      sr_data_in => memory_space_1_sr_data,
      sr_req_in => memory_space_1_sr_req,
      sr_ack_out => memory_space_1_sr_ack,
      sr_tag_in => memory_space_1_sr_tag,
      sc_req_in=> memory_space_1_sc_req,
      sc_ack_out => memory_space_1_sc_ack,
      sc_tag_out => memory_space_1_sc_tag,
      clock => clk,
      reset => reset); -- 
  RegisterBank_memory_space_2: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_2_lr_addr,
      lr_req_in => memory_space_2_lr_req,
      lr_ack_out => memory_space_2_lr_ack,
      lr_tag_in => memory_space_2_lr_tag,
      lc_req_in => memory_space_2_lc_req,
      lc_ack_out => memory_space_2_lc_ack,
      lc_data_out => memory_space_2_lc_data,
      lc_tag_out => memory_space_2_lc_tag,
      sr_addr_in => memory_space_2_sr_addr,
      sr_data_in => memory_space_2_sr_data,
      sr_req_in => memory_space_2_sr_req,
      sr_ack_out => memory_space_2_sr_ack,
      sr_tag_in => memory_space_2_sr_tag,
      sc_req_in=> memory_space_2_sc_req,
      sc_ack_out => memory_space_2_sc_ack,
      sc_tag_out => memory_space_2_sc_tag,
      clock => clk,
      reset => reset); -- 
  RegisterBank_memory_space_3: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 1) -- 
    port map(-- 
      lr_addr_in => memory_space_3_lr_addr,
      lr_req_in => memory_space_3_lr_req,
      lr_ack_out => memory_space_3_lr_ack,
      lr_tag_in => memory_space_3_lr_tag,
      lc_req_in => memory_space_3_lc_req,
      lc_ack_out => memory_space_3_lc_ack,
      lc_data_out => memory_space_3_lc_data,
      lc_tag_out => memory_space_3_lc_tag,
      sr_addr_in => memory_space_3_sr_addr,
      sr_data_in => memory_space_3_sr_data,
      sr_req_in => memory_space_3_sr_req,
      sr_ack_out => memory_space_3_sr_ack,
      sr_tag_in => memory_space_3_sr_tag,
      sc_req_in=> memory_space_3_sc_req,
      sc_ack_out => memory_space_3_sc_ack,
      sc_tag_out => memory_space_3_sc_tag,
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
library work;
use work.vc_system_package.all;
entity test_system is  -- system 
  port (-- 
    main_ret_val_x_x : out  std_logic_vector(31 downto 0);
    main_tag_in: in std_logic_vector(0 downto 0);
    main_tag_out: out std_logic_vector(0 downto 0);
    main_start : in std_logic;
    main_fin   : out std_logic;
    clk : in std_logic;
    reset : in std_logic); -- 
  -- 
end entity; 
architecture Default of test_system is -- system-architecture 
  -- interface signals to connect to memory space memory_space_0
  signal memory_space_0_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_0_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_0_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_0_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_0_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_0_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_0_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_0_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_0_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(0 downto 0);
  -- declarations related to module main
  component main is -- 
    port ( -- 
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      sub_call_reqs : out  std_logic_vector(0 downto 0);
      sub_call_acks : in   std_logic_vector(0 downto 0);
      sub_call_data : out  std_logic_vector(63 downto 0);
      sub_call_tag  :  out  std_logic_vector(0 downto 0);
      sub_return_reqs : out  std_logic_vector(0 downto 0);
      sub_return_acks : in   std_logic_vector(0 downto 0);
      sub_return_data : in   std_logic_vector(31 downto 0);
      sub_return_tag :  in   std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- declarations related to module sub
  component sub is -- 
    port ( -- 
      a : in  std_logic_vector(31 downto 0);
      b : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(0 downto 0);
      sub_slave_call_reqs : out  std_logic_vector(0 downto 0);
      sub_slave_call_acks : in   std_logic_vector(0 downto 0);
      sub_slave_call_data : out  std_logic_vector(63 downto 0);
      sub_slave_call_tag  :  out  std_logic_vector(0 downto 0);
      sub_slave_return_reqs : out  std_logic_vector(0 downto 0);
      sub_slave_return_acks : in   std_logic_vector(0 downto 0);
      sub_slave_return_data : in   std_logic_vector(31 downto 0);
      sub_slave_return_tag :  in   std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module sub
  signal sub_a :  std_logic_vector(31 downto 0);
  signal sub_b :  std_logic_vector(31 downto 0);
  signal sub_ret_val_x_x :  std_logic_vector(31 downto 0);
  signal sub_in_args    : std_logic_vector(63 downto 0);
  signal sub_out_args   : std_logic_vector(31 downto 0);
  signal sub_tag_in    : std_logic_vector(0 downto 0);
  signal sub_tag_out   : std_logic_vector(0 downto 0);
  signal sub_start : std_logic;
  signal sub_fin   : std_logic;
  -- caller side aggregated signals for module sub
  signal sub_call_reqs: std_logic_vector(0 downto 0);
  signal sub_call_acks: std_logic_vector(0 downto 0);
  signal sub_return_reqs: std_logic_vector(0 downto 0);
  signal sub_return_acks: std_logic_vector(0 downto 0);
  signal sub_call_data: std_logic_vector(63 downto 0);
  signal sub_call_tag: std_logic_vector(0 downto 0);
  signal sub_return_data: std_logic_vector(31 downto 0);
  signal sub_return_tag: std_logic_vector(0 downto 0);
  -- declarations related to module sub_slave
  component sub_slave is -- 
    port ( -- 
      a : in  std_logic_vector(31 downto 0);
      b : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_0_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module sub_slave
  signal sub_slave_a :  std_logic_vector(31 downto 0);
  signal sub_slave_b :  std_logic_vector(31 downto 0);
  signal sub_slave_ret_val_x_x :  std_logic_vector(31 downto 0);
  signal sub_slave_in_args    : std_logic_vector(63 downto 0);
  signal sub_slave_out_args   : std_logic_vector(31 downto 0);
  signal sub_slave_tag_in    : std_logic_vector(0 downto 0);
  signal sub_slave_tag_out   : std_logic_vector(0 downto 0);
  signal sub_slave_start : std_logic;
  signal sub_slave_fin   : std_logic;
  -- caller side aggregated signals for module sub_slave
  signal sub_slave_call_reqs: std_logic_vector(0 downto 0);
  signal sub_slave_call_acks: std_logic_vector(0 downto 0);
  signal sub_slave_return_reqs: std_logic_vector(0 downto 0);
  signal sub_slave_return_acks: std_logic_vector(0 downto 0);
  signal sub_slave_call_data: std_logic_vector(63 downto 0);
  signal sub_slave_call_tag: std_logic_vector(0 downto 0);
  signal sub_slave_return_data: std_logic_vector(31 downto 0);
  signal sub_slave_return_tag: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module main
  main_instance:main-- 
    port map(-- 
      ret_val_x_x => main_ret_val_x_x,
      start => main_start,
      fin => main_fin,
      clk => clk,
      reset => reset,
      sub_call_reqs => sub_call_reqs(0 downto 0),
      sub_call_acks => sub_call_acks(0 downto 0),
      sub_call_data => sub_call_data(63 downto 0),
      sub_call_tag => sub_call_tag(0 downto 0),
      sub_return_reqs => sub_return_reqs(0 downto 0),
      sub_return_acks => sub_return_acks(0 downto 0),
      sub_return_data => sub_return_data(31 downto 0),
      sub_return_tag => sub_return_tag(0 downto 0),
      tag_in => main_tag_in,
      tag_out => main_tag_out-- 
    ); -- 
  -- module sub
  sub_a <= sub_in_args(63 downto 32);
  sub_b <= sub_in_args(31 downto 0);
  sub_out_args <= sub_ret_val_x_x ;
  -- call arbiter for module sub
  sub_arbiter: CallArbiterUnitary -- 
    generic map( --
      num_reqs => 1,
      call_data_width => 64,
      return_data_width => 32,
      callee_tag_length => 1,
      caller_tag_length => 1--
    )
    port map(-- 
      call_reqs => sub_call_reqs,
      call_acks => sub_call_acks,
      return_reqs => sub_return_reqs,
      return_acks => sub_return_acks,
      call_data  => sub_call_data,
      call_tag  => sub_call_tag,
      return_tag  => sub_return_tag,
      call_in_tag => sub_tag_in,
      call_out_tag => sub_tag_out,
      return_data =>sub_return_data,
      call_start => sub_start,
      call_fin => sub_fin,
      call_in_args => sub_in_args,
      call_out_args => sub_out_args,
      clk => clk, 
      reset => reset --
    ); --
  sub_instance:sub-- 
    port map(-- 
      a => sub_a,
      b => sub_b,
      ret_val_x_x => sub_ret_val_x_x,
      start => sub_start,
      fin => sub_fin,
      clk => clk,
      reset => reset,
      memory_space_0_sr_req => memory_space_0_sr_req(0 downto 0),
      memory_space_0_sr_ack => memory_space_0_sr_ack(0 downto 0),
      memory_space_0_sr_addr => memory_space_0_sr_addr(0 downto 0),
      memory_space_0_sr_data => memory_space_0_sr_data(31 downto 0),
      memory_space_0_sr_tag => memory_space_0_sr_tag(0 downto 0),
      memory_space_0_sc_req => memory_space_0_sc_req(0 downto 0),
      memory_space_0_sc_ack => memory_space_0_sc_ack(0 downto 0),
      memory_space_0_sc_tag => memory_space_0_sc_tag(0 downto 0),
      sub_slave_call_reqs => sub_slave_call_reqs(0 downto 0),
      sub_slave_call_acks => sub_slave_call_acks(0 downto 0),
      sub_slave_call_data => sub_slave_call_data(63 downto 0),
      sub_slave_call_tag => sub_slave_call_tag(0 downto 0),
      sub_slave_return_reqs => sub_slave_return_reqs(0 downto 0),
      sub_slave_return_acks => sub_slave_return_acks(0 downto 0),
      sub_slave_return_data => sub_slave_return_data(31 downto 0),
      sub_slave_return_tag => sub_slave_return_tag(0 downto 0),
      tag_in => sub_tag_in,
      tag_out => sub_tag_out-- 
    ); -- 
  -- module sub_slave
  sub_slave_a <= sub_slave_in_args(63 downto 32);
  sub_slave_b <= sub_slave_in_args(31 downto 0);
  sub_slave_out_args <= sub_slave_ret_val_x_x ;
  -- call arbiter for module sub_slave
  sub_slave_arbiter: CallArbiterUnitary -- 
    generic map( --
      num_reqs => 1,
      call_data_width => 64,
      return_data_width => 32,
      callee_tag_length => 1,
      caller_tag_length => 1--
    )
    port map(-- 
      call_reqs => sub_slave_call_reqs,
      call_acks => sub_slave_call_acks,
      return_reqs => sub_slave_return_reqs,
      return_acks => sub_slave_return_acks,
      call_data  => sub_slave_call_data,
      call_tag  => sub_slave_call_tag,
      return_tag  => sub_slave_return_tag,
      call_in_tag => sub_slave_tag_in,
      call_out_tag => sub_slave_tag_out,
      return_data =>sub_slave_return_data,
      call_start => sub_slave_start,
      call_fin => sub_slave_fin,
      call_in_args => sub_slave_in_args,
      call_out_args => sub_slave_out_args,
      clk => clk, 
      reset => reset --
    ); --
  sub_slave_instance:sub_slave-- 
    port map(-- 
      a => sub_slave_a,
      b => sub_slave_b,
      ret_val_x_x => sub_slave_ret_val_x_x,
      start => sub_slave_start,
      fin => sub_slave_fin,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(0 downto 0),
      memory_space_0_lr_ack => memory_space_0_lr_ack(0 downto 0),
      memory_space_0_lr_addr => memory_space_0_lr_addr(0 downto 0),
      memory_space_0_lr_tag => memory_space_0_lr_tag(0 downto 0),
      memory_space_0_lc_req => memory_space_0_lc_req(0 downto 0),
      memory_space_0_lc_ack => memory_space_0_lc_ack(0 downto 0),
      memory_space_0_lc_data => memory_space_0_lc_data(31 downto 0),
      memory_space_0_lc_tag => memory_space_0_lc_tag(0 downto 0),
      tag_in => sub_slave_tag_in,
      tag_out => sub_slave_tag_out-- 
    ); -- 
  RegisterBank_memory_space_0: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 1,
      num_registers => 2) -- 
    port map(-- 
      lr_addr_in => memory_space_0_lr_addr,
      lr_req_in => memory_space_0_lr_req,
      lr_ack_out => memory_space_0_lr_ack,
      lr_tag_in => memory_space_0_lr_tag,
      lc_req_in => memory_space_0_lc_req,
      lc_ack_out => memory_space_0_lc_ack,
      lc_data_out => memory_space_0_lc_data,
      lc_tag_out => memory_space_0_lc_tag,
      sr_addr_in => memory_space_0_sr_addr,
      sr_data_in => memory_space_0_sr_data,
      sr_req_in => memory_space_0_sr_req,
      sr_ack_out => memory_space_0_sr_ack,
      sr_tag_in => memory_space_0_sr_tag,
      sc_req_in=> memory_space_0_sc_req,
      sc_ack_out => memory_space_0_sc_ack,
      sc_tag_out => memory_space_0_sc_tag,
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
library work;
use work.vc_system_package.all;
entity test_system_Test_Bench is -- 
  -- 
end entity;
architecture Default of test_system_Test_Bench is -- 
  component test_system is -- 
    port (-- 
      main_ret_val_x_x : out  std_logic_vector(31 downto 0);
      main_tag_in: in std_logic_vector(0 downto 0);
      main_tag_out: out std_logic_vector(0 downto 0);
      main_start : in std_logic;
      main_fin   : out std_logic;
      clk : in std_logic;
      reset : in std_logic); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal main_ret_val_x_x :   std_logic_vector(31 downto 0);
  signal main_tag_in: std_logic_vector(0 downto 0);
  signal main_tag_out: std_logic_vector(0 downto 0);
  signal main_start : std_logic := '0';
  signal main_fin   : std_logic := '0';
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
    main_start <= '1';
    wait until clk = '1';
    main_start <= '0';
    while main_fin /= '1' loop -- 
      wait until clk = '1';
      -- 
    end loop;
    wait;
    --
  end process;
  test_system_instance: test_system -- 
    port map ( -- 
      main_ret_val_x_x => main_ret_val_x_x,
      main_tag_in => main_tag_in,
      main_tag_out => main_tag_out,
      main_start => main_start,
      main_fin  => main_fin ,
      clk => clk,
      reset => reset); -- 
  -- 
end Default;
