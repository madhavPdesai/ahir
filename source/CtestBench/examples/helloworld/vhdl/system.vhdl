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
    memory_space_0_lr_req : out  std_logic_vector(3 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(3 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(19 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(7 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(3 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(3 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(7 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(3 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(3 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(19 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(3 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(3 downto 0);
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
  signal ptr_deref_52_store_2_ack_0 : boolean;
  signal ptr_deref_52_store_2_req_1 : boolean;
  signal ptr_deref_52_store_2_ack_1 : boolean;
  signal ptr_deref_52_store_0_req_0 : boolean;
  signal ptr_deref_52_store_0_ack_0 : boolean;
  signal ptr_deref_52_store_0_req_1 : boolean;
  signal ptr_deref_52_store_0_ack_1 : boolean;
  signal ptr_deref_52_store_1_req_0 : boolean;
  signal ptr_deref_52_store_1_ack_0 : boolean;
  signal ptr_deref_52_store_1_req_1 : boolean;
  signal ptr_deref_52_store_1_ack_1 : boolean;
  signal ptr_deref_52_store_2_req_0 : boolean;
  signal binary_79_inst_req_0 : boolean;
  signal binary_79_inst_ack_0 : boolean;
  signal binary_79_inst_req_1 : boolean;
  signal binary_79_inst_ack_1 : boolean;
  signal ptr_deref_52_store_3_req_0 : boolean;
  signal ptr_deref_52_store_3_ack_0 : boolean;
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
  signal ptr_deref_65_store_0_req_1 : boolean;
  signal ptr_deref_65_store_0_ack_1 : boolean;
  signal ptr_deref_65_store_1_req_0 : boolean;
  signal ptr_deref_65_store_1_ack_0 : boolean;
  signal ptr_deref_65_store_1_req_1 : boolean;
  signal ptr_deref_65_store_1_ack_1 : boolean;
  signal ptr_deref_65_store_2_req_0 : boolean;
  signal ptr_deref_65_store_2_ack_0 : boolean;
  signal ptr_deref_65_store_2_req_1 : boolean;
  signal ptr_deref_65_store_2_ack_1 : boolean;
  signal ptr_deref_65_store_3_req_0 : boolean;
  signal ptr_deref_65_store_3_ack_0 : boolean;
  signal ptr_deref_65_store_3_req_1 : boolean;
  signal ptr_deref_65_store_3_ack_1 : boolean;
  signal ptr_deref_70_load_0_req_0 : boolean;
  signal ptr_deref_70_load_0_ack_0 : boolean;
  signal ptr_deref_70_load_0_req_1 : boolean;
  signal ptr_deref_70_load_0_ack_1 : boolean;
  signal ptr_deref_70_load_1_req_0 : boolean;
  signal ptr_deref_70_load_1_ack_0 : boolean;
  signal ptr_deref_70_load_1_req_1 : boolean;
  signal ptr_deref_70_load_1_ack_1 : boolean;
  signal ptr_deref_70_load_2_req_0 : boolean;
  signal ptr_deref_70_load_2_ack_0 : boolean;
  signal ptr_deref_70_load_2_req_1 : boolean;
  signal ptr_deref_70_load_2_ack_1 : boolean;
  signal ptr_deref_70_load_3_req_0 : boolean;
  signal ptr_deref_70_load_3_ack_0 : boolean;
  signal ptr_deref_70_load_3_req_1 : boolean;
  signal ptr_deref_70_load_3_ack_1 : boolean;
  signal ptr_deref_70_gather_scatter_req_0 : boolean;
  signal ptr_deref_70_gather_scatter_ack_0 : boolean;
  signal ptr_deref_74_load_0_req_0 : boolean;
  signal ptr_deref_74_load_0_ack_0 : boolean;
  signal ptr_deref_74_load_0_req_1 : boolean;
  signal ptr_deref_74_load_0_ack_1 : boolean;
  signal ptr_deref_74_load_1_req_0 : boolean;
  signal ptr_deref_74_load_1_ack_0 : boolean;
  signal ptr_deref_74_load_1_req_1 : boolean;
  signal ptr_deref_74_load_1_ack_1 : boolean;
  signal ptr_deref_74_load_2_req_0 : boolean;
  signal ptr_deref_74_load_2_ack_0 : boolean;
  signal ptr_deref_74_load_2_req_1 : boolean;
  signal ptr_deref_74_load_2_ack_1 : boolean;
  signal ptr_deref_74_load_3_req_0 : boolean;
  signal ptr_deref_74_load_3_ack_0 : boolean;
  signal ptr_deref_74_load_3_req_1 : boolean;
  signal ptr_deref_74_load_3_ack_1 : boolean;
  signal ptr_deref_74_gather_scatter_req_0 : boolean;
  signal ptr_deref_74_gather_scatter_ack_0 : boolean;
  signal type_cast_88_inst_req_0 : boolean;
  signal type_cast_88_inst_ack_0 : boolean;
  signal simple_obj_ref_86_inst_req_0 : boolean;
  signal simple_obj_ref_86_inst_ack_0 : boolean;
  signal ptr_deref_92_load_0_req_0 : boolean;
  signal ptr_deref_92_load_0_ack_0 : boolean;
  signal ptr_deref_92_load_0_req_1 : boolean;
  signal ptr_deref_92_load_0_ack_1 : boolean;
  signal ptr_deref_92_load_1_req_0 : boolean;
  signal ptr_deref_92_load_1_ack_0 : boolean;
  signal ptr_deref_92_load_1_req_1 : boolean;
  signal ptr_deref_92_load_1_ack_1 : boolean;
  signal ptr_deref_92_load_2_req_0 : boolean;
  signal ptr_deref_92_load_2_ack_0 : boolean;
  signal ptr_deref_92_load_2_req_1 : boolean;
  signal ptr_deref_92_load_2_ack_1 : boolean;
  signal ptr_deref_92_load_3_req_0 : boolean;
  signal ptr_deref_92_load_3_ack_0 : boolean;
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
      signal assign_stmt_46_x_xentry_x_xx_x8_symbol : Boolean;
      signal assign_stmt_46_x_xexit_x_xx_x9_symbol : Boolean;
      signal assign_stmt_50_x_xentry_x_xx_x10_symbol : Boolean;
      signal assign_stmt_50_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_54_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_54_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_59_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_59_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_63_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_63_x_xexit_x_xx_x17_symbol : Boolean;
      signal assign_stmt_67_x_xentry_x_xx_x18_symbol : Boolean;
      signal assign_stmt_67_x_xexit_x_xx_x19_symbol : Boolean;
      signal assign_stmt_71_x_xentry_x_xx_x20_symbol : Boolean;
      signal assign_stmt_71_x_xexit_x_xx_x21_symbol : Boolean;
      signal assign_stmt_75_x_xentry_x_xx_x22_symbol : Boolean;
      signal assign_stmt_75_x_xexit_x_xx_x23_symbol : Boolean;
      signal assign_stmt_80_x_xentry_x_xx_x24_symbol : Boolean;
      signal assign_stmt_80_x_xexit_x_xx_x25_symbol : Boolean;
      signal assign_stmt_85_x_xentry_x_xx_x26_symbol : Boolean;
      signal assign_stmt_85_x_xexit_x_xx_x27_symbol : Boolean;
      signal assign_stmt_89_x_xentry_x_xx_x28_symbol : Boolean;
      signal assign_stmt_89_x_xexit_x_xx_x29_symbol : Boolean;
      signal assign_stmt_93_x_xentry_x_xx_x30_symbol : Boolean;
      signal assign_stmt_93_x_xexit_x_xx_x31_symbol : Boolean;
      signal assign_stmt_96_x_xentry_x_xx_x32_symbol : Boolean;
      signal assign_stmt_96_x_xexit_x_xx_x33_symbol : Boolean;
      signal return_x_xx_x34_symbol : Boolean;
      signal merge_stmt_98_x_xexit_x_xx_x35_symbol : Boolean;
      signal assign_stmt_101_x_xentry_x_xx_x36_symbol : Boolean;
      signal assign_stmt_101_x_xexit_x_xx_x37_symbol : Boolean;
      signal assign_stmt_46_38_symbol : Boolean;
      signal assign_stmt_50_42_symbol : Boolean;
      signal assign_stmt_54_46_symbol : Boolean;
      signal assign_stmt_59_88_symbol : Boolean;
      signal assign_stmt_63_92_symbol : Boolean;
      signal assign_stmt_67_105_symbol : Boolean;
      signal assign_stmt_71_147_symbol : Boolean;
      signal assign_stmt_75_189_symbol : Boolean;
      signal assign_stmt_80_231_symbol : Boolean;
      signal assign_stmt_85_244_symbol : Boolean;
      signal assign_stmt_89_248_symbol : Boolean;
      signal assign_stmt_93_261_symbol : Boolean;
      signal assign_stmt_96_303_symbol : Boolean;
      signal assign_stmt_101_324_symbol : Boolean;
      signal return_x_xx_xPhiReq_345_symbol : Boolean;
      signal merge_stmt_98_PhiReqMerge_348_symbol : Boolean;
      signal merge_stmt_98_PhiAck_349_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_40_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_40_3_start; -- transition branch_block_stmt_40/$entry
      branch_block_stmt_40_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_40/branch_block_stmt_40__entry__ (optimized away) 
      branch_block_stmt_40_x_xexit_x_xx_x7_symbol  <=  assign_stmt_101_x_xexit_x_xx_x37_symbol; -- place branch_block_stmt_40/branch_block_stmt_40__exit__ (optimized away) 
      assign_stmt_46_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_40_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_40/assign_stmt_46__entry__ (optimized away) 
      assign_stmt_46_x_xexit_x_xx_x9_symbol  <=  assign_stmt_46_38_symbol; -- place branch_block_stmt_40/assign_stmt_46__exit__ (optimized away) 
      assign_stmt_50_x_xentry_x_xx_x10_symbol  <=  assign_stmt_46_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_40/assign_stmt_50__entry__ (optimized away) 
      assign_stmt_50_x_xexit_x_xx_x11_symbol  <=  assign_stmt_50_42_symbol; -- place branch_block_stmt_40/assign_stmt_50__exit__ (optimized away) 
      assign_stmt_54_x_xentry_x_xx_x12_symbol  <=  assign_stmt_50_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_40/assign_stmt_54__entry__ (optimized away) 
      assign_stmt_54_x_xexit_x_xx_x13_symbol  <=  assign_stmt_54_46_symbol; -- place branch_block_stmt_40/assign_stmt_54__exit__ (optimized away) 
      assign_stmt_59_x_xentry_x_xx_x14_symbol  <=  assign_stmt_54_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_40/assign_stmt_59__entry__ (optimized away) 
      assign_stmt_59_x_xexit_x_xx_x15_symbol  <=  assign_stmt_59_88_symbol; -- place branch_block_stmt_40/assign_stmt_59__exit__ (optimized away) 
      assign_stmt_63_x_xentry_x_xx_x16_symbol  <=  assign_stmt_59_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_40/assign_stmt_63__entry__ (optimized away) 
      assign_stmt_63_x_xexit_x_xx_x17_symbol  <=  assign_stmt_63_92_symbol; -- place branch_block_stmt_40/assign_stmt_63__exit__ (optimized away) 
      assign_stmt_67_x_xentry_x_xx_x18_symbol  <=  assign_stmt_63_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_40/assign_stmt_67__entry__ (optimized away) 
      assign_stmt_67_x_xexit_x_xx_x19_symbol  <=  assign_stmt_67_105_symbol; -- place branch_block_stmt_40/assign_stmt_67__exit__ (optimized away) 
      assign_stmt_71_x_xentry_x_xx_x20_symbol  <=  assign_stmt_67_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_40/assign_stmt_71__entry__ (optimized away) 
      assign_stmt_71_x_xexit_x_xx_x21_symbol  <=  assign_stmt_71_147_symbol; -- place branch_block_stmt_40/assign_stmt_71__exit__ (optimized away) 
      assign_stmt_75_x_xentry_x_xx_x22_symbol  <=  assign_stmt_71_x_xexit_x_xx_x21_symbol; -- place branch_block_stmt_40/assign_stmt_75__entry__ (optimized away) 
      assign_stmt_75_x_xexit_x_xx_x23_symbol  <=  assign_stmt_75_189_symbol; -- place branch_block_stmt_40/assign_stmt_75__exit__ (optimized away) 
      assign_stmt_80_x_xentry_x_xx_x24_symbol  <=  assign_stmt_75_x_xexit_x_xx_x23_symbol; -- place branch_block_stmt_40/assign_stmt_80__entry__ (optimized away) 
      assign_stmt_80_x_xexit_x_xx_x25_symbol  <=  assign_stmt_80_231_symbol; -- place branch_block_stmt_40/assign_stmt_80__exit__ (optimized away) 
      assign_stmt_85_x_xentry_x_xx_x26_symbol  <=  assign_stmt_80_x_xexit_x_xx_x25_symbol; -- place branch_block_stmt_40/assign_stmt_85__entry__ (optimized away) 
      assign_stmt_85_x_xexit_x_xx_x27_symbol  <=  assign_stmt_85_244_symbol; -- place branch_block_stmt_40/assign_stmt_85__exit__ (optimized away) 
      assign_stmt_89_x_xentry_x_xx_x28_symbol  <=  assign_stmt_85_x_xexit_x_xx_x27_symbol; -- place branch_block_stmt_40/assign_stmt_89__entry__ (optimized away) 
      assign_stmt_89_x_xexit_x_xx_x29_symbol  <=  assign_stmt_89_248_symbol; -- place branch_block_stmt_40/assign_stmt_89__exit__ (optimized away) 
      assign_stmt_93_x_xentry_x_xx_x30_symbol  <=  assign_stmt_89_x_xexit_x_xx_x29_symbol; -- place branch_block_stmt_40/assign_stmt_93__entry__ (optimized away) 
      assign_stmt_93_x_xexit_x_xx_x31_symbol  <=  assign_stmt_93_261_symbol; -- place branch_block_stmt_40/assign_stmt_93__exit__ (optimized away) 
      assign_stmt_96_x_xentry_x_xx_x32_symbol  <=  assign_stmt_93_x_xexit_x_xx_x31_symbol; -- place branch_block_stmt_40/assign_stmt_96__entry__ (optimized away) 
      assign_stmt_96_x_xexit_x_xx_x33_symbol  <=  assign_stmt_96_303_symbol; -- place branch_block_stmt_40/assign_stmt_96__exit__ (optimized away) 
      return_x_xx_x34_symbol  <=  assign_stmt_96_x_xexit_x_xx_x33_symbol; -- place branch_block_stmt_40/return__ (optimized away) 
      merge_stmt_98_x_xexit_x_xx_x35_symbol  <=  merge_stmt_98_PhiAck_349_symbol; -- place branch_block_stmt_40/merge_stmt_98__exit__ (optimized away) 
      assign_stmt_101_x_xentry_x_xx_x36_symbol  <=  merge_stmt_98_x_xexit_x_xx_x35_symbol; -- place branch_block_stmt_40/assign_stmt_101__entry__ (optimized away) 
      assign_stmt_101_x_xexit_x_xx_x37_symbol  <=  assign_stmt_101_324_symbol; -- place branch_block_stmt_40/assign_stmt_101__exit__ (optimized away) 
      assign_stmt_46_38: Block -- branch_block_stmt_40/assign_stmt_46 
        signal assign_stmt_46_38_start: Boolean;
        signal Xentry_39_symbol: Boolean;
        signal Xexit_40_symbol: Boolean;
        signal dummy_41_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_46_38_start <= assign_stmt_46_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_39_symbol  <= assign_stmt_46_38_start; -- transition branch_block_stmt_40/assign_stmt_46/$entry
        dummy_41_symbol <= Xentry_39_symbol; -- transition branch_block_stmt_40/assign_stmt_46/dummy
        Xexit_40_symbol <= dummy_41_symbol; -- transition branch_block_stmt_40/assign_stmt_46/$exit
        assign_stmt_46_38_symbol <= Xexit_40_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_46
      assign_stmt_50_42: Block -- branch_block_stmt_40/assign_stmt_50 
        signal assign_stmt_50_42_start: Boolean;
        signal Xentry_43_symbol: Boolean;
        signal Xexit_44_symbol: Boolean;
        signal dummy_45_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_50_42_start <= assign_stmt_50_x_xentry_x_xx_x10_symbol; -- control passed to block
        Xentry_43_symbol  <= assign_stmt_50_42_start; -- transition branch_block_stmt_40/assign_stmt_50/$entry
        dummy_45_symbol <= Xentry_43_symbol; -- transition branch_block_stmt_40/assign_stmt_50/dummy
        Xexit_44_symbol <= dummy_45_symbol; -- transition branch_block_stmt_40/assign_stmt_50/$exit
        assign_stmt_50_42_symbol <= Xexit_44_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_50
      assign_stmt_54_46: Block -- branch_block_stmt_40/assign_stmt_54 
        signal assign_stmt_54_46_start: Boolean;
        signal Xentry_47_symbol: Boolean;
        signal Xexit_48_symbol: Boolean;
        signal ptr_deref_52_49_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_54_46_start <= assign_stmt_54_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_47_symbol  <= assign_stmt_54_46_start; -- transition branch_block_stmt_40/assign_stmt_54/$entry
        ptr_deref_52_49: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52 
          signal ptr_deref_52_49_start: Boolean;
          signal Xentry_50_symbol: Boolean;
          signal Xexit_51_symbol: Boolean;
          signal ptr_deref_52_write_52_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_52_49_start <= Xentry_47_symbol; -- control passed to block
          Xentry_50_symbol  <= ptr_deref_52_49_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/$entry
          ptr_deref_52_write_52: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write 
            signal ptr_deref_52_write_52_start: Boolean;
            signal Xentry_53_symbol: Boolean;
            signal Xexit_54_symbol: Boolean;
            signal split_req_55_symbol : Boolean;
            signal split_ack_56_symbol : Boolean;
            signal word_access_57_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_52_write_52_start <= Xentry_50_symbol; -- control passed to block
            Xentry_53_symbol  <= ptr_deref_52_write_52_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/$entry
            split_req_55_symbol <= Xentry_53_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/split_req
            ptr_deref_52_gather_scatter_req_0 <= split_req_55_symbol; -- link to DP
            split_ack_56_symbol <= ptr_deref_52_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/split_ack
            word_access_57: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access 
              signal word_access_57_start: Boolean;
              signal Xentry_58_symbol: Boolean;
              signal Xexit_59_symbol: Boolean;
              signal word_access_0_60_symbol : Boolean;
              signal word_access_1_67_symbol : Boolean;
              signal word_access_2_74_symbol : Boolean;
              signal word_access_3_81_symbol : Boolean;
              -- 
            begin -- 
              word_access_57_start <= split_ack_56_symbol; -- control passed to block
              Xentry_58_symbol  <= word_access_57_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/$entry
              word_access_0_60: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0 
                signal word_access_0_60_start: Boolean;
                signal Xentry_61_symbol: Boolean;
                signal Xexit_62_symbol: Boolean;
                signal rr_63_symbol : Boolean;
                signal ra_64_symbol : Boolean;
                signal cr_65_symbol : Boolean;
                signal ca_66_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_60_start <= Xentry_58_symbol; -- control passed to block
                Xentry_61_symbol  <= word_access_0_60_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0/$entry
                rr_63_symbol <= Xentry_61_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0/rr
                ptr_deref_52_store_0_req_0 <= rr_63_symbol; -- link to DP
                ra_64_symbol <= ptr_deref_52_store_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0/ra
                cr_65_symbol <= ra_64_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0/cr
                ptr_deref_52_store_0_req_1 <= cr_65_symbol; -- link to DP
                ca_66_symbol <= ptr_deref_52_store_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0/ca
                Xexit_62_symbol <= ca_66_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0/$exit
                word_access_0_60_symbol <= Xexit_62_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_0
              word_access_1_67: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1 
                signal word_access_1_67_start: Boolean;
                signal Xentry_68_symbol: Boolean;
                signal Xexit_69_symbol: Boolean;
                signal rr_70_symbol : Boolean;
                signal ra_71_symbol : Boolean;
                signal cr_72_symbol : Boolean;
                signal ca_73_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_67_start <= Xentry_58_symbol; -- control passed to block
                Xentry_68_symbol  <= word_access_1_67_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1/$entry
                rr_70_symbol <= Xentry_68_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1/rr
                ptr_deref_52_store_1_req_0 <= rr_70_symbol; -- link to DP
                ra_71_symbol <= ptr_deref_52_store_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1/ra
                cr_72_symbol <= ra_71_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1/cr
                ptr_deref_52_store_1_req_1 <= cr_72_symbol; -- link to DP
                ca_73_symbol <= ptr_deref_52_store_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1/ca
                Xexit_69_symbol <= ca_73_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1/$exit
                word_access_1_67_symbol <= Xexit_69_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_1
              word_access_2_74: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2 
                signal word_access_2_74_start: Boolean;
                signal Xentry_75_symbol: Boolean;
                signal Xexit_76_symbol: Boolean;
                signal rr_77_symbol : Boolean;
                signal ra_78_symbol : Boolean;
                signal cr_79_symbol : Boolean;
                signal ca_80_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_74_start <= Xentry_58_symbol; -- control passed to block
                Xentry_75_symbol  <= word_access_2_74_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2/$entry
                rr_77_symbol <= Xentry_75_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2/rr
                ptr_deref_52_store_2_req_0 <= rr_77_symbol; -- link to DP
                ra_78_symbol <= ptr_deref_52_store_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2/ra
                cr_79_symbol <= ra_78_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2/cr
                ptr_deref_52_store_2_req_1 <= cr_79_symbol; -- link to DP
                ca_80_symbol <= ptr_deref_52_store_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2/ca
                Xexit_76_symbol <= ca_80_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2/$exit
                word_access_2_74_symbol <= Xexit_76_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_2
              word_access_3_81: Block -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3 
                signal word_access_3_81_start: Boolean;
                signal Xentry_82_symbol: Boolean;
                signal Xexit_83_symbol: Boolean;
                signal rr_84_symbol : Boolean;
                signal ra_85_symbol : Boolean;
                signal cr_86_symbol : Boolean;
                signal ca_87_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_81_start <= Xentry_58_symbol; -- control passed to block
                Xentry_82_symbol  <= word_access_3_81_start; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3/$entry
                rr_84_symbol <= Xentry_82_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3/rr
                ptr_deref_52_store_3_req_0 <= rr_84_symbol; -- link to DP
                ra_85_symbol <= ptr_deref_52_store_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3/ra
                cr_86_symbol <= ra_85_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3/cr
                ptr_deref_52_store_3_req_1 <= cr_86_symbol; -- link to DP
                ca_87_symbol <= ptr_deref_52_store_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3/ca
                Xexit_83_symbol <= ca_87_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3/$exit
                word_access_3_81_symbol <= Xexit_83_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/word_access_3
              Xexit_59_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/$exit 
                signal Xexit_59_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_59_predecessors(0) <= word_access_0_60_symbol;
                Xexit_59_predecessors(1) <= word_access_1_67_symbol;
                Xexit_59_predecessors(2) <= word_access_2_74_symbol;
                Xexit_59_predecessors(3) <= word_access_3_81_symbol;
                Xexit_59_join: join -- 
                  port map( -- 
                    preds => Xexit_59_predecessors,
                    symbol_out => Xexit_59_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access/$exit
              word_access_57_symbol <= Xexit_59_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/word_access
            Xexit_54_symbol <= word_access_57_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write/$exit
            ptr_deref_52_write_52_symbol <= Xexit_54_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52/ptr_deref_52_write
          Xexit_51_symbol <= ptr_deref_52_write_52_symbol; -- transition branch_block_stmt_40/assign_stmt_54/ptr_deref_52/$exit
          ptr_deref_52_49_symbol <= Xexit_51_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_54/ptr_deref_52
        Xexit_48_symbol <= ptr_deref_52_49_symbol; -- transition branch_block_stmt_40/assign_stmt_54/$exit
        assign_stmt_54_46_symbol <= Xexit_48_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_54
      assign_stmt_59_88: Block -- branch_block_stmt_40/assign_stmt_59 
        signal assign_stmt_59_88_start: Boolean;
        signal Xentry_89_symbol: Boolean;
        signal Xexit_90_symbol: Boolean;
        signal dummy_91_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_59_88_start <= assign_stmt_59_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_89_symbol  <= assign_stmt_59_88_start; -- transition branch_block_stmt_40/assign_stmt_59/$entry
        dummy_91_symbol <= Xentry_89_symbol; -- transition branch_block_stmt_40/assign_stmt_59/dummy
        Xexit_90_symbol <= dummy_91_symbol; -- transition branch_block_stmt_40/assign_stmt_59/$exit
        assign_stmt_59_88_symbol <= Xexit_90_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_59
      assign_stmt_63_92: Block -- branch_block_stmt_40/assign_stmt_63 
        signal assign_stmt_63_92_start: Boolean;
        signal Xentry_93_symbol: Boolean;
        signal Xexit_94_symbol: Boolean;
        signal type_cast_62_95_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_63_92_start <= assign_stmt_63_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_93_symbol  <= assign_stmt_63_92_start; -- transition branch_block_stmt_40/assign_stmt_63/$entry
        type_cast_62_95: Block -- branch_block_stmt_40/assign_stmt_63/type_cast_62 
          signal type_cast_62_95_start: Boolean;
          signal Xentry_96_symbol: Boolean;
          signal Xexit_97_symbol: Boolean;
          signal simple_obj_ref_61_98_symbol : Boolean;
          signal req_103_symbol : Boolean;
          signal ack_104_symbol : Boolean;
          -- 
        begin -- 
          type_cast_62_95_start <= Xentry_93_symbol; -- control passed to block
          Xentry_96_symbol  <= type_cast_62_95_start; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/$entry
          simple_obj_ref_61_98: Block -- branch_block_stmt_40/assign_stmt_63/type_cast_62/simple_obj_ref_61 
            signal simple_obj_ref_61_98_start: Boolean;
            signal Xentry_99_symbol: Boolean;
            signal Xexit_100_symbol: Boolean;
            signal req_101_symbol : Boolean;
            signal ack_102_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_61_98_start <= Xentry_96_symbol; -- control passed to block
            Xentry_99_symbol  <= simple_obj_ref_61_98_start; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/simple_obj_ref_61/$entry
            req_101_symbol <= Xentry_99_symbol; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/simple_obj_ref_61/req
            simple_obj_ref_61_inst_req_0 <= req_101_symbol; -- link to DP
            ack_102_symbol <= simple_obj_ref_61_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/simple_obj_ref_61/ack
            Xexit_100_symbol <= ack_102_symbol; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/simple_obj_ref_61/$exit
            simple_obj_ref_61_98_symbol <= Xexit_100_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_63/type_cast_62/simple_obj_ref_61
          req_103_symbol <= simple_obj_ref_61_98_symbol; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/req
          type_cast_62_inst_req_0 <= req_103_symbol; -- link to DP
          ack_104_symbol <= type_cast_62_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/ack
          Xexit_97_symbol <= ack_104_symbol; -- transition branch_block_stmt_40/assign_stmt_63/type_cast_62/$exit
          type_cast_62_95_symbol <= Xexit_97_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_63/type_cast_62
        Xexit_94_symbol <= type_cast_62_95_symbol; -- transition branch_block_stmt_40/assign_stmt_63/$exit
        assign_stmt_63_92_symbol <= Xexit_94_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_63
      assign_stmt_67_105: Block -- branch_block_stmt_40/assign_stmt_67 
        signal assign_stmt_67_105_start: Boolean;
        signal Xentry_106_symbol: Boolean;
        signal Xexit_107_symbol: Boolean;
        signal ptr_deref_65_108_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_67_105_start <= assign_stmt_67_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_106_symbol  <= assign_stmt_67_105_start; -- transition branch_block_stmt_40/assign_stmt_67/$entry
        ptr_deref_65_108: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65 
          signal ptr_deref_65_108_start: Boolean;
          signal Xentry_109_symbol: Boolean;
          signal Xexit_110_symbol: Boolean;
          signal ptr_deref_65_write_111_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_65_108_start <= Xentry_106_symbol; -- control passed to block
          Xentry_109_symbol  <= ptr_deref_65_108_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/$entry
          ptr_deref_65_write_111: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write 
            signal ptr_deref_65_write_111_start: Boolean;
            signal Xentry_112_symbol: Boolean;
            signal Xexit_113_symbol: Boolean;
            signal split_req_114_symbol : Boolean;
            signal split_ack_115_symbol : Boolean;
            signal word_access_116_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_65_write_111_start <= Xentry_109_symbol; -- control passed to block
            Xentry_112_symbol  <= ptr_deref_65_write_111_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/$entry
            split_req_114_symbol <= Xentry_112_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/split_req
            ptr_deref_65_gather_scatter_req_0 <= split_req_114_symbol; -- link to DP
            split_ack_115_symbol <= ptr_deref_65_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/split_ack
            word_access_116: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access 
              signal word_access_116_start: Boolean;
              signal Xentry_117_symbol: Boolean;
              signal Xexit_118_symbol: Boolean;
              signal word_access_0_119_symbol : Boolean;
              signal word_access_1_126_symbol : Boolean;
              signal word_access_2_133_symbol : Boolean;
              signal word_access_3_140_symbol : Boolean;
              -- 
            begin -- 
              word_access_116_start <= split_ack_115_symbol; -- control passed to block
              Xentry_117_symbol  <= word_access_116_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/$entry
              word_access_0_119: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0 
                signal word_access_0_119_start: Boolean;
                signal Xentry_120_symbol: Boolean;
                signal Xexit_121_symbol: Boolean;
                signal rr_122_symbol : Boolean;
                signal ra_123_symbol : Boolean;
                signal cr_124_symbol : Boolean;
                signal ca_125_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_119_start <= Xentry_117_symbol; -- control passed to block
                Xentry_120_symbol  <= word_access_0_119_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0/$entry
                rr_122_symbol <= Xentry_120_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0/rr
                ptr_deref_65_store_0_req_0 <= rr_122_symbol; -- link to DP
                ra_123_symbol <= ptr_deref_65_store_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0/ra
                cr_124_symbol <= ra_123_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0/cr
                ptr_deref_65_store_0_req_1 <= cr_124_symbol; -- link to DP
                ca_125_symbol <= ptr_deref_65_store_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0/ca
                Xexit_121_symbol <= ca_125_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0/$exit
                word_access_0_119_symbol <= Xexit_121_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_0
              word_access_1_126: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1 
                signal word_access_1_126_start: Boolean;
                signal Xentry_127_symbol: Boolean;
                signal Xexit_128_symbol: Boolean;
                signal rr_129_symbol : Boolean;
                signal ra_130_symbol : Boolean;
                signal cr_131_symbol : Boolean;
                signal ca_132_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_126_start <= Xentry_117_symbol; -- control passed to block
                Xentry_127_symbol  <= word_access_1_126_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1/$entry
                rr_129_symbol <= Xentry_127_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1/rr
                ptr_deref_65_store_1_req_0 <= rr_129_symbol; -- link to DP
                ra_130_symbol <= ptr_deref_65_store_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1/ra
                cr_131_symbol <= ra_130_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1/cr
                ptr_deref_65_store_1_req_1 <= cr_131_symbol; -- link to DP
                ca_132_symbol <= ptr_deref_65_store_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1/ca
                Xexit_128_symbol <= ca_132_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1/$exit
                word_access_1_126_symbol <= Xexit_128_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_1
              word_access_2_133: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2 
                signal word_access_2_133_start: Boolean;
                signal Xentry_134_symbol: Boolean;
                signal Xexit_135_symbol: Boolean;
                signal rr_136_symbol : Boolean;
                signal ra_137_symbol : Boolean;
                signal cr_138_symbol : Boolean;
                signal ca_139_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_133_start <= Xentry_117_symbol; -- control passed to block
                Xentry_134_symbol  <= word_access_2_133_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2/$entry
                rr_136_symbol <= Xentry_134_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2/rr
                ptr_deref_65_store_2_req_0 <= rr_136_symbol; -- link to DP
                ra_137_symbol <= ptr_deref_65_store_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2/ra
                cr_138_symbol <= ra_137_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2/cr
                ptr_deref_65_store_2_req_1 <= cr_138_symbol; -- link to DP
                ca_139_symbol <= ptr_deref_65_store_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2/ca
                Xexit_135_symbol <= ca_139_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2/$exit
                word_access_2_133_symbol <= Xexit_135_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_2
              word_access_3_140: Block -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3 
                signal word_access_3_140_start: Boolean;
                signal Xentry_141_symbol: Boolean;
                signal Xexit_142_symbol: Boolean;
                signal rr_143_symbol : Boolean;
                signal ra_144_symbol : Boolean;
                signal cr_145_symbol : Boolean;
                signal ca_146_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_140_start <= Xentry_117_symbol; -- control passed to block
                Xentry_141_symbol  <= word_access_3_140_start; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3/$entry
                rr_143_symbol <= Xentry_141_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3/rr
                ptr_deref_65_store_3_req_0 <= rr_143_symbol; -- link to DP
                ra_144_symbol <= ptr_deref_65_store_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3/ra
                cr_145_symbol <= ra_144_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3/cr
                ptr_deref_65_store_3_req_1 <= cr_145_symbol; -- link to DP
                ca_146_symbol <= ptr_deref_65_store_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3/ca
                Xexit_142_symbol <= ca_146_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3/$exit
                word_access_3_140_symbol <= Xexit_142_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/word_access_3
              Xexit_118_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/$exit 
                signal Xexit_118_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_118_predecessors(0) <= word_access_0_119_symbol;
                Xexit_118_predecessors(1) <= word_access_1_126_symbol;
                Xexit_118_predecessors(2) <= word_access_2_133_symbol;
                Xexit_118_predecessors(3) <= word_access_3_140_symbol;
                Xexit_118_join: join -- 
                  port map( -- 
                    preds => Xexit_118_predecessors,
                    symbol_out => Xexit_118_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access/$exit
              word_access_116_symbol <= Xexit_118_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/word_access
            Xexit_113_symbol <= word_access_116_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write/$exit
            ptr_deref_65_write_111_symbol <= Xexit_113_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65/ptr_deref_65_write
          Xexit_110_symbol <= ptr_deref_65_write_111_symbol; -- transition branch_block_stmt_40/assign_stmt_67/ptr_deref_65/$exit
          ptr_deref_65_108_symbol <= Xexit_110_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_67/ptr_deref_65
        Xexit_107_symbol <= ptr_deref_65_108_symbol; -- transition branch_block_stmt_40/assign_stmt_67/$exit
        assign_stmt_67_105_symbol <= Xexit_107_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_67
      assign_stmt_71_147: Block -- branch_block_stmt_40/assign_stmt_71 
        signal assign_stmt_71_147_start: Boolean;
        signal Xentry_148_symbol: Boolean;
        signal Xexit_149_symbol: Boolean;
        signal ptr_deref_70_150_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_71_147_start <= assign_stmt_71_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_148_symbol  <= assign_stmt_71_147_start; -- transition branch_block_stmt_40/assign_stmt_71/$entry
        ptr_deref_70_150: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70 
          signal ptr_deref_70_150_start: Boolean;
          signal Xentry_151_symbol: Boolean;
          signal Xexit_152_symbol: Boolean;
          signal ptr_deref_70_read_153_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_70_150_start <= Xentry_148_symbol; -- control passed to block
          Xentry_151_symbol  <= ptr_deref_70_150_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/$entry
          ptr_deref_70_read_153: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read 
            signal ptr_deref_70_read_153_start: Boolean;
            signal Xentry_154_symbol: Boolean;
            signal Xexit_155_symbol: Boolean;
            signal word_access_156_symbol : Boolean;
            signal merge_req_187_symbol : Boolean;
            signal merge_ack_188_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_70_read_153_start <= Xentry_151_symbol; -- control passed to block
            Xentry_154_symbol  <= ptr_deref_70_read_153_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/$entry
            word_access_156: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access 
              signal word_access_156_start: Boolean;
              signal Xentry_157_symbol: Boolean;
              signal Xexit_158_symbol: Boolean;
              signal word_access_0_159_symbol : Boolean;
              signal word_access_1_166_symbol : Boolean;
              signal word_access_2_173_symbol : Boolean;
              signal word_access_3_180_symbol : Boolean;
              -- 
            begin -- 
              word_access_156_start <= Xentry_154_symbol; -- control passed to block
              Xentry_157_symbol  <= word_access_156_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/$entry
              word_access_0_159: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0 
                signal word_access_0_159_start: Boolean;
                signal Xentry_160_symbol: Boolean;
                signal Xexit_161_symbol: Boolean;
                signal rr_162_symbol : Boolean;
                signal ra_163_symbol : Boolean;
                signal cr_164_symbol : Boolean;
                signal ca_165_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_159_start <= Xentry_157_symbol; -- control passed to block
                Xentry_160_symbol  <= word_access_0_159_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0/$entry
                rr_162_symbol <= Xentry_160_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0/rr
                ptr_deref_70_load_0_req_0 <= rr_162_symbol; -- link to DP
                ra_163_symbol <= ptr_deref_70_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0/ra
                cr_164_symbol <= ra_163_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0/cr
                ptr_deref_70_load_0_req_1 <= cr_164_symbol; -- link to DP
                ca_165_symbol <= ptr_deref_70_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0/ca
                Xexit_161_symbol <= ca_165_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0/$exit
                word_access_0_159_symbol <= Xexit_161_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_0
              word_access_1_166: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1 
                signal word_access_1_166_start: Boolean;
                signal Xentry_167_symbol: Boolean;
                signal Xexit_168_symbol: Boolean;
                signal rr_169_symbol : Boolean;
                signal ra_170_symbol : Boolean;
                signal cr_171_symbol : Boolean;
                signal ca_172_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_166_start <= Xentry_157_symbol; -- control passed to block
                Xentry_167_symbol  <= word_access_1_166_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1/$entry
                rr_169_symbol <= Xentry_167_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1/rr
                ptr_deref_70_load_1_req_0 <= rr_169_symbol; -- link to DP
                ra_170_symbol <= ptr_deref_70_load_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1/ra
                cr_171_symbol <= ra_170_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1/cr
                ptr_deref_70_load_1_req_1 <= cr_171_symbol; -- link to DP
                ca_172_symbol <= ptr_deref_70_load_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1/ca
                Xexit_168_symbol <= ca_172_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1/$exit
                word_access_1_166_symbol <= Xexit_168_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_1
              word_access_2_173: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2 
                signal word_access_2_173_start: Boolean;
                signal Xentry_174_symbol: Boolean;
                signal Xexit_175_symbol: Boolean;
                signal rr_176_symbol : Boolean;
                signal ra_177_symbol : Boolean;
                signal cr_178_symbol : Boolean;
                signal ca_179_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_173_start <= Xentry_157_symbol; -- control passed to block
                Xentry_174_symbol  <= word_access_2_173_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2/$entry
                rr_176_symbol <= Xentry_174_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2/rr
                ptr_deref_70_load_2_req_0 <= rr_176_symbol; -- link to DP
                ra_177_symbol <= ptr_deref_70_load_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2/ra
                cr_178_symbol <= ra_177_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2/cr
                ptr_deref_70_load_2_req_1 <= cr_178_symbol; -- link to DP
                ca_179_symbol <= ptr_deref_70_load_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2/ca
                Xexit_175_symbol <= ca_179_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2/$exit
                word_access_2_173_symbol <= Xexit_175_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_2
              word_access_3_180: Block -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3 
                signal word_access_3_180_start: Boolean;
                signal Xentry_181_symbol: Boolean;
                signal Xexit_182_symbol: Boolean;
                signal rr_183_symbol : Boolean;
                signal ra_184_symbol : Boolean;
                signal cr_185_symbol : Boolean;
                signal ca_186_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_180_start <= Xentry_157_symbol; -- control passed to block
                Xentry_181_symbol  <= word_access_3_180_start; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3/$entry
                rr_183_symbol <= Xentry_181_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3/rr
                ptr_deref_70_load_3_req_0 <= rr_183_symbol; -- link to DP
                ra_184_symbol <= ptr_deref_70_load_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3/ra
                cr_185_symbol <= ra_184_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3/cr
                ptr_deref_70_load_3_req_1 <= cr_185_symbol; -- link to DP
                ca_186_symbol <= ptr_deref_70_load_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3/ca
                Xexit_182_symbol <= ca_186_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3/$exit
                word_access_3_180_symbol <= Xexit_182_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/word_access_3
              Xexit_158_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/$exit 
                signal Xexit_158_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_158_predecessors(0) <= word_access_0_159_symbol;
                Xexit_158_predecessors(1) <= word_access_1_166_symbol;
                Xexit_158_predecessors(2) <= word_access_2_173_symbol;
                Xexit_158_predecessors(3) <= word_access_3_180_symbol;
                Xexit_158_join: join -- 
                  port map( -- 
                    preds => Xexit_158_predecessors,
                    symbol_out => Xexit_158_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access/$exit
              word_access_156_symbol <= Xexit_158_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/word_access
            merge_req_187_symbol <= word_access_156_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/merge_req
            ptr_deref_70_gather_scatter_req_0 <= merge_req_187_symbol; -- link to DP
            merge_ack_188_symbol <= ptr_deref_70_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/merge_ack
            Xexit_155_symbol <= merge_ack_188_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read/$exit
            ptr_deref_70_read_153_symbol <= Xexit_155_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70/ptr_deref_70_read
          Xexit_152_symbol <= ptr_deref_70_read_153_symbol; -- transition branch_block_stmt_40/assign_stmt_71/ptr_deref_70/$exit
          ptr_deref_70_150_symbol <= Xexit_152_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_71/ptr_deref_70
        Xexit_149_symbol <= ptr_deref_70_150_symbol; -- transition branch_block_stmt_40/assign_stmt_71/$exit
        assign_stmt_71_147_symbol <= Xexit_149_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_71
      assign_stmt_75_189: Block -- branch_block_stmt_40/assign_stmt_75 
        signal assign_stmt_75_189_start: Boolean;
        signal Xentry_190_symbol: Boolean;
        signal Xexit_191_symbol: Boolean;
        signal ptr_deref_74_192_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_75_189_start <= assign_stmt_75_x_xentry_x_xx_x22_symbol; -- control passed to block
        Xentry_190_symbol  <= assign_stmt_75_189_start; -- transition branch_block_stmt_40/assign_stmt_75/$entry
        ptr_deref_74_192: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74 
          signal ptr_deref_74_192_start: Boolean;
          signal Xentry_193_symbol: Boolean;
          signal Xexit_194_symbol: Boolean;
          signal ptr_deref_74_read_195_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_74_192_start <= Xentry_190_symbol; -- control passed to block
          Xentry_193_symbol  <= ptr_deref_74_192_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/$entry
          ptr_deref_74_read_195: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read 
            signal ptr_deref_74_read_195_start: Boolean;
            signal Xentry_196_symbol: Boolean;
            signal Xexit_197_symbol: Boolean;
            signal word_access_198_symbol : Boolean;
            signal merge_req_229_symbol : Boolean;
            signal merge_ack_230_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_74_read_195_start <= Xentry_193_symbol; -- control passed to block
            Xentry_196_symbol  <= ptr_deref_74_read_195_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/$entry
            word_access_198: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access 
              signal word_access_198_start: Boolean;
              signal Xentry_199_symbol: Boolean;
              signal Xexit_200_symbol: Boolean;
              signal word_access_0_201_symbol : Boolean;
              signal word_access_1_208_symbol : Boolean;
              signal word_access_2_215_symbol : Boolean;
              signal word_access_3_222_symbol : Boolean;
              -- 
            begin -- 
              word_access_198_start <= Xentry_196_symbol; -- control passed to block
              Xentry_199_symbol  <= word_access_198_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/$entry
              word_access_0_201: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0 
                signal word_access_0_201_start: Boolean;
                signal Xentry_202_symbol: Boolean;
                signal Xexit_203_symbol: Boolean;
                signal rr_204_symbol : Boolean;
                signal ra_205_symbol : Boolean;
                signal cr_206_symbol : Boolean;
                signal ca_207_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_201_start <= Xentry_199_symbol; -- control passed to block
                Xentry_202_symbol  <= word_access_0_201_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0/$entry
                rr_204_symbol <= Xentry_202_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0/rr
                ptr_deref_74_load_0_req_0 <= rr_204_symbol; -- link to DP
                ra_205_symbol <= ptr_deref_74_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0/ra
                cr_206_symbol <= ra_205_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0/cr
                ptr_deref_74_load_0_req_1 <= cr_206_symbol; -- link to DP
                ca_207_symbol <= ptr_deref_74_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0/ca
                Xexit_203_symbol <= ca_207_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0/$exit
                word_access_0_201_symbol <= Xexit_203_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_0
              word_access_1_208: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1 
                signal word_access_1_208_start: Boolean;
                signal Xentry_209_symbol: Boolean;
                signal Xexit_210_symbol: Boolean;
                signal rr_211_symbol : Boolean;
                signal ra_212_symbol : Boolean;
                signal cr_213_symbol : Boolean;
                signal ca_214_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_208_start <= Xentry_199_symbol; -- control passed to block
                Xentry_209_symbol  <= word_access_1_208_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1/$entry
                rr_211_symbol <= Xentry_209_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1/rr
                ptr_deref_74_load_1_req_0 <= rr_211_symbol; -- link to DP
                ra_212_symbol <= ptr_deref_74_load_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1/ra
                cr_213_symbol <= ra_212_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1/cr
                ptr_deref_74_load_1_req_1 <= cr_213_symbol; -- link to DP
                ca_214_symbol <= ptr_deref_74_load_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1/ca
                Xexit_210_symbol <= ca_214_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1/$exit
                word_access_1_208_symbol <= Xexit_210_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_1
              word_access_2_215: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2 
                signal word_access_2_215_start: Boolean;
                signal Xentry_216_symbol: Boolean;
                signal Xexit_217_symbol: Boolean;
                signal rr_218_symbol : Boolean;
                signal ra_219_symbol : Boolean;
                signal cr_220_symbol : Boolean;
                signal ca_221_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_215_start <= Xentry_199_symbol; -- control passed to block
                Xentry_216_symbol  <= word_access_2_215_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2/$entry
                rr_218_symbol <= Xentry_216_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2/rr
                ptr_deref_74_load_2_req_0 <= rr_218_symbol; -- link to DP
                ra_219_symbol <= ptr_deref_74_load_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2/ra
                cr_220_symbol <= ra_219_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2/cr
                ptr_deref_74_load_2_req_1 <= cr_220_symbol; -- link to DP
                ca_221_symbol <= ptr_deref_74_load_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2/ca
                Xexit_217_symbol <= ca_221_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2/$exit
                word_access_2_215_symbol <= Xexit_217_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_2
              word_access_3_222: Block -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3 
                signal word_access_3_222_start: Boolean;
                signal Xentry_223_symbol: Boolean;
                signal Xexit_224_symbol: Boolean;
                signal rr_225_symbol : Boolean;
                signal ra_226_symbol : Boolean;
                signal cr_227_symbol : Boolean;
                signal ca_228_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_222_start <= Xentry_199_symbol; -- control passed to block
                Xentry_223_symbol  <= word_access_3_222_start; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3/$entry
                rr_225_symbol <= Xentry_223_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3/rr
                ptr_deref_74_load_3_req_0 <= rr_225_symbol; -- link to DP
                ra_226_symbol <= ptr_deref_74_load_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3/ra
                cr_227_symbol <= ra_226_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3/cr
                ptr_deref_74_load_3_req_1 <= cr_227_symbol; -- link to DP
                ca_228_symbol <= ptr_deref_74_load_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3/ca
                Xexit_224_symbol <= ca_228_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3/$exit
                word_access_3_222_symbol <= Xexit_224_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/word_access_3
              Xexit_200_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/$exit 
                signal Xexit_200_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_200_predecessors(0) <= word_access_0_201_symbol;
                Xexit_200_predecessors(1) <= word_access_1_208_symbol;
                Xexit_200_predecessors(2) <= word_access_2_215_symbol;
                Xexit_200_predecessors(3) <= word_access_3_222_symbol;
                Xexit_200_join: join -- 
                  port map( -- 
                    preds => Xexit_200_predecessors,
                    symbol_out => Xexit_200_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access/$exit
              word_access_198_symbol <= Xexit_200_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/word_access
            merge_req_229_symbol <= word_access_198_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/merge_req
            ptr_deref_74_gather_scatter_req_0 <= merge_req_229_symbol; -- link to DP
            merge_ack_230_symbol <= ptr_deref_74_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/merge_ack
            Xexit_197_symbol <= merge_ack_230_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read/$exit
            ptr_deref_74_read_195_symbol <= Xexit_197_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74/ptr_deref_74_read
          Xexit_194_symbol <= ptr_deref_74_read_195_symbol; -- transition branch_block_stmt_40/assign_stmt_75/ptr_deref_74/$exit
          ptr_deref_74_192_symbol <= Xexit_194_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_75/ptr_deref_74
        Xexit_191_symbol <= ptr_deref_74_192_symbol; -- transition branch_block_stmt_40/assign_stmt_75/$exit
        assign_stmt_75_189_symbol <= Xexit_191_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_75
      assign_stmt_80_231: Block -- branch_block_stmt_40/assign_stmt_80 
        signal assign_stmt_80_231_start: Boolean;
        signal Xentry_232_symbol: Boolean;
        signal Xexit_233_symbol: Boolean;
        signal binary_79_234_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_80_231_start <= assign_stmt_80_x_xentry_x_xx_x24_symbol; -- control passed to block
        Xentry_232_symbol  <= assign_stmt_80_231_start; -- transition branch_block_stmt_40/assign_stmt_80/$entry
        binary_79_234: Block -- branch_block_stmt_40/assign_stmt_80/binary_79 
          signal binary_79_234_start: Boolean;
          signal Xentry_235_symbol: Boolean;
          signal Xexit_236_symbol: Boolean;
          signal binary_79_inputs_237_symbol : Boolean;
          signal rr_240_symbol : Boolean;
          signal ra_241_symbol : Boolean;
          signal cr_242_symbol : Boolean;
          signal ca_243_symbol : Boolean;
          -- 
        begin -- 
          binary_79_234_start <= Xentry_232_symbol; -- control passed to block
          Xentry_235_symbol  <= binary_79_234_start; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/$entry
          binary_79_inputs_237: Block -- branch_block_stmt_40/assign_stmt_80/binary_79/binary_79_inputs 
            signal binary_79_inputs_237_start: Boolean;
            signal Xentry_238_symbol: Boolean;
            signal Xexit_239_symbol: Boolean;
            -- 
          begin -- 
            binary_79_inputs_237_start <= Xentry_235_symbol; -- control passed to block
            Xentry_238_symbol  <= binary_79_inputs_237_start; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/binary_79_inputs/$entry
            Xexit_239_symbol <= Xentry_238_symbol; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/binary_79_inputs/$exit
            binary_79_inputs_237_symbol <= Xexit_239_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_80/binary_79/binary_79_inputs
          rr_240_symbol <= binary_79_inputs_237_symbol; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/rr
          binary_79_inst_req_0 <= rr_240_symbol; -- link to DP
          ra_241_symbol <= binary_79_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/ra
          cr_242_symbol <= ra_241_symbol; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/cr
          binary_79_inst_req_1 <= cr_242_symbol; -- link to DP
          ca_243_symbol <= binary_79_inst_ack_1; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/ca
          Xexit_236_symbol <= ca_243_symbol; -- transition branch_block_stmt_40/assign_stmt_80/binary_79/$exit
          binary_79_234_symbol <= Xexit_236_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_80/binary_79
        Xexit_233_symbol <= binary_79_234_symbol; -- transition branch_block_stmt_40/assign_stmt_80/$exit
        assign_stmt_80_231_symbol <= Xexit_233_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_80
      assign_stmt_85_244: Block -- branch_block_stmt_40/assign_stmt_85 
        signal assign_stmt_85_244_start: Boolean;
        signal Xentry_245_symbol: Boolean;
        signal Xexit_246_symbol: Boolean;
        signal dummy_247_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_85_244_start <= assign_stmt_85_x_xentry_x_xx_x26_symbol; -- control passed to block
        Xentry_245_symbol  <= assign_stmt_85_244_start; -- transition branch_block_stmt_40/assign_stmt_85/$entry
        dummy_247_symbol <= Xentry_245_symbol; -- transition branch_block_stmt_40/assign_stmt_85/dummy
        Xexit_246_symbol <= dummy_247_symbol; -- transition branch_block_stmt_40/assign_stmt_85/$exit
        assign_stmt_85_244_symbol <= Xexit_246_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_85
      assign_stmt_89_248: Block -- branch_block_stmt_40/assign_stmt_89 
        signal assign_stmt_89_248_start: Boolean;
        signal Xentry_249_symbol: Boolean;
        signal Xexit_250_symbol: Boolean;
        signal type_cast_88_251_symbol : Boolean;
        signal simple_obj_ref_86_256_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_89_248_start <= assign_stmt_89_x_xentry_x_xx_x28_symbol; -- control passed to block
        Xentry_249_symbol  <= assign_stmt_89_248_start; -- transition branch_block_stmt_40/assign_stmt_89/$entry
        type_cast_88_251: Block -- branch_block_stmt_40/assign_stmt_89/type_cast_88 
          signal type_cast_88_251_start: Boolean;
          signal Xentry_252_symbol: Boolean;
          signal Xexit_253_symbol: Boolean;
          signal req_254_symbol : Boolean;
          signal ack_255_symbol : Boolean;
          -- 
        begin -- 
          type_cast_88_251_start <= Xentry_249_symbol; -- control passed to block
          Xentry_252_symbol  <= type_cast_88_251_start; -- transition branch_block_stmt_40/assign_stmt_89/type_cast_88/$entry
          req_254_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_40/assign_stmt_89/type_cast_88/req
          type_cast_88_inst_req_0 <= req_254_symbol; -- link to DP
          ack_255_symbol <= type_cast_88_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_89/type_cast_88/ack
          Xexit_253_symbol <= ack_255_symbol; -- transition branch_block_stmt_40/assign_stmt_89/type_cast_88/$exit
          type_cast_88_251_symbol <= Xexit_253_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_89/type_cast_88
        simple_obj_ref_86_256: Block -- branch_block_stmt_40/assign_stmt_89/simple_obj_ref_86 
          signal simple_obj_ref_86_256_start: Boolean;
          signal Xentry_257_symbol: Boolean;
          signal Xexit_258_symbol: Boolean;
          signal pipe_wreq_259_symbol : Boolean;
          signal pipe_wack_260_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_86_256_start <= type_cast_88_251_symbol; -- control passed to block
          Xentry_257_symbol  <= simple_obj_ref_86_256_start; -- transition branch_block_stmt_40/assign_stmt_89/simple_obj_ref_86/$entry
          pipe_wreq_259_symbol <= Xentry_257_symbol; -- transition branch_block_stmt_40/assign_stmt_89/simple_obj_ref_86/pipe_wreq
          simple_obj_ref_86_inst_req_0 <= pipe_wreq_259_symbol; -- link to DP
          pipe_wack_260_symbol <= simple_obj_ref_86_inst_ack_0; -- transition branch_block_stmt_40/assign_stmt_89/simple_obj_ref_86/pipe_wack
          Xexit_258_symbol <= pipe_wack_260_symbol; -- transition branch_block_stmt_40/assign_stmt_89/simple_obj_ref_86/$exit
          simple_obj_ref_86_256_symbol <= Xexit_258_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_89/simple_obj_ref_86
        Xexit_250_symbol <= simple_obj_ref_86_256_symbol; -- transition branch_block_stmt_40/assign_stmt_89/$exit
        assign_stmt_89_248_symbol <= Xexit_250_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_89
      assign_stmt_93_261: Block -- branch_block_stmt_40/assign_stmt_93 
        signal assign_stmt_93_261_start: Boolean;
        signal Xentry_262_symbol: Boolean;
        signal Xexit_263_symbol: Boolean;
        signal ptr_deref_92_264_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_93_261_start <= assign_stmt_93_x_xentry_x_xx_x30_symbol; -- control passed to block
        Xentry_262_symbol  <= assign_stmt_93_261_start; -- transition branch_block_stmt_40/assign_stmt_93/$entry
        ptr_deref_92_264: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92 
          signal ptr_deref_92_264_start: Boolean;
          signal Xentry_265_symbol: Boolean;
          signal Xexit_266_symbol: Boolean;
          signal ptr_deref_92_read_267_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_92_264_start <= Xentry_262_symbol; -- control passed to block
          Xentry_265_symbol  <= ptr_deref_92_264_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/$entry
          ptr_deref_92_read_267: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read 
            signal ptr_deref_92_read_267_start: Boolean;
            signal Xentry_268_symbol: Boolean;
            signal Xexit_269_symbol: Boolean;
            signal word_access_270_symbol : Boolean;
            signal merge_req_301_symbol : Boolean;
            signal merge_ack_302_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_92_read_267_start <= Xentry_265_symbol; -- control passed to block
            Xentry_268_symbol  <= ptr_deref_92_read_267_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/$entry
            word_access_270: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access 
              signal word_access_270_start: Boolean;
              signal Xentry_271_symbol: Boolean;
              signal Xexit_272_symbol: Boolean;
              signal word_access_0_273_symbol : Boolean;
              signal word_access_1_280_symbol : Boolean;
              signal word_access_2_287_symbol : Boolean;
              signal word_access_3_294_symbol : Boolean;
              -- 
            begin -- 
              word_access_270_start <= Xentry_268_symbol; -- control passed to block
              Xentry_271_symbol  <= word_access_270_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/$entry
              word_access_0_273: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0 
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
                Xentry_274_symbol  <= word_access_0_273_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0/$entry
                rr_276_symbol <= Xentry_274_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0/rr
                ptr_deref_92_load_0_req_0 <= rr_276_symbol; -- link to DP
                ra_277_symbol <= ptr_deref_92_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0/ra
                cr_278_symbol <= ra_277_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0/cr
                ptr_deref_92_load_0_req_1 <= cr_278_symbol; -- link to DP
                ca_279_symbol <= ptr_deref_92_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0/ca
                Xexit_275_symbol <= ca_279_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0/$exit
                word_access_0_273_symbol <= Xexit_275_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_0
              word_access_1_280: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1 
                signal word_access_1_280_start: Boolean;
                signal Xentry_281_symbol: Boolean;
                signal Xexit_282_symbol: Boolean;
                signal rr_283_symbol : Boolean;
                signal ra_284_symbol : Boolean;
                signal cr_285_symbol : Boolean;
                signal ca_286_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_280_start <= Xentry_271_symbol; -- control passed to block
                Xentry_281_symbol  <= word_access_1_280_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1/$entry
                rr_283_symbol <= Xentry_281_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1/rr
                ptr_deref_92_load_1_req_0 <= rr_283_symbol; -- link to DP
                ra_284_symbol <= ptr_deref_92_load_1_ack_0; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1/ra
                cr_285_symbol <= ra_284_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1/cr
                ptr_deref_92_load_1_req_1 <= cr_285_symbol; -- link to DP
                ca_286_symbol <= ptr_deref_92_load_1_ack_1; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1/ca
                Xexit_282_symbol <= ca_286_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1/$exit
                word_access_1_280_symbol <= Xexit_282_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_1
              word_access_2_287: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2 
                signal word_access_2_287_start: Boolean;
                signal Xentry_288_symbol: Boolean;
                signal Xexit_289_symbol: Boolean;
                signal rr_290_symbol : Boolean;
                signal ra_291_symbol : Boolean;
                signal cr_292_symbol : Boolean;
                signal ca_293_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_287_start <= Xentry_271_symbol; -- control passed to block
                Xentry_288_symbol  <= word_access_2_287_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2/$entry
                rr_290_symbol <= Xentry_288_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2/rr
                ptr_deref_92_load_2_req_0 <= rr_290_symbol; -- link to DP
                ra_291_symbol <= ptr_deref_92_load_2_ack_0; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2/ra
                cr_292_symbol <= ra_291_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2/cr
                ptr_deref_92_load_2_req_1 <= cr_292_symbol; -- link to DP
                ca_293_symbol <= ptr_deref_92_load_2_ack_1; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2/ca
                Xexit_289_symbol <= ca_293_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2/$exit
                word_access_2_287_symbol <= Xexit_289_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_2
              word_access_3_294: Block -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3 
                signal word_access_3_294_start: Boolean;
                signal Xentry_295_symbol: Boolean;
                signal Xexit_296_symbol: Boolean;
                signal rr_297_symbol : Boolean;
                signal ra_298_symbol : Boolean;
                signal cr_299_symbol : Boolean;
                signal ca_300_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_294_start <= Xentry_271_symbol; -- control passed to block
                Xentry_295_symbol  <= word_access_3_294_start; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3/$entry
                rr_297_symbol <= Xentry_295_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3/rr
                ptr_deref_92_load_3_req_0 <= rr_297_symbol; -- link to DP
                ra_298_symbol <= ptr_deref_92_load_3_ack_0; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3/ra
                cr_299_symbol <= ra_298_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3/cr
                ptr_deref_92_load_3_req_1 <= cr_299_symbol; -- link to DP
                ca_300_symbol <= ptr_deref_92_load_3_ack_1; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3/ca
                Xexit_296_symbol <= ca_300_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3/$exit
                word_access_3_294_symbol <= Xexit_296_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/word_access_3
              Xexit_272_block : Block -- non-trivial join transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/$exit 
                signal Xexit_272_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_272_predecessors(0) <= word_access_0_273_symbol;
                Xexit_272_predecessors(1) <= word_access_1_280_symbol;
                Xexit_272_predecessors(2) <= word_access_2_287_symbol;
                Xexit_272_predecessors(3) <= word_access_3_294_symbol;
                Xexit_272_join: join -- 
                  port map( -- 
                    preds => Xexit_272_predecessors,
                    symbol_out => Xexit_272_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access/$exit
              word_access_270_symbol <= Xexit_272_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/word_access
            merge_req_301_symbol <= word_access_270_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/merge_req
            ptr_deref_92_gather_scatter_req_0 <= merge_req_301_symbol; -- link to DP
            merge_ack_302_symbol <= ptr_deref_92_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/merge_ack
            Xexit_269_symbol <= merge_ack_302_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read/$exit
            ptr_deref_92_read_267_symbol <= Xexit_269_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92/ptr_deref_92_read
          Xexit_266_symbol <= ptr_deref_92_read_267_symbol; -- transition branch_block_stmt_40/assign_stmt_93/ptr_deref_92/$exit
          ptr_deref_92_264_symbol <= Xexit_266_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_93/ptr_deref_92
        Xexit_263_symbol <= ptr_deref_92_264_symbol; -- transition branch_block_stmt_40/assign_stmt_93/$exit
        assign_stmt_93_261_symbol <= Xexit_263_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_93
      assign_stmt_96_303: Block -- branch_block_stmt_40/assign_stmt_96 
        signal assign_stmt_96_303_start: Boolean;
        signal Xentry_304_symbol: Boolean;
        signal Xexit_305_symbol: Boolean;
        signal simple_obj_ref_94_306_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_96_303_start <= assign_stmt_96_x_xentry_x_xx_x32_symbol; -- control passed to block
        Xentry_304_symbol  <= assign_stmt_96_303_start; -- transition branch_block_stmt_40/assign_stmt_96/$entry
        simple_obj_ref_94_306: Block -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94 
          signal simple_obj_ref_94_306_start: Boolean;
          signal Xentry_307_symbol: Boolean;
          signal Xexit_308_symbol: Boolean;
          signal simple_obj_ref_94_write_309_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_94_306_start <= Xentry_304_symbol; -- control passed to block
          Xentry_307_symbol  <= simple_obj_ref_94_306_start; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/$entry
          simple_obj_ref_94_write_309: Block -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write 
            signal simple_obj_ref_94_write_309_start: Boolean;
            signal Xentry_310_symbol: Boolean;
            signal Xexit_311_symbol: Boolean;
            signal split_req_312_symbol : Boolean;
            signal split_ack_313_symbol : Boolean;
            signal word_access_314_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_94_write_309_start <= Xentry_307_symbol; -- control passed to block
            Xentry_310_symbol  <= simple_obj_ref_94_write_309_start; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/$entry
            split_req_312_symbol <= Xentry_310_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/split_req
            simple_obj_ref_94_gather_scatter_req_0 <= split_req_312_symbol; -- link to DP
            split_ack_313_symbol <= simple_obj_ref_94_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/split_ack
            word_access_314: Block -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access 
              signal word_access_314_start: Boolean;
              signal Xentry_315_symbol: Boolean;
              signal Xexit_316_symbol: Boolean;
              signal word_access_0_317_symbol : Boolean;
              -- 
            begin -- 
              word_access_314_start <= split_ack_313_symbol; -- control passed to block
              Xentry_315_symbol  <= word_access_314_start; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/$entry
              word_access_0_317: Block -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0 
                signal word_access_0_317_start: Boolean;
                signal Xentry_318_symbol: Boolean;
                signal Xexit_319_symbol: Boolean;
                signal rr_320_symbol : Boolean;
                signal ra_321_symbol : Boolean;
                signal cr_322_symbol : Boolean;
                signal ca_323_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_317_start <= Xentry_315_symbol; -- control passed to block
                Xentry_318_symbol  <= word_access_0_317_start; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0/$entry
                rr_320_symbol <= Xentry_318_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0/rr
                simple_obj_ref_94_store_0_req_0 <= rr_320_symbol; -- link to DP
                ra_321_symbol <= simple_obj_ref_94_store_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0/ra
                cr_322_symbol <= ra_321_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0/cr
                simple_obj_ref_94_store_0_req_1 <= cr_322_symbol; -- link to DP
                ca_323_symbol <= simple_obj_ref_94_store_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0/ca
                Xexit_319_symbol <= ca_323_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0/$exit
                word_access_0_317_symbol <= Xexit_319_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/word_access_0
              Xexit_316_symbol <= word_access_0_317_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access/$exit
              word_access_314_symbol <= Xexit_316_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/word_access
            Xexit_311_symbol <= word_access_314_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write/$exit
            simple_obj_ref_94_write_309_symbol <= Xexit_311_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/simple_obj_ref_94_write
          Xexit_308_symbol <= simple_obj_ref_94_write_309_symbol; -- transition branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94/$exit
          simple_obj_ref_94_306_symbol <= Xexit_308_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_96/simple_obj_ref_94
        Xexit_305_symbol <= simple_obj_ref_94_306_symbol; -- transition branch_block_stmt_40/assign_stmt_96/$exit
        assign_stmt_96_303_symbol <= Xexit_305_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_96
      assign_stmt_101_324: Block -- branch_block_stmt_40/assign_stmt_101 
        signal assign_stmt_101_324_start: Boolean;
        signal Xentry_325_symbol: Boolean;
        signal Xexit_326_symbol: Boolean;
        signal simple_obj_ref_100_327_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_101_324_start <= assign_stmt_101_x_xentry_x_xx_x36_symbol; -- control passed to block
        Xentry_325_symbol  <= assign_stmt_101_324_start; -- transition branch_block_stmt_40/assign_stmt_101/$entry
        simple_obj_ref_100_327: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100 
          signal simple_obj_ref_100_327_start: Boolean;
          signal Xentry_328_symbol: Boolean;
          signal Xexit_329_symbol: Boolean;
          signal simple_obj_ref_100_read_330_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_100_327_start <= Xentry_325_symbol; -- control passed to block
          Xentry_328_symbol  <= simple_obj_ref_100_327_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/$entry
          simple_obj_ref_100_read_330: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read 
            signal simple_obj_ref_100_read_330_start: Boolean;
            signal Xentry_331_symbol: Boolean;
            signal Xexit_332_symbol: Boolean;
            signal word_access_333_symbol : Boolean;
            signal merge_req_343_symbol : Boolean;
            signal merge_ack_344_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_100_read_330_start <= Xentry_328_symbol; -- control passed to block
            Xentry_331_symbol  <= simple_obj_ref_100_read_330_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/$entry
            word_access_333: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access 
              signal word_access_333_start: Boolean;
              signal Xentry_334_symbol: Boolean;
              signal Xexit_335_symbol: Boolean;
              signal word_access_0_336_symbol : Boolean;
              -- 
            begin -- 
              word_access_333_start <= Xentry_331_symbol; -- control passed to block
              Xentry_334_symbol  <= word_access_333_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/$entry
              word_access_0_336: Block -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0 
                signal word_access_0_336_start: Boolean;
                signal Xentry_337_symbol: Boolean;
                signal Xexit_338_symbol: Boolean;
                signal rr_339_symbol : Boolean;
                signal ra_340_symbol : Boolean;
                signal cr_341_symbol : Boolean;
                signal ca_342_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_336_start <= Xentry_334_symbol; -- control passed to block
                Xentry_337_symbol  <= word_access_0_336_start; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0/$entry
                rr_339_symbol <= Xentry_337_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0/rr
                simple_obj_ref_100_load_0_req_0 <= rr_339_symbol; -- link to DP
                ra_340_symbol <= simple_obj_ref_100_load_0_ack_0; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0/ra
                cr_341_symbol <= ra_340_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0/cr
                simple_obj_ref_100_load_0_req_1 <= cr_341_symbol; -- link to DP
                ca_342_symbol <= simple_obj_ref_100_load_0_ack_1; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0/ca
                Xexit_338_symbol <= ca_342_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0/$exit
                word_access_0_336_symbol <= Xexit_338_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/word_access_0
              Xexit_335_symbol <= word_access_0_336_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access/$exit
              word_access_333_symbol <= Xexit_335_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/word_access
            merge_req_343_symbol <= word_access_333_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/merge_req
            simple_obj_ref_100_gather_scatter_req_0 <= merge_req_343_symbol; -- link to DP
            merge_ack_344_symbol <= simple_obj_ref_100_gather_scatter_ack_0; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/merge_ack
            Xexit_332_symbol <= merge_ack_344_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read/$exit
            simple_obj_ref_100_read_330_symbol <= Xexit_332_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/simple_obj_ref_100_read
          Xexit_329_symbol <= simple_obj_ref_100_read_330_symbol; -- transition branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100/$exit
          simple_obj_ref_100_327_symbol <= Xexit_329_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_40/assign_stmt_101/simple_obj_ref_100
        Xexit_326_symbol <= simple_obj_ref_100_327_symbol; -- transition branch_block_stmt_40/assign_stmt_101/$exit
        assign_stmt_101_324_symbol <= Xexit_326_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/assign_stmt_101
      return_x_xx_xPhiReq_345: Block -- branch_block_stmt_40/return___PhiReq 
        signal return_x_xx_xPhiReq_345_start: Boolean;
        signal Xentry_346_symbol: Boolean;
        signal Xexit_347_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_345_start <= return_x_xx_x34_symbol; -- control passed to block
        Xentry_346_symbol  <= return_x_xx_xPhiReq_345_start; -- transition branch_block_stmt_40/return___PhiReq/$entry
        Xexit_347_symbol <= Xentry_346_symbol; -- transition branch_block_stmt_40/return___PhiReq/$exit
        return_x_xx_xPhiReq_345_symbol <= Xexit_347_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_40/return___PhiReq
      merge_stmt_98_PhiReqMerge_348_symbol  <=  return_x_xx_xPhiReq_345_symbol; -- place branch_block_stmt_40/merge_stmt_98_PhiReqMerge (optimized away) 
      merge_stmt_98_PhiAck_349: Block -- branch_block_stmt_40/merge_stmt_98_PhiAck 
        signal merge_stmt_98_PhiAck_349_start: Boolean;
        signal Xentry_350_symbol: Boolean;
        signal Xexit_351_symbol: Boolean;
        signal dummy_352_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_98_PhiAck_349_start <= merge_stmt_98_PhiReqMerge_348_symbol; -- control passed to block
        Xentry_350_symbol  <= merge_stmt_98_PhiAck_349_start; -- transition branch_block_stmt_40/merge_stmt_98_PhiAck/$entry
        dummy_352_symbol <= Xentry_350_symbol; -- transition branch_block_stmt_40/merge_stmt_98_PhiAck/dummy
        Xexit_351_symbol <= dummy_352_symbol; -- transition branch_block_stmt_40/merge_stmt_98_PhiAck/$exit
        merge_stmt_98_PhiAck_349_symbol <= Xexit_351_symbol; -- control passed from block 
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
    -- shared load operator group (0) : ptr_deref_70_load_0 ptr_deref_74_load_0 ptr_deref_92_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_70_load_0_req_0;
      reqL(1) <= ptr_deref_74_load_0_req_0;
      reqL(0) <= ptr_deref_92_load_0_req_0;
      ptr_deref_70_load_0_ack_0 <= ackL(2);
      ptr_deref_74_load_0_ack_0 <= ackL(1);
      ptr_deref_92_load_0_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_70_load_0_req_1;
      reqR(1) <= ptr_deref_74_load_0_req_1;
      reqR(0) <= ptr_deref_92_load_0_req_1;
      ptr_deref_70_load_0_ack_1 <= ackR(2);
      ptr_deref_74_load_0_ack_1 <= ackR(1);
      ptr_deref_92_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_0 & ptr_deref_74_word_address_0 & ptr_deref_92_word_address_0;
      ptr_deref_70_data_0 <= data_out(23 downto 16);
      ptr_deref_74_data_0 <= data_out(15 downto 8);
      ptr_deref_92_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(3),
          mack => memory_space_0_lr_ack(3),
          maddr => memory_space_0_lr_addr(19 downto 15),
          mtag => memory_space_0_lr_tag(7 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(3),
          mack => memory_space_0_lc_ack(3),
          mdata => memory_space_0_lc_data(31 downto 24),
          mtag => memory_space_0_lc_tag(7 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_70_load_1 ptr_deref_74_load_1 ptr_deref_92_load_1 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_70_load_1_req_0;
      reqL(1) <= ptr_deref_74_load_1_req_0;
      reqL(0) <= ptr_deref_92_load_1_req_0;
      ptr_deref_70_load_1_ack_0 <= ackL(2);
      ptr_deref_74_load_1_ack_0 <= ackL(1);
      ptr_deref_92_load_1_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_70_load_1_req_1;
      reqR(1) <= ptr_deref_74_load_1_req_1;
      reqR(0) <= ptr_deref_92_load_1_req_1;
      ptr_deref_70_load_1_ack_1 <= ackR(2);
      ptr_deref_74_load_1_ack_1 <= ackR(1);
      ptr_deref_92_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_1 & ptr_deref_74_word_address_1 & ptr_deref_92_word_address_1;
      ptr_deref_70_data_1 <= data_out(23 downto 16);
      ptr_deref_74_data_1 <= data_out(15 downto 8);
      ptr_deref_92_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(2),
          mack => memory_space_0_lr_ack(2),
          maddr => memory_space_0_lr_addr(14 downto 10),
          mtag => memory_space_0_lr_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(2),
          mack => memory_space_0_lc_ack(2),
          mdata => memory_space_0_lc_data(23 downto 16),
          mtag => memory_space_0_lc_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : ptr_deref_70_load_2 ptr_deref_74_load_2 ptr_deref_92_load_2 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_70_load_2_req_0;
      reqL(1) <= ptr_deref_74_load_2_req_0;
      reqL(0) <= ptr_deref_92_load_2_req_0;
      ptr_deref_70_load_2_ack_0 <= ackL(2);
      ptr_deref_74_load_2_ack_0 <= ackL(1);
      ptr_deref_92_load_2_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_70_load_2_req_1;
      reqR(1) <= ptr_deref_74_load_2_req_1;
      reqR(0) <= ptr_deref_92_load_2_req_1;
      ptr_deref_70_load_2_ack_1 <= ackR(2);
      ptr_deref_74_load_2_ack_1 <= ackR(1);
      ptr_deref_92_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_2 & ptr_deref_74_word_address_2 & ptr_deref_92_word_address_2;
      ptr_deref_70_data_2 <= data_out(23 downto 16);
      ptr_deref_74_data_2 <= data_out(15 downto 8);
      ptr_deref_92_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(1),
          mack => memory_space_0_lr_ack(1),
          maddr => memory_space_0_lr_addr(9 downto 5),
          mtag => memory_space_0_lr_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(1),
          mack => memory_space_0_lc_ack(1),
          mdata => memory_space_0_lc_data(15 downto 8),
          mtag => memory_space_0_lc_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : ptr_deref_70_load_3 ptr_deref_74_load_3 ptr_deref_92_load_3 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_70_load_3_req_0;
      reqL(1) <= ptr_deref_74_load_3_req_0;
      reqL(0) <= ptr_deref_92_load_3_req_0;
      ptr_deref_70_load_3_ack_0 <= ackL(2);
      ptr_deref_74_load_3_ack_0 <= ackL(1);
      ptr_deref_92_load_3_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_70_load_3_req_1;
      reqR(1) <= ptr_deref_74_load_3_req_1;
      reqR(0) <= ptr_deref_92_load_3_req_1;
      ptr_deref_70_load_3_ack_1 <= ackR(2);
      ptr_deref_74_load_3_ack_1 <= ackR(1);
      ptr_deref_92_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_70_word_address_3 & ptr_deref_74_word_address_3 & ptr_deref_92_word_address_3;
      ptr_deref_70_data_3 <= data_out(23 downto 16);
      ptr_deref_74_data_3 <= data_out(15 downto 8);
      ptr_deref_92_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(4 downto 0),
          mtag => memory_space_0_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(7 downto 0),
          mtag => memory_space_0_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 3
    -- shared load operator group (4) : simple_obj_ref_100_load_0 
    LoadGroup4: Block -- 
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
    end Block; -- load group 4
    -- shared store operator group (0) : ptr_deref_52_store_0 ptr_deref_65_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_52_store_0_req_0;
      reqL(0) <= ptr_deref_65_store_0_req_0;
      ptr_deref_52_store_0_ack_0 <= ackL(1);
      ptr_deref_65_store_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_52_store_0_req_1;
      reqR(0) <= ptr_deref_65_store_0_req_1;
      ptr_deref_52_store_0_ack_1 <= ackR(1);
      ptr_deref_65_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_0 & ptr_deref_65_word_address_0;
      data_in <= ptr_deref_52_data_0 & ptr_deref_65_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(7 downto 6),
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
          mreq => memory_space_0_sc_req(3),
          mack => memory_space_0_sc_ack(3),
          mtag => memory_space_0_sc_tag(7 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_52_store_1 ptr_deref_65_store_1 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_52_store_1_req_0;
      reqL(0) <= ptr_deref_65_store_1_req_0;
      ptr_deref_52_store_1_ack_0 <= ackL(1);
      ptr_deref_65_store_1_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_52_store_1_req_1;
      reqR(0) <= ptr_deref_65_store_1_req_1;
      ptr_deref_52_store_1_ack_1 <= ackR(1);
      ptr_deref_65_store_1_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_1 & ptr_deref_65_word_address_1;
      data_in <= ptr_deref_52_data_1 & ptr_deref_65_data_1;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(5 downto 4),
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
          mreq => memory_space_0_sc_req(2),
          mack => memory_space_0_sc_ack(2),
          mtag => memory_space_0_sc_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : ptr_deref_52_store_2 ptr_deref_65_store_2 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_52_store_2_req_0;
      reqL(0) <= ptr_deref_65_store_2_req_0;
      ptr_deref_52_store_2_ack_0 <= ackL(1);
      ptr_deref_65_store_2_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_52_store_2_req_1;
      reqR(0) <= ptr_deref_65_store_2_req_1;
      ptr_deref_52_store_2_ack_1 <= ackR(1);
      ptr_deref_65_store_2_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_2 & ptr_deref_65_word_address_2;
      data_in <= ptr_deref_52_data_2 & ptr_deref_65_data_2;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(3 downto 2),
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
          mreq => memory_space_0_sc_req(1),
          mack => memory_space_0_sc_ack(1),
          mtag => memory_space_0_sc_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared store operator group (3) : ptr_deref_52_store_3 ptr_deref_65_store_3 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_52_store_3_req_0;
      reqL(0) <= ptr_deref_65_store_3_req_0;
      ptr_deref_52_store_3_ack_0 <= ackL(1);
      ptr_deref_65_store_3_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_52_store_3_req_1;
      reqR(0) <= ptr_deref_65_store_3_req_1;
      ptr_deref_52_store_3_ack_1 <= ackR(1);
      ptr_deref_65_store_3_ack_1 <= ackR(0);
      addr_in <= ptr_deref_52_word_address_3 & ptr_deref_65_word_address_3;
      data_in <= ptr_deref_52_data_3 & ptr_deref_65_data_3;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(1 downto 0),
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
          mreq => memory_space_0_sc_req(0),
          mack => memory_space_0_sc_ack(0),
          mtag => memory_space_0_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 3
    -- shared store operator group (4) : simple_obj_ref_94_store_0 
    StoreGroup4: Block -- 
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
    end Block; -- store group 4
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
    memory_space_0_lr_req : out  std_logic_vector(3 downto 0);
    memory_space_0_lr_ack : in   std_logic_vector(3 downto 0);
    memory_space_0_lr_addr : out  std_logic_vector(19 downto 0);
    memory_space_0_lr_tag :  out  std_logic_vector(7 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(3 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(3 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(7 downto 0);
    memory_space_0_sr_req : out  std_logic_vector(3 downto 0);
    memory_space_0_sr_ack : in   std_logic_vector(3 downto 0);
    memory_space_0_sr_addr : out  std_logic_vector(19 downto 0);
    memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
    memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(3 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(3 downto 0);
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
  signal ptr_deref_120_gather_scatter_req_0 : boolean;
  signal ptr_deref_120_gather_scatter_ack_0 : boolean;
  signal ptr_deref_120_store_0_req_0 : boolean;
  signal ptr_deref_120_store_0_ack_0 : boolean;
  signal ptr_deref_120_store_0_req_1 : boolean;
  signal ptr_deref_120_store_0_ack_1 : boolean;
  signal ptr_deref_120_store_1_req_0 : boolean;
  signal ptr_deref_120_store_1_ack_0 : boolean;
  signal ptr_deref_120_store_1_req_1 : boolean;
  signal ptr_deref_120_store_1_ack_1 : boolean;
  signal ptr_deref_120_store_2_req_0 : boolean;
  signal ptr_deref_120_store_2_ack_0 : boolean;
  signal ptr_deref_120_store_2_req_1 : boolean;
  signal ptr_deref_120_store_2_ack_1 : boolean;
  signal ptr_deref_120_store_3_req_0 : boolean;
  signal ptr_deref_120_store_3_ack_0 : boolean;
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
  signal ptr_deref_133_store_0_req_1 : boolean;
  signal ptr_deref_133_store_0_ack_1 : boolean;
  signal ptr_deref_133_store_1_req_0 : boolean;
  signal ptr_deref_133_store_1_ack_0 : boolean;
  signal ptr_deref_133_store_1_req_1 : boolean;
  signal ptr_deref_133_store_1_ack_1 : boolean;
  signal ptr_deref_133_store_2_req_0 : boolean;
  signal ptr_deref_133_store_2_ack_0 : boolean;
  signal ptr_deref_133_store_2_req_1 : boolean;
  signal ptr_deref_133_store_2_ack_1 : boolean;
  signal ptr_deref_133_store_3_req_0 : boolean;
  signal ptr_deref_133_store_3_ack_0 : boolean;
  signal ptr_deref_133_store_3_req_1 : boolean;
  signal ptr_deref_133_store_3_ack_1 : boolean;
  signal ptr_deref_138_load_0_req_0 : boolean;
  signal ptr_deref_138_load_0_ack_0 : boolean;
  signal ptr_deref_138_load_0_req_1 : boolean;
  signal ptr_deref_138_load_0_ack_1 : boolean;
  signal ptr_deref_138_load_1_req_0 : boolean;
  signal ptr_deref_138_load_1_ack_0 : boolean;
  signal ptr_deref_138_load_1_req_1 : boolean;
  signal ptr_deref_138_load_1_ack_1 : boolean;
  signal ptr_deref_138_load_2_req_0 : boolean;
  signal ptr_deref_138_load_2_ack_0 : boolean;
  signal ptr_deref_138_load_2_req_1 : boolean;
  signal ptr_deref_138_load_2_ack_1 : boolean;
  signal ptr_deref_138_load_3_req_0 : boolean;
  signal ptr_deref_138_load_3_ack_0 : boolean;
  signal ptr_deref_138_load_3_req_1 : boolean;
  signal ptr_deref_138_load_3_ack_1 : boolean;
  signal ptr_deref_138_gather_scatter_req_0 : boolean;
  signal ptr_deref_138_gather_scatter_ack_0 : boolean;
  signal ptr_deref_142_load_0_req_0 : boolean;
  signal ptr_deref_142_load_0_ack_0 : boolean;
  signal ptr_deref_142_load_0_req_1 : boolean;
  signal ptr_deref_142_load_0_ack_1 : boolean;
  signal ptr_deref_142_load_1_req_0 : boolean;
  signal ptr_deref_142_load_1_ack_0 : boolean;
  signal ptr_deref_142_load_1_req_1 : boolean;
  signal ptr_deref_142_load_1_ack_1 : boolean;
  signal ptr_deref_142_load_2_req_0 : boolean;
  signal ptr_deref_142_load_2_ack_0 : boolean;
  signal ptr_deref_142_load_2_req_1 : boolean;
  signal ptr_deref_142_load_2_ack_1 : boolean;
  signal ptr_deref_142_load_3_req_0 : boolean;
  signal ptr_deref_142_load_3_ack_0 : boolean;
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
  signal ptr_deref_160_load_0_req_0 : boolean;
  signal ptr_deref_160_load_0_ack_0 : boolean;
  signal ptr_deref_160_load_0_req_1 : boolean;
  signal ptr_deref_160_load_0_ack_1 : boolean;
  signal ptr_deref_160_load_1_req_0 : boolean;
  signal ptr_deref_160_load_1_ack_0 : boolean;
  signal ptr_deref_160_load_1_req_1 : boolean;
  signal ptr_deref_160_load_1_ack_1 : boolean;
  signal ptr_deref_160_load_2_req_0 : boolean;
  signal ptr_deref_160_load_2_ack_0 : boolean;
  signal ptr_deref_160_load_2_req_1 : boolean;
  signal ptr_deref_160_load_2_ack_1 : boolean;
  signal ptr_deref_160_load_3_req_0 : boolean;
  signal ptr_deref_160_load_3_ack_0 : boolean;
  signal ptr_deref_160_load_3_req_1 : boolean;
  signal ptr_deref_160_load_3_ack_1 : boolean;
  signal ptr_deref_160_gather_scatter_req_0 : boolean;
  signal ptr_deref_160_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_162_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_162_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_162_store_0_req_0 : boolean;
  signal simple_obj_ref_162_store_0_ack_0 : boolean;
  signal simple_obj_ref_162_store_0_req_1 : boolean;
  signal simple_obj_ref_162_store_0_ack_1 : boolean;
  signal simple_obj_ref_168_load_0_req_0 : boolean;
  signal simple_obj_ref_168_load_0_ack_0 : boolean;
  signal simple_obj_ref_168_load_0_req_1 : boolean;
  signal simple_obj_ref_168_load_0_ack_1 : boolean;
  signal simple_obj_ref_168_gather_scatter_req_0 : boolean;
  signal simple_obj_ref_168_gather_scatter_ack_0 : boolean;
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
  foo_CP_353: Block -- control-path 
    signal foo_CP_353_start: Boolean;
    signal Xentry_354_symbol: Boolean;
    signal Xexit_355_symbol: Boolean;
    signal branch_block_stmt_108_356_symbol : Boolean;
    -- 
  begin -- 
    foo_CP_353_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_354_symbol  <= foo_CP_353_start; -- transition $entry
    branch_block_stmt_108_356: Block -- branch_block_stmt_108 
      signal branch_block_stmt_108_356_start: Boolean;
      signal Xentry_357_symbol: Boolean;
      signal Xexit_358_symbol: Boolean;
      signal branch_block_stmt_108_x_xentry_x_xx_x359_symbol : Boolean;
      signal branch_block_stmt_108_x_xexit_x_xx_x360_symbol : Boolean;
      signal assign_stmt_114_x_xentry_x_xx_x361_symbol : Boolean;
      signal assign_stmt_114_x_xexit_x_xx_x362_symbol : Boolean;
      signal assign_stmt_118_x_xentry_x_xx_x363_symbol : Boolean;
      signal assign_stmt_118_x_xexit_x_xx_x364_symbol : Boolean;
      signal assign_stmt_122_x_xentry_x_xx_x365_symbol : Boolean;
      signal assign_stmt_122_x_xexit_x_xx_x366_symbol : Boolean;
      signal assign_stmt_127_x_xentry_x_xx_x367_symbol : Boolean;
      signal assign_stmt_127_x_xexit_x_xx_x368_symbol : Boolean;
      signal assign_stmt_131_x_xentry_x_xx_x369_symbol : Boolean;
      signal assign_stmt_131_x_xexit_x_xx_x370_symbol : Boolean;
      signal assign_stmt_135_x_xentry_x_xx_x371_symbol : Boolean;
      signal assign_stmt_135_x_xexit_x_xx_x372_symbol : Boolean;
      signal assign_stmt_139_x_xentry_x_xx_x373_symbol : Boolean;
      signal assign_stmt_139_x_xexit_x_xx_x374_symbol : Boolean;
      signal assign_stmt_143_x_xentry_x_xx_x375_symbol : Boolean;
      signal assign_stmt_143_x_xexit_x_xx_x376_symbol : Boolean;
      signal assign_stmt_148_x_xentry_x_xx_x377_symbol : Boolean;
      signal assign_stmt_148_x_xexit_x_xx_x378_symbol : Boolean;
      signal assign_stmt_153_x_xentry_x_xx_x379_symbol : Boolean;
      signal assign_stmt_153_x_xexit_x_xx_x380_symbol : Boolean;
      signal assign_stmt_157_x_xentry_x_xx_x381_symbol : Boolean;
      signal assign_stmt_157_x_xexit_x_xx_x382_symbol : Boolean;
      signal assign_stmt_161_x_xentry_x_xx_x383_symbol : Boolean;
      signal assign_stmt_161_x_xexit_x_xx_x384_symbol : Boolean;
      signal assign_stmt_164_x_xentry_x_xx_x385_symbol : Boolean;
      signal assign_stmt_164_x_xexit_x_xx_x386_symbol : Boolean;
      signal return_x_xx_x387_symbol : Boolean;
      signal merge_stmt_166_x_xexit_x_xx_x388_symbol : Boolean;
      signal assign_stmt_169_x_xentry_x_xx_x389_symbol : Boolean;
      signal assign_stmt_169_x_xexit_x_xx_x390_symbol : Boolean;
      signal assign_stmt_114_391_symbol : Boolean;
      signal assign_stmt_118_395_symbol : Boolean;
      signal assign_stmt_122_399_symbol : Boolean;
      signal assign_stmt_127_441_symbol : Boolean;
      signal assign_stmt_131_445_symbol : Boolean;
      signal assign_stmt_135_458_symbol : Boolean;
      signal assign_stmt_139_500_symbol : Boolean;
      signal assign_stmt_143_542_symbol : Boolean;
      signal assign_stmt_148_584_symbol : Boolean;
      signal assign_stmt_153_597_symbol : Boolean;
      signal assign_stmt_157_601_symbol : Boolean;
      signal assign_stmt_161_614_symbol : Boolean;
      signal assign_stmt_164_656_symbol : Boolean;
      signal assign_stmt_169_677_symbol : Boolean;
      signal return_x_xx_xPhiReq_698_symbol : Boolean;
      signal merge_stmt_166_PhiReqMerge_701_symbol : Boolean;
      signal merge_stmt_166_PhiAck_702_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_108_356_start <= Xentry_354_symbol; -- control passed to block
      Xentry_357_symbol  <= branch_block_stmt_108_356_start; -- transition branch_block_stmt_108/$entry
      branch_block_stmt_108_x_xentry_x_xx_x359_symbol  <=  Xentry_357_symbol; -- place branch_block_stmt_108/branch_block_stmt_108__entry__ (optimized away) 
      branch_block_stmt_108_x_xexit_x_xx_x360_symbol  <=  assign_stmt_169_x_xexit_x_xx_x390_symbol; -- place branch_block_stmt_108/branch_block_stmt_108__exit__ (optimized away) 
      assign_stmt_114_x_xentry_x_xx_x361_symbol  <=  branch_block_stmt_108_x_xentry_x_xx_x359_symbol; -- place branch_block_stmt_108/assign_stmt_114__entry__ (optimized away) 
      assign_stmt_114_x_xexit_x_xx_x362_symbol  <=  assign_stmt_114_391_symbol; -- place branch_block_stmt_108/assign_stmt_114__exit__ (optimized away) 
      assign_stmt_118_x_xentry_x_xx_x363_symbol  <=  assign_stmt_114_x_xexit_x_xx_x362_symbol; -- place branch_block_stmt_108/assign_stmt_118__entry__ (optimized away) 
      assign_stmt_118_x_xexit_x_xx_x364_symbol  <=  assign_stmt_118_395_symbol; -- place branch_block_stmt_108/assign_stmt_118__exit__ (optimized away) 
      assign_stmt_122_x_xentry_x_xx_x365_symbol  <=  assign_stmt_118_x_xexit_x_xx_x364_symbol; -- place branch_block_stmt_108/assign_stmt_122__entry__ (optimized away) 
      assign_stmt_122_x_xexit_x_xx_x366_symbol  <=  assign_stmt_122_399_symbol; -- place branch_block_stmt_108/assign_stmt_122__exit__ (optimized away) 
      assign_stmt_127_x_xentry_x_xx_x367_symbol  <=  assign_stmt_122_x_xexit_x_xx_x366_symbol; -- place branch_block_stmt_108/assign_stmt_127__entry__ (optimized away) 
      assign_stmt_127_x_xexit_x_xx_x368_symbol  <=  assign_stmt_127_441_symbol; -- place branch_block_stmt_108/assign_stmt_127__exit__ (optimized away) 
      assign_stmt_131_x_xentry_x_xx_x369_symbol  <=  assign_stmt_127_x_xexit_x_xx_x368_symbol; -- place branch_block_stmt_108/assign_stmt_131__entry__ (optimized away) 
      assign_stmt_131_x_xexit_x_xx_x370_symbol  <=  assign_stmt_131_445_symbol; -- place branch_block_stmt_108/assign_stmt_131__exit__ (optimized away) 
      assign_stmt_135_x_xentry_x_xx_x371_symbol  <=  assign_stmt_131_x_xexit_x_xx_x370_symbol; -- place branch_block_stmt_108/assign_stmt_135__entry__ (optimized away) 
      assign_stmt_135_x_xexit_x_xx_x372_symbol  <=  assign_stmt_135_458_symbol; -- place branch_block_stmt_108/assign_stmt_135__exit__ (optimized away) 
      assign_stmt_139_x_xentry_x_xx_x373_symbol  <=  assign_stmt_135_x_xexit_x_xx_x372_symbol; -- place branch_block_stmt_108/assign_stmt_139__entry__ (optimized away) 
      assign_stmt_139_x_xexit_x_xx_x374_symbol  <=  assign_stmt_139_500_symbol; -- place branch_block_stmt_108/assign_stmt_139__exit__ (optimized away) 
      assign_stmt_143_x_xentry_x_xx_x375_symbol  <=  assign_stmt_139_x_xexit_x_xx_x374_symbol; -- place branch_block_stmt_108/assign_stmt_143__entry__ (optimized away) 
      assign_stmt_143_x_xexit_x_xx_x376_symbol  <=  assign_stmt_143_542_symbol; -- place branch_block_stmt_108/assign_stmt_143__exit__ (optimized away) 
      assign_stmt_148_x_xentry_x_xx_x377_symbol  <=  assign_stmt_143_x_xexit_x_xx_x376_symbol; -- place branch_block_stmt_108/assign_stmt_148__entry__ (optimized away) 
      assign_stmt_148_x_xexit_x_xx_x378_symbol  <=  assign_stmt_148_584_symbol; -- place branch_block_stmt_108/assign_stmt_148__exit__ (optimized away) 
      assign_stmt_153_x_xentry_x_xx_x379_symbol  <=  assign_stmt_148_x_xexit_x_xx_x378_symbol; -- place branch_block_stmt_108/assign_stmt_153__entry__ (optimized away) 
      assign_stmt_153_x_xexit_x_xx_x380_symbol  <=  assign_stmt_153_597_symbol; -- place branch_block_stmt_108/assign_stmt_153__exit__ (optimized away) 
      assign_stmt_157_x_xentry_x_xx_x381_symbol  <=  assign_stmt_153_x_xexit_x_xx_x380_symbol; -- place branch_block_stmt_108/assign_stmt_157__entry__ (optimized away) 
      assign_stmt_157_x_xexit_x_xx_x382_symbol  <=  assign_stmt_157_601_symbol; -- place branch_block_stmt_108/assign_stmt_157__exit__ (optimized away) 
      assign_stmt_161_x_xentry_x_xx_x383_symbol  <=  assign_stmt_157_x_xexit_x_xx_x382_symbol; -- place branch_block_stmt_108/assign_stmt_161__entry__ (optimized away) 
      assign_stmt_161_x_xexit_x_xx_x384_symbol  <=  assign_stmt_161_614_symbol; -- place branch_block_stmt_108/assign_stmt_161__exit__ (optimized away) 
      assign_stmt_164_x_xentry_x_xx_x385_symbol  <=  assign_stmt_161_x_xexit_x_xx_x384_symbol; -- place branch_block_stmt_108/assign_stmt_164__entry__ (optimized away) 
      assign_stmt_164_x_xexit_x_xx_x386_symbol  <=  assign_stmt_164_656_symbol; -- place branch_block_stmt_108/assign_stmt_164__exit__ (optimized away) 
      return_x_xx_x387_symbol  <=  assign_stmt_164_x_xexit_x_xx_x386_symbol; -- place branch_block_stmt_108/return__ (optimized away) 
      merge_stmt_166_x_xexit_x_xx_x388_symbol  <=  merge_stmt_166_PhiAck_702_symbol; -- place branch_block_stmt_108/merge_stmt_166__exit__ (optimized away) 
      assign_stmt_169_x_xentry_x_xx_x389_symbol  <=  merge_stmt_166_x_xexit_x_xx_x388_symbol; -- place branch_block_stmt_108/assign_stmt_169__entry__ (optimized away) 
      assign_stmt_169_x_xexit_x_xx_x390_symbol  <=  assign_stmt_169_677_symbol; -- place branch_block_stmt_108/assign_stmt_169__exit__ (optimized away) 
      assign_stmt_114_391: Block -- branch_block_stmt_108/assign_stmt_114 
        signal assign_stmt_114_391_start: Boolean;
        signal Xentry_392_symbol: Boolean;
        signal Xexit_393_symbol: Boolean;
        signal dummy_394_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_114_391_start <= assign_stmt_114_x_xentry_x_xx_x361_symbol; -- control passed to block
        Xentry_392_symbol  <= assign_stmt_114_391_start; -- transition branch_block_stmt_108/assign_stmt_114/$entry
        dummy_394_symbol <= Xentry_392_symbol; -- transition branch_block_stmt_108/assign_stmt_114/dummy
        Xexit_393_symbol <= dummy_394_symbol; -- transition branch_block_stmt_108/assign_stmt_114/$exit
        assign_stmt_114_391_symbol <= Xexit_393_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_114
      assign_stmt_118_395: Block -- branch_block_stmt_108/assign_stmt_118 
        signal assign_stmt_118_395_start: Boolean;
        signal Xentry_396_symbol: Boolean;
        signal Xexit_397_symbol: Boolean;
        signal dummy_398_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_118_395_start <= assign_stmt_118_x_xentry_x_xx_x363_symbol; -- control passed to block
        Xentry_396_symbol  <= assign_stmt_118_395_start; -- transition branch_block_stmt_108/assign_stmt_118/$entry
        dummy_398_symbol <= Xentry_396_symbol; -- transition branch_block_stmt_108/assign_stmt_118/dummy
        Xexit_397_symbol <= dummy_398_symbol; -- transition branch_block_stmt_108/assign_stmt_118/$exit
        assign_stmt_118_395_symbol <= Xexit_397_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_118
      assign_stmt_122_399: Block -- branch_block_stmt_108/assign_stmt_122 
        signal assign_stmt_122_399_start: Boolean;
        signal Xentry_400_symbol: Boolean;
        signal Xexit_401_symbol: Boolean;
        signal ptr_deref_120_402_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_122_399_start <= assign_stmt_122_x_xentry_x_xx_x365_symbol; -- control passed to block
        Xentry_400_symbol  <= assign_stmt_122_399_start; -- transition branch_block_stmt_108/assign_stmt_122/$entry
        ptr_deref_120_402: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120 
          signal ptr_deref_120_402_start: Boolean;
          signal Xentry_403_symbol: Boolean;
          signal Xexit_404_symbol: Boolean;
          signal ptr_deref_120_write_405_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_120_402_start <= Xentry_400_symbol; -- control passed to block
          Xentry_403_symbol  <= ptr_deref_120_402_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/$entry
          ptr_deref_120_write_405: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write 
            signal ptr_deref_120_write_405_start: Boolean;
            signal Xentry_406_symbol: Boolean;
            signal Xexit_407_symbol: Boolean;
            signal split_req_408_symbol : Boolean;
            signal split_ack_409_symbol : Boolean;
            signal word_access_410_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_120_write_405_start <= Xentry_403_symbol; -- control passed to block
            Xentry_406_symbol  <= ptr_deref_120_write_405_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/$entry
            split_req_408_symbol <= Xentry_406_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/split_req
            ptr_deref_120_gather_scatter_req_0 <= split_req_408_symbol; -- link to DP
            split_ack_409_symbol <= ptr_deref_120_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/split_ack
            word_access_410: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access 
              signal word_access_410_start: Boolean;
              signal Xentry_411_symbol: Boolean;
              signal Xexit_412_symbol: Boolean;
              signal word_access_0_413_symbol : Boolean;
              signal word_access_1_420_symbol : Boolean;
              signal word_access_2_427_symbol : Boolean;
              signal word_access_3_434_symbol : Boolean;
              -- 
            begin -- 
              word_access_410_start <= split_ack_409_symbol; -- control passed to block
              Xentry_411_symbol  <= word_access_410_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/$entry
              word_access_0_413: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0 
                signal word_access_0_413_start: Boolean;
                signal Xentry_414_symbol: Boolean;
                signal Xexit_415_symbol: Boolean;
                signal rr_416_symbol : Boolean;
                signal ra_417_symbol : Boolean;
                signal cr_418_symbol : Boolean;
                signal ca_419_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_413_start <= Xentry_411_symbol; -- control passed to block
                Xentry_414_symbol  <= word_access_0_413_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0/$entry
                rr_416_symbol <= Xentry_414_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0/rr
                ptr_deref_120_store_0_req_0 <= rr_416_symbol; -- link to DP
                ra_417_symbol <= ptr_deref_120_store_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0/ra
                cr_418_symbol <= ra_417_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0/cr
                ptr_deref_120_store_0_req_1 <= cr_418_symbol; -- link to DP
                ca_419_symbol <= ptr_deref_120_store_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0/ca
                Xexit_415_symbol <= ca_419_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0/$exit
                word_access_0_413_symbol <= Xexit_415_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_0
              word_access_1_420: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1 
                signal word_access_1_420_start: Boolean;
                signal Xentry_421_symbol: Boolean;
                signal Xexit_422_symbol: Boolean;
                signal rr_423_symbol : Boolean;
                signal ra_424_symbol : Boolean;
                signal cr_425_symbol : Boolean;
                signal ca_426_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_420_start <= Xentry_411_symbol; -- control passed to block
                Xentry_421_symbol  <= word_access_1_420_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1/$entry
                rr_423_symbol <= Xentry_421_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1/rr
                ptr_deref_120_store_1_req_0 <= rr_423_symbol; -- link to DP
                ra_424_symbol <= ptr_deref_120_store_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1/ra
                cr_425_symbol <= ra_424_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1/cr
                ptr_deref_120_store_1_req_1 <= cr_425_symbol; -- link to DP
                ca_426_symbol <= ptr_deref_120_store_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1/ca
                Xexit_422_symbol <= ca_426_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1/$exit
                word_access_1_420_symbol <= Xexit_422_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_1
              word_access_2_427: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2 
                signal word_access_2_427_start: Boolean;
                signal Xentry_428_symbol: Boolean;
                signal Xexit_429_symbol: Boolean;
                signal rr_430_symbol : Boolean;
                signal ra_431_symbol : Boolean;
                signal cr_432_symbol : Boolean;
                signal ca_433_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_427_start <= Xentry_411_symbol; -- control passed to block
                Xentry_428_symbol  <= word_access_2_427_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2/$entry
                rr_430_symbol <= Xentry_428_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2/rr
                ptr_deref_120_store_2_req_0 <= rr_430_symbol; -- link to DP
                ra_431_symbol <= ptr_deref_120_store_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2/ra
                cr_432_symbol <= ra_431_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2/cr
                ptr_deref_120_store_2_req_1 <= cr_432_symbol; -- link to DP
                ca_433_symbol <= ptr_deref_120_store_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2/ca
                Xexit_429_symbol <= ca_433_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2/$exit
                word_access_2_427_symbol <= Xexit_429_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_2
              word_access_3_434: Block -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3 
                signal word_access_3_434_start: Boolean;
                signal Xentry_435_symbol: Boolean;
                signal Xexit_436_symbol: Boolean;
                signal rr_437_symbol : Boolean;
                signal ra_438_symbol : Boolean;
                signal cr_439_symbol : Boolean;
                signal ca_440_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_434_start <= Xentry_411_symbol; -- control passed to block
                Xentry_435_symbol  <= word_access_3_434_start; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3/$entry
                rr_437_symbol <= Xentry_435_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3/rr
                ptr_deref_120_store_3_req_0 <= rr_437_symbol; -- link to DP
                ra_438_symbol <= ptr_deref_120_store_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3/ra
                cr_439_symbol <= ra_438_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3/cr
                ptr_deref_120_store_3_req_1 <= cr_439_symbol; -- link to DP
                ca_440_symbol <= ptr_deref_120_store_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3/ca
                Xexit_436_symbol <= ca_440_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3/$exit
                word_access_3_434_symbol <= Xexit_436_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/word_access_3
              Xexit_412_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/$exit 
                signal Xexit_412_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_412_predecessors(0) <= word_access_0_413_symbol;
                Xexit_412_predecessors(1) <= word_access_1_420_symbol;
                Xexit_412_predecessors(2) <= word_access_2_427_symbol;
                Xexit_412_predecessors(3) <= word_access_3_434_symbol;
                Xexit_412_join: join -- 
                  port map( -- 
                    preds => Xexit_412_predecessors,
                    symbol_out => Xexit_412_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access/$exit
              word_access_410_symbol <= Xexit_412_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/word_access
            Xexit_407_symbol <= word_access_410_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write/$exit
            ptr_deref_120_write_405_symbol <= Xexit_407_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120/ptr_deref_120_write
          Xexit_404_symbol <= ptr_deref_120_write_405_symbol; -- transition branch_block_stmt_108/assign_stmt_122/ptr_deref_120/$exit
          ptr_deref_120_402_symbol <= Xexit_404_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_122/ptr_deref_120
        Xexit_401_symbol <= ptr_deref_120_402_symbol; -- transition branch_block_stmt_108/assign_stmt_122/$exit
        assign_stmt_122_399_symbol <= Xexit_401_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_122
      assign_stmt_127_441: Block -- branch_block_stmt_108/assign_stmt_127 
        signal assign_stmt_127_441_start: Boolean;
        signal Xentry_442_symbol: Boolean;
        signal Xexit_443_symbol: Boolean;
        signal dummy_444_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_127_441_start <= assign_stmt_127_x_xentry_x_xx_x367_symbol; -- control passed to block
        Xentry_442_symbol  <= assign_stmt_127_441_start; -- transition branch_block_stmt_108/assign_stmt_127/$entry
        dummy_444_symbol <= Xentry_442_symbol; -- transition branch_block_stmt_108/assign_stmt_127/dummy
        Xexit_443_symbol <= dummy_444_symbol; -- transition branch_block_stmt_108/assign_stmt_127/$exit
        assign_stmt_127_441_symbol <= Xexit_443_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_127
      assign_stmt_131_445: Block -- branch_block_stmt_108/assign_stmt_131 
        signal assign_stmt_131_445_start: Boolean;
        signal Xentry_446_symbol: Boolean;
        signal Xexit_447_symbol: Boolean;
        signal type_cast_130_448_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_131_445_start <= assign_stmt_131_x_xentry_x_xx_x369_symbol; -- control passed to block
        Xentry_446_symbol  <= assign_stmt_131_445_start; -- transition branch_block_stmt_108/assign_stmt_131/$entry
        type_cast_130_448: Block -- branch_block_stmt_108/assign_stmt_131/type_cast_130 
          signal type_cast_130_448_start: Boolean;
          signal Xentry_449_symbol: Boolean;
          signal Xexit_450_symbol: Boolean;
          signal simple_obj_ref_129_451_symbol : Boolean;
          signal req_456_symbol : Boolean;
          signal ack_457_symbol : Boolean;
          -- 
        begin -- 
          type_cast_130_448_start <= Xentry_446_symbol; -- control passed to block
          Xentry_449_symbol  <= type_cast_130_448_start; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/$entry
          simple_obj_ref_129_451: Block -- branch_block_stmt_108/assign_stmt_131/type_cast_130/simple_obj_ref_129 
            signal simple_obj_ref_129_451_start: Boolean;
            signal Xentry_452_symbol: Boolean;
            signal Xexit_453_symbol: Boolean;
            signal req_454_symbol : Boolean;
            signal ack_455_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_129_451_start <= Xentry_449_symbol; -- control passed to block
            Xentry_452_symbol  <= simple_obj_ref_129_451_start; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/simple_obj_ref_129/$entry
            req_454_symbol <= Xentry_452_symbol; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/simple_obj_ref_129/req
            simple_obj_ref_129_inst_req_0 <= req_454_symbol; -- link to DP
            ack_455_symbol <= simple_obj_ref_129_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/simple_obj_ref_129/ack
            Xexit_453_symbol <= ack_455_symbol; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/simple_obj_ref_129/$exit
            simple_obj_ref_129_451_symbol <= Xexit_453_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_131/type_cast_130/simple_obj_ref_129
          req_456_symbol <= simple_obj_ref_129_451_symbol; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/req
          type_cast_130_inst_req_0 <= req_456_symbol; -- link to DP
          ack_457_symbol <= type_cast_130_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/ack
          Xexit_450_symbol <= ack_457_symbol; -- transition branch_block_stmt_108/assign_stmt_131/type_cast_130/$exit
          type_cast_130_448_symbol <= Xexit_450_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_131/type_cast_130
        Xexit_447_symbol <= type_cast_130_448_symbol; -- transition branch_block_stmt_108/assign_stmt_131/$exit
        assign_stmt_131_445_symbol <= Xexit_447_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_131
      assign_stmt_135_458: Block -- branch_block_stmt_108/assign_stmt_135 
        signal assign_stmt_135_458_start: Boolean;
        signal Xentry_459_symbol: Boolean;
        signal Xexit_460_symbol: Boolean;
        signal ptr_deref_133_461_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_135_458_start <= assign_stmt_135_x_xentry_x_xx_x371_symbol; -- control passed to block
        Xentry_459_symbol  <= assign_stmt_135_458_start; -- transition branch_block_stmt_108/assign_stmt_135/$entry
        ptr_deref_133_461: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133 
          signal ptr_deref_133_461_start: Boolean;
          signal Xentry_462_symbol: Boolean;
          signal Xexit_463_symbol: Boolean;
          signal ptr_deref_133_write_464_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_133_461_start <= Xentry_459_symbol; -- control passed to block
          Xentry_462_symbol  <= ptr_deref_133_461_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/$entry
          ptr_deref_133_write_464: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write 
            signal ptr_deref_133_write_464_start: Boolean;
            signal Xentry_465_symbol: Boolean;
            signal Xexit_466_symbol: Boolean;
            signal split_req_467_symbol : Boolean;
            signal split_ack_468_symbol : Boolean;
            signal word_access_469_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_133_write_464_start <= Xentry_462_symbol; -- control passed to block
            Xentry_465_symbol  <= ptr_deref_133_write_464_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/$entry
            split_req_467_symbol <= Xentry_465_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/split_req
            ptr_deref_133_gather_scatter_req_0 <= split_req_467_symbol; -- link to DP
            split_ack_468_symbol <= ptr_deref_133_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/split_ack
            word_access_469: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access 
              signal word_access_469_start: Boolean;
              signal Xentry_470_symbol: Boolean;
              signal Xexit_471_symbol: Boolean;
              signal word_access_0_472_symbol : Boolean;
              signal word_access_1_479_symbol : Boolean;
              signal word_access_2_486_symbol : Boolean;
              signal word_access_3_493_symbol : Boolean;
              -- 
            begin -- 
              word_access_469_start <= split_ack_468_symbol; -- control passed to block
              Xentry_470_symbol  <= word_access_469_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/$entry
              word_access_0_472: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0 
                signal word_access_0_472_start: Boolean;
                signal Xentry_473_symbol: Boolean;
                signal Xexit_474_symbol: Boolean;
                signal rr_475_symbol : Boolean;
                signal ra_476_symbol : Boolean;
                signal cr_477_symbol : Boolean;
                signal ca_478_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_472_start <= Xentry_470_symbol; -- control passed to block
                Xentry_473_symbol  <= word_access_0_472_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0/$entry
                rr_475_symbol <= Xentry_473_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0/rr
                ptr_deref_133_store_0_req_0 <= rr_475_symbol; -- link to DP
                ra_476_symbol <= ptr_deref_133_store_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0/ra
                cr_477_symbol <= ra_476_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0/cr
                ptr_deref_133_store_0_req_1 <= cr_477_symbol; -- link to DP
                ca_478_symbol <= ptr_deref_133_store_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0/ca
                Xexit_474_symbol <= ca_478_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0/$exit
                word_access_0_472_symbol <= Xexit_474_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_0
              word_access_1_479: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1 
                signal word_access_1_479_start: Boolean;
                signal Xentry_480_symbol: Boolean;
                signal Xexit_481_symbol: Boolean;
                signal rr_482_symbol : Boolean;
                signal ra_483_symbol : Boolean;
                signal cr_484_symbol : Boolean;
                signal ca_485_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_479_start <= Xentry_470_symbol; -- control passed to block
                Xentry_480_symbol  <= word_access_1_479_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1/$entry
                rr_482_symbol <= Xentry_480_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1/rr
                ptr_deref_133_store_1_req_0 <= rr_482_symbol; -- link to DP
                ra_483_symbol <= ptr_deref_133_store_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1/ra
                cr_484_symbol <= ra_483_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1/cr
                ptr_deref_133_store_1_req_1 <= cr_484_symbol; -- link to DP
                ca_485_symbol <= ptr_deref_133_store_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1/ca
                Xexit_481_symbol <= ca_485_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1/$exit
                word_access_1_479_symbol <= Xexit_481_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_1
              word_access_2_486: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2 
                signal word_access_2_486_start: Boolean;
                signal Xentry_487_symbol: Boolean;
                signal Xexit_488_symbol: Boolean;
                signal rr_489_symbol : Boolean;
                signal ra_490_symbol : Boolean;
                signal cr_491_symbol : Boolean;
                signal ca_492_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_486_start <= Xentry_470_symbol; -- control passed to block
                Xentry_487_symbol  <= word_access_2_486_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2/$entry
                rr_489_symbol <= Xentry_487_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2/rr
                ptr_deref_133_store_2_req_0 <= rr_489_symbol; -- link to DP
                ra_490_symbol <= ptr_deref_133_store_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2/ra
                cr_491_symbol <= ra_490_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2/cr
                ptr_deref_133_store_2_req_1 <= cr_491_symbol; -- link to DP
                ca_492_symbol <= ptr_deref_133_store_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2/ca
                Xexit_488_symbol <= ca_492_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2/$exit
                word_access_2_486_symbol <= Xexit_488_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_2
              word_access_3_493: Block -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3 
                signal word_access_3_493_start: Boolean;
                signal Xentry_494_symbol: Boolean;
                signal Xexit_495_symbol: Boolean;
                signal rr_496_symbol : Boolean;
                signal ra_497_symbol : Boolean;
                signal cr_498_symbol : Boolean;
                signal ca_499_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_493_start <= Xentry_470_symbol; -- control passed to block
                Xentry_494_symbol  <= word_access_3_493_start; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3/$entry
                rr_496_symbol <= Xentry_494_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3/rr
                ptr_deref_133_store_3_req_0 <= rr_496_symbol; -- link to DP
                ra_497_symbol <= ptr_deref_133_store_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3/ra
                cr_498_symbol <= ra_497_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3/cr
                ptr_deref_133_store_3_req_1 <= cr_498_symbol; -- link to DP
                ca_499_symbol <= ptr_deref_133_store_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3/ca
                Xexit_495_symbol <= ca_499_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3/$exit
                word_access_3_493_symbol <= Xexit_495_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/word_access_3
              Xexit_471_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/$exit 
                signal Xexit_471_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_471_predecessors(0) <= word_access_0_472_symbol;
                Xexit_471_predecessors(1) <= word_access_1_479_symbol;
                Xexit_471_predecessors(2) <= word_access_2_486_symbol;
                Xexit_471_predecessors(3) <= word_access_3_493_symbol;
                Xexit_471_join: join -- 
                  port map( -- 
                    preds => Xexit_471_predecessors,
                    symbol_out => Xexit_471_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access/$exit
              word_access_469_symbol <= Xexit_471_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/word_access
            Xexit_466_symbol <= word_access_469_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write/$exit
            ptr_deref_133_write_464_symbol <= Xexit_466_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133/ptr_deref_133_write
          Xexit_463_symbol <= ptr_deref_133_write_464_symbol; -- transition branch_block_stmt_108/assign_stmt_135/ptr_deref_133/$exit
          ptr_deref_133_461_symbol <= Xexit_463_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_135/ptr_deref_133
        Xexit_460_symbol <= ptr_deref_133_461_symbol; -- transition branch_block_stmt_108/assign_stmt_135/$exit
        assign_stmt_135_458_symbol <= Xexit_460_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_135
      assign_stmt_139_500: Block -- branch_block_stmt_108/assign_stmt_139 
        signal assign_stmt_139_500_start: Boolean;
        signal Xentry_501_symbol: Boolean;
        signal Xexit_502_symbol: Boolean;
        signal ptr_deref_138_503_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_139_500_start <= assign_stmt_139_x_xentry_x_xx_x373_symbol; -- control passed to block
        Xentry_501_symbol  <= assign_stmt_139_500_start; -- transition branch_block_stmt_108/assign_stmt_139/$entry
        ptr_deref_138_503: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138 
          signal ptr_deref_138_503_start: Boolean;
          signal Xentry_504_symbol: Boolean;
          signal Xexit_505_symbol: Boolean;
          signal ptr_deref_138_read_506_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_138_503_start <= Xentry_501_symbol; -- control passed to block
          Xentry_504_symbol  <= ptr_deref_138_503_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/$entry
          ptr_deref_138_read_506: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read 
            signal ptr_deref_138_read_506_start: Boolean;
            signal Xentry_507_symbol: Boolean;
            signal Xexit_508_symbol: Boolean;
            signal word_access_509_symbol : Boolean;
            signal merge_req_540_symbol : Boolean;
            signal merge_ack_541_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_138_read_506_start <= Xentry_504_symbol; -- control passed to block
            Xentry_507_symbol  <= ptr_deref_138_read_506_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/$entry
            word_access_509: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access 
              signal word_access_509_start: Boolean;
              signal Xentry_510_symbol: Boolean;
              signal Xexit_511_symbol: Boolean;
              signal word_access_0_512_symbol : Boolean;
              signal word_access_1_519_symbol : Boolean;
              signal word_access_2_526_symbol : Boolean;
              signal word_access_3_533_symbol : Boolean;
              -- 
            begin -- 
              word_access_509_start <= Xentry_507_symbol; -- control passed to block
              Xentry_510_symbol  <= word_access_509_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/$entry
              word_access_0_512: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0 
                signal word_access_0_512_start: Boolean;
                signal Xentry_513_symbol: Boolean;
                signal Xexit_514_symbol: Boolean;
                signal rr_515_symbol : Boolean;
                signal ra_516_symbol : Boolean;
                signal cr_517_symbol : Boolean;
                signal ca_518_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_512_start <= Xentry_510_symbol; -- control passed to block
                Xentry_513_symbol  <= word_access_0_512_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0/$entry
                rr_515_symbol <= Xentry_513_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0/rr
                ptr_deref_138_load_0_req_0 <= rr_515_symbol; -- link to DP
                ra_516_symbol <= ptr_deref_138_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0/ra
                cr_517_symbol <= ra_516_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0/cr
                ptr_deref_138_load_0_req_1 <= cr_517_symbol; -- link to DP
                ca_518_symbol <= ptr_deref_138_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0/ca
                Xexit_514_symbol <= ca_518_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0/$exit
                word_access_0_512_symbol <= Xexit_514_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_0
              word_access_1_519: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1 
                signal word_access_1_519_start: Boolean;
                signal Xentry_520_symbol: Boolean;
                signal Xexit_521_symbol: Boolean;
                signal rr_522_symbol : Boolean;
                signal ra_523_symbol : Boolean;
                signal cr_524_symbol : Boolean;
                signal ca_525_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_519_start <= Xentry_510_symbol; -- control passed to block
                Xentry_520_symbol  <= word_access_1_519_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1/$entry
                rr_522_symbol <= Xentry_520_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1/rr
                ptr_deref_138_load_1_req_0 <= rr_522_symbol; -- link to DP
                ra_523_symbol <= ptr_deref_138_load_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1/ra
                cr_524_symbol <= ra_523_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1/cr
                ptr_deref_138_load_1_req_1 <= cr_524_symbol; -- link to DP
                ca_525_symbol <= ptr_deref_138_load_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1/ca
                Xexit_521_symbol <= ca_525_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1/$exit
                word_access_1_519_symbol <= Xexit_521_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_1
              word_access_2_526: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2 
                signal word_access_2_526_start: Boolean;
                signal Xentry_527_symbol: Boolean;
                signal Xexit_528_symbol: Boolean;
                signal rr_529_symbol : Boolean;
                signal ra_530_symbol : Boolean;
                signal cr_531_symbol : Boolean;
                signal ca_532_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_526_start <= Xentry_510_symbol; -- control passed to block
                Xentry_527_symbol  <= word_access_2_526_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2/$entry
                rr_529_symbol <= Xentry_527_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2/rr
                ptr_deref_138_load_2_req_0 <= rr_529_symbol; -- link to DP
                ra_530_symbol <= ptr_deref_138_load_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2/ra
                cr_531_symbol <= ra_530_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2/cr
                ptr_deref_138_load_2_req_1 <= cr_531_symbol; -- link to DP
                ca_532_symbol <= ptr_deref_138_load_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2/ca
                Xexit_528_symbol <= ca_532_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2/$exit
                word_access_2_526_symbol <= Xexit_528_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_2
              word_access_3_533: Block -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3 
                signal word_access_3_533_start: Boolean;
                signal Xentry_534_symbol: Boolean;
                signal Xexit_535_symbol: Boolean;
                signal rr_536_symbol : Boolean;
                signal ra_537_symbol : Boolean;
                signal cr_538_symbol : Boolean;
                signal ca_539_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_533_start <= Xentry_510_symbol; -- control passed to block
                Xentry_534_symbol  <= word_access_3_533_start; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3/$entry
                rr_536_symbol <= Xentry_534_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3/rr
                ptr_deref_138_load_3_req_0 <= rr_536_symbol; -- link to DP
                ra_537_symbol <= ptr_deref_138_load_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3/ra
                cr_538_symbol <= ra_537_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3/cr
                ptr_deref_138_load_3_req_1 <= cr_538_symbol; -- link to DP
                ca_539_symbol <= ptr_deref_138_load_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3/ca
                Xexit_535_symbol <= ca_539_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3/$exit
                word_access_3_533_symbol <= Xexit_535_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/word_access_3
              Xexit_511_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/$exit 
                signal Xexit_511_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_511_predecessors(0) <= word_access_0_512_symbol;
                Xexit_511_predecessors(1) <= word_access_1_519_symbol;
                Xexit_511_predecessors(2) <= word_access_2_526_symbol;
                Xexit_511_predecessors(3) <= word_access_3_533_symbol;
                Xexit_511_join: join -- 
                  port map( -- 
                    preds => Xexit_511_predecessors,
                    symbol_out => Xexit_511_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access/$exit
              word_access_509_symbol <= Xexit_511_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/word_access
            merge_req_540_symbol <= word_access_509_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/merge_req
            ptr_deref_138_gather_scatter_req_0 <= merge_req_540_symbol; -- link to DP
            merge_ack_541_symbol <= ptr_deref_138_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/merge_ack
            Xexit_508_symbol <= merge_ack_541_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read/$exit
            ptr_deref_138_read_506_symbol <= Xexit_508_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138/ptr_deref_138_read
          Xexit_505_symbol <= ptr_deref_138_read_506_symbol; -- transition branch_block_stmt_108/assign_stmt_139/ptr_deref_138/$exit
          ptr_deref_138_503_symbol <= Xexit_505_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_139/ptr_deref_138
        Xexit_502_symbol <= ptr_deref_138_503_symbol; -- transition branch_block_stmt_108/assign_stmt_139/$exit
        assign_stmt_139_500_symbol <= Xexit_502_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_139
      assign_stmt_143_542: Block -- branch_block_stmt_108/assign_stmt_143 
        signal assign_stmt_143_542_start: Boolean;
        signal Xentry_543_symbol: Boolean;
        signal Xexit_544_symbol: Boolean;
        signal ptr_deref_142_545_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_143_542_start <= assign_stmt_143_x_xentry_x_xx_x375_symbol; -- control passed to block
        Xentry_543_symbol  <= assign_stmt_143_542_start; -- transition branch_block_stmt_108/assign_stmt_143/$entry
        ptr_deref_142_545: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142 
          signal ptr_deref_142_545_start: Boolean;
          signal Xentry_546_symbol: Boolean;
          signal Xexit_547_symbol: Boolean;
          signal ptr_deref_142_read_548_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_142_545_start <= Xentry_543_symbol; -- control passed to block
          Xentry_546_symbol  <= ptr_deref_142_545_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/$entry
          ptr_deref_142_read_548: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read 
            signal ptr_deref_142_read_548_start: Boolean;
            signal Xentry_549_symbol: Boolean;
            signal Xexit_550_symbol: Boolean;
            signal word_access_551_symbol : Boolean;
            signal merge_req_582_symbol : Boolean;
            signal merge_ack_583_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_142_read_548_start <= Xentry_546_symbol; -- control passed to block
            Xentry_549_symbol  <= ptr_deref_142_read_548_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/$entry
            word_access_551: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access 
              signal word_access_551_start: Boolean;
              signal Xentry_552_symbol: Boolean;
              signal Xexit_553_symbol: Boolean;
              signal word_access_0_554_symbol : Boolean;
              signal word_access_1_561_symbol : Boolean;
              signal word_access_2_568_symbol : Boolean;
              signal word_access_3_575_symbol : Boolean;
              -- 
            begin -- 
              word_access_551_start <= Xentry_549_symbol; -- control passed to block
              Xentry_552_symbol  <= word_access_551_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/$entry
              word_access_0_554: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0 
                signal word_access_0_554_start: Boolean;
                signal Xentry_555_symbol: Boolean;
                signal Xexit_556_symbol: Boolean;
                signal rr_557_symbol : Boolean;
                signal ra_558_symbol : Boolean;
                signal cr_559_symbol : Boolean;
                signal ca_560_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_554_start <= Xentry_552_symbol; -- control passed to block
                Xentry_555_symbol  <= word_access_0_554_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0/$entry
                rr_557_symbol <= Xentry_555_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0/rr
                ptr_deref_142_load_0_req_0 <= rr_557_symbol; -- link to DP
                ra_558_symbol <= ptr_deref_142_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0/ra
                cr_559_symbol <= ra_558_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0/cr
                ptr_deref_142_load_0_req_1 <= cr_559_symbol; -- link to DP
                ca_560_symbol <= ptr_deref_142_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0/ca
                Xexit_556_symbol <= ca_560_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0/$exit
                word_access_0_554_symbol <= Xexit_556_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_0
              word_access_1_561: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1 
                signal word_access_1_561_start: Boolean;
                signal Xentry_562_symbol: Boolean;
                signal Xexit_563_symbol: Boolean;
                signal rr_564_symbol : Boolean;
                signal ra_565_symbol : Boolean;
                signal cr_566_symbol : Boolean;
                signal ca_567_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_561_start <= Xentry_552_symbol; -- control passed to block
                Xentry_562_symbol  <= word_access_1_561_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1/$entry
                rr_564_symbol <= Xentry_562_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1/rr
                ptr_deref_142_load_1_req_0 <= rr_564_symbol; -- link to DP
                ra_565_symbol <= ptr_deref_142_load_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1/ra
                cr_566_symbol <= ra_565_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1/cr
                ptr_deref_142_load_1_req_1 <= cr_566_symbol; -- link to DP
                ca_567_symbol <= ptr_deref_142_load_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1/ca
                Xexit_563_symbol <= ca_567_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1/$exit
                word_access_1_561_symbol <= Xexit_563_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_1
              word_access_2_568: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2 
                signal word_access_2_568_start: Boolean;
                signal Xentry_569_symbol: Boolean;
                signal Xexit_570_symbol: Boolean;
                signal rr_571_symbol : Boolean;
                signal ra_572_symbol : Boolean;
                signal cr_573_symbol : Boolean;
                signal ca_574_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_568_start <= Xentry_552_symbol; -- control passed to block
                Xentry_569_symbol  <= word_access_2_568_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2/$entry
                rr_571_symbol <= Xentry_569_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2/rr
                ptr_deref_142_load_2_req_0 <= rr_571_symbol; -- link to DP
                ra_572_symbol <= ptr_deref_142_load_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2/ra
                cr_573_symbol <= ra_572_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2/cr
                ptr_deref_142_load_2_req_1 <= cr_573_symbol; -- link to DP
                ca_574_symbol <= ptr_deref_142_load_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2/ca
                Xexit_570_symbol <= ca_574_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2/$exit
                word_access_2_568_symbol <= Xexit_570_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_2
              word_access_3_575: Block -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3 
                signal word_access_3_575_start: Boolean;
                signal Xentry_576_symbol: Boolean;
                signal Xexit_577_symbol: Boolean;
                signal rr_578_symbol : Boolean;
                signal ra_579_symbol : Boolean;
                signal cr_580_symbol : Boolean;
                signal ca_581_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_575_start <= Xentry_552_symbol; -- control passed to block
                Xentry_576_symbol  <= word_access_3_575_start; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3/$entry
                rr_578_symbol <= Xentry_576_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3/rr
                ptr_deref_142_load_3_req_0 <= rr_578_symbol; -- link to DP
                ra_579_symbol <= ptr_deref_142_load_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3/ra
                cr_580_symbol <= ra_579_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3/cr
                ptr_deref_142_load_3_req_1 <= cr_580_symbol; -- link to DP
                ca_581_symbol <= ptr_deref_142_load_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3/ca
                Xexit_577_symbol <= ca_581_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3/$exit
                word_access_3_575_symbol <= Xexit_577_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/word_access_3
              Xexit_553_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/$exit 
                signal Xexit_553_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_553_predecessors(0) <= word_access_0_554_symbol;
                Xexit_553_predecessors(1) <= word_access_1_561_symbol;
                Xexit_553_predecessors(2) <= word_access_2_568_symbol;
                Xexit_553_predecessors(3) <= word_access_3_575_symbol;
                Xexit_553_join: join -- 
                  port map( -- 
                    preds => Xexit_553_predecessors,
                    symbol_out => Xexit_553_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access/$exit
              word_access_551_symbol <= Xexit_553_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/word_access
            merge_req_582_symbol <= word_access_551_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/merge_req
            ptr_deref_142_gather_scatter_req_0 <= merge_req_582_symbol; -- link to DP
            merge_ack_583_symbol <= ptr_deref_142_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/merge_ack
            Xexit_550_symbol <= merge_ack_583_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read/$exit
            ptr_deref_142_read_548_symbol <= Xexit_550_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142/ptr_deref_142_read
          Xexit_547_symbol <= ptr_deref_142_read_548_symbol; -- transition branch_block_stmt_108/assign_stmt_143/ptr_deref_142/$exit
          ptr_deref_142_545_symbol <= Xexit_547_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_143/ptr_deref_142
        Xexit_544_symbol <= ptr_deref_142_545_symbol; -- transition branch_block_stmt_108/assign_stmt_143/$exit
        assign_stmt_143_542_symbol <= Xexit_544_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_143
      assign_stmt_148_584: Block -- branch_block_stmt_108/assign_stmt_148 
        signal assign_stmt_148_584_start: Boolean;
        signal Xentry_585_symbol: Boolean;
        signal Xexit_586_symbol: Boolean;
        signal binary_147_587_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_148_584_start <= assign_stmt_148_x_xentry_x_xx_x377_symbol; -- control passed to block
        Xentry_585_symbol  <= assign_stmt_148_584_start; -- transition branch_block_stmt_108/assign_stmt_148/$entry
        binary_147_587: Block -- branch_block_stmt_108/assign_stmt_148/binary_147 
          signal binary_147_587_start: Boolean;
          signal Xentry_588_symbol: Boolean;
          signal Xexit_589_symbol: Boolean;
          signal binary_147_inputs_590_symbol : Boolean;
          signal rr_593_symbol : Boolean;
          signal ra_594_symbol : Boolean;
          signal cr_595_symbol : Boolean;
          signal ca_596_symbol : Boolean;
          -- 
        begin -- 
          binary_147_587_start <= Xentry_585_symbol; -- control passed to block
          Xentry_588_symbol  <= binary_147_587_start; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/$entry
          binary_147_inputs_590: Block -- branch_block_stmt_108/assign_stmt_148/binary_147/binary_147_inputs 
            signal binary_147_inputs_590_start: Boolean;
            signal Xentry_591_symbol: Boolean;
            signal Xexit_592_symbol: Boolean;
            -- 
          begin -- 
            binary_147_inputs_590_start <= Xentry_588_symbol; -- control passed to block
            Xentry_591_symbol  <= binary_147_inputs_590_start; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/binary_147_inputs/$entry
            Xexit_592_symbol <= Xentry_591_symbol; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/binary_147_inputs/$exit
            binary_147_inputs_590_symbol <= Xexit_592_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_148/binary_147/binary_147_inputs
          rr_593_symbol <= binary_147_inputs_590_symbol; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/rr
          binary_147_inst_req_0 <= rr_593_symbol; -- link to DP
          ra_594_symbol <= binary_147_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/ra
          cr_595_symbol <= ra_594_symbol; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/cr
          binary_147_inst_req_1 <= cr_595_symbol; -- link to DP
          ca_596_symbol <= binary_147_inst_ack_1; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/ca
          Xexit_589_symbol <= ca_596_symbol; -- transition branch_block_stmt_108/assign_stmt_148/binary_147/$exit
          binary_147_587_symbol <= Xexit_589_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_148/binary_147
        Xexit_586_symbol <= binary_147_587_symbol; -- transition branch_block_stmt_108/assign_stmt_148/$exit
        assign_stmt_148_584_symbol <= Xexit_586_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_148
      assign_stmt_153_597: Block -- branch_block_stmt_108/assign_stmt_153 
        signal assign_stmt_153_597_start: Boolean;
        signal Xentry_598_symbol: Boolean;
        signal Xexit_599_symbol: Boolean;
        signal dummy_600_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_153_597_start <= assign_stmt_153_x_xentry_x_xx_x379_symbol; -- control passed to block
        Xentry_598_symbol  <= assign_stmt_153_597_start; -- transition branch_block_stmt_108/assign_stmt_153/$entry
        dummy_600_symbol <= Xentry_598_symbol; -- transition branch_block_stmt_108/assign_stmt_153/dummy
        Xexit_599_symbol <= dummy_600_symbol; -- transition branch_block_stmt_108/assign_stmt_153/$exit
        assign_stmt_153_597_symbol <= Xexit_599_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_153
      assign_stmt_157_601: Block -- branch_block_stmt_108/assign_stmt_157 
        signal assign_stmt_157_601_start: Boolean;
        signal Xentry_602_symbol: Boolean;
        signal Xexit_603_symbol: Boolean;
        signal type_cast_156_604_symbol : Boolean;
        signal simple_obj_ref_154_609_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_157_601_start <= assign_stmt_157_x_xentry_x_xx_x381_symbol; -- control passed to block
        Xentry_602_symbol  <= assign_stmt_157_601_start; -- transition branch_block_stmt_108/assign_stmt_157/$entry
        type_cast_156_604: Block -- branch_block_stmt_108/assign_stmt_157/type_cast_156 
          signal type_cast_156_604_start: Boolean;
          signal Xentry_605_symbol: Boolean;
          signal Xexit_606_symbol: Boolean;
          signal req_607_symbol : Boolean;
          signal ack_608_symbol : Boolean;
          -- 
        begin -- 
          type_cast_156_604_start <= Xentry_602_symbol; -- control passed to block
          Xentry_605_symbol  <= type_cast_156_604_start; -- transition branch_block_stmt_108/assign_stmt_157/type_cast_156/$entry
          req_607_symbol <= Xentry_605_symbol; -- transition branch_block_stmt_108/assign_stmt_157/type_cast_156/req
          type_cast_156_inst_req_0 <= req_607_symbol; -- link to DP
          ack_608_symbol <= type_cast_156_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_157/type_cast_156/ack
          Xexit_606_symbol <= ack_608_symbol; -- transition branch_block_stmt_108/assign_stmt_157/type_cast_156/$exit
          type_cast_156_604_symbol <= Xexit_606_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_157/type_cast_156
        simple_obj_ref_154_609: Block -- branch_block_stmt_108/assign_stmt_157/simple_obj_ref_154 
          signal simple_obj_ref_154_609_start: Boolean;
          signal Xentry_610_symbol: Boolean;
          signal Xexit_611_symbol: Boolean;
          signal pipe_wreq_612_symbol : Boolean;
          signal pipe_wack_613_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_154_609_start <= type_cast_156_604_symbol; -- control passed to block
          Xentry_610_symbol  <= simple_obj_ref_154_609_start; -- transition branch_block_stmt_108/assign_stmt_157/simple_obj_ref_154/$entry
          pipe_wreq_612_symbol <= Xentry_610_symbol; -- transition branch_block_stmt_108/assign_stmt_157/simple_obj_ref_154/pipe_wreq
          simple_obj_ref_154_inst_req_0 <= pipe_wreq_612_symbol; -- link to DP
          pipe_wack_613_symbol <= simple_obj_ref_154_inst_ack_0; -- transition branch_block_stmt_108/assign_stmt_157/simple_obj_ref_154/pipe_wack
          Xexit_611_symbol <= pipe_wack_613_symbol; -- transition branch_block_stmt_108/assign_stmt_157/simple_obj_ref_154/$exit
          simple_obj_ref_154_609_symbol <= Xexit_611_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_157/simple_obj_ref_154
        Xexit_603_symbol <= simple_obj_ref_154_609_symbol; -- transition branch_block_stmt_108/assign_stmt_157/$exit
        assign_stmt_157_601_symbol <= Xexit_603_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_157
      assign_stmt_161_614: Block -- branch_block_stmt_108/assign_stmt_161 
        signal assign_stmt_161_614_start: Boolean;
        signal Xentry_615_symbol: Boolean;
        signal Xexit_616_symbol: Boolean;
        signal ptr_deref_160_617_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_161_614_start <= assign_stmt_161_x_xentry_x_xx_x383_symbol; -- control passed to block
        Xentry_615_symbol  <= assign_stmt_161_614_start; -- transition branch_block_stmt_108/assign_stmt_161/$entry
        ptr_deref_160_617: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160 
          signal ptr_deref_160_617_start: Boolean;
          signal Xentry_618_symbol: Boolean;
          signal Xexit_619_symbol: Boolean;
          signal ptr_deref_160_read_620_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_160_617_start <= Xentry_615_symbol; -- control passed to block
          Xentry_618_symbol  <= ptr_deref_160_617_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/$entry
          ptr_deref_160_read_620: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read 
            signal ptr_deref_160_read_620_start: Boolean;
            signal Xentry_621_symbol: Boolean;
            signal Xexit_622_symbol: Boolean;
            signal word_access_623_symbol : Boolean;
            signal merge_req_654_symbol : Boolean;
            signal merge_ack_655_symbol : Boolean;
            -- 
          begin -- 
            ptr_deref_160_read_620_start <= Xentry_618_symbol; -- control passed to block
            Xentry_621_symbol  <= ptr_deref_160_read_620_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/$entry
            word_access_623: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access 
              signal word_access_623_start: Boolean;
              signal Xentry_624_symbol: Boolean;
              signal Xexit_625_symbol: Boolean;
              signal word_access_0_626_symbol : Boolean;
              signal word_access_1_633_symbol : Boolean;
              signal word_access_2_640_symbol : Boolean;
              signal word_access_3_647_symbol : Boolean;
              -- 
            begin -- 
              word_access_623_start <= Xentry_621_symbol; -- control passed to block
              Xentry_624_symbol  <= word_access_623_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/$entry
              word_access_0_626: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0 
                signal word_access_0_626_start: Boolean;
                signal Xentry_627_symbol: Boolean;
                signal Xexit_628_symbol: Boolean;
                signal rr_629_symbol : Boolean;
                signal ra_630_symbol : Boolean;
                signal cr_631_symbol : Boolean;
                signal ca_632_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_626_start <= Xentry_624_symbol; -- control passed to block
                Xentry_627_symbol  <= word_access_0_626_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0/$entry
                rr_629_symbol <= Xentry_627_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0/rr
                ptr_deref_160_load_0_req_0 <= rr_629_symbol; -- link to DP
                ra_630_symbol <= ptr_deref_160_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0/ra
                cr_631_symbol <= ra_630_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0/cr
                ptr_deref_160_load_0_req_1 <= cr_631_symbol; -- link to DP
                ca_632_symbol <= ptr_deref_160_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0/ca
                Xexit_628_symbol <= ca_632_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0/$exit
                word_access_0_626_symbol <= Xexit_628_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_0
              word_access_1_633: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1 
                signal word_access_1_633_start: Boolean;
                signal Xentry_634_symbol: Boolean;
                signal Xexit_635_symbol: Boolean;
                signal rr_636_symbol : Boolean;
                signal ra_637_symbol : Boolean;
                signal cr_638_symbol : Boolean;
                signal ca_639_symbol : Boolean;
                -- 
              begin -- 
                word_access_1_633_start <= Xentry_624_symbol; -- control passed to block
                Xentry_634_symbol  <= word_access_1_633_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1/$entry
                rr_636_symbol <= Xentry_634_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1/rr
                ptr_deref_160_load_1_req_0 <= rr_636_symbol; -- link to DP
                ra_637_symbol <= ptr_deref_160_load_1_ack_0; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1/ra
                cr_638_symbol <= ra_637_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1/cr
                ptr_deref_160_load_1_req_1 <= cr_638_symbol; -- link to DP
                ca_639_symbol <= ptr_deref_160_load_1_ack_1; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1/ca
                Xexit_635_symbol <= ca_639_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1/$exit
                word_access_1_633_symbol <= Xexit_635_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_1
              word_access_2_640: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2 
                signal word_access_2_640_start: Boolean;
                signal Xentry_641_symbol: Boolean;
                signal Xexit_642_symbol: Boolean;
                signal rr_643_symbol : Boolean;
                signal ra_644_symbol : Boolean;
                signal cr_645_symbol : Boolean;
                signal ca_646_symbol : Boolean;
                -- 
              begin -- 
                word_access_2_640_start <= Xentry_624_symbol; -- control passed to block
                Xentry_641_symbol  <= word_access_2_640_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2/$entry
                rr_643_symbol <= Xentry_641_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2/rr
                ptr_deref_160_load_2_req_0 <= rr_643_symbol; -- link to DP
                ra_644_symbol <= ptr_deref_160_load_2_ack_0; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2/ra
                cr_645_symbol <= ra_644_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2/cr
                ptr_deref_160_load_2_req_1 <= cr_645_symbol; -- link to DP
                ca_646_symbol <= ptr_deref_160_load_2_ack_1; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2/ca
                Xexit_642_symbol <= ca_646_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2/$exit
                word_access_2_640_symbol <= Xexit_642_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_2
              word_access_3_647: Block -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3 
                signal word_access_3_647_start: Boolean;
                signal Xentry_648_symbol: Boolean;
                signal Xexit_649_symbol: Boolean;
                signal rr_650_symbol : Boolean;
                signal ra_651_symbol : Boolean;
                signal cr_652_symbol : Boolean;
                signal ca_653_symbol : Boolean;
                -- 
              begin -- 
                word_access_3_647_start <= Xentry_624_symbol; -- control passed to block
                Xentry_648_symbol  <= word_access_3_647_start; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3/$entry
                rr_650_symbol <= Xentry_648_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3/rr
                ptr_deref_160_load_3_req_0 <= rr_650_symbol; -- link to DP
                ra_651_symbol <= ptr_deref_160_load_3_ack_0; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3/ra
                cr_652_symbol <= ra_651_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3/cr
                ptr_deref_160_load_3_req_1 <= cr_652_symbol; -- link to DP
                ca_653_symbol <= ptr_deref_160_load_3_ack_1; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3/ca
                Xexit_649_symbol <= ca_653_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3/$exit
                word_access_3_647_symbol <= Xexit_649_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/word_access_3
              Xexit_625_block : Block -- non-trivial join transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/$exit 
                signal Xexit_625_predecessors: BooleanArray(3 downto 0);
                -- 
              begin -- 
                Xexit_625_predecessors(0) <= word_access_0_626_symbol;
                Xexit_625_predecessors(1) <= word_access_1_633_symbol;
                Xexit_625_predecessors(2) <= word_access_2_640_symbol;
                Xexit_625_predecessors(3) <= word_access_3_647_symbol;
                Xexit_625_join: join -- 
                  port map( -- 
                    preds => Xexit_625_predecessors,
                    symbol_out => Xexit_625_symbol,
                    clk => clk,
                    reset => reset); -- 
                -- 
              end Block; -- non-trivial join transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access/$exit
              word_access_623_symbol <= Xexit_625_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/word_access
            merge_req_654_symbol <= word_access_623_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/merge_req
            ptr_deref_160_gather_scatter_req_0 <= merge_req_654_symbol; -- link to DP
            merge_ack_655_symbol <= ptr_deref_160_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/merge_ack
            Xexit_622_symbol <= merge_ack_655_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read/$exit
            ptr_deref_160_read_620_symbol <= Xexit_622_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160/ptr_deref_160_read
          Xexit_619_symbol <= ptr_deref_160_read_620_symbol; -- transition branch_block_stmt_108/assign_stmt_161/ptr_deref_160/$exit
          ptr_deref_160_617_symbol <= Xexit_619_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_161/ptr_deref_160
        Xexit_616_symbol <= ptr_deref_160_617_symbol; -- transition branch_block_stmt_108/assign_stmt_161/$exit
        assign_stmt_161_614_symbol <= Xexit_616_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_161
      assign_stmt_164_656: Block -- branch_block_stmt_108/assign_stmt_164 
        signal assign_stmt_164_656_start: Boolean;
        signal Xentry_657_symbol: Boolean;
        signal Xexit_658_symbol: Boolean;
        signal simple_obj_ref_162_659_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_164_656_start <= assign_stmt_164_x_xentry_x_xx_x385_symbol; -- control passed to block
        Xentry_657_symbol  <= assign_stmt_164_656_start; -- transition branch_block_stmt_108/assign_stmt_164/$entry
        simple_obj_ref_162_659: Block -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162 
          signal simple_obj_ref_162_659_start: Boolean;
          signal Xentry_660_symbol: Boolean;
          signal Xexit_661_symbol: Boolean;
          signal simple_obj_ref_162_write_662_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_162_659_start <= Xentry_657_symbol; -- control passed to block
          Xentry_660_symbol  <= simple_obj_ref_162_659_start; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/$entry
          simple_obj_ref_162_write_662: Block -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write 
            signal simple_obj_ref_162_write_662_start: Boolean;
            signal Xentry_663_symbol: Boolean;
            signal Xexit_664_symbol: Boolean;
            signal split_req_665_symbol : Boolean;
            signal split_ack_666_symbol : Boolean;
            signal word_access_667_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_162_write_662_start <= Xentry_660_symbol; -- control passed to block
            Xentry_663_symbol  <= simple_obj_ref_162_write_662_start; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/$entry
            split_req_665_symbol <= Xentry_663_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/split_req
            simple_obj_ref_162_gather_scatter_req_0 <= split_req_665_symbol; -- link to DP
            split_ack_666_symbol <= simple_obj_ref_162_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/split_ack
            word_access_667: Block -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access 
              signal word_access_667_start: Boolean;
              signal Xentry_668_symbol: Boolean;
              signal Xexit_669_symbol: Boolean;
              signal word_access_0_670_symbol : Boolean;
              -- 
            begin -- 
              word_access_667_start <= split_ack_666_symbol; -- control passed to block
              Xentry_668_symbol  <= word_access_667_start; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/$entry
              word_access_0_670: Block -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0 
                signal word_access_0_670_start: Boolean;
                signal Xentry_671_symbol: Boolean;
                signal Xexit_672_symbol: Boolean;
                signal rr_673_symbol : Boolean;
                signal ra_674_symbol : Boolean;
                signal cr_675_symbol : Boolean;
                signal ca_676_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_670_start <= Xentry_668_symbol; -- control passed to block
                Xentry_671_symbol  <= word_access_0_670_start; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0/$entry
                rr_673_symbol <= Xentry_671_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0/rr
                simple_obj_ref_162_store_0_req_0 <= rr_673_symbol; -- link to DP
                ra_674_symbol <= simple_obj_ref_162_store_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0/ra
                cr_675_symbol <= ra_674_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0/cr
                simple_obj_ref_162_store_0_req_1 <= cr_675_symbol; -- link to DP
                ca_676_symbol <= simple_obj_ref_162_store_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0/ca
                Xexit_672_symbol <= ca_676_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0/$exit
                word_access_0_670_symbol <= Xexit_672_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/word_access_0
              Xexit_669_symbol <= word_access_0_670_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access/$exit
              word_access_667_symbol <= Xexit_669_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/word_access
            Xexit_664_symbol <= word_access_667_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write/$exit
            simple_obj_ref_162_write_662_symbol <= Xexit_664_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/simple_obj_ref_162_write
          Xexit_661_symbol <= simple_obj_ref_162_write_662_symbol; -- transition branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162/$exit
          simple_obj_ref_162_659_symbol <= Xexit_661_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_164/simple_obj_ref_162
        Xexit_658_symbol <= simple_obj_ref_162_659_symbol; -- transition branch_block_stmt_108/assign_stmt_164/$exit
        assign_stmt_164_656_symbol <= Xexit_658_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_164
      assign_stmt_169_677: Block -- branch_block_stmt_108/assign_stmt_169 
        signal assign_stmt_169_677_start: Boolean;
        signal Xentry_678_symbol: Boolean;
        signal Xexit_679_symbol: Boolean;
        signal simple_obj_ref_168_680_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_169_677_start <= assign_stmt_169_x_xentry_x_xx_x389_symbol; -- control passed to block
        Xentry_678_symbol  <= assign_stmt_169_677_start; -- transition branch_block_stmt_108/assign_stmt_169/$entry
        simple_obj_ref_168_680: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168 
          signal simple_obj_ref_168_680_start: Boolean;
          signal Xentry_681_symbol: Boolean;
          signal Xexit_682_symbol: Boolean;
          signal simple_obj_ref_168_read_683_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_168_680_start <= Xentry_678_symbol; -- control passed to block
          Xentry_681_symbol  <= simple_obj_ref_168_680_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/$entry
          simple_obj_ref_168_read_683: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read 
            signal simple_obj_ref_168_read_683_start: Boolean;
            signal Xentry_684_symbol: Boolean;
            signal Xexit_685_symbol: Boolean;
            signal word_access_686_symbol : Boolean;
            signal merge_req_696_symbol : Boolean;
            signal merge_ack_697_symbol : Boolean;
            -- 
          begin -- 
            simple_obj_ref_168_read_683_start <= Xentry_681_symbol; -- control passed to block
            Xentry_684_symbol  <= simple_obj_ref_168_read_683_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/$entry
            word_access_686: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access 
              signal word_access_686_start: Boolean;
              signal Xentry_687_symbol: Boolean;
              signal Xexit_688_symbol: Boolean;
              signal word_access_0_689_symbol : Boolean;
              -- 
            begin -- 
              word_access_686_start <= Xentry_684_symbol; -- control passed to block
              Xentry_687_symbol  <= word_access_686_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/$entry
              word_access_0_689: Block -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0 
                signal word_access_0_689_start: Boolean;
                signal Xentry_690_symbol: Boolean;
                signal Xexit_691_symbol: Boolean;
                signal rr_692_symbol : Boolean;
                signal ra_693_symbol : Boolean;
                signal cr_694_symbol : Boolean;
                signal ca_695_symbol : Boolean;
                -- 
              begin -- 
                word_access_0_689_start <= Xentry_687_symbol; -- control passed to block
                Xentry_690_symbol  <= word_access_0_689_start; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0/$entry
                rr_692_symbol <= Xentry_690_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0/rr
                simple_obj_ref_168_load_0_req_0 <= rr_692_symbol; -- link to DP
                ra_693_symbol <= simple_obj_ref_168_load_0_ack_0; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0/ra
                cr_694_symbol <= ra_693_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0/cr
                simple_obj_ref_168_load_0_req_1 <= cr_694_symbol; -- link to DP
                ca_695_symbol <= simple_obj_ref_168_load_0_ack_1; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0/ca
                Xexit_691_symbol <= ca_695_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0/$exit
                word_access_0_689_symbol <= Xexit_691_symbol; -- control passed from block 
                -- 
              end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/word_access_0
              Xexit_688_symbol <= word_access_0_689_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access/$exit
              word_access_686_symbol <= Xexit_688_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/word_access
            merge_req_696_symbol <= word_access_686_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/merge_req
            simple_obj_ref_168_gather_scatter_req_0 <= merge_req_696_symbol; -- link to DP
            merge_ack_697_symbol <= simple_obj_ref_168_gather_scatter_ack_0; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/merge_ack
            Xexit_685_symbol <= merge_ack_697_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read/$exit
            simple_obj_ref_168_read_683_symbol <= Xexit_685_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/simple_obj_ref_168_read
          Xexit_682_symbol <= simple_obj_ref_168_read_683_symbol; -- transition branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168/$exit
          simple_obj_ref_168_680_symbol <= Xexit_682_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_108/assign_stmt_169/simple_obj_ref_168
        Xexit_679_symbol <= simple_obj_ref_168_680_symbol; -- transition branch_block_stmt_108/assign_stmt_169/$exit
        assign_stmt_169_677_symbol <= Xexit_679_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/assign_stmt_169
      return_x_xx_xPhiReq_698: Block -- branch_block_stmt_108/return___PhiReq 
        signal return_x_xx_xPhiReq_698_start: Boolean;
        signal Xentry_699_symbol: Boolean;
        signal Xexit_700_symbol: Boolean;
        -- 
      begin -- 
        return_x_xx_xPhiReq_698_start <= return_x_xx_x387_symbol; -- control passed to block
        Xentry_699_symbol  <= return_x_xx_xPhiReq_698_start; -- transition branch_block_stmt_108/return___PhiReq/$entry
        Xexit_700_symbol <= Xentry_699_symbol; -- transition branch_block_stmt_108/return___PhiReq/$exit
        return_x_xx_xPhiReq_698_symbol <= Xexit_700_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/return___PhiReq
      merge_stmt_166_PhiReqMerge_701_symbol  <=  return_x_xx_xPhiReq_698_symbol; -- place branch_block_stmt_108/merge_stmt_166_PhiReqMerge (optimized away) 
      merge_stmt_166_PhiAck_702: Block -- branch_block_stmt_108/merge_stmt_166_PhiAck 
        signal merge_stmt_166_PhiAck_702_start: Boolean;
        signal Xentry_703_symbol: Boolean;
        signal Xexit_704_symbol: Boolean;
        signal dummy_705_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_166_PhiAck_702_start <= merge_stmt_166_PhiReqMerge_701_symbol; -- control passed to block
        Xentry_703_symbol  <= merge_stmt_166_PhiAck_702_start; -- transition branch_block_stmt_108/merge_stmt_166_PhiAck/$entry
        dummy_705_symbol <= Xentry_703_symbol; -- transition branch_block_stmt_108/merge_stmt_166_PhiAck/dummy
        Xexit_704_symbol <= dummy_705_symbol; -- transition branch_block_stmt_108/merge_stmt_166_PhiAck/$exit
        merge_stmt_166_PhiAck_702_symbol <= Xexit_704_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_108/merge_stmt_166_PhiAck
      Xexit_358_symbol <= branch_block_stmt_108_x_xexit_x_xx_x360_symbol; -- transition branch_block_stmt_108/$exit
      branch_block_stmt_108_356_symbol <= Xexit_358_symbol; -- control passed from block 
      -- 
    end Block; -- branch_block_stmt_108
    Xexit_355_symbol <= branch_block_stmt_108_356_symbol; -- transition $exit
    fin  <=  '1' when Xexit_355_symbol else '0'; -- fin symbol when control-path exits
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
    -- shared load operator group (0) : ptr_deref_160_load_0 ptr_deref_142_load_0 ptr_deref_138_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_160_load_0_req_0;
      reqL(1) <= ptr_deref_142_load_0_req_0;
      reqL(0) <= ptr_deref_138_load_0_req_0;
      ptr_deref_160_load_0_ack_0 <= ackL(2);
      ptr_deref_142_load_0_ack_0 <= ackL(1);
      ptr_deref_138_load_0_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_160_load_0_req_1;
      reqR(1) <= ptr_deref_142_load_0_req_1;
      reqR(0) <= ptr_deref_138_load_0_req_1;
      ptr_deref_160_load_0_ack_1 <= ackR(2);
      ptr_deref_142_load_0_ack_1 <= ackR(1);
      ptr_deref_138_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_0 & ptr_deref_142_word_address_0 & ptr_deref_138_word_address_0;
      ptr_deref_160_data_0 <= data_out(23 downto 16);
      ptr_deref_142_data_0 <= data_out(15 downto 8);
      ptr_deref_138_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(3),
          mack => memory_space_0_lr_ack(3),
          maddr => memory_space_0_lr_addr(19 downto 15),
          mtag => memory_space_0_lr_tag(7 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(3),
          mack => memory_space_0_lc_ack(3),
          mdata => memory_space_0_lc_data(31 downto 24),
          mtag => memory_space_0_lc_tag(7 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_160_load_1 ptr_deref_142_load_1 ptr_deref_138_load_1 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_160_load_1_req_0;
      reqL(1) <= ptr_deref_142_load_1_req_0;
      reqL(0) <= ptr_deref_138_load_1_req_0;
      ptr_deref_160_load_1_ack_0 <= ackL(2);
      ptr_deref_142_load_1_ack_0 <= ackL(1);
      ptr_deref_138_load_1_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_160_load_1_req_1;
      reqR(1) <= ptr_deref_142_load_1_req_1;
      reqR(0) <= ptr_deref_138_load_1_req_1;
      ptr_deref_160_load_1_ack_1 <= ackR(2);
      ptr_deref_142_load_1_ack_1 <= ackR(1);
      ptr_deref_138_load_1_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_1 & ptr_deref_142_word_address_1 & ptr_deref_138_word_address_1;
      ptr_deref_160_data_1 <= data_out(23 downto 16);
      ptr_deref_142_data_1 <= data_out(15 downto 8);
      ptr_deref_138_data_1 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(2),
          mack => memory_space_0_lr_ack(2),
          maddr => memory_space_0_lr_addr(14 downto 10),
          mtag => memory_space_0_lr_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(2),
          mack => memory_space_0_lc_ack(2),
          mdata => memory_space_0_lc_data(23 downto 16),
          mtag => memory_space_0_lc_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : ptr_deref_160_load_2 ptr_deref_138_load_2 ptr_deref_142_load_2 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_160_load_2_req_0;
      reqL(1) <= ptr_deref_138_load_2_req_0;
      reqL(0) <= ptr_deref_142_load_2_req_0;
      ptr_deref_160_load_2_ack_0 <= ackL(2);
      ptr_deref_138_load_2_ack_0 <= ackL(1);
      ptr_deref_142_load_2_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_160_load_2_req_1;
      reqR(1) <= ptr_deref_138_load_2_req_1;
      reqR(0) <= ptr_deref_142_load_2_req_1;
      ptr_deref_160_load_2_ack_1 <= ackR(2);
      ptr_deref_138_load_2_ack_1 <= ackR(1);
      ptr_deref_142_load_2_ack_1 <= ackR(0);
      data_in <= ptr_deref_160_word_address_2 & ptr_deref_138_word_address_2 & ptr_deref_142_word_address_2;
      ptr_deref_160_data_2 <= data_out(23 downto 16);
      ptr_deref_138_data_2 <= data_out(15 downto 8);
      ptr_deref_142_data_2 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(1),
          mack => memory_space_0_lr_ack(1),
          maddr => memory_space_0_lr_addr(9 downto 5),
          mtag => memory_space_0_lr_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(1),
          mack => memory_space_0_lc_ack(1),
          mdata => memory_space_0_lc_data(15 downto 8),
          mtag => memory_space_0_lc_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : ptr_deref_138_load_3 ptr_deref_142_load_3 ptr_deref_160_load_3 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(14 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_138_load_3_req_0;
      reqL(1) <= ptr_deref_142_load_3_req_0;
      reqL(0) <= ptr_deref_160_load_3_req_0;
      ptr_deref_138_load_3_ack_0 <= ackL(2);
      ptr_deref_142_load_3_ack_0 <= ackL(1);
      ptr_deref_160_load_3_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_138_load_3_req_1;
      reqR(1) <= ptr_deref_142_load_3_req_1;
      reqR(0) <= ptr_deref_160_load_3_req_1;
      ptr_deref_138_load_3_ack_1 <= ackR(2);
      ptr_deref_142_load_3_ack_1 <= ackR(1);
      ptr_deref_160_load_3_ack_1 <= ackR(0);
      data_in <= ptr_deref_138_word_address_3 & ptr_deref_142_word_address_3 & ptr_deref_160_word_address_3;
      ptr_deref_138_data_3 <= data_out(23 downto 16);
      ptr_deref_142_data_3 <= data_out(15 downto 8);
      ptr_deref_160_data_3 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 5,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(4 downto 0),
          mtag => memory_space_0_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(7 downto 0),
          mtag => memory_space_0_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 3
    -- shared load operator group (4) : simple_obj_ref_168_load_0 
    LoadGroup4: Block -- 
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
    end Block; -- load group 4
    -- shared store operator group (0) : ptr_deref_133_store_0 ptr_deref_120_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_133_store_0_req_0;
      reqL(0) <= ptr_deref_120_store_0_req_0;
      ptr_deref_133_store_0_ack_0 <= ackL(1);
      ptr_deref_120_store_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_133_store_0_req_1;
      reqR(0) <= ptr_deref_120_store_0_req_1;
      ptr_deref_133_store_0_ack_1 <= ackR(1);
      ptr_deref_120_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_0 & ptr_deref_120_word_address_0;
      data_in <= ptr_deref_133_data_0 & ptr_deref_120_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(7 downto 6),
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
          mreq => memory_space_0_sc_req(3),
          mack => memory_space_0_sc_ack(3),
          mtag => memory_space_0_sc_tag(7 downto 6),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_120_store_1 ptr_deref_133_store_1 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_120_store_1_req_0;
      reqL(0) <= ptr_deref_133_store_1_req_0;
      ptr_deref_120_store_1_ack_0 <= ackL(1);
      ptr_deref_133_store_1_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_120_store_1_req_1;
      reqR(0) <= ptr_deref_133_store_1_req_1;
      ptr_deref_120_store_1_ack_1 <= ackR(1);
      ptr_deref_133_store_1_ack_1 <= ackR(0);
      addr_in <= ptr_deref_120_word_address_1 & ptr_deref_133_word_address_1;
      data_in <= ptr_deref_120_data_1 & ptr_deref_133_data_1;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(5 downto 4),
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
          mreq => memory_space_0_sc_req(2),
          mack => memory_space_0_sc_ack(2),
          mtag => memory_space_0_sc_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 1
    -- shared store operator group (2) : ptr_deref_133_store_2 ptr_deref_120_store_2 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_133_store_2_req_0;
      reqL(0) <= ptr_deref_120_store_2_req_0;
      ptr_deref_133_store_2_ack_0 <= ackL(1);
      ptr_deref_120_store_2_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_133_store_2_req_1;
      reqR(0) <= ptr_deref_120_store_2_req_1;
      ptr_deref_133_store_2_ack_1 <= ackR(1);
      ptr_deref_120_store_2_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_2 & ptr_deref_120_word_address_2;
      data_in <= ptr_deref_133_data_2 & ptr_deref_120_data_2;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(3 downto 2),
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
          mreq => memory_space_0_sc_req(1),
          mack => memory_space_0_sc_ack(1),
          mtag => memory_space_0_sc_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared store operator group (3) : ptr_deref_133_store_3 ptr_deref_120_store_3 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(9 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_133_store_3_req_0;
      reqL(0) <= ptr_deref_120_store_3_req_0;
      ptr_deref_133_store_3_ack_0 <= ackL(1);
      ptr_deref_120_store_3_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_133_store_3_req_1;
      reqR(0) <= ptr_deref_120_store_3_req_1;
      ptr_deref_133_store_3_ack_1 <= ackR(1);
      ptr_deref_120_store_3_ack_1 <= ackR(0);
      addr_in <= ptr_deref_133_word_address_3 & ptr_deref_120_word_address_3;
      data_in <= ptr_deref_133_data_3 & ptr_deref_120_data_3;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 5,
        data_width => 8,
        num_reqs => 2,
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(1 downto 0),
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
          mreq => memory_space_0_sc_req(0),
          mack => memory_space_0_sc_ack(0),
          mtag => memory_space_0_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 3
    -- shared store operator group (4) : simple_obj_ref_162_store_0 
    StoreGroup4: Block -- 
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
    end Block; -- store group 4
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
    memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_lc_data : in   std_logic_vector(7 downto 0);
    memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity mem_load_x_x;
architecture Default of mem_load_x_x is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- links between control-path and data-path
  signal array_obj_ref_13_offset_inst_ack_0 : boolean;
  signal array_obj_ref_13_root_address_inst_req_0 : boolean;
  signal array_obj_ref_13_root_address_inst_ack_0 : boolean;
  signal array_obj_ref_13_addr_0_req_0 : boolean;
  signal array_obj_ref_13_addr_0_ack_0 : boolean;
  signal array_obj_ref_13_load_0_req_1 : boolean;
  signal array_obj_ref_13_load_0_ack_1 : boolean;
  signal array_obj_ref_13_gather_scatter_req_0 : boolean;
  signal array_obj_ref_13_gather_scatter_ack_0 : boolean;
  signal binary_10_inst_req_0 : boolean;
  signal binary_10_inst_ack_0 : boolean;
  signal binary_10_inst_req_1 : boolean;
  signal binary_10_inst_ack_1 : boolean;
  signal binary_12_inst_req_0 : boolean;
  signal binary_12_inst_ack_0 : boolean;
  signal binary_12_inst_req_1 : boolean;
  signal binary_12_inst_ack_1 : boolean;
  signal array_obj_ref_13_load_0_req_0 : boolean;
  signal array_obj_ref_13_load_0_ack_0 : boolean;
  signal array_obj_ref_13_index_0_resize_req_0 : boolean;
  signal array_obj_ref_13_index_0_resize_ack_0 : boolean;
  signal array_obj_ref_13_index_0_rename_req_0 : boolean;
  signal array_obj_ref_13_index_0_rename_ack_0 : boolean;
  signal array_obj_ref_13_offset_inst_req_0 : boolean;
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
  mem_load_x_xx_xCP_706: Block -- control-path 
    signal mem_load_x_xx_xCP_706_start: Boolean;
    signal Xentry_707_symbol: Boolean;
    signal Xexit_708_symbol: Boolean;
    signal assign_stmt_14_709_symbol : Boolean;
    -- 
  begin -- 
    mem_load_x_xx_xCP_706_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_707_symbol  <= mem_load_x_xx_xCP_706_start; -- transition $entry
    assign_stmt_14_709: Block -- assign_stmt_14 
      signal assign_stmt_14_709_start: Boolean;
      signal Xentry_710_symbol: Boolean;
      signal Xexit_711_symbol: Boolean;
      signal array_obj_ref_13_712_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_14_709_start <= Xentry_707_symbol; -- control passed to block
      Xentry_710_symbol  <= assign_stmt_14_709_start; -- transition assign_stmt_14/$entry
      array_obj_ref_13_712: Block -- assign_stmt_14/array_obj_ref_13 
        signal array_obj_ref_13_712_start: Boolean;
        signal Xentry_713_symbol: Boolean;
        signal Xexit_714_symbol: Boolean;
        signal array_obj_ref_13_addr_gen_715_symbol : Boolean;
        signal array_obj_ref_13_read_757_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_13_712_start <= Xentry_710_symbol; -- control passed to block
        Xentry_713_symbol  <= array_obj_ref_13_712_start; -- transition assign_stmt_14/array_obj_ref_13/$entry
        array_obj_ref_13_addr_gen_715: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen 
          signal array_obj_ref_13_addr_gen_715_start: Boolean;
          signal Xentry_716_symbol: Boolean;
          signal Xexit_717_symbol: Boolean;
          signal scale_indices_718_symbol : Boolean;
          signal add_indices_748_symbol : Boolean;
          signal sum_rename_req_753_symbol : Boolean;
          signal sum_rename_ack_754_symbol : Boolean;
          signal root_rename_req_755_symbol : Boolean;
          signal root_rename_ack_756_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_13_addr_gen_715_start <= Xentry_713_symbol; -- control passed to block
          Xentry_716_symbol  <= array_obj_ref_13_addr_gen_715_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/$entry
          scale_indices_718: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices 
            signal scale_indices_718_start: Boolean;
            signal Xentry_719_symbol: Boolean;
            signal Xexit_720_symbol: Boolean;
            signal idx_0_721_symbol : Boolean;
            -- 
          begin -- 
            scale_indices_718_start <= Xentry_716_symbol; -- control passed to block
            Xentry_719_symbol  <= scale_indices_718_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/$entry
            idx_0_721: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0 
              signal idx_0_721_start: Boolean;
              signal Xentry_722_symbol: Boolean;
              signal Xexit_723_symbol: Boolean;
              signal binary_12_724_symbol : Boolean;
              signal index_resize_req_744_symbol : Boolean;
              signal index_resize_ack_745_symbol : Boolean;
              signal scale_rename_req_746_symbol : Boolean;
              signal scale_rename_ack_747_symbol : Boolean;
              -- 
            begin -- 
              idx_0_721_start <= Xentry_719_symbol; -- control passed to block
              Xentry_722_symbol  <= idx_0_721_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/$entry
              binary_12_724: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12 
                signal binary_12_724_start: Boolean;
                signal Xentry_725_symbol: Boolean;
                signal Xexit_726_symbol: Boolean;
                signal binary_12_inputs_727_symbol : Boolean;
                signal rr_740_symbol : Boolean;
                signal ra_741_symbol : Boolean;
                signal cr_742_symbol : Boolean;
                signal ca_743_symbol : Boolean;
                -- 
              begin -- 
                binary_12_724_start <= Xentry_722_symbol; -- control passed to block
                Xentry_725_symbol  <= binary_12_724_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/$entry
                binary_12_inputs_727: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs 
                  signal binary_12_inputs_727_start: Boolean;
                  signal Xentry_728_symbol: Boolean;
                  signal Xexit_729_symbol: Boolean;
                  signal binary_10_730_symbol : Boolean;
                  -- 
                begin -- 
                  binary_12_inputs_727_start <= Xentry_725_symbol; -- control passed to block
                  Xentry_728_symbol  <= binary_12_inputs_727_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/$entry
                  binary_10_730: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10 
                    signal binary_10_730_start: Boolean;
                    signal Xentry_731_symbol: Boolean;
                    signal Xexit_732_symbol: Boolean;
                    signal binary_10_inputs_733_symbol : Boolean;
                    signal rr_736_symbol : Boolean;
                    signal ra_737_symbol : Boolean;
                    signal cr_738_symbol : Boolean;
                    signal ca_739_symbol : Boolean;
                    -- 
                  begin -- 
                    binary_10_730_start <= Xentry_728_symbol; -- control passed to block
                    Xentry_731_symbol  <= binary_10_730_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/$entry
                    binary_10_inputs_733: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/binary_10_inputs 
                      signal binary_10_inputs_733_start: Boolean;
                      signal Xentry_734_symbol: Boolean;
                      signal Xexit_735_symbol: Boolean;
                      -- 
                    begin -- 
                      binary_10_inputs_733_start <= Xentry_731_symbol; -- control passed to block
                      Xentry_734_symbol  <= binary_10_inputs_733_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/binary_10_inputs/$entry
                      Xexit_735_symbol <= Xentry_734_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/binary_10_inputs/$exit
                      binary_10_inputs_733_symbol <= Xexit_735_symbol; -- control passed from block 
                      -- 
                    end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/binary_10_inputs
                    rr_736_symbol <= binary_10_inputs_733_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/rr
                    binary_10_inst_req_0 <= rr_736_symbol; -- link to DP
                    ra_737_symbol <= binary_10_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/ra
                    cr_738_symbol <= ra_737_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/cr
                    binary_10_inst_req_1 <= cr_738_symbol; -- link to DP
                    ca_739_symbol <= binary_10_inst_ack_1; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/ca
                    Xexit_732_symbol <= ca_739_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10/$exit
                    binary_10_730_symbol <= Xexit_732_symbol; -- control passed from block 
                    -- 
                  end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/binary_10
                  Xexit_729_symbol <= binary_10_730_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs/$exit
                  binary_12_inputs_727_symbol <= Xexit_729_symbol; -- control passed from block 
                  -- 
                end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/binary_12_inputs
                rr_740_symbol <= binary_12_inputs_727_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/rr
                binary_12_inst_req_0 <= rr_740_symbol; -- link to DP
                ra_741_symbol <= binary_12_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/ra
                cr_742_symbol <= ra_741_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/cr
                binary_12_inst_req_1 <= cr_742_symbol; -- link to DP
                ca_743_symbol <= binary_12_inst_ack_1; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/ca
                Xexit_726_symbol <= ca_743_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12/$exit
                binary_12_724_symbol <= Xexit_726_symbol; -- control passed from block 
                -- 
              end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/binary_12
              index_resize_req_744_symbol <= binary_12_724_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/index_resize_req
              array_obj_ref_13_index_0_resize_req_0 <= index_resize_req_744_symbol; -- link to DP
              index_resize_ack_745_symbol <= array_obj_ref_13_index_0_resize_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/index_resize_ack
              scale_rename_req_746_symbol <= index_resize_ack_745_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/scale_rename_req
              array_obj_ref_13_index_0_rename_req_0 <= scale_rename_req_746_symbol; -- link to DP
              scale_rename_ack_747_symbol <= array_obj_ref_13_index_0_rename_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/scale_rename_ack
              Xexit_723_symbol <= scale_rename_ack_747_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0/$exit
              idx_0_721_symbol <= Xexit_723_symbol; -- control passed from block 
              -- 
            end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/idx_0
            Xexit_720_symbol <= idx_0_721_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices/$exit
            scale_indices_718_symbol <= Xexit_720_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/scale_indices
          add_indices_748: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/add_indices 
            signal add_indices_748_start: Boolean;
            signal Xentry_749_symbol: Boolean;
            signal Xexit_750_symbol: Boolean;
            signal final_index_req_751_symbol : Boolean;
            signal final_index_ack_752_symbol : Boolean;
            -- 
          begin -- 
            add_indices_748_start <= scale_indices_718_symbol; -- control passed to block
            Xentry_749_symbol  <= add_indices_748_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/add_indices/$entry
            final_index_req_751_symbol <= Xentry_749_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/add_indices/final_index_req
            array_obj_ref_13_offset_inst_req_0 <= final_index_req_751_symbol; -- link to DP
            final_index_ack_752_symbol <= array_obj_ref_13_offset_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/add_indices/final_index_ack
            Xexit_750_symbol <= final_index_ack_752_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/add_indices/$exit
            add_indices_748_symbol <= Xexit_750_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/add_indices
          sum_rename_req_753_symbol <= add_indices_748_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/sum_rename_req
          array_obj_ref_13_root_address_inst_req_0 <= sum_rename_req_753_symbol; -- link to DP
          sum_rename_ack_754_symbol <= array_obj_ref_13_root_address_inst_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/sum_rename_ack
          root_rename_req_755_symbol <= sum_rename_ack_754_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/root_rename_req
          array_obj_ref_13_addr_0_req_0 <= root_rename_req_755_symbol; -- link to DP
          root_rename_ack_756_symbol <= array_obj_ref_13_addr_0_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/root_rename_ack
          Xexit_717_symbol <= root_rename_ack_756_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen/$exit
          array_obj_ref_13_addr_gen_715_symbol <= Xexit_717_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_addr_gen
        array_obj_ref_13_read_757: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read 
          signal array_obj_ref_13_read_757_start: Boolean;
          signal Xentry_758_symbol: Boolean;
          signal Xexit_759_symbol: Boolean;
          signal word_access_760_symbol : Boolean;
          signal merge_req_770_symbol : Boolean;
          signal merge_ack_771_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_13_read_757_start <= array_obj_ref_13_addr_gen_715_symbol; -- control passed to block
          Xentry_758_symbol  <= array_obj_ref_13_read_757_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/$entry
          word_access_760: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access 
            signal word_access_760_start: Boolean;
            signal Xentry_761_symbol: Boolean;
            signal Xexit_762_symbol: Boolean;
            signal word_access_0_763_symbol : Boolean;
            -- 
          begin -- 
            word_access_760_start <= Xentry_758_symbol; -- control passed to block
            Xentry_761_symbol  <= word_access_760_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/$entry
            word_access_0_763: Block -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0 
              signal word_access_0_763_start: Boolean;
              signal Xentry_764_symbol: Boolean;
              signal Xexit_765_symbol: Boolean;
              signal rr_766_symbol : Boolean;
              signal ra_767_symbol : Boolean;
              signal cr_768_symbol : Boolean;
              signal ca_769_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_763_start <= Xentry_761_symbol; -- control passed to block
              Xentry_764_symbol  <= word_access_0_763_start; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0/$entry
              rr_766_symbol <= Xentry_764_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0/rr
              array_obj_ref_13_load_0_req_0 <= rr_766_symbol; -- link to DP
              ra_767_symbol <= array_obj_ref_13_load_0_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0/ra
              cr_768_symbol <= ra_767_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0/cr
              array_obj_ref_13_load_0_req_1 <= cr_768_symbol; -- link to DP
              ca_769_symbol <= array_obj_ref_13_load_0_ack_1; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0/ca
              Xexit_765_symbol <= ca_769_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0/$exit
              word_access_0_763_symbol <= Xexit_765_symbol; -- control passed from block 
              -- 
            end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/word_access_0
            Xexit_762_symbol <= word_access_0_763_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access/$exit
            word_access_760_symbol <= Xexit_762_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/word_access
          merge_req_770_symbol <= word_access_760_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/merge_req
          array_obj_ref_13_gather_scatter_req_0 <= merge_req_770_symbol; -- link to DP
          merge_ack_771_symbol <= array_obj_ref_13_gather_scatter_ack_0; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/merge_ack
          Xexit_759_symbol <= merge_ack_771_symbol; -- transition assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read/$exit
          array_obj_ref_13_read_757_symbol <= Xexit_759_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_14/array_obj_ref_13/array_obj_ref_13_read
        Xexit_714_symbol <= array_obj_ref_13_read_757_symbol; -- transition assign_stmt_14/array_obj_ref_13/$exit
        array_obj_ref_13_712_symbol <= Xexit_714_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_14/array_obj_ref_13
      Xexit_711_symbol <= array_obj_ref_13_712_symbol; -- transition assign_stmt_14/$exit
      assign_stmt_14_709_symbol <= Xexit_711_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_14
    Xexit_708_symbol <= assign_stmt_14_709_symbol; -- transition $exit
    fin  <=  '1' when Xexit_708_symbol else '0'; -- fin symbol when control-path exits
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
        generic map (addr_width => 5,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_0_lr_req(0),
          mack => memory_space_0_lr_ack(0),
          maddr => memory_space_0_lr_addr(4 downto 0),
          mtag => memory_space_0_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_0_lc_req(0),
          mack => memory_space_0_lc_ack(0),
          mdata => memory_space_0_lc_data(7 downto 0),
          mtag => memory_space_0_lc_tag(1 downto 0),
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
    memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
    memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
    memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
    memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
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
  mem_store_x_xx_xCP_772: Block -- control-path 
    signal mem_store_x_xx_xCP_772_start: Boolean;
    signal Xentry_773_symbol: Boolean;
    signal Xexit_774_symbol: Boolean;
    signal assign_stmt_26_775_symbol : Boolean;
    -- 
  begin -- 
    mem_store_x_xx_xCP_772_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_773_symbol  <= mem_store_x_xx_xCP_772_start; -- transition $entry
    assign_stmt_26_775: Block -- assign_stmt_26 
      signal assign_stmt_26_775_start: Boolean;
      signal Xentry_776_symbol: Boolean;
      signal Xexit_777_symbol: Boolean;
      signal array_obj_ref_24_778_symbol : Boolean;
      -- 
    begin -- 
      assign_stmt_26_775_start <= Xentry_773_symbol; -- control passed to block
      Xentry_776_symbol  <= assign_stmt_26_775_start; -- transition assign_stmt_26/$entry
      array_obj_ref_24_778: Block -- assign_stmt_26/array_obj_ref_24 
        signal array_obj_ref_24_778_start: Boolean;
        signal Xentry_779_symbol: Boolean;
        signal Xexit_780_symbol: Boolean;
        signal array_obj_ref_24_addr_gen_781_symbol : Boolean;
        signal array_obj_ref_24_write_823_symbol : Boolean;
        -- 
      begin -- 
        array_obj_ref_24_778_start <= Xentry_776_symbol; -- control passed to block
        Xentry_779_symbol  <= array_obj_ref_24_778_start; -- transition assign_stmt_26/array_obj_ref_24/$entry
        array_obj_ref_24_addr_gen_781: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen 
          signal array_obj_ref_24_addr_gen_781_start: Boolean;
          signal Xentry_782_symbol: Boolean;
          signal Xexit_783_symbol: Boolean;
          signal scale_indices_784_symbol : Boolean;
          signal add_indices_814_symbol : Boolean;
          signal sum_rename_req_819_symbol : Boolean;
          signal sum_rename_ack_820_symbol : Boolean;
          signal root_rename_req_821_symbol : Boolean;
          signal root_rename_ack_822_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_24_addr_gen_781_start <= Xentry_779_symbol; -- control passed to block
          Xentry_782_symbol  <= array_obj_ref_24_addr_gen_781_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/$entry
          scale_indices_784: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices 
            signal scale_indices_784_start: Boolean;
            signal Xentry_785_symbol: Boolean;
            signal Xexit_786_symbol: Boolean;
            signal idx_0_787_symbol : Boolean;
            -- 
          begin -- 
            scale_indices_784_start <= Xentry_782_symbol; -- control passed to block
            Xentry_785_symbol  <= scale_indices_784_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/$entry
            idx_0_787: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0 
              signal idx_0_787_start: Boolean;
              signal Xentry_788_symbol: Boolean;
              signal Xexit_789_symbol: Boolean;
              signal binary_23_790_symbol : Boolean;
              signal index_resize_req_810_symbol : Boolean;
              signal index_resize_ack_811_symbol : Boolean;
              signal scale_rename_req_812_symbol : Boolean;
              signal scale_rename_ack_813_symbol : Boolean;
              -- 
            begin -- 
              idx_0_787_start <= Xentry_785_symbol; -- control passed to block
              Xentry_788_symbol  <= idx_0_787_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/$entry
              binary_23_790: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23 
                signal binary_23_790_start: Boolean;
                signal Xentry_791_symbol: Boolean;
                signal Xexit_792_symbol: Boolean;
                signal binary_23_inputs_793_symbol : Boolean;
                signal rr_806_symbol : Boolean;
                signal ra_807_symbol : Boolean;
                signal cr_808_symbol : Boolean;
                signal ca_809_symbol : Boolean;
                -- 
              begin -- 
                binary_23_790_start <= Xentry_788_symbol; -- control passed to block
                Xentry_791_symbol  <= binary_23_790_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/$entry
                binary_23_inputs_793: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs 
                  signal binary_23_inputs_793_start: Boolean;
                  signal Xentry_794_symbol: Boolean;
                  signal Xexit_795_symbol: Boolean;
                  signal binary_21_796_symbol : Boolean;
                  -- 
                begin -- 
                  binary_23_inputs_793_start <= Xentry_791_symbol; -- control passed to block
                  Xentry_794_symbol  <= binary_23_inputs_793_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/$entry
                  binary_21_796: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21 
                    signal binary_21_796_start: Boolean;
                    signal Xentry_797_symbol: Boolean;
                    signal Xexit_798_symbol: Boolean;
                    signal binary_21_inputs_799_symbol : Boolean;
                    signal rr_802_symbol : Boolean;
                    signal ra_803_symbol : Boolean;
                    signal cr_804_symbol : Boolean;
                    signal ca_805_symbol : Boolean;
                    -- 
                  begin -- 
                    binary_21_796_start <= Xentry_794_symbol; -- control passed to block
                    Xentry_797_symbol  <= binary_21_796_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/$entry
                    binary_21_inputs_799: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/binary_21_inputs 
                      signal binary_21_inputs_799_start: Boolean;
                      signal Xentry_800_symbol: Boolean;
                      signal Xexit_801_symbol: Boolean;
                      -- 
                    begin -- 
                      binary_21_inputs_799_start <= Xentry_797_symbol; -- control passed to block
                      Xentry_800_symbol  <= binary_21_inputs_799_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/binary_21_inputs/$entry
                      Xexit_801_symbol <= Xentry_800_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/binary_21_inputs/$exit
                      binary_21_inputs_799_symbol <= Xexit_801_symbol; -- control passed from block 
                      -- 
                    end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/binary_21_inputs
                    rr_802_symbol <= binary_21_inputs_799_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/rr
                    binary_21_inst_req_0 <= rr_802_symbol; -- link to DP
                    ra_803_symbol <= binary_21_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/ra
                    cr_804_symbol <= ra_803_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/cr
                    binary_21_inst_req_1 <= cr_804_symbol; -- link to DP
                    ca_805_symbol <= binary_21_inst_ack_1; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/ca
                    Xexit_798_symbol <= ca_805_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21/$exit
                    binary_21_796_symbol <= Xexit_798_symbol; -- control passed from block 
                    -- 
                  end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/binary_21
                  Xexit_795_symbol <= binary_21_796_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs/$exit
                  binary_23_inputs_793_symbol <= Xexit_795_symbol; -- control passed from block 
                  -- 
                end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/binary_23_inputs
                rr_806_symbol <= binary_23_inputs_793_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/rr
                binary_23_inst_req_0 <= rr_806_symbol; -- link to DP
                ra_807_symbol <= binary_23_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/ra
                cr_808_symbol <= ra_807_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/cr
                binary_23_inst_req_1 <= cr_808_symbol; -- link to DP
                ca_809_symbol <= binary_23_inst_ack_1; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/ca
                Xexit_792_symbol <= ca_809_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23/$exit
                binary_23_790_symbol <= Xexit_792_symbol; -- control passed from block 
                -- 
              end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/binary_23
              index_resize_req_810_symbol <= binary_23_790_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/index_resize_req
              array_obj_ref_24_index_0_resize_req_0 <= index_resize_req_810_symbol; -- link to DP
              index_resize_ack_811_symbol <= array_obj_ref_24_index_0_resize_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/index_resize_ack
              scale_rename_req_812_symbol <= index_resize_ack_811_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/scale_rename_req
              array_obj_ref_24_index_0_rename_req_0 <= scale_rename_req_812_symbol; -- link to DP
              scale_rename_ack_813_symbol <= array_obj_ref_24_index_0_rename_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/scale_rename_ack
              Xexit_789_symbol <= scale_rename_ack_813_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0/$exit
              idx_0_787_symbol <= Xexit_789_symbol; -- control passed from block 
              -- 
            end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/idx_0
            Xexit_786_symbol <= idx_0_787_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices/$exit
            scale_indices_784_symbol <= Xexit_786_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/scale_indices
          add_indices_814: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/add_indices 
            signal add_indices_814_start: Boolean;
            signal Xentry_815_symbol: Boolean;
            signal Xexit_816_symbol: Boolean;
            signal final_index_req_817_symbol : Boolean;
            signal final_index_ack_818_symbol : Boolean;
            -- 
          begin -- 
            add_indices_814_start <= scale_indices_784_symbol; -- control passed to block
            Xentry_815_symbol  <= add_indices_814_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/add_indices/$entry
            final_index_req_817_symbol <= Xentry_815_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/add_indices/final_index_req
            array_obj_ref_24_offset_inst_req_0 <= final_index_req_817_symbol; -- link to DP
            final_index_ack_818_symbol <= array_obj_ref_24_offset_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/add_indices/final_index_ack
            Xexit_816_symbol <= final_index_ack_818_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/add_indices/$exit
            add_indices_814_symbol <= Xexit_816_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/add_indices
          sum_rename_req_819_symbol <= add_indices_814_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/sum_rename_req
          array_obj_ref_24_root_address_inst_req_0 <= sum_rename_req_819_symbol; -- link to DP
          sum_rename_ack_820_symbol <= array_obj_ref_24_root_address_inst_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/sum_rename_ack
          root_rename_req_821_symbol <= sum_rename_ack_820_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/root_rename_req
          array_obj_ref_24_addr_0_req_0 <= root_rename_req_821_symbol; -- link to DP
          root_rename_ack_822_symbol <= array_obj_ref_24_addr_0_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/root_rename_ack
          Xexit_783_symbol <= root_rename_ack_822_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen/$exit
          array_obj_ref_24_addr_gen_781_symbol <= Xexit_783_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_addr_gen
        array_obj_ref_24_write_823: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write 
          signal array_obj_ref_24_write_823_start: Boolean;
          signal Xentry_824_symbol: Boolean;
          signal Xexit_825_symbol: Boolean;
          signal split_req_826_symbol : Boolean;
          signal split_ack_827_symbol : Boolean;
          signal word_access_828_symbol : Boolean;
          -- 
        begin -- 
          array_obj_ref_24_write_823_start <= array_obj_ref_24_addr_gen_781_symbol; -- control passed to block
          Xentry_824_symbol  <= array_obj_ref_24_write_823_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/$entry
          split_req_826_symbol <= Xentry_824_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/split_req
          array_obj_ref_24_gather_scatter_req_0 <= split_req_826_symbol; -- link to DP
          split_ack_827_symbol <= array_obj_ref_24_gather_scatter_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/split_ack
          word_access_828: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access 
            signal word_access_828_start: Boolean;
            signal Xentry_829_symbol: Boolean;
            signal Xexit_830_symbol: Boolean;
            signal word_access_0_831_symbol : Boolean;
            -- 
          begin -- 
            word_access_828_start <= split_ack_827_symbol; -- control passed to block
            Xentry_829_symbol  <= word_access_828_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/$entry
            word_access_0_831: Block -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0 
              signal word_access_0_831_start: Boolean;
              signal Xentry_832_symbol: Boolean;
              signal Xexit_833_symbol: Boolean;
              signal rr_834_symbol : Boolean;
              signal ra_835_symbol : Boolean;
              signal cr_836_symbol : Boolean;
              signal ca_837_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_831_start <= Xentry_829_symbol; -- control passed to block
              Xentry_832_symbol  <= word_access_0_831_start; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0/$entry
              rr_834_symbol <= Xentry_832_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0/rr
              array_obj_ref_24_store_0_req_0 <= rr_834_symbol; -- link to DP
              ra_835_symbol <= array_obj_ref_24_store_0_ack_0; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0/ra
              cr_836_symbol <= ra_835_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0/cr
              array_obj_ref_24_store_0_req_1 <= cr_836_symbol; -- link to DP
              ca_837_symbol <= array_obj_ref_24_store_0_ack_1; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0/ca
              Xexit_833_symbol <= ca_837_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0/$exit
              word_access_0_831_symbol <= Xexit_833_symbol; -- control passed from block 
              -- 
            end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/word_access_0
            Xexit_830_symbol <= word_access_0_831_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access/$exit
            word_access_828_symbol <= Xexit_830_symbol; -- control passed from block 
            -- 
          end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/word_access
          Xexit_825_symbol <= word_access_828_symbol; -- transition assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write/$exit
          array_obj_ref_24_write_823_symbol <= Xexit_825_symbol; -- control passed from block 
          -- 
        end Block; -- assign_stmt_26/array_obj_ref_24/array_obj_ref_24_write
        Xexit_780_symbol <= array_obj_ref_24_write_823_symbol; -- transition assign_stmt_26/array_obj_ref_24/$exit
        array_obj_ref_24_778_symbol <= Xexit_780_symbol; -- control passed from block 
        -- 
      end Block; -- assign_stmt_26/array_obj_ref_24
      Xexit_777_symbol <= array_obj_ref_24_778_symbol; -- transition assign_stmt_26/$exit
      assign_stmt_26_775_symbol <= Xexit_777_symbol; -- control passed from block 
      -- 
    end Block; -- assign_stmt_26
    Xexit_774_symbol <= assign_stmt_26_775_symbol; -- transition $exit
    fin  <=  '1' when Xexit_774_symbol else '0'; -- fin symbol when control-path exits
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
        tag_length => 2,
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
          mtag => memory_space_0_sr_tag(1 downto 0),
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
          mreq => memory_space_0_sc_req(0),
          mack => memory_space_0_sc_ack(0),
          mtag => memory_space_0_sc_tag(1 downto 0),
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
  signal memory_space_0_lr_req :  std_logic_vector(8 downto 0);
  signal memory_space_0_lr_ack : std_logic_vector(8 downto 0);
  signal memory_space_0_lr_addr : std_logic_vector(44 downto 0);
  signal memory_space_0_lr_tag : std_logic_vector(17 downto 0);
  signal memory_space_0_lc_req : std_logic_vector(8 downto 0);
  signal memory_space_0_lc_ack :  std_logic_vector(8 downto 0);
  signal memory_space_0_lc_data : std_logic_vector(71 downto 0);
  signal memory_space_0_lc_tag :  std_logic_vector(17 downto 0);
  signal memory_space_0_sr_req :  std_logic_vector(8 downto 0);
  signal memory_space_0_sr_ack : std_logic_vector(8 downto 0);
  signal memory_space_0_sr_addr : std_logic_vector(44 downto 0);
  signal memory_space_0_sr_data : std_logic_vector(71 downto 0);
  signal memory_space_0_sr_tag : std_logic_vector(17 downto 0);
  signal memory_space_0_sc_req : std_logic_vector(8 downto 0);
  signal memory_space_0_sc_ack :  std_logic_vector(8 downto 0);
  signal memory_space_0_sc_tag :  std_logic_vector(17 downto 0);
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
      memory_space_0_lr_req : out  std_logic_vector(3 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(3 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(19 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(7 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(3 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(3 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(7 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(3 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(3 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(19 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(3 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(3 downto 0);
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
      memory_space_0_lr_req : out  std_logic_vector(3 downto 0);
      memory_space_0_lr_ack : in   std_logic_vector(3 downto 0);
      memory_space_0_lr_addr : out  std_logic_vector(19 downto 0);
      memory_space_0_lr_tag :  out  std_logic_vector(7 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(3 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(3 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(31 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(7 downto 0);
      memory_space_0_sr_req : out  std_logic_vector(3 downto 0);
      memory_space_0_sr_ack : in   std_logic_vector(3 downto 0);
      memory_space_0_sr_addr : out  std_logic_vector(19 downto 0);
      memory_space_0_sr_data : out  std_logic_vector(31 downto 0);
      memory_space_0_sr_tag :  out  std_logic_vector(7 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(3 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(3 downto 0);
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
      memory_space_0_lr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_lc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_lc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_lc_data : in   std_logic_vector(7 downto 0);
      memory_space_0_lc_tag :  in  std_logic_vector(1 downto 0);
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
      memory_space_0_sr_tag :  out  std_logic_vector(1 downto 0);
      memory_space_0_sc_req : out  std_logic_vector(0 downto 0);
      memory_space_0_sc_ack : in   std_logic_vector(0 downto 0);
      memory_space_0_sc_tag :  in  std_logic_vector(1 downto 0);
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
      memory_space_0_lr_req => memory_space_0_lr_req(8 downto 5),
      memory_space_0_lr_ack => memory_space_0_lr_ack(8 downto 5),
      memory_space_0_lr_addr => memory_space_0_lr_addr(44 downto 25),
      memory_space_0_lr_tag => memory_space_0_lr_tag(17 downto 10),
      memory_space_0_lc_req => memory_space_0_lc_req(8 downto 5),
      memory_space_0_lc_ack => memory_space_0_lc_ack(8 downto 5),
      memory_space_0_lc_data => memory_space_0_lc_data(71 downto 40),
      memory_space_0_lc_tag => memory_space_0_lc_tag(17 downto 10),
      memory_space_0_sr_req => memory_space_0_sr_req(8 downto 5),
      memory_space_0_sr_ack => memory_space_0_sr_ack(8 downto 5),
      memory_space_0_sr_addr => memory_space_0_sr_addr(44 downto 25),
      memory_space_0_sr_data => memory_space_0_sr_data(71 downto 40),
      memory_space_0_sr_tag => memory_space_0_sr_tag(17 downto 10),
      memory_space_0_sc_req => memory_space_0_sc_req(8 downto 5),
      memory_space_0_sc_ack => memory_space_0_sc_ack(8 downto 5),
      memory_space_0_sc_tag => memory_space_0_sc_tag(17 downto 10),
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
      memory_space_0_lr_req => memory_space_0_lr_req(4 downto 1),
      memory_space_0_lr_ack => memory_space_0_lr_ack(4 downto 1),
      memory_space_0_lr_addr => memory_space_0_lr_addr(24 downto 5),
      memory_space_0_lr_tag => memory_space_0_lr_tag(9 downto 2),
      memory_space_0_lc_req => memory_space_0_lc_req(4 downto 1),
      memory_space_0_lc_ack => memory_space_0_lc_ack(4 downto 1),
      memory_space_0_lc_data => memory_space_0_lc_data(39 downto 8),
      memory_space_0_lc_tag => memory_space_0_lc_tag(9 downto 2),
      memory_space_0_sr_req => memory_space_0_sr_req(4 downto 1),
      memory_space_0_sr_ack => memory_space_0_sr_ack(4 downto 1),
      memory_space_0_sr_addr => memory_space_0_sr_addr(24 downto 5),
      memory_space_0_sr_data => memory_space_0_sr_data(39 downto 8),
      memory_space_0_sr_tag => memory_space_0_sr_tag(9 downto 2),
      memory_space_0_sc_req => memory_space_0_sc_req(4 downto 1),
      memory_space_0_sc_ack => memory_space_0_sc_ack(4 downto 1),
      memory_space_0_sc_tag => memory_space_0_sc_tag(9 downto 2),
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
      memory_space_0_lr_req => memory_space_0_lr_req(0 downto 0),
      memory_space_0_lr_ack => memory_space_0_lr_ack(0 downto 0),
      memory_space_0_lr_addr => memory_space_0_lr_addr(4 downto 0),
      memory_space_0_lr_tag => memory_space_0_lr_tag(1 downto 0),
      memory_space_0_lc_req => memory_space_0_lc_req(0 downto 0),
      memory_space_0_lc_ack => memory_space_0_lc_ack(0 downto 0),
      memory_space_0_lc_data => memory_space_0_lc_data(7 downto 0),
      memory_space_0_lc_tag => memory_space_0_lc_tag(1 downto 0),
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
      memory_space_0_sr_tag => memory_space_0_sr_tag(1 downto 0),
      memory_space_0_sc_req => memory_space_0_sc_req(0 downto 0),
      memory_space_0_sc_ack => memory_space_0_sc_ack(0 downto 0),
      memory_space_0_sc_tag => memory_space_0_sc_tag(1 downto 0),
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
      num_loads => 9,
      num_stores => 9,
      addr_width => 5,
      data_width => 8,
      tag_width => 2,
      number_of_banks => 2,
      mux_degree => 2,
      demux_degree => 2,
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
library work;
use work.vc_system_package.all;
use work.Utility_Package.all;
use work.Modelsim_FLI_Foreign.all;
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
    Modelsim_FLI_Initialize;
    wait until clk = '1';
    reset <= '0';
    while true loop --
      Modelsim_FLI_Listen;
      Modelsim_FLI_Send;
      wait until clk = '1';
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
      obj_ref := Pack_String_To_VHPI_String("bar req");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      bar_start <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("bar 0");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      bar_a <= Unpack_String(val_string,32);
      obj_ref := Pack_String_To_Vhpi_String("bar ack");
      val_string := To_String(bar_fin);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
      obj_ref := Pack_String_To_Vhpi_String("bar 0");
      val_string := Pack_SLV_To_Vhpi_String(bar_ret_val_x_x);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
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
      obj_ref := Pack_String_To_VHPI_String("foo req");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      foo_start <= To_Std_Logic(val_string);
      obj_ref := Pack_String_To_Vhpi_String("foo 0");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      foo_a <= Unpack_String(val_string,32);
      obj_ref := Pack_String_To_Vhpi_String("foo ack");
      val_string := To_String(foo_fin);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
      obj_ref := Pack_String_To_Vhpi_String("foo 0");
      val_string := Pack_SLV_To_Vhpi_String(foo_ret_val_x_x);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
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
      obj_ref := Pack_String_To_Vhpi_String("inpipe req");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      inpipe_pipe_write_req <= Unpack_String(val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("inpipe 0");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      inpipe_pipe_write_data <= Unpack_String(val_string,32);
      obj_ref := Pack_String_To_Vhpi_String("inpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(inpipe_pipe_write_ack);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
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
      obj_ref := Pack_String_To_Vhpi_String("outpipe req");
      Modelsim_FLI_Get_Port_Value(obj_ref,val_string);
      outpipe_pipe_read_req <= Unpack_String(val_string,1);
      obj_ref := Pack_String_To_Vhpi_String("outpipe 0");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_data);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
      obj_ref := Pack_String_To_Vhpi_String("outpipe ack");
      val_string := Pack_SLV_To_Vhpi_String(outpipe_pipe_read_ack);
      Modelsim_FLI_Set_Port_Value(obj_ref,val_string);
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
