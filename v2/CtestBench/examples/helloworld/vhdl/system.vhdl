-- VHDL produced by vc2vhdl from virtual circuit (vc) description 
library ieee;
use ieee.std_logic_1164.all;
package vc_system_package is -- 
  constant mempool_base_address : std_logic_vector(4 downto 0) := "00000";
  constant xx_xstr1_base_address : std_logic_vector(2 downto 0) := "000";
  constant xx_xstr2_base_address : std_logic_vector(2 downto 0) := "000";
  constant xx_xstr_base_address : std_logic_vector(2 downto 0) := "000";
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
  port ( -- 
    a : in  std_logic_vector(31 downto 0);
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_0_lr_req : out  std_logic_vector(11 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(11 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(59 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(11 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(11 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(11 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(95 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(11 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(7 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(7 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(39 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(63 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(7 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(7 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(7 downto 0);
    midpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
    midpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
    midpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
    outpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    outpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    outpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity bar;
architecture Default of bar is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal ptr_deref_52_gather_scatter_req_0 : boolean;
  signal ptr_deref_52_gather_scatter_ack_0 : boolean;
  signal ptr_deref_52_store_0_req_0 : boolean;
  signal ptr_deref_52_store_0_ack_0 : boolean;
  signal ptr_deref_52_store_1_req_0 : boolean;
  signal ptr_deref_52_store_1_ack_0 : boolean;
  signal ptr_deref_52_store_2_req_0 : boolean;
  signal ptr_deref_52_store_2_ack_0 : boolean;
  signal ptr_deref_52_store_3_req_0 : boolean;
  signal ptr_deref_52_store_3_ack_0 : boolean;
  signal ptr_deref_52_store_0_req_1 : boolean;
  signal ptr_deref_52_store_0_ack_1 : boolean;
  signal ptr_deref_52_store_1_req_1 : boolean;
  signal ptr_deref_52_store_1_ack_1 : boolean;
  signal ptr_deref_52_store_2_req_1 : boolean;
  signal ptr_deref_52_store_2_ack_1 : boolean;
  signal ptr_deref_52_store_3_req_1 : boolean;
  signal ptr_deref_52_store_3_ack_1 : boolean;
  signal simple_obj_ref_61_inst_req_0 : boolean;
  signal simple_obj_ref_61_inst_ack_0 : boolean;
  signal type_cast_62_inst_req_0 : boolean;
  signal type_cast_62_inst_ack_0 : boolean;
  signal ptr_deref_65_gather_scatter_req_0 : boolean;
  signal ptr_deref_65_gather_scatter_ack_0 : boolean;
  signal ptr_deref_65_store_0_req_0 : boolean;
  signal ptr_deref_65_store_0_ack_0 : boolean;
  signal ptr_deref_65_store_1_req_0 : boolean;
  signal ptr_deref_65_store_1_ack_0 : boolean;
  signal ptr_deref_65_store_2_req_0 : boolean;
  signal ptr_deref_65_store_2_ack_0 : boolean;
  signal ptr_deref_65_store_3_req_0 : boolean;
  signal ptr_deref_65_store_3_ack_0 : boolean;
  signal ptr_deref_65_store_0_req_1 : boolean;
  signal ptr_deref_65_store_0_ack_1 : boolean;
  signal ptr_deref_65_store_1_req_1 : boolean;
  signal ptr_deref_65_store_1_ack_1 : boolean;
  signal ptr_deref_65_store_2_req_1 : boolean;
  signal ptr_deref_65_store_2_ack_1 : boolean;
  signal ptr_deref_65_store_3_req_1 : boolean;
  signal ptr_deref_65_store_3_ack_1 : boolean;
  signal ptr_deref_70_load_0_req_0 : boolean;
  signal ptr_deref_70_load_0_ack_0 : boolean;
  signal ptr_deref_70_load_1_req_0 : boolean;
  signal ptr_deref_70_load_1_ack_0 : boolean;
  signal ptr_deref_70_load_2_req_0 : boolean;
  signal ptr_deref_70_load_2_ack_0 : boolean;
  signal ptr_deref_70_load_3_req_0 : boolean;
  signal ptr_deref_70_load_3_ack_0 : boolean;
  signal ptr_deref_70_load_0_req_1 : boolean;
  signal ptr_deref_70_load_0_ack_1 : boolean;
  signal ptr_deref_70_load_1_req_1 : boolean;
  signal ptr_deref_70_load_1_ack_1 : boolean;
  signal ptr_deref_70_load_2_req_1 : boolean;
  signal ptr_deref_70_load_2_ack_1 : boolean;
  signal ptr_deref_70_load_3_req_1 : boolean;
  signal ptr_deref_70_load_3_ack_1 : boolean;
  signal ptr_deref_70_gather_scatter_req_0 : boolean;
  signal ptr_deref_70_gather_scatter_ack_0 : boolean;
  signal ptr_deref_74_load_0_req_0 : boolean;
  signal ptr_deref_74_load_0_ack_0 : boolean;
  signal ptr_deref_74_load_1_req_0 : boolean;
  signal ptr_deref_74_load_1_ack_0 : boolean;
  signal ptr_deref_74_load_2_req_0 : boolean;
  signal ptr_deref_74_load_2_ack_0 : boolean;
  signal ptr_deref_74_load_3_req_0 : boolean;
  signal ptr_deref_74_load_3_ack_0 : boolean;
  signal ptr_deref_74_load_0_req_1 : boolean;
  signal ptr_deref_74_load_0_ack_1 : boolean;
  signal ptr_deref_74_load_1_req_1 : boolean;
  signal ptr_deref_74_load_1_ack_1 : boolean;
  signal ptr_deref_74_load_2_req_1 : boolean;
  signal ptr_deref_74_load_2_ack_1 : boolean;
  signal ptr_deref_74_load_3_req_1 : boolean;
  signal ptr_deref_74_load_3_ack_1 : boolean;
  signal ptr_deref_74_gather_scatter_req_0 : boolean;
  signal ptr_deref_74_gather_scatter_ack_0 : boolean;
  signal binary_79_inst_req_0 : boolean;
  signal binary_79_inst_ack_0 : boolean;
  signal binary_79_inst_req_1 : boolean;
  signal binary_79_inst_ack_1 : boolean;
  signal type_cast_88_inst_req_0 : boolean;
  signal type_cast_88_inst_ack_0 : boolean;
  signal simple_obj_ref_86_inst_req_0 : boolean;
  signal simple_obj_ref_86_inst_ack_0 : boolean;
  signal ptr_deref_92_load_0_req_0 : boolean;
  signal ptr_deref_92_load_0_ack_0 : boolean;
  signal ptr_deref_92_load_1_req_0 : boolean;
  signal ptr_deref_92_load_1_ack_0 : boolean;
  signal ptr_deref_92_load_2_req_0 : boolean;
  signal ptr_deref_92_load_2_ack_0 : boolean;
  signal ptr_deref_92_load_3_req_0 : boolean;
  signal ptr_deref_92_load_3_ack_0 : boolean;
  signal ptr_deref_92_load_0_req_1 : boolean;
  signal ptr_deref_92_load_0_ack_1 : boolean;
  signal ptr_deref_92_load_1_req_1 : boolean;
  signal ptr_deref_92_load_1_ack_1 : boolean;
  signal ptr_deref_92_load_2_req_1 : boolean;
  signal ptr_deref_92_load_2_ack_1 : boolean;
  signal ptr_deref_92_load_3_req_1 : boolean;
  signal ptr_deref_92_load_3_ack_1 : boolean;
  signal ptr_deref_92_gather_scatter_req_0 : boolean;
  signal ptr_deref_92_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_94_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_94_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_94_store_0_req_0 : boolean;
  signal simple_obj_ref_94_store_0_ack_0 : boolean;
  signal simple_obj_ref_94_store_0_req_1 : boolean;
  signal simple_obj_ref_94_store_0_ack_1 : boolean;
  signal simple_obj_ref_100_load_0_req_0 : boolean;
  signal simple_obj_ref_100_load_0_ack_0 : boolean;
  signal simple_obj_ref_100_load_0_req_1 : boolean;
  signal simple_obj_ref_100_load_0_ack_1 : boolean;
  signal simple_obj_ref_100_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_100_gather_scatter_ack_0 : boolean;
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
  bar_CP_0: Block -- control-path 
    signal bar_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_40_3_symbol : Boolean;
    -- 
  begin -- 
    bar_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= bar_CP_0_start; -- transition $entry
    branch_block_stmt_40_3: Block -- branch_block_stmt_40 
      signal branch_block_stmt_40_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_40_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_40_x_xexit_x_xx_x7_symbol : Boolean;
      signal assign_stmt_46_to_assign_stmt_96_x_xentry_x_xx_x8_symbol : Boolean;
      signal assign_stmt_46_to_assign_stmt_96_x_xexit_x_xx_x9_symbol : Boolean;
      signal return_x_xx_x10_symbol : Boolean;
      signal merge_stmt_98_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_101_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_101_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_46_to_assign_stmt_96_14_symbol : Boolean;
      signal assign_stmt_101_399_symbol : Boolean;
      signal return_x_xx_xPhiReq_432_symbol : Boolean;
      signal merge_stmt_98_PhiReqMerge_435_symbol : Boolean;
      signal merge_stmt_98_PhiAck_436_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_40_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_40_3_start; -- transition branch_block_stmt_40/$entry
      branch_block_stmt_40_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_40/branch_block_stmt_40__entry__ (optimized away) 
      branch_block_stmt_40_x_xexit_x_xx_x7_symbol  <=  assign_stmt_101_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_40/branch_block_stmt_40__exit__ (optimized away) 
      assign_stmt_46_to_assign_stmt_96_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_40_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96__entry__ (optimized away) 
      assign_stmt_46_to_assign_stmt_96_x_xexit_x_xx_x9_symbol  <=  assign_stmt_46_to_assign_stmt_96_14_symbol; -- place branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96__exit__ (optimized away) 
      return_x_xx_x10_symbol  <=  assign_stmt_46_to_assign_stmt_96_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_40/return__ (optimized away) 
      merge_stmt_98_x_xexit_x_xx_x11_symbol  <=  merge_stmt_98_PhiAck_436_symbol; -- place branch_block_stmt_40/merge_stmt_98__exit__ (optimized away) 
      assign_stmt_101_x_xentry_x_xx_x12_symbol  <=  merge_stmt_98_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_40/assign_stmt_101__entry__ (optimized away) 
      assign_stmt_101_x_xexit_x_xx_x13_symbol  <=  assign_stmt_101_399_symbol; -- place branch_block_stmt_40/assign_stmt_101__exit__ (optimized away) 
      assign_stmt_46_to_assign_stmt_96_14: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96 
        signal assign_stmt_46_to_assign_stmt_96_14_start: Boolean;
        signal Xentry_15_symbol: Boolean;
        signal Xexit_16_symbol: Boolean;
        signal assign_stmt_54_active_x_x17_symbol : Boolean;
        signal assign_stmt_54_completed_x_x18_symbol : Boolean;
        signal simple_obj_ref_53_complete_19_symbol : Boolean;
        signal ptr_deref_52_trigger_x_x20_symbol : Boolean;
        signal ptr_deref_52_active_x_x21_symbol : Boolean;
        signal ptr_deref_52_base_address_calculated_22_symbol : Boolean;
        signal ptr_deref_52_root_address_calculated_23_symbol : Boolean;
        signal ptr_deref_52_word_address_calculated_24_symbol : Boolean;
        signal ptr_deref_52_request_25_symbol : Boolean;
        signal ptr_deref_52_complete_53_symbol : Boolean;
        signal assign_stmt_63_active_x_x79_symbol : Boolean;
        signal assign_stmt_63_completed_x_x80_symbol : Boolean;
        signal type_cast_62_active_x_x81_symbol : Boolean;
        signal type_cast_62_trigger_x_x82_symbol : Boolean;
        signal simple_obj_ref_61_trigger_x_x83_symbol : Boolean;
        signal simple_obj_ref_61_complete_84_symbol : Boolean;
        signal type_cast_62_complete_89_symbol : Boolean;
        signal assign_stmt_67_active_x_x94_symbol : Boolean;
        signal assign_stmt_67_completed_x_x95_symbol : Boolean;
        signal simple_obj_ref_66_complete_96_symbol : Boolean;
        signal ptr_deref_65_trigger_x_x97_symbol : Boolean;
        signal ptr_deref_65_active_x_x98_symbol : Boolean;
        signal ptr_deref_65_base_address_calculated_99_symbol : Boolean;
        signal ptr_deref_65_root_address_calculated_100_symbol : Boolean;
        signal ptr_deref_65_word_address_calculated_101_symbol : Boolean;
        signal ptr_deref_65_request_102_symbol : Boolean;
        signal ptr_deref_65_complete_130_symbol : Boolean;
        signal assign_stmt_71_active_x_x156_symbol : Boolean;
        signal assign_stmt_71_completed_x_x157_symbol : Boolean;
        signal ptr_deref_70_trigger_x_x158_symbol : Boolean;
        signal ptr_deref_70_active_x_x159_symbol : Boolean;
        signal ptr_deref_70_base_address_calculated_160_symbol : Boolean;
        signal ptr_deref_70_root_address_calculated_161_symbol : Boolean;
        signal ptr_deref_70_word_address_calculated_162_symbol : Boolean;
        signal ptr_deref_70_request_163_symbol : Boolean;
        signal ptr_deref_70_complete_189_symbol : Boolean;
        signal assign_stmt_75_active_x_x217_symbol : Boolean;
        signal assign_stmt_75_completed_x_x218_symbol : Boolean;
        signal ptr_deref_74_trigger_x_x219_symbol : Boolean;
        signal ptr_deref_74_active_x_x220_symbol : Boolean;
        signal ptr_deref_74_base_address_calculated_221_symbol : Boolean;
        signal ptr_deref_74_root_address_calculated_222_symbol : Boolean;
        signal ptr_deref_74_word_address_calculated_223_symbol : Boolean;
        signal ptr_deref_74_request_224_symbol : Boolean;
        signal ptr_deref_74_complete_250_symbol : Boolean;
        signal assign_stmt_80_active_x_x278_symbol : Boolean;
        signal assign_stmt_80_completed_x_x279_symbol : Boolean;
        signal binary_79_active_x_x280_symbol : Boolean;
        signal binary_79_trigger_x_x281_symbol : Boolean;
        signal simple_obj_ref_77_complete_282_symbol : Boolean;
        signal simple_obj_ref_78_complete_283_symbol : Boolean;
        signal binary_79_complete_284_symbol : Boolean;
        signal assign_stmt_89_active_x_x291_symbol : Boolean;
        signal assign_stmt_89_completed_x_x292_symbol : Boolean;
        signal type_cast_88_active_x_x293_symbol : Boolean;
        signal type_cast_88_trigger_x_x294_symbol : Boolean;
        signal simple_obj_ref_87_complete_295_symbol : Boolean;
        signal type_cast_88_complete_296_symbol : Boolean;
        signal simple_obj_ref_86_trigger_x_x301_symbol : Boolean;
        signal simple_obj_ref_86_complete_302_symbol : Boolean;
        signal assign_stmt_93_active_x_x307_symbol : Boolean;
        signal assign_stmt_93_completed_x_x308_symbol : Boolean;
        signal ptr_deref_92_trigger_x_x309_symbol : Boolean;
        signal ptr_deref_92_active_x_x310_symbol : Boolean;
        signal ptr_deref_92_base_address_calculated_311_symbol : Boolean;
        signal ptr_deref_92_root_address_calculated_312_symbol : Boolean;
        signal ptr_deref_92_word_address_calculated_313_symbol : Boolean;
        signal ptr_deref_92_request_314_symbol : Boolean;
        signal ptr_deref_92_complete_340_symbol : Boolean;
        signal assign_stmt_96_active_x_x368_symbol : Boolean;
        signal assign_stmt_96_completed_x_x369_symbol : Boolean;
        signal simple_obj_ref_95_complete_370_symbol : Boolean;
        signal simple_obj_ref_94_trigger_x_x371_symbol : Boolean;
        signal simple_obj_ref_94_active_x_x372_symbol : Boolean;
        signal simple_obj_ref_94_root_address_calculated_373_symbol : Boolean;
        signal simple_obj_ref_94_word_address_calculated_374_symbol : Boolean;
        signal simple_obj_ref_94_request_375_symbol : Boolean;
        signal simple_obj_ref_94_complete_388_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_46_to_assign_stmt_96_14_start <= assign_stmt_46_to_assign_stmt_96_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_15_symbol  <= assign_stmt_46_to_assign_stmt_96_14_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/$entry
        assign_stmt_54_active_x_x17_symbol <= simple_obj_ref_53_complete_19_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_54_active_
        assign_stmt_54_completed_x_x18_symbol <= ptr_deref_52_complete_53_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_54_completed_
        simple_obj_ref_53_complete_19_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_53_complete
        ptr_deref_52_trigger_x_x20_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_trigger_ 
          signal ptr_deref_52_trigger_x_x20_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_52_trigger_x_x20_predecessors(0) <= ptr_deref_52_word_address_calculated_24_symbol;
          ptr_deref_52_trigger_x_x20_predecessors(1) <= assign_stmt_54_active_x_x17_symbol;
          ptr_deref_52_trigger_x_x20_join: join -- 
            port map( -- 
              preds => ptr_deref_52_trigger_x_x20_predecessors,
              symbol_out => ptr_deref_52_trigger_x_x20_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_trigger_
        ptr_deref_52_active_x_x21_symbol <= ptr_deref_52_request_25_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_active_
        ptr_deref_52_base_address_calculated_22_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_base_address_calculated
        ptr_deref_52_root_address_calculated_23_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_root_address_calculated
        ptr_deref_52_word_address_calculated_24_symbol <= ptr_deref_52_root_address_calculated_23_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_word_address_calculated
        ptr_deref_52_request_25: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request 
          signal ptr_deref_52_request_25_start: Boolean;
          signal Xentry_26_symbol: Boolean;
          signal Xexit_27_symbol: Boolean;
          signal split_req_28_symbol : Boolean;
          signal split_ack_29_symbol : Boolean;
          signal word_access_30_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_52_request_25_start <= ptr_deref_52_trigger_x_x20_symbol; -- control passed to block
          Xentry_26_symbol  <= ptr_deref_52_request_25_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/$entry
          split_req_28_symbol <= Xentry_26_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/split_req
          ptr_deref_52_gather_scatter_req_0 <= split_req_28_symbol; -- link to DP
          split_ack_29_symbol <= ptr_deref_52_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/split_ack
          word_access_30: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access 
            signal word_access_30_start: Boolean;
            signal Xentry_31_symbol: Boolean;
            signal Xexit_32_symbol: Boolean;
            signal word_access_0_33_symbol : Boolean;
            signal word_access_1_38_symbol : Boolean;
            signal word_access_2_43_symbol : Boolean;
            signal word_access_3_48_symbol : Boolean;
            -- 
          begin -- 
            word_access_30_start <= split_ack_29_symbol; -- control passed to block
            Xentry_31_symbol  <= word_access_30_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/$entry
            word_access_0_33: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_0 
              signal word_access_0_33_start: Boolean;
              signal Xentry_34_symbol: Boolean;
              signal Xexit_35_symbol: Boolean;
              signal rr_36_symbol : Boolean;
              signal ra_37_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_33_start <= Xentry_31_symbol; -- control passed to block
              Xentry_34_symbol  <= word_access_0_33_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_0/$entry
              rr_36_symbol <= Xentry_34_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_0/rr
              ptr_deref_52_store_0_req_0 <= rr_36_symbol; -- link to DP
              ra_37_symbol <= ptr_deref_52_store_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_0/ra
              Xexit_35_symbol <= ra_37_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_0/$exit
              word_access_0_33_symbol <= Xexit_35_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_0
            word_access_1_38: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_1 
              signal word_access_1_38_start: Boolean;
              signal Xentry_39_symbol: Boolean;
              signal Xexit_40_symbol: Boolean;
              signal rr_41_symbol : Boolean;
              signal ra_42_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_38_start <= Xentry_31_symbol; -- control passed to block
              Xentry_39_symbol  <= word_access_1_38_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_1/$entry
              rr_41_symbol <= Xentry_39_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_1/rr
              ptr_deref_52_store_1_req_0 <= rr_41_symbol; -- link to DP
              ra_42_symbol <= ptr_deref_52_store_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_1/ra
              Xexit_40_symbol <= ra_42_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_1/$exit
              word_access_1_38_symbol <= Xexit_40_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_1
            word_access_2_43: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_2 
              signal word_access_2_43_start: Boolean;
              signal Xentry_44_symbol: Boolean;
              signal Xexit_45_symbol: Boolean;
              signal rr_46_symbol : Boolean;
              signal ra_47_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_43_start <= Xentry_31_symbol; -- control passed to block
              Xentry_44_symbol  <= word_access_2_43_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_2/$entry
              rr_46_symbol <= Xentry_44_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_2/rr
              ptr_deref_52_store_2_req_0 <= rr_46_symbol; -- link to DP
              ra_47_symbol <= ptr_deref_52_store_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_2/ra
              Xexit_45_symbol <= ra_47_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_2/$exit
              word_access_2_43_symbol <= Xexit_45_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_2
            word_access_3_48: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_3 
              signal word_access_3_48_start: Boolean;
              signal Xentry_49_symbol: Boolean;
              signal Xexit_50_symbol: Boolean;
              signal rr_51_symbol : Boolean;
              signal ra_52_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_48_start <= Xentry_31_symbol; -- control passed to block
              Xentry_49_symbol  <= word_access_3_48_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_3/$entry
              rr_51_symbol <= Xentry_49_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_3/rr
              ptr_deref_52_store_3_req_0 <= rr_51_symbol; -- link to DP
              ra_52_symbol <= ptr_deref_52_store_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_3/ra
              Xexit_50_symbol <= ra_52_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_3/$exit
              word_access_3_48_symbol <= Xexit_50_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/word_access_3
            Xexit_32_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/$exit 
              signal Xexit_32_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_32_predecessors(0) <= word_access_0_33_symbol;
              Xexit_32_predecessors(1) <= word_access_1_38_symbol;
              Xexit_32_predecessors(2) <= word_access_2_43_symbol;
              Xexit_32_predecessors(3) <= word_access_3_48_symbol;
              Xexit_32_join: join -- 
                port map( -- 
                  preds => Xexit_32_predecessors,
                  symbol_out => Xexit_32_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access/$exit
            word_access_30_symbol <= Xexit_32_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/word_access
          Xexit_27_symbol <= word_access_30_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request/$exit
          ptr_deref_52_request_25_symbol <= Xexit_27_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_request
        ptr_deref_52_complete_53: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete 
          signal ptr_deref_52_complete_53_start: Boolean;
          signal Xentry_54_symbol: Boolean;
          signal Xexit_55_symbol: Boolean;
          signal word_access_56_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_52_complete_53_start <= ptr_deref_52_active_x_x21_symbol; -- control passed to block
          Xentry_54_symbol  <= ptr_deref_52_complete_53_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/$entry
          word_access_56: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access 
            signal word_access_56_start: Boolean;
            signal Xentry_57_symbol: Boolean;
            signal Xexit_58_symbol: Boolean;
            signal word_access_0_59_symbol : Boolean;
            signal word_access_1_64_symbol : Boolean;
            signal word_access_2_69_symbol : Boolean;
            signal word_access_3_74_symbol : Boolean;
            -- 
          begin -- 
            word_access_56_start <= Xentry_54_symbol; -- control passed to block
            Xentry_57_symbol  <= word_access_56_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/$entry
            word_access_0_59: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_0 
              signal word_access_0_59_start: Boolean;
              signal Xentry_60_symbol: Boolean;
              signal Xexit_61_symbol: Boolean;
              signal cr_62_symbol : Boolean;
              signal ca_63_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_59_start <= Xentry_57_symbol; -- control passed to block
              Xentry_60_symbol  <= word_access_0_59_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_0/$entry
              cr_62_symbol <= Xentry_60_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_0/cr
              ptr_deref_52_store_0_req_1 <= cr_62_symbol; -- link to DP
              ca_63_symbol <= ptr_deref_52_store_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_0/ca
              Xexit_61_symbol <= ca_63_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_0/$exit
              word_access_0_59_symbol <= Xexit_61_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_0
            word_access_1_64: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_1 
              signal word_access_1_64_start: Boolean;
              signal Xentry_65_symbol: Boolean;
              signal Xexit_66_symbol: Boolean;
              signal cr_67_symbol : Boolean;
              signal ca_68_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_64_start <= Xentry_57_symbol; -- control passed to block
              Xentry_65_symbol  <= word_access_1_64_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_1/$entry
              cr_67_symbol <= Xentry_65_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_1/cr
              ptr_deref_52_store_1_req_1 <= cr_67_symbol; -- link to DP
              ca_68_symbol <= ptr_deref_52_store_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_1/ca
              Xexit_66_symbol <= ca_68_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_1/$exit
              word_access_1_64_symbol <= Xexit_66_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_1
            word_access_2_69: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_2 
              signal word_access_2_69_start: Boolean;
              signal Xentry_70_symbol: Boolean;
              signal Xexit_71_symbol: Boolean;
              signal cr_72_symbol : Boolean;
              signal ca_73_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_69_start <= Xentry_57_symbol; -- control passed to block
              Xentry_70_symbol  <= word_access_2_69_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_2/$entry
              cr_72_symbol <= Xentry_70_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_2/cr
              ptr_deref_52_store_2_req_1 <= cr_72_symbol; -- link to DP
              ca_73_symbol <= ptr_deref_52_store_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_2/ca
              Xexit_71_symbol <= ca_73_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_2/$exit
              word_access_2_69_symbol <= Xexit_71_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_2
            word_access_3_74: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_3 
              signal word_access_3_74_start: Boolean;
              signal Xentry_75_symbol: Boolean;
              signal Xexit_76_symbol: Boolean;
              signal cr_77_symbol : Boolean;
              signal ca_78_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_74_start <= Xentry_57_symbol; -- control passed to block
              Xentry_75_symbol  <= word_access_3_74_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_3/$entry
              cr_77_symbol <= Xentry_75_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_3/cr
              ptr_deref_52_store_3_req_1 <= cr_77_symbol; -- link to DP
              ca_78_symbol <= ptr_deref_52_store_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_3/ca
              Xexit_76_symbol <= ca_78_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_3/$exit
              word_access_3_74_symbol <= Xexit_76_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/word_access_3
            Xexit_58_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/$exit 
              signal Xexit_58_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_58_predecessors(0) <= word_access_0_59_symbol;
              Xexit_58_predecessors(1) <= word_access_1_64_symbol;
              Xexit_58_predecessors(2) <= word_access_2_69_symbol;
              Xexit_58_predecessors(3) <= word_access_3_74_symbol;
              Xexit_58_join: join -- 
                port map( -- 
                  preds => Xexit_58_predecessors,
                  symbol_out => Xexit_58_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access/$exit
            word_access_56_symbol <= Xexit_58_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/word_access
          Xexit_55_symbol <= word_access_56_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete/$exit
          ptr_deref_52_complete_53_symbol <= Xexit_55_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_52_complete
        assign_stmt_63_active_x_x79_symbol <= type_cast_62_complete_89_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_63_active_
        assign_stmt_63_completed_x_x80_symbol <= assign_stmt_63_active_x_x79_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_63_completed_
        type_cast_62_active_x_x81_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_active_ 
          signal type_cast_62_active_x_x81_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_62_active_x_x81_predecessors(0) <= type_cast_62_trigger_x_x82_symbol;
          type_cast_62_active_x_x81_predecessors(1) <= simple_obj_ref_61_complete_84_symbol;
          type_cast_62_active_x_x81_join: join -- 
            port map( -- 
              preds => type_cast_62_active_x_x81_predecessors,
              symbol_out => type_cast_62_active_x_x81_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_active_
        type_cast_62_trigger_x_x82_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_trigger_
        simple_obj_ref_61_trigger_x_x83_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_trigger_
        simple_obj_ref_61_complete_84: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_complete 
          signal simple_obj_ref_61_complete_84_start: Boolean;
          signal Xentry_85_symbol: Boolean;
          signal Xexit_86_symbol: Boolean;
          signal req_87_symbol : Boolean;
          signal ack_88_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_61_complete_84_start <= simple_obj_ref_61_trigger_x_x83_symbol; -- control passed to block
          Xentry_85_symbol  <= simple_obj_ref_61_complete_84_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_complete/$entry
          req_87_symbol <= Xentry_85_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_complete/req
          simple_obj_ref_61_inst_req_0 <= req_87_symbol; -- link to DP
          ack_88_symbol <= simple_obj_ref_61_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_complete/ack
          Xexit_86_symbol <= ack_88_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_complete/$exit
          simple_obj_ref_61_complete_84_symbol <= Xexit_86_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_61_complete
        type_cast_62_complete_89: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_complete 
          signal type_cast_62_complete_89_start: Boolean;
          signal Xentry_90_symbol: Boolean;
          signal Xexit_91_symbol: Boolean;
          signal req_92_symbol : Boolean;
          signal ack_93_symbol : Boolean;
          -- 
        begin -- 
          type_cast_62_complete_89_start <= type_cast_62_active_x_x81_symbol; -- control passed to block
          Xentry_90_symbol  <= type_cast_62_complete_89_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_complete/$entry
          req_92_symbol <= Xentry_90_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_complete/req
          type_cast_62_inst_req_0 <= req_92_symbol; -- link to DP
          ack_93_symbol <= type_cast_62_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_complete/ack
          Xexit_91_symbol <= ack_93_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_complete/$exit
          type_cast_62_complete_89_symbol <= Xexit_91_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_62_complete
        assign_stmt_67_active_x_x94_symbol <= simple_obj_ref_66_complete_96_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_67_active_
        assign_stmt_67_completed_x_x95_symbol <= ptr_deref_65_complete_130_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_67_completed_
        simple_obj_ref_66_complete_96_symbol <= assign_stmt_63_completed_x_x80_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_66_complete
        ptr_deref_65_trigger_x_x97_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_trigger_ 
          signal ptr_deref_65_trigger_x_x97_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_65_trigger_x_x97_predecessors(0) <= ptr_deref_65_word_address_calculated_101_symbol;
          ptr_deref_65_trigger_x_x97_predecessors(1) <= assign_stmt_67_active_x_x94_symbol;
          ptr_deref_65_trigger_x_x97_predecessors(2) <= ptr_deref_52_active_x_x21_symbol;
          ptr_deref_65_trigger_x_x97_join: join -- 
            port map( -- 
              preds => ptr_deref_65_trigger_x_x97_predecessors,
              symbol_out => ptr_deref_65_trigger_x_x97_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_trigger_
        ptr_deref_65_active_x_x98_symbol <= ptr_deref_65_request_102_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_active_
        ptr_deref_65_base_address_calculated_99_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_base_address_calculated
        ptr_deref_65_root_address_calculated_100_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_root_address_calculated
        ptr_deref_65_word_address_calculated_101_symbol <= ptr_deref_65_root_address_calculated_100_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_word_address_calculated
        ptr_deref_65_request_102: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request 
          signal ptr_deref_65_request_102_start: Boolean;
          signal Xentry_103_symbol: Boolean;
          signal Xexit_104_symbol: Boolean;
          signal split_req_105_symbol : Boolean;
          signal split_ack_106_symbol : Boolean;
          signal word_access_107_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_65_request_102_start <= ptr_deref_65_trigger_x_x97_symbol; -- control passed to block
          Xentry_103_symbol  <= ptr_deref_65_request_102_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/$entry
          split_req_105_symbol <= Xentry_103_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/split_req
          ptr_deref_65_gather_scatter_req_0 <= split_req_105_symbol; -- link to DP
          split_ack_106_symbol <= ptr_deref_65_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/split_ack
          word_access_107: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access 
            signal word_access_107_start: Boolean;
            signal Xentry_108_symbol: Boolean;
            signal Xexit_109_symbol: Boolean;
            signal word_access_0_110_symbol : Boolean;
            signal word_access_1_115_symbol : Boolean;
            signal word_access_2_120_symbol : Boolean;
            signal word_access_3_125_symbol : Boolean;
            -- 
          begin -- 
            word_access_107_start <= split_ack_106_symbol; -- control passed to block
            Xentry_108_symbol  <= word_access_107_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/$entry
            word_access_0_110: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_0 
              signal word_access_0_110_start: Boolean;
              signal Xentry_111_symbol: Boolean;
              signal Xexit_112_symbol: Boolean;
              signal rr_113_symbol : Boolean;
              signal ra_114_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_110_start <= Xentry_108_symbol; -- control passed to block
              Xentry_111_symbol  <= word_access_0_110_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_0/$entry
              rr_113_symbol <= Xentry_111_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_0/rr
              ptr_deref_65_store_0_req_0 <= rr_113_symbol; -- link to DP
              ra_114_symbol <= ptr_deref_65_store_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_0/ra
              Xexit_112_symbol <= ra_114_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_0/$exit
              word_access_0_110_symbol <= Xexit_112_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_0
            word_access_1_115: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_1 
              signal word_access_1_115_start: Boolean;
              signal Xentry_116_symbol: Boolean;
              signal Xexit_117_symbol: Boolean;
              signal rr_118_symbol : Boolean;
              signal ra_119_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_115_start <= Xentry_108_symbol; -- control passed to block
              Xentry_116_symbol  <= word_access_1_115_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_1/$entry
              rr_118_symbol <= Xentry_116_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_1/rr
              ptr_deref_65_store_1_req_0 <= rr_118_symbol; -- link to DP
              ra_119_symbol <= ptr_deref_65_store_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_1/ra
              Xexit_117_symbol <= ra_119_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_1/$exit
              word_access_1_115_symbol <= Xexit_117_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_1
            word_access_2_120: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_2 
              signal word_access_2_120_start: Boolean;
              signal Xentry_121_symbol: Boolean;
              signal Xexit_122_symbol: Boolean;
              signal rr_123_symbol : Boolean;
              signal ra_124_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_120_start <= Xentry_108_symbol; -- control passed to block
              Xentry_121_symbol  <= word_access_2_120_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_2/$entry
              rr_123_symbol <= Xentry_121_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_2/rr
              ptr_deref_65_store_2_req_0 <= rr_123_symbol; -- link to DP
              ra_124_symbol <= ptr_deref_65_store_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_2/ra
              Xexit_122_symbol <= ra_124_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_2/$exit
              word_access_2_120_symbol <= Xexit_122_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_2
            word_access_3_125: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_3 
              signal word_access_3_125_start: Boolean;
              signal Xentry_126_symbol: Boolean;
              signal Xexit_127_symbol: Boolean;
              signal rr_128_symbol : Boolean;
              signal ra_129_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_125_start <= Xentry_108_symbol; -- control passed to block
              Xentry_126_symbol  <= word_access_3_125_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_3/$entry
              rr_128_symbol <= Xentry_126_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_3/rr
              ptr_deref_65_store_3_req_0 <= rr_128_symbol; -- link to DP
              ra_129_symbol <= ptr_deref_65_store_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_3/ra
              Xexit_127_symbol <= ra_129_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_3/$exit
              word_access_3_125_symbol <= Xexit_127_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/word_access_3
            Xexit_109_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/$exit 
              signal Xexit_109_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_109_predecessors(0) <= word_access_0_110_symbol;
              Xexit_109_predecessors(1) <= word_access_1_115_symbol;
              Xexit_109_predecessors(2) <= word_access_2_120_symbol;
              Xexit_109_predecessors(3) <= word_access_3_125_symbol;
              Xexit_109_join: join -- 
                port map( -- 
                  preds => Xexit_109_predecessors,
                  symbol_out => Xexit_109_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access/$exit
            word_access_107_symbol <= Xexit_109_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/word_access
          Xexit_104_symbol <= word_access_107_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request/$exit
          ptr_deref_65_request_102_symbol <= Xexit_104_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_request
        ptr_deref_65_complete_130: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete 
          signal ptr_deref_65_complete_130_start: Boolean;
          signal Xentry_131_symbol: Boolean;
          signal Xexit_132_symbol: Boolean;
          signal word_access_133_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_65_complete_130_start <= ptr_deref_65_active_x_x98_symbol; -- control passed to block
          Xentry_131_symbol  <= ptr_deref_65_complete_130_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/$entry
          word_access_133: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access 
            signal word_access_133_start: Boolean;
            signal Xentry_134_symbol: Boolean;
            signal Xexit_135_symbol: Boolean;
            signal word_access_0_136_symbol : Boolean;
            signal word_access_1_141_symbol : Boolean;
            signal word_access_2_146_symbol : Boolean;
            signal word_access_3_151_symbol : Boolean;
            -- 
          begin -- 
            word_access_133_start <= Xentry_131_symbol; -- control passed to block
            Xentry_134_symbol  <= word_access_133_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/$entry
            word_access_0_136: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_0 
              signal word_access_0_136_start: Boolean;
              signal Xentry_137_symbol: Boolean;
              signal Xexit_138_symbol: Boolean;
              signal cr_139_symbol : Boolean;
              signal ca_140_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_136_start <= Xentry_134_symbol; -- control passed to block
              Xentry_137_symbol  <= word_access_0_136_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_0/$entry
              cr_139_symbol <= Xentry_137_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_0/cr
              ptr_deref_65_store_0_req_1 <= cr_139_symbol; -- link to DP
              ca_140_symbol <= ptr_deref_65_store_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_0/ca
              Xexit_138_symbol <= ca_140_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_0/$exit
              word_access_0_136_symbol <= Xexit_138_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_0
            word_access_1_141: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_1 
              signal word_access_1_141_start: Boolean;
              signal Xentry_142_symbol: Boolean;
              signal Xexit_143_symbol: Boolean;
              signal cr_144_symbol : Boolean;
              signal ca_145_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_141_start <= Xentry_134_symbol; -- control passed to block
              Xentry_142_symbol  <= word_access_1_141_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_1/$entry
              cr_144_symbol <= Xentry_142_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_1/cr
              ptr_deref_65_store_1_req_1 <= cr_144_symbol; -- link to DP
              ca_145_symbol <= ptr_deref_65_store_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_1/ca
              Xexit_143_symbol <= ca_145_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_1/$exit
              word_access_1_141_symbol <= Xexit_143_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_1
            word_access_2_146: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_2 
              signal word_access_2_146_start: Boolean;
              signal Xentry_147_symbol: Boolean;
              signal Xexit_148_symbol: Boolean;
              signal cr_149_symbol : Boolean;
              signal ca_150_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_146_start <= Xentry_134_symbol; -- control passed to block
              Xentry_147_symbol  <= word_access_2_146_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_2/$entry
              cr_149_symbol <= Xentry_147_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_2/cr
              ptr_deref_65_store_2_req_1 <= cr_149_symbol; -- link to DP
              ca_150_symbol <= ptr_deref_65_store_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_2/ca
              Xexit_148_symbol <= ca_150_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_2/$exit
              word_access_2_146_symbol <= Xexit_148_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_2
            word_access_3_151: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_3 
              signal word_access_3_151_start: Boolean;
              signal Xentry_152_symbol: Boolean;
              signal Xexit_153_symbol: Boolean;
              signal cr_154_symbol : Boolean;
              signal ca_155_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_151_start <= Xentry_134_symbol; -- control passed to block
              Xentry_152_symbol  <= word_access_3_151_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_3/$entry
              cr_154_symbol <= Xentry_152_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_3/cr
              ptr_deref_65_store_3_req_1 <= cr_154_symbol; -- link to DP
              ca_155_symbol <= ptr_deref_65_store_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_3/ca
              Xexit_153_symbol <= ca_155_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_3/$exit
              word_access_3_151_symbol <= Xexit_153_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/word_access_3
            Xexit_135_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/$exit 
              signal Xexit_135_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_135_predecessors(0) <= word_access_0_136_symbol;
              Xexit_135_predecessors(1) <= word_access_1_141_symbol;
              Xexit_135_predecessors(2) <= word_access_2_146_symbol;
              Xexit_135_predecessors(3) <= word_access_3_151_symbol;
              Xexit_135_join: join -- 
                port map( -- 
                  preds => Xexit_135_predecessors,
                  symbol_out => Xexit_135_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access/$exit
            word_access_133_symbol <= Xexit_135_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/word_access
          Xexit_132_symbol <= word_access_133_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete/$exit
          ptr_deref_65_complete_130_symbol <= Xexit_132_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_65_complete
        assign_stmt_71_active_x_x156_symbol <= ptr_deref_70_complete_189_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_71_active_
        assign_stmt_71_completed_x_x157_symbol <= assign_stmt_71_active_x_x156_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_71_completed_
        ptr_deref_70_trigger_x_x158_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_trigger_ 
          signal ptr_deref_70_trigger_x_x158_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_70_trigger_x_x158_predecessors(0) <= ptr_deref_70_word_address_calculated_162_symbol;
          ptr_deref_70_trigger_x_x158_predecessors(1) <= ptr_deref_65_active_x_x98_symbol;
          ptr_deref_70_trigger_x_x158_join: join -- 
            port map( -- 
              preds => ptr_deref_70_trigger_x_x158_predecessors,
              symbol_out => ptr_deref_70_trigger_x_x158_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_trigger_
        ptr_deref_70_active_x_x159_symbol <= ptr_deref_70_request_163_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_active_
        ptr_deref_70_base_address_calculated_160_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_base_address_calculated
        ptr_deref_70_root_address_calculated_161_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_root_address_calculated
        ptr_deref_70_word_address_calculated_162_symbol <= ptr_deref_70_root_address_calculated_161_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_word_address_calculated
        ptr_deref_70_request_163: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request 
          signal ptr_deref_70_request_163_start: Boolean;
          signal Xentry_164_symbol: Boolean;
          signal Xexit_165_symbol: Boolean;
          signal word_access_166_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_70_request_163_start <= ptr_deref_70_trigger_x_x158_symbol; -- control passed to block
          Xentry_164_symbol  <= ptr_deref_70_request_163_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/$entry
          word_access_166: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access 
            signal word_access_166_start: Boolean;
            signal Xentry_167_symbol: Boolean;
            signal Xexit_168_symbol: Boolean;
            signal word_access_0_169_symbol : Boolean;
            signal word_access_1_174_symbol : Boolean;
            signal word_access_2_179_symbol : Boolean;
            signal word_access_3_184_symbol : Boolean;
            -- 
          begin -- 
            word_access_166_start <= Xentry_164_symbol; -- control passed to block
            Xentry_167_symbol  <= word_access_166_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/$entry
            word_access_0_169: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_0 
              signal word_access_0_169_start: Boolean;
              signal Xentry_170_symbol: Boolean;
              signal Xexit_171_symbol: Boolean;
              signal rr_172_symbol : Boolean;
              signal ra_173_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_169_start <= Xentry_167_symbol; -- control passed to block
              Xentry_170_symbol  <= word_access_0_169_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_0/$entry
              rr_172_symbol <= Xentry_170_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_0/rr
              ptr_deref_70_load_0_req_0 <= rr_172_symbol; -- link to DP
              ra_173_symbol <= ptr_deref_70_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_0/ra
              Xexit_171_symbol <= ra_173_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_0/$exit
              word_access_0_169_symbol <= Xexit_171_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_0
            word_access_1_174: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_1 
              signal word_access_1_174_start: Boolean;
              signal Xentry_175_symbol: Boolean;
              signal Xexit_176_symbol: Boolean;
              signal rr_177_symbol : Boolean;
              signal ra_178_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_174_start <= Xentry_167_symbol; -- control passed to block
              Xentry_175_symbol  <= word_access_1_174_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_1/$entry
              rr_177_symbol <= Xentry_175_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_1/rr
              ptr_deref_70_load_1_req_0 <= rr_177_symbol; -- link to DP
              ra_178_symbol <= ptr_deref_70_load_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_1/ra
              Xexit_176_symbol <= ra_178_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_1/$exit
              word_access_1_174_symbol <= Xexit_176_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_1
            word_access_2_179: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_2 
              signal word_access_2_179_start: Boolean;
              signal Xentry_180_symbol: Boolean;
              signal Xexit_181_symbol: Boolean;
              signal rr_182_symbol : Boolean;
              signal ra_183_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_179_start <= Xentry_167_symbol; -- control passed to block
              Xentry_180_symbol  <= word_access_2_179_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_2/$entry
              rr_182_symbol <= Xentry_180_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_2/rr
              ptr_deref_70_load_2_req_0 <= rr_182_symbol; -- link to DP
              ra_183_symbol <= ptr_deref_70_load_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_2/ra
              Xexit_181_symbol <= ra_183_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_2/$exit
              word_access_2_179_symbol <= Xexit_181_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_2
            word_access_3_184: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_3 
              signal word_access_3_184_start: Boolean;
              signal Xentry_185_symbol: Boolean;
              signal Xexit_186_symbol: Boolean;
              signal rr_187_symbol : Boolean;
              signal ra_188_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_184_start <= Xentry_167_symbol; -- control passed to block
              Xentry_185_symbol  <= word_access_3_184_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_3/$entry
              rr_187_symbol <= Xentry_185_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_3/rr
              ptr_deref_70_load_3_req_0 <= rr_187_symbol; -- link to DP
              ra_188_symbol <= ptr_deref_70_load_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_3/ra
              Xexit_186_symbol <= ra_188_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_3/$exit
              word_access_3_184_symbol <= Xexit_186_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/word_access_3
            Xexit_168_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/$exit 
              signal Xexit_168_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_168_predecessors(0) <= word_access_0_169_symbol;
              Xexit_168_predecessors(1) <= word_access_1_174_symbol;
              Xexit_168_predecessors(2) <= word_access_2_179_symbol;
              Xexit_168_predecessors(3) <= word_access_3_184_symbol;
              Xexit_168_join: join -- 
                port map( -- 
                  preds => Xexit_168_predecessors,
                  symbol_out => Xexit_168_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access/$exit
            word_access_166_symbol <= Xexit_168_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/word_access
          Xexit_165_symbol <= word_access_166_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request/$exit
          ptr_deref_70_request_163_symbol <= Xexit_165_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_request
        ptr_deref_70_complete_189: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete 
          signal ptr_deref_70_complete_189_start: Boolean;
          signal Xentry_190_symbol: Boolean;
          signal Xexit_191_symbol: Boolean;
          signal word_access_192_symbol : Boolean;
          signal merge_req_215_symbol : Boolean;
          signal merge_ack_216_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_70_complete_189_start <= ptr_deref_70_active_x_x159_symbol; -- control passed to block
          Xentry_190_symbol  <= ptr_deref_70_complete_189_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/$entry
          word_access_192: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access 
            signal word_access_192_start: Boolean;
            signal Xentry_193_symbol: Boolean;
            signal Xexit_194_symbol: Boolean;
            signal word_access_0_195_symbol : Boolean;
            signal word_access_1_200_symbol : Boolean;
            signal word_access_2_205_symbol : Boolean;
            signal word_access_3_210_symbol : Boolean;
            -- 
          begin -- 
            word_access_192_start <= Xentry_190_symbol; -- control passed to block
            Xentry_193_symbol  <= word_access_192_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/$entry
            word_access_0_195: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_0 
              signal word_access_0_195_start: Boolean;
              signal Xentry_196_symbol: Boolean;
              signal Xexit_197_symbol: Boolean;
              signal cr_198_symbol : Boolean;
              signal ca_199_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_195_start <= Xentry_193_symbol; -- control passed to block
              Xentry_196_symbol  <= word_access_0_195_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_0/$entry
              cr_198_symbol <= Xentry_196_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_0/cr
              ptr_deref_70_load_0_req_1 <= cr_198_symbol; -- link to DP
              ca_199_symbol <= ptr_deref_70_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_0/ca
              Xexit_197_symbol <= ca_199_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_0/$exit
              word_access_0_195_symbol <= Xexit_197_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_0
            word_access_1_200: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_1 
              signal word_access_1_200_start: Boolean;
              signal Xentry_201_symbol: Boolean;
              signal Xexit_202_symbol: Boolean;
              signal cr_203_symbol : Boolean;
              signal ca_204_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_200_start <= Xentry_193_symbol; -- control passed to block
              Xentry_201_symbol  <= word_access_1_200_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_1/$entry
              cr_203_symbol <= Xentry_201_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_1/cr
              ptr_deref_70_load_1_req_1 <= cr_203_symbol; -- link to DP
              ca_204_symbol <= ptr_deref_70_load_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_1/ca
              Xexit_202_symbol <= ca_204_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_1/$exit
              word_access_1_200_symbol <= Xexit_202_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_1
            word_access_2_205: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_2 
              signal word_access_2_205_start: Boolean;
              signal Xentry_206_symbol: Boolean;
              signal Xexit_207_symbol: Boolean;
              signal cr_208_symbol : Boolean;
              signal ca_209_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_205_start <= Xentry_193_symbol; -- control passed to block
              Xentry_206_symbol  <= word_access_2_205_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_2/$entry
              cr_208_symbol <= Xentry_206_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_2/cr
              ptr_deref_70_load_2_req_1 <= cr_208_symbol; -- link to DP
              ca_209_symbol <= ptr_deref_70_load_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_2/ca
              Xexit_207_symbol <= ca_209_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_2/$exit
              word_access_2_205_symbol <= Xexit_207_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_2
            word_access_3_210: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_3 
              signal word_access_3_210_start: Boolean;
              signal Xentry_211_symbol: Boolean;
              signal Xexit_212_symbol: Boolean;
              signal cr_213_symbol : Boolean;
              signal ca_214_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_210_start <= Xentry_193_symbol; -- control passed to block
              Xentry_211_symbol  <= word_access_3_210_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_3/$entry
              cr_213_symbol <= Xentry_211_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_3/cr
              ptr_deref_70_load_3_req_1 <= cr_213_symbol; -- link to DP
              ca_214_symbol <= ptr_deref_70_load_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_3/ca
              Xexit_212_symbol <= ca_214_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_3/$exit
              word_access_3_210_symbol <= Xexit_212_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/word_access_3
            Xexit_194_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/$exit 
              signal Xexit_194_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_194_predecessors(0) <= word_access_0_195_symbol;
              Xexit_194_predecessors(1) <= word_access_1_200_symbol;
              Xexit_194_predecessors(2) <= word_access_2_205_symbol;
              Xexit_194_predecessors(3) <= word_access_3_210_symbol;
              Xexit_194_join: join -- 
                port map( -- 
                  preds => Xexit_194_predecessors,
                  symbol_out => Xexit_194_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access/$exit
            word_access_192_symbol <= Xexit_194_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/word_access
          merge_req_215_symbol <= word_access_192_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/merge_req
          ptr_deref_70_gather_scatter_req_0 <= merge_req_215_symbol; -- link to DP
          merge_ack_216_symbol <= ptr_deref_70_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/merge_ack
          Xexit_191_symbol <= merge_ack_216_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete/$exit
          ptr_deref_70_complete_189_symbol <= Xexit_191_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_70_complete
        assign_stmt_75_active_x_x217_symbol <= ptr_deref_74_complete_250_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_75_active_
        assign_stmt_75_completed_x_x218_symbol <= assign_stmt_75_active_x_x217_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_75_completed_
        ptr_deref_74_trigger_x_x219_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_trigger_ 
          signal ptr_deref_74_trigger_x_x219_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_74_trigger_x_x219_predecessors(0) <= ptr_deref_74_word_address_calculated_223_symbol;
          ptr_deref_74_trigger_x_x219_predecessors(1) <= ptr_deref_65_active_x_x98_symbol;
          ptr_deref_74_trigger_x_x219_join: join -- 
            port map( -- 
              preds => ptr_deref_74_trigger_x_x219_predecessors,
              symbol_out => ptr_deref_74_trigger_x_x219_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_trigger_
        ptr_deref_74_active_x_x220_symbol <= ptr_deref_74_request_224_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_active_
        ptr_deref_74_base_address_calculated_221_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_base_address_calculated
        ptr_deref_74_root_address_calculated_222_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_root_address_calculated
        ptr_deref_74_word_address_calculated_223_symbol <= ptr_deref_74_root_address_calculated_222_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_word_address_calculated
        ptr_deref_74_request_224: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request 
          signal ptr_deref_74_request_224_start: Boolean;
          signal Xentry_225_symbol: Boolean;
          signal Xexit_226_symbol: Boolean;
          signal word_access_227_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_74_request_224_start <= ptr_deref_74_trigger_x_x219_symbol; -- control passed to block
          Xentry_225_symbol  <= ptr_deref_74_request_224_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/$entry
          word_access_227: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access 
            signal word_access_227_start: Boolean;
            signal Xentry_228_symbol: Boolean;
            signal Xexit_229_symbol: Boolean;
            signal word_access_0_230_symbol : Boolean;
            signal word_access_1_235_symbol : Boolean;
            signal word_access_2_240_symbol : Boolean;
            signal word_access_3_245_symbol : Boolean;
            -- 
          begin -- 
            word_access_227_start <= Xentry_225_symbol; -- control passed to block
            Xentry_228_symbol  <= word_access_227_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/$entry
            word_access_0_230: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_0 
              signal word_access_0_230_start: Boolean;
              signal Xentry_231_symbol: Boolean;
              signal Xexit_232_symbol: Boolean;
              signal rr_233_symbol : Boolean;
              signal ra_234_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_230_start <= Xentry_228_symbol; -- control passed to block
              Xentry_231_symbol  <= word_access_0_230_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_0/$entry
              rr_233_symbol <= Xentry_231_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_0/rr
              ptr_deref_74_load_0_req_0 <= rr_233_symbol; -- link to DP
              ra_234_symbol <= ptr_deref_74_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_0/ra
              Xexit_232_symbol <= ra_234_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_0/$exit
              word_access_0_230_symbol <= Xexit_232_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_0
            word_access_1_235: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_1 
              signal word_access_1_235_start: Boolean;
              signal Xentry_236_symbol: Boolean;
              signal Xexit_237_symbol: Boolean;
              signal rr_238_symbol : Boolean;
              signal ra_239_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_235_start <= Xentry_228_symbol; -- control passed to block
              Xentry_236_symbol  <= word_access_1_235_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_1/$entry
              rr_238_symbol <= Xentry_236_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_1/rr
              ptr_deref_74_load_1_req_0 <= rr_238_symbol; -- link to DP
              ra_239_symbol <= ptr_deref_74_load_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_1/ra
              Xexit_237_symbol <= ra_239_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_1/$exit
              word_access_1_235_symbol <= Xexit_237_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_1
            word_access_2_240: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_2 
              signal word_access_2_240_start: Boolean;
              signal Xentry_241_symbol: Boolean;
              signal Xexit_242_symbol: Boolean;
              signal rr_243_symbol : Boolean;
              signal ra_244_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_240_start <= Xentry_228_symbol; -- control passed to block
              Xentry_241_symbol  <= word_access_2_240_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_2/$entry
              rr_243_symbol <= Xentry_241_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_2/rr
              ptr_deref_74_load_2_req_0 <= rr_243_symbol; -- link to DP
              ra_244_symbol <= ptr_deref_74_load_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_2/ra
              Xexit_242_symbol <= ra_244_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_2/$exit
              word_access_2_240_symbol <= Xexit_242_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_2
            word_access_3_245: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_3 
              signal word_access_3_245_start: Boolean;
              signal Xentry_246_symbol: Boolean;
              signal Xexit_247_symbol: Boolean;
              signal rr_248_symbol : Boolean;
              signal ra_249_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_245_start <= Xentry_228_symbol; -- control passed to block
              Xentry_246_symbol  <= word_access_3_245_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_3/$entry
              rr_248_symbol <= Xentry_246_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_3/rr
              ptr_deref_74_load_3_req_0 <= rr_248_symbol; -- link to DP
              ra_249_symbol <= ptr_deref_74_load_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_3/ra
              Xexit_247_symbol <= ra_249_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_3/$exit
              word_access_3_245_symbol <= Xexit_247_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/word_access_3
            Xexit_229_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/$exit 
              signal Xexit_229_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_229_predecessors(0) <= word_access_0_230_symbol;
              Xexit_229_predecessors(1) <= word_access_1_235_symbol;
              Xexit_229_predecessors(2) <= word_access_2_240_symbol;
              Xexit_229_predecessors(3) <= word_access_3_245_symbol;
              Xexit_229_join: join -- 
                port map( -- 
                  preds => Xexit_229_predecessors,
                  symbol_out => Xexit_229_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access/$exit
            word_access_227_symbol <= Xexit_229_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/word_access
          Xexit_226_symbol <= word_access_227_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request/$exit
          ptr_deref_74_request_224_symbol <= Xexit_226_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_request
        ptr_deref_74_complete_250: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete 
          signal ptr_deref_74_complete_250_start: Boolean;
          signal Xentry_251_symbol: Boolean;
          signal Xexit_252_symbol: Boolean;
          signal word_access_253_symbol : Boolean;
          signal merge_req_276_symbol : Boolean;
          signal merge_ack_277_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_74_complete_250_start <= ptr_deref_74_active_x_x220_symbol; -- control passed to block
          Xentry_251_symbol  <= ptr_deref_74_complete_250_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/$entry
          word_access_253: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access 
            signal word_access_253_start: Boolean;
            signal Xentry_254_symbol: Boolean;
            signal Xexit_255_symbol: Boolean;
            signal word_access_0_256_symbol : Boolean;
            signal word_access_1_261_symbol : Boolean;
            signal word_access_2_266_symbol : Boolean;
            signal word_access_3_271_symbol : Boolean;
            -- 
          begin -- 
            word_access_253_start <= Xentry_251_symbol; -- control passed to block
            Xentry_254_symbol  <= word_access_253_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/$entry
            word_access_0_256: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_0 
              signal word_access_0_256_start: Boolean;
              signal Xentry_257_symbol: Boolean;
              signal Xexit_258_symbol: Boolean;
              signal cr_259_symbol : Boolean;
              signal ca_260_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_256_start <= Xentry_254_symbol; -- control passed to block
              Xentry_257_symbol  <= word_access_0_256_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_0/$entry
              cr_259_symbol <= Xentry_257_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_0/cr
              ptr_deref_74_load_0_req_1 <= cr_259_symbol; -- link to DP
              ca_260_symbol <= ptr_deref_74_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_0/ca
              Xexit_258_symbol <= ca_260_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_0/$exit
              word_access_0_256_symbol <= Xexit_258_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_0
            word_access_1_261: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_1 
              signal word_access_1_261_start: Boolean;
              signal Xentry_262_symbol: Boolean;
              signal Xexit_263_symbol: Boolean;
              signal cr_264_symbol : Boolean;
              signal ca_265_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_261_start <= Xentry_254_symbol; -- control passed to block
              Xentry_262_symbol  <= word_access_1_261_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_1/$entry
              cr_264_symbol <= Xentry_262_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_1/cr
              ptr_deref_74_load_1_req_1 <= cr_264_symbol; -- link to DP
              ca_265_symbol <= ptr_deref_74_load_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_1/ca
              Xexit_263_symbol <= ca_265_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_1/$exit
              word_access_1_261_symbol <= Xexit_263_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_1
            word_access_2_266: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_2 
              signal word_access_2_266_start: Boolean;
              signal Xentry_267_symbol: Boolean;
              signal Xexit_268_symbol: Boolean;
              signal cr_269_symbol : Boolean;
              signal ca_270_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_266_start <= Xentry_254_symbol; -- control passed to block
              Xentry_267_symbol  <= word_access_2_266_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_2/$entry
              cr_269_symbol <= Xentry_267_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_2/cr
              ptr_deref_74_load_2_req_1 <= cr_269_symbol; -- link to DP
              ca_270_symbol <= ptr_deref_74_load_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_2/ca
              Xexit_268_symbol <= ca_270_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_2/$exit
              word_access_2_266_symbol <= Xexit_268_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_2
            word_access_3_271: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_3 
              signal word_access_3_271_start: Boolean;
              signal Xentry_272_symbol: Boolean;
              signal Xexit_273_symbol: Boolean;
              signal cr_274_symbol : Boolean;
              signal ca_275_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_271_start <= Xentry_254_symbol; -- control passed to block
              Xentry_272_symbol  <= word_access_3_271_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_3/$entry
              cr_274_symbol <= Xentry_272_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_3/cr
              ptr_deref_74_load_3_req_1 <= cr_274_symbol; -- link to DP
              ca_275_symbol <= ptr_deref_74_load_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_3/ca
              Xexit_273_symbol <= ca_275_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_3/$exit
              word_access_3_271_symbol <= Xexit_273_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/word_access_3
            Xexit_255_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/$exit 
              signal Xexit_255_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_255_predecessors(0) <= word_access_0_256_symbol;
              Xexit_255_predecessors(1) <= word_access_1_261_symbol;
              Xexit_255_predecessors(2) <= word_access_2_266_symbol;
              Xexit_255_predecessors(3) <= word_access_3_271_symbol;
              Xexit_255_join: join -- 
                port map( -- 
                  preds => Xexit_255_predecessors,
                  symbol_out => Xexit_255_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access/$exit
            word_access_253_symbol <= Xexit_255_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/word_access
          merge_req_276_symbol <= word_access_253_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/merge_req
          ptr_deref_74_gather_scatter_req_0 <= merge_req_276_symbol; -- link to DP
          merge_ack_277_symbol <= ptr_deref_74_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/merge_ack
          Xexit_252_symbol <= merge_ack_277_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete/$exit
          ptr_deref_74_complete_250_symbol <= Xexit_252_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_74_complete
        assign_stmt_80_active_x_x278_symbol <= binary_79_complete_284_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_80_active_
        assign_stmt_80_completed_x_x279_symbol <= assign_stmt_80_active_x_x278_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_80_completed_
        binary_79_active_x_x280_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_active_ 
          signal binary_79_active_x_x280_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_79_active_x_x280_predecessors(0) <= binary_79_trigger_x_x281_symbol;
          binary_79_active_x_x280_predecessors(1) <= simple_obj_ref_77_complete_282_symbol;
          binary_79_active_x_x280_predecessors(2) <= simple_obj_ref_78_complete_283_symbol;
          binary_79_active_x_x280_join: join -- 
            port map( -- 
              preds => binary_79_active_x_x280_predecessors,
              symbol_out => binary_79_active_x_x280_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_active_
        binary_79_trigger_x_x281_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_trigger_
        simple_obj_ref_77_complete_282_symbol <= assign_stmt_71_completed_x_x157_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_77_complete
        simple_obj_ref_78_complete_283_symbol <= assign_stmt_75_completed_x_x218_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_78_complete
        binary_79_complete_284: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete 
          signal binary_79_complete_284_start: Boolean;
          signal Xentry_285_symbol: Boolean;
          signal Xexit_286_symbol: Boolean;
          signal rr_287_symbol : Boolean;
          signal ra_288_symbol : Boolean;
          signal cr_289_symbol : Boolean;
          signal ca_290_symbol : Boolean;
          -- 
        begin -- 
          binary_79_complete_284_start <= binary_79_active_x_x280_symbol; -- control passed to block
          Xentry_285_symbol  <= binary_79_complete_284_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete/$entry
          rr_287_symbol <= Xentry_285_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete/rr
          binary_79_inst_req_0 <= rr_287_symbol; -- link to DP
          ra_288_symbol <= binary_79_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete/ra
          cr_289_symbol <= ra_288_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete/cr
          binary_79_inst_req_1 <= cr_289_symbol; -- link to DP
          ca_290_symbol <= binary_79_inst_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete/ca
          Xexit_286_symbol <= ca_290_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete/$exit
          binary_79_complete_284_symbol <= Xexit_286_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/binary_79_complete
        assign_stmt_89_active_x_x291_symbol <= type_cast_88_complete_296_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_89_active_
        assign_stmt_89_completed_x_x292_symbol <= simple_obj_ref_86_complete_302_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_89_completed_
        type_cast_88_active_x_x293_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_active_ 
          signal type_cast_88_active_x_x293_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_88_active_x_x293_predecessors(0) <= type_cast_88_trigger_x_x294_symbol;
          type_cast_88_active_x_x293_predecessors(1) <= simple_obj_ref_87_complete_295_symbol;
          type_cast_88_active_x_x293_join: join -- 
            port map( -- 
              preds => type_cast_88_active_x_x293_predecessors,
              symbol_out => type_cast_88_active_x_x293_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_active_
        type_cast_88_trigger_x_x294_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_trigger_
        simple_obj_ref_87_complete_295_symbol <= assign_stmt_80_completed_x_x279_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_87_complete
        type_cast_88_complete_296: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_complete 
          signal type_cast_88_complete_296_start: Boolean;
          signal Xentry_297_symbol: Boolean;
          signal Xexit_298_symbol: Boolean;
          signal req_299_symbol : Boolean;
          signal ack_300_symbol : Boolean;
          -- 
        begin -- 
          type_cast_88_complete_296_start <= type_cast_88_active_x_x293_symbol; -- control passed to block
          Xentry_297_symbol  <= type_cast_88_complete_296_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_complete/$entry
          req_299_symbol <= Xentry_297_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_complete/req
          type_cast_88_inst_req_0 <= req_299_symbol; -- link to DP
          ack_300_symbol <= type_cast_88_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_complete/ack
          Xexit_298_symbol <= ack_300_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_complete/$exit
          type_cast_88_complete_296_symbol <= Xexit_298_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/type_cast_88_complete
        simple_obj_ref_86_trigger_x_x301_symbol <= assign_stmt_89_active_x_x291_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_trigger_
        simple_obj_ref_86_complete_302: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_complete 
          signal simple_obj_ref_86_complete_302_start: Boolean;
          signal Xentry_303_symbol: Boolean;
          signal Xexit_304_symbol: Boolean;
          signal pipe_wreq_305_symbol : Boolean;
          signal pipe_wack_306_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_86_complete_302_start <= simple_obj_ref_86_trigger_x_x301_symbol; -- control passed to block
          Xentry_303_symbol  <= simple_obj_ref_86_complete_302_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_complete/$entry
          pipe_wreq_305_symbol <= Xentry_303_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_complete/pipe_wreq
          simple_obj_ref_86_inst_req_0 <= pipe_wreq_305_symbol; -- link to DP
          pipe_wack_306_symbol <= simple_obj_ref_86_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_complete/pipe_wack
          Xexit_304_symbol <= pipe_wack_306_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_complete/$exit
          simple_obj_ref_86_complete_302_symbol <= Xexit_304_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_86_complete
        assign_stmt_93_active_x_x307_symbol <= ptr_deref_92_complete_340_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_93_active_
        assign_stmt_93_completed_x_x308_symbol <= assign_stmt_93_active_x_x307_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_93_completed_
        ptr_deref_92_trigger_x_x309_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_trigger_ 
          signal ptr_deref_92_trigger_x_x309_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_92_trigger_x_x309_predecessors(0) <= ptr_deref_92_word_address_calculated_313_symbol;
          ptr_deref_92_trigger_x_x309_predecessors(1) <= ptr_deref_65_active_x_x98_symbol;
          ptr_deref_92_trigger_x_x309_join: join -- 
            port map( -- 
              preds => ptr_deref_92_trigger_x_x309_predecessors,
              symbol_out => ptr_deref_92_trigger_x_x309_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_trigger_
        ptr_deref_92_active_x_x310_symbol <= ptr_deref_92_request_314_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_active_
        ptr_deref_92_base_address_calculated_311_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_base_address_calculated
        ptr_deref_92_root_address_calculated_312_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_root_address_calculated
        ptr_deref_92_word_address_calculated_313_symbol <= ptr_deref_92_root_address_calculated_312_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_word_address_calculated
        ptr_deref_92_request_314: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request 
          signal ptr_deref_92_request_314_start: Boolean;
          signal Xentry_315_symbol: Boolean;
          signal Xexit_316_symbol: Boolean;
          signal word_access_317_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_92_request_314_start <= ptr_deref_92_trigger_x_x309_symbol; -- control passed to block
          Xentry_315_symbol  <= ptr_deref_92_request_314_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/$entry
          word_access_317: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access 
            signal word_access_317_start: Boolean;
            signal Xentry_318_symbol: Boolean;
            signal Xexit_319_symbol: Boolean;
            signal word_access_0_320_symbol : Boolean;
            signal word_access_1_325_symbol : Boolean;
            signal word_access_2_330_symbol : Boolean;
            signal word_access_3_335_symbol : Boolean;
            -- 
          begin -- 
            word_access_317_start <= Xentry_315_symbol; -- control passed to block
            Xentry_318_symbol  <= word_access_317_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/$entry
            word_access_0_320: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_0 
              signal word_access_0_320_start: Boolean;
              signal Xentry_321_symbol: Boolean;
              signal Xexit_322_symbol: Boolean;
              signal rr_323_symbol : Boolean;
              signal ra_324_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_320_start <= Xentry_318_symbol; -- control passed to block
              Xentry_321_symbol  <= word_access_0_320_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_0/$entry
              rr_323_symbol <= Xentry_321_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_0/rr
              ptr_deref_92_load_0_req_0 <= rr_323_symbol; -- link to DP
              ra_324_symbol <= ptr_deref_92_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_0/ra
              Xexit_322_symbol <= ra_324_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_0/$exit
              word_access_0_320_symbol <= Xexit_322_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_0
            word_access_1_325: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_1 
              signal word_access_1_325_start: Boolean;
              signal Xentry_326_symbol: Boolean;
              signal Xexit_327_symbol: Boolean;
              signal rr_328_symbol : Boolean;
              signal ra_329_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_325_start <= Xentry_318_symbol; -- control passed to block
              Xentry_326_symbol  <= word_access_1_325_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_1/$entry
              rr_328_symbol <= Xentry_326_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_1/rr
              ptr_deref_92_load_1_req_0 <= rr_328_symbol; -- link to DP
              ra_329_symbol <= ptr_deref_92_load_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_1/ra
              Xexit_327_symbol <= ra_329_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_1/$exit
              word_access_1_325_symbol <= Xexit_327_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_1
            word_access_2_330: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_2 
              signal word_access_2_330_start: Boolean;
              signal Xentry_331_symbol: Boolean;
              signal Xexit_332_symbol: Boolean;
              signal rr_333_symbol : Boolean;
              signal ra_334_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_330_start <= Xentry_318_symbol; -- control passed to block
              Xentry_331_symbol  <= word_access_2_330_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_2/$entry
              rr_333_symbol <= Xentry_331_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_2/rr
              ptr_deref_92_load_2_req_0 <= rr_333_symbol; -- link to DP
              ra_334_symbol <= ptr_deref_92_load_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_2/ra
              Xexit_332_symbol <= ra_334_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_2/$exit
              word_access_2_330_symbol <= Xexit_332_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_2
            word_access_3_335: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_3 
              signal word_access_3_335_start: Boolean;
              signal Xentry_336_symbol: Boolean;
              signal Xexit_337_symbol: Boolean;
              signal rr_338_symbol : Boolean;
              signal ra_339_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_335_start <= Xentry_318_symbol; -- control passed to block
              Xentry_336_symbol  <= word_access_3_335_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_3/$entry
              rr_338_symbol <= Xentry_336_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_3/rr
              ptr_deref_92_load_3_req_0 <= rr_338_symbol; -- link to DP
              ra_339_symbol <= ptr_deref_92_load_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_3/ra
              Xexit_337_symbol <= ra_339_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_3/$exit
              word_access_3_335_symbol <= Xexit_337_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/word_access_3
            Xexit_319_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/$exit 
              signal Xexit_319_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_319_predecessors(0) <= word_access_0_320_symbol;
              Xexit_319_predecessors(1) <= word_access_1_325_symbol;
              Xexit_319_predecessors(2) <= word_access_2_330_symbol;
              Xexit_319_predecessors(3) <= word_access_3_335_symbol;
              Xexit_319_join: join -- 
                port map( -- 
                  preds => Xexit_319_predecessors,
                  symbol_out => Xexit_319_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access/$exit
            word_access_317_symbol <= Xexit_319_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/word_access
          Xexit_316_symbol <= word_access_317_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request/$exit
          ptr_deref_92_request_314_symbol <= Xexit_316_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_request
        ptr_deref_92_complete_340: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete 
          signal ptr_deref_92_complete_340_start: Boolean;
          signal Xentry_341_symbol: Boolean;
          signal Xexit_342_symbol: Boolean;
          signal word_access_343_symbol : Boolean;
          signal merge_req_366_symbol : Boolean;
          signal merge_ack_367_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_92_complete_340_start <= ptr_deref_92_active_x_x310_symbol; -- control passed to block
          Xentry_341_symbol  <= ptr_deref_92_complete_340_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/$entry
          word_access_343: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access 
            signal word_access_343_start: Boolean;
            signal Xentry_344_symbol: Boolean;
            signal Xexit_345_symbol: Boolean;
            signal word_access_0_346_symbol : Boolean;
            signal word_access_1_351_symbol : Boolean;
            signal word_access_2_356_symbol : Boolean;
            signal word_access_3_361_symbol : Boolean;
            -- 
          begin -- 
            word_access_343_start <= Xentry_341_symbol; -- control passed to block
            Xentry_344_symbol  <= word_access_343_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/$entry
            word_access_0_346: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_0 
              signal word_access_0_346_start: Boolean;
              signal Xentry_347_symbol: Boolean;
              signal Xexit_348_symbol: Boolean;
              signal cr_349_symbol : Boolean;
              signal ca_350_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_346_start <= Xentry_344_symbol; -- control passed to block
              Xentry_347_symbol  <= word_access_0_346_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_0/$entry
              cr_349_symbol <= Xentry_347_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_0/cr
              ptr_deref_92_load_0_req_1 <= cr_349_symbol; -- link to DP
              ca_350_symbol <= ptr_deref_92_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_0/ca
              Xexit_348_symbol <= ca_350_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_0/$exit
              word_access_0_346_symbol <= Xexit_348_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_0
            word_access_1_351: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_1 
              signal word_access_1_351_start: Boolean;
              signal Xentry_352_symbol: Boolean;
              signal Xexit_353_symbol: Boolean;
              signal cr_354_symbol : Boolean;
              signal ca_355_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_351_start <= Xentry_344_symbol; -- control passed to block
              Xentry_352_symbol  <= word_access_1_351_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_1/$entry
              cr_354_symbol <= Xentry_352_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_1/cr
              ptr_deref_92_load_1_req_1 <= cr_354_symbol; -- link to DP
              ca_355_symbol <= ptr_deref_92_load_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_1/ca
              Xexit_353_symbol <= ca_355_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_1/$exit
              word_access_1_351_symbol <= Xexit_353_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_1
            word_access_2_356: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_2 
              signal word_access_2_356_start: Boolean;
              signal Xentry_357_symbol: Boolean;
              signal Xexit_358_symbol: Boolean;
              signal cr_359_symbol : Boolean;
              signal ca_360_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_356_start <= Xentry_344_symbol; -- control passed to block
              Xentry_357_symbol  <= word_access_2_356_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_2/$entry
              cr_359_symbol <= Xentry_357_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_2/cr
              ptr_deref_92_load_2_req_1 <= cr_359_symbol; -- link to DP
              ca_360_symbol <= ptr_deref_92_load_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_2/ca
              Xexit_358_symbol <= ca_360_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_2/$exit
              word_access_2_356_symbol <= Xexit_358_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_2
            word_access_3_361: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_3 
              signal word_access_3_361_start: Boolean;
              signal Xentry_362_symbol: Boolean;
              signal Xexit_363_symbol: Boolean;
              signal cr_364_symbol : Boolean;
              signal ca_365_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_361_start <= Xentry_344_symbol; -- control passed to block
              Xentry_362_symbol  <= word_access_3_361_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_3/$entry
              cr_364_symbol <= Xentry_362_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_3/cr
              ptr_deref_92_load_3_req_1 <= cr_364_symbol; -- link to DP
              ca_365_symbol <= ptr_deref_92_load_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_3/ca
              Xexit_363_symbol <= ca_365_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_3/$exit
              word_access_3_361_symbol <= Xexit_363_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/word_access_3
            Xexit_345_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/$exit 
              signal Xexit_345_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_345_predecessors(0) <= word_access_0_346_symbol;
              Xexit_345_predecessors(1) <= word_access_1_351_symbol;
              Xexit_345_predecessors(2) <= word_access_2_356_symbol;
              Xexit_345_predecessors(3) <= word_access_3_361_symbol;
              Xexit_345_join: join -- 
                port map( -- 
                  preds => Xexit_345_predecessors,
                  symbol_out => Xexit_345_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access/$exit
            word_access_343_symbol <= Xexit_345_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/word_access
          merge_req_366_symbol <= word_access_343_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/merge_req
          ptr_deref_92_gather_scatter_req_0 <= merge_req_366_symbol; -- link to DP
          merge_ack_367_symbol <= ptr_deref_92_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/merge_ack
          Xexit_342_symbol <= merge_ack_367_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete/$exit
          ptr_deref_92_complete_340_symbol <= Xexit_342_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/ptr_deref_92_complete
        assign_stmt_96_active_x_x368_symbol <= simple_obj_ref_95_complete_370_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_96_active_
        assign_stmt_96_completed_x_x369_symbol <= simple_obj_ref_94_complete_388_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/assign_stmt_96_completed_
        simple_obj_ref_95_complete_370_symbol <= assign_stmt_93_completed_x_x308_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_95_complete
        simple_obj_ref_94_trigger_x_x371_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_trigger_ 
          signal simple_obj_ref_94_trigger_x_x371_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_94_trigger_x_x371_predecessors(0) <= simple_obj_ref_94_word_address_calculated_374_symbol;
          simple_obj_ref_94_trigger_x_x371_predecessors(1) <= assign_stmt_96_active_x_x368_symbol;
          simple_obj_ref_94_trigger_x_x371_join: join -- 
            port map( -- 
              preds => simple_obj_ref_94_trigger_x_x371_predecessors,
              symbol_out => simple_obj_ref_94_trigger_x_x371_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_trigger_
        simple_obj_ref_94_active_x_x372_symbol <= simple_obj_ref_94_request_375_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_active_
        simple_obj_ref_94_root_address_calculated_373_symbol <= Xentry_15_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_root_address_calculated
        simple_obj_ref_94_word_address_calculated_374_symbol <= simple_obj_ref_94_root_address_calculated_373_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_word_address_calculated
        simple_obj_ref_94_request_375: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request 
          signal simple_obj_ref_94_request_375_start: Boolean;
          signal Xentry_376_symbol: Boolean;
          signal Xexit_377_symbol: Boolean;
          signal split_req_378_symbol : Boolean;
          signal split_ack_379_symbol : Boolean;
          signal word_access_380_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_94_request_375_start <= simple_obj_ref_94_trigger_x_x371_symbol; -- control passed to block
          Xentry_376_symbol  <= simple_obj_ref_94_request_375_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/$entry
          split_req_378_symbol <= Xentry_376_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/split_req
          simple_obj_ref_94_gather_scatter_req_0 <= split_req_378_symbol; -- link to DP
          split_ack_379_symbol <= simple_obj_ref_94_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/split_ack
          word_access_380: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access 
            signal word_access_380_start: Boolean;
            signal Xentry_381_symbol: Boolean;
            signal Xexit_382_symbol: Boolean;
            signal word_access_0_383_symbol : Boolean;
            -- 
          begin -- 
            word_access_380_start <= split_ack_379_symbol; -- control passed to block
            Xentry_381_symbol  <= word_access_380_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/$entry
            word_access_0_383: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/word_access_0 
              signal word_access_0_383_start: Boolean;
              signal Xentry_384_symbol: Boolean;
              signal Xexit_385_symbol: Boolean;
              signal rr_386_symbol : Boolean;
              signal ra_387_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_383_start <= Xentry_381_symbol; -- control passed to block
              Xentry_384_symbol  <= word_access_0_383_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/word_access_0/$entry
              rr_386_symbol <= Xentry_384_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/word_access_0/rr
              simple_obj_ref_94_store_0_req_0 <= rr_386_symbol; -- link to DP
              ra_387_symbol <= simple_obj_ref_94_store_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/word_access_0/ra
              Xexit_385_symbol <= ra_387_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/word_access_0/$exit
              word_access_0_383_symbol <= Xexit_385_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/word_access_0
            Xexit_382_symbol <= word_access_0_383_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access/$exit
            word_access_380_symbol <= Xexit_382_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/word_access
          Xexit_377_symbol <= word_access_380_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request/$exit
          simple_obj_ref_94_request_375_symbol <= Xexit_377_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_request
        simple_obj_ref_94_complete_388: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete 
          signal simple_obj_ref_94_complete_388_start: Boolean;
          signal Xentry_389_symbol: Boolean;
          signal Xexit_390_symbol: Boolean;
          signal word_access_391_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_94_complete_388_start <= simple_obj_ref_94_active_x_x372_symbol; -- control passed to block
          Xentry_389_symbol  <= simple_obj_ref_94_complete_388_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/$entry
          word_access_391: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access 
            signal word_access_391_start: Boolean;
            signal Xentry_392_symbol: Boolean;
            signal Xexit_393_symbol: Boolean;
            signal word_access_0_394_symbol : Boolean;
            -- 
          begin -- 
            word_access_391_start <= Xentry_389_symbol; -- control passed to block
            Xentry_392_symbol  <= word_access_391_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/$entry
            word_access_0_394: Block -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/word_access_0 
              signal word_access_0_394_start: Boolean;
              signal Xentry_395_symbol: Boolean;
              signal Xexit_396_symbol: Boolean;
              signal cr_397_symbol : Boolean;
              signal ca_398_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_394_start <= Xentry_392_symbol; -- control passed to block
              Xentry_395_symbol  <= word_access_0_394_start; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/word_access_0/$entry
              cr_397_symbol <= Xentry_395_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/word_access_0/cr
              simple_obj_ref_94_store_0_req_1 <= cr_397_symbol; -- link to DP
              ca_398_symbol <= simple_obj_ref_94_store_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/word_access_0/ca
              Xexit_396_symbol <= ca_398_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/word_access_0/$exit
              word_access_0_394_symbol <= Xexit_396_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/word_access_0
            Xexit_393_symbol <= word_access_0_394_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access/$exit
            word_access_391_symbol <= Xexit_393_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/word_access
          Xexit_390_symbol <= word_access_391_symbol; -- transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete/$exit
          simple_obj_ref_94_complete_388_symbol <= Xexit_390_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/simple_obj_ref_94_complete
        Xexit_16_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/$exit 
          signal Xexit_16_predecessors: BooleanArray(8 downto 0);
          -- 
        begin -- 
          Xexit_16_predecessors(0) <= assign_stmt_54_completed_x_x18_symbol;
          Xexit_16_predecessors(1) <= ptr_deref_52_base_address_calculated_22_symbol;
          Xexit_16_predecessors(2) <= assign_stmt_67_completed_x_x95_symbol;
          Xexit_16_predecessors(3) <= ptr_deref_65_base_address_calculated_99_symbol;
          Xexit_16_predecessors(4) <= ptr_deref_70_base_address_calculated_160_symbol;
          Xexit_16_predecessors(5) <= ptr_deref_74_base_address_calculated_221_symbol;
          Xexit_16_predecessors(6) <= assign_stmt_89_completed_x_x292_symbol;
          Xexit_16_predecessors(7) <= ptr_deref_92_base_address_calculated_311_symbol;
          Xexit_16_predecessors(8) <= assign_stmt_96_completed_x_x369_symbol;
          Xexit_16_join: join -- 
            port map( -- 
              preds => Xexit_16_predecessors,
              symbol_out => Xexit_16_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96/$exit
        assign_stmt_46_to_assign_stmt_96_14_symbol <= Xexit_16_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_46_to_assign_stmt_96
      assign_stmt_101_399: Block -- branch_block_stmt_40/assign_stmt_101 
        signal assign_stmt_101_399_start: Boolean;
        signal Xentry_400_symbol: Boolean;
        signal Xexit_401_symbol: Boolean;
        signal assign_stmt_101_active_x_x402_symbol : Boolean;
        signal assign_stmt_101_completed_x_x403_symbol : Boolean;
        signal simple_obj_ref_100_trigger_x_x404_symbol : Boolean;
        signal simple_obj_ref_100_active_x_x405_symbol : Boolean;
        signal simple_obj_ref_100_root_address_calculated_406_symbol : Boolean;
        signal simple_obj_ref_100_word_address_calculated_407_symbol : Boolean;
        signal simple_obj_ref_100_request_408_symbol : Boolean;
        signal simple_obj_ref_100_complete_419_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_101_399_start <= assign_stmt_101_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_400_symbol  <= assign_stmt_101_399_start; -- transition branch_block_stmt_40/assign_stmt_101/$entry
        assign_stmt_101_active_x_x402_symbol <= simple_obj_ref_100_complete_419_symbol; -- transition branch_block_stmt_40/assign_stmt_101/assign_stmt_101_active_
        assign_stmt_101_completed_x_x403_symbol <= assign_stmt_101_active_x_x402_symbol; -- transition branch_block_stmt_40/assign_stmt_101/assign_stmt_101_completed_
        simple_obj_ref_100_trigger_x_x404_symbol <= simple_obj_ref_100_word_address_calculated_407_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_trigger_
        simple_obj_ref_100_active_x_x405_symbol <= simple_obj_ref_100_request_408_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_active_
        simple_obj_ref_100_root_address_calculated_406_symbol <= Xentry_400_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_root_address_calculated
        simple_obj_ref_100_word_address_calculated_407_symbol <= simple_obj_ref_100_root_address_calculated_406_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_word_address_calculated
        simple_obj_ref_100_request_408: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request 
          signal simple_obj_ref_100_request_408_start: Boolean;
          signal Xentry_409_symbol: Boolean;
          signal Xexit_410_symbol: Boolean;
          signal word_access_411_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_100_request_408_start <= simple_obj_ref_100_trigger_x_x404_symbol; -- control passed to block
          Xentry_409_symbol  <= simple_obj_ref_100_request_408_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/$entry
          word_access_411: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access 
            signal word_access_411_start: Boolean;
            signal Xentry_412_symbol: Boolean;
            signal Xexit_413_symbol: Boolean;
            signal word_access_0_414_symbol : Boolean;
            -- 
          begin -- 
            word_access_411_start <= Xentry_409_symbol; -- control passed to block
            Xentry_412_symbol  <= word_access_411_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/$entry
            word_access_0_414: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/word_access_0 
              signal word_access_0_414_start: Boolean;
              signal Xentry_415_symbol: Boolean;
              signal Xexit_416_symbol: Boolean;
              signal rr_417_symbol : Boolean;
              signal ra_418_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_414_start <= Xentry_412_symbol; -- control passed to block
              Xentry_415_symbol  <= word_access_0_414_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/word_access_0/$entry
              rr_417_symbol <= Xentry_415_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/word_access_0/rr
              simple_obj_ref_100_load_0_req_0 <= rr_417_symbol; -- link to DP
              ra_418_symbol <= simple_obj_ref_100_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/word_access_0/ra
              Xexit_416_symbol <= ra_418_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/word_access_0/$exit
              word_access_0_414_symbol <= Xexit_416_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/word_access_0
            Xexit_413_symbol <= word_access_0_414_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access/$exit
            word_access_411_symbol <= Xexit_413_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/word_access
          Xexit_410_symbol <= word_access_411_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request/$exit
          simple_obj_ref_100_request_408_symbol <= Xexit_410_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_request
        simple_obj_ref_100_complete_419: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete 
          signal simple_obj_ref_100_complete_419_start: Boolean;
          signal Xentry_420_symbol: Boolean;
          signal Xexit_421_symbol: Boolean;
          signal word_access_422_symbol : Boolean;
          signal merge_req_430_symbol : Boolean;
          signal merge_ack_431_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_100_complete_419_start <= simple_obj_ref_100_active_x_x405_symbol; -- control passed to block
          Xentry_420_symbol  <= simple_obj_ref_100_complete_419_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/$entry
          word_access_422: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access 
            signal word_access_422_start: Boolean;
            signal Xentry_423_symbol: Boolean;
            signal Xexit_424_symbol: Boolean;
            signal word_access_0_425_symbol : Boolean;
            -- 
          begin -- 
            word_access_422_start <= Xentry_420_symbol; -- control passed to block
            Xentry_423_symbol  <= word_access_422_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/$entry
            word_access_0_425: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/word_access_0 
              signal word_access_0_425_start: Boolean;
              signal Xentry_426_symbol: Boolean;
              signal Xexit_427_symbol: Boolean;
              signal cr_428_symbol : Boolean;
              signal ca_429_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_425_start <= Xentry_423_symbol; -- control passed to block
              Xentry_426_symbol  <= word_access_0_425_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/word_access_0/$entry
              cr_428_symbol <= Xentry_426_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/word_access_0/cr
              simple_obj_ref_100_load_0_req_1 <= cr_428_symbol; -- link to DP
              ca_429_symbol <= simple_obj_ref_100_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/word_access_0/ca
              Xexit_427_symbol <= ca_429_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/word_access_0/$exit
              word_access_0_425_symbol <= Xexit_427_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/word_access_0
            Xexit_424_symbol <= word_access_0_425_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access/$exit
            word_access_422_symbol <= Xexit_424_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/word_access
          merge_req_430_symbol <= word_access_422_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/merge_req
          simple_obj_ref_100_gather_scatter_req_0 <= merge_req_430_symbol; -- link to DP
          merge_ack_431_symbol <= simple_obj_ref_100_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/merge_ack
          Xexit_421_symbol <= merge_ack_431_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete/$exit
          simple_obj_ref_100_complete_419_symbol <= Xexit_421_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100_complete
        Xexit_401_symbol <= assign_stmt_101_completed_x_x403_symbol; -- transition branch_block_stmt_40/assign_stmt_101/$exit
        assign_stmt_101_399_symbol <= Xexit_401_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_101
      return_x_xx_xPhiReq_432: Block -- branch_block_stmt_40/return___PhiReq 
        signal return_x_xx_xPhiReq_432_start: Boolean;
        signal Xentry_433_symbol: Boolean;
        signal Xexit_434_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_432_start <= return_x_xx_x10_symbol; -- control passed to block
        Xentry_433_symbol  <= return_x_xx_xPhiReq_432_start; -- transition branch_block_stmt_40/return___PhiReq/$entry
        Xexit_434_symbol <= Xentry_433_symbol; -- transition branch_block_stmt_40/return___PhiReq/$exit
        return_x_xx_xPhiReq_432_symbol <= Xexit_434_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/return___PhiReq
      merge_stmt_98_PhiReqMerge_435_symbol  <=  return_x_xx_xPhiReq_432_symbol; -- place branch_block_stmt_40/merge_stmt_98_PhiReqMerge (optimized away) 
      merge_stmt_98_PhiAck_436: Block -- branch_block_stmt_40/merge_stmt_98_PhiAck 
        signal merge_stmt_98_PhiAck_436_start: Boolean;
        signal Xentry_437_symbol: Boolean;
        signal Xexit_438_symbol: Boolean;
        signal dummy_439_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_98_PhiAck_436_start <= merge_stmt_98_PhiReqMerge_435_symbol; -- control passed to block
        Xentry_437_symbol  <= merge_stmt_98_PhiAck_436_start; -- transition branch_block_stmt_40/merge_stmt_98_PhiAck/$entry
        dummy_439_symbol <= Xentry_437_symbol; -- transition branch_block_stmt_40/merge_stmt_98_PhiAck/dummy
        Xexit_438_symbol <= dummy_439_symbol; -- transition branch_block_stmt_40/merge_stmt_98_PhiAck/$exit
        merge_stmt_98_PhiAck_436_symbol <= Xexit_438_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/merge_stmt_98_PhiAck
      Xexit_5_symbol <= branch_block_stmt_40_x_xexit_x_xx_x7_symbol; -- transition branch_block_stmt_40/$exit
      branch_block_stmt_40_3_symbol <= Xexit_5_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_40
    Xexit_2_symbol <= branch_block_stmt_40_3_symbol; -- transition $exit
    fin  <=  '1' when Xexit_2_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal b_50 : std_logic_vector(31 downto 0);
    signal iNsTr_0_46 : std_logic_vector(31 downto 0);
    signal iNsTr_10_93 : std_logic_vector(31 downto 0);
    signal iNsTr_2_59 : std_logic_vector(31 downto 0);
    signal iNsTr_3_63 : std_logic_vector(31 downto 0);
    signal iNsTr_5_71 : std_logic_vector(31 downto 0);
    signal iNsTr_6_75 : std_logic_vector(31 downto 0);
    signal iNsTr_7_80 : std_logic_vector(31 downto 0);
    signal iNsTr_8_85 : std_logic_vector(31 downto 0);
    signal ptr_deref_52_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_52_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_52_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_52_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_52_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_52_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_52_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_52_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_52_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_65_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_65_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_65_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_65_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_65_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_65_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_65_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_65_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_65_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_70_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_70_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_70_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_70_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_70_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_70_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_70_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_70_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_74_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_74_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_74_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_74_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_74_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_74_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_74_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_74_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_92_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_92_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_92_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_92_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_92_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_92_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_92_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_92_word_address_3 : std_logic_vector(4 downto 0);
    signal simple_obj_ref_100_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_100_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_61_wire : std_logic_vector(31 downto 0);
    signal simple_obj_ref_94_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_94_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_88_wire : std_logic_vector(31 downto 0);
    signal xxbarxxbodyxxb_alloc_base_address : std_logic_vector(4 downto 0);
    signal xxbarxxbodyxxiNsTr_0_alloc_base_address : std_logic_vector(4 downto 0);
    signal xxbarxxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    b_50 <= "00000000000000000000000000000101";
    iNsTr_0_46 <= "00000000000000000000000000000001";
    iNsTr_2_59 <= "00000000000000000000000000000000";
    iNsTr_8_85 <= "00000000000000000000000000000000";
    ptr_deref_52_word_address_0 <= "00001";
    ptr_deref_52_word_address_1 <= "00010";
    ptr_deref_52_word_address_2 <= "00011";
    ptr_deref_52_word_address_3 <= "00100";
    ptr_deref_65_word_address_0 <= "00101";
    ptr_deref_65_word_address_1 <= "00110";
    ptr_deref_65_word_address_2 <= "00111";
    ptr_deref_65_word_address_3 <= "01000";
    ptr_deref_70_word_address_0 <= "00001";
    ptr_deref_70_word_address_1 <= "00010";
    ptr_deref_70_word_address_2 <= "00011";
    ptr_deref_70_word_address_3 <= "00100";
    ptr_deref_74_word_address_0 <= "00101";
    ptr_deref_74_word_address_1 <= "00110";
    ptr_deref_74_word_address_2 <= "00111";
    ptr_deref_74_word_address_3 <= "01000";
    ptr_deref_92_word_address_0 <= "00001";
    ptr_deref_92_word_address_1 <= "00010";
    ptr_deref_92_word_address_2 <= "00011";
    ptr_deref_92_word_address_3 <= "00100";
    simple_obj_ref_100_word_address_0 <= "0";
    simple_obj_ref_94_word_address_0 <= "0";
    xxbarxxbodyxxb_alloc_base_address <= "00101";
    xxbarxxbodyxxiNsTr_0_alloc_base_address <= "00001";
    xxbarxxstored_ret_val_x_xx_xbase_address <= "0";
    type_cast_62_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_61_wire, dout => iNsTr_3_63, req => type_cast_62_inst_req_0, ack => type_cast_62_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_88_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_7_80, dout => type_cast_88_wire, req => type_cast_88_inst_req_0, ack => type_cast_88_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_52_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_52_gather_scatter_ack_0 <= ptr_deref_52_gather_scatter_req_0;
      aggregated_sig <= a;
      ptr_deref_52_data_0 <= aggregated_sig(31 downto 24);
      ptr_deref_52_data_1 <= aggregated_sig(23 downto 16);
      ptr_deref_52_data_2 <= aggregated_sig(15 downto 8);
      ptr_deref_52_data_3 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_65_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_65_gather_scatter_ack_0 <= ptr_deref_65_gather_scatter_req_0;
      aggregated_sig <= iNsTr_3_63;
      ptr_deref_65_data_0 <= aggregated_sig(31 downto 24);
      ptr_deref_65_data_1 <= aggregated_sig(23 downto 16);
      ptr_deref_65_data_2 <= aggregated_sig(15 downto 8);
      ptr_deref_65_data_3 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_70_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_70_gather_scatter_ack_0 <= ptr_deref_70_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_70_data_0 & ptr_deref_70_data_1 & ptr_deref_70_data_2 & ptr_deref_70_data_3;
      iNsTr_5_71 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_74_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_74_gather_scatter_ack_0 <= ptr_deref_74_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_74_data_0 & ptr_deref_74_data_1 & ptr_deref_74_data_2 & ptr_deref_74_data_3;
      iNsTr_6_75 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_92_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_92_gather_scatter_ack_0 <= ptr_deref_92_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_92_data_0 & ptr_deref_92_data_1 & ptr_deref_92_data_2 & ptr_deref_92_data_3;
      iNsTr_10_93 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_100_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_100_gather_scatter_ack_0 <= simple_obj_ref_100_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_100_data_0;
      ret_val_x_x <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_94_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_94_gather_scatter_ack_0 <= simple_obj_ref_94_gather_scatter_req_0;
      aggregated_sig <= iNsTr_10_93;
      simple_obj_ref_94_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_79_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_71 & iNsTr_6_75;
      iNsTr_7_80 <= data_out(31 downto 0);
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
          reqL => binary_79_inst_req_0,
          ackL => binary_79_inst_ack_0,
          reqR => binary_79_inst_req_1,
          ackR => binary_79_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared load operator group (0) : ptr_deref_70_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_70_load_0_req_0;
      ptr_deref_70_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_70_load_0_req_1;
      ptr_deref_70_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_0;
      ptr_deref_70_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(11),
          mack => memory_space_0_lr_ack(11),
          maddr => memory_space_0_lr_addr(59 downto 55),
          mtag => memory_space_0_lr_tag(11 downto 11),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(11),
          mack => memory_space_0_lc_ack(11),
          mdata => memory_space_0_lc_data(95 downto 88),
          mtag => memory_space_0_lc_tag(11 downto 11),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_70_load_1 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_70_load_1_req_0;
      ptr_deref_70_load_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_70_load_1_req_1;
      ptr_deref_70_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_1;
      ptr_deref_70_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(10),
          mack => memory_space_0_lr_ack(10),
          maddr => memory_space_0_lr_addr(54 downto 50),
          mtag => memory_space_0_lr_tag(10 downto 10),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(10),
          mack => memory_space_0_lc_ack(10),
          mdata => memory_space_0_lc_data(87 downto 80),
          mtag => memory_space_0_lc_tag(10 downto 10),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : ptr_deref_70_load_2 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_70_load_2_req_0;
      ptr_deref_70_load_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_70_load_2_req_1;
      ptr_deref_70_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_2;
      ptr_deref_70_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(9),
          mack => memory_space_0_lr_ack(9),
          maddr => memory_space_0_lr_addr(49 downto 45),
          mtag => memory_space_0_lr_tag(9 downto 9),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(9),
          mack => memory_space_0_lc_ack(9),
          mdata => memory_space_0_lc_data(79 downto 72),
          mtag => memory_space_0_lc_tag(9 downto 9),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : ptr_deref_70_load_3 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_70_load_3_req_0;
      ptr_deref_70_load_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_70_load_3_req_1;
      ptr_deref_70_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_3;
      ptr_deref_70_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(8),
          mack => memory_space_0_lr_ack(8),
          maddr => memory_space_0_lr_addr(44 downto 40),
          mtag => memory_space_0_lr_tag(8 downto 8),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(8),
          mack => memory_space_0_lc_ack(8),
          mdata => memory_space_0_lc_data(71 downto 64),
          mtag => memory_space_0_lc_tag(8 downto 8),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 3
    -- shared load operator group (4) : ptr_deref_74_load_0 
    LoadGroup4: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_74_load_0_req_0;
      ptr_deref_74_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_74_load_0_req_1;
      ptr_deref_74_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_74_word_address_0;
      ptr_deref_74_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(7),
          mack => memory_space_0_lr_ack(7),
          maddr => memory_space_0_lr_addr(39 downto 35),
          mtag => memory_space_0_lr_tag(7 downto 7),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(7),
          mack => memory_space_0_lc_ack(7),
          mdata => memory_space_0_lc_data(63 downto 56),
          mtag => memory_space_0_lc_tag(7 downto 7),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 4
    -- shared load operator group (5) : ptr_deref_74_load_1 
    LoadGroup5: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_74_load_1_req_0;
      ptr_deref_74_load_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_74_load_1_req_1;
      ptr_deref_74_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_74_word_address_1;
      ptr_deref_74_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(6),
          mack => memory_space_0_lr_ack(6),
          maddr => memory_space_0_lr_addr(34 downto 30),
          mtag => memory_space_0_lr_tag(6 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(6),
          mack => memory_space_0_lc_ack(6),
          mdata => memory_space_0_lc_data(55 downto 48),
          mtag => memory_space_0_lc_tag(6 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 5
    -- shared load operator group (6) : ptr_deref_74_load_2 
    LoadGroup6: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_74_load_2_req_0;
      ptr_deref_74_load_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_74_load_2_req_1;
      ptr_deref_74_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_74_word_address_2;
      ptr_deref_74_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(5),
          mack => memory_space_0_lr_ack(5),
          maddr => memory_space_0_lr_addr(29 downto 25),
          mtag => memory_space_0_lr_tag(5 downto 5),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(5),
          mack => memory_space_0_lc_ack(5),
          mdata => memory_space_0_lc_data(47 downto 40),
          mtag => memory_space_0_lc_tag(5 downto 5),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 6
    -- shared load operator group (7) : ptr_deref_74_load_3 
    LoadGroup7: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_74_load_3_req_0;
      ptr_deref_74_load_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_74_load_3_req_1;
      ptr_deref_74_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_74_word_address_3;
      ptr_deref_74_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(4),
          mack => memory_space_0_lr_ack(4),
          maddr => memory_space_0_lr_addr(24 downto 20),
          mtag => memory_space_0_lr_tag(4 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(4),
          mack => memory_space_0_lc_ack(4),
          mdata => memory_space_0_lc_data(39 downto 32),
          mtag => memory_space_0_lc_tag(4 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 7
    -- shared load operator group (8) : ptr_deref_92_load_0 
    LoadGroup8: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_92_load_0_req_0;
      ptr_deref_92_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_92_load_0_req_1;
      ptr_deref_92_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_92_word_address_0;
      ptr_deref_92_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(3),
          mack => memory_space_0_lr_ack(3),
          maddr => memory_space_0_lr_addr(19 downto 15),
          mtag => memory_space_0_lr_tag(3 downto 3),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(3),
          mack => memory_space_0_lc_ack(3),
          mdata => memory_space_0_lc_data(31 downto 24),
          mtag => memory_space_0_lc_tag(3 downto 3),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 8
    -- shared load operator group (9) : ptr_deref_92_load_1 
    LoadGroup9: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_92_load_1_req_0;
      ptr_deref_92_load_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_92_load_1_req_1;
      ptr_deref_92_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_92_word_address_1;
      ptr_deref_92_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(2),
          mack => memory_space_0_lr_ack(2),
          maddr => memory_space_0_lr_addr(14 downto 10),
          mtag => memory_space_0_lr_tag(2 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(2),
          mack => memory_space_0_lc_ack(2),
          mdata => memory_space_0_lc_data(23 downto 16),
          mtag => memory_space_0_lc_tag(2 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 9
    -- shared load operator group (10) : ptr_deref_92_load_2 
    LoadGroup10: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_92_load_2_req_0;
      ptr_deref_92_load_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_92_load_2_req_1;
      ptr_deref_92_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_92_word_address_2;
      ptr_deref_92_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(1),
          mack => memory_space_0_lr_ack(1),
          maddr => memory_space_0_lr_addr(9 downto 5),
          mtag => memory_space_0_lr_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(1),
          mack => memory_space_0_lc_ack(1),
          mdata => memory_space_0_lc_data(15 downto 8),
          mtag => memory_space_0_lc_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 10
    -- shared load operator group (11) : ptr_deref_92_load_3 
    LoadGroup11: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_92_load_3_req_0;
      ptr_deref_92_load_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_92_load_3_req_1;
      ptr_deref_92_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_92_word_address_3;
      ptr_deref_92_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(4 downto 0),
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
    end Block; -- load group 11
    -- shared load operator group (12) : simple_obj_ref_100_load_0 
    LoadGroup12: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_100_load_0_req_0;
      simple_obj_ref_100_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_100_load_0_req_1;
      simple_obj_ref_100_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_100_word_address_0;
      simple_obj_ref_100_data_0 <= data_out(31 downto 0);
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
    end Block; -- load group 12
    -- shared store operator group (0) : ptr_deref_52_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_52_store_0_req_0;
      ptr_deref_52_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_52_store_0_req_1;
      ptr_deref_52_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_0;
      data_in <= ptr_deref_52_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(7),
          mack => memory_space_0_sr_ack(7),
          maddr => memory_space_0_sr_addr(39 downto 35),
          mdata => memory_space_0_sr_data(63 downto 56),
          mtag => memory_space_0_sr_tag(7 downto 7),
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
          mreq => memory_space_0_sc_req(7),
          mack => memory_space_0_sc_ack(7),
          mtag => memory_space_0_sc_tag(7 downto 7),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_52_store_1 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_52_store_1_req_0;
      ptr_deref_52_store_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_52_store_1_req_1;
      ptr_deref_52_store_1_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_1;
      data_in <= ptr_deref_52_data_1;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(6),
          mack => memory_space_0_sr_ack(6),
          maddr => memory_space_0_sr_addr(34 downto 30),
          mdata => memory_space_0_sr_data(55 downto 48),
          mtag => memory_space_0_sr_tag(6 downto 6),
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
          mreq => memory_space_0_sc_req(6),
          mack => memory_space_0_sc_ack(6),
          mtag => memory_space_0_sc_tag(6 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : ptr_deref_52_store_2 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_52_store_2_req_0;
      ptr_deref_52_store_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_52_store_2_req_1;
      ptr_deref_52_store_2_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_2;
      data_in <= ptr_deref_52_data_2;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(5),
          mack => memory_space_0_sr_ack(5),
          maddr => memory_space_0_sr_addr(29 downto 25),
          mdata => memory_space_0_sr_data(47 downto 40),
          mtag => memory_space_0_sr_tag(5 downto 5),
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
          mreq => memory_space_0_sc_req(5),
          mack => memory_space_0_sc_ack(5),
          mtag => memory_space_0_sc_tag(5 downto 5),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared store operator group (3) : ptr_deref_52_store_3 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_52_store_3_req_0;
      ptr_deref_52_store_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_52_store_3_req_1;
      ptr_deref_52_store_3_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_3;
      data_in <= ptr_deref_52_data_3;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(4),
          mack => memory_space_0_sr_ack(4),
          maddr => memory_space_0_sr_addr(24 downto 20),
          mdata => memory_space_0_sr_data(39 downto 32),
          mtag => memory_space_0_sr_tag(4 downto 4),
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
          mreq => memory_space_0_sc_req(4),
          mack => memory_space_0_sc_ack(4),
          mtag => memory_space_0_sc_tag(4 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 3
    -- shared store operator group (4) : ptr_deref_65_store_0 
    StoreGroup4: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_65_store_0_req_0;
      ptr_deref_65_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_65_store_0_req_1;
      ptr_deref_65_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_65_word_address_0;
      data_in <= ptr_deref_65_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(3),
          mack => memory_space_0_sr_ack(3),
          maddr => memory_space_0_sr_addr(19 downto 15),
          mdata => memory_space_0_sr_data(31 downto 24),
          mtag => memory_space_0_sr_tag(3 downto 3),
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
          mreq => memory_space_0_sc_req(3),
          mack => memory_space_0_sc_ack(3),
          mtag => memory_space_0_sc_tag(3 downto 3),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 4
    -- shared store operator group (5) : ptr_deref_65_store_1 
    StoreGroup5: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_65_store_1_req_0;
      ptr_deref_65_store_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_65_store_1_req_1;
      ptr_deref_65_store_1_ack_1 <= ackR(0);
      addr_in <= ptr_deref_65_word_address_1;
      data_in <= ptr_deref_65_data_1;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(2),
          mack => memory_space_0_sr_ack(2),
          maddr => memory_space_0_sr_addr(14 downto 10),
          mdata => memory_space_0_sr_data(23 downto 16),
          mtag => memory_space_0_sr_tag(2 downto 2),
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
          mreq => memory_space_0_sc_req(2),
          mack => memory_space_0_sc_ack(2),
          mtag => memory_space_0_sc_tag(2 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 5
    -- shared store operator group (6) : ptr_deref_65_store_2 
    StoreGroup6: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_65_store_2_req_0;
      ptr_deref_65_store_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_65_store_2_req_1;
      ptr_deref_65_store_2_ack_1 <= ackR(0);
      addr_in <= ptr_deref_65_word_address_2;
      data_in <= ptr_deref_65_data_2;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(1),
          mack => memory_space_0_sr_ack(1),
          maddr => memory_space_0_sr_addr(9 downto 5),
          mdata => memory_space_0_sr_data(15 downto 8),
          mtag => memory_space_0_sr_tag(1 downto 1),
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
          mreq => memory_space_0_sc_req(1),
          mack => memory_space_0_sc_ack(1),
          mtag => memory_space_0_sc_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 6
    -- shared store operator group (7) : ptr_deref_65_store_3 
    StoreGroup7: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_65_store_3_req_0;
      ptr_deref_65_store_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_65_store_3_req_1;
      ptr_deref_65_store_3_ack_1 <= ackR(0);
      addr_in <= ptr_deref_65_word_address_3;
      data_in <= ptr_deref_65_data_3;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
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
          maddr => memory_space_0_sr_addr(4 downto 0),
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
    end Block; -- store group 7
    -- shared store operator group (8) : simple_obj_ref_94_store_0 
    StoreGroup8: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_94_store_0_req_0;
      simple_obj_ref_94_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_94_store_0_req_1;
      simple_obj_ref_94_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_94_word_address_0;
      data_in <= simple_obj_ref_94_data_0;
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
    end Block; -- store group 8
    -- shared inport operator group (0) : simple_obj_ref_61_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_61_inst_req_0;
      simple_obj_ref_61_inst_ack_0 <= ack(0);
      simple_obj_ref_61_wire <= data_out(31 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_86_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_86_inst_req_0;
      simple_obj_ref_86_inst_ack_0 <= ack(0);
      data_in <= type_cast_88_wire;
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
  port ( -- 
    a : in  std_logic_vector(31 downto 0);
    ret_val_x_x : out  std_logic_vector(31 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    memory_space_0_lr_req : out  std_logic_vector(11 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(11 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(59 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(11 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(11 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(11 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(95 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(11 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(7 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(7 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(39 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(63 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(7 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(7 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(7 downto 0);
    inpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
    inpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
    inpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
    midpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
    midpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
    midpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity foo;
architecture Default of foo is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal ptr_deref_160_load_3_req_1 : boolean;
  signal ptr_deref_160_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_162_store_0_ack_0 : boolean;
  signal simple_obj_ref_162_store_0_req_0 : boolean;
  signal ptr_deref_160_gather_scatter_req_0 : boolean;
  signal ptr_deref_160_load_3_ack_1 : boolean;
  signal ptr_deref_160_load_3_ack_0 : boolean;
  signal simple_obj_ref_168_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_168_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_168_load_0_ack_1 : boolean;
  signal simple_obj_ref_168_load_0_req_1 : boolean;
  signal ptr_deref_160_load_2_ack_1 : boolean;
  signal ptr_deref_160_load_2_req_1 : boolean;
  signal simple_obj_ref_162_gather_scatter_ack_0 : boolean;
  signal ptr_deref_160_load_1_ack_1 : boolean;
  signal ptr_deref_160_load_1_req_1 : boolean;
  signal simple_obj_ref_168_load_0_ack_0 : boolean;
  signal simple_obj_ref_162_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_168_load_0_req_0 : boolean;
  signal simple_obj_ref_162_store_0_ack_1 : boolean;
  signal ptr_deref_160_load_0_ack_1 : boolean;
  signal ptr_deref_160_load_0_req_1 : boolean;
  signal simple_obj_ref_162_store_0_req_1 : boolean;
  signal ptr_deref_160_load_3_req_0 : boolean;
  signal ptr_deref_160_load_2_ack_0 : boolean;
  signal ptr_deref_160_load_2_req_0 : boolean;
  signal ptr_deref_160_load_1_ack_0 : boolean;
  signal ptr_deref_160_load_1_req_0 : boolean;
  signal ptr_deref_160_load_0_ack_0 : boolean;
  signal ptr_deref_160_load_0_req_0 : boolean;
  signal ptr_deref_120_gather_scatter_req_0 : boolean;
  signal ptr_deref_120_gather_scatter_ack_0 : boolean;
  signal ptr_deref_120_store_0_req_0 : boolean;
  signal ptr_deref_120_store_0_ack_0 : boolean;
  signal ptr_deref_120_store_1_req_0 : boolean;
  signal ptr_deref_120_store_1_ack_0 : boolean;
  signal ptr_deref_120_store_2_req_0 : boolean;
  signal ptr_deref_120_store_2_ack_0 : boolean;
  signal ptr_deref_120_store_3_req_0 : boolean;
  signal ptr_deref_120_store_3_ack_0 : boolean;
  signal ptr_deref_120_store_0_req_1 : boolean;
  signal ptr_deref_120_store_0_ack_1 : boolean;
  signal ptr_deref_120_store_1_req_1 : boolean;
  signal ptr_deref_120_store_1_ack_1 : boolean;
  signal ptr_deref_120_store_2_req_1 : boolean;
  signal ptr_deref_120_store_2_ack_1 : boolean;
  signal ptr_deref_120_store_3_req_1 : boolean;
  signal ptr_deref_120_store_3_ack_1 : boolean;
  signal simple_obj_ref_129_inst_req_0 : boolean;
  signal simple_obj_ref_129_inst_ack_0 : boolean;
  signal type_cast_130_inst_req_0 : boolean;
  signal type_cast_130_inst_ack_0 : boolean;
  signal ptr_deref_133_gather_scatter_req_0 : boolean;
  signal ptr_deref_133_gather_scatter_ack_0 : boolean;
  signal ptr_deref_133_store_0_req_0 : boolean;
  signal ptr_deref_133_store_0_ack_0 : boolean;
  signal ptr_deref_133_store_1_req_0 : boolean;
  signal ptr_deref_133_store_1_ack_0 : boolean;
  signal ptr_deref_133_store_2_req_0 : boolean;
  signal ptr_deref_133_store_2_ack_0 : boolean;
  signal ptr_deref_133_store_3_req_0 : boolean;
  signal ptr_deref_133_store_3_ack_0 : boolean;
  signal ptr_deref_133_store_0_req_1 : boolean;
  signal ptr_deref_133_store_0_ack_1 : boolean;
  signal ptr_deref_133_store_1_req_1 : boolean;
  signal ptr_deref_133_store_1_ack_1 : boolean;
  signal ptr_deref_133_store_2_req_1 : boolean;
  signal ptr_deref_133_store_2_ack_1 : boolean;
  signal ptr_deref_133_store_3_req_1 : boolean;
  signal ptr_deref_133_store_3_ack_1 : boolean;
  signal ptr_deref_138_load_0_req_0 : boolean;
  signal ptr_deref_138_load_0_ack_0 : boolean;
  signal ptr_deref_138_load_1_req_0 : boolean;
  signal ptr_deref_138_load_1_ack_0 : boolean;
  signal ptr_deref_138_load_2_req_0 : boolean;
  signal ptr_deref_138_load_2_ack_0 : boolean;
  signal ptr_deref_138_load_3_req_0 : boolean;
  signal ptr_deref_138_load_3_ack_0 : boolean;
  signal ptr_deref_138_load_0_req_1 : boolean;
  signal ptr_deref_138_load_0_ack_1 : boolean;
  signal ptr_deref_138_load_1_req_1 : boolean;
  signal ptr_deref_138_load_1_ack_1 : boolean;
  signal ptr_deref_138_load_2_req_1 : boolean;
  signal ptr_deref_138_load_2_ack_1 : boolean;
  signal ptr_deref_138_load_3_req_1 : boolean;
  signal ptr_deref_138_load_3_ack_1 : boolean;
  signal ptr_deref_138_gather_scatter_req_0 : boolean;
  signal ptr_deref_138_gather_scatter_ack_0 : boolean;
  signal ptr_deref_142_load_0_req_0 : boolean;
  signal ptr_deref_142_load_0_ack_0 : boolean;
  signal ptr_deref_142_load_1_req_0 : boolean;
  signal ptr_deref_142_load_1_ack_0 : boolean;
  signal ptr_deref_142_load_2_req_0 : boolean;
  signal ptr_deref_142_load_2_ack_0 : boolean;
  signal ptr_deref_142_load_3_req_0 : boolean;
  signal ptr_deref_142_load_3_ack_0 : boolean;
  signal ptr_deref_142_load_0_req_1 : boolean;
  signal ptr_deref_142_load_0_ack_1 : boolean;
  signal ptr_deref_142_load_1_req_1 : boolean;
  signal ptr_deref_142_load_1_ack_1 : boolean;
  signal ptr_deref_142_load_2_req_1 : boolean;
  signal ptr_deref_142_load_2_ack_1 : boolean;
  signal ptr_deref_142_load_3_req_1 : boolean;
  signal ptr_deref_142_load_3_ack_1 : boolean;
  signal ptr_deref_142_gather_scatter_req_0 : boolean;
  signal ptr_deref_142_gather_scatter_ack_0 : boolean;
  signal binary_147_inst_req_0 : boolean;
  signal binary_147_inst_ack_0 : boolean;
  signal binary_147_inst_req_1 : boolean;
  signal binary_147_inst_ack_1 : boolean;
  signal type_cast_156_inst_req_0 : boolean;
  signal type_cast_156_inst_ack_0 : boolean;
  signal simple_obj_ref_154_inst_req_0 : boolean;
  signal simple_obj_ref_154_inst_ack_0 : boolean;
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
  foo_CP_440: Block -- control-path 
    signal foo_CP_440_start: Boolean;
    signal Xentry_441_symbol: Boolean;
    signal Xexit_442_symbol: Boolean;
    signal branch_block_stmt_108_443_symbol : Boolean;
    -- 
  begin -- 
    foo_CP_440_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_441_symbol  <= foo_CP_440_start; -- transition $entry
    branch_block_stmt_108_443: Block -- branch_block_stmt_108 
      signal branch_block_stmt_108_443_start: Boolean;
      signal Xentry_444_symbol: Boolean;
      signal Xexit_445_symbol: Boolean;
      signal branch_block_stmt_108_x_xentry_x_xx_x446_symbol : Boolean;
      signal branch_block_stmt_108_x_xexit_x_xx_x447_symbol : Boolean;
      signal assign_stmt_114_to_assign_stmt_164_x_xentry_x_xx_x448_symbol : Boolean;
      signal assign_stmt_114_to_assign_stmt_164_x_xexit_x_xx_x449_symbol : Boolean;
      signal return_x_xx_x450_symbol : Boolean;
      signal merge_stmt_166_x_xexit_x_xx_x451_symbol : Boolean;
      signal assign_stmt_169_x_xentry_x_xx_x452_symbol : Boolean;
      signal assign_stmt_169_x_xexit_x_xx_x453_symbol : Boolean;
      signal assign_stmt_114_to_assign_stmt_164_454_symbol : Boolean;
      signal assign_stmt_169_839_symbol : Boolean;
      signal return_x_xx_xPhiReq_872_symbol : Boolean;
      signal merge_stmt_166_PhiReqMerge_875_symbol : Boolean;
      signal merge_stmt_166_PhiAck_876_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_108_443_start <= Xentry_441_symbol; -- control passed to block
      Xentry_444_symbol  <= branch_block_stmt_108_443_start; -- transition branch_block_stmt_108/$entry
      branch_block_stmt_108_x_xentry_x_xx_x446_symbol  <=  Xentry_444_symbol; -- place branch_block_stmt_108/branch_block_stmt_108__entry__ (optimized away) 
      branch_block_stmt_108_x_xexit_x_xx_x447_symbol  <=  assign_stmt_169_x_xexit_x_xx_x453_symbol; -- place branch_block_stmt_108/branch_block_stmt_108__exit__ (optimized away) 
      assign_stmt_114_to_assign_stmt_164_x_xentry_x_xx_x448_symbol  <=  branch_block_stmt_108_x_xentry_x_xx_x446_symbol; -- place branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164__entry__ (optimized away) 
      assign_stmt_114_to_assign_stmt_164_x_xexit_x_xx_x449_symbol  <=  assign_stmt_114_to_assign_stmt_164_454_symbol; -- place branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164__exit__ (optimized away) 
      return_x_xx_x450_symbol  <=  assign_stmt_114_to_assign_stmt_164_x_xexit_x_xx_x449_symbol; -- place branch_block_stmt_108/return__ (optimized away) 
      merge_stmt_166_x_xexit_x_xx_x451_symbol  <=  merge_stmt_166_PhiAck_876_symbol; -- place branch_block_stmt_108/merge_stmt_166__exit__ (optimized away) 
      assign_stmt_169_x_xentry_x_xx_x452_symbol  <=  merge_stmt_166_x_xexit_x_xx_x451_symbol; -- place branch_block_stmt_108/assign_stmt_169__entry__ (optimized away) 
      assign_stmt_169_x_xexit_x_xx_x453_symbol  <=  assign_stmt_169_839_symbol; -- place branch_block_stmt_108/assign_stmt_169__exit__ (optimized away) 
      assign_stmt_114_to_assign_stmt_164_454: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164 
        signal assign_stmt_114_to_assign_stmt_164_454_start: Boolean;
        signal Xentry_455_symbol: Boolean;
        signal Xexit_456_symbol: Boolean;
        signal assign_stmt_122_active_x_x457_symbol : Boolean;
        signal assign_stmt_122_completed_x_x458_symbol : Boolean;
        signal simple_obj_ref_121_complete_459_symbol : Boolean;
        signal ptr_deref_120_trigger_x_x460_symbol : Boolean;
        signal ptr_deref_120_active_x_x461_symbol : Boolean;
        signal ptr_deref_120_base_address_calculated_462_symbol : Boolean;
        signal ptr_deref_120_root_address_calculated_463_symbol : Boolean;
        signal ptr_deref_120_word_address_calculated_464_symbol : Boolean;
        signal ptr_deref_120_request_465_symbol : Boolean;
        signal ptr_deref_120_complete_493_symbol : Boolean;
        signal assign_stmt_131_active_x_x519_symbol : Boolean;
        signal assign_stmt_131_completed_x_x520_symbol : Boolean;
        signal type_cast_130_active_x_x521_symbol : Boolean;
        signal type_cast_130_trigger_x_x522_symbol : Boolean;
        signal simple_obj_ref_129_trigger_x_x523_symbol : Boolean;
        signal simple_obj_ref_129_complete_524_symbol : Boolean;
        signal type_cast_130_complete_529_symbol : Boolean;
        signal assign_stmt_135_active_x_x534_symbol : Boolean;
        signal assign_stmt_135_completed_x_x535_symbol : Boolean;
        signal simple_obj_ref_134_complete_536_symbol : Boolean;
        signal ptr_deref_133_trigger_x_x537_symbol : Boolean;
        signal ptr_deref_133_active_x_x538_symbol : Boolean;
        signal ptr_deref_133_base_address_calculated_539_symbol : Boolean;
        signal ptr_deref_133_root_address_calculated_540_symbol : Boolean;
        signal ptr_deref_133_word_address_calculated_541_symbol : Boolean;
        signal ptr_deref_133_request_542_symbol : Boolean;
        signal ptr_deref_133_complete_570_symbol : Boolean;
        signal assign_stmt_139_active_x_x596_symbol : Boolean;
        signal assign_stmt_139_completed_x_x597_symbol : Boolean;
        signal ptr_deref_138_trigger_x_x598_symbol : Boolean;
        signal ptr_deref_138_active_x_x599_symbol : Boolean;
        signal ptr_deref_138_base_address_calculated_600_symbol : Boolean;
        signal ptr_deref_138_root_address_calculated_601_symbol : Boolean;
        signal ptr_deref_138_word_address_calculated_602_symbol : Boolean;
        signal ptr_deref_138_request_603_symbol : Boolean;
        signal ptr_deref_138_complete_629_symbol : Boolean;
        signal assign_stmt_143_active_x_x657_symbol : Boolean;
        signal assign_stmt_143_completed_x_x658_symbol : Boolean;
        signal ptr_deref_142_trigger_x_x659_symbol : Boolean;
        signal ptr_deref_142_active_x_x660_symbol : Boolean;
        signal ptr_deref_142_base_address_calculated_661_symbol : Boolean;
        signal ptr_deref_142_root_address_calculated_662_symbol : Boolean;
        signal ptr_deref_142_word_address_calculated_663_symbol : Boolean;
        signal ptr_deref_142_request_664_symbol : Boolean;
        signal ptr_deref_142_complete_690_symbol : Boolean;
        signal assign_stmt_148_active_x_x718_symbol : Boolean;
        signal assign_stmt_148_completed_x_x719_symbol : Boolean;
        signal binary_147_active_x_x720_symbol : Boolean;
        signal binary_147_trigger_x_x721_symbol : Boolean;
        signal simple_obj_ref_145_complete_722_symbol : Boolean;
        signal simple_obj_ref_146_complete_723_symbol : Boolean;
        signal binary_147_complete_724_symbol : Boolean;
        signal assign_stmt_157_active_x_x731_symbol : Boolean;
        signal assign_stmt_157_completed_x_x732_symbol : Boolean;
        signal type_cast_156_active_x_x733_symbol : Boolean;
        signal type_cast_156_trigger_x_x734_symbol : Boolean;
        signal simple_obj_ref_155_complete_735_symbol : Boolean;
        signal type_cast_156_complete_736_symbol : Boolean;
        signal simple_obj_ref_154_trigger_x_x741_symbol : Boolean;
        signal simple_obj_ref_154_complete_742_symbol : Boolean;
        signal assign_stmt_161_active_x_x747_symbol : Boolean;
        signal assign_stmt_161_completed_x_x748_symbol : Boolean;
        signal ptr_deref_160_trigger_x_x749_symbol : Boolean;
        signal ptr_deref_160_active_x_x750_symbol : Boolean;
        signal ptr_deref_160_base_address_calculated_751_symbol : Boolean;
        signal ptr_deref_160_root_address_calculated_752_symbol : Boolean;
        signal ptr_deref_160_word_address_calculated_753_symbol : Boolean;
        signal ptr_deref_160_request_754_symbol : Boolean;
        signal ptr_deref_160_complete_780_symbol : Boolean;
        signal assign_stmt_164_active_x_x808_symbol : Boolean;
        signal assign_stmt_164_completed_x_x809_symbol : Boolean;
        signal simple_obj_ref_163_complete_810_symbol : Boolean;
        signal simple_obj_ref_162_trigger_x_x811_symbol : Boolean;
        signal simple_obj_ref_162_active_x_x812_symbol : Boolean;
        signal simple_obj_ref_162_root_address_calculated_813_symbol : Boolean;
        signal simple_obj_ref_162_word_address_calculated_814_symbol : Boolean;
        signal simple_obj_ref_162_request_815_symbol : Boolean;
        signal simple_obj_ref_162_complete_828_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_114_to_assign_stmt_164_454_start <= assign_stmt_114_to_assign_stmt_164_x_xentry_x_xx_x448_symbol; -- control passed to block
        Xentry_455_symbol  <= assign_stmt_114_to_assign_stmt_164_454_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/$entry
        assign_stmt_122_active_x_x457_symbol <= simple_obj_ref_121_complete_459_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_122_active_
        assign_stmt_122_completed_x_x458_symbol <= ptr_deref_120_complete_493_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_122_completed_
        simple_obj_ref_121_complete_459_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_121_complete
        ptr_deref_120_trigger_x_x460_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_trigger_ 
          signal ptr_deref_120_trigger_x_x460_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_120_trigger_x_x460_predecessors(0) <= ptr_deref_120_word_address_calculated_464_symbol;
          ptr_deref_120_trigger_x_x460_predecessors(1) <= assign_stmt_122_active_x_x457_symbol;
          ptr_deref_120_trigger_x_x460_join: join -- 
            port map( -- 
              preds => ptr_deref_120_trigger_x_x460_predecessors,
              symbol_out => ptr_deref_120_trigger_x_x460_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_trigger_
        ptr_deref_120_active_x_x461_symbol <= ptr_deref_120_request_465_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_active_
        ptr_deref_120_base_address_calculated_462_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_base_address_calculated
        ptr_deref_120_root_address_calculated_463_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_root_address_calculated
        ptr_deref_120_word_address_calculated_464_symbol <= ptr_deref_120_root_address_calculated_463_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_word_address_calculated
        ptr_deref_120_request_465: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request 
          signal ptr_deref_120_request_465_start: Boolean;
          signal Xentry_466_symbol: Boolean;
          signal Xexit_467_symbol: Boolean;
          signal split_req_468_symbol : Boolean;
          signal split_ack_469_symbol : Boolean;
          signal word_access_470_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_120_request_465_start <= ptr_deref_120_trigger_x_x460_symbol; -- control passed to block
          Xentry_466_symbol  <= ptr_deref_120_request_465_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/$entry
          split_req_468_symbol <= Xentry_466_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/split_req
          ptr_deref_120_gather_scatter_req_0 <= split_req_468_symbol; -- link to DP
          split_ack_469_symbol <= ptr_deref_120_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/split_ack
          word_access_470: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access 
            signal word_access_470_start: Boolean;
            signal Xentry_471_symbol: Boolean;
            signal Xexit_472_symbol: Boolean;
            signal word_access_0_473_symbol : Boolean;
            signal word_access_1_478_symbol : Boolean;
            signal word_access_2_483_symbol : Boolean;
            signal word_access_3_488_symbol : Boolean;
            -- 
          begin -- 
            word_access_470_start <= split_ack_469_symbol; -- control passed to block
            Xentry_471_symbol  <= word_access_470_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/$entry
            word_access_0_473: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_0 
              signal word_access_0_473_start: Boolean;
              signal Xentry_474_symbol: Boolean;
              signal Xexit_475_symbol: Boolean;
              signal rr_476_symbol : Boolean;
              signal ra_477_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_473_start <= Xentry_471_symbol; -- control passed to block
              Xentry_474_symbol  <= word_access_0_473_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_0/$entry
              rr_476_symbol <= Xentry_474_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_0/rr
              ptr_deref_120_store_0_req_0 <= rr_476_symbol; -- link to DP
              ra_477_symbol <= ptr_deref_120_store_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_0/ra
              Xexit_475_symbol <= ra_477_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_0/$exit
              word_access_0_473_symbol <= Xexit_475_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_0
            word_access_1_478: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_1 
              signal word_access_1_478_start: Boolean;
              signal Xentry_479_symbol: Boolean;
              signal Xexit_480_symbol: Boolean;
              signal rr_481_symbol : Boolean;
              signal ra_482_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_478_start <= Xentry_471_symbol; -- control passed to block
              Xentry_479_symbol  <= word_access_1_478_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_1/$entry
              rr_481_symbol <= Xentry_479_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_1/rr
              ptr_deref_120_store_1_req_0 <= rr_481_symbol; -- link to DP
              ra_482_symbol <= ptr_deref_120_store_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_1/ra
              Xexit_480_symbol <= ra_482_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_1/$exit
              word_access_1_478_symbol <= Xexit_480_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_1
            word_access_2_483: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_2 
              signal word_access_2_483_start: Boolean;
              signal Xentry_484_symbol: Boolean;
              signal Xexit_485_symbol: Boolean;
              signal rr_486_symbol : Boolean;
              signal ra_487_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_483_start <= Xentry_471_symbol; -- control passed to block
              Xentry_484_symbol  <= word_access_2_483_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_2/$entry
              rr_486_symbol <= Xentry_484_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_2/rr
              ptr_deref_120_store_2_req_0 <= rr_486_symbol; -- link to DP
              ra_487_symbol <= ptr_deref_120_store_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_2/ra
              Xexit_485_symbol <= ra_487_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_2/$exit
              word_access_2_483_symbol <= Xexit_485_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_2
            word_access_3_488: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_3 
              signal word_access_3_488_start: Boolean;
              signal Xentry_489_symbol: Boolean;
              signal Xexit_490_symbol: Boolean;
              signal rr_491_symbol : Boolean;
              signal ra_492_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_488_start <= Xentry_471_symbol; -- control passed to block
              Xentry_489_symbol  <= word_access_3_488_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_3/$entry
              rr_491_symbol <= Xentry_489_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_3/rr
              ptr_deref_120_store_3_req_0 <= rr_491_symbol; -- link to DP
              ra_492_symbol <= ptr_deref_120_store_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_3/ra
              Xexit_490_symbol <= ra_492_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_3/$exit
              word_access_3_488_symbol <= Xexit_490_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/word_access_3
            Xexit_472_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/$exit 
              signal Xexit_472_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_472_predecessors(0) <= word_access_0_473_symbol;
              Xexit_472_predecessors(1) <= word_access_1_478_symbol;
              Xexit_472_predecessors(2) <= word_access_2_483_symbol;
              Xexit_472_predecessors(3) <= word_access_3_488_symbol;
              Xexit_472_join: join -- 
                port map( -- 
                  preds => Xexit_472_predecessors,
                  symbol_out => Xexit_472_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access/$exit
            word_access_470_symbol <= Xexit_472_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/word_access
          Xexit_467_symbol <= word_access_470_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request/$exit
          ptr_deref_120_request_465_symbol <= Xexit_467_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_request
        ptr_deref_120_complete_493: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete 
          signal ptr_deref_120_complete_493_start: Boolean;
          signal Xentry_494_symbol: Boolean;
          signal Xexit_495_symbol: Boolean;
          signal word_access_496_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_120_complete_493_start <= ptr_deref_120_active_x_x461_symbol; -- control passed to block
          Xentry_494_symbol  <= ptr_deref_120_complete_493_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/$entry
          word_access_496: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access 
            signal word_access_496_start: Boolean;
            signal Xentry_497_symbol: Boolean;
            signal Xexit_498_symbol: Boolean;
            signal word_access_0_499_symbol : Boolean;
            signal word_access_1_504_symbol : Boolean;
            signal word_access_2_509_symbol : Boolean;
            signal word_access_3_514_symbol : Boolean;
            -- 
          begin -- 
            word_access_496_start <= Xentry_494_symbol; -- control passed to block
            Xentry_497_symbol  <= word_access_496_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/$entry
            word_access_0_499: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_0 
              signal word_access_0_499_start: Boolean;
              signal Xentry_500_symbol: Boolean;
              signal Xexit_501_symbol: Boolean;
              signal cr_502_symbol : Boolean;
              signal ca_503_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_499_start <= Xentry_497_symbol; -- control passed to block
              Xentry_500_symbol  <= word_access_0_499_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_0/$entry
              cr_502_symbol <= Xentry_500_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_0/cr
              ptr_deref_120_store_0_req_1 <= cr_502_symbol; -- link to DP
              ca_503_symbol <= ptr_deref_120_store_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_0/ca
              Xexit_501_symbol <= ca_503_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_0/$exit
              word_access_0_499_symbol <= Xexit_501_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_0
            word_access_1_504: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_1 
              signal word_access_1_504_start: Boolean;
              signal Xentry_505_symbol: Boolean;
              signal Xexit_506_symbol: Boolean;
              signal cr_507_symbol : Boolean;
              signal ca_508_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_504_start <= Xentry_497_symbol; -- control passed to block
              Xentry_505_symbol  <= word_access_1_504_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_1/$entry
              cr_507_symbol <= Xentry_505_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_1/cr
              ptr_deref_120_store_1_req_1 <= cr_507_symbol; -- link to DP
              ca_508_symbol <= ptr_deref_120_store_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_1/ca
              Xexit_506_symbol <= ca_508_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_1/$exit
              word_access_1_504_symbol <= Xexit_506_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_1
            word_access_2_509: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_2 
              signal word_access_2_509_start: Boolean;
              signal Xentry_510_symbol: Boolean;
              signal Xexit_511_symbol: Boolean;
              signal cr_512_symbol : Boolean;
              signal ca_513_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_509_start <= Xentry_497_symbol; -- control passed to block
              Xentry_510_symbol  <= word_access_2_509_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_2/$entry
              cr_512_symbol <= Xentry_510_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_2/cr
              ptr_deref_120_store_2_req_1 <= cr_512_symbol; -- link to DP
              ca_513_symbol <= ptr_deref_120_store_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_2/ca
              Xexit_511_symbol <= ca_513_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_2/$exit
              word_access_2_509_symbol <= Xexit_511_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_2
            word_access_3_514: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_3 
              signal word_access_3_514_start: Boolean;
              signal Xentry_515_symbol: Boolean;
              signal Xexit_516_symbol: Boolean;
              signal cr_517_symbol : Boolean;
              signal ca_518_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_514_start <= Xentry_497_symbol; -- control passed to block
              Xentry_515_symbol  <= word_access_3_514_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_3/$entry
              cr_517_symbol <= Xentry_515_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_3/cr
              ptr_deref_120_store_3_req_1 <= cr_517_symbol; -- link to DP
              ca_518_symbol <= ptr_deref_120_store_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_3/ca
              Xexit_516_symbol <= ca_518_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_3/$exit
              word_access_3_514_symbol <= Xexit_516_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/word_access_3
            Xexit_498_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/$exit 
              signal Xexit_498_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_498_predecessors(0) <= word_access_0_499_symbol;
              Xexit_498_predecessors(1) <= word_access_1_504_symbol;
              Xexit_498_predecessors(2) <= word_access_2_509_symbol;
              Xexit_498_predecessors(3) <= word_access_3_514_symbol;
              Xexit_498_join: join -- 
                port map( -- 
                  preds => Xexit_498_predecessors,
                  symbol_out => Xexit_498_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access/$exit
            word_access_496_symbol <= Xexit_498_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/word_access
          Xexit_495_symbol <= word_access_496_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete/$exit
          ptr_deref_120_complete_493_symbol <= Xexit_495_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_120_complete
        assign_stmt_131_active_x_x519_symbol <= type_cast_130_complete_529_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_131_active_
        assign_stmt_131_completed_x_x520_symbol <= assign_stmt_131_active_x_x519_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_131_completed_
        type_cast_130_active_x_x521_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_active_ 
          signal type_cast_130_active_x_x521_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_130_active_x_x521_predecessors(0) <= type_cast_130_trigger_x_x522_symbol;
          type_cast_130_active_x_x521_predecessors(1) <= simple_obj_ref_129_complete_524_symbol;
          type_cast_130_active_x_x521_join: join -- 
            port map( -- 
              preds => type_cast_130_active_x_x521_predecessors,
              symbol_out => type_cast_130_active_x_x521_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_active_
        type_cast_130_trigger_x_x522_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_trigger_
        simple_obj_ref_129_trigger_x_x523_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_trigger_
        simple_obj_ref_129_complete_524: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_complete 
          signal simple_obj_ref_129_complete_524_start: Boolean;
          signal Xentry_525_symbol: Boolean;
          signal Xexit_526_symbol: Boolean;
          signal req_527_symbol : Boolean;
          signal ack_528_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_129_complete_524_start <= simple_obj_ref_129_trigger_x_x523_symbol; -- control passed to block
          Xentry_525_symbol  <= simple_obj_ref_129_complete_524_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_complete/$entry
          req_527_symbol <= Xentry_525_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_complete/req
          simple_obj_ref_129_inst_req_0 <= req_527_symbol; -- link to DP
          ack_528_symbol <= simple_obj_ref_129_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_complete/ack
          Xexit_526_symbol <= ack_528_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_complete/$exit
          simple_obj_ref_129_complete_524_symbol <= Xexit_526_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_129_complete
        type_cast_130_complete_529: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_complete 
          signal type_cast_130_complete_529_start: Boolean;
          signal Xentry_530_symbol: Boolean;
          signal Xexit_531_symbol: Boolean;
          signal req_532_symbol : Boolean;
          signal ack_533_symbol : Boolean;
          -- 
        begin -- 
          type_cast_130_complete_529_start <= type_cast_130_active_x_x521_symbol; -- control passed to block
          Xentry_530_symbol  <= type_cast_130_complete_529_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_complete/$entry
          req_532_symbol <= Xentry_530_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_complete/req
          type_cast_130_inst_req_0 <= req_532_symbol; -- link to DP
          ack_533_symbol <= type_cast_130_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_complete/ack
          Xexit_531_symbol <= ack_533_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_complete/$exit
          type_cast_130_complete_529_symbol <= Xexit_531_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_130_complete
        assign_stmt_135_active_x_x534_symbol <= simple_obj_ref_134_complete_536_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_135_active_
        assign_stmt_135_completed_x_x535_symbol <= ptr_deref_133_complete_570_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_135_completed_
        simple_obj_ref_134_complete_536_symbol <= assign_stmt_131_completed_x_x520_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_134_complete
        ptr_deref_133_trigger_x_x537_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_trigger_ 
          signal ptr_deref_133_trigger_x_x537_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          ptr_deref_133_trigger_x_x537_predecessors(0) <= ptr_deref_133_word_address_calculated_541_symbol;
          ptr_deref_133_trigger_x_x537_predecessors(1) <= assign_stmt_135_active_x_x534_symbol;
          ptr_deref_133_trigger_x_x537_predecessors(2) <= ptr_deref_120_active_x_x461_symbol;
          ptr_deref_133_trigger_x_x537_join: join -- 
            port map( -- 
              preds => ptr_deref_133_trigger_x_x537_predecessors,
              symbol_out => ptr_deref_133_trigger_x_x537_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_trigger_
        ptr_deref_133_active_x_x538_symbol <= ptr_deref_133_request_542_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_active_
        ptr_deref_133_base_address_calculated_539_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_base_address_calculated
        ptr_deref_133_root_address_calculated_540_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_root_address_calculated
        ptr_deref_133_word_address_calculated_541_symbol <= ptr_deref_133_root_address_calculated_540_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_word_address_calculated
        ptr_deref_133_request_542: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request 
          signal ptr_deref_133_request_542_start: Boolean;
          signal Xentry_543_symbol: Boolean;
          signal Xexit_544_symbol: Boolean;
          signal split_req_545_symbol : Boolean;
          signal split_ack_546_symbol : Boolean;
          signal word_access_547_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_133_request_542_start <= ptr_deref_133_trigger_x_x537_symbol; -- control passed to block
          Xentry_543_symbol  <= ptr_deref_133_request_542_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/$entry
          split_req_545_symbol <= Xentry_543_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/split_req
          ptr_deref_133_gather_scatter_req_0 <= split_req_545_symbol; -- link to DP
          split_ack_546_symbol <= ptr_deref_133_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/split_ack
          word_access_547: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access 
            signal word_access_547_start: Boolean;
            signal Xentry_548_symbol: Boolean;
            signal Xexit_549_symbol: Boolean;
            signal word_access_0_550_symbol : Boolean;
            signal word_access_1_555_symbol : Boolean;
            signal word_access_2_560_symbol : Boolean;
            signal word_access_3_565_symbol : Boolean;
            -- 
          begin -- 
            word_access_547_start <= split_ack_546_symbol; -- control passed to block
            Xentry_548_symbol  <= word_access_547_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/$entry
            word_access_0_550: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_0 
              signal word_access_0_550_start: Boolean;
              signal Xentry_551_symbol: Boolean;
              signal Xexit_552_symbol: Boolean;
              signal rr_553_symbol : Boolean;
              signal ra_554_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_550_start <= Xentry_548_symbol; -- control passed to block
              Xentry_551_symbol  <= word_access_0_550_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_0/$entry
              rr_553_symbol <= Xentry_551_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_0/rr
              ptr_deref_133_store_0_req_0 <= rr_553_symbol; -- link to DP
              ra_554_symbol <= ptr_deref_133_store_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_0/ra
              Xexit_552_symbol <= ra_554_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_0/$exit
              word_access_0_550_symbol <= Xexit_552_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_0
            word_access_1_555: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_1 
              signal word_access_1_555_start: Boolean;
              signal Xentry_556_symbol: Boolean;
              signal Xexit_557_symbol: Boolean;
              signal rr_558_symbol : Boolean;
              signal ra_559_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_555_start <= Xentry_548_symbol; -- control passed to block
              Xentry_556_symbol  <= word_access_1_555_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_1/$entry
              rr_558_symbol <= Xentry_556_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_1/rr
              ptr_deref_133_store_1_req_0 <= rr_558_symbol; -- link to DP
              ra_559_symbol <= ptr_deref_133_store_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_1/ra
              Xexit_557_symbol <= ra_559_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_1/$exit
              word_access_1_555_symbol <= Xexit_557_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_1
            word_access_2_560: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_2 
              signal word_access_2_560_start: Boolean;
              signal Xentry_561_symbol: Boolean;
              signal Xexit_562_symbol: Boolean;
              signal rr_563_symbol : Boolean;
              signal ra_564_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_560_start <= Xentry_548_symbol; -- control passed to block
              Xentry_561_symbol  <= word_access_2_560_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_2/$entry
              rr_563_symbol <= Xentry_561_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_2/rr
              ptr_deref_133_store_2_req_0 <= rr_563_symbol; -- link to DP
              ra_564_symbol <= ptr_deref_133_store_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_2/ra
              Xexit_562_symbol <= ra_564_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_2/$exit
              word_access_2_560_symbol <= Xexit_562_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_2
            word_access_3_565: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_3 
              signal word_access_3_565_start: Boolean;
              signal Xentry_566_symbol: Boolean;
              signal Xexit_567_symbol: Boolean;
              signal rr_568_symbol : Boolean;
              signal ra_569_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_565_start <= Xentry_548_symbol; -- control passed to block
              Xentry_566_symbol  <= word_access_3_565_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_3/$entry
              rr_568_symbol <= Xentry_566_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_3/rr
              ptr_deref_133_store_3_req_0 <= rr_568_symbol; -- link to DP
              ra_569_symbol <= ptr_deref_133_store_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_3/ra
              Xexit_567_symbol <= ra_569_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_3/$exit
              word_access_3_565_symbol <= Xexit_567_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/word_access_3
            Xexit_549_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/$exit 
              signal Xexit_549_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_549_predecessors(0) <= word_access_0_550_symbol;
              Xexit_549_predecessors(1) <= word_access_1_555_symbol;
              Xexit_549_predecessors(2) <= word_access_2_560_symbol;
              Xexit_549_predecessors(3) <= word_access_3_565_symbol;
              Xexit_549_join: join -- 
                port map( -- 
                  preds => Xexit_549_predecessors,
                  symbol_out => Xexit_549_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access/$exit
            word_access_547_symbol <= Xexit_549_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/word_access
          Xexit_544_symbol <= word_access_547_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request/$exit
          ptr_deref_133_request_542_symbol <= Xexit_544_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_request
        ptr_deref_133_complete_570: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete 
          signal ptr_deref_133_complete_570_start: Boolean;
          signal Xentry_571_symbol: Boolean;
          signal Xexit_572_symbol: Boolean;
          signal word_access_573_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_133_complete_570_start <= ptr_deref_133_active_x_x538_symbol; -- control passed to block
          Xentry_571_symbol  <= ptr_deref_133_complete_570_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/$entry
          word_access_573: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access 
            signal word_access_573_start: Boolean;
            signal Xentry_574_symbol: Boolean;
            signal Xexit_575_symbol: Boolean;
            signal word_access_0_576_symbol : Boolean;
            signal word_access_1_581_symbol : Boolean;
            signal word_access_2_586_symbol : Boolean;
            signal word_access_3_591_symbol : Boolean;
            -- 
          begin -- 
            word_access_573_start <= Xentry_571_symbol; -- control passed to block
            Xentry_574_symbol  <= word_access_573_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/$entry
            word_access_0_576: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_0 
              signal word_access_0_576_start: Boolean;
              signal Xentry_577_symbol: Boolean;
              signal Xexit_578_symbol: Boolean;
              signal cr_579_symbol : Boolean;
              signal ca_580_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_576_start <= Xentry_574_symbol; -- control passed to block
              Xentry_577_symbol  <= word_access_0_576_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_0/$entry
              cr_579_symbol <= Xentry_577_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_0/cr
              ptr_deref_133_store_0_req_1 <= cr_579_symbol; -- link to DP
              ca_580_symbol <= ptr_deref_133_store_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_0/ca
              Xexit_578_symbol <= ca_580_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_0/$exit
              word_access_0_576_symbol <= Xexit_578_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_0
            word_access_1_581: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_1 
              signal word_access_1_581_start: Boolean;
              signal Xentry_582_symbol: Boolean;
              signal Xexit_583_symbol: Boolean;
              signal cr_584_symbol : Boolean;
              signal ca_585_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_581_start <= Xentry_574_symbol; -- control passed to block
              Xentry_582_symbol  <= word_access_1_581_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_1/$entry
              cr_584_symbol <= Xentry_582_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_1/cr
              ptr_deref_133_store_1_req_1 <= cr_584_symbol; -- link to DP
              ca_585_symbol <= ptr_deref_133_store_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_1/ca
              Xexit_583_symbol <= ca_585_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_1/$exit
              word_access_1_581_symbol <= Xexit_583_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_1
            word_access_2_586: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_2 
              signal word_access_2_586_start: Boolean;
              signal Xentry_587_symbol: Boolean;
              signal Xexit_588_symbol: Boolean;
              signal cr_589_symbol : Boolean;
              signal ca_590_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_586_start <= Xentry_574_symbol; -- control passed to block
              Xentry_587_symbol  <= word_access_2_586_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_2/$entry
              cr_589_symbol <= Xentry_587_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_2/cr
              ptr_deref_133_store_2_req_1 <= cr_589_symbol; -- link to DP
              ca_590_symbol <= ptr_deref_133_store_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_2/ca
              Xexit_588_symbol <= ca_590_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_2/$exit
              word_access_2_586_symbol <= Xexit_588_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_2
            word_access_3_591: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_3 
              signal word_access_3_591_start: Boolean;
              signal Xentry_592_symbol: Boolean;
              signal Xexit_593_symbol: Boolean;
              signal cr_594_symbol : Boolean;
              signal ca_595_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_591_start <= Xentry_574_symbol; -- control passed to block
              Xentry_592_symbol  <= word_access_3_591_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_3/$entry
              cr_594_symbol <= Xentry_592_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_3/cr
              ptr_deref_133_store_3_req_1 <= cr_594_symbol; -- link to DP
              ca_595_symbol <= ptr_deref_133_store_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_3/ca
              Xexit_593_symbol <= ca_595_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_3/$exit
              word_access_3_591_symbol <= Xexit_593_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/word_access_3
            Xexit_575_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/$exit 
              signal Xexit_575_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_575_predecessors(0) <= word_access_0_576_symbol;
              Xexit_575_predecessors(1) <= word_access_1_581_symbol;
              Xexit_575_predecessors(2) <= word_access_2_586_symbol;
              Xexit_575_predecessors(3) <= word_access_3_591_symbol;
              Xexit_575_join: join -- 
                port map( -- 
                  preds => Xexit_575_predecessors,
                  symbol_out => Xexit_575_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access/$exit
            word_access_573_symbol <= Xexit_575_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/word_access
          Xexit_572_symbol <= word_access_573_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete/$exit
          ptr_deref_133_complete_570_symbol <= Xexit_572_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_133_complete
        assign_stmt_139_active_x_x596_symbol <= ptr_deref_138_complete_629_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_139_active_
        assign_stmt_139_completed_x_x597_symbol <= assign_stmt_139_active_x_x596_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_139_completed_
        ptr_deref_138_trigger_x_x598_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_trigger_ 
          signal ptr_deref_138_trigger_x_x598_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_138_trigger_x_x598_predecessors(0) <= ptr_deref_138_word_address_calculated_602_symbol;
          ptr_deref_138_trigger_x_x598_predecessors(1) <= ptr_deref_133_active_x_x538_symbol;
          ptr_deref_138_trigger_x_x598_join: join -- 
            port map( -- 
              preds => ptr_deref_138_trigger_x_x598_predecessors,
              symbol_out => ptr_deref_138_trigger_x_x598_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_trigger_
        ptr_deref_138_active_x_x599_symbol <= ptr_deref_138_request_603_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_active_
        ptr_deref_138_base_address_calculated_600_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_base_address_calculated
        ptr_deref_138_root_address_calculated_601_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_root_address_calculated
        ptr_deref_138_word_address_calculated_602_symbol <= ptr_deref_138_root_address_calculated_601_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_word_address_calculated
        ptr_deref_138_request_603: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request 
          signal ptr_deref_138_request_603_start: Boolean;
          signal Xentry_604_symbol: Boolean;
          signal Xexit_605_symbol: Boolean;
          signal word_access_606_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_138_request_603_start <= ptr_deref_138_trigger_x_x598_symbol; -- control passed to block
          Xentry_604_symbol  <= ptr_deref_138_request_603_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/$entry
          word_access_606: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access 
            signal word_access_606_start: Boolean;
            signal Xentry_607_symbol: Boolean;
            signal Xexit_608_symbol: Boolean;
            signal word_access_0_609_symbol : Boolean;
            signal word_access_1_614_symbol : Boolean;
            signal word_access_2_619_symbol : Boolean;
            signal word_access_3_624_symbol : Boolean;
            -- 
          begin -- 
            word_access_606_start <= Xentry_604_symbol; -- control passed to block
            Xentry_607_symbol  <= word_access_606_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/$entry
            word_access_0_609: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_0 
              signal word_access_0_609_start: Boolean;
              signal Xentry_610_symbol: Boolean;
              signal Xexit_611_symbol: Boolean;
              signal rr_612_symbol : Boolean;
              signal ra_613_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_609_start <= Xentry_607_symbol; -- control passed to block
              Xentry_610_symbol  <= word_access_0_609_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_0/$entry
              rr_612_symbol <= Xentry_610_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_0/rr
              ptr_deref_138_load_0_req_0 <= rr_612_symbol; -- link to DP
              ra_613_symbol <= ptr_deref_138_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_0/ra
              Xexit_611_symbol <= ra_613_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_0/$exit
              word_access_0_609_symbol <= Xexit_611_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_0
            word_access_1_614: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_1 
              signal word_access_1_614_start: Boolean;
              signal Xentry_615_symbol: Boolean;
              signal Xexit_616_symbol: Boolean;
              signal rr_617_symbol : Boolean;
              signal ra_618_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_614_start <= Xentry_607_symbol; -- control passed to block
              Xentry_615_symbol  <= word_access_1_614_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_1/$entry
              rr_617_symbol <= Xentry_615_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_1/rr
              ptr_deref_138_load_1_req_0 <= rr_617_symbol; -- link to DP
              ra_618_symbol <= ptr_deref_138_load_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_1/ra
              Xexit_616_symbol <= ra_618_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_1/$exit
              word_access_1_614_symbol <= Xexit_616_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_1
            word_access_2_619: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_2 
              signal word_access_2_619_start: Boolean;
              signal Xentry_620_symbol: Boolean;
              signal Xexit_621_symbol: Boolean;
              signal rr_622_symbol : Boolean;
              signal ra_623_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_619_start <= Xentry_607_symbol; -- control passed to block
              Xentry_620_symbol  <= word_access_2_619_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_2/$entry
              rr_622_symbol <= Xentry_620_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_2/rr
              ptr_deref_138_load_2_req_0 <= rr_622_symbol; -- link to DP
              ra_623_symbol <= ptr_deref_138_load_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_2/ra
              Xexit_621_symbol <= ra_623_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_2/$exit
              word_access_2_619_symbol <= Xexit_621_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_2
            word_access_3_624: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_3 
              signal word_access_3_624_start: Boolean;
              signal Xentry_625_symbol: Boolean;
              signal Xexit_626_symbol: Boolean;
              signal rr_627_symbol : Boolean;
              signal ra_628_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_624_start <= Xentry_607_symbol; -- control passed to block
              Xentry_625_symbol  <= word_access_3_624_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_3/$entry
              rr_627_symbol <= Xentry_625_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_3/rr
              ptr_deref_138_load_3_req_0 <= rr_627_symbol; -- link to DP
              ra_628_symbol <= ptr_deref_138_load_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_3/ra
              Xexit_626_symbol <= ra_628_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_3/$exit
              word_access_3_624_symbol <= Xexit_626_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/word_access_3
            Xexit_608_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/$exit 
              signal Xexit_608_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_608_predecessors(0) <= word_access_0_609_symbol;
              Xexit_608_predecessors(1) <= word_access_1_614_symbol;
              Xexit_608_predecessors(2) <= word_access_2_619_symbol;
              Xexit_608_predecessors(3) <= word_access_3_624_symbol;
              Xexit_608_join: join -- 
                port map( -- 
                  preds => Xexit_608_predecessors,
                  symbol_out => Xexit_608_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access/$exit
            word_access_606_symbol <= Xexit_608_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/word_access
          Xexit_605_symbol <= word_access_606_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request/$exit
          ptr_deref_138_request_603_symbol <= Xexit_605_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_request
        ptr_deref_138_complete_629: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete 
          signal ptr_deref_138_complete_629_start: Boolean;
          signal Xentry_630_symbol: Boolean;
          signal Xexit_631_symbol: Boolean;
          signal word_access_632_symbol : Boolean;
          signal merge_req_655_symbol : Boolean;
          signal merge_ack_656_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_138_complete_629_start <= ptr_deref_138_active_x_x599_symbol; -- control passed to block
          Xentry_630_symbol  <= ptr_deref_138_complete_629_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/$entry
          word_access_632: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access 
            signal word_access_632_start: Boolean;
            signal Xentry_633_symbol: Boolean;
            signal Xexit_634_symbol: Boolean;
            signal word_access_0_635_symbol : Boolean;
            signal word_access_1_640_symbol : Boolean;
            signal word_access_2_645_symbol : Boolean;
            signal word_access_3_650_symbol : Boolean;
            -- 
          begin -- 
            word_access_632_start <= Xentry_630_symbol; -- control passed to block
            Xentry_633_symbol  <= word_access_632_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/$entry
            word_access_0_635: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_0 
              signal word_access_0_635_start: Boolean;
              signal Xentry_636_symbol: Boolean;
              signal Xexit_637_symbol: Boolean;
              signal cr_638_symbol : Boolean;
              signal ca_639_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_635_start <= Xentry_633_symbol; -- control passed to block
              Xentry_636_symbol  <= word_access_0_635_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_0/$entry
              cr_638_symbol <= Xentry_636_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_0/cr
              ptr_deref_138_load_0_req_1 <= cr_638_symbol; -- link to DP
              ca_639_symbol <= ptr_deref_138_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_0/ca
              Xexit_637_symbol <= ca_639_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_0/$exit
              word_access_0_635_symbol <= Xexit_637_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_0
            word_access_1_640: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_1 
              signal word_access_1_640_start: Boolean;
              signal Xentry_641_symbol: Boolean;
              signal Xexit_642_symbol: Boolean;
              signal cr_643_symbol : Boolean;
              signal ca_644_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_640_start <= Xentry_633_symbol; -- control passed to block
              Xentry_641_symbol  <= word_access_1_640_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_1/$entry
              cr_643_symbol <= Xentry_641_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_1/cr
              ptr_deref_138_load_1_req_1 <= cr_643_symbol; -- link to DP
              ca_644_symbol <= ptr_deref_138_load_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_1/ca
              Xexit_642_symbol <= ca_644_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_1/$exit
              word_access_1_640_symbol <= Xexit_642_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_1
            word_access_2_645: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_2 
              signal word_access_2_645_start: Boolean;
              signal Xentry_646_symbol: Boolean;
              signal Xexit_647_symbol: Boolean;
              signal cr_648_symbol : Boolean;
              signal ca_649_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_645_start <= Xentry_633_symbol; -- control passed to block
              Xentry_646_symbol  <= word_access_2_645_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_2/$entry
              cr_648_symbol <= Xentry_646_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_2/cr
              ptr_deref_138_load_2_req_1 <= cr_648_symbol; -- link to DP
              ca_649_symbol <= ptr_deref_138_load_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_2/ca
              Xexit_647_symbol <= ca_649_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_2/$exit
              word_access_2_645_symbol <= Xexit_647_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_2
            word_access_3_650: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_3 
              signal word_access_3_650_start: Boolean;
              signal Xentry_651_symbol: Boolean;
              signal Xexit_652_symbol: Boolean;
              signal cr_653_symbol : Boolean;
              signal ca_654_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_650_start <= Xentry_633_symbol; -- control passed to block
              Xentry_651_symbol  <= word_access_3_650_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_3/$entry
              cr_653_symbol <= Xentry_651_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_3/cr
              ptr_deref_138_load_3_req_1 <= cr_653_symbol; -- link to DP
              ca_654_symbol <= ptr_deref_138_load_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_3/ca
              Xexit_652_symbol <= ca_654_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_3/$exit
              word_access_3_650_symbol <= Xexit_652_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/word_access_3
            Xexit_634_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/$exit 
              signal Xexit_634_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_634_predecessors(0) <= word_access_0_635_symbol;
              Xexit_634_predecessors(1) <= word_access_1_640_symbol;
              Xexit_634_predecessors(2) <= word_access_2_645_symbol;
              Xexit_634_predecessors(3) <= word_access_3_650_symbol;
              Xexit_634_join: join -- 
                port map( -- 
                  preds => Xexit_634_predecessors,
                  symbol_out => Xexit_634_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access/$exit
            word_access_632_symbol <= Xexit_634_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/word_access
          merge_req_655_symbol <= word_access_632_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/merge_req
          ptr_deref_138_gather_scatter_req_0 <= merge_req_655_symbol; -- link to DP
          merge_ack_656_symbol <= ptr_deref_138_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/merge_ack
          Xexit_631_symbol <= merge_ack_656_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete/$exit
          ptr_deref_138_complete_629_symbol <= Xexit_631_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_138_complete
        assign_stmt_143_active_x_x657_symbol <= ptr_deref_142_complete_690_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_143_active_
        assign_stmt_143_completed_x_x658_symbol <= assign_stmt_143_active_x_x657_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_143_completed_
        ptr_deref_142_trigger_x_x659_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_trigger_ 
          signal ptr_deref_142_trigger_x_x659_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_142_trigger_x_x659_predecessors(0) <= ptr_deref_142_word_address_calculated_663_symbol;
          ptr_deref_142_trigger_x_x659_predecessors(1) <= ptr_deref_133_active_x_x538_symbol;
          ptr_deref_142_trigger_x_x659_join: join -- 
            port map( -- 
              preds => ptr_deref_142_trigger_x_x659_predecessors,
              symbol_out => ptr_deref_142_trigger_x_x659_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_trigger_
        ptr_deref_142_active_x_x660_symbol <= ptr_deref_142_request_664_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_active_
        ptr_deref_142_base_address_calculated_661_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_base_address_calculated
        ptr_deref_142_root_address_calculated_662_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_root_address_calculated
        ptr_deref_142_word_address_calculated_663_symbol <= ptr_deref_142_root_address_calculated_662_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_word_address_calculated
        ptr_deref_142_request_664: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request 
          signal ptr_deref_142_request_664_start: Boolean;
          signal Xentry_665_symbol: Boolean;
          signal Xexit_666_symbol: Boolean;
          signal word_access_667_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_142_request_664_start <= ptr_deref_142_trigger_x_x659_symbol; -- control passed to block
          Xentry_665_symbol  <= ptr_deref_142_request_664_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/$entry
          word_access_667: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access 
            signal word_access_667_start: Boolean;
            signal Xentry_668_symbol: Boolean;
            signal Xexit_669_symbol: Boolean;
            signal word_access_0_670_symbol : Boolean;
            signal word_access_1_675_symbol : Boolean;
            signal word_access_2_680_symbol : Boolean;
            signal word_access_3_685_symbol : Boolean;
            -- 
          begin -- 
            word_access_667_start <= Xentry_665_symbol; -- control passed to block
            Xentry_668_symbol  <= word_access_667_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/$entry
            word_access_0_670: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_0 
              signal word_access_0_670_start: Boolean;
              signal Xentry_671_symbol: Boolean;
              signal Xexit_672_symbol: Boolean;
              signal rr_673_symbol : Boolean;
              signal ra_674_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_670_start <= Xentry_668_symbol; -- control passed to block
              Xentry_671_symbol  <= word_access_0_670_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_0/$entry
              rr_673_symbol <= Xentry_671_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_0/rr
              ptr_deref_142_load_0_req_0 <= rr_673_symbol; -- link to DP
              ra_674_symbol <= ptr_deref_142_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_0/ra
              Xexit_672_symbol <= ra_674_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_0/$exit
              word_access_0_670_symbol <= Xexit_672_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_0
            word_access_1_675: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_1 
              signal word_access_1_675_start: Boolean;
              signal Xentry_676_symbol: Boolean;
              signal Xexit_677_symbol: Boolean;
              signal rr_678_symbol : Boolean;
              signal ra_679_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_675_start <= Xentry_668_symbol; -- control passed to block
              Xentry_676_symbol  <= word_access_1_675_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_1/$entry
              rr_678_symbol <= Xentry_676_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_1/rr
              ptr_deref_142_load_1_req_0 <= rr_678_symbol; -- link to DP
              ra_679_symbol <= ptr_deref_142_load_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_1/ra
              Xexit_677_symbol <= ra_679_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_1/$exit
              word_access_1_675_symbol <= Xexit_677_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_1
            word_access_2_680: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_2 
              signal word_access_2_680_start: Boolean;
              signal Xentry_681_symbol: Boolean;
              signal Xexit_682_symbol: Boolean;
              signal rr_683_symbol : Boolean;
              signal ra_684_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_680_start <= Xentry_668_symbol; -- control passed to block
              Xentry_681_symbol  <= word_access_2_680_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_2/$entry
              rr_683_symbol <= Xentry_681_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_2/rr
              ptr_deref_142_load_2_req_0 <= rr_683_symbol; -- link to DP
              ra_684_symbol <= ptr_deref_142_load_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_2/ra
              Xexit_682_symbol <= ra_684_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_2/$exit
              word_access_2_680_symbol <= Xexit_682_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_2
            word_access_3_685: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_3 
              signal word_access_3_685_start: Boolean;
              signal Xentry_686_symbol: Boolean;
              signal Xexit_687_symbol: Boolean;
              signal rr_688_symbol : Boolean;
              signal ra_689_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_685_start <= Xentry_668_symbol; -- control passed to block
              Xentry_686_symbol  <= word_access_3_685_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_3/$entry
              rr_688_symbol <= Xentry_686_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_3/rr
              ptr_deref_142_load_3_req_0 <= rr_688_symbol; -- link to DP
              ra_689_symbol <= ptr_deref_142_load_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_3/ra
              Xexit_687_symbol <= ra_689_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_3/$exit
              word_access_3_685_symbol <= Xexit_687_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/word_access_3
            Xexit_669_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/$exit 
              signal Xexit_669_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_669_predecessors(0) <= word_access_0_670_symbol;
              Xexit_669_predecessors(1) <= word_access_1_675_symbol;
              Xexit_669_predecessors(2) <= word_access_2_680_symbol;
              Xexit_669_predecessors(3) <= word_access_3_685_symbol;
              Xexit_669_join: join -- 
                port map( -- 
                  preds => Xexit_669_predecessors,
                  symbol_out => Xexit_669_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access/$exit
            word_access_667_symbol <= Xexit_669_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/word_access
          Xexit_666_symbol <= word_access_667_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request/$exit
          ptr_deref_142_request_664_symbol <= Xexit_666_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_request
        ptr_deref_142_complete_690: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete 
          signal ptr_deref_142_complete_690_start: Boolean;
          signal Xentry_691_symbol: Boolean;
          signal Xexit_692_symbol: Boolean;
          signal word_access_693_symbol : Boolean;
          signal merge_req_716_symbol : Boolean;
          signal merge_ack_717_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_142_complete_690_start <= ptr_deref_142_active_x_x660_symbol; -- control passed to block
          Xentry_691_symbol  <= ptr_deref_142_complete_690_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/$entry
          word_access_693: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access 
            signal word_access_693_start: Boolean;
            signal Xentry_694_symbol: Boolean;
            signal Xexit_695_symbol: Boolean;
            signal word_access_0_696_symbol : Boolean;
            signal word_access_1_701_symbol : Boolean;
            signal word_access_2_706_symbol : Boolean;
            signal word_access_3_711_symbol : Boolean;
            -- 
          begin -- 
            word_access_693_start <= Xentry_691_symbol; -- control passed to block
            Xentry_694_symbol  <= word_access_693_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/$entry
            word_access_0_696: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_0 
              signal word_access_0_696_start: Boolean;
              signal Xentry_697_symbol: Boolean;
              signal Xexit_698_symbol: Boolean;
              signal cr_699_symbol : Boolean;
              signal ca_700_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_696_start <= Xentry_694_symbol; -- control passed to block
              Xentry_697_symbol  <= word_access_0_696_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_0/$entry
              cr_699_symbol <= Xentry_697_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_0/cr
              ptr_deref_142_load_0_req_1 <= cr_699_symbol; -- link to DP
              ca_700_symbol <= ptr_deref_142_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_0/ca
              Xexit_698_symbol <= ca_700_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_0/$exit
              word_access_0_696_symbol <= Xexit_698_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_0
            word_access_1_701: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_1 
              signal word_access_1_701_start: Boolean;
              signal Xentry_702_symbol: Boolean;
              signal Xexit_703_symbol: Boolean;
              signal cr_704_symbol : Boolean;
              signal ca_705_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_701_start <= Xentry_694_symbol; -- control passed to block
              Xentry_702_symbol  <= word_access_1_701_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_1/$entry
              cr_704_symbol <= Xentry_702_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_1/cr
              ptr_deref_142_load_1_req_1 <= cr_704_symbol; -- link to DP
              ca_705_symbol <= ptr_deref_142_load_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_1/ca
              Xexit_703_symbol <= ca_705_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_1/$exit
              word_access_1_701_symbol <= Xexit_703_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_1
            word_access_2_706: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_2 
              signal word_access_2_706_start: Boolean;
              signal Xentry_707_symbol: Boolean;
              signal Xexit_708_symbol: Boolean;
              signal cr_709_symbol : Boolean;
              signal ca_710_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_706_start <= Xentry_694_symbol; -- control passed to block
              Xentry_707_symbol  <= word_access_2_706_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_2/$entry
              cr_709_symbol <= Xentry_707_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_2/cr
              ptr_deref_142_load_2_req_1 <= cr_709_symbol; -- link to DP
              ca_710_symbol <= ptr_deref_142_load_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_2/ca
              Xexit_708_symbol <= ca_710_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_2/$exit
              word_access_2_706_symbol <= Xexit_708_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_2
            word_access_3_711: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_3 
              signal word_access_3_711_start: Boolean;
              signal Xentry_712_symbol: Boolean;
              signal Xexit_713_symbol: Boolean;
              signal cr_714_symbol : Boolean;
              signal ca_715_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_711_start <= Xentry_694_symbol; -- control passed to block
              Xentry_712_symbol  <= word_access_3_711_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_3/$entry
              cr_714_symbol <= Xentry_712_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_3/cr
              ptr_deref_142_load_3_req_1 <= cr_714_symbol; -- link to DP
              ca_715_symbol <= ptr_deref_142_load_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_3/ca
              Xexit_713_symbol <= ca_715_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_3/$exit
              word_access_3_711_symbol <= Xexit_713_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/word_access_3
            Xexit_695_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/$exit 
              signal Xexit_695_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_695_predecessors(0) <= word_access_0_696_symbol;
              Xexit_695_predecessors(1) <= word_access_1_701_symbol;
              Xexit_695_predecessors(2) <= word_access_2_706_symbol;
              Xexit_695_predecessors(3) <= word_access_3_711_symbol;
              Xexit_695_join: join -- 
                port map( -- 
                  preds => Xexit_695_predecessors,
                  symbol_out => Xexit_695_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access/$exit
            word_access_693_symbol <= Xexit_695_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/word_access
          merge_req_716_symbol <= word_access_693_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/merge_req
          ptr_deref_142_gather_scatter_req_0 <= merge_req_716_symbol; -- link to DP
          merge_ack_717_symbol <= ptr_deref_142_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/merge_ack
          Xexit_692_symbol <= merge_ack_717_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete/$exit
          ptr_deref_142_complete_690_symbol <= Xexit_692_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_142_complete
        assign_stmt_148_active_x_x718_symbol <= binary_147_complete_724_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_148_active_
        assign_stmt_148_completed_x_x719_symbol <= assign_stmt_148_active_x_x718_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_148_completed_
        binary_147_active_x_x720_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_active_ 
          signal binary_147_active_x_x720_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_147_active_x_x720_predecessors(0) <= binary_147_trigger_x_x721_symbol;
          binary_147_active_x_x720_predecessors(1) <= simple_obj_ref_145_complete_722_symbol;
          binary_147_active_x_x720_predecessors(2) <= simple_obj_ref_146_complete_723_symbol;
          binary_147_active_x_x720_join: join -- 
            port map( -- 
              preds => binary_147_active_x_x720_predecessors,
              symbol_out => binary_147_active_x_x720_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_active_
        binary_147_trigger_x_x721_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_trigger_
        simple_obj_ref_145_complete_722_symbol <= assign_stmt_139_completed_x_x597_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_145_complete
        simple_obj_ref_146_complete_723_symbol <= assign_stmt_143_completed_x_x658_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_146_complete
        binary_147_complete_724: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete 
          signal binary_147_complete_724_start: Boolean;
          signal Xentry_725_symbol: Boolean;
          signal Xexit_726_symbol: Boolean;
          signal rr_727_symbol : Boolean;
          signal ra_728_symbol : Boolean;
          signal cr_729_symbol : Boolean;
          signal ca_730_symbol : Boolean;
          -- 
        begin -- 
          binary_147_complete_724_start <= binary_147_active_x_x720_symbol; -- control passed to block
          Xentry_725_symbol  <= binary_147_complete_724_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete/$entry
          rr_727_symbol <= Xentry_725_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete/rr
          binary_147_inst_req_0 <= rr_727_symbol; -- link to DP
          ra_728_symbol <= binary_147_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete/ra
          cr_729_symbol <= ra_728_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete/cr
          binary_147_inst_req_1 <= cr_729_symbol; -- link to DP
          ca_730_symbol <= binary_147_inst_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete/ca
          Xexit_726_symbol <= ca_730_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete/$exit
          binary_147_complete_724_symbol <= Xexit_726_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/binary_147_complete
        assign_stmt_157_active_x_x731_symbol <= type_cast_156_complete_736_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_157_active_
        assign_stmt_157_completed_x_x732_symbol <= simple_obj_ref_154_complete_742_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_157_completed_
        type_cast_156_active_x_x733_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_active_ 
          signal type_cast_156_active_x_x733_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_156_active_x_x733_predecessors(0) <= type_cast_156_trigger_x_x734_symbol;
          type_cast_156_active_x_x733_predecessors(1) <= simple_obj_ref_155_complete_735_symbol;
          type_cast_156_active_x_x733_join: join -- 
            port map( -- 
              preds => type_cast_156_active_x_x733_predecessors,
              symbol_out => type_cast_156_active_x_x733_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_active_
        type_cast_156_trigger_x_x734_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_trigger_
        simple_obj_ref_155_complete_735_symbol <= assign_stmt_148_completed_x_x719_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_155_complete
        type_cast_156_complete_736: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_complete 
          signal type_cast_156_complete_736_start: Boolean;
          signal Xentry_737_symbol: Boolean;
          signal Xexit_738_symbol: Boolean;
          signal req_739_symbol : Boolean;
          signal ack_740_symbol : Boolean;
          -- 
        begin -- 
          type_cast_156_complete_736_start <= type_cast_156_active_x_x733_symbol; -- control passed to block
          Xentry_737_symbol  <= type_cast_156_complete_736_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_complete/$entry
          req_739_symbol <= Xentry_737_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_complete/req
          type_cast_156_inst_req_0 <= req_739_symbol; -- link to DP
          ack_740_symbol <= type_cast_156_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_complete/ack
          Xexit_738_symbol <= ack_740_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_complete/$exit
          type_cast_156_complete_736_symbol <= Xexit_738_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/type_cast_156_complete
        simple_obj_ref_154_trigger_x_x741_symbol <= assign_stmt_157_active_x_x731_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_trigger_
        simple_obj_ref_154_complete_742: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_complete 
          signal simple_obj_ref_154_complete_742_start: Boolean;
          signal Xentry_743_symbol: Boolean;
          signal Xexit_744_symbol: Boolean;
          signal pipe_wreq_745_symbol : Boolean;
          signal pipe_wack_746_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_154_complete_742_start <= simple_obj_ref_154_trigger_x_x741_symbol; -- control passed to block
          Xentry_743_symbol  <= simple_obj_ref_154_complete_742_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_complete/$entry
          pipe_wreq_745_symbol <= Xentry_743_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_complete/pipe_wreq
          simple_obj_ref_154_inst_req_0 <= pipe_wreq_745_symbol; -- link to DP
          pipe_wack_746_symbol <= simple_obj_ref_154_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_complete/pipe_wack
          Xexit_744_symbol <= pipe_wack_746_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_complete/$exit
          simple_obj_ref_154_complete_742_symbol <= Xexit_744_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_154_complete
        assign_stmt_161_active_x_x747_symbol <= ptr_deref_160_complete_780_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_161_active_
        assign_stmt_161_completed_x_x748_symbol <= assign_stmt_161_active_x_x747_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_161_completed_
        ptr_deref_160_trigger_x_x749_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_trigger_ 
          signal ptr_deref_160_trigger_x_x749_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_160_trigger_x_x749_predecessors(0) <= ptr_deref_160_word_address_calculated_753_symbol;
          ptr_deref_160_trigger_x_x749_predecessors(1) <= ptr_deref_133_active_x_x538_symbol;
          ptr_deref_160_trigger_x_x749_join: join -- 
            port map( -- 
              preds => ptr_deref_160_trigger_x_x749_predecessors,
              symbol_out => ptr_deref_160_trigger_x_x749_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_trigger_
        ptr_deref_160_active_x_x750_symbol <= ptr_deref_160_request_754_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_active_
        ptr_deref_160_base_address_calculated_751_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_base_address_calculated
        ptr_deref_160_root_address_calculated_752_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_root_address_calculated
        ptr_deref_160_word_address_calculated_753_symbol <= ptr_deref_160_root_address_calculated_752_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_word_address_calculated
        ptr_deref_160_request_754: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request 
          signal ptr_deref_160_request_754_start: Boolean;
          signal Xentry_755_symbol: Boolean;
          signal Xexit_756_symbol: Boolean;
          signal word_access_757_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_160_request_754_start <= ptr_deref_160_trigger_x_x749_symbol; -- control passed to block
          Xentry_755_symbol  <= ptr_deref_160_request_754_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/$entry
          word_access_757: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access 
            signal word_access_757_start: Boolean;
            signal Xentry_758_symbol: Boolean;
            signal Xexit_759_symbol: Boolean;
            signal word_access_0_760_symbol : Boolean;
            signal word_access_1_765_symbol : Boolean;
            signal word_access_2_770_symbol : Boolean;
            signal word_access_3_775_symbol : Boolean;
            -- 
          begin -- 
            word_access_757_start <= Xentry_755_symbol; -- control passed to block
            Xentry_758_symbol  <= word_access_757_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/$entry
            word_access_0_760: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_0 
              signal word_access_0_760_start: Boolean;
              signal Xentry_761_symbol: Boolean;
              signal Xexit_762_symbol: Boolean;
              signal rr_763_symbol : Boolean;
              signal ra_764_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_760_start <= Xentry_758_symbol; -- control passed to block
              Xentry_761_symbol  <= word_access_0_760_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_0/$entry
              rr_763_symbol <= Xentry_761_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_0/rr
              ptr_deref_160_load_0_req_0 <= rr_763_symbol; -- link to DP
              ra_764_symbol <= ptr_deref_160_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_0/ra
              Xexit_762_symbol <= ra_764_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_0/$exit
              word_access_0_760_symbol <= Xexit_762_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_0
            word_access_1_765: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_1 
              signal word_access_1_765_start: Boolean;
              signal Xentry_766_symbol: Boolean;
              signal Xexit_767_symbol: Boolean;
              signal rr_768_symbol : Boolean;
              signal ra_769_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_765_start <= Xentry_758_symbol; -- control passed to block
              Xentry_766_symbol  <= word_access_1_765_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_1/$entry
              rr_768_symbol <= Xentry_766_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_1/rr
              ptr_deref_160_load_1_req_0 <= rr_768_symbol; -- link to DP
              ra_769_symbol <= ptr_deref_160_load_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_1/ra
              Xexit_767_symbol <= ra_769_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_1/$exit
              word_access_1_765_symbol <= Xexit_767_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_1
            word_access_2_770: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_2 
              signal word_access_2_770_start: Boolean;
              signal Xentry_771_symbol: Boolean;
              signal Xexit_772_symbol: Boolean;
              signal rr_773_symbol : Boolean;
              signal ra_774_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_770_start <= Xentry_758_symbol; -- control passed to block
              Xentry_771_symbol  <= word_access_2_770_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_2/$entry
              rr_773_symbol <= Xentry_771_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_2/rr
              ptr_deref_160_load_2_req_0 <= rr_773_symbol; -- link to DP
              ra_774_symbol <= ptr_deref_160_load_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_2/ra
              Xexit_772_symbol <= ra_774_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_2/$exit
              word_access_2_770_symbol <= Xexit_772_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_2
            word_access_3_775: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_3 
              signal word_access_3_775_start: Boolean;
              signal Xentry_776_symbol: Boolean;
              signal Xexit_777_symbol: Boolean;
              signal rr_778_symbol : Boolean;
              signal ra_779_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_775_start <= Xentry_758_symbol; -- control passed to block
              Xentry_776_symbol  <= word_access_3_775_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_3/$entry
              rr_778_symbol <= Xentry_776_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_3/rr
              ptr_deref_160_load_3_req_0 <= rr_778_symbol; -- link to DP
              ra_779_symbol <= ptr_deref_160_load_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_3/ra
              Xexit_777_symbol <= ra_779_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_3/$exit
              word_access_3_775_symbol <= Xexit_777_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/word_access_3
            Xexit_759_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/$exit 
              signal Xexit_759_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_759_predecessors(0) <= word_access_0_760_symbol;
              Xexit_759_predecessors(1) <= word_access_1_765_symbol;
              Xexit_759_predecessors(2) <= word_access_2_770_symbol;
              Xexit_759_predecessors(3) <= word_access_3_775_symbol;
              Xexit_759_join: join -- 
                port map( -- 
                  preds => Xexit_759_predecessors,
                  symbol_out => Xexit_759_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access/$exit
            word_access_757_symbol <= Xexit_759_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/word_access
          Xexit_756_symbol <= word_access_757_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request/$exit
          ptr_deref_160_request_754_symbol <= Xexit_756_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_request
        ptr_deref_160_complete_780: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete 
          signal ptr_deref_160_complete_780_start: Boolean;
          signal Xentry_781_symbol: Boolean;
          signal Xexit_782_symbol: Boolean;
          signal word_access_783_symbol : Boolean;
          signal merge_req_806_symbol : Boolean;
          signal merge_ack_807_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_160_complete_780_start <= ptr_deref_160_active_x_x750_symbol; -- control passed to block
          Xentry_781_symbol  <= ptr_deref_160_complete_780_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/$entry
          word_access_783: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access 
            signal word_access_783_start: Boolean;
            signal Xentry_784_symbol: Boolean;
            signal Xexit_785_symbol: Boolean;
            signal word_access_0_786_symbol : Boolean;
            signal word_access_1_791_symbol : Boolean;
            signal word_access_2_796_symbol : Boolean;
            signal word_access_3_801_symbol : Boolean;
            -- 
          begin -- 
            word_access_783_start <= Xentry_781_symbol; -- control passed to block
            Xentry_784_symbol  <= word_access_783_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/$entry
            word_access_0_786: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_0 
              signal word_access_0_786_start: Boolean;
              signal Xentry_787_symbol: Boolean;
              signal Xexit_788_symbol: Boolean;
              signal cr_789_symbol : Boolean;
              signal ca_790_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_786_start <= Xentry_784_symbol; -- control passed to block
              Xentry_787_symbol  <= word_access_0_786_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_0/$entry
              cr_789_symbol <= Xentry_787_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_0/cr
              ptr_deref_160_load_0_req_1 <= cr_789_symbol; -- link to DP
              ca_790_symbol <= ptr_deref_160_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_0/ca
              Xexit_788_symbol <= ca_790_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_0/$exit
              word_access_0_786_symbol <= Xexit_788_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_0
            word_access_1_791: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_1 
              signal word_access_1_791_start: Boolean;
              signal Xentry_792_symbol: Boolean;
              signal Xexit_793_symbol: Boolean;
              signal cr_794_symbol : Boolean;
              signal ca_795_symbol : Boolean;
              -- 
            begin -- 
              word_access_1_791_start <= Xentry_784_symbol; -- control passed to block
              Xentry_792_symbol  <= word_access_1_791_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_1/$entry
              cr_794_symbol <= Xentry_792_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_1/cr
              ptr_deref_160_load_1_req_1 <= cr_794_symbol; -- link to DP
              ca_795_symbol <= ptr_deref_160_load_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_1/ca
              Xexit_793_symbol <= ca_795_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_1/$exit
              word_access_1_791_symbol <= Xexit_793_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_1
            word_access_2_796: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_2 
              signal word_access_2_796_start: Boolean;
              signal Xentry_797_symbol: Boolean;
              signal Xexit_798_symbol: Boolean;
              signal cr_799_symbol : Boolean;
              signal ca_800_symbol : Boolean;
              -- 
            begin -- 
              word_access_2_796_start <= Xentry_784_symbol; -- control passed to block
              Xentry_797_symbol  <= word_access_2_796_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_2/$entry
              cr_799_symbol <= Xentry_797_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_2/cr
              ptr_deref_160_load_2_req_1 <= cr_799_symbol; -- link to DP
              ca_800_symbol <= ptr_deref_160_load_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_2/ca
              Xexit_798_symbol <= ca_800_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_2/$exit
              word_access_2_796_symbol <= Xexit_798_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_2
            word_access_3_801: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_3 
              signal word_access_3_801_start: Boolean;
              signal Xentry_802_symbol: Boolean;
              signal Xexit_803_symbol: Boolean;
              signal cr_804_symbol : Boolean;
              signal ca_805_symbol : Boolean;
              -- 
            begin -- 
              word_access_3_801_start <= Xentry_784_symbol; -- control passed to block
              Xentry_802_symbol  <= word_access_3_801_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_3/$entry
              cr_804_symbol <= Xentry_802_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_3/cr
              ptr_deref_160_load_3_req_1 <= cr_804_symbol; -- link to DP
              ca_805_symbol <= ptr_deref_160_load_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_3/ca
              Xexit_803_symbol <= ca_805_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_3/$exit
              word_access_3_801_symbol <= Xexit_803_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/word_access_3
            Xexit_785_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/$exit 
              signal Xexit_785_predecessors: BooleanArray(3 downto 0);
              -- 
            begin -- 
              Xexit_785_predecessors(0) <= word_access_0_786_symbol;
              Xexit_785_predecessors(1) <= word_access_1_791_symbol;
              Xexit_785_predecessors(2) <= word_access_2_796_symbol;
              Xexit_785_predecessors(3) <= word_access_3_801_symbol;
              Xexit_785_join: join -- 
                port map( -- 
                  preds => Xexit_785_predecessors,
                  symbol_out => Xexit_785_symbol,
                  clk => clk,
                  reset => reset); -- 
              -- 
            end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access/$exit
            word_access_783_symbol <= Xexit_785_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/word_access
          merge_req_806_symbol <= word_access_783_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/merge_req
          ptr_deref_160_gather_scatter_req_0 <= merge_req_806_symbol; -- link to DP
          merge_ack_807_symbol <= ptr_deref_160_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/merge_ack
          Xexit_782_symbol <= merge_ack_807_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete/$exit
          ptr_deref_160_complete_780_symbol <= Xexit_782_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/ptr_deref_160_complete
        assign_stmt_164_active_x_x808_symbol <= simple_obj_ref_163_complete_810_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_164_active_
        assign_stmt_164_completed_x_x809_symbol <= simple_obj_ref_162_complete_828_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/assign_stmt_164_completed_
        simple_obj_ref_163_complete_810_symbol <= assign_stmt_161_completed_x_x748_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_163_complete
        simple_obj_ref_162_trigger_x_x811_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_trigger_ 
          signal simple_obj_ref_162_trigger_x_x811_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          simple_obj_ref_162_trigger_x_x811_predecessors(0) <= simple_obj_ref_162_word_address_calculated_814_symbol;
          simple_obj_ref_162_trigger_x_x811_predecessors(1) <= assign_stmt_164_active_x_x808_symbol;
          simple_obj_ref_162_trigger_x_x811_join: join -- 
            port map( -- 
              preds => simple_obj_ref_162_trigger_x_x811_predecessors,
              symbol_out => simple_obj_ref_162_trigger_x_x811_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_trigger_
        simple_obj_ref_162_active_x_x812_symbol <= simple_obj_ref_162_request_815_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_active_
        simple_obj_ref_162_root_address_calculated_813_symbol <= Xentry_455_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_root_address_calculated
        simple_obj_ref_162_word_address_calculated_814_symbol <= simple_obj_ref_162_root_address_calculated_813_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_word_address_calculated
        simple_obj_ref_162_request_815: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request 
          signal simple_obj_ref_162_request_815_start: Boolean;
          signal Xentry_816_symbol: Boolean;
          signal Xexit_817_symbol: Boolean;
          signal split_req_818_symbol : Boolean;
          signal split_ack_819_symbol : Boolean;
          signal word_access_820_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_162_request_815_start <= simple_obj_ref_162_trigger_x_x811_symbol; -- control passed to block
          Xentry_816_symbol  <= simple_obj_ref_162_request_815_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/$entry
          split_req_818_symbol <= Xentry_816_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/split_req
          simple_obj_ref_162_gather_scatter_req_0 <= split_req_818_symbol; -- link to DP
          split_ack_819_symbol <= simple_obj_ref_162_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/split_ack
          word_access_820: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access 
            signal word_access_820_start: Boolean;
            signal Xentry_821_symbol: Boolean;
            signal Xexit_822_symbol: Boolean;
            signal word_access_0_823_symbol : Boolean;
            -- 
          begin -- 
            word_access_820_start <= split_ack_819_symbol; -- control passed to block
            Xentry_821_symbol  <= word_access_820_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/$entry
            word_access_0_823: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/word_access_0 
              signal word_access_0_823_start: Boolean;
              signal Xentry_824_symbol: Boolean;
              signal Xexit_825_symbol: Boolean;
              signal rr_826_symbol : Boolean;
              signal ra_827_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_823_start <= Xentry_821_symbol; -- control passed to block
              Xentry_824_symbol  <= word_access_0_823_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/word_access_0/$entry
              rr_826_symbol <= Xentry_824_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/word_access_0/rr
              simple_obj_ref_162_store_0_req_0 <= rr_826_symbol; -- link to DP
              ra_827_symbol <= simple_obj_ref_162_store_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/word_access_0/ra
              Xexit_825_symbol <= ra_827_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/word_access_0/$exit
              word_access_0_823_symbol <= Xexit_825_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/word_access_0
            Xexit_822_symbol <= word_access_0_823_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access/$exit
            word_access_820_symbol <= Xexit_822_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/word_access
          Xexit_817_symbol <= word_access_820_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request/$exit
          simple_obj_ref_162_request_815_symbol <= Xexit_817_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_request
        simple_obj_ref_162_complete_828: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete 
          signal simple_obj_ref_162_complete_828_start: Boolean;
          signal Xentry_829_symbol: Boolean;
          signal Xexit_830_symbol: Boolean;
          signal word_access_831_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_162_complete_828_start <= simple_obj_ref_162_active_x_x812_symbol; -- control passed to block
          Xentry_829_symbol  <= simple_obj_ref_162_complete_828_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/$entry
          word_access_831: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access 
            signal word_access_831_start: Boolean;
            signal Xentry_832_symbol: Boolean;
            signal Xexit_833_symbol: Boolean;
            signal word_access_0_834_symbol : Boolean;
            -- 
          begin -- 
            word_access_831_start <= Xentry_829_symbol; -- control passed to block
            Xentry_832_symbol  <= word_access_831_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/$entry
            word_access_0_834: Block -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/word_access_0 
              signal word_access_0_834_start: Boolean;
              signal Xentry_835_symbol: Boolean;
              signal Xexit_836_symbol: Boolean;
              signal cr_837_symbol : Boolean;
              signal ca_838_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_834_start <= Xentry_832_symbol; -- control passed to block
              Xentry_835_symbol  <= word_access_0_834_start; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/word_access_0/$entry
              cr_837_symbol <= Xentry_835_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/word_access_0/cr
              simple_obj_ref_162_store_0_req_1 <= cr_837_symbol; -- link to DP
              ca_838_symbol <= simple_obj_ref_162_store_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/word_access_0/ca
              Xexit_836_symbol <= ca_838_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/word_access_0/$exit
              word_access_0_834_symbol <= Xexit_836_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/word_access_0
            Xexit_833_symbol <= word_access_0_834_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access/$exit
            word_access_831_symbol <= Xexit_833_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/word_access
          Xexit_830_symbol <= word_access_831_symbol; -- transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete/$exit
          simple_obj_ref_162_complete_828_symbol <= Xexit_830_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/simple_obj_ref_162_complete
        Xexit_456_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/$exit 
          signal Xexit_456_predecessors: BooleanArray(8 downto 0);
          -- 
        begin -- 
          Xexit_456_predecessors(0) <= assign_stmt_122_completed_x_x458_symbol;
          Xexit_456_predecessors(1) <= ptr_deref_120_base_address_calculated_462_symbol;
          Xexit_456_predecessors(2) <= assign_stmt_135_completed_x_x535_symbol;
          Xexit_456_predecessors(3) <= ptr_deref_133_base_address_calculated_539_symbol;
          Xexit_456_predecessors(4) <= ptr_deref_138_base_address_calculated_600_symbol;
          Xexit_456_predecessors(5) <= ptr_deref_142_base_address_calculated_661_symbol;
          Xexit_456_predecessors(6) <= assign_stmt_157_completed_x_x732_symbol;
          Xexit_456_predecessors(7) <= ptr_deref_160_base_address_calculated_751_symbol;
          Xexit_456_predecessors(8) <= assign_stmt_164_completed_x_x809_symbol;
          Xexit_456_join: join -- 
            port map( -- 
              preds => Xexit_456_predecessors,
              symbol_out => Xexit_456_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164/$exit
        assign_stmt_114_to_assign_stmt_164_454_symbol <= Xexit_456_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_114_to_assign_stmt_164
      assign_stmt_169_839: Block -- branch_block_stmt_108/assign_stmt_169 
        signal assign_stmt_169_839_start: Boolean;
        signal Xentry_840_symbol: Boolean;
        signal Xexit_841_symbol: Boolean;
        signal assign_stmt_169_active_x_x842_symbol : Boolean;
        signal assign_stmt_169_completed_x_x843_symbol : Boolean;
        signal simple_obj_ref_168_trigger_x_x844_symbol : Boolean;
        signal simple_obj_ref_168_active_x_x845_symbol : Boolean;
        signal simple_obj_ref_168_root_address_calculated_846_symbol : Boolean;
        signal simple_obj_ref_168_word_address_calculated_847_symbol : Boolean;
        signal simple_obj_ref_168_request_848_symbol : Boolean;
        signal simple_obj_ref_168_complete_859_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_169_839_start <= assign_stmt_169_x_xentry_x_xx_x452_symbol; -- control passed to block
        Xentry_840_symbol  <= assign_stmt_169_839_start; -- transition branch_block_stmt_108/assign_stmt_169/$entry
        assign_stmt_169_active_x_x842_symbol <= simple_obj_ref_168_complete_859_symbol; -- transition branch_block_stmt_108/assign_stmt_169/assign_stmt_169_active_
        assign_stmt_169_completed_x_x843_symbol <= assign_stmt_169_active_x_x842_symbol; -- transition branch_block_stmt_108/assign_stmt_169/assign_stmt_169_completed_
        simple_obj_ref_168_trigger_x_x844_symbol <= simple_obj_ref_168_word_address_calculated_847_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_trigger_
        simple_obj_ref_168_active_x_x845_symbol <= simple_obj_ref_168_request_848_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_active_
        simple_obj_ref_168_root_address_calculated_846_symbol <= Xentry_840_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_root_address_calculated
        simple_obj_ref_168_word_address_calculated_847_symbol <= simple_obj_ref_168_root_address_calculated_846_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_word_address_calculated
        simple_obj_ref_168_request_848: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request 
          signal simple_obj_ref_168_request_848_start: Boolean;
          signal Xentry_849_symbol: Boolean;
          signal Xexit_850_symbol: Boolean;
          signal word_access_851_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_168_request_848_start <= simple_obj_ref_168_trigger_x_x844_symbol; -- control passed to block
          Xentry_849_symbol  <= simple_obj_ref_168_request_848_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/$entry
          word_access_851: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access 
            signal word_access_851_start: Boolean;
            signal Xentry_852_symbol: Boolean;
            signal Xexit_853_symbol: Boolean;
            signal word_access_0_854_symbol : Boolean;
            -- 
          begin -- 
            word_access_851_start <= Xentry_849_symbol; -- control passed to block
            Xentry_852_symbol  <= word_access_851_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/$entry
            word_access_0_854: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/word_access_0 
              signal word_access_0_854_start: Boolean;
              signal Xentry_855_symbol: Boolean;
              signal Xexit_856_symbol: Boolean;
              signal rr_857_symbol : Boolean;
              signal ra_858_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_854_start <= Xentry_852_symbol; -- control passed to block
              Xentry_855_symbol  <= word_access_0_854_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/word_access_0/$entry
              rr_857_symbol <= Xentry_855_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/word_access_0/rr
              simple_obj_ref_168_load_0_req_0 <= rr_857_symbol; -- link to DP
              ra_858_symbol <= simple_obj_ref_168_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/word_access_0/ra
              Xexit_856_symbol <= ra_858_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/word_access_0/$exit
              word_access_0_854_symbol <= Xexit_856_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/word_access_0
            Xexit_853_symbol <= word_access_0_854_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access/$exit
            word_access_851_symbol <= Xexit_853_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/word_access
          Xexit_850_symbol <= word_access_851_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request/$exit
          simple_obj_ref_168_request_848_symbol <= Xexit_850_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_request
        simple_obj_ref_168_complete_859: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete 
          signal simple_obj_ref_168_complete_859_start: Boolean;
          signal Xentry_860_symbol: Boolean;
          signal Xexit_861_symbol: Boolean;
          signal word_access_862_symbol : Boolean;
          signal merge_req_870_symbol : Boolean;
          signal merge_ack_871_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_168_complete_859_start <= simple_obj_ref_168_active_x_x845_symbol; -- control passed to block
          Xentry_860_symbol  <= simple_obj_ref_168_complete_859_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/$entry
          word_access_862: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access 
            signal word_access_862_start: Boolean;
            signal Xentry_863_symbol: Boolean;
            signal Xexit_864_symbol: Boolean;
            signal word_access_0_865_symbol : Boolean;
            -- 
          begin -- 
            word_access_862_start <= Xentry_860_symbol; -- control passed to block
            Xentry_863_symbol  <= word_access_862_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/$entry
            word_access_0_865: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/word_access_0 
              signal word_access_0_865_start: Boolean;
              signal Xentry_866_symbol: Boolean;
              signal Xexit_867_symbol: Boolean;
              signal cr_868_symbol : Boolean;
              signal ca_869_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_865_start <= Xentry_863_symbol; -- control passed to block
              Xentry_866_symbol  <= word_access_0_865_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/word_access_0/$entry
              cr_868_symbol <= Xentry_866_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/word_access_0/cr
              simple_obj_ref_168_load_0_req_1 <= cr_868_symbol; -- link to DP
              ca_869_symbol <= simple_obj_ref_168_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/word_access_0/ca
              Xexit_867_symbol <= ca_869_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/word_access_0/$exit
              word_access_0_865_symbol <= Xexit_867_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/word_access_0
            Xexit_864_symbol <= word_access_0_865_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access/$exit
            word_access_862_symbol <= Xexit_864_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/word_access
          merge_req_870_symbol <= word_access_862_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/merge_req
          simple_obj_ref_168_gather_scatter_req_0 <= merge_req_870_symbol; -- link to DP
          merge_ack_871_symbol <= simple_obj_ref_168_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/merge_ack
          Xexit_861_symbol <= merge_ack_871_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete/$exit
          simple_obj_ref_168_complete_859_symbol <= Xexit_861_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168_complete
        Xexit_841_symbol <= assign_stmt_169_completed_x_x843_symbol; -- transition branch_block_stmt_108/assign_stmt_169/$exit
        assign_stmt_169_839_symbol <= Xexit_841_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_169
      return_x_xx_xPhiReq_872: Block -- branch_block_stmt_108/return___PhiReq 
        signal return_x_xx_xPhiReq_872_start: Boolean;
        signal Xentry_873_symbol: Boolean;
        signal Xexit_874_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_872_start <= return_x_xx_x450_symbol; -- control passed to block
        Xentry_873_symbol  <= return_x_xx_xPhiReq_872_start; -- transition branch_block_stmt_108/return___PhiReq/$entry
        Xexit_874_symbol <= Xentry_873_symbol; -- transition branch_block_stmt_108/return___PhiReq/$exit
        return_x_xx_xPhiReq_872_symbol <= Xexit_874_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/return___PhiReq
      merge_stmt_166_PhiReqMerge_875_symbol  <=  return_x_xx_xPhiReq_872_symbol; -- place branch_block_stmt_108/merge_stmt_166_PhiReqMerge (optimized away) 
      merge_stmt_166_PhiAck_876: Block -- branch_block_stmt_108/merge_stmt_166_PhiAck 
        signal merge_stmt_166_PhiAck_876_start: Boolean;
        signal Xentry_877_symbol: Boolean;
        signal Xexit_878_symbol: Boolean;
        signal dummy_879_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_166_PhiAck_876_start <= merge_stmt_166_PhiReqMerge_875_symbol; -- control passed to block
        Xentry_877_symbol  <= merge_stmt_166_PhiAck_876_start; -- transition branch_block_stmt_108/merge_stmt_166_PhiAck/$entry
        dummy_879_symbol <= Xentry_877_symbol; -- transition branch_block_stmt_108/merge_stmt_166_PhiAck/dummy
        Xexit_878_symbol <= dummy_879_symbol; -- transition branch_block_stmt_108/merge_stmt_166_PhiAck/$exit
        merge_stmt_166_PhiAck_876_symbol <= Xexit_878_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/merge_stmt_166_PhiAck
      Xexit_445_symbol <= branch_block_stmt_108_x_xexit_x_xx_x447_symbol; -- transition branch_block_stmt_108/$exit
      branch_block_stmt_108_443_symbol <= Xexit_445_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_108
    Xexit_442_symbol <= branch_block_stmt_108_443_symbol; -- transition $exit
    fin  <=  '1' when Xexit_442_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal b_118 : std_logic_vector(31 downto 0);
    signal iNsTr_0_114 : std_logic_vector(31 downto 0);
    signal iNsTr_10_161 : std_logic_vector(31 downto 0);
    signal iNsTr_2_127 : std_logic_vector(31 downto 0);
    signal iNsTr_3_131 : std_logic_vector(31 downto 0);
    signal iNsTr_5_139 : std_logic_vector(31 downto 0);
    signal iNsTr_6_143 : std_logic_vector(31 downto 0);
    signal iNsTr_7_148 : std_logic_vector(31 downto 0);
    signal iNsTr_8_153 : std_logic_vector(31 downto 0);
    signal ptr_deref_120_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_120_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_120_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_120_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_120_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_120_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_120_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_120_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_120_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_133_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_133_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_133_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_133_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_133_wire : std_logic_vector(31 downto 0);
    signal ptr_deref_133_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_133_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_133_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_133_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_138_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_138_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_138_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_138_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_138_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_138_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_138_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_138_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_142_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_142_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_142_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_142_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_142_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_142_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_142_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_142_word_address_3 : std_logic_vector(4 downto 0);
    signal ptr_deref_160_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_160_data_1 : std_logic_vector(7 downto 0);
    signal ptr_deref_160_data_2 : std_logic_vector(7 downto 0);
    signal ptr_deref_160_data_3 : std_logic_vector(7 downto 0);
    signal ptr_deref_160_word_address_0 : std_logic_vector(4 downto 0);
    signal ptr_deref_160_word_address_1 : std_logic_vector(4 downto 0);
    signal ptr_deref_160_word_address_2 : std_logic_vector(4 downto 0);
    signal ptr_deref_160_word_address_3 : std_logic_vector(4 downto 0);
    signal simple_obj_ref_129_wire : std_logic_vector(31 downto 0);
    signal simple_obj_ref_162_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_162_word_address_0 : std_logic_vector(0 downto 0);
    signal simple_obj_ref_168_data_0 : std_logic_vector(31 downto 0);
    signal simple_obj_ref_168_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_156_wire : std_logic_vector(31 downto 0);
    signal xxfooxxbodyxxb_alloc_base_address : std_logic_vector(4 downto 0);
    signal xxfooxxbodyxxiNsTr_0_alloc_base_address : std_logic_vector(4 downto 0);
    signal xxfooxxstored_ret_val_x_xx_xbase_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    b_118 <= "00000000000000000000000000001101";
    iNsTr_0_114 <= "00000000000000000000000000001001";
    iNsTr_2_127 <= "00000000000000000000000000000000";
    iNsTr_8_153 <= "00000000000000000000000000000000";
    ptr_deref_120_word_address_0 <= "01001";
    ptr_deref_120_word_address_1 <= "01010";
    ptr_deref_120_word_address_2 <= "01011";
    ptr_deref_120_word_address_3 <= "01100";
    ptr_deref_133_word_address_0 <= "01101";
    ptr_deref_133_word_address_1 <= "01110";
    ptr_deref_133_word_address_2 <= "01111";
    ptr_deref_133_word_address_3 <= "10000";
    ptr_deref_138_word_address_0 <= "01001";
    ptr_deref_138_word_address_1 <= "01010";
    ptr_deref_138_word_address_2 <= "01011";
    ptr_deref_138_word_address_3 <= "01100";
    ptr_deref_142_word_address_0 <= "01101";
    ptr_deref_142_word_address_1 <= "01110";
    ptr_deref_142_word_address_2 <= "01111";
    ptr_deref_142_word_address_3 <= "10000";
    ptr_deref_160_word_address_0 <= "01001";
    ptr_deref_160_word_address_1 <= "01010";
    ptr_deref_160_word_address_2 <= "01011";
    ptr_deref_160_word_address_3 <= "01100";
    simple_obj_ref_162_word_address_0 <= "0";
    simple_obj_ref_168_word_address_0 <= "0";
    xxfooxxbodyxxb_alloc_base_address <= "01101";
    xxfooxxbodyxxiNsTr_0_alloc_base_address <= "01001";
    xxfooxxstored_ret_val_x_xx_xbase_address <= "0";
    type_cast_130_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => simple_obj_ref_129_wire, dout => iNsTr_3_131, req => type_cast_130_inst_req_0, ack => type_cast_130_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_156_inst: RegisterBase generic map(in_data_width => 32,out_data_width => 32) -- 
      port map( din => iNsTr_7_148, dout => type_cast_156_wire, req => type_cast_156_inst_req_0, ack => type_cast_156_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_120_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_120_gather_scatter_ack_0 <= ptr_deref_120_gather_scatter_req_0;
      aggregated_sig <= a;
      ptr_deref_120_data_0 <= aggregated_sig(31 downto 24);
      ptr_deref_120_data_1 <= aggregated_sig(23 downto 16);
      ptr_deref_120_data_2 <= aggregated_sig(15 downto 8);
      ptr_deref_120_data_3 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_133_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_133_gather_scatter_ack_0 <= ptr_deref_133_gather_scatter_req_0;
      aggregated_sig <= iNsTr_3_131;
      ptr_deref_133_data_0 <= aggregated_sig(31 downto 24);
      ptr_deref_133_data_1 <= aggregated_sig(23 downto 16);
      ptr_deref_133_data_2 <= aggregated_sig(15 downto 8);
      ptr_deref_133_data_3 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_138_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_138_gather_scatter_ack_0 <= ptr_deref_138_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_138_data_0 & ptr_deref_138_data_1 & ptr_deref_138_data_2 & ptr_deref_138_data_3;
      iNsTr_5_139 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_142_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_142_gather_scatter_ack_0 <= ptr_deref_142_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_142_data_0 & ptr_deref_142_data_1 & ptr_deref_142_data_2 & ptr_deref_142_data_3;
      iNsTr_6_143 <= aggregated_sig(31 downto 0);
      --
    end Block;
    ptr_deref_160_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      ptr_deref_160_gather_scatter_ack_0 <= ptr_deref_160_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_160_data_0 & ptr_deref_160_data_1 & ptr_deref_160_data_2 & ptr_deref_160_data_3;
      iNsTr_10_161 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_162_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_162_gather_scatter_ack_0 <= simple_obj_ref_162_gather_scatter_req_0;
      aggregated_sig <= iNsTr_10_161;
      simple_obj_ref_162_data_0 <= aggregated_sig(31 downto 0);
      --
    end Block;
    simple_obj_ref_168_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(31 downto 0); --
    begin -- 
      simple_obj_ref_168_gather_scatter_ack_0 <= simple_obj_ref_168_gather_scatter_req_0;
      aggregated_sig <= simple_obj_ref_168_data_0;
      ret_val_x_x <= aggregated_sig(31 downto 0);
      --
    end Block;
    -- shared split operator group (0) : binary_147_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_5_139 & iNsTr_6_143;
      iNsTr_7_148 <= data_out(31 downto 0);
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
          reqL => binary_147_inst_req_0,
          ackL => binary_147_inst_ack_0,
          reqR => binary_147_inst_req_1,
          ackR => binary_147_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared load operator group (0) : ptr_deref_138_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_138_load_0_req_0;
      ptr_deref_138_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_138_load_0_req_1;
      ptr_deref_138_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_138_word_address_0;
      ptr_deref_138_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(11),
          mack => memory_space_0_lr_ack(11),
          maddr => memory_space_0_lr_addr(59 downto 55),
          mtag => memory_space_0_lr_tag(11 downto 11),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(11),
          mack => memory_space_0_lc_ack(11),
          mdata => memory_space_0_lc_data(95 downto 88),
          mtag => memory_space_0_lc_tag(11 downto 11),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_138_load_1 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_138_load_1_req_0;
      ptr_deref_138_load_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_138_load_1_req_1;
      ptr_deref_138_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_138_word_address_1;
      ptr_deref_138_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(10),
          mack => memory_space_0_lr_ack(10),
          maddr => memory_space_0_lr_addr(54 downto 50),
          mtag => memory_space_0_lr_tag(10 downto 10),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(10),
          mack => memory_space_0_lc_ack(10),
          mdata => memory_space_0_lc_data(87 downto 80),
          mtag => memory_space_0_lc_tag(10 downto 10),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : ptr_deref_138_load_2 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_138_load_2_req_0;
      ptr_deref_138_load_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_138_load_2_req_1;
      ptr_deref_138_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_138_word_address_2;
      ptr_deref_138_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(9),
          mack => memory_space_0_lr_ack(9),
          maddr => memory_space_0_lr_addr(49 downto 45),
          mtag => memory_space_0_lr_tag(9 downto 9),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(9),
          mack => memory_space_0_lc_ack(9),
          mdata => memory_space_0_lc_data(79 downto 72),
          mtag => memory_space_0_lc_tag(9 downto 9),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : ptr_deref_138_load_3 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_138_load_3_req_0;
      ptr_deref_138_load_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_138_load_3_req_1;
      ptr_deref_138_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_138_word_address_3;
      ptr_deref_138_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(8),
          mack => memory_space_0_lr_ack(8),
          maddr => memory_space_0_lr_addr(44 downto 40),
          mtag => memory_space_0_lr_tag(8 downto 8),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(8),
          mack => memory_space_0_lc_ack(8),
          mdata => memory_space_0_lc_data(71 downto 64),
          mtag => memory_space_0_lc_tag(8 downto 8),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 3
    -- shared load operator group (4) : ptr_deref_142_load_0 
    LoadGroup4: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_142_load_0_req_0;
      ptr_deref_142_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_142_load_0_req_1;
      ptr_deref_142_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_142_word_address_0;
      ptr_deref_142_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(7),
          mack => memory_space_0_lr_ack(7),
          maddr => memory_space_0_lr_addr(39 downto 35),
          mtag => memory_space_0_lr_tag(7 downto 7),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(7),
          mack => memory_space_0_lc_ack(7),
          mdata => memory_space_0_lc_data(63 downto 56),
          mtag => memory_space_0_lc_tag(7 downto 7),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 4
    -- shared load operator group (5) : ptr_deref_142_load_1 
    LoadGroup5: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_142_load_1_req_0;
      ptr_deref_142_load_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_142_load_1_req_1;
      ptr_deref_142_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_142_word_address_1;
      ptr_deref_142_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(6),
          mack => memory_space_0_lr_ack(6),
          maddr => memory_space_0_lr_addr(34 downto 30),
          mtag => memory_space_0_lr_tag(6 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(6),
          mack => memory_space_0_lc_ack(6),
          mdata => memory_space_0_lc_data(55 downto 48),
          mtag => memory_space_0_lc_tag(6 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 5
    -- shared load operator group (6) : ptr_deref_142_load_2 
    LoadGroup6: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_142_load_2_req_0;
      ptr_deref_142_load_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_142_load_2_req_1;
      ptr_deref_142_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_142_word_address_2;
      ptr_deref_142_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(5),
          mack => memory_space_0_lr_ack(5),
          maddr => memory_space_0_lr_addr(29 downto 25),
          mtag => memory_space_0_lr_tag(5 downto 5),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(5),
          mack => memory_space_0_lc_ack(5),
          mdata => memory_space_0_lc_data(47 downto 40),
          mtag => memory_space_0_lc_tag(5 downto 5),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 6
    -- shared load operator group (7) : ptr_deref_142_load_3 
    LoadGroup7: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_142_load_3_req_0;
      ptr_deref_142_load_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_142_load_3_req_1;
      ptr_deref_142_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_142_word_address_3;
      ptr_deref_142_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(4),
          mack => memory_space_0_lr_ack(4),
          maddr => memory_space_0_lr_addr(24 downto 20),
          mtag => memory_space_0_lr_tag(4 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(4),
          mack => memory_space_0_lc_ack(4),
          mdata => memory_space_0_lc_data(39 downto 32),
          mtag => memory_space_0_lc_tag(4 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 7
    -- shared load operator group (8) : ptr_deref_160_load_0 
    LoadGroup8: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_160_load_0_req_0;
      ptr_deref_160_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_160_load_0_req_1;
      ptr_deref_160_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_0;
      ptr_deref_160_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(3),
          mack => memory_space_0_lr_ack(3),
          maddr => memory_space_0_lr_addr(19 downto 15),
          mtag => memory_space_0_lr_tag(3 downto 3),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(3),
          mack => memory_space_0_lc_ack(3),
          mdata => memory_space_0_lc_data(31 downto 24),
          mtag => memory_space_0_lc_tag(3 downto 3),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 8
    -- shared load operator group (9) : ptr_deref_160_load_1 
    LoadGroup9: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_160_load_1_req_0;
      ptr_deref_160_load_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_160_load_1_req_1;
      ptr_deref_160_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_1;
      ptr_deref_160_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(2),
          mack => memory_space_0_lr_ack(2),
          maddr => memory_space_0_lr_addr(14 downto 10),
          mtag => memory_space_0_lr_tag(2 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(2),
          mack => memory_space_0_lc_ack(2),
          mdata => memory_space_0_lc_data(23 downto 16),
          mtag => memory_space_0_lc_tag(2 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 9
    -- shared load operator group (10) : ptr_deref_160_load_2 
    LoadGroup10: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_160_load_2_req_0;
      ptr_deref_160_load_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_160_load_2_req_1;
      ptr_deref_160_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_2;
      ptr_deref_160_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(1),
          mack => memory_space_0_lr_ack(1),
          maddr => memory_space_0_lr_addr(9 downto 5),
          mtag => memory_space_0_lr_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(1),
          mack => memory_space_0_lc_ack(1),
          mdata => memory_space_0_lc_data(15 downto 8),
          mtag => memory_space_0_lc_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 10
    -- shared load operator group (11) : ptr_deref_160_load_3 
    LoadGroup11: Block -- 
      signal data_in: std_logic_vector(4 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_160_load_3_req_0;
      ptr_deref_160_load_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_160_load_3_req_1;
      ptr_deref_160_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_3;
      ptr_deref_160_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(4 downto 0),
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
    end Block; -- load group 11
    -- shared load operator group (12) : simple_obj_ref_168_load_0 
    LoadGroup12: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_168_load_0_req_0;
      simple_obj_ref_168_load_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_168_load_0_req_1;
      simple_obj_ref_168_load_0_ack_1 <= ackR(0);
      data_in <= simple_obj_ref_168_word_address_0;
      simple_obj_ref_168_data_0 <= data_out(31 downto 0);
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
    end Block; -- load group 12
    -- shared store operator group (0) : ptr_deref_120_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_120_store_0_req_0;
      ptr_deref_120_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_120_store_0_req_1;
      ptr_deref_120_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_120_word_address_0;
      data_in <= ptr_deref_120_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(7),
          mack => memory_space_0_sr_ack(7),
          maddr => memory_space_0_sr_addr(39 downto 35),
          mdata => memory_space_0_sr_data(63 downto 56),
          mtag => memory_space_0_sr_tag(7 downto 7),
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
          mreq => memory_space_0_sc_req(7),
          mack => memory_space_0_sc_ack(7),
          mtag => memory_space_0_sc_tag(7 downto 7),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_120_store_1 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_120_store_1_req_0;
      ptr_deref_120_store_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_120_store_1_req_1;
      ptr_deref_120_store_1_ack_1 <= ackR(0);
      addr_in <= ptr_deref_120_word_address_1;
      data_in <= ptr_deref_120_data_1;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(6),
          mack => memory_space_0_sr_ack(6),
          maddr => memory_space_0_sr_addr(34 downto 30),
          mdata => memory_space_0_sr_data(55 downto 48),
          mtag => memory_space_0_sr_tag(6 downto 6),
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
          mreq => memory_space_0_sc_req(6),
          mack => memory_space_0_sc_ack(6),
          mtag => memory_space_0_sc_tag(6 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : ptr_deref_120_store_2 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_120_store_2_req_0;
      ptr_deref_120_store_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_120_store_2_req_1;
      ptr_deref_120_store_2_ack_1 <= ackR(0);
      addr_in <= ptr_deref_120_word_address_2;
      data_in <= ptr_deref_120_data_2;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(5),
          mack => memory_space_0_sr_ack(5),
          maddr => memory_space_0_sr_addr(29 downto 25),
          mdata => memory_space_0_sr_data(47 downto 40),
          mtag => memory_space_0_sr_tag(5 downto 5),
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
          mreq => memory_space_0_sc_req(5),
          mack => memory_space_0_sc_ack(5),
          mtag => memory_space_0_sc_tag(5 downto 5),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared store operator group (3) : ptr_deref_120_store_3 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_120_store_3_req_0;
      ptr_deref_120_store_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_120_store_3_req_1;
      ptr_deref_120_store_3_ack_1 <= ackR(0);
      addr_in <= ptr_deref_120_word_address_3;
      data_in <= ptr_deref_120_data_3;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(4),
          mack => memory_space_0_sr_ack(4),
          maddr => memory_space_0_sr_addr(24 downto 20),
          mdata => memory_space_0_sr_data(39 downto 32),
          mtag => memory_space_0_sr_tag(4 downto 4),
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
          mreq => memory_space_0_sc_req(4),
          mack => memory_space_0_sc_ack(4),
          mtag => memory_space_0_sc_tag(4 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 3
    -- shared store operator group (4) : ptr_deref_133_store_0 
    StoreGroup4: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_133_store_0_req_0;
      ptr_deref_133_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_133_store_0_req_1;
      ptr_deref_133_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_0;
      data_in <= ptr_deref_133_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(3),
          mack => memory_space_0_sr_ack(3),
          maddr => memory_space_0_sr_addr(19 downto 15),
          mdata => memory_space_0_sr_data(31 downto 24),
          mtag => memory_space_0_sr_tag(3 downto 3),
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
          mreq => memory_space_0_sc_req(3),
          mack => memory_space_0_sc_ack(3),
          mtag => memory_space_0_sc_tag(3 downto 3),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 4
    -- shared store operator group (5) : ptr_deref_133_store_1 
    StoreGroup5: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_133_store_1_req_0;
      ptr_deref_133_store_1_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_133_store_1_req_1;
      ptr_deref_133_store_1_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_1;
      data_in <= ptr_deref_133_data_1;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(2),
          mack => memory_space_0_sr_ack(2),
          maddr => memory_space_0_sr_addr(14 downto 10),
          mdata => memory_space_0_sr_data(23 downto 16),
          mtag => memory_space_0_sr_tag(2 downto 2),
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
          mreq => memory_space_0_sc_req(2),
          mack => memory_space_0_sc_ack(2),
          mtag => memory_space_0_sc_tag(2 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 5
    -- shared store operator group (6) : ptr_deref_133_store_2 
    StoreGroup6: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_133_store_2_req_0;
      ptr_deref_133_store_2_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_133_store_2_req_1;
      ptr_deref_133_store_2_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_2;
      data_in <= ptr_deref_133_data_2;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_0_sr_req(1),
          mack => memory_space_0_sr_ack(1),
          maddr => memory_space_0_sr_addr(9 downto 5),
          mdata => memory_space_0_sr_data(15 downto 8),
          mtag => memory_space_0_sr_tag(1 downto 1),
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
          mreq => memory_space_0_sc_req(1),
          mack => memory_space_0_sc_ack(1),
          mtag => memory_space_0_sc_tag(1 downto 1),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 6
    -- shared store operator group (7) : ptr_deref_133_store_3 
    StoreGroup7: Block -- 
      signal addr_in: std_logic_vector(4 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_133_store_3_req_0;
      ptr_deref_133_store_3_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_133_store_3_req_1;
      ptr_deref_133_store_3_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_3;
      data_in <= ptr_deref_133_data_3;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
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
          maddr => memory_space_0_sr_addr(4 downto 0),
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
    end Block; -- store group 7
    -- shared store operator group (8) : simple_obj_ref_162_store_0 
    StoreGroup8: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= simple_obj_ref_162_store_0_req_0;
      simple_obj_ref_162_store_0_ack_0 <= ackL(0);
      reqR(0) <= simple_obj_ref_162_store_0_req_1;
      simple_obj_ref_162_store_0_ack_1 <= ackR(0);
      addr_in <= simple_obj_ref_162_word_address_0;
      data_in <= simple_obj_ref_162_data_0;
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
    end Block; -- store group 8
    -- shared inport operator group (0) : simple_obj_ref_129_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_129_inst_req_0;
      simple_obj_ref_129_inst_ack_0 <= ack(0);
      simple_obj_ref_129_wire <= data_out(31 downto 0);
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
    -- shared outport operator group (0) : simple_obj_ref_154_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_154_inst_req_0;
      simple_obj_ref_154_inst_ack_0 <= ack(0);
      data_in <= type_cast_156_wire;
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
    memory_space_0_lr_addr : out  std_logic_vector(4 downto 0);
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
  signal array_obj_ref_13_addr_0_req_0 : boolean;
  signal array_obj_ref_13_addr_0_ack_0 : boolean;
  signal binary_12_inst_req_0 : boolean;
  signal binary_12_inst_ack_0 : boolean;
  signal binary_10_inst_req_0 : boolean;
  signal binary_10_inst_ack_0 : boolean;
  signal binary_10_inst_req_1 : boolean;
  signal binary_10_inst_ack_1 : boolean;
  signal array_obj_ref_13_root_address_inst_req_0 : boolean;
  signal array_obj_ref_13_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_13_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_13_offset_inst_req_0 : boolean;
  signal array_obj_ref_13_offset_inst_ack_0 : boolean;
  signal array_obj_ref_13_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_13_index_0_rename_req_0 : boolean;
  signal binary_12_inst_req_1 : boolean;
  signal binary_12_inst_ack_1 : boolean;
  signal array_obj_ref_13_index_0_resize_req_0 : boolean;
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
  mem_load_x_xx_xCP_880: Block -- control-path 
    signal mem_load_x_xx_xCP_880_start: Boolean;
    signal Xentry_881_symbol: Boolean;
    signal Xexit_882_symbol: Boolean;
    signal assign_stmt_14_883_symbol : Boolean;
    -- 
  begin -- 
    mem_load_x_xx_xCP_880_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_881_symbol  <= mem_load_x_xx_xCP_880_start; -- transition $entry
    assign_stmt_14_883: Block -- assign_stmt_14 
      signal assign_stmt_14_883_start: Boolean;
      signal Xentry_884_symbol: Boolean;
      signal Xexit_885_symbol: Boolean;
      signal assign_stmt_14_active_x_x886_symbol : Boolean;
      signal assign_stmt_14_completed_x_x887_symbol : Boolean;
      signal array_obj_ref_13_trigger_x_x888_symbol : Boolean;
      signal array_obj_ref_13_active_x_x889_symbol : Boolean;
      signal array_obj_ref_13_root_address_calculated_890_symbol : Boolean;
      signal array_obj_ref_13_word_address_calculated_891_symbol : Boolean;
      signal array_obj_ref_13_indices_scaled_892_symbol : Boolean;
      signal array_obj_ref_13_offset_calculated_893_symbol : Boolean;
      signal array_obj_ref_13_index_computed_0_894_symbol : Boolean;
      signal array_obj_ref_13_index_resized_0_895_symbol : Boolean;
      signal binary_12_active_x_x896_symbol : Boolean;
      signal binary_12_trigger_x_x897_symbol : Boolean;
      signal binary_10_active_x_x898_symbol : Boolean;
      signal binary_10_trigger_x_x899_symbol : Boolean;
      signal simple_obj_ref_8_complete_900_symbol : Boolean;
      signal binary_10_complete_901_symbol : Boolean;
      signal binary_12_complete_908_symbol : Boolean;
      signal array_obj_ref_13_index_resize_0_915_symbol : Boolean;
      signal array_obj_ref_13_index_scale_0_920_symbol : Boolean;
      signal array_obj_ref_13_add_indices_925_symbol : Boolean;
      signal array_obj_ref_13_base_plus_offset_930_symbol : Boolean;
      signal array_obj_ref_13_word_addrgen_935_symbol : Boolean;
      signal array_obj_ref_13_request_940_symbol : Boolean;
      signal array_obj_ref_13_complete_951_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_14_883_start <= Xentry_881_symbol; -- control passed to block
      Xentry_884_symbol  <= assign_stmt_14_883_start; -- transition assign_stmt_14/$entry
      assign_stmt_14_active_x_x886_symbol <= array_obj_ref_13_complete_951_symbol; -- transition assign_stmt_14/assign_stmt_14_active_
      assign_stmt_14_completed_x_x887_symbol <= assign_stmt_14_active_x_x886_symbol; -- transition assign_stmt_14/assign_stmt_14_completed_
      array_obj_ref_13_trigger_x_x888_symbol <= array_obj_ref_13_word_address_calculated_891_symbol; -- transition assign_stmt_14/array_obj_ref_13_trigger_
      array_obj_ref_13_active_x_x889_symbol <= array_obj_ref_13_request_940_symbol; -- transition assign_stmt_14/array_obj_ref_13_active_
      array_obj_ref_13_root_address_calculated_890_symbol <= array_obj_ref_13_base_plus_offset_930_symbol; -- transition assign_stmt_14/array_obj_ref_13_root_address_calculated
      array_obj_ref_13_word_address_calculated_891_symbol <= array_obj_ref_13_word_addrgen_935_symbol; -- transition assign_stmt_14/array_obj_ref_13_word_address_calculated
      array_obj_ref_13_indices_scaled_892_symbol <= array_obj_ref_13_index_scale_0_920_symbol; -- transition assign_stmt_14/array_obj_ref_13_indices_scaled
      array_obj_ref_13_offset_calculated_893_symbol <= array_obj_ref_13_add_indices_925_symbol; -- transition assign_stmt_14/array_obj_ref_13_offset_calculated
      array_obj_ref_13_index_computed_0_894_symbol <= binary_12_complete_908_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_computed_0
      array_obj_ref_13_index_resized_0_895_symbol <= array_obj_ref_13_index_resize_0_915_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_resized_0
      binary_12_active_x_x896_block : Block -- non-trivial join transition assign_stmt_14/binary_12_active_ 
        signal binary_12_active_x_x896_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_12_active_x_x896_predecessors(0) <= binary_12_trigger_x_x897_symbol;
        binary_12_active_x_x896_predecessors(1) <= binary_10_complete_901_symbol;
        binary_12_active_x_x896_join: join -- 
          port map( -- 
            preds => binary_12_active_x_x896_predecessors,
            symbol_out => binary_12_active_x_x896_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_14/binary_12_active_
      binary_12_trigger_x_x897_symbol <= Xentry_884_symbol; -- transition assign_stmt_14/binary_12_trigger_
      binary_10_active_x_x898_block : Block -- non-trivial join transition assign_stmt_14/binary_10_active_ 
        signal binary_10_active_x_x898_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_10_active_x_x898_predecessors(0) <= binary_10_trigger_x_x899_symbol;
        binary_10_active_x_x898_predecessors(1) <= simple_obj_ref_8_complete_900_symbol;
        binary_10_active_x_x898_join: join -- 
          port map( -- 
            preds => binary_10_active_x_x898_predecessors,
            symbol_out => binary_10_active_x_x898_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_14/binary_10_active_
      binary_10_trigger_x_x899_symbol <= Xentry_884_symbol; -- transition assign_stmt_14/binary_10_trigger_
      simple_obj_ref_8_complete_900_symbol <= Xentry_884_symbol; -- transition assign_stmt_14/simple_obj_ref_8_complete
      binary_10_complete_901: Block -- assign_stmt_14/binary_10_complete 
        signal binary_10_complete_901_start: Boolean;
        signal Xentry_902_symbol: Boolean;
        signal Xexit_903_symbol: Boolean;
        signal rr_904_symbol : Boolean;
        signal ra_905_symbol : Boolean;
        signal cr_906_symbol : Boolean;
        signal ca_907_symbol : Boolean;
        -- 
      begin -- 
        binary_10_complete_901_start <= binary_10_active_x_x898_symbol; -- control passed to block
        Xentry_902_symbol  <= binary_10_complete_901_start; -- transition assign_stmt_14/binary_10_complete/$entry
        rr_904_symbol <= Xentry_902_symbol; -- transition assign_stmt_14/binary_10_complete/rr
        binary_10_inst_req_0 <= rr_904_symbol; -- link to DP
        ra_905_symbol <= binary_10_inst_ack_0; -- transition assign_stmt_14/binary_10_complete/ra
        cr_906_symbol <= ra_905_symbol; -- transition assign_stmt_14/binary_10_complete/cr
        binary_10_inst_req_1 <= cr_906_symbol; -- link to DP
        ca_907_symbol <= binary_10_inst_ack_1; -- transition assign_stmt_14/binary_10_complete/ca
        Xexit_903_symbol <= ca_907_symbol; -- transition assign_stmt_14/binary_10_complete/$exit
        binary_10_complete_901_symbol <= Xexit_903_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/binary_10_complete
      binary_12_complete_908: Block -- assign_stmt_14/binary_12_complete 
        signal binary_12_complete_908_start: Boolean;
        signal Xentry_909_symbol: Boolean;
        signal Xexit_910_symbol: Boolean;
        signal rr_911_symbol : Boolean;
        signal ra_912_symbol : Boolean;
        signal cr_913_symbol : Boolean;
        signal ca_914_symbol : Boolean;
        -- 
      begin -- 
        binary_12_complete_908_start <= binary_12_active_x_x896_symbol; -- control passed to block
        Xentry_909_symbol  <= binary_12_complete_908_start; -- transition assign_stmt_14/binary_12_complete/$entry
        rr_911_symbol <= Xentry_909_symbol; -- transition assign_stmt_14/binary_12_complete/rr
        binary_12_inst_req_0 <= rr_911_symbol; -- link to DP
        ra_912_symbol <= binary_12_inst_ack_0; -- transition assign_stmt_14/binary_12_complete/ra
        cr_913_symbol <= ra_912_symbol; -- transition assign_stmt_14/binary_12_complete/cr
        binary_12_inst_req_1 <= cr_913_symbol; -- link to DP
        ca_914_symbol <= binary_12_inst_ack_1; -- transition assign_stmt_14/binary_12_complete/ca
        Xexit_910_symbol <= ca_914_symbol; -- transition assign_stmt_14/binary_12_complete/$exit
        binary_12_complete_908_symbol <= Xexit_910_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/binary_12_complete
      array_obj_ref_13_index_resize_0_915: Block -- assign_stmt_14/array_obj_ref_13_index_resize_0 
        signal array_obj_ref_13_index_resize_0_915_start: Boolean;
        signal Xentry_916_symbol: Boolean;
        signal Xexit_917_symbol: Boolean;
        signal index_resize_req_918_symbol : Boolean;
        signal index_resize_ack_919_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_index_resize_0_915_start <= array_obj_ref_13_index_computed_0_894_symbol; -- control passed to block
        Xentry_916_symbol  <= array_obj_ref_13_index_resize_0_915_start; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/$entry
        index_resize_req_918_symbol <= Xentry_916_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/index_resize_req
        array_obj_ref_13_index_0_resize_req_0 <= index_resize_req_918_symbol; -- link to DP
        index_resize_ack_919_symbol <= array_obj_ref_13_index_0_resize_ack_0; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/index_resize_ack
        Xexit_917_symbol <= index_resize_ack_919_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_resize_0/$exit
        array_obj_ref_13_index_resize_0_915_symbol <= Xexit_917_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_index_resize_0
      array_obj_ref_13_index_scale_0_920: Block -- assign_stmt_14/array_obj_ref_13_index_scale_0 
        signal array_obj_ref_13_index_scale_0_920_start: Boolean;
        signal Xentry_921_symbol: Boolean;
        signal Xexit_922_symbol: Boolean;
        signal scale_rename_req_923_symbol : Boolean;
        signal scale_rename_ack_924_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_index_scale_0_920_start <= array_obj_ref_13_index_resized_0_895_symbol; -- control passed to block
        Xentry_921_symbol  <= array_obj_ref_13_index_scale_0_920_start; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/$entry
        scale_rename_req_923_symbol <= Xentry_921_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/scale_rename_req
        array_obj_ref_13_index_0_rename_req_0 <= scale_rename_req_923_symbol; -- link to DP
        scale_rename_ack_924_symbol <= array_obj_ref_13_index_0_rename_ack_0; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/scale_rename_ack
        Xexit_922_symbol <= scale_rename_ack_924_symbol; -- transition assign_stmt_14/array_obj_ref_13_index_scale_0/$exit
        array_obj_ref_13_index_scale_0_920_symbol <= Xexit_922_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_index_scale_0
      array_obj_ref_13_add_indices_925: Block -- assign_stmt_14/array_obj_ref_13_add_indices 
        signal array_obj_ref_13_add_indices_925_start: Boolean;
        signal Xentry_926_symbol: Boolean;
        signal Xexit_927_symbol: Boolean;
        signal final_index_req_928_symbol : Boolean;
        signal final_index_ack_929_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_add_indices_925_start <= array_obj_ref_13_indices_scaled_892_symbol; -- control passed to block
        Xentry_926_symbol  <= array_obj_ref_13_add_indices_925_start; -- transition assign_stmt_14/array_obj_ref_13_add_indices/$entry
        final_index_req_928_symbol <= Xentry_926_symbol; -- transition assign_stmt_14/array_obj_ref_13_add_indices/final_index_req
        array_obj_ref_13_offset_inst_req_0 <= final_index_req_928_symbol; -- link to DP
        final_index_ack_929_symbol <= array_obj_ref_13_offset_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13_add_indices/final_index_ack
        Xexit_927_symbol <= final_index_ack_929_symbol; -- transition assign_stmt_14/array_obj_ref_13_add_indices/$exit
        array_obj_ref_13_add_indices_925_symbol <= Xexit_927_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_add_indices
      array_obj_ref_13_base_plus_offset_930: Block -- assign_stmt_14/array_obj_ref_13_base_plus_offset 
        signal array_obj_ref_13_base_plus_offset_930_start: Boolean;
        signal Xentry_931_symbol: Boolean;
        signal Xexit_932_symbol: Boolean;
        signal sum_rename_req_933_symbol : Boolean;
        signal sum_rename_ack_934_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_base_plus_offset_930_start <= array_obj_ref_13_offset_calculated_893_symbol; -- control passed to block
        Xentry_931_symbol  <= array_obj_ref_13_base_plus_offset_930_start; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/$entry
        sum_rename_req_933_symbol <= Xentry_931_symbol; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/sum_rename_req
        array_obj_ref_13_root_address_inst_req_0 <= sum_rename_req_933_symbol; -- link to DP
        sum_rename_ack_934_symbol <= array_obj_ref_13_root_address_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/sum_rename_ack
        Xexit_932_symbol <= sum_rename_ack_934_symbol; -- transition assign_stmt_14/array_obj_ref_13_base_plus_offset/$exit
        array_obj_ref_13_base_plus_offset_930_symbol <= Xexit_932_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_base_plus_offset
      array_obj_ref_13_word_addrgen_935: Block -- assign_stmt_14/array_obj_ref_13_word_addrgen 
        signal array_obj_ref_13_word_addrgen_935_start: Boolean;
        signal Xentry_936_symbol: Boolean;
        signal Xexit_937_symbol: Boolean;
        signal root_rename_req_938_symbol : Boolean;
        signal root_rename_ack_939_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_word_addrgen_935_start <= array_obj_ref_13_root_address_calculated_890_symbol; -- control passed to block
        Xentry_936_symbol  <= array_obj_ref_13_word_addrgen_935_start; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/$entry
        root_rename_req_938_symbol <= Xentry_936_symbol; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/root_rename_req
        array_obj_ref_13_addr_0_req_0 <= root_rename_req_938_symbol; -- link to DP
        root_rename_ack_939_symbol <= array_obj_ref_13_addr_0_ack_0; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/root_rename_ack
        Xexit_937_symbol <= root_rename_ack_939_symbol; -- transition assign_stmt_14/array_obj_ref_13_word_addrgen/$exit
        array_obj_ref_13_word_addrgen_935_symbol <= Xexit_937_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_word_addrgen
      array_obj_ref_13_request_940: Block -- assign_stmt_14/array_obj_ref_13_request 
        signal array_obj_ref_13_request_940_start: Boolean;
        signal Xentry_941_symbol: Boolean;
        signal Xexit_942_symbol: Boolean;
        signal word_access_943_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_request_940_start <= array_obj_ref_13_trigger_x_x888_symbol; -- control passed to block
        Xentry_941_symbol  <= array_obj_ref_13_request_940_start; -- transition assign_stmt_14/array_obj_ref_13_request/$entry
        word_access_943: Block -- assign_stmt_14/array_obj_ref_13_request/word_access 
          signal word_access_943_start: Boolean;
          signal Xentry_944_symbol: Boolean;
          signal Xexit_945_symbol: Boolean;
          signal word_access_0_946_symbol : Boolean;
          -- 
        begin -- 
          word_access_943_start <= Xentry_941_symbol; -- control passed to block
          Xentry_944_symbol  <= word_access_943_start; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/$entry
          word_access_0_946: Block -- assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0 
            signal word_access_0_946_start: Boolean;
            signal Xentry_947_symbol: Boolean;
            signal Xexit_948_symbol: Boolean;
            signal rr_949_symbol : Boolean;
            signal ra_950_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_946_start <= Xentry_944_symbol; -- control passed to block
            Xentry_947_symbol  <= word_access_0_946_start; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/$entry
            rr_949_symbol <= Xentry_947_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/rr
            array_obj_ref_13_load_0_req_0 <= rr_949_symbol; -- link to DP
            ra_950_symbol <= array_obj_ref_13_load_0_ack_0; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/ra
            Xexit_948_symbol <= ra_950_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0/$exit
            word_access_0_946_symbol <= Xexit_948_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13_request/word_access/word_access_0
          Xexit_945_symbol <= word_access_0_946_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/word_access/$exit
          word_access_943_symbol <= Xexit_945_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_14/array_obj_ref_13_request/word_access
        Xexit_942_symbol <= word_access_943_symbol; -- transition assign_stmt_14/array_obj_ref_13_request/$exit
        array_obj_ref_13_request_940_symbol <= Xexit_942_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_request
      array_obj_ref_13_complete_951: Block -- assign_stmt_14/array_obj_ref_13_complete 
        signal array_obj_ref_13_complete_951_start: Boolean;
        signal Xentry_952_symbol: Boolean;
        signal Xexit_953_symbol: Boolean;
        signal word_access_954_symbol : Boolean;
        signal merge_req_962_symbol : Boolean;
        signal merge_ack_963_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_complete_951_start <= array_obj_ref_13_active_x_x889_symbol; -- control passed to block
        Xentry_952_symbol  <= array_obj_ref_13_complete_951_start; -- transition assign_stmt_14/array_obj_ref_13_complete/$entry
        word_access_954: Block -- assign_stmt_14/array_obj_ref_13_complete/word_access 
          signal word_access_954_start: Boolean;
          signal Xentry_955_symbol: Boolean;
          signal Xexit_956_symbol: Boolean;
          signal word_access_0_957_symbol : Boolean;
          -- 
        begin -- 
          word_access_954_start <= Xentry_952_symbol; -- control passed to block
          Xentry_955_symbol  <= word_access_954_start; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/$entry
          word_access_0_957: Block -- assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0 
            signal word_access_0_957_start: Boolean;
            signal Xentry_958_symbol: Boolean;
            signal Xexit_959_symbol: Boolean;
            signal cr_960_symbol : Boolean;
            signal ca_961_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_957_start <= Xentry_955_symbol; -- control passed to block
            Xentry_958_symbol  <= word_access_0_957_start; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/$entry
            cr_960_symbol <= Xentry_958_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/cr
            array_obj_ref_13_load_0_req_1 <= cr_960_symbol; -- link to DP
            ca_961_symbol <= array_obj_ref_13_load_0_ack_1; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/ca
            Xexit_959_symbol <= ca_961_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0/$exit
            word_access_0_957_symbol <= Xexit_959_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13_complete/word_access/word_access_0
          Xexit_956_symbol <= word_access_0_957_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/word_access/$exit
          word_access_954_symbol <= Xexit_956_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_14/array_obj_ref_13_complete/word_access
        merge_req_962_symbol <= word_access_954_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/merge_req
        array_obj_ref_13_gather_scatter_req_0 <= merge_req_962_symbol; -- link to DP
        merge_ack_963_symbol <= array_obj_ref_13_gather_scatter_ack_0; -- transition assign_stmt_14/array_obj_ref_13_complete/merge_ack
        Xexit_953_symbol <= merge_ack_963_symbol; -- transition assign_stmt_14/array_obj_ref_13_complete/$exit
        array_obj_ref_13_complete_951_symbol <= Xexit_953_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13_complete
      Xexit_885_symbol <= assign_stmt_14_completed_x_x887_symbol; -- transition assign_stmt_14/$exit
      assign_stmt_14_883_symbol <= Xexit_885_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_14
    Xexit_882_symbol <= assign_stmt_14_883_symbol; -- transition $exit
    fin  <=  '1' when Xexit_882_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_13_data_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_13_final_offset : std_logic_vector(4 downto 0);
    signal array_obj_ref_13_offset_scale_factor_0 : std_logic_vector(4 downto 0);
    signal array_obj_ref_13_resized_base_address : std_logic_vector(4 downto 0);
    signal array_obj_ref_13_root_address : std_logic_vector(4 downto 0);
    signal array_obj_ref_13_word_address_0 : std_logic_vector(4 downto 0);
    signal array_obj_ref_13_word_offset_0 : std_logic_vector(4 downto 0);
    signal binary_10_wire : std_logic_vector(31 downto 0);
    signal binary_12_resized : std_logic_vector(4 downto 0);
    signal binary_12_scaled : std_logic_vector(4 downto 0);
    signal binary_12_wire : std_logic_vector(31 downto 0);
    signal expr_11_wire_constant : std_logic_vector(31 downto 0);
    signal expr_9_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_13_offset_scale_factor_0 <= "00001";
    array_obj_ref_13_resized_base_address <= "00000";
    array_obj_ref_13_word_offset_0 <= "00000";
    expr_11_wire_constant <= "00000000000000000000000000000000";
    expr_9_wire_constant <= "00000000000000000000000000000001";
    array_obj_ref_13_index_0_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 5) -- 
      port map( din => binary_12_wire, dout => binary_12_resized, req => array_obj_ref_13_index_0_resize_req_0, ack => array_obj_ref_13_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_13_offset_inst: RegisterBase generic map(in_data_width => 5,out_data_width => 5) -- 
      port map( din => binary_12_scaled, dout => array_obj_ref_13_final_offset, req => array_obj_ref_13_offset_inst_req_0, ack => array_obj_ref_13_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_13_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(4 downto 0); --
    begin -- 
      array_obj_ref_13_addr_0_ack_0 <= array_obj_ref_13_addr_0_req_0;
      aggregated_sig <= array_obj_ref_13_root_address;
      array_obj_ref_13_word_address_0 <= aggregated_sig(4 downto 0);
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
      signal aggregated_sig: std_logic_vector(4 downto 0); --
    begin -- 
      array_obj_ref_13_index_0_rename_ack_0 <= array_obj_ref_13_index_0_rename_req_0;
      aggregated_sig <= binary_12_resized;
      binary_12_scaled <= aggregated_sig(4 downto 0);
      --
    end Block;
    array_obj_ref_13_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(4 downto 0); --
    begin -- 
      array_obj_ref_13_root_address_inst_ack_0 <= array_obj_ref_13_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_13_final_offset;
      array_obj_ref_13_root_address <= aggregated_sig(4 downto 0);
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
      signal data_in: std_logic_vector(4 downto 0);
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
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(4 downto 0),
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
    memory_space_0_sr_addr : out  std_logic_vector(4 downto 0);
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
  signal binary_21_inst_req_0 : boolean;
  signal binary_21_inst_ack_0 : boolean;
  signal binary_21_inst_req_1 : boolean;
  signal binary_21_inst_ack_1 : boolean;
  signal binary_23_inst_req_0 : boolean;
  signal binary_23_inst_ack_0 : boolean;
  signal binary_23_inst_req_1 : boolean;
  signal binary_23_inst_ack_1 : boolean;
  signal array_obj_ref_24_index_0_resize_req_0 : boolean;
  signal array_obj_ref_24_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_24_index_0_rename_req_0 : boolean;
  signal array_obj_ref_24_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_24_offset_inst_req_0 : boolean;
  signal array_obj_ref_24_offset_inst_ack_0 : boolean;
  signal array_obj_ref_24_root_address_inst_req_0 : boolean;
  signal array_obj_ref_24_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_24_addr_0_req_0 : boolean;
  signal array_obj_ref_24_addr_0_ack_0 : boolean;
  signal array_obj_ref_24_gather_scatter_req_0 : boolean;
  signal array_obj_ref_24_gather_scatter_ack_0 : boolean;
  signal array_obj_ref_24_store_0_req_0 : boolean;
  signal array_obj_ref_24_store_0_ack_0 : boolean;
  signal array_obj_ref_24_store_0_req_1 : boolean;
  signal array_obj_ref_24_store_0_ack_1 : boolean;
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
  mem_store_x_xx_xCP_964: Block -- control-path 
    signal mem_store_x_xx_xCP_964_start: Boolean;
    signal Xentry_965_symbol: Boolean;
    signal Xexit_966_symbol: Boolean;
    signal assign_stmt_26_967_symbol : Boolean;
    -- 
  begin -- 
    mem_store_x_xx_xCP_964_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_965_symbol  <= mem_store_x_xx_xCP_964_start; -- transition $entry
    assign_stmt_26_967: Block -- assign_stmt_26 
      signal assign_stmt_26_967_start: Boolean;
      signal Xentry_968_symbol: Boolean;
      signal Xexit_969_symbol: Boolean;
      signal assign_stmt_26_active_x_x970_symbol : Boolean;
      signal assign_stmt_26_completed_x_x971_symbol : Boolean;
      signal simple_obj_ref_25_complete_972_symbol : Boolean;
      signal array_obj_ref_24_trigger_x_x973_symbol : Boolean;
      signal array_obj_ref_24_active_x_x974_symbol : Boolean;
      signal array_obj_ref_24_root_address_calculated_975_symbol : Boolean;
      signal array_obj_ref_24_word_address_calculated_976_symbol : Boolean;
      signal array_obj_ref_24_indices_scaled_977_symbol : Boolean;
      signal array_obj_ref_24_offset_calculated_978_symbol : Boolean;
      signal array_obj_ref_24_index_computed_0_979_symbol : Boolean;
      signal array_obj_ref_24_index_resized_0_980_symbol : Boolean;
      signal binary_23_active_x_x981_symbol : Boolean;
      signal binary_23_trigger_x_x982_symbol : Boolean;
      signal binary_21_active_x_x983_symbol : Boolean;
      signal binary_21_trigger_x_x984_symbol : Boolean;
      signal simple_obj_ref_19_complete_985_symbol : Boolean;
      signal binary_21_complete_986_symbol : Boolean;
      signal binary_23_complete_993_symbol : Boolean;
      signal array_obj_ref_24_index_resize_0_1000_symbol : Boolean;
      signal array_obj_ref_24_index_scale_0_1005_symbol : Boolean;
      signal array_obj_ref_24_add_indices_1010_symbol : Boolean;
      signal array_obj_ref_24_base_plus_offset_1015_symbol : Boolean;
      signal array_obj_ref_24_word_addrgen_1020_symbol : Boolean;
      signal array_obj_ref_24_request_1025_symbol : Boolean;
      signal array_obj_ref_24_complete_1038_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_26_967_start <= Xentry_965_symbol; -- control passed to block
      Xentry_968_symbol  <= assign_stmt_26_967_start; -- transition assign_stmt_26/$entry
      assign_stmt_26_active_x_x970_symbol <= simple_obj_ref_25_complete_972_symbol; -- transition assign_stmt_26/assign_stmt_26_active_
      assign_stmt_26_completed_x_x971_symbol <= array_obj_ref_24_complete_1038_symbol; -- transition assign_stmt_26/assign_stmt_26_completed_
      simple_obj_ref_25_complete_972_symbol <= Xentry_968_symbol; -- transition assign_stmt_26/simple_obj_ref_25_complete
      array_obj_ref_24_trigger_x_x973_block : Block -- non-trivial join transition assign_stmt_26/array_obj_ref_24_trigger_ 
        signal array_obj_ref_24_trigger_x_x973_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        array_obj_ref_24_trigger_x_x973_predecessors(0) <= array_obj_ref_24_word_address_calculated_976_symbol;
        array_obj_ref_24_trigger_x_x973_predecessors(1) <= assign_stmt_26_active_x_x970_symbol;
        array_obj_ref_24_trigger_x_x973_join: join -- 
          port map( -- 
            preds => array_obj_ref_24_trigger_x_x973_predecessors,
            symbol_out => array_obj_ref_24_trigger_x_x973_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_26/array_obj_ref_24_trigger_
      array_obj_ref_24_active_x_x974_symbol <= array_obj_ref_24_request_1025_symbol; -- transition assign_stmt_26/array_obj_ref_24_active_
      array_obj_ref_24_root_address_calculated_975_symbol <= array_obj_ref_24_base_plus_offset_1015_symbol; -- transition assign_stmt_26/array_obj_ref_24_root_address_calculated
      array_obj_ref_24_word_address_calculated_976_symbol <= array_obj_ref_24_word_addrgen_1020_symbol; -- transition assign_stmt_26/array_obj_ref_24_word_address_calculated
      array_obj_ref_24_indices_scaled_977_symbol <= array_obj_ref_24_index_scale_0_1005_symbol; -- transition assign_stmt_26/array_obj_ref_24_indices_scaled
      array_obj_ref_24_offset_calculated_978_symbol <= array_obj_ref_24_add_indices_1010_symbol; -- transition assign_stmt_26/array_obj_ref_24_offset_calculated
      array_obj_ref_24_index_computed_0_979_symbol <= binary_23_complete_993_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_computed_0
      array_obj_ref_24_index_resized_0_980_symbol <= array_obj_ref_24_index_resize_0_1000_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_resized_0
      binary_23_active_x_x981_block : Block -- non-trivial join transition assign_stmt_26/binary_23_active_ 
        signal binary_23_active_x_x981_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_23_active_x_x981_predecessors(0) <= binary_23_trigger_x_x982_symbol;
        binary_23_active_x_x981_predecessors(1) <= binary_21_complete_986_symbol;
        binary_23_active_x_x981_join: join -- 
          port map( -- 
            preds => binary_23_active_x_x981_predecessors,
            symbol_out => binary_23_active_x_x981_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_26/binary_23_active_
      binary_23_trigger_x_x982_symbol <= Xentry_968_symbol; -- transition assign_stmt_26/binary_23_trigger_
      binary_21_active_x_x983_block : Block -- non-trivial join transition assign_stmt_26/binary_21_active_ 
        signal binary_21_active_x_x983_predecessors: BooleanArray(1 downto 0);
        -- 
      begin -- 
        binary_21_active_x_x983_predecessors(0) <= binary_21_trigger_x_x984_symbol;
        binary_21_active_x_x983_predecessors(1) <= simple_obj_ref_19_complete_985_symbol;
        binary_21_active_x_x983_join: join -- 
          port map( -- 
            preds => binary_21_active_x_x983_predecessors,
            symbol_out => binary_21_active_x_x983_symbol,
            clk => clk,
            reset => reset); -- 
        -- 
      end Block; -- non-trivial join transition assign_stmt_26/binary_21_active_
      binary_21_trigger_x_x984_symbol <= Xentry_968_symbol; -- transition assign_stmt_26/binary_21_trigger_
      simple_obj_ref_19_complete_985_symbol <= Xentry_968_symbol; -- transition assign_stmt_26/simple_obj_ref_19_complete
      binary_21_complete_986: Block -- assign_stmt_26/binary_21_complete 
        signal binary_21_complete_986_start: Boolean;
        signal Xentry_987_symbol: Boolean;
        signal Xexit_988_symbol: Boolean;
        signal rr_989_symbol : Boolean;
        signal ra_990_symbol : Boolean;
        signal cr_991_symbol : Boolean;
        signal ca_992_symbol : Boolean;
        -- 
      begin -- 
        binary_21_complete_986_start <= binary_21_active_x_x983_symbol; -- control passed to block
        Xentry_987_symbol  <= binary_21_complete_986_start; -- transition assign_stmt_26/binary_21_complete/$entry
        rr_989_symbol <= Xentry_987_symbol; -- transition assign_stmt_26/binary_21_complete/rr
        binary_21_inst_req_0 <= rr_989_symbol; -- link to DP
        ra_990_symbol <= binary_21_inst_ack_0; -- transition assign_stmt_26/binary_21_complete/ra
        cr_991_symbol <= ra_990_symbol; -- transition assign_stmt_26/binary_21_complete/cr
        binary_21_inst_req_1 <= cr_991_symbol; -- link to DP
        ca_992_symbol <= binary_21_inst_ack_1; -- transition assign_stmt_26/binary_21_complete/ca
        Xexit_988_symbol <= ca_992_symbol; -- transition assign_stmt_26/binary_21_complete/$exit
        binary_21_complete_986_symbol <= Xexit_988_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/binary_21_complete
      binary_23_complete_993: Block -- assign_stmt_26/binary_23_complete 
        signal binary_23_complete_993_start: Boolean;
        signal Xentry_994_symbol: Boolean;
        signal Xexit_995_symbol: Boolean;
        signal rr_996_symbol : Boolean;
        signal ra_997_symbol : Boolean;
        signal cr_998_symbol : Boolean;
        signal ca_999_symbol : Boolean;
        -- 
      begin -- 
        binary_23_complete_993_start <= binary_23_active_x_x981_symbol; -- control passed to block
        Xentry_994_symbol  <= binary_23_complete_993_start; -- transition assign_stmt_26/binary_23_complete/$entry
        rr_996_symbol <= Xentry_994_symbol; -- transition assign_stmt_26/binary_23_complete/rr
        binary_23_inst_req_0 <= rr_996_symbol; -- link to DP
        ra_997_symbol <= binary_23_inst_ack_0; -- transition assign_stmt_26/binary_23_complete/ra
        cr_998_symbol <= ra_997_symbol; -- transition assign_stmt_26/binary_23_complete/cr
        binary_23_inst_req_1 <= cr_998_symbol; -- link to DP
        ca_999_symbol <= binary_23_inst_ack_1; -- transition assign_stmt_26/binary_23_complete/ca
        Xexit_995_symbol <= ca_999_symbol; -- transition assign_stmt_26/binary_23_complete/$exit
        binary_23_complete_993_symbol <= Xexit_995_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/binary_23_complete
      array_obj_ref_24_index_resize_0_1000: Block -- assign_stmt_26/array_obj_ref_24_index_resize_0 
        signal array_obj_ref_24_index_resize_0_1000_start: Boolean;
        signal Xentry_1001_symbol: Boolean;
        signal Xexit_1002_symbol: Boolean;
        signal index_resize_req_1003_symbol : Boolean;
        signal index_resize_ack_1004_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_index_resize_0_1000_start <= array_obj_ref_24_index_computed_0_979_symbol; -- control passed to block
        Xentry_1001_symbol  <= array_obj_ref_24_index_resize_0_1000_start; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/$entry
        index_resize_req_1003_symbol <= Xentry_1001_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/index_resize_req
        array_obj_ref_24_index_0_resize_req_0 <= index_resize_req_1003_symbol; -- link to DP
        index_resize_ack_1004_symbol <= array_obj_ref_24_index_0_resize_ack_0; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/index_resize_ack
        Xexit_1002_symbol <= index_resize_ack_1004_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_resize_0/$exit
        array_obj_ref_24_index_resize_0_1000_symbol <= Xexit_1002_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_index_resize_0
      array_obj_ref_24_index_scale_0_1005: Block -- assign_stmt_26/array_obj_ref_24_index_scale_0 
        signal array_obj_ref_24_index_scale_0_1005_start: Boolean;
        signal Xentry_1006_symbol: Boolean;
        signal Xexit_1007_symbol: Boolean;
        signal scale_rename_req_1008_symbol : Boolean;
        signal scale_rename_ack_1009_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_index_scale_0_1005_start <= array_obj_ref_24_index_resized_0_980_symbol; -- control passed to block
        Xentry_1006_symbol  <= array_obj_ref_24_index_scale_0_1005_start; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/$entry
        scale_rename_req_1008_symbol <= Xentry_1006_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/scale_rename_req
        array_obj_ref_24_index_0_rename_req_0 <= scale_rename_req_1008_symbol; -- link to DP
        scale_rename_ack_1009_symbol <= array_obj_ref_24_index_0_rename_ack_0; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/scale_rename_ack
        Xexit_1007_symbol <= scale_rename_ack_1009_symbol; -- transition assign_stmt_26/array_obj_ref_24_index_scale_0/$exit
        array_obj_ref_24_index_scale_0_1005_symbol <= Xexit_1007_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_index_scale_0
      array_obj_ref_24_add_indices_1010: Block -- assign_stmt_26/array_obj_ref_24_add_indices 
        signal array_obj_ref_24_add_indices_1010_start: Boolean;
        signal Xentry_1011_symbol: Boolean;
        signal Xexit_1012_symbol: Boolean;
        signal final_index_req_1013_symbol : Boolean;
        signal final_index_ack_1014_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_add_indices_1010_start <= array_obj_ref_24_indices_scaled_977_symbol; -- control passed to block
        Xentry_1011_symbol  <= array_obj_ref_24_add_indices_1010_start; -- transition assign_stmt_26/array_obj_ref_24_add_indices/$entry
        final_index_req_1013_symbol <= Xentry_1011_symbol; -- transition assign_stmt_26/array_obj_ref_24_add_indices/final_index_req
        array_obj_ref_24_offset_inst_req_0 <= final_index_req_1013_symbol; -- link to DP
        final_index_ack_1014_symbol <= array_obj_ref_24_offset_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24_add_indices/final_index_ack
        Xexit_1012_symbol <= final_index_ack_1014_symbol; -- transition assign_stmt_26/array_obj_ref_24_add_indices/$exit
        array_obj_ref_24_add_indices_1010_symbol <= Xexit_1012_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_add_indices
      array_obj_ref_24_base_plus_offset_1015: Block -- assign_stmt_26/array_obj_ref_24_base_plus_offset 
        signal array_obj_ref_24_base_plus_offset_1015_start: Boolean;
        signal Xentry_1016_symbol: Boolean;
        signal Xexit_1017_symbol: Boolean;
        signal sum_rename_req_1018_symbol : Boolean;
        signal sum_rename_ack_1019_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_base_plus_offset_1015_start <= array_obj_ref_24_offset_calculated_978_symbol; -- control passed to block
        Xentry_1016_symbol  <= array_obj_ref_24_base_plus_offset_1015_start; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/$entry
        sum_rename_req_1018_symbol <= Xentry_1016_symbol; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/sum_rename_req
        array_obj_ref_24_root_address_inst_req_0 <= sum_rename_req_1018_symbol; -- link to DP
        sum_rename_ack_1019_symbol <= array_obj_ref_24_root_address_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/sum_rename_ack
        Xexit_1017_symbol <= sum_rename_ack_1019_symbol; -- transition assign_stmt_26/array_obj_ref_24_base_plus_offset/$exit
        array_obj_ref_24_base_plus_offset_1015_symbol <= Xexit_1017_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_base_plus_offset
      array_obj_ref_24_word_addrgen_1020: Block -- assign_stmt_26/array_obj_ref_24_word_addrgen 
        signal array_obj_ref_24_word_addrgen_1020_start: Boolean;
        signal Xentry_1021_symbol: Boolean;
        signal Xexit_1022_symbol: Boolean;
        signal root_rename_req_1023_symbol : Boolean;
        signal root_rename_ack_1024_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_word_addrgen_1020_start <= array_obj_ref_24_root_address_calculated_975_symbol; -- control passed to block
        Xentry_1021_symbol  <= array_obj_ref_24_word_addrgen_1020_start; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/$entry
        root_rename_req_1023_symbol <= Xentry_1021_symbol; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/root_rename_req
        array_obj_ref_24_addr_0_req_0 <= root_rename_req_1023_symbol; -- link to DP
        root_rename_ack_1024_symbol <= array_obj_ref_24_addr_0_ack_0; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/root_rename_ack
        Xexit_1022_symbol <= root_rename_ack_1024_symbol; -- transition assign_stmt_26/array_obj_ref_24_word_addrgen/$exit
        array_obj_ref_24_word_addrgen_1020_symbol <= Xexit_1022_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_word_addrgen
      array_obj_ref_24_request_1025: Block -- assign_stmt_26/array_obj_ref_24_request 
        signal array_obj_ref_24_request_1025_start: Boolean;
        signal Xentry_1026_symbol: Boolean;
        signal Xexit_1027_symbol: Boolean;
        signal split_req_1028_symbol : Boolean;
        signal split_ack_1029_symbol : Boolean;
        signal word_access_1030_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_request_1025_start <= array_obj_ref_24_trigger_x_x973_symbol; -- control passed to block
        Xentry_1026_symbol  <= array_obj_ref_24_request_1025_start; -- transition assign_stmt_26/array_obj_ref_24_request/$entry
        split_req_1028_symbol <= Xentry_1026_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/split_req
        array_obj_ref_24_gather_scatter_req_0 <= split_req_1028_symbol; -- link to DP
        split_ack_1029_symbol <= array_obj_ref_24_gather_scatter_ack_0; -- transition assign_stmt_26/array_obj_ref_24_request/split_ack
        word_access_1030: Block -- assign_stmt_26/array_obj_ref_24_request/word_access 
          signal word_access_1030_start: Boolean;
          signal Xentry_1031_symbol: Boolean;
          signal Xexit_1032_symbol: Boolean;
          signal word_access_0_1033_symbol : Boolean;
          -- 
        begin -- 
          word_access_1030_start <= split_ack_1029_symbol; -- control passed to block
          Xentry_1031_symbol  <= word_access_1030_start; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/$entry
          word_access_0_1033: Block -- assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0 
            signal word_access_0_1033_start: Boolean;
            signal Xentry_1034_symbol: Boolean;
            signal Xexit_1035_symbol: Boolean;
            signal rr_1036_symbol : Boolean;
            signal ra_1037_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_1033_start <= Xentry_1031_symbol; -- control passed to block
            Xentry_1034_symbol  <= word_access_0_1033_start; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/$entry
            rr_1036_symbol <= Xentry_1034_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/rr
            array_obj_ref_24_store_0_req_0 <= rr_1036_symbol; -- link to DP
            ra_1037_symbol <= array_obj_ref_24_store_0_ack_0; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/ra
            Xexit_1035_symbol <= ra_1037_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0/$exit
            word_access_0_1033_symbol <= Xexit_1035_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24_request/word_access/word_access_0
          Xexit_1032_symbol <= word_access_0_1033_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/word_access/$exit
          word_access_1030_symbol <= Xexit_1032_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_26/array_obj_ref_24_request/word_access
        Xexit_1027_symbol <= word_access_1030_symbol; -- transition assign_stmt_26/array_obj_ref_24_request/$exit
        array_obj_ref_24_request_1025_symbol <= Xexit_1027_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_request
      array_obj_ref_24_complete_1038: Block -- assign_stmt_26/array_obj_ref_24_complete 
        signal array_obj_ref_24_complete_1038_start: Boolean;
        signal Xentry_1039_symbol: Boolean;
        signal Xexit_1040_symbol: Boolean;
        signal word_access_1041_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_complete_1038_start <= array_obj_ref_24_active_x_x974_symbol; -- control passed to block
        Xentry_1039_symbol  <= array_obj_ref_24_complete_1038_start; -- transition assign_stmt_26/array_obj_ref_24_complete/$entry
        word_access_1041: Block -- assign_stmt_26/array_obj_ref_24_complete/word_access 
          signal word_access_1041_start: Boolean;
          signal Xentry_1042_symbol: Boolean;
          signal Xexit_1043_symbol: Boolean;
          signal word_access_0_1044_symbol : Boolean;
          -- 
        begin -- 
          word_access_1041_start <= Xentry_1039_symbol; -- control passed to block
          Xentry_1042_symbol  <= word_access_1041_start; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/$entry
          word_access_0_1044: Block -- assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0 
            signal word_access_0_1044_start: Boolean;
            signal Xentry_1045_symbol: Boolean;
            signal Xexit_1046_symbol: Boolean;
            signal cr_1047_symbol : Boolean;
            signal ca_1048_symbol : Boolean;
            -- 
          begin -- 
            word_access_0_1044_start <= Xentry_1042_symbol; -- control passed to block
            Xentry_1045_symbol  <= word_access_0_1044_start; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/$entry
            cr_1047_symbol <= Xentry_1045_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/cr
            array_obj_ref_24_store_0_req_1 <= cr_1047_symbol; -- link to DP
            ca_1048_symbol <= array_obj_ref_24_store_0_ack_1; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/ca
            Xexit_1046_symbol <= ca_1048_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0/$exit
            word_access_0_1044_symbol <= Xexit_1046_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24_complete/word_access/word_access_0
          Xexit_1043_symbol <= word_access_0_1044_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/word_access/$exit
          word_access_1041_symbol <= Xexit_1043_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_26/array_obj_ref_24_complete/word_access
        Xexit_1040_symbol <= word_access_1041_symbol; -- transition assign_stmt_26/array_obj_ref_24_complete/$exit
        array_obj_ref_24_complete_1038_symbol <= Xexit_1040_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24_complete
      Xexit_969_symbol <= assign_stmt_26_completed_x_x971_symbol; -- transition assign_stmt_26/$exit
      assign_stmt_26_967_symbol <= Xexit_969_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_26
    Xexit_966_symbol <= assign_stmt_26_967_symbol; -- transition $exit
    fin  <=  '1' when Xexit_966_symbol else '0'; -- fin symbol when control-path exits
    -- 
  end Block; -- control-path
  -- the data path
  data_path: Block -- 
    signal array_obj_ref_24_data_0 : std_logic_vector(7 downto 0);
    signal array_obj_ref_24_final_offset : std_logic_vector(4 downto 0);
    signal array_obj_ref_24_offset_scale_factor_0 : std_logic_vector(4 downto 0);
    signal array_obj_ref_24_resized_base_address : std_logic_vector(4 downto 0);
    signal array_obj_ref_24_root_address : std_logic_vector(4 downto 0);
    signal array_obj_ref_24_word_address_0 : std_logic_vector(4 downto 0);
    signal array_obj_ref_24_word_offset_0 : std_logic_vector(4 downto 0);
    signal binary_21_wire : std_logic_vector(31 downto 0);
    signal binary_23_resized : std_logic_vector(4 downto 0);
    signal binary_23_scaled : std_logic_vector(4 downto 0);
    signal binary_23_wire : std_logic_vector(31 downto 0);
    signal expr_20_wire_constant : std_logic_vector(31 downto 0);
    signal expr_22_wire_constant : std_logic_vector(31 downto 0);
    -- 
  begin -- 
    array_obj_ref_24_offset_scale_factor_0 <= "00001";
    array_obj_ref_24_resized_base_address <= "00000";
    array_obj_ref_24_word_offset_0 <= "00000";
    expr_20_wire_constant <= "00000000000000000000000000000001";
    expr_22_wire_constant <= "00000000000000000000000000000000";
    array_obj_ref_24_index_0_resize: RegisterBase generic map(in_data_width => 32,out_data_width => 5) -- 
      port map( din => binary_23_wire, dout => binary_23_resized, req => array_obj_ref_24_index_0_resize_req_0, ack => array_obj_ref_24_index_0_resize_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_24_offset_inst: RegisterBase generic map(in_data_width => 5,out_data_width => 5) -- 
      port map( din => binary_23_scaled, dout => array_obj_ref_24_final_offset, req => array_obj_ref_24_offset_inst_req_0, ack => array_obj_ref_24_offset_inst_ack_0, clk => clk, reset => reset); -- 
    array_obj_ref_24_addr_0: Block -- 
      signal aggregated_sig: std_logic_vector(4 downto 0); --
    begin -- 
      array_obj_ref_24_addr_0_ack_0 <= array_obj_ref_24_addr_0_req_0;
      aggregated_sig <= array_obj_ref_24_root_address;
      array_obj_ref_24_word_address_0 <= aggregated_sig(4 downto 0);
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
      signal aggregated_sig: std_logic_vector(4 downto 0); --
    begin -- 
      array_obj_ref_24_index_0_rename_ack_0 <= array_obj_ref_24_index_0_rename_req_0;
      aggregated_sig <= binary_23_resized;
      binary_23_scaled <= aggregated_sig(4 downto 0);
      --
    end Block;
    array_obj_ref_24_root_address_inst: Block -- 
      signal aggregated_sig: std_logic_vector(4 downto 0); --
    begin -- 
      array_obj_ref_24_root_address_inst_ack_0 <= array_obj_ref_24_root_address_inst_req_0;
      aggregated_sig <= array_obj_ref_24_final_offset;
      array_obj_ref_24_root_address <= aggregated_sig(4 downto 0);
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
      signal addr_in: std_logic_vector(4 downto 0);
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
        generic map ( addr_width => 5,
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
          maddr => memory_space_0_sr_addr(4 downto 0),
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
entity test_system is  -- system 
  port (-- 
    bar_a : in  std_logic_vector(31 downto 0);
    bar_ret_val_x_x : out  std_logic_vector(31 downto 0);
    bar_tag_in: in std_logic_vector(0 downto 0);
    bar_tag_out: out std_logic_vector(0 downto 0);
    bar_start : in std_logic;
    bar_fin   : out std_logic;
    foo_a : in  std_logic_vector(31 downto 0);
    foo_ret_val_x_x : out  std_logic_vector(31 downto 0);
    foo_tag_in: in std_logic_vector(0 downto 0);
    foo_tag_out: out std_logic_vector(0 downto 0);
    foo_start : in std_logic;
    foo_fin   : out std_logic;
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
  signal memory_space_0_lr_req :  std_logic_vector(24 downto 0);
  signal memory_space_0_lr_ack : std_logic_vector(24 downto 0);
  signal memory_space_0_lr_addr : std_logic_vector(124 downto 0);
  signal memory_space_0_lr_tag : std_logic_vector(24 downto 0);
  signal memory_space_0_lc_req : std_logic_vector(24 downto 0);
  signal memory_space_0_lc_ack :  std_logic_vector(24 downto 0);
  signal memory_space_0_lc_data : std_logic_vector(199 downto 0);
  signal memory_space_0_lc_tag :  std_logic_vector(24 downto 0);
  signal memory_space_0_sr_req :  std_logic_vector(16 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(16 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(84 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(135 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(16 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(16 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(16 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(16 downto 0);
  -- interface signals to connect to memory space memory_space_1
  -- interface signals to connect to memory space memory_space_2
  -- interface signals to connect to memory space memory_space_3
  -- declarations related to module bar
  component bar is -- 
    port ( -- 
      a : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_0_lr_req : out  std_logic_vector(11 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(11 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(59 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(11 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(11 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(11 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(95 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(11 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(7 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(7 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(39 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(63 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(7 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(7 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(7 downto 0);
      midpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
      midpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
      midpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
      outpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      outpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      outpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- declarations related to module foo
  component foo is -- 
    port ( -- 
      a : in  std_logic_vector(31 downto 0);
      ret_val_x_x : out  std_logic_vector(31 downto 0);
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      memory_space_0_lr_req : out  std_logic_vector(11 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(11 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(59 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(11 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(11 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(11 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(95 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(11 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(7 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(7 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(39 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(63 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(7 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(7 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(7 downto 0);
      inpipe_pipe_read_req : out  std_logic_vector(0 downto 0);
      inpipe_pipe_read_ack : in   std_logic_vector(0 downto 0);
      inpipe_pipe_read_data : in   std_logic_vector(31 downto 0);
      midpipe_pipe_write_req : out  std_logic_vector(0 downto 0);
      midpipe_pipe_write_ack : in   std_logic_vector(0 downto 0);
      midpipe_pipe_write_data : out  std_logic_vector(31 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
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
      memory_space_0_lr_addr : out  std_logic_vector(4 downto 0);
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
      memory_space_0_sr_addr : out  std_logic_vector(4 downto 0);
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
    port map(-- 
      a => bar_a,
      ret_val_x_x => bar_ret_val_x_x,
      start => bar_start,
      fin => bar_fin,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(24 downto 13),
      memory_space_0_lr_ack => memory_space_0_lr_ack(24 downto 13),
      memory_space_0_lr_addr => memory_space_0_lr_addr(124 downto 65),
      memory_space_0_lr_tag => memory_space_0_lr_tag(24 downto 13),
      memory_space_0_lc_req => memory_space_0_lc_req(24 downto 13),
      memory_space_0_lc_ack => memory_space_0_lc_ack(24 downto 13),
      memory_space_0_lc_data => memory_space_0_lc_data(199 downto 104),
      memory_space_0_lc_tag => memory_space_0_lc_tag(24 downto 13),
      memory_space_0_sr_req => memory_space_0_sr_req(16 downto 9),
      memory_space_0_sr_ack => memory_space_0_sr_ack(16 downto 9),
      memory_space_0_sr_addr => memory_space_0_sr_addr(84 downto 45),
      memory_space_0_sr_data => memory_space_0_sr_data(135 downto 72),
      memory_space_0_sr_tag => memory_space_0_sr_tag(16 downto 9),
      memory_space_0_sc_req => memory_space_0_sc_req(16 downto 9),
      memory_space_0_sc_ack => memory_space_0_sc_ack(16 downto 9),
      memory_space_0_sc_tag => memory_space_0_sc_tag(16 downto 9),
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
    port map(-- 
      a => foo_a,
      ret_val_x_x => foo_ret_val_x_x,
      start => foo_start,
      fin => foo_fin,
      clk => clk,
      reset => reset,
      memory_space_0_lr_req => memory_space_0_lr_req(11 downto 0),
      memory_space_0_lr_ack => memory_space_0_lr_ack(11 downto 0),
      memory_space_0_lr_addr => memory_space_0_lr_addr(59 downto 0),
      memory_space_0_lr_tag => memory_space_0_lr_tag(11 downto 0),
      memory_space_0_lc_req => memory_space_0_lc_req(11 downto 0),
      memory_space_0_lc_ack => memory_space_0_lc_ack(11 downto 0),
      memory_space_0_lc_data => memory_space_0_lc_data(95 downto 0),
      memory_space_0_lc_tag => memory_space_0_lc_tag(11 downto 0),
      memory_space_0_sr_req => memory_space_0_sr_req(8 downto 1),
      memory_space_0_sr_ack => memory_space_0_sr_ack(8 downto 1),
      memory_space_0_sr_addr => memory_space_0_sr_addr(44 downto 5),
      memory_space_0_sr_data => memory_space_0_sr_data(71 downto 8),
      memory_space_0_sr_tag => memory_space_0_sr_tag(8 downto 1),
      memory_space_0_sc_req => memory_space_0_sc_req(8 downto 1),
      memory_space_0_sc_ack => memory_space_0_sc_ack(8 downto 1),
      memory_space_0_sc_tag => memory_space_0_sc_tag(8 downto 1),
      inpipe_pipe_read_req => inpipe_pipe_read_req(0 downto 0),
      inpipe_pipe_read_ack => inpipe_pipe_read_ack(0 downto 0),
      inpipe_pipe_read_data => inpipe_pipe_read_data(31 downto 0),
      midpipe_pipe_write_req => midpipe_pipe_write_req(0 downto 0),
      midpipe_pipe_write_ack => midpipe_pipe_write_ack(0 downto 0),
      midpipe_pipe_write_data => midpipe_pipe_write_data(31 downto 0),
      tag_in => foo_tag_in,
      tag_out => foo_tag_out-- 
    ); -- 
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
      memory_space_0_lr_req => memory_space_0_lr_req(12 downto 12),
      memory_space_0_lr_ack => memory_space_0_lr_ack(12 downto 12),
      memory_space_0_lr_addr => memory_space_0_lr_addr(64 downto 60),
      memory_space_0_lr_tag => memory_space_0_lr_tag(12 downto 12),
      memory_space_0_lc_req => memory_space_0_lc_req(12 downto 12),
      memory_space_0_lc_ack => memory_space_0_lc_ack(12 downto 12),
      memory_space_0_lc_data => memory_space_0_lc_data(103 downto 96),
      memory_space_0_lc_tag => memory_space_0_lc_tag(12 downto 12),
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
      memory_space_0_sr_addr => memory_space_0_sr_addr(4 downto 0),
      memory_space_0_sr_data => memory_space_0_sr_data(7 downto 0),
      memory_space_0_sr_tag => memory_space_0_sr_tag(0 downto 0),
      memory_space_0_sc_req => memory_space_0_sc_req(0 downto 0),
      memory_space_0_sc_ack => memory_space_0_sc_ack(0 downto 0),
      memory_space_0_sc_tag => memory_space_0_sc_tag(0 downto 0),
      tag_in => mem_store_x_x_tag_in,
      tag_out => mem_store_x_x_tag_out-- 
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
  MemorySpace_memory_space_0: memory_subsystem -- 
    generic map(-- 
      num_loads => 25,
      num_stores => 17,
      addr_width => 5,
      data_width => 8,
      tag_width => 1,
      number_of_banks => 2,
      mux_degree => 100,
      demux_degree => 100,
      base_bank_addr_width => 10,
      base_bank_data_width => 8
      ) -- 
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
      bar_start : in std_logic;
      bar_fin   : out std_logic;
      foo_a : in  std_logic_vector(31 downto 0);
      foo_ret_val_x_x : out  std_logic_vector(31 downto 0);
      foo_tag_in: in std_logic_vector(0 downto 0);
      foo_tag_out: out std_logic_vector(0 downto 0);
      foo_start : in std_logic;
      foo_fin   : out std_logic;
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
  signal bar_start : std_logic := '0';
  signal bar_fin   : std_logic := '0';
  signal foo_a :  std_logic_vector(31 downto 0) := (others => '0');
  signal foo_ret_val_x_x :   std_logic_vector(31 downto 0);
  signal foo_tag_in: std_logic_vector(0 downto 0);
  signal foo_tag_out: std_logic_vector(0 downto 0);
  signal foo_start : std_logic := '0';
  signal foo_fin   : std_logic := '0';
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
      Vhpi_Get_Port_Value(obj_ref,val_string);
      bar_start <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("bar 0");
      Vhpi_Get_Port_Value(obj_ref,val_string);
      bar_a <= Unpack_String(val_string,32);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("bar ack");
      val_string := To_String(bar_fin);
      Vhpi_Set_Port_Value(obj_ref,val_string);
      obj_ref := Pack_String_To_Vhpi_String("bar 0");
      val_string := Pack_SLV_To_Vhpi_String(bar_ret_val_x_x);
      Vhpi_Set_Port_Value(obj_ref,val_string);
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
      Vhpi_Get_Port_Value(obj_ref,val_string);
      foo_start <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("foo 0");
      Vhpi_Get_Port_Value(obj_ref,val_string);
      foo_a <= Unpack_String(val_string,32);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("foo ack");
      val_string := To_String(foo_fin);
      Vhpi_Set_Port_Value(obj_ref,val_string);
      obj_ref := Pack_String_To_Vhpi_String("foo 0");
      val_string := Pack_SLV_To_Vhpi_String(foo_ret_val_x_x);
      Vhpi_Set_Port_Value(obj_ref,val_string);
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
      Vhpi_Get_Port_Value(obj_ref,val_string);
      inpipe_pipe_write_req <= Unpack_String(val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("inpipe 0");
      Vhpi_Get_Port_Value(obj_ref,val_string);
      inpipe_pipe_write_data <= Unpack_String(val_string,32);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("inpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(inpipe_pipe_write_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string);
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
      Vhpi_Get_Port_Value(obj_ref,val_string);
      outpipe_pipe_read_req <= Unpack_String(val_string,1);
      wait until clk = '1';
      obj_ref := Pack_String_To_Vhpi_String("outpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_ack);
      Vhpi_Set_Port_Value(obj_ref,val_string);
      obj_ref := Pack_String_To_Vhpi_String("outpipe 0");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_data);
      Vhpi_Set_Port_Value(obj_ref,val_string);
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
      bar_start => bar_start,
      bar_fin  => bar_fin ,
      foo_a => foo_a,
      foo_ret_val_x_x => foo_ret_val_x_x,
      foo_tag_in => foo_tag_in,
      foo_tag_out => foo_tag_out,
      foo_start => foo_start,
      foo_fin  => foo_fin ,
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
