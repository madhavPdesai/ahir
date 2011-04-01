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
  signal simple_obj_ref_169_store_0_req_0 : boolean;
  signal simple_obj_ref_183_load_0_ack_1 : boolean;
  signal simple_obj_ref_183_load_0_ack_0 : boolean;
  signal simple_obj_ref_149_load_0_ack_1 : boolean;
  signal simple_obj_ref_149_load_0_req_1 : boolean;
  signal binary_154_inst_ack_1 : boolean;
  signal simple_obj_ref_183_load_0_req_0 : boolean;
  signal simple_obj_ref_177_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_169_store_0_ack_1 : boolean;
  signal simple_obj_ref_169_store_0_req_1 : boolean;
  signal simple_obj_ref_169_store_0_ack_0 : boolean;
  signal simple_obj_ref_177_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_138_store_0_ack_1 : boolean;
  signal simple_obj_ref_169_gather_scatter_ack_0 : boolean;
  signal binary_154_inst_req_1 : boolean;
  signal call_stmt_144_call_ack_1 : boolean;
  signal simple_obj_ref_169_gather_scatter_req_0 : boolean;
  signal binary_154_inst_ack_0 : boolean;
  signal call_stmt_144_call_req_1 : boolean;
  signal simple_obj_ref_149_load_0_ack_0 : boolean;
  signal simple_obj_ref_149_load_0_req_0 : boolean;
  signal simple_obj_ref_138_gather_scatter_req_0 : boolean;
  signal call_stmt_144_call_ack_0 : boolean;
  signal simple_obj_ref_164_store_0_ack_1 : boolean;
  signal simple_obj_ref_164_store_0_req_1 : boolean;
  signal simple_obj_ref_164_store_0_ack_0 : boolean;
  signal simple_obj_ref_164_store_0_req_0 : boolean;
  signal simple_obj_ref_164_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_164_gather_scatter_req_0 : boolean;
  signal binary_154_inst_req_0 : boolean;
  signal simple_obj_ref_175_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_175_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_175_load_0_ack_1 : boolean;
  signal simple_obj_ref_149_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_175_load_0_req_1 : boolean;
  signal if_stmt_157_branch_ack_0 : boolean;
  signal simple_obj_ref_177_store_0_ack_1 : boolean;
  signal simple_obj_ref_175_load_0_ack_0 : boolean;
  signal simple_obj_ref_177_store_0_req_1 : boolean;
  signal simple_obj_ref_175_load_0_req_0 : boolean;
  signal call_stmt_144_call_req_0 : boolean;
  signal simple_obj_ref_149_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_177_store_0_ack_0 : boolean;
  signal if_stmt_157_branch_ack_1 : boolean;
  signal simple_obj_ref_183_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_183_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_177_store_0_req_0 : boolean;
  signal simple_obj_ref_138_store_0_req_1 : boolean;
  signal simple_obj_ref_145_store_0_ack_1 : boolean;
  signal simple_obj_ref_138_store_0_ack_0 : boolean;
  signal simple_obj_ref_145_store_0_req_1 : boolean;
  signal simple_obj_ref_145_store_0_ack_0 : boolean;
  signal simple_obj_ref_145_store_0_req_0 : boolean;
  signal simple_obj_ref_138_store_0_req_0 : boolean;
  signal simple_obj_ref_145_gather_scatter_ack_0 : boolean;
  signal if_stmt_157_branch_req_0 : boolean;
  signal simple_obj_ref_145_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_138_gather_scatter_ack_0 : boolean;
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
  main_CP_540: Block -- control-path 
    signal main_CP_540_start: Boolean;
    signal Xentry_541_symbol: Boolean;
    signal Xexit_542_symbol: Boolean;
    signal branch_block_stmt_135_543_symbol : Boolean;
    -- 
  begin -- 
    main_CP_540_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_541_symbol  <= main_CP_540_start; -- transition $entry
    branch_block_stmt_135_543: Block -- branch_block_stmt_135 
      signal branch_block_stmt_135_543_start: Boolean;
      signal Xentry_544_symbol: Boolean;
      signal Xexit_545_symbol: Boolean;
      signal branch_block_stmt_135_x_xentry_x_xx_x546_symbol : Boolean;
      signal branch_block_stmt_135_x_xexit_x_xx_x547_symbol : Boolean;
      signal assign_stmt_140_x_xentry_x_xx_x548_symbol : Boolean;
      signal assign_stmt_140_x_xexit_x_xx_x549_symbol : Boolean;
      signal call_stmt_144_x_xentry_x_xx_x550_symbol : Boolean;
      signal call_stmt_144_x_xexit_x_xx_x551_symbol : Boolean;
      signal assign_stmt_147_x_xentry_x_xx_x552_symbol : Boolean;
      signal assign_stmt_147_x_xexit_x_xx_x553_symbol : Boolean;
      signal assign_stmt_150_x_xentry_x_xx_x554_symbol : Boolean;
      signal assign_stmt_150_x_xexit_x_xx_x555_symbol : Boolean;
      signal assign_stmt_156_x_xentry_x_xx_x556_symbol : Boolean;
      signal assign_stmt_156_x_xexit_x_xx_x557_symbol : Boolean;
      signal if_stmt_157_x_xentry_x_xx_x558_symbol : Boolean;
      signal merge_stmt_163_x_xexit_x_xx_x559_symbol : Boolean;
      signal assign_stmt_166_x_xentry_x_xx_x560_symbol : Boolean;
      signal assign_stmt_166_x_xexit_x_xx_x561_symbol : Boolean;
      signal merge_stmt_168_x_xexit_x_xx_x562_symbol : Boolean;
      signal assign_stmt_171_x_xentry_x_xx_x563_symbol : Boolean;
      signal assign_stmt_171_x_xexit_x_xx_x564_symbol : Boolean;
      signal merge_stmt_173_x_xexit_x_xx_x565_symbol : Boolean;
      signal assign_stmt_176_x_xentry_x_xx_x566_symbol : Boolean;
      signal assign_stmt_176_x_xexit_x_xx_x567_symbol : Boolean;
      signal assign_stmt_179_x_xentry_x_xx_x568_symbol : Boolean;
      signal assign_stmt_179_x_xexit_x_xx_x569_symbol : Boolean;
      signal merge_stmt_181_x_xexit_x_xx_x570_symbol : Boolean;
      signal assign_stmt_184_x_xentry_x_xx_x571_symbol : Boolean;
      signal assign_stmt_184_x_xexit_x_xx_x572_symbol : Boolean;
      signal bb_1_bb_3_573_symbol : Boolean;
      signal bb_2_bb_3_574_symbol : Boolean;
      signal return_x_xx_x575_symbol : Boolean;
      signal assign_stmt_140_576_symbol : Boolean;
      signal call_stmt_144_597_symbol : Boolean;
      signal assign_stmt_147_610_symbol : Boolean;
      signal assign_stmt_150_631_symbol : Boolean;
      signal assign_stmt_156_652_symbol : Boolean;
      signal if_stmt_157_eval_test_665_symbol : Boolean;
      signal simple_obj_ref_158_place_669_symbol : Boolean;
      signal if_stmt_157_if_link_670_symbol : Boolean;
      signal if_stmt_157_else_link_674_symbol : Boolean;
      signal bb_0_bb_1_678_symbol : Boolean;
      signal bb_0_bb_2_679_symbol : Boolean;
      signal assign_stmt_166_680_symbol : Boolean;
      signal assign_stmt_171_701_symbol : Boolean;
      signal assign_stmt_176_722_symbol : Boolean;
      signal assign_stmt_179_743_symbol : Boolean;
      signal assign_stmt_184_764_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_785_symbol : Boolean;
      signal merge_stmt_163_PhiReqMerge_788_symbol : Boolean;
      signal merge_stmt_163_PhiAck_789_symbol : Boolean;
      signal bb_0_bb_2_PhiReq_793_symbol : Boolean;
      signal merge_stmt_168_PhiReqMerge_796_symbol : Boolean;
      signal merge_stmt_168_PhiAck_797_symbol : Boolean;
      signal bb_1_bb_3_PhiReq_801_symbol : Boolean;
      signal bb_2_bb_3_PhiReq_804_symbol : Boolean;
      signal merge_stmt_173_PhiReqMerge_807_symbol : Boolean;
      signal merge_stmt_173_PhiAck_808_symbol : Boolean;
      signal return_x_xx_xPhiReq_812_symbol : Boolean;
      signal merge_stmt_181_PhiReqMerge_815_symbol : Boolean;
      signal merge_stmt_181_PhiAck_816_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_135_543_start <= Xentry_541_symbol; -- control passed to block
      Xentry_544_symbol  <= branch_block_stmt_135_543_start; -- transition branch_block_stmt_135/$entry
      branch_block_stmt_135_x_xentry_x_xx_x546_symbol  <=  Xentry_544_symbol; -- place branch_block_stmt_135/branch_block_stmt_135__entry__ (optimized away) 
      branch_block_stmt_135_x_xexit_x_xx_x547_symbol  <=  assign_stmt_184_x_xexit_x_xx_x572_symbol; -- place branch_block_stmt_135/branch_block_stmt_135__exit__ (optimized away) 
      assign_stmt_140_x_xentry_x_xx_x548_symbol  <=  branch_block_stmt_135_x_xentry_x_xx_x546_symbol; -- place branch_block_stmt_135/assign_stmt_140__entry__ (optimized away) 
      assign_stmt_140_x_xexit_x_xx_x549_symbol  <=  assign_stmt_140_576_symbol; -- place branch_block_stmt_135/assign_stmt_140__exit__ (optimized away) 
      call_stmt_144_x_xentry_x_xx_x550_symbol  <=  assign_stmt_140_x_xexit_x_xx_x549_symbol; -- place branch_block_stmt_135/call_stmt_144__entry__ (optimized away) 
      call_stmt_144_x_xexit_x_xx_x551_symbol  <=  call_stmt_144_597_symbol; -- place branch_block_stmt_135/call_stmt_144__exit__ (optimized away) 
      assign_stmt_147_x_xentry_x_xx_x552_symbol  <=  call_stmt_144_x_xexit_x_xx_x551_symbol; -- place branch_block_stmt_135/assign_stmt_147__entry__ (optimized away) 
      assign_stmt_147_x_xexit_x_xx_x553_symbol  <=  assign_stmt_147_610_symbol; -- place branch_block_stmt_135/assign_stmt_147__exit__ (optimized away) 
      assign_stmt_150_x_xentry_x_xx_x554_symbol  <=  assign_stmt_147_x_xexit_x_xx_x553_symbol; -- place branch_block_stmt_135/assign_stmt_150__entry__ (optimized away) 
      assign_stmt_150_x_xexit_x_xx_x555_symbol  <=  assign_stmt_150_631_symbol; -- place branch_block_stmt_135/assign_stmt_150__exit__ (optimized away) 
      assign_stmt_156_x_xentry_x_xx_x556_symbol  <=  assign_stmt_150_x_xexit_x_xx_x555_symbol; -- place branch_block_stmt_135/assign_stmt_156__entry__ (optimized away) 
      assign_stmt_156_x_xexit_x_xx_x557_symbol  <=  assign_stmt_156_652_symbol; -- place branch_block_stmt_135/assign_stmt_156__exit__ (optimized away) 
      if_stmt_157_x_xentry_x_xx_x558_symbol  <=  assign_stmt_156_x_xexit_x_xx_x557_symbol; -- place branch_block_stmt_135/if_stmt_157__entry__ (optimized away) 
      merge_stmt_163_x_xexit_x_xx_x559_symbol  <=  merge_stmt_163_PhiAck_789_symbol; -- place branch_block_stmt_135/merge_stmt_163__exit__ (optimized away) 
      assign_stmt_166_x_xentry_x_xx_x560_symbol  <=  merge_stmt_163_x_xexit_x_xx_x559_symbol; -- place branch_block_stmt_135/assign_stmt_166__entry__ (optimized away) 
      assign_stmt_166_x_xexit_x_xx_x561_symbol  <=  assign_stmt_166_680_symbol; -- place branch_block_stmt_135/assign_stmt_166__exit__ (optimized away) 
      merge_stmt_168_x_xexit_x_xx_x562_symbol  <=  merge_stmt_168_PhiAck_797_symbol; -- place branch_block_stmt_135/merge_stmt_168__exit__ (optimized away) 
      assign_stmt_171_x_xentry_x_xx_x563_symbol  <=  merge_stmt_168_x_xexit_x_xx_x562_symbol; -- place branch_block_stmt_135/assign_stmt_171__entry__ (optimized away) 
      assign_stmt_171_x_xexit_x_xx_x564_symbol  <=  assign_stmt_171_701_symbol; -- place branch_block_stmt_135/assign_stmt_171__exit__ (optimized away) 
      merge_stmt_173_x_xexit_x_xx_x565_symbol  <=  merge_stmt_173_PhiAck_808_symbol; -- place branch_block_stmt_135/merge_stmt_173__exit__ (optimized away) 
      assign_stmt_176_x_xentry_x_xx_x566_symbol  <=  merge_stmt_173_x_xexit_x_xx_x565_symbol; -- place branch_block_stmt_135/assign_stmt_176__entry__ (optimized away) 
      assign_stmt_176_x_xexit_x_xx_x567_symbol  <=  assign_stmt_176_722_symbol; -- place branch_block_stmt_135/assign_stmt_176__exit__ (optimized away) 
      assign_stmt_179_x_xentry_x_xx_x568_symbol  <=  assign_stmt_176_x_xexit_x_xx_x567_symbol; -- place branch_block_stmt_135/assign_stmt_179__entry__ (optimized away) 
      assign_stmt_179_x_xexit_x_xx_x569_symbol  <=  assign_stmt_179_743_symbol; -- place branch_block_stmt_135/assign_stmt_179__exit__ (optimized away) 
      merge_stmt_181_x_xexit_x_xx_x570_symbol  <=  merge_stmt_181_PhiAck_816_symbol; -- place branch_block_stmt_135/merge_stmt_181__exit__ (optimized away) 
      assign_stmt_184_x_xentry_x_xx_x571_symbol  <=  merge_stmt_181_x_xexit_x_xx_x570_symbol; -- place branch_block_stmt_135/assign_stmt_184__entry__ (optimized away) 
      assign_stmt_184_x_xexit_x_xx_x572_symbol  <=  assign_stmt_184_764_symbol; -- place branch_block_stmt_135/assign_stmt_184__exit__ (optimized away) 
      bb_1_bb_3_573_symbol  <=  assign_stmt_166_x_xexit_x_xx_x561_symbol; -- place branch_block_stmt_135/bb_1_bb_3 (optimized away) 
      bb_2_bb_3_574_symbol  <=  assign_stmt_171_x_xexit_x_xx_x564_symbol; -- place branch_block_stmt_135/bb_2_bb_3 (optimized away) 
      return_x_xx_x575_symbol  <=  assign_stmt_179_x_xexit_x_xx_x569_symbol; -- place branch_block_stmt_135/return__ (optimized away) 
      assign_stmt_140_576: Block -- branch_block_stmt_135/assign_stmt_140 
        signal assign_stmt_140_576_start: Boolean;
        signal Xentry_577_symbol: Boolean;
        signal Xexit_578_symbol: Boolean;
        signal simple_obj_ref_138_579_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_140_576_start <= assign_stmt_140_x_xentry_x_xx_x548_symbol; -- control passed to block
        Xentry_577_symbol  <= assign_stmt_140_576_start; -- transition branch_block_stmt_135/assign_stmt_140/$entry
        simple_obj_ref_138_579: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138 
          signal simple_obj_ref_138_579_start: Boolean;
          signal Xentry_580_symbol: Boolean;
          signal Xexit_581_symbol: Boolean;
          signal simple_obj_ref_138_write_582_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_138_579_start <= Xentry_577_symbol; -- control passed to block
          Xentry_580_symbol  <= simple_obj_ref_138_579_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/$entry
          simple_obj_ref_138_write_582: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write 
            signal simple_obj_ref_138_write_582_start: Boolean;
            signal Xentry_583_symbol: Boolean;
            signal Xexit_584_symbol: Boolean;
            signal split_req_585_symbol : Boolean;
            signal split_ack_586_symbol : Boolean;
            signal word_access_587_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_138_write_582_start <= Xentry_580_symbol; -- control passed to block
            Xentry_583_symbol  <= simple_obj_ref_138_write_582_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/$entry
            split_req_585_symbol <= Xentry_583_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/split_req
            simple_obj_ref_138_gather_scatter_req_0 <= split_req_585_symbol; -- link to DP
            split_ack_586_symbol <= simple_obj_ref_138_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/split_ack
            word_access_587: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access 
              signal word_access_587_start: Boolean;
              signal Xentry_588_symbol: Boolean;
              signal Xexit_589_symbol: Boolean;
              signal word_access_0_590_symbol : Boolean;
              -- 
            begin -- 
              word_access_587_start <= split_ack_586_symbol; -- control passed to block
              Xentry_588_symbol  <= word_access_587_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/$entry
              word_access_0_590: Block -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0 
                signal word_access_0_590_start: Boolean;
                signal Xentry_591_symbol: Boolean;
                signal Xexit_592_symbol: Boolean;
                signal rr_593_symbol : Boolean;
                signal ra_594_symbol : Boolean;
                signal cr_595_symbol : Boolean;
                signal ca_596_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_590_start <= Xentry_588_symbol; -- control passed to block
                Xentry_591_symbol  <= word_access_0_590_start; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0/$entry
                rr_593_symbol <= Xentry_591_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0/rr
                simple_obj_ref_138_store_0_req_0 <= rr_593_symbol; -- link to DP
                ra_594_symbol <= simple_obj_ref_138_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0/ra
                cr_595_symbol <= ra_594_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0/cr
                simple_obj_ref_138_store_0_req_1 <= cr_595_symbol; -- link to DP
                ca_596_symbol <= simple_obj_ref_138_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0/ca
                Xexit_592_symbol <= ca_596_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0/$exit
                word_access_0_590_symbol <= Xexit_592_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/word_access_0
              Xexit_589_symbol <= word_access_0_590_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access/$exit
              word_access_587_symbol <= Xexit_589_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/word_access
            Xexit_584_symbol <= word_access_587_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write/$exit
            simple_obj_ref_138_write_582_symbol <= Xexit_584_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/simple_obj_ref_138_write
          Xexit_581_symbol <= simple_obj_ref_138_write_582_symbol; -- transition branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138/$exit
          simple_obj_ref_138_579_symbol <= Xexit_581_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_140/simple_obj_ref_138
        Xexit_578_symbol <= simple_obj_ref_138_579_symbol; -- transition branch_block_stmt_135/assign_stmt_140/$exit
        assign_stmt_140_576_symbol <= Xexit_578_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_140
      call_stmt_144_597: Block -- branch_block_stmt_135/call_stmt_144 
        signal call_stmt_144_597_start: Boolean;
        signal Xentry_598_symbol: Boolean;
        signal Xexit_599_symbol: Boolean;
        signal call_stmt_144_in_args_x_x600_symbol : Boolean;
        signal crr_603_symbol : Boolean;
        signal cra_604_symbol : Boolean;
        signal ccr_605_symbol : Boolean;
        signal cca_606_symbol : Boolean;
        signal call_stmt_144_out_args_x_x607_symbol : Boolean;
        -- 
      begin -- 
        call_stmt_144_597_start <= call_stmt_144_x_xentry_x_xx_x550_symbol; -- control passed to block
        Xentry_598_symbol  <= call_stmt_144_597_start; -- transition branch_block_stmt_135/call_stmt_144/$entry
        call_stmt_144_in_args_x_x600: Block -- branch_block_stmt_135/call_stmt_144/call_stmt_144_in_args_ 
          signal call_stmt_144_in_args_x_x600_start: Boolean;
          signal Xentry_601_symbol: Boolean;
          signal Xexit_602_symbol: Boolean;
          -- 
        begin -- 
          call_stmt_144_in_args_x_x600_start <= Xentry_598_symbol; -- control passed to block
          Xentry_601_symbol  <= call_stmt_144_in_args_x_x600_start; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_in_args_/$entry
          Xexit_602_symbol <= Xentry_601_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_in_args_/$exit
          call_stmt_144_in_args_x_x600_symbol <= Xexit_602_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/call_stmt_144/call_stmt_144_in_args_
        crr_603_symbol <= call_stmt_144_in_args_x_x600_symbol; -- transition branch_block_stmt_135/call_stmt_144/crr
        call_stmt_144_call_req_0 <= crr_603_symbol; -- link to DP
        cra_604_symbol <= call_stmt_144_call_ack_0; -- transition branch_block_stmt_135/call_stmt_144/cra
        ccr_605_symbol <= cra_604_symbol; -- transition branch_block_stmt_135/call_stmt_144/ccr
        call_stmt_144_call_req_1 <= ccr_605_symbol; -- link to DP
        cca_606_symbol <= call_stmt_144_call_ack_1; -- transition branch_block_stmt_135/call_stmt_144/cca
        call_stmt_144_out_args_x_x607: Block -- branch_block_stmt_135/call_stmt_144/call_stmt_144_out_args_ 
          signal call_stmt_144_out_args_x_x607_start: Boolean;
          signal Xentry_608_symbol: Boolean;
          signal Xexit_609_symbol: Boolean;
          -- 
        begin -- 
          call_stmt_144_out_args_x_x607_start <= cca_606_symbol; -- control passed to block
          Xentry_608_symbol  <= call_stmt_144_out_args_x_x607_start; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_out_args_/$entry
          Xexit_609_symbol <= Xentry_608_symbol; -- transition branch_block_stmt_135/call_stmt_144/call_stmt_144_out_args_/$exit
          call_stmt_144_out_args_x_x607_symbol <= Xexit_609_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/call_stmt_144/call_stmt_144_out_args_
        Xexit_599_symbol <= call_stmt_144_out_args_x_x607_symbol; -- transition branch_block_stmt_135/call_stmt_144/$exit
        call_stmt_144_597_symbol <= Xexit_599_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/call_stmt_144
      assign_stmt_147_610: Block -- branch_block_stmt_135/assign_stmt_147 
        signal assign_stmt_147_610_start: Boolean;
        signal Xentry_611_symbol: Boolean;
        signal Xexit_612_symbol: Boolean;
        signal simple_obj_ref_145_613_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_147_610_start <= assign_stmt_147_x_xentry_x_xx_x552_symbol; -- control passed to block
        Xentry_611_symbol  <= assign_stmt_147_610_start; -- transition branch_block_stmt_135/assign_stmt_147/$entry
        simple_obj_ref_145_613: Block -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145 
          signal simple_obj_ref_145_613_start: Boolean;
          signal Xentry_614_symbol: Boolean;
          signal Xexit_615_symbol: Boolean;
          signal simple_obj_ref_145_write_616_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_145_613_start <= Xentry_611_symbol; -- control passed to block
          Xentry_614_symbol  <= simple_obj_ref_145_613_start; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/$entry
          simple_obj_ref_145_write_616: Block -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write 
            signal simple_obj_ref_145_write_616_start: Boolean;
            signal Xentry_617_symbol: Boolean;
            signal Xexit_618_symbol: Boolean;
            signal split_req_619_symbol : Boolean;
            signal split_ack_620_symbol : Boolean;
            signal word_access_621_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_145_write_616_start <= Xentry_614_symbol; -- control passed to block
            Xentry_617_symbol  <= simple_obj_ref_145_write_616_start; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/$entry
            split_req_619_symbol <= Xentry_617_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/split_req
            simple_obj_ref_145_gather_scatter_req_0 <= split_req_619_symbol; -- link to DP
            split_ack_620_symbol <= simple_obj_ref_145_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/split_ack
            word_access_621: Block -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access 
              signal word_access_621_start: Boolean;
              signal Xentry_622_symbol: Boolean;
              signal Xexit_623_symbol: Boolean;
              signal word_access_0_624_symbol : Boolean;
              -- 
            begin -- 
              word_access_621_start <= split_ack_620_symbol; -- control passed to block
              Xentry_622_symbol  <= word_access_621_start; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/$entry
              word_access_0_624: Block -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0 
                signal word_access_0_624_start: Boolean;
                signal Xentry_625_symbol: Boolean;
                signal Xexit_626_symbol: Boolean;
                signal rr_627_symbol : Boolean;
                signal ra_628_symbol : Boolean;
                signal cr_629_symbol : Boolean;
                signal ca_630_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_624_start <= Xentry_622_symbol; -- control passed to block
                Xentry_625_symbol  <= word_access_0_624_start; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0/$entry
                rr_627_symbol <= Xentry_625_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0/rr
                simple_obj_ref_145_store_0_req_0 <= rr_627_symbol; -- link to DP
                ra_628_symbol <= simple_obj_ref_145_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0/ra
                cr_629_symbol <= ra_628_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0/cr
                simple_obj_ref_145_store_0_req_1 <= cr_629_symbol; -- link to DP
                ca_630_symbol <= simple_obj_ref_145_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0/ca
                Xexit_626_symbol <= ca_630_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0/$exit
                word_access_0_624_symbol <= Xexit_626_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/word_access_0
              Xexit_623_symbol <= word_access_0_624_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access/$exit
              word_access_621_symbol <= Xexit_623_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/word_access
            Xexit_618_symbol <= word_access_621_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write/$exit
            simple_obj_ref_145_write_616_symbol <= Xexit_618_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/simple_obj_ref_145_write
          Xexit_615_symbol <= simple_obj_ref_145_write_616_symbol; -- transition branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145/$exit
          simple_obj_ref_145_613_symbol <= Xexit_615_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_147/simple_obj_ref_145
        Xexit_612_symbol <= simple_obj_ref_145_613_symbol; -- transition branch_block_stmt_135/assign_stmt_147/$exit
        assign_stmt_147_610_symbol <= Xexit_612_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_147
      assign_stmt_150_631: Block -- branch_block_stmt_135/assign_stmt_150 
        signal assign_stmt_150_631_start: Boolean;
        signal Xentry_632_symbol: Boolean;
        signal Xexit_633_symbol: Boolean;
        signal simple_obj_ref_149_634_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_150_631_start <= assign_stmt_150_x_xentry_x_xx_x554_symbol; -- control passed to block
        Xentry_632_symbol  <= assign_stmt_150_631_start; -- transition branch_block_stmt_135/assign_stmt_150/$entry
        simple_obj_ref_149_634: Block -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149 
          signal simple_obj_ref_149_634_start: Boolean;
          signal Xentry_635_symbol: Boolean;
          signal Xexit_636_symbol: Boolean;
          signal simple_obj_ref_149_read_637_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_149_634_start <= Xentry_632_symbol; -- control passed to block
          Xentry_635_symbol  <= simple_obj_ref_149_634_start; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/$entry
          simple_obj_ref_149_read_637: Block -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read 
            signal simple_obj_ref_149_read_637_start: Boolean;
            signal Xentry_638_symbol: Boolean;
            signal Xexit_639_symbol: Boolean;
            signal word_access_640_symbol : Boolean;
            signal merge_req_650_symbol : Boolean;
            signal merge_ack_651_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_149_read_637_start <= Xentry_635_symbol; -- control passed to block
            Xentry_638_symbol  <= simple_obj_ref_149_read_637_start; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/$entry
            word_access_640: Block -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access 
              signal word_access_640_start: Boolean;
              signal Xentry_641_symbol: Boolean;
              signal Xexit_642_symbol: Boolean;
              signal word_access_0_643_symbol : Boolean;
              -- 
            begin -- 
              word_access_640_start <= Xentry_638_symbol; -- control passed to block
              Xentry_641_symbol  <= word_access_640_start; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/$entry
              word_access_0_643: Block -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0 
                signal word_access_0_643_start: Boolean;
                signal Xentry_644_symbol: Boolean;
                signal Xexit_645_symbol: Boolean;
                signal rr_646_symbol : Boolean;
                signal ra_647_symbol : Boolean;
                signal cr_648_symbol : Boolean;
                signal ca_649_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_643_start <= Xentry_641_symbol; -- control passed to block
                Xentry_644_symbol  <= word_access_0_643_start; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0/$entry
                rr_646_symbol <= Xentry_644_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0/rr
                simple_obj_ref_149_load_0_req_0 <= rr_646_symbol; -- link to DP
                ra_647_symbol <= simple_obj_ref_149_load_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0/ra
                cr_648_symbol <= ra_647_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0/cr
                simple_obj_ref_149_load_0_req_1 <= cr_648_symbol; -- link to DP
                ca_649_symbol <= simple_obj_ref_149_load_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0/ca
                Xexit_645_symbol <= ca_649_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0/$exit
                word_access_0_643_symbol <= Xexit_645_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/word_access_0
              Xexit_642_symbol <= word_access_0_643_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access/$exit
              word_access_640_symbol <= Xexit_642_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/word_access
            merge_req_650_symbol <= word_access_640_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/merge_req
            simple_obj_ref_149_gather_scatter_req_0 <= merge_req_650_symbol; -- link to DP
            merge_ack_651_symbol <= simple_obj_ref_149_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/merge_ack
            Xexit_639_symbol <= merge_ack_651_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read/$exit
            simple_obj_ref_149_read_637_symbol <= Xexit_639_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/simple_obj_ref_149_read
          Xexit_636_symbol <= simple_obj_ref_149_read_637_symbol; -- transition branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149/$exit
          simple_obj_ref_149_634_symbol <= Xexit_636_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_150/simple_obj_ref_149
        Xexit_633_symbol <= simple_obj_ref_149_634_symbol; -- transition branch_block_stmt_135/assign_stmt_150/$exit
        assign_stmt_150_631_symbol <= Xexit_633_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_150
      assign_stmt_156_652: Block -- branch_block_stmt_135/assign_stmt_156 
        signal assign_stmt_156_652_start: Boolean;
        signal Xentry_653_symbol: Boolean;
        signal Xexit_654_symbol: Boolean;
        signal binary_154_655_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_156_652_start <= assign_stmt_156_x_xentry_x_xx_x556_symbol; -- control passed to block
        Xentry_653_symbol  <= assign_stmt_156_652_start; -- transition branch_block_stmt_135/assign_stmt_156/$entry
        binary_154_655: Block -- branch_block_stmt_135/assign_stmt_156/binary_154 
          signal binary_154_655_start: Boolean;
          signal Xentry_656_symbol: Boolean;
          signal Xexit_657_symbol: Boolean;
          signal binary_154_inputs_658_symbol : Boolean;
          signal rr_661_symbol : Boolean;
          signal ra_662_symbol : Boolean;
          signal cr_663_symbol : Boolean;
          signal ca_664_symbol : Boolean;
          -- 
        begin -- 
          binary_154_655_start <= Xentry_653_symbol; -- control passed to block
          Xentry_656_symbol  <= binary_154_655_start; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/$entry
          binary_154_inputs_658: Block -- branch_block_stmt_135/assign_stmt_156/binary_154/binary_154_inputs 
            signal binary_154_inputs_658_start: Boolean;
            signal Xentry_659_symbol: Boolean;
            signal Xexit_660_symbol: Boolean;
            -- 
          begin -- 
            binary_154_inputs_658_start <= Xentry_656_symbol; -- control passed to block
            Xentry_659_symbol  <= binary_154_inputs_658_start; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/binary_154_inputs/$entry
            Xexit_660_symbol <= Xentry_659_symbol; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/binary_154_inputs/$exit
            binary_154_inputs_658_symbol <= Xexit_660_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_156/binary_154/binary_154_inputs
          rr_661_symbol <= binary_154_inputs_658_symbol; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/rr
          binary_154_inst_req_0 <= rr_661_symbol; -- link to DP
          ra_662_symbol <= binary_154_inst_ack_0; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/ra
          cr_663_symbol <= ra_662_symbol; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/cr
          binary_154_inst_req_1 <= cr_663_symbol; -- link to DP
          ca_664_symbol <= binary_154_inst_ack_1; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/ca
          Xexit_657_symbol <= ca_664_symbol; -- transition branch_block_stmt_135/assign_stmt_156/binary_154/$exit
          binary_154_655_symbol <= Xexit_657_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_156/binary_154
        Xexit_654_symbol <= binary_154_655_symbol; -- transition branch_block_stmt_135/assign_stmt_156/$exit
        assign_stmt_156_652_symbol <= Xexit_654_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_156
      if_stmt_157_eval_test_665: Block -- branch_block_stmt_135/if_stmt_157_eval_test 
        signal if_stmt_157_eval_test_665_start: Boolean;
        signal Xentry_666_symbol: Boolean;
        signal Xexit_667_symbol: Boolean;
        signal branch_req_668_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_eval_test_665_start <= if_stmt_157_x_xentry_x_xx_x558_symbol; -- control passed to block
        Xentry_666_symbol  <= if_stmt_157_eval_test_665_start; -- transition branch_block_stmt_135/if_stmt_157_eval_test/$entry
        branch_req_668_symbol <= Xentry_666_symbol; -- transition branch_block_stmt_135/if_stmt_157_eval_test/branch_req
        if_stmt_157_branch_req_0 <= branch_req_668_symbol; -- link to DP
        Xexit_667_symbol <= branch_req_668_symbol; -- transition branch_block_stmt_135/if_stmt_157_eval_test/$exit
        if_stmt_157_eval_test_665_symbol <= Xexit_667_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_eval_test
      simple_obj_ref_158_place_669_symbol  <=  if_stmt_157_eval_test_665_symbol; -- place branch_block_stmt_135/simple_obj_ref_158_place (optimized away) 
      if_stmt_157_if_link_670: Block -- branch_block_stmt_135/if_stmt_157_if_link 
        signal if_stmt_157_if_link_670_start: Boolean;
        signal Xentry_671_symbol: Boolean;
        signal Xexit_672_symbol: Boolean;
        signal if_choice_transition_673_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_if_link_670_start <= simple_obj_ref_158_place_669_symbol; -- control passed to block
        Xentry_671_symbol  <= if_stmt_157_if_link_670_start; -- transition branch_block_stmt_135/if_stmt_157_if_link/$entry
        if_choice_transition_673_symbol <= if_stmt_157_branch_ack_1; -- transition branch_block_stmt_135/if_stmt_157_if_link/if_choice_transition
        Xexit_672_symbol <= if_choice_transition_673_symbol; -- transition branch_block_stmt_135/if_stmt_157_if_link/$exit
        if_stmt_157_if_link_670_symbol <= Xexit_672_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_if_link
      if_stmt_157_else_link_674: Block -- branch_block_stmt_135/if_stmt_157_else_link 
        signal if_stmt_157_else_link_674_start: Boolean;
        signal Xentry_675_symbol: Boolean;
        signal Xexit_676_symbol: Boolean;
        signal else_choice_transition_677_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_157_else_link_674_start <= simple_obj_ref_158_place_669_symbol; -- control passed to block
        Xentry_675_symbol  <= if_stmt_157_else_link_674_start; -- transition branch_block_stmt_135/if_stmt_157_else_link/$entry
        else_choice_transition_677_symbol <= if_stmt_157_branch_ack_0; -- transition branch_block_stmt_135/if_stmt_157_else_link/else_choice_transition
        Xexit_676_symbol <= else_choice_transition_677_symbol; -- transition branch_block_stmt_135/if_stmt_157_else_link/$exit
        if_stmt_157_else_link_674_symbol <= Xexit_676_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/if_stmt_157_else_link
      bb_0_bb_1_678_symbol  <=  if_stmt_157_if_link_670_symbol; -- place branch_block_stmt_135/bb_0_bb_1 (optimized away) 
      bb_0_bb_2_679_symbol  <=  if_stmt_157_else_link_674_symbol; -- place branch_block_stmt_135/bb_0_bb_2 (optimized away) 
      assign_stmt_166_680: Block -- branch_block_stmt_135/assign_stmt_166 
        signal assign_stmt_166_680_start: Boolean;
        signal Xentry_681_symbol: Boolean;
        signal Xexit_682_symbol: Boolean;
        signal simple_obj_ref_164_683_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_166_680_start <= assign_stmt_166_x_xentry_x_xx_x560_symbol; -- control passed to block
        Xentry_681_symbol  <= assign_stmt_166_680_start; -- transition branch_block_stmt_135/assign_stmt_166/$entry
        simple_obj_ref_164_683: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164 
          signal simple_obj_ref_164_683_start: Boolean;
          signal Xentry_684_symbol: Boolean;
          signal Xexit_685_symbol: Boolean;
          signal simple_obj_ref_164_write_686_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_164_683_start <= Xentry_681_symbol; -- control passed to block
          Xentry_684_symbol  <= simple_obj_ref_164_683_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/$entry
          simple_obj_ref_164_write_686: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write 
            signal simple_obj_ref_164_write_686_start: Boolean;
            signal Xentry_687_symbol: Boolean;
            signal Xexit_688_symbol: Boolean;
            signal split_req_689_symbol : Boolean;
            signal split_ack_690_symbol : Boolean;
            signal word_access_691_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_164_write_686_start <= Xentry_684_symbol; -- control passed to block
            Xentry_687_symbol  <= simple_obj_ref_164_write_686_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/$entry
            split_req_689_symbol <= Xentry_687_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/split_req
            simple_obj_ref_164_gather_scatter_req_0 <= split_req_689_symbol; -- link to DP
            split_ack_690_symbol <= simple_obj_ref_164_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/split_ack
            word_access_691: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access 
              signal word_access_691_start: Boolean;
              signal Xentry_692_symbol: Boolean;
              signal Xexit_693_symbol: Boolean;
              signal word_access_0_694_symbol : Boolean;
              -- 
            begin -- 
              word_access_691_start <= split_ack_690_symbol; -- control passed to block
              Xentry_692_symbol  <= word_access_691_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/$entry
              word_access_0_694: Block -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0 
                signal word_access_0_694_start: Boolean;
                signal Xentry_695_symbol: Boolean;
                signal Xexit_696_symbol: Boolean;
                signal rr_697_symbol : Boolean;
                signal ra_698_symbol : Boolean;
                signal cr_699_symbol : Boolean;
                signal ca_700_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_694_start <= Xentry_692_symbol; -- control passed to block
                Xentry_695_symbol  <= word_access_0_694_start; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0/$entry
                rr_697_symbol <= Xentry_695_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0/rr
                simple_obj_ref_164_store_0_req_0 <= rr_697_symbol; -- link to DP
                ra_698_symbol <= simple_obj_ref_164_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0/ra
                cr_699_symbol <= ra_698_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0/cr
                simple_obj_ref_164_store_0_req_1 <= cr_699_symbol; -- link to DP
                ca_700_symbol <= simple_obj_ref_164_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0/ca
                Xexit_696_symbol <= ca_700_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0/$exit
                word_access_0_694_symbol <= Xexit_696_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/word_access_0
              Xexit_693_symbol <= word_access_0_694_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access/$exit
              word_access_691_symbol <= Xexit_693_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/word_access
            Xexit_688_symbol <= word_access_691_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write/$exit
            simple_obj_ref_164_write_686_symbol <= Xexit_688_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/simple_obj_ref_164_write
          Xexit_685_symbol <= simple_obj_ref_164_write_686_symbol; -- transition branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164/$exit
          simple_obj_ref_164_683_symbol <= Xexit_685_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_166/simple_obj_ref_164
        Xexit_682_symbol <= simple_obj_ref_164_683_symbol; -- transition branch_block_stmt_135/assign_stmt_166/$exit
        assign_stmt_166_680_symbol <= Xexit_682_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_166
      assign_stmt_171_701: Block -- branch_block_stmt_135/assign_stmt_171 
        signal assign_stmt_171_701_start: Boolean;
        signal Xentry_702_symbol: Boolean;
        signal Xexit_703_symbol: Boolean;
        signal simple_obj_ref_169_704_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_171_701_start <= assign_stmt_171_x_xentry_x_xx_x563_symbol; -- control passed to block
        Xentry_702_symbol  <= assign_stmt_171_701_start; -- transition branch_block_stmt_135/assign_stmt_171/$entry
        simple_obj_ref_169_704: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169 
          signal simple_obj_ref_169_704_start: Boolean;
          signal Xentry_705_symbol: Boolean;
          signal Xexit_706_symbol: Boolean;
          signal simple_obj_ref_169_write_707_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_169_704_start <= Xentry_702_symbol; -- control passed to block
          Xentry_705_symbol  <= simple_obj_ref_169_704_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/$entry
          simple_obj_ref_169_write_707: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write 
            signal simple_obj_ref_169_write_707_start: Boolean;
            signal Xentry_708_symbol: Boolean;
            signal Xexit_709_symbol: Boolean;
            signal split_req_710_symbol : Boolean;
            signal split_ack_711_symbol : Boolean;
            signal word_access_712_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_169_write_707_start <= Xentry_705_symbol; -- control passed to block
            Xentry_708_symbol  <= simple_obj_ref_169_write_707_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/$entry
            split_req_710_symbol <= Xentry_708_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/split_req
            simple_obj_ref_169_gather_scatter_req_0 <= split_req_710_symbol; -- link to DP
            split_ack_711_symbol <= simple_obj_ref_169_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/split_ack
            word_access_712: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access 
              signal word_access_712_start: Boolean;
              signal Xentry_713_symbol: Boolean;
              signal Xexit_714_symbol: Boolean;
              signal word_access_0_715_symbol : Boolean;
              -- 
            begin -- 
              word_access_712_start <= split_ack_711_symbol; -- control passed to block
              Xentry_713_symbol  <= word_access_712_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/$entry
              word_access_0_715: Block -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0 
                signal word_access_0_715_start: Boolean;
                signal Xentry_716_symbol: Boolean;
                signal Xexit_717_symbol: Boolean;
                signal rr_718_symbol : Boolean;
                signal ra_719_symbol : Boolean;
                signal cr_720_symbol : Boolean;
                signal ca_721_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_715_start <= Xentry_713_symbol; -- control passed to block
                Xentry_716_symbol  <= word_access_0_715_start; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0/$entry
                rr_718_symbol <= Xentry_716_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0/rr
                simple_obj_ref_169_store_0_req_0 <= rr_718_symbol; -- link to DP
                ra_719_symbol <= simple_obj_ref_169_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0/ra
                cr_720_symbol <= ra_719_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0/cr
                simple_obj_ref_169_store_0_req_1 <= cr_720_symbol; -- link to DP
                ca_721_symbol <= simple_obj_ref_169_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0/ca
                Xexit_717_symbol <= ca_721_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0/$exit
                word_access_0_715_symbol <= Xexit_717_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/word_access_0
              Xexit_714_symbol <= word_access_0_715_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access/$exit
              word_access_712_symbol <= Xexit_714_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/word_access
            Xexit_709_symbol <= word_access_712_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write/$exit
            simple_obj_ref_169_write_707_symbol <= Xexit_709_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/simple_obj_ref_169_write
          Xexit_706_symbol <= simple_obj_ref_169_write_707_symbol; -- transition branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169/$exit
          simple_obj_ref_169_704_symbol <= Xexit_706_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_171/simple_obj_ref_169
        Xexit_703_symbol <= simple_obj_ref_169_704_symbol; -- transition branch_block_stmt_135/assign_stmt_171/$exit
        assign_stmt_171_701_symbol <= Xexit_703_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_171
      assign_stmt_176_722: Block -- branch_block_stmt_135/assign_stmt_176 
        signal assign_stmt_176_722_start: Boolean;
        signal Xentry_723_symbol: Boolean;
        signal Xexit_724_symbol: Boolean;
        signal simple_obj_ref_175_725_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_176_722_start <= assign_stmt_176_x_xentry_x_xx_x566_symbol; -- control passed to block
        Xentry_723_symbol  <= assign_stmt_176_722_start; -- transition branch_block_stmt_135/assign_stmt_176/$entry
        simple_obj_ref_175_725: Block -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175 
          signal simple_obj_ref_175_725_start: Boolean;
          signal Xentry_726_symbol: Boolean;
          signal Xexit_727_symbol: Boolean;
          signal simple_obj_ref_175_read_728_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_175_725_start <= Xentry_723_symbol; -- control passed to block
          Xentry_726_symbol  <= simple_obj_ref_175_725_start; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/$entry
          simple_obj_ref_175_read_728: Block -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read 
            signal simple_obj_ref_175_read_728_start: Boolean;
            signal Xentry_729_symbol: Boolean;
            signal Xexit_730_symbol: Boolean;
            signal word_access_731_symbol : Boolean;
            signal merge_req_741_symbol : Boolean;
            signal merge_ack_742_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_175_read_728_start <= Xentry_726_symbol; -- control passed to block
            Xentry_729_symbol  <= simple_obj_ref_175_read_728_start; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/$entry
            word_access_731: Block -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access 
              signal word_access_731_start: Boolean;
              signal Xentry_732_symbol: Boolean;
              signal Xexit_733_symbol: Boolean;
              signal word_access_0_734_symbol : Boolean;
              -- 
            begin -- 
              word_access_731_start <= Xentry_729_symbol; -- control passed to block
              Xentry_732_symbol  <= word_access_731_start; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/$entry
              word_access_0_734: Block -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0 
                signal word_access_0_734_start: Boolean;
                signal Xentry_735_symbol: Boolean;
                signal Xexit_736_symbol: Boolean;
                signal rr_737_symbol : Boolean;
                signal ra_738_symbol : Boolean;
                signal cr_739_symbol : Boolean;
                signal ca_740_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_734_start <= Xentry_732_symbol; -- control passed to block
                Xentry_735_symbol  <= word_access_0_734_start; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0/$entry
                rr_737_symbol <= Xentry_735_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0/rr
                simple_obj_ref_175_load_0_req_0 <= rr_737_symbol; -- link to DP
                ra_738_symbol <= simple_obj_ref_175_load_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0/ra
                cr_739_symbol <= ra_738_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0/cr
                simple_obj_ref_175_load_0_req_1 <= cr_739_symbol; -- link to DP
                ca_740_symbol <= simple_obj_ref_175_load_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0/ca
                Xexit_736_symbol <= ca_740_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0/$exit
                word_access_0_734_symbol <= Xexit_736_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/word_access_0
              Xexit_733_symbol <= word_access_0_734_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access/$exit
              word_access_731_symbol <= Xexit_733_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/word_access
            merge_req_741_symbol <= word_access_731_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/merge_req
            simple_obj_ref_175_gather_scatter_req_0 <= merge_req_741_symbol; -- link to DP
            merge_ack_742_symbol <= simple_obj_ref_175_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/merge_ack
            Xexit_730_symbol <= merge_ack_742_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read/$exit
            simple_obj_ref_175_read_728_symbol <= Xexit_730_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/simple_obj_ref_175_read
          Xexit_727_symbol <= simple_obj_ref_175_read_728_symbol; -- transition branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175/$exit
          simple_obj_ref_175_725_symbol <= Xexit_727_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_176/simple_obj_ref_175
        Xexit_724_symbol <= simple_obj_ref_175_725_symbol; -- transition branch_block_stmt_135/assign_stmt_176/$exit
        assign_stmt_176_722_symbol <= Xexit_724_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_176
      assign_stmt_179_743: Block -- branch_block_stmt_135/assign_stmt_179 
        signal assign_stmt_179_743_start: Boolean;
        signal Xentry_744_symbol: Boolean;
        signal Xexit_745_symbol: Boolean;
        signal simple_obj_ref_177_746_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_179_743_start <= assign_stmt_179_x_xentry_x_xx_x568_symbol; -- control passed to block
        Xentry_744_symbol  <= assign_stmt_179_743_start; -- transition branch_block_stmt_135/assign_stmt_179/$entry
        simple_obj_ref_177_746: Block -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177 
          signal simple_obj_ref_177_746_start: Boolean;
          signal Xentry_747_symbol: Boolean;
          signal Xexit_748_symbol: Boolean;
          signal simple_obj_ref_177_write_749_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_177_746_start <= Xentry_744_symbol; -- control passed to block
          Xentry_747_symbol  <= simple_obj_ref_177_746_start; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/$entry
          simple_obj_ref_177_write_749: Block -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write 
            signal simple_obj_ref_177_write_749_start: Boolean;
            signal Xentry_750_symbol: Boolean;
            signal Xexit_751_symbol: Boolean;
            signal split_req_752_symbol : Boolean;
            signal split_ack_753_symbol : Boolean;
            signal word_access_754_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_177_write_749_start <= Xentry_747_symbol; -- control passed to block
            Xentry_750_symbol  <= simple_obj_ref_177_write_749_start; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/$entry
            split_req_752_symbol <= Xentry_750_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/split_req
            simple_obj_ref_177_gather_scatter_req_0 <= split_req_752_symbol; -- link to DP
            split_ack_753_symbol <= simple_obj_ref_177_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/split_ack
            word_access_754: Block -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access 
              signal word_access_754_start: Boolean;
              signal Xentry_755_symbol: Boolean;
              signal Xexit_756_symbol: Boolean;
              signal word_access_0_757_symbol : Boolean;
              -- 
            begin -- 
              word_access_754_start <= split_ack_753_symbol; -- control passed to block
              Xentry_755_symbol  <= word_access_754_start; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/$entry
              word_access_0_757: Block -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0 
                signal word_access_0_757_start: Boolean;
                signal Xentry_758_symbol: Boolean;
                signal Xexit_759_symbol: Boolean;
                signal rr_760_symbol : Boolean;
                signal ra_761_symbol : Boolean;
                signal cr_762_symbol : Boolean;
                signal ca_763_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_757_start <= Xentry_755_symbol; -- control passed to block
                Xentry_758_symbol  <= word_access_0_757_start; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0/$entry
                rr_760_symbol <= Xentry_758_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0/rr
                simple_obj_ref_177_store_0_req_0 <= rr_760_symbol; -- link to DP
                ra_761_symbol <= simple_obj_ref_177_store_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0/ra
                cr_762_symbol <= ra_761_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0/cr
                simple_obj_ref_177_store_0_req_1 <= cr_762_symbol; -- link to DP
                ca_763_symbol <= simple_obj_ref_177_store_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0/ca
                Xexit_759_symbol <= ca_763_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0/$exit
                word_access_0_757_symbol <= Xexit_759_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/word_access_0
              Xexit_756_symbol <= word_access_0_757_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access/$exit
              word_access_754_symbol <= Xexit_756_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/word_access
            Xexit_751_symbol <= word_access_754_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write/$exit
            simple_obj_ref_177_write_749_symbol <= Xexit_751_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/simple_obj_ref_177_write
          Xexit_748_symbol <= simple_obj_ref_177_write_749_symbol; -- transition branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177/$exit
          simple_obj_ref_177_746_symbol <= Xexit_748_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_179/simple_obj_ref_177
        Xexit_745_symbol <= simple_obj_ref_177_746_symbol; -- transition branch_block_stmt_135/assign_stmt_179/$exit
        assign_stmt_179_743_symbol <= Xexit_745_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_179
      assign_stmt_184_764: Block -- branch_block_stmt_135/assign_stmt_184 
        signal assign_stmt_184_764_start: Boolean;
        signal Xentry_765_symbol: Boolean;
        signal Xexit_766_symbol: Boolean;
        signal simple_obj_ref_183_767_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_184_764_start <= assign_stmt_184_x_xentry_x_xx_x571_symbol; -- control passed to block
        Xentry_765_symbol  <= assign_stmt_184_764_start; -- transition branch_block_stmt_135/assign_stmt_184/$entry
        simple_obj_ref_183_767: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183 
          signal simple_obj_ref_183_767_start: Boolean;
          signal Xentry_768_symbol: Boolean;
          signal Xexit_769_symbol: Boolean;
          signal simple_obj_ref_183_read_770_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_183_767_start <= Xentry_765_symbol; -- control passed to block
          Xentry_768_symbol  <= simple_obj_ref_183_767_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/$entry
          simple_obj_ref_183_read_770: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read 
            signal simple_obj_ref_183_read_770_start: Boolean;
            signal Xentry_771_symbol: Boolean;
            signal Xexit_772_symbol: Boolean;
            signal word_access_773_symbol : Boolean;
            signal merge_req_783_symbol : Boolean;
            signal merge_ack_784_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_183_read_770_start <= Xentry_768_symbol; -- control passed to block
            Xentry_771_symbol  <= simple_obj_ref_183_read_770_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/$entry
            word_access_773: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access 
              signal word_access_773_start: Boolean;
              signal Xentry_774_symbol: Boolean;
              signal Xexit_775_symbol: Boolean;
              signal word_access_0_776_symbol : Boolean;
              -- 
            begin -- 
              word_access_773_start <= Xentry_771_symbol; -- control passed to block
              Xentry_774_symbol  <= word_access_773_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/$entry
              word_access_0_776: Block -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0 
                signal word_access_0_776_start: Boolean;
                signal Xentry_777_symbol: Boolean;
                signal Xexit_778_symbol: Boolean;
                signal rr_779_symbol : Boolean;
                signal ra_780_symbol : Boolean;
                signal cr_781_symbol : Boolean;
                signal ca_782_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_776_start <= Xentry_774_symbol; -- control passed to block
                Xentry_777_symbol  <= word_access_0_776_start; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0/$entry
                rr_779_symbol <= Xentry_777_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0/rr
                simple_obj_ref_183_load_0_req_0 <= rr_779_symbol; -- link to DP
                ra_780_symbol <= simple_obj_ref_183_load_0_ack_0; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0/ra
                cr_781_symbol <= ra_780_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0/cr
                simple_obj_ref_183_load_0_req_1 <= cr_781_symbol; -- link to DP
                ca_782_symbol <= simple_obj_ref_183_load_0_ack_1; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0/ca
                Xexit_778_symbol <= ca_782_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0/$exit
                word_access_0_776_symbol <= Xexit_778_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/word_access_0
              Xexit_775_symbol <= word_access_0_776_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access/$exit
              word_access_773_symbol <= Xexit_775_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/word_access
            merge_req_783_symbol <= word_access_773_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/merge_req
            simple_obj_ref_183_gather_scatter_req_0 <= merge_req_783_symbol; -- link to DP
            merge_ack_784_symbol <= simple_obj_ref_183_gather_scatter_ack_0; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/merge_ack
            Xexit_772_symbol <= merge_ack_784_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read/$exit
            simple_obj_ref_183_read_770_symbol <= Xexit_772_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/simple_obj_ref_183_read
          Xexit_769_symbol <= simple_obj_ref_183_read_770_symbol; -- transition branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183/$exit
          simple_obj_ref_183_767_symbol <= Xexit_769_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_135/assign_stmt_184/simple_obj_ref_183
        Xexit_766_symbol <= simple_obj_ref_183_767_symbol; -- transition branch_block_stmt_135/assign_stmt_184/$exit
        assign_stmt_184_764_symbol <= Xexit_766_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/assign_stmt_184
      bb_0_bb_1_PhiReq_785: Block -- branch_block_stmt_135/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_785_start: Boolean;
        signal Xentry_786_symbol: Boolean;
        signal Xexit_787_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_785_start <= bb_0_bb_1_678_symbol; -- control passed to block
        Xentry_786_symbol  <= bb_0_bb_1_PhiReq_785_start; -- transition branch_block_stmt_135/bb_0_bb_1_PhiReq/$entry
        Xexit_787_symbol <= Xentry_786_symbol; -- transition branch_block_stmt_135/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_785_symbol <= Xexit_787_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_0_bb_1_PhiReq
      merge_stmt_163_PhiReqMerge_788_symbol  <=  bb_0_bb_1_PhiReq_785_symbol; -- place branch_block_stmt_135/merge_stmt_163_PhiReqMerge (optimized away) 
      merge_stmt_163_PhiAck_789: Block -- branch_block_stmt_135/merge_stmt_163_PhiAck 
        signal merge_stmt_163_PhiAck_789_start: Boolean;
        signal Xentry_790_symbol: Boolean;
        signal Xexit_791_symbol: Boolean;
        signal dummy_792_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_163_PhiAck_789_start <= merge_stmt_163_PhiReqMerge_788_symbol; -- control passed to block
        Xentry_790_symbol  <= merge_stmt_163_PhiAck_789_start; -- transition branch_block_stmt_135/merge_stmt_163_PhiAck/$entry
        dummy_792_symbol <= Xentry_790_symbol; -- transition branch_block_stmt_135/merge_stmt_163_PhiAck/dummy
        Xexit_791_symbol <= dummy_792_symbol; -- transition branch_block_stmt_135/merge_stmt_163_PhiAck/$exit
        merge_stmt_163_PhiAck_789_symbol <= Xexit_791_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_163_PhiAck
      bb_0_bb_2_PhiReq_793: Block -- branch_block_stmt_135/bb_0_bb_2_PhiReq 
        signal bb_0_bb_2_PhiReq_793_start: Boolean;
        signal Xentry_794_symbol: Boolean;
        signal Xexit_795_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_2_PhiReq_793_start <= bb_0_bb_2_679_symbol; -- control passed to block
        Xentry_794_symbol  <= bb_0_bb_2_PhiReq_793_start; -- transition branch_block_stmt_135/bb_0_bb_2_PhiReq/$entry
        Xexit_795_symbol <= Xentry_794_symbol; -- transition branch_block_stmt_135/bb_0_bb_2_PhiReq/$exit
        bb_0_bb_2_PhiReq_793_symbol <= Xexit_795_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_0_bb_2_PhiReq
      merge_stmt_168_PhiReqMerge_796_symbol  <=  bb_0_bb_2_PhiReq_793_symbol; -- place branch_block_stmt_135/merge_stmt_168_PhiReqMerge (optimized away) 
      merge_stmt_168_PhiAck_797: Block -- branch_block_stmt_135/merge_stmt_168_PhiAck 
        signal merge_stmt_168_PhiAck_797_start: Boolean;
        signal Xentry_798_symbol: Boolean;
        signal Xexit_799_symbol: Boolean;
        signal dummy_800_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_168_PhiAck_797_start <= merge_stmt_168_PhiReqMerge_796_symbol; -- control passed to block
        Xentry_798_symbol  <= merge_stmt_168_PhiAck_797_start; -- transition branch_block_stmt_135/merge_stmt_168_PhiAck/$entry
        dummy_800_symbol <= Xentry_798_symbol; -- transition branch_block_stmt_135/merge_stmt_168_PhiAck/dummy
        Xexit_799_symbol <= dummy_800_symbol; -- transition branch_block_stmt_135/merge_stmt_168_PhiAck/$exit
        merge_stmt_168_PhiAck_797_symbol <= Xexit_799_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_168_PhiAck
      bb_1_bb_3_PhiReq_801: Block -- branch_block_stmt_135/bb_1_bb_3_PhiReq 
        signal bb_1_bb_3_PhiReq_801_start: Boolean;
        signal Xentry_802_symbol: Boolean;
        signal Xexit_803_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_3_PhiReq_801_start <= bb_1_bb_3_573_symbol; -- control passed to block
        Xentry_802_symbol  <= bb_1_bb_3_PhiReq_801_start; -- transition branch_block_stmt_135/bb_1_bb_3_PhiReq/$entry
        Xexit_803_symbol <= Xentry_802_symbol; -- transition branch_block_stmt_135/bb_1_bb_3_PhiReq/$exit
        bb_1_bb_3_PhiReq_801_symbol <= Xexit_803_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_1_bb_3_PhiReq
      bb_2_bb_3_PhiReq_804: Block -- branch_block_stmt_135/bb_2_bb_3_PhiReq 
        signal bb_2_bb_3_PhiReq_804_start: Boolean;
        signal Xentry_805_symbol: Boolean;
        signal Xexit_806_symbol: Boolean;
        -- 
      begin -- 
        bb_2_bb_3_PhiReq_804_start <= bb_2_bb_3_574_symbol; -- control passed to block
        Xentry_805_symbol  <= bb_2_bb_3_PhiReq_804_start; -- transition branch_block_stmt_135/bb_2_bb_3_PhiReq/$entry
        Xexit_806_symbol <= Xentry_805_symbol; -- transition branch_block_stmt_135/bb_2_bb_3_PhiReq/$exit
        bb_2_bb_3_PhiReq_804_symbol <= Xexit_806_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/bb_2_bb_3_PhiReq
      merge_stmt_173_PhiReqMerge_807_symbol  <=  bb_1_bb_3_PhiReq_801_symbol or bb_2_bb_3_PhiReq_804_symbol; -- place branch_block_stmt_135/merge_stmt_173_PhiReqMerge (optimized away) 
      merge_stmt_173_PhiAck_808: Block -- branch_block_stmt_135/merge_stmt_173_PhiAck 
        signal merge_stmt_173_PhiAck_808_start: Boolean;
        signal Xentry_809_symbol: Boolean;
        signal Xexit_810_symbol: Boolean;
        signal dummy_811_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_173_PhiAck_808_start <= merge_stmt_173_PhiReqMerge_807_symbol; -- control passed to block
        Xentry_809_symbol  <= merge_stmt_173_PhiAck_808_start; -- transition branch_block_stmt_135/merge_stmt_173_PhiAck/$entry
        dummy_811_symbol <= Xentry_809_symbol; -- transition branch_block_stmt_135/merge_stmt_173_PhiAck/dummy
        Xexit_810_symbol <= dummy_811_symbol; -- transition branch_block_stmt_135/merge_stmt_173_PhiAck/$exit
        merge_stmt_173_PhiAck_808_symbol <= Xexit_810_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_173_PhiAck
      return_x_xx_xPhiReq_812: Block -- branch_block_stmt_135/return___PhiReq 
        signal return_x_xx_xPhiReq_812_start: Boolean;
        signal Xentry_813_symbol: Boolean;
        signal Xexit_814_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_812_start <= return_x_xx_x575_symbol; -- control passed to block
        Xentry_813_symbol  <= return_x_xx_xPhiReq_812_start; -- transition branch_block_stmt_135/return___PhiReq/$entry
        Xexit_814_symbol <= Xentry_813_symbol; -- transition branch_block_stmt_135/return___PhiReq/$exit
        return_x_xx_xPhiReq_812_symbol <= Xexit_814_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/return___PhiReq
      merge_stmt_181_PhiReqMerge_815_symbol  <=  return_x_xx_xPhiReq_812_symbol; -- place branch_block_stmt_135/merge_stmt_181_PhiReqMerge (optimized away) 
      merge_stmt_181_PhiAck_816: Block -- branch_block_stmt_135/merge_stmt_181_PhiAck 
        signal merge_stmt_181_PhiAck_816_start: Boolean;
        signal Xentry_817_symbol: Boolean;
        signal Xexit_818_symbol: Boolean;
        signal dummy_819_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_181_PhiAck_816_start <= merge_stmt_181_PhiReqMerge_815_symbol; -- control passed to block
        Xentry_817_symbol  <= merge_stmt_181_PhiAck_816_start; -- transition branch_block_stmt_135/merge_stmt_181_PhiAck/$entry
        dummy_819_symbol <= Xentry_817_symbol; -- transition branch_block_stmt_135/merge_stmt_181_PhiAck/dummy
        Xexit_818_symbol <= dummy_819_symbol; -- transition branch_block_stmt_135/merge_stmt_181_PhiAck/$exit
        merge_stmt_181_PhiAck_816_symbol <= Xexit_818_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_135/merge_stmt_181_PhiAck
      Xexit_545_symbol <= branch_block_stmt_135_x_xexit_x_xx_x547_symbol; -- transition branch_block_stmt_135/$exit
      branch_block_stmt_135_543_symbol <= Xexit_545_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_135
    Xexit_542_symbol <= branch_block_stmt_135_543_symbol; -- transition $exit
    fin  <=  '1' when Xexit_542_symbol else '0'; -- fin symbol when control-path exits
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
    signal iNsTr_05_176 : std_logic_vector(31 downto 0);
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
    signal xxmainxxmainxxc_base_address : std_logic_vector(0 downto 0);
    signal xxmainxxmainxxiNsTr_0_base_address : std_logic_vector(0 downto 0);
    signal xxmainxxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    expr_139_wire_constant <= "00000000000000000000000000000000";
    expr_141_wire_constant <= "00000000000000000000000000000101";
    expr_142_wire_constant <= "00000000000000000000000000000010";
    expr_153_wire_constant <= "00000000000000000000000000000100";
    expr_165_wire_constant <= "00000000000000000000000000000001";
    expr_170_wire_constant <= "00000000000000000000000000000000";
    simple_obj_ref_138_word_address_0 <= "0";
    simple_obj_ref_145_word_address_0 <= "0";
    simple_obj_ref_149_word_address_0 <= "0";
    simple_obj_ref_164_word_address_0 <= "0";
    simple_obj_ref_169_word_address_0 <= "0";
    simple_obj_ref_175_word_address_0 <= "0";
    simple_obj_ref_177_word_address_0 <= "0";
    simple_obj_ref_183_word_address_0 <= "0";
    xxmainxxmainxxc_base_address <= "0";
    xxmainxxmainxxiNsTr_0_base_address <= "0";
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
      iNsTr_05_176 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_177_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_177_gather_scatter_ack_0 <= simple_obj_ref_177_gather_scatter_req_0;
      aggregated_sig <= iNsTr_05_176;
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
          constant_operand => "00000000000000000000000000000100",
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
    -- shared store operator group (0) : simple_obj_ref_138_store_0 simple_obj_ref_164_store_0 simple_obj_ref_169_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
      signal data_in: std_logic_vector(95 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= simple_obj_ref_138_store_0_req_0;
      reqL(1) <= simple_obj_ref_164_store_0_req_0;
      reqL(0) <= simple_obj_ref_169_store_0_req_0;
      simple_obj_ref_138_store_0_ack_0 <= ackL(2);
      simple_obj_ref_164_store_0_ack_0 <= ackL(1);
      simple_obj_ref_169_store_0_ack_0 <= ackL(0);
      reqR(2) <= simple_obj_ref_138_store_0_req_1;
      reqR(1) <= simple_obj_ref_164_store_0_req_1;
      reqR(0) <= simple_obj_ref_169_store_0_req_1;
      simple_obj_ref_138_store_0_ack_1 <= ackR(2);
      simple_obj_ref_164_store_0_ack_1 <= ackR(1);
      simple_obj_ref_169_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_138_word_address_0 & simple_obj_ref_164_word_address_0 & simple_obj_ref_169_word_address_0;
      data_in <= simple_obj_ref_138_data_0 & simple_obj_ref_164_data_0 & simple_obj_ref_169_data_0;
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
  signal simple_obj_ref_128_load_0_req_0 : boolean;
  signal simple_obj_ref_128_load_0_ack_0 : boolean;
  signal simple_obj_ref_128_load_0_req_1 : boolean;
  signal simple_obj_ref_128_load_0_ack_1 : boolean;
  signal simple_obj_ref_128_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_128_gather_scatter_ack_0 : boolean;
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
  signal memory_space_7_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_7_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_7_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_7_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_7_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_7_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_7_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_7_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_7_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_7_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_7_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_7_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_7_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_7_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_7_sc_ack :  std_logic_vector(0 downto 0);
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
  sub_CP_215: Block -- control-path 
    signal sub_CP_215_start: Boolean;
    signal Xentry_216_symbol: Boolean;
    signal Xexit_217_symbol: Boolean;
    signal branch_block_stmt_57_218_symbol : Boolean;
    -- 
  begin -- 
    sub_CP_215_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_216_symbol  <= sub_CP_215_start; -- transition $entry
    branch_block_stmt_57_218: Block -- branch_block_stmt_57 
      signal branch_block_stmt_57_218_start: Boolean;
      signal Xentry_219_symbol: Boolean;
      signal Xexit_220_symbol: Boolean;
      signal branch_block_stmt_57_x_xentry_x_xx_x221_symbol : Boolean;
      signal branch_block_stmt_57_x_xexit_x_xx_x222_symbol : Boolean;
      signal assign_stmt_63_x_xentry_x_xx_x223_symbol : Boolean;
      signal assign_stmt_63_x_xexit_x_xx_x224_symbol : Boolean;
      signal assign_stmt_66_x_xentry_x_xx_x225_symbol : Boolean;
      signal assign_stmt_66_x_xexit_x_xx_x226_symbol : Boolean;
      signal assign_stmt_69_x_xentry_x_xx_x227_symbol : Boolean;
      signal assign_stmt_69_x_xexit_x_xx_x228_symbol : Boolean;
      signal assign_stmt_74_x_xentry_x_xx_x229_symbol : Boolean;
      signal assign_stmt_74_x_xexit_x_xx_x230_symbol : Boolean;
      signal assign_stmt_78_x_xentry_x_xx_x231_symbol : Boolean;
      signal assign_stmt_78_x_xexit_x_xx_x232_symbol : Boolean;
      signal assign_stmt_81_x_xentry_x_xx_x233_symbol : Boolean;
      signal assign_stmt_81_x_xexit_x_xx_x234_symbol : Boolean;
      signal assign_stmt_86_x_xentry_x_xx_x235_symbol : Boolean;
      signal assign_stmt_86_x_xexit_x_xx_x236_symbol : Boolean;
      signal assign_stmt_90_x_xentry_x_xx_x237_symbol : Boolean;
      signal assign_stmt_90_x_xexit_x_xx_x238_symbol : Boolean;
      signal assign_stmt_95_x_xentry_x_xx_x239_symbol : Boolean;
      signal assign_stmt_95_x_xexit_x_xx_x240_symbol : Boolean;
      signal assign_stmt_99_x_xentry_x_xx_x241_symbol : Boolean;
      signal assign_stmt_99_x_xexit_x_xx_x242_symbol : Boolean;
      signal assign_stmt_104_x_xentry_x_xx_x243_symbol : Boolean;
      signal assign_stmt_104_x_xexit_x_xx_x244_symbol : Boolean;
      signal assign_stmt_108_x_xentry_x_xx_x245_symbol : Boolean;
      signal assign_stmt_108_x_xexit_x_xx_x246_symbol : Boolean;
      signal assign_stmt_113_x_xentry_x_xx_x247_symbol : Boolean;
      signal assign_stmt_113_x_xexit_x_xx_x248_symbol : Boolean;
      signal assign_stmt_117_x_xentry_x_xx_x249_symbol : Boolean;
      signal assign_stmt_117_x_xexit_x_xx_x250_symbol : Boolean;
      signal call_stmt_121_x_xentry_x_xx_x251_symbol : Boolean;
      signal call_stmt_121_x_xexit_x_xx_x252_symbol : Boolean;
      signal assign_stmt_124_x_xentry_x_xx_x253_symbol : Boolean;
      signal assign_stmt_124_x_xexit_x_xx_x254_symbol : Boolean;
      signal merge_stmt_126_x_xexit_x_xx_x255_symbol : Boolean;
      signal assign_stmt_129_x_xentry_x_xx_x256_symbol : Boolean;
      signal assign_stmt_129_x_xexit_x_xx_x257_symbol : Boolean;
      signal return_x_xx_x258_symbol : Boolean;
      signal assign_stmt_63_259_symbol : Boolean;
      signal assign_stmt_66_280_symbol : Boolean;
      signal assign_stmt_69_301_symbol : Boolean;
      signal assign_stmt_74_322_symbol : Boolean;
      signal assign_stmt_78_326_symbol : Boolean;
      signal assign_stmt_81_347_symbol : Boolean;
      signal assign_stmt_86_368_symbol : Boolean;
      signal assign_stmt_90_372_symbol : Boolean;
      signal assign_stmt_95_393_symbol : Boolean;
      signal assign_stmt_99_397_symbol : Boolean;
      signal assign_stmt_104_427_symbol : Boolean;
      signal assign_stmt_108_431_symbol : Boolean;
      signal assign_stmt_113_452_symbol : Boolean;
      signal assign_stmt_117_456_symbol : Boolean;
      signal call_stmt_121_477_symbol : Boolean;
      signal assign_stmt_124_490_symbol : Boolean;
      signal assign_stmt_129_511_symbol : Boolean;
      signal return_x_xx_xPhiReq_532_symbol : Boolean;
      signal merge_stmt_126_PhiReqMerge_535_symbol : Boolean;
      signal merge_stmt_126_PhiAck_536_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_57_218_start <= Xentry_216_symbol; -- control passed to block
      Xentry_219_symbol  <= branch_block_stmt_57_218_start; -- transition branch_block_stmt_57/$entry
      branch_block_stmt_57_x_xentry_x_xx_x221_symbol  <=  Xentry_219_symbol; -- place branch_block_stmt_57/branch_block_stmt_57__entry__ (optimized away) 
      branch_block_stmt_57_x_xexit_x_xx_x222_symbol  <=  assign_stmt_129_x_xexit_x_xx_x257_symbol; -- place branch_block_stmt_57/branch_block_stmt_57__exit__ (optimized away) 
      assign_stmt_63_x_xentry_x_xx_x223_symbol  <=  branch_block_stmt_57_x_xentry_x_xx_x221_symbol; -- place branch_block_stmt_57/assign_stmt_63__entry__ (optimized away) 
      assign_stmt_63_x_xexit_x_xx_x224_symbol  <=  assign_stmt_63_259_symbol; -- place branch_block_stmt_57/assign_stmt_63__exit__ (optimized away) 
      assign_stmt_66_x_xentry_x_xx_x225_symbol  <=  assign_stmt_63_x_xexit_x_xx_x224_symbol; -- place branch_block_stmt_57/assign_stmt_66__entry__ (optimized away) 
      assign_stmt_66_x_xexit_x_xx_x226_symbol  <=  assign_stmt_66_280_symbol; -- place branch_block_stmt_57/assign_stmt_66__exit__ (optimized away) 
      assign_stmt_69_x_xentry_x_xx_x227_symbol  <=  assign_stmt_66_x_xexit_x_xx_x226_symbol; -- place branch_block_stmt_57/assign_stmt_69__entry__ (optimized away) 
      assign_stmt_69_x_xexit_x_xx_x228_symbol  <=  assign_stmt_69_301_symbol; -- place branch_block_stmt_57/assign_stmt_69__exit__ (optimized away) 
      assign_stmt_74_x_xentry_x_xx_x229_symbol  <=  assign_stmt_69_x_xexit_x_xx_x228_symbol; -- place branch_block_stmt_57/assign_stmt_74__entry__ (optimized away) 
      assign_stmt_74_x_xexit_x_xx_x230_symbol  <=  assign_stmt_74_322_symbol; -- place branch_block_stmt_57/assign_stmt_74__exit__ (optimized away) 
      assign_stmt_78_x_xentry_x_xx_x231_symbol  <=  assign_stmt_74_x_xexit_x_xx_x230_symbol; -- place branch_block_stmt_57/assign_stmt_78__entry__ (optimized away) 
      assign_stmt_78_x_xexit_x_xx_x232_symbol  <=  assign_stmt_78_326_symbol; -- place branch_block_stmt_57/assign_stmt_78__exit__ (optimized away) 
      assign_stmt_81_x_xentry_x_xx_x233_symbol  <=  assign_stmt_78_x_xexit_x_xx_x232_symbol; -- place branch_block_stmt_57/assign_stmt_81__entry__ (optimized away) 
      assign_stmt_81_x_xexit_x_xx_x234_symbol  <=  assign_stmt_81_347_symbol; -- place branch_block_stmt_57/assign_stmt_81__exit__ (optimized away) 
      assign_stmt_86_x_xentry_x_xx_x235_symbol  <=  assign_stmt_81_x_xexit_x_xx_x234_symbol; -- place branch_block_stmt_57/assign_stmt_86__entry__ (optimized away) 
      assign_stmt_86_x_xexit_x_xx_x236_symbol  <=  assign_stmt_86_368_symbol; -- place branch_block_stmt_57/assign_stmt_86__exit__ (optimized away) 
      assign_stmt_90_x_xentry_x_xx_x237_symbol  <=  assign_stmt_86_x_xexit_x_xx_x236_symbol; -- place branch_block_stmt_57/assign_stmt_90__entry__ (optimized away) 
      assign_stmt_90_x_xexit_x_xx_x238_symbol  <=  assign_stmt_90_372_symbol; -- place branch_block_stmt_57/assign_stmt_90__exit__ (optimized away) 
      assign_stmt_95_x_xentry_x_xx_x239_symbol  <=  assign_stmt_90_x_xexit_x_xx_x238_symbol; -- place branch_block_stmt_57/assign_stmt_95__entry__ (optimized away) 
      assign_stmt_95_x_xexit_x_xx_x240_symbol  <=  assign_stmt_95_393_symbol; -- place branch_block_stmt_57/assign_stmt_95__exit__ (optimized away) 
      assign_stmt_99_x_xentry_x_xx_x241_symbol  <=  assign_stmt_95_x_xexit_x_xx_x240_symbol; -- place branch_block_stmt_57/assign_stmt_99__entry__ (optimized away) 
      assign_stmt_99_x_xexit_x_xx_x242_symbol  <=  assign_stmt_99_397_symbol; -- place branch_block_stmt_57/assign_stmt_99__exit__ (optimized away) 
      assign_stmt_104_x_xentry_x_xx_x243_symbol  <=  assign_stmt_99_x_xexit_x_xx_x242_symbol; -- place branch_block_stmt_57/assign_stmt_104__entry__ (optimized away) 
      assign_stmt_104_x_xexit_x_xx_x244_symbol  <=  assign_stmt_104_427_symbol; -- place branch_block_stmt_57/assign_stmt_104__exit__ (optimized away) 
      assign_stmt_108_x_xentry_x_xx_x245_symbol  <=  assign_stmt_104_x_xexit_x_xx_x244_symbol; -- place branch_block_stmt_57/assign_stmt_108__entry__ (optimized away) 
      assign_stmt_108_x_xexit_x_xx_x246_symbol  <=  assign_stmt_108_431_symbol; -- place branch_block_stmt_57/assign_stmt_108__exit__ (optimized away) 
      assign_stmt_113_x_xentry_x_xx_x247_symbol  <=  assign_stmt_108_x_xexit_x_xx_x246_symbol; -- place branch_block_stmt_57/assign_stmt_113__entry__ (optimized away) 
      assign_stmt_113_x_xexit_x_xx_x248_symbol  <=  assign_stmt_113_452_symbol; -- place branch_block_stmt_57/assign_stmt_113__exit__ (optimized away) 
      assign_stmt_117_x_xentry_x_xx_x249_symbol  <=  assign_stmt_113_x_xexit_x_xx_x248_symbol; -- place branch_block_stmt_57/assign_stmt_117__entry__ (optimized away) 
      assign_stmt_117_x_xexit_x_xx_x250_symbol  <=  assign_stmt_117_456_symbol; -- place branch_block_stmt_57/assign_stmt_117__exit__ (optimized away) 
      call_stmt_121_x_xentry_x_xx_x251_symbol  <=  assign_stmt_117_x_xexit_x_xx_x250_symbol; -- place branch_block_stmt_57/call_stmt_121__entry__ (optimized away) 
      call_stmt_121_x_xexit_x_xx_x252_symbol  <=  call_stmt_121_477_symbol; -- place branch_block_stmt_57/call_stmt_121__exit__ (optimized away) 
      assign_stmt_124_x_xentry_x_xx_x253_symbol  <=  call_stmt_121_x_xexit_x_xx_x252_symbol; -- place branch_block_stmt_57/assign_stmt_124__entry__ (optimized away) 
      assign_stmt_124_x_xexit_x_xx_x254_symbol  <=  assign_stmt_124_490_symbol; -- place branch_block_stmt_57/assign_stmt_124__exit__ (optimized away) 
      merge_stmt_126_x_xexit_x_xx_x255_symbol  <=  merge_stmt_126_PhiAck_536_symbol; -- place branch_block_stmt_57/merge_stmt_126__exit__ (optimized away) 
      assign_stmt_129_x_xentry_x_xx_x256_symbol  <=  merge_stmt_126_x_xexit_x_xx_x255_symbol; -- place branch_block_stmt_57/assign_stmt_129__entry__ (optimized away) 
      assign_stmt_129_x_xexit_x_xx_x257_symbol  <=  assign_stmt_129_511_symbol; -- place branch_block_stmt_57/assign_stmt_129__exit__ (optimized away) 
      return_x_xx_x258_symbol  <=  assign_stmt_124_x_xexit_x_xx_x254_symbol; -- place branch_block_stmt_57/return__ (optimized away) 
      assign_stmt_63_259: Block -- branch_block_stmt_57/assign_stmt_63 
        signal assign_stmt_63_259_start: Boolean;
        signal Xentry_260_symbol: Boolean;
        signal Xexit_261_symbol: Boolean;
        signal simple_obj_ref_61_262_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_63_259_start <= assign_stmt_63_x_xentry_x_xx_x223_symbol; -- control passed to block
        Xentry_260_symbol  <= assign_stmt_63_259_start; -- transition branch_block_stmt_57/assign_stmt_63/$entry
        simple_obj_ref_61_262: Block -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61 
          signal simple_obj_ref_61_262_start: Boolean;
          signal Xentry_263_symbol: Boolean;
          signal Xexit_264_symbol: Boolean;
          signal simple_obj_ref_61_write_265_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_61_262_start <= Xentry_260_symbol; -- control passed to block
          Xentry_263_symbol  <= simple_obj_ref_61_262_start; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/$entry
          simple_obj_ref_61_write_265: Block -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write 
            signal simple_obj_ref_61_write_265_start: Boolean;
            signal Xentry_266_symbol: Boolean;
            signal Xexit_267_symbol: Boolean;
            signal split_req_268_symbol : Boolean;
            signal split_ack_269_symbol : Boolean;
            signal word_access_270_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_61_write_265_start <= Xentry_263_symbol; -- control passed to block
            Xentry_266_symbol  <= simple_obj_ref_61_write_265_start; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/$entry
            split_req_268_symbol <= Xentry_266_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/split_req
            simple_obj_ref_61_gather_scatter_req_0 <= split_req_268_symbol; -- link to DP
            split_ack_269_symbol <= simple_obj_ref_61_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/split_ack
            word_access_270: Block -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access 
              signal word_access_270_start: Boolean;
              signal Xentry_271_symbol: Boolean;
              signal Xexit_272_symbol: Boolean;
              signal word_access_0_273_symbol : Boolean;
              -- 
            begin -- 
              word_access_270_start <= split_ack_269_symbol; -- control passed to block
              Xentry_271_symbol  <= word_access_270_start; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/$entry
              word_access_0_273: Block -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0 
                signal word_access_0_273_start: Boolean;
                signal Xentry_274_symbol: Boolean;
                signal Xexit_275_symbol: Boolean;
                signal rr_276_symbol : Boolean;
                signal ra_277_symbol : Boolean;
                signal cr_278_symbol : Boolean;
                signal ca_279_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_273_start <= Xentry_271_symbol; -- control passed to block
                Xentry_274_symbol  <= word_access_0_273_start; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0/$entry
                rr_276_symbol <= Xentry_274_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0/rr
                simple_obj_ref_61_store_0_req_0 <= rr_276_symbol; -- link to DP
                ra_277_symbol <= simple_obj_ref_61_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0/ra
                cr_278_symbol <= ra_277_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0/cr
                simple_obj_ref_61_store_0_req_1 <= cr_278_symbol; -- link to DP
                ca_279_symbol <= simple_obj_ref_61_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0/ca
                Xexit_275_symbol <= ca_279_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0/$exit
                word_access_0_273_symbol <= Xexit_275_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/word_access_0
              Xexit_272_symbol <= word_access_0_273_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access/$exit
              word_access_270_symbol <= Xexit_272_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/word_access
            Xexit_267_symbol <= word_access_270_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write/$exit
            simple_obj_ref_61_write_265_symbol <= Xexit_267_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/simple_obj_ref_61_write
          Xexit_264_symbol <= simple_obj_ref_61_write_265_symbol; -- transition branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61/$exit
          simple_obj_ref_61_262_symbol <= Xexit_264_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_63/simple_obj_ref_61
        Xexit_261_symbol <= simple_obj_ref_61_262_symbol; -- transition branch_block_stmt_57/assign_stmt_63/$exit
        assign_stmt_63_259_symbol <= Xexit_261_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_63
      assign_stmt_66_280: Block -- branch_block_stmt_57/assign_stmt_66 
        signal assign_stmt_66_280_start: Boolean;
        signal Xentry_281_symbol: Boolean;
        signal Xexit_282_symbol: Boolean;
        signal simple_obj_ref_64_283_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_66_280_start <= assign_stmt_66_x_xentry_x_xx_x225_symbol; -- control passed to block
        Xentry_281_symbol  <= assign_stmt_66_280_start; -- transition branch_block_stmt_57/assign_stmt_66/$entry
        simple_obj_ref_64_283: Block -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64 
          signal simple_obj_ref_64_283_start: Boolean;
          signal Xentry_284_symbol: Boolean;
          signal Xexit_285_symbol: Boolean;
          signal simple_obj_ref_64_write_286_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_64_283_start <= Xentry_281_symbol; -- control passed to block
          Xentry_284_symbol  <= simple_obj_ref_64_283_start; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/$entry
          simple_obj_ref_64_write_286: Block -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write 
            signal simple_obj_ref_64_write_286_start: Boolean;
            signal Xentry_287_symbol: Boolean;
            signal Xexit_288_symbol: Boolean;
            signal split_req_289_symbol : Boolean;
            signal split_ack_290_symbol : Boolean;
            signal word_access_291_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_64_write_286_start <= Xentry_284_symbol; -- control passed to block
            Xentry_287_symbol  <= simple_obj_ref_64_write_286_start; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/$entry
            split_req_289_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/split_req
            simple_obj_ref_64_gather_scatter_req_0 <= split_req_289_symbol; -- link to DP
            split_ack_290_symbol <= simple_obj_ref_64_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/split_ack
            word_access_291: Block -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access 
              signal word_access_291_start: Boolean;
              signal Xentry_292_symbol: Boolean;
              signal Xexit_293_symbol: Boolean;
              signal word_access_0_294_symbol : Boolean;
              -- 
            begin -- 
              word_access_291_start <= split_ack_290_symbol; -- control passed to block
              Xentry_292_symbol  <= word_access_291_start; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/$entry
              word_access_0_294: Block -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0 
                signal word_access_0_294_start: Boolean;
                signal Xentry_295_symbol: Boolean;
                signal Xexit_296_symbol: Boolean;
                signal rr_297_symbol : Boolean;
                signal ra_298_symbol : Boolean;
                signal cr_299_symbol : Boolean;
                signal ca_300_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_294_start <= Xentry_292_symbol; -- control passed to block
                Xentry_295_symbol  <= word_access_0_294_start; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0/$entry
                rr_297_symbol <= Xentry_295_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0/rr
                simple_obj_ref_64_store_0_req_0 <= rr_297_symbol; -- link to DP
                ra_298_symbol <= simple_obj_ref_64_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0/ra
                cr_299_symbol <= ra_298_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0/cr
                simple_obj_ref_64_store_0_req_1 <= cr_299_symbol; -- link to DP
                ca_300_symbol <= simple_obj_ref_64_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0/ca
                Xexit_296_symbol <= ca_300_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0/$exit
                word_access_0_294_symbol <= Xexit_296_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/word_access_0
              Xexit_293_symbol <= word_access_0_294_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access/$exit
              word_access_291_symbol <= Xexit_293_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/word_access
            Xexit_288_symbol <= word_access_291_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write/$exit
            simple_obj_ref_64_write_286_symbol <= Xexit_288_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/simple_obj_ref_64_write
          Xexit_285_symbol <= simple_obj_ref_64_write_286_symbol; -- transition branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64/$exit
          simple_obj_ref_64_283_symbol <= Xexit_285_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_66/simple_obj_ref_64
        Xexit_282_symbol <= simple_obj_ref_64_283_symbol; -- transition branch_block_stmt_57/assign_stmt_66/$exit
        assign_stmt_66_280_symbol <= Xexit_282_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_66
      assign_stmt_69_301: Block -- branch_block_stmt_57/assign_stmt_69 
        signal assign_stmt_69_301_start: Boolean;
        signal Xentry_302_symbol: Boolean;
        signal Xexit_303_symbol: Boolean;
        signal simple_obj_ref_68_304_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_69_301_start <= assign_stmt_69_x_xentry_x_xx_x227_symbol; -- control passed to block
        Xentry_302_symbol  <= assign_stmt_69_301_start; -- transition branch_block_stmt_57/assign_stmt_69/$entry
        simple_obj_ref_68_304: Block -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68 
          signal simple_obj_ref_68_304_start: Boolean;
          signal Xentry_305_symbol: Boolean;
          signal Xexit_306_symbol: Boolean;
          signal simple_obj_ref_68_read_307_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_68_304_start <= Xentry_302_symbol; -- control passed to block
          Xentry_305_symbol  <= simple_obj_ref_68_304_start; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/$entry
          simple_obj_ref_68_read_307: Block -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read 
            signal simple_obj_ref_68_read_307_start: Boolean;
            signal Xentry_308_symbol: Boolean;
            signal Xexit_309_symbol: Boolean;
            signal word_access_310_symbol : Boolean;
            signal merge_req_320_symbol : Boolean;
            signal merge_ack_321_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_68_read_307_start <= Xentry_305_symbol; -- control passed to block
            Xentry_308_symbol  <= simple_obj_ref_68_read_307_start; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/$entry
            word_access_310: Block -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access 
              signal word_access_310_start: Boolean;
              signal Xentry_311_symbol: Boolean;
              signal Xexit_312_symbol: Boolean;
              signal word_access_0_313_symbol : Boolean;
              -- 
            begin -- 
              word_access_310_start <= Xentry_308_symbol; -- control passed to block
              Xentry_311_symbol  <= word_access_310_start; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/$entry
              word_access_0_313: Block -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0 
                signal word_access_0_313_start: Boolean;
                signal Xentry_314_symbol: Boolean;
                signal Xexit_315_symbol: Boolean;
                signal rr_316_symbol : Boolean;
                signal ra_317_symbol : Boolean;
                signal cr_318_symbol : Boolean;
                signal ca_319_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_313_start <= Xentry_311_symbol; -- control passed to block
                Xentry_314_symbol  <= word_access_0_313_start; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0/$entry
                rr_316_symbol <= Xentry_314_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0/rr
                simple_obj_ref_68_load_0_req_0 <= rr_316_symbol; -- link to DP
                ra_317_symbol <= simple_obj_ref_68_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0/ra
                cr_318_symbol <= ra_317_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0/cr
                simple_obj_ref_68_load_0_req_1 <= cr_318_symbol; -- link to DP
                ca_319_symbol <= simple_obj_ref_68_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0/ca
                Xexit_315_symbol <= ca_319_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0/$exit
                word_access_0_313_symbol <= Xexit_315_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/word_access_0
              Xexit_312_symbol <= word_access_0_313_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access/$exit
              word_access_310_symbol <= Xexit_312_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/word_access
            merge_req_320_symbol <= word_access_310_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/merge_req
            simple_obj_ref_68_gather_scatter_req_0 <= merge_req_320_symbol; -- link to DP
            merge_ack_321_symbol <= simple_obj_ref_68_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/merge_ack
            Xexit_309_symbol <= merge_ack_321_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read/$exit
            simple_obj_ref_68_read_307_symbol <= Xexit_309_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/simple_obj_ref_68_read
          Xexit_306_symbol <= simple_obj_ref_68_read_307_symbol; -- transition branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68/$exit
          simple_obj_ref_68_304_symbol <= Xexit_306_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_69/simple_obj_ref_68
        Xexit_303_symbol <= simple_obj_ref_68_304_symbol; -- transition branch_block_stmt_57/assign_stmt_69/$exit
        assign_stmt_69_301_symbol <= Xexit_303_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_69
      assign_stmt_74_322: Block -- branch_block_stmt_57/assign_stmt_74 
        signal assign_stmt_74_322_start: Boolean;
        signal Xentry_323_symbol: Boolean;
        signal Xexit_324_symbol: Boolean;
        signal dummy_325_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_74_322_start <= assign_stmt_74_x_xentry_x_xx_x229_symbol; -- control passed to block
        Xentry_323_symbol  <= assign_stmt_74_322_start; -- transition branch_block_stmt_57/assign_stmt_74/$entry
        dummy_325_symbol <= Xentry_323_symbol; -- transition branch_block_stmt_57/assign_stmt_74/dummy
        Xexit_324_symbol <= dummy_325_symbol; -- transition branch_block_stmt_57/assign_stmt_74/$exit
        assign_stmt_74_322_symbol <= Xexit_324_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_74
      assign_stmt_78_326: Block -- branch_block_stmt_57/assign_stmt_78 
        signal assign_stmt_78_326_start: Boolean;
        signal Xentry_327_symbol: Boolean;
        signal Xexit_328_symbol: Boolean;
        signal ptr_deref_76_329_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_78_326_start <= assign_stmt_78_x_xentry_x_xx_x231_symbol; -- control passed to block
        Xentry_327_symbol  <= assign_stmt_78_326_start; -- transition branch_block_stmt_57/assign_stmt_78/$entry
        ptr_deref_76_329: Block -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76 
          signal ptr_deref_76_329_start: Boolean;
          signal Xentry_330_symbol: Boolean;
          signal Xexit_331_symbol: Boolean;
          signal ptr_deref_76_write_332_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_76_329_start <= Xentry_327_symbol; -- control passed to block
          Xentry_330_symbol  <= ptr_deref_76_329_start; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/$entry
          ptr_deref_76_write_332: Block -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write 
            signal ptr_deref_76_write_332_start: Boolean;
            signal Xentry_333_symbol: Boolean;
            signal Xexit_334_symbol: Boolean;
            signal split_req_335_symbol : Boolean;
            signal split_ack_336_symbol : Boolean;
            signal word_access_337_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_76_write_332_start <= Xentry_330_symbol; -- control passed to block
            Xentry_333_symbol  <= ptr_deref_76_write_332_start; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/$entry
            split_req_335_symbol <= Xentry_333_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/split_req
            ptr_deref_76_gather_scatter_req_0 <= split_req_335_symbol; -- link to DP
            split_ack_336_symbol <= ptr_deref_76_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/split_ack
            word_access_337: Block -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access 
              signal word_access_337_start: Boolean;
              signal Xentry_338_symbol: Boolean;
              signal Xexit_339_symbol: Boolean;
              signal word_access_0_340_symbol : Boolean;
              -- 
            begin -- 
              word_access_337_start <= split_ack_336_symbol; -- control passed to block
              Xentry_338_symbol  <= word_access_337_start; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/$entry
              word_access_0_340: Block -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0 
                signal word_access_0_340_start: Boolean;
                signal Xentry_341_symbol: Boolean;
                signal Xexit_342_symbol: Boolean;
                signal rr_343_symbol : Boolean;
                signal ra_344_symbol : Boolean;
                signal cr_345_symbol : Boolean;
                signal ca_346_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_340_start <= Xentry_338_symbol; -- control passed to block
                Xentry_341_symbol  <= word_access_0_340_start; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0/$entry
                rr_343_symbol <= Xentry_341_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0/rr
                ptr_deref_76_store_0_req_0 <= rr_343_symbol; -- link to DP
                ra_344_symbol <= ptr_deref_76_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0/ra
                cr_345_symbol <= ra_344_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0/cr
                ptr_deref_76_store_0_req_1 <= cr_345_symbol; -- link to DP
                ca_346_symbol <= ptr_deref_76_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0/ca
                Xexit_342_symbol <= ca_346_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0/$exit
                word_access_0_340_symbol <= Xexit_342_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/word_access_0
              Xexit_339_symbol <= word_access_0_340_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access/$exit
              word_access_337_symbol <= Xexit_339_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/word_access
            Xexit_334_symbol <= word_access_337_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write/$exit
            ptr_deref_76_write_332_symbol <= Xexit_334_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76/ptr_deref_76_write
          Xexit_331_symbol <= ptr_deref_76_write_332_symbol; -- transition branch_block_stmt_57/assign_stmt_78/ptr_deref_76/$exit
          ptr_deref_76_329_symbol <= Xexit_331_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_78/ptr_deref_76
        Xexit_328_symbol <= ptr_deref_76_329_symbol; -- transition branch_block_stmt_57/assign_stmt_78/$exit
        assign_stmt_78_326_symbol <= Xexit_328_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_78
      assign_stmt_81_347: Block -- branch_block_stmt_57/assign_stmt_81 
        signal assign_stmt_81_347_start: Boolean;
        signal Xentry_348_symbol: Boolean;
        signal Xexit_349_symbol: Boolean;
        signal simple_obj_ref_80_350_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_81_347_start <= assign_stmt_81_x_xentry_x_xx_x233_symbol; -- control passed to block
        Xentry_348_symbol  <= assign_stmt_81_347_start; -- transition branch_block_stmt_57/assign_stmt_81/$entry
        simple_obj_ref_80_350: Block -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80 
          signal simple_obj_ref_80_350_start: Boolean;
          signal Xentry_351_symbol: Boolean;
          signal Xexit_352_symbol: Boolean;
          signal simple_obj_ref_80_read_353_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_80_350_start <= Xentry_348_symbol; -- control passed to block
          Xentry_351_symbol  <= simple_obj_ref_80_350_start; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/$entry
          simple_obj_ref_80_read_353: Block -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read 
            signal simple_obj_ref_80_read_353_start: Boolean;
            signal Xentry_354_symbol: Boolean;
            signal Xexit_355_symbol: Boolean;
            signal word_access_356_symbol : Boolean;
            signal merge_req_366_symbol : Boolean;
            signal merge_ack_367_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_80_read_353_start <= Xentry_351_symbol; -- control passed to block
            Xentry_354_symbol  <= simple_obj_ref_80_read_353_start; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/$entry
            word_access_356: Block -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access 
              signal word_access_356_start: Boolean;
              signal Xentry_357_symbol: Boolean;
              signal Xexit_358_symbol: Boolean;
              signal word_access_0_359_symbol : Boolean;
              -- 
            begin -- 
              word_access_356_start <= Xentry_354_symbol; -- control passed to block
              Xentry_357_symbol  <= word_access_356_start; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/$entry
              word_access_0_359: Block -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0 
                signal word_access_0_359_start: Boolean;
                signal Xentry_360_symbol: Boolean;
                signal Xexit_361_symbol: Boolean;
                signal rr_362_symbol : Boolean;
                signal ra_363_symbol : Boolean;
                signal cr_364_symbol : Boolean;
                signal ca_365_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_359_start <= Xentry_357_symbol; -- control passed to block
                Xentry_360_symbol  <= word_access_0_359_start; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0/$entry
                rr_362_symbol <= Xentry_360_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0/rr
                simple_obj_ref_80_load_0_req_0 <= rr_362_symbol; -- link to DP
                ra_363_symbol <= simple_obj_ref_80_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0/ra
                cr_364_symbol <= ra_363_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0/cr
                simple_obj_ref_80_load_0_req_1 <= cr_364_symbol; -- link to DP
                ca_365_symbol <= simple_obj_ref_80_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0/ca
                Xexit_361_symbol <= ca_365_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0/$exit
                word_access_0_359_symbol <= Xexit_361_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/word_access_0
              Xexit_358_symbol <= word_access_0_359_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access/$exit
              word_access_356_symbol <= Xexit_358_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/word_access
            merge_req_366_symbol <= word_access_356_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/merge_req
            simple_obj_ref_80_gather_scatter_req_0 <= merge_req_366_symbol; -- link to DP
            merge_ack_367_symbol <= simple_obj_ref_80_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/merge_ack
            Xexit_355_symbol <= merge_ack_367_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read/$exit
            simple_obj_ref_80_read_353_symbol <= Xexit_355_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/simple_obj_ref_80_read
          Xexit_352_symbol <= simple_obj_ref_80_read_353_symbol; -- transition branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80/$exit
          simple_obj_ref_80_350_symbol <= Xexit_352_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_81/simple_obj_ref_80
        Xexit_349_symbol <= simple_obj_ref_80_350_symbol; -- transition branch_block_stmt_57/assign_stmt_81/$exit
        assign_stmt_81_347_symbol <= Xexit_349_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_81
      assign_stmt_86_368: Block -- branch_block_stmt_57/assign_stmt_86 
        signal assign_stmt_86_368_start: Boolean;
        signal Xentry_369_symbol: Boolean;
        signal Xexit_370_symbol: Boolean;
        signal dummy_371_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_86_368_start <= assign_stmt_86_x_xentry_x_xx_x235_symbol; -- control passed to block
        Xentry_369_symbol  <= assign_stmt_86_368_start; -- transition branch_block_stmt_57/assign_stmt_86/$entry
        dummy_371_symbol <= Xentry_369_symbol; -- transition branch_block_stmt_57/assign_stmt_86/dummy
        Xexit_370_symbol <= dummy_371_symbol; -- transition branch_block_stmt_57/assign_stmt_86/$exit
        assign_stmt_86_368_symbol <= Xexit_370_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_86
      assign_stmt_90_372: Block -- branch_block_stmt_57/assign_stmt_90 
        signal assign_stmt_90_372_start: Boolean;
        signal Xentry_373_symbol: Boolean;
        signal Xexit_374_symbol: Boolean;
        signal ptr_deref_88_375_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_90_372_start <= assign_stmt_90_x_xentry_x_xx_x237_symbol; -- control passed to block
        Xentry_373_symbol  <= assign_stmt_90_372_start; -- transition branch_block_stmt_57/assign_stmt_90/$entry
        ptr_deref_88_375: Block -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88 
          signal ptr_deref_88_375_start: Boolean;
          signal Xentry_376_symbol: Boolean;
          signal Xexit_377_symbol: Boolean;
          signal ptr_deref_88_write_378_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_375_start <= Xentry_373_symbol; -- control passed to block
          Xentry_376_symbol  <= ptr_deref_88_375_start; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/$entry
          ptr_deref_88_write_378: Block -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write 
            signal ptr_deref_88_write_378_start: Boolean;
            signal Xentry_379_symbol: Boolean;
            signal Xexit_380_symbol: Boolean;
            signal split_req_381_symbol : Boolean;
            signal split_ack_382_symbol : Boolean;
            signal word_access_383_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_88_write_378_start <= Xentry_376_symbol; -- control passed to block
            Xentry_379_symbol  <= ptr_deref_88_write_378_start; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/$entry
            split_req_381_symbol <= Xentry_379_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/split_req
            ptr_deref_88_gather_scatter_req_0 <= split_req_381_symbol; -- link to DP
            split_ack_382_symbol <= ptr_deref_88_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/split_ack
            word_access_383: Block -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access 
              signal word_access_383_start: Boolean;
              signal Xentry_384_symbol: Boolean;
              signal Xexit_385_symbol: Boolean;
              signal word_access_0_386_symbol : Boolean;
              -- 
            begin -- 
              word_access_383_start <= split_ack_382_symbol; -- control passed to block
              Xentry_384_symbol  <= word_access_383_start; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/$entry
              word_access_0_386: Block -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0 
                signal word_access_0_386_start: Boolean;
                signal Xentry_387_symbol: Boolean;
                signal Xexit_388_symbol: Boolean;
                signal rr_389_symbol : Boolean;
                signal ra_390_symbol : Boolean;
                signal cr_391_symbol : Boolean;
                signal ca_392_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_386_start <= Xentry_384_symbol; -- control passed to block
                Xentry_387_symbol  <= word_access_0_386_start; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0/$entry
                rr_389_symbol <= Xentry_387_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0/rr
                ptr_deref_88_store_0_req_0 <= rr_389_symbol; -- link to DP
                ra_390_symbol <= ptr_deref_88_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0/ra
                cr_391_symbol <= ra_390_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0/cr
                ptr_deref_88_store_0_req_1 <= cr_391_symbol; -- link to DP
                ca_392_symbol <= ptr_deref_88_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0/ca
                Xexit_388_symbol <= ca_392_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0/$exit
                word_access_0_386_symbol <= Xexit_388_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/word_access_0
              Xexit_385_symbol <= word_access_0_386_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access/$exit
              word_access_383_symbol <= Xexit_385_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/word_access
            Xexit_380_symbol <= word_access_383_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write/$exit
            ptr_deref_88_write_378_symbol <= Xexit_380_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88/ptr_deref_88_write
          Xexit_377_symbol <= ptr_deref_88_write_378_symbol; -- transition branch_block_stmt_57/assign_stmt_90/ptr_deref_88/$exit
          ptr_deref_88_375_symbol <= Xexit_377_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_90/ptr_deref_88
        Xexit_374_symbol <= ptr_deref_88_375_symbol; -- transition branch_block_stmt_57/assign_stmt_90/$exit
        assign_stmt_90_372_symbol <= Xexit_374_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_90
      assign_stmt_95_393: Block -- branch_block_stmt_57/assign_stmt_95 
        signal assign_stmt_95_393_start: Boolean;
        signal Xentry_394_symbol: Boolean;
        signal Xexit_395_symbol: Boolean;
        signal dummy_396_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_95_393_start <= assign_stmt_95_x_xentry_x_xx_x239_symbol; -- control passed to block
        Xentry_394_symbol  <= assign_stmt_95_393_start; -- transition branch_block_stmt_57/assign_stmt_95/$entry
        dummy_396_symbol <= Xentry_394_symbol; -- transition branch_block_stmt_57/assign_stmt_95/dummy
        Xexit_395_symbol <= dummy_396_symbol; -- transition branch_block_stmt_57/assign_stmt_95/$exit
        assign_stmt_95_393_symbol <= Xexit_395_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_95
      assign_stmt_99_397: Block -- branch_block_stmt_57/assign_stmt_99 
        signal assign_stmt_99_397_start: Boolean;
        signal Xentry_398_symbol: Boolean;
        signal Xexit_399_symbol: Boolean;
        signal ptr_deref_97_400_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_99_397_start <= assign_stmt_99_x_xentry_x_xx_x241_symbol; -- control passed to block
        Xentry_398_symbol  <= assign_stmt_99_397_start; -- transition branch_block_stmt_57/assign_stmt_99/$entry
        ptr_deref_97_400: Block -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97 
          signal ptr_deref_97_400_start: Boolean;
          signal Xentry_401_symbol: Boolean;
          signal Xexit_402_symbol: Boolean;
          signal ptr_deref_97_addr_gen_403_symbol : Boolean;
          signal ptr_deref_97_write_412_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_97_400_start <= Xentry_398_symbol; -- control passed to block
          Xentry_401_symbol  <= ptr_deref_97_400_start; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/$entry
          ptr_deref_97_addr_gen_403: Block -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen 
            signal ptr_deref_97_addr_gen_403_start: Boolean;
            signal Xentry_404_symbol: Boolean;
            signal Xexit_405_symbol: Boolean;
            signal base_resize_req_406_symbol : Boolean;
            signal base_resize_ack_407_symbol : Boolean;
            signal sum_rename_req_408_symbol : Boolean;
            signal sum_rename_ack_409_symbol : Boolean;
            signal root_rename_req_410_symbol : Boolean;
            signal root_rename_ack_411_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_97_addr_gen_403_start <= Xentry_401_symbol; -- control passed to block
            Xentry_404_symbol  <= ptr_deref_97_addr_gen_403_start; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/$entry
            base_resize_req_406_symbol <= Xentry_404_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/base_resize_req
            ptr_deref_97_base_resize_req_0 <= base_resize_req_406_symbol; -- link to DP
            base_resize_ack_407_symbol <= ptr_deref_97_base_resize_ack_0; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/base_resize_ack
            sum_rename_req_408_symbol <= base_resize_ack_407_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/sum_rename_req
            ptr_deref_97_root_address_inst_req_0 <= sum_rename_req_408_symbol; -- link to DP
            sum_rename_ack_409_symbol <= ptr_deref_97_root_address_inst_ack_0; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/sum_rename_ack
            root_rename_req_410_symbol <= sum_rename_ack_409_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/root_rename_req
            ptr_deref_97_addr_0_req_0 <= root_rename_req_410_symbol; -- link to DP
            root_rename_ack_411_symbol <= ptr_deref_97_addr_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/root_rename_ack
            Xexit_405_symbol <= root_rename_ack_411_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen/$exit
            ptr_deref_97_addr_gen_403_symbol <= Xexit_405_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_addr_gen
          ptr_deref_97_write_412: Block -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write 
            signal ptr_deref_97_write_412_start: Boolean;
            signal Xentry_413_symbol: Boolean;
            signal Xexit_414_symbol: Boolean;
            signal split_req_415_symbol : Boolean;
            signal split_ack_416_symbol : Boolean;
            signal word_access_417_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_97_write_412_start <= ptr_deref_97_addr_gen_403_symbol; -- control passed to block
            Xentry_413_symbol  <= ptr_deref_97_write_412_start; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/$entry
            split_req_415_symbol <= Xentry_413_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/split_req
            ptr_deref_97_gather_scatter_req_0 <= split_req_415_symbol; -- link to DP
            split_ack_416_symbol <= ptr_deref_97_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/split_ack
            word_access_417: Block -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access 
              signal word_access_417_start: Boolean;
              signal Xentry_418_symbol: Boolean;
              signal Xexit_419_symbol: Boolean;
              signal word_access_0_420_symbol : Boolean;
              -- 
            begin -- 
              word_access_417_start <= split_ack_416_symbol; -- control passed to block
              Xentry_418_symbol  <= word_access_417_start; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/$entry
              word_access_0_420: Block -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0 
                signal word_access_0_420_start: Boolean;
                signal Xentry_421_symbol: Boolean;
                signal Xexit_422_symbol: Boolean;
                signal rr_423_symbol : Boolean;
                signal ra_424_symbol : Boolean;
                signal cr_425_symbol : Boolean;
                signal ca_426_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_420_start <= Xentry_418_symbol; -- control passed to block
                Xentry_421_symbol  <= word_access_0_420_start; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0/$entry
                rr_423_symbol <= Xentry_421_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0/rr
                ptr_deref_97_store_0_req_0 <= rr_423_symbol; -- link to DP
                ra_424_symbol <= ptr_deref_97_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0/ra
                cr_425_symbol <= ra_424_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0/cr
                ptr_deref_97_store_0_req_1 <= cr_425_symbol; -- link to DP
                ca_426_symbol <= ptr_deref_97_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0/ca
                Xexit_422_symbol <= ca_426_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0/$exit
                word_access_0_420_symbol <= Xexit_422_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/word_access_0
              Xexit_419_symbol <= word_access_0_420_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access/$exit
              word_access_417_symbol <= Xexit_419_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/word_access
            Xexit_414_symbol <= word_access_417_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write/$exit
            ptr_deref_97_write_412_symbol <= Xexit_414_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97/ptr_deref_97_write
          Xexit_402_symbol <= ptr_deref_97_write_412_symbol; -- transition branch_block_stmt_57/assign_stmt_99/ptr_deref_97/$exit
          ptr_deref_97_400_symbol <= Xexit_402_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_99/ptr_deref_97
        Xexit_399_symbol <= ptr_deref_97_400_symbol; -- transition branch_block_stmt_57/assign_stmt_99/$exit
        assign_stmt_99_397_symbol <= Xexit_399_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_99
      assign_stmt_104_427: Block -- branch_block_stmt_57/assign_stmt_104 
        signal assign_stmt_104_427_start: Boolean;
        signal Xentry_428_symbol: Boolean;
        signal Xexit_429_symbol: Boolean;
        signal dummy_430_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_104_427_start <= assign_stmt_104_x_xentry_x_xx_x243_symbol; -- control passed to block
        Xentry_428_symbol  <= assign_stmt_104_427_start; -- transition branch_block_stmt_57/assign_stmt_104/$entry
        dummy_430_symbol <= Xentry_428_symbol; -- transition branch_block_stmt_57/assign_stmt_104/dummy
        Xexit_429_symbol <= dummy_430_symbol; -- transition branch_block_stmt_57/assign_stmt_104/$exit
        assign_stmt_104_427_symbol <= Xexit_429_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_104
      assign_stmt_108_431: Block -- branch_block_stmt_57/assign_stmt_108 
        signal assign_stmt_108_431_start: Boolean;
        signal Xentry_432_symbol: Boolean;
        signal Xexit_433_symbol: Boolean;
        signal ptr_deref_107_434_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_108_431_start <= assign_stmt_108_x_xentry_x_xx_x245_symbol; -- control passed to block
        Xentry_432_symbol  <= assign_stmt_108_431_start; -- transition branch_block_stmt_57/assign_stmt_108/$entry
        ptr_deref_107_434: Block -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107 
          signal ptr_deref_107_434_start: Boolean;
          signal Xentry_435_symbol: Boolean;
          signal Xexit_436_symbol: Boolean;
          signal ptr_deref_107_read_437_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_107_434_start <= Xentry_432_symbol; -- control passed to block
          Xentry_435_symbol  <= ptr_deref_107_434_start; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/$entry
          ptr_deref_107_read_437: Block -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read 
            signal ptr_deref_107_read_437_start: Boolean;
            signal Xentry_438_symbol: Boolean;
            signal Xexit_439_symbol: Boolean;
            signal word_access_440_symbol : Boolean;
            signal merge_req_450_symbol : Boolean;
            signal merge_ack_451_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_107_read_437_start <= Xentry_435_symbol; -- control passed to block
            Xentry_438_symbol  <= ptr_deref_107_read_437_start; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/$entry
            word_access_440: Block -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access 
              signal word_access_440_start: Boolean;
              signal Xentry_441_symbol: Boolean;
              signal Xexit_442_symbol: Boolean;
              signal word_access_0_443_symbol : Boolean;
              -- 
            begin -- 
              word_access_440_start <= Xentry_438_symbol; -- control passed to block
              Xentry_441_symbol  <= word_access_440_start; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/$entry
              word_access_0_443: Block -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0 
                signal word_access_0_443_start: Boolean;
                signal Xentry_444_symbol: Boolean;
                signal Xexit_445_symbol: Boolean;
                signal rr_446_symbol : Boolean;
                signal ra_447_symbol : Boolean;
                signal cr_448_symbol : Boolean;
                signal ca_449_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_443_start <= Xentry_441_symbol; -- control passed to block
                Xentry_444_symbol  <= word_access_0_443_start; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0/$entry
                rr_446_symbol <= Xentry_444_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0/rr
                ptr_deref_107_load_0_req_0 <= rr_446_symbol; -- link to DP
                ra_447_symbol <= ptr_deref_107_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0/ra
                cr_448_symbol <= ra_447_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0/cr
                ptr_deref_107_load_0_req_1 <= cr_448_symbol; -- link to DP
                ca_449_symbol <= ptr_deref_107_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0/ca
                Xexit_445_symbol <= ca_449_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0/$exit
                word_access_0_443_symbol <= Xexit_445_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/word_access_0
              Xexit_442_symbol <= word_access_0_443_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access/$exit
              word_access_440_symbol <= Xexit_442_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/word_access
            merge_req_450_symbol <= word_access_440_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/merge_req
            ptr_deref_107_gather_scatter_req_0 <= merge_req_450_symbol; -- link to DP
            merge_ack_451_symbol <= ptr_deref_107_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/merge_ack
            Xexit_439_symbol <= merge_ack_451_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read/$exit
            ptr_deref_107_read_437_symbol <= Xexit_439_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107/ptr_deref_107_read
          Xexit_436_symbol <= ptr_deref_107_read_437_symbol; -- transition branch_block_stmt_57/assign_stmt_108/ptr_deref_107/$exit
          ptr_deref_107_434_symbol <= Xexit_436_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_108/ptr_deref_107
        Xexit_433_symbol <= ptr_deref_107_434_symbol; -- transition branch_block_stmt_57/assign_stmt_108/$exit
        assign_stmt_108_431_symbol <= Xexit_433_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_108
      assign_stmt_113_452: Block -- branch_block_stmt_57/assign_stmt_113 
        signal assign_stmt_113_452_start: Boolean;
        signal Xentry_453_symbol: Boolean;
        signal Xexit_454_symbol: Boolean;
        signal dummy_455_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_113_452_start <= assign_stmt_113_x_xentry_x_xx_x247_symbol; -- control passed to block
        Xentry_453_symbol  <= assign_stmt_113_452_start; -- transition branch_block_stmt_57/assign_stmt_113/$entry
        dummy_455_symbol <= Xentry_453_symbol; -- transition branch_block_stmt_57/assign_stmt_113/dummy
        Xexit_454_symbol <= dummy_455_symbol; -- transition branch_block_stmt_57/assign_stmt_113/$exit
        assign_stmt_113_452_symbol <= Xexit_454_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_113
      assign_stmt_117_456: Block -- branch_block_stmt_57/assign_stmt_117 
        signal assign_stmt_117_456_start: Boolean;
        signal Xentry_457_symbol: Boolean;
        signal Xexit_458_symbol: Boolean;
        signal ptr_deref_116_459_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_117_456_start <= assign_stmt_117_x_xentry_x_xx_x249_symbol; -- control passed to block
        Xentry_457_symbol  <= assign_stmt_117_456_start; -- transition branch_block_stmt_57/assign_stmt_117/$entry
        ptr_deref_116_459: Block -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116 
          signal ptr_deref_116_459_start: Boolean;
          signal Xentry_460_symbol: Boolean;
          signal Xexit_461_symbol: Boolean;
          signal ptr_deref_116_read_462_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_116_459_start <= Xentry_457_symbol; -- control passed to block
          Xentry_460_symbol  <= ptr_deref_116_459_start; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/$entry
          ptr_deref_116_read_462: Block -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read 
            signal ptr_deref_116_read_462_start: Boolean;
            signal Xentry_463_symbol: Boolean;
            signal Xexit_464_symbol: Boolean;
            signal word_access_465_symbol : Boolean;
            signal merge_req_475_symbol : Boolean;
            signal merge_ack_476_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_116_read_462_start <= Xentry_460_symbol; -- control passed to block
            Xentry_463_symbol  <= ptr_deref_116_read_462_start; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/$entry
            word_access_465: Block -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access 
              signal word_access_465_start: Boolean;
              signal Xentry_466_symbol: Boolean;
              signal Xexit_467_symbol: Boolean;
              signal word_access_0_468_symbol : Boolean;
              -- 
            begin -- 
              word_access_465_start <= Xentry_463_symbol; -- control passed to block
              Xentry_466_symbol  <= word_access_465_start; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/$entry
              word_access_0_468: Block -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0 
                signal word_access_0_468_start: Boolean;
                signal Xentry_469_symbol: Boolean;
                signal Xexit_470_symbol: Boolean;
                signal rr_471_symbol : Boolean;
                signal ra_472_symbol : Boolean;
                signal cr_473_symbol : Boolean;
                signal ca_474_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_468_start <= Xentry_466_symbol; -- control passed to block
                Xentry_469_symbol  <= word_access_0_468_start; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0/$entry
                rr_471_symbol <= Xentry_469_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0/rr
                ptr_deref_116_load_0_req_0 <= rr_471_symbol; -- link to DP
                ra_472_symbol <= ptr_deref_116_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0/ra
                cr_473_symbol <= ra_472_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0/cr
                ptr_deref_116_load_0_req_1 <= cr_473_symbol; -- link to DP
                ca_474_symbol <= ptr_deref_116_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0/ca
                Xexit_470_symbol <= ca_474_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0/$exit
                word_access_0_468_symbol <= Xexit_470_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/word_access_0
              Xexit_467_symbol <= word_access_0_468_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access/$exit
              word_access_465_symbol <= Xexit_467_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/word_access
            merge_req_475_symbol <= word_access_465_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/merge_req
            ptr_deref_116_gather_scatter_req_0 <= merge_req_475_symbol; -- link to DP
            merge_ack_476_symbol <= ptr_deref_116_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/merge_ack
            Xexit_464_symbol <= merge_ack_476_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read/$exit
            ptr_deref_116_read_462_symbol <= Xexit_464_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116/ptr_deref_116_read
          Xexit_461_symbol <= ptr_deref_116_read_462_symbol; -- transition branch_block_stmt_57/assign_stmt_117/ptr_deref_116/$exit
          ptr_deref_116_459_symbol <= Xexit_461_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_117/ptr_deref_116
        Xexit_458_symbol <= ptr_deref_116_459_symbol; -- transition branch_block_stmt_57/assign_stmt_117/$exit
        assign_stmt_117_456_symbol <= Xexit_458_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_117
      call_stmt_121_477: Block -- branch_block_stmt_57/call_stmt_121 
        signal call_stmt_121_477_start: Boolean;
        signal Xentry_478_symbol: Boolean;
        signal Xexit_479_symbol: Boolean;
        signal call_stmt_121_in_args_x_x480_symbol : Boolean;
        signal crr_483_symbol : Boolean;
        signal cra_484_symbol : Boolean;
        signal ccr_485_symbol : Boolean;
        signal cca_486_symbol : Boolean;
        signal call_stmt_121_out_args_x_x487_symbol : Boolean;
        -- 
      begin -- 
        call_stmt_121_477_start <= call_stmt_121_x_xentry_x_xx_x251_symbol; -- control passed to block
        Xentry_478_symbol  <= call_stmt_121_477_start; -- transition branch_block_stmt_57/call_stmt_121/$entry
        call_stmt_121_in_args_x_x480: Block -- branch_block_stmt_57/call_stmt_121/call_stmt_121_in_args_ 
          signal call_stmt_121_in_args_x_x480_start: Boolean;
          signal Xentry_481_symbol: Boolean;
          signal Xexit_482_symbol: Boolean;
          -- 
        begin -- 
          call_stmt_121_in_args_x_x480_start <= Xentry_478_symbol; -- control passed to block
          Xentry_481_symbol  <= call_stmt_121_in_args_x_x480_start; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_in_args_/$entry
          Xexit_482_symbol <= Xentry_481_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_in_args_/$exit
          call_stmt_121_in_args_x_x480_symbol <= Xexit_482_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/call_stmt_121/call_stmt_121_in_args_
        crr_483_symbol <= call_stmt_121_in_args_x_x480_symbol; -- transition branch_block_stmt_57/call_stmt_121/crr
        call_stmt_121_call_req_0 <= crr_483_symbol; -- link to DP
        cra_484_symbol <= call_stmt_121_call_ack_0; -- transition branch_block_stmt_57/call_stmt_121/cra
        ccr_485_symbol <= cra_484_symbol; -- transition branch_block_stmt_57/call_stmt_121/ccr
        call_stmt_121_call_req_1 <= ccr_485_symbol; -- link to DP
        cca_486_symbol <= call_stmt_121_call_ack_1; -- transition branch_block_stmt_57/call_stmt_121/cca
        call_stmt_121_out_args_x_x487: Block -- branch_block_stmt_57/call_stmt_121/call_stmt_121_out_args_ 
          signal call_stmt_121_out_args_x_x487_start: Boolean;
          signal Xentry_488_symbol: Boolean;
          signal Xexit_489_symbol: Boolean;
          -- 
        begin -- 
          call_stmt_121_out_args_x_x487_start <= cca_486_symbol; -- control passed to block
          Xentry_488_symbol  <= call_stmt_121_out_args_x_x487_start; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_out_args_/$entry
          Xexit_489_symbol <= Xentry_488_symbol; -- transition branch_block_stmt_57/call_stmt_121/call_stmt_121_out_args_/$exit
          call_stmt_121_out_args_x_x487_symbol <= Xexit_489_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/call_stmt_121/call_stmt_121_out_args_
        Xexit_479_symbol <= call_stmt_121_out_args_x_x487_symbol; -- transition branch_block_stmt_57/call_stmt_121/$exit
        call_stmt_121_477_symbol <= Xexit_479_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/call_stmt_121
      assign_stmt_124_490: Block -- branch_block_stmt_57/assign_stmt_124 
        signal assign_stmt_124_490_start: Boolean;
        signal Xentry_491_symbol: Boolean;
        signal Xexit_492_symbol: Boolean;
        signal simple_obj_ref_122_493_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_124_490_start <= assign_stmt_124_x_xentry_x_xx_x253_symbol; -- control passed to block
        Xentry_491_symbol  <= assign_stmt_124_490_start; -- transition branch_block_stmt_57/assign_stmt_124/$entry
        simple_obj_ref_122_493: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122 
          signal simple_obj_ref_122_493_start: Boolean;
          signal Xentry_494_symbol: Boolean;
          signal Xexit_495_symbol: Boolean;
          signal simple_obj_ref_122_write_496_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_122_493_start <= Xentry_491_symbol; -- control passed to block
          Xentry_494_symbol  <= simple_obj_ref_122_493_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/$entry
          simple_obj_ref_122_write_496: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write 
            signal simple_obj_ref_122_write_496_start: Boolean;
            signal Xentry_497_symbol: Boolean;
            signal Xexit_498_symbol: Boolean;
            signal split_req_499_symbol : Boolean;
            signal split_ack_500_symbol : Boolean;
            signal word_access_501_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_122_write_496_start <= Xentry_494_symbol; -- control passed to block
            Xentry_497_symbol  <= simple_obj_ref_122_write_496_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/$entry
            split_req_499_symbol <= Xentry_497_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/split_req
            simple_obj_ref_122_gather_scatter_req_0 <= split_req_499_symbol; -- link to DP
            split_ack_500_symbol <= simple_obj_ref_122_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/split_ack
            word_access_501: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access 
              signal word_access_501_start: Boolean;
              signal Xentry_502_symbol: Boolean;
              signal Xexit_503_symbol: Boolean;
              signal word_access_0_504_symbol : Boolean;
              -- 
            begin -- 
              word_access_501_start <= split_ack_500_symbol; -- control passed to block
              Xentry_502_symbol  <= word_access_501_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/$entry
              word_access_0_504: Block -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0 
                signal word_access_0_504_start: Boolean;
                signal Xentry_505_symbol: Boolean;
                signal Xexit_506_symbol: Boolean;
                signal rr_507_symbol : Boolean;
                signal ra_508_symbol : Boolean;
                signal cr_509_symbol : Boolean;
                signal ca_510_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_504_start <= Xentry_502_symbol; -- control passed to block
                Xentry_505_symbol  <= word_access_0_504_start; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0/$entry
                rr_507_symbol <= Xentry_505_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0/rr
                simple_obj_ref_122_store_0_req_0 <= rr_507_symbol; -- link to DP
                ra_508_symbol <= simple_obj_ref_122_store_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0/ra
                cr_509_symbol <= ra_508_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0/cr
                simple_obj_ref_122_store_0_req_1 <= cr_509_symbol; -- link to DP
                ca_510_symbol <= simple_obj_ref_122_store_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0/ca
                Xexit_506_symbol <= ca_510_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0/$exit
                word_access_0_504_symbol <= Xexit_506_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/word_access_0
              Xexit_503_symbol <= word_access_0_504_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access/$exit
              word_access_501_symbol <= Xexit_503_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/word_access
            Xexit_498_symbol <= word_access_501_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write/$exit
            simple_obj_ref_122_write_496_symbol <= Xexit_498_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/simple_obj_ref_122_write
          Xexit_495_symbol <= simple_obj_ref_122_write_496_symbol; -- transition branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122/$exit
          simple_obj_ref_122_493_symbol <= Xexit_495_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_124/simple_obj_ref_122
        Xexit_492_symbol <= simple_obj_ref_122_493_symbol; -- transition branch_block_stmt_57/assign_stmt_124/$exit
        assign_stmt_124_490_symbol <= Xexit_492_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_124
      assign_stmt_129_511: Block -- branch_block_stmt_57/assign_stmt_129 
        signal assign_stmt_129_511_start: Boolean;
        signal Xentry_512_symbol: Boolean;
        signal Xexit_513_symbol: Boolean;
        signal simple_obj_ref_128_514_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_129_511_start <= assign_stmt_129_x_xentry_x_xx_x256_symbol; -- control passed to block
        Xentry_512_symbol  <= assign_stmt_129_511_start; -- transition branch_block_stmt_57/assign_stmt_129/$entry
        simple_obj_ref_128_514: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128 
          signal simple_obj_ref_128_514_start: Boolean;
          signal Xentry_515_symbol: Boolean;
          signal Xexit_516_symbol: Boolean;
          signal simple_obj_ref_128_read_517_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_128_514_start <= Xentry_512_symbol; -- control passed to block
          Xentry_515_symbol  <= simple_obj_ref_128_514_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/$entry
          simple_obj_ref_128_read_517: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read 
            signal simple_obj_ref_128_read_517_start: Boolean;
            signal Xentry_518_symbol: Boolean;
            signal Xexit_519_symbol: Boolean;
            signal word_access_520_symbol : Boolean;
            signal merge_req_530_symbol : Boolean;
            signal merge_ack_531_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_128_read_517_start <= Xentry_515_symbol; -- control passed to block
            Xentry_518_symbol  <= simple_obj_ref_128_read_517_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/$entry
            word_access_520: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access 
              signal word_access_520_start: Boolean;
              signal Xentry_521_symbol: Boolean;
              signal Xexit_522_symbol: Boolean;
              signal word_access_0_523_symbol : Boolean;
              -- 
            begin -- 
              word_access_520_start <= Xentry_518_symbol; -- control passed to block
              Xentry_521_symbol  <= word_access_520_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/$entry
              word_access_0_523: Block -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0 
                signal word_access_0_523_start: Boolean;
                signal Xentry_524_symbol: Boolean;
                signal Xexit_525_symbol: Boolean;
                signal rr_526_symbol : Boolean;
                signal ra_527_symbol : Boolean;
                signal cr_528_symbol : Boolean;
                signal ca_529_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_523_start <= Xentry_521_symbol; -- control passed to block
                Xentry_524_symbol  <= word_access_0_523_start; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0/$entry
                rr_526_symbol <= Xentry_524_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0/rr
                simple_obj_ref_128_load_0_req_0 <= rr_526_symbol; -- link to DP
                ra_527_symbol <= simple_obj_ref_128_load_0_ack_0; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0/ra
                cr_528_symbol <= ra_527_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0/cr
                simple_obj_ref_128_load_0_req_1 <= cr_528_symbol; -- link to DP
                ca_529_symbol <= simple_obj_ref_128_load_0_ack_1; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0/ca
                Xexit_525_symbol <= ca_529_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0/$exit
                word_access_0_523_symbol <= Xexit_525_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/word_access_0
              Xexit_522_symbol <= word_access_0_523_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access/$exit
              word_access_520_symbol <= Xexit_522_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/word_access
            merge_req_530_symbol <= word_access_520_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/merge_req
            simple_obj_ref_128_gather_scatter_req_0 <= merge_req_530_symbol; -- link to DP
            merge_ack_531_symbol <= simple_obj_ref_128_gather_scatter_ack_0; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/merge_ack
            Xexit_519_symbol <= merge_ack_531_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read/$exit
            simple_obj_ref_128_read_517_symbol <= Xexit_519_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/simple_obj_ref_128_read
          Xexit_516_symbol <= simple_obj_ref_128_read_517_symbol; -- transition branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128/$exit
          simple_obj_ref_128_514_symbol <= Xexit_516_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_57/assign_stmt_129/simple_obj_ref_128
        Xexit_513_symbol <= simple_obj_ref_128_514_symbol; -- transition branch_block_stmt_57/assign_stmt_129/$exit
        assign_stmt_129_511_symbol <= Xexit_513_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/assign_stmt_129
      return_x_xx_xPhiReq_532: Block -- branch_block_stmt_57/return___PhiReq 
        signal return_x_xx_xPhiReq_532_start: Boolean;
        signal Xentry_533_symbol: Boolean;
        signal Xexit_534_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_532_start <= return_x_xx_x258_symbol; -- control passed to block
        Xentry_533_symbol  <= return_x_xx_xPhiReq_532_start; -- transition branch_block_stmt_57/return___PhiReq/$entry
        Xexit_534_symbol <= Xentry_533_symbol; -- transition branch_block_stmt_57/return___PhiReq/$exit
        return_x_xx_xPhiReq_532_symbol <= Xexit_534_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/return___PhiReq
      merge_stmt_126_PhiReqMerge_535_symbol  <=  return_x_xx_xPhiReq_532_symbol; -- place branch_block_stmt_57/merge_stmt_126_PhiReqMerge (optimized away) 
      merge_stmt_126_PhiAck_536: Block -- branch_block_stmt_57/merge_stmt_126_PhiAck 
        signal merge_stmt_126_PhiAck_536_start: Boolean;
        signal Xentry_537_symbol: Boolean;
        signal Xexit_538_symbol: Boolean;
        signal dummy_539_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_126_PhiAck_536_start <= merge_stmt_126_PhiReqMerge_535_symbol; -- control passed to block
        Xentry_537_symbol  <= merge_stmt_126_PhiAck_536_start; -- transition branch_block_stmt_57/merge_stmt_126_PhiAck/$entry
        dummy_539_symbol <= Xentry_537_symbol; -- transition branch_block_stmt_57/merge_stmt_126_PhiAck/dummy
        Xexit_538_symbol <= dummy_539_symbol; -- transition branch_block_stmt_57/merge_stmt_126_PhiAck/$exit
        merge_stmt_126_PhiAck_536_symbol <= Xexit_538_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_57/merge_stmt_126_PhiAck
      Xexit_220_symbol <= branch_block_stmt_57_x_xexit_x_xx_x222_symbol; -- transition branch_block_stmt_57/$exit
      branch_block_stmt_57_218_symbol <= Xexit_220_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_57
    Xexit_217_symbol <= branch_block_stmt_57_218_symbol; -- transition $exit
    fin  <=  '1' when Xexit_217_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal expr_98_wire_constant : std_logic_vector(31 downto 0);
    signal iNsTr_10_95 : std_logic_vector(31 downto 0);
    signal iNsTr_10_95_resized : std_logic_vector(0 downto 0);
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
    signal xxsubxxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    signal xxsubxxsubxxiNsTr_0_base_address : std_logic_vector(0 downto 0);
    signal xxsubxxsubxxiNsTr_1_base_address : std_logic_vector(0 downto 0);
    signal xxsubxxsubxxt_base_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    expr_98_wire_constant <= "00000000000000000000000000000001";
    iNsTr_10_95 <= "00000000000000000000000000000000";
    iNsTr_12_104 <= "00000000000000000000000000000000";
    iNsTr_14_113 <= "00000000000000000000000000000001";
    iNsTr_5_74 <= "00000000000000000000000000000000";
    iNsTr_8_86 <= "00000000000000000000000000000001";
    ptr_deref_107_word_address_0 <= "0";
    ptr_deref_116_word_address_0 <= "1";
    ptr_deref_76_word_address_0 <= "0";
    ptr_deref_88_word_address_0 <= "1";
    ptr_deref_97_word_offset_0 <= "0";
    simple_obj_ref_122_word_address_0 <= "0";
    simple_obj_ref_128_word_address_0 <= "0";
    simple_obj_ref_61_word_address_0 <= "0";
    simple_obj_ref_64_word_address_0 <= "0";
    simple_obj_ref_68_word_address_0 <= "0";
    simple_obj_ref_80_word_address_0 <= "0";
    xxsubxxstored_ret_val_x_xx_xbase_address <= "0";
    xxsubxxsubxxiNsTr_0_base_address <= "0";
    xxsubxxsubxxiNsTr_1_base_address <= "0";
    xxsubxxsubxxt_base_address <= "0";
    ptr_deref_97_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 1) -- 
      port map( din => iNsTr_10_95, dout => iNsTr_10_95_resized, req => ptr_deref_97_base_resize_req_0, ack => ptr_deref_97_base_resize_ack_0, clk => clk, reset => reset); -- 
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
      aggregated_sig <= iNsTr_10_95_resized;
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
    -- shared load operator group (0) : ptr_deref_107_load_0 ptr_deref_116_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_107_load_0_req_0;
      reqL(0) <= ptr_deref_116_load_0_req_0;
      ptr_deref_107_load_0_ack_0 <= ackL(1);
      ptr_deref_116_load_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_107_load_0_req_1;
      reqR(0) <= ptr_deref_116_load_0_req_1;
      ptr_deref_107_load_0_ack_1 <= ackR(1);
      ptr_deref_116_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_107_word_address_0 & ptr_deref_116_word_address_0;
      ptr_deref_107_data_0 <= data_out(63 downto 32);
      ptr_deref_116_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_7_lr_req(0),
          mack => memory_space_7_lr_ack(0),
          maddr => memory_space_7_lr_addr(0 downto 0),
          mtag => memory_space_7_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_7_lc_req(0),
          mack => memory_space_7_lc_ack(0),
          mdata => memory_space_7_lc_data(31 downto 0),
          mtag => memory_space_7_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_128_load_0 
    LoadGroup1: Block -- 
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
    end Block; -- load group 1
    -- shared load operator group (2) : simple_obj_ref_68_load_0 
    LoadGroup2: Block -- 
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
    end Block; -- load group 2
    -- shared load operator group (3) : simple_obj_ref_80_load_0 
    LoadGroup3: Block -- 
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
    end Block; -- load group 3
    -- shared store operator group (0) : ptr_deref_76_store_0 ptr_deref_88_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_76_store_0_req_0;
      reqL(0) <= ptr_deref_88_store_0_req_0;
      ptr_deref_76_store_0_ack_0 <= ackL(1);
      ptr_deref_88_store_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_76_store_0_req_1;
      reqR(0) <= ptr_deref_88_store_0_req_1;
      ptr_deref_76_store_0_ack_1 <= ackR(1);
      ptr_deref_88_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_76_word_address_0 & ptr_deref_88_word_address_0;
      data_in <= ptr_deref_76_data_0 & ptr_deref_88_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 32,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_7_sr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        );--
      StoreComplete: StoreCompleteShared -- 
        generic map ( -- 
          num_reqs => 2,
          tag_length => 2 -- 
        )
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          mreq => memory_space_7_sc_req(0),
          mack => memory_space_7_sc_ack(0),
          mtag => memory_space_7_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_97_store_0 
    StoreGroup1: Block -- 
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
    end Block; -- store group 1
    -- shared store operator group (2) : simple_obj_ref_122_store_0 
    StoreGroup2: Block -- 
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
    end Block; -- store group 2
    -- shared store operator group (3) : simple_obj_ref_61_store_0 
    StoreGroup3: Block -- 
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
    end Block; -- store group 3
    -- shared store operator group (4) : simple_obj_ref_64_store_0 
    StoreGroup4: Block -- 
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
    end Block; -- store group 4
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
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 32,
      tag_width => 2,
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
  signal simple_obj_ref_11_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_11_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_14_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_14_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_14_store_0_req_0 : boolean;
  signal simple_obj_ref_14_store_0_ack_0 : boolean;
  signal simple_obj_ref_14_store_0_req_1 : boolean;
  signal simple_obj_ref_14_store_0_ack_1 : boolean;
  signal ptr_deref_24_load_0_req_0 : boolean;
  signal ptr_deref_24_load_0_ack_0 : boolean;
  signal ptr_deref_24_load_0_req_1 : boolean;
  signal ptr_deref_24_load_0_ack_1 : boolean;
  signal ptr_deref_24_gather_scatter_req_0 : boolean;
  signal ptr_deref_24_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_11_store_0_req_0 : boolean;
  signal simple_obj_ref_11_store_0_ack_0 : boolean;
  signal simple_obj_ref_11_store_0_req_1 : boolean;
  signal simple_obj_ref_11_store_0_ack_1 : boolean;
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
  signal simple_obj_ref_42_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_42_store_0_req_0 : boolean;
  signal simple_obj_ref_42_store_0_ack_0 : boolean;
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
      signal assign_stmt_13_x_xentry_x_xx_x8_symbol : Boolean;
      signal assign_stmt_13_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_16_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_16_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_21_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_21_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_25_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_25_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_28_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_28_x_xexit_x_xx_x17_symbol : Boolean;
      signal assign_stmt_33_x_xentry_x_xx_x18_symbol : Boolean;
      signal assign_stmt_33_x_xexit_x_xx_x19_symbol : Boolean;
      signal assign_stmt_36_x_xentry_x_xx_x20_symbol : Boolean;
      signal assign_stmt_36_x_xexit_x_xx_x21_symbol : Boolean;
      signal assign_stmt_41_x_xentry_x_xx_x22_symbol : Boolean;
      signal assign_stmt_41_x_xexit_x_xx_x23_symbol : Boolean;
      signal assign_stmt_44_x_xentry_x_xx_x24_symbol : Boolean;
      signal assign_stmt_44_x_xexit_x_xx_x25_symbol : Boolean;
      signal merge_stmt_46_x_xexit_x_xx_x26_symbol : Boolean;
      signal assign_stmt_49_x_xentry_x_xx_x27_symbol : Boolean;
      signal assign_stmt_49_x_xexit_x_xx_x28_symbol : Boolean;
      signal return_x_xx_x29_symbol : Boolean;
      signal assign_stmt_13_30_symbol : Boolean;
      signal assign_stmt_16_51_symbol : Boolean;
      signal assign_stmt_21_72_symbol : Boolean;
      signal assign_stmt_25_76_symbol : Boolean;
      signal assign_stmt_28_97_symbol : Boolean;
      signal assign_stmt_33_118_symbol : Boolean;
      signal assign_stmt_36_131_symbol : Boolean;
      signal assign_stmt_41_152_symbol : Boolean;
      signal assign_stmt_44_165_symbol : Boolean;
      signal assign_stmt_49_186_symbol : Boolean;
      signal return_x_xx_xPhiReq_207_symbol : Boolean;
      signal merge_stmt_46_PhiReqMerge_210_symbol : Boolean;
      signal merge_stmt_46_PhiAck_211_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_8_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_8_3_start; -- transition branch_block_stmt_8/$entry
      branch_block_stmt_8_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_8/branch_block_stmt_8__entry__ (optimized away) 
      branch_block_stmt_8_x_xexit_x_xx_x7_symbol  <=  assign_stmt_49_x_xexit_x_xx_x28_symbol; -- place branch_block_stmt_8/branch_block_stmt_8__exit__ (optimized away) 
      assign_stmt_13_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_8_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_8/assign_stmt_13__entry__ (optimized away) 
      assign_stmt_13_x_xexit_x_xx_x9_symbol  <=  assign_stmt_13_30_symbol; -- place branch_block_stmt_8/assign_stmt_13__exit__ (optimized away) 
      assign_stmt_16_x_xentry_x_xx_x10_symbol  <=  assign_stmt_13_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_8/assign_stmt_16__entry__ (optimized away) 
      assign_stmt_16_x_xexit_x_xx_x11_symbol  <=  assign_stmt_16_51_symbol; -- place branch_block_stmt_8/assign_stmt_16__exit__ (optimized away) 
      assign_stmt_21_x_xentry_x_xx_x12_symbol  <=  assign_stmt_16_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_8/assign_stmt_21__entry__ (optimized away) 
      assign_stmt_21_x_xexit_x_xx_x13_symbol  <=  assign_stmt_21_72_symbol; -- place branch_block_stmt_8/assign_stmt_21__exit__ (optimized away) 
      assign_stmt_25_x_xentry_x_xx_x14_symbol  <=  assign_stmt_21_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_8/assign_stmt_25__entry__ (optimized away) 
      assign_stmt_25_x_xexit_x_xx_x15_symbol  <=  assign_stmt_25_76_symbol; -- place branch_block_stmt_8/assign_stmt_25__exit__ (optimized away) 
      assign_stmt_28_x_xentry_x_xx_x16_symbol  <=  assign_stmt_25_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_8/assign_stmt_28__entry__ (optimized away) 
      assign_stmt_28_x_xexit_x_xx_x17_symbol  <=  assign_stmt_28_97_symbol; -- place branch_block_stmt_8/assign_stmt_28__exit__ (optimized away) 
      assign_stmt_33_x_xentry_x_xx_x18_symbol  <=  assign_stmt_28_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_8/assign_stmt_33__entry__ (optimized away) 
      assign_stmt_33_x_xexit_x_xx_x19_symbol  <=  assign_stmt_33_118_symbol; -- place branch_block_stmt_8/assign_stmt_33__exit__ (optimized away) 
      assign_stmt_36_x_xentry_x_xx_x20_symbol  <=  assign_stmt_33_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_8/assign_stmt_36__entry__ (optimized away) 
      assign_stmt_36_x_xexit_x_xx_x21_symbol  <=  assign_stmt_36_131_symbol; -- place branch_block_stmt_8/assign_stmt_36__exit__ (optimized away) 
      assign_stmt_41_x_xentry_x_xx_x22_symbol  <=  assign_stmt_36_x_xexit_x_xx_x21_symbol; -- place branch_block_stmt_8/assign_stmt_41__entry__ (optimized away) 
      assign_stmt_41_x_xexit_x_xx_x23_symbol  <=  assign_stmt_41_152_symbol; -- place branch_block_stmt_8/assign_stmt_41__exit__ (optimized away) 
      assign_stmt_44_x_xentry_x_xx_x24_symbol  <=  assign_stmt_41_x_xexit_x_xx_x23_symbol; -- place branch_block_stmt_8/assign_stmt_44__entry__ (optimized away) 
      assign_stmt_44_x_xexit_x_xx_x25_symbol  <=  assign_stmt_44_165_symbol; -- place branch_block_stmt_8/assign_stmt_44__exit__ (optimized away) 
      merge_stmt_46_x_xexit_x_xx_x26_symbol  <=  merge_stmt_46_PhiAck_211_symbol; -- place branch_block_stmt_8/merge_stmt_46__exit__ (optimized away) 
      assign_stmt_49_x_xentry_x_xx_x27_symbol  <=  merge_stmt_46_x_xexit_x_xx_x26_symbol; -- place branch_block_stmt_8/assign_stmt_49__entry__ (optimized away) 
      assign_stmt_49_x_xexit_x_xx_x28_symbol  <=  assign_stmt_49_186_symbol; -- place branch_block_stmt_8/assign_stmt_49__exit__ (optimized away) 
      return_x_xx_x29_symbol  <=  assign_stmt_44_x_xexit_x_xx_x25_symbol; -- place branch_block_stmt_8/return__ (optimized away) 
      assign_stmt_13_30: Block -- branch_block_stmt_8/assign_stmt_13 
        signal assign_stmt_13_30_start: Boolean;
        signal Xentry_31_symbol: Boolean;
        signal Xexit_32_symbol: Boolean;
        signal simple_obj_ref_11_33_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_13_30_start <= assign_stmt_13_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_31_symbol  <= assign_stmt_13_30_start; -- transition branch_block_stmt_8/assign_stmt_13/$entry
        simple_obj_ref_11_33: Block -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11 
          signal simple_obj_ref_11_33_start: Boolean;
          signal Xentry_34_symbol: Boolean;
          signal Xexit_35_symbol: Boolean;
          signal simple_obj_ref_11_write_36_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_11_33_start <= Xentry_31_symbol; -- control passed to block
          Xentry_34_symbol  <= simple_obj_ref_11_33_start; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/$entry
          simple_obj_ref_11_write_36: Block -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write 
            signal simple_obj_ref_11_write_36_start: Boolean;
            signal Xentry_37_symbol: Boolean;
            signal Xexit_38_symbol: Boolean;
            signal split_req_39_symbol : Boolean;
            signal split_ack_40_symbol : Boolean;
            signal word_access_41_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_11_write_36_start <= Xentry_34_symbol; -- control passed to block
            Xentry_37_symbol  <= simple_obj_ref_11_write_36_start; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/$entry
            split_req_39_symbol <= Xentry_37_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/split_req
            simple_obj_ref_11_gather_scatter_req_0 <= split_req_39_symbol; -- link to DP
            split_ack_40_symbol <= simple_obj_ref_11_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/split_ack
            word_access_41: Block -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access 
              signal word_access_41_start: Boolean;
              signal Xentry_42_symbol: Boolean;
              signal Xexit_43_symbol: Boolean;
              signal word_access_0_44_symbol : Boolean;
              -- 
            begin -- 
              word_access_41_start <= split_ack_40_symbol; -- control passed to block
              Xentry_42_symbol  <= word_access_41_start; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/$entry
              word_access_0_44: Block -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0 
                signal word_access_0_44_start: Boolean;
                signal Xentry_45_symbol: Boolean;
                signal Xexit_46_symbol: Boolean;
                signal rr_47_symbol : Boolean;
                signal ra_48_symbol : Boolean;
                signal cr_49_symbol : Boolean;
                signal ca_50_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_44_start <= Xentry_42_symbol; -- control passed to block
                Xentry_45_symbol  <= word_access_0_44_start; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0/$entry
                rr_47_symbol <= Xentry_45_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0/rr
                simple_obj_ref_11_store_0_req_0 <= rr_47_symbol; -- link to DP
                ra_48_symbol <= simple_obj_ref_11_store_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0/ra
                cr_49_symbol <= ra_48_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0/cr
                simple_obj_ref_11_store_0_req_1 <= cr_49_symbol; -- link to DP
                ca_50_symbol <= simple_obj_ref_11_store_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0/ca
                Xexit_46_symbol <= ca_50_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0/$exit
                word_access_0_44_symbol <= Xexit_46_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/word_access_0
              Xexit_43_symbol <= word_access_0_44_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access/$exit
              word_access_41_symbol <= Xexit_43_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/word_access
            Xexit_38_symbol <= word_access_41_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write/$exit
            simple_obj_ref_11_write_36_symbol <= Xexit_38_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/simple_obj_ref_11_write
          Xexit_35_symbol <= simple_obj_ref_11_write_36_symbol; -- transition branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11/$exit
          simple_obj_ref_11_33_symbol <= Xexit_35_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_13/simple_obj_ref_11
        Xexit_32_symbol <= simple_obj_ref_11_33_symbol; -- transition branch_block_stmt_8/assign_stmt_13/$exit
        assign_stmt_13_30_symbol <= Xexit_32_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_13
      assign_stmt_16_51: Block -- branch_block_stmt_8/assign_stmt_16 
        signal assign_stmt_16_51_start: Boolean;
        signal Xentry_52_symbol: Boolean;
        signal Xexit_53_symbol: Boolean;
        signal simple_obj_ref_14_54_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_16_51_start <= assign_stmt_16_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_52_symbol  <= assign_stmt_16_51_start; -- transition branch_block_stmt_8/assign_stmt_16/$entry
        simple_obj_ref_14_54: Block -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14 
          signal simple_obj_ref_14_54_start: Boolean;
          signal Xentry_55_symbol: Boolean;
          signal Xexit_56_symbol: Boolean;
          signal simple_obj_ref_14_write_57_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_14_54_start <= Xentry_52_symbol; -- control passed to block
          Xentry_55_symbol  <= simple_obj_ref_14_54_start; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/$entry
          simple_obj_ref_14_write_57: Block -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write 
            signal simple_obj_ref_14_write_57_start: Boolean;
            signal Xentry_58_symbol: Boolean;
            signal Xexit_59_symbol: Boolean;
            signal split_req_60_symbol : Boolean;
            signal split_ack_61_symbol : Boolean;
            signal word_access_62_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_14_write_57_start <= Xentry_55_symbol; -- control passed to block
            Xentry_58_symbol  <= simple_obj_ref_14_write_57_start; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/$entry
            split_req_60_symbol <= Xentry_58_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/split_req
            simple_obj_ref_14_gather_scatter_req_0 <= split_req_60_symbol; -- link to DP
            split_ack_61_symbol <= simple_obj_ref_14_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/split_ack
            word_access_62: Block -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access 
              signal word_access_62_start: Boolean;
              signal Xentry_63_symbol: Boolean;
              signal Xexit_64_symbol: Boolean;
              signal word_access_0_65_symbol : Boolean;
              -- 
            begin -- 
              word_access_62_start <= split_ack_61_symbol; -- control passed to block
              Xentry_63_symbol  <= word_access_62_start; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/$entry
              word_access_0_65: Block -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0 
                signal word_access_0_65_start: Boolean;
                signal Xentry_66_symbol: Boolean;
                signal Xexit_67_symbol: Boolean;
                signal rr_68_symbol : Boolean;
                signal ra_69_symbol : Boolean;
                signal cr_70_symbol : Boolean;
                signal ca_71_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_65_start <= Xentry_63_symbol; -- control passed to block
                Xentry_66_symbol  <= word_access_0_65_start; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0/$entry
                rr_68_symbol <= Xentry_66_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0/rr
                simple_obj_ref_14_store_0_req_0 <= rr_68_symbol; -- link to DP
                ra_69_symbol <= simple_obj_ref_14_store_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0/ra
                cr_70_symbol <= ra_69_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0/cr
                simple_obj_ref_14_store_0_req_1 <= cr_70_symbol; -- link to DP
                ca_71_symbol <= simple_obj_ref_14_store_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0/ca
                Xexit_67_symbol <= ca_71_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0/$exit
                word_access_0_65_symbol <= Xexit_67_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/word_access_0
              Xexit_64_symbol <= word_access_0_65_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access/$exit
              word_access_62_symbol <= Xexit_64_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/word_access
            Xexit_59_symbol <= word_access_62_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write/$exit
            simple_obj_ref_14_write_57_symbol <= Xexit_59_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/simple_obj_ref_14_write
          Xexit_56_symbol <= simple_obj_ref_14_write_57_symbol; -- transition branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14/$exit
          simple_obj_ref_14_54_symbol <= Xexit_56_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_16/simple_obj_ref_14
        Xexit_53_symbol <= simple_obj_ref_14_54_symbol; -- transition branch_block_stmt_8/assign_stmt_16/$exit
        assign_stmt_16_51_symbol <= Xexit_53_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_16
      assign_stmt_21_72: Block -- branch_block_stmt_8/assign_stmt_21 
        signal assign_stmt_21_72_start: Boolean;
        signal Xentry_73_symbol: Boolean;
        signal Xexit_74_symbol: Boolean;
        signal dummy_75_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_21_72_start <= assign_stmt_21_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_73_symbol  <= assign_stmt_21_72_start; -- transition branch_block_stmt_8/assign_stmt_21/$entry
        dummy_75_symbol <= Xentry_73_symbol; -- transition branch_block_stmt_8/assign_stmt_21/dummy
        Xexit_74_symbol <= dummy_75_symbol; -- transition branch_block_stmt_8/assign_stmt_21/$exit
        assign_stmt_21_72_symbol <= Xexit_74_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_21
      assign_stmt_25_76: Block -- branch_block_stmt_8/assign_stmt_25 
        signal assign_stmt_25_76_start: Boolean;
        signal Xentry_77_symbol: Boolean;
        signal Xexit_78_symbol: Boolean;
        signal ptr_deref_24_79_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_25_76_start <= assign_stmt_25_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_77_symbol  <= assign_stmt_25_76_start; -- transition branch_block_stmt_8/assign_stmt_25/$entry
        ptr_deref_24_79: Block -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24 
          signal ptr_deref_24_79_start: Boolean;
          signal Xentry_80_symbol: Boolean;
          signal Xexit_81_symbol: Boolean;
          signal ptr_deref_24_read_82_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_24_79_start <= Xentry_77_symbol; -- control passed to block
          Xentry_80_symbol  <= ptr_deref_24_79_start; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/$entry
          ptr_deref_24_read_82: Block -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read 
            signal ptr_deref_24_read_82_start: Boolean;
            signal Xentry_83_symbol: Boolean;
            signal Xexit_84_symbol: Boolean;
            signal word_access_85_symbol : Boolean;
            signal merge_req_95_symbol : Boolean;
            signal merge_ack_96_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_24_read_82_start <= Xentry_80_symbol; -- control passed to block
            Xentry_83_symbol  <= ptr_deref_24_read_82_start; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/$entry
            word_access_85: Block -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access 
              signal word_access_85_start: Boolean;
              signal Xentry_86_symbol: Boolean;
              signal Xexit_87_symbol: Boolean;
              signal word_access_0_88_symbol : Boolean;
              -- 
            begin -- 
              word_access_85_start <= Xentry_83_symbol; -- control passed to block
              Xentry_86_symbol  <= word_access_85_start; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/$entry
              word_access_0_88: Block -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0 
                signal word_access_0_88_start: Boolean;
                signal Xentry_89_symbol: Boolean;
                signal Xexit_90_symbol: Boolean;
                signal rr_91_symbol : Boolean;
                signal ra_92_symbol : Boolean;
                signal cr_93_symbol : Boolean;
                signal ca_94_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_88_start <= Xentry_86_symbol; -- control passed to block
                Xentry_89_symbol  <= word_access_0_88_start; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0/$entry
                rr_91_symbol <= Xentry_89_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0/rr
                ptr_deref_24_load_0_req_0 <= rr_91_symbol; -- link to DP
                ra_92_symbol <= ptr_deref_24_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0/ra
                cr_93_symbol <= ra_92_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0/cr
                ptr_deref_24_load_0_req_1 <= cr_93_symbol; -- link to DP
                ca_94_symbol <= ptr_deref_24_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0/ca
                Xexit_90_symbol <= ca_94_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0/$exit
                word_access_0_88_symbol <= Xexit_90_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/word_access_0
              Xexit_87_symbol <= word_access_0_88_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access/$exit
              word_access_85_symbol <= Xexit_87_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/word_access
            merge_req_95_symbol <= word_access_85_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/merge_req
            ptr_deref_24_gather_scatter_req_0 <= merge_req_95_symbol; -- link to DP
            merge_ack_96_symbol <= ptr_deref_24_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/merge_ack
            Xexit_84_symbol <= merge_ack_96_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read/$exit
            ptr_deref_24_read_82_symbol <= Xexit_84_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24/ptr_deref_24_read
          Xexit_81_symbol <= ptr_deref_24_read_82_symbol; -- transition branch_block_stmt_8/assign_stmt_25/ptr_deref_24/$exit
          ptr_deref_24_79_symbol <= Xexit_81_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_25/ptr_deref_24
        Xexit_78_symbol <= ptr_deref_24_79_symbol; -- transition branch_block_stmt_8/assign_stmt_25/$exit
        assign_stmt_25_76_symbol <= Xexit_78_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_25
      assign_stmt_28_97: Block -- branch_block_stmt_8/assign_stmt_28 
        signal assign_stmt_28_97_start: Boolean;
        signal Xentry_98_symbol: Boolean;
        signal Xexit_99_symbol: Boolean;
        signal simple_obj_ref_27_100_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_28_97_start <= assign_stmt_28_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_98_symbol  <= assign_stmt_28_97_start; -- transition branch_block_stmt_8/assign_stmt_28/$entry
        simple_obj_ref_27_100: Block -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27 
          signal simple_obj_ref_27_100_start: Boolean;
          signal Xentry_101_symbol: Boolean;
          signal Xexit_102_symbol: Boolean;
          signal simple_obj_ref_27_read_103_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_27_100_start <= Xentry_98_symbol; -- control passed to block
          Xentry_101_symbol  <= simple_obj_ref_27_100_start; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/$entry
          simple_obj_ref_27_read_103: Block -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read 
            signal simple_obj_ref_27_read_103_start: Boolean;
            signal Xentry_104_symbol: Boolean;
            signal Xexit_105_symbol: Boolean;
            signal word_access_106_symbol : Boolean;
            signal merge_req_116_symbol : Boolean;
            signal merge_ack_117_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_27_read_103_start <= Xentry_101_symbol; -- control passed to block
            Xentry_104_symbol  <= simple_obj_ref_27_read_103_start; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/$entry
            word_access_106: Block -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access 
              signal word_access_106_start: Boolean;
              signal Xentry_107_symbol: Boolean;
              signal Xexit_108_symbol: Boolean;
              signal word_access_0_109_symbol : Boolean;
              -- 
            begin -- 
              word_access_106_start <= Xentry_104_symbol; -- control passed to block
              Xentry_107_symbol  <= word_access_106_start; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/$entry
              word_access_0_109: Block -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0 
                signal word_access_0_109_start: Boolean;
                signal Xentry_110_symbol: Boolean;
                signal Xexit_111_symbol: Boolean;
                signal rr_112_symbol : Boolean;
                signal ra_113_symbol : Boolean;
                signal cr_114_symbol : Boolean;
                signal ca_115_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_109_start <= Xentry_107_symbol; -- control passed to block
                Xentry_110_symbol  <= word_access_0_109_start; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0/$entry
                rr_112_symbol <= Xentry_110_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0/rr
                simple_obj_ref_27_load_0_req_0 <= rr_112_symbol; -- link to DP
                ra_113_symbol <= simple_obj_ref_27_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0/ra
                cr_114_symbol <= ra_113_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0/cr
                simple_obj_ref_27_load_0_req_1 <= cr_114_symbol; -- link to DP
                ca_115_symbol <= simple_obj_ref_27_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0/ca
                Xexit_111_symbol <= ca_115_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0/$exit
                word_access_0_109_symbol <= Xexit_111_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/word_access_0
              Xexit_108_symbol <= word_access_0_109_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access/$exit
              word_access_106_symbol <= Xexit_108_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/word_access
            merge_req_116_symbol <= word_access_106_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/merge_req
            simple_obj_ref_27_gather_scatter_req_0 <= merge_req_116_symbol; -- link to DP
            merge_ack_117_symbol <= simple_obj_ref_27_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/merge_ack
            Xexit_105_symbol <= merge_ack_117_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read/$exit
            simple_obj_ref_27_read_103_symbol <= Xexit_105_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/simple_obj_ref_27_read
          Xexit_102_symbol <= simple_obj_ref_27_read_103_symbol; -- transition branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27/$exit
          simple_obj_ref_27_100_symbol <= Xexit_102_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_28/simple_obj_ref_27
        Xexit_99_symbol <= simple_obj_ref_27_100_symbol; -- transition branch_block_stmt_8/assign_stmt_28/$exit
        assign_stmt_28_97_symbol <= Xexit_99_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_28
      assign_stmt_33_118: Block -- branch_block_stmt_8/assign_stmt_33 
        signal assign_stmt_33_118_start: Boolean;
        signal Xentry_119_symbol: Boolean;
        signal Xexit_120_symbol: Boolean;
        signal binary_32_121_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_33_118_start <= assign_stmt_33_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_119_symbol  <= assign_stmt_33_118_start; -- transition branch_block_stmt_8/assign_stmt_33/$entry
        binary_32_121: Block -- branch_block_stmt_8/assign_stmt_33/binary_32 
          signal binary_32_121_start: Boolean;
          signal Xentry_122_symbol: Boolean;
          signal Xexit_123_symbol: Boolean;
          signal binary_32_inputs_124_symbol : Boolean;
          signal rr_127_symbol : Boolean;
          signal ra_128_symbol : Boolean;
          signal cr_129_symbol : Boolean;
          signal ca_130_symbol : Boolean;
          -- 
        begin -- 
          binary_32_121_start <= Xentry_119_symbol; -- control passed to block
          Xentry_122_symbol  <= binary_32_121_start; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/$entry
          binary_32_inputs_124: Block -- branch_block_stmt_8/assign_stmt_33/binary_32/binary_32_inputs 
            signal binary_32_inputs_124_start: Boolean;
            signal Xentry_125_symbol: Boolean;
            signal Xexit_126_symbol: Boolean;
            -- 
          begin -- 
            binary_32_inputs_124_start <= Xentry_122_symbol; -- control passed to block
            Xentry_125_symbol  <= binary_32_inputs_124_start; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/binary_32_inputs/$entry
            Xexit_126_symbol <= Xentry_125_symbol; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/binary_32_inputs/$exit
            binary_32_inputs_124_symbol <= Xexit_126_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_33/binary_32/binary_32_inputs
          rr_127_symbol <= binary_32_inputs_124_symbol; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/rr
          binary_32_inst_req_0 <= rr_127_symbol; -- link to DP
          ra_128_symbol <= binary_32_inst_ack_0; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/ra
          cr_129_symbol <= ra_128_symbol; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/cr
          binary_32_inst_req_1 <= cr_129_symbol; -- link to DP
          ca_130_symbol <= binary_32_inst_ack_1; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/ca
          Xexit_123_symbol <= ca_130_symbol; -- transition branch_block_stmt_8/assign_stmt_33/binary_32/$exit
          binary_32_121_symbol <= Xexit_123_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_33/binary_32
        Xexit_120_symbol <= binary_32_121_symbol; -- transition branch_block_stmt_8/assign_stmt_33/$exit
        assign_stmt_33_118_symbol <= Xexit_120_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_33
      assign_stmt_36_131: Block -- branch_block_stmt_8/assign_stmt_36 
        signal assign_stmt_36_131_start: Boolean;
        signal Xentry_132_symbol: Boolean;
        signal Xexit_133_symbol: Boolean;
        signal simple_obj_ref_35_134_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_36_131_start <= assign_stmt_36_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_132_symbol  <= assign_stmt_36_131_start; -- transition branch_block_stmt_8/assign_stmt_36/$entry
        simple_obj_ref_35_134: Block -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35 
          signal simple_obj_ref_35_134_start: Boolean;
          signal Xentry_135_symbol: Boolean;
          signal Xexit_136_symbol: Boolean;
          signal simple_obj_ref_35_read_137_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_35_134_start <= Xentry_132_symbol; -- control passed to block
          Xentry_135_symbol  <= simple_obj_ref_35_134_start; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/$entry
          simple_obj_ref_35_read_137: Block -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read 
            signal simple_obj_ref_35_read_137_start: Boolean;
            signal Xentry_138_symbol: Boolean;
            signal Xexit_139_symbol: Boolean;
            signal word_access_140_symbol : Boolean;
            signal merge_req_150_symbol : Boolean;
            signal merge_ack_151_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_35_read_137_start <= Xentry_135_symbol; -- control passed to block
            Xentry_138_symbol  <= simple_obj_ref_35_read_137_start; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/$entry
            word_access_140: Block -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access 
              signal word_access_140_start: Boolean;
              signal Xentry_141_symbol: Boolean;
              signal Xexit_142_symbol: Boolean;
              signal word_access_0_143_symbol : Boolean;
              -- 
            begin -- 
              word_access_140_start <= Xentry_138_symbol; -- control passed to block
              Xentry_141_symbol  <= word_access_140_start; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/$entry
              word_access_0_143: Block -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0 
                signal word_access_0_143_start: Boolean;
                signal Xentry_144_symbol: Boolean;
                signal Xexit_145_symbol: Boolean;
                signal rr_146_symbol : Boolean;
                signal ra_147_symbol : Boolean;
                signal cr_148_symbol : Boolean;
                signal ca_149_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_143_start <= Xentry_141_symbol; -- control passed to block
                Xentry_144_symbol  <= word_access_0_143_start; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0/$entry
                rr_146_symbol <= Xentry_144_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0/rr
                simple_obj_ref_35_load_0_req_0 <= rr_146_symbol; -- link to DP
                ra_147_symbol <= simple_obj_ref_35_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0/ra
                cr_148_symbol <= ra_147_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0/cr
                simple_obj_ref_35_load_0_req_1 <= cr_148_symbol; -- link to DP
                ca_149_symbol <= simple_obj_ref_35_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0/ca
                Xexit_145_symbol <= ca_149_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0/$exit
                word_access_0_143_symbol <= Xexit_145_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/word_access_0
              Xexit_142_symbol <= word_access_0_143_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access/$exit
              word_access_140_symbol <= Xexit_142_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/word_access
            merge_req_150_symbol <= word_access_140_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/merge_req
            simple_obj_ref_35_gather_scatter_req_0 <= merge_req_150_symbol; -- link to DP
            merge_ack_151_symbol <= simple_obj_ref_35_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/merge_ack
            Xexit_139_symbol <= merge_ack_151_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read/$exit
            simple_obj_ref_35_read_137_symbol <= Xexit_139_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/simple_obj_ref_35_read
          Xexit_136_symbol <= simple_obj_ref_35_read_137_symbol; -- transition branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35/$exit
          simple_obj_ref_35_134_symbol <= Xexit_136_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_36/simple_obj_ref_35
        Xexit_133_symbol <= simple_obj_ref_35_134_symbol; -- transition branch_block_stmt_8/assign_stmt_36/$exit
        assign_stmt_36_131_symbol <= Xexit_133_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_36
      assign_stmt_41_152: Block -- branch_block_stmt_8/assign_stmt_41 
        signal assign_stmt_41_152_start: Boolean;
        signal Xentry_153_symbol: Boolean;
        signal Xexit_154_symbol: Boolean;
        signal binary_40_155_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_41_152_start <= assign_stmt_41_x_xentry_x_xx_x22_symbol; -- control passed to block
        Xentry_153_symbol  <= assign_stmt_41_152_start; -- transition branch_block_stmt_8/assign_stmt_41/$entry
        binary_40_155: Block -- branch_block_stmt_8/assign_stmt_41/binary_40 
          signal binary_40_155_start: Boolean;
          signal Xentry_156_symbol: Boolean;
          signal Xexit_157_symbol: Boolean;
          signal binary_40_inputs_158_symbol : Boolean;
          signal rr_161_symbol : Boolean;
          signal ra_162_symbol : Boolean;
          signal cr_163_symbol : Boolean;
          signal ca_164_symbol : Boolean;
          -- 
        begin -- 
          binary_40_155_start <= Xentry_153_symbol; -- control passed to block
          Xentry_156_symbol  <= binary_40_155_start; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/$entry
          binary_40_inputs_158: Block -- branch_block_stmt_8/assign_stmt_41/binary_40/binary_40_inputs 
            signal binary_40_inputs_158_start: Boolean;
            signal Xentry_159_symbol: Boolean;
            signal Xexit_160_symbol: Boolean;
            -- 
          begin -- 
            binary_40_inputs_158_start <= Xentry_156_symbol; -- control passed to block
            Xentry_159_symbol  <= binary_40_inputs_158_start; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/binary_40_inputs/$entry
            Xexit_160_symbol <= Xentry_159_symbol; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/binary_40_inputs/$exit
            binary_40_inputs_158_symbol <= Xexit_160_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_41/binary_40/binary_40_inputs
          rr_161_symbol <= binary_40_inputs_158_symbol; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/rr
          binary_40_inst_req_0 <= rr_161_symbol; -- link to DP
          ra_162_symbol <= binary_40_inst_ack_0; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/ra
          cr_163_symbol <= ra_162_symbol; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/cr
          binary_40_inst_req_1 <= cr_163_symbol; -- link to DP
          ca_164_symbol <= binary_40_inst_ack_1; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/ca
          Xexit_157_symbol <= ca_164_symbol; -- transition branch_block_stmt_8/assign_stmt_41/binary_40/$exit
          binary_40_155_symbol <= Xexit_157_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_41/binary_40
        Xexit_154_symbol <= binary_40_155_symbol; -- transition branch_block_stmt_8/assign_stmt_41/$exit
        assign_stmt_41_152_symbol <= Xexit_154_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_41
      assign_stmt_44_165: Block -- branch_block_stmt_8/assign_stmt_44 
        signal assign_stmt_44_165_start: Boolean;
        signal Xentry_166_symbol: Boolean;
        signal Xexit_167_symbol: Boolean;
        signal simple_obj_ref_42_168_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_44_165_start <= assign_stmt_44_x_xentry_x_xx_x24_symbol; -- control passed to block
        Xentry_166_symbol  <= assign_stmt_44_165_start; -- transition branch_block_stmt_8/assign_stmt_44/$entry
        simple_obj_ref_42_168: Block -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42 
          signal simple_obj_ref_42_168_start: Boolean;
          signal Xentry_169_symbol: Boolean;
          signal Xexit_170_symbol: Boolean;
          signal simple_obj_ref_42_write_171_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_42_168_start <= Xentry_166_symbol; -- control passed to block
          Xentry_169_symbol  <= simple_obj_ref_42_168_start; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/$entry
          simple_obj_ref_42_write_171: Block -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write 
            signal simple_obj_ref_42_write_171_start: Boolean;
            signal Xentry_172_symbol: Boolean;
            signal Xexit_173_symbol: Boolean;
            signal split_req_174_symbol : Boolean;
            signal split_ack_175_symbol : Boolean;
            signal word_access_176_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_42_write_171_start <= Xentry_169_symbol; -- control passed to block
            Xentry_172_symbol  <= simple_obj_ref_42_write_171_start; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/$entry
            split_req_174_symbol <= Xentry_172_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/split_req
            simple_obj_ref_42_gather_scatter_req_0 <= split_req_174_symbol; -- link to DP
            split_ack_175_symbol <= simple_obj_ref_42_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/split_ack
            word_access_176: Block -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access 
              signal word_access_176_start: Boolean;
              signal Xentry_177_symbol: Boolean;
              signal Xexit_178_symbol: Boolean;
              signal word_access_0_179_symbol : Boolean;
              -- 
            begin -- 
              word_access_176_start <= split_ack_175_symbol; -- control passed to block
              Xentry_177_symbol  <= word_access_176_start; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/$entry
              word_access_0_179: Block -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0 
                signal word_access_0_179_start: Boolean;
                signal Xentry_180_symbol: Boolean;
                signal Xexit_181_symbol: Boolean;
                signal rr_182_symbol : Boolean;
                signal ra_183_symbol : Boolean;
                signal cr_184_symbol : Boolean;
                signal ca_185_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_179_start <= Xentry_177_symbol; -- control passed to block
                Xentry_180_symbol  <= word_access_0_179_start; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0/$entry
                rr_182_symbol <= Xentry_180_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0/rr
                simple_obj_ref_42_store_0_req_0 <= rr_182_symbol; -- link to DP
                ra_183_symbol <= simple_obj_ref_42_store_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0/ra
                cr_184_symbol <= ra_183_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0/cr
                simple_obj_ref_42_store_0_req_1 <= cr_184_symbol; -- link to DP
                ca_185_symbol <= simple_obj_ref_42_store_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0/ca
                Xexit_181_symbol <= ca_185_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0/$exit
                word_access_0_179_symbol <= Xexit_181_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/word_access_0
              Xexit_178_symbol <= word_access_0_179_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access/$exit
              word_access_176_symbol <= Xexit_178_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/word_access
            Xexit_173_symbol <= word_access_176_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write/$exit
            simple_obj_ref_42_write_171_symbol <= Xexit_173_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/simple_obj_ref_42_write
          Xexit_170_symbol <= simple_obj_ref_42_write_171_symbol; -- transition branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42/$exit
          simple_obj_ref_42_168_symbol <= Xexit_170_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_44/simple_obj_ref_42
        Xexit_167_symbol <= simple_obj_ref_42_168_symbol; -- transition branch_block_stmt_8/assign_stmt_44/$exit
        assign_stmt_44_165_symbol <= Xexit_167_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_44
      assign_stmt_49_186: Block -- branch_block_stmt_8/assign_stmt_49 
        signal assign_stmt_49_186_start: Boolean;
        signal Xentry_187_symbol: Boolean;
        signal Xexit_188_symbol: Boolean;
        signal simple_obj_ref_48_189_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_49_186_start <= assign_stmt_49_x_xentry_x_xx_x27_symbol; -- control passed to block
        Xentry_187_symbol  <= assign_stmt_49_186_start; -- transition branch_block_stmt_8/assign_stmt_49/$entry
        simple_obj_ref_48_189: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48 
          signal simple_obj_ref_48_189_start: Boolean;
          signal Xentry_190_symbol: Boolean;
          signal Xexit_191_symbol: Boolean;
          signal simple_obj_ref_48_read_192_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_48_189_start <= Xentry_187_symbol; -- control passed to block
          Xentry_190_symbol  <= simple_obj_ref_48_189_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/$entry
          simple_obj_ref_48_read_192: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read 
            signal simple_obj_ref_48_read_192_start: Boolean;
            signal Xentry_193_symbol: Boolean;
            signal Xexit_194_symbol: Boolean;
            signal word_access_195_symbol : Boolean;
            signal merge_req_205_symbol : Boolean;
            signal merge_ack_206_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_48_read_192_start <= Xentry_190_symbol; -- control passed to block
            Xentry_193_symbol  <= simple_obj_ref_48_read_192_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/$entry
            word_access_195: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access 
              signal word_access_195_start: Boolean;
              signal Xentry_196_symbol: Boolean;
              signal Xexit_197_symbol: Boolean;
              signal word_access_0_198_symbol : Boolean;
              -- 
            begin -- 
              word_access_195_start <= Xentry_193_symbol; -- control passed to block
              Xentry_196_symbol  <= word_access_195_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/$entry
              word_access_0_198: Block -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0 
                signal word_access_0_198_start: Boolean;
                signal Xentry_199_symbol: Boolean;
                signal Xexit_200_symbol: Boolean;
                signal rr_201_symbol : Boolean;
                signal ra_202_symbol : Boolean;
                signal cr_203_symbol : Boolean;
                signal ca_204_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_198_start <= Xentry_196_symbol; -- control passed to block
                Xentry_199_symbol  <= word_access_0_198_start; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0/$entry
                rr_201_symbol <= Xentry_199_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0/rr
                simple_obj_ref_48_load_0_req_0 <= rr_201_symbol; -- link to DP
                ra_202_symbol <= simple_obj_ref_48_load_0_ack_0; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0/ra
                cr_203_symbol <= ra_202_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0/cr
                simple_obj_ref_48_load_0_req_1 <= cr_203_symbol; -- link to DP
                ca_204_symbol <= simple_obj_ref_48_load_0_ack_1; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0/ca
                Xexit_200_symbol <= ca_204_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0/$exit
                word_access_0_198_symbol <= Xexit_200_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/word_access_0
              Xexit_197_symbol <= word_access_0_198_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access/$exit
              word_access_195_symbol <= Xexit_197_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/word_access
            merge_req_205_symbol <= word_access_195_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/merge_req
            simple_obj_ref_48_gather_scatter_req_0 <= merge_req_205_symbol; -- link to DP
            merge_ack_206_symbol <= simple_obj_ref_48_gather_scatter_ack_0; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/merge_ack
            Xexit_194_symbol <= merge_ack_206_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read/$exit
            simple_obj_ref_48_read_192_symbol <= Xexit_194_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/simple_obj_ref_48_read
          Xexit_191_symbol <= simple_obj_ref_48_read_192_symbol; -- transition branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48/$exit
          simple_obj_ref_48_189_symbol <= Xexit_191_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_8/assign_stmt_49/simple_obj_ref_48
        Xexit_188_symbol <= simple_obj_ref_48_189_symbol; -- transition branch_block_stmt_8/assign_stmt_49/$exit
        assign_stmt_49_186_symbol <= Xexit_188_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/assign_stmt_49
      return_x_xx_xPhiReq_207: Block -- branch_block_stmt_8/return___PhiReq 
        signal return_x_xx_xPhiReq_207_start: Boolean;
        signal Xentry_208_symbol: Boolean;
        signal Xexit_209_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_207_start <= return_x_xx_x29_symbol; -- control passed to block
        Xentry_208_symbol  <= return_x_xx_xPhiReq_207_start; -- transition branch_block_stmt_8/return___PhiReq/$entry
        Xexit_209_symbol <= Xentry_208_symbol; -- transition branch_block_stmt_8/return___PhiReq/$exit
        return_x_xx_xPhiReq_207_symbol <= Xexit_209_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_8/return___PhiReq
      merge_stmt_46_PhiReqMerge_210_symbol  <=  return_x_xx_xPhiReq_207_symbol; -- place branch_block_stmt_8/merge_stmt_46_PhiReqMerge (optimized away) 
      merge_stmt_46_PhiAck_211: Block -- branch_block_stmt_8/merge_stmt_46_PhiAck 
        signal merge_stmt_46_PhiAck_211_start: Boolean;
        signal Xentry_212_symbol: Boolean;
        signal Xexit_213_symbol: Boolean;
        signal dummy_214_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_46_PhiAck_211_start <= merge_stmt_46_PhiReqMerge_210_symbol; -- control passed to block
        Xentry_212_symbol  <= merge_stmt_46_PhiAck_211_start; -- transition branch_block_stmt_8/merge_stmt_46_PhiAck/$entry
        dummy_214_symbol <= Xentry_212_symbol; -- transition branch_block_stmt_8/merge_stmt_46_PhiAck/dummy
        Xexit_213_symbol <= dummy_214_symbol; -- transition branch_block_stmt_8/merge_stmt_46_PhiAck/$exit
        merge_stmt_46_PhiAck_211_symbol <= Xexit_213_symbol; -- control passed from block 
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
    signal xxsub_slavexxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    signal xxsub_slavexxsub_slavexxiNsTr_0_base_address : std_logic_vector(0 downto 0);
    signal xxsub_slavexxsub_slavexxiNsTr_1_base_address : std_logic_vector(0 downto 0);
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
    xxsub_slavexxstored_ret_val_x_xx_xbase_address <= "0";
    xxsub_slavexxsub_slavexxiNsTr_0_base_address <= "0";
    xxsub_slavexxsub_slavexxiNsTr_1_base_address <= "0";
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
