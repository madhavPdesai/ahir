-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant free_list_base_address : std_logic_vector(2 downto 0) := "000";
  constant head_base_address : std_logic_vector(0 downto 0) := "0";
  constant mempool_base_address : std_logic_vector(0 downto 0) := "0";
  constant xx_xstr1_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr2_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr3_base_address : std_logic_vector(2 downto 0) := "000";
  constant xx_xstr4_base_address : std_logic_vector(2 downto 0) := "000";
  constant xx_xstr5_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr6_base_address : std_logic_vector(3 downto 0) := "0000";
  constant xx_xstr_base_address : std_logic_vector(4 downto 0) := "00000";
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
entity foo is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(2 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(2 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
    foo_in_pipe_read_req : out  std_logic_vector(0 downto 0);
    foo_in_pipe_read_ack : in   std_logic_vector(0 downto 0);
    foo_in_pipe_read_data : in   std_logic_vector(31 downto 0);
    foo_out_pipe_write_req : out  std_logic_vector(0 downto 0);
    foo_out_pipe_write_ack : in   std_logic_vector(0 downto 0);
    foo_out_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity foo;
architecture Default of foo is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal binary_85_inst_req_0 : boolean;
  signal binary_85_inst_ack_0 : boolean;
  signal binary_85_inst_req_1 : boolean;
  signal simple_obj_ref_66_inst_req_0 : boolean;
  signal simple_obj_ref_66_inst_ack_0 : boolean;
  signal type_cast_67_inst_req_0 : boolean;
  signal type_cast_67_inst_ack_0 : boolean;
  signal array_obj_ref_71_base_resize_req_0 : boolean;
  signal array_obj_ref_71_base_resize_ack_0 : boolean;
  signal array_obj_ref_71_root_address_inst_req_0 : boolean;
  signal array_obj_ref_71_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_71_final_reg_req_0 : boolean;
  signal array_obj_ref_71_final_reg_ack_0 : boolean;
  signal type_cast_76_inst_req_0 : boolean;
  signal type_cast_76_inst_ack_0 : boolean;
  signal ptr_deref_80_base_resize_req_0 : boolean;
  signal ptr_deref_80_base_resize_ack_0 : boolean;
  signal ptr_deref_80_root_address_inst_req_0 : boolean;
  signal ptr_deref_80_root_address_inst_ack_0 : boolean;
  signal ptr_deref_80_addr_0_req_0 : boolean;
  signal ptr_deref_80_addr_0_ack_0 : boolean;
  signal ptr_deref_80_load_0_req_0 : boolean;
  signal ptr_deref_80_load_0_ack_0 : boolean;
  signal ptr_deref_80_load_0_req_1 : boolean;
  signal ptr_deref_80_load_0_ack_1 : boolean;
  signal ptr_deref_80_gather_scatter_req_0 : boolean;
  signal ptr_deref_80_gather_scatter_ack_0 : boolean;
  signal binary_85_inst_ack_1 : boolean;
  signal ptr_deref_88_base_resize_req_0 : boolean;
  signal ptr_deref_88_base_resize_ack_0 : boolean;
  signal ptr_deref_88_root_address_inst_req_0 : boolean;
  signal ptr_deref_88_root_address_inst_ack_0 : boolean;
  signal ptr_deref_88_addr_0_req_0 : boolean;
  signal ptr_deref_88_addr_0_ack_0 : boolean;
  signal ptr_deref_88_gather_scatter_req_0 : boolean;
  signal ptr_deref_88_gather_scatter_ack_0 : boolean;
  signal ptr_deref_88_store_0_req_0 : boolean;
  signal ptr_deref_88_store_0_ack_0 : boolean;
  signal ptr_deref_88_store_0_req_1 : boolean;
  signal ptr_deref_88_store_0_ack_1 : boolean;
  signal type_cast_98_inst_req_0 : boolean;
  signal type_cast_98_inst_ack_0 : boolean;
  signal simple_obj_ref_96_inst_req_0 : boolean;
  signal simple_obj_ref_96_inst_ack_0 : boolean;
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
  foo_CP_0: Block -- control-path 
    signal foo_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_56_3_symbol : Boolean;
    -- 
  begin -- 
    foo_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= foo_CP_0_start; -- transition $entry
    branch_block_stmt_56_3: Block -- branch_block_stmt_56 
      signal branch_block_stmt_56_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_56_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_56_x_xexit_x_xx_x7_symbol : Boolean;
      signal bb_0_bb_1_8_symbol : Boolean;
      signal merge_stmt_58_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_63_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_63_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_68_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_68_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_72_to_assign_stmt_95_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_72_to_assign_stmt_95_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_99_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_99_x_xexit_x_xx_x17_symbol : Boolean;
      signal bb_1_bb_1_18_symbol : Boolean;
      signal assign_stmt_63_19_symbol : Boolean;
      signal assign_stmt_68_22_symbol : Boolean;
      signal assign_stmt_72_to_assign_stmt_95_40_symbol : Boolean;
      signal assign_stmt_99_184_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_203_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_206_symbol : Boolean;
      signal merge_stmt_58_PhiReqMerge_209_symbol : Boolean;
      signal merge_stmt_58_PhiAck_210_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_56_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_56_3_start; -- transition branch_block_stmt_56/$entry
      branch_block_stmt_56_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_56/branch_block_stmt_56__entry__ (optimized away) 
      branch_block_stmt_56_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_56/branch_block_stmt_56__exit__ (optimized away) 
      bb_0_bb_1_8_symbol  <=  branch_block_stmt_56_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_56/bb_0_bb_1 (optimized away) 
      merge_stmt_58_x_xexit_x_xx_x9_symbol  <=  merge_stmt_58_PhiAck_210_symbol; -- place branch_block_stmt_56/merge_stmt_58__exit__ (optimized away) 
      assign_stmt_63_x_xentry_x_xx_x10_symbol  <=  merge_stmt_58_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_56/assign_stmt_63__entry__ (optimized away) 
      assign_stmt_63_x_xexit_x_xx_x11_symbol  <=  assign_stmt_63_19_symbol; -- place branch_block_stmt_56/assign_stmt_63__exit__ (optimized away) 
      assign_stmt_68_x_xentry_x_xx_x12_symbol  <=  assign_stmt_63_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_56/assign_stmt_68__entry__ (optimized away) 
      assign_stmt_68_x_xexit_x_xx_x13_symbol  <=  assign_stmt_68_22_symbol; -- place branch_block_stmt_56/assign_stmt_68__exit__ (optimized away) 
      assign_stmt_72_to_assign_stmt_95_x_xentry_x_xx_x14_symbol  <=  assign_stmt_68_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95__entry__ (optimized away) 
      assign_stmt_72_to_assign_stmt_95_x_xexit_x_xx_x15_symbol  <=  assign_stmt_72_to_assign_stmt_95_40_symbol; -- place branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95__exit__ (optimized away) 
      assign_stmt_99_x_xentry_x_xx_x16_symbol  <=  assign_stmt_72_to_assign_stmt_95_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_56/assign_stmt_99__entry__ (optimized away) 
      assign_stmt_99_x_xexit_x_xx_x17_symbol  <=  assign_stmt_99_184_symbol; -- place branch_block_stmt_56/assign_stmt_99__exit__ (optimized away) 
      bb_1_bb_1_18_symbol  <=  assign_stmt_99_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_56/bb_1_bb_1 (optimized away) 
      assign_stmt_63_19: Block -- branch_block_stmt_56/assign_stmt_63 
        signal assign_stmt_63_19_start: Boolean;
        signal Xentry_20_symbol: Boolean;
        signal Xexit_21_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_63_19_start <= assign_stmt_63_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_20_symbol  <= assign_stmt_63_19_start; -- transition branch_block_stmt_56/assign_stmt_63/$entry
        Xexit_21_symbol <= Xentry_20_symbol; -- transition branch_block_stmt_56/assign_stmt_63/$exit
        assign_stmt_63_19_symbol <= Xexit_21_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/assign_stmt_63
      assign_stmt_68_22: Block -- branch_block_stmt_56/assign_stmt_68 
        signal assign_stmt_68_22_start: Boolean;
        signal Xentry_23_symbol: Boolean;
        signal Xexit_24_symbol: Boolean;
        signal assign_stmt_68_active_x_x25_symbol : Boolean;
        signal assign_stmt_68_completed_x_x26_symbol : Boolean;
        signal type_cast_67_active_x_x27_symbol : Boolean;
        signal type_cast_67_trigger_x_x28_symbol : Boolean;
        signal simple_obj_ref_66_trigger_x_x29_symbol : Boolean;
        signal simple_obj_ref_66_complete_30_symbol : Boolean;
        signal type_cast_67_complete_35_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_68_22_start <= assign_stmt_68_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_23_symbol  <= assign_stmt_68_22_start; -- transition branch_block_stmt_56/assign_stmt_68/$entry
        assign_stmt_68_active_x_x25_symbol <= type_cast_67_complete_35_symbol; -- transition branch_block_stmt_56/assign_stmt_68/assign_stmt_68_active_
        assign_stmt_68_completed_x_x26_symbol <= assign_stmt_68_active_x_x25_symbol; -- transition branch_block_stmt_56/assign_stmt_68/assign_stmt_68_completed_
        type_cast_67_active_x_x27_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_68/type_cast_67_active_ 
          signal type_cast_67_active_x_x27_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_67_active_x_x27_predecessors(0) <= type_cast_67_trigger_x_x28_symbol;
          type_cast_67_active_x_x27_predecessors(1) <= simple_obj_ref_66_complete_30_symbol;
          type_cast_67_active_x_x27_join: join -- 
            port map( -- 
              preds => type_cast_67_active_x_x27_predecessors,
              symbol_out => type_cast_67_active_x_x27_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_68/type_cast_67_active_
        type_cast_67_trigger_x_x28_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_56/assign_stmt_68/type_cast_67_trigger_
        simple_obj_ref_66_trigger_x_x29_symbol <= Xentry_23_symbol; -- transition branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_trigger_
        simple_obj_ref_66_complete_30: Block -- branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_complete 
          signal simple_obj_ref_66_complete_30_start: Boolean;
          signal Xentry_31_symbol: Boolean;
          signal Xexit_32_symbol: Boolean;
          signal req_33_symbol : Boolean;
          signal ack_34_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_66_complete_30_start <= simple_obj_ref_66_trigger_x_x29_symbol; -- control passed to block
          Xentry_31_symbol  <= simple_obj_ref_66_complete_30_start; -- transition branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_complete/$entry
          req_33_symbol <= Xentry_31_symbol; -- transition branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_complete/req
          simple_obj_ref_66_inst_req_0 <= req_33_symbol; -- link to DP
          ack_34_symbol <= simple_obj_ref_66_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_complete/ack
          Xexit_32_symbol <= ack_34_symbol; -- transition branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_complete/$exit
          simple_obj_ref_66_complete_30_symbol <= Xexit_32_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_68/simple_obj_ref_66_complete
        type_cast_67_complete_35: Block -- branch_block_stmt_56/assign_stmt_68/type_cast_67_complete 
          signal type_cast_67_complete_35_start: Boolean;
          signal Xentry_36_symbol: Boolean;
          signal Xexit_37_symbol: Boolean;
          signal req_38_symbol : Boolean;
          signal ack_39_symbol : Boolean;
          -- 
        begin -- 
          type_cast_67_complete_35_start <= type_cast_67_active_x_x27_symbol; -- control passed to block
          Xentry_36_symbol  <= type_cast_67_complete_35_start; -- transition branch_block_stmt_56/assign_stmt_68/type_cast_67_complete/$entry
          req_38_symbol <= Xentry_36_symbol; -- transition branch_block_stmt_56/assign_stmt_68/type_cast_67_complete/req
          type_cast_67_inst_req_0 <= req_38_symbol; -- link to DP
          ack_39_symbol <= type_cast_67_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_68/type_cast_67_complete/ack
          Xexit_37_symbol <= ack_39_symbol; -- transition branch_block_stmt_56/assign_stmt_68/type_cast_67_complete/$exit
          type_cast_67_complete_35_symbol <= Xexit_37_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_68/type_cast_67_complete
        Xexit_24_symbol <= assign_stmt_68_completed_x_x26_symbol; -- transition branch_block_stmt_56/assign_stmt_68/$exit
        assign_stmt_68_22_symbol <= Xexit_24_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/assign_stmt_68
      assign_stmt_72_to_assign_stmt_95_40: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95 
        signal assign_stmt_72_to_assign_stmt_95_40_start: Boolean;
        signal Xentry_41_symbol: Boolean;
        signal Xexit_42_symbol: Boolean;
        signal assign_stmt_72_active_x_x43_symbol : Boolean;
        signal assign_stmt_72_completed_x_x44_symbol : Boolean;
        signal array_obj_ref_71_trigger_x_x45_symbol : Boolean;
        signal array_obj_ref_71_active_x_x46_symbol : Boolean;
        signal array_obj_ref_71_base_address_calculated_47_symbol : Boolean;
        signal array_obj_ref_71_root_address_calculated_48_symbol : Boolean;
        signal array_obj_ref_71_base_address_resized_49_symbol : Boolean;
        signal array_obj_ref_71_base_addr_resize_50_symbol : Boolean;
        signal array_obj_ref_71_base_plus_offset_55_symbol : Boolean;
        signal array_obj_ref_71_complete_60_symbol : Boolean;
        signal assign_stmt_77_active_x_x65_symbol : Boolean;
        signal assign_stmt_77_completed_x_x66_symbol : Boolean;
        signal type_cast_76_active_x_x67_symbol : Boolean;
        signal type_cast_76_trigger_x_x68_symbol : Boolean;
        signal simple_obj_ref_75_complete_69_symbol : Boolean;
        signal type_cast_76_complete_70_symbol : Boolean;
        signal assign_stmt_81_active_x_x75_symbol : Boolean;
        signal assign_stmt_81_completed_x_x76_symbol : Boolean;
        signal ptr_deref_80_trigger_x_x77_symbol : Boolean;
        signal ptr_deref_80_active_x_x78_symbol : Boolean;
        signal ptr_deref_80_base_address_calculated_79_symbol : Boolean;
        signal simple_obj_ref_79_complete_80_symbol : Boolean;
        signal ptr_deref_80_root_address_calculated_81_symbol : Boolean;
        signal ptr_deref_80_word_address_calculated_82_symbol : Boolean;
        signal ptr_deref_80_base_address_resized_83_symbol : Boolean;
        signal ptr_deref_80_base_addr_resize_84_symbol : Boolean;
        signal ptr_deref_80_base_plus_offset_89_symbol : Boolean;
        signal ptr_deref_80_word_addrgen_94_symbol : Boolean;
        signal ptr_deref_80_request_99_symbol : Boolean;
        signal ptr_deref_80_complete_110_symbol : Boolean;
        signal assign_stmt_86_active_x_x123_symbol : Boolean;
        signal assign_stmt_86_completed_x_x124_symbol : Boolean;
        signal binary_85_active_x_x125_symbol : Boolean;
        signal binary_85_trigger_x_x126_symbol : Boolean;
        signal simple_obj_ref_83_complete_127_symbol : Boolean;
        signal binary_85_complete_128_symbol : Boolean;
        signal assign_stmt_90_active_x_x135_symbol : Boolean;
        signal assign_stmt_90_completed_x_x136_symbol : Boolean;
        signal simple_obj_ref_89_complete_137_symbol : Boolean;
        signal ptr_deref_88_trigger_x_x138_symbol : Boolean;
        signal ptr_deref_88_active_x_x139_symbol : Boolean;
        signal ptr_deref_88_base_address_calculated_140_symbol : Boolean;
        signal simple_obj_ref_87_complete_141_symbol : Boolean;
        signal ptr_deref_88_root_address_calculated_142_symbol : Boolean;
        signal ptr_deref_88_word_address_calculated_143_symbol : Boolean;
        signal ptr_deref_88_base_address_resized_144_symbol : Boolean;
        signal ptr_deref_88_base_addr_resize_145_symbol : Boolean;
        signal ptr_deref_88_base_plus_offset_150_symbol : Boolean;
        signal ptr_deref_88_word_addrgen_155_symbol : Boolean;
        signal ptr_deref_88_request_160_symbol : Boolean;
        signal ptr_deref_88_complete_173_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_72_to_assign_stmt_95_40_start <= assign_stmt_72_to_assign_stmt_95_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_41_symbol  <= assign_stmt_72_to_assign_stmt_95_40_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/$entry
        assign_stmt_72_active_x_x43_symbol <= array_obj_ref_71_complete_60_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_72_active_
        assign_stmt_72_completed_x_x44_symbol <= assign_stmt_72_active_x_x43_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_72_completed_
        array_obj_ref_71_trigger_x_x45_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_trigger_
        array_obj_ref_71_active_x_x46_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_active_ 
          signal array_obj_ref_71_active_x_x46_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          array_obj_ref_71_active_x_x46_predecessors(0) <= array_obj_ref_71_trigger_x_x45_symbol;
          array_obj_ref_71_active_x_x46_predecessors(1) <= array_obj_ref_71_root_address_calculated_48_symbol;
          array_obj_ref_71_active_x_x46_join: join -- 
            port map( -- 
              preds => array_obj_ref_71_active_x_x46_predecessors,
              symbol_out => array_obj_ref_71_active_x_x46_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_active_
        array_obj_ref_71_base_address_calculated_47_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_address_calculated
        array_obj_ref_71_root_address_calculated_48_symbol <= array_obj_ref_71_base_plus_offset_55_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_root_address_calculated
        array_obj_ref_71_base_address_resized_49_symbol <= array_obj_ref_71_base_addr_resize_50_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_address_resized
        array_obj_ref_71_base_addr_resize_50: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_addr_resize 
          signal array_obj_ref_71_base_addr_resize_50_start: Boolean;
          signal Xentry_51_symbol: Boolean;
          signal Xexit_52_symbol: Boolean;
          signal base_resize_req_53_symbol : Boolean;
          signal base_resize_ack_54_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_71_base_addr_resize_50_start <= array_obj_ref_71_base_address_calculated_47_symbol; -- control passed to block
          Xentry_51_symbol  <= array_obj_ref_71_base_addr_resize_50_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_addr_resize/$entry
          base_resize_req_53_symbol <= Xentry_51_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_addr_resize/base_resize_req
          array_obj_ref_71_base_resize_req_0 <= base_resize_req_53_symbol; -- link to DP
          base_resize_ack_54_symbol <= array_obj_ref_71_base_resize_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_addr_resize/base_resize_ack
          Xexit_52_symbol <= base_resize_ack_54_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_addr_resize/$exit
          array_obj_ref_71_base_addr_resize_50_symbol <= Xexit_52_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_addr_resize
        array_obj_ref_71_base_plus_offset_55: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_plus_offset 
          signal array_obj_ref_71_base_plus_offset_55_start: Boolean;
          signal Xentry_56_symbol: Boolean;
          signal Xexit_57_symbol: Boolean;
          signal sum_rename_req_58_symbol : Boolean;
          signal sum_rename_ack_59_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_71_base_plus_offset_55_start <= array_obj_ref_71_base_address_resized_49_symbol; -- control passed to block
          Xentry_56_symbol  <= array_obj_ref_71_base_plus_offset_55_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_plus_offset/$entry
          sum_rename_req_58_symbol <= Xentry_56_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_plus_offset/sum_rename_req
          array_obj_ref_71_root_address_inst_req_0 <= sum_rename_req_58_symbol; -- link to DP
          sum_rename_ack_59_symbol <= array_obj_ref_71_root_address_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_plus_offset/sum_rename_ack
          Xexit_57_symbol <= sum_rename_ack_59_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_plus_offset/$exit
          array_obj_ref_71_base_plus_offset_55_symbol <= Xexit_57_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_base_plus_offset
        array_obj_ref_71_complete_60: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_complete 
          signal array_obj_ref_71_complete_60_start: Boolean;
          signal Xentry_61_symbol: Boolean;
          signal Xexit_62_symbol: Boolean;
          signal final_reg_req_63_symbol : Boolean;
          signal final_reg_ack_64_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_71_complete_60_start <= array_obj_ref_71_active_x_x46_symbol; -- control passed to block
          Xentry_61_symbol  <= array_obj_ref_71_complete_60_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_complete/$entry
          final_reg_req_63_symbol <= Xentry_61_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_complete/final_reg_req
          array_obj_ref_71_final_reg_req_0 <= final_reg_req_63_symbol; -- link to DP
          final_reg_ack_64_symbol <= array_obj_ref_71_final_reg_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_complete/final_reg_ack
          Xexit_62_symbol <= final_reg_ack_64_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_complete/$exit
          array_obj_ref_71_complete_60_symbol <= Xexit_62_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/array_obj_ref_71_complete
        assign_stmt_77_active_x_x65_symbol <= type_cast_76_complete_70_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_77_active_
        assign_stmt_77_completed_x_x66_symbol <= assign_stmt_77_active_x_x65_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_77_completed_
        type_cast_76_active_x_x67_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_active_ 
          signal type_cast_76_active_x_x67_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_76_active_x_x67_predecessors(0) <= type_cast_76_trigger_x_x68_symbol;
          type_cast_76_active_x_x67_predecessors(1) <= simple_obj_ref_75_complete_69_symbol;
          type_cast_76_active_x_x67_join: join -- 
            port map( -- 
              preds => type_cast_76_active_x_x67_predecessors,
              symbol_out => type_cast_76_active_x_x67_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_active_
        type_cast_76_trigger_x_x68_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_trigger_
        simple_obj_ref_75_complete_69_symbol <= assign_stmt_72_completed_x_x44_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/simple_obj_ref_75_complete
        type_cast_76_complete_70: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_complete 
          signal type_cast_76_complete_70_start: Boolean;
          signal Xentry_71_symbol: Boolean;
          signal Xexit_72_symbol: Boolean;
          signal req_73_symbol : Boolean;
          signal ack_74_symbol : Boolean;
          -- 
        begin -- 
          type_cast_76_complete_70_start <= type_cast_76_active_x_x67_symbol; -- control passed to block
          Xentry_71_symbol  <= type_cast_76_complete_70_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_complete/$entry
          req_73_symbol <= Xentry_71_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_complete/req
          type_cast_76_inst_req_0 <= req_73_symbol; -- link to DP
          ack_74_symbol <= type_cast_76_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_complete/ack
          Xexit_72_symbol <= ack_74_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_complete/$exit
          type_cast_76_complete_70_symbol <= Xexit_72_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/type_cast_76_complete
        assign_stmt_81_active_x_x75_symbol <= ptr_deref_80_complete_110_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_81_active_
        assign_stmt_81_completed_x_x76_symbol <= assign_stmt_81_active_x_x75_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_81_completed_
        ptr_deref_80_trigger_x_x77_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_trigger_ 
          signal ptr_deref_80_trigger_x_x77_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_80_trigger_x_x77_predecessors(0) <= ptr_deref_80_word_address_calculated_82_symbol;
          ptr_deref_80_trigger_x_x77_predecessors(1) <= ptr_deref_80_base_address_calculated_79_symbol;
          ptr_deref_80_trigger_x_x77_join: join -- 
            port map( -- 
              preds => ptr_deref_80_trigger_x_x77_predecessors,
              symbol_out => ptr_deref_80_trigger_x_x77_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_trigger_
        ptr_deref_80_active_x_x78_symbol <= ptr_deref_80_request_99_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_active_
        ptr_deref_80_base_address_calculated_79_symbol <= simple_obj_ref_79_complete_80_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_address_calculated
        simple_obj_ref_79_complete_80_symbol <= assign_stmt_77_completed_x_x66_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/simple_obj_ref_79_complete
        ptr_deref_80_root_address_calculated_81_symbol <= ptr_deref_80_base_plus_offset_89_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_root_address_calculated
        ptr_deref_80_word_address_calculated_82_symbol <= ptr_deref_80_word_addrgen_94_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_address_calculated
        ptr_deref_80_base_address_resized_83_symbol <= ptr_deref_80_base_addr_resize_84_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_address_resized
        ptr_deref_80_base_addr_resize_84: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_addr_resize 
          signal ptr_deref_80_base_addr_resize_84_start: Boolean;
          signal Xentry_85_symbol: Boolean;
          signal Xexit_86_symbol: Boolean;
          signal base_resize_req_87_symbol : Boolean;
          signal base_resize_ack_88_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_80_base_addr_resize_84_start <= ptr_deref_80_base_address_calculated_79_symbol; -- control passed to block
          Xentry_85_symbol  <= ptr_deref_80_base_addr_resize_84_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_addr_resize/$entry
          base_resize_req_87_symbol <= Xentry_85_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_addr_resize/base_resize_req
          ptr_deref_80_base_resize_req_0 <= base_resize_req_87_symbol; -- link to DP
          base_resize_ack_88_symbol <= ptr_deref_80_base_resize_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_addr_resize/base_resize_ack
          Xexit_86_symbol <= base_resize_ack_88_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_addr_resize/$exit
          ptr_deref_80_base_addr_resize_84_symbol <= Xexit_86_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_addr_resize
        ptr_deref_80_base_plus_offset_89: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_plus_offset 
          signal ptr_deref_80_base_plus_offset_89_start: Boolean;
          signal Xentry_90_symbol: Boolean;
          signal Xexit_91_symbol: Boolean;
          signal sum_rename_req_92_symbol : Boolean;
          signal sum_rename_ack_93_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_80_base_plus_offset_89_start <= ptr_deref_80_base_address_resized_83_symbol; -- control passed to block
          Xentry_90_symbol  <= ptr_deref_80_base_plus_offset_89_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_plus_offset/$entry
          sum_rename_req_92_symbol <= Xentry_90_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_plus_offset/sum_rename_req
          ptr_deref_80_root_address_inst_req_0 <= sum_rename_req_92_symbol; -- link to DP
          sum_rename_ack_93_symbol <= ptr_deref_80_root_address_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_plus_offset/sum_rename_ack
          Xexit_91_symbol <= sum_rename_ack_93_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_plus_offset/$exit
          ptr_deref_80_base_plus_offset_89_symbol <= Xexit_91_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_base_plus_offset
        ptr_deref_80_word_addrgen_94: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_addrgen 
          signal ptr_deref_80_word_addrgen_94_start: Boolean;
          signal Xentry_95_symbol: Boolean;
          signal Xexit_96_symbol: Boolean;
          signal root_rename_req_97_symbol : Boolean;
          signal root_rename_ack_98_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_80_word_addrgen_94_start <= ptr_deref_80_root_address_calculated_81_symbol; -- control passed to block
          Xentry_95_symbol  <= ptr_deref_80_word_addrgen_94_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_addrgen/$entry
          root_rename_req_97_symbol <= Xentry_95_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_addrgen/root_rename_req
          ptr_deref_80_addr_0_req_0 <= root_rename_req_97_symbol; -- link to DP
          root_rename_ack_98_symbol <= ptr_deref_80_addr_0_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_addrgen/root_rename_ack
          Xexit_96_symbol <= root_rename_ack_98_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_addrgen/$exit
          ptr_deref_80_word_addrgen_94_symbol <= Xexit_96_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_word_addrgen
        ptr_deref_80_request_99: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request 
          signal ptr_deref_80_request_99_start: Boolean;
          signal Xentry_100_symbol: Boolean;
          signal Xexit_101_symbol: Boolean;
          signal word_access_102_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_80_request_99_start <= ptr_deref_80_trigger_x_x77_symbol; -- control passed to block
          Xentry_100_symbol  <= ptr_deref_80_request_99_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/$entry
          word_access_102: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access 
            signal word_access_102_start: Boolean;
            signal Xentry_103_symbol: Boolean;
            signal Xexit_104_symbol: Boolean;
            signal word_access_0_105_symbol : Boolean;
            -- 
          begin -- 
            word_access_102_start <= Xentry_100_symbol; -- control passed to block
            Xentry_103_symbol  <= word_access_102_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/$entry
            word_access_0_105: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/word_access_0 
              signal word_access_0_105_start: Boolean;
              signal Xentry_106_symbol: Boolean;
              signal Xexit_107_symbol: Boolean;
              signal rr_108_symbol : Boolean;
              signal ra_109_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_105_start <= Xentry_103_symbol; -- control passed to block
              Xentry_106_symbol  <= word_access_0_105_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/word_access_0/$entry
              rr_108_symbol <= Xentry_106_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/word_access_0/rr
              ptr_deref_80_load_0_req_0 <= rr_108_symbol; -- link to DP
              ra_109_symbol <= ptr_deref_80_load_0_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/word_access_0/ra
              Xexit_107_symbol <= ra_109_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/word_access_0/$exit
              word_access_0_105_symbol <= Xexit_107_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/word_access_0
            Xexit_104_symbol <= word_access_0_105_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access/$exit
            word_access_102_symbol <= Xexit_104_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/word_access
          Xexit_101_symbol <= word_access_102_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request/$exit
          ptr_deref_80_request_99_symbol <= Xexit_101_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_request
        ptr_deref_80_complete_110: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete 
          signal ptr_deref_80_complete_110_start: Boolean;
          signal Xentry_111_symbol: Boolean;
          signal Xexit_112_symbol: Boolean;
          signal word_access_113_symbol : Boolean;
          signal merge_req_121_symbol : Boolean;
          signal merge_ack_122_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_80_complete_110_start <= ptr_deref_80_active_x_x78_symbol; -- control passed to block
          Xentry_111_symbol  <= ptr_deref_80_complete_110_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/$entry
          word_access_113: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access 
            signal word_access_113_start: Boolean;
            signal Xentry_114_symbol: Boolean;
            signal Xexit_115_symbol: Boolean;
            signal word_access_0_116_symbol : Boolean;
            -- 
          begin -- 
            word_access_113_start <= Xentry_111_symbol; -- control passed to block
            Xentry_114_symbol  <= word_access_113_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/$entry
            word_access_0_116: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/word_access_0 
              signal word_access_0_116_start: Boolean;
              signal Xentry_117_symbol: Boolean;
              signal Xexit_118_symbol: Boolean;
              signal cr_119_symbol : Boolean;
              signal ca_120_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_116_start <= Xentry_114_symbol; -- control passed to block
              Xentry_117_symbol  <= word_access_0_116_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/word_access_0/$entry
              cr_119_symbol <= Xentry_117_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/word_access_0/cr
              ptr_deref_80_load_0_req_1 <= cr_119_symbol; -- link to DP
              ca_120_symbol <= ptr_deref_80_load_0_ack_1; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/word_access_0/ca
              Xexit_118_symbol <= ca_120_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/word_access_0/$exit
              word_access_0_116_symbol <= Xexit_118_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/word_access_0
            Xexit_115_symbol <= word_access_0_116_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access/$exit
            word_access_113_symbol <= Xexit_115_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/word_access
          merge_req_121_symbol <= word_access_113_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/merge_req
          ptr_deref_80_gather_scatter_req_0 <= merge_req_121_symbol; -- link to DP
          merge_ack_122_symbol <= ptr_deref_80_gather_scatter_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/merge_ack
          Xexit_112_symbol <= merge_ack_122_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete/$exit
          ptr_deref_80_complete_110_symbol <= Xexit_112_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_80_complete
        assign_stmt_86_active_x_x123_symbol <= binary_85_complete_128_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_86_active_
        assign_stmt_86_completed_x_x124_symbol <= assign_stmt_86_active_x_x123_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_86_completed_
        binary_85_active_x_x125_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_active_ 
          signal binary_85_active_x_x125_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_85_active_x_x125_predecessors(0) <= binary_85_trigger_x_x126_symbol;
          binary_85_active_x_x125_predecessors(1) <= simple_obj_ref_83_complete_127_symbol;
          binary_85_active_x_x125_join: join -- 
            port map( -- 
              preds => binary_85_active_x_x125_predecessors,
              symbol_out => binary_85_active_x_x125_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_active_
        binary_85_trigger_x_x126_symbol <= Xentry_41_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_trigger_
        simple_obj_ref_83_complete_127_symbol <= assign_stmt_81_completed_x_x76_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/simple_obj_ref_83_complete
        binary_85_complete_128: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete 
          signal binary_85_complete_128_start: Boolean;
          signal Xentry_129_symbol: Boolean;
          signal Xexit_130_symbol: Boolean;
          signal rr_131_symbol : Boolean;
          signal ra_132_symbol : Boolean;
          signal cr_133_symbol : Boolean;
          signal ca_134_symbol : Boolean;
          -- 
        begin -- 
          binary_85_complete_128_start <= binary_85_active_x_x125_symbol; -- control passed to block
          Xentry_129_symbol  <= binary_85_complete_128_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete/$entry
          rr_131_symbol <= Xentry_129_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete/rr
          binary_85_inst_req_0 <= rr_131_symbol; -- link to DP
          ra_132_symbol <= binary_85_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete/ra
          cr_133_symbol <= ra_132_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete/cr
          binary_85_inst_req_1 <= cr_133_symbol; -- link to DP
          ca_134_symbol <= binary_85_inst_ack_1; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete/ca
          Xexit_130_symbol <= ca_134_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete/$exit
          binary_85_complete_128_symbol <= Xexit_130_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/binary_85_complete
        assign_stmt_90_active_x_x135_symbol <= simple_obj_ref_89_complete_137_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_90_active_
        assign_stmt_90_completed_x_x136_symbol <= ptr_deref_88_complete_173_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/assign_stmt_90_completed_
        simple_obj_ref_89_complete_137_symbol <= assign_stmt_86_completed_x_x124_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/simple_obj_ref_89_complete
        ptr_deref_88_trigger_x_x138_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_trigger_ 
          signal ptr_deref_88_trigger_x_x138_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          ptr_deref_88_trigger_x_x138_predecessors(0) <= ptr_deref_88_word_address_calculated_143_symbol;
          ptr_deref_88_trigger_x_x138_predecessors(1) <= ptr_deref_88_base_address_calculated_140_symbol;
          ptr_deref_88_trigger_x_x138_predecessors(2) <= assign_stmt_90_active_x_x135_symbol;
          ptr_deref_88_trigger_x_x138_predecessors(3) <= ptr_deref_80_active_x_x78_symbol;
          ptr_deref_88_trigger_x_x138_join: join -- 
            port map( -- 
              preds => ptr_deref_88_trigger_x_x138_predecessors,
              symbol_out => ptr_deref_88_trigger_x_x138_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_trigger_
        ptr_deref_88_active_x_x139_symbol <= ptr_deref_88_request_160_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_active_
        ptr_deref_88_base_address_calculated_140_symbol <= simple_obj_ref_87_complete_141_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_address_calculated
        simple_obj_ref_87_complete_141_symbol <= assign_stmt_77_completed_x_x66_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/simple_obj_ref_87_complete
        ptr_deref_88_root_address_calculated_142_symbol <= ptr_deref_88_base_plus_offset_150_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_root_address_calculated
        ptr_deref_88_word_address_calculated_143_symbol <= ptr_deref_88_word_addrgen_155_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_address_calculated
        ptr_deref_88_base_address_resized_144_symbol <= ptr_deref_88_base_addr_resize_145_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_address_resized
        ptr_deref_88_base_addr_resize_145: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_addr_resize 
          signal ptr_deref_88_base_addr_resize_145_start: Boolean;
          signal Xentry_146_symbol: Boolean;
          signal Xexit_147_symbol: Boolean;
          signal base_resize_req_148_symbol : Boolean;
          signal base_resize_ack_149_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_base_addr_resize_145_start <= ptr_deref_88_base_address_calculated_140_symbol; -- control passed to block
          Xentry_146_symbol  <= ptr_deref_88_base_addr_resize_145_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_addr_resize/$entry
          base_resize_req_148_symbol <= Xentry_146_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_addr_resize/base_resize_req
          ptr_deref_88_base_resize_req_0 <= base_resize_req_148_symbol; -- link to DP
          base_resize_ack_149_symbol <= ptr_deref_88_base_resize_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_addr_resize/base_resize_ack
          Xexit_147_symbol <= base_resize_ack_149_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_addr_resize/$exit
          ptr_deref_88_base_addr_resize_145_symbol <= Xexit_147_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_addr_resize
        ptr_deref_88_base_plus_offset_150: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_plus_offset 
          signal ptr_deref_88_base_plus_offset_150_start: Boolean;
          signal Xentry_151_symbol: Boolean;
          signal Xexit_152_symbol: Boolean;
          signal sum_rename_req_153_symbol : Boolean;
          signal sum_rename_ack_154_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_base_plus_offset_150_start <= ptr_deref_88_base_address_resized_144_symbol; -- control passed to block
          Xentry_151_symbol  <= ptr_deref_88_base_plus_offset_150_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_plus_offset/$entry
          sum_rename_req_153_symbol <= Xentry_151_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_plus_offset/sum_rename_req
          ptr_deref_88_root_address_inst_req_0 <= sum_rename_req_153_symbol; -- link to DP
          sum_rename_ack_154_symbol <= ptr_deref_88_root_address_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_plus_offset/sum_rename_ack
          Xexit_152_symbol <= sum_rename_ack_154_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_plus_offset/$exit
          ptr_deref_88_base_plus_offset_150_symbol <= Xexit_152_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_base_plus_offset
        ptr_deref_88_word_addrgen_155: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_addrgen 
          signal ptr_deref_88_word_addrgen_155_start: Boolean;
          signal Xentry_156_symbol: Boolean;
          signal Xexit_157_symbol: Boolean;
          signal root_rename_req_158_symbol : Boolean;
          signal root_rename_ack_159_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_word_addrgen_155_start <= ptr_deref_88_root_address_calculated_142_symbol; -- control passed to block
          Xentry_156_symbol  <= ptr_deref_88_word_addrgen_155_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_addrgen/$entry
          root_rename_req_158_symbol <= Xentry_156_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_addrgen/root_rename_req
          ptr_deref_88_addr_0_req_0 <= root_rename_req_158_symbol; -- link to DP
          root_rename_ack_159_symbol <= ptr_deref_88_addr_0_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_addrgen/root_rename_ack
          Xexit_157_symbol <= root_rename_ack_159_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_addrgen/$exit
          ptr_deref_88_word_addrgen_155_symbol <= Xexit_157_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_word_addrgen
        ptr_deref_88_request_160: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request 
          signal ptr_deref_88_request_160_start: Boolean;
          signal Xentry_161_symbol: Boolean;
          signal Xexit_162_symbol: Boolean;
          signal split_req_163_symbol : Boolean;
          signal split_ack_164_symbol : Boolean;
          signal word_access_165_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_request_160_start <= ptr_deref_88_trigger_x_x138_symbol; -- control passed to block
          Xentry_161_symbol  <= ptr_deref_88_request_160_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/$entry
          split_req_163_symbol <= Xentry_161_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/split_req
          ptr_deref_88_gather_scatter_req_0 <= split_req_163_symbol; -- link to DP
          split_ack_164_symbol <= ptr_deref_88_gather_scatter_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/split_ack
          word_access_165: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access 
            signal word_access_165_start: Boolean;
            signal Xentry_166_symbol: Boolean;
            signal Xexit_167_symbol: Boolean;
            signal word_access_0_168_symbol : Boolean;
            -- 
          begin -- 
            word_access_165_start <= split_ack_164_symbol; -- control passed to block
            Xentry_166_symbol  <= word_access_165_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/$entry
            word_access_0_168: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/word_access_0 
              signal word_access_0_168_start: Boolean;
              signal Xentry_169_symbol: Boolean;
              signal Xexit_170_symbol: Boolean;
              signal rr_171_symbol : Boolean;
              signal ra_172_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_168_start <= Xentry_166_symbol; -- control passed to block
              Xentry_169_symbol  <= word_access_0_168_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/word_access_0/$entry
              rr_171_symbol <= Xentry_169_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/word_access_0/rr
              ptr_deref_88_store_0_req_0 <= rr_171_symbol; -- link to DP
              ra_172_symbol <= ptr_deref_88_store_0_ack_0; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/word_access_0/ra
              Xexit_170_symbol <= ra_172_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/word_access_0/$exit
              word_access_0_168_symbol <= Xexit_170_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/word_access_0
            Xexit_167_symbol <= word_access_0_168_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access/$exit
            word_access_165_symbol <= Xexit_167_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/word_access
          Xexit_162_symbol <= word_access_165_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request/$exit
          ptr_deref_88_request_160_symbol <= Xexit_162_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_request
        ptr_deref_88_complete_173: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete 
          signal ptr_deref_88_complete_173_start: Boolean;
          signal Xentry_174_symbol: Boolean;
          signal Xexit_175_symbol: Boolean;
          signal word_access_176_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_88_complete_173_start <= ptr_deref_88_active_x_x139_symbol; -- control passed to block
          Xentry_174_symbol  <= ptr_deref_88_complete_173_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/$entry
          word_access_176: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access 
            signal word_access_176_start: Boolean;
            signal Xentry_177_symbol: Boolean;
            signal Xexit_178_symbol: Boolean;
            signal word_access_0_179_symbol : Boolean;
            -- 
          begin -- 
            word_access_176_start <= Xentry_174_symbol; -- control passed to block
            Xentry_177_symbol  <= word_access_176_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/$entry
            word_access_0_179: Block -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/word_access_0 
              signal word_access_0_179_start: Boolean;
              signal Xentry_180_symbol: Boolean;
              signal Xexit_181_symbol: Boolean;
              signal cr_182_symbol : Boolean;
              signal ca_183_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_179_start <= Xentry_177_symbol; -- control passed to block
              Xentry_180_symbol  <= word_access_0_179_start; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/word_access_0/$entry
              cr_182_symbol <= Xentry_180_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/word_access_0/cr
              ptr_deref_88_store_0_req_1 <= cr_182_symbol; -- link to DP
              ca_183_symbol <= ptr_deref_88_store_0_ack_1; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/word_access_0/ca
              Xexit_181_symbol <= ca_183_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/word_access_0/$exit
              word_access_0_179_symbol <= Xexit_181_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/word_access_0
            Xexit_178_symbol <= word_access_0_179_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access/$exit
            word_access_176_symbol <= Xexit_178_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/word_access
          Xexit_175_symbol <= word_access_176_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete/$exit
          ptr_deref_88_complete_173_symbol <= Xexit_175_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/ptr_deref_88_complete
        Xexit_42_symbol <= assign_stmt_90_completed_x_x136_symbol; -- transition branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95/$exit
        assign_stmt_72_to_assign_stmt_95_40_symbol <= Xexit_42_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/assign_stmt_72_to_assign_stmt_95
      assign_stmt_99_184: Block -- branch_block_stmt_56/assign_stmt_99 
        signal assign_stmt_99_184_start: Boolean;
        signal Xentry_185_symbol: Boolean;
        signal Xexit_186_symbol: Boolean;
        signal assign_stmt_99_active_x_x187_symbol : Boolean;
        signal assign_stmt_99_completed_x_x188_symbol : Boolean;
        signal type_cast_98_active_x_x189_symbol : Boolean;
        signal type_cast_98_trigger_x_x190_symbol : Boolean;
        signal simple_obj_ref_97_complete_191_symbol : Boolean;
        signal type_cast_98_complete_192_symbol : Boolean;
        signal simple_obj_ref_96_trigger_x_x197_symbol : Boolean;
        signal simple_obj_ref_96_complete_198_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_99_184_start <= assign_stmt_99_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_185_symbol  <= assign_stmt_99_184_start; -- transition branch_block_stmt_56/assign_stmt_99/$entry
        assign_stmt_99_active_x_x187_symbol <= type_cast_98_complete_192_symbol; -- transition branch_block_stmt_56/assign_stmt_99/assign_stmt_99_active_
        assign_stmt_99_completed_x_x188_symbol <= simple_obj_ref_96_complete_198_symbol; -- transition branch_block_stmt_56/assign_stmt_99/assign_stmt_99_completed_
        type_cast_98_active_x_x189_block : Block -- non-trivial join transition branch_block_stmt_56/assign_stmt_99/type_cast_98_active_ 
          signal type_cast_98_active_x_x189_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_98_active_x_x189_predecessors(0) <= type_cast_98_trigger_x_x190_symbol;
          type_cast_98_active_x_x189_predecessors(1) <= simple_obj_ref_97_complete_191_symbol;
          type_cast_98_active_x_x189_join: join -- 
            port map( -- 
              preds => type_cast_98_active_x_x189_predecessors,
              symbol_out => type_cast_98_active_x_x189_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_56/assign_stmt_99/type_cast_98_active_
        type_cast_98_trigger_x_x190_symbol <= Xentry_185_symbol; -- transition branch_block_stmt_56/assign_stmt_99/type_cast_98_trigger_
        simple_obj_ref_97_complete_191_symbol <= Xentry_185_symbol; -- transition branch_block_stmt_56/assign_stmt_99/simple_obj_ref_97_complete
        type_cast_98_complete_192: Block -- branch_block_stmt_56/assign_stmt_99/type_cast_98_complete 
          signal type_cast_98_complete_192_start: Boolean;
          signal Xentry_193_symbol: Boolean;
          signal Xexit_194_symbol: Boolean;
          signal req_195_symbol : Boolean;
          signal ack_196_symbol : Boolean;
          -- 
        begin -- 
          type_cast_98_complete_192_start <= type_cast_98_active_x_x189_symbol; -- control passed to block
          Xentry_193_symbol  <= type_cast_98_complete_192_start; -- transition branch_block_stmt_56/assign_stmt_99/type_cast_98_complete/$entry
          req_195_symbol <= Xentry_193_symbol; -- transition branch_block_stmt_56/assign_stmt_99/type_cast_98_complete/req
          type_cast_98_inst_req_0 <= req_195_symbol; -- link to DP
          ack_196_symbol <= type_cast_98_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_99/type_cast_98_complete/ack
          Xexit_194_symbol <= ack_196_symbol; -- transition branch_block_stmt_56/assign_stmt_99/type_cast_98_complete/$exit
          type_cast_98_complete_192_symbol <= Xexit_194_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_99/type_cast_98_complete
        simple_obj_ref_96_trigger_x_x197_symbol <= assign_stmt_99_active_x_x187_symbol; -- transition branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_trigger_
        simple_obj_ref_96_complete_198: Block -- branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_complete 
          signal simple_obj_ref_96_complete_198_start: Boolean;
          signal Xentry_199_symbol: Boolean;
          signal Xexit_200_symbol: Boolean;
          signal pipe_wreq_201_symbol : Boolean;
          signal pipe_wack_202_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_96_complete_198_start <= simple_obj_ref_96_trigger_x_x197_symbol; -- control passed to block
          Xentry_199_symbol  <= simple_obj_ref_96_complete_198_start; -- transition branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_complete/$entry
          pipe_wreq_201_symbol <= Xentry_199_symbol; -- transition branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_complete/pipe_wreq
          simple_obj_ref_96_inst_req_0 <= pipe_wreq_201_symbol; -- link to DP
          pipe_wack_202_symbol <= simple_obj_ref_96_inst_ack_0; -- transition branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_complete/pipe_wack
          Xexit_200_symbol <= pipe_wack_202_symbol; -- transition branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_complete/$exit
          simple_obj_ref_96_complete_198_symbol <= Xexit_200_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_56/assign_stmt_99/simple_obj_ref_96_complete
        Xexit_186_symbol <= assign_stmt_99_completed_x_x188_symbol; -- transition branch_block_stmt_56/assign_stmt_99/$exit
        assign_stmt_99_184_symbol <= Xexit_186_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/assign_stmt_99
      bb_0_bb_1_PhiReq_203: Block -- branch_block_stmt_56/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_203_start: Boolean;
        signal Xentry_204_symbol: Boolean;
        signal Xexit_205_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_203_start <= bb_0_bb_1_8_symbol; -- control passed to block
        Xentry_204_symbol  <= bb_0_bb_1_PhiReq_203_start; -- transition branch_block_stmt_56/bb_0_bb_1_PhiReq/$entry
        Xexit_205_symbol <= Xentry_204_symbol; -- transition branch_block_stmt_56/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_203_symbol <= Xexit_205_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_206: Block -- branch_block_stmt_56/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_206_start: Boolean;
        signal Xentry_207_symbol: Boolean;
        signal Xexit_208_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_206_start <= bb_1_bb_1_18_symbol; -- control passed to block
        Xentry_207_symbol  <= bb_1_bb_1_PhiReq_206_start; -- transition branch_block_stmt_56/bb_1_bb_1_PhiReq/$entry
        Xexit_208_symbol <= Xentry_207_symbol; -- transition branch_block_stmt_56/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_206_symbol <= Xexit_208_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/bb_1_bb_1_PhiReq
      merge_stmt_58_PhiReqMerge_209_symbol  <=  bb_0_bb_1_PhiReq_203_symbol or bb_1_bb_1_PhiReq_206_symbol; -- place branch_block_stmt_56/merge_stmt_58_PhiReqMerge (optimized away) 
      merge_stmt_58_PhiAck_210: Block -- branch_block_stmt_56/merge_stmt_58_PhiAck 
        signal merge_stmt_58_PhiAck_210_start: Boolean;
        signal Xentry_211_symbol: Boolean;
        signal Xexit_212_symbol: Boolean;
        signal dummy_213_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_58_PhiAck_210_start <= merge_stmt_58_PhiReqMerge_209_symbol; -- control passed to block
        Xentry_211_symbol  <= merge_stmt_58_PhiAck_210_start; -- transition branch_block_stmt_56/merge_stmt_58_PhiAck/$entry
        dummy_213_symbol <= Xentry_211_symbol; -- transition branch_block_stmt_56/merge_stmt_58_PhiAck/dummy
        Xexit_212_symbol <= dummy_213_symbol; -- transition branch_block_stmt_56/merge_stmt_58_PhiAck/$exit
        merge_stmt_58_PhiAck_210_symbol <= Xexit_212_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_56/merge_stmt_58_PhiAck
      Xexit_5_symbol <= branch_block_stmt_56_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_56/$exit
      branch_block_stmt_56_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_56
    Xexit_2_symbol <= branch_block_stmt_56_3_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_71_resized_base_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_71_root_address : std_logic_vector(2 downto 0);
    signal expr_84_wire_constant : std_logic_vector(31 downto 0);
    signal iNsTr_1_63 : std_logic_vector(31 downto 0);
    signal iNsTr_2_68 : std_logic_vector(31 downto 0);
    signal iNsTr_3_72 : std_logic_vector(31 downto 0);
    signal iNsTr_4_77 : std_logic_vector(31 downto 0);
    signal iNsTr_5_81 : std_logic_vector(31 downto 0);
    signal iNsTr_6_86 : std_logic_vector(31 downto 0);
    signal iNsTr_8_95 : std_logic_vector(31 downto 0);
    signal ptr_deref_80_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_80_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_80_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_80_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_80_word_offset_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_88_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_88_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_88_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_88_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_88_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_88_word_offset_0 : std_logic_vector(2 downto 0);
    signal simple_obj_ref_66_wire : std_logic_vector(31 downto 0);
    signal type_cast_98_wire : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    expr_84_wire_constant <= "00000000000000000000000000000001";
    iNsTr_1_63 <= "00000000000000000000000000000000";
    iNsTr_8_95 <= "00000000000000000000000000000000";
    ptr_deref_80_word_offset_0 <= "000";
    ptr_deref_88_word_offset_0 <= "000";
    array_obj_ref_71_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_2_68, dout => array_obj_ref_71_resized_base_address, req => array_obj_ref_71_base_resize_req_0, ack => array_obj_ref_71_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_71_final_reg: RegisterBase generic map(in_data_width => 3,out_data_width => 32) -- 
      port map( din => array_obj_ref_71_root_address, dout => iNsTr_3_72, req => array_obj_ref_71_final_reg_req_0, ack => array_obj_ref_71_final_reg_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_80_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_4_77, dout => ptr_deref_80_resized_base_address, req => ptr_deref_80_base_resize_req_0, ack => ptr_deref_80_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_88_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_4_77, dout => ptr_deref_88_resized_base_address, req => ptr_deref_88_base_resize_req_0, ack => ptr_deref_88_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_67_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_66_wire, dout => iNsTr_2_68, req => type_cast_67_inst_req_0, ack => type_cast_67_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_76_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_3_72, dout => iNsTr_4_77, req => type_cast_76_inst_req_0, ack => type_cast_76_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_98_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_2_68, dout => type_cast_98_wire, req => type_cast_98_inst_req_0, ack => type_cast_98_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_71_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_71_root_address_inst_ack_0 <= array_obj_ref_71_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_71_resized_base_address;
      array_obj_ref_71_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_80_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_80_addr_0_ack_0 <= ptr_deref_80_addr_0_req_0;
      aggregated_sig <= ptr_deref_80_root_address;
      ptr_deref_80_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_80_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_80_gather_scatter_ack_0 <= ptr_deref_80_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_80_data_0;
      iNsTr_5_81 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_80_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_80_root_address_inst_ack_0 <= ptr_deref_80_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_80_resized_base_address;
      ptr_deref_80_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_88_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_88_addr_0_ack_0 <= ptr_deref_88_addr_0_req_0;
      aggregated_sig <= ptr_deref_88_root_address;
      ptr_deref_88_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_88_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_88_gather_scatter_ack_0 <= ptr_deref_88_gather_scatter_req_0;
      aggregated_sig <= iNsTr_6_86;
      ptr_deref_88_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_88_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_88_root_address_inst_ack_0 <= ptr_deref_88_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_88_resized_base_address;
      ptr_deref_88_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_85_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_81;
      iNsTr_6_86 <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntSHL",
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
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
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
    end Block; -- split operator group 0
    -- shared load operator group (0) : ptr_deref_80_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(2 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_80_load_0_req_0;
      ptr_deref_80_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_80_load_0_req_1;
      ptr_deref_80_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_80_word_address_0;
      ptr_deref_80_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 3,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(2 downto 0),
          mtag => memory_space_1_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_1_lc_req(0),
          mack => memory_space_1_lc_ack(0),
          mdata => memory_space_1_lc_data(31 downto 0),
          mtag => memory_space_1_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared store operator group (0) : ptr_deref_88_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
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
        generic map ( addr_width => 3,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(0),
          mack => memory_space_1_sr_ack(0),
          maddr => memory_space_1_sr_addr(2 downto 0),
          mdata => memory_space_1_sr_data(31 downto 0),
          mtag => memory_space_1_sr_tag(1 downto 0),
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
          mreq => memory_space_1_sc_req(0),
          mack => memory_space_1_sc_ack(0),
          mtag => memory_space_1_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared inport operator group (0) : simple_obj_ref_66_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_66_inst_req_0;
      simple_obj_ref_66_inst_ack_0 <= ack(0);
      simple_obj_ref_66_wire <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => foo_in_pipe_read_req(0),
          oack => foo_in_pipe_read_ack(0),
          odata => foo_in_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_96_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_96_inst_req_0;
      simple_obj_ref_96_inst_ack_0 <= ack(0);
      data_in <= type_cast_98_wire;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => foo_out_pipe_write_req(0),
          oack => foo_out_pipe_write_ack(0),
          odata => foo_out_pipe_write_data(31 downto 0),
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
entity free_queue_manager is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(2 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
    memory_space_1_sr_req : out  std_logic_vector(1 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(1 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(5 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(63 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(3 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(1 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(1 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(3 downto 0);
    memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
    free_queue_put_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_put_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_put_pipe_read_data : in   std_logic_vector(31 downto 0);
    free_queue_request_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_request_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_request_pipe_read_data : in   std_logic_vector(7 downto 0);
    free_queue_get_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_get_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_get_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity free_queue_manager;
architecture Default of free_queue_manager is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal type_cast_201_inst_req_0 : boolean;
  signal type_cast_201_inst_ack_0 : boolean;
  signal simple_obj_ref_199_inst_req_0 : boolean;
  signal simple_obj_ref_199_inst_ack_0 : boolean;
  signal simple_obj_ref_211_inst_req_0 : boolean;
  signal simple_obj_ref_211_inst_ack_0 : boolean;
  signal ptr_deref_117_gather_scatter_req_0 : boolean;
  signal ptr_deref_117_gather_scatter_ack_0 : boolean;
  signal ptr_deref_117_store_0_req_0 : boolean;
  signal ptr_deref_117_store_0_ack_0 : boolean;
  signal ptr_deref_117_store_0_req_1 : boolean;
  signal ptr_deref_117_store_0_ack_1 : boolean;
  signal ptr_deref_127_gather_scatter_req_0 : boolean;
  signal ptr_deref_127_gather_scatter_ack_0 : boolean;
  signal ptr_deref_127_store_0_req_0 : boolean;
  signal ptr_deref_127_store_0_ack_0 : boolean;
  signal ptr_deref_127_store_0_req_1 : boolean;
  signal ptr_deref_127_store_0_ack_1 : boolean;
  signal simple_obj_ref_135_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_135_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_135_store_0_req_0 : boolean;
  signal simple_obj_ref_135_store_0_ack_0 : boolean;
  signal simple_obj_ref_135_store_0_req_1 : boolean;
  signal simple_obj_ref_135_store_0_ack_1 : boolean;
  signal simple_obj_ref_146_inst_req_0 : boolean;
  signal simple_obj_ref_146_inst_ack_0 : boolean;
  signal type_cast_147_inst_req_0 : boolean;
  signal type_cast_147_inst_ack_0 : boolean;
  signal switch_stmt_149_branch_default_req_0 : boolean;
  signal switch_stmt_149_select_expr_0_req_0 : boolean;
  signal switch_stmt_149_select_expr_0_ack_0 : boolean;
  signal switch_stmt_149_select_expr_0_req_1 : boolean;
  signal switch_stmt_149_select_expr_0_ack_1 : boolean;
  signal switch_stmt_149_branch_0_req_0 : boolean;
  signal switch_stmt_149_select_expr_1_req_0 : boolean;
  signal switch_stmt_149_select_expr_1_ack_0 : boolean;
  signal switch_stmt_149_select_expr_1_req_1 : boolean;
  signal switch_stmt_149_select_expr_1_ack_1 : boolean;
  signal switch_stmt_149_branch_1_req_0 : boolean;
  signal switch_stmt_149_branch_0_ack_1 : boolean;
  signal switch_stmt_149_branch_1_ack_1 : boolean;
  signal switch_stmt_149_branch_default_ack_0 : boolean;
  signal simple_obj_ref_161_load_0_req_0 : boolean;
  signal simple_obj_ref_161_load_0_ack_0 : boolean;
  signal simple_obj_ref_161_load_0_req_1 : boolean;
  signal simple_obj_ref_161_load_0_ack_1 : boolean;
  signal simple_obj_ref_161_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_161_gather_scatter_ack_0 : boolean;
  signal binary_166_inst_req_0 : boolean;
  signal binary_166_inst_ack_0 : boolean;
  signal binary_166_inst_req_1 : boolean;
  signal binary_166_inst_ack_1 : boolean;
  signal if_stmt_169_branch_req_0 : boolean;
  signal if_stmt_169_branch_ack_1 : boolean;
  signal if_stmt_169_branch_ack_0 : boolean;
  signal array_obj_ref_179_base_resize_req_0 : boolean;
  signal array_obj_ref_179_base_resize_ack_0 : boolean;
  signal array_obj_ref_179_root_address_inst_req_0 : boolean;
  signal array_obj_ref_179_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_179_final_reg_req_0 : boolean;
  signal array_obj_ref_179_final_reg_ack_0 : boolean;
  signal ptr_deref_183_base_resize_req_0 : boolean;
  signal ptr_deref_183_base_resize_ack_0 : boolean;
  signal ptr_deref_183_root_address_inst_req_0 : boolean;
  signal ptr_deref_183_root_address_inst_ack_0 : boolean;
  signal ptr_deref_183_addr_0_req_0 : boolean;
  signal ptr_deref_183_addr_0_ack_0 : boolean;
  signal ptr_deref_183_load_0_req_0 : boolean;
  signal ptr_deref_183_load_0_ack_0 : boolean;
  signal ptr_deref_183_load_0_req_1 : boolean;
  signal ptr_deref_183_load_0_ack_1 : boolean;
  signal ptr_deref_183_gather_scatter_req_0 : boolean;
  signal ptr_deref_183_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_185_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_185_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_185_store_0_req_0 : boolean;
  signal simple_obj_ref_185_store_0_ack_0 : boolean;
  signal simple_obj_ref_185_store_0_req_1 : boolean;
  signal simple_obj_ref_185_store_0_ack_1 : boolean;
  signal type_cast_192_inst_req_0 : boolean;
  signal type_cast_192_inst_ack_0 : boolean;
  signal type_cast_212_inst_req_0 : boolean;
  signal type_cast_212_inst_ack_0 : boolean;
  signal type_cast_216_inst_req_0 : boolean;
  signal type_cast_216_inst_ack_0 : boolean;
  signal simple_obj_ref_219_load_0_req_0 : boolean;
  signal simple_obj_ref_219_load_0_ack_0 : boolean;
  signal simple_obj_ref_219_load_0_req_1 : boolean;
  signal simple_obj_ref_219_load_0_ack_1 : boolean;
  signal simple_obj_ref_219_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_219_gather_scatter_ack_0 : boolean;
  signal type_cast_224_inst_req_0 : boolean;
  signal type_cast_224_inst_ack_0 : boolean;
  signal ptr_deref_227_base_resize_req_0 : boolean;
  signal ptr_deref_227_base_resize_ack_0 : boolean;
  signal ptr_deref_227_root_address_inst_req_0 : boolean;
  signal ptr_deref_227_root_address_inst_ack_0 : boolean;
  signal ptr_deref_227_addr_0_req_0 : boolean;
  signal ptr_deref_227_addr_0_ack_0 : boolean;
  signal ptr_deref_227_gather_scatter_req_0 : boolean;
  signal ptr_deref_227_gather_scatter_ack_0 : boolean;
  signal ptr_deref_227_store_0_req_0 : boolean;
  signal ptr_deref_227_store_0_ack_0 : boolean;
  signal ptr_deref_227_store_0_req_1 : boolean;
  signal ptr_deref_227_store_0_ack_1 : boolean;
  signal simple_obj_ref_230_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_230_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_230_store_0_req_0 : boolean;
  signal simple_obj_ref_230_store_0_ack_0 : boolean;
  signal simple_obj_ref_230_store_0_req_1 : boolean;
  signal simple_obj_ref_230_store_0_ack_1 : boolean;
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
  free_queue_manager_CP_214: Block -- control-path 
    signal free_queue_manager_CP_214_start: Boolean;
    signal Xentry_215_symbol: Boolean;
    signal Xexit_216_symbol: Boolean;
    signal branch_block_stmt_104_217_symbol : Boolean;
    -- 
  begin -- 
    free_queue_manager_CP_214_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_215_symbol  <= free_queue_manager_CP_214_start; -- transition $entry
    branch_block_stmt_104_217: Block -- branch_block_stmt_104 
      signal branch_block_stmt_104_217_start: Boolean;
      signal Xentry_218_symbol: Boolean;
      signal Xexit_219_symbol: Boolean;
      signal branch_block_stmt_104_x_xentry_x_xx_x220_symbol : Boolean;
      signal branch_block_stmt_104_x_xexit_x_xx_x221_symbol : Boolean;
      signal assign_stmt_109_to_assign_stmt_137_x_xentry_x_xx_x222_symbol : Boolean;
      signal assign_stmt_109_to_assign_stmt_137_x_xexit_x_xx_x223_symbol : Boolean;
      signal bb_0_xx_xbackedge_224_symbol : Boolean;
      signal merge_stmt_139_x_xexit_x_xx_x225_symbol : Boolean;
      signal assign_stmt_144_x_xentry_x_xx_x226_symbol : Boolean;
      signal assign_stmt_144_x_xexit_x_xx_x227_symbol : Boolean;
      signal assign_stmt_148_x_xentry_x_xx_x228_symbol : Boolean;
      signal assign_stmt_148_x_xexit_x_xx_x229_symbol : Boolean;
      signal switch_stmt_149_x_xentry_x_xx_x230_symbol : Boolean;
      signal switch_stmt_149_x_xexit_x_xx_x231_symbol : Boolean;
      signal merge_stmt_159_x_xentry_x_xx_x232_symbol : Boolean;
      signal merge_stmt_159_x_xexit_x_xx_x233_symbol : Boolean;
      signal assign_stmt_162_to_assign_stmt_168_x_xentry_x_xx_x234_symbol : Boolean;
      signal assign_stmt_162_to_assign_stmt_168_x_xexit_x_xx_x235_symbol : Boolean;
      signal if_stmt_169_x_xentry_x_xx_x236_symbol : Boolean;
      signal if_stmt_169_x_xexit_x_xx_x237_symbol : Boolean;
      signal merge_stmt_175_x_xentry_x_xx_x238_symbol : Boolean;
      signal merge_stmt_175_x_xexit_x_xx_x239_symbol : Boolean;
      signal assign_stmt_180_to_assign_stmt_187_x_xentry_x_xx_x240_symbol : Boolean;
      signal assign_stmt_180_to_assign_stmt_187_x_xexit_x_xx_x241_symbol : Boolean;
      signal bb_3_bb_4_242_symbol : Boolean;
      signal merge_stmt_189_x_xexit_x_xx_x243_symbol : Boolean;
      signal assign_stmt_193_to_assign_stmt_198_x_xentry_x_xx_x244_symbol : Boolean;
      signal assign_stmt_193_to_assign_stmt_198_x_xexit_x_xx_x245_symbol : Boolean;
      signal assign_stmt_202_x_xentry_x_xx_x246_symbol : Boolean;
      signal assign_stmt_202_x_xexit_x_xx_x247_symbol : Boolean;
      signal bb_4_xx_xbackedge_248_symbol : Boolean;
      signal merge_stmt_204_x_xexit_x_xx_x249_symbol : Boolean;
      signal assign_stmt_209_x_xentry_x_xx_x250_symbol : Boolean;
      signal assign_stmt_209_x_xexit_x_xx_x251_symbol : Boolean;
      signal assign_stmt_213_x_xentry_x_xx_x252_symbol : Boolean;
      signal assign_stmt_213_x_xexit_x_xx_x253_symbol : Boolean;
      signal assign_stmt_217_to_assign_stmt_232_x_xentry_x_xx_x254_symbol : Boolean;
      signal assign_stmt_217_to_assign_stmt_232_x_xexit_x_xx_x255_symbol : Boolean;
      signal bb_5_xx_xbackedge_256_symbol : Boolean;
      signal assign_stmt_109_to_assign_stmt_137_257_symbol : Boolean;
      signal assign_stmt_144_352_symbol : Boolean;
      signal assign_stmt_148_355_symbol : Boolean;
      signal switch_stmt_149_dead_link_373_symbol : Boolean;
      signal switch_stmt_149_x_xcondition_check_place_x_xx_x377_symbol : Boolean;
      signal switch_stmt_149_x_xcondition_check_x_xx_x378_symbol : Boolean;
      signal switch_stmt_149_x_xselect_x_xx_x397_symbol : Boolean;
      signal switch_stmt_149_choice_0_398_symbol : Boolean;
      signal xx_xbackedge_bb_2_402_symbol : Boolean;
      signal switch_stmt_149_choice_1_403_symbol : Boolean;
      signal xx_xbackedge_bb_5_407_symbol : Boolean;
      signal switch_stmt_149_choice_default_408_symbol : Boolean;
      signal xx_xbackedge_xx_xbackedge_412_symbol : Boolean;
      signal assign_stmt_162_to_assign_stmt_168_413_symbol : Boolean;
      signal if_stmt_169_dead_link_458_symbol : Boolean;
      signal if_stmt_169_eval_test_462_symbol : Boolean;
      signal simple_obj_ref_170_place_466_symbol : Boolean;
      signal if_stmt_169_if_link_467_symbol : Boolean;
      signal if_stmt_169_else_link_471_symbol : Boolean;
      signal bb_2_bb_4_475_symbol : Boolean;
      signal bb_2_bb_3_476_symbol : Boolean;
      signal assign_stmt_180_to_assign_stmt_187_477_symbol : Boolean;
      signal assign_stmt_193_to_assign_stmt_198_581_symbol : Boolean;
      signal assign_stmt_202_594_symbol : Boolean;
      signal assign_stmt_209_613_symbol : Boolean;
      signal assign_stmt_213_616_symbol : Boolean;
      signal assign_stmt_217_to_assign_stmt_232_634_symbol : Boolean;
      signal bb_0_xx_xbackedge_PhiReq_767_symbol : Boolean;
      signal bb_4_xx_xbackedge_PhiReq_770_symbol : Boolean;
      signal bb_5_xx_xbackedge_PhiReq_773_symbol : Boolean;
      signal xx_xbackedge_xx_xbackedge_PhiReq_776_symbol : Boolean;
      signal merge_stmt_139_PhiReqMerge_779_symbol : Boolean;
      signal merge_stmt_139_PhiAck_780_symbol : Boolean;
      signal merge_stmt_159_dead_link_784_symbol : Boolean;
      signal xx_xbackedge_bb_2_PhiReq_788_symbol : Boolean;
      signal merge_stmt_159_PhiReqMerge_791_symbol : Boolean;
      signal merge_stmt_159_PhiAck_792_symbol : Boolean;
      signal merge_stmt_175_dead_link_796_symbol : Boolean;
      signal bb_2_bb_3_PhiReq_800_symbol : Boolean;
      signal merge_stmt_175_PhiReqMerge_803_symbol : Boolean;
      signal merge_stmt_175_PhiAck_804_symbol : Boolean;
      signal bb_2_bb_4_PhiReq_808_symbol : Boolean;
      signal bb_3_bb_4_PhiReq_811_symbol : Boolean;
      signal merge_stmt_189_PhiReqMerge_814_symbol : Boolean;
      signal merge_stmt_189_PhiAck_815_symbol : Boolean;
      signal xx_xbackedge_bb_5_PhiReq_819_symbol : Boolean;
      signal merge_stmt_204_PhiReqMerge_822_symbol : Boolean;
      signal merge_stmt_204_PhiAck_823_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_104_217_start <= Xentry_215_symbol; -- control passed to block
      Xentry_218_symbol  <= branch_block_stmt_104_217_start; -- transition branch_block_stmt_104/$entry
      branch_block_stmt_104_x_xentry_x_xx_x220_symbol  <=  Xentry_218_symbol; -- place branch_block_stmt_104/branch_block_stmt_104__entry__ (optimized away) 
      branch_block_stmt_104_x_xexit_x_xx_x221_symbol  <=   false ; -- place branch_block_stmt_104/branch_block_stmt_104__exit__ (optimized away) 
      assign_stmt_109_to_assign_stmt_137_x_xentry_x_xx_x222_symbol  <=  branch_block_stmt_104_x_xentry_x_xx_x220_symbol; -- place branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137__entry__ (optimized away) 
      assign_stmt_109_to_assign_stmt_137_x_xexit_x_xx_x223_symbol  <=  assign_stmt_109_to_assign_stmt_137_257_symbol; -- place branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137__exit__ (optimized away) 
      bb_0_xx_xbackedge_224_symbol  <=  assign_stmt_109_to_assign_stmt_137_x_xexit_x_xx_x223_symbol; -- place branch_block_stmt_104/bb_0_xx_xbackedge (optimized away) 
      merge_stmt_139_x_xexit_x_xx_x225_symbol  <=  merge_stmt_139_PhiAck_780_symbol; -- place branch_block_stmt_104/merge_stmt_139__exit__ (optimized away) 
      assign_stmt_144_x_xentry_x_xx_x226_symbol  <=  merge_stmt_139_x_xexit_x_xx_x225_symbol; -- place branch_block_stmt_104/assign_stmt_144__entry__ (optimized away) 
      assign_stmt_144_x_xexit_x_xx_x227_symbol  <=  assign_stmt_144_352_symbol; -- place branch_block_stmt_104/assign_stmt_144__exit__ (optimized away) 
      assign_stmt_148_x_xentry_x_xx_x228_symbol  <=  assign_stmt_144_x_xexit_x_xx_x227_symbol; -- place branch_block_stmt_104/assign_stmt_148__entry__ (optimized away) 
      assign_stmt_148_x_xexit_x_xx_x229_symbol  <=  assign_stmt_148_355_symbol; -- place branch_block_stmt_104/assign_stmt_148__exit__ (optimized away) 
      switch_stmt_149_x_xentry_x_xx_x230_symbol  <=  assign_stmt_148_x_xexit_x_xx_x229_symbol; -- place branch_block_stmt_104/switch_stmt_149__entry__ (optimized away) 
      switch_stmt_149_x_xexit_x_xx_x231_symbol  <=  switch_stmt_149_dead_link_373_symbol; -- place branch_block_stmt_104/switch_stmt_149__exit__ (optimized away) 
      merge_stmt_159_x_xentry_x_xx_x232_symbol  <=  switch_stmt_149_x_xexit_x_xx_x231_symbol; -- place branch_block_stmt_104/merge_stmt_159__entry__ (optimized away) 
      merge_stmt_159_x_xexit_x_xx_x233_symbol  <=  merge_stmt_159_dead_link_784_symbol or merge_stmt_159_PhiAck_792_symbol; -- place branch_block_stmt_104/merge_stmt_159__exit__ (optimized away) 
      assign_stmt_162_to_assign_stmt_168_x_xentry_x_xx_x234_symbol  <=  merge_stmt_159_x_xexit_x_xx_x233_symbol; -- place branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168__entry__ (optimized away) 
      assign_stmt_162_to_assign_stmt_168_x_xexit_x_xx_x235_symbol  <=  assign_stmt_162_to_assign_stmt_168_413_symbol; -- place branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168__exit__ (optimized away) 
      if_stmt_169_x_xentry_x_xx_x236_symbol  <=  assign_stmt_162_to_assign_stmt_168_x_xexit_x_xx_x235_symbol; -- place branch_block_stmt_104/if_stmt_169__entry__ (optimized away) 
      if_stmt_169_x_xexit_x_xx_x237_symbol  <=  if_stmt_169_dead_link_458_symbol; -- place branch_block_stmt_104/if_stmt_169__exit__ (optimized away) 
      merge_stmt_175_x_xentry_x_xx_x238_symbol  <=  if_stmt_169_x_xexit_x_xx_x237_symbol; -- place branch_block_stmt_104/merge_stmt_175__entry__ (optimized away) 
      merge_stmt_175_x_xexit_x_xx_x239_symbol  <=  merge_stmt_175_dead_link_796_symbol or merge_stmt_175_PhiAck_804_symbol; -- place branch_block_stmt_104/merge_stmt_175__exit__ (optimized away) 
      assign_stmt_180_to_assign_stmt_187_x_xentry_x_xx_x240_symbol  <=  merge_stmt_175_x_xexit_x_xx_x239_symbol; -- place branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187__entry__ (optimized away) 
      assign_stmt_180_to_assign_stmt_187_x_xexit_x_xx_x241_symbol  <=  assign_stmt_180_to_assign_stmt_187_477_symbol; -- place branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187__exit__ (optimized away) 
      bb_3_bb_4_242_symbol  <=  assign_stmt_180_to_assign_stmt_187_x_xexit_x_xx_x241_symbol; -- place branch_block_stmt_104/bb_3_bb_4 (optimized away) 
      merge_stmt_189_x_xexit_x_xx_x243_symbol  <=  merge_stmt_189_PhiAck_815_symbol; -- place branch_block_stmt_104/merge_stmt_189__exit__ (optimized away) 
      assign_stmt_193_to_assign_stmt_198_x_xentry_x_xx_x244_symbol  <=  merge_stmt_189_x_xexit_x_xx_x243_symbol; -- place branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198__entry__ (optimized away) 
      assign_stmt_193_to_assign_stmt_198_x_xexit_x_xx_x245_symbol  <=  assign_stmt_193_to_assign_stmt_198_581_symbol; -- place branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198__exit__ (optimized away) 
      assign_stmt_202_x_xentry_x_xx_x246_symbol  <=  assign_stmt_193_to_assign_stmt_198_x_xexit_x_xx_x245_symbol; -- place branch_block_stmt_104/assign_stmt_202__entry__ (optimized away) 
      assign_stmt_202_x_xexit_x_xx_x247_symbol  <=  assign_stmt_202_594_symbol; -- place branch_block_stmt_104/assign_stmt_202__exit__ (optimized away) 
      bb_4_xx_xbackedge_248_symbol  <=  assign_stmt_202_x_xexit_x_xx_x247_symbol; -- place branch_block_stmt_104/bb_4_xx_xbackedge (optimized away) 
      merge_stmt_204_x_xexit_x_xx_x249_symbol  <=  merge_stmt_204_PhiAck_823_symbol; -- place branch_block_stmt_104/merge_stmt_204__exit__ (optimized away) 
      assign_stmt_209_x_xentry_x_xx_x250_symbol  <=  merge_stmt_204_x_xexit_x_xx_x249_symbol; -- place branch_block_stmt_104/assign_stmt_209__entry__ (optimized away) 
      assign_stmt_209_x_xexit_x_xx_x251_symbol  <=  assign_stmt_209_613_symbol; -- place branch_block_stmt_104/assign_stmt_209__exit__ (optimized away) 
      assign_stmt_213_x_xentry_x_xx_x252_symbol  <=  assign_stmt_209_x_xexit_x_xx_x251_symbol; -- place branch_block_stmt_104/assign_stmt_213__entry__ (optimized away) 
      assign_stmt_213_x_xexit_x_xx_x253_symbol  <=  assign_stmt_213_616_symbol; -- place branch_block_stmt_104/assign_stmt_213__exit__ (optimized away) 
      assign_stmt_217_to_assign_stmt_232_x_xentry_x_xx_x254_symbol  <=  assign_stmt_213_x_xexit_x_xx_x253_symbol; -- place branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232__entry__ (optimized away) 
      assign_stmt_217_to_assign_stmt_232_x_xexit_x_xx_x255_symbol  <=  assign_stmt_217_to_assign_stmt_232_634_symbol; -- place branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232__exit__ (optimized away) 
      bb_5_xx_xbackedge_256_symbol  <=  assign_stmt_217_to_assign_stmt_232_x_xexit_x_xx_x255_symbol; -- place branch_block_stmt_104/bb_5_xx_xbackedge (optimized away) 
      assign_stmt_109_to_assign_stmt_137_257: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137 
        signal assign_stmt_109_to_assign_stmt_137_257_start: Boolean;
        signal Xentry_258_symbol: Boolean;
        signal Xexit_259_symbol: Boolean;
        signal assign_stmt_119_active_x_x260_symbol : Boolean;
        signal assign_stmt_119_completed_x_x261_symbol : Boolean;
        signal ptr_deref_117_trigger_x_x262_symbol : Boolean;
        signal ptr_deref_117_active_x_x263_symbol : Boolean;
        signal ptr_deref_117_base_address_calculated_264_symbol : Boolean;
        signal ptr_deref_117_root_address_calculated_265_symbol : Boolean;
        signal ptr_deref_117_word_address_calculated_266_symbol : Boolean;
        signal ptr_deref_117_request_267_symbol : Boolean;
        signal ptr_deref_117_complete_280_symbol : Boolean;
        signal assign_stmt_129_active_x_x291_symbol : Boolean;
        signal assign_stmt_129_completed_x_x292_symbol : Boolean;
        signal ptr_deref_127_trigger_x_x293_symbol : Boolean;
        signal ptr_deref_127_active_x_x294_symbol : Boolean;
        signal ptr_deref_127_base_address_calculated_295_symbol : Boolean;
        signal ptr_deref_127_root_address_calculated_296_symbol : Boolean;
        signal ptr_deref_127_word_address_calculated_297_symbol : Boolean;
        signal ptr_deref_127_request_298_symbol : Boolean;
        signal ptr_deref_127_complete_311_symbol : Boolean;
        signal assign_stmt_137_active_x_x322_symbol : Boolean;
        signal assign_stmt_137_completed_x_x323_symbol : Boolean;
        signal simple_obj_ref_135_trigger_x_x324_symbol : Boolean;
        signal simple_obj_ref_135_active_x_x325_symbol : Boolean;
        signal simple_obj_ref_135_root_address_calculated_326_symbol : Boolean;
        signal simple_obj_ref_135_word_address_calculated_327_symbol : Boolean;
        signal simple_obj_ref_135_request_328_symbol : Boolean;
        signal simple_obj_ref_135_complete_341_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_109_to_assign_stmt_137_257_start <= assign_stmt_109_to_assign_stmt_137_x_xentry_x_xx_x222_symbol; -- control passed to block
        Xentry_258_symbol  <= assign_stmt_109_to_assign_stmt_137_257_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/$entry
        assign_stmt_119_active_x_x260_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/assign_stmt_119_active_
        assign_stmt_119_completed_x_x261_symbol <= ptr_deref_117_complete_280_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/assign_stmt_119_completed_
        ptr_deref_117_trigger_x_x262_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_trigger_ 
          signal ptr_deref_117_trigger_x_x262_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_117_trigger_x_x262_predecessors(0) <= ptr_deref_117_word_address_calculated_266_symbol;
          ptr_deref_117_trigger_x_x262_predecessors(1) <= assign_stmt_119_active_x_x260_symbol;
          ptr_deref_117_trigger_x_x262_join: join -- 
            port map( -- 
              preds => ptr_deref_117_trigger_x_x262_predecessors,
              symbol_out => ptr_deref_117_trigger_x_x262_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_trigger_
        ptr_deref_117_active_x_x263_symbol <= ptr_deref_117_request_267_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_active_
        ptr_deref_117_base_address_calculated_264_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_base_address_calculated
        ptr_deref_117_root_address_calculated_265_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_root_address_calculated
        ptr_deref_117_word_address_calculated_266_symbol <= ptr_deref_117_root_address_calculated_265_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_word_address_calculated
        ptr_deref_117_request_267: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request 
          signal ptr_deref_117_request_267_start: Boolean;
          signal Xentry_268_symbol: Boolean;
          signal Xexit_269_symbol: Boolean;
          signal split_req_270_symbol : Boolean;
          signal split_ack_271_symbol : Boolean;
          signal word_access_272_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_117_request_267_start <= ptr_deref_117_trigger_x_x262_symbol; -- control passed to block
          Xentry_268_symbol  <= ptr_deref_117_request_267_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/$entry
          split_req_270_symbol <= Xentry_268_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/split_req
          ptr_deref_117_gather_scatter_req_0 <= split_req_270_symbol; -- link to DP
          split_ack_271_symbol <= ptr_deref_117_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/split_ack
          word_access_272: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access 
            signal word_access_272_start: Boolean;
            signal Xentry_273_symbol: Boolean;
            signal Xexit_274_symbol: Boolean;
            signal word_access_0_275_symbol : Boolean;
            -- 
          begin -- 
            word_access_272_start <= split_ack_271_symbol; -- control passed to block
            Xentry_273_symbol  <= word_access_272_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/$entry
            word_access_0_275: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/word_access_0 
              signal word_access_0_275_start: Boolean;
              signal Xentry_276_symbol: Boolean;
              signal Xexit_277_symbol: Boolean;
              signal rr_278_symbol : Boolean;
              signal ra_279_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_275_start <= Xentry_273_symbol; -- control passed to block
              Xentry_276_symbol  <= word_access_0_275_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/word_access_0/$entry
              rr_278_symbol <= Xentry_276_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/word_access_0/rr
              ptr_deref_117_store_0_req_0 <= rr_278_symbol; -- link to DP
              ra_279_symbol <= ptr_deref_117_store_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/word_access_0/ra
              Xexit_277_symbol <= ra_279_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/word_access_0/$exit
              word_access_0_275_symbol <= Xexit_277_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/word_access_0
            Xexit_274_symbol <= word_access_0_275_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access/$exit
            word_access_272_symbol <= Xexit_274_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/word_access
          Xexit_269_symbol <= word_access_272_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request/$exit
          ptr_deref_117_request_267_symbol <= Xexit_269_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_request
        ptr_deref_117_complete_280: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete 
          signal ptr_deref_117_complete_280_start: Boolean;
          signal Xentry_281_symbol: Boolean;
          signal Xexit_282_symbol: Boolean;
          signal word_access_283_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_117_complete_280_start <= ptr_deref_117_active_x_x263_symbol; -- control passed to block
          Xentry_281_symbol  <= ptr_deref_117_complete_280_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/$entry
          word_access_283: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access 
            signal word_access_283_start: Boolean;
            signal Xentry_284_symbol: Boolean;
            signal Xexit_285_symbol: Boolean;
            signal word_access_0_286_symbol : Boolean;
            -- 
          begin -- 
            word_access_283_start <= Xentry_281_symbol; -- control passed to block
            Xentry_284_symbol  <= word_access_283_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/$entry
            word_access_0_286: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/word_access_0 
              signal word_access_0_286_start: Boolean;
              signal Xentry_287_symbol: Boolean;
              signal Xexit_288_symbol: Boolean;
              signal cr_289_symbol : Boolean;
              signal ca_290_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_286_start <= Xentry_284_symbol; -- control passed to block
              Xentry_287_symbol  <= word_access_0_286_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/word_access_0/$entry
              cr_289_symbol <= Xentry_287_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/word_access_0/cr
              ptr_deref_117_store_0_req_1 <= cr_289_symbol; -- link to DP
              ca_290_symbol <= ptr_deref_117_store_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/word_access_0/ca
              Xexit_288_symbol <= ca_290_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/word_access_0/$exit
              word_access_0_286_symbol <= Xexit_288_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/word_access_0
            Xexit_285_symbol <= word_access_0_286_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access/$exit
            word_access_283_symbol <= Xexit_285_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/word_access
          Xexit_282_symbol <= word_access_283_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete/$exit
          ptr_deref_117_complete_280_symbol <= Xexit_282_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_117_complete
        assign_stmt_129_active_x_x291_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/assign_stmt_129_active_
        assign_stmt_129_completed_x_x292_symbol <= ptr_deref_127_complete_311_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/assign_stmt_129_completed_
        ptr_deref_127_trigger_x_x293_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_trigger_ 
          signal ptr_deref_127_trigger_x_x293_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_127_trigger_x_x293_predecessors(0) <= ptr_deref_127_word_address_calculated_297_symbol;
          ptr_deref_127_trigger_x_x293_predecessors(1) <= assign_stmt_129_active_x_x291_symbol;
          ptr_deref_127_trigger_x_x293_predecessors(2) <= ptr_deref_117_active_x_x263_symbol;
          ptr_deref_127_trigger_x_x293_join: join -- 
            port map( -- 
              preds => ptr_deref_127_trigger_x_x293_predecessors,
              symbol_out => ptr_deref_127_trigger_x_x293_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_trigger_
        ptr_deref_127_active_x_x294_symbol <= ptr_deref_127_request_298_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_active_
        ptr_deref_127_base_address_calculated_295_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_base_address_calculated
        ptr_deref_127_root_address_calculated_296_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_root_address_calculated
        ptr_deref_127_word_address_calculated_297_symbol <= ptr_deref_127_root_address_calculated_296_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_word_address_calculated
        ptr_deref_127_request_298: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request 
          signal ptr_deref_127_request_298_start: Boolean;
          signal Xentry_299_symbol: Boolean;
          signal Xexit_300_symbol: Boolean;
          signal split_req_301_symbol : Boolean;
          signal split_ack_302_symbol : Boolean;
          signal word_access_303_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_127_request_298_start <= ptr_deref_127_trigger_x_x293_symbol; -- control passed to block
          Xentry_299_symbol  <= ptr_deref_127_request_298_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/$entry
          split_req_301_symbol <= Xentry_299_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/split_req
          ptr_deref_127_gather_scatter_req_0 <= split_req_301_symbol; -- link to DP
          split_ack_302_symbol <= ptr_deref_127_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/split_ack
          word_access_303: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access 
            signal word_access_303_start: Boolean;
            signal Xentry_304_symbol: Boolean;
            signal Xexit_305_symbol: Boolean;
            signal word_access_0_306_symbol : Boolean;
            -- 
          begin -- 
            word_access_303_start <= split_ack_302_symbol; -- control passed to block
            Xentry_304_symbol  <= word_access_303_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/$entry
            word_access_0_306: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/word_access_0 
              signal word_access_0_306_start: Boolean;
              signal Xentry_307_symbol: Boolean;
              signal Xexit_308_symbol: Boolean;
              signal rr_309_symbol : Boolean;
              signal ra_310_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_306_start <= Xentry_304_symbol; -- control passed to block
              Xentry_307_symbol  <= word_access_0_306_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/word_access_0/$entry
              rr_309_symbol <= Xentry_307_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/word_access_0/rr
              ptr_deref_127_store_0_req_0 <= rr_309_symbol; -- link to DP
              ra_310_symbol <= ptr_deref_127_store_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/word_access_0/ra
              Xexit_308_symbol <= ra_310_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/word_access_0/$exit
              word_access_0_306_symbol <= Xexit_308_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/word_access_0
            Xexit_305_symbol <= word_access_0_306_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access/$exit
            word_access_303_symbol <= Xexit_305_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/word_access
          Xexit_300_symbol <= word_access_303_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request/$exit
          ptr_deref_127_request_298_symbol <= Xexit_300_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_request
        ptr_deref_127_complete_311: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete 
          signal ptr_deref_127_complete_311_start: Boolean;
          signal Xentry_312_symbol: Boolean;
          signal Xexit_313_symbol: Boolean;
          signal word_access_314_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_127_complete_311_start <= ptr_deref_127_active_x_x294_symbol; -- control passed to block
          Xentry_312_symbol  <= ptr_deref_127_complete_311_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/$entry
          word_access_314: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access 
            signal word_access_314_start: Boolean;
            signal Xentry_315_symbol: Boolean;
            signal Xexit_316_symbol: Boolean;
            signal word_access_0_317_symbol : Boolean;
            -- 
          begin -- 
            word_access_314_start <= Xentry_312_symbol; -- control passed to block
            Xentry_315_symbol  <= word_access_314_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/$entry
            word_access_0_317: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/word_access_0 
              signal word_access_0_317_start: Boolean;
              signal Xentry_318_symbol: Boolean;
              signal Xexit_319_symbol: Boolean;
              signal cr_320_symbol : Boolean;
              signal ca_321_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_317_start <= Xentry_315_symbol; -- control passed to block
              Xentry_318_symbol  <= word_access_0_317_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/word_access_0/$entry
              cr_320_symbol <= Xentry_318_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/word_access_0/cr
              ptr_deref_127_store_0_req_1 <= cr_320_symbol; -- link to DP
              ca_321_symbol <= ptr_deref_127_store_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/word_access_0/ca
              Xexit_319_symbol <= ca_321_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/word_access_0/$exit
              word_access_0_317_symbol <= Xexit_319_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/word_access_0
            Xexit_316_symbol <= word_access_0_317_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access/$exit
            word_access_314_symbol <= Xexit_316_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/word_access
          Xexit_313_symbol <= word_access_314_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete/$exit
          ptr_deref_127_complete_311_symbol <= Xexit_313_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/ptr_deref_127_complete
        assign_stmt_137_active_x_x322_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/assign_stmt_137_active_
        assign_stmt_137_completed_x_x323_symbol <= simple_obj_ref_135_complete_341_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/assign_stmt_137_completed_
        simple_obj_ref_135_trigger_x_x324_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_trigger_ 
          signal simple_obj_ref_135_trigger_x_x324_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_135_trigger_x_x324_predecessors(0) <= simple_obj_ref_135_word_address_calculated_327_symbol;
          simple_obj_ref_135_trigger_x_x324_predecessors(1) <= assign_stmt_137_active_x_x322_symbol;
          simple_obj_ref_135_trigger_x_x324_join: join -- 
            port map( -- 
              preds => simple_obj_ref_135_trigger_x_x324_predecessors,
              symbol_out => simple_obj_ref_135_trigger_x_x324_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_trigger_
        simple_obj_ref_135_active_x_x325_symbol <= simple_obj_ref_135_request_328_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_active_
        simple_obj_ref_135_root_address_calculated_326_symbol <= Xentry_258_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_root_address_calculated
        simple_obj_ref_135_word_address_calculated_327_symbol <= simple_obj_ref_135_root_address_calculated_326_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_word_address_calculated
        simple_obj_ref_135_request_328: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request 
          signal simple_obj_ref_135_request_328_start: Boolean;
          signal Xentry_329_symbol: Boolean;
          signal Xexit_330_symbol: Boolean;
          signal split_req_331_symbol : Boolean;
          signal split_ack_332_symbol : Boolean;
          signal word_access_333_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_135_request_328_start <= simple_obj_ref_135_trigger_x_x324_symbol; -- control passed to block
          Xentry_329_symbol  <= simple_obj_ref_135_request_328_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/$entry
          split_req_331_symbol <= Xentry_329_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/split_req
          simple_obj_ref_135_gather_scatter_req_0 <= split_req_331_symbol; -- link to DP
          split_ack_332_symbol <= simple_obj_ref_135_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/split_ack
          word_access_333: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access 
            signal word_access_333_start: Boolean;
            signal Xentry_334_symbol: Boolean;
            signal Xexit_335_symbol: Boolean;
            signal word_access_0_336_symbol : Boolean;
            -- 
          begin -- 
            word_access_333_start <= split_ack_332_symbol; -- control passed to block
            Xentry_334_symbol  <= word_access_333_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/$entry
            word_access_0_336: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/word_access_0 
              signal word_access_0_336_start: Boolean;
              signal Xentry_337_symbol: Boolean;
              signal Xexit_338_symbol: Boolean;
              signal rr_339_symbol : Boolean;
              signal ra_340_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_336_start <= Xentry_334_symbol; -- control passed to block
              Xentry_337_symbol  <= word_access_0_336_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/word_access_0/$entry
              rr_339_symbol <= Xentry_337_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/word_access_0/rr
              simple_obj_ref_135_store_0_req_0 <= rr_339_symbol; -- link to DP
              ra_340_symbol <= simple_obj_ref_135_store_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/word_access_0/ra
              Xexit_338_symbol <= ra_340_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/word_access_0/$exit
              word_access_0_336_symbol <= Xexit_338_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/word_access_0
            Xexit_335_symbol <= word_access_0_336_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access/$exit
            word_access_333_symbol <= Xexit_335_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/word_access
          Xexit_330_symbol <= word_access_333_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request/$exit
          simple_obj_ref_135_request_328_symbol <= Xexit_330_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_request
        simple_obj_ref_135_complete_341: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete 
          signal simple_obj_ref_135_complete_341_start: Boolean;
          signal Xentry_342_symbol: Boolean;
          signal Xexit_343_symbol: Boolean;
          signal word_access_344_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_135_complete_341_start <= simple_obj_ref_135_active_x_x325_symbol; -- control passed to block
          Xentry_342_symbol  <= simple_obj_ref_135_complete_341_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/$entry
          word_access_344: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access 
            signal word_access_344_start: Boolean;
            signal Xentry_345_symbol: Boolean;
            signal Xexit_346_symbol: Boolean;
            signal word_access_0_347_symbol : Boolean;
            -- 
          begin -- 
            word_access_344_start <= Xentry_342_symbol; -- control passed to block
            Xentry_345_symbol  <= word_access_344_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/$entry
            word_access_0_347: Block -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/word_access_0 
              signal word_access_0_347_start: Boolean;
              signal Xentry_348_symbol: Boolean;
              signal Xexit_349_symbol: Boolean;
              signal cr_350_symbol : Boolean;
              signal ca_351_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_347_start <= Xentry_345_symbol; -- control passed to block
              Xentry_348_symbol  <= word_access_0_347_start; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/word_access_0/$entry
              cr_350_symbol <= Xentry_348_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/word_access_0/cr
              simple_obj_ref_135_store_0_req_1 <= cr_350_symbol; -- link to DP
              ca_351_symbol <= simple_obj_ref_135_store_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/word_access_0/ca
              Xexit_349_symbol <= ca_351_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/word_access_0/$exit
              word_access_0_347_symbol <= Xexit_349_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/word_access_0
            Xexit_346_symbol <= word_access_0_347_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access/$exit
            word_access_344_symbol <= Xexit_346_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/word_access
          Xexit_343_symbol <= word_access_344_symbol; -- transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete/$exit
          simple_obj_ref_135_complete_341_symbol <= Xexit_343_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/simple_obj_ref_135_complete
        Xexit_259_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/$exit 
          signal Xexit_259_predecessors: BooleanArray(4 downto 0);
          -- 
        begin -- 
          Xexit_259_predecessors(0) <= assign_stmt_119_completed_x_x261_symbol;
          Xexit_259_predecessors(1) <= ptr_deref_117_base_address_calculated_264_symbol;
          Xexit_259_predecessors(2) <= assign_stmt_129_completed_x_x292_symbol;
          Xexit_259_predecessors(3) <= ptr_deref_127_base_address_calculated_295_symbol;
          Xexit_259_predecessors(4) <= assign_stmt_137_completed_x_x323_symbol;
          Xexit_259_join: join -- 
            port map( -- 
              preds => Xexit_259_predecessors,
              symbol_out => Xexit_259_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137/$exit
        assign_stmt_109_to_assign_stmt_137_257_symbol <= Xexit_259_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_109_to_assign_stmt_137
      assign_stmt_144_352: Block -- branch_block_stmt_104/assign_stmt_144 
        signal assign_stmt_144_352_start: Boolean;
        signal Xentry_353_symbol: Boolean;
        signal Xexit_354_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_144_352_start <= assign_stmt_144_x_xentry_x_xx_x226_symbol; -- control passed to block
        Xentry_353_symbol  <= assign_stmt_144_352_start; -- transition branch_block_stmt_104/assign_stmt_144/$entry
        Xexit_354_symbol <= Xentry_353_symbol; -- transition branch_block_stmt_104/assign_stmt_144/$exit
        assign_stmt_144_352_symbol <= Xexit_354_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_144
      assign_stmt_148_355: Block -- branch_block_stmt_104/assign_stmt_148 
        signal assign_stmt_148_355_start: Boolean;
        signal Xentry_356_symbol: Boolean;
        signal Xexit_357_symbol: Boolean;
        signal assign_stmt_148_active_x_x358_symbol : Boolean;
        signal assign_stmt_148_completed_x_x359_symbol : Boolean;
        signal type_cast_147_active_x_x360_symbol : Boolean;
        signal type_cast_147_trigger_x_x361_symbol : Boolean;
        signal simple_obj_ref_146_trigger_x_x362_symbol : Boolean;
        signal simple_obj_ref_146_complete_363_symbol : Boolean;
        signal type_cast_147_complete_368_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_148_355_start <= assign_stmt_148_x_xentry_x_xx_x228_symbol; -- control passed to block
        Xentry_356_symbol  <= assign_stmt_148_355_start; -- transition branch_block_stmt_104/assign_stmt_148/$entry
        assign_stmt_148_active_x_x358_symbol <= type_cast_147_complete_368_symbol; -- transition branch_block_stmt_104/assign_stmt_148/assign_stmt_148_active_
        assign_stmt_148_completed_x_x359_symbol <= assign_stmt_148_active_x_x358_symbol; -- transition branch_block_stmt_104/assign_stmt_148/assign_stmt_148_completed_
        type_cast_147_active_x_x360_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_148/type_cast_147_active_ 
          signal type_cast_147_active_x_x360_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_147_active_x_x360_predecessors(0) <= type_cast_147_trigger_x_x361_symbol;
          type_cast_147_active_x_x360_predecessors(1) <= simple_obj_ref_146_complete_363_symbol;
          type_cast_147_active_x_x360_join: join -- 
            port map( -- 
              preds => type_cast_147_active_x_x360_predecessors,
              symbol_out => type_cast_147_active_x_x360_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_148/type_cast_147_active_
        type_cast_147_trigger_x_x361_symbol <= Xentry_356_symbol; -- transition branch_block_stmt_104/assign_stmt_148/type_cast_147_trigger_
        simple_obj_ref_146_trigger_x_x362_symbol <= Xentry_356_symbol; -- transition branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_trigger_
        simple_obj_ref_146_complete_363: Block -- branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_complete 
          signal simple_obj_ref_146_complete_363_start: Boolean;
          signal Xentry_364_symbol: Boolean;
          signal Xexit_365_symbol: Boolean;
          signal req_366_symbol : Boolean;
          signal ack_367_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_146_complete_363_start <= simple_obj_ref_146_trigger_x_x362_symbol; -- control passed to block
          Xentry_364_symbol  <= simple_obj_ref_146_complete_363_start; -- transition branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_complete/$entry
          req_366_symbol <= Xentry_364_symbol; -- transition branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_complete/req
          simple_obj_ref_146_inst_req_0 <= req_366_symbol; -- link to DP
          ack_367_symbol <= simple_obj_ref_146_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_complete/ack
          Xexit_365_symbol <= ack_367_symbol; -- transition branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_complete/$exit
          simple_obj_ref_146_complete_363_symbol <= Xexit_365_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_148/simple_obj_ref_146_complete
        type_cast_147_complete_368: Block -- branch_block_stmt_104/assign_stmt_148/type_cast_147_complete 
          signal type_cast_147_complete_368_start: Boolean;
          signal Xentry_369_symbol: Boolean;
          signal Xexit_370_symbol: Boolean;
          signal req_371_symbol : Boolean;
          signal ack_372_symbol : Boolean;
          -- 
        begin -- 
          type_cast_147_complete_368_start <= type_cast_147_active_x_x360_symbol; -- control passed to block
          Xentry_369_symbol  <= type_cast_147_complete_368_start; -- transition branch_block_stmt_104/assign_stmt_148/type_cast_147_complete/$entry
          req_371_symbol <= Xentry_369_symbol; -- transition branch_block_stmt_104/assign_stmt_148/type_cast_147_complete/req
          type_cast_147_inst_req_0 <= req_371_symbol; -- link to DP
          ack_372_symbol <= type_cast_147_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_148/type_cast_147_complete/ack
          Xexit_370_symbol <= ack_372_symbol; -- transition branch_block_stmt_104/assign_stmt_148/type_cast_147_complete/$exit
          type_cast_147_complete_368_symbol <= Xexit_370_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_148/type_cast_147_complete
        Xexit_357_symbol <= assign_stmt_148_completed_x_x359_symbol; -- transition branch_block_stmt_104/assign_stmt_148/$exit
        assign_stmt_148_355_symbol <= Xexit_357_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_148
      switch_stmt_149_dead_link_373: Block -- branch_block_stmt_104/switch_stmt_149_dead_link 
        signal switch_stmt_149_dead_link_373_start: Boolean;
        signal Xentry_374_symbol: Boolean;
        signal Xexit_375_symbol: Boolean;
        signal dead_transition_376_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_149_dead_link_373_start <= switch_stmt_149_x_xentry_x_xx_x230_symbol; -- control passed to block
        Xentry_374_symbol  <= switch_stmt_149_dead_link_373_start; -- transition branch_block_stmt_104/switch_stmt_149_dead_link/$entry
        dead_transition_376_symbol <= false;
        Xexit_375_symbol <= dead_transition_376_symbol; -- transition branch_block_stmt_104/switch_stmt_149_dead_link/$exit
        switch_stmt_149_dead_link_373_symbol <= Xexit_375_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/switch_stmt_149_dead_link
      switch_stmt_149_x_xcondition_check_place_x_xx_x377_symbol  <=  switch_stmt_149_x_xentry_x_xx_x230_symbol; -- place branch_block_stmt_104/switch_stmt_149__condition_check_place__ (optimized away) 
      switch_stmt_149_x_xcondition_check_x_xx_x378: Block -- branch_block_stmt_104/switch_stmt_149__condition_check__ 
        signal switch_stmt_149_x_xcondition_check_x_xx_x378_start: Boolean;
        signal Xentry_379_symbol: Boolean;
        signal Xexit_380_symbol: Boolean;
        signal condition_0_381_symbol : Boolean;
        signal condition_1_389_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_149_x_xcondition_check_x_xx_x378_start <= switch_stmt_149_x_xcondition_check_place_x_xx_x377_symbol; -- control passed to block
        Xentry_379_symbol  <= switch_stmt_149_x_xcondition_check_x_xx_x378_start; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/$entry
        condition_0_381: Block -- branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0 
          signal condition_0_381_start: Boolean;
          signal Xentry_382_symbol: Boolean;
          signal Xexit_383_symbol: Boolean;
          signal rr_384_symbol : Boolean;
          signal ra_385_symbol : Boolean;
          signal cr_386_symbol : Boolean;
          signal ca_387_symbol : Boolean;
          signal cmp_388_symbol : Boolean;
          -- 
        begin -- 
          condition_0_381_start <= Xentry_379_symbol; -- control passed to block
          Xentry_382_symbol  <= condition_0_381_start; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/$entry
          rr_384_symbol <= Xentry_382_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/rr
          switch_stmt_149_select_expr_0_req_0 <= rr_384_symbol; -- link to DP
          ra_385_symbol <= switch_stmt_149_select_expr_0_ack_0; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/ra
          cr_386_symbol <= ra_385_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/cr
          switch_stmt_149_select_expr_0_req_1 <= cr_386_symbol; -- link to DP
          ca_387_symbol <= switch_stmt_149_select_expr_0_ack_1; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/ca
          cmp_388_symbol <= ca_387_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/cmp
          switch_stmt_149_branch_0_req_0 <= cmp_388_symbol; -- link to DP
          Xexit_383_symbol <= cmp_388_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0/$exit
          condition_0_381_symbol <= Xexit_383_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/switch_stmt_149__condition_check__/condition_0
        condition_1_389: Block -- branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1 
          signal condition_1_389_start: Boolean;
          signal Xentry_390_symbol: Boolean;
          signal Xexit_391_symbol: Boolean;
          signal rr_392_symbol : Boolean;
          signal ra_393_symbol : Boolean;
          signal cr_394_symbol : Boolean;
          signal ca_395_symbol : Boolean;
          signal cmp_396_symbol : Boolean;
          -- 
        begin -- 
          condition_1_389_start <= Xentry_379_symbol; -- control passed to block
          Xentry_390_symbol  <= condition_1_389_start; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/$entry
          rr_392_symbol <= Xentry_390_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/rr
          switch_stmt_149_select_expr_1_req_0 <= rr_392_symbol; -- link to DP
          ra_393_symbol <= switch_stmt_149_select_expr_1_ack_0; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/ra
          cr_394_symbol <= ra_393_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/cr
          switch_stmt_149_select_expr_1_req_1 <= cr_394_symbol; -- link to DP
          ca_395_symbol <= switch_stmt_149_select_expr_1_ack_1; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/ca
          cmp_396_symbol <= ca_395_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/cmp
          switch_stmt_149_branch_1_req_0 <= cmp_396_symbol; -- link to DP
          Xexit_391_symbol <= cmp_396_symbol; -- transition branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1/$exit
          condition_1_389_symbol <= Xexit_391_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/switch_stmt_149__condition_check__/condition_1
        Xexit_380_block : Block -- non-trivial join transition branch_block_stmt_104/switch_stmt_149__condition_check__/$exit 
          signal Xexit_380_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_380_predecessors(0) <= condition_0_381_symbol;
          Xexit_380_predecessors(1) <= condition_1_389_symbol;
          Xexit_380_join: join -- 
            port map( -- 
              preds => Xexit_380_predecessors,
              symbol_out => Xexit_380_symbol,
              clk => clk,
              reset => reset); -- 
          switch_stmt_149_branch_default_req_0 <= Xexit_380_symbol; -- link to DP
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/switch_stmt_149__condition_check__/$exit
        switch_stmt_149_x_xcondition_check_x_xx_x378_symbol <= Xexit_380_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/switch_stmt_149__condition_check__
      switch_stmt_149_x_xselect_x_xx_x397_symbol  <=  switch_stmt_149_x_xcondition_check_x_xx_x378_symbol; -- place branch_block_stmt_104/switch_stmt_149__select__ (optimized away) 
      switch_stmt_149_choice_0_398: Block -- branch_block_stmt_104/switch_stmt_149_choice_0 
        signal switch_stmt_149_choice_0_398_start: Boolean;
        signal Xentry_399_symbol: Boolean;
        signal Xexit_400_symbol: Boolean;
        signal ack1_401_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_149_choice_0_398_start <= switch_stmt_149_x_xselect_x_xx_x397_symbol; -- control passed to block
        Xentry_399_symbol  <= switch_stmt_149_choice_0_398_start; -- transition branch_block_stmt_104/switch_stmt_149_choice_0/$entry
        ack1_401_symbol <= switch_stmt_149_branch_0_ack_1; -- transition branch_block_stmt_104/switch_stmt_149_choice_0/ack1
        Xexit_400_symbol <= ack1_401_symbol; -- transition branch_block_stmt_104/switch_stmt_149_choice_0/$exit
        switch_stmt_149_choice_0_398_symbol <= Xexit_400_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/switch_stmt_149_choice_0
      xx_xbackedge_bb_2_402_symbol  <=  switch_stmt_149_choice_0_398_symbol; -- place branch_block_stmt_104/xx_xbackedge_bb_2 (optimized away) 
      switch_stmt_149_choice_1_403: Block -- branch_block_stmt_104/switch_stmt_149_choice_1 
        signal switch_stmt_149_choice_1_403_start: Boolean;
        signal Xentry_404_symbol: Boolean;
        signal Xexit_405_symbol: Boolean;
        signal ack1_406_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_149_choice_1_403_start <= switch_stmt_149_x_xselect_x_xx_x397_symbol; -- control passed to block
        Xentry_404_symbol  <= switch_stmt_149_choice_1_403_start; -- transition branch_block_stmt_104/switch_stmt_149_choice_1/$entry
        ack1_406_symbol <= switch_stmt_149_branch_1_ack_1; -- transition branch_block_stmt_104/switch_stmt_149_choice_1/ack1
        Xexit_405_symbol <= ack1_406_symbol; -- transition branch_block_stmt_104/switch_stmt_149_choice_1/$exit
        switch_stmt_149_choice_1_403_symbol <= Xexit_405_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/switch_stmt_149_choice_1
      xx_xbackedge_bb_5_407_symbol  <=  switch_stmt_149_choice_1_403_symbol; -- place branch_block_stmt_104/xx_xbackedge_bb_5 (optimized away) 
      switch_stmt_149_choice_default_408: Block -- branch_block_stmt_104/switch_stmt_149_choice_default 
        signal switch_stmt_149_choice_default_408_start: Boolean;
        signal Xentry_409_symbol: Boolean;
        signal Xexit_410_symbol: Boolean;
        signal ack0_411_symbol : Boolean;
        -- 
      begin -- 
        switch_stmt_149_choice_default_408_start <= switch_stmt_149_x_xselect_x_xx_x397_symbol; -- control passed to block
        Xentry_409_symbol  <= switch_stmt_149_choice_default_408_start; -- transition branch_block_stmt_104/switch_stmt_149_choice_default/$entry
        ack0_411_symbol <= switch_stmt_149_branch_default_ack_0; -- transition branch_block_stmt_104/switch_stmt_149_choice_default/ack0
        Xexit_410_symbol <= ack0_411_symbol; -- transition branch_block_stmt_104/switch_stmt_149_choice_default/$exit
        switch_stmt_149_choice_default_408_symbol <= Xexit_410_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/switch_stmt_149_choice_default
      xx_xbackedge_xx_xbackedge_412_symbol  <=  switch_stmt_149_choice_default_408_symbol; -- place branch_block_stmt_104/xx_xbackedge_xx_xbackedge (optimized away) 
      assign_stmt_162_to_assign_stmt_168_413: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168 
        signal assign_stmt_162_to_assign_stmt_168_413_start: Boolean;
        signal Xentry_414_symbol: Boolean;
        signal Xexit_415_symbol: Boolean;
        signal assign_stmt_162_active_x_x416_symbol : Boolean;
        signal assign_stmt_162_completed_x_x417_symbol : Boolean;
        signal simple_obj_ref_161_trigger_x_x418_symbol : Boolean;
        signal simple_obj_ref_161_active_x_x419_symbol : Boolean;
        signal simple_obj_ref_161_root_address_calculated_420_symbol : Boolean;
        signal simple_obj_ref_161_word_address_calculated_421_symbol : Boolean;
        signal simple_obj_ref_161_request_422_symbol : Boolean;
        signal simple_obj_ref_161_complete_433_symbol : Boolean;
        signal assign_stmt_168_active_x_x446_symbol : Boolean;
        signal assign_stmt_168_completed_x_x447_symbol : Boolean;
        signal binary_166_active_x_x448_symbol : Boolean;
        signal binary_166_trigger_x_x449_symbol : Boolean;
        signal simple_obj_ref_164_complete_450_symbol : Boolean;
        signal binary_166_complete_451_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_162_to_assign_stmt_168_413_start <= assign_stmt_162_to_assign_stmt_168_x_xentry_x_xx_x234_symbol; -- control passed to block
        Xentry_414_symbol  <= assign_stmt_162_to_assign_stmt_168_413_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/$entry
        assign_stmt_162_active_x_x416_symbol <= simple_obj_ref_161_complete_433_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/assign_stmt_162_active_
        assign_stmt_162_completed_x_x417_symbol <= assign_stmt_162_active_x_x416_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/assign_stmt_162_completed_
        simple_obj_ref_161_trigger_x_x418_symbol <= simple_obj_ref_161_word_address_calculated_421_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_trigger_
        simple_obj_ref_161_active_x_x419_symbol <= simple_obj_ref_161_request_422_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_active_
        simple_obj_ref_161_root_address_calculated_420_symbol <= Xentry_414_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_root_address_calculated
        simple_obj_ref_161_word_address_calculated_421_symbol <= simple_obj_ref_161_root_address_calculated_420_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_word_address_calculated
        simple_obj_ref_161_request_422: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request 
          signal simple_obj_ref_161_request_422_start: Boolean;
          signal Xentry_423_symbol: Boolean;
          signal Xexit_424_symbol: Boolean;
          signal word_access_425_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_161_request_422_start <= simple_obj_ref_161_trigger_x_x418_symbol; -- control passed to block
          Xentry_423_symbol  <= simple_obj_ref_161_request_422_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/$entry
          word_access_425: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access 
            signal word_access_425_start: Boolean;
            signal Xentry_426_symbol: Boolean;
            signal Xexit_427_symbol: Boolean;
            signal word_access_0_428_symbol : Boolean;
            -- 
          begin -- 
            word_access_425_start <= Xentry_423_symbol; -- control passed to block
            Xentry_426_symbol  <= word_access_425_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/$entry
            word_access_0_428: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/word_access_0 
              signal word_access_0_428_start: Boolean;
              signal Xentry_429_symbol: Boolean;
              signal Xexit_430_symbol: Boolean;
              signal rr_431_symbol : Boolean;
              signal ra_432_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_428_start <= Xentry_426_symbol; -- control passed to block
              Xentry_429_symbol  <= word_access_0_428_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/word_access_0/$entry
              rr_431_symbol <= Xentry_429_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/word_access_0/rr
              simple_obj_ref_161_load_0_req_0 <= rr_431_symbol; -- link to DP
              ra_432_symbol <= simple_obj_ref_161_load_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/word_access_0/ra
              Xexit_430_symbol <= ra_432_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/word_access_0/$exit
              word_access_0_428_symbol <= Xexit_430_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/word_access_0
            Xexit_427_symbol <= word_access_0_428_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access/$exit
            word_access_425_symbol <= Xexit_427_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/word_access
          Xexit_424_symbol <= word_access_425_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request/$exit
          simple_obj_ref_161_request_422_symbol <= Xexit_424_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_request
        simple_obj_ref_161_complete_433: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete 
          signal simple_obj_ref_161_complete_433_start: Boolean;
          signal Xentry_434_symbol: Boolean;
          signal Xexit_435_symbol: Boolean;
          signal word_access_436_symbol : Boolean;
          signal merge_req_444_symbol : Boolean;
          signal merge_ack_445_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_161_complete_433_start <= simple_obj_ref_161_active_x_x419_symbol; -- control passed to block
          Xentry_434_symbol  <= simple_obj_ref_161_complete_433_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/$entry
          word_access_436: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access 
            signal word_access_436_start: Boolean;
            signal Xentry_437_symbol: Boolean;
            signal Xexit_438_symbol: Boolean;
            signal word_access_0_439_symbol : Boolean;
            -- 
          begin -- 
            word_access_436_start <= Xentry_434_symbol; -- control passed to block
            Xentry_437_symbol  <= word_access_436_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/$entry
            word_access_0_439: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/word_access_0 
              signal word_access_0_439_start: Boolean;
              signal Xentry_440_symbol: Boolean;
              signal Xexit_441_symbol: Boolean;
              signal cr_442_symbol : Boolean;
              signal ca_443_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_439_start <= Xentry_437_symbol; -- control passed to block
              Xentry_440_symbol  <= word_access_0_439_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/word_access_0/$entry
              cr_442_symbol <= Xentry_440_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/word_access_0/cr
              simple_obj_ref_161_load_0_req_1 <= cr_442_symbol; -- link to DP
              ca_443_symbol <= simple_obj_ref_161_load_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/word_access_0/ca
              Xexit_441_symbol <= ca_443_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/word_access_0/$exit
              word_access_0_439_symbol <= Xexit_441_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/word_access_0
            Xexit_438_symbol <= word_access_0_439_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access/$exit
            word_access_436_symbol <= Xexit_438_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/word_access
          merge_req_444_symbol <= word_access_436_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/merge_req
          simple_obj_ref_161_gather_scatter_req_0 <= merge_req_444_symbol; -- link to DP
          merge_ack_445_symbol <= simple_obj_ref_161_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/merge_ack
          Xexit_435_symbol <= merge_ack_445_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete/$exit
          simple_obj_ref_161_complete_433_symbol <= Xexit_435_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_161_complete
        assign_stmt_168_active_x_x446_symbol <= binary_166_complete_451_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/assign_stmt_168_active_
        assign_stmt_168_completed_x_x447_symbol <= assign_stmt_168_active_x_x446_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/assign_stmt_168_completed_
        binary_166_active_x_x448_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_active_ 
          signal binary_166_active_x_x448_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_166_active_x_x448_predecessors(0) <= binary_166_trigger_x_x449_symbol;
          binary_166_active_x_x448_predecessors(1) <= simple_obj_ref_164_complete_450_symbol;
          binary_166_active_x_x448_join: join -- 
            port map( -- 
              preds => binary_166_active_x_x448_predecessors,
              symbol_out => binary_166_active_x_x448_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_active_
        binary_166_trigger_x_x449_symbol <= Xentry_414_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_trigger_
        simple_obj_ref_164_complete_450_symbol <= assign_stmt_162_completed_x_x417_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/simple_obj_ref_164_complete
        binary_166_complete_451: Block -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete 
          signal binary_166_complete_451_start: Boolean;
          signal Xentry_452_symbol: Boolean;
          signal Xexit_453_symbol: Boolean;
          signal rr_454_symbol : Boolean;
          signal ra_455_symbol : Boolean;
          signal cr_456_symbol : Boolean;
          signal ca_457_symbol : Boolean;
          -- 
        begin -- 
          binary_166_complete_451_start <= binary_166_active_x_x448_symbol; -- control passed to block
          Xentry_452_symbol  <= binary_166_complete_451_start; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete/$entry
          rr_454_symbol <= Xentry_452_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete/rr
          binary_166_inst_req_0 <= rr_454_symbol; -- link to DP
          ra_455_symbol <= binary_166_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete/ra
          cr_456_symbol <= ra_455_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete/cr
          binary_166_inst_req_1 <= cr_456_symbol; -- link to DP
          ca_457_symbol <= binary_166_inst_ack_1; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete/ca
          Xexit_453_symbol <= ca_457_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete/$exit
          binary_166_complete_451_symbol <= Xexit_453_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/binary_166_complete
        Xexit_415_symbol <= assign_stmt_168_completed_x_x447_symbol; -- transition branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168/$exit
        assign_stmt_162_to_assign_stmt_168_413_symbol <= Xexit_415_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_162_to_assign_stmt_168
      if_stmt_169_dead_link_458: Block -- branch_block_stmt_104/if_stmt_169_dead_link 
        signal if_stmt_169_dead_link_458_start: Boolean;
        signal Xentry_459_symbol: Boolean;
        signal Xexit_460_symbol: Boolean;
        signal dead_transition_461_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_169_dead_link_458_start <= if_stmt_169_x_xentry_x_xx_x236_symbol; -- control passed to block
        Xentry_459_symbol  <= if_stmt_169_dead_link_458_start; -- transition branch_block_stmt_104/if_stmt_169_dead_link/$entry
        dead_transition_461_symbol <= false;
        Xexit_460_symbol <= dead_transition_461_symbol; -- transition branch_block_stmt_104/if_stmt_169_dead_link/$exit
        if_stmt_169_dead_link_458_symbol <= Xexit_460_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/if_stmt_169_dead_link
      if_stmt_169_eval_test_462: Block -- branch_block_stmt_104/if_stmt_169_eval_test 
        signal if_stmt_169_eval_test_462_start: Boolean;
        signal Xentry_463_symbol: Boolean;
        signal Xexit_464_symbol: Boolean;
        signal branch_req_465_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_169_eval_test_462_start <= if_stmt_169_x_xentry_x_xx_x236_symbol; -- control passed to block
        Xentry_463_symbol  <= if_stmt_169_eval_test_462_start; -- transition branch_block_stmt_104/if_stmt_169_eval_test/$entry
        branch_req_465_symbol <= Xentry_463_symbol; -- transition branch_block_stmt_104/if_stmt_169_eval_test/branch_req
        if_stmt_169_branch_req_0 <= branch_req_465_symbol; -- link to DP
        Xexit_464_symbol <= branch_req_465_symbol; -- transition branch_block_stmt_104/if_stmt_169_eval_test/$exit
        if_stmt_169_eval_test_462_symbol <= Xexit_464_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/if_stmt_169_eval_test
      simple_obj_ref_170_place_466_symbol  <=  if_stmt_169_eval_test_462_symbol; -- place branch_block_stmt_104/simple_obj_ref_170_place (optimized away) 
      if_stmt_169_if_link_467: Block -- branch_block_stmt_104/if_stmt_169_if_link 
        signal if_stmt_169_if_link_467_start: Boolean;
        signal Xentry_468_symbol: Boolean;
        signal Xexit_469_symbol: Boolean;
        signal if_choice_transition_470_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_169_if_link_467_start <= simple_obj_ref_170_place_466_symbol; -- control passed to block
        Xentry_468_symbol  <= if_stmt_169_if_link_467_start; -- transition branch_block_stmt_104/if_stmt_169_if_link/$entry
        if_choice_transition_470_symbol <= if_stmt_169_branch_ack_1; -- transition branch_block_stmt_104/if_stmt_169_if_link/if_choice_transition
        Xexit_469_symbol <= if_choice_transition_470_symbol; -- transition branch_block_stmt_104/if_stmt_169_if_link/$exit
        if_stmt_169_if_link_467_symbol <= Xexit_469_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/if_stmt_169_if_link
      if_stmt_169_else_link_471: Block -- branch_block_stmt_104/if_stmt_169_else_link 
        signal if_stmt_169_else_link_471_start: Boolean;
        signal Xentry_472_symbol: Boolean;
        signal Xexit_473_symbol: Boolean;
        signal else_choice_transition_474_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_169_else_link_471_start <= simple_obj_ref_170_place_466_symbol; -- control passed to block
        Xentry_472_symbol  <= if_stmt_169_else_link_471_start; -- transition branch_block_stmt_104/if_stmt_169_else_link/$entry
        else_choice_transition_474_symbol <= if_stmt_169_branch_ack_0; -- transition branch_block_stmt_104/if_stmt_169_else_link/else_choice_transition
        Xexit_473_symbol <= else_choice_transition_474_symbol; -- transition branch_block_stmt_104/if_stmt_169_else_link/$exit
        if_stmt_169_else_link_471_symbol <= Xexit_473_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/if_stmt_169_else_link
      bb_2_bb_4_475_symbol  <=  if_stmt_169_if_link_467_symbol; -- place branch_block_stmt_104/bb_2_bb_4 (optimized away) 
      bb_2_bb_3_476_symbol  <=  if_stmt_169_else_link_471_symbol; -- place branch_block_stmt_104/bb_2_bb_3 (optimized away) 
      assign_stmt_180_to_assign_stmt_187_477: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187 
        signal assign_stmt_180_to_assign_stmt_187_477_start: Boolean;
        signal Xentry_478_symbol: Boolean;
        signal Xexit_479_symbol: Boolean;
        signal assign_stmt_180_active_x_x480_symbol : Boolean;
        signal assign_stmt_180_completed_x_x481_symbol : Boolean;
        signal array_obj_ref_179_trigger_x_x482_symbol : Boolean;
        signal array_obj_ref_179_active_x_x483_symbol : Boolean;
        signal array_obj_ref_179_base_address_calculated_484_symbol : Boolean;
        signal array_obj_ref_179_root_address_calculated_485_symbol : Boolean;
        signal array_obj_ref_179_base_address_resized_486_symbol : Boolean;
        signal array_obj_ref_179_base_addr_resize_487_symbol : Boolean;
        signal array_obj_ref_179_base_plus_offset_492_symbol : Boolean;
        signal array_obj_ref_179_complete_497_symbol : Boolean;
        signal assign_stmt_184_active_x_x502_symbol : Boolean;
        signal assign_stmt_184_completed_x_x503_symbol : Boolean;
        signal ptr_deref_183_trigger_x_x504_symbol : Boolean;
        signal ptr_deref_183_active_x_x505_symbol : Boolean;
        signal ptr_deref_183_base_address_calculated_506_symbol : Boolean;
        signal simple_obj_ref_182_complete_507_symbol : Boolean;
        signal ptr_deref_183_root_address_calculated_508_symbol : Boolean;
        signal ptr_deref_183_word_address_calculated_509_symbol : Boolean;
        signal ptr_deref_183_base_address_resized_510_symbol : Boolean;
        signal ptr_deref_183_base_addr_resize_511_symbol : Boolean;
        signal ptr_deref_183_base_plus_offset_516_symbol : Boolean;
        signal ptr_deref_183_word_addrgen_521_symbol : Boolean;
        signal ptr_deref_183_request_526_symbol : Boolean;
        signal ptr_deref_183_complete_537_symbol : Boolean;
        signal assign_stmt_187_active_x_x550_symbol : Boolean;
        signal assign_stmt_187_completed_x_x551_symbol : Boolean;
        signal simple_obj_ref_186_complete_552_symbol : Boolean;
        signal simple_obj_ref_185_trigger_x_x553_symbol : Boolean;
        signal simple_obj_ref_185_active_x_x554_symbol : Boolean;
        signal simple_obj_ref_185_root_address_calculated_555_symbol : Boolean;
        signal simple_obj_ref_185_word_address_calculated_556_symbol : Boolean;
        signal simple_obj_ref_185_request_557_symbol : Boolean;
        signal simple_obj_ref_185_complete_570_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_180_to_assign_stmt_187_477_start <= assign_stmt_180_to_assign_stmt_187_x_xentry_x_xx_x240_symbol; -- control passed to block
        Xentry_478_symbol  <= assign_stmt_180_to_assign_stmt_187_477_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/$entry
        assign_stmt_180_active_x_x480_symbol <= array_obj_ref_179_complete_497_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/assign_stmt_180_active_
        assign_stmt_180_completed_x_x481_symbol <= assign_stmt_180_active_x_x480_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/assign_stmt_180_completed_
        array_obj_ref_179_trigger_x_x482_symbol <= Xentry_478_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_trigger_
        array_obj_ref_179_active_x_x483_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_active_ 
          signal array_obj_ref_179_active_x_x483_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          array_obj_ref_179_active_x_x483_predecessors(0) <= array_obj_ref_179_trigger_x_x482_symbol;
          array_obj_ref_179_active_x_x483_predecessors(1) <= array_obj_ref_179_root_address_calculated_485_symbol;
          array_obj_ref_179_active_x_x483_join: join -- 
            port map( -- 
              preds => array_obj_ref_179_active_x_x483_predecessors,
              symbol_out => array_obj_ref_179_active_x_x483_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_active_
        array_obj_ref_179_base_address_calculated_484_symbol <= Xentry_478_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_address_calculated
        array_obj_ref_179_root_address_calculated_485_symbol <= array_obj_ref_179_base_plus_offset_492_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_root_address_calculated
        array_obj_ref_179_base_address_resized_486_symbol <= array_obj_ref_179_base_addr_resize_487_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_address_resized
        array_obj_ref_179_base_addr_resize_487: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_addr_resize 
          signal array_obj_ref_179_base_addr_resize_487_start: Boolean;
          signal Xentry_488_symbol: Boolean;
          signal Xexit_489_symbol: Boolean;
          signal base_resize_req_490_symbol : Boolean;
          signal base_resize_ack_491_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_179_base_addr_resize_487_start <= array_obj_ref_179_base_address_calculated_484_symbol; -- control passed to block
          Xentry_488_symbol  <= array_obj_ref_179_base_addr_resize_487_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_addr_resize/$entry
          base_resize_req_490_symbol <= Xentry_488_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_addr_resize/base_resize_req
          array_obj_ref_179_base_resize_req_0 <= base_resize_req_490_symbol; -- link to DP
          base_resize_ack_491_symbol <= array_obj_ref_179_base_resize_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_addr_resize/base_resize_ack
          Xexit_489_symbol <= base_resize_ack_491_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_addr_resize/$exit
          array_obj_ref_179_base_addr_resize_487_symbol <= Xexit_489_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_addr_resize
        array_obj_ref_179_base_plus_offset_492: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_plus_offset 
          signal array_obj_ref_179_base_plus_offset_492_start: Boolean;
          signal Xentry_493_symbol: Boolean;
          signal Xexit_494_symbol: Boolean;
          signal sum_rename_req_495_symbol : Boolean;
          signal sum_rename_ack_496_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_179_base_plus_offset_492_start <= array_obj_ref_179_base_address_resized_486_symbol; -- control passed to block
          Xentry_493_symbol  <= array_obj_ref_179_base_plus_offset_492_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_plus_offset/$entry
          sum_rename_req_495_symbol <= Xentry_493_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_plus_offset/sum_rename_req
          array_obj_ref_179_root_address_inst_req_0 <= sum_rename_req_495_symbol; -- link to DP
          sum_rename_ack_496_symbol <= array_obj_ref_179_root_address_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_plus_offset/sum_rename_ack
          Xexit_494_symbol <= sum_rename_ack_496_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_plus_offset/$exit
          array_obj_ref_179_base_plus_offset_492_symbol <= Xexit_494_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_base_plus_offset
        array_obj_ref_179_complete_497: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_complete 
          signal array_obj_ref_179_complete_497_start: Boolean;
          signal Xentry_498_symbol: Boolean;
          signal Xexit_499_symbol: Boolean;
          signal final_reg_req_500_symbol : Boolean;
          signal final_reg_ack_501_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_179_complete_497_start <= array_obj_ref_179_active_x_x483_symbol; -- control passed to block
          Xentry_498_symbol  <= array_obj_ref_179_complete_497_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_complete/$entry
          final_reg_req_500_symbol <= Xentry_498_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_complete/final_reg_req
          array_obj_ref_179_final_reg_req_0 <= final_reg_req_500_symbol; -- link to DP
          final_reg_ack_501_symbol <= array_obj_ref_179_final_reg_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_complete/final_reg_ack
          Xexit_499_symbol <= final_reg_ack_501_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_complete/$exit
          array_obj_ref_179_complete_497_symbol <= Xexit_499_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/array_obj_ref_179_complete
        assign_stmt_184_active_x_x502_symbol <= ptr_deref_183_complete_537_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/assign_stmt_184_active_
        assign_stmt_184_completed_x_x503_symbol <= assign_stmt_184_active_x_x502_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/assign_stmt_184_completed_
        ptr_deref_183_trigger_x_x504_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_trigger_ 
          signal ptr_deref_183_trigger_x_x504_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_183_trigger_x_x504_predecessors(0) <= ptr_deref_183_word_address_calculated_509_symbol;
          ptr_deref_183_trigger_x_x504_predecessors(1) <= ptr_deref_183_base_address_calculated_506_symbol;
          ptr_deref_183_trigger_x_x504_join: join -- 
            port map( -- 
              preds => ptr_deref_183_trigger_x_x504_predecessors,
              symbol_out => ptr_deref_183_trigger_x_x504_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_trigger_
        ptr_deref_183_active_x_x505_symbol <= ptr_deref_183_request_526_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_active_
        ptr_deref_183_base_address_calculated_506_symbol <= simple_obj_ref_182_complete_507_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_address_calculated
        simple_obj_ref_182_complete_507_symbol <= assign_stmt_180_completed_x_x481_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_182_complete
        ptr_deref_183_root_address_calculated_508_symbol <= ptr_deref_183_base_plus_offset_516_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_root_address_calculated
        ptr_deref_183_word_address_calculated_509_symbol <= ptr_deref_183_word_addrgen_521_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_address_calculated
        ptr_deref_183_base_address_resized_510_symbol <= ptr_deref_183_base_addr_resize_511_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_address_resized
        ptr_deref_183_base_addr_resize_511: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_addr_resize 
          signal ptr_deref_183_base_addr_resize_511_start: Boolean;
          signal Xentry_512_symbol: Boolean;
          signal Xexit_513_symbol: Boolean;
          signal base_resize_req_514_symbol : Boolean;
          signal base_resize_ack_515_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_183_base_addr_resize_511_start <= ptr_deref_183_base_address_calculated_506_symbol; -- control passed to block
          Xentry_512_symbol  <= ptr_deref_183_base_addr_resize_511_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_addr_resize/$entry
          base_resize_req_514_symbol <= Xentry_512_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_addr_resize/base_resize_req
          ptr_deref_183_base_resize_req_0 <= base_resize_req_514_symbol; -- link to DP
          base_resize_ack_515_symbol <= ptr_deref_183_base_resize_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_addr_resize/base_resize_ack
          Xexit_513_symbol <= base_resize_ack_515_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_addr_resize/$exit
          ptr_deref_183_base_addr_resize_511_symbol <= Xexit_513_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_addr_resize
        ptr_deref_183_base_plus_offset_516: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_plus_offset 
          signal ptr_deref_183_base_plus_offset_516_start: Boolean;
          signal Xentry_517_symbol: Boolean;
          signal Xexit_518_symbol: Boolean;
          signal sum_rename_req_519_symbol : Boolean;
          signal sum_rename_ack_520_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_183_base_plus_offset_516_start <= ptr_deref_183_base_address_resized_510_symbol; -- control passed to block
          Xentry_517_symbol  <= ptr_deref_183_base_plus_offset_516_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_plus_offset/$entry
          sum_rename_req_519_symbol <= Xentry_517_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_plus_offset/sum_rename_req
          ptr_deref_183_root_address_inst_req_0 <= sum_rename_req_519_symbol; -- link to DP
          sum_rename_ack_520_symbol <= ptr_deref_183_root_address_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_plus_offset/sum_rename_ack
          Xexit_518_symbol <= sum_rename_ack_520_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_plus_offset/$exit
          ptr_deref_183_base_plus_offset_516_symbol <= Xexit_518_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_base_plus_offset
        ptr_deref_183_word_addrgen_521: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_addrgen 
          signal ptr_deref_183_word_addrgen_521_start: Boolean;
          signal Xentry_522_symbol: Boolean;
          signal Xexit_523_symbol: Boolean;
          signal root_rename_req_524_symbol : Boolean;
          signal root_rename_ack_525_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_183_word_addrgen_521_start <= ptr_deref_183_root_address_calculated_508_symbol; -- control passed to block
          Xentry_522_symbol  <= ptr_deref_183_word_addrgen_521_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_addrgen/$entry
          root_rename_req_524_symbol <= Xentry_522_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_addrgen/root_rename_req
          ptr_deref_183_addr_0_req_0 <= root_rename_req_524_symbol; -- link to DP
          root_rename_ack_525_symbol <= ptr_deref_183_addr_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_addrgen/root_rename_ack
          Xexit_523_symbol <= root_rename_ack_525_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_addrgen/$exit
          ptr_deref_183_word_addrgen_521_symbol <= Xexit_523_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_word_addrgen
        ptr_deref_183_request_526: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request 
          signal ptr_deref_183_request_526_start: Boolean;
          signal Xentry_527_symbol: Boolean;
          signal Xexit_528_symbol: Boolean;
          signal word_access_529_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_183_request_526_start <= ptr_deref_183_trigger_x_x504_symbol; -- control passed to block
          Xentry_527_symbol  <= ptr_deref_183_request_526_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/$entry
          word_access_529: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access 
            signal word_access_529_start: Boolean;
            signal Xentry_530_symbol: Boolean;
            signal Xexit_531_symbol: Boolean;
            signal word_access_0_532_symbol : Boolean;
            -- 
          begin -- 
            word_access_529_start <= Xentry_527_symbol; -- control passed to block
            Xentry_530_symbol  <= word_access_529_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/$entry
            word_access_0_532: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/word_access_0 
              signal word_access_0_532_start: Boolean;
              signal Xentry_533_symbol: Boolean;
              signal Xexit_534_symbol: Boolean;
              signal rr_535_symbol : Boolean;
              signal ra_536_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_532_start <= Xentry_530_symbol; -- control passed to block
              Xentry_533_symbol  <= word_access_0_532_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/word_access_0/$entry
              rr_535_symbol <= Xentry_533_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/word_access_0/rr
              ptr_deref_183_load_0_req_0 <= rr_535_symbol; -- link to DP
              ra_536_symbol <= ptr_deref_183_load_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/word_access_0/ra
              Xexit_534_symbol <= ra_536_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/word_access_0/$exit
              word_access_0_532_symbol <= Xexit_534_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/word_access_0
            Xexit_531_symbol <= word_access_0_532_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access/$exit
            word_access_529_symbol <= Xexit_531_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/word_access
          Xexit_528_symbol <= word_access_529_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request/$exit
          ptr_deref_183_request_526_symbol <= Xexit_528_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_request
        ptr_deref_183_complete_537: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete 
          signal ptr_deref_183_complete_537_start: Boolean;
          signal Xentry_538_symbol: Boolean;
          signal Xexit_539_symbol: Boolean;
          signal word_access_540_symbol : Boolean;
          signal merge_req_548_symbol : Boolean;
          signal merge_ack_549_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_183_complete_537_start <= ptr_deref_183_active_x_x505_symbol; -- control passed to block
          Xentry_538_symbol  <= ptr_deref_183_complete_537_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/$entry
          word_access_540: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access 
            signal word_access_540_start: Boolean;
            signal Xentry_541_symbol: Boolean;
            signal Xexit_542_symbol: Boolean;
            signal word_access_0_543_symbol : Boolean;
            -- 
          begin -- 
            word_access_540_start <= Xentry_538_symbol; -- control passed to block
            Xentry_541_symbol  <= word_access_540_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/$entry
            word_access_0_543: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/word_access_0 
              signal word_access_0_543_start: Boolean;
              signal Xentry_544_symbol: Boolean;
              signal Xexit_545_symbol: Boolean;
              signal cr_546_symbol : Boolean;
              signal ca_547_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_543_start <= Xentry_541_symbol; -- control passed to block
              Xentry_544_symbol  <= word_access_0_543_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/word_access_0/$entry
              cr_546_symbol <= Xentry_544_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/word_access_0/cr
              ptr_deref_183_load_0_req_1 <= cr_546_symbol; -- link to DP
              ca_547_symbol <= ptr_deref_183_load_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/word_access_0/ca
              Xexit_545_symbol <= ca_547_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/word_access_0/$exit
              word_access_0_543_symbol <= Xexit_545_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/word_access_0
            Xexit_542_symbol <= word_access_0_543_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access/$exit
            word_access_540_symbol <= Xexit_542_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/word_access
          merge_req_548_symbol <= word_access_540_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/merge_req
          ptr_deref_183_gather_scatter_req_0 <= merge_req_548_symbol; -- link to DP
          merge_ack_549_symbol <= ptr_deref_183_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/merge_ack
          Xexit_539_symbol <= merge_ack_549_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete/$exit
          ptr_deref_183_complete_537_symbol <= Xexit_539_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/ptr_deref_183_complete
        assign_stmt_187_active_x_x550_symbol <= simple_obj_ref_186_complete_552_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/assign_stmt_187_active_
        assign_stmt_187_completed_x_x551_symbol <= simple_obj_ref_185_complete_570_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/assign_stmt_187_completed_
        simple_obj_ref_186_complete_552_symbol <= assign_stmt_184_completed_x_x503_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_186_complete
        simple_obj_ref_185_trigger_x_x553_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_trigger_ 
          signal simple_obj_ref_185_trigger_x_x553_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_185_trigger_x_x553_predecessors(0) <= simple_obj_ref_185_word_address_calculated_556_symbol;
          simple_obj_ref_185_trigger_x_x553_predecessors(1) <= assign_stmt_187_active_x_x550_symbol;
          simple_obj_ref_185_trigger_x_x553_join: join -- 
            port map( -- 
              preds => simple_obj_ref_185_trigger_x_x553_predecessors,
              symbol_out => simple_obj_ref_185_trigger_x_x553_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_trigger_
        simple_obj_ref_185_active_x_x554_symbol <= simple_obj_ref_185_request_557_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_active_
        simple_obj_ref_185_root_address_calculated_555_symbol <= Xentry_478_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_root_address_calculated
        simple_obj_ref_185_word_address_calculated_556_symbol <= simple_obj_ref_185_root_address_calculated_555_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_word_address_calculated
        simple_obj_ref_185_request_557: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request 
          signal simple_obj_ref_185_request_557_start: Boolean;
          signal Xentry_558_symbol: Boolean;
          signal Xexit_559_symbol: Boolean;
          signal split_req_560_symbol : Boolean;
          signal split_ack_561_symbol : Boolean;
          signal word_access_562_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_185_request_557_start <= simple_obj_ref_185_trigger_x_x553_symbol; -- control passed to block
          Xentry_558_symbol  <= simple_obj_ref_185_request_557_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/$entry
          split_req_560_symbol <= Xentry_558_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/split_req
          simple_obj_ref_185_gather_scatter_req_0 <= split_req_560_symbol; -- link to DP
          split_ack_561_symbol <= simple_obj_ref_185_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/split_ack
          word_access_562: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access 
            signal word_access_562_start: Boolean;
            signal Xentry_563_symbol: Boolean;
            signal Xexit_564_symbol: Boolean;
            signal word_access_0_565_symbol : Boolean;
            -- 
          begin -- 
            word_access_562_start <= split_ack_561_symbol; -- control passed to block
            Xentry_563_symbol  <= word_access_562_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/$entry
            word_access_0_565: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/word_access_0 
              signal word_access_0_565_start: Boolean;
              signal Xentry_566_symbol: Boolean;
              signal Xexit_567_symbol: Boolean;
              signal rr_568_symbol : Boolean;
              signal ra_569_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_565_start <= Xentry_563_symbol; -- control passed to block
              Xentry_566_symbol  <= word_access_0_565_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/word_access_0/$entry
              rr_568_symbol <= Xentry_566_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/word_access_0/rr
              simple_obj_ref_185_store_0_req_0 <= rr_568_symbol; -- link to DP
              ra_569_symbol <= simple_obj_ref_185_store_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/word_access_0/ra
              Xexit_567_symbol <= ra_569_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/word_access_0/$exit
              word_access_0_565_symbol <= Xexit_567_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/word_access_0
            Xexit_564_symbol <= word_access_0_565_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access/$exit
            word_access_562_symbol <= Xexit_564_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/word_access
          Xexit_559_symbol <= word_access_562_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request/$exit
          simple_obj_ref_185_request_557_symbol <= Xexit_559_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_request
        simple_obj_ref_185_complete_570: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete 
          signal simple_obj_ref_185_complete_570_start: Boolean;
          signal Xentry_571_symbol: Boolean;
          signal Xexit_572_symbol: Boolean;
          signal word_access_573_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_185_complete_570_start <= simple_obj_ref_185_active_x_x554_symbol; -- control passed to block
          Xentry_571_symbol  <= simple_obj_ref_185_complete_570_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/$entry
          word_access_573: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access 
            signal word_access_573_start: Boolean;
            signal Xentry_574_symbol: Boolean;
            signal Xexit_575_symbol: Boolean;
            signal word_access_0_576_symbol : Boolean;
            -- 
          begin -- 
            word_access_573_start <= Xentry_571_symbol; -- control passed to block
            Xentry_574_symbol  <= word_access_573_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/$entry
            word_access_0_576: Block -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/word_access_0 
              signal word_access_0_576_start: Boolean;
              signal Xentry_577_symbol: Boolean;
              signal Xexit_578_symbol: Boolean;
              signal cr_579_symbol : Boolean;
              signal ca_580_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_576_start <= Xentry_574_symbol; -- control passed to block
              Xentry_577_symbol  <= word_access_0_576_start; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/word_access_0/$entry
              cr_579_symbol <= Xentry_577_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/word_access_0/cr
              simple_obj_ref_185_store_0_req_1 <= cr_579_symbol; -- link to DP
              ca_580_symbol <= simple_obj_ref_185_store_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/word_access_0/ca
              Xexit_578_symbol <= ca_580_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/word_access_0/$exit
              word_access_0_576_symbol <= Xexit_578_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/word_access_0
            Xexit_575_symbol <= word_access_0_576_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access/$exit
            word_access_573_symbol <= Xexit_575_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/word_access
          Xexit_572_symbol <= word_access_573_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete/$exit
          simple_obj_ref_185_complete_570_symbol <= Xexit_572_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/simple_obj_ref_185_complete
        Xexit_479_symbol <= assign_stmt_187_completed_x_x551_symbol; -- transition branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187/$exit
        assign_stmt_180_to_assign_stmt_187_477_symbol <= Xexit_479_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_180_to_assign_stmt_187
      assign_stmt_193_to_assign_stmt_198_581: Block -- branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198 
        signal assign_stmt_193_to_assign_stmt_198_581_start: Boolean;
        signal Xentry_582_symbol: Boolean;
        signal Xexit_583_symbol: Boolean;
        signal assign_stmt_193_active_x_x584_symbol : Boolean;
        signal assign_stmt_193_completed_x_x585_symbol : Boolean;
        signal type_cast_192_active_x_x586_symbol : Boolean;
        signal type_cast_192_trigger_x_x587_symbol : Boolean;
        signal simple_obj_ref_191_complete_588_symbol : Boolean;
        signal type_cast_192_complete_589_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_193_to_assign_stmt_198_581_start <= assign_stmt_193_to_assign_stmt_198_x_xentry_x_xx_x244_symbol; -- control passed to block
        Xentry_582_symbol  <= assign_stmt_193_to_assign_stmt_198_581_start; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/$entry
        assign_stmt_193_active_x_x584_symbol <= type_cast_192_complete_589_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/assign_stmt_193_active_
        assign_stmt_193_completed_x_x585_symbol <= assign_stmt_193_active_x_x584_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/assign_stmt_193_completed_
        type_cast_192_active_x_x586_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_active_ 
          signal type_cast_192_active_x_x586_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_192_active_x_x586_predecessors(0) <= type_cast_192_trigger_x_x587_symbol;
          type_cast_192_active_x_x586_predecessors(1) <= simple_obj_ref_191_complete_588_symbol;
          type_cast_192_active_x_x586_join: join -- 
            port map( -- 
              preds => type_cast_192_active_x_x586_predecessors,
              symbol_out => type_cast_192_active_x_x586_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_active_
        type_cast_192_trigger_x_x587_symbol <= Xentry_582_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_trigger_
        simple_obj_ref_191_complete_588_symbol <= Xentry_582_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/simple_obj_ref_191_complete
        type_cast_192_complete_589: Block -- branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_complete 
          signal type_cast_192_complete_589_start: Boolean;
          signal Xentry_590_symbol: Boolean;
          signal Xexit_591_symbol: Boolean;
          signal req_592_symbol : Boolean;
          signal ack_593_symbol : Boolean;
          -- 
        begin -- 
          type_cast_192_complete_589_start <= type_cast_192_active_x_x586_symbol; -- control passed to block
          Xentry_590_symbol  <= type_cast_192_complete_589_start; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_complete/$entry
          req_592_symbol <= Xentry_590_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_complete/req
          type_cast_192_inst_req_0 <= req_592_symbol; -- link to DP
          ack_593_symbol <= type_cast_192_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_complete/ack
          Xexit_591_symbol <= ack_593_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_complete/$exit
          type_cast_192_complete_589_symbol <= Xexit_591_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/type_cast_192_complete
        Xexit_583_symbol <= assign_stmt_193_completed_x_x585_symbol; -- transition branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198/$exit
        assign_stmt_193_to_assign_stmt_198_581_symbol <= Xexit_583_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_193_to_assign_stmt_198
      assign_stmt_202_594: Block -- branch_block_stmt_104/assign_stmt_202 
        signal assign_stmt_202_594_start: Boolean;
        signal Xentry_595_symbol: Boolean;
        signal Xexit_596_symbol: Boolean;
        signal assign_stmt_202_active_x_x597_symbol : Boolean;
        signal assign_stmt_202_completed_x_x598_symbol : Boolean;
        signal type_cast_201_active_x_x599_symbol : Boolean;
        signal type_cast_201_trigger_x_x600_symbol : Boolean;
        signal simple_obj_ref_200_complete_601_symbol : Boolean;
        signal type_cast_201_complete_602_symbol : Boolean;
        signal simple_obj_ref_199_trigger_x_x607_symbol : Boolean;
        signal simple_obj_ref_199_complete_608_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_202_594_start <= assign_stmt_202_x_xentry_x_xx_x246_symbol; -- control passed to block
        Xentry_595_symbol  <= assign_stmt_202_594_start; -- transition branch_block_stmt_104/assign_stmt_202/$entry
        assign_stmt_202_active_x_x597_symbol <= type_cast_201_complete_602_symbol; -- transition branch_block_stmt_104/assign_stmt_202/assign_stmt_202_active_
        assign_stmt_202_completed_x_x598_symbol <= simple_obj_ref_199_complete_608_symbol; -- transition branch_block_stmt_104/assign_stmt_202/assign_stmt_202_completed_
        type_cast_201_active_x_x599_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_202/type_cast_201_active_ 
          signal type_cast_201_active_x_x599_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_201_active_x_x599_predecessors(0) <= type_cast_201_trigger_x_x600_symbol;
          type_cast_201_active_x_x599_predecessors(1) <= simple_obj_ref_200_complete_601_symbol;
          type_cast_201_active_x_x599_join: join -- 
            port map( -- 
              preds => type_cast_201_active_x_x599_predecessors,
              symbol_out => type_cast_201_active_x_x599_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_202/type_cast_201_active_
        type_cast_201_trigger_x_x600_symbol <= Xentry_595_symbol; -- transition branch_block_stmt_104/assign_stmt_202/type_cast_201_trigger_
        simple_obj_ref_200_complete_601_symbol <= Xentry_595_symbol; -- transition branch_block_stmt_104/assign_stmt_202/simple_obj_ref_200_complete
        type_cast_201_complete_602: Block -- branch_block_stmt_104/assign_stmt_202/type_cast_201_complete 
          signal type_cast_201_complete_602_start: Boolean;
          signal Xentry_603_symbol: Boolean;
          signal Xexit_604_symbol: Boolean;
          signal req_605_symbol : Boolean;
          signal ack_606_symbol : Boolean;
          -- 
        begin -- 
          type_cast_201_complete_602_start <= type_cast_201_active_x_x599_symbol; -- control passed to block
          Xentry_603_symbol  <= type_cast_201_complete_602_start; -- transition branch_block_stmt_104/assign_stmt_202/type_cast_201_complete/$entry
          req_605_symbol <= Xentry_603_symbol; -- transition branch_block_stmt_104/assign_stmt_202/type_cast_201_complete/req
          type_cast_201_inst_req_0 <= req_605_symbol; -- link to DP
          ack_606_symbol <= type_cast_201_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_202/type_cast_201_complete/ack
          Xexit_604_symbol <= ack_606_symbol; -- transition branch_block_stmt_104/assign_stmt_202/type_cast_201_complete/$exit
          type_cast_201_complete_602_symbol <= Xexit_604_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_202/type_cast_201_complete
        simple_obj_ref_199_trigger_x_x607_symbol <= assign_stmt_202_active_x_x597_symbol; -- transition branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_trigger_
        simple_obj_ref_199_complete_608: Block -- branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_complete 
          signal simple_obj_ref_199_complete_608_start: Boolean;
          signal Xentry_609_symbol: Boolean;
          signal Xexit_610_symbol: Boolean;
          signal pipe_wreq_611_symbol : Boolean;
          signal pipe_wack_612_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_199_complete_608_start <= simple_obj_ref_199_trigger_x_x607_symbol; -- control passed to block
          Xentry_609_symbol  <= simple_obj_ref_199_complete_608_start; -- transition branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_complete/$entry
          pipe_wreq_611_symbol <= Xentry_609_symbol; -- transition branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_complete/pipe_wreq
          simple_obj_ref_199_inst_req_0 <= pipe_wreq_611_symbol; -- link to DP
          pipe_wack_612_symbol <= simple_obj_ref_199_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_complete/pipe_wack
          Xexit_610_symbol <= pipe_wack_612_symbol; -- transition branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_complete/$exit
          simple_obj_ref_199_complete_608_symbol <= Xexit_610_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_202/simple_obj_ref_199_complete
        Xexit_596_symbol <= assign_stmt_202_completed_x_x598_symbol; -- transition branch_block_stmt_104/assign_stmt_202/$exit
        assign_stmt_202_594_symbol <= Xexit_596_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_202
      assign_stmt_209_613: Block -- branch_block_stmt_104/assign_stmt_209 
        signal assign_stmt_209_613_start: Boolean;
        signal Xentry_614_symbol: Boolean;
        signal Xexit_615_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_209_613_start <= assign_stmt_209_x_xentry_x_xx_x250_symbol; -- control passed to block
        Xentry_614_symbol  <= assign_stmt_209_613_start; -- transition branch_block_stmt_104/assign_stmt_209/$entry
        Xexit_615_symbol <= Xentry_614_symbol; -- transition branch_block_stmt_104/assign_stmt_209/$exit
        assign_stmt_209_613_symbol <= Xexit_615_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_209
      assign_stmt_213_616: Block -- branch_block_stmt_104/assign_stmt_213 
        signal assign_stmt_213_616_start: Boolean;
        signal Xentry_617_symbol: Boolean;
        signal Xexit_618_symbol: Boolean;
        signal assign_stmt_213_active_x_x619_symbol : Boolean;
        signal assign_stmt_213_completed_x_x620_symbol : Boolean;
        signal type_cast_212_active_x_x621_symbol : Boolean;
        signal type_cast_212_trigger_x_x622_symbol : Boolean;
        signal simple_obj_ref_211_trigger_x_x623_symbol : Boolean;
        signal simple_obj_ref_211_complete_624_symbol : Boolean;
        signal type_cast_212_complete_629_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_213_616_start <= assign_stmt_213_x_xentry_x_xx_x252_symbol; -- control passed to block
        Xentry_617_symbol  <= assign_stmt_213_616_start; -- transition branch_block_stmt_104/assign_stmt_213/$entry
        assign_stmt_213_active_x_x619_symbol <= type_cast_212_complete_629_symbol; -- transition branch_block_stmt_104/assign_stmt_213/assign_stmt_213_active_
        assign_stmt_213_completed_x_x620_symbol <= assign_stmt_213_active_x_x619_symbol; -- transition branch_block_stmt_104/assign_stmt_213/assign_stmt_213_completed_
        type_cast_212_active_x_x621_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_213/type_cast_212_active_ 
          signal type_cast_212_active_x_x621_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_212_active_x_x621_predecessors(0) <= type_cast_212_trigger_x_x622_symbol;
          type_cast_212_active_x_x621_predecessors(1) <= simple_obj_ref_211_complete_624_symbol;
          type_cast_212_active_x_x621_join: join -- 
            port map( -- 
              preds => type_cast_212_active_x_x621_predecessors,
              symbol_out => type_cast_212_active_x_x621_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_213/type_cast_212_active_
        type_cast_212_trigger_x_x622_symbol <= Xentry_617_symbol; -- transition branch_block_stmt_104/assign_stmt_213/type_cast_212_trigger_
        simple_obj_ref_211_trigger_x_x623_symbol <= Xentry_617_symbol; -- transition branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_trigger_
        simple_obj_ref_211_complete_624: Block -- branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_complete 
          signal simple_obj_ref_211_complete_624_start: Boolean;
          signal Xentry_625_symbol: Boolean;
          signal Xexit_626_symbol: Boolean;
          signal req_627_symbol : Boolean;
          signal ack_628_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_211_complete_624_start <= simple_obj_ref_211_trigger_x_x623_symbol; -- control passed to block
          Xentry_625_symbol  <= simple_obj_ref_211_complete_624_start; -- transition branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_complete/$entry
          req_627_symbol <= Xentry_625_symbol; -- transition branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_complete/req
          simple_obj_ref_211_inst_req_0 <= req_627_symbol; -- link to DP
          ack_628_symbol <= simple_obj_ref_211_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_complete/ack
          Xexit_626_symbol <= ack_628_symbol; -- transition branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_complete/$exit
          simple_obj_ref_211_complete_624_symbol <= Xexit_626_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_213/simple_obj_ref_211_complete
        type_cast_212_complete_629: Block -- branch_block_stmt_104/assign_stmt_213/type_cast_212_complete 
          signal type_cast_212_complete_629_start: Boolean;
          signal Xentry_630_symbol: Boolean;
          signal Xexit_631_symbol: Boolean;
          signal req_632_symbol : Boolean;
          signal ack_633_symbol : Boolean;
          -- 
        begin -- 
          type_cast_212_complete_629_start <= type_cast_212_active_x_x621_symbol; -- control passed to block
          Xentry_630_symbol  <= type_cast_212_complete_629_start; -- transition branch_block_stmt_104/assign_stmt_213/type_cast_212_complete/$entry
          req_632_symbol <= Xentry_630_symbol; -- transition branch_block_stmt_104/assign_stmt_213/type_cast_212_complete/req
          type_cast_212_inst_req_0 <= req_632_symbol; -- link to DP
          ack_633_symbol <= type_cast_212_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_213/type_cast_212_complete/ack
          Xexit_631_symbol <= ack_633_symbol; -- transition branch_block_stmt_104/assign_stmt_213/type_cast_212_complete/$exit
          type_cast_212_complete_629_symbol <= Xexit_631_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_213/type_cast_212_complete
        Xexit_618_symbol <= assign_stmt_213_completed_x_x620_symbol; -- transition branch_block_stmt_104/assign_stmt_213/$exit
        assign_stmt_213_616_symbol <= Xexit_618_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_213
      assign_stmt_217_to_assign_stmt_232_634: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232 
        signal assign_stmt_217_to_assign_stmt_232_634_start: Boolean;
        signal Xentry_635_symbol: Boolean;
        signal Xexit_636_symbol: Boolean;
        signal assign_stmt_217_active_x_x637_symbol : Boolean;
        signal assign_stmt_217_completed_x_x638_symbol : Boolean;
        signal type_cast_216_active_x_x639_symbol : Boolean;
        signal type_cast_216_trigger_x_x640_symbol : Boolean;
        signal simple_obj_ref_215_complete_641_symbol : Boolean;
        signal type_cast_216_complete_642_symbol : Boolean;
        signal assign_stmt_220_active_x_x647_symbol : Boolean;
        signal assign_stmt_220_completed_x_x648_symbol : Boolean;
        signal simple_obj_ref_219_trigger_x_x649_symbol : Boolean;
        signal simple_obj_ref_219_active_x_x650_symbol : Boolean;
        signal simple_obj_ref_219_root_address_calculated_651_symbol : Boolean;
        signal simple_obj_ref_219_word_address_calculated_652_symbol : Boolean;
        signal simple_obj_ref_219_request_653_symbol : Boolean;
        signal simple_obj_ref_219_complete_664_symbol : Boolean;
        signal assign_stmt_225_active_x_x677_symbol : Boolean;
        signal assign_stmt_225_completed_x_x678_symbol : Boolean;
        signal type_cast_224_active_x_x679_symbol : Boolean;
        signal type_cast_224_trigger_x_x680_symbol : Boolean;
        signal simple_obj_ref_223_complete_681_symbol : Boolean;
        signal type_cast_224_complete_682_symbol : Boolean;
        signal assign_stmt_229_active_x_x687_symbol : Boolean;
        signal assign_stmt_229_completed_x_x688_symbol : Boolean;
        signal simple_obj_ref_228_complete_689_symbol : Boolean;
        signal ptr_deref_227_trigger_x_x690_symbol : Boolean;
        signal ptr_deref_227_active_x_x691_symbol : Boolean;
        signal ptr_deref_227_base_address_calculated_692_symbol : Boolean;
        signal simple_obj_ref_226_complete_693_symbol : Boolean;
        signal ptr_deref_227_root_address_calculated_694_symbol : Boolean;
        signal ptr_deref_227_word_address_calculated_695_symbol : Boolean;
        signal ptr_deref_227_base_address_resized_696_symbol : Boolean;
        signal ptr_deref_227_base_addr_resize_697_symbol : Boolean;
        signal ptr_deref_227_base_plus_offset_702_symbol : Boolean;
        signal ptr_deref_227_word_addrgen_707_symbol : Boolean;
        signal ptr_deref_227_request_712_symbol : Boolean;
        signal ptr_deref_227_complete_725_symbol : Boolean;
        signal assign_stmt_232_active_x_x736_symbol : Boolean;
        signal assign_stmt_232_completed_x_x737_symbol : Boolean;
        signal simple_obj_ref_231_complete_738_symbol : Boolean;
        signal simple_obj_ref_230_trigger_x_x739_symbol : Boolean;
        signal simple_obj_ref_230_active_x_x740_symbol : Boolean;
        signal simple_obj_ref_230_root_address_calculated_741_symbol : Boolean;
        signal simple_obj_ref_230_word_address_calculated_742_symbol : Boolean;
        signal simple_obj_ref_230_request_743_symbol : Boolean;
        signal simple_obj_ref_230_complete_756_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_217_to_assign_stmt_232_634_start <= assign_stmt_217_to_assign_stmt_232_x_xentry_x_xx_x254_symbol; -- control passed to block
        Xentry_635_symbol  <= assign_stmt_217_to_assign_stmt_232_634_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/$entry
        assign_stmt_217_active_x_x637_symbol <= type_cast_216_complete_642_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_217_active_
        assign_stmt_217_completed_x_x638_symbol <= assign_stmt_217_active_x_x637_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_217_completed_
        type_cast_216_active_x_x639_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_active_ 
          signal type_cast_216_active_x_x639_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_216_active_x_x639_predecessors(0) <= type_cast_216_trigger_x_x640_symbol;
          type_cast_216_active_x_x639_predecessors(1) <= simple_obj_ref_215_complete_641_symbol;
          type_cast_216_active_x_x639_join: join -- 
            port map( -- 
              preds => type_cast_216_active_x_x639_predecessors,
              symbol_out => type_cast_216_active_x_x639_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_active_
        type_cast_216_trigger_x_x640_symbol <= Xentry_635_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_trigger_
        simple_obj_ref_215_complete_641_symbol <= Xentry_635_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_215_complete
        type_cast_216_complete_642: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_complete 
          signal type_cast_216_complete_642_start: Boolean;
          signal Xentry_643_symbol: Boolean;
          signal Xexit_644_symbol: Boolean;
          signal req_645_symbol : Boolean;
          signal ack_646_symbol : Boolean;
          -- 
        begin -- 
          type_cast_216_complete_642_start <= type_cast_216_active_x_x639_symbol; -- control passed to block
          Xentry_643_symbol  <= type_cast_216_complete_642_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_complete/$entry
          req_645_symbol <= Xentry_643_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_complete/req
          type_cast_216_inst_req_0 <= req_645_symbol; -- link to DP
          ack_646_symbol <= type_cast_216_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_complete/ack
          Xexit_644_symbol <= ack_646_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_complete/$exit
          type_cast_216_complete_642_symbol <= Xexit_644_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_216_complete
        assign_stmt_220_active_x_x647_symbol <= simple_obj_ref_219_complete_664_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_220_active_
        assign_stmt_220_completed_x_x648_symbol <= assign_stmt_220_active_x_x647_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_220_completed_
        simple_obj_ref_219_trigger_x_x649_symbol <= simple_obj_ref_219_word_address_calculated_652_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_trigger_
        simple_obj_ref_219_active_x_x650_symbol <= simple_obj_ref_219_request_653_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_active_
        simple_obj_ref_219_root_address_calculated_651_symbol <= Xentry_635_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_root_address_calculated
        simple_obj_ref_219_word_address_calculated_652_symbol <= simple_obj_ref_219_root_address_calculated_651_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_word_address_calculated
        simple_obj_ref_219_request_653: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request 
          signal simple_obj_ref_219_request_653_start: Boolean;
          signal Xentry_654_symbol: Boolean;
          signal Xexit_655_symbol: Boolean;
          signal word_access_656_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_219_request_653_start <= simple_obj_ref_219_trigger_x_x649_symbol; -- control passed to block
          Xentry_654_symbol  <= simple_obj_ref_219_request_653_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/$entry
          word_access_656: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access 
            signal word_access_656_start: Boolean;
            signal Xentry_657_symbol: Boolean;
            signal Xexit_658_symbol: Boolean;
            signal word_access_0_659_symbol : Boolean;
            -- 
          begin -- 
            word_access_656_start <= Xentry_654_symbol; -- control passed to block
            Xentry_657_symbol  <= word_access_656_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/$entry
            word_access_0_659: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/word_access_0 
              signal word_access_0_659_start: Boolean;
              signal Xentry_660_symbol: Boolean;
              signal Xexit_661_symbol: Boolean;
              signal rr_662_symbol : Boolean;
              signal ra_663_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_659_start <= Xentry_657_symbol; -- control passed to block
              Xentry_660_symbol  <= word_access_0_659_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/word_access_0/$entry
              rr_662_symbol <= Xentry_660_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/word_access_0/rr
              simple_obj_ref_219_load_0_req_0 <= rr_662_symbol; -- link to DP
              ra_663_symbol <= simple_obj_ref_219_load_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/word_access_0/ra
              Xexit_661_symbol <= ra_663_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/word_access_0/$exit
              word_access_0_659_symbol <= Xexit_661_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/word_access_0
            Xexit_658_symbol <= word_access_0_659_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access/$exit
            word_access_656_symbol <= Xexit_658_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/word_access
          Xexit_655_symbol <= word_access_656_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request/$exit
          simple_obj_ref_219_request_653_symbol <= Xexit_655_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_request
        simple_obj_ref_219_complete_664: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete 
          signal simple_obj_ref_219_complete_664_start: Boolean;
          signal Xentry_665_symbol: Boolean;
          signal Xexit_666_symbol: Boolean;
          signal word_access_667_symbol : Boolean;
          signal merge_req_675_symbol : Boolean;
          signal merge_ack_676_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_219_complete_664_start <= simple_obj_ref_219_active_x_x650_symbol; -- control passed to block
          Xentry_665_symbol  <= simple_obj_ref_219_complete_664_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/$entry
          word_access_667: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access 
            signal word_access_667_start: Boolean;
            signal Xentry_668_symbol: Boolean;
            signal Xexit_669_symbol: Boolean;
            signal word_access_0_670_symbol : Boolean;
            -- 
          begin -- 
            word_access_667_start <= Xentry_665_symbol; -- control passed to block
            Xentry_668_symbol  <= word_access_667_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/$entry
            word_access_0_670: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/word_access_0 
              signal word_access_0_670_start: Boolean;
              signal Xentry_671_symbol: Boolean;
              signal Xexit_672_symbol: Boolean;
              signal cr_673_symbol : Boolean;
              signal ca_674_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_670_start <= Xentry_668_symbol; -- control passed to block
              Xentry_671_symbol  <= word_access_0_670_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/word_access_0/$entry
              cr_673_symbol <= Xentry_671_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/word_access_0/cr
              simple_obj_ref_219_load_0_req_1 <= cr_673_symbol; -- link to DP
              ca_674_symbol <= simple_obj_ref_219_load_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/word_access_0/ca
              Xexit_672_symbol <= ca_674_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/word_access_0/$exit
              word_access_0_670_symbol <= Xexit_672_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/word_access_0
            Xexit_669_symbol <= word_access_0_670_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access/$exit
            word_access_667_symbol <= Xexit_669_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/word_access
          merge_req_675_symbol <= word_access_667_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/merge_req
          simple_obj_ref_219_gather_scatter_req_0 <= merge_req_675_symbol; -- link to DP
          merge_ack_676_symbol <= simple_obj_ref_219_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/merge_ack
          Xexit_666_symbol <= merge_ack_676_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete/$exit
          simple_obj_ref_219_complete_664_symbol <= Xexit_666_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_219_complete
        assign_stmt_225_active_x_x677_symbol <= type_cast_224_complete_682_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_225_active_
        assign_stmt_225_completed_x_x678_symbol <= assign_stmt_225_active_x_x677_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_225_completed_
        type_cast_224_active_x_x679_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_active_ 
          signal type_cast_224_active_x_x679_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_224_active_x_x679_predecessors(0) <= type_cast_224_trigger_x_x680_symbol;
          type_cast_224_active_x_x679_predecessors(1) <= simple_obj_ref_223_complete_681_symbol;
          type_cast_224_active_x_x679_join: join -- 
            port map( -- 
              preds => type_cast_224_active_x_x679_predecessors,
              symbol_out => type_cast_224_active_x_x679_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_active_
        type_cast_224_trigger_x_x680_symbol <= Xentry_635_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_trigger_
        simple_obj_ref_223_complete_681_symbol <= Xentry_635_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_223_complete
        type_cast_224_complete_682: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_complete 
          signal type_cast_224_complete_682_start: Boolean;
          signal Xentry_683_symbol: Boolean;
          signal Xexit_684_symbol: Boolean;
          signal req_685_symbol : Boolean;
          signal ack_686_symbol : Boolean;
          -- 
        begin -- 
          type_cast_224_complete_682_start <= type_cast_224_active_x_x679_symbol; -- control passed to block
          Xentry_683_symbol  <= type_cast_224_complete_682_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_complete/$entry
          req_685_symbol <= Xentry_683_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_complete/req
          type_cast_224_inst_req_0 <= req_685_symbol; -- link to DP
          ack_686_symbol <= type_cast_224_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_complete/ack
          Xexit_684_symbol <= ack_686_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_complete/$exit
          type_cast_224_complete_682_symbol <= Xexit_684_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/type_cast_224_complete
        assign_stmt_229_active_x_x687_symbol <= simple_obj_ref_228_complete_689_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_229_active_
        assign_stmt_229_completed_x_x688_symbol <= ptr_deref_227_complete_725_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_229_completed_
        simple_obj_ref_228_complete_689_symbol <= assign_stmt_220_completed_x_x648_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_228_complete
        ptr_deref_227_trigger_x_x690_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_trigger_ 
          signal ptr_deref_227_trigger_x_x690_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_227_trigger_x_x690_predecessors(0) <= ptr_deref_227_word_address_calculated_695_symbol;
          ptr_deref_227_trigger_x_x690_predecessors(1) <= ptr_deref_227_base_address_calculated_692_symbol;
          ptr_deref_227_trigger_x_x690_predecessors(2) <= assign_stmt_229_active_x_x687_symbol;
          ptr_deref_227_trigger_x_x690_join: join -- 
            port map( -- 
              preds => ptr_deref_227_trigger_x_x690_predecessors,
              symbol_out => ptr_deref_227_trigger_x_x690_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_trigger_
        ptr_deref_227_active_x_x691_symbol <= ptr_deref_227_request_712_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_active_
        ptr_deref_227_base_address_calculated_692_symbol <= simple_obj_ref_226_complete_693_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_address_calculated
        simple_obj_ref_226_complete_693_symbol <= assign_stmt_225_completed_x_x678_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_226_complete
        ptr_deref_227_root_address_calculated_694_symbol <= ptr_deref_227_base_plus_offset_702_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_root_address_calculated
        ptr_deref_227_word_address_calculated_695_symbol <= ptr_deref_227_word_addrgen_707_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_address_calculated
        ptr_deref_227_base_address_resized_696_symbol <= ptr_deref_227_base_addr_resize_697_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_address_resized
        ptr_deref_227_base_addr_resize_697: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_addr_resize 
          signal ptr_deref_227_base_addr_resize_697_start: Boolean;
          signal Xentry_698_symbol: Boolean;
          signal Xexit_699_symbol: Boolean;
          signal base_resize_req_700_symbol : Boolean;
          signal base_resize_ack_701_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_227_base_addr_resize_697_start <= ptr_deref_227_base_address_calculated_692_symbol; -- control passed to block
          Xentry_698_symbol  <= ptr_deref_227_base_addr_resize_697_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_addr_resize/$entry
          base_resize_req_700_symbol <= Xentry_698_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_addr_resize/base_resize_req
          ptr_deref_227_base_resize_req_0 <= base_resize_req_700_symbol; -- link to DP
          base_resize_ack_701_symbol <= ptr_deref_227_base_resize_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_addr_resize/base_resize_ack
          Xexit_699_symbol <= base_resize_ack_701_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_addr_resize/$exit
          ptr_deref_227_base_addr_resize_697_symbol <= Xexit_699_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_addr_resize
        ptr_deref_227_base_plus_offset_702: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_plus_offset 
          signal ptr_deref_227_base_plus_offset_702_start: Boolean;
          signal Xentry_703_symbol: Boolean;
          signal Xexit_704_symbol: Boolean;
          signal sum_rename_req_705_symbol : Boolean;
          signal sum_rename_ack_706_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_227_base_plus_offset_702_start <= ptr_deref_227_base_address_resized_696_symbol; -- control passed to block
          Xentry_703_symbol  <= ptr_deref_227_base_plus_offset_702_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_plus_offset/$entry
          sum_rename_req_705_symbol <= Xentry_703_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_plus_offset/sum_rename_req
          ptr_deref_227_root_address_inst_req_0 <= sum_rename_req_705_symbol; -- link to DP
          sum_rename_ack_706_symbol <= ptr_deref_227_root_address_inst_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_plus_offset/sum_rename_ack
          Xexit_704_symbol <= sum_rename_ack_706_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_plus_offset/$exit
          ptr_deref_227_base_plus_offset_702_symbol <= Xexit_704_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_base_plus_offset
        ptr_deref_227_word_addrgen_707: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_addrgen 
          signal ptr_deref_227_word_addrgen_707_start: Boolean;
          signal Xentry_708_symbol: Boolean;
          signal Xexit_709_symbol: Boolean;
          signal root_rename_req_710_symbol : Boolean;
          signal root_rename_ack_711_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_227_word_addrgen_707_start <= ptr_deref_227_root_address_calculated_694_symbol; -- control passed to block
          Xentry_708_symbol  <= ptr_deref_227_word_addrgen_707_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_addrgen/$entry
          root_rename_req_710_symbol <= Xentry_708_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_addrgen/root_rename_req
          ptr_deref_227_addr_0_req_0 <= root_rename_req_710_symbol; -- link to DP
          root_rename_ack_711_symbol <= ptr_deref_227_addr_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_addrgen/root_rename_ack
          Xexit_709_symbol <= root_rename_ack_711_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_addrgen/$exit
          ptr_deref_227_word_addrgen_707_symbol <= Xexit_709_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_word_addrgen
        ptr_deref_227_request_712: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request 
          signal ptr_deref_227_request_712_start: Boolean;
          signal Xentry_713_symbol: Boolean;
          signal Xexit_714_symbol: Boolean;
          signal split_req_715_symbol : Boolean;
          signal split_ack_716_symbol : Boolean;
          signal word_access_717_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_227_request_712_start <= ptr_deref_227_trigger_x_x690_symbol; -- control passed to block
          Xentry_713_symbol  <= ptr_deref_227_request_712_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/$entry
          split_req_715_symbol <= Xentry_713_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/split_req
          ptr_deref_227_gather_scatter_req_0 <= split_req_715_symbol; -- link to DP
          split_ack_716_symbol <= ptr_deref_227_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/split_ack
          word_access_717: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access 
            signal word_access_717_start: Boolean;
            signal Xentry_718_symbol: Boolean;
            signal Xexit_719_symbol: Boolean;
            signal word_access_0_720_symbol : Boolean;
            -- 
          begin -- 
            word_access_717_start <= split_ack_716_symbol; -- control passed to block
            Xentry_718_symbol  <= word_access_717_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/$entry
            word_access_0_720: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/word_access_0 
              signal word_access_0_720_start: Boolean;
              signal Xentry_721_symbol: Boolean;
              signal Xexit_722_symbol: Boolean;
              signal rr_723_symbol : Boolean;
              signal ra_724_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_720_start <= Xentry_718_symbol; -- control passed to block
              Xentry_721_symbol  <= word_access_0_720_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/word_access_0/$entry
              rr_723_symbol <= Xentry_721_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/word_access_0/rr
              ptr_deref_227_store_0_req_0 <= rr_723_symbol; -- link to DP
              ra_724_symbol <= ptr_deref_227_store_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/word_access_0/ra
              Xexit_722_symbol <= ra_724_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/word_access_0/$exit
              word_access_0_720_symbol <= Xexit_722_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/word_access_0
            Xexit_719_symbol <= word_access_0_720_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access/$exit
            word_access_717_symbol <= Xexit_719_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/word_access
          Xexit_714_symbol <= word_access_717_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request/$exit
          ptr_deref_227_request_712_symbol <= Xexit_714_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_request
        ptr_deref_227_complete_725: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete 
          signal ptr_deref_227_complete_725_start: Boolean;
          signal Xentry_726_symbol: Boolean;
          signal Xexit_727_symbol: Boolean;
          signal word_access_728_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_227_complete_725_start <= ptr_deref_227_active_x_x691_symbol; -- control passed to block
          Xentry_726_symbol  <= ptr_deref_227_complete_725_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/$entry
          word_access_728: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access 
            signal word_access_728_start: Boolean;
            signal Xentry_729_symbol: Boolean;
            signal Xexit_730_symbol: Boolean;
            signal word_access_0_731_symbol : Boolean;
            -- 
          begin -- 
            word_access_728_start <= Xentry_726_symbol; -- control passed to block
            Xentry_729_symbol  <= word_access_728_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/$entry
            word_access_0_731: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/word_access_0 
              signal word_access_0_731_start: Boolean;
              signal Xentry_732_symbol: Boolean;
              signal Xexit_733_symbol: Boolean;
              signal cr_734_symbol : Boolean;
              signal ca_735_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_731_start <= Xentry_729_symbol; -- control passed to block
              Xentry_732_symbol  <= word_access_0_731_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/word_access_0/$entry
              cr_734_symbol <= Xentry_732_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/word_access_0/cr
              ptr_deref_227_store_0_req_1 <= cr_734_symbol; -- link to DP
              ca_735_symbol <= ptr_deref_227_store_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/word_access_0/ca
              Xexit_733_symbol <= ca_735_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/word_access_0/$exit
              word_access_0_731_symbol <= Xexit_733_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/word_access_0
            Xexit_730_symbol <= word_access_0_731_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access/$exit
            word_access_728_symbol <= Xexit_730_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/word_access
          Xexit_727_symbol <= word_access_728_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete/$exit
          ptr_deref_227_complete_725_symbol <= Xexit_727_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/ptr_deref_227_complete
        assign_stmt_232_active_x_x736_symbol <= simple_obj_ref_231_complete_738_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_232_active_
        assign_stmt_232_completed_x_x737_symbol <= simple_obj_ref_230_complete_756_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/assign_stmt_232_completed_
        simple_obj_ref_231_complete_738_symbol <= assign_stmt_217_completed_x_x638_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_231_complete
        simple_obj_ref_230_trigger_x_x739_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_trigger_ 
          signal simple_obj_ref_230_trigger_x_x739_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          simple_obj_ref_230_trigger_x_x739_predecessors(0) <= simple_obj_ref_230_word_address_calculated_742_symbol;
          simple_obj_ref_230_trigger_x_x739_predecessors(1) <= assign_stmt_232_active_x_x736_symbol;
          simple_obj_ref_230_trigger_x_x739_predecessors(2) <= simple_obj_ref_219_active_x_x650_symbol;
          simple_obj_ref_230_trigger_x_x739_join: join -- 
            port map( -- 
              preds => simple_obj_ref_230_trigger_x_x739_predecessors,
              symbol_out => simple_obj_ref_230_trigger_x_x739_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_trigger_
        simple_obj_ref_230_active_x_x740_symbol <= simple_obj_ref_230_request_743_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_active_
        simple_obj_ref_230_root_address_calculated_741_symbol <= Xentry_635_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_root_address_calculated
        simple_obj_ref_230_word_address_calculated_742_symbol <= simple_obj_ref_230_root_address_calculated_741_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_word_address_calculated
        simple_obj_ref_230_request_743: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request 
          signal simple_obj_ref_230_request_743_start: Boolean;
          signal Xentry_744_symbol: Boolean;
          signal Xexit_745_symbol: Boolean;
          signal split_req_746_symbol : Boolean;
          signal split_ack_747_symbol : Boolean;
          signal word_access_748_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_230_request_743_start <= simple_obj_ref_230_trigger_x_x739_symbol; -- control passed to block
          Xentry_744_symbol  <= simple_obj_ref_230_request_743_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/$entry
          split_req_746_symbol <= Xentry_744_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/split_req
          simple_obj_ref_230_gather_scatter_req_0 <= split_req_746_symbol; -- link to DP
          split_ack_747_symbol <= simple_obj_ref_230_gather_scatter_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/split_ack
          word_access_748: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access 
            signal word_access_748_start: Boolean;
            signal Xentry_749_symbol: Boolean;
            signal Xexit_750_symbol: Boolean;
            signal word_access_0_751_symbol : Boolean;
            -- 
          begin -- 
            word_access_748_start <= split_ack_747_symbol; -- control passed to block
            Xentry_749_symbol  <= word_access_748_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/$entry
            word_access_0_751: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/word_access_0 
              signal word_access_0_751_start: Boolean;
              signal Xentry_752_symbol: Boolean;
              signal Xexit_753_symbol: Boolean;
              signal rr_754_symbol : Boolean;
              signal ra_755_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_751_start <= Xentry_749_symbol; -- control passed to block
              Xentry_752_symbol  <= word_access_0_751_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/word_access_0/$entry
              rr_754_symbol <= Xentry_752_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/word_access_0/rr
              simple_obj_ref_230_store_0_req_0 <= rr_754_symbol; -- link to DP
              ra_755_symbol <= simple_obj_ref_230_store_0_ack_0; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/word_access_0/ra
              Xexit_753_symbol <= ra_755_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/word_access_0/$exit
              word_access_0_751_symbol <= Xexit_753_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/word_access_0
            Xexit_750_symbol <= word_access_0_751_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access/$exit
            word_access_748_symbol <= Xexit_750_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/word_access
          Xexit_745_symbol <= word_access_748_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request/$exit
          simple_obj_ref_230_request_743_symbol <= Xexit_745_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_request
        simple_obj_ref_230_complete_756: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete 
          signal simple_obj_ref_230_complete_756_start: Boolean;
          signal Xentry_757_symbol: Boolean;
          signal Xexit_758_symbol: Boolean;
          signal word_access_759_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_230_complete_756_start <= simple_obj_ref_230_active_x_x740_symbol; -- control passed to block
          Xentry_757_symbol  <= simple_obj_ref_230_complete_756_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/$entry
          word_access_759: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access 
            signal word_access_759_start: Boolean;
            signal Xentry_760_symbol: Boolean;
            signal Xexit_761_symbol: Boolean;
            signal word_access_0_762_symbol : Boolean;
            -- 
          begin -- 
            word_access_759_start <= Xentry_757_symbol; -- control passed to block
            Xentry_760_symbol  <= word_access_759_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/$entry
            word_access_0_762: Block -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/word_access_0 
              signal word_access_0_762_start: Boolean;
              signal Xentry_763_symbol: Boolean;
              signal Xexit_764_symbol: Boolean;
              signal cr_765_symbol : Boolean;
              signal ca_766_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_762_start <= Xentry_760_symbol; -- control passed to block
              Xentry_763_symbol  <= word_access_0_762_start; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/word_access_0/$entry
              cr_765_symbol <= Xentry_763_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/word_access_0/cr
              simple_obj_ref_230_store_0_req_1 <= cr_765_symbol; -- link to DP
              ca_766_symbol <= simple_obj_ref_230_store_0_ack_1; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/word_access_0/ca
              Xexit_764_symbol <= ca_766_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/word_access_0/$exit
              word_access_0_762_symbol <= Xexit_764_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/word_access_0
            Xexit_761_symbol <= word_access_0_762_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access/$exit
            word_access_759_symbol <= Xexit_761_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/word_access
          Xexit_758_symbol <= word_access_759_symbol; -- transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete/$exit
          simple_obj_ref_230_complete_756_symbol <= Xexit_758_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/simple_obj_ref_230_complete
        Xexit_636_block : Block -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/$exit 
          signal Xexit_636_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_636_predecessors(0) <= assign_stmt_229_completed_x_x688_symbol;
          Xexit_636_predecessors(1) <= assign_stmt_232_completed_x_x737_symbol;
          Xexit_636_join: join -- 
            port map( -- 
              preds => Xexit_636_predecessors,
              symbol_out => Xexit_636_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232/$exit
        assign_stmt_217_to_assign_stmt_232_634_symbol <= Xexit_636_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/assign_stmt_217_to_assign_stmt_232
      bb_0_xx_xbackedge_PhiReq_767: Block -- branch_block_stmt_104/bb_0_xx_xbackedge_PhiReq 
        signal bb_0_xx_xbackedge_PhiReq_767_start: Boolean;
        signal Xentry_768_symbol: Boolean;
        signal Xexit_769_symbol: Boolean;
        -- 
      begin -- 
        bb_0_xx_xbackedge_PhiReq_767_start <= bb_0_xx_xbackedge_224_symbol; -- control passed to block
        Xentry_768_symbol  <= bb_0_xx_xbackedge_PhiReq_767_start; -- transition branch_block_stmt_104/bb_0_xx_xbackedge_PhiReq/$entry
        Xexit_769_symbol <= Xentry_768_symbol; -- transition branch_block_stmt_104/bb_0_xx_xbackedge_PhiReq/$exit
        bb_0_xx_xbackedge_PhiReq_767_symbol <= Xexit_769_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/bb_0_xx_xbackedge_PhiReq
      bb_4_xx_xbackedge_PhiReq_770: Block -- branch_block_stmt_104/bb_4_xx_xbackedge_PhiReq 
        signal bb_4_xx_xbackedge_PhiReq_770_start: Boolean;
        signal Xentry_771_symbol: Boolean;
        signal Xexit_772_symbol: Boolean;
        -- 
      begin -- 
        bb_4_xx_xbackedge_PhiReq_770_start <= bb_4_xx_xbackedge_248_symbol; -- control passed to block
        Xentry_771_symbol  <= bb_4_xx_xbackedge_PhiReq_770_start; -- transition branch_block_stmt_104/bb_4_xx_xbackedge_PhiReq/$entry
        Xexit_772_symbol <= Xentry_771_symbol; -- transition branch_block_stmt_104/bb_4_xx_xbackedge_PhiReq/$exit
        bb_4_xx_xbackedge_PhiReq_770_symbol <= Xexit_772_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/bb_4_xx_xbackedge_PhiReq
      bb_5_xx_xbackedge_PhiReq_773: Block -- branch_block_stmt_104/bb_5_xx_xbackedge_PhiReq 
        signal bb_5_xx_xbackedge_PhiReq_773_start: Boolean;
        signal Xentry_774_symbol: Boolean;
        signal Xexit_775_symbol: Boolean;
        -- 
      begin -- 
        bb_5_xx_xbackedge_PhiReq_773_start <= bb_5_xx_xbackedge_256_symbol; -- control passed to block
        Xentry_774_symbol  <= bb_5_xx_xbackedge_PhiReq_773_start; -- transition branch_block_stmt_104/bb_5_xx_xbackedge_PhiReq/$entry
        Xexit_775_symbol <= Xentry_774_symbol; -- transition branch_block_stmt_104/bb_5_xx_xbackedge_PhiReq/$exit
        bb_5_xx_xbackedge_PhiReq_773_symbol <= Xexit_775_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/bb_5_xx_xbackedge_PhiReq
      xx_xbackedge_xx_xbackedge_PhiReq_776: Block -- branch_block_stmt_104/xx_xbackedge_xx_xbackedge_PhiReq 
        signal xx_xbackedge_xx_xbackedge_PhiReq_776_start: Boolean;
        signal Xentry_777_symbol: Boolean;
        signal Xexit_778_symbol: Boolean;
        -- 
      begin -- 
        xx_xbackedge_xx_xbackedge_PhiReq_776_start <= xx_xbackedge_xx_xbackedge_412_symbol; -- control passed to block
        Xentry_777_symbol  <= xx_xbackedge_xx_xbackedge_PhiReq_776_start; -- transition branch_block_stmt_104/xx_xbackedge_xx_xbackedge_PhiReq/$entry
        Xexit_778_symbol <= Xentry_777_symbol; -- transition branch_block_stmt_104/xx_xbackedge_xx_xbackedge_PhiReq/$exit
        xx_xbackedge_xx_xbackedge_PhiReq_776_symbol <= Xexit_778_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/xx_xbackedge_xx_xbackedge_PhiReq
      merge_stmt_139_PhiReqMerge_779_symbol  <=  bb_0_xx_xbackedge_PhiReq_767_symbol or bb_4_xx_xbackedge_PhiReq_770_symbol or bb_5_xx_xbackedge_PhiReq_773_symbol or xx_xbackedge_xx_xbackedge_PhiReq_776_symbol; -- place branch_block_stmt_104/merge_stmt_139_PhiReqMerge (optimized away) 
      merge_stmt_139_PhiAck_780: Block -- branch_block_stmt_104/merge_stmt_139_PhiAck 
        signal merge_stmt_139_PhiAck_780_start: Boolean;
        signal Xentry_781_symbol: Boolean;
        signal Xexit_782_symbol: Boolean;
        signal dummy_783_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_139_PhiAck_780_start <= merge_stmt_139_PhiReqMerge_779_symbol; -- control passed to block
        Xentry_781_symbol  <= merge_stmt_139_PhiAck_780_start; -- transition branch_block_stmt_104/merge_stmt_139_PhiAck/$entry
        dummy_783_symbol <= Xentry_781_symbol; -- transition branch_block_stmt_104/merge_stmt_139_PhiAck/dummy
        Xexit_782_symbol <= dummy_783_symbol; -- transition branch_block_stmt_104/merge_stmt_139_PhiAck/$exit
        merge_stmt_139_PhiAck_780_symbol <= Xexit_782_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_139_PhiAck
      merge_stmt_159_dead_link_784: Block -- branch_block_stmt_104/merge_stmt_159_dead_link 
        signal merge_stmt_159_dead_link_784_start: Boolean;
        signal Xentry_785_symbol: Boolean;
        signal Xexit_786_symbol: Boolean;
        signal dead_transition_787_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_159_dead_link_784_start <= merge_stmt_159_x_xentry_x_xx_x232_symbol; -- control passed to block
        Xentry_785_symbol  <= merge_stmt_159_dead_link_784_start; -- transition branch_block_stmt_104/merge_stmt_159_dead_link/$entry
        dead_transition_787_symbol <= false;
        Xexit_786_symbol <= dead_transition_787_symbol; -- transition branch_block_stmt_104/merge_stmt_159_dead_link/$exit
        merge_stmt_159_dead_link_784_symbol <= Xexit_786_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_159_dead_link
      xx_xbackedge_bb_2_PhiReq_788: Block -- branch_block_stmt_104/xx_xbackedge_bb_2_PhiReq 
        signal xx_xbackedge_bb_2_PhiReq_788_start: Boolean;
        signal Xentry_789_symbol: Boolean;
        signal Xexit_790_symbol: Boolean;
        -- 
      begin -- 
        xx_xbackedge_bb_2_PhiReq_788_start <= xx_xbackedge_bb_2_402_symbol; -- control passed to block
        Xentry_789_symbol  <= xx_xbackedge_bb_2_PhiReq_788_start; -- transition branch_block_stmt_104/xx_xbackedge_bb_2_PhiReq/$entry
        Xexit_790_symbol <= Xentry_789_symbol; -- transition branch_block_stmt_104/xx_xbackedge_bb_2_PhiReq/$exit
        xx_xbackedge_bb_2_PhiReq_788_symbol <= Xexit_790_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/xx_xbackedge_bb_2_PhiReq
      merge_stmt_159_PhiReqMerge_791_symbol  <=  xx_xbackedge_bb_2_PhiReq_788_symbol; -- place branch_block_stmt_104/merge_stmt_159_PhiReqMerge (optimized away) 
      merge_stmt_159_PhiAck_792: Block -- branch_block_stmt_104/merge_stmt_159_PhiAck 
        signal merge_stmt_159_PhiAck_792_start: Boolean;
        signal Xentry_793_symbol: Boolean;
        signal Xexit_794_symbol: Boolean;
        signal dummy_795_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_159_PhiAck_792_start <= merge_stmt_159_PhiReqMerge_791_symbol; -- control passed to block
        Xentry_793_symbol  <= merge_stmt_159_PhiAck_792_start; -- transition branch_block_stmt_104/merge_stmt_159_PhiAck/$entry
        dummy_795_symbol <= Xentry_793_symbol; -- transition branch_block_stmt_104/merge_stmt_159_PhiAck/dummy
        Xexit_794_symbol <= dummy_795_symbol; -- transition branch_block_stmt_104/merge_stmt_159_PhiAck/$exit
        merge_stmt_159_PhiAck_792_symbol <= Xexit_794_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_159_PhiAck
      merge_stmt_175_dead_link_796: Block -- branch_block_stmt_104/merge_stmt_175_dead_link 
        signal merge_stmt_175_dead_link_796_start: Boolean;
        signal Xentry_797_symbol: Boolean;
        signal Xexit_798_symbol: Boolean;
        signal dead_transition_799_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_175_dead_link_796_start <= merge_stmt_175_x_xentry_x_xx_x238_symbol; -- control passed to block
        Xentry_797_symbol  <= merge_stmt_175_dead_link_796_start; -- transition branch_block_stmt_104/merge_stmt_175_dead_link/$entry
        dead_transition_799_symbol <= false;
        Xexit_798_symbol <= dead_transition_799_symbol; -- transition branch_block_stmt_104/merge_stmt_175_dead_link/$exit
        merge_stmt_175_dead_link_796_symbol <= Xexit_798_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_175_dead_link
      bb_2_bb_3_PhiReq_800: Block -- branch_block_stmt_104/bb_2_bb_3_PhiReq 
        signal bb_2_bb_3_PhiReq_800_start: Boolean;
        signal Xentry_801_symbol: Boolean;
        signal Xexit_802_symbol: Boolean;
        -- 
      begin -- 
        bb_2_bb_3_PhiReq_800_start <= bb_2_bb_3_476_symbol; -- control passed to block
        Xentry_801_symbol  <= bb_2_bb_3_PhiReq_800_start; -- transition branch_block_stmt_104/bb_2_bb_3_PhiReq/$entry
        Xexit_802_symbol <= Xentry_801_symbol; -- transition branch_block_stmt_104/bb_2_bb_3_PhiReq/$exit
        bb_2_bb_3_PhiReq_800_symbol <= Xexit_802_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/bb_2_bb_3_PhiReq
      merge_stmt_175_PhiReqMerge_803_symbol  <=  bb_2_bb_3_PhiReq_800_symbol; -- place branch_block_stmt_104/merge_stmt_175_PhiReqMerge (optimized away) 
      merge_stmt_175_PhiAck_804: Block -- branch_block_stmt_104/merge_stmt_175_PhiAck 
        signal merge_stmt_175_PhiAck_804_start: Boolean;
        signal Xentry_805_symbol: Boolean;
        signal Xexit_806_symbol: Boolean;
        signal dummy_807_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_175_PhiAck_804_start <= merge_stmt_175_PhiReqMerge_803_symbol; -- control passed to block
        Xentry_805_symbol  <= merge_stmt_175_PhiAck_804_start; -- transition branch_block_stmt_104/merge_stmt_175_PhiAck/$entry
        dummy_807_symbol <= Xentry_805_symbol; -- transition branch_block_stmt_104/merge_stmt_175_PhiAck/dummy
        Xexit_806_symbol <= dummy_807_symbol; -- transition branch_block_stmt_104/merge_stmt_175_PhiAck/$exit
        merge_stmt_175_PhiAck_804_symbol <= Xexit_806_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_175_PhiAck
      bb_2_bb_4_PhiReq_808: Block -- branch_block_stmt_104/bb_2_bb_4_PhiReq 
        signal bb_2_bb_4_PhiReq_808_start: Boolean;
        signal Xentry_809_symbol: Boolean;
        signal Xexit_810_symbol: Boolean;
        -- 
      begin -- 
        bb_2_bb_4_PhiReq_808_start <= bb_2_bb_4_475_symbol; -- control passed to block
        Xentry_809_symbol  <= bb_2_bb_4_PhiReq_808_start; -- transition branch_block_stmt_104/bb_2_bb_4_PhiReq/$entry
        Xexit_810_symbol <= Xentry_809_symbol; -- transition branch_block_stmt_104/bb_2_bb_4_PhiReq/$exit
        bb_2_bb_4_PhiReq_808_symbol <= Xexit_810_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/bb_2_bb_4_PhiReq
      bb_3_bb_4_PhiReq_811: Block -- branch_block_stmt_104/bb_3_bb_4_PhiReq 
        signal bb_3_bb_4_PhiReq_811_start: Boolean;
        signal Xentry_812_symbol: Boolean;
        signal Xexit_813_symbol: Boolean;
        -- 
      begin -- 
        bb_3_bb_4_PhiReq_811_start <= bb_3_bb_4_242_symbol; -- control passed to block
        Xentry_812_symbol  <= bb_3_bb_4_PhiReq_811_start; -- transition branch_block_stmt_104/bb_3_bb_4_PhiReq/$entry
        Xexit_813_symbol <= Xentry_812_symbol; -- transition branch_block_stmt_104/bb_3_bb_4_PhiReq/$exit
        bb_3_bb_4_PhiReq_811_symbol <= Xexit_813_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/bb_3_bb_4_PhiReq
      merge_stmt_189_PhiReqMerge_814_symbol  <=  bb_2_bb_4_PhiReq_808_symbol or bb_3_bb_4_PhiReq_811_symbol; -- place branch_block_stmt_104/merge_stmt_189_PhiReqMerge (optimized away) 
      merge_stmt_189_PhiAck_815: Block -- branch_block_stmt_104/merge_stmt_189_PhiAck 
        signal merge_stmt_189_PhiAck_815_start: Boolean;
        signal Xentry_816_symbol: Boolean;
        signal Xexit_817_symbol: Boolean;
        signal dummy_818_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_189_PhiAck_815_start <= merge_stmt_189_PhiReqMerge_814_symbol; -- control passed to block
        Xentry_816_symbol  <= merge_stmt_189_PhiAck_815_start; -- transition branch_block_stmt_104/merge_stmt_189_PhiAck/$entry
        dummy_818_symbol <= Xentry_816_symbol; -- transition branch_block_stmt_104/merge_stmt_189_PhiAck/dummy
        Xexit_817_symbol <= dummy_818_symbol; -- transition branch_block_stmt_104/merge_stmt_189_PhiAck/$exit
        merge_stmt_189_PhiAck_815_symbol <= Xexit_817_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_189_PhiAck
      xx_xbackedge_bb_5_PhiReq_819: Block -- branch_block_stmt_104/xx_xbackedge_bb_5_PhiReq 
        signal xx_xbackedge_bb_5_PhiReq_819_start: Boolean;
        signal Xentry_820_symbol: Boolean;
        signal Xexit_821_symbol: Boolean;
        -- 
      begin -- 
        xx_xbackedge_bb_5_PhiReq_819_start <= xx_xbackedge_bb_5_407_symbol; -- control passed to block
        Xentry_820_symbol  <= xx_xbackedge_bb_5_PhiReq_819_start; -- transition branch_block_stmt_104/xx_xbackedge_bb_5_PhiReq/$entry
        Xexit_821_symbol <= Xentry_820_symbol; -- transition branch_block_stmt_104/xx_xbackedge_bb_5_PhiReq/$exit
        xx_xbackedge_bb_5_PhiReq_819_symbol <= Xexit_821_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/xx_xbackedge_bb_5_PhiReq
      merge_stmt_204_PhiReqMerge_822_symbol  <=  xx_xbackedge_bb_5_PhiReq_819_symbol; -- place branch_block_stmt_104/merge_stmt_204_PhiReqMerge (optimized away) 
      merge_stmt_204_PhiAck_823: Block -- branch_block_stmt_104/merge_stmt_204_PhiAck 
        signal merge_stmt_204_PhiAck_823_start: Boolean;
        signal Xentry_824_symbol: Boolean;
        signal Xexit_825_symbol: Boolean;
        signal dummy_826_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_204_PhiAck_823_start <= merge_stmt_204_PhiReqMerge_822_symbol; -- control passed to block
        Xentry_824_symbol  <= merge_stmt_204_PhiAck_823_start; -- transition branch_block_stmt_104/merge_stmt_204_PhiAck/$entry
        dummy_826_symbol <= Xentry_824_symbol; -- transition branch_block_stmt_104/merge_stmt_204_PhiAck/dummy
        Xexit_825_symbol <= dummy_826_symbol; -- transition branch_block_stmt_104/merge_stmt_204_PhiAck/$exit
        merge_stmt_204_PhiAck_823_symbol <= Xexit_825_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_104/merge_stmt_204_PhiAck
      Xexit_219_symbol <= branch_block_stmt_104_x_xexit_x_xx_x221_symbol; -- transition branch_block_stmt_104/$exit
      branch_block_stmt_104_217_symbol <= Xexit_219_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_104
    Xexit_216_symbol <= branch_block_stmt_104_217_symbol; -- transition $exit
    fin  <=  '1' when Xexit_216_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_179_resized_base_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_179_root_address : std_logic_vector(2 downto 0);
    signal expr_128_wire_constant : std_logic_vector(31 downto 0);
    signal expr_151_wire_constant : std_logic_vector(7 downto 0);
    signal expr_151_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_154_wire_constant : std_logic_vector(7 downto 0);
    signal expr_154_wire_constant_cmp : std_logic_vector(0 downto 0);
    signal expr_165_wire_constant : std_logic_vector(31 downto 0);
    signal iNsTr_0_109 : std_logic_vector(31 downto 0);
    signal iNsTr_11_162 : std_logic_vector(31 downto 0);
    signal iNsTr_12_168 : std_logic_vector(0 downto 0);
    signal iNsTr_14_209 : std_logic_vector(31 downto 0);
    signal iNsTr_15_213 : std_logic_vector(31 downto 0);
    signal iNsTr_16_217 : std_logic_vector(31 downto 0);
    signal iNsTr_17_220 : std_logic_vector(31 downto 0);
    signal iNsTr_18_225 : std_logic_vector(31 downto 0);
    signal iNsTr_1_115 : std_logic_vector(31 downto 0);
    signal iNsTr_22_193 : std_logic_vector(31 downto 0);
    signal iNsTr_23_198 : std_logic_vector(31 downto 0);
    signal iNsTr_26_180 : std_logic_vector(31 downto 0);
    signal iNsTr_27_184 : std_logic_vector(31 downto 0);
    signal iNsTr_3_125 : std_logic_vector(31 downto 0);
    signal iNsTr_5_134 : std_logic_vector(31 downto 0);
    signal iNsTr_8_144 : std_logic_vector(31 downto 0);
    signal iNsTr_9_148 : std_logic_vector(7 downto 0);
    signal ptr_deref_117_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_117_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_117_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_127_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_127_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_127_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_183_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_183_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_183_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_183_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_183_word_offset_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_227_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_227_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_227_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_227_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_227_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_227_word_offset_0 : std_logic_vector(2 downto 0);
    signal simple_obj_ref_135_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_135_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_146_wire : std_logic_vector(7 downto 0);
    signal simple_obj_ref_161_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_161_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_185_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_185_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_211_wire : std_logic_vector(31 downto 0);
    signal simple_obj_ref_219_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_219_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_230_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_230_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_201_wire : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    expr_128_wire_constant <= "00000000000000000000000000000000";
    expr_151_wire_constant <= "00000010";
    expr_154_wire_constant <= "00000001";
    expr_165_wire_constant <= "00000000000000000000000000000000";
    iNsTr_0_109 <= "00000000000000000000000000000100";
    iNsTr_14_209 <= "00000000000000000000000000000000";
    iNsTr_1_115 <= "00000000000000000000000000000010";
    iNsTr_23_198 <= "00000000000000000000000000000000";
    iNsTr_3_125 <= "00000000000000000000000000000100";
    iNsTr_5_134 <= "00000000000000000000000000000010";
    iNsTr_8_144 <= "00000000000000000000000000000000";
    ptr_deref_117_word_address_0 <= "010";
    ptr_deref_127_word_address_0 <= "100";
    ptr_deref_183_word_offset_0 <= "000";
    ptr_deref_227_word_offset_0 <= "000";
    simple_obj_ref_135_word_address_0 <= "0";
    simple_obj_ref_161_word_address_0 <= "0";
    simple_obj_ref_185_word_address_0 <= "0";
    simple_obj_ref_219_word_address_0 <= "0";
    simple_obj_ref_230_word_address_0 <= "0";
    array_obj_ref_179_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_11_162, dout => array_obj_ref_179_resized_base_address, req => array_obj_ref_179_base_resize_req_0, ack => array_obj_ref_179_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_179_final_reg: RegisterBase generic map(in_data_width => 3,out_data_width => 32) -- 
      port map( din => array_obj_ref_179_root_address, dout => iNsTr_26_180, req => array_obj_ref_179_final_reg_req_0, ack => array_obj_ref_179_final_reg_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_183_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_26_180, dout => ptr_deref_183_resized_base_address, req => ptr_deref_183_base_resize_req_0, ack => ptr_deref_183_base_resize_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_227_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_18_225, dout => ptr_deref_227_resized_base_address, req => ptr_deref_227_base_resize_req_0, ack => ptr_deref_227_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_147_inst: RegisterBase generic map(in_data_width => 8,out_data_width => 8) -- 
      port map( din => simple_obj_ref_146_wire, dout => iNsTr_9_148, req => type_cast_147_inst_req_0, ack => type_cast_147_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_192_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_11_162, dout => iNsTr_22_193, req => type_cast_192_inst_req_0, ack => type_cast_192_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_201_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_22_193, dout => type_cast_201_wire, req => type_cast_201_inst_req_0, ack => type_cast_201_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_212_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_211_wire, dout => iNsTr_15_213, req => type_cast_212_inst_req_0, ack => type_cast_212_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_216_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_15_213, dout => iNsTr_16_217, req => type_cast_216_inst_req_0, ack => type_cast_216_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_224_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_15_213, dout => iNsTr_18_225, req => type_cast_224_inst_req_0, ack => type_cast_224_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_179_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_179_root_address_inst_ack_0 <= array_obj_ref_179_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_179_resized_base_address;
      array_obj_ref_179_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_117_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_117_gather_scatter_ack_0 <= ptr_deref_117_gather_scatter_req_0;
      aggregated_sig <= iNsTr_0_109;
      ptr_deref_117_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_127_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_127_gather_scatter_ack_0 <= ptr_deref_127_gather_scatter_req_0;
      aggregated_sig <= expr_128_wire_constant;
      ptr_deref_127_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_183_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_183_addr_0_ack_0 <= ptr_deref_183_addr_0_req_0;
      aggregated_sig <= ptr_deref_183_root_address;
      ptr_deref_183_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_183_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_183_gather_scatter_ack_0 <= ptr_deref_183_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_183_data_0;
      iNsTr_27_184 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_183_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_183_root_address_inst_ack_0 <= ptr_deref_183_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_183_resized_base_address;
      ptr_deref_183_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_227_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_227_addr_0_ack_0 <= ptr_deref_227_addr_0_req_0;
      aggregated_sig <= ptr_deref_227_root_address;
      ptr_deref_227_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_227_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_227_gather_scatter_ack_0 <= ptr_deref_227_gather_scatter_req_0;
      aggregated_sig <= iNsTr_17_220;
      ptr_deref_227_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_227_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_227_root_address_inst_ack_0 <= ptr_deref_227_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_227_resized_base_address;
      ptr_deref_227_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    simple_obj_ref_135_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_135_gather_scatter_ack_0 <= simple_obj_ref_135_gather_scatter_req_0;
      aggregated_sig <= iNsTr_5_134;
      simple_obj_ref_135_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_161_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_161_gather_scatter_ack_0 <= simple_obj_ref_161_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_161_data_0;
      iNsTr_11_162 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_185_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_185_gather_scatter_ack_0 <= simple_obj_ref_185_gather_scatter_req_0;
      aggregated_sig <= iNsTr_27_184;
      simple_obj_ref_185_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_219_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_219_gather_scatter_ack_0 <= simple_obj_ref_219_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_219_data_0;
      iNsTr_17_220 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_230_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_230_gather_scatter_ack_0 <= simple_obj_ref_230_gather_scatter_req_0;
      aggregated_sig <= iNsTr_16_217;
      simple_obj_ref_230_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    if_stmt_169_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_12_168;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_169_branch_req_0,
          ack0 => if_stmt_169_branch_ack_0,
          ack1 => if_stmt_169_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_149_branch_0: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_151_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_149_branch_0_req_0,
          ack0 => open,
          ack1 => switch_stmt_149_branch_0_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_149_branch_1: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= expr_154_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_149_branch_1_req_0,
          ack0 => open,
          ack1 => switch_stmt_149_branch_1_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    switch_stmt_149_branch_default: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(1 downto 0);
      begin 
      condition_sig <= expr_151_wire_constant_cmp & expr_154_wire_constant_cmp;
      branch_instance: BranchBase -- 
        generic map( condition_width => 2)
        port map( -- 
          condition => condition_sig,
          req => switch_stmt_149_branch_default_req_0,
          ack0 => switch_stmt_149_branch_default_ack_0,
          ack1 => open,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_166_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_11_162;
      iNsTr_12_168 <= data_out(0 downto 0);
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
          reqL => binary_166_inst_req_0,
          ackL => binary_166_inst_ack_0,
          reqR => binary_166_inst_req_1,
          ackR => binary_166_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : switch_stmt_149_select_expr_0 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_148;
      expr_151_wire_constant_cmp <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000010",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_149_select_expr_0_req_0,
          ackL => switch_stmt_149_select_expr_0_ack_0,
          reqR => switch_stmt_149_select_expr_0_req_1,
          ackR => switch_stmt_149_select_expr_0_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : switch_stmt_149_select_expr_1 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_148;
      expr_154_wire_constant_cmp <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntEq",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 8,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "00000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => switch_stmt_149_select_expr_1_req_0,
          ackL => switch_stmt_149_select_expr_1_ack_0,
          reqR => switch_stmt_149_select_expr_1_req_1,
          ackR => switch_stmt_149_select_expr_1_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared load operator group (0) : ptr_deref_183_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(2 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_183_load_0_req_0;
      ptr_deref_183_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_183_load_0_req_1;
      ptr_deref_183_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_183_word_address_0;
      ptr_deref_183_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 3,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(2 downto 0),
          mtag => memory_space_1_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_1_lc_req(0),
          mack => memory_space_1_lc_ack(0),
          mdata => memory_space_1_lc_data(31 downto 0),
          mtag => memory_space_1_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : simple_obj_ref_219_load_0 simple_obj_ref_161_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= simple_obj_ref_219_load_0_req_0;
      reqL(0) <= simple_obj_ref_161_load_0_req_0;
      simple_obj_ref_219_load_0_ack_0 <= ackL(1);
      simple_obj_ref_161_load_0_ack_0 <= ackL(0);
      reqR(1) <= simple_obj_ref_219_load_0_req_1;
      reqR(0) <= simple_obj_ref_161_load_0_req_1;
      simple_obj_ref_219_load_0_ack_1 <= ackR(1);
      simple_obj_ref_161_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_219_word_address_0 & simple_obj_ref_161_word_address_0;
      simple_obj_ref_219_data_0 <= data_out(63 downto 32);
      simple_obj_ref_161_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_2_lr_req(0),
          mack => memory_space_2_lr_ack(0),
          maddr => memory_space_2_lr_addr(0 downto 0),
          mtag => memory_space_2_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_2_lc_req(0),
          mack => memory_space_2_lc_ack(0),
          mdata => memory_space_2_lc_data(31 downto 0),
          mtag => memory_space_2_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared store operator group (0) : ptr_deref_117_store_0 ptr_deref_227_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(5 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_117_store_0_req_0;
      reqL(0) <= ptr_deref_227_store_0_req_0;
      ptr_deref_117_store_0_ack_0 <= ackL(1);
      ptr_deref_227_store_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_117_store_0_req_1;
      reqR(0) <= ptr_deref_227_store_0_req_1;
      ptr_deref_117_store_0_ack_1 <= ackR(1);
      ptr_deref_227_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_117_word_address_0 & ptr_deref_227_word_address_0;
      data_in <= ptr_deref_117_data_0 & ptr_deref_227_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 3,
        data_width => 32,
        num_reqs => 2,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(1),
          mack => memory_space_1_sr_ack(1),
          maddr => memory_space_1_sr_addr(5 downto 3),
          mdata => memory_space_1_sr_data(63 downto 32),
          mtag => memory_space_1_sr_tag(3 downto 2),
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
          mreq => memory_space_1_sc_req(1),
          mack => memory_space_1_sc_ack(1),
          mtag => memory_space_1_sc_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_127_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_127_store_0_req_0;
      ptr_deref_127_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_127_store_0_req_1;
      ptr_deref_127_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_127_word_address_0;
      data_in <= ptr_deref_127_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 3,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(0),
          mack => memory_space_1_sr_ack(0),
          maddr => memory_space_1_sr_addr(2 downto 0),
          mdata => memory_space_1_sr_data(31 downto 0),
          mtag => memory_space_1_sr_tag(1 downto 0),
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
          mreq => memory_space_1_sc_req(0),
          mack => memory_space_1_sc_ack(0),
          mtag => memory_space_1_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : simple_obj_ref_230_store_0 simple_obj_ref_185_store_0 simple_obj_ref_135_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
      signal data_in: std_logic_vector(95 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= simple_obj_ref_230_store_0_req_0;
      reqL(1) <= simple_obj_ref_185_store_0_req_0;
      reqL(0) <= simple_obj_ref_135_store_0_req_0;
      simple_obj_ref_230_store_0_ack_0 <= ackL(2);
      simple_obj_ref_185_store_0_ack_0 <= ackL(1);
      simple_obj_ref_135_store_0_ack_0 <= ackL(0);
      reqR(2) <= simple_obj_ref_230_store_0_req_1;
      reqR(1) <= simple_obj_ref_185_store_0_req_1;
      reqR(0) <= simple_obj_ref_135_store_0_req_1;
      simple_obj_ref_230_store_0_ack_1 <= ackR(2);
      simple_obj_ref_185_store_0_ack_1 <= ackR(1);
      simple_obj_ref_135_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_230_word_address_0 & simple_obj_ref_185_word_address_0 & simple_obj_ref_135_word_address_0;
      data_in <= simple_obj_ref_230_data_0 & simple_obj_ref_185_data_0 & simple_obj_ref_135_data_0;
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
          mreq => memory_space_2_sr_req(0),
          mack => memory_space_2_sr_ack(0),
          maddr => memory_space_2_sr_addr(0 downto 0),
          mdata => memory_space_2_sr_data(31 downto 0),
          mtag => memory_space_2_sr_tag(1 downto 0),
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
          mreq => memory_space_2_sc_req(0),
          mack => memory_space_2_sc_ack(0),
          mtag => memory_space_2_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared inport operator group (0) : simple_obj_ref_146_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_146_inst_req_0;
      simple_obj_ref_146_inst_ack_0 <= ack(0);
      simple_obj_ref_146_wire <= data_out(7 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => free_queue_request_pipe_read_req(0),
          oack => free_queue_request_pipe_read_ack(0),
          odata => free_queue_request_pipe_read_data(7 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : simple_obj_ref_211_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_211_inst_req_0;
      simple_obj_ref_211_inst_ack_0 <= ack(0);
      simple_obj_ref_211_wire <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => free_queue_put_pipe_read_req(0),
          oack => free_queue_put_pipe_read_ack(0),
          odata => free_queue_put_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : simple_obj_ref_199_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_199_inst_req_0;
      simple_obj_ref_199_inst_ack_0 <= ack(0);
      data_in <= type_cast_201_wire;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => free_queue_get_pipe_write_req(0),
          oack => free_queue_get_pipe_write_ack(0),
          odata => free_queue_get_pipe_write_data(31 downto 0),
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
entity input_module is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sr_addr : out  std_logic_vector(2 downto 0);
    memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
    free_queue_get_pipe_read_req : out  std_logic_vector(0 downto 0);
    free_queue_get_pipe_read_ack : in   std_logic_vector(0 downto 0);
    free_queue_get_pipe_read_data : in   std_logic_vector(31 downto 0);
    input_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    input_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    input_data_pipe_read_data : in   std_logic_vector(31 downto 0);
    foo_in_pipe_write_req : out  std_logic_vector(0 downto 0);
    foo_in_pipe_write_ack : in   std_logic_vector(0 downto 0);
    foo_in_pipe_write_data : out  std_logic_vector(31 downto 0);
    free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity input_module;
architecture Default of input_module is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal type_cast_256_inst_ack_0 : boolean;
  signal ptr_deref_288_base_resize_ack_0 : boolean;
  signal ptr_deref_288_root_address_inst_req_0 : boolean;
  signal ptr_deref_288_root_address_inst_ack_0 : boolean;
  signal ptr_deref_288_base_resize_req_0 : boolean;
  signal ptr_deref_288_gather_scatter_req_0 : boolean;
  signal ptr_deref_288_gather_scatter_ack_0 : boolean;
  signal if_stmt_263_branch_ack_0 : boolean;
  signal type_cast_277_inst_ack_0 : boolean;
  signal simple_obj_ref_245_inst_req_0 : boolean;
  signal binary_261_inst_ack_1 : boolean;
  signal type_cast_298_inst_req_0 : boolean;
  signal type_cast_298_inst_ack_0 : boolean;
  signal if_stmt_263_branch_req_0 : boolean;
  signal binary_261_inst_req_1 : boolean;
  signal simple_obj_ref_255_inst_req_0 : boolean;
  signal array_obj_ref_281_root_address_inst_req_0 : boolean;
  signal array_obj_ref_281_base_resize_ack_0 : boolean;
  signal type_cast_285_inst_req_0 : boolean;
  signal type_cast_285_inst_ack_0 : boolean;
  signal array_obj_ref_281_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_281_final_reg_req_0 : boolean;
  signal simple_obj_ref_255_inst_ack_0 : boolean;
  signal simple_obj_ref_296_inst_req_0 : boolean;
  signal simple_obj_ref_296_inst_ack_0 : boolean;
  signal ptr_deref_288_addr_0_req_0 : boolean;
  signal ptr_deref_288_addr_0_ack_0 : boolean;
  signal ptr_deref_288_store_0_req_0 : boolean;
  signal ptr_deref_288_store_0_ack_0 : boolean;
  signal ptr_deref_288_store_0_req_1 : boolean;
  signal ptr_deref_288_store_0_ack_1 : boolean;
  signal simple_obj_ref_245_inst_ack_0 : boolean;
  signal type_cast_256_inst_req_0 : boolean;
  signal binary_261_inst_ack_0 : boolean;
  signal if_stmt_263_branch_ack_1 : boolean;
  signal simple_obj_ref_276_inst_ack_0 : boolean;
  signal type_cast_277_inst_req_0 : boolean;
  signal binary_261_inst_req_0 : boolean;
  signal array_obj_ref_281_final_reg_ack_0 : boolean;
  signal array_obj_ref_281_base_resize_req_0 : boolean;
  signal simple_obj_ref_276_inst_req_0 : boolean;
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
  input_module_CP_827: Block -- control-path 
    signal input_module_CP_827_start: Boolean;
    signal Xentry_828_symbol: Boolean;
    signal Xexit_829_symbol: Boolean;
    signal branch_block_stmt_237_830_symbol : Boolean;
    -- 
  begin -- 
    input_module_CP_827_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_828_symbol  <= input_module_CP_827_start; -- transition $entry
    branch_block_stmt_237_830: Block -- branch_block_stmt_237 
      signal branch_block_stmt_237_830_start: Boolean;
      signal Xentry_831_symbol: Boolean;
      signal Xexit_832_symbol: Boolean;
      signal branch_block_stmt_237_x_xentry_x_xx_x833_symbol : Boolean;
      signal branch_block_stmt_237_x_xexit_x_xx_x834_symbol : Boolean;
      signal bb_0_xx_xbackedge_835_symbol : Boolean;
      signal merge_stmt_239_x_xexit_x_xx_x836_symbol : Boolean;
      signal assign_stmt_244_x_xentry_x_xx_x837_symbol : Boolean;
      signal assign_stmt_244_x_xexit_x_xx_x838_symbol : Boolean;
      signal assign_stmt_248_x_xentry_x_xx_x839_symbol : Boolean;
      signal assign_stmt_248_x_xexit_x_xx_x840_symbol : Boolean;
      signal assign_stmt_253_x_xentry_x_xx_x841_symbol : Boolean;
      signal assign_stmt_253_x_xexit_x_xx_x842_symbol : Boolean;
      signal assign_stmt_257_x_xentry_x_xx_x843_symbol : Boolean;
      signal assign_stmt_257_x_xexit_x_xx_x844_symbol : Boolean;
      signal assign_stmt_262_x_xentry_x_xx_x845_symbol : Boolean;
      signal assign_stmt_262_x_xexit_x_xx_x846_symbol : Boolean;
      signal if_stmt_263_x_xentry_x_xx_x847_symbol : Boolean;
      signal if_stmt_263_x_xexit_x_xx_x848_symbol : Boolean;
      signal merge_stmt_269_x_xentry_x_xx_x849_symbol : Boolean;
      signal merge_stmt_269_x_xexit_x_xx_x850_symbol : Boolean;
      signal assign_stmt_274_x_xentry_x_xx_x851_symbol : Boolean;
      signal assign_stmt_274_x_xexit_x_xx_x852_symbol : Boolean;
      signal assign_stmt_278_x_xentry_x_xx_x853_symbol : Boolean;
      signal assign_stmt_278_x_xexit_x_xx_x854_symbol : Boolean;
      signal assign_stmt_282_to_assign_stmt_295_x_xentry_x_xx_x855_symbol : Boolean;
      signal assign_stmt_282_to_assign_stmt_295_x_xexit_x_xx_x856_symbol : Boolean;
      signal assign_stmt_299_x_xentry_x_xx_x857_symbol : Boolean;
      signal assign_stmt_299_x_xexit_x_xx_x858_symbol : Boolean;
      signal bb_2_xx_xbackedge_859_symbol : Boolean;
      signal assign_stmt_244_860_symbol : Boolean;
      signal assign_stmt_248_863_symbol : Boolean;
      signal assign_stmt_253_874_symbol : Boolean;
      signal assign_stmt_257_877_symbol : Boolean;
      signal assign_stmt_262_895_symbol : Boolean;
      signal if_stmt_263_dead_link_910_symbol : Boolean;
      signal if_stmt_263_eval_test_914_symbol : Boolean;
      signal simple_obj_ref_264_place_918_symbol : Boolean;
      signal if_stmt_263_if_link_919_symbol : Boolean;
      signal if_stmt_263_else_link_923_symbol : Boolean;
      signal xx_xbackedge_xx_xbackedge_927_symbol : Boolean;
      signal xx_xbackedge_bb_2_928_symbol : Boolean;
      signal assign_stmt_274_929_symbol : Boolean;
      signal assign_stmt_278_932_symbol : Boolean;
      signal assign_stmt_282_to_assign_stmt_295_950_symbol : Boolean;
      signal assign_stmt_299_1034_symbol : Boolean;
      signal bb_0_xx_xbackedge_PhiReq_1053_symbol : Boolean;
      signal bb_2_xx_xbackedge_PhiReq_1056_symbol : Boolean;
      signal xx_xbackedge_xx_xbackedge_PhiReq_1059_symbol : Boolean;
      signal merge_stmt_239_PhiReqMerge_1062_symbol : Boolean;
      signal merge_stmt_239_PhiAck_1063_symbol : Boolean;
      signal merge_stmt_269_dead_link_1067_symbol : Boolean;
      signal xx_xbackedge_bb_2_PhiReq_1071_symbol : Boolean;
      signal merge_stmt_269_PhiReqMerge_1074_symbol : Boolean;
      signal merge_stmt_269_PhiAck_1075_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_237_830_start <= Xentry_828_symbol; -- control passed to block
      Xentry_831_symbol  <= branch_block_stmt_237_830_start; -- transition branch_block_stmt_237/$entry
      branch_block_stmt_237_x_xentry_x_xx_x833_symbol  <=  Xentry_831_symbol; -- place branch_block_stmt_237/branch_block_stmt_237__entry__ (optimized away) 
      branch_block_stmt_237_x_xexit_x_xx_x834_symbol  <=   false ; -- place branch_block_stmt_237/branch_block_stmt_237__exit__ (optimized away) 
      bb_0_xx_xbackedge_835_symbol  <=  branch_block_stmt_237_x_xentry_x_xx_x833_symbol; -- place branch_block_stmt_237/bb_0_xx_xbackedge (optimized away) 
      merge_stmt_239_x_xexit_x_xx_x836_symbol  <=  merge_stmt_239_PhiAck_1063_symbol; -- place branch_block_stmt_237/merge_stmt_239__exit__ (optimized away) 
      assign_stmt_244_x_xentry_x_xx_x837_symbol  <=  merge_stmt_239_x_xexit_x_xx_x836_symbol; -- place branch_block_stmt_237/assign_stmt_244__entry__ (optimized away) 
      assign_stmt_244_x_xexit_x_xx_x838_symbol  <=  assign_stmt_244_860_symbol; -- place branch_block_stmt_237/assign_stmt_244__exit__ (optimized away) 
      assign_stmt_248_x_xentry_x_xx_x839_symbol  <=  assign_stmt_244_x_xexit_x_xx_x838_symbol; -- place branch_block_stmt_237/assign_stmt_248__entry__ (optimized away) 
      assign_stmt_248_x_xexit_x_xx_x840_symbol  <=  assign_stmt_248_863_symbol; -- place branch_block_stmt_237/assign_stmt_248__exit__ (optimized away) 
      assign_stmt_253_x_xentry_x_xx_x841_symbol  <=  assign_stmt_248_x_xexit_x_xx_x840_symbol; -- place branch_block_stmt_237/assign_stmt_253__entry__ (optimized away) 
      assign_stmt_253_x_xexit_x_xx_x842_symbol  <=  assign_stmt_253_874_symbol; -- place branch_block_stmt_237/assign_stmt_253__exit__ (optimized away) 
      assign_stmt_257_x_xentry_x_xx_x843_symbol  <=  assign_stmt_253_x_xexit_x_xx_x842_symbol; -- place branch_block_stmt_237/assign_stmt_257__entry__ (optimized away) 
      assign_stmt_257_x_xexit_x_xx_x844_symbol  <=  assign_stmt_257_877_symbol; -- place branch_block_stmt_237/assign_stmt_257__exit__ (optimized away) 
      assign_stmt_262_x_xentry_x_xx_x845_symbol  <=  assign_stmt_257_x_xexit_x_xx_x844_symbol; -- place branch_block_stmt_237/assign_stmt_262__entry__ (optimized away) 
      assign_stmt_262_x_xexit_x_xx_x846_symbol  <=  assign_stmt_262_895_symbol; -- place branch_block_stmt_237/assign_stmt_262__exit__ (optimized away) 
      if_stmt_263_x_xentry_x_xx_x847_symbol  <=  assign_stmt_262_x_xexit_x_xx_x846_symbol; -- place branch_block_stmt_237/if_stmt_263__entry__ (optimized away) 
      if_stmt_263_x_xexit_x_xx_x848_symbol  <=  if_stmt_263_dead_link_910_symbol; -- place branch_block_stmt_237/if_stmt_263__exit__ (optimized away) 
      merge_stmt_269_x_xentry_x_xx_x849_symbol  <=  if_stmt_263_x_xexit_x_xx_x848_symbol; -- place branch_block_stmt_237/merge_stmt_269__entry__ (optimized away) 
      merge_stmt_269_x_xexit_x_xx_x850_symbol  <=  merge_stmt_269_dead_link_1067_symbol or merge_stmt_269_PhiAck_1075_symbol; -- place branch_block_stmt_237/merge_stmt_269__exit__ (optimized away) 
      assign_stmt_274_x_xentry_x_xx_x851_symbol  <=  merge_stmt_269_x_xexit_x_xx_x850_symbol; -- place branch_block_stmt_237/assign_stmt_274__entry__ (optimized away) 
      assign_stmt_274_x_xexit_x_xx_x852_symbol  <=  assign_stmt_274_929_symbol; -- place branch_block_stmt_237/assign_stmt_274__exit__ (optimized away) 
      assign_stmt_278_x_xentry_x_xx_x853_symbol  <=  assign_stmt_274_x_xexit_x_xx_x852_symbol; -- place branch_block_stmt_237/assign_stmt_278__entry__ (optimized away) 
      assign_stmt_278_x_xexit_x_xx_x854_symbol  <=  assign_stmt_278_932_symbol; -- place branch_block_stmt_237/assign_stmt_278__exit__ (optimized away) 
      assign_stmt_282_to_assign_stmt_295_x_xentry_x_xx_x855_symbol  <=  assign_stmt_278_x_xexit_x_xx_x854_symbol; -- place branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295__entry__ (optimized away) 
      assign_stmt_282_to_assign_stmt_295_x_xexit_x_xx_x856_symbol  <=  assign_stmt_282_to_assign_stmt_295_950_symbol; -- place branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295__exit__ (optimized away) 
      assign_stmt_299_x_xentry_x_xx_x857_symbol  <=  assign_stmt_282_to_assign_stmt_295_x_xexit_x_xx_x856_symbol; -- place branch_block_stmt_237/assign_stmt_299__entry__ (optimized away) 
      assign_stmt_299_x_xexit_x_xx_x858_symbol  <=  assign_stmt_299_1034_symbol; -- place branch_block_stmt_237/assign_stmt_299__exit__ (optimized away) 
      bb_2_xx_xbackedge_859_symbol  <=  assign_stmt_299_x_xexit_x_xx_x858_symbol; -- place branch_block_stmt_237/bb_2_xx_xbackedge (optimized away) 
      assign_stmt_244_860: Block -- branch_block_stmt_237/assign_stmt_244 
        signal assign_stmt_244_860_start: Boolean;
        signal Xentry_861_symbol: Boolean;
        signal Xexit_862_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_244_860_start <= assign_stmt_244_x_xentry_x_xx_x837_symbol; -- control passed to block
        Xentry_861_symbol  <= assign_stmt_244_860_start; -- transition branch_block_stmt_237/assign_stmt_244/$entry
        Xexit_862_symbol <= Xentry_861_symbol; -- transition branch_block_stmt_237/assign_stmt_244/$exit
        assign_stmt_244_860_symbol <= Xexit_862_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_244
      assign_stmt_248_863: Block -- branch_block_stmt_237/assign_stmt_248 
        signal assign_stmt_248_863_start: Boolean;
        signal Xentry_864_symbol: Boolean;
        signal Xexit_865_symbol: Boolean;
        signal assign_stmt_248_active_x_x866_symbol : Boolean;
        signal assign_stmt_248_completed_x_x867_symbol : Boolean;
        signal simple_obj_ref_245_trigger_x_x868_symbol : Boolean;
        signal simple_obj_ref_245_complete_869_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_248_863_start <= assign_stmt_248_x_xentry_x_xx_x839_symbol; -- control passed to block
        Xentry_864_symbol  <= assign_stmt_248_863_start; -- transition branch_block_stmt_237/assign_stmt_248/$entry
        assign_stmt_248_active_x_x866_symbol <= Xentry_864_symbol; -- transition branch_block_stmt_237/assign_stmt_248/assign_stmt_248_active_
        assign_stmt_248_completed_x_x867_symbol <= simple_obj_ref_245_complete_869_symbol; -- transition branch_block_stmt_237/assign_stmt_248/assign_stmt_248_completed_
        simple_obj_ref_245_trigger_x_x868_symbol <= assign_stmt_248_active_x_x866_symbol; -- transition branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_trigger_
        simple_obj_ref_245_complete_869: Block -- branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_complete 
          signal simple_obj_ref_245_complete_869_start: Boolean;
          signal Xentry_870_symbol: Boolean;
          signal Xexit_871_symbol: Boolean;
          signal pipe_wreq_872_symbol : Boolean;
          signal pipe_wack_873_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_245_complete_869_start <= simple_obj_ref_245_trigger_x_x868_symbol; -- control passed to block
          Xentry_870_symbol  <= simple_obj_ref_245_complete_869_start; -- transition branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_complete/$entry
          pipe_wreq_872_symbol <= Xentry_870_symbol; -- transition branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_complete/pipe_wreq
          simple_obj_ref_245_inst_req_0 <= pipe_wreq_872_symbol; -- link to DP
          pipe_wack_873_symbol <= simple_obj_ref_245_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_complete/pipe_wack
          Xexit_871_symbol <= pipe_wack_873_symbol; -- transition branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_complete/$exit
          simple_obj_ref_245_complete_869_symbol <= Xexit_871_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_248/simple_obj_ref_245_complete
        Xexit_865_symbol <= assign_stmt_248_completed_x_x867_symbol; -- transition branch_block_stmt_237/assign_stmt_248/$exit
        assign_stmt_248_863_symbol <= Xexit_865_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_248
      assign_stmt_253_874: Block -- branch_block_stmt_237/assign_stmt_253 
        signal assign_stmt_253_874_start: Boolean;
        signal Xentry_875_symbol: Boolean;
        signal Xexit_876_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_253_874_start <= assign_stmt_253_x_xentry_x_xx_x841_symbol; -- control passed to block
        Xentry_875_symbol  <= assign_stmt_253_874_start; -- transition branch_block_stmt_237/assign_stmt_253/$entry
        Xexit_876_symbol <= Xentry_875_symbol; -- transition branch_block_stmt_237/assign_stmt_253/$exit
        assign_stmt_253_874_symbol <= Xexit_876_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_253
      assign_stmt_257_877: Block -- branch_block_stmt_237/assign_stmt_257 
        signal assign_stmt_257_877_start: Boolean;
        signal Xentry_878_symbol: Boolean;
        signal Xexit_879_symbol: Boolean;
        signal assign_stmt_257_active_x_x880_symbol : Boolean;
        signal assign_stmt_257_completed_x_x881_symbol : Boolean;
        signal type_cast_256_active_x_x882_symbol : Boolean;
        signal type_cast_256_trigger_x_x883_symbol : Boolean;
        signal simple_obj_ref_255_trigger_x_x884_symbol : Boolean;
        signal simple_obj_ref_255_complete_885_symbol : Boolean;
        signal type_cast_256_complete_890_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_257_877_start <= assign_stmt_257_x_xentry_x_xx_x843_symbol; -- control passed to block
        Xentry_878_symbol  <= assign_stmt_257_877_start; -- transition branch_block_stmt_237/assign_stmt_257/$entry
        assign_stmt_257_active_x_x880_symbol <= type_cast_256_complete_890_symbol; -- transition branch_block_stmt_237/assign_stmt_257/assign_stmt_257_active_
        assign_stmt_257_completed_x_x881_symbol <= assign_stmt_257_active_x_x880_symbol; -- transition branch_block_stmt_237/assign_stmt_257/assign_stmt_257_completed_
        type_cast_256_active_x_x882_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_257/type_cast_256_active_ 
          signal type_cast_256_active_x_x882_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_256_active_x_x882_predecessors(0) <= type_cast_256_trigger_x_x883_symbol;
          type_cast_256_active_x_x882_predecessors(1) <= simple_obj_ref_255_complete_885_symbol;
          type_cast_256_active_x_x882_join: join -- 
            port map( -- 
              preds => type_cast_256_active_x_x882_predecessors,
              symbol_out => type_cast_256_active_x_x882_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_257/type_cast_256_active_
        type_cast_256_trigger_x_x883_symbol <= Xentry_878_symbol; -- transition branch_block_stmt_237/assign_stmt_257/type_cast_256_trigger_
        simple_obj_ref_255_trigger_x_x884_symbol <= Xentry_878_symbol; -- transition branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_trigger_
        simple_obj_ref_255_complete_885: Block -- branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_complete 
          signal simple_obj_ref_255_complete_885_start: Boolean;
          signal Xentry_886_symbol: Boolean;
          signal Xexit_887_symbol: Boolean;
          signal req_888_symbol : Boolean;
          signal ack_889_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_255_complete_885_start <= simple_obj_ref_255_trigger_x_x884_symbol; -- control passed to block
          Xentry_886_symbol  <= simple_obj_ref_255_complete_885_start; -- transition branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_complete/$entry
          req_888_symbol <= Xentry_886_symbol; -- transition branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_complete/req
          simple_obj_ref_255_inst_req_0 <= req_888_symbol; -- link to DP
          ack_889_symbol <= simple_obj_ref_255_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_complete/ack
          Xexit_887_symbol <= ack_889_symbol; -- transition branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_complete/$exit
          simple_obj_ref_255_complete_885_symbol <= Xexit_887_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_257/simple_obj_ref_255_complete
        type_cast_256_complete_890: Block -- branch_block_stmt_237/assign_stmt_257/type_cast_256_complete 
          signal type_cast_256_complete_890_start: Boolean;
          signal Xentry_891_symbol: Boolean;
          signal Xexit_892_symbol: Boolean;
          signal req_893_symbol : Boolean;
          signal ack_894_symbol : Boolean;
          -- 
        begin -- 
          type_cast_256_complete_890_start <= type_cast_256_active_x_x882_symbol; -- control passed to block
          Xentry_891_symbol  <= type_cast_256_complete_890_start; -- transition branch_block_stmt_237/assign_stmt_257/type_cast_256_complete/$entry
          req_893_symbol <= Xentry_891_symbol; -- transition branch_block_stmt_237/assign_stmt_257/type_cast_256_complete/req
          type_cast_256_inst_req_0 <= req_893_symbol; -- link to DP
          ack_894_symbol <= type_cast_256_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_257/type_cast_256_complete/ack
          Xexit_892_symbol <= ack_894_symbol; -- transition branch_block_stmt_237/assign_stmt_257/type_cast_256_complete/$exit
          type_cast_256_complete_890_symbol <= Xexit_892_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_257/type_cast_256_complete
        Xexit_879_symbol <= assign_stmt_257_completed_x_x881_symbol; -- transition branch_block_stmt_237/assign_stmt_257/$exit
        assign_stmt_257_877_symbol <= Xexit_879_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_257
      assign_stmt_262_895: Block -- branch_block_stmt_237/assign_stmt_262 
        signal assign_stmt_262_895_start: Boolean;
        signal Xentry_896_symbol: Boolean;
        signal Xexit_897_symbol: Boolean;
        signal assign_stmt_262_active_x_x898_symbol : Boolean;
        signal assign_stmt_262_completed_x_x899_symbol : Boolean;
        signal binary_261_active_x_x900_symbol : Boolean;
        signal binary_261_trigger_x_x901_symbol : Boolean;
        signal simple_obj_ref_259_complete_902_symbol : Boolean;
        signal binary_261_complete_903_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_262_895_start <= assign_stmt_262_x_xentry_x_xx_x845_symbol; -- control passed to block
        Xentry_896_symbol  <= assign_stmt_262_895_start; -- transition branch_block_stmt_237/assign_stmt_262/$entry
        assign_stmt_262_active_x_x898_symbol <= binary_261_complete_903_symbol; -- transition branch_block_stmt_237/assign_stmt_262/assign_stmt_262_active_
        assign_stmt_262_completed_x_x899_symbol <= assign_stmt_262_active_x_x898_symbol; -- transition branch_block_stmt_237/assign_stmt_262/assign_stmt_262_completed_
        binary_261_active_x_x900_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_262/binary_261_active_ 
          signal binary_261_active_x_x900_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_261_active_x_x900_predecessors(0) <= binary_261_trigger_x_x901_symbol;
          binary_261_active_x_x900_predecessors(1) <= simple_obj_ref_259_complete_902_symbol;
          binary_261_active_x_x900_join: join -- 
            port map( -- 
              preds => binary_261_active_x_x900_predecessors,
              symbol_out => binary_261_active_x_x900_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_262/binary_261_active_
        binary_261_trigger_x_x901_symbol <= Xentry_896_symbol; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_trigger_
        simple_obj_ref_259_complete_902_symbol <= Xentry_896_symbol; -- transition branch_block_stmt_237/assign_stmt_262/simple_obj_ref_259_complete
        binary_261_complete_903: Block -- branch_block_stmt_237/assign_stmt_262/binary_261_complete 
          signal binary_261_complete_903_start: Boolean;
          signal Xentry_904_symbol: Boolean;
          signal Xexit_905_symbol: Boolean;
          signal rr_906_symbol : Boolean;
          signal ra_907_symbol : Boolean;
          signal cr_908_symbol : Boolean;
          signal ca_909_symbol : Boolean;
          -- 
        begin -- 
          binary_261_complete_903_start <= binary_261_active_x_x900_symbol; -- control passed to block
          Xentry_904_symbol  <= binary_261_complete_903_start; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_complete/$entry
          rr_906_symbol <= Xentry_904_symbol; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_complete/rr
          binary_261_inst_req_0 <= rr_906_symbol; -- link to DP
          ra_907_symbol <= binary_261_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_complete/ra
          cr_908_symbol <= ra_907_symbol; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_complete/cr
          binary_261_inst_req_1 <= cr_908_symbol; -- link to DP
          ca_909_symbol <= binary_261_inst_ack_1; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_complete/ca
          Xexit_905_symbol <= ca_909_symbol; -- transition branch_block_stmt_237/assign_stmt_262/binary_261_complete/$exit
          binary_261_complete_903_symbol <= Xexit_905_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_262/binary_261_complete
        Xexit_897_symbol <= assign_stmt_262_completed_x_x899_symbol; -- transition branch_block_stmt_237/assign_stmt_262/$exit
        assign_stmt_262_895_symbol <= Xexit_897_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_262
      if_stmt_263_dead_link_910: Block -- branch_block_stmt_237/if_stmt_263_dead_link 
        signal if_stmt_263_dead_link_910_start: Boolean;
        signal Xentry_911_symbol: Boolean;
        signal Xexit_912_symbol: Boolean;
        signal dead_transition_913_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_263_dead_link_910_start <= if_stmt_263_x_xentry_x_xx_x847_symbol; -- control passed to block
        Xentry_911_symbol  <= if_stmt_263_dead_link_910_start; -- transition branch_block_stmt_237/if_stmt_263_dead_link/$entry
        dead_transition_913_symbol <= false;
        Xexit_912_symbol <= dead_transition_913_symbol; -- transition branch_block_stmt_237/if_stmt_263_dead_link/$exit
        if_stmt_263_dead_link_910_symbol <= Xexit_912_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/if_stmt_263_dead_link
      if_stmt_263_eval_test_914: Block -- branch_block_stmt_237/if_stmt_263_eval_test 
        signal if_stmt_263_eval_test_914_start: Boolean;
        signal Xentry_915_symbol: Boolean;
        signal Xexit_916_symbol: Boolean;
        signal branch_req_917_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_263_eval_test_914_start <= if_stmt_263_x_xentry_x_xx_x847_symbol; -- control passed to block
        Xentry_915_symbol  <= if_stmt_263_eval_test_914_start; -- transition branch_block_stmt_237/if_stmt_263_eval_test/$entry
        branch_req_917_symbol <= Xentry_915_symbol; -- transition branch_block_stmt_237/if_stmt_263_eval_test/branch_req
        if_stmt_263_branch_req_0 <= branch_req_917_symbol; -- link to DP
        Xexit_916_symbol <= branch_req_917_symbol; -- transition branch_block_stmt_237/if_stmt_263_eval_test/$exit
        if_stmt_263_eval_test_914_symbol <= Xexit_916_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/if_stmt_263_eval_test
      simple_obj_ref_264_place_918_symbol  <=  if_stmt_263_eval_test_914_symbol; -- place branch_block_stmt_237/simple_obj_ref_264_place (optimized away) 
      if_stmt_263_if_link_919: Block -- branch_block_stmt_237/if_stmt_263_if_link 
        signal if_stmt_263_if_link_919_start: Boolean;
        signal Xentry_920_symbol: Boolean;
        signal Xexit_921_symbol: Boolean;
        signal if_choice_transition_922_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_263_if_link_919_start <= simple_obj_ref_264_place_918_symbol; -- control passed to block
        Xentry_920_symbol  <= if_stmt_263_if_link_919_start; -- transition branch_block_stmt_237/if_stmt_263_if_link/$entry
        if_choice_transition_922_symbol <= if_stmt_263_branch_ack_1; -- transition branch_block_stmt_237/if_stmt_263_if_link/if_choice_transition
        Xexit_921_symbol <= if_choice_transition_922_symbol; -- transition branch_block_stmt_237/if_stmt_263_if_link/$exit
        if_stmt_263_if_link_919_symbol <= Xexit_921_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/if_stmt_263_if_link
      if_stmt_263_else_link_923: Block -- branch_block_stmt_237/if_stmt_263_else_link 
        signal if_stmt_263_else_link_923_start: Boolean;
        signal Xentry_924_symbol: Boolean;
        signal Xexit_925_symbol: Boolean;
        signal else_choice_transition_926_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_263_else_link_923_start <= simple_obj_ref_264_place_918_symbol; -- control passed to block
        Xentry_924_symbol  <= if_stmt_263_else_link_923_start; -- transition branch_block_stmt_237/if_stmt_263_else_link/$entry
        else_choice_transition_926_symbol <= if_stmt_263_branch_ack_0; -- transition branch_block_stmt_237/if_stmt_263_else_link/else_choice_transition
        Xexit_925_symbol <= else_choice_transition_926_symbol; -- transition branch_block_stmt_237/if_stmt_263_else_link/$exit
        if_stmt_263_else_link_923_symbol <= Xexit_925_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/if_stmt_263_else_link
      xx_xbackedge_xx_xbackedge_927_symbol  <=  if_stmt_263_if_link_919_symbol; -- place branch_block_stmt_237/xx_xbackedge_xx_xbackedge (optimized away) 
      xx_xbackedge_bb_2_928_symbol  <=  if_stmt_263_else_link_923_symbol; -- place branch_block_stmt_237/xx_xbackedge_bb_2 (optimized away) 
      assign_stmt_274_929: Block -- branch_block_stmt_237/assign_stmt_274 
        signal assign_stmt_274_929_start: Boolean;
        signal Xentry_930_symbol: Boolean;
        signal Xexit_931_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_274_929_start <= assign_stmt_274_x_xentry_x_xx_x851_symbol; -- control passed to block
        Xentry_930_symbol  <= assign_stmt_274_929_start; -- transition branch_block_stmt_237/assign_stmt_274/$entry
        Xexit_931_symbol <= Xentry_930_symbol; -- transition branch_block_stmt_237/assign_stmt_274/$exit
        assign_stmt_274_929_symbol <= Xexit_931_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_274
      assign_stmt_278_932: Block -- branch_block_stmt_237/assign_stmt_278 
        signal assign_stmt_278_932_start: Boolean;
        signal Xentry_933_symbol: Boolean;
        signal Xexit_934_symbol: Boolean;
        signal assign_stmt_278_active_x_x935_symbol : Boolean;
        signal assign_stmt_278_completed_x_x936_symbol : Boolean;
        signal type_cast_277_active_x_x937_symbol : Boolean;
        signal type_cast_277_trigger_x_x938_symbol : Boolean;
        signal simple_obj_ref_276_trigger_x_x939_symbol : Boolean;
        signal simple_obj_ref_276_complete_940_symbol : Boolean;
        signal type_cast_277_complete_945_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_278_932_start <= assign_stmt_278_x_xentry_x_xx_x853_symbol; -- control passed to block
        Xentry_933_symbol  <= assign_stmt_278_932_start; -- transition branch_block_stmt_237/assign_stmt_278/$entry
        assign_stmt_278_active_x_x935_symbol <= type_cast_277_complete_945_symbol; -- transition branch_block_stmt_237/assign_stmt_278/assign_stmt_278_active_
        assign_stmt_278_completed_x_x936_symbol <= assign_stmt_278_active_x_x935_symbol; -- transition branch_block_stmt_237/assign_stmt_278/assign_stmt_278_completed_
        type_cast_277_active_x_x937_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_278/type_cast_277_active_ 
          signal type_cast_277_active_x_x937_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_277_active_x_x937_predecessors(0) <= type_cast_277_trigger_x_x938_symbol;
          type_cast_277_active_x_x937_predecessors(1) <= simple_obj_ref_276_complete_940_symbol;
          type_cast_277_active_x_x937_join: join -- 
            port map( -- 
              preds => type_cast_277_active_x_x937_predecessors,
              symbol_out => type_cast_277_active_x_x937_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_278/type_cast_277_active_
        type_cast_277_trigger_x_x938_symbol <= Xentry_933_symbol; -- transition branch_block_stmt_237/assign_stmt_278/type_cast_277_trigger_
        simple_obj_ref_276_trigger_x_x939_symbol <= Xentry_933_symbol; -- transition branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_trigger_
        simple_obj_ref_276_complete_940: Block -- branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_complete 
          signal simple_obj_ref_276_complete_940_start: Boolean;
          signal Xentry_941_symbol: Boolean;
          signal Xexit_942_symbol: Boolean;
          signal req_943_symbol : Boolean;
          signal ack_944_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_276_complete_940_start <= simple_obj_ref_276_trigger_x_x939_symbol; -- control passed to block
          Xentry_941_symbol  <= simple_obj_ref_276_complete_940_start; -- transition branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_complete/$entry
          req_943_symbol <= Xentry_941_symbol; -- transition branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_complete/req
          simple_obj_ref_276_inst_req_0 <= req_943_symbol; -- link to DP
          ack_944_symbol <= simple_obj_ref_276_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_complete/ack
          Xexit_942_symbol <= ack_944_symbol; -- transition branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_complete/$exit
          simple_obj_ref_276_complete_940_symbol <= Xexit_942_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_278/simple_obj_ref_276_complete
        type_cast_277_complete_945: Block -- branch_block_stmt_237/assign_stmt_278/type_cast_277_complete 
          signal type_cast_277_complete_945_start: Boolean;
          signal Xentry_946_symbol: Boolean;
          signal Xexit_947_symbol: Boolean;
          signal req_948_symbol : Boolean;
          signal ack_949_symbol : Boolean;
          -- 
        begin -- 
          type_cast_277_complete_945_start <= type_cast_277_active_x_x937_symbol; -- control passed to block
          Xentry_946_symbol  <= type_cast_277_complete_945_start; -- transition branch_block_stmt_237/assign_stmt_278/type_cast_277_complete/$entry
          req_948_symbol <= Xentry_946_symbol; -- transition branch_block_stmt_237/assign_stmt_278/type_cast_277_complete/req
          type_cast_277_inst_req_0 <= req_948_symbol; -- link to DP
          ack_949_symbol <= type_cast_277_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_278/type_cast_277_complete/ack
          Xexit_947_symbol <= ack_949_symbol; -- transition branch_block_stmt_237/assign_stmt_278/type_cast_277_complete/$exit
          type_cast_277_complete_945_symbol <= Xexit_947_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_278/type_cast_277_complete
        Xexit_934_symbol <= assign_stmt_278_completed_x_x936_symbol; -- transition branch_block_stmt_237/assign_stmt_278/$exit
        assign_stmt_278_932_symbol <= Xexit_934_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_278
      assign_stmt_282_to_assign_stmt_295_950: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295 
        signal assign_stmt_282_to_assign_stmt_295_950_start: Boolean;
        signal Xentry_951_symbol: Boolean;
        signal Xexit_952_symbol: Boolean;
        signal assign_stmt_282_active_x_x953_symbol : Boolean;
        signal assign_stmt_282_completed_x_x954_symbol : Boolean;
        signal array_obj_ref_281_trigger_x_x955_symbol : Boolean;
        signal array_obj_ref_281_active_x_x956_symbol : Boolean;
        signal array_obj_ref_281_base_address_calculated_957_symbol : Boolean;
        signal array_obj_ref_281_root_address_calculated_958_symbol : Boolean;
        signal array_obj_ref_281_base_address_resized_959_symbol : Boolean;
        signal array_obj_ref_281_base_addr_resize_960_symbol : Boolean;
        signal array_obj_ref_281_base_plus_offset_965_symbol : Boolean;
        signal array_obj_ref_281_complete_970_symbol : Boolean;
        signal assign_stmt_286_active_x_x975_symbol : Boolean;
        signal assign_stmt_286_completed_x_x976_symbol : Boolean;
        signal type_cast_285_active_x_x977_symbol : Boolean;
        signal type_cast_285_trigger_x_x978_symbol : Boolean;
        signal simple_obj_ref_284_complete_979_symbol : Boolean;
        signal type_cast_285_complete_980_symbol : Boolean;
        signal assign_stmt_290_active_x_x985_symbol : Boolean;
        signal assign_stmt_290_completed_x_x986_symbol : Boolean;
        signal simple_obj_ref_289_complete_987_symbol : Boolean;
        signal ptr_deref_288_trigger_x_x988_symbol : Boolean;
        signal ptr_deref_288_active_x_x989_symbol : Boolean;
        signal ptr_deref_288_base_address_calculated_990_symbol : Boolean;
        signal simple_obj_ref_287_complete_991_symbol : Boolean;
        signal ptr_deref_288_root_address_calculated_992_symbol : Boolean;
        signal ptr_deref_288_word_address_calculated_993_symbol : Boolean;
        signal ptr_deref_288_base_address_resized_994_symbol : Boolean;
        signal ptr_deref_288_base_addr_resize_995_symbol : Boolean;
        signal ptr_deref_288_base_plus_offset_1000_symbol : Boolean;
        signal ptr_deref_288_word_addrgen_1005_symbol : Boolean;
        signal ptr_deref_288_request_1010_symbol : Boolean;
        signal ptr_deref_288_complete_1023_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_282_to_assign_stmt_295_950_start <= assign_stmt_282_to_assign_stmt_295_x_xentry_x_xx_x855_symbol; -- control passed to block
        Xentry_951_symbol  <= assign_stmt_282_to_assign_stmt_295_950_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/$entry
        assign_stmt_282_active_x_x953_symbol <= array_obj_ref_281_complete_970_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/assign_stmt_282_active_
        assign_stmt_282_completed_x_x954_symbol <= assign_stmt_282_active_x_x953_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/assign_stmt_282_completed_
        array_obj_ref_281_trigger_x_x955_symbol <= Xentry_951_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_trigger_
        array_obj_ref_281_active_x_x956_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_active_ 
          signal array_obj_ref_281_active_x_x956_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          array_obj_ref_281_active_x_x956_predecessors(0) <= array_obj_ref_281_trigger_x_x955_symbol;
          array_obj_ref_281_active_x_x956_predecessors(1) <= array_obj_ref_281_root_address_calculated_958_symbol;
          array_obj_ref_281_active_x_x956_join: join -- 
            port map( -- 
              preds => array_obj_ref_281_active_x_x956_predecessors,
              symbol_out => array_obj_ref_281_active_x_x956_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_active_
        array_obj_ref_281_base_address_calculated_957_symbol <= Xentry_951_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_address_calculated
        array_obj_ref_281_root_address_calculated_958_symbol <= array_obj_ref_281_base_plus_offset_965_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_root_address_calculated
        array_obj_ref_281_base_address_resized_959_symbol <= array_obj_ref_281_base_addr_resize_960_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_address_resized
        array_obj_ref_281_base_addr_resize_960: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_addr_resize 
          signal array_obj_ref_281_base_addr_resize_960_start: Boolean;
          signal Xentry_961_symbol: Boolean;
          signal Xexit_962_symbol: Boolean;
          signal base_resize_req_963_symbol : Boolean;
          signal base_resize_ack_964_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_281_base_addr_resize_960_start <= array_obj_ref_281_base_address_calculated_957_symbol; -- control passed to block
          Xentry_961_symbol  <= array_obj_ref_281_base_addr_resize_960_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_addr_resize/$entry
          base_resize_req_963_symbol <= Xentry_961_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_addr_resize/base_resize_req
          array_obj_ref_281_base_resize_req_0 <= base_resize_req_963_symbol; -- link to DP
          base_resize_ack_964_symbol <= array_obj_ref_281_base_resize_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_addr_resize/base_resize_ack
          Xexit_962_symbol <= base_resize_ack_964_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_addr_resize/$exit
          array_obj_ref_281_base_addr_resize_960_symbol <= Xexit_962_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_addr_resize
        array_obj_ref_281_base_plus_offset_965: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_plus_offset 
          signal array_obj_ref_281_base_plus_offset_965_start: Boolean;
          signal Xentry_966_symbol: Boolean;
          signal Xexit_967_symbol: Boolean;
          signal sum_rename_req_968_symbol : Boolean;
          signal sum_rename_ack_969_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_281_base_plus_offset_965_start <= array_obj_ref_281_base_address_resized_959_symbol; -- control passed to block
          Xentry_966_symbol  <= array_obj_ref_281_base_plus_offset_965_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_plus_offset/$entry
          sum_rename_req_968_symbol <= Xentry_966_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_plus_offset/sum_rename_req
          array_obj_ref_281_root_address_inst_req_0 <= sum_rename_req_968_symbol; -- link to DP
          sum_rename_ack_969_symbol <= array_obj_ref_281_root_address_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_plus_offset/sum_rename_ack
          Xexit_967_symbol <= sum_rename_ack_969_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_plus_offset/$exit
          array_obj_ref_281_base_plus_offset_965_symbol <= Xexit_967_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_base_plus_offset
        array_obj_ref_281_complete_970: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_complete 
          signal array_obj_ref_281_complete_970_start: Boolean;
          signal Xentry_971_symbol: Boolean;
          signal Xexit_972_symbol: Boolean;
          signal final_reg_req_973_symbol : Boolean;
          signal final_reg_ack_974_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_281_complete_970_start <= array_obj_ref_281_active_x_x956_symbol; -- control passed to block
          Xentry_971_symbol  <= array_obj_ref_281_complete_970_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_complete/$entry
          final_reg_req_973_symbol <= Xentry_971_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_complete/final_reg_req
          array_obj_ref_281_final_reg_req_0 <= final_reg_req_973_symbol; -- link to DP
          final_reg_ack_974_symbol <= array_obj_ref_281_final_reg_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_complete/final_reg_ack
          Xexit_972_symbol <= final_reg_ack_974_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_complete/$exit
          array_obj_ref_281_complete_970_symbol <= Xexit_972_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/array_obj_ref_281_complete
        assign_stmt_286_active_x_x975_symbol <= type_cast_285_complete_980_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/assign_stmt_286_active_
        assign_stmt_286_completed_x_x976_symbol <= assign_stmt_286_active_x_x975_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/assign_stmt_286_completed_
        type_cast_285_active_x_x977_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_active_ 
          signal type_cast_285_active_x_x977_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_285_active_x_x977_predecessors(0) <= type_cast_285_trigger_x_x978_symbol;
          type_cast_285_active_x_x977_predecessors(1) <= simple_obj_ref_284_complete_979_symbol;
          type_cast_285_active_x_x977_join: join -- 
            port map( -- 
              preds => type_cast_285_active_x_x977_predecessors,
              symbol_out => type_cast_285_active_x_x977_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_active_
        type_cast_285_trigger_x_x978_symbol <= Xentry_951_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_trigger_
        simple_obj_ref_284_complete_979_symbol <= assign_stmt_282_completed_x_x954_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/simple_obj_ref_284_complete
        type_cast_285_complete_980: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_complete 
          signal type_cast_285_complete_980_start: Boolean;
          signal Xentry_981_symbol: Boolean;
          signal Xexit_982_symbol: Boolean;
          signal req_983_symbol : Boolean;
          signal ack_984_symbol : Boolean;
          -- 
        begin -- 
          type_cast_285_complete_980_start <= type_cast_285_active_x_x977_symbol; -- control passed to block
          Xentry_981_symbol  <= type_cast_285_complete_980_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_complete/$entry
          req_983_symbol <= Xentry_981_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_complete/req
          type_cast_285_inst_req_0 <= req_983_symbol; -- link to DP
          ack_984_symbol <= type_cast_285_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_complete/ack
          Xexit_982_symbol <= ack_984_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_complete/$exit
          type_cast_285_complete_980_symbol <= Xexit_982_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/type_cast_285_complete
        assign_stmt_290_active_x_x985_symbol <= simple_obj_ref_289_complete_987_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/assign_stmt_290_active_
        assign_stmt_290_completed_x_x986_symbol <= ptr_deref_288_complete_1023_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/assign_stmt_290_completed_
        simple_obj_ref_289_complete_987_symbol <= Xentry_951_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/simple_obj_ref_289_complete
        ptr_deref_288_trigger_x_x988_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_trigger_ 
          signal ptr_deref_288_trigger_x_x988_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_288_trigger_x_x988_predecessors(0) <= ptr_deref_288_word_address_calculated_993_symbol;
          ptr_deref_288_trigger_x_x988_predecessors(1) <= ptr_deref_288_base_address_calculated_990_symbol;
          ptr_deref_288_trigger_x_x988_predecessors(2) <= assign_stmt_290_active_x_x985_symbol;
          ptr_deref_288_trigger_x_x988_join: join -- 
            port map( -- 
              preds => ptr_deref_288_trigger_x_x988_predecessors,
              symbol_out => ptr_deref_288_trigger_x_x988_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_trigger_
        ptr_deref_288_active_x_x989_symbol <= ptr_deref_288_request_1010_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_active_
        ptr_deref_288_base_address_calculated_990_symbol <= simple_obj_ref_287_complete_991_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_address_calculated
        simple_obj_ref_287_complete_991_symbol <= assign_stmt_286_completed_x_x976_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/simple_obj_ref_287_complete
        ptr_deref_288_root_address_calculated_992_symbol <= ptr_deref_288_base_plus_offset_1000_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_root_address_calculated
        ptr_deref_288_word_address_calculated_993_symbol <= ptr_deref_288_word_addrgen_1005_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_address_calculated
        ptr_deref_288_base_address_resized_994_symbol <= ptr_deref_288_base_addr_resize_995_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_address_resized
        ptr_deref_288_base_addr_resize_995: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_addr_resize 
          signal ptr_deref_288_base_addr_resize_995_start: Boolean;
          signal Xentry_996_symbol: Boolean;
          signal Xexit_997_symbol: Boolean;
          signal base_resize_req_998_symbol : Boolean;
          signal base_resize_ack_999_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_288_base_addr_resize_995_start <= ptr_deref_288_base_address_calculated_990_symbol; -- control passed to block
          Xentry_996_symbol  <= ptr_deref_288_base_addr_resize_995_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_addr_resize/$entry
          base_resize_req_998_symbol <= Xentry_996_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_addr_resize/base_resize_req
          ptr_deref_288_base_resize_req_0 <= base_resize_req_998_symbol; -- link to DP
          base_resize_ack_999_symbol <= ptr_deref_288_base_resize_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_addr_resize/base_resize_ack
          Xexit_997_symbol <= base_resize_ack_999_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_addr_resize/$exit
          ptr_deref_288_base_addr_resize_995_symbol <= Xexit_997_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_addr_resize
        ptr_deref_288_base_plus_offset_1000: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_plus_offset 
          signal ptr_deref_288_base_plus_offset_1000_start: Boolean;
          signal Xentry_1001_symbol: Boolean;
          signal Xexit_1002_symbol: Boolean;
          signal sum_rename_req_1003_symbol : Boolean;
          signal sum_rename_ack_1004_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_288_base_plus_offset_1000_start <= ptr_deref_288_base_address_resized_994_symbol; -- control passed to block
          Xentry_1001_symbol  <= ptr_deref_288_base_plus_offset_1000_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_plus_offset/$entry
          sum_rename_req_1003_symbol <= Xentry_1001_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_plus_offset/sum_rename_req
          ptr_deref_288_root_address_inst_req_0 <= sum_rename_req_1003_symbol; -- link to DP
          sum_rename_ack_1004_symbol <= ptr_deref_288_root_address_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_plus_offset/sum_rename_ack
          Xexit_1002_symbol <= sum_rename_ack_1004_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_plus_offset/$exit
          ptr_deref_288_base_plus_offset_1000_symbol <= Xexit_1002_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_base_plus_offset
        ptr_deref_288_word_addrgen_1005: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_addrgen 
          signal ptr_deref_288_word_addrgen_1005_start: Boolean;
          signal Xentry_1006_symbol: Boolean;
          signal Xexit_1007_symbol: Boolean;
          signal root_rename_req_1008_symbol : Boolean;
          signal root_rename_ack_1009_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_288_word_addrgen_1005_start <= ptr_deref_288_root_address_calculated_992_symbol; -- control passed to block
          Xentry_1006_symbol  <= ptr_deref_288_word_addrgen_1005_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_addrgen/$entry
          root_rename_req_1008_symbol <= Xentry_1006_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_addrgen/root_rename_req
          ptr_deref_288_addr_0_req_0 <= root_rename_req_1008_symbol; -- link to DP
          root_rename_ack_1009_symbol <= ptr_deref_288_addr_0_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_addrgen/root_rename_ack
          Xexit_1007_symbol <= root_rename_ack_1009_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_addrgen/$exit
          ptr_deref_288_word_addrgen_1005_symbol <= Xexit_1007_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_word_addrgen
        ptr_deref_288_request_1010: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request 
          signal ptr_deref_288_request_1010_start: Boolean;
          signal Xentry_1011_symbol: Boolean;
          signal Xexit_1012_symbol: Boolean;
          signal split_req_1013_symbol : Boolean;
          signal split_ack_1014_symbol : Boolean;
          signal word_access_1015_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_288_request_1010_start <= ptr_deref_288_trigger_x_x988_symbol; -- control passed to block
          Xentry_1011_symbol  <= ptr_deref_288_request_1010_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/$entry
          split_req_1013_symbol <= Xentry_1011_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/split_req
          ptr_deref_288_gather_scatter_req_0 <= split_req_1013_symbol; -- link to DP
          split_ack_1014_symbol <= ptr_deref_288_gather_scatter_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/split_ack
          word_access_1015: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access 
            signal word_access_1015_start: Boolean;
            signal Xentry_1016_symbol: Boolean;
            signal Xexit_1017_symbol: Boolean;
            signal word_access_0_1018_symbol : Boolean;
            -- 
          begin -- 
            word_access_1015_start <= split_ack_1014_symbol; -- control passed to block
            Xentry_1016_symbol  <= word_access_1015_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/$entry
            word_access_0_1018: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/word_access_0 
              signal word_access_0_1018_start: Boolean;
              signal Xentry_1019_symbol: Boolean;
              signal Xexit_1020_symbol: Boolean;
              signal rr_1021_symbol : Boolean;
              signal ra_1022_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1018_start <= Xentry_1016_symbol; -- control passed to block
              Xentry_1019_symbol  <= word_access_0_1018_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/word_access_0/$entry
              rr_1021_symbol <= Xentry_1019_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/word_access_0/rr
              ptr_deref_288_store_0_req_0 <= rr_1021_symbol; -- link to DP
              ra_1022_symbol <= ptr_deref_288_store_0_ack_0; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/word_access_0/ra
              Xexit_1020_symbol <= ra_1022_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/word_access_0/$exit
              word_access_0_1018_symbol <= Xexit_1020_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/word_access_0
            Xexit_1017_symbol <= word_access_0_1018_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access/$exit
            word_access_1015_symbol <= Xexit_1017_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/word_access
          Xexit_1012_symbol <= word_access_1015_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request/$exit
          ptr_deref_288_request_1010_symbol <= Xexit_1012_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_request
        ptr_deref_288_complete_1023: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete 
          signal ptr_deref_288_complete_1023_start: Boolean;
          signal Xentry_1024_symbol: Boolean;
          signal Xexit_1025_symbol: Boolean;
          signal word_access_1026_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_288_complete_1023_start <= ptr_deref_288_active_x_x989_symbol; -- control passed to block
          Xentry_1024_symbol  <= ptr_deref_288_complete_1023_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/$entry
          word_access_1026: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access 
            signal word_access_1026_start: Boolean;
            signal Xentry_1027_symbol: Boolean;
            signal Xexit_1028_symbol: Boolean;
            signal word_access_0_1029_symbol : Boolean;
            -- 
          begin -- 
            word_access_1026_start <= Xentry_1024_symbol; -- control passed to block
            Xentry_1027_symbol  <= word_access_1026_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/$entry
            word_access_0_1029: Block -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/word_access_0 
              signal word_access_0_1029_start: Boolean;
              signal Xentry_1030_symbol: Boolean;
              signal Xexit_1031_symbol: Boolean;
              signal cr_1032_symbol : Boolean;
              signal ca_1033_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1029_start <= Xentry_1027_symbol; -- control passed to block
              Xentry_1030_symbol  <= word_access_0_1029_start; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/word_access_0/$entry
              cr_1032_symbol <= Xentry_1030_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/word_access_0/cr
              ptr_deref_288_store_0_req_1 <= cr_1032_symbol; -- link to DP
              ca_1033_symbol <= ptr_deref_288_store_0_ack_1; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/word_access_0/ca
              Xexit_1031_symbol <= ca_1033_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/word_access_0/$exit
              word_access_0_1029_symbol <= Xexit_1031_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/word_access_0
            Xexit_1028_symbol <= word_access_0_1029_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access/$exit
            word_access_1026_symbol <= Xexit_1028_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/word_access
          Xexit_1025_symbol <= word_access_1026_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete/$exit
          ptr_deref_288_complete_1023_symbol <= Xexit_1025_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/ptr_deref_288_complete
        Xexit_952_symbol <= assign_stmt_290_completed_x_x986_symbol; -- transition branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295/$exit
        assign_stmt_282_to_assign_stmt_295_950_symbol <= Xexit_952_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_282_to_assign_stmt_295
      assign_stmt_299_1034: Block -- branch_block_stmt_237/assign_stmt_299 
        signal assign_stmt_299_1034_start: Boolean;
        signal Xentry_1035_symbol: Boolean;
        signal Xexit_1036_symbol: Boolean;
        signal assign_stmt_299_active_x_x1037_symbol : Boolean;
        signal assign_stmt_299_completed_x_x1038_symbol : Boolean;
        signal type_cast_298_active_x_x1039_symbol : Boolean;
        signal type_cast_298_trigger_x_x1040_symbol : Boolean;
        signal simple_obj_ref_297_complete_1041_symbol : Boolean;
        signal type_cast_298_complete_1042_symbol : Boolean;
        signal simple_obj_ref_296_trigger_x_x1047_symbol : Boolean;
        signal simple_obj_ref_296_complete_1048_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_299_1034_start <= assign_stmt_299_x_xentry_x_xx_x857_symbol; -- control passed to block
        Xentry_1035_symbol  <= assign_stmt_299_1034_start; -- transition branch_block_stmt_237/assign_stmt_299/$entry
        assign_stmt_299_active_x_x1037_symbol <= type_cast_298_complete_1042_symbol; -- transition branch_block_stmt_237/assign_stmt_299/assign_stmt_299_active_
        assign_stmt_299_completed_x_x1038_symbol <= simple_obj_ref_296_complete_1048_symbol; -- transition branch_block_stmt_237/assign_stmt_299/assign_stmt_299_completed_
        type_cast_298_active_x_x1039_block : Block -- non-trivial join transition branch_block_stmt_237/assign_stmt_299/type_cast_298_active_ 
          signal type_cast_298_active_x_x1039_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_298_active_x_x1039_predecessors(0) <= type_cast_298_trigger_x_x1040_symbol;
          type_cast_298_active_x_x1039_predecessors(1) <= simple_obj_ref_297_complete_1041_symbol;
          type_cast_298_active_x_x1039_join: join -- 
            port map( -- 
              preds => type_cast_298_active_x_x1039_predecessors,
              symbol_out => type_cast_298_active_x_x1039_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_237/assign_stmt_299/type_cast_298_active_
        type_cast_298_trigger_x_x1040_symbol <= Xentry_1035_symbol; -- transition branch_block_stmt_237/assign_stmt_299/type_cast_298_trigger_
        simple_obj_ref_297_complete_1041_symbol <= Xentry_1035_symbol; -- transition branch_block_stmt_237/assign_stmt_299/simple_obj_ref_297_complete
        type_cast_298_complete_1042: Block -- branch_block_stmt_237/assign_stmt_299/type_cast_298_complete 
          signal type_cast_298_complete_1042_start: Boolean;
          signal Xentry_1043_symbol: Boolean;
          signal Xexit_1044_symbol: Boolean;
          signal req_1045_symbol : Boolean;
          signal ack_1046_symbol : Boolean;
          -- 
        begin -- 
          type_cast_298_complete_1042_start <= type_cast_298_active_x_x1039_symbol; -- control passed to block
          Xentry_1043_symbol  <= type_cast_298_complete_1042_start; -- transition branch_block_stmt_237/assign_stmt_299/type_cast_298_complete/$entry
          req_1045_symbol <= Xentry_1043_symbol; -- transition branch_block_stmt_237/assign_stmt_299/type_cast_298_complete/req
          type_cast_298_inst_req_0 <= req_1045_symbol; -- link to DP
          ack_1046_symbol <= type_cast_298_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_299/type_cast_298_complete/ack
          Xexit_1044_symbol <= ack_1046_symbol; -- transition branch_block_stmt_237/assign_stmt_299/type_cast_298_complete/$exit
          type_cast_298_complete_1042_symbol <= Xexit_1044_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_299/type_cast_298_complete
        simple_obj_ref_296_trigger_x_x1047_symbol <= assign_stmt_299_active_x_x1037_symbol; -- transition branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_trigger_
        simple_obj_ref_296_complete_1048: Block -- branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_complete 
          signal simple_obj_ref_296_complete_1048_start: Boolean;
          signal Xentry_1049_symbol: Boolean;
          signal Xexit_1050_symbol: Boolean;
          signal pipe_wreq_1051_symbol : Boolean;
          signal pipe_wack_1052_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_296_complete_1048_start <= simple_obj_ref_296_trigger_x_x1047_symbol; -- control passed to block
          Xentry_1049_symbol  <= simple_obj_ref_296_complete_1048_start; -- transition branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_complete/$entry
          pipe_wreq_1051_symbol <= Xentry_1049_symbol; -- transition branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_complete/pipe_wreq
          simple_obj_ref_296_inst_req_0 <= pipe_wreq_1051_symbol; -- link to DP
          pipe_wack_1052_symbol <= simple_obj_ref_296_inst_ack_0; -- transition branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_complete/pipe_wack
          Xexit_1050_symbol <= pipe_wack_1052_symbol; -- transition branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_complete/$exit
          simple_obj_ref_296_complete_1048_symbol <= Xexit_1050_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_237/assign_stmt_299/simple_obj_ref_296_complete
        Xexit_1036_symbol <= assign_stmt_299_completed_x_x1038_symbol; -- transition branch_block_stmt_237/assign_stmt_299/$exit
        assign_stmt_299_1034_symbol <= Xexit_1036_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/assign_stmt_299
      bb_0_xx_xbackedge_PhiReq_1053: Block -- branch_block_stmt_237/bb_0_xx_xbackedge_PhiReq 
        signal bb_0_xx_xbackedge_PhiReq_1053_start: Boolean;
        signal Xentry_1054_symbol: Boolean;
        signal Xexit_1055_symbol: Boolean;
        -- 
      begin -- 
        bb_0_xx_xbackedge_PhiReq_1053_start <= bb_0_xx_xbackedge_835_symbol; -- control passed to block
        Xentry_1054_symbol  <= bb_0_xx_xbackedge_PhiReq_1053_start; -- transition branch_block_stmt_237/bb_0_xx_xbackedge_PhiReq/$entry
        Xexit_1055_symbol <= Xentry_1054_symbol; -- transition branch_block_stmt_237/bb_0_xx_xbackedge_PhiReq/$exit
        bb_0_xx_xbackedge_PhiReq_1053_symbol <= Xexit_1055_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/bb_0_xx_xbackedge_PhiReq
      bb_2_xx_xbackedge_PhiReq_1056: Block -- branch_block_stmt_237/bb_2_xx_xbackedge_PhiReq 
        signal bb_2_xx_xbackedge_PhiReq_1056_start: Boolean;
        signal Xentry_1057_symbol: Boolean;
        signal Xexit_1058_symbol: Boolean;
        -- 
      begin -- 
        bb_2_xx_xbackedge_PhiReq_1056_start <= bb_2_xx_xbackedge_859_symbol; -- control passed to block
        Xentry_1057_symbol  <= bb_2_xx_xbackedge_PhiReq_1056_start; -- transition branch_block_stmt_237/bb_2_xx_xbackedge_PhiReq/$entry
        Xexit_1058_symbol <= Xentry_1057_symbol; -- transition branch_block_stmt_237/bb_2_xx_xbackedge_PhiReq/$exit
        bb_2_xx_xbackedge_PhiReq_1056_symbol <= Xexit_1058_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/bb_2_xx_xbackedge_PhiReq
      xx_xbackedge_xx_xbackedge_PhiReq_1059: Block -- branch_block_stmt_237/xx_xbackedge_xx_xbackedge_PhiReq 
        signal xx_xbackedge_xx_xbackedge_PhiReq_1059_start: Boolean;
        signal Xentry_1060_symbol: Boolean;
        signal Xexit_1061_symbol: Boolean;
        -- 
      begin -- 
        xx_xbackedge_xx_xbackedge_PhiReq_1059_start <= xx_xbackedge_xx_xbackedge_927_symbol; -- control passed to block
        Xentry_1060_symbol  <= xx_xbackedge_xx_xbackedge_PhiReq_1059_start; -- transition branch_block_stmt_237/xx_xbackedge_xx_xbackedge_PhiReq/$entry
        Xexit_1061_symbol <= Xentry_1060_symbol; -- transition branch_block_stmt_237/xx_xbackedge_xx_xbackedge_PhiReq/$exit
        xx_xbackedge_xx_xbackedge_PhiReq_1059_symbol <= Xexit_1061_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/xx_xbackedge_xx_xbackedge_PhiReq
      merge_stmt_239_PhiReqMerge_1062_symbol  <=  bb_0_xx_xbackedge_PhiReq_1053_symbol or bb_2_xx_xbackedge_PhiReq_1056_symbol or xx_xbackedge_xx_xbackedge_PhiReq_1059_symbol; -- place branch_block_stmt_237/merge_stmt_239_PhiReqMerge (optimized away) 
      merge_stmt_239_PhiAck_1063: Block -- branch_block_stmt_237/merge_stmt_239_PhiAck 
        signal merge_stmt_239_PhiAck_1063_start: Boolean;
        signal Xentry_1064_symbol: Boolean;
        signal Xexit_1065_symbol: Boolean;
        signal dummy_1066_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_239_PhiAck_1063_start <= merge_stmt_239_PhiReqMerge_1062_symbol; -- control passed to block
        Xentry_1064_symbol  <= merge_stmt_239_PhiAck_1063_start; -- transition branch_block_stmt_237/merge_stmt_239_PhiAck/$entry
        dummy_1066_symbol <= Xentry_1064_symbol; -- transition branch_block_stmt_237/merge_stmt_239_PhiAck/dummy
        Xexit_1065_symbol <= dummy_1066_symbol; -- transition branch_block_stmt_237/merge_stmt_239_PhiAck/$exit
        merge_stmt_239_PhiAck_1063_symbol <= Xexit_1065_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/merge_stmt_239_PhiAck
      merge_stmt_269_dead_link_1067: Block -- branch_block_stmt_237/merge_stmt_269_dead_link 
        signal merge_stmt_269_dead_link_1067_start: Boolean;
        signal Xentry_1068_symbol: Boolean;
        signal Xexit_1069_symbol: Boolean;
        signal dead_transition_1070_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_269_dead_link_1067_start <= merge_stmt_269_x_xentry_x_xx_x849_symbol; -- control passed to block
        Xentry_1068_symbol  <= merge_stmt_269_dead_link_1067_start; -- transition branch_block_stmt_237/merge_stmt_269_dead_link/$entry
        dead_transition_1070_symbol <= false;
        Xexit_1069_symbol <= dead_transition_1070_symbol; -- transition branch_block_stmt_237/merge_stmt_269_dead_link/$exit
        merge_stmt_269_dead_link_1067_symbol <= Xexit_1069_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/merge_stmt_269_dead_link
      xx_xbackedge_bb_2_PhiReq_1071: Block -- branch_block_stmt_237/xx_xbackedge_bb_2_PhiReq 
        signal xx_xbackedge_bb_2_PhiReq_1071_start: Boolean;
        signal Xentry_1072_symbol: Boolean;
        signal Xexit_1073_symbol: Boolean;
        -- 
      begin -- 
        xx_xbackedge_bb_2_PhiReq_1071_start <= xx_xbackedge_bb_2_928_symbol; -- control passed to block
        Xentry_1072_symbol  <= xx_xbackedge_bb_2_PhiReq_1071_start; -- transition branch_block_stmt_237/xx_xbackedge_bb_2_PhiReq/$entry
        Xexit_1073_symbol <= Xentry_1072_symbol; -- transition branch_block_stmt_237/xx_xbackedge_bb_2_PhiReq/$exit
        xx_xbackedge_bb_2_PhiReq_1071_symbol <= Xexit_1073_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/xx_xbackedge_bb_2_PhiReq
      merge_stmt_269_PhiReqMerge_1074_symbol  <=  xx_xbackedge_bb_2_PhiReq_1071_symbol; -- place branch_block_stmt_237/merge_stmt_269_PhiReqMerge (optimized away) 
      merge_stmt_269_PhiAck_1075: Block -- branch_block_stmt_237/merge_stmt_269_PhiAck 
        signal merge_stmt_269_PhiAck_1075_start: Boolean;
        signal Xentry_1076_symbol: Boolean;
        signal Xexit_1077_symbol: Boolean;
        signal dummy_1078_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_269_PhiAck_1075_start <= merge_stmt_269_PhiReqMerge_1074_symbol; -- control passed to block
        Xentry_1076_symbol  <= merge_stmt_269_PhiAck_1075_start; -- transition branch_block_stmt_237/merge_stmt_269_PhiAck/$entry
        dummy_1078_symbol <= Xentry_1076_symbol; -- transition branch_block_stmt_237/merge_stmt_269_PhiAck/dummy
        Xexit_1077_symbol <= dummy_1078_symbol; -- transition branch_block_stmt_237/merge_stmt_269_PhiAck/$exit
        merge_stmt_269_PhiAck_1075_symbol <= Xexit_1077_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_237/merge_stmt_269_PhiAck
      Xexit_832_symbol <= branch_block_stmt_237_x_xexit_x_xx_x834_symbol; -- transition branch_block_stmt_237/$exit
      branch_block_stmt_237_830_symbol <= Xexit_832_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_237
    Xexit_829_symbol <= branch_block_stmt_237_830_symbol; -- transition $exit
    fin  <=  '1' when Xexit_829_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_281_resized_base_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_281_root_address : std_logic_vector(2 downto 0);
    signal expr_260_wire_constant : std_logic_vector(31 downto 0);
    signal iNsTr_10_286 : std_logic_vector(31 downto 0);
    signal iNsTr_12_295 : std_logic_vector(31 downto 0);
    signal iNsTr_1_244 : std_logic_vector(31 downto 0);
    signal iNsTr_3_253 : std_logic_vector(31 downto 0);
    signal iNsTr_4_257 : std_logic_vector(31 downto 0);
    signal iNsTr_5_262 : std_logic_vector(0 downto 0);
    signal iNsTr_7_274 : std_logic_vector(31 downto 0);
    signal iNsTr_8_278 : std_logic_vector(31 downto 0);
    signal iNsTr_9_282 : std_logic_vector(31 downto 0);
    signal ptr_deref_288_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_288_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_288_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_288_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_288_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_288_word_offset_0 : std_logic_vector(2 downto 0);
    signal simple_obj_ref_255_wire : std_logic_vector(31 downto 0);
    signal simple_obj_ref_276_wire : std_logic_vector(31 downto 0);
    signal type_cast_247_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_298_wire : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    expr_260_wire_constant <= "00000000000000000000000000000000";
    iNsTr_12_295 <= "00000000000000000000000000000000";
    iNsTr_1_244 <= "00000000000000000000000000000000";
    iNsTr_3_253 <= "00000000000000000000000000000000";
    iNsTr_7_274 <= "00000000000000000000000000000000";
    ptr_deref_288_word_offset_0 <= "000";
    type_cast_247_wire_constant <= "00000010";
    array_obj_ref_281_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_4_257, dout => array_obj_ref_281_resized_base_address, req => array_obj_ref_281_base_resize_req_0, ack => array_obj_ref_281_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_281_final_reg: RegisterBase generic map(in_data_width => 3,out_data_width => 32) -- 
      port map( din => array_obj_ref_281_root_address, dout => iNsTr_9_282, req => array_obj_ref_281_final_reg_req_0, ack => array_obj_ref_281_final_reg_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_288_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_10_286, dout => ptr_deref_288_resized_base_address, req => ptr_deref_288_base_resize_req_0, ack => ptr_deref_288_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_256_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_255_wire, dout => iNsTr_4_257, req => type_cast_256_inst_req_0, ack => type_cast_256_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_277_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_276_wire, dout => iNsTr_8_278, req => type_cast_277_inst_req_0, ack => type_cast_277_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_285_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_9_282, dout => iNsTr_10_286, req => type_cast_285_inst_req_0, ack => type_cast_285_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_298_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_4_257, dout => type_cast_298_wire, req => type_cast_298_inst_req_0, ack => type_cast_298_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_281_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_281_root_address_inst_ack_0 <= array_obj_ref_281_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_281_resized_base_address;
      array_obj_ref_281_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_288_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_288_addr_0_ack_0 <= ptr_deref_288_addr_0_req_0;
      aggregated_sig <= ptr_deref_288_root_address;
      ptr_deref_288_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_288_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_288_gather_scatter_ack_0 <= ptr_deref_288_gather_scatter_req_0;
      aggregated_sig <= iNsTr_8_278;
      ptr_deref_288_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_288_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_288_root_address_inst_ack_0 <= ptr_deref_288_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_288_resized_base_address;
      ptr_deref_288_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    if_stmt_263_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_5_262;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_263_branch_req_0,
          ack0 => if_stmt_263_branch_ack_0,
          ack1 => if_stmt_263_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_261_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_4_257;
      iNsTr_5_262 <= data_out(0 downto 0);
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
          reqL => binary_261_inst_req_0,
          ackL => binary_261_inst_ack_0,
          reqR => binary_261_inst_req_1,
          ackR => binary_261_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared store operator group (0) : ptr_deref_288_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_288_store_0_req_0;
      ptr_deref_288_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_288_store_0_req_1;
      ptr_deref_288_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_288_word_address_0;
      data_in <= ptr_deref_288_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 3,
        data_width => 32,
        num_reqs => 1,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_1_sr_req(0),
          mack => memory_space_1_sr_ack(0),
          maddr => memory_space_1_sr_addr(2 downto 0),
          mdata => memory_space_1_sr_data(31 downto 0),
          mtag => memory_space_1_sr_tag(1 downto 0),
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
          mreq => memory_space_1_sc_req(0),
          mack => memory_space_1_sc_ack(0),
          mtag => memory_space_1_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared inport operator group (0) : simple_obj_ref_255_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_255_inst_req_0;
      simple_obj_ref_255_inst_ack_0 <= ack(0);
      simple_obj_ref_255_wire <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => free_queue_get_pipe_read_req(0),
          oack => free_queue_get_pipe_read_ack(0),
          odata => free_queue_get_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared inport operator group (1) : simple_obj_ref_276_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_276_inst_req_0;
      simple_obj_ref_276_inst_ack_0 <= ack(0);
      simple_obj_ref_276_wire <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => input_data_pipe_read_req(0),
          oack => input_data_pipe_read_ack(0),
          odata => input_data_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 1
    -- shared outport operator group (0) : simple_obj_ref_245_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_245_inst_req_0;
      simple_obj_ref_245_inst_ack_0 <= ack(0);
      data_in <= type_cast_247_wire_constant;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => free_queue_request_pipe_write_req(0),
          oack => free_queue_request_pipe_write_ack(0),
          odata => free_queue_request_pipe_write_data(7 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : simple_obj_ref_296_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_296_inst_req_0;
      simple_obj_ref_296_inst_ack_0 <= ack(0);
      data_in <= type_cast_298_wire;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => foo_in_pipe_write_req(0),
          oack => foo_in_pipe_write_ack(0),
          odata => foo_in_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
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
entity mem_load_x_x is -- 
  port ( -- 
    address : in  std_logic_vector(31 downto 0);
    data : out  std_logic_vector(7 downto 0);
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
    memory_space_0_lc_data : in   std_logic_vector(7 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity mem_load_x_x;
architecture Default of mem_load_x_x is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal binary_10_inst_req_0 : boolean;
  signal binary_10_inst_ack_0 : boolean;
  signal binary_10_inst_req_1 : boolean;
  signal binary_10_inst_ack_1 : boolean;
  signal binary_12_inst_req_0 : boolean;
  signal binary_12_inst_ack_0 : boolean;
  signal binary_12_inst_req_1 : boolean;
  signal binary_12_inst_ack_1 : boolean;
  signal array_obj_ref_13_index_0_resize_req_0 : boolean;
  signal array_obj_ref_13_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_13_index_0_rename_req_0 : boolean;
  signal array_obj_ref_13_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_13_offset_inst_req_0 : boolean;
  signal array_obj_ref_13_offset_inst_ack_0 : boolean;
  signal array_obj_ref_13_root_address_inst_req_0 : boolean;
  signal array_obj_ref_13_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_13_addr_0_req_0 : boolean;
  signal array_obj_ref_13_addr_0_ack_0 : boolean;
  signal array_obj_ref_13_load_0_req_0 : boolean;
  signal array_obj_ref_13_load_0_ack_0 : boolean;
  signal array_obj_ref_13_load_0_req_1 : boolean;
  signal array_obj_ref_13_load_0_ack_1 : boolean;
  signal array_obj_ref_13_gather_scatter_req_0 : boolean;
  signal array_obj_ref_13_gather_scatter_ack_0 : boolean;
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
  mem_load_x_xx_xCP_1079: Block -- control-path 
    signal mem_load_x_xx_xCP_1079_start: Boolean;
    signal Xentry_1080_symbol: Boolean;
    signal Xexit_1081_symbol: Boolean;
    signal assign_stmt_14_1082_symbol : Boolean;
    -- 
  begin -- 
    mem_load_x_xx_xCP_1079_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1080_symbol  <= mem_load_x_xx_xCP_1079_start; -- transition $entry
    assign_stmt_14_1082: Block -- assign_stmt_14 
      signal assign_stmt_14_1082_start: Boolean;
      signal Xentry_1083_symbol: Boolean;
      signal Xexit_1084_symbol: Boolean;
      signal assign_stmt_14_active_x_x1085_symbol : Boolean;
      signal assign_stmt_14_completed_x_x1086_symbol : Boolean;
      signal array_obj_ref_13_trigger_x_x1087_symbol : Boolean;
      signal array_obj_ref_13_active_x_x1088_symbol : Boolean;
      signal array_obj_ref_13_root_address_calculated_1089_symbol : Boolean;
      signal array_obj_ref_13_word_address_calculated_1090_symbol : Boolean;
      signal array_obj_ref_13_indices_scaled_1091_symbol : Boolean;
      signal array_obj_ref_13_offset_calculated_1092_symbol : Boolean;
      signal array_obj_ref_13_index_computed_0_1093_symbol : Boolean;
      signal array_obj_ref_13_index_resized_0_1094_symbol : Boolean;
      signal binary_12_active_x_x1095_symbol : Boolean;
      signal binary_12_trigger_x_x1096_symbol : Boolean;
      signal binary_10_active_x_x1097_symbol : Boolean;
      signal binary_10_trigger_x_x1098_symbol : Boolean;
      signal simple_obj_ref_8_complete_1099_symbol : Boolean;
      signal binary_10_complete_1100_symbol : Boolean;
      signal binary_12_complete_1107_symbol : Boolean;
      signal array_obj_ref_13_index_resize_0_1114_symbol : Boolean;
      signal array_obj_ref_13_index_scale_0_1119_symbol : Boolean;
      signal array_obj_ref_13_add_indices_1124_symbol : Boolean;
      signal array_obj_ref_13_base_plus_offset_1129_symbol : Boolean;
      signal array_obj_ref_13_word_addrgen_1134_symbol : Boolean;
      signal array_obj_ref_13_request_1139_symbol : Boolean;
      signal array_obj_ref_13_complete_1150_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_14_1082_start <= Xentry_1080_symbol; -- control passed to block
      Xentry_1083_symbol  <= assign_stmt_14_1082_start; -- transition assign_stmt_14/$entry
      assign_stmt_14_active_x_x1085_symbol <= array_obj_ref_13_complete_1150_symbol; -- transition assign_stmt_14/assign_stmt_14_active_
      assign_stmt_14_completed_x_x1086_symbol <= assign_stmt_14_active_x_x1085_symbol; -- transition assign_stmt_14/assign_stmt_14_completed_
      array_obj_ref_13_trigger_x_x1087_symbol <= array_obj_ref_13_word_address_calculated_1090_symbol; -- transition assign_stmt_14/array_obj_ref_13_trigger_
      array_obj_ref_13_active_x_x1088_symbol <= array_obj_ref_13_request_1139_symbol; -- transition assign_stmt_14/array_obj_ref_13_active_
      array_obj_ref_13_root_address_calculated_1089_symbol <= array_obj_ref_13_base_plus_offset_1129_symbol; -- transition assign_stmt_14/array_obj_ref_13_root_address_calculated
      array_obj_ref_13_word_address_calculated_1090_symbol <= array_obj_ref_13_word_addrgen_1134_symbol; -- transition assign_stmt_14/array_obj_ref_13_word_address_calculated
      array_obj_ref_13_indices_scaled_1091_symbol <= array_obj_ref_13_index_scale_0_1119_symbol; -- transition assign_stmt_14/array_obj_ref_13_indices_scaled
      array_obj_ref_13_offset_calculated_1092_symbol <= array_obj_ref_13_add_indices_1124_symbol; -- transition assign_stmt_14/array_obj_ref_13_offset_calculated
      array_obj_ref_13_index_computed_0_1093_symbol <= binary_12_complete_1107_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_computed_0
      array_obj_ref_13_index_resized_0_1094_symbol <= array_obj_ref_13_index_resize_0_1114_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_resized_0
      binary_12_active_x_x1095_block : Block -- non-trivial join transition assign_stmt_14/binary_12_active_ 
        signal binary_12_active_x_x1095_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_12_active_x_x1095_predecessors(0) <= binary_12_trigger_x_x1096_symbol;
        binary_12_active_x_x1095_predecessors(1) <= binary_10_complete_1100_symbol;
        binary_12_active_x_x1095_join: join -- 
          port map( -- 
            preds => binary_12_active_x_x1095_predecessors,
            symbol_out => binary_12_active_x_x1095_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_14/binary_12_active_
      binary_12_trigger_x_x1096_symbol <= Xentry_1083_symbol; -- transition assign_stmt_14/binary_12_trigger_
      binary_10_active_x_x1097_block : Block -- non-trivial join transition assign_stmt_14/binary_10_active_ 
        signal binary_10_active_x_x1097_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_10_active_x_x1097_predecessors(0) <= binary_10_trigger_x_x1098_symbol;
        binary_10_active_x_x1097_predecessors(1) <= simple_obj_ref_8_complete_1099_symbol;
        binary_10_active_x_x1097_join: join -- 
          port map( -- 
            preds => binary_10_active_x_x1097_predecessors,
            symbol_out => binary_10_active_x_x1097_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_14/binary_10_active_
      binary_10_trigger_x_x1098_symbol <= Xentry_1083_symbol; -- transition assign_stmt_14/binary_10_trigger_
      simple_obj_ref_8_complete_1099_symbol <= Xentry_1083_symbol; -- transition assign_stmt_14/simple_obj_ref_8_complete
      binary_10_complete_1100: Block -- assign_stmt_14/binary_10_complete 
        signal binary_10_complete_1100_start: Boolean;
        signal Xentry_1101_symbol: Boolean;
        signal Xexit_1102_symbol: Boolean;
        signal rr_1103_symbol : Boolean;
        signal ra_1104_symbol : Boolean;
        signal cr_1105_symbol : Boolean;
        signal ca_1106_symbol : Boolean;
        -- 
      begin -- 
        binary_10_complete_1100_start <= binary_10_active_x_x1097_symbol; -- control passed to block
        Xentry_1101_symbol  <= binary_10_complete_1100_start; -- transition assign_stmt_14/binary_10_complete/$entry
        rr_1103_symbol <= Xentry_1101_symbol; -- transition assign_stmt_14/binary_10_complete/rr
        binary_10_inst_req_0 <= rr_1103_symbol; -- link to DP
        ra_1104_symbol <= binary_10_inst_ack_0; -- transition assign_stmt_14/binary_10_complete/ra
        cr_1105_symbol <= ra_1104_symbol; -- transition assign_stmt_14/binary_10_complete/cr
        binary_10_inst_req_1 <= cr_1105_symbol; -- link to DP
        ca_1106_symbol <= binary_10_inst_ack_1; -- transition assign_stmt_14/binary_10_complete/ca
        Xexit_1102_symbol <= ca_1106_symbol; -- transition assign_stmt_14/binary_10_complete/$exit
        binary_10_complete_1100_symbol <= Xexit_1102_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/binary_10_complete
      binary_12_complete_1107: Block -- assign_stmt_14/binary_12_complete 
        signal binary_12_complete_1107_start: Boolean;
        signal Xentry_1108_symbol: Boolean;
        signal Xexit_1109_symbol: Boolean;
        signal rr_1110_symbol : Boolean;
        signal ra_1111_symbol : Boolean;
        signal cr_1112_symbol : Boolean;
        signal ca_1113_symbol : Boolean;
        -- 
      begin -- 
        binary_12_complete_1107_start <= binary_12_active_x_x1095_symbol; -- control passed to block
        Xentry_1108_symbol  <= binary_12_complete_1107_start; -- transition assign_stmt_14/binary_12_complete/$entry
        rr_1110_symbol <= Xentry_1108_symbol; -- transition assign_stmt_14/binary_12_complete/rr
        binary_12_inst_req_0 <= rr_1110_symbol; -- link to DP
        ra_1111_symbol <= binary_12_inst_ack_0; -- transition assign_stmt_14/binary_12_complete/ra
        cr_1112_symbol <= ra_1111_symbol; -- transition assign_stmt_14/binary_12_complete/cr
        binary_12_inst_req_1 <= cr_1112_symbol; -- link to DP
        ca_1113_symbol <= binary_12_inst_ack_1; -- transition assign_stmt_14/binary_12_complete/ca
        Xexit_1109_symbol <= ca_1113_symbol; -- transition assign_stmt_14/binary_12_complete/$exit
        binary_12_complete_1107_symbol <= Xexit_1109_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/binary_12_complete
      array_obj_ref_13_index_resize_0_1114: Block -- assign_stmt_14/array_obj_ref_13_index_resize_0 
        signal array_obj_ref_13_index_resize_0_1114_start: Boolean;
        signal Xentry_1115_symbol: Boolean;
        signal Xexit_1116_symbol: Boolean;
        signal index_resize_req_1117_symbol : Boolean;
        signal index_resize_ack_1118_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_index_resize_0_1114_start <= array_obj_ref_13_index_computed_0_1093_symbol; -- control passed to block
        Xentry_1115_symbol  <= array_obj_ref_13_index_resize_0_1114_start; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/$entry
        index_resize_req_1117_symbol <= Xentry_1115_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/index_resize_req
        array_obj_ref_13_index_0_resize_req_0 <= index_resize_req_1117_symbol; -- link to DP
        index_resize_ack_1118_symbol <= array_obj_ref_13_index_0_resize_ack_0; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/index_resize_ack
        Xexit_1116_symbol <= index_resize_ack_1118_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/$exit
        array_obj_ref_13_index_resize_0_1114_symbol <= Xexit_1116_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_index_resize_0
      array_obj_ref_13_index_scale_0_1119: Block -- assign_stmt_14/array_obj_ref_13_index_scale_0 
        signal array_obj_ref_13_index_scale_0_1119_start: Boolean;
        signal Xentry_1120_symbol: Boolean;
        signal Xexit_1121_symbol: Boolean;
        signal scale_rename_req_1122_symbol : Boolean;
        signal scale_rename_ack_1123_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_index_scale_0_1119_start <= array_obj_ref_13_index_resized_0_1094_symbol; -- control passed to block
        Xentry_1120_symbol  <= array_obj_ref_13_index_scale_0_1119_start; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/$entry
        scale_rename_req_1122_symbol <= Xentry_1120_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/scale_rename_req
        array_obj_ref_13_index_0_rename_req_0 <= scale_rename_req_1122_symbol; -- link to DP
        scale_rename_ack_1123_symbol <= array_obj_ref_13_index_0_rename_ack_0; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/scale_rename_ack
        Xexit_1121_symbol <= scale_rename_ack_1123_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/$exit
        array_obj_ref_13_index_scale_0_1119_symbol <= Xexit_1121_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_index_scale_0
      array_obj_ref_13_add_indices_1124: Block -- assign_stmt_14/array_obj_ref_13_add_indices 
        signal array_obj_ref_13_add_indices_1124_start: Boolean;
        signal Xentry_1125_symbol: Boolean;
        signal Xexit_1126_symbol: Boolean;
        signal final_index_req_1127_symbol : Boolean;
        signal final_index_ack_1128_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_add_indices_1124_start <= array_obj_ref_13_indices_scaled_1091_symbol; -- control passed to block
        Xentry_1125_symbol  <= array_obj_ref_13_add_indices_1124_start; -- transition assign_stmt_14/array_obj_ref_13_add_indices/$entry
        final_index_req_1127_symbol <= Xentry_1125_symbol; -- transition assign_stmt_14/array_obj_ref_13_add_indices/final_index_req
        array_obj_ref_13_offset_inst_req_0 <= final_index_req_1127_symbol; -- link to DP
        final_index_ack_1128_symbol <= array_obj_ref_13_offset_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13_add_indices/final_index_ack
        Xexit_1126_symbol <= final_index_ack_1128_symbol; -- transition assign_stmt_14/array_obj_ref_13_add_indices/$exit
        array_obj_ref_13_add_indices_1124_symbol <= Xexit_1126_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_add_indices
      array_obj_ref_13_base_plus_offset_1129: Block -- assign_stmt_14/array_obj_ref_13_base_plus_offset 
        signal array_obj_ref_13_base_plus_offset_1129_start: Boolean;
        signal Xentry_1130_symbol: Boolean;
        signal Xexit_1131_symbol: Boolean;
        signal sum_rename_req_1132_symbol : Boolean;
        signal sum_rename_ack_1133_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_base_plus_offset_1129_start <= array_obj_ref_13_offset_calculated_1092_symbol; -- control passed to block
        Xentry_1130_symbol  <= array_obj_ref_13_base_plus_offset_1129_start; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/$entry
        sum_rename_req_1132_symbol <= Xentry_1130_symbol; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/sum_rename_req
        array_obj_ref_13_root_address_inst_req_0 <= sum_rename_req_1132_symbol; -- link to DP
        sum_rename_ack_1133_symbol <= array_obj_ref_13_root_address_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/sum_rename_ack
        Xexit_1131_symbol <= sum_rename_ack_1133_symbol; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/$exit
        array_obj_ref_13_base_plus_offset_1129_symbol <= Xexit_1131_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_base_plus_offset
      array_obj_ref_13_word_addrgen_1134: Block -- assign_stmt_14/array_obj_ref_13_word_addrgen 
        signal array_obj_ref_13_word_addrgen_1134_start: Boolean;
        signal Xentry_1135_symbol: Boolean;
        signal Xexit_1136_symbol: Boolean;
        signal root_rename_req_1137_symbol : Boolean;
        signal root_rename_ack_1138_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_word_addrgen_1134_start <= array_obj_ref_13_root_address_calculated_1089_symbol; -- control passed to block
        Xentry_1135_symbol  <= array_obj_ref_13_word_addrgen_1134_start; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/$entry
        root_rename_req_1137_symbol <= Xentry_1135_symbol; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/root_rename_req
        array_obj_ref_13_addr_0_req_0 <= root_rename_req_1137_symbol; -- link to DP
        root_rename_ack_1138_symbol <= array_obj_ref_13_addr_0_ack_0; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/root_rename_ack
        Xexit_1136_symbol <= root_rename_ack_1138_symbol; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/$exit
        array_obj_ref_13_word_addrgen_1134_symbol <= Xexit_1136_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_word_addrgen
      array_obj_ref_13_request_1139: Block -- assign_stmt_14/array_obj_ref_13_request 
        signal array_obj_ref_13_request_1139_start: Boolean;
        signal Xentry_1140_symbol: Boolean;
        signal Xexit_1141_symbol: Boolean;
        signal word_access_1142_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_request_1139_start <= array_obj_ref_13_trigger_x_x1087_symbol; -- control passed to block
        Xentry_1140_symbol  <= array_obj_ref_13_request_1139_start; -- transition assign_stmt_14/array_obj_ref_13_request/$entry
        word_access_1142: Block -- assign_stmt_14/array_obj_ref_13_request/word_access 
          signal word_access_1142_start: Boolean;
          signal Xentry_1143_symbol: Boolean;
          signal Xexit_1144_symbol: Boolean;
          signal word_access_0_1145_symbol : Boolean;
          -- 
        begin -- 
          word_access_1142_start <= Xentry_1140_symbol; -- control passed to block
          Xentry_1143_symbol  <= word_access_1142_start; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/$entry
          word_access_0_1145: Block -- assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0 
            signal word_access_0_1145_start: Boolean;
            signal Xentry_1146_symbol: Boolean;
            signal Xexit_1147_symbol: Boolean;
            signal rr_1148_symbol : Boolean;
            signal ra_1149_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_1145_start <= Xentry_1143_symbol; -- control passed to block
            Xentry_1146_symbol  <= word_access_0_1145_start; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/$entry
            rr_1148_symbol <= Xentry_1146_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/rr
            array_obj_ref_13_load_0_req_0 <= rr_1148_symbol; -- link to DP
            ra_1149_symbol <= array_obj_ref_13_load_0_ack_0; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/ra
            Xexit_1147_symbol <= ra_1149_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/$exit
            word_access_0_1145_symbol <= Xexit_1147_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0
          Xexit_1144_symbol <= word_access_0_1145_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/$exit
          word_access_1142_symbol <= Xexit_1144_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_14/array_obj_ref_13_request/word_access
        Xexit_1141_symbol <= word_access_1142_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/$exit
        array_obj_ref_13_request_1139_symbol <= Xexit_1141_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_request
      array_obj_ref_13_complete_1150: Block -- assign_stmt_14/array_obj_ref_13_complete 
        signal array_obj_ref_13_complete_1150_start: Boolean;
        signal Xentry_1151_symbol: Boolean;
        signal Xexit_1152_symbol: Boolean;
        signal word_access_1153_symbol : Boolean;
        signal merge_req_1161_symbol : Boolean;
        signal merge_ack_1162_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_complete_1150_start <= array_obj_ref_13_active_x_x1088_symbol; -- control passed to block
        Xentry_1151_symbol  <= array_obj_ref_13_complete_1150_start; -- transition assign_stmt_14/array_obj_ref_13_complete/$entry
        word_access_1153: Block -- assign_stmt_14/array_obj_ref_13_complete/word_access 
          signal word_access_1153_start: Boolean;
          signal Xentry_1154_symbol: Boolean;
          signal Xexit_1155_symbol: Boolean;
          signal word_access_0_1156_symbol : Boolean;
          -- 
        begin -- 
          word_access_1153_start <= Xentry_1151_symbol; -- control passed to block
          Xentry_1154_symbol  <= word_access_1153_start; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/$entry
          word_access_0_1156: Block -- assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0 
            signal word_access_0_1156_start: Boolean;
            signal Xentry_1157_symbol: Boolean;
            signal Xexit_1158_symbol: Boolean;
            signal cr_1159_symbol : Boolean;
            signal ca_1160_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_1156_start <= Xentry_1154_symbol; -- control passed to block
            Xentry_1157_symbol  <= word_access_0_1156_start; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/$entry
            cr_1159_symbol <= Xentry_1157_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/cr
            array_obj_ref_13_load_0_req_1 <= cr_1159_symbol; -- link to DP
            ca_1160_symbol <= array_obj_ref_13_load_0_ack_1; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/ca
            Xexit_1158_symbol <= ca_1160_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/$exit
            word_access_0_1156_symbol <= Xexit_1158_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0
          Xexit_1155_symbol <= word_access_0_1156_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/$exit
          word_access_1153_symbol <= Xexit_1155_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_14/array_obj_ref_13_complete/word_access
        merge_req_1161_symbol <= word_access_1153_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/merge_req
        array_obj_ref_13_gather_scatter_req_0 <= merge_req_1161_symbol; -- link to DP
        merge_ack_1162_symbol <= array_obj_ref_13_gather_scatter_ack_0; -- transition assign_stmt_14/array_obj_ref_13_complete/merge_ack
        Xexit_1152_symbol <= merge_ack_1162_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/$exit
        array_obj_ref_13_complete_1150_symbol <= Xexit_1152_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_complete
      Xexit_1084_symbol <= assign_stmt_14_completed_x_x1086_symbol; -- transition assign_stmt_14/$exit
      assign_stmt_14_1082_symbol <= Xexit_1084_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_14
    Xexit_1081_symbol <= assign_stmt_14_1082_symbol; -- transition $exit
    fin  <=  '1' when Xexit_1081_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_13_data_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_13_final_offset : std_logic_vector(0 downto 0);
    signal array_obj_ref_13_offset_scale_factor_0 : std_logic_vector(0 downto 0);
    signal array_obj_ref_13_resized_base_address : std_logic_vector(0 downto 0);
    signal array_obj_ref_13_root_address : std_logic_vector(0 downto 0);
    signal array_obj_ref_13_word_address_0 : std_logic_vector(0 downto 0);
    signal array_obj_ref_13_word_offset_0 : std_logic_vector(0 downto 0);
    signal binary_10_wire : std_logic_vector(31 downto 0);
    signal binary_12_resized : std_logic_vector(0 downto 0);
    signal binary_12_scaled : std_logic_vector(0 downto 0);
    signal binary_12_wire : std_logic_vector(31 downto 0);
    signal expr_11_wire_constant : std_logic_vector(31 downto 0);
    signal expr_9_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_13_offset_scale_factor_0 <= "1";
    array_obj_ref_13_resized_base_address <= "0";
    array_obj_ref_13_word_offset_0 <= "0";
    expr_11_wire_constant <= "00000000000000000000000000000000";
    expr_9_wire_constant <= "00000000000000000000000000000001";
    array_obj_ref_13_index_0_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 1) -- 
      port map( din => binary_12_wire, dout => binary_12_resized, req => array_obj_ref_13_index_0_resize_req_0, ack => array_obj_ref_13_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_13_offset_inst: RegisterBase generic map(in_data_width => 1,out_data_width => 1) -- 
      port map( din => binary_12_scaled, dout => array_obj_ref_13_final_offset, req => array_obj_ref_13_offset_inst_req_0, ack => array_obj_ref_13_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_13_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      array_obj_ref_13_addr_0_ack_0 <= array_obj_ref_13_addr_0_req_0;
      aggregated_sig <= array_obj_ref_13_root_address;
      array_obj_ref_13_word_address_0 <= aggregated_sig(0 downto 0);
      --
    end Block;
    array_obj_ref_13_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      array_obj_ref_13_gather_scatter_ack_0 <= array_obj_ref_13_gather_scatter_req_0;
      aggregated_sig <= array_obj_ref_13_data_0;
      data <= aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_13_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      array_obj_ref_13_index_0_rename_ack_0 <= array_obj_ref_13_index_0_rename_req_0;
      aggregated_sig <= binary_12_resized;
      binary_12_scaled <= aggregated_sig(0 downto 0);
      --
    end Block;
    array_obj_ref_13_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      array_obj_ref_13_root_address_inst_ack_0 <= array_obj_ref_13_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_13_final_offset;
      array_obj_ref_13_root_address <= aggregated_sig(0 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_10_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= address;
      binary_10_wire <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntMul",
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
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_10_inst_req_0,
          ackL => binary_10_inst_ack_0,
          reqR => binary_10_inst_req_1,
          ackR => binary_10_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_12_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_10_wire;
      binary_12_wire <= data_out(31 downto 0);
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
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_12_inst_req_0,
          ackL => binary_12_inst_ack_0,
          reqR => binary_12_inst_req_1,
          ackR => binary_12_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared load operator group (0) : array_obj_ref_13_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= array_obj_ref_13_load_0_req_0;
      array_obj_ref_13_load_0_ack_0 <= ackL(0);
      reqR(0) <= array_obj_ref_13_load_0_req_1;
      array_obj_ref_13_load_0_ack_1 <= ackR(0);
      data_in <= array_obj_ref_13_word_address_0;
      array_obj_ref_13_data_0 <= data_out(7 downto 0);
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
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(7 downto 0),
          mtag => memory_space_0_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
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
entity mem_store_x_x is -- 
  port ( -- 
    address : in  std_logic_vector(31 downto 0);
    data : in  std_logic_vector(7 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(7 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(0 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(0 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity mem_store_x_x;
architecture Default of mem_store_x_x is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal array_obj_ref_24_index_0_rename_req_0 : boolean;
  signal array_obj_ref_24_index_0_resize_req_0 : boolean;
  signal array_obj_ref_24_addr_0_ack_0 : boolean;
  signal array_obj_ref_24_store_0_ack_0 : boolean;
  signal array_obj_ref_24_root_address_inst_req_0 : boolean;
  signal array_obj_ref_24_index_0_rename_ack_0 : boolean;
  signal binary_23_inst_ack_0 : boolean;
  signal array_obj_ref_24_store_0_req_0 : boolean;
  signal array_obj_ref_24_gather_scatter_ack_0 : boolean;
  signal array_obj_ref_24_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_24_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_24_addr_0_req_0 : boolean;
  signal binary_23_inst_req_0 : boolean;
  signal array_obj_ref_24_offset_inst_req_0 : boolean;
  signal array_obj_ref_24_store_0_req_1 : boolean;
  signal array_obj_ref_24_store_0_ack_1 : boolean;
  signal array_obj_ref_24_offset_inst_ack_0 : boolean;
  signal array_obj_ref_24_gather_scatter_req_0 : boolean;
  signal binary_21_inst_req_0 : boolean;
  signal binary_21_inst_ack_0 : boolean;
  signal binary_21_inst_req_1 : boolean;
  signal binary_21_inst_ack_1 : boolean;
  signal binary_23_inst_ack_1 : boolean;
  signal binary_23_inst_req_1 : boolean;
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
  mem_store_x_xx_xCP_1163: Block -- control-path 
    signal mem_store_x_xx_xCP_1163_start: Boolean;
    signal Xentry_1164_symbol: Boolean;
    signal Xexit_1165_symbol: Boolean;
    signal assign_stmt_26_1166_symbol : Boolean;
    -- 
  begin -- 
    mem_store_x_xx_xCP_1163_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1164_symbol  <= mem_store_x_xx_xCP_1163_start; -- transition $entry
    assign_stmt_26_1166: Block -- assign_stmt_26 
      signal assign_stmt_26_1166_start: Boolean;
      signal Xentry_1167_symbol: Boolean;
      signal Xexit_1168_symbol: Boolean;
      signal assign_stmt_26_active_x_x1169_symbol : Boolean;
      signal assign_stmt_26_completed_x_x1170_symbol : Boolean;
      signal simple_obj_ref_25_complete_1171_symbol : Boolean;
      signal array_obj_ref_24_trigger_x_x1172_symbol : Boolean;
      signal array_obj_ref_24_active_x_x1173_symbol : Boolean;
      signal array_obj_ref_24_root_address_calculated_1174_symbol : Boolean;
      signal array_obj_ref_24_word_address_calculated_1175_symbol : Boolean;
      signal array_obj_ref_24_indices_scaled_1176_symbol : Boolean;
      signal array_obj_ref_24_offset_calculated_1177_symbol : Boolean;
      signal array_obj_ref_24_index_computed_0_1178_symbol : Boolean;
      signal array_obj_ref_24_index_resized_0_1179_symbol : Boolean;
      signal binary_23_active_x_x1180_symbol : Boolean;
      signal binary_23_trigger_x_x1181_symbol : Boolean;
      signal binary_21_active_x_x1182_symbol : Boolean;
      signal binary_21_trigger_x_x1183_symbol : Boolean;
      signal simple_obj_ref_19_complete_1184_symbol : Boolean;
      signal binary_21_complete_1185_symbol : Boolean;
      signal binary_23_complete_1192_symbol : Boolean;
      signal array_obj_ref_24_index_resize_0_1199_symbol : Boolean;
      signal array_obj_ref_24_index_scale_0_1204_symbol : Boolean;
      signal array_obj_ref_24_add_indices_1209_symbol : Boolean;
      signal array_obj_ref_24_base_plus_offset_1214_symbol : Boolean;
      signal array_obj_ref_24_word_addrgen_1219_symbol : Boolean;
      signal array_obj_ref_24_request_1224_symbol : Boolean;
      signal array_obj_ref_24_complete_1237_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_26_1166_start <= Xentry_1164_symbol; -- control passed to block
      Xentry_1167_symbol  <= assign_stmt_26_1166_start; -- transition assign_stmt_26/$entry
      assign_stmt_26_active_x_x1169_symbol <= simple_obj_ref_25_complete_1171_symbol; -- transition assign_stmt_26/assign_stmt_26_active_
      assign_stmt_26_completed_x_x1170_symbol <= array_obj_ref_24_complete_1237_symbol; -- transition assign_stmt_26/assign_stmt_26_completed_
      simple_obj_ref_25_complete_1171_symbol <= Xentry_1167_symbol; -- transition assign_stmt_26/simple_obj_ref_25_complete
      array_obj_ref_24_trigger_x_x1172_block : Block -- non-trivial join transition assign_stmt_26/array_obj_ref_24_trigger_ 
        signal array_obj_ref_24_trigger_x_x1172_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        array_obj_ref_24_trigger_x_x1172_predecessors(0) <= array_obj_ref_24_word_address_calculated_1175_symbol;
        array_obj_ref_24_trigger_x_x1172_predecessors(1) <= assign_stmt_26_active_x_x1169_symbol;
        array_obj_ref_24_trigger_x_x1172_join: join -- 
          port map( -- 
            preds => array_obj_ref_24_trigger_x_x1172_predecessors,
            symbol_out => array_obj_ref_24_trigger_x_x1172_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_26/array_obj_ref_24_trigger_
      array_obj_ref_24_active_x_x1173_symbol <= array_obj_ref_24_request_1224_symbol; -- transition assign_stmt_26/array_obj_ref_24_active_
      array_obj_ref_24_root_address_calculated_1174_symbol <= array_obj_ref_24_base_plus_offset_1214_symbol; -- transition assign_stmt_26/array_obj_ref_24_root_address_calculated
      array_obj_ref_24_word_address_calculated_1175_symbol <= array_obj_ref_24_word_addrgen_1219_symbol; -- transition assign_stmt_26/array_obj_ref_24_word_address_calculated
      array_obj_ref_24_indices_scaled_1176_symbol <= array_obj_ref_24_index_scale_0_1204_symbol; -- transition assign_stmt_26/array_obj_ref_24_indices_scaled
      array_obj_ref_24_offset_calculated_1177_symbol <= array_obj_ref_24_add_indices_1209_symbol; -- transition assign_stmt_26/array_obj_ref_24_offset_calculated
      array_obj_ref_24_index_computed_0_1178_symbol <= binary_23_complete_1192_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_computed_0
      array_obj_ref_24_index_resized_0_1179_symbol <= array_obj_ref_24_index_resize_0_1199_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_resized_0
      binary_23_active_x_x1180_block : Block -- non-trivial join transition assign_stmt_26/binary_23_active_ 
        signal binary_23_active_x_x1180_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_23_active_x_x1180_predecessors(0) <= binary_23_trigger_x_x1181_symbol;
        binary_23_active_x_x1180_predecessors(1) <= binary_21_complete_1185_symbol;
        binary_23_active_x_x1180_join: join -- 
          port map( -- 
            preds => binary_23_active_x_x1180_predecessors,
            symbol_out => binary_23_active_x_x1180_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_26/binary_23_active_
      binary_23_trigger_x_x1181_symbol <= Xentry_1167_symbol; -- transition assign_stmt_26/binary_23_trigger_
      binary_21_active_x_x1182_block : Block -- non-trivial join transition assign_stmt_26/binary_21_active_ 
        signal binary_21_active_x_x1182_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_21_active_x_x1182_predecessors(0) <= binary_21_trigger_x_x1183_symbol;
        binary_21_active_x_x1182_predecessors(1) <= simple_obj_ref_19_complete_1184_symbol;
        binary_21_active_x_x1182_join: join -- 
          port map( -- 
            preds => binary_21_active_x_x1182_predecessors,
            symbol_out => binary_21_active_x_x1182_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_26/binary_21_active_
      binary_21_trigger_x_x1183_symbol <= Xentry_1167_symbol; -- transition assign_stmt_26/binary_21_trigger_
      simple_obj_ref_19_complete_1184_symbol <= Xentry_1167_symbol; -- transition assign_stmt_26/simple_obj_ref_19_complete
      binary_21_complete_1185: Block -- assign_stmt_26/binary_21_complete 
        signal binary_21_complete_1185_start: Boolean;
        signal Xentry_1186_symbol: Boolean;
        signal Xexit_1187_symbol: Boolean;
        signal rr_1188_symbol : Boolean;
        signal ra_1189_symbol : Boolean;
        signal cr_1190_symbol : Boolean;
        signal ca_1191_symbol : Boolean;
        -- 
      begin -- 
        binary_21_complete_1185_start <= binary_21_active_x_x1182_symbol; -- control passed to block
        Xentry_1186_symbol  <= binary_21_complete_1185_start; -- transition assign_stmt_26/binary_21_complete/$entry
        rr_1188_symbol <= Xentry_1186_symbol; -- transition assign_stmt_26/binary_21_complete/rr
        binary_21_inst_req_0 <= rr_1188_symbol; -- link to DP
        ra_1189_symbol <= binary_21_inst_ack_0; -- transition assign_stmt_26/binary_21_complete/ra
        cr_1190_symbol <= ra_1189_symbol; -- transition assign_stmt_26/binary_21_complete/cr
        binary_21_inst_req_1 <= cr_1190_symbol; -- link to DP
        ca_1191_symbol <= binary_21_inst_ack_1; -- transition assign_stmt_26/binary_21_complete/ca
        Xexit_1187_symbol <= ca_1191_symbol; -- transition assign_stmt_26/binary_21_complete/$exit
        binary_21_complete_1185_symbol <= Xexit_1187_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/binary_21_complete
      binary_23_complete_1192: Block -- assign_stmt_26/binary_23_complete 
        signal binary_23_complete_1192_start: Boolean;
        signal Xentry_1193_symbol: Boolean;
        signal Xexit_1194_symbol: Boolean;
        signal rr_1195_symbol : Boolean;
        signal ra_1196_symbol : Boolean;
        signal cr_1197_symbol : Boolean;
        signal ca_1198_symbol : Boolean;
        -- 
      begin -- 
        binary_23_complete_1192_start <= binary_23_active_x_x1180_symbol; -- control passed to block
        Xentry_1193_symbol  <= binary_23_complete_1192_start; -- transition assign_stmt_26/binary_23_complete/$entry
        rr_1195_symbol <= Xentry_1193_symbol; -- transition assign_stmt_26/binary_23_complete/rr
        binary_23_inst_req_0 <= rr_1195_symbol; -- link to DP
        ra_1196_symbol <= binary_23_inst_ack_0; -- transition assign_stmt_26/binary_23_complete/ra
        cr_1197_symbol <= ra_1196_symbol; -- transition assign_stmt_26/binary_23_complete/cr
        binary_23_inst_req_1 <= cr_1197_symbol; -- link to DP
        ca_1198_symbol <= binary_23_inst_ack_1; -- transition assign_stmt_26/binary_23_complete/ca
        Xexit_1194_symbol <= ca_1198_symbol; -- transition assign_stmt_26/binary_23_complete/$exit
        binary_23_complete_1192_symbol <= Xexit_1194_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/binary_23_complete
      array_obj_ref_24_index_resize_0_1199: Block -- assign_stmt_26/array_obj_ref_24_index_resize_0 
        signal array_obj_ref_24_index_resize_0_1199_start: Boolean;
        signal Xentry_1200_symbol: Boolean;
        signal Xexit_1201_symbol: Boolean;
        signal index_resize_req_1202_symbol : Boolean;
        signal index_resize_ack_1203_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_index_resize_0_1199_start <= array_obj_ref_24_index_computed_0_1178_symbol; -- control passed to block
        Xentry_1200_symbol  <= array_obj_ref_24_index_resize_0_1199_start; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/$entry
        index_resize_req_1202_symbol <= Xentry_1200_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/index_resize_req
        array_obj_ref_24_index_0_resize_req_0 <= index_resize_req_1202_symbol; -- link to DP
        index_resize_ack_1203_symbol <= array_obj_ref_24_index_0_resize_ack_0; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/index_resize_ack
        Xexit_1201_symbol <= index_resize_ack_1203_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/$exit
        array_obj_ref_24_index_resize_0_1199_symbol <= Xexit_1201_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_index_resize_0
      array_obj_ref_24_index_scale_0_1204: Block -- assign_stmt_26/array_obj_ref_24_index_scale_0 
        signal array_obj_ref_24_index_scale_0_1204_start: Boolean;
        signal Xentry_1205_symbol: Boolean;
        signal Xexit_1206_symbol: Boolean;
        signal scale_rename_req_1207_symbol : Boolean;
        signal scale_rename_ack_1208_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_index_scale_0_1204_start <= array_obj_ref_24_index_resized_0_1179_symbol; -- control passed to block
        Xentry_1205_symbol  <= array_obj_ref_24_index_scale_0_1204_start; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/$entry
        scale_rename_req_1207_symbol <= Xentry_1205_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/scale_rename_req
        array_obj_ref_24_index_0_rename_req_0 <= scale_rename_req_1207_symbol; -- link to DP
        scale_rename_ack_1208_symbol <= array_obj_ref_24_index_0_rename_ack_0; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/scale_rename_ack
        Xexit_1206_symbol <= scale_rename_ack_1208_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/$exit
        array_obj_ref_24_index_scale_0_1204_symbol <= Xexit_1206_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_index_scale_0
      array_obj_ref_24_add_indices_1209: Block -- assign_stmt_26/array_obj_ref_24_add_indices 
        signal array_obj_ref_24_add_indices_1209_start: Boolean;
        signal Xentry_1210_symbol: Boolean;
        signal Xexit_1211_symbol: Boolean;
        signal final_index_req_1212_symbol : Boolean;
        signal final_index_ack_1213_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_add_indices_1209_start <= array_obj_ref_24_indices_scaled_1176_symbol; -- control passed to block
        Xentry_1210_symbol  <= array_obj_ref_24_add_indices_1209_start; -- transition assign_stmt_26/array_obj_ref_24_add_indices/$entry
        final_index_req_1212_symbol <= Xentry_1210_symbol; -- transition assign_stmt_26/array_obj_ref_24_add_indices/final_index_req
        array_obj_ref_24_offset_inst_req_0 <= final_index_req_1212_symbol; -- link to DP
        final_index_ack_1213_symbol <= array_obj_ref_24_offset_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24_add_indices/final_index_ack
        Xexit_1211_symbol <= final_index_ack_1213_symbol; -- transition assign_stmt_26/array_obj_ref_24_add_indices/$exit
        array_obj_ref_24_add_indices_1209_symbol <= Xexit_1211_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_add_indices
      array_obj_ref_24_base_plus_offset_1214: Block -- assign_stmt_26/array_obj_ref_24_base_plus_offset 
        signal array_obj_ref_24_base_plus_offset_1214_start: Boolean;
        signal Xentry_1215_symbol: Boolean;
        signal Xexit_1216_symbol: Boolean;
        signal sum_rename_req_1217_symbol : Boolean;
        signal sum_rename_ack_1218_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_base_plus_offset_1214_start <= array_obj_ref_24_offset_calculated_1177_symbol; -- control passed to block
        Xentry_1215_symbol  <= array_obj_ref_24_base_plus_offset_1214_start; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/$entry
        sum_rename_req_1217_symbol <= Xentry_1215_symbol; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/sum_rename_req
        array_obj_ref_24_root_address_inst_req_0 <= sum_rename_req_1217_symbol; -- link to DP
        sum_rename_ack_1218_symbol <= array_obj_ref_24_root_address_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/sum_rename_ack
        Xexit_1216_symbol <= sum_rename_ack_1218_symbol; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/$exit
        array_obj_ref_24_base_plus_offset_1214_symbol <= Xexit_1216_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_base_plus_offset
      array_obj_ref_24_word_addrgen_1219: Block -- assign_stmt_26/array_obj_ref_24_word_addrgen 
        signal array_obj_ref_24_word_addrgen_1219_start: Boolean;
        signal Xentry_1220_symbol: Boolean;
        signal Xexit_1221_symbol: Boolean;
        signal root_rename_req_1222_symbol : Boolean;
        signal root_rename_ack_1223_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_word_addrgen_1219_start <= array_obj_ref_24_root_address_calculated_1174_symbol; -- control passed to block
        Xentry_1220_symbol  <= array_obj_ref_24_word_addrgen_1219_start; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/$entry
        root_rename_req_1222_symbol <= Xentry_1220_symbol; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/root_rename_req
        array_obj_ref_24_addr_0_req_0 <= root_rename_req_1222_symbol; -- link to DP
        root_rename_ack_1223_symbol <= array_obj_ref_24_addr_0_ack_0; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/root_rename_ack
        Xexit_1221_symbol <= root_rename_ack_1223_symbol; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/$exit
        array_obj_ref_24_word_addrgen_1219_symbol <= Xexit_1221_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_word_addrgen
      array_obj_ref_24_request_1224: Block -- assign_stmt_26/array_obj_ref_24_request 
        signal array_obj_ref_24_request_1224_start: Boolean;
        signal Xentry_1225_symbol: Boolean;
        signal Xexit_1226_symbol: Boolean;
        signal split_req_1227_symbol : Boolean;
        signal split_ack_1228_symbol : Boolean;
        signal word_access_1229_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_request_1224_start <= array_obj_ref_24_trigger_x_x1172_symbol; -- control passed to block
        Xentry_1225_symbol  <= array_obj_ref_24_request_1224_start; -- transition assign_stmt_26/array_obj_ref_24_request/$entry
        split_req_1227_symbol <= Xentry_1225_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/split_req
        array_obj_ref_24_gather_scatter_req_0 <= split_req_1227_symbol; -- link to DP
        split_ack_1228_symbol <= array_obj_ref_24_gather_scatter_ack_0; -- transition assign_stmt_26/array_obj_ref_24_request/split_ack
        word_access_1229: Block -- assign_stmt_26/array_obj_ref_24_request/word_access 
          signal word_access_1229_start: Boolean;
          signal Xentry_1230_symbol: Boolean;
          signal Xexit_1231_symbol: Boolean;
          signal word_access_0_1232_symbol : Boolean;
          -- 
        begin -- 
          word_access_1229_start <= split_ack_1228_symbol; -- control passed to block
          Xentry_1230_symbol  <= word_access_1229_start; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/$entry
          word_access_0_1232: Block -- assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0 
            signal word_access_0_1232_start: Boolean;
            signal Xentry_1233_symbol: Boolean;
            signal Xexit_1234_symbol: Boolean;
            signal rr_1235_symbol : Boolean;
            signal ra_1236_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_1232_start <= Xentry_1230_symbol; -- control passed to block
            Xentry_1233_symbol  <= word_access_0_1232_start; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/$entry
            rr_1235_symbol <= Xentry_1233_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/rr
            array_obj_ref_24_store_0_req_0 <= rr_1235_symbol; -- link to DP
            ra_1236_symbol <= array_obj_ref_24_store_0_ack_0; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/ra
            Xexit_1234_symbol <= ra_1236_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/$exit
            word_access_0_1232_symbol <= Xexit_1234_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0
          Xexit_1231_symbol <= word_access_0_1232_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/$exit
          word_access_1229_symbol <= Xexit_1231_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_26/array_obj_ref_24_request/word_access
        Xexit_1226_symbol <= word_access_1229_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/$exit
        array_obj_ref_24_request_1224_symbol <= Xexit_1226_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_request
      array_obj_ref_24_complete_1237: Block -- assign_stmt_26/array_obj_ref_24_complete 
        signal array_obj_ref_24_complete_1237_start: Boolean;
        signal Xentry_1238_symbol: Boolean;
        signal Xexit_1239_symbol: Boolean;
        signal word_access_1240_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_complete_1237_start <= array_obj_ref_24_active_x_x1173_symbol; -- control passed to block
        Xentry_1238_symbol  <= array_obj_ref_24_complete_1237_start; -- transition assign_stmt_26/array_obj_ref_24_complete/$entry
        word_access_1240: Block -- assign_stmt_26/array_obj_ref_24_complete/word_access 
          signal word_access_1240_start: Boolean;
          signal Xentry_1241_symbol: Boolean;
          signal Xexit_1242_symbol: Boolean;
          signal word_access_0_1243_symbol : Boolean;
          -- 
        begin -- 
          word_access_1240_start <= Xentry_1238_symbol; -- control passed to block
          Xentry_1241_symbol  <= word_access_1240_start; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/$entry
          word_access_0_1243: Block -- assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0 
            signal word_access_0_1243_start: Boolean;
            signal Xentry_1244_symbol: Boolean;
            signal Xexit_1245_symbol: Boolean;
            signal cr_1246_symbol : Boolean;
            signal ca_1247_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_1243_start <= Xentry_1241_symbol; -- control passed to block
            Xentry_1244_symbol  <= word_access_0_1243_start; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/$entry
            cr_1246_symbol <= Xentry_1244_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/cr
            array_obj_ref_24_store_0_req_1 <= cr_1246_symbol; -- link to DP
            ca_1247_symbol <= array_obj_ref_24_store_0_ack_1; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/ca
            Xexit_1245_symbol <= ca_1247_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/$exit
            word_access_0_1243_symbol <= Xexit_1245_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0
          Xexit_1242_symbol <= word_access_0_1243_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/$exit
          word_access_1240_symbol <= Xexit_1242_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_26/array_obj_ref_24_complete/word_access
        Xexit_1239_symbol <= word_access_1240_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/$exit
        array_obj_ref_24_complete_1237_symbol <= Xexit_1239_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_complete
      Xexit_1168_symbol <= assign_stmt_26_completed_x_x1170_symbol; -- transition assign_stmt_26/$exit
      assign_stmt_26_1166_symbol <= Xexit_1168_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_26
    Xexit_1165_symbol <= assign_stmt_26_1166_symbol; -- transition $exit
    fin  <=  '1' when Xexit_1165_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_24_data_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_24_final_offset : std_logic_vector(0 downto 0);
    signal array_obj_ref_24_offset_scale_factor_0 : std_logic_vector(0 downto 0);
    signal array_obj_ref_24_resized_base_address : std_logic_vector(0 downto 0);
    signal array_obj_ref_24_root_address : std_logic_vector(0 downto 0);
    signal array_obj_ref_24_word_address_0 : std_logic_vector(0 downto 0);
    signal array_obj_ref_24_word_offset_0 : std_logic_vector(0 downto 0);
    signal binary_21_wire : std_logic_vector(31 downto 0);
    signal binary_23_resized : std_logic_vector(0 downto 0);
    signal binary_23_scaled : std_logic_vector(0 downto 0);
    signal binary_23_wire : std_logic_vector(31 downto 0);
    signal expr_20_wire_constant : std_logic_vector(31 downto 0);
    signal expr_22_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_24_offset_scale_factor_0 <= "1";
    array_obj_ref_24_resized_base_address <= "0";
    array_obj_ref_24_word_offset_0 <= "0";
    expr_20_wire_constant <= "00000000000000000000000000000001";
    expr_22_wire_constant <= "00000000000000000000000000000000";
    array_obj_ref_24_index_0_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 1) -- 
      port map( din => binary_23_wire, dout => binary_23_resized, req => array_obj_ref_24_index_0_resize_req_0, ack => array_obj_ref_24_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_24_offset_inst: RegisterBase generic map(in_data_width => 1,out_data_width => 1) -- 
      port map( din => binary_23_scaled, dout => array_obj_ref_24_final_offset, req => array_obj_ref_24_offset_inst_req_0, ack => array_obj_ref_24_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_24_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      array_obj_ref_24_addr_0_ack_0 <= array_obj_ref_24_addr_0_req_0;
      aggregated_sig <= array_obj_ref_24_root_address;
      array_obj_ref_24_word_address_0 <= aggregated_sig(0 downto 0);
      --
    end Block;
    array_obj_ref_24_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      array_obj_ref_24_gather_scatter_ack_0 <= array_obj_ref_24_gather_scatter_req_0;
      aggregated_sig <= data;
      array_obj_ref_24_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    array_obj_ref_24_index_0_rename: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      array_obj_ref_24_index_0_rename_ack_0 <= array_obj_ref_24_index_0_rename_req_0;
      aggregated_sig <= binary_23_resized;
      binary_23_scaled <= aggregated_sig(0 downto 0);
      --
    end Block;
    array_obj_ref_24_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(0 downto 0); --
    begin -- 
      array_obj_ref_24_root_address_inst_ack_0 <= array_obj_ref_24_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_24_final_offset;
      array_obj_ref_24_root_address <= aggregated_sig(0 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_21_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= address;
      binary_21_wire <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntMul",
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
          owidth => 32,
          constant_operand => "00000000000000000000000000000001",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_21_inst_req_0,
          ackL => binary_21_inst_ack_0,
          reqR => binary_21_inst_req_1,
          ackR => binary_21_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_23_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= binary_21_wire;
      binary_23_wire <= data_out(31 downto 0);
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
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 32,
          constant_operand => "00000000000000000000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_23_inst_req_0,
          ackL => binary_23_inst_ack_0,
          reqR => binary_23_inst_req_1,
          ackR => binary_23_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared store operator group (0) : array_obj_ref_24_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= array_obj_ref_24_store_0_req_0;
      array_obj_ref_24_store_0_ack_0 <= ackL(0);
      reqR(0) <= array_obj_ref_24_store_0_req_1;
      array_obj_ref_24_store_0_ack_1 <= ackR(0);
      addr_in <= array_obj_ref_24_word_address_0;
      data_in <= array_obj_ref_24_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 8,
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
          mdata => memory_space_0_sr_data(7 downto 0),
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
    end Block; -- store group 0
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
entity output_module is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lr_addr : out  std_logic_vector(2 downto 0);
    memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
    foo_out_pipe_read_req : out  std_logic_vector(0 downto 0);
    foo_out_pipe_read_ack : in   std_logic_vector(0 downto 0);
    foo_out_pipe_read_data : in   std_logic_vector(31 downto 0);
    free_queue_put_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_put_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_put_pipe_write_data : out  std_logic_vector(31 downto 0);
    free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
    free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
    output_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    output_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    output_data_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity output_module;
architecture Default of output_module is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal ptr_deref_326_gather_scatter_ack_0 : boolean;
  signal type_cast_322_inst_ack_0 : boolean;
  signal ptr_deref_326_base_resize_ack_0 : boolean;
  signal array_obj_ref_318_base_resize_ack_0 : boolean;
  signal array_obj_ref_318_final_reg_ack_0 : boolean;
  signal array_obj_ref_318_base_resize_req_0 : boolean;
  signal simple_obj_ref_342_inst_req_0 : boolean;
  signal array_obj_ref_318_root_address_inst_req_0 : boolean;
  signal type_cast_314_inst_ack_0 : boolean;
  signal ptr_deref_326_load_0_req_1 : boolean;
  signal type_cast_335_inst_ack_0 : boolean;
  signal simple_obj_ref_351_inst_ack_0 : boolean;
  signal simple_obj_ref_342_inst_ack_0 : boolean;
  signal ptr_deref_326_root_address_inst_req_0 : boolean;
  signal ptr_deref_326_root_address_inst_ack_0 : boolean;
  signal ptr_deref_326_base_resize_req_0 : boolean;
  signal array_obj_ref_318_root_address_inst_ack_0 : boolean;
  signal ptr_deref_326_load_0_ack_1 : boolean;
  signal type_cast_353_inst_req_0 : boolean;
  signal ptr_deref_326_addr_0_ack_0 : boolean;
  signal type_cast_353_inst_ack_0 : boolean;
  signal type_cast_322_inst_req_0 : boolean;
  signal type_cast_314_inst_req_0 : boolean;
  signal simple_obj_ref_313_inst_ack_0 : boolean;
  signal simple_obj_ref_351_inst_req_0 : boolean;
  signal ptr_deref_326_load_0_req_0 : boolean;
  signal type_cast_335_inst_req_0 : boolean;
  signal ptr_deref_326_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_313_inst_req_0 : boolean;
  signal ptr_deref_326_load_0_ack_0 : boolean;
  signal array_obj_ref_318_final_reg_req_0 : boolean;
  signal simple_obj_ref_333_inst_ack_0 : boolean;
  signal simple_obj_ref_333_inst_req_0 : boolean;
  signal ptr_deref_326_addr_0_req_0 : boolean;
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
  output_module_CP_1248: Block -- control-path 
    signal output_module_CP_1248_start: Boolean;
    signal Xentry_1249_symbol: Boolean;
    signal Xexit_1250_symbol: Boolean;
    signal branch_block_stmt_304_1251_symbol : Boolean;
    -- 
  begin -- 
    output_module_CP_1248_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1249_symbol  <= output_module_CP_1248_start; -- transition $entry
    branch_block_stmt_304_1251: Block -- branch_block_stmt_304 
      signal branch_block_stmt_304_1251_start: Boolean;
      signal Xentry_1252_symbol: Boolean;
      signal Xexit_1253_symbol: Boolean;
      signal branch_block_stmt_304_x_xentry_x_xx_x1254_symbol : Boolean;
      signal branch_block_stmt_304_x_xexit_x_xx_x1255_symbol : Boolean;
      signal bb_0_bb_1_1256_symbol : Boolean;
      signal merge_stmt_306_x_xexit_x_xx_x1257_symbol : Boolean;
      signal assign_stmt_311_x_xentry_x_xx_x1258_symbol : Boolean;
      signal assign_stmt_311_x_xexit_x_xx_x1259_symbol : Boolean;
      signal assign_stmt_315_x_xentry_x_xx_x1260_symbol : Boolean;
      signal assign_stmt_315_x_xexit_x_xx_x1261_symbol : Boolean;
      signal assign_stmt_319_to_assign_stmt_332_x_xentry_x_xx_x1262_symbol : Boolean;
      signal assign_stmt_319_to_assign_stmt_332_x_xexit_x_xx_x1263_symbol : Boolean;
      signal assign_stmt_336_x_xentry_x_xx_x1264_symbol : Boolean;
      signal assign_stmt_336_x_xexit_x_xx_x1265_symbol : Boolean;
      signal assign_stmt_341_x_xentry_x_xx_x1266_symbol : Boolean;
      signal assign_stmt_341_x_xexit_x_xx_x1267_symbol : Boolean;
      signal assign_stmt_345_x_xentry_x_xx_x1268_symbol : Boolean;
      signal assign_stmt_345_x_xexit_x_xx_x1269_symbol : Boolean;
      signal assign_stmt_350_x_xentry_x_xx_x1270_symbol : Boolean;
      signal assign_stmt_350_x_xexit_x_xx_x1271_symbol : Boolean;
      signal assign_stmt_354_x_xentry_x_xx_x1272_symbol : Boolean;
      signal assign_stmt_354_x_xexit_x_xx_x1273_symbol : Boolean;
      signal bb_1_bb_1_1274_symbol : Boolean;
      signal assign_stmt_311_1275_symbol : Boolean;
      signal assign_stmt_315_1278_symbol : Boolean;
      signal assign_stmt_319_to_assign_stmt_332_1296_symbol : Boolean;
      signal assign_stmt_336_1379_symbol : Boolean;
      signal assign_stmt_341_1398_symbol : Boolean;
      signal assign_stmt_345_1401_symbol : Boolean;
      signal assign_stmt_350_1412_symbol : Boolean;
      signal assign_stmt_354_1415_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_1434_symbol : Boolean;
      signal bb_1_bb_1_PhiReq_1437_symbol : Boolean;
      signal merge_stmt_306_PhiReqMerge_1440_symbol : Boolean;
      signal merge_stmt_306_PhiAck_1441_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_304_1251_start <= Xentry_1249_symbol; -- control passed to block
      Xentry_1252_symbol  <= branch_block_stmt_304_1251_start; -- transition branch_block_stmt_304/$entry
      branch_block_stmt_304_x_xentry_x_xx_x1254_symbol  <=  Xentry_1252_symbol; -- place branch_block_stmt_304/branch_block_stmt_304__entry__ (optimized away) 
      branch_block_stmt_304_x_xexit_x_xx_x1255_symbol  <=   false ; -- place branch_block_stmt_304/branch_block_stmt_304__exit__ (optimized away) 
      bb_0_bb_1_1256_symbol  <=  branch_block_stmt_304_x_xentry_x_xx_x1254_symbol; -- place branch_block_stmt_304/bb_0_bb_1 (optimized away) 
      merge_stmt_306_x_xexit_x_xx_x1257_symbol  <=  merge_stmt_306_PhiAck_1441_symbol; -- place branch_block_stmt_304/merge_stmt_306__exit__ (optimized away) 
      assign_stmt_311_x_xentry_x_xx_x1258_symbol  <=  merge_stmt_306_x_xexit_x_xx_x1257_symbol; -- place branch_block_stmt_304/assign_stmt_311__entry__ (optimized away) 
      assign_stmt_311_x_xexit_x_xx_x1259_symbol  <=  assign_stmt_311_1275_symbol; -- place branch_block_stmt_304/assign_stmt_311__exit__ (optimized away) 
      assign_stmt_315_x_xentry_x_xx_x1260_symbol  <=  assign_stmt_311_x_xexit_x_xx_x1259_symbol; -- place branch_block_stmt_304/assign_stmt_315__entry__ (optimized away) 
      assign_stmt_315_x_xexit_x_xx_x1261_symbol  <=  assign_stmt_315_1278_symbol; -- place branch_block_stmt_304/assign_stmt_315__exit__ (optimized away) 
      assign_stmt_319_to_assign_stmt_332_x_xentry_x_xx_x1262_symbol  <=  assign_stmt_315_x_xexit_x_xx_x1261_symbol; -- place branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332__entry__ (optimized away) 
      assign_stmt_319_to_assign_stmt_332_x_xexit_x_xx_x1263_symbol  <=  assign_stmt_319_to_assign_stmt_332_1296_symbol; -- place branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332__exit__ (optimized away) 
      assign_stmt_336_x_xentry_x_xx_x1264_symbol  <=  assign_stmt_319_to_assign_stmt_332_x_xexit_x_xx_x1263_symbol; -- place branch_block_stmt_304/assign_stmt_336__entry__ (optimized away) 
      assign_stmt_336_x_xexit_x_xx_x1265_symbol  <=  assign_stmt_336_1379_symbol; -- place branch_block_stmt_304/assign_stmt_336__exit__ (optimized away) 
      assign_stmt_341_x_xentry_x_xx_x1266_symbol  <=  assign_stmt_336_x_xexit_x_xx_x1265_symbol; -- place branch_block_stmt_304/assign_stmt_341__entry__ (optimized away) 
      assign_stmt_341_x_xexit_x_xx_x1267_symbol  <=  assign_stmt_341_1398_symbol; -- place branch_block_stmt_304/assign_stmt_341__exit__ (optimized away) 
      assign_stmt_345_x_xentry_x_xx_x1268_symbol  <=  assign_stmt_341_x_xexit_x_xx_x1267_symbol; -- place branch_block_stmt_304/assign_stmt_345__entry__ (optimized away) 
      assign_stmt_345_x_xexit_x_xx_x1269_symbol  <=  assign_stmt_345_1401_symbol; -- place branch_block_stmt_304/assign_stmt_345__exit__ (optimized away) 
      assign_stmt_350_x_xentry_x_xx_x1270_symbol  <=  assign_stmt_345_x_xexit_x_xx_x1269_symbol; -- place branch_block_stmt_304/assign_stmt_350__entry__ (optimized away) 
      assign_stmt_350_x_xexit_x_xx_x1271_symbol  <=  assign_stmt_350_1412_symbol; -- place branch_block_stmt_304/assign_stmt_350__exit__ (optimized away) 
      assign_stmt_354_x_xentry_x_xx_x1272_symbol  <=  assign_stmt_350_x_xexit_x_xx_x1271_symbol; -- place branch_block_stmt_304/assign_stmt_354__entry__ (optimized away) 
      assign_stmt_354_x_xexit_x_xx_x1273_symbol  <=  assign_stmt_354_1415_symbol; -- place branch_block_stmt_304/assign_stmt_354__exit__ (optimized away) 
      bb_1_bb_1_1274_symbol  <=  assign_stmt_354_x_xexit_x_xx_x1273_symbol; -- place branch_block_stmt_304/bb_1_bb_1 (optimized away) 
      assign_stmt_311_1275: Block -- branch_block_stmt_304/assign_stmt_311 
        signal assign_stmt_311_1275_start: Boolean;
        signal Xentry_1276_symbol: Boolean;
        signal Xexit_1277_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_311_1275_start <= assign_stmt_311_x_xentry_x_xx_x1258_symbol; -- control passed to block
        Xentry_1276_symbol  <= assign_stmt_311_1275_start; -- transition branch_block_stmt_304/assign_stmt_311/$entry
        Xexit_1277_symbol <= Xentry_1276_symbol; -- transition branch_block_stmt_304/assign_stmt_311/$exit
        assign_stmt_311_1275_symbol <= Xexit_1277_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_311
      assign_stmt_315_1278: Block -- branch_block_stmt_304/assign_stmt_315 
        signal assign_stmt_315_1278_start: Boolean;
        signal Xentry_1279_symbol: Boolean;
        signal Xexit_1280_symbol: Boolean;
        signal assign_stmt_315_active_x_x1281_symbol : Boolean;
        signal assign_stmt_315_completed_x_x1282_symbol : Boolean;
        signal type_cast_314_active_x_x1283_symbol : Boolean;
        signal type_cast_314_trigger_x_x1284_symbol : Boolean;
        signal simple_obj_ref_313_trigger_x_x1285_symbol : Boolean;
        signal simple_obj_ref_313_complete_1286_symbol : Boolean;
        signal type_cast_314_complete_1291_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_315_1278_start <= assign_stmt_315_x_xentry_x_xx_x1260_symbol; -- control passed to block
        Xentry_1279_symbol  <= assign_stmt_315_1278_start; -- transition branch_block_stmt_304/assign_stmt_315/$entry
        assign_stmt_315_active_x_x1281_symbol <= type_cast_314_complete_1291_symbol; -- transition branch_block_stmt_304/assign_stmt_315/assign_stmt_315_active_
        assign_stmt_315_completed_x_x1282_symbol <= assign_stmt_315_active_x_x1281_symbol; -- transition branch_block_stmt_304/assign_stmt_315/assign_stmt_315_completed_
        type_cast_314_active_x_x1283_block : Block -- non-trivial join transition branch_block_stmt_304/assign_stmt_315/type_cast_314_active_ 
          signal type_cast_314_active_x_x1283_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_314_active_x_x1283_predecessors(0) <= type_cast_314_trigger_x_x1284_symbol;
          type_cast_314_active_x_x1283_predecessors(1) <= simple_obj_ref_313_complete_1286_symbol;
          type_cast_314_active_x_x1283_join: join -- 
            port map( -- 
              preds => type_cast_314_active_x_x1283_predecessors,
              symbol_out => type_cast_314_active_x_x1283_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_304/assign_stmt_315/type_cast_314_active_
        type_cast_314_trigger_x_x1284_symbol <= Xentry_1279_symbol; -- transition branch_block_stmt_304/assign_stmt_315/type_cast_314_trigger_
        simple_obj_ref_313_trigger_x_x1285_symbol <= Xentry_1279_symbol; -- transition branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_trigger_
        simple_obj_ref_313_complete_1286: Block -- branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_complete 
          signal simple_obj_ref_313_complete_1286_start: Boolean;
          signal Xentry_1287_symbol: Boolean;
          signal Xexit_1288_symbol: Boolean;
          signal req_1289_symbol : Boolean;
          signal ack_1290_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_313_complete_1286_start <= simple_obj_ref_313_trigger_x_x1285_symbol; -- control passed to block
          Xentry_1287_symbol  <= simple_obj_ref_313_complete_1286_start; -- transition branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_complete/$entry
          req_1289_symbol <= Xentry_1287_symbol; -- transition branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_complete/req
          simple_obj_ref_313_inst_req_0 <= req_1289_symbol; -- link to DP
          ack_1290_symbol <= simple_obj_ref_313_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_complete/ack
          Xexit_1288_symbol <= ack_1290_symbol; -- transition branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_complete/$exit
          simple_obj_ref_313_complete_1286_symbol <= Xexit_1288_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_315/simple_obj_ref_313_complete
        type_cast_314_complete_1291: Block -- branch_block_stmt_304/assign_stmt_315/type_cast_314_complete 
          signal type_cast_314_complete_1291_start: Boolean;
          signal Xentry_1292_symbol: Boolean;
          signal Xexit_1293_symbol: Boolean;
          signal req_1294_symbol : Boolean;
          signal ack_1295_symbol : Boolean;
          -- 
        begin -- 
          type_cast_314_complete_1291_start <= type_cast_314_active_x_x1283_symbol; -- control passed to block
          Xentry_1292_symbol  <= type_cast_314_complete_1291_start; -- transition branch_block_stmt_304/assign_stmt_315/type_cast_314_complete/$entry
          req_1294_symbol <= Xentry_1292_symbol; -- transition branch_block_stmt_304/assign_stmt_315/type_cast_314_complete/req
          type_cast_314_inst_req_0 <= req_1294_symbol; -- link to DP
          ack_1295_symbol <= type_cast_314_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_315/type_cast_314_complete/ack
          Xexit_1293_symbol <= ack_1295_symbol; -- transition branch_block_stmt_304/assign_stmt_315/type_cast_314_complete/$exit
          type_cast_314_complete_1291_symbol <= Xexit_1293_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_315/type_cast_314_complete
        Xexit_1280_symbol <= assign_stmt_315_completed_x_x1282_symbol; -- transition branch_block_stmt_304/assign_stmt_315/$exit
        assign_stmt_315_1278_symbol <= Xexit_1280_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_315
      assign_stmt_319_to_assign_stmt_332_1296: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332 
        signal assign_stmt_319_to_assign_stmt_332_1296_start: Boolean;
        signal Xentry_1297_symbol: Boolean;
        signal Xexit_1298_symbol: Boolean;
        signal assign_stmt_319_active_x_x1299_symbol : Boolean;
        signal assign_stmt_319_completed_x_x1300_symbol : Boolean;
        signal array_obj_ref_318_trigger_x_x1301_symbol : Boolean;
        signal array_obj_ref_318_active_x_x1302_symbol : Boolean;
        signal array_obj_ref_318_base_address_calculated_1303_symbol : Boolean;
        signal array_obj_ref_318_root_address_calculated_1304_symbol : Boolean;
        signal array_obj_ref_318_base_address_resized_1305_symbol : Boolean;
        signal array_obj_ref_318_base_addr_resize_1306_symbol : Boolean;
        signal array_obj_ref_318_base_plus_offset_1311_symbol : Boolean;
        signal array_obj_ref_318_complete_1316_symbol : Boolean;
        signal assign_stmt_323_active_x_x1321_symbol : Boolean;
        signal assign_stmt_323_completed_x_x1322_symbol : Boolean;
        signal type_cast_322_active_x_x1323_symbol : Boolean;
        signal type_cast_322_trigger_x_x1324_symbol : Boolean;
        signal simple_obj_ref_321_complete_1325_symbol : Boolean;
        signal type_cast_322_complete_1326_symbol : Boolean;
        signal assign_stmt_327_active_x_x1331_symbol : Boolean;
        signal assign_stmt_327_completed_x_x1332_symbol : Boolean;
        signal ptr_deref_326_trigger_x_x1333_symbol : Boolean;
        signal ptr_deref_326_active_x_x1334_symbol : Boolean;
        signal ptr_deref_326_base_address_calculated_1335_symbol : Boolean;
        signal simple_obj_ref_325_complete_1336_symbol : Boolean;
        signal ptr_deref_326_root_address_calculated_1337_symbol : Boolean;
        signal ptr_deref_326_word_address_calculated_1338_symbol : Boolean;
        signal ptr_deref_326_base_address_resized_1339_symbol : Boolean;
        signal ptr_deref_326_base_addr_resize_1340_symbol : Boolean;
        signal ptr_deref_326_base_plus_offset_1345_symbol : Boolean;
        signal ptr_deref_326_word_addrgen_1350_symbol : Boolean;
        signal ptr_deref_326_request_1355_symbol : Boolean;
        signal ptr_deref_326_complete_1366_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_319_to_assign_stmt_332_1296_start <= assign_stmt_319_to_assign_stmt_332_x_xentry_x_xx_x1262_symbol; -- control passed to block
        Xentry_1297_symbol  <= assign_stmt_319_to_assign_stmt_332_1296_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/$entry
        assign_stmt_319_active_x_x1299_symbol <= array_obj_ref_318_complete_1316_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/assign_stmt_319_active_
        assign_stmt_319_completed_x_x1300_symbol <= assign_stmt_319_active_x_x1299_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/assign_stmt_319_completed_
        array_obj_ref_318_trigger_x_x1301_symbol <= Xentry_1297_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_trigger_
        array_obj_ref_318_active_x_x1302_block : Block -- non-trivial join transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_active_ 
          signal array_obj_ref_318_active_x_x1302_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          array_obj_ref_318_active_x_x1302_predecessors(0) <= array_obj_ref_318_trigger_x_x1301_symbol;
          array_obj_ref_318_active_x_x1302_predecessors(1) <= array_obj_ref_318_root_address_calculated_1304_symbol;
          array_obj_ref_318_active_x_x1302_join: join -- 
            port map( -- 
              preds => array_obj_ref_318_active_x_x1302_predecessors,
              symbol_out => array_obj_ref_318_active_x_x1302_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_active_
        array_obj_ref_318_base_address_calculated_1303_symbol <= Xentry_1297_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_address_calculated
        array_obj_ref_318_root_address_calculated_1304_symbol <= array_obj_ref_318_base_plus_offset_1311_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_root_address_calculated
        array_obj_ref_318_base_address_resized_1305_symbol <= array_obj_ref_318_base_addr_resize_1306_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_address_resized
        array_obj_ref_318_base_addr_resize_1306: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_addr_resize 
          signal array_obj_ref_318_base_addr_resize_1306_start: Boolean;
          signal Xentry_1307_symbol: Boolean;
          signal Xexit_1308_symbol: Boolean;
          signal base_resize_req_1309_symbol : Boolean;
          signal base_resize_ack_1310_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_318_base_addr_resize_1306_start <= array_obj_ref_318_base_address_calculated_1303_symbol; -- control passed to block
          Xentry_1307_symbol  <= array_obj_ref_318_base_addr_resize_1306_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_addr_resize/$entry
          base_resize_req_1309_symbol <= Xentry_1307_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_addr_resize/base_resize_req
          array_obj_ref_318_base_resize_req_0 <= base_resize_req_1309_symbol; -- link to DP
          base_resize_ack_1310_symbol <= array_obj_ref_318_base_resize_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_addr_resize/base_resize_ack
          Xexit_1308_symbol <= base_resize_ack_1310_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_addr_resize/$exit
          array_obj_ref_318_base_addr_resize_1306_symbol <= Xexit_1308_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_addr_resize
        array_obj_ref_318_base_plus_offset_1311: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_plus_offset 
          signal array_obj_ref_318_base_plus_offset_1311_start: Boolean;
          signal Xentry_1312_symbol: Boolean;
          signal Xexit_1313_symbol: Boolean;
          signal sum_rename_req_1314_symbol : Boolean;
          signal sum_rename_ack_1315_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_318_base_plus_offset_1311_start <= array_obj_ref_318_base_address_resized_1305_symbol; -- control passed to block
          Xentry_1312_symbol  <= array_obj_ref_318_base_plus_offset_1311_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_plus_offset/$entry
          sum_rename_req_1314_symbol <= Xentry_1312_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_plus_offset/sum_rename_req
          array_obj_ref_318_root_address_inst_req_0 <= sum_rename_req_1314_symbol; -- link to DP
          sum_rename_ack_1315_symbol <= array_obj_ref_318_root_address_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_plus_offset/sum_rename_ack
          Xexit_1313_symbol <= sum_rename_ack_1315_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_plus_offset/$exit
          array_obj_ref_318_base_plus_offset_1311_symbol <= Xexit_1313_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_base_plus_offset
        array_obj_ref_318_complete_1316: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_complete 
          signal array_obj_ref_318_complete_1316_start: Boolean;
          signal Xentry_1317_symbol: Boolean;
          signal Xexit_1318_symbol: Boolean;
          signal final_reg_req_1319_symbol : Boolean;
          signal final_reg_ack_1320_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_318_complete_1316_start <= array_obj_ref_318_active_x_x1302_symbol; -- control passed to block
          Xentry_1317_symbol  <= array_obj_ref_318_complete_1316_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_complete/$entry
          final_reg_req_1319_symbol <= Xentry_1317_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_complete/final_reg_req
          array_obj_ref_318_final_reg_req_0 <= final_reg_req_1319_symbol; -- link to DP
          final_reg_ack_1320_symbol <= array_obj_ref_318_final_reg_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_complete/final_reg_ack
          Xexit_1318_symbol <= final_reg_ack_1320_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_complete/$exit
          array_obj_ref_318_complete_1316_symbol <= Xexit_1318_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/array_obj_ref_318_complete
        assign_stmt_323_active_x_x1321_symbol <= type_cast_322_complete_1326_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/assign_stmt_323_active_
        assign_stmt_323_completed_x_x1322_symbol <= assign_stmt_323_active_x_x1321_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/assign_stmt_323_completed_
        type_cast_322_active_x_x1323_block : Block -- non-trivial join transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_active_ 
          signal type_cast_322_active_x_x1323_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_322_active_x_x1323_predecessors(0) <= type_cast_322_trigger_x_x1324_symbol;
          type_cast_322_active_x_x1323_predecessors(1) <= simple_obj_ref_321_complete_1325_symbol;
          type_cast_322_active_x_x1323_join: join -- 
            port map( -- 
              preds => type_cast_322_active_x_x1323_predecessors,
              symbol_out => type_cast_322_active_x_x1323_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_active_
        type_cast_322_trigger_x_x1324_symbol <= Xentry_1297_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_trigger_
        simple_obj_ref_321_complete_1325_symbol <= assign_stmt_319_completed_x_x1300_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/simple_obj_ref_321_complete
        type_cast_322_complete_1326: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_complete 
          signal type_cast_322_complete_1326_start: Boolean;
          signal Xentry_1327_symbol: Boolean;
          signal Xexit_1328_symbol: Boolean;
          signal req_1329_symbol : Boolean;
          signal ack_1330_symbol : Boolean;
          -- 
        begin -- 
          type_cast_322_complete_1326_start <= type_cast_322_active_x_x1323_symbol; -- control passed to block
          Xentry_1327_symbol  <= type_cast_322_complete_1326_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_complete/$entry
          req_1329_symbol <= Xentry_1327_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_complete/req
          type_cast_322_inst_req_0 <= req_1329_symbol; -- link to DP
          ack_1330_symbol <= type_cast_322_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_complete/ack
          Xexit_1328_symbol <= ack_1330_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_complete/$exit
          type_cast_322_complete_1326_symbol <= Xexit_1328_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/type_cast_322_complete
        assign_stmt_327_active_x_x1331_symbol <= ptr_deref_326_complete_1366_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/assign_stmt_327_active_
        assign_stmt_327_completed_x_x1332_symbol <= assign_stmt_327_active_x_x1331_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/assign_stmt_327_completed_
        ptr_deref_326_trigger_x_x1333_block : Block -- non-trivial join transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_trigger_ 
          signal ptr_deref_326_trigger_x_x1333_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_326_trigger_x_x1333_predecessors(0) <= ptr_deref_326_word_address_calculated_1338_symbol;
          ptr_deref_326_trigger_x_x1333_predecessors(1) <= ptr_deref_326_base_address_calculated_1335_symbol;
          ptr_deref_326_trigger_x_x1333_join: join -- 
            port map( -- 
              preds => ptr_deref_326_trigger_x_x1333_predecessors,
              symbol_out => ptr_deref_326_trigger_x_x1333_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_trigger_
        ptr_deref_326_active_x_x1334_symbol <= ptr_deref_326_request_1355_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_active_
        ptr_deref_326_base_address_calculated_1335_symbol <= simple_obj_ref_325_complete_1336_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_address_calculated
        simple_obj_ref_325_complete_1336_symbol <= assign_stmt_323_completed_x_x1322_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/simple_obj_ref_325_complete
        ptr_deref_326_root_address_calculated_1337_symbol <= ptr_deref_326_base_plus_offset_1345_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_root_address_calculated
        ptr_deref_326_word_address_calculated_1338_symbol <= ptr_deref_326_word_addrgen_1350_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_address_calculated
        ptr_deref_326_base_address_resized_1339_symbol <= ptr_deref_326_base_addr_resize_1340_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_address_resized
        ptr_deref_326_base_addr_resize_1340: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_addr_resize 
          signal ptr_deref_326_base_addr_resize_1340_start: Boolean;
          signal Xentry_1341_symbol: Boolean;
          signal Xexit_1342_symbol: Boolean;
          signal base_resize_req_1343_symbol : Boolean;
          signal base_resize_ack_1344_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_326_base_addr_resize_1340_start <= ptr_deref_326_base_address_calculated_1335_symbol; -- control passed to block
          Xentry_1341_symbol  <= ptr_deref_326_base_addr_resize_1340_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_addr_resize/$entry
          base_resize_req_1343_symbol <= Xentry_1341_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_addr_resize/base_resize_req
          ptr_deref_326_base_resize_req_0 <= base_resize_req_1343_symbol; -- link to DP
          base_resize_ack_1344_symbol <= ptr_deref_326_base_resize_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_addr_resize/base_resize_ack
          Xexit_1342_symbol <= base_resize_ack_1344_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_addr_resize/$exit
          ptr_deref_326_base_addr_resize_1340_symbol <= Xexit_1342_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_addr_resize
        ptr_deref_326_base_plus_offset_1345: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_plus_offset 
          signal ptr_deref_326_base_plus_offset_1345_start: Boolean;
          signal Xentry_1346_symbol: Boolean;
          signal Xexit_1347_symbol: Boolean;
          signal sum_rename_req_1348_symbol : Boolean;
          signal sum_rename_ack_1349_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_326_base_plus_offset_1345_start <= ptr_deref_326_base_address_resized_1339_symbol; -- control passed to block
          Xentry_1346_symbol  <= ptr_deref_326_base_plus_offset_1345_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_plus_offset/$entry
          sum_rename_req_1348_symbol <= Xentry_1346_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_plus_offset/sum_rename_req
          ptr_deref_326_root_address_inst_req_0 <= sum_rename_req_1348_symbol; -- link to DP
          sum_rename_ack_1349_symbol <= ptr_deref_326_root_address_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_plus_offset/sum_rename_ack
          Xexit_1347_symbol <= sum_rename_ack_1349_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_plus_offset/$exit
          ptr_deref_326_base_plus_offset_1345_symbol <= Xexit_1347_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_base_plus_offset
        ptr_deref_326_word_addrgen_1350: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_addrgen 
          signal ptr_deref_326_word_addrgen_1350_start: Boolean;
          signal Xentry_1351_symbol: Boolean;
          signal Xexit_1352_symbol: Boolean;
          signal root_rename_req_1353_symbol : Boolean;
          signal root_rename_ack_1354_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_326_word_addrgen_1350_start <= ptr_deref_326_root_address_calculated_1337_symbol; -- control passed to block
          Xentry_1351_symbol  <= ptr_deref_326_word_addrgen_1350_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_addrgen/$entry
          root_rename_req_1353_symbol <= Xentry_1351_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_addrgen/root_rename_req
          ptr_deref_326_addr_0_req_0 <= root_rename_req_1353_symbol; -- link to DP
          root_rename_ack_1354_symbol <= ptr_deref_326_addr_0_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_addrgen/root_rename_ack
          Xexit_1352_symbol <= root_rename_ack_1354_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_addrgen/$exit
          ptr_deref_326_word_addrgen_1350_symbol <= Xexit_1352_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_word_addrgen
        ptr_deref_326_request_1355: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request 
          signal ptr_deref_326_request_1355_start: Boolean;
          signal Xentry_1356_symbol: Boolean;
          signal Xexit_1357_symbol: Boolean;
          signal word_access_1358_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_326_request_1355_start <= ptr_deref_326_trigger_x_x1333_symbol; -- control passed to block
          Xentry_1356_symbol  <= ptr_deref_326_request_1355_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/$entry
          word_access_1358: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access 
            signal word_access_1358_start: Boolean;
            signal Xentry_1359_symbol: Boolean;
            signal Xexit_1360_symbol: Boolean;
            signal word_access_0_1361_symbol : Boolean;
            -- 
          begin -- 
            word_access_1358_start <= Xentry_1356_symbol; -- control passed to block
            Xentry_1359_symbol  <= word_access_1358_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/$entry
            word_access_0_1361: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/word_access_0 
              signal word_access_0_1361_start: Boolean;
              signal Xentry_1362_symbol: Boolean;
              signal Xexit_1363_symbol: Boolean;
              signal rr_1364_symbol : Boolean;
              signal ra_1365_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1361_start <= Xentry_1359_symbol; -- control passed to block
              Xentry_1362_symbol  <= word_access_0_1361_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/word_access_0/$entry
              rr_1364_symbol <= Xentry_1362_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/word_access_0/rr
              ptr_deref_326_load_0_req_0 <= rr_1364_symbol; -- link to DP
              ra_1365_symbol <= ptr_deref_326_load_0_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/word_access_0/ra
              Xexit_1363_symbol <= ra_1365_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/word_access_0/$exit
              word_access_0_1361_symbol <= Xexit_1363_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/word_access_0
            Xexit_1360_symbol <= word_access_0_1361_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access/$exit
            word_access_1358_symbol <= Xexit_1360_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/word_access
          Xexit_1357_symbol <= word_access_1358_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request/$exit
          ptr_deref_326_request_1355_symbol <= Xexit_1357_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_request
        ptr_deref_326_complete_1366: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete 
          signal ptr_deref_326_complete_1366_start: Boolean;
          signal Xentry_1367_symbol: Boolean;
          signal Xexit_1368_symbol: Boolean;
          signal word_access_1369_symbol : Boolean;
          signal merge_req_1377_symbol : Boolean;
          signal merge_ack_1378_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_326_complete_1366_start <= ptr_deref_326_active_x_x1334_symbol; -- control passed to block
          Xentry_1367_symbol  <= ptr_deref_326_complete_1366_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/$entry
          word_access_1369: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access 
            signal word_access_1369_start: Boolean;
            signal Xentry_1370_symbol: Boolean;
            signal Xexit_1371_symbol: Boolean;
            signal word_access_0_1372_symbol : Boolean;
            -- 
          begin -- 
            word_access_1369_start <= Xentry_1367_symbol; -- control passed to block
            Xentry_1370_symbol  <= word_access_1369_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/$entry
            word_access_0_1372: Block -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/word_access_0 
              signal word_access_0_1372_start: Boolean;
              signal Xentry_1373_symbol: Boolean;
              signal Xexit_1374_symbol: Boolean;
              signal cr_1375_symbol : Boolean;
              signal ca_1376_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1372_start <= Xentry_1370_symbol; -- control passed to block
              Xentry_1373_symbol  <= word_access_0_1372_start; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/word_access_0/$entry
              cr_1375_symbol <= Xentry_1373_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/word_access_0/cr
              ptr_deref_326_load_0_req_1 <= cr_1375_symbol; -- link to DP
              ca_1376_symbol <= ptr_deref_326_load_0_ack_1; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/word_access_0/ca
              Xexit_1374_symbol <= ca_1376_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/word_access_0/$exit
              word_access_0_1372_symbol <= Xexit_1374_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/word_access_0
            Xexit_1371_symbol <= word_access_0_1372_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access/$exit
            word_access_1369_symbol <= Xexit_1371_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/word_access
          merge_req_1377_symbol <= word_access_1369_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/merge_req
          ptr_deref_326_gather_scatter_req_0 <= merge_req_1377_symbol; -- link to DP
          merge_ack_1378_symbol <= ptr_deref_326_gather_scatter_ack_0; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/merge_ack
          Xexit_1368_symbol <= merge_ack_1378_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete/$exit
          ptr_deref_326_complete_1366_symbol <= Xexit_1368_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/ptr_deref_326_complete
        Xexit_1298_symbol <= assign_stmt_327_completed_x_x1332_symbol; -- transition branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332/$exit
        assign_stmt_319_to_assign_stmt_332_1296_symbol <= Xexit_1298_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_319_to_assign_stmt_332
      assign_stmt_336_1379: Block -- branch_block_stmt_304/assign_stmt_336 
        signal assign_stmt_336_1379_start: Boolean;
        signal Xentry_1380_symbol: Boolean;
        signal Xexit_1381_symbol: Boolean;
        signal assign_stmt_336_active_x_x1382_symbol : Boolean;
        signal assign_stmt_336_completed_x_x1383_symbol : Boolean;
        signal type_cast_335_active_x_x1384_symbol : Boolean;
        signal type_cast_335_trigger_x_x1385_symbol : Boolean;
        signal simple_obj_ref_334_complete_1386_symbol : Boolean;
        signal type_cast_335_complete_1387_symbol : Boolean;
        signal simple_obj_ref_333_trigger_x_x1392_symbol : Boolean;
        signal simple_obj_ref_333_complete_1393_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_336_1379_start <= assign_stmt_336_x_xentry_x_xx_x1264_symbol; -- control passed to block
        Xentry_1380_symbol  <= assign_stmt_336_1379_start; -- transition branch_block_stmt_304/assign_stmt_336/$entry
        assign_stmt_336_active_x_x1382_symbol <= type_cast_335_complete_1387_symbol; -- transition branch_block_stmt_304/assign_stmt_336/assign_stmt_336_active_
        assign_stmt_336_completed_x_x1383_symbol <= simple_obj_ref_333_complete_1393_symbol; -- transition branch_block_stmt_304/assign_stmt_336/assign_stmt_336_completed_
        type_cast_335_active_x_x1384_block : Block -- non-trivial join transition branch_block_stmt_304/assign_stmt_336/type_cast_335_active_ 
          signal type_cast_335_active_x_x1384_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_335_active_x_x1384_predecessors(0) <= type_cast_335_trigger_x_x1385_symbol;
          type_cast_335_active_x_x1384_predecessors(1) <= simple_obj_ref_334_complete_1386_symbol;
          type_cast_335_active_x_x1384_join: join -- 
            port map( -- 
              preds => type_cast_335_active_x_x1384_predecessors,
              symbol_out => type_cast_335_active_x_x1384_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_304/assign_stmt_336/type_cast_335_active_
        type_cast_335_trigger_x_x1385_symbol <= Xentry_1380_symbol; -- transition branch_block_stmt_304/assign_stmt_336/type_cast_335_trigger_
        simple_obj_ref_334_complete_1386_symbol <= Xentry_1380_symbol; -- transition branch_block_stmt_304/assign_stmt_336/simple_obj_ref_334_complete
        type_cast_335_complete_1387: Block -- branch_block_stmt_304/assign_stmt_336/type_cast_335_complete 
          signal type_cast_335_complete_1387_start: Boolean;
          signal Xentry_1388_symbol: Boolean;
          signal Xexit_1389_symbol: Boolean;
          signal req_1390_symbol : Boolean;
          signal ack_1391_symbol : Boolean;
          -- 
        begin -- 
          type_cast_335_complete_1387_start <= type_cast_335_active_x_x1384_symbol; -- control passed to block
          Xentry_1388_symbol  <= type_cast_335_complete_1387_start; -- transition branch_block_stmt_304/assign_stmt_336/type_cast_335_complete/$entry
          req_1390_symbol <= Xentry_1388_symbol; -- transition branch_block_stmt_304/assign_stmt_336/type_cast_335_complete/req
          type_cast_335_inst_req_0 <= req_1390_symbol; -- link to DP
          ack_1391_symbol <= type_cast_335_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_336/type_cast_335_complete/ack
          Xexit_1389_symbol <= ack_1391_symbol; -- transition branch_block_stmt_304/assign_stmt_336/type_cast_335_complete/$exit
          type_cast_335_complete_1387_symbol <= Xexit_1389_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_336/type_cast_335_complete
        simple_obj_ref_333_trigger_x_x1392_symbol <= assign_stmt_336_active_x_x1382_symbol; -- transition branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_trigger_
        simple_obj_ref_333_complete_1393: Block -- branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_complete 
          signal simple_obj_ref_333_complete_1393_start: Boolean;
          signal Xentry_1394_symbol: Boolean;
          signal Xexit_1395_symbol: Boolean;
          signal pipe_wreq_1396_symbol : Boolean;
          signal pipe_wack_1397_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_333_complete_1393_start <= simple_obj_ref_333_trigger_x_x1392_symbol; -- control passed to block
          Xentry_1394_symbol  <= simple_obj_ref_333_complete_1393_start; -- transition branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_complete/$entry
          pipe_wreq_1396_symbol <= Xentry_1394_symbol; -- transition branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_complete/pipe_wreq
          simple_obj_ref_333_inst_req_0 <= pipe_wreq_1396_symbol; -- link to DP
          pipe_wack_1397_symbol <= simple_obj_ref_333_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_complete/pipe_wack
          Xexit_1395_symbol <= pipe_wack_1397_symbol; -- transition branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_complete/$exit
          simple_obj_ref_333_complete_1393_symbol <= Xexit_1395_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_336/simple_obj_ref_333_complete
        Xexit_1381_symbol <= assign_stmt_336_completed_x_x1383_symbol; -- transition branch_block_stmt_304/assign_stmt_336/$exit
        assign_stmt_336_1379_symbol <= Xexit_1381_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_336
      assign_stmt_341_1398: Block -- branch_block_stmt_304/assign_stmt_341 
        signal assign_stmt_341_1398_start: Boolean;
        signal Xentry_1399_symbol: Boolean;
        signal Xexit_1400_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_341_1398_start <= assign_stmt_341_x_xentry_x_xx_x1266_symbol; -- control passed to block
        Xentry_1399_symbol  <= assign_stmt_341_1398_start; -- transition branch_block_stmt_304/assign_stmt_341/$entry
        Xexit_1400_symbol <= Xentry_1399_symbol; -- transition branch_block_stmt_304/assign_stmt_341/$exit
        assign_stmt_341_1398_symbol <= Xexit_1400_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_341
      assign_stmt_345_1401: Block -- branch_block_stmt_304/assign_stmt_345 
        signal assign_stmt_345_1401_start: Boolean;
        signal Xentry_1402_symbol: Boolean;
        signal Xexit_1403_symbol: Boolean;
        signal assign_stmt_345_active_x_x1404_symbol : Boolean;
        signal assign_stmt_345_completed_x_x1405_symbol : Boolean;
        signal simple_obj_ref_342_trigger_x_x1406_symbol : Boolean;
        signal simple_obj_ref_342_complete_1407_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_345_1401_start <= assign_stmt_345_x_xentry_x_xx_x1268_symbol; -- control passed to block
        Xentry_1402_symbol  <= assign_stmt_345_1401_start; -- transition branch_block_stmt_304/assign_stmt_345/$entry
        assign_stmt_345_active_x_x1404_symbol <= Xentry_1402_symbol; -- transition branch_block_stmt_304/assign_stmt_345/assign_stmt_345_active_
        assign_stmt_345_completed_x_x1405_symbol <= simple_obj_ref_342_complete_1407_symbol; -- transition branch_block_stmt_304/assign_stmt_345/assign_stmt_345_completed_
        simple_obj_ref_342_trigger_x_x1406_symbol <= assign_stmt_345_active_x_x1404_symbol; -- transition branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_trigger_
        simple_obj_ref_342_complete_1407: Block -- branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_complete 
          signal simple_obj_ref_342_complete_1407_start: Boolean;
          signal Xentry_1408_symbol: Boolean;
          signal Xexit_1409_symbol: Boolean;
          signal pipe_wreq_1410_symbol : Boolean;
          signal pipe_wack_1411_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_342_complete_1407_start <= simple_obj_ref_342_trigger_x_x1406_symbol; -- control passed to block
          Xentry_1408_symbol  <= simple_obj_ref_342_complete_1407_start; -- transition branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_complete/$entry
          pipe_wreq_1410_symbol <= Xentry_1408_symbol; -- transition branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_complete/pipe_wreq
          simple_obj_ref_342_inst_req_0 <= pipe_wreq_1410_symbol; -- link to DP
          pipe_wack_1411_symbol <= simple_obj_ref_342_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_complete/pipe_wack
          Xexit_1409_symbol <= pipe_wack_1411_symbol; -- transition branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_complete/$exit
          simple_obj_ref_342_complete_1407_symbol <= Xexit_1409_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_345/simple_obj_ref_342_complete
        Xexit_1403_symbol <= assign_stmt_345_completed_x_x1405_symbol; -- transition branch_block_stmt_304/assign_stmt_345/$exit
        assign_stmt_345_1401_symbol <= Xexit_1403_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_345
      assign_stmt_350_1412: Block -- branch_block_stmt_304/assign_stmt_350 
        signal assign_stmt_350_1412_start: Boolean;
        signal Xentry_1413_symbol: Boolean;
        signal Xexit_1414_symbol: Boolean;
        -- 
      begin -- 
        assign_stmt_350_1412_start <= assign_stmt_350_x_xentry_x_xx_x1270_symbol; -- control passed to block
        Xentry_1413_symbol  <= assign_stmt_350_1412_start; -- transition branch_block_stmt_304/assign_stmt_350/$entry
        Xexit_1414_symbol <= Xentry_1413_symbol; -- transition branch_block_stmt_304/assign_stmt_350/$exit
        assign_stmt_350_1412_symbol <= Xexit_1414_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_350
      assign_stmt_354_1415: Block -- branch_block_stmt_304/assign_stmt_354 
        signal assign_stmt_354_1415_start: Boolean;
        signal Xentry_1416_symbol: Boolean;
        signal Xexit_1417_symbol: Boolean;
        signal assign_stmt_354_active_x_x1418_symbol : Boolean;
        signal assign_stmt_354_completed_x_x1419_symbol : Boolean;
        signal type_cast_353_active_x_x1420_symbol : Boolean;
        signal type_cast_353_trigger_x_x1421_symbol : Boolean;
        signal simple_obj_ref_352_complete_1422_symbol : Boolean;
        signal type_cast_353_complete_1423_symbol : Boolean;
        signal simple_obj_ref_351_trigger_x_x1428_symbol : Boolean;
        signal simple_obj_ref_351_complete_1429_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_354_1415_start <= assign_stmt_354_x_xentry_x_xx_x1272_symbol; -- control passed to block
        Xentry_1416_symbol  <= assign_stmt_354_1415_start; -- transition branch_block_stmt_304/assign_stmt_354/$entry
        assign_stmt_354_active_x_x1418_symbol <= type_cast_353_complete_1423_symbol; -- transition branch_block_stmt_304/assign_stmt_354/assign_stmt_354_active_
        assign_stmt_354_completed_x_x1419_symbol <= simple_obj_ref_351_complete_1429_symbol; -- transition branch_block_stmt_304/assign_stmt_354/assign_stmt_354_completed_
        type_cast_353_active_x_x1420_block : Block -- non-trivial join transition branch_block_stmt_304/assign_stmt_354/type_cast_353_active_ 
          signal type_cast_353_active_x_x1420_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_353_active_x_x1420_predecessors(0) <= type_cast_353_trigger_x_x1421_symbol;
          type_cast_353_active_x_x1420_predecessors(1) <= simple_obj_ref_352_complete_1422_symbol;
          type_cast_353_active_x_x1420_join: join -- 
            port map( -- 
              preds => type_cast_353_active_x_x1420_predecessors,
              symbol_out => type_cast_353_active_x_x1420_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_304/assign_stmt_354/type_cast_353_active_
        type_cast_353_trigger_x_x1421_symbol <= Xentry_1416_symbol; -- transition branch_block_stmt_304/assign_stmt_354/type_cast_353_trigger_
        simple_obj_ref_352_complete_1422_symbol <= Xentry_1416_symbol; -- transition branch_block_stmt_304/assign_stmt_354/simple_obj_ref_352_complete
        type_cast_353_complete_1423: Block -- branch_block_stmt_304/assign_stmt_354/type_cast_353_complete 
          signal type_cast_353_complete_1423_start: Boolean;
          signal Xentry_1424_symbol: Boolean;
          signal Xexit_1425_symbol: Boolean;
          signal req_1426_symbol : Boolean;
          signal ack_1427_symbol : Boolean;
          -- 
        begin -- 
          type_cast_353_complete_1423_start <= type_cast_353_active_x_x1420_symbol; -- control passed to block
          Xentry_1424_symbol  <= type_cast_353_complete_1423_start; -- transition branch_block_stmt_304/assign_stmt_354/type_cast_353_complete/$entry
          req_1426_symbol <= Xentry_1424_symbol; -- transition branch_block_stmt_304/assign_stmt_354/type_cast_353_complete/req
          type_cast_353_inst_req_0 <= req_1426_symbol; -- link to DP
          ack_1427_symbol <= type_cast_353_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_354/type_cast_353_complete/ack
          Xexit_1425_symbol <= ack_1427_symbol; -- transition branch_block_stmt_304/assign_stmt_354/type_cast_353_complete/$exit
          type_cast_353_complete_1423_symbol <= Xexit_1425_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_354/type_cast_353_complete
        simple_obj_ref_351_trigger_x_x1428_symbol <= assign_stmt_354_active_x_x1418_symbol; -- transition branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_trigger_
        simple_obj_ref_351_complete_1429: Block -- branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_complete 
          signal simple_obj_ref_351_complete_1429_start: Boolean;
          signal Xentry_1430_symbol: Boolean;
          signal Xexit_1431_symbol: Boolean;
          signal pipe_wreq_1432_symbol : Boolean;
          signal pipe_wack_1433_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_351_complete_1429_start <= simple_obj_ref_351_trigger_x_x1428_symbol; -- control passed to block
          Xentry_1430_symbol  <= simple_obj_ref_351_complete_1429_start; -- transition branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_complete/$entry
          pipe_wreq_1432_symbol <= Xentry_1430_symbol; -- transition branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_complete/pipe_wreq
          simple_obj_ref_351_inst_req_0 <= pipe_wreq_1432_symbol; -- link to DP
          pipe_wack_1433_symbol <= simple_obj_ref_351_inst_ack_0; -- transition branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_complete/pipe_wack
          Xexit_1431_symbol <= pipe_wack_1433_symbol; -- transition branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_complete/$exit
          simple_obj_ref_351_complete_1429_symbol <= Xexit_1431_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_304/assign_stmt_354/simple_obj_ref_351_complete
        Xexit_1417_symbol <= assign_stmt_354_completed_x_x1419_symbol; -- transition branch_block_stmt_304/assign_stmt_354/$exit
        assign_stmt_354_1415_symbol <= Xexit_1417_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/assign_stmt_354
      bb_0_bb_1_PhiReq_1434: Block -- branch_block_stmt_304/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_1434_start: Boolean;
        signal Xentry_1435_symbol: Boolean;
        signal Xexit_1436_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_1434_start <= bb_0_bb_1_1256_symbol; -- control passed to block
        Xentry_1435_symbol  <= bb_0_bb_1_PhiReq_1434_start; -- transition branch_block_stmt_304/bb_0_bb_1_PhiReq/$entry
        Xexit_1436_symbol <= Xentry_1435_symbol; -- transition branch_block_stmt_304/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_1434_symbol <= Xexit_1436_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/bb_0_bb_1_PhiReq
      bb_1_bb_1_PhiReq_1437: Block -- branch_block_stmt_304/bb_1_bb_1_PhiReq 
        signal bb_1_bb_1_PhiReq_1437_start: Boolean;
        signal Xentry_1438_symbol: Boolean;
        signal Xexit_1439_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_1_PhiReq_1437_start <= bb_1_bb_1_1274_symbol; -- control passed to block
        Xentry_1438_symbol  <= bb_1_bb_1_PhiReq_1437_start; -- transition branch_block_stmt_304/bb_1_bb_1_PhiReq/$entry
        Xexit_1439_symbol <= Xentry_1438_symbol; -- transition branch_block_stmt_304/bb_1_bb_1_PhiReq/$exit
        bb_1_bb_1_PhiReq_1437_symbol <= Xexit_1439_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/bb_1_bb_1_PhiReq
      merge_stmt_306_PhiReqMerge_1440_symbol  <=  bb_0_bb_1_PhiReq_1434_symbol or bb_1_bb_1_PhiReq_1437_symbol; -- place branch_block_stmt_304/merge_stmt_306_PhiReqMerge (optimized away) 
      merge_stmt_306_PhiAck_1441: Block -- branch_block_stmt_304/merge_stmt_306_PhiAck 
        signal merge_stmt_306_PhiAck_1441_start: Boolean;
        signal Xentry_1442_symbol: Boolean;
        signal Xexit_1443_symbol: Boolean;
        signal dummy_1444_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_306_PhiAck_1441_start <= merge_stmt_306_PhiReqMerge_1440_symbol; -- control passed to block
        Xentry_1442_symbol  <= merge_stmt_306_PhiAck_1441_start; -- transition branch_block_stmt_304/merge_stmt_306_PhiAck/$entry
        dummy_1444_symbol <= Xentry_1442_symbol; -- transition branch_block_stmt_304/merge_stmt_306_PhiAck/dummy
        Xexit_1443_symbol <= dummy_1444_symbol; -- transition branch_block_stmt_304/merge_stmt_306_PhiAck/$exit
        merge_stmt_306_PhiAck_1441_symbol <= Xexit_1443_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_304/merge_stmt_306_PhiAck
      Xexit_1253_symbol <= branch_block_stmt_304_x_xexit_x_xx_x1255_symbol; -- transition branch_block_stmt_304/$exit
      branch_block_stmt_304_1251_symbol <= Xexit_1253_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_304
    Xexit_1250_symbol <= branch_block_stmt_304_1251_symbol; -- transition $exit
    fin  <=  '1' when Xexit_1250_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_318_resized_base_address : std_logic_vector(2 downto 0);
    signal array_obj_ref_318_root_address : std_logic_vector(2 downto 0);
    signal iNsTr_10_350 : std_logic_vector(31 downto 0);
    signal iNsTr_1_311 : std_logic_vector(31 downto 0);
    signal iNsTr_2_315 : std_logic_vector(31 downto 0);
    signal iNsTr_3_319 : std_logic_vector(31 downto 0);
    signal iNsTr_4_323 : std_logic_vector(31 downto 0);
    signal iNsTr_5_327 : std_logic_vector(31 downto 0);
    signal iNsTr_6_332 : std_logic_vector(31 downto 0);
    signal iNsTr_8_341 : std_logic_vector(31 downto 0);
    signal ptr_deref_326_data_0 : std_logic_vector(31 downto 0);
    signal ptr_deref_326_resized_base_address : std_logic_vector(2 downto 0);
    signal ptr_deref_326_root_address : std_logic_vector(2 downto 0);
    signal ptr_deref_326_word_address_0 : std_logic_vector(2 downto 0);
    signal ptr_deref_326_word_offset_0 : std_logic_vector(2 downto 0);
    signal simple_obj_ref_313_wire : std_logic_vector(31 downto 0);
    signal type_cast_335_wire : std_logic_vector(31 downto 0);
    signal type_cast_344_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_353_wire : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    iNsTr_10_350 <= "00000000000000000000000000000000";
    iNsTr_1_311 <= "00000000000000000000000000000000";
    iNsTr_6_332 <= "00000000000000000000000000000000";
    iNsTr_8_341 <= "00000000000000000000000000000000";
    ptr_deref_326_word_offset_0 <= "000";
    type_cast_344_wire_constant <= "00000001";
    array_obj_ref_318_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_2_315, dout => array_obj_ref_318_resized_base_address, req => array_obj_ref_318_base_resize_req_0, ack => array_obj_ref_318_base_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_318_final_reg: RegisterBase generic map(in_data_width => 3,out_data_width => 32) -- 
      port map( din => array_obj_ref_318_root_address, dout => iNsTr_3_319, req => array_obj_ref_318_final_reg_req_0, ack => array_obj_ref_318_final_reg_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_326_base_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 3) -- 
      port map( din => iNsTr_4_323, dout => ptr_deref_326_resized_base_address, req => ptr_deref_326_base_resize_req_0, ack => ptr_deref_326_base_resize_ack_0, clk => clk, reset => reset); -- 
    type_cast_314_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_313_wire, dout => iNsTr_2_315, req => type_cast_314_inst_req_0, ack => type_cast_314_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_322_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_3_319, dout => iNsTr_4_323, req => type_cast_322_inst_req_0, ack => type_cast_322_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_335_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_5_327, dout => type_cast_335_wire, req => type_cast_335_inst_req_0, ack => type_cast_335_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_353_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_2_315, dout => type_cast_353_wire, req => type_cast_353_inst_req_0, ack => type_cast_353_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_318_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      array_obj_ref_318_root_address_inst_ack_0 <= array_obj_ref_318_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_318_resized_base_address;
      array_obj_ref_318_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_326_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_326_addr_0_ack_0 <= ptr_deref_326_addr_0_req_0;
      aggregated_sig <= ptr_deref_326_root_address;
      ptr_deref_326_word_address_0 <= aggregated_sig(2 downto 0);
      --
    end Block;
    ptr_deref_326_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_326_gather_scatter_ack_0 <= ptr_deref_326_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_326_data_0;
      iNsTr_5_327 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_326_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(2 downto 0); --
    begin -- 
      ptr_deref_326_root_address_inst_ack_0 <= ptr_deref_326_root_address_inst_req_0;
      aggregated_sig <= ptr_deref_326_resized_base_address;
      ptr_deref_326_root_address <= aggregated_sig(2 downto 0);
      --
    end Block;
    -- shared load operator group (0) : ptr_deref_326_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(2 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_326_load_0_req_0;
      ptr_deref_326_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_326_load_0_req_1;
      ptr_deref_326_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_326_word_address_0;
      ptr_deref_326_data_0 <= data_out(31 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 3,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_1_lr_req(0),
          mack => memory_space_1_lr_ack(0),
          maddr => memory_space_1_lr_addr(2 downto 0),
          mtag => memory_space_1_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 32,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_1_lc_req(0),
          mack => memory_space_1_lc_ack(0),
          mdata => memory_space_1_lc_data(31 downto 0),
          mtag => memory_space_1_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared inport operator group (0) : simple_obj_ref_313_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_313_inst_req_0;
      simple_obj_ref_313_inst_ack_0 <= ack(0);
      simple_obj_ref_313_wire <= data_out(31 downto 0);
      Inport: InputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (-- 
          req => req , 
          ack => ack , 
          data => data_out, 
          oreq => foo_out_pipe_read_req(0),
          oack => foo_out_pipe_read_ack(0),
          odata => foo_out_pipe_read_data(31 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- inport group 0
    -- shared outport operator group (0) : simple_obj_ref_333_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_333_inst_req_0;
      simple_obj_ref_333_inst_ack_0 <= ack(0);
      data_in <= type_cast_335_wire;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => output_data_pipe_write_req(0),
          oack => output_data_pipe_write_ack(0),
          odata => output_data_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 0
    -- shared outport operator group (1) : simple_obj_ref_342_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_342_inst_req_0;
      simple_obj_ref_342_inst_ack_0 <= ack(0);
      data_in <= type_cast_344_wire_constant;
      outport: OutputPort -- 
        generic map ( data_width => 8,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => free_queue_request_pipe_write_req(0),
          oack => free_queue_request_pipe_write_ack(0),
          odata => free_queue_request_pipe_write_data(7 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 1
    -- shared outport operator group (2) : simple_obj_ref_351_inst 
    OutportGroup2: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_351_inst_req_0;
      simple_obj_ref_351_inst_ack_0 <= ack(0);
      data_in <= type_cast_353_wire;
      outport: OutputPort -- 
        generic map ( data_width => 32,  num_reqs => 1,  no_arbitration => true)
        port map (--
          req => req , 
          ack => ack , 
          data => data_in, 
          oreq => free_queue_put_pipe_write_req(0),
          oack => free_queue_put_pipe_write_ack(0),
          odata => free_queue_put_pipe_write_data(31 downto 0),
          clk => clk, reset => reset -- 
        );-- 
      -- 
    end Block; -- outport group 2
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
entity test_system is  -- system 
  port (-- 
    clk : in std_logic;
    reset : in std_logic;
    input_data_pipe_write_data: in std_logic_vector(31 downto 0);
    input_data_pipe_write_req : in std_logic_vector(0 downto 0);
    input_data_pipe_write_ack : out std_logic_vector(0 downto 0);
    output_data_pipe_read_data: out std_logic_vector(31 downto 0);
    output_data_pipe_read_req : in std_logic_vector(0 downto 0);
    output_data_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
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
  signal memory_space_0_lc_data : std_logic_vector(7 downto 0);
  signal memory_space_0_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_0_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(0 downto 0);
  -- interface signals to connect to memory space memory_space_1
  signal memory_space_1_lr_req :  std_logic_vector(2 downto 0);
  signal memory_space_1_lr_ack : std_logic_vector(2 downto 0);
  signal memory_space_1_lr_addr : std_logic_vector(8 downto 0);
  signal memory_space_1_lr_tag : std_logic_vector(5 downto 0);
  signal memory_space_1_lc_req : std_logic_vector(2 downto 0);
  signal memory_space_1_lc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_1_lc_data : std_logic_vector(95 downto 0);
  signal memory_space_1_lc_tag :  std_logic_vector(5 downto 0);
  signal memory_space_1_sr_req :  std_logic_vector(3 downto 0);
  signal memory_space_1_sr_ack : std_logic_vector(3 downto 0);
  signal memory_space_1_sr_addr : std_logic_vector(11 downto 0);
  signal memory_space_1_sr_data : std_logic_vector(127 downto 0);
  signal memory_space_1_sr_tag : std_logic_vector(7 downto 0);
  signal memory_space_1_sc_req : std_logic_vector(3 downto 0);
  signal memory_space_1_sc_ack :  std_logic_vector(3 downto 0);
  signal memory_space_1_sc_tag :  std_logic_vector(7 downto 0);
  -- interface signals to connect to memory space memory_space_2
  signal memory_space_2_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_2_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_2_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_lc_data : std_logic_vector(31 downto 0);
  signal memory_space_2_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_2_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_2_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_2_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_2_sr_data : std_logic_vector(31 downto 0);
  signal memory_space_2_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_2_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_2_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_2_sc_tag :  std_logic_vector(1 downto 0);
  -- interface signals to connect to memory space memory_space_3
  -- interface signals to connect to memory space memory_space_4
  -- interface signals to connect to memory space memory_space_5
  -- interface signals to connect to memory space memory_space_6
  -- interface signals to connect to memory space memory_space_7
  -- interface signals to connect to memory space memory_space_8
  -- interface signals to connect to memory space memory_space_9
  -- declarations related to module foo
  component foo is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(2 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(2 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
      foo_in_pipe_read_req : out  std_logic_vector(0 downto 0);
      foo_in_pipe_read_ack : in   std_logic_vector(0 downto 0);
      foo_in_pipe_read_data : in   std_logic_vector(31 downto 0);
      foo_out_pipe_write_req : out  std_logic_vector(0 downto 0);
      foo_out_pipe_write_ack : in   std_logic_vector(0 downto 0);
      foo_out_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module foo
  signal foo_tag_in    : std_logic_vector(0 downto 0);
  signal foo_tag_out   : std_logic_vector(0 downto 0);
  signal foo_start : std_logic;
  signal foo_fin   : std_logic;
  -- declarations related to module free_queue_manager
  component free_queue_manager is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(2 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_2_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_2_lc_tag :  in  std_logic_vector(1 downto 0);
      memory_space_1_sr_req : out  std_logic_vector(1 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(1 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(5 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(63 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(3 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(1 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(1 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(3 downto 0);
      memory_space_2_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_2_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_2_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_2_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_2_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_2_sc_tag :  in  std_logic_vector(1 downto 0);
      free_queue_put_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_put_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_put_pipe_read_data : in   std_logic_vector(31 downto 0);
      free_queue_request_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_request_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_request_pipe_read_data : in   std_logic_vector(7 downto 0);
      free_queue_get_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_get_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_get_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module free_queue_manager
  signal free_queue_manager_tag_in    : std_logic_vector(0 downto 0);
  signal free_queue_manager_tag_out   : std_logic_vector(0 downto 0);
  signal free_queue_manager_start : std_logic;
  signal free_queue_manager_fin   : std_logic;
  -- declarations related to module input_module
  component input_module is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_1_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sr_addr : out  std_logic_vector(2 downto 0);
      memory_space_1_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_1_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_sc_tag :  in  std_logic_vector(1 downto 0);
      free_queue_get_pipe_read_req : out  std_logic_vector(0 downto 0);
      free_queue_get_pipe_read_ack : in   std_logic_vector(0 downto 0);
      free_queue_get_pipe_read_data : in   std_logic_vector(31 downto 0);
      input_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      input_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      input_data_pipe_read_data : in   std_logic_vector(31 downto 0);
      foo_in_pipe_write_req : out  std_logic_vector(0 downto 0);
      foo_in_pipe_write_ack : in   std_logic_vector(0 downto 0);
      foo_in_pipe_write_data : out  std_logic_vector(31 downto 0);
      free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module input_module
  signal input_module_tag_in    : std_logic_vector(0 downto 0);
  signal input_module_tag_out   : std_logic_vector(0 downto 0);
  signal input_module_start : std_logic;
  signal input_module_fin   : std_logic;
  -- declarations related to module mem_load_x_x
  component mem_load_x_x is -- 
    port ( -- 
      address : in  std_logic_vector(31 downto 0);
      data : out  std_logic_vector(7 downto 0);
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
      memory_space_0_lc_data : in   std_logic_vector(7 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module mem_load_x_x
  signal mem_load_x_x_address :  std_logic_vector(31 downto 0);
  signal mem_load_x_x_data :  std_logic_vector(7 downto 0);
  signal mem_load_x_x_in_args    : std_logic_vector(31 downto 0);
  signal mem_load_x_x_out_args   : std_logic_vector(7 downto 0);
  signal mem_load_x_x_tag_in    : std_logic_vector(0 downto 0);
  signal mem_load_x_x_tag_out   : std_logic_vector(0 downto 0);
  signal mem_load_x_x_start : std_logic;
  signal mem_load_x_x_fin   : std_logic;
  -- declarations related to module mem_store_x_x
  component mem_store_x_x is -- 
    port ( -- 
      address : in  std_logic_vector(31 downto 0);
      data : in  std_logic_vector(7 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_0_sr_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(0 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(7 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(0 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(0 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module mem_store_x_x
  signal mem_store_x_x_address :  std_logic_vector(31 downto 0);
  signal mem_store_x_x_data :  std_logic_vector(7 downto 0);
  signal mem_store_x_x_in_args    : std_logic_vector(39 downto 0);
  signal mem_store_x_x_tag_in    : std_logic_vector(0 downto 0);
  signal mem_store_x_x_tag_out   : std_logic_vector(0 downto 0);
  signal mem_store_x_x_start : std_logic;
  signal mem_store_x_x_fin   : std_logic;
  -- declarations related to module output_module
  component output_module is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_1_lr_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lr_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lr_addr : out  std_logic_vector(2 downto 0);
      memory_space_1_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_1_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_1_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_1_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_1_lc_tag :  in  std_logic_vector(1 downto 0);
      foo_out_pipe_read_req : out  std_logic_vector(0 downto 0);
      foo_out_pipe_read_ack : in   std_logic_vector(0 downto 0);
      foo_out_pipe_read_data : in   std_logic_vector(31 downto 0);
      free_queue_put_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_put_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_put_pipe_write_data : out  std_logic_vector(31 downto 0);
      free_queue_request_pipe_write_req : out  std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_ack : in   std_logic_vector(0 downto 0);
      free_queue_request_pipe_write_data : out  std_logic_vector(7 downto 0);
      output_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      output_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      output_data_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module output_module
  signal output_module_tag_in    : std_logic_vector(0 downto 0);
  signal output_module_tag_out   : std_logic_vector(0 downto 0);
  signal output_module_start : std_logic;
  signal output_module_fin   : std_logic;
  -- aggregate signals for write to pipe foo_in
  signal foo_in_pipe_write_data: std_logic_vector(31 downto 0);
  signal foo_in_pipe_write_req: std_logic_vector(0 downto 0);
  signal foo_in_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe foo_in
  signal foo_in_pipe_read_data: std_logic_vector(31 downto 0);
  signal foo_in_pipe_read_req: std_logic_vector(0 downto 0);
  signal foo_in_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe foo_out
  signal foo_out_pipe_write_data: std_logic_vector(31 downto 0);
  signal foo_out_pipe_write_req: std_logic_vector(0 downto 0);
  signal foo_out_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe foo_out
  signal foo_out_pipe_read_data: std_logic_vector(31 downto 0);
  signal foo_out_pipe_read_req: std_logic_vector(0 downto 0);
  signal foo_out_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe free_queue_get
  signal free_queue_get_pipe_write_data: std_logic_vector(31 downto 0);
  signal free_queue_get_pipe_write_req: std_logic_vector(0 downto 0);
  signal free_queue_get_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe free_queue_get
  signal free_queue_get_pipe_read_data: std_logic_vector(31 downto 0);
  signal free_queue_get_pipe_read_req: std_logic_vector(0 downto 0);
  signal free_queue_get_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe free_queue_put
  signal free_queue_put_pipe_write_data: std_logic_vector(31 downto 0);
  signal free_queue_put_pipe_write_req: std_logic_vector(0 downto 0);
  signal free_queue_put_pipe_write_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe free_queue_put
  signal free_queue_put_pipe_read_data: std_logic_vector(31 downto 0);
  signal free_queue_put_pipe_read_req: std_logic_vector(0 downto 0);
  signal free_queue_put_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe free_queue_request
  signal free_queue_request_pipe_write_data: std_logic_vector(15 downto 0);
  signal free_queue_request_pipe_write_req: std_logic_vector(1 downto 0);
  signal free_queue_request_pipe_write_ack: std_logic_vector(1 downto 0);
  -- aggregate signals for read from pipe free_queue_request
  signal free_queue_request_pipe_read_data: std_logic_vector(7 downto 0);
  signal free_queue_request_pipe_read_req: std_logic_vector(0 downto 0);
  signal free_queue_request_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for read from pipe input_data
  signal input_data_pipe_read_data: std_logic_vector(31 downto 0);
  signal input_data_pipe_read_req: std_logic_vector(0 downto 0);
  signal input_data_pipe_read_ack: std_logic_vector(0 downto 0);
  -- aggregate signals for write to pipe output_data
  signal output_data_pipe_write_data: std_logic_vector(31 downto 0);
  signal output_data_pipe_write_req: std_logic_vector(0 downto 0);
  signal output_data_pipe_write_ack: std_logic_vector(0 downto 0);
  -- 
begin -- 
  -- module foo
  foo_instance:foo-- 
    port map(-- 
      start => foo_start,
      fin => foo_fin,
      clk => clk,
      reset => reset,
      memory_space_1_lr_req => memory_space_1_lr_req(2 downto 2),
      memory_space_1_lr_ack => memory_space_1_lr_ack(2 downto 2),
      memory_space_1_lr_addr => memory_space_1_lr_addr(8 downto 6),
      memory_space_1_lr_tag => memory_space_1_lr_tag(5 downto 4),
      memory_space_1_lc_req => memory_space_1_lc_req(2 downto 2),
      memory_space_1_lc_ack => memory_space_1_lc_ack(2 downto 2),
      memory_space_1_lc_data => memory_space_1_lc_data(95 downto 64),
      memory_space_1_lc_tag => memory_space_1_lc_tag(5 downto 4),
      memory_space_1_sr_req => memory_space_1_sr_req(3 downto 3),
      memory_space_1_sr_ack => memory_space_1_sr_ack(3 downto 3),
      memory_space_1_sr_addr => memory_space_1_sr_addr(11 downto 9),
      memory_space_1_sr_data => memory_space_1_sr_data(127 downto 96),
      memory_space_1_sr_tag => memory_space_1_sr_tag(7 downto 6),
      memory_space_1_sc_req => memory_space_1_sc_req(3 downto 3),
      memory_space_1_sc_ack => memory_space_1_sc_ack(3 downto 3),
      memory_space_1_sc_tag => memory_space_1_sc_tag(7 downto 6),
      foo_in_pipe_read_req => foo_in_pipe_read_req(0 downto 0),
      foo_in_pipe_read_ack => foo_in_pipe_read_ack(0 downto 0),
      foo_in_pipe_read_data => foo_in_pipe_read_data(31 downto 0),
      foo_out_pipe_write_req => foo_out_pipe_write_req(0 downto 0),
      foo_out_pipe_write_ack => foo_out_pipe_write_ack(0 downto 0),
      foo_out_pipe_write_data => foo_out_pipe_write_data(31 downto 0),
      tag_in => foo_tag_in,
      tag_out => foo_tag_out-- 
    ); -- 
  -- module will be run forever 
  foo_tag_in <= (others => '0');
  foo_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => foo_start, fin => foo_fin);
  -- module free_queue_manager
  free_queue_manager_instance:free_queue_manager-- 
    port map(-- 
      start => free_queue_manager_start,
      fin => free_queue_manager_fin,
      clk => clk,
      reset => reset,
      memory_space_1_lr_req => memory_space_1_lr_req(0 downto 0),
      memory_space_1_lr_ack => memory_space_1_lr_ack(0 downto 0),
      memory_space_1_lr_addr => memory_space_1_lr_addr(2 downto 0),
      memory_space_1_lr_tag => memory_space_1_lr_tag(1 downto 0),
      memory_space_1_lc_req => memory_space_1_lc_req(0 downto 0),
      memory_space_1_lc_ack => memory_space_1_lc_ack(0 downto 0),
      memory_space_1_lc_data => memory_space_1_lc_data(31 downto 0),
      memory_space_1_lc_tag => memory_space_1_lc_tag(1 downto 0),
      memory_space_2_lr_req => memory_space_2_lr_req(0 downto 0),
      memory_space_2_lr_ack => memory_space_2_lr_ack(0 downto 0),
      memory_space_2_lr_addr => memory_space_2_lr_addr(0 downto 0),
      memory_space_2_lr_tag => memory_space_2_lr_tag(1 downto 0),
      memory_space_2_lc_req => memory_space_2_lc_req(0 downto 0),
      memory_space_2_lc_ack => memory_space_2_lc_ack(0 downto 0),
      memory_space_2_lc_data => memory_space_2_lc_data(31 downto 0),
      memory_space_2_lc_tag => memory_space_2_lc_tag(1 downto 0),
      memory_space_1_sr_req => memory_space_1_sr_req(1 downto 0),
      memory_space_1_sr_ack => memory_space_1_sr_ack(1 downto 0),
      memory_space_1_sr_addr => memory_space_1_sr_addr(5 downto 0),
      memory_space_1_sr_data => memory_space_1_sr_data(63 downto 0),
      memory_space_1_sr_tag => memory_space_1_sr_tag(3 downto 0),
      memory_space_1_sc_req => memory_space_1_sc_req(1 downto 0),
      memory_space_1_sc_ack => memory_space_1_sc_ack(1 downto 0),
      memory_space_1_sc_tag => memory_space_1_sc_tag(3 downto 0),
      memory_space_2_sr_req => memory_space_2_sr_req(0 downto 0),
      memory_space_2_sr_ack => memory_space_2_sr_ack(0 downto 0),
      memory_space_2_sr_addr => memory_space_2_sr_addr(0 downto 0),
      memory_space_2_sr_data => memory_space_2_sr_data(31 downto 0),
      memory_space_2_sr_tag => memory_space_2_sr_tag(1 downto 0),
      memory_space_2_sc_req => memory_space_2_sc_req(0 downto 0),
      memory_space_2_sc_ack => memory_space_2_sc_ack(0 downto 0),
      memory_space_2_sc_tag => memory_space_2_sc_tag(1 downto 0),
      free_queue_put_pipe_read_req => free_queue_put_pipe_read_req(0 downto 0),
      free_queue_put_pipe_read_ack => free_queue_put_pipe_read_ack(0 downto 0),
      free_queue_put_pipe_read_data => free_queue_put_pipe_read_data(31 downto 0),
      free_queue_request_pipe_read_req => free_queue_request_pipe_read_req(0 downto 0),
      free_queue_request_pipe_read_ack => free_queue_request_pipe_read_ack(0 downto 0),
      free_queue_request_pipe_read_data => free_queue_request_pipe_read_data(7 downto 0),
      free_queue_get_pipe_write_req => free_queue_get_pipe_write_req(0 downto 0),
      free_queue_get_pipe_write_ack => free_queue_get_pipe_write_ack(0 downto 0),
      free_queue_get_pipe_write_data => free_queue_get_pipe_write_data(31 downto 0),
      tag_in => free_queue_manager_tag_in,
      tag_out => free_queue_manager_tag_out-- 
    ); -- 
  -- module will be run forever 
  free_queue_manager_tag_in <= (others => '0');
  free_queue_manager_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => free_queue_manager_start, fin => free_queue_manager_fin);
  -- module input_module
  input_module_instance:input_module-- 
    port map(-- 
      start => input_module_start,
      fin => input_module_fin,
      clk => clk,
      reset => reset,
      memory_space_1_sr_req => memory_space_1_sr_req(2 downto 2),
      memory_space_1_sr_ack => memory_space_1_sr_ack(2 downto 2),
      memory_space_1_sr_addr => memory_space_1_sr_addr(8 downto 6),
      memory_space_1_sr_data => memory_space_1_sr_data(95 downto 64),
      memory_space_1_sr_tag => memory_space_1_sr_tag(5 downto 4),
      memory_space_1_sc_req => memory_space_1_sc_req(2 downto 2),
      memory_space_1_sc_ack => memory_space_1_sc_ack(2 downto 2),
      memory_space_1_sc_tag => memory_space_1_sc_tag(5 downto 4),
      free_queue_get_pipe_read_req => free_queue_get_pipe_read_req(0 downto 0),
      free_queue_get_pipe_read_ack => free_queue_get_pipe_read_ack(0 downto 0),
      free_queue_get_pipe_read_data => free_queue_get_pipe_read_data(31 downto 0),
      input_data_pipe_read_req => input_data_pipe_read_req(0 downto 0),
      input_data_pipe_read_ack => input_data_pipe_read_ack(0 downto 0),
      input_data_pipe_read_data => input_data_pipe_read_data(31 downto 0),
      foo_in_pipe_write_req => foo_in_pipe_write_req(0 downto 0),
      foo_in_pipe_write_ack => foo_in_pipe_write_ack(0 downto 0),
      foo_in_pipe_write_data => foo_in_pipe_write_data(31 downto 0),
      free_queue_request_pipe_write_req => free_queue_request_pipe_write_req(0 downto 0),
      free_queue_request_pipe_write_ack => free_queue_request_pipe_write_ack(0 downto 0),
      free_queue_request_pipe_write_data => free_queue_request_pipe_write_data(7 downto 0),
      tag_in => input_module_tag_in,
      tag_out => input_module_tag_out-- 
    ); -- 
  -- module will be run forever 
  input_module_tag_in <= (others => '0');
  input_module_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => input_module_start, fin => input_module_fin);
  -- module mem_load_x_x
  mem_load_x_x_start <= '0';
  mem_load_x_x_instance:mem_load_x_x-- 
    port map(-- 
      address => mem_load_x_x_address,
      data => mem_load_x_x_data,
      start => mem_load_x_x_start,
      fin => mem_load_x_x_fin,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(0 downto 0),
      memory_space_0_lr_ack => memory_space_0_lr_ack(0 downto 0),
      memory_space_0_lr_addr => memory_space_0_lr_addr(0 downto 0),
      memory_space_0_lr_tag => memory_space_0_lr_tag(0 downto 0),
      memory_space_0_lc_req => memory_space_0_lc_req(0 downto 0),
      memory_space_0_lc_ack => memory_space_0_lc_ack(0 downto 0),
      memory_space_0_lc_data => memory_space_0_lc_data(7 downto 0),
      memory_space_0_lc_tag => memory_space_0_lc_tag(0 downto 0),
      tag_in => mem_load_x_x_tag_in,
      tag_out => mem_load_x_x_tag_out-- 
    ); -- 
  -- module mem_store_x_x
  mem_store_x_x_start <= '0';
  mem_store_x_x_instance:mem_store_x_x-- 
    port map(-- 
      address => mem_store_x_x_address,
      data => mem_store_x_x_data,
      start => mem_store_x_x_start,
      fin => mem_store_x_x_fin,
      clk => clk,
      reset => reset,
      memory_space_0_sr_req => memory_space_0_sr_req(0 downto 0),
      memory_space_0_sr_ack => memory_space_0_sr_ack(0 downto 0),
      memory_space_0_sr_addr => memory_space_0_sr_addr(0 downto 0),
      memory_space_0_sr_data => memory_space_0_sr_data(7 downto 0),
      memory_space_0_sr_tag => memory_space_0_sr_tag(0 downto 0),
      memory_space_0_sc_req => memory_space_0_sc_req(0 downto 0),
      memory_space_0_sc_ack => memory_space_0_sc_ack(0 downto 0),
      memory_space_0_sc_tag => memory_space_0_sc_tag(0 downto 0),
      tag_in => mem_store_x_x_tag_in,
      tag_out => mem_store_x_x_tag_out-- 
    ); -- 
  -- module output_module
  output_module_instance:output_module-- 
    port map(-- 
      start => output_module_start,
      fin => output_module_fin,
      clk => clk,
      reset => reset,
      memory_space_1_lr_req => memory_space_1_lr_req(1 downto 1),
      memory_space_1_lr_ack => memory_space_1_lr_ack(1 downto 1),
      memory_space_1_lr_addr => memory_space_1_lr_addr(5 downto 3),
      memory_space_1_lr_tag => memory_space_1_lr_tag(3 downto 2),
      memory_space_1_lc_req => memory_space_1_lc_req(1 downto 1),
      memory_space_1_lc_ack => memory_space_1_lc_ack(1 downto 1),
      memory_space_1_lc_data => memory_space_1_lc_data(63 downto 32),
      memory_space_1_lc_tag => memory_space_1_lc_tag(3 downto 2),
      foo_out_pipe_read_req => foo_out_pipe_read_req(0 downto 0),
      foo_out_pipe_read_ack => foo_out_pipe_read_ack(0 downto 0),
      foo_out_pipe_read_data => foo_out_pipe_read_data(31 downto 0),
      free_queue_put_pipe_write_req => free_queue_put_pipe_write_req(0 downto 0),
      free_queue_put_pipe_write_ack => free_queue_put_pipe_write_ack(0 downto 0),
      free_queue_put_pipe_write_data => free_queue_put_pipe_write_data(31 downto 0),
      free_queue_request_pipe_write_req => free_queue_request_pipe_write_req(1 downto 1),
      free_queue_request_pipe_write_ack => free_queue_request_pipe_write_ack(1 downto 1),
      free_queue_request_pipe_write_data => free_queue_request_pipe_write_data(15 downto 8),
      output_data_pipe_write_req => output_data_pipe_write_req(0 downto 0),
      output_data_pipe_write_ack => output_data_pipe_write_ack(0 downto 0),
      output_data_pipe_write_data => output_data_pipe_write_data(31 downto 0),
      tag_in => output_module_tag_in,
      tag_out => output_module_tag_out-- 
    ); -- 
  -- module will be run forever 
  output_module_tag_in <= (others => '0');
  output_module_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => output_module_start, fin => output_module_fin);
  foo_in_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => foo_in_pipe_read_req,
      read_ack => foo_in_pipe_read_ack,
      read_data => foo_in_pipe_read_data,
      write_req => foo_in_pipe_write_req,
      write_ack => foo_in_pipe_write_ack,
      write_data => foo_in_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  foo_out_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => foo_out_pipe_read_req,
      read_ack => foo_out_pipe_read_ack,
      read_data => foo_out_pipe_read_data,
      write_req => foo_out_pipe_write_req,
      write_ack => foo_out_pipe_write_ack,
      write_data => foo_out_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  free_queue_get_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => free_queue_get_pipe_read_req,
      read_ack => free_queue_get_pipe_read_ack,
      read_data => free_queue_get_pipe_read_data,
      write_req => free_queue_get_pipe_write_req,
      write_ack => free_queue_get_pipe_write_ack,
      write_data => free_queue_get_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  free_queue_put_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => free_queue_put_pipe_read_req,
      read_ack => free_queue_put_pipe_read_ack,
      read_data => free_queue_put_pipe_read_data,
      write_req => free_queue_put_pipe_write_req,
      write_ack => free_queue_put_pipe_write_ack,
      write_data => free_queue_put_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  free_queue_request_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 2,
      data_width => 8,
      depth => 1 --
    )
    port map( -- 
      read_req => free_queue_request_pipe_read_req,
      read_ack => free_queue_request_pipe_read_ack,
      read_data => free_queue_request_pipe_read_data,
      write_req => free_queue_request_pipe_write_req,
      write_ack => free_queue_request_pipe_write_ack,
      write_data => free_queue_request_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  input_data_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => input_data_pipe_read_req,
      read_ack => input_data_pipe_read_ack,
      read_data => input_data_pipe_read_data,
      write_req => input_data_pipe_write_req,
      write_ack => input_data_pipe_write_ack,
      write_data => input_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  output_data_Pipe: PipeBase -- 
    generic map( -- 
      num_reads => 1,
      num_writes => 1,
      data_width => 32,
      depth => 1 --
    )
    port map( -- 
      read_req => output_data_pipe_read_req,
      read_ack => output_data_pipe_read_ack,
      read_data => output_data_pipe_read_data,
      write_req => output_data_pipe_write_req,
      write_ack => output_data_pipe_write_ack,
      write_data => output_data_pipe_write_data,
      clk => clk,reset => reset -- 
    ); -- 
  RegisterBank_memory_space_0: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 8,
      tag_width => 1,
      num_registers => 1) -- 
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
  RegisterBank_memory_space_1: register_bank -- 
    generic map(-- 
      num_loads => 3,
      num_stores => 4,
      addr_width => 3,
      data_width => 32,
      tag_width => 2,
      num_registers => 6) -- 
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
      tag_width => 2,
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
      clk : in std_logic;
      reset : in std_logic;
      input_data_pipe_write_data: in std_logic_vector(31 downto 0);
      input_data_pipe_write_req : in std_logic_vector(0 downto 0);
      input_data_pipe_write_ack : out std_logic_vector(0 downto 0);
      output_data_pipe_read_data: out std_logic_vector(31 downto 0);
      output_data_pipe_read_req : in std_logic_vector(0 downto 0);
      output_data_pipe_read_ack : out std_logic_vector(0 downto 0)); -- 
    -- 
  end component;
  signal clk: std_logic := '0';
  signal reset: std_logic := '1';
  signal foo_tag_in: std_logic_vector(0 downto 0);
  signal foo_tag_out: std_logic_vector(0 downto 0);
  signal foo_start : std_logic := '0';
  signal foo_fin   : std_logic := '0';
  signal free_queue_manager_tag_in: std_logic_vector(0 downto 0);
  signal free_queue_manager_tag_out: std_logic_vector(0 downto 0);
  signal free_queue_manager_start : std_logic := '0';
  signal free_queue_manager_fin   : std_logic := '0';
  signal input_module_tag_in: std_logic_vector(0 downto 0);
  signal input_module_tag_out: std_logic_vector(0 downto 0);
  signal input_module_start : std_logic := '0';
  signal input_module_fin   : std_logic := '0';
  signal output_module_tag_in: std_logic_vector(0 downto 0);
  signal output_module_tag_out: std_logic_vector(0 downto 0);
  signal output_module_start : std_logic := '0';
  signal output_module_fin   : std_logic := '0';
  -- write to pipe input_data
  signal input_data_pipe_write_data: std_logic_vector(31 downto 0);
  signal input_data_pipe_write_req : std_logic_vector(0 downto 0) := (others => '0');
  signal input_data_pipe_write_ack : std_logic_vector(0 downto 0);
  -- read from pipe output_data
  signal output_data_pipe_read_data: std_logic_vector(31 downto 0);
  signal output_data_pipe_read_req : std_logic_vector(0 downto 0) := (others => '0');
  signal output_data_pipe_read_ack : std_logic_vector(0 downto 0);
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
      obj_ref := Pack_String_To_Vhpi_String("input_data req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      input_data_pipe_write_req <= Unpack_String(val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("input_data 0");
      Vhpi_Get_Port_Value(obj_ref,val_string,32);
      input_data_pipe_write_data <= Unpack_String(val_string,32);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("input_data ack");
      val_string := Pack_SLV_To_Vhpi_String(input_data_pipe_write_ack);
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
      obj_ref := Pack_String_To_Vhpi_String("output_data req");
      Vhpi_Get_Port_Value(obj_ref,val_string,1);
      output_data_pipe_read_req <= Unpack_String(val_string,1);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("output_data ack");
      val_string := Pack_SLV_To_Vhpi_String(output_data_pipe_read_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("output_data 0");
      val_string := Pack_SLV_To_Vhpi_String(output_data_pipe_read_data);
      Vhpi_Set_Port_Value(obj_ref,val_string,32);
      -- 
    end loop;
    --
  end process;
  test_system_instance: test_system -- 
    port map ( -- 
      clk => clk,
      reset => reset,
      input_data_pipe_write_data  => input_data_pipe_write_data, 
      input_data_pipe_write_req  => input_data_pipe_write_req, 
      input_data_pipe_write_ack  => input_data_pipe_write_ack,
      output_data_pipe_read_data  => output_data_pipe_read_data, 
      output_data_pipe_read_req  => output_data_pipe_read_req, 
      output_data_pipe_read_ack  => output_data_pipe_read_ack ); -- 
  -- 
end VhpiLink;
