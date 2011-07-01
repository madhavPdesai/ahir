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
entity output_port_lookup is -- 
  port ( -- 
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    fin   : out std_logic;
    in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
    in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
    in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
    in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
    out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
    out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
    out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
    out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
    tag_in: in std_logic_vector(0 downto 0);
    tag_out: out std_logic_vector(0 downto 0)-- 
  );
  -- 
end entity output_port_lookup;
architecture Default of output_port_lookup is -- 
  -- always true...
  signal always_true_symbol: Boolean;
  -- output port buffer signals
  -- links between control-path and data-path
  signal ptr_deref_46_gather_scatter_req_0 : boolean;
  signal ptr_deref_46_gather_scatter_ack_0 : boolean;
  signal ptr_deref_46_store_0_req_0 : boolean;
  signal ptr_deref_46_store_0_ack_0 : boolean;
  signal ptr_deref_46_store_0_req_1 : boolean;
  signal ptr_deref_46_store_0_ack_1 : boolean;
  signal simple_obj_ref_53_inst_req_0 : boolean;
  signal simple_obj_ref_53_inst_ack_0 : boolean;
  signal ptr_deref_56_gather_scatter_req_0 : boolean;
  signal ptr_deref_56_gather_scatter_ack_0 : boolean;
  signal ptr_deref_56_store_0_req_0 : boolean;
  signal ptr_deref_56_store_0_ack_0 : boolean;
  signal ptr_deref_56_store_0_req_1 : boolean;
  signal ptr_deref_56_store_0_ack_1 : boolean;
  signal simple_obj_ref_60_inst_req_0 : boolean;
  signal simple_obj_ref_60_inst_ack_0 : boolean;
  signal ptr_deref_63_gather_scatter_req_0 : boolean;
  signal ptr_deref_63_gather_scatter_ack_0 : boolean;
  signal ptr_deref_63_store_0_req_0 : boolean;
  signal ptr_deref_63_store_0_ack_0 : boolean;
  signal ptr_deref_63_store_0_req_1 : boolean;
  signal ptr_deref_63_store_0_ack_1 : boolean;
  signal ptr_deref_68_load_0_req_0 : boolean;
  signal ptr_deref_68_load_0_ack_0 : boolean;
  signal ptr_deref_68_load_0_req_1 : boolean;
  signal ptr_deref_68_load_0_ack_1 : boolean;
  signal ptr_deref_68_gather_scatter_req_0 : boolean;
  signal ptr_deref_68_gather_scatter_ack_0 : boolean;
  signal ptr_deref_126_load_0_req_1 : boolean;
  signal ptr_deref_126_load_0_ack_1 : boolean;
  signal ptr_deref_126_gather_scatter_req_0 : boolean;
  signal ptr_deref_126_gather_scatter_ack_0 : boolean;
  signal type_cast_73_inst_req_0 : boolean;
  signal type_cast_73_inst_ack_0 : boolean;
  signal binary_79_inst_req_0 : boolean;
  signal binary_79_inst_ack_0 : boolean;
  signal binary_79_inst_req_1 : boolean;
  signal binary_79_inst_ack_1 : boolean;
  signal if_stmt_82_branch_req_0 : boolean;
  signal if_stmt_82_branch_ack_1 : boolean;
  signal if_stmt_82_branch_ack_0 : boolean;
  signal ptr_deref_91_load_0_req_0 : boolean;
  signal ptr_deref_91_load_0_ack_0 : boolean;
  signal ptr_deref_91_load_0_req_1 : boolean;
  signal ptr_deref_91_load_0_ack_1 : boolean;
  signal ptr_deref_91_gather_scatter_req_0 : boolean;
  signal ptr_deref_91_gather_scatter_ack_0 : boolean;
  signal type_cast_95_inst_req_0 : boolean;
  signal type_cast_95_inst_ack_0 : boolean;
  signal binary_101_inst_req_0 : boolean;
  signal binary_101_inst_ack_0 : boolean;
  signal binary_101_inst_req_1 : boolean;
  signal binary_101_inst_ack_1 : boolean;
  signal if_stmt_103_branch_req_0 : boolean;
  signal if_stmt_103_branch_ack_1 : boolean;
  signal if_stmt_103_branch_ack_0 : boolean;
  signal ptr_deref_112_load_0_req_0 : boolean;
  signal ptr_deref_112_load_0_ack_0 : boolean;
  signal ptr_deref_112_load_0_req_1 : boolean;
  signal ptr_deref_112_load_0_ack_1 : boolean;
  signal ptr_deref_112_gather_scatter_req_0 : boolean;
  signal ptr_deref_112_gather_scatter_ack_0 : boolean;
  signal binary_118_inst_req_0 : boolean;
  signal binary_118_inst_ack_0 : boolean;
  signal binary_118_inst_req_1 : boolean;
  signal binary_118_inst_ack_1 : boolean;
  signal ptr_deref_121_gather_scatter_req_0 : boolean;
  signal ptr_deref_121_gather_scatter_ack_0 : boolean;
  signal ptr_deref_121_store_0_req_0 : boolean;
  signal ptr_deref_121_store_0_ack_0 : boolean;
  signal ptr_deref_121_store_0_req_1 : boolean;
  signal ptr_deref_121_store_0_ack_1 : boolean;
  signal ptr_deref_126_load_0_req_0 : boolean;
  signal ptr_deref_126_load_0_ack_0 : boolean;
  signal ptr_deref_232_load_0_req_0 : boolean;
  signal ptr_deref_232_load_0_ack_0 : boolean;
  signal ptr_deref_232_load_0_req_1 : boolean;
  signal ptr_deref_232_load_0_ack_1 : boolean;
  signal ptr_deref_232_gather_scatter_req_0 : boolean;
  signal ptr_deref_232_gather_scatter_ack_0 : boolean;
  signal binary_132_inst_req_0 : boolean;
  signal binary_132_inst_ack_0 : boolean;
  signal binary_132_inst_req_1 : boolean;
  signal binary_132_inst_ack_1 : boolean;
  signal type_cast_136_inst_req_0 : boolean;
  signal type_cast_136_inst_ack_0 : boolean;
  signal ptr_deref_139_gather_scatter_req_0 : boolean;
  signal ptr_deref_139_gather_scatter_ack_0 : boolean;
  signal ptr_deref_139_store_0_req_0 : boolean;
  signal ptr_deref_139_store_0_ack_0 : boolean;
  signal ptr_deref_139_store_0_req_1 : boolean;
  signal ptr_deref_139_store_0_ack_1 : boolean;
  signal ptr_deref_144_load_0_req_0 : boolean;
  signal ptr_deref_144_load_0_ack_0 : boolean;
  signal ptr_deref_144_load_0_req_1 : boolean;
  signal ptr_deref_144_load_0_ack_1 : boolean;
  signal ptr_deref_144_gather_scatter_req_0 : boolean;
  signal ptr_deref_144_gather_scatter_ack_0 : boolean;
  signal type_cast_149_inst_req_0 : boolean;
  signal type_cast_149_inst_ack_0 : boolean;
  signal binary_153_inst_req_0 : boolean;
  signal binary_153_inst_ack_0 : boolean;
  signal binary_153_inst_req_1 : boolean;
  signal binary_153_inst_ack_1 : boolean;
  signal ptr_deref_157_load_0_req_0 : boolean;
  signal ptr_deref_157_load_0_ack_0 : boolean;
  signal ptr_deref_157_load_0_req_1 : boolean;
  signal ptr_deref_157_load_0_ack_1 : boolean;
  signal ptr_deref_157_gather_scatter_req_0 : boolean;
  signal ptr_deref_157_gather_scatter_ack_0 : boolean;
  signal type_cast_161_inst_req_0 : boolean;
  signal type_cast_161_inst_ack_0 : boolean;
  signal type_cast_166_inst_req_0 : boolean;
  signal type_cast_166_inst_ack_0 : boolean;
  signal binary_170_inst_req_0 : boolean;
  signal binary_170_inst_ack_0 : boolean;
  signal binary_170_inst_req_1 : boolean;
  signal binary_170_inst_ack_1 : boolean;
  signal type_cast_171_inst_req_0 : boolean;
  signal type_cast_171_inst_ack_0 : boolean;
  signal binary_177_inst_req_0 : boolean;
  signal binary_177_inst_ack_0 : boolean;
  signal binary_177_inst_req_1 : boolean;
  signal binary_177_inst_ack_1 : boolean;
  signal ternary_183_inst_req_0 : boolean;
  signal ternary_183_inst_ack_0 : boolean;
  signal type_cast_187_inst_req_0 : boolean;
  signal type_cast_187_inst_ack_0 : boolean;
  signal type_cast_187_inst_req_1 : boolean;
  signal type_cast_187_inst_ack_1 : boolean;
  signal type_cast_188_inst_req_0 : boolean;
  signal type_cast_188_inst_ack_0 : boolean;
  signal ptr_deref_191_gather_scatter_req_0 : boolean;
  signal ptr_deref_191_gather_scatter_ack_0 : boolean;
  signal ptr_deref_191_store_0_req_0 : boolean;
  signal ptr_deref_191_store_0_ack_0 : boolean;
  signal ptr_deref_191_store_0_req_1 : boolean;
  signal ptr_deref_191_store_0_ack_1 : boolean;
  signal ptr_deref_196_load_0_req_0 : boolean;
  signal ptr_deref_196_load_0_ack_0 : boolean;
  signal ptr_deref_196_load_0_req_1 : boolean;
  signal ptr_deref_196_load_0_ack_1 : boolean;
  signal ptr_deref_196_gather_scatter_req_0 : boolean;
  signal ptr_deref_196_gather_scatter_ack_0 : boolean;
  signal binary_202_inst_req_0 : boolean;
  signal binary_202_inst_ack_0 : boolean;
  signal binary_202_inst_req_1 : boolean;
  signal binary_202_inst_ack_1 : boolean;
  signal ptr_deref_206_load_0_req_0 : boolean;
  signal ptr_deref_206_load_0_ack_0 : boolean;
  signal ptr_deref_206_load_0_req_1 : boolean;
  signal ptr_deref_206_load_0_ack_1 : boolean;
  signal ptr_deref_206_gather_scatter_req_0 : boolean;
  signal ptr_deref_206_gather_scatter_ack_0 : boolean;
  signal binary_212_inst_req_0 : boolean;
  signal binary_212_inst_ack_0 : boolean;
  signal binary_212_inst_req_1 : boolean;
  signal binary_212_inst_ack_1 : boolean;
  signal binary_217_inst_req_0 : boolean;
  signal binary_217_inst_ack_0 : boolean;
  signal binary_217_inst_req_1 : boolean;
  signal binary_217_inst_ack_1 : boolean;
  signal ptr_deref_220_gather_scatter_req_0 : boolean;
  signal ptr_deref_220_gather_scatter_ack_0 : boolean;
  signal ptr_deref_220_store_0_req_0 : boolean;
  signal ptr_deref_220_store_0_ack_0 : boolean;
  signal ptr_deref_220_store_0_req_1 : boolean;
  signal ptr_deref_220_store_0_ack_1 : boolean;
  signal ptr_deref_224_gather_scatter_req_0 : boolean;
  signal ptr_deref_224_gather_scatter_ack_0 : boolean;
  signal ptr_deref_224_store_0_req_0 : boolean;
  signal ptr_deref_224_store_0_ack_0 : boolean;
  signal ptr_deref_224_store_0_req_1 : boolean;
  signal ptr_deref_224_store_0_ack_1 : boolean;
  signal type_cast_236_inst_req_0 : boolean;
  signal type_cast_236_inst_ack_0 : boolean;
  signal type_cast_240_inst_req_0 : boolean;
  signal type_cast_240_inst_ack_0 : boolean;
  signal binary_244_inst_req_0 : boolean;
  signal binary_244_inst_ack_0 : boolean;
  signal binary_244_inst_req_1 : boolean;
  signal binary_244_inst_ack_1 : boolean;
  signal if_stmt_246_branch_req_0 : boolean;
  signal if_stmt_246_branch_ack_1 : boolean;
  signal if_stmt_246_branch_ack_0 : boolean;
  signal ptr_deref_254_gather_scatter_req_0 : boolean;
  signal ptr_deref_254_gather_scatter_ack_0 : boolean;
  signal ptr_deref_254_store_0_req_0 : boolean;
  signal ptr_deref_254_store_0_ack_0 : boolean;
  signal ptr_deref_254_store_0_req_1 : boolean;
  signal ptr_deref_254_store_0_ack_1 : boolean;
  signal ptr_deref_262_load_0_req_0 : boolean;
  signal ptr_deref_262_load_0_ack_0 : boolean;
  signal ptr_deref_262_load_0_req_1 : boolean;
  signal ptr_deref_262_load_0_ack_1 : boolean;
  signal ptr_deref_262_gather_scatter_req_0 : boolean;
  signal ptr_deref_262_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_264_inst_req_0 : boolean;
  signal simple_obj_ref_264_inst_ack_0 : boolean;
  signal ptr_deref_269_load_0_req_0 : boolean;
  signal ptr_deref_269_load_0_ack_0 : boolean;
  signal ptr_deref_269_load_0_req_1 : boolean;
  signal ptr_deref_269_load_0_ack_1 : boolean;
  signal ptr_deref_269_gather_scatter_req_0 : boolean;
  signal ptr_deref_269_gather_scatter_ack_0 : boolean;
  signal simple_obj_ref_271_inst_req_0 : boolean;
  signal simple_obj_ref_271_inst_ack_0 : boolean;
  signal memory_space_4_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_4_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_4_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_4_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_4_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_4_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_4_lc_data : std_logic_vector(7 downto 0);
  signal memory_space_4_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_4_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_4_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_4_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_4_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_4_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_4_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_4_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_4_sc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_5_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_5_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_5_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_5_lr_tag : std_logic_vector(1 downto 0);
  signal memory_space_5_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_5_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_5_lc_data : std_logic_vector(7 downto 0);
  signal memory_space_5_lc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_5_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_5_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_5_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_5_sr_data : std_logic_vector(7 downto 0);
  signal memory_space_5_sr_tag : std_logic_vector(1 downto 0);
  signal memory_space_5_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_5_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_5_sc_tag :  std_logic_vector(1 downto 0);
  signal memory_space_6_lr_req :  std_logic_vector(2 downto 0);
  signal memory_space_6_lr_ack : std_logic_vector(2 downto 0);
  signal memory_space_6_lr_addr : std_logic_vector(2 downto 0);
  signal memory_space_6_lr_tag : std_logic_vector(5 downto 0);
  signal memory_space_6_lc_req : std_logic_vector(2 downto 0);
  signal memory_space_6_lc_ack :  std_logic_vector(2 downto 0);
  signal memory_space_6_lc_data : std_logic_vector(191 downto 0);
  signal memory_space_6_lc_tag :  std_logic_vector(5 downto 0);
  signal memory_space_6_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_6_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_6_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_6_sr_data : std_logic_vector(63 downto 0);
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
  signal memory_space_7_lc_data : std_logic_vector(63 downto 0);
  signal memory_space_7_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_7_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_7_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_7_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_7_sr_data : std_logic_vector(63 downto 0);
  signal memory_space_7_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_7_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_7_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_7_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_8_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_8_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_8_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_8_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_8_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_8_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_8_lc_data : std_logic_vector(15 downto 0);
  signal memory_space_8_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_8_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_8_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_8_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_8_sr_data : std_logic_vector(15 downto 0);
  signal memory_space_8_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_8_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_8_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_8_sc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_9_lr_req :  std_logic_vector(0 downto 0);
  signal memory_space_9_lr_ack : std_logic_vector(0 downto 0);
  signal memory_space_9_lr_addr : std_logic_vector(0 downto 0);
  signal memory_space_9_lr_tag : std_logic_vector(0 downto 0);
  signal memory_space_9_lc_req : std_logic_vector(0 downto 0);
  signal memory_space_9_lc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_9_lc_data : std_logic_vector(63 downto 0);
  signal memory_space_9_lc_tag :  std_logic_vector(0 downto 0);
  signal memory_space_9_sr_req :  std_logic_vector(0 downto 0);
  signal memory_space_9_sr_ack : std_logic_vector(0 downto 0);
  signal memory_space_9_sr_addr : std_logic_vector(0 downto 0);
  signal memory_space_9_sr_data : std_logic_vector(63 downto 0);
  signal memory_space_9_sr_tag : std_logic_vector(0 downto 0);
  signal memory_space_9_sc_req : std_logic_vector(0 downto 0);
  signal memory_space_9_sc_ack :  std_logic_vector(0 downto 0);
  signal memory_space_9_sc_tag :  std_logic_vector(0 downto 0);
  -- 
begin --  
  -- output port buffering assignments
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
  output_port_lookup_CP_0: Block -- control-path 
    signal output_port_lookup_CP_0_start: Boolean;
    signal Xentry_1_symbol: Boolean;
    signal Xexit_2_symbol: Boolean;
    signal branch_block_stmt_13_3_symbol : Boolean;
    -- 
  begin -- 
    output_port_lookup_CP_0_start <=  true when start = '1' else false; -- control passed to control-path.
    Xentry_1_symbol  <= output_port_lookup_CP_0_start; -- transition $entry
    branch_block_stmt_13_3: Block -- branch_block_stmt_13 
      signal branch_block_stmt_13_3_start: Boolean;
      signal Xentry_4_symbol: Boolean;
      signal Xexit_5_symbol: Boolean;
      signal branch_block_stmt_13_x_xentry_x_xx_x6_symbol : Boolean;
      signal branch_block_stmt_13_x_xexit_x_xx_x7_symbol : Boolean;
      signal assign_stmt_24_to_assign_stmt_49_x_xentry_x_xx_x8_symbol : Boolean;
      signal assign_stmt_24_to_assign_stmt_49_x_xexit_x_xx_x9_symbol : Boolean;
      signal bb_0_bb_1_10_symbol : Boolean;
      signal merge_stmt_51_x_xexit_x_xx_x11_symbol : Boolean;
      signal assign_stmt_54_x_xentry_x_xx_x12_symbol : Boolean;
      signal assign_stmt_54_x_xexit_x_xx_x13_symbol : Boolean;
      signal assign_stmt_58_x_xentry_x_xx_x14_symbol : Boolean;
      signal assign_stmt_58_x_xexit_x_xx_x15_symbol : Boolean;
      signal assign_stmt_61_x_xentry_x_xx_x16_symbol : Boolean;
      signal assign_stmt_61_x_xexit_x_xx_x17_symbol : Boolean;
      signal assign_stmt_65_to_assign_stmt_81_x_xentry_x_xx_x18_symbol : Boolean;
      signal assign_stmt_65_to_assign_stmt_81_x_xexit_x_xx_x19_symbol : Boolean;
      signal if_stmt_82_x_xentry_x_xx_x20_symbol : Boolean;
      signal if_stmt_82_x_xexit_x_xx_x21_symbol : Boolean;
      signal merge_stmt_88_x_xentry_x_xx_x22_symbol : Boolean;
      signal merge_stmt_88_x_xexit_x_xx_x23_symbol : Boolean;
      signal assign_stmt_92_to_assign_stmt_102_x_xentry_x_xx_x24_symbol : Boolean;
      signal assign_stmt_92_to_assign_stmt_102_x_xexit_x_xx_x25_symbol : Boolean;
      signal if_stmt_103_x_xentry_x_xx_x26_symbol : Boolean;
      signal if_stmt_103_x_xexit_x_xx_x27_symbol : Boolean;
      signal merge_stmt_109_x_xentry_x_xx_x28_symbol : Boolean;
      signal merge_stmt_109_x_xexit_x_xx_x29_symbol : Boolean;
      signal assign_stmt_113_to_assign_stmt_227_x_xentry_x_xx_x30_symbol : Boolean;
      signal assign_stmt_113_to_assign_stmt_227_x_xexit_x_xx_x31_symbol : Boolean;
      signal bb_3_bb_6_32_symbol : Boolean;
      signal merge_stmt_229_x_xexit_x_xx_x33_symbol : Boolean;
      signal assign_stmt_233_to_assign_stmt_245_x_xentry_x_xx_x34_symbol : Boolean;
      signal assign_stmt_233_to_assign_stmt_245_x_xexit_x_xx_x35_symbol : Boolean;
      signal if_stmt_246_x_xentry_x_xx_x36_symbol : Boolean;
      signal if_stmt_246_x_xexit_x_xx_x37_symbol : Boolean;
      signal merge_stmt_252_x_xentry_x_xx_x38_symbol : Boolean;
      signal merge_stmt_252_x_xexit_x_xx_x39_symbol : Boolean;
      signal assign_stmt_257_x_xentry_x_xx_x40_symbol : Boolean;
      signal assign_stmt_257_x_xexit_x_xx_x41_symbol : Boolean;
      signal bb_5_bb_6_42_symbol : Boolean;
      signal merge_stmt_259_x_xexit_x_xx_x43_symbol : Boolean;
      signal assign_stmt_263_x_xentry_x_xx_x44_symbol : Boolean;
      signal assign_stmt_263_x_xexit_x_xx_x45_symbol : Boolean;
      signal assign_stmt_266_x_xentry_x_xx_x46_symbol : Boolean;
      signal assign_stmt_266_x_xexit_x_xx_x47_symbol : Boolean;
      signal assign_stmt_270_x_xentry_x_xx_x48_symbol : Boolean;
      signal assign_stmt_270_x_xexit_x_xx_x49_symbol : Boolean;
      signal assign_stmt_273_x_xentry_x_xx_x50_symbol : Boolean;
      signal assign_stmt_273_x_xexit_x_xx_x51_symbol : Boolean;
      signal bb_6_bb_1_52_symbol : Boolean;
      signal assign_stmt_24_to_assign_stmt_49_53_symbol : Boolean;
      signal assign_stmt_54_87_symbol : Boolean;
      signal assign_stmt_58_98_symbol : Boolean;
      signal assign_stmt_61_133_symbol : Boolean;
      signal assign_stmt_65_to_assign_stmt_81_144_symbol : Boolean;
      signal if_stmt_82_dead_link_232_symbol : Boolean;
      signal if_stmt_82_eval_test_236_symbol : Boolean;
      signal simple_obj_ref_83_place_240_symbol : Boolean;
      signal if_stmt_82_if_link_241_symbol : Boolean;
      signal if_stmt_82_else_link_245_symbol : Boolean;
      signal bb_1_bb_2_249_symbol : Boolean;
      signal bb_1_bb_4_250_symbol : Boolean;
      signal assign_stmt_92_to_assign_stmt_102_251_symbol : Boolean;
      signal if_stmt_103_dead_link_307_symbol : Boolean;
      signal if_stmt_103_eval_test_311_symbol : Boolean;
      signal simple_obj_ref_104_place_315_symbol : Boolean;
      signal if_stmt_103_if_link_316_symbol : Boolean;
      signal if_stmt_103_else_link_320_symbol : Boolean;
      signal bb_2_bb_3_324_symbol : Boolean;
      signal bb_2_bb_4_325_symbol : Boolean;
      signal assign_stmt_113_to_assign_stmt_227_326_symbol : Boolean;
      signal assign_stmt_233_to_assign_stmt_245_843_symbol : Boolean;
      signal if_stmt_246_dead_link_906_symbol : Boolean;
      signal if_stmt_246_eval_test_910_symbol : Boolean;
      signal simple_obj_ref_247_place_914_symbol : Boolean;
      signal if_stmt_246_if_link_915_symbol : Boolean;
      signal if_stmt_246_else_link_919_symbol : Boolean;
      signal bb_4_bb_5_923_symbol : Boolean;
      signal bb_4_bb_6_924_symbol : Boolean;
      signal assign_stmt_257_925_symbol : Boolean;
      signal assign_stmt_263_959_symbol : Boolean;
      signal assign_stmt_266_993_symbol : Boolean;
      signal assign_stmt_270_1005_symbol : Boolean;
      signal assign_stmt_273_1039_symbol : Boolean;
      signal bb_0_bb_1_PhiReq_1051_symbol : Boolean;
      signal bb_6_bb_1_PhiReq_1054_symbol : Boolean;
      signal merge_stmt_51_PhiReqMerge_1057_symbol : Boolean;
      signal merge_stmt_51_PhiAck_1058_symbol : Boolean;
      signal merge_stmt_88_dead_link_1062_symbol : Boolean;
      signal bb_1_bb_2_PhiReq_1066_symbol : Boolean;
      signal merge_stmt_88_PhiReqMerge_1069_symbol : Boolean;
      signal merge_stmt_88_PhiAck_1070_symbol : Boolean;
      signal merge_stmt_109_dead_link_1074_symbol : Boolean;
      signal bb_2_bb_3_PhiReq_1078_symbol : Boolean;
      signal merge_stmt_109_PhiReqMerge_1081_symbol : Boolean;
      signal merge_stmt_109_PhiAck_1082_symbol : Boolean;
      signal bb_1_bb_4_PhiReq_1086_symbol : Boolean;
      signal bb_2_bb_4_PhiReq_1089_symbol : Boolean;
      signal merge_stmt_229_PhiReqMerge_1092_symbol : Boolean;
      signal merge_stmt_229_PhiAck_1093_symbol : Boolean;
      signal merge_stmt_252_dead_link_1097_symbol : Boolean;
      signal bb_4_bb_5_PhiReq_1101_symbol : Boolean;
      signal merge_stmt_252_PhiReqMerge_1104_symbol : Boolean;
      signal merge_stmt_252_PhiAck_1105_symbol : Boolean;
      signal bb_3_bb_6_PhiReq_1109_symbol : Boolean;
      signal bb_4_bb_6_PhiReq_1112_symbol : Boolean;
      signal bb_5_bb_6_PhiReq_1115_symbol : Boolean;
      signal merge_stmt_259_PhiReqMerge_1118_symbol : Boolean;
      signal merge_stmt_259_PhiAck_1119_symbol : Boolean;
      -- 
    begin -- 
      branch_block_stmt_13_3_start <= Xentry_1_symbol; -- control passed to block
      Xentry_4_symbol  <= branch_block_stmt_13_3_start; -- transition branch_block_stmt_13/$entry
      branch_block_stmt_13_x_xentry_x_xx_x6_symbol  <=  Xentry_4_symbol; -- place branch_block_stmt_13/branch_block_stmt_13__entry__ (optimized away) 
      branch_block_stmt_13_x_xexit_x_xx_x7_symbol  <=   false ; -- place branch_block_stmt_13/branch_block_stmt_13__exit__ (optimized away) 
      assign_stmt_24_to_assign_stmt_49_x_xentry_x_xx_x8_symbol  <=  branch_block_stmt_13_x_xentry_x_xx_x6_symbol; -- place branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49__entry__ (optimized away) 
      assign_stmt_24_to_assign_stmt_49_x_xexit_x_xx_x9_symbol  <=  assign_stmt_24_to_assign_stmt_49_53_symbol; -- place branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49__exit__ (optimized away) 
      bb_0_bb_1_10_symbol  <=  assign_stmt_24_to_assign_stmt_49_x_xexit_x_xx_x9_symbol; -- place branch_block_stmt_13/bb_0_bb_1 (optimized away) 
      merge_stmt_51_x_xexit_x_xx_x11_symbol  <=  merge_stmt_51_PhiAck_1058_symbol; -- place branch_block_stmt_13/merge_stmt_51__exit__ (optimized away) 
      assign_stmt_54_x_xentry_x_xx_x12_symbol  <=  merge_stmt_51_x_xexit_x_xx_x11_symbol; -- place branch_block_stmt_13/assign_stmt_54__entry__ (optimized away) 
      assign_stmt_54_x_xexit_x_xx_x13_symbol  <=  assign_stmt_54_87_symbol; -- place branch_block_stmt_13/assign_stmt_54__exit__ (optimized away) 
      assign_stmt_58_x_xentry_x_xx_x14_symbol  <=  assign_stmt_54_x_xexit_x_xx_x13_symbol; -- place branch_block_stmt_13/assign_stmt_58__entry__ (optimized away) 
      assign_stmt_58_x_xexit_x_xx_x15_symbol  <=  assign_stmt_58_98_symbol; -- place branch_block_stmt_13/assign_stmt_58__exit__ (optimized away) 
      assign_stmt_61_x_xentry_x_xx_x16_symbol  <=  assign_stmt_58_x_xexit_x_xx_x15_symbol; -- place branch_block_stmt_13/assign_stmt_61__entry__ (optimized away) 
      assign_stmt_61_x_xexit_x_xx_x17_symbol  <=  assign_stmt_61_133_symbol; -- place branch_block_stmt_13/assign_stmt_61__exit__ (optimized away) 
      assign_stmt_65_to_assign_stmt_81_x_xentry_x_xx_x18_symbol  <=  assign_stmt_61_x_xexit_x_xx_x17_symbol; -- place branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81__entry__ (optimized away) 
      assign_stmt_65_to_assign_stmt_81_x_xexit_x_xx_x19_symbol  <=  assign_stmt_65_to_assign_stmt_81_144_symbol; -- place branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81__exit__ (optimized away) 
      if_stmt_82_x_xentry_x_xx_x20_symbol  <=  assign_stmt_65_to_assign_stmt_81_x_xexit_x_xx_x19_symbol; -- place branch_block_stmt_13/if_stmt_82__entry__ (optimized away) 
      if_stmt_82_x_xexit_x_xx_x21_symbol  <=  if_stmt_82_dead_link_232_symbol; -- place branch_block_stmt_13/if_stmt_82__exit__ (optimized away) 
      merge_stmt_88_x_xentry_x_xx_x22_symbol  <=  if_stmt_82_x_xexit_x_xx_x21_symbol; -- place branch_block_stmt_13/merge_stmt_88__entry__ (optimized away) 
      merge_stmt_88_x_xexit_x_xx_x23_symbol  <=  merge_stmt_88_dead_link_1062_symbol or merge_stmt_88_PhiAck_1070_symbol; -- place branch_block_stmt_13/merge_stmt_88__exit__ (optimized away) 
      assign_stmt_92_to_assign_stmt_102_x_xentry_x_xx_x24_symbol  <=  merge_stmt_88_x_xexit_x_xx_x23_symbol; -- place branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102__entry__ (optimized away) 
      assign_stmt_92_to_assign_stmt_102_x_xexit_x_xx_x25_symbol  <=  assign_stmt_92_to_assign_stmt_102_251_symbol; -- place branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102__exit__ (optimized away) 
      if_stmt_103_x_xentry_x_xx_x26_symbol  <=  assign_stmt_92_to_assign_stmt_102_x_xexit_x_xx_x25_symbol; -- place branch_block_stmt_13/if_stmt_103__entry__ (optimized away) 
      if_stmt_103_x_xexit_x_xx_x27_symbol  <=  if_stmt_103_dead_link_307_symbol; -- place branch_block_stmt_13/if_stmt_103__exit__ (optimized away) 
      merge_stmt_109_x_xentry_x_xx_x28_symbol  <=  if_stmt_103_x_xexit_x_xx_x27_symbol; -- place branch_block_stmt_13/merge_stmt_109__entry__ (optimized away) 
      merge_stmt_109_x_xexit_x_xx_x29_symbol  <=  merge_stmt_109_dead_link_1074_symbol or merge_stmt_109_PhiAck_1082_symbol; -- place branch_block_stmt_13/merge_stmt_109__exit__ (optimized away) 
      assign_stmt_113_to_assign_stmt_227_x_xentry_x_xx_x30_symbol  <=  merge_stmt_109_x_xexit_x_xx_x29_symbol; -- place branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227__entry__ (optimized away) 
      assign_stmt_113_to_assign_stmt_227_x_xexit_x_xx_x31_symbol  <=  assign_stmt_113_to_assign_stmt_227_326_symbol; -- place branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227__exit__ (optimized away) 
      bb_3_bb_6_32_symbol  <=  assign_stmt_113_to_assign_stmt_227_x_xexit_x_xx_x31_symbol; -- place branch_block_stmt_13/bb_3_bb_6 (optimized away) 
      merge_stmt_229_x_xexit_x_xx_x33_symbol  <=  merge_stmt_229_PhiAck_1093_symbol; -- place branch_block_stmt_13/merge_stmt_229__exit__ (optimized away) 
      assign_stmt_233_to_assign_stmt_245_x_xentry_x_xx_x34_symbol  <=  merge_stmt_229_x_xexit_x_xx_x33_symbol; -- place branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245__entry__ (optimized away) 
      assign_stmt_233_to_assign_stmt_245_x_xexit_x_xx_x35_symbol  <=  assign_stmt_233_to_assign_stmt_245_843_symbol; -- place branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245__exit__ (optimized away) 
      if_stmt_246_x_xentry_x_xx_x36_symbol  <=  assign_stmt_233_to_assign_stmt_245_x_xexit_x_xx_x35_symbol; -- place branch_block_stmt_13/if_stmt_246__entry__ (optimized away) 
      if_stmt_246_x_xexit_x_xx_x37_symbol  <=  if_stmt_246_dead_link_906_symbol; -- place branch_block_stmt_13/if_stmt_246__exit__ (optimized away) 
      merge_stmt_252_x_xentry_x_xx_x38_symbol  <=  if_stmt_246_x_xexit_x_xx_x37_symbol; -- place branch_block_stmt_13/merge_stmt_252__entry__ (optimized away) 
      merge_stmt_252_x_xexit_x_xx_x39_symbol  <=  merge_stmt_252_dead_link_1097_symbol or merge_stmt_252_PhiAck_1105_symbol; -- place branch_block_stmt_13/merge_stmt_252__exit__ (optimized away) 
      assign_stmt_257_x_xentry_x_xx_x40_symbol  <=  merge_stmt_252_x_xexit_x_xx_x39_symbol; -- place branch_block_stmt_13/assign_stmt_257__entry__ (optimized away) 
      assign_stmt_257_x_xexit_x_xx_x41_symbol  <=  assign_stmt_257_925_symbol; -- place branch_block_stmt_13/assign_stmt_257__exit__ (optimized away) 
      bb_5_bb_6_42_symbol  <=  assign_stmt_257_x_xexit_x_xx_x41_symbol; -- place branch_block_stmt_13/bb_5_bb_6 (optimized away) 
      merge_stmt_259_x_xexit_x_xx_x43_symbol  <=  merge_stmt_259_PhiAck_1119_symbol; -- place branch_block_stmt_13/merge_stmt_259__exit__ (optimized away) 
      assign_stmt_263_x_xentry_x_xx_x44_symbol  <=  merge_stmt_259_x_xexit_x_xx_x43_symbol; -- place branch_block_stmt_13/assign_stmt_263__entry__ (optimized away) 
      assign_stmt_263_x_xexit_x_xx_x45_symbol  <=  assign_stmt_263_959_symbol; -- place branch_block_stmt_13/assign_stmt_263__exit__ (optimized away) 
      assign_stmt_266_x_xentry_x_xx_x46_symbol  <=  assign_stmt_263_x_xexit_x_xx_x45_symbol; -- place branch_block_stmt_13/assign_stmt_266__entry__ (optimized away) 
      assign_stmt_266_x_xexit_x_xx_x47_symbol  <=  assign_stmt_266_993_symbol; -- place branch_block_stmt_13/assign_stmt_266__exit__ (optimized away) 
      assign_stmt_270_x_xentry_x_xx_x48_symbol  <=  assign_stmt_266_x_xexit_x_xx_x47_symbol; -- place branch_block_stmt_13/assign_stmt_270__entry__ (optimized away) 
      assign_stmt_270_x_xexit_x_xx_x49_symbol  <=  assign_stmt_270_1005_symbol; -- place branch_block_stmt_13/assign_stmt_270__exit__ (optimized away) 
      assign_stmt_273_x_xentry_x_xx_x50_symbol  <=  assign_stmt_270_x_xexit_x_xx_x49_symbol; -- place branch_block_stmt_13/assign_stmt_273__entry__ (optimized away) 
      assign_stmt_273_x_xexit_x_xx_x51_symbol  <=  assign_stmt_273_1039_symbol; -- place branch_block_stmt_13/assign_stmt_273__exit__ (optimized away) 
      bb_6_bb_1_52_symbol  <=  assign_stmt_273_x_xexit_x_xx_x51_symbol; -- place branch_block_stmt_13/bb_6_bb_1 (optimized away) 
      assign_stmt_24_to_assign_stmt_49_53: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49 
        signal assign_stmt_24_to_assign_stmt_49_53_start: Boolean;
        signal Xentry_54_symbol: Boolean;
        signal Xexit_55_symbol: Boolean;
        signal assign_stmt_49_active_x_x56_symbol : Boolean;
        signal assign_stmt_49_completed_x_x57_symbol : Boolean;
        signal ptr_deref_46_trigger_x_x58_symbol : Boolean;
        signal ptr_deref_46_active_x_x59_symbol : Boolean;
        signal ptr_deref_46_base_address_calculated_60_symbol : Boolean;
        signal ptr_deref_46_root_address_calculated_61_symbol : Boolean;
        signal ptr_deref_46_word_address_calculated_62_symbol : Boolean;
        signal ptr_deref_46_request_63_symbol : Boolean;
        signal ptr_deref_46_complete_76_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_24_to_assign_stmt_49_53_start <= assign_stmt_24_to_assign_stmt_49_x_xentry_x_xx_x8_symbol; -- control passed to block
        Xentry_54_symbol  <= assign_stmt_24_to_assign_stmt_49_53_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/$entry
        assign_stmt_49_active_x_x56_symbol <= Xentry_54_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/assign_stmt_49_active_
        assign_stmt_49_completed_x_x57_symbol <= ptr_deref_46_complete_76_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/assign_stmt_49_completed_
        ptr_deref_46_trigger_x_x58_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_trigger_ 
          signal ptr_deref_46_trigger_x_x58_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_46_trigger_x_x58_predecessors(0) <= ptr_deref_46_word_address_calculated_62_symbol;
          ptr_deref_46_trigger_x_x58_predecessors(1) <= assign_stmt_49_active_x_x56_symbol;
          ptr_deref_46_trigger_x_x58_join: join -- 
            port map( -- 
              preds => ptr_deref_46_trigger_x_x58_predecessors,
              symbol_out => ptr_deref_46_trigger_x_x58_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_trigger_
        ptr_deref_46_active_x_x59_symbol <= ptr_deref_46_request_63_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_active_
        ptr_deref_46_base_address_calculated_60_symbol <= Xentry_54_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_base_address_calculated
        ptr_deref_46_root_address_calculated_61_symbol <= Xentry_54_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_root_address_calculated
        ptr_deref_46_word_address_calculated_62_symbol <= ptr_deref_46_root_address_calculated_61_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_word_address_calculated
        ptr_deref_46_request_63: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request 
          signal ptr_deref_46_request_63_start: Boolean;
          signal Xentry_64_symbol: Boolean;
          signal Xexit_65_symbol: Boolean;
          signal split_req_66_symbol : Boolean;
          signal split_ack_67_symbol : Boolean;
          signal word_access_68_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_46_request_63_start <= ptr_deref_46_trigger_x_x58_symbol; -- control passed to block
          Xentry_64_symbol  <= ptr_deref_46_request_63_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/$entry
          split_req_66_symbol <= Xentry_64_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/split_req
          ptr_deref_46_gather_scatter_req_0 <= split_req_66_symbol; -- link to DP
          split_ack_67_symbol <= ptr_deref_46_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/split_ack
          word_access_68: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access 
            signal word_access_68_start: Boolean;
            signal Xentry_69_symbol: Boolean;
            signal Xexit_70_symbol: Boolean;
            signal word_access_0_71_symbol : Boolean;
            -- 
          begin -- 
            word_access_68_start <= split_ack_67_symbol; -- control passed to block
            Xentry_69_symbol  <= word_access_68_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/$entry
            word_access_0_71: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/word_access_0 
              signal word_access_0_71_start: Boolean;
              signal Xentry_72_symbol: Boolean;
              signal Xexit_73_symbol: Boolean;
              signal rr_74_symbol : Boolean;
              signal ra_75_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_71_start <= Xentry_69_symbol; -- control passed to block
              Xentry_72_symbol  <= word_access_0_71_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/word_access_0/$entry
              rr_74_symbol <= Xentry_72_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/word_access_0/rr
              ptr_deref_46_store_0_req_0 <= rr_74_symbol; -- link to DP
              ra_75_symbol <= ptr_deref_46_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/word_access_0/ra
              Xexit_73_symbol <= ra_75_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/word_access_0/$exit
              word_access_0_71_symbol <= Xexit_73_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/word_access_0
            Xexit_70_symbol <= word_access_0_71_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access/$exit
            word_access_68_symbol <= Xexit_70_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/word_access
          Xexit_65_symbol <= word_access_68_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request/$exit
          ptr_deref_46_request_63_symbol <= Xexit_65_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_request
        ptr_deref_46_complete_76: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete 
          signal ptr_deref_46_complete_76_start: Boolean;
          signal Xentry_77_symbol: Boolean;
          signal Xexit_78_symbol: Boolean;
          signal word_access_79_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_46_complete_76_start <= ptr_deref_46_active_x_x59_symbol; -- control passed to block
          Xentry_77_symbol  <= ptr_deref_46_complete_76_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/$entry
          word_access_79: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access 
            signal word_access_79_start: Boolean;
            signal Xentry_80_symbol: Boolean;
            signal Xexit_81_symbol: Boolean;
            signal word_access_0_82_symbol : Boolean;
            -- 
          begin -- 
            word_access_79_start <= Xentry_77_symbol; -- control passed to block
            Xentry_80_symbol  <= word_access_79_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/$entry
            word_access_0_82: Block -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/word_access_0 
              signal word_access_0_82_start: Boolean;
              signal Xentry_83_symbol: Boolean;
              signal Xexit_84_symbol: Boolean;
              signal cr_85_symbol : Boolean;
              signal ca_86_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_82_start <= Xentry_80_symbol; -- control passed to block
              Xentry_83_symbol  <= word_access_0_82_start; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/word_access_0/$entry
              cr_85_symbol <= Xentry_83_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/word_access_0/cr
              ptr_deref_46_store_0_req_1 <= cr_85_symbol; -- link to DP
              ca_86_symbol <= ptr_deref_46_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/word_access_0/ca
              Xexit_84_symbol <= ca_86_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/word_access_0/$exit
              word_access_0_82_symbol <= Xexit_84_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/word_access_0
            Xexit_81_symbol <= word_access_0_82_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access/$exit
            word_access_79_symbol <= Xexit_81_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/word_access
          Xexit_78_symbol <= word_access_79_symbol; -- transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete/$exit
          ptr_deref_46_complete_76_symbol <= Xexit_78_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/ptr_deref_46_complete
        Xexit_55_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/$exit 
          signal Xexit_55_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_55_predecessors(0) <= assign_stmt_49_completed_x_x57_symbol;
          Xexit_55_predecessors(1) <= ptr_deref_46_base_address_calculated_60_symbol;
          Xexit_55_join: join -- 
            port map( -- 
              preds => Xexit_55_predecessors,
              symbol_out => Xexit_55_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49/$exit
        assign_stmt_24_to_assign_stmt_49_53_symbol <= Xexit_55_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_24_to_assign_stmt_49
      assign_stmt_54_87: Block -- branch_block_stmt_13/assign_stmt_54 
        signal assign_stmt_54_87_start: Boolean;
        signal Xentry_88_symbol: Boolean;
        signal Xexit_89_symbol: Boolean;
        signal assign_stmt_54_active_x_x90_symbol : Boolean;
        signal assign_stmt_54_completed_x_x91_symbol : Boolean;
        signal simple_obj_ref_53_trigger_x_x92_symbol : Boolean;
        signal simple_obj_ref_53_complete_93_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_54_87_start <= assign_stmt_54_x_xentry_x_xx_x12_symbol; -- control passed to block
        Xentry_88_symbol  <= assign_stmt_54_87_start; -- transition branch_block_stmt_13/assign_stmt_54/$entry
        assign_stmt_54_active_x_x90_symbol <= simple_obj_ref_53_complete_93_symbol; -- transition branch_block_stmt_13/assign_stmt_54/assign_stmt_54_active_
        assign_stmt_54_completed_x_x91_symbol <= assign_stmt_54_active_x_x90_symbol; -- transition branch_block_stmt_13/assign_stmt_54/assign_stmt_54_completed_
        simple_obj_ref_53_trigger_x_x92_symbol <= Xentry_88_symbol; -- transition branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_trigger_
        simple_obj_ref_53_complete_93: Block -- branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_complete 
          signal simple_obj_ref_53_complete_93_start: Boolean;
          signal Xentry_94_symbol: Boolean;
          signal Xexit_95_symbol: Boolean;
          signal req_96_symbol : Boolean;
          signal ack_97_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_53_complete_93_start <= simple_obj_ref_53_trigger_x_x92_symbol; -- control passed to block
          Xentry_94_symbol  <= simple_obj_ref_53_complete_93_start; -- transition branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_complete/$entry
          req_96_symbol <= Xentry_94_symbol; -- transition branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_complete/req
          simple_obj_ref_53_inst_req_0 <= req_96_symbol; -- link to DP
          ack_97_symbol <= simple_obj_ref_53_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_complete/ack
          Xexit_95_symbol <= ack_97_symbol; -- transition branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_complete/$exit
          simple_obj_ref_53_complete_93_symbol <= Xexit_95_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_54/simple_obj_ref_53_complete
        Xexit_89_symbol <= assign_stmt_54_completed_x_x91_symbol; -- transition branch_block_stmt_13/assign_stmt_54/$exit
        assign_stmt_54_87_symbol <= Xexit_89_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_54
      assign_stmt_58_98: Block -- branch_block_stmt_13/assign_stmt_58 
        signal assign_stmt_58_98_start: Boolean;
        signal Xentry_99_symbol: Boolean;
        signal Xexit_100_symbol: Boolean;
        signal assign_stmt_58_active_x_x101_symbol : Boolean;
        signal assign_stmt_58_completed_x_x102_symbol : Boolean;
        signal simple_obj_ref_57_complete_103_symbol : Boolean;
        signal ptr_deref_56_trigger_x_x104_symbol : Boolean;
        signal ptr_deref_56_active_x_x105_symbol : Boolean;
        signal ptr_deref_56_base_address_calculated_106_symbol : Boolean;
        signal ptr_deref_56_root_address_calculated_107_symbol : Boolean;
        signal ptr_deref_56_word_address_calculated_108_symbol : Boolean;
        signal ptr_deref_56_request_109_symbol : Boolean;
        signal ptr_deref_56_complete_122_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_58_98_start <= assign_stmt_58_x_xentry_x_xx_x14_symbol; -- control passed to block
        Xentry_99_symbol  <= assign_stmt_58_98_start; -- transition branch_block_stmt_13/assign_stmt_58/$entry
        assign_stmt_58_active_x_x101_symbol <= simple_obj_ref_57_complete_103_symbol; -- transition branch_block_stmt_13/assign_stmt_58/assign_stmt_58_active_
        assign_stmt_58_completed_x_x102_symbol <= ptr_deref_56_complete_122_symbol; -- transition branch_block_stmt_13/assign_stmt_58/assign_stmt_58_completed_
        simple_obj_ref_57_complete_103_symbol <= Xentry_99_symbol; -- transition branch_block_stmt_13/assign_stmt_58/simple_obj_ref_57_complete
        ptr_deref_56_trigger_x_x104_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_trigger_ 
          signal ptr_deref_56_trigger_x_x104_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_56_trigger_x_x104_predecessors(0) <= ptr_deref_56_word_address_calculated_108_symbol;
          ptr_deref_56_trigger_x_x104_predecessors(1) <= assign_stmt_58_active_x_x101_symbol;
          ptr_deref_56_trigger_x_x104_join: join -- 
            port map( -- 
              preds => ptr_deref_56_trigger_x_x104_predecessors,
              symbol_out => ptr_deref_56_trigger_x_x104_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_trigger_
        ptr_deref_56_active_x_x105_symbol <= ptr_deref_56_request_109_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_active_
        ptr_deref_56_base_address_calculated_106_symbol <= Xentry_99_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_base_address_calculated
        ptr_deref_56_root_address_calculated_107_symbol <= Xentry_99_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_root_address_calculated
        ptr_deref_56_word_address_calculated_108_symbol <= ptr_deref_56_root_address_calculated_107_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_word_address_calculated
        ptr_deref_56_request_109: Block -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request 
          signal ptr_deref_56_request_109_start: Boolean;
          signal Xentry_110_symbol: Boolean;
          signal Xexit_111_symbol: Boolean;
          signal split_req_112_symbol : Boolean;
          signal split_ack_113_symbol : Boolean;
          signal word_access_114_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_56_request_109_start <= ptr_deref_56_trigger_x_x104_symbol; -- control passed to block
          Xentry_110_symbol  <= ptr_deref_56_request_109_start; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/$entry
          split_req_112_symbol <= Xentry_110_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/split_req
          ptr_deref_56_gather_scatter_req_0 <= split_req_112_symbol; -- link to DP
          split_ack_113_symbol <= ptr_deref_56_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/split_ack
          word_access_114: Block -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access 
            signal word_access_114_start: Boolean;
            signal Xentry_115_symbol: Boolean;
            signal Xexit_116_symbol: Boolean;
            signal word_access_0_117_symbol : Boolean;
            -- 
          begin -- 
            word_access_114_start <= split_ack_113_symbol; -- control passed to block
            Xentry_115_symbol  <= word_access_114_start; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/$entry
            word_access_0_117: Block -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/word_access_0 
              signal word_access_0_117_start: Boolean;
              signal Xentry_118_symbol: Boolean;
              signal Xexit_119_symbol: Boolean;
              signal rr_120_symbol : Boolean;
              signal ra_121_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_117_start <= Xentry_115_symbol; -- control passed to block
              Xentry_118_symbol  <= word_access_0_117_start; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/word_access_0/$entry
              rr_120_symbol <= Xentry_118_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/word_access_0/rr
              ptr_deref_56_store_0_req_0 <= rr_120_symbol; -- link to DP
              ra_121_symbol <= ptr_deref_56_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/word_access_0/ra
              Xexit_119_symbol <= ra_121_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/word_access_0/$exit
              word_access_0_117_symbol <= Xexit_119_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/word_access_0
            Xexit_116_symbol <= word_access_0_117_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access/$exit
            word_access_114_symbol <= Xexit_116_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/word_access
          Xexit_111_symbol <= word_access_114_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request/$exit
          ptr_deref_56_request_109_symbol <= Xexit_111_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_request
        ptr_deref_56_complete_122: Block -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete 
          signal ptr_deref_56_complete_122_start: Boolean;
          signal Xentry_123_symbol: Boolean;
          signal Xexit_124_symbol: Boolean;
          signal word_access_125_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_56_complete_122_start <= ptr_deref_56_active_x_x105_symbol; -- control passed to block
          Xentry_123_symbol  <= ptr_deref_56_complete_122_start; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/$entry
          word_access_125: Block -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access 
            signal word_access_125_start: Boolean;
            signal Xentry_126_symbol: Boolean;
            signal Xexit_127_symbol: Boolean;
            signal word_access_0_128_symbol : Boolean;
            -- 
          begin -- 
            word_access_125_start <= Xentry_123_symbol; -- control passed to block
            Xentry_126_symbol  <= word_access_125_start; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/$entry
            word_access_0_128: Block -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/word_access_0 
              signal word_access_0_128_start: Boolean;
              signal Xentry_129_symbol: Boolean;
              signal Xexit_130_symbol: Boolean;
              signal cr_131_symbol : Boolean;
              signal ca_132_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_128_start <= Xentry_126_symbol; -- control passed to block
              Xentry_129_symbol  <= word_access_0_128_start; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/word_access_0/$entry
              cr_131_symbol <= Xentry_129_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/word_access_0/cr
              ptr_deref_56_store_0_req_1 <= cr_131_symbol; -- link to DP
              ca_132_symbol <= ptr_deref_56_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/word_access_0/ca
              Xexit_130_symbol <= ca_132_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/word_access_0/$exit
              word_access_0_128_symbol <= Xexit_130_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/word_access_0
            Xexit_127_symbol <= word_access_0_128_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access/$exit
            word_access_125_symbol <= Xexit_127_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/word_access
          Xexit_124_symbol <= word_access_125_symbol; -- transition branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete/$exit
          ptr_deref_56_complete_122_symbol <= Xexit_124_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_58/ptr_deref_56_complete
        Xexit_100_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_58/$exit 
          signal Xexit_100_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_100_predecessors(0) <= assign_stmt_58_completed_x_x102_symbol;
          Xexit_100_predecessors(1) <= ptr_deref_56_base_address_calculated_106_symbol;
          Xexit_100_join: join -- 
            port map( -- 
              preds => Xexit_100_predecessors,
              symbol_out => Xexit_100_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_58/$exit
        assign_stmt_58_98_symbol <= Xexit_100_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_58
      assign_stmt_61_133: Block -- branch_block_stmt_13/assign_stmt_61 
        signal assign_stmt_61_133_start: Boolean;
        signal Xentry_134_symbol: Boolean;
        signal Xexit_135_symbol: Boolean;
        signal assign_stmt_61_active_x_x136_symbol : Boolean;
        signal assign_stmt_61_completed_x_x137_symbol : Boolean;
        signal simple_obj_ref_60_trigger_x_x138_symbol : Boolean;
        signal simple_obj_ref_60_complete_139_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_61_133_start <= assign_stmt_61_x_xentry_x_xx_x16_symbol; -- control passed to block
        Xentry_134_symbol  <= assign_stmt_61_133_start; -- transition branch_block_stmt_13/assign_stmt_61/$entry
        assign_stmt_61_active_x_x136_symbol <= simple_obj_ref_60_complete_139_symbol; -- transition branch_block_stmt_13/assign_stmt_61/assign_stmt_61_active_
        assign_stmt_61_completed_x_x137_symbol <= assign_stmt_61_active_x_x136_symbol; -- transition branch_block_stmt_13/assign_stmt_61/assign_stmt_61_completed_
        simple_obj_ref_60_trigger_x_x138_symbol <= Xentry_134_symbol; -- transition branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_trigger_
        simple_obj_ref_60_complete_139: Block -- branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_complete 
          signal simple_obj_ref_60_complete_139_start: Boolean;
          signal Xentry_140_symbol: Boolean;
          signal Xexit_141_symbol: Boolean;
          signal req_142_symbol : Boolean;
          signal ack_143_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_60_complete_139_start <= simple_obj_ref_60_trigger_x_x138_symbol; -- control passed to block
          Xentry_140_symbol  <= simple_obj_ref_60_complete_139_start; -- transition branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_complete/$entry
          req_142_symbol <= Xentry_140_symbol; -- transition branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_complete/req
          simple_obj_ref_60_inst_req_0 <= req_142_symbol; -- link to DP
          ack_143_symbol <= simple_obj_ref_60_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_complete/ack
          Xexit_141_symbol <= ack_143_symbol; -- transition branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_complete/$exit
          simple_obj_ref_60_complete_139_symbol <= Xexit_141_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_61/simple_obj_ref_60_complete
        Xexit_135_symbol <= assign_stmt_61_completed_x_x137_symbol; -- transition branch_block_stmt_13/assign_stmt_61/$exit
        assign_stmt_61_133_symbol <= Xexit_135_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_61
      assign_stmt_65_to_assign_stmt_81_144: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81 
        signal assign_stmt_65_to_assign_stmt_81_144_start: Boolean;
        signal Xentry_145_symbol: Boolean;
        signal Xexit_146_symbol: Boolean;
        signal assign_stmt_65_active_x_x147_symbol : Boolean;
        signal assign_stmt_65_completed_x_x148_symbol : Boolean;
        signal simple_obj_ref_64_complete_149_symbol : Boolean;
        signal ptr_deref_63_trigger_x_x150_symbol : Boolean;
        signal ptr_deref_63_active_x_x151_symbol : Boolean;
        signal ptr_deref_63_base_address_calculated_152_symbol : Boolean;
        signal ptr_deref_63_root_address_calculated_153_symbol : Boolean;
        signal ptr_deref_63_word_address_calculated_154_symbol : Boolean;
        signal ptr_deref_63_request_155_symbol : Boolean;
        signal ptr_deref_63_complete_168_symbol : Boolean;
        signal assign_stmt_69_active_x_x179_symbol : Boolean;
        signal assign_stmt_69_completed_x_x180_symbol : Boolean;
        signal ptr_deref_68_trigger_x_x181_symbol : Boolean;
        signal ptr_deref_68_active_x_x182_symbol : Boolean;
        signal ptr_deref_68_base_address_calculated_183_symbol : Boolean;
        signal ptr_deref_68_root_address_calculated_184_symbol : Boolean;
        signal ptr_deref_68_word_address_calculated_185_symbol : Boolean;
        signal ptr_deref_68_request_186_symbol : Boolean;
        signal ptr_deref_68_complete_197_symbol : Boolean;
        signal assign_stmt_74_active_x_x210_symbol : Boolean;
        signal assign_stmt_74_completed_x_x211_symbol : Boolean;
        signal type_cast_73_active_x_x212_symbol : Boolean;
        signal type_cast_73_trigger_x_x213_symbol : Boolean;
        signal simple_obj_ref_72_complete_214_symbol : Boolean;
        signal type_cast_73_complete_215_symbol : Boolean;
        signal assign_stmt_81_active_x_x220_symbol : Boolean;
        signal assign_stmt_81_completed_x_x221_symbol : Boolean;
        signal binary_79_active_x_x222_symbol : Boolean;
        signal binary_79_trigger_x_x223_symbol : Boolean;
        signal simple_obj_ref_76_complete_224_symbol : Boolean;
        signal binary_79_complete_225_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_65_to_assign_stmt_81_144_start <= assign_stmt_65_to_assign_stmt_81_x_xentry_x_xx_x18_symbol; -- control passed to block
        Xentry_145_symbol  <= assign_stmt_65_to_assign_stmt_81_144_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/$entry
        assign_stmt_65_active_x_x147_symbol <= simple_obj_ref_64_complete_149_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_65_active_
        assign_stmt_65_completed_x_x148_symbol <= ptr_deref_63_complete_168_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_65_completed_
        simple_obj_ref_64_complete_149_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/simple_obj_ref_64_complete
        ptr_deref_63_trigger_x_x150_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_trigger_ 
          signal ptr_deref_63_trigger_x_x150_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_63_trigger_x_x150_predecessors(0) <= ptr_deref_63_word_address_calculated_154_symbol;
          ptr_deref_63_trigger_x_x150_predecessors(1) <= assign_stmt_65_active_x_x147_symbol;
          ptr_deref_63_trigger_x_x150_join: join -- 
            port map( -- 
              preds => ptr_deref_63_trigger_x_x150_predecessors,
              symbol_out => ptr_deref_63_trigger_x_x150_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_trigger_
        ptr_deref_63_active_x_x151_symbol <= ptr_deref_63_request_155_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_active_
        ptr_deref_63_base_address_calculated_152_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_base_address_calculated
        ptr_deref_63_root_address_calculated_153_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_root_address_calculated
        ptr_deref_63_word_address_calculated_154_symbol <= ptr_deref_63_root_address_calculated_153_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_word_address_calculated
        ptr_deref_63_request_155: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request 
          signal ptr_deref_63_request_155_start: Boolean;
          signal Xentry_156_symbol: Boolean;
          signal Xexit_157_symbol: Boolean;
          signal split_req_158_symbol : Boolean;
          signal split_ack_159_symbol : Boolean;
          signal word_access_160_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_63_request_155_start <= ptr_deref_63_trigger_x_x150_symbol; -- control passed to block
          Xentry_156_symbol  <= ptr_deref_63_request_155_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/$entry
          split_req_158_symbol <= Xentry_156_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/split_req
          ptr_deref_63_gather_scatter_req_0 <= split_req_158_symbol; -- link to DP
          split_ack_159_symbol <= ptr_deref_63_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/split_ack
          word_access_160: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access 
            signal word_access_160_start: Boolean;
            signal Xentry_161_symbol: Boolean;
            signal Xexit_162_symbol: Boolean;
            signal word_access_0_163_symbol : Boolean;
            -- 
          begin -- 
            word_access_160_start <= split_ack_159_symbol; -- control passed to block
            Xentry_161_symbol  <= word_access_160_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/$entry
            word_access_0_163: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/word_access_0 
              signal word_access_0_163_start: Boolean;
              signal Xentry_164_symbol: Boolean;
              signal Xexit_165_symbol: Boolean;
              signal rr_166_symbol : Boolean;
              signal ra_167_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_163_start <= Xentry_161_symbol; -- control passed to block
              Xentry_164_symbol  <= word_access_0_163_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/word_access_0/$entry
              rr_166_symbol <= Xentry_164_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/word_access_0/rr
              ptr_deref_63_store_0_req_0 <= rr_166_symbol; -- link to DP
              ra_167_symbol <= ptr_deref_63_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/word_access_0/ra
              Xexit_165_symbol <= ra_167_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/word_access_0/$exit
              word_access_0_163_symbol <= Xexit_165_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/word_access_0
            Xexit_162_symbol <= word_access_0_163_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access/$exit
            word_access_160_symbol <= Xexit_162_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/word_access
          Xexit_157_symbol <= word_access_160_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request/$exit
          ptr_deref_63_request_155_symbol <= Xexit_157_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_request
        ptr_deref_63_complete_168: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete 
          signal ptr_deref_63_complete_168_start: Boolean;
          signal Xentry_169_symbol: Boolean;
          signal Xexit_170_symbol: Boolean;
          signal word_access_171_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_63_complete_168_start <= ptr_deref_63_active_x_x151_symbol; -- control passed to block
          Xentry_169_symbol  <= ptr_deref_63_complete_168_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/$entry
          word_access_171: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access 
            signal word_access_171_start: Boolean;
            signal Xentry_172_symbol: Boolean;
            signal Xexit_173_symbol: Boolean;
            signal word_access_0_174_symbol : Boolean;
            -- 
          begin -- 
            word_access_171_start <= Xentry_169_symbol; -- control passed to block
            Xentry_172_symbol  <= word_access_171_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/$entry
            word_access_0_174: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/word_access_0 
              signal word_access_0_174_start: Boolean;
              signal Xentry_175_symbol: Boolean;
              signal Xexit_176_symbol: Boolean;
              signal cr_177_symbol : Boolean;
              signal ca_178_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_174_start <= Xentry_172_symbol; -- control passed to block
              Xentry_175_symbol  <= word_access_0_174_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/word_access_0/$entry
              cr_177_symbol <= Xentry_175_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/word_access_0/cr
              ptr_deref_63_store_0_req_1 <= cr_177_symbol; -- link to DP
              ca_178_symbol <= ptr_deref_63_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/word_access_0/ca
              Xexit_176_symbol <= ca_178_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/word_access_0/$exit
              word_access_0_174_symbol <= Xexit_176_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/word_access_0
            Xexit_173_symbol <= word_access_0_174_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access/$exit
            word_access_171_symbol <= Xexit_173_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/word_access
          Xexit_170_symbol <= word_access_171_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete/$exit
          ptr_deref_63_complete_168_symbol <= Xexit_170_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_63_complete
        assign_stmt_69_active_x_x179_symbol <= ptr_deref_68_complete_197_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_69_active_
        assign_stmt_69_completed_x_x180_symbol <= assign_stmt_69_active_x_x179_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_69_completed_
        ptr_deref_68_trigger_x_x181_symbol <= ptr_deref_68_word_address_calculated_185_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_trigger_
        ptr_deref_68_active_x_x182_symbol <= ptr_deref_68_request_186_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_active_
        ptr_deref_68_base_address_calculated_183_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_base_address_calculated
        ptr_deref_68_root_address_calculated_184_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_root_address_calculated
        ptr_deref_68_word_address_calculated_185_symbol <= ptr_deref_68_root_address_calculated_184_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_word_address_calculated
        ptr_deref_68_request_186: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request 
          signal ptr_deref_68_request_186_start: Boolean;
          signal Xentry_187_symbol: Boolean;
          signal Xexit_188_symbol: Boolean;
          signal word_access_189_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_68_request_186_start <= ptr_deref_68_trigger_x_x181_symbol; -- control passed to block
          Xentry_187_symbol  <= ptr_deref_68_request_186_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/$entry
          word_access_189: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access 
            signal word_access_189_start: Boolean;
            signal Xentry_190_symbol: Boolean;
            signal Xexit_191_symbol: Boolean;
            signal word_access_0_192_symbol : Boolean;
            -- 
          begin -- 
            word_access_189_start <= Xentry_187_symbol; -- control passed to block
            Xentry_190_symbol  <= word_access_189_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/$entry
            word_access_0_192: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/word_access_0 
              signal word_access_0_192_start: Boolean;
              signal Xentry_193_symbol: Boolean;
              signal Xexit_194_symbol: Boolean;
              signal rr_195_symbol : Boolean;
              signal ra_196_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_192_start <= Xentry_190_symbol; -- control passed to block
              Xentry_193_symbol  <= word_access_0_192_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/word_access_0/$entry
              rr_195_symbol <= Xentry_193_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/word_access_0/rr
              ptr_deref_68_load_0_req_0 <= rr_195_symbol; -- link to DP
              ra_196_symbol <= ptr_deref_68_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/word_access_0/ra
              Xexit_194_symbol <= ra_196_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/word_access_0/$exit
              word_access_0_192_symbol <= Xexit_194_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/word_access_0
            Xexit_191_symbol <= word_access_0_192_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access/$exit
            word_access_189_symbol <= Xexit_191_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/word_access
          Xexit_188_symbol <= word_access_189_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request/$exit
          ptr_deref_68_request_186_symbol <= Xexit_188_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_request
        ptr_deref_68_complete_197: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete 
          signal ptr_deref_68_complete_197_start: Boolean;
          signal Xentry_198_symbol: Boolean;
          signal Xexit_199_symbol: Boolean;
          signal word_access_200_symbol : Boolean;
          signal merge_req_208_symbol : Boolean;
          signal merge_ack_209_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_68_complete_197_start <= ptr_deref_68_active_x_x182_symbol; -- control passed to block
          Xentry_198_symbol  <= ptr_deref_68_complete_197_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/$entry
          word_access_200: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access 
            signal word_access_200_start: Boolean;
            signal Xentry_201_symbol: Boolean;
            signal Xexit_202_symbol: Boolean;
            signal word_access_0_203_symbol : Boolean;
            -- 
          begin -- 
            word_access_200_start <= Xentry_198_symbol; -- control passed to block
            Xentry_201_symbol  <= word_access_200_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/$entry
            word_access_0_203: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/word_access_0 
              signal word_access_0_203_start: Boolean;
              signal Xentry_204_symbol: Boolean;
              signal Xexit_205_symbol: Boolean;
              signal cr_206_symbol : Boolean;
              signal ca_207_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_203_start <= Xentry_201_symbol; -- control passed to block
              Xentry_204_symbol  <= word_access_0_203_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/word_access_0/$entry
              cr_206_symbol <= Xentry_204_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/word_access_0/cr
              ptr_deref_68_load_0_req_1 <= cr_206_symbol; -- link to DP
              ca_207_symbol <= ptr_deref_68_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/word_access_0/ca
              Xexit_205_symbol <= ca_207_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/word_access_0/$exit
              word_access_0_203_symbol <= Xexit_205_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/word_access_0
            Xexit_202_symbol <= word_access_0_203_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access/$exit
            word_access_200_symbol <= Xexit_202_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/word_access
          merge_req_208_symbol <= word_access_200_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/merge_req
          ptr_deref_68_gather_scatter_req_0 <= merge_req_208_symbol; -- link to DP
          merge_ack_209_symbol <= ptr_deref_68_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/merge_ack
          Xexit_199_symbol <= merge_ack_209_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete/$exit
          ptr_deref_68_complete_197_symbol <= Xexit_199_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/ptr_deref_68_complete
        assign_stmt_74_active_x_x210_symbol <= type_cast_73_complete_215_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_74_active_
        assign_stmt_74_completed_x_x211_symbol <= assign_stmt_74_active_x_x210_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_74_completed_
        type_cast_73_active_x_x212_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_active_ 
          signal type_cast_73_active_x_x212_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_73_active_x_x212_predecessors(0) <= type_cast_73_trigger_x_x213_symbol;
          type_cast_73_active_x_x212_predecessors(1) <= simple_obj_ref_72_complete_214_symbol;
          type_cast_73_active_x_x212_join: join -- 
            port map( -- 
              preds => type_cast_73_active_x_x212_predecessors,
              symbol_out => type_cast_73_active_x_x212_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_active_
        type_cast_73_trigger_x_x213_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_trigger_
        simple_obj_ref_72_complete_214_symbol <= assign_stmt_69_completed_x_x180_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/simple_obj_ref_72_complete
        type_cast_73_complete_215: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_complete 
          signal type_cast_73_complete_215_start: Boolean;
          signal Xentry_216_symbol: Boolean;
          signal Xexit_217_symbol: Boolean;
          signal req_218_symbol : Boolean;
          signal ack_219_symbol : Boolean;
          -- 
        begin -- 
          type_cast_73_complete_215_start <= type_cast_73_active_x_x212_symbol; -- control passed to block
          Xentry_216_symbol  <= type_cast_73_complete_215_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_complete/$entry
          req_218_symbol <= Xentry_216_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_complete/req
          type_cast_73_inst_req_0 <= req_218_symbol; -- link to DP
          ack_219_symbol <= type_cast_73_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_complete/ack
          Xexit_217_symbol <= ack_219_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_complete/$exit
          type_cast_73_complete_215_symbol <= Xexit_217_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/type_cast_73_complete
        assign_stmt_81_active_x_x220_symbol <= binary_79_complete_225_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_81_active_
        assign_stmt_81_completed_x_x221_symbol <= assign_stmt_81_active_x_x220_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/assign_stmt_81_completed_
        binary_79_active_x_x222_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_active_ 
          signal binary_79_active_x_x222_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_79_active_x_x222_predecessors(0) <= binary_79_trigger_x_x223_symbol;
          binary_79_active_x_x222_predecessors(1) <= simple_obj_ref_76_complete_224_symbol;
          binary_79_active_x_x222_join: join -- 
            port map( -- 
              preds => binary_79_active_x_x222_predecessors,
              symbol_out => binary_79_active_x_x222_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_active_
        binary_79_trigger_x_x223_symbol <= Xentry_145_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_trigger_
        simple_obj_ref_76_complete_224_symbol <= assign_stmt_74_completed_x_x211_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/simple_obj_ref_76_complete
        binary_79_complete_225: Block -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete 
          signal binary_79_complete_225_start: Boolean;
          signal Xentry_226_symbol: Boolean;
          signal Xexit_227_symbol: Boolean;
          signal rr_228_symbol : Boolean;
          signal ra_229_symbol : Boolean;
          signal cr_230_symbol : Boolean;
          signal ca_231_symbol : Boolean;
          -- 
        begin -- 
          binary_79_complete_225_start <= binary_79_active_x_x222_symbol; -- control passed to block
          Xentry_226_symbol  <= binary_79_complete_225_start; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete/$entry
          rr_228_symbol <= Xentry_226_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete/rr
          binary_79_inst_req_0 <= rr_228_symbol; -- link to DP
          ra_229_symbol <= binary_79_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete/ra
          cr_230_symbol <= ra_229_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete/cr
          binary_79_inst_req_1 <= cr_230_symbol; -- link to DP
          ca_231_symbol <= binary_79_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete/ca
          Xexit_227_symbol <= ca_231_symbol; -- transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete/$exit
          binary_79_complete_225_symbol <= Xexit_227_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/binary_79_complete
        Xexit_146_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/$exit 
          signal Xexit_146_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          Xexit_146_predecessors(0) <= assign_stmt_65_completed_x_x148_symbol;
          Xexit_146_predecessors(1) <= ptr_deref_63_base_address_calculated_152_symbol;
          Xexit_146_predecessors(2) <= ptr_deref_68_base_address_calculated_183_symbol;
          Xexit_146_predecessors(3) <= assign_stmt_81_completed_x_x221_symbol;
          Xexit_146_join: join -- 
            port map( -- 
              preds => Xexit_146_predecessors,
              symbol_out => Xexit_146_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81/$exit
        assign_stmt_65_to_assign_stmt_81_144_symbol <= Xexit_146_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_65_to_assign_stmt_81
      if_stmt_82_dead_link_232: Block -- branch_block_stmt_13/if_stmt_82_dead_link 
        signal if_stmt_82_dead_link_232_start: Boolean;
        signal Xentry_233_symbol: Boolean;
        signal Xexit_234_symbol: Boolean;
        signal dead_transition_235_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_82_dead_link_232_start <= if_stmt_82_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_233_symbol  <= if_stmt_82_dead_link_232_start; -- transition branch_block_stmt_13/if_stmt_82_dead_link/$entry
        dead_transition_235_symbol <= false;
        Xexit_234_symbol <= dead_transition_235_symbol; -- transition branch_block_stmt_13/if_stmt_82_dead_link/$exit
        if_stmt_82_dead_link_232_symbol <= Xexit_234_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_82_dead_link
      if_stmt_82_eval_test_236: Block -- branch_block_stmt_13/if_stmt_82_eval_test 
        signal if_stmt_82_eval_test_236_start: Boolean;
        signal Xentry_237_symbol: Boolean;
        signal Xexit_238_symbol: Boolean;
        signal branch_req_239_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_82_eval_test_236_start <= if_stmt_82_x_xentry_x_xx_x20_symbol; -- control passed to block
        Xentry_237_symbol  <= if_stmt_82_eval_test_236_start; -- transition branch_block_stmt_13/if_stmt_82_eval_test/$entry
        branch_req_239_symbol <= Xentry_237_symbol; -- transition branch_block_stmt_13/if_stmt_82_eval_test/branch_req
        if_stmt_82_branch_req_0 <= branch_req_239_symbol; -- link to DP
        Xexit_238_symbol <= branch_req_239_symbol; -- transition branch_block_stmt_13/if_stmt_82_eval_test/$exit
        if_stmt_82_eval_test_236_symbol <= Xexit_238_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_82_eval_test
      simple_obj_ref_83_place_240_symbol  <=  if_stmt_82_eval_test_236_symbol; -- place branch_block_stmt_13/simple_obj_ref_83_place (optimized away) 
      if_stmt_82_if_link_241: Block -- branch_block_stmt_13/if_stmt_82_if_link 
        signal if_stmt_82_if_link_241_start: Boolean;
        signal Xentry_242_symbol: Boolean;
        signal Xexit_243_symbol: Boolean;
        signal if_choice_transition_244_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_82_if_link_241_start <= simple_obj_ref_83_place_240_symbol; -- control passed to block
        Xentry_242_symbol  <= if_stmt_82_if_link_241_start; -- transition branch_block_stmt_13/if_stmt_82_if_link/$entry
        if_choice_transition_244_symbol <= if_stmt_82_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_82_if_link/if_choice_transition
        Xexit_243_symbol <= if_choice_transition_244_symbol; -- transition branch_block_stmt_13/if_stmt_82_if_link/$exit
        if_stmt_82_if_link_241_symbol <= Xexit_243_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_82_if_link
      if_stmt_82_else_link_245: Block -- branch_block_stmt_13/if_stmt_82_else_link 
        signal if_stmt_82_else_link_245_start: Boolean;
        signal Xentry_246_symbol: Boolean;
        signal Xexit_247_symbol: Boolean;
        signal else_choice_transition_248_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_82_else_link_245_start <= simple_obj_ref_83_place_240_symbol; -- control passed to block
        Xentry_246_symbol  <= if_stmt_82_else_link_245_start; -- transition branch_block_stmt_13/if_stmt_82_else_link/$entry
        else_choice_transition_248_symbol <= if_stmt_82_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_82_else_link/else_choice_transition
        Xexit_247_symbol <= else_choice_transition_248_symbol; -- transition branch_block_stmt_13/if_stmt_82_else_link/$exit
        if_stmt_82_else_link_245_symbol <= Xexit_247_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_82_else_link
      bb_1_bb_2_249_symbol  <=  if_stmt_82_if_link_241_symbol; -- place branch_block_stmt_13/bb_1_bb_2 (optimized away) 
      bb_1_bb_4_250_symbol  <=  if_stmt_82_else_link_245_symbol; -- place branch_block_stmt_13/bb_1_bb_4 (optimized away) 
      assign_stmt_92_to_assign_stmt_102_251: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102 
        signal assign_stmt_92_to_assign_stmt_102_251_start: Boolean;
        signal Xentry_252_symbol: Boolean;
        signal Xexit_253_symbol: Boolean;
        signal assign_stmt_92_active_x_x254_symbol : Boolean;
        signal assign_stmt_92_completed_x_x255_symbol : Boolean;
        signal ptr_deref_91_trigger_x_x256_symbol : Boolean;
        signal ptr_deref_91_active_x_x257_symbol : Boolean;
        signal ptr_deref_91_base_address_calculated_258_symbol : Boolean;
        signal ptr_deref_91_root_address_calculated_259_symbol : Boolean;
        signal ptr_deref_91_word_address_calculated_260_symbol : Boolean;
        signal ptr_deref_91_request_261_symbol : Boolean;
        signal ptr_deref_91_complete_272_symbol : Boolean;
        signal assign_stmt_96_active_x_x285_symbol : Boolean;
        signal assign_stmt_96_completed_x_x286_symbol : Boolean;
        signal type_cast_95_active_x_x287_symbol : Boolean;
        signal type_cast_95_trigger_x_x288_symbol : Boolean;
        signal simple_obj_ref_94_complete_289_symbol : Boolean;
        signal type_cast_95_complete_290_symbol : Boolean;
        signal assign_stmt_102_active_x_x295_symbol : Boolean;
        signal assign_stmt_102_completed_x_x296_symbol : Boolean;
        signal binary_101_active_x_x297_symbol : Boolean;
        signal binary_101_trigger_x_x298_symbol : Boolean;
        signal simple_obj_ref_98_complete_299_symbol : Boolean;
        signal binary_101_complete_300_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_92_to_assign_stmt_102_251_start <= assign_stmt_92_to_assign_stmt_102_x_xentry_x_xx_x24_symbol; -- control passed to block
        Xentry_252_symbol  <= assign_stmt_92_to_assign_stmt_102_251_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/$entry
        assign_stmt_92_active_x_x254_symbol <= ptr_deref_91_complete_272_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/assign_stmt_92_active_
        assign_stmt_92_completed_x_x255_symbol <= assign_stmt_92_active_x_x254_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/assign_stmt_92_completed_
        ptr_deref_91_trigger_x_x256_symbol <= ptr_deref_91_word_address_calculated_260_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_trigger_
        ptr_deref_91_active_x_x257_symbol <= ptr_deref_91_request_261_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_active_
        ptr_deref_91_base_address_calculated_258_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_base_address_calculated
        ptr_deref_91_root_address_calculated_259_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_root_address_calculated
        ptr_deref_91_word_address_calculated_260_symbol <= ptr_deref_91_root_address_calculated_259_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_word_address_calculated
        ptr_deref_91_request_261: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request 
          signal ptr_deref_91_request_261_start: Boolean;
          signal Xentry_262_symbol: Boolean;
          signal Xexit_263_symbol: Boolean;
          signal word_access_264_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_91_request_261_start <= ptr_deref_91_trigger_x_x256_symbol; -- control passed to block
          Xentry_262_symbol  <= ptr_deref_91_request_261_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/$entry
          word_access_264: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access 
            signal word_access_264_start: Boolean;
            signal Xentry_265_symbol: Boolean;
            signal Xexit_266_symbol: Boolean;
            signal word_access_0_267_symbol : Boolean;
            -- 
          begin -- 
            word_access_264_start <= Xentry_262_symbol; -- control passed to block
            Xentry_265_symbol  <= word_access_264_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/$entry
            word_access_0_267: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/word_access_0 
              signal word_access_0_267_start: Boolean;
              signal Xentry_268_symbol: Boolean;
              signal Xexit_269_symbol: Boolean;
              signal rr_270_symbol : Boolean;
              signal ra_271_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_267_start <= Xentry_265_symbol; -- control passed to block
              Xentry_268_symbol  <= word_access_0_267_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/word_access_0/$entry
              rr_270_symbol <= Xentry_268_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/word_access_0/rr
              ptr_deref_91_load_0_req_0 <= rr_270_symbol; -- link to DP
              ra_271_symbol <= ptr_deref_91_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/word_access_0/ra
              Xexit_269_symbol <= ra_271_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/word_access_0/$exit
              word_access_0_267_symbol <= Xexit_269_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/word_access_0
            Xexit_266_symbol <= word_access_0_267_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access/$exit
            word_access_264_symbol <= Xexit_266_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/word_access
          Xexit_263_symbol <= word_access_264_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request/$exit
          ptr_deref_91_request_261_symbol <= Xexit_263_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_request
        ptr_deref_91_complete_272: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete 
          signal ptr_deref_91_complete_272_start: Boolean;
          signal Xentry_273_symbol: Boolean;
          signal Xexit_274_symbol: Boolean;
          signal word_access_275_symbol : Boolean;
          signal merge_req_283_symbol : Boolean;
          signal merge_ack_284_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_91_complete_272_start <= ptr_deref_91_active_x_x257_symbol; -- control passed to block
          Xentry_273_symbol  <= ptr_deref_91_complete_272_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/$entry
          word_access_275: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access 
            signal word_access_275_start: Boolean;
            signal Xentry_276_symbol: Boolean;
            signal Xexit_277_symbol: Boolean;
            signal word_access_0_278_symbol : Boolean;
            -- 
          begin -- 
            word_access_275_start <= Xentry_273_symbol; -- control passed to block
            Xentry_276_symbol  <= word_access_275_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/$entry
            word_access_0_278: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/word_access_0 
              signal word_access_0_278_start: Boolean;
              signal Xentry_279_symbol: Boolean;
              signal Xexit_280_symbol: Boolean;
              signal cr_281_symbol : Boolean;
              signal ca_282_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_278_start <= Xentry_276_symbol; -- control passed to block
              Xentry_279_symbol  <= word_access_0_278_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/word_access_0/$entry
              cr_281_symbol <= Xentry_279_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/word_access_0/cr
              ptr_deref_91_load_0_req_1 <= cr_281_symbol; -- link to DP
              ca_282_symbol <= ptr_deref_91_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/word_access_0/ca
              Xexit_280_symbol <= ca_282_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/word_access_0/$exit
              word_access_0_278_symbol <= Xexit_280_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/word_access_0
            Xexit_277_symbol <= word_access_0_278_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access/$exit
            word_access_275_symbol <= Xexit_277_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/word_access
          merge_req_283_symbol <= word_access_275_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/merge_req
          ptr_deref_91_gather_scatter_req_0 <= merge_req_283_symbol; -- link to DP
          merge_ack_284_symbol <= ptr_deref_91_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/merge_ack
          Xexit_274_symbol <= merge_ack_284_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete/$exit
          ptr_deref_91_complete_272_symbol <= Xexit_274_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/ptr_deref_91_complete
        assign_stmt_96_active_x_x285_symbol <= type_cast_95_complete_290_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/assign_stmt_96_active_
        assign_stmt_96_completed_x_x286_symbol <= assign_stmt_96_active_x_x285_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/assign_stmt_96_completed_
        type_cast_95_active_x_x287_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_active_ 
          signal type_cast_95_active_x_x287_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_95_active_x_x287_predecessors(0) <= type_cast_95_trigger_x_x288_symbol;
          type_cast_95_active_x_x287_predecessors(1) <= simple_obj_ref_94_complete_289_symbol;
          type_cast_95_active_x_x287_join: join -- 
            port map( -- 
              preds => type_cast_95_active_x_x287_predecessors,
              symbol_out => type_cast_95_active_x_x287_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_active_
        type_cast_95_trigger_x_x288_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_trigger_
        simple_obj_ref_94_complete_289_symbol <= assign_stmt_92_completed_x_x255_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/simple_obj_ref_94_complete
        type_cast_95_complete_290: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_complete 
          signal type_cast_95_complete_290_start: Boolean;
          signal Xentry_291_symbol: Boolean;
          signal Xexit_292_symbol: Boolean;
          signal req_293_symbol : Boolean;
          signal ack_294_symbol : Boolean;
          -- 
        begin -- 
          type_cast_95_complete_290_start <= type_cast_95_active_x_x287_symbol; -- control passed to block
          Xentry_291_symbol  <= type_cast_95_complete_290_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_complete/$entry
          req_293_symbol <= Xentry_291_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_complete/req
          type_cast_95_inst_req_0 <= req_293_symbol; -- link to DP
          ack_294_symbol <= type_cast_95_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_complete/ack
          Xexit_292_symbol <= ack_294_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_complete/$exit
          type_cast_95_complete_290_symbol <= Xexit_292_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/type_cast_95_complete
        assign_stmt_102_active_x_x295_symbol <= binary_101_complete_300_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/assign_stmt_102_active_
        assign_stmt_102_completed_x_x296_symbol <= assign_stmt_102_active_x_x295_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/assign_stmt_102_completed_
        binary_101_active_x_x297_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_active_ 
          signal binary_101_active_x_x297_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_101_active_x_x297_predecessors(0) <= binary_101_trigger_x_x298_symbol;
          binary_101_active_x_x297_predecessors(1) <= simple_obj_ref_98_complete_299_symbol;
          binary_101_active_x_x297_join: join -- 
            port map( -- 
              preds => binary_101_active_x_x297_predecessors,
              symbol_out => binary_101_active_x_x297_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_active_
        binary_101_trigger_x_x298_symbol <= Xentry_252_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_trigger_
        simple_obj_ref_98_complete_299_symbol <= assign_stmt_96_completed_x_x286_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/simple_obj_ref_98_complete
        binary_101_complete_300: Block -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete 
          signal binary_101_complete_300_start: Boolean;
          signal Xentry_301_symbol: Boolean;
          signal Xexit_302_symbol: Boolean;
          signal rr_303_symbol : Boolean;
          signal ra_304_symbol : Boolean;
          signal cr_305_symbol : Boolean;
          signal ca_306_symbol : Boolean;
          -- 
        begin -- 
          binary_101_complete_300_start <= binary_101_active_x_x297_symbol; -- control passed to block
          Xentry_301_symbol  <= binary_101_complete_300_start; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete/$entry
          rr_303_symbol <= Xentry_301_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete/rr
          binary_101_inst_req_0 <= rr_303_symbol; -- link to DP
          ra_304_symbol <= binary_101_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete/ra
          cr_305_symbol <= ra_304_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete/cr
          binary_101_inst_req_1 <= cr_305_symbol; -- link to DP
          ca_306_symbol <= binary_101_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete/ca
          Xexit_302_symbol <= ca_306_symbol; -- transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete/$exit
          binary_101_complete_300_symbol <= Xexit_302_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/binary_101_complete
        Xexit_253_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/$exit 
          signal Xexit_253_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_253_predecessors(0) <= ptr_deref_91_base_address_calculated_258_symbol;
          Xexit_253_predecessors(1) <= assign_stmt_102_completed_x_x296_symbol;
          Xexit_253_join: join -- 
            port map( -- 
              preds => Xexit_253_predecessors,
              symbol_out => Xexit_253_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102/$exit
        assign_stmt_92_to_assign_stmt_102_251_symbol <= Xexit_253_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_92_to_assign_stmt_102
      if_stmt_103_dead_link_307: Block -- branch_block_stmt_13/if_stmt_103_dead_link 
        signal if_stmt_103_dead_link_307_start: Boolean;
        signal Xentry_308_symbol: Boolean;
        signal Xexit_309_symbol: Boolean;
        signal dead_transition_310_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_103_dead_link_307_start <= if_stmt_103_x_xentry_x_xx_x26_symbol; -- control passed to block
        Xentry_308_symbol  <= if_stmt_103_dead_link_307_start; -- transition branch_block_stmt_13/if_stmt_103_dead_link/$entry
        dead_transition_310_symbol <= false;
        Xexit_309_symbol <= dead_transition_310_symbol; -- transition branch_block_stmt_13/if_stmt_103_dead_link/$exit
        if_stmt_103_dead_link_307_symbol <= Xexit_309_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_103_dead_link
      if_stmt_103_eval_test_311: Block -- branch_block_stmt_13/if_stmt_103_eval_test 
        signal if_stmt_103_eval_test_311_start: Boolean;
        signal Xentry_312_symbol: Boolean;
        signal Xexit_313_symbol: Boolean;
        signal branch_req_314_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_103_eval_test_311_start <= if_stmt_103_x_xentry_x_xx_x26_symbol; -- control passed to block
        Xentry_312_symbol  <= if_stmt_103_eval_test_311_start; -- transition branch_block_stmt_13/if_stmt_103_eval_test/$entry
        branch_req_314_symbol <= Xentry_312_symbol; -- transition branch_block_stmt_13/if_stmt_103_eval_test/branch_req
        if_stmt_103_branch_req_0 <= branch_req_314_symbol; -- link to DP
        Xexit_313_symbol <= branch_req_314_symbol; -- transition branch_block_stmt_13/if_stmt_103_eval_test/$exit
        if_stmt_103_eval_test_311_symbol <= Xexit_313_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_103_eval_test
      simple_obj_ref_104_place_315_symbol  <=  if_stmt_103_eval_test_311_symbol; -- place branch_block_stmt_13/simple_obj_ref_104_place (optimized away) 
      if_stmt_103_if_link_316: Block -- branch_block_stmt_13/if_stmt_103_if_link 
        signal if_stmt_103_if_link_316_start: Boolean;
        signal Xentry_317_symbol: Boolean;
        signal Xexit_318_symbol: Boolean;
        signal if_choice_transition_319_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_103_if_link_316_start <= simple_obj_ref_104_place_315_symbol; -- control passed to block
        Xentry_317_symbol  <= if_stmt_103_if_link_316_start; -- transition branch_block_stmt_13/if_stmt_103_if_link/$entry
        if_choice_transition_319_symbol <= if_stmt_103_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_103_if_link/if_choice_transition
        Xexit_318_symbol <= if_choice_transition_319_symbol; -- transition branch_block_stmt_13/if_stmt_103_if_link/$exit
        if_stmt_103_if_link_316_symbol <= Xexit_318_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_103_if_link
      if_stmt_103_else_link_320: Block -- branch_block_stmt_13/if_stmt_103_else_link 
        signal if_stmt_103_else_link_320_start: Boolean;
        signal Xentry_321_symbol: Boolean;
        signal Xexit_322_symbol: Boolean;
        signal else_choice_transition_323_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_103_else_link_320_start <= simple_obj_ref_104_place_315_symbol; -- control passed to block
        Xentry_321_symbol  <= if_stmt_103_else_link_320_start; -- transition branch_block_stmt_13/if_stmt_103_else_link/$entry
        else_choice_transition_323_symbol <= if_stmt_103_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_103_else_link/else_choice_transition
        Xexit_322_symbol <= else_choice_transition_323_symbol; -- transition branch_block_stmt_13/if_stmt_103_else_link/$exit
        if_stmt_103_else_link_320_symbol <= Xexit_322_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_103_else_link
      bb_2_bb_3_324_symbol  <=  if_stmt_103_if_link_316_symbol; -- place branch_block_stmt_13/bb_2_bb_3 (optimized away) 
      bb_2_bb_4_325_symbol  <=  if_stmt_103_else_link_320_symbol; -- place branch_block_stmt_13/bb_2_bb_4 (optimized away) 
      assign_stmt_113_to_assign_stmt_227_326: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227 
        signal assign_stmt_113_to_assign_stmt_227_326_start: Boolean;
        signal Xentry_327_symbol: Boolean;
        signal Xexit_328_symbol: Boolean;
        signal assign_stmt_113_active_x_x329_symbol : Boolean;
        signal assign_stmt_113_completed_x_x330_symbol : Boolean;
        signal ptr_deref_112_trigger_x_x331_symbol : Boolean;
        signal ptr_deref_112_active_x_x332_symbol : Boolean;
        signal ptr_deref_112_base_address_calculated_333_symbol : Boolean;
        signal ptr_deref_112_root_address_calculated_334_symbol : Boolean;
        signal ptr_deref_112_word_address_calculated_335_symbol : Boolean;
        signal ptr_deref_112_request_336_symbol : Boolean;
        signal ptr_deref_112_complete_347_symbol : Boolean;
        signal assign_stmt_119_active_x_x360_symbol : Boolean;
        signal assign_stmt_119_completed_x_x361_symbol : Boolean;
        signal binary_118_active_x_x362_symbol : Boolean;
        signal binary_118_trigger_x_x363_symbol : Boolean;
        signal simple_obj_ref_115_complete_364_symbol : Boolean;
        signal binary_118_complete_365_symbol : Boolean;
        signal assign_stmt_123_active_x_x372_symbol : Boolean;
        signal assign_stmt_123_completed_x_x373_symbol : Boolean;
        signal simple_obj_ref_122_complete_374_symbol : Boolean;
        signal ptr_deref_121_trigger_x_x375_symbol : Boolean;
        signal ptr_deref_121_active_x_x376_symbol : Boolean;
        signal ptr_deref_121_base_address_calculated_377_symbol : Boolean;
        signal ptr_deref_121_root_address_calculated_378_symbol : Boolean;
        signal ptr_deref_121_word_address_calculated_379_symbol : Boolean;
        signal ptr_deref_121_request_380_symbol : Boolean;
        signal ptr_deref_121_complete_393_symbol : Boolean;
        signal assign_stmt_127_active_x_x404_symbol : Boolean;
        signal assign_stmt_127_completed_x_x405_symbol : Boolean;
        signal ptr_deref_126_trigger_x_x406_symbol : Boolean;
        signal ptr_deref_126_active_x_x407_symbol : Boolean;
        signal ptr_deref_126_base_address_calculated_408_symbol : Boolean;
        signal ptr_deref_126_root_address_calculated_409_symbol : Boolean;
        signal ptr_deref_126_word_address_calculated_410_symbol : Boolean;
        signal ptr_deref_126_request_411_symbol : Boolean;
        signal ptr_deref_126_complete_422_symbol : Boolean;
        signal assign_stmt_133_active_x_x435_symbol : Boolean;
        signal assign_stmt_133_completed_x_x436_symbol : Boolean;
        signal binary_132_active_x_x437_symbol : Boolean;
        signal binary_132_trigger_x_x438_symbol : Boolean;
        signal simple_obj_ref_129_complete_439_symbol : Boolean;
        signal binary_132_complete_440_symbol : Boolean;
        signal assign_stmt_137_active_x_x447_symbol : Boolean;
        signal assign_stmt_137_completed_x_x448_symbol : Boolean;
        signal type_cast_136_active_x_x449_symbol : Boolean;
        signal type_cast_136_trigger_x_x450_symbol : Boolean;
        signal simple_obj_ref_135_complete_451_symbol : Boolean;
        signal type_cast_136_complete_452_symbol : Boolean;
        signal assign_stmt_141_active_x_x457_symbol : Boolean;
        signal assign_stmt_141_completed_x_x458_symbol : Boolean;
        signal simple_obj_ref_140_complete_459_symbol : Boolean;
        signal ptr_deref_139_trigger_x_x460_symbol : Boolean;
        signal ptr_deref_139_active_x_x461_symbol : Boolean;
        signal ptr_deref_139_base_address_calculated_462_symbol : Boolean;
        signal ptr_deref_139_root_address_calculated_463_symbol : Boolean;
        signal ptr_deref_139_word_address_calculated_464_symbol : Boolean;
        signal ptr_deref_139_request_465_symbol : Boolean;
        signal ptr_deref_139_complete_478_symbol : Boolean;
        signal assign_stmt_145_active_x_x489_symbol : Boolean;
        signal assign_stmt_145_completed_x_x490_symbol : Boolean;
        signal ptr_deref_144_trigger_x_x491_symbol : Boolean;
        signal ptr_deref_144_active_x_x492_symbol : Boolean;
        signal ptr_deref_144_base_address_calculated_493_symbol : Boolean;
        signal ptr_deref_144_root_address_calculated_494_symbol : Boolean;
        signal ptr_deref_144_word_address_calculated_495_symbol : Boolean;
        signal ptr_deref_144_request_496_symbol : Boolean;
        signal ptr_deref_144_complete_507_symbol : Boolean;
        signal assign_stmt_154_active_x_x520_symbol : Boolean;
        signal assign_stmt_154_completed_x_x521_symbol : Boolean;
        signal binary_153_active_x_x522_symbol : Boolean;
        signal binary_153_trigger_x_x523_symbol : Boolean;
        signal type_cast_149_active_x_x524_symbol : Boolean;
        signal type_cast_149_trigger_x_x525_symbol : Boolean;
        signal simple_obj_ref_148_complete_526_symbol : Boolean;
        signal type_cast_149_complete_527_symbol : Boolean;
        signal binary_153_complete_532_symbol : Boolean;
        signal assign_stmt_158_active_x_x539_symbol : Boolean;
        signal assign_stmt_158_completed_x_x540_symbol : Boolean;
        signal ptr_deref_157_trigger_x_x541_symbol : Boolean;
        signal ptr_deref_157_active_x_x542_symbol : Boolean;
        signal ptr_deref_157_base_address_calculated_543_symbol : Boolean;
        signal ptr_deref_157_root_address_calculated_544_symbol : Boolean;
        signal ptr_deref_157_word_address_calculated_545_symbol : Boolean;
        signal ptr_deref_157_request_546_symbol : Boolean;
        signal ptr_deref_157_complete_557_symbol : Boolean;
        signal assign_stmt_162_active_x_x570_symbol : Boolean;
        signal assign_stmt_162_completed_x_x571_symbol : Boolean;
        signal type_cast_161_active_x_x572_symbol : Boolean;
        signal type_cast_161_trigger_x_x573_symbol : Boolean;
        signal simple_obj_ref_160_complete_574_symbol : Boolean;
        signal type_cast_161_complete_575_symbol : Boolean;
        signal assign_stmt_172_active_x_x580_symbol : Boolean;
        signal assign_stmt_172_completed_x_x581_symbol : Boolean;
        signal type_cast_171_active_x_x582_symbol : Boolean;
        signal type_cast_171_trigger_x_x583_symbol : Boolean;
        signal binary_170_active_x_x584_symbol : Boolean;
        signal binary_170_trigger_x_x585_symbol : Boolean;
        signal type_cast_166_active_x_x586_symbol : Boolean;
        signal type_cast_166_trigger_x_x587_symbol : Boolean;
        signal simple_obj_ref_165_complete_588_symbol : Boolean;
        signal type_cast_166_complete_589_symbol : Boolean;
        signal binary_170_complete_594_symbol : Boolean;
        signal type_cast_171_complete_601_symbol : Boolean;
        signal assign_stmt_178_active_x_x606_symbol : Boolean;
        signal assign_stmt_178_completed_x_x607_symbol : Boolean;
        signal binary_177_active_x_x608_symbol : Boolean;
        signal binary_177_trigger_x_x609_symbol : Boolean;
        signal simple_obj_ref_174_complete_610_symbol : Boolean;
        signal binary_177_complete_611_symbol : Boolean;
        signal assign_stmt_184_active_x_x618_symbol : Boolean;
        signal assign_stmt_184_completed_x_x619_symbol : Boolean;
        signal ternary_183_trigger_x_x620_symbol : Boolean;
        signal ternary_183_active_x_x621_symbol : Boolean;
        signal simple_obj_ref_180_complete_622_symbol : Boolean;
        signal simple_obj_ref_181_complete_623_symbol : Boolean;
        signal simple_obj_ref_182_complete_624_symbol : Boolean;
        signal ternary_183_complete_625_symbol : Boolean;
        signal assign_stmt_189_active_x_x630_symbol : Boolean;
        signal assign_stmt_189_completed_x_x631_symbol : Boolean;
        signal type_cast_188_active_x_x632_symbol : Boolean;
        signal type_cast_188_trigger_x_x633_symbol : Boolean;
        signal type_cast_187_active_x_x634_symbol : Boolean;
        signal type_cast_187_trigger_x_x635_symbol : Boolean;
        signal simple_obj_ref_186_complete_636_symbol : Boolean;
        signal type_cast_187_complete_637_symbol : Boolean;
        signal type_cast_188_complete_644_symbol : Boolean;
        signal assign_stmt_193_active_x_x649_symbol : Boolean;
        signal assign_stmt_193_completed_x_x650_symbol : Boolean;
        signal simple_obj_ref_192_complete_651_symbol : Boolean;
        signal ptr_deref_191_trigger_x_x652_symbol : Boolean;
        signal ptr_deref_191_active_x_x653_symbol : Boolean;
        signal ptr_deref_191_base_address_calculated_654_symbol : Boolean;
        signal ptr_deref_191_root_address_calculated_655_symbol : Boolean;
        signal ptr_deref_191_word_address_calculated_656_symbol : Boolean;
        signal ptr_deref_191_request_657_symbol : Boolean;
        signal ptr_deref_191_complete_670_symbol : Boolean;
        signal assign_stmt_197_active_x_x681_symbol : Boolean;
        signal assign_stmt_197_completed_x_x682_symbol : Boolean;
        signal ptr_deref_196_trigger_x_x683_symbol : Boolean;
        signal ptr_deref_196_active_x_x684_symbol : Boolean;
        signal ptr_deref_196_base_address_calculated_685_symbol : Boolean;
        signal ptr_deref_196_root_address_calculated_686_symbol : Boolean;
        signal ptr_deref_196_word_address_calculated_687_symbol : Boolean;
        signal ptr_deref_196_request_688_symbol : Boolean;
        signal ptr_deref_196_complete_699_symbol : Boolean;
        signal assign_stmt_203_active_x_x712_symbol : Boolean;
        signal assign_stmt_203_completed_x_x713_symbol : Boolean;
        signal binary_202_active_x_x714_symbol : Boolean;
        signal binary_202_trigger_x_x715_symbol : Boolean;
        signal simple_obj_ref_199_complete_716_symbol : Boolean;
        signal binary_202_complete_717_symbol : Boolean;
        signal assign_stmt_207_active_x_x724_symbol : Boolean;
        signal assign_stmt_207_completed_x_x725_symbol : Boolean;
        signal ptr_deref_206_trigger_x_x726_symbol : Boolean;
        signal ptr_deref_206_active_x_x727_symbol : Boolean;
        signal ptr_deref_206_base_address_calculated_728_symbol : Boolean;
        signal ptr_deref_206_root_address_calculated_729_symbol : Boolean;
        signal ptr_deref_206_word_address_calculated_730_symbol : Boolean;
        signal ptr_deref_206_request_731_symbol : Boolean;
        signal ptr_deref_206_complete_742_symbol : Boolean;
        signal assign_stmt_213_active_x_x755_symbol : Boolean;
        signal assign_stmt_213_completed_x_x756_symbol : Boolean;
        signal binary_212_active_x_x757_symbol : Boolean;
        signal binary_212_trigger_x_x758_symbol : Boolean;
        signal simple_obj_ref_209_complete_759_symbol : Boolean;
        signal binary_212_complete_760_symbol : Boolean;
        signal assign_stmt_218_active_x_x767_symbol : Boolean;
        signal assign_stmt_218_completed_x_x768_symbol : Boolean;
        signal binary_217_active_x_x769_symbol : Boolean;
        signal binary_217_trigger_x_x770_symbol : Boolean;
        signal simple_obj_ref_215_complete_771_symbol : Boolean;
        signal simple_obj_ref_216_complete_772_symbol : Boolean;
        signal binary_217_complete_773_symbol : Boolean;
        signal assign_stmt_222_active_x_x780_symbol : Boolean;
        signal assign_stmt_222_completed_x_x781_symbol : Boolean;
        signal simple_obj_ref_221_complete_782_symbol : Boolean;
        signal ptr_deref_220_trigger_x_x783_symbol : Boolean;
        signal ptr_deref_220_active_x_x784_symbol : Boolean;
        signal ptr_deref_220_base_address_calculated_785_symbol : Boolean;
        signal ptr_deref_220_root_address_calculated_786_symbol : Boolean;
        signal ptr_deref_220_word_address_calculated_787_symbol : Boolean;
        signal ptr_deref_220_request_788_symbol : Boolean;
        signal ptr_deref_220_complete_801_symbol : Boolean;
        signal assign_stmt_227_active_x_x812_symbol : Boolean;
        signal assign_stmt_227_completed_x_x813_symbol : Boolean;
        signal ptr_deref_224_trigger_x_x814_symbol : Boolean;
        signal ptr_deref_224_active_x_x815_symbol : Boolean;
        signal ptr_deref_224_base_address_calculated_816_symbol : Boolean;
        signal ptr_deref_224_root_address_calculated_817_symbol : Boolean;
        signal ptr_deref_224_word_address_calculated_818_symbol : Boolean;
        signal ptr_deref_224_request_819_symbol : Boolean;
        signal ptr_deref_224_complete_832_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_113_to_assign_stmt_227_326_start <= assign_stmt_113_to_assign_stmt_227_x_xentry_x_xx_x30_symbol; -- control passed to block
        Xentry_327_symbol  <= assign_stmt_113_to_assign_stmt_227_326_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/$entry
        assign_stmt_113_active_x_x329_symbol <= ptr_deref_112_complete_347_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_113_active_
        assign_stmt_113_completed_x_x330_symbol <= assign_stmt_113_active_x_x329_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_113_completed_
        ptr_deref_112_trigger_x_x331_symbol <= ptr_deref_112_word_address_calculated_335_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_trigger_
        ptr_deref_112_active_x_x332_symbol <= ptr_deref_112_request_336_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_active_
        ptr_deref_112_base_address_calculated_333_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_base_address_calculated
        ptr_deref_112_root_address_calculated_334_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_root_address_calculated
        ptr_deref_112_word_address_calculated_335_symbol <= ptr_deref_112_root_address_calculated_334_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_word_address_calculated
        ptr_deref_112_request_336: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request 
          signal ptr_deref_112_request_336_start: Boolean;
          signal Xentry_337_symbol: Boolean;
          signal Xexit_338_symbol: Boolean;
          signal word_access_339_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_112_request_336_start <= ptr_deref_112_trigger_x_x331_symbol; -- control passed to block
          Xentry_337_symbol  <= ptr_deref_112_request_336_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/$entry
          word_access_339: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access 
            signal word_access_339_start: Boolean;
            signal Xentry_340_symbol: Boolean;
            signal Xexit_341_symbol: Boolean;
            signal word_access_0_342_symbol : Boolean;
            -- 
          begin -- 
            word_access_339_start <= Xentry_337_symbol; -- control passed to block
            Xentry_340_symbol  <= word_access_339_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/$entry
            word_access_0_342: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/word_access_0 
              signal word_access_0_342_start: Boolean;
              signal Xentry_343_symbol: Boolean;
              signal Xexit_344_symbol: Boolean;
              signal rr_345_symbol : Boolean;
              signal ra_346_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_342_start <= Xentry_340_symbol; -- control passed to block
              Xentry_343_symbol  <= word_access_0_342_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/word_access_0/$entry
              rr_345_symbol <= Xentry_343_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/word_access_0/rr
              ptr_deref_112_load_0_req_0 <= rr_345_symbol; -- link to DP
              ra_346_symbol <= ptr_deref_112_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/word_access_0/ra
              Xexit_344_symbol <= ra_346_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/word_access_0/$exit
              word_access_0_342_symbol <= Xexit_344_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/word_access_0
            Xexit_341_symbol <= word_access_0_342_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access/$exit
            word_access_339_symbol <= Xexit_341_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/word_access
          Xexit_338_symbol <= word_access_339_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request/$exit
          ptr_deref_112_request_336_symbol <= Xexit_338_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_request
        ptr_deref_112_complete_347: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete 
          signal ptr_deref_112_complete_347_start: Boolean;
          signal Xentry_348_symbol: Boolean;
          signal Xexit_349_symbol: Boolean;
          signal word_access_350_symbol : Boolean;
          signal merge_req_358_symbol : Boolean;
          signal merge_ack_359_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_112_complete_347_start <= ptr_deref_112_active_x_x332_symbol; -- control passed to block
          Xentry_348_symbol  <= ptr_deref_112_complete_347_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/$entry
          word_access_350: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access 
            signal word_access_350_start: Boolean;
            signal Xentry_351_symbol: Boolean;
            signal Xexit_352_symbol: Boolean;
            signal word_access_0_353_symbol : Boolean;
            -- 
          begin -- 
            word_access_350_start <= Xentry_348_symbol; -- control passed to block
            Xentry_351_symbol  <= word_access_350_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/$entry
            word_access_0_353: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/word_access_0 
              signal word_access_0_353_start: Boolean;
              signal Xentry_354_symbol: Boolean;
              signal Xexit_355_symbol: Boolean;
              signal cr_356_symbol : Boolean;
              signal ca_357_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_353_start <= Xentry_351_symbol; -- control passed to block
              Xentry_354_symbol  <= word_access_0_353_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/word_access_0/$entry
              cr_356_symbol <= Xentry_354_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/word_access_0/cr
              ptr_deref_112_load_0_req_1 <= cr_356_symbol; -- link to DP
              ca_357_symbol <= ptr_deref_112_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/word_access_0/ca
              Xexit_355_symbol <= ca_357_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/word_access_0/$exit
              word_access_0_353_symbol <= Xexit_355_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/word_access_0
            Xexit_352_symbol <= word_access_0_353_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access/$exit
            word_access_350_symbol <= Xexit_352_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/word_access
          merge_req_358_symbol <= word_access_350_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/merge_req
          ptr_deref_112_gather_scatter_req_0 <= merge_req_358_symbol; -- link to DP
          merge_ack_359_symbol <= ptr_deref_112_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/merge_ack
          Xexit_349_symbol <= merge_ack_359_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete/$exit
          ptr_deref_112_complete_347_symbol <= Xexit_349_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_112_complete
        assign_stmt_119_active_x_x360_symbol <= binary_118_complete_365_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_119_active_
        assign_stmt_119_completed_x_x361_symbol <= assign_stmt_119_active_x_x360_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_119_completed_
        binary_118_active_x_x362_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_active_ 
          signal binary_118_active_x_x362_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_118_active_x_x362_predecessors(0) <= binary_118_trigger_x_x363_symbol;
          binary_118_active_x_x362_predecessors(1) <= simple_obj_ref_115_complete_364_symbol;
          binary_118_active_x_x362_join: join -- 
            port map( -- 
              preds => binary_118_active_x_x362_predecessors,
              symbol_out => binary_118_active_x_x362_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_active_
        binary_118_trigger_x_x363_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_trigger_
        simple_obj_ref_115_complete_364_symbol <= assign_stmt_113_completed_x_x330_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_115_complete
        binary_118_complete_365: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete 
          signal binary_118_complete_365_start: Boolean;
          signal Xentry_366_symbol: Boolean;
          signal Xexit_367_symbol: Boolean;
          signal rr_368_symbol : Boolean;
          signal ra_369_symbol : Boolean;
          signal cr_370_symbol : Boolean;
          signal ca_371_symbol : Boolean;
          -- 
        begin -- 
          binary_118_complete_365_start <= binary_118_active_x_x362_symbol; -- control passed to block
          Xentry_366_symbol  <= binary_118_complete_365_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete/$entry
          rr_368_symbol <= Xentry_366_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete/rr
          binary_118_inst_req_0 <= rr_368_symbol; -- link to DP
          ra_369_symbol <= binary_118_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete/ra
          cr_370_symbol <= ra_369_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete/cr
          binary_118_inst_req_1 <= cr_370_symbol; -- link to DP
          ca_371_symbol <= binary_118_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete/ca
          Xexit_367_symbol <= ca_371_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete/$exit
          binary_118_complete_365_symbol <= Xexit_367_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_118_complete
        assign_stmt_123_active_x_x372_symbol <= simple_obj_ref_122_complete_374_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_123_active_
        assign_stmt_123_completed_x_x373_symbol <= ptr_deref_121_complete_393_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_123_completed_
        simple_obj_ref_122_complete_374_symbol <= assign_stmt_119_completed_x_x361_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_122_complete
        ptr_deref_121_trigger_x_x375_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_trigger_ 
          signal ptr_deref_121_trigger_x_x375_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_121_trigger_x_x375_predecessors(0) <= ptr_deref_121_word_address_calculated_379_symbol;
          ptr_deref_121_trigger_x_x375_predecessors(1) <= assign_stmt_123_active_x_x372_symbol;
          ptr_deref_121_trigger_x_x375_join: join -- 
            port map( -- 
              preds => ptr_deref_121_trigger_x_x375_predecessors,
              symbol_out => ptr_deref_121_trigger_x_x375_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_trigger_
        ptr_deref_121_active_x_x376_symbol <= ptr_deref_121_request_380_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_active_
        ptr_deref_121_base_address_calculated_377_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_base_address_calculated
        ptr_deref_121_root_address_calculated_378_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_root_address_calculated
        ptr_deref_121_word_address_calculated_379_symbol <= ptr_deref_121_root_address_calculated_378_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_word_address_calculated
        ptr_deref_121_request_380: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request 
          signal ptr_deref_121_request_380_start: Boolean;
          signal Xentry_381_symbol: Boolean;
          signal Xexit_382_symbol: Boolean;
          signal split_req_383_symbol : Boolean;
          signal split_ack_384_symbol : Boolean;
          signal word_access_385_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_121_request_380_start <= ptr_deref_121_trigger_x_x375_symbol; -- control passed to block
          Xentry_381_symbol  <= ptr_deref_121_request_380_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/$entry
          split_req_383_symbol <= Xentry_381_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/split_req
          ptr_deref_121_gather_scatter_req_0 <= split_req_383_symbol; -- link to DP
          split_ack_384_symbol <= ptr_deref_121_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/split_ack
          word_access_385: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access 
            signal word_access_385_start: Boolean;
            signal Xentry_386_symbol: Boolean;
            signal Xexit_387_symbol: Boolean;
            signal word_access_0_388_symbol : Boolean;
            -- 
          begin -- 
            word_access_385_start <= split_ack_384_symbol; -- control passed to block
            Xentry_386_symbol  <= word_access_385_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/$entry
            word_access_0_388: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/word_access_0 
              signal word_access_0_388_start: Boolean;
              signal Xentry_389_symbol: Boolean;
              signal Xexit_390_symbol: Boolean;
              signal rr_391_symbol : Boolean;
              signal ra_392_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_388_start <= Xentry_386_symbol; -- control passed to block
              Xentry_389_symbol  <= word_access_0_388_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/word_access_0/$entry
              rr_391_symbol <= Xentry_389_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/word_access_0/rr
              ptr_deref_121_store_0_req_0 <= rr_391_symbol; -- link to DP
              ra_392_symbol <= ptr_deref_121_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/word_access_0/ra
              Xexit_390_symbol <= ra_392_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/word_access_0/$exit
              word_access_0_388_symbol <= Xexit_390_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/word_access_0
            Xexit_387_symbol <= word_access_0_388_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access/$exit
            word_access_385_symbol <= Xexit_387_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/word_access
          Xexit_382_symbol <= word_access_385_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request/$exit
          ptr_deref_121_request_380_symbol <= Xexit_382_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_request
        ptr_deref_121_complete_393: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete 
          signal ptr_deref_121_complete_393_start: Boolean;
          signal Xentry_394_symbol: Boolean;
          signal Xexit_395_symbol: Boolean;
          signal word_access_396_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_121_complete_393_start <= ptr_deref_121_active_x_x376_symbol; -- control passed to block
          Xentry_394_symbol  <= ptr_deref_121_complete_393_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/$entry
          word_access_396: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access 
            signal word_access_396_start: Boolean;
            signal Xentry_397_symbol: Boolean;
            signal Xexit_398_symbol: Boolean;
            signal word_access_0_399_symbol : Boolean;
            -- 
          begin -- 
            word_access_396_start <= Xentry_394_symbol; -- control passed to block
            Xentry_397_symbol  <= word_access_396_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/$entry
            word_access_0_399: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/word_access_0 
              signal word_access_0_399_start: Boolean;
              signal Xentry_400_symbol: Boolean;
              signal Xexit_401_symbol: Boolean;
              signal cr_402_symbol : Boolean;
              signal ca_403_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_399_start <= Xentry_397_symbol; -- control passed to block
              Xentry_400_symbol  <= word_access_0_399_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/word_access_0/$entry
              cr_402_symbol <= Xentry_400_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/word_access_0/cr
              ptr_deref_121_store_0_req_1 <= cr_402_symbol; -- link to DP
              ca_403_symbol <= ptr_deref_121_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/word_access_0/ca
              Xexit_401_symbol <= ca_403_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/word_access_0/$exit
              word_access_0_399_symbol <= Xexit_401_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/word_access_0
            Xexit_398_symbol <= word_access_0_399_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access/$exit
            word_access_396_symbol <= Xexit_398_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/word_access
          Xexit_395_symbol <= word_access_396_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete/$exit
          ptr_deref_121_complete_393_symbol <= Xexit_395_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_121_complete
        assign_stmt_127_active_x_x404_symbol <= ptr_deref_126_complete_422_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_127_active_
        assign_stmt_127_completed_x_x405_symbol <= assign_stmt_127_active_x_x404_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_127_completed_
        ptr_deref_126_trigger_x_x406_symbol <= ptr_deref_126_word_address_calculated_410_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_trigger_
        ptr_deref_126_active_x_x407_symbol <= ptr_deref_126_request_411_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_active_
        ptr_deref_126_base_address_calculated_408_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_base_address_calculated
        ptr_deref_126_root_address_calculated_409_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_root_address_calculated
        ptr_deref_126_word_address_calculated_410_symbol <= ptr_deref_126_root_address_calculated_409_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_word_address_calculated
        ptr_deref_126_request_411: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request 
          signal ptr_deref_126_request_411_start: Boolean;
          signal Xentry_412_symbol: Boolean;
          signal Xexit_413_symbol: Boolean;
          signal word_access_414_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_126_request_411_start <= ptr_deref_126_trigger_x_x406_symbol; -- control passed to block
          Xentry_412_symbol  <= ptr_deref_126_request_411_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/$entry
          word_access_414: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access 
            signal word_access_414_start: Boolean;
            signal Xentry_415_symbol: Boolean;
            signal Xexit_416_symbol: Boolean;
            signal word_access_0_417_symbol : Boolean;
            -- 
          begin -- 
            word_access_414_start <= Xentry_412_symbol; -- control passed to block
            Xentry_415_symbol  <= word_access_414_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/$entry
            word_access_0_417: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/word_access_0 
              signal word_access_0_417_start: Boolean;
              signal Xentry_418_symbol: Boolean;
              signal Xexit_419_symbol: Boolean;
              signal rr_420_symbol : Boolean;
              signal ra_421_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_417_start <= Xentry_415_symbol; -- control passed to block
              Xentry_418_symbol  <= word_access_0_417_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/word_access_0/$entry
              rr_420_symbol <= Xentry_418_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/word_access_0/rr
              ptr_deref_126_load_0_req_0 <= rr_420_symbol; -- link to DP
              ra_421_symbol <= ptr_deref_126_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/word_access_0/ra
              Xexit_419_symbol <= ra_421_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/word_access_0/$exit
              word_access_0_417_symbol <= Xexit_419_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/word_access_0
            Xexit_416_symbol <= word_access_0_417_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access/$exit
            word_access_414_symbol <= Xexit_416_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/word_access
          Xexit_413_symbol <= word_access_414_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request/$exit
          ptr_deref_126_request_411_symbol <= Xexit_413_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_request
        ptr_deref_126_complete_422: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete 
          signal ptr_deref_126_complete_422_start: Boolean;
          signal Xentry_423_symbol: Boolean;
          signal Xexit_424_symbol: Boolean;
          signal word_access_425_symbol : Boolean;
          signal merge_req_433_symbol : Boolean;
          signal merge_ack_434_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_126_complete_422_start <= ptr_deref_126_active_x_x407_symbol; -- control passed to block
          Xentry_423_symbol  <= ptr_deref_126_complete_422_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/$entry
          word_access_425: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access 
            signal word_access_425_start: Boolean;
            signal Xentry_426_symbol: Boolean;
            signal Xexit_427_symbol: Boolean;
            signal word_access_0_428_symbol : Boolean;
            -- 
          begin -- 
            word_access_425_start <= Xentry_423_symbol; -- control passed to block
            Xentry_426_symbol  <= word_access_425_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/$entry
            word_access_0_428: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/word_access_0 
              signal word_access_0_428_start: Boolean;
              signal Xentry_429_symbol: Boolean;
              signal Xexit_430_symbol: Boolean;
              signal cr_431_symbol : Boolean;
              signal ca_432_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_428_start <= Xentry_426_symbol; -- control passed to block
              Xentry_429_symbol  <= word_access_0_428_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/word_access_0/$entry
              cr_431_symbol <= Xentry_429_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/word_access_0/cr
              ptr_deref_126_load_0_req_1 <= cr_431_symbol; -- link to DP
              ca_432_symbol <= ptr_deref_126_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/word_access_0/ca
              Xexit_430_symbol <= ca_432_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/word_access_0/$exit
              word_access_0_428_symbol <= Xexit_430_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/word_access_0
            Xexit_427_symbol <= word_access_0_428_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access/$exit
            word_access_425_symbol <= Xexit_427_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/word_access
          merge_req_433_symbol <= word_access_425_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/merge_req
          ptr_deref_126_gather_scatter_req_0 <= merge_req_433_symbol; -- link to DP
          merge_ack_434_symbol <= ptr_deref_126_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/merge_ack
          Xexit_424_symbol <= merge_ack_434_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete/$exit
          ptr_deref_126_complete_422_symbol <= Xexit_424_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_126_complete
        assign_stmt_133_active_x_x435_symbol <= binary_132_complete_440_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_133_active_
        assign_stmt_133_completed_x_x436_symbol <= assign_stmt_133_active_x_x435_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_133_completed_
        binary_132_active_x_x437_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_active_ 
          signal binary_132_active_x_x437_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_132_active_x_x437_predecessors(0) <= binary_132_trigger_x_x438_symbol;
          binary_132_active_x_x437_predecessors(1) <= simple_obj_ref_129_complete_439_symbol;
          binary_132_active_x_x437_join: join -- 
            port map( -- 
              preds => binary_132_active_x_x437_predecessors,
              symbol_out => binary_132_active_x_x437_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_active_
        binary_132_trigger_x_x438_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_trigger_
        simple_obj_ref_129_complete_439_symbol <= assign_stmt_127_completed_x_x405_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_129_complete
        binary_132_complete_440: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete 
          signal binary_132_complete_440_start: Boolean;
          signal Xentry_441_symbol: Boolean;
          signal Xexit_442_symbol: Boolean;
          signal rr_443_symbol : Boolean;
          signal ra_444_symbol : Boolean;
          signal cr_445_symbol : Boolean;
          signal ca_446_symbol : Boolean;
          -- 
        begin -- 
          binary_132_complete_440_start <= binary_132_active_x_x437_symbol; -- control passed to block
          Xentry_441_symbol  <= binary_132_complete_440_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete/$entry
          rr_443_symbol <= Xentry_441_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete/rr
          binary_132_inst_req_0 <= rr_443_symbol; -- link to DP
          ra_444_symbol <= binary_132_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete/ra
          cr_445_symbol <= ra_444_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete/cr
          binary_132_inst_req_1 <= cr_445_symbol; -- link to DP
          ca_446_symbol <= binary_132_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete/ca
          Xexit_442_symbol <= ca_446_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete/$exit
          binary_132_complete_440_symbol <= Xexit_442_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_132_complete
        assign_stmt_137_active_x_x447_symbol <= type_cast_136_complete_452_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_137_active_
        assign_stmt_137_completed_x_x448_symbol <= assign_stmt_137_active_x_x447_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_137_completed_
        type_cast_136_active_x_x449_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_active_ 
          signal type_cast_136_active_x_x449_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_136_active_x_x449_predecessors(0) <= type_cast_136_trigger_x_x450_symbol;
          type_cast_136_active_x_x449_predecessors(1) <= simple_obj_ref_135_complete_451_symbol;
          type_cast_136_active_x_x449_join: join -- 
            port map( -- 
              preds => type_cast_136_active_x_x449_predecessors,
              symbol_out => type_cast_136_active_x_x449_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_active_
        type_cast_136_trigger_x_x450_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_trigger_
        simple_obj_ref_135_complete_451_symbol <= assign_stmt_133_completed_x_x436_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_135_complete
        type_cast_136_complete_452: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_complete 
          signal type_cast_136_complete_452_start: Boolean;
          signal Xentry_453_symbol: Boolean;
          signal Xexit_454_symbol: Boolean;
          signal req_455_symbol : Boolean;
          signal ack_456_symbol : Boolean;
          -- 
        begin -- 
          type_cast_136_complete_452_start <= type_cast_136_active_x_x449_symbol; -- control passed to block
          Xentry_453_symbol  <= type_cast_136_complete_452_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_complete/$entry
          req_455_symbol <= Xentry_453_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_complete/req
          type_cast_136_inst_req_0 <= req_455_symbol; -- link to DP
          ack_456_symbol <= type_cast_136_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_complete/ack
          Xexit_454_symbol <= ack_456_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_complete/$exit
          type_cast_136_complete_452_symbol <= Xexit_454_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_136_complete
        assign_stmt_141_active_x_x457_symbol <= simple_obj_ref_140_complete_459_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_141_active_
        assign_stmt_141_completed_x_x458_symbol <= ptr_deref_139_complete_478_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_141_completed_
        simple_obj_ref_140_complete_459_symbol <= assign_stmt_137_completed_x_x448_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_140_complete
        ptr_deref_139_trigger_x_x460_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_trigger_ 
          signal ptr_deref_139_trigger_x_x460_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_139_trigger_x_x460_predecessors(0) <= ptr_deref_139_word_address_calculated_464_symbol;
          ptr_deref_139_trigger_x_x460_predecessors(1) <= assign_stmt_141_active_x_x457_symbol;
          ptr_deref_139_trigger_x_x460_join: join -- 
            port map( -- 
              preds => ptr_deref_139_trigger_x_x460_predecessors,
              symbol_out => ptr_deref_139_trigger_x_x460_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_trigger_
        ptr_deref_139_active_x_x461_symbol <= ptr_deref_139_request_465_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_active_
        ptr_deref_139_base_address_calculated_462_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_base_address_calculated
        ptr_deref_139_root_address_calculated_463_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_root_address_calculated
        ptr_deref_139_word_address_calculated_464_symbol <= ptr_deref_139_root_address_calculated_463_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_word_address_calculated
        ptr_deref_139_request_465: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request 
          signal ptr_deref_139_request_465_start: Boolean;
          signal Xentry_466_symbol: Boolean;
          signal Xexit_467_symbol: Boolean;
          signal split_req_468_symbol : Boolean;
          signal split_ack_469_symbol : Boolean;
          signal word_access_470_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_139_request_465_start <= ptr_deref_139_trigger_x_x460_symbol; -- control passed to block
          Xentry_466_symbol  <= ptr_deref_139_request_465_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/$entry
          split_req_468_symbol <= Xentry_466_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/split_req
          ptr_deref_139_gather_scatter_req_0 <= split_req_468_symbol; -- link to DP
          split_ack_469_symbol <= ptr_deref_139_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/split_ack
          word_access_470: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access 
            signal word_access_470_start: Boolean;
            signal Xentry_471_symbol: Boolean;
            signal Xexit_472_symbol: Boolean;
            signal word_access_0_473_symbol : Boolean;
            -- 
          begin -- 
            word_access_470_start <= split_ack_469_symbol; -- control passed to block
            Xentry_471_symbol  <= word_access_470_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/$entry
            word_access_0_473: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/word_access_0 
              signal word_access_0_473_start: Boolean;
              signal Xentry_474_symbol: Boolean;
              signal Xexit_475_symbol: Boolean;
              signal rr_476_symbol : Boolean;
              signal ra_477_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_473_start <= Xentry_471_symbol; -- control passed to block
              Xentry_474_symbol  <= word_access_0_473_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/word_access_0/$entry
              rr_476_symbol <= Xentry_474_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/word_access_0/rr
              ptr_deref_139_store_0_req_0 <= rr_476_symbol; -- link to DP
              ra_477_symbol <= ptr_deref_139_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/word_access_0/ra
              Xexit_475_symbol <= ra_477_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/word_access_0/$exit
              word_access_0_473_symbol <= Xexit_475_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/word_access_0
            Xexit_472_symbol <= word_access_0_473_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access/$exit
            word_access_470_symbol <= Xexit_472_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/word_access
          Xexit_467_symbol <= word_access_470_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request/$exit
          ptr_deref_139_request_465_symbol <= Xexit_467_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_request
        ptr_deref_139_complete_478: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete 
          signal ptr_deref_139_complete_478_start: Boolean;
          signal Xentry_479_symbol: Boolean;
          signal Xexit_480_symbol: Boolean;
          signal word_access_481_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_139_complete_478_start <= ptr_deref_139_active_x_x461_symbol; -- control passed to block
          Xentry_479_symbol  <= ptr_deref_139_complete_478_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/$entry
          word_access_481: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access 
            signal word_access_481_start: Boolean;
            signal Xentry_482_symbol: Boolean;
            signal Xexit_483_symbol: Boolean;
            signal word_access_0_484_symbol : Boolean;
            -- 
          begin -- 
            word_access_481_start <= Xentry_479_symbol; -- control passed to block
            Xentry_482_symbol  <= word_access_481_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/$entry
            word_access_0_484: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/word_access_0 
              signal word_access_0_484_start: Boolean;
              signal Xentry_485_symbol: Boolean;
              signal Xexit_486_symbol: Boolean;
              signal cr_487_symbol : Boolean;
              signal ca_488_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_484_start <= Xentry_482_symbol; -- control passed to block
              Xentry_485_symbol  <= word_access_0_484_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/word_access_0/$entry
              cr_487_symbol <= Xentry_485_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/word_access_0/cr
              ptr_deref_139_store_0_req_1 <= cr_487_symbol; -- link to DP
              ca_488_symbol <= ptr_deref_139_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/word_access_0/ca
              Xexit_486_symbol <= ca_488_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/word_access_0/$exit
              word_access_0_484_symbol <= Xexit_486_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/word_access_0
            Xexit_483_symbol <= word_access_0_484_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access/$exit
            word_access_481_symbol <= Xexit_483_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/word_access
          Xexit_480_symbol <= word_access_481_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete/$exit
          ptr_deref_139_complete_478_symbol <= Xexit_480_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_139_complete
        assign_stmt_145_active_x_x489_symbol <= ptr_deref_144_complete_507_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_145_active_
        assign_stmt_145_completed_x_x490_symbol <= assign_stmt_145_active_x_x489_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_145_completed_
        ptr_deref_144_trigger_x_x491_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_trigger_ 
          signal ptr_deref_144_trigger_x_x491_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_144_trigger_x_x491_predecessors(0) <= ptr_deref_144_word_address_calculated_495_symbol;
          ptr_deref_144_trigger_x_x491_predecessors(1) <= ptr_deref_121_active_x_x376_symbol;
          ptr_deref_144_trigger_x_x491_join: join -- 
            port map( -- 
              preds => ptr_deref_144_trigger_x_x491_predecessors,
              symbol_out => ptr_deref_144_trigger_x_x491_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_trigger_
        ptr_deref_144_active_x_x492_symbol <= ptr_deref_144_request_496_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_active_
        ptr_deref_144_base_address_calculated_493_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_base_address_calculated
        ptr_deref_144_root_address_calculated_494_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_root_address_calculated
        ptr_deref_144_word_address_calculated_495_symbol <= ptr_deref_144_root_address_calculated_494_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_word_address_calculated
        ptr_deref_144_request_496: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request 
          signal ptr_deref_144_request_496_start: Boolean;
          signal Xentry_497_symbol: Boolean;
          signal Xexit_498_symbol: Boolean;
          signal word_access_499_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_144_request_496_start <= ptr_deref_144_trigger_x_x491_symbol; -- control passed to block
          Xentry_497_symbol  <= ptr_deref_144_request_496_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/$entry
          word_access_499: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access 
            signal word_access_499_start: Boolean;
            signal Xentry_500_symbol: Boolean;
            signal Xexit_501_symbol: Boolean;
            signal word_access_0_502_symbol : Boolean;
            -- 
          begin -- 
            word_access_499_start <= Xentry_497_symbol; -- control passed to block
            Xentry_500_symbol  <= word_access_499_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/$entry
            word_access_0_502: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/word_access_0 
              signal word_access_0_502_start: Boolean;
              signal Xentry_503_symbol: Boolean;
              signal Xexit_504_symbol: Boolean;
              signal rr_505_symbol : Boolean;
              signal ra_506_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_502_start <= Xentry_500_symbol; -- control passed to block
              Xentry_503_symbol  <= word_access_0_502_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/word_access_0/$entry
              rr_505_symbol <= Xentry_503_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/word_access_0/rr
              ptr_deref_144_load_0_req_0 <= rr_505_symbol; -- link to DP
              ra_506_symbol <= ptr_deref_144_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/word_access_0/ra
              Xexit_504_symbol <= ra_506_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/word_access_0/$exit
              word_access_0_502_symbol <= Xexit_504_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/word_access_0
            Xexit_501_symbol <= word_access_0_502_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access/$exit
            word_access_499_symbol <= Xexit_501_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/word_access
          Xexit_498_symbol <= word_access_499_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request/$exit
          ptr_deref_144_request_496_symbol <= Xexit_498_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_request
        ptr_deref_144_complete_507: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete 
          signal ptr_deref_144_complete_507_start: Boolean;
          signal Xentry_508_symbol: Boolean;
          signal Xexit_509_symbol: Boolean;
          signal word_access_510_symbol : Boolean;
          signal merge_req_518_symbol : Boolean;
          signal merge_ack_519_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_144_complete_507_start <= ptr_deref_144_active_x_x492_symbol; -- control passed to block
          Xentry_508_symbol  <= ptr_deref_144_complete_507_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/$entry
          word_access_510: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access 
            signal word_access_510_start: Boolean;
            signal Xentry_511_symbol: Boolean;
            signal Xexit_512_symbol: Boolean;
            signal word_access_0_513_symbol : Boolean;
            -- 
          begin -- 
            word_access_510_start <= Xentry_508_symbol; -- control passed to block
            Xentry_511_symbol  <= word_access_510_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/$entry
            word_access_0_513: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/word_access_0 
              signal word_access_0_513_start: Boolean;
              signal Xentry_514_symbol: Boolean;
              signal Xexit_515_symbol: Boolean;
              signal cr_516_symbol : Boolean;
              signal ca_517_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_513_start <= Xentry_511_symbol; -- control passed to block
              Xentry_514_symbol  <= word_access_0_513_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/word_access_0/$entry
              cr_516_symbol <= Xentry_514_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/word_access_0/cr
              ptr_deref_144_load_0_req_1 <= cr_516_symbol; -- link to DP
              ca_517_symbol <= ptr_deref_144_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/word_access_0/ca
              Xexit_515_symbol <= ca_517_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/word_access_0/$exit
              word_access_0_513_symbol <= Xexit_515_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/word_access_0
            Xexit_512_symbol <= word_access_0_513_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access/$exit
            word_access_510_symbol <= Xexit_512_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/word_access
          merge_req_518_symbol <= word_access_510_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/merge_req
          ptr_deref_144_gather_scatter_req_0 <= merge_req_518_symbol; -- link to DP
          merge_ack_519_symbol <= ptr_deref_144_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/merge_ack
          Xexit_509_symbol <= merge_ack_519_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete/$exit
          ptr_deref_144_complete_507_symbol <= Xexit_509_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_144_complete
        assign_stmt_154_active_x_x520_symbol <= binary_153_complete_532_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_154_active_
        assign_stmt_154_completed_x_x521_symbol <= assign_stmt_154_active_x_x520_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_154_completed_
        binary_153_active_x_x522_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_active_ 
          signal binary_153_active_x_x522_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_153_active_x_x522_predecessors(0) <= binary_153_trigger_x_x523_symbol;
          binary_153_active_x_x522_predecessors(1) <= type_cast_149_complete_527_symbol;
          binary_153_active_x_x522_join: join -- 
            port map( -- 
              preds => binary_153_active_x_x522_predecessors,
              symbol_out => binary_153_active_x_x522_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_active_
        binary_153_trigger_x_x523_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_trigger_
        type_cast_149_active_x_x524_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_active_ 
          signal type_cast_149_active_x_x524_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_149_active_x_x524_predecessors(0) <= type_cast_149_trigger_x_x525_symbol;
          type_cast_149_active_x_x524_predecessors(1) <= simple_obj_ref_148_complete_526_symbol;
          type_cast_149_active_x_x524_join: join -- 
            port map( -- 
              preds => type_cast_149_active_x_x524_predecessors,
              symbol_out => type_cast_149_active_x_x524_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_active_
        type_cast_149_trigger_x_x525_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_trigger_
        simple_obj_ref_148_complete_526_symbol <= assign_stmt_145_completed_x_x490_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_148_complete
        type_cast_149_complete_527: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_complete 
          signal type_cast_149_complete_527_start: Boolean;
          signal Xentry_528_symbol: Boolean;
          signal Xexit_529_symbol: Boolean;
          signal req_530_symbol : Boolean;
          signal ack_531_symbol : Boolean;
          -- 
        begin -- 
          type_cast_149_complete_527_start <= type_cast_149_active_x_x524_symbol; -- control passed to block
          Xentry_528_symbol  <= type_cast_149_complete_527_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_complete/$entry
          req_530_symbol <= Xentry_528_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_complete/req
          type_cast_149_inst_req_0 <= req_530_symbol; -- link to DP
          ack_531_symbol <= type_cast_149_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_complete/ack
          Xexit_529_symbol <= ack_531_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_complete/$exit
          type_cast_149_complete_527_symbol <= Xexit_529_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_149_complete
        binary_153_complete_532: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete 
          signal binary_153_complete_532_start: Boolean;
          signal Xentry_533_symbol: Boolean;
          signal Xexit_534_symbol: Boolean;
          signal rr_535_symbol : Boolean;
          signal ra_536_symbol : Boolean;
          signal cr_537_symbol : Boolean;
          signal ca_538_symbol : Boolean;
          -- 
        begin -- 
          binary_153_complete_532_start <= binary_153_active_x_x522_symbol; -- control passed to block
          Xentry_533_symbol  <= binary_153_complete_532_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete/$entry
          rr_535_symbol <= Xentry_533_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete/rr
          binary_153_inst_req_0 <= rr_535_symbol; -- link to DP
          ra_536_symbol <= binary_153_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete/ra
          cr_537_symbol <= ra_536_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete/cr
          binary_153_inst_req_1 <= cr_537_symbol; -- link to DP
          ca_538_symbol <= binary_153_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete/ca
          Xexit_534_symbol <= ca_538_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete/$exit
          binary_153_complete_532_symbol <= Xexit_534_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_153_complete
        assign_stmt_158_active_x_x539_symbol <= ptr_deref_157_complete_557_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_158_active_
        assign_stmt_158_completed_x_x540_symbol <= assign_stmt_158_active_x_x539_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_158_completed_
        ptr_deref_157_trigger_x_x541_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_trigger_ 
          signal ptr_deref_157_trigger_x_x541_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_157_trigger_x_x541_predecessors(0) <= ptr_deref_157_word_address_calculated_545_symbol;
          ptr_deref_157_trigger_x_x541_predecessors(1) <= ptr_deref_139_active_x_x461_symbol;
          ptr_deref_157_trigger_x_x541_join: join -- 
            port map( -- 
              preds => ptr_deref_157_trigger_x_x541_predecessors,
              symbol_out => ptr_deref_157_trigger_x_x541_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_trigger_
        ptr_deref_157_active_x_x542_symbol <= ptr_deref_157_request_546_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_active_
        ptr_deref_157_base_address_calculated_543_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_base_address_calculated
        ptr_deref_157_root_address_calculated_544_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_root_address_calculated
        ptr_deref_157_word_address_calculated_545_symbol <= ptr_deref_157_root_address_calculated_544_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_word_address_calculated
        ptr_deref_157_request_546: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request 
          signal ptr_deref_157_request_546_start: Boolean;
          signal Xentry_547_symbol: Boolean;
          signal Xexit_548_symbol: Boolean;
          signal word_access_549_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_157_request_546_start <= ptr_deref_157_trigger_x_x541_symbol; -- control passed to block
          Xentry_547_symbol  <= ptr_deref_157_request_546_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/$entry
          word_access_549: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access 
            signal word_access_549_start: Boolean;
            signal Xentry_550_symbol: Boolean;
            signal Xexit_551_symbol: Boolean;
            signal word_access_0_552_symbol : Boolean;
            -- 
          begin -- 
            word_access_549_start <= Xentry_547_symbol; -- control passed to block
            Xentry_550_symbol  <= word_access_549_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/$entry
            word_access_0_552: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/word_access_0 
              signal word_access_0_552_start: Boolean;
              signal Xentry_553_symbol: Boolean;
              signal Xexit_554_symbol: Boolean;
              signal rr_555_symbol : Boolean;
              signal ra_556_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_552_start <= Xentry_550_symbol; -- control passed to block
              Xentry_553_symbol  <= word_access_0_552_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/word_access_0/$entry
              rr_555_symbol <= Xentry_553_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/word_access_0/rr
              ptr_deref_157_load_0_req_0 <= rr_555_symbol; -- link to DP
              ra_556_symbol <= ptr_deref_157_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/word_access_0/ra
              Xexit_554_symbol <= ra_556_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/word_access_0/$exit
              word_access_0_552_symbol <= Xexit_554_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/word_access_0
            Xexit_551_symbol <= word_access_0_552_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access/$exit
            word_access_549_symbol <= Xexit_551_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/word_access
          Xexit_548_symbol <= word_access_549_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request/$exit
          ptr_deref_157_request_546_symbol <= Xexit_548_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_request
        ptr_deref_157_complete_557: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete 
          signal ptr_deref_157_complete_557_start: Boolean;
          signal Xentry_558_symbol: Boolean;
          signal Xexit_559_symbol: Boolean;
          signal word_access_560_symbol : Boolean;
          signal merge_req_568_symbol : Boolean;
          signal merge_ack_569_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_157_complete_557_start <= ptr_deref_157_active_x_x542_symbol; -- control passed to block
          Xentry_558_symbol  <= ptr_deref_157_complete_557_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/$entry
          word_access_560: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access 
            signal word_access_560_start: Boolean;
            signal Xentry_561_symbol: Boolean;
            signal Xexit_562_symbol: Boolean;
            signal word_access_0_563_symbol : Boolean;
            -- 
          begin -- 
            word_access_560_start <= Xentry_558_symbol; -- control passed to block
            Xentry_561_symbol  <= word_access_560_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/$entry
            word_access_0_563: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/word_access_0 
              signal word_access_0_563_start: Boolean;
              signal Xentry_564_symbol: Boolean;
              signal Xexit_565_symbol: Boolean;
              signal cr_566_symbol : Boolean;
              signal ca_567_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_563_start <= Xentry_561_symbol; -- control passed to block
              Xentry_564_symbol  <= word_access_0_563_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/word_access_0/$entry
              cr_566_symbol <= Xentry_564_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/word_access_0/cr
              ptr_deref_157_load_0_req_1 <= cr_566_symbol; -- link to DP
              ca_567_symbol <= ptr_deref_157_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/word_access_0/ca
              Xexit_565_symbol <= ca_567_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/word_access_0/$exit
              word_access_0_563_symbol <= Xexit_565_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/word_access_0
            Xexit_562_symbol <= word_access_0_563_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access/$exit
            word_access_560_symbol <= Xexit_562_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/word_access
          merge_req_568_symbol <= word_access_560_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/merge_req
          ptr_deref_157_gather_scatter_req_0 <= merge_req_568_symbol; -- link to DP
          merge_ack_569_symbol <= ptr_deref_157_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/merge_ack
          Xexit_559_symbol <= merge_ack_569_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete/$exit
          ptr_deref_157_complete_557_symbol <= Xexit_559_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_157_complete
        assign_stmt_162_active_x_x570_symbol <= type_cast_161_complete_575_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_162_active_
        assign_stmt_162_completed_x_x571_symbol <= assign_stmt_162_active_x_x570_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_162_completed_
        type_cast_161_active_x_x572_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_active_ 
          signal type_cast_161_active_x_x572_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_161_active_x_x572_predecessors(0) <= type_cast_161_trigger_x_x573_symbol;
          type_cast_161_active_x_x572_predecessors(1) <= simple_obj_ref_160_complete_574_symbol;
          type_cast_161_active_x_x572_join: join -- 
            port map( -- 
              preds => type_cast_161_active_x_x572_predecessors,
              symbol_out => type_cast_161_active_x_x572_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_active_
        type_cast_161_trigger_x_x573_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_trigger_
        simple_obj_ref_160_complete_574_symbol <= assign_stmt_158_completed_x_x540_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_160_complete
        type_cast_161_complete_575: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_complete 
          signal type_cast_161_complete_575_start: Boolean;
          signal Xentry_576_symbol: Boolean;
          signal Xexit_577_symbol: Boolean;
          signal req_578_symbol : Boolean;
          signal ack_579_symbol : Boolean;
          -- 
        begin -- 
          type_cast_161_complete_575_start <= type_cast_161_active_x_x572_symbol; -- control passed to block
          Xentry_576_symbol  <= type_cast_161_complete_575_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_complete/$entry
          req_578_symbol <= Xentry_576_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_complete/req
          type_cast_161_inst_req_0 <= req_578_symbol; -- link to DP
          ack_579_symbol <= type_cast_161_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_complete/ack
          Xexit_577_symbol <= ack_579_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_complete/$exit
          type_cast_161_complete_575_symbol <= Xexit_577_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_161_complete
        assign_stmt_172_active_x_x580_symbol <= type_cast_171_complete_601_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_172_active_
        assign_stmt_172_completed_x_x581_symbol <= assign_stmt_172_active_x_x580_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_172_completed_
        type_cast_171_active_x_x582_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_active_ 
          signal type_cast_171_active_x_x582_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_171_active_x_x582_predecessors(0) <= type_cast_171_trigger_x_x583_symbol;
          type_cast_171_active_x_x582_predecessors(1) <= binary_170_complete_594_symbol;
          type_cast_171_active_x_x582_join: join -- 
            port map( -- 
              preds => type_cast_171_active_x_x582_predecessors,
              symbol_out => type_cast_171_active_x_x582_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_active_
        type_cast_171_trigger_x_x583_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_trigger_
        binary_170_active_x_x584_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_active_ 
          signal binary_170_active_x_x584_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_170_active_x_x584_predecessors(0) <= binary_170_trigger_x_x585_symbol;
          binary_170_active_x_x584_predecessors(1) <= type_cast_166_complete_589_symbol;
          binary_170_active_x_x584_join: join -- 
            port map( -- 
              preds => binary_170_active_x_x584_predecessors,
              symbol_out => binary_170_active_x_x584_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_active_
        binary_170_trigger_x_x585_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_trigger_
        type_cast_166_active_x_x586_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_active_ 
          signal type_cast_166_active_x_x586_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_166_active_x_x586_predecessors(0) <= type_cast_166_trigger_x_x587_symbol;
          type_cast_166_active_x_x586_predecessors(1) <= simple_obj_ref_165_complete_588_symbol;
          type_cast_166_active_x_x586_join: join -- 
            port map( -- 
              preds => type_cast_166_active_x_x586_predecessors,
              symbol_out => type_cast_166_active_x_x586_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_active_
        type_cast_166_trigger_x_x587_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_trigger_
        simple_obj_ref_165_complete_588_symbol <= assign_stmt_162_completed_x_x571_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_165_complete
        type_cast_166_complete_589: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_complete 
          signal type_cast_166_complete_589_start: Boolean;
          signal Xentry_590_symbol: Boolean;
          signal Xexit_591_symbol: Boolean;
          signal req_592_symbol : Boolean;
          signal ack_593_symbol : Boolean;
          -- 
        begin -- 
          type_cast_166_complete_589_start <= type_cast_166_active_x_x586_symbol; -- control passed to block
          Xentry_590_symbol  <= type_cast_166_complete_589_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_complete/$entry
          req_592_symbol <= Xentry_590_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_complete/req
          type_cast_166_inst_req_0 <= req_592_symbol; -- link to DP
          ack_593_symbol <= type_cast_166_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_complete/ack
          Xexit_591_symbol <= ack_593_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_complete/$exit
          type_cast_166_complete_589_symbol <= Xexit_591_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_166_complete
        binary_170_complete_594: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete 
          signal binary_170_complete_594_start: Boolean;
          signal Xentry_595_symbol: Boolean;
          signal Xexit_596_symbol: Boolean;
          signal rr_597_symbol : Boolean;
          signal ra_598_symbol : Boolean;
          signal cr_599_symbol : Boolean;
          signal ca_600_symbol : Boolean;
          -- 
        begin -- 
          binary_170_complete_594_start <= binary_170_active_x_x584_symbol; -- control passed to block
          Xentry_595_symbol  <= binary_170_complete_594_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete/$entry
          rr_597_symbol <= Xentry_595_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete/rr
          binary_170_inst_req_0 <= rr_597_symbol; -- link to DP
          ra_598_symbol <= binary_170_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete/ra
          cr_599_symbol <= ra_598_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete/cr
          binary_170_inst_req_1 <= cr_599_symbol; -- link to DP
          ca_600_symbol <= binary_170_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete/ca
          Xexit_596_symbol <= ca_600_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete/$exit
          binary_170_complete_594_symbol <= Xexit_596_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_170_complete
        type_cast_171_complete_601: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_complete 
          signal type_cast_171_complete_601_start: Boolean;
          signal Xentry_602_symbol: Boolean;
          signal Xexit_603_symbol: Boolean;
          signal req_604_symbol : Boolean;
          signal ack_605_symbol : Boolean;
          -- 
        begin -- 
          type_cast_171_complete_601_start <= type_cast_171_active_x_x582_symbol; -- control passed to block
          Xentry_602_symbol  <= type_cast_171_complete_601_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_complete/$entry
          req_604_symbol <= Xentry_602_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_complete/req
          type_cast_171_inst_req_0 <= req_604_symbol; -- link to DP
          ack_605_symbol <= type_cast_171_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_complete/ack
          Xexit_603_symbol <= ack_605_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_complete/$exit
          type_cast_171_complete_601_symbol <= Xexit_603_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_171_complete
        assign_stmt_178_active_x_x606_symbol <= binary_177_complete_611_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_178_active_
        assign_stmt_178_completed_x_x607_symbol <= assign_stmt_178_active_x_x606_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_178_completed_
        binary_177_active_x_x608_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_active_ 
          signal binary_177_active_x_x608_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_177_active_x_x608_predecessors(0) <= binary_177_trigger_x_x609_symbol;
          binary_177_active_x_x608_predecessors(1) <= simple_obj_ref_174_complete_610_symbol;
          binary_177_active_x_x608_join: join -- 
            port map( -- 
              preds => binary_177_active_x_x608_predecessors,
              symbol_out => binary_177_active_x_x608_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_active_
        binary_177_trigger_x_x609_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_trigger_
        simple_obj_ref_174_complete_610_symbol <= assign_stmt_162_completed_x_x571_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_174_complete
        binary_177_complete_611: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete 
          signal binary_177_complete_611_start: Boolean;
          signal Xentry_612_symbol: Boolean;
          signal Xexit_613_symbol: Boolean;
          signal rr_614_symbol : Boolean;
          signal ra_615_symbol : Boolean;
          signal cr_616_symbol : Boolean;
          signal ca_617_symbol : Boolean;
          -- 
        begin -- 
          binary_177_complete_611_start <= binary_177_active_x_x608_symbol; -- control passed to block
          Xentry_612_symbol  <= binary_177_complete_611_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete/$entry
          rr_614_symbol <= Xentry_612_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete/rr
          binary_177_inst_req_0 <= rr_614_symbol; -- link to DP
          ra_615_symbol <= binary_177_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete/ra
          cr_616_symbol <= ra_615_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete/cr
          binary_177_inst_req_1 <= cr_616_symbol; -- link to DP
          ca_617_symbol <= binary_177_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete/ca
          Xexit_613_symbol <= ca_617_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete/$exit
          binary_177_complete_611_symbol <= Xexit_613_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_177_complete
        assign_stmt_184_active_x_x618_symbol <= ternary_183_complete_625_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_184_active_
        assign_stmt_184_completed_x_x619_symbol <= assign_stmt_184_active_x_x618_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_184_completed_
        ternary_183_trigger_x_x620_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_trigger_
        ternary_183_active_x_x621_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_active_ 
          signal ternary_183_active_x_x621_predecessors: BooleanArray(3 downto 0);
          -- 
        begin -- 
          ternary_183_active_x_x621_predecessors(0) <= ternary_183_trigger_x_x620_symbol;
          ternary_183_active_x_x621_predecessors(1) <= simple_obj_ref_180_complete_622_symbol;
          ternary_183_active_x_x621_predecessors(2) <= simple_obj_ref_181_complete_623_symbol;
          ternary_183_active_x_x621_predecessors(3) <= simple_obj_ref_182_complete_624_symbol;
          ternary_183_active_x_x621_join: join -- 
            port map( -- 
              preds => ternary_183_active_x_x621_predecessors,
              symbol_out => ternary_183_active_x_x621_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_active_
        simple_obj_ref_180_complete_622_symbol <= assign_stmt_154_completed_x_x521_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_180_complete
        simple_obj_ref_181_complete_623_symbol <= assign_stmt_172_completed_x_x581_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_181_complete
        simple_obj_ref_182_complete_624_symbol <= assign_stmt_178_completed_x_x607_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_182_complete
        ternary_183_complete_625: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_complete 
          signal ternary_183_complete_625_start: Boolean;
          signal Xentry_626_symbol: Boolean;
          signal Xexit_627_symbol: Boolean;
          signal req_628_symbol : Boolean;
          signal ack_629_symbol : Boolean;
          -- 
        begin -- 
          ternary_183_complete_625_start <= ternary_183_active_x_x621_symbol; -- control passed to block
          Xentry_626_symbol  <= ternary_183_complete_625_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_complete/$entry
          req_628_symbol <= Xentry_626_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_complete/req
          ternary_183_inst_req_0 <= req_628_symbol; -- link to DP
          ack_629_symbol <= ternary_183_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_complete/ack
          Xexit_627_symbol <= ack_629_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_complete/$exit
          ternary_183_complete_625_symbol <= Xexit_627_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ternary_183_complete
        assign_stmt_189_active_x_x630_symbol <= type_cast_188_complete_644_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_189_active_
        assign_stmt_189_completed_x_x631_symbol <= assign_stmt_189_active_x_x630_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_189_completed_
        type_cast_188_active_x_x632_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_active_ 
          signal type_cast_188_active_x_x632_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_188_active_x_x632_predecessors(0) <= type_cast_188_trigger_x_x633_symbol;
          type_cast_188_active_x_x632_predecessors(1) <= type_cast_187_complete_637_symbol;
          type_cast_188_active_x_x632_join: join -- 
            port map( -- 
              preds => type_cast_188_active_x_x632_predecessors,
              symbol_out => type_cast_188_active_x_x632_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_active_
        type_cast_188_trigger_x_x633_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_trigger_
        type_cast_187_active_x_x634_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_active_ 
          signal type_cast_187_active_x_x634_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_187_active_x_x634_predecessors(0) <= type_cast_187_trigger_x_x635_symbol;
          type_cast_187_active_x_x634_predecessors(1) <= simple_obj_ref_186_complete_636_symbol;
          type_cast_187_active_x_x634_join: join -- 
            port map( -- 
              preds => type_cast_187_active_x_x634_predecessors,
              symbol_out => type_cast_187_active_x_x634_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_active_
        type_cast_187_trigger_x_x635_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_trigger_
        simple_obj_ref_186_complete_636_symbol <= assign_stmt_184_completed_x_x619_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_186_complete
        type_cast_187_complete_637: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete 
          signal type_cast_187_complete_637_start: Boolean;
          signal Xentry_638_symbol: Boolean;
          signal Xexit_639_symbol: Boolean;
          signal rr_640_symbol : Boolean;
          signal ra_641_symbol : Boolean;
          signal cr_642_symbol : Boolean;
          signal ca_643_symbol : Boolean;
          -- 
        begin -- 
          type_cast_187_complete_637_start <= type_cast_187_active_x_x634_symbol; -- control passed to block
          Xentry_638_symbol  <= type_cast_187_complete_637_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete/$entry
          rr_640_symbol <= Xentry_638_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete/rr
          type_cast_187_inst_req_0 <= rr_640_symbol; -- link to DP
          ra_641_symbol <= type_cast_187_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete/ra
          cr_642_symbol <= ra_641_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete/cr
          type_cast_187_inst_req_1 <= cr_642_symbol; -- link to DP
          ca_643_symbol <= type_cast_187_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete/ca
          Xexit_639_symbol <= ca_643_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete/$exit
          type_cast_187_complete_637_symbol <= Xexit_639_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_187_complete
        type_cast_188_complete_644: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_complete 
          signal type_cast_188_complete_644_start: Boolean;
          signal Xentry_645_symbol: Boolean;
          signal Xexit_646_symbol: Boolean;
          signal req_647_symbol : Boolean;
          signal ack_648_symbol : Boolean;
          -- 
        begin -- 
          type_cast_188_complete_644_start <= type_cast_188_active_x_x632_symbol; -- control passed to block
          Xentry_645_symbol  <= type_cast_188_complete_644_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_complete/$entry
          req_647_symbol <= Xentry_645_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_complete/req
          type_cast_188_inst_req_0 <= req_647_symbol; -- link to DP
          ack_648_symbol <= type_cast_188_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_complete/ack
          Xexit_646_symbol <= ack_648_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_complete/$exit
          type_cast_188_complete_644_symbol <= Xexit_646_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/type_cast_188_complete
        assign_stmt_193_active_x_x649_symbol <= simple_obj_ref_192_complete_651_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_193_active_
        assign_stmt_193_completed_x_x650_symbol <= ptr_deref_191_complete_670_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_193_completed_
        simple_obj_ref_192_complete_651_symbol <= assign_stmt_189_completed_x_x631_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_192_complete
        ptr_deref_191_trigger_x_x652_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_trigger_ 
          signal ptr_deref_191_trigger_x_x652_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_191_trigger_x_x652_predecessors(0) <= ptr_deref_191_word_address_calculated_656_symbol;
          ptr_deref_191_trigger_x_x652_predecessors(1) <= assign_stmt_193_active_x_x649_symbol;
          ptr_deref_191_trigger_x_x652_join: join -- 
            port map( -- 
              preds => ptr_deref_191_trigger_x_x652_predecessors,
              symbol_out => ptr_deref_191_trigger_x_x652_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_trigger_
        ptr_deref_191_active_x_x653_symbol <= ptr_deref_191_request_657_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_active_
        ptr_deref_191_base_address_calculated_654_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_base_address_calculated
        ptr_deref_191_root_address_calculated_655_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_root_address_calculated
        ptr_deref_191_word_address_calculated_656_symbol <= ptr_deref_191_root_address_calculated_655_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_word_address_calculated
        ptr_deref_191_request_657: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request 
          signal ptr_deref_191_request_657_start: Boolean;
          signal Xentry_658_symbol: Boolean;
          signal Xexit_659_symbol: Boolean;
          signal split_req_660_symbol : Boolean;
          signal split_ack_661_symbol : Boolean;
          signal word_access_662_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_191_request_657_start <= ptr_deref_191_trigger_x_x652_symbol; -- control passed to block
          Xentry_658_symbol  <= ptr_deref_191_request_657_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/$entry
          split_req_660_symbol <= Xentry_658_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/split_req
          ptr_deref_191_gather_scatter_req_0 <= split_req_660_symbol; -- link to DP
          split_ack_661_symbol <= ptr_deref_191_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/split_ack
          word_access_662: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access 
            signal word_access_662_start: Boolean;
            signal Xentry_663_symbol: Boolean;
            signal Xexit_664_symbol: Boolean;
            signal word_access_0_665_symbol : Boolean;
            -- 
          begin -- 
            word_access_662_start <= split_ack_661_symbol; -- control passed to block
            Xentry_663_symbol  <= word_access_662_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/$entry
            word_access_0_665: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/word_access_0 
              signal word_access_0_665_start: Boolean;
              signal Xentry_666_symbol: Boolean;
              signal Xexit_667_symbol: Boolean;
              signal rr_668_symbol : Boolean;
              signal ra_669_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_665_start <= Xentry_663_symbol; -- control passed to block
              Xentry_666_symbol  <= word_access_0_665_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/word_access_0/$entry
              rr_668_symbol <= Xentry_666_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/word_access_0/rr
              ptr_deref_191_store_0_req_0 <= rr_668_symbol; -- link to DP
              ra_669_symbol <= ptr_deref_191_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/word_access_0/ra
              Xexit_667_symbol <= ra_669_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/word_access_0/$exit
              word_access_0_665_symbol <= Xexit_667_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/word_access_0
            Xexit_664_symbol <= word_access_0_665_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access/$exit
            word_access_662_symbol <= Xexit_664_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/word_access
          Xexit_659_symbol <= word_access_662_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request/$exit
          ptr_deref_191_request_657_symbol <= Xexit_659_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_request
        ptr_deref_191_complete_670: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete 
          signal ptr_deref_191_complete_670_start: Boolean;
          signal Xentry_671_symbol: Boolean;
          signal Xexit_672_symbol: Boolean;
          signal word_access_673_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_191_complete_670_start <= ptr_deref_191_active_x_x653_symbol; -- control passed to block
          Xentry_671_symbol  <= ptr_deref_191_complete_670_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/$entry
          word_access_673: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access 
            signal word_access_673_start: Boolean;
            signal Xentry_674_symbol: Boolean;
            signal Xexit_675_symbol: Boolean;
            signal word_access_0_676_symbol : Boolean;
            -- 
          begin -- 
            word_access_673_start <= Xentry_671_symbol; -- control passed to block
            Xentry_674_symbol  <= word_access_673_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/$entry
            word_access_0_676: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/word_access_0 
              signal word_access_0_676_start: Boolean;
              signal Xentry_677_symbol: Boolean;
              signal Xexit_678_symbol: Boolean;
              signal cr_679_symbol : Boolean;
              signal ca_680_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_676_start <= Xentry_674_symbol; -- control passed to block
              Xentry_677_symbol  <= word_access_0_676_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/word_access_0/$entry
              cr_679_symbol <= Xentry_677_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/word_access_0/cr
              ptr_deref_191_store_0_req_1 <= cr_679_symbol; -- link to DP
              ca_680_symbol <= ptr_deref_191_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/word_access_0/ca
              Xexit_678_symbol <= ca_680_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/word_access_0/$exit
              word_access_0_676_symbol <= Xexit_678_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/word_access_0
            Xexit_675_symbol <= word_access_0_676_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access/$exit
            word_access_673_symbol <= Xexit_675_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/word_access
          Xexit_672_symbol <= word_access_673_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete/$exit
          ptr_deref_191_complete_670_symbol <= Xexit_672_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_191_complete
        assign_stmt_197_active_x_x681_symbol <= ptr_deref_196_complete_699_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_197_active_
        assign_stmt_197_completed_x_x682_symbol <= assign_stmt_197_active_x_x681_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_197_completed_
        ptr_deref_196_trigger_x_x683_symbol <= ptr_deref_196_word_address_calculated_687_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_trigger_
        ptr_deref_196_active_x_x684_symbol <= ptr_deref_196_request_688_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_active_
        ptr_deref_196_base_address_calculated_685_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_base_address_calculated
        ptr_deref_196_root_address_calculated_686_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_root_address_calculated
        ptr_deref_196_word_address_calculated_687_symbol <= ptr_deref_196_root_address_calculated_686_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_word_address_calculated
        ptr_deref_196_request_688: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request 
          signal ptr_deref_196_request_688_start: Boolean;
          signal Xentry_689_symbol: Boolean;
          signal Xexit_690_symbol: Boolean;
          signal word_access_691_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_196_request_688_start <= ptr_deref_196_trigger_x_x683_symbol; -- control passed to block
          Xentry_689_symbol  <= ptr_deref_196_request_688_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/$entry
          word_access_691: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access 
            signal word_access_691_start: Boolean;
            signal Xentry_692_symbol: Boolean;
            signal Xexit_693_symbol: Boolean;
            signal word_access_0_694_symbol : Boolean;
            -- 
          begin -- 
            word_access_691_start <= Xentry_689_symbol; -- control passed to block
            Xentry_692_symbol  <= word_access_691_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/$entry
            word_access_0_694: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/word_access_0 
              signal word_access_0_694_start: Boolean;
              signal Xentry_695_symbol: Boolean;
              signal Xexit_696_symbol: Boolean;
              signal rr_697_symbol : Boolean;
              signal ra_698_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_694_start <= Xentry_692_symbol; -- control passed to block
              Xentry_695_symbol  <= word_access_0_694_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/word_access_0/$entry
              rr_697_symbol <= Xentry_695_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/word_access_0/rr
              ptr_deref_196_load_0_req_0 <= rr_697_symbol; -- link to DP
              ra_698_symbol <= ptr_deref_196_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/word_access_0/ra
              Xexit_696_symbol <= ra_698_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/word_access_0/$exit
              word_access_0_694_symbol <= Xexit_696_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/word_access_0
            Xexit_693_symbol <= word_access_0_694_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access/$exit
            word_access_691_symbol <= Xexit_693_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/word_access
          Xexit_690_symbol <= word_access_691_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request/$exit
          ptr_deref_196_request_688_symbol <= Xexit_690_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_request
        ptr_deref_196_complete_699: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete 
          signal ptr_deref_196_complete_699_start: Boolean;
          signal Xentry_700_symbol: Boolean;
          signal Xexit_701_symbol: Boolean;
          signal word_access_702_symbol : Boolean;
          signal merge_req_710_symbol : Boolean;
          signal merge_ack_711_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_196_complete_699_start <= ptr_deref_196_active_x_x684_symbol; -- control passed to block
          Xentry_700_symbol  <= ptr_deref_196_complete_699_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/$entry
          word_access_702: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access 
            signal word_access_702_start: Boolean;
            signal Xentry_703_symbol: Boolean;
            signal Xexit_704_symbol: Boolean;
            signal word_access_0_705_symbol : Boolean;
            -- 
          begin -- 
            word_access_702_start <= Xentry_700_symbol; -- control passed to block
            Xentry_703_symbol  <= word_access_702_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/$entry
            word_access_0_705: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/word_access_0 
              signal word_access_0_705_start: Boolean;
              signal Xentry_706_symbol: Boolean;
              signal Xexit_707_symbol: Boolean;
              signal cr_708_symbol : Boolean;
              signal ca_709_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_705_start <= Xentry_703_symbol; -- control passed to block
              Xentry_706_symbol  <= word_access_0_705_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/word_access_0/$entry
              cr_708_symbol <= Xentry_706_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/word_access_0/cr
              ptr_deref_196_load_0_req_1 <= cr_708_symbol; -- link to DP
              ca_709_symbol <= ptr_deref_196_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/word_access_0/ca
              Xexit_707_symbol <= ca_709_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/word_access_0/$exit
              word_access_0_705_symbol <= Xexit_707_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/word_access_0
            Xexit_704_symbol <= word_access_0_705_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access/$exit
            word_access_702_symbol <= Xexit_704_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/word_access
          merge_req_710_symbol <= word_access_702_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/merge_req
          ptr_deref_196_gather_scatter_req_0 <= merge_req_710_symbol; -- link to DP
          merge_ack_711_symbol <= ptr_deref_196_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/merge_ack
          Xexit_701_symbol <= merge_ack_711_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete/$exit
          ptr_deref_196_complete_699_symbol <= Xexit_701_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_196_complete
        assign_stmt_203_active_x_x712_symbol <= binary_202_complete_717_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_203_active_
        assign_stmt_203_completed_x_x713_symbol <= assign_stmt_203_active_x_x712_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_203_completed_
        binary_202_active_x_x714_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_active_ 
          signal binary_202_active_x_x714_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_202_active_x_x714_predecessors(0) <= binary_202_trigger_x_x715_symbol;
          binary_202_active_x_x714_predecessors(1) <= simple_obj_ref_199_complete_716_symbol;
          binary_202_active_x_x714_join: join -- 
            port map( -- 
              preds => binary_202_active_x_x714_predecessors,
              symbol_out => binary_202_active_x_x714_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_active_
        binary_202_trigger_x_x715_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_trigger_
        simple_obj_ref_199_complete_716_symbol <= assign_stmt_197_completed_x_x682_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_199_complete
        binary_202_complete_717: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete 
          signal binary_202_complete_717_start: Boolean;
          signal Xentry_718_symbol: Boolean;
          signal Xexit_719_symbol: Boolean;
          signal rr_720_symbol : Boolean;
          signal ra_721_symbol : Boolean;
          signal cr_722_symbol : Boolean;
          signal ca_723_symbol : Boolean;
          -- 
        begin -- 
          binary_202_complete_717_start <= binary_202_active_x_x714_symbol; -- control passed to block
          Xentry_718_symbol  <= binary_202_complete_717_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete/$entry
          rr_720_symbol <= Xentry_718_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete/rr
          binary_202_inst_req_0 <= rr_720_symbol; -- link to DP
          ra_721_symbol <= binary_202_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete/ra
          cr_722_symbol <= ra_721_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete/cr
          binary_202_inst_req_1 <= cr_722_symbol; -- link to DP
          ca_723_symbol <= binary_202_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete/ca
          Xexit_719_symbol <= ca_723_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete/$exit
          binary_202_complete_717_symbol <= Xexit_719_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_202_complete
        assign_stmt_207_active_x_x724_symbol <= ptr_deref_206_complete_742_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_207_active_
        assign_stmt_207_completed_x_x725_symbol <= assign_stmt_207_active_x_x724_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_207_completed_
        ptr_deref_206_trigger_x_x726_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_trigger_ 
          signal ptr_deref_206_trigger_x_x726_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_206_trigger_x_x726_predecessors(0) <= ptr_deref_206_word_address_calculated_730_symbol;
          ptr_deref_206_trigger_x_x726_predecessors(1) <= ptr_deref_191_active_x_x653_symbol;
          ptr_deref_206_trigger_x_x726_join: join -- 
            port map( -- 
              preds => ptr_deref_206_trigger_x_x726_predecessors,
              symbol_out => ptr_deref_206_trigger_x_x726_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_trigger_
        ptr_deref_206_active_x_x727_symbol <= ptr_deref_206_request_731_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_active_
        ptr_deref_206_base_address_calculated_728_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_base_address_calculated
        ptr_deref_206_root_address_calculated_729_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_root_address_calculated
        ptr_deref_206_word_address_calculated_730_symbol <= ptr_deref_206_root_address_calculated_729_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_word_address_calculated
        ptr_deref_206_request_731: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request 
          signal ptr_deref_206_request_731_start: Boolean;
          signal Xentry_732_symbol: Boolean;
          signal Xexit_733_symbol: Boolean;
          signal word_access_734_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_206_request_731_start <= ptr_deref_206_trigger_x_x726_symbol; -- control passed to block
          Xentry_732_symbol  <= ptr_deref_206_request_731_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/$entry
          word_access_734: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access 
            signal word_access_734_start: Boolean;
            signal Xentry_735_symbol: Boolean;
            signal Xexit_736_symbol: Boolean;
            signal word_access_0_737_symbol : Boolean;
            -- 
          begin -- 
            word_access_734_start <= Xentry_732_symbol; -- control passed to block
            Xentry_735_symbol  <= word_access_734_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/$entry
            word_access_0_737: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/word_access_0 
              signal word_access_0_737_start: Boolean;
              signal Xentry_738_symbol: Boolean;
              signal Xexit_739_symbol: Boolean;
              signal rr_740_symbol : Boolean;
              signal ra_741_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_737_start <= Xentry_735_symbol; -- control passed to block
              Xentry_738_symbol  <= word_access_0_737_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/word_access_0/$entry
              rr_740_symbol <= Xentry_738_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/word_access_0/rr
              ptr_deref_206_load_0_req_0 <= rr_740_symbol; -- link to DP
              ra_741_symbol <= ptr_deref_206_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/word_access_0/ra
              Xexit_739_symbol <= ra_741_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/word_access_0/$exit
              word_access_0_737_symbol <= Xexit_739_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/word_access_0
            Xexit_736_symbol <= word_access_0_737_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access/$exit
            word_access_734_symbol <= Xexit_736_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/word_access
          Xexit_733_symbol <= word_access_734_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request/$exit
          ptr_deref_206_request_731_symbol <= Xexit_733_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_request
        ptr_deref_206_complete_742: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete 
          signal ptr_deref_206_complete_742_start: Boolean;
          signal Xentry_743_symbol: Boolean;
          signal Xexit_744_symbol: Boolean;
          signal word_access_745_symbol : Boolean;
          signal merge_req_753_symbol : Boolean;
          signal merge_ack_754_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_206_complete_742_start <= ptr_deref_206_active_x_x727_symbol; -- control passed to block
          Xentry_743_symbol  <= ptr_deref_206_complete_742_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/$entry
          word_access_745: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access 
            signal word_access_745_start: Boolean;
            signal Xentry_746_symbol: Boolean;
            signal Xexit_747_symbol: Boolean;
            signal word_access_0_748_symbol : Boolean;
            -- 
          begin -- 
            word_access_745_start <= Xentry_743_symbol; -- control passed to block
            Xentry_746_symbol  <= word_access_745_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/$entry
            word_access_0_748: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/word_access_0 
              signal word_access_0_748_start: Boolean;
              signal Xentry_749_symbol: Boolean;
              signal Xexit_750_symbol: Boolean;
              signal cr_751_symbol : Boolean;
              signal ca_752_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_748_start <= Xentry_746_symbol; -- control passed to block
              Xentry_749_symbol  <= word_access_0_748_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/word_access_0/$entry
              cr_751_symbol <= Xentry_749_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/word_access_0/cr
              ptr_deref_206_load_0_req_1 <= cr_751_symbol; -- link to DP
              ca_752_symbol <= ptr_deref_206_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/word_access_0/ca
              Xexit_750_symbol <= ca_752_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/word_access_0/$exit
              word_access_0_748_symbol <= Xexit_750_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/word_access_0
            Xexit_747_symbol <= word_access_0_748_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access/$exit
            word_access_745_symbol <= Xexit_747_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/word_access
          merge_req_753_symbol <= word_access_745_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/merge_req
          ptr_deref_206_gather_scatter_req_0 <= merge_req_753_symbol; -- link to DP
          merge_ack_754_symbol <= ptr_deref_206_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/merge_ack
          Xexit_744_symbol <= merge_ack_754_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete/$exit
          ptr_deref_206_complete_742_symbol <= Xexit_744_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_206_complete
        assign_stmt_213_active_x_x755_symbol <= binary_212_complete_760_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_213_active_
        assign_stmt_213_completed_x_x756_symbol <= assign_stmt_213_active_x_x755_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_213_completed_
        binary_212_active_x_x757_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_active_ 
          signal binary_212_active_x_x757_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_212_active_x_x757_predecessors(0) <= binary_212_trigger_x_x758_symbol;
          binary_212_active_x_x757_predecessors(1) <= simple_obj_ref_209_complete_759_symbol;
          binary_212_active_x_x757_join: join -- 
            port map( -- 
              preds => binary_212_active_x_x757_predecessors,
              symbol_out => binary_212_active_x_x757_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_active_
        binary_212_trigger_x_x758_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_trigger_
        simple_obj_ref_209_complete_759_symbol <= assign_stmt_207_completed_x_x725_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_209_complete
        binary_212_complete_760: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete 
          signal binary_212_complete_760_start: Boolean;
          signal Xentry_761_symbol: Boolean;
          signal Xexit_762_symbol: Boolean;
          signal rr_763_symbol : Boolean;
          signal ra_764_symbol : Boolean;
          signal cr_765_symbol : Boolean;
          signal ca_766_symbol : Boolean;
          -- 
        begin -- 
          binary_212_complete_760_start <= binary_212_active_x_x757_symbol; -- control passed to block
          Xentry_761_symbol  <= binary_212_complete_760_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete/$entry
          rr_763_symbol <= Xentry_761_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete/rr
          binary_212_inst_req_0 <= rr_763_symbol; -- link to DP
          ra_764_symbol <= binary_212_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete/ra
          cr_765_symbol <= ra_764_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete/cr
          binary_212_inst_req_1 <= cr_765_symbol; -- link to DP
          ca_766_symbol <= binary_212_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete/ca
          Xexit_762_symbol <= ca_766_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete/$exit
          binary_212_complete_760_symbol <= Xexit_762_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_212_complete
        assign_stmt_218_active_x_x767_symbol <= binary_217_complete_773_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_218_active_
        assign_stmt_218_completed_x_x768_symbol <= assign_stmt_218_active_x_x767_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_218_completed_
        binary_217_active_x_x769_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_active_ 
          signal binary_217_active_x_x769_predecessors: BooleanArray(2 downto 0);
          -- 
        begin -- 
          binary_217_active_x_x769_predecessors(0) <= binary_217_trigger_x_x770_symbol;
          binary_217_active_x_x769_predecessors(1) <= simple_obj_ref_215_complete_771_symbol;
          binary_217_active_x_x769_predecessors(2) <= simple_obj_ref_216_complete_772_symbol;
          binary_217_active_x_x769_join: join -- 
            port map( -- 
              preds => binary_217_active_x_x769_predecessors,
              symbol_out => binary_217_active_x_x769_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_active_
        binary_217_trigger_x_x770_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_trigger_
        simple_obj_ref_215_complete_771_symbol <= assign_stmt_203_completed_x_x713_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_215_complete
        simple_obj_ref_216_complete_772_symbol <= assign_stmt_213_completed_x_x756_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_216_complete
        binary_217_complete_773: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete 
          signal binary_217_complete_773_start: Boolean;
          signal Xentry_774_symbol: Boolean;
          signal Xexit_775_symbol: Boolean;
          signal rr_776_symbol : Boolean;
          signal ra_777_symbol : Boolean;
          signal cr_778_symbol : Boolean;
          signal ca_779_symbol : Boolean;
          -- 
        begin -- 
          binary_217_complete_773_start <= binary_217_active_x_x769_symbol; -- control passed to block
          Xentry_774_symbol  <= binary_217_complete_773_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete/$entry
          rr_776_symbol <= Xentry_774_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete/rr
          binary_217_inst_req_0 <= rr_776_symbol; -- link to DP
          ra_777_symbol <= binary_217_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete/ra
          cr_778_symbol <= ra_777_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete/cr
          binary_217_inst_req_1 <= cr_778_symbol; -- link to DP
          ca_779_symbol <= binary_217_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete/ca
          Xexit_775_symbol <= ca_779_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete/$exit
          binary_217_complete_773_symbol <= Xexit_775_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/binary_217_complete
        assign_stmt_222_active_x_x780_symbol <= simple_obj_ref_221_complete_782_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_222_active_
        assign_stmt_222_completed_x_x781_symbol <= ptr_deref_220_complete_801_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_222_completed_
        simple_obj_ref_221_complete_782_symbol <= assign_stmt_218_completed_x_x768_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/simple_obj_ref_221_complete
        ptr_deref_220_trigger_x_x783_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_trigger_ 
          signal ptr_deref_220_trigger_x_x783_predecessors: BooleanArray(4 downto 0);
          -- 
        begin -- 
          ptr_deref_220_trigger_x_x783_predecessors(0) <= ptr_deref_220_word_address_calculated_787_symbol;
          ptr_deref_220_trigger_x_x783_predecessors(1) <= assign_stmt_222_active_x_x780_symbol;
          ptr_deref_220_trigger_x_x783_predecessors(2) <= ptr_deref_112_active_x_x332_symbol;
          ptr_deref_220_trigger_x_x783_predecessors(3) <= ptr_deref_126_active_x_x407_symbol;
          ptr_deref_220_trigger_x_x783_predecessors(4) <= ptr_deref_196_active_x_x684_symbol;
          ptr_deref_220_trigger_x_x783_join: join -- 
            port map( -- 
              preds => ptr_deref_220_trigger_x_x783_predecessors,
              symbol_out => ptr_deref_220_trigger_x_x783_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_trigger_
        ptr_deref_220_active_x_x784_symbol <= ptr_deref_220_request_788_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_active_
        ptr_deref_220_base_address_calculated_785_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_base_address_calculated
        ptr_deref_220_root_address_calculated_786_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_root_address_calculated
        ptr_deref_220_word_address_calculated_787_symbol <= ptr_deref_220_root_address_calculated_786_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_word_address_calculated
        ptr_deref_220_request_788: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request 
          signal ptr_deref_220_request_788_start: Boolean;
          signal Xentry_789_symbol: Boolean;
          signal Xexit_790_symbol: Boolean;
          signal split_req_791_symbol : Boolean;
          signal split_ack_792_symbol : Boolean;
          signal word_access_793_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_220_request_788_start <= ptr_deref_220_trigger_x_x783_symbol; -- control passed to block
          Xentry_789_symbol  <= ptr_deref_220_request_788_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/$entry
          split_req_791_symbol <= Xentry_789_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/split_req
          ptr_deref_220_gather_scatter_req_0 <= split_req_791_symbol; -- link to DP
          split_ack_792_symbol <= ptr_deref_220_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/split_ack
          word_access_793: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access 
            signal word_access_793_start: Boolean;
            signal Xentry_794_symbol: Boolean;
            signal Xexit_795_symbol: Boolean;
            signal word_access_0_796_symbol : Boolean;
            -- 
          begin -- 
            word_access_793_start <= split_ack_792_symbol; -- control passed to block
            Xentry_794_symbol  <= word_access_793_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/$entry
            word_access_0_796: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/word_access_0 
              signal word_access_0_796_start: Boolean;
              signal Xentry_797_symbol: Boolean;
              signal Xexit_798_symbol: Boolean;
              signal rr_799_symbol : Boolean;
              signal ra_800_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_796_start <= Xentry_794_symbol; -- control passed to block
              Xentry_797_symbol  <= word_access_0_796_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/word_access_0/$entry
              rr_799_symbol <= Xentry_797_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/word_access_0/rr
              ptr_deref_220_store_0_req_0 <= rr_799_symbol; -- link to DP
              ra_800_symbol <= ptr_deref_220_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/word_access_0/ra
              Xexit_798_symbol <= ra_800_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/word_access_0/$exit
              word_access_0_796_symbol <= Xexit_798_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/word_access_0
            Xexit_795_symbol <= word_access_0_796_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access/$exit
            word_access_793_symbol <= Xexit_795_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/word_access
          Xexit_790_symbol <= word_access_793_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request/$exit
          ptr_deref_220_request_788_symbol <= Xexit_790_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_request
        ptr_deref_220_complete_801: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete 
          signal ptr_deref_220_complete_801_start: Boolean;
          signal Xentry_802_symbol: Boolean;
          signal Xexit_803_symbol: Boolean;
          signal word_access_804_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_220_complete_801_start <= ptr_deref_220_active_x_x784_symbol; -- control passed to block
          Xentry_802_symbol  <= ptr_deref_220_complete_801_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/$entry
          word_access_804: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access 
            signal word_access_804_start: Boolean;
            signal Xentry_805_symbol: Boolean;
            signal Xexit_806_symbol: Boolean;
            signal word_access_0_807_symbol : Boolean;
            -- 
          begin -- 
            word_access_804_start <= Xentry_802_symbol; -- control passed to block
            Xentry_805_symbol  <= word_access_804_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/$entry
            word_access_0_807: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/word_access_0 
              signal word_access_0_807_start: Boolean;
              signal Xentry_808_symbol: Boolean;
              signal Xexit_809_symbol: Boolean;
              signal cr_810_symbol : Boolean;
              signal ca_811_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_807_start <= Xentry_805_symbol; -- control passed to block
              Xentry_808_symbol  <= word_access_0_807_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/word_access_0/$entry
              cr_810_symbol <= Xentry_808_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/word_access_0/cr
              ptr_deref_220_store_0_req_1 <= cr_810_symbol; -- link to DP
              ca_811_symbol <= ptr_deref_220_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/word_access_0/ca
              Xexit_809_symbol <= ca_811_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/word_access_0/$exit
              word_access_0_807_symbol <= Xexit_809_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/word_access_0
            Xexit_806_symbol <= word_access_0_807_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access/$exit
            word_access_804_symbol <= Xexit_806_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/word_access
          Xexit_803_symbol <= word_access_804_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete/$exit
          ptr_deref_220_complete_801_symbol <= Xexit_803_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_220_complete
        assign_stmt_227_active_x_x812_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_227_active_
        assign_stmt_227_completed_x_x813_symbol <= ptr_deref_224_complete_832_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/assign_stmt_227_completed_
        ptr_deref_224_trigger_x_x814_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_trigger_ 
          signal ptr_deref_224_trigger_x_x814_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_224_trigger_x_x814_predecessors(0) <= ptr_deref_224_word_address_calculated_818_symbol;
          ptr_deref_224_trigger_x_x814_predecessors(1) <= assign_stmt_227_active_x_x812_symbol;
          ptr_deref_224_trigger_x_x814_join: join -- 
            port map( -- 
              preds => ptr_deref_224_trigger_x_x814_predecessors,
              symbol_out => ptr_deref_224_trigger_x_x814_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_trigger_
        ptr_deref_224_active_x_x815_symbol <= ptr_deref_224_request_819_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_active_
        ptr_deref_224_base_address_calculated_816_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_base_address_calculated
        ptr_deref_224_root_address_calculated_817_symbol <= Xentry_327_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_root_address_calculated
        ptr_deref_224_word_address_calculated_818_symbol <= ptr_deref_224_root_address_calculated_817_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_word_address_calculated
        ptr_deref_224_request_819: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request 
          signal ptr_deref_224_request_819_start: Boolean;
          signal Xentry_820_symbol: Boolean;
          signal Xexit_821_symbol: Boolean;
          signal split_req_822_symbol : Boolean;
          signal split_ack_823_symbol : Boolean;
          signal word_access_824_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_224_request_819_start <= ptr_deref_224_trigger_x_x814_symbol; -- control passed to block
          Xentry_820_symbol  <= ptr_deref_224_request_819_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/$entry
          split_req_822_symbol <= Xentry_820_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/split_req
          ptr_deref_224_gather_scatter_req_0 <= split_req_822_symbol; -- link to DP
          split_ack_823_symbol <= ptr_deref_224_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/split_ack
          word_access_824: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access 
            signal word_access_824_start: Boolean;
            signal Xentry_825_symbol: Boolean;
            signal Xexit_826_symbol: Boolean;
            signal word_access_0_827_symbol : Boolean;
            -- 
          begin -- 
            word_access_824_start <= split_ack_823_symbol; -- control passed to block
            Xentry_825_symbol  <= word_access_824_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/$entry
            word_access_0_827: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/word_access_0 
              signal word_access_0_827_start: Boolean;
              signal Xentry_828_symbol: Boolean;
              signal Xexit_829_symbol: Boolean;
              signal rr_830_symbol : Boolean;
              signal ra_831_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_827_start <= Xentry_825_symbol; -- control passed to block
              Xentry_828_symbol  <= word_access_0_827_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/word_access_0/$entry
              rr_830_symbol <= Xentry_828_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/word_access_0/rr
              ptr_deref_224_store_0_req_0 <= rr_830_symbol; -- link to DP
              ra_831_symbol <= ptr_deref_224_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/word_access_0/ra
              Xexit_829_symbol <= ra_831_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/word_access_0/$exit
              word_access_0_827_symbol <= Xexit_829_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/word_access_0
            Xexit_826_symbol <= word_access_0_827_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access/$exit
            word_access_824_symbol <= Xexit_826_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/word_access
          Xexit_821_symbol <= word_access_824_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request/$exit
          ptr_deref_224_request_819_symbol <= Xexit_821_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_request
        ptr_deref_224_complete_832: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete 
          signal ptr_deref_224_complete_832_start: Boolean;
          signal Xentry_833_symbol: Boolean;
          signal Xexit_834_symbol: Boolean;
          signal word_access_835_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_224_complete_832_start <= ptr_deref_224_active_x_x815_symbol; -- control passed to block
          Xentry_833_symbol  <= ptr_deref_224_complete_832_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/$entry
          word_access_835: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access 
            signal word_access_835_start: Boolean;
            signal Xentry_836_symbol: Boolean;
            signal Xexit_837_symbol: Boolean;
            signal word_access_0_838_symbol : Boolean;
            -- 
          begin -- 
            word_access_835_start <= Xentry_833_symbol; -- control passed to block
            Xentry_836_symbol  <= word_access_835_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/$entry
            word_access_0_838: Block -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/word_access_0 
              signal word_access_0_838_start: Boolean;
              signal Xentry_839_symbol: Boolean;
              signal Xexit_840_symbol: Boolean;
              signal cr_841_symbol : Boolean;
              signal ca_842_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_838_start <= Xentry_836_symbol; -- control passed to block
              Xentry_839_symbol  <= word_access_0_838_start; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/word_access_0/$entry
              cr_841_symbol <= Xentry_839_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/word_access_0/cr
              ptr_deref_224_store_0_req_1 <= cr_841_symbol; -- link to DP
              ca_842_symbol <= ptr_deref_224_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/word_access_0/ca
              Xexit_840_symbol <= ca_842_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/word_access_0/$exit
              word_access_0_838_symbol <= Xexit_840_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/word_access_0
            Xexit_837_symbol <= word_access_0_838_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access/$exit
            word_access_835_symbol <= Xexit_837_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/word_access
          Xexit_834_symbol <= word_access_835_symbol; -- transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete/$exit
          ptr_deref_224_complete_832_symbol <= Xexit_834_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/ptr_deref_224_complete
        Xexit_328_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/$exit 
          signal Xexit_328_predecessors: BooleanArray(15 downto 0);
          -- 
        begin -- 
          Xexit_328_predecessors(0) <= ptr_deref_112_base_address_calculated_333_symbol;
          Xexit_328_predecessors(1) <= assign_stmt_123_completed_x_x373_symbol;
          Xexit_328_predecessors(2) <= ptr_deref_121_base_address_calculated_377_symbol;
          Xexit_328_predecessors(3) <= ptr_deref_126_base_address_calculated_408_symbol;
          Xexit_328_predecessors(4) <= assign_stmt_141_completed_x_x458_symbol;
          Xexit_328_predecessors(5) <= ptr_deref_139_base_address_calculated_462_symbol;
          Xexit_328_predecessors(6) <= ptr_deref_144_base_address_calculated_493_symbol;
          Xexit_328_predecessors(7) <= ptr_deref_157_base_address_calculated_543_symbol;
          Xexit_328_predecessors(8) <= assign_stmt_193_completed_x_x650_symbol;
          Xexit_328_predecessors(9) <= ptr_deref_191_base_address_calculated_654_symbol;
          Xexit_328_predecessors(10) <= ptr_deref_196_base_address_calculated_685_symbol;
          Xexit_328_predecessors(11) <= ptr_deref_206_base_address_calculated_728_symbol;
          Xexit_328_predecessors(12) <= assign_stmt_222_completed_x_x781_symbol;
          Xexit_328_predecessors(13) <= ptr_deref_220_base_address_calculated_785_symbol;
          Xexit_328_predecessors(14) <= assign_stmt_227_completed_x_x813_symbol;
          Xexit_328_predecessors(15) <= ptr_deref_224_base_address_calculated_816_symbol;
          Xexit_328_join: join -- 
            port map( -- 
              preds => Xexit_328_predecessors,
              symbol_out => Xexit_328_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227/$exit
        assign_stmt_113_to_assign_stmt_227_326_symbol <= Xexit_328_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_113_to_assign_stmt_227
      assign_stmt_233_to_assign_stmt_245_843: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245 
        signal assign_stmt_233_to_assign_stmt_245_843_start: Boolean;
        signal Xentry_844_symbol: Boolean;
        signal Xexit_845_symbol: Boolean;
        signal assign_stmt_233_active_x_x846_symbol : Boolean;
        signal assign_stmt_233_completed_x_x847_symbol : Boolean;
        signal ptr_deref_232_trigger_x_x848_symbol : Boolean;
        signal ptr_deref_232_active_x_x849_symbol : Boolean;
        signal ptr_deref_232_base_address_calculated_850_symbol : Boolean;
        signal ptr_deref_232_root_address_calculated_851_symbol : Boolean;
        signal ptr_deref_232_word_address_calculated_852_symbol : Boolean;
        signal ptr_deref_232_request_853_symbol : Boolean;
        signal ptr_deref_232_complete_864_symbol : Boolean;
        signal assign_stmt_237_active_x_x877_symbol : Boolean;
        signal assign_stmt_237_completed_x_x878_symbol : Boolean;
        signal type_cast_236_active_x_x879_symbol : Boolean;
        signal type_cast_236_trigger_x_x880_symbol : Boolean;
        signal simple_obj_ref_235_complete_881_symbol : Boolean;
        signal type_cast_236_complete_882_symbol : Boolean;
        signal assign_stmt_245_active_x_x887_symbol : Boolean;
        signal assign_stmt_245_completed_x_x888_symbol : Boolean;
        signal binary_244_active_x_x889_symbol : Boolean;
        signal binary_244_trigger_x_x890_symbol : Boolean;
        signal type_cast_240_active_x_x891_symbol : Boolean;
        signal type_cast_240_trigger_x_x892_symbol : Boolean;
        signal simple_obj_ref_239_complete_893_symbol : Boolean;
        signal type_cast_240_complete_894_symbol : Boolean;
        signal binary_244_complete_899_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_233_to_assign_stmt_245_843_start <= assign_stmt_233_to_assign_stmt_245_x_xentry_x_xx_x34_symbol; -- control passed to block
        Xentry_844_symbol  <= assign_stmt_233_to_assign_stmt_245_843_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/$entry
        assign_stmt_233_active_x_x846_symbol <= ptr_deref_232_complete_864_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/assign_stmt_233_active_
        assign_stmt_233_completed_x_x847_symbol <= assign_stmt_233_active_x_x846_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/assign_stmt_233_completed_
        ptr_deref_232_trigger_x_x848_symbol <= ptr_deref_232_word_address_calculated_852_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_trigger_
        ptr_deref_232_active_x_x849_symbol <= ptr_deref_232_request_853_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_active_
        ptr_deref_232_base_address_calculated_850_symbol <= Xentry_844_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_base_address_calculated
        ptr_deref_232_root_address_calculated_851_symbol <= Xentry_844_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_root_address_calculated
        ptr_deref_232_word_address_calculated_852_symbol <= ptr_deref_232_root_address_calculated_851_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_word_address_calculated
        ptr_deref_232_request_853: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request 
          signal ptr_deref_232_request_853_start: Boolean;
          signal Xentry_854_symbol: Boolean;
          signal Xexit_855_symbol: Boolean;
          signal word_access_856_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_232_request_853_start <= ptr_deref_232_trigger_x_x848_symbol; -- control passed to block
          Xentry_854_symbol  <= ptr_deref_232_request_853_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/$entry
          word_access_856: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access 
            signal word_access_856_start: Boolean;
            signal Xentry_857_symbol: Boolean;
            signal Xexit_858_symbol: Boolean;
            signal word_access_0_859_symbol : Boolean;
            -- 
          begin -- 
            word_access_856_start <= Xentry_854_symbol; -- control passed to block
            Xentry_857_symbol  <= word_access_856_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/$entry
            word_access_0_859: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/word_access_0 
              signal word_access_0_859_start: Boolean;
              signal Xentry_860_symbol: Boolean;
              signal Xexit_861_symbol: Boolean;
              signal rr_862_symbol : Boolean;
              signal ra_863_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_859_start <= Xentry_857_symbol; -- control passed to block
              Xentry_860_symbol  <= word_access_0_859_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/word_access_0/$entry
              rr_862_symbol <= Xentry_860_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/word_access_0/rr
              ptr_deref_232_load_0_req_0 <= rr_862_symbol; -- link to DP
              ra_863_symbol <= ptr_deref_232_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/word_access_0/ra
              Xexit_861_symbol <= ra_863_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/word_access_0/$exit
              word_access_0_859_symbol <= Xexit_861_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/word_access_0
            Xexit_858_symbol <= word_access_0_859_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access/$exit
            word_access_856_symbol <= Xexit_858_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/word_access
          Xexit_855_symbol <= word_access_856_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request/$exit
          ptr_deref_232_request_853_symbol <= Xexit_855_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_request
        ptr_deref_232_complete_864: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete 
          signal ptr_deref_232_complete_864_start: Boolean;
          signal Xentry_865_symbol: Boolean;
          signal Xexit_866_symbol: Boolean;
          signal word_access_867_symbol : Boolean;
          signal merge_req_875_symbol : Boolean;
          signal merge_ack_876_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_232_complete_864_start <= ptr_deref_232_active_x_x849_symbol; -- control passed to block
          Xentry_865_symbol  <= ptr_deref_232_complete_864_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/$entry
          word_access_867: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access 
            signal word_access_867_start: Boolean;
            signal Xentry_868_symbol: Boolean;
            signal Xexit_869_symbol: Boolean;
            signal word_access_0_870_symbol : Boolean;
            -- 
          begin -- 
            word_access_867_start <= Xentry_865_symbol; -- control passed to block
            Xentry_868_symbol  <= word_access_867_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/$entry
            word_access_0_870: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/word_access_0 
              signal word_access_0_870_start: Boolean;
              signal Xentry_871_symbol: Boolean;
              signal Xexit_872_symbol: Boolean;
              signal cr_873_symbol : Boolean;
              signal ca_874_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_870_start <= Xentry_868_symbol; -- control passed to block
              Xentry_871_symbol  <= word_access_0_870_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/word_access_0/$entry
              cr_873_symbol <= Xentry_871_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/word_access_0/cr
              ptr_deref_232_load_0_req_1 <= cr_873_symbol; -- link to DP
              ca_874_symbol <= ptr_deref_232_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/word_access_0/ca
              Xexit_872_symbol <= ca_874_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/word_access_0/$exit
              word_access_0_870_symbol <= Xexit_872_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/word_access_0
            Xexit_869_symbol <= word_access_0_870_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access/$exit
            word_access_867_symbol <= Xexit_869_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/word_access
          merge_req_875_symbol <= word_access_867_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/merge_req
          ptr_deref_232_gather_scatter_req_0 <= merge_req_875_symbol; -- link to DP
          merge_ack_876_symbol <= ptr_deref_232_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/merge_ack
          Xexit_866_symbol <= merge_ack_876_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete/$exit
          ptr_deref_232_complete_864_symbol <= Xexit_866_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/ptr_deref_232_complete
        assign_stmt_237_active_x_x877_symbol <= type_cast_236_complete_882_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/assign_stmt_237_active_
        assign_stmt_237_completed_x_x878_symbol <= assign_stmt_237_active_x_x877_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/assign_stmt_237_completed_
        type_cast_236_active_x_x879_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_active_ 
          signal type_cast_236_active_x_x879_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_236_active_x_x879_predecessors(0) <= type_cast_236_trigger_x_x880_symbol;
          type_cast_236_active_x_x879_predecessors(1) <= simple_obj_ref_235_complete_881_symbol;
          type_cast_236_active_x_x879_join: join -- 
            port map( -- 
              preds => type_cast_236_active_x_x879_predecessors,
              symbol_out => type_cast_236_active_x_x879_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_active_
        type_cast_236_trigger_x_x880_symbol <= Xentry_844_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_trigger_
        simple_obj_ref_235_complete_881_symbol <= assign_stmt_233_completed_x_x847_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/simple_obj_ref_235_complete
        type_cast_236_complete_882: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_complete 
          signal type_cast_236_complete_882_start: Boolean;
          signal Xentry_883_symbol: Boolean;
          signal Xexit_884_symbol: Boolean;
          signal req_885_symbol : Boolean;
          signal ack_886_symbol : Boolean;
          -- 
        begin -- 
          type_cast_236_complete_882_start <= type_cast_236_active_x_x879_symbol; -- control passed to block
          Xentry_883_symbol  <= type_cast_236_complete_882_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_complete/$entry
          req_885_symbol <= Xentry_883_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_complete/req
          type_cast_236_inst_req_0 <= req_885_symbol; -- link to DP
          ack_886_symbol <= type_cast_236_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_complete/ack
          Xexit_884_symbol <= ack_886_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_complete/$exit
          type_cast_236_complete_882_symbol <= Xexit_884_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_236_complete
        assign_stmt_245_active_x_x887_symbol <= binary_244_complete_899_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/assign_stmt_245_active_
        assign_stmt_245_completed_x_x888_symbol <= assign_stmt_245_active_x_x887_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/assign_stmt_245_completed_
        binary_244_active_x_x889_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_active_ 
          signal binary_244_active_x_x889_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          binary_244_active_x_x889_predecessors(0) <= binary_244_trigger_x_x890_symbol;
          binary_244_active_x_x889_predecessors(1) <= type_cast_240_complete_894_symbol;
          binary_244_active_x_x889_join: join -- 
            port map( -- 
              preds => binary_244_active_x_x889_predecessors,
              symbol_out => binary_244_active_x_x889_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_active_
        binary_244_trigger_x_x890_symbol <= Xentry_844_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_trigger_
        type_cast_240_active_x_x891_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_active_ 
          signal type_cast_240_active_x_x891_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          type_cast_240_active_x_x891_predecessors(0) <= type_cast_240_trigger_x_x892_symbol;
          type_cast_240_active_x_x891_predecessors(1) <= simple_obj_ref_239_complete_893_symbol;
          type_cast_240_active_x_x891_join: join -- 
            port map( -- 
              preds => type_cast_240_active_x_x891_predecessors,
              symbol_out => type_cast_240_active_x_x891_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_active_
        type_cast_240_trigger_x_x892_symbol <= Xentry_844_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_trigger_
        simple_obj_ref_239_complete_893_symbol <= assign_stmt_237_completed_x_x878_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/simple_obj_ref_239_complete
        type_cast_240_complete_894: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_complete 
          signal type_cast_240_complete_894_start: Boolean;
          signal Xentry_895_symbol: Boolean;
          signal Xexit_896_symbol: Boolean;
          signal req_897_symbol : Boolean;
          signal ack_898_symbol : Boolean;
          -- 
        begin -- 
          type_cast_240_complete_894_start <= type_cast_240_active_x_x891_symbol; -- control passed to block
          Xentry_895_symbol  <= type_cast_240_complete_894_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_complete/$entry
          req_897_symbol <= Xentry_895_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_complete/req
          type_cast_240_inst_req_0 <= req_897_symbol; -- link to DP
          ack_898_symbol <= type_cast_240_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_complete/ack
          Xexit_896_symbol <= ack_898_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_complete/$exit
          type_cast_240_complete_894_symbol <= Xexit_896_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/type_cast_240_complete
        binary_244_complete_899: Block -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete 
          signal binary_244_complete_899_start: Boolean;
          signal Xentry_900_symbol: Boolean;
          signal Xexit_901_symbol: Boolean;
          signal rr_902_symbol : Boolean;
          signal ra_903_symbol : Boolean;
          signal cr_904_symbol : Boolean;
          signal ca_905_symbol : Boolean;
          -- 
        begin -- 
          binary_244_complete_899_start <= binary_244_active_x_x889_symbol; -- control passed to block
          Xentry_900_symbol  <= binary_244_complete_899_start; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete/$entry
          rr_902_symbol <= Xentry_900_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete/rr
          binary_244_inst_req_0 <= rr_902_symbol; -- link to DP
          ra_903_symbol <= binary_244_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete/ra
          cr_904_symbol <= ra_903_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete/cr
          binary_244_inst_req_1 <= cr_904_symbol; -- link to DP
          ca_905_symbol <= binary_244_inst_ack_1; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete/ca
          Xexit_901_symbol <= ca_905_symbol; -- transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete/$exit
          binary_244_complete_899_symbol <= Xexit_901_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/binary_244_complete
        Xexit_845_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/$exit 
          signal Xexit_845_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_845_predecessors(0) <= ptr_deref_232_base_address_calculated_850_symbol;
          Xexit_845_predecessors(1) <= assign_stmt_245_completed_x_x888_symbol;
          Xexit_845_join: join -- 
            port map( -- 
              preds => Xexit_845_predecessors,
              symbol_out => Xexit_845_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245/$exit
        assign_stmt_233_to_assign_stmt_245_843_symbol <= Xexit_845_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_233_to_assign_stmt_245
      if_stmt_246_dead_link_906: Block -- branch_block_stmt_13/if_stmt_246_dead_link 
        signal if_stmt_246_dead_link_906_start: Boolean;
        signal Xentry_907_symbol: Boolean;
        signal Xexit_908_symbol: Boolean;
        signal dead_transition_909_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_246_dead_link_906_start <= if_stmt_246_x_xentry_x_xx_x36_symbol; -- control passed to block
        Xentry_907_symbol  <= if_stmt_246_dead_link_906_start; -- transition branch_block_stmt_13/if_stmt_246_dead_link/$entry
        dead_transition_909_symbol <= false;
        Xexit_908_symbol <= dead_transition_909_symbol; -- transition branch_block_stmt_13/if_stmt_246_dead_link/$exit
        if_stmt_246_dead_link_906_symbol <= Xexit_908_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_246_dead_link
      if_stmt_246_eval_test_910: Block -- branch_block_stmt_13/if_stmt_246_eval_test 
        signal if_stmt_246_eval_test_910_start: Boolean;
        signal Xentry_911_symbol: Boolean;
        signal Xexit_912_symbol: Boolean;
        signal branch_req_913_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_246_eval_test_910_start <= if_stmt_246_x_xentry_x_xx_x36_symbol; -- control passed to block
        Xentry_911_symbol  <= if_stmt_246_eval_test_910_start; -- transition branch_block_stmt_13/if_stmt_246_eval_test/$entry
        branch_req_913_symbol <= Xentry_911_symbol; -- transition branch_block_stmt_13/if_stmt_246_eval_test/branch_req
        if_stmt_246_branch_req_0 <= branch_req_913_symbol; -- link to DP
        Xexit_912_symbol <= branch_req_913_symbol; -- transition branch_block_stmt_13/if_stmt_246_eval_test/$exit
        if_stmt_246_eval_test_910_symbol <= Xexit_912_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_246_eval_test
      simple_obj_ref_247_place_914_symbol  <=  if_stmt_246_eval_test_910_symbol; -- place branch_block_stmt_13/simple_obj_ref_247_place (optimized away) 
      if_stmt_246_if_link_915: Block -- branch_block_stmt_13/if_stmt_246_if_link 
        signal if_stmt_246_if_link_915_start: Boolean;
        signal Xentry_916_symbol: Boolean;
        signal Xexit_917_symbol: Boolean;
        signal if_choice_transition_918_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_246_if_link_915_start <= simple_obj_ref_247_place_914_symbol; -- control passed to block
        Xentry_916_symbol  <= if_stmt_246_if_link_915_start; -- transition branch_block_stmt_13/if_stmt_246_if_link/$entry
        if_choice_transition_918_symbol <= if_stmt_246_branch_ack_1; -- transition branch_block_stmt_13/if_stmt_246_if_link/if_choice_transition
        Xexit_917_symbol <= if_choice_transition_918_symbol; -- transition branch_block_stmt_13/if_stmt_246_if_link/$exit
        if_stmt_246_if_link_915_symbol <= Xexit_917_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_246_if_link
      if_stmt_246_else_link_919: Block -- branch_block_stmt_13/if_stmt_246_else_link 
        signal if_stmt_246_else_link_919_start: Boolean;
        signal Xentry_920_symbol: Boolean;
        signal Xexit_921_symbol: Boolean;
        signal else_choice_transition_922_symbol : Boolean;
        -- 
      begin -- 
        if_stmt_246_else_link_919_start <= simple_obj_ref_247_place_914_symbol; -- control passed to block
        Xentry_920_symbol  <= if_stmt_246_else_link_919_start; -- transition branch_block_stmt_13/if_stmt_246_else_link/$entry
        else_choice_transition_922_symbol <= if_stmt_246_branch_ack_0; -- transition branch_block_stmt_13/if_stmt_246_else_link/else_choice_transition
        Xexit_921_symbol <= else_choice_transition_922_symbol; -- transition branch_block_stmt_13/if_stmt_246_else_link/$exit
        if_stmt_246_else_link_919_symbol <= Xexit_921_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/if_stmt_246_else_link
      bb_4_bb_5_923_symbol  <=  if_stmt_246_if_link_915_symbol; -- place branch_block_stmt_13/bb_4_bb_5 (optimized away) 
      bb_4_bb_6_924_symbol  <=  if_stmt_246_else_link_919_symbol; -- place branch_block_stmt_13/bb_4_bb_6 (optimized away) 
      assign_stmt_257_925: Block -- branch_block_stmt_13/assign_stmt_257 
        signal assign_stmt_257_925_start: Boolean;
        signal Xentry_926_symbol: Boolean;
        signal Xexit_927_symbol: Boolean;
        signal assign_stmt_257_active_x_x928_symbol : Boolean;
        signal assign_stmt_257_completed_x_x929_symbol : Boolean;
        signal ptr_deref_254_trigger_x_x930_symbol : Boolean;
        signal ptr_deref_254_active_x_x931_symbol : Boolean;
        signal ptr_deref_254_base_address_calculated_932_symbol : Boolean;
        signal ptr_deref_254_root_address_calculated_933_symbol : Boolean;
        signal ptr_deref_254_word_address_calculated_934_symbol : Boolean;
        signal ptr_deref_254_request_935_symbol : Boolean;
        signal ptr_deref_254_complete_948_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_257_925_start <= assign_stmt_257_x_xentry_x_xx_x40_symbol; -- control passed to block
        Xentry_926_symbol  <= assign_stmt_257_925_start; -- transition branch_block_stmt_13/assign_stmt_257/$entry
        assign_stmt_257_active_x_x928_symbol <= Xentry_926_symbol; -- transition branch_block_stmt_13/assign_stmt_257/assign_stmt_257_active_
        assign_stmt_257_completed_x_x929_symbol <= ptr_deref_254_complete_948_symbol; -- transition branch_block_stmt_13/assign_stmt_257/assign_stmt_257_completed_
        ptr_deref_254_trigger_x_x930_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_trigger_ 
          signal ptr_deref_254_trigger_x_x930_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          ptr_deref_254_trigger_x_x930_predecessors(0) <= ptr_deref_254_word_address_calculated_934_symbol;
          ptr_deref_254_trigger_x_x930_predecessors(1) <= assign_stmt_257_active_x_x928_symbol;
          ptr_deref_254_trigger_x_x930_join: join -- 
            port map( -- 
              preds => ptr_deref_254_trigger_x_x930_predecessors,
              symbol_out => ptr_deref_254_trigger_x_x930_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_trigger_
        ptr_deref_254_active_x_x931_symbol <= ptr_deref_254_request_935_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_active_
        ptr_deref_254_base_address_calculated_932_symbol <= Xentry_926_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_base_address_calculated
        ptr_deref_254_root_address_calculated_933_symbol <= Xentry_926_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_root_address_calculated
        ptr_deref_254_word_address_calculated_934_symbol <= ptr_deref_254_root_address_calculated_933_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_word_address_calculated
        ptr_deref_254_request_935: Block -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request 
          signal ptr_deref_254_request_935_start: Boolean;
          signal Xentry_936_symbol: Boolean;
          signal Xexit_937_symbol: Boolean;
          signal split_req_938_symbol : Boolean;
          signal split_ack_939_symbol : Boolean;
          signal word_access_940_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_254_request_935_start <= ptr_deref_254_trigger_x_x930_symbol; -- control passed to block
          Xentry_936_symbol  <= ptr_deref_254_request_935_start; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/$entry
          split_req_938_symbol <= Xentry_936_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/split_req
          ptr_deref_254_gather_scatter_req_0 <= split_req_938_symbol; -- link to DP
          split_ack_939_symbol <= ptr_deref_254_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/split_ack
          word_access_940: Block -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access 
            signal word_access_940_start: Boolean;
            signal Xentry_941_symbol: Boolean;
            signal Xexit_942_symbol: Boolean;
            signal word_access_0_943_symbol : Boolean;
            -- 
          begin -- 
            word_access_940_start <= split_ack_939_symbol; -- control passed to block
            Xentry_941_symbol  <= word_access_940_start; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/$entry
            word_access_0_943: Block -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/word_access_0 
              signal word_access_0_943_start: Boolean;
              signal Xentry_944_symbol: Boolean;
              signal Xexit_945_symbol: Boolean;
              signal rr_946_symbol : Boolean;
              signal ra_947_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_943_start <= Xentry_941_symbol; -- control passed to block
              Xentry_944_symbol  <= word_access_0_943_start; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/word_access_0/$entry
              rr_946_symbol <= Xentry_944_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/word_access_0/rr
              ptr_deref_254_store_0_req_0 <= rr_946_symbol; -- link to DP
              ra_947_symbol <= ptr_deref_254_store_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/word_access_0/ra
              Xexit_945_symbol <= ra_947_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/word_access_0/$exit
              word_access_0_943_symbol <= Xexit_945_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/word_access_0
            Xexit_942_symbol <= word_access_0_943_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access/$exit
            word_access_940_symbol <= Xexit_942_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/word_access
          Xexit_937_symbol <= word_access_940_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request/$exit
          ptr_deref_254_request_935_symbol <= Xexit_937_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_request
        ptr_deref_254_complete_948: Block -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete 
          signal ptr_deref_254_complete_948_start: Boolean;
          signal Xentry_949_symbol: Boolean;
          signal Xexit_950_symbol: Boolean;
          signal word_access_951_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_254_complete_948_start <= ptr_deref_254_active_x_x931_symbol; -- control passed to block
          Xentry_949_symbol  <= ptr_deref_254_complete_948_start; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/$entry
          word_access_951: Block -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access 
            signal word_access_951_start: Boolean;
            signal Xentry_952_symbol: Boolean;
            signal Xexit_953_symbol: Boolean;
            signal word_access_0_954_symbol : Boolean;
            -- 
          begin -- 
            word_access_951_start <= Xentry_949_symbol; -- control passed to block
            Xentry_952_symbol  <= word_access_951_start; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/$entry
            word_access_0_954: Block -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/word_access_0 
              signal word_access_0_954_start: Boolean;
              signal Xentry_955_symbol: Boolean;
              signal Xexit_956_symbol: Boolean;
              signal cr_957_symbol : Boolean;
              signal ca_958_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_954_start <= Xentry_952_symbol; -- control passed to block
              Xentry_955_symbol  <= word_access_0_954_start; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/word_access_0/$entry
              cr_957_symbol <= Xentry_955_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/word_access_0/cr
              ptr_deref_254_store_0_req_1 <= cr_957_symbol; -- link to DP
              ca_958_symbol <= ptr_deref_254_store_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/word_access_0/ca
              Xexit_956_symbol <= ca_958_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/word_access_0/$exit
              word_access_0_954_symbol <= Xexit_956_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/word_access_0
            Xexit_953_symbol <= word_access_0_954_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access/$exit
            word_access_951_symbol <= Xexit_953_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/word_access
          Xexit_950_symbol <= word_access_951_symbol; -- transition branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete/$exit
          ptr_deref_254_complete_948_symbol <= Xexit_950_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_257/ptr_deref_254_complete
        Xexit_927_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_257/$exit 
          signal Xexit_927_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_927_predecessors(0) <= assign_stmt_257_completed_x_x929_symbol;
          Xexit_927_predecessors(1) <= ptr_deref_254_base_address_calculated_932_symbol;
          Xexit_927_join: join -- 
            port map( -- 
              preds => Xexit_927_predecessors,
              symbol_out => Xexit_927_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_257/$exit
        assign_stmt_257_925_symbol <= Xexit_927_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_257
      assign_stmt_263_959: Block -- branch_block_stmt_13/assign_stmt_263 
        signal assign_stmt_263_959_start: Boolean;
        signal Xentry_960_symbol: Boolean;
        signal Xexit_961_symbol: Boolean;
        signal assign_stmt_263_active_x_x962_symbol : Boolean;
        signal assign_stmt_263_completed_x_x963_symbol : Boolean;
        signal ptr_deref_262_trigger_x_x964_symbol : Boolean;
        signal ptr_deref_262_active_x_x965_symbol : Boolean;
        signal ptr_deref_262_base_address_calculated_966_symbol : Boolean;
        signal ptr_deref_262_root_address_calculated_967_symbol : Boolean;
        signal ptr_deref_262_word_address_calculated_968_symbol : Boolean;
        signal ptr_deref_262_request_969_symbol : Boolean;
        signal ptr_deref_262_complete_980_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_263_959_start <= assign_stmt_263_x_xentry_x_xx_x44_symbol; -- control passed to block
        Xentry_960_symbol  <= assign_stmt_263_959_start; -- transition branch_block_stmt_13/assign_stmt_263/$entry
        assign_stmt_263_active_x_x962_symbol <= ptr_deref_262_complete_980_symbol; -- transition branch_block_stmt_13/assign_stmt_263/assign_stmt_263_active_
        assign_stmt_263_completed_x_x963_symbol <= assign_stmt_263_active_x_x962_symbol; -- transition branch_block_stmt_13/assign_stmt_263/assign_stmt_263_completed_
        ptr_deref_262_trigger_x_x964_symbol <= ptr_deref_262_word_address_calculated_968_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_trigger_
        ptr_deref_262_active_x_x965_symbol <= ptr_deref_262_request_969_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_active_
        ptr_deref_262_base_address_calculated_966_symbol <= Xentry_960_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_base_address_calculated
        ptr_deref_262_root_address_calculated_967_symbol <= Xentry_960_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_root_address_calculated
        ptr_deref_262_word_address_calculated_968_symbol <= ptr_deref_262_root_address_calculated_967_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_word_address_calculated
        ptr_deref_262_request_969: Block -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request 
          signal ptr_deref_262_request_969_start: Boolean;
          signal Xentry_970_symbol: Boolean;
          signal Xexit_971_symbol: Boolean;
          signal word_access_972_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_262_request_969_start <= ptr_deref_262_trigger_x_x964_symbol; -- control passed to block
          Xentry_970_symbol  <= ptr_deref_262_request_969_start; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/$entry
          word_access_972: Block -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access 
            signal word_access_972_start: Boolean;
            signal Xentry_973_symbol: Boolean;
            signal Xexit_974_symbol: Boolean;
            signal word_access_0_975_symbol : Boolean;
            -- 
          begin -- 
            word_access_972_start <= Xentry_970_symbol; -- control passed to block
            Xentry_973_symbol  <= word_access_972_start; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/$entry
            word_access_0_975: Block -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/word_access_0 
              signal word_access_0_975_start: Boolean;
              signal Xentry_976_symbol: Boolean;
              signal Xexit_977_symbol: Boolean;
              signal rr_978_symbol : Boolean;
              signal ra_979_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_975_start <= Xentry_973_symbol; -- control passed to block
              Xentry_976_symbol  <= word_access_0_975_start; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/word_access_0/$entry
              rr_978_symbol <= Xentry_976_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/word_access_0/rr
              ptr_deref_262_load_0_req_0 <= rr_978_symbol; -- link to DP
              ra_979_symbol <= ptr_deref_262_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/word_access_0/ra
              Xexit_977_symbol <= ra_979_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/word_access_0/$exit
              word_access_0_975_symbol <= Xexit_977_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/word_access_0
            Xexit_974_symbol <= word_access_0_975_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access/$exit
            word_access_972_symbol <= Xexit_974_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/word_access
          Xexit_971_symbol <= word_access_972_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request/$exit
          ptr_deref_262_request_969_symbol <= Xexit_971_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_request
        ptr_deref_262_complete_980: Block -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete 
          signal ptr_deref_262_complete_980_start: Boolean;
          signal Xentry_981_symbol: Boolean;
          signal Xexit_982_symbol: Boolean;
          signal word_access_983_symbol : Boolean;
          signal merge_req_991_symbol : Boolean;
          signal merge_ack_992_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_262_complete_980_start <= ptr_deref_262_active_x_x965_symbol; -- control passed to block
          Xentry_981_symbol  <= ptr_deref_262_complete_980_start; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/$entry
          word_access_983: Block -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access 
            signal word_access_983_start: Boolean;
            signal Xentry_984_symbol: Boolean;
            signal Xexit_985_symbol: Boolean;
            signal word_access_0_986_symbol : Boolean;
            -- 
          begin -- 
            word_access_983_start <= Xentry_981_symbol; -- control passed to block
            Xentry_984_symbol  <= word_access_983_start; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/$entry
            word_access_0_986: Block -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/word_access_0 
              signal word_access_0_986_start: Boolean;
              signal Xentry_987_symbol: Boolean;
              signal Xexit_988_symbol: Boolean;
              signal cr_989_symbol : Boolean;
              signal ca_990_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_986_start <= Xentry_984_symbol; -- control passed to block
              Xentry_987_symbol  <= word_access_0_986_start; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/word_access_0/$entry
              cr_989_symbol <= Xentry_987_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/word_access_0/cr
              ptr_deref_262_load_0_req_1 <= cr_989_symbol; -- link to DP
              ca_990_symbol <= ptr_deref_262_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/word_access_0/ca
              Xexit_988_symbol <= ca_990_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/word_access_0/$exit
              word_access_0_986_symbol <= Xexit_988_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/word_access_0
            Xexit_985_symbol <= word_access_0_986_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access/$exit
            word_access_983_symbol <= Xexit_985_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/word_access
          merge_req_991_symbol <= word_access_983_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/merge_req
          ptr_deref_262_gather_scatter_req_0 <= merge_req_991_symbol; -- link to DP
          merge_ack_992_symbol <= ptr_deref_262_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/merge_ack
          Xexit_982_symbol <= merge_ack_992_symbol; -- transition branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete/$exit
          ptr_deref_262_complete_980_symbol <= Xexit_982_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_263/ptr_deref_262_complete
        Xexit_961_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_263/$exit 
          signal Xexit_961_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_961_predecessors(0) <= assign_stmt_263_completed_x_x963_symbol;
          Xexit_961_predecessors(1) <= ptr_deref_262_base_address_calculated_966_symbol;
          Xexit_961_join: join -- 
            port map( -- 
              preds => Xexit_961_predecessors,
              symbol_out => Xexit_961_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_263/$exit
        assign_stmt_263_959_symbol <= Xexit_961_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_263
      assign_stmt_266_993: Block -- branch_block_stmt_13/assign_stmt_266 
        signal assign_stmt_266_993_start: Boolean;
        signal Xentry_994_symbol: Boolean;
        signal Xexit_995_symbol: Boolean;
        signal assign_stmt_266_active_x_x996_symbol : Boolean;
        signal assign_stmt_266_completed_x_x997_symbol : Boolean;
        signal simple_obj_ref_265_complete_998_symbol : Boolean;
        signal simple_obj_ref_264_trigger_x_x999_symbol : Boolean;
        signal simple_obj_ref_264_complete_1000_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_266_993_start <= assign_stmt_266_x_xentry_x_xx_x46_symbol; -- control passed to block
        Xentry_994_symbol  <= assign_stmt_266_993_start; -- transition branch_block_stmt_13/assign_stmt_266/$entry
        assign_stmt_266_active_x_x996_symbol <= simple_obj_ref_265_complete_998_symbol; -- transition branch_block_stmt_13/assign_stmt_266/assign_stmt_266_active_
        assign_stmt_266_completed_x_x997_symbol <= simple_obj_ref_264_complete_1000_symbol; -- transition branch_block_stmt_13/assign_stmt_266/assign_stmt_266_completed_
        simple_obj_ref_265_complete_998_symbol <= Xentry_994_symbol; -- transition branch_block_stmt_13/assign_stmt_266/simple_obj_ref_265_complete
        simple_obj_ref_264_trigger_x_x999_symbol <= assign_stmt_266_active_x_x996_symbol; -- transition branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_trigger_
        simple_obj_ref_264_complete_1000: Block -- branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_complete 
          signal simple_obj_ref_264_complete_1000_start: Boolean;
          signal Xentry_1001_symbol: Boolean;
          signal Xexit_1002_symbol: Boolean;
          signal pipe_wreq_1003_symbol : Boolean;
          signal pipe_wack_1004_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_264_complete_1000_start <= simple_obj_ref_264_trigger_x_x999_symbol; -- control passed to block
          Xentry_1001_symbol  <= simple_obj_ref_264_complete_1000_start; -- transition branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_complete/$entry
          pipe_wreq_1003_symbol <= Xentry_1001_symbol; -- transition branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_complete/pipe_wreq
          simple_obj_ref_264_inst_req_0 <= pipe_wreq_1003_symbol; -- link to DP
          pipe_wack_1004_symbol <= simple_obj_ref_264_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_complete/pipe_wack
          Xexit_1002_symbol <= pipe_wack_1004_symbol; -- transition branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_complete/$exit
          simple_obj_ref_264_complete_1000_symbol <= Xexit_1002_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_266/simple_obj_ref_264_complete
        Xexit_995_symbol <= assign_stmt_266_completed_x_x997_symbol; -- transition branch_block_stmt_13/assign_stmt_266/$exit
        assign_stmt_266_993_symbol <= Xexit_995_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_266
      assign_stmt_270_1005: Block -- branch_block_stmt_13/assign_stmt_270 
        signal assign_stmt_270_1005_start: Boolean;
        signal Xentry_1006_symbol: Boolean;
        signal Xexit_1007_symbol: Boolean;
        signal assign_stmt_270_active_x_x1008_symbol : Boolean;
        signal assign_stmt_270_completed_x_x1009_symbol : Boolean;
        signal ptr_deref_269_trigger_x_x1010_symbol : Boolean;
        signal ptr_deref_269_active_x_x1011_symbol : Boolean;
        signal ptr_deref_269_base_address_calculated_1012_symbol : Boolean;
        signal ptr_deref_269_root_address_calculated_1013_symbol : Boolean;
        signal ptr_deref_269_word_address_calculated_1014_symbol : Boolean;
        signal ptr_deref_269_request_1015_symbol : Boolean;
        signal ptr_deref_269_complete_1026_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_270_1005_start <= assign_stmt_270_x_xentry_x_xx_x48_symbol; -- control passed to block
        Xentry_1006_symbol  <= assign_stmt_270_1005_start; -- transition branch_block_stmt_13/assign_stmt_270/$entry
        assign_stmt_270_active_x_x1008_symbol <= ptr_deref_269_complete_1026_symbol; -- transition branch_block_stmt_13/assign_stmt_270/assign_stmt_270_active_
        assign_stmt_270_completed_x_x1009_symbol <= assign_stmt_270_active_x_x1008_symbol; -- transition branch_block_stmt_13/assign_stmt_270/assign_stmt_270_completed_
        ptr_deref_269_trigger_x_x1010_symbol <= ptr_deref_269_word_address_calculated_1014_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_trigger_
        ptr_deref_269_active_x_x1011_symbol <= ptr_deref_269_request_1015_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_active_
        ptr_deref_269_base_address_calculated_1012_symbol <= Xentry_1006_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_base_address_calculated
        ptr_deref_269_root_address_calculated_1013_symbol <= Xentry_1006_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_root_address_calculated
        ptr_deref_269_word_address_calculated_1014_symbol <= ptr_deref_269_root_address_calculated_1013_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_word_address_calculated
        ptr_deref_269_request_1015: Block -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request 
          signal ptr_deref_269_request_1015_start: Boolean;
          signal Xentry_1016_symbol: Boolean;
          signal Xexit_1017_symbol: Boolean;
          signal word_access_1018_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_269_request_1015_start <= ptr_deref_269_trigger_x_x1010_symbol; -- control passed to block
          Xentry_1016_symbol  <= ptr_deref_269_request_1015_start; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/$entry
          word_access_1018: Block -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access 
            signal word_access_1018_start: Boolean;
            signal Xentry_1019_symbol: Boolean;
            signal Xexit_1020_symbol: Boolean;
            signal word_access_0_1021_symbol : Boolean;
            -- 
          begin -- 
            word_access_1018_start <= Xentry_1016_symbol; -- control passed to block
            Xentry_1019_symbol  <= word_access_1018_start; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/$entry
            word_access_0_1021: Block -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/word_access_0 
              signal word_access_0_1021_start: Boolean;
              signal Xentry_1022_symbol: Boolean;
              signal Xexit_1023_symbol: Boolean;
              signal rr_1024_symbol : Boolean;
              signal ra_1025_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1021_start <= Xentry_1019_symbol; -- control passed to block
              Xentry_1022_symbol  <= word_access_0_1021_start; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/word_access_0/$entry
              rr_1024_symbol <= Xentry_1022_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/word_access_0/rr
              ptr_deref_269_load_0_req_0 <= rr_1024_symbol; -- link to DP
              ra_1025_symbol <= ptr_deref_269_load_0_ack_0; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/word_access_0/ra
              Xexit_1023_symbol <= ra_1025_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/word_access_0/$exit
              word_access_0_1021_symbol <= Xexit_1023_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/word_access_0
            Xexit_1020_symbol <= word_access_0_1021_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access/$exit
            word_access_1018_symbol <= Xexit_1020_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/word_access
          Xexit_1017_symbol <= word_access_1018_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request/$exit
          ptr_deref_269_request_1015_symbol <= Xexit_1017_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_request
        ptr_deref_269_complete_1026: Block -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete 
          signal ptr_deref_269_complete_1026_start: Boolean;
          signal Xentry_1027_symbol: Boolean;
          signal Xexit_1028_symbol: Boolean;
          signal word_access_1029_symbol : Boolean;
          signal merge_req_1037_symbol : Boolean;
          signal merge_ack_1038_symbol : Boolean;
          -- 
        begin -- 
          ptr_deref_269_complete_1026_start <= ptr_deref_269_active_x_x1011_symbol; -- control passed to block
          Xentry_1027_symbol  <= ptr_deref_269_complete_1026_start; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/$entry
          word_access_1029: Block -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access 
            signal word_access_1029_start: Boolean;
            signal Xentry_1030_symbol: Boolean;
            signal Xexit_1031_symbol: Boolean;
            signal word_access_0_1032_symbol : Boolean;
            -- 
          begin -- 
            word_access_1029_start <= Xentry_1027_symbol; -- control passed to block
            Xentry_1030_symbol  <= word_access_1029_start; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/$entry
            word_access_0_1032: Block -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/word_access_0 
              signal word_access_0_1032_start: Boolean;
              signal Xentry_1033_symbol: Boolean;
              signal Xexit_1034_symbol: Boolean;
              signal cr_1035_symbol : Boolean;
              signal ca_1036_symbol : Boolean;
              -- 
            begin -- 
              word_access_0_1032_start <= Xentry_1030_symbol; -- control passed to block
              Xentry_1033_symbol  <= word_access_0_1032_start; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/word_access_0/$entry
              cr_1035_symbol <= Xentry_1033_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/word_access_0/cr
              ptr_deref_269_load_0_req_1 <= cr_1035_symbol; -- link to DP
              ca_1036_symbol <= ptr_deref_269_load_0_ack_1; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/word_access_0/ca
              Xexit_1034_symbol <= ca_1036_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/word_access_0/$exit
              word_access_0_1032_symbol <= Xexit_1034_symbol; -- control passed from block 
              -- 
            end Block; -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/word_access_0
            Xexit_1031_symbol <= word_access_0_1032_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access/$exit
            word_access_1029_symbol <= Xexit_1031_symbol; -- control passed from block 
            -- 
          end Block; -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/word_access
          merge_req_1037_symbol <= word_access_1029_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/merge_req
          ptr_deref_269_gather_scatter_req_0 <= merge_req_1037_symbol; -- link to DP
          merge_ack_1038_symbol <= ptr_deref_269_gather_scatter_ack_0; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/merge_ack
          Xexit_1028_symbol <= merge_ack_1038_symbol; -- transition branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete/$exit
          ptr_deref_269_complete_1026_symbol <= Xexit_1028_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_270/ptr_deref_269_complete
        Xexit_1007_block : Block -- non-trivial join transition branch_block_stmt_13/assign_stmt_270/$exit 
          signal Xexit_1007_predecessors: BooleanArray(1 downto 0);
          -- 
        begin -- 
          Xexit_1007_predecessors(0) <= assign_stmt_270_completed_x_x1009_symbol;
          Xexit_1007_predecessors(1) <= ptr_deref_269_base_address_calculated_1012_symbol;
          Xexit_1007_join: join -- 
            port map( -- 
              preds => Xexit_1007_predecessors,
              symbol_out => Xexit_1007_symbol,
              clk => clk,
              reset => reset); -- 
          -- 
        end Block; -- non-trivial join transition branch_block_stmt_13/assign_stmt_270/$exit
        assign_stmt_270_1005_symbol <= Xexit_1007_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_270
      assign_stmt_273_1039: Block -- branch_block_stmt_13/assign_stmt_273 
        signal assign_stmt_273_1039_start: Boolean;
        signal Xentry_1040_symbol: Boolean;
        signal Xexit_1041_symbol: Boolean;
        signal assign_stmt_273_active_x_x1042_symbol : Boolean;
        signal assign_stmt_273_completed_x_x1043_symbol : Boolean;
        signal simple_obj_ref_272_complete_1044_symbol : Boolean;
        signal simple_obj_ref_271_trigger_x_x1045_symbol : Boolean;
        signal simple_obj_ref_271_complete_1046_symbol : Boolean;
        -- 
      begin -- 
        assign_stmt_273_1039_start <= assign_stmt_273_x_xentry_x_xx_x50_symbol; -- control passed to block
        Xentry_1040_symbol  <= assign_stmt_273_1039_start; -- transition branch_block_stmt_13/assign_stmt_273/$entry
        assign_stmt_273_active_x_x1042_symbol <= simple_obj_ref_272_complete_1044_symbol; -- transition branch_block_stmt_13/assign_stmt_273/assign_stmt_273_active_
        assign_stmt_273_completed_x_x1043_symbol <= simple_obj_ref_271_complete_1046_symbol; -- transition branch_block_stmt_13/assign_stmt_273/assign_stmt_273_completed_
        simple_obj_ref_272_complete_1044_symbol <= Xentry_1040_symbol; -- transition branch_block_stmt_13/assign_stmt_273/simple_obj_ref_272_complete
        simple_obj_ref_271_trigger_x_x1045_symbol <= assign_stmt_273_active_x_x1042_symbol; -- transition branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_trigger_
        simple_obj_ref_271_complete_1046: Block -- branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_complete 
          signal simple_obj_ref_271_complete_1046_start: Boolean;
          signal Xentry_1047_symbol: Boolean;
          signal Xexit_1048_symbol: Boolean;
          signal pipe_wreq_1049_symbol : Boolean;
          signal pipe_wack_1050_symbol : Boolean;
          -- 
        begin -- 
          simple_obj_ref_271_complete_1046_start <= simple_obj_ref_271_trigger_x_x1045_symbol; -- control passed to block
          Xentry_1047_symbol  <= simple_obj_ref_271_complete_1046_start; -- transition branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_complete/$entry
          pipe_wreq_1049_symbol <= Xentry_1047_symbol; -- transition branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_complete/pipe_wreq
          simple_obj_ref_271_inst_req_0 <= pipe_wreq_1049_symbol; -- link to DP
          pipe_wack_1050_symbol <= simple_obj_ref_271_inst_ack_0; -- transition branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_complete/pipe_wack
          Xexit_1048_symbol <= pipe_wack_1050_symbol; -- transition branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_complete/$exit
          simple_obj_ref_271_complete_1046_symbol <= Xexit_1048_symbol; -- control passed from block 
          -- 
        end Block; -- branch_block_stmt_13/assign_stmt_273/simple_obj_ref_271_complete
        Xexit_1041_symbol <= assign_stmt_273_completed_x_x1043_symbol; -- transition branch_block_stmt_13/assign_stmt_273/$exit
        assign_stmt_273_1039_symbol <= Xexit_1041_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/assign_stmt_273
      bb_0_bb_1_PhiReq_1051: Block -- branch_block_stmt_13/bb_0_bb_1_PhiReq 
        signal bb_0_bb_1_PhiReq_1051_start: Boolean;
        signal Xentry_1052_symbol: Boolean;
        signal Xexit_1053_symbol: Boolean;
        -- 
      begin -- 
        bb_0_bb_1_PhiReq_1051_start <= bb_0_bb_1_10_symbol; -- control passed to block
        Xentry_1052_symbol  <= bb_0_bb_1_PhiReq_1051_start; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$entry
        Xexit_1053_symbol <= Xentry_1052_symbol; -- transition branch_block_stmt_13/bb_0_bb_1_PhiReq/$exit
        bb_0_bb_1_PhiReq_1051_symbol <= Xexit_1053_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_0_bb_1_PhiReq
      bb_6_bb_1_PhiReq_1054: Block -- branch_block_stmt_13/bb_6_bb_1_PhiReq 
        signal bb_6_bb_1_PhiReq_1054_start: Boolean;
        signal Xentry_1055_symbol: Boolean;
        signal Xexit_1056_symbol: Boolean;
        -- 
      begin -- 
        bb_6_bb_1_PhiReq_1054_start <= bb_6_bb_1_52_symbol; -- control passed to block
        Xentry_1055_symbol  <= bb_6_bb_1_PhiReq_1054_start; -- transition branch_block_stmt_13/bb_6_bb_1_PhiReq/$entry
        Xexit_1056_symbol <= Xentry_1055_symbol; -- transition branch_block_stmt_13/bb_6_bb_1_PhiReq/$exit
        bb_6_bb_1_PhiReq_1054_symbol <= Xexit_1056_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_6_bb_1_PhiReq
      merge_stmt_51_PhiReqMerge_1057_symbol  <=  bb_0_bb_1_PhiReq_1051_symbol or bb_6_bb_1_PhiReq_1054_symbol; -- place branch_block_stmt_13/merge_stmt_51_PhiReqMerge (optimized away) 
      merge_stmt_51_PhiAck_1058: Block -- branch_block_stmt_13/merge_stmt_51_PhiAck 
        signal merge_stmt_51_PhiAck_1058_start: Boolean;
        signal Xentry_1059_symbol: Boolean;
        signal Xexit_1060_symbol: Boolean;
        signal dummy_1061_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_51_PhiAck_1058_start <= merge_stmt_51_PhiReqMerge_1057_symbol; -- control passed to block
        Xentry_1059_symbol  <= merge_stmt_51_PhiAck_1058_start; -- transition branch_block_stmt_13/merge_stmt_51_PhiAck/$entry
        dummy_1061_symbol <= Xentry_1059_symbol; -- transition branch_block_stmt_13/merge_stmt_51_PhiAck/dummy
        Xexit_1060_symbol <= dummy_1061_symbol; -- transition branch_block_stmt_13/merge_stmt_51_PhiAck/$exit
        merge_stmt_51_PhiAck_1058_symbol <= Xexit_1060_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_51_PhiAck
      merge_stmt_88_dead_link_1062: Block -- branch_block_stmt_13/merge_stmt_88_dead_link 
        signal merge_stmt_88_dead_link_1062_start: Boolean;
        signal Xentry_1063_symbol: Boolean;
        signal Xexit_1064_symbol: Boolean;
        signal dead_transition_1065_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_88_dead_link_1062_start <= merge_stmt_88_x_xentry_x_xx_x22_symbol; -- control passed to block
        Xentry_1063_symbol  <= merge_stmt_88_dead_link_1062_start; -- transition branch_block_stmt_13/merge_stmt_88_dead_link/$entry
        dead_transition_1065_symbol <= false;
        Xexit_1064_symbol <= dead_transition_1065_symbol; -- transition branch_block_stmt_13/merge_stmt_88_dead_link/$exit
        merge_stmt_88_dead_link_1062_symbol <= Xexit_1064_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_88_dead_link
      bb_1_bb_2_PhiReq_1066: Block -- branch_block_stmt_13/bb_1_bb_2_PhiReq 
        signal bb_1_bb_2_PhiReq_1066_start: Boolean;
        signal Xentry_1067_symbol: Boolean;
        signal Xexit_1068_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_2_PhiReq_1066_start <= bb_1_bb_2_249_symbol; -- control passed to block
        Xentry_1067_symbol  <= bb_1_bb_2_PhiReq_1066_start; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$entry
        Xexit_1068_symbol <= Xentry_1067_symbol; -- transition branch_block_stmt_13/bb_1_bb_2_PhiReq/$exit
        bb_1_bb_2_PhiReq_1066_symbol <= Xexit_1068_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_2_PhiReq
      merge_stmt_88_PhiReqMerge_1069_symbol  <=  bb_1_bb_2_PhiReq_1066_symbol; -- place branch_block_stmt_13/merge_stmt_88_PhiReqMerge (optimized away) 
      merge_stmt_88_PhiAck_1070: Block -- branch_block_stmt_13/merge_stmt_88_PhiAck 
        signal merge_stmt_88_PhiAck_1070_start: Boolean;
        signal Xentry_1071_symbol: Boolean;
        signal Xexit_1072_symbol: Boolean;
        signal dummy_1073_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_88_PhiAck_1070_start <= merge_stmt_88_PhiReqMerge_1069_symbol; -- control passed to block
        Xentry_1071_symbol  <= merge_stmt_88_PhiAck_1070_start; -- transition branch_block_stmt_13/merge_stmt_88_PhiAck/$entry
        dummy_1073_symbol <= Xentry_1071_symbol; -- transition branch_block_stmt_13/merge_stmt_88_PhiAck/dummy
        Xexit_1072_symbol <= dummy_1073_symbol; -- transition branch_block_stmt_13/merge_stmt_88_PhiAck/$exit
        merge_stmt_88_PhiAck_1070_symbol <= Xexit_1072_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_88_PhiAck
      merge_stmt_109_dead_link_1074: Block -- branch_block_stmt_13/merge_stmt_109_dead_link 
        signal merge_stmt_109_dead_link_1074_start: Boolean;
        signal Xentry_1075_symbol: Boolean;
        signal Xexit_1076_symbol: Boolean;
        signal dead_transition_1077_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_109_dead_link_1074_start <= merge_stmt_109_x_xentry_x_xx_x28_symbol; -- control passed to block
        Xentry_1075_symbol  <= merge_stmt_109_dead_link_1074_start; -- transition branch_block_stmt_13/merge_stmt_109_dead_link/$entry
        dead_transition_1077_symbol <= false;
        Xexit_1076_symbol <= dead_transition_1077_symbol; -- transition branch_block_stmt_13/merge_stmt_109_dead_link/$exit
        merge_stmt_109_dead_link_1074_symbol <= Xexit_1076_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_109_dead_link
      bb_2_bb_3_PhiReq_1078: Block -- branch_block_stmt_13/bb_2_bb_3_PhiReq 
        signal bb_2_bb_3_PhiReq_1078_start: Boolean;
        signal Xentry_1079_symbol: Boolean;
        signal Xexit_1080_symbol: Boolean;
        -- 
      begin -- 
        bb_2_bb_3_PhiReq_1078_start <= bb_2_bb_3_324_symbol; -- control passed to block
        Xentry_1079_symbol  <= bb_2_bb_3_PhiReq_1078_start; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/$entry
        Xexit_1080_symbol <= Xentry_1079_symbol; -- transition branch_block_stmt_13/bb_2_bb_3_PhiReq/$exit
        bb_2_bb_3_PhiReq_1078_symbol <= Xexit_1080_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_2_bb_3_PhiReq
      merge_stmt_109_PhiReqMerge_1081_symbol  <=  bb_2_bb_3_PhiReq_1078_symbol; -- place branch_block_stmt_13/merge_stmt_109_PhiReqMerge (optimized away) 
      merge_stmt_109_PhiAck_1082: Block -- branch_block_stmt_13/merge_stmt_109_PhiAck 
        signal merge_stmt_109_PhiAck_1082_start: Boolean;
        signal Xentry_1083_symbol: Boolean;
        signal Xexit_1084_symbol: Boolean;
        signal dummy_1085_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_109_PhiAck_1082_start <= merge_stmt_109_PhiReqMerge_1081_symbol; -- control passed to block
        Xentry_1083_symbol  <= merge_stmt_109_PhiAck_1082_start; -- transition branch_block_stmt_13/merge_stmt_109_PhiAck/$entry
        dummy_1085_symbol <= Xentry_1083_symbol; -- transition branch_block_stmt_13/merge_stmt_109_PhiAck/dummy
        Xexit_1084_symbol <= dummy_1085_symbol; -- transition branch_block_stmt_13/merge_stmt_109_PhiAck/$exit
        merge_stmt_109_PhiAck_1082_symbol <= Xexit_1084_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_109_PhiAck
      bb_1_bb_4_PhiReq_1086: Block -- branch_block_stmt_13/bb_1_bb_4_PhiReq 
        signal bb_1_bb_4_PhiReq_1086_start: Boolean;
        signal Xentry_1087_symbol: Boolean;
        signal Xexit_1088_symbol: Boolean;
        -- 
      begin -- 
        bb_1_bb_4_PhiReq_1086_start <= bb_1_bb_4_250_symbol; -- control passed to block
        Xentry_1087_symbol  <= bb_1_bb_4_PhiReq_1086_start; -- transition branch_block_stmt_13/bb_1_bb_4_PhiReq/$entry
        Xexit_1088_symbol <= Xentry_1087_symbol; -- transition branch_block_stmt_13/bb_1_bb_4_PhiReq/$exit
        bb_1_bb_4_PhiReq_1086_symbol <= Xexit_1088_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_1_bb_4_PhiReq
      bb_2_bb_4_PhiReq_1089: Block -- branch_block_stmt_13/bb_2_bb_4_PhiReq 
        signal bb_2_bb_4_PhiReq_1089_start: Boolean;
        signal Xentry_1090_symbol: Boolean;
        signal Xexit_1091_symbol: Boolean;
        -- 
      begin -- 
        bb_2_bb_4_PhiReq_1089_start <= bb_2_bb_4_325_symbol; -- control passed to block
        Xentry_1090_symbol  <= bb_2_bb_4_PhiReq_1089_start; -- transition branch_block_stmt_13/bb_2_bb_4_PhiReq/$entry
        Xexit_1091_symbol <= Xentry_1090_symbol; -- transition branch_block_stmt_13/bb_2_bb_4_PhiReq/$exit
        bb_2_bb_4_PhiReq_1089_symbol <= Xexit_1091_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_2_bb_4_PhiReq
      merge_stmt_229_PhiReqMerge_1092_symbol  <=  bb_1_bb_4_PhiReq_1086_symbol or bb_2_bb_4_PhiReq_1089_symbol; -- place branch_block_stmt_13/merge_stmt_229_PhiReqMerge (optimized away) 
      merge_stmt_229_PhiAck_1093: Block -- branch_block_stmt_13/merge_stmt_229_PhiAck 
        signal merge_stmt_229_PhiAck_1093_start: Boolean;
        signal Xentry_1094_symbol: Boolean;
        signal Xexit_1095_symbol: Boolean;
        signal dummy_1096_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_229_PhiAck_1093_start <= merge_stmt_229_PhiReqMerge_1092_symbol; -- control passed to block
        Xentry_1094_symbol  <= merge_stmt_229_PhiAck_1093_start; -- transition branch_block_stmt_13/merge_stmt_229_PhiAck/$entry
        dummy_1096_symbol <= Xentry_1094_symbol; -- transition branch_block_stmt_13/merge_stmt_229_PhiAck/dummy
        Xexit_1095_symbol <= dummy_1096_symbol; -- transition branch_block_stmt_13/merge_stmt_229_PhiAck/$exit
        merge_stmt_229_PhiAck_1093_symbol <= Xexit_1095_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_229_PhiAck
      merge_stmt_252_dead_link_1097: Block -- branch_block_stmt_13/merge_stmt_252_dead_link 
        signal merge_stmt_252_dead_link_1097_start: Boolean;
        signal Xentry_1098_symbol: Boolean;
        signal Xexit_1099_symbol: Boolean;
        signal dead_transition_1100_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_252_dead_link_1097_start <= merge_stmt_252_x_xentry_x_xx_x38_symbol; -- control passed to block
        Xentry_1098_symbol  <= merge_stmt_252_dead_link_1097_start; -- transition branch_block_stmt_13/merge_stmt_252_dead_link/$entry
        dead_transition_1100_symbol <= false;
        Xexit_1099_symbol <= dead_transition_1100_symbol; -- transition branch_block_stmt_13/merge_stmt_252_dead_link/$exit
        merge_stmt_252_dead_link_1097_symbol <= Xexit_1099_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_252_dead_link
      bb_4_bb_5_PhiReq_1101: Block -- branch_block_stmt_13/bb_4_bb_5_PhiReq 
        signal bb_4_bb_5_PhiReq_1101_start: Boolean;
        signal Xentry_1102_symbol: Boolean;
        signal Xexit_1103_symbol: Boolean;
        -- 
      begin -- 
        bb_4_bb_5_PhiReq_1101_start <= bb_4_bb_5_923_symbol; -- control passed to block
        Xentry_1102_symbol  <= bb_4_bb_5_PhiReq_1101_start; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/$entry
        Xexit_1103_symbol <= Xentry_1102_symbol; -- transition branch_block_stmt_13/bb_4_bb_5_PhiReq/$exit
        bb_4_bb_5_PhiReq_1101_symbol <= Xexit_1103_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_4_bb_5_PhiReq
      merge_stmt_252_PhiReqMerge_1104_symbol  <=  bb_4_bb_5_PhiReq_1101_symbol; -- place branch_block_stmt_13/merge_stmt_252_PhiReqMerge (optimized away) 
      merge_stmt_252_PhiAck_1105: Block -- branch_block_stmt_13/merge_stmt_252_PhiAck 
        signal merge_stmt_252_PhiAck_1105_start: Boolean;
        signal Xentry_1106_symbol: Boolean;
        signal Xexit_1107_symbol: Boolean;
        signal dummy_1108_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_252_PhiAck_1105_start <= merge_stmt_252_PhiReqMerge_1104_symbol; -- control passed to block
        Xentry_1106_symbol  <= merge_stmt_252_PhiAck_1105_start; -- transition branch_block_stmt_13/merge_stmt_252_PhiAck/$entry
        dummy_1108_symbol <= Xentry_1106_symbol; -- transition branch_block_stmt_13/merge_stmt_252_PhiAck/dummy
        Xexit_1107_symbol <= dummy_1108_symbol; -- transition branch_block_stmt_13/merge_stmt_252_PhiAck/$exit
        merge_stmt_252_PhiAck_1105_symbol <= Xexit_1107_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_252_PhiAck
      bb_3_bb_6_PhiReq_1109: Block -- branch_block_stmt_13/bb_3_bb_6_PhiReq 
        signal bb_3_bb_6_PhiReq_1109_start: Boolean;
        signal Xentry_1110_symbol: Boolean;
        signal Xexit_1111_symbol: Boolean;
        -- 
      begin -- 
        bb_3_bb_6_PhiReq_1109_start <= bb_3_bb_6_32_symbol; -- control passed to block
        Xentry_1110_symbol  <= bb_3_bb_6_PhiReq_1109_start; -- transition branch_block_stmt_13/bb_3_bb_6_PhiReq/$entry
        Xexit_1111_symbol <= Xentry_1110_symbol; -- transition branch_block_stmt_13/bb_3_bb_6_PhiReq/$exit
        bb_3_bb_6_PhiReq_1109_symbol <= Xexit_1111_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_3_bb_6_PhiReq
      bb_4_bb_6_PhiReq_1112: Block -- branch_block_stmt_13/bb_4_bb_6_PhiReq 
        signal bb_4_bb_6_PhiReq_1112_start: Boolean;
        signal Xentry_1113_symbol: Boolean;
        signal Xexit_1114_symbol: Boolean;
        -- 
      begin -- 
        bb_4_bb_6_PhiReq_1112_start <= bb_4_bb_6_924_symbol; -- control passed to block
        Xentry_1113_symbol  <= bb_4_bb_6_PhiReq_1112_start; -- transition branch_block_stmt_13/bb_4_bb_6_PhiReq/$entry
        Xexit_1114_symbol <= Xentry_1113_symbol; -- transition branch_block_stmt_13/bb_4_bb_6_PhiReq/$exit
        bb_4_bb_6_PhiReq_1112_symbol <= Xexit_1114_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_4_bb_6_PhiReq
      bb_5_bb_6_PhiReq_1115: Block -- branch_block_stmt_13/bb_5_bb_6_PhiReq 
        signal bb_5_bb_6_PhiReq_1115_start: Boolean;
        signal Xentry_1116_symbol: Boolean;
        signal Xexit_1117_symbol: Boolean;
        -- 
      begin -- 
        bb_5_bb_6_PhiReq_1115_start <= bb_5_bb_6_42_symbol; -- control passed to block
        Xentry_1116_symbol  <= bb_5_bb_6_PhiReq_1115_start; -- transition branch_block_stmt_13/bb_5_bb_6_PhiReq/$entry
        Xexit_1117_symbol <= Xentry_1116_symbol; -- transition branch_block_stmt_13/bb_5_bb_6_PhiReq/$exit
        bb_5_bb_6_PhiReq_1115_symbol <= Xexit_1117_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/bb_5_bb_6_PhiReq
      merge_stmt_259_PhiReqMerge_1118_symbol  <=  bb_3_bb_6_PhiReq_1109_symbol or bb_4_bb_6_PhiReq_1112_symbol or bb_5_bb_6_PhiReq_1115_symbol; -- place branch_block_stmt_13/merge_stmt_259_PhiReqMerge (optimized away) 
      merge_stmt_259_PhiAck_1119: Block -- branch_block_stmt_13/merge_stmt_259_PhiAck 
        signal merge_stmt_259_PhiAck_1119_start: Boolean;
        signal Xentry_1120_symbol: Boolean;
        signal Xexit_1121_symbol: Boolean;
        signal dummy_1122_symbol : Boolean;
        -- 
      begin -- 
        merge_stmt_259_PhiAck_1119_start <= merge_stmt_259_PhiReqMerge_1118_symbol; -- control passed to block
        Xentry_1120_symbol  <= merge_stmt_259_PhiAck_1119_start; -- transition branch_block_stmt_13/merge_stmt_259_PhiAck/$entry
        dummy_1122_symbol <= Xentry_1120_symbol; -- transition branch_block_stmt_13/merge_stmt_259_PhiAck/dummy
        Xexit_1121_symbol <= dummy_1122_symbol; -- transition branch_block_stmt_13/merge_stmt_259_PhiAck/$exit
        merge_stmt_259_PhiAck_1119_symbol <= Xexit_1121_symbol; -- control passed from block 
        -- 
      end Block; -- branch_block_stmt_13/merge_stmt_259_PhiAck
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
    signal binary_170_wire : std_logic_vector(31 downto 0);
    signal curr_state_24 : std_logic_vector(31 downto 0);
    signal decoded_src_40 : std_logic_vector(31 downto 0);
    signal iNsTr_10_81 : std_logic_vector(0 downto 0);
    signal iNsTr_12_92 : std_logic_vector(7 downto 0);
    signal iNsTr_13_96 : std_logic_vector(31 downto 0);
    signal iNsTr_14_102 : std_logic_vector(0 downto 0);
    signal iNsTr_16_233 : std_logic_vector(7 downto 0);
    signal iNsTr_17_237 : std_logic_vector(31 downto 0);
    signal iNsTr_18_245 : std_logic_vector(0 downto 0);
    signal iNsTr_20_113 : std_logic_vector(63 downto 0);
    signal iNsTr_21_119 : std_logic_vector(63 downto 0);
    signal iNsTr_23_127 : std_logic_vector(63 downto 0);
    signal iNsTr_24_133 : std_logic_vector(63 downto 0);
    signal iNsTr_25_137 : std_logic_vector(15 downto 0);
    signal iNsTr_27_145 : std_logic_vector(63 downto 0);
    signal iNsTr_28_154 : std_logic_vector(0 downto 0);
    signal iNsTr_29_158 : std_logic_vector(15 downto 0);
    signal iNsTr_30_162 : std_logic_vector(31 downto 0);
    signal iNsTr_31_172 : std_logic_vector(31 downto 0);
    signal iNsTr_32_178 : std_logic_vector(31 downto 0);
    signal iNsTr_33_184 : std_logic_vector(31 downto 0);
    signal iNsTr_34_189 : std_logic_vector(63 downto 0);
    signal iNsTr_36_197 : std_logic_vector(63 downto 0);
    signal iNsTr_37_203 : std_logic_vector(63 downto 0);
    signal iNsTr_38_207 : std_logic_vector(63 downto 0);
    signal iNsTr_39_213 : std_logic_vector(63 downto 0);
    signal iNsTr_3_54 : std_logic_vector(7 downto 0);
    signal iNsTr_40_218 : std_logic_vector(63 downto 0);
    signal iNsTr_46_263 : std_logic_vector(7 downto 0);
    signal iNsTr_49_270 : std_logic_vector(63 downto 0);
    signal iNsTr_6_61 : std_logic_vector(63 downto 0);
    signal iNsTr_8_69 : std_logic_vector(7 downto 0);
    signal iNsTr_9_74 : std_logic_vector(31 downto 0);
    signal inctrl_28 : std_logic_vector(31 downto 0);
    signal indata_32 : std_logic_vector(31 downto 0);
    signal new_dest_44 : std_logic_vector(31 downto 0);
    signal pkt_is_from_cpu_36 : std_logic_vector(31 downto 0);
    signal ptr_deref_112_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_112_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_121_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_121_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_121_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_126_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_126_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_139_data_0 : std_logic_vector(15 downto 0);
    signal ptr_deref_139_wire : std_logic_vector(15 downto 0);
    signal ptr_deref_139_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_144_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_144_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_157_data_0 : std_logic_vector(15 downto 0);
    signal ptr_deref_157_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_191_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_191_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_191_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_196_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_196_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_206_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_206_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_220_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_220_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_220_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_224_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_224_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_224_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_232_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_232_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_254_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_254_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_254_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_262_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_262_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_269_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_269_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_46_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_46_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_46_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_56_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_56_wire : std_logic_vector(7 downto 0);
    signal ptr_deref_56_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_63_data_0 : std_logic_vector(63 downto 0);
    signal ptr_deref_63_wire : std_logic_vector(63 downto 0);
    signal ptr_deref_63_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_68_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_68_word_address_0 : std_logic_vector(0 downto 0);
    signal ptr_deref_91_data_0 : std_logic_vector(7 downto 0);
    signal ptr_deref_91_word_address_0 : std_logic_vector(0 downto 0);
    signal type_cast_100_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_117_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_131_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_149_wire : std_logic_vector(63 downto 0);
    signal type_cast_152_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_166_wire : std_logic_vector(31 downto 0);
    signal type_cast_169_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_176_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_187_wire : std_logic_vector(63 downto 0);
    signal type_cast_201_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_211_wire_constant : std_logic_vector(63 downto 0);
    signal type_cast_226_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_240_wire : std_logic_vector(31 downto 0);
    signal type_cast_243_wire_constant : std_logic_vector(31 downto 0);
    signal type_cast_256_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_48_wire_constant : std_logic_vector(7 downto 0);
    signal type_cast_78_wire_constant : std_logic_vector(31 downto 0);
    signal xxoutput_port_lookupxxbodyxxcurr_state_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxoutput_port_lookupxxbodyxxdecoded_src_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxoutput_port_lookupxxbodyxxinctrl_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxoutput_port_lookupxxbodyxxindata_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxoutput_port_lookupxxbodyxxnew_dest_alloc_base_address : std_logic_vector(0 downto 0);
    signal xxoutput_port_lookupxxbodyxxpkt_is_from_cpu_alloc_base_address : std_logic_vector(0 downto 0);
    -- 
  begin -- 
    curr_state_24 <= "00000000000000000000000000000000";
    decoded_src_40 <= "00000000000000000000000000000000";
    inctrl_28 <= "00000000000000000000000000000000";
    indata_32 <= "00000000000000000000000000000000";
    new_dest_44 <= "00000000000000000000000000000000";
    pkt_is_from_cpu_36 <= "00000000000000000000000000000000";
    ptr_deref_112_word_address_0 <= "0";
    ptr_deref_121_word_address_0 <= "0";
    ptr_deref_126_word_address_0 <= "0";
    ptr_deref_139_word_address_0 <= "0";
    ptr_deref_144_word_address_0 <= "0";
    ptr_deref_157_word_address_0 <= "0";
    ptr_deref_191_word_address_0 <= "0";
    ptr_deref_196_word_address_0 <= "0";
    ptr_deref_206_word_address_0 <= "0";
    ptr_deref_220_word_address_0 <= "0";
    ptr_deref_224_word_address_0 <= "0";
    ptr_deref_232_word_address_0 <= "0";
    ptr_deref_254_word_address_0 <= "0";
    ptr_deref_262_word_address_0 <= "0";
    ptr_deref_269_word_address_0 <= "0";
    ptr_deref_46_word_address_0 <= "0";
    ptr_deref_56_word_address_0 <= "0";
    ptr_deref_63_word_address_0 <= "0";
    ptr_deref_68_word_address_0 <= "0";
    ptr_deref_91_word_address_0 <= "0";
    type_cast_100_wire_constant <= "00000000000000000000000011111111";
    type_cast_117_wire_constant <= "0000000000000000000000000000000000000000000000010000000000000000";
    type_cast_131_wire_constant <= "0000000000000000000000000000000000000000000000000000000000010000";
    type_cast_152_wire_constant <= "0000000000000000000000000000000000000000000000000000000000000000";
    type_cast_169_wire_constant <= "00000000000000000000000000000001";
    type_cast_176_wire_constant <= "00000000000000000000000000000001";
    type_cast_201_wire_constant <= "0000000000000000111111111111111111111111111111111111111111111111";
    type_cast_211_wire_constant <= "0000000000000000000000000000000000000000000000000000000000110000";
    type_cast_226_wire_constant <= "00000001";
    type_cast_243_wire_constant <= "00000000000000000000000000000000";
    type_cast_256_wire_constant <= "00000000";
    type_cast_48_wire_constant <= "00000000";
    type_cast_78_wire_constant <= "00000000000000000000000000000000";
    xxoutput_port_lookupxxbodyxxcurr_state_alloc_base_address <= "0";
    xxoutput_port_lookupxxbodyxxdecoded_src_alloc_base_address <= "0";
    xxoutput_port_lookupxxbodyxxinctrl_alloc_base_address <= "0";
    xxoutput_port_lookupxxbodyxxindata_alloc_base_address <= "0";
    xxoutput_port_lookupxxbodyxxnew_dest_alloc_base_address <= "0";
    xxoutput_port_lookupxxbodyxxpkt_is_from_cpu_alloc_base_address <= "0";
    ternary_183_inst: SelectBase generic map(data_width => 32) -- 
      port map( x => iNsTr_31_172, y => iNsTr_32_178, sel => iNsTr_28_154, z => iNsTr_33_184, req => ternary_183_inst_req_0, ack => ternary_183_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_136_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 16, flow_through => false ) 
      port map( din => iNsTr_24_133, dout => iNsTr_25_137, req => type_cast_136_inst_req_0, ack => type_cast_136_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_149_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => true ) 
      port map( din => iNsTr_27_145, dout => type_cast_149_wire, req => type_cast_149_inst_req_0, ack => type_cast_149_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_161_inst: RegisterBase --
      generic map(in_data_width => 16,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_29_158, dout => iNsTr_30_162, req => type_cast_161_inst_req_0, ack => type_cast_161_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_166_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_30_162, dout => type_cast_166_wire, req => type_cast_166_inst_req_0, ack => type_cast_166_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_171_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => false ) 
      port map( din => binary_170_wire, dout => iNsTr_31_172, req => type_cast_171_inst_req_0, ack => type_cast_171_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_188_inst: RegisterBase --
      generic map(in_data_width => 64,out_data_width => 64, flow_through => false ) 
      port map( din => type_cast_187_wire, dout => iNsTr_34_189, req => type_cast_188_inst_req_0, ack => type_cast_188_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_236_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_16_233, dout => iNsTr_17_237, req => type_cast_236_inst_req_0, ack => type_cast_236_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_240_inst: RegisterBase --
      generic map(in_data_width => 32,out_data_width => 32, flow_through => true ) 
      port map( din => iNsTr_17_237, dout => type_cast_240_wire, req => type_cast_240_inst_req_0, ack => type_cast_240_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_73_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_8_69, dout => iNsTr_9_74, req => type_cast_73_inst_req_0, ack => type_cast_73_inst_ack_0, clk => clk, reset => reset); -- 
    type_cast_95_inst: RegisterBase --
      generic map(in_data_width => 8,out_data_width => 32, flow_through => false ) 
      port map( din => iNsTr_12_92, dout => iNsTr_13_96, req => type_cast_95_inst_req_0, ack => type_cast_95_inst_ack_0, clk => clk, reset => reset); -- 
    ptr_deref_112_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_112_gather_scatter_ack_0 <= ptr_deref_112_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_112_data_0;
      iNsTr_20_113 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_121_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_121_gather_scatter_ack_0 <= ptr_deref_121_gather_scatter_req_0;
      aggregated_sig <= iNsTr_21_119;
      ptr_deref_121_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_126_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_126_gather_scatter_ack_0 <= ptr_deref_126_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_126_data_0;
      iNsTr_23_127 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_139_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(15 downto 0); --
    begin -- 
      ptr_deref_139_gather_scatter_ack_0 <= ptr_deref_139_gather_scatter_req_0;
      aggregated_sig <= iNsTr_25_137;
      ptr_deref_139_data_0 <= aggregated_sig(15 downto 0);
      --
    end Block;
    ptr_deref_144_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_144_gather_scatter_ack_0 <= ptr_deref_144_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_144_data_0;
      iNsTr_27_145 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_157_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(15 downto 0); --
    begin -- 
      ptr_deref_157_gather_scatter_ack_0 <= ptr_deref_157_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_157_data_0;
      iNsTr_29_158 <= aggregated_sig(15 downto 0);
      --
    end Block;
    ptr_deref_191_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_191_gather_scatter_ack_0 <= ptr_deref_191_gather_scatter_req_0;
      aggregated_sig <= iNsTr_34_189;
      ptr_deref_191_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_196_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_196_gather_scatter_ack_0 <= ptr_deref_196_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_196_data_0;
      iNsTr_36_197 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_206_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_206_gather_scatter_ack_0 <= ptr_deref_206_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_206_data_0;
      iNsTr_38_207 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_220_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_220_gather_scatter_ack_0 <= ptr_deref_220_gather_scatter_req_0;
      aggregated_sig <= iNsTr_40_218;
      ptr_deref_220_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_224_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_224_gather_scatter_ack_0 <= ptr_deref_224_gather_scatter_req_0;
      aggregated_sig <= type_cast_226_wire_constant;
      ptr_deref_224_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_232_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_232_gather_scatter_ack_0 <= ptr_deref_232_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_232_data_0;
      iNsTr_16_233 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_254_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_254_gather_scatter_ack_0 <= ptr_deref_254_gather_scatter_req_0;
      aggregated_sig <= type_cast_256_wire_constant;
      ptr_deref_254_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_262_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_262_gather_scatter_ack_0 <= ptr_deref_262_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_262_data_0;
      iNsTr_46_263 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_269_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_269_gather_scatter_ack_0 <= ptr_deref_269_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_269_data_0;
      iNsTr_49_270 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_46_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_46_gather_scatter_ack_0 <= ptr_deref_46_gather_scatter_req_0;
      aggregated_sig <= type_cast_48_wire_constant;
      ptr_deref_46_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_56_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_56_gather_scatter_ack_0 <= ptr_deref_56_gather_scatter_req_0;
      aggregated_sig <= iNsTr_3_54;
      ptr_deref_56_data_0 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_63_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(63 downto 0); --
    begin -- 
      ptr_deref_63_gather_scatter_ack_0 <= ptr_deref_63_gather_scatter_req_0;
      aggregated_sig <= iNsTr_6_61;
      ptr_deref_63_data_0 <= aggregated_sig(63 downto 0);
      --
    end Block;
    ptr_deref_68_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_68_gather_scatter_ack_0 <= ptr_deref_68_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_68_data_0;
      iNsTr_8_69 <= aggregated_sig(7 downto 0);
      --
    end Block;
    ptr_deref_91_gather_scatter: Block -- 
      signal aggregated_sig: std_logic_vector(7 downto 0); --
    begin -- 
      ptr_deref_91_gather_scatter_ack_0 <= ptr_deref_91_gather_scatter_req_0;
      aggregated_sig <= ptr_deref_91_data_0;
      iNsTr_12_92 <= aggregated_sig(7 downto 0);
      --
    end Block;
    if_stmt_103_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_14_102;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_103_branch_req_0,
          ack0 => if_stmt_103_branch_ack_0,
          ack1 => if_stmt_103_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_246_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_18_245;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_246_branch_req_0,
          ack0 => if_stmt_246_branch_ack_0,
          ack1 => if_stmt_246_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    if_stmt_82_branch: Block -- 
      -- branch-block
      signal condition_sig : std_logic_vector(0 downto 0);
      begin 
      condition_sig <= iNsTr_10_81;
      branch_instance: BranchBase -- 
        generic map( condition_width => 1)
        port map( -- 
          condition => condition_sig,
          req => if_stmt_82_branch_req_0,
          ack0 => if_stmt_82_branch_ack_0,
          ack1 => if_stmt_82_branch_ack_1,
          clk => clk,
          reset => reset); -- 
      --
    end Block; -- branch-block
    -- shared split operator group (0) : binary_101_inst 
    SplitOperatorGroup0: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_13_96;
      iNsTr_14_102 <= data_out(0 downto 0);
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
          constant_operand => "00000000000000000000000011111111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_101_inst_req_0,
          ackL => binary_101_inst_ack_0,
          reqR => binary_101_inst_req_1,
          ackR => binary_101_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 0
    -- shared split operator group (1) : binary_118_inst 
    SplitOperatorGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_20_113;
      iNsTr_21_119 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000000000000000000000000000000000010000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_118_inst_req_0,
          ackL => binary_118_inst_ack_0,
          reqR => binary_118_inst_req_1,
          ackR => binary_118_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 1
    -- shared split operator group (2) : binary_132_inst 
    SplitOperatorGroup2: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_23_127;
      iNsTr_24_133 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntLSHR",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000000000000000000000000000000000000000000000010000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_132_inst_req_0,
          ackL => binary_132_inst_ack_0,
          reqR => binary_132_inst_req_1,
          ackR => binary_132_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 2
    -- shared split operator group (3) : binary_153_inst 
    SplitOperatorGroup3: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_149_wire;
      iNsTr_28_154 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntNe",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 1,
          constant_operand => "0000000000000000000000000000000000000000000000000000000000000000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_153_inst_req_0,
          ackL => binary_153_inst_ack_0,
          reqR => binary_153_inst_req_1,
          ackR => binary_153_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 3
    -- shared split operator group (4) : binary_170_inst 
    SplitOperatorGroup4: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_166_wire;
      binary_170_wire <= data_out(31 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntASHR",
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
          flow_through => true--
        ) 
        port map ( -- 
          reqL => binary_170_inst_req_0,
          ackL => binary_170_inst_ack_0,
          reqR => binary_170_inst_req_1,
          ackR => binary_170_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 4
    -- shared split operator group (5) : binary_177_inst 
    SplitOperatorGroup5: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(31 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_30_162;
      iNsTr_32_178 <= data_out(31 downto 0);
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
          reqL => binary_177_inst_req_0,
          ackL => binary_177_inst_ack_0,
          reqR => binary_177_inst_req_1,
          ackR => binary_177_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 5
    -- shared split operator group (6) : binary_202_inst 
    SplitOperatorGroup6: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_36_197;
      iNsTr_37_203 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntAnd",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000111111111111111111111111111111111111111111111111",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_202_inst_req_0,
          ackL => binary_202_inst_ack_0,
          reqR => binary_202_inst_req_1,
          ackR => binary_202_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 6
    -- shared split operator group (7) : binary_212_inst 
    SplitOperatorGroup7: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_38_207;
      iNsTr_39_213 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntSHL",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 0, 
          num_inputs    => 1,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0000000000000000000000000000000000000000000000000000000000110000",
          use_constant  => true,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_212_inst_req_0,
          ackL => binary_212_inst_ack_0,
          reqR => binary_212_inst_req_1,
          ackR => binary_212_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 7
    -- shared split operator group (8) : binary_217_inst 
    SplitOperatorGroup8: Block -- 
      signal data_in: std_logic_vector(127 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_37_203 & iNsTr_39_213;
      iNsTr_40_218 <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntOr",
          input1_is_int => true, 
          input1_characteristic_width => 0, 
          input1_mantissa_width    => 0, 
          iwidth_1  => 64,
          input2_is_int => true, 
          input2_characteristic_width => 0, 
          input2_mantissa_width => 0, 
          iwidth_2      => 64, 
          num_inputs    => 2,
          output_is_int => true,
          output_characteristic_width  => 0, 
          output_mantissa_width => 0, 
          owidth => 64,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => false--
        ) 
        port map ( -- 
          reqL => binary_217_inst_req_0,
          ackL => binary_217_inst_ack_0,
          reqR => binary_217_inst_req_1,
          ackR => binary_217_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 8
    -- shared split operator group (9) : binary_244_inst 
    SplitOperatorGroup9: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= type_cast_240_wire;
      iNsTr_18_245 <= data_out(0 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntNe",
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
          reqL => binary_244_inst_req_0,
          ackL => binary_244_inst_ack_0,
          reqR => binary_244_inst_req_1,
          ackR => binary_244_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 9
    -- shared split operator group (10) : binary_79_inst 
    SplitOperatorGroup10: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(0 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_9_74;
      iNsTr_10_81 <= data_out(0 downto 0);
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
          reqL => binary_79_inst_req_0,
          ackL => binary_79_inst_ack_0,
          reqR => binary_79_inst_req_1,
          ackR => binary_79_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 10
    -- shared split operator group (11) : type_cast_187_inst 
    SplitOperatorGroup11: Block -- 
      signal data_in: std_logic_vector(31 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      data_in <= iNsTr_33_184;
      type_cast_187_wire <= data_out(63 downto 0);
      UnsharedOperator: UnsharedOperatorBase -- 
        generic map ( -- 
          operator_id => "ApIntToApIntSigned",
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
          owidth => 64,
          constant_operand => "0",
          use_constant  => false,
          zero_delay => false, 
          flow_through => true--
        ) 
        port map ( -- 
          reqL => type_cast_187_inst_req_0,
          ackL => type_cast_187_inst_ack_0,
          reqR => type_cast_187_inst_req_1,
          ackR => type_cast_187_inst_ack_1,
          dataL => data_in, 
          dataR => data_out,
          clk => clk,
          reset => reset); -- 
      -- 
    end Block; -- split operator group 11
    -- shared load operator group (0) : ptr_deref_269_load_0 ptr_deref_112_load_0 
    LoadGroup0: Block -- 
      signal data_in: std_logic_vector(1 downto 0);
      signal data_out: std_logic_vector(127 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_269_load_0_req_0;
      reqL(0) <= ptr_deref_112_load_0_req_0;
      ptr_deref_269_load_0_ack_0 <= ackL(1);
      ptr_deref_112_load_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_269_load_0_req_1;
      reqR(0) <= ptr_deref_112_load_0_req_1;
      ptr_deref_269_load_0_ack_1 <= ackR(1);
      ptr_deref_112_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_269_word_address_0 & ptr_deref_112_word_address_0;
      ptr_deref_269_data_0 <= data_out(127 downto 64);
      ptr_deref_112_data_0 <= data_out(63 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_6_lr_req(2),
          mack => memory_space_6_lr_ack(2),
          maddr => memory_space_6_lr_addr(2 downto 2),
          mtag => memory_space_6_lr_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 64,  num_reqs => 2,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_6_lc_req(2),
          mack => memory_space_6_lc_ack(2),
          mdata => memory_space_6_lc_data(191 downto 128),
          mtag => memory_space_6_lc_tag(5 downto 4),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 0
    -- shared load operator group (1) : ptr_deref_126_load_0 
    LoadGroup1: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_126_load_0_req_0;
      ptr_deref_126_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_126_load_0_req_1;
      ptr_deref_126_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_126_word_address_0;
      ptr_deref_126_data_0 <= data_out(63 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_6_lr_req(1),
          mack => memory_space_6_lr_ack(1),
          maddr => memory_space_6_lr_addr(1 downto 1),
          mtag => memory_space_6_lr_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 64,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_6_lc_req(1),
          mack => memory_space_6_lc_ack(1),
          mdata => memory_space_6_lc_data(127 downto 64),
          mtag => memory_space_6_lc_tag(3 downto 2),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 1
    -- shared load operator group (2) : ptr_deref_144_load_0 
    LoadGroup2: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_144_load_0_req_0;
      ptr_deref_144_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_144_load_0_req_1;
      ptr_deref_144_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_144_word_address_0;
      ptr_deref_144_data_0 <= data_out(63 downto 0);
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
        generic map ( data_width => 64,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_7_lc_req(0),
          mack => memory_space_7_lc_ack(0),
          mdata => memory_space_7_lc_data(63 downto 0),
          mtag => memory_space_7_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 2
    -- shared load operator group (3) : ptr_deref_157_load_0 
    LoadGroup3: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_157_load_0_req_0;
      ptr_deref_157_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_157_load_0_req_1;
      ptr_deref_157_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_157_word_address_0;
      ptr_deref_157_data_0 <= data_out(15 downto 0);
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
        generic map ( data_width => 16,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_8_lc_req(0),
          mack => memory_space_8_lc_ack(0),
          mdata => memory_space_8_lc_data(15 downto 0),
          mtag => memory_space_8_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 3
    -- shared load operator group (4) : ptr_deref_196_load_0 
    LoadGroup4: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_196_load_0_req_0;
      ptr_deref_196_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_196_load_0_req_1;
      ptr_deref_196_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_196_word_address_0;
      ptr_deref_196_data_0 <= data_out(63 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
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
        generic map ( data_width => 64,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_6_lc_req(0),
          mack => memory_space_6_lc_ack(0),
          mdata => memory_space_6_lc_data(63 downto 0),
          mtag => memory_space_6_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 4
    -- shared load operator group (5) : ptr_deref_206_load_0 
    LoadGroup5: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_206_load_0_req_0;
      ptr_deref_206_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_206_load_0_req_1;
      ptr_deref_206_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_206_word_address_0;
      ptr_deref_206_data_0 <= data_out(63 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_9_lr_req(0),
          mack => memory_space_9_lr_ack(0),
          maddr => memory_space_9_lr_addr(0 downto 0),
          mtag => memory_space_9_lr_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 64,  num_reqs => 1,  tag_length => 1,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_9_lc_req(0),
          mack => memory_space_9_lc_ack(0),
          mdata => memory_space_9_lc_data(63 downto 0),
          mtag => memory_space_9_lc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 5
    -- shared load operator group (6) : ptr_deref_232_load_0 ptr_deref_262_load_0 ptr_deref_91_load_0 
    LoadGroup6: Block -- 
      signal data_in: std_logic_vector(2 downto 0);
      signal data_out: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_232_load_0_req_0;
      reqL(1) <= ptr_deref_262_load_0_req_0;
      reqL(0) <= ptr_deref_91_load_0_req_0;
      ptr_deref_232_load_0_ack_0 <= ackL(2);
      ptr_deref_262_load_0_ack_0 <= ackL(1);
      ptr_deref_91_load_0_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_232_load_0_req_1;
      reqR(1) <= ptr_deref_262_load_0_req_1;
      reqR(0) <= ptr_deref_91_load_0_req_1;
      ptr_deref_232_load_0_ack_1 <= ackR(2);
      ptr_deref_262_load_0_ack_1 <= ackR(1);
      ptr_deref_91_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_232_word_address_0 & ptr_deref_262_word_address_0 & ptr_deref_91_word_address_0;
      ptr_deref_232_data_0 <= data_out(23 downto 16);
      ptr_deref_262_data_0 <= data_out(15 downto 8);
      ptr_deref_91_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqL => reqL , 
          ackL => ackL , 
          dataL => data_in, 
          mreq => memory_space_5_lr_req(0),
          mack => memory_space_5_lr_ack(0),
          maddr => memory_space_5_lr_addr(0 downto 0),
          mtag => memory_space_5_lr_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      LoadComplete: LoadCompleteShared -- 
        generic map ( data_width => 8,  num_reqs => 3,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_5_lc_req(0),
          mack => memory_space_5_lc_ack(0),
          mdata => memory_space_5_lc_data(7 downto 0),
          mtag => memory_space_5_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 6
    -- shared load operator group (7) : ptr_deref_68_load_0 
    LoadGroup7: Block -- 
      signal data_in: std_logic_vector(0 downto 0);
      signal data_out: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_68_load_0_req_0;
      ptr_deref_68_load_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_68_load_0_req_1;
      ptr_deref_68_load_0_ack_1 <= ackR(0);
      data_in <= ptr_deref_68_word_address_0;
      ptr_deref_68_data_0 <= data_out(7 downto 0);
      LoadReq: LoadReqShared -- 
        generic map (addr_width => 1,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
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
        generic map ( data_width => 8,  num_reqs => 1,  tag_length => 2,  no_arbitration => true)
        port map ( -- 
          reqR => reqR , 
          ackR => ackR , 
          dataR => data_out, 
          mreq => memory_space_4_lc_req(0),
          mack => memory_space_4_lc_ack(0),
          mdata => memory_space_4_lc_data(7 downto 0),
          mtag => memory_space_4_lc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- load group 7
    -- shared store operator group (0) : ptr_deref_121_store_0 
    StoreGroup0: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_121_store_0_req_0;
      ptr_deref_121_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_121_store_0_req_1;
      ptr_deref_121_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_121_word_address_0;
      data_in <= ptr_deref_121_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 64,
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
          mdata => memory_space_7_sr_data(63 downto 0),
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
    end Block; -- store group 0
    -- shared store operator group (1) : ptr_deref_139_store_0 
    StoreGroup1: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(15 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_139_store_0_req_0;
      ptr_deref_139_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_139_store_0_req_1;
      ptr_deref_139_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_139_word_address_0;
      data_in <= ptr_deref_139_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 16,
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
          mdata => memory_space_8_sr_data(15 downto 0),
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
    end Block; -- store group 1
    -- shared store operator group (2) : ptr_deref_191_store_0 
    StoreGroup2: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(63 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_191_store_0_req_0;
      ptr_deref_191_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_191_store_0_req_1;
      ptr_deref_191_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_191_word_address_0;
      data_in <= ptr_deref_191_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 64,
        num_reqs => 1,
        tag_length => 1,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_9_sr_req(0),
          mack => memory_space_9_sr_ack(0),
          maddr => memory_space_9_sr_addr(0 downto 0),
          mdata => memory_space_9_sr_data(63 downto 0),
          mtag => memory_space_9_sr_tag(0 downto 0),
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
          mreq => memory_space_9_sc_req(0),
          mack => memory_space_9_sc_ack(0),
          mtag => memory_space_9_sc_tag(0 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 2
    -- shared store operator group (3) : ptr_deref_63_store_0 ptr_deref_220_store_0 
    StoreGroup3: Block -- 
      signal addr_in: std_logic_vector(1 downto 0);
      signal data_in: std_logic_vector(127 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 1 downto 0);
      -- 
    begin -- 
      reqL(1) <= ptr_deref_63_store_0_req_0;
      reqL(0) <= ptr_deref_220_store_0_req_0;
      ptr_deref_63_store_0_ack_0 <= ackL(1);
      ptr_deref_220_store_0_ack_0 <= ackL(0);
      reqR(1) <= ptr_deref_63_store_0_req_1;
      reqR(0) <= ptr_deref_220_store_0_req_1;
      ptr_deref_63_store_0_ack_1 <= ackR(1);
      ptr_deref_220_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_63_word_address_0 & ptr_deref_220_word_address_0;
      data_in <= ptr_deref_63_data_0 & ptr_deref_220_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 64,
        num_reqs => 2,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_6_sr_req(0),
          mack => memory_space_6_sr_ack(0),
          maddr => memory_space_6_sr_addr(0 downto 0),
          mdata => memory_space_6_sr_data(63 downto 0),
          mtag => memory_space_6_sr_tag(1 downto 0),
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
          mreq => memory_space_6_sc_req(0),
          mack => memory_space_6_sc_ack(0),
          mtag => memory_space_6_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 3
    -- shared store operator group (4) : ptr_deref_224_store_0 ptr_deref_46_store_0 ptr_deref_254_store_0 
    StoreGroup4: Block -- 
      signal addr_in: std_logic_vector(2 downto 0);
      signal data_in: std_logic_vector(23 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 2 downto 0);
      -- 
    begin -- 
      reqL(2) <= ptr_deref_224_store_0_req_0;
      reqL(1) <= ptr_deref_46_store_0_req_0;
      reqL(0) <= ptr_deref_254_store_0_req_0;
      ptr_deref_224_store_0_ack_0 <= ackL(2);
      ptr_deref_46_store_0_ack_0 <= ackL(1);
      ptr_deref_254_store_0_ack_0 <= ackL(0);
      reqR(2) <= ptr_deref_224_store_0_req_1;
      reqR(1) <= ptr_deref_46_store_0_req_1;
      reqR(0) <= ptr_deref_254_store_0_req_1;
      ptr_deref_224_store_0_ack_1 <= ackR(2);
      ptr_deref_46_store_0_ack_1 <= ackR(1);
      ptr_deref_254_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_224_word_address_0 & ptr_deref_46_word_address_0 & ptr_deref_254_word_address_0;
      data_in <= ptr_deref_224_data_0 & ptr_deref_46_data_0 & ptr_deref_254_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 8,
        num_reqs => 3,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_4_sr_req(0),
          mack => memory_space_4_sr_ack(0),
          maddr => memory_space_4_sr_addr(0 downto 0),
          mdata => memory_space_4_sr_data(7 downto 0),
          mtag => memory_space_4_sr_tag(1 downto 0),
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
          mreq => memory_space_4_sc_req(0),
          mack => memory_space_4_sc_ack(0),
          mtag => memory_space_4_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 4
    -- shared store operator group (5) : ptr_deref_56_store_0 
    StoreGroup5: Block -- 
      signal addr_in: std_logic_vector(0 downto 0);
      signal data_in: std_logic_vector(7 downto 0);
      signal reqR, ackR, reqL, ackL : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      reqL(0) <= ptr_deref_56_store_0_req_0;
      ptr_deref_56_store_0_ack_0 <= ackL(0);
      reqR(0) <= ptr_deref_56_store_0_req_1;
      ptr_deref_56_store_0_ack_1 <= ackR(0);
      addr_in <= ptr_deref_56_word_address_0;
      data_in <= ptr_deref_56_data_0;
      StoreReq: StoreReqShared -- 
        generic map ( addr_width => 1,
        data_width => 8,
        num_reqs => 1,
        tag_length => 2,
        no_arbitration => true)
        port map (--
          reqL => reqL , 
          ackL => ackL , 
          addr => addr_in, 
          data => data_in, 
          mreq => memory_space_5_sr_req(0),
          mack => memory_space_5_sr_ack(0),
          maddr => memory_space_5_sr_addr(0 downto 0),
          mdata => memory_space_5_sr_data(7 downto 0),
          mtag => memory_space_5_sr_tag(1 downto 0),
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
          mreq => memory_space_5_sc_req(0),
          mack => memory_space_5_sc_ack(0),
          mtag => memory_space_5_sc_tag(1 downto 0),
          clk => clk, reset => reset -- 
        ); -- 
      -- 
    end Block; -- store group 5
    -- shared inport operator group (0) : simple_obj_ref_53_inst 
    InportGroup0: Block -- 
      signal data_out: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_53_inst_req_0;
      simple_obj_ref_53_inst_ack_0 <= ack(0);
      iNsTr_3_54 <= data_out(7 downto 0);
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
    -- shared inport operator group (1) : simple_obj_ref_60_inst 
    InportGroup1: Block -- 
      signal data_out: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_60_inst_req_0;
      simple_obj_ref_60_inst_ack_0 <= ack(0);
      iNsTr_6_61 <= data_out(63 downto 0);
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
    end Block; -- inport group 1
    -- shared outport operator group (0) : simple_obj_ref_264_inst 
    OutportGroup0: Block -- 
      signal data_in: std_logic_vector(7 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_264_inst_req_0;
      simple_obj_ref_264_inst_ack_0 <= ack(0);
      data_in <= iNsTr_46_263;
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
    -- shared outport operator group (1) : simple_obj_ref_271_inst 
    OutportGroup1: Block -- 
      signal data_in: std_logic_vector(63 downto 0);
      signal req, ack : BooleanArray( 0 downto 0);
      -- 
    begin -- 
      req(0) <= simple_obj_ref_271_inst_req_0;
      simple_obj_ref_271_inst_ack_0 <= ack(0);
      data_in <= iNsTr_49_270;
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
    end Block; -- outport group 1
    -- 
  end Block; -- data_path
  RegisterBank_memory_space_4: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 8,
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
      data_width => 8,
      tag_width => 2,
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
      num_loads => 3,
      num_stores => 1,
      addr_width => 1,
      data_width => 64,
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
      data_width => 64,
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
  RegisterBank_memory_space_8: register_bank -- 
    generic map(-- 
      num_loads => 1,
      num_stores => 1,
      addr_width => 1,
      data_width => 16,
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
      data_width => 64,
      tag_width => 1,
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
  -- declarations related to module output_port_lookup
  component output_port_lookup is -- 
    port ( -- 
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      fin   : out std_logic;
      in_ctrl_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_ctrl_pipe_read_data : in   std_logic_vector(7 downto 0);
      in_data_pipe_read_req : out  std_logic_vector(0 downto 0);
      in_data_pipe_read_ack : in   std_logic_vector(0 downto 0);
      in_data_pipe_read_data : in   std_logic_vector(63 downto 0);
      out_ctrl_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_ctrl_pipe_write_data : out  std_logic_vector(7 downto 0);
      out_data_pipe_write_req : out  std_logic_vector(0 downto 0);
      out_data_pipe_write_ack : in   std_logic_vector(0 downto 0);
      out_data_pipe_write_data : out  std_logic_vector(63 downto 0);
      tag_in: in std_logic_vector(0 downto 0);
      tag_out: out std_logic_vector(0 downto 0)-- 
    );
    -- 
  end component;
  -- argument signals for module output_port_lookup
  signal output_port_lookup_tag_in    : std_logic_vector(0 downto 0);
  signal output_port_lookup_tag_out   : std_logic_vector(0 downto 0);
  signal output_port_lookup_start : std_logic;
  signal output_port_lookup_fin   : std_logic;
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
  -- module output_port_lookup
  output_port_lookup_instance:output_port_lookup-- 
    port map(-- 
      start => output_port_lookup_start,
      fin => output_port_lookup_fin,
      clk => clk,
      reset => reset,
      in_ctrl_pipe_read_req => in_ctrl_pipe_read_req(0 downto 0),
      in_ctrl_pipe_read_ack => in_ctrl_pipe_read_ack(0 downto 0),
      in_ctrl_pipe_read_data => in_ctrl_pipe_read_data(7 downto 0),
      in_data_pipe_read_req => in_data_pipe_read_req(0 downto 0),
      in_data_pipe_read_ack => in_data_pipe_read_ack(0 downto 0),
      in_data_pipe_read_data => in_data_pipe_read_data(63 downto 0),
      out_ctrl_pipe_write_req => out_ctrl_pipe_write_req(0 downto 0),
      out_ctrl_pipe_write_ack => out_ctrl_pipe_write_ack(0 downto 0),
      out_ctrl_pipe_write_data => out_ctrl_pipe_write_data(7 downto 0),
      out_data_pipe_write_req => out_data_pipe_write_req(0 downto 0),
      out_data_pipe_write_ack => out_data_pipe_write_ack(0 downto 0),
      out_data_pipe_write_data => out_data_pipe_write_data(63 downto 0),
      tag_in => output_port_lookup_tag_in,
      tag_out => output_port_lookup_tag_out-- 
    ); -- 
  -- module will be run forever 
  output_port_lookup_tag_in <= (others => '0');
  output_port_lookup_auto_run: auto_run generic map(use_delay => true)  port map(clk => clk, reset => reset, start => output_port_lookup_start, fin => output_port_lookup_fin);
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
